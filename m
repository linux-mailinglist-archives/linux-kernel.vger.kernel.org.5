Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59B9B76240B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 22:59:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231330AbjGYU7r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 16:59:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbjGYU7p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 16:59:45 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2068.outbound.protection.outlook.com [40.107.21.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D3DE1BF6;
        Tue, 25 Jul 2023 13:59:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QklMVshSrapWBrHawYKRXpGcQTmXv9jasQa7+zW0vambWBrz5wWWX4mZzM+59QSL+yMElOEdDoi6xtKF8BjBLq1Kpa3xuslavk4LOMXhrcyG7Xr5yQnQkqZtl11ZCXzp0tGQifuafA5mOZlqTh0O6RUqiyniSXd02BMHwVMPVVAZ6SFigHsU4vYi6JaMaqDfb5CCanT/XBnoSeeW0Hxxfz6uYXWyNlrWhd0UXAkj0CsbVD5OuAyoLJsrCg48AZN+JsDgH8gQcC4VXM3l4TLsO1yCfDG1oDCoPE9tjPXZmFWhLzBtr0orQpx3lmZenQY9hDStB1GQwToK7m+H+ty9/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HNqq7yAtrbsZpuYf0Moj0dFh9iP3Uq7J6wSe84pIrOk=;
 b=SpVZM5Ub8l7kuB6Dkkoitylo203VYpjJGCeIwuIxYBj+zD0mP2Ieyk/DtoeKpCebmRPc4CwC1TfYEgRwnU2qhadSi2ggq9wyviJPd+FmKDF3wrhpeVjuiVBelmo1pDqWlfikGGkEei9n7jDPMQU/fhZeaUndMfz+F6vC91kXkll/iPkJKiMP6M6a0BdF6yAUA7FKrgScvd7LdJT9paXtIKw7JTzaIsTK2NToeZYb1f2/SGswviyc1anYICSH//u8tEIr4D43ZbgSakmMYCKhU4hpZfVUB4oXpVVMNjKoYPSTmX/UjNz7BHthvQ+0HEWv5WZ2OTDZgTPRFNvbxSCJKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HNqq7yAtrbsZpuYf0Moj0dFh9iP3Uq7J6wSe84pIrOk=;
 b=pH4KlAgJFRIyEuYg+vogM5VMFKaowYUlHcLemXlp6Bu1VV75QlQdE4iZP5d52Tk/5+1vKi9IPsr3KHoNNXliEfSi21hqjLj0/2Vxa45KVP8KX4Xgx8+20kqtbBXWCRrdhb8eS5gFyfud2XMBEBuBPNXZ+RF2z1Bfk+I6AlOQauU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by DB9PR04MB8378.eurprd04.prod.outlook.com (2603:10a6:10:25f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Tue, 25 Jul
 2023 20:59:38 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::6074:afac:3fae:6194]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::6074:afac:3fae:6194%4]) with mapi id 15.20.6609.032; Tue, 25 Jul 2023
 20:59:38 +0000
Date:   Tue, 25 Jul 2023 23:59:33 +0300
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Ioana Ciornei <ioana.ciornei@nxp.com>,
        Simon Horman <simon.horman@corigine.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Josua Mayer <josua@solid-run.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Sean Anderson <sean.anderson@seco.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [v2] dpaa: avoid linking objects into multiple modules
Message-ID: <20230725205933.yqvdy3h7hewbjosy@skbuf>
References: <20230725204004.3366679-1-arnd@kernel.org>
 <20230725204004.3366679-1-arnd@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230725204004.3366679-1-arnd@kernel.org>
 <20230725204004.3366679-1-arnd@kernel.org>
X-ClientProxiedBy: VE1PR03CA0055.eurprd03.prod.outlook.com
 (2603:10a6:803:118::44) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|DB9PR04MB8378:EE_
