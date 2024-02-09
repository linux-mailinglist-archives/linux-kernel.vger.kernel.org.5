Return-Path: <linux-kernel+bounces-59974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 959DD84FE16
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 22:01:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30443284090
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 21:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7886B17570;
	Fri,  9 Feb 2024 21:01:14 +0000 (UTC)
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F33538A;
	Fri,  9 Feb 2024 21:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707512474; cv=none; b=FUZyAtIkxgFg0M5mtzEdHbRFTuZKcwtAT200WX25Z/fdcHVoMtMGaTTE7xNWmE3TAtN9Ubbk/WGBoQxZKnp3qckfcK4MgzORXxLbjbWpVpzv6juogYLAEnkczRKqqCmkI/DVYPd9VvPRjMFRxmD7Rnlj1bsqY1jiHX/6TUdaHLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707512474; c=relaxed/simple;
	bh=ZlCWjyEbCdYaq94XTypns1HHxFSL+MANCGm2IE1pLOk=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=dam8aA1nWJBt6fzC1ro0dORN6Q+uO/qtiAhqJHYgMg072h039Bwy9TbSWkzx5h/gz/NwxDsGkKx0KaCLZVld8cjxEuvXBeTHVknneod9JBO/XJZXiAFlkiCmAXu7SZ76gIoDy4TqvHiu2GelPIkDFgiCq1xImh9MoWp7/F5fZoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from [192.168.1.105] (178.176.73.169) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Sat, 10 Feb
 2024 00:00:54 +0300
Subject: Re: [PATCH net-next v2 5/5] net: ravb: Add runtime PM support
To: Claudiu <claudiu.beznea@tuxon.dev>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-renesas-soc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Claudiu Beznea
	<claudiu.beznea.uj@bp.renesas.com>
References: <20240209170459.4143861-1-claudiu.beznea.uj@bp.renesas.com>
 <20240209170459.4143861-6-claudiu.beznea.uj@bp.renesas.com>
From: Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <3808dee0-b623-b870-7d96-94cc5fc12350@omp.ru>
Date: Sat, 10 Feb 2024 00:00:54 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240209170459.4143861-6-claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.1.0, Database issued on: 02/09/2024 20:49:20
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 59
X-KSE-AntiSpam-Info: Lua profiles 183341 [Feb 09 2024]
X-KSE-AntiSpam-Info: Version: 6.1.0.3
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 7 0.3.7 6d6bf5bd8eea7373134f756a2fd73e9456bb7d1a
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {relay has no DNS name}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: {Found in DNSBL: 178.176.73.169 in (user)
 b.barracudacentral.org}
X-KSE-AntiSpam-Info: {Found in DNSBL: 178.176.73.169 in (user)
 dbl.spamhaus.org}
X-KSE-AntiSpam-Info:
	d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;omp.ru:7.1.1
X-KSE-AntiSpam-Info: ApMailHostAddress: 178.176.73.169
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 59
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 02/09/2024 20:54:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 2/9/2024 5:38:00 PM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

On 2/9/24 8:04 PM, Claudiu wrote:

> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
> Add runtime PM support for the ravb driver. As the driver is used by
> different IP variants, with different behaviors, to be able to have the
> runtime PM support available for all devices, the preparatory commits
> moved all the resources parsing and allocations in the driver's probe
> function and kept the settings for ravb_open(). This is due to the fact
> that on some IP variants-platforms tuples disabling/enabling the clocks
> will switch the IP to the reset operation mode where registers' content is

   This pesky "registers' content" somehow evaded me -- should be "register
contents" as well...

> lost and reconfiguration needs to be done. For this the rabv_open()
> function enables the clocks, switches the IP to configuration mode, applies
> all the registers settings and switches the IP to the operational mode. At
> the end of ravb_open() IP is ready to send/receive data.
> 
> In ravb_close() necessary reverts are done (compared with ravb_open()), the
> IP is switched to reset mode and clocks are disabled.
> 
> The ethtool APIs or IOCTLs that might execute while the interface is down
> are either cached (and applied in ravb_open()) or rejected (as at that time
> the IP is in reset mode). Keeping the IP in the reset mode also increases
> the power saved (according to the hardware manual).
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
[...]

> diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
> index f4be08f0198d..5bbfdfeef8a9 100644
> --- a/drivers/net/ethernet/renesas/ravb_main.c
> +++ b/drivers/net/ethernet/renesas/ravb_main.c
> @@ -1939,16 +1939,21 @@ static int ravb_open(struct net_device *ndev)
>  {
>  	struct ravb_private *priv = netdev_priv(ndev);
>  	const struct ravb_hw_info *info = priv->info;
> +	struct device *dev = &priv->pdev->dev;
>  	int error;
>  
>  	napi_enable(&priv->napi[RAVB_BE]);
>  	if (info->nc_queues)
>  		napi_enable(&priv->napi[RAVB_NC]);
>  
> +	error = pm_runtime_resume_and_get(dev);
> +	if (error < 0)
> +		goto out_napi_off;

   Well, s/error/ret/ -- it would fit better here...

[...]
> @@ -3066,6 +3089,12 @@ static void ravb_remove(struct platform_device *pdev)
>  	struct net_device *ndev = platform_get_drvdata(pdev);
>  	struct ravb_private *priv = netdev_priv(ndev);
>  	const struct ravb_hw_info *info = priv->info;
> +	struct device *dev = &priv->pdev->dev;
> +	int error;
> +
> +	error = pm_runtime_resume_and_get(dev);
> +	if (error < 0)
> +		return;

   Again, s/erorr/ret/ in this case.

[...]

MBR, Sergey

