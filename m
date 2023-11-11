Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 755917E889E
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 03:51:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346125AbjKKCvR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 21:51:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235343AbjKKCub (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 21:50:31 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F370549F3;
        Fri, 10 Nov 2023 18:49:53 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1cc3bb32b5dso23379875ad.3;
        Fri, 10 Nov 2023 18:49:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699670993; x=1700275793; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aywI18AL9/yTpfLmgU/8YHajN6V0oOz7C0bBhae84qs=;
        b=gistYSKkh9rIKSKSHU53HWqLs/Hnii+QVmVqOSu4634rHQP93hgBlcp0o1PRx0W6/1
         s9VF5GKJgw+RHi3aBf9chlOXqBTytmR9aijYqrl4OIi6LZddcnYd24WImolw+5ji6nTq
         7XDe9mfDO64eLEbQq3U4qNqcyz7DVRYCEEqeQZ+RIf/8MlIu464CIEOeEsruTpP0EDyO
         Y/Uo83v56x1/I3UUROlzNBsj3Fp0tijackccgxEiM90RHGJmMYUweZXYtMNOaHI+vi+E
         ibnA3WnVeNs4vvMlHkt63gxZi4yySSTgp4tPlZTxe/dRztF5SzGGaa1DLb5XMZssAnQT
         aR+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699670993; x=1700275793;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aywI18AL9/yTpfLmgU/8YHajN6V0oOz7C0bBhae84qs=;
        b=RyMRbiuAW9g46xDe23PA++VS+FVXD4qtnkwyG0Say79QJhiqOXhwjzUpnbrc+eVvHl
         rC6hPdu3CPwwPks8UoRbjCH5We5On48UJBd2vjrCiAVk+W+VFwKPZitb8diR+Mb97vFf
         I3kZI8iI4+yEcSh88JitFrIIL/UunORq7/o7SgQGwt9q7LeD/rYNlA5Z44dZBxiTCu1u
         zFvRHM56S/v2o6rKS4oNP5LbdoOHkAebFb6qPDSPuIOLhUFN8RCX6gsYXancuqKDj2dz
         Og6qnHqQhVkiRSCICX4D4BPCd/FdX5fX6tJNAujk+o7DfpLEs8Q2NXbV5TeoJiiHRTaW
         /icQ==
X-Gm-Message-State: AOJu0Yxt9mD2gXOjW3pDtADmmVuuLfhSqIhn6C3lWK+9o35QA1jknLMu
        Fjm7oEPxvpiDf0m1vHcoofo=
X-Google-Smtp-Source: AGHT+IHtjS7yLbQvCr58pX9BKUWMoh6OXZBxXztSlcDHkhJIVXO66cO6Iyq6EXc62lWyzEo6r5G6qw==
X-Received: by 2002:a17:902:d68b:b0:1bb:598a:14e5 with SMTP id v11-20020a170902d68b00b001bb598a14e5mr1208169ply.43.1699670993291;
        Fri, 10 Nov 2023 18:49:53 -0800 (PST)
Received: from localhost ([2620:10d:c090:400::4:7384])
        by smtp.gmail.com with ESMTPSA id b6-20020a170902a9c600b001b392bf9192sm346665plr.145.2023.11.10.18.49.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Nov 2023 18:49:52 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
From:   Tejun Heo <tj@kernel.org>
To:     torvalds@linux-foundation.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org,
        joshdon@google.com, brho@google.com, pjt@google.com,
        derkling@google.com, haoluo@google.com, dvernet@meta.com,
        dschatzberg@meta.com, dskarlat@cs.cmu.edu, riel@surriel.com,
        changwoo@igalia.com, himadrics@inria.fr, memxor@gmail.com
Cc:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        kernel-team@meta.com, Tejun Heo <tj@kernel.org>
Subject: [PATCH 30/36] sched_ext: Implement sched_ext_ops.cpu_online/offline()
Date:   Fri, 10 Nov 2023 16:47:56 -1000
Message-ID: <20231111024835.2164816-31-tj@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231111024835.2164816-1-tj@kernel.org>
References: <20231111024835.2164816-1-tj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add ops.cpu_online/offline() which are invoked when CPUs come online and
offline respectively. As the enqueue path already automatically bypasses
tasks to the local dsq on a deactivated CPU, BPF schedulers are guaranteed
to see tasks only on CPUs which are between online() and offline().

Signed-off-by: Tejun Heo <tj@kernel.org>
Reviewed-by: David Vernet <dvernet@meta.com>
Acked-by: Josh Don <joshdon@google.com>
Acked-by: Hao Luo <haoluo@google.com>
Acked-by: Barret Rhoden <brho@google.com>
---
 include/linux/sched/ext.h | 18 ++++++++++++++++++
 kernel/sched/ext.c        | 18 +++++++++++++++++-
 2 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
index 633a2b550d0c..98b0f20a7c1d 100644
--- a/include/linux/sched/ext.h
+++ b/include/linux/sched/ext.h
@@ -378,6 +378,24 @@ struct sched_ext_ops {
 	 */
 	void (*cpu_release)(s32 cpu, struct scx_cpu_release_args *args);
 
+	/**
+	 * cpu_online - A CPU became online
+	 * @cpu: CPU which just came up
+	 *
+	 * @cpu just came online. @cpu doesn't call ops.enqueue() or run tasks
+	 * associated with other CPUs beforehand.
+	 */
+	void (*cpu_online)(s32 cpu);
+
+	/**
+	 * cpu_offline - A CPU is going offline
+	 * @cpu: CPU which is going offline
+	 *
+	 * @cpu is going offline. @cpu doesn't call ops.enqueue() or run tasks
+	 * associated with other CPUs afterwards.
+	 */
+	void (*cpu_offline)(s32 cpu);
+
 	/**
 	 * prep_enable - Prepare to enable BPF scheduling for a task
 	 * @p: task to prepare BPF scheduling for
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 4e00a7cd660e..51078fab6df3 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -1404,7 +1404,8 @@ static int balance_scx(struct rq *rq, struct task_struct *prev,
 		 * emitted in scx_notify_pick_next_task().
 		 */
 		if (SCX_HAS_OP(cpu_acquire))
-			SCX_CALL_OP(0, cpu_acquire, cpu_of(rq), NULL);
+			SCX_CALL_OP(SCX_KF_UNLOCKED, cpu_acquire, cpu_of(rq),
+				    NULL);
 		rq->scx.cpu_released = false;
 	}
 
@@ -1864,6 +1865,18 @@ void __scx_update_idle(struct rq *rq, bool idle)
 #endif
 }
 
+static void rq_online_scx(struct rq *rq, enum rq_onoff_reason reason)
+{
+	if (SCX_HAS_OP(cpu_online) && reason == RQ_ONOFF_HOTPLUG)
+		SCX_CALL_OP(SCX_KF_REST, cpu_online, cpu_of(rq));
+}
+
+static void rq_offline_scx(struct rq *rq, enum rq_onoff_reason reason)
+{
+	if (SCX_HAS_OP(cpu_offline) && reason == RQ_ONOFF_HOTPLUG)
+		SCX_CALL_OP(SCX_KF_REST, cpu_offline, cpu_of(rq));
+}
+
 #else /* !CONFIG_SMP */
 
 static bool test_and_clear_cpu_idle(int cpu) { return false; }
@@ -2381,6 +2394,9 @@ DEFINE_SCHED_CLASS(ext) = {
 	.balance		= balance_scx,
 	.select_task_rq		= select_task_rq_scx,
 	.set_cpus_allowed	= set_cpus_allowed_scx,
+
+	.rq_online		= rq_online_scx,
+	.rq_offline		= rq_offline_scx,
 #endif
 
 	.task_tick		= task_tick_scx,
-- 
2.42.0

