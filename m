Return-Path: <linux-kernel+bounces-25524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B5BFE82D1D3
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 19:08:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 564BDB212A5
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 18:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77CF1107A6;
	Sun, 14 Jan 2024 18:08:07 +0000 (UTC)
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29BE3EAF4;
	Sun, 14 Jan 2024 18:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from [192.168.1.105] (31.173.83.169) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Sun, 14 Jan
 2024 21:07:52 +0300
Subject: Re: [PATCH net-next v3 08/19] net: ravb: Move the IRQs get and
 request in the probe function
To: claudiu beznea <claudiu.beznea@tuxon.dev>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<richardcochran@gmail.com>, <p.zabel@pengutronix.de>,
	<yoshihiro.shimoda.uh@renesas.com>, <wsa+renesas@sang-engineering.com>
CC: <netdev@vger.kernel.org>, <linux-renesas-soc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <geert+renesas@glider.be>, Claudiu Beznea
	<claudiu.beznea.uj@bp.renesas.com>
References: <20240105082339.1468817-1-claudiu.beznea.uj@bp.renesas.com>
 <20240105082339.1468817-9-claudiu.beznea.uj@bp.renesas.com>
 <02548b1b-d32c-78b1-f1b6-5fdb505d31bb@omp.ru>
 <ee783b61-95fc-44ab-a311-0ca7d058ac39@tuxon.dev>
 <dce944a1-9557-9ab0-d30d-7a51a47c6d96@omp.ru>
 <3e430f8e-b327-485f-ae19-6f1938083dd3@tuxon.dev>
From: Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <0ef3553a-9a7d-d93a-7920-0bd4aa49e5cb@omp.ru>
Date: Sun, 14 Jan 2024 21:07:51 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <3e430f8e-b327-485f-ae19-6f1938083dd3@tuxon.dev>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.1.0, Database issued on: 01/14/2024 17:51:39
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 59
X-KSE-AntiSpam-Info: Lua profiles 182622 [Jan 14 2024]
X-KSE-AntiSpam-Info: Version: 6.1.0.3
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 7 0.3.7 6d6bf5bd8eea7373134f756a2fd73e9456bb7d1a
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {relay has no DNS name}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: {Found in DNSBL: 31.173.83.169 in (user)
 b.barracudacentral.org}
X-KSE-AntiSpam-Info:
	d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;omp.ru:7.1.1;127.0.0.199:7.1.2
X-KSE-AntiSpam-Info: ApMailHostAddress: 31.173.83.169
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 59
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 01/14/2024 17:56:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 1/14/2024 4:54:00 PM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

On 1/10/24 2:55 PM, claudiu beznea wrote:

[...]

>>>>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>>>>
>>>>> The runtime PM implementation will disable clocks at the end of
>>>>> ravb_probe(). As some IP variants switch to reset mode as a result of
>>>>> setting module standby through clock disable APIs, to implement runtime PM
>>>>> the resource parsing and requesting are moved in the probe function and IP
>>>>> settings are moved in the open function. This is done because at the end of
>>>>> the probe some IP variants will switch anyway to reset mode and the
>>>>> registers content is lost. Also keeping only register specific operations
>>>>> in the ravb_open()/ravb_close() functions will make them faster.
>>>>>
>>>>> Commit moves IRQ requests to ravb_probe() to have all the IRQs ready when
>>>>> the interface is open. As now IRQs gets and requests are in a single place
>>>>> there is no need to keep intermediary data (like ravb_rx_irqs[] and
>>>>> ravb_tx_irqs[] arrays or IRQs in struct ravb_private).
>>>>
>>>>    There's one thing that you probably didn't take into account: after
>>>> you call request_irq(), you should be able to handle your IRQ as it's
>>>> automatically unmasked, unless you pass IRQF_NO_AUTOEN to request_irq().
>>>> Your device may be held i reset or even powered off but if you pass
>>>> IRQF_SHARED to request_irq() (you do in a single IRQ config), you must
>>>> be prepared to get your device's registers read (in order to ascertain
>>
>>    And, at least on arm32, reading a powered off (or not clocked?) device's
>> register causes an imprecise external abort exception -- which results in a
>> kernel oops...
>>
>>>> whether it's your IRQ or not). And you can't even pass IRQF_NO_AUTOEN
>>>> along with IRQF_SHARED, according to my reading of the IRQ code...
>>>
>>> Good point!

   Iff we can come up with a robust check whether the device is powered on,
we can overcome even the IRQF_SHARED issue though...
   I'm seeing pm_runtime_active() API and wondering whether we can use it
from the IRQ context. Alternatively, we can add a is_opened flag, like
sh_eth.c does...

>>>>> This is a preparatory change to add runtime PM support for all IP variants.
>>>>
>>>>   I don't readily see why this is necessary for the full-fledged RPM
>>>> support...
>>>
>>> I tried to speed up the ravb_open()/ravb_close() but missed the IRQF_SHARED
>>
>>    I doubt that optimizing ravb_{open,close}() is worth pursuing, frankly...

   OTOH, we'll get a simpler/cleaner code if we do this...
   Previously, I was under an impression that it's common behavior of
the networking drivers to call request_irq() from their ndo_open() methods.
Apparently, it's not true anymore (probably with the introduction of the
managed device API) -- the newer drivers often call devm_request_irq()
from their probe() methods instead...

>>> IRQ. As there is only one IRQ requested w/ IRQF_SHARED, are you OK with
>>> still keeping the rest of IRQs handled as proposed by this patch?
>>
>>    I'm not, as this doesn't really seem necessary for your main goal.
>> It's not clear in what state U-Boot leaves EtherAVB...

   This still seems an issue though... My prior experience with the R-Car
MMC driver tells me that U-Boot may leave interrupts enabled... :-/

> Ok. One other reason I did this is, as commit message states, to keep
> resource parsing and allocation/freeing in probe/remove and hardware
> settings in open/close.
>  
> Anyway, I'll revert all the changes IRQ related.

   Now I've changed my mind -- let's retain your patch! It needs some work
though...

> Thank you,
> Claudiu Beznea

[...]

MBR, Sergey

