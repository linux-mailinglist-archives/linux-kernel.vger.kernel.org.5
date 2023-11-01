Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECAC07DDF7F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 11:33:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231781AbjKAKdr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 06:33:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjKAKdo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 06:33:44 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60B38DE;
        Wed,  1 Nov 2023 03:33:41 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2c5056059e0so94558821fa.3;
        Wed, 01 Nov 2023 03:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698834819; x=1699439619; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GJ7Pkdq68DdGuC7oYx1WEucucKxc3YExNfOgXseBzwA=;
        b=KBoxk78aF39+rU/vFAasohAunITAHnbplGjQjZwZ6N91QDESpUq2xElQnOdUZtzfSY
         FxEw7ioQuu+qqbGXTKJzsHYZGLhlHx3XOnTWnvLTgrIli517kGcPwrgb4CfjxTLqqlU7
         a97+tnc28tDVIq9u9zWWZNXvCFulg59WcO923y9K38Bm5WHmmkVYUKDBV0GT1Vrlw2Mc
         a1Rcz5FQP+uHwq/3ygIA+9n01mqizsfVnXBUW1TbpHj/JJea6IFsmxu01mx3MQ37dlCf
         djVOk7zQ7mETyUCs4Yv9rkO6bMz+wCpNxOrVxNZyXr+0PlRRnGmHzQD8VyDOfYeuu2vB
         VP2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698834819; x=1699439619;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GJ7Pkdq68DdGuC7oYx1WEucucKxc3YExNfOgXseBzwA=;
        b=JaQIsXiIJ3N4JjJu2jsU0dsqsgXohTORHXMPXGtqJlrMStxFgQe6J03XX41Zuke4yu
         aDjs+C8HzJhRk+FKnFCr0Mpi4Px3BSeiboUWTL/1S/RGW0oIj02T94vpE+vsKaMJ/FZf
         ZCZZu4dE/a6ZzLik0L7wpItRDm+e14NJRJ3+Rc7c8rp4tKk6jPnddn6ecCSi1dLu3cvF
         m8N7rWFN2xmibDGUSUkNJil6gr2+0jw/H4wv3QR53nwkudVhRnQso2HrnVu+SEciaX/D
         kR+hEOQQuQZIs3hWdC58bXW8Nf8k4CkQvKOA6/uCzMBpxSq0DxO8HkatejCqBZHU4y7A
         5few==
X-Gm-Message-State: AOJu0Yzp4YVDP+lM0IFoU4Zyj2teh0jhSf16ous42Iu1qUh3Ji8kpHz7
        mUSUnm3hEYOHd++a/dhNsk0=
X-Google-Smtp-Source: AGHT+IHbSPNRa+AMFlS6/zxPx8fHqxW+UkldgWRWzXhiuHxOScEZt/HEo5iL64EZT79UNX4+yu7C2w==
X-Received: by 2002:a05:6512:401b:b0:509:e5e:232a with SMTP id br27-20020a056512401b00b005090e5e232amr10433720lfb.42.1698834819102;
        Wed, 01 Nov 2023 03:33:39 -0700 (PDT)
Received: from pc636 (host-90-233-220-95.mobileonline.telia.com. [90.233.220.95])
        by smtp.gmail.com with ESMTPSA id be34-20020a056512252200b00507a0098421sm180455lfb.181.2023.11.01.03.33.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Nov 2023 03:33:38 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Wed, 1 Nov 2023 11:33:35 +0100
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        RCU <rcu@vger.kernel.org>,
        Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
        Hillf Danton <hdanton@sina.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH 1/3] rcu: Reduce synchronize_rcu() waiting time
Message-ID: <ZUIpfzEt_rpTAS8T@pc636>
References: <20231025140915.590390-1-urezki@gmail.com>
 <20231025140915.590390-2-urezki@gmail.com>
 <ZTlNogQ_nWUzVJ9M@boqun-archlinux>
 <ZTpk7gvIgdHioL3c@pc636>
 <ZT6ilzH0HQNFLb2Y@boqun-archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZT6ilzH0HQNFLb2Y@boqun-archlinux>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 29, 2023 at 11:21:11AM -0700, Boqun Feng wrote:
