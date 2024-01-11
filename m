Return-Path: <linux-kernel+bounces-23296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4246C82AAA3
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 10:19:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C99A2284672
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 09:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EB9D10962;
	Thu, 11 Jan 2024 09:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="0dp21seN"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7707101F2;
	Thu, 11 Jan 2024 09:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1704964728; x=1736500728;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=XK58nclcVRnIHE9fcfk+mcawlc/AKvXgWkq8pB197XQ=;
  b=0dp21seNZuFGmPNxMAGrsSp3GwcdOnnaY6mVsLnE69LdkzlQZZMsZbsf
   jlbgqA2l+FBATZDUb8O0KGr2IsvrhaLo3208lVI2mpcAP/hv4zK0HHWnA
   UVwbG0CxG7Xy4AW1wTz7JMhs1p0QQhszf2e5MInZ7A4bUVsFQ8d8v58Fs
   +bK6gmmu+8os1v7ycXgqpnID6cNG5vKnnmE8JYSpC6NZKHAVebs7WDX6q
   XsaHGwO1MDo1mKCOhqWioaoca7Ubsrd/lJGbcSYxAqgEsgEfFUI0BzJAx
   xwsKlz00Ce9CtLgjlWCMKbq9wklt33WMbbTYItmSNMIocegvMxzieYQsG
   g==;
X-CSE-ConnectionGUID: pyfMQCeHT/qwADty0xUwfQ==
X-CSE-MsgGUID: gmiEVHxnSUqJdF2eT86h/Q==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.04,185,1695711600"; 
   d="scan'208";a="15044071"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Jan 2024 02:18:46 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 11 Jan 2024 02:18:17 -0700
Received: from localhost (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 11 Jan 2024 02:18:17 -0700
Date: Thu, 11 Jan 2024 10:18:16 +0100
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: =?utf-8?B?U2FuanXDoW4gR2FyY8OtYSw=?= Jorge
	<Jorge.SanjuanGarcia@duagon.com>
CC: "andrew@lunn.ch" <andrew@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"s-vadapalli@ti.com" <s-vadapalli@ti.com>, "grygorii.strashko@ti.com"
	<grygorii.strashko@ti.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net v2 1/1] net: ethernet: ti: am65-cpsw: Fix max mtu to
 fit ethernet frames
Message-ID: <20240111091816.kdsqvs34b4z67w5f@DEN-DL-M31836.microchip.com>
References: <20240105085530.14070-1-jorge.sanjuangarcia@duagon.com>
 <20240105085530.14070-2-jorge.sanjuangarcia@duagon.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240105085530.14070-2-jorge.sanjuangarcia@duagon.com>

The 01/05/2024 08:55, Sanjuán García, Jorge wrote:
 
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
> Fixes: 93a76530316a ("net: ethernet: ti: introduce am65x/j721e gigabit eth subsystem driver")
> Signed-off-by: Jorge Sanjuan Garcia <jorge.sanjuangarcia@duagon.com>

In case you send a single patch then, it is not required to create a
cover letter. Other then that it looks OK.

Reviewed-by: Horatiu Vultur <horatiu.vultur@microchip.com>

> ---
>  drivers/net/ethernet/ti/am65-cpsw-nuss.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
> index 7651f90f51f2..3c7854537cb5 100644
> --- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
> +++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
> @@ -56,7 +56,7 @@
>  #define AM65_CPSW_MAX_PORTS    8
> 
>  #define AM65_CPSW_MIN_PACKET_SIZE      VLAN_ETH_ZLEN
> -#define AM65_CPSW_MAX_PACKET_SIZE      (VLAN_ETH_FRAME_LEN + ETH_FCS_LEN)
> +#define AM65_CPSW_MAX_PACKET_SIZE      2024
> 
>  #define AM65_CPSW_REG_CTL              0x004
>  #define AM65_CPSW_REG_STAT_PORT_EN     0x014
> @@ -2196,7 +2196,8 @@ am65_cpsw_nuss_init_port_ndev(struct am65_cpsw_common *common, u32 port_idx)
>         eth_hw_addr_set(port->ndev, port->slave.mac_addr);
> 
>         port->ndev->min_mtu = AM65_CPSW_MIN_PACKET_SIZE;
> -       port->ndev->max_mtu = AM65_CPSW_MAX_PACKET_SIZE;
> +       port->ndev->max_mtu = AM65_CPSW_MAX_PACKET_SIZE -
> +                             (VLAN_ETH_HLEN + ETH_FCS_LEN);
>         port->ndev->hw_features = NETIF_F_SG |
>                                   NETIF_F_RXCSUM |
>                                   NETIF_F_HW_CSUM |
> --
> 2.34.1
> 

-- 
/Horatiu

