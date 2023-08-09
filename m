Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A045776C03
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 00:13:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232416AbjHIWM7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 18:12:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231703AbjHIWMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 18:12:53 -0400
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C97EEB9
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 15:12:52 -0700 (PDT)
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7658752ce2fso24202985a.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Aug 2023 15:12:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691619171; x=1692223971;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NCs/KK1OPApuPq1wtS/IBD+prxoRkH0tsLIOpWbu+9s=;
        b=WcbPqdOLJiZ38sbu3c/K7zpXLMjMYiwAbdzXRo5A40rCdOA1KKpma0zsYT5dmK/+WJ
         CYfyxzXU1DbUAAhUa46BB3ScOs4r8lFI8aOQrA9dKt+GG3J7IQb4i1AEjsJpOTX4enOd
         9JI8VDqFGkIim56Y219HPSm43W8scNqD67gybuAnb8S1pZlQ9UPt4xnGviO/GDnERUfj
         /Z7d5yEMjp9gYSoUgXWu1+7ZmUXEB9wKUqTF3Xws4WF39tR+/iuhweo7SlqhUPEloGBN
         tqdAuKLVhSlIncbjTYMOiDQb9uV7u4y7z9gf5YkIE7SWAIlnlljzkh0vCh5k6arP60IA
         4XHA==
X-Gm-Message-State: AOJu0YxfmnUv18IYAVK7VOuTmTbmVe6cPg87pDqfc0J/XyxoXFmoZWcO
        INfd7aXdWFYelpdEej0Cr8sbSy0ah4MZGFP7
X-Google-Smtp-Source: AGHT+IF8ijknA8gAofAvZ7a0l3MyWFw4fpQ3p/a7jd5Znwoy7kGyMUGOe5DFAomxvQiAZK3DaIn3Vw==
X-Received: by 2002:a05:620a:29d2:b0:765:7d7b:7197 with SMTP id s18-20020a05620a29d200b007657d7b7197mr386020qkp.31.1691619171616;
        Wed, 09 Aug 2023 15:12:51 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:ed08])
        by smtp.gmail.com with ESMTPSA id g20-20020a05620a13d400b00767d6ec578csm23080qkl.20.2023.08.09.15.12.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 15:12:51 -0700 (PDT)
From:   David Vernet <void@manifault.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, tj@kernel.org,
        roman.gushchin@linux.dev, gautham.shenoy@amd.com,
        kprateek.nayak@amd.com, aaron.lu@intel.com,
        wuyun.abel@bytedance.com, kernel-team@meta.com
Subject: [PATCH v3 3/7] sched: Check cpu_active() earlier in newidle_balance()
Date:   Wed,  9 Aug 2023 17:12:14 -0500
Message-ID: <20230809221218.163894-4-void@manifault.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809221218.163894-1-void@manifault.com>
References: <20230809221218.163894-1-void@manifault.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In newidle_balance(), we check if the current CPU is inactive, and then
decline to pull any remote tasks to the core if so. Before this check,
however, we're currently updating rq->idle_stamp. If a core is offline,
setting its idle stamp is not useful. The core won't be chosen by any
task in select_task_rq_fair(), and setting the rq->idle_stamp is
misleading anyways given that the core being inactive should imply that
it should have a very cold cache.

Let's set rq->idle_stamp in newidle_balance() only if the cpu is active.

Signed-off-by: David Vernet <void@manifault.com>
---
 kernel/sched/fair.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index c28206499a3d..eb15d6f46479 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -12037,18 +12037,18 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
 	if (this_rq->ttwu_pending)
 		return 0;
 
-	/*
-	 * We must set idle_stamp _before_ calling idle_balance(), such that we
-	 * measure the duration of idle_balance() as idle time.
-	 */
-	this_rq->idle_stamp = rq_clock(this_rq);
-
 	/*
 	 * Do not pull tasks towards !active CPUs...
 	 */
 	if (!cpu_active(this_cpu))
 		return 0;
 
+	/*
+	 * We must set idle_stamp _before_ calling idle_balance(), such that we
+	 * measure the duration of idle_balance() as idle time.
+	 */
+	this_rq->idle_stamp = rq_clock(this_rq);
+
 	/*
 	 * This is OK, because current is on_cpu, which avoids it being picked
 	 * for load-balance and preemption/IRQs are still disabled avoiding
-- 
2.41.0

