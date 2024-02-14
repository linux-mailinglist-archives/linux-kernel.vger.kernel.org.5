Return-Path: <linux-kernel+bounces-65592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6E8D854F30
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 17:55:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2561F1C2851A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 16:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3DE360864;
	Wed, 14 Feb 2024 16:55:42 +0000 (UTC)
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB786604BA;
	Wed, 14 Feb 2024 16:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707929742; cv=none; b=QQXo8VM+we3zmRThsN3eVj3gBWYmE+w2Lz3F37jOPsYTQhBtkBwGmxd586PvQgkEGj+tQthn17gOxZp41cToHuihqOzlPeBmy6c0IwWTH3PiRnQjPFSB9Oewbd07URTHUPgmzYQP7QE75FaqCKnRpMqwpLuu6mCDBO36RtIr6h8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707929742; c=relaxed/simple;
	bh=R4aO56oitobWIyygbTcNM6DX/tMQVEEpkvRemh26eN0=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=j0VHTzCLfZRJ+1LoJu/U9d96fYEeJbVliKqGt+CjlQymjaJgtpgepHyMQzQmU0wPDQdgSv9hzAaRAts/GdwjxImD5CSzQZr0p2nOycz3M/NwmCXWknV62Ijk3YOZWlv/iUPOkvN7FRCxogpBQxa+QWdOchjBe1Nl/K6XFGUidOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from [192.168.1.105] (178.176.73.178) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Wed, 14 Feb
 2024 19:55:29 +0300
Subject: Re: [PATCH net-next v4 4/6] net: ravb: Move the update of
 ndev->features to ravb_set_features()
To: Claudiu <claudiu.beznea@tuxon.dev>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<biju.das.jz@bp.renesas.com>
CC: <netdev@vger.kernel.org>, <linux-renesas-soc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Claudiu Beznea
	<claudiu.beznea.uj@bp.renesas.com>
References: <20240214135800.2674435-1-claudiu.beznea.uj@bp.renesas.com>
 <20240214135800.2674435-5-claudiu.beznea.uj@bp.renesas.com>
From: Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <d1f1bb09-2c13-1d1c-b403-35b537778286@omp.ru>
Date: Wed, 14 Feb 2024 19:55:28 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240214135800.2674435-5-claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.1.0, Database issued on: 02/14/2024 16:36:43
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
	d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;omp.ru:7.1.1;127.0.0.199:7.1.2;178.176.73.178:7.4.1,7.7.3
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
X-KSE-Antiphishing-Bases: 02/14/2024 16:41:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 2/14/2024 2:42:00 PM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

On 2/14/24 4:57 PM, Claudiu wrote:

> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
> Commit c2da9408579d ("ravb: Add Rx checksum offload support for GbEth")
> introduced support for setting GbEth features. With this the IP-specific
> features update functions update the ndev->features individually.
> 
> Next commits add runtime PM support for the ravb driver. The runtime PM
> implementation will enable/disable the IP clocks on
> the ravb_open()/ravb_close() functions. Accessing the IP registers with
> clocks disabled blocks the system.
> 
> The ravb_set_features() function could be executed when the Ethernet
> interface is closed so we need to ensure we don't access IP registers while
> the interface is down when runtime PM support will be in place.
> 
> For these, move the update of ndev->features to ravb_set_features(). In
> this way we update the ndev->features only when the IP-specific features
> set function returns success and we can avoid code duplication when
> introducing runtime PM registers protection.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
[...]

Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>

> diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
> index 7a7f743a1fef..ac23779d1cc5 100644
> --- a/drivers/net/ethernet/renesas/ravb_main.c
> +++ b/drivers/net/ethernet/renesas/ravb_main.c
[...]
> @@ -2567,8 +2564,15 @@ static int ravb_set_features(struct net_device *ndev,
>  {
>  	struct ravb_private *priv = netdev_priv(ndev);
>  	const struct ravb_hw_info *info = priv->info;
> +	int ret;

   I'd use 'error' here, it would fit well... :-)

> +
> +	ret = info->set_feature(ndev, features);
> +	if (ret)
> +		return ret;
>  
> -	return info->set_feature(ndev, features);
> +	ndev->features = features;
> +
> +	return 0;
>  }
>  
>  static const struct net_device_ops ravb_netdev_ops = {

MBR, Sergey

