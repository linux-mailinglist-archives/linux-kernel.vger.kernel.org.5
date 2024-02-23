Return-Path: <linux-kernel+bounces-78809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 37640861924
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 18:15:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AC3C1C24F72
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 17:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F07112D769;
	Fri, 23 Feb 2024 17:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nD9O8SxF"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E10823A7
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 17:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708708497; cv=none; b=q71ETkxGHTC7SZdvh0D3HXCS2MORZCJfSthJYXKbTZDN30l+eWI6QW0CBJsSUPxHmYQJDBUIM3I2mRfDXoDM8japY1LpGzUfB3MN98zRkdYskwyQHVyQ2hJ4ZEfuA4w47zNVn+zBeeB8ZPj6s6thWeuTsOdJ6eRlJcfNF2z+BGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708708497; c=relaxed/simple;
	bh=ztI079C4kK2GAb/GQ39H0guLv9wqTuVaU/tymCIWIXM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c/gy4jFDtvQGQoATZjA9tCzFzX+fWwZ9cqT+j0sjVYDkkrCDcy99aNaOcfMbEmzSFcu57yG98imtxXAQZpVmLbTsXlBRiIleyEUYimIF2K8TG1P+ONpAvmwddjaFg0PR3KOG+ypwpbE/n3N2dualf6GfFHt2c3ZFkX5H9MfYdDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=nD9O8SxF; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-29a378040daso811044a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 09:14:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708708494; x=1709313294; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Vg7OXlKlVYW7hg5QFkzlyn1txlxCwfeUmFWqrZZakkI=;
        b=nD9O8SxFwXZ5OICagtej07tg8zISocQZb43sE8vXfeMn6qcQabMD5xGGSZfpgRR6GI
         n6Zwh9qSxycabFyxfep3LeG2LygBwOC+KsYKAMZkFMf5aY3uwdNpes0/o++bsRFe/WQR
         Arzj/PXAEn39txFhmk8+uC7RuUPn51+7BO9b0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708708494; x=1709313294;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vg7OXlKlVYW7hg5QFkzlyn1txlxCwfeUmFWqrZZakkI=;
        b=DG/zaQJUMCTYk9IEP+q5FQJvUMW6wvxC5XCDvu2TfUu4a6lnlFZbDFz2hgbuVP8tlq
         bm2Ih/AdNsEAcOAQ5udEOBCW+Il0zX6PynLoMM7xborWZYX4upcqrtJJY4eVErYxKTs9
         aMksxjlEnrSoZTlJHphUTne1CP8u1MxjnUHBvcePgH/1SfXbUsB8uLA86pCE1Jtzi6le
         d9PImgaUUGdlS3BPiT0Og299LNhvFh1G/yb7DjxW4aaAtUPZUETT4oWxu1ZSXxCu9H+K
         y2Hb9XCnOwKF7FY016FEMixwT3WN5d5vJjo2vTLC1/Tp3JDOXx5/DyrFnTwV6/kWit+S
         B5SQ==
X-Forwarded-Encrypted: i=1; AJvYcCUp4rft9y6N6QUvcE6U66MgbahNM66ayTaYQydFmLPnALXC5yxyo7qJec4DPcRF+nqte3QUk/z7Ijaz5zs5rkw9Vx3tLGrcKJBEd5/Z
X-Gm-Message-State: AOJu0YxycJ6JqUmUUNmlIld669GXf2URPMxe+ZJvk/ZuDTv/2zhhv7ll
	khMRZ/mQxy9rl2XWECxv+jLudHQe/FnMrnF1R/fQ4Bn+IloinLRp3UU3GusITw==
X-Google-Smtp-Source: AGHT+IHYsFzFj8B69cBmCkJ+HRyrAZNB3qghpWQMDXfj6imG1QPDbz2xJ3wDEwcSJ8BYkVFwQqGa9A==
X-Received: by 2002:a17:90a:c797:b0:29a:5eb9:71ab with SMTP id gn23-20020a17090ac79700b0029a5eb971abmr462657pjb.21.1708708494023;
        Fri, 23 Feb 2024 09:14:54 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id a4-20020a17090acb8400b002973162eca1sm1738761pju.17.2024.02.23.09.14.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 09:14:53 -0800 (PST)
Date: Fri, 23 Feb 2024 09:14:53 -0800
From: Kees Cook <keescook@chromium.org>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	linux-iio@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] [RFC] iio: pressure: dlhl60d: Check mask_width for IRQs
Message-ID: <202402230912.50332AF1@keescook>
References: <20240222222335.work.759-kees@kernel.org>
 <20240223170918.00006b16@Huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240223170918.00006b16@Huawei.com>

