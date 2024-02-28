Return-Path: <linux-kernel+bounces-84796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 89CFC86ABB2
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 10:55:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B2481F271E7
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 09:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05EAC36124;
	Wed, 28 Feb 2024 09:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="TCcMxJss"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 994CB2E859
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 09:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709114148; cv=none; b=FBEF3ZQb3j/I1J/VsVNZ4JJtxIY9MT+R4U5XfCcliYcr0bz829z/L4BuXaFaadnoB/5rRaySUSqIxOJ0oBzXFgkxoemWchHQZhaW5LhMaMSSD6+EIs1d2DqUqbexDJjTPH6kR2S3rLUs+tOQd/TppVWyINQUkLU1f3haE07Ojgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709114148; c=relaxed/simple;
	bh=9q6oppYW6Sx1xCipRYioovq/te3WS0mFoUe1jHuAcxA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sMcx4HrWhjU6lYriIOyKze0OqVn8M9KdcwfxoaGv6pTOZoVeYO/z5iIriCAGHsocZc1JqUciYvmvPg3VFGLyTiPSXhy0RMcDe2nRq+DfcffDJCx8WzuW+wTBaGG1akrgwdEZxkoOSKJUMfCJBvBmOyPlGRlDV3EKdjGs/GleuEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=TCcMxJss; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-563bb51c36eso5983325a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 01:55:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1709114144; x=1709718944; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uBNtmpWHwk23veRV9DRLTSwz8gtd1U5j/H2m71ZLWRY=;
        b=TCcMxJss2TB7BX2uaGDGxUxsHQUJaNeCFlShnR54jCLmhmx66HyNhEFxRcrOkK+8CI
         sWwxJnWVSUlFiR7QKTnWcijmHClo4JsVD0CxIieUyKIve6GDVeQVCVRlboWa3X5wBKMO
         Rp6pH5zQDqLjFgwxe58buSsHD59evL0fXcx1c08RNB5BW/rU33PBv9E7odw2jELGorr1
         L3dB3F2aSI3N3Zoi/WJdl0KbIcN4LTS1bDdjs5NSVb1QncdIuYJP6SDEN/c8saebnrmk
         +72yOn6h8VzV4XLrMe1JZgl2cV/wJWMEa0xqVjixW0hqTuS93WHkEUaQb8A2RXlUP7MF
         ifOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709114144; x=1709718944;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uBNtmpWHwk23veRV9DRLTSwz8gtd1U5j/H2m71ZLWRY=;
        b=kNAorgRjpuDpMHYoXB1y9lNXHgb5B8Wan7N6jPnxBwbs+uVU0AyLGisKZpC5YyRUrv
         ifKM/XpcdKYkw1Hl1sojsIY/CKzIIx97cDLmydvIMynaOeY05VomY3fWxlxy3GiBIAxI
         2GqHe5i+AUWNMpNG4D3TzkUhqS/Dc3/O4c6dgdRdUoFDp2R9a9PXSGcvkoEAGRw0cQp3
         3Bt4K3e1yNxSnunMPEZ4Ji9Y6g1vO1u0gANGdYewq4VZ1srLLbkzPt9Q7UvlXUh22S1u
         qzoPda+IULL0rok/+Onv2m+zuEU3TkyDnAu0kkRZ7jce20ipdF3YIXPG8MjEY9pdupkg
         ooMg==
X-Forwarded-Encrypted: i=1; AJvYcCXKo1dNCjsMx3GbEINlslnV7iMsHu1Z5AK7BKVFayKcs++d2c2ItLhjPgpNcIBf+QqEV0XoGJt7KaE34vD+33Pq5xqqjVU5//WWstKw
X-Gm-Message-State: AOJu0Yzpj6ZqTNJy9bEKviu76Ajmoe7avs/MeSIPaPvnx56MuIIfBqoa
	9HLQtKdJUIq0uSVADotRKzOamX48EhF8GX/H2nCwf0UXEiuzv490Sg4d1vZ2Vt0=
