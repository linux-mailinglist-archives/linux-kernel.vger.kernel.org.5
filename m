Return-Path: <linux-kernel+bounces-49006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB300846496
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 00:50:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7B1C28C0B8
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 23:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A6DF47F68;
	Thu,  1 Feb 2024 23:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="mCmxhQkt"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E0147F52;
	Thu,  1 Feb 2024 23:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706831413; cv=none; b=csMdWnLCD1R3e7EtDmcy7S7J1PnCbrGJuV07FVljeMv2UxO5aDAhYgxRZSuwueHgjJF5dqDNZZ6jX9H/S9/mJhyDWhBiPWgv//ZHUM43C+gjc6Ug8fsk3dKDOXba6xP4kmRAAp64KqLF9gno03qacIVH7b2KvX8Zj3InK2Xjb+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706831413; c=relaxed/simple;
	bh=uxc7sN1qyLKA8RXd9+usKdpcepmKr7acUGjP2DjQCwk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=t6b7m3zvgkohn37q+7YQVDqc/3AEBqZYLbywlFfqPGZuKBx2XI/Ou0yFbee+aNIF4/hw2Os8xb0CXvRxNNZMoqbHv6aIHOTKTVFKRM1DfCMhUHbYbrglNg+d0lJB4/VVKodzd5B/rxJgUQZjZ4zeJIa0tz72/U03i6sFS7XMkd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=mCmxhQkt; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 411No1hc022509;
	Thu, 1 Feb 2024 17:50:01 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706831401;
	bh=pA3/cTZ7i/yJAMqa6Cw/IrsmxoD/vopbCB/efVaHv1A=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=mCmxhQktzfBdzUR++y9QJ2gjcZ79F6I+u+Pf0YitUGlLEHDivkEWT4ni+98VkTROB
	 CbhrQQ3E97J8mAEx5RwCn6zqB6/ZXfOy/02cj74UtdL9/zks8lbpw1N7CX+JSH05A9
	 wVnRJ67k/awJrKvCbZBV5/1UIsup2/FztgswVVvM=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 411No1h7022823
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 1 Feb 2024 17:50:01 -0600
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 1
 Feb 2024 17:50:01 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 1 Feb 2024 17:50:01 -0600
Received: from [10.249.42.149] ([10.249.42.149])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 411No0Ns130682;
	Thu, 1 Feb 2024 17:50:01 -0600
Message-ID: <6ba87a3f-e2f4-4caf-8d23-aa78caaba45a@ti.com>
Date: Thu, 1 Feb 2024 17:50:00 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/12] dt-bindings: arm: keystone: ti-sci: Add
 reboot-controller child node
Content-Language: en-US
To: Rob Herring <robh@kernel.org>
CC: Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Santosh
 Shilimkar <ssantosh@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Sebastian Reichel <sre@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>
References: <20240131221957.213717-1-afd@ti.com>
 <20240131221957.213717-3-afd@ti.com>
 <20240201230351.GA1900918-robh@kernel.org>
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20240201230351.GA1900918-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 2/1/24 5:03 PM, Rob Herring wrote:
> On Wed, Jan 31, 2024 at 04:19:47PM -0600, Andrew Davis wrote:
>> The TI-SCI firmware supports rebooting the system in addition to the
>> functions already listed here, document child node for the same.
>>
>> Signed-off-by: Andrew Davis <afd@ti.com>
>> ---
>>   .../devicetree/bindings/arm/keystone/ti,sci.yaml          | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/arm/keystone/ti,sci.yaml b/Documentation/devicetree/bindings/arm/keystone/ti,sci.yaml
>> index c24ad0968f3ef..e392175b33c74 100644
>> --- a/Documentation/devicetree/bindings/arm/keystone/ti,sci.yaml
>> +++ b/Documentation/devicetree/bindings/arm/keystone/ti,sci.yaml
>> @@ -83,6 +83,10 @@ properties:
>>       type: object
>>       $ref: /schemas/reset/ti,sci-reset.yaml#
>>   
>> +  reboot-controller:
>> +    type: object
>> +    $ref: /schemas/power/reset/ti,sci-reboot.yaml#
> 
> Don't need a ref just for a single property.
> 
> But then why do we need a node here at all? Can't you assume reboot
> support for TI-SCI firmware (i.e. based on the parent node). Then you
> don't need a DT update to add the feature.
> 

We could yes, but then again we could do the same for all the
child nodes of this system-controller parent node. Might even
have been better that way, for now I'm trying to be consistent
with what is already here (child node per service provided,
even though the services are always the same).

Andrew

> Rob

