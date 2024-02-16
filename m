Return-Path: <linux-kernel+bounces-68761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7701F857FBE
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 15:48:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EF741C2373E
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 14:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0FFD12F385;
	Fri, 16 Feb 2024 14:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hw5R7ZNz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD5912C812;
	Fri, 16 Feb 2024 14:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708094890; cv=none; b=oE4ijALqkqMZyw8lrbdj7fMhN5GlU5sRfWc+VuNRwGyQQYx/ThxRSKqzDJbklnxBRSST3oso/q87tcb2B1xVosBKftCBW0LA9+hTxC3SmjL3UklNQsENSB4XZDK4A01K4+NLglI9OfAbd8lqY2abdQQfET0rXnjuYzcV6UZVzRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708094890; c=relaxed/simple;
	bh=K44i2DqBgPJ7hcROlXOpw2GUYsBOzblxH4exPmx/m7E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ONBqVHW/DqBTgAb+9pgLQfd4fBGFRZ3dEwWhyOzTxc4kgSavuX5ZX13N+362l43p5IajLi1KJRr9zvzhDBhvs4exXwfK/fpePKkgHaanM52K+RQPj2UTtPP9oOwkOV0YF/nfqLEsea2OocZqgaWeJfc+NSNkQCAZsP9uNCxl+Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hw5R7ZNz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D5DDC43390;
	Fri, 16 Feb 2024 14:48:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708094889;
	bh=K44i2DqBgPJ7hcROlXOpw2GUYsBOzblxH4exPmx/m7E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Hw5R7ZNzL50e0lBhiiS4QmPuoshCVtH+ucSgCFvn47Y5tjgLFdjUdbjXiqra+RPKo
	 jVYfVOb1H6GaR71LhkJT2hkZ1ieMdGraTZqeTXQ4XetOsMqdVH5r7O0pBSwgfRoqvi
	 MnNMnUEGEKIItwy+zSb0wALsa2UcIBYontsLC5XxmV/stSJg5eQ/8Nl+2qcOBK1ZaP
	 ZaOhAVOp5F1HdBlWW8rpyjfNv16VtV+j9QvFJCLJ30jq1eiCFgd0lfBlBH/9sbTWmm
	 pJ9mnHYq8+YMCbdkvkFaY++VjtI1FAmrK0MoLiV4jsxYmxrN69xxfPL6GsSP8BIITz
	 7E8VO1cRbYB/Q==
Date: Fri, 16 Feb 2024 14:47:56 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-iio@vger.kernel.org, Rob Herring <robh@kernel.org>, Frank Rowand
 <frowand.list@gmail.com>, linux-kernel@vger.kernel.org, Julia Lawall
 <Julia.Lawall@inria.fr>, Peter Zijlstra <peterz@infradead.org>, Nicolas
 Palix <nicolas.palix@imag.fr>, Sumera Priyadarsini
 <sylphrenadin@gmail.com>, "Rafael J . Wysocki" <rafael@kernel.org>, Len
 Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 0/8] of: automate of_node_put() - new approach to loops.
Message-ID: <20240216144756.08e25894@jic23-huawei>
In-Reply-To: <ZcoJEUTdMAKdMHd1@smile.fi.intel.com>
References: <20240211174237.182947-1-jic23@kernel.org>
	<ZcoJEUTdMAKdMHd1@smile.fi.intel.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 12 Feb 2024 14:03:29 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Sun, Feb 11, 2024 at 05:42:28PM +0000, Jonathan Cameron wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > Since RFC:
> > - Provide a for_each_available_child_of_node_scoped() variant and
> >   use that whenever we aren't specifically trying to include disabled
> >   nodes.
> > - Fix the for_each_child_of_node_scoped() to not use a mix of
> >   _available_ and other calls.
> > - Include a few more examples.  The last one is there to show that
> >   not all uses of the __free(device_node) call are due to the loops.  
> 
> I'm a bit skeptical about need of this work. What I would prefer to see
> is getting rid of OF-centric drivers in IIO. With that, we would need
> only fwnode part to be properly implemented.
> 

To be honest main reason for doing of first was that they have unit tests :)

The IIO drivers were more of a proving ground than cases I really cared
out cleaning up.  However I'm always of the view that better to make
some improvement now than wait for a perfect improvement later.
 
However one or two are not going to be converted to fwnode handling
any time soon because they make use of phandle based referencing for
driver specific hook ups that isn't going to get generic handling any
time soon.

I'll probably focus on getting the fwnode version of this moving
forwards first though and 'maybe' convert a few of the easier ones
of these over to that framework to reduce how many users of this
we end up with in IIO.

Jonathan








