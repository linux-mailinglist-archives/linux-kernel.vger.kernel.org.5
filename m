Return-Path: <linux-kernel+bounces-68783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75CD885803B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 16:09:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9959D1C22528
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 15:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 559F612FB06;
	Fri, 16 Feb 2024 15:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Czp8tKkC"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF9E01292F4;
	Fri, 16 Feb 2024 15:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708096135; cv=none; b=rypQ04JyHtgLItTGyOrpOzRdTVmhXk2X3Jfe62FjlCpPBJ3W45Tg8WNeqxCtqxLYuYrjOQF/ol24VSnGFfDN/vCbhZssMJiXWRuOfMa4Btl+F4lz2/xGqaryogGs4bfcWBKiovEHJsV5tGiQAAaRy+bcXjNV5FPggpfqafzN/RU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708096135; c=relaxed/simple;
	bh=b2g5R64dRf9ayZbi4lbGay7eXPb9wiPuGz4M+ef2a1I=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=NmVTDrAfdq1fP7qqwOU0JcviAIjuO87DfI/Y0nAmNZCs5Yx7bE9xvLOlCG1rRtpLzT6Oy7PIbmZiiLQs4F+6XLKXDVS26cZm8mawI+DgNJIPY3muRBfDxWPB+Ui++keoCgeZNpL2DgmFt8eR+6UtGd7lyEym3Wu30Hl/4VCT8ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Czp8tKkC; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41GF8W0L114580;
	Fri, 16 Feb 2024 09:08:32 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1708096112;
	bh=SVSdtMRcvm8l3QkqkcyDPXSfszJ5GRE8MQ9FEavnTSc=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=Czp8tKkC+6AQ4v1uTYFweTkLSF1/x2Ix/br+dDckKUx5nSDKZD4UtU2yHcJEljWbt
	 P+ApyGPQedbFkFL6LwqGBRP+TpA3W3oXeQVW7Ca9ZrPj3MwNiw4oaAv2EV3OixdZlU
	 JUwfUdBKxPoZvaP3kP2lKzRMzmKSuhvJyJiqM3io=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41GF8W0p023273
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 16 Feb 2024 09:08:32 -0600
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 16
 Feb 2024 09:08:32 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 16 Feb 2024 09:08:32 -0600
Received: from [10.249.42.149] ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41GF8VV9100285;
	Fri, 16 Feb 2024 09:08:31 -0600
Message-ID: <d3ca964c-7fdd-4ed6-8f9c-348d21e5666c@ti.com>
Date: Fri, 16 Feb 2024 09:08:31 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] arm64: dts: ti: k3-j784s4-main: Fix mux-reg-masks in
 serdes_ln_ctrl
To: Siddharth Vadapalli <s-vadapalli@ti.com>, Peter Rosin <peda@axentia.se>
CC: <nm@ti.com>, <vigneshr@ti.com>, <kristo@kernel.org>, <robh@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <gregkh@linuxfoundation.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <c-vankar@ti.com>, <srk@ti.com>
References: <20240213080348.248916-1-s-vadapalli@ti.com>
 <1be60db1-f292-1074-5898-801380e1fb22@axentia.se>
 <af73545a-1746-4e14-a3f2-772d72e6ff97@ti.com>
 <4abe2bde-1171-4b77-b7bc-49491792a721@ti.com>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <4abe2bde-1171-4b77-b7bc-49491792a721@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 2/15/24 10:56 PM, Siddharth Vadapalli wrote:
> On 24/02/13 11:08AM, Andrew Davis wrote:
>> On 2/13/24 3:19 AM, Peter Rosin wrote:
>>> Hi!
>>>
>>> 2024-02-13 at 09:03, Siddharth Vadapalli wrote:
>>>> From: Chintan Vankar <c-vankar@ti.com>
>>>>
>>>> Change offset in mux-reg-masks property for serdes_ln_ctrl node
>>>> since reg-mux property is used in compatible.
>>>>
>>>> Fixes: 2765149273f4 ("mux: mmio: use reg property when parent device is not a syscon")
>>>> Signed-off-by: Chintan Vankar <c-vankar@ti.com>
>>>> Acked-by: Andrew Davis <afd@ti.com>
>>>> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
>>>> ---
> ...
> 
>>>> +			mux-reg-masks = <0x0 0x3>, <0x4 0x3>, /* SERDES0 lane0/1 select */
>>>> +					<0x8 0x3>, <0xc 0x3>, /* SERDES0 lane2/3 select */
>>>> +					<0x10 0x3>, <0x14 0x3>, /* SERDES1 lane0/1 select */
>>>> +					<0x18 0x3>, <0x1c 0x3>, /* SERDES1 lane2/3 select */
>>>> +					<0x20 0x3>, <0x24 0x3>, /* SERDES2 lane0/1 select */
>>>> +					<0x28 0x3>, <0x2c 0x3>; /* SERDES2 lane2/3 select */
>>>>    			idle-states = <J784S4_SERDES0_LANE0_PCIE1_LANE0>,
>>>>    				      <J784S4_SERDES0_LANE1_PCIE1_LANE1>,
>>>>    				      <J784S4_SERDES0_LANE2_IP3_UNUSED>,
>>>
>>> Ouch. I suspect there is a similar problem in
>>> arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi:
>>>
>>>
>>> 	fss: bus@47000000 {
>>> 		compatible = "simple-bus";
>>> 		reg = <0x0 0x47000000 0x0 0x100>;
>>> 		#address-cells = <2>;
>>> 		#size-cells = <2>;
>>> 		ranges;
>>>
>>> 		hbmc_mux: mux-controller@47000004 {
>>> 			compatible = "reg-mux";
>>> 			reg = <0x00 0x47000004 0x00 0x2>;
>>> 			#mux-control-cells = <1>;
>>> -			mux-reg-masks = <0x4 0x2>; /* HBMC select */
>>> +			mux-reg-masks = <0x0 0x2>; /* HBMC select */
>>> 		};
>>>
>>> Who knows what non-upstreamed devices and devicetrees are affected?
>>> I guess we need to revert 2765149273f4 ("mux: mmio: use reg property
>>> when parent device is not a syscon") unless someone sees a sane way
>>> to fix this.
>>
>> There are only two in-tree nodes with "reg-mux" with a reg property: the
>> one this patch fixes, and the hbmc_mux you point out, both in TI devices.
>> I'd say it is safe to assume we are the only users, and our non-upstreamed
>> DTs depend on that patch, reverting it would cause more issues for
>> out-of-tree users than just fixing the two broken nodes above.
> 
> Peter,
> 
> Is it alright for this patch to be merged, given Andrew's response above?
> The problem with "hbmc_mux" node that you pointed out above could be fixed
> by another patch. Please let me know.

The hbmc_mux fix is now also posted:

https://lore.kernel.org/linux-arm-kernel/20240215141957.13775-1-afd@ti.com/

Andrew

> 
> Regards,
> Siddharth.

