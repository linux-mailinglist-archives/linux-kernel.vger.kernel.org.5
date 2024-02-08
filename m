Return-Path: <linux-kernel+bounces-58346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DF7084E4F9
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 17:24:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 326A81C226DF
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 16:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60D0E7E59D;
	Thu,  8 Feb 2024 16:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="fDHBS8Ik"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E31763E9
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 16:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707409455; cv=none; b=N/2OsvV9QK8MjhJXPgoOvXLuIqKQlPhcZqmmWFjySh5wMqVuOwcqtPrt+u/Xd4LkxtnwXezhJKDNQDLkgEV0Yiu7GTNcns1Ouqhm23EmH0LQ/Fedzr4hpNeVQv+Tyj79h8wFWoUliURTA9TWVca/LBjmHDu43D86kSvaeauKTlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707409455; c=relaxed/simple;
	bh=mDgKDFsvIzRxs8kNu0fV7Mm+7XOwb4dOr95Y88h2hns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fkQ6QhiW6FyNYnYeHziY56pOonDS7kwBlsb2F8quncS4j2deRo+A4vEqUxhek3c+GKtrvAEsxeyl19oHUnOU2ANFHTZJIqRXI8SdcFsEyG2fmAWY5REz0qIhOfitDxhAA1HevuPWSFuzD0YmBf1sNK2MSArnhR5a2Uwd54Xk55g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=fDHBS8Ik; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a29c4bbb2f4so274197066b.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Feb 2024 08:24:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1707409449; x=1708014249; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dUj3OGsNRWWdIHw/r8I+PMckpHVn/MIoedR4J0AfVJ0=;
        b=fDHBS8IkFxR4cqrUjerWeQQTgKy8SppqiGl0Z9NSZEDzSSUb5mAjnsietjlQlw3lKM
         hrc2zsbnK6vp3i0rr86gwuvd3yfDCnkzLQzd0rjWBD6Q+4XFU6Vm7WizG9LMVrG9Gzdv
         MX18HJf22ZLbxQwzbPEZFCiwhd6noz3EaOlz27wJoTyDAIKICXs4EV+E1b9npbxYYdGD
         ASw7/6Vvd2KcIFYaMYYHxD6R0+77CHHPFjHU/VUci26GJF5BFUqjtO5+kbWRmSHA4QnJ
         a36jjPCclSq0/MUbTs3xciQ43XrQvoV+m4kQiA9QmhefbVAOA8q/w6OVFhjbQmCZmQKi
         lyNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707409449; x=1708014249;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dUj3OGsNRWWdIHw/r8I+PMckpHVn/MIoedR4J0AfVJ0=;
        b=QqywxEVISGgue3RRQIvU85NaM9Ip+7qAHb4Tvtm7LQ0pZPloPnLTpTG1c75pQf//z4
         pYJe8UUvewHOhKYP2LcL+AgrQSx9KIFUk9RcLEQpCciMRkrvS+BapVxwzi2y3dPKo8P7
         rqiOmZM/N0JhjGV3+bmxRxkwdxwGR5h43RkQSVffNB5xg5oEaC5tjP1/TP0iORfpjB2Q
         lZeQKl1MEId2n69ruBm6h0M27o8oR9bGMwmsFdt1Yu+tBmZtSJnC5P0SelyktJvdxxa0
         c/3B1k6Asj/BpKD8N9rusyN9beEXrkx/56VGwNX2nhzhduWGbSO6BKp7Rub/z7x3wZT+
         I8FA==
X-Gm-Message-State: AOJu0YzkDP2nvjRhfiRGDSw/nl8NsQSPMbDsEPAF6A0YhZGrrdNnXbg4
	0tX69myGtO0YALhpwyKUjn1b5AJl9MnB3MXKkJlwQ/5R3hDr9UyDzQOfS47nLsk=
