Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25B65807E2D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 03:05:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232540AbjLGCFS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 21:05:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjLGCFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 21:05:16 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27D8BC3;
        Wed,  6 Dec 2023 18:05:23 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-286f8ee27aeso465977a91.3;
        Wed, 06 Dec 2023 18:05:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701914722; x=1702519522; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qo8WdwTNE01KEbEBjzPvpUi0RD4zLVV6lNkHFrnKZ1g=;
        b=ZljeI4uYnVtEXHqiSv3/Exuoi+H8AEOOYQFeHqagHw8gJWMAgNixFhgNbQyyb61Gib
         yjyc+8uHFZNUl4JctNEJWWAEjASH0x8epGFro4Vyeyrg92OVl6zkMcQY4GDw2MBghktV
         S4Ghzqc7LKZNPHhBuCnTudm6qun43eilYyC+Etd6rxvFlwqRLxA4BQ5igydUGK5lCSTy
         3gd5inubmVmkzeUAXZG0tfSxCQQApfBsgx1hOq9lWSEQqKCTnGYQjYmcNOawvvo+PscB
         sQXTWZWZrUyDbawdee5ZEtYnjF0KtJFSL+R/1brPUJJB92kQPJqdMKDol1wooOGdBbPH
         NJdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701914722; x=1702519522;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qo8WdwTNE01KEbEBjzPvpUi0RD4zLVV6lNkHFrnKZ1g=;
        b=mnJwkQmFY2Q4ImbPJM7Gfw9s3j3AAmTvdGlW6uu3Td9vyo1kcO1ulWRtz/mkbgs62a
         EzCu66Ofzjl3S7nNWfmet4q+o5I5I6rRNd8qG/uzN2s0ldz+fdtP/ZCCl7uPg4cDntL1
         T4B3BM0TtSmR9MoOmWDF/vko5R8nwrnaaxwv+VDc2CWR6BJM46X8Zv+83/k+c/U17qDK
         nSmg/F9DoA2grMp/N4AHVV88ARbk7Yl9mgw0YwiBzpjA9Awj+Rl2dY06/Z4m7HpH0l+J
         SJoRwZEXVJjUYcZfnJoHD3I/ovQnbkLV/vjhmNk/sWcOAflN2OxsYn9xCHFc1Du/z84j
         grvw==
X-Gm-Message-State: AOJu0Yyjf0ZlNgNjL8qN+5LRyLB+LbM05+PcfQAd8pG8VzWjnCfJ+FHK
        3L99+RmoS5dJBbWtG5CkHyM=
X-Google-Smtp-Source: AGHT+IGYMVeRpcfNi8Y9ulOlJdsx/6z+qzU68LCGzzsOZ4/4C8xe5yon3k5U17LOU/GKs+aa3ZG2sQ==
X-Received: by 2002:a17:90b:4a4f:b0:285:ada5:956 with SMTP id lb15-20020a17090b4a4f00b00285ada50956mr1986916pjb.42.1701914722434;
        Wed, 06 Dec 2023 18:05:22 -0800 (PST)
Received: from localhost.localdomain ([61.253.179.202])
        by smtp.googlemail.com with ESMTPSA id u64-20020a17090a51c600b0028672a85808sm99011pjh.35.2023.12.06.18.05.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 18:05:22 -0800 (PST)
From:   Changwoo Min <multics69@gmail.com>
X-Google-Original-From: Changwoo Min <changwoo@igalia.com>
To:     tj@kernel.org
Cc:     kernel-dev@igalia.com, andrea.righi@canonical.com,
        andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
        brho@google.com, bristot@redhat.com, bsegall@google.com,
        changwoo@igalia.com, daniel@iogearbox.net, derkling@google.com,
        dietmar.eggemann@arm.com, dschatzberg@meta.com,
        dskarlat@cs.cmu.edu, dvernet@meta.com, haoluo@google.com,
        himadrics@inria.fr, joshdon@google.com, juri.lelli@redhat.com,
        kernel-team@meta.com, linux-kernel@vger.kernel.org,
        martin.lau@kernel.org, memxor@gmail.com, mgorman@suse.de,
        mingo@redhat.com, peterz@infradead.org, pjt@google.com,
        riel@surriel.com, rostedt@goodmis.org,
        torvalds@linux-foundation.org, vincent.guittot@linaro.org,
        vschneid@redhat.com
Subject: [PATCH] scx: set p->scx.ops_state using atomic_long_set_release
Date:   Thu,  7 Dec 2023 11:04:59 +0900
Message-ID: <20231207020459.117365-1-changwoo@igalia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231111024835.2164816-13-tj@kernel.org>
References: <20231111024835.2164816-13-tj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

p->scx.ops_state should be updated using the release semantics,
atomic_long_set_release(), because it is read using
atomic_long_read_acquire() at ops_dequeue() and wait_ops_state().
---
 kernel/sched/ext.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 53ee906aa2b6..3a40ca2007b6 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -881,7 +881,7 @@ static void do_enqueue_task(struct rq *rq, struct task_struct *p, u64 enq_flags,
 	qseq = rq->scx.ops_qseq++ << SCX_OPSS_QSEQ_SHIFT;
 
 	WARN_ON_ONCE(atomic_long_read(&p->scx.ops_state) != SCX_OPSS_NONE);
-	atomic_long_set(&p->scx.ops_state, SCX_OPSS_QUEUEING | qseq);
+	atomic_long_set_release(&p->scx.ops_state, SCX_OPSS_QUEUEING | qseq);
 
 	ddsp_taskp = this_cpu_ptr(&direct_dispatch_task);
 	WARN_ON_ONCE(*ddsp_taskp);
-- 
2.43.0

