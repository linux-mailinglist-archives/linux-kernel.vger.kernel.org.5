Return-Path: <linux-kernel+bounces-119575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2640988CA9D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 18:21:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBAC41F82E44
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 17:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9188A1CD16;
	Tue, 26 Mar 2024 17:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ria7CDjh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F1617BA0;
	Tue, 26 Mar 2024 17:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711473701; cv=none; b=c8HSqMcCBZuit11Mio3ue9Zur+4oRaYUwgJ67TUo9m5a4pVN6p5pfWxslv7E/d2ZaT+HamynyH+a5EIiOiPgo9C87LGWDv5ng+FlsGR+jYlsV3kB8d9TZru47GakxZZOf7gbUK9P+Bk8YSNBhbarHX7Lifrhsoz4NodLxJyx4js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711473701; c=relaxed/simple;
	bh=Y2psVmmKz1IVlz2128aKGOfPLJwSPX4Xp8L0iyNSHXg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WkxD6UD6C00107XOZId2QlYQYE3xJ9jVNB871yAg9Sf2dQtDlZYSXaaOpNBSxbADvDgYlj2EwlZnrD6FMW2ROWuk1hLqYOV39HexxTlydSSDzVyV+ssefY60Bp4nlSeSjp4eKIYvzpnWWzNnCu9H2yQ94DVtUnAa1tmthZgBSxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ria7CDjh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54CBDC433F1;
	Tue, 26 Mar 2024 17:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711473701;
	bh=Y2psVmmKz1IVlz2128aKGOfPLJwSPX4Xp8L0iyNSHXg=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=Ria7CDjhdCEvJpQdokB9O8PlgR9VLZJzLYOIlMZCdtpy7kjHFDktOj9wx9xxoIxjY
	 Drjm+nVZAgdaY/LGr7ruUXIkjlsrp+MCT24lwKVI5fyMgSiJGiVX/3MoF64X5SuZES
	 LJaIWm6SA+hlbHxL09dvBETD4pq7NjxebfMaRofF4gKa8HevLZlo+gR1TDyLQdMlcU
	 9W93oHL9OOu15RrBASTjhOxShjdWg55uEtbUWGPRQ2d0KtbdalOkugrFIbnqoK1tXm
	 O24REZM2D/HXGmqhqQ7U54aqz6CEHd3gKGjkEg8nZUtT6iPaxRYm0yhgrU8P7Nmet6
	 hqzlMflXAaDQw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 4B673CE129B; Tue, 26 Mar 2024 10:21:40 -0700 (PDT)
Date: Tue, 26 Mar 2024 10:21:40 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Johannes Berg <johannes@sipsolutions.net>, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Frederic Weisbecker <frederic@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Johannes Berg <johannes.berg@intel.com>
Subject: Re: [PATCH v2] rcu: mollify sparse with RCU guard
Message-ID: <df1ecb31-fed2-4069-93bf-8773f30842b2@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240325183907.7205bf36489a.Ic3ac66ff5d6a9bd8a610858060117e1364641a3f@changeid>
 <ZgG3UC-x8wAIOdd3@boqun-archlinux>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZgG3UC-x8wAIOdd3@boqun-archlinux>

On Mon, Mar 25, 2024 at 10:41:36AM -0700, Boqun Feng wrote:
> On Mon, Mar 25, 2024 at 06:39:08PM +0100, Johannes Berg wrote:
> > From: Johannes Berg <johannes.berg@intel.com>
> > 
> > When using "guard(rcu)();" sparse will complain, because even
> > though it now understands the cleanup attribute, it doesn't
> > evaluate the calls from it at function exit, and thus doesn't
> > count the context correctly.
> > 
> > Given that there's a conditional in the resulting code:
> > 
> >   static inline void class_rcu_destructor(class_rcu_t *_T)
> >   {
> >       if (_T->lock) {
> >           rcu_read_unlock();
> >       }
> >   }
> > 
> > it seems that even trying to teach sparse to evalulate the
> > cleanup attribute function it'd still be difficult to really
> > make it understand the full context here.
> > 
> > Suppress the sparse warning by just releasing the context in
> > the acquisition part of the function, after all we know it's
> > safe with the guard, that's the whole point of it.
> > 
> > Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> 
> Reviewed-by: Boqun Feng <boqun.feng@gmail.com>

Queued, thank you both!

							Thanx, Paul

> Regards,
> Boqun
> 
> > ---
> > v2: add a comment after discussion with Boqun
> > 
> > ---
> >  include/linux/rcupdate.h | 14 +++++++++++++-
> >  1 file changed, 13 insertions(+), 1 deletion(-)
> > 
> > diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
> > index 0746b1b0b663..6a3c52b3c180 100644
> > --- a/include/linux/rcupdate.h
> > +++ b/include/linux/rcupdate.h
> > @@ -1059,6 +1059,18 @@ rcu_head_after_call_rcu(struct rcu_head *rhp, rcu_callback_t f)
> >  extern int rcu_expedited;
> >  extern int rcu_normal;
> >  
> > -DEFINE_LOCK_GUARD_0(rcu, rcu_read_lock(), rcu_read_unlock())
> > +DEFINE_LOCK_GUARD_0(rcu,
> > +		    do {
> > +			rcu_read_lock();
> > +			/*
> > +			 * sparse doesn't call the cleanup function,
> > +			 * so just release immediately and don't track
> > +			 * the context. We don't need to anyway, since
> > +			 * the whole point of the guard is to not need
> > +			 * the explicit unlock.
> > +			 */
> > +			__release(RCU);
> > +		    } while(0),
> > +		    rcu_read_unlock())
> >  
> >  #endif /* __LINUX_RCUPDATE_H */
> > -- 
> > 2.44.0
> > 

