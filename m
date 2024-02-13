Return-Path: <linux-kernel+bounces-64197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC4D0853BAC
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 20:52:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B73A1C26836
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 19:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F656608F1;
	Tue, 13 Feb 2024 19:52:31 +0000 (UTC)
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E4860ECB;
	Tue, 13 Feb 2024 19:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707853950; cv=none; b=diOnD79lhd9G2qfX4txMoqmxezFLlu0+XTMKV0vm4zejeOQsabN4UFle3Ma1jxI+2Yk0dqmsVzSF/uPEJDAe4mbRhrnVrLvS9MKS5PCakCaqdeLpIJMz9jAgFn1IDSQvP5Cir2ulfOaQcLkJMtbgE2CGJodiN8VBVsdkKgeHDHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707853950; c=relaxed/simple;
	bh=B/Zh10xQbdlld19xfJvnSNoL4PD7RYqchRBmmWzUX6Q=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=vEIaQL0ck/wgdjb4sjUOCNJhXCqE25iKcIDkcoSptxm9IkOw2tJtap+XIjFigaOj/dwotRecLUpQT4cRY82PfH6nG+lc+goBWPFXTYMZtOVHziliz1pfTFKGv7PAhlU4ezTLW/Uc9yE1A8WY6PyMDlwHfsLc11W225GXg027f8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from [192.168.1.105] (178.176.75.253) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Tue, 13 Feb
 2024 22:52:25 +0300
Subject: Re: [PATCH net-next v3 4/6] net: ravb: Move the update of
 ndev->features to ravb_set_features()
To: Claudiu <claudiu.beznea@tuxon.dev>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<biju.das.jz@bp.renesas.com>
CC: <netdev@vger.kernel.org>, <linux-renesas-soc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Claudiu Beznea
	<claudiu.beznea.uj@bp.renesas.com>
References: <20240213094110.853155-1-claudiu.beznea.uj@bp.renesas.com>
 <20240213094110.853155-5-claudiu.beznea.uj@bp.renesas.com>
From: Sergey Shtylyov <s.shtylyov@omp.ru>
Organization: Open Mobile Platform
Message-ID: <3747ad9a-217a-2f43-835a-7c23f6a710d2@omp.ru>
Date: Tue, 13 Feb 2024 22:52:25 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240213094110.853155-5-claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.1.0, Database issued on: 02/13/2024 19:36:27
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 183416 [Feb 13 2024]
X-KSE-AntiSpam-Info: Version: 6.1.0.3
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 7 0.3.7 6d6bf5bd8eea7373134f756a2fd73e9456bb7d1a
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info:
	omp.ru:7.1.1;178.176.75.253:7.4.1,7.7.3;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1
X-KSE-AntiSpam-Info: {cloud_iprep_silent}
X-KSE-AntiSpam-Info: ApMailHostAddress: 178.176.75.253
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 02/13/2024 19:40:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 2/13/2024 4:21:00 PM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

On 2/13/24 12:41 PM, Claudiu wrote:

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
> For these, move the update of ndev->features to ravb_set_features() and
> make the IP-specific features set function return int. In this way we
> update the ndev->features only when the IP-specific features set function
> returns success and we can avoid code duplication when introducing
> runtime PM registers protection.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
[...]

> diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
> index 7a7f743a1fef..b3b91783bb7a 100644
> --- a/drivers/net/ethernet/renesas/ravb_main.c
> +++ b/drivers/net/ethernet/renesas/ravb_main.c
> @@ -2475,7 +2475,7 @@ static int ravb_change_mtu(struct net_device *ndev, int new_mtu)
>  	return 0;
>  }
>  
> -static void ravb_set_rx_csum(struct net_device *ndev, bool enable)
> +static int ravb_set_rx_csum(struct net_device *ndev, bool enable)
>  {
>  	struct ravb_private *priv = netdev_priv(ndev);
>  	unsigned long flags;
> @@ -2492,6 +2492,8 @@ static void ravb_set_rx_csum(struct net_device *ndev, bool enable)
>  	ravb_rcv_snd_enable(ndev);
>  
>  	spin_unlock_irqrestore(&priv->lock, flags);
> +
> +	return 0;
>  }
>  
>  static int ravb_endisable_csum_gbeth(struct net_device *ndev, enum ravb_reg reg,

   Wait! You're not updating the call site of ravb_set_rx_csum(), are you?
It looks like the above 2 hunks aren't needed...

[...]

MBR, Sergey

