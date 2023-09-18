Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1712F7A426E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 09:32:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240229AbjIRHbZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 03:31:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240087AbjIRHao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 03:30:44 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3F5F1B6;
        Mon, 18 Sep 2023 00:30:27 -0700 (PDT)
Date:   Mon, 18 Sep 2023 07:30:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1695022224;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8wZ4UPauAaCMdYEQufzFfL5YyIzdQq3MPR1r1SVgLl4=;
        b=gV/7wnWMOU4lraE4apiIHUPDL076zPdl9OfBQoA9MntDwti5ono38fOBi+TrsI/1pD0aVq
        kjHUJvgwawQVxlu1OqATleJ72C8+0W2onarbYb/eF6zn5685jHC+IZydA9IOZRrwxDFovr
        fAiGvDFhg+5YjlY/lbAh1Jj7YLuU0Bx3cXRwptgL71m+zHjogXhNBr/pnG3AVXKYJzCtsj
        eQ22XJogsuDfPu/KIw7GfshqIN1WPf5ldqFyUUxfELMvAQrOFAsXJNZ5+/z8sN9+UgY2jO
        pziHU5tiyvv2NndWcrjaIgasZX3DQZJsGR00Ho6oZexo12lN8UNVGPpdOdCYvg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1695022224;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8wZ4UPauAaCMdYEQufzFfL5YyIzdQq3MPR1r1SVgLl4=;
        b=iA2tcvBEKMxygXC/IF3zAffUqKuhwbR3zGwMVgy51He8e8GkMRGFyaBAPiymmKLtf5W0lT
        HOacWn4X/QByo7AQ==
From:   "tip-bot2 for Rik van Riel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/mm, kexec, ima: Use memblock_free_late() from
 ima_free_kexec_buffer()
Cc:     Mike Rappoport <rppt@kernel.org>, Rik van Riel <riel@surriel.com>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230817135558.67274c83@imladris.surriel.com>
References: <20230817135558.67274c83@imladris.surriel.com>
MIME-Version: 1.0
Message-ID: <169502222333.27769.4548051138666245264.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     34cf99c250d5cd2530b93a57b0de31d3aaf8685b
Gitweb:        https://git.kernel.org/tip/34cf99c250d5cd2530b93a57b0de31d3aaf8685b
Author:        Rik van Riel <riel@surriel.com>
AuthorDate:    Thu, 17 Aug 2023 13:55:58 -04:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 18 Sep 2023 09:24:15 +02:00

x86/mm, kexec, ima: Use memblock_free_late() from ima_free_kexec_buffer()

The code calling ima_free_kexec_buffer() runs long after the memblock
allocator has already been torn down, potentially resulting in a use
after free in memblock_isolate_range().

With KASAN or KFENCE, this use after free will result in a BUG
from the idle task, and a subsequent kernel panic.

Switch ima_free_kexec_buffer() over to memblock_free_late() to avoid
that bug.

Fixes: fee3ff99bc67 ("powerpc: Move arch independent ima kexec functions to drivers/of/kexec.c")
Suggested-by: Mike Rappoport <rppt@kernel.org>
Signed-off-by: Rik van Riel <riel@surriel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20230817135558.67274c83@imladris.surriel.com
---
 arch/x86/kernel/setup.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index b9145a6..b098b1f 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -358,15 +358,11 @@ static void __init add_early_ima_buffer(u64 phys_addr)
 #if defined(CONFIG_HAVE_IMA_KEXEC) && !defined(CONFIG_OF_FLATTREE)
 int __init ima_free_kexec_buffer(void)
 {
-	int rc;
-
 	if (!ima_kexec_buffer_size)
 		return -ENOENT;
 
-	rc = memblock_phys_free(ima_kexec_buffer_phys,
-				ima_kexec_buffer_size);
-	if (rc)
-		return rc;
+	memblock_free_late(ima_kexec_buffer_phys,
+			   ima_kexec_buffer_size);
 
 	ima_kexec_buffer_phys = 0;
 	ima_kexec_buffer_size = 0;
