Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 716D27F2164
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 00:26:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbjKTX0d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 18:26:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjKTX0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 18:26:31 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2089.outbound.protection.outlook.com [40.107.22.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 695B0A0;
        Mon, 20 Nov 2023 15:26:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gFGtz/Xjw5UvVmW4KUnhGUKZgjAemVBy2dXIFyuB08ikIq5jGsWe/PqShlebna25BqnSrB5JZoXdTEraueEiQRYIn+MokZfGviHKJ3FNhxDaTcTD4OzgxAEQWbUl1QO1YwUNOtZXSWIZTaWFziIA53Btg8B8LxBJNMXGlWVJ3BM5LzXU2zcFXyPYYhWz/TuHOGiCT75gH0cR9+stnlzaSqSXuIBgSC6n55eS2hlbJ9gcwRHhRD+9vuPQQvtY85i6VyGoBN6qMryYi/aHd+ok8vaoKv07FvEMKQxgQ+0aSdIryZ/0tGbCY6mTF14TpnIwZi0cC2FTPP1MLxygbk8bPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wGjkXEXvwGtbNUKMyir4oDhjSOGzqQJhEsWuKcaXs5Q=;
 b=fG7uV442mpE5jpP8FbHi08aCTN/dIzqQukuzuWFUkH6iGZ4ZHFy5U+2co2LUj3pezEYc4CkemLLxgjBWZvPocHWq6WYA0Uzh7lC5VchOIyvu/ep0wIO/iZK7auDQg/SXWj3sL3kZTXUmqNDyeIf4Dwrv1rKwCOixcNU1HEOpt1r/al0dBq8vMt6yT4iEQok5Csd9MkXn+GTVEQuOLfbdoELduq+S65fZAfr1DOYaFHRPghElFsyeB26SnkYUriMQHoorjB4PFzOxDOzWryr1S98PqttgZTjBmGdiUgHZ+ibwMNEVkJfnNvgtQlQjDRPyjM4m2xf+xugbqSQsGdKvvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wGjkXEXvwGtbNUKMyir4oDhjSOGzqQJhEsWuKcaXs5Q=;
 b=DIzBGEwqxDFNlFwqrPoI/nJec7jaGflO+m/n2XqbwUxjVBazo5iQmvL8peS83jdNtgCq2JrH72M5P1ueZXI6jqWgb+aV47NfiMy/LIEEkUce1xX/7kvGVqWrhYpfEs8PQF+JQnduZi7ePTjYIY7tn2vnbrrw9BdPr0M/s3rLVn8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by VI1PR04MB6831.eurprd04.prod.outlook.com (2603:10a6:803:135::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.16; Mon, 20 Nov
 2023 23:26:24 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4%7]) with mapi id 15.20.7025.017; Mon, 20 Nov 2023
 23:26:24 +0000
Date:   Tue, 21 Nov 2023 01:26:20 +0200
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     Roger Quadros <rogerq@kernel.org>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, s-vadapalli@ti.com, r-gunasekaran@ti.com,
        vigneshr@ti.com, srk@ti.com, horms@kernel.org, p-varis@ti.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 net-next 6/7] net: ethernet: ti: am65-cpsw-qos: Add
 Frame Preemption MAC Merge support
Message-ID: <20231120232620.uciap4bazypzlg3g@skbuf>
References: <20231120140147.78726-1-rogerq@kernel.org>
 <20231120140147.78726-7-rogerq@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231120140147.78726-7-rogerq@kernel.org>
