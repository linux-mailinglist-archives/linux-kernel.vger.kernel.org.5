Return-Path: <linux-kernel+bounces-89226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20E5986ECF6
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 00:34:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFD112831A2
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 23:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B165D5EE97;
	Fri,  1 Mar 2024 23:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="pWhTjipz"
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 524435EE8F
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 23:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709336038; cv=none; b=nINtwFtKinq1794XCNJupQNv31R0g6v/BMrre96Ia4pBf6M+QsB1NyRRs/1eTA92ArvL7pzRhpGQkSZfN/3QgmFROiUbzIyxaxwxIlCqLVro1tq2rI4iXqAlQ+LPfTJkVwnRRi8dCrOpWyP8iqnplqk+Wgi1S+cpTIQuQDww2IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709336038; c=relaxed/simple;
	bh=9ko6RFqUjrBXAVmwG8bBIF/XzRTNQIzqqVxM4hdGHTw=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q/KNbXJCS5na1cTI3SQIRBi+7v+sGiULKnVFvB05jBwwR0LdV5Z7ZLDuHCq2bUfv3WKsyms3tGsSo9qB5zafTQEY9/uv1XqDyLkKi26lZnR4ilgD6vYuK39EeKBbIGAjYb9+lARoGUKcO3HVJwRlzsxz9soQK7TVdmCGxBi1n0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=pWhTjipz; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-7c81e087882so42537939f.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2024 15:33:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1709336036; x=1709940836; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=vs9jOV2wHjO0L90PYhH0rLhwCoykJcsupCw1nSbLUFU=;
        b=pWhTjipzFoWOvhe6dr4blyoln8xuiTP/Y4IIJ8Yy6Z2pPUYAG+BOFQR2KPqVwd+bJ+
         Wj6GF8dKbcNkxjp6IliZdBPUBTvIlDxoutkldrGAtTC5auM8W/M1BiFwIBUO0XUz0/Fr
         pvzu4YfPFK5WvciNVPk5mPo+5wODJRQQxdAik=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709336036; x=1709940836;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vs9jOV2wHjO0L90PYhH0rLhwCoykJcsupCw1nSbLUFU=;
        b=V4rRDQqEksiKMdpCtdArYbECZ4xIapEwuEyDdxhFedokS9tVFs7Ofw9ioHpto1F+84
         qnlkNds6g40dMzGLKP/8PVcjBqjM+st6J6plNhPL/lAXvxC51QkYttbt8qbjFJGM4jA/
         xcyNRyztWruguaZ1fTn2pbI4xT755xLXpRo95TLkXKNwF7CzjXWxZ776VyCOXqYDDkIG
         Or3iHBHYO6hrQpFzddMZ1UoVOoR+gFAFzLVfqPX+HhE4kDMBjMiOXgKRLTen7ISoKOMr
         W/TRiIxN/c7c3lZJg8dYrcB41zQEZr/GOL0+mtYANGjE74qb/4c8tbN7V54niKCpv5pa
         6w7w==
X-Forwarded-Encrypted: i=1; AJvYcCU5PXsVzxo/8xfbQmLSlnBBCuu/gGAkfy2HmwDN0xuJScifj8MuzpzX01iaevjqM9jS3v2qzOvkc5XXhyT6uDV2yYg5GPse28pVtESa
X-Gm-Message-State: AOJu0YyX6SxZXy8+hx38hZ78nWn2Xbynj3GyAGaNhwVCh6lxvEZy8jSa
	oG1uV1erX0HMypCXzl/9w2CFcfSNbgXbzir/z0Yuqm0WrejQNZf+2CNoFPf8g74=
X-Google-Smtp-Source: AGHT+IFtZffyiQu2T3rPBJ+IXhjJLNO7avqnppjR7kYb1XNvOIzf+PEZs/3FOOmbtq5K8NoK2LcG2Q==
X-Received: by 2002:a05:6e02:1b83:b0:365:88b:3fc2 with SMTP id h3-20020a056e021b8300b00365088b3fc2mr2154224ili.4.1709336036317;
        Fri, 01 Mar 2024 15:33:56 -0800 (PST)
Received: from localhost ([91.196.69.76])
        by smtp.gmail.com with ESMTPSA id a26-20020a056638005a00b00474d1d7b244sm401925jap.93.2024.03.01.15.33.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 15:33:55 -0800 (PST)
