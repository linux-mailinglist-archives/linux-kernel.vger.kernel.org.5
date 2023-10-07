Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C56567BC22E
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 00:20:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233750AbjJFWUB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 18:20:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233545AbjJFWT7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 18:19:59 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDC7EBD;
        Fri,  6 Oct 2023 15:19:57 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37E9EC433C8;
        Fri,  6 Oct 2023 22:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696630797;
        bh=WGyqp51USRKGjf5xzGkqKPciBO+afTjUzN5NoFsInhk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=GtY6ChTdMyFPhMz7PFi1cYgRvcMxAesQx7AC9iOKiRU3OyJ1078UhZ+GkOeibMFDE
         p/ue0rDkC/tnITau1VzILI/K4r8vM/0hG00cOggq8MtI8140P/B7Bwwg7jr1iAyS4/
         RMyfAWj2i3q9ZKgxRluy9KE48o9ggeStHXdhxTJUwRS3EGZy9zH0Sr/4GsD5IeiahR
         khbiWHZ9erTlCZtDttupbkRtlAYyxeevyOssKHbm5yBqXFPbd9HAANFlXIBsCI8VX2
         Liz/sxBBe8sRs1smRcUB1l+3qK2sOuYjvtN7E1RYMlj8cfwYgTxncYLpug4otRJjL0
         LbLv8g5IkGAmg==
Date:   Fri, 6 Oct 2023 17:19:55 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Sui Jingfeng <sui.jingfeng@linux.dev>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        Chia-I Wu <olvaffe@gmail.com>, linux-pci@vger.kernel.org,
        Sui Jingfeng <suijingfeng@loongson.cn>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [-next 0/5] Add the pci_is_vga() helper and use it
Message-ID: <20231006221955.GA874670@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230830111532.444535-1-sui.jingfeng@linux.dev>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 30, 2023 at 07:15:27PM +0800, Sui Jingfeng wrote:
> From: Sui Jingfeng <suijingfeng@loongson.cn>
> 
> The PCI code and ID assignment specification defined four types of
> display controllers for the display base class(03h), and the devices
> with 0x00h sub-class code are VGA devices. VGA devices with programming
> interface 0x00 is VGA-compatible, VGA devices with programming interface
> 0x01 are 8514-compatible controllers. Besides, PCI_CLASS_NOT_DEFINED_VGA
> is defined to provide backward compatibility for devices that were built
> before the class code field was defined. Thus, PCI(e) device with the
> PCI_CLASS_NOT_DEFINED_VGA class code should also be handled as the normal
> VGA-compatible devices.
> 
> Compared with the "if ((pdev->class >> 8) != PCI_CLASS_DISPLAY_VGA)" code,
> the newly implemented pci_is_vga() is shorter and straightforward. So it
> is more easy to use. It is designed as a inline function, the more common
> case "if ((pdev->class >> 8) == PCI_CLASS_DISPLAY_VGA))" is put before the
> less common case "if ((pdev->class >> 8) == PCI_CLASS_NOT_DEFINED_VGA)",
> so there should no performance penalty.
> 
> Sui Jingfeng (5):
>   PCI: Add the pci_is_vga() helper
>   PCI/VGA: Deal with VGA devices
>   PCI/sysfs: Use pci_is_vga() helper
>   drm/virgpu: Switch to pci_is_vga()
>   drm/qxl: Switch to pci_is_vga()
> 
>  drivers/gpu/drm/qxl/qxl_drv.c        | 11 +++--------
>  drivers/gpu/drm/virtio/virtgpu_drv.c |  2 +-
>  drivers/pci/pci-sysfs.c              |  6 +++---
>  drivers/pci/vgaarb.c                 | 19 +++++++++----------
>  include/linux/pci.h                  | 27 +++++++++++++++++++++++++++
>  5 files changed, 43 insertions(+), 22 deletions(-)

I applied these on pci/vga for v6.7, thanks!

