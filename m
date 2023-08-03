Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 349C576E33A
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 10:36:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234043AbjHCIf6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 04:35:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233889AbjHCIfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 04:35:39 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1202F3ABB
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 01:33:00 -0700 (PDT)
Date:   Thu, 3 Aug 2023 10:32:53 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691051577;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=Rt7SzZxNCz3Ob9bL0UZFPQ8dPBEEt0ivUNFN0hErH2U=;
        b=0Hof1zx5qRd+CcepuRrhbnfQPVWLdfWDm6Viy4K1w9ixH5mwC2763wkgKaMQq25QAnTBmo
        jCPXdiPNWnY9XIsGpZKtklz1EmkTVWzUdl9pH4MdtmehZeUs+/dlK6rWQD+OWtTUU4O0JD
        l3BITNrVi1CnM9gNTVqOobrHZv8k7I8jiMwN8a0SGJvNF8djJmv2JIR2eJLaUrSk7o+JZ+
        7ZVbv1nI41JNSwmXfiTooVt7cxRI2TAbSXrCqO7aI1lVH3UycitjuTwIy5RZnRJ3m2OfAH
        nl2kJCYBhDnvMVAuBb/Ubb5ahnddDi4LV5C4E9J9f+aqvanJS7m56tWJtg0zyw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691051577;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=Rt7SzZxNCz3Ob9bL0UZFPQ8dPBEEt0ivUNFN0hErH2U=;
        b=VGrGhDE0UAHthR77cd66fLdNo0FHfwVdLFinZv8cLZl0KQZY/gnoGKQvmWYEe6aP8fc+8h
        I4clV73bHTDp+dBg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH] x86/microcode: Remove microcode_mutex.
Message-ID: <20230803083253.VGMnC9Gd@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

microcode_mutex is only used by reload_store().  It has a comment saying
"to synchronize with each other". This probably means the sysfs
interface vs the legacy interface which was removed in commit
181b6f40e9ea8 ("x86/microcode: Rip out the OLD_INTERFACE").

The sysfs interface does not need additional synchronisation vs itself
because it is provided as kernfs_ops::mutex which is acquired in
kernfs_fop_write_iter().

Remove superfluous microcode_mutex.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
This poped up as "defined but not used" on RT builds without
CONFIG_MICROCODE_LATE_LOADING enabled.

 arch/x86/kernel/cpu/microcode/core.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/core.c b/arch/x86/kernel/cpu/microcode/core.c
index 3afcf3de0dd49..2f9d35744bc41 100644
--- a/arch/x86/kernel/cpu/microcode/core.c
+++ b/arch/x86/kernel/cpu/microcode/core.c
@@ -54,15 +54,12 @@ LIST_HEAD(microcode_cache);
  *
  * All non cpu-hotplug-callback call sites use:
  *
- * - microcode_mutex to synchronize with each other;
  * - cpus_read_lock/unlock() to synchronize with
  *   the cpu-hotplug-callback call sites.
  *
  * We guarantee that only a single cpu is being
  * updated at any particular moment of time.
  */
-static DEFINE_MUTEX(microcode_mutex);
-
 struct ucode_cpu_info		ucode_cpu_info[NR_CPUS];
 
 struct cpu_info_ctx {
@@ -488,10 +485,7 @@ static ssize_t reload_store(struct device *dev,
 	if (tmp_ret != UCODE_NEW)
 		goto put;
 
-	mutex_lock(&microcode_mutex);
 	ret = microcode_reload_late();
-	mutex_unlock(&microcode_mutex);
-
 put:
 	cpus_read_unlock();
 
-- 
2.40.1

