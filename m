Return-Path: <linux-kernel+bounces-37372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 574F283AEF4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 17:59:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 892E31C23843
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 16:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BA3B7E77E;
	Wed, 24 Jan 2024 16:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="N/7pUQuK"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 232CE7E76F
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 16:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706115575; cv=none; b=YEhJ66DUg6/wUjxqfNKBXExaWf28K1LIJiPB0g0adANnM5KlISOAuFyx46vhfMdAMkBH6Dm+plL4D3kxSsGJBgt7beNtF6mOJoUgVIFhZmsb3jeVAzAD4a1VTcLvrvf24fF622bbzdxpr+k75Wfqq7J1cqP5hj/c/AAx6pZP/h0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706115575; c=relaxed/simple;
	bh=CSwRne/H5azSZN/9g7rwdujKi3YP++rh3IuboXHZ1S0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=GFro0ao6SjXKWXQRhyupIuTueNaju0CgI4qVuEjDLzsMI0w1UeJY2HZdpTk/zVK48mdDvvgyDSsvmZujBvL1p4yBfEOuET3iPT0ECs/WwM+AEajJlhpLjHU5N4si3nGS12hNl0d/hXoBWTVvw3hZpSbDmvhefa1Lke2CsS41zxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=N/7pUQuK; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40OGxLtt062756;
	Wed, 24 Jan 2024 10:59:21 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706115561;
	bh=T8/YhXvz+6ok2cqMvBRisj3ChhhqYjkF3Bew7xjZa8Y=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=N/7pUQuKhKkaLZeMnEz57YNsAihKTiUvePPZSQMDu6Ueh1WqCiSDz7vFQfgdy0M2j
	 7vG/JdE6Cp6pYjeKCA+6XyfTr1Rt9VvgwDsiEbJcQGPcMkdD2z7HiiMtO4/uWo6cBK
	 36ubC1MjAFxC9QPoRerIiwSb8gDesYlm6W/EZxqA=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40OGxKA5033955
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 24 Jan 2024 10:59:20 -0600
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 24
 Jan 2024 10:59:20 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 24 Jan 2024 10:59:20 -0600
Received: from [10.249.42.149] ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40OGxK4k108621;
	Wed, 24 Jan 2024 10:59:20 -0600
Message-ID: <1e6a94e7-1b88-450e-825f-bf4b56afb748@ti.com>
Date: Wed, 24 Jan 2024 10:59:20 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] ARM: multi_v7_defconfig: Add more TI Keystone support
Content-Language: en-US
To: Nishanth Menon <nm@ti.com>
CC: Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Santosh Shilimkar
	<ssantosh@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
References: <20240124162857.111915-1-afd@ti.com>
 <20240124164141.e6sdftiqxoxr6k7t@ravage>
From: Andrew Davis <afd@ti.com>
In-Reply-To: <20240124164141.e6sdftiqxoxr6k7t@ravage>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 1/24/24 10:41 AM, Nishanth Menon wrote:
> On 10:28-20240124, Andrew Davis wrote:
>> The Keystone platforms used their own keystone_defconfig mostly to
>> enable CONFIG_ARM_LPAE which could not be added to the multi_v7 config.
>> Now that we have multi_v7_lpae_defconfig/lpae.config target we can and
>> should use that defconfig for Keystone. Add the remaining must have
>> options for Keystone support to multi_v7_defconfig.
>>
> 
> Please state bloat-o-meter impact on vmlinux.
> 

$ ./scripts/bloat-o-meter build/vmlinux.baseline build/vmlinux
add/remove: 387/0 grow/shrink: 6/0 up/down: 130945/0 (130945)
..
Total: Before=22791863, After=22922808, chg +0.57%


Seems half of that is TI_KEYSTONE_NETCP, if we don't think
anyone will need nfs rootfs boot then we could make it a module:


$ ./scripts/bloat-o-meter build/vmlinux.baseline build/vmlinux
add/remove: 286/0 grow/shrink: 4/0 up/down: 64393/0 (64393)
..
Total: Before=22791863, After=22856256, chg +0.28%


Andrew

>> Signed-off-by: Andrew Davis <afd@ti.com>
>> ---
>>   arch/arm/configs/multi_v7_defconfig | 16 ++++++++++++++++
>>   1 file changed, 16 insertions(+)