X-MS-Office365-Filtering-Correlation-Id: 987a82df-9191-47d5-3913-08db8d520ec9
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PoC7Uw5zUtl0ouPGTq8BtLE7279sYfZOJTlfZiDt33llOtsYGmCu5HfhoHCrd2L7460PXuStx3uNCB//wE6fDWPMgSwnFakLHXEGnwEy8KOQgC7OknCMv5oeUJAMtKdLXCI1HShqOOKzO+vEM+ZcdXPuRNFkFv3BZoQHW4XnF/j7I538wnoJebcIPQP0/VWuBSbkmFdm4z9DJ0B5Zr/uO/6sn42EpFaWs+eEmpzWa0k6kHY9Hnvn+WvdhIKEYFSw3bTn2/K+QOToihfJeDyxnntfEMJPQaQunyDVbFSIbbldDXv/pw7T10rBgIsV4nLUXJ2p+miQFX5UE5Q6V8aQcy+8M/tv/CIoF+D1P9wpBWGocDwX3x0Es5ZGz6ETHiD7gXOe1sw0yMWoLWtB7taMRRrlXW7lYqc4gaDh4Bv4RqckVHbseYVVNxk8D29Lp8IEsKCDpXWdn/+CYdQlPx45cLC30u48zYItP5fn1xguJ1Zs9M9MdQCzTVfxy8FGS1Ew5QSbkDss8KNayAE7uo112f3jJRzlrnpVYHTBm96E+EQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(7916004)(376002)(396003)(346002)(39860400002)(366004)(136003)(451199021)(6506007)(186003)(1076003)(26005)(83380400001)(478600001)(54906003)(6666004)(86362001)(33716001)(66556008)(6486002)(41300700001)(316002)(66476007)(6916009)(66946007)(4326008)(2906002)(8936002)(8676002)(38100700002)(5660300002)(44832011)(7416002)(6512007)(9686003)(966005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jPIrNS7mIsmjpiH7d5yQR1/9sdWiyBoGtmkb+CqTg2dwXb+6qjCCHKWunD8x?=
 =?us-ascii?Q?/Sb/JLr7VCDPGoKhLnI1NZ5V0uoWbwEijxL70qZ1t793zfcrZ/IYxP/PeDHn?=
 =?us-ascii?Q?QIPCT9INMl5lCiLqbY4hKadKPo9NMEKyBOiMZ6yhH71wTV1RNP7yZYPNApiB?=
 =?us-ascii?Q?mJD34UwWVgB4mGS6K1S0bDSiMOvPJ0btcLzkjep2RgLjFD4leQb0/kYHsppE?=
 =?us-ascii?Q?uiXQ9vK+Y3Vz7NDRJ1SpMNta5kluXu332XgGp+iEqGufeHzOs9faNNUOhgik?=
 =?us-ascii?Q?9I4wOKkH8bqhMwJA25yM0Zd346hYsU5gouPOEu42KACrYWcbXBqIIPq14O9a?=
 =?us-ascii?Q?VFrK1ZCe5NY2Eyj06jdSsLQsCatpKXFbVvqxFjF4RJUqqJkNrFbcBEKHsK4m?=
 =?us-ascii?Q?qm56DeXHrDR0SWDlPIlEsaEWiONzNYZYVhfYrA+9kIFyXA43k+kv6RkXT8A5?=
 =?us-ascii?Q?qMGJeYQtp1Gxt77t+oT4L/PtRdkiGqlUicUHksxgYCnL3GuHpdRiBaqrg3sI?=
 =?us-ascii?Q?dHMjgaYUr9raE3O6BC07EiZtITppNahKoMBNEBT90Ayzc60T4M1xA6YcG3bf?=
 =?us-ascii?Q?MfzPSSMdlMAtMnd8y2KvPliRUlhjlsW4Mkfl/ROvOi3oLUp4Izy41ePwQvPt?=
 =?us-ascii?Q?NSjXrcSF9QZb8sRB7Nm8qsZyclfhFTLPNqZAV00ZPfjVmYF+ygoXkQ58vQxo?=
 =?us-ascii?Q?KJDQZxkeEZUxB9CW87I5yEQdyk/xbfcvqx3XIsMRleLkEA5e1BIhZ+YQJlMe?=
 =?us-ascii?Q?V/5E7ZTQqt4EqU9QdkScuH4n+xIMj6VHiReEmStwatAeRflPgdotKd4L4aM0?=
 =?us-ascii?Q?3LfjbJ3Bip5fLrmpqasnvd/1cOMXs5VFzkgJBPGKChd4zyAVIyaOsFqmJcR0?=
 =?us-ascii?Q?TTN7RnJQx3Xr35aGGHx9Gs9WorI1k4FYBFYW/Vd5YiEIgk82trfdp3rJ2ogp?=
 =?us-ascii?Q?x0mwIvrOIbAHZN7uKJiUBkn19iGyuSD6z0SV3cxikLi0fYsZSdY5c7fYKKkb?=
 =?us-ascii?Q?tA5eDh8mu2BpBEMD2kDoPysGsWxXbTPS1dES9FNOvDBa4r3lAk6ajJ0/oFlf?=
 =?us-ascii?Q?RRE0IZvP7QREXxY70vWycS/KXmKwuA2geOGY8esz6XG68fcJr0fszvMTYOTt?=
 =?us-ascii?Q?DTF0gaHXFtKJ7Az0GGIcKumMI6bm4Z+dnkG6hu24IN1Zn5s5JOhB/kMt4wFE?=
 =?us-ascii?Q?d+EnDQ+GeoyISDdqUkeNoLH3DYd27w7exLj5kfOgSkUVWtHW7w3mtFDojyDi?=
 =?us-ascii?Q?pbff0W4NIzhjfUDn7cBVVCs9hd/pFVfe6EmfHAIeqNQAKQG7UIGlLPWPnnqw?=
 =?us-ascii?Q?uhuAh+jdzGon95022ai513prQb09OByE6I3a6o7ocRkoaRX+1XtTTRmb6Vk3?=
 =?us-ascii?Q?cUpxecGgT8DsmAf6HRBX7ZV0Y/3/0+UCLpIaUdK8K7uM6Gs8dEifJx7vakwo?=
 =?us-ascii?Q?rBi4mtJf8N/Bws/+VLqlIGT2CcGiLmA6hxD3OYIW54efsjFEJzdy0D3iUmxk?=
 =?us-ascii?Q?EIdVBomD7rKWRB00aT3q7odJQ0UC1wsHjYbCDklKcHLztC+U0KzvwAIz5Gvk?=
 =?us-ascii?Q?7udgEZW+nqd84hNholySOY3r8V+wApQBH6sBjy1AfohhOQSS9dpyl8y+l4Dn?=
 =?us-ascii?Q?Tg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 987a82df-9191-47d5-3913-08db8d520ec9
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2023 20:59:38.0123
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pN/rMqQ5kB4+yxHFcwj7MnzU47qozk5vhjpjddi0gktnEMGDgy79hNi9EBVFYNqOLolstsDZwF4G5xDuc3PONA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8378
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On Tue, Jul 25, 2023 at 10:39:40PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Each object file contains information about which module it gets linked
> into, so linking the same file into multiple modules now causes a warning:
> 
> scripts/Makefile.build:254: drivers/net/ethernet/freescale/dpaa2/Makefile: dpaa2-mac.o is added to multiple modules: fsl-dpaa2-eth fsl-dpaa2-switch
> scripts/Makefile.build:254: drivers/net/ethernet/freescale/dpaa2/Makefile: dpmac.o is added to multiple modules: fsl-dpaa2-eth fsl-dpaa2-switch
> 
> Chang the way that dpaa2 is built by moving the two common files into a
> separate module with exported symbols instead.
> 
> To avoid a link failure when the switch driver is built-in, but the dpio driver
> is a loadable module, add the same dependency in there that exists for
> the ethernet driver.

