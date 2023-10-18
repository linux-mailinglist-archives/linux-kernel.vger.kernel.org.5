Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A24657CDF4F
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 16:19:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345279AbjJROS4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 10:18:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345282AbjJROSZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 10:18:25 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27ABC1BFF;
        Wed, 18 Oct 2023 07:15:22 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9B3AC433AB;
        Wed, 18 Oct 2023 14:15:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697638522;
        bh=vGpK+Pi7RyLYmOTT0dOXU/PSvCQL3AhVx2ZeABK+HqQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lBRJyh5ggVZy+mjLiB3NyWBJbrvA3Di+LbBd9k+pKr589slUklFKTNHljLdcaBa5h
         xbbFgH5HLLYrrkNpMahfyfu3+acEkUMYSpB3X8NOoNfnIkm65HvT9vOaIWUcoBQLBR
         J2Aybrn8dvF2SXwK1idhNv1SToe0GolqdPsfA/1muQXPDDyPNXASCp5Ys/Xa2uZKxL
         PYbJLc5mZvv3t2DAW9OO5yhCaQQmJtgrMELZrdaQzuESuNl0Yl8UBcTgP2YvqfF/Q5
         NR1RdNHPOkAyFQTGRFdyLoRxqe40hzywNgkYu3QHd/xpfU286eRm+WZrumnJPk37AA
         4bKaiToDy9HOA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Javier Carrasco <javier.carrasco.cruz@gmail.com>,
        syzbot+0434ac83f907a1dbdd1e@syzkaller.appspotmail.com,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <sashal@kernel.org>, linux-input@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 11/11] Input: powermate - fix use-after-free in powermate_config_complete
Date:   Wed, 18 Oct 2023 10:14:53 -0400
Message-Id: <20231018141455.1335353-11-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231018141455.1335353-1-sashal@kernel.org>
References: <20231018141455.1335353-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.198
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Javier Carrasco <javier.carrasco.cruz@gmail.com>

[ Upstream commit 5c15c60e7be615f05a45cd905093a54b11f461bc ]

syzbot has found a use-after-free bug [1] in the powermate driver. This
happens when the device is disconnected, which leads to a memory free from
the powermate_device struct.  When an asynchronous control message
completes after the kfree and its callback is invoked, the lock does not
exist anymore and hence the bug.

Use usb_kill_urb() on pm->config to cancel any in-progress requests upon
device disconnection.

[1] https://syzkaller.appspot.com/bug?extid=0434ac83f907a1dbdd1e

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Reported-by: syzbot+0434ac83f907a1dbdd1e@syzkaller.appspotmail.com
Link: https://lore.kernel.org/r/20230916-topic-powermate_use_after_free-v3-1-64412b81a7a2@gmail.com
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/input/misc/powermate.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/misc/powermate.c b/drivers/input/misc/powermate.c
index c4e0e1886061f..6b1b95d58e6b5 100644
--- a/drivers/input/misc/powermate.c
+++ b/drivers/input/misc/powermate.c
@@ -425,6 +425,7 @@ static void powermate_disconnect(struct usb_interface *intf)
 		pm->requires_update = 0;
 		usb_kill_urb(pm->irq);
 		input_unregister_device(pm->input);
+		usb_kill_urb(pm->config);
 		usb_free_urb(pm->irq);
 		usb_free_urb(pm->config);
 		powermate_free_buffers(interface_to_usbdev(intf), pm);
-- 
2.40.1

