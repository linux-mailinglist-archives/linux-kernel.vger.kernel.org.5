Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBE4B7A71E5
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 07:22:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232731AbjITFWZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 01:22:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232520AbjITFVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 01:21:51 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86C56CE
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 22:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=u3Ft1l1JDv7ZC52Lq7+Ymsf40ejM5vNmM+ncxv9CXLE=; b=oUraPWiAz2WkKj3ieKbjfyRNMB
        ybzOBWZlLYsFk4UpVQw+IylNiJG6UcwMPV5L90XGa2hLnUv0jfPUFDG7esxrqFg11xqsp6K+vA57h
        iZySrxGh1VKm0Eg50/ud38QMQ+zcGUIX8cONeTVUNlOXJl3fS8tOXMD/gJfqo7rCKhsYgDlxtj2ZU
        VZBjA316DqchJJajOvPZfcDiCcU1G79WEEvMCEL/V/M61vcbEVIp1CWO4VH4/Slcs+/PJt/2HPhSB
        NjtYAfukYaPTn238BlKVZXYuOhDoZxMfq87qtNhX71ay2FX3VdQvUKyyDcaf2ljYKMc6YaSq3OYkR
        WHc49Gxg==;
Received: from [2601:1c2:980:9ec0::9fed] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qipej-001tym-11;
        Wed, 20 Sep 2023 05:21:45 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 11/16] xtensa: hw_breakpoint: include header for missing prototype
Date:   Tue, 19 Sep 2023 22:21:34 -0700
Message-ID: <20230920052139.10570-12-rdunlap@infradead.org>
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

Add the prototype for restore_dbreak() to <asm/hw_breakpoint.h> and use
that header in hw_breakpoint.c to prevent a build warning:

arch/xtensa/kernel/hw_breakpoint.c:263:6: warning: no previous prototype for 'restore_dbreak' [-Wmissing-prototypes]
  263 | void restore_dbreak(void)

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Chris Zankel <chris@zankel.net>
Cc: Max Filippov <jcmvbkbc@gmail.com>
---
 arch/xtensa/include/asm/hw_breakpoint.h |    1 +
 arch/xtensa/kernel/hw_breakpoint.c      |    1 +
 2 files changed, 2 insertions(+)

diff -- a/arch/xtensa/include/asm/hw_breakpoint.h b/arch/xtensa/include/asm/hw_breakpoint.h
--- a/arch/xtensa/include/asm/hw_breakpoint.h
+++ b/arch/xtensa/include/asm/hw_breakpoint.h
@@ -48,6 +48,7 @@ void arch_uninstall_hw_breakpoint(struct
 void hw_breakpoint_pmu_read(struct perf_event *bp);
 int check_hw_breakpoint(struct pt_regs *regs);
 void clear_ptrace_hw_breakpoint(struct task_struct *tsk);
+void restore_dbreak(void);
 
 #else
 
diff -- a/arch/xtensa/kernel/hw_breakpoint.c b/arch/xtensa/kernel/hw_breakpoint.c
--- a/arch/xtensa/kernel/hw_breakpoint.c
+++ b/arch/xtensa/kernel/hw_breakpoint.c
@@ -13,6 +13,7 @@
 #include <linux/percpu.h>
 #include <linux/perf_event.h>
 #include <asm/core.h>
+#include <asm/hw_breakpoint.h>
 
 /* Breakpoint currently in use for each IBREAKA. */
 static DEFINE_PER_CPU(struct perf_event *, bp_on_reg[XCHAL_NUM_IBREAK]);
