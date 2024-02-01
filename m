Return-Path: <linux-kernel+bounces-47982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B30418455A5
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 11:40:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4B3B1C23242
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 10:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4156D15A490;
	Thu,  1 Feb 2024 10:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="NI74xNAI"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C27112747F;
	Thu,  1 Feb 2024 10:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706784042; cv=none; b=eChphJFFIn/ysVT/TzdZ4ow6SAUolxvj4z82rf1TB4zkZ+eApJsozbsXsA/3s9lj+g+BLs48QAO6PwY/mVI+D3Vh9ANUCTuSQrxjlFYdUIjVNqbB5f2rLi+vYCexIkqMEHX13TsuWKuGVGVvbUlbwOfTgraQe7hM+zJ4WjTc9CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706784042; c=relaxed/simple;
	bh=IAxQ247gpt/xDUWQXHExdT3CIugrLkHsYYszRWh8NGA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=IAxtFjuICeJ0aFR7VBhYs63U8nOZtjEubM3up+A+LTJhc1wFhS3DO6U5SC4YkgTTD6WcSWIbRqDDMe7+nNlHDlqw9uC5ddPvyeK2wq1WSrN72pkPlVWHeR5U4Am1SCKwwHpJ+hN7rpQHO+Nzeg5bW31KMRovtAMyzGM5lb/PKk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=NI74xNAI; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 411AeTGJ076393;
	Thu, 1 Feb 2024 04:40:29 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706784029;
	bh=9OeQC3NYKDo60H/HChds5+O9TwH7tRqkh+NBR9Fhh1A=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=NI74xNAIvYz//AoFYZqtYee4pHtB79pTeGnorL3u9ZH0YcNLRUC7fi+78V+y8qVgO
	 PSC9EnEkRJw0AJILQPDZUhH9ZwWb0FghgCN9csOGVefOEEs9XRc28zuEarK1INKkEX
	 AXQIWuM7g9gWRYxgtoDnNwM3nBhkreqC1CBhnV38=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 411AeTNu102304
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 1 Feb 2024 04:40:29 -0600
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 1
 Feb 2024 04:40:28 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 1 Feb 2024 04:40:28 -0600
Received: from [172.24.227.177] (jayesh-hp-probook-440-g8-notebook-pc.dhcp.ti.com [172.24.227.177])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 411AeOEQ022888;
	Thu, 1 Feb 2024 04:40:25 -0600
Message-ID: <30ac8486-325d-44cb-9855-84a0b41f6857@ti.com>
Date: Thu, 1 Feb 2024 16:10:23 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: ti: k3-am69-sk: remove assigned-clock-parents
 for unused VP
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, <nm@ti.com>,
        <vigneshr@ti.com>
CC: <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <a-bhatia1@ti.com>, <rogerq@kernel.org>, <sabiya.d@ti.com>,
        <u-kumar1@ti.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
References: <20231221113042.48492-1-j-choudhary@ti.com>
 <bf271671-861d-43d4-a24f-de49256ef9d0@ideasonboard.com>
Content-Language: en-US
From: Jayesh Choudhary <j-choudhary@ti.com>
In-Reply-To: <bf271671-861d-43d4-a24f-de49256ef9d0@ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hello Tomi,

On 03/01/24 18:35, Tomi Valkeinen wrote:
> Hi,
> 
> On 21/12/2023 13:30, Jayesh Choudhary wrote:
>> VP2 and VP3 are unused video ports and VP3 share the same parent
>> clock as VP1 causing issue with pixel clock setting for HDMI (VP1).
>> So remove the parent clocks for unused VPs.
>>
>> Fixes: 6f8605fd7d11 ("arm64: dts: ti: k3-am69-sk: Add DP and HDMI 
>> support")
>> Reported-by: Nishanth Menon <nm@ti.com>
>> Closes: 
>> https://storage.kernelci.org/mainline/master/v6.7-rc6/arm64/defconfig/gcc-10/lab-ti/baseline-nfs-am69_sk-fs.txt
>> Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
>> ---
>>
>> Local testing log for HDMI on AM69-SK:
>> <https://gist.github.com/Jayesh2000/517395cd85eb28d65b8ee4568cefb809>
>>
>>   arch/arm64/boot/dts/ti/k3-am69-sk.dts | 8 ++------
>>   1 file changed, 2 insertions(+), 6 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/ti/k3-am69-sk.dts 
>> b/arch/arm64/boot/dts/ti/k3-am69-sk.dts
>> index 8da591579868..370980eb59b0 100644
>> --- a/arch/arm64/boot/dts/ti/k3-am69-sk.dts
>> +++ b/arch/arm64/boot/dts/ti/k3-am69-sk.dts
>> @@ -918,13 +918,9 @@ &dss {
>>       pinctrl-names = "default";
>>       pinctrl-0 = <&dss_vout0_pins_default>;
>>       assigned-clocks = <&k3_clks 218 2>,
>> -              <&k3_clks 218 5>,
>> -              <&k3_clks 218 14>,
>> -              <&k3_clks 218 18>;
>> +              <&k3_clks 218 5>;
>>       assigned-clock-parents = <&k3_clks 218 3>,
>> -                 <&k3_clks 218 7>,
>> -                 <&k3_clks 218 16>,
>> -                 <&k3_clks 218 22>;
>> +                 <&k3_clks 218 7>;
>>   };
>>   &serdes_wiz4 {
> 
> The SK has two outputs, using VP0 and VP1, so the above kind of makes 
> sense. Then again, setting up 4 clocks here really shouldn't break the 
> SK, should it? The AM69 has 4 available VPs. How does one configure the 
> clocks for a board that uses 4 VPs, or possibly a different selection of 
> VPs?

> 
> I think the patch desc should explain why this doesn't work. Afaik, the 
> dts is not wrong as such, but there's an underlying issue that breaks 
> the clocking if all four clocks are set up here.
> 

I discussed this with firmware team, there is an issue with sibling
child clocks. If parent clock is shared, DM cannot set its rate.
The determine_rate and set_rate query are behaving unexpectedly in
this case. determine_rate is returning 0 and set_rate is setting it
to 1.8G even when VP can support max 600M.

Jayesh

> So, with the desc updated, as this fixes an issue and is not wrong:
> 
> Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> 
> But I also feel this is dodging a firmware (?) issue.
> 
>   Tomi
> 

