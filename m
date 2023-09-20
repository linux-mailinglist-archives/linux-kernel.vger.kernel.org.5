Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2F277A71ED
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 07:22:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232806AbjITFW6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 01:22:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232529AbjITFVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 01:21:51 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40BBBC2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 22:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=4HIhMY7GzHluaw6zpJ+7jZBwZYJkux/Wi2WftldLB38=; b=RcDjiSTfO6D/u/E2n07xRc/WUb
        LFK30atEO3ctcQ7/z/XmRxrOxrAtmNGu5Hp7p2paAmXIBbEB4Dj1307NCfwmv1ySxzF0zXxk8OUY8
        3lt6Hj+z1Lfw1cLfUpco219XLo47Hq1DeDTsqHYoIFVLtQXHwK4HyIUpyUV1TP2bmYNqaPRHzeYjz
        nZMFtD4sl4EuX57ABKcT1kj3/YG4QoH9q4w0etVI0VM4Vz51hGzvR13ju73m9zE68BK5XiVPmBY2Q
        ZR3G4DLF9vI4I65LT1xeWfJP/RH/shRHbQrHZIohJ/4dD8MN8fFWHDOphLVEKEo6KrzmgnnlQLOJe
        5BjTi6LQ==;
Received: from [2601:1c2:980:9ec0::9fed] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qipej-001tym-04;
        Wed, 20 Sep 2023 05:21:45 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 10/16] xtensa: smp: add headers for missing function prototypes
Date:   Tue, 19 Sep 2023 22:21:33 -0700
Message-ID: <20230920052139.10570-11-rdunlap@infradead.org>
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

Use <asm/smp.h> to provide the prototype for secondary_start_kernel().
Use <linux/profile.h> to provide the prototype for
setup_profiling_timer().

arch/xtensa/kernel/smp.c:119:6: warning: no previous prototype for 'secondary_start_kernel' [-Wmissing-prototypes]
  119 | void secondary_start_kernel(void)
arch/xtensa/kernel/smp.c:461:5: warning: no previous prototype for 'setup_profiling_timer' [-Wmissing-prototypes]
  461 | int setup_profiling_timer(unsigned int multiplier)

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Chris Zankel <chris@zankel.net>
Cc: Max Filippov <jcmvbkbc@gmail.com>
---
 arch/xtensa/include/asm/smp.h |    1 +
 arch/xtensa/kernel/smp.c      |    1 +
 2 files changed, 2 insertions(+)

diff -- a/arch/xtensa/include/asm/smp.h b/arch/xtensa/include/asm/smp.h
--- a/arch/xtensa/include/asm/smp.h
+++ b/arch/xtensa/include/asm/smp.h
@@ -23,6 +23,7 @@ struct cpumask;
 void arch_send_call_function_ipi_mask(const struct cpumask *mask);
 void arch_send_call_function_single_ipi(int cpu);
 
+void secondary_start_kernel(void);
 void smp_init_cpus(void);
 void secondary_init_irq(void);
 void ipi_init(void);
diff -- a/arch/xtensa/kernel/smp.c b/arch/xtensa/kernel/smp.c
--- a/arch/xtensa/kernel/smp.c
+++ b/arch/xtensa/kernel/smp.c
@@ -21,6 +21,7 @@
 #include <linux/irq.h>
 #include <linux/kdebug.h>
 #include <linux/module.h>
+#include <linux/profile.h>
 #include <linux/sched/mm.h>
 #include <linux/sched/hotplug.h>
 #include <linux/sched/task_stack.h>
