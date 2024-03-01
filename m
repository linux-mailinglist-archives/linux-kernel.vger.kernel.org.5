Return-Path: <linux-kernel+bounces-89205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16CEC86EBF6
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 23:39:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 405751C21928
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 22:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 695D55EE6A;
	Fri,  1 Mar 2024 22:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gUcXrBeu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3BAC59153;
	Fri,  1 Mar 2024 22:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709332784; cv=none; b=s1h1peWt3JvPoHzmfs07NqLtLo19i1m/49L7mdP1B3Sw//7QMVnoQYx2clcQRWITJznDcomvJgKLXANSVWQcqQCb3Zv5ma3F4Ggja8HblqvhoR427ANrd+bfvBr79K8lDpKfLgBJEUCPz5mfHOUDhsAwQR3w6Wsdnu2/Vcqtdzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709332784; c=relaxed/simple;
	bh=gd1f0JmgW2lhfJwMqf/zdowmXxcjdaYyBE2I6GBLjTc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jGvxCYKXFzXrOiU6XfvvSG9xhoXLHoLSLg6YAB+nfvOj0YvtRxGet4cZOG19Ie1hmMp7QFB/3F2zO3eeAmzW8IL0KiGiEF5nC+2CPK0zkiBDhT65axxUh/bexTavdHwNKXqTTT3FR84ObrizGVQgsd01GMu7OPp62H7cjX6Z834=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gUcXrBeu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A9D3C433F1;
	Fri,  1 Mar 2024 22:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709332784;
	bh=gd1f0JmgW2lhfJwMqf/zdowmXxcjdaYyBE2I6GBLjTc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gUcXrBeuXb+gSba1MISbY8ZI9Asv/8gfB7IcJzmjThNAC3bu9EX8B8M4DHXxm5CmL
	 EhSPkuG5X2QPns555r6RcdyhCXjmI6L7oIsQwDuDb2FcYsaN5KuIimzBCrtfHA8wHH
	 GGju4TZ9bd2Dqwl0Wluz2TVtuVLhL11VEVSyO80M2YJJGifaP0WeGsolwZyY8iO70X
	 YDpUpbnyY3NJopbypb68FKpb0M3NFxD7nGNl7qoOjibLeTPbkhrJtmBhpIAIG8nlv/
	 4bpRDHVfSH3DZoI3e7SOqGeHpVCZsg0/dRKxW4DJ+b473x06C/rKXshhzYzVyamPIx
	 g8XUsaomD19SA==
Date: Fri, 1 Mar 2024 16:39:42 -0600
From: Rob Herring <robh@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
	Frank Rowand <frowand.list@gmail.com>, linux-kernel@vger.kernel.org,
	Julia Lawall <Julia.Lawall@inria.fr>,
	Peter Zijlstra <peterz@infradead.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	marek.vasut@gmail.com,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [RESEND PATCH v2 0/4] of: automate of_node_put() - new approach
 to loops.
Message-ID: <20240301223942.GA3179769-robh@kernel.org>
References: <20240225142714.286440-1-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240225142714.286440-1-jic23@kernel.org>

On Sun, Feb 25, 2024 at 02:27:10PM +0000, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Some discussion occured on previous posting.
> https://lore.kernel.org/linux-iio/20240223124432.26443-1-Jonathan.Cameron@huawei.com/
> 
> Summary:
> * fwnode conversions should be considered when applying this
>   infrastructure to a driver. Perhaps better to move directly to
>   the generic FW property handling rather than improve existing
>   of specific code.
> * There are lots of potential places to use this based on detections
>   from Julia's coccinelle scripts linked below.
> 
> The equivalent device_for_each_child_node_scoped() series for
> fwnode will be queued up in IIO for the merge window shortly as
> it has gathered sufficient tags. Hopefully the precdent set there
> for the approach will reassure people that instantiating the
> child variable inside the macro definition is the best approach.
> https://lore.kernel.org/linux-iio/20240217164249.921878-1-jic23@kernel.org/
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

I'll let you take it. For the series:

Reviewed-by: Rob Herring <robh@kernel.org>

I've got some drivers/of/ conversions too, but they are probably next 
cycle at this point.

Rob

