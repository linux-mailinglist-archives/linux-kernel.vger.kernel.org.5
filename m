Return-Path: <linux-kernel+bounces-55110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 005BF84B7D9
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 15:27:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 858FA1F26D8A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 14:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDDA8132C1E;
	Tue,  6 Feb 2024 14:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="NcbB0qq6"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4676A132C17;
	Tue,  6 Feb 2024 14:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707229604; cv=none; b=YBd8ywQMqQ/QtkWiYlOerC3tfHuiJ7Jx4fjK103HszFNsahQZnwF23DFaZwQNzmdpH3t6lMyLzntjQiTQY8XoSI2+ESnpnyMslIzwfKso3yK9J231SdaVGCSQPtJvUq8NFDAjndrFy8zjqu52+dzJ5CCNCtpNmjyzklqFa0rae0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707229604; c=relaxed/simple;
	bh=UX150K6XObyFbEcXUrojgx5zkcHzyVXDC9FA4xQ0Bgk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=mBZmhNjCv500XKtIpDrcMrF3mtpr3vGd8dwTgXbt0mtMv9M3oRIjnwVK4BAk7dsgIgWhWbQXGI5mQBLm/3zOW+83vEN6R5WjO8Qf2lT9UO1+NpU2yVErIHqDJqEoaqtuT30hiC2w4B38j/46ig5H+at3DktQeUZl+qEe7hfHzkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=NcbB0qq6; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 416EQZjx046188;
	Tue, 6 Feb 2024 08:26:35 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707229595;
	bh=MwJ30/bw+pkd0WzAspzpQ+DwdhN3FJqhFcO85PhK8f0=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=NcbB0qq6ABT7as00rZgOd0hRxrscr1DrWJHA1I/JjPTRN2DNavZ+adu6r/BSWDQKU
	 gKnMg16D1Zdfz7x4ldWPnjr16TpkqOntBuASNDCzlbdHHg96e8MubZbQvkqSPml5s0
	 Av9Jpwm4QpxZVi2sKIAo44sh1HdSfqTCZu7OByHo=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 416EQZeK077693
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 6 Feb 2024 08:26:35 -0600
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 6
 Feb 2024 08:26:35 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 6 Feb 2024 08:26:35 -0600
Received: from [10.24.69.14] (chandru.dhcp.ti.com [10.24.69.14])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 416EQVlE008028;
	Tue, 6 Feb 2024 08:26:32 -0600
Message-ID: <c2b7f22d-f07d-4cac-8a01-af7b014e7ff4@ti.com>
Date: Tue, 6 Feb 2024 19:56:30 +0530
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
From: CHANDRU DHAVAMANI <chandru@ti.com>
In-Reply-To: <c5b6bd1d-dbb4-4bfb-8b3e-9b0733e2ba5d@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180


On 06/02/24 19:45, Kumar, Udit wrote:
>
> On 2/6/2024 7:24 PM, Kamlesh Gurudasani wrote:
>> Nishanth Menon <nm@ti.com> writes:
>>
>>> On 16:13-20240206, Udit Kumar wrote:
>>>> Most of clocks and their parents are defined in contiguous range,
>>>> But in few cases, there is gap in clock numbers[0].
>>>> Driver assumes clocks to be in contiguous range, and add their clock
>>>> ids incrementally.
>>>>
>>>> New firmware started returning error while calling get_freq and is_on
>>>> API for non-available clock ids.
>>>>
>>>> In this fix, driver checks and adds only valid clock ids.
>>>>
>>>> Fixes: 3c13933c6033 ("clk: keystone: sci-clk: add support for 
>>>> dynamically probing clocks")
>>>>
>>>> [0] 
>>>> https://software-dl.ti.com/tisci/esd/latest/5_soc_doc/j7200/clocks.html 
>>>>
>>>> Section Clocks for NAVSS0_CPTS_0 Device,
>>>> clock id 12-15 not present.
>>>>
>>>> Signed-off-by: Udit Kumar <u-kumar1@ti.com>
>>>>                   while (num_parents--) {
>>>> +                    /* Check if this clock id is valid */
>>>> +                    ret = provider->ops->get_freq(provider->sci,
>>>> +                        sci_clk->dev_id, clk_id, &freq);
>>> get_freq is a bit expensive as it has to walk the clock tree to find
>>> the clock frequency (at least the first time?). just wondering if
>>> there is lighter alternative here?
>>>
>> How about get_clock? Doesn't read the registers at least.
>
> Said API needs, some flags to be passed,
>
> Can those flag be set to zero, Chandru ?


get_clock doesn't require any flags to be passed.


>
>
>> Regards,
>> Kamlesh

