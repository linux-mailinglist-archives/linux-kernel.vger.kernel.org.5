Return-Path: <linux-kernel+bounces-68075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7ED98575AD
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 06:36:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08FD81C223B1
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 05:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45885134A0;
	Fri, 16 Feb 2024 05:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="SsTNCG6z"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFBA128EC;
	Fri, 16 Feb 2024 05:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708061806; cv=none; b=N3HRdqQdAtEFYvJUtYGizcneShQq7fqO0fdwzTuuit8nuwvgB5YQM/M7EJkWAPN0BXTT4rsOB0qfzEugGOk4teizvequm4gDmsDChA2Xmdb5wKAUZ00AC1QT1dVoZ+EYan3hzTS4elkXktS+wgeVrvivb2UYG3G7WcrhwOG2/aA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708061806; c=relaxed/simple;
	bh=mRflPSxs4pLh6jh9HLk3XOJ5488O52HahU07Ty24MOs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=RszB09BS4xDTFpEJwvr6bJMQ1kGga7FaPh+h/WG+BXJlMPuwJi4s+EtSmzv+uNM+K5Bv9fsXz4uxnLjuL9NoJtNaSsx43KzcLFG5T3lJO7zTtjwOoreVWXWzZlWVNS8erwv+4SFymCX4HzBTQxWFk7MwNkWypgH5l1FQpycP+mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=SsTNCG6z; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41G5aCXF093423;
	Thu, 15 Feb 2024 23:36:12 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1708061772;
	bh=w4YhGTK+t27RaSNPXnZt3dIUmjnBjmFi3fc525Pd/Ok=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=SsTNCG6zI1H0UbO7K0MjzmdianYqMiZw566yUj8DUZo+NdirokPOgJt3Xv9BARR7z
	 Ux+q0Ebp2Lii4BY01MzGfZCmHgpZjdoB0pDFw7SeVD3tCvKojz/pWzBHHSDac74/V+
	 4SMXGVIwpZBlfjX/vJeqapP5voOfv/dk/oApZh9o=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41G5aCkG063356
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 15 Feb 2024 23:36:12 -0600
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 15
 Feb 2024 23:36:12 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 15 Feb 2024 23:36:12 -0600
Received: from [172.24.227.94] (uda0132425.dhcp.ti.com [172.24.227.94])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41G5a6C9032963;
	Thu, 15 Feb 2024 23:36:07 -0600
Message-ID: <d2b6dcda-cd22-4163-bdf5-2bc4b8e276ea@ti.com>
Date: Fri, 16 Feb 2024 11:06:05 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] arm64: dts: ti: Add common1 register space for
 AM62x, AM62A & AM65x SoCs
Content-Language: en-US
To: Devarsh Thakkar <devarsht@ti.com>, <jyri.sarha@iki.fi>,
        <tomi.valkeinen@ideasonboard.com>, <airlied@gmail.com>,
        <daniel@ffwll.ch>, <maarten.lankhorst@linux.intel.com>,
        <mripard@kernel.org>, <tzimmermann@suse.de>, <robh@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <nm@ti.com>, <kristo@kernel.org>
CC: <praneeth@ti.com>, <a-bhatia1@ti.com>, <j-luthra@ti.com>
References: <20240215115516.3157909-1-devarsht@ti.com>
 <20240215115516.3157909-3-devarsht@ti.com>
From: Vignesh Raghavendra <vigneshr@ti.com>
In-Reply-To: <20240215115516.3157909-3-devarsht@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180



On 15/02/24 17:25, Devarsh Thakkar wrote:
> This adds common1 register space for AM62x, AM62A and AM65x SoC's which are
> using TI's Keystone display hardware and supporting it as described in
> Documentation/devicetree/bindings/display/ti/ti,am65x-dss.yaml
> 
> Fixes: 3618811657b3 ("arm64: dts: ti: k3-am62a-main: Add node for Display SubSystem (DSS)")
> Fixes: 8ccc1073c7bb ("arm64: dts: ti: k3-am62-main: Add node for DSS")
> Fixes: fc539b90eda2 ("arm64: dts: ti: am654: Add DSS node")

