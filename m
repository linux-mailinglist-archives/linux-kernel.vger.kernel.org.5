Return-Path: <linux-kernel+bounces-61384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCEBF8511AB
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 11:58:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD9851C209B9
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 10:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 360F82BAE9;
	Mon, 12 Feb 2024 10:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="oPLwlbXx"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B74A1864C;
	Mon, 12 Feb 2024 10:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707735466; cv=none; b=CTxyKZ5s/ASls1QVKrw1Bss56K12QryrJBf37OrSmLJsDRgo31hWeN5WevcNFqIE7TqlNH3cXuMbuiVXG/fg+kjd6lc5NJW5Ce8PBJqEvINk7i4Ba9KcNiBO/Sm/Y6ffZpfkemq9wv68O5/AfVv4/hbixLcFnI3h6EqtL1iqHgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707735466; c=relaxed/simple;
	bh=9xW0e/NGcWkk+FEV31dLjsWMJfc9mdwIin0wbI9k+Vw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=To3dHpobRcHQm4WzBXhSUziEja2mOntQFoBOqMAOmMn0HGhmRfJfBE0nPenKh4YbML2TaPcWtx4T7yZEBkJ0vrCELsaIiPqE14qQWkpJT1a3XRgPgRtSDvKAub2pIoPkpLoCXBGut60/2dUkKCO8G+9z0WrP9RFMhXVVpZFFvwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=oPLwlbXx; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41CAvXFW117411;
	Mon, 12 Feb 2024 04:57:33 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707735453;
	bh=tkADkNXyuq0rzbZNH8mLuZ5jl0kk11rq9K3V6xvB+bo=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=oPLwlbXxW2Hij6ZnKcI7jhDd+p3S8L3omOYL/nfq9Z5Df8PY0vI9Ex8wWXLXVIZBZ
	 274Rt9lODVhmJTNm/92ornuec/qtlv9MdRUq2PWkuHl/AlGqg6R5Yr0krPPlzeXK6o
	 12nYwurZQWS1Vealtk7HPNrvirRMlUV7fc32+gZE=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41CAvXKa083841
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 12 Feb 2024 04:57:33 -0600
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 12
 Feb 2024 04:57:33 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 12 Feb 2024 04:57:33 -0600
Received: from [172.24.227.193] (devarsht.dhcp.ti.com [172.24.227.193])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41CAvSNE002368;
	Mon, 12 Feb 2024 04:57:29 -0600
Message-ID: <9c5b7b2c-8a66-4173-dfe9-5724ec5f733d@ti.com>
Date: Mon, 12 Feb 2024 16:27:28 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2] dt-bindings: media: Add sram-size Property for Wave5
Content-Language: en-US
To: Nicolas Dufresne <nicolas@ndufresne.ca>, Brandon Brnich <b-brnich@ti.com>,
        Nishanth Menon <nm@ti.com>
CC: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Nas Chung
	<nas.chung@chipsnmedia.com>,
        Jackson Lee <jackson.lee@chipsnmedia.com>,
        Mauro
 Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>, <linux-media@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Vignesh
 Raghavendra <vigneshr@ti.com>,
        Darren Etheridge <detheridge@ti.com>
References: <20240201184238.2542695-1-b-brnich@ti.com>
 <1209b7cf-5be2-4107-aa6b-d67a32ea3737@linaro.org>
 <20240202125257.p4astjuxpzr5ltjs@dragster>
 <8091a8cf-c1c0-49b0-b136-1ad0d185aa6a@linaro.org>
 <20240202155813.szxvi7bfp5xh7rvw@babble>
 <adfef53c-d64e-4855-ab61-101b6fa419e5@linaro.org>
 <20240205141255.z5kybm42qld44tdz@portfolio>
 <20240205192003.3qns6cxqurqnnj7c@udba0500997>
 <ab029558-fc04-854e-1f97-785f5cec0681@ti.com>
 <fccdc181727307f52a36f3bb621d6a4e192096da.camel@ndufresne.ca>
From: Devarsh Thakkar <devarsht@ti.com>
In-Reply-To: <fccdc181727307f52a36f3bb621d6a4e192096da.camel@ndufresne.ca>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Nicolas,

On 09/02/24 23:12, Nicolas Dufresne wrote:
> Le jeudi 08 février 2024 à 11:52 +0530, Devarsh Thakkar a écrit :
>> I think even with the approach selected in [1] i.e. referring the
>> mmio-sram node using DT property, you can still use dynamic SRAM
>> allocation.
>> The driver can still allocate from global sram pool dynamically using
>> of_gen_pool API as being explained here [3] i.e allocate when first
>> instance is opened and free up later when no instances are running.
>>
>> But I agree with Nishanth's point too that we may not want to give all
>> of SRAM to VPU. For e.g. on AM62A we have 64KiB SRAM and a 1080p
>> use-case requires 48KiB and even higher for 4K so if there is another
>> peripheral who is referring this sram node, then it may not get enough
>> as VPU will hog the major chunk (or all) of it while it is running and
>> this is where an optional property like sram-size will help to cap the
>> max sram usage for VPU and so this helps especially on platforms with
>> limited SRAM availability.
>>
>> As I understand, the sram size allocation is dependent on resolution and
>> once programmed can't be changed until all instances of VPU are done,
>> and we can't predict how many instances user will launch and with what
>> resolutions.
>>
>> So here's the flow we had thought of some time back :
>> 1) Define worst case sram size (per 4K use-case as I believe that's the
>> max for CnM wave521c) as a macro in driver
>>
>> Then the condition for determining sram size to be allocated should be
>> as below  :
>>
>> 2) When first instance of VPU is opened, allocate as per sram-size if
>> sram-size property is specified.
>>
>> 3) If sram-size is not specified then :
>>    -> Allocate as per worst case size macro defined in driver from sram
>> pool,
>>    -> If worst case size of SRAM > max SRAM size, then allocate
>>       max SRAM size
>>
>> 4). When all of the instances of VPU are closed, then free up all
>> allocated SRAM.
>>
>> [3] :
>> https://wiki.analog.com/resources/tools-software/linuxdsp/docs/linux-kernel-and-drivers/sram
> 
> Only issue here is that DT is not a use case configuration file. That DT
> parameter is meant for HW that simply cannot be operated without it. This is
> also edgy, because it also means that it should only be used if that information
> is not static and vary unpredictably per SoC, which seems generally unlikely. 
> 
> The Wave5 IP *can* work without it, so it should resort to something more
> dynamic. User configuration should be sorted out at the OS level.
> 
> Nicolas

Thanks, yeah that makes sense. The sram allocation size is dependent on
resolution so I think we should employ a fallback model for sram allocation as
described below :

1) Driver code should enumerate required sram sizes for each of the standard
resolutions (for e.g. #define 1080P_SRAM_SIZE 48128, #define 4K_SRAM_SIZE
66368 and so on...) and try to allocate per highest enumerated resolution
first) from sram pool using gen_pool_alloc when first instance of VPU is opened.

2) If the allocation fails, then driver should try to fallback to lower
resolution sram allocation size (viz. 1080P_SRAM_SIZE) for sram allocation.

3) When all of the VPU instances get closed, then free up all allocated SRAM
back to the pool so that other peripherals can use it.

Regards
Devarsh

