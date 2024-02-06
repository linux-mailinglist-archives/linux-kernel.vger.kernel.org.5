Return-Path: <linux-kernel+bounces-55131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A34D84B81A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 15:40:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B3FB1C234D8
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 14:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20B70131750;
	Tue,  6 Feb 2024 14:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="I8WcFTku"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C215438D;
	Tue,  6 Feb 2024 14:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707230361; cv=none; b=Sr5ibLHOuwm/akl+T+Pr5V39oDpxQ3yHszCqzeUt9ABbJZzJg6cTWH669omeiceLX3wHYXO3aO7j5UGF5N86YDvSrKBjHSugigobhbBMizx9miEe4zySoOzz+crc25CWmYH/qZllg8RjvTKdVMzoCQuAEvMniMjK8rTKg9a6vOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707230361; c=relaxed/simple;
	bh=lgOEKAcriUKR1R+3/onXDsuF9htvWfPfkhPmt5o/xuw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=XN5qm+E3cPT+zEBvoS5uZ6TXawT/DCnu0YIxy0Yx9eUqu4+foQnexYlZ/J8tH16lduu/xnXWRm0XcCdax0sGGwv1mSAtA03K85Lpicnp4cWXCVBBV7ovkU0uryx3BJZC4TqbL6kcGdWtQZKYBM/9jiC/T70u87hNT0dbJexBV9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=I8WcFTku; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 416EdAE5107824;
	Tue, 6 Feb 2024 08:39:10 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707230350;
	bh=MrWuEOqIJdRB3uRaM/IMcntwfhK8jW9zSzRcS2wE14Y=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=I8WcFTkuuQefvtWQdafrFEcSuR1KXA0DodYP0x+UZM0W4+0sdUOLS/wBcktq5i/NG
	 Iseg8muMZfg0W4pclddmqKohCDcBdwVqzS+xjONpj4iZY4rKvzxURy2IhFwC8zzX1O
	 5+RuCaTbKg4fmcUB96pV7DpyuaGWsIzEiIqHQ1Bs=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 416EdAXH090983
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 6 Feb 2024 08:39:10 -0600
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 6
 Feb 2024 08:39:10 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 6 Feb 2024 08:39:10 -0600
Received: from [10.249.141.75] ([10.249.141.75])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 416Ed5xI007843;
	Tue, 6 Feb 2024 08:39:06 -0600
Message-ID: <a4fdbcfe-e0e0-4280-8638-e39b6b46778e@ti.com>
Date: Tue, 6 Feb 2024 20:09:05 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] clk: keystone: sci-clk: Adding support for non
 contiguous clocks
Content-Language: en-US
To: CHANDRU DHAVAMANI <chandru@ti.com>, Kamlesh Gurudasani <kamlesh@ti.com>,
        Nishanth Menon <nm@ti.com>
CC: <kristo@kernel.org>, <ssantosh@kernel.org>, <rishabh@ti.com>,
        <vigneshr@ti.com>, <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <u-kumar1@ti.com>
References: <20240206104357.3803517-1-u-kumar1@ti.com>
 <20240206131420.wtitflgav23jto2q@verbally>
 <871q9pzoiq.fsf@kamlesh.i-did-not-set--mail-host-address--so-tickle-me>
 <c5b6bd1d-dbb4-4bfb-8b3e-9b0733e2ba5d@ti.com>
 <c2b7f22d-f07d-4cac-8a01-af7b014e7ff4@ti.com>
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <c2b7f22d-f07d-4cac-8a01-af7b014e7ff4@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180


On 2/6/2024 7:56 PM, CHANDRU DHAVAMANI wrote:
>
> On 06/02/24 19:45, Kumar, Udit wrote:
>>
>> On 2/6/2024 7:24 PM, Kamlesh Gurudasani wrote:
>>> Nishanth Menon <nm@ti.com> writes:
>>>
>>>> On 16:13-20240206, Udit Kumar wrote:
>>>>> Most of clocks and their parents are defined in contiguous range,
>>>>> But in few cases, there is gap in clock numbers[0].
>>>>> Driver assumes clocks to be in contiguous range, and add their clock
>>>>> ids incrementally.
>>>>>
>>>>> New firmware started returning error while calling get_freq and is_on
>>>>> API for non-available clock ids.
>>>>>
>>>>> In this fix, driver checks and adds only valid clock ids.
>>>>>
>>>>> Fixes: 3c13933c6033 ("clk: keystone: sci-clk: add support for 
>>>>> dynamically probing clocks")
>>>>>
>>>>> [0] 
>>>>> https://software-dl.ti.com/tisci/esd/latest/5_soc_doc/j7200/clocks.html 
>>>>>
>>>>> Section Clocks for NAVSS0_CPTS_0 Device,
>>>>> clock id 12-15 not present.
>>>>>
>>>>> Signed-off-by: Udit Kumar <u-kumar1@ti.com>
>>>>>                   while (num_parents--) {
>>>>> +                    /* Check if this clock id is valid */
>>>>> +                    ret = provider->ops->get_freq(provider->sci,
>>>>> +                        sci_clk->dev_id, clk_id, &freq);
>>>> get_freq is a bit expensive as it has to walk the clock tree to find
>>>> the clock frequency (at least the first time?). just wondering if
>>>> there is lighter alternative here?
>>>>
>>> How about get_clock? Doesn't read the registers at least.
>>
>> Said API needs, some flags to be passed,
>>
>> Can those flag be set to zero, Chandru ?
>
>
> get_clock doesn't require any flags to be passed.


May be firmware does not need it but  I was referring to

https://elixir.bootlin.com/linux/latest/source/drivers/clk/keystone/sci-clk.c#L78



>
>
>>
>>
>>> Regards,
>>> Kamlesh

