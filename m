Return-Path: <linux-kernel+bounces-45098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD918842BB4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 19:23:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F05CD1C24A25
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 18:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEEDC157E74;
	Tue, 30 Jan 2024 18:23:05 +0000 (UTC)
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EDDC15696D;
	Tue, 30 Jan 2024 18:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706638985; cv=none; b=PxGa2nnejFr9QzTk5ivYAPTzaBtCPlVPiokZvXYhmSuaaJu1LG5H8rCQByCqG7dWEUqc35JOtkRQdljS/Ff/AQr52gwOE+MCZdDLmGhmImBcSNgFxiGQ/oYM1C2UfKVsXidDz7LFWdgYiFgMMXPKWKGu0VbiEz5+o9SMdRUFkWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706638985; c=relaxed/simple;
	bh=7WQHyByr3bWwXliRpuJSVJb6fnBv4p9vOXnA1S0acDg=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Ej6+74BquawyGEahZbz8LkxmjkHLlIyKTdb/4ViEix4sG2WXLhw8bg+17wx2omj2Jx8mokO45CP6R7VZ9XWYdgtJGrJ7ixsOBVU4e4HlncaApJU8R7d7Z/X6bnq9PB9a3zgsqNDVnP1isyeaqRMiBb5Knl0/9r/dXbc58xQuxmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from [192.168.1.105] (178.176.75.73) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Tue, 30 Jan
 2024 21:22:49 +0300
Subject: Re: [PATCH net-next v4 07/15] net: ravb: Move reference clock
 enable/disable on runtime PM APIs
To: claudiu beznea <claudiu.beznea@tuxon.dev>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<richardcochran@gmail.com>, <p.zabel@pengutronix.de>,
	<geert+renesas@glider.be>
CC: <netdev@vger.kernel.org>, <linux-renesas-soc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Claudiu Beznea
	<claudiu.beznea.uj@bp.renesas.com>
References: <20240123125829.3970325-1-claudiu.beznea.uj@bp.renesas.com>
 <20240123125829.3970325-8-claudiu.beznea.uj@bp.renesas.com>
 <ec3f5d8a-ac38-1134-93a3-c4ceb8b944e0@omp.ru>
 <6307da2b-aadf-4cd7-85e3-3032153544b5@tuxon.dev>
From: Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <9a6b25e5-af9f-2ee9-c587-d67fe49525b1@omp.ru>
Date: Tue, 30 Jan 2024 21:22:49 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <6307da2b-aadf-4cd7-85e3-3032153544b5@tuxon.dev>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.1.0, Database issued on: 01/30/2024 17:18:56
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 59
X-KSE-AntiSpam-Info: Lua profiles 183058 [Jan 30 2024]
X-KSE-AntiSpam-Info: Version: 6.1.0.3
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 7 0.3.7 6d6bf5bd8eea7373134f756a2fd73e9456bb7d1a
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_uf_ne_domains}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {relay has no DNS name}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: {Found in DNSBL: 178.176.75.73 in (user)
 dbl.spamhaus.org}
X-KSE-AntiSpam-Info:
	git.kernel.org:7.1.1;omp.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2
X-KSE-AntiSpam-Info: ApMailHostAddress: 178.176.75.73
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 59
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 01/30/2024 17:23:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 1/30/2024 2:18:00 PM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

On 1/29/24 4:53 PM, claudiu beznea wrote:

[...]

>>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>>
>>> Reference clock could be or not part of the power domain. If it is part of
>>
>>    Could be or not be, perhaps?
>>
>>> the power domain, the power domain takes care of propertly setting it. In
>>
>>    Properly. :-)
>>
>>> case it is not part of the power domain and full runtime PM support is
>>> available in driver the clock will not be propertly disabled/enabled at
>>> runtime. For this, keep the prepare/unprepare operations in the driver's
>>> probe()/remove() functions and move the enable/disable in runtime PM
>>> functions.
>>>
>>> Along with it, the other clock request operations were moved close to
>>> reference clock request and prepare to have all the clock requests
>>> specific code grouped together.
>>>
>>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>> [...]
>>
>>> diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
>>> index 9fc0e39e33c2..4673cc2faec0 100644
>>> --- a/drivers/net/ethernet/renesas/ravb_main.c
>>> +++ b/drivers/net/ethernet/renesas/ravb_main.c
>> [...]
>>> @@ -3060,21 +3058,27 @@ static int ravb_resume(struct device *dev)
>>>  	return ret;
>>>  }
>>>  
>>> -static int ravb_runtime_nop(struct device *dev)
>>> +static int ravb_runtime_suspend(struct device *dev)
>>>  {
>>> -	/* Runtime PM callback shared between ->runtime_suspend()
>>> -	 * and ->runtime_resume(). Simply returns success.
>>> -	 *
>>> -	 * This driver re-initializes all registers after
>>> -	 * pm_runtime_get_sync() anyway so there is no need
>>> -	 * to save and restore registers here.
>>> -	 */
>>
>>    I want to pull out the dummy {ravb|sh_eth}_runtime_nop() funcs --
>> they don't seem to be necessary... Then we can implement your clock

   The need to have the dummy RPM suspend/resume methods is gone since:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=63d00be69348fda431ae59aba6af268a5cf5058e

>> dance with freshly added ravb_runtime_{suspend|resume}()...
> 
> For this series, does it worth having a patch that removes ravb runtime
> suspend/resume ops to then add a new patch that add it it again?

    Probably not, indeed... I just wanted to have 2 symmetric patches
for sh_eth and ravb removing the dummy methods...

> I can do it but it I see no reason in doing it in this series...
> 
> The dummy functions were there and the commit description explains the
> reason they were updated.

   Yet you don't say a word about the big comment in ravb_runtime_nop()
that you remove. This comment doesn't really make much sense as this
driver currently has the RPM calls and ndo_{open|stop}() methods decoupled...
This stuff was copied from sh_eth.c verbatim -- I clearly overlooked it when
prepping this driver for upstream... :-<
   You can keep this patch as is (but not its description!) or have a separate
patch that removes just the big comment not making much sense, both options
would be fine by me. I will take care of sh_eth.c myself (not really sure
whether you have targets having this IP)...

> Thank you,
> Claudiu Beznea

MBR, Sergey

