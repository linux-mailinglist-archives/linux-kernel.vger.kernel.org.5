Return-Path: <linux-kernel+bounces-80040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96387862A0C
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 12:03:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77926B210D3
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 11:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA84B101DA;
	Sun, 25 Feb 2024 11:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b="ocdENja4"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F69D267
	for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 11:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708859023; cv=none; b=FBCBPwu8sruOOrhdR/l5f92IhmJA4w+3gVgVf7uia/u8GPf4etrMBhJEnL2cm4cJdaYhklQGFVo7jB86C2/KaIQPlk5C0e9Alka6FKBe5ywlnK5epoZQftg8UpxdBqihJVxiB6FhAMaMjfeahCTuj9GfCjZe0L9RvaP0BUpjFAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708859023; c=relaxed/simple;
	bh=Z5TyrwFS5+g2naMDbgD8Y0Yup48z7yb1zLyYPj4M38M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p7Wyv8igk9OrLXAGO5r7xkrBf/KlMZKtAraqkhzFqiehBEKCHYdp43wxJ3Qyx5BAiOvGSlUtE3Hqu8Wv1GAt2gWJZFOlLGpnwoGp9P+054fhhV3cHRkDl478xpEu9im0yzneZNEdAJLqUmHq3QwHXmuveB4I7ao4CLr2YNwadGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=marliere.net header.i=@marliere.net header.b=ocdENja4; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=marliere.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1dc09556599so19689385ad.1
        for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 03:03:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708859021; x=1709463821;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:dkim-signature:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=15Blst29HGQPopSfvgIrNbaX0gzGv9i907KA2hfl4tk=;
        b=TAnbwktedNrYOjXWCNIM09tfrp3UiQBRqJ1HZUsz/choBCb+iWkhp398jh5OAx67Gt
         bfkmDPSa31tTa7NXJ/Up9A1Q92wWkKN8xQhEKgcIrs904PnY0TvfQ2K8PPUC8eyT9mmU
         K/AE0GBDW91ciUP2ZTmLAyToVk/8hrP1AZiMbsI0VQB1Oub0b55BFTfB7Q46hw5gM7Mb
         AzT6VRcmq7l+IoPuQJP8//M8Vk8TYMXQnD0VkRRmX5O41Pg8fwMXSaY7LV6eXVVSdvPM
         ti1MOOHyso5cXomP794xhAmZMS88a2uZPOoPz5RVh84EUdG2u8fs2l+FpfpMEzzuvX3r
         +fyQ==
X-Forwarded-Encrypted: i=1; AJvYcCVspEocjt/pH/SjKU7iPGM3dGgsABiXuF92RdUhi6Hen2U5kCvrb3k9vDSDzBHos89l7FYjxUZqpm2U2GijRQZmpD1fEI87N9RR6ksx
X-Gm-Message-State: AOJu0YxmRvJKIncfv4Cv2gI4RSXTnaqlV2R99IdIYLlMpnOdKIywdPIm
	id3GQ1LxWHywTo4e8E6GD4U//IN/PKgXwbowH4p/F/aYPkQ+AEoM
X-Google-Smtp-Source: AGHT+IELd7l6EyoDFaFNGZC5uZbM1lQMJV0IFeOzxE7P/kBORfB2Op/gCFMV0iEmD5oxOQZ9P/9M1A==
X-Received: by 2002:a17:902:dac9:b0:1dc:623d:1c3f with SMTP id q9-20020a170902dac900b001dc623d1c3fmr6537152plx.6.1708859020584;
        Sun, 25 Feb 2024 03:03:40 -0800 (PST)
Received: from mail.marliere.net ([24.199.118.162])
        by smtp.gmail.com with ESMTPSA id 21-20020a170902ee5500b001db337d53ddsm2096075plo.56.2024.02.25.03.03.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Feb 2024 03:03:40 -0800 (PST)
