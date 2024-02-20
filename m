Return-Path: <linux-kernel+bounces-73511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CED3085C3A3
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 19:32:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CA781C21C8A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 18:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3DE7129A82;
	Tue, 20 Feb 2024 18:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OZNAvdcl"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F479127B76;
	Tue, 20 Feb 2024 18:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708453885; cv=none; b=ltpjKX1EywNdQ3pIkyWg3u/UgXEu4cEWQmGkwgGj11F/Z4niX5PEX60hR9eqVrHZ74ApdGdRAVwMmvMs0MyYIh81AYe2rJMRMKorF02rghjUxmLVEKAcEHocO6mjce9mW+7YH8JScilPeJ0pJlHkCWpvw0Hnu6VwGw9Jpd/KL04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708453885; c=relaxed/simple;
	bh=l89RWgPz2iqTJBk3s+AeEhVE9dSu7ScUqa1mPU2DCVk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ezf/I9hJ5qI8CD73+efOHbqJ9UbK7ywDaZaTzbIWdOV7K/P+P7RzwVYFX2PUYaagkppFH0eTWsTyQz2ZF87+A3XX+bk3fjeop5jm3hEE9EPRCEmKB1cW0DQtOZq+sJZ0NdBVgh6Im9VZfIUGoVXY9n/+9T8WfUC0dD31ihZPKyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OZNAvdcl; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-512bce554a5so2601905e87.3;
        Tue, 20 Feb 2024 10:31:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708453881; x=1709058681; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6kWaBqD0vOuk8Z+fTVr0T6CR2C9b1D4p7NocTjVSfYM=;
        b=OZNAvdclwuQjawJ3A3KZ0sALhuWfKa3gdWtQfHGrKqX3siy60QAcK5gqoO0NVb6yP7
         z0kn0cfsQuQfOxu4dK3akVvc7Vw+pEmk98SSD6cKdAS6fjyFNf1q72+LBvXs0fr5bp0l
         eV64SnvTJzJooAOs+/BEeuYWnWeqgphatXQUxxTlQQ0aZh8Yrc6AyHPsjDKhXpRNRRY5
         qRTPShR4wg/IzFW/PLVENhJRju1Pj8s2igGFBcRnmtmgyPpw7WmkSmgIHZ5Xp9OI04Yk
         4HhrPkziX53HizYmU/eIKvoMcOOhE0qKc8jM5KYtAbj5Qf50KVMHPQ+oQnfo1OcTJxrn
         bTGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708453881; x=1709058681;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6kWaBqD0vOuk8Z+fTVr0T6CR2C9b1D4p7NocTjVSfYM=;
        b=Lg77LX3lM0Bbh2yqshg2YUAQmk7AqxabvtUYhqYBipNyRdu5SqWJcBuhtK2L9z7ptc
         85tvvgkNvs/+rPZjJqxrhmXeDPBELGtqL2hl8kcBMO1zbMFktASoUtOpNv4GDd4R8x7J
         NAXlvQxQuozEB32jjaHsq+H8J9+kGNVNXiuO7ei7vy/zlK2/yo6htGsAmlHlZ8mOOc5v
         ubnOcZgTdR0P4cvRbJbGTs38bbY22mNdTCc9IFgxGtvLNdDWwhoyYCa89vG2b+wL+M1p
         keTv1IcBiefCwV+kLbjo/auedYI+rn3vdxdIdKwxoZtpEj+tMNS/8AFJLkoRM1fETjyS
         Jwbw==
X-Forwarded-Encrypted: i=1; AJvYcCVxD5Z8EhgcqHRWLMmEMR4G5W0NtQw1Y6tKXFAodz6KnThAsQ2lb8uBQHb9G1qtlRqwGXUI1ajHVesNiY8xYN0WsTz2xdeoXNvgEZtx
X-Gm-Message-State: AOJu0YyMAncnR8XmJtBO2cSV10qNflSFnQfrbPdGY6vk+uqzJRQLzGnP
	D8KAjFuzasLBk7WbCVn3mAbvDye2bGnoVJXfNmID1MLbiihJeACdvLje+R52