X-ClientProxiedBy: AM8P190CA0021.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:219::26) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|VI1PR04MB6831:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f36ae2c-a336-4c2b-6635-08dbea201c6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W4gZJduCPVYQO8I+LfZfKvRzXJ9GHIjJu8CbX7dhHg3E6j4w3lEq70QC5fWtKt+xmz2uuKRTvAGe28eDeVJ7s9igfMGA422Qe6JaKqkSh8YHi91zzq+7ShSH71P0jEaf5cRk/pSFLpW1PUjYajGy60fO1enwONCDR8VZovagVGxOddlW1ptME6EfmPyFIQ3Q6psZasVe6abHxEDc5VBnCQAucfXm8GeAgNydaPfQmp1jI898vZBwQ4ZE5MXkpBTvW0WG9OEgsjbMjVMdDKbZCrb7fASSE5phkDbSHMhlHDXT8Ab3JpSicWycFQmqX0u4bggedKzqENWNiTPRVQY9TlTM3i37OEKKtpOqekfj2OIHpbtJdTDJJg/tzWzAnwyVV+cXt2W2dKb0GW5FwlXioQKEkQYBCgEmQXQ1a4FjUlyw9j4ssJpdLuKC1Mc9Q7a/8s18DNF5DE5Bb0OBv2LNqhJB2zHRDU5AJkK5qOfLe3qByhNun4R10mXmaSp/BNDSarRMa/pTmfEh3GZ3vVg0fLo+1j2X8/zD/QqP3ynme4ZBhJKGyRS6kxKYmiES7HKfpfupvHaEKuIpZABi9Z6qxy/V45MgyahpzXwXewDxRq4p6CT8QzI5Pkia5+YYiHxN
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(39860400002)(376002)(396003)(366004)(136003)(230173577357003)(230922051799003)(230273577357003)(451199024)(64100799003)(186009)(1800799012)(316002)(6916009)(66946007)(66476007)(66556008)(9686003)(6512007)(6666004)(6506007)(26005)(1076003)(6486002)(478600001)(38100700002)(33716001)(83380400001)(86362001)(44832011)(2906002)(7416002)(5660300002)(8936002)(4326008)(8676002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PBE2JUdWrivwjZh9GUz6QubWgHahbln02xxeOJ/JX2aqkhtArXG9ZxvvbxxK?=
 =?us-ascii?Q?Qka3CKKUWs/bkw6whYTohu0UHXSf2CsMrvEciT/2i27WdEe3EE+PphGROPZo?=
 =?us-ascii?Q?NrxceMO4kk8u+N0zikH3EbgdJt39V8wb3kUZf21xAG6tr8r9zJtITeIBDOhT?=
 =?us-ascii?Q?F4x9YsGirnIB4slCqj89DfCmBUqm4SzAZjbjvvITFaFJ53TXfckHeSgKsSqU?=
 =?us-ascii?Q?tZdyZvdYI8f/ojkIMjBkiY7ftovvdbV7LSLAQoYtczcnIb4t8mqsRHsfRZch?=
 =?us-ascii?Q?/XbRxfEoxF96GT4NSO67ewr9C9HiIkHpke376zaRSDy7+9MJU8F/zKQTgEU8?=
 =?us-ascii?Q?Y5/RO4ZeL0mae1tEwhtSOdtfAErtEhycSvQILVU5DZBozlwX1d8NuX5eJ0Qo?=
 =?us-ascii?Q?N+KQOKTgw5BJbVfv73WeTn7PZsQAd+5pMovDtGXifY84C3UqsdgG9vlGCmd3?=
 =?us-ascii?Q?YGGYjlulvbZlLSTWuLbVR6dz80830IRIlOkXGoAzp1sg/2zrlzFZ/T8MmE/b?=
 =?us-ascii?Q?L0EDxgROJGv7mp+SZZzwrrMBFKfuhnMtWEX9LeqBLQ6peK04rgn+jlk79jx9?=
 =?us-ascii?Q?XVjOcIJmdD3YrCo4lkLXqhoQ9fIeg5yHu8EBUbfiNHadbg5lvPKwlLddrDF1?=
 =?us-ascii?Q?1kUzHHSUcUeUmb+1tgQE550qYW35WPE0HVPckQPaxcmJjdlvCsQyn2NxsyCt?=
 =?us-ascii?Q?OQ8m88D7Evq7nyvQrOvgEe1FVNvpdI6ldR8zBy8U03zxhh30gQVs0dqBVgkQ?=
 =?us-ascii?Q?MfdEACvuG4TfXYtTw1H6bak1X1sDUzB16pAOC0kOU/3MeCcNrAZaV3S0VtW0?=
 =?us-ascii?Q?dUd5VidKwm7CDmcDduxJzKCeFux5EKEKaj4XPvoY1pvb2CBLNJAXSZ3fwEU1?=
 =?us-ascii?Q?IzfZgrDQnC2XwFY9jwh1DI+ED8FNdaWuC1xhGIaaf1jkW6LchVb99QIJ53LX?=
 =?us-ascii?Q?42LfGZAlWR1j5ii3pcayBYL+ghC49hsxtFTHzg1TYMgzNqxmxp0wmhXcJHDN?=
 =?us-ascii?Q?+pZH6vdKKuwCO8Ps22R4evO0xMPBqB3bG4avg9qfCn7FHbbSxP32pcyAKHSZ?=
 =?us-ascii?Q?ShvmWXPC9SIXYeHnnv4zGgzWcv5VMhf367IeA/85nu+htk+oFLH6ilzGrh1Z?=
 =?us-ascii?Q?y75rMdHooFT/1qKwvdcs24HIF9V1j7koXUoQDzlbsqX6gVqenG5Fmx5hQ7t3?=
 =?us-ascii?Q?9CdfRESj9JQ1Z73jhhOLAamNOKrqmsModH8abTPoDFcXeKC3L3k65++1rUbC?=
 =?us-ascii?Q?Sbu/A/8hm3/V6xen3jsbo56i0R4++1Yhv8qRL+ax+HPazlhKZXkhiCG7xTbE?=
 =?us-ascii?Q?j498oYiVYXf3uwZMbSmQxCShIvy8BAZGEqYMo3c5QeEE3cRtrvwvDuJgnRRu?=
 =?us-ascii?Q?Pl27Zf4InGOBHfJ/s59GfhWlr8eKGYhxXCAiYfipPhuUvA64RqBy0YA9IJ9q?=
 =?us-ascii?Q?dnAnVUHpIL4URDNszUlr0dcGr8oKWVhAGS7uSxJrhoHjWXS410DkLT7ll08b?=
 =?us-ascii?Q?Sv7yc7i9XkAqvBoT9MKhNpC/Z4Axu4nnSwpSSije6LQXmQc6kcQZsF6Tz3t/?=
 =?us-ascii?Q?MHW+dnzZRWfT0wirjImWu49rByt4BliKHRENeOs/ngxL45hwWFP2wrrDpTfj?=
 =?us-ascii?Q?iw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f36ae2c-a336-4c2b-6635-08dbea201c6a
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2023 23:26:24.0663
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n/QdBU1tOEzUea+7dJFrNkRFJV1MddCUaKk+X9GugRc19U9dCLbhPjFCx7eUT+uZl8aln78dj3PaGW9rewTO3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6831
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 20, 2023 at 04:01:46PM +0200, Roger Quadros wrote:
> Changelog:
> 
> v6:
> - get mutex around am65_cpsw_iet_commit_preemptible_tcs() in
>   am65_cpsw_iet_change_preemptible_tcs()
> - use "preemption" instead of "pre-emption"
> - call am65_cpsw_setup_mqprio() from within am65_cpsw_setup_taprio()
> - Now works with kselftest except the last test which fails
> 
> root@am62xx:~/kselftest# ./run_kselftest.sh -t net/forwarding:ethtool_mm.sh
> # TEST: Manual configuration with verification: eth0 to eth1          [ OK ]
> # TEST: Manual configuration with verification: eth1 to eth0          [ OK ]
> # TEST: Manual configuration without verification: eth0 to eth1       [ OK ]
> # TEST: Manual configuration without verification: eth1 to eth0       [ OK ]
> # TEST: Manual configuration with failed verification: eth0 to eth1   [ OK ]
> # TEST: Manual configuration with failed verification: eth1 to eth0   [ OK ]
> # Warning: Stopping lldpad.service, but it can still be activated by:
> #   lldpad.socket
> # TEST: LLDP                                                          [FAIL]
> #       eth0 pMAC TX is not active

Interesting, but why?

Could you disable all tests except the one that fails, then re-run with
verbose shell output, spawn a child interactive shell right after the
command that fails, run it by hand without the grep (copying it from the
verbose output just one line above) and see what output it gives,
compared to what it should?

diff --git a/tools/testing/selftests/net/forwarding/ethtool_mm.sh b/tools/testing/selftests/net/forwarding/ethtool_mm.sh
index 39e736f30322..2340051742b6 100755
--- a/tools/testing/selftests/net/forwarding/ethtool_mm.sh
+++ b/tools/testing/selftests/net/forwarding/ethtool_mm.sh
@@ -2,12 +2,6 @@
 # SPDX-License-Identifier: GPL-2.0
 
 ALL_TESTS="
-	manual_with_verification_h1_to_h2
-	manual_with_verification_h2_to_h1
-	manual_without_verification_h1_to_h2
-	manual_without_verification_h2_to_h1
-	manual_failed_verification_h1_to_h2
-	manual_failed_verification_h2_to_h1
 	lldp
 "
 
@@ -170,6 +164,8 @@ lldp()
 {
 	RET=0
 
+	set -x
+
 	systemctl start lldpad
 
 	# Configure the interfaces to receive and transmit LLDPDUs
@@ -185,6 +181,10 @@ lldp()
 
 	lldptool -i $h1 -t -n -V addEthCaps | \
 		grep -q "Preemption capability active"
+
+	set +x
+	bash
+
 	check_err "$?" "$h1 pMAC TX is not active"
 
 	lldptool -i $h2 -t -n -V addEthCaps | \

You have the openlldp compiled from the master branch so that it has
preemption/MAC merge support, right? We just "require_command lldptool"
but we don't probe for this functionality, as opposed to tc and ethtool.

> diff --git a/drivers/net/ethernet/ti/am65-cpsw-ethtool.c b/drivers/net/ethernet/ti/am65-cpsw-ethtool.c
> index b9e1d568604b..6af00640e99c 100644
> --- a/drivers/net/ethernet/ti/am65-cpsw-ethtool.c
> +++ b/drivers/net/ethernet/ti/am65-cpsw-ethtool.c
> @@ -740,6 +741,157 @@ static int am65_cpsw_set_ethtool_priv_flags(struct net_device *ndev, u32 flags)
>  	return 0;
>  }
>  
> +static int am65_cpsw_set_mm(struct net_device *ndev, struct ethtool_mm_cfg *cfg,
> +			    struct netlink_ext_ack *extack)
> +{
> +	struct am65_cpsw_port *port = am65_ndev_to_port(ndev);
> +	struct am65_cpsw_ndev_priv *priv = netdev_priv(ndev);
> +	struct am65_cpsw_iet *iet = &port->qos.iet;
> +	u32 val, add_frag_size;
> +	int err;
> +
> +	err = ethtool_mm_frag_size_min_to_add(cfg->tx_min_frag_size, &add_frag_size, extack);
> +	if (err)
> +		return err;
> +
> +	mutex_lock(&priv->mm_lock);
> +
> +	if (cfg->pmac_enabled) {
> +		/* change TX & RX FIFO MAX_BLKS as per TRM recommendation */
> +		if (!iet->original_max_blks)
> +			iet->original_max_blks = readl(port->port_base + AM65_CPSW_PN_REG_MAX_BLKS);
> +
> +		writel(AM65_CPSW_PN_TX_RX_MAX_BLKS_IET,
> +		       port->port_base + AM65_CPSW_PN_REG_MAX_BLKS);
> +	} else {
> +		/* restore RX & TX FIFO MAX_BLKS */
> +		if (iet->original_max_blks) {

else {
	if ()
}

can be written as

else if () {
}

> +			writel(iet->original_max_blks,
> +			       port->port_base + AM65_CPSW_PN_REG_MAX_BLKS);
> +		}
> +	}
> +
> +	am65_cpsw_port_iet_rx_enable(port, cfg->pmac_enabled);
> +	am65_cpsw_port_iet_tx_enable(port, cfg->tx_enabled);
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
> +		/* Clear LINKFAIL to allow verify/response packets */
> +		val &= ~AM65_CPSW_PN_IET_MAC_LINKFAIL;
> +	}
> +
> +	val &= ~AM65_CPSW_PN_IET_MAC_MAC_ADDFRAGSIZE_MASK;
> +	val |= AM65_CPSW_PN_IET_MAC_SET_ADDFRAGSIZE(add_frag_size);
> +	writel(val, port->port_base + AM65_CPSW_PN_REG_IET_CTRL);
> +
> +	/* verify_timeout_count can only be set at valid link */
> +	if (cfg->verify_time > 0)
> +		port->qos.iet.verify_time_ms = cfg->verify_time;
> +	else
> +		port->qos.iet.verify_time_ms = 10;
> +
> +	/* enable/disable preemption based on link status */
> +	am65_cpsw_iet_commit_preemptible_tcs(port);
> +
> +	mutex_unlock(&priv->mm_lock);
> +
> +	return 0;
> +}
> diff --git a/drivers/net/ethernet/ti/am65-cpsw-qos.c b/drivers/net/ethernet/ti/am65-cpsw-qos.c
> index 60f625e1350b..8443c13c9ff6 100644
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

