Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3B1F7B5ABD
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 21:04:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238559AbjJBTCd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 15:02:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbjJBTCc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 15:02:32 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FD4AAC;
        Mon,  2 Oct 2023 12:02:29 -0700 (PDT)
Date:   Mon, 02 Oct 2023 19:02:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1696273347;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=9kykBRle4YMK7mud01a1hYzMlSj6W5nGXFWJBDbOBmY=;
        b=p+vQGxcSM58OSSCcFE3oDZ5+j4OyScgJjZPScYZN+b437pQbfkb3VqwTQ1OqOG4Rr0f5jy
        llUUJoJpgg0AAKwOdB3fTghwhi6e7NmQlUwe4V4PbJ1ueA1fOjew9au3RJXpSx+MfzILur
        triwqY/SxNbN4D41Rz4l3LbXlC2tKveJkeT6tC4WFF51qPRv/dfMB7XH2RBeGU3Soyq2d8
        HsrTdmmhKs4FXPMgUbiDPaEzzl0QEZXio364/tX+4UsztbxSH6FYjihmrqAixLRxIjeefj
        9srBknaf2nJrR8HE6CLUeoiqlhC7eewyvHfJCPKOSEY1I0wCLZtFq+tkVy+SNg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1696273347;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=9kykBRle4YMK7mud01a1hYzMlSj6W5nGXFWJBDbOBmY=;
        b=Yl8KGZUjz4bE/sSLu8cjn7TsmZ91ClBmJmPA+QmapRRQlsqU83VAPW9knoSYmZ1aKqbc/n
        9cvNlPbu7zQbwzAw==
From:   "tip-bot2 for Zhiquan Li" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/mce: Set PG_hwpoison page flag to avoid the capture
 kernel panic
Cc:     Youquan Song <youquan.song@intel.com>,
        Zhiquan Li <zhiquan1.li@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <169627334714.3135.12336854585078188172.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     cb17fd1dcdaea8f6508844c690b3ffd5da484800
Gitweb:        https://git.kernel.org/tip/cb17fd1dcdaea8f6508844c690b3ffd5da484800
Author:        Zhiquan Li <zhiquan1.li@intel.com>
AuthorDate:    Thu, 14 Sep 2023 11:05:39 +08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 02 Oct 2023 20:26:13 +02:00

x86/mce: Set PG_hwpoison page flag to avoid the capture kernel panic

Kdump can exclude the HWPoison page to avoid touching the error page
again, the prerequisite is the PG_hwpoison page flag is set.

However, for some MCE fatal error cases, there is no opportunity
to queue a task for calling memory_failure(), and as a result,
the capture kernel touches the error page again and panics.

Add the mce_set_page_hwpoison_now() function, which marks a page as
HWPoison before kernel panic() for MCE error, so that the dump
program can check and skip the error page and prevent the capture
kernel panic.

[ Tony: Changed TestSetPageHWPoison() to SetPageHWPoison() ]
[ mingo: Fixed the comments & changelog ]

Co-developed-by: Youquan Song <youquan.song@intel.com>
Signed-off-by: Youquan Song <youquan.song@intel.com>
Signed-off-by: Zhiquan Li <zhiquan1.li@intel.com>
Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
Cc: Borislav Petkov <bp@alien8.de>
Link: https://lore.kernel.org/all/20230719211625.298785-1-tony.luck@intel.com/#t
---
 arch/x86/kernel/cpu/mce/core.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 6f35f72..1a14e82 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -156,6 +156,22 @@ void mce_unregister_decode_chain(struct notifier_block *nb)
 }
 EXPORT_SYMBOL_GPL(mce_unregister_decode_chain);
 
+/*
+ * Kdump can exclude the HWPoison page to avoid touching the error page again,
+ * the prerequisite is that the PG_hwpoison page flag is set. However, for some
+ * MCE fatal error cases, there is no opportunity to queue a task
+ * for calling memory_failure(), and as a result, the capture kernel panics.
+ * This function marks the page as HWPoison before kernel panic() for MCE.
+ */
+static void mce_set_page_hwpoison_now(unsigned long pfn)
+{
+	struct page *p;
+
+	p = pfn_to_online_page(pfn);
+	if (p)
+		SetPageHWPoison(p);
+}
+
 static void __print_mce(struct mce *m)
 {
 	pr_emerg(HW_ERR "CPU %d: Machine Check%s: %Lx Bank %d: %016Lx\n",
@@ -286,6 +302,8 @@ static noinstr void mce_panic(const char *msg, struct mce *final, char *exp)
 	if (!fake_panic) {
 		if (panic_timeout == 0)
 			panic_timeout = mca_cfg.panic_timeout;
+		if (final && (final->status & MCI_STATUS_ADDRV))
+			mce_set_page_hwpoison_now(final->addr >> PAGE_SHIFT);
 		panic(msg);
 	} else
 		pr_emerg(HW_ERR "Fake kernel panic: %s\n", msg);
