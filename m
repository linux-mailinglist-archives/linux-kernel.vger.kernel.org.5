Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89E7577F382
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 11:35:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349722AbjHQJfC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 05:35:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349781AbjHQJem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 05:34:42 -0400
Received: from smtp-relay-canonical-1.canonical.com (smtp-relay-canonical-1.canonical.com [185.125.188.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD19435A8;
        Thu, 17 Aug 2023 02:34:09 -0700 (PDT)
Received: from localhost.localdomain (unknown [10.101.196.174])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 245853FE17;
        Thu, 17 Aug 2023 09:34:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1692264848;
        bh=Ksqpp/XvRCKKjK7S7YJcjvhjgnscGVeofJ7gCfAd86Q=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=rt8GZZyCn3AngVpK1jkE0NLRSd0BNDiyMLXEd1kibZa5tnMB0Z9EwbbJuXNHYpcnI
         Pkkm3h3Qnv4GRs2rt+5cBig1cKUdyAloJ7SiUfgnV6jq3B3fGI7zEbW7MOxs4Ou+i2
         2pVap5Tx+Y0AfFeyxhplQugu0d30xcd17Lrrs5DwYW4WD7ZdlwE7ObKh3zLKGFUdVJ
         XuH/f6FpxlG3To1H4aOLVcvP3H8BgSLTdye0bP1N52AFhovan65QFgEKxfxCIbpVP7
         9l2S7D6lQxkuFIFgo9nnXkvaDz0Ft530CJWNONdvzLUjBFDbELP8zQpUtMa+JGUi+I
         FDPKXlVVmIZow==
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     mathias.nyman@intel.com
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] xhci: Disable connect, disconnect and over-current wakeup on system suspend
Date:   Thu, 17 Aug 2023 17:33:05 +0800
Message-Id: <20230817093305.212821-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
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

HP ProOne 440 G10 AIO sometimes cannot suspend as xHCI wakes up the
system:
[  445.814574] hub 2-0:1.0: hub_suspend
[  445.814652] usb usb2: bus suspend, wakeup 0
[  445.824629] xhci_hcd 0000:00:14.0: Port change event, 1-11, id 11, portsc: 0x202a0
[  445.824639] xhci_hcd 0000:00:14.0: resume root hub
[  445.824651] xhci_hcd 0000:00:14.0: handle_port_status: starting usb1 port polling.
[  445.844039] xhci_hcd 0000:00:14.0: PM: pci_pm_suspend(): hcd_pci_suspend+0x0/0x20 returns -16
[  445.844058] xhci_hcd 0000:00:14.0: PM: dpm_run_callback(): pci_pm_suspend+0x0/0x1c0 returns -16
[  445.844072] xhci_hcd 0000:00:14.0: PM: failed to suspend async: error -16
[  446.276101] PM: Some devices failed to suspend, or early wake event detected

The system is designed to let display and touchpanel share the same
power source, so when the display becomes off, the USB touchpanel also
lost its power and disconnect itself from USB bus. That doesn't play
well when most Desktop Environment lock and turnoff the display right
before entering system suspend.

So for system-wide suspend, also disable connect, disconnect and
over-current wakeup to prevent spurious wakeup.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/usb/host/xhci.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index fae994f679d4..dc499100efa6 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -16,6 +16,7 @@
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/slab.h>
+#include <linux/suspend.h>
 #include <linux/dmi.h>
 #include <linux/dma-mapping.h>
 
@@ -789,7 +790,7 @@ static void xhci_disable_hub_port_wake(struct xhci_hcd *xhci,
 		t2 = t1;
 
 		/* clear wake bits if do_wake is not set */
-		if (!do_wakeup)
+		if (!do_wakeup || pm_suspend_target_state != PM_SUSPEND_ON)
 			t2 &= ~PORT_WAKE_BITS;
 
 		/* Don't touch csc bit if connected or connect change is set */
-- 
2.34.1

