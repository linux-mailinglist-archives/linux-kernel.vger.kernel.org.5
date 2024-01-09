Return-Path: <linux-kernel+bounces-21368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66294828E42
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 20:54:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0533B1F24981
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 19:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A71E3D578;
	Tue,  9 Jan 2024 19:54:04 +0000 (UTC)
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 554363D969;
	Tue,  9 Jan 2024 19:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from [192.168.1.105] (31.173.83.101) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Tue, 9 Jan
 2024 22:53:49 +0300
Subject: Re: [PATCH net-next v3 19/19] net: ravb: Add runtime PM support
To: Claudiu <claudiu.beznea@tuxon.dev>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<richardcochran@gmail.com>, <p.zabel@pengutronix.de>,
	<yoshihiro.shimoda.uh@renesas.com>, <wsa+renesas@sang-engineering.com>
CC: <netdev@vger.kernel.org>, <linux-renesas-soc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <geert+renesas@glider.be>, Claudiu Beznea
	<claudiu.beznea.uj@bp.renesas.com>
References: <20240105082339.1468817-1-claudiu.beznea.uj@bp.renesas.com>
 <20240105082339.1468817-20-claudiu.beznea.uj@bp.renesas.com>
From: Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <6c53095c-2d63-d6d3-e233-a7709a6e48b1@omp.ru>
Date: Tue, 9 Jan 2024 22:53:48 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240105082339.1468817-20-claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.1.0, Database issued on: 01/09/2024 19:41:39
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 182518 [Jan 09 2024]
X-KSE-AntiSpam-Info: Version: 6.1.0.3
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 7 0.3.7 6d6bf5bd8eea7373134f756a2fd73e9456bb7d1a
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info:
	d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;omp.ru:7.1.1
X-KSE-AntiSpam-Info: ApMailHostAddress: 31.173.83.101
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 01/09/2024 19:46:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 1/9/2024 2:55:00 PM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

On 1/5/24 11:23 AM, Claudiu wrote:

> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
> Add runtime PM support for the ravb driver. As the driver is used by
> different IP variants, with different behaviors, to be able to have the
> runtime PM support available for all devices, the preparatory commits
> moved all the resources parsing and allocations in the driver's probe
> function and kept the settings for ravb_open(). This is due to the fact
> that on some IP variants-platforms tuples disabling/enabling the clocks
> will switch the IP to the reset operation mode where registers' content is
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
> Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
[...]

> diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
> index e909960fbc30..e99351fe8d7f 100644
> --- a/drivers/net/ethernet/renesas/ravb_main.c
> +++ b/drivers/net/ethernet/renesas/ravb_main.c
[...]
> @@ -2233,7 +2243,14 @@ static int ravb_close(struct net_device *ndev)
>  	ravb_get_stats(ndev);
>  
>  	/* Set reset mode. */
> -	return ravb_set_opmode(ndev, CCC_OPC_RESET);
> +	error = ravb_set_opmode(ndev, CCC_OPC_RESET);
> +	if (error)
> +		return error;
> +
> +	pm_runtime_mark_last_busy(dev);
> +	pm_runtime_put_autosuspend(dev);

   BTW, doesn't make sense to check/return the result?

> +
> +	return 0;
>  }
>  
>  static int ravb_hwtstamp_get(struct net_device *ndev, struct ifreq *req)
[...]

MBR, Sergey

