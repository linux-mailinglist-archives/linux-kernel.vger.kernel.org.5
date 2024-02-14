Return-Path: <linux-kernel+bounces-64977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70666854560
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 10:34:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E47F1F2E0B0
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 09:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B998012E5E;
	Wed, 14 Feb 2024 09:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="JkBF/Esl"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D1614AA5;
	Wed, 14 Feb 2024 09:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707903236; cv=none; b=GBsAS74ngwbwN2e/tRhxeVDEKAE8PC4g+3osOSCxFkZXs4wrdjxKzebFCfKQJUkIM2XQ9oA6SjWgiylR5DWp+MYRg/Rdz5Bqg8HmbhSk/84N6aN5yGMDUH/R90AVnu+RCt44r9Q+tLxxzNV7KZtBCu5p2zGQ7U5lN1++9V94j20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707903236; c=relaxed/simple;
	bh=0sRF2fYJsoTIYT5ppyHEQIjBd+Nyoe/Br/X1weWpW1o=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=cH2mjU8CAayMoMkv+MQepDxyM64Lkdae6OD/GP2Cw8mXSWtw+peDURGerrOia/mmvK5F8+X9SuaiUqNw/NgqR9YvNpTuTBOqDYP01n0CFDxjueqBaUN/WfpNasETRCW45+BU80FBAaPg6VOVm3Tnw/1OidssfdHi2M9PXPdL1Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=JkBF/Esl; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41E9XdsR092356;
	Wed, 14 Feb 2024 03:33:39 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707903220;
	bh=FX81LtiN4vosjyx6v3LoLwfNCXMnS9Oe2H6l1AufTkM=;
	h=Date:Subject:To:References:From:In-Reply-To;
	b=JkBF/EslcADZE/fPgTc+dvQc5W05erx7PhWbbtYAY1ieQIXwDOWSWVcmyDiaQ3Zhs
	 0ZGLwOOXWSebYWRQEykIX3TyCKzcrEP4Z7sEucHSNpiUvNrxSYqSKotC7b39vGzlee
	 BtxcVvoDeKbermcBqqrQszGUnO8wZWvepeGlWmTs=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41E9Xdp7130107
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 14 Feb 2024 03:33:39 -0600
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 14
 Feb 2024 03:33:39 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 14 Feb 2024 03:33:39 -0600
Received: from [172.24.227.36] (a0497641-hp-z2-tower-g9-workstation-desktop-pc.dhcp.ti.com [172.24.227.36])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41E9XI60090954;
	Wed, 14 Feb 2024 03:33:36 -0600
Message-ID: <a8ed43ca-d2fb-4dce-ba9f-9c52e5a05b1a@ti.com>
Date: Wed, 14 Feb 2024 15:03:36 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] arm64: dts: ti: k3-j721e-sk: fix PMIC interrupt
 number
Content-Language: en-US
To: Romain Naour <romain.naour@smile.fr>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <conor+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <robh+dt@kernel.org>, <kristo@kernel.org>, <vigneshr@ti.com>,
        <nm@ti.com>
References: <20240209171146.307465-1-romain.naour@smile.fr>
 <20240209171146.307465-2-romain.naour@smile.fr>
From: Neha Malcom Francis <n-francis@ti.com>
In-Reply-To: <20240209171146.307465-2-romain.naour@smile.fr>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 09/02/24 22:41, Romain Naour wrote:
> The tps659413 and tps659411 nodes set WKUP_GPIO0_7 (G28) pin as input
> to be used as PMIC interrupt but uses 9 (WKUP_GPIO0_9) as
> "interrupts" property.
> 
> Replace 9 by 7 for both tps659413 and tps659411 after checking in the
> board schematic [1].
> 
> [1] https://www.ti.com/tool/SK-TDA4VM
> 
> Fixes: b808cef0be46 ("arm64: dts: ti: k3-j721e-sk: Add TPS6594 family PMICs")
> Cc: Neha Malcom Francis <n-francis@ti.com>
> Signed-off-by: Romain Naour <romain.naour@smile.fr>
> ---
> v2: update tps659411 interrupts parameter too.
> ---
>   arch/arm64/boot/dts/ti/k3-j721e-sk.dts | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j721e-sk.dts b/arch/arm64/boot/dts/ti/k3-j721e-sk.dts
> index 188dfe291a32..658764f7d544 100644
> --- a/arch/arm64/boot/dts/ti/k3-j721e-sk.dts
> +++ b/arch/arm64/boot/dts/ti/k3-j721e-sk.dts
> @@ -574,7 +574,7 @@ tps659413: pmic@48 {
>   		pinctrl-names = "default";
>   		pinctrl-0 = <&pmic_irq_pins_default>;
>   		interrupt-parent = <&wkup_gpio0>;
> -		interrupts = <9 IRQ_TYPE_EDGE_FALLING>;
> +		interrupts = <7 IRQ_TYPE_EDGE_FALLING>;
>   		gpio-controller;
>   		#gpio-cells = <2>;
>   		ti,primary-pmic;
> @@ -651,7 +651,7 @@ tps659411: pmic@4c {
>   		reg = <0x4c>;
>   		system-power-controller;
>   		interrupt-parent = <&wkup_gpio0>;
> -		interrupts = <9 IRQ_TYPE_EDGE_FALLING>;
> +		interrupts = <7 IRQ_TYPE_EDGE_FALLING>;
>   		gpio-controller;
>   		#gpio-cells = <2>;
>   		buck1234-supply = <&vsys_3v3>;


Reviewed-by: Neha Malcom Francis <n-francis@ti.com>

-- 
Thanking You
Neha Malcom Francis

