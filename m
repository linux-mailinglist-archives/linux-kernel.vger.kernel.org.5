Return-Path: <linux-kernel+bounces-78100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 022A0860EE9
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 11:08:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7ACB1B2340E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 10:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0AD85CDDC;
	Fri, 23 Feb 2024 10:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="lesdaC3A"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB17F29D08;
	Fri, 23 Feb 2024 10:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708682887; cv=none; b=U/eS3UFA54HSlWOxEHEXr0T0ERgqbFwHgB94xoJoCM1YbT5+nE8kCUhUrqZ+kfTr1DNGiJYfKy5LmL/Wb6yNVyORkaUoJFvc71/PSRwbcEXpYXR+wrrt1i4gbTTNkvBMR+pG2MNIe/buV4RZ+B9ZhvhdsR2AW2xKS+x63SZX3E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708682887; c=relaxed/simple;
	bh=Zin8l2qPLCAOlaxlh9w1w0UDrji5ob34On52/vcAqkA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X3T363u6SW8ublAlniunN5PCeqlT2rZCcFN6o5JUEJAGvyV5XegnV9O4LcTbz2IuCGxrYDsNKH3UX66i3qQdnqn77+eTe1+CTBwFb/yXqT77JhNmO0ktgQTRcWXzhYZeZhpYRZDVn2f5e4h5cVnuRHlmym4QOl+BKzpvk4UYaQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=lesdaC3A; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9A3A524000A;
	Fri, 23 Feb 2024 10:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708682876;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5c3jkfiwWBVIVcLpQtxgvJnB9TnAlyKeMM5FmscF5j8=;
	b=lesdaC3AUqO4IhojWmi1I7Z8Y86vi8R00ZOyKv++IK4CwhLPLOgn5XY5k4oR3MF9KxG5bP
	FHh8Vwvv8ZqVP7QC7gAed27JRdYn4HIB7z1pIItzXg4YYNTrETeym5e/QwVk9lB36wh9tm
	JxbCR6BLtTMDJO9AvkEoN32a3DNz4gcCTqKL8Tr4ZDnrsyAQx7L0BHAgfYciUrRKAtWAd6
	TbBK9YZKs7K2AT92OvKym9dtZqqCJBhxy0zzQxhyw1V+Tke2vFi33vAh1YiWLCw5Dgt4Bl
	LyPfMMvW0GnXiDCqRuf8EqRFC3wBpgyr9kKf/gl7Wy0DYjAFj74/A+0yraffPA==
Date: Fri, 23 Feb 2024 11:07:52 +0100
From: Herve Codina <herve.codina@bootlin.com>
To: Yury Norov <yury.norov@gmail.com>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rasmus Villemoes
 <linux@rasmusvillemoes.dk>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Andrew Lunn
 <andrew@lunn.ch>, Mark Brown <broonie@kernel.org>, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v4 3/5] lib/bitmap: Introduce bitmap_scatter() and
 bitmap_gather() helpers
Message-ID: <20240223110752.2329d3f0@bootlin.com>
In-Reply-To: <ZdfBuFZ7tf4b+3n8@yury-ThinkPad>
References: <20240222142219.441767-1-herve.codina@bootlin.com>
	<20240222142219.441767-4-herve.codina@bootlin.com>
	<Zddqr3aN4rU-upai@smile.fi.intel.com>
	<20240222174959.7097c29b@bootlin.com>
	<ZdfBuFZ7tf4b+3n8@yury-ThinkPad>
Organization: Bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

Andy, Yury,

On Thu, 22 Feb 2024 13:50:48 -0800
Yury Norov <yury.norov@gmail.com> wrote:

> On Thu, Feb 22, 2024 at 05:49:59PM +0100, Herve Codina wrote:
> > Hi Andy, Yury,
> > 
> > On Thu, 22 Feb 2024 17:39:27 +0200
> > Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > 
> > ...  
> > > > + * bitmap_scatter() for the bitmap scatter detailed operations).    
> > >   
> > > > + * Suppose scattered computed using bitmap_scatter(scattered, src, mask, n).
> > > > + * The operation bitmap_gather(result, scattered, mask, n) leads to a result
> > > > + * equal or equivalent to src.    
> > > 
> > > This paragraph...
> > >   
> > > > + * The result can be 'equivalent' because bitmap_scatter() and bitmap_gather()
> > > > + * are not bijective.    
> > > 
> > >   
> > > > + * The result and src values are equivalent in that sense that a call to
> > > > + * bitmap_scatter(res, src, mask, n) and a call to bitmap_scatter(res, result,
> > > > + * mask, n) will lead to the same res value.    
> > > 
> > > ...seems duplicating this one.
> > > 
> > > I would drop the latter one.  
> > 
> > I would like to give details about the 'equivalent' in this scatter/gather case.  
> 
> If you would like - please do! :)
>  
> > If Yury is ok, I can drop this last paragraph.  
> 
> The original bitmap_onto() description is 3 times longer, and barely
> that descriptive. I'm OK with your working and especially pictures.
> 

Right, I will keep my last paragraph in the next iteration.

Regards,
Hervé



