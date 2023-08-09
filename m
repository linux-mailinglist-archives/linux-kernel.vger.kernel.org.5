Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 395EF7756C5
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 11:58:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231804AbjHIJ6p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 05:58:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbjHIJ6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 05:58:43 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CB2461BFA;
        Wed,  9 Aug 2023 02:58:41 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.201])
        by gateway (Coremail) with SMTP id _____8DxVuhQY9NkLrgTAA--.7322S3;
        Wed, 09 Aug 2023 17:58:40 +0800 (CST)
Received: from localhost.localdomain (unknown [10.20.42.201])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8BxB81DY9Nk3RZRAA--.65284S2;
        Wed, 09 Aug 2023 17:58:39 +0800 (CST)
From:   Yinbo Zhu <zhuyinbo@loongson.cn>
To:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jianmin Lv <lvjianmin@loongson.cn>, wanghongliang@loongson.cn,
        loongson-kernel@lists.loongnix.cn, Yinbo Zhu <zhuyinbo@loongson.cn>
Subject: [PATCH v2] usb: xhci-plat: fix usb disconnect issue after s4
Date:   Wed,  9 Aug 2023 17:58:26 +0800
Message-Id: <20230809095826.18183-1-zhuyinbo@loongson.cn>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxB81DY9Nk3RZRAA--.65284S2
X-CM-SenderInfo: 52kx5xhqerqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
        ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
        nUUI43ZEXa7xR_UUUUUUUUU==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The xhci retaining bogus hardware states cause usb disconnect devices
connected before hibernation(s4) and refer to the commit 'f3d478858be
("usb: ohci-platform: fix usb disconnect issue after s4")' which set
flag "hibernated" as true when resume-from-hibernation and that the
drivers will reset the hardware to get rid of any existing state and
make sure resume from hibernation re-enumerates everything for xhci.

Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
---
Change in v2:
		1. Add CONFIG_PM_SLEEP in xhci_plat_pm_ops that for fix
		   compile issue when CONFIG_PM not enable.

 drivers/usb/host/xhci-plat.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/host/xhci-plat.c b/drivers/usb/host/xhci-plat.c
index 28218c8f1837..112468fdcca2 100644
--- a/drivers/usb/host/xhci-plat.c
+++ b/drivers/usb/host/xhci-plat.c
@@ -451,7 +451,7 @@ static int __maybe_unused xhci_plat_suspend(struct device *dev)
 	return 0;
 }
 
-static int __maybe_unused xhci_plat_resume(struct device *dev)
+static int __maybe_unused xhci_plat_resume_common(struct device *dev, struct pm_message pmsg)
 {
 	struct usb_hcd	*hcd = dev_get_drvdata(dev);
 	struct xhci_hcd	*xhci = hcd_to_xhci(hcd);
@@ -466,7 +466,7 @@ static int __maybe_unused xhci_plat_resume(struct device *dev)
 	if (ret)
 		return ret;
 
-	ret = xhci_resume(xhci, PMSG_RESUME);
+	ret = xhci_resume(xhci, pmsg);
 	if (ret)
 		return ret;
 
@@ -477,6 +477,16 @@ static int __maybe_unused xhci_plat_resume(struct device *dev)
 	return 0;
 }
 
+static int __maybe_unused xhci_plat_resume(struct device *dev)
+{
+	return xhci_plat_resume_common(dev, PMSG_RESUME);
+}
+
+static int __maybe_unused xhci_plat_restore(struct device *dev)
+{
+	return xhci_plat_resume_common(dev, PMSG_RESTORE);
+}
+
 static int __maybe_unused xhci_plat_runtime_suspend(struct device *dev)
 {
 	struct usb_hcd  *hcd = dev_get_drvdata(dev);
@@ -499,8 +509,14 @@ static int __maybe_unused xhci_plat_runtime_resume(struct device *dev)
 }
 
 const struct dev_pm_ops xhci_plat_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(xhci_plat_suspend, xhci_plat_resume)
-
+#ifdef CONFIG_PM_SLEEP
+	.suspend = xhci_plat_suspend,
+	.resume = xhci_plat_resume,
+	.freeze = xhci_plat_suspend,
+	.thaw = xhci_plat_resume,
+	.poweroff = xhci_plat_suspend,
+	.restore = xhci_plat_restore,
+#endif
 	SET_RUNTIME_PM_OPS(xhci_plat_runtime_suspend,
 			   xhci_plat_runtime_resume,
 			   NULL)
-- 
2.20.1

