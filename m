Return-Path: <linux-kernel+bounces-58422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8C6884E64D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 18:10:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB8251C2604C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 17:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 368AF84FA3;
	Thu,  8 Feb 2024 17:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JioAjxEI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 491887EEFA;
	Thu,  8 Feb 2024 17:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707411950; cv=none; b=da7epeRcUwd40mHuicC04LVglEOUCgBVz9qJzoigQUreGV/2DuWjvOqzT3bgr8hwKJng6cSWLez3CH4yjzLakSQZAE7KoQMJkS8YNOpBf/bhO5dJOdRd5qtav3ub6zWepr3OqndzKPzd3kV56I9uQwtdUq9Bdhv5fMOqUnOeyqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707411950; c=relaxed/simple;
	bh=YnAV3cf2dVZn5SmfbURqED8Do4HIbJUHN3PAYcyqo9k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tO8VFBykZzEE5fc7q9YEzBeu5hgHZfY1Rr0+D+OlpkxfyvU3sgRK6CZ42xCYkwd8j5NqRtficQpp6tiZ4xKZFTeCoGvO0F5/j6Lk6NShV+pVAUMvkdIS7UD9wS+s0oVw9jm6zo8qUwgt30MR44/qntRGZiaGf/28BKW4KyBD9zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JioAjxEI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54645C433F1;
	Thu,  8 Feb 2024 17:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707411949;
	bh=YnAV3cf2dVZn5SmfbURqED8Do4HIbJUHN3PAYcyqo9k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JioAjxEIF25UWXJ3iGFsxP2SknKfe0pbZTb55tQY/S+atONebMks8B0c75LaX6ruh
	 QnbsSXzBApv3mZHIeFqkejqOLUZvRZN2gyuy4Ae9ClB0ztnrTjbIxiNaqamxprZGeo
	 XSXHKyF9nmRPcsYa2RhXEm6yuDg4xtycoy1tqBKdTOnMmMwdhXEeVpt6DjHiKfo8/p
	 vVTPbRAtjx4YHYptU4HiJ2vJGN399BuOamAfynRvL4KOCXJ31NsKAgfl8QKP6tWcYF
	 VENaEs96bdDiViJToqKWJYzNltdrZenenPYZ/UhdLWI9DKzqyDzkT46hEAjMcaGFtJ
	 sgVhyPUOFn4gw==
Date: Thu, 8 Feb 2024 17:05:44 +0000
From: Lee Jones <lee@kernel.org>
To: Petr Mladek <pmladek@suse.com>
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
Message-ID: <20240208170544.GV689448@google.com>
References: <a37e8071-32ac-4f5d-95e8-ddd2eb21edcd@rasmusvillemoes.dk>
 <20240125103624.GC74950@google.com>
 <54e518b6dd9647c1add38b706eccbb4b@AcuMS.aculab.com>
 <20240129092440.GA1708181@google.com>
 <7054dcbfb7214665afedaea93ce4dbad@AcuMS.aculab.com>
 <20240129095237.GC1708181@google.com>
 <20240130150721.GA692144@google.com>
 <79921f9a-2453-48ec-85db-e63a0958db1e@prevas.dk>
 <20240130155336.GA8551@google.com>
 <ZcUAIqnA_SJN0Clg@alley>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZcUAIqnA_SJN0Clg@alley>

On Thu, 08 Feb 2024, Petr Mladek wrote:

