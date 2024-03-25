Return-Path: <linux-kernel+bounces-117415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96A5088AB18
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:14:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36B161FA0079
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF48913BAE6;
	Mon, 25 Mar 2024 15:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="CviebTFY"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F962101E6;
	Mon, 25 Mar 2024 15:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711381994; cv=none; b=sXSz34+2pRR7PZRuZ5+/b/6+ny22qeXhNrOM3LpGS1cWIQbkug3C+9Y1T04fhnWBTxiVxg07yNBG+njG0qv+sHJoUk3Y9r93M7YftlKp0dQnIJT1VLGFRpbpiOi0NOfKI8ilzxkxCVUYtxky+dyc/p7o9CYq8Syd1d4HX2AtR/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711381994; c=relaxed/simple;
	bh=6qkwxJanykJAHfSSb7L1wdhXBNycnlwWLBxVXpMf/ic=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S8OcLDqTIMBUFr9AMTKbBTewplNrciXDE7Vz3JYjslacEJSwOYDibk7mS0nhKc8xscBF4LoHLK7xRs2TBuvOrBv5HufmsI4m+EhbSCJjAKi5IYu10H78WbkBHdQUUTbuSHuzrGCgIqHR8L8IJOIjkRU1/T6xR8xSumWGnITw/7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=CviebTFY; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1711381990;
	bh=6qkwxJanykJAHfSSb7L1wdhXBNycnlwWLBxVXpMf/ic=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CviebTFYvAdoJ4BAnSe4jHHEcyB/fzp+SFRkba/W0B53M13oFyvxhAzjbdkHe1p0w
	 74lBB1oKoUWzwD1d1M25ir2oo4Wfu4VW4wGVkbRnkjgxtGjbdeOtuvT7oc/MmUUO7x
	 1TB7qFW+EucAo/5qLsvYJmvvL+OzRJtIwONQK/UKO7ed2IVsY+/o8/TyQL/dX9kRjl
	 iMXAChnd/9SbI54p3Lrw4zMZAX+6uS814cMoK2dgQK0s2ASZ5co1REj8m4xvsr+a5c
	 PytTPYJcQY1rVNYmC+S6LusJboHEua1fw+KvixoaNoLgOKnSVV7vAW4sNblPCbYXj6
	 /SojULNn2PCwg==
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 4152337813B7;
	Mon, 25 Mar 2024 15:53:10 +0000 (UTC)
Date: Mon, 25 Mar 2024 16:53:08 +0100
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Heiko Stuebner <heiko@sntech.de>, linux-rockchip@lists.infradead.org,
 Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel@collabora.com
Subject: Re: [PATCH v1 4/4] arm64: dts: rockchip: rk3588-evb1: Enable GPU
Message-ID: <20240325165308.483b01b3@collabora.com>
In-Reply-To: <20240325153850.189128-5-sebastian.reichel@collabora.com>
References: <20240325153850.189128-1-sebastian.reichel@collabora.com>
	<20240325153850.189128-5-sebastian.reichel@collabora.com>
Organization: Collabora
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 25 Mar 2024 16:37:21 +0100
Sebastian Reichel <sebastian.reichel@collabora.com> wrote:

> From: Boris Brezillon <boris.brezillon@collabora.com>
> 
> Enable the Mali GPU in the RK3588 EVB1.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
>  arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dts | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dts b/arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dts
> index de30c2632b8e..b51a17b404f3 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dts
> @@ -281,6 +281,12 @@ &gmac0_rgmii_clk
>  	status = "okay";
>  };
>  
> +&gpu {
> +	mali-supply = <&vdd_gpu_s0>;
> +	sram-supply = <&vdd_gpu_mem_s0>;
> +	status = "okay";
> +};
> +
>  &i2c2 {
>  	status = "okay";
>  
> @@ -484,12 +490,15 @@ rk806_dvs3_null: dvs3-null-pins {
>  
>  		regulators {
>  			vdd_gpu_s0: dcdc-reg1 {
> +				regulator-always-on;

IIRC, this is only needed because of some bug in the power-domain
driver (or elsewhere). Is there any other reason to flag those as
always-on? I mean, it's working but probably not ideal from a PM
standpoint, as that means the regulators will stay on even when the GPU
is idle.

>  				regulator-boot-on;
>  				regulator-min-microvolt = <550000>;
>  				regulator-max-microvolt = <950000>;
>  				regulator-ramp-delay = <12500>;
>  				regulator-name = "vdd_gpu_s0";
>  				regulator-enable-ramp-delay = <400>;
> +				regulator-coupled-with = <&vdd_gpu_mem_s0>;
> +				regulator-coupled-max-spread = <10000>;
>  				regulator-state-mem {
>  					regulator-off-in-suspend;
>  				};
> @@ -534,12 +543,15 @@ regulator-state-mem {
>  			};
>  
>  			vdd_gpu_mem_s0: dcdc-reg5 {
> +				regulator-always-on;
>  				regulator-boot-on;
>  				regulator-min-microvolt = <675000>;
>  				regulator-max-microvolt = <950000>;
>  				regulator-ramp-delay = <12500>;
>  				regulator-enable-ramp-delay = <400>;
>  				regulator-name = "vdd_gpu_mem_s0";
> +				regulator-coupled-with = <&vdd_gpu_s0>;
> +				regulator-coupled-max-spread = <10000>;
>  				regulator-state-mem {
>  					regulator-off-in-suspend;
>  				};


