Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38485767943
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 02:01:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235760AbjG2ABq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 20:01:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjG2ABj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 20:01:39 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2059.outbound.protection.outlook.com [40.107.15.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0046D3585;
        Fri, 28 Jul 2023 17:01:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cs1sOdEZRhqgPnIDmm7g40Zgq+Ga3DVEayfPji3b+Wq8D1RTy/6ROnNOEfa/l7zoQ44wyI+T2vQmPAAmHkoyflFnyrrYOtIrNmF0m+gicki98cK/kgZPPJsd4s091+J4XMVItbcNS9Aen1eO+iiXpR7HuKwdiU4KvTSwnESpWLsUU71oIsIJ1UohkkbgexzRkwB1qKb4zPRqBJUB1PtjAtMdI+nxlJe5SzEYf4aAn1j7BfgoOp0qQjKLdsltohSxEvzYxWG4QeXEwVjo9QGd+DRBrU/RgzWIQqWfZ/jYHjCTQYCVhuhtKk2Ha7wMEtl/nMWU6LRCJjoDGMEIgqOXcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6N3rgwTAEGjIF9pBuW6z5bB4w2VVB4cXoAf4XDpNZ4o=;
 b=MmOkdKegNhazoLEjipr6x4FY4v7XaoJp1sVb5+Az2eUOGJY1aMWVdbhzxDgB131ImDuXdriDi+vmpU1L+H7W67ZMl8kApprKAek+PHR7bRdwETQWMNnynPZoz3sBRgi9OMosaCx9yNqP82hHFGF45fw2RXpzrunX6SMOFcrG2hEMNpKAW0A32XQiOH/3cyFnk9jtG61T+Aut3u5A07gjhcfwTxlXgNnsOyWOC6uJl+pGH9RN4BU7vdhjrRR03bTw/8/+n/FyTmiC+LcdWgRKjV3hP1KpBZskSrTVHIMoJCoXrlT0ippOHNS98Veis1mKPLAKZssdHdhdogZzQgWhaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6N3rgwTAEGjIF9pBuW6z5bB4w2VVB4cXoAf4XDpNZ4o=;
 b=rUSE1r1GFgddVDuFNOWge3H4L8iRf3cwLwtpjE1/1HOYkuk2vGBebre+/A+b/PggiMj3BCXWJqk9sNK90qGC2no2mkMEdn2IFHurxDrPxfJQ2en/9NxhB+WGsL1USbfdBcKk7BBINqSHr/sI6z9Xa/WXQHsdLxEH/M2PTkbrMlI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by DUZPR04MB9824.eurprd04.prod.outlook.com (2603:10a6:10:4dc::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Sat, 29 Jul
 2023 00:01:32 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::6074:afac:3fae:6194]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::6074:afac:3fae:6194%4]) with mapi id 15.20.6631.039; Sat, 29 Jul 2023
 00:01:31 +0000
Date:   Sat, 29 Jul 2023 03:01:27 +0300
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     Roger Quadros <rogerq@kernel.org>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, s-vadapalli@ti.com, srk@ti.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] net: ethernet: ti: am65-cpsw-qos: Add Frame
 Preemption MAC Merge support
