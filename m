Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8055E7C5313
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 14:09:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346839AbjJKMJ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 08:09:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346720AbjJKMJV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 08:09:21 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34260E5
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 05:09:18 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-68fb85afef4so5212654b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 05:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1697026158; x=1697630958; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FNW2oYGtelVvgczyk2A13Ij/ocoUNYFTCyV6b+P6gh8=;
        b=Mmo0Lnn+6H8KnO/eFtAmfbbl3hOGYqf/dJPe2Gl7jKVZA6i5IUgfYQmNNLIddHocA+
         khn0amvjF094s7IG8TQIcf0740yn5BdlfLgsg+7Jdf0Y6u5Ch/xYr7wdfLd4UULrtYJO
         VGwe4GAU0n8qKA9iiqRGZFi8Dk5yEFpg54ZAU6s1HJ8y8dRg8yRWhrvk1SpyOfy++Z51
         WCNs6OJGScGEa/qwzJJZiEjsbGHVgXOBtzqGjqumoSwQcaJA0hZ/vD/Pl9XSNl9Ke/pS
         3YyynfVVqBpQ9rWrZuyp5KdApZQbZNHCU4c0FspeyoSMJ2o7kaJfsVx4c2s8RRDKB/kw
         YERw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697026158; x=1697630958;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FNW2oYGtelVvgczyk2A13Ij/ocoUNYFTCyV6b+P6gh8=;
        b=Ts7UQnRpyOVaCXHiFVuJangKHvQbNfWmYJU+CSEEMgThOsBspniZPv6w1yRzPl3wWu
         uB4w+hbEXCzgu2RSHhpK++lm7vot+peXsCN+jvsIb7rmifgDUgaQryU0ggYxjRkyb6Ee
         SdFiF6UWUofEBtKbDUB2UAf3l+vGEPNv/ybTpQbdbVLXYRO7ZGg4iEzpTL/6+2n9D+HL
         1ppjFgJIDpg7OUzvQciua6x8tXFoWDHdtKr1Utae6OapP5V/c1Nm5z8+A0IT0T/91KoB
         aD6bSRKjAB+CAxd0WgOO6P9WdyfVPaWXzpU+E9ZKcxc4nfj1DtRvXTlciSvsgAFZYEg2
         kZjA==
X-Gm-Message-State: AOJu0Ywg2mA16wwcsjJCG70JtiZG1yvf6J+WiIa6EeMBx+8wUo+4Fa1K
        RNC7Md23amWp7qIKtLzaMb9Yyw==
X-Google-Smtp-Source: AGHT+IESYxnB1J1sRdVkJQH+ZE6Y19Leh4aJwAI7/dVl9OQScpOyuiqMRtRlItHAn1x1rBydnQwedg==
X-Received: by 2002:a05:6a00:4217:b0:697:4901:3d4d with SMTP id cd23-20020a056a00421700b0069749013d4dmr17449212pfb.5.1697026157840;
        Wed, 11 Oct 2023 05:09:17 -0700 (PDT)
Received: from n37-019-243.byted.org ([180.184.51.142])
        by smtp.gmail.com with ESMTPSA id u13-20020a62ed0d000000b006930db1e6cfsm9962769pfh.62.2023.10.11.05.09.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 05:09:17 -0700 (PDT)
From:   Chuyi Zhou <zhouchuyi@bytedance.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@kernel.org, tj@kernel.org, linux-kernel@vger.kernel.org,
        Chuyi Zhou <zhouchuyi@bytedance.com>
Subject: [PATCH bpf-next v5 1/8] cgroup: Prepare for using css_task_iter_*() in BPF
Date:   Wed, 11 Oct 2023 20:08:50 +0800
Message-Id: <20231011120857.251943-2-zhouchuyi@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20231011120857.251943-1-zhouchuyi@bytedance.com>
References: <20231011120857.251943-1-zhouchuyi@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes some preparations for using css_task_iter_*() in BPF
Program.

1. Flags CSS_TASK_ITER_* are #define-s and it's not easy for bpf prog to
use them. Convert them to enum so bpf prog can take them from vmlinux.h.

