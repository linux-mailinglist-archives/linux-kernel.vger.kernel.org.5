Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68648809DBB
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 08:57:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573425AbjLHH5d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 02:57:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235819AbjLHH5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 02:57:23 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 305A41732
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 23:56:50 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1F4BC433C8;
        Fri,  8 Dec 2023 07:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1702022209;
        bh=o2UUrCoVcp9dZ4AGqtFIB2M8Nl9dlDoJXot+6mCPrZ8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FrhciUbi6O+Wd68OLSjrVQGicpAGhEiyodWGbIiNxxLUBJjNXwr9FNFnaSa3j1Zmz
         Xfq2pO62lJtdc062uF7SfZSl++lLOErc7DLWXqEWaz46pt1lDZkVbgX5s6D9q4VBCs
         C8FE0YpZFZwPc0SCsP//rZ/bBSldNnThsdI/O7gk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 5.10.203
Date:   Fri,  8 Dec 2023 08:56:43 +0100
Message-ID: <2023120843-carnation-excusably-ab58@gregkh>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2023120843-vista-ardently-bcc7@gregkh>
References: <2023120843-vista-ardently-bcc7@gregkh>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

diff --git a/Documentation/ABI/testing/sysfs-bus-usb b/Documentation/ABI/testing/sysfs-bus-usb
index bf2c1968525f..73eb23bc1f34 100644
--- a/Documentation/ABI/testing/sysfs-bus-usb
+++ b/Documentation/ABI/testing/sysfs-bus-usb
@@ -154,17 +154,6 @@ Description:
 		files hold a string value (enable or disable) indicating whether
 		or not USB3 hardware LPM U1 or U2 is enabled for the device.
 
-What:		/sys/bus/usb/devices/.../removable
-Date:		February 2012
-Contact:	Matthew Garrett <mjg@redhat.com>
-Description:
-		Some information about whether a given USB device is
-		physically fixed to the platform can be inferred from a
-		combination of hub descriptor bits and platform-specific data
-		such as ACPI. This file will read either "removable" or
-		"fixed" if the information is available, and "unknown"
-		otherwise.
-
 What:		/sys/bus/usb/devices/.../ltm_capable
 Date:		July 2012
 Contact:	Sarah Sharp <sarah.a.sharp@linux.intel.com>
diff --git a/Documentation/ABI/testing/sysfs-devices-removable b/Documentation/ABI/testing/sysfs-devices-removable
new file mode 100644
index 000000000000..acf7766e800b
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-devices-removable
@@ -0,0 +1,17 @@
+What:		/sys/devices/.../removable
+Date:		May 2021
+Contact:	Rajat Jain <rajatxjain@gmail.com>
+Description:
+		Information about whether a given device can be removed from the
+		platform by the	user. This is determined by its subsystem in a
+		bus / platform-specific way. This attribute is only present for
+		devices that can support determining such information:
+
+		"removable": device can be removed from the platform by the user
+		"fixed":     device is fixed to the platform / cannot be removed
+			     by the user.
+		"unknown":   The information is unavailable / cannot be deduced.
+
+		Currently this is only supported by USB (which infers the
+		information from a combination of hub descriptor bits and
+		platform-specific data such as ACPI).
diff --git a/Makefile b/Makefile
index ed0e42c99c90..4cbeb198196b 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 5
 PATCHLEVEL = 10
-SUBLEVEL = 202
+SUBLEVEL = 203
 EXTRAVERSION =
 NAME = Dare mighty things
 
diff --git a/arch/arm/xen/enlighten.c b/arch/arm/xen/enlighten.c
index 3d25fd615250..518c7557f78a 100644
--- a/arch/arm/xen/enlighten.c
+++ b/arch/arm/xen/enlighten.c
@@ -351,7 +351,8 @@ static int __init xen_guest_init(void)
 	 * for secondary CPUs as they are brought up.
 	 * For uniformity we use VCPUOP_register_vcpu_info even on cpu0.
 	 */
-	xen_vcpu_info = alloc_percpu(struct vcpu_info);
+	xen_vcpu_info = __alloc_percpu(sizeof(struct vcpu_info),
+				       1 << fls(sizeof(struct vcpu_info) - 1));
 	if (xen_vcpu_info == NULL)
 		return -ENOMEM;
 
diff --git a/arch/mips/kvm/mmu.c b/arch/mips/kvm/mmu.c
index 28c366d307e7..38a5be10a3db 100644
--- a/arch/mips/kvm/mmu.c
+++ b/arch/mips/kvm/mmu.c
@@ -667,7 +667,7 @@ static int kvm_mips_map_page(struct kvm_vcpu *vcpu, unsigned long gpa,
 	gfn_t gfn = gpa >> PAGE_SHIFT;
 	int srcu_idx, err;
 	kvm_pfn_t pfn;
-	pte_t *ptep, entry, old_pte;
+	pte_t *ptep, entry;
 	bool writeable;
 	unsigned long prot_bits;
 	unsigned long mmu_seq;
@@ -739,7 +739,6 @@ static int kvm_mips_map_page(struct kvm_vcpu *vcpu, unsigned long gpa,
 	entry = pfn_pte(pfn, __pgprot(prot_bits));
 
 	/* Write the PTE */
-	old_pte = *ptep;
 	set_pte(ptep, entry);
 
 	err = 0;
diff --git a/arch/parisc/include/uapi/asm/errno.h b/arch/parisc/include/uapi/asm/errno.h
index 87245c584784..8d94739d75c6 100644
--- a/arch/parisc/include/uapi/asm/errno.h
+++ b/arch/parisc/include/uapi/asm/errno.h
@@ -75,7 +75,6 @@
 
 /* We now return you to your regularly scheduled HPUX. */
 
-#define ENOSYM		215	/* symbol does not exist in executable */
 #define	ENOTSOCK	216	/* Socket operation on non-socket */
 #define	EDESTADDRREQ	217	/* Destination address required */
 #define	EMSGSIZE	218	/* Message too long */
@@ -101,7 +100,6 @@
 #define	ETIMEDOUT	238	/* Connection timed out */
 #define	ECONNREFUSED	239	/* Connection refused */
 #define	EREFUSED	ECONNREFUSED	/* for HP's NFS apparently */
-#define	EREMOTERELEASE	240	/* Remote peer released connection */
 #define	EHOSTDOWN	241	/* Host is down */
 #define	EHOSTUNREACH	242	/* No route to host */
 
diff --git a/arch/powerpc/kernel/fpu.S b/arch/powerpc/kernel/fpu.S
index 3ff9a8fafa46..a56597c88e94 100644
--- a/arch/powerpc/kernel/fpu.S
+++ b/arch/powerpc/kernel/fpu.S
@@ -23,6 +23,15 @@
 #include <asm/feature-fixups.h>
 
 #ifdef CONFIG_VSX
+#define __REST_1FPVSR(n,c,base)						\
+BEGIN_FTR_SECTION							\
+	b	2f;							\
+END_FTR_SECTION_IFSET(CPU_FTR_VSX);					\
+	REST_FPR(n,base);						\
+	b	3f;							\
+2:	REST_VSR(n,c,base);						\
+3:
+
 #define __REST_32FPVSRS(n,c,base)					\
 BEGIN_FTR_SECTION							\
 	b	2f;							\
@@ -41,9 +50,11 @@ END_FTR_SECTION_IFSET(CPU_FTR_VSX);					\
 2:	SAVE_32VSRS(n,c,base);						\
 3:
 #else
+#define __REST_1FPVSR(n,b,base)		REST_FPR(n, base)
 #define __REST_32FPVSRS(n,b,base)	REST_32FPRS(n, base)
 #define __SAVE_32FPVSRS(n,b,base)	SAVE_32FPRS(n, base)
 #endif
+#define REST_1FPVSR(n,c,base)   __REST_1FPVSR(n,__REG_##c,__REG_##base)
 #define REST_32FPVSRS(n,c,base) __REST_32FPVSRS(n,__REG_##c,__REG_##base)
 #define SAVE_32FPVSRS(n,c,base) __SAVE_32FPVSRS(n,__REG_##c,__REG_##base)
 
@@ -67,6 +78,7 @@ _GLOBAL(store_fp_state)
 	SAVE_32FPVSRS(0, R4, R3)
 	mffs	fr0
 	stfd	fr0,FPSTATE_FPSCR(r3)
+	REST_1FPVSR(0, R4, R3)
 	blr
 EXPORT_SYMBOL(store_fp_state)
 
@@ -132,4 +144,5 @@ _GLOBAL(save_fpu)
 2:	SAVE_32FPVSRS(0, R4, R6)
 	mffs	fr0
 	stfd	fr0,FPSTATE_FPSCR(r6)
+	REST_1FPVSR(0, R4, R6)
 	blr
diff --git a/arch/powerpc/kernel/vector.S b/arch/powerpc/kernel/vector.S
index 801dc28fdcca..6bd47d4242d0 100644
--- a/arch/powerpc/kernel/vector.S
+++ b/arch/powerpc/kernel/vector.S
@@ -32,6 +32,7 @@ _GLOBAL(store_vr_state)
 	mfvscr	v0
 	li	r4, VRSTATE_VSCR
 	stvx	v0, r4, r3
+	lvx	v0, 0, r3
 	blr
 EXPORT_SYMBOL(store_vr_state)
 
@@ -104,6 +105,7 @@ _GLOBAL(save_altivec)
 	mfvscr	v0
 	li	r4,VRSTATE_VSCR
 	stvx	v0,r4,r7
+	lvx	v0,0,r7
 	blr
 
 #ifdef CONFIG_VSX
diff --git a/arch/s390/mm/page-states.c b/arch/s390/mm/page-states.c
index 567c69f3069e..4e5312fa2c53 100644
--- a/arch/s390/mm/page-states.c
+++ b/arch/s390/mm/page-states.c
@@ -112,7 +112,7 @@ static void mark_kernel_pmd(pud_t *pud, unsigned long addr, unsigned long end)
 		next = pmd_addr_end(addr, end);
 		if (pmd_none(*pmd) || pmd_large(*pmd))
 			continue;
-		page = virt_to_page(pmd_val(*pmd));
+		page = phys_to_page(pmd_val(*pmd));
 		set_bit(PG_arch_1, &page->flags);
 	} while (pmd++, addr = next, addr != end);
 }
@@ -130,8 +130,8 @@ static void mark_kernel_pud(p4d_t *p4d, unsigned long addr, unsigned long end)
 		if (pud_none(*pud) || pud_large(*pud))
 			continue;
 		if (!pud_folded(*pud)) {
-			page = virt_to_page(pud_val(*pud));
-			for (i = 0; i < 3; i++)
+			page = phys_to_page(pud_val(*pud));
+			for (i = 0; i < 4; i++)
 				set_bit(PG_arch_1, &page[i].flags);
 		}
 		mark_kernel_pmd(pud, addr, next);
@@ -151,8 +151,8 @@ static void mark_kernel_p4d(pgd_t *pgd, unsigned long addr, unsigned long end)
 		if (p4d_none(*p4d))
 			continue;
 		if (!p4d_folded(*p4d)) {
-			page = virt_to_page(p4d_val(*p4d));
-			for (i = 0; i < 3; i++)
+			page = phys_to_page(p4d_val(*p4d));
+			for (i = 0; i < 4; i++)
 				set_bit(PG_arch_1, &page[i].flags);
 		}
 		mark_kernel_pud(p4d, addr, next);
@@ -173,8 +173,8 @@ static void mark_kernel_pgd(void)
 		if (pgd_none(*pgd))
 			continue;
 		if (!pgd_folded(*pgd)) {
-			page = virt_to_page(pgd_val(*pgd));
-			for (i = 0; i < 3; i++)
+			page = phys_to_page(pgd_val(*pgd));
+			for (i = 0; i < 4; i++)
 				set_bit(PG_arch_1, &page[i].flags);
 		}
 		mark_kernel_p4d(pgd, addr, next);
diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
index ba70bcded128..508d22728ce8 100644
--- a/drivers/acpi/resource.c
+++ b/drivers/acpi/resource.c
@@ -448,6 +448,13 @@ static const struct dmi_system_id asus_laptop[] = {
 			DMI_MATCH(DMI_BOARD_NAME, "GMxXGxx"),
 		},
 	},
