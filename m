Return-Path: <linux-kernel+bounces-18949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95D6782658F
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 19:24:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 354BB1F21499
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 18:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4868113FE7;
	Sun,  7 Jan 2024 18:24:33 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 065F613FE4;
	Sun,  7 Jan 2024 18:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from [192.168.1.104] (31.173.82.35) by msexch01.omp.ru (10.188.4.12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Sun, 7 Jan
 2024 21:24:17 +0300
Subject: Re: [PATCH net-next v3 08/19] net: ravb: Move the IRQs get and
 request in the probe function
To: Claudiu <claudiu.beznea@tuxon.dev>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<richardcochran@gmail.com>, <p.zabel@pengutronix.de>,
	<yoshihiro.shimoda.uh@renesas.com>, <wsa+renesas@sang-engineering.com>
CC: <netdev@vger.kernel.org>, <linux-renesas-soc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <geert+renesas@glider.be>, Claudiu Beznea
	<claudiu.beznea.uj@bp.renesas.com>
References: <20240105082339.1468817-1-claudiu.beznea.uj@bp.renesas.com>
 <20240105082339.1468817-9-claudiu.beznea.uj@bp.renesas.com>
From: Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <02548b1b-d32c-78b1-f1b6-5fdb505d31bb@omp.ru>
Date: Sun, 7 Jan 2024 21:24:17 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240105082339.1468817-9-claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.1.0, Database issued on: 01/07/2024 18:00:30
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 59
X-KSE-AntiSpam-Info: Lua profiles 182476 [Jan 07 2024]
X-KSE-AntiSpam-Info: Version: 6.1.0.3
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 7 0.3.7 6d6bf5bd8eea7373134f756a2fd73e9456bb7d1a
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {relay has no DNS name}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: {Found in DNSBL: 31.173.82.35 in (user)
 b.barracudacentral.org}
X-KSE-AntiSpam-Info: {Found in DNSBL: 31.173.82.35 in (user) dbl.spamhaus.org}
X-KSE-AntiSpam-Info:
	31.173.82.35:7.4.1,7.7.3;127.0.0.199:7.1.2;omp.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1
X-KSE-AntiSpam-Info: {cloud_iprep_silent}
X-KSE-AntiSpam-Info: ApMailHostAddress: 31.173.82.35
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 59
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 01/07/2024 18:06:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 1/7/2024 5:20:00 PM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

On 1/5/24 11:23 AM, Claudiu wrote:

> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
> The runtime PM implementation will disable clocks at the end of
> ravb_probe(). As some IP variants switch to reset mode as a result of
> setting module standby through clock disable APIs, to implement runtime PM
> the resource parsing and requesting are moved in the probe function and IP
> settings are moved in the open function. This is done because at the end of
> the probe some IP variants will switch anyway to reset mode and the
> registers content is lost. Also keeping only register specific operations
> in the ravb_open()/ravb_close() functions will make them faster.
> 
> Commit moves IRQ requests to ravb_probe() to have all the IRQs ready when
> the interface is open. As now IRQs gets and requests are in a single place
> there is no need to keep intermediary data (like ravb_rx_irqs[] and
> ravb_tx_irqs[] arrays or IRQs in struct ravb_private).

   There's one thing that you probably didn't take into account: after
you call request_irq(), you should be able to handle your IRQ as it's
automatically unmasked, unless you pass IRQF_NO_AUTOEN to request_irq().
Your device may be held i reset or even powered off but if you pass IRQF_SHARED to request_irq() (you do in a single IRQ config), you must
be prepared to get your device's registers read (in order to ascertain
whether it's your IRQ or not). And you can't even pass IRQF_NO_AUTOEN
along with IRQF_SHARED, according to my reading of the IRQ code...

> This is a preparatory change to add runtime PM support for all IP variants.

  I don't readily see why this is necessary for the full-fledged RPM
support...

> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

   Unfortunately, I have to NAK this patch, at least in its current
form...

[...]

MBR, Sergey

