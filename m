Return-Path: <linux-kernel+bounces-56097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2318284C5ED
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 09:06:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDB6F286F7B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 08:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37493200BD;
	Wed,  7 Feb 2024 08:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="k7g2xvuH"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B87200A4;
	Wed,  7 Feb 2024 08:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707293181; cv=none; b=IYp62c6+iDggEKt7Z/Y027PPaoZuuYyUr1+jYgkqfDm15CulDL+zbAAWiwT9Usf0KR4AG2YADqj0TfT3vN6lBn/z/5KzeIhfZZMQ/8ajH/HaZ332iPpJrXGiKWZSOZk7KUVljP7rbfeXlc1rcXhQ9C08ElXAkjklsE8Re9tGEfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707293181; c=relaxed/simple;
	bh=0akLjgta1i5BwmXhrQQ86/PzQcGvJya4mfnU7574Grw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=WmXCCo9dHyid5BTRS/HJZ83O3dcwClp/zUPmesn5/cREVhp35SKVa3X8BwoNvt7j2nWdtZwDoTuaxqOrmjq99deXRRYFcVAASTOX9mVRJiNaDw582YcdoPnHHYf6s6IR29ZYXZJCsIvicXaEICrKxfQd4CgJfCCN5jnp/9LnM9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=k7g2xvuH; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41786AmG111110;
	Wed, 7 Feb 2024 02:06:10 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707293170;
	bh=cYHxqfbAMZy5YcllbR7IzjQ6cA/xPUZllesIYQkr87I=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=k7g2xvuHASWzgVNETsP3hMuXhzzgmzJO8I33XXDvEEjZnj2aymFkitTZCfxHjIKGp
	 NO2E5gZ+v4FmI4/Irc+5QXBxAJz+gwyOHUZhssCe3MBYseGElRVbMZANuEobf67J+D
	 OH72v657HWUi92w9N9H5MmbnOjjAjFxIrl2K49KU=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41786Ahi008231
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 7 Feb 2024 02:06:10 -0600
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 7
 Feb 2024 02:06:10 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 7 Feb 2024 02:06:10 -0600
Received: from [10.24.69.14] (chandru.dhcp.ti.com [10.24.69.14])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 417866mQ072127;
	Wed, 7 Feb 2024 02:06:06 -0600
Message-ID: <5f54ee18-b3df-4918-9d5e-b765a6714ea2@ti.com>
Date: Wed, 7 Feb 2024 13:36:05 +0530
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
        Nishanth Menon <nm@ti.com>, <vishalm@ti.com>
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
 <4398af20-3396-4a5c-8fcb-a7b3d0d6f15b@ti.com>
 <978c8110-3083-4fc2-a348-d7f97fd7839c@ti.com>
From: CHANDRU DHAVAMANI <chandru@ti.com>
In-Reply-To: <978c8110-3083-4fc2-a348-d7f97fd7839c@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180


On 07/02/24 13:03, Kumar, Udit wrote:
>
> On 2/7/2024 12:53 PM, CHANDRU DHAVAMANI wrote:
>>
>> On 07/02/24 11:03, Kumar, Udit wrote:
>>>
>>> On 2/6/2024 9:24 PM, Kamlesh Gurudasani wrote:
>>>> "Kumar, Udit" <u-kumar1@ti.com> writes:
>>>>
>>>>>>>>> get_freq is a bit expensive as it has to walk the clock tree 
>>>>>>>>> to find
>>>>>>>>> the clock frequency (at least the first time?). just wondering if
>>>>>>>>> there is lighter alternative here?
>>>>>>>>>
>>>>>>>> How about get_clock? Doesn't read the registers at least.
>>>>>>> Said API needs, some flags to be passed,
>>>>>>>
>>>>>>> Can those flag be set to zero, Chandru ?
>>>>>>
>>>>>> get_clock doesn't require any flags to be passed.
>>>>>
>>>>> May be firmware does not need it but  I was referring to
>>>>>
>>>>> https://elixir.bootlin.com/linux/latest/source/drivers/clk/keystone/sci-clk.c#L78 
>>>>>
>>>> Just took a look,
>>>>
>>>> I now understand the reason for confusion,
>>>>
>>>> #define TI_SCI_MSG_SET_CLOCK_STATE    0x0100
>>>> #define TI_SCI_MSG_GET_CLOCK_STATE    0x0101
>>>>
>>>> cops->get_clock = ti_sci_cmd_get_clock;  --> refers to
>>>> TI_SCI_MSG_SET_CLOCK_STATE
>>>> That's why we are passing the flag from linux for get_clock
>>>>
>>>> Linux is using terminology of get/put.
>>>>
>>>> As Chandru pointed, we don't have to pass flags, cause he is refering
>>>> to TI_SCI_MSG_GET_CLOCK_STATE
>>>>
>>>> Below functions passes TI_SCI_MSG_GET_CLOCK_STATE to DM, which is what
>>>> we actually want.
>>>> cops->is_auto = ti_sci_cmd_clk_is_auto;
>>>> cops->is_on = ti_sci_cmd_clk_is_on;
>>>> cops->is_off = ti_sci_cmd_clk_is_off;
>>>
>>>
>>> I think calling ti_sci_cmd_clk_is_auto should be good . other 
>>> functions needs current state and requested state.
>>>
>>> Chandru ?
>>>
>>
>> ti_sci_cmd_clk_is_auto is internal function to linux.
>> For TI_SCI_MSG_GET_CLOCK_STATE, linux only needs to pass pointers to 
>> the variables where result will be stored.
>
>
> Yes this internal function calls TI_SCI_MSG_GET_CLOCK_STATE
>

Okay. We can use TI_SCI_MSG_GET_CLOCK_STATE to check to if clock is 
valid or not.


>
>>
>>
>>>>
>>>> Which should be safe to call, Chandru can confirm.
>>>>
>>>> Regards,
>>>> Kamlesh
>>>>>
>>>>>
>>>>>>
>>>>>>>
>>>>>>>> Regards,
>>>>>>>> Kamlesh

