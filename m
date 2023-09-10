Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AED91799C87
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Sep 2023 06:09:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345374AbjIJEJd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Sep 2023 00:09:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232538AbjIJEJb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Sep 2023 00:09:31 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C7111A5
        for <linux-kernel@vger.kernel.org>; Sat,  9 Sep 2023 21:09:25 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id d75a77b69052e-41206fd9717so22692841cf.3
        for <linux-kernel@vger.kernel.org>; Sat, 09 Sep 2023 21:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1694318964; x=1694923764; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZkRZLEJK4Dw7pZOYiPMmTawxS/A6O7ErhDLwZB01zqQ=;
        b=dmckHSTDvaz36ffxMDyzwXfNjSuBMZtkPIbPtQ+cgxcmLyOFe96H3YkKM5xA1PSubZ
         VSGJn+kBRfceFVI4If9oobbD3ONMkXzb8VOa3I+nidS93R2NYZsTCvxE3ukhxm6JdZg9
         ZVCNZo51j9+6xQazWhYxt75o3j6qijFUjJIKo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694318964; x=1694923764;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZkRZLEJK4Dw7pZOYiPMmTawxS/A6O7ErhDLwZB01zqQ=;
        b=r2hwg+05/V8BnOf4CrX+lcqOqO/M/okpditkWLvrjfyAJZE9esUyx/jEtfe7IxwDAk
         zFhRc/LUH+zHlDFq484oReCmsiHOPImTPdFAI99DuJDdT9EZIPU7J0ylzeDd3WMomczl
         K6alLqpAj3w5ebFPcLoeU3u0QX3UlHyz55KmqDKu6TgQorI6adAMYJyP5xI05Y8V3kM2
         oahcwTSIhmnbwEkbiYZP6XKXJDN/O57AEfsI+6K5CQ7/A/mMHnhjFu3+gCoIFhQvOKTM
         r/Vv2iokgTVJUMnQYkFAeojNM5hhrVykwHPqr0K7Z8bhm+wyUp1VE/Gr75ZhD6Xx4Ofv
         Rb+g==
X-Gm-Message-State: AOJu0YxboHJj/vuyV5NcxUJnIS+X0CBf+HX9g7EOA66oYFp5m2wuUfos
        YbX1FraywQr6KRhb/Ck0mWtW2A==
X-Google-Smtp-Source: AGHT+IHFXrsdD8XDk4Y1FBqgfo9q1OAiUJca62IOc/9tZwFu57lGE44pZpvL+KmqHgzBojHBuHwLfg==
X-Received: by 2002:a05:622a:cf:b0:412:b89b:15f7 with SMTP id p15-20020a05622a00cf00b00412b89b15f7mr8726426qtw.41.1694318964599;
        Sat, 09 Sep 2023 21:09:24 -0700 (PDT)
Received: from localhost (c-98-249-43-138.hsd1.va.comcast.net. [98.249.43.138])
        by smtp.gmail.com with ESMTPSA id dd4-20020ad45804000000b00655d6d31470sm1077366qvb.43.2023.09.09.21.09.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Sep 2023 21:09:23 -0700 (PDT)
Date:   Sun, 10 Sep 2023 00:09:23 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, rcu <rcu@vger.kernel.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>
Subject: Re: [PATCH 04/10] rcu/nocb: Remove needless full barrier after
 callback advancing
Message-ID: <20230910040923.GA762577@google.com>
References: <20230908203603.5865-1-frederic@kernel.org>
 <20230908203603.5865-5-frederic@kernel.org>
 <20230909043125.GA3920383@google.com>
 <ZPy3-MS7uOJfmJhs@boqun-archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZPy3-MS7uOJfmJhs@boqun-archlinux>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 09, 2023 at 11:22:48AM -0700, Boqun Feng wrote:
