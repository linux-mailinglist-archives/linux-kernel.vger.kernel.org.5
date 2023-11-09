Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C61B7E6DE6
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 16:43:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344168AbjKIPns (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 10:43:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344220AbjKIPms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 10:42:48 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCA664487;
        Thu,  9 Nov 2023 07:41:40 -0800 (PST)
Date:   Thu, 09 Nov 2023 15:41:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1699544498;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=bv6Yj8YYO8U9m5DfpJG2dPx7BM1yh8k4cwSobi7Y5ws=;
        b=mr8uDf/hE/BVTLV0tY4Mq+692GnQrLEfziLsoU8D/L0jYBmejHAAfsVSl+YS7VVia8k17k
        7isCYrggzOC8jeNqKO0jsRiXfkvkv8fQVehyO+yA/sSTZxVKE9EfcTHfHyWZuWelyg25Ay
        fxcR3PLdwgk+89E8uSyaVDrZ7z8R2CM0RZvOdEAGiVJgFzge9ROL3IWVJsHF7/fZ+pBK5X
        NQ/rwV9ZFV0JLUgDzkEb9h00BRu2GYPGT7ERYTsM4sDCRWmzwoV4ws82SjyCmi2ieXz3X7
        Zl3F9b60lkVC7fa/4D8uVYm42ZHTBEpfZsPXx2WdJsdvA3WI+vfQ/eZ9mWp42g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1699544498;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=bv6Yj8YYO8U9m5DfpJG2dPx7BM1yh8k4cwSobi7Y5ws=;
        b=pK8HVc891GjTF6RzV7vk/AzoRlG3ZzqfXUm/QXTfjRqH2+QN0QHlNi0RCG0Sb/g+Oi309w
        elusyQQOnBF42qBg==
From:   "tip-bot2 for Colin Ian King" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/misc] x86/lib: Fix overflow when counting digits
Cc:     Colin Ian King <colin.i.king@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <169954449765.3135.6225096248572680656.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/misc branch of tip:

Commit-ID:     f9bb4627d3a4cfc2af77f4320da75a75be51ed07
Gitweb:        https://git.kernel.org/tip/f9bb4627d3a4cfc2af77f4320da75a75be51ed07
Author:        Colin Ian King <colin.i.king@gmail.com>
AuthorDate:    Thu, 02 Nov 2023 17:49:01 
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Thu, 09 Nov 2023 07:33:56 -08:00

x86/lib: Fix overflow when counting digits

tl;dr: The num_digits() function has a theoretical overflow issue.
But it doesn't affect any actual in-tree users.  Fix it by using
a larger type for one of the local variables.

Long version:

There is an overflow in variable m in function num_digits when val
is >= 1410065408 which leads to the digit calculation loop to
iterate more times than required. This results in either more
digits being counted or in some cases (for example where val is
1932683193) the value of m eventually overflows to zero and the
while loop spins forever).

Currently the function num_digits is currently only being used for
small values of val in the SMP boot stage for digit counting on the
number of cpus and NUMA nodes, so the overflow is never encountered.
However it is useful to fix the overflow issue in case the function
is used for other purposes in the future. (The issue was discovered
while investigating the digit counting performance in various
kernel helper functions rather than any real-world use-case).

The simplest fix is to make m a long long, the overhead in
multiplication speed for a long long is very minor for small values
of val less than 10000 on modern processors. The alternative
fix is to replace the multiplication with a constant division
by 10 loop (this compiles down to an multiplication and shift)
without needing to make m a long long, but this is slightly slower
than the fix in this commit when measured on a range of x86
processors).

[ dhansen: subject and changelog tweaks ]

Fixes: 646e29a1789a ("x86: Improve the printout of the SMP bootup CPU table")
Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lore.kernel.org/all/20231102174901.2590325-1-colin.i.king%40gmail.com
---
 arch/x86/lib/misc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/lib/misc.c b/arch/x86/lib/misc.c
index 92cd8ec..40b81c3 100644
--- a/arch/x86/lib/misc.c
+++ b/arch/x86/lib/misc.c
@@ -8,7 +8,7 @@
  */
 int num_digits(int val)
 {
-	int m = 10;
+	long long m = 10;
 	int d = 1;
 
 	if (val < 0) {
