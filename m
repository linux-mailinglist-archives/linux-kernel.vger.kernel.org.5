Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 226E577EB05
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 22:50:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346257AbjHPUt3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 16:49:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346296AbjHPUtT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 16:49:19 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61A671FCE
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 13:49:18 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id ca18e2360f4ac-79196067c75so174781939f.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 13:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1692218957; x=1692823757;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iBU6OAHisDW8IjSoPB1UV1dGy/bG7wQX5Wr7I8sL+PE=;
        b=pYEggQZz15ir02ay+i6tIa1sOsfTsu6fBmwOHQgwONqyeQmnwZujoOFbydC4kcnSPf
         XPDAlI+Fgz/D4KZpt+v4H2n+GBkngvyApFLLMC03FL9PSRCbk9TyIAsW0r5N+s/JvLGa
         +pAANWGlrXY334SUA9pZqvWeNEVMHeI+C5D+0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692218957; x=1692823757;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iBU6OAHisDW8IjSoPB1UV1dGy/bG7wQX5Wr7I8sL+PE=;
        b=GySTiqHZ2id29XHq2hFPZtMkQb8T6R4p7Fn1j/bsJrk78rcme7Kx3aHmfm/z37q0Ue
         4nD3zG9JraOhj0a622B5K/ploeTTao8U8/nO1TOnDgFIN4ibPPUfGnX1PjfuUcg7Pij5
         isO3BEp6mrZgnsvX4sW12DRk7yIRB8YPcnXdC+PIhS82aKJRjdZO5h9FjRFub1z+G5pf
         EeBqxHZ9tvs+6X2mU8tgbj8Xf1JbtYqxRtl4ivblvJxen2Phop9J6isGzB5k1eqU3TCz
         3352u2PE8okAGUsufxzGXRx6anTo2qi+wCbOQ9xNu5oPEfR83pIfLGlnhrTVpAQFn5Pm
         MsiQ==
X-Gm-Message-State: AOJu0Yz4yP1k0VQ2dHFg6BEDNh84Eyy2gW6g0ut/UiF+JZaEL2Vi3rEn
        nUFc09CclAKBr8Uu1lfEU+O4eH8bJWJGqkxt2EU=
X-Google-Smtp-Source: AGHT+IEIvbFcHHoRWxRpHydXEK6MEYyts6fqcvvYu5MoQ7579t5qhGp/23TYyMKRz5mL+c7gKImf2g==
X-Received: by 2002:a05:6e02:218f:b0:349:4776:7e01 with SMTP id j15-20020a056e02218f00b0034947767e01mr4081268ila.19.1692218957310;
        Wed, 16 Aug 2023 13:49:17 -0700 (PDT)
Received: from joelboxx5.c.googlers.com.com (156.190.123.34.bc.googleusercontent.com. [34.123.190.156])
        by smtp.gmail.com with ESMTPSA id t11-20020a92ca8b000000b0032afe23820bsm4478513ilo.17.2023.08.16.13.49.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 13:49:16 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Zqiang <qiang.zhang1211@gmail.com>
Cc:     rcu@vger.kernel.org
Subject: [PATCH] rcutorture: Replace schedule_timeout*() 1 jiffie waits with HZ/20
Date:   Wed, 16 Aug 2023 20:49:12 +0000
Message-ID: <20230816204913.450457-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.41.0.694.ge786442a9b-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the past, we see that spinning on schedule_timeout* with a wait of 1
jiffie can hang the kernel. See d52d3a2bf408 ("torture: Fix hang during
kthread shutdown phase").

Recently again it showed up in torture's stutter code as well. The behavior is
the the function may instantly return and never go to sleep preempting whatever
was running under it.

To prevent future issues, apply the same fix mentioned in the above
commit d52d3a2bf408 to more places.

I took care to only apply it to places where I thought it made sense.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 kernel/rcu/rcutorture.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 8dd52ea78b52..a31297f32a2a 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -1153,7 +1153,7 @@ static int rcu_torture_boost(void *arg)
 				mutex_unlock(&boost_mutex);
 				break;
 			}
-			schedule_timeout_uninterruptible(1);
+			schedule_timeout_uninterruptible(HZ / 20);
 		}
 
 		/* Go do the stutter. */
@@ -1164,7 +1164,7 @@ checkwait:	if (stutter_wait("rcu_torture_boost"))
 	/* Clean up and exit. */
 	while (!kthread_should_stop()) {
 		torture_shutdown_absorb("rcu_torture_boost");
-		schedule_timeout_uninterruptible(1);
+		schedule_timeout_uninterruptible(HZ / 20);
 	}
 	torture_kthread_stopping("rcu_torture_boost");
 	return 0;
@@ -1187,7 +1187,7 @@ rcu_torture_fqs(void *arg)
 		fqs_resume_time = jiffies + fqs_stutter * HZ;
 		while (time_before(jiffies, fqs_resume_time) &&
 		       !kthread_should_stop()) {
-			schedule_timeout_interruptible(1);
+			schedule_timeout_interruptible(HZ / 20);
 		}
 		fqs_burst_remaining = fqs_duration;
 		while (fqs_burst_remaining > 0 &&
@@ -2903,7 +2903,7 @@ static int rcu_torture_fwd_prog(void *args)
 			WRITE_ONCE(rcu_fwd_seq, rcu_fwd_seq + 1);
 		} else {
 			while (READ_ONCE(rcu_fwd_seq) == oldseq && !torture_must_stop())
-				schedule_timeout_interruptible(1);
+				schedule_timeout_interruptible(HZ / 20);
 			oldseq = READ_ONCE(rcu_fwd_seq);
 		}
 		pr_alert("%s: Starting forward-progress test %d\n", __func__, rfp->rcu_fwd_id);
@@ -3204,7 +3204,7 @@ static int rcu_torture_read_exit_child(void *trsp_in)
 	set_user_nice(current, MAX_NICE);
 	// Minimize time between reading and exiting.
 	while (!kthread_should_stop())
-		schedule_timeout_uninterruptible(1);
+		schedule_timeout_uninterruptible(HZ / 20);
 	(void)rcu_torture_one_read(trsp, -1);
 	return 0;
 }
@@ -3252,7 +3252,7 @@ static int rcu_torture_read_exit(void *unused)
 	smp_mb(); // Store before wakeup.
 	wake_up(&read_exit_wq);
 	while (!torture_must_stop())
-		schedule_timeout_uninterruptible(1);
+		schedule_timeout_uninterruptible(HZ / 20);
 	torture_kthread_stopping("rcu_torture_read_exit");
 	return 0;
 }
-- 
2.41.0.694.ge786442a9b-goog

