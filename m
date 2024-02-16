Return-Path: <linux-kernel+bounces-68902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E6C48581AB
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 16:48:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 606621C216BD
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 15:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C385B12F5AB;
	Fri, 16 Feb 2024 15:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LTJTgDpi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09BC078B5C;
	Fri, 16 Feb 2024 15:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708098475; cv=none; b=niX9f7OuJqQ6QCzhsNIz0haQ5qGoyXmNpjdtt1GXRaHF0zqAwarYIvIoDp9n/AgjnXYJmspyYQ2bzhCwJw8CR0MudBr6ZJq1pm2eTSRQ1MvHF33xej+m4cX9YHF9AUze9xcb3wJ7u+K04EltUkBxb89NaPmfMHg0Ddgn1eJTReQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708098475; c=relaxed/simple;
	bh=//k0SvhCxQhftvOC+GhG0NKWK1nXrfUeUMgoGAuA3tw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S9o3r9MNIUrA73WfJWbmXdZE7YNFBeM849AbXlEoHjIcnyFJj2jDFtRYQMKQ3Vg2/5IbU/czWTCTcsIt4/dvy0Ye7klwG9GQbSQTUsJUAXMPx93z9Ognk7GqrSe2Rlrj4PBCJXNUEfXjjbzxqiDJsWtDQaqDSscuKnGfbg60xtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LTJTgDpi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6D55C433F1;
	Fri, 16 Feb 2024 15:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708098474;
	bh=//k0SvhCxQhftvOC+GhG0NKWK1nXrfUeUMgoGAuA3tw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LTJTgDpiXIa3C0ltza04ggfd1K8nuPfGeI1aNgCrVpV1cKngufLi5Jt1MZG7fiLF6
	 dNAFf09Z60BaiAhfND6nHQmZrDCr7oDd57U4BViP/+XB7+WWZtvVh5ODK3jzicxdZb
	 4YuKmBGQW1HaC5YYBKBDwl9NOu8jM0Glb2YyLS81H4cr08WxfLGNwKDBH1VJMVsIlP
	 MKEgvQxkr7hNR7u+xPSCOQyoVota0icQIMKCBiI5I1sFBvo3vrEu+xl8hBOSxgxDzg
	 sG33ULumZvqoE9b17qhHKt1E3UHBnN8+CJhsQEp6Yn2/JmDVzcuuPuOcNp3dWdaWBp
	 IA2IHTDCNIkiQ==
Date: Fri, 16 Feb 2024 15:47:42 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: lars@metafoo.de, ang.iglesiasg@gmail.com,
 andriy.shevchenko@linux.intel.com, 579lpy@gmail.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers: iio: pressure: Add SPI support for BMP38x and
 BMP390
Message-ID: <20240216154742.685bd875@jic23-huawei>
In-Reply-To: <20240216132644.GA4236@vamoiridPC>
References: <20240215164332.506736-1-vassilisamir@gmail.com>
	<20240216111834.73287ab0@jic23-huawei>
	<20240216132644.GA4236@vamoiridPC>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 16 Feb 2024 14:26:44 +0100
Vasileios Amoiridis <vassilisamir@gmail.com> wrote:

> On Fri, Feb 16, 2024 at 11:18:34AM +0000, Jonathan Cameron wrote:
> > On Thu, 15 Feb 2024 17:43:32 +0100
> > Vasileios Amoiridis <vassilisamir@gmail.com> wrote:
> >   
> > > According to the datasheet of BMP38x and BMP390 devices, in SPI
> > > operation, the first byte that returns after a read operation is
> > > garbage and it needs to be dropped and return the rest of the
> > > bytes.  
> > 
> > Make it clear in the patch title that this is a fix and add a fixes tag.
> >   
> 
> The original support for SPI was added 8 years ago. Should I include that commit
> of 8 years ago in the fixes tag or just use a the word "fixes" with the rest of the
> title?
> 
Original git commit for the fixes tag.  Lets us know this wants to go in all stable kernels.
Also fixes in the title.


> > > +	ssize_t status;
> > > +	u8 buf;
> > > +
> > > +	memcpy(&buf, reg, reg_size);
> > > +	buf |= 0x80;  
> > 
> > Can you use regmap_bus read_flag_mask for this?  Seems to apply to 
> > all devices supported. + that's common for spi regmaps
> >  
> 
> Yes I noticed it yesterday in my tests that this was missing and it actually
> applies to all the devices. So the read_flag_mask should be added to both
> regmap_bus structs. 

It's there sort of indirectly for the bmp280 - the register addresses all happen
to include that bit, then it is cleared explicitly for the other direction.



> > 
> > Mind you I note the bmp280_regmap_spi_write() is masking the bit out which seems
> > backwards  - all the registers are defined with the bit set for that part
> > but not the 380.  Ah well - not part of this fix even if it's odd.
> > 

> > > diff --git a/drivers/iio/pressure/bmp280.h b/drivers/iio/pressure/bmp280.h
> > > index 4012387d7956..ca482b7e4295 100644
> > > --- a/drivers/iio/pressure/bmp280.h
> > > +++ b/drivers/iio/pressure/bmp280.h
> > > @@ -191,6 +191,8 @@
> > >  #define BMP380_TEMP_SKIPPED		0x800000
> > >  #define BMP380_PRESS_SKIPPED		0x800000
> > >  
> > > +#define BMP380_SPI_MAX_REG_COUNT_READ   3  
> > This doesn't seem useful as only used in one place.  
> 
> Could this define be moved in the bmp280-spi.c file or to not even use a define?
Not use it. Don't see how it is helpful. Just check that the
thing will fit in the array using an ARRAY_SIZE()...
> 
> > > +
> > >  /* BMP280 specific registers */
> > >  #define BMP280_REG_HUMIDITY_LSB		0xFE
> > >  #define BMP280_REG_HUMIDITY_MSB		0xFD  
> >   