X-Google-Smtp-Source: AGHT+IEIFruNbjA6lIlRnwaNww/H4ag/9ylwKLheyLBkY8mB91yELl6eJpDS8GU14tELfL9nNLw9Lg==
X-Received: by 2002:a05:6512:3c9d:b0:511:9d36:18a8 with SMTP id h29-20020a0565123c9d00b005119d3618a8mr13126055lfv.2.1708453881137;
        Tue, 20 Feb 2024 10:31:21 -0800 (PST)
Received: from pc638.lan (host-185-121-47-193.sydskane.nu. [185.121.47.193])
        by smtp.gmail.com with ESMTPSA id b14-20020ac247ee000000b005118add498asm1365937lfp.130.2024.02.20.10.31.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 10:31:20 -0800 (PST)
From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To: "Paul E . McKenney" <paulmck@kernel.org>
Cc: RCU <rcu@vger.kernel.org>,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Hillf Danton <hdanton@sina.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
	Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH v5 4/4] rcu: Support direct wake-up of synchronize_rcu() users
Date: Tue, 20 Feb 2024 19:31:15 +0100
Message-Id: <20240220183115.74124-5-urezki@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240220183115.74124-1-urezki@gmail.com>
References: <20240220183115.74124-1-urezki@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch introduces a small enhancement which allows to do a
direct wake-up of synchronize_rcu() callers. It occurs after a
completion of grace period, thus by the gp-kthread.

Number of clients is limited by the hard-coded maximum allowed
threshold. The remaining part, if still exists is deferred to
a main worker.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 kernel/rcu/tree.c | 31 +++++++++++++++++++++++++++++--
 kernel/rcu/tree.h |  6 ++++++
 2 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 3bf6b3c5ef05..31f3a61f9c38 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1644,7 +1644,8 @@ static void rcu_sr_normal_gp_cleanup_work(struct work_struct *work)
  */
 static void rcu_sr_normal_gp_cleanup(void)
 {
-	struct llist_node *wait_tail;
+	struct llist_node *wait_tail, *next, *rcu;
+	int done = 0;
 
 	wait_tail = rcu_state.srs_wait_tail;
 	if (wait_tail == NULL)
@@ -1652,12 +1653,38 @@ static void rcu_sr_normal_gp_cleanup(void)
 
 	rcu_state.srs_wait_tail = NULL;
 	ASSERT_EXCLUSIVE_WRITER(rcu_state.srs_wait_tail);
+	WARN_ON_ONCE(!rcu_sr_is_wait_head(wait_tail));
+
+	/*
+	 * Process (a) and (d) cases. See an illustration. Apart of
+	 * that it handles the scenario when all clients are done,
+	 * wait-head is released if last. The worker is not kicked.
+	 */
+	llist_for_each_safe(rcu, next, wait_tail->next) {
+		if (rcu_sr_is_wait_head(rcu)) {
+			if (!rcu->next) {
+				rcu_sr_put_wait_head(rcu);
+				wait_tail->next = NULL;
+			} else {
+				wait_tail->next = rcu;
+			}
+
+			break;
+		}
+
+		rcu_sr_normal_complete(rcu);
+		// It can be last, update a next on this step.
+		wait_tail->next = next;
+
+		if (++done == SR_MAX_USERS_WAKE_FROM_GP)
+			break;
+	}
 
 	// concurrent sr_normal_gp_cleanup work might observe this update.
 	smp_store_release(&rcu_state.srs_done_tail, wait_tail);
 	ASSERT_EXCLUSIVE_WRITER(rcu_state.srs_done_tail);
 
-	if (wait_tail)
+	if (wait_tail->next)
 		queue_work(system_highpri_wq, &rcu_state.srs_cleanup_work);
 }
 
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index b942b9437438..2832787cee1d 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -315,6 +315,12 @@ do {									\
 	__set_current_state(TASK_RUNNING);				\
 } while (0)
 
+/*
+ * A max threshold for synchronize_rcu() users which are
+ * awaken directly by the rcu_gp_kthread(). Left part is
+ * deferred to the main worker.
+ */
+#define SR_MAX_USERS_WAKE_FROM_GP 5
 #define SR_NORMAL_GP_WAIT_HEAD_MAX 5
 
 struct sr_wait_node {
-- 
2.39.2


