Return-Path: <linux-kernel+bounces-37553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5BEE83B184
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 19:52:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E4ED289D4C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 18:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0504013174F;
	Wed, 24 Jan 2024 18:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="V9Eh7knq"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A284E12F59B
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 18:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706122349; cv=none; b=l6KQ+0IkEzbxEdHJW9yChzjAMTOKFU+HxGTLRoD5rBPpUc3zh48QEvTufsR6cR9xYDhh7nyVcofGRAgaeRw+GvQT7duD0B+shXNb/E0bKnaKRJMHQegoFSItoxf1wgXOQ+a7hQ/lpHp9hzN1xME8iWZXfJAbc2v2gnbVDO6/500=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706122349; c=relaxed/simple;
	bh=4jUhsHFJS4iLZr3GhEH/FR7zM5m0O6OVbg4xgwLN4qI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=M2kBsI3sQFG0ivGzVXeCr2kffamNzV6GKTgRoJkkwscrYx2+4s2mpa5AtazS5vCQqnF8ch95UeCVM70cohbrYUwY2gcYoi+PZpY1Zp0zrWx8N8y+PMK+fvTgCJECnOHL8pkfUIL5zHGRzoj5DUxkS7K2H3yZ3obDkW5phUpzRVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=V9Eh7knq; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40OIqABs004864;
	Wed, 24 Jan 2024 12:52:10 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706122330;
	bh=3z5Dtz4jhRDLew/8SutnYIHrRd1ImbhMh+X0wJ2Fyx0=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=V9Eh7knq1+FOKt7pMEB/xFGF1tJ3IdrfmSKV2QSdKzhl8T8CLKZdBVPHJg0Ci/ceD
	 XTdz1gmE+SP3oGu4ikeWEj9fxIny5hNfL5tgGyrtcBrecHZD2uPZ7p5aqXonph9UlG
	 nDmwA2U8kWeH6yZqdH8Ts4gVKLQ3uSszSGKjEAMI=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40OIqA4u029558
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 24 Jan 2024 12:52:10 -0600
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 24
 Jan 2024 12:52:10 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 24 Jan 2024 12:52:10 -0600
Received: from [10.249.42.149] ([10.249.42.149])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40OIq9tr033511;
	Wed, 24 Jan 2024 12:52:09 -0600
Message-ID: <5f5a2ecd-7878-46ba-9a85-a2a4ba060ad7@ti.com>
Date: Wed, 24 Jan 2024 12:52:09 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] ARM: configs: keystone: Remove this defconfig
Content-Language: en-US
To: Nishanth Menon <nm@ti.com>
CC: Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Santosh Shilimkar
	<ssantosh@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20240124162857.111915-1-afd@ti.com>
 <20240124162857.111915-2-afd@ti.com>
 <20240124164116.k5ah56xvuclfkxdr@despise>
 <0ab47165-3ba3-4d34-aea0-9bc12fd5ff31@ti.com>
 <20240124180451.bptuhldi44leulr3@pectin>
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20240124180451.bptuhldi44leulr3@pectin>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 1/24/24 12:04 PM, Nishanth Menon wrote:
> On 11:31-20240124, Andrew Davis wrote:
>> On 1/24/24 10:41 AM, Nishanth Menon wrote:
>>> On 10:28-20240124, Andrew Davis wrote:
>>>> TI Keystone devices can and should use the common multi-v7 defconfig.
>>>> Currently it is not clear which defconfig should be used and so config
>>>> options for Keystone boards are added to either both defconfigs, or only
>>>> one or the other. As nice as it is to have a config just for this platform
>>>> it is a maintenance burden. As it is not used by generic distros it is not
>>>> very useful to continue to maintain. Remove this defconfig.
>>>>
>>>> Signed-off-by: Andrew Davis <afd@ti.com>
>>>> ---
>>>>    arch/arm/configs/keystone_defconfig | 238 ----------------------------
>>>>    1 file changed, 238 deletions(-)
>>>>    delete mode 100644 arch/arm/configs/keystone_defconfig
>>>>
>>>
>>> There are a bunch of downstream folks who will have recipe fails etc if
>>> we do that. I am not sure we need to go down that route.
>>>
>>
>> That is the point of this patch, we want to stop any remaining downstream
>> folks from using this defconfig. It is not maintained nor updated like
>> the multi_v7_defconfig, any new or needed options will only be added to
>> multi-v7 defconfig.
>>
> 
> I am going to have to defer to ARM maintainers what they think..
> enabling LPAE etc in common multi_v7_config.
> 

We are not enabling LPAE in common multi_v7_config, that can't be
done as many plats do not support it. Keystone will use the new
multi_v7_lpae_defconfig which was just added:

e9faf9b0b07a ("ARM: add multi_v7_lpae_defconfig")

That is what prompted me to make this change, we now have a
commonish config that works for Keystone.

Andrew


> --
> Regards,
> Nishanth Menon
> Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

