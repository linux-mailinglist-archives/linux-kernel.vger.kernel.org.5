Return-Path: <linux-kernel+bounces-61197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C6CC850ED1
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 09:22:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0225B210FA
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 08:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5267BF4E7;
	Mon, 12 Feb 2024 08:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="OmOfxypT"
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62674F4E3;
	Mon, 12 Feb 2024 08:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707726111; cv=none; b=KBW3cgier1921WRk1QK9/f9H1y/43vxVXbz2PSArEhBba8V3W9Aa6+K7JoMOCyQ96+XwY1QIHooWZdTj87nNShL+yIX+L5JYkHkXb7c9X8EIxiozCjfU3eFu8hA568rD5O4g6X07PgS50k/Zj7hdIxXhkbQtzcAlZKq0CjX45ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707726111; c=relaxed/simple;
	bh=g0WQi0HNaqLfu0XOzmwPx5gk2Q2jL0KleSor3EoTheM=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=s0wb9pevvfQDCm04i6y2eeSVGkttzuuVqI8hxno4sVKN9E5R4Vf/aDemvu1Mc5q68Egg8cypdavOX3gx5JYy7xvTPDULUnbU5h0486kk5c0Ua3W7wyoWZZ544SLdg5q93OUtFRJl8doN0UXcECOt4rO0jbaPpy0myc9SQn/L33o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=OmOfxypT; arc=none smtp.client-ip=192.134.164.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=LWPYvSgv0zdZTV2ZQVH85xdYYPR/Wied75A3/ihbQiU=;
  b=OmOfxypTRMnwSRd8PU7qoJQJeRVQXStmHAbSkPN8zkhWCqZ/ALP2yHVK
   pb7aHTNaBe0wEEuDXMty6VS9nyJw+kx7ooaABZ92rdP0ZcEVr9b+fJyp9
   J2vNpntkIuxpcvI5n34FfM9DXLLWaif/0lKy6uScurfkhvmlIMs3dEj1D
   E=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.05,262,1701126000"; 
   d="scan'208";a="79346150"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 09:20:37 +0100
Date: Mon, 12 Feb 2024 09:20:35 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
To: Jonathan Cameron <jic23@kernel.org>
cc: linux-iio@vger.kernel.org, Rob Herring <robh@kernel.org>, 
    Frank Rowand <frowand.list@gmail.com>, linux-kernel@vger.kernel.org, 
    Peter Zijlstra <peterz@infradead.org>, 
    Nicolas Palix <nicolas.palix@imag.fr>, 
    Sumera Priyadarsini <sylphrenadin@gmail.com>, 
    "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
    linux-acpi@vger.kernel.org, 
    Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    =?ISO-8859-15?Q?Nuno_S=E1?= <nuno.sa@analog.com>, 
    Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 2/8] of: Introduce for_each_*_child_of_node_scoped() to
 automate of_node_put() handling
In-Reply-To: <20240211174237.182947-3-jic23@kernel.org>
Message-ID: <6c65d280-9b8f-393c-2adb-2387535ad924@inria.fr>
References: <20240211174237.182947-1-jic23@kernel.org> <20240211174237.182947-3-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Sun, 11 Feb 2024, Jonathan Cameron wrote:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> To avoid issues with out of order cleanup, or ambiguity about when the
> auto freed data is first instantiated, do it within the for loop definition.
>
> The disadvantage is that the struct device_node *child variable creation
> is not immediately obvious where this is used.
> However, in many cases, if there is another definition of
> struct device_node *child; the compiler / static analysers will notify us
> that it is unused, or uninitialized.
>
> Note that, in the vast majority of cases, the _available_ form should be
> used and as code is converted to these scoped handers, we should confirm
> that any cases that do not check for available have a good reason not
> to.

Is it a good idea to make the two changes at once?  Maybe it would slow
down the use of the scoped form, which can really simplify the code.

julia

>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  include/linux/of.h | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/include/linux/of.h b/include/linux/of.h
> index 50e882ee91da..024dda54b9c7 100644
> --- a/include/linux/of.h
> +++ b/include/linux/of.h
> @@ -1430,10 +1430,23 @@ static inline int of_property_read_s32(const struct device_node *np,
>  #define for_each_child_of_node(parent, child) \
>  	for (child = of_get_next_child(parent, NULL); child != NULL; \
>  	     child = of_get_next_child(parent, child))
> +
> +#define for_each_child_of_node_scoped(parent, child) \
> +	for (struct device_node *child __free(device_node) =		\
> +	     of_get_next_child(parent, NULL);				\
> +	     child != NULL;						\
> +	     child = of_get_next_child(parent, child))
> +
>  #define for_each_available_child_of_node(parent, child) \
>  	for (child = of_get_next_available_child(parent, NULL); child != NULL; \
>  	     child = of_get_next_available_child(parent, child))
>
> +#define for_each_available_child_of_node_scoped(parent, child) \
> +	for (struct device_node *child __free(device_node) =		\
> +	     of_get_next_available_child(parent, NULL);			\
> +	     child != NULL;						\
> +	     child = of_get_next_available_child(parent, child))
> +
>  #define for_each_of_cpu_node(cpu) \
>  	for (cpu = of_get_next_cpu_node(NULL); cpu != NULL; \
>  	     cpu = of_get_next_cpu_node(cpu))
> --
> 2.43.1
>
>

