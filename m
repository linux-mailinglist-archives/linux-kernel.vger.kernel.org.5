Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3AE776E97E
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 15:07:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234220AbjHCNG4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 09:06:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235884AbjHCNGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 09:06:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD1E53C3C;
        Thu,  3 Aug 2023 06:04:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A1C0D61DA6;
        Thu,  3 Aug 2023 13:04:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA118C433C7;
        Thu,  3 Aug 2023 13:04:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691067889;
        bh=86rL97Y8LGSMwqN4UB29phiH/7PV6r8NUnN8AezfSh8=;
        h=From:To:Cc:Subject:Date:From;
        b=qzBdAtG0+WQv9czSqYqQTtciTyODL/3rKsQvkDQNYGuRa7TwZ4sr7sls5ycSUMgUb
         YFgBDN5+7lETFfhRRCZ0BQ4Hzr6QnHdCvyw16xwv3inLYuvsAYcAPEF3DcChFQ9/Rh
         ZMMUNDmfv6WAIz9yKny41sM6m3A5ciHgsRFRiSBenYP8q1OslKi1gh0uL7Pg3mxKt/
         KG0a+Fk9aHrZurvPg0B9SvsdbI8MQ0bi6X9eyVCfVC+r7ElBL+P9tcdTsewPIerVe2
         wGkHNn2SbJ7eQjQK2jCePJ2nXk6QQILY33YTWfEshkklOpj52S8IJqsq9nA4aoVfJ4
         gJZB4A8U9ROrw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        syzbot+63ee658b9a100ffadbe2@syzkaller.appspotmail.com,
        Oliver Neukum <oneukum@suse.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>, davem@davemloft.net,
        edumazet@google.com, pabeni@redhat.com, netdev@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 1/3] net: usbnet: Fix WARNING in usbnet_start_xmit/usb_submit_urb
Date:   Thu,  3 Aug 2023 09:04:43 -0400
Message-Id: <20230803130446.642038-1-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.188
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alan Stern <stern@rowland.harvard.edu>

[ Upstream commit 5e1627cb43ddf1b24b92eb26f8d958a3f5676ccb ]

The syzbot fuzzer identified a problem in the usbnet driver:

usb 1-1: BOGUS urb xfer, pipe 3 != type 1
WARNING: CPU: 0 PID: 754 at drivers/usb/core/urb.c:504 usb_submit_urb+0xed6/0x1880 drivers/usb/core/urb.c:504
Modules linked in:
CPU: 0 PID: 754 Comm: kworker/0:2 Not tainted 6.4.0-rc7-syzkaller-00014-g692b7dc87ca6 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/27/2023
Workqueue: mld mld_ifc_work
RIP: 0010:usb_submit_urb+0xed6/0x1880 drivers/usb/core/urb.c:504
Code: 7c 24 18 e8 2c b4 5b fb 48 8b 7c 24 18 e8 42 07 f0 fe 41 89 d8 44 89 e1 4c 89 ea 48 89 c6 48 c7 c7 a0 c9 fc 8a e8 5a 6f 23 fb <0f> 0b e9 58 f8 ff ff e8 fe b3 5b fb 48 81 c5 c0 05 00 00 e9 84 f7
RSP: 0018:ffffc9000463f568 EFLAGS: 00010086
RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000000000
RDX: ffff88801eb28000 RSI: ffffffff814c03b7 RDI: 0000000000000001
RBP: ffff8881443b7190 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000001 R12: 0000000000000003
R13: ffff88802a77cb18 R14: 0000000000000003 R15: ffff888018262500
FS:  0000000000000000(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000556a99c15a18 CR3: 0000000028c71000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 usbnet_start_xmit+0xfe5/0x2190 drivers/net/usb/usbnet.c:1453
 __netdev_start_xmit include/linux/netdevice.h:4918 [inline]
 netdev_start_xmit include/linux/netdevice.h:4932 [inline]
 xmit_one net/core/dev.c:3578 [inline]
 dev_hard_start_xmit+0x187/0x700 net/core/dev.c:3594
...

This bug is caused by the fact that usbnet trusts the bulk endpoint
addresses its probe routine receives in the driver_info structure, and
it does not check to see that these endpoints actually exist and have
the expected type and directions.

The fix is simply to add such a check.

Reported-and-tested-by: syzbot+63ee658b9a100ffadbe2@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/linux-usb/000000000000a56e9105d0cec021@google.com/
Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
CC: Oliver Neukum <oneukum@suse.com>
Link: https://lore.kernel.org/r/ea152b6d-44df-4f8a-95c6-4db51143dcc1@rowland.harvard.edu
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/usb/usbnet.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/usb/usbnet.c b/drivers/net/usb/usbnet.c
index 43d70348343b2..481a41d879b53 100644
--- a/drivers/net/usb/usbnet.c
+++ b/drivers/net/usb/usbnet.c
@@ -1738,6 +1738,10 @@ usbnet_probe (struct usb_interface *udev, const struct usb_device_id *prod)
 	} else if (!info->in || !info->out)
 		status = usbnet_get_endpoints (dev, udev);
 	else {
+		u8 ep_addrs[3] = {
+			info->in + USB_DIR_IN, info->out + USB_DIR_OUT, 0
+		};
+
 		dev->in = usb_rcvbulkpipe (xdev, info->in);
 		dev->out = usb_sndbulkpipe (xdev, info->out);
 		if (!(info->flags & FLAG_NO_SETINT))
@@ -1747,6 +1751,8 @@ usbnet_probe (struct usb_interface *udev, const struct usb_device_id *prod)
 		else
 			status = 0;
 
+		if (status == 0 && !usb_check_bulk_endpoints(udev, ep_addrs))
+			status = -EINVAL;
 	}
 	if (status >= 0 && dev->status)
 		status = init_status (dev, udev);
-- 
2.40.1

