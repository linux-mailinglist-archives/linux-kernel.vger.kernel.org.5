Return-Path: <linux-kernel+bounces-141941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19CF38A2560
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 06:54:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADF381F23A0A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 04:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F6031BC4E;
	Fri, 12 Apr 2024 04:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="iUMAMzS3"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2A71BC2A;
	Fri, 12 Apr 2024 04:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712897619; cv=none; b=buukP1bjGq3QW49ZUj0uQ0MHsNzxs3lL4HhYerGNTE3mi/zW34Qlzr7QFqXNivVsTlbBTo7nLl6LGQLa+OXpC9K45pLMZ0Xc1G+lJfStpmlzhozIIcnB99vUjpCgQlO0Xf6pfExPcgPKE1ZrymeauOeeqajp2huGouSPYMrf76s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712897619; c=relaxed/simple;
	bh=E+KRkPVI5Unn86xXAB9fTmeU6TRCueeu16ejB2Sy3Qs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ckFd7cula6/1fSk1xECRd7brkknqrEXnA6pzGncZTL2eGLlea6BM0YbyzGp1Z/fUJJzGiF9Ci88bWKDF8ZOc9gCU4lBgYc7mQu0mUnJ6HGzqOsY8xeOuUpTKoH17je6bZXIroN2VfrRzZGnjA5pyzTfZyiWk8KiF16So7c2T9+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=iUMAMzS3; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43C4rWlU069366;
	Thu, 11 Apr 2024 23:53:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1712897612;
	bh=8n04c7LUmKPp9K4cTwnl5B/I0cP31VnVpEMulyjHZ9k=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=iUMAMzS3RMk/fulOIZhG5a4KXwrn8xO7zO50mcZ4QSRjamTQUfQkwtzVrCyJ0EL2Y
	 UzeEuLRWIBLDv9LmSMSNXMoJoJgzHy3GC2evUI6fl1vcXfkEa0mWS2AMv7lJVT6zpf
	 dZsWUlcxyEWp1htwECDLsfrbDb0gdYP/llKkEUhk=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43C4rWBo013595
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 11 Apr 2024 23:53:32 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 11
 Apr 2024 23:53:31 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 11 Apr 2024 23:53:31 -0500
Received: from [10.249.141.75] ([10.249.141.75])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43C4rRrB004011;
	Thu, 11 Apr 2024 23:53:28 -0500
Message-ID: <87a289ce-6260-4249-9829-0de189663532@ti.com>
Date: Fri, 12 Apr 2024 10:23:27 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/7] arm64: dts: ti: k3-am69-sk: Remove HS400 mode support
 for eMMC
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
 <20240411225257.383889-7-jm@ti.com>
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <20240411225257.383889-7-jm@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Judith

On 4/12/2024 4:22 AM, Judith Mendez wrote:
> From: Dasnavis Sabiya <sabiya.d@ti.com>
>
> The eMMC fails to enumerate intermittently on HS400 mode. Also
> observing multiple CQE recovery warnings.
> Update the sdhci0 node to disable HS400 and set HS200 mode for
> eMMC node.
>
> Signed-off-by: Dasnavis Sabiya <sabiya.d@ti.com>
> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>
> ---
>   arch/arm64/boot/dts/ti/k3-am69-sk.dts | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm64/boot/dts/ti/k3-am69-sk.dts b/arch/arm64/boot/dts/ti/k3-am69-sk.dts
> index 50de2a448a3a6..a677bb9200a35 100644
> --- a/arch/arm64/boot/dts/ti/k3-am69-sk.dts
> +++ b/arch/arm64/boot/dts/ti/k3-am69-sk.dts
> @@ -906,6 +906,7 @@ &main_sdhci0 {
>   	non-removable;
>   	ti,driver-strength-ohm = <50>;
>   	disable-wp;
> +	no-mmc-hs400;


This is just WA to get rid of CQE errors. I prefer to hold this patch 
under debug from hardware side is not complete.

>   };
>   
>   &main_sdhci1 {

