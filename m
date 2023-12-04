Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE656803211
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 13:04:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232492AbjLDL7g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 06:59:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235417AbjLDL6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 06:58:49 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B9031FE0
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 03:57:57 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31B25C43397;
        Mon,  4 Dec 2023 11:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701691076;
        bh=2ybd8Cw7YtU9u9EHHq/wEoKMfFc0foeXptI4v618YLo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kwK3J2nyRuMO7cc5FBlkOyQQSG16HXJjEpaaGw+7p6jnWH8JfDJgQ3aRzupuj+HKJ
         I+Q8200Ouq+z26Ued3VzF7lulESo3RTxh/uBSoAXt01m8og1VH+yUqaXsK2186cN8P
         H4LJD0/LOAXq+HryzMRBKBn4i6B8pThCUKG31eo0TspSza2nH3GMr8zKzFUWe/B/dP
         D+pMcvarz9XNE5Eb2uDlXFlC+BV+C8HBlqr2gjbjKe06AcxFT/wqBX6UjZxsEzfEA4
         1A1XeFtr+uHK8eNDjH6u4FmaZF/j66FI2sEgKFmXPZ5n93470IsO76PWFqSNOJEOak
         r1N4zlmIlKQSQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     linux-mips@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Stephen Rothwell" <sfr@rothwell.id.au>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>
Subject: [PATCH 19/20] mips: smp: fix setup_profiling_timer() prototype
Date:   Mon,  4 Dec 2023 12:57:09 +0100
Message-Id: <20231204115710.2247097-20-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231204115710.2247097-1-arnd@kernel.org>
References: <20231204115710.2247097-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The function is unconditionally defined in smp.c but is conditionally
declared in a header that is not included here.

arch/mips/kernel/smp.c:473:5: error: no previous prototype for 'setup_profiling_timer' [-Werror=missing-prototypes]

Add the missing #include and #ifdef to match the declaration.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/mips/kernel/smp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/mips/kernel/smp.c b/arch/mips/kernel/smp.c
index 8fbef537fb88..774e4dcd86d2 100644
--- a/arch/mips/kernel/smp.c
+++ b/arch/mips/kernel/smp.c
@@ -10,6 +10,7 @@
 #include <linux/delay.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
+#include <linux/profile.h>
 #include <linux/smp.h>
 #include <linux/spinlock.h>
 #include <linux/threads.h>
@@ -468,11 +469,13 @@ int __cpu_up(unsigned int cpu, struct task_struct *tidle)
 	return 0;
 }
 
+#ifdef CONFIG_PROFILING
 /* Not really SMP stuff ... */
 int setup_profiling_timer(unsigned int multiplier)
 {
 	return 0;
 }
+#endif
 
 static void flush_tlb_all_ipi(void *info)
 {
-- 
2.39.2

