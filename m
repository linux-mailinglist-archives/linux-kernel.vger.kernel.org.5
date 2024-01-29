Return-Path: <linux-kernel+bounces-43652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02275841735
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 00:59:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56F19B22A54
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 23:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8032D15AACA;
	Mon, 29 Jan 2024 23:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dn40Uogg"
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1609A15A49F;
	Mon, 29 Jan 2024 23:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706572684; cv=none; b=VrAmYjbSPrgrGLlLO6/8HBlSOqMRUK1ucERgmg/XbOsAlTZkOdTiIBPv8TU4msN904VTfgBxd52Pm7wqM6+bHGCBlOZd75XilSwYkMYCIEdP3pmIrF/yFOKCVJlaxWvi0uM28zisQLZUEH3qKcKJ/2ch5kea/uiL8LIjKszMGH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706572684; c=relaxed/simple;
	bh=cMoN08x8DJbrRhShWVbuuVh0Mj9QDkxZOXM+tXs4QhQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RCLwQAoT32wHse+ms/avkkUHRQ4r7IcWfqQ1ml32uRQIwtWd2Il3CcbNLIcKvoxWPkAqlKMz74Uu1qClV7rVtcCK3lk5CkwE6CvMbDo8Qe0CF60EMeftyiKjmW3qG7ceI9ipv0Pzo/a+Lrd4qH21NmeU9Pg1kUODWgv1955LcwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dn40Uogg; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-68009cb4669so26394626d6.1;
        Mon, 29 Jan 2024 15:58:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706572682; x=1707177482; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iHUR1QnArqb/KzcPRauFtcmzZ974lUT6wsV0EVNvRMY=;
        b=dn40UoggpsAnEDlsg/eGxsb8KgPGAYtJuaULbbG6ZQ3PaQDJOQ9AWe9Lp1BIrC24FY
         n+ZHqonw2wkpCtCpdpFQZvfwfeg4ClRxCVZ/9zsxoKuXLBgB0opWtUdFia+04xhuc+Z5
         41TedPr0J8kuZgyHn4mdId5HO2ZBuA4zNiaIftB2DayWGJ8ekbbgbiAyupxLpJp7pKRN
         ngAYv4ErCHIM/m0BIEpD0tpww6uYkdidSdFFGTVnUmmhLDp9G/Om2n/HCkNASiG1KDd5
         CJuW+OerRJSRXfrOGS7YDYUg0qxt3p0Cj6co3f/1SiZuD03QhQyPVVq89Y6ucMhBf8HS
         hFBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706572682; x=1707177482;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iHUR1QnArqb/KzcPRauFtcmzZ974lUT6wsV0EVNvRMY=;
        b=TbBR/zp5f3VwynrkM6Vc+How4ST2wzeWF5wr5hn71O2vFk3WKAyAGiJ8hMzuUTx3dG
         r4n2rlc1RxKfNB0wuVgBk8zH20COuC2Q1ptmGf0FSt1VdSCwMDpLlgQyZqo3Bsznc8Aq
         79IW+xRTqcRxGlWas/AhUMAZgJdorucFGBct5DtgxK43jouAUNPT5pqAYL8YXbHN0gKg
         FE/8uQMmp/52V/57Nfuo/wwkIawJYBy0ktwfRTx5mW1vExGzFQCnZ8wtRDcq+uEjwjni
         NgqJg59H0BUxeyyhHh2br7CbrUwleLdt/mT1bFhPK1n01bhIjPRC5M3hr+K4+rVG+ND4
         ZptQ==
X-Gm-Message-State: AOJu0YzUS9JbN4Cto4tK7mEq+wpWNCzXL52g5JthpvOOK9/d/HC7o1E0
	KI4FtjOQRXefJ9c1mDVRUjtfhaqLdN1ADmxDa0mCj2ezZLgoWKrx
X-Google-Smtp-Source: AGHT+IESo8pp7/GCsPNbeJLKcFxrXJLEx0yeAitMKAvgf+Pun/ZtGi028JfyKoo2UHuUBo9XqJRccw==
X-Received: by 2002:ad4:5d41:0:b0:681:14ff:3e82 with SMTP id jk1-20020ad45d41000000b0068114ff3e82mr8163678qvb.41.1706572682008;
        Mon, 29 Jan 2024 15:58:02 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCW4nX8l1RiUaDqNwgvQyG6Stbxdi76PYvdMlfy1LNbkN9UwNojCt6lQoEIBUSWoeO1yST2ZR5aoub9PGGMb47XRr2KY4WyYjbscLmjuNXQC16PtJsdOb3pW13GF3AlcGsw11FutOgzzGHqD88ZhpWZEGBbX4ttEnJ5ipR7Mm4E7a5K64IRRvvBVL06De5YDbLdwmHNGLKZHrLk8R7IYs/FVTBkCM29SgVzt6YId6TGpoMPIUr3uUjbHaqTAMJK0EcpbGtrMo1uW/qzBZUvPZ2Fdn2pFdYEInovzliLR/ceEfmHH2ylscSS55cq+nAxT7aPj2aGuOumNs49S7FrlryXs7hTf4G6w3/A8CUy2oaMrf4+9FPCZNGZssmdfYLXTx3lPYgRRFokbv/37uki1eICi1A==
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id 12-20020ad45b8c000000b0068c501d0766sm1310796qvp.41.2024.01.29.15.58.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 15:58:01 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailauth.nyi.internal (Postfix) with ESMTP id 44BD427C0064;
	Mon, 29 Jan 2024 18:58:01 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 29 Jan 2024 18:58:01 -0500
