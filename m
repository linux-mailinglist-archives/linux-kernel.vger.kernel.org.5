Return-Path: <linux-kernel+bounces-55975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FDCC84C46B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 06:34:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A410C289DDD
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 05:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91A5A14AB2;
	Wed,  7 Feb 2024 05:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="xjNkYLLQ"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFDAE1CD1E;
	Wed,  7 Feb 2024 05:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707284073; cv=none; b=rqetDIjJKkujzX8FeERE9iKfHMOC/yIJG+rWDsG7/oMwOKOXY8qh3va0cXu3X2bET9R4Ia0cvbe6ZQCQv944SvTEPElsN49FAidcNf8vN2CJ5gUpXL5TJhRxrR/QhuAqkNgx0DyYJBb8xd3mkTqNCIdna4r2KenVglwwaXUFH+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707284073; c=relaxed/simple;
	bh=/vwFyEuN+SciqLKd3L2Vv0FZcwpX+FovUMX7WH9gDf0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=jPNxNl5YEkI4XqonznXJlq8EBmEatKXqcdIGmvFH6H7nJEfmPj8zoj0vXwy+st1j2MbUg1P/IjIXVrCtJ8Udg+If16FIsrh/H7yb1tBoJTMO5YIj0FfKpTF67qHT7s55dubs2Pdx8CNu9QfMRspXDYoO9EujBWM1BdPC40K0cCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=xjNkYLLQ; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4175Y6aa067259;
	Tue, 6 Feb 2024 23:34:06 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707284046;
	bh=iRmefxTu3nU+jSjCWHu54KxXXwApbQgyUthBZ1sSZHs=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=xjNkYLLQH4kg5BXxsb9vfbrUNI7/xn/sNjgCqjm0kwXbC7NcbjBjWrBRR+LUqpCl4
	 547nvaNdml+hCKYfkyLYZ9eMQK1FbIOHgg04e58sM4qInRwG1yp1t3Wf/2h3zLtm47
	 6UOwzJkDFyc1SOs1f/h57h2GMYT1NK1Q7Q/LP6cA=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4175Y53p120442
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 6 Feb 2024 23:34:06 -0600
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 6
 Feb 2024 23:34:05 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 6 Feb 2024 23:34:05 -0600
Received: from [172.24.20.156] (lt5cd2489kgj.dhcp.ti.com [172.24.20.156])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4175XrFZ073161;
	Tue, 6 Feb 2024 23:33:55 -0600
Message-ID: <e2ea03ce-0367-413b-aca9-7c1fabda173a@ti.com>
Date: Wed, 7 Feb 2024 11:03:52 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] clk: keystone: sci-clk: Adding support for non
 contiguous clocks
To: Kamlesh Gurudasani <kamlesh@ti.com>, CHANDRU DHAVAMANI <chandru@ti.com>,
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
Content-Language: en-US
From: "Kumar, Udit" <u-kumar1@ti.com>
In-Reply-To: <87ttmly4fa.fsf@kamlesh.i-did-not-set--mail-host-address--so-tickle-me>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180


On 2/6/2024 9:24 PM, Kamlesh Gurudasani wrote:
> "Kumar, Udit" <u-kumar1@ti.com> writes:
>
>>>>>> get_freq is a bit expensive as it has to walk the clock tree to find
>>>>>> the clock frequency (at least the first time?). just wondering if
>>>>>> there is lighter alternative here?
>>>>>>
>>>>> How about get_clock? Doesn't read the registers at least.
>>>> Said API needs, some flags to be passed,
>>>>
>>>> Can those flag be set to zero, Chandru ?
>>>
>>> get_clock doesn't require any flags to be passed.
>>
>> May be firmware does not need it but  I was referring to
>>
>> https://elixir.bootlin.com/linux/latest/source/drivers/clk/keystone/sci-clk.c#L78
> Just took a look,
>
> I now understand the reason for confusion,
>
> #define TI_SCI_MSG_SET_CLOCK_STATE	0x0100
> #define TI_SCI_MSG_GET_CLOCK_STATE	0x0101
>
> cops->get_clock = ti_sci_cmd_get_clock;  --> refers to
> TI_SCI_MSG_SET_CLOCK_STATE
> That's why we are passing the flag from linux for get_clock
>
> Linux is using terminology of get/put.
>
> As Chandru pointed, we don't have to pass flags, cause he is refering
> to TI_SCI_MSG_GET_CLOCK_STATE
>
> Below functions passes TI_SCI_MSG_GET_CLOCK_STATE to DM, which is what
> we actually want.
> cops->is_auto = ti_sci_cmd_clk_is_auto;
> cops->is_on = ti_sci_cmd_clk_is_on;
> cops->is_off = ti_sci_cmd_clk_is_off;


I think calling ti_sci_cmd_clk_is_auto should be good . other functions 
needs current state and requested state.

Chandru ?

>
> Which should be safe to call, Chandru can confirm.
>
> Regards,
> Kamlesh
>>
>>
>>>
>>>>
>>>>> Regards,
>>>>> Kamlesh

