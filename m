Return-Path: <linux-kernel+bounces-157252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C550D8B0F22
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 17:53:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BF1E1C216DB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 15:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DB0316130A;
	Wed, 24 Apr 2024 15:53:14 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FF6313DBB2;
	Wed, 24 Apr 2024 15:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713973993; cv=none; b=shpI6HKoTwnRdA6pb+NgWa5CMjFvGGAlswLqbYKTOXvdhPTxr+yA7r7cdqCDCvyU+DZpGPYb7p7nyjRAMfJhI07GmAgku2SwyQt1lQTENQ8MAUV6iHgp0fs/brEsMR++2JC4MsfWYhsV18BIp7cBMTfbg+UcW9lbJ5MVJpjksRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713973993; c=relaxed/simple;
	bh=cqQlTJYlnxpdMp1tQKkUwfXxp9N7FIOvRmzCX75X7js=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LlpxOscILPTWY2s9vNkcCHF2ImJbJMwV48J7ju6t8kJESXBhfdhguXx3I6xh4lSxbKJz7BkE2ongSAM0PAjrB481lfuY7FuCw9PSXT2fdm8eiV+PrU4lFLA0INuV17u7MCBc4k4tln+kX5WogFfh5eGHRI9nEXrXIJRwPh2Y8Gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 709531063;
	Wed, 24 Apr 2024 08:53:39 -0700 (PDT)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1D0143F73F;
	Wed, 24 Apr 2024 08:53:10 -0700 (PDT)
Date: Wed, 24 Apr 2024 16:53:07 +0100
From: Andre Przywara <andre.przywara@arm.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Yangtao Li <tiny.windzz@gmail.com>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Chen-Yu Tsai
 <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland
 <samuel@sholland.org>, linux-pm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] cpufreq: sun50i: fix error returns in
 dt_has_supported_hw()
Message-ID: <20240424165307.16f45b21@donnerap.manchester.arm.com>
In-Reply-To: <9bfe5703-b39b-4d98-9995-f6a7d0ea558d@moroto.mountain>
References: <9bfe5703-b39b-4d98-9995-f6a7d0ea558d@moroto.mountain>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 24 Apr 2024 14:40:11 +0300
Dan Carpenter <dan.carpenter@linaro.org> wrote:

Hi Dan,

thanks for having a look!

> The dt_has_supported_hw() function returns type bool.  That means these
> negative error codes are cast to true but the function should return
> false instead.

Ouch, of course! I refactored the function during development, but missed
that part.

> Fixes: fa5aec9561cf ("cpufreq: sun50i: Add support for opp_supported_hw")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Reviewed-by: Andre Przywara <andre.przywara@arm.com>

Thanks,
Andre

> ---
>  drivers/cpufreq/sun50i-cpufreq-nvmem.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/sun50i-cpufreq-nvmem.c b/drivers/cpufreq/sun50i-cpufreq-nvmem.c
> index cd50cea16a87..0b882765cd66 100644
> --- a/drivers/cpufreq/sun50i-cpufreq-nvmem.c
> +++ b/drivers/cpufreq/sun50i-cpufreq-nvmem.c
> @@ -136,11 +136,11 @@ static bool dt_has_supported_hw(void)
>  
>  	cpu_dev = get_cpu_device(0);
>  	if (!cpu_dev)
> -		return -ENODEV;
> +		return false;
>  
>  	np = dev_pm_opp_of_get_opp_desc_node(cpu_dev);
>  	if (!np)
> -		return -ENOENT;
> +		return false;
>  
>  	for_each_child_of_node(np, opp) {
>  		if (of_find_property(opp, "opp-supported-hw", NULL)) {


