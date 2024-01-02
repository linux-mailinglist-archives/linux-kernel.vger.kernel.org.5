Return-Path: <linux-kernel+bounces-14213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5CB5821930
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 10:54:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 319D4282DE8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 09:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36360CA69;
	Tue,  2 Jan 2024 09:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="OGJCQe8X"
X-Original-To: linux-kernel@vger.kernel.org
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA33C8C4;
	Tue,  2 Jan 2024 09:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4029rfb8004461;
	Tue, 2 Jan 2024 03:53:41 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1704189221;
	bh=74sdqSkVGxGgwTNR2R1XLLsqkxdGTod/LNAm1GoA48s=;
	h=Date:CC:Subject:To:References:From:In-Reply-To;
	b=OGJCQe8XSEJCKH187sP5V1JSoPpmqXv5QSaqH0w+uL79w3Qn/pevMwAD2ima0ji7B
	 YBxZ3RVnGnkp4JaNUgIxZHPpZLmr5YoDkyGQbxT2c78xiaoh/R4DqsDi9Rw73RL6nF
	 Z0KTo0uq+KjfRnpsiyu0NxCEyzkqHVEB+TMPSwbg=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4029rfDx070659
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 2 Jan 2024 03:53:41 -0600
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 2
 Jan 2024 03:53:41 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 2 Jan 2024 03:53:41 -0600
Received: from [10.249.131.186] ([10.249.131.186])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4029rbpD033320;
	Tue, 2 Jan 2024 03:53:38 -0600
Message-ID: <ff6c57ba-ff35-d7b4-482e-99673d202790@ti.com>
Date: Tue, 2 Jan 2024 15:23:37 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
CC: "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com"
	<edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        <s-vadapalli@ti.com>
Subject: Re: [PATCH 1/3] net: ethernet: ti: am65-cpsw: Fix max mtu to fit
 ethernet frames
Content-Language: en-US
To: =?UTF-8?B?U2FuanXDoW4gR2FyY8OtYSwgSm9yZ2U=?=
	<Jorge.SanjuanGarcia@duagon.com>
References: <20240102081825.14635-1-jorge.sanjuangarcia@duagon.com>
 <c025f2f9-ca2c-4fdb-adb1-803745fded0c.a613f387-0b3b-49fd-9401-3a0ed0c1f80e.61715cd4-eb1f-4175-83f7-1dd58ae46b17@emailsignatures365.codetwo.com>
 <20240102081825.14635-2-jorge.sanjuangarcia@duagon.com>
From: Siddharth Vadapalli <s-vadapalli@ti.com>
In-Reply-To: <20240102081825.14635-2-jorge.sanjuangarcia@duagon.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Hello,

On 02-01-2024 13:49, Sanjuán García, Jorge wrote:
> The value of AM65_CPSW_MAX_PACKET_SIZE represents the maximum length
> of a received frame. This value is written to the register
> AM65_CPSW_PORT_REG_RX_MAXLEN.
> 
> The maximum MTU configured on the network device should then leave
> some room for the ethernet headers and frame check. Otherwise, if
> the network interface is configured to its maximum mtu possible,
> the frames will be larger than AM65_CPSW_MAX_PACKET_SIZE and will
> get dropped as oversized.
> 
> Fixes: 93a76530316a ("net: ethernet: ti: introduce am65x/j721e gigabit eth 
> subsystem driver")
> Signed-off-by: Jorge Sanjuan Garcia <jorge.sanjuangarcia@duagon.com>

Please use [PATCH net] as the subject prefix for patches which are
posted as Bug Fixes. Apart from that, this patch looks good to me.

Reviewed-by: Siddharth Vadapalli <s-vadapalli@ti.com>

> ---
>   drivers/net/ethernet/ti/am65-cpsw-nuss.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c 
> b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
> index 7651f90f51f2..378d69b8cb14 100644
> --- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
> +++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
> @@ -2196,7 +2196,8 @@ am65_cpsw_nuss_init_port_ndev(struct am65_cpsw_common 
> *common, u32 port_idx)
>           eth_hw_addr_set(port->ndev, port->slave.mac_addr);
> 
>           port->ndev->min_mtu = AM65_CPSW_MIN_PACKET_SIZE;
> -       port->ndev->max_mtu = AM65_CPSW_MAX_PACKET_SIZE;
> +       port->ndev->max_mtu = AM65_CPSW_MAX_PACKET_SIZE -
> +                             (VLAN_ETH_HLEN + ETH_FCS_LEN);
>           port->ndev->hw_features = NETIF_F_SG |
>                                     NETIF_F_RXCSUM |
>                                     NETIF_F_HW_CSUM |

...

-- 
Regards,
Siddharth.

