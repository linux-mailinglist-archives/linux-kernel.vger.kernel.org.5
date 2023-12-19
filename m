Return-Path: <linux-kernel+bounces-5833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5118C819001
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 19:55:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9229B23C9D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 18:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9629E38F8A;
	Tue, 19 Dec 2023 18:55:03 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55CA038FA7;
	Tue, 19 Dec 2023 18:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from [192.168.1.104] (178.176.72.19) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Tue, 19 Dec
 2023 21:54:50 +0300
Subject: Re: [PATCH net-next v2 11/21] net: ravb: Move DBAT configuration to
 the driver's ndo_open API
To: claudiu beznea <claudiu.beznea@tuxon.dev>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<richardcochran@gmail.com>, <p.zabel@pengutronix.de>,
	<yoshihiro.shimoda.uh@renesas.com>, <wsa+renesas@sang-engineering.com>,
	<geert+renesas@glider.be>
CC: <netdev@vger.kernel.org>, <linux-renesas-soc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Claudiu Beznea
	<claudiu.beznea.uj@bp.renesas.com>
References: <20231214114600.2451162-1-claudiu.beznea.uj@bp.renesas.com>
 <20231214114600.2451162-12-claudiu.beznea.uj@bp.renesas.com>
 <a93c0673-2876-5bb2-29aa-0d0208b97b10@omp.ru>
 <4721c4e6-cc0f-48bd-8b14-4a8217ada1fd@omp.ru>
 <b17c6124-0b84-40b2-a254-cce617f73cf2@tuxon.dev>
From: Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <59ba595a-ab79-cc5d-feff-dad60e80c44f@omp.ru>
Date: Tue, 19 Dec 2023 21:54:49 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <b17c6124-0b84-40b2-a254-cce617f73cf2@tuxon.dev>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.1.0, Database issued on: 12/19/2023 18:30:48
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 59
X-KSE-AntiSpam-Info: Lua profiles 182235 [Dec 19 2023]
X-KSE-AntiSpam-Info: Version: 6.1.0.3
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 7 0.3.7 6d6bf5bd8eea7373134f756a2fd73e9456bb7d1a
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {relay has no DNS name}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info:
	omp.ru:7.1.1;178.176.72.19:7.4.1,7.7.3;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1
X-KSE-AntiSpam-Info: {cloud_iprep_silent}
X-KSE-AntiSpam-Info: ApMailHostAddress: 178.176.72.19
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 59
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 12/19/2023 18:39:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 12/19/2023 3:42:00 PM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

On 12/17/23 3:54 PM, claudiu beznea wrote:

[...]

>>>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>>>
>>>> DBAT setup was done in the driver's probe API. As some IP variants switch
>>>> to reset mode (and thus registers' content is lost) when setting clocks
>>>> (due to module standby functionality) to be able to implement runtime PM
>>>> move the DBAT configuration in the driver's ndo_open API.
>>>>
>>>> This commit prepares the code for the addition of runtime PM.
>>>>
>>>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>>
>>> Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
>>>
>>> [...]
>>>> diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
>>>> index 04eaa1967651..6b8ca08be35e 100644
>>>> --- a/drivers/net/ethernet/renesas/ravb_main.c
>>>> +++ b/drivers/net/ethernet/renesas/ravb_main.c
>>>> @@ -1822,6 +1822,7 @@ static int ravb_open(struct net_device *ndev)
>>>>  		napi_enable(&priv->napi[RAVB_NC]);
>>>>  
>>>>  	ravb_set_delay_mode(ndev);
>>>> +	ravb_write(ndev, priv->desc_bat_dma, DBAT);
>>
>>    Looking at it again, I suspect this belong in ravb_dmac_init()...
> 
> ravb_dmac_init() is called from multiple places in this driver, e.g.,

   It's purpose is to configure AVB-DMAC and DBAT is the AVB-DMAC register,
right?

> ravb_set_ringparam(), ravb_tx_timeout_work().

   I know. Its value is only calculated once, in ravb_probe(), right?

> I'm afraid we may broke the behavior of these if DBAT setup is moved

   Do not be afraid! :-)

> in ravb_dmac_init(). This is also
> valid for setting delay (see patch 10/12).

   I don't think there will be a problem either... but maybe we
should call it in ravb_emac_init() indeed.

[...]

MBR, Sergey

