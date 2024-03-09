Return-Path: <linux-kernel+bounces-98005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2D55877339
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 19:25:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 175E71C215C8
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 18:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC305481C4;
	Sat,  9 Mar 2024 18:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XyVATKzI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AA06481A7;
	Sat,  9 Mar 2024 18:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710008396; cv=none; b=H+x/o4pW6CYhJwkvpt+NoXEGMr+du2hVS0bkz9us/rf11SsBCVDTQKaE0b2B+3+jVreSulYHRTwPTwwgdsv70Fr6mv7k2RMeIRElqs3YLkn6b8lrOgOinSqob6KxkEtb/moH8qVhhNdx1oQ2//08MwnimxGaxgkyCAqcSouuNjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710008396; c=relaxed/simple;
	bh=xwPSJ7u/u8eKM3hiZZ05+P5z2GbwUDxdaFWTSwWYdrI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=laI3ya1s3wuEOCmh3TIGxOXxLpBjWRk0MdksB1Cco1lo7lkiPvNuRz0WvQ0UkHYZjJj5F/vY4vmi1mqm76Epip0b6M3H33ywb1OTto1wbfpRBnUPmzhXFVs1H0f4VgxWuynNmiDjUCwvjYACrurLqj/2J2dBhPnH0sc1LRGBZ3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XyVATKzI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85646C433C7;
	Sat,  9 Mar 2024 18:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710008395;
	bh=xwPSJ7u/u8eKM3hiZZ05+P5z2GbwUDxdaFWTSwWYdrI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XyVATKzIg3DUzc+hCVGAY/fxLL4iFPPQTos1kSNqCoq9qOs5Vc2sE+KJQHHtUwVHm
	 jJ5OJNg5o+Dym8O5n1C9zaPcn5QJt9Rg3Gb5nb4IGcfuAwD2P7oeavKFC1klx9KQyB
	 3wBE1B8+D1e3UNyKzeb8s2ACUl13wHDGElg/eflQTfIXhmdQh7LWgFbeUpoKj7Tz6z
	 kXsJP/TTrFW6lf56bBCPnsvP38TPh2uMswhhg0JE/YHYIo+SWbappJGkj5aP8lQmGP
	 wK89Xl4m13/G2+bTBeLIXMHgoRJOgpTIzsL/k9l/Z9tJcwB/bj1eLsO8wvCJZSq10W
	 eg5WhgLTy/vcw==
Date: Sat, 9 Mar 2024 18:19:42 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, lars@metafoo.de,
 ang.iglesiasg@gmail.com, mazziesaccount@gmail.com, ak@it-klinger.de,
 petre.rodan@subdimension.ro, phil@raspberrypi.com, 579lpy@gmail.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] iio: pressure: Add triggered buffer support for
 BMP280 driver
Message-ID: <20240309181942.5a60c3a7@jic23-huawei>
In-Reply-To: <20240304200547.GA10314@vamoiridPC>
References: <20240303165300.468011-1-vassilisamir@gmail.com>
	<20240303165300.468011-5-vassilisamir@gmail.com>
	<ZeW15Q2juyQuTw5q@smile.fi.intel.com>
	<20240304190838.GA4431@vamoiridPC>
	<ZeYegxEF521ixMTs@smile.fi.intel.com>
	<20240304200547.GA10314@vamoiridPC>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 4 Mar 2024 21:05:47 +0100
Vasileios Amoiridis <vassilisamir@gmail.com> wrote:

> On Mon, Mar 04, 2024 at 09:18:27PM +0200, Andy Shevchenko wrote:
> > On Mon, Mar 04, 2024 at 08:08:38PM +0100, Vasileios Amoiridis wrote:  
> > > On Mon, Mar 04, 2024 at 01:52:05PM +0200, Andy Shevchenko wrote:  
> > > > On Sun, Mar 03, 2024 at 05:53:00PM +0100, Vasileios Amoiridis wrote:  
> > 
> > ...
> >   
> > > > > +	struct {
> > > > > +		s32 temperature;
> > > > > +		u32 pressure;
> > > > > +		u32 humidity;  
> > > >   
> > > > > +		s64 timestamp;  
> > > > 
> > > > Shouldn't this be aligned properly?  
> > > 
> > > I saw that in some drivers it was added and in some it was not. What is the
> > > difference of aligning just the timestamp of the kernel?  
> > 
> > You can count yourself. With provided structure as above there is a high
> > probability of misaligned timeout field. The latter has to be aligned on
> > 8 bytes.
> >   
> 
> I was unaware, but now I am not. Thank you very much for the feedback.

Fun bit of C is that you aren't actually aligning just the timestamp.
A C structure is aligned to the alignment of the maximum element within it.
So by specifying that timestamp is aligned to 8 bytes, you also force the
alignment of the whole structure to 8 bytes.

When you see the outer buffer aligned as well (typically the potentially larger
__aligned (IIO_DMA_MINALIGN)) that's for a different reason.  Used on a trailing
element of a structure via iio_priv() that ensures there is nothing else in the
cacheline (maximum one in the system) on systems where this matters due to non
coherent DMA.  Still need the __aligned(8) on the timestamp though as otherwise
the internal padding may be wrong (like here).

On some architectures small buffers are always bounced - if that were true on
all of them we could get rid of the complexity of IIO_DMA_MINALIGN.

Alignment is so much fun - particularly with x86_32 which does 8 byte values aligned
to 4 bytes. We had a massive set of patches fixing subtle issues around that a
few years ago.

Jonathan

  
> > > > > +	} iio_buffer;  
> > 
> > -- 
> > With Best Regards,
> > Andy Shevchenko
> > 
> >   


