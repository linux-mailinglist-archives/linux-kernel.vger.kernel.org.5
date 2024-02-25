Return-Path: <linux-kernel+bounces-80096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD8AA862AB1
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 15:26:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57315281AAC
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 14:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FB3C134B2;
	Sun, 25 Feb 2024 14:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kkZhsTN9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B045079D3;
	Sun, 25 Feb 2024 14:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708871170; cv=none; b=k3SN4/xND+XUaRZmOeCk0PYopACfdfZ2o5ZZgOre/6MSGd329IXdEUDarg5AjdXK8y7AocJCD1Gz9pDSvudisDUdnwzChaLfqcIdxTZrJVeuACK3ZUIZMHe5rfkM/owXzFjwXwbe7+MK9WRjGalmuXN3xF1gPD9tsLJRFpfv8OM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708871170; c=relaxed/simple;
	bh=DSkIOEmSp0C6kr5aSqiw6aDcTQkT4NmpKejcQ5yj5vQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=soAEX2kcbHHAD0R+ObcekhqbeQA2xEDN492XeFNH+PNHIg6u6s+X9PWUWpD6ogUe4RQlOHMCvzuslq5la26oPq5tD2mX6mpAE7RpOFH7KkzYX+t/dEeRCPQti+G+Wsz3gxIEH4FND15HW8Zov7TeEvruRaiNXXSHEWUHktR0Nts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kkZhsTN9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB897C433F1;
	Sun, 25 Feb 2024 14:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708871170;
	bh=DSkIOEmSp0C6kr5aSqiw6aDcTQkT4NmpKejcQ5yj5vQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kkZhsTN9XAiyaBMtDDyksufVLT3WhEXWjwe8uPjGEyQ1Lg0+ENVTan2CR3isrn2Qd
	 co0QwhMSI76mZvgZZ/51IsXGfsRgpk/k8V2iAZN2MEunrClFUWlgL3jpTcdLTswxMF
	 w+u8GJC8QLzP4AJ+4gj2UacBRRCDNcwb0+uST3U/jKbnXDss8Rb44ujNzzM4Ywhdcf
	 Udq3c/wgjJUB9jToGkDv/t9DhWu8Z2+wCONuUnF/tOAmDkivJqByjMCPXgzYn/nSnJ
	 whOqCuUxpqEX+IixDIBPyzjQvKb+xPg1XOxPAvPxeRusw6r8z5/QmJvq6dT0HjtvUQ
	 c+FYPPFB9VT5g==
Date: Sun, 25 Feb 2024 14:25:55 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: <linux-iio@vger.kernel.org>, Rob Herring <robh@kernel.org>, Frank Rowand
 <frowand.list@gmail.com>, <linux-kernel@vger.kernel.org>, Julia Lawall
 <Julia.Lawall@inria.fr>, Peter Zijlstra <peterz@infradead.org>, Andy
 Shevchenko <andriy.shevchenko@linux.intel.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, <marek.vasut@gmail.com>
Subject: Re: [PATCH v2 0/4] of: automate of_node_put() - new approach to
 loops.
Message-ID: <20240225142555.6afdec07@jic23-huawei>
In-Reply-To: <20240223124432.26443-1-Jonathan.Cameron@huawei.com>
References: <20240223124432.26443-1-Jonathan.Cameron@huawei.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 23 Feb 2024 12:44:28 +0000
Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:

> The equivalent device_for_each_child_node_scoped() series for
> fwnode will be queued up in IIO for the merge window shortly as
> it has gathered sufficient tags. Hopefully the precdent set there
> for the approach will reassure people that instantiating the
> child variable inside the macro definition is the best approach.
> https://lore.kernel.org/linux-iio/20240217164249.921878-1-jic23@kernel.org/

I missed the devicetree list. Will resend with a brief summary of the
discussion on v2 so far.  Sorry for the noise!
> 
> v2: Andy suggested most of the original converted set should move to
>     generic fwnode / property.h handling.  Within IIO that was
>     a reasonable observation given we've been trying to move away from
>     firmware specific handling for some time. Patches making that change
>     to appropriate drivers posted.
>     As we discussed there are cases which are not suitable for such
>     conversion and this infrastructure still provides clear benefits
>     for them.
> 
> Ideally it would be good if this introductory series adding the
> infrastructure makes the 6.9 merge window. There are no dependencies
> on work queued in the IIO tree, so this can go via devicetree
> if the maintainers would prefer. I've had some off list messages
> asking when this would be merged, as there is interest in building
> on it next cycle for other parts of the kernel (where conversion to
> fwnode handling may be less appropriate).
> 
> The outputs of Julia's scripts linked below show how widely this can be
> easily applied and give a conservative estimate of the complexity reduction
> and code savings. In some cases those drivers should move to fwnode
> and use the equivalent infrastructure there, but many will be unsuitable
> for conversion so this is still good win.
> 
> Edited cover letter from v1:
> 
> Thanks to Julia Lawal who also posted coccinelle for both types (loop and
> non loop cases)
> 
> https://lore.kernel.org/all/alpine.DEB.2.22.394.2401312234250.3245@hadrien/
> https://lore.kernel.org/all/alpine.DEB.2.22.394.2401291455430.8649@hadrien/
> 
> The cover letter of the RFC includes information on the various approaches
> considered.
> https://lore.kernel.org/all/20240128160542.178315-1-jic23@kernel.org/
> 
> Whilst these macros produce nice reductions in complexity the loops
> still have the unfortunate side effect of hiding the local declaration
> of a struct device_node * which is then used inside the loop.
> 
> Julia suggested making that a little more visible via
>  #define for_each_child_of_node_scoped(parent, struct device_node *, child)
> but in discussion we both expressed that this doesn't really make things
> all that clear either so I haven't adopted this suggestion.
> 
> 
> 
> Jonathan Cameron (4):
>   of: Add cleanup.h based auto release via __free(device_node) markings.
>   of: Introduce for_each_*_child_of_node_scoped() to automate
>     of_node_put() handling
>   of: unittest: Use for_each_child_of_node_scoped()
>   iio: adc: rcar-gyroadc: use for_each_available_child_node_scoped()
> 
>  drivers/iio/adc/rcar-gyroadc.c | 21 ++++++---------------
>  drivers/of/unittest.c          | 11 +++--------
>  include/linux/of.h             | 15 +++++++++++++++
>  3 files changed, 24 insertions(+), 23 deletions(-)
> 


