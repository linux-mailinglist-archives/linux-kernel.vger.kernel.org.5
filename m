Return-Path: <linux-kernel+bounces-41879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FD7A83F924
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 19:23:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2A001F21C08
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 18:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C92A631A98;
	Sun, 28 Jan 2024 18:23:14 +0000 (UTC)
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9977331A93;
	Sun, 28 Jan 2024 18:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706466194; cv=none; b=QKhOfGdZlHmpwBdJgxuGZrQW/QmhPhWaDGkYWhkGW9VqNttn9a4sv0fEXsZZoc8VaCB+CQTHuN+mQVyL4P3B8P/bGqYOXQoAf//CFHF+tYxihmaWZSvuolhw1B1ItnTNiQkfHiC2lSWmS6AsDdCdnvsz1apDBfq0r5gTmhK3LRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706466194; c=relaxed/simple;
	bh=4/rZR42xEDUEKBuhsxAoPbAjoVhj37dpEubn0dEsJmo=;
	h=Subject:From:To:CC:References:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=DQsAYf1tS7OUsWAIaJf2hqraMX3VcFynrxscA63x5W0aQMYarxJypDMWi68VxS+yeLYTYL4Aqr6iYvXlcfl29AB9BHgQfMkjYQV930rT2cqaHhoPGF/jjUEUCO/4fkBrbkarnXErTjnQpuj0yQDg1PqJNtgv7OiVvD+ovZuwYwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from [192.168.1.105] (178.176.74.225) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Sun, 28 Jan
 2024 21:23:02 +0300
Subject: Re: [PATCH net-next v4 08/15] net: ravb: Move the IRQs get and
 request in the probe function
From: Sergey Shtylyov <s.shtylyov@omp.ru>
To: Claudiu <claudiu.beznea@tuxon.dev>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<richardcochran@gmail.com>, <p.zabel@pengutronix.de>,
	<geert+renesas@glider.be>
CC: <netdev@vger.kernel.org>, <linux-renesas-soc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Claudiu Beznea
	<claudiu.beznea.uj@bp.renesas.com>
References: <20240123125829.3970325-1-claudiu.beznea.uj@bp.renesas.com>
 <20240123125829.3970325-9-claudiu.beznea.uj@bp.renesas.com>
 <bb26b1a9-a848-7b5a-26fd-192f004184d8@omp.ru>
 <ada0e1ac-dd33-aad2-52f9-0448b819bc94@omp.ru>
Organization: Open Mobile Platform
Message-ID: <dd7b35a1-b3c8-328e-5d32-a18a1798211b@omp.ru>
Date: Sun, 28 Jan 2024 21:23:02 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ada0e1ac-dd33-aad2-52f9-0448b819bc94@omp.ru>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.1.0, Database issued on: 01/28/2024 18:08:14
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 59
X-KSE-AntiSpam-Info: Lua profiles 182981 [Jan 28 2024]
X-KSE-AntiSpam-Info: Version: 6.1.0.3
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 7 0.3.7 6d6bf5bd8eea7373134f756a2fd73e9456bb7d1a
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Int_BEC_cat_st_0}
X-KSE-AntiSpam-Info: {Tracking_arrow_text}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {relay has no DNS name}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: {Found in DNSBL: 178.176.74.225 in (user)
 b.barracudacentral.org}
X-KSE-AntiSpam-Info: {Found in DNSBL: 178.176.74.225 in (user)
 dbl.spamhaus.org}
X-KSE-AntiSpam-Info:
	178.176.74.225:7.1.2,7.7.3,7.4.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;omp.ru:7.1.1
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
X-KSE-Antiphishing-Bases: 01/28/2024 18:13:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 1/28/2024 3:09:00 PM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

On 1/28/24 9:03 PM, Sergey Shtylyov wrote:
[...]

>>    I suggest the following subject "net: ravb: Move getting/requesting IRQs in
>> the probe() method".

    Or the probe() API, if you prefer this naming...

>    Oops, s/in/to/. :-)

   Well, we don't move getting IRQs to the probe() method, but
we move the platform_get_irq[_byname]() calls to a sperate function.
So, pperhaps "in" was good... :-) 

[...]

MBR, Sergey

