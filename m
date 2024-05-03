Return-Path: <linux-kernel+bounces-167324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1BB98BA7E4
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 09:36:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3B921C2184E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 07:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B614146A66;
	Fri,  3 May 2024 07:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="G5N8yGqI"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 264351474B8;
	Fri,  3 May 2024 07:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714721784; cv=none; b=RuEZzQinEDpxlSjxQGFuGYtndbAuV71Y3E2lu8fzeSVKKHGdsj2erq/FJcqhPcQQh2aXsXBgtoZ2AkZSVdPEA+gWAdUwH/an3clABLZcc1w/KLtuOXgT3efl5W8zw+Zk9owxv1xADRPffJXd3aMZ7DYIsBVwbVFnuc99EgB3U9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714721784; c=relaxed/simple;
	bh=uDu1QNx07sEE5UtL8idu7li2seT8o+SYA+gutMazzcY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Xvb7XpbkaNWgdj/pUtnqeTlhSxmOVjZV+w3ukOO9KrEH0If6AJi1ILqycclF7ahvLaFuDYGhFKncFgWQLJFNi9Psvjz7CjeWk1MO9eh/7qRi46o8GN8cjUeE38sfTKePFDr3MLFvMtxPM01O+j7T8aTj8lfkkdMTFrTK2GvwFlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=G5N8yGqI; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4437aC7a075675;
	Fri, 3 May 2024 02:36:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1714721772;
	bh=NAuouXKQJwWg0JMmYfKZjZJi4ycsvu1MT8jf7d2FKng=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=G5N8yGqIbGpKgZCRcM96cQBETRr9fZ88A7UPpfEvvdp3zdDLfko5iqSrONfC53KCe
	 V2TlrgMlJf8H7oUwMDuD91jTKwCRd5HHq6wzlgQS8Lq1s1DOTivy5gbQUPO9Zmpz21
	 U9lvLOXSCWpp3NcXv5qdIq9pjPd+1Sov4Jgy7iYc=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4437aCaR100824
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 3 May 2024 02:36:12 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 3
 May 2024 02:36:12 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 3 May 2024 02:36:12 -0500
Received: from [172.24.227.88] (uda0500640.dhcp.ti.com [172.24.227.88])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4437a8oZ008242;
	Fri, 3 May 2024 02:36:09 -0500
Message-ID: <d67a0ed2-d0a2-7c10-d247-74953590af5c@ti.com>
Date: Fri, 3 May 2024 13:06:07 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 2/2] arm64: dts: ti: k3-j784s4-evm: Enable USB3 support
Content-Language: en-US
To: Roger Quadros <rogerq@kernel.org>, <nm@ti.com>, <vigneshr@ti.com>
CC: <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <srk@ti.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Ravi
 Gunasekaran <r-gunasekaran@ti.com>
References: <20240502053615.29514-1-r-gunasekaran@ti.com>
 <20240502053615.29514-3-r-gunasekaran@ti.com>
 <865b6c46-b09c-4251-867c-992f008001ae@kernel.org>
From: Ravi Gunasekaran <r-gunasekaran@ti.com>
In-Reply-To: <865b6c46-b09c-4251-867c-992f008001ae@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Roger, Rob

On 5/3/24 12:18 PM, Roger Quadros wrote:
> 
> 
> On 02/05/2024 08:36, Ravi Gunasekaran wrote:
>> From: Matt Ranostay <mranostay@ti.com>
>>
>> The board uses SERDES0 Lane 3 for USB3 IP. So update the
>> SerDes lane info for USB. Add the pin mux data and
>> enable USB3 support.
>>
>> Signed-off-by: Matt Ranostay <mranostay@ti.com>
>> Signed-off-by: Ravi Gunasekaran <r-gunasekaran@ti.com>
>> ---
>>  arch/arm64/boot/dts/ti/k3-j784s4-evm.dts | 41 ++++++++++++++++++++++++
>>  1 file changed, 41 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
>> index d511b25d62e3..bee73dab803d 100644
>> --- a/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
>> +++ b/arch/arm64/boot/dts/ti/k3-j784s4-evm.dts
>> @@ -336,6 +336,13 @@
>>  			J784S4_IOPAD(0x010, PIN_INPUT_PULLUP, 8) /* (AH33) MCAN13_RX.I2C4_SDA */
>>  		>;
>>  	};
>> +
>> +	main_usbss0_pins_default: main-usbss0-pins-default {
> 
> Should be main-usbss0-default-pins
> 
> This should fix the checkpatch warning.
> 

I will fix and send a v2

[...]

-- 
Regards,
Ravi

