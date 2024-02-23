Return-Path: <linux-kernel+bounces-77985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90AE9860DB5
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 10:13:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C2C3284FC8
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 09:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4923258217;
	Fri, 23 Feb 2024 09:13:42 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB6AB1BDEE;
	Fri, 23 Feb 2024 09:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708679621; cv=none; b=d0NmrjgqdlhKN8itCy+ve6/EOmss2rH6NnlM0dhMIka8u1ta44peIdSKQ34uNxNx26uZ2u/TpgzjoAYMAGVMAPv9i6qGiZn2wttOfkKQImOoXYGrEIQANgciHj6o0j0U/clop1hy3An1Q2oaJZ3zARuY1mTPMYXXsG//TaDuX8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708679621; c=relaxed/simple;
	bh=/cxpcMGeXQCVeZ+jggIPGGTTs4Sl/gpFjVZN1g4uHzo=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bII2iLj72jKaIfQATaFa8UU8COt1ba9GoIPk5HbTjwkF/R+UmyYKiKG0nfGuWRCxBNvQF1hFUiWEHjzNwazkb9YsGMA+sVDdAC5k0az0iIZGlFosnO9I2kNt8CRO9XvVWUus+2WHubv9Vl9/aim16lIBm+HSn9Q2NyZbJ9u5j8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Th42G63N9z6JBbR;
	Fri, 23 Feb 2024 17:09:10 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id D5CF81400DC;
	Fri, 23 Feb 2024 17:13:35 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 23 Feb
 2024 09:13:35 +0000
Date: Fri, 23 Feb 2024 09:13:34 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC: Jonathan Cameron <jic23@kernel.org>, <linux-iio@vger.kernel.org>, "Rob
 Herring" <robh@kernel.org>, Frank Rowand <frowand.list@gmail.com>,
	<linux-kernel@vger.kernel.org>, Julia Lawall <Julia.Lawall@inria.fr>, "Peter
 Zijlstra" <peterz@infradead.org>, Nicolas Palix <nicolas.palix@imag.fr>,
	Sumera Priyadarsini <sylphrenadin@gmail.com>, "Rafael J . Wysocki"
	<rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	<linux-acpi@vger.kernel.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>
Subject: Re: [PATCH 0/8] of: automate of_node_put() - new approach to loops.
Message-ID: <20240223091334.00005522@Huawei.com>
In-Reply-To: <Zc9-eSEH-D1n4dAv@smile.fi.intel.com>
References: <20240211174237.182947-1-jic23@kernel.org>
	<ZcoJEUTdMAKdMHd1@smile.fi.intel.com>
	<20240216144756.08e25894@jic23-huawei>
	<Zc9-eSEH-D1n4dAv@smile.fi.intel.com>
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
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Fri, 16 Feb 2024 17:25:45 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Fri, Feb 16, 2024 at 02:47:56PM +0000, Jonathan Cameron wrote:
> > On Mon, 12 Feb 2024 14:03:29 +0200
> > Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:  
> > > On Sun, Feb 11, 2024 at 05:42:28PM +0000, Jonathan Cameron wrote:  
> 
> ...
> 
> > > I'm a bit skeptical about need of this work. What I would prefer to see
> > > is getting rid of OF-centric drivers in IIO. With that, we would need
> > > only fwnode part to be properly implemented.  
> > 
> > To be honest main reason for doing of first was that they have unit tests :)  
> 
> fwnode also has KUnit test. Have you considered adding test cases there?
> 
> > The IIO drivers were more of a proving ground than cases I really cared
> > out cleaning up.  However I'm always of the view that better to make
> > some improvement now than wait for a perfect improvement later.  
> 
> Yes, but in my opinion _in this particular case_ it brings more churn and
> some maybe even not good from educational purposes, i.e. one can look at
> the current series and think "oh, OF is still in use, let me provide my
> driver OF-only (for whatever reasons behind)", while targeting conversion
> first will tell people: "hey, there is an agnostic device property framework
> that should be used in a new code and that's why we have been converting old
> drivers too".
> 
> > However one or two are not going to be converted to fwnode handling
> > any time soon because they make use of phandle based referencing for
> > driver specific hook ups that isn't going to get generic handling any
> > time soon.  
> 
> Sure, exceptions happen.

After the series converting over most of the cases this patch set touched
in IIO, I have 

rcar-gyroadc and the unit test left, which are enough to show the purpose
of the patch and put a few real users in place.

Will submit a v2 with just those 2 users.  Ideal would be to get these in
for the merge window so it is available for other subsystems next cycle.

> 
> > I'll probably focus on getting the fwnode version of this moving
> > forwards first though and 'maybe' convert a few of the easier ones
> > of these over to that framework to reduce how many users of this
> > we end up with in IIO.  
> 
> Thanks!
> 


