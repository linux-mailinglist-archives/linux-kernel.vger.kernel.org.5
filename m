Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91B47777289
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 10:14:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234104AbjHJIOF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 04:14:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234089AbjHJIN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 04:13:59 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA7EE2683
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 01:13:36 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-686efb9ee3cso578541b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 01:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1691655216; x=1692260016;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V+gOX8E32N7J0qn1e/cgbPAAdyKUl0JYooXv5sNbHuI=;
        b=OG7IuzB6CPOFfsV9wFrgnazb3f1VQrgIV5f+OOZdkCCvMJDzb3aV1VZFFlJjpUsXA3
         +BP87n9CA/2IoiPk0nP0DzRB7WQ7FQy3RpzkGS3xJcTT6KV93ClOZg7CbgeULa7wj9ly
         Fr3KCTw83jY9eghkbiZB2yqiscmS6/rgT4aHFfjPPmngWuHbHqylqAWkCsuflY/r6XA/
         u+1EJS1Q7o+TgHUDSY/Y9RXZe993prhItKrseX0iBXnPuQufH4ZiVy6hcumq/SQIiGp4
         weiY7Tex+vf38O2Fi3m5cUUfZFvNYFueWFQFMKwYqa/fe7Wq4zxqt5ZSwFX0OfTK0l6P
         IEEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691655216; x=1692260016;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V+gOX8E32N7J0qn1e/cgbPAAdyKUl0JYooXv5sNbHuI=;
        b=ZFy+105Bz1Tc7JUwW59smB6b+rR2mt/1DQXnaqI6b50GAioaKK61BvlV3SUo7lUKyS
         lUfmPz/09yVq8XG88vftM5bV7TuUy3JNk52TTfw4DLG+xfABHzFaMC7r2cggcRHp5omg
         tdQfqnObMXTqpTHVd61cgj/NtPRHDKLrLQkiLt6jePBCvfLA/NrC7PNmPCO5TFpMT2U1
         +y/yoSow1hTr15Y5qkJrT4OsARkbBnIOvnrKaSa4jc8lZv04GpOrjqu56zRqOfH8I2dk
         BQgZeHNT0C4IMxcMsmAOeADRO9/az15Txv8K8Ox6iVucRbHdKyma1Eq/+pfgtFXlhoZ0
         z3og==
X-Gm-Message-State: AOJu0Yyi5voIoxNMNK9P2NLv+YYo2E23LSGVZrfynAi1HaQhusj3MxK5
        zLfU0sLXPWw7a8sAdOOG1ca9ag==
X-Google-Smtp-Source: AGHT+IGtscS04wQJzOPzeNPixXB/Nvlgj5vG5uoIWZkaaoCuS2LHPKsrUQS+DTx+/kSMNoPf/s1uqQ==
X-Received: by 2002:a17:903:246:b0:1b8:76ce:9d91 with SMTP id j6-20020a170903024600b001b876ce9d91mr1911030plh.1.1691655216226;
        Thu, 10 Aug 2023 01:13:36 -0700 (PDT)
Received: from n37-019-243.byted.org ([180.184.51.40])
        by smtp.gmail.com with ESMTPSA id x12-20020a170902ec8c00b001b1a2c14a4asm1019036plg.38.2023.08.10.01.13.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 01:13:35 -0700 (PDT)
From:   Chuyi Zhou <zhouchuyi@bytedance.com>
To:     hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        muchun.song@linux.dev
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        wuyun.abel@bytedance.com, robin.lu@bytedance.com,
        Chuyi Zhou <zhouchuyi@bytedance.com>
Subject: [RFC PATCH v2 2/5] mm: Add policy_name to identify OOM policies
Date:   Thu, 10 Aug 2023 16:13:16 +0800
Message-Id: <20230810081319.65668-3-zhouchuyi@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230810081319.65668-1-zhouchuyi@bytedance.com>
References: <20230810081319.65668-1-zhouchuyi@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a new metadata policy_name in oom_control and report it
in dump_header(), so we can know what has been the selection policy. In
BPF program, we can call kfunc set_oom_policy_name to set the current
user-defined policy name. The in-kernel policy_name is "default".