Please take a look at
https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/log/?h=vga
and let me know if I broke anything because I changed a few things;
interdiff below:

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 522708938563..252ee29fd697 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -1551,9 +1551,8 @@ static umode_t pci_dev_attrs_are_visible(struct kobject *kobj,
 	struct device *dev = kobj_to_dev(kobj);
 	struct pci_dev *pdev = to_pci_dev(dev);
 
-	if (a == &dev_attr_boot_vga.attr)
-		if (pci_is_vga(pdev))
-			return a->mode;
+	if (a == &dev_attr_boot_vga.attr && pci_is_vga(pdev))
+		return a->mode;
 
 	return 0;
 }
diff --git a/drivers/pci/vgaarb.c b/drivers/pci/vgaarb.c
index ef8fe685de67..feca96fc4255 100644
--- a/drivers/pci/vgaarb.c
+++ b/drivers/pci/vgaarb.c
@@ -1499,6 +1499,7 @@ static int pci_notify(struct notifier_block *nb, unsigned long action,
 
 	vgaarb_dbg(dev, "%s\n", __func__);
 
+	/* Only deal with VGA class devices */
 	if (!pci_is_vga(pdev))
 		return 0;
 
@@ -1536,8 +1537,8 @@ static struct miscdevice vga_arb_device = {
 
 static int __init vga_arb_device_init(void)
 {
-	struct pci_dev *pdev = NULL;
 	int rc;
+	struct pci_dev *pdev;
 
 	rc = misc_register(&vga_arb_device);
 	if (rc < 0)
@@ -1546,11 +1547,13 @@ static int __init vga_arb_device_init(void)
 	bus_register_notifier(&pci_bus_type, &pci_notifier);
 
 	/* Add all VGA class PCI devices by default */
-	do {
-		pdev = pci_get_subsys(PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID, pdev);
+	pdev = NULL;
+	while ((pdev =
+		pci_get_subsys(PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
+			       PCI_ANY_ID, pdev)) != NULL) {
 		if (pci_is_vga(pdev))
 			vga_arbiter_add_pci_device(pdev);
-	} while (pdev);
+	}
 
 	pr_info("loaded\n");
 	return rc;
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 53e24e31c27e..7bab234391cb 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -714,23 +714,20 @@ static inline bool pci_is_bridge(struct pci_dev *dev)
 }
 
 /**
- * The PCI code and ID assignment specification defined four types of
- * display controllers for the display base class(03h), and the devices
- * with 0x00h sub-class code are VGA devices. VGA devices with programming
- * interface 0x00 is VGA-compatible, VGA devices with programming interface
- * 0x01 are 8514-compatible controllers. Besides, PCI_CLASS_NOT_DEFINED_VGA
- * is defined to provide backward compatibility for devices that were built
- * before the class code field was defined. This means that it belong to the
- * VGA devices category also.
+ * pci_is_vga - check if the PCI device is a VGA device
  *
- * Returns:
- * true if the PCI device is a VGA device, false otherwise.
+ * The PCI Code and ID Assignment spec, r1.15, secs 1.4 and 1.1, define
+ * VGA Base Class and Sub-Classes:
+ *
+ *   03 00  PCI_CLASS_DISPLAY_VGA      VGA-compatible or 8514-compatible
+ *   00 01  PCI_CLASS_NOT_DEFINED_VGA  VGA-compatible (before Class Code)
+ *
+ * Return true if the PCI device is a VGA device and uses the legacy VGA
+ * resources ([mem 0xa0000-0xbffff], [io 0x3b0-0x3bb], [io 0x3c0-0x3df] and
+ * aliases).
  */
 static inline bool pci_is_vga(struct pci_dev *pdev)
 {
-	if (!pdev)
-		return false;
-
 	if ((pdev->class >> 8) == PCI_CLASS_DISPLAY_VGA)
 		return true;
 
