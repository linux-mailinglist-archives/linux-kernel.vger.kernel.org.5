Return-Path: <linux-kernel+bounces-44806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A7428427A6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 16:07:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26B43285F8E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 15:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C5927CF08;
	Tue, 30 Jan 2024 15:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HetWeDur"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3BB87E761;
	Tue, 30 Jan 2024 15:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706627247; cv=none; b=goxWfljTfmtlFi7AmqcmSIb98/kAAE9RYL1YzZ+Ccci3R0hgLmlKktlA58veowpYLw5yQn8JRA4Vu2/vncwHXm0frWDvpxgCtQFMCBcvTteGB8MCnbBIfNxGCccBw7HAVXzjJ0jzsC3I/qwvLvySVgckpLq5XL0v0FflotcN+kM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706627247; c=relaxed/simple;
	bh=sXZB4BUwJD78nnuO2sH8rY6iShJKvwQE0A/35/RmFvU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ttzKq9wcasR9Uo4AJ4lsNBNBNpVdBGKdsopF9C8UVA1dEANXB2wWV7cOp2f44sr657bqSQH/h2G94ySh1GnACBF8YSZTnlf/1Q6SwZtszPBm2E3kMtB1H18NMb2w685+NFZndIbr2vcd5+40YQq07lYcZ1juLiUl3dxQ3jyx0CQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HetWeDur; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10FF0C433F1;
	Tue, 30 Jan 2024 15:07:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706627247;
	bh=sXZB4BUwJD78nnuO2sH8rY6iShJKvwQE0A/35/RmFvU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HetWeDuroFc2r1ZPggJiNdtdOohvM/NHBXpVqRMhe/PNNgJPM0G07yGCxHS0/ZTha
	 L48gb1+oAUsw+9Km1tfN9fVHlQpdZN+SV+vleoKV+JBwyBt+Q4AuLIWbcZgYvjQSZO
	 HRcXhnwNsS/Oc2jiP5bEipWfm6jZQBinYRjO8Wy61EaQlDw48r8u0S+uxJzuFfupCb
	 RlkpizrjCMV10O6L7umq7k1FOiBCf0ueMtZ7hcM9m7foMFxFrw7YxuxRad17Ytep4z
	 NXjnQ+F4dn8CaZuYuPd8Bmhb5mxrgNG46vEhlaLLggyeh5J9D3SmcyuV425t5VRZgv
	 PJ9c6X2v5RJKQ==
Date: Tue, 30 Jan 2024 15:07:21 +0000
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
Message-ID: <20240130150721.GA692144@google.com>
References: <20240125083921.1312709-1-lee@kernel.org>
 <a37e8071-32ac-4f5d-95e8-ddd2eb21edcd@rasmusvillemoes.dk>
 <20240125103624.GC74950@google.com>
 <54e518b6dd9647c1add38b706eccbb4b@AcuMS.aculab.com>
 <20240129092440.GA1708181@google.com>
 <7054dcbfb7214665afedaea93ce4dbad@AcuMS.aculab.com>
 <20240129095237.GC1708181@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240129095237.GC1708181@google.com>

On Mon, 29 Jan 2024, Lee Jones wrote:

> On Mon, 29 Jan 2024, David Laight wrote:
> 
> > ...
> > > > I'm sure that the safest return for 'truncated' is the buffer length.
> > > > The a series of statements like:
> > > > 	buf += xxx(buf, buf_end - buf, .....);
> > > > can all be called with a single overflow check at the end.
> > > >
> > > > Forget the check, and the length just contains a trailing '\0'
> > > > which might cause confusion but isn't going to immediately
> > > > break the world.
> > > 
> > > snprintf() does this and has been proven to cause buffer-overflows.
> > > There have been multiple articles authored describing why using
> > > snprintf() is not generally a good idea for the masses including the 2
> > > linked in the commit message:
> > 
> > snprintf() returns the number of bytes that would have been output [1].
> > I'm not suggesting that, or not terminating the buffer.
> > Just returning the length including the '\0' (unless length was zero).
> > This still lets the code check for overflow but isn't going to
> > generate a pointer outside the buffer if used to update a pointer.
> 
> I see.  Well I'm not married to my solution.  However, I am convinced
> that the 2 solutions currently offered can be improved upon.  If you or
> anyone else has a better solution, I'd be more than happy to implement
> and switch to it.
> 
> Let me have a think about the solution you suggest and get back to you.

Okay, I've written a bunch of simple test cases and results are
positive.  It seems to achieve my aim whilst minimising any potential
pitfalls.

 - Success returns Bytes actually written - no functional change
 - Overflow returns the size of the buffer - which makes the result
   a) testable for overflow
   b) non-catastrophic if accidentally used to manipulate later sizes

    int size = 10;
    char buf[size];
    char *b = buf;

    ret = spprintf(b, size, "1234");
    size -= ret;
    b += ret;
    // ret = 4  size = 6  buf = "1234\0"

    ret = spprintf(b, size, "5678");
    size -= ret;
    b += ret;
    // ret = 4  size = 2  buf = "12345678\0"

    ret = spprintf(b, size, "9***");
    size -= ret;
    b += ret;
    // ret = 2  size = 0  buf = "123456789\0"

Since size is now 0, further calls result in no changes of state.

    ret = spprintf(b, size, "----");
    size -= ret;
    b += ret;
    // ret = 0  size = 0  buf = "123456789\0"

I'll knock this up and submit a patch.

-- 
Lee Jones [李琼斯]

