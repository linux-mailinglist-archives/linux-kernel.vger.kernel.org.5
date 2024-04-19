Return-Path: <linux-kernel+bounces-151991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D37738AB712
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 00:06:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89EE51F21123
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 22:06:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BCC713D277;
	Fri, 19 Apr 2024 22:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TCxnuC75"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 525C112DD97
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 22:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713564402; cv=none; b=rsB5u7XMACVCH+wm/s7Jl5VsBxlXz6QtPGed1WMLUg6tt1nGX7vrQY44NAjNL8ulV+pR8K/Ka8njXgKtW/+zj0OCXMIaoifFOzb+kpAsOliJFOFF1a3MToRAMIIg9BPvg+ZVhwjSpq29ItYb7s3+8EufE9mvtq55gUomWTTsxzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713564402; c=relaxed/simple;
	bh=HeT9nhhIMYBtkKPJip1Kr/IHxznmegsRPe83L4lJCPY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y28Tt7Qgul/BRBgzy2buRozdmWFVL2o1LVeZCuF5RcAEFni2v9otHDktQZuhN+9Ynyca5JXin6b9M3RqARhv68dwOy9XJlvTTp1sG5PV9uzne0jxj99r6fo4riKKQOdRaFlWrGuFKR/uirsFjcAG/ApCZjuyPKOrewM1jaF50lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=TCxnuC75; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6eff9dc1821so2679253b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 15:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1713564400; x=1714169200; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SnHpohGprJrLzOXpBs7R+B8zUZeUsKWVGPy1iJRIl2k=;
        b=TCxnuC75/8Q4dyjsYeIYpQ3yCszm6WdWKkmPMFU3uTwtvro0wWICjW0RxxndDrFwgi
         VgmSgJNT9dQhKP4MREc09lRPMk/6CmU0FTY9CnRnnlCRq/ouLb+B76QYuSm21IC0tOf6
         CgLjRJjmchjTfL5XZ9Bv3qmplBrRa0ELaTpiY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713564400; x=1714169200;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SnHpohGprJrLzOXpBs7R+B8zUZeUsKWVGPy1iJRIl2k=;
        b=MNaLoXv8OQrNMMEcimK8+1j0q8xmbdILJWKkQ4jm2zEK1W22IKjpZHwWr3YbjSLfmx
         P3W5z19k05HGs4AIWyn/gYXWB/4z3Gl0Baa+sskATFgRVW1yX452TSjCs74U6MBlurmk
         4IKDPYhxZ7ihwBzgSRQ5H1bNhGzE/MJj9DvzzEt0zgdtVfDpQzy2sdn+Dl+ZDf95xeol
         kgJpj8zmm8PZtL25LcT6yLYuSUIuVZTvqdzkI8Y0Cp/+KR3mctBxYgbg0VQ7MXIA6FuL
         vUTzW7O02spPqhCUUHXw2q8y5g4TKMqmU0Gqk7buMbAKtwIzK8SqwOAM5gdWRl9b5LLp
         qRaA==
X-Forwarded-Encrypted: i=1; AJvYcCV6h6dMQLN1qMUP/F8nG5DcH52Y3nMU6rvqS2TLcAtki6RwBWPQd1EVWVrYaE+Le75iYax122iZ/07gB4i1VcIHQYZnqbVOiK3VOEst
X-Gm-Message-State: AOJu0YwR0bUyqKZE5HIBthm3wBjd0ikRPA3QBopykfJSK4F6oFx+ocC5
	W6AV+ohtkWo0hP9NsPeY+a6Jyt2d0TyS0qtPM/o5/BZmU0FPjNZOtR25P13Cpg==
X-Google-Smtp-Source: AGHT+IH1Pkisx80b5t24X2ImtRqmySWcV0DaxKzxf/v+MWxsgRhyCUvPxlo3v1fniPHvqeKc00XqhA==
X-Received: by 2002:a05:6a00:1487:b0:6ea:c04c:a899 with SMTP id v7-20020a056a00148700b006eac04ca899mr4461837pfu.20.1713564400565;
        Fri, 19 Apr 2024 15:06:40 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id bm5-20020a056a00320500b006ecf3e302ffsm3851578pfb.174.2024.04.19.15.06.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 15:06:39 -0700 (PDT)
Date: Fri, 19 Apr 2024 15:06:39 -0700
From: Kees Cook <keescook@chromium.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/19] Enable -Wshadow=local for kernel/sched
Message-ID: <202404191458.17308A48D4@keescook>
References: <20220302043451.2441320-1-willy@infradead.org>
 <202404161413.8B4810C5@keescook>
 <CAHk-=wg7+dfpEvDnTnB-eR9QRZ2VySbxOEHbYqL3Ai5wwkon5Q@mail.gmail.com>
 <Zh8dTOZ_YxeGhp-L@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zh8dTOZ_YxeGhp-L@casper.infradead.org>

On Wed, Apr 17, 2024 at 01:52:28AM +0100, Matthew Wilcox wrote:
> On Tue, Apr 16, 2024 at 05:29:02PM -0700, Linus Torvalds wrote:
> > On Tue, 16 Apr 2024 at 14:15, Kees Cook <keescook@chromium.org> wrote:
> > >
> > > I was looking at -Wshadow=local again, and remembered this series. It
> > > sounded like things were close, but a tweak was needed. What would be
> > > next to get this working?
> > 
> > So what is the solution to
> > 
> >     #define MAX(a,b) ({ \
> >         typeof(a) __a = (a); \
> >         typeof(b) __b = (b); \
> >         __a > __b ? __a : __b; \
> >     })
> 
> #define __MAX(a, __a, b, __b) ({	\
> 	typeof(a) __a = (a);		\
> 	typeof(b) __b = (b);		\
> 	__a > __b ? __a : __b;		\
> })
> 
> #define MAX(a, b)	__MAX(a, UNIQUE_ID(a), b, UNIQUE_ID(b))

Yup, this is what we've had for a long time now. See
include/linux/minmax.h

> At least, I think that was the plan.  This was two years ago and I've
> mostly forgotten.
> 
> >     int test(int a, int b, int c)
> >     {
> >         return MAX(a, MAX(b,c));
> >     }
> > 
> > where -Wshadow=all causes insane warnings that are bogus garbage?
> > 
> > Honestly, Willy's patch-series is a hack to avoid this kind of very
> > natural nested macro pattern.
> > 
> > But it's a horrible hack, and it does it by making the code actively worse.
> > 
> > Here's the deal: if we can't handle somethng like the above without
> > warning, -Wshadow isn't getting enabled.
> > 
> > Because we don't write worse code because of bad warnings.
> > 
> > IOW, what is the sane way to just say "this variable can shadow the
> > use site, and it's fine"?
> > 
> > Without that kind of out, I don't think -Wshadow=local is workable.

This isn't a hill I want to die on, but it's just another case where
we've fought bugs more than once that would have stood out immediately
if we had -Wshadow=local enabled, but there is basically only 1 user. In
my bug-fighting calculus, it makes sense to deal with fixing the 1 user
so we can gain the coverage everywhere else.

But there are much worse bug sources, so if Willy's series isn't
workable, I'll drop this again for now. :)

-Kees


-- 
Kees Cook