Message-ID: <65e265e3.050a0220.7044b.19ad@mx.google.com>
X-Google-Original-Message-ID: <20240301233352.GA1005526@JoelBox.>
Date: Fri, 1 Mar 2024 18:33:52 -0500
From: Joel Fernandes <joel@joelfernandes.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Ankur Arora <ankur.a.arora@oracle.com>, linux-kernel@vger.kernel.org,
	tglx@linutronix.de, peterz@infradead.org,
	torvalds@linux-foundation.org, paulmck@kernel.org,
	akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
	dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	willy@infradead.org, mgorman@suse.de, jpoimboe@kernel.org,
	mark.rutland@arm.com, jgross@suse.com, andrew.cooper3@citrix.com,
	bristot@kernel.org, mathieu.desnoyers@efficios.com,
	geert@linux-m68k.org, glaubitz@physik.fu-berlin.de,
	anton.ivanov@cambridgegreys.com, mattst88@gmail.com,
	krypton@ulrich-teichert.org, David.Laight@aculab.com,
	richard@nod.at, mjguzik@gmail.com, jon.grimm@amd.com,
	bharata@amd.com, raghavendra.kt@amd.com, boris.ostrovsky@oracle.com,
	konrad.wilk@oracle.com, Masami Hiramatsu <mhiramat@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH 29/30] Documentation: tracing: add TIF_NEED_RESCHED_LAZY
References: <20240213055554.1802415-1-ankur.a.arora@oracle.com>
 <20240213055554.1802415-30-ankur.a.arora@oracle.com>
 <20240221164334.6f8c69e8@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240221164334.6f8c69e8@gandalf.local.home>

On Wed, Feb 21, 2024 at 04:43:34PM -0500, Steven Rostedt wrote:
> On Mon, 12 Feb 2024 21:55:53 -0800
> Ankur Arora <ankur.a.arora@oracle.com> wrote:
> 
> > Document various combinations of resched flags.
> > 
> > Cc: Steven Rostedt <rostedt@goodmis.org>
> > Cc: Masami Hiramatsu <mhiramat@kernel.org>
> > Cc: Jonathan Corbet <corbet@lwn.net>
> > Originally-by: Thomas Gleixner <tglx@linutronix.de>
> > Link: https://lore.kernel.org/lkml/87jzshhexi.ffs@tglx/
> > Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
> > ---
> >  Documentation/trace/ftrace.rst | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/trace/ftrace.rst b/Documentation/trace/ftrace.rst
> > index 7e7b8ec17934..7f20c0bae009 100644
> > --- a/Documentation/trace/ftrace.rst
> > +++ b/Documentation/trace/ftrace.rst
> > @@ -1036,8 +1036,12 @@ explains which is which.
> >  		be printed here.
> >  
> >    need-resched:
> > -	- 'N' both TIF_NEED_RESCHED and PREEMPT_NEED_RESCHED is set,
> > +	- 'B' all three, TIF_NEED_RESCHED, TIF_NEED_RESCHED_LAZY and PREEMPT_NEED_RESCHED are set,
> > +	- 'N' both TIF_NEED_RESCHED and PREEMPT_NEED_RESCHED are set,
> > +	- 'L' both TIF_NEED_RESCHED_LAZY and PREEMPT_NEED_RESCHED are set,
> > +	- 'b' both TIF_NEED_RESCHED and TIF_NEED_RESCHED_LAZY are set,
> >  	- 'n' only TIF_NEED_RESCHED is set,
> > +	- 'l' only TIF_NEED_RESCHED_LAZY is set,
> >  	- 'p' only PREEMPT_NEED_RESCHED is set,

One thing I was curious about in current code, under which situation will
"only PREEMPT_NEED_RESCHED is set" case happen? All the code paths I see set
the PREEMPT_NEED_RESCHED when then TIF has already been set. That kind of
makes sense, why enter the scheduler on preempt_enable() unless there was a
reason to, and TIF should have recorded that reason.

So in other words, if 'p' above cannot happen, then it could be removed as a
potential need-resched stat. If it can happen, I'd love to learn in which
case?

Also considering all users of set_tsk_need_resched() also call the
set_preempt_need_resched() shortly after, should we add a helper to squash
the 2 calls and simplify callers?

There are some "special cases" where only TIF flag need be set (such as setting
rescheduling from an interrupt or when rescheduling a remote CPU). For those,
they can directly call the set_tsk_need_resched() like they do now.

thanks,

 - Joel




