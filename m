Return-Path: <linux-kernel+bounces-5601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A08F9818CE7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 17:50:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4024E1F25877
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 16:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE976210EC;
	Tue, 19 Dec 2023 16:49:50 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 339CD20DFE;
	Tue, 19 Dec 2023 16:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from [192.168.1.104] (178.176.72.19) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Tue, 19 Dec
 2023 19:49:30 +0300
Subject: Re: [PATCH net 1/2] net: ravb: Wait for operation mode to be applied
To: claudiu beznea <claudiu.beznea@tuxon.dev>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<claudiu.beznea.uj@bp.renesas.com>, <yoshihiro.shimoda.uh@renesas.com>,
	<wsa+renesas@sang-engineering.com>, <niklas.soderlund+renesas@ragnatech.se>,
	<biju.das.jz@bp.renesas.com>, <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	<mitsuhiro.kimura.kc@renesas.com>, <geert+renesas@glider.be>
CC: <netdev@vger.kernel.org>, <linux-renesas-soc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20231214113137.2450292-1-claudiu.beznea.uj@bp.renesas.com>
 <20231214113137.2450292-2-claudiu.beznea.uj@bp.renesas.com>
 <d08dbbd4-2e63-c436-6935-df68c291bf75@omp.ru>
 <0b807496-f387-4aef-8650-a43a9249468f@tuxon.dev>
From: Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <2e70a095-8079-84f1-f842-eb90059610ed@omp.ru>
Date: Tue, 19 Dec 2023 19:49:29 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <0b807496-f387-4aef-8650-a43a9249468f@tuxon.dev>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.1.0, Database issued on: 12/19/2023 16:26:24
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
	omp.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;178.176.72.19:7.7.3,7.4.1;127.0.0.199:7.1.2
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
X-KSE-Antiphishing-Bases: 12/19/2023 16:32:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 12/19/2023 2:00:00 PM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

On 12/15/23 1:04 PM, claudiu beznea wrote:
[...]
>>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>>
>>> CSR.OPS bits specify the current operating mode and (according to
>>> documentation) they are updated when the operating mode change request
>>> is processed. Thus, check CSR.OPS before proceeding.
>>
>>    The manuals I have indeed say we need to check CSR.OPS... But we only
>> need to wait iff we transfer from the operation mode to the config mode...
> 
> RZ/G3S manual say about CSR.OPS "These bits are updated when an operating

   I was unable to find the RZ/G3 manuals on ther Renesas' website... :-(

> mode changes is processed". From this I get we need to check it for any mode.

  I don't argue with the (safety) checking of CSR.OPS, I was just pointing
out that the R-Car gen3 manual says that only transfer from operation to
the config mode happens after a considerable amount of time, other transfers
do happen immediately after updating CCC.OPC.

> Also, on configuration procedure (of RZ/G3S) it say CSR.OPS need to be
> checked when switching from reset -> config.

   Just checked or waited on?
   The R-car does have a specific algorithm for transferring from the operation
to the reset mode (you need to set CC.DTSR first and then wait for CSR.DTS to
clear before updating CCC.OPC)...

[...]

>>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>> ---
>>>  drivers/net/ethernet/renesas/ravb_main.c | 47 ++++++++++++++++++++----
>>>  1 file changed, 39 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
>>> index 9178f6d60e74..ce95eb5af354 100644
>>> --- a/drivers/net/ethernet/renesas/ravb_main.c
>>> +++ b/drivers/net/ethernet/renesas/ravb_main.c
[...]
>>> @@ -1744,6 +1747,18 @@ static inline int ravb_hook_irq(unsigned int irq, irq_handler_t handler,
>>>  	return error;
>>>  }
>>>  
>>> +static int ravb_set_reset_mode(struct net_device *ndev)
>>> +{
>>> +	int error;
>>> +
>>> +	ravb_write(ndev, CCC_OPC_RESET, CCC);
>>> +	error = ravb_wait(ndev, CSR, CSR_OPS, CSR_OPS_RESET);
>>> +	if (error)
>>> +		netdev_err(ndev, "failed to switch device to reset mode\n");
>>> +
>>> +	return error;
>>> +}
>>> +
>>
>>    Again, ravb_wait() call doesn't seem necessary here...
> 
> Ok. I followed the guideline from the description of CSR.OPS. Let me know
> if you want to keep it or not. I think I haven't saw any issues w/o this.

  Yes, please remove the waiting.

[...]

MBR, Sergey

