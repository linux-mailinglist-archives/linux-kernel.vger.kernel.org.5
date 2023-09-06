Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16A0D794583
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 23:57:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244856AbjIFV5Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 17:57:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238311AbjIFV5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 17:57:24 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A7A7172E;
        Wed,  6 Sep 2023 14:57:20 -0700 (PDT)
Date:   Wed, 06 Sep 2023 21:57:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694037438;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3qe6SZp7PK7Xw1ozwqNGjFk1GaFSsClf3kAtxy4JikE=;
        b=A8WEpD8fqLikB+Je+9FIdVgAzyhJiurtPF2wKygw2cMe4nSKA04lcy+ShJGjGmaQUk7nDy
        6DDVSiqhqrK2+tCJdDggDFQfUFCnw2hw2EkCKcWb9AeK+iyTqkl4eH6Ktdjvs6snCPHok0
        UugZQS3wigVN6hZ0LKVIIQqUXN4M+aS9Y0ZsKLgGdqM0f65CNcBXsXT8VBgAM4Aiq+DYaY
        3EttC23JU1kDcT/+igBVIxlmfuLFoPiH5d/4dTeuyiQ9jX1wsRJKCiFHkYVp4bwE+KoBxq
        TZU/jaGFyuLpeWJA6d4GMx9K6k9UkEym9aILC4UoHf9DVnDAWoqCiarXtRG6Dw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694037438;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3qe6SZp7PK7Xw1ozwqNGjFk1GaFSsClf3kAtxy4JikE=;
        b=CRYucvlVZcK+39QX9ZDOyIKJ/MWQ7ysnSTlnM0xUE1XJbDa7410jPstGToJydNBjrT1+mS
        rruMetmsVZxjvICw==
From:   "tip-bot2 for Song Liu" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/build: Fix linker fill bytes
 quirk/incompatibility for ld.lld
Cc:     Song Liu <song@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230906175215.2236033-1-song@kernel.org>
References: <20230906175215.2236033-1-song@kernel.org>
MIME-Version: 1.0
Message-ID: <169403743756.27769.4802517361429397352.tip-bot2@tip-bot2>
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

Commit-ID:     65e710899fd19f435f40268f3a92dfaa11f14470
Gitweb:        https://git.kernel.org/tip/65e710899fd19f435f40268f3a92dfaa11f14470
Author:        Song Liu <song@kernel.org>
AuthorDate:    Wed, 06 Sep 2023 10:52:15 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 06 Sep 2023 23:49:12 +02:00

x86/build: Fix linker fill bytes quirk/incompatibility for ld.lld

With ":text =0xcccc", ld.lld fills unused text area with 0xcccc0000.
Example objdump -D output:

	ffffffff82b04203:       00 00                   add    %al,(%rax)
	ffffffff82b04205:       cc                      int3
	ffffffff82b04206:       cc                      int3
	ffffffff82b04207:       00 00                   add    %al,(%rax)
	ffffffff82b04209:       cc                      int3
	ffffffff82b0420a:       cc                      int3

Replace it with ":text =0xcccccccc", so we get the following instead:

	ffffffff82b04203:       cc                      int3
	ffffffff82b04204:       cc                      int3
	ffffffff82b04205:       cc                      int3
	ffffffff82b04206:       cc                      int3
	ffffffff82b04207:       cc                      int3
	ffffffff82b04208:       cc                      int3

gcc/ld doesn't seem to have the same issue. The generated code stays the
same for gcc/ld.

Signed-off-by: Song Liu <song@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Fixes: 7705dc855797 ("x86/vmlinux: Use INT3 instead of NOP for linker fill bytes")
Link: https://lore.kernel.org/r/20230906175215.2236033-1-song@kernel.org
---
 arch/x86/kernel/vmlinux.lds.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 83d41c2..f15fb71 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -156,7 +156,7 @@ SECTIONS
 		ALIGN_ENTRY_TEXT_END
 		*(.gnu.warning)
 
-	} :text =0xcccc
+	} :text = 0xcccccccc
 
 	/* End of text section, which should occupy whole number of pages */
 	_etext = .;
