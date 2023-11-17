Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 804DE7EF47B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 15:32:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231610AbjKQOcR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 09:32:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjKQOcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 09:32:15 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9892A5;
        Fri, 17 Nov 2023 06:32:11 -0800 (PST)
Date:   Fri, 17 Nov 2023 14:32:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1700231529;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=K4SlUOcraB1ZrRDjMaBiCvCaXWUmNRHo1TwtO7TWWZc=;
        b=UmCXfLKaklKoS7Rrd8EYBonPBLTo1lgCZBidGGyEKuYDdDxYh4y7OzDJJ+39xZon5CCjA3
        XYPU6hpwcC5B1PKm9bmKYicUZ9qy+tkkjCVfSg+YfJV7uU4RxUBpq4C7qVUz6Jo7k964yO
        032lZxKA5lhfYOuBoVMsDxjygRfAXVKM+HdeFi7qa64Vxx0SzhynRlg2nhm93TT2YcdxAp
        sEjE2O1B1q3ZGYkDAJ2w80XdzkK68gvtQp9JkeEcIVTQ8iOddo9syQEFJeRPvv4EfZSM6b
        fwkRhGMybZpF8priJ0YVToc1a5fgwWrlOG9S3WE5P5ganWZwxqSHz3FiSqRkkQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1700231529;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=K4SlUOcraB1ZrRDjMaBiCvCaXWUmNRHo1TwtO7TWWZc=;
        b=iYLnFa0UMk8ZEYGlaMfaVIfxrfFMpHvE3yKkVZS8XLZrJpJDvzDi5gHYGRrCpmFeEmsziB
        L7gbH+wsAlrb+wBQ==
From:   "tip-bot2 for Colin Ian King" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/misc] x86/lib: Fix overflow when counting digits
Cc:     Colin Ian King <colin.i.king@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <170023152812.391.4668620262387822327.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/misc branch of tip:

Commit-ID:     a24d61c609813963aacc9f6ec8343f4fcaac7243
Gitweb:        https://git.kernel.org/tip/a24d61c609813963aacc9f6ec8343f4fcaac7243
Author:        Colin Ian King <colin.i.king@gmail.com>
AuthorDate:    Thu, 02 Nov 2023 17:49:01 
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Fri, 17 Nov 2023 06:26:14 -08:00

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
