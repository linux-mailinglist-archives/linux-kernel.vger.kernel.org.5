Return-Path: <linux-kernel+bounces-158081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80B938B1B31
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 08:44:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B26A61C21152
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 06:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D71A5A11A;
	Thu, 25 Apr 2024 06:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="WtlrpY2w"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C47CC3BBE8;
	Thu, 25 Apr 2024 06:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714027466; cv=none; b=hTjBMYSOz9LPtWGIqeg1+oUviWhJWDOch2ico8swdmq5g5CLu+pxFNTD0HTKF2RI0ceWBi78qrQOTjq+7hhCeUFBvOMHAd1+zeoP13LKILvHsJ2DqkLoSUXQxTZqLIK3AQbzqUP5LPxFhi2aNYJR9zwKJouFcB1Eo1w6TEG6rNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714027466; c=relaxed/simple;
	bh=WQSMwd+tNMCVO6kH1o+7mkTtu6LUon02eBDzLfrMOo8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=tVlKUs2reqQCZYJv2uTxqITTNy2LCSoMH0dhyOLviQpSLzyMW6gVz4NEuoGJq93zu4ZQtatHxFwgKifYFQ6Epbk/APqM7yl0D5gk2wfGwXAvLa0fdgFZNUgViPzDIPFam1MCwsOLQoJHICsxWklHN2zbaxPTOYub00FD02PA4Gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=WtlrpY2w; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43P6i47Z085553;
	Thu, 25 Apr 2024 01:44:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1714027444;
	bh=/Ulz98hKzYu1co/cS/dOgIOLEVqfXbA1NDOWLo9MEUI=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=WtlrpY2wyJsxReczN5lBNBshDzijgx/oB1qSXDL2d4EzpXmf4Rsk2Z23+BJftc7cU
	 Kp9kOEfEcZnWJ2ddjTrDbGWYr+Amlt0dI8Vk7feoEOSPJpugq2v7MO/o2ow/wDgOla
	 wg+YaWkVUIA80cl21P/wr1cUxsEpKkkf/CHT5wMg=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43P6i41E041580
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 25 Apr 2024 01:44:04 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 25
 Apr 2024 01:44:04 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 25 Apr 2024 01:44:04 -0500
Received: from [10.24.69.25] (danish-tpc.dhcp.ti.com [10.24.69.25])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43P6hwhf010667;
	Thu, 25 Apr 2024 01:43:59 -0500
Message-ID: <1c5809f2-b69d-48d1-8c27-285f164ebeb8@ti.com>
Date: Thu, 25 Apr 2024 12:13:58 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: ti: icssg_prueth: Add SW TX / RX Coalescing
 based on hrtimers
Content-Language: en-US
To: Andrew Lunn <andrew@lunn.ch>
CC: Dan Carpenter <dan.carpenter@linaro.org>,
        Heiner Kallweit
	<hkallweit1@gmail.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Diogo Ivo
	<diogo.ivo@siemens.com>, Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski
	<kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
        "David S. Miller"
	<davem@davemloft.net>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>, <r-gunasekaran@ti.com>,
        Roger Quadros <rogerq@kernel.org>
References: <20240424091823.1814136-1-danishanwar@ti.com>
 <98588a89-4970-4d75-be8a-ac410d77789f@lunn.ch>
From: MD Danish Anwar <danishanwar@ti.com>
In-Reply-To: <98588a89-4970-4d75-be8a-ac410d77789f@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi Andrew,

On 24/04/24 6:01 pm, Andrew Lunn wrote:
> On Wed, Apr 24, 2024 at 02:48:23PM +0530, MD Danish Anwar wrote:
>> Add SW IRQ coalescing based on hrtimers for RX and TX data path for ICSSG
>> driver, which can be enabled by ethtool commands:
>>
>> - RX coalescing
>>   ethtool -C eth1 rx-usecs 50
>>
>> - TX coalescing can be enabled per TX queue
>>
>>   - by default enables coalesing for TX0
>>   ethtool -C eth1 tx-usecs 50
>>   - configure TX0
>>   ethtool -Q eth0 queue_mask 1 --coalesce tx-usecs 100
>>   - configure TX1
>>   ethtool -Q eth0 queue_mask 2 --coalesce tx-usecs 100
>>   - configure TX0 and TX1
>>   ethtool -Q eth0 queue_mask 3 --coalesce tx-usecs 100 --coalesce
>> tx-usecs 100
>>
>> Minimum value for both rx-usecs and tx-usecs is 20us.
> 
> Do you have some benchmark numbers?
> 
> Did you see this patch on the mailing list:
> 
> https://lore.kernel.org/all/20240415094804.8016-1-paul.barker.ct@bp.renesas.com/T/#md50cb07bbdd6daf985f3796508cf4b246b085268
> 
> This is basically a one line change, which brings big performance
> gains. Did you try something as simple as that, rather than all your
> hrtimer code?
> 

I did some benchmarking today with,
	1. Default driver (without any IRQ coalescing enabled)
	2. IRQ Coalescing (With this patch)
	3. Default IRQ Coalescing (Suggested by you in the above patch)

I have pasted the full logs at [1].

Below are the final numbers,

==============================================================
Method                  | Tput_TX | CPU_TX | Tput_RX | CPU_RX |
==============================================================
Default Driver           943 Mbps    31%      517 Mbps  38%   |
IRQ Coalescing (Patch)   943 Mbps    28%      518 Mbps  25%   |
Default IRQ Coalescing   942 Mbps    32%      521 Mbps  25%   |
==============================================================

I see that the performance number is more or less same for all three
methods only the CPU load seems to be varying. The IRQ coalescing patch
(using hrtimer) seems to improve the cpu load by 3-4% in TX and 13% in
RX. Whereas the default method that you have suggested doesn't give any
improvemnet in tx however cpu load improves in RX with the same amount
as method 2.

Please let me know if this patch is OK to you based on the benchmarking?

[1]
https://gist.githubusercontent.com/danish-ti/47855631be9f3635cee994693662a988/raw/94b4eb86b42fe243ab03186a88a314e0cb272fd0/gistfile1.txt

> 	Andrew

-- 
Thanks and Regards,
Danish

