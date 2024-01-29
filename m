Return-Path: <linux-kernel+bounces-42435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A929784015F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 10:25:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F6851F23B50
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 09:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30D3355762;
	Mon, 29 Jan 2024 09:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b6VMHbKv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5845655C29;
	Mon, 29 Jan 2024 09:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706520286; cv=none; b=ehMg7PmPueA0NFk1iZ+ny2acIZWceqcCEMlIq8WNUKCf+SeaoiHihZWN8/eXJP5TiKjXpUiLiVwW9dQHYHKYYaLuZaQe8jnYHYXksOacZk2U2I3F3V7gjDM0Y6Kdn2ndWUS2nhKmfhf2UYNptKbnywAsTK4YZEmV58nCf8Xkj9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706520286; c=relaxed/simple;
	bh=CaVyL8/alkHSlyanSOlgNxf/AcPt6spU+xNLSCDKduo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=daIfGOIRjP2e8KNX0R223Nvd8Gme9B0jn6PKgcFR2dOqZQ3vfI1/TRrJT+XvoYmhDLH5RDR6R2w/GU4T0jvq4bSoP9w9kbClm2MY8CbhfV6faeL6c29HJSKg57RjqsZ3S0YVKj2bQKJVAYqFlEL4tQ1G0R5vNyB1Ks9qu0Bmooc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b6VMHbKv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8958FC433F1;
	Mon, 29 Jan 2024 09:24:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706520285;
	bh=CaVyL8/alkHSlyanSOlgNxf/AcPt6spU+xNLSCDKduo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b6VMHbKvkfmIjyVW8DfjfU6DjAshN7JrYkKyqBumkbaN5uHXmHEHw0gyeWv48KCEY
	 hNY/FHP2YbM4FLIXI3R6KcbunDu+tH2tF5EccYJjBQvh1q3hLZH1Qf6AX2J3YJ/wzQ
	 /NR059Vl9Qj6YDj7LBVFN9Cp0+NvjuUImvin6wL+Hk9/PJ88tAaBdQt+dvhiXXyw1w
	 mI1gJRv0OYJ6C61NIyR2q1QL9OTscf7U12Tprz5PRoapKhmc+3SyM4mV2mQhEqFCnT
	 B12xJMzY/EKAwV+eMvwyhrSOLFqVMhMv+16qCeQJE2wa1yxatchRPP1e0vdq5hQ8ss
	 03DawQAdEX+FA==
Date: Mon, 29 Jan 2024 09:24:40 +0000
From: Lee Jones <lee@kernel.org>
To: David Laight <David.Laight@aculab.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Crutcher Dunnavant <crutcher+kernel@datastacks.com>,
	Juergen Quade <quade@hsnr.de>
Subject: Re: [PATCH 1/1] lib/vsprintf: Implement ssprintf() to catch
 truncated strings
Message-ID: <20240129092440.GA1708181@google.com>
References: <20240125083921.1312709-1-lee@kernel.org>
 <a37e8071-32ac-4f5d-95e8-ddd2eb21edcd@rasmusvillemoes.dk>
 <20240125103624.GC74950@google.com>
 <54e518b6dd9647c1add38b706eccbb4b@AcuMS.aculab.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <54e518b6dd9647c1add38b706eccbb4b@AcuMS.aculab.com>

NB: I was _just_ about to send out v2 with Rasmus's suggestions before I
saw your reply.  I'm going to submit it anyway and Cc both you and
Rasmus.  If you still disagree with my suggested approach, we can either
continue discussion here or on the new version.

More below:

> From: Lee Jones
> > Sent: 25 January 2024 10:36
> > On Thu, 25 Jan 2024, Rasmus Villemoes wrote:
> > 
> > > On 25/01/2024 09.39, Lee Jones wrote:
> > > > There is an ongoing effort to replace the use of {v}snprintf() variants
> > > > with safer alternatives - for a more in depth view, see Jon's write-up
> > > > on LWN [0] and/or Alex's on the Kernel Self Protection Project [1].
> > > >
> > > > Whist executing the task, it quickly became apparent that the initial
> > > > thought of simply s/snprintf/scnprintf/ wasn't going to be adequate for
> > > > a number of cases.  Specifically ones where the caller needs to know
> > > > whether the given string ends up being truncated.  This is where
> > > > ssprintf() [based on similar semantics of strscpy()] comes in, since it
> > > > takes the best parts of both of the aforementioned variants.  It has the
> > > > testability of truncation of snprintf() and returns the number of Bytes
> > > > *actually* written, similar to scnprintf(), making it a very programmer
> > > > friendly alternative.
> > > >
> > > > Here's some examples to show the differences:
> > > >
> > > >   Success: No truncation - all 9 Bytes successfully written to the buffer
> > > >
> > > >     ret = snprintf (buf, 10, "%s", "123456789");  // ret = 9
> > > >     ret = scnprintf(buf, 10, "%s", "123456789");  // ret = 9
> > > >     ret = ssprintf (buf, 10, "%s", "123456789");  // ret = 9
> > > >
> > > >   Failure: Truncation - only 9 of 10 Bytes written; '-' is truncated
> > > >
> > > >     ret = snprintf (buf, 10, "%s", "123456789-"); // ret = 10
> > > >
> > > >       Reports: "10 Bytes would have been written if buf was large enough"
> > > >       Issue: Programmers need to know/remember to check ret against "10"
> > >
> > > Yeah, so I'm not at all sure we need yet-another-wrapper with
> > > yet-another-hard-to-read-prefix when people can just RTFM and learn how
> > > to check for truncation or whatnot. But if you do this:
> > 
> > As wonderful as it would be for people to "just RTFM", we're seeing a
> > large number of cases where this isn't happening.  Providing a more
> > programmer friendly way is thought, by people way smarter than me, to be
> > a solid means to solve this issue.  Please also see Kees Cook's related
> > work to remove strlcpy() use.
> 
> My worry is that people will believe the length and forget that
> it might be an error code.

My plan is to go around and convert these myself.  All of the examples
in the kernel will check the return value for error.  We can go one
further and author a Coccinelle rule to enforce the semantics.

> So you replace one set of errors (truncated data), with another
> worse set (eg write before start of buffer).

Under-running the buffer is no worse over-running.  However, as I say,
we're going to make a concerted effort to prevent that via various
proactive and passive measures.

> I'm sure that the safest return for 'truncated' is the buffer length.
> The a series of statements like:
> 	buf += xxx(buf, buf_end - buf, .....);
> can all be called with a single overflow check at the end.
>
> Forget the check, and the length just contains a trailing '\0'
> which might cause confusion but isn't going to immediately
> break the world.

snprintf() does this and has been proven to cause buffer-overflows.
There have been multiple articles authored describing why using
snprintf() is not generally a good idea for the masses including the 2
linked in the commit message:

LWN: snprintf() confusion
  https://lwn.net/Articles/69419/

KSPP: Replace uses of snprintf() and vsnprintf()
  https://github.com/KSPP/linux/issues/105

Yes, you should check ssprintf() for error.  This is no different to the
many hundreds of APIs where this is also a stipulation.  Not checking
(m)any of the memory allocation APIs for error will also lead to similar
results which is why we enforce the check.

-- 
Lee Jones [李琼斯]

