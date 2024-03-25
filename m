Return-Path: <linux-kernel+bounces-117403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD8E888B133
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 21:21:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24B86BC5B88
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85F8313E05A;
	Mon, 25 Mar 2024 15:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="PYdCrYRP"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6147512FF60;
	Mon, 25 Mar 2024 15:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711381486; cv=none; b=kivwfxdCRwX5RtTNnYrDAlqb1BEUx3nkL7hP0cW+rfI7+tg6zW9652e8UFwXBbXnbYIuhekc5tqQ7NIJ5kWd233cRcaeJlRxz24N4fIg6LCk/ERQcB6aw5D5vsEI5sbVUZP4kziaygFahPmVhpopS9YLTx/wurgWILj2R2pEh9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711381486; c=relaxed/simple;
	bh=p6elCi+U91QoAFAv5OeSOQpHEUSS0AUEz76zcbg2hA0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FCr0NM2ElTrx+v+ZovLXjQrQIduOFqioRsLae5/adllPUxeJ/1gRXnaCkHv+hi2M8zvUcidF71HvHyvJHClaCFNBcxYRSZzqV/zWiEJhM7ZV14v90cbbkHM+zhoUjjn3QBvI4g1XcMJgWXh1MGAQjSdyUW08QiYEvVY67y4YjPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=PYdCrYRP; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1711381484;
	bh=p6elCi+U91QoAFAv5OeSOQpHEUSS0AUEz76zcbg2hA0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PYdCrYRPfIizad0x8XJj4QyrkCvECXuEjXXWbP0AvprmmFOzPOap5u9xcrwYZDysS
	 yPpSyA85aJfTBU4XzfhA+CJDo3mX2S4aiNSlZdVEBhua1kJhCmLEJoXOJotemXE6gm
	 OHtw1pGPBMTfl+Mp38Fv7BFU7jwPEaAbbb9O6g+r2JdXsMtZLFtAOEzUvjglnlw5rp
	 lF0ysROvSqj4yonmLH2KAknuStT9vGsOB2LkHK0HDFbdn9A97TnWVcvZ+GWPH7Lk78
	 vgnSN0Zr61wN3O7/eCyX1XD2x1EMW6WIaFQkkGWgektmkkCQZBYqK3s/IACjsJINrO
	 h4YbokDZkcmaQ==
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 6617A37813B7;
	Mon, 25 Mar 2024 15:44:43 +0000 (UTC)
Date: Mon, 25 Mar 2024 16:44:41 +0100
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Heiko Stuebner <heiko@sntech.de>, linux-rockchip@lists.infradead.org,
 Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel@collabora.com
Subject: Re: [PATCH v1 3/4] arm64: dts: rockchip: rk3588-rock5b: Enable GPU
Message-ID: <20240325164441.1dab4018@collabora.com>
In-Reply-To: <20240325153850.189128-4-sebastian.reichel@collabora.com>
References: <20240325153850.189128-1-sebastian.reichel@collabora.com>
	<20240325153850.189128-4-sebastian.reichel@collabora.com>
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

On Mon, 25 Mar 2024 16:37:20 +0100
Sebastian Reichel <sebastian.reichel@collabora.com> wrote:

> From: Boris Brezillon <boris.brezillon@collabora.com>
> 
> Enable the Mali GPU in the Rock 5B.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>

I don't remember writing this patch ;-), maybe I screwed authorship at
some point, dunno.

> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
>  arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
> index 1fe8b2a0ed75..096ee7a98b89 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts
> @@ -180,6 +180,11 @@ &cpu_l3 {
>  	cpu-supply = <&vdd_cpu_lit_s0>;
>  };
>  
> +&gpu {
> +	mali-supply = <&vdd_gpu_s0>;
> +	status = "okay";
> +};
> +
>  &i2c0 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&i2c0m2_xfer>;
> @@ -470,6 +475,7 @@ rk806_dvs3_null: dvs3-null-pins {
>  
>  		regulators {
>  			vdd_gpu_s0: vdd_gpu_mem_s0: dcdc-reg1 {
> +				regulator-always-on;

Hm, should we mention why the regulator is always on here?

>  				regulator-boot-on;
>  				regulator-min-microvolt = <550000>;
>  				regulator-max-microvolt = <950000>;


