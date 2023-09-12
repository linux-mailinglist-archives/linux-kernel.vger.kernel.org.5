Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A4CF79C784
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 09:02:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231302AbjILHCd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 03:02:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231328AbjILHCa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 03:02:30 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5195810EC
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 00:02:03 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1bf6ea270b2so35558715ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 00:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1694502123; x=1695106923; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HDkGVzbyVwp5CP2Bj0/gBikBLcGAUp0LBh7IxC9dYSw=;
        b=FuKgP0rdrCNA8BL2+5RQShyltCoZSh6tDMZSCrIaPkjDxlemdkC06K0GeEsnkYypnY
         1P5q0ytA/Wa9uX9rOokYy3bVL7QhC4/mnOg5lGyldv6U9E3UXW94xGBr1iTzzLPwCzNp
         vznLxsYaTmrIn2+UPKGpAB3ua88fhLAR4+0r37N84H7yhRbk2Y8X8wnRkRlL7Blnn+vG
         V8N3ePT6EE0isFWsHU6pdYes5qSfPgtFNHjU3wgHZAimBWV7WSApZ0byr5HZCSU1p/qN
         Hb4+qGeskPP6wsbsiPvxmJNhKV8BG1yop2cson0Os3mCblUf0qc6FplKx6Wq5kZbdgSI
         40ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694502123; x=1695106923;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HDkGVzbyVwp5CP2Bj0/gBikBLcGAUp0LBh7IxC9dYSw=;
        b=gjbCGCmsE5VQXP4mh1yCyrCL4CFY8HoRmVym+osn7fGXEz96aykUR+dsjyuigc5J6J
         Ele/2vMiorNsYXrTuuk6K8+ZqCROQ2qGYW5dOoxb+qkgJvO3g9MsMzQ9pcRHBat4u3tZ
         ba6f3jFurtl+ZedMEYepaG6O5AkhwrXkXYVFOVS652uTBr1f9TSgAnkFfcKOgylDLkqk
         4kMI8PI4nqoB/tjK2jMBOunNVqu5CHoBHASz8Xr+BUM86Le2hfEmu5wyUrGUGW9WDx11
         jO8nTZsWibu1SdRDrPMe1z5Nrs+1Xnz2Ce1x0fRJ0LUaof6p90h2WaCKP4wC30+aRg8z
         HRCg==
X-Gm-Message-State: AOJu0YzdFzlISD+Ts/TKcVaa8/mo0FarsW6F7HMbVD/eGzsuedq+Jbuu
        aGARLN1VaXt5lT/s+F6d6g8awg==
X-Google-Smtp-Source: AGHT+IFckTbjOlPAIMiqK0BYx/GUeBDEJpj6eWIM+X+1r3sNOUrdk6v7pTIn0Cta0Ln/MF1jph7UfQ==
X-Received: by 2002:a17:903:2443:b0:1c3:d864:d6b3 with SMTP id l3-20020a170903244300b001c3d864d6b3mr482903pls.57.1694502122788;
        Tue, 12 Sep 2023 00:02:02 -0700 (PDT)
Received: from n37-019-243.byted.org ([180.184.84.173])
        by smtp.gmail.com with ESMTPSA id b8-20020a170902d50800b001b8953365aesm7635401plg.22.2023.09.12.00.02.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 00:02:02 -0700 (PDT)
From:   Chuyi Zhou <zhouchuyi@bytedance.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@kernel.org, tj@kernel.org, linux-kernel@vger.kernel.org,
        Chuyi Zhou <zhouchuyi@bytedance.com>
Subject: [PATCH bpf-next v2 1/6] cgroup: Prepare for using css_task_iter_*() in BPF
Date:   Tue, 12 Sep 2023 15:01:44 +0800
Message-Id: <20230912070149.969939-2-zhouchuyi@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230912070149.969939-1-zhouchuyi@bytedance.com>
References: <20230912070149.969939-1-zhouchuyi@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Signed-off-by: Chuyi Zhou <zhouchuyi@bytedance.com>
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

