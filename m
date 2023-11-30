Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F30947FE7B2
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 04:37:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344295AbjK3Dho (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 22:37:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231639AbjK3Dhn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 22:37:43 -0500
Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.219])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0A8DD1B4;
        Wed, 29 Nov 2023 19:37:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=ZQQnG7Xd6nXerp8hNY
        w4rgyz/Uv30Jfz7wNiiBGv9JU=; b=Or7KV+5so84/3kvDLVCgswxFhait3VnExe
        Nte5r1Nducmti/M6QaLchtA+XXsk+nnpcuXjfnjYbld0ezdEYRqvQdG9TMxC290V
        h3mLwRNCK7fMlU0/heS6TK/ki4mteTVkafey1gfgR9SqEUnchj5ZGDajYvl5hRfb
        0e+8SYlLo=
Received: from localhost.localdomain (unknown [39.144.190.126])
        by zwqz-smtp-mta-g2-1 (Coremail) with SMTP id _____wD3_liBA2hlqnEuEQ--.45301S2;
        Thu, 30 Nov 2023 11:37:37 +0800 (CST)
From:   Haoran Liu <liuhaoran14@163.com>
To:     mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Haoran Liu <liuhaoran14@163.com>
Subject: [PATCH] [media] usbtv: Add error handling for usb_submit_urb in usbtv_audio_start
Date:   Wed, 29 Nov 2023 19:37:35 -0800
Message-Id: <20231130033735.36013-1-liuhaoran14@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: _____wD3_liBA2hlqnEuEQ--.45301S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZF4UJw4UKryftF18tr17trb_yoW8Zr48pa
        13Wa15ZFWDJw43ZrnrJFs5Cr1Fvan3tFW8CF9rG39xZws8ta1Yqa40y34a9r48CryxJw13
        tr1qqrW5uwsFv37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zEBTYUUUUUU=
X-Originating-IP: [39.144.190.126]
X-CM-SenderInfo: xolxxtxrud0iqu6rljoofrz/1tbiwhQ4glc662t4DAABs0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces improved error handling for the usb_submit_urb call
in the usbtv_audio_start function. Prior to this change, the function did
not handle the scenario where usb_submit_urb could fail, potentially
leading to inconsistent state and unreliable audio streaming.

Although the error addressed by this patch may not occur in the current
environment, I still suggest implementing these error handling routines
if the function is not highly time-sensitive. As the environment evolves
or the code gets reused in different contexts, there's a possibility that
these errors might occur. Addressing them now can prevent potential
debugging efforts in the future, which could be quite resource-intensive.

Signed-off-by: Haoran Liu <liuhaoran14@163.com>
---
 drivers/media/usb/usbtv/usbtv-audio.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/media/usb/usbtv/usbtv-audio.c b/drivers/media/usb/usbtv/usbtv-audio.c
index 333bd305a4f9..81d6d54fd12c 100644
--- a/drivers/media/usb/usbtv/usbtv-audio.c
+++ b/drivers/media/usb/usbtv/usbtv-audio.c
@@ -172,6 +172,7 @@ static void usbtv_audio_urb_received(struct urb *urb)
 static int usbtv_audio_start(struct usbtv *chip)
 {
 	unsigned int pipe;
+	int err;
 	static const u16 setup[][2] = {
 		/* These seem to enable the device. */
 		{ USBTV_BASE + 0x0008, 0x0001 },
@@ -216,7 +217,15 @@ static int usbtv_audio_start(struct usbtv *chip)
 	usbtv_set_regs(chip, setup, ARRAY_SIZE(setup));
 
 	usb_clear_halt(chip->udev, pipe);
-	usb_submit_urb(chip->snd_bulk_urb, GFP_ATOMIC);
+	err = usb_submit_urb(chip->snd_bulk_urb, GFP_ATOMIC);
+	if (err) {
+		dev_err(&chip->udev->dev,
+			"usb_submit_urb failed: %d\n", err);
+		kfree(chip->snd_bulk_urb->transfer_buffer);
+		usb_free_urb(chip->snd_bulk_urb);
+		chip->snd_bulk_urb = NULL;
+		return err;
+	}
 
 	return 0;
 
-- 
2.17.1

