Return-Path: <linux-kernel+bounces-152615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89B438AC134
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 22:24:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F92E280F53
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 20:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7544144391;
	Sun, 21 Apr 2024 20:23:54 +0000 (UTC)
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75CCE1BF20;
	Sun, 21 Apr 2024 20:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713731034; cv=none; b=L6PPgqJ+ndxzmY7J6+IXSDwISU5H/KxdUpnt+VcEz8MzDI2V1+JJx/qAUkPMAnv74p2SJxBBiSI3mpztoAX/v/cJtTxUJrVFnXcP4hIEDYTVafhCvsBKY3KOZ56sE6H4IEbeoNI8vaBZyshcHSSfHznCiV/BKuvrXBXLT4OkGs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713731034; c=relaxed/simple;
	bh=YHUxQDucqlt2tZ6/YcmABpo3iYb+1IqsFatlx4/NmYk=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=vEYBNfSo1ovhmiQIhO8JAa75Nyals7VxslO1j62G2ER+/kacYYvRQuxyM+89w5rzuTWdpHAQ6/b4XQm0vkRgdTUPWWQ/1YPMyU00qEU8iL/5VArpP0flPBqIfZWqtizrToSM3LOIHfq3j1BSo2nnifgqKR0GdZ6q+OgoeKXAn0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from [192.168.1.105] (178.176.72.135) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Sun, 21 Apr
 2024 23:23:33 +0300
Subject: Re: [net-next RFC v3 4/7] net: ravb: Refactor GbEth RX code path
To: Paul Barker <paul.barker.ct@bp.renesas.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: =?UTF-8?Q?Niklas_S=c3=b6derlund?= <niklas.soderlund+renesas@ragnatech.se>,
	Geert Uytterhoeven <geert+renesas@glider.be>, <netdev@vger.kernel.org>,
	<linux-renesas-soc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240415094804.8016-1-paul.barker.ct@bp.renesas.com>
 <20240415094804.8016-5-paul.barker.ct@bp.renesas.com>
 <897c3e16-7ded-bdea-08c7-14bf497bfc05@omp.ru>
 <bcddc226-7cbf-4994-94fe-eb70331f2bfa@bp.renesas.com>
From: Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <aa375f97-a94a-66bf-e96c-2a8f75e2cf8b@omp.ru>
Date: Sun, 21 Apr 2024 23:23:33 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <bcddc226-7cbf-4994-94fe-eb70331f2bfa@bp.renesas.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.1.0, Database issued on: 04/21/2024 20:06:29
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 59
X-KSE-AntiSpam-Info: Lua profiles 184824 [Apr 21 2024]
X-KSE-AntiSpam-Info: Version: 6.1.0.4
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 18 0.3.18
 b9d6ada76958f07c6a68617a7ac8df800bc4166c
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_uf_ne_domains}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {relay has no DNS name}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: {Found in DNSBL: 178.176.72.135 in (user)
 b.barracudacentral.org}
X-KSE-AntiSpam-Info:
	lore.kernel.org:7.1.1;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;omp.ru:7.1.1;178.176.72.135:7.1.2
X-KSE-AntiSpam-Info: ApMailHostAddress: 178.176.72.135
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 59
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 04/21/2024 20:10:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 4/21/2024 5:54:00 PM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

On 4/21/24 6:49 PM, Paul Barker wrote:
[...]

>>> We can reduce code duplication in ravb_rx_gbeth() and add comments to
>>> make the code flow easier to understand.
>>>
>>> Signed-off-by: Paul Barker <paul.barker.ct@bp.renesas.com>
>>> ---
>>>  drivers/net/ethernet/renesas/ravb_main.c | 70 ++++++++++++------------
>>>  1 file changed, 35 insertions(+), 35 deletions(-)
>>>
>>> diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
>>> index baa01bd81f2d..12618171f6d5 100644
>>> --- a/drivers/net/ethernet/renesas/ravb_main.c
>>> +++ b/drivers/net/ethernet/renesas/ravb_main.c
>>> @@ -818,47 +818,47 @@ static int ravb_rx_gbeth(struct net_device *ndev, int budget, int q)
>>>  				stats->rx_missed_errors++;
>>>  		} else {
>>>  			die_dt = desc->die_dt & 0xF0;
>>> -			switch (die_dt) {
>>> -			case DT_FSINGLE:
>>> -				skb = ravb_get_skb_gbeth(ndev, entry, desc);
>>> +			skb = ravb_get_skb_gbeth(ndev, entry, desc);
>>> +			if (die_dt == DT_FSINGLE || die_dt == DT_FSTART) {
>>
>>    No, please keep using *switch* statement here...
> 
> That's a shame - I much prefer this version with reduced code
> duplication, especially when we add page pool support. Duplication with
> subtle differences leads to bugs, see [1] for an example.
> 
> [1]: https://lore.kernel.org/all/20240416120254.2620-4-paul.barker.ct@bp.renesas.com/

   I wasn't clear enough probably, sorry about that.
   What I meant to say was that your use of the *if* statement
wasn't  actually justified. Please use the *switch* statement
instead.

[...]

> Thanks,

MBR, Sergey

