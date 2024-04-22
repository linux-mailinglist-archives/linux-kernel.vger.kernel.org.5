Return-Path: <linux-kernel+bounces-154069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B0A28AD717
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 00:07:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EC67283CA6
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 22:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8AF11D559;
	Mon, 22 Apr 2024 22:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="OAe/vxOP"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 864371CD2E;
	Mon, 22 Apr 2024 22:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713823624; cv=none; b=mqniDXb3BF5LHQfXSGCaPxjZitLUUTX28n4KEmkwu7W2RbE8A4wtq3urdKxQ9BK87jJ0cY5OtCHYdGjwyXUXWoaHMHEl/sKUJSb8F/FTXwQlKTnnLGi/+ER1ae7APInIbgG9WlHWk9l6JGeb5hJ/qmaeJJ+AQoMzyJ57RNtFKJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713823624; c=relaxed/simple;
	bh=YG2ho/COX1GcuoOgAMZQGsutT3JYVTyxSfFQqkjoH58=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=P5IWvDFl8GIMgY8dCMkKQo6FWiU7PlJv3QeVz1rrA1xruZhwJ2NUW8zxL5RzTGyWcHeLCTIdnqFvmNCSzGkRj/LcjJFFWoc4AtovUs4Xlb/iSCq0nr/lcFezFXZEUyGfN0Pe3AlWglHv/UtJd91uHJWBc7M6uMwHp1SdCnSM3Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=OAe/vxOP; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43MM6nw3059208;
	Mon, 22 Apr 2024 17:06:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1713823609;
	bh=1BJa45blcEjepqkQOUqbdHFGqA41MZjWndkZliOxTMU=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=OAe/vxOPVyE2yfRFo4SEglCbI+L8otru7AmIGIvYiVRwc4L1XBU86vavejN9JC99q
	 sVmqcySnZRldFXb4INZc3uiQ4FZblqYcE6tmnAal5WGQbmWtVU/KFixGCNdJ5CIujf
	 FdirCdUsS8b2vfippch+jYnorAQfdWd4wZnviwyo=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43MM6ne0069246
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 22 Apr 2024 17:06:49 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 22
 Apr 2024 17:06:48 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 22 Apr 2024 17:06:48 -0500
Received: from [128.247.81.105] (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43MM6mvq104678;
	Mon, 22 Apr 2024 17:06:48 -0500
Message-ID: <ecf3f42b-9758-4ee4-b1e4-a003933ea225@ti.com>
Date: Mon, 22 Apr 2024 17:06:48 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/6] arm64: defconfig: Set CONFIG_MFD_TPS6594_I2C=y
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
CC: Vignesh Raghavendra <vigneshr@ti.com>, Conor Dooley <conor+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Bhavya Kapoor <b-kapoor@ti.com>,
        Dasnavis
 Sabiya <sabiya.d@ti.com>
References: <20240416221648.3522201-1-jm@ti.com>
 <20240416221648.3522201-7-jm@ti.com>
 <5f03207b-c29b-4d16-92b0-d14eef77bf17@linaro.org>
Content-Language: en-US
From: Judith Mendez <jm@ti.com>
In-Reply-To: <5f03207b-c29b-4d16-92b0-d14eef77bf17@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hi,

On 4/19/24 8:59 AM, Krzysztof Kozlowski wrote:
> On 17/04/2024 00:16, Judith Mendez wrote:
>> SK-AM62A-LP uses TPS6593x PMIC (interfaced over I2C) to power the SoC
>> and various other peripherals on the board [1].
>>
>> Booting SD with UHS modes have a dependency on TPS6593x PMIC driver so
>> change to built in order to boot using SD boot at the higher speed modes.
>>
>> Fixes: f9010eb938be ("arm64: defconfig: Enable TPS6593 PMIC for SK-AM62A")
> 
> No, that's not a fix. Fix is using proper initramfs, because bug is lack
> of initramfs, not having it as module.
> 
> I don't agree, because I prefer to have this as module.

ok, will drop this patch, thanks.

~ Judith

> 
>> Signed-off-by: Judith Mendez <jm@ti.com>
> 
> 
> Best regards,
> Krzysztof
> 


