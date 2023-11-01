Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9980D7DE335
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 16:36:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343615AbjKAPfR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 11:35:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234336AbjKAPfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 11:35:13 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36C6510C;
        Wed,  1 Nov 2023 08:35:10 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-507e85ebf50so9579596e87.1;
        Wed, 01 Nov 2023 08:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698852908; x=1699457708; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aIIZwA6A6ZSGwUkyR5SMMDUjncuESjzRULHo0mOS0I8=;
        b=jYpCGsUszNJkVrltilXQ60RDQe2OB4zz3WqE5Qlv3kaFV10XQoZzebkZO+BrAtCw7c
         8arMbYDBufXfk2pQz+oDsh187I4x86uz0n5XfcbYdjujwiyeanRd89/zoMmK9XdnZ7Ta
         MI6FFJJBBgrMSZtbLHTf6fuwjkAmyPwG+RWE4DESyrXA8s1S+2lHoMBXT9eJwxgLBRB9
         poe556jJhJYbeq+YTUhnmavQxCQxNoKaZWuDioMECNkOEFUtSHYPCIocQg0C+8Jrq++A
         4iJC2WtXpu1cEmL3EPiaUyz+Xjae0xrfDPLcJ7pBGBunVZ5aTlx8Up943M8Lg2mmvOqW
         tSqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698852908; x=1699457708;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aIIZwA6A6ZSGwUkyR5SMMDUjncuESjzRULHo0mOS0I8=;
        b=nqU69QLuz1jgexkd2zy4zAz2gxcxrlFSnwqvHRkHpOxO96b4LczTOwZ+/tv4D4TD04
         fUoV0mtoajZ+G3ZyuvWbNbNMEYK/jWEq82rFo9zCh9prWMCbffe+qluNA+OQsDEaF6Qz
         aXWiQl0Ge9vA3B1t0odV4hdOR5J+LxFgEu3MOrf9b4uc6tqdzoXRokZU2nFeME7BuRQH
         bLQ7cYCdM8ndSM0koWgr9gLm0X/38GEKPc6BYyO3on1JeOvORK6ZJiYpPiby47mKzGFt
         bPfrIpJhyzTraWt3+eteRgw2be3USjy2CLjXsDSqP8m/Q66ZnBcjqLQLsn915pY1zMk/
         gbUQ==
X-Gm-Message-State: AOJu0YyX0kLgxArPVpXi3igNe0ynvwgL+ybvFfC2903u5asHpl/KZL/o
        hHF90DQrRqt1UDH071arjE4gth6b+MenVA==
X-Google-Smtp-Source: AGHT+IG2Dm8xQOiLB5t95uT9spzoLYlJChARyWhp/+raeoD1SQt4EFnBKWlq8dcFUxecEM4lv67SjA==
X-Received: by 2002:a05:6512:3b23:b0:4fb:7559:aea3 with SMTP id f35-20020a0565123b2300b004fb7559aea3mr16498907lfv.39.1698852907876;
        Wed, 01 Nov 2023 08:35:07 -0700 (PDT)
Received: from pc636 (host-90-233-220-95.mobileonline.telia.com. [90.233.220.95])
        by smtp.gmail.com with ESMTPSA id g28-20020a0565123b9c00b00507aa6ab0ecsm241191lfv.248.2023.11.01.08.35.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Nov 2023 08:35:07 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date:   Wed, 1 Nov 2023 16:35:05 +0100
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     Boqun Feng <boqun.feng@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        RCU <rcu@vger.kernel.org>,
        Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
        Hillf Danton <hdanton@sina.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH 1/3] rcu: Reduce synchronize_rcu() waiting time
Message-ID: <ZUJwKXcjK0064zkb@pc636>
References: <20231025140915.590390-1-urezki@gmail.com>
 <20231025140915.590390-2-urezki@gmail.com>
 <ZTlNogQ_nWUzVJ9M@boqun-archlinux>
 <ZTpk7gvIgdHioL3c@pc636>
 <ZT6ilzH0HQNFLb2Y@boqun-archlinux>
 <ZUIpfzEt_rpTAS8T@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZUIpfzEt_rpTAS8T@pc636>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 01, 2023 at 11:33:35AM +0100, Uladzislau Rezki wrote:
> On Sun, Oct 29, 2023 at 11:21:11AM -0700, Boqun Feng wrote:
> > On Thu, Oct 26, 2023 at 03:09:02PM +0200, Uladzislau Rezki wrote:
> > [...]
> > > > Late to the party, but I kinda wonder whether we can resolve it by:
> > > > 
> > > > 1) either introduce a separate seglist that only contains callbacks
> > > > queued by call_rcu_hurry(), and whenever after an GP and callbacks are
> > > > ready, call_rcu_hurry() callbacks will be called first.
> > > > 
> > > > 2) or make call_rcu_hurry() callbacks always inserted at the head of the
> > > > NEXT list instead of the tail, e.g. (untested code):
> > > > 
> > > > diff --git a/kernel/rcu/rcu_segcblist.c b/kernel/rcu/rcu_segcblist.c
> > > > index f71fac422c8f..89a875f8ecc7 100644
> > > > --- a/kernel/rcu/rcu_segcblist.c
> > > > +++ b/kernel/rcu/rcu_segcblist.c
> > > > @@ -338,13 +338,21 @@ bool rcu_segcblist_nextgp(struct rcu_segcblist *rsclp, unsigned long *lp)
> > > >   * absolutely not OK for it to ever miss posting a callback.
> > > >   */
> > > >  void rcu_segcblist_enqueue(struct rcu_segcblist *rsclp,
> > > > -			   struct rcu_head *rhp)
> > > > +			   struct rcu_head *rhp,
> > > > +			   bool is_lazy)
> > > >  {
> > > >  	rcu_segcblist_inc_len(rsclp);
> > > >  	rcu_segcblist_inc_seglen(rsclp, RCU_NEXT_TAIL);
> > > > -	rhp->next = NULL;
> > > > -	WRITE_ONCE(*rsclp->tails[RCU_NEXT_TAIL], rhp);
> > > > -	WRITE_ONCE(rsclp->tails[RCU_NEXT_TAIL], &rhp->next);
> > > > +	/* If hurry and the list is not empty, put it in the front */
> > > > +	if (!is_lazy && rcu_segcblist_get_seglen(rsclp, RCU_NEXT_TAIL) > 1) {
> > > > +		// hurry callback, queued at front
> > > > +		rhp->next = READ_ONCE(*rsclp->tails[RCU_NEXT_READY_TAIL]);
> > > > +		WRITE_ONCE(*rsclp->tails[RCU_NEXT_READY_TAIL], rhp);
> > > > +	} else {
> > > > +		rhp->next = NULL;
> > > > +		WRITE_ONCE(*rsclp->tails[RCU_NEXT_TAIL], rhp);
> > > > +		WRITE_ONCE(rsclp->tails[RCU_NEXT_TAIL], &rhp->next);
> > > > +	}
> > > >  }
> > > >  
> > > >  /*
> > > > diff --git a/kernel/rcu/rcu_segcblist.h b/kernel/rcu/rcu_segcblist.h
> > > > index 4fe877f5f654..459475bb8df9 100644
> > > > --- a/kernel/rcu/rcu_segcblist.h
> > > > +++ b/kernel/rcu/rcu_segcblist.h
> > > > @@ -136,7 +136,8 @@ struct rcu_head *rcu_segcblist_first_cb(struct rcu_segcblist *rsclp);
> > > >  struct rcu_head *rcu_segcblist_first_pend_cb(struct rcu_segcblist *rsclp);
> > > >  bool rcu_segcblist_nextgp(struct rcu_segcblist *rsclp, unsigned long *lp);
> > > >  void rcu_segcblist_enqueue(struct rcu_segcblist *rsclp,
> > > > -			   struct rcu_head *rhp);
> > > > +			   struct rcu_head *rhp,
> > > > +			   bool is_lazy);
> > > >  bool rcu_segcblist_entrain(struct rcu_segcblist *rsclp,
> > > >  			   struct rcu_head *rhp);
> > > >  void rcu_segcblist_extract_done_cbs(struct rcu_segcblist *rsclp,
> > > > diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> > > > index 20d7a238d675..53adf5ab9c9f 100644
> > > > --- a/kernel/rcu/srcutree.c
> > > > +++ b/kernel/rcu/srcutree.c
> > > > @@ -1241,7 +1241,7 @@ static unsigned long srcu_gp_start_if_needed(struct srcu_struct *ssp,
> > > >  		sdp = raw_cpu_ptr(ssp->sda);
> > > >  	spin_lock_irqsave_sdp_contention(sdp, &flags);
> > > >  	if (rhp)
> > > > -		rcu_segcblist_enqueue(&sdp->srcu_cblist, rhp);
> > > > +		rcu_segcblist_enqueue(&sdp->srcu_cblist, rhp, true);
> > > >  	rcu_segcblist_advance(&sdp->srcu_cblist,
> > > >  			      rcu_seq_current(&ssp->srcu_sup->srcu_gp_seq));
> > > >  	s = rcu_seq_snap(&ssp->srcu_sup->srcu_gp_seq);
> > > > diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
> > > > index 8d65f7d576a3..7dec7c68f88f 100644
> > > > --- a/kernel/rcu/tasks.h
> > > > +++ b/kernel/rcu/tasks.h
> > > > @@ -362,7 +362,7 @@ static void call_rcu_tasks_generic(struct rcu_head *rhp, rcu_callback_t func,
> > > >  	}
> > > >  	if (needwake)
> > > >  		rtpcp->urgent_gp = 3;
> > > > -	rcu_segcblist_enqueue(&rtpcp->cblist, rhp);
> > > > +	rcu_segcblist_enqueue(&rtpcp->cblist, rhp, true);
> > > >  	raw_spin_unlock_irqrestore_rcu_node(rtpcp, flags);
> > > >  	if (unlikely(needadjust)) {
> > > >  		raw_spin_lock_irqsave(&rtp->cbs_gbl_lock, flags);
> > > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > > > index cb1caefa8bd0..e05cbff40dc7 100644
> > > > --- a/kernel/rcu/tree.c
> > > > +++ b/kernel/rcu/tree.c
> > > > @@ -2670,7 +2670,7 @@ __call_rcu_common(struct rcu_head *head, rcu_callback_t func, bool lazy_in)
> > > >  	if (rcu_nocb_try_bypass(rdp, head, &was_alldone, flags, lazy))
> > > >  		return; // Enqueued onto ->nocb_bypass, so just leave.
> > > >  	// If no-CBs CPU gets here, rcu_nocb_try_bypass() acquired ->nocb_lock.
> > > > -	rcu_segcblist_enqueue(&rdp->cblist, head);
> > > > +	rcu_segcblist_enqueue(&rdp->cblist, head, lazy_in);
> > > >  	if (__is_kvfree_rcu_offset((unsigned long)func))
> > > >  		trace_rcu_kvfree_callback(rcu_state.name, head,
> > > >  					 (unsigned long)func,
> > > > 
> > 
> > Surprisingly, this survives from a whole rcutorture run ;-)
> > 
> > > > Sure, there may be some corner cases I'm missing, but I think overall
> > > > this is better than (sorta) duplicating the logic of seglist (the llist
> > > > in sr_normal_state) or the logic of wake_rcu_gp()
> > > > (synchronize_rcu_normal).
> > > > 
> > > > Anyway, these are just if-you-have-time-to-try options ;-)
> > > > 
> > > Hm.. You still mix callbacks and there is a dependency in order
> > > of execution. The callback process time also might be varied from
> > > one callback to another.
> > > 
> > > If you have many *_hurry() calls we end in the same situation. Apart
> > 
> > I plan to resolve that by only puting a call_rcu_hurry(wakeme_after_gp)
> > in the front of the list.
> > 
> > > of that we also have !CONFIG_RCU_NOCB_CPU path that is also covered
> > > by the patch that is in question.
> > 
> > I don't see why the above approach doesn't work for
> > !CONFIG_RCU_NOCB_CPU, but I maybe miss something here.
> > 
> Basically it does not work, because you do not fix the mixing "issue".
> I have been working on it and we agreed to separate it. Because it is
> just makes sense. The reason and the problem i see, i described in the
> commit message of v2.
> 
> >
> > Do you have a benchmark I can try out to see if my diff can achieve the
> > similar result? Thanks!
> > 
> There is no a good benchmark. But you can write it for sure. I tested
> three scenarios:
> 
> - Run a camera app on our Android devices. Measuring app launch in
>   milliseconds;
> - Doing synchronize_rcu() and kfree(ptr) simultaneously by 10K/etc
>   workers. It is important test case because we have a fallback to
>   this scenario for our kvfree_rcu_mightslepp() API.
> - I had a look at time delta of loading 100 kernel modules.
> 
> That were my main test cases.
> 
I will provide the patches and test steps, so you can try on.
Tomorrow i will send it!

--
Uladzislau Rezki