> On Tue 2024-01-30 15:53:36, Lee Jones wrote:
> > On Tue, 30 Jan 2024, Rasmus Villemoes wrote:
> > > On 30/01/2024 16.07, Lee Jones wrote:
> > > > On Mon, 29 Jan 2024, Lee Jones wrote:
> > > >> On Mon, 29 Jan 2024, David Laight wrote:
> > > >>>> snprintf() does this and has been proven to cause buffer-overflows.
> > > >>>> There have been multiple articles authored describing why using
> > > >>>> snprintf() is not generally a good idea for the masses including the 2
> > > >>>> linked in the commit message:
> > > >>>
> > > >>> snprintf() returns the number of bytes that would have been output [1].
> >
> > > > Okay, I've written a bunch of simple test cases and results are
> > > > positive.  It seems to achieve my aim whilst minimising any potential
> > > > pitfalls.
> > > > 
> > > >  - Success returns Bytes actually written - no functional change
> > > >  - Overflow returns the size of the buffer - which makes the result
> > > >    a) testable for overflow
> > > >    b) non-catastrophic if accidentally used to manipulate later sizes
> > > 
> > > You are describing scnprintf(), which almost does exactly that. The last
> > > thing we need is another interface with almost identical semantics.
> > 
> > It does, which is why when I first centred my efforts on this task the
> > plan was to simply switch to it.  However, as I described in the commit
> > message:
> > 
> >   "Whist executing the task, it quickly became apparent that the initial
> >   thought of simply s/snprintf/scnprintf/ wasn't going to be adequate
> >   for a number of cases.  Specifically ones where the caller needs to
> >   know whether the given string ends up being truncated."
> > 
> > A great deal of callers want to know if the string they attempted to
> > form was successful.  A malformed string would lead to oddities in the
> > best cases and various device/probing/matching failures in the worst.
> > 
> > > >     int size = 10;
> > > >     char buf[size];
> > > >     char *b = buf;
> > > > 
> > > >     ret = spprintf(b, size, "1234");
> > > >     size -= ret;
> > > >     b += ret;
> > > >     // ret = 4  size = 6  buf = "1234\0"
> > > > 
> > > >     ret = spprintf(b, size, "5678");
> > > >     size -= ret;
> > > >     b += ret;
> > > >     // ret = 4  size = 2  buf = "12345678\0"
> > > > 
> > > >     ret = spprintf(b, size, "9***");
> > > >     size -= ret;
> > > >     b += ret;
> > > >     // ret = 2  size = 0  buf = "123456789\0"
> > > 
> > > So here scnprint() would have returned 1, leaving size at 1. scnprintf()
> > > has the invariant that, for non-zero size, the return value is strictly
> > > less than that size, so when passed a size of 1, all subsequent calls
> > > return 0 (corresponding to the fact that all it could do was to write
> > > the '\0' terminator).
> > > 
> > > This pattern already exists, and is really the reason scnprint exists.
> > > Yes, scnprintf() cannot distinguish overflow from
> > > it-just-exactly-fitted. Maybe it would have been better to make it work
> > > like this, but I don't think there's a real use
> > 
> > There are real use-cases.  They are what brought me here.
> >
> > > and we do have
> > > seq_buf() if one really wants an interface that can build a string
> > > piece-meal while keeping track of whether it ever caused overflow.
> > 
> > seq_buf_*() looks okay, but it's petty heavy requiring what looks like
> > the buffers to be initialised with an API call before use.  We're
> > looking for something more light weight.
> > 
> > scnprint() had clear safety centric improvements over snprintf() and
> > spprintf() adds an additional layer of return value checking on top of
> > that.
> > 
> > I'm not sure I understand the resistance to something which is needed
> > and has clear benefits over what presently exists just for the sake of a
> > few lines of code.  I'd be on board if it were change for the sake of
> > change, but the added flexibility and ease of use is evident.
> 
> My view is the following:
> 
> First, I agree that snprintf() is dangerous and should be replaced.

Thanks for your input Petr.

> I think that the resistance is because:
> 
>   + ssprintf() has its danger as well. You wrote [1] that
>     "Under-running the buffer is no worse over-running". But it is
>     no better either.
> 
>   + More APIs might create more confusion and increase the risk of
>     a misuse.
> 
>   + spprintf() does not allow to detect truncated string. It means
>     that it does not provide any advantage over the existing scnprintf().

spprintf() can detect a truncated string:

  ret = spprintf(buf, 10, "1234567890");
  if (ret == 10) {
    /* The buffer truncated */
  }

And if the return value is used directly on a subsequent call:

  spprintf(buf + ret, 10 - ret, "1234567890"); /* No underflow/overflow */

Caveat: I just knocked this example up off the top of my head.  It's
        completely untested and probably contains lots of errors.

> So, if we could solve it another way then it might be better.

I'm still quite fond of ssprintf() since it seems to solve the present
issues and it's very light (compared with the alternative), but I think
the preferred approach is to use seq_buf in cases where the caller needs
to know if truncation occurred.

> That said, people tend to look how an API is used instead of RTFM.
> They copy good or bad patterns. There is even a term for this
> but I can't remember it new.
> 
> So, if we introduce a new API and provide some good examples
> then there is a good chance that people will continue using
> it correctly. And it even might be checked more easily.
> 
> There is a similarity with alloc() APIs. Good (most) programmers
> know that they need to check kalloc() return value. They might
> also learn that they need to check also return value from
> ssnprintf() of how we call it. Especially, when we provide
> good examples from the very beginning. Also it might
> be checked by Coccinelle.
> 
> 
> Finally, if you eventually send a new version of a string API
> then please add Linus into Cc. He has huge experience and very
> good feeling for what is good and what is wrong. And he
> is interested into exactly these types of APIs.
> 
> 
> [1] https://lore.kernel.org/r/20240129092440.GA1708181@google.com
> 
> Best Regards,
> Petr

-- 
Lee Jones [李琼斯]

