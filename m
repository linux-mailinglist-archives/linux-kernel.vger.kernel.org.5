Return-Path: <linux-kernel+bounces-154072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D82D18AD71D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 00:08:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77FB11F224DE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 22:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C7CA1E862;
	Mon, 22 Apr 2024 22:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="wLXErwNx"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 307D31CF9B;
	Mon, 22 Apr 2024 22:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713823730; cv=none; b=MeQ33gOWNQk5q8VNInnPo1M3jZ95VYT3IsRIz/iKl+vUDFwxRDDo6gMghGo1ttSie3JVu/GGMes/X0o1aKDL22WKLO0mfwup5q5yo0Y+XEmpzFWl/+K5fAd+oFiK5+P/GmOTZq0ywU7IWq6eAae8WJX134s6pr9gEKYGQ10EVt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713823730; c=relaxed/simple;
	bh=iwFh/LowvrnnfWd26b5194+KsamPL0FUUxnTCuZhpXY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=NwnhEIseYtToQRzUIP3//eErWAUnYJOGrvFr/rJ4M9ndJoYke0MOyTnDrrn2g8UFuRfIZL1AzEvTHTVPs9fmyI5/HdX5GBToQIjZde7oBc3ScTw8bL7Tj3cgTZk6hQGXY/UevzSl64l+ruxkJopSUP6t/p9n7zt8KUJVaoMEvPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=wLXErwNx; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43MM7sGd072533;
	Mon, 22 Apr 2024 17:07:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1713823674;
	bh=nzD5oItknIFpCQaryZQZGLImSq+8x8jfKCtKHdZtycY=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=wLXErwNx1PywVfvA5110AUPxd1QaPIj72xRpPzy240ZQR5RmMaqf7AJ3S7hr1GaAx
	 6j42Duc4GPW08kElh0OcB9JODvumCalK0/UqfH32fRK3hCZnLDNReTJqLLuTJVRU8U
	 EE0V4rsEIOJN0Vf2wV8GhRBAmoARPivznTbbmI38=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43MM7s0K070020
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 22 Apr 2024 17:07:54 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 22
 Apr 2024 17:07:53 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 22 Apr 2024 17:07:53 -0500
Received: from [128.247.81.105] (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43MM7rBb053110;
	Mon, 22 Apr 2024 17:07:53 -0500
Message-ID: <daa0e2a5-a408-42ee-8204-cba039d38edb@ti.com>
Date: Mon, 22 Apr 2024 17:07:53 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] arm64: dts: ti: k3-am62-main: Add eQEP nodes
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Catalin Marinas
	<catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        William Breathitt
 Gray <william.gray@linaro.org>
CC: David Lechner <david@lechnology.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
References: <20240418221417.1592787-1-jm@ti.com>
 <20240418221417.1592787-2-jm@ti.com>
 <f297210a-ad3b-40f5-b8ab-e51e11cefbe4@linaro.org>
Content-Language: en-US
From: Judith Mendez <jm@ti.com>
In-Reply-To: <f297210a-ad3b-40f5-b8ab-e51e11cefbe4@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi,

On 4/19/24 8:56 AM, Krzysztof Kozlowski wrote:
> On 19/04/2024 00:14, Judith Mendez wrote:
>> Add eQEP DT nodes 0-2 for AM625 SoC.
>>
>> Since external hardware was needed to test eQEP, the DT nodes
>> for eQEP were not included in the introductory commit. Now that
>> eQEP has been validated, add nodes to k3-am62-main.dtsi.
>>
>> Fixes: f1d17330a5be ("arm64: dts: ti: Introduce base support for AM62x SoC")
>> Signed-off-by: Judith Mendez <jm@ti.com>
>> ---
>>   arch/arm64/boot/dts/ti/k3-am62-main.dtsi | 30 ++++++++++++++++++++++++
>>   1 file changed, 30 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
>> index e9cffca073efc..0877899b90667 100644
>> --- a/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
>> +++ b/arch/arm64/boot/dts/ti/k3-am62-main.dtsi
>> @@ -844,6 +844,36 @@ ecap2: pwm@23120000 {
>>   		status = "disabled";
>>   	};
>>   
>> +	eqep0: counter@23200000 {
>> +		compatible = "ti,am3352-eqep";
> 
> That's k3-am62, not am3352. See writing-bindings (and numerous
> presentations telling you how to do it, e.g. from two previous EOSS/ELCE).
> 

Thanks, will fix and send v2.

~ Judith

> Best regards,
> Krzysztof
> 


