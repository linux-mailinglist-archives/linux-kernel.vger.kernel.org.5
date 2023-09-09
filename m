Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A72FD799412
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 02:39:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240265AbjIIAiy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 20:38:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239795AbjIIAia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 20:38:30 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5C132729;
        Fri,  8 Sep 2023 17:38:01 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48678C116AA;
        Sat,  9 Sep 2023 00:37:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694219859;
        bh=i5ekX9ffQk337N8EgxWQZtzRvmPnFzNxRVWQmADw7ag=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OqJVmVCMH0tnR0kFAldZYStUyOJMIeNgxerKdX40uOSDdZ95/TBU8l3SxNBqbceNJ
         vDLgRAVH6LIV+gcwTrYv0yyrREvEHIoTmSadlHR4PrVKOE/0n7OLLd3oohQvrEsTA8
         QFi3t7lA9afYbARI7eF05jlFgH8RD8dKqiuCzptx1kfdKUU0hPQpK8sm/0LS3aDZmP
         YEjnWN9ZD2G9SrI4ob9wK5yrL2qm1VsDrfMlVaxmebfMvzJzvmuVA8ojmNW2PmisUw
         yY/DHiI3C055/+8P1IYFzCu2kL1iDV2r+TwG2UmK6civ6CU08Pxmln8QZcIkuzajA4
         q4ILYNAG/14cA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Xiaolei Wang <xiaolei.wang@windriver.com>,
        Peter Chen <peter.chen@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, pawell@cadence.com,
        linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 6.4 12/25] usb: cdns3: Put the cdns set active part outside the spin lock
Date:   Fri,  8 Sep 2023 20:37:00 -0400
Message-Id: <20230909003715.3579761-12-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230909003715.3579761-1-sashal@kernel.org>
References: <20230909003715.3579761-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.4.15
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiaolei Wang <xiaolei.wang@windriver.com>

[ Upstream commit 2319b9c87fe243327285f2fefd7374ffd75a65fc ]

The device may be scheduled during the resume process,
so this cannot appear in atomic operations. Since
pm_runtime_set_active will resume suppliers, put set
active outside the spin lock, which is only used to
protect the struct cdns data structure, otherwise the
kernel will report the following warning:

  BUG: sleeping function called from invalid context at drivers/base/power/runtime.c:1163
  in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 651, name: sh
  preempt_count: 1, expected: 0
  RCU nest depth: 0, expected: 0
  CPU: 0 PID: 651 Comm: sh Tainted: G        WC         6.1.20 #1
  Hardware name: Freescale i.MX8QM MEK (DT)
  Call trace:
    dump_backtrace.part.0+0xe0/0xf0
    show_stack+0x18/0x30
    dump_stack_lvl+0x64/0x80
    dump_stack+0x1c/0x38
    __might_resched+0x1fc/0x240
    __might_sleep+0x68/0xc0
    __pm_runtime_resume+0x9c/0xe0
    rpm_get_suppliers+0x68/0x1b0
    __pm_runtime_set_status+0x298/0x560
    cdns_resume+0xb0/0x1c0
    cdns3_controller_resume.isra.0+0x1e0/0x250
    cdns3_plat_resume+0x28/0x40

Signed-off-by: Xiaolei Wang <xiaolei.wang@windriver.com>
Acked-by: Peter Chen <peter.chen@kernel.org>
Link: https://lore.kernel.org/r/20230616021952.1025854-1-xiaolei.wang@windriver.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/cdns3/cdns3-plat.c |  3 ++-
 drivers/usb/cdns3/cdnsp-pci.c  |  3 ++-
 drivers/usb/cdns3/core.c       | 15 +++++++++++----
 drivers/usb/cdns3/core.h       |  7 +++++--
 4 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/cdns3/cdns3-plat.c b/drivers/usb/cdns3/cdns3-plat.c
index 2bc5d094548b6..726b2e4f67e4d 100644
--- a/drivers/usb/cdns3/cdns3-plat.c
+++ b/drivers/usb/cdns3/cdns3-plat.c
@@ -256,9 +256,10 @@ static int cdns3_controller_resume(struct device *dev, pm_message_t msg)
 	cdns3_set_platform_suspend(cdns->dev, false, false);
 
 	spin_lock_irqsave(&cdns->lock, flags);
