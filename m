Return-Path: <linux-kernel+bounces-5804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 04C6C818FB3
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 19:21:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EC2C1F2320B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 18:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 815E137D29;
	Tue, 19 Dec 2023 18:20:59 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A8439860;
	Tue, 19 Dec 2023 18:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from [192.168.1.104] (178.176.72.19) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Tue, 19 Dec
 2023 21:20:47 +0300
Subject: Re: [PATCH net-next v2 09/21] net: ravb: Split GTI computation and
 set operations
To: claudiu beznea <claudiu.beznea@tuxon.dev>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<richardcochran@gmail.com>, <p.zabel@pengutronix.de>,
	<yoshihiro.shimoda.uh@renesas.com>, <wsa+renesas@sang-engineering.com>,
	<geert+renesas@glider.be>
CC: <netdev@vger.kernel.org>, <linux-renesas-soc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Claudiu Beznea
	<claudiu.beznea.uj@bp.renesas.com>
References: <20231214114600.2451162-1-claudiu.beznea.uj@bp.renesas.com>
 <20231214114600.2451162-10-claudiu.beznea.uj@bp.renesas.com>
 <3e8f65e3-3aab-ddf4-2b05-16b275af6021@omp.ru>
 <53c90a2a-c43b-40e7-a9b2-55aab55541d7@tuxon.dev>
From: Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <154d6a86-d2d3-afae-a604-aa8fecb63f23@omp.ru>
Date: Tue, 19 Dec 2023 21:20:46 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <53c90a2a-c43b-40e7-a9b2-55aab55541d7@tuxon.dev>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.1.0, Database issued on: 12/19/2023 17:56:33
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 182235 [Dec 19 2023]
X-KSE-AntiSpam-Info: Version: 6.1.0.3
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 7 0.3.7 6d6bf5bd8eea7373134f756a2fd73e9456bb7d1a
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info:
	178.176.72.19:7.7.3,7.4.1;omp.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2
X-KSE-AntiSpam-Info: {cloud_iprep_silent}
X-KSE-AntiSpam-Info: ApMailHostAddress: 178.176.72.19
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 12/19/2023 18:00:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 12/19/2023 3:42:00 PM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

On 12/17/23 3:40 PM, claudiu beznea wrote:

[...]
>>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>>
>>> ravb_set_gti() was computing the value of GTI based on the reference clock
>>> rate and then applied it to register. This was done on the driver's probe
>>> function. In order to implement runtime PM for all IP variants (as some IP
>>> variants switches to reset operation mode (and thus the register's content
>>
>>    Again, operating mode...
>>
>>> is lost) when module standby is configured through clock APIs) the GTI was
>>
>>    The GTI what? Setup?
>>
>>> split in 2 parts: one computing the value of the GTI register (done in the
>>> driver's probe function) and one applying the computed value to register
>>> (done in the driver's ndo_open API).
>>>
>>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>> [...]
>>
>>> diff --git a/drivers/net/ethernet/renesas/ravb.h b/drivers/net/ethernet/renesas/ravb.h
>>> index e0f8276cffed..76202395b68d 100644
>>> --- a/drivers/net/ethernet/renesas/ravb.h
>>> +++ b/drivers/net/ethernet/renesas/ravb.h
>>> @@ -1106,6 +1106,8 @@ struct ravb_private {
>>>  
>>>  	const struct ravb_hw_info *info;
>>>  	struct reset_control *rstc;
>>> +
>>> +	uint64_t gti_tiv;
>>
>>    Please use the kernel type, u64; uint64_t is for userland, IIRC.
> 
> I just kept the initial type here.

   Oops, that type slipped in while I wasn't yet a reviewer. :-/

> Anyway, uint64_t should translate to u64 AFAICT.

   Yes.

> Looking at it again the field here is enough to be 32 bit as the register
> field is no longer than that. It is needed on 64 bits when checking the
> ranges in compute function.

   Indeed. The actual GTI.TIV field is even 28-bit wide only...

[...]
>>> diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
>>> index d7f6e8ea8e79..5e01e03e1b43 100644
>>> --- a/drivers/net/ethernet/renesas/ravb_main.c
>>> +++ b/drivers/net/ethernet/renesas/ravb_main.c
>>> @@ -1750,6 +1750,51 @@ static int ravb_set_reset_mode(struct net_device *ndev)
>>>  	return error;
>>>  }
>>>  
>>> +static int ravb_set_gti(struct net_device *ndev)
>>> +{
>> [...]
>>> +	/* Request GTI loading */
>>> +	ravb_modify(ndev, GCCR, GCCR_LTI, GCCR_LTI);
>>> +
>>> +	/* Check completion status. */
>>> +	return ravb_wait(ndev, GCCR, GCCR_LTI, 0);
>>
>>    Is this really necessary?
> 
> I've just updated it to respect the manual specifications. Please let me
> know if you want me to drop it. For this series it should be harmless
> keeping it as it was previously (I will double check it).

   Looks like you'll have to frop the fix patch #2, so this ravb_wait()
call shouldn't be placed here as well...

>> [...]
>>> @@ -1767,6 +1812,10 @@ static int ravb_open(struct net_device *ndev)
>>>  		goto out_napi_off;
>>>  	ravb_emac_init(ndev);
>>>  
>>> +	error = ravb_set_gti(ndev);
>>> +	if (error)
>>> +		goto out_dma_stop;
>>> +
>>
>>    Hm... belongs in ravb_dmac_init() now, as it seems... 
> 
> Isn't it PTP specific?

   I just had an impression it belonged to the AVB-DMAC register range
but perhaps I'm wrong...

[...]

MBR, Sergey

