Return-Path: <linux-kernel+bounces-18923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 504F882652C
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 17:44:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0D331C215E2
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 16:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C754A13AE8;
	Sun,  7 Jan 2024 16:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KYjoohRE"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1726F13ADE;
	Sun,  7 Jan 2024 16:44:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C6E1C433C8;
	Sun,  7 Jan 2024 16:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704645846;
	bh=yNuz58aVKzYmHclOZSz1fw5Rc9L0KgXBqimMwdOlpUk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KYjoohREaK0YSvHr3ECAzknIg8vFcNYObH2tLXzm6mx0i37QXMPrOCCybDv1aN0Z3
	 U84nhFjdVNZzhd1Aa8neNg9SE7ynhCy0S7IsCpqnPI/8herlXN2DMCXQPZwHzXc6gi
	 v7oDRftEYjLLSAEtLH7yzgZFG5ZGmoY755pXfXXg+qqHSmRez+pf0MjQC6dPLmGEqV
	 Ib1TBRJCGcHr4ZjzNgtlCNAhuDWBfbyGP0XwFYzBGENfvrC1cAN2omwe2SuDmiXYv+
	 mEb834deSX3yKNdsvrYyEgLb+Jvam7Y6jcJag0zgMwxsK/DmMktfuMdmCpQYASQZ8/
	 k//qs42hwV95Q==
Date: Sun, 7 Jan 2024 16:43:56 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: linux-iio@vger.kernel.org, linux-spi@vger.kernel.org,
 devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, Michael Hennerich <michael.hennerich@analog.com>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Liam Girdwood
 <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] dt-bindings: spi: add spi-rx-bus-channels
 peripheral property
Message-ID: <20240107164356.3e8df266@jic23-huawei>
In-Reply-To: <20231215-ad7380-mainline-v3-1-7a11ebf642b9@baylibre.com>
References: <20231215-ad7380-mainline-v3-0-7a11ebf642b9@baylibre.com>
	<20231215-ad7380-mainline-v3-1-7a11ebf642b9@baylibre.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.39; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 15 Dec 2023 04:32:02 -0600
David Lechner <dlechner@baylibre.com> wrote:

> This adds a new spi-rx-bus-channels property to the generic spi
> peripheral property bindings. This property is used to describe
> devices that have parallel data output channels.
> 
> This property is different from spi-rx-bus-width in that the latter
> means that we are reading multiple bits of a single word at one time
> while the former means that we are reading single bits of multiple words
> at the same time.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
> 
> The rest of this series is ready to merge, so just looking for an ack from
> Mark on this one.

Mark, could you take a look at this SPI binding change when you have time?

I don't want to apply it without your view on whether this makes sense
from a general SPI point of view as we all hate maintaining bindings
if they turn out to not be sufficiently future looking etc and we need
to deprecate them in favour of something else.

Thanks,

Jonathan

> 
>  .../devicetree/bindings/spi/spi-peripheral-props.yaml        | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
> index 15938f81fdce..1c8e71c18234 100644
> --- a/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
> +++ b/Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
> @@ -67,6 +67,18 @@ properties:
>      enum: [0, 1, 2, 4, 8]
>      default: 1
>  
> +  spi-rx-bus-channels:
> +    description:
> +      The number of parallel channels for read transfers. The difference between
> +      this and spi-rx-bus-width is that a value N for spi-rx-bus-channels means
> +      the SPI bus is receiving one bit each of N different words at the same
> +      time whereas a value M for spi-rx-bus-width means that the bus is
> +      receiving M bits of a single word at the same time. It is also possible to
> +      use both properties at the same time, meaning the bus is receiving M bits
> +      of N different words at the same time.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    default: 1
> +
>    spi-rx-delay-us:
>      description:
>        Delay, in microseconds, after a read transfer.
> 


