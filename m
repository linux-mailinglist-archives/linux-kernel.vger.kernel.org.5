Return-Path: <linux-kernel+bounces-87364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FCED86D35C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 20:39:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C34641F25A7E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 19:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B67E613C9F9;
	Thu, 29 Feb 2024 19:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PKuAhuaM"
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E7331E499
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 19:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709235573; cv=none; b=QQNwcRFGjAf5aQRdBm8ihg2JEZMJl0ylpUiCMeoMXmyQBMA3+eJwPgbys9OtketY5OPqmEh/64D7MaYK3TffgfUckAhKq2ixKHE3lumSq53TacN4YTfFrssT7NkRTks1kHFinvbMB3o5kGwkdVhOvw9ZWt4jy3U1C5+RZqRefHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709235573; c=relaxed/simple;
	bh=C+JJWelZGwVqdA3olYAOFPwLiYZ4xCxGhyr4cc7HScs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aZzkWzD6mD43xVqqi09cAdproaMG3JM+7TNxcPxiOKHPj2FIC3IjlDErHbjHqcRRCQdw/estb5veLr+PhsZM0MaeJPcRt5yG3twz7ZlBeLNKufrq+zoiRSLeAElN+dOluU0i+aT3dFIJGxGxf0DdaZA87dHWjgnBOyT6sJxzU4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=PKuAhuaM; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-7c7f3f66d17so65111339f.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 11:39:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709235570; x=1709840370; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2Gj+BEkBgEqWivQ9srAklb104D0qLcRARdb72wK6r78=;
        b=PKuAhuaMP8LVFhKCMwblPJuUacOs/osxN+NdGDZvkQ/VJ2pHAipwWYhzZyvJ42ZKY0
         WMCXfAsu5wpKJL2BrGycPI+Q0FGvGdaxWOS2ofVvlgxhYUl3YlqofP6c3ic/UgKj01Sa
         9UfVQ0iJoF5PPMhV1Qx77LSJDoF/kN5ZW+p0o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709235570; x=1709840370;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Gj+BEkBgEqWivQ9srAklb104D0qLcRARdb72wK6r78=;
        b=mEiOA0zoGjSzOZlbK7C6fBQTS9JSferfjGj8INgwB4vpfhtluKR0NPwwf03AAVqukz
         zlR6FB1fykWWWQslgt9bUhjN0JM7g/0H2GuYyXCwrEk10FU44K/MXLneq2hdufUn9gQP
         Hm17ohIvjtj8tjd3OYE8K7Ap/2DFqA6WBhFShfy7itk3XkDT+16Eh4PU0/qRP/KRuwu3
         cUrZnwrTtRE5S6ZYy3WcR6QrcxXNJDVY593tikW+iVInC5KF5BhvOcb9++eZ/CLBa9jR
         2axIvimbEntaREAljQnfaJnuNJzLdfL9bHFMdEZGr1cFS6ceBe3i9rJCrO2oTOi9r5qW
         Phsg==
X-Forwarded-Encrypted: i=1; AJvYcCWmeOveKpFKGveOYBEwR8odXYe62Tv7cKTlDP9jad05jmMj/DWvU83+lDNyTQq2zNzyov/JWRbP1VZbyV5SM3G8aVt1SAYmWPfwHz99
X-Gm-Message-State: AOJu0YwxTMEEdMuD7XDXfcjnwvNqUwVC4pevzOIJ8sXVvzjz7h+c5b1T
	Pu9e9DbdXurOYPggM9IHls/Ozw/AUHSu9ZdGdV+UdCLKuwO/srJGUSS/vGEjvA==
X-Google-Smtp-Source: AGHT+IFflBENGybw7AkP83/tQKr6kJsdZWm0Sw/tOPw0d/8ecXfBEQAjJ/Tt6ipaHpc0qkUXGk0Gbw==
X-Received: by 2002:a6b:5b08:0:b0:7c7:a1e1:e2ec with SMTP id v8-20020a6b5b08000000b007c7a1e1e2ecmr3715738ioh.17.1709235570008;
        Thu, 29 Feb 2024 11:39:30 -0800 (PST)
Received: from localhost (144.57.222.35.bc.googleusercontent.com. [35.222.57.144])
        by smtp.gmail.com with UTF8SMTPSA id dy2-20020a0566381d4200b004747cfba9cesm448794jab.104.2024.02.29.11.39.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Feb 2024 11:39:29 -0800 (PST)
Date: Thu, 29 Feb 2024 19:39:29 +0000
From: Matthias Kaehlcke <mka@chromium.org>
To: Javier Carrasco <javier.carrasco@wolfvision.net>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Helen Koike <helen.koike@collabora.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Russell King <linux@armlinux.org.uk>,
	linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v6 3/9] usb: misc: onboard_hub: rename to onboard_dev