Unrelated change should be separate.

> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> v2: add missing module description

There was a previous attempt at this before, by Alexander Lobakin:
https://patchwork.kernel.org/project/netdevbpf/patch/20221119225650.1044591-16-alobakin@pm.me/

but it seems he wasn't persistent enough with it.

Something which I liked better in his proposal was the naming of the
config option (FSL_DPAA2_MAC) and of the new module (fsl-dpaa2-mac).

Something which I like better in your proposal is the straightforward
EXPORT_SYMBOL_GPL rather than EXPORT_SYMBOL_NS_GPL() whose purpose I did
not understand.

A mix of the 2 would be great.

> ---
>  drivers/net/ethernet/freescale/Makefile          |  4 +---
>  drivers/net/ethernet/freescale/dpaa2/Kconfig     |  1 +
>  drivers/net/ethernet/freescale/dpaa2/Makefile    |  9 +++++----
>  drivers/net/ethernet/freescale/dpaa2/dpaa2-mac.c | 12 ++++++++++++
>  4 files changed, 19 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/ethernet/freescale/Makefile b/drivers/net/ethernet/freescale/Makefile
> index de7b318422330..c63e0c090f8f7 100644
> --- a/drivers/net/ethernet/freescale/Makefile
> +++ b/drivers/net/ethernet/freescale/Makefile
> @@ -22,6 +22,4 @@ ucc_geth_driver-objs := ucc_geth.o ucc_geth_ethtool.o
>  obj-$(CONFIG_FSL_FMAN) += fman/
>  obj-$(CONFIG_FSL_DPAA_ETH) += dpaa/
>  
> -obj-$(CONFIG_FSL_DPAA2_ETH) += dpaa2/
> -
> -obj-y += enetc/
> +obj-y += enetc/ dpaa2/
> diff --git a/drivers/net/ethernet/freescale/dpaa2/Kconfig b/drivers/net/ethernet/freescale/dpaa2/Kconfig
> index d029b69c3f183..4e26b5a4bc5c4 100644
> --- a/drivers/net/ethernet/freescale/dpaa2/Kconfig
> +++ b/drivers/net/ethernet/freescale/dpaa2/Kconfig
> @@ -32,6 +32,7 @@ config FSL_DPAA2_PTP_CLOCK
>  
>  config FSL_DPAA2_SWITCH
>  	tristate "Freescale DPAA2 Ethernet Switch"
> +	depends on FSL_MC_BUS && FSL_MC_DPIO
>  	depends on BRIDGE || BRIDGE=n
>  	depends on NET_SWITCHDEV
>  	help
> diff --git a/drivers/net/ethernet/freescale/dpaa2/Makefile b/drivers/net/ethernet/freescale/dpaa2/Makefile
> index 1b05ba8d1cbff..c042d2c27926c 100644
> --- a/drivers/net/ethernet/freescale/dpaa2/Makefile
> +++ b/drivers/net/ethernet/freescale/dpaa2/Makefile
> @@ -3,15 +3,16 @@
>  # Makefile for the Freescale DPAA2 Ethernet controller
>  #
>  
> -obj-$(CONFIG_FSL_DPAA2_ETH)		+= fsl-dpaa2-eth.o
> +obj-$(CONFIG_FSL_DPAA2_ETH)		+= fsl-dpaa2-eth.o fsl-dpaa2-common.o
>  obj-$(CONFIG_FSL_DPAA2_PTP_CLOCK)	+= fsl-dpaa2-ptp.o
> -obj-$(CONFIG_FSL_DPAA2_SWITCH)		+= fsl-dpaa2-switch.o
> +obj-$(CONFIG_FSL_DPAA2_SWITCH)		+= fsl-dpaa2-switch.o fsl-dpaa2-common.o

