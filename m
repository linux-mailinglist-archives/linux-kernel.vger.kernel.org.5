Return-Path: <linux-kernel+bounces-95532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91107874EFE
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 13:28:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 003FF1F222C7
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 12:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74AF912AAE5;
	Thu,  7 Mar 2024 12:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TCE/VXET"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF1868563D;
	Thu,  7 Mar 2024 12:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709814488; cv=none; b=mBXN/ijKE3q4rMM7Rc98NC4XzvuVNgzMLPbVkLuXfo249IaoQ31NLR+3pCTCkvsWjy5mZyAe0nrQH0Be97/++CMbELBIyJaSBEhdNc7hjYpStLzD4VXQLdaezLaHB8gKqCM2zJioshDgg1uHSDMcC8mVecAn7kaNNgdbksZiSn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709814488; c=relaxed/simple;
	bh=EqkDsKVlKPs/822PR4HaJMgwoDO9BoVj0fvPRRDp83U=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nrR+PZPGCUnbiDLIs8qwdxBP7ggFP3cop2K7ax7Vw9iSGdtjV5U1I8e/mUrtRjkJPMQl/gTsMk+RGmFEstk3UEQPSeGxQDZxZ0N8gczOWM5R1Q/7l4WPK7ObkuHl++IXBLqp48a7dYuLuvwu2EuSnpdfsbbqogLCrQS7PikmWCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TCE/VXET; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-513181719easo631869e87.3;
        Thu, 07 Mar 2024 04:28:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709814485; x=1710419285; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gz8Cbh194aVw03XqXK43A9BunRKEWBlJAiUGr2SJ1Hg=;
        b=TCE/VXETLQ3mteN8pNmfVsr7TyG3Khl09uU6xh1Mpl5R0uNampI8iSlZBcxpuzCbVu
         TKyHTlgsJwqjp/GsKz/pSmyMw12/xHqX5l1Q/RAFk28ZrCfT0/xVf6Oi/LAo/JCytJ3m
         GtcTNI3aDHUTblOqJ64egc1po0jiLc5yOQwS71RNdEin9zxaFZMa2ffpDRoNp6kbOdmY
         tYKFLTQC8UrMY6JkGfRVPK8dLcMgcT1rN1FgNMwPR54lQKGNU5k3yz9DH+3zKHO6Up7L
         XPfy3QW97k3+ofrkvBiVsOtJVlPDo4QdfA0t5UtHU6QmKKitXVtl9BrLTqaQRV9QDKcn
         dQCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709814485; x=1710419285;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gz8Cbh194aVw03XqXK43A9BunRKEWBlJAiUGr2SJ1Hg=;
        b=krX4ReVllHh4luLKO7dL6YHOROAT64ujEprVKfKkKNAIcWLO0SrGTSUGCmN65OVWnV
         fEex23J+Lee6y6BdtfkbDNAFgP9vt5OCT7jAVIYhg9CWwG86MHttZLkVpBgaFBwqHZG1
         JlnGdrQKGy+5SHMf6W++ryNa7chI6dTtsgbzxsAKVZiMPcoYn+nFZibSHqrXmFaaToga
         IJZyotuTsErFkq5JKtI2mF1gYiGgagI7BDZkRl+VAWP8HNBP/5RB6Dm/HwyVcojqjFyu
         NgjSWb0IesOk1h7G19NpK2ps/XiT4+0/TPqOypdNOK1gZiXb0pFWW1ik1SuK3mPws6eG
         f3bg==
X-Forwarded-Encrypted: i=1; AJvYcCUjWGdzY0CgrHVvRp5YJQzFGNGQaqanbLXK1zd64rZqH0YZD4uEOBFstHtF8xcmWiSI2IqKDSxOBaJ73OqWhfWADkpi3GNNJMAMzJWXWe3y/q+twOa8DaRllbPZ6mk+tmF3
X-Gm-Message-State: AOJu0YwGqFSlnpA8bynLG5MwqNRxjrfT9qRtl3fSxYcwBhK9VhFbghp3
	07Lwe6zujzJ2dmXlJx638A7+4ToQmvbs9M41HupqGb22uH9gFLxA
