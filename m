Return-Path: <linux-kernel+bounces-60429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8944E8504D6
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 16:09:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28D31B20DB1
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 15:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43F525BAD7;
	Sat, 10 Feb 2024 15:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TBxZ6iRT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8332436AF0;
	Sat, 10 Feb 2024 15:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707577760; cv=none; b=tbd6uyJnkm420E9p5M8Fs+SX0R7JX8O6P/iu3dOjl7+aM02yL5vned/l5mWin7z96FLRBIILKRWTbqtEugQ53qZTJdmFOrkV3J2NJXuOT/vwDsM45h2IjL20IpsxuqGYUk0bqz0dVZi6+llp+lpFX7PAx2B06Vh9jZUhb+pHcKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707577760; c=relaxed/simple;
	bh=pLfRpHjTu9m4W1qVp6S/4OIPP2Vk2vK5FIofqlCRYbw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IlKYsHOw5JWFRMas6qSFQ7ni6/EyeEwNZwEj2o1gDhDkeYXmY0P0OUkcjuM4KGTgTKVXQmUTQdPFEKApDypIos+if2xPVjTpKQw9soQKqPdCp48XcE00wGqIuzYRB+rPh5keR/mf61JOSbGKbRy8cqW42AfyCeJsoru4iIKuFyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TBxZ6iRT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02936C433C7;
	Sat, 10 Feb 2024 15:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707577759;
	bh=pLfRpHjTu9m4W1qVp6S/4OIPP2Vk2vK5FIofqlCRYbw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TBxZ6iRTVK8O3qULrXjcu9aWbDLvDocrTlaznymZzOSUUDvG9DNb0cS6/ng7KG7KU
	 B8bBeOTMeiTwKXzlQnJZecrw3WLlSIAcmax5EB2O1Y8MqnsvpHHMHxjbcp7TkVYYhK
	 cGi43eDOCg32mB0olSZermbJQBBvv7RANHcgJ7y2NJTOxkjflaYtY8YBTiq0hl8ETP
	 xZ9un7gG+nX6sx4F34kCEijzdGDJ0PsnbTkHLwHnEZV89Q1ay9fIjak06VcHbF+Y5l
	 LubrmNj1nqLHksfS0DUsPiHfext2+lGklbuQ/R6pGgU64ZT9xJhy3v5cbTPE/pGx+h
	 CjmqCKMNhaIFw==
Date: Sat, 10 Feb 2024 15:09:07 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Petre Rodan <petre.rodan@subdimension.ro>
Cc: andy.shevchenko@gmail.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v2 4/4] iio: pressure: hsc030pa add triggered buffer
Message-ID: <20240210150907.40e27f53@jic23-huawei>
In-Reply-To: <ZcEPJh1i7cc0xyBW@sunspire>
References: <20240127160405.19696-1-petre.rodan@subdimension.ro>
	<20240127160405.19696-5-petre.rodan@subdimension.ro>
	<Zb-1UGJt27OV-vjc@surfacebook.localdomain>
	<ZcEPJh1i7cc0xyBW@sunspire>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 5 Feb 2024 18:39:02 +0200
Petre Rodan <petre.rodan@subdimension.ro> wrote:

> hello Andy,
> 
> On Sun, Feb 04, 2024 at 06:03:28PM +0200, andy.shevchenko@gmail.com wrote:
> [..]
> > > +	memcpy(&data->scan.chan[1], &data->buffer[2], 2);  
> > 
> > Hmm... We don't have fixed-size memcpy() :-(  
> 
> 	__be16 *ptr;
> 
> 	ptr = (__be16 *) data->buffer;
> 	data->scan.chan[0] = *ptr;
> 	data->scan.chan[1] = *++ptr;
> 
> is this an acceptable replacement? I do not understand that your concern was, my
> intent was to copy exactly 2 bytes over.

Andy?

I'm not sure what you meant here either.  

There is an existing oddity that the read_raw deals with this as a be32 and
masking out the right sections for each channel rather than perhaps more logical
be16 pair here.

Jonathan

> 
> > > +	iio_push_to_buffers_with_timestamp(indio_dev, &data->scan,
> > > +					   iio_get_time_ns(indio_dev));  
> 
> thanks,
> peter