On Fri, Feb 23, 2024 at 05:09:18PM +0000, Jonathan Cameron wrote:
> On Thu, 22 Feb 2024 14:23:39 -0800
> Kees Cook <keescook@chromium.org> wrote:
> 
> > Clang tripped over a FORTIFY warning in this code, and while it seems it
> > may be a false positive in Clang due to loop unwinding, the code in
> > question seems to make a lot of assumptions. 
> 
> Hi Kees,
> 
> The assumptions are mostly characteristics of how the IIO buffers work
> with the scan masks defined based on indexes in the driver provided
> struct iio_chan_spec arrays.
> 
> This driver is doing more work than it should need to as we long ago
> moved some of the more fiddly handling into the IIO core.
> 
> > Comments added, and the
> > Clang warning[1] has been worked around by growing the array size.
> > Also there was an uninitialized 4th byte in the __be32 array that was
> > being sent through to iio_push_to_buffers().
> 
> That is indeed not good - the buffer should have been zero initialized.

Okay, I'll get this respun and include the fix.

> 
> > 
> > Link: https://github.com/ClangBuiltLinux/linux/issues/2000 [1]
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> > Cc: Jonathan Cameron <jic23@kernel.org>
> > Cc: Lars-Peter Clausen <lars@metafoo.de>
> > Cc: "Uwe Kleine-König" <u.kleine-koenig@pengutronix.de>
> > Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Cc: "Nuno Sá" <nuno.sa@analog.com>
> > Cc: linux-iio@vger.kernel.org
> > ---
> >  drivers/iio/pressure/dlhl60d.c | 11 +++++++++--
> >  1 file changed, 9 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/iio/pressure/dlhl60d.c b/drivers/iio/pressure/dlhl60d.c
> > index 28c8269ba65d..9bbecd0bfe88 100644
> > --- a/drivers/iio/pressure/dlhl60d.c
> > +++ b/drivers/iio/pressure/dlhl60d.c
> > @@ -250,20 +250,27 @@ static irqreturn_t dlh_trigger_handler(int irq, void *private)
> >  	struct dlh_state *st = iio_priv(indio_dev);
> >  	int ret;
> >  	unsigned int chn, i = 0;
> > -	__be32 tmp_buf[2];
> > +	/* This was only an array pair of 4 bytes. */
> 
> True, which is the right size as far as I can tell.
> If we need this to suppress a warning then comment should say that.

Okay. I think I'll leave it as 2 and manually "unroll" the loop.

> 
> > +	__be32 tmp_buf[4] = { };
> >  
> >  	ret = dlh_start_capture_and_read(st);
> >  	if (ret)
> >  		goto out;
> >  
> > +	/* Nothing was checking masklength vs ARRAY_SIZE(tmp_buf)? */
> 
> Not needed but no way a compiler could know that.
> 
> > +	if (WARN_ON_ONCE(indio_dev->masklength > ARRAY_SIZE(tmp_buf)))
> > +		goto out;
> > +
> >  	for_each_set_bit(chn, indio_dev->active_scan_mask,
> 
> This is all a bit pointless if not 'wrong' other than the
> 4th byte uninitialized part.  The limit can be hard coded as 2 as
> that's a characteristic of this driver.
> 
> For device that always read a particular set of channels they
> should provide indio_dev->available_scan_masks = { BIT(1) | BIT(0), 0 };
> and then always push all the data making this always
> 
> 	memcpy(&tmp_buf[0], &st->rx_buf[1], 3);
> 	mempcy(&tmp_buf[1], &st->rx_buf[1] + 3, 3);

Okay, so this could be unrolled manually to check just for bits 0 and 1?

> 
> The buffer demux code in the IIO core will deal with repacking the data
> if only one channel is enabled.
> 
> >  		indio_dev->masklength) {
> > -		memcpy(tmp_buf + i,
> > +		/* This is copying 3 bytes. What about the 4th? */
> > +		memcpy(&tmp_buf[i],
> >  			&st->rx_buf[1] + chn * DLH_NUM_DATA_BYTES,
> >  			DLH_NUM_DATA_BYTES);
> >  		i++;
> >  	}
> >  
> > +	/* How do we know the iio buffer_list has only 2 items? */
> 
> Can only include items from the channels array at indexes up to the max
> scan_index in there, so 0 and 1 in this case (1 might not be present if only
> one channel is enabled). Sizes (and alignment) are given by storagebits so
> 4 bytes for each.

This code pattern seems repeated through all of iio, so I guess we'll
leave it as-is. It seems like it'd be nice to have a "length" argument
to iio_push_to_buffers(), just to sanity check, but that would need to
be a pretty large patch. :P

> 
> >  	iio_push_to_buffers(indio_dev, tmp_buf);
> >  
> >  out:

Thanks for looking at this!

-Kees

-- 
Kees Cook

