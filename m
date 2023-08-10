Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3AB1777288
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 10:14:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234085AbjHJIOE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 04:14:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234079AbjHJIN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 04:13:58 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4B7A2127
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 01:13:32 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1bc83a96067so5015765ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 01:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1691655212; x=1692260012;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tl5oO1QRXOb7Xlr/P1TocHGd4tt8X+hUV0N7kEiSrUM=;
        b=aDltu1PKROoqGLCvRCHWF58dz9bbnpl3orhWXwYhHL4mOHV2ipbxiKpukTOenyL6CP
         qsNy+obeB+6hqeZA4OJZrBAEy5I5NGbHxgyWFUwujdVGnzUJPnTe5NggTksBrAirVvJP
         s1EYtHrvz6WbPAli7p8Q8y6ax6VSW2rlRMDKpBKnDWboQse/8rLDqIBFeQVxhHeZztwp
         hNgKt7V0jmP5xO5pheYLt3rgmcVCkGCETmfp0Yi1GP0kbth3HerEwWBLJr9aP63ixuse
         /4sAIb4CE6FcbBvaG+uCMzgW0hze7LEwB0OChYDzKAYsFMSSo2MoGv0b3ayXt0THKVke
         snpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691655212; x=1692260012;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tl5oO1QRXOb7Xlr/P1TocHGd4tt8X+hUV0N7kEiSrUM=;
        b=Cl/QLQXl88mw0UO5TvX8gyYtdwhtkqdyr/ts45f0qne8vaHs4Cmph/6ww/dSIQml5i
         EedU2viEUjvAJJI8bWDXFY11zZgwutfR7cTbGtjaUCwT/hm/j7mYd0Jx99gTyVdgXK4H
         Zq1dNteZpry0W7PFnnVJp4Tjs8yuqbA/qExZ2JNCARqLUPTjaULVOerAJUnVMsbZAz97
         ZjnhjFB3BV+4zXsiB7XNOoOCYwZt4kAki2Ceckw+5SkCj0d9IyE4g1BClWJfG+epRgKT
         hFCdUerSBBqSm0Z1cWymb82NUlSUtgqFRiV6DwnIBCn7pN0UXkj2jfSR8UkKRC+1g+Y/
         C4Mw==
X-Gm-Message-State: AOJu0YwN/0kw3vY8oOv2nBA437Psr6xxc3jkG72XKMbv340dLLrpJnjm
        C9tK1qvE5YhhXnwRZPMNosP1zQ==
X-Google-Smtp-Source: AGHT+IFFybK5XwmJPTjMNNThFKg57uX9Mgd++y0VnkKYwGUQcpL7/Y8InoUpFsJs/oQykpOry4nY0Q==
X-Received: by 2002:a17:903:41cf:b0:1bc:9794:22ef with SMTP id u15-20020a17090341cf00b001bc979422efmr1545395ple.1.1691655212147;
        Thu, 10 Aug 2023 01:13:32 -0700 (PDT)
Received: from n37-019-243.byted.org ([180.184.51.40])
        by smtp.gmail.com with ESMTPSA id x12-20020a170902ec8c00b001b1a2c14a4asm1019036plg.38.2023.08.10.01.13.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 01:13:31 -0700 (PDT)
From:   Chuyi Zhou <zhouchuyi@bytedance.com>
To:     hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        muchun.song@linux.dev
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        wuyun.abel@bytedance.com, robin.lu@bytedance.com,
        Chuyi Zhou <zhouchuyi@bytedance.com>,
        Michal Hocko <mhocko@suse.com>
Subject: [RFC PATCH v2 1/5] mm, oom: Introduce bpf_oom_evaluate_task
Date:   Thu, 10 Aug 2023 16:13:15 +0800
Message-Id: <20230810081319.65668-2-zhouchuyi@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230810081319.65668-1-zhouchuyi@bytedance.com>
References: <20230810081319.65668-1-zhouchuyi@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a new hook bpf_oom_evaluate_task in oom_evaluate_task. It
takes oc and current iterating task as parameters and returns a result
indicating which one should be selected. We can use it to bypass the
current logic of oom_evaluate_task and implement customized OOM policies
in the attached BPF progams.

