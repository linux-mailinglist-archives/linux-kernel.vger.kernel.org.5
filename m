Return-Path: <linux-kernel+bounces-78806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 395A0861912
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 18:14:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B3EF1C23236
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 17:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C22212B168;
	Fri, 23 Feb 2024 17:12:40 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C84D13A863;
	Fri, 23 Feb 2024 17:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708708359; cv=none; b=SX600kba1/tUWHuWhsoCrw6a5180BoEG8yWbSqwday2f9stlFwu5cWAfsUSJP323Z3AuUn79NbhpxuES6REc6TNZEA/r7u4GbQYtO685Pd5zgl0TezeOtKyDCkcxZsD+u6hmvifFHnU5VvsC8uMQksO3bERlzxAlUYuUXYIc5vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708708359; c=relaxed/simple;
	bh=omVfxmJ5d0K2yC1GRTrc2kykKRrP0QiZLn0MqUh5wF4=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GdrpZsO/wj4Pb1gj46PeT+d9kGi8tWa6QRwb2wcDKc2IjOprKYEiYEGL16Tt+KCcDAvo4pNHm05lZCh81gf+mCqKqXPZ/lE1qD52go6XikKyGfNwZuynqtQ+bXTluz1c5/LvlpOPZHUk8bBBlINwKLdCoXVfZ6+Gjz7qIugB8dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ThGgF35Tnz6K5tk;
	Sat, 24 Feb 2024 01:08:25 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 211CD140F0B;
	Sat, 24 Feb 2024 01:12:35 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 23 Feb
 2024 17:12:34 +0000
Date: Fri, 23 Feb 2024 17:12:33 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Julia Lawall <julia.lawall@inria.fr>
CC: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	<linux-iio@vger.kernel.org>, Rob Herring <robh@kernel.org>, Frank Rowand
	<frowand.list@gmail.com>, <linux-kernel@vger.kernel.org>, Peter Zijlstra
	<peterz@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	<marek.vasut@gmail.com>
Subject: Re: [PATCH v2 0/4] of: automate of_node_put() - new approach to
 loops.
Message-ID: <20240223171233.000069bd@Huawei.com>
In-Reply-To: <3ced0f8-fe6c-a2f4-f7c4-79ecc7c308d@inria.fr>
References: <20240223124432.26443-1-Jonathan.Cameron@huawei.com>
	<Zdi_ToUofu62s5zT@smile.fi.intel.com>
	<20240223163602.0000697a@Huawei.com>
	<3ced0f8-fe6c-a2f4-f7c4-79ecc7c308d@inria.fr>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Fri, 23 Feb 2024 17:38:31 +0100 (CET)
Julia Lawall <julia.lawall@inria.fr> wrote:

> On Fri, 23 Feb 2024, Jonathan Cameron wrote:
> 
> > On Fri, 23 Feb 2024 17:52:46 +0200
> > Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> >  
> > > On Fri, Feb 23, 2024 at 12:44:28PM +0000, Jonathan Cameron wrote:  
> > > > The equivalent device_for_each_child_node_scoped() series for
> > > > fwnode will be queued up in IIO for the merge window shortly as
> > > > it has gathered sufficient tags. Hopefully the precdent set there
> > > > for the approach will reassure people that instantiating the
> > > > child variable inside the macro definition is the best approach.
> > > > https://lore.kernel.org/linux-iio/20240217164249.921878-1-jic23@kernel.org/
> > > >
> > > > v2: Andy suggested most of the original converted set should move to
> > > >     generic fwnode / property.h handling.  Within IIO that was
> > > >     a reasonable observation given we've been trying to move away from
> > > >     firmware specific handling for some time. Patches making that change
> > > >     to appropriate drivers posted.
> > > >     As we discussed there are cases which are not suitable for such
> > > >     conversion and this infrastructure still provides clear benefits
> > > >     for them.  
> > >  
> > > >   iio: adc: rcar-gyroadc: use for_each_available_child_node_scoped()  
> > >
> > > Is this the only one so far? Or do we have more outside of IIO?
> > >
> > > I'm fine with the code if OF maintainers think it's useful.
> > > My concern is to make as many as possible drivers to be converted to
> > > use fwnode instead of OF one.
> > >  
> > Julia wrote a coccinelle script
> > __free() cases
> > https://lore.kernel.org/all/alpine.DEB.2.22.394.2401291455430.8649@hadrien/  
> 
> The script doesn't use fwnode.  It gets rid of of_node_put, asssuming that
> someone has already set that up for __free.

Question I was addressing was a few lines up.
"Or do we have more outside of IIO?"

I should have addressed it immediately after the question
+ not sent half an answer :(

> 
> julia


