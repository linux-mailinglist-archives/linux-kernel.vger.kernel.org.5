Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC63C7ABC26
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 01:06:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbjIVXGM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 19:06:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjIVXGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 19:06:11 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B942198
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 16:06:05 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d81503de9c9so3795372276.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 16:06:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695423964; x=1696028764; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NHVBmOhheiImvCV9GEh5Xy8qOuiiZvjK42ap36JRWZs=;
        b=hbGZj91tIiL3NZZRYvNp+umzqtIq1gebYrGd624HbNknr9x7AGYp/eXTzbwoHYDkxL
         O7RKLsa/+BWlVatFm300tpmg0s8qo6q88vWDi/zNRHgzYkiF3Kk5amOTUpzvFdFXU0ar
         O2lwhyjJ1Wxj+dOSYTKPnQc+S/7aLmhwW4lbuwMR6dTasnjwCpq1G18UFMPwLO2c9g3k
         cakKgXuLngNcGseirMtS+d/ihZnbdJEdlb2L8rf9OT56QGLy1Z79xvC9S2CCAy3uBr3H
         xtYTtaEJ3lANOmO5VACGHOLX5PPqeXg18u1Mv12L0rRaWwGDZBHWXkEYlvuyq1FVPfkL
         vIYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695423964; x=1696028764;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NHVBmOhheiImvCV9GEh5Xy8qOuiiZvjK42ap36JRWZs=;
        b=ciFHTuTZuejJqiEnDfok8xKcppiLSaguMvrqS/2kQDg6mE9wk5NYKCvPqB24YEBxZK
         79UYIDf1FVbK9D7CjgRfYU18aA9ku4PFC0mUCbZiezrhoAQ8oAWSwksZCNAbYl/oAubX
         ZtvTvk5np09C9rcOQn/1QwNREki8n6Gkp0g+MuqwPpE5U02ZPgdjPx4UILu377P6Mge+
         996jPoPn1URhoEpeGS1YmgbXDhmkqj1YDhQqgof4vIFs6OE2diCuGQesh+u+HN3bHOXn
         Yf30kz4E7+7EkgMzZAc66qwiJfdktrfGeybXapFpFWGgSWywrCA6ru11qmCo7OaViDCQ
         V5LA==
X-Gm-Message-State: AOJu0YxGdo2iB7HKJpJbQFL28vEEo0HxJ3ebaKwBrLj/3xuGTFlFUBkp
        DDM0DLtZCy5ot2sq3bsbc+fIuXnzP+Rn
X-Google-Smtp-Source: AGHT+IHcEOUTZMrMFXz1WkiszefUBqI8/NRduNAV0Yjuii+krJVE1p0B41FYlhVV1jNl6VJMMk3dtVXNMRx5
X-Received: from joshdon-desktop.svl.corp.google.com ([2620:15c:2a3:200:7ebc:6ddc:e08c:7b19])
 (user=joshdon job=sendgmr) by 2002:a05:6902:161c:b0:d0e:e780:81b3 with SMTP
 id bw28-20020a056902161c00b00d0ee78081b3mr7454ybb.2.1695423964289; Fri, 22
 Sep 2023 16:06:04 -0700 (PDT)
Date:   Fri, 22 Sep 2023 16:05:34 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
Message-ID: <20230922230535.296350-1-joshdon@google.com>
Subject: [PATCH 1/2] sched: make cfs_rq->throttled_csd_list available on !SMP
From:   Josh Don <joshdon@google.com>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org, Josh Don <joshdon@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This makes the following patch cleaner by avoiding extra CONFIG_SMP
conditionals on the availability of throttled_csd_list.

Signed-off-by: Josh Don <joshdon@google.com>
---
 kernel/sched/fair.c  | 4 ----
 kernel/sched/sched.h | 2 --
 2 files changed, 6 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 384900bf87eb..8f4e63fc8900 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5765,11 +5765,9 @@ static bool distribute_cfs_runtime(struct cfs_bandwidth *cfs_b)
 		if (!cfs_rq_throttled(cfs_rq))
 			goto next;
 
-#ifdef CONFIG_SMP
 		/* Already queued for async unthrottle */
 		if (!list_empty(&cfs_rq->throttled_csd_list))
 			goto next;
-#endif
 
 		/* By the above checks, this should never be true */
 		SCHED_WARN_ON(cfs_rq->runtime_remaining > 0);
@@ -6136,9 +6134,7 @@ static void init_cfs_rq_runtime(struct cfs_rq *cfs_rq)
 {
 	cfs_rq->runtime_enabled = 0;
 	INIT_LIST_HEAD(&cfs_rq->throttled_list);
-#ifdef CONFIG_SMP
 	INIT_LIST_HEAD(&cfs_rq->throttled_csd_list);
-#endif
 }
 
 void start_cfs_bandwidth(struct cfs_bandwidth *cfs_b)
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 68768f47ccb7..8f6a6b693d10 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -644,9 +644,7 @@ struct cfs_rq {
 	int			throttled;
 	int			throttle_count;
 	struct list_head	throttled_list;
-#ifdef CONFIG_SMP
 	struct list_head	throttled_csd_list;
-#endif
 #endif /* CONFIG_CFS_BANDWIDTH */
 #endif /* CONFIG_FAIR_GROUP_SCHED */
 };
-- 
2.42.0.515.g380fc7ccd1-goog