Suggested-by: Michal Hocko <mhocko@suse.com>
Signed-off-by: Chuyi Zhou <zhouchuyi@bytedance.com>
---
 mm/oom_kill.c | 59 +++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 50 insertions(+), 9 deletions(-)

diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 612b5597d3af..255c9ef1d808 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -18,6 +18,7 @@
  *  kernel subsystems and hints as to where to find out what things do.
  */
 
+#include <linux/bpf.h>
 #include <linux/oom.h>
 #include <linux/mm.h>
 #include <linux/err.h>
@@ -305,6 +306,27 @@ static enum oom_constraint constrained_alloc(struct oom_control *oc)
 	return CONSTRAINT_NONE;
 }
 
+enum {
+	NO_BPF_POLICY,
+	BPF_EVAL_ABORT,
+	BPF_EVAL_NEXT,
+	BPF_EVAL_SELECT,
+};
+
+__weak noinline int bpf_oom_evaluate_task(struct task_struct *task, struct oom_control *oc)
+{
+	return NO_BPF_POLICY;
+}
+
+BTF_SET8_START(oom_bpf_fmodret_ids)
+BTF_ID_FLAGS(func, bpf_oom_evaluate_task)
+BTF_SET8_END(oom_bpf_fmodret_ids)
+
+static const struct btf_kfunc_id_set oom_bpf_fmodret_set = {
+	.owner = THIS_MODULE,
+	.set   = &oom_bpf_fmodret_ids,
+};
+
 static int oom_evaluate_task(struct task_struct *task, void *arg)
 {
 	struct oom_control *oc = arg;
@@ -317,6 +339,26 @@ static int oom_evaluate_task(struct task_struct *task, void *arg)
 	if (!is_memcg_oom(oc) && !oom_cpuset_eligible(task, oc))
 		goto next;
 
+	/*
+	 * If task is allocating a lot of memory and has been marked to be
+	 * killed first if it triggers an oom, then select it.
+	 */
+	if (oom_task_origin(task)) {
+		points = LONG_MAX;
+		goto select;
+	}
+
+	switch (bpf_oom_evaluate_task(task, oc)) {
+	case BPF_EVAL_ABORT:
+		goto abort; /* abort search process */
+	case BPF_EVAL_NEXT:
+		goto next; /* ignore the task */
+	case BPF_EVAL_SELECT:
+		goto select; /* select the task */
+	default:
+		break; /* No BPF policy */
+	}
+
 	/*
 	 * This task already has access to memory reserves and is being killed.
 	 * Don't allow any other task to have access to the reserves unless
@@ -329,15 +371,6 @@ static int oom_evaluate_task(struct task_struct *task, void *arg)
 		goto abort;
 	}
 
-	/*
-	 * If task is allocating a lot of memory and has been marked to be
-	 * killed first if it triggers an oom, then select it.
-	 */
-	if (oom_task_origin(task)) {
-		points = LONG_MAX;
-		goto select;
-	}
-
 	points = oom_badness(task, oc->totalpages);
 	if (points == LONG_MIN || points < oc->chosen_points)
 		goto next;
@@ -732,10 +765,18 @@ static struct ctl_table vm_oom_kill_table[] = {
 
 static int __init oom_init(void)
 {
+	int err;
 	oom_reaper_th = kthread_run(oom_reaper, NULL, "oom_reaper");
 #ifdef CONFIG_SYSCTL
 	register_sysctl_init("vm", vm_oom_kill_table);
 #endif
+
+#ifdef CONFIG_BPF_SYSCALL
+	err = register_btf_fmodret_id_set(&oom_bpf_fmodret_set);
+	if (err)
+		pr_warn("error while registering oom fmodret entrypoints: %d", err);
+#endif
+
 	return 0;
 }
 subsys_initcall(oom_init)
-- 
2.20.1

