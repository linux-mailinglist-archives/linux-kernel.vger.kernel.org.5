Return-Path: <linux-kernel+bounces-48389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F241845B56
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 16:24:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C2BD2930A8
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 15:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CF456216A;
	Thu,  1 Feb 2024 15:21:50 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6FF062164;
	Thu,  1 Feb 2024 15:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706800909; cv=none; b=Fo8XC0VzK1+gmyHKGvzVALMBqE9/aYCCssqsQMWwKBsE8xYIKRom696388fEe0vq2mNdIcHJBip6BK7WH15m3fjF/NzSN0D+Z4rW8Fa/WCcTgyWZVxV9uFFymd+aMjQviUZXa2h1btW1hDhnWuklZK0fVD22x34h7Qzq9ZG529U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706800909; c=relaxed/simple;
	bh=J2Fi4XHVN1Jz6WkErdbO9Tc/fjc+p7m1fDIZnr5SYJA=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cHoMYfDRfnMhUa2E0C96kaFOSIn2DSF3skPM5e/kKNcd8kEa9yMsrHQnwHSKSYIpFt/Q8oiX++XUmgfZ/RUFxfKtQubDx4g9syMzG0DlapJN9jUxauReZkdW6HUnJdSJNvP/f0C844cHyjuV1N3hmi7CAP0AploTdm7loKPLEIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TQjGh5Yt0z6K8wZ;
	Thu,  1 Feb 2024 23:18:36 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 689371400DB;
	Thu,  1 Feb 2024 23:21:45 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 1 Feb
 2024 15:21:44 +0000
Date: Thu, 1 Feb 2024 15:21:44 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC: Jonathan Cameron <jic23@kernel.org>, <linux-iio@vger.kernel.org>, "Rob
 Herring" <robh@kernel.org>, Frank Rowand <frowand.list@gmail.com>,
	<linux-kernel@vger.kernel.org>, Julia Lawall <Julia.Lawall@inria.fr>,
	"Nicolas Palix" <nicolas.palix@imag.fr>, Sumera Priyadarsini
	<sylphrenadin@gmail.com>, "Rafael J . Wysocki" <rafael@kernel.org>, "Len
 Brown" <lenb@kernel.org>, <linux-acpi@vger.kernel.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>
Subject: Re: [RFC PATCH 0/5] of: automate of_node_put() - new approach to
 loops.
Message-ID: <20240201152144.000078d6@Huawei.com>
In-Reply-To: <Zbt-fw8eUrQzBjX9@smile.fi.intel.com>
References: <20240128160542.178315-1-jic23@kernel.org>
	<Zbt-fw8eUrQzBjX9@smile.fi.intel.com>
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
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

> > 3) Introduced the pointer to auto put device_node only within the
> >    for loop scope.
> > 
> > +#define for_each_child_of_node_scoped(parent, child) \
> > +	for (struct device_node *child __free(device_node) =		\
> > +	     of_get_next_child(parent, NULL);				\
> > +	     child != NULL;						\  
> 
> Just
> 
> 	     child;

Agreed that's the same, but was thinking to follow local style.
I don't feel strongly though so fine with dropping the != NULL

> 
> > +	     child = of_get_next_available_child(parent, child))
> > +
> > 
> > This series is presenting option 3.  I only implemented this loop out of
> > all the similar ones and it is only compile tested.
> > 
> > Disadvantage Rob raised is that it isn't obvious this macro will instantiate
> > a struct device_node *child.  I can't see a way around that other than option 2
> > above, but all suggestions welcome.  Note that if a conversion leaves an
> > 'external' struct device_node *child variable, in many cases the compiler
> > will catch that as an unused variable. We don't currently run shaddow
> > variable detection in normal kernel builds, but that could also be used
> > to catch such bugs.  
> 


