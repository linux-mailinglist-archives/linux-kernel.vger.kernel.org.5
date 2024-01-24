Return-Path: <linux-kernel+bounces-36489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D28A683A199
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 06:56:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6551DB22C7F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 05:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D454CF501;
	Wed, 24 Jan 2024 05:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="B5gNBuZd"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 699FBE541;
	Wed, 24 Jan 2024 05:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706075778; cv=none; b=rdh3NJUmXH5/D4XGRf5hbd9jylsiVpNpeSSJyAArVrQYeNhU1f7FJbs7JdPeVT/L/dVW9uraBVmPfnh18+S3IGtyPkQ6fdeOGBrzE2p3iUgN8wWsydHx5oQ0NNvtc4oZOZxkbtBos7OaRky9BaWU4AIViY0xUoHM4eAqziznq0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706075778; c=relaxed/simple;
	bh=Mtv9huBRB3XLSzYzkY5yNwfFSuBXgm9+U9XhIB4rkkw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=g6ei1Qb+b1Au4ZaGE+U07m+Z56gJMNiTWuNO7WfpIWdKKd0iXLqKVdy8NYHgAEym7BkaQmWCLjKABsHb7kXMz2ttwM9gCdWS3/Xx+8XWOWOkw+ps+/Ptbs4S6xMdRQxK4oQQ+3Ca1/5iGR995ouM/QvxRDHLWNz6w021tIpTPjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=B5gNBuZd; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40O5u4M1010724;
	Tue, 23 Jan 2024 23:56:04 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706075764;
	bh=gUkEY0JOHv9rnjrrLI9cNW4bj/5kjOFDACovw2GyPXE=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=B5gNBuZdRqNUBbhY5NO6JIke2EgW3FSs+B8zmvPXjDDyR8nu0k+HHaBz+8a3nbnSR
	 z4AkkIfyLDYeRjQ0hd8/WgROgkuhiCNBqvDt3KmOqdX1hSm9/HnM1G+iKs3ytggTND
	 rwndFTjPiBH1WeL8sgjyVgansZ0+Ie4j3mS/XfG4=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40O5u4sx009517
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 23 Jan 2024 23:56:04 -0600
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 23
 Jan 2024 23:56:04 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 23 Jan 2024 23:56:04 -0600
Received: from [172.24.227.112] (jayesh-hp-probook-440-g8-notebook-pc.dhcp.ti.com [172.24.227.112])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40O5u02l019754;
	Tue, 23 Jan 2024 23:56:01 -0600
Message-ID: <0fcec921-0220-4251-afa4-44db5e80d2ef@ti.com>
Date: Wed, 24 Jan 2024 11:26:00 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: ti: k3-am62p-mcu/wakeup: Disable MCU and
 wakeup R5FSS nodes
Content-Language: en-US
To: Vaishnav Achath <vaishnav.a@ti.com>, <nm@ti.com>, <vigneshr@ti.com>,
        <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>
CC: <bb@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <u-kumar1@ti.com>
References: <20240121134017.374992-1-vaishnav.a@ti.com>
From: Jayesh Choudhary <j-choudhary@ti.com>
In-Reply-To: <20240121134017.374992-1-vaishnav.a@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hello Vaishnav,

On 21/01/24 19:10, Vaishnav Achath wrote:
> K3 Remoteproc R5 driver requires reserved memory carveouts and
> mailbox configuration to instantiate the cores successfully.
> Since this is a board level dependency, keep the R5 subsytem
> disabled at SoC dtsi, otherwise it results in probe errors like
> below during AM62P SK boot:
> 
> r5fss@79000000: reserved memory init failed, ret = -22
> r5fss@79000000: k3_r5_cluster_rproc_init failed, ret = -22
> r5fss@78000000: reserved memory init failed, ret = -22
> r5fss@78000000: k3_r5_cluster_rproc_init failed, ret = -22
> 
> Fixes: b5080c7c1f7e ("arm64: dts: ti: k3-am62p: Add nodes for more IPs")
> 
> Signed-off-by: Vaishnav Achath <vaishnav.a@ti.com>

Reviewed-by: Jayesh Choudhary <j-choudhary@ti.com>

> ---
>   arch/arm64/boot/dts/ti/k3-am62p-mcu.dtsi    | 2 ++
>   arch/arm64/boot/dts/ti/k3-am62p-wakeup.dtsi | 1 +
>   2 files changed, 3 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am62p-mcu.dtsi b/arch/arm64/boot/dts/ti/k3-am62p-mcu.dtsi
> index c4b0b91d70cf..14eb9ba836d3 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62p-mcu.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am62p-mcu.dtsi
> @@ -187,6 +187,8 @@ mcu_r5fss0: r5fss@79000000 {
>   		ranges = <0x79000000 0x00 0x79000000 0x8000>,
>   			 <0x79020000 0x00 0x79020000 0x8000>;
>   		power-domains = <&k3_pds 7 TI_SCI_PD_EXCLUSIVE>;
> +		status = "disabled";
> +
>   		mcu_r5fss0_core0: r5f@79000000 {
>   			compatible = "ti,am62-r5f";
>   			reg = <0x79000000 0x00008000>,
> diff --git a/arch/arm64/boot/dts/ti/k3-am62p-wakeup.dtsi b/arch/arm64/boot/dts/ti/k3-am62p-wakeup.dtsi
> index 19f42b39394e..10a7059b2d9b 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62p-wakeup.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am62p-wakeup.dtsi
> @@ -78,6 +78,7 @@ wkup_r5fss0: r5fss@78000000 {
>   		ranges = <0x78000000 0x00 0x78000000 0x8000>,
>   			 <0x78100000 0x00 0x78100000 0x8000>;
>   		power-domains = <&k3_pds 119 TI_SCI_PD_EXCLUSIVE>;
> +		status = "disabled";
>   
>   		wkup_r5fss0_core0: r5f@78000000 {
>   			compatible = "ti,am62-r5f";

Thanks.

