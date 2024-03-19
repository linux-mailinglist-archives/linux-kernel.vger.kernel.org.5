Return-Path: <linux-kernel+bounces-108029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34C77880501
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 19:42:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F236B2143E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 18:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69F453987D;
	Tue, 19 Mar 2024 18:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gpCpHlIb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A59382C690;
	Tue, 19 Mar 2024 18:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710873725; cv=none; b=lgT52/UY3k+09pZWGqc0O5GfP2RXxv5VvLHqNiosvzI5lFJ3wmjl+bzI9XYFj7Sr6mNEEGyHD5u52sOnm8ojc0qa93sl9xpZ32vdKaZSYACYK53VE1jLkE21JPWgpdFJ/36F9wUQoZq+xb9hkyu6Yx1SpgDW39Ni9ItA55IBUqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710873725; c=relaxed/simple;
	bh=/Xdo3nItTl5sMcBffTOyaNJrd79EpP5bGPedf1unGSA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nObDhreRQglCZEGmB5+bbvrQeFmgb0sL+Hbj4vRCLtg+0SjrAKwDRAq41rqBn12zcmPzyos6HZ0dJ0xF1KX4FJpF8FEEUP8OHdwWYyytESlAolBxn0lKeF70wAFbfAb3M4Zia/B+o94LuLIlCXXD59SLtjHLtOmKTUNgYt2UX3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gpCpHlIb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42EFBC433C7;
	Tue, 19 Mar 2024 18:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710873725;
	bh=/Xdo3nItTl5sMcBffTOyaNJrd79EpP5bGPedf1unGSA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gpCpHlIbdzMeUzAQj0R9Dd63LUg2B8fV6shgM8BsPWL8WNCK2ZzhCdiS5Qy50m6+o
	 qAVh9yXmzUgpH/q908cwHMoKzYX4wVR57IzrSiBzz6WkKBoSqArJTZhQmpda7/WGI9
	 uOgGATTIYZ+u69a7N4xZZhoHLC9Lo9YcHmPfZZ7L3kI16r8M+Mb817M/YXPTNbY72/
	 lHvoC1EO78OvuYNODy66ib4kUH7CyGztsQ9U5AdYG9fxBW714VDPO3K4gS+MHSyZ82
	 qS33KTUcTUkHrL/98s8uOOO+m0pcxoKIOQZn7s0jWTrr6QpwH6ahbGxN3FHfJBbk/+
	 0aJmkG6x3vb8g==
Date: Tue, 19 Mar 2024 15:42:00 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
	David Lechner <dlechner@baylibre.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Michael Hennerich <michael.hennerich@analog.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: adc: ad7944: Add support for "3-wire mode"
Message-ID: <ZfnceCKWLmbkWIgb@x1>
References: <20240314-mainline-ad7944-3-wire-mode-v2-1-d469da0705d2@baylibre.com>
 <ZfX5jynjW4M9pvw1@surfacebook.localdomain>
 <20240318124041.0000032d@Huawei.com>
 <CAHp75VeQcvuEy4V6-+3PeWTZJ9=Qae0AiiNB93OOw3wuc-uh3A@mail.gmail.com>
 <20240318142923.000042f4@Huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240318142923.000042f4@Huawei.com>

On Mon, Mar 18, 2024 at 02:29:23PM +0000, Jonathan Cameron wrote:
> On Mon, 18 Mar 2024 15:09:32 +0200
> Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> 
> > On Mon, Mar 18, 2024 at 2:41 PM Jonathan Cameron
> > <Jonathan.Cameron@huawei.com> wrote:
> > > > >  struct ad7944_adc {
> > > > >     struct spi_device *spi;
> > > > > +   enum ad7944_spi_mode spi_mode;
> > > > >     /* Chip-specific timing specifications. */
> > > > >     const struct ad7944_timing_spec *timing_spec;
> > > > >     /* GPIO connected to CNV pin. */
> > > > > @@ -58,6 +75,9 @@ struct ad7944_adc {
> > > > >      } sample __aligned(IIO_DMA_MINALIGN);
> > > > >  };  
> > > >
> > > > Have you run `pahole` to see if there is a better place for a new member?  
> > >
> > > I know this matters for structures where we see lots of them, but do we actually
> > > care for one offs?  Whilst it doesn't matter here I'd focus much more
> > > on readability and like parameter grouping for cases like this than wasting
> > > a few bytes.  
> > 
> > This is _also_ true, but think more about cache line contamination.
> > Even not-so-important bytes may decrease the performance. In some
> > cases it's tolerable, in some it is not (high-speed ADC). In general I
> > assume that the developer has to understand many aspects of the
> > software and cache line contamination may be last but definitely not
> > least.
> > 
> 
> Not totally sure what you are covering with contamination as many aspects
> around caches and that's not really a standard term for any of them (as
> far as I know).
> 
> It's part of a multi cacheline allocation anyway (because it's tacked on the
> end of the iio device struct, so fairly unlikely to share with other allocations
> and definitely not on ARM because of the trailing __aligned(IIO_DMA_MINALIGN)
> elements.
> 
> If it matters more locally, then pahole is more likely to push you to pack

You mean 'pahole --reorganize', right? Yeah, I need to take into account
explicit __attribute__((__aligned__)) at the start of cachelines as a
hint that the fields in a cacheline can't be moved outside of that
cacheline or plain leave that cacheline members alone, as-is.

I also need to get perf's data-type profiling as an input for 'pahole
--reorganize', with that we may take into account the existing
__aligned__ markings and combine it with what we get from data-type
profiling.

- Arnaldo

> things together in a fashion that makes false sharing and similar perf issues
> more likely if you are grouping things for packing purposes rather than
> logical groups.
> 
> If you just mean cache pressure then fair enough if we squeeze everything into
> one cacheline and that doesn't cause false sharing.
> 'Maybe' this will fit on x86. On Arm64 it's not going to
> make any difference, just moving the padding around a bit within the line.
> 
> So I'd argue premature optimization for a small, one off, structure.
> 
> Jonathan
> 
> 
> 