Signed-off-by: Chuyi Zhou <zhouchuyi@bytedance.com>
---
 include/linux/oom.h |  7 +++++++
 mm/oom_kill.c       | 42 +++++++++++++++++++++++++++++++++++++++---
 2 files changed, 46 insertions(+), 3 deletions(-)

diff --git a/include/linux/oom.h b/include/linux/oom.h
index 7d0c9c48a0c5..69d0f2ec6ea6 100644
--- a/include/linux/oom.h
+++ b/include/linux/oom.h
@@ -22,6 +22,10 @@ enum oom_constraint {
 	CONSTRAINT_MEMCG,
 };
 
+enum {
+	POLICY_NAME_LEN = 16,
+};
+
 /*
  * Details of the page allocation that triggered the oom killer that are used to
  * determine what should be killed.
@@ -52,6 +56,9 @@ struct oom_control {
 
 	/* Used to print the constraint info. */
 	enum oom_constraint constraint;
+
+	/* Used to report the policy info. */
+	char policy_name[POLICY_NAME_LEN];
 };
 
 extern struct mutex oom_lock;
diff --git a/mm/oom_kill.c b/mm/oom_kill.c
index 255c9ef1d808..3239dcdba4d7 100644
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -443,6 +443,35 @@ static int dump_task(struct task_struct *p, void *arg)
 	return 0;
 }
 
+__bpf_kfunc void set_oom_policy_name(struct oom_control *oc, const char *src, size_t sz)
+{
+	memset(oc->policy_name, 0, sizeof(oc->policy_name));
+
+	if (sz > POLICY_NAME_LEN)
+		sz = POLICY_NAME_LEN;
+
+	memcpy(oc->policy_name, src, sz);
+}
+
+__diag_push();
+__diag_ignore_all("-Wmissing-prototypes",
+		  "kfuncs which will be used in BPF programs");
+
+__weak noinline void bpf_set_policy_name(struct oom_control *oc)
+{
+}
+
+__diag_pop();
+
+BTF_SET8_START(bpf_oom_policy_kfunc_ids)
+BTF_ID_FLAGS(func, set_oom_policy_name)
+BTF_SET8_END(bpf_oom_policy_kfunc_ids)
+
+static const struct btf_kfunc_id_set bpf_oom_policy_kfunc_set = {
+	.owner          = THIS_MODULE,
+	.set            = &bpf_oom_policy_kfunc_ids,
+};
+
 /**
  * dump_tasks - dump current memory state of all system tasks
  * @oc: pointer to struct oom_control
@@ -484,8 +513,8 @@ static void dump_oom_summary(struct oom_control *oc, struct task_struct *victim)
 
 static void dump_header(struct oom_control *oc, struct task_struct *p)
 {
-	pr_warn("%s invoked oom-killer: gfp_mask=%#x(%pGg), order=%d, oom_score_adj=%hd\n",
-		current->comm, oc->gfp_mask, &oc->gfp_mask, oc->order,
+	pr_warn("%s invoked oom-killer: gfp_mask=%#x(%pGg), order=%d, policy_name=%s, oom_score_adj=%hd\n",
+		current->comm, oc->gfp_mask, &oc->gfp_mask, oc->order, oc->policy_name,
 			current->signal->oom_score_adj);
 	if (!IS_ENABLED(CONFIG_COMPACTION) && oc->order)
 		pr_warn("COMPACTION is disabled!!!\n");
@@ -775,8 +804,11 @@ static int __init oom_init(void)
 	err = register_btf_fmodret_id_set(&oom_bpf_fmodret_set);
 	if (err)
 		pr_warn("error while registering oom fmodret entrypoints: %d", err);
+	err = register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING,
+					&bpf_oom_policy_kfunc_set);
+	if (err)
+		pr_warn("error while registering oom kfunc entrypoints: %d", err);
 #endif
-
 	return 0;
 }
 subsys_initcall(oom_init)
@@ -1196,6 +1228,10 @@ bool out_of_memory(struct oom_control *oc)
 		return true;
 	}
 
+	set_oom_policy_name(oc, "default", sizeof("default"));
+
+	bpf_set_policy_name(oc);
+
 	select_bad_process(oc);
 	/* Found nothing?!?! */
 	if (!oc->chosen) {
-- 
2.20.1

