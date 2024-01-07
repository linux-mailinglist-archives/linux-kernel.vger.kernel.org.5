Return-Path: <linux-kernel+bounces-18920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9509582651F
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 17:32:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C4091F215F9
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 16:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B627E134B0;
	Sun,  7 Jan 2024 16:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uGhrVE5i"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E4413FE3;
	Sun,  7 Jan 2024 16:32:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F73DC433C7;
	Sun,  7 Jan 2024 16:32:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704645144;
	bh=exh9kYUXjvd715QZ32/MSnUargXIWrOgxzdke+sLuKA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uGhrVE5iJDZYQeAfO9XWjw0R53LcCKY8K2RMtvhzCzfJbwHlDMXWqTB+Uths0/qQx
	 FTE1CgvhVNWbk4lNmwQv1xRWl6YNdN/1Qp38jkXUmnuZUg29q/h0OU1SIUvoC9zV6y
	 x/NzMZdKf3zPjN2n2v/4RqH1GwTqfjfoyxD7shL9NRjRZyBDSXh7Rah7JBHgrFPw0C
	 usHSOIILG06OPxYi7AH/lz8MYopZdquj1JXLiYx3QG35d/3wtqJxPfo4gjfA3QXAia
	 PgYlopKkdAYyQ0dMUryZK9EJXr+7Wso4VGIgtpzflG3JvJyl5kRXKFUiuPLAqvdrk+
	 CzLrY+bLnwWgw==
Date: Sun, 7 Jan 2024 16:32:15 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Petre Rodan <petre.rodan@subdimension.ro>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Andreas Klinger <ak@it-klinger.de>,
 Lars-Peter Clausen <lars@metafoo.de>, Angel Iglesias
 <ang.iglesiasg@gmail.com>, Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [PATCH v3 10/10] iio: pressure: mprls0025pa add SPI driver
Message-ID: <20240107163215.427b563d@jic23-huawei>
In-Reply-To: <ZZl628UdGQ_Bu2jy@smile.fi.intel.com>
References: <20231229092445.30180-1-petre.rodan@subdimension.ro>
	<20231229092445.30180-11-petre.rodan@subdimension.ro>
	<ZZlyDT0J4n1_YXh4@smile.fi.intel.com>
	<ZZl5rBPOKwvxZAAx@sunspire>
	<ZZl628UdGQ_Bu2jy@smile.fi.intel.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.39; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 6 Jan 2024 18:07:55 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Sat, Jan 06, 2024 at 06:02:52PM +0200, Petre Rodan wrote:
> > On Sat, Jan 06, 2024 at 05:30:21PM +0200, Andy Shevchenko wrote:  
> > > On Fri, Dec 29, 2023 at 11:24:38AM +0200, Petre Rodan wrote:  
> > > > Add SPI component of the driver.  
> 
> > > > +#include <linux/mod_devicetable.h>
> > > > +#include <linux/module.h>
> > > > +#include <linux/spi/spi.h>
> > > > +#include <linux/stddef.h>  
> > > 
> > > Basically here we need additionally these ones:
> > > 
> > > device.h
> > > errno.h
> > > types.h  
> > 
> > ok, I'll add errno.h. the other two are in the shared .h file.  
> 
> Yes, but it's better to follow IWYI principle. Generally speaking
> there is no guarantee that above will be _always_ the case.
> 
> Anyway, I leave this to Jonathan.
> 
When it's a local include to the driver like this I don't mind
as much if the includes aren't there in the c file, but do generally
'slightly prefer' them to be so.  As such I've added them here and
in the i2c file (I also renamed that patch as 'refactor' isn't
exactly descriptive in the patch title!)  I suspect none of us
feel that strongly about this so rather than slowing things down
I took a fairly random decision that let me apply the series today.

Anyhow, along with dropping the text on what this was tested on in
the final patch - series applied to the togreg branch of iio.git.

However, I'll be rebasing that tree on rc1 once available hence
for now this will only be pushed out as testing for 0-day to get
a head start on poking it.

Thanks,

Jonathan



