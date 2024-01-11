Return-Path: <linux-kernel+bounces-23331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D494C82AB2D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 10:47:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B63121C21CF5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 09:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03A4D11C94;
	Thu, 11 Jan 2024 09:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="sc/mq8zK"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B00211722;
	Thu, 11 Jan 2024 09:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40B9kViR007843;
	Thu, 11 Jan 2024 03:46:31 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1704966391;
	bh=BkKV7jODf3A3P8yk03zMcE0wRaE/PUSWXFjUCTWGGoI=;
	h=Date:CC:Subject:To:References:From:In-Reply-To;
	b=sc/mq8zKVJsO+Y5zP8ISQ3K15joW/OKIWn9Iyy8JBHxhDKHntOEHRG2CUdqSXhmHU
	 5LgJs6Gm22IzGbg4eAkGsXGQdAG4yKLIlNJFDrsmFQ+T4GWMyQGAXC7WiBrWevurYc
	 E3j3r66qNTKuv8JTFNj7pci4IPrIE/XcyPtd4538=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40B9kVTx014661
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 11 Jan 2024 03:46:31 -0600
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 11
 Jan 2024 03:46:31 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 11 Jan 2024 03:46:31 -0600
Received: from [172.24.227.9] (uda0492258.dhcp.ti.com [172.24.227.9])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40B9kSoY029834;
	Thu, 11 Jan 2024 03:46:28 -0600
Message-ID: <524ea592-02d6-4a1d-899a-feaa7fd11914@ti.com>
Date: Thu, 11 Jan 2024 15:16:27 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        <s-vadapalli@ti.com>
Subject: Re: [PATCH net v2 1/1] net: ethernet: ti: am65-cpsw: Fix max mtu to
 fit ethernet frames
Content-Language: en-US
To: =?UTF-8?B?U2FuanXDoW4gR2FyY8OtYSwgSm9yZ2U=?=
	<Jorge.SanjuanGarcia@duagon.com>,
        "andrew@lunn.ch" <andrew@lunn.ch>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com"
	<edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>
References: <20240105085530.14070-1-jorge.sanjuangarcia@duagon.com>
 <c025f2f9-ca2c-4fdb-adb1-803745fded0c.a613f387-0b3b-49fd-9401-3a0ed0c1f80e.2e3f49f4-dbd1-4269-9bd1-2d3ffbda767f@emailsignatures365.codetwo.com>
 <20240105085530.14070-2-jorge.sanjuangarcia@duagon.com>
From: Siddharth Vadapalli <s-vadapalli@ti.com>
In-Reply-To: <20240105085530.14070-2-jorge.sanjuangarcia@duagon.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180



On 05/01/24 14:25, Sanjuán García, Jorge wrote:
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
> The switch supports ethernet frame sizes between 64 and 2024 bytes
> (including VLAN) as stated in the technical reference manual, so
> define AM65_CPSW_MAX_PACKET_SIZE with that maximum size.
> 
> Fixes: 93a76530316a ("net: ethernet: ti: introduce am65x/j721e gigabit eth 
> subsystem driver")
> Signed-off-by: Jorge Sanjuan Garcia <jorge.sanjuangarcia@duagon.com>

Reviewed-by: Siddharth Vadapalli <s-vadapalli@ti.com>

> ---
>   drivers/net/ethernet/ti/am65-cpsw-nuss.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c 
> b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
> index 7651f90f51f2..3c7854537cb5 100644
> --- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
> +++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
> @@ -56,7 +56,7 @@
>   #define AM65_CPSW_MAX_PORTS     8
> 
>   #define AM65_CPSW_MIN_PACKET_SIZE       VLAN_ETH_ZLEN
> -#define AM65_CPSW_MAX_PACKET_SIZE      (VLAN_ETH_FRAME_LEN + ETH_FCS_LEN)
> +#define AM65_CPSW_MAX_PACKET_SIZE      2024
> 
>   #define AM65_CPSW_REG_CTL               0x004
>   #define AM65_CPSW_REG_STAT_PORT_EN      0x014
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

..

-- 
Regards,
Siddharth.

