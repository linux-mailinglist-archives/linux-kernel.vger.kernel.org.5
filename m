Return-Path: <linux-kernel+bounces-41864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 44A2B83F8F6
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 19:02:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82D0AB21612
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 18:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE65C2E62B;
	Sun, 28 Jan 2024 18:01:56 +0000 (UTC)
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F1B62D60A;
	Sun, 28 Jan 2024 18:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706464916; cv=none; b=S4zaPiokHUtW13LDGyN5U0yPn3l3Z9dEygXy2BQmlmjsOyW+vyJIGjp9PJ4bQioNB7rTPnfN7+av9cMMIH0h2YpDzaTv9EABfx2L04QFE/BqE08FCvEPOnXylW9CEYAzj5eIqtuYdReWVVQkWbwSaR+Gv2DupaOnzNVqbBgS+nM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706464916; c=relaxed/simple;
	bh=vOfs+m+BbxLk/reMFaIjPXLuBEleunnZ3wlO2LKnsPM=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=L9lxS1GAoWI4H2xXzzUtqqEetvvSkYN6wmli2YyJhf8Y90G8ONZVSqOK2/bN4X34TZCa998PbbrM4W21YzTKV17Je6Fu0Z0TY9W8764X0A/DgiC6ZxPEuXEmi+DCEK0j/PDLg8Dxipx0lBuOCIxXRTffFQUDl+rDPnDdlGzXmm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from [192.168.1.105] (178.176.74.225) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Sun, 28 Jan
 2024 21:01:36 +0300
Subject: Re: [PATCH net-next v4 08/15] net: ravb: Move the IRQs get and
 request in the probe function
To: Claudiu <claudiu.beznea@tuxon.dev>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<richardcochran@gmail.com>, <p.zabel@pengutronix.de>,
	<geert+renesas@glider.be>
CC: <netdev@vger.kernel.org>, <linux-renesas-soc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Claudiu Beznea
	<claudiu.beznea.uj@bp.renesas.com>
References: <20240123125829.3970325-1-claudiu.beznea.uj@bp.renesas.com>
 <20240123125829.3970325-9-claudiu.beznea.uj@bp.renesas.com>
From: Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <bb26b1a9-a848-7b5a-26fd-192f004184d8@omp.ru>
Date: Sun, 28 Jan 2024 21:01:35 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240123125829.3970325-9-claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.1.0, Database issued on: 01/28/2024 17:47:03
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 59
X-KSE-AntiSpam-Info: Lua profiles 182979 [Jan 28 2024]
X-KSE-AntiSpam-Info: Version: 6.1.0.3
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 7 0.3.7 6d6bf5bd8eea7373134f756a2fd73e9456bb7d1a
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {relay has no DNS name}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: {Found in DNSBL: 178.176.74.225 in (user)
 b.barracudacentral.org}
X-KSE-AntiSpam-Info: {Found in DNSBL: 178.176.74.225 in (user)
 dbl.spamhaus.org}
X-KSE-AntiSpam-Info:
	d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;omp.ru:7.1.1;178.176.74.225:7.4.1,7.7.3,7.1.2;127.0.0.199:7.1.2
X-KSE-AntiSpam-Info: {cloud_iprep_silent}
X-KSE-AntiSpam-Info: ApMailHostAddress: 178.176.74.225
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 59
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 01/28/2024 17:50:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 1/28/2024 3:09:00 PM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

Hello!

   I suggest the following subject "net: ravb: Move getting/requesting IRQs in
the probe() method".

On 1/23/24 3:58 PM, Claudiu wrote:

> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
> The runtime PM implementation will disable clocks at the end of
> ravb_probe(). As some IP variants switch to reset mode as a result of
> setting module standby through clock disable APIs, to implement runtime PM
> the resource parsing and requesting are moved in the probe function and IP
> settings are moved in the open function. This is done because at the end of
> the probe some IP variants will switch anyway to reset mode and the
> registers content is lost. Also keeping only register specific operations 

   Register contents?

> in the ravb_open()/ravb_close() functions will make them faster.
> 
> Commit moves IRQ requests to ravb_probe() to have all the IRQs ready when
> the interface is open. As now IRQs gets and requests are in a single place

   Again, getting/requesting IRQs.

> there is no need to keep intermediary data (like ravb_rx_irqs[] and
> ravb_tx_irqs[] arrays or IRQs in struct ravb_private).
> 
> In order to avoid accessing the IP registers while the IP is runtime
> suspended (e.g. in the timeframe b/w the probe requests shared IRQs and
> IP clocks are enabled) in the interrupt handlers were introduced
> pm_runtime_active() checks. The device runtime PM usage counter has been
> incremented to avoid disabling the device's clocks while the check is in
> progress (if any).

   Oh, so this scheme does have some complications...

> This is a preparatory change to add runtime PM support for all IP variants.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

   With the above fixed:

Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>

[...]

MBR, Sergey

