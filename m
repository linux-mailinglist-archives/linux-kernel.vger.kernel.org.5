Return-Path: <linux-kernel+bounces-122994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BFF08900CD
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 14:50:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E836E1F267B9
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 13:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 779CD823C8;
	Thu, 28 Mar 2024 13:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RlRm8TMU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6DC514294;
	Thu, 28 Mar 2024 13:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711633822; cv=none; b=PIl0cwX5/mwFwmLv0dMvfKZ2qIzguh+fHCXxwehThuyx9BP4DoF6zloBL0giu3bMNNVcLtnSrozzRlQosSW36lOFcCUdu7BdtWPDgXD1bVd772o74nuA+e0GJqKycrm5r79V71ugH696i++lNhQUDoKLvW6RbP6xySGeqz22UnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711633822; c=relaxed/simple;
	bh=eEFZMLCzrNeTjFb/yRecNNt9sgMVSJerpj93zicjX0g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XVhek6IVNz/enXodLjnmC24Q7tBlMgqbITpwlqF/O8ZOhe79lYkcf9qtdonY3RluH12pM757NEWuE7HNbCaWbQwgpJa3v/iGrHLCBKwBdL29nlweM/OXdrNkUoFTYvQgYTszD00pVTC+Rs/aTUdXDwCMGKwGkSNzxwVzgWbzjz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RlRm8TMU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAD2BC433F1;
	Thu, 28 Mar 2024 13:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711633822;
	bh=eEFZMLCzrNeTjFb/yRecNNt9sgMVSJerpj93zicjX0g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RlRm8TMUUhnFq8otL/CkuJWEuxQH0W6r/vraQcpWxldMMhODpRcuIHIknFc4ZQ8xM
	 9UPo3wqX6ANiOSGNllM4wUu7Iz/6Zq9zE8Boloa/sa/d5jzpVKrHmDuwDTHkuYoPaF
	 gJy9LFqdRJIa3btLD2flWZfMVOO0ueJH/ExvOb/Q/COMBt2LRV+DAbkubw1BiUdaGo
	 rQwobimWcwiL61ibRvIhBg34UKGAv8ZLVrqERoIv0IX4gDv6cAUmbndwfN9+gagG3F
	 gopgEh9niINNG8qivXuCyRRLUEWLPWcIEni2Al+cdhU2yfkEXj6MrHgQpgzv78LJLb
	 rpyOQraz9P1YA==
Date: Thu, 28 Mar 2024 13:50:03 +0000
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
Subject: Re: [PATCH RFC 6/7] staging: iio: impedance-analyzer: admv1013: Use
 devm_regulator_get_enable_get_voltage()
Message-ID: <20240328135003.3c200be3@jic23-huawei>
In-Reply-To: <20240327-regulator-get-enable-get-votlage-v1-6-5f4517faa059@baylibre.com>
References: <20240327-regulator-get-enable-get-votlage-v1-0-5f4517faa059@baylibre.com>
	<20240327-regulator-get-enable-get-votlage-v1-6-5f4517faa059@baylibre.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 27 Mar 2024 18:18:55 -0500
David Lechner <dlechner@baylibre.com> wrote:

> We can reduce boilerplate code by using
> devm_regulator_get_enable_get_voltage().
Wrong device in patch title.  I thought it odd we had a driver for same part
number in staging and out of it!.

Otherwise LGTM

Not sure how we'll merge this set assuming everyone agrees it's a good idea.
Immutable branch probably.  On off chance we don't do that, with the patch title
fixed.
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>


Jonathan

> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
>  drivers/staging/iio/impedance-analyzer/ad5933.c | 24 +-----------------------
>  1 file changed, 1 insertion(+), 23 deletions(-)
> 
> diff --git a/drivers/staging/iio/impedance-analyzer/ad5933.c b/drivers/staging/iio/impedance-analyzer/ad5933.c
> index 9149d41fe65b..e4942833b793 100644
> --- a/drivers/staging/iio/impedance-analyzer/ad5933.c
> +++ b/drivers/staging/iio/impedance-analyzer/ad5933.c
> @@ -84,7 +84,6 @@
>  
>  struct ad5933_state {
>  	struct i2c_client		*client;
> -	struct regulator		*reg;
>  	struct clk			*mclk;
>  	struct delayed_work		work;
>  	struct mutex			lock; /* Protect sensor state */
> @@ -660,13 +659,6 @@ static void ad5933_work(struct work_struct *work)
>  	}
>  }
>  
> -static void ad5933_reg_disable(void *data)
> -{
> -	struct ad5933_state *st = data;
> -
> -	regulator_disable(st->reg);
> -}
> -
>  static int ad5933_probe(struct i2c_client *client)
>  {
>  	const struct i2c_device_id *id = i2c_client_get_device_id(client);
> @@ -685,21 +677,7 @@ static int ad5933_probe(struct i2c_client *client)
>  
>  	mutex_init(&st->lock);
>  
> -	st->reg = devm_regulator_get(&client->dev, "vdd");
> -	if (IS_ERR(st->reg))
> -		return PTR_ERR(st->reg);
> -
> -	ret = regulator_enable(st->reg);
> -	if (ret) {
> -		dev_err(&client->dev, "Failed to enable specified VDD supply\n");
> -		return ret;
> -	}
> -
> -	ret = devm_add_action_or_reset(&client->dev, ad5933_reg_disable, st);
> -	if (ret)
> -		return ret;
> -
> -	ret = regulator_get_voltage(st->reg);
> +	ret = devm_regulator_get_enable_get_voltage(&client->dev, "vdd");
>  	if (ret < 0)
>  		return ret;
>  
> 


