Return-Path: <linux-kernel+bounces-122993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3250D8900C8
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 14:48:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D832128830E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 13:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3CBE7EEED;
	Thu, 28 Mar 2024 13:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PeSn9Tui"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB707F489;
	Thu, 28 Mar 2024 13:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711633682; cv=none; b=Qp5XZcXafFTodKs+0n9+K+3gf69Hw0lSirrf7V1RVf7hecq1ytvbfgJi0K/42u0za3EfCNNnVubhCxk6jQpH0xkt3ekRnDkCV1YNb19/LQY0g0hLQoPHitVDMYnWFbgcQgH57t95m0EpGWmGmQ9CH9+qeigjUEVnegf8cPxkFzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711633682; c=relaxed/simple;
	bh=Mqk/uL+0zGkb+VyKKk8rS4iYfMD/QaQUPhXTSjQmDsI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BTkHVrB0gQ0cf8th+UJPrUIdtLzsS1Ruoofb5aaBYeicOgrTyrSAD0BeuK24J1dK8YdbNN4xMO1EyECZYrC4O3nWC1BWrZh4YmEFAT+pGfp8Zzo8NZ1sG40HWqtqld4+ICeiuHc0WE0HpQDb+fT5h6izkKOvyBoBhPpc7WGiSRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PeSn9Tui; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7882EC433C7;
	Thu, 28 Mar 2024 13:47:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711633682;
	bh=Mqk/uL+0zGkb+VyKKk8rS4iYfMD/QaQUPhXTSjQmDsI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PeSn9TuiD+ZvpMPt1FytmMu033LmGwqF16/Mfzbs/m3o+q2cL1KCC+6OSchrYxLX2
	 C36qBS6AsUVX/2ZkKHujEbDjLv50888t/I86ZeG4GqP5ybbe3OPdykMO1JCPIo6iFF
	 YoADpWP36TARDUlJfEvPvlgjOy/wPsBFL2rPYto0hb2DgYEczssWERRzs8uICcdatl
	 9MVDbpLRA3s1IAsQQeIHCQXE9zPaJOglroGA9/dtQ7gSINZ2a0axRanmk1uq0ZLG62
	 v5bJgdBahpirDUOuwTsofKTRH5G25UGAt7UyUwF0whWN0c6O4zQ9uOYl3gtLQp8Xbi
	 klISroPU87d0A==
Date: Thu, 28 Mar 2024 13:47:44 +0000
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
Subject: Re: [PATCH RFC 1/7] regulator: devres: add APIs for reference
 supplies
Message-ID: <20240328134744.2fc263b9@jic23-huawei>
In-Reply-To: <20240327-regulator-get-enable-get-votlage-v1-1-5f4517faa059@baylibre.com>
References: <20240327-regulator-get-enable-get-votlage-v1-0-5f4517faa059@baylibre.com>
	<20240327-regulator-get-enable-get-votlage-v1-1-5f4517faa059@baylibre.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 27 Mar 2024 18:18:50 -0500
David Lechner <dlechner@baylibre.com> wrote:

> A common use case for regulators is to supply a reference voltage to an
> analog input or output device. This adds two new devres APIs to get,
> enable, and get the voltage in a single call. This allows eliminating
> boilerplate code in drivers that use reference supplies in this way.
> 
> devm_regulator_get_enable_get_voltage() is intended for cases where the
Maybe avoid the double get?
devm_regulator_get_enable_read_voltage() perhaps?

> supply is required to provide an external reference voltage.
> 
> devm_regulator_get_optional_enable_get_voltage() is intended for cases
> where the supply is optional and device typically uses an internal
> reference voltage if the supply is not available.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>

In general I'll find this very useful (there are 50+ incidence
of the pattern this can replace in IIO).
I would keep it more similar to other devm regulator related functions
and not do error printing internally though.

Jonathan

