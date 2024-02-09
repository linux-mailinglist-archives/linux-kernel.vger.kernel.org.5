Return-Path: <linux-kernel+bounces-60103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 294B484FFDF
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 23:27:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B6E41F2333A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 22:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C54E63610A;
	Fri,  9 Feb 2024 22:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="RtqLBxN+"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E15821350;
	Fri,  9 Feb 2024 22:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707517659; cv=none; b=Hk7Dk3nAMHF35pMdp0d5Qk2AHkoQDgzZMeetK7MeGsiBTt9vA8aBC31v8JBd4G442Zhuf4btAbbyW/MR1M+7NXq50WqgaET/PvwY1gLRHVurIAabMSQJ7ZmW85Gqou7YxHo21qXkmdgzSOp57Q4qSi2kG06R3+0eUDBY/1ysKOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707517659; c=relaxed/simple;
	bh=WFnln71H1Jrztbp5ObIU6Rg/jE1e1LD9LnpnWn70gqg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=LHMOi4GcD0H99MzleyiLJ214c8tNWFOTAKzufp2Wdl0tv6q0I9bwQaDP426/QHwlcBNotXAbkGMeLCyZ1wPDPl47m76gidVpptALn7w9+3iP2EfQDzabgEx2LgbfVSdFpBVBqxalN0j3mRAPFgR8cZlnEbX7fi0Ph0L2n6Mpxxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=RtqLBxN+; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 419MRUJT048903;
	Fri, 9 Feb 2024 16:27:30 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707517650;
	bh=yRtjzBrabNUFLK1rvVN6g3JsGoxwYp7lbeqd5YZCsig=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=RtqLBxN+isZRoKJ0KQ1w5RgHiPmUfiP9Hi7Cmr+yBiWty878YgDjtPXeODW2ZdR+n
	 OFnNgdFl2sPxrAdB3gr0CzuepIIv3cJPvR7Rqzb7v7wXBEuHHXTGVFRINziTX25G7M
	 FGmgzwvIWTLjCaSc0lSlYjPLlrhC1YVo3gfDtlIo=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 419MRUjx014601
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 9 Feb 2024 16:27:30 -0600
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 9
 Feb 2024 16:27:29 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 9 Feb 2024 16:27:29 -0600
Received: from [128.247.81.105] (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 419MRTNu067033;
	Fri, 9 Feb 2024 16:27:29 -0600
Message-ID: <15db1143-afe2-44b0-a6a5-bce871a6bd6b@ti.com>
Date: Fri, 9 Feb 2024 16:27:29 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 9/9] arm64: dts: ti: k3-am6*: Fix bootph-all property
 in MMC node
Content-Language: en-US
To: Nishanth Menon <nm@ti.com>
CC: Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20240207225526.3953230-1-jm@ti.com>
 <20240207225526.3953230-10-jm@ti.com>
 <20240209172745.dswt5q6xnulubrjp@bagpipe>
From: Judith Mendez <jm@ti.com>
In-Reply-To: <20240209172745.dswt5q6xnulubrjp@bagpipe>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Nishanth,

On 2/9/24 11:27 AM, Nishanth Menon wrote:
> On 16:55-20240207, Judith Mendez wrote:
>>   &sdhci1 {
>>   	/* SD/MMC */
>> +	bootph-all;
>>   	status = "okay";
>>   	vmmc-supply = <&vdd_mmc1>;
>>   	vqmmc-supply = <&vddshv_sdio>;
>>   	pinctrl-names = "default";
>>   	pinctrl-0 = <&main_mmc1_pins_default>;
>>   	disable-wp;
>> -	bootph-all;
> 
> NAK! Read [1]
> 
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/dts-coding-style.rst#n117
> 

No worries, I can remove this change.

~ Judith