X-Google-Smtp-Source: AGHT+IHn52EhzPq1RG3ODn9Z6RrwbKI8Y+PrluZvwDL2enxJ7j/yXzctI2kVvuCepYHbsCHDJKUqqw==
X-Received: by 2002:a17:906:35cf:b0:a44:46a:27bf with SMTP id p15-20020a17090635cf00b00a44046a27bfmr572076ejb.16.1709114144028;
        Wed, 28 Feb 2024 01:55:44 -0800 (PST)
Received: from alley ([176.114.240.50])
        by smtp.gmail.com with ESMTPSA id c12-20020a17090603cc00b00a433f470cf1sm1668440eja.138.2024.02.28.01.55.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 01:55:43 -0800 (PST)
Date: Wed, 28 Feb 2024 10:55:42 +0100
From: Petr Mladek <pmladek@suse.com>
To: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	intel-gfx@lists.freedesktop.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Matthew Wilcox <willy@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/12] drm/i915: Indicate which pipe failed the fastset
 check overall
Message-ID: <Zd8CtrOmb8nfGBdl@alley>
References: <20240215164055.30585-1-ville.syrjala@linux.intel.com>
 <20240215164055.30585-2-ville.syrjala@linux.intel.com>
 <ZdfApN1h97GTfL1t@intel.com>
 <Zdj2ONs8BZ6959Xb@intel.com>
 <87bk83mfwp.fsf@intel.com>
 <1013ff2d-76b2-41f9-a5d4-39a567a3b0cc@rasmusvillemoes.dk>
 <Zd4qrLVWcacza747@intel.com>
 <fa42285b-099e-4d2d-9368-58cea7f67010@rasmusvillemoes.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fa42285b-099e-4d2d-9368-58cea7f67010@rasmusvillemoes.dk>

On Wed 2024-02-28 09:32:37, Rasmus Villemoes wrote:
> On 27/02/2024 19.32, Ville Syrjälä wrote:
> > On Tue, Feb 27, 2024 at 10:38:10AM +0100, Rasmus Villemoes wrote:
> >> On 26/02/2024 15.57, Jani Nikula wrote:
> So if we really want to go down this road, I think it should be
> something like %pX{drm:whatever}, with core printf just looking up the
> token "drm" in a run-time list of registered callbacks (because I don't
> want vsprintf.c filled with random subsystems' formatting code), and
> that single callback would then be handed a pointer to the rest of the
> format string (i.e. the "whatever}..."), the pointer argument from the
> varargs, and the buf,end pair. But then we're back to trusting that
> callback (which might of course multiplex based on the "whatever" part)
> to behave correctly. And then we might as well avoid the string parsing
> and just do the "callback + pointer" in one struct (passed as pointer to
> compound literal), which also avoids the tricky "what to do about module
> unload versus unregistering of callbacks" etc.

Mathew Wilcox had the idea to introduce a structure:

	struct printf_state {
	       char *buf;
	       char *end;
	       void *ptr;
	};

Where *ptr would point to some data which should be printed,
same as wee pass to the %pbla now.

Then allow to implement:

	char *my_func(struct printf_state *ps, void *ptr);

and use it as:

	printk("%pX(%p)\n", my_func, ptr);


One problem here is type checking of the data passed via *ptr
but we already have the same problem now.

Another problem is how to make sure that the function is safe.
A solution might be to implement an API for appending characters,
strings, numbers, ... Similar to seq_buf() API.

AFAIK, the result was to actually use the existing seq_buf API
to format the string. AFAIK, it motivated:

   + commit 96928d9032a7c34f1 ("seq_buf: Add seq_buf_do_printk() helper")

and probably also

   + commit d0ed46b60396cfa7 ("tracing: Move readpos from seq_buf to trace_seq")

and also this one is pretty useful:

   + commit dcc4e5728eeaeda8 ("seq_buf: Introduce DECLARE_SEQ_BUF and
     seq_buf_str()")

And it motivated:

   + commit dcc4e5728eeaeda84878ca0 ("seq_buf: Introduce
     DECLARE_SEQ_BUF and seq_buf_str()")


Best Regards,
Petr

