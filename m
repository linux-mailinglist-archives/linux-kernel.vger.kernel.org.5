Return-Path: <linux-kernel+bounces-64842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB4D2854392
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 08:44:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED0C11C21656
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 07:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CED9F1171A;
	Wed, 14 Feb 2024 07:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="XIEFh2Vh"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 622B4125A1;
	Wed, 14 Feb 2024 07:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707896638; cv=none; b=m0NojRhtDoNr6xT1q8rXp4CQurjTRUEiLgir86HmKfgU8zXR5Q5q7ZjbRS4VqXHJBoT68q5/XucSCIDUr9lH1UQX1FeZYjY35/LLj4BJDMBMAvOyESHooQrvtmOxnsimVkbEK2XEBOyopOx/hpg6QAPgttclUrsQBi9aUAHHnpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707896638; c=relaxed/simple;
	bh=v3L39AG6iIecOgYkszF4p8cxFB40CDXlfe218wo6Xg8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=GRovJkvuKPoLKq3svMyyojBd34VTsef0dn6V9shd6f+Oepb+R66SyI9IS1yN4tk7RQ4lNQJzb/3XgqnJudEiM7+pBLcrM4Q10I+fKtpH21jFr+BDrifK2SEgtOTUO8zS2f0Nif40kodEAMbOe/6QUkdVnMr95/huaK5lT4w3r/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=XIEFh2Vh; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41E7hnRS112889;
	Wed, 14 Feb 2024 01:43:49 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707896629;
	bh=tnihI+YM3AXr5w3Jx4CWOP0Vj9gtjnvp82oYgzAV3jc=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=XIEFh2Vhl6RYwnXj5/GrFmRlty1mzwtRrU939XWONr5OrZWnB3VH8XWGbS8Wy8/BK
	 d4VF1tqjKDijBm9D5BIUPLasnLCsZDi687ScQrbs1CYKlwUU61fLOoRYbs3cJeUhFr
	 KftOkUFVQdsGC6KPvDkWXsCVPu3Y0on/tH4gmC2M=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41E7hnKs015561
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 14 Feb 2024 01:43:49 -0600
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 14
 Feb 2024 01:43:49 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 14 Feb 2024 01:43:48 -0600
Received: from [10.24.69.142] ([10.24.69.142])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41E7hj04028714;
	Wed, 14 Feb 2024 01:43:45 -0600
Message-ID: <45bd5618-2e22-4715-9724-92f1d4b84608@ti.com>
Date: Wed, 14 Feb 2024 13:13:44 +0530
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
To: Michael Walle <mwalle@kernel.org>, Andrew Davis <afd@ti.com>, <nm@ti.com>,
        <vigneshr@ti.com>, <conor+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <kristo@kernel.org>,
        <robh+dt@kernel.org>
CC: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <u-kumar1@ti.com>,
        <j-choudhary@ti.com>
References: <20240206100608.127702-1-vaishnav.a@ti.com>
 <20240206100608.127702-4-vaishnav.a@ti.com>
 <CZ386ITQ83KH.1KNOV5MXLXPBF@kernel.org>
From: Vaishnav Achath <vaishnav.a@ti.com>
In-Reply-To: <CZ386ITQ83KH.1KNOV5MXLXPBF@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Michael,

On 12/02/24 21:32, Michael Walle wrote:
> Hi,
> 
> On Tue Feb 6, 2024 at 11:06 AM CET, Vaishnav Achath wrote:
>> +# Boards with J722s SoC
>> +dtb-$(CONFIG_ARCH_K3) += k3-j722s-evm.dtb
> 
> I'm a bit confused by your names. What are the new/correct ones now?
> Some seem to use the amXX names and some the jXX ones. I've read [1]
> and it appears it was suggested to use the am67 names for the device
> trees. Esp. because there is already, am62, am64, am65, am68 and
> am69 in as names for the device trees.
> 
> The TRM you've linked in the cover letter doesn't shed much light
> either. It just lists both.
> 

Both names are correct, for other Jacinto devices J721S2 and J784S4, the 
industrial variants (AM68, AM69 respectively) and those boards were 
announced at a later point of time and since the automotive/J7 variants 
were introduced first, the SoC dtsi and files have the J7XX names, for 
AM62/AM64 there is no confusion in naming, in this case the initial TRM 
itself mentions J722S and AM67 variants with similar capabilities, the 
reasoning behind continuing with the J722S name is because the initial 
support is being added for J722S EVM (the top marking on the SoC package 
populated on the EVM say XJ722SAMW, this can be seen in the schematics 
also), please let know if this clarifies the confusion.

Thanks and Regards,
Vaishnav

> -michael
> 
> [1] https://lore.kernel.org/all/81f90d13-da10-4a68-a0e7-95212f40b3e8@ti.com/

