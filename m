Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1100B80F4D5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 18:44:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376991AbjLLRoW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 12:44:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235100AbjLLRoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 12:44:20 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC7C394;
        Tue, 12 Dec 2023 09:44:26 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1d3448937ddso3852075ad.2;
        Tue, 12 Dec 2023 09:44:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702403065; x=1703007865; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5KKzp1EbEDs6N+rI5JIGWryzdQ1kJSdRSLI+Af4oxu8=;
        b=ZBlrOGB/scjQxQcRFsobpGpiha+btbQ77K74SbKWdUxQANqW56bOX3c1761baxJeKb
         aNfWhOYnIZYwkLRjLcdGyVt1sOJIsgSRldPkj+MJUtXLNsGF2dzIRTZhWcuslJKIXIlq
         rf13BGVDKjWPq9ajbaR9Z6TYZnORAykNIfTPiYH9tlTd+qwNnroXkn+oBhdXiqXBdych
         XbNX9Qplp7Ai/2lImS6BqVZwVSDbjr4vSRDglTrGIFnKv883BTDWETla9XzoP5uuS07L
         eu7kZGgMewyn37gKW8/VXbO9KbPayGencOaJ561Q5nPvWpOrtc2k+6WCaMPSnac+zGos
         3x0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702403065; x=1703007865;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5KKzp1EbEDs6N+rI5JIGWryzdQ1kJSdRSLI+Af4oxu8=;
        b=X4DUbvquaAyYyQAQkImHiJmswTjFFfdXeRbhjB2eUytNeJR+xpp1RhfsxEABluImVV
         jRHdyzZ+6wDLEqd4j2JxY5oQAfWCVl3VdNTMdGCCl1PoSf5vIj6RhSDDapSAiJUOFmMz
         W+sy6pQ+4xS4H+g/GcPAhuRjlcvdZ1640D/Tb7Cu1tVyZ4pblT/wEG4KQhO1dkJwvPEy
         YFIvRfusFDZebnm5kHyJ4UgdsoP209o5l9TV4yuCvCCSZ9qi3CLoeQSo/MuBTO5KiPwk
         ve7+fkaaq89PGkuc+uYr75UcCQVpFcQP3liwkOqyBldh8eRbeGPylg6dL9FlwUHiI0BZ
         rgEg==
X-Gm-Message-State: AOJu0YxIQxNqnf296VPvhRGOTnW6G07jadSdVLwhYN4J45fPCSOceNEB
        2W1gV81UUTUhwr01FBXQNh7B3LW8rac4/Gcf
X-Google-Smtp-Source: AGHT+IEQGOmnlGiG4EEyXbW/ZmLkZMLVu58QKVIhOgRRi1/SOfshTbiX74NTBLVUPcPtKkjoUW/4KQ==
X-Received: by 2002:a17:902:d2cf:b0:1d0:c986:8aae with SMTP id n15-20020a170902d2cf00b001d0c9868aaemr3983134plc.97.1702403065304;
        Tue, 12 Dec 2023 09:44:25 -0800 (PST)
Received: from localhost.localdomain ([101.0.63.152])
        by smtp.gmail.com with ESMTPSA id d14-20020a170902cece00b001d0cd48e08fsm8975208plg.179.2023.12.12.09.44.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 09:44:24 -0800 (PST)
From:   "Neeraj Upadhyay (AMD)" <neeraj.iitr10@gmail.com>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, paulmck@kernel.org, Neeraj.Upadhyay@amd.com,
        Boqun Feng <boqun.feng@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Neeraj Upadhyay <neeraj.iitr10@gmail.com>
Subject: [PATCH rcu 1/1] rcu-tasks: Mark RCU Tasks accesses to current->rcu_tasks_idle_cpu
Date:   Tue, 12 Dec 2023 23:13:50 +0530
Message-Id: <20231212174350.11835-1-neeraj.iitr10@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231212174331.GA11807@neeraj.linux>
References: <20231212174331.GA11807@neeraj.linux>
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

From: "Paul E. McKenney" <paulmck@kernel.org>

The task_struct structure's ->rcu_tasks_idle_cpu can be concurrently
read and written from the RCU Tasks grace-period kthread and from the
CPU on which the task_struct structure's task is running.  This commit
therefore marks the accesses appropriately.

Reported-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Neeraj Upadhyay (AMD) <neeraj.iitr10@gmail.com>
---
 kernel/rcu/tasks.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index f54d5782eca0..732ad5b39946 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -975,7 +975,7 @@ static void check_holdout_task(struct task_struct *t,
 	    t->rcu_tasks_nvcsw != READ_ONCE(t->nvcsw) ||
 	    !rcu_tasks_is_holdout(t) ||
 	    (IS_ENABLED(CONFIG_NO_HZ_FULL) &&
-	     !is_idle_task(t) && t->rcu_tasks_idle_cpu >= 0)) {
+	     !is_idle_task(t) && READ_ONCE(t->rcu_tasks_idle_cpu) >= 0)) {
 		WRITE_ONCE(t->rcu_tasks_holdout, false);
 		list_del_init(&t->rcu_tasks_holdout_list);
 		put_task_struct(t);
@@ -993,7 +993,7 @@ static void check_holdout_task(struct task_struct *t,
 		 t, ".I"[is_idle_task(t)],
 		 "N."[cpu < 0 || !tick_nohz_full_cpu(cpu)],
 		 t->rcu_tasks_nvcsw, t->nvcsw, t->rcu_tasks_holdout,
-		 t->rcu_tasks_idle_cpu, cpu);
+		 data_race(t->rcu_tasks_idle_cpu), cpu);
 	sched_show_task(t);
 }
 
-- 
2.40.1