I am not completely sure how this works. Can fsl-dpaa2-common appear
both in obj-y (added by $(CONFIG_FSL_DPAA2_ETH)) and in obj-m (added by
$(CONFIG_FSL_DPAA2_SWITCH))? Olek proposed the introduction of a new,
hidden and selectable tristate FSL_DPAA2_MAC. At least I understand how
that works.

>  
> -fsl-dpaa2-eth-objs	:= dpaa2-eth.o dpaa2-ethtool.o dpni.o dpaa2-mac.o dpmac.o dpaa2-eth-devlink.o dpaa2-xsk.o
> +fsl-dpaa2-eth-objs	:= dpaa2-eth.o dpaa2-ethtool.o dpni.o dpaa2-eth-devlink.o dpaa2-xsk.o
>  fsl-dpaa2-eth-${CONFIG_FSL_DPAA2_ETH_DCB} += dpaa2-eth-dcb.o
>  fsl-dpaa2-eth-${CONFIG_DEBUG_FS} += dpaa2-eth-debugfs.o
>  fsl-dpaa2-ptp-objs	:= dpaa2-ptp.o dprtc.o
> -fsl-dpaa2-switch-objs	:= dpaa2-switch.o dpaa2-switch-ethtool.o dpsw.o dpaa2-switch-flower.o dpaa2-mac.o dpmac.o
> +fsl-dpaa2-switch-objs	:= dpaa2-switch.o dpaa2-switch-ethtool.o dpsw.o dpaa2-switch-flower.o
> +fsl-dpaa2-common-objs	+= dpaa2-mac.o dpmac.o
>  
>  # Needed by the tracing framework
>  CFLAGS_dpaa2-eth.o := -I$(src)
> diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-mac.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-mac.c
> index a69bb22c37eab..c51dbd84d199e 100644
> --- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-mac.c
> +++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-mac.c
> @@ -348,6 +348,7 @@ void dpaa2_mac_start(struct dpaa2_mac *mac)
>  
>  	phylink_start(mac->phylink);
>  }
> +EXPORT_SYMBOL_GPL(dpaa2_mac_start);
>  
>  void dpaa2_mac_stop(struct dpaa2_mac *mac)
>  {
> @@ -358,6 +359,7 @@ void dpaa2_mac_stop(struct dpaa2_mac *mac)
>  	if (mac->serdes_phy)
>  		phy_power_off(mac->serdes_phy);
>  }
> +EXPORT_SYMBOL_GPL(dpaa2_mac_stop);
>  
>  int dpaa2_mac_connect(struct dpaa2_mac *mac)
>  {
> @@ -450,6 +452,7 @@ int dpaa2_mac_connect(struct dpaa2_mac *mac)
>  
>  	return err;
>  }
> +EXPORT_SYMBOL_GPL(dpaa2_mac_connect);
>  
>  void dpaa2_mac_disconnect(struct dpaa2_mac *mac)
>  {
> @@ -462,6 +465,7 @@ void dpaa2_mac_disconnect(struct dpaa2_mac *mac)
>  	of_phy_put(mac->serdes_phy);
>  	mac->serdes_phy = NULL;
>  }
> +EXPORT_SYMBOL_GPL(dpaa2_mac_disconnect);
>  
>  int dpaa2_mac_open(struct dpaa2_mac *mac)
>  {
> @@ -510,6 +514,7 @@ int dpaa2_mac_open(struct dpaa2_mac *mac)
>  	dpmac_close(mac->mc_io, 0, dpmac_dev->mc_handle);
>  	return err;
>  }
> +EXPORT_SYMBOL_GPL(dpaa2_mac_open);
>  
>  void dpaa2_mac_close(struct dpaa2_mac *mac)
>  {
> @@ -519,6 +524,7 @@ void dpaa2_mac_close(struct dpaa2_mac *mac)
>  	if (mac->fw_node)
>  		fwnode_handle_put(mac->fw_node);
>  }
> +EXPORT_SYMBOL_GPL(dpaa2_mac_close);
>  
>  static char dpaa2_mac_ethtool_stats[][ETH_GSTRING_LEN] = {
>  	[DPMAC_CNT_ING_ALL_FRAME]		= "[mac] rx all frames",
> @@ -557,6 +563,7 @@ int dpaa2_mac_get_sset_count(void)
>  {
>  	return DPAA2_MAC_NUM_STATS;
>  }
> +EXPORT_SYMBOL_GPL(dpaa2_mac_get_sset_count);
>  
>  void dpaa2_mac_get_strings(u8 *data)
>  {
> @@ -568,6 +575,7 @@ void dpaa2_mac_get_strings(u8 *data)
>  		p += ETH_GSTRING_LEN;
>  	}
>  }
> +EXPORT_SYMBOL_GPL(dpaa2_mac_get_strings);
>  
>  void dpaa2_mac_get_ethtool_stats(struct dpaa2_mac *mac, u64 *data)
>  {
> @@ -587,3 +595,7 @@ void dpaa2_mac_get_ethtool_stats(struct dpaa2_mac *mac, u64 *data)
>  		*(data + i) = value;
>  	}
>  }
> +EXPORT_SYMBOL_GPL(dpaa2_mac_get_ethtool_stats);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("DPAA2 Ethernet core library");

s/core/MAC/ everywhere

> -- 
> 2.39.2
>

Also, the commit message prefix is wrong. "dpaa:" gets used for "drivers/net/ethernet/freescale/dpaa/".
DPAA(1) and DPAA2 have as much in common as King Charles II and Charles III.

pw-bot: cr
