Return-Path: <linux-kernel+bounces-145932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C72CC8A5CF0
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 23:27:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BE671C2181C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 21:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D19B157460;
	Mon, 15 Apr 2024 21:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hXy8eAQj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1A5156236;
	Mon, 15 Apr 2024 21:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713216433; cv=none; b=DyZXAnDuC+T6qQOYg0tzCpytq1qMAHS03/3F+rm/EWMZUmEcB3wAbODV7fvPQYaG0GL70fOKJ2UEU1Kam+rFrCpW7jTL6R8QwugKvIZwQFMXqPwFGgxSwVBXiIN8scJVzuo078A0ttPd6JPBQwf0AD2YY8rONNd2HlA7TyxWPXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713216433; c=relaxed/simple;
	bh=AokiBwLoenA+AuAq05ya7tY/KjTt6b5eb9h8P1KVQgY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Smrx3I99aSmmZcix2r+KUrPqJRRWUY4EBAZLMp6V/PccuguRo1VJw0iE/1FrTbYbuGkOG+GKnn7JJhgUqANr1txGKw9K97YBh847pt95wBBNBd0ReIQujQAeI3/7uZ3CvfQtEFbqeOt0pI8VrlFPNZD9I5bl/HVQ0wO7WlbwWrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hXy8eAQj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28C9AC113CC;
	Mon, 15 Apr 2024 21:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713216433;
	bh=AokiBwLoenA+AuAq05ya7tY/KjTt6b5eb9h8P1KVQgY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hXy8eAQj0AlY6mfR43iRJ6wS/B4Mn29gxVYqTjINDIeY7vknv4DS3h4gc4pDRJLUq
	 uB1iJajd7UgRZ7Da4E2BzwyONCB1jPrkpDxaA01jy7sQbz4WuQreTY69KXFrZtxtU7
	 t1AwZARUlS1IyHp3/w+trYZ2JH5XrcDvDnKpvJlJKyKgMJTGyZV9ZxlQjEQ2pPgCGa
	 FeY9zkIYRVhknFX9GyEYSvm3upQRX61YNLdl2jQz94icifluufllDDRCdHdT61HzE3
	 osRcwcH6S3/KK/Bei8f6d22RF+Qa1WXy+tnX1cni3hG61xlz534rwNjrKLvaAO4KzF
	 kJqePPDycI82Q==
Date: Mon, 15 Apr 2024 16:27:10 -0500
From: Rob Herring <robh@kernel.org>
To: Arseniy Krasnov <avkrasnov@salutedevices.com>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
	oxffffaa@gmail.com, kernel@sberdevices.ru
Subject: Re: [PATCH v4 1/2] dt-bindings: mtd: amlogic,meson-nand: support
 fields for boot ROM code
Message-ID: <20240415212710.GA105671-robh@kernel.org>
References: <20240410185409.2635622-1-avkrasnov@salutedevices.com>
 <20240410185409.2635622-2-avkrasnov@salutedevices.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240410185409.2635622-2-avkrasnov@salutedevices.com>

On Wed, Apr 10, 2024 at 09:54:08PM +0300, Arseniy Krasnov wrote:
> Boot ROM code on Meson requires that some pages on NAND must be written
> in special mode: "short" ECC mode where each block is 384 bytes and
> scrambling mode is on. Such pages located with the specified interval
> within specified offset. Both interval and offset are located in the
> device tree and used by driver if 'nand-is-boot-medium' is set for
> NAND chip.
> 
> Signed-off-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
> ---
>  .../bindings/mtd/amlogic,meson-nand.yaml           | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.yaml b/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.yaml
> index 57b6957c8415..838ae1847ef0 100644
> --- a/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.yaml
> +++ b/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.yaml
> @@ -64,11 +64,25 @@ patternProperties:
>          items:
>            maximum: 0
>  
> +      amlogic,boot-pages:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        description:
> +          The NFC driver needs this information to select ECC
> +          algorithms supported by the boot ROM.

'the $driver drivers needs this information' is true for every property, 
so it's redundant. You fail to say *what* the property represents or 
defines.

> +
> +      amlogic,boot-page-step:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        description:
> +          The NFC driver needs this information to select ECC
> +          algorithms supported by the boot ROM (in pages).

Same issue here.

> +
>      unevaluatedProperties: false
>  
>      dependencies:
>        nand-ecc-strength: [nand-ecc-step-size]
>        nand-ecc-step-size: [nand-ecc-strength]
> +      amlogic,boot-pages: [nand-is-boot-medium, "amlogic,boot-page-step"]
> +      amlogic,boot-page-step: [nand-is-boot-medium, "amlogic,boot-pages"]
>  
>  
>  required:
> -- 
> 2.35.0
> 

