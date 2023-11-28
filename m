Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 958CD7FB377
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 09:01:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234629AbjK1IBH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 03:01:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343963AbjK1IAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 03:00:37 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75B4CB6;
        Tue, 28 Nov 2023 00:00:42 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-50abb83866bso6932977e87.3;
        Tue, 28 Nov 2023 00:00:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701158441; x=1701763241; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MRdqwIFL2uVW5SxPC7i3fG3JaqKAc+zofDkQy5XD79k=;
        b=LfhBQkt4wO0EbJX2OvRJREaSOnZEbNUkktBqO1TRXMgOZ8ds3NkB2YsMFzPlLmtLmY
         wBk5SyDZy4tQiciLSbv791qs56flA+8XRMJWbgrxJpNkrrxeskv8H37gkmRmXazphcW6
         LKXj14loIRF0rTWMV3GuAPUcWNBh+zBL4m7U2N7+uV4CiHJ68Dx3VCYaBso3Me3B3bWw
         /RcXClN2pPmQTsf68A0giys4f+DhwnkRwgj3P0rtheFnll0oxTVLLYIShtYIK/3gzGuU
         J3dtw/zqc3IFuy8nEHs0+yXdh4JesRQmrhUnI8Y8kr66mf74JoQ00UN0XGDyI+mBpN+W
         WjBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701158441; x=1701763241;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MRdqwIFL2uVW5SxPC7i3fG3JaqKAc+zofDkQy5XD79k=;
        b=V4x4lDDxhXBTebb9mjzmNjFdURqOPPLqJ0nae87okG7YgDDgEeGIMrlg1GnE1lxPRf
         W61rBva6utkhWmIke7xMzVc9r/KL5qi5CCFjnuV8XZpyDcLxGAMoJnwN2w63HSR1qZ1O
         hC3SXFi+foFgmdJBkrVhq1H1ClRfSLqF4MItDZzfciz5CC0WqVm4AaO36M6r2daHoJGp
         +blkhDEFNrFuLN3sjPLe+GUqGVzFRVPU2uOrcClQUgEZ/wnKQkMrgj+eC8amFrLlPsRc
         ocRQhfXOquleSMbecCFbEOJV/Yd+ZNl8BAzvZKjEDRjeDlbbdm7YCiM82JrVPdI7NnMk
         q/wA==
X-Gm-Message-State: AOJu0YwTvdclA3soNl3y+WeV1FDYoNe4lDqvFwTdcK3ujOwnUSO4utk0
        Wp5Q+GORhIVVBGSaTga2nG0=
X-Google-Smtp-Source: AGHT+IHe6xi4biLqoNAaaRuvyFCyxXEagtGb5TcjgRABkz7K+RpGBmUMYSw1iQ20LwMVr1VBG52asQ==
X-Received: by 2002:a05:6512:1282:b0:50b:ae9f:bf9c with SMTP id u2-20020a056512128200b0050bae9fbf9cmr5286278lfs.55.1701158440567;
        Tue, 28 Nov 2023 00:00:40 -0800 (PST)
Received: from pc638.lan ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id o16-20020ac24bd0000000b004fe202a5c7csm1765501lfq.135.2023.11.28.00.00.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 00:00:40 -0800 (PST)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     RCU <rcu@vger.kernel.org>,
        Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Hillf Danton <hdanton@sina.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH v3 5/7] rcu: Support direct wake-up of synchronize_rcu() users
Date:   Tue, 28 Nov 2023 09:00:31 +0100
Message-Id: <20231128080033.288050-6-urezki@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231128080033.288050-1-urezki@gmail.com>
References: <20231128080033.288050-1-urezki@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces a small enhancement which allows to do a
direct wake-up of synchronize_rcu() callers. It occurs after a
completion of grace period, thus by the gp-kthread.

Number of clients is limited by the hard-coded maximum allowed
threshold. The remaining part, if still exists is deferred to
a main worker.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 kernel/rcu/tree.c | 39 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 37 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index d7b48996825f..69663a6d5050 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1384,6 +1384,12 @@ static void rcu_poll_gp_seq_end_unlocked(unsigned long *snap)
 		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 }
 
+/*
+ * A max threshold for synchronize_rcu() users which are
+ * awaken directly by the rcu_gp_kthread(). Left part is
+ * deferred to the main worker.
+ */
+#define SR_MAX_USERS_WAKE_FROM_GP 5
 #define SR_NORMAL_GP_WAIT_HEAD_MAX 5
 
 struct sr_wait_node {
@@ -1617,7 +1623,8 @@ static DECLARE_WORK(sr_normal_gp_cleanup, rcu_sr_normal_gp_cleanup_work);
  */
 static void rcu_sr_normal_gp_cleanup(void)
 {
-	struct llist_node *wait_tail;
+	struct llist_node *wait_tail, *head, *rcu;
+	int done = 0;
 
 	wait_tail = sr.srs_wait_tail;
 	if (wait_tail == NULL)
@@ -1626,11 +1633,39 @@ static void rcu_sr_normal_gp_cleanup(void)
 	sr.srs_wait_tail = NULL;
 	ASSERT_EXCLUSIVE_WRITER(sr.srs_wait_tail);
 
+	WARN_ON_ONCE(!rcu_sr_is_wait_head(wait_tail));
+	head = wait_tail->next;
+
+	/*
+	 * Process (a) and (d) cases. See an illustration. Apart of
+	 * that it handles the scenario when all clients are done,
+	 * wait-head is released if last. The worker is not kicked.
+	 */
+	llist_for_each_safe(rcu, head, head) {
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
+		wait_tail->next = head;
+
+		if (++done == SR_MAX_USERS_WAKE_FROM_GP)
+			break;
+	}
+
 	// concurrent sr_normal_gp_cleanup work might observe this update.
 	smp_store_release(&sr.srs_done_tail, wait_tail);
 	ASSERT_EXCLUSIVE_WRITER(sr.srs_done_tail);
 
-	if (wait_tail)
+	if (wait_tail->next)
 		queue_work(system_highpri_wq, &sr_normal_gp_cleanup);
 }
 
-- 
2.39.2

