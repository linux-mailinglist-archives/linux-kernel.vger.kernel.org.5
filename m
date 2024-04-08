Return-Path: <linux-kernel+bounces-135580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BF6F89C7E8
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 17:12:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E8931C23B05
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 15:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C14F13F458;
	Mon,  8 Apr 2024 15:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="oDSGbC8e"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E25E13F439;
	Mon,  8 Apr 2024 15:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712589129; cv=none; b=ZMAlqIWfRy7r474Q+yCoFJpnI1CxHzymhmdoDcGVl96tuKtfxEHgqfJnOeMDAHrwpPxk0YnUxmhqpk6lB/g9mWJ3rGwBw988bOcjRkQwAc0MEmBfqr+rejyt674zORimgwQTrmZCUy0OipLqxmbmB57tQDefYBfP4P1exMyJ5LE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712589129; c=relaxed/simple;
	bh=qr2rFW6w9/fvO6Ij1T8ekWnLY0TacXSC2/hiYqqAFmQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XUys2MXJX7h9dWNfUS1k6KdWhsUPz78B+PdGcOqudKlb0Z6CqeLXwtEYqaHm/GcxHLAY5m7M+FxM3/OW4L64pLAIT4QyI1jyQjiUxc5NZKcI1d5445P16aKoQb2eRnthMb0B2hjhliiIdyi05r+Zx4aLfO9HnyEqSDlenCVDCTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=oDSGbC8e; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1712589118;
	bh=qr2rFW6w9/fvO6Ij1T8ekWnLY0TacXSC2/hiYqqAFmQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oDSGbC8elT7mNaWJPttrR6M96crZSrhUQpXj4MBczDc6c+xxtAjQJ4AJcVjQn1u8S
	 pbPg25UPAmUENh1PRbCXrDz2HFCvnqBqP52ovQH0yqcAo9SFZZiUL1nGhMaLCEryLi
	 D53tuPWKGc/8UPFAbtyb8RV9asVDuasmnU+S5Kz8=
Date: Mon, 8 Apr 2024 17:11:57 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Armin Wolf <W_Armin@gmx.de>
Cc: mlj@danelec.com, rafael.j.wysocki@intel.com, lenb@kernel.org, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH] ACPI: fan: Add hwmon support
Message-ID: <8bccc21e-58ce-460f-b73b-de3b4cf383dd@t-8ch.de>
References: <20240408123718.15512-1-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240408123718.15512-1-W_Armin@gmx.de>

Hi,

On 2024-04-08 14:37:18+0200, Armin Wolf wrote:
> Currently, the driver does only supports a custom sysfs
> interface to allow userspace to read the fan speed.
> Add support for the standard hwmon interface so users
> can read the fan speed with standard tools like "sensors".
> 
> Signed-off-by: Armin Wolf <W_Armin@gmx.de>
> ---
>  drivers/acpi/Makefile    |  1 +
>  drivers/acpi/fan.h       |  2 ++
>  drivers/acpi/fan_core.c  |  7 ++++
>  drivers/acpi/fan_hwmon.c | 78 ++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 88 insertions(+)
>  create mode 100644 drivers/acpi/fan_hwmon.c

[snip]

> +
> +int devm_acpi_fan_create_hwmon(struct acpi_device *device)
> +{
> +	struct device *hdev;
> +
> +	hdev = devm_hwmon_device_register_with_info(&device->dev, "acpi_fan", device,
> +						    &acpi_fan_chip_info, NULL);

This fails to link if CONFIG_ACPI_FAN=y and CONFIG_HWMON=n:

ld: vmlinux.o: in function `devm_acpi_fan_create_hwmon':
../drivers/acpi/fan_hwmon.c:74:(.text+0x819e65): undefined reference to `devm_hwmon_device_register_with_info'

With this fixed:

Reviewed-by: Thomas Weißschuh <linux@weissschuh.net>

> +
> +	return PTR_ERR_OR_ZERO(hdev);
> +}
> --
> 2.39.2
> 
> 