+	{
+		/* Asus ExpertBook B1402CVA */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
+			DMI_MATCH(DMI_BOARD_NAME, "B1402CVA"),
+		},
+	},
 	{
 		/* TongFang GM6XGxX/TUXEDO Stellaris 16 Gen5 AMD */
 		.matches = {
diff --git a/drivers/ata/pata_isapnp.c b/drivers/ata/pata_isapnp.c
index 43bb224430d3..8892931ea867 100644
--- a/drivers/ata/pata_isapnp.c
+++ b/drivers/ata/pata_isapnp.c
@@ -82,6 +82,9 @@ static int isapnp_init_one(struct pnp_dev *idev, const struct pnp_device_id *dev
 	if (pnp_port_valid(idev, 1)) {
 		ctl_addr = devm_ioport_map(&idev->dev,
 					   pnp_port_start(idev, 1), 1);
+		if (!ctl_addr)
+			return -ENOMEM;
+
 		ap->ioaddr.altstatus_addr = ctl_addr;
 		ap->ioaddr.ctl_addr = ctl_addr;
 		ap->ops = &isapnp_port_ops;
diff --git a/drivers/base/core.c b/drivers/base/core.c
index cb859febd03c..d98cab88c38a 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -2053,6 +2053,25 @@ static ssize_t online_store(struct device *dev, struct device_attribute *attr,
 }
 static DEVICE_ATTR_RW(online);
 
+static ssize_t removable_show(struct device *dev, struct device_attribute *attr,
+			      char *buf)
+{
+	const char *loc;
+
+	switch (dev->removable) {
+	case DEVICE_REMOVABLE:
+		loc = "removable";
+		break;
+	case DEVICE_FIXED:
+		loc = "fixed";
+		break;
+	default:
+		loc = "unknown";
+	}
+	return sysfs_emit(buf, "%s\n", loc);
+}
+static DEVICE_ATTR_RO(removable);
+
 int device_add_groups(struct device *dev, const struct attribute_group **groups)
 {
 	return sysfs_create_groups(&dev->kobj, groups);
@@ -2230,8 +2249,16 @@ static int device_add_attrs(struct device *dev)
 			goto err_remove_dev_online;
 	}
 
+	if (dev_removable_is_valid(dev)) {
+		error = device_create_file(dev, &dev_attr_removable);
+		if (error)
+			goto err_remove_dev_waiting_for_supplier;
+	}
+
 	return 0;
 
+ err_remove_dev_waiting_for_supplier:
+	device_remove_file(dev, &dev_attr_waiting_for_supplier);
  err_remove_dev_online:
 	device_remove_file(dev, &dev_attr_online);
  err_remove_dev_groups:
@@ -2251,6 +2278,7 @@ static void device_remove_attrs(struct device *dev)
 	struct class *class = dev->class;
 	const struct device_type *type = dev->type;
 
+	device_remove_file(dev, &dev_attr_removable);
 	device_remove_file(dev, &dev_attr_waiting_for_supplier);
 	device_remove_file(dev, &dev_attr_online);
 	device_remove_groups(dev, dev->groups);
diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 503c01d4015d..1e8318acf621 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -1187,8 +1187,6 @@ static void __device_release_driver(struct device *dev, struct device *parent)
 		else if (drv->remove)
 			drv->remove(dev);
 
-		device_links_driver_cleanup(dev);
-
 		devres_release_all(dev);
 		arch_teardown_dma_ops(dev);
 		kfree(dev->dma_range_map);
@@ -1200,6 +1198,8 @@ static void __device_release_driver(struct device *dev, struct device *parent)
 		pm_runtime_reinit(dev);
 		dev_pm_set_driver_flags(dev, 0);
 
+		device_links_driver_cleanup(dev);
+
 		klist_remove(&dev->p->knode_driver);
 		device_pm_check_callbacks(dev);
 		if (dev->bus)
diff --git a/drivers/cpufreq/imx6q-cpufreq.c b/drivers/cpufreq/imx6q-cpufreq.c
index 5bf5fc759881..00f7ad746668 100644
--- a/drivers/cpufreq/imx6q-cpufreq.c
+++ b/drivers/cpufreq/imx6q-cpufreq.c
@@ -209,6 +209,14 @@ static struct cpufreq_driver imx6q_cpufreq_driver = {
 	.suspend = cpufreq_generic_suspend,
 };
 
+static void imx6x_disable_freq_in_opp(struct device *dev, unsigned long freq)
+{
+	int ret = dev_pm_opp_disable(dev, freq);
+
+	if (ret < 0 && ret != -ENODEV)
+		dev_warn(dev, "failed to disable %ldMHz OPP\n", freq / 1000000);
+}
+
 #define OCOTP_CFG3			0x440
 #define OCOTP_CFG3_SPEED_SHIFT		16
 #define OCOTP_CFG3_SPEED_1P2GHZ		0x3
@@ -254,17 +262,15 @@ static int imx6q_opp_check_speed_grading(struct device *dev)
 	val &= 0x3;
 
 	if (val < OCOTP_CFG3_SPEED_996MHZ)
-		if (dev_pm_opp_disable(dev, 996000000))
-			dev_warn(dev, "failed to disable 996MHz OPP\n");
+		imx6x_disable_freq_in_opp(dev, 996000000);
 
 	if (of_machine_is_compatible("fsl,imx6q") ||
 	    of_machine_is_compatible("fsl,imx6qp")) {
 		if (val != OCOTP_CFG3_SPEED_852MHZ)
-			if (dev_pm_opp_disable(dev, 852000000))
-				dev_warn(dev, "failed to disable 852MHz OPP\n");
+			imx6x_disable_freq_in_opp(dev, 852000000);
+
 		if (val != OCOTP_CFG3_SPEED_1P2GHZ)
-			if (dev_pm_opp_disable(dev, 1200000000))
-				dev_warn(dev, "failed to disable 1.2GHz OPP\n");
+			imx6x_disable_freq_in_opp(dev, 1200000000);
 	}
 
 	return 0;
@@ -316,20 +322,16 @@ static int imx6ul_opp_check_speed_grading(struct device *dev)
 	val >>= OCOTP_CFG3_SPEED_SHIFT;
 	val &= 0x3;
 
-	if (of_machine_is_compatible("fsl,imx6ul")) {
+	if (of_machine_is_compatible("fsl,imx6ul"))
 		if (val != OCOTP_CFG3_6UL_SPEED_696MHZ)
-			if (dev_pm_opp_disable(dev, 696000000))
-				dev_warn(dev, "failed to disable 696MHz OPP\n");
-	}
+			imx6x_disable_freq_in_opp(dev, 696000000);
 
 	if (of_machine_is_compatible("fsl,imx6ull")) {
-		if (val != OCOTP_CFG3_6ULL_SPEED_792MHZ)
-			if (dev_pm_opp_disable(dev, 792000000))
-				dev_warn(dev, "failed to disable 792MHz OPP\n");
+		if (val < OCOTP_CFG3_6ULL_SPEED_792MHZ)
+			imx6x_disable_freq_in_opp(dev, 792000000);
 
 		if (val != OCOTP_CFG3_6ULL_SPEED_900MHZ)
-			if (dev_pm_opp_disable(dev, 900000000))
-				dev_warn(dev, "failed to disable 900MHz OPP\n");
+			imx6x_disable_freq_in_opp(dev, 900000000);
 	}
 
 	return ret;
diff --git a/drivers/firewire/core-device.c b/drivers/firewire/core-device.c
index 80db43a22069..94ae27865b9e 100644
--- a/drivers/firewire/core-device.c
+++ b/drivers/firewire/core-device.c
@@ -719,14 +719,11 @@ static void create_units(struct fw_device *device)
 					fw_unit_attributes,
 					&unit->attribute_group);
 
-		if (device_register(&unit->device) < 0)
-			goto skip_unit;
-
 		fw_device_get(device);
-		continue;
-
-	skip_unit:
-		kfree(unit);
+		if (device_register(&unit->device) < 0) {
+			put_device(&unit->device);
+			continue;
+		}
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
index 4b568ee93243..02a73b9e08d7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bios.c
@@ -29,6 +29,7 @@
 #include "amdgpu.h"
 #include "atom.h"
 
+#include <linux/device.h>
 #include <linux/pci.h>
 #include <linux/slab.h>
 #include <linux/acpi.h>
@@ -285,6 +286,10 @@ static bool amdgpu_atrm_get_bios(struct amdgpu_device *adev)
 	if (adev->flags & AMD_IS_APU)
 		return false;
 
+	/* ATRM is for on-platform devices only */
+	if (dev_is_removable(&adev->pdev->dev))
+		return false;
+
 	while ((pdev = pci_get_class(PCI_CLASS_DISPLAY_VGA << 8, pdev)) != NULL) {
 		dhandle = ACPI_HANDLE(&pdev->dev);
 		if (!dhandle)
diff --git a/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c b/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
index db9d0b86d542..9e518213a54f 100644
--- a/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
+++ b/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
@@ -36,6 +36,7 @@ struct panel_desc {
 	const struct panel_init_cmd *init_cmds;
 	unsigned int lanes;
 	bool discharge_on_disable;
+	bool lp11_before_reset;
 };
 
 struct boe_panel {
@@ -551,6 +552,10 @@ static int boe_panel_prepare(struct drm_panel *panel)
 
 	usleep_range(5000, 10000);
 
+	if (boe->desc->lp11_before_reset) {
+		mipi_dsi_dcs_nop(boe->dsi);
+		usleep_range(1000, 2000);
+	}
 	gpiod_set_value(boe->enable_gpio, 1);
 	usleep_range(1000, 2000);
 	gpiod_set_value(boe->enable_gpio, 0);
@@ -692,6 +697,7 @@ static const struct panel_desc auo_b101uan08_3_desc = {
 	.mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_SYNC_PULSE |
 		      MIPI_DSI_MODE_LPM,
 	.init_cmds = auo_b101uan08_3_init_cmd,
+	.lp11_before_reset = true,
 };
 
 static const struct drm_display_mode boe_tv105wum_nw0_default_mode = {
@@ -719,6 +725,7 @@ static const struct panel_desc boe_tv105wum_nw0_desc = {
 	.mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_SYNC_PULSE |
 		      MIPI_DSI_MODE_LPM,
 	.init_cmds = boe_init_cmd,
+	.lp11_before_reset = true,
 };
 
 static int boe_panel_get_modes(struct drm_panel *panel,
diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index e90b51811888..ee01b61a6baf 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -2154,13 +2154,13 @@ static const struct panel_desc innolux_g070y2_l01 = {
 static const struct display_timing innolux_g101ice_l01_timing = {
 	.pixelclock = { 60400000, 71100000, 74700000 },
 	.hactive = { 1280, 1280, 1280 },
-	.hfront_porch = { 41, 80, 100 },
-	.hback_porch = { 40, 79, 99 },
-	.hsync_len = { 1, 1, 1 },
+	.hfront_porch = { 30, 60, 70 },
+	.hback_porch = { 30, 60, 70 },
+	.hsync_len = { 22, 40, 60 },
 	.vactive = { 800, 800, 800 },
-	.vfront_porch = { 5, 11, 14 },
-	.vback_porch = { 4, 11, 14 },
-	.vsync_len = { 1, 1, 1 },
+	.vfront_porch = { 3, 8, 14 },
+	.vback_porch = { 3, 8, 14 },
+	.vsync_len = { 4, 7, 12 },
 	.flags = DISPLAY_FLAGS_DE_HIGH,
 };
 
@@ -2177,6 +2177,7 @@ static const struct panel_desc innolux_g101ice_l01 = {
 		.disable = 200,
 	},
 	.bus_format = MEDIA_BUS_FMT_RGB888_1X7X4_SPWG,
+	.bus_flags = DRM_BUS_FLAG_DE_HIGH,
 	.connector_type = DRM_MODE_CONNECTOR_LVDS,
 };
 
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
index 05fcc9e078d6..682d78fab9a5 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
@@ -248,14 +248,22 @@ static inline void vop_cfg_done(struct vop *vop)
 	VOP_REG_SET(vop, common, cfg_done, 1);
 }
 
-static bool has_rb_swapped(uint32_t format)
+static bool has_rb_swapped(uint32_t version, uint32_t format)
 {
 	switch (format) {
 	case DRM_FORMAT_XBGR8888:
 	case DRM_FORMAT_ABGR8888:
-	case DRM_FORMAT_BGR888:
 	case DRM_FORMAT_BGR565:
 		return true;
+	/*
+	 * full framework (IP version 3.x) only need rb swapped for RGB888 and
+	 * little framework (IP version 2.x) only need rb swapped for BGR888,
+	 * check for 3.x to also only rb swap BGR888 for unknown vop version
+	 */
+	case DRM_FORMAT_RGB888:
+		return VOP_MAJOR(version) == 3;
+	case DRM_FORMAT_BGR888:
+		return VOP_MAJOR(version) != 3;
 	default:
 		return false;
 	}
@@ -988,7 +996,7 @@ static void vop_plane_atomic_update(struct drm_plane *plane,
 	VOP_WIN_SET(vop, win, dsp_info, dsp_info);
 	VOP_WIN_SET(vop, win, dsp_st, dsp_st);
 
-	rb_swap = has_rb_swapped(fb->format->format);
+	rb_swap = has_rb_swapped(vop->data->version, fb->format->format);
 	VOP_WIN_SET(vop, win, rb_swap, rb_swap);
 
 	/*
diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 524d6d712e72..476967ab6294 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -702,15 +702,22 @@ static void hid_close_report(struct hid_device *device)
  * Free a device structure, all reports, and all fields.
  */
 
-static void hid_device_release(struct device *dev)
+void hiddev_free(struct kref *ref)
 {
-	struct hid_device *hid = to_hid_device(dev);
+	struct hid_device *hid = container_of(ref, struct hid_device, ref);
 
 	hid_close_report(hid);
 	kfree(hid->dev_rdesc);
 	kfree(hid);
 }
 
+static void hid_device_release(struct device *dev)
+{
+	struct hid_device *hid = to_hid_device(dev);
+
+	kref_put(&hid->ref, hiddev_free);
+}
+
 /*
  * Fetch a report description item from the data stream. We support long
  * items, though they are not used yet.
@@ -2444,10 +2451,12 @@ int hid_add_device(struct hid_device *hdev)
 			hid_warn(hdev, "bad device descriptor (%d)\n", ret);
 	}
 
+	hdev->id = atomic_inc_return(&id);
+
 	/* XXX hack, any other cleaner solution after the driver core
 	 * is converted to allow more than 20 bytes as the device name? */
 	dev_set_name(&hdev->dev, "%04X:%04X:%04X.%04X", hdev->bus,
-		     hdev->vendor, hdev->product, atomic_inc_return(&id));
+		     hdev->vendor, hdev->product, hdev->id);
 
 	hid_debug_register(hdev, dev_name(&hdev->dev));
 	ret = device_add(&hdev->dev);
@@ -2490,6 +2499,7 @@ struct hid_device *hid_allocate_device(void)
 	spin_lock_init(&hdev->debug_list_lock);
 	sema_init(&hdev->driver_input_lock, 1);
 	mutex_init(&hdev->ll_open_lock);
+	kref_init(&hdev->ref);
 
 	return hdev;
 }
diff --git a/drivers/hid/hid-debug.c b/drivers/hid/hid-debug.c
index 1f60a381ae63..81da80f0c75b 100644
--- a/drivers/hid/hid-debug.c
+++ b/drivers/hid/hid-debug.c
@@ -1082,6 +1082,7 @@ static int hid_debug_events_open(struct inode *inode, struct file *file)
 		goto out;
 	}
 	list->hdev = (struct hid_device *) inode->i_private;
+	kref_get(&list->hdev->ref);
 	file->private_data = list;
 	mutex_init(&list->read_mutex);
 
@@ -1174,6 +1175,8 @@ static int hid_debug_events_release(struct inode *inode, struct file *file)
 	list_del(&list->node);
 	spin_unlock_irqrestore(&list->hdev->debug_list_lock, flags);
 	kfifo_free(&list->hid_debug_fifo);
+
+	kref_put(&list->hdev->ref, hiddev_free);
 	kfree(list);
 
 	return 0;
diff --git a/drivers/infiniband/hw/i40iw/i40iw_ctrl.c b/drivers/infiniband/hw/i40iw/i40iw_ctrl.c
index 86d3f8aff329..2b18bb36e4e3 100644
--- a/drivers/infiniband/hw/i40iw/i40iw_ctrl.c
+++ b/drivers/infiniband/hw/i40iw/i40iw_ctrl.c
@@ -3033,6 +3033,9 @@ static enum i40iw_status_code i40iw_sc_alloc_stag(
 	u64 header;
 	enum i40iw_page_size page_size;
 
+	if (!info->total_len && !info->all_memory)
+		return -EINVAL;
+
 	page_size = (info->page_size == 0x200000) ? I40IW_PAGE_SIZE_2M : I40IW_PAGE_SIZE_4K;
 	cqp = dev->cqp;
 	wqe = i40iw_sc_cqp_get_next_send_wqe(cqp, scratch);
@@ -3091,6 +3094,9 @@ static enum i40iw_status_code i40iw_sc_mr_reg_non_shared(
 	u8 addr_type;
 	enum i40iw_page_size page_size;
 
+	if (!info->total_len && !info->all_memory)
+		return -EINVAL;
+
 	page_size = (info->page_size == 0x200000) ? I40IW_PAGE_SIZE_2M : I40IW_PAGE_SIZE_4K;
 	if (info->access_rights & (I40IW_ACCESS_FLAGS_REMOTEREAD_ONLY |
 				   I40IW_ACCESS_FLAGS_REMOTEWRITE_ONLY))
diff --git a/drivers/infiniband/hw/i40iw/i40iw_type.h b/drivers/infiniband/hw/i40iw/i40iw_type.h
index c3babf3cbb8e..341aa6b1b6c1 100644
--- a/drivers/infiniband/hw/i40iw/i40iw_type.h
+++ b/drivers/infiniband/hw/i40iw/i40iw_type.h
@@ -786,6 +786,7 @@ struct i40iw_allocate_stag_info {
 	bool use_hmc_fcn_index;
 	u8 hmc_fcn_index;
 	bool use_pf_rid;
+	bool all_memory;
 };
 
 struct i40iw_reg_ns_stag_info {
@@ -804,6 +805,7 @@ struct i40iw_reg_ns_stag_info {
 	bool use_hmc_fcn_index;
 	u8 hmc_fcn_index;
 	bool use_pf_rid;
+	bool all_memory;
 };
 
 struct i40iw_fast_reg_stag_info {
diff --git a/drivers/infiniband/hw/i40iw/i40iw_verbs.c b/drivers/infiniband/hw/i40iw/i40iw_verbs.c
index 533f3caecb7a..89654dc91d81 100644
--- a/drivers/infiniband/hw/i40iw/i40iw_verbs.c
+++ b/drivers/infiniband/hw/i40iw/i40iw_verbs.c
@@ -1494,7 +1494,8 @@ static int i40iw_handle_q_mem(struct i40iw_device *iwdev,
 static int i40iw_hw_alloc_stag(struct i40iw_device *iwdev, struct i40iw_mr *iwmr)
 {
 	struct i40iw_allocate_stag_info *info;
-	struct i40iw_pd *iwpd = to_iwpd(iwmr->ibmr.pd);
+	struct ib_pd *pd = iwmr->ibmr.pd;
+	struct i40iw_pd *iwpd = to_iwpd(pd);
 	enum i40iw_status_code status;
 	int err = 0;
 	struct i40iw_cqp_request *cqp_request;
@@ -1511,6 +1512,7 @@ static int i40iw_hw_alloc_stag(struct i40iw_device *iwdev, struct i40iw_mr *iwmr
 	info->stag_idx = iwmr->stag >> I40IW_CQPSQ_STAG_IDX_SHIFT;
 	info->pd_id = iwpd->sc_pd.pd_id;
 	info->total_len = iwmr->length;
+	info->all_memory = pd->flags & IB_PD_UNSAFE_GLOBAL_RKEY;
 	info->remote_access = true;
 	cqp_info->cqp_cmd = OP_ALLOC_STAG;
 	cqp_info->post_sq = 1;
@@ -1563,6 +1565,8 @@ static struct ib_mr *i40iw_alloc_mr(struct ib_pd *pd, enum ib_mr_type mr_type,
 	iwmr->type = IW_MEMREG_TYPE_MEM;
 	palloc = &iwpbl->pble_alloc;
 	iwmr->page_cnt = max_num_sg;
+	/* Use system PAGE_SIZE as the sg page sizes are unknown at this point */
+	iwmr->length = max_num_sg * PAGE_SIZE;
 	mutex_lock(&iwdev->pbl_mutex);
 	status = i40iw_get_pble(&iwdev->sc_dev, iwdev->pble_rsrc, palloc, iwmr->page_cnt);
 	mutex_unlock(&iwdev->pbl_mutex);
@@ -1659,7 +1663,8 @@ static int i40iw_hwreg_mr(struct i40iw_device *iwdev,
 {
 	struct i40iw_pbl *iwpbl = &iwmr->iwpbl;
 	struct i40iw_reg_ns_stag_info *stag_info;
-	struct i40iw_pd *iwpd = to_iwpd(iwmr->ibmr.pd);
+	struct ib_pd *pd = iwmr->ibmr.pd;
+	struct i40iw_pd *iwpd = to_iwpd(pd);
 	struct i40iw_pble_alloc *palloc = &iwpbl->pble_alloc;
 	enum i40iw_status_code status;
 	int err = 0;
@@ -1679,6 +1684,7 @@ static int i40iw_hwreg_mr(struct i40iw_device *iwdev,
 	stag_info->total_len = iwmr->length;
 	stag_info->access_rights = access;
 	stag_info->pd_id = iwpd->sc_pd.pd_id;
+	stag_info->all_memory = pd->flags & IB_PD_UNSAFE_GLOBAL_RKEY;
 	stag_info->addr_type = I40IW_ADDR_TYPE_VA_BASED;
 	stag_info->page_size = iwmr->page_size;
 
diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index 762c50239146..beedad0fe09a 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -119,6 +119,7 @@ static const struct xpad_device {
 	{ 0x044f, 0x0f07, "Thrustmaster, Inc. Controller", 0, XTYPE_XBOX },
 	{ 0x044f, 0x0f10, "Thrustmaster Modena GT Wheel", 0, XTYPE_XBOX },
 	{ 0x044f, 0xb326, "Thrustmaster Gamepad GP XID", 0, XTYPE_XBOX360 },
+	{ 0x03f0, 0x0495, "HyperX Clutch Gladiate", 0, XTYPE_XBOXONE },
 	{ 0x045e, 0x0202, "Microsoft X-Box pad v1 (US)", 0, XTYPE_XBOX },
 	{ 0x045e, 0x0285, "Microsoft X-Box pad (Japan)", 0, XTYPE_XBOX },
 	{ 0x045e, 0x0287, "Microsoft Xbox Controller S", 0, XTYPE_XBOX },
@@ -431,6 +432,7 @@ static const struct usb_device_id xpad_table[] = {
 	XPAD_XBOX360_VENDOR(0x0079),		/* GPD Win 2 Controller */
 	XPAD_XBOX360_VENDOR(0x03eb),		/* Wooting Keyboards (Legacy) */
 	XPAD_XBOX360_VENDOR(0x044f),		/* Thrustmaster X-Box 360 controllers */
+	XPAD_XBOXONE_VENDOR(0x03f0),		/* HP HyperX Xbox One Controllers */
 	XPAD_XBOX360_VENDOR(0x045e),		/* Microsoft X-Box 360 controllers */
 	XPAD_XBOXONE_VENDOR(0x045e),		/* Microsoft X-Box One controllers */
 	XPAD_XBOX360_VENDOR(0x046d),		/* Logitech X-Box 360 style controllers */
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 47666c9b4ba1..6be92e0afdb0 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -6325,7 +6325,7 @@ static void quirk_igfx_skip_te_disable(struct pci_dev *dev)
 	ver = (dev->device >> 8) & 0xff;
 	if (ver != 0x45 && ver != 0x46 && ver != 0x4c &&
 	    ver != 0x4e && ver != 0x8a && ver != 0x98 &&
-	    ver != 0x9a && ver != 0xa7)
+	    ver != 0x9a && ver != 0xa7 && ver != 0x7d)
 		return;
 
 	if (risky_device(dev))
diff --git a/drivers/md/bcache/btree.c b/drivers/md/bcache/btree.c
index 24c57bb85b35..3d6a7fbcbb15 100644
--- a/drivers/md/bcache/btree.c
+++ b/drivers/md/bcache/btree.c
@@ -1342,7 +1342,7 @@ static int btree_gc_coalesce(struct btree *b, struct btree_op *op,
 	memset(new_nodes, 0, sizeof(new_nodes));
 	closure_init_stack(&cl);
 
-	while (nodes < GC_MERGE_NODES && !IS_ERR(r[nodes].b))
+	while (nodes < GC_MERGE_NODES && !IS_ERR_OR_NULL(r[nodes].b))
 		keys += r[nodes++].keys;
 
 	blocks = btree_default_blocks(b->c) * 2 / 3;
@@ -1489,7 +1489,7 @@ static int btree_gc_coalesce(struct btree *b, struct btree_op *op,
 	bch_keylist_free(&keylist);
 
 	for (i = 0; i < nodes; i++)
-		if (!IS_ERR(new_nodes[i])) {
+		if (!IS_ERR_OR_NULL(new_nodes[i])) {
 			btree_node_free(new_nodes[i]);
 			rw_unlock(true, new_nodes[i]);
 		}
@@ -1506,6 +1506,8 @@ static int btree_gc_rewrite_node(struct btree *b, struct btree_op *op,
 		return 0;
 
 	n = btree_node_alloc_replacement(replace, NULL);
+	if (IS_ERR(n))
+		return 0;
 
 	/* recheck reserve after allocating replacement node */
 	if (btree_check_reserve(b, NULL)) {
diff --git a/drivers/md/bcache/sysfs.c b/drivers/md/bcache/sysfs.c
index 554e3afc9b68..ca3e2f000cd4 100644
--- a/drivers/md/bcache/sysfs.c
+++ b/drivers/md/bcache/sysfs.c
@@ -1078,7 +1078,7 @@ SHOW(__bch_cache)
 			sum += INITIAL_PRIO - cached[i];
 
 		if (n)
-			do_div(sum, n);
+			sum = div64_u64(sum, n);
 
 		for (i = 0; i < ARRAY_SIZE(q); i++)
 			q[i] = INITIAL_PRIO - cached[n * (i + 1) /
diff --git a/drivers/md/bcache/writeback.c b/drivers/md/bcache/writeback.c
index 6324c922f6ba..94e899ce3855 100644
--- a/drivers/md/bcache/writeback.c
+++ b/drivers/md/bcache/writeback.c
@@ -921,24 +921,35 @@ static int bch_btre_dirty_init_thread_nr(void)
 void bch_sectors_dirty_init(struct bcache_device *d)
 {
 	int i;
+	struct btree *b = NULL;
 	struct bkey *k = NULL;
 	struct btree_iter iter;
 	struct sectors_dirty_init op;
 	struct cache_set *c = d->c;
 	struct bch_dirty_init_state state;
 
+retry_lock:
+	b = c->root;
+	rw_lock(0, b, b->level);
+	if (b != c->root) {
+		rw_unlock(0, b);
+		goto retry_lock;
+	}
+
 	/* Just count root keys if no leaf node */
-	rw_lock(0, c->root, c->root->level);
 	if (c->root->level == 0) {
 		bch_btree_op_init(&op.op, -1);
 		op.inode = d->id;
 		op.count = 0;
 
 		for_each_key_filter(&c->root->keys,
-				    k, &iter, bch_ptr_invalid)
+				    k, &iter, bch_ptr_invalid) {
+			if (KEY_INODE(k) != op.inode)
+				continue;
 			sectors_dirty_init_fn(&op.op, c->root, k);
+		}
 
-		rw_unlock(0, c->root);
+		rw_unlock(0, b);
 		return;
 	}
 
@@ -958,23 +969,24 @@ void bch_sectors_dirty_init(struct bcache_device *d)
 		if (atomic_read(&state.enough))
 			break;
 
+		atomic_inc(&state.started);
 		state.infos[i].state = &state;
 		state.infos[i].thread =
 			kthread_run(bch_dirty_init_thread, &state.infos[i],
 				    "bch_dirtcnt[%d]", i);
 		if (IS_ERR(state.infos[i].thread)) {
 			pr_err("fails to run thread bch_dirty_init[%d]\n", i);
+			atomic_dec(&state.started);
 			for (--i; i >= 0; i--)
 				kthread_stop(state.infos[i].thread);
 			goto out;
 		}
-		atomic_inc(&state.started);
 	}
 
 out:
 	/* Must wait for all threads to stop. */
 	wait_event(state.wait, atomic_read(&state.started) == 0);
-	rw_unlock(0, c->root);
+	rw_unlock(0, b);
 }
 
 void bch_cached_dev_writeback_init(struct cached_dev *dc)
diff --git a/drivers/md/dm-delay.c b/drivers/md/dm-delay.c
index 2628a832787b..d58b9ae6f287 100644
--- a/drivers/md/dm-delay.c
+++ b/drivers/md/dm-delay.c
@@ -30,7 +30,7 @@ struct delay_c {
 	struct workqueue_struct *kdelayd_wq;
 	struct work_struct flush_expired_bios;
 	struct list_head delayed_bios;
-	atomic_t may_delay;
+	bool may_delay;
 
 	struct delay_class read;
 	struct delay_class write;
@@ -191,7 +191,7 @@ static int delay_ctr(struct dm_target *ti, unsigned int argc, char **argv)
 	INIT_WORK(&dc->flush_expired_bios, flush_expired_bios);
 	INIT_LIST_HEAD(&dc->delayed_bios);
 	mutex_init(&dc->timer_lock);
-	atomic_set(&dc->may_delay, 1);
+	dc->may_delay = true;
 	dc->argc = argc;
 
 	ret = delay_class_ctr(ti, &dc->read, argv);
@@ -245,7 +245,7 @@ static int delay_bio(struct delay_c *dc, struct delay_class *c, struct bio *bio)
 	struct dm_delay_info *delayed;
 	unsigned long expires = 0;
 
-	if (!c->delay || !atomic_read(&dc->may_delay))
+	if (!c->delay)
 		return DM_MAPIO_REMAPPED;
 
 	delayed = dm_per_bio_data(bio, sizeof(struct dm_delay_info));
@@ -254,6 +254,10 @@ static int delay_bio(struct delay_c *dc, struct delay_class *c, struct bio *bio)
 	delayed->expires = expires = jiffies + msecs_to_jiffies(c->delay);
 
 	mutex_lock(&delayed_bios_lock);
+	if (unlikely(!dc->may_delay)) {
+		mutex_unlock(&delayed_bios_lock);
+		return DM_MAPIO_REMAPPED;
+	}
 	c->ops++;
 	list_add_tail(&delayed->list, &dc->delayed_bios);
 	mutex_unlock(&delayed_bios_lock);
@@ -267,7 +271,10 @@ static void delay_presuspend(struct dm_target *ti)
 {
 	struct delay_c *dc = ti->private;
 
-	atomic_set(&dc->may_delay, 0);
+	mutex_lock(&delayed_bios_lock);
+	dc->may_delay = false;
+	mutex_unlock(&delayed_bios_lock);
+
 	del_timer_sync(&dc->delay_timer);
 	flush_bios(flush_delayed_bios(dc, 1));
 }
@@ -276,7 +283,7 @@ static void delay_resume(struct dm_target *ti)
 {
 	struct delay_c *dc = ti->private;
 
-	atomic_set(&dc->may_delay, 1);
+	dc->may_delay = true;
 }
 
 static int delay_map(struct dm_target *ti, struct bio *bio)
diff --git a/drivers/md/dm-verity-fec.c b/drivers/md/dm-verity-fec.c
index cea2b3789736..442437e4e03b 100644
--- a/drivers/md/dm-verity-fec.c
+++ b/drivers/md/dm-verity-fec.c
@@ -24,7 +24,8 @@ bool verity_fec_is_enabled(struct dm_verity *v)
  */
 static inline struct dm_verity_fec_io *fec_io(struct dm_verity_io *io)
 {
-	return (struct dm_verity_fec_io *) verity_io_digest_end(io->v, io);
+	return (struct dm_verity_fec_io *)
+		((char *)io + io->v->ti->per_io_data_size - sizeof(struct dm_verity_fec_io));
 }
 
 /*
diff --git a/drivers/md/dm-verity-target.c b/drivers/md/dm-verity-target.c
index 0c2048d2b847..7671949c8a2d 100644
--- a/drivers/md/dm-verity-target.c
+++ b/drivers/md/dm-verity-target.c
@@ -583,7 +583,9 @@ static void verity_end_io(struct bio *bio)
 	struct dm_verity_io *io = bio->bi_private;
 
 	if (bio->bi_status &&
-	    (!verity_fec_is_enabled(io->v) || verity_is_system_shutting_down())) {
+	    (!verity_fec_is_enabled(io->v) ||
+	     verity_is_system_shutting_down() ||
+	     (bio->bi_opf & REQ_RAHEAD))) {
 		verity_finish_io(io, bio->bi_status);
 		return;
 	}
diff --git a/drivers/md/dm-verity.h b/drivers/md/dm-verity.h
index 4e769d13473a..78d1e51195ad 100644
--- a/drivers/md/dm-verity.h
+++ b/drivers/md/dm-verity.h
@@ -111,12 +111,6 @@ static inline u8 *verity_io_want_digest(struct dm_verity *v,
 	return (u8 *)(io + 1) + v->ahash_reqsize + v->digest_size;
 }
 
-static inline u8 *verity_io_digest_end(struct dm_verity *v,
-				       struct dm_verity_io *io)
-{
-	return verity_io_want_digest(v, io) + v->digest_size;
-}
-
 extern int verity_for_bv_block(struct dm_verity *v, struct dm_verity_io *io,
 			       struct bvec_iter *iter,
 			       int (*process)(struct dm_verity *v,
diff --git a/drivers/media/i2c/smiapp/smiapp-core.c b/drivers/media/i2c/smiapp/smiapp-core.c
index 6fc0680a93d0..3bf96b047132 100644
--- a/drivers/media/i2c/smiapp/smiapp-core.c
+++ b/drivers/media/i2c/smiapp/smiapp-core.c
@@ -2647,7 +2647,7 @@ static int smiapp_open(struct v4l2_subdev *sd, struct v4l2_subdev_fh *fh)
 		try_fmt->code = sensor->internal_csi_format->code;
 		try_fmt->field = V4L2_FIELD_NONE;
 
-		if (ssd != sensor->pixel_array)
+		if (ssd == sensor->pixel_array)
 			continue;
 
 		try_comp = v4l2_subdev_get_try_compose(sd, fh->pad, i);
diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index b4a07a166605..cdb9a55a2c70 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -70,6 +70,9 @@
 
 #define PCI_DEVICE_ID_TI_J721E			0xb00d
 #define PCI_DEVICE_ID_TI_AM654			0xb00c
+#define PCI_DEVICE_ID_TI_J7200			0xb00f
+#define PCI_DEVICE_ID_TI_AM64			0xb010
+#define PCI_DEVICE_ID_TI_J721S2		0xb013
 #define PCI_DEVICE_ID_LS1088A			0x80c0
 
 #define is_am654_pci_dev(pdev)		\
@@ -1000,6 +1003,15 @@ static const struct pci_device_id pci_endpoint_test_tbl[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_TI, PCI_DEVICE_ID_TI_J721E),
 	  .driver_data = (kernel_ulong_t)&j721e_data,
 	},
+	{ PCI_DEVICE(PCI_VENDOR_ID_TI, PCI_DEVICE_ID_TI_J7200),
+	  .driver_data = (kernel_ulong_t)&j721e_data,
+	},
+	{ PCI_DEVICE(PCI_VENDOR_ID_TI, PCI_DEVICE_ID_TI_AM64),
+	  .driver_data = (kernel_ulong_t)&j721e_data,
+	},
+	{ PCI_DEVICE(PCI_VENDOR_ID_TI, PCI_DEVICE_ID_TI_J721S2),
+	  .driver_data = (kernel_ulong_t)&j721e_data,
+	},
 	{ }
 };
 MODULE_DEVICE_TABLE(pci, pci_endpoint_test_tbl);
diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index d81baf750aeb..41d98d7198be 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -1418,6 +1418,8 @@ static void mmc_blk_cqe_complete_rq(struct mmc_queue *mq, struct request *req)
 			blk_mq_requeue_request(req, true);
 		else
 			__blk_mq_end_request(req, BLK_STS_OK);
+	} else if (mq->in_recovery) {
+		blk_mq_requeue_request(req, true);
 	} else {
 		blk_mq_end_request(req, BLK_STS_OK);
 	}
diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 8f2465394253..fdeaaae08060 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -547,22 +547,25 @@ int mmc_cqe_recovery(struct mmc_host *host)
 	host->cqe_ops->cqe_recovery_start(host);
 
 	memset(&cmd, 0, sizeof(cmd));
-	cmd.opcode       = MMC_STOP_TRANSMISSION,
-	cmd.flags        = MMC_RSP_R1B | MMC_CMD_AC,
+	cmd.opcode       = MMC_STOP_TRANSMISSION;
+	cmd.flags        = MMC_RSP_R1B | MMC_CMD_AC;
 	cmd.flags       &= ~MMC_RSP_CRC; /* Ignore CRC */
-	cmd.busy_timeout = MMC_CQE_RECOVERY_TIMEOUT,
-	mmc_wait_for_cmd(host, &cmd, 0);
+	cmd.busy_timeout = MMC_CQE_RECOVERY_TIMEOUT;
+	mmc_wait_for_cmd(host, &cmd, MMC_CMD_RETRIES);
 
 	memset(&cmd, 0, sizeof(cmd));
 	cmd.opcode       = MMC_CMDQ_TASK_MGMT;
 	cmd.arg          = 1; /* Discard entire queue */
 	cmd.flags        = MMC_RSP_R1B | MMC_CMD_AC;
 	cmd.flags       &= ~MMC_RSP_CRC; /* Ignore CRC */
-	cmd.busy_timeout = MMC_CQE_RECOVERY_TIMEOUT,
-	err = mmc_wait_for_cmd(host, &cmd, 0);
+	cmd.busy_timeout = MMC_CQE_RECOVERY_TIMEOUT;
+	err = mmc_wait_for_cmd(host, &cmd, MMC_CMD_RETRIES);
 
 	host->cqe_ops->cqe_recovery_finish(host);
 
+	if (err)
+		err = mmc_wait_for_cmd(host, &cmd, MMC_CMD_RETRIES);
+
 	mmc_retune_release(host);
 
 	return err;
diff --git a/drivers/mmc/core/regulator.c b/drivers/mmc/core/regulator.c
index 609201a467ef..4dcbc2281d2b 100644
--- a/drivers/mmc/core/regulator.c
+++ b/drivers/mmc/core/regulator.c
@@ -271,3 +271,44 @@ int mmc_regulator_get_supply(struct mmc_host *mmc)
 	return 0;
 }
 EXPORT_SYMBOL_GPL(mmc_regulator_get_supply);
+
+/**
+ * mmc_regulator_enable_vqmmc - enable VQMMC regulator for a host
+ * @mmc: the host to regulate
+ *
+ * Returns 0 or errno. Enables the regulator for vqmmc.
+ * Keeps track of the enable status for ensuring that calls to
+ * regulator_enable/disable are balanced.
+ */
+int mmc_regulator_enable_vqmmc(struct mmc_host *mmc)
+{
+	int ret = 0;
+
+	if (!IS_ERR(mmc->supply.vqmmc) && !mmc->vqmmc_enabled) {
+		ret = regulator_enable(mmc->supply.vqmmc);
+		if (ret < 0)
+			dev_err(mmc_dev(mmc), "enabling vqmmc regulator failed\n");
+		else
+			mmc->vqmmc_enabled = true;
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(mmc_regulator_enable_vqmmc);
+
+/**
+ * mmc_regulator_disable_vqmmc - disable VQMMC regulator for a host
+ * @mmc: the host to regulate
+ *
+ * Returns 0 or errno. Disables the regulator for vqmmc.
+ * Keeps track of the enable status for ensuring that calls to
+ * regulator_enable/disable are balanced.
+ */
+void mmc_regulator_disable_vqmmc(struct mmc_host *mmc)
+{
+	if (!IS_ERR(mmc->supply.vqmmc) && mmc->vqmmc_enabled) {
+		regulator_disable(mmc->supply.vqmmc);
+		mmc->vqmmc_enabled = false;
+	}
+}
+EXPORT_SYMBOL_GPL(mmc_regulator_disable_vqmmc);
diff --git a/drivers/mmc/host/cqhci.c b/drivers/mmc/host/cqhci.c
index 7ba4f714106f..23cf7912c1ba 100644
--- a/drivers/mmc/host/cqhci.c
+++ b/drivers/mmc/host/cqhci.c
@@ -890,8 +890,8 @@ static bool cqhci_clear_all_tasks(struct mmc_host *mmc, unsigned int timeout)
 	ret = cqhci_tasks_cleared(cq_host);
 
 	if (!ret)
-		pr_debug("%s: cqhci: Failed to clear tasks\n",
-			 mmc_hostname(mmc));
+		pr_warn("%s: cqhci: Failed to clear tasks\n",
+			mmc_hostname(mmc));
 
 	return ret;
 }
@@ -924,7 +924,7 @@ static bool cqhci_halt(struct mmc_host *mmc, unsigned int timeout)
 	ret = cqhci_halted(cq_host);
 
 	if (!ret)
-		pr_debug("%s: cqhci: Failed to halt\n", mmc_hostname(mmc));
+		pr_warn("%s: cqhci: Failed to halt\n", mmc_hostname(mmc));
 
 	return ret;
 }
@@ -932,10 +932,10 @@ static bool cqhci_halt(struct mmc_host *mmc, unsigned int timeout)
 /*
  * After halting we expect to be able to use the command line. We interpret the
  * failure to halt to mean the data lines might still be in use (and the upper
- * layers will need to send a STOP command), so we set the timeout based on a
- * generous command timeout.
+ * layers will need to send a STOP command), however failing to halt complicates
+ * the recovery, so set a timeout that would reasonably allow I/O to complete.
  */
-#define CQHCI_START_HALT_TIMEOUT	5
+#define CQHCI_START_HALT_TIMEOUT	500
 
 static void cqhci_recovery_start(struct mmc_host *mmc)
 {
@@ -1023,28 +1023,28 @@ static void cqhci_recovery_finish(struct mmc_host *mmc)
 
 	ok = cqhci_halt(mmc, CQHCI_FINISH_HALT_TIMEOUT);
 
-	if (!cqhci_clear_all_tasks(mmc, CQHCI_CLEAR_TIMEOUT))
-		ok = false;
-
 	/*
 	 * The specification contradicts itself, by saying that tasks cannot be
 	 * cleared if CQHCI does not halt, but if CQHCI does not halt, it should
 	 * be disabled/re-enabled, but not to disable before clearing tasks.
 	 * Have a go anyway.
 	 */
-	if (!ok) {
-		pr_debug("%s: cqhci: disable / re-enable\n", mmc_hostname(mmc));
-		cqcfg = cqhci_readl(cq_host, CQHCI_CFG);
-		cqcfg &= ~CQHCI_ENABLE;
-		cqhci_writel(cq_host, cqcfg, CQHCI_CFG);
-		cqcfg |= CQHCI_ENABLE;
-		cqhci_writel(cq_host, cqcfg, CQHCI_CFG);
-		/* Be sure that there are no tasks */
-		ok = cqhci_halt(mmc, CQHCI_FINISH_HALT_TIMEOUT);
-		if (!cqhci_clear_all_tasks(mmc, CQHCI_CLEAR_TIMEOUT))
-			ok = false;
-		WARN_ON(!ok);
-	}
+	if (!cqhci_clear_all_tasks(mmc, CQHCI_CLEAR_TIMEOUT))
+		ok = false;
+
+	/* Disable to make sure tasks really are cleared */
+	cqcfg = cqhci_readl(cq_host, CQHCI_CFG);
+	cqcfg &= ~CQHCI_ENABLE;
+	cqhci_writel(cq_host, cqcfg, CQHCI_CFG);
+
+	cqcfg = cqhci_readl(cq_host, CQHCI_CFG);
+	cqcfg |= CQHCI_ENABLE;
+	cqhci_writel(cq_host, cqcfg, CQHCI_CFG);
+
+	cqhci_halt(mmc, CQHCI_FINISH_HALT_TIMEOUT);
+
+	if (!ok)
+		cqhci_clear_all_tasks(mmc, CQHCI_CLEAR_TIMEOUT);
 
 	cqhci_recover_mrqs(cq_host);
 
diff --git a/drivers/mmc/host/sdhci-sprd.c b/drivers/mmc/host/sdhci-sprd.c
index 540ebccaa9a3..d8e412bbb93b 100644
--- a/drivers/mmc/host/sdhci-sprd.c
+++ b/drivers/mmc/host/sdhci-sprd.c
@@ -392,12 +392,33 @@ static void sdhci_sprd_request_done(struct sdhci_host *host,
 	mmc_request_done(host->mmc, mrq);
 }
 
+static void sdhci_sprd_set_power(struct sdhci_host *host, unsigned char mode,
+				 unsigned short vdd)
+{
+	struct mmc_host *mmc = host->mmc;
+
+	switch (mode) {
+	case MMC_POWER_OFF:
+		mmc_regulator_set_ocr(host->mmc, mmc->supply.vmmc, 0);
+
+		mmc_regulator_disable_vqmmc(mmc);
+		break;
+	case MMC_POWER_ON:
+		mmc_regulator_enable_vqmmc(mmc);
+		break;
+	case MMC_POWER_UP:
+		mmc_regulator_set_ocr(host->mmc, mmc->supply.vmmc, vdd);
+		break;
+	}
+}
+
 static struct sdhci_ops sdhci_sprd_ops = {
 	.read_l = sdhci_sprd_readl,
 	.write_l = sdhci_sprd_writel,
 	.write_w = sdhci_sprd_writew,
 	.write_b = sdhci_sprd_writeb,
 	.set_clock = sdhci_sprd_set_clock,
+	.set_power = sdhci_sprd_set_power,
 	.get_max_clock = sdhci_sprd_get_max_clock,
 	.get_min_clock = sdhci_sprd_get_min_clock,
 	.set_bus_width = sdhci_set_bus_width,
@@ -663,6 +684,10 @@ static int sdhci_sprd_probe(struct platform_device *pdev)
 	host->caps1 &= ~(SDHCI_SUPPORT_SDR50 | SDHCI_SUPPORT_SDR104 |
 			 SDHCI_SUPPORT_DDR50);
 
+	ret = mmc_regulator_get_supply(host->mmc);
+	if (ret)
+		goto pm_runtime_disable;
+
 	ret = sdhci_setup_host(host);
 	if (ret)
 		goto pm_runtime_disable;
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-drv.c b/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
index a5d6faf7b89e..23401958bc13 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
@@ -682,10 +682,24 @@ static void xgbe_service(struct work_struct *work)
 static void xgbe_service_timer(struct timer_list *t)
 {
 	struct xgbe_prv_data *pdata = from_timer(pdata, t, service_timer);
+	struct xgbe_channel *channel;
+	unsigned int i;
 
 	queue_work(pdata->dev_workqueue, &pdata->service_work);
 
 	mod_timer(&pdata->service_timer, jiffies + HZ);
+
+	if (!pdata->tx_usecs)
+		return;
+
+	for (i = 0; i < pdata->channel_count; i++) {
+		channel = pdata->channel[i];
+		if (!channel->tx_ring || channel->tx_timer_active)
+			break;
+		channel->tx_timer_active = 1;
+		mod_timer(&channel->tx_timer,
+			  jiffies + usecs_to_jiffies(pdata->tx_usecs));
+	}
 }
 
 static void xgbe_init_timers(struct xgbe_prv_data *pdata)
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c b/drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c
index 61f39a0e04f9..64aebf922dda 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c
@@ -314,10 +314,15 @@ static int xgbe_get_link_ksettings(struct net_device *netdev,
 
 	cmd->base.phy_address = pdata->phy.address;
 
-	cmd->base.autoneg = pdata->phy.autoneg;
-	cmd->base.speed = pdata->phy.speed;
-	cmd->base.duplex = pdata->phy.duplex;
+	if (netif_carrier_ok(netdev)) {
+		cmd->base.speed = pdata->phy.speed;
+		cmd->base.duplex = pdata->phy.duplex;
+	} else {
+		cmd->base.speed = SPEED_UNKNOWN;
+		cmd->base.duplex = DUPLEX_UNKNOWN;
+	}
 
+	cmd->base.autoneg = pdata->phy.autoneg;
 	cmd->base.port = PORT_NONE;
 
 	XGBE_LM_COPY(cmd, supported, lks, supported);
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-mdio.c b/drivers/net/ethernet/amd/xgbe/xgbe-mdio.c
index ca7372369b3e..60be836b294b 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-mdio.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-mdio.c
@@ -1178,7 +1178,19 @@ static int xgbe_phy_config_fixed(struct xgbe_prv_data *pdata)
 	if (pdata->phy.duplex != DUPLEX_FULL)
 		return -EINVAL;
 
-	xgbe_set_mode(pdata, mode);
+	/* Force the mode change for SFI in Fixed PHY config.
+	 * Fixed PHY configs needs PLL to be enabled while doing mode set.
+	 * When the SFP module isn't connected during boot, driver assumes
+	 * AN is ON and attempts autonegotiation. However, if the connected
+	 * SFP comes up in Fixed PHY config, the link will not come up as
+	 * PLL isn't enabled while the initial mode set command is issued.
+	 * So, force the mode change for SFI in Fixed PHY configuration to
+	 * fix link issues.
+	 */
+	if (mode == XGBE_MODE_SFI)
+		xgbe_change_mode(pdata, mode);
+	else
+		xgbe_set_mode(pdata, mode);
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
index 35401202523e..07ba0438f965 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
@@ -928,14 +928,12 @@ static int dpaa2_eth_build_single_fd(struct dpaa2_eth_priv *priv,
 	dma_addr_t addr;
 
 	buffer_start = skb->data - dpaa2_eth_needed_headroom(skb);
-
-	/* If there's enough room to align the FD address, do it.
-	 * It will help hardware optimize accesses.
-	 */
 	aligned_start = PTR_ALIGN(buffer_start - DPAA2_ETH_TX_BUF_ALIGN,
 				  DPAA2_ETH_TX_BUF_ALIGN);
 	if (aligned_start >= skb->head)
 		buffer_start = aligned_start;
+	else
+		return -ENOMEM;
 
 	/* Store a backpointer to the skb at the beginning of the buffer
 	 * (in the private data area) such that we can release it
@@ -4337,6 +4335,8 @@ static int dpaa2_eth_probe(struct fsl_mc_device *dpni_dev)
 	if (err)
 		goto err_dl_port_add;
 
+	net_dev->needed_headroom = DPAA2_ETH_SWA_SIZE + DPAA2_ETH_TX_BUF_ALIGN;
+
 	err = register_netdev(net_dev);
 	if (err < 0) {
 		dev_err(dev, "register_netdev() failed\n");
diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.h b/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.h
index d236b8695c39..2825f53e7e9b 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.h
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.h
@@ -664,7 +664,7 @@ static inline bool dpaa2_eth_rx_pause_enabled(u64 link_options)
 
 static inline unsigned int dpaa2_eth_needed_headroom(struct sk_buff *skb)
 {
-	unsigned int headroom = DPAA2_ETH_SWA_SIZE;
+	unsigned int headroom = DPAA2_ETH_SWA_SIZE + DPAA2_ETH_TX_BUF_ALIGN;
 
 	/* If we don't have an skb (e.g. XDP buffer), we only need space for
 	 * the software annotation area
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
index 000dd89c4baf..d6f7a2a58aee 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
@@ -556,7 +556,9 @@ static irqreturn_t otx2_pfvf_mbox_intr_handler(int irq, void *pf_irq)
 		otx2_write64(pf, RVU_PF_VFPF_MBOX_INTX(1), intr);
 		otx2_queue_work(mbox, pf->mbox_pfvf_wq, 64, vfs, intr,
 				TYPE_PFVF);
-		vfs -= 64;
+		if (intr)
+			trace_otx2_msg_interrupt(mbox->mbox.pdev, "VF(s) to PF", intr);
+		vfs = 64;
 	}
 
 	intr = otx2_read64(pf, RVU_PF_VFPF_MBOX_INTX(0));
@@ -564,7 +566,8 @@ static irqreturn_t otx2_pfvf_mbox_intr_handler(int irq, void *pf_irq)
 
 	otx2_queue_work(mbox, pf->mbox_pfvf_wq, 0, vfs, intr, TYPE_PFVF);
 
-	trace_otx2_msg_interrupt(mbox->mbox.pdev, "VF(s) to PF", intr);
+	if (intr)
+		trace_otx2_msg_interrupt(mbox->mbox.pdev, "VF(s) to PF", intr);
 
 	return IRQ_HANDLED;
 }
diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index ab6af1f1ad5b..88253cedd9d9 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -582,6 +582,8 @@ struct rtl8169_tc_offsets {
 enum rtl_flag {
 	RTL_FLAG_TASK_ENABLED = 0,
 	RTL_FLAG_TASK_RESET_PENDING,
+	RTL_FLAG_TASK_RESET_NO_QUEUE_WAKE,
+	RTL_FLAG_TASK_TX_TIMEOUT,
 	RTL_FLAG_MAX
 };
 
@@ -4036,7 +4038,7 @@ static void rtl8169_tx_timeout(struct net_device *dev, unsigned int txqueue)
 {
 	struct rtl8169_private *tp = netdev_priv(dev);
 
-	rtl_schedule_task(tp, RTL_FLAG_TASK_RESET_PENDING);
+	rtl_schedule_task(tp, RTL_FLAG_TASK_TX_TIMEOUT);
 }
 
 static int rtl8169_tx_map(struct rtl8169_private *tp, const u32 *opts, u32 len,
@@ -4656,6 +4658,7 @@ static void rtl_task(struct work_struct *work)
 {
 	struct rtl8169_private *tp =
 		container_of(work, struct rtl8169_private, wk.work);
+	int ret;
 
 	rtnl_lock();
 
@@ -4663,9 +4666,21 @@ static void rtl_task(struct work_struct *work)
 	    !test_bit(RTL_FLAG_TASK_ENABLED, tp->wk.flags))
 		goto out_unlock;
 
+	if (test_and_clear_bit(RTL_FLAG_TASK_TX_TIMEOUT, tp->wk.flags)) {
+		/* ASPM compatibility issues are a typical reason for tx timeouts */
+		ret = pci_disable_link_state(tp->pci_dev, PCIE_LINK_STATE_L1 |
+							  PCIE_LINK_STATE_L0S);
+		if (!ret)
+			netdev_warn_once(tp->dev, "ASPM disabled on Tx timeout\n");
+		goto reset;
+	}
+
 	if (test_and_clear_bit(RTL_FLAG_TASK_RESET_PENDING, tp->wk.flags)) {
+reset:
 		rtl_reset_work(tp);
 		netif_wake_queue(tp->dev);
+	} else if (test_and_clear_bit(RTL_FLAG_TASK_RESET_NO_QUEUE_WAKE, tp->wk.flags)) {
+		rtl_reset_work(tp);
 	}
 out_unlock:
 	rtnl_unlock();
@@ -4699,7 +4714,7 @@ static void r8169_phylink_handler(struct net_device *ndev)
 	} else {
 		/* In few cases rx is broken after link-down otherwise */
 		if (rtl_is_8125(tp))
-			rtl_reset_work(tp);
+			rtl_schedule_task(tp, RTL_FLAG_TASK_RESET_NO_QUEUE_WAKE);
 		pm_runtime_idle(d);
 	}
 
@@ -4769,7 +4784,7 @@ static int rtl8169_close(struct net_device *dev)
 	rtl8169_down(tp);
 	rtl8169_rx_clear(tp);
 
-	cancel_work_sync(&tp->wk.work);
+	cancel_work(&tp->wk.work);
 
 	free_irq(pci_irq_vector(pdev, 0), tp);
 
@@ -5035,6 +5050,8 @@ static void rtl_remove_one(struct pci_dev *pdev)
 	if (pci_dev_run_wake(pdev))
 		pm_runtime_get_noresume(&pdev->dev);
 
+	cancel_work_sync(&tp->wk.work);
+
 	unregister_netdev(tp->dev);
 
 	if (r8168_check_dash(tp))
diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
index f218bacec001..f092f468016b 100644
--- a/drivers/net/ethernet/renesas/ravb_main.c
+++ b/drivers/net/ethernet/renesas/ravb_main.c
@@ -1383,13 +1383,13 @@ static int ravb_open(struct net_device *ndev)
 	if (priv->chip_id == RCAR_GEN2)
 		ravb_ptp_init(ndev, priv->pdev);
 
-	netif_tx_start_all_queues(ndev);
-
 	/* PHY control start */
 	error = ravb_phy_start(ndev);
 	if (error)
 		goto out_ptp_stop;
 
+	netif_tx_start_all_queues(ndev);
+
 	return 0;
 
 out_ptp_stop:
@@ -1438,6 +1438,12 @@ static void ravb_tx_timeout_work(struct work_struct *work)
 	struct net_device *ndev = priv->ndev;
 	int error;
 
+	if (!rtnl_trylock()) {
+		usleep_range(1000, 2000);
+		schedule_work(&priv->work);
+		return;
+	}
+
 	netif_tx_stop_all_queues(ndev);
 
 	/* Stop PTP Clock driver */
@@ -1470,7 +1476,7 @@ static void ravb_tx_timeout_work(struct work_struct *work)
 		 */
 		netdev_err(ndev, "%s: ravb_dmac_init() failed, error %d\n",
 			   __func__, error);
-		return;
+		goto out_unlock;
 	}
 	ravb_emac_init(ndev);
 
@@ -1480,6 +1486,9 @@ static void ravb_tx_timeout_work(struct work_struct *work)
 		ravb_ptp_init(ndev, priv->pdev);
 
 	netif_tx_start_all_queues(ndev);
+
+out_unlock:
+	rtnl_unlock();
 }
 
 /* Packet transmit function for Ethernet AVB */
@@ -2063,7 +2072,9 @@ static int ravb_probe(struct platform_device *pdev)
 	ndev->hw_features = NETIF_F_RXCSUM;
 
 	pm_runtime_enable(&pdev->dev);
-	pm_runtime_get_sync(&pdev->dev);
+	error = pm_runtime_resume_and_get(&pdev->dev);
+	if (error < 0)
+		goto out_rpm_disable;
 
 	/* The Ether-specific entries in the device structure. */
 	ndev->base_addr = res->start;
@@ -2238,6 +2249,7 @@ static int ravb_probe(struct platform_device *pdev)
 	free_netdev(ndev);
 
 	pm_runtime_put(&pdev->dev);
+out_rpm_disable:
 	pm_runtime_disable(&pdev->dev);
 	return error;
 }
diff --git a/drivers/net/ethernet/stmicro/stmmac/mmc_core.c b/drivers/net/ethernet/stmicro/stmmac/mmc_core.c
index a57b0fa815ab..a510bac0b825 100644
--- a/drivers/net/ethernet/stmicro/stmmac/mmc_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/mmc_core.c
@@ -177,8 +177,10 @@
 #define MMC_XGMAC_RX_DISCARD_OCT_GB	0x1b4
 #define MMC_XGMAC_RX_ALIGN_ERR_PKT	0x1bc
 
+#define MMC_XGMAC_TX_FPE_INTR_MASK	0x204
 #define MMC_XGMAC_TX_FPE_FRAG		0x208
 #define MMC_XGMAC_TX_HOLD_REQ		0x20c
+#define MMC_XGMAC_RX_FPE_INTR_MASK	0x224
 #define MMC_XGMAC_RX_PKT_ASSEMBLY_ERR	0x228
 #define MMC_XGMAC_RX_PKT_SMD_ERR	0x22c
 #define MMC_XGMAC_RX_PKT_ASSEMBLY_OK	0x230
@@ -352,6 +354,8 @@ static void dwxgmac_mmc_intr_all_mask(void __iomem *mmcaddr)
 {
 	writel(0x0, mmcaddr + MMC_RX_INTR_MASK);
 	writel(0x0, mmcaddr + MMC_TX_INTR_MASK);
+	writel(MMC_DEFAULT_MASK, mmcaddr + MMC_XGMAC_TX_FPE_INTR_MASK);
+	writel(MMC_DEFAULT_MASK, mmcaddr + MMC_XGMAC_RX_FPE_INTR_MASK);
 	writel(MMC_DEFAULT_MASK, mmcaddr + MMC_XGMAC_RX_IPC_INTR_MASK);
 }
 
diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
index 9d362283196a..2a5a3f8761c3 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
@@ -763,7 +763,7 @@ axienet_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 		if (lp->features & XAE_FEATURE_FULL_TX_CSUM) {
 			/* Tx Full Checksum Offload Enabled */
 			cur_p->app0 |= 2;
-		} else if (lp->features & XAE_FEATURE_PARTIAL_RX_CSUM) {
+		} else if (lp->features & XAE_FEATURE_PARTIAL_TX_CSUM) {
 			csum_start_off = skb_transport_offset(skb);
 			csum_index_off = csum_start_off + skb->csum_offset;
 			/* Tx Partial Checksum Offload Enabled */
diff --git a/drivers/net/hyperv/netvsc_drv.c b/drivers/net/hyperv/netvsc_drv.c
index f2020be43cfe..790bf750281a 100644
--- a/drivers/net/hyperv/netvsc_drv.c
+++ b/drivers/net/hyperv/netvsc_drv.c
@@ -2217,9 +2217,6 @@ static int netvsc_vf_join(struct net_device *vf_netdev,
 		goto upper_link_failed;
 	}
 
-	/* set slave flag before open to prevent IPv6 addrconf */
-	vf_netdev->flags |= IFF_SLAVE;
-
 	schedule_delayed_work(&ndev_ctx->vf_takeover, VF_TAKEOVER_INT);
 
 	call_netdevice_notifiers(NETDEV_JOIN, vf_netdev);
@@ -2317,16 +2314,18 @@ static struct net_device *get_netvsc_byslot(const struct net_device *vf_netdev)
 			return hv_get_drvdata(ndev_ctx->device_ctx);
 	}
 
-	/* Fallback path to check synthetic vf with
-	 * help of mac addr
+	/* Fallback path to check synthetic vf with help of mac addr.
+	 * Because this function can be called before vf_netdev is
+	 * initialized (NETDEV_POST_INIT) when its perm_addr has not been copied
+	 * from dev_addr, also try to match to its dev_addr.
+	 * Note: On Hyper-V and Azure, it's not possible to set a MAC address
+	 * on a VF that matches to the MAC of a unrelated NETVSC device.
 	 */
 	list_for_each_entry(ndev_ctx, &netvsc_dev_list, list) {
 		ndev = hv_get_drvdata(ndev_ctx->device_ctx);
-		if (ether_addr_equal(vf_netdev->perm_addr, ndev->perm_addr)) {
-			netdev_notice(vf_netdev,
-				      "falling back to mac addr based matching\n");
+		if (ether_addr_equal(vf_netdev->perm_addr, ndev->perm_addr) ||
+		    ether_addr_equal(vf_netdev->dev_addr, ndev->perm_addr))
 			return ndev;
-		}
 	}
 
 	netdev_notice(vf_netdev,
@@ -2334,6 +2333,19 @@ static struct net_device *get_netvsc_byslot(const struct net_device *vf_netdev)
 	return NULL;
 }
 
+static int netvsc_prepare_bonding(struct net_device *vf_netdev)
+{
+	struct net_device *ndev;
+
+	ndev = get_netvsc_byslot(vf_netdev);
+	if (!ndev)
+		return NOTIFY_DONE;
+
+	/* set slave flag before open to prevent IPv6 addrconf */
+	vf_netdev->flags |= IFF_SLAVE;
+	return NOTIFY_DONE;
+}
+
 static int netvsc_register_vf(struct net_device *vf_netdev)
 {
 	struct net_device_context *net_device_ctx;
@@ -2516,15 +2528,6 @@ static int netvsc_probe(struct hv_device *dev,
 		goto devinfo_failed;
 	}
 
-	nvdev = rndis_filter_device_add(dev, device_info);
-	if (IS_ERR(nvdev)) {
-		ret = PTR_ERR(nvdev);
-		netdev_err(net, "unable to add netvsc device (ret %d)\n", ret);
-		goto rndis_failed;
-	}
-
-	memcpy(net->dev_addr, device_info->mac_adr, ETH_ALEN);
-
 	/* We must get rtnl lock before scheduling nvdev->subchan_work,
 	 * otherwise netvsc_subchan_work() can get rtnl lock first and wait
 	 * all subchannels to show up, but that may not happen because
@@ -2532,9 +2535,23 @@ static int netvsc_probe(struct hv_device *dev,
 	 * -> ... -> device_add() -> ... -> __device_attach() can't get
 	 * the device lock, so all the subchannels can't be processed --
 	 * finally netvsc_subchan_work() hangs forever.
+	 *
+	 * The rtnl lock also needs to be held before rndis_filter_device_add()
+	 * which advertises nvsp_2_vsc_capability / sriov bit, and triggers
+	 * VF NIC offering and registering. If VF NIC finished register_netdev()
+	 * earlier it may cause name based config failure.
 	 */
 	rtnl_lock();
 
+	nvdev = rndis_filter_device_add(dev, device_info);
+	if (IS_ERR(nvdev)) {
+		ret = PTR_ERR(nvdev);
+		netdev_err(net, "unable to add netvsc device (ret %d)\n", ret);
+		goto rndis_failed;
+	}
+
+	memcpy(net->dev_addr, device_info->mac_adr, ETH_ALEN);
+
 	if (nvdev->num_chn > 1)
 		schedule_work(&nvdev->subchan_work);
 
@@ -2568,9 +2585,9 @@ static int netvsc_probe(struct hv_device *dev,
 	return 0;
 
 register_failed:
-	rtnl_unlock();
 	rndis_filter_device_remove(dev, nvdev);
 rndis_failed:
+	rtnl_unlock();
 	netvsc_devinfo_put(device_info);
 devinfo_failed:
 	free_percpu(net_device_ctx->vf_stats);
@@ -2737,6 +2754,8 @@ static int netvsc_netdev_event(struct notifier_block *this,
 		return NOTIFY_DONE;
 
 	switch (event) {
+	case NETDEV_POST_INIT:
+		return netvsc_prepare_bonding(event_dev);
 	case NETDEV_REGISTER:
 		return netvsc_register_vf(event_dev);
 	case NETDEV_UNREGISTER:
@@ -2771,12 +2790,17 @@ static int __init netvsc_drv_init(void)
 	}
 	netvsc_ring_bytes = ring_size * PAGE_SIZE;
 
+	register_netdevice_notifier(&netvsc_netdev_notifier);
+
 	ret = vmbus_driver_register(&netvsc_drv);
 	if (ret)
-		return ret;
+		goto err_vmbus_reg;
 
-	register_netdevice_notifier(&netvsc_netdev_notifier);
 	return 0;
+
+err_vmbus_reg:
+	unregister_netdevice_notifier(&netvsc_netdev_notifier);
+	return ret;
 }
 
 MODULE_LICENSE("GPL");
diff --git a/drivers/net/usb/ax88179_178a.c b/drivers/net/usb/ax88179_178a.c
index 79a53fe245e5..38cb863ccb91 100644
--- a/drivers/net/usb/ax88179_178a.c
+++ b/drivers/net/usb/ax88179_178a.c
@@ -1700,11 +1700,11 @@ static int ax88179_reset(struct usbnet *dev)
 
 	*tmp16 = AX_PHYPWR_RSTCTL_IPRL;
 	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_PHYPWR_RSTCTL, 2, 2, tmp16);
-	msleep(200);
+	msleep(500);
 
 	*tmp = AX_CLK_SELECT_ACS | AX_CLK_SELECT_BCS;
 	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_CLK_SELECT, 1, 1, tmp);
-	msleep(100);
+	msleep(200);
 
 	/* Ethernet PHY Auto Detach*/
 	ax88179_auto_detach(dev, 0);
diff --git a/drivers/net/wireguard/device.c b/drivers/net/wireguard/device.c
index e0693cd965ec..713ca20feaef 100644
--- a/drivers/net/wireguard/device.c
+++ b/drivers/net/wireguard/device.c
@@ -193,7 +193,7 @@ static netdev_tx_t wg_xmit(struct sk_buff *skb, struct net_device *dev)
 	 */
 	while (skb_queue_len(&peer->staged_packet_queue) > MAX_STAGED_PACKETS) {
 		dev_kfree_skb(__skb_dequeue(&peer->staged_packet_queue));
-		++dev->stats.tx_dropped;
+		DEV_STATS_INC(dev, tx_dropped);
 	}
 	skb_queue_splice_tail(&packets, &peer->staged_packet_queue);
 	spin_unlock_bh(&peer->staged_packet_queue.lock);
@@ -211,7 +211,7 @@ static netdev_tx_t wg_xmit(struct sk_buff *skb, struct net_device *dev)
 	else if (skb->protocol == htons(ETH_P_IPV6))
 		icmpv6_ndo_send(skb, ICMPV6_DEST_UNREACH, ICMPV6_ADDR_UNREACH, 0);
 err:
-	++dev->stats.tx_errors;
+	DEV_STATS_INC(dev, tx_errors);
 	kfree_skb(skb);
 	return ret;
 }
diff --git a/drivers/net/wireguard/receive.c b/drivers/net/wireguard/receive.c
index f500aaf67837..d38b24339a1f 100644
--- a/drivers/net/wireguard/receive.c
+++ b/drivers/net/wireguard/receive.c
@@ -423,20 +423,20 @@ static void wg_packet_consume_data_done(struct wg_peer *peer,
 	net_dbg_skb_ratelimited("%s: Packet has unallowed src IP (%pISc) from peer %llu (%pISpfsc)\n",
 				dev->name, skb, peer->internal_id,
 				&peer->endpoint.addr);
-	++dev->stats.rx_errors;
-	++dev->stats.rx_frame_errors;
+	DEV_STATS_INC(dev, rx_errors);
+	DEV_STATS_INC(dev, rx_frame_errors);
 	goto packet_processed;
 dishonest_packet_type:
 	net_dbg_ratelimited("%s: Packet is neither ipv4 nor ipv6 from peer %llu (%pISpfsc)\n",
 			    dev->name, peer->internal_id, &peer->endpoint.addr);
-	++dev->stats.rx_errors;
-	++dev->stats.rx_frame_errors;
+	DEV_STATS_INC(dev, rx_errors);
+	DEV_STATS_INC(dev, rx_frame_errors);
 	goto packet_processed;
 dishonest_packet_size:
 	net_dbg_ratelimited("%s: Packet has incorrect size from peer %llu (%pISpfsc)\n",
 			    dev->name, peer->internal_id, &peer->endpoint.addr);
-	++dev->stats.rx_errors;
-	++dev->stats.rx_length_errors;
+	DEV_STATS_INC(dev, rx_errors);
+	DEV_STATS_INC(dev, rx_length_errors);
 	goto packet_processed;
 packet_processed:
 	dev_kfree_skb(skb);
diff --git a/drivers/net/wireguard/send.c b/drivers/net/wireguard/send.c
index 95c853b59e1d..0d48e0f4a1ba 100644
--- a/drivers/net/wireguard/send.c
+++ b/drivers/net/wireguard/send.c
@@ -333,7 +333,8 @@ static void wg_packet_create_data(struct wg_peer *peer, struct sk_buff *first)
 void wg_packet_purge_staged_packets(struct wg_peer *peer)
 {
 	spin_lock_bh(&peer->staged_packet_queue.lock);
-	peer->device->dev->stats.tx_dropped += peer->staged_packet_queue.qlen;
+	DEV_STATS_ADD(peer->device->dev, tx_dropped,
+		      peer->staged_packet_queue.qlen);
 	__skb_queue_purge(&peer->staged_packet_queue);
 	spin_unlock_bh(&peer->staged_packet_queue.lock);
 }
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index a82a0796a614..59109eb8e8e4 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -1189,19 +1189,19 @@ static void nvmet_init_cap(struct nvmet_ctrl *ctrl)
 	ctrl->cap |= NVMET_QUEUE_SIZE - 1;
 }
 
-u16 nvmet_ctrl_find_get(const char *subsysnqn, const char *hostnqn, u16 cntlid,
-		struct nvmet_req *req, struct nvmet_ctrl **ret)
+struct nvmet_ctrl *nvmet_ctrl_find_get(const char *subsysnqn,
+				       const char *hostnqn, u16 cntlid,
+				       struct nvmet_req *req)
 {
+	struct nvmet_ctrl *ctrl = NULL;
 	struct nvmet_subsys *subsys;
-	struct nvmet_ctrl *ctrl;
-	u16 status = 0;
 
 	subsys = nvmet_find_get_subsys(req->port, subsysnqn);
 	if (!subsys) {
 		pr_warn("connect request for invalid subsystem %s!\n",
 			subsysnqn);
 		req->cqe->result.u32 = IPO_IATTR_CONNECT_DATA(subsysnqn);
-		return NVME_SC_CONNECT_INVALID_PARAM | NVME_SC_DNR;
+		goto out;
 	}
 
 	mutex_lock(&subsys->lock);
@@ -1214,20 +1214,21 @@ u16 nvmet_ctrl_find_get(const char *subsysnqn, const char *hostnqn, u16 cntlid,
 			if (!kref_get_unless_zero(&ctrl->ref))
 				continue;
 
-			*ret = ctrl;
-			goto out;
+			/* ctrl found */
+			goto found;
 		}
 	}
 
+	ctrl = NULL; /* ctrl not found */
 	pr_warn("could not find controller %d for subsys %s / host %s\n",
 		cntlid, subsysnqn, hostnqn);
 	req->cqe->result.u32 = IPO_IATTR_CONNECT_DATA(cntlid);
-	status = NVME_SC_CONNECT_INVALID_PARAM | NVME_SC_DNR;
 
-out:
+found:
 	mutex_unlock(&subsys->lock);
 	nvmet_subsys_put(subsys);
-	return status;
+out:
+	return ctrl;
 }
 
 u16 nvmet_check_ctrl_status(struct nvmet_req *req, struct nvme_command *cmd)
diff --git a/drivers/nvme/target/fabrics-cmd.c b/drivers/nvme/target/fabrics-cmd.c
index e62d3d0fa6c8..fb4f62982cb7 100644
--- a/drivers/nvme/target/fabrics-cmd.c
+++ b/drivers/nvme/target/fabrics-cmd.c
@@ -189,6 +189,8 @@ static void nvmet_execute_admin_connect(struct nvmet_req *req)
 		goto out;
 	}
 
+	d->subsysnqn[NVMF_NQN_FIELD_LEN - 1] = '\0';
+	d->hostnqn[NVMF_NQN_FIELD_LEN - 1] = '\0';
 	status = nvmet_alloc_ctrl(d->subsysnqn, d->hostnqn, req,
 				  le32_to_cpu(c->kato), &ctrl);
 	if (status) {
@@ -223,7 +225,7 @@ static void nvmet_execute_io_connect(struct nvmet_req *req)
 {
 	struct nvmf_connect_command *c = &req->cmd->connect;
 	struct nvmf_connect_data *d;
-	struct nvmet_ctrl *ctrl = NULL;
+	struct nvmet_ctrl *ctrl;
 	u16 qid = le16_to_cpu(c->qid);
 	u16 status = 0;
 
@@ -250,11 +252,14 @@ static void nvmet_execute_io_connect(struct nvmet_req *req)
 		goto out;
 	}
 
-	status = nvmet_ctrl_find_get(d->subsysnqn, d->hostnqn,
-				     le16_to_cpu(d->cntlid),
-				     req, &ctrl);
-	if (status)
+	d->subsysnqn[NVMF_NQN_FIELD_LEN - 1] = '\0';
+	d->hostnqn[NVMF_NQN_FIELD_LEN - 1] = '\0';
+	ctrl = nvmet_ctrl_find_get(d->subsysnqn, d->hostnqn,
+				   le16_to_cpu(d->cntlid), req);
+	if (!ctrl) {
+		status = NVME_SC_CONNECT_INVALID_PARAM | NVME_SC_DNR;
 		goto out;
+	}
 
 	if (unlikely(qid > ctrl->subsys->max_qid)) {
 		pr_warn("invalid queue id (%d)\n", qid);
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 4bf6d21290c2..ef162b64fabe 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -430,8 +430,9 @@ void nvmet_ctrl_fatal_error(struct nvmet_ctrl *ctrl);
 void nvmet_update_cc(struct nvmet_ctrl *ctrl, u32 new);
 u16 nvmet_alloc_ctrl(const char *subsysnqn, const char *hostnqn,
 		struct nvmet_req *req, u32 kato, struct nvmet_ctrl **ctrlp);
-u16 nvmet_ctrl_find_get(const char *subsysnqn, const char *hostnqn, u16 cntlid,
-		struct nvmet_req *req, struct nvmet_ctrl **ret);
+struct nvmet_ctrl *nvmet_ctrl_find_get(const char *subsysnqn,
+				       const char *hostnqn, u16 cntlid,
+				       struct nvmet_req *req);
 void nvmet_ctrl_put(struct nvmet_ctrl *ctrl);
 u16 nvmet_check_ctrl_status(struct nvmet_req *req, struct nvme_command *cmd);
 
diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index 5b722287aac9..afaea201a5af 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -865,8 +865,8 @@ static irqreturn_t ks_pcie_err_irq_handler(int irq, void *priv)
 	return ks_pcie_handle_error_irq(ks_pcie);
 }
 
-static int __init ks_pcie_add_pcie_port(struct keystone_pcie *ks_pcie,
-					struct platform_device *pdev)
+static int ks_pcie_add_pcie_port(struct keystone_pcie *ks_pcie,
+				 struct platform_device *pdev)
 {
 	struct dw_pcie *pci = ks_pcie->pci;
 	struct pcie_port *pp = &pci->pp;
@@ -978,8 +978,8 @@ static const struct dw_pcie_ep_ops ks_pcie_am654_ep_ops = {
 	.get_features = &ks_pcie_am654_get_features,
 };
 
-static int __init ks_pcie_add_pcie_ep(struct keystone_pcie *ks_pcie,
-				      struct platform_device *pdev)
+static int ks_pcie_add_pcie_ep(struct keystone_pcie *ks_pcie,
+			       struct platform_device *pdev)
 {
 	int ret;
 	struct dw_pcie_ep *ep;
diff --git a/drivers/pinctrl/core.c b/drivers/pinctrl/core.c
index 840000870d5a..4d5249436993 100644
--- a/drivers/pinctrl/core.c
+++ b/drivers/pinctrl/core.c
@@ -1239,17 +1239,17 @@ static void pinctrl_link_add(struct pinctrl_dev *pctldev,
 static int pinctrl_commit_state(struct pinctrl *p, struct pinctrl_state *state)
 {
 	struct pinctrl_setting *setting, *setting2;
-	struct pinctrl_state *old_state = p->state;
+	struct pinctrl_state *old_state = READ_ONCE(p->state);
 	int ret;
 
-	if (p->state) {
+	if (old_state) {
 		/*
 		 * For each pinmux setting in the old state, forget SW's record
 		 * of mux owner for that pingroup. Any pingroups which are
 		 * still owned by the new state will be re-acquired by the call
 		 * to pinmux_enable_setting() in the loop below.
 		 */
-		list_for_each_entry(setting, &p->state->settings, node) {
+		list_for_each_entry(setting, &old_state->settings, node) {
 			if (setting->type != PIN_MAP_TYPE_MUX_GROUP)
 				continue;
 			pinmux_disable_setting(setting);
diff --git a/drivers/s390/block/dasd.c b/drivers/s390/block/dasd.c
index 09e932a7b17f..81de5c98221a 100644
--- a/drivers/s390/block/dasd.c
+++ b/drivers/s390/block/dasd.c
@@ -737,18 +737,20 @@ static void dasd_profile_start(struct dasd_block *block,
 	 * we count each request only once.
 	 */
 	device = cqr->startdev;
-	if (device->profile.data) {
-		counter = 1; /* request is not yet queued on the start device */
-		list_for_each(l, &device->ccw_queue)
-			if (++counter >= 31)
-				break;
-	}
+	if (!device->profile.data)
+		return;
+
+	spin_lock(get_ccwdev_lock(device->cdev));
+	counter = 1; /* request is not yet queued on the start device */
+	list_for_each(l, &device->ccw_queue)
+		if (++counter >= 31)
+			break;
+	spin_unlock(get_ccwdev_lock(device->cdev));
+
 	spin_lock(&device->profile.lock);
-	if (device->profile.data) {
-		device->profile.data->dasd_io_nr_req[counter]++;
-		if (rq_data_dir(req) == READ)
-			device->profile.data->dasd_read_nr_req[counter]++;
-	}
+	device->profile.data->dasd_io_nr_req[counter]++;
+	if (rq_data_dir(req) == READ)
+		device->profile.data->dasd_read_nr_req[counter]++;
 	spin_unlock(&device->profile.lock);
 }
 
diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.c
index 8d199deaf3b1..0930bf996cd3 100644
--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -839,7 +839,7 @@ qla2xxx_queuecommand(struct Scsi_Host *host, struct scsi_cmnd *cmd)
 		uint16_t hwq;
 		struct qla_qpair *qpair = NULL;
 
-		tag = blk_mq_unique_tag(cmd->request);
+		tag = blk_mq_unique_tag(scsi_cmd_to_rq(cmd));
 		hwq = blk_mq_unique_tag_to_hwq(tag);
 		qpair = ha->queue_pair_map[hwq];
 
@@ -1714,8 +1714,16 @@ static void qla2x00_abort_srb(struct qla_qpair *qp, srb_t *sp, const int res,
 		}
 
 		spin_lock_irqsave(qp->qp_lock_ptr, *flags);
-		if (ret_cmd && blk_mq_request_started(cmd->request))
-			sp->done(sp, res);
+		switch (sp->type) {
+		case SRB_SCSI_CMD:
+			if (ret_cmd && blk_mq_request_started(scsi_cmd_to_rq(cmd)))
+				sp->done(sp, res);
+			break;
+		default:
+			if (ret_cmd)
+				sp->done(sp, res);
+			break;
+		}
 	} else {
 		sp->done(sp, res);
 	}
diff --git a/drivers/usb/core/config.c b/drivers/usb/core/config.c
index 39f1eca60a71..2f8a1225b697 100644
--- a/drivers/usb/core/config.c
+++ b/drivers/usb/core/config.c
@@ -61,7 +61,7 @@ static void usb_parse_ssp_isoc_endpoint_companion(struct device *ddev,
 	desc = (struct usb_ssp_isoc_ep_comp_descriptor *) buffer;
 	if (desc->bDescriptorType != USB_DT_SSP_ISOC_ENDPOINT_COMP ||
 	    size < USB_DT_SSP_ISOC_EP_COMP_SIZE) {
-		dev_warn(ddev, "Invalid SuperSpeedPlus isoc endpoint companion"
+		dev_notice(ddev, "Invalid SuperSpeedPlus isoc endpoint companion"
 			 "for config %d interface %d altsetting %d ep %d.\n",
 			 cfgno, inum, asnum, ep->desc.bEndpointAddress);
 		return;
@@ -83,7 +83,7 @@ static void usb_parse_ss_endpoint_companion(struct device *ddev, int cfgno,
 
 	if (desc->bDescriptorType != USB_DT_SS_ENDPOINT_COMP ||
 			size < USB_DT_SS_EP_COMP_SIZE) {
-		dev_warn(ddev, "No SuperSpeed endpoint companion for config %d "
+		dev_notice(ddev, "No SuperSpeed endpoint companion for config %d "
 				" interface %d altsetting %d ep %d: "
 				"using minimum values\n",
 				cfgno, inum, asnum, ep->desc.bEndpointAddress);
@@ -109,13 +109,13 @@ static void usb_parse_ss_endpoint_companion(struct device *ddev, int cfgno,
 
 	/* Check the various values */
 	if (usb_endpoint_xfer_control(&ep->desc) && desc->bMaxBurst != 0) {
-		dev_warn(ddev, "Control endpoint with bMaxBurst = %d in "
+		dev_notice(ddev, "Control endpoint with bMaxBurst = %d in "
 				"config %d interface %d altsetting %d ep %d: "
 				"setting to zero\n", desc->bMaxBurst,
 				cfgno, inum, asnum, ep->desc.bEndpointAddress);
 		ep->ss_ep_comp.bMaxBurst = 0;
 	} else if (desc->bMaxBurst > 15) {
-		dev_warn(ddev, "Endpoint with bMaxBurst = %d in "
+		dev_notice(ddev, "Endpoint with bMaxBurst = %d in "
 				"config %d interface %d altsetting %d ep %d: "
 				"setting to 15\n", desc->bMaxBurst,
 				cfgno, inum, asnum, ep->desc.bEndpointAddress);
@@ -125,7 +125,7 @@ static void usb_parse_ss_endpoint_companion(struct device *ddev, int cfgno,
 	if ((usb_endpoint_xfer_control(&ep->desc) ||
 			usb_endpoint_xfer_int(&ep->desc)) &&
 				desc->bmAttributes != 0) {
-		dev_warn(ddev, "%s endpoint with bmAttributes = %d in "
+		dev_notice(ddev, "%s endpoint with bmAttributes = %d in "
 				"config %d interface %d altsetting %d ep %d: "
 				"setting to zero\n",
 				usb_endpoint_xfer_control(&ep->desc) ? "Control" : "Bulk",
@@ -134,7 +134,7 @@ static void usb_parse_ss_endpoint_companion(struct device *ddev, int cfgno,
 		ep->ss_ep_comp.bmAttributes = 0;
 	} else if (usb_endpoint_xfer_bulk(&ep->desc) &&
 			desc->bmAttributes > 16) {
-		dev_warn(ddev, "Bulk endpoint with more than 65536 streams in "
+		dev_notice(ddev, "Bulk endpoint with more than 65536 streams in "
 				"config %d interface %d altsetting %d ep %d: "
 				"setting to max\n",
 				cfgno, inum, asnum, ep->desc.bEndpointAddress);
@@ -142,7 +142,7 @@ static void usb_parse_ss_endpoint_companion(struct device *ddev, int cfgno,
 	} else if (usb_endpoint_xfer_isoc(&ep->desc) &&
 		   !USB_SS_SSP_ISOC_COMP(desc->bmAttributes) &&
 		   USB_SS_MULT(desc->bmAttributes) > 3) {
-		dev_warn(ddev, "Isoc endpoint has Mult of %d in "
+		dev_notice(ddev, "Isoc endpoint has Mult of %d in "
 				"config %d interface %d altsetting %d ep %d: "
 				"setting to 3\n",
 				USB_SS_MULT(desc->bmAttributes),
@@ -160,7 +160,7 @@ static void usb_parse_ss_endpoint_companion(struct device *ddev, int cfgno,
 	else
 		max_tx = 999999;
 	if (le16_to_cpu(desc->wBytesPerInterval) > max_tx) {
-		dev_warn(ddev, "%s endpoint with wBytesPerInterval of %d in "
+		dev_notice(ddev, "%s endpoint with wBytesPerInterval of %d in "
 				"config %d interface %d altsetting %d ep %d: "
 				"setting to %d\n",
 				usb_endpoint_xfer_isoc(&ep->desc) ? "Isoc" : "Int",
@@ -273,7 +273,7 @@ static int usb_parse_endpoint(struct device *ddev, int cfgno,
 	else if (d->bLength >= USB_DT_ENDPOINT_SIZE)
 		n = USB_DT_ENDPOINT_SIZE;
 	else {
-		dev_warn(ddev, "config %d interface %d altsetting %d has an "
+		dev_notice(ddev, "config %d interface %d altsetting %d has an "
 		    "invalid endpoint descriptor of length %d, skipping\n",
 		    cfgno, inum, asnum, d->bLength);
 		goto skip_to_next_endpoint_or_interface_descriptor;
@@ -281,7 +281,7 @@ static int usb_parse_endpoint(struct device *ddev, int cfgno,
 
 	i = d->bEndpointAddress & ~USB_ENDPOINT_DIR_MASK;
 	if (i >= 16 || i == 0) {
-		dev_warn(ddev, "config %d interface %d altsetting %d has an "
+		dev_notice(ddev, "config %d interface %d altsetting %d has an "
 		    "invalid endpoint with address 0x%X, skipping\n",
 		    cfgno, inum, asnum, d->bEndpointAddress);
 		goto skip_to_next_endpoint_or_interface_descriptor;
@@ -293,7 +293,7 @@ static int usb_parse_endpoint(struct device *ddev, int cfgno,
 
 	/* Check for duplicate endpoint addresses */
 	if (config_endpoint_is_duplicate(config, inum, asnum, d)) {
-		dev_warn(ddev, "config %d interface %d altsetting %d has a duplicate endpoint with address 0x%X, skipping\n",
+		dev_notice(ddev, "config %d interface %d altsetting %d has a duplicate endpoint with address 0x%X, skipping\n",
 				cfgno, inum, asnum, d->bEndpointAddress);
 		goto skip_to_next_endpoint_or_interface_descriptor;
 	}
@@ -301,7 +301,7 @@ static int usb_parse_endpoint(struct device *ddev, int cfgno,
 	/* Ignore some endpoints */
 	if (udev->quirks & USB_QUIRK_ENDPOINT_IGNORE) {
 		if (usb_endpoint_is_ignored(udev, ifp, d)) {
-			dev_warn(ddev, "config %d interface %d altsetting %d has an ignored endpoint with address 0x%X, skipping\n",
+			dev_notice(ddev, "config %d interface %d altsetting %d has an ignored endpoint with address 0x%X, skipping\n",
 					cfgno, inum, asnum,
 					d->bEndpointAddress);
 			goto skip_to_next_endpoint_or_interface_descriptor;
@@ -378,7 +378,7 @@ static int usb_parse_endpoint(struct device *ddev, int cfgno,
 		}
 	}
 	if (d->bInterval < i || d->bInterval > j) {
-		dev_warn(ddev, "config %d interface %d altsetting %d "
+		dev_notice(ddev, "config %d interface %d altsetting %d "
 		    "endpoint 0x%X has an invalid bInterval %d, "
 		    "changing to %d\n",
 		    cfgno, inum, asnum,
@@ -391,7 +391,7 @@ static int usb_parse_endpoint(struct device *ddev, int cfgno,
 	 * them usable, we will try treating them as Interrupt endpoints.
 	 */
 	if (udev->speed == USB_SPEED_LOW && usb_endpoint_xfer_bulk(d)) {
-		dev_warn(ddev, "config %d interface %d altsetting %d "
+		dev_notice(ddev, "config %d interface %d altsetting %d "
 		    "endpoint 0x%X is Bulk; changing to Interrupt\n",
 		    cfgno, inum, asnum, d->bEndpointAddress);
 		endpoint->desc.bmAttributes = USB_ENDPOINT_XFER_INT;
@@ -408,7 +408,7 @@ static int usb_parse_endpoint(struct device *ddev, int cfgno,
 	 */
 	maxp = le16_to_cpu(endpoint->desc.wMaxPacketSize);
 	if (maxp == 0 && !(usb_endpoint_xfer_isoc(d) && asnum == 0)) {
-		dev_warn(ddev, "config %d interface %d altsetting %d endpoint 0x%X has invalid wMaxPacketSize 0\n",
+		dev_notice(ddev, "config %d interface %d altsetting %d endpoint 0x%X has invalid wMaxPacketSize 0\n",
 		    cfgno, inum, asnum, d->bEndpointAddress);
 	}
 
@@ -439,7 +439,7 @@ static int usb_parse_endpoint(struct device *ddev, int cfgno,
 	j = maxpacket_maxes[usb_endpoint_type(&endpoint->desc)];
 
 	if (maxp > j) {
-		dev_warn(ddev, "config %d interface %d altsetting %d endpoint 0x%X has invalid maxpacket %d, setting to %d\n",
+		dev_notice(ddev, "config %d interface %d altsetting %d endpoint 0x%X has invalid maxpacket %d, setting to %d\n",
 		    cfgno, inum, asnum, d->bEndpointAddress, maxp, j);
 		maxp = j;
 		endpoint->desc.wMaxPacketSize = cpu_to_le16(i | maxp);
@@ -452,7 +452,7 @@ static int usb_parse_endpoint(struct device *ddev, int cfgno,
 	 */
 	if (udev->speed == USB_SPEED_HIGH && usb_endpoint_xfer_bulk(d)) {
 		if (maxp != 512)
-			dev_warn(ddev, "config %d interface %d altsetting %d "
+			dev_notice(ddev, "config %d interface %d altsetting %d "
 				"bulk endpoint 0x%X has invalid maxpacket %d\n",
 				cfgno, inum, asnum, d->bEndpointAddress,
 				maxp);
@@ -533,7 +533,7 @@ static int usb_parse_interface(struct device *ddev, int cfgno,
 	      i < intfc->num_altsetting;
 	     (++i, ++alt)) {
 		if (alt->desc.bAlternateSetting == asnum) {
-			dev_warn(ddev, "Duplicate descriptor for config %d "
+			dev_notice(ddev, "Duplicate descriptor for config %d "
 			    "interface %d altsetting %d, skipping\n",
 			    cfgno, inum, asnum);
 			goto skip_to_next_interface_descriptor;
@@ -559,7 +559,7 @@ static int usb_parse_interface(struct device *ddev, int cfgno,
 	num_ep = num_ep_orig = alt->desc.bNumEndpoints;
 	alt->desc.bNumEndpoints = 0;		/* Use as a counter */
 	if (num_ep > USB_MAXENDPOINTS) {
-		dev_warn(ddev, "too many endpoints for config %d interface %d "
+		dev_notice(ddev, "too many endpoints for config %d interface %d "
 		    "altsetting %d: %d, using maximum allowed: %d\n",
 		    cfgno, inum, asnum, num_ep, USB_MAXENDPOINTS);
 		num_ep = USB_MAXENDPOINTS;
@@ -590,7 +590,7 @@ static int usb_parse_interface(struct device *ddev, int cfgno,
 	}
 
 	if (n != num_ep_orig)
-		dev_warn(ddev, "config %d interface %d altsetting %d has %d "
+		dev_notice(ddev, "config %d interface %d altsetting %d has %d "
 		    "endpoint descriptor%s, different from the interface "
 		    "descriptor's value: %d\n",
 		    cfgno, inum, asnum, n, plural(n), num_ep_orig);
@@ -625,7 +625,7 @@ static int usb_parse_configuration(struct usb_device *dev, int cfgidx,
 	if (config->desc.bDescriptorType != USB_DT_CONFIG ||
 	    config->desc.bLength < USB_DT_CONFIG_SIZE ||
 	    config->desc.bLength > size) {
-		dev_err(ddev, "invalid descriptor for config index %d: "
+		dev_notice(ddev, "invalid descriptor for config index %d: "
 		    "type = 0x%X, length = %d\n", cfgidx,
 		    config->desc.bDescriptorType, config->desc.bLength);
 		return -EINVAL;
@@ -636,7 +636,7 @@ static int usb_parse_configuration(struct usb_device *dev, int cfgidx,
 	size -= config->desc.bLength;
 
 	if (nintf > USB_MAXINTERFACES) {
-		dev_warn(ddev, "config %d has too many interfaces: %d, "
+		dev_notice(ddev, "config %d has too many interfaces: %d, "
 		    "using maximum allowed: %d\n",
 		    cfgno, nintf, USB_MAXINTERFACES);
 		nintf = USB_MAXINTERFACES;
@@ -650,7 +650,7 @@ static int usb_parse_configuration(struct usb_device *dev, int cfgidx,
 	     (buffer2 += header->bLength, size2 -= header->bLength)) {
 
 		if (size2 < sizeof(struct usb_descriptor_header)) {
-			dev_warn(ddev, "config %d descriptor has %d excess "
+			dev_notice(ddev, "config %d descriptor has %d excess "
 			    "byte%s, ignoring\n",
 			    cfgno, size2, plural(size2));
 			break;
@@ -658,7 +658,7 @@ static int usb_parse_configuration(struct usb_device *dev, int cfgidx,
 
 		header = (struct usb_descriptor_header *) buffer2;
 		if ((header->bLength > size2) || (header->bLength < 2)) {
-			dev_warn(ddev, "config %d has an invalid descriptor "
+			dev_notice(ddev, "config %d has an invalid descriptor "
 			    "of length %d, skipping remainder of the config\n",
 			    cfgno, header->bLength);
 			break;
@@ -670,7 +670,7 @@ static int usb_parse_configuration(struct usb_device *dev, int cfgidx,
 
 			d = (struct usb_interface_descriptor *) header;
 			if (d->bLength < USB_DT_INTERFACE_SIZE) {
-				dev_warn(ddev, "config %d has an invalid "
+				dev_notice(ddev, "config %d has an invalid "
 				    "interface descriptor of length %d, "
 				    "skipping\n", cfgno, d->bLength);
 				continue;
@@ -680,7 +680,7 @@ static int usb_parse_configuration(struct usb_device *dev, int cfgidx,
 
 			if ((dev->quirks & USB_QUIRK_HONOR_BNUMINTERFACES) &&
 			    n >= nintf_orig) {
-				dev_warn(ddev, "config %d has more interface "
+				dev_notice(ddev, "config %d has more interface "
 				    "descriptors, than it declares in "
 				    "bNumInterfaces, ignoring interface "
 				    "number: %d\n", cfgno, inum);
@@ -688,7 +688,7 @@ static int usb_parse_configuration(struct usb_device *dev, int cfgidx,
 			}
 
 			if (inum >= nintf_orig)
-				dev_warn(ddev, "config %d has an invalid "
+				dev_notice(ddev, "config %d has an invalid "
 				    "interface number: %d but max is %d\n",
 				    cfgno, inum, nintf_orig - 1);
 
@@ -713,14 +713,14 @@ static int usb_parse_configuration(struct usb_device *dev, int cfgidx,
 
 			d = (struct usb_interface_assoc_descriptor *)header;
 			if (d->bLength < USB_DT_INTERFACE_ASSOCIATION_SIZE) {
-				dev_warn(ddev,
+				dev_notice(ddev,
 					 "config %d has an invalid interface association descriptor of length %d, skipping\n",
 					 cfgno, d->bLength);
 				continue;
 			}
 
 			if (iad_num == USB_MAXIADS) {
-				dev_warn(ddev, "found more Interface "
+				dev_notice(ddev, "found more Interface "
 					       "Association Descriptors "
 					       "than allocated for in "
 					       "configuration %d\n", cfgno);
@@ -731,7 +731,7 @@ static int usb_parse_configuration(struct usb_device *dev, int cfgidx,
 
 		} else if (header->bDescriptorType == USB_DT_DEVICE ||
 			    header->bDescriptorType == USB_DT_CONFIG)
-			dev_warn(ddev, "config %d contains an unexpected "
+			dev_notice(ddev, "config %d contains an unexpected "
 			    "descriptor of type 0x%X, skipping\n",
 			    cfgno, header->bDescriptorType);
 
@@ -740,11 +740,11 @@ static int usb_parse_configuration(struct usb_device *dev, int cfgidx,
 	config->desc.wTotalLength = cpu_to_le16(buffer2 - buffer0);
 
 	if (n != nintf)
-		dev_warn(ddev, "config %d has %d interface%s, different from "
+		dev_notice(ddev, "config %d has %d interface%s, different from "
 		    "the descriptor's value: %d\n",
 		    cfgno, n, plural(n), nintf_orig);
 	else if (n == 0)
-		dev_warn(ddev, "config %d has no interfaces?\n", cfgno);
+		dev_notice(ddev, "config %d has no interfaces?\n", cfgno);
 	config->desc.bNumInterfaces = nintf = n;
 
 	/* Check for missing interface numbers */
@@ -754,7 +754,7 @@ static int usb_parse_configuration(struct usb_device *dev, int cfgidx,
 				break;
 		}
 		if (j >= nintf)
-			dev_warn(ddev, "config %d has no interface number "
+			dev_notice(ddev, "config %d has no interface number "
 			    "%d\n", cfgno, i);
 	}
 
@@ -762,7 +762,7 @@ static int usb_parse_configuration(struct usb_device *dev, int cfgidx,
 	for (i = 0; i < nintf; ++i) {
 		j = nalts[i];
 		if (j > USB_MAXALTSETTING) {
-			dev_warn(ddev, "too many alternate settings for "
+			dev_notice(ddev, "too many alternate settings for "
 			    "config %d interface %d: %d, "
 			    "using maximum allowed: %d\n",
 			    cfgno, inums[i], j, USB_MAXALTSETTING);
@@ -811,7 +811,7 @@ static int usb_parse_configuration(struct usb_device *dev, int cfgidx,
 					break;
 			}
 			if (n >= intfc->num_altsetting)
-				dev_warn(ddev, "config %d interface %d has no "
+				dev_notice(ddev, "config %d interface %d has no "
 				    "altsetting %d\n", cfgno, inums[i], j);
 		}
 	}
@@ -868,7 +868,7 @@ int usb_get_configuration(struct usb_device *dev)
 	int result;
 
 	if (ncfg > USB_MAXCONFIG) {
-		dev_warn(ddev, "too many configurations: %d, "
+		dev_notice(ddev, "too many configurations: %d, "
 		    "using maximum allowed: %d\n", ncfg, USB_MAXCONFIG);
 		dev->descriptor.bNumConfigurations = ncfg = USB_MAXCONFIG;
 	}
@@ -902,7 +902,7 @@ int usb_get_configuration(struct usb_device *dev)
 			    "descriptor/%s: %d\n", cfgno, "start", result);
 			if (result != -EPIPE)
 				goto err;
-			dev_err(ddev, "chopping to %d config(s)\n", cfgno);
+			dev_notice(ddev, "chopping to %d config(s)\n", cfgno);
 			dev->descriptor.bNumConfigurations = cfgno;
 			break;
 		} else if (result < 4) {
@@ -934,7 +934,7 @@ int usb_get_configuration(struct usb_device *dev)
 			goto err;
 		}
 		if (result < length) {
-			dev_warn(ddev, "config index %d descriptor too short "
+			dev_notice(ddev, "config index %d descriptor too short "
 			    "(expected %i, got %i)\n", cfgno, length, result);
 			length = result;
 		}
@@ -993,7 +993,7 @@ int usb_get_bos_descriptor(struct usb_device *dev)
 	/* Get BOS descriptor */
 	ret = usb_get_descriptor(dev, USB_DT_BOS, 0, bos, USB_DT_BOS_SIZE);
 	if (ret < USB_DT_BOS_SIZE || bos->bLength < USB_DT_BOS_SIZE) {
-		dev_err(ddev, "unable to get BOS descriptor or descriptor too short\n");
+		dev_notice(ddev, "unable to get BOS descriptor or descriptor too short\n");
 		if (ret >= 0)
 			ret = -ENOMSG;
 		kfree(bos);
@@ -1021,7 +1021,7 @@ int usb_get_bos_descriptor(struct usb_device *dev)
 
 	ret = usb_get_descriptor(dev, USB_DT_BOS, 0, buffer, total_len);
 	if (ret < total_len) {
-		dev_err(ddev, "unable to get BOS descriptor set\n");
+		dev_notice(ddev, "unable to get BOS descriptor set\n");
 		if (ret >= 0)
 			ret = -ENOMSG;
 		goto err;
@@ -1046,8 +1046,8 @@ int usb_get_bos_descriptor(struct usb_device *dev)
 		}
 
 		if (cap->bDescriptorType != USB_DT_DEVICE_CAPABILITY) {
-			dev_warn(ddev, "descriptor type invalid, skip\n");
-			continue;
+			dev_notice(ddev, "descriptor type invalid, skip\n");
+			goto skip_to_next_descriptor;
 		}
 
 		switch (cap_type) {
@@ -1080,6 +1080,7 @@ int usb_get_bos_descriptor(struct usb_device *dev)
 			break;
 		}
 
+skip_to_next_descriptor:
 		total_len -= length;
 		buffer += length;
 	}
diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index cfcd4f2ffffa..331f41c6cc75 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -2450,6 +2450,8 @@ static void set_usb_port_removable(struct usb_device *udev)
 	u16 wHubCharacteristics;
 	bool removable = true;
 
+	dev_set_removable(&udev->dev, DEVICE_REMOVABLE_UNKNOWN);
+
 	if (!hdev)
 		return;
 
@@ -2461,11 +2463,11 @@ static void set_usb_port_removable(struct usb_device *udev)
 	 */
 	switch (hub->ports[udev->portnum - 1]->connect_type) {
 	case USB_PORT_CONNECT_TYPE_HOT_PLUG:
-		udev->removable = USB_DEVICE_REMOVABLE;
+		dev_set_removable(&udev->dev, DEVICE_REMOVABLE);
 		return;
 	case USB_PORT_CONNECT_TYPE_HARD_WIRED:
 	case USB_PORT_NOT_USED:
-		udev->removable = USB_DEVICE_FIXED;
+		dev_set_removable(&udev->dev, DEVICE_FIXED);
 		return;
 	default:
 		break;
@@ -2490,9 +2492,9 @@ static void set_usb_port_removable(struct usb_device *udev)
 	}
 
 	if (removable)
-		udev->removable = USB_DEVICE_REMOVABLE;
+		dev_set_removable(&udev->dev, DEVICE_REMOVABLE);
 	else
-		udev->removable = USB_DEVICE_FIXED;
+		dev_set_removable(&udev->dev, DEVICE_FIXED);
 
 }
 
@@ -2564,8 +2566,7 @@ int usb_new_device(struct usb_device *udev)
 	device_enable_async_suspend(&udev->dev);
 
 	/* check whether the hub or firmware marks this port as non-removable */
-	if (udev->parent)
-		set_usb_port_removable(udev);
+	set_usb_port_removable(udev);
 
 	/* Register the device.  The device driver is responsible
 	 * for configuring the device and invoking the add-device
diff --git a/drivers/usb/core/sysfs.c b/drivers/usb/core/sysfs.c
index a2ca38e25e0c..35ce8b87e939 100644
--- a/drivers/usb/core/sysfs.c
+++ b/drivers/usb/core/sysfs.c
@@ -298,29 +298,6 @@ static ssize_t urbnum_show(struct device *dev, struct device_attribute *attr,
 }
 static DEVICE_ATTR_RO(urbnum);
 
-static ssize_t removable_show(struct device *dev, struct device_attribute *attr,
-			      char *buf)
-{
-	struct usb_device *udev;
-	char *state;
-
-	udev = to_usb_device(dev);
-
-	switch (udev->removable) {
-	case USB_DEVICE_REMOVABLE:
-		state = "removable";
-		break;
-	case USB_DEVICE_FIXED:
-		state = "fixed";
-		break;
-	default:
-		state = "unknown";
-	}
-
-	return sprintf(buf, "%s\n", state);
-}
-static DEVICE_ATTR_RO(removable);
-
 static ssize_t ltm_capable_show(struct device *dev,
 				struct device_attribute *attr, char *buf)
 {
@@ -825,7 +802,6 @@ static struct attribute *dev_attrs[] = {
 	&dev_attr_avoid_reset_quirk.attr,
 	&dev_attr_authorized.attr,
 	&dev_attr_remove.attr,
-	&dev_attr_removable.attr,
 	&dev_attr_ltm_capable.attr,
 #ifdef CONFIG_OF
 	&dev_attr_devspec.attr,
diff --git a/drivers/usb/dwc2/hcd_intr.c b/drivers/usb/dwc2/hcd_intr.c
index d5f4ec1b73b1..08e2792cb732 100644
--- a/drivers/usb/dwc2/hcd_intr.c
+++ b/drivers/usb/dwc2/hcd_intr.c
@@ -2045,15 +2045,17 @@ static void dwc2_hc_n_intr(struct dwc2_hsotg *hsotg, int chnum)
 {
 	struct dwc2_qtd *qtd;
 	struct dwc2_host_chan *chan;
-	u32 hcint, hcintmsk;
+	u32 hcint, hcintraw, hcintmsk;
 
 	chan = hsotg->hc_ptr_array[chnum];
 
-	hcint = dwc2_readl(hsotg, HCINT(chnum));
+	hcintraw = dwc2_readl(hsotg, HCINT(chnum));
 	hcintmsk = dwc2_readl(hsotg, HCINTMSK(chnum));
+	hcint = hcintraw & hcintmsk;
+	dwc2_writel(hsotg, hcint, HCINT(chnum));
+
 	if (!chan) {
 		dev_err(hsotg->dev, "## hc_ptr_array for channel is NULL ##\n");
-		dwc2_writel(hsotg, hcint, HCINT(chnum));
 		return;
 	}
 
@@ -2062,11 +2064,9 @@ static void dwc2_hc_n_intr(struct dwc2_hsotg *hsotg, int chnum)
 			 chnum);
 		dev_vdbg(hsotg->dev,
 			 "  hcint 0x%08x, hcintmsk 0x%08x, hcint&hcintmsk 0x%08x\n",
-			 hcint, hcintmsk, hcint & hcintmsk);
+			 hcintraw, hcintmsk, hcint);
 	}
 
-	dwc2_writel(hsotg, hcint, HCINT(chnum));
-
 	/*
 	 * If we got an interrupt after someone called
 	 * dwc2_hcd_endpoint_disable() we don't want to crash below
@@ -2076,8 +2076,7 @@ static void dwc2_hc_n_intr(struct dwc2_hsotg *hsotg, int chnum)
 		return;
 	}
 
-	chan->hcint = hcint;
-	hcint &= hcintmsk;
+	chan->hcint = hcintraw;
 
 	/*
 	 * If the channel was halted due to a dequeue, the qtd list might
diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 5bc245b4be44..214a8ff2d69c 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -1627,6 +1627,8 @@ static int dwc3_probe(struct platform_device *pdev)
 
 	pm_runtime_put(dev);
 
+	dma_set_max_seg_size(dev, UINT_MAX);
+
 	return 0;
 
 err5:
diff --git a/drivers/usb/dwc3/drd.c b/drivers/usb/dwc3/drd.c
index 0a96f44ccca7..8bcfbb29ce70 100644
--- a/drivers/usb/dwc3/drd.c
+++ b/drivers/usb/dwc3/drd.c
@@ -547,6 +547,7 @@ static int dwc3_setup_role_switch(struct dwc3 *dwc)
 		dwc->role_switch_default_mode = USB_DR_MODE_PERIPHERAL;
 		mode = DWC3_GCTL_PRTCAP_DEVICE;
 	}
+	dwc3_set_mode(dwc, mode);
 
 	dwc3_role_switch.fwnode = dev_fwnode(dwc->dev);
 	dwc3_role_switch.set = dwc3_usb_role_switch_set;
@@ -556,7 +557,6 @@ static int dwc3_setup_role_switch(struct dwc3 *dwc)
 	if (IS_ERR(dwc->role_sw))
 		return PTR_ERR(dwc->role_sw);
 
-	dwc3_set_mode(dwc, mode);
 	return 0;
 }
 #else
diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
index 3973f6c18857..db3559a10207 100644
--- a/drivers/usb/dwc3/dwc3-qcom.c
+++ b/drivers/usb/dwc3/dwc3-qcom.c
@@ -492,7 +492,7 @@ static int dwc3_qcom_setup_irq(struct platform_device *pdev)
 		irq_set_status_flags(irq, IRQ_NOAUTOEN);
 		ret = devm_request_threaded_irq(qcom->dev, irq, NULL,
 					qcom_dwc3_resume_irq,
-					IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
+					IRQF_ONESHOT,
 					"qcom_dwc3 HS", qcom);
 		if (ret) {
 			dev_err(qcom->dev, "hs_phy_irq failed: %d\n", ret);
@@ -507,7 +507,7 @@ static int dwc3_qcom_setup_irq(struct platform_device *pdev)
 		irq_set_status_flags(irq, IRQ_NOAUTOEN);
 		ret = devm_request_threaded_irq(qcom->dev, irq, NULL,
 					qcom_dwc3_resume_irq,
-					IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
+					IRQF_ONESHOT,
 					"qcom_dwc3 DP_HS", qcom);
 		if (ret) {
 			dev_err(qcom->dev, "dp_hs_phy_irq failed: %d\n", ret);
@@ -522,7 +522,7 @@ static int dwc3_qcom_setup_irq(struct platform_device *pdev)
 		irq_set_status_flags(irq, IRQ_NOAUTOEN);
 		ret = devm_request_threaded_irq(qcom->dev, irq, NULL,
 					qcom_dwc3_resume_irq,
-					IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
+					IRQF_ONESHOT,
 					"qcom_dwc3 DM_HS", qcom);
 		if (ret) {
 			dev_err(qcom->dev, "dm_hs_phy_irq failed: %d\n", ret);
@@ -537,7 +537,7 @@ static int dwc3_qcom_setup_irq(struct platform_device *pdev)
 		irq_set_status_flags(irq, IRQ_NOAUTOEN);
 		ret = devm_request_threaded_irq(qcom->dev, irq, NULL,
 					qcom_dwc3_resume_irq,
-					IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
+					IRQF_ONESHOT,
 					"qcom_dwc3 SS", qcom);
 		if (ret) {
 			dev_err(qcom->dev, "ss_phy_irq failed: %d\n", ret);
@@ -690,6 +690,7 @@ static int dwc3_qcom_of_register_core(struct platform_device *pdev)
 	if (!qcom->dwc3) {
 		ret = -ENODEV;
 		dev_err(dev, "failed to get dwc3 platform device\n");
+		of_platform_depopulate(dev);
 	}
 
 node_put:
@@ -698,9 +699,9 @@ static int dwc3_qcom_of_register_core(struct platform_device *pdev)
 	return ret;
 }
 
-static struct platform_device *
-dwc3_qcom_create_urs_usb_platdev(struct device *dev)
+static struct platform_device *dwc3_qcom_create_urs_usb_platdev(struct device *dev)
 {
+	struct platform_device *urs_usb = NULL;
 	struct fwnode_handle *fwh;
 	struct acpi_device *adev;
 	char name[8];
@@ -720,9 +721,26 @@ dwc3_qcom_create_urs_usb_platdev(struct device *dev)
 
 	adev = to_acpi_device_node(fwh);
 	if (!adev)
-		return NULL;
+		goto err_put_handle;
+
+	urs_usb = acpi_create_platform_device(adev, NULL);
+	if (IS_ERR_OR_NULL(urs_usb))
+		goto err_put_handle;
+
+	return urs_usb;
+
+err_put_handle:
+	fwnode_handle_put(fwh);
+
+	return urs_usb;
+}
+
+static void dwc3_qcom_destroy_urs_usb_platdev(struct platform_device *urs_usb)
+{
+	struct fwnode_handle *fwh = urs_usb->dev.fwnode;
 
-	return acpi_create_platform_device(adev, NULL);
+	platform_device_unregister(urs_usb);
+	fwnode_handle_put(fwh);
 }
 
 static int dwc3_qcom_probe(struct platform_device *pdev)
@@ -807,13 +825,13 @@ static int dwc3_qcom_probe(struct platform_device *pdev)
 	if (IS_ERR(qcom->qscratch_base)) {
 		dev_err(dev, "failed to map qscratch, err=%d\n", ret);
 		ret = PTR_ERR(qcom->qscratch_base);
-		goto clk_disable;
+		goto free_urs;
 	}
 
 	ret = dwc3_qcom_setup_irq(pdev);
 	if (ret) {
 		dev_err(dev, "failed to setup IRQs, err=%d\n", ret);
-		goto clk_disable;
+		goto free_urs;
 	}
 
 	/*
@@ -832,7 +850,7 @@ static int dwc3_qcom_probe(struct platform_device *pdev)
 
 	if (ret) {
 		dev_err(dev, "failed to register DWC3 Core, err=%d\n", ret);
-		goto depopulate;
+		goto free_urs;
 	}
 
 	ret = dwc3_qcom_interconnect_init(qcom);
@@ -864,7 +882,11 @@ static int dwc3_qcom_probe(struct platform_device *pdev)
 	if (np)
 		of_platform_depopulate(&pdev->dev);
 	else
-		platform_device_put(pdev);
+		platform_device_del(qcom->dwc3);
+	platform_device_put(qcom->dwc3);
+free_urs:
+	if (qcom->urs_usb)
+		dwc3_qcom_destroy_urs_usb_platdev(qcom->urs_usb);
 clk_disable:
 	for (i = qcom->num_clocks - 1; i >= 0; i--) {
 		clk_disable_unprepare(qcom->clks[i]);
@@ -886,7 +908,11 @@ static int dwc3_qcom_remove(struct platform_device *pdev)
 	if (np)
 		of_platform_depopulate(&pdev->dev);
 	else
-		platform_device_put(pdev);
+		platform_device_del(qcom->dwc3);
+	platform_device_put(qcom->dwc3);
+
+	if (qcom->urs_usb)
+		dwc3_qcom_destroy_urs_usb_platdev(qcom->urs_usb);
 
 	for (i = qcom->num_clocks - 1; i >= 0; i--) {
 		clk_disable_unprepare(qcom->clks[i]);
diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
index 3e0579d6ec82..851c24253940 100644
--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -203,8 +203,8 @@ static void option_instat_callback(struct urb *urb);
 #define DELL_PRODUCT_5829E_ESIM			0x81e4
 #define DELL_PRODUCT_5829E			0x81e6
 
-#define DELL_PRODUCT_FM101R			0x8213
-#define DELL_PRODUCT_FM101R_ESIM		0x8215
+#define DELL_PRODUCT_FM101R_ESIM		0x8213
+#define DELL_PRODUCT_FM101R			0x8215
 
 #define KYOCERA_VENDOR_ID			0x0c88
 #define KYOCERA_PRODUCT_KPC650			0x17da
@@ -609,6 +609,8 @@ static void option_instat_callback(struct urb *urb);
 #define UNISOC_VENDOR_ID			0x1782
 /* TOZED LT70-C based on UNISOC SL8563 uses UNISOC's vendor ID */
 #define TOZED_PRODUCT_LT70C			0x4055
+/* Luat Air72*U series based on UNISOC UIS8910 uses UNISOC's vendor ID */
+#define LUAT_PRODUCT_AIR720U			0x4e00
 
 /* Device flags */
 
@@ -1546,7 +1548,8 @@ static const struct usb_device_id option_ids[] = {
 	{ USB_DEVICE_AND_INTERFACE_INFO(ZTE_VENDOR_ID, 0x0165, 0xff, 0xff, 0xff) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(ZTE_VENDOR_ID, 0x0167, 0xff, 0xff, 0xff),
 	  .driver_info = RSVD(4) },
-	{ USB_DEVICE_AND_INTERFACE_INFO(ZTE_VENDOR_ID, 0x0189, 0xff, 0xff, 0xff) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(ZTE_VENDOR_ID, 0x0189, 0xff, 0xff, 0xff),
+	  .driver_info = RSVD(4) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(ZTE_VENDOR_ID, 0x0191, 0xff, 0xff, 0xff), /* ZTE EuFi890 */
 	  .driver_info = RSVD(4) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(ZTE_VENDOR_ID, 0x0196, 0xff, 0xff, 0xff) },
@@ -2249,6 +2252,7 @@ static const struct usb_device_id option_ids[] = {
 	  .driver_info = RSVD(4) | RSVD(5) | RSVD(6) },
 	{ USB_DEVICE(0x1782, 0x4d10) },						/* Fibocom L610 (AT mode) */
 	{ USB_DEVICE_INTERFACE_CLASS(0x1782, 0x4d11, 0xff) },			/* Fibocom L610 (ECM/RNDIS mode) */
+	{ USB_DEVICE_AND_INTERFACE_INFO(0x2cb7, 0x0001, 0xff, 0xff, 0xff) },	/* Fibocom L716-EU (ECM/RNDIS mode) */
 	{ USB_DEVICE(0x2cb7, 0x0104),						/* Fibocom NL678 series */
 	  .driver_info = RSVD(4) | RSVD(5) },
 	{ USB_DEVICE_INTERFACE_CLASS(0x2cb7, 0x0105, 0xff),			/* Fibocom NL678 series */
@@ -2271,6 +2275,7 @@ static const struct usb_device_id option_ids[] = {
 	{ USB_DEVICE_AND_INTERFACE_INFO(SIERRA_VENDOR_ID, SIERRA_PRODUCT_EM9191, 0xff, 0xff, 0x40) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(SIERRA_VENDOR_ID, SIERRA_PRODUCT_EM9191, 0xff, 0, 0) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(UNISOC_VENDOR_ID, TOZED_PRODUCT_LT70C, 0xff, 0, 0) },
+	{ USB_DEVICE_AND_INTERFACE_INFO(UNISOC_VENDOR_ID, LUAT_PRODUCT_AIR720U, 0xff, 0, 0) },
 	{ } /* Terminating entry */
 };
 MODULE_DEVICE_TABLE(usb, option_ids);
diff --git a/drivers/video/fbdev/sticore.h b/drivers/video/fbdev/sticore.h
index 0ebdd28a0b81..d83ab3ded5f3 100644
--- a/drivers/video/fbdev/sticore.h
+++ b/drivers/video/fbdev/sticore.h
@@ -231,7 +231,7 @@ struct sti_rom_font {
 	 u8 height;
 	 u8 font_type;		/* language type */
 	 u8 bytes_per_char;
-	u32 next_font;
+	s32 next_font;		/* note: signed int */
 	 u8 underline_height;
 	 u8 underline_pos;
 	 u8 res008[2];
diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
index 2b385c1b4a99..ad3ee4857e15 100644
--- a/drivers/xen/swiotlb-xen.c
+++ b/drivers/xen/swiotlb-xen.c
@@ -579,4 +579,5 @@ const struct dma_map_ops xen_swiotlb_dma_ops = {
 	.get_sgtable = dma_common_get_sgtable,
 	.alloc_pages = dma_common_alloc_pages,
 	.free_pages = dma_common_free_pages,
+	.max_mapping_size = swiotlb_max_mapping_size,
 };
diff --git a/fs/afs/dynroot.c b/fs/afs/dynroot.c
index db832cc931c8..b35c6081dbfe 100644
--- a/fs/afs/dynroot.c
+++ b/fs/afs/dynroot.c
@@ -131,8 +131,8 @@ static int afs_probe_cell_name(struct dentry *dentry)
 
 	ret = dns_query(net->net, "afsdb", name, len, "srv=1",
 			NULL, NULL, false);
-	if (ret == -ENODATA)
-		ret = -EDESTADDRREQ;
+	if (ret == -ENODATA || ret == -ENOKEY)
+		ret = -ENOENT;
 	return ret;
 }
 
diff --git a/fs/afs/internal.h b/fs/afs/internal.h
index 637cbe549397..31c7a562147c 100644
--- a/fs/afs/internal.h
+++ b/fs/afs/internal.h
@@ -546,6 +546,7 @@ struct afs_server_entry {
 };
 
 struct afs_server_list {
+	struct rcu_head		rcu;
 	afs_volid_t		vids[AFS_MAXTYPES]; /* Volume IDs */
 	refcount_t		usage;
 	unsigned char		nr_servers;
diff --git a/fs/afs/server_list.c b/fs/afs/server_list.c
index ed9056703505..b59896b1de0a 100644
--- a/fs/afs/server_list.c
+++ b/fs/afs/server_list.c
@@ -17,7 +17,7 @@ void afs_put_serverlist(struct afs_net *net, struct afs_server_list *slist)
 		for (i = 0; i < slist->nr_servers; i++)
 			afs_unuse_server(net, slist->servers[i].server,
 					 afs_server_trace_put_slist);
-		kfree(slist);
+		kfree_rcu(slist, rcu);
 	}
 }
 
diff --git a/fs/afs/super.c b/fs/afs/super.c
index e38bb1e7a4d2..1b62a99b3673 100644
--- a/fs/afs/super.c
+++ b/fs/afs/super.c
@@ -406,6 +406,8 @@ static int afs_validate_fc(struct fs_context *fc)
 			return PTR_ERR(volume);
 
 		ctx->volume = volume;
+		if (volume->type != AFSVL_RWVOL)
+			ctx->flock_mode = afs_flock_mode_local;
 	}
 
 	return 0;
diff --git a/fs/afs/vl_rotate.c b/fs/afs/vl_rotate.c
index 488e58490b16..eb415ce56360 100644
--- a/fs/afs/vl_rotate.c
+++ b/fs/afs/vl_rotate.c
@@ -58,6 +58,12 @@ static bool afs_start_vl_iteration(struct afs_vl_cursor *vc)
 		}
 
 		/* Status load is ordered after lookup counter load */
+		if (cell->dns_status == DNS_LOOKUP_GOT_NOT_FOUND) {
+			pr_warn("No record of cell %s\n", cell->name);
+			vc->error = -ENOENT;
+			return false;
+		}
+
 		if (cell->dns_source == DNS_RECORD_UNAVAILABLE) {
 			vc->error = -EDESTADDRREQ;
 			return false;
@@ -285,6 +291,7 @@ bool afs_select_vlserver(struct afs_vl_cursor *vc)
  */
 static void afs_vl_dump_edestaddrreq(const struct afs_vl_cursor *vc)
 {
+	struct afs_cell *cell = vc->cell;
 	static int count;
 	int i;
 
@@ -294,6 +301,9 @@ static void afs_vl_dump_edestaddrreq(const struct afs_vl_cursor *vc)
 
 	rcu_read_lock();
 	pr_notice("EDESTADDR occurred\n");
+	pr_notice("CELL: %s err=%d\n", cell->name, cell->error);
+	pr_notice("DNS: src=%u st=%u lc=%x\n",
+		  cell->dns_source, cell->dns_status, cell->dns_lookup_count);
 	pr_notice("VC: ut=%lx ix=%u ni=%hu fl=%hx err=%hd\n",
 		  vc->untried, vc->index, vc->nr_iterations, vc->flags, vc->error);
 
diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 0e25a3f64b2e..cd689d5c4c82 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2972,6 +2972,7 @@ int __cold open_ctree(struct super_block *sb, struct btrfs_fs_devices *fs_device
 		goto fail_alloc;
 	}
 
+	btrfs_info(fs_info, "first mount of filesystem %pU", disk_super->fsid);
 	/*
 	 * Verify the type first, if that or the checksum value are
 	 * corrupted, we'll find out
diff --git a/fs/btrfs/ref-verify.c b/fs/btrfs/ref-verify.c
index 78693d3dd15b..bd3bb94cc56b 100644
--- a/fs/btrfs/ref-verify.c
+++ b/fs/btrfs/ref-verify.c
@@ -804,6 +804,7 @@ int btrfs_ref_tree_mod(struct btrfs_fs_info *fs_info,
 			dump_ref_action(fs_info, ra);
 			kfree(ref);
 			kfree(ra);
+			kfree(re);
 			goto out_unlock;
 		} else if (be->num_refs == 0) {
 			btrfs_err(fs_info,
@@ -813,6 +814,7 @@ int btrfs_ref_tree_mod(struct btrfs_fs_info *fs_info,
 			dump_ref_action(fs_info, ra);
 			kfree(ref);
 			kfree(ra);
+			kfree(re);
 			goto out_unlock;
 		}
 
diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index b081b61e97c8..af9701afcab7 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -7303,7 +7303,7 @@ long btrfs_ioctl_send(struct file *mnt_file, struct btrfs_ioctl_send_args *arg)
 	sctx->flags = arg->flags;
 
 	sctx->send_filp = fget(arg->send_fd);
-	if (!sctx->send_filp) {
+	if (!sctx->send_filp || !(sctx->send_filp->f_mode & FMODE_WRITE)) {
 		ret = -EBADF;
 		goto out;
 	}
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index ea731fa8bd35..fd4edd966450 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -318,7 +318,10 @@ void __btrfs_panic(struct btrfs_fs_info *fs_info, const char *function,
 
 static void btrfs_put_super(struct super_block *sb)
 {
-	close_ctree(btrfs_sb(sb));
+	struct btrfs_fs_info *fs_info = btrfs_sb(sb);
+
+	btrfs_info(fs_info, "last unmount of filesystem %pU", fs_info->fs_devices->fsid);
+	close_ctree(fs_info);
 }
 
 enum {
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index 86c50e0570a5..eaf5cd043dac 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -2993,15 +2993,16 @@ struct extent_map *btrfs_get_chunk_map(struct btrfs_fs_info *fs_info,
 	read_unlock(&em_tree->lock);
 
 	if (!em) {
-		btrfs_crit(fs_info, "unable to find logical %llu length %llu",
+		btrfs_crit(fs_info,
+			   "unable to find chunk map for logical %llu length %llu",
 			   logical, length);
 		return ERR_PTR(-EINVAL);
 	}
 
-	if (em->start > logical || em->start + em->len < logical) {
+	if (em->start > logical || em->start + em->len <= logical) {
 		btrfs_crit(fs_info,
-			   "found a bad mapping, wanted %llu-%llu, found %llu-%llu",
-			   logical, length, em->start, em->start + em->len);
+			   "found a bad chunk map, wanted %llu-%llu, found %llu-%llu",
+			   logical, logical + length, em->start, em->start + em->len);
 		free_extent_map(em);
 		return ERR_PTR(-EINVAL);
 	}
diff --git a/fs/cifs/cifsfs.c b/fs/cifs/cifsfs.c
index 0d8d7b57636f..b87d6792b14a 100644
--- a/fs/cifs/cifsfs.c
+++ b/fs/cifs/cifsfs.c
@@ -1076,6 +1076,7 @@ const struct inode_operations cifs_file_inode_ops = {
 
 const struct inode_operations cifs_symlink_inode_ops = {
 	.get_link = cifs_get_link,
+	.setattr = cifs_setattr,
 	.permission = cifs_permission,
 	.listxattr = cifs_listxattr,
 };
diff --git a/fs/cifs/xattr.c b/fs/cifs/xattr.c
index b8299173ea7e..c6931eab3f97 100644
--- a/fs/cifs/xattr.c
+++ b/fs/cifs/xattr.c
@@ -157,10 +157,13 @@ static int cifs_xattr_set(const struct xattr_handler *handler,
 		if (cifs_sb->mnt_cifs_flags & CIFS_MOUNT_NO_XATTR)
 			goto out;
 
-		if (pTcon->ses->server->ops->set_EA)
+		if (pTcon->ses->server->ops->set_EA) {
 			rc = pTcon->ses->server->ops->set_EA(xid, pTcon,
 				full_path, name, value, (__u16)size,
 				cifs_sb->local_nls, cifs_sb);
+			if (rc == 0)
+				inode_set_ctime_current(inode);
+		}
 		break;
 
 	case XATTR_CIFS_ACL:
diff --git a/fs/ext4/extents_status.c b/fs/ext4/extents_status.c
index 7806adcc41a7..cccbdfd49a86 100644
--- a/fs/ext4/extents_status.c
+++ b/fs/ext4/extents_status.c
@@ -144,14 +144,17 @@
 static struct kmem_cache *ext4_es_cachep;
 static struct kmem_cache *ext4_pending_cachep;
 
-static int __es_insert_extent(struct inode *inode, struct extent_status *newes);
+static int __es_insert_extent(struct inode *inode, struct extent_status *newes,
+			      struct extent_status *prealloc);
 static int __es_remove_extent(struct inode *inode, ext4_lblk_t lblk,
-			      ext4_lblk_t end, int *reserved);
+			      ext4_lblk_t end, int *reserved,
+			      struct extent_status *prealloc);
 static int es_reclaim_extents(struct ext4_inode_info *ei, int *nr_to_scan);
 static int __es_shrink(struct ext4_sb_info *sbi, int nr_to_scan,
 		       struct ext4_inode_info *locked_ei);
-static void __revise_pending(struct inode *inode, ext4_lblk_t lblk,
-			     ext4_lblk_t len);
+static int __revise_pending(struct inode *inode, ext4_lblk_t lblk,
+			    ext4_lblk_t len,
+			    struct pending_reservation **prealloc);
 
 int __init ext4_init_es(void)
 {
@@ -448,22 +451,49 @@ static void ext4_es_list_del(struct inode *inode)
 	spin_unlock(&sbi->s_es_lock);
 }
 
-static struct extent_status *
-ext4_es_alloc_extent(struct inode *inode, ext4_lblk_t lblk, ext4_lblk_t len,
-		     ext4_fsblk_t pblk)
+static inline struct pending_reservation *__alloc_pending(bool nofail)
+{
+	if (!nofail)
+		return kmem_cache_alloc(ext4_pending_cachep, GFP_ATOMIC);
+
+	return kmem_cache_zalloc(ext4_pending_cachep, GFP_KERNEL | __GFP_NOFAIL);
+}
+
+static inline void __free_pending(struct pending_reservation *pr)
+{
+	kmem_cache_free(ext4_pending_cachep, pr);
+}
+
+/*
+ * Returns true if we cannot fail to allocate memory for this extent_status
+ * entry and cannot reclaim it until its status changes.
+ */
+static inline bool ext4_es_must_keep(struct extent_status *es)
+{
+	/* fiemap, bigalloc, and seek_data/hole need to use it. */
+	if (ext4_es_is_delayed(es))
+		return true;
+
+	return false;
+}
+
+static inline struct extent_status *__es_alloc_extent(bool nofail)
+{
+	if (!nofail)
+		return kmem_cache_alloc(ext4_es_cachep, GFP_ATOMIC);
+
+	return kmem_cache_zalloc(ext4_es_cachep, GFP_KERNEL | __GFP_NOFAIL);
+}
+
+static void ext4_es_init_extent(struct inode *inode, struct extent_status *es,
+		ext4_lblk_t lblk, ext4_lblk_t len, ext4_fsblk_t pblk)
 {
-	struct extent_status *es;
-	es = kmem_cache_alloc(ext4_es_cachep, GFP_ATOMIC);
-	if (es == NULL)
-		return NULL;
 	es->es_lblk = lblk;
 	es->es_len = len;
 	es->es_pblk = pblk;
 
-	/*
-	 * We don't count delayed extent because we never try to reclaim them
-	 */
-	if (!ext4_es_is_delayed(es)) {
+	/* We never try to reclaim a must kept extent, so we don't count it. */
+	if (!ext4_es_must_keep(es)) {
 		if (!EXT4_I(inode)->i_es_shk_nr++)
 			ext4_es_list_add(inode);
 		percpu_counter_inc(&EXT4_SB(inode->i_sb)->
@@ -472,8 +502,11 @@ ext4_es_alloc_extent(struct inode *inode, ext4_lblk_t lblk, ext4_lblk_t len,
 
 	EXT4_I(inode)->i_es_all_nr++;
 	percpu_counter_inc(&EXT4_SB(inode->i_sb)->s_es_stats.es_stats_all_cnt);
+}
 
-	return es;
+static inline void __es_free_extent(struct extent_status *es)
+{
+	kmem_cache_free(ext4_es_cachep, es);
 }
 
 static void ext4_es_free_extent(struct inode *inode, struct extent_status *es)
@@ -481,8 +514,8 @@ static void ext4_es_free_extent(struct inode *inode, struct extent_status *es)
 	EXT4_I(inode)->i_es_all_nr--;
 	percpu_counter_dec(&EXT4_SB(inode->i_sb)->s_es_stats.es_stats_all_cnt);
 
-	/* Decrease the shrink counter when this es is not delayed */
-	if (!ext4_es_is_delayed(es)) {
+	/* Decrease the shrink counter when we can reclaim the extent. */
+	if (!ext4_es_must_keep(es)) {
 		BUG_ON(EXT4_I(inode)->i_es_shk_nr == 0);
 		if (!--EXT4_I(inode)->i_es_shk_nr)
 			ext4_es_list_del(inode);
@@ -490,7 +523,7 @@ static void ext4_es_free_extent(struct inode *inode, struct extent_status *es)
 					s_es_stats.es_stats_shk_cnt);
 	}
 
-	kmem_cache_free(ext4_es_cachep, es);
+	__es_free_extent(es);
 }
 
 /*
@@ -752,7 +785,8 @@ static inline void ext4_es_insert_extent_check(struct inode *inode,
 }
 #endif
 
-static int __es_insert_extent(struct inode *inode, struct extent_status *newes)
+static int __es_insert_extent(struct inode *inode, struct extent_status *newes,
+			      struct extent_status *prealloc)
 {
 	struct ext4_es_tree *tree = &EXT4_I(inode)->i_es_tree;
 	struct rb_node **p = &tree->root.rb_node;
@@ -792,10 +826,15 @@ static int __es_insert_extent(struct inode *inode, struct extent_status *newes)
 		}
 	}
 
-	es = ext4_es_alloc_extent(inode, newes->es_lblk, newes->es_len,
-				  newes->es_pblk);
+	if (prealloc)
+		es = prealloc;
+	else
+		es = __es_alloc_extent(false);
 	if (!es)
 		return -ENOMEM;
+	ext4_es_init_extent(inode, es, newes->es_lblk, newes->es_len,
+			    newes->es_pblk);
+
 	rb_link_node(&es->rb_node, parent, p);
 	rb_insert_color(&es->rb_node, &tree->root);
 
@@ -816,8 +855,12 @@ int ext4_es_insert_extent(struct inode *inode, ext4_lblk_t lblk,
 {
 	struct extent_status newes;
 	ext4_lblk_t end = lblk + len - 1;
-	int err = 0;
+	int err1 = 0, err2 = 0, err3 = 0;
 	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
+	struct extent_status *es1 = NULL;
+	struct extent_status *es2 = NULL;
+	struct pending_reservation *pr = NULL;
+	bool revise_pending = false;
 
 	if (EXT4_SB(inode->i_sb)->s_mount_state & EXT4_FC_REPLAY)
 		return 0;
@@ -845,29 +888,57 @@ int ext4_es_insert_extent(struct inode *inode, ext4_lblk_t lblk,
 
 	ext4_es_insert_extent_check(inode, &newes);
 
+	revise_pending = sbi->s_cluster_ratio > 1 &&
+			 test_opt(inode->i_sb, DELALLOC) &&
+			 (status & (EXTENT_STATUS_WRITTEN |
+				    EXTENT_STATUS_UNWRITTEN));
+retry:
+	if (err1 && !es1)
+		es1 = __es_alloc_extent(true);
+	if ((err1 || err2) && !es2)
+		es2 = __es_alloc_extent(true);
+	if ((err1 || err2 || err3) && revise_pending && !pr)
+		pr = __alloc_pending(true);
 	write_lock(&EXT4_I(inode)->i_es_lock);
-	err = __es_remove_extent(inode, lblk, end, NULL);
-	if (err != 0)
+
+	err1 = __es_remove_extent(inode, lblk, end, NULL, es1);
+	if (err1 != 0)
 		goto error;
-retry:
-	err = __es_insert_extent(inode, &newes);
-	if (err == -ENOMEM && __es_shrink(EXT4_SB(inode->i_sb),
-					  128, EXT4_I(inode)))
-		goto retry;
-	if (err == -ENOMEM && !ext4_es_is_delayed(&newes))
-		err = 0;
+	/* Free preallocated extent if it didn't get used. */
+	if (es1) {
+		if (!es1->es_len)
+			__es_free_extent(es1);
+		es1 = NULL;
+	}
 
-	if (sbi->s_cluster_ratio > 1 && test_opt(inode->i_sb, DELALLOC) &&
-	    (status & EXTENT_STATUS_WRITTEN ||
-	     status & EXTENT_STATUS_UNWRITTEN))
-		__revise_pending(inode, lblk, len);
+	err2 = __es_insert_extent(inode, &newes, es2);
+	if (err2 == -ENOMEM && !ext4_es_must_keep(&newes))
+		err2 = 0;
+	if (err2 != 0)
+		goto error;
+	/* Free preallocated extent if it didn't get used. */
+	if (es2) {
+		if (!es2->es_len)
+			__es_free_extent(es2);
+		es2 = NULL;
+	}
 
+	if (revise_pending) {
+		err3 = __revise_pending(inode, lblk, len, &pr);
+		if (err3 != 0)
+			goto error;
+		if (pr) {
+			__free_pending(pr);
+			pr = NULL;
+		}
+	}
 error:
 	write_unlock(&EXT4_I(inode)->i_es_lock);
+	if (err1 || err2 || err3)
+		goto retry;
 
 	ext4_es_print_tree(inode);
-
-	return err;
+	return 0;
 }
 
 /*
@@ -900,7 +971,7 @@ void ext4_es_cache_extent(struct inode *inode, ext4_lblk_t lblk,
 
 	es = __es_tree_search(&EXT4_I(inode)->i_es_tree.root, lblk);
 	if (!es || es->es_lblk > end)
-		__es_insert_extent(inode, &newes);
+		__es_insert_extent(inode, &newes, NULL);
 	write_unlock(&EXT4_I(inode)->i_es_lock);
 }
 
@@ -1271,7 +1342,7 @@ static unsigned int get_rsvd(struct inode *inode, ext4_lblk_t end,
 				rc->ndelonly--;
 				node = rb_next(&pr->rb_node);
 				rb_erase(&pr->rb_node, &tree->root);
-				kmem_cache_free(ext4_pending_cachep, pr);
+				__free_pending(pr);
 				if (!node)
 					break;
 				pr = rb_entry(node, struct pending_reservation,
@@ -1290,6 +1361,7 @@ static unsigned int get_rsvd(struct inode *inode, ext4_lblk_t end,
  * @lblk - first block in range
  * @end - last block in range
  * @reserved - number of cluster reservations released
+ * @prealloc - pre-allocated es to avoid memory allocation failures
  *
  * If @reserved is not NULL and delayed allocation is enabled, counts
  * block/cluster reservations freed by removing range and if bigalloc
@@ -1297,7 +1369,8 @@ static unsigned int get_rsvd(struct inode *inode, ext4_lblk_t end,
  * error code on failure.
  */
 static int __es_remove_extent(struct inode *inode, ext4_lblk_t lblk,
-			      ext4_lblk_t end, int *reserved)
+			      ext4_lblk_t end, int *reserved,
+			      struct extent_status *prealloc)
 {
 	struct ext4_es_tree *tree = &EXT4_I(inode)->i_es_tree;
 	struct rb_node *node;
@@ -1305,14 +1378,12 @@ static int __es_remove_extent(struct inode *inode, ext4_lblk_t lblk,
 	struct extent_status orig_es;
 	ext4_lblk_t len1, len2;
 	ext4_fsblk_t block;
-	int err;
+	int err = 0;
 	bool count_reserved = true;
 	struct rsvd_count rc;
 
 	if (reserved == NULL || !test_opt(inode->i_sb, DELALLOC))
 		count_reserved = false;
-retry:
-	err = 0;
 
 	es = __es_tree_search(&tree->root, lblk);
 	if (!es)
@@ -1346,14 +1417,13 @@ static int __es_remove_extent(struct inode *inode, ext4_lblk_t lblk,
 					orig_es.es_len - len2;
 			ext4_es_store_pblock_status(&newes, block,
 						    ext4_es_status(&orig_es));
-			err = __es_insert_extent(inode, &newes);
+			err = __es_insert_extent(inode, &newes, prealloc);
 			if (err) {
+				if (!ext4_es_must_keep(&newes))
+					return 0;
+
 				es->es_lblk = orig_es.es_lblk;
 				es->es_len = orig_es.es_len;
-				if ((err == -ENOMEM) &&
-				    __es_shrink(EXT4_SB(inode->i_sb),
-							128, EXT4_I(inode)))
-					goto retry;
 				goto out;
 			}
 		} else {
@@ -1433,6 +1503,7 @@ int ext4_es_remove_extent(struct inode *inode, ext4_lblk_t lblk,
 	ext4_lblk_t end;
 	int err = 0;
 	int reserved = 0;
+	struct extent_status *es = NULL;
 
 	if (EXT4_SB(inode->i_sb)->s_mount_state & EXT4_FC_REPLAY)
 		return 0;
@@ -1447,17 +1518,29 @@ int ext4_es_remove_extent(struct inode *inode, ext4_lblk_t lblk,
 	end = lblk + len - 1;
 	BUG_ON(end < lblk);
 
+retry:
+	if (err && !es)
+		es = __es_alloc_extent(true);
 	/*
 	 * ext4_clear_inode() depends on us taking i_es_lock unconditionally
 	 * so that we are sure __es_shrink() is done with the inode before it
 	 * is reclaimed.
 	 */
 	write_lock(&EXT4_I(inode)->i_es_lock);
-	err = __es_remove_extent(inode, lblk, end, &reserved);
+	err = __es_remove_extent(inode, lblk, end, &reserved, es);
+	/* Free preallocated extent if it didn't get used. */
+	if (es) {
+		if (!es->es_len)
+			__es_free_extent(es);
+		es = NULL;
+	}
 	write_unlock(&EXT4_I(inode)->i_es_lock);
+	if (err)
+		goto retry;
+
 	ext4_es_print_tree(inode);
 	ext4_da_release_space(inode, reserved);
-	return err;
+	return 0;
 }
 
 static int __es_shrink(struct ext4_sb_info *sbi, int nr_to_scan,
@@ -1704,11 +1787,8 @@ static int es_do_reclaim_extents(struct ext4_inode_info *ei, ext4_lblk_t end,
 
 		(*nr_to_scan)--;
 		node = rb_next(&es->rb_node);
-		/*
-		 * We can't reclaim delayed extent from status tree because
-		 * fiemap, bigallic, and seek_data/hole need to use it.
-		 */
-		if (ext4_es_is_delayed(es))
+
+		if (ext4_es_must_keep(es))
 			goto next;
 		if (ext4_es_is_referenced(es)) {
 			ext4_es_clear_referenced(es);
@@ -1772,7 +1852,7 @@ void ext4_clear_inode_es(struct inode *inode)
 	while (node) {
 		es = rb_entry(node, struct extent_status, rb_node);
 		node = rb_next(node);
-		if (!ext4_es_is_delayed(es)) {
+		if (!ext4_es_must_keep(es)) {
 			rb_erase(&es->rb_node, &tree->root);
 			ext4_es_free_extent(inode, es);
 		}
@@ -1859,11 +1939,13 @@ static struct pending_reservation *__get_pending(struct inode *inode,
  *
  * @inode - file containing the cluster
  * @lblk - logical block in the cluster to be added
+ * @prealloc - preallocated pending entry
  *
  * Returns 0 on successful insertion and -ENOMEM on failure.  If the
  * pending reservation is already in the set, returns successfully.
  */
-static int __insert_pending(struct inode *inode, ext4_lblk_t lblk)
+static int __insert_pending(struct inode *inode, ext4_lblk_t lblk,
+			    struct pending_reservation **prealloc)
 {
 	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
 	struct ext4_pending_tree *tree = &EXT4_I(inode)->i_pending_tree;
@@ -1889,10 +1971,15 @@ static int __insert_pending(struct inode *inode, ext4_lblk_t lblk)
 		}
 	}
 
-	pr = kmem_cache_alloc(ext4_pending_cachep, GFP_ATOMIC);
-	if (pr == NULL) {
-		ret = -ENOMEM;
-		goto out;
+	if (likely(*prealloc == NULL)) {
+		pr = __alloc_pending(false);
+		if (!pr) {
+			ret = -ENOMEM;
+			goto out;
+		}
+	} else {
+		pr = *prealloc;
+		*prealloc = NULL;
 	}
 	pr->lclu = lclu;
 
@@ -1922,7 +2009,7 @@ static void __remove_pending(struct inode *inode, ext4_lblk_t lblk)
 	if (pr != NULL) {
 		tree = &EXT4_I(inode)->i_pending_tree;
 		rb_erase(&pr->rb_node, &tree->root);
-		kmem_cache_free(ext4_pending_cachep, pr);
+		__free_pending(pr);
 	}
 }
 
@@ -1983,7 +2070,10 @@ int ext4_es_insert_delayed_block(struct inode *inode, ext4_lblk_t lblk,
 				 bool allocated)
 {
 	struct extent_status newes;
-	int err = 0;
+	int err1 = 0, err2 = 0, err3 = 0;
+	struct extent_status *es1 = NULL;
+	struct extent_status *es2 = NULL;
+	struct pending_reservation *pr = NULL;
 
 	if (EXT4_SB(inode->i_sb)->s_mount_state & EXT4_FC_REPLAY)
 		return 0;
@@ -1998,29 +2088,52 @@ int ext4_es_insert_delayed_block(struct inode *inode, ext4_lblk_t lblk,
 
 	ext4_es_insert_extent_check(inode, &newes);
 
+retry:
+	if (err1 && !es1)
+		es1 = __es_alloc_extent(true);
+	if ((err1 || err2) && !es2)
+		es2 = __es_alloc_extent(true);
+	if ((err1 || err2 || err3) && allocated && !pr)
+		pr = __alloc_pending(true);
 	write_lock(&EXT4_I(inode)->i_es_lock);
 
-	err = __es_remove_extent(inode, lblk, lblk, NULL);
-	if (err != 0)
-		goto error;
-retry:
-	err = __es_insert_extent(inode, &newes);
-	if (err == -ENOMEM && __es_shrink(EXT4_SB(inode->i_sb),
-					  128, EXT4_I(inode)))
-		goto retry;
-	if (err != 0)
+	err1 = __es_remove_extent(inode, lblk, lblk, NULL, es1);
+	if (err1 != 0)
 		goto error;
+	/* Free preallocated extent if it didn't get used. */
+	if (es1) {
+		if (!es1->es_len)
+			__es_free_extent(es1);
+		es1 = NULL;
+	}
 
-	if (allocated)
-		__insert_pending(inode, lblk);
+	err2 = __es_insert_extent(inode, &newes, es2);
+	if (err2 != 0)
+		goto error;
+	/* Free preallocated extent if it didn't get used. */
+	if (es2) {
+		if (!es2->es_len)
+			__es_free_extent(es2);
+		es2 = NULL;
+	}
 
+	if (allocated) {
+		err3 = __insert_pending(inode, lblk, &pr);
+		if (err3 != 0)
+			goto error;
+		if (pr) {
+			__free_pending(pr);
+			pr = NULL;
+		}
+	}
 error:
 	write_unlock(&EXT4_I(inode)->i_es_lock);
+	if (err1 || err2 || err3)
+		goto retry;
 
 	ext4_es_print_tree(inode);
 	ext4_print_pending_tree(inode);
-
-	return err;
+	return 0;
 }
 
 /*
@@ -2121,21 +2234,24 @@ unsigned int ext4_es_delayed_clu(struct inode *inode, ext4_lblk_t lblk,
  * @inode - file containing the range
  * @lblk - logical block defining the start of range
  * @len  - length of range in blocks
+ * @prealloc - preallocated pending entry
  *
  * Used after a newly allocated extent is added to the extents status tree.
  * Requires that the extents in the range have either written or unwritten
  * status.  Must be called while holding i_es_lock.
  */
-static void __revise_pending(struct inode *inode, ext4_lblk_t lblk,
-			     ext4_lblk_t len)
+static int __revise_pending(struct inode *inode, ext4_lblk_t lblk,
+			    ext4_lblk_t len,
+			    struct pending_reservation **prealloc)
 {
 	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
 	ext4_lblk_t end = lblk + len - 1;
 	ext4_lblk_t first, last;
 	bool f_del = false, l_del = false;
+	int ret = 0;
 
 	if (len == 0)
-		return;
+		return 0;
 
 	/*
 	 * Two cases - block range within single cluster and block range
@@ -2156,7 +2272,9 @@ static void __revise_pending(struct inode *inode, ext4_lblk_t lblk,
 			f_del = __es_scan_range(inode, &ext4_es_is_delonly,
 						first, lblk - 1);
 		if (f_del) {
-			__insert_pending(inode, first);
+			ret = __insert_pending(inode, first, prealloc);
+			if (ret < 0)
+				goto out;
 		} else {
 			last = EXT4_LBLK_CMASK(sbi, end) +
 			       sbi->s_cluster_ratio - 1;
@@ -2164,9 +2282,11 @@ static void __revise_pending(struct inode *inode, ext4_lblk_t lblk,
 				l_del = __es_scan_range(inode,
 							&ext4_es_is_delonly,
 							end + 1, last);
-			if (l_del)
-				__insert_pending(inode, last);
-			else
+			if (l_del) {
+				ret = __insert_pending(inode, last, prealloc);
+				if (ret < 0)
+					goto out;
+			} else
 				__remove_pending(inode, last);
 		}
 	} else {
@@ -2174,18 +2294,24 @@ static void __revise_pending(struct inode *inode, ext4_lblk_t lblk,
 		if (first != lblk)
 			f_del = __es_scan_range(inode, &ext4_es_is_delonly,
 						first, lblk - 1);
-		if (f_del)
-			__insert_pending(inode, first);
-		else
+		if (f_del) {
+			ret = __insert_pending(inode, first, prealloc);
+			if (ret < 0)
+				goto out;
+		} else
 			__remove_pending(inode, first);
 
 		last = EXT4_LBLK_CMASK(sbi, end) + sbi->s_cluster_ratio - 1;
 		if (last != end)
 			l_del = __es_scan_range(inode, &ext4_es_is_delonly,
 						end + 1, last);
-		if (l_del)
-			__insert_pending(inode, last);
-		else
+		if (l_del) {
+			ret = __insert_pending(inode, last, prealloc);
+			if (ret < 0)
+				goto out;
+		} else
 			__remove_pending(inode, last);
 	}
+out:
+	return ret;
 }
diff --git a/fs/inode.c b/fs/inode.c
index 311237e8d359..5c7139aa2bda 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -2392,6 +2392,22 @@ int vfs_ioc_fssetxattr_check(struct inode *inode, const struct fsxattr *old_fa,
 }
 EXPORT_SYMBOL(vfs_ioc_fssetxattr_check);
 
+/**
+ * inode_set_ctime_current - set the ctime to current_time
+ * @inode: inode
+ *
+ * Set the inode->i_ctime to the current value for the inode. Returns
+ * the current value that was assigned to i_ctime.
+ */
+struct timespec64 inode_set_ctime_current(struct inode *inode)
+{
+	struct timespec64 now = current_time(inode);
+
+	inode_set_ctime(inode, now.tv_sec, now.tv_nsec);
+	return now;
+}
+EXPORT_SYMBOL(inode_set_ctime_current);
+
 /**
  * in_group_or_capable - check whether caller is CAP_FSETID privileged
  * @inode:	inode to check
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index b09ead06a249..31edb883afd0 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1758,6 +1758,12 @@ nfsd_rename(struct svc_rqst *rqstp, struct svc_fh *ffhp, char *fname, int flen,
 	if (!flen || isdotent(fname, flen) || !tlen || isdotent(tname, tlen))
 		goto out;
 
+	err = (rqstp->rq_vers == 2) ? nfserr_acces : nfserr_xdev;
+	if (ffhp->fh_export->ex_path.mnt != tfhp->fh_export->ex_path.mnt)
+		goto out;
+	if (ffhp->fh_export->ex_path.dentry != tfhp->fh_export->ex_path.dentry)
+		goto out;
+
 retry:
 	host_err = fh_want_write(ffhp);
 	if (host_err) {
@@ -1792,12 +1798,6 @@ nfsd_rename(struct svc_rqst *rqstp, struct svc_fh *ffhp, char *fname, int flen,
 	if (ndentry == trap)
 		goto out_dput_new;
 
-	host_err = -EXDEV;
-	if (ffhp->fh_export->ex_path.mnt != tfhp->fh_export->ex_path.mnt)
-		goto out_dput_new;
-	if (ffhp->fh_export->ex_path.dentry != tfhp->fh_export->ex_path.dentry)
-		goto out_dput_new;
-
 	if (nfsd_has_cached_files(ndentry)) {
 		has_cached = true;
 		goto out_dput_old;
diff --git a/include/linux/device.h b/include/linux/device.h
index 4f7e0c85e11f..6394c4b70a09 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -348,6 +348,22 @@ enum dl_dev_state {
 	DL_DEV_UNBINDING,
 };
 
+/**
+ * enum device_removable - Whether the device is removable. The criteria for a
+ * device to be classified as removable is determined by its subsystem or bus.
+ * @DEVICE_REMOVABLE_NOT_SUPPORTED: This attribute is not supported for this
+ *				    device (default).
+ * @DEVICE_REMOVABLE_UNKNOWN:  Device location is Unknown.
+ * @DEVICE_FIXED: Device is not removable by the user.
+ * @DEVICE_REMOVABLE: Device is removable by the user.
+ */
+enum device_removable {
+	DEVICE_REMOVABLE_NOT_SUPPORTED = 0, /* must be 0 */
+	DEVICE_REMOVABLE_UNKNOWN,
+	DEVICE_FIXED,
+	DEVICE_REMOVABLE,
+};
+
 /**
  * struct dev_links_info - Device data related to device links.
  * @suppliers: List of links to supplier devices.
@@ -435,6 +451,9 @@ struct dev_links_info {
  * 		device (i.e. the bus driver that discovered the device).
  * @iommu_group: IOMMU group the device belongs to.
  * @iommu:	Per device generic IOMMU runtime data
+ * @removable:  Whether the device can be removed from the system. This
+ *              should be set by the subsystem / bus driver that discovered
+ *              the device.
  *
  * @offline_disabled: If set, the device is permanently online.
  * @offline:	Set after successful invocation of bus type's .offline().
@@ -546,6 +565,8 @@ struct device {
 	struct iommu_group	*iommu_group;
 	struct dev_iommu	*iommu;
 
+	enum device_removable	removable;
+
 	bool			offline_disabled:1;
 	bool			offline:1;
 	bool			of_node_reused:1;
@@ -781,6 +802,22 @@ static inline bool dev_has_sync_state(struct device *dev)
 	return false;
 }
 
+static inline void dev_set_removable(struct device *dev,
+				     enum device_removable removable)
+{
+	dev->removable = removable;
+}
+
+static inline bool dev_is_removable(struct device *dev)
+{
+	return dev->removable == DEVICE_REMOVABLE;
+}
+
+static inline bool dev_removable_is_valid(struct device *dev)
+{
+	return dev->removable != DEVICE_REMOVABLE_NOT_SUPPORTED;
+}
+
 /*
  * High level routines for use by the bus drivers
  */
diff --git a/include/linux/fs.h b/include/linux/fs.h
index f9e25d0a7b9c..82316863c71f 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1580,7 +1580,50 @@ static inline void i_gid_write(struct inode *inode, gid_t gid)
 	inode->i_gid = make_kgid(inode->i_sb->s_user_ns, gid);
 }
 
-extern struct timespec64 current_time(struct inode *inode);
+struct timespec64 current_time(struct inode *inode);
+struct timespec64 inode_set_ctime_current(struct inode *inode);
+
+/**
+ * inode_get_ctime - fetch the current ctime from the inode
+ * @inode: inode from which to fetch ctime
+ *
+ * Grab the current ctime from the inode and return it.
+ */
+static inline struct timespec64 inode_get_ctime(const struct inode *inode)
+{
+	return inode->i_ctime;
+}
+
+/**
+ * inode_set_ctime_to_ts - set the ctime in the inode
+ * @inode: inode in which to set the ctime
+ * @ts: value to set in the ctime field
+ *
+ * Set the ctime in @inode to @ts
+ */
+static inline struct timespec64 inode_set_ctime_to_ts(struct inode *inode,
+						      struct timespec64 ts)
+{
+	inode->i_ctime = ts;
+	return ts;
+}
+
+/**
+ * inode_set_ctime - set the ctime in the inode
+ * @inode: inode in which to set the ctime
+ * @sec: tv_sec value to set
+ * @nsec: tv_nsec value to set
+ *
+ * Set the ctime in @inode to { @sec, @nsec }
+ */
+static inline struct timespec64 inode_set_ctime(struct inode *inode,
+						time64_t sec, long nsec)
+{
+	struct timespec64 ts = { .tv_sec  = sec,
+				 .tv_nsec = nsec };
+
+	return inode_set_ctime_to_ts(inode, ts);
+}
 
 /*
  * Snapshotting support.
diff --git a/include/linux/hid.h b/include/linux/hid.h
index 256f34f49167..9e306bf9959d 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -624,8 +624,13 @@ struct hid_device {							/* device report descriptor */
 	struct list_head debug_list;
 	spinlock_t  debug_list_lock;
 	wait_queue_head_t debug_wait;
+	struct kref			ref;
+
+	unsigned int id;						/* system unique id */
 };
 
+void hiddev_free(struct kref *ref);
+
 #define to_hid_device(pdev) \
 	container_of(pdev, struct hid_device, dev)
 
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index fb294cbb9081..fb08b86acdbf 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -405,6 +405,7 @@ struct mmc_host {
 	unsigned int		use_blk_mq:1;	/* use blk-mq */
 	unsigned int		retune_crc_disable:1; /* don't trigger retune upon crc */
 	unsigned int		can_dma_map_merge:1; /* merging can be used */
+	unsigned int		vqmmc_enabled:1; /* vqmmc regulator is enabled */
 
 	int			rescan_disable;	/* disable card detection */
 	int			rescan_entered;	/* used with nonremovable devices */
@@ -546,6 +547,8 @@ static inline int mmc_regulator_set_vqmmc(struct mmc_host *mmc,
 #endif
 
 int mmc_regulator_get_supply(struct mmc_host *mmc);
+int mmc_regulator_enable_vqmmc(struct mmc_host *mmc);
+void mmc_regulator_disable_vqmmc(struct mmc_host *mmc);
 
 static inline int mmc_card_is_removable(struct mmc_host *host)
 {
diff --git a/include/linux/platform_data/x86/soc.h b/include/linux/platform_data/x86/soc.h
new file mode 100644
index 000000000000..da05f425587a
--- /dev/null
+++ b/include/linux/platform_data/x86/soc.h
@@ -0,0 +1,65 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Helpers for Intel SoC model detection
+ *
+ * Copyright (c) 2019, Intel Corporation.
+ */
+
+#ifndef __PLATFORM_DATA_X86_SOC_H
+#define __PLATFORM_DATA_X86_SOC_H
+
+#if IS_ENABLED(CONFIG_X86)
+
+#include <asm/cpu_device_id.h>
+#include <asm/intel-family.h>
+
+#define SOC_INTEL_IS_CPU(soc, type)				\
+static inline bool soc_intel_is_##soc(void)			\
+{								\
+	static const struct x86_cpu_id soc##_cpu_ids[] = {	\
+		X86_MATCH_INTEL_FAM6_MODEL(type, NULL),		\
+		{}						\
+	};							\
+	const struct x86_cpu_id *id;				\
+								\
+	id = x86_match_cpu(soc##_cpu_ids);			\
+	if (id)							\
+		return true;					\
+	return false;						\
+}
+
+SOC_INTEL_IS_CPU(byt, ATOM_SILVERMONT);
+SOC_INTEL_IS_CPU(cht, ATOM_AIRMONT);
+SOC_INTEL_IS_CPU(apl, ATOM_GOLDMONT);
+SOC_INTEL_IS_CPU(glk, ATOM_GOLDMONT_PLUS);
+SOC_INTEL_IS_CPU(cml, KABYLAKE_L);
+
+#else /* IS_ENABLED(CONFIG_X86) */
+
+static inline bool soc_intel_is_byt(void)
+{
+	return false;
+}
+
+static inline bool soc_intel_is_cht(void)
+{
+	return false;
+}
+
+static inline bool soc_intel_is_apl(void)
+{
+	return false;
+}
+
+static inline bool soc_intel_is_glk(void)
+{
+	return false;
+}
+
+static inline bool soc_intel_is_cml(void)
+{
+	return false;
+}
+#endif /* IS_ENABLED(CONFIG_X86) */
+
+#endif /* __PLATFORM_DATA_X86_SOC_H */
diff --git a/include/linux/usb.h b/include/linux/usb.h
index 8bc1119afc31..e02cf70ca52f 100644
--- a/include/linux/usb.h
+++ b/include/linux/usb.h
@@ -478,12 +478,6 @@ struct usb_dev_state;
 
 struct usb_tt;
 
-enum usb_device_removable {
-	USB_DEVICE_REMOVABLE_UNKNOWN = 0,
-	USB_DEVICE_REMOVABLE,
-	USB_DEVICE_FIXED,
-};
-
 enum usb_port_connect_type {
 	USB_PORT_CONNECT_TYPE_UNKNOWN = 0,
 	USB_PORT_CONNECT_TYPE_HOT_PLUG,
@@ -710,7 +704,6 @@ struct usb_device {
 #endif
 	struct wusb_dev *wusb_dev;
 	int slot_id;
-	enum usb_device_removable removable;
 	struct usb2_lpm_parameters l1_params;
 	struct usb3_lpm_parameters u1_params;
 	struct usb3_lpm_parameters u2_params;
diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
index 460c58fa011a..0383fac637e1 100644
--- a/include/linux/workqueue.h
+++ b/include/linux/workqueue.h
@@ -460,6 +460,7 @@ extern int schedule_on_each_cpu(work_func_t func);
 int execute_in_process_context(work_func_t fn, struct execute_work *);
 
 extern bool flush_work(struct work_struct *work);
+extern bool cancel_work(struct work_struct *work);
 extern bool cancel_work_sync(struct work_struct *work);
 
 extern bool flush_delayed_work(struct delayed_work *dwork);
diff --git a/include/scsi/scsi_cmnd.h b/include/scsi/scsi_cmnd.h
index 4d272e834ca2..b1c9b52876f3 100644
--- a/include/scsi/scsi_cmnd.h
+++ b/include/scsi/scsi_cmnd.h
@@ -144,6 +144,12 @@ struct scsi_cmnd {
 	unsigned int extra_len;	/* length of alignment and padding */
 };
 
+/* Variant of blk_mq_rq_from_pdu() that verifies the type of its argument. */
+static inline struct request *scsi_cmd_to_rq(struct scsi_cmnd *scmd)
+{
+	return blk_mq_rq_from_pdu(scmd);
+}
+
 /*
  * Return the driver private allocation behind the command.
  * Only works if cmd_size is set in the host template.
diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index 1fe05e70cc79..0c4f159865b9 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -3149,7 +3149,7 @@ static int __io_import_fixed(struct io_kiocb *req, int rw, struct iov_iter *iter
 		 */
 		const struct bio_vec *bvec = imu->bvec;
 
-		if (offset <= bvec->bv_len) {
+		if (offset < bvec->bv_len) {
 			iov_iter_advance(iter, offset);
 		} else {
 			unsigned long seg_skip;
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index 6cbd2b444476..7471d85f54ae 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -3357,7 +3357,8 @@ static int alloc_chain_hlocks(int req)
 		size = chain_block_size(curr);
 		if (likely(size >= req)) {
 			del_chain_block(0, size, chain_block_next(curr));
-			add_chain_block(curr + req, size - req);
+			if (size > req)
+				add_chain_block(curr + req, size - req);
 			return curr;
 		}
 	}
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 37d01e44d483..63140e4dd5df 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -3240,6 +3240,15 @@ static bool __cancel_work(struct work_struct *work, bool is_dwork)
 	return ret;
 }
 
+/*
+ * See cancel_delayed_work()
+ */
+bool cancel_work(struct work_struct *work)
+{
+	return __cancel_work(work, false);
+}
+EXPORT_SYMBOL(cancel_work);
+
 /**
  * cancel_delayed_work - cancel a delayed work
  * @dwork: delayed_work to cancel
diff --git a/lib/errname.c b/lib/errname.c
index a5799a8c9cab..fec08e7c8a1d 100644
--- a/lib/errname.c
+++ b/lib/errname.c
@@ -110,9 +110,6 @@ static const char *names_0[] = {
 	E(ENOSPC),
 	E(ENOSR),
 	E(ENOSTR),
-#ifdef ENOSYM
-	E(ENOSYM),
-#endif
 	E(ENOSYS),
 	E(ENOTBLK),
 	E(ENOTCONN),
@@ -143,9 +140,6 @@ static const char *names_0[] = {
 #endif
 	E(EREMOTE),
 	E(EREMOTEIO),
-#ifdef EREMOTERELEASE
-	E(EREMOTERELEASE),
-#endif
 	E(ERESTART),
 	E(ERFKILL),
 	E(EROFS),
diff --git a/net/ipv4/igmp.c b/net/ipv4/igmp.c
index 4cffdb9795de..cb55fede03c0 100644
--- a/net/ipv4/igmp.c
+++ b/net/ipv4/igmp.c
@@ -216,8 +216,10 @@ static void igmp_start_timer(struct ip_mc_list *im, int max_delay)
 	int tv = prandom_u32() % max_delay;
 
 	im->tm_running = 1;
-	if (!mod_timer(&im->timer, jiffies+tv+2))
-		refcount_inc(&im->refcnt);
+	if (refcount_inc_not_zero(&im->refcnt)) {
+		if (mod_timer(&im->timer, jiffies + tv + 2))
+			ip_ma_put(im);
+	}
 }
 
 static void igmp_gq_start_timer(struct in_device *in_dev)
diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index 445b1a2966d7..d360c7d70e8a 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -808,7 +808,7 @@ static void __ip_do_redirect(struct rtable *rt, struct sk_buff *skb, struct flow
 			goto reject_redirect;
 	}
 
-	n = __ipv4_neigh_lookup(rt->dst.dev, new_gw);
+	n = __ipv4_neigh_lookup(rt->dst.dev, (__force u32)new_gw);
 	if (!n)
 		n = neigh_create(&arp_tbl, &new_gw, rt->dst.dev);
 	if (!IS_ERR(n)) {
diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index 9fc47292b68d..664ddf5641de 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -396,8 +396,12 @@ static int smcr_clnt_conf_first_link(struct smc_sock *smc)
 	struct smc_llc_qentry *qentry;
 	int rc;
 
-	/* receive CONFIRM LINK request from server over RoCE fabric */
-	qentry = smc_llc_wait(link->lgr, NULL, SMC_LLC_WAIT_TIME,
+	/* Receive CONFIRM LINK request from server over RoCE fabric.
+	 * Increasing the client's timeout by twice as much as the server's
+	 * timeout by default can temporarily avoid decline messages of
+	 * both sides crossing or colliding
+	 */
+	qentry = smc_llc_wait(link->lgr, NULL, 2 * SMC_LLC_WAIT_TIME,
 			      SMC_LLC_CONFIRM_LINK);
 	if (!qentry) {
 		struct smc_clc_msg_decline dclc;
diff --git a/security/integrity/iint.c b/security/integrity/iint.c
index 9ed2d5bfbed5..b6e33ac70aef 100644
--- a/security/integrity/iint.c
+++ b/security/integrity/iint.c
@@ -66,9 +66,32 @@ struct integrity_iint_cache *integrity_iint_find(struct inode *inode)
 	return iint;
 }
 
-static void iint_free(struct integrity_iint_cache *iint)
+#define IMA_MAX_NESTING (FILESYSTEM_MAX_STACK_DEPTH+1)
+
+/*
+ * It is not clear that IMA should be nested at all, but as long is it measures
+ * files both on overlayfs and on underlying fs, we need to annotate the iint
+ * mutex to avoid lockdep false positives related to IMA + overlayfs.
+ * See ovl_lockdep_annotate_inode_mutex_key() for more details.
+ */
+static inline void iint_lockdep_annotate(struct integrity_iint_cache *iint,
+					 struct inode *inode)
+{
+#ifdef CONFIG_LOCKDEP
+	static struct lock_class_key iint_mutex_key[IMA_MAX_NESTING];
+
+	int depth = inode->i_sb->s_stack_depth;
+
+	if (WARN_ON_ONCE(depth < 0 || depth >= IMA_MAX_NESTING))
+		depth = 0;
+
+	lockdep_set_class(&iint->mutex, &iint_mutex_key[depth]);
+#endif
+}
+
+static void iint_init_always(struct integrity_iint_cache *iint,
+			     struct inode *inode)
 {
-	kfree(iint->ima_hash);
 	iint->ima_hash = NULL;
 	iint->version = 0;
 	iint->flags = 0UL;
@@ -80,6 +103,14 @@ static void iint_free(struct integrity_iint_cache *iint)
 	iint->ima_creds_status = INTEGRITY_UNKNOWN;
 	iint->evm_status = INTEGRITY_UNKNOWN;
 	iint->measured_pcrs = 0;
+	mutex_init(&iint->mutex);
+	iint_lockdep_annotate(iint, inode);
+}
+
+static void iint_free(struct integrity_iint_cache *iint)
+{
+	kfree(iint->ima_hash);
+	mutex_destroy(&iint->mutex);
 	kmem_cache_free(iint_cache, iint);
 }
 
@@ -112,6 +143,8 @@ struct integrity_iint_cache *integrity_inode_get(struct inode *inode)
 	if (!iint)
 		return NULL;
 
+	iint_init_always(iint, inode);
+
 	write_lock(&integrity_iint_lock);
 
 	p = &integrity_iint_tree.rb_node;
@@ -161,25 +194,18 @@ void integrity_inode_free(struct inode *inode)
 	iint_free(iint);
 }
 
-static void init_once(void *foo)
+static void iint_init_once(void *foo)
 {
 	struct integrity_iint_cache *iint = foo;
 
 	memset(iint, 0, sizeof(*iint));
-	iint->ima_file_status = INTEGRITY_UNKNOWN;
-	iint->ima_mmap_status = INTEGRITY_UNKNOWN;
-	iint->ima_bprm_status = INTEGRITY_UNKNOWN;
-	iint->ima_read_status = INTEGRITY_UNKNOWN;
-	iint->ima_creds_status = INTEGRITY_UNKNOWN;
-	iint->evm_status = INTEGRITY_UNKNOWN;
-	mutex_init(&iint->mutex);
 }
 
 static int __init integrity_iintcache_init(void)
 {
 	iint_cache =
 	    kmem_cache_create("iint_cache", sizeof(struct integrity_iint_cache),
-			      0, SLAB_PANIC, init_once);
+			      0, SLAB_PANIC, iint_init_once);
 	return 0;
 }
 DEFINE_LSM(integrity) = {
diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index dfef761d5521..12c6eb76fca3 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -2278,6 +2278,8 @@ static const struct snd_pci_quirk power_save_denylist[] = {
 	SND_PCI_QUIRK(0x17aa, 0x36a7, "Lenovo C50 All in one", 0),
 	/* https://bugs.launchpad.net/bugs/1821663 */
 	SND_PCI_QUIRK(0x1631, 0xe017, "Packard Bell NEC IMEDIA 5204", 0),
+	/* KONTRON SinglePC may cause a stall at runtime resume */
+	SND_PCI_QUIRK(0x1734, 0x1232, "KONTRON SinglePC", 0),
 	{}
 };
 #endif /* CONFIG_PM */
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 65f8dc65b967..3d94a2f41d82 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -1994,6 +1994,7 @@ enum {
 	ALC887_FIXUP_ASUS_AUDIO,
 	ALC887_FIXUP_ASUS_HMIC,
 	ALCS1200A_FIXUP_MIC_VREF,
+	ALC888VD_FIXUP_MIC_100VREF,
 };
 
 static void alc889_fixup_coef(struct hda_codec *codec,
@@ -2547,6 +2548,13 @@ static const struct hda_fixup alc882_fixups[] = {
 			{}
 		}
 	},
+	[ALC888VD_FIXUP_MIC_100VREF] = {
+		.type = HDA_FIXUP_PINCTLS,
+		.v.pins = (const struct hda_pintbl[]) {
+			{ 0x18, PIN_VREF100 }, /* headset mic */
+			{}
+		}
+	},
 };
 
 static const struct snd_pci_quirk alc882_fixup_tbl[] = {
@@ -2616,6 +2624,7 @@ static const struct snd_pci_quirk alc882_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x106b, 0x4a00, "Macbook 5,2", ALC889_FIXUP_MBA11_VREF),
 
 	SND_PCI_QUIRK(0x1071, 0x8258, "Evesham Voyaeger", ALC882_FIXUP_EAPD),
+	SND_PCI_QUIRK(0x10ec, 0x12d8, "iBase Elo Touch", ALC888VD_FIXUP_MIC_100VREF),
 	SND_PCI_QUIRK(0x13fe, 0x1009, "Advantech MIT-W101", ALC886_FIXUP_EAPD),
 	SND_PCI_QUIRK(0x1458, 0xa002, "Gigabyte EP45-DS3/Z87X-UD3H", ALC889_FIXUP_FRONT_HP_NO_PRESENCE),
 	SND_PCI_QUIRK(0x1458, 0xa0b8, "Gigabyte AZ370-Gaming", ALC1220_FIXUP_GB_DUAL_CODECS),
@@ -3257,6 +3266,7 @@ static void alc_disable_headset_jack_key(struct hda_codec *codec)
 	case 0x10ec0230:
 	case 0x10ec0236:
 	case 0x10ec0256:
+	case 0x10ec0257:
 	case 0x19e58326:
 		alc_write_coef_idx(codec, 0x48, 0x0);
 		alc_update_coef_idx(codec, 0x49, 0x0045, 0x0);
@@ -3286,6 +3296,7 @@ static void alc_enable_headset_jack_key(struct hda_codec *codec)
 	case 0x10ec0230:
 	case 0x10ec0236:
 	case 0x10ec0256:
+	case 0x10ec0257:
 	case 0x19e58326:
 		alc_write_coef_idx(codec, 0x48, 0xd011);
 		alc_update_coef_idx(codec, 0x49, 0x007f, 0x0045);
@@ -6415,6 +6426,7 @@ static void alc_combo_jack_hp_jd_restart(struct hda_codec *codec)
 	case 0x10ec0236:
 	case 0x10ec0255:
 	case 0x10ec0256:
+	case 0x10ec0257:
 	case 0x19e58326:
 		alc_update_coef_idx(codec, 0x1b, 0x8000, 1 << 15); /* Reset HP JD */
 		alc_update_coef_idx(codec, 0x1b, 0x8000, 0 << 15);
diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index ac97e8b7978c..8723d540ac2f 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -634,10 +634,12 @@ static int asoc_simple_probe(struct platform_device *pdev)
 
 		int dai_idx = 0;
 
+		ret = -EINVAL;
+
 		cinfo = dev->platform_data;
 		if (!cinfo) {
 			dev_err(dev, "no info for asoc-simple-card\n");
-			return -EINVAL;
+			goto err;
 		}
 
 		if (!cinfo->name ||
@@ -646,7 +648,7 @@ static int asoc_simple_probe(struct platform_device *pdev)
 		    !cinfo->platform ||
 		    !cinfo->cpu_dai.name) {
 			dev_err(dev, "insufficient asoc_simple_card_info settings\n");
-			return -EINVAL;
+			goto err;
 		}
 
 		dai_props->cpu_dai	= &priv->dais[dai_idx++];
diff --git a/sound/soc/intel/common/soc-intel-quirks.h b/sound/soc/intel/common/soc-intel-quirks.h
index a93987ab7f4d..de4e550c5b34 100644
--- a/sound/soc/intel/common/soc-intel-quirks.h
+++ b/sound/soc/intel/common/soc-intel-quirks.h
@@ -9,34 +9,13 @@
 #ifndef _SND_SOC_INTEL_QUIRKS_H
 #define _SND_SOC_INTEL_QUIRKS_H
 
+#include <linux/platform_data/x86/soc.h>
+
 #if IS_ENABLED(CONFIG_X86)
 
 #include <linux/dmi.h>
-#include <asm/cpu_device_id.h>
-#include <asm/intel-family.h>
 #include <asm/iosf_mbi.h>
 
-#define SOC_INTEL_IS_CPU(soc, type)				\
-static inline bool soc_intel_is_##soc(void)			\
-{								\
-	static const struct x86_cpu_id soc##_cpu_ids[] = {	\
-		X86_MATCH_INTEL_FAM6_MODEL(type, NULL),		\
-		{}						\
-	};							\
-	const struct x86_cpu_id *id;				\
-								\
-	id = x86_match_cpu(soc##_cpu_ids);			\
-	if (id)							\
-		return true;					\
-	return false;						\
-}
-
-SOC_INTEL_IS_CPU(byt, ATOM_SILVERMONT);
-SOC_INTEL_IS_CPU(cht, ATOM_AIRMONT);
-SOC_INTEL_IS_CPU(apl, ATOM_GOLDMONT);
-SOC_INTEL_IS_CPU(glk, ATOM_GOLDMONT_PLUS);
-SOC_INTEL_IS_CPU(cml, KABYLAKE_L);
-
 static inline bool soc_intel_is_byt_cr(struct platform_device *pdev)
 {
 	/*
@@ -114,30 +93,6 @@ static inline bool soc_intel_is_byt_cr(struct platform_device *pdev)
 	return false;
 }
 
-static inline bool soc_intel_is_byt(void)
-{
-	return false;
-}
-
-static inline bool soc_intel_is_cht(void)
-{
-	return false;
-}
-
-static inline bool soc_intel_is_apl(void)
-{
-	return false;
-}
-
-static inline bool soc_intel_is_glk(void)
-{
-	return false;
-}
-
-static inline bool soc_intel_is_cml(void)
-{
-	return false;
-}
 #endif
 
- #endif /* _SND_SOC_INTEL_QUIRKS_H */
+#endif /* _SND_SOC_INTEL_QUIRKS_H */
diff --git a/sound/soc/sof/sof-pci-dev.c b/sound/soc/sof/sof-pci-dev.c
index fe9feaab6a0a..ade292a61ed6 100644
--- a/sound/soc/sof/sof-pci-dev.c
+++ b/sound/soc/sof/sof-pci-dev.c
@@ -12,6 +12,7 @@
 #include <linux/dmi.h>
 #include <linux/module.h>
 #include <linux/pci.h>
+#include <linux/platform_data/x86/soc.h>
 #include <linux/pm_runtime.h>
 #include <sound/intel-dsp-config.h>
 #include <sound/soc-acpi.h>
@@ -31,17 +32,22 @@ static char *tplg_path;
 module_param(tplg_path, charp, 0444);
 MODULE_PARM_DESC(tplg_path, "alternate path for SOF topology.");
 
+static char *tplg_filename;
+module_param(tplg_filename, charp, 0444);
+MODULE_PARM_DESC(tplg_filename, "alternate filename for SOF topology.");
+
 static int sof_pci_debug;
 module_param_named(sof_pci_debug, sof_pci_debug, int, 0444);
 MODULE_PARM_DESC(sof_pci_debug, "SOF PCI debug options (0x0 all off)");
 
-static const char *sof_override_tplg_name;
+static const char *sof_dmi_override_tplg_name;
+static bool sof_dmi_use_community_key;
 
 #define SOF_PCI_DISABLE_PM_RUNTIME BIT(0)
 
 static int sof_tplg_cb(const struct dmi_system_id *id)
 {
-	sof_override_tplg_name = id->driver_data;
+	sof_dmi_override_tplg_name = id->driver_data;
 	return 1;
 }
 
@@ -57,25 +63,44 @@ static const struct dmi_system_id sof_tplg_table[] = {
 	{}
 };
 
+/* all Up boards use the community key */
+static int up_use_community_key(const struct dmi_system_id *id)
+{
+	sof_dmi_use_community_key = true;
+	return 1;
+}
+
+/*
+ * For ApolloLake Chromebooks we want to force the use of the Intel production key.
+ * All newer platforms use the community key
+ */
+static int chromebook_use_community_key(const struct dmi_system_id *id)
+{
+	if (!soc_intel_is_apl())
+		sof_dmi_use_community_key = true;
+	return 1;
+}
+
 static const struct dmi_system_id community_key_platforms[] = {
 	{
-		.ident = "Up Squared",
+		.ident = "Up boards",
+		.callback = up_use_community_key,
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "AAEON"),
-			DMI_MATCH(DMI_BOARD_NAME, "UP-APL01"),
 		}
 	},
 	{
-		.ident = "Up Extreme",
+		.ident = "Google Chromebooks",
+		.callback = chromebook_use_community_key,
 		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "AAEON"),
-			DMI_MATCH(DMI_BOARD_NAME, "UP-WHL01"),
+			DMI_MATCH(DMI_PRODUCT_FAMILY, "Google"),
 		}
 	},
 	{
-		.ident = "Google Chromebooks",
+		.ident = "Google firmware",
+		.callback = chromebook_use_community_key,
 		.matches = {
-			DMI_MATCH(DMI_PRODUCT_FAMILY, "Google"),
+			DMI_MATCH(DMI_BIOS_VERSION, "Google"),
 		}
 	},
 	{},
@@ -379,7 +404,7 @@ static int sof_pci_probe(struct pci_dev *pci,
 			"Module parameter used, changed fw path to %s\n",
 			sof_pdata->fw_filename_prefix);
 
-	} else if (dmi_check_system(community_key_platforms)) {
+	} else if (dmi_check_system(community_key_platforms) && sof_dmi_use_community_key) {
 		sof_pdata->fw_filename_prefix =
 			devm_kasprintf(dev, GFP_KERNEL, "%s/%s",
 				       sof_pdata->desc->default_fw_path,
@@ -399,9 +424,20 @@ static int sof_pci_probe(struct pci_dev *pci,
 		sof_pdata->tplg_filename_prefix =
 			sof_pdata->desc->default_tplg_path;
 
-	dmi_check_system(sof_tplg_table);
-	if (sof_override_tplg_name)
-		sof_pdata->tplg_filename = sof_override_tplg_name;
+	/*
+	 * the topology filename will be provided in the machine descriptor, unless
+	 * it is overridden by a module parameter or DMI quirk.
+	 */
+	if (tplg_filename) {
+		sof_pdata->tplg_filename = tplg_filename;
+
+		dev_dbg(dev, "Module parameter used, changed tplg filename to %s\n",
+			sof_pdata->tplg_filename);
+	} else {
+		dmi_check_system(sof_tplg_table);
+		if (sof_dmi_override_tplg_name)
+			sof_pdata->tplg_filename = sof_dmi_override_tplg_name;
+	}
 
 #if IS_ENABLED(CONFIG_SND_SOC_SOF_PROBE_WORK_QUEUE)
 	/* set callback to enable runtime_pm */
diff --git a/tools/arch/parisc/include/uapi/asm/errno.h b/tools/arch/parisc/include/uapi/asm/errno.h
index 87245c584784..8d94739d75c6 100644
--- a/tools/arch/parisc/include/uapi/asm/errno.h
+++ b/tools/arch/parisc/include/uapi/asm/errno.h
@@ -75,7 +75,6 @@
 
 /* We now return you to your regularly scheduled HPUX. */
 
-#define ENOSYM		215	/* symbol does not exist in executable */
 #define	ENOTSOCK	216	/* Socket operation on non-socket */
 #define	EDESTADDRREQ	217	/* Destination address required */
 #define	EMSGSIZE	218	/* Message too long */
@@ -101,7 +100,6 @@
 #define	ETIMEDOUT	238	/* Connection timed out */
 #define	ECONNREFUSED	239	/* Connection refused */
 #define	EREFUSED	ECONNREFUSED	/* for HP's NFS apparently */
-#define	EREMOTERELEASE	240	/* Remote peer released connection */
 #define	EHOSTDOWN	241	/* Host is down */
 #define	EHOSTUNREACH	242	/* No route to host */
 
diff --git a/tools/testing/selftests/net/ipsec.c b/tools/testing/selftests/net/ipsec.c
index 17ced7d6ce25..03b048b66831 100644
--- a/tools/testing/selftests/net/ipsec.c
+++ b/tools/testing/selftests/net/ipsec.c
@@ -2117,7 +2117,7 @@ static int check_results(void)
 
 int main(int argc, char **argv)
 {
-	unsigned int nr_process = 1;
+	long nr_process = 1;
 	int route_sock = -1, ret = KSFT_SKIP;
 	int test_desc_fd[2];
 	uint32_t route_seq;
@@ -2138,7 +2138,7 @@ int main(int argc, char **argv)
 			exit_usage(argv);
 		}
 
-		if (nr_process > MAX_PROCESSES || !nr_process) {
+		if (nr_process > MAX_PROCESSES || nr_process < 1) {
 			printk("nr_process should be between [1; %u]",
 					MAX_PROCESSES);
 			exit_usage(argv);
diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/testing/selftests/net/mptcp/mptcp_connect.c
index 77bb62feb872..37c1ec888ba2 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
@@ -15,6 +15,7 @@
 #include <unistd.h>
 
 #include <sys/poll.h>
+#include <sys/random.h>
 #include <sys/sendfile.h>
 #include <sys/stat.h>
 #include <sys/socket.h>
@@ -734,15 +735,11 @@ int main_loop_s(int listensock)
 
 static void init_rng(void)
 {
-	int fd = open("/dev/urandom", O_RDONLY);
 	unsigned int foo;
 
-	if (fd > 0) {
-		int ret = read(fd, &foo, sizeof(foo));
-
-		if (ret < 0)
-			srand(fd + foo);
-		close(fd);
+	if (getrandom(&foo, sizeof(foo), 0) == -1) {
+		perror("getrandom");
+		exit(1);
 	}
 
 	srand(foo);