> On Thu, Oct 26, 2023 at 03:09:02PM +0200, Uladzislau Rezki wrote:
> [...]
> > > Late to the party, but I kinda wonder whether we can resolve it by:
> > > 
> > > 1) either introduce a separate seglist that only contains callbacks
> > > queued by call_rcu_hurry(), and whenever after an GP and callbacks are
> > > ready, call_rcu_hurry() callbacks will be called first.
> > > 
> > > 2) or make call_rcu_hurry() callbacks always inserted at the head of the
> > > NEXT list instead of the tail, e.g. (untested code):
> > > 
> > > diff --git a/kernel/rcu/rcu_segcblist.c b/kernel/rcu/rcu_segcblist.c
> > > index f71fac422c8f..89a875f8ecc7 100644
> > > --- a/kernel/rcu/rcu_segcblist.c
> > > +++ b/kernel/rcu/rcu_segcblist.c
> > > @@ -338,13 +338,21 @@ bool rcu_segcblist_nextgp(struct rcu_segcblist *rsclp, unsigned long *lp)
> > >   * absolutely not OK for it to ever miss posting a callback.
> > >   */
> > >  void rcu_segcblist_enqueue(struct rcu_segcblist *rsclp,
> > > -			   struct rcu_head *rhp)
> > > +			   struct rcu_head *rhp,
> > > +			   bool is_lazy)
> > >  {
> > >  	rcu_segcblist_inc_len(rsclp);
> > >  	rcu_segcblist_inc_seglen(rsclp, RCU_NEXT_TAIL);
> > > -	rhp->next = NULL;
> > > -	WRITE_ONCE(*rsclp->tails[RCU_NEXT_TAIL], rhp);
> > > -	WRITE_ONCE(rsclp->tails[RCU_NEXT_TAIL], &rhp->next);
> > > +	/* If hurry and the list is not empty, put it in the front */
> > > +	if (!is_lazy && rcu_segcblist_get_seglen(rsclp, RCU_NEXT_TAIL) > 1) {
> > > +		// hurry callback, queued at front
> > > +		rhp->next = READ_ONCE(*rsclp->tails[RCU_NEXT_READY_TAIL]);
> > > +		WRITE_ONCE(*rsclp->tails[RCU_NEXT_READY_TAIL], rhp);
> > > +	} else {
> > > +		rhp->next = NULL;
> > > +		WRITE_ONCE(*rsclp->tails[RCU_NEXT_TAIL], rhp);
> > > +		WRITE_ONCE(rsclp->tails[RCU_NEXT_TAIL], &rhp->next);
> > > +	}
> > >  }
> > >  
> > >  /*
> > > diff --git a/kernel/rcu/rcu_segcblist.h b/kernel/rcu/rcu_segcblist.h
> > > index 4fe877f5f654..459475bb8df9 100644
> > > --- a/kernel/rcu/rcu_segcblist.h
> > > +++ b/kernel/rcu/rcu_segcblist.h
> > > @@ -136,7 +136,8 @@ struct rcu_head *rcu_segcblist_first_cb(struct rcu_segcblist *rsclp);
> > >  struct rcu_head *rcu_segcblist_first_pend_cb(struct rcu_segcblist *rsclp);
> > >  bool rcu_segcblist_nextgp(struct rcu_segcblist *rsclp, unsigned long *lp);
> > >  void rcu_segcblist_enqueue(struct rcu_segcblist *rsclp,
> > > -			   struct rcu_head *rhp);
> > > +			   struct rcu_head *rhp,
> > > +			   bool is_lazy);
> > >  bool rcu_segcblist_entrain(struct rcu_segcblist *rsclp,
> > >  			   struct rcu_head *rhp);
> > >  void rcu_segcblist_extract_done_cbs(struct rcu_segcblist *rsclp,
> > > diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> > > index 20d7a238d675..53adf5ab9c9f 100644
> > > --- a/kernel/rcu/srcutree.c
> > > +++ b/kernel/rcu/srcutree.c
> > > @@ -1241,7 +1241,7 @@ static unsigned long srcu_gp_start_if_needed(struct srcu_struct *ssp,
> > >  		sdp = raw_cpu_ptr(ssp->sda);
> > >  	spin_lock_irqsave_sdp_contention(sdp, &flags);
> > >  	if (rhp)
> > > -		rcu_segcblist_enqueue(&sdp->srcu_cblist, rhp);
> > > +		rcu_segcblist_enqueue(&sdp->srcu_cblist, rhp, true);
> > >  	rcu_segcblist_advance(&sdp->srcu_cblist,
> > >  			      rcu_seq_current(&ssp->srcu_sup->srcu_gp_seq));
> > >  	s = rcu_seq_snap(&ssp->srcu_sup->srcu_gp_seq);
> > > diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
> > > index 8d65f7d576a3..7dec7c68f88f 100644
> > > --- a/kernel/rcu/tasks.h
> > > +++ b/kernel/rcu/tasks.h
> > > @@ -362,7 +362,7 @@ static void call_rcu_tasks_generic(struct rcu_head *rhp, rcu_callback_t func,
> > >  	}
> > >  	if (needwake)
> > >  		rtpcp->urgent_gp = 3;
> > > -	rcu_segcblist_enqueue(&rtpcp->cblist, rhp);
> > > +	rcu_segcblist_enqueue(&rtpcp->cblist, rhp, true);
> > >  	raw_spin_unlock_irqrestore_rcu_node(rtpcp, flags);
> > >  	if (unlikely(needadjust)) {
> > >  		raw_spin_lock_irqsave(&rtp->cbs_gbl_lock, flags);
> > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > index cb1caefa8bd0..e05cbff40dc7 100644
> > > --- a/kernel/rcu/tree.c
> > > +++ b/kernel/rcu/tree.c
> > > @@ -2670,7 +2670,7 @@ __call_rcu_common(struct rcu_head *head, rcu_callback_t func, bool lazy_in)
> > >  	if (rcu_nocb_try_bypass(rdp, head, &was_alldone, flags, lazy))
> > >  		return; // Enqueued onto ->nocb_bypass, so just leave.
> > >  	// If no-CBs CPU gets here, rcu_nocb_try_bypass() acquired ->nocb_lock.
> > > -	rcu_segcblist_enqueue(&rdp->cblist, head);
> > > +	rcu_segcblist_enqueue(&rdp->cblist, head, lazy_in);
> > >  	if (__is_kvfree_rcu_offset((unsigned long)func))
> > >  		trace_rcu_kvfree_callback(rcu_state.name, head,
> > >  					 (unsigned long)func,
> > > 
> 
> Surprisingly, this survives from a whole rcutorture run ;-)
> 
> > > Sure, there may be some corner cases I'm missing, but I think overall
> > > this is better than (sorta) duplicating the logic of seglist (the llist
> > > in sr_normal_state) or the logic of wake_rcu_gp()
> > > (synchronize_rcu_normal).
> > > 
> > > Anyway, these are just if-you-have-time-to-try options ;-)
> > > 
> > Hm.. You still mix callbacks and there is a dependency in order
> > of execution. The callback process time also might be varied from
> > one callback to another.
> > 
> > If you have many *_hurry() calls we end in the same situation. Apart
> 
> I plan to resolve that by only puting a call_rcu_hurry(wakeme_after_gp)
> in the front of the list.
> 
> > of that we also have !CONFIG_RCU_NOCB_CPU path that is also covered
> > by the patch that is in question.
> 
> I don't see why the above approach doesn't work for
> !CONFIG_RCU_NOCB_CPU, but I maybe miss something here.
> 
Basically it does not work, because you do not fix the mixing "issue".
I have been working on it and we agreed to separate it. Because it is
just makes sense. The reason and the problem i see, i described in the
commit message of v2.

>
> Do you have a benchmark I can try out to see if my diff can achieve the
> similar result? Thanks!
> 
There is no a good benchmark. But you can write it for sure. I tested
three scenarios:

- Run a camera app on our Android devices. Measuring app launch in
  milliseconds;
- Doing synchronize_rcu() and kfree(ptr) simultaneously by 10K/etc
  workers. It is important test case because we have a fallback to
  this scenario for our kvfree_rcu_mightslepp() API.
- I had a look at time delta of loading 100 kernel modules.

That were my main test cases.

--
Uladzislau Rezki
