Return-Path: <linux-kernel+bounces-61442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86215851269
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 12:38:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 829F0B2876B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 11:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A139D39847;
	Mon, 12 Feb 2024 11:37:41 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E0E63984F;
	Mon, 12 Feb 2024 11:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707737861; cv=none; b=DBlVsjg7dNht3+8uR737t2ga8hMCJVtBbNH4kzh28ndZmF02hFRyCheU76wRFZxthwxGFUYTy/Np2Z24og8P2uALXsKTVLByUGxPJyn8MZ9QUDLCDySEwMm3ypT76UhlK/JN5/HSn7GKhgPUbk1JTTu1QRAduN2BTqz1U6eUAis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707737861; c=relaxed/simple;
	bh=LANI5gKq1ByHLjiH+h5+HQGDiFqfmM8ncEdFP0M7WX0=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pSuPs8kn6UweINtRcsff2NlHJQCqt0up1H7fA5nUhOVaGKjUv8cnl8xJBunKMZPgdkXmOlgC9TqHX8MZN5/9l4JhO30sWhxQpl/yTHGK9K7DhYz5znYv+u3x1w8GP4lrxcbqA18b+SDD7aiRhqHVmfueHWY/pYEngmwjzFB9Nqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TYMmM33vZz67lZn;
	Mon, 12 Feb 2024 19:33:55 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id EA940140DAF;
	Mon, 12 Feb 2024 19:37:29 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 12 Feb
 2024 11:37:29 +0000
Date: Mon, 12 Feb 2024 11:37:28 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Julia Lawall <julia.lawall@inria.fr>
CC: Jonathan Cameron <jic23@kernel.org>, <linux-iio@vger.kernel.org>, "Rob
 Herring" <robh@kernel.org>, Frank Rowand <frowand.list@gmail.com>,
	<linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	Nicolas Palix <nicolas.palix@imag.fr>, Sumera Priyadarsini
	<sylphrenadin@gmail.com>, "Rafael J . Wysocki" <rafael@kernel.org>, "Len
 Brown" <lenb@kernel.org>, <linux-acpi@vger.kernel.org>, Andy Shevchenko
	<andriy.shevchenko@linux.intel.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>
Subject: Re: [PATCH 2/8] of: Introduce for_each_*_child_of_node_scoped() to
 automate of_node_put() handling
Message-ID: <20240212113728.00001e81@Huawei.com>
In-Reply-To: <6c65d280-9b8f-393c-2adb-2387535ad924@inria.fr>
References: <20240211174237.182947-1-jic23@kernel.org>
	<20240211174237.182947-3-jic23@kernel.org>
	<6c65d280-9b8f-393c-2adb-2387535ad924@inria.fr>
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
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Mon, 12 Feb 2024 09:20:35 +0100 (CET)
Julia Lawall <julia.lawall@inria.fr> wrote:

> On Sun, 11 Feb 2024, Jonathan Cameron wrote:
> 
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >
> > To avoid issues with out of order cleanup, or ambiguity about when the
> > auto freed data is first instantiated, do it within the for loop definition.
> >
> > The disadvantage is that the struct device_node *child variable creation
> > is not immediately obvious where this is used.
> > However, in many cases, if there is another definition of
> > struct device_node *child; the compiler / static analysers will notify us
> > that it is unused, or uninitialized.
> >
> > Note that, in the vast majority of cases, the _available_ form should be
> > used and as code is converted to these scoped handers, we should confirm
> > that any cases that do not check for available have a good reason not
> > to.  
> 
> Is it a good idea to make the two changes at once?  Maybe it would slow
> down the use of the scoped form, which can really simplify the code.

Good question.  I combined them based on what I think Rob was asking for.

Rob,

What would you prefer?

Jonathan

> 
> julia
> 
> >
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > ---
> >  include/linux/of.h | 13 +++++++++++++
> >  1 file changed, 13 insertions(+)
> >
> > diff --git a/include/linux/of.h b/include/linux/of.h
> > index 50e882ee91da..024dda54b9c7 100644
> > --- a/include/linux/of.h
> > +++ b/include/linux/of.h
> > @@ -1430,10 +1430,23 @@ static inline int of_property_read_s32(const struct device_node *np,
> >  #define for_each_child_of_node(parent, child) \
> >  	for (child = of_get_next_child(parent, NULL); child != NULL; \
> >  	     child = of_get_next_child(parent, child))
> > +
> > +#define for_each_child_of_node_scoped(parent, child) \
> > +	for (struct device_node *child __free(device_node) =		\
> > +	     of_get_next_child(parent, NULL);				\
> > +	     child != NULL;						\
> > +	     child = of_get_next_child(parent, child))
> > +
> >  #define for_each_available_child_of_node(parent, child) \
> >  	for (child = of_get_next_available_child(parent, NULL); child != NULL; \
> >  	     child = of_get_next_available_child(parent, child))
> >
> > +#define for_each_available_child_of_node_scoped(parent, child) \
> > +	for (struct device_node *child __free(device_node) =		\
> > +	     of_get_next_available_child(parent, NULL);			\
> > +	     child != NULL;						\
> > +	     child = of_get_next_available_child(parent, child))
> > +
> >  #define for_each_of_cpu_node(cpu) \
> >  	for (cpu = of_get_next_cpu_node(NULL); cpu != NULL; \
> >  	     cpu = of_get_next_cpu_node(cpu))
> > --
> > 2.43.1
> >
> >  


