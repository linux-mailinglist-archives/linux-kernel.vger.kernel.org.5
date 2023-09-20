Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6BE37A71DC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 07:21:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232671AbjITFVz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 01:21:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230447AbjITFVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 01:21:49 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CA3EF3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 22:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=bdGMMInrswQ95Tb8dukbNjhTN3UO5dqRY0oC6nmLpw4=; b=VYVOF3t5sAVT6/NToDEzNwDCSt
        0ujQ0Zga1aIka7ubet3P4Ysl6F+ASh073v7Vd1PtZoonyQqNRTQViZYQ5YrPb3D8YX7XM7XqFlWAr
        zCwFJs0wOXORgzPrNXZcs8yXMRYESCR4z2rQaD7XBxuYUDj6DPcNrK8mmyJP0kYXGHEDGkgMCXK7G
        Ly8BtxHe3hBRyqLTSef+GRa5n9McrxPjteeg+YssXEuVypNoFsCXPHsI4/fMDJpVgIoHE0ohDyY/v
        VWAWkyRYIcc4A+3GJzKSxCTEmWC5Zt3vXl5eRMc3AbMMLTqiWWZwmCFaEN5iac2raPJf74xJpazGw
        DG4R+yWA==;
Received: from [2601:1c2:980:9ec0::9fed] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qipeh-001tym-0l;
        Wed, 20 Sep 2023 05:21:43 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 04/16] xtensa: ptrace: add prototypes to <asm/ptrace.h>
Date:   Tue, 19 Sep 2023 22:21:27 -0700
Message-ID: <20230920052139.10570-5-rdunlap@infradead.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920052139.10570-1-rdunlap@infradead.org>
References: <20230920052139.10570-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add prototype for do_syscall_trace_enter() to asm/ptrace.h.
Move prototype for do_syscall_trace_leave() there to be consistent.

Fixes a build warning:

arch/xtensa/kernel/ptrace.c:545:5: warning: no previous prototype for 'do_syscall_trace_enter' [-Wmissing-prototypes]
  545 | int do_syscall_trace_enter(struct pt_regs *regs)

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Chris Zankel <chris@zankel.net>
Cc: Max Filippov <jcmvbkbc@gmail.com>
---
 arch/xtensa/include/asm/ptrace.h |    3 +++
 arch/xtensa/kernel/ptrace.c      |    1 -
 2 files changed, 3 insertions(+), 1 deletion(-)

diff -- a/arch/xtensa/include/asm/ptrace.h b/arch/xtensa/include/asm/ptrace.h
--- a/arch/xtensa/include/asm/ptrace.h
+++ b/arch/xtensa/include/asm/ptrace.h
@@ -106,6 +106,9 @@ static inline unsigned long regs_return_
 	return regs->areg[2];
 }
 
+int do_syscall_trace_enter(struct pt_regs *regs);
+void do_syscall_trace_leave(struct pt_regs *regs);
+
 #else	/* __ASSEMBLY__ */
 
 # include <asm/asm-offsets.h>
diff -- a/arch/xtensa/kernel/ptrace.c b/arch/xtensa/kernel/ptrace.c
--- a/arch/xtensa/kernel/ptrace.c
+++ b/arch/xtensa/kernel/ptrace.c
@@ -541,7 +541,6 @@ long arch_ptrace(struct task_struct *chi
 	return ret;
 }
 
-void do_syscall_trace_leave(struct pt_regs *regs);
 int do_syscall_trace_enter(struct pt_regs *regs)
 {
 	if (regs->syscall == NO_SYSCALL)
