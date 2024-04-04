Return-Path: <linux-kernel+bounces-131709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44033898AF3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 17:21:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67F7E1C215B8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 15:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA7B8130A76;
	Thu,  4 Apr 2024 15:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="IIAlxcZt"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05FD017BA8
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 15:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712243883; cv=none; b=nGrB2nQSKHKCQuTzmKVQhRm7Sh6B3n1YyvdSP3cz4cGuuAhZpBjR0mvyhnKXh6KLTtHtF+9do1LJUO7BB0uV4JC1Ak8PFqGHZYDYfu0cm8doCVtLg+iEHN0ULtZuSyWQo87Q+j+3/UUcxHSpBZrdouZ8TVloHPYn3HIXnSKf1hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712243883; c=relaxed/simple;
	bh=5u0mSnGZq6U7j+Xqr+fOgVz1ptm7mdnI2G3ktaRuXPg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bgTa8BGCdtqp35z0+qepc5/Np9kU4oM1yFNkJiH60wBGL2hKAW+piKzGi/nqMAFjuRegJ3JMgF/yNiglV5P57tAk2qivZRhSv/z56gBH/Nwa5rv7uYbnDa6spJr570BaHM9lxOU9qWA1ZuWQG8Li3KS03AgbP09Q0wEoJ77Q2+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=IIAlxcZt; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-41551639550so8239105e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 08:18:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1712243879; x=1712848679; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7xlbw7xqSmZyIJHb4NJpbY67KK4cFZtrrJjprT99a7E=;
        b=IIAlxcZtGMqA8ytWme4dFl61qwLbpA8zVlEUQ0TuEleBVqBd0vOu0ykh9Cuy0HPcAk
         JC4i5Q3yu6yqximtg6xnH7QS635q8pARAYYoIISkytNhEKNqLpTM5ItkNPwYbgm3COhd
         HjWMYr5rNH5jEeiMGWOl3h0KhMsQlA8SLKVdWrJpp6YgyK7GM4FLvos2r86XjF3W0tiQ
         Qp4BbHBPYxZIJephpTimuHIQRDka9RF6NeOhj68RDm+LltsR5AzEFGa9rq0/RT9FfQKq
         puPphCXkeP5Ay3teKLLVrR+TFh50YEx5aGq0MQ3M6K0ODoPQ41EAH9ASAFYfMzrsnRPQ
         3auA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712243879; x=1712848679;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7xlbw7xqSmZyIJHb4NJpbY67KK4cFZtrrJjprT99a7E=;
        b=AbhsmsTT/eI6AuapjLaU6rMDu7DqqBTofTbrMRJAXSkl1M/taw9tDNfcFIDn+OMfyM
         i4sjQxlXl5QiTeiXYeQOKbu2D8zBy6TFBZ+zq/8ARIbkXyQ5qrad+qXCuMZWHNY9RGpO
         Iw7BGZZfyFlPOXQwiUpPE6LngljJ2ugkrx/OhNR5KepXTOdJjUaKOUcdcgiwcVqz3tX2
         gof1xzrbj3FsKOQXdNqL838Wa6fFoWwZDMue2Xo0M30B8DkxQDAMUozwXPdI9hEHZUbp
         PHqGrqHtocAYVljfnIjpEE5EK2fghwj/XOP3j1VzxTOzJtUykHlf8NCc1wNB0RxtE6Ag
         C3iw==
X-Forwarded-Encrypted: i=1; AJvYcCWSHU3p9vwdhMRxeyNh0VrNCAcILW3aA3RUBgCYCB6OHZYPb8mzbIu9/OtQ8j1J0TJZtAAgzPE+uVCYPA5NMxYjEy+Kzj/ee5eRqZkh
X-Gm-Message-State: AOJu0Yz52uEHszoCwVTIuVjE1MyJK+R9xBIRaCvd0GJrEXRDRQTjbK0Q
	4U39zz+GMRVpfKmvzwnlPaOH50OkPKoygA3NFvSVP1zTEitUo3lE8v/52YlZ914=
