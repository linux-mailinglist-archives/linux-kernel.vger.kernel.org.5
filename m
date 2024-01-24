Return-Path: <linux-kernel+bounces-37481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97C6483B0A7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 19:03:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5189B288F86
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 18:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0A47129A8D;
	Wed, 24 Jan 2024 18:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="OGAnfko9"
Received: from mail.codeweavers.com (mail.codeweavers.com [4.36.192.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C04C27E778;
	Wed, 24 Jan 2024 18:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.36.192.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706119397; cv=none; b=Ef85waT4cRLHEiErkpqSeNm1qrUcmO+AAvzuIQa5pvMKRHwUH1MCnldHRb43mRl9Brj4tvfJJo4RolegjhMfWm0C855Fr1GYalWzb2NMnHvwdj+0n28bqJZ8C+Kut/klItFJ6gNDzfWQ/o2XTxUQEe9UB+ZXMbWxu7XgrPddQB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706119397; c=relaxed/simple;
	bh=bTzKhd4Vdam5ERW3M7c5bvxorwduJzmfAqrXA6UqVAA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y6CmXNaIKNOiqoXmfDzkbpKj29UC8XKqtT3B3eDr3o5rJf2ZOt/WxQQQU2rXwnq1Y2G9eE3BW8XdYknPFT2LDxyLA/F41GHlhgWms4pWBRtYLcjiNAFCELFXZbkCTg/uOhUNzGgZEH0bqKXolIL+bDBzYQAiRR6TZ23B1WawZjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com; spf=pass smtp.mailfrom=codeweavers.com; dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b=OGAnfko9; arc=none smtp.client-ip=4.36.192.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeweavers.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codeweavers.com; s=s1; h=Message-ID:Date:Subject:Cc:To:From:Sender;
	bh=EgQaF8x2DRjGMV5K7O4i6mK/I6jmASKOSLI9NikLiVQ=; b=OGAnfko9CUjl52+4q4w3XK/FJu
	v+hIFX9ql6Xu3SL4KhkEdM1w6L1383UDISKQLKxJq8+JB4D+Lwl5sil94/HsCOVc2mhWnVwbKvwj9
	pj3V9+5dFdLzdBQbsXwl2aPx6wym4ai6UEvfm9Czwanb1Wfc7dMClF5Zhi9wVj8pxKqKEGcpEGjBz
	6S3mGKpKPr0R9BeafF+NJ2uqV8GeoLSoJSF7oiuUbDaDP3p7O8gIjD09q+6Z0qgMMuJ3t7bsl21Ls
	Ro+fZbXFsMWSQsMzhyLhUlLiUjALxYOVglyJG198wrN8w2Tps4aG0N80lJQDvL6xEMiqnSIoi3JC1
	xOTTq5Sg==;
Received: from cw137ip160.mn.codeweavers.com ([10.69.137.160] helo=camazotz.localnet)
	by mail.codeweavers.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <zfigura@codeweavers.com>)
	id 1rShaj-00EKfU-14;
	Wed, 24 Jan 2024 12:03:13 -0600
From: Elizabeth Figura <zfigura@codeweavers.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
 Arnd Bergmann <arnd@arndb.de>
Cc: wine-devel@winehq.org,
 =?ISO-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
 Wolfram Sang <wsa@kernel.org>, Arkadiusz Hiler <ahiler@codeweavers.com>,
 Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH 8/9] ntsync: Introduce NTSYNC_IOC_PUT_MUTEX.
Date: Wed, 24 Jan 2024 12:03:13 -0600
Message-ID: <2171522.irdbgypaU6@camazotz>
In-Reply-To: <4027ec4c-1e11-40fc-a9af-07732d7c3c1a@app.fastmail.com>
References:
 <20240124004028.16826-1-zfigura@codeweavers.com>
 <20240124004028.16826-9-zfigura@codeweavers.com>
 <4027ec4c-1e11-40fc-a9af-07732d7c3c1a@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Wednesday, 24 January 2024 01:42:19 CST Arnd Bergmann wrote:
> On Wed, Jan 24, 2024, at 01:40, Elizabeth Figura wrote:
> > @@ -738,6 +803,8 @@ static long ntsync_char_ioctl(struct file *file, 
> > diff --git a/include/uapi/linux/ntsync.h b/include/uapi/linux/ntsync.h
> > index 26d1b3d4847f..2e44e7e77776 100644
> > --- a/include/uapi/linux/ntsync.h
> > +++ b/include/uapi/linux/ntsync.h
> > @@ -46,5 +46,7 @@ struct ntsync_wait_args {
> >  					      struct ntsync_wait_args)
> >  #define NTSYNC_IOC_CREATE_MUTEX		_IOWR(NTSYNC_IOC_BASE, 5, \
> >  					      struct ntsync_mutex_args)
> > +#define NTSYNC_IOC_PUT_MUTEX		_IOWR(NTSYNC_IOC_BASE, 6, \
> > +					      struct ntsync_mutex_args)
> > 
> 
> In your implementation, this argument is not written back to
> user space, so I think this should be _IOW rather than than _IORW.
> 
> Again, no practical difference here.

Hm, but there is a put_user() at the end of the function, or am I missing something?



