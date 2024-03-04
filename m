Return-Path: <linux-kernel+bounces-90537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 531128700D6
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 12:55:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 736041C2034E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 11:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 932C53B780;
	Mon,  4 Mar 2024 11:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BzaGLWZZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE763B189;
	Mon,  4 Mar 2024 11:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709553350; cv=none; b=m/3w7VOr0hW7FiTep1aDERzvhnuzxFTJ6nwF+8WO3gi8L672ss0QXDsu16fSd0ZkFBvkHol/ipWgSu2c2RhM21R+TVnT7ji8kSon10IF1PzI2onhOzt3RCl0Zi2cSn1W3xpA5H9e82PF7TJ/af3sjyvFecGeIipe1IRZFJDhJcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709553350; c=relaxed/simple;
	bh=C9l5GlIDwT57uW3nuT4SZmJxej662flcSTsn1taW6Yc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JBc01izc2i/hpRqXyAqJuvFU1mJCb9/IVfiKFPwt9rY9arXgKYYObL36eGBAjNMkLam18neK2bddal9o+4y3Qki9XAtocx738ilFsd1oAj1bN1PnQSyabq/CGEXIeI1PSawgXgiWniKQbgAUZ/35z4N+WO4Oc3DsCEMUw+RuFVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BzaGLWZZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F10D5C433C7;
	Mon,  4 Mar 2024 11:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709553350;
	bh=C9l5GlIDwT57uW3nuT4SZmJxej662flcSTsn1taW6Yc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BzaGLWZZeaomXtN8YrYSmmI70bToSfUpwLRoDuQ32TC4qFdcmEr3gC/CA4SwDVHes
	 UtbioiU+g9iTbRLQXYCfS4gX8x4Bn3ukdFBnDO/ifdgd7J5D29VeEbHW/RTLP/PvcA
	 rwdRZZ+vixU3EbjYGZT9X7zeFXn7KFjw9Z/vjksV74WpQTLoGWugXwboCmbLFuF+SZ
	 mbEAGGuovjLS8sgROt5iIq2KlcZtHfmrxuveaTPt4WNhU+1G04a96/dvYLVsGwW+my
	 bS97F7syfe4aCjxAiSXzDDxhoqMwYkynlwKjmtJxS6qOboJs+vMdIP6UXOoTw4dUCN
	 skOsCFbc5uK5Q==
Date: Mon, 4 Mar 2024 12:55:47 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Uladzislau Rezki <urezki@gmail.com>
Cc: "Paul E . McKenney" <paulmck@kernel.org>, RCU <rcu@vger.kernel.org>,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	Boqun Feng <boqun.feng@gmail.com>, Hillf Danton <hdanton@sina.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH v5 2/4] rcu: Reduce synchronize_rcu() latency
Message-ID: <ZeW2w08WZo4yapQp@localhost.localdomain>
References: <20240220183115.74124-1-urezki@gmail.com>
 <20240220183115.74124-3-urezki@gmail.com>
 <Zd0ZtNu+Rt0qXkfS@lothringen>
 <Zd91pR0fjiCUZTtP@pc636>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zd91pR0fjiCUZTtP@pc636>

Le Wed, Feb 28, 2024 at 07:04:21PM +0100, Uladzislau Rezki a écrit :
> On Tue, Feb 27, 2024 at 12:07:32AM +0100, Frederic Weisbecker wrote:
> > On Tue, Feb 20, 2024 at 07:31:13PM +0100, Uladzislau Rezki (Sony) wrote:
> > > +static void rcu_sr_normal_gp_cleanup_work(struct work_struct *work)
> > > +{
> > > +	struct llist_node *done, *rcu, *next, *head;
> > > +
> > > +	/*
> > > +	 * This work execution can potentially execute
> > > +	 * while a new done tail is being updated by
> > > +	 * grace period kthread in rcu_sr_normal_gp_cleanup().
> > > +	 * So, read and updates of done tail need to
> > > +	 * follow acq-rel semantics.
> > > +	 *
> > > +	 * Given that wq semantics guarantees that a single work
> > > +	 * cannot execute concurrently by multiple kworkers,
> > > +	 * the done tail list manipulations are protected here.
> > > +	 */
> > > +	done = smp_load_acquire(&rcu_state.srs_done_tail);
> > > +	if (!done)
> > > +		return;
> > > +
> > > +	WARN_ON_ONCE(!rcu_sr_is_wait_head(done));
> > > +	head = done->next;
> > > +	done->next = NULL;
> > 
> > Can the following race happen?
> > 
> > CPU 0                                                   CPU 1
> > -----                                                   -----
> > 
> > // wait_tail == HEAD1
> > rcu_sr_normal_gp_cleanup() {
> >     // has passed SR_MAX_USERS_WAKE_FROM_GP
> >     wait_tail->next = next;
> >     // done_tail = HEAD1
> >     smp_store_release(&rcu_state.srs_done_tail, wait_tail);
> >     queue_work() {
> >         test_and_set_bit(WORK_STRUCT_PENDING_BIT, work_data_bits(work)
> >         __queue_work()
> >     }
> > }
> > 
> >                                                       set_work_pool_and_clear_pending()
> >                                                       rcu_sr_normal_gp_cleanup_work() {
> > // new GP, wait_tail == HEAD2
> > rcu_sr_normal_gp_cleanup() {
> >     // executes all completion, but stop at HEAD1
> >     wait_tail->next = HEAD1;
> >     // done_tail = HEAD2
> >     smp_store_release(&rcu_state.srs_done_tail, wait_tail);
> >     queue_work() {
> >         test_and_set_bit(WORK_STRUCT_PENDING_BIT, work_data_bits(work)
> >         __queue_work()
> >     }
> > }
> >                                                           // done = HEAD2
> >                                                           done = smp_load_acquire(&rcu_state.srs_done_tail);
> >                                                           // head = HEAD1
> >                                                           head = done->next;
> >                                                           done->next = NULL;
> >                                                           llist_for_each_safe() {
> >                                                               // completes all callbacks, release HEAD1
> >                                                           }
> >                                                       }
> >                                                       // Process second queue
> >                                                       set_work_pool_and_clear_pending()
> >                                                       rcu_sr_normal_gp_cleanup_work() {
> >                                                           // done = HEAD2
> >                                                           done = smp_load_acquire(&rcu_state.srs_done_tail);
> > 
> > // new GP, wait_tail == HEAD3
> > rcu_sr_normal_gp_cleanup() {
> >     // Finds HEAD2 with ->next == NULL at the end
> >     rcu_sr_put_wait_head(HEAD2)
> >     ...
> > 
> > // A few more GPs later
> > rcu_sr_normal_gp_init() {
> >      HEAD2 = rcu_sr_get_wait_head();
> >      llist_add(HEAD2, &rcu_state.srs_next);
> >                                                           // head == rcu_state.srs_next
> >                                                           head = done->next;
> >                                                           done->next = NULL;
> >                                                           llist_for_each_safe() {
> >                                                               // EXECUTE CALLBACKS TOO EARLY!!!
> >                                                           }
> >                                                       }
> Looks like that. To address this, we should not release the head in the GP
> > kthread.

But then you have to unconditionally schedule the work, right? Otherwise the
HEADs are not released. And that means dropping this patch (right now I don't
have a better idea).

