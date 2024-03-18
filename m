Return-Path: <linux-kernel+bounces-106092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EE9C87E8E7
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 12:50:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44DB01C21821
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 11:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17537376EC;
	Mon, 18 Mar 2024 11:50:30 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17C6937162;
	Mon, 18 Mar 2024 11:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710762629; cv=none; b=vFp800VCWvQ6qfl5nAChadqwJcgNsJbqvGdwxcLHRP13/rskvlpWgPFkdUvhUxLfRaUKHaLPRT2UKcpECH90yqJc130D4qDkeRopcX9opNL8viYtCK/y+6JTOka2OqJlq0pi+6lHm56d7g2b9O2jPPT0iY3m9lmZl+Wf5BmZbV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710762629; c=relaxed/simple;
	bh=jTDdMudVhYB9Z0ObVnYky7+BLMrmLovdUgzxDbvmYMI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hQdqaVs/BIeB1TbOZM8Wl9qmWC8yGaVKI1E2XhABYbn1RPLLM8hw352NRJObUitV0wSWgfbpkyON0BrPPIqv4edvkkR9KfHXhlce/iLMejD9a/kcdoK+arjNLyIHtsMdMM0fmndPURER/njwmW0oEHk7m0zA14K4Q/XZNaS+tmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8163BDA7;
	Mon, 18 Mar 2024 04:51:02 -0700 (PDT)
Received: from donnerap.manchester.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 066463F762;
	Mon, 18 Mar 2024 04:50:25 -0700 (PDT)
Date: Mon, 18 Mar 2024 11:50:23 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>, Corentin Labbe <clabbe@baylibre.com>,
 Maxime Ripard <mripard@kernel.org>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] arm64: dts: allwinner: Pine H64: correctly remove
 reg_gmac_3v3
Message-ID: <20240318115023.59e368f2@donnerap.manchester.arm.com>
In-Reply-To: <20240317184130.157695-1-krzysztof.kozlowski@linaro.org>
References: <20240317184130.157695-1-krzysztof.kozlowski@linaro.org>
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

On Sun, 17 Mar 2024 19:41:27 +0100
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

Hi Krzysztof,

> There is no "reg_gmac_3v3" device node in sun50i-h6-pine-h64.dts,
> although there is "gmac-3v3" with "reg_gmac_3v3" label, so let's assume
> author wanted to remove that node.  Delete node via phandle, not via
> full node path, to fix this.

Ah, that's a good catch! Indeed that regulator node is still in the DTB
right now.

> Fixes: f33a91175029 ("arm64: dts: allwinner: add pineh64 model B")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Successfully compiled the DTB and can confirm that the node is gone now.

Reviewed-by: Andre Przywara <andre.przywara@arm.com>

Cheers,
Andre

> ---
>  arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64-model-b.dts | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64-model-b.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64-model-b.dts
> index b710f1a0f53a..1b6e5595ac6e 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64-model-b.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64-model-b.dts
> @@ -5,12 +5,12 @@
>  
>  #include "sun50i-h6-pine-h64.dts"
>  
> +/delete-node/ &reg_gmac_3v3;
> +
>  / {
>  	model = "Pine H64 model B";
>  	compatible = "pine64,pine-h64-model-b", "allwinner,sun50i-h6";
>  
> -	/delete-node/ reg_gmac_3v3;
> -
>  	wifi_pwrseq: wifi_pwrseq {
>  		compatible = "mmc-pwrseq-simple";
>  		reset-gpios = <&r_pio 1 3 GPIO_ACTIVE_LOW>; /* PM3 */


