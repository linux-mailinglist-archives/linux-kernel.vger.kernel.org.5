Return-Path: <linux-kernel+bounces-78744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F0E986182F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 17:40:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E54EB26C26
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 16:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A19D1292D5;
	Fri, 23 Feb 2024 16:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="cPSpGPfb"
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98197186A;
	Fri, 23 Feb 2024 16:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708706386; cv=none; b=r8YDiwDFKOKaTRvU8CtAfD8ZYTFVNOE7lR/CktYY2ar59CtHOBQroYklhpPYff89iUxLk3o7kmFaA87OxbqjwsZ6wSgUJLe/5wZog6eybrnVUTQEXUsiJKe676sKjfScE0XCUtz0blHGRzZ4PgBQRFsbfiIUTQtyfJFhybaflAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708706386; c=relaxed/simple;
	bh=Eyyd4fCCeFKmwaKN8igGEeVJ7NSJ0KckQXwkQZvFZZY=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=nAhrtZSnLD5aTPqi313nV8lGc6rFgpqxc0inmzFfZNWk9kT+uAlZEF7VQKEyFM6ya0qG/7LkWWtljRCetmApZaUDq/BtyKbJSoW3t471pLl8zyCss7LCKMSaVywm6a3SaPpmaINaNr37JxghPB1ljM19r5ojBtHU/fDar+m9oDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=cPSpGPfb; arc=none smtp.client-ip=192.134.164.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=WlaWiwvIFPdrrOg3qAWisrb28vfZjwD7loFQzxqh5Tk=;
  b=cPSpGPfbqpKVl5lyqr2tHFFAlw7VD9HTotQGtr07yvfFT/zfBpXt/yRC
   AE2n6inNv5DJ5fiklDfA5VzkVoc4khupoM/Y8RW5EP16xeQHqFzaQUljN
   4kpTjRjhDpvbVmFED0xoekmxJMdyGOAO4LVP6sWHQNJN2lgJvkhQqtze6
   Q=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.06,180,1705359600"; 
   d="scan'208";a="153524982"
Received: from wifi-eduroam-85-082.paris.inria.fr ([128.93.85.82])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2024 17:38:32 +0100
Date: Fri, 23 Feb 2024 17:38:31 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
    linux-iio@vger.kernel.org, Rob Herring <robh@kernel.org>, 
    Frank Rowand <frowand.list@gmail.com>, linux-kernel@vger.kernel.org, 
    Peter Zijlstra <peterz@infradead.org>, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>, marek.vasut@gmail.com
Subject: Re: [PATCH v2 0/4] of: automate of_node_put() - new approach to
 loops.
In-Reply-To: <20240223163602.0000697a@Huawei.com>
Message-ID: <3ced0f8-fe6c-a2f4-f7c4-79ecc7c308d@inria.fr>
References: <20240223124432.26443-1-Jonathan.Cameron@huawei.com> <Zdi_ToUofu62s5zT@smile.fi.intel.com> <20240223163602.0000697a@Huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Fri, 23 Feb 2024, Jonathan Cameron wrote:

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
> __free() cases
> https://lore.kernel.org/all/alpine.DEB.2.22.394.2401291455430.8649@hadrien/

The script doesn't use fwnode.  It gets rid of of_node_put, asssuming that
someone has already set that up for __free.

julia

