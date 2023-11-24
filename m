Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98D4B7F718E
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 11:33:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345481AbjKXKdf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 05:33:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345584AbjKXKdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 05:33:09 -0500
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2061.outbound.protection.outlook.com [40.107.96.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B449C1BD;
        Fri, 24 Nov 2023 02:33:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mgTjMI1DDRivQcdWBDMnin9cWH1Si2VOfk06dmQa35bskeTB5/FlvQ1RT9tTQNrHycU2fSDmk3nHFEf2zed6FMUDON8FxQq3Tey7nupl34bVpTlTCwak/csHALGGv4sgeJIrb6AsPOv0Z8Q/zrCHUjh2yFRYhZpdjfM1zpysk+okaZSTtgt62BQmbTRfB+UExepKcNuP0c+HAAfGNUAv5WZBBTKiBFoGRCmDn5LrkawoVLsgdAcfDZxDBqhwBXrvgjCrsmOK9qNlOcl5hBSRCCuYY5hSjew+p8ZyjXCDG2llp3DX3f7K0eakvYSi/tb2BB5cDBR3OeK246KR0ge8NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CxiFRDtp5qqk6Bo0ku32SWQukLFTF8Compi0RCGR9bw=;
 b=KB9YWq/9lGG2S6be55uerEVZLcnL5tLTdb1swsh+B6Thdr0r+sn3BCgE+9e/Gz1BVREz+O1Lf6MDfGdmdOrjRt4ZiUXWQhxXqf2G7kxoqc9qD/Cz6seM/F5mJmWDtinLM5ba35i9o2J96B58ljGqPHf1T26HadKuAqCm6KDh7YsgpH+xXU2/9MEXLkOF+MNkbWoIyiIqXcalYdT1R8dkF2KcKZNV/iSeBkj64ws91O6H7Nxq3kNpNBS7ILzHEhJFVTraW/U4l+SMA1WOjU6aEwBlBvHExZPlpmMjeW4wgZzw4oq1IbnkkC3ctBrYoNkei1t1jW4JcmF/ODewpfWulg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=suse.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CxiFRDtp5qqk6Bo0ku32SWQukLFTF8Compi0RCGR9bw=;
 b=msTqFvnRpN8xjA7liweI1Ed94Es5KNBUKc1CKyr4iSeG4zW85JbUYetwPKqz1NI6r/x8UlHZLuLWkeZtxQuGUAfktNApZnbztFXgKXDXpHTdwvocOVGcaFg12vETgAVyP/ztrasBt+WQg5jlrDkYE+SqncGDnTIzS3/z5Aus6E0=
Received: from DM6PR03CA0011.namprd03.prod.outlook.com (2603:10b6:5:40::24) by
 CH3PR12MB9196.namprd12.prod.outlook.com (2603:10b6:610:197::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7025.21; Fri, 24 Nov 2023 10:33:11 +0000
Received: from CY4PEPF0000EDD1.namprd03.prod.outlook.com
 (2603:10b6:5:40:cafe::1d) by DM6PR03CA0011.outlook.office365.com
 (2603:10b6:5:40::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.21 via Frontend
 Transport; Fri, 24 Nov 2023 10:33:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD1.mail.protection.outlook.com (10.167.241.205) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7025.12 via Frontend Transport; Fri, 24 Nov 2023 10:33:11 +0000
Received: from cjq-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 24 Nov
 2023 04:33:04 -0600
From:   Jiqian Chen <Jiqian.Chen@amd.com>
To:     Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Boris Ostrovsky" <boris.ostrovsky@oracle.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>,
        <xen-devel@lists.xenproject.org>, <linux-kernel@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>
CC:     Stefano Stabellini <stefano.stabellini@amd.com>,
        Alex Deucher <Alexander.Deucher@amd.com>,
        Christian Koenig <Christian.Koenig@amd.com>,
        Stewart Hildebrand <Stewart.Hildebrand@amd.com>,
        Xenia Ragiadakou <xenia.ragiadakou@amd.com>,
        Honglei Huang <Honglei1.Huang@amd.com>,
        "Julia Zhang" <Julia.Zhang@amd.com>, Huang Rui <Ray.Huang@amd.com>,
        Jiqian Chen <Jiqian.Chen@amd.com>,
        Huang Rui <ray.huang@amd.com>
Subject: [RFC KERNEL PATCH v2 3/3] xen/privcmd: Add new syscall to get gsi from irq
Date:   Fri, 24 Nov 2023 18:31:23 +0800
Message-ID: <20231124103123.3263471-4-Jiqian.Chen@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231124103123.3263471-1-Jiqian.Chen@amd.com>
References: <20231124103123.3263471-1-Jiqian.Chen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD1:EE_|CH3PR12MB9196:EE_
X-MS-Office365-Filtering-Correlation-Id: 80ea1451-a9bb-427e-cf1a-08dbecd8c1e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qNlkV3KqrC0RcB1olsj+8U2+ITAJfIdDp+h2cntHYuQMWOmB+0cxyXJ+14LBLnvlJrIvGAv5IVYEf8PXuuzQnj9B1jGYso0DxwYAFLnBMykDWt9p7cQVB6W9sCBxsC0pyCJLQkBC5YjHmBJzBEPx7pXFPbKiK5+weT2SskjYhPY31DrwEXrCzNbVRMcbkxsLyr9g422xYvxUhcduWLHGhGcfxh8Gp5K7Hue+9ETbvLCiddAmodXERWNO4QC3E1BhZI4EtJfyyqyL+3+SkmOicm1TwHwEMV+zehY3b7aAoj24/LfqCZni2oLoyshCzp2vjb7tpWgGoPz+4iZQ4wME+Opl1a59MmpmulPMhWG1jbyv+bApVDnJb58HGH4jzUAPmUljfJ0xGufEF35KT4ZoEcv3RkgxuLxIG3tAuWV1fb4Ky6Lk3k0WSCUyc2L+jbakE27Uy+53WCEzVp+U1aE0hcOzLg93WeM4FJDeDCZ9OeUR2QU77p/neNVXxIzJT0hnmgrPenbMOFEgqwtGzjCK0pzu3uSyLg4Dwr+bxwOdVJP+dTMbeYxUoUuYW1OYuiu3pOn98o3svHDYYeLHlW5DUK3UidG1TsbuIgnt5GQyuJzcjW6nZVYabHQ1QuinxoPHI070uaeHGBjB3glGYETXQhvHudGS3OLDaRBMSxmTQs3/KN/8PCsKW/PpksjznNiE8VbvXXz5t12gmHhN7W88L5gGloncafAY6QVcIbpmgpB2KAwHPVsyXDhsCJGH0Dd2bGriAD+pbf0EGVZRQKhj9tT/2JljvRc1860UlRQynpQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(346002)(396003)(39860400002)(376002)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(82310400011)(36840700001)(40470700004)(46966006)(36756003)(41300700001)(36860700001)(2616005)(356005)(47076005)(16526019)(426003)(336012)(26005)(40480700001)(7696005)(81166007)(1076003)(83380400001)(82740400003)(40460700003)(478600001)(6666004)(110136005)(316002)(70206006)(70586007)(54906003)(2906002)(921008)(8936002)(8676002)(4326008)(86362001)(7416002)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2023 10:33:11.2117
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 80ea1451-a9bb-427e-cf1a-08dbecd8c1e5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9196
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In PVH dom0, it uses the linux local interrupt mechanism,
when it allocs irq for a gsi, it is dynamic, and follow
the principle of applying first, distributing first. And
if you debug the codes, you will find the irq number is
alloced from small to large, but the applying gsi number
is not, may gsi 38 comes before gsi 28, it causes the irq
number is not equal with the gsi number.
And when we passthrough a device, QEMU will use device's gsi
number to do mapping actions, see xen_pt_realize->
xc_physdev_map_pirq, but the gsi number is got from file
/sys/bus/pci/devices/xxxx:xx:xx.x/irq, irq!= gsi, so it will
fail when mapping.
And in current linux codes, there is no method to translate
irq to gsi for userspace.

For above purpose, this patch record the relationship of gsi
and irq when PVH dom0 do acpi_register_gsi_ioapic for devices
and adds a new syscall into privcmd to let userspace can get
that translation when they have a need.

Signed-off-by: Jiqian Chen <Jiqian.Chen@amd.com>
Signed-off-by: Huang Rui <ray.huang@amd.com>
---
 arch/x86/include/asm/apic.h      |  7 ++++++
 arch/x86/include/asm/xen/pci.h   |  5 ++++
 arch/x86/kernel/acpi/boot.c      |  2 +-
 arch/x86/pci/xen.c               | 21 +++++++++++++++++
 drivers/xen/events/events_base.c | 39 ++++++++++++++++++++++++++++++++
 drivers/xen/privcmd.c            | 20 ++++++++++++++++
 include/uapi/xen/privcmd.h       |  7 ++++++
 include/xen/events.h             |  5 ++++
 8 files changed, 105 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
index d21f48f1c242..5646444285ac 100644
--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -169,6 +169,8 @@ extern bool apic_needs_pit(void);
 
 extern void apic_send_IPI_allbutself(unsigned int vector);
 
+extern int acpi_register_gsi_ioapic(struct device *dev, u32 gsi,
+				    int trigger, int polarity);
 #else /* !CONFIG_X86_LOCAL_APIC */
 static inline void lapic_shutdown(void) { }
 #define local_apic_timer_c2_ok		1
@@ -183,6 +185,11 @@ static inline void apic_intr_mode_init(void) { }
 static inline void lapic_assign_system_vectors(void) { }
 static inline void lapic_assign_legacy_vector(unsigned int i, bool r) { }
 static inline bool apic_needs_pit(void) { return true; }
+static inline int acpi_register_gsi_ioapic(struct device *dev, u32 gsi,
+				    int trigger, int polarity)
+{
+	return (int)gsi;
+}
 #endif /* !CONFIG_X86_LOCAL_APIC */
 
 #ifdef CONFIG_X86_X2APIC
diff --git a/arch/x86/include/asm/xen/pci.h b/arch/x86/include/asm/xen/pci.h
index 9015b888edd6..aa8ded61fc2d 100644
--- a/arch/x86/include/asm/xen/pci.h
+++ b/arch/x86/include/asm/xen/pci.h
@@ -5,6 +5,7 @@
 #if defined(CONFIG_PCI_XEN)
 extern int __init pci_xen_init(void);
 extern int __init pci_xen_hvm_init(void);
+extern int __init pci_xen_pvh_init(void);
 #define pci_xen 1
 #else
 #define pci_xen 0
@@ -13,6 +14,10 @@ static inline int pci_xen_hvm_init(void)
 {
 	return -1;
 }
+static inline int pci_xen_pvh_init(void)
+{
+	return -1;
+}
 #endif
 #ifdef CONFIG_XEN_PV_DOM0
 int __init pci_xen_initial_domain(void);
diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index d0918a75cb00..45b157e18c0b 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -739,7 +739,7 @@ static int acpi_register_gsi_pic(struct device *dev, u32 gsi,
 }
 
 #ifdef CONFIG_X86_LOCAL_APIC
-static int acpi_register_gsi_ioapic(struct device *dev, u32 gsi,
+int acpi_register_gsi_ioapic(struct device *dev, u32 gsi,
 				    int trigger, int polarity)
 {
 	int irq = gsi;
diff --git a/arch/x86/pci/xen.c b/arch/x86/pci/xen.c
index 652cd53e77f6..f056ab5c0a06 100644
--- a/arch/x86/pci/xen.c
+++ b/arch/x86/pci/xen.c
@@ -114,6 +114,21 @@ static int acpi_register_gsi_xen_hvm(struct device *dev, u32 gsi,
 				 false /* no mapping of GSI to PIRQ */);
 }
 
+static int acpi_register_gsi_xen_pvh(struct device *dev, u32 gsi,
+				    int trigger, int polarity)
+{
+	int irq;
+
+	irq = acpi_register_gsi_ioapic(dev, gsi, trigger, polarity);
+	if (irq < 0)
+		return irq;
+
+	if (xen_pvh_add_gsi_irq_map(gsi, irq) == -EEXIST)
+		printk(KERN_INFO "Already map the GSI :%u and IRQ: %d\n", gsi, irq);
+
+	return irq;
+}
+
 #ifdef CONFIG_XEN_PV_DOM0
 static int xen_register_gsi(u32 gsi, int triggering, int polarity)
 {
@@ -558,6 +573,12 @@ int __init pci_xen_hvm_init(void)
 	return 0;
 }
 
+int __init pci_xen_pvh_init(void)
+{
+	__acpi_register_gsi = acpi_register_gsi_xen_pvh;
+	return 0;
+}
+
 #ifdef CONFIG_XEN_PV_DOM0
 int __init pci_xen_initial_domain(void)
 {
diff --git a/drivers/xen/events/events_base.c b/drivers/xen/events/events_base.c
index 6de6b084ea60..a02d62955509 100644
--- a/drivers/xen/events/events_base.c
+++ b/drivers/xen/events/events_base.c
@@ -957,6 +957,43 @@ int xen_irq_from_gsi(unsigned gsi)
 }
 EXPORT_SYMBOL_GPL(xen_irq_from_gsi);
 
+int xen_gsi_from_irq(unsigned irq)
+{
+	struct irq_info *info;
+
+	list_for_each_entry(info, &xen_irq_list_head, list) {
+		if (info->type != IRQT_PIRQ)
+			continue;
+
+		if (info->irq == irq)
+			return info->u.pirq.gsi;
+	}
+
+	return -1;
+}
+EXPORT_SYMBOL_GPL(xen_gsi_from_irq);
+
+int xen_pvh_add_gsi_irq_map(unsigned gsi, unsigned irq)
+{
+	int tmp_irq;
+	struct irq_info *info;
+
+	tmp_irq = xen_irq_from_gsi(gsi);
+	if (tmp_irq != -1)
+		return -EEXIST;
+
+	info = kzalloc(sizeof(*info), GFP_KERNEL);
+	if (info == NULL)
+		panic("Unable to allocate metadata for GSI%d\n", gsi);
+
+	info->type = IRQT_PIRQ;
+	info->irq = irq;
+	info->u.pirq.gsi = gsi;
+	list_add_tail(&info->list, &xen_irq_list_head);
+
+	return 0;
+}
+
 static void __unbind_from_irq(unsigned int irq)
 {
 	evtchn_port_t evtchn = evtchn_from_irq(irq);
@@ -2303,6 +2340,8 @@ void __init xen_init_IRQ(void)
 	xen_init_setup_upcall_vector();
 	xen_alloc_callback_vector();
 
+	if (xen_pvh_domain())
+		pci_xen_pvh_init();
 
 	if (xen_hvm_domain()) {
 		native_init_IRQ();
diff --git a/drivers/xen/privcmd.c b/drivers/xen/privcmd.c
index 1ce7f3c7a950..6fa8a01d8ae6 100644
--- a/drivers/xen/privcmd.c
+++ b/drivers/xen/privcmd.c
@@ -45,6 +45,7 @@
 #include <xen/page.h>
 #include <xen/xen-ops.h>
 #include <xen/balloon.h>
+#include <xen/events.h>
 
 #include "privcmd.h"
 
@@ -842,6 +843,21 @@ static long privcmd_ioctl_mmap_resource(struct file *file,
 	return rc;
 }
 
+static long privcmd_ioctl_gsi_from_irq(struct file *file, void __user *udata)
+{
+	struct privcmd_gsi_from_irq kdata;
+
+	if (copy_from_user(&kdata, udata, sizeof(kdata)))
+		return -EFAULT;
+
+	kdata.gsi = xen_gsi_from_irq(kdata.irq);
+
+	if (copy_to_user(udata, &kdata, sizeof(kdata)))
+		return -EFAULT;
+
+	return 0;
+}
+
 #ifdef CONFIG_XEN_PRIVCMD_EVENTFD
 /* Irqfd support */
 static struct workqueue_struct *irqfd_cleanup_wq;
@@ -1534,6 +1550,10 @@ static long privcmd_ioctl(struct file *file,
 		ret = privcmd_ioctl_ioeventfd(file, udata);
 		break;
 
+	case IOCTL_PRIVCMD_GSI_FROM_IRQ:
+		ret = privcmd_ioctl_gsi_from_irq(file, udata);
+		break;
+
 	default:
 		break;
 	}
diff --git a/include/uapi/xen/privcmd.h b/include/uapi/xen/privcmd.h
index 8b8c5d1420fe..61f0ffbec077 100644
--- a/include/uapi/xen/privcmd.h
+++ b/include/uapi/xen/privcmd.h
@@ -126,6 +126,11 @@ struct privcmd_ioeventfd {
 	__u8 pad[2];
 };
 
+struct privcmd_gsi_from_irq {
+	__u32 irq;
+	__u32 gsi;
+};
+
 /*
  * @cmd: IOCTL_PRIVCMD_HYPERCALL
  * @arg: &privcmd_hypercall_t
@@ -157,5 +162,7 @@ struct privcmd_ioeventfd {
 	_IOW('P', 8, struct privcmd_irqfd)
 #define IOCTL_PRIVCMD_IOEVENTFD					\
 	_IOW('P', 9, struct privcmd_ioeventfd)
+#define IOCTL_PRIVCMD_GSI_FROM_IRQ				\
+	_IOC(_IOC_NONE, 'P', 10, sizeof(struct privcmd_gsi_from_irq))
 
 #endif /* __LINUX_PUBLIC_PRIVCMD_H__ */
diff --git a/include/xen/events.h b/include/xen/events.h
index 23932b0673dc..78377c936efe 100644
--- a/include/xen/events.h
+++ b/include/xen/events.h
@@ -131,6 +131,11 @@ int xen_pirq_from_irq(unsigned irq);
 /* Return the irq allocated to the gsi */
 int xen_irq_from_gsi(unsigned gsi);
 
+/* Return the gsi from irq */
+int xen_gsi_from_irq(unsigned irq);
+
+int xen_pvh_add_gsi_irq_map(unsigned gsi, unsigned irq);
+
 /* Determine whether to ignore this IRQ if it is passed to a guest. */
 int xen_test_irq_shared(int irq);
 
-- 
2.34.1

