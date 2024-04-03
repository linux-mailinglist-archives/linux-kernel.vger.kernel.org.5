Return-Path: <linux-kernel+bounces-130239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B88888975D3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 19:02:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 909631C261D6
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 17:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF96A152504;
	Wed,  3 Apr 2024 17:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rx/GFrI/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA611514D2;
	Wed,  3 Apr 2024 17:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712163740; cv=none; b=JTig32J50p1+ESVHrYXI3eHrBiBwOYcA3blOmBiMJQUAZDTOjDAjowHvh0k8hh8LHZiJ7kVHExMTpL5AF/rEc2SyJg1lsgEmuGuoMqWbC5WFWmFJM6Xid/6wcz07BJQxdHydNphG/qNKEsbAgo1IowWt8Oe/xIDUj2Gt9k5q/g4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712163740; c=relaxed/simple;
	bh=2oGsbwbq15QL3wvwkV7hEBDpgVGRbcvJNrIyVScYh6g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AGEfiepnNSLcUDJdMm/aPAcP+s2deE5d4S327TdYLK+0a2VGUfqRllhLMsHf7hX4cqvduxzW84QzlPiZWiVF4N04HTpuxEJF4u8luuCZFvIgX0W9OVkfCnksvN4d4d2CChc+Odr+z2yWv35+oysKqsyS0DrxrFkVxoX5hAnQ5rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rx/GFrI/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87308C43390;
	Wed,  3 Apr 2024 17:02:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712163739;
	bh=2oGsbwbq15QL3wvwkV7hEBDpgVGRbcvJNrIyVScYh6g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Rx/GFrI/POAqeyJagkVNQjQ4UaDfYwJqjMkwf9+CnS/ac8n2Nb03EXzq0FqdGLE7L
	 SZlx7hdF0VWhMXORF4dGtipOW3bT9HocxdzMhoTdJYCqsTyqw1jJwz77HENtm8I2jE
	 SiV5GRjTCv6qotdJjr41qnIewCD/i3z3HkxRIam96U0DRROD8MUYtopJRnM2djQMGN
	 Ugyl4CkPhuqxLmbQGsEFgLHry+oNQbGVmqF8a5j2HFVlqXWG5fXewg9exJ4EfF7u/Z
	 TrLZZPmB8o5YgFCKltUaE9VjMDWMnB4gPxiekAKLQ/s45NQ6VdGym9etkYC0lIJgmC
	 6n23OeoB3gvgw==
Date: Wed, 3 Apr 2024 12:02:17 -0500
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
Subject: Re: [PATCH v1 1/2] dt-bindings: mtd: amlogic,meson-nand: support
 fields for boot ROM code
Message-ID: <20240403170217.GA3984955-robh@kernel.org>
References: <20240402202705.2355326-1-avkrasnov@salutedevices.com>
 <20240402202705.2355326-2-avkrasnov@salutedevices.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240402202705.2355326-2-avkrasnov@salutedevices.com>

On Tue, Apr 02, 2024 at 11:27:04PM +0300, Arseniy Krasnov wrote:
> Boot ROM code on Meson requires that some pages on NAND must be written
> in special mode: "short" ECC mode where each block is 384 bytes and
> scrambling mode is on. Such pages located with the specified interval
> within specified offset. Both interval and offset are located in the
> device tree and used by driver if 'nand-is-boot-medium' is set for
> NAND chip.
> 
> Signed-off-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
> ---
>  .../bindings/mtd/amlogic,meson-nand.yaml         | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.yaml b/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.yaml
> index 57b6957c8415..f49819ee76b8 100644
> --- a/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.yaml
> +++ b/Documentation/devicetree/bindings/mtd/amlogic,meson-nand.yaml
> @@ -64,11 +64,27 @@ patternProperties:
>          items:
>            maximum: 0
>  
> +      meson,boot-page-last:

'meson' is not a valid vendor.

> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        description:
> +          The NFC driver needs this information to select ECC
> +          algorithms supported by the boot ROM.
> +          Only used in combination with 'nand-is-boot-medium'.

No need to state what's captured with constraints.

> +
> +      meson,boot-page-step:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        description:
> +          The NFC driver needs this information to select ECC
> +          algorithms supported by the boot ROM.
> +          Only used in combination with 'nand-is-boot-medium'.

step is in blocks/pages/bytes?

> +
>      unevaluatedProperties: false
>  
>      dependencies:
>        nand-ecc-strength: [nand-ecc-step-size]
>        nand-ecc-step-size: [nand-ecc-strength]
> +      meson,boot-page-last: [nand-is-boot-medium]
> +      meson,boot-page-step: [nand-is-boot-medium]

I assume both properties must be present? If so:

meson,boot-page-last: ['meson,boot-page-step']
meson,boot-page-step: ['meson,boot-page-last']

Rob

