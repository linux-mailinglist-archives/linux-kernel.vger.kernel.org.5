Return-Path: <linux-kernel+bounces-28940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47AF88304E7
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 13:07:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CCCC6B22AC1
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 12:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54DA01DFDF;
	Wed, 17 Jan 2024 12:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FEqsFe94"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E7A1DFCF;
	Wed, 17 Jan 2024 12:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705493249; cv=none; b=ftvBX/xm5z9UjJsKaKXAaywOBHPihKim/NI9BJLLsD3Am6WAWfe0Rw1DRhsfz8tOA7tGNrtWjUDfBiJzJ2Y4n3iTmc4K50Gxt3Tpk023ZI5cD0oxRzGr+60dDRk5hQ1yYwVh5V9WMDHGQYoyYoLF03SnhPEe9mqMyTL/LY1FTrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705493249; c=relaxed/simple;
	bh=wpw637Q0rxse1Y2+Phvi66Mke3B2SRMl31WlpUI87QE=;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To; b=kmKSjk6Ynih+YKXK1C02Ds4gKiJC5OOcAq3VbmuK5tWbkCbMKoB+SaVHqSvDWIC8dsplvK2JkCi+Y+SE3coHwaO99XHi21CQMTR9QKj1KzYd1tygM6OoYv7lYmc/1voMstdWj3It41zlJfEFRwNqPivmag2isIi9ic+FHH2Inio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FEqsFe94; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EC2AC433C7;
	Wed, 17 Jan 2024 12:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705493249;
	bh=wpw637Q0rxse1Y2+Phvi66Mke3B2SRMl31WlpUI87QE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FEqsFe94WyllVCMT1A45wmnuJLWetHY7WzypkL9ZFY4eYcvHiQt+FQHOhkz5d3/yS
	 1g8GZM1xqMkWlcRL23XZ5xzrB7BMb+YMFSohb4NyW1tMeOH6f0dBVy8693tRQPwsk7
	 CT841qWqiuPQcvzyP/rDAfLfFRzJlhXKEtlUHHsQMlMtx9cfIH7CAlGgHb6zTqsz/K
	 aFo/lsZ8a44WowDz8jLLyvORB8mlTzu637Ohk9VajFXicO7ElCJwoN+9zeWLAIgV/E
	 fB3sor/umyNg2YuoYjENSZQWg0OMKuXAttn8MmwVB2Hvam3HcKvKrvzFJY9CRj9GM5
	 pEQhOk4XAIWMA==
Date: Wed, 17 Jan 2024 13:07:25 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Zqiang <qiang.zhang1211@gmail.com>
Cc: paulmck@kernel.org, quic_neeraju@quicinc.com, joel@joelfernandes.org,
	rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu/nocb: Check rdp_gp->nocb_timer in
 __call_rcu_nocb_wake()
Message-ID: <ZafC_YkTJKsOropE@localhost.localdomain>
References: <20240117102616.18302-1-qiang.zhang1211@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240117102616.18302-1-qiang.zhang1211@gmail.com>

Le Wed, Jan 17, 2024 at 06:26:16PM +0800, Zqiang a écrit :
> Currently, only rdp_gp->nocb_timer is used, for nocb_timer of
> no-rdp_gp structure, the timer_pending() is always return false,
> this commit therefore need to check rdp_gp->nocb_timer in
> __call_rcu_nocb_wake().
> 
> Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
> ---
>  kernel/rcu/tree_nocb.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
> index 54971afc3a9b..3f85577bddd4 100644
> --- a/kernel/rcu/tree_nocb.h
> +++ b/kernel/rcu/tree_nocb.h
> @@ -564,6 +564,7 @@ static void __call_rcu_nocb_wake(struct rcu_data *rdp, bool was_alldone,
>  	long lazy_len;
>  	long len;
>  	struct task_struct *t;
> +	struct rcu_data *rdp_gp = rdp->nocb_gp_rdp;
>  
>  	// If we are being polled or there is no kthread, just leave.
>  	t = READ_ONCE(rdp->nocb_gp_kthread);
> @@ -608,7 +609,7 @@ static void __call_rcu_nocb_wake(struct rcu_data *rdp, bool was_alldone,
>  		smp_mb(); /* Enqueue before timer_pending(). */
>  		if ((rdp->nocb_cb_sleep ||
>  		     !rcu_segcblist_ready_cbs(&rdp->cblist)) &&
> -		    !timer_pending(&rdp->nocb_timer)) {
> +		    !timer_pending(&rdp_gp->nocb_timer)) {

Hehe, good eyes ;-)

I had that change in mind but while checking that area further I actually
wondered what is the actual purpose of this RCU_NOCB_WAKE_FORCE thing. If
we reach that place, it means that the nocb_gp kthread should be awaken
already (or the timer pending), so what does a force wake up solve in that
case?

Paul, any recollection of that?

In the meantime:

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

