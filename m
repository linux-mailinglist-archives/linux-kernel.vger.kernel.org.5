Return-Path: <linux-kernel+bounces-82239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F5348680FA
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 20:27:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F2421C225C6
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 19:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88E1A12FF64;
	Mon, 26 Feb 2024 19:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lrxavY2O"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDAED12F5A4;
	Mon, 26 Feb 2024 19:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708975647; cv=none; b=YWw04rN75topSTo7swK7T24LdHzv83ZXigMSQPIR2TH9pL50gyvSczqjYTI0gfBkDl+mbt/OC8KGsi83Skwg7O1TLhxfDatY4wGNzLbOtKnsbN/7imu4JVglbKmDVp6tG9bpsvgIDJ+4/VlvyquAYYra8zd05w0Dt3mLt39ZYHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708975647; c=relaxed/simple;
	bh=aJbYoUvl3lfn7Y5sMCUZh5e5qg+OrgmfaaR50t0lkJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W/eK1cCqflsfzGl4LOlsBnM3Q57oc96LKPQ+e0gN/jyr/vpLExE4JzHu3p7Nx+URLjFfT9qlNqCDTamH8KmNwhRr/0CRpJJX2fS6umC89YWPDc8hk5iymAF6Jm4y0b46oKhYrPAF72jwsICj45dJzm7/PFBdhMZMKEJNcM8ke4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lrxavY2O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D891C433F1;
	Mon, 26 Feb 2024 19:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708975647;
	bh=aJbYoUvl3lfn7Y5sMCUZh5e5qg+OrgmfaaR50t0lkJQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lrxavY2Owp9oUSCoyyk7c/jH+HbEE7iLdJMWXEjCj8Iz8OrkGd21LKCfDiWtbksUn
	 eSvBJf0UL3HTBonJ+o2BzGVV1ktYQr4FxRcBtJfuPsc/UYTYheo/M3eafrSsTdzJEK
	 6oRw7QJhT+D44GIXlXs7As7ovpSx6kHGaPgQPzB/qu5ymbKREirSosOsT9cMOcIKdJ
	 H0VKJiefYNPBcuzHs2OWI35jRe+b2aCOweOAHMLVFDcc0caPndshNvFGFXiWzmRjoA
	 FXB6lFzXyxxyxoWI1KQhBBT6iCHW1Ba/Je1/euDHbsd9+NwFwZY/qZJGMssborKpBx
	 2qiDHHNtLcFgA==
Date: Mon, 26 Feb 2024 19:27:11 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Nathan Chancellor <nathan@kernel.org>, Nick
 Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>,
 Justin Stitt <justinstitt@google.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH v2 2/2] iio: proximity: isl29501: make use of
 of_device_id table
Message-ID: <20240226192711.1da77a05@jic23-huawei>
In-Reply-To: <20240225201654.49450-2-krzysztof.kozlowski@linaro.org>
References: <20240225201654.49450-1-krzysztof.kozlowski@linaro.org>
	<20240225201654.49450-2-krzysztof.kozlowski@linaro.org>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 25 Feb 2024 21:16:54 +0100
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> Reference the of_device_id table in the driver structure, so it will be
> used for module autoloading and device matching.  This fixes clang W=1
> warning:
> 
>   isl29501.c:999:34: error: unused variable 'isl29501_i2c_matches' [-Werror,-Wunused-const-variable]
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Applied just patch 2.

Thanks,

Jonathan
> 
> ---
> 
> Rework according to comments.
> 
> An old v1:
> https://lore.kernel.org/all/20230810111933.205619-1-krzysztof.kozlowski@linaro.org/
> ---
>  drivers/iio/proximity/isl29501.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/proximity/isl29501.c b/drivers/iio/proximity/isl29501.c
> index bcebacaf3dab..4982686fb4c3 100644
> --- a/drivers/iio/proximity/isl29501.c
> +++ b/drivers/iio/proximity/isl29501.c
> @@ -995,17 +995,16 @@ static const struct i2c_device_id isl29501_id[] = {
>  
>  MODULE_DEVICE_TABLE(i2c, isl29501_id);
>  
> -#if defined(CONFIG_OF)
>  static const struct of_device_id isl29501_i2c_matches[] = {
>  	{ .compatible = "renesas,isl29501" },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(of, isl29501_i2c_matches);
> -#endif
>  
>  static struct i2c_driver isl29501_driver = {
>  	.driver = {
>  		.name	= "isl29501",
> +		.of_match_table = isl29501_i2c_matches,
>  	},
>  	.id_table	= isl29501_id,
>  	.probe		= isl29501_probe,


