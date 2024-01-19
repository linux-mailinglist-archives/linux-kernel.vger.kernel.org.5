Return-Path: <linux-kernel+bounces-31524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B471832F7E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 20:45:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12F58286244
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 19:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C5885645F;
	Fri, 19 Jan 2024 19:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i8qlEF5l"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C561E23B1;
	Fri, 19 Jan 2024 19:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705693536; cv=none; b=YILhbeMuINTPoEKzTJo29VU4eoDtwDX1fSz8JgjbvfxspQa5zek/ZSx6DWksd3eLFGr2Bc1b49QonRW/hK7ngo+rZ8/ORqyyBnjCrYninsP78vOzxdMo5fenud6FPp8adUqOUdgUd9z2nMZl02JU0ZhFQz+jO0QQ70lyQoNfgEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705693536; c=relaxed/simple;
	bh=ZLRFh8jAtCz6PPqki5bAxQzNfDJr0iQNBuuoCLP1jyY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QdtGz39IIvQVPGdUinTAiYJ+nqxcXWiDINi/a6EJgcMez40l+cLkZMlvwF5KucLo6TlKewJf8wzhV5sp3GlN0Qvo+5B5u1aQpsVn3NG/MeBv76chP1aqOjhUL18d7uoUcqDEoRxb9VfrFwIGkRY0fqAU/ULyW0XikwzKrSumXAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i8qlEF5l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27FBCC433C7;
	Fri, 19 Jan 2024 19:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705693536;
	bh=ZLRFh8jAtCz6PPqki5bAxQzNfDJr0iQNBuuoCLP1jyY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i8qlEF5lFfm1rnknBphId32t07uJ2nWjZ0/vbiPRCdIJBTGH3RGmYFFCigwhoDjuK
	 pGvDBpEd3bg9kRqQBr2nd2+zOlbXyEQMy1eEDclTbGqmNl1sL5vngXy3TvavH1eG5K
	 t83Sb2pV54FQfxvF4wf/dzRlharZnoV7WWdmB2/dzUKd0BXalzqIFCSxcGN23ujhTK
	 iGVUrXYmcIySuzr6IIKdxbbqup7CATqsBYPI1ozLYJZPxapqjL1MTfLuSkQvJUdb6x
	 YDIEwjUvntaq11XQmZBCDnqRJuFqa9/nPYX2DFSYHq7BWK3+WJiaGmofo2U+O0vmA5
	 9HAR7B0e5IcWQ==
Date: Fri, 19 Jan 2024 13:45:34 -0600
From: Rob Herring <robh@kernel.org>
To: Dharma Balasubiramani <dharma.b@microchip.com>
Cc: conor.dooley@microchip.com, sam@ravnborg.org, bbrezillon@kernel.org,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev, dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, lee@kernel.org,
	thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
	linux-pwm@vger.kernel.org, linux4microchip@microchip.com
Subject: Re: [PATCH v3 2/3] dt-bindings: atmel,hlcdc: convert pwm bindings to
 json-schema
Message-ID: <20240119194534.GA938671-robh@kernel.org>
References: <20240118092612.117491-1-dharma.b@microchip.com>
 <20240118092612.117491-3-dharma.b@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240118092612.117491-3-dharma.b@microchip.com>

On Thu, Jan 18, 2024 at 02:56:11PM +0530, Dharma Balasubiramani wrote:
> Convert device tree bindings for Atmel's HLCDC PWM controller to YAML
> format.
> 
> Signed-off-by: Dharma Balasubiramani <dharma.b@microchip.com>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> ---
> changelog
> v2 -> v3
> - Remove '|' in description, as there is no formatting to preserve.
> - Delete the description for pwm-cells.
> - Drop the label for pwm node as it not used.
> v1 -> v2
> - Remove the explicit copyrights.
> - Modify title (not include words like binding/driver).
> - Modify description actually describing the hardware and not the driver.
> - Remove pinctrl properties which aren't required.
> - Drop parent node and it's other sub-device node which are not related here.
> ---
>  .../bindings/pwm/atmel,hlcdc-pwm.yaml         | 44 +++++++++++++++++++
>  .../bindings/pwm/atmel-hlcdc-pwm.txt          | 29 ------------
>  2 files changed, 44 insertions(+), 29 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/pwm/atmel,hlcdc-pwm.yaml
>  delete mode 100644 Documentation/devicetree/bindings/pwm/atmel-hlcdc-pwm.txt
> 
> diff --git a/Documentation/devicetree/bindings/pwm/atmel,hlcdc-pwm.yaml b/Documentation/devicetree/bindings/pwm/atmel,hlcdc-pwm.yaml
> new file mode 100644
> index 000000000000..4f4cc21fe4f7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pwm/atmel,hlcdc-pwm.yaml
> @@ -0,0 +1,44 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pwm/atmel,hlcdc-pwm.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Atmel's HLCDC's PWM controller
> +
> +maintainers:
> +  - Nicolas Ferre <nicolas.ferre@microchip.com>
> +  - Alexandre Belloni <alexandre.belloni@bootlin.com>
> +  - Claudiu Beznea <claudiu.beznea@tuxon.dev>
> +
> +description:
> +  The LCDC integrates a Pulse Width Modulation (PWM) Controller. This block
> +  generates the LCD contrast control signal (LCD_PWM) that controls the
> +  display's contrast by software. LCDC_PWM is an 8-bit PWM signal that can be
> +  converted to an analog voltage with a simple passive filter. LCD display
> +  panels have different backlight specifications in terms of minimum/maximum
> +  values for PWM frequency. If the LCDC PWM frequency range does not match the
> +  LCD display panel, it is possible to use the standalone PWM Controller to
> +  drive the backlight.
> +
> +properties:
> +  compatible:
> +    const: atmel,hlcdc-pwm
> +
> +  "#pwm-cells":
> +    const: 3
> +
> +required:
> +  - compatible
> +  - "#pwm-cells"
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    pwm {
> +      compatible = "atmel,hlcdc-pwm";
> +      pinctrl-names = "default";
> +      pinctrl-0 = <&pinctrl_lcd_pwm>;
> +      #pwm-cells = <3>;
> +    };

Move the example to the MFD schema. Or just drop if already there.

Rob

