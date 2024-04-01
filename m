Return-Path: <linux-kernel+bounces-127204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 524F18947F5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 01:50:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F129E1F241AB
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 23:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 837F257315;
	Mon,  1 Apr 2024 23:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="AbgKql0u"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A482A1BF;
	Mon,  1 Apr 2024 23:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712015443; cv=none; b=EQePA9QOH1nCkEH80jzM4gZBDGpaZ5rkkV1njbtc7i50C4vkAA6LIALHpadvi8g+t+r6ZNnXtPZWrwkKk1TLG8RjE8pA9ADvshTJlQV/IyirtMSo+Y+4+XjTB7xdrKkN1Nn+EgnJJJXjQEddc6X7EXnam/7gXrSse0JRSjwUygk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712015443; c=relaxed/simple;
	bh=gC3y51smFQte+vpAUum3ZwOj1MUe7sBXkuCwpfUK7Pw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=q8Ds4FOeotaBXDl6YYah8pTMppeF7E1ztATsKXJlP2qH683qwy7BpyVYZHNSQNwdIl6F9bY45xfjEDigXaKcT3nZ3qNFWXnGGCrMvm1gKXo+/2odp6C2xr3zgwT/1BZA9Z6cppR0BgNXRKmRxLdJOx7KHHwzqXRaznKzxEmqlp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=AbgKql0u; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 431NobTl104499;
	Mon, 1 Apr 2024 18:50:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1712015437;
	bh=gC3y51smFQte+vpAUum3ZwOj1MUe7sBXkuCwpfUK7Pw=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=AbgKql0ukID+o8z/3tOLazD9/Q0mUbUR1zry7T/uKGONvtx9P6iUODZRXwyk7/M74
	 SQ9AG2zQ2yotPuXsG7thUM8/SOpAZx+2A9u7Gl6U7thVwPLd9v/A507+Ie/K2aKpKe
	 P6SkO1Vy5jh29H8rAY8KeAR2uE6yDAn/yN+QwAYs=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 431Nob62095778
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 1 Apr 2024 18:50:37 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 1
 Apr 2024 18:50:37 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 1 Apr 2024 18:50:37 -0500
Received: from [10.249.42.149] ([10.249.42.149])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 431NobFt082588;
	Mon, 1 Apr 2024 18:50:37 -0500
Message-ID: <e172edd3-824b-4ee4-b650-be1a8b9286fd@ti.com>
Date: Mon, 1 Apr 2024 18:50:37 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/13] mailbox: omap: Remove kernel FIFO message queuing
To: Hari Nagalla <hnagalla@ti.com>, Jassi Brar <jassisinghbrar@gmail.com>,
        Nick Saulnier <nsaulnier@ti.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
CC: <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240325172045.113047-1-afd@ti.com>
 <20240325172045.113047-14-afd@ti.com>
 <761aa56f-55c4-e0d4-9f75-eef8035aa25b@ti.com>
Content-Language: en-US
From: Andrew Davis <afd@ti.com>
In-Reply-To: <761aa56f-55c4-e0d4-9f75-eef8035aa25b@ti.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On 4/1/24 6:39 PM, Hari Nagalla wrote:
> On 3/25/24 12:20, Andrew Davis wrote:
>> The kernel FIFO queue has a couple issues. The biggest issue is that
>> it causes extra latency in a path that can be used in real-time tasks,
>> such as communication with real-time remote processors.
>>
>> The whole FIFO idea itself looks to be a leftover from before the
>> unified mailbox framework. The current mailbox framework expects
>> mbox_chan_received_data() to be called with data immediately as it
>> arrives. Remove the FIFO and pass the messages to the mailbox
>> framework directly.
> Yes, this would definitely speed up the message receive path. With RT linux, the irq runs in thread context, so that is Ok. But with non-RT the whole receive path runs in interrupt context. So, i think it would be appropriate to use a threaded_irq()?

I was thinking the same at first, but seems some mailbox drivers use threaded, others
use non-threaded context. Since all we do in the IRQ context anymore is call
mbox_chan_received_data(), which is supposed to be IRQ safe, then it should be fine
either way. So for now I just kept this using the regular IRQ context as before.

If that does turn out to be an issue then let's switch to threaded.

Andrew