-	cdns_resume(cdns, !PMSG_IS_AUTO(msg));
+	cdns_resume(cdns);
 	cdns->in_lpm = false;
 	spin_unlock_irqrestore(&cdns->lock, flags);
+	cdns_set_active(cdns, !PMSG_IS_AUTO(msg));
 	if (cdns->wakeup_pending) {
 		cdns->wakeup_pending = false;
 		enable_irq(cdns->wakeup_irq);
diff --git a/drivers/usb/cdns3/cdnsp-pci.c b/drivers/usb/cdns3/cdnsp-pci.c
index 7b151f5af3ccb..0725668ffea4c 100644
--- a/drivers/usb/cdns3/cdnsp-pci.c
+++ b/drivers/usb/cdns3/cdnsp-pci.c
@@ -208,8 +208,9 @@ static int __maybe_unused cdnsp_pci_resume(struct device *dev)
 	int ret;
 
 	spin_lock_irqsave(&cdns->lock, flags);
-	ret = cdns_resume(cdns, 1);
+	ret = cdns_resume(cdns);
 	spin_unlock_irqrestore(&cdns->lock, flags);
+	cdns_set_active(cdns, 1);
 
 	return ret;
 }
diff --git a/drivers/usb/cdns3/core.c b/drivers/usb/cdns3/core.c
index dbcdf3b24b477..7b20d2d5c262e 100644
--- a/drivers/usb/cdns3/core.c
+++ b/drivers/usb/cdns3/core.c
@@ -522,9 +522,8 @@ int cdns_suspend(struct cdns *cdns)
 }
 EXPORT_SYMBOL_GPL(cdns_suspend);
 
-int cdns_resume(struct cdns *cdns, u8 set_active)
+int cdns_resume(struct cdns *cdns)
 {
-	struct device *dev = cdns->dev;
 	enum usb_role real_role;
 	bool role_changed = false;
 	int ret = 0;
@@ -556,15 +555,23 @@ int cdns_resume(struct cdns *cdns, u8 set_active)
 	if (cdns->roles[cdns->role]->resume)
 		cdns->roles[cdns->role]->resume(cdns, cdns_power_is_lost(cdns));
 
+	return 0;
+}
+EXPORT_SYMBOL_GPL(cdns_resume);
+
+void cdns_set_active(struct cdns *cdns, u8 set_active)
+{
+	struct device *dev = cdns->dev;
+
 	if (set_active) {
 		pm_runtime_disable(dev);
 		pm_runtime_set_active(dev);
 		pm_runtime_enable(dev);
 	}
 
-	return 0;
+	return;
 }
-EXPORT_SYMBOL_GPL(cdns_resume);
+EXPORT_SYMBOL_GPL(cdns_set_active);
 #endif /* CONFIG_PM_SLEEP */
 
 MODULE_AUTHOR("Peter Chen <peter.chen@nxp.com>");
diff --git a/drivers/usb/cdns3/core.h b/drivers/usb/cdns3/core.h
index 2d332a788871e..4a4dbc2c15615 100644
--- a/drivers/usb/cdns3/core.h
+++ b/drivers/usb/cdns3/core.h
@@ -125,10 +125,13 @@ int cdns_init(struct cdns *cdns);
 int cdns_remove(struct cdns *cdns);
 
 #ifdef CONFIG_PM_SLEEP
-int cdns_resume(struct cdns *cdns, u8 set_active);
+int cdns_resume(struct cdns *cdns);
 int cdns_suspend(struct cdns *cdns);
+void cdns_set_active(struct cdns *cdns, u8 set_active);
 #else /* CONFIG_PM_SLEEP */
-static inline int cdns_resume(struct cdns *cdns, u8 set_active)
+static inline int cdns_resume(struct cdns *cdns)
+{ return 0; }
+static inline int cdns_set_active(struct cdns *cdns, u8 set_active)
 { return 0; }
 static inline int cdns_suspend(struct cdns *cdns)
 { return 0; }
-- 
2.40.1

