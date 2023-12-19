Return-Path: <linux-kernel+bounces-5916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2A05819179
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 21:30:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D7FBB258A3
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 20:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F5543A1AF;
	Tue, 19 Dec 2023 20:29:55 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F4239AFF;
	Tue, 19 Dec 2023 20:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from [192.168.1.104] (178.176.72.19) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Tue, 19 Dec
 2023 23:29:44 +0300
Subject: Re: [PATCH net-next v2 17/21] net: ravb: Keep clock request
 operations grouped together
To: claudiu beznea <claudiu.beznea@tuxon.dev>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<richardcochran@gmail.com>, <p.zabel@pengutronix.de>,
	<yoshihiro.shimoda.uh@renesas.com>, <wsa+renesas@sang-engineering.com>,
	<geert+renesas@glider.be>
CC: <netdev@vger.kernel.org>, <linux-renesas-soc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Claudiu Beznea
	<claudiu.beznea.uj@bp.renesas.com>
References: <20231214114600.2451162-1-claudiu.beznea.uj@bp.renesas.com>
 <20231214114600.2451162-18-claudiu.beznea.uj@bp.renesas.com>
 <2cb29821-7135-4369-ebc7-c742226e6230@omp.ru>
 <15c867d9-f77e-4b92-8b90-08d27116ce84@tuxon.dev>
From: Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <1a5f0b9c-3d8b-d9ae-d516-048856a2d0f9@omp.ru>
Date: Tue, 19 Dec 2023 23:29:32 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <15c867d9-f77e-4b92-8b90-08d27116ce84@tuxon.dev>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.1.0, Database issued on: 12/19/2023 20:16:21
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 182236 [Dec 19 2023]
X-KSE-AntiSpam-Info: Version: 6.1.0.3
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 7 0.3.7 6d6bf5bd8eea7373134f756a2fd73e9456bb7d1a
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info:
	127.0.0.199:7.1.2;178.176.72.19:7.7.3,7.4.1;omp.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1
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
X-KSE-Antiphishing-Bases: 12/19/2023 20:21:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 12/19/2023 6:03:00 PM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

On 12/17/23 4:22 PM, claudiu beznea wrote:

[...]

>>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>>
>>> Keep clock request operations grouped togeter to have all clock-related
>>> code in a single place. This makes the code simpler to follow.
>>>
>>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>> ---
>>>
>>> Changes in v2:
>>> - none; this patch is new
>>>
>>>  drivers/net/ethernet/renesas/ravb_main.c | 28 ++++++++++++------------
>>>  1 file changed, 14 insertions(+), 14 deletions(-)
>>>
>>> diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
>>> index 38999ef1ea85..a2a64c22ec41 100644
>>> --- a/drivers/net/ethernet/renesas/ravb_main.c
>>> +++ b/drivers/net/ethernet/renesas/ravb_main.c
>>> @@ -2768,6 +2768,20 @@ static int ravb_probe(struct platform_device *pdev)
>>>  	if (error)
>>>  		goto out_reset_assert;
>>>  
>>> +	priv->clk = devm_clk_get(&pdev->dev, NULL);
>>> +	if (IS_ERR(priv->clk)) {
>>> +		error = PTR_ERR(priv->clk);
>>> +		goto out_reset_assert;
>>> +	}
>>> +
>>> +	if (info->gptp_ref_clk) {
>>> +		priv->gptp_clk = devm_clk_get(&pdev->dev, "gptp");
>>> +		if (IS_ERR(priv->gptp_clk)) {
>>> +			error = PTR_ERR(priv->gptp_clk);
>>> +			goto out_reset_assert;
>>> +		}
>>> +	}
>>> +
>>>  	priv->refclk = devm_clk_get_optional(&pdev->dev, "refclk");
>>>  	if (IS_ERR(priv->refclk)) {
>>>  		error = PTR_ERR(priv->refclk);
>>
>>    Hmm... I think we currently have all these calls in one place.
>> Perhaps you just shouldn't have moved this code around?
> 
> refclk have been moved at this point due to runtime PM. As refclk was
> changed to be part of driver's runtime PM APIs we need to have it requested
> (and prepared) before pm_runtime_resume_and_get(). Calling
> pm_runtime_resume_and_get() will call driver's runtime PM resume.
> 
> The idea with this patch was to have all clock requests (clk, gptp, refclk)
> in a single place (it's easier to follow the code this way, in my opinion).
> If you prefer I can squash this patch with patch 07/21 "net: ravb: Move
> reference clock enable/disable on runtime PM APIs". Please, let me know
> what do you think.

   Yes, please move all 3 clocks at once.

MBR, Sergey