X-Google-Smtp-Source: AGHT+IF7s13a6XM9QT2+cD+JFrastWF1CNrt9w1debgG4B7c/Y5AUf4dil3GcDG2LyOd/TxHBMq+gg==
X-Received: by 2002:a17:906:be9:b0:a36:6198:3505 with SMTP id z9-20020a1709060be900b00a3661983505mr6833269ejg.25.1707409449402;
        Thu, 08 Feb 2024 08:24:09 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX3axDNWzksmQMwAlkfrX+vSv4edGdWLY14hQ+nOMS3SN6zQoilLnFuKIacjMvVx7tQqdaanoJYM9JeU3wV6QBQbOHgKMNtAFJNAGrmFqv55DiWou4GB0M/FVENwAjVoY1fjOogII7LtU/sRIDeTiRSXReAqedPkRE2GVoKpwo1CAYjScFq1uHSogrvzAj7HNW5PjkMBkDSA2ULGyyyJxstYUFGJ5qpUt2rdpwXVyd4uO5TBFjUFaMdg3KAaDotYaprrdtqo9erPZIvxegbMhPZ0WVEOdS57AsDeTQg6DP/2VafHu4wakp2keb99IV222nm0GQP0QHS+XabXVZ1YRd6LYWF0hd2xidKnSWegFZS08gdxA6Rh4DtI8yxyfKFTTUBmkts1LTx5vALHnDSqkWFqtvzI30ii8oUUD4V
Received: from alley ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id lf21-20020a170906ae5500b00a388c12dee6sm209249ejb.82.2024.02.08.08.24.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 08:24:09 -0800 (PST)
Date: Thu, 8 Feb 2024 17:24:02 +0100
From: Petr Mladek <pmladek@suse.com>
To: Lee Jones <lee@kernel.org>
Cc: Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
	David Laight <David.Laight@aculab.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Crutcher Dunnavant <crutcher+kernel@datastacks.com>,
	Juergen Quade <quade@hsnr.de>
Subject: Re: [PATCH 1/1] lib/vsprintf: Implement ssprintf() to catch
 truncated strings
Message-ID: <ZcUAIqnA_SJN0Clg@alley>
References: <20240125083921.1312709-1-lee@kernel.org>
 <a37e8071-32ac-4f5d-95e8-ddd2eb21edcd@rasmusvillemoes.dk>
 <20240125103624.GC74950@google.com>
 <54e518b6dd9647c1add38b706eccbb4b@AcuMS.aculab.com>
 <20240129092440.GA1708181@google.com>
 <7054dcbfb7214665afedaea93ce4dbad@AcuMS.aculab.com>
 <20240129095237.GC1708181@google.com>
 <20240130150721.GA692144@google.com>
 <79921f9a-2453-48ec-85db-e63a0958db1e@prevas.dk>
 <20240130155336.GA8551@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240130155336.GA8551@google.com>

