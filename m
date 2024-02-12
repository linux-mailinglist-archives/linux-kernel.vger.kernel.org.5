Return-Path: <linux-kernel+bounces-61943-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 156208518BF
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 17:13:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5E952819FE
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 16:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91E5D3D0C8;
	Mon, 12 Feb 2024 16:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="rZFpmCro"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C8D63A1C4;
	Mon, 12 Feb 2024 16:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707754416; cv=none; b=cO0RPzXv5/cbdYVzLjm/bDYPjR/VavcowSne1xYA1sEVAuA0aCSJuDKp2n77Vgv4lOMjytvZ9c2c0sNNosmYcX95nWJzC9VDpOHktLT3wv+MXXe0jz2OUOWr89fcDBGRbhn/BgpbQBhktkCwGUkEOMDrGbspgS1G9otgSqUowUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707754416; c=relaxed/simple;
	bh=Us+gm13rBbIPyPGbnxPsm5KrPySAQQEKZ7En/wpqCGk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ATZKVxbpnm5bB+9hJcjpADVfO3/uKLM9zORFVntH8VR5mKKDn/qxMTA8dL354gMJ7d9RMa+k2FqCnB+twyV60Djgy8eG2VOLhxy7A+yNX0vzIKoDT5c05YA4MpKJdPUM91N6ox6Wb6tmSTNQBtA/dUV42/kCVgx0s4T8dHqkEFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=rZFpmCro; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41CGDGQl130327;
	Mon, 12 Feb 2024 10:13:16 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707754396;
	bh=TN1i4r7AT4NTHS/cqs4Lebur5DhSNWFg6+vsiT9DZoU=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=rZFpmCroVnlnwibRs0YS/V8/opPg+hp25gqg1uA8X+ZQHdncTK9t0CDHLEnCQppDu
	 nDd7OyQ4Sp6DIizWgAcFu3Ugeui+/qeRQrHPraYnj/YniuBoI/kOPUwE4L5GGwclQK
	 CHZmnd7pdSyiZ00RbnTe/+knicsQU03xtf3Ls/FA=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41CGDGRi023925
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 12 Feb 2024 10:13:16 -0600
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 12
 Feb 2024 10:13:15 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 12 Feb 2024 10:13:16 -0600
Received: from [10.249.42.149] ([10.249.42.149])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41CGDFF9065517;
	Mon, 12 Feb 2024 10:13:15 -0600
Message-ID: <961cb55f-1725-4e3e-9704-c0e7cb9e4e7c@ti.com>
Date: Mon, 12 Feb 2024 10:13:14 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 18/19] power: reset: syscon-poweroff: Move device data
 into a struct
To: Sebastian Reichel <sebastian.reichel@collabora.com>
CC: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Cristian
 Ciocaltea <cristian.ciocaltea@gmail.com>,
        Florian Fainelli
	<florian.fainelli@broadcom.com>,
        Ray Jui <rjui@broadcom.com>, Scott Branden
	<sbranden@broadcom.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad
 Dybcio <konrad.dybcio@linaro.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-actions@lists.infradead.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
References: <20240208170410.67975-1-afd@ti.com>
 <20240208170410.67975-19-afd@ti.com>
 <glaiaikudbtuahnwnqoduretcnmrpb7lg2gerlnntcltrjfcko@4vgjb4v66rad>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <glaiaikudbtuahnwnqoduretcnmrpb7lg2gerlnntcltrjfcko@4vgjb4v66rad>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 2/11/24 5:52 PM, Sebastian Reichel wrote:
> Hi Andrew,
> 
> On Thu, Feb 08, 2024 at 11:04:09AM -0600, Andrew Davis wrote:
>> Currently all these device data elements are top level global variables.
>> Move these into a struct. This will be used in the next patch when
>> the global variable usage is removed. Doing this in two steps makes
>> the patches easier to read.
>>
>> Signed-off-by: Andrew Davis <afd@ti.com>
>> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> ---
>>   drivers/power/reset/syscon-poweroff.c | 36 +++++++++++++++------------
>>   1 file changed, 20 insertions(+), 16 deletions(-)
>>
>> diff --git a/drivers/power/reset/syscon-poweroff.c b/drivers/power/reset/syscon-poweroff.c
>> index 1b2ce7734260c..4899a019256e8 100644
>> --- a/drivers/power/reset/syscon-poweroff.c
>> +++ b/drivers/power/reset/syscon-poweroff.c
>> @@ -15,15 +15,19 @@
>>   #include <linux/pm.h>
>>   #include <linux/regmap.h>
>>   
>> -static struct regmap *map;
>> -static u32 offset;
>> -static u32 value;
>> -static u32 mask;
>> +struct syscon_poweroff_data {
>> +	struct regmap *map;
>> +	u32 offset;
>> +	u32 value;
>> +	u32 mask;
>> +};
>> +
>> +static struct syscon_poweroff_data *data;
> 
> This patch is broken without the follow-up patch, since data is
> never allocated. You need to move the memory allocation from the
> next patch to this one.

Ah, yes, seems I meant to make this struct point to a definition
not just a declaration. But just moving the allocation to this
patch seems to make this easier too, will do that, v4 on the way.

Thanks,
Andrew

> 
> Greetings,
> 
> -- Sebastian

