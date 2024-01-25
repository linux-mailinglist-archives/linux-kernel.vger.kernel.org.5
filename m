Return-Path: <linux-kernel+bounces-38743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08AA983C520
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 15:47:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5815292353
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 14:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 324456EB47;
	Thu, 25 Jan 2024 14:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="HSbj3U7o"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD2936DD1D;
	Thu, 25 Jan 2024 14:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706194042; cv=none; b=iN7cvrEB//Cx1fgBGHWDpj7b4QgL5TCSQVsjKnUpxBt94Stlvo5ljrsNR9nseYSpkePSV8XxF87xVipmLAA4VYa2Gn+QERSvAcmTkjsIeLorZ1vpYHw/VQwGM7zeCP566reDx8bECe2+LQOUR1p5CiXti3WYvIWnlOfclU6Dh0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706194042; c=relaxed/simple;
	bh=WsVmPf+FEspaeZMEYX/3tKPPjqKErDviLE42fEGcT0U=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=LGG0fEmt5/0M7Lbanao4wsaj+iSE1+KiMEaRUCdpdirvAo7QYDAFnfZ47RUcWGNDKfD6P1hJx3zKiydBI3C7GqPN0z/KaNfEYMD1ZZqKRe9A8E9JR8Fa5g4ak8eMBekB0cv+g5twRLvUHveILtUuibV9yiyyxZhzI4c1yfllVfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=HSbj3U7o; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40PEl9nv055580;
	Thu, 25 Jan 2024 08:47:09 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706194029;
	bh=GNbstS5x7P650fLxgLNehqdh3nUvUe2wiyCCBgE0H/A=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=HSbj3U7oGoL+PzG5NPkj0w+57+zritNreWUelqzDjTTOA/HJFRtCasqytBQtPnVX+
	 BnKYPT8noTR7vmD2qhHbCiyXYtxDtkTKXsishTixIgy7qwK9HY5d+wkSt6A3s2b5H5
	 YDZFlp2g7UMCqppyMNOOVPu7T4aiwXH9HAx67UhQ=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40PEl9ji064671
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 25 Jan 2024 08:47:09 -0600
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 25
 Jan 2024 08:47:09 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 25 Jan 2024 08:47:09 -0600
Received: from [10.249.42.149] ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40PEl8kL101598;
	Thu, 25 Jan 2024 08:47:08 -0600
Message-ID: <585e7ceb-f714-4c11-b9af-13d3bd325d12@ti.com>
Date: Thu, 25 Jan 2024 08:47:08 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/5] arm64: dts: ti: k3-j784s4-main: Fix mux-reg-masks
 in serdes_ln_ctrl
Content-Language: en-US
To: Chintan Vankar <c-vankar@ti.com>, Peter Rosin <peda@axentia.se>,
        Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, Tero
 Kristo <kristo@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>, Nishanth
 Menon <nm@ti.com>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        <s-vadapalli@ti.com>, <r-gunasekaran@ti.com>, <danishanwar@ti.com>
References: <20240125100501.4137977-1-c-vankar@ti.com>
 <20240125100501.4137977-2-c-vankar@ti.com>
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20240125100501.4137977-2-c-vankar@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 1/25/24 4:04 AM, Chintan Vankar wrote:
> Change offset in mux-reg-masks property for serdes_ln_ctrl node
> since reg-mux property is used in compatible.
> 
> Fixes: 2765149273f4 ("mux: mmio: use reg property when parent device is not a syscon")
> Signed-off-by: Chintan Vankar <c-vankar@ti.com>

Acked-by: Andrew Davis <afd@ti.com>

> ---
>   arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
> index f2b720ed1e4f..56c8eaad6324 100644
> --- a/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi
> @@ -52,12 +52,12 @@ serdes_ln_ctrl: mux-controller@4080 {
>   			compatible = "reg-mux";
>   			reg = <0x00004080 0x30>;
>   			#mux-control-cells = <1>;
> -			mux-reg-masks = <0x4080 0x3>, <0x4084 0x3>, /* SERDES0 lane0/1 select */
> -					<0x4088 0x3>, <0x408c 0x3>, /* SERDES0 lane2/3 select */
> -					<0x4090 0x3>, <0x4094 0x3>, /* SERDES1 lane0/1 select */
> -					<0x4098 0x3>, <0x409c 0x3>, /* SERDES1 lane2/3 select */
> -					<0x40a0 0x3>, <0x40a4 0x3>, /* SERDES2 lane0/1 select */
> -					<0x40a8 0x3>, <0x40ac 0x3>; /* SERDES2 lane2/3 select */
> +			mux-reg-masks = <0x0 0x3>, <0x4 0x3>, /* SERDES0 lane0/1 select */
> +					<0x8 0x3>, <0xc 0x3>, /* SERDES0 lane2/3 select */
> +					<0x10 0x3>, <0x14 0x3>, /* SERDES1 lane0/1 select */
> +					<0x18 0x3>, <0x1c 0x3>, /* SERDES1 lane2/3 select */
> +					<0x20 0x3>, <0x24 0x3>, /* SERDES2 lane0/1 select */
> +					<0x28 0x3>, <0x2c 0x3>; /* SERDES2 lane2/3 select */
>   			idle-states = <J784S4_SERDES0_LANE0_PCIE1_LANE0>,
>   				      <J784S4_SERDES0_LANE1_PCIE1_LANE1>,
>   				      <J784S4_SERDES0_LANE2_IP3_UNUSED>,

