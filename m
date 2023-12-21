Return-Path: <linux-kernel+bounces-8031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EBDC81B0D6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 09:58:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F11361F23B8F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 08:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8728E210F5;
	Thu, 21 Dec 2023 08:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hb0pT7TY"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB65C208DE;
	Thu, 21 Dec 2023 08:58:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98173C433C8;
	Thu, 21 Dec 2023 08:58:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703149092;
	bh=gLq6owYsi5+HzSEWjDiTXSIZh7zeqkTrjBurAO/BXVM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hb0pT7TYb6E2npKuG1J8kJlRD8022tec43nOjCXNzAfTKOW4HSo6vhCKgic7S/MS7
	 zT0KXYfeJvUFWhw32SigZV/GPh/px0g2h5y0r4MnE5NMyoh5Htf8dLbgJB/NWV9jXw
	 nxlK381fmNuArHKuK9bzObZMLaP9u2HbVu1TGRzMyrUJuMio7kf79aVMH5VhkX0aGR
	 xNPobhJ0Z83rEd2MWsC8SNMBSjtadWPOMB2NKBGbSi3pMbag1zH3JZcD+QKh5Ind3H
	 wQXx0OEXTp4/jAyE2xSCIZcZ8D6ZzHt5nxqMMer7sE0mcCWizpFQsGzVoZ23YMCo7C
	 vfYYISIamm6kg==
Date: Thu, 21 Dec 2023 16:58:07 +0800
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Mark Hasemeyer <markhas@chromium.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Raul Rangel <rrangel@chromium.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Rob Herring <robh@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>,
	Benson Leung <bleung@chromium.org>,
	Bhanu Prakash Maiya <bhanumaiya@chromium.org>,
	Chen-Yu Tsai <wenst@chromium.org>,
	Guenter Roeck <groeck@chromium.org>, Lee Jones <lee@kernel.org>,
	Prashant Malani <pmalani@chromium.org>,
	Rob Barnes <robbarnes@google.com>,
	Stephen Boyd <swboyd@chromium.org>, chrome-platform@lists.linux.dev
Subject: Re: [PATCH v2 22/22] platform/chrome: cros_ec: Use PM subsystem to
 manage wakeirq
Message-ID: <ZYP-H27vsJvMTupH@google.com>
References: <20231220235459.2965548-1-markhas@chromium.org>
 <20231220165423.v2.22.Ieee574a0e94fbaae01fd6883ffe2ceeb98d7df28@changeid>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231220165423.v2.22.Ieee574a0e94fbaae01fd6883ffe2ceeb98d7df28@changeid>

On Wed, Dec 20, 2023 at 04:54:36PM -0700, Mark Hasemeyer wrote:
> The IRQ wake logic was added on an interface basis (lpc, spi, uart) as
> opposed to adding it to cros_ec.c because the i2c subsystem already
> enables the wakirq (if applicable) on our behalf.

The setting flow are all the same.  I think helper functions in cros_ec.c help
to deduplicate the code.

> diff --git a/drivers/platform/chrome/cros_ec_lpc.c b/drivers/platform/chrome/cros_ec_lpc.c
[...]
> +static const struct dmi_system_id untrusted_fw_irq_wake_capable[] = {
> +	{
> +		.ident = "Brya",
> +		.matches = {
> +			DMI_MATCH(DMI_PRODUCT_FAMILY, "Google_Brya")
> +		}
> +	},
> +	{
> +		.ident = "Brask",
> +		.matches = {
> +			DMI_MATCH(DMI_PRODUCT_FAMILY, "Google_Brask")
> +		}
> +	},
> +	{ }
> +}
> +MODULE_DEVICE_TABLE(dmi, untrusted_fw_irq_wake_capable);

Does it really need `MODULE_DEVICE_TABLE`?

> +static bool cros_ec_should_force_irq_wake_capable(void)

Suggestion: either drop "cros_ec_" prefix or use "cros_ec_lpc_" prefix.