Message-ID: <20230729000127.fqwwp2j6rzyw6xth@skbuf>
References: <20230725072338.20789-1-rogerq@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230725072338.20789-1-rogerq@kernel.org>
X-ClientProxiedBy: FR0P281CA0187.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ab::17) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|DUZPR04MB9824:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fdbc563-f616-4b97-4a6e-08db8fc6f698
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 94hzDdFJgmIMOEYWwZ41aeb5dXZfx0dMBst2T5zj/PaAWT7paRDxcAV1reBEgtKErpap0sxd7v/bU+HIFtpJWfo75Y8Gvkr2AQcgoL+5bUTNt8YFonmL/XexMXYNOKEhCdG0FR1VhyhX/thwrcUee7vceztU3bSaeeEn73MyOooibKQfZbA7nfAfTKSN8jeMxAIaqh8UbNpu4JzkyZxz5twLNQELjPNKYYDj0N4qExFgA4msz0kWy2qZUsBYe/L7olAbV5neskewXa1VWsnK0bHOqSTYPnuP1V5nsutXaccmZdvOlfx6VWKutWar0OAjWMW+Usk1ZTABXw4+lHaw/lPXsS1vYaCbEpsgpSELfzzi+RlLV9+bn8Q+RraAMn5FjzoKo74MPb/4A0ggKhT6DQRC71WuLIwXQPYOQUL+9oX1YzXkojrw2b4np4HnVRR5lhjQr+WhUKXvpdRAVByry/CB+akOrkuffkXTkw3eSUcxv8cnc9go0Bub3YjWHark0R1YePsTzvPfVE+Eh3jbChnYMf4Sk/JgynSy1Lqdf9lv8Hh0R+anJ5wku80d0nvVwopbNE39X6244U+q1tpKCw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(4636009)(136003)(39860400002)(396003)(376002)(346002)(366004)(451199021)(6666004)(478600001)(6486002)(83380400001)(9686003)(6512007)(966005)(26005)(6916009)(6506007)(1076003)(4326008)(38100700002)(66476007)(66556008)(66946007)(186003)(44832011)(316002)(8936002)(8676002)(30864003)(41300700001)(2906002)(86362001)(5660300002)(33716001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZTVYSm5lcHRtZUxZaFNEWU9HYTYxQytjdldadWgxbUFsQXI1Kys1eVhobi9I?=
 =?utf-8?B?ZFhSVDMwN01uWG1Rb0tPNTJXblYwUDhkaW1pNC9LNDBFaWRRNFpsS0w1OTND?=
 =?utf-8?B?dTVSZnZxQy9YMjdhS0JvcUxBZTdqM2xGb0lZMlBnZ09hYUh4WmdLblpPdnUv?=
 =?utf-8?B?ekIzSENINlNCaSsvVXZ4d1VZRDUzYnZsTkV0Vnhzbi9UbGxSVzhwcU9xU2NW?=
 =?utf-8?B?bEhXclZSeVp1V0RoajdKQllXUjI2amxSakFkRmN4cFBkWllRaytoVU5pN3NJ?=
 =?utf-8?B?NlZwUGRoTTJlOTl6STRhOXBvaVJ1eU92cGhKa2lsWWtXWmFZOC9SRUVDYklu?=
 =?utf-8?B?L1BKVDVBQ3VHSnN5aWpJZ3FPRjIwN25XNVUwUjhCT3loK3ZEQkxTQm5MY01z?=
 =?utf-8?B?TDd6bzdqaFkvOEY4dGRUc2p4YytVTHZoQW9IQmNjRnkwVXpFVWlTMmxvTitB?=
 =?utf-8?B?S0ZaTlg4cVl2TFV1K3F4aFFSTnR5SFR6MnN2MXRRTFF2RGlmWTlRb2RZWkFO?=
 =?utf-8?B?Yy92NWFCenlTQU1LeDAyVUIzZUVSQll6cWhWdGk4UDk1OEN2aUJvK0VGK0xh?=
 =?utf-8?B?STdtOEF3R0MyWHl6VzF0NVVQaTFSTHkwcEVaOFowQkhtZDgvWFRPUHZpV0xU?=
 =?utf-8?B?V2djb2VEaUZsQzhjVGtUNjlDUUpzZE55eGxmVlkyWlRhTElPRzBJZlFQY3NF?=
 =?utf-8?B?bElGMlFBbEJzQlZaRFZpSG80Mzd1bEs1Y2o1SEx5emZjUlFMMVR1OVJmM0FN?=
 =?utf-8?B?cVF2RTNUck84SkdwRUhZbFhGeW1zK2VKS2hCenFMdWgxNDlOQjZma2Rrb044?=
 =?utf-8?B?RjVHM3Y3anEvdWJaQkVaQ1hoYytvR211VGw5bUF6a3ZtaDJSck9hQWNTeXIy?=
 =?utf-8?B?Z0NnN0hOeFIrYWo4NURlaHdza01NanlObzFFQlNWcmNMVVJtMEE2dTVQVEp2?=
 =?utf-8?B?blY0Y0lSUDI3c203NTJOTzBMbzAxU0pCOFFZZlFBSTgyMURScEVtMVMxN0NB?=
 =?utf-8?B?TUxHZGgwK09uR2xaaG5tM2xrWGRiV2xkNWpML2dnRERIcUNkamlkM2E5MmZm?=
 =?utf-8?B?UTB2cUVTbm42bTQ2STRkWktUcUp5UDl1Kzk5a0pkcG1LckxJTDlvTUM5cE1t?=
 =?utf-8?B?dVpZTXIzRDd3N1BVckNwdkVkcDV6MFc2WDZzYWd5Rm1JMFZZNjMwNUFHNHlE?=
 =?utf-8?B?SXJzckw0bFhhZWVYeFQ4NWNscUFveDA0VUcxR0VEMm85TkZzMXkxN0hJcVZ0?=
 =?utf-8?B?VS9LRkZIZDZTQTlIeFY5cWpyMm9XbUJLcjBsL1ZXWlpSNG5EejlSaVRWeGw1?=
 =?utf-8?B?ZWNVRFY0TFgwUVdqTUUyUlI1VHlPVmJLZllZVzlJSnJWcHRaaldlNC9Gemdq?=
 =?utf-8?B?WmxGWm9WNFZLVjhUa0VvQ3hwQmNOUUtBbnpPK1duMFREWDdzZnVZU21vbldr?=
 =?utf-8?B?VEcyeFFCek1EK2crb2dOalBCUFhHb3NZUnU4MHlRV0cxRGtOZ084b2RrSVk0?=
 =?utf-8?B?VDZ6elR0RHVhKzltbzBRZzF0aXk5MUdhTXZTT2loWGw3eHpGWEtFMnFDRHRi?=
 =?utf-8?B?bThDRmU4bFgvL1hNTTA4S3Z4bGtIZ29tdDIxaXJIWnhiT3RJejU4MGNBVHYv?=
 =?utf-8?B?NVd4a2hrUFo2M0RrZ3B1WXlpMHZkcGNBdEFNMmtmYWg5UDdoMjhsdHVRWlU2?=
 =?utf-8?B?dUY4Z1FyNXhNOGFrditIODh1dmFXVW1ubG1WK1R5QnM4V014VE4xRE1jd2Fj?=
 =?utf-8?B?RzZVa1FEZWFtT2N0dno3TEd5MHVQaEZVM1VDNjhKWkFpeUIwc2VhK3U3dUNZ?=
 =?utf-8?B?NEZvSGt1cUJINVhSZXNuTnZ2WVB6L2VzUFUzNkNtcC94V05BZ3YrMjhGOWU4?=
 =?utf-8?B?andHcEZEUlVxN2thMlU3YThpRDZaZk8vMUkyZ2RjK2FPbHBSYXJaNDdnOHFw?=
 =?utf-8?B?R0JTbWcvSXFOK0Y3cm9haTdybkZ1ZExoUzZoWG5rWmM4aU1qS0hhbllMTHRn?=
 =?utf-8?B?dVVGMjhEWUhKNXBHa3F0dTdDWktCc3AxVVpxcExIU0ZLVkxybnlJUG9uUEhK?=
 =?utf-8?B?dGhnN2EzZG9HOTdqYjk1TlpwYm5hR1pZVTMzeUR0bDlVa0hYOVNVeGZXTmNR?=
 =?utf-8?B?bEcvY1JranMrTDhSajc1SG8xWTZ5emorcVNOcFZ1NFJSeGlnMVlBOElobk5a?=
 =?utf-8?B?ckE9PQ==?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fdbc563-f616-4b97-4a6e-08db8fc6f698
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2023 00:01:30.9115
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N2DFIWszfFhizwTH1hr67287v+MslN1ZiCd0PaA8XHQVCtjYPhO5VRznkgXRARaRPYl2B42HWTpCBEG9ocXLyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9824
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Roger,

On Tue, Jul 25, 2023 at 10:23:38AM +0300, Roger Quadros wrote:
> Add driver support for viewing / changing the MAC Merge sublayer
> parameters and seeing the verification state machine's current state
> via ethtool.
> 
> As hardware does not support interrupt notification for verification
> events we resort to polling on link up. On link up we try a couple of
> times for verification success and if unsuccessful then give up.
> 
> The Frame Preemption feature is described in the Technical Reference
> Manual [1] in section:
> 	12.3.1.4.6.7 Intersperced Express Traffic (IET – P802.3br/D2.0)
> 
> Due to Silicon Errata i2208 [2] we set limit min IET fragment size to 124.
> 
> [1] AM62x TRM - https://www.ti.com/lit/ug/spruiv7a/spruiv7a.pdf
> [2] AM62x Silicon Errata - https://www.ti.com/lit/er/sprz487c/sprz487c.pdf

Thanks for the documentation.

> 
> Signed-off-by: Roger Quadros <rogerq@kernel.org>
> ---
> 
> Hi,
> 
> This is RFC because I've still not got Verification to work

What are you testing with? There's a selftest at tools/testing/selftests/net/forwarding/ethtool_mm.sh.

> and I'm still clueless on how to set the preemptible mask to set the
> preemtible queues. The driver doesn't yet support MQPRIO offloading.

I'm not sure what it is that you say you're clueless about. The user
space tooling for setting the preemptible traffic classes? You can take
the "fp" line of arguments from the mqprio command in the selftest
above, and transplant it to a taprio command you already have.

To avoid any confusion, please make sure that your iproute2 version has
commit e848ef0ad5d0 ("tc/taprio: fix parsing of "fp" option when it
doesn't appear last") applied.

> 
> Please let me know if overall approach is OK. Thanks.
> 
> cheers,
> -roger
> 
>  drivers/net/ethernet/ti/am65-cpsw-ethtool.c | 168 ++++++++++++++++
>  drivers/net/ethernet/ti/am65-cpsw-nuss.c    |   2 +
>  drivers/net/ethernet/ti/am65-cpsw-nuss.h    |   5 +
>  drivers/net/ethernet/ti/am65-cpsw-qos.c     | 212 ++++++++++++++++----
>  drivers/net/ethernet/ti/am65-cpsw-qos.h     |  90 +++++++++
>  5 files changed, 440 insertions(+), 37 deletions(-)
> 
> diff --git a/drivers/net/ethernet/ti/am65-cpsw-ethtool.c b/drivers/net/ethernet/ti/am65-cpsw-ethtool.c
> index c51e2af91f69..fd2ba29ebc0b 100644
> --- a/drivers/net/ethernet/ti/am65-cpsw-ethtool.c
> +++ b/drivers/net/ethernet/ti/am65-cpsw-ethtool.c
> @@ -11,6 +11,7 @@
>  #include <linux/pm_runtime.h>
>  
>  #include "am65-cpsw-nuss.h"
> +#include "am65-cpsw-qos.h"
>  #include "cpsw_ale.h"
>  #include "am65-cpts.h"
>  
> @@ -715,6 +716,171 @@ static int am65_cpsw_set_ethtool_priv_flags(struct net_device *ndev, u32 flags)
>  	return 0;
>  }
>  
> +/* enable common IET only if at least 1 port has pre-emptible queues. disable otherwise */
> +static void am65_cpsw_iet_enable(struct am65_cpsw_common *common)
> +{
> +	u32 common_enable = 0;
> +	u32 val;
> +	int i;
> +
> +	for (i = 0; i < common->port_num; i++)
> +		common_enable |= common->ports[i].qos.iet.preemptible_tcs;
> +
> +	val = readl(common->cpsw_base + AM65_CPSW_REG_CTL);
> +
> +	if (common_enable)
> +		val |= AM65_CPSW_CTL_IET_EN;
> +	else
> +		val &= ~AM65_CPSW_CTL_IET_EN;
> +
> +	writel(val, common->cpsw_base + AM65_CPSW_REG_CTL);
> +	common->iet_enabled = common_enable;
> +}

I see that IET_ENABLE is global to the switch. I wonder what it controls
exactly, since there's also a port-level IET_PORT_EN below.

Our interpretations (likely speculative both) seem to differ on how this
should be set. Let me just say a few words about the UAPI
(Documentation/networking/ethtool-netlink.rst and "man ethtool" would
hold the info).

Verification should succeed regardless of whether there is any preemptible
TC configured. The pmac-enabled knob (ETHTOOL_A_MM_PMAC_ENABLED) is
intended to control, among other things, whether the port responds to
verification frames from the link partner. IOW need pmac-enabled=true on
a port, before verify-enabled=true on the link partner can work. Also,
in the UAPI, tx-enabled=true requires pmac-enabled=true within the same
station.

The semantically closest hardware bit for pmac-enabled seems to be
IET_PORT_EN, and tx-enabled seems to correspond to MAC_PENABLE.

Whereas IET_ENABLE seems to be a global override for all, both RX and TX.

If I'm correct, you could implicitly set/unset IET_ENABLE depending on
whether IET_PORT_EN is set on any port, and in turn, set IET_PORT_EN
based on pmac-enabled.

> +
> +static void am65_cpsw_iet_port_enable(struct am65_cpsw_port *port, bool enable)
> +{
> +	u32 val;
> +
> +	val = readl(port->port_base + AM65_CPSW_PN_REG_CTL);
> +	if (enable)
> +		val |= AM65_CPSW_PN_CTL_IET_PORT_EN;
> +	else
> +		val &= ~AM65_CPSW_PN_CTL_IET_PORT_EN;
> +
> +	writel(val, port->port_base + AM65_CPSW_PN_REG_CTL);
> +}

Not too much documentation on what this does. If it's about being able
to process preemptible traffic on this port in general, then you are not
correct in hooking it to tx_enabled.

> +
> +static void am65_cpsw_iet_mac_penable(struct am65_cpsw_port *port, bool enable)
> +{
> +	u32 val;
> +
> +	val = readl(port->port_base + AM65_CPSW_PN_REG_IET_CTRL);
> +	if (enable)
> +		val |= AM65_CPSW_PN_IET_MAC_PENABLE;
> +	else
> +		val &= ~AM65_CPSW_PN_IET_MAC_PENABLE;
> +
> +	writel(val, port->port_base + AM65_CPSW_PN_REG_IET_CTRL);
> +}

At least the documentation seems to be clear here that hooking this to
tx_enabled seems to be the right thing.

> +
> +static int am65_cpsw_get_mm(struct net_device *ndev, struct ethtool_mm_state *state)
> +{
> +	struct am65_cpsw_port *port = am65_ndev_to_port(ndev);
> +	struct am65_cpsw_common *common = am65_ndev_to_common(ndev);
> +	struct am65_cpsw_ndev_priv *priv = netdev_priv(ndev);
> +	u32 port_ctrl, cmn_ctrl, iet_ctrl, iet_status, verify_cnt;
> +	u32 add_frag_size;
> +
> +	mutex_lock(&priv->mm_lock);
> +
> +	iet_ctrl = readl(port->port_base + AM65_CPSW_PN_REG_IET_CTRL);
> +	cmn_ctrl = readl(common->cpsw_base + AM65_CPSW_REG_CTL);
> +	port_ctrl = readl(port->port_base + AM65_CPSW_PN_REG_CTL);
> +
> +	state->pmac_enabled = !!(iet_ctrl & AM65_CPSW_PN_IET_MAC_PENABLE);
> +
> +	iet_status = readl(port->port_base + AM65_CPSW_PN_REG_IET_STATUS);
> +
> +	if (iet_ctrl & AM65_CPSW_PN_IET_MAC_DISABLEVERIFY)
> +		state->verify_status = ETHTOOL_MM_VERIFY_STATUS_DISABLED;
> +	else if (iet_status & AM65_CPSW_PN_MAC_VERIFIED)
> +		state->verify_status = ETHTOOL_MM_VERIFY_STATUS_SUCCEEDED;
> +	else if (iet_status & AM65_CPSW_PN_MAC_VERIFY_FAIL)
> +		state->verify_status = ETHTOOL_MM_VERIFY_STATUS_FAILED;
> +	else
> +		state->verify_status = ETHTOOL_MM_VERIFY_STATUS_UNKNOWN;
> +
> +	add_frag_size = AM65_CPSW_PN_IET_MAC_GET_ADDFRAGSIZE(iet_ctrl);
> +	state->tx_min_frag_size = ethtool_mm_frag_size_add_to_min(add_frag_size);
> +	state->rx_min_frag_size = state->tx_min_frag_size;

This is most likely wrong. You don't want rx_min_frag_size to follow tx_min_frag_size,
because tx_min_frag_size is settable (by ethtool, openlldp etc) and rx_min_frag_size
is not (it's an indication of what is the minimum fragment size that the port can receive).

In fact, the erratum i2208 you've linked to seems to be an RX issue, not
a TX one. So the correct workaround seems to be to set rx_min_frag_size
to 124, not to limit tx_min_frag_size as you've done?

> +
> +	state->tx_enabled = !!(port_ctrl & AM65_CPSW_PN_CTL_IET_PORT_EN);
> +
> +	/* FPE active if common IET enabled and verification success or disabled (forced) */
> +	state->tx_active = state->tx_enabled && !!(cmn_ctrl & AM65_CPSW_CTL_IET_EN) &&
> +			   (state->verify_status == ETHTOOL_MM_VERIFY_STATUS_SUCCEEDED ||
> +			    state->verify_status == ETHTOOL_MM_VERIFY_STATUS_DISABLED);
> +	state->verify_enabled = !(iet_ctrl & AM65_CPSW_PN_IET_MAC_DISABLEVERIFY);
> +
> +	verify_cnt = AM65_CPSW_PN_MAC_GET_VERIFY_CNT(readl(port->port_base +
> +							   AM65_CPSW_PN_REG_IET_VERIFY));
> +	state->verify_time = port->qos.iet.verify_time_ms;
> +	state->max_verify_time = am65_cpsw_iet_get_verify_timeout_ms(AM65_CPSW_PN_MAC_VERIFY_CNT_MASK,
> +								     SPEED_1000);

I guess this should return the verify_timeout_ms for the current speed,
with a fallback for SPEED_1000 if there's no link. Otherwise it may be
wrong for other speeds and openlldp may fail trying to set it to the max.

> +
> +	mutex_unlock(&priv->mm_lock);
> +
> +	return 0;
> +}
> +
> +static int am65_cpsw_set_mm(struct net_device *ndev, struct ethtool_mm_cfg *cfg,
> +			    struct netlink_ext_ack *extack)
> +{
> +	struct am65_cpsw_port *port = am65_ndev_to_port(ndev);
> +	struct am65_cpsw_ndev_priv *priv = netdev_priv(ndev);
> +	struct am65_cpsw_iet *iet = &port->qos.iet;
> +	u32 val, add_frag_size;
> +	int err;
> +
> +	/* Errata i2208: min fragment size cannot be less than 124 */
> +	if (cfg->tx_min_frag_size < 124) {
> +		netdev_err(ndev, "tx_min_fragment_size cannot be less than 124\n");

nitpick: use the extack (if the workaround is correct at all, see above)

> +		return -EINVAL;
> +	}
> +
> +	err = ethtool_mm_frag_size_min_to_add(cfg->tx_min_frag_size, &add_frag_size, extack);
> +	if (err)
> +		return err;
> +
> +	mutex_lock(&priv->mm_lock);
> +
> +	if (cfg->tx_enabled) {
> +		/* For IET, Change MAX_BLKS */
> +		if (!iet->original_max_blks)
> +			iet->original_max_blks = readl(port->port_base + AM65_CPSW_PN_REG_MAX_BLKS);
> +
> +		writel(AM65_CPSW_PN_TX_RX_MAX_BLKS_IET,
> +		       port->port_base + AM65_CPSW_PN_REG_MAX_BLKS);
> +	} else {
> +		/* restore MAX_BLKS to default */
> +		if (iet->original_max_blks) {
> +			writel(iet->original_max_blks,
> +			       port->port_base + AM65_CPSW_PN_REG_MAX_BLKS);
> +		}
> +	}

According to the documentation, it seems necessary to resize the RX FIFO
based on pmac_enabled, not tx_enabled.

> +
> +	am65_cpsw_iet_port_enable(port, cfg->tx_enabled);
> +	am65_cpsw_iet_mac_penable(port, cfg->tx_enabled);
> +
> +	val = readl(port->port_base + AM65_CPSW_PN_REG_IET_CTRL);
> +	if (cfg->verify_enabled) {
> +		val &= ~AM65_CPSW_PN_IET_MAC_DISABLEVERIFY;
> +		/* Reset Verify state machine. Verification won't start here.
> +		 * Verification will be done once link-up.
> +		 */
> +		val |= AM65_CPSW_PN_IET_MAC_LINKFAIL;
> +	} else {
> +		val |= AM65_CPSW_PN_IET_MAC_DISABLEVERIFY;
> +	}
> +
> +	val &= ~AM65_CPSW_PN_IET_MAC_MAC_ADDFRAGSIZE_MASK;
> +	val |= AM65_CPSW_PN_IET_MAC_SET_ADDFRAGSIZE(add_frag_size);
> +	writel(val, port->port_base + AM65_CPSW_PN_REG_IET_CTRL);
> +
> +	/* verify_timeout_count can only be set at valid link */
> +	port->qos.iet.verify_time_ms = cfg->verify_time;
> +
> +	/* iet common enable/disable */
> +	am65_cpsw_iet_enable(port->common);
> +
> +	/* enable/disable pre-emption based on link status */
> +	am65_cpsw_iet_commit_preemptible_tcs(port);
> +
> +	mutex_unlock(&priv->mm_lock);
> +
> +	return 0;
> +}
> +
>  const struct ethtool_ops am65_cpsw_ethtool_ops_slave = {
>  	.begin			= am65_cpsw_ethtool_op_begin,
>  	.complete		= am65_cpsw_ethtool_op_complete,
> @@ -743,4 +909,6 @@ const struct ethtool_ops am65_cpsw_ethtool_ops_slave = {
>  	.get_eee		= am65_cpsw_get_eee,
>  	.set_eee		= am65_cpsw_set_eee,
>  	.nway_reset		= am65_cpsw_nway_reset,
> +	.get_mm			= am65_cpsw_get_mm,
> +	.set_mm			= am65_cpsw_set_mm,
>  };
> diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
> index bebcfd5e6b57..b0e2d6773543 100644
> --- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
> +++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
> @@ -2160,6 +2160,8 @@ am65_cpsw_nuss_init_port_ndev(struct am65_cpsw_common *common, u32 port_idx)
>  	ndev_priv = netdev_priv(port->ndev);
>  	ndev_priv->port = port;
>  	ndev_priv->msg_enable = AM65_CPSW_DEBUG;
> +	mutex_init(&ndev_priv->mm_lock);
> +	port->qos.link_speed = SPEED_UNKNOWN;
>  	SET_NETDEV_DEV(port->ndev, dev);
>  
>  	eth_hw_addr_set(port->ndev, port->slave.mac_addr);
> diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.h b/drivers/net/ethernet/ti/am65-cpsw-nuss.h
> index bf40c88fbd9b..ede3a7457e9c 100644
> --- a/drivers/net/ethernet/ti/am65-cpsw-nuss.h
> +++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.h
> @@ -145,6 +145,7 @@ struct am65_cpsw_common {
>  	bool			pf_p0_rx_ptype_rrobin;
>  	struct am65_cpts	*cpts;
>  	int			est_enabled;
> +	int			iet_enabled;
>  
>  	bool		is_emac_mode;
>  	u16			br_members;
> @@ -170,6 +171,10 @@ struct am65_cpsw_ndev_priv {
>  	struct am65_cpsw_port	*port;
>  	struct am65_cpsw_ndev_stats __percpu *stats;
>  	bool offload_fwd_mark;
> +	/* Serialize access to MAC Merge state between ethtool requests
> +	 * and link state updates
> +	 */
> +	struct mutex		mm_lock;
>  };
>  
>  #define am65_ndev_to_priv(ndev) \
> diff --git a/drivers/net/ethernet/ti/am65-cpsw-qos.c b/drivers/net/ethernet/ti/am65-cpsw-qos.c
> index 3a908db6e5b2..ae30d5c79be8 100644
> --- a/drivers/net/ethernet/ti/am65-cpsw-qos.c
> +++ b/drivers/net/ethernet/ti/am65-cpsw-qos.c
> @@ -4,9 +4,11 @@
>   *
>   * quality of service module includes:
>   * Enhanced Scheduler Traffic (EST - P802.1Qbv/D2.2)
> + * Interspersed Express Traffic (IET - P802.3br/D2.0)
>   */
>  
>  #include <linux/pm_runtime.h>
> +#include <linux/units.h>
>  #include <linux/time.h>
>  #include <net/pkt_cls.h>
>  
> @@ -15,47 +17,176 @@
>  #include "am65-cpts.h"
>  #include "cpsw_ale.h"
>  
> -#define AM65_CPSW_REG_CTL			0x004
> -#define AM65_CPSW_PN_REG_CTL			0x004
> -#define AM65_CPSW_PN_REG_FIFO_STATUS		0x050
> -#define AM65_CPSW_PN_REG_EST_CTL		0x060
> -#define AM65_CPSW_PN_REG_PRI_CIR(pri)		(0x140 + 4 * (pri))
> -
> -/* AM65_CPSW_REG_CTL register fields */
> -#define AM65_CPSW_CTL_EST_EN			BIT(18)
> -
> -/* AM65_CPSW_PN_REG_CTL register fields */
> -#define AM65_CPSW_PN_CTL_EST_PORT_EN		BIT(17)
> -
> -/* AM65_CPSW_PN_REG_EST_CTL register fields */
> -#define AM65_CPSW_PN_EST_ONEBUF			BIT(0)
> -#define AM65_CPSW_PN_EST_BUFSEL			BIT(1)
> -#define AM65_CPSW_PN_EST_TS_EN			BIT(2)
> -#define AM65_CPSW_PN_EST_TS_FIRST		BIT(3)
> -#define AM65_CPSW_PN_EST_ONEPRI			BIT(4)
> -#define AM65_CPSW_PN_EST_TS_PRI_MSK		GENMASK(7, 5)
> -
> -/* AM65_CPSW_PN_REG_FIFO_STATUS register fields */
> -#define AM65_CPSW_PN_FST_TX_PRI_ACTIVE_MSK	GENMASK(7, 0)
> -#define AM65_CPSW_PN_FST_TX_E_MAC_ALLOW_MSK	GENMASK(15, 8)
> -#define AM65_CPSW_PN_FST_EST_CNT_ERR		BIT(16)
> -#define AM65_CPSW_PN_FST_EST_ADD_ERR		BIT(17)
> -#define AM65_CPSW_PN_FST_EST_BUFACT		BIT(18)
> -
> -/* EST FETCH COMMAND RAM */
> -#define AM65_CPSW_FETCH_RAM_CMD_NUM		0x80
> -#define AM65_CPSW_FETCH_CNT_MSK			GENMASK(21, 8)
> -#define AM65_CPSW_FETCH_CNT_MAX			(AM65_CPSW_FETCH_CNT_MSK >> 8)
> -#define AM65_CPSW_FETCH_CNT_OFFSET		8
> -#define AM65_CPSW_FETCH_ALLOW_MSK		GENMASK(7, 0)
> -#define AM65_CPSW_FETCH_ALLOW_MAX		AM65_CPSW_FETCH_ALLOW_MSK
> -
>  enum timer_act {
>  	TACT_PROG,		/* need program timer */
>  	TACT_NEED_STOP,		/* need stop first */
>  	TACT_SKIP_PROG,		/* just buffer can be updated */
>  };
>  
> +/* IET */
> +static int am65_cpsw_iet_set_verify_timeout_count(struct am65_cpsw_port *port)
> +{
> +	int link_speed = port->qos.link_speed;
> +	int verify_time_ms = port->qos.iet.verify_time_ms;

nitpick: gratuitous reverse xmas tree rule breakage

> +	u32 val;
> +
> +	if (link_speed == SPEED_UNKNOWN) {
> +		netdev_err(port->ndev, "%s called without active link\n", __func__);
> +		return -ENODEV;
> +	}

I guess you can use a simple WARN_ON() for code paths like this where it
is obvious that it can't trigger.

> +
> +	/* The number of wireside clocks contained in the verify
> +	 * timeout counter. The default is 0x1312d0
> +	 * (10ms at 125Mhz in 1G mode).
> +	 */
> +	val = 125 * HZ_PER_MHZ;	/* assuming 125MHz wireside clock */
> +
> +	val /= MILLIHZ_PER_HZ;		/* count per ms timeout */
> +	val *= verify_time_ms;		/* count for timeout ms */
> +	if (link_speed < SPEED_1000)
> +		val <<= 1;	/* FIXME: Is this correct? */

What indication do you have that you should do this shift?

> +
> +	if (val > AM65_CPSW_PN_MAC_VERIFY_CNT_MASK)
> +		return -EINVAL;
> +
> +	writel(val, port->port_base + AM65_CPSW_PN_REG_IET_VERIFY);
> +
> +	return 0;
> +}
> +
> +unsigned int am65_cpsw_iet_get_verify_timeout_ms(u32 count, int link_speed)
> +{
> +	unsigned int timeout_ms;
> +	u32 val = 125 * HZ_PER_MHZ;	/* assuming 125MHz wireside clock */
> +
> +	if (link_speed == SPEED_UNKNOWN)
> +		return -EINVAL;
> +
> +	val /= MILLIHZ_PER_HZ;		/* count per ms timeout */
> +
> +	timeout_ms = count / val;
> +
> +	if (link_speed < SPEED_1000)
> +		timeout_ms >>= 1;	/* FIXME: Is this correct? */
> +
> +	return timeout_ms;
> +}
> +
> +static int am65_cpsw_iet_verify_wait(struct am65_cpsw_port *port)
> +{
> +	u32 ctrl, status;
> +	int try;
> +
> +	ctrl = readl(port->port_base + AM65_CPSW_PN_REG_IET_CTRL);
> +	/* Clear MAC_PENABLE */
> +	ctrl &= ~AM65_CPSW_PN_IET_MAC_PENABLE;
> +	writel(ctrl, port->port_base + AM65_CPSW_PN_REG_IET_CTRL);
> +
> +	try = 20;
> +	do {
> +		/* Set MAC_PENABLE and Clear MAC_LINKFAIL bit to start Verify. */
> +		ctrl = readl(port->port_base + AM65_CPSW_PN_REG_IET_CTRL);
> +		ctrl &= ~AM65_CPSW_PN_IET_MAC_LINKFAIL;
> +		ctrl |= AM65_CPSW_PN_IET_MAC_PENABLE;
> +		writel(ctrl, port->port_base + AM65_CPSW_PN_REG_IET_CTRL);
> +
> +		msleep(port->qos.iet.verify_time_ms);
> +
> +		status = readl(port->port_base + AM65_CPSW_PN_REG_IET_STATUS);
> +		if (status & AM65_CPSW_PN_MAC_VERIFIED)
> +			return 0;
> +
> +		if (status & AM65_CPSW_PN_MAC_VERIFY_FAIL) {
> +			netdev_dbg(port->ndev,
> +				   "MM MAC verify failed, trying again");

nitpick: one of the Ms in MM stands for MAC already

> +			/* Reset the verify state machine by writing 1
> +			 * to LINKFAIL and 0 to MAC_PENABLE
> +			 */
> +			ctrl = readl(port->port_base + AM65_CPSW_PN_REG_IET_CTRL);
> +			ctrl &= ~AM65_CPSW_PN_IET_MAC_PENABLE;
> +			ctrl |= AM65_CPSW_PN_IET_MAC_LINKFAIL;
> +			writel(ctrl, port->port_base + AM65_CPSW_PN_REG_IET_CTRL);
> +			continue;
> +		}
> +
> +		if (status & AM65_CPSW_PN_MAC_RESPOND_ERR) {
> +			netdev_err(port->ndev, "MM MAC respond error");
> +			return -ENODEV;
> +		}
> +
> +		if (status & AM65_CPSW_PN_MAC_VERIFY_ERR) {
> +			netdev_err(port->ndev, "MM MAC verify error");
> +			return -ENODEV;
> +		}
> +	} while (try-- > 0);
> +
> +	netdev_info(port->ndev, "MM MAC verify timeout");
> +	return -ETIMEDOUT;

What error messages are you getting here? Timeout or an actual response
from hardware?

> +}
> +
> +static void am65_cpsw_iet_set_preempt_mask(struct am65_cpsw_port *port, u8 preemptible_tcs)
> +{
> +	u32 val;
> +
> +	val = readl(port->port_base + AM65_CPSW_PN_REG_IET_CTRL);
> +	val &= ~AM65_CPSW_PN_IET_MAC_PREMPT_MASK;
> +	val |= AM65_CPSW_PN_IET_MAC_SET_PREEMPT(preemptible_tcs);
> +	writel(val, port->port_base + AM65_CPSW_PN_REG_IET_CTRL);
> +}
> +
> +/* CPSW does not have an IRQ to notify changes to the MAC Merge TX status
> + * (active/inactive), but the preemptible traffic classes should only be
> + * committed to hardware once TX is active. Resort to polling.
> + */
> +void am65_cpsw_iet_commit_preemptible_tcs(struct am65_cpsw_port *port)
> +{
> +	u8 preemptible_tcs = 0;
> +	u32 val;
> +	int err;
> +
> +	if (port->qos.link_speed == SPEED_UNKNOWN)
> +		goto out;
> +
> +	val = readl(port->port_base + AM65_CPSW_PN_REG_CTL);
> +	if (!(val & AM65_CPSW_PN_CTL_IET_PORT_EN))
> +		goto out;
> +
> +	/* update verify count */
> +	err = am65_cpsw_iet_set_verify_timeout_count(port);
> +	if (err) {
> +		netdev_err(port->ndev, "couldn't set verify count: %d\n", err);
> +		return;
> +	}
> +
> +	val = readl(port->port_base + AM65_CPSW_PN_REG_IET_CTRL);
> +	if (!(val & AM65_CPSW_PN_IET_MAC_DISABLEVERIFY)) {
> +		err = am65_cpsw_iet_verify_wait(port);
> +		if (err)
> +			goto out;
> +	}
> +
> +	preemptible_tcs = port->qos.iet.preemptible_tcs;
> +out:
> +	am65_cpsw_iet_set_preempt_mask(port, preemptible_tcs);
> +}
> +
> +void am65_cpsw_iet_change_preemptible_tcs(struct am65_cpsw_port *port, u8 preemptible_tcs)
> +{
> +	port->qos.iet.preemptible_tcs = preemptible_tcs;
> +	am65_cpsw_iet_commit_preemptible_tcs(port);
> +}
> +
> +void am65_cpsw_iet_link_state_update(struct net_device *ndev)
> +{
> +	struct am65_cpsw_ndev_priv *priv = am65_ndev_to_priv(ndev);
> +	struct am65_cpsw_port *port = am65_ndev_to_port(ndev);
> +
> +	mutex_lock(&priv->mm_lock);
> +	am65_cpsw_iet_commit_preemptible_tcs(port);
> +	mutex_unlock(&priv->mm_lock);
> +}
> +
> +/* EST */
>  static int am65_cpsw_port_est_enabled(struct am65_cpsw_port *port)
>  {
>  	return port->qos.est_oper || port->qos.est_admin;
> @@ -541,7 +672,6 @@ static void am65_cpsw_est_link_up(struct net_device *ndev, int link_speed)
>  	ktime_t cur_time;
>  	s64 delta;
>  
> -	port->qos.link_speed = link_speed;
>  	if (!am65_cpsw_port_est_enabled(port))
>  		return;
>  
> @@ -565,10 +695,13 @@ static int am65_cpsw_setup_taprio(struct net_device *ndev, void *type_data)
>  {
>  	struct am65_cpsw_port *port = am65_ndev_to_port(ndev);
>  	struct am65_cpsw_common *common = port->common;
> +	struct tc_taprio_qopt_offload *taprio = type_data;
>  
>  	if (!IS_ENABLED(CONFIG_TI_AM65_CPSW_TAS))
>  		return -ENODEV;
>  
> +	am65_cpsw_iet_change_preemptible_tcs(port, taprio->mqprio.preemptible_tcs);
> +
>  	if (!netif_running(ndev)) {
>  		dev_err(&ndev->dev, "interface is down, link speed unknown\n");
>  		return -ENETDOWN;
> @@ -801,6 +934,9 @@ void am65_cpsw_qos_link_up(struct net_device *ndev, int link_speed)
>  {
>  	struct am65_cpsw_port *port = am65_ndev_to_port(ndev);
>  
> +	port->qos.link_speed = link_speed;
> +	am65_cpsw_iet_link_state_update(ndev);
> +
>  	if (!IS_ENABLED(CONFIG_TI_AM65_CPSW_TAS))
>  		return;
>  
> @@ -812,13 +948,15 @@ void am65_cpsw_qos_link_down(struct net_device *ndev)
>  {
>  	struct am65_cpsw_port *port = am65_ndev_to_port(ndev);
>  
> +	port->qos.link_speed = SPEED_UNKNOWN;
> +	am65_cpsw_iet_link_state_update(ndev);
> +
>  	if (!IS_ENABLED(CONFIG_TI_AM65_CPSW_TAS))
>  		return;
>  
>  	if (!port->qos.link_down_time)
>  		port->qos.link_down_time = ktime_get();
>  
> -	port->qos.link_speed = SPEED_UNKNOWN;
>  }
>  
>  static u32
> diff --git a/drivers/net/ethernet/ti/am65-cpsw-qos.h b/drivers/net/ethernet/ti/am65-cpsw-qos.h
> index 0cc2a3b3d7f9..2cfb18e6587d 100644
> --- a/drivers/net/ethernet/ti/am65-cpsw-qos.h
> +++ b/drivers/net/ethernet/ti/am65-cpsw-qos.h
> @@ -9,6 +9,7 @@
>  #include <net/pkt_sched.h>
>  
>  struct am65_cpsw_common;
> +struct am65_cpsw_port;
>  
>  struct am65_cpsw_est {
>  	int buf;
> @@ -16,6 +17,13 @@ struct am65_cpsw_est {
>  	struct tc_taprio_qopt_offload taprio;
>  };
>  
> +struct am65_cpsw_iet {
> +	struct ethtool_mm_cfg *cfg;

Leftover? This pointer is stale outside of am65_cpsw_set_mm().

> +	u8 preemptible_tcs;
> +	u32 original_max_blks;
> +	int verify_time_ms;
> +};
