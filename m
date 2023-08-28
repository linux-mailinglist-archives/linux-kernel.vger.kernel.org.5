Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EFF378B210
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 15:35:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230423AbjH1NfA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 09:35:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231764AbjH1Nen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 09:34:43 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE14AE48
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 06:34:07 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id e9e14a558f8ab-34ca1aadcccso11089335ab.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 06:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1693229629; x=1693834429;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gdfwWZuHfmu4XVauJdMgU5vlwPFHnOTjqbMeUAVj4NA=;
        b=cunLBsMuV99MuZIqzzB3pvXS5IVO9fnMv09aXOWv62jRJVQ4OTjLxV4A7A8UYTqJyK
         7PlpuRfKd9Q1/8O7A4qKZD5FOzUqNLAqIyTBGWygawTQHJ/3n2OZpt7YxNP84fc5IX5n
         GSmv1es2mR3cTpDSGKOGmlzmAfube0w+g1/38=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693229629; x=1693834429;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gdfwWZuHfmu4XVauJdMgU5vlwPFHnOTjqbMeUAVj4NA=;
        b=K8Uw9AGsyCWf87j/umvmEunoDUOeWUjvT11leGGHfiUy2PiaByiBorOmTS/vkHLXfA
         EwWfjJQz+OS6LzQX++L01N2chkY2LKkjhKFpcR/tTn+zA4G5c2alzoVf3dN/Imw0mnyv
         tnhNe+4Ty1K56l2Uv0M6DU6GjHx9vPRqVpH4tSf3Aoz8qYOaqt2Ye1TBvvVYHsHlUs4E
         OSd0tbaSYXbJUqGc5qrpR8BRNp2vfI+81VA4QJpofYRvRlAK8Wz0Y0GoIRmmW1glAPhG
         3HKzrFMUp39qKR86vgMuoJMncztU37sjttIBleQIcMPiuO0C20vyjfNDUTyjA0/28kvq
         V9PA==
X-Gm-Message-State: AOJu0YyFsBOPZVIQnYr7ic7oPrPmxR2QMIlOOIqVpSkIsVKYmuAWIjrQ
        H76BN8yPL6D+vZuovL7hGND14A==
X-Google-Smtp-Source: AGHT+IF5+VfM0BVFTCOXKLdn6eWCMQ6wX7z/wEgNm8jXMcm1bcG9fXtJVfR5TJ+0nSKOdMNnfxE9Yg==
X-Received: by 2002:a5e:cb07:0:b0:785:5917:a35f with SMTP id p7-20020a5ecb07000000b007855917a35fmr16961160iom.8.1693229629617;
        Mon, 28 Aug 2023 06:33:49 -0700 (PDT)
Received: from localhost (156.190.123.34.bc.googleusercontent.com. [34.123.190.156])
        by smtp.gmail.com with ESMTPSA id eh25-20020a056638299900b00433dd6c78b0sm2445541jab.97.2023.08.28.06.33.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 06:33:48 -0700 (PDT)
Date:   Mon, 28 Aug 2023 13:33:48 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Huacai Chen <chenhuacai@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Z qiang <qiang.zhang1211@gmail.com>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        John Stultz <jstultz@google.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Binbin Zhou <zhoubinbin@loongson.cn>
Subject: Re: [PATCH V4 2/2] rcu: Update jiffies in rcu_cpu_stall_reset()
Message-ID: <20230828133348.GA1553000@google.com>
References: <CAAhV-H7uXA=r-w1nN7sBpRTba3LjjZs+wasJfGo7VZ6D9eMBAw@mail.gmail.com>
 <8792da20-a58e-4cc0-b3d2-231d5ade2242@paulmck-laptop>
 <CAAhV-H5BNPX8Eo3Xdy-jcYY97=xazGU+VVqoDy7qEH+VpVWFJA@mail.gmail.com>
 <24e34f50-32d2-4b67-8ec0-1034c984d035@paulmck-laptop>
 <CAAhV-H5pfDG_tsRDL4dUYykaQ1ZwQYRDrQccpULBM5+kF4i2fA@mail.gmail.com>
 <20230825232807.GA97898@google.com>
 <CAEXW_YSock304V471X_A7WrxCWtHJGx3APmSy0k7Lc0o69D9Hg@mail.gmail.com>
 <CAAhV-H6PM_KZj4_h-SdJAaseMDK2nMqqJWL8fWHhL4vUA50bQg@mail.gmail.com>
 <CAEXW_YS5dVVOQvO6tWwF7mrgtHiYgVKP_TAipzBNiaFqWDzdeQ@mail.gmail.com>
 <2681134d-cc88-49a0-a1bc-4ec0816288f6@paulmck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2681134d-cc88-49a0-a1bc-4ec0816288f6@paulmck-laptop>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 28, 2023 at 03:47:12AM -0700, Paul E. McKenney wrote:
