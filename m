Return-Path: <linux-kernel+bounces-8952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E3D081BE7A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 19:50:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E899B2512A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 18:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BE2C65193;
	Thu, 21 Dec 2023 18:50:22 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A5F1E48C;
	Thu, 21 Dec 2023 18:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from [192.168.1.104] (178.176.75.203) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Thu, 21 Dec
 2023 21:50:07 +0300
From: Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: Re: [PATCH net-next v2 20/21] net: ravb: Do not apply RX CSUM
 settings to hardware if the interface is down
To: claudiu beznea <claudiu.beznea@tuxon.dev>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<richardcochran@gmail.com>, <p.zabel@pengutronix.de>,
	<yoshihiro.shimoda.uh@renesas.com>, <wsa+renesas@sang-engineering.com>,
	<geert+renesas@glider.be>
CC: <netdev@vger.kernel.org>, <linux-renesas-soc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Claudiu Beznea
	<claudiu.beznea.uj@bp.renesas.com>
References: <20231214114600.2451162-1-claudiu.beznea.uj@bp.renesas.com>
 <20231214114600.2451162-21-claudiu.beznea.uj@bp.renesas.com>
 <247ad9d9-298e-017b-f6e4-e672ee458ee7@omp.ru>
 <322c95f1-d42d-447d-89d1-7c61112b0cfd@tuxon.dev>
Organization: Open Mobile Platform
Message-ID: <101991df-0a00-b939-49db-d6fd425d0b50@omp.ru>
Date: Thu, 21 Dec 2023 21:50:06 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <322c95f1-d42d-447d-89d1-7c61112b0cfd@tuxon.dev>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.1.0, Database issued on: 12/21/2023 18:35:23
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 59
X-KSE-AntiSpam-Info: Lua profiles 182285 [Dec 21 2023]
X-KSE-AntiSpam-Info: Version: 6.1.0.3
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 7 0.3.7 6d6bf5bd8eea7373134f756a2fd73e9456bb7d1a
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {relay has no DNS name}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: {Found in DNSBL: 178.176.75.203 in (user)
 b.barracudacentral.org}
X-KSE-AntiSpam-Info: {Found in DNSBL: 178.176.75.203 in (user)
 dbl.spamhaus.org}
X-KSE-AntiSpam-Info:
	omp.ru:7.1.1;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1
X-KSE-AntiSpam-Info: ApMailHostAddress: 178.176.75.203
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 59
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 12/21/2023 18:38:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 12/21/2023 5:11:00 PM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

On 12/17/23 5:34 PM, claudiu beznea wrote:

[...]

>>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>>
>>> Do not apply the RX CSUM settings to hardware if the interface is down. In
>>> case runtime PM is enabled, and while the interface is down, the IP will be
>>> in reset mode (as for some platforms disabling/enabling the clocks will
>>> switch the IP to standby mode, which will lead to losing registers'
>>
>>    To/From perhaps?
>>    And just "register".
>>
>>> content) and applying settings in reset mode is not an option. Instead,
>>> cache the RX CSUM settings and apply them in ravb_open().
>>
>>    Have this issue actually occurred for you?
> 
> Setting RX CSUM while the if is down? No.
> 
>>> Commit prepares for the addition of runtime PM.
>>>
>>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>> [...]
>>
>>> diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
>>> index 633346b6cd7c..9ff943dff522 100644
>>> --- a/drivers/net/ethernet/renesas/ravb_main.c
>>> +++ b/drivers/net/ethernet/renesas/ravb_main.c
>>> @@ -1868,6 +1868,15 @@ static int ravb_open(struct net_device *ndev)
>>>  	if (info->gptp || info->ccc_gac)
>>>  		ravb_ptp_init(ndev, priv->pdev);
>>>  
>>> +	/* Apply features that might have been changed while the interface
>>> +	 * was down.
>>> +	 */
>>> +	if (ndev->hw_features & NETIF_F_RXCSUM) {
>>
>>    I'm afraid this is a wrong field; we need ndev->features, no?
> 
> RX CSUM is not enabled for all ravb aware devices (see struct
> ravb_hw_info::net_hw_features). We should be setting the ECMR only for
> these ones. ravb_hw_info::net_hw_features is set in ndev->hw_features in
> probe(). So here code checks if platforms supports RXCSUM and then below it
> applies what has been requested though ndo_set_features(), if any.

  OK. But we don't need this snippet here anyway...

>>> +		u32 val = (ndev->features & NETIF_F_RXCSUM) ? ECMR_RCSC : 0;
>>> +
>>> +		ravb_modify(ndev, ECMR, ECMR_RCSC, val);
>>> +	}
>>> +
>>
>>    The ECMR setting is already done in ravb_emac_init_rcar(), no need
>> to duplicate it here, I think...
> 
> Ok, it worth being moved there.

   No need to move, it's already there...

[...]
>>> @@ -2337,6 +2346,9 @@ static void ravb_set_rx_csum(struct net_device *ndev, bool enable)
>>>  	struct ravb_private *priv = netdev_priv(ndev);
>>>  	unsigned long flags;
>>>  
>>> +	if (!netif_running(ndev))
>>
>>    Racy as well...
> 
> It's also called with rtnl_mutex locked.

   Well, at least the only place that calls the ndo_set_features()
method, __netdev_update_features() calls ASSERT_RTNL() at the start.
However, since we'd have to use the is_opened flag anyway, let's rely
on it instead...

[...]

MBR, Sergey

