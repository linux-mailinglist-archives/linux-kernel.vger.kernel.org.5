Return-Path: <linux-kernel+bounces-64992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DBE8C85464D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 10:43:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A9FB291E9C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 09:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FFB213ADB;
	Wed, 14 Feb 2024 09:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="hoPxFim3"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 579A0134A0;
	Wed, 14 Feb 2024 09:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707903789; cv=none; b=UMIVzUy+2ad/q9x+Ox5uoymjFDK4liRt6E2EJMZUksZOjxOHom38CGkfmv9e3vVlXxRb2Lgbav0ue4eAKZaJvcYjylTgVmyWJY1Cm5eMsBzzbCVF+U+llJ9RpjbzCGVgVeSqvAPwlb7PsuXit7FAT70W8AxCvyJ1ebvlkLaBlr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707903789; c=relaxed/simple;
	bh=HMI1tbD40fcGI/Gob3tsmSySOJRmfxkF2v0X/xjyfg0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ZOFMF27TzsxuoztDSw9iPWCT9HVXDrvJh/+dzHHWDxOeT6vjNzTc/gA7UaG40GQwZqiUyXKgFd+OxaXH/bVHgXyPijDyN1kjZIlbQlbD/uKMidGg4r/m73x5ypQ5XjDobmF0jEGhP8q3NTNc6uS+OO90/53WQW2o1hr2Qk9KmcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=hoPxFim3; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41E9h2hP095235;
	Wed, 14 Feb 2024 03:43:02 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707903782;
	bh=uju5aoFJkk6TMHaeqnz2NpeT+LqncuXnyulu66p63c8=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=hoPxFim30jjKVogLslEViC6zyluNQGbPGw1L+VJxTcoDw65LPHvni4YQitVob6aqJ
	 q6tfaBil/slkxbvPfLGfT2h7WyB5bEEBRu6AhX3yD8tZAUSsaAOkkmW7FfRjidureJ
	 T0lThVMTBlHwH8pMYWg+SmW8GadrmB0hUOsxJ9bc=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41E9h2eL038895
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 14 Feb 2024 03:43:02 -0600
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 14
 Feb 2024 03:43:01 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 14 Feb 2024 03:43:01 -0600
Received: from [172.24.227.94] (uda0132425.dhcp.ti.com [172.24.227.94])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41E9guiN104110;
	Wed, 14 Feb 2024 03:42:57 -0600
Message-ID: <40e15761-70b3-4343-a4b3-653bc4e6637e@ti.com>
Date: Wed, 14 Feb 2024 15:12:56 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] arm64: dts: ti: Add support for TI J722S
 Evaluation Module
Content-Language: en-US
To: Vaishnav Achath <vaishnav.a@ti.com>, Michael Walle <mwalle@kernel.org>,
        Andrew Davis <afd@ti.com>, <nm@ti.com>, <conor+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <kristo@kernel.org>,
        <robh+dt@kernel.org>
CC: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <u-kumar1@ti.com>,
        <j-choudhary@ti.com>
References: <20240206100608.127702-1-vaishnav.a@ti.com>
 <20240206100608.127702-4-vaishnav.a@ti.com>
 <CZ386ITQ83KH.1KNOV5MXLXPBF@kernel.org>
 <45bd5618-2e22-4715-9724-92f1d4b84608@ti.com>
From: Vignesh Raghavendra <vigneshr@ti.com>
In-Reply-To: <45bd5618-2e22-4715-9724-92f1d4b84608@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180



On 14/02/24 13:13, Vaishnav Achath wrote:
> Hi Michael,
> 
> On 12/02/24 21:32, Michael Walle wrote:
>> Hi,
>>
>> On Tue Feb 6, 2024 at 11:06 AM CET, Vaishnav Achath wrote:
>>> +# Boards with J722s SoC
>>> +dtb-$(CONFIG_ARCH_K3) += k3-j722s-evm.dtb
>>
>> I'm a bit confused by your names. What are the new/correct ones now?
>> Some seem to use the amXX names and some the jXX ones. I've read [1]
>> and it appears it was suggested to use the am67 names for the device
>> trees. Esp. because there is already, am62, am64, am65, am68 and
>> am69 in as names for the device trees.
>>
>> The TRM you've linked in the cover letter doesn't shed much light
>> either. It just lists both.
>>
> 
> Both names are correct, for other Jacinto devices J721S2 and J784S4, the
> industrial variants (AM68, AM69 respectively) and those boards were
> announced at a later point of time and since the automotive/J7 variants
> were introduced first, the SoC dtsi and files have the J7XX names, for
> AM62/AM64 there is no confusion in naming, in this case the initial TRM
> itself mentions J722S and AM67 variants with similar capabilities, the
> reasoning behind continuing with the J722S name is because the initial
> support is being added for J722S EVM (the top marking on the SoC package
> populated on the EVM say XJ722SAMW, this can be seen in the schematics
> also), please let know if this clarifies the confusion.
> 

AM64,AM62x/A/P are from different product line (Sitara) and don't have
any other aliases.

On the other hand, Jacinto SoCs have both J7xx variant and AM6xx part
numbers. Its being really unpredictable wrt when AM6xx variants of
Jacinto devices come out. So as a general rule, we name the DTS files
based on the name of the first device that comes out in the market which
has consistently been J7xx.

-- 
Regards
Vignesh

