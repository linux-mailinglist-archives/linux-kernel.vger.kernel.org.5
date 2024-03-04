Return-Path: <linux-kernel+bounces-91205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26949870B2E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 21:07:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B36DD287BC2
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 20:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 381AB7A150;
	Mon,  4 Mar 2024 20:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zv8M//rr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F0217995F;
	Mon,  4 Mar 2024 20:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709582864; cv=none; b=iSD4xRqi8ErxJWxJxMKLMUnBiVWYuOkSmbuJq9puFpDxtNrohoXbZ9WcJ9NV7zQFpMcWFKWXJqhibJupszC0kyLtRcQu3/MjqxqFhcMBAfmjSu1oeovQJeFaw6vJVZ1VU8jmFJ6x8R83wXvss8SkkykHavrK4iBOWqRSrKGJFJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709582864; c=relaxed/simple;
	bh=rxDEV3N7EKQdsIQOLDUfRTkpb7cFIvo3F8fg01dVwRs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gkb/0+mEH4wuPYj3k5XVkvO8Dw4tbiryV2e6vClr25TlR4GCpMoYpF+82tbSNj6rmn+dyT2VZM9GYA5alRS1n9vLOOlxuRqo4hl7z5MWeeLmzwQM4dEnimn/K7o7gDsVk7rSlHPWYSyTjihUeIl1tmRe/Kmw9Tt9DZNyaoyKO68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zv8M//rr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC525C433C7;
	Mon,  4 Mar 2024 20:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709582863;
	bh=rxDEV3N7EKQdsIQOLDUfRTkpb7cFIvo3F8fg01dVwRs=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=Zv8M//rr2IL8nsFMGCvFoGPdtHjhU2LSfZiDzXCU8Q18POe7eD9orzOh/ZacOFMta
	 aIRJImzgxiEp5EaYGojWJ/Osctuq3eBtYVKcIFqW8FJhrMFJbraGw58rV2iStfoQpb
	 BnV69K8jFTt471YprBBuiqPCG5PDzrdIccBOwlbmilUqooBYpxVi9oycDkdX6mpZjm
	 xUBeBftmQV8BBxY2sME5UojTpshHJxptPyCf8QGNfKaJ/wu3GWLDk1TgqeW5nzTufq
	 ++ktAIfPGJgvZFh4XttGeCos0Jhn9nVXi0J0hHI14mdaL1zmU1i6OErHwSv2DOmbMd
	 wjb4nswzxrFJg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 60D4BCE049E; Mon,  4 Mar 2024 12:07:43 -0800 (PST)
Date: Mon, 4 Mar 2024 12:07:43 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Uladzislau Rezki <urezki@gmail.com>
Cc: Frederic Weisbecker <frederic@kernel.org>, RCU <rcu@vger.kernel.org>,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	Boqun Feng <boqun.feng@gmail.com>, Hillf Danton <hdanton@sina.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: Re: [PATCH v5 2/4] rcu: Reduce synchronize_rcu() latency
Message-ID: <aa431a31-e9a3-4a6c-b2a7-f0e09794ca4c@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240220183115.74124-1-urezki@gmail.com>
 <20240220183115.74124-3-urezki@gmail.com>
 <Zd0ZtNu+Rt0qXkfS@lothringen>
 <Zd91pR0fjiCUZTtP@pc636>
 <ZeW2w08WZo4yapQp@localhost.localdomain>
 <ZeX1cXWKv2kirDXg@pc638.lan>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZeX1cXWKv2kirDXg@pc638.lan>

