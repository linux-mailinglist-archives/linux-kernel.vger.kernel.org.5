Return-Path: <linux-kernel+bounces-65616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1454854F6E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 18:07:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76C30280CC5
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 17:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DA7960BA9;
	Wed, 14 Feb 2024 17:07:33 +0000 (UTC)
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA77A54FB8;
	Wed, 14 Feb 2024 17:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707930452; cv=none; b=qD2tZ+ucnEIN4DFuQXiKNJpIWPIooQdssZN8fW3xkOUifmYDmtNzKO/p8toH/ulAByKJBHchknF3ggO+eXOIy4NAyFJpMAka++SwjF/XUZpbUJ6jDnwXKvJbQc8o5SaEflVKMCeRdI/a85I7dNh9MCRisXyRHso6im/fqb9nREo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707930452; c=relaxed/simple;
	bh=WVc+KVsJWg/hJEZDvHdju5OFgugSoNT7Gs02IKHsAtE=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=O1LZ0a8RsdK0sACrMA0BP7Fk4rT2iD2XAtyb2B3KFf7oybaWZqnFwaFrsVC5zlqb8pe2PvlPKGfp7wU2JGfPIdZRoVqbaHjYRHXGU2Lw1DELqLtTiuSFb4qeoxf56Us9M0gVDd1lTtGQa0OcnYqEFC1UBAiDVz7MpN69sejNLhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from [192.168.1.105] (178.176.73.178) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Wed, 14 Feb
 2024 20:07:20 +0300
Subject: Re: [PATCH net-next v4 5/6] net: ravb: Do not apply features to
 hardware if the interface is down
To: Claudiu <claudiu.beznea@tuxon.dev>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<biju.das.jz@bp.renesas.com>
CC: <netdev@vger.kernel.org>, <linux-renesas-soc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Claudiu Beznea
	<claudiu.beznea.uj@bp.renesas.com>
References: <20240214135800.2674435-1-claudiu.beznea.uj@bp.renesas.com>
 <20240214135800.2674435-6-claudiu.beznea.uj@bp.renesas.com>
From: Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <02f45526-0d56-469c-db3d-de1ef8785685@omp.ru>
Date: Wed, 14 Feb 2024 20:07:20 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240214135800.2674435-6-claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.1.0, Database issued on: 02/14/2024 16:49:17
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 59
X-KSE-AntiSpam-Info: Lua profiles 183446 [Feb 14 2024]
X-KSE-AntiSpam-Info: Version: 6.1.0.3
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 7 0.3.7 6d6bf5bd8eea7373134f756a2fd73e9456bb7d1a
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {relay has no DNS name}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: {Found in DNSBL: 178.176.73.178 in (user)
 b.barracudacentral.org}
X-KSE-AntiSpam-Info: {Found in DNSBL: 178.176.73.178 in (user)
 dbl.spamhaus.org}
X-KSE-AntiSpam-Info:
	d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;178.176.73.178:7.4.1,7.7.3;omp.ru:7.1.1;127.0.0.199:7.1.2
X-KSE-AntiSpam-Info: {cloud_iprep_silent}
X-KSE-AntiSpam-Info: ApMailHostAddress: 178.176.73.178
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 59
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 02/14/2024 16:56:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 2/14/2024 2:42:00 PM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

On 2/14/24 4:57 PM, Claudiu wrote:

> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
> Do not apply features to hardware if the interface is down. In case runtime
> PM is enabled, and while the interface is down, the IP will be in reset
> mode (as for some platforms disabling the clocks will switch the IP to
> reset mode, which will lead to losing register contents) and applying
> settings in reset mode is not an option. Instead, cache the features and
> apply them in ravb_open() through ravb_emac_init().
> 
> To avoid accessing the hardware while the interface is down
> pm_runtime_active() check was introduced. Along with it the device runtime
> PM usage counter has been incremented to avoid disabling the device clocks
> while the check is in progress (if any).
> 
> Commit prepares for the addition of runtime PM.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>

[...]

MBR, Sergey