> ---
>  Documentation/driver-api/driver-model/devres.rst |  2 +
>  drivers/regulator/devres.c                       | 83 ++++++++++++++++++++++++
>  include/linux/regulator/consumer.h               | 14 ++++
>  3 files changed, 99 insertions(+)
> 
> diff --git a/Documentation/driver-api/driver-model/devres.rst b/Documentation/driver-api/driver-model/devres.rst
> index 7be8b8dd5f00..fd954d09e13c 100644
> --- a/Documentation/driver-api/driver-model/devres.rst
> +++ b/Documentation/driver-api/driver-model/devres.rst
> @@ -433,9 +433,11 @@ REGULATOR
>    devm_regulator_bulk_put()
>    devm_regulator_get()
>    devm_regulator_get_enable()
> +  devm_regulator_get_enable_get_voltage()
>    devm_regulator_get_enable_optional()
>    devm_regulator_get_exclusive()
>    devm_regulator_get_optional()
> +  devm_regulator_get_optional_enable_get_voltage()
>    devm_regulator_irq_helper()
>    devm_regulator_put()
>    devm_regulator_register()
> diff --git a/drivers/regulator/devres.c b/drivers/regulator/devres.c
> index 90bb0d178885..e240926defc5 100644
> --- a/drivers/regulator/devres.c
> +++ b/drivers/regulator/devres.c
> @@ -145,6 +145,89 @@ struct regulator *devm_regulator_get_optional(struct device *dev,
>  }
>  EXPORT_SYMBOL_GPL(devm_regulator_get_optional);
>  
> +static int _devm_regulator_get_enable_get_voltage(struct device *dev,
> +						  const char *id,
> +						  bool silent_enodev)
> +{
> +	struct regulator *r;
> +	int ret;
> +
> +	/*
> +	 * Since we need a real voltage, we use devm_regulator_get_optional()
> +	 * here to avoid getting a dummy regulator if the supply is not present.
> +	 */
> +	r = devm_regulator_get_optional(dev, id);
> +	if (silent_enodev && PTR_ERR(r) == -ENODEV)
> +		return -ENODEV;
> +	if (IS_ERR(r))
> +		return dev_err_probe(dev, PTR_ERR(r),

There isn't any obvious precedence that I can see for using dev_err_probe() in these
calls.  I'd not introduce it here.

It's probably enough to print an error message at the caller that
just says we failed to get the voltage (rather than which step failed)./

> +				     "failed to get regulator '%s'\n", id);
> +
> +	ret = regulator_enable(r);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "failed to enable regulator '%s'\n", id);
> +
> +	ret = devm_add_action_or_reset(dev, regulator_action_disable, r);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "failed to add disable action for regulator '%s'\n",
> +				     id);
> +
> +	ret = regulator_get_voltage(r);
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret,
> +				     "failed to get voltage for regulator '%s'\n",
> +				     id);
> +
> +	return ret;
> +}
> +
> +/**
> + * devm_regulator_get_enable_get_voltage - Resource managed regulator get and
> + *                                         enable that returns the voltage
> + * @dev: device to supply
> + * @id:  supply name or regulator ID.
> + *
> + * Get and enable regulator for duration of the device life-time.
> + * regulator_disable() and regulator_put() are automatically called on driver
> + * detach. See regulator_get_optional(), regulator_enable(), and
> + * regulator_get_voltage() for more information.
> + *
> + * This is a convenience function for supplies that provide a reference voltage
> + * where the consumer driver just needs to know the voltage and keep the
> + * regulator enabled. Also, as a convenience, this prints error messages on
> + * failure.
> + *
> + * Returns: voltage in microvolts on success, or an error code on failure.
> + */
> +int devm_regulator_get_enable_get_voltage(struct device *dev, const char *id)
> +{
> +	return _devm_regulator_get_enable_get_voltage(dev, id, false);
> +}
> +EXPORT_SYMBOL_GPL(devm_regulator_get_enable_get_voltage);
> +
> +/**
> + * devm_regulator_get_optional_enable_get_voltage - Resource managed regulator
> + *                                                  get and enable that returns
> + *                                                  the voltage
> + * @dev: device to supply
> + * @id:  supply name or regulator ID.
> + *
> + * This function is identical to devm_regulator_get_enable_get_voltage() except
> + * that it does not print an error message in the case of -ENODEV. Callers are
> + * expected to handle -ENODEV as a special case instead of passing it on as an
> + * error.
> + *
> + * Returns: voltage in microvolts on success, or an error code on failure.
> + */
> +int devm_regulator_get_optional_enable_get_voltage(struct device *dev,
> +						   const char *id)
> +{
> +	return _devm_regulator_get_enable_get_voltage(dev, id, true);
> +}
> +EXPORT_SYMBOL_GPL(devm_regulator_get_optional_enable_get_voltage);
> +
>  static int devm_regulator_match(struct device *dev, void *res, void *data)
>  {
>  	struct regulator **r = res;
> diff --git a/include/linux/regulator/consumer.h b/include/linux/regulator/consumer.h
> index 4660582a3302..35596db521a0 100644
> --- a/include/linux/regulator/consumer.h
> +++ b/include/linux/regulator/consumer.h
> @@ -164,6 +164,8 @@ struct regulator *__must_check devm_regulator_get_optional(struct device *dev,
>  							   const char *id);
>  int devm_regulator_get_enable(struct device *dev, const char *id);
>  int devm_regulator_get_enable_optional(struct device *dev, const char *id);
> +int devm_regulator_get_enable_get_voltage(struct device *dev, const char *id);
> +int devm_regulator_get_optional_enable_get_voltage(struct device *dev, const char *id);
>  void regulator_put(struct regulator *regulator);
>  void devm_regulator_put(struct regulator *regulator);
>  
> @@ -329,6 +331,18 @@ static inline int devm_regulator_get_enable_optional(struct device *dev,
>  	return -ENODEV;
>  }
>  
> +static inline int devm_regulator_get_enable_get_voltage(struct device *dev,
> +							const char *id)
> +{
> +	return -ENODEV;
> +}
> +
> +static inline int devm_regulator_get_optional_enable_get_voltage(struct device *dev,
> +								 const char *id)
> +{
> +	return -ENODEV;
> +}
> +
>  static inline struct regulator *__must_check
>  regulator_get_optional(struct device *dev, const char *id)
>  {
> 