X-Google-Smtp-Source: AGHT+IH+z04jXguuPWkCkxWYOurzfVC5AL0YZP3gEFwfUoCOpVfzeJRZXXfb9vK4fmJXzZpHygrfmQ==
X-Received: by 2002:a05:600c:3016:b0:415:67ac:3245 with SMTP id j22-20020a05600c301600b0041567ac3245mr56070wmh.28.1712243879403;
        Thu, 04 Apr 2024 08:17:59 -0700 (PDT)
Received: from alley ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id fl13-20020a05600c0b8d00b004162ba5b46fsm1635932wmb.42.2024.04.04.08.17.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 08:17:59 -0700 (PDT)
Date: Thu, 4 Apr 2024 17:17:57 +0200
From: Petr Mladek <pmladek@suse.com>
To: Joe Lawrence <joe.lawrence@redhat.com>
Cc: zhangwarden@gmail.com, jpoimboe@kernel.org, mbenes@suse.cz,
	jikos@kernel.org, live-patching@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] livepatch: Add KLP_IDLE state
Message-ID: <Zg7EpZol5jB_gHH9@alley>
References: <20240402030954.97262-1-zhangwarden@gmail.com>
 <ZgwNn5+/Ryh05OOm@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZgwNn5+/Ryh05OOm@redhat.com>

On Tue 2024-04-02 09:52:31, Joe Lawrence wrote:
> On Tue, Apr 02, 2024 at 11:09:54AM +0800, zhangwarden@gmail.com wrote:
> > From: Wardenjohn <zhangwarden@gmail.com>
> > 
> > In livepatch, using KLP_UNDEFINED is seems to be confused.
> > When kernel is ready, livepatch is ready too, which state is
> > idle but not undefined. What's more, if one livepatch process
> > is finished, the klp state should be idle rather than undefined.
> > 
> > Therefore, using KLP_IDLE to replace KLP_UNDEFINED is much better
> > in reading and understanding.
> > ---
> >  include/linux/livepatch.h     |  1 +
> >  kernel/livepatch/patch.c      |  2 +-
> >  kernel/livepatch/transition.c | 24 ++++++++++++------------
> >  3 files changed, 14 insertions(+), 13 deletions(-)
> > 
> > diff --git a/include/linux/livepatch.h b/include/linux/livepatch.h
> > index 9b9b38e89563..c1c53cd5b227 100644
> > --- a/include/linux/livepatch.h
> > +++ b/include/linux/livepatch.h
> > @@ -19,6 +19,7 @@
> >  
> >  /* task patch states */
> >  #define KLP_UNDEFINED	-1
> > +#define KLP_IDLE       -1
> 
> Hi Wardenjohn,
> 
> Quick question, does this patch intend to:
> 
> - Completely replace KLP_UNDEFINED with KLP_IDLE
> - Introduce KLP_IDLE as an added, fourth potential state
> - Introduce KLP_IDLE as synonym of sorts for KLP_UNDEFINED under certain
>   conditions
> 
> I ask because this patch leaves KLP_UNDEFINED defined and used in other
> parts of the tree (ie, init/init_task.c), yet KLP_IDLE is added and
> continues to use the same -1 enumeration.

Having two names for the same state adds more harm than good.

Honestly, neither "task->patch_state == KLP_UNDEFINED" nor "KLP_IDLE"
make much sense.

The problem is in the variable name. It is not a state of a patch.
It is the state of the transition. The right solution would be
something like:

  klp_target_state -> klp_transition_target_state
  task->patch_state -> task->klp_transition_state
  KLP_UNKNOWN -> KLP_IDLE

But it would also require renaming:

  /proc/<pid>/patch_state -> klp_transition_state

which might break userspace tools => likely not acceptable.


My opinion:

It would be nice to clean this up but it does not look worth the
effort.

Best Regards,
Petr