On Tue 2024-01-30 15:53:36, Lee Jones wrote:
> On Tue, 30 Jan 2024, Rasmus Villemoes wrote:
> > On 30/01/2024 16.07, Lee Jones wrote:
> > > On Mon, 29 Jan 2024, Lee Jones wrote:
> > >> On Mon, 29 Jan 2024, David Laight wrote:
> > >>>> snprintf() does this and has been proven to cause buffer-overflows.
> > >>>> There have been multiple articles authored describing why using
> > >>>> snprintf() is not generally a good idea for the masses including the 2
> > >>>> linked in the commit message:
> > >>>
> > >>> snprintf() returns the number of bytes that would have been output [1].
>
> > > Okay, I've written a bunch of simple test cases and results are
> > > positive.  It seems to achieve my aim whilst minimising any potential
> > > pitfalls.
> > > 
> > >  - Success returns Bytes actually written - no functional change
> > >  - Overflow returns the size of the buffer - which makes the result
> > >    a) testable for overflow
> > >    b) non-catastrophic if accidentally used to manipulate later sizes
> > 
> > You are describing scnprintf(), which almost does exactly that. The last
> > thing we need is another interface with almost identical semantics.
> 
> It does, which is why when I first centred my efforts on this task the
> plan was to simply switch to it.  However, as I described in the commit
> message:
> 
>   "Whist executing the task, it quickly became apparent that the initial
>   thought of simply s/snprintf/scnprintf/ wasn't going to be adequate
>   for a number of cases.  Specifically ones where the caller needs to
>   know whether the given string ends up being truncated."
> 
> A great deal of callers want to know if the string they attempted to
> form was successful.  A malformed string would lead to oddities in the
> best cases and various device/probing/matching failures in the worst.
> 
> > >     int size = 10;
> > >     char buf[size];
> > >     char *b = buf;
> > > 
> > >     ret = spprintf(b, size, "1234");
> > >     size -= ret;
> > >     b += ret;
> > >     // ret = 4  size = 6  buf = "1234\0"
> > > 
> > >     ret = spprintf(b, size, "5678");
> > >     size -= ret;
> > >     b += ret;
> > >     // ret = 4  size = 2  buf = "12345678\0"
> > > 
> > >     ret = spprintf(b, size, "9***");
> > >     size -= ret;
> > >     b += ret;
> > >     // ret = 2  size = 0  buf = "123456789\0"
> > 
> > So here scnprint() would have returned 1, leaving size at 1. scnprintf()
> > has the invariant that, for non-zero size, the return value is strictly
> > less than that size, so when passed a size of 1, all subsequent calls
> > return 0 (corresponding to the fact that all it could do was to write
> > the '\0' terminator).
> > 
> > This pattern already exists, and is really the reason scnprint exists.
> > Yes, scnprintf() cannot distinguish overflow from
> > it-just-exactly-fitted. Maybe it would have been better to make it work
> > like this, but I don't think there's a real use
> 
> There are real use-cases.  They are what brought me here.
>
> > and we do have
> > seq_buf() if one really wants an interface that can build a string
> > piece-meal while keeping track of whether it ever caused overflow.
> 
> seq_buf_*() looks okay, but it's petty heavy requiring what looks like
> the buffers to be initialised with an API call before use.  We're
> looking for something more light weight.
> 
> scnprint() had clear safety centric improvements over snprintf() and
> spprintf() adds an additional layer of return value checking on top of
> that.
> 
> I'm not sure I understand the resistance to something which is needed
> and has clear benefits over what presently exists just for the sake of a
> few lines of code.  I'd be on board if it were change for the sake of
> change, but the added flexibility and ease of use is evident.

My view is the following:

First, I agree that snprintf() is dangerous and should be replaced.

I think that the resistance is because:

  + ssprintf() has its danger as well. You wrote [1] that
    "Under-running the buffer is no worse over-running". But it is
    no better either.

  + More APIs might create more confusion and increase the risk of
    a misuse.

  + spprintf() does not allow to detect truncated string. It means
    that it does not provide any advantage over the existing scnprintf().

So, if we could solve it another way then it might be better.


That said, people tend to look how an API is used instead of RTFM.
They copy good or bad patterns. There is even a term for this
but I can't remember it new.

So, if we introduce a new API and provide some good examples
then there is a good chance that people will continue using
it correctly. And it even might be checked more easily.

There is a similarity with alloc() APIs. Good (most) programmers
know that they need to check kalloc() return value. They might
also learn that they need to check also return value from
ssnprintf() of how we call it. Especially, when we provide
good examples from the very beginning. Also it might
be checked by Coccinelle.


Finally, if you eventually send a new version of a string API
then please add Linus into Cc. He has huge experience and very
good feeling for what is good and what is wrong. And he
is interested into exactly these types of APIs.


[1] https://lore.kernel.org/r/20240129092440.GA1708181@google.com

Best Regards,
Petr