> On Sun, Aug 27, 2023 at 06:11:40PM -0400, Joel Fernandes wrote:
> > On Sun, Aug 27, 2023 at 1:51 AM Huacai Chen <chenhuacai@kernel.org> wrote:
> > [..]
> > > > > > > The only way I know of to avoid these sorts of false positives is for
> > > > > > > the user to manually suppress all timeouts (perhaps using a kernel-boot
> > > > > > > parameter for your early-boot case), do the gdb work, and then unsuppress
> > > > > > > all stalls.  Even that won't work for networking, because the other
> > > > > > > system's clock will be running throughout.
> > > > > > >
> > > > > > > In other words, from what I know now, there is no perfect solution.
> > > > > > > Therefore, there are sharp limits to the complexity of any solution that
> > > > > > > I will be willing to accept.
> > > > > > I think the simplest solution is (I hope Joel will not angry):
> > > > >
> > > > > Not angry at all, just want to help. ;-). The problem is the 300*HZ solution
> > > > > will also effect the VM workloads which also do a similar reset.  Allow me few
> > > > > days to see if I can take a shot at fixing it slightly differently. I am
> > > > > trying Paul's idea of setting jiffies at a later time. I think it is doable.
> > > > > I think the advantage of doing this is it will make stall detection more
> > > > > robust in this face of these gaps in jiffie update. And that solution does
> > > > > not even need us to rely on ktime (and all the issues that come with that).
> > > > >
> > > >
> > > > I wrote a patch similar to Paul's idea and sent it out for review, the
> > > > advantage being it purely is based on jiffies. Could you try it out
> > > > and let me know?
> > > If you can cc my gmail <chenhuacai@gmail.com>, that could be better.
> > 
> > Sure, will do.
> > 
> > > I have read your patch, maybe the counter (nr_fqs_jiffies_stall)
> > > should be atomic_t and we should use atomic operation to decrement its
> > > value. Because rcu_gp_fqs() can be run concurrently, and we may miss
> > > the (nr_fqs == 1) condition.
> > 
> > I don't think so. There is only 1 place where RMW operation happens
> > and rcu_gp_fqs() is called only from the GP kthread. So a concurrent
> > RMW (and hence a lost update) is not possible.
> 
> Huacai, is your concern that the gdb user might have created a script
> (for example, printing a variable or two, then automatically continuing),
> so that breakpoints could happen in quick successsion, such that the
> second breakpoint might run concurrently with rcu_gp_fqs()?
> 
> If this can really happen, the point that Joel makes is a good one, namely
> that rcu_gp_fqs() is single-threaded and (absent rcutorture) runs only
> once every few jiffies.  And gdb breakpoints, even with scripting, should
> also be rather rare.  So if this is an issue, a global lock should do the
> trick, perhaps even one of the existing locks in the rcu_state structure.
> The result should then be just as performant/scalable and a lot simpler
> than use of atomics.

Thanks Paul and Huacai, also I was thinking in the event of such concurrent
breakpoint stalling jiffies updates but GP thread / rcu_gp_fqs() chugging
along, we could also make the patch more robust for such a situation as
follows (diff on top of previous patch [1]). Thoughts?

Also if someone sets a breakpoint right after the "nr_fqs == 1" check, then
they are kind of asking for it anyway since the GP kthread getting
stalled is an actual reason for RCU stalls (infact rcutorture has a test mode
for it even :P) and as such the false-positive may not be that false. ;-)

Btw apologies for forgetting to CC Thomas on [1] since he is involved in the
timekeeping discussions. I relied on "git send-email" to populate the Cc list
but did not add Cc: to the patch.

[1] https://lore.kernel.org/all/20230827025349.4161262-1-joel@joelfernandes.org/

---8<-----------------------

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 9273f2318ea1..ffb165a2ef41 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1559,13 +1559,15 @@ static void rcu_gp_fqs(bool first_time)
 	WRITE_ONCE(rcu_state.n_force_qs, rcu_state.n_force_qs + 1);
 
 	WARN_ON_ONCE(nr_fqs > 3);
-	if (nr_fqs) {
+	/* Only countdown nr_fqs for stall purposes if jiffies moves. */
+	if (nr_fqs && jiffies != READ_ONCE(rcu_state.jiffies_last_fqs)) {
 		if (nr_fqs == 1) {
 			WRITE_ONCE(rcu_state.jiffies_stall,
 				   jiffies + rcu_jiffies_till_stall_check());
 		}
 		WRITE_ONCE(rcu_state.nr_fqs_jiffies_stall, --nr_fqs);
 	}
+	WRITE_ONCE(rcu_state.jiffies_last_fqs, jiffies);
 
 	if (first_time) {
 		/* Collect dyntick-idle snapshots. */
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index e9821a8422db..72128e348fa1 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -386,6 +386,8 @@ struct rcu_state {
 						/*  in jiffies. */
 	unsigned long jiffies_stall;		/* Time at which to check */
 						/*  for CPU stalls. */
+	unsigned long jiffies_last_fqs;		/* jiffies value at last FQS.
+						   to confirm jiffies moves. */
 	int nr_fqs_jiffies_stall;		/* Number of fqs loops after
 						 * which read jiffies and set
 						 * jiffies_stall. Stall
diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index a2fa6b22e248..0ddd22afbc3a 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -160,6 +160,7 @@ void rcu_cpu_stall_reset(void)
 {
 	WRITE_ONCE(rcu_state.nr_fqs_jiffies_stall, 3);
 	WRITE_ONCE(rcu_state.jiffies_stall, ULONG_MAX);
+	WRITE_ONCE(rcu_state.jiffies_last_fqs, 0);
 }
 
 //////////////////////////////////////////////////////////////////////////////
@@ -177,6 +178,7 @@ static void record_gp_stall_check_time(void)
 	smp_mb(); // ->gp_start before ->jiffies_stall and caller's ->gp_seq.
 	WRITE_ONCE(rcu_state.nr_fqs_jiffies_stall, 0);
 	WRITE_ONCE(rcu_state.jiffies_stall, j + j1);
+	WRITE_ONCE(rcu_state.jiffies_last_fqs, 0);
 	rcu_state.jiffies_resched = j + j1 / 2;
 	rcu_state.n_force_qs_gpstart = READ_ONCE(rcu_state.n_force_qs);
 }