> On Sat, Sep 09, 2023 at 04:31:25AM +0000, Joel Fernandes wrote:
> > On Fri, Sep 08, 2023 at 10:35:57PM +0200, Frederic Weisbecker wrote:
> > > A full barrier is issued from nocb_gp_wait() upon callbacks advancing
> > > to order grace period completion with callbacks execution.
> > > 
> > > However these two events are already ordered by the
> > > smp_mb__after_unlock_lock() barrier within the call to
> > > raw_spin_lock_rcu_node() that is necessary for callbacks advancing to
> > > happen.
> > > 
> > > The following litmus test shows the kind of guarantee that this barrier
> > > provides:
> > > 
> > > 	C smp_mb__after_unlock_lock
> > > 
> > > 	{}
> > > 
> > > 	// rcu_gp_cleanup()
> > > 	P0(spinlock_t *rnp_lock, int *gpnum)
> > > 	{
> > > 		// Grace period cleanup increase gp sequence number
> > > 		spin_lock(rnp_lock);
> > > 		WRITE_ONCE(*gpnum, 1);
> > > 		spin_unlock(rnp_lock);
> > > 	}
> > > 
> > > 	// nocb_gp_wait()
> > > 	P1(spinlock_t *rnp_lock, spinlock_t *nocb_lock, int *gpnum, int *cb_ready)
> > > 	{
> > > 		int r1;
> > > 
> > > 		// Call rcu_advance_cbs() from nocb_gp_wait()
> > > 		spin_lock(nocb_lock);
> > > 		spin_lock(rnp_lock);
> > > 		smp_mb__after_unlock_lock();
> > > 		r1 = READ_ONCE(*gpnum);
> > > 		WRITE_ONCE(*cb_ready, 1);
> > > 		spin_unlock(rnp_lock);
> > > 		spin_unlock(nocb_lock);
> > > 	}
> > > 
> > > 	// nocb_cb_wait()
> > > 	P2(spinlock_t *nocb_lock, int *cb_ready, int *cb_executed)
> > > 	{
> > > 		int r2;
> > > 
> > > 		// rcu_do_batch() -> rcu_segcblist_extract_done_cbs()
> > > 		spin_lock(nocb_lock);
> > > 		r2 = READ_ONCE(*cb_ready);
> > > 		spin_unlock(nocb_lock);
> > > 
> > > 		// Actual callback execution
> > > 		WRITE_ONCE(*cb_executed, 1);
> > 
> > So related to this something in the docs caught my attention under "Callback
> > Invocation" [1]
> > 
> > <quote>
> > However, if the callback function communicates to other CPUs, for example,
> > doing a wakeup, then it is that function's responsibility to maintain
> > ordering. For example, if the callback function wakes up a task that runs on
> > some other CPU, proper ordering must in place in both the callback function
> > and the task being awakened. To see why this is important, consider the top
> > half of the grace-period cleanup diagram. The callback might be running on a
> > CPU corresponding to the leftmost leaf rcu_node structure, and awaken a task
> > that is to run on a CPU corresponding to the rightmost leaf rcu_node
> > structure, and the grace-period kernel thread might not yet have reached the
> > rightmost leaf. In this case, the grace period's memory ordering might not
> > yet have reached that CPU, so again the callback function and the awakened
> > task must supply proper ordering.
> > </quote>
> > 
> > I believe this text is for non-nocb but if we apply that to the nocb case,
> > lets see what happens.
> > 
> > In the litmus, he rcu_advance_cbs() happened on P1, however the callback is
> > executing on P2. That sounds very similar to the non-nocb world described in
> > the text where a callback tries to wake something up on a different CPU and
> > needs to take care of all the ordering.
> > 
> > So unless I'm missing something (quite possible), P2 must see the update to
> > gpnum as well. However, per your limus test, the only thing P2  does is
> > acquire the nocb_lock. I don't see how it is guaranteed to see gpnum == 1.
> 
> Because P1 writes cb_ready under nocb_lock, and P2 reads cb_ready under
> nocb_lock as well and if P2 read P1's write, then we know the serialized
> order of locking is P1 first (i.e. the spin_lock(nocb_lock) on P2 reads
> from the spin_unlock(nocb_lock) on P1), in other words:
> 
> (fact #1)
> 
> 	unlock(nocb_lock) // on P1
> 	->rfe
> 	lock(nocb_lock) // on P2
> 
> so if P1 reads P0's write on gpnum
> 
> (assumption #1)
> 
> 	W(gpnum)=1 // on P0
> 	->rfe
> 	R(gpnum)=1 // on P1
> 
> and we have
> 
> (fact #2)
> 
> 	R(gpnum)=1 // on P1
> 	->(po; [UL])
> 	unlock(nocb_lock) // on P1
> 
> combine them you get
> 
> 	W(gpnum)=1 // on P0
> 	->rfe           // fact #1
> 	->(po; [UL])    // fact #2
> 	->rfe           // assumption #1
> 	lock(nocb_lock) // on P2
> 	->([LKR]; po)
> 	M // any access on P2 after spin_lock(nocb_lock);
> 
> so
> 	W(gpnum)=1 // on P0
> 	->rfe ->po-unlock-lock-po
> 	M // on P2
> 
> and po-unlock-lock-po is A-culum, hence "->rfe ->po-unlock-lock-po" or
> "rfe; po-unlock-lock-po" is culum-fence, hence it's a ->prop, which
> means the write of gpnum on P0 propagates to P2 before any memory
> accesses after spin_lock(nocb_lock)?

You and Frederic are right. I confirmed this by running herd7 as well.

Also he adds a ->co between P2 and P3, so that's why the
smp_mb__after_lock_unlock() helps to keep the propogation intact. Its pretty
much the R-pattern extended across 4 CPUs.

We should probably document these in the RCU memory ordering docs.

thanks,

 - Joel

