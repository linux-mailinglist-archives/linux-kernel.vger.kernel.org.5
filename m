Return-Path: <linux-kernel+bounces-108269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1643880897
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 01:35:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 923CDB21A22
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 00:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E314EBE;
	Wed, 20 Mar 2024 00:34:55 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1983629;
	Wed, 20 Mar 2024 00:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710894894; cv=none; b=KLgDWcNnxb6x98QQZw6OfYLPpyh8D36uyPctmgTEEJAYJlGKEvkuzgR0RsVsUNisesPISXRz76H/oXw6XdTQArUxN3M6jpQl0M1Oy+TClzZocKGaL7erTGEloahmjmaCXjADCL6X8/oUqm846smjTSdc3aySjv6569VkYyc6VG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710894894; c=relaxed/simple;
	bh=ZjyLvlOBSSMgSQbTO2EhcxGH7IpxIDHqTWIIUav4yGg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OYmpz7D5Lo1Vhkd8Bh0lHiHsVZYtympRVprw2vT2LZPvZSuYPkfCXHtSYzWbilooNHRRB4qO1DPb+xT+6e+hlWDWEA8wg5eNljLBiqI5UldCRYYQrmGiOScDMbYt2TGCDkRSqkohflHAD1CMo3y8cEHbHpp+c+JHzdawnSo3aww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ED74C433C7;
	Wed, 20 Mar 2024 00:34:52 +0000 (UTC)
Date: Tue, 19 Mar 2024 20:37:16 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Justin Stitt <justinstitt@google.com>
Cc: Nathan Chancellor <nathan@kernel.org>, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, ndesaulniers@google.com, morbo@google.com,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 llvm@lists.linux.dev, patches@lists.linux.dev, Linux Kernel Functional
 Testing <lkft@linaro.org>
Subject: Re: [PATCH 2/2] tracing: Ignore -Wstring-compare with diagnostic
 macros
Message-ID: <20240319203716.208c9b29@gandalf.local.home>
In-Reply-To: <CAFhGd8q_4QfjPwGhtfOA40ZGNF7_wf3V43rAvcb_qXQnz1TFOw@mail.gmail.com>
References: <20240319-tracing-fully-silence-wstring-compare-v1-0-81adb44403f5@kernel.org>
	<20240319-tracing-fully-silence-wstring-compare-v1-2-81adb44403f5@kernel.org>
	<CAFhGd8q_4QfjPwGhtfOA40ZGNF7_wf3V43rAvcb_qXQnz1TFOw@mail.gmail.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 19 Mar 2024 17:30:41 -0700
Justin Stitt <justinstitt@google.com> wrote:


> > diff --git a/include/trace/stages/stage6_event_callback.h b/include/trace/stages/stage6_event_callback.h
> > index 83da83a0c14f..56a4eea5a48e 100644
> > --- a/include/trace/stages/stage6_event_callback.h
> > +++ b/include/trace/stages/stage6_event_callback.h
> > @@ -35,9 +35,14 @@
> >         do {                                                            \
> >                 char *__str__ = __get_str(dst);                         \
> >                 int __len__ = __get_dynamic_array_len(dst) - 1;         \
> > +               __diag_push();                                          \
> > +               __diag_ignore(clang, 11, "-Wstring-compare",            \
> > +                             "__builtin_constant_p() ensures strcmp()" \
> > +                             "will be used for string literals");      \
> >                 WARN_ON_ONCE(__builtin_constant_p(src) ?                \
> >                              strcmp((src), __data_offsets.dst##_ptr_) : \
> >                              (src) != __data_offsets.dst##_ptr_);       \  
> 
> What exactly is the point of the literal string comparison? Why
> doesn't strcmp do the trick?

This is done in the hotpath, and is only for debugging. The string passed
into __string() should be the same as the string passed into __assign_str().

But this is moot as I ended up always using strcmp() even if it will slow
down the recording of the event.

Next merge window the src parameter (along with the strcmp() checks) are
going away.

-- Steve


> 
> > +               __diag_pop();                                           \
> >                 memcpy(__str__, __data_offsets.dst##_ptr_ ? :           \
> >                        EVENT_NULL_STR, __len__);                        \
> >                 __str__[__len__] = '\0';                                \
> >
> > --
> > 2.44.0
> >  


