Return-Path: <linux-kernel+bounces-38400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C79883BF07
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 11:37:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E1A7B2A859
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 10:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E806D1CD00;
	Thu, 25 Jan 2024 10:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jkEu5Tph"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3562832C60;
	Thu, 25 Jan 2024 10:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706178991; cv=none; b=jLdqIqnxLqCoEwDypuOOt2vGlqHs480tgNc51S/53Jkc2zMBqzSGqzIk4pabxmOkBCaDJMeCXzv1GhWG55cb8xEASiBn2xh8gCmMx3mV12RCGHHcSHu+Sf+NHFEeSvuMPVQ8Jzj1esOqWgCinD/MJWg9+OyWYEiQhcHAbR2DI5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706178991; c=relaxed/simple;
	bh=RYngMZoEzsFVQfzATY40EOP/Ghyf3Ecc4V9vxdhnAHg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sr+N68TvW/KMP3KWuvYwGEBtUYwR9apRRHkFK08gKh6dY0B5cs+iQp7bivhG5tr2JuN2KzFFN9K+EIz8xubg46VjwEwDIaIURXlgzbPufLyszQ5jhhLyOGrs0RInYmq+QW088qBP0UEPPvDruDJbOc3YE2zoCQoYZslcCB+9kKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jkEu5Tph; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2E9BC433F1;
	Thu, 25 Jan 2024 10:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706178990;
	bh=RYngMZoEzsFVQfzATY40EOP/Ghyf3Ecc4V9vxdhnAHg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jkEu5TphxlQN5VjN5SBeWzbjSDdHcvImdqX3TSsEbYaxEWiyswL609etipf9SWqHp
	 r/WkdtU6/oce5njRbuD3cuKINHRMa9ifraLwB0iHnn4/nW5SXm02hHzCEsBja1q2YS
	 dPg2fONSG9kbr3YzNjssF0HcFOnbceSJmXrgQORtIUkGfSVIrVFLFT+9C863fMF+kM
	 qRbBaYDbie6t0ZHOeCQAJkUX/zx7FqnYBzro4HZJHriUJ7BARMtfCcps+dgIKHEwhB
	 hpulw473CjrObtAoT0Dri0fPfmAZ5MnSVtpvbsnq2pC/iTMEiYeegQFhpIET4ZTYPk
	 Tjeq7paTfb0Vg==
Date: Thu, 25 Jan 2024 10:36:24 +0000
From: Lee Jones <lee@kernel.org>
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Crutcher Dunnavant <crutcher+kernel@datastacks.com>,
	Juergen Quade <quade@hsnr.de>
Subject: Re: [PATCH 1/1] lib/vsprintf: Implement ssprintf() to catch
 truncated strings
Message-ID: <20240125103624.GC74950@google.com>
References: <20240125083921.1312709-1-lee@kernel.org>
 <a37e8071-32ac-4f5d-95e8-ddd2eb21edcd@rasmusvillemoes.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a37e8071-32ac-4f5d-95e8-ddd2eb21edcd@rasmusvillemoes.dk>

On Thu, 25 Jan 2024, Rasmus Villemoes wrote:

> On 25/01/2024 09.39, Lee Jones wrote:
> > There is an ongoing effort to replace the use of {v}snprintf() variants
> > with safer alternatives - for a more in depth view, see Jon's write-up
> > on LWN [0] and/or Alex's on the Kernel Self Protection Project [1].
> > 
> > Whist executing the task, it quickly became apparent that the initial
> > thought of simply s/snprintf/scnprintf/ wasn't going to be adequate for
> > a number of cases.  Specifically ones where the caller needs to know
> > whether the given string ends up being truncated.  This is where
> > ssprintf() [based on similar semantics of strscpy()] comes in, since it
> > takes the best parts of both of the aforementioned variants.  It has the
> > testability of truncation of snprintf() and returns the number of Bytes
> > *actually* written, similar to scnprintf(), making it a very programmer
> > friendly alternative.
> > 
> > Here's some examples to show the differences:
> > 
> >   Success: No truncation - all 9 Bytes successfully written to the buffer
> > 
> >     ret = snprintf (buf, 10, "%s", "123456789");  // ret = 9
> >     ret = scnprintf(buf, 10, "%s", "123456789");  // ret = 9
> >     ret = ssprintf (buf, 10, "%s", "123456789");  // ret = 9
> > 
> >   Failure: Truncation - only 9 of 10 Bytes written; '-' is truncated
> > 
> >     ret = snprintf (buf, 10, "%s", "123456789-"); // ret = 10
> > 
> >       Reports: "10 Bytes would have been written if buf was large enough"
> >       Issue: Programmers need to know/remember to check ret against "10"
> 
> Yeah, so I'm not at all sure we need yet-another-wrapper with
> yet-another-hard-to-read-prefix when people can just RTFM and learn how
> to check for truncation or whatnot. But if you do this:

As wonderful as it would be for people to "just RTFM", we're seeing a
large number of cases where this isn't happening.  Providing a more
programmer friendly way is thought, by people way smarter than me, to be
a solid means to solve this issue.  Please also see Kees Cook's related
work to remove strlcpy() use.

> > +/**
> > + * vssprintf - Format a string and place it in a buffer
> > + * @buf: The buffer to place the result into
> > + * @size: The size of the buffer, including the trailing null space
> > + * @fmt: The format string to use
> > + * @args: Arguments for the format string
> > + *
> > + * The return value is the number of characters which have been written into
> > + * the @buf not including the trailing '\0' or -E2BIG if the string was
> > + * truncated. If @size is == 0 the function returns 0.
> > + *
> > + * If you're not already dealing with a va_list consider using ssprintf().
> > + *
> > + * See the vsnprintf() documentation for format string extensions over C99.
> > + */
> > +int vssprintf(char *buf, size_t size, const char *fmt, va_list args)
> > +{
> > +	int i;
> > +
> > +	if (unlikely(!size))
> > +		return 0;
> 
> No, don't special-case size 0 here. Passing size==0 should just
> guarantee -E2BIG because that's essentially a programmer error, and the
> calling code is then at least much more likely to not believe that buf
> now contains a nul-terminated (empty) string.
> 
> And since it's essentially a bug, there's no need to special-case size 0
> to avoid calling vsnprintf(), just let it be caught by the i >= size check.

Agree.  Thanks for the feedback.  I will change this.

> > +	i = vsnprintf(buf, size, fmt, args);
> > +
> > +	if (unlikely(i >= size))
> > +		return -E2BIG;
> > +
> > +	if (likely(i < size))
> > +		return i;
> 
> Those two ifs are mutually exclusive, so why the second if() and not
> just a direct "return i"? That final "return size-1" is unreachable, and
> confusing.

That's true.  The last line of vscnprintf() essentially means that the
data was truncated, which is caught by the new check.  So it should be
reworked to look like this:

```
  if (likely(i < size))
          return i;

  return -E2BIG;
```

Thanks again.  That's very helpful.

-- 
Lee Jones [李琼斯]

