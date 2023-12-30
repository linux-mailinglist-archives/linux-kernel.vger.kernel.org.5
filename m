Return-Path: <linux-kernel+bounces-13403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FC798204A0
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 12:35:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E8EEB214ED
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 11:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E82779C2;
	Sat, 30 Dec 2023 11:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U5n/1dIl"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5DAE5676;
	Sat, 30 Dec 2023 11:34:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D72A9C433C8;
	Sat, 30 Dec 2023 11:34:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703936091;
	bh=1yYEGXvx/YDRGmJ5mBECuPkbf2R58XFI65h+zZJ+hE8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=U5n/1dIlvru2ILAHUy4fukwKHQtmfPKekQCobkHm8aCa74HOEwFVtKbfuKSg3xC8c
	 ytDK4wl5vBK7RcWCnD5dmVoqMxb3KvJv2K3vyQCHniMBniHW17q9u2XE2nkwiNe88F
	 hSjZdO7PG1Febjzvx4aHs3CNnbxJuG5FG+BmyOr42RkW4TFwEyjm49QlxWysEc05vb
	 bNDLhA1vOWrC8D4CB2u33muSOLUT0hBvXy084NhfVKWo//DDq0aY+FyW4VgPmr9fyk
	 eKR3nnNPMOyps0uRBKXtsvT/067UNJAWZdDFL7sg8+Z/f+M7gzRj18IdFBu5R72pYu
	 jZnZDbZs70+zg==
Date: Sat, 30 Dec 2023 11:34:44 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Petre Rodan <petre.rodan@subdimension.ro>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Andreas Klinger <ak@it-klinger.de>,
 Lars-Peter Clausen <lars@metafoo.de>, Angel Iglesias
 <ang.iglesiasg@gmail.com>, Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [PATCH v2 08/10] iio: pressure: mprls0025pa.c refactor
Message-ID: <20231230113444.74de6b93@jic23-huawei>
In-Reply-To: <ZYxS1o2lSlaJ6dG4@smile.fi.intel.com>
References: <20231224143500.10940-1-petre.rodan@subdimension.ro>
	<20231224143500.10940-9-petre.rodan@subdimension.ro>
	<20231226164922.6d7132c1@jic23-huawei>
	<ZYw1wbvYQqqCr5C2@sunspire>
	<ZYxS1o2lSlaJ6dG4@smile.fi.intel.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 27 Dec 2023 18:37:42 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Wed, Dec 27, 2023 at 04:33:37PM +0200, Petre Rodan wrote:
> > On Tue, Dec 26, 2023 at 04:49:22PM +0000, Jonathan Cameron wrote:  
> 
> ,,,
> 
> > > >  		ret = devm_request_irq(dev, data->irq, mpr_eoc_handler,
> > > > -				IRQF_TRIGGER_RISING, client->name, data);
> > > > +				      IRQF_TRIGGER_RISING, dev_name(dev), data);  
> > > 
> > > Even though you'll change it again here, would have been nice to have
> > > the alignment fixed in the earlier patch then the code update here.  
> > 
> > I tried this, but due to the fact that the line has to be right-aligned to
> > column 80 we will still see a whitespace difference due to the length diff of
> > the name-related argument.  
> 
> You can split in the previous patch accordingly, so data comes to a new line.
> 
> ...
> 
> > > > +#include <linux/iio/iio.h>  
> > > 
> > > Why include this?  Can't see an IIO specific stuff in here.  
> > 
> > tried to remove it and
> > 
> >   CC [M]  mprls0025pa_i2c.o
> > mprls0025pa.h:89:63: error: 'IIO_DMA_MINALIGN' undeclared here (not in a function); did you mean 'ARCH_DMA_MINALIGN'?
> >    89 |         u8          buffer[MPR_MEASUREMENT_RD_SIZE] __aligned(IIO_DMA_MINALIGN);  
> 
> > I guess it makes more sense to move it to the .h file, where buffer[] is defined.  
> 
> Yes, C-code and especially headers should follow IWYI principle. The real user
> of that definition is _the header_ file, and not C in this case.

Absolutely - it is clear why this should be included from the header file.

Jonathan

> 
> 


