Return-Path: <linux-kernel+bounces-60534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD2B9850644
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 21:37:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4189C1F24C11
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 20:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9174B5FB99;
	Sat, 10 Feb 2024 20:37:44 +0000 (UTC)
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B135B1EB;
	Sat, 10 Feb 2024 20:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707597464; cv=none; b=H+d/32odrk+YEgrvn2ErOWkjCssfFQhi0nMgpSk/C4NjkMQJj+0H0Y75oJKLqRIrXoz7fVjjeMNkT1huX4ZYsGqptQ3xNmB6B2FXhqf+EdDJ1dYKFc5uVbgh2DcBPqni67wszMc8ohE0+UZ4LUTYfYYwC6FKjZfBWQpBLU8lagk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707597464; c=relaxed/simple;
	bh=o3DjcLuy3LIalFk9cwJNOhs8h+B9l1E7S8qrQDbmMgk=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=jqfTLKSAvIHRHQxg7bvL3zR87k7soa3grm/eSFyYzzUeiagLZdSjSCZu/A/Ttu7h4HX+sKTOwYn93iyUtqzVelVv+YSuHpHVNcJGEw4+FbJEN3c86a29Vj9Az3wFoWY+u460BYtWiOkaXZRTTs0z6/Ihu5+JaGat4Dx2P1GNUKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from [192.168.1.105] (31.173.86.126) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Sat, 10 Feb
 2024 23:37:31 +0300
Subject: Re: [PATCH net-next v2 4/5] net: ravb: Do not apply RX checksum
 settings to hardware if the interface is down
To: Biju Das <biju.das.jz@bp.renesas.com>, Claudiu.Beznea
	<claudiu.beznea@tuxon.dev>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Claudiu Beznea
	<claudiu.beznea.uj@bp.renesas.com>
References: <20240209170459.4143861-1-claudiu.beznea.uj@bp.renesas.com>
 <20240209170459.4143861-5-claudiu.beznea.uj@bp.renesas.com>
 <6f907f89-7588-fd99-1a63-8291f9e29c81@omp.ru>
 <TYCPR01MB112693D3BB55CB8CC91437B87864B2@TYCPR01MB11269.jpnprd01.prod.outlook.com>
From: Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <e48e0cba-572b-93ac-efe4-112305721142@omp.ru>
Date: Sat, 10 Feb 2024 23:37:31 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <TYCPR01MB112693D3BB55CB8CC91437B87864B2@TYCPR01MB11269.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: msexch02.omp.ru (10.188.4.13) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.1.0, Database issued on: 02/10/2024 20:25:19
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 59
X-KSE-AntiSpam-Info: Lua profiles 183344 [Feb 10 2024]
X-KSE-AntiSpam-Info: Version: 6.1.0.3
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 7 0.3.7 6d6bf5bd8eea7373134f756a2fd73e9456bb7d1a
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {relay has no DNS name}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: {Found in DNSBL: 31.173.86.126 in (user)
 b.barracudacentral.org}
X-KSE-AntiSpam-Info:
	omp.ru:7.1.1;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1
X-KSE-AntiSpam-Info: ApMailHostAddress: 31.173.86.126
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 59
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 02/10/2024 20:28:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 2/10/2024 5:04:00 PM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

On 2/9/24 11:41 PM, Biju Das wrote:
[...]

>>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>>
>>> Do not apply the RX checksum settings to hardware if the interface is
>>> down.
>>> In case runtime PM is enabled, and while the interface is down, the IP
>>> will be in reset mode (as for some platforms disabling the clocks will
>>> switch the IP to reset mode, which will lead to losing register
>>> contents) and applying settings in reset mode is not an option.
>>> Instead, cache the RX checksum settings and apply them in ravb_open()
>>> through ravb_emac_init().
>>> This has been solved by introducing pm_runtime_active() check. The
>>> device runtime PM usage counter has been incremented to avoid
>>> disabling the device clocks while the check is in progress (if any).
>>>
>>> Commit prepares for the addition of runtime PM.
>>>
>>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>
>> Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
> 
> This will do the same job, without code duplication right?
> 
> static int ravb_set_features(struct net_device *ndev,
> 			     netdev_features_t features)
> {
> 	struct ravb_private *priv = netdev_priv(ndev);
> 	struct device *dev = &priv->pdev->dev;
> 	const struct ravb_hw_info *info = priv->info;
> 
> 	pm_runtime_get_noresume(dev);
> 	if (!pm_runtime_active(dev)) {
> 		pm_runtime_put_noidle(dev);
> 		ndev->features = features;
> 		return 0;
> 	}
> 		
> 	return info->set_feature(ndev, features);

   We now leak the device reference by not calling pm_runtime_put_noidle()
after this statement...
   The approach seems sane though -- Claudiu, please consider following it.

[...]

> Cheers,
> Biju

MBR, Sergey