X-Google-Smtp-Source: AGHT+IGtxLAQ7JfgdKUdX5qRypv7ccc7PLfOLhCNjgv+T1FKt/DqTA5ubsnN7zGIYg9b/rd3kT/KzQ==
X-Received: by 2002:ac2:5f08:0:b0:513:1e47:bc5b with SMTP id 8-20020ac25f08000000b005131e47bc5bmr1311362lfq.25.1709814484392;
        Thu, 07 Mar 2024 04:28:04 -0800 (PST)
Received: from pc636 (host-90-235-19-15.mobileonline.telia.com. [90.235.19.15])
        by smtp.gmail.com with ESMTPSA id a22-20020a19f816000000b00512fb973e21sm3027187lff.294.2024.03.07.04.28.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 04:28:04 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Thu, 7 Mar 2024 13:28:01 +0100
To: Joel Fernandes <joel@joelfernandes.org>
Cc: "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
	"Paul E . McKenney" <paulmck@kernel.org>, RCU <rcu@vger.kernel.org>,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	Boqun Feng <boqun.feng@gmail.com>, Hillf Danton <hdanton@sina.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
	Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH 1/2] rcu: Do not release a wait-head from a GP kthread
Message-ID: <Zemy0bbZh7YA1aRY@pc636>
References: <20240305195720.42687-1-urezki@gmail.com>
 <a1faf101-c689-4530-a9a5-c7f95b8825d6@joelfernandes.org>
 <14ab5bd4-d7b8-4233-9389-f21884986671@joelfernandes.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <14ab5bd4-d7b8-4233-9389-f21884986671@joelfernandes.org>

