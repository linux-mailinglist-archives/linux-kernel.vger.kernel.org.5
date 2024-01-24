Return-Path: <linux-kernel+bounces-37440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FA5683B027
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 18:37:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05408B215EA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 17:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C30EA1272BE;
	Wed, 24 Jan 2024 17:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="bwBDisSK"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F7B1272B0
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 17:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706117541; cv=none; b=tUkJS2W/ClbomZw8syaOkurF6A3jxi6sDg0/kUCgOTfPlbCGMIaK0mmeBhq6TCC3EndKjJfn2dkU+mBV1hYIf1XN+DMJNxx9t7urdq+DdtzhR9ltN+Di5Q27EjcNHAZgoNH6DaqhxuoD9CH7zB0AB385WwEJyvIK5nGC/vdS4CI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706117541; c=relaxed/simple;
	bh=L9WwAHFBlNfwynoK+bz4ENy/mk9uymDQGuGkhJ92QG8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=TKxEy4HX0nj+Op8+p9B0V5rITSxYkrzxopm9b40VxDpilr4UybhHb+WVxzr70XfUQoXkmEWrVEQlCBfLcFD8E2NM9z8CVeVa5aCpY0nu9AP7n0HocFIOGbkHOmXF3mzAJ8R487HShH0Cu8C7eTb1c8catKFDAExw8nC9jLf+JyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=bwBDisSK; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40OHW0kD059675;
	Wed, 24 Jan 2024 11:32:00 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706117520;
	bh=WifEWBVAqtT7VDYyujVHllrGH/B8fDTWzGvePRInBgI=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=bwBDisSKIG0jOFW4SPsd9u96vh1/QO0vVFqSecaUsDCk6uBb0FU9hsstPvmKw1L9U
	 8uKN5mCuvNWw5mdnBMp91Y3A8E74Hq3t1nobulDEMX2lLbZjPerqQKrth8+uMrnMUZ
	 Q+h57sxitWy+uKSdTMJeZ4XTllCkYyMp0EmtuEuA=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40OHW0Mu049176
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 24 Jan 2024 11:32:00 -0600
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 24
 Jan 2024 11:31:59 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 24 Jan 2024 11:31:59 -0600
Received: from [10.249.42.149] ([10.249.42.149])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40OHVxQS061836;
	Wed, 24 Jan 2024 11:31:59 -0600
Message-ID: <0ab47165-3ba3-4d34-aea0-9bc12fd5ff31@ti.com>
Date: Wed, 24 Jan 2024 11:31:59 -0600
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
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20240124164116.k5ah56xvuclfkxdr@despise>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 1/24/24 10:41 AM, Nishanth Menon wrote:
> On 10:28-20240124, Andrew Davis wrote:
>> TI Keystone devices can and should use the common multi-v7 defconfig.
>> Currently it is not clear which defconfig should be used and so config
>> options for Keystone boards are added to either both defconfigs, or only
>> one or the other. As nice as it is to have a config just for this platform
>> it is a maintenance burden. As it is not used by generic distros it is not
>> very useful to continue to maintain. Remove this defconfig.
>>
>> Signed-off-by: Andrew Davis <afd@ti.com>
>> ---
>>   arch/arm/configs/keystone_defconfig | 238 ----------------------------
>>   1 file changed, 238 deletions(-)
>>   delete mode 100644 arch/arm/configs/keystone_defconfig
>>
> 
> There are a bunch of downstream folks who will have recipe fails etc if
> we do that. I am not sure we need to go down that route.
> 

That is the point of this patch, we want to stop any remaining downstream
folks from using this defconfig. It is not maintained nor updated like
the multi_v7_defconfig, any new or needed options will only be added to
multi-v7 defconfig.

> I know we had intent on multi_v7_defconfig -> but as far as I recollect,
> at least during armv7 it did'nt exactly pan out as it did on armv8.
> 

It worked for ARMv8 as it wasn't allowed go spin up custom defconfigs for
every random platform. It will work here for many/most platforms just the
same if they do what I'm doing here and remove their old unneeded defconfigs.

Andrew

