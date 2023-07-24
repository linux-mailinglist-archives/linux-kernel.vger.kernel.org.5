Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0050175E808
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 03:37:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231810AbjGXBhP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 21:37:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231791AbjGXBgi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 21:36:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D65B59F6;
        Sun, 23 Jul 2023 18:33:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B289A60F25;
        Mon, 24 Jul 2023 01:31:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7336AC433C8;
        Mon, 24 Jul 2023 01:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690162309;
        bh=M6LrzzuU4c4hEekCPHry8e/a9qHh0p6vF4b+LERkyLs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b4NNBqTXa+0MpfvkKkQ8WvbBjOS+32x5ot1fB7zXe/vkQFLVRCZMc6acEO4UP0LEV
         HzSmCxbsxGFqWoVeFTCjxKwcZAW6GLSGX31KWXYTDA23BBlZ94WK100vUCXf3ptdxk
         VLI42Q+BMBevqSBbPjzdFI0n67FntosICmMNqYSaD6cd9dMAmX0TpgoPZFoC9qjC2G
         IMiy7Ug/nmKBXu02jvHS/ZdjRYsUiItpetFpRqAE03wByq+XuHL47ZFfsMj+u6WNkO
         /Q7A9OV53CqDBJ0+whCLSaFVbMDrCebzX/BRf8oHd+JvXvCILWpeQJFtGsLuOi6xIG
         OVcyJyu1eaCHg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Prashanth K <quic_prashk@quicinc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>, balbi@kernel.org,
        linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 6.4 05/40] usb: gadget: u_serial: Avoid spinlock recursion in __gs_console_push
Date:   Sun, 23 Jul 2023 21:31:05 -0400
Message-Id: <20230724013140.2327815-5-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230724013140.2327815-1-sashal@kernel.org>
References: <20230724013140.2327815-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.4.5
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

From: Prashanth K <quic_prashk@quicinc.com>

[ Upstream commit e5990469943c711cb00bfde6338d2add6c6d0bfe ]

When serial console over USB is enabled, gs_console_connect
queues gs_console_work, where it acquires the spinlock and
queues the usb request, and this request goes to gadget layer.
Now consider a situation where gadget layer prints something
to dmesg, this will eventually call gs_console_write() which
requires cons->lock. And this causes spinlock recursion. Avoid
this by excluding usb_ep_queue from the spinlock.

 spin_lock_irqsave //needs cons->lock
 gs_console_write
	.
	.
 _printk
 __warn_printk
 dev_warn/pr_err
	.
	.
 [USB Gadget Layer]
	.
	.
 usb_ep_queue
 gs_console_work
 __gs_console_push // acquires cons->lock
 process_one_work

Signed-off-by: Prashanth K <quic_prashk@quicinc.com>
Link: https://lore.kernel.org/r/1683638872-6885-1-git-send-email-quic_prashk@quicinc.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/gadget/function/u_serial.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/gadget/function/u_serial.c b/drivers/usb/gadget/function/u_serial.c
index a0ca47fbff0fc..1bc96ff954ffe 100644
--- a/drivers/usb/gadget/function/u_serial.c
+++ b/drivers/usb/gadget/function/u_serial.c
@@ -916,8 +916,11 @@ static void __gs_console_push(struct gs_console *cons)
 	}
 
 	req->length = size;
+
+	spin_unlock_irq(&cons->lock);
 	if (usb_ep_queue(ep, req, GFP_ATOMIC))
 		req->length = 0;
+	spin_lock_irq(&cons->lock);
 }
 
 static void gs_console_work(struct work_struct *work)
-- 
2.39.2

