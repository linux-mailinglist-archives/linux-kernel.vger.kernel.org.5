Return-Path: <linux-kernel+bounces-62348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7012851ECA
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 21:40:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C9AD1F229C1
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 20:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6F4D47A67;
	Mon, 12 Feb 2024 20:40:16 +0000 (UTC)
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E735E1EB3D;
	Mon, 12 Feb 2024 20:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707770416; cv=none; b=iJGZdyJF8UIL8i9sFQ83dEHeYzY9jHq1j/MngqUIcMbUZ1oVuLeq8YDp2NAIojVdt1WTutdhdIQC15q3LgLbgXCizbpcbZKlq0IpMb8Q0RvPluFk9kZqbDLUGcwCBLa0lYBJRLkdTLvdOxwHw4dnHbJSC3YIhVbu2uyWy7fztC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707770416; c=relaxed/simple;
	bh=ts416wrAK6dKQgFPcsXRwARoY2LTcVFjNPySoHIIVHY=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=NHI1mU5SoGVV9y4U9q0F4XQ0iY7UvnAo0w8UnqzZUraVWvIAG5kdajRNkaQhuPNb0ck+PEeVNNaCDGObXOzMxt9JA+HA3ywdQHGVhcqlUMCzpYhwnJFJhFsMbhMgHC5DcSbpnqEHC1/y0A2T7xWjQNIdZFNgkXp6xBiPpnk4Qp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from [192.168.1.105] (178.176.73.92) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Mon, 12 Feb
 2024 23:40:04 +0300
Subject: Re: [RFC PATCH net-next v2 6/7] net: ravb: Enable SW IRQ Coalescing
 for GbEth
To: Paul Barker <paul.barker.ct@bp.renesas.com>, "David S . Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Wolfram Sang
	<wsa+renesas@sang-engineering.com>, <netdev@vger.kernel.org>,
	<linux-renesas-soc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240206091909.3191-1-paul.barker.ct@bp.renesas.com>
 <20240206091909.3191-7-paul.barker.ct@bp.renesas.com>
 <2251fe66-11b7-2f30-c905-7bc1b9a57dab@omp.ru>
 <895bdec7-05d6-4435-8be1-fe8ca716cbcb@bp.renesas.com>
From: Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <7c28bbea-0b3f-ee62-05c8-e6f1bc738b0b@omp.ru>
Date: Mon, 12 Feb 2024 23:40:04 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <895bdec7-05d6-4435-8be1-fe8ca716cbcb@bp.renesas.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.1.0, Database issued on: 02/12/2024 20:22:58
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 59
X-KSE-AntiSpam-Info: Lua profiles 183376 [Feb 12 2024]
X-KSE-AntiSpam-Info: Version: 6.1.0.3
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 7 0.3.7 6d6bf5bd8eea7373134f756a2fd73e9456bb7d1a
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {relay has no DNS name}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: {Found in DNSBL: 178.176.73.92 in (user)
 b.barracudacentral.org}
X-KSE-AntiSpam-Info:
	127.0.0.199:7.1.2;178.176.73.92:7.4.1,7.7.3;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;omp.ru:7.1.1
X-KSE-AntiSpam-Info: {cloud_iprep_silent}
X-KSE-AntiSpam-Info: ApMailHostAddress: 178.176.73.92
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 59
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 02/12/2024 20:28:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 2/12/2024 6:23:00 PM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

On 2/12/24 2:45 PM, Paul Barker wrote:
[...]
>>> diff --git a/drivers/net/ethernet/renesas/ravb.h b/drivers/net/ethernet/renesas/ravb.h
>>> index 55a7a08aabef..ca7a66759e35 100644
>>> --- a/drivers/net/ethernet/renesas/ravb.h
>>> +++ b/drivers/net/ethernet/renesas/ravb.h
>>> @@ -1078,6 +1078,7 @@ struct ravb_hw_info {
>>>  	unsigned nc_queues:1;		/* AVB-DMAC has RX and TX NC queues */
>>>  	unsigned magic_pkt:1;		/* E-MAC supports magic packet detection */
>>>  	unsigned half_duplex:1;		/* E-MAC supports half duplex mode */
>>> +	unsigned needs_irq_coalesce:1;	/* Requires SW IRQ Coalescing to achieve best performance */
>>
>>    Is this really a hardware feature?
> 
> It's more like a requirement to get the best out of this hardware and the Linux networking stack.
> 
> I considered checking the compatible string in the probe function but I decided that storing a configuration bit in the HW info struct was cleaner.

   Yes, but you added the new bit under the "hardware features" commet. :-)

>>    Also, s/Requires SW/Needs software/ and s/to achieve best performance//,
>> please...
> 
> Will do.

   The comment is too long, I think. :-)

[...]

> Thanks for the review,
> Paul

MBR, Sergey

