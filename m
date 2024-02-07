Return-Path: <linux-kernel+bounces-56067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F347E84C597
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 08:24:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADA6C286FDA
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 07:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EA011F606;
	Wed,  7 Feb 2024 07:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="xIXBHDpw"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E92731F94C;
	Wed,  7 Feb 2024 07:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707290642; cv=none; b=aEjwYNEWGVBTJ7/RDu4BTf5H31HsA7oUjWeV6pp4fNflpHZL/sQnK1+NyZCmrkO++p49AoguyqYjylHzQpaj2VQJ6aQZO1L1SLNr3OJ+n5W+n3sva6oM8EPMeaRPwpsyI//SNTeKWnI5TLIZ6VzCZ1+8sE407KFShuKyxDa1zf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707290642; c=relaxed/simple;
	bh=P+qwE/LvcSrv6uS4V0+wVdLNJt/Nzmner4dCG4NzmD0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=D4gCSTWd+xHW65dTqoRcZWZkj+hV87SeRsu4QGO5gPGRe1qlIFe/Nl9XophfYVBjTT1jMFJkVMisxpzf1kW2fyhLZtOCOghitISG/KjjLwKiItbFahwu2rhIUcwB+rVQDurAfXSJ4K1wjI7y6eTlI2ZAiZkBxdfvJzYirrfzIxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=xIXBHDpw; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4177NqkE020551;
	Wed, 7 Feb 2024 01:23:52 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707290632;
	bh=/rdkrLH0rHwRYDnSan6hZ6J3vu1p7qYE06NMC/e8b5Y=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=xIXBHDpwEJ7wxuak9b3F2/hLQqPshOUu23/WyDxgfzrZMol0p+N9vQiVqKOC4audZ
	 dWOAHi1QpTOCOSbWKWQwp2f3SZ2m0A6Jr+/KiGDwyqs1qNyj9vvdL956BmmBA4frPA
	 AkIhdpH1Qb7WbKBbDOoyK4BLqCtwtWc68MdDDVQY=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4177NqS2130697
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 7 Feb 2024 01:23:52 -0600
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 7
 Feb 2024 01:23:52 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 7 Feb 2024 01:23:52 -0600
Received: from [10.24.69.14] (chandru.dhcp.ti.com [10.24.69.14])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4177Nm0r098286;
	Wed, 7 Feb 2024 01:23:48 -0600
Message-ID: <4398af20-3396-4a5c-8fcb-a7b3d0d6f15b@ti.com>
Date: Wed, 7 Feb 2024 12:53:47 +0530
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
To: "Kumar, Udit" <u-kumar1@ti.com>, Kamlesh Gurudasani <kamlesh@ti.com>,
        Nishanth Menon <nm@ti.com>
CC: <kristo@kernel.org>, <ssantosh@kernel.org>, <rishabh@ti.com>,
        <vigneshr@ti.com>, <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-clk@vger.kernel.org>
References: <20240206104357.3803517-1-u-kumar1@ti.com>
 <20240206131420.wtitflgav23jto2q@verbally>
 <871q9pzoiq.fsf@kamlesh.i-did-not-set--mail-host-address--so-tickle-me>
 <c5b6bd1d-dbb4-4bfb-8b3e-9b0733e2ba5d@ti.com>
 <c2b7f22d-f07d-4cac-8a01-af7b014e7ff4@ti.com>
 <a4fdbcfe-e0e0-4280-8638-e39b6b46778e@ti.com>
 <87ttmly4fa.fsf@kamlesh.i-did-not-set--mail-host-address--so-tickle-me>
 <e2ea03ce-0367-413b-aca9-7c1fabda173a@ti.com>
From: CHANDRU DHAVAMANI <chandru@ti.com>
In-Reply-To: <e2ea03ce-0367-413b-aca9-7c1fabda173a@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180


On 07/02/24 11:03, Kumar, Udit wrote:
>
> On 2/6/2024 9:24 PM, Kamlesh Gurudasani wrote:
>> "Kumar, Udit" <u-kumar1@ti.com> writes:
>>
>>>>>>> get_freq is a bit expensive as it has to walk the clock tree to 
>>>>>>> find
>>>>>>> the clock frequency (at least the first time?). just wondering if
>>>>>>> there is lighter alternative here?
>>>>>>>
>>>>>> How about get_clock? Doesn't read the registers at least.
>>>>> Said API needs, some flags to be passed,
>>>>>
>>>>> Can those flag be set to zero, Chandru ?
>>>>
>>>> get_clock doesn't require any flags to be passed.
>>>
>>> May be firmware does not need it but  I was referring to
>>>
>>> https://elixir.bootlin.com/linux/latest/source/drivers/clk/keystone/sci-clk.c#L78 
>>>
>> Just took a look,
>>
>> I now understand the reason for confusion,
>>
>> #define TI_SCI_MSG_SET_CLOCK_STATE    0x0100
>> #define TI_SCI_MSG_GET_CLOCK_STATE    0x0101
>>
>> cops->get_clock = ti_sci_cmd_get_clock;  --> refers to
>> TI_SCI_MSG_SET_CLOCK_STATE
>> That's why we are passing the flag from linux for get_clock
>>
>> Linux is using terminology of get/put.
>>
>> As Chandru pointed, we don't have to pass flags, cause he is refering
>> to TI_SCI_MSG_GET_CLOCK_STATE
>>
>> Below functions passes TI_SCI_MSG_GET_CLOCK_STATE to DM, which is what
>> we actually want.
>> cops->is_auto = ti_sci_cmd_clk_is_auto;
>> cops->is_on = ti_sci_cmd_clk_is_on;
>> cops->is_off = ti_sci_cmd_clk_is_off;
>
>
> I think calling ti_sci_cmd_clk_is_auto should be good . other 
> functions needs current state and requested state.
>
> Chandru ?
>

ti_sci_cmd_clk_is_auto is internal function to linux.
For TI_SCI_MSG_GET_CLOCK_STATE, linux only needs to pass pointers to the 
variables where result will be stored.


>>
>> Which should be safe to call, Chandru can confirm.
>>
>> Regards,
>> Kamlesh
>>>
>>>
>>>>
>>>>>
>>>>>> Regards,
>>>>>> Kamlesh

