Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1535A7D3745
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 14:56:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbjJWM4F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 08:56:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230108AbjJWM4C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 08:56:02 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8BA4D7C;
        Mon, 23 Oct 2023 05:55:57 -0700 (PDT)
Date:   Mon, 23 Oct 2023 12:55:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1698065755;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YZEg4B8ZXuhFQLOdRKI34p1p/QHIZWG+7pUU2/5EiMU=;
        b=HEjVNzW1zV1rgMga3FSLpp2/ZGqS7LRTfJgrdmPLx5E7oddsN74CCITdiZeWH3DyR56/UN
        RMOusumsYXqMqUD3lDcbxLqRhfwmcpQIVurrXMuGuPVU5AmsjRlCU8czlSjmD1scncoVDw
        rrdV9z3xL1fnY3HOtISDf7rKG7Ylx6DEqf0L0jIYRDq7u1DLKy7VE9aaOu8TzoZWuG/n7V
        Kl6+8N3gK0Cbkn0JvVunA0WDVSI7Kq4bZ2paHN28Thubt9c1fzVRlmS/0u1DuC7rWuaoJ3
        ejYzqCbyNpXmmWmPDQB8z9/Bb16eJ86zN3muUvEjzOBips8Hlz98q0qe9ynEeA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1698065755;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YZEg4B8ZXuhFQLOdRKI34p1p/QHIZWG+7pUU2/5EiMU=;
        b=mSfJDKZKNoiuvWp2LvWNTUxV57wKGl9eFLT9W5nwzXsPYLqjxy/NJBU3wjWU/xWBVGtI/w
        1aExUxCUvVYclVCg==
From:   "tip-bot2 for Zhiquan Li" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: ras/core] x86/mce: Mark fatal MCE's page as poison to avoid
 panic in the kdump kernel
Cc:     Youquan Song <youquan.song@intel.com>,
        Zhiquan Li <zhiquan1.li@intel.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231014051754.3759099-1-zhiquan1.li@intel.com>
References: <20231014051754.3759099-1-zhiquan1.li@intel.com>
MIME-Version: 1.0
Message-ID: <169806575453.3135.14265994538914502918.tip-bot2@tip-bot2>
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

The following commit has been merged into the ras/core branch of tip:

Commit-ID:     1d11b153d23b5fd131d4ea125ff23c9e8ebc98ab
Gitweb:        https://git.kernel.org/tip/1d11b153d23b5fd131d4ea125ff23c9e8ebc98ab
Author:        Zhiquan Li <zhiquan1.li@intel.com>
AuthorDate:    Mon, 23 Oct 2023 12:22:37 +08:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 23 Oct 2023 14:53:13 +02:00

x86/mce: Mark fatal MCE's page as poison to avoid panic in the kdump kernel

Memory errors don't happen very often, especially fatal ones. However,
in large-scale scenarios such as data centers, that probability
increases with the amount of machines present.

When a fatal machine check happens, mce_panic() is called based on the
severity grading of that error. The page containing the error is not
marked as poison.

However, when kexec is enabled, tools like makedumpfile understand when
pages are marked as poison and do not touch them so as not to cause
a fatal machine check exception again while dumping the previous
kernel's memory.

Therefore, mark the page containing the error as poisoned so that the
kexec'ed kernel can avoid accessing the page.

  [ bp: Rewrite commit message and comment. ]

Co-developed-by: Youquan Song <youquan.song@intel.com>
Signed-off-by: Youquan Song <youquan.song@intel.com>
Signed-off-by: Zhiquan Li <zhiquan1.li@intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
Link: https://lore.kernel.org/r/20231014051754.3759099-1-zhiquan1.li@intel.com
---
 arch/x86/kernel/cpu/mce/core.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 0214d42..a25e692 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -44,6 +44,7 @@
 #include <linux/sync_core.h>
 #include <linux/task_work.h>
 #include <linux/hardirq.h>
+#include <linux/kexec.h>
 
 #include <asm/intel-family.h>
 #include <asm/processor.h>
@@ -233,6 +234,7 @@ static noinstr void mce_panic(const char *msg, struct mce *final, char *exp)
 	struct llist_node *pending;
 	struct mce_evt_llist *l;
 	int apei_err = 0;
+	struct page *p;
 
 	/*
 	 * Allow instrumentation around external facilities usage. Not that it
@@ -286,6 +288,18 @@ static noinstr void mce_panic(const char *msg, struct mce *final, char *exp)
 	if (!fake_panic) {
 		if (panic_timeout == 0)
 			panic_timeout = mca_cfg.panic_timeout;
+
+		/*
+		 * Kdump skips the poisoned page in order to avoid
+		 * touching the error bits again. Poison the page even
+		 * if the error is fatal and the machine is about to
+		 * panic.
+		 */
+		if (kexec_crash_loaded()) {
+			p = pfn_to_online_page(final->addr >> PAGE_SHIFT);
+			if (final && (final->status & MCI_STATUS_ADDRV) && p)
+				SetPageHWPoison(p);
+		}
 		panic(msg);
 	} else
 		pr_emerg(HW_ERR "Fake kernel panic: %s\n", msg);
