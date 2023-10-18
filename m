Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8D237CDFD7
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 16:31:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345664AbjJRObW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 10:31:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345738AbjJRObH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 10:31:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75D2B24B1D;
        Wed, 18 Oct 2023 07:22:34 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DA6FC433C8;
        Wed, 18 Oct 2023 14:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697638570;
        bh=8ApVyFM3ieRgIXR30RUL7sm2tVCE9iYbitpYpVOU1V4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NIbm3Z1CNp3Qq3vJHvZqU+mJRnhjJOBRtvXKDnFRfx6aBg7A6sZOlBY4rvHY/ltAs
         twjThZQ5rfhaOjrpY28qBZ2OAiexxx4PdNIWgDjQwWYpcQLd7AaqjejAE27MJXMxAk
         EMy9YKNuwaZ6xE/qMNGGvk172z8xo/8AZa+htYymSreJ7a8DkuC06Pao5VnbxyGsw1
         3rxt3X6go70nppPXC6A+kdg0NoDaaRPm8USKzVPRFKMprsHG9qgJL1OZteOhzF3VrB
         EdS1JpFP74Bhl2EyQOSZxiIzQD2tml8wqOfjEDwwe4tAALgiUqs22mbW+lFtK+5gVX
         16+GIByYl1fIw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Javier Carrasco <javier.carrasco.cruz@gmail.com>,
        syzbot+0434ac83f907a1dbdd1e@syzkaller.appspotmail.com,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <sashal@kernel.org>, linux-input@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 7/7] Input: powermate - fix use-after-free in powermate_config_complete
Date:   Wed, 18 Oct 2023 10:15:46 -0400
Message-Id: <20231018141548.1335665-7-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231018141548.1335665-1-sashal@kernel.org>
References: <20231018141548.1335665-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.296
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
index e8de3aaf9f633..14f48e10f589e 100644
--- a/drivers/input/misc/powermate.c
+++ b/drivers/input/misc/powermate.c
@@ -424,6 +424,7 @@ static void powermate_disconnect(struct usb_interface *intf)
 		pm->requires_update = 0;
 		usb_kill_urb(pm->irq);
 		input_unregister_device(pm->input);
+		usb_kill_urb(pm->config);
 		usb_free_urb(pm->irq);
 		usb_free_urb(pm->config);
 		powermate_free_buffers(interface_to_usbdev(intf), pm);
-- 
2.40.1

