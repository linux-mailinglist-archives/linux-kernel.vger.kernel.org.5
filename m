Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED4478031F0
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 12:59:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343741AbjLDL6O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 06:58:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233068AbjLDL5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 06:57:37 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01BA2184
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 03:57:30 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAAE4C433C7;
        Mon,  4 Dec 2023 11:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701691049;
        bh=63/jrMa/1loCjLp+mnSNzgGTPIfRhB1ZC/FTGaLdVmE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oWgMPbijBeVLdjCj9onCM1zc45ZCBY4f4h2YP/vOZexqp1X6OiLPGG3ETE6EpP+QA
         0F3D3D0mts/0ZBtUr70kNlb/ZWFberEuPga79PQeYG/62NYiI/QFd3zJI7NVn63LMx
         PzYoL+gDiYRoqPuJ/HcsBQuP9ZP9JDQHEnopS7pdplT0HaQ74AySyWYQWdMbHssSvM
         hA8FLtKQnnqSEQCJ1s3LXBxFfjWMd1arydqFl2ssZssN9V/Fv7GCqIAxHzpuR7JF8K
         /SxY9PHmaWJ3djBpl6ncH+JvrfRCSHNcfNDsnuKprN2N6wg4zUg98kVJTKZuF3gPMC
         Mafzor6S8T7Iw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     linux-mips@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Stephen Rothwell" <sfr@rothwell.id.au>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>
Subject: [PATCH 05/20] mips: signal: move sigcontext declarations to header
Date:   Mon,  4 Dec 2023 12:56:55 +0100
Message-Id: <20231204115710.2247097-6-arnd@kernel.org>
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

Function declarations should be in a shared header to ensure the prototypes
match the definition:

arch/mips/kernel/signal.c:439:5: error: no previous prototype for 'setup_sigcontext' [-Werror=missing-prototypes]
arch/mips/kernel/signal.c:516:5: error: no previous prototype for 'restore_sigcontext' [-Werror=missing-prototypes]

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/mips/kernel/signal-common.h | 3 +++
 arch/mips/kernel/signal_n32.c    | 3 ---
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/mips/kernel/signal-common.h b/arch/mips/kernel/signal-common.h
index f50d48435c68..136eb20ac024 100644
--- a/arch/mips/kernel/signal-common.h
+++ b/arch/mips/kernel/signal-common.h
@@ -40,4 +40,7 @@ _restore_fp_context(void __user *fpregs, void __user *csr);
 extern asmlinkage int _save_msa_all_upper(void __user *buf);
 extern asmlinkage int _restore_msa_all_upper(void __user *buf);
 
+extern int setup_sigcontext(struct pt_regs *, struct sigcontext __user *);
+extern int restore_sigcontext(struct pt_regs *, struct sigcontext __user *);
+
 #endif	/* __SIGNAL_COMMON_H */
diff --git a/arch/mips/kernel/signal_n32.c b/arch/mips/kernel/signal_n32.c
index ff2043d620ba..139d2596b0d4 100644
--- a/arch/mips/kernel/signal_n32.c
+++ b/arch/mips/kernel/signal_n32.c
@@ -33,9 +33,6 @@
  */
 #define __NR_N32_restart_syscall	6214
 
-extern int setup_sigcontext(struct pt_regs *, struct sigcontext __user *);
-extern int restore_sigcontext(struct pt_regs *, struct sigcontext __user *);
-
 struct ucontextn32 {
 	u32		    uc_flags;
 	s32		    uc_link;
-- 
2.39.2

