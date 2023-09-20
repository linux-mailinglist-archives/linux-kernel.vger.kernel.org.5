Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88A4D7A71E2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 07:22:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232758AbjITFWR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 01:22:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232431AbjITFVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 01:21:50 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04ABD9F
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 22:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=s0y5UIjqoCpjnF4OBN5FWM7GDvbMo4ENMqy1dPJ0poI=; b=sQqu1AdlYjnuMiQvcqDvmHt5VE
        sdb/baXQUxEVZsWLXtqSeajq7O9yxvqpXOG4BgJhE2TUFqFiY2jMNCYDj1LYZJdkviYGJVNmetyPj
        ybFTPwhaatYrk7Mte4h//Zc+8I+QEKkKqmJ8llxJUNs//YyDiig5APahD5sWPTaDvLSvOH7HLXlvJ
        JJWj8vi+t/EMCheqqC2JnU2OMpcmklG5JhYuE5Gfw7PgW4i0RXcXKm9gWyoGos8SGglL9UBTAvdz5
        gbC325GIkyK0CRYnzE4hh2cjmIfD8xWDMQcOTc/k+dd0ZRM4olETPt+/9d4d593V8+4X/b7CIlRA+
        PA9uaQBA==;
Received: from [2601:1c2:980:9ec0::9fed] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qipeh-001tym-2Z;
        Wed, 20 Sep 2023 05:21:43 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 06/16] xtensa: signal: include headers for function prototypes
Date:   Tue, 19 Sep 2023 22:21:29 -0700
Message-ID: <20230920052139.10570-7-rdunlap@infradead.org>
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

Add <asm/syscall.h> to satisfy the xtensa_rt_sigreturn() prototype
warning.
Add <asm/processor.h> to satisfy the do_notify_resume() prototype
warning.

arch/xtensa/kernel/signal.c:246:17: warning: no previous prototype for 'xtensa_rt_sigreturn' [-Wmissing-prototypes]
arch/xtensa/kernel/signal.c:525:6: warning: no previous prototype for 'do_notify_resume' [-Wmissing-prototypes]
  525 | void do_notify_resume(struct pt_regs *regs)

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Chris Zankel <chris@zankel.net>
Cc: Max Filippov <jcmvbkbc@gmail.com>
---
 arch/xtensa/include/asm/processor.h |    1 +
 arch/xtensa/kernel/signal.c         |    2 ++
 2 files changed, 3 insertions(+)

diff -- a/arch/xtensa/kernel/signal.c b/arch/xtensa/kernel/signal.c
--- a/arch/xtensa/kernel/signal.c
+++ b/arch/xtensa/kernel/signal.c
@@ -26,6 +26,8 @@
 #include <linux/uaccess.h>
 #include <asm/cacheflush.h>
 #include <asm/coprocessor.h>
+#include <asm/processor.h>
+#include <asm/syscall.h>
 #include <asm/unistd.h>
 
 extern struct task_struct *coproc_owners[];
diff -- a/arch/xtensa/include/asm/processor.h b/arch/xtensa/include/asm/processor.h
--- a/arch/xtensa/include/asm/processor.h
+++ b/arch/xtensa/include/asm/processor.h
@@ -220,6 +220,7 @@ struct mm_struct;
 extern unsigned long __get_wchan(struct task_struct *p);
 
 void init_arch(bp_tag_t *bp_start);
+void do_notify_resume(struct pt_regs *regs);
 
 #define KSTK_EIP(tsk)		(task_pt_regs(tsk)->pc)
 #define KSTK_ESP(tsk)		(task_pt_regs(tsk)->areg[1])
