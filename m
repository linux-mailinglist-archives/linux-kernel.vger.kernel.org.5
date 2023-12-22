Return-Path: <linux-kernel+bounces-9542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6314681C748
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 10:27:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79E761C22987
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 09:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F242DF67;
	Fri, 22 Dec 2023 09:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kvLPru3+"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ABAAD527;
	Fri, 22 Dec 2023 09:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-50e67f70f34so745406e87.0;
        Fri, 22 Dec 2023 01:27:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703237265; x=1703842065; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LGMfLXT4RL6oKZY66as4dBPKGDBuU79L4DSeHv0sqDQ=;
        b=kvLPru3+9FdN0BkXGJAPIA/vpp4vKEdBTA3ssoJk+4dsVusLwHx6EjayI1LX+dvP/1
         lcJZliu/54Q/UtFNTZbOH5YoPd3EW2mEtT7cOJe6xlX/SjoIs7MKh658fT/S3PS5+tMs
         nhIy9YkjTNfXwqJZUzfXuBxvaR6gktpIOU5sUy2vn1hb18Qz5NE3Kux0luRAzIt4TtoU
         hlFFp0RCLZdC4qBbjmbhJM7YD2JqzU+xM6gr2L2f17vmK+WU2Jo2E3zAkx+ba0kVCIGu
         TqCbyc8iyCIVC7HIUi+2EqTR1RfN+skYh/srG5nKxWO3ghUOhTY4vjdhC1S4TndUHpRY
         0jJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703237265; x=1703842065;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LGMfLXT4RL6oKZY66as4dBPKGDBuU79L4DSeHv0sqDQ=;
        b=UgHd9qLbxD+d+v+627g/ogFTczu5w25sOAL+P4+xemLDmDZ4scIWh9Zn46s/KHkeEp
         rOAuTIcUOeoQo2DB1vq3WP+PIn8NlfSLt0+WfUOkG2HuIXeXundDIY4GYdRi5ykRTsL+
         vb/h0bb+pGcu7CYuARcC2OSLcBFljw2dDPBk7AVWYmPBeFmm2LD9H3oeRV8QSJdrLq0p
         nuBLiP8xCGazaw0kwugM33qWwF2bZcEE4/00E1QcTlDCo7Zeamnu2RAMl2I5bZangFG/
         4O9E21ULsxnYCy6wE6OecB/3gSOTUTR/Tm2AoBYjJV2U0T0K2tmK9WKGXw94/jBRbCfK
         +KWA==
X-Gm-Message-State: AOJu0YwPgaM/HdcX282wtz8XIvsThmiW3viloqQCLHy6jU2ZIes7f0fk
	JPMhGFQEuypm+M51lk96hYrpRz7L4yU=
X-Google-Smtp-Source: AGHT+IHXaH7jK87DnvGTt1FKqEa3ChRNEfkCTn08Gao6X+n1JQ7AXI55fCDjTekZwAxW4ootDgOsaA==
X-Received: by 2002:a19:7611:0:b0:50e:4faa:430d with SMTP id c17-20020a197611000000b0050e4faa430dmr474864lff.86.1703237264819;
        Fri, 22 Dec 2023 01:27:44 -0800 (PST)
Received: from pc636 (host-90-233-221-204.mobileonline.telia.com. [90.233.221.204])
        by smtp.gmail.com with ESMTPSA id s18-20020a056512315200b0050e17e66bebsm496364lfi.98.2023.12.22.01.27.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 01:27:44 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Fri, 22 Dec 2023 10:27:41 +0100
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Uladzislau Rezki <urezki@gmail.com>, RCU <rcu@vger.kernel.org>,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	Boqun Feng <boqun.feng@gmail.com>, Hillf Danton <hdanton@sina.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
	Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH v3 4/7] rcu: Improve handling of synchronize_rcu() users
