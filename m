Return-Path: <linux-kernel+bounces-60101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D637C84FFD4
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 23:24:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87C151F2233F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 22:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0B2525625;
	Fri,  9 Feb 2024 22:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="wImCDcIL"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A1018053;
	Fri,  9 Feb 2024 22:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707517470; cv=none; b=ce/nw0hW9hwlq/jePcBf7if2Vwa0vWzQZ6ay+YmXEu7pQhRlipva2vTQs0T95h/hOVC1yqSGb6f/EoqJux1u8CZwhP+4J8t42WE38shl5h8U31U3/n/q/wnWkj50lX6U9Tgfa2OoaW0g2r3J9YhIV3IRVB15XGi8/4jMRFI9458=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707517470; c=relaxed/simple;
	bh=vH8d89MTM4yFZ0dvmIj9xDLCgv/y4kKbCoZ1sbaEaVw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=H07s41WeQyXimlff8EWuoDEhE86eR9uyOzKWRqATphI+ctsSKt6KQUlCDIs4wH1mzanysvde6KWU/M96WEXxFbg2GzfcD/yh9i/LZlLAPSZ7MrIzjiJOE4YzstngKTicI1c+FlrCkmUrTG3IDn4u+FpEpHa6CK1LxFJV+qF1NUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=wImCDcIL; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 419MNvpS035042;
	Fri, 9 Feb 2024 16:23:57 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707517437;
	bh=KGog1oxH5D6pp4K+yhkOe/G2uvi8Fh6g45AzpLcAprY=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=wImCDcILtGcNafTeuMXs88FAwGPm2BuGnStmlGyFaRu7S8GQpQvPQNcz/F964Glwr
	 vDDF5T4GaoUGg2hcLbVawrfXchvq7D5DflYu1DHUME3gWzkw9JUiY2HweaJp23E0dO
	 JyS6+L5eT2HTRDaODYNfTVPY4E5lc/LvXNeEoas4=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 419MNvhY076348
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 9 Feb 2024 16:23:57 -0600
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 9
 Feb 2024 16:23:56 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 9 Feb 2024 16:23:56 -0600
Received: from [128.247.81.105] (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 419MNuBs006051;
	Fri, 9 Feb 2024 16:23:56 -0600
Message-ID: <d795c353-a009-4270-8652-1dedb9008d41@ti.com>
Date: Fri, 9 Feb 2024 16:23:56 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 6/9] arm64: dts: ti: k3-am6*: Remove DLL properties for
 soft PHYs
To: Francesco Dolcini <francesco@dolcini.it>
CC: Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero
 Kristo <kristo@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20240207225526.3953230-1-jm@ti.com>
 <20240207225526.3953230-7-jm@ti.com> <20240209180515.GA29650@francesco-nb>
Content-Language: en-US
From: Judith Mendez <jm@ti.com>
In-Reply-To: <20240209180515.GA29650@francesco-nb>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Francesco,

On 2/9/24 12:05 PM, Francesco Dolcini wrote:
> On Wed, Feb 07, 2024 at 04:55:23PM -0600, Judith Mendez wrote:
>> Remove DLL properties which are not applicable for soft PHYs
>> since these PHYs do not have a DLL to enable.
>>
>> Signed-off-by: Judith Mendez <jm@ti.com>
>> ---
>>   arch/arm64/boot/dts/ti/k3-am62-main.dtsi       | 3 ---
>>   arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts | 3 ---
>>   arch/arm64/boot/dts/ti/k3-am62a-main.dtsi      | 1 -
>>   arch/arm64/boot/dts/ti/k3-am62a7-sk.dts        | 1 -
>>   arch/arm64/boot/dts/ti/k3-am62p5-sk.dts        | 1 -
>>   arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi | 2 --
>>   arch/arm64/boot/dts/ti/k3-am64-main.dtsi       | 1 -
>>   arch/arm64/boot/dts/ti/k3-am642-evm.dts        | 1 -
>>   arch/arm64/boot/dts/ti/k3-am642-sk.dts         | 1 -
>>   9 files changed, 14 deletions(-)
> 
> you missed k3-am62-verdin-dev.dtsi and more ?

ok, will include in v2.

> 
> $ ack --dts -g k3-am6[24] | ack -x -l ti,driver-strength-ohm
> arch/arm64/boot/dts/ti/k3-am62-verdin-dahlia.dtsi
> arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi
> arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi
> arch/arm64/boot/dts/ti/k3-am642-tqma64xxl-mbax4xxl.dts
> arch/arm64/boot/dts/ti/k3-am625-phyboard-lyra-rdk.dts
> arch/arm64/boot/dts/ti/k3-am62-verdin-wifi.dtsi
> arch/arm64/boot/dts/ti/k3-am642-tqma64xxl.dtsi
> arch/arm64/boot/dts/ti/k3-am62p5-sk.dts
> arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi
> arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts
> arch/arm64/boot/dts/ti/k3-am642-evm.dts
> arch/arm64/boot/dts/ti/k3-am642-sk.dts
> arch/arm64/boot/dts/ti/k3-am642-phyboard-electra-rdk.dts
> arch/arm64/boot/dts/ti/k3-am62-phycore-som.dtsi
> arch/arm64/boot/dts/ti/k3-am62a7-sk.dts
> arch/arm64/boot/dts/ti/k3-am62-verdin-dev.dtsi
> 
> Francesco
> 

~ Judith

