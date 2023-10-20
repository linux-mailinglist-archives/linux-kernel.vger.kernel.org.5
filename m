Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACDFB7D0EF4
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 13:42:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377516AbjJTLl4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 07:41:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377381AbjJTLla (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 07:41:30 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD9BE2D43;
        Fri, 20 Oct 2023 04:38:26 -0700 (PDT)
Date:   Fri, 20 Oct 2023 11:37:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1697801875;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=47fegGk78WLObql5tga+epDvENs5jZ0xTJTdq0Xxcws=;
        b=U8EKH9cgfN5Y3AKsePYtmHeKkylX2IC9PEXo1gCJlWkS4eupNsSncbQPcrMu0i5PdWj85a
        B5KUZ7fSeh8BvTNMUYpfvTkfAZNHgrUYHiZ+VIz+Im1Yfvt6Osh+krjds70g+/SPWypxGi
        j0iXDFv8krparTCoSR8Lk4jA+hyvbMC1xrlzrhgOW97I1YrZMZHXcTLBkDSLoBfQQgC8Pn
        usT/oU2HuengUHLf7AQ06DdOfg9RQsY/+rlz8UF6waNIJIU3Ibzt/1GlOAsM8Ow3HzeFCj
        Ji+ucn6ANkHkXV8cA2wMBQb/Wnbj41zF+7zZXOlzsxdT04Tg1EPMtzlUPouDJw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1697801875;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=47fegGk78WLObql5tga+epDvENs5jZ0xTJTdq0Xxcws=;
        b=3vsTXnEl16QDLeGsZh83u6Ejdafhyvw3kxiw/7GyU1X2rf1gwo81rWrjw43HMywDZam/pW
        3pWxIhKUp9DX4BDQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/microcode] x86/microcode/amd: Cache builtin microcode too
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231010150702.495139089@linutronix.de>
References: <20231010150702.495139089@linutronix.de>
MIME-Version: 1.0
Message-ID: <169780187520.3135.17318786431537770737.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/microcode branch of tip:

Commit-ID:     78f52b9b8ac34713cb352a90d12fc82d2e8128e3
Gitweb:        https://git.kernel.org/tip/78f52b9b8ac34713cb352a90d12fc82d2e8128e3
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 10 Oct 2023 17:08:43 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Thu, 19 Oct 2023 15:44:35 +02:00

x86/microcode/amd: Cache builtin microcode too

save_microcode_in_initrd_amd() fails to cache builtin microcode and only
scans initrd.

Use find_blobs_in_containers() instead which covers both.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20231010150702.495139089@linutronix.de
---
 arch/x86/kernel/cpu/microcode/amd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/microcode/amd.c b/arch/x86/kernel/cpu/microcode/amd.c
index 56d8bd6..2458379 100644
--- a/arch/x86/kernel/cpu/microcode/amd.c
+++ b/arch/x86/kernel/cpu/microcode/amd.c
@@ -533,7 +533,7 @@ int __init save_microcode_in_initrd_amd(unsigned int cpuid_1_eax)
 	enum ucode_state ret;
 	struct cpio_data cp;
 
-	cp = find_microcode_in_initrd(ucode_path);
+	find_blobs_in_containers(cpuid_1_eax, &cp);
 	if (!(cp.data && cp.size))
 		return -EINVAL;
 
