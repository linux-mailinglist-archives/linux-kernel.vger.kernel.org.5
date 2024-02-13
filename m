Return-Path: <linux-kernel+bounces-63238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C517852CB7
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 10:44:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F40B288C1D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 09:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1190E22606;
	Tue, 13 Feb 2024 09:38:56 +0000 (UTC)
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A638524B2;
	Tue, 13 Feb 2024 09:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707817135; cv=none; b=D56PL0LraviCH3oPBfa3lFBpwb3C1ufDOVggxTR1s7d9debovnYspwz+nXBohMObMAwR3j5TtNT+lQ8y2h8PXG4GKBGQ2MsZAh0UtrLd4N1zIorDkLuehBNscm+/8K+ewE4HnsVeSErmOfcGa6ieGta3hJG510vH6gxk9OpvryU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707817135; c=relaxed/simple;
	bh=5iT7l3x7XVyWOZkv6U7BTCdIVoGJfyP7vWO5/lmPTY8=;
	h=Subject:From:To:CC:References:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=nTnAfrOPmLrmxxX7cG7KlUrmf+8Y85cXqjAt+S2cCibmxeBI/1LwK3ZL/z3ibnKBO51Stz7uzi9Tkv3SxmoG1fptf72bS9jpaPpwfEXUQhw6/6yozl4JIhrS9tr16e4wbcWzaQaPfW3FSsUHaWMZUCDyQDbYuOffwEAPK2VJsRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from [192.168.1.105] (178.176.73.162) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Tue, 13 Feb
 2024 12:38:41 +0300
Subject: Re: [RFC PATCH net-next v2 0/7] Improve GbEth performance on Renesas
 RZ/G2L and related SoCs
From: Sergey Shtylyov <s.shtylyov@omp.ru>
To: Paul Barker <paul.barker.ct@bp.renesas.com>, "David S . Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Wolfram Sang
	<wsa+renesas@sang-engineering.com>, <netdev@vger.kernel.org>,
	<linux-renesas-soc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240206091909.3191-1-paul.barker.ct@bp.renesas.com>
 <29d9d3cb-4ac2-32e2-51b8-475d34216b07@omp.ru>
 <99a883c8-ccf2-4e52-9c34-ead59cd84117@bp.renesas.com>
 <4bf96e67-d35b-813c-ac9b-f2094903ac55@omp.ru>
Organization: Open Mobile Platform
Message-ID: <7923894a-c42c-b4ae-1828-775d1fb68a10@omp.ru>
Date: Tue, 13 Feb 2024 12:38:41 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <4bf96e67-d35b-813c-ac9b-f2094903ac55@omp.ru>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.1.0, Database issued on: 02/13/2024 09:23:13
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 59
X-KSE-AntiSpam-Info: Lua profiles 183389 [Feb 13 2024]
X-KSE-AntiSpam-Info: Version: 6.1.0.3
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 7 0.3.7 6d6bf5bd8eea7373134f756a2fd73e9456bb7d1a
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {relay has no DNS name}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: {Found in DNSBL: 178.176.73.162 in (user)
 b.barracudacentral.org}
X-KSE-AntiSpam-Info:
	omp.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;178.176.73.162:7.1.2;127.0.0.199:7.1.2
X-KSE-AntiSpam-Info: ApMailHostAddress: 178.176.73.162
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 59
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 02/13/2024 09:27:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 2/13/2024 7:14:00 AM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

On 2/12/24 11:53 PM, Sergey Shtylyov wrote:
[...]

>>>> This series aims to improve peformance of the GbEth IP in the Renesas
>>>
>>>    You didn't fix the typo in "peformance"... :-/
>>>
>>>> RZ/G2L SoC family and the RZ/G3S SoC, which use the ravb driver. Along
>>>> the way, we do some refactoring and ensure that napi_complete_done() is
>>>> used in accordance with the NAPI documentation for both GbEth and R-Car
>>>> code paths.
>>>>
>>>> Performance improvment mainly comes from enabling SW IRQ Coalescing for
>>>
>>>    And in "improvment" too... :-/
>>
>> I'll fix this and the above type in v3.
> 
>    TIA! Chances are this will end up in the merge commit...
> 
>>>> all SoCs using the GbEth IP, and NAPI Threaded mode for single core SoCs
>>>> using the GbEth IP. These can be enabled/disabled at runtime via sysfs,
>>>> but our goal is to set sensible defaults which get good performance on
>>>> the affected SoCs.
>>>>
>>>> The performance impact of this series on iperf3 testing is as follows:
>>>>   * RZ/G2L Ethernet throughput is unchanged, but CPU usage drops:
>>>>       * Bidirectional and TCP RX: 6.5% less CPU usage
>>>>       * UDP RX: 10% less CPU usage
>>>>
>>>>   * RZ/G2UL and RZ/G3S Ethernet throughput is increased for all test
>>>>     cases except UDP TX, which suffers a slight loss:
>>>>       * TCP TX: 32% more throughput
>>>>       * TCP RX: 11% more throughput
>>>>       * UDP TX: 10% less throughput
>>>>       * UDP RX: 10183% more throughput - the previous throughput of
>>>
>>>    So this is a real figure? I thought you forgot to erase 10... :-)
>>
>> Yes, throughput went from 1.06Mbps to 109Mbps for the RZ/G2UL with these
>> changes.
> 
>    Hm, that gives me even 10283%! :-)

   Stupid me, forgot to subtract 100%... :-)

[...]

MBR, Sergey

