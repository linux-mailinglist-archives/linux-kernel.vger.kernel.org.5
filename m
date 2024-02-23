Return-Path: <linux-kernel+bounces-78750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F362A86183F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 17:43:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91874B26AAD
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 16:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C627B12BE83;
	Fri, 23 Feb 2024 16:42:41 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FB8412AAC7;
	Fri, 23 Feb 2024 16:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708706561; cv=none; b=KCr7yyUjjKoOoYcfERoXUE+/+GX19GsCa3HdZeYgCbOwrRuGz9gUvfMB8eMg7AqI+PfzqYx6g205FLtCAxsfe29ePhHrIfy+ZYN8zBmeahflFYtnXqYlWGuSKm1L+o9l3FLijdi9aPC/lvU85NOjIsyxfpUHLKiQw6CiI9SXHjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708706561; c=relaxed/simple;
	bh=IWsuBkee3xCAQ86kme8tbkr6alhrezjCTnJppe/xkIg=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dKIeqXyNtMUQwJpIT/eeFy/IDeKkUoso51nAy7jwt4n5ysJCqrBOcoaGU4Fd9VDonsY1qE3nKn1AsGhCUkH2sLWYkpGMdivZkTrfcfOrQoa1f2pQcEwq9xuUE7lhaWgTOkqHX3kKqWqBYZqu6jwb6MfQZMeFp0hGqMF7z7AA9NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ThG0f6FZtz67mqV;
	Sat, 24 Feb 2024 00:38:26 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 78C82140684;
	Sat, 24 Feb 2024 00:42:36 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 23 Feb
 2024 16:42:36 +0000
Date: Fri, 23 Feb 2024 16:42:35 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC: <linux-iio@vger.kernel.org>, Rob Herring <robh@kernel.org>, Frank Rowand
	<frowand.list@gmail.com>, <linux-kernel@vger.kernel.org>, Julia Lawall
	<Julia.Lawall@inria.fr>, Peter Zijlstra <peterz@infradead.org>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, <marek.vasut@gmail.com>
Subject: Re: [PATCH v2 0/4] of: automate of_node_put() - new approach to
 loops.
Message-ID: <20240223164235.00000e46@Huawei.com>
In-Reply-To: <20240223163602.0000697a@Huawei.com>
References: <20240223124432.26443-1-Jonathan.Cameron@huawei.com>
	<Zdi_ToUofu62s5zT@smile.fi.intel.com>
	<20240223163602.0000697a@Huawei.com>
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
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Fri, 23 Feb 2024 16:36:02 +0000
Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:

> On Fri, 23 Feb 2024 17:52:46 +0200
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> 
> > On Fri, Feb 23, 2024 at 12:44:28PM +0000, Jonathan Cameron wrote:
> > > The equivalent device_for_each_child_node_scoped() series for
> > > fwnode will be queued up in IIO for the merge window shortly as
> > > it has gathered sufficient tags. Hopefully the precdent set there
> > > for the approach will reassure people that instantiating the
> > > child variable inside the macro definition is the best approach.
> > > https://lore.kernel.org/linux-iio/20240217164249.921878-1-jic23@kernel.org/
> > > 
> > > v2: Andy suggested most of the original converted set should move to
> > >     generic fwnode / property.h handling.  Within IIO that was
> > >     a reasonable observation given we've been trying to move away from
> > >     firmware specific handling for some time. Patches making that change
> > >     to appropriate drivers posted.
> > >     As we discussed there are cases which are not suitable for such
> > >     conversion and this infrastructure still provides clear benefits
> > >     for them.  
> > 
> > >   iio: adc: rcar-gyroadc: use for_each_available_child_node_scoped()  
> > 
> > Is this the only one so far? Or do we have more outside of IIO?
> > 
> > I'm fine with the code if OF maintainers think it's useful.
> > My concern is to make as many as possible drivers to be converted to
> > use fwnode instead of OF one.
> > 
> Julia wrote a coccinelle script 
> __free() cases (53)
> https://lore.kernel.org/all/alpine.DEB.2.22.394.2401291455430.8649@hadrien/
Gah. Second time today I've hit the wrong key whilst pasting.

loop cases. (73)
https://lore.kernel.org/all/alpine.DEB.2.22.394.2401312234250.3245@hadrien/

Scattered right across the kernel.

No others submitted yet and there is just the one left in IIO after fwnode
conversions.  There are other drivers I haven't converted to fwnode for
various reasons, but this isn't useful for them as not all call of_node_put().

Some of the other cases will be suitable for fwnode conversion and that
is definitely the right first choice in many cases.

Agreed, it's down to the OF maintainers to take a call on whether they want
this infrastructure or not.  No longer matters much to me for IIO
as you can see.

Jonathan