Message-ID: <ZeDdcZHCNNjKizDa@google.com>
References: <20240229-onboard_xvf3500-v6-0-a0aff2947040@wolfvision.net>
 <20240229-onboard_xvf3500-v6-3-a0aff2947040@wolfvision.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240229-onboard_xvf3500-v6-3-a0aff2947040@wolfvision.net>

On Thu, Feb 29, 2024 at 09:34:46AM +0100, Javier Carrasco wrote:
> This patch prepares onboad_hub to support non-hub devices by renaming
> the driver files and their content, the headers and their references.
> 
> The comments and descriptions have been slightly modified to keep
> coherence and account for the specific cases that only affect onboard
> hubs (e.g. peer-hub).
> 
> The "hub" variables in functions where "dev" (and similar names) variables
> already exist have been renamed to onboard_dev for clarity, which adds a
> few lines in cases where more than 80 characters are used.
> 
> No new functionality has been added.
> 
> Signed-off-by: Javier Carrasco <javier.carrasco@wolfvision.net>

Acked-by: Matthias Kaehlcke <mka@chromium.org>

This should land together with "usb: misc: onboard_dev: add support for
non-hub devices".

> diff --git a/drivers/usb/misc/onboard_usb_dev.c b/drivers/usb/misc/onboard_usb_dev.c
> new file mode 100644
> index 000000000000..4ae580445408
> --- /dev/null
> +++ b/drivers/usb/misc/onboard_usb_dev.c
>
> ...
>
> +static const struct usb_device_id onboard_dev_id_table[] = {
> +	{ USB_DEVICE(VENDOR_ID_CYPRESS, 0x6504) }, /* CYUSB33{0,1,2}x/CYUSB230x 3.0 HUB */
> +	{ USB_DEVICE(VENDOR_ID_CYPRESS, 0x6506) }, /* CYUSB33{0,1,2}x/CYUSB230x 2.0 HUB */
> +	{ USB_DEVICE(VENDOR_ID_CYPRESS, 0x6570) }, /* CY7C6563x 2.0 HUB */
> +	{ USB_DEVICE(VENDOR_ID_GENESYS, 0x0608) }, /* Genesys Logic GL850G USB 2.0 HUB */
> +	{ USB_DEVICE(VENDOR_ID_GENESYS, 0x0610) }, /* Genesys Logic GL852G USB 2.0 HUB */
> +	{ USB_DEVICE(VENDOR_ID_GENESYS, 0x0620) }, /* Genesys Logic GL3523 USB 3.1 HUB */
> +	{ USB_DEVICE(VENDOR_ID_MICROCHIP, 0x2412) }, /* USB2412 USB 2.0 HUB */
> +	{ USB_DEVICE(VENDOR_ID_MICROCHIP, 0x2514) }, /* USB2514B USB 2.0 HUB */
> +	{ USB_DEVICE(VENDOR_ID_MICROCHIP, 0x2517) }, /* USB2517 USB 2.0 HUB */
> +	{ USB_DEVICE(VENDOR_ID_MICROCHIP, 0x2744) }, /* USB5744 USB 2.0 HUB */
> +	{ USB_DEVICE(VENDOR_ID_MICROCHIP, 0x5744) }, /* USB5744 USB 3.0 HUB */
> +	{ USB_DEVICE(VENDOR_ID_REALTEK, 0x0411) }, /* RTS5411 USB 3.1 HUB */
> +	{ USB_DEVICE(VENDOR_ID_REALTEK, 0x5411) }, /* RTS5411 USB 2.1 HUB */
> +	{ USB_DEVICE(VENDOR_ID_REALTEK, 0x0414) }, /* RTS5414 USB 3.2 HUB */
> +	{ USB_DEVICE(VENDOR_ID_REALTEK, 0x5414) }, /* RTS5414 USB 2.1 HUB */
> +	{ USB_DEVICE(VENDOR_ID_TI, 0x8140) }, /* TI USB8041 3.0 HUB */
> +	{ USB_DEVICE(VENDOR_ID_TI, 0x8142) }, /* TI USB8041 2.0 HUB */
> +	{ USB_DEVICE(VENDOR_ID_VIA, 0x0817) }, /* VIA VL817 3.1 HUB */
> +	{ USB_DEVICE(VENDOR_ID_VIA, 0x2817) }, /* VIA VL817 2.0 HUB */
> +	{}
> +};

nit: 'hub' isn't an acronym, please s/HUB/hub/ in the next revision.

