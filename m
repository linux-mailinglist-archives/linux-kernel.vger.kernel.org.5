Return-Path: <linux-kernel+bounces-7111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1E4E81A1C8
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 16:04:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E528C1C208FE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 15:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 951913DBBA;
	Wed, 20 Dec 2023 15:04:10 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A26D3F8D6;
	Wed, 20 Dec 2023 15:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5900D1FB;
	Wed, 20 Dec 2023 07:04:50 -0800 (PST)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AF96D3F64C;
	Wed, 20 Dec 2023 07:04:03 -0800 (PST)
Date: Wed, 20 Dec 2023 15:04:00 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: fuyao <fuyao1697@cyg.com>
Cc: Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>, Alexandre TORGUE
 <alexandre.torgue@st.com>, Enric Balletbo i Serra <eballetbo@gmail.com>,
 Baruch Siach <baruch@tkos.co.il>, Paul Barker <paul.barker@sancloud.com>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] ARM: dts: sun8i: r40: open the regulator aldo1
Message-ID: <20231220150400.0f32e2a5@donnerap.manchester.arm.com>
In-Reply-To: <ZYKjYypuAx7gNuam@debian.cyg>
References: <ZYKjYypuAx7gNuam@debian.cyg>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 20 Dec 2023 16:18:43 +0800
fuyao <fuyao1697@cyg.com> wrote:

Hi,

> the aldo1 is connect regulator pin which power the TV.

What do you mean with that? That ALDO1 is connected to VCC-TVOUT and/or
VCC-TVIN on the R40 SoC?

> The USB core use TV ref as reference Voltage.

The USB core in the SoC? So pin VCC-USB, which requires 3.3V, the same
voltage as the TV pins?
Which means this doesn't really have much to do with TV, it's just that
USB and also "TV" are supplied by ALDO1?

> Signed-off-by: fuyao <fuyao1697@cyg.com>
> ---
>  arch/arm/boot/dts/allwinner/sun8i-r40-feta40i.dtsi | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/allwinner/sun8i-r40-feta40i.dtsi b/arch/arm/boot/dts/allwinner/sun8i-r40-feta40i.dtsi
> index 9f39b5a2bb35..8906170461df 100644
> --- a/arch/arm/boot/dts/allwinner/sun8i-r40-feta40i.dtsi
> +++ b/arch/arm/boot/dts/allwinner/sun8i-r40-feta40i.dtsi
> @@ -42,6 +42,13 @@ &pio {
>  	vcc-pg-supply = <&reg_dldo1>;
>  };
>  
> +&reg_aldo1 {
> +	regulator-always-on;

So did USB never work before, with the DT as in mainline?

For always-on regulators it would be good to see some rationale why this
cannot be referenced by its consumer. If it is really supplying the USB
core, that would be a reason, because we don't have a good way of
describing this.

> +	regulator-min-microvolt = <3300000>;
> +	regulator-max-microvolt = <3300000>;
> +	regulator-name = "vcc-aldo1";

Regulators should be named after their users, so use something like:
	regulator-name = "vcc-3v3-tv-usb";

That then also serves as documentation of why this is always on.

Cheers,
Andre

> +};
> +
>  &reg_aldo2 {
>  	regulator-always-on;
>  	regulator-min-microvolt = <1800000>;


