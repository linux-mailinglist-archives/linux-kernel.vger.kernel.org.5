Return-Path: <linux-kernel+bounces-62155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CD20851C50
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 18:59:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 473F82835FE
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 17:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22BA53FB30;
	Mon, 12 Feb 2024 17:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="JFoSEacf"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62E433FB04;
	Mon, 12 Feb 2024 17:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707760594; cv=none; b=GK6SOlO8suUE1exSPJDXebrueK78dJjdBVgrWbZlRX0fsGnHWVFArMMYVR15eoYZfsK4wQgstGtt9rvcGXp+2GtdMv3qTsboBL98pBAAQ8W6XXvPuUR8nrZE6IokES2TWmYIc4D2PFOPUq1bOcw7UQwMvA1np8zXwYdrZLCUAgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707760594; c=relaxed/simple;
	bh=2r25D3RkmAhnoHfCtG3fTfGBVMpFCXq8I78FILFhQ7w=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Sq5uL6E7M+d+glyUfe6F+hCwX1FNSHMHvU1jvTle8HAHDolyb81+kx4+y63rGUX5bRY0JfBXaC0oq8VKKLD2Jt4z9rYkKpbuXJCzt1+znZi22Ak20dQIUamYSTveqctiTBSdJUv+Vn+uCTHjfWEch7+7CNf+qxicb3lHsKQnFoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=JFoSEacf; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41CHuOlb091354;
	Mon, 12 Feb 2024 11:56:24 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707760584;
	bh=SSN3qP2rZfQOjml1X+YPSJR5oxmjDrVN1aLFoleE3d0=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=JFoSEacfp6BBhYLTE257VnK+hcUdzl5XxftxmxRLUu8jn7f3oNdx2f9vD9hVWZ/Lr
	 MJdUqj9NrL52y8wU51d+x2o7rDtf8FdTDmANSB+4bZDyC+mCh0ToTH35a79d/NfyIa
	 iA35Dpb3wlV+9dcVx1FXkjaDEb3mlBhX+Id+lEpc=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41CHuOlR000577
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 12 Feb 2024 11:56:24 -0600
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 12
 Feb 2024 11:56:23 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 12 Feb 2024 11:56:23 -0600
Received: from [128.247.81.105] (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41CHuNke115748;
	Mon, 12 Feb 2024 11:56:23 -0600
Message-ID: <3a203d8b-861f-49bd-a196-c86e2d46123a@ti.com>
Date: Mon, 12 Feb 2024 11:56:23 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/7] Add tuning algorithm for delay chain
To: Francesco Dolcini <francesco@dolcini.it>
CC: Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter
	<adrian.hunter@intel.com>, <linux-mmc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20240207011520.3128382-1-jm@ti.com>
 <20240211160232.GB4443@francesco-nb>
 <7482f19f-b340-482f-bdf6-a5a68aeaf09e@ti.com>
 <20240212173244.GA17182@francesco-nb>
Content-Language: en-US
From: Judith Mendez <jm@ti.com>
In-Reply-To: <20240212173244.GA17182@francesco-nb>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Francesco,

On 2/12/24 11:32 AM, Francesco Dolcini wrote:
> Hi Judith,
> 
> On Mon, Feb 12, 2024 at 10:33:35AM -0600, Judith Mendez wrote:
>> Hi Francesco,
>>
>> On 2/11/24 10:02 AM, Francesco Dolcini wrote:
>>> On Tue, Feb 06, 2024 at 07:15:13PM -0600, Judith Mendez wrote:
>>>> This patch series introduces a new tuning algorithm for
>>>> mmc. The new algorithm should be used when delay chain is
>>>> enabled. The ITAPDLY is selected from the largest passing
>>>> window and the buffer is not viewed as a circular buffer.
>>>> The new tuning algorithm is implemented as per the paper
>>>> published here [0] and has been tested on the following
>>>
>>> Where is this `[0]`?
>>
>> I must have missed linking the ref doc here, will add in next
>> iteration, thanks.
>>
>>>
>>>> platforms: AM62x SK, AM62A SK, AM62p SK, AM64x SK, and AM64x
>>>> EVM.
>>>
>>> In the other patches you link some document, but I was not able to find
>>> anything related to AM62, can you provide some reference on this
>>> specific SOC?
>>
>> This patch series fixes issues that affect all Sitara SoCs, not only
>> AM62x. However, I could use AM62x for reference, no problem.
> 
> I am really looking for documentation here that is related to the AM62
> because I was not able to find anything and this is a topic of interest
> for me.
> 

The AM62x device datasheet: https://www.ti.com/lit/ds/symlink/am625.pdf,
reference Table 7-79 for MMC0 and Table 7-97 for MMC1.

TRM, reference section 12.4.5 for MMCSD and section 12.4.5.5.2.3.2
Tuning Sequence that we currently implement in the sdhci_am654 driver.
Section 14.8.4.6 for MMCSD registers, SS_CFG_PHY_CTRL_1,
SS_CFG_PHY_CTRL_5, and SS_CFG_PHY_CTRL_5 are usually of higher interest.

Tuning algorithm, reference: 
https://www.ti.com/lit/an/spract9/spract9.pdf which is applicable for 
AM62x, DLL is not applicable
for AM62x, so the tuning algorithm should not consider the buffer
as a circular buffer.

~ Judith

> Can you share something?
> 
> Francesco
> 