> @@ -428,20 +453,36 @@ static int cros_ec_lpc_probe(struct platform_device *pdev)
>  	 * Some boards do not have an IRQ allotted for cros_ec_lpc,
>  	 * which makes ENXIO an expected (and safe) scenario.
>  	 */
> -	irq = platform_get_irq_optional(pdev, 0);
> -	if (irq > 0)
> +	irq = platform_get_irq_resource_optional(pdev, 0, &irqres);
> +	if (irq > 0) {
>  		ec_dev->irq = irq;
> -	else if (irq != -ENXIO) {
> +		if (cros_ec_should_force_irq_wake_capable())

Please see suggestion above.

>  	ret = cros_ec_register(ec_dev);
>  	if (ret) {
> -		dev_err(dev, "couldn't register ec_dev (%d)\n", ret);
> +		dev_err_probe(dev, ret, "couldn't register ec_dev (%d)\n", ret);

The change is irrelevant to the series.

> +	if (irq_wake) {
> +		ret = device_init_wakeup(dev, true);
> +		if (ret) {
> +			dev_err_probe(dev, ret, "Failed to init device for wakeup");
> +			return ret;
> +		}
> +		ret = dev_pm_set_wake_irq(dev, irq);
> +		if (ret)
> +			return ret;
> +	}
[...]
> @@ -470,6 +512,8 @@ static void cros_ec_lpc_remove(struct platform_device *pdev)
>  		acpi_remove_notify_handler(adev->handle, ACPI_ALL_NOTIFY,
>  					   cros_ec_lpc_acpi_notify);
>  
> +	dev_pm_clear_wake_irq(dev);
> +	device_init_wakeup(dev, false);

Is it safe to call them anyway regardless of `irq_wake` in cros_ec_lpc_probe()?

> diff --git a/drivers/platform/chrome/cros_ec_spi.c b/drivers/platform/chrome/cros_ec_spi.c
[...]
> -static void cros_ec_spi_dt_probe(struct cros_ec_spi *ec_spi, struct device *dev)
> +static void cros_ec_spi_dt_probe(struct cros_ec_spi *ec_spi, struct spi_device *spi)
>  {
> -	struct device_node *np = dev->of_node;
> +	struct cros_ec_device *ec_dev = spi_get_drvdata(spi);
> +	struct device_node *np = spi->dev.of_node;

struct spi_device *spi = ec_spi->spi; [1]

[1]: https://elixir.bootlin.com/linux/v6.6/source/drivers/platform/chrome/cros_ec_spi.c#L751

> +	if (!np)
> +		return;
> +

The change is an improvement (or rather say it could change behavior).  But
strictly speaking, the change is irrelevant to the series.

> @@ -702,6 +710,11 @@ static void cros_ec_spi_dt_probe(struct cros_ec_spi *ec_spi, struct device *dev)
>  	ret = of_property_read_u32(np, "google,cros-ec-spi-msg-delay", &val);
>  	if (!ret)
>  		ec_spi->end_of_msg_delay = val;
> +
> +	if (ec_dev->irq > 0 && of_property_read_bool(np, "wakeup-source")) {

Or just use `spi->irq`[2].

[2]: https://elixir.bootlin.com/linux/v6.6/source/drivers/platform/chrome/cros_ec_spi.c#L762

They are the same, but does of_property_present() make more sense?

> @@ -768,6 +778,9 @@ static int cros_ec_spi_probe(struct spi_device *spi)
>  			   sizeof(struct ec_response_get_protocol_info);
>  	ec_dev->dout_size = sizeof(struct ec_host_request);
>  
> +	/* Check for any DT properties */
> +	cros_ec_spi_dt_probe(ec_spi, spi);

`spi` is possibly not needed.  See comment above.

> @@ -776,19 +789,31 @@ static int cros_ec_spi_probe(struct spi_device *spi)
>  
>  	err = cros_ec_register(ec_dev);
>  	if (err) {
> -		dev_err(dev, "cannot register EC\n");
> +		dev_err_probe(dev, err, "cannot register EC\n");

The change is irrelevant to the series.

> -	device_init_wakeup(&spi->dev, true);
> +	if (ec_spi->irq_wake) {
> +		err = device_init_wakeup(dev, true);
> +		if (err) {
> +			dev_err_probe(dev, err, "Failed to init device for wakeup\n");
> +			return err;
> +		}
> +		err = dev_pm_set_wake_irq(dev, ec_dev->irq);
> +		if (err)
> +			dev_err_probe(dev, err, "Failed to set irq(%d) for wake\n", ec_dev->irq);

The part is different from what the patch changed in cros_ec_lpc.c.  Better to
be consistent.
- Just return vs. dev_err_probe().
- %i vs. %d.

>  static void cros_ec_spi_remove(struct spi_device *spi)
>  {
>  	struct cros_ec_device *ec_dev = spi_get_drvdata(spi);
> +	struct device *dev = ec_dev->dev;
>  
> +	dev_pm_clear_wake_irq(dev);
> +	device_init_wakeup(dev, false);

Ditto, is it safe to just call them regardless of `ec_spi->irq_wake`?

> diff --git a/drivers/platform/chrome/cros_ec_uart.c b/drivers/platform/chrome/cros_ec_uart.c
[...]
> @@ -301,13 +307,31 @@ static int cros_ec_uart_probe(struct serdev_device *serdev)
>  
>  	serdev_device_set_client_ops(serdev, &cros_ec_uart_client_ops);
>  
> -	return cros_ec_register(ec_dev);
> +	/* Register a new cros_ec device */
> +	ret = cros_ec_register(ec_dev);
> +	if (ret) {
> +		dev_err(dev, "Couldn't register ec_dev (%d)\n", ret);

From reading the changes above, I thought it would use dev_err_probe().

> +	if (ec_uart->irq_wake) {
> +		ret = device_init_wakeup(dev, true);
> +		if (ret) {
> +			dev_err_probe(dev, ret, "Failed to init device for wakeup");
> +			return ret;
> +		}
> +		ret = dev_pm_set_wake_irq(dev, ec_uart->irq);

Ditto, better to be consistent.

>  static void cros_ec_uart_remove(struct serdev_device *serdev)
>  {
>  	struct cros_ec_device *ec_dev = serdev_device_get_drvdata(serdev);
> +	struct device *dev = ec_dev->dev;
>  
> +	dev_pm_clear_wake_irq(dev);
> +	device_init_wakeup(dev, false);

Ditto, is it safe to just call them regardless of `ec_uart->irq_wake`?