Message-ID: <ZYVWjc65LzD8qkdw@pc636>
References: <20231128080033.288050-1-urezki@gmail.com>
 <20231128080033.288050-5-urezki@gmail.com>
 <579f86e0-e03e-4ab3-9a85-a62064bcf2a1@paulmck-laptop>
 <ZYQY8bB3zpywfBxO@pc636>
 <650554ca-17f6-4119-ab4e-42239c958c73@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <650554ca-17f6-4119-ab4e-42239c958c73@paulmck-laptop>

On Thu, Dec 21, 2023 at 10:40:21AM -0800, Paul E. McKenney wrote:
> On Thu, Dec 21, 2023 at 11:52:33AM +0100, Uladzislau Rezki wrote:
> > On Tue, Dec 19, 2023 at 05:37:56PM -0800, Paul E. McKenney wrote:
> > > On Tue, Nov 28, 2023 at 09:00:30AM +0100, Uladzislau Rezki (Sony) wrote:
> > > > From: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
> > > > 
> > > > Currently, processing of the next batch of rcu_synchronize nodes
> > > > for the new grace period, requires doing a llist reversal operation
> > > > to find the tail element of the list. This can be a very costly
> > > > operation (high number of cache misses) for a long list.
> > > > 
> > > > To address this, this patch introduces a "dummy-wait-node" entity.
> > > > At every grace period init, a new wait node is added to the llist.
> > > > This wait node is used as wait tail for this new grace period.
> > > > 
> > > > This allows lockless additions of new rcu_synchronize nodes in the
> > > > rcu_sr_normal_add_req(), while the cleanup work executes and does
> > > > the progress. The dummy nodes are removed on next round of cleanup
> > > > work execution.
> > > > 
> > > > Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > > > Signed-off-by: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>
> > > 
> > > This says that Uladzislau created the patch and that Neeraj
> > > acted as maintainer.  I am guessing that you both worked on it,
> > > in which case is should have the Co-developed-by tags as shown in
> > > Documentation/process/submitting-patches.rst.  Could you please update
> > > these to reflect the actual origin?
> > > 
> > Right. We both worked on it. Neeraj is an author whereas i should mark
> > myself as a Co-developed-by. This is a correct way. Thank you for
> > pointing on it!
> 
> Sounds good, thank you!
> 
> > > One question below toward the end.  There are probably others that I
> > > should be asking, but I have to start somewhere.  ;-)
> > > 
> > Good :)
> > 
> > > >  
> > > >  /*
> > > >   * Helper function for rcu_gp_init().
> > > >   */
> > > > -static void rcu_sr_normal_gp_init(void)
> > > > +static bool rcu_sr_normal_gp_init(void)
> > > >  {
> > > > -	struct llist_node *head, *tail;
> > > > +	struct llist_node *first;
> > > > +	struct llist_node *wait_head;
> > > > +	bool start_new_poll = false;
> > > >  
> > > > -	if (llist_empty(&sr.srs_next))
> > > > -		return;
> > > > +	first = READ_ONCE(sr.srs_next.first);
> > > > +	if (!first || rcu_sr_is_wait_head(first))
> > > > +		return start_new_poll;
> > > > +
> > > > +	wait_head = rcu_sr_get_wait_head();
> > > > +	if (!wait_head) {
> > > > +		// Kick another GP to retry.
> > > > +		start_new_poll = true;
> > > > +		return start_new_poll;
> > > > +	}
> > > >  
> > > > -	tail = llist_del_all(&sr.srs_next);
> > > > -	head = llist_reverse_order(tail);
> > > > +	/* Inject a wait-dummy-node. */
> > > > +	llist_add(wait_head, &sr.srs_next);
> > > >  
> > > >  	/*
> > > > -	 * A waiting list of GP should be empty on this step,
> > > > -	 * since a GP-kthread, rcu_gp_init() -> gp_cleanup(),
> > > > +	 * A waiting list of rcu_synchronize nodes should be empty on
> > > > +	 * this step, since a GP-kthread, rcu_gp_init() -> gp_cleanup(),
> > > >  	 * rolls it over. If not, it is a BUG, warn a user.
> > > >  	 */
> > > > -	WARN_ON_ONCE(!llist_empty(&sr.srs_wait));
> > > > +	WARN_ON_ONCE(sr.srs_wait_tail != NULL);
> > > > +	sr.srs_wait_tail = wait_head;
> > > > +	ASSERT_EXCLUSIVE_WRITER(sr.srs_wait_tail);
> > > >  
> > > > -	WRITE_ONCE(sr.srs_wait_tail, tail);
> > > > -	__llist_add_batch(head, tail, &sr.srs_wait);
> > > > +	return start_new_poll;
> > > >  }
> > > >  
> > > >  static void rcu_sr_normal_add_req(struct rcu_synchronize *rs)
> > > > @@ -1493,6 +1684,7 @@ static noinline_for_stack bool rcu_gp_init(void)
> > > >  	unsigned long mask;
> > > >  	struct rcu_data *rdp;
> > > >  	struct rcu_node *rnp = rcu_get_root();
> > > > +	bool start_new_poll;
> > > >  
> > > >  	WRITE_ONCE(rcu_state.gp_activity, jiffies);
> > > >  	raw_spin_lock_irq_rcu_node(rnp);
> > > > @@ -1517,11 +1709,15 @@ static noinline_for_stack bool rcu_gp_init(void)
> > > >  	/* Record GP times before starting GP, hence rcu_seq_start(). */
> > > >  	rcu_seq_start(&rcu_state.gp_seq);
> > > >  	ASSERT_EXCLUSIVE_WRITER(rcu_state.gp_seq);
> > > > -	rcu_sr_normal_gp_init();
> > > > +	start_new_poll = rcu_sr_normal_gp_init();
> > > >  	trace_rcu_grace_period(rcu_state.name, rcu_state.gp_seq, TPS("start"));
> > > >  	rcu_poll_gp_seq_start(&rcu_state.gp_seq_polled_snap);
> > > >  	raw_spin_unlock_irq_rcu_node(rnp);
> > > >  
> > > > +	// New poll request after rnp unlock
> > > > +	if (start_new_poll)
> > > > +		(void) start_poll_synchronize_rcu();
> > > 
> > > You lost me on this one.  Anything that got moved to the wait list
> > > should be handled by the current grace period, right?  Or is the
> > > problem that rcu_sr_normal_gp_init() is being invoked after the call
> > > to rcu_seq_start()?  If that is the case, could it be moved ahead so
> > > that we don't need the extra grace period?
> > > 
> > > Or am I missing something subtle here?
> > > 
> > The problem is that, we are limited in number of "wait-heads" which we
> > add as a marker node for this/current grace period. If there are more clients
> > and there is no a wait-head available it means that a system, the deferred
> > kworker, is slow in processing callbacks, thus all wait-nodes are in use.
> > 
> > That is why we need an extra grace period. Basically to repeat our try one
> > more time, i.e. it might be that a current grace period is not able to handle
> > users due to the fact that a system is doing really slow, but this is rather
> > a corner case and is not a problem.
> 
> But in that case, the real issue is not the need for an extra grace
> period, but rather the need for the wakeup processing to happen, correct?
> Or am I missing something subtle here?
> 
Basically, yes. If we had a spare dummy-node we could process the users
by the current GP(no need in extra). Why we may not have it - it is because
like you pointed:

- wake-up issue, i.e. wake-up time + when we are on_cpu;
- slow list process. For example priority. The kworker is not
  given enough CPU time to do the progress, thus "dummy-nodes"
  are not released in time for reuse.

Therefore, en extra GP is requested if there is a high flow of
synchronize_rcu() users and kworker is not able to do a progress
in time.

For example 60K+ parallel synchronize_rcu() users will trigger it.

--
Uladzislau Rezki

