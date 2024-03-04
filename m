Return-Path: <linux-kernel+bounces-90436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EED3386FF25
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 11:34:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A0C5B21709
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 10:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E42DF2EB09;
	Mon,  4 Mar 2024 10:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="yUycssvT"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 891D51A29F;
	Mon,  4 Mar 2024 10:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709548448; cv=none; b=We0T+BOpWXFt2UPDEcDGnaD/YRXQI10EZvBIvekL6vQPo0mV3ONNN1wyAryx26AVA2vutMp4KPZ282PSM8ffEFgrADxEssx6wwGzfjG1LWQApu2xpqBdbAUidkTt8T1MhiWLxIR8NDwWB2ZOD1AYrAu+Y3LHWyJSEnr7c56QNVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709548448; c=relaxed/simple;
	bh=X8hStsCEoYVAZ6F/f5AhI30DQJROTSe1ABt+YDwR7qE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ha8Ry9PJe0MhdLQmebE4UxUBr1RkF2a0L1sMae/LkCiMpBgn/lBW34vw6dH4mAHMeIy6b9jJvJTJqiEvVX60448hq2QvIoR+AN6KC0IQ0wG1shIIxfxH2WVjCQ0foIl6lDP5QtOX0vmLwrMnVMmWXsGavO1QBbG3LD97jyhmjAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=yUycssvT; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 424AWsLm059411;
	Mon, 4 Mar 2024 04:32:54 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1709548374;
	bh=dGqTM/o/z/iQYnEvV+JIGkw/hQ9dTMU9/eegiOjtL5M=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=yUycssvT7jbKY/9r4s3Z10FR8/TIMGCoktkB2/v0KdDTs6LLJi0pLxOtSG0R9sOnW
	 EZ8Dgq0ea3oyebO8lT74vPPmwM8i/p9fRARDo0gxbRYeUuR16QYT11t/ldjSLjzsTU
	 rNZ1ZWKriCC6NQLJflHXzWD6FWaOq3oJbHxmpsog=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 424AWsR4004236
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 4 Mar 2024 04:32:54 -0600
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 4
 Mar 2024 04:32:53 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 4 Mar 2024 04:32:53 -0600
Received: from [172.24.227.88] (uda0500640.dhcp.ti.com [172.24.227.88])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 424AWn0D060483;
	Mon, 4 Mar 2024 04:32:49 -0600
Message-ID: <8d92dcbb-828d-17f4-d199-c625505e7b0c@ti.com>
Date: Mon, 4 Mar 2024 16:02:48 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] net: hsr: Use full string description when opening HSR
 network device
Content-Language: en-US
To: Lukasz Majewski <lukma@denx.de>, Oleksij Rempel <o.rempel@pengutronix.de>
CC: Eric Dumazet <edumazet@google.com>, Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, <netdev@vger.kernel.org>,
        <Tristram.Ha@microchip.com>,
        "Sebastian Andrzej
 Siewior" <bigeasy@linutronix.de>,
        Paolo Abeni <pabeni@redhat.com>,
        "Nikita
 Zhandarovich" <n.zhandarovich@fintech.ru>,
        Murali Karicheri
	<m-karicheri2@ti.com>,
        Ziyang Xuan <william.xuanziyang@huawei.com>,
        <linux-kernel@vger.kernel.org>,
        Ravi Gunasekaran <r-gunasekaran@ti.com>
References: <20240304093220.4183179-1-lukma@denx.de>
From: Ravi Gunasekaran <r-gunasekaran@ti.com>
In-Reply-To: <20240304093220.4183179-1-lukma@denx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180



On 3/4/24 3:02 PM, Lukasz Majewski wrote:
> Up till now only single character ('A' or 'B') was used to provide
> information of HSR slave network device status.
> 
> As it is also possible and valid, that Interlink network device may
> be supported as well, the description must be more verbose. As a result
> the full string description is now used.
> 
> Signed-off-by: Lukasz Majewski <lukma@denx.de>
> ---
>  net/hsr/hsr_device.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/net/hsr/hsr_device.c b/net/hsr/hsr_device.c
> index 9d71b66183da..9a60489fba96 100644
> --- a/net/hsr/hsr_device.c
> +++ b/net/hsr/hsr_device.c
> @@ -142,30 +142,29 @@ static int hsr_dev_open(struct net_device *dev)
>  {
>  	struct hsr_priv *hsr;
>  	struct hsr_port *port;
> -	char designation;
> +	char *designation = NULL;
>  
>  	hsr = netdev_priv(dev);
> -	designation = '\0';
>  
>  	hsr_for_each_port(hsr, port) {
>  		if (port->type == HSR_PT_MASTER)
>  			continue;
>  		switch (port->type) {
>  		case HSR_PT_SLAVE_A:
> -			designation = 'A';
> +			designation = "Slave A";

"designation" is now a pointer and is being assigned value
without even allocating memory for it.

>  			break;
>  		case HSR_PT_SLAVE_B:
> -			designation = 'B';
> +			designation = "Slave B";
>  			break;
>  		default:
> -			designation = '?';
> +			designation = "Unknown";
>  		}
>  		if (!is_slave_up(port->dev))
> -			netdev_warn(dev, "Slave %c (%s) is not up; please bring it up to get a fully working HSR network\n",
> +			netdev_warn(dev, "%s (%s) is not up; please bring it up to get a fully working HSR network\n",
>  				    designation, port->dev->name);
>  	}
>  
> -	if (designation == '\0')
> +	if (!designation)
>  		netdev_warn(dev, "No slave devices configured\n");
>  
>  	return 0;

-- 
Regards,
Ravi

