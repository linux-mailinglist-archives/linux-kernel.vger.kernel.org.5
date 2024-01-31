Return-Path: <linux-kernel+bounces-46010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 805C4843931
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 09:36:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2DCC1C26DDC
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 08:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A58AA5D8E5;
	Wed, 31 Jan 2024 08:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m/Tj0cn6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D50755DF1F;
	Wed, 31 Jan 2024 08:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706690209; cv=none; b=smP8HbiihnbLgmxvzB3pYzJgWAREnFXZ6aY8s0AAFT8Yxni/WuNQ8QnhCViKGEkPFoGDRj89ZjmUAYpn8uPCBu+KRjU72PFB9zJpfB5k7v6Lpu1A9/klO1jXHvASy6k63Dg0+H/tPwm/ADps31tegEMD48GWKuERmaao7TK8sB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706690209; c=relaxed/simple;
	bh=3fSoaam3bpW+RZdeV1nq004KT4pap3gb5P9HUz6Zm+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W5SEHuEMOQKt0WVQnh8cOmtZk+r5yamdMVLMSzoeb1pPjKQFGv95Enqjgeu2P7QO9+9NCf7HSWpaWj4ldvNDkRWriQeDiYIDLt72+QxMkgVRJXkt7p7zZYnV9eUjsKWvJDk/ITdU0Absz7Zkx0wJm66cilWR56sr2u7EJffYMLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m/Tj0cn6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCCD7C433C7;
	Wed, 31 Jan 2024 08:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706690208;
	bh=3fSoaam3bpW+RZdeV1nq004KT4pap3gb5P9HUz6Zm+A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m/Tj0cn61cMCn2mizYiadUUc5W0/r22jCNnm/WJ6/1Icey3ZHgTjsdgu9xarclDMN
	 W3ak17gZzVfqIKuY36pBWpQvy4H+DJ0d2K06HFj5j+neG1Vvg2sl72fL5Cm7724JPm
	 MfAsIT3RZdKZzM65rEPc9iIcK1l7mZ7Xcdlp3SgwqIF2QZnItCJ/5/Xf+Fuaa8JSzz
	 /8ePjt6iV/mARr1qg4MDENfIEgJ3AcNnj1gNjsgdbsqWeccq3mQw1P5EFi10cDhCIX
	 P4GpT6HuGineQ4lZzL3atzrw5jxN5r3iJEWzwTZzg44ooM0Ndlh/3p4hbeHG6wc5y2
	 A+ok0FnJSqX3Q==
Date: Wed, 31 Jan 2024 08:36:42 +0000
From: Lee Jones <lee@kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
	David Laight <David.Laight@aculab.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
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
Message-ID: <20240131083642.GB8551@google.com>
References: <20240125083921.1312709-1-lee@kernel.org>
 <a37e8071-32ac-4f5d-95e8-ddd2eb21edcd@rasmusvillemoes.dk>
 <20240125103624.GC74950@google.com>
 <54e518b6dd9647c1add38b706eccbb4b@AcuMS.aculab.com>
 <20240129092440.GA1708181@google.com>
 <7054dcbfb7214665afedaea93ce4dbad@AcuMS.aculab.com>
 <20240129095237.GC1708181@google.com>
 <20240130150721.GA692144@google.com>
 <79921f9a-2453-48ec-85db-e63a0958db1e@prevas.dk>
 <202401301351.83A809993@keescook>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202401301351.83A809993@keescook>

On Tue, 30 Jan 2024, Kees Cook wrote:

> On Tue, Jan 30, 2024 at 04:18:42PM +0100, Rasmus Villemoes wrote:
> > So here scnprint() would have returned 1, leaving size at 1. scnprintf()
> > has the invariant that, for non-zero size, the return value is strictly
> > less than that size, so when passed a size of 1, all subsequent calls
> > return 0 (corresponding to the fact that all it could do was to write
> > the '\0' terminator).
> > 
> > This pattern already exists, and is really the reason scnprint exists.
> > Yes, scnprintf() cannot distinguish overflow from
> > it-just-exactly-fitted. Maybe it would have been better to make it work
> > like this, but I don't think there's a real use - and we do have
> > seq_buf() if one really wants an interface that can build a string
> > piece-meal while keeping track of whether it ever caused overflow.
> 
> Yeah, I think we can take the handful of places that really need to know
> about the overflow and can't reliably use scnprintf() and migrate them
> to the seq_buf API. It should be much easier to use now[1] too.
> 
> That way we won't add a new string API, and we can continue to remove
> snprintf.

This looks promising.  I'll have a look and get back to you.

> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/include/linux/seq_buf.h?id=dcc4e5728eeaeda84878ca0018758cff1abfca21
>     https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/include/linux/seq_buf.h?id=7a8e9cdf9405819105ae7405cd91e482bf574b01

-- 
Lee Jones [李琼斯]

