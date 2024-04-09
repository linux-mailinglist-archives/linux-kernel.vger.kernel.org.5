Return-Path: <linux-kernel+bounces-137021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2549789DB37
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 15:54:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3D6228A4AD
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 13:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 978AD130A72;
	Tue,  9 Apr 2024 13:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OiFpcHrJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA2412C531;
	Tue,  9 Apr 2024 13:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712670441; cv=none; b=iqlaIeDr207XDc5GlFyZx5O67cYOBWMOh4tG73vT4huTHztNU6TRcK89Xx+KvDprGIpDen5r0EjTNfY7fcPmF+Bnnj3ikZ/u+rVK/lujefQMGLY4l6dlEYfQchcWSdg7jta2YFA6PzeR5CMgLYPEWizCplEWVUhH/nYW1AV5FDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712670441; c=relaxed/simple;
	bh=eMgGDvBhSwomIduc3Ww9nHxOHT2zRidPoz1kaAAG6Xc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qBmCxUUiBerS9LgFse8HdC/SY5Y9AeWDWryGucfPoPhfTKE6j07pMol4oecv88IooNGk7VdMdW+x96ZEKN2k1LWM8CUkcOAbqRlSKmmIjvYh/LihBbDR+oKbCk4IY9v/rodYskIJiU9lRqUBQQe+26ShwmQ4AkMaGFwr3c7RoTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OiFpcHrJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E767C433F1;
	Tue,  9 Apr 2024 13:47:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712670440;
	bh=eMgGDvBhSwomIduc3Ww9nHxOHT2zRidPoz1kaAAG6Xc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OiFpcHrJrELfQ0w4lX0cktdooBbdqsoHCXatp67xvr4gT/dXvE4wa6RVsIydrq0Ce
	 RsIqw93EknR0C4SLFv+idmJKR6ZutAE7ABCpYqG1WtfW4qdFdm07px4Sr6CvEb3wMV
	 eNuBvEm0/6pqZY0bkHFkqKXe4mkepAUsvP3GB57ALkyiv35+N/B033wi1xMe+1mlHP
	 7PsPMY8c5DfwgLZ6Mgr7lrH6+ynkoJLzZOD+pdMYFQ9EwYi5qFUONZJozCwdX13aom
	 6VTB6jC2frvRFZAXY4S0Vf0k20CuzXzKcqgADfZDdMgG5afEEF2SIDBvU97l9C4S9M
	 RWYC1iDthhkiA==
Date: Tue, 9 Apr 2024 08:47:18 -0500
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
Subject: Re: [PATCH v2 1/2] dt-bindings: mtd: amlogic,meson-nand: support
 fields for boot ROM code
Message-ID: <20240409134718.GA1050037-robh@kernel.org>
References: <20240408085931.456337-1-avkrasnov@salutedevices.com>
 <20240408085931.456337-2-avkrasnov@salutedevices.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240408085931.456337-2-avkrasnov@salutedevices.com>

On Mon, Apr 08, 2024 at 11:59:30AM +0300, Arseniy Krasnov wrote:
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
> index 57b6957c8415..80ba5003ca70 100644
> --- a/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.yaml
> +++ b/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.yaml
> @@ -64,11 +64,25 @@ patternProperties:
>          items:
>            maximum: 0
>  
> +      amlogic,boot-page-last:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        description:
> +          The NFC driver needs this information to select ECC
> +          algorithms supported by the boot ROM.
> +
> +      amlogic,boot-page-step:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        description:
> +          The NFC driver needs this information to select ECC
> +          algorithms supported by the boot ROM (in pages).
> +
>      unevaluatedProperties: false
>  
>      dependencies:
>        nand-ecc-strength: [nand-ecc-step-size]
>        nand-ecc-step-size: [nand-ecc-strength]
> +      amlogic,boot-page-last: [nand-is-boot-medium, amlogic,boot-page-step]
> +      amlogic,boot-page-step: [nand-is-boot-medium, amlogic,boot-page-last]

You need quotes if using the inline syntax.

Rob

