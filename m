Return-Path: <linux-kernel+bounces-159930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A77018B3668
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 13:13:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D8EB1F22267
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 11:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFFC0144D3C;
	Fri, 26 Apr 2024 11:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="y74g0B5s"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 484E51448DA;
	Fri, 26 Apr 2024 11:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714130014; cv=none; b=KkZKs4seFDNzzu3aKnAN4uHyijNtv4WXaodEPnhGucRyPeYQAk5QUZHbeh0RlE6fsS1Dk16z3FgpdQT6FKgUXYvXqJe9h7+nL7OINHhZ3u9xK6JPyJ+w8edN/yCuPEW7jsJY1btpHZDGGtNRBuFmBXvLLK0El6wQAPgx6+vmDXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714130014; c=relaxed/simple;
	bh=vC7iyWCj3aDXtIR8X0fjWS86HcWXHjbkerC3To4iCDA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=axz9iVVTFFa/0jTPc90y2Tzqi1YV24QLWakk0HmFdjvwYhkOeUOWFeIwnxzRWi+e7Y1hcPD7i31CKfnpX1kV4zHXtMr6AbJ2euFouKGh9qg9OYa8eoWn7z+wEUVCzxXDHBmMqYNmzEH5w2WjRbjJd+HHUop4SG8sjYR82xTtmO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=y74g0B5s; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43QBDJuQ107051;
	Fri, 26 Apr 2024 06:13:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1714129999;
	bh=nwa0Yc3YV0W//ZWELeJT4clRoNt+B690HLCRopEIv7A=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=y74g0B5sG/FZu+EiGhFoEBCHFw8dF+0voprRiyH3bZp+Ne/SB7janQJPafEp16De1
	 SIVMvk1acXOwO/p1O8diGfQUw5Ow4DglVPmLiFntz52HBQcoajTGeimPjKMvz3NB5Q
	 HSyzGkKRZIUz4+CfGQ0G7y4qVAWJfxAV7KR4lqUE=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43QBDJAS013630
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 26 Apr 2024 06:13:19 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 26
 Apr 2024 06:13:18 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 26 Apr 2024 06:13:18 -0500
Received: from [10.249.141.75] ([10.249.141.75])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43QBCuQR009574;
	Fri, 26 Apr 2024 06:13:00 -0500
Message-ID: <791db6d2-44ae-45c3-b3a2-86bd57531722@ti.com>
Date: Fri, 26 Apr 2024 16:42:52 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/6] arm64: dts: ti: k3-j7*-main: Add bootph-pre-ram to
 main_esm
To: Neha Malcom Francis <n-francis@ti.com>, <robh@kernel.org>,
        <conor+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <vigneshr@ti.com>, <nm@ti.com>
CC: <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kristo@kernel.org>, <u-kumar1@ti.com>
References: <20240425211233.2006233-1-n-francis@ti.com>
 <20240425211233.2006233-7-n-francis@ti.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20240425211233.2006233-7-n-francis@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Thanks Neha

On 4/26/2024 2:42 AM, Neha Malcom Francis wrote:
> Add bootph-pre-ram to main_esm as R5 bootloader configures MAIN domain
> watchdog interrupts to generate the ESM pin events.
>
> Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
> ---
>   arch/arm64/boot/dts/ti/k3-j7200-main.dtsi | 1 +
>   arch/arm64/boot/dts/ti/k3-j721e-main.dtsi | 1 +
>   2 files changed, 2 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
> index b24a6333563a..30ec36ce4ce7 100644
> --- a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
> @@ -1565,5 +1565,6 @@ main_esm: esm@700000 {
>   		compatible = "ti,j721e-esm";
>   		reg = <0x0 0x700000 0x0 0x1000>;
>   		ti,esm-pins = <656>, <657>;
> +		bootph-pre-ram;

Reviewed-by: Udit Kumar <u-kumar1@ti.com>

>   	};
>   };
> diff --git a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
> index 0dd5005b34aa..a5dc1e1bc1a9 100644
> --- a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
> @@ -2957,5 +2957,6 @@ main_esm: esm@700000 {
>   		compatible = "ti,j721e-esm";
>   		reg = <0x0 0x700000 0x0 0x1000>;
>   		ti,esm-pins = <344>, <345>;
> +		bootph-pre-ram;
>   	};
>   };

