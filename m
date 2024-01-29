Return-Path: <linux-kernel+bounces-42502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 83E5484023F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 10:54:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10578B21658
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 09:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90A2255777;
	Mon, 29 Jan 2024 09:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="COgUzsam"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B43E55821C;
	Mon, 29 Jan 2024 09:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706521962; cv=none; b=KT9wSH6/6OwDJu3GhV07Hn0NYz5/H6oLKNMrHNaz3FolbvzkVyrufiZABwVsJlnS33ZXkyKRkfriWZz1JToLQOk6Ib5K0jEEDE4L6PnGiw5FyNNzzEDJK8iQQX4NXaitGvSnMmKuWMy7/RbkSlkRShKAsr6jAS8ar8TAPEg7ObE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706521962; c=relaxed/simple;
	bh=F761W1UopTbjLyj6oTvDG2L2LbG+NdNFiuf1Z57ZfvU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D9KJBkYrzdd3YWbR4IbZoKLPqkb8rm7jsVScBrBygC3rlAaFg8Gfb4wyNCtWb8+ebHyGVAx7vO/XBGKyuPJf0RHeXgl5q71a4TbPTXsDrvSlgVJiFObYmZvk+KfV70OGqdSz6Vp16DhbodUPbrpht4pg+CpYhd39BUkyc4qyGAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=COgUzsam; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0704BC43394;
	Mon, 29 Jan 2024 09:52:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706521962;
	bh=F761W1UopTbjLyj6oTvDG2L2LbG+NdNFiuf1Z57ZfvU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=COgUzsamxI5JaoiIBz2Ywypnk2v0IKL0/dnBkQZSS+JflQx2RfdnF4kKBrFx0pQ5Y
	 RBWfoeyETfyEfN0ADn7dY7AOv0qD1cTUwncEY6BN350gATWMnXZF9LlsSOaSIOV+2c
	 ec2BH//MA8DKdupmzbAy71FuWJrtgHvPby6oxnvJPFuTsJzw8AS0LqV+laEOggQRow
	 Gy5lVU+ySllOabDXJO2jNyEIuZMQ1MpSsP6WT+B7gF5UOIr6UtsOidSsMwGXzqo8KY
	 G3y8Y9GAA8D7XmFUs5rvzq7kom2Inez1SbixEQyp1qfM5Cnbf6qeIGRzIBK6Dm37Ya
	 08SrNsgMN3QwA==
Date: Mon, 29 Jan 2024 09:52:37 +0000
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
Message-ID: <20240129095237.GC1708181@google.com>
References: <20240125083921.1312709-1-lee@kernel.org>
 <a37e8071-32ac-4f5d-95e8-ddd2eb21edcd@rasmusvillemoes.dk>
 <20240125103624.GC74950@google.com>
 <54e518b6dd9647c1add38b706eccbb4b@AcuMS.aculab.com>
 <20240129092440.GA1708181@google.com>
 <7054dcbfb7214665afedaea93ce4dbad@AcuMS.aculab.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7054dcbfb7214665afedaea93ce4dbad@AcuMS.aculab.com>

On Mon, 29 Jan 2024, David Laight wrote:

> ...
> > > I'm sure that the safest return for 'truncated' is the buffer length.
> > > The a series of statements like:
> > > 	buf += xxx(buf, buf_end - buf, .....);
> > > can all be called with a single overflow check at the end.
> > >
> > > Forget the check, and the length just contains a trailing '\0'
> > > which might cause confusion but isn't going to immediately
> > > break the world.
> > 
> > snprintf() does this and has been proven to cause buffer-overflows.
> > There have been multiple articles authored describing why using
> > snprintf() is not generally a good idea for the masses including the 2
> > linked in the commit message:
> 
> snprintf() returns the number of bytes that would have been output [1].
> I'm not suggesting that, or not terminating the buffer.
> Just returning the length including the '\0' (unless length was zero).
> This still lets the code check for overflow but isn't going to
> generate a pointer outside the buffer if used to update a pointer.

I see.  Well I'm not married to my solution.  However, I am convinced
that the 2 solutions currently offered can be improved upon.  If you or
anyone else has a better solution, I'd be more than happy to implement
and switch to it.

Let me have a think about the solution you suggest and get back to you.

> [1] I'm pretty certain this is because the original libc version
> of sprintf() allocated a FILE structure on stack (fully buffered)
> and called fprintf().
> snprintf() would have been done the same way but with something
> to stop the buffer being flushed.

Interesting.  Thanks for the background.

-- 
Lee Jones [李琼斯]