On Thu, Mar 07, 2024 at 01:21:50AM -0500, Joel Fernandes wrote:
> 
> 
> On 3/6/2024 5:31 PM, Joel Fernandes wrote:
> > 
> > 
> > On 3/5/2024 2:57 PM, Uladzislau Rezki (Sony) wrote:
> >> Fix a below race by not releasing a wait-head from the
> >> GP-kthread as it can lead for reusing it whereas a worker
> >> can still access it thus execute newly added callbacks too
> >> early.
> >>
> >> CPU 0                              CPU 1
> >> -----                              -----
> >>
> >> // wait_tail == HEAD1
> >> rcu_sr_normal_gp_cleanup() {
> >>     // has passed SR_MAX_USERS_WAKE_FROM_GP
> >>     wait_tail->next = next;
> >>     // done_tail = HEAD1
> >>     smp_store_release(&rcu_state.srs_done_tail, wait_tail);
> >>     queue_work() {
> >>         test_and_set_bit(WORK_STRUCT_PENDING_BIT, work_data_bits(work)
> >>         __queue_work()
> >>     }
> >> }
> >>
> >>                                set_work_pool_and_clear_pending()
> >>                                rcu_sr_normal_gp_cleanup_work() {
> >> // new GP, wait_tail == HEAD2
> >> rcu_sr_normal_gp_cleanup() {
> >>     // executes all completion, but stop at HEAD1
> >>     wait_tail->next = HEAD1;
> >>     // done_tail = HEAD2
> >>     smp_store_release(&rcu_state.srs_done_tail, wait_tail);
> >>     queue_work() {
> >>         test_and_set_bit(WORK_STRUCT_PENDING_BIT, work_data_bits(work)
> >>         __queue_work()
> >>     }
> >> }
> >>                                  // done = HEAD2
> >>                                  done = smp_load_acquire(&rcu_state.srs_done_tail);
> >>                                  // head = HEAD1
> >>                                  head = done->next;
> >>                                  done->next = NULL;
> >>                                  llist_for_each_safe() {
> >>                                  // completes all callbacks, release HEAD1
> >>                                  }
> >>                                }
> >>                                // Process second queue
> >>                                set_work_pool_and_clear_pending()
> >>                                rcu_sr_normal_gp_cleanup_work() {
> >>                                // done = HEAD2
> >>                                done = smp_load_acquire(&rcu_state.srs_done_tail);
> >>
> >> // new GP, wait_tail == HEAD3
> >> rcu_sr_normal_gp_cleanup() {
> >>     // Finds HEAD2 with ->next == NULL at the end
> >>     rcu_sr_put_wait_head(HEAD2)
> >>     ...
> >>
> >> // A few more GPs later
> >> rcu_sr_normal_gp_init() {
> >>      HEAD2 = rcu_sr_get_wait_head();
> >>      llist_add(HEAD2, &rcu_state.srs_next);
> >>                                // head == rcu_state.srs_next
> >>                                head = done->next;
> >>                                done->next = NULL;
> >>                                llist_for_each_safe() {
> >>                                 // EXECUTE CALLBACKS TOO EARLY!!!
> >>                                 }
> >>                                }
> >>
> >> Reported-by: Frederic Weisbecker <frederic@kernel.org>
> >> Fixes: 05a10b921000 ("rcu: Support direct wake-up of synchronize_rcu() users")
> >> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> >> ---
> >>  kernel/rcu/tree.c | 22 ++++++++--------------
> >>  1 file changed, 8 insertions(+), 14 deletions(-)
> >>
> >> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> >> index 31f3a61f9c38..475647620b12 100644
> >> --- a/kernel/rcu/tree.c
> >> +++ b/kernel/rcu/tree.c
> >> @@ -1656,21 +1656,11 @@ static void rcu_sr_normal_gp_cleanup(void)
> >>  	WARN_ON_ONCE(!rcu_sr_is_wait_head(wait_tail));
> >>  
> >>  	/*
> >> -	 * Process (a) and (d) cases. See an illustration. Apart of
> >> -	 * that it handles the scenario when all clients are done,
> >> -	 * wait-head is released if last. The worker is not kicked.
> >> +	 * Process (a) and (d) cases. See an illustration.
> >>  	 */
> >>  	llist_for_each_safe(rcu, next, wait_tail->next) {
> >> -		if (rcu_sr_is_wait_head(rcu)) {
> >> -			if (!rcu->next) {
> >> -				rcu_sr_put_wait_head(rcu);
> >> -				wait_tail->next = NULL;
> >> -			} else {
> >> -				wait_tail->next = rcu;
> >> -			}
> >> -
> >> +		if (rcu_sr_is_wait_head(rcu))
> >>  			break;
> >> -		}
> >>  
> >>  		rcu_sr_normal_complete(rcu);
> >>  		// It can be last, update a next on this step.
> >> @@ -1684,8 +1674,12 @@ static void rcu_sr_normal_gp_cleanup(void)
> >>  	smp_store_release(&rcu_state.srs_done_tail, wait_tail);
> >>  	ASSERT_EXCLUSIVE_WRITER(rcu_state.srs_done_tail);
> >>  
> >> -	if (wait_tail->next)
> >> -		queue_work(system_highpri_wq, &rcu_state.srs_cleanup_work);
> >> +	/*
> >> +	 * We schedule a work in order to perform a final processing
> >> +	 * of outstanding users(if still left) and releasing wait-heads
> >> +	 * added by rcu_sr_normal_gp_init() call.
> >> +	 */
> >> +	queue_work(system_highpri_wq, &rcu_state.srs_cleanup_work);
> >>  }
> 
> One question, why do you need to queue_work() if wait_tail->next == NULL?
> 
> AFAICS, at this stage if wait_tail->next == NULL, you are in CASE f. so the last
> remaining HEAD stays?  (And llist_for_each_safe() in
> rcu_sr_normal_gp_cleanup_work becomes a NOOP).
> 
> Could be something like this, but maybe I missed something:
> 
> @@ -1672,7 +1674,7 @@ static void rcu_sr_normal_gp_cleanup_work(struct
> work_struct *work)
>   */
>  static void rcu_sr_normal_gp_cleanup(void)
>  {
> -       struct llist_node *wait_tail, *next, *rcu;
> +       struct llist_node *wait_tail, *next = NULL, *rcu = NULL;
>         int done = 0;
> 
>         wait_tail = rcu_state.srs_wait_tail;
> @@ -1707,7 +1709,8 @@ static void rcu_sr_normal_gp_cleanup(void)
>          * of outstanding users(if still left) and releasing wait-heads
>          * added by rcu_sr_normal_gp_init() call.
>          */
> -       queue_work(system_highpri_wq, &rcu_state.srs_cleanup_work);
> +       if (rcu)
> +               queue_work(system_highpri_wq, &rcu_state.srs_cleanup_work);
>  }
> 
>  /*
>
Unneeded queueing happens only first time after boot. After one cycle
we always need to queue the work to do a previous cleanups.

if (wait_head->next)
    queue_the_work();


wait_head->next is always not NULL except first cycle after boot.

--
Uladzislau Rezki