2. In the next patch we will add css_task_iter_*() in common kfuncs which
is not safe. Since css_task_iter_*() does spin_unlock_irq() which might
screw up irq flags depending on the context where bpf prog is running.
So we should use irqsave/irqrestore here and the switching is harmless.

Suggested-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Chuyi Zhou <zhouchuyi@bytedance.com>
Acked-by: Tejun Heo <tj@kernel.org>
---
 include/linux/cgroup.h | 12 +++++-------
 kernel/cgroup/cgroup.c | 18 ++++++++++++------
 2 files changed, 17 insertions(+), 13 deletions(-)

diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
index b307013b9c6c..0ef0af66080e 100644
--- a/include/linux/cgroup.h
+++ b/include/linux/cgroup.h
@@ -40,13 +40,11 @@ struct kernel_clone_args;
 #define CGROUP_WEIGHT_DFL		100
 #define CGROUP_WEIGHT_MAX		10000
 
-/* walk only threadgroup leaders */
-#define CSS_TASK_ITER_PROCS		(1U << 0)
-/* walk all threaded css_sets in the domain */
-#define CSS_TASK_ITER_THREADED		(1U << 1)
-
-/* internal flags */
-#define CSS_TASK_ITER_SKIPPED		(1U << 16)
+enum {
+	CSS_TASK_ITER_PROCS    = (1U << 0),  /* walk only threadgroup leaders */
+	CSS_TASK_ITER_THREADED = (1U << 1),  /* walk all threaded css_sets in the domain */
+	CSS_TASK_ITER_SKIPPED  = (1U << 16), /* internal flags */
+};
 
 /* a css_task_iter should be treated as an opaque object */
 struct css_task_iter {
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 1fb7f562289d..b6d64f3b8888 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -4917,9 +4917,11 @@ static void css_task_iter_advance(struct css_task_iter *it)
 void css_task_iter_start(struct cgroup_subsys_state *css, unsigned int flags,
 			 struct css_task_iter *it)
 {
+	unsigned long irqflags;
+
 	memset(it, 0, sizeof(*it));
 
-	spin_lock_irq(&css_set_lock);
+	spin_lock_irqsave(&css_set_lock, irqflags);
 
 	it->ss = css->ss;
 	it->flags = flags;
@@ -4933,7 +4935,7 @@ void css_task_iter_start(struct cgroup_subsys_state *css, unsigned int flags,
 
 	css_task_iter_advance(it);
 
-	spin_unlock_irq(&css_set_lock);
+	spin_unlock_irqrestore(&css_set_lock, irqflags);
 }
 
 /**
@@ -4946,12 +4948,14 @@ void css_task_iter_start(struct cgroup_subsys_state *css, unsigned int flags,
  */
 struct task_struct *css_task_iter_next(struct css_task_iter *it)
 {
+	unsigned long irqflags;
+
 	if (it->cur_task) {
 		put_task_struct(it->cur_task);
 		it->cur_task = NULL;
 	}
 
-	spin_lock_irq(&css_set_lock);
+	spin_lock_irqsave(&css_set_lock, irqflags);
 
 	/* @it may be half-advanced by skips, finish advancing */
 	if (it->flags & CSS_TASK_ITER_SKIPPED)
@@ -4964,7 +4968,7 @@ struct task_struct *css_task_iter_next(struct css_task_iter *it)
 		css_task_iter_advance(it);
 	}
 
-	spin_unlock_irq(&css_set_lock);
+	spin_unlock_irqrestore(&css_set_lock, irqflags);
 
 	return it->cur_task;
 }
@@ -4977,11 +4981,13 @@ struct task_struct *css_task_iter_next(struct css_task_iter *it)
  */
 void css_task_iter_end(struct css_task_iter *it)
 {
+	unsigned long irqflags;
+
 	if (it->cur_cset) {
-		spin_lock_irq(&css_set_lock);
+		spin_lock_irqsave(&css_set_lock, irqflags);
 		list_del(&it->iters_node);
 		put_css_set_locked(it->cur_cset);
-		spin_unlock_irq(&css_set_lock);
+		spin_unlock_irqrestore(&css_set_lock, irqflags);
 	}
 
 	if (it->cur_dcset)
-- 
2.20.1