On Mon, Mar 04, 2024 at 05:23:13PM +0100, Uladzislau Rezki wrote:
> On Mon, Mar 04, 2024 at 12:55:47PM +0100, Frederic Weisbecker wrote:
> > Le Wed, Feb 28, 2024 at 07:04:21PM +0100, Uladzislau Rezki a écrit :
> > > On Tue, Feb 27, 2024 at 12:07:32AM +0100, Frederic Weisbecker wrote:
> > > > On Tue, Feb 20, 2024 at 07:31:13PM +0100, Uladzislau Rezki (Sony) wrote:
> > > > > +static void rcu_sr_normal_gp_cleanup_work(struct work_struct *work)
> > > > > +{
> > > > > +	struct llist_node *done, *rcu, *next, *head;
> > > > > +
> > > > > +	/*
> > > > > +	 * This work execution can potentially execute
> > > > > +	 * while a new done tail is being updated by
> > > > > +	 * grace period kthread in rcu_sr_normal_gp_cleanup().
> > > > > +	 * So, read and updates of done tail need to
> > > > > +	 * follow acq-rel semantics.
> > > > > +	 *
> > > > > +	 * Given that wq semantics guarantees that a single work
> > > > > +	 * cannot execute concurrently by multiple kworkers,
> > > > > +	 * the done tail list manipulations are protected here.
> > > > > +	 */
> > > > > +	done = smp_load_acquire(&rcu_state.srs_done_tail);
> > > > > +	if (!done)
> > > > > +		return;
> > > > > +
> > > > > +	WARN_ON_ONCE(!rcu_sr_is_wait_head(done));
> > > > > +	head = done->next;
> > > > > +	done->next = NULL;
> > > > 
> > > > Can the following race happen?
> > > > 
> > > > CPU 0                                                   CPU 1
> > > > -----                                                   -----
> > > > 
> > > > // wait_tail == HEAD1
> > > > rcu_sr_normal_gp_cleanup() {
> > > >     // has passed SR_MAX_USERS_WAKE_FROM_GP
> > > >     wait_tail->next = next;
> > > >     // done_tail = HEAD1
> > > >     smp_store_release(&rcu_state.srs_done_tail, wait_tail);
> > > >     queue_work() {
> > > >         test_and_set_bit(WORK_STRUCT_PENDING_BIT, work_data_bits(work)
> > > >         __queue_work()
> > > >     }
> > > > }
> > > > 
> > > >                                                       set_work_pool_and_clear_pending()
> > > >                                                       rcu_sr_normal_gp_cleanup_work() {
> > > > // new GP, wait_tail == HEAD2
> > > > rcu_sr_normal_gp_cleanup() {
> > > >     // executes all completion, but stop at HEAD1
> > > >     wait_tail->next = HEAD1;
> > > >     // done_tail = HEAD2
> > > >     smp_store_release(&rcu_state.srs_done_tail, wait_tail);
> > > >     queue_work() {
> > > >         test_and_set_bit(WORK_STRUCT_PENDING_BIT, work_data_bits(work)
> > > >         __queue_work()
> > > >     }
> > > > }
> > > >                                                           // done = HEAD2
> > > >                                                           done = smp_load_acquire(&rcu_state.srs_done_tail);
> > > >                                                           // head = HEAD1
> > > >                                                           head = done->next;
> > > >                                                           done->next = NULL;
> > > >                                                           llist_for_each_safe() {
> > > >                                                               // completes all callbacks, release HEAD1
> > > >                                                           }
> > > >                                                       }
> > > >                                                       // Process second queue
> > > >                                                       set_work_pool_and_clear_pending()
> > > >                                                       rcu_sr_normal_gp_cleanup_work() {
> > > >                                                           // done = HEAD2
> > > >                                                           done = smp_load_acquire(&rcu_state.srs_done_tail);
> > > > 
> > > > // new GP, wait_tail == HEAD3
> > > > rcu_sr_normal_gp_cleanup() {
> > > >     // Finds HEAD2 with ->next == NULL at the end
> > > >     rcu_sr_put_wait_head(HEAD2)
> > > >     ...
> > > > 
> > > > // A few more GPs later
> > > > rcu_sr_normal_gp_init() {
> > > >      HEAD2 = rcu_sr_get_wait_head();
> > > >      llist_add(HEAD2, &rcu_state.srs_next);
> > > >                                                           // head == rcu_state.srs_next
> > > >                                                           head = done->next;
> > > >                                                           done->next = NULL;
> > > >                                                           llist_for_each_safe() {
> > > >                                                               // EXECUTE CALLBACKS TOO EARLY!!!
> > > >                                                           }
> > > >                                                       }
> > > Looks like that. To address this, we should not release the head in the GP
> > > > kthread.
> > 
> > But then you have to unconditionally schedule the work, right? Otherwise the
> > HEADs are not released. And that means dropping this patch (right now I don't
> > have a better idea).
> >
> The easiest way is to drop the patch. To address it we can go with:
> 
> <snip>
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 31f3a61f9c38..9aa2cd46583e 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -1661,16 +1661,8 @@ static void rcu_sr_normal_gp_cleanup(void)
>  	 * wait-head is released if last. The worker is not kicked.
>  	 */
>  	llist_for_each_safe(rcu, next, wait_tail->next) {
> -		if (rcu_sr_is_wait_head(rcu)) {
> -			if (!rcu->next) {
> -				rcu_sr_put_wait_head(rcu);
> -				wait_tail->next = NULL;
> -			} else {
> -				wait_tail->next = rcu;
> -			}
> -
> +		if (rcu_sr_is_wait_head(rcu))
>  			break;
> -		}
>  
>  		rcu_sr_normal_complete(rcu);
>  		// It can be last, update a next on this step.
> <snip>
> 
> i.e. the process of users from GP is still there. The work is triggered
> to perform a final complete(if there are users) + releasing wait-heads
> so we do not race anymore.
> 
> I am OK with both cases. Dropping the patch will make it more simple
> for sure.

Please feel free to repost a fixed-up patch series.  I can easily replace
the commits currently in -rcu with new ones.  Just let me know.

						Thanx, Paul

