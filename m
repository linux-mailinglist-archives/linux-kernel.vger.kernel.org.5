Return-Path: <linux-kernel+bounces-123016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11B6989011A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 15:06:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A72691F26B44
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 14:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D57EA129E9A;
	Thu, 28 Mar 2024 14:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EynValxe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0960682880;
	Thu, 28 Mar 2024 14:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711634742; cv=none; b=V9n7CXzWm6GU6mUJ/ApU0nhfAcNlYWLu9AG2J0ipr+p+cN8jbyJxuZh4YxilNAISWYAIboCIuIJ5KT9E6ouLqYDBhcvOFiUY/ialivb+C3MeLRR2XUrbXnqcqnQA4ucBxPtyyhBYa35+4bkblUKl2ON/nMmQEVi/CEXmrXNprrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711634742; c=relaxed/simple;
	bh=EinO3RtbM3TdIgTBE67vxWObbXsICsHEkufTBzcRYss=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FTAjV1xw3s6g+gNU05kC5caPmCXwts2cOzRvJvqprW3+2PvyjtdoDtABe0o9a+3BxOgP1zWXgMwgROfK+FrKJYuXe08nIvhZSX6VNDhJkxFuw7B30SS6R1hBTT8d7hcXRN45uQswBCphsaG9TIN+uhDhHUDScaSJsD/RfVdCkNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EynValxe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D80DC433C7;
	Thu, 28 Mar 2024 14:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711634741;
	bh=EinO3RtbM3TdIgTBE67vxWObbXsICsHEkufTBzcRYss=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EynValxen7HB5uREd61Y/MCiL3SKrBpIwIK+Odpq57OsuEHRPhKesevco8VnJuQUA
	 ZnNRKgLy+fWHQaODETgdJXJ8q7vjEGZ/s0AH2Jw/NLurT1jnFSqpXEdBZOzTjkZajz
	 ZZB+zXjdn61nbtrXvJwkGEMSaTUIV/RHQiOVeebhZPyS6B275LVVHfpLgzZN6ioyNk
	 4rgk43euFuglZCzHla+KzLQFI4zjgVTO33ICUepAihQY5yzrofLiF2S1ElC26sL5mn
	 7g2KMrhPBYDjVv3iBg2xcxWs7fCLE1K1VIf1NhRI1Jqy2O9iHkCIftuHveOC3kt4qA
	 SNEgvjJ05Vuog==
Date: Thu, 28 Mar 2024 14:05:25 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Jean Delvare <jdelvare@suse.com>, Guenter
 Roeck <linux@roeck-us.net>, Support Opensource
 <support.opensource@diasemi.com>, Cosmin Tanislav
 <cosmin.tanislav@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Antoniu Miclaus
 <antoniu.miclaus@analog.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hwmon@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-staging@lists.linux.dev, linux-input@vger.kernel.org
Subject: Re: [PATCH RFC 2/7] hwmon: (adc128d818) Use
 devm_regulator_get_optional_enable_get_voltage()
Message-ID: <20240328140525.6364512e@jic23-huawei>
In-Reply-To: <20240327-regulator-get-enable-get-votlage-v1-2-5f4517faa059@baylibre.com>
References: <20240327-regulator-get-enable-get-votlage-v1-0-5f4517faa059@baylibre.com>
	<20240327-regulator-get-enable-get-votlage-v1-2-5f4517faa059@baylibre.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 27 Mar 2024 18:18:51 -0500
David Lechner <dlechner@baylibre.com> wrote:

> We can reduce boilerplate code and eliminate the driver remove()
> function by using devm_regulator_get_optional_enable_get_voltage().
> 
> A new external_vref flag is added since we no longer have the handle
> to the regulator to check if it is present.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
One trivial thing.
With that tidied up...

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

>  	hwmon_dev = devm_hwmon_device_register_with_groups(dev, client->name,
>  							   data, adc128_groups);
>  	if (IS_ERR(hwmon_dev)) {
>  		err = PTR_ERR(hwmon_dev);
> -		goto error;
> +		return err;

return PTR_ERR()

>  	}
>  
>  	return 0;
> -
> -error:
> -	if (data->regulator)
> -		regulator_disable(data->regulator);
> -	return err;
> -}

