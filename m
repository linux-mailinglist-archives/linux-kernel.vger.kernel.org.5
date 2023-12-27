Return-Path: <linux-kernel+bounces-11857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFB5481EC90
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 07:27:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1DE851C222C6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 06:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E604525A;
	Wed, 27 Dec 2023 06:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L/qWPKvS"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C109522C;
	Wed, 27 Dec 2023 06:27:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E25BC433C8;
	Wed, 27 Dec 2023 06:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703658423;
	bh=1aL1UjeuTN6ZyivWuNsZk/rd0snWq7SDPeGNQ5MhZWM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L/qWPKvSzoa6dDByZYJmBYGK9sPkGQ/Awk9Sb68jnWX6jkHPf/sQq71k8JRLbhw9q
	 zgxqu9jzrEBz9Ulc2uRcXfGyraUzk92ZSkynnglqLFHwB94XRY8oJ/h65zvf1dpFwk
	 3XAI4I8sArc+pTKRIpBrWlmA5/fvEo3ML7gA+oyT2G3MR4lbo5VEesGCRWfAOs0RU+
	 Tt7KPhC0x8cbM8cZrQFqjcwlTXTkrJ1HakxOczAAU/g8HrtZ3hkSkLFNcy033qSIhR
	 EsmC0xyoTl10qmcMbA5JDA4+KvXdljahO6UUOK8vdvwIi5knxpmLtvi2UebCDUUGQv
	 sCEF8rc9sz3BA==
Date: Wed, 27 Dec 2023 14:26:58 +0800
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Mark Hasemeyer <markhas@chromium.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Raul Rangel <rrangel@chromium.org>,
	Benson Leung <bleung@chromium.org>,
	Bhanu Prakash Maiya <bhanumaiya@chromium.org>,
	Chen-Yu Tsai <wenst@chromium.org>,
	Guenter Roeck <groeck@chromium.org>, Lee Jones <lee@kernel.org>,
	Prashant Malani <pmalani@chromium.org>,
	Rob Barnes <robbarnes@google.com>,
	Stephen Boyd <swboyd@chromium.org>, chrome-platform@lists.linux.dev
Subject: Re: [PATCH v3 24/24] platform/chrome: cros_ec: Use PM subsystem to
 manage wakeirq
Message-ID: <ZYvDshfJ-jnWNEY5@google.com>
References: <20231226192149.1830592-1-markhas@chromium.org>
 <20231226122113.v3.24.Ieee574a0e94fbaae01fd6883ffe2ceeb98d7df28@changeid>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231226122113.v3.24.Ieee574a0e94fbaae01fd6883ffe2ceeb98d7df28@changeid>

On Tue, Dec 26, 2023 at 12:21:28PM -0700, Mark Hasemeyer wrote:
> The cros ec driver is manually managing the wake IRQ by calling
> enable_irq_wake()/disable_irq_wake() during suspend/resume.
> 
> Modify the driver to use the power management subsystem to manage the
> wakeirq.
> 
> Rather than assuming that the IRQ is wake capable, use the underlying
> firmware/device tree to determine whether or not to enable it as a wake
> source. Some Chromebooks rely solely on the ec_sync pin to wake the AP
> but do not specify the interrupt as wake capable in the ACPI _CRS. For
> LPC/ACPI based systems a DMI quirk is introduced listing boards whose
> firmware should not be trusted to provide correct wake capable values.
> For device tree base systems, it is not an issue as the relevant device
> tree entries have been updated and DTS is built from source for each
> ChromeOS update.
> 
> Signed-off-by: Mark Hasemeyer <markhas@chromium.org>

The patch overall looks good to me.

With some minor comments:
Acked-by: Tzung-Bi Shih <tzungbi@kernel.org>

> diff --git a/drivers/platform/chrome/cros_ec_uart.c b/drivers/platform/chrome/cros_ec_uart.c
[...]
>  static int cros_ec_uart_acpi_probe(struct cros_ec_uart *ec_uart)
>  {
[...]
>  	/* Retrieve GpioInt and translate it to Linux IRQ number */
> -	ret = acpi_dev_gpio_irq_get(adev, 0);
> +	ret = acpi_dev_get_gpio_irq_resource(adev, NULL, 0, &irqres);
>  	if (ret < 0)
>  		return ret;
>  
> -	ec_uart->irq = ret;
> -	dev_dbg(&ec_uart->serdev->dev, "IRQ number %d\n", ec_uart->irq);
> +	ec_uart->irq = irqres.start;

How about keep using `ret`?

> @@ -301,7 +306,14 @@ static int cros_ec_uart_probe(struct serdev_device *serdev)
>  
>  	serdev_device_set_client_ops(serdev, &cros_ec_uart_client_ops);
>  
> -	return cros_ec_register(ec_dev);
> +	/* Register a new cros_ec device */
> +	ret = cros_ec_register(ec_dev);
> +	if (ret) {
> +		dev_err(dev, "Couldn't register ec_dev (%d)\n", ret);
> +		return ret;
> +	}

It doesn't need the change after moving device_init_wakeup() and
dev_pm_set_wake_irq() into cros_ec_register().

Drop it?