X-ME-Sender: <xms:iDu4ZWwaX3o2FkXMTSRGsDyHo0zbKt_i_p1g2aiy_qSAIhEADoNlCQ>
    <xme:iDu4ZSRkwdehv_WnO-nwCgm8yNogzssPM97ORhoVtk5AlZdIJl4YpOSkYl0lDkc-I
    PgvowaT0N_OfhUBwg>
X-ME-Received: <xmr:iDu4ZYVT4B2buJ4rfmRSAhUeuapq3K4NfOO0Pu9F-6NAT3wlrcYvtFMeQv17Tw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfedthedgudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeegleejiedthedvheeggfejveefjeejkefgveffieeujefhueeigfegueeh
    geeggfenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvg
X-ME-Proxy: <xmx:iDu4Zch5DN14REpoiuQcTsaBs5_jf8th1lTQiOL6SU66nwvNO4Nquw>
    <xmx:iDu4ZYBOXUQXJ3mIOSHcOt9M45qQXDVGXoUUJec8i6Utm1JvEHWVBw>
    <xmx:iDu4ZdIIKM8FGRczj0Zd3O6ZdmVnFGpSRSVW5vhny4bPvKM_iinPSg>
    <xmx:iTu4ZU6bF28b72sAEoelYIphvGsWAbWw1ZrKQHyOGKyhpohRb0FxfA>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Jan 2024 18:58:00 -0500 (EST)
From: Boqun Feng <boqun.feng@gmail.com>
To: linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Josh Triplett <josh@joshtriplett.org>,
	Neeraj Upadhyay <neeraj.iitr10@gmail.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>
Subject: [PATCH 6/8] rcutorture: Suppress rtort_pipe_count warnings until after stalls
Date: Mon, 29 Jan 2024 15:56:39 -0800
Message-ID: <20240129235646.3171983-7-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240129235646.3171983-1-boqun.feng@gmail.com>
References: <20240129235646.3171983-1-boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Paul E. McKenney" <paulmck@kernel.org>

Currently, if rcu_torture_writer() sees fewer than ten grace periods
having elapsed during a call to stutter_wait() that actually waited,
the rtort_pipe_count warning is emitted.  This has worked well for
a long time.  Except that the rcutorture TREE07 scenario now does a
short-term 14-second RCU CPU stall, which can most definitely case
false-positive rtort_pipe_count warnings.

This commit therefore changes rcu_torture_writer() to compute the
full expected holdoff and stall duration, and to refuse to report any
rtort_pipe_count warnings until after all stalls have completed.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/rcu/rcutorture.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 7567ca8e743c..45d6b4c3d199 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -1368,9 +1368,13 @@ rcu_torture_writer(void *arg)
 	struct rcu_torture *rp;
 	struct rcu_torture *old_rp;
 	static DEFINE_TORTURE_RANDOM(rand);
+	unsigned long stallsdone = jiffies;
 	bool stutter_waited;
 	unsigned long ulo[NUM_ACTIVE_RCU_POLL_OLDSTATE];
 
+	// If a new stall test is added, this must be adjusted.
+	if (stall_cpu_holdoff + stall_gp_kthread + stall_cpu)
+		stallsdone += (stall_cpu_holdoff + stall_gp_kthread + stall_cpu + 60) * HZ;
 	VERBOSE_TOROUT_STRING("rcu_torture_writer task started");
 	if (!can_expedite)
 		pr_alert("%s" TORTURE_FLAG
@@ -1576,11 +1580,11 @@ rcu_torture_writer(void *arg)
 		    !atomic_read(&rcu_fwd_cb_nodelay) &&
 		    !cur_ops->slow_gps &&
 		    !torture_must_stop() &&
-		    boot_ended)
+		    boot_ended &&
+		    time_after(jiffies, stallsdone))
 			for (i = 0; i < ARRAY_SIZE(rcu_tortures); i++)
 				if (list_empty(&rcu_tortures[i].rtort_free) &&
-				    rcu_access_pointer(rcu_torture_current) !=
-				    &rcu_tortures[i]) {
+				    rcu_access_pointer(rcu_torture_current) != &rcu_tortures[i]) {
 					tracing_off();
 					show_rcu_gp_kthreads();
 					WARN(1, "%s: rtort_pipe_count: %d\n", __func__, rcu_tortures[i].rtort_pipe_count);
@@ -2441,7 +2445,8 @@ static struct notifier_block rcu_torture_stall_block = {
 
 /*
  * CPU-stall kthread.  It waits as specified by stall_cpu_holdoff, then
- * induces a CPU stall for the time specified by stall_cpu.
+ * induces a CPU stall for the time specified by stall_cpu.  If a new
+ * stall test is added, stallsdone in rcu_torture_writer() must be adjusted.
  */
 static int rcu_torture_stall(void *args)
 {
-- 
2.43.0


