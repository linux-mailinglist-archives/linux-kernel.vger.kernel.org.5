Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8487C7C7BDB
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 05:02:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbjJMDCj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 23:02:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjJMDCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 23:02:37 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2B9BA9
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 20:02:31 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id 46e09a7af769-6bf106fb6a0so257593a34.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 20:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697166151; x=1697770951; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yn96BHMkhBAhs+vzga0XSrFRLZkctuRF634ZGrl6IPA=;
        b=Rf2NlvFosn8j/lNo2gdneaDMX6gj0cKj6aX7tQCfkmSPNcMaBGREpss6EqoGLYfC/X
         x+ia8tl99iFPbZp2La+LM0u+MQwgSm/QbDqr1BeaSiMw5ytVKiZBwliqN2qpNcbl73DJ
         MgKB5TNP0PHFB3TOTdMUECDzQ1ALSPEAdptHM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697166151; x=1697770951;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yn96BHMkhBAhs+vzga0XSrFRLZkctuRF634ZGrl6IPA=;
        b=FCnKNPxRO+Zv2mbR3KJHAoAYVhyWQfV86i49+t19OewM6s0h5wfNHrMbu/LT8r0pIp
         NkI9AiRn3/yfOzv6vDexd4IPsPkRqFNE5Nt1ps0wAa1QGlFvhn+lU4kHLgmdQc2xffzm
         61jWdqyn6mE/0Nbf54Ofi1kF5bH96lbuzxsJVWewBT2S6mN+lZ19M2dyV/I67tXIQ/3s
         gznTOp9GOlNQJvvjq5j9pOTHw3XDoTH9p0NFNCX3qd29RZ2BMXnVKmesnaKUiAkoSXxi
         RLn/rEE3UgAUGYzjlVf4S7X4LAD/oeQqeEpHr5njasZY428+qRQHK1t3tcPpfs+rMLs7
         yreA==
X-Gm-Message-State: AOJu0YxoWuka2nJJzfUR+zjkT+1C/L9sNKfvQxmIzolP8jdBt8j1GYHK
        nS9k2pRzFwqgWAsP3VHTknDNLONqDQ2+e+46czU=
X-Google-Smtp-Source: AGHT+IHCCHqpMs50mWOyijU+pYsv88b1NYW/Vmne9g+NANFL3Pm/oNXYjmCJBzgeLQsYGllwybZChw==
X-Received: by 2002:a4a:b588:0:b0:578:c2af:45b5 with SMTP id t8-20020a4ab588000000b00578c2af45b5mr24228879ooo.0.1697166150613;
        Thu, 12 Oct 2023 20:02:30 -0700 (PDT)
Received: from youssefesmat.aus.corp.google.com ([2620:15c:2a:20a:8225:2656:5ff1:7674])
        by smtp.gmail.com with ESMTPSA id q68-20020a4a3347000000b0057b722edbd5sm2956083ooq.1.2023.10.12.20.02.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 20:02:29 -0700 (PDT)
From:   Youssef Esmat <youssefesmat@chromium.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     peterz@infradead.org, bsegall@google.com, mingo@kernel.org,
        vincent.guittot@linaro.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, mgorman@suse.de,
        bristot@redhat.com, corbet@lwn.net, qyousef@layalina.io,
        chris.hyser@oracle.com, patrick.bellasi@matbug.net, pjt@google.com,
        pavel@ucw.cz, qperret@google.com, tim.c.chen@linux.intel.com,
        joshdon@google.com, timj@gnu.org, kprateek.nayak@amd.com,
        yu.c.chen@intel.com, joel@joelfernandes.org, efault@gmx.de,
        tglx@linutronix.de, wuyun.abel@bytedance.com,
        Youssef Esmat <youssefesmat@chromium.org>
Subject: [PATCH] sched/eevdf: Toggle eligibility through sched_feat
Date:   Thu, 12 Oct 2023 22:02:13 -0500
Message-ID: <20231013030213.2472697-1-youssefesmat@chromium.org>
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Interactive workloads see performance gains by disabling eligibility
checks (EEVDF->EVDF). Disabling the checks reduces the number of
context switches and delays less important work (higher deadlines/nice
values) in favor of more important work (lower deadlines/nice values).

That said, that can add large latencies for some work loads and as the
default is eligibility on, but allowing it to be turned off when
beneficial.

Signed-off-by: Youssef Esmat <youssefesmat@chromium.org>
Link: https://lore.kernel.org/lkml/CA+q576MS0-MV1Oy-eecvmYpvNT3tqxD8syzrpxQ-Zk310hvRbw@mail.gmail.com/
---
 kernel/sched/fair.c     | 3 +++
 kernel/sched/features.h | 1 +
 2 files changed, 4 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index a751e552f253..16106da5a354 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -728,6 +728,9 @@ int entity_eligible(struct cfs_rq *cfs_rq, struct sched_entity *se)
 	s64 avg = cfs_rq->avg_vruntime;
 	long load = cfs_rq->avg_load;
 
+	if (!sched_feat(ENFORCE_ELIGIBILITY))
+		return 1;
+
 	if (curr && curr->on_rq) {
 		unsigned long weight = scale_load_down(curr->load.weight);
 
diff --git a/kernel/sched/features.h b/kernel/sched/features.h
index f770168230ae..84e38a0045b7 100644
--- a/kernel/sched/features.h
+++ b/kernel/sched/features.h
@@ -7,6 +7,7 @@
 SCHED_FEAT(PLACE_LAG, true)
 SCHED_FEAT(PLACE_DEADLINE_INITIAL, true)
 SCHED_FEAT(RUN_TO_PARITY, true)
+SCHED_FEAT(ENFORCE_ELIGIBILITY, true)
 
 /*
  * Prefer to schedule the task we woke last (assuming it failed
-- 
2.42.0.655.g421f12c284-goog