This doesn't work. Patch wont apply cleanly to kernels before before
AM62A was introduced.

Please split this into 3 patches, one per SoC with appropriate Fixes: tag.

> Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
> Reviewed-by: Aradhya Bhatia <a-bhatia1@ti.com>
> ---
> V2: Add common1 region for AM62A SoC too
> V3: Add Fixes tag
> V4: Add Reviewed-by
> ---
>  arch/arm64/boot/dts/ti/k3-am62-main.dtsi  | 5 +++--
>  arch/arm64/boot/dts/ti/k3-am62a-main.dtsi | 5 +++--
>  arch/arm64/boot/dts/ti/k3-am65-main.dtsi  | 5 +++--
>  3 files changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
> index fe0cc4a9a501..8cee4d94cdd3 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
> @@ -779,9 +779,10 @@ dss: dss@30200000 {
>  		      <0x00 0x30207000 0x00 0x1000>, /* ovr1 */
>  		      <0x00 0x30208000 0x00 0x1000>, /* ovr2 */
>  		      <0x00 0x3020a000 0x00 0x1000>, /* vp1: Used for OLDI */
> -		      <0x00 0x3020b000 0x00 0x1000>; /* vp2: Used as DPI Out */
> +		      <0x00 0x3020b000 0x00 0x1000>, /* vp2: Used as DPI Out */
> +		      <0x00 0x30201000 0x00 0x1000>; /* common1 */
>  		reg-names = "common", "vidl1", "vid",
> -			    "ovr1", "ovr2", "vp1", "vp2";
> +			    "ovr1", "ovr2", "vp1", "vp2", "common1";
>  		power-domains = <&k3_pds 186 TI_SCI_PD_EXCLUSIVE>;
>  		clocks = <&k3_clks 186 6>,
>  			 <&dss_vp1_clk>,
> diff --git a/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
> index 972971159a62..f475daea548e 100644
> --- a/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
> @@ -994,9 +994,10 @@ dss: dss@30200000 {
>  		      <0x00 0x30207000 0x00 0x1000>, /* ovr1 */
>  		      <0x00 0x30208000 0x00 0x1000>, /* ovr2 */
>  		      <0x00 0x3020a000 0x00 0x1000>, /* vp1: Tied OFF in the SoC */
> -		      <0x00 0x3020b000 0x00 0x1000>; /* vp2: Used as DPI Out */
> +		      <0x00 0x3020b000 0x00 0x1000>, /* vp2: Used as DPI Out */
> +		      <0x00 0x30201000 0x00 0x1000>; /* common1 */
>  		reg-names = "common", "vidl1", "vid",
> -			    "ovr1", "ovr2", "vp1", "vp2";
> +			    "ovr1", "ovr2", "vp1", "vp2", "common1";
>  		power-domains = <&k3_pds 186 TI_SCI_PD_EXCLUSIVE>;
>  		clocks = <&k3_clks 186 6>,
>  			 <&k3_clks 186 0>,
> diff --git a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
> index 07010d31350e..ff857117d719 100644
> --- a/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am65-main.dtsi
> @@ -991,9 +991,10 @@ dss: dss@4a00000 {
>  		      <0x0 0x04a07000 0x0 0x1000>, /* ovr1 */
>  		      <0x0 0x04a08000 0x0 0x1000>, /* ovr2 */
>  		      <0x0 0x04a0a000 0x0 0x1000>, /* vp1 */
> -		      <0x0 0x04a0b000 0x0 0x1000>; /* vp2 */
> +		      <0x0 0x04a0b000 0x0 0x1000>, /* vp2 */
> +		      <0x0 0x04a01000 0x0 0x1000>; /* common1 */
>  		reg-names = "common", "vidl1", "vid",
> -			"ovr1", "ovr2", "vp1", "vp2";
> +			"ovr1", "ovr2", "vp1", "vp2", "common1";
>  
>  		ti,am65x-oldi-io-ctrl = <&dss_oldi_io_ctrl>;
>  

-- 
Regards
Vignesh