If this was ordered alphabetically, u comes after t.

>  #include <linux/time.h>
>  #include <net/pkt_cls.h>
>  
> @@ -259,6 +266,196 @@ static int am65_cpsw_setup_mqprio(struct net_device *ndev, void *type_data)
>  	return ret;
>  }
>  
> +static int am65_cpsw_iet_set_verify_timeout_count(struct am65_cpsw_port *port)
> +{
> +	int verify_time_ms = port->qos.iet.verify_time_ms;
> +	int link_speed = port->qos.link_speed;
> +	u32 val;
> +
> +	if (WARN_ON(link_speed == SPEED_UNKNOWN))
> +		return -ENODEV;
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

Is there any way to find out and remove the FIXME? Like running the
selftest at SPEED_100?

> +
> +	if (val > AM65_CPSW_PN_MAC_VERIFY_CNT_MASK)
> +		return -EINVAL;
> +
> +	writel(val, port->port_base + AM65_CPSW_PN_REG_IET_VERIFY);
> +
> +	return 0;
> +}
> +
> +/* CPSW does not have an IRQ to notify changes to the MAC Merge TX status
> + * (active/inactive), but the preemptible traffic classes should only be
> + * committed to hardware once TX is active. Resort to polling.
> + */
> +void am65_cpsw_iet_commit_preemptible_tcs(struct am65_cpsw_port *port)
> +{
> +	u8 preemptible_tcs = 0;

I don't think the zero-initialization helps, since the value is later
unconditionally overwritten.

> +	int err;
> +	u32 val;
> +
> +	if (port->qos.link_speed == SPEED_UNKNOWN)
> +		return;
> +
> +	val = readl(port->port_base + AM65_CPSW_PN_REG_CTL);
> +	if (!(val & AM65_CPSW_PN_CTL_IET_PORT_EN))
> +		return;
> +
> +	/* update common IET enable */
> +	am65_cpsw_iet_common_enable(port->common);
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
> +			return;
> +	}
> +
> +	preemptible_tcs = port->qos.iet.preemptible_tcs;
> +	am65_cpsw_iet_set_preempt_mask(port, preemptible_tcs);
> +}