Date: Sun, 25 Feb 2024 08:04:29 -0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marliere.net;
	s=2024; t=1708859018;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=15Blst29HGQPopSfvgIrNbaX0gzGv9i907KA2hfl4tk=;
	b=ocdENja46D86FdLm2EarmlZS4PgyoWsVIdnZ93d37/F21HD68dZ7RNKI3B7j1a5AxAzDJt
	KOdQIv20ECLNa8GC7L62qFh6VCg84LtkGvbHCWZnDkRbSBaFvrXtAfoyMn7DSZay0G7TYn
	CECcZEZgbEzLd5Xnd81953pSQeHA3k3PV8JxjHE3pzHK6gG3OC1ey/8s9b7GM519Gljetj
	Fh3376sZrnEoB60Kn8UApdsXcT/6xp4UEERp4mX9CxxOJA+4C6dvQc3sQsPHw5hGlXL+Jk
	galLyTs23wLBpGAmG0jJ6WNvC0TDgmkDchAn2EjZ1Eq1RDiL6YqmBeWrz8fWtA==
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=ricardo@marliere.net smtp.mailfrom=ricardo@marliere.net
From: "Ricardo B. Marliere" <ricardo@marliere.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alex Elder <elder@ieee.org>, Johan Hovold <johan@kernel.org>, 
	Alex Elder <elder@kernel.org>, greybus-dev@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] greybus: constify the struct device_type usage
Message-ID: <yru2ywkyqwhg3rpyuqkkx73fxkkgsfj3vcbttnzrjq662ctrov@boh65bhxjjgo>
References: <20240219-device_cleanup-greybus-v1-1-babb3f65e8cc@marliere.net>
 <cf5b2696-d7ca-40fc-856a-52f352cd270c@ieee.org>
 <ids3525jm5zkwkgizt2xtg3do37kqqtfdy5gc2cptdduexoe7r@cr4yxh3tykkh>
 <2024022553-deepness-sublevel-73de@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024022553-deepness-sublevel-73de@gregkh>

On 25 Feb 09:33, Greg Kroah-Hartman wrote:
> On Sat, Feb 24, 2024 at 05:22:39PM -0300, Ricardo B. Marliere wrote:
> > On 24 Feb 09:43, Alex Elder wrote:
> > > On 2/19/24 6:40 AM, Ricardo B. Marliere wrote:
> > > > Since commit aed65af1cc2f ("drivers: make device_type const"), the driver
> > > > core can properly handle constant struct device_type. Move the
> > > > greybus_hd_type, greybus_module_type, greybus_interface_type,
> > > > greybus_control_type, greybus_bundle_type and greybus_svc_type variables to
> > > > be constant structures as well, placing it into read-only memory which can
> > > > not be modified at runtime.
> > > > 
> > > > Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>
> > > 
> > > This looks good to me.  Assuming it compiles cleanly:
> > > 
> > > Reviewed-by: Alex Elder <elder@linaro.org>
> > 
> > Hi Alex!
> > 
> > Thanks for reviewing.
> > 
> > > 
> > > On another subject:
> > > 
> > > Johan might disagree, but I think it would be nice to make
> > > the definitions of the Greybus device types as static (private)
> > > and make the is_gb_host_device() etc. functions real functions
> > > rather than static inlines in <linux/greybus.h>.
> > > 
> > > It turns out that all of the is_gb_*() functions are called only
> > > from drivers/greybus/core.c; they could all be moved there rather
> > > than advertising them in <linux/greybus.h>.
> > 
> > I guess it depends whether they would be used somewhere else in the
> > future. Perhaps it was left there with that intention when it was first
> > being developed? I agree, though. Will happily send a patch with this if
> > desired.
> 
> Let's clean the code up for what we have today.  If it's needed in the
> future, we can move the structures then.

Sounds good to me, will send a v2 then!

Thank you,
-	Ricardo.


> 
> thanks,
> 
> greg k-h

