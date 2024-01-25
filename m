Return-Path: <linux-kernel+bounces-38560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E91783C198
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 13:04:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA7DE288240
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 12:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B415376E0;
	Thu, 25 Jan 2024 12:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Hf0soOzB"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03330175BC;
	Thu, 25 Jan 2024 12:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706184263; cv=none; b=IFtARP3QkoJWpqBhF/BGpBQ31qqTjN1eWmwbvkEdvajBVju7Hap1Wbo0zaS8KcrAdaEryv7/nu+PAmVZot2Ak0jz+9SnXye4FHydL9lUhajrE2DqlJ0H719cjKzfqqTJ3WLCXsnY8AyfCWxEt8QQc1mMDjoNHbxXHywGCNsApMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706184263; c=relaxed/simple;
	bh=5bp79cwDp8DSmmQoBYXJMCmgVWIkVUnM66o+7HqXkY8=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=b05avqX3DZvvX06NctWT7wA4amzl7jpkfG3lnpYxgaw35Lenm9cH1fImpP0W5H+KRBG95wsGWGHVTiQ3NmyeXCDJlhSBDfZlzbOqtlQ4gxlUbSlyjYobe0Pv79eCVd/U6Fx/4i3GihqbhHQ8ahk+RJydpD9pTreGmZ/vYbU/pN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Hf0soOzB; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40PC3pVf106723;
	Thu, 25 Jan 2024 06:03:51 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706184231;
	bh=k+mmQBY2pE0JBtYEWVRQvsRmj8Awiu7mIvMnAkSv+mI=;
	h=Date:CC:Subject:To:References:From:In-Reply-To;
	b=Hf0soOzBNclS7zZhil5eXj9DMg/zI3jdSCQ/nlzpYlBI9aK7geluSs71mFiMO+I+U
	 D4USidB/4RVdlWukwU6AKKBstSIptkgCMneRwKB3EGyy3gy40yOULDwc8WV/xudzvF
	 xJtJBDQm5xLCnYU8kUmU7GhSBM9FZMeACZfNT09c=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40PC3pYK110230
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 25 Jan 2024 06:03:51 -0600
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 25
 Jan 2024 06:03:50 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 25 Jan 2024 06:03:50 -0600
Received: from [172.24.227.9] (uda0492258.dhcp.ti.com [172.24.227.9])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40PC3jFG017632;
	Thu, 25 Jan 2024 06:03:46 -0600
Message-ID: <0db57065-b48a-4c63-8ad3-45af2924a3cb@ti.com>
Date: Thu, 25 Jan 2024 17:33:45 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: Andrew Davis <afd@ti.com>, Peter Rosin <peda@axentia.se>,
        Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, Tero
 Kristo <kristo@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>, Nishanth
 Menon <nm@ti.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        <r-gunasekaran@ti.com>, <danishanwar@ti.com>, <s-vadapalli@ti.com>
Subject: Re: [PATCH v3 2/5] arm64: dts: ti: k3-j784s4-main: Add CPSW2G and
 CPSW9G nodes
Content-Language: en-US
To: Chintan Vankar <c-vankar@ti.com>
References: <20240125100501.4137977-1-c-vankar@ti.com>
 <20240125100501.4137977-3-c-vankar@ti.com>
From: Siddharth Vadapalli <s-vadapalli@ti.com>
In-Reply-To: <20240125100501.4137977-3-c-vankar@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hello Chintan,

On 25/01/24 15:34, Chintan Vankar wrote:
> From: Siddharth Vadapalli <s-vadapalli@ti.com>
> 

..

>  
> +	main_cpsw0: ethernet@c000000 {
> +		compatible = "ti,j784s4-cpswxg-nuss";
> +		reg = <0x00 0xc000000 0x00 0x200000>;
> +		reg-names = "cpsw_nuss";
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges = <0x00 0x00 0x00 0xc000000 0x00 0x200000>;
> +		dma-coherent;
> +		clocks = <&k3_clks 64 0>;
> +		clock-names = "fck";
> +		power-domains = <&k3_pds 64 TI_SCI_PD_EXCLUSIVE>;
> +
> +		dmas = <&main_udmap 0xca00>,
> +		       <&main_udmap 0xca01>,
> +		       <&main_udmap 0xca02>,
> +		       <&main_udmap 0xca03>,
> +		       <&main_udmap 0xca04>,
> +		       <&main_udmap 0xca05>,
> +		       <&main_udmap 0xca06>,
> +		       <&main_udmap 0xca07>,
> +		       <&main_udmap 0x4a00>;
> +		dma-names = "tx0", "tx1", "tx2", "tx3",
> +			    "tx4", "tx5", "tx6", "tx7",
> +			    "rx";
> +
> +		status = "disabled";
> +
> +		ethernet-ports {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			main_cpsw0_port1: port@1 {
> +				reg = <1>;
> +				label = "port1";
> +				ti,mac-only;
> +				status = "disabled";
> +			};
> +
> +			main_cpsw0_port2: port@2 {
> +				reg = <2>;
> +				label = "port2";
> +				ti,mac-only;
> +				status = "disabled";
> +			};
> +
> +			main_cpsw0_port3: port@3 {
> +				reg = <3>;
> +				label = "port3";
> +				ti,mac-only;
> +				status = "disabled";
> +			};
> +
> +			main_cpsw0_port4: port@4 {
> +				reg = <4>;
> +				label = "port4";
> +				ti,mac-only;
> +				status = "disabled";
> +			};
> +
> +			main_cpsw0_port5: port@5 {
> +				reg = <5>;
> +				label = "port5";

Please add the "ti,mac-only" property here and in the following 3 nodes as well
to keep it consistent.

> +				status = "disabled";
> +			};
> +
> +			main_cpsw0_port6: port@6 {
> +				reg = <6>;
> +				label = "port6";
> +				status = "disabled";
> +			};
> +
> +			main_cpsw0_port7: port@7 {
> +				reg = <7>;
> +				label = "port7";
> +				status = "disabled";
> +			};
> +
> +			main_cpsw0_port8: port@8 {
> +				reg = <8>;
> +				label = "port8";
> +				status = "disabled";
> +			};
> +		};
> +

..

-- 
Regards,
Siddharth.

