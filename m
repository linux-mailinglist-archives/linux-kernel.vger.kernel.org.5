Return-Path: <linux-kernel+bounces-141939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 187FF8A255A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 06:53:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8C7C286581
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 04:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A19B012E4E;
	Fri, 12 Apr 2024 04:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ZeV4ja9a"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4999110A1E;
	Fri, 12 Apr 2024 04:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712897581; cv=none; b=SXoKBYwE7KgYr5xvkqjwMS/G1GCetzQtKXA8KARexccYq7G2n3+M3amrfEbKQ/kpeYydwGdpr116bySh0V4XWy7KN/H9fC5pvEVBbOnc5IfuUypsnfXqfuOmOsPY4YdggZfLtK870nJMP2Rw3FT7wEo4z4Bpozt/WqjlG5w6L+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712897581; c=relaxed/simple;
	bh=LtUFDSjJGggm6EpDlBMSTP8SazPOe1Jkjby5KRb+AVs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=as2d2Hpkp9F/Nv3j6n8d3///hZ3wp3kg4K1o5NWlB8gC0W76dDwzQQ8vsGjUiGCvSwzobiv7XtnCaZlcEbTS3gmQ+SqJFYeUrnqzMqThIhM2uxTikht1HI2HSsPgNlaXW/9MTWyzexhe84nhfpPi7+FburaW4ZQ8F2ChW/pGSDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ZeV4ja9a; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43C4qpDb069253;
	Thu, 11 Apr 2024 23:52:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1712897571;
	bh=ctT5+vfnar7s8XJ9XsNYMLr9b4FMwIV6AD5au9w4L1c=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=ZeV4ja9aIOmbyrNkw2MF5AvsWXyl7n97EhIuQc2CyF8iwgM+FIOXvBq3FwUJLb8UW
	 NZz63SHSULHM2qHhlnd7LxZV/Nahp4QLdAseI5eB2cGoumC0qkY7BF6bAHM6p6Vi6d
	 86WbxW7AdvGDQmtK14q0HH5aZyr6Kov2+qHHDWFg=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43C4qpIh051276
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 11 Apr 2024 23:52:51 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 11
 Apr 2024 23:52:51 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 11 Apr 2024 23:52:51 -0500
Received: from [10.249.141.75] ([10.249.141.75])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43C4qlPr125131;
	Thu, 11 Apr 2024 23:52:47 -0500
Message-ID: <f59e7f17-b978-4ff3-86d4-a77191ca66ac@ti.com>
Date: Fri, 12 Apr 2024 10:22:46 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] arm64: dts: ti: k3-j784s4-evm: Remove HS400 mode
 support for eMMC
To: Judith Mendez <jm@ti.com>, Rob Herring <robh@kernel.org>,
        Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Bhavya Kapoor <b-kapoor@ti.com>,
        Dasnavis
 Sabiya <sabiya.d@ti.com>
References: <20240411225257.383889-1-jm@ti.com>
 <20240411225257.383889-8-jm@ti.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20240411225257.383889-8-jm@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Judith

On 4/12/2024 4:22 AM, Judith Mendez wrote:
> From: Udit Kumar <u-kumar1@ti.com>
>
> The eMMC fails to enumerate intermittently on HS400 mode. Also
> observing multiple CQE recovery warnings.
>
> Update the sdhci0 node to disable HS400.
>
> Cc: Vignesh Raghavendra <vigneshr@ti.com>
> Cc: Bhavya Kapoor <b-kapoor@ti.com>
> Cc: Siddharth Vadapalli <s-vadapalli@ti.com>
> Signed-off-by: Udit Kumar <u-kumar1@ti.com>
> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
> [Judith: Reword commit]
> Signed-off-by: Judith Mendez <jm@ti.com>
> ---
>   arch/arm64/boot/dts/ti/k3-j784s4-evm.dts | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
> index 81fd7afac8c57..04a241a91e6b8 100644
> --- a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
> +++ b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
> @@ -791,6 +791,7 @@ &main_sdhci0 {
>   	non-removable;
>   	ti,driver-strength-ohm = <50>;
>   	disable-wp;
> +	no-mmc-hs400;

This is just WA to get rid of CQE errors. I prefer to hold this patch 
under debug from hardware side is not complete.

Moreover, CQE errors are seen with 32GB variant not with 16GB, So we can 
not blame controller for this


>   };
>   
>   &main_sdhci1 {

