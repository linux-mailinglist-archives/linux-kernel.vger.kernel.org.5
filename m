Return-Path: <linux-kernel+bounces-78916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3C0A861A9A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 18:51:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F164286934
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 17:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 201EE13DBA3;
	Fri, 23 Feb 2024 17:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XNfHMMyW"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C39134CCA
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 17:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708710613; cv=none; b=oC6bsOb73JA/Q9tVU1VVqQqTIpNs+jjS+IEcYFiuCztArORVK5P2Vou0hLIs2vIGUssphji46OV50SzdLRVN6V3UVMFJWv1NverfRBZV2rEXlmf4r3FDFLgsPIwoZPbTvPc9PvUwsJHwZHOQgZGTHcyv+0rMjfirLJHYBhV4cPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708710613; c=relaxed/simple;
	bh=CjG7WgCgFDAFL/tReNZpG/kD85Tt86MKrrUPD2AYLQk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GcLpkzPBPVkpS/sfgSx5ayZgKKcMKqjc9KfWPOwE3F1CkrN7PpuZPRA8iBdgWcww01UcKlYVB2sobv7wpuz5yn9TMI0d+r75K2sKdJ5NJHVuW35QIn/xx5hGdybSEPN1ygA+TtToyiLhSczWIuLgV0jPV/BX/JVJKZ3fBOqRsSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=XNfHMMyW; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-5cdbc4334edso787247a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 09:50:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708710611; x=1709315411; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Fh8E4x68Izt4HceoSL2C5zjPW+nFmkMjm9Tr07dbTE4=;
        b=XNfHMMyWWywPWp6ekMQN2xw5jYA2vu0lHbsC/j8YCsn+aQlDzdprJ3E6jhtEMi2o21
         i42tsViP1d2CHrY5kkF9+W5IyGrSFhJYLbbkLDm5yHnSHLg75qJ+jsvGYMDIZ1qyqTIE
         uYVyL+TZTDVCWwUzkKosPaR/upLby1n5XNrKs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708710611; x=1709315411;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Fh8E4x68Izt4HceoSL2C5zjPW+nFmkMjm9Tr07dbTE4=;
        b=i8xHkknFIj/bEvbsASURA/x+8xo9XuuKxy4JBDVNSgl0HcynsDJKEntou4w7kSeEyQ
         UM/MnA0j7RIuio4eJcYrj0iwPhfJ3iBYqcwcX3u92Z4KMOPlsQiR+PxGMboHwqLDNQOg
         XORcfpgd51xn+lb6xKBbwmb31l0YfJiSlsMkpybXXQkxQB2EwfpCADtN+y8Wk5nSfQ22
         x+qHeIucyie6pDtiszWt1ZuQvJQrAwOI8ybLibB1DpgmljNNYK+vp9ZXC9Jq+f259wZO
         Y806SKRWIa7DCSBA7rgsdbYSciSDuOeMt8jcMtkMtVrCbe+sFDBi6Dqp3e0vRYuLhOJX
         pcKw==
X-Forwarded-Encrypted: i=1; AJvYcCUg5PLguLwm9kKnUxlKipCeijWh3Ec2rdPYz5YV/c2HgBoqNwYxVzgbA8TiUqSeOl30Kt6rRbdCUxuyjjAinmvLNZXsQ/5rlWgwXFOl
X-Gm-Message-State: AOJu0YzGny1x7pQ/7lD+GCiOMIZx6AxdjJwhwc7t7sBBJWxwOg4c9vco
	zECxoez7HWK7x6GlBjwHjsyJUBBR4tpxcRFaH9/2JshWc09ADp2h/ktyDLF6Pg==
X-Google-Smtp-Source: AGHT+IH1UP6oOCdgigSlZN7GfzqMGdE+JitpTrFkneg82nmtKJhtaUdsf1z4v1ua63Pt3t+NHytt5w==
X-Received: by 2002:a05:6a20:a901:b0:1a0:61e4:a940 with SMTP id cd1-20020a056a20a90100b001a061e4a940mr573533pzb.45.1708710610948;
        Fri, 23 Feb 2024 09:50:10 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id u2-20020a656702000000b005dc26144d96sm10977296pgf.75.2024.02.23.09.50.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 09:50:10 -0800 (PST)
Date: Fri, 23 Feb 2024 09:50:10 -0800
From: Kees Cook <keescook@chromium.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	linux-iio@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, llvm@lists.linux.dev,
	Tomislav Denis <tomislav.denis@avl.com>,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] iio: pressure: dlhl60d: Initialize empty DLH bytes
Message-ID: <202402230949.E06F3297@keescook>
References: <20240223172936.it.875-kees@kernel.org>
 <ZdjaOLVd1yxNXhsp@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZdjaOLVd1yxNXhsp@smile.fi.intel.com>

On Fri, Feb 23, 2024 at 07:47:36PM +0200, Andy Shevchenko wrote:
> On Fri, Feb 23, 2024 at 09:29:39AM -0800, Kees Cook wrote:
> > 3 bytes were being read but 4 were being written. Explicitly initialize
> > the unused bytes to 0 and refactor the loop to use direct array
> > indexing, which appears to silence a Clang false positive warning[1].
> 
> ...
> 
> >  	for_each_set_bit(chn, indio_dev->active_scan_mask,
> > -		indio_dev->masklength) {
> > -		memcpy(tmp_buf + i,
> > +			 indio_dev->masklength) {
> > +		memcpy(&tmp_buf[i++],
> >  			&st->rx_buf[1] + chn * DLH_NUM_DATA_BYTES,
> >  			DLH_NUM_DATA_BYTES);
> > -		i++;
> >  	}
> 
> Not that I'm against the changes, but they (in accordance with the commit
> message) are irrelevant to this fix. I prefer fixes to be more focused on
> the real issues.

Jonathan, let me know if you'd prefer I split this patch...

-- 
Kees Cook

