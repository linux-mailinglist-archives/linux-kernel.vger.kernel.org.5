Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7132D7F2127
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 00:03:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbjKTXD0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 18:03:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjKTXDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 18:03:24 -0500
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2044.outbound.protection.outlook.com [40.107.6.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6AECC8;
        Mon, 20 Nov 2023 15:03:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lTnTpIs76L1zWGjDThSFkMwYoGRuxmkfA98qj1t64g5UigoRVUSBKlcptOMfNknUf3fBzWZwiZfQWTjazf6xX+XxBZrh4ZvsU0xicTVQcayp1xdkX1ig4tZnHcGxFNNp1/CYb2e6nfsv/JBHFCQ1mkfnou3ImUQ/XXif9RIlpGx32FtLf29/liSOFUOdUvQTuD5YkRGofdgIB6UvfYv6oAh4gJ+waSeC0IB694EupnaxzYcJ/tQu+XCfFRrQvBSMQbHJVoPU0H8Yn3i/DNZMhiilgX1e+cF3Vk40LNdyi5tTQZL7PcUE0uVExe520V8cgnXjPN/HtYiAcqm8sV4wag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gut9D2+6SA8B7JBbadyk4x6SMBNcBwxzMtKwovI8wyo=;
 b=YYXoWkDZhnch7JIin8XH48eq2aOQE0TEcQywBPrgzOQUX8g+rH6QJWsIBTxI9O/Wa5rv5YSiK1btUOQgEfOrfkVUvxRLB7WYSDQDR6+xVe13NMzAZApSeJghGrT/vZpGJhamlUG6/R+fphnOyNKafHOvZaMpr13y4Pqk7iDatfOqm+J6CL9bjMwANuqvMJrhuYTOUb0bAnBZTx/+xU3L57eRSq3cZNBg+7Lauc3mmTVlX7+lrmbtOM8ixpf2jk9y5WfLvGuhNNgzxv081AEyOc9XiU2sCu+tbb9XL4VPp2wbgPyuNH0jipUGaIuSeEkOXg2uSBI6HQZmnLvbyeT7PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gut9D2+6SA8B7JBbadyk4x6SMBNcBwxzMtKwovI8wyo=;
 b=Kgtnq+UtWTcOMwCHlIrljJ+o5Q8+kCFdC0thR0tSdpS0srf6T6wLnfQUW6qlThhZ/QcQ0QAeMS9gx7UgZ9IaEyXqmq7msXyVfcboACOcP/jeOUyeGvlcZuQAGoIZnupO12/ZkOQrt8WRfp41U37IZDrhZq7QJJRgv9BrZpYApN8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by DB9PR04MB8153.eurprd04.prod.outlook.com (2603:10a6:10:245::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.16; Mon, 20 Nov
 2023 23:03:18 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4%7]) with mapi id 15.20.7025.017; Mon, 20 Nov 2023
 23:03:18 +0000
Date:   Tue, 21 Nov 2023 01:03:14 +0200
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     Roger Quadros <rogerq@kernel.org>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, s-vadapalli@ti.com, r-gunasekaran@ti.com,
        vigneshr@ti.com, srk@ti.com, horms@kernel.org, p-varis@ti.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Grygorii Strashko <grygorii.strashko@ti.com>
Subject: Re: [PATCH v6 net-next 5/7] net: ethernet: ti: am65-cpsw: add mqprio
 qdisc offload in channel mode
Message-ID: <20231120230314.tqozomqbd6jiqbf7@skbuf>
References: <20231120140147.78726-1-rogerq@kernel.org>
 <20231120140147.78726-6-rogerq@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231120140147.78726-6-rogerq@kernel.org>
X-ClientProxiedBy: AS4P195CA0044.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:65a::7) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|DB9PR04MB8153:EE_
X-MS-Office365-Filtering-Correlation-Id: 3708e6de-c3e8-423c-51d3-08dbea1ce272
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v3AwAMatBxS1ZXgGac0HWsmdIkbiNggnzxmMV5ZEOTTYmw5njgnSKJJ7QIPJvAXTu3ej+3zReDDbgQXjMhbkigvvZTKDA+LzXQU+TQW68ghV4wL/86SPZIa2wCDqP/rCSwFsbo9r67UouWoDDGRTLV6Max+1AEn54pgRf3h5EDQ2bUlL4LQuj67Fou1RnnIhwUovJhoXLAaAus4DjF1WERsxshxSBXGkcHDEtGhBjHhVLFAqbYP2llagJkN7CFES1fVpJDQfR1jZeb/oeS1voWyBD/3IdsYhTCVfo0PD0pv2EvwKkkpDZ2KxgXrssPbgIF8KxOKYTSZ6W0DmcgKH3NTv1/5alSXklYxq8BM2rvlx+NBgacFDo6JjDdeQtDuMyJ2nfvPqoJzqnvSjQJDhrZ4gbADXW10xYJO9EN52k4eWOVY3nsNQiK+m44i8nz5biQnS51L6hbk6p7jCz2660Uyw4KCw2jxBRk4tHu8AviJ8+tbAuDRrLxtuiqpuROXuukcMpgaR2srFiIUi/qLuW/Ldj2GAXyoc+9ASbu12pXf3zOIVzf4SjgpM9vrCw9FU
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(396003)(366004)(136003)(376002)(39860400002)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(41300700001)(5660300002)(86362001)(7416002)(44832011)(2906002)(33716001)(9686003)(6506007)(6512007)(1076003)(26005)(83380400001)(6486002)(478600001)(6666004)(4326008)(8676002)(8936002)(38100700002)(66476007)(66556008)(316002)(66946007)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Jy/OJEp2X9Huuw4fYcN9X2PP3d1lXlFz3csLOYOGN06x0l7HZK053l7moTv0?=
 =?us-ascii?Q?6Zn2xTP8oLnPY8TV4rSpq33dnwv9UGDKXnyxXvnbnefxoOF9RzpiAm4UbkLb?=
 =?us-ascii?Q?dfQ56l/jORufYLlFWuzlX8U/ZfvWC2dcGRDAypau+5Hcv9gVdedIcjHiHJCI?=
 =?us-ascii?Q?xpslHERH32axQAmUbH38X9C3wcWgAjxbkcWPCB5UF6uILjC66enNO5U4CFb+?=
 =?us-ascii?Q?3ZGxng2aniGN+7PsnHRLSc6cA/bQcQ1T5s2NU1MALOs55YX+fJfwN/moQNEc?=
 =?us-ascii?Q?tTwacHCTlftGjyxbY8+mCbWf0ksPd4NFqpg1KUsB5FP7dT6W9/xJhNjoSRml?=
 =?us-ascii?Q?BZdACHRP0JF/8oRoZjKWcr62JjkS/ziMOFS0ZkXi4/3Uhe8HmwGsdT5PEz8u?=
 =?us-ascii?Q?e+qvp4RJUWSm/6OZpfKNb9xrkf7Bef3FSdQPjOUpQA5OKDs8+SHeUBLJvcnp?=
 =?us-ascii?Q?4Ip51imVNTFNsplorLV3ZGJv5zutAYMW5cdqa9Ue0nziuGQPElIRD91xVQlP?=
 =?us-ascii?Q?oejomV3TFXWyMtmqa+M9W443Hh1zI7kOb/TAhuO+3bdTkF2zl6wNH1VxZTGr?=
 =?us-ascii?Q?39TicDSoHcqp4sqkjO5xyYV554MC13Zqtp1NwrAFkSRWsbld4eEt66vnY7W5?=
 =?us-ascii?Q?Hx5ctNZA+WN2R7lQodCRu1HTUeTiX1TcNHaW5xf0pGmSPUT07ppZd0j0mHWt?=
 =?us-ascii?Q?UQ48bgjwvD5rFvd+VEikZj7rlEdENVPY5aPziDzt6Spz/H7MkW1Wfbo1EF+z?=
 =?us-ascii?Q?6XLuhYIRKAJm8OZwxwclOVaXvwwKgmrYD8Wr90zFpliNRZ1JmvySMqzao7HZ?=
 =?us-ascii?Q?VW5mKFPUqq/v5kAG7xiz9gbJIG7jBTEy/JNH6vNZflVsWoAeoogE+otX9374?=
 =?us-ascii?Q?SpBgoYhcCCu0nCt/CBT6Jcu5nyUa/knE5AyV0wzVqeeVb69aZ+m5UXmTXII1?=
 =?us-ascii?Q?KlLvElfMRS0sF7l9dPt5ExvDkrg1lsBKiNMeFbD0wP8EhpUR0c13fYS6fmba?=
 =?us-ascii?Q?N8ECTKekS9FTeXpfF+gBosscWADOjcpL6mrxDs9YzgMQEGNol3JaLPHMi7f9?=
 =?us-ascii?Q?q8sOdG2MO4rXPEsgwDTsB0IT/QS9wiRmQfgGwKt666D5b93wYmpbbaZOxTaC?=
 =?us-ascii?Q?OAYoLRZAOEt/R3w2qqdJ1uUklCyOrD0V2YFeEFQzVDmNo08tc99kIvjRCdTH?=
 =?us-ascii?Q?EmvEfKnxnW5zIn/ixxuyrue5hKzrBMr8ugIQyldpDiFxZ4yrb4WwZo8FOg6D?=
 =?us-ascii?Q?Q9AH2NjjU/pphsHXAqrFWDHc26rDHGigzQEJkCDJsUFI56f/RvVk5U8Q5Acr?=
 =?us-ascii?Q?Zjf7gOnSgWXi5z/4aMojDJUpudpLRnW1xnVIpLelbsBkVxB/PWlIiM6js6Lr?=
 =?us-ascii?Q?484OiVcK6dKl+h/y1VK6CgX99o6IwdsqFwvwjtvy35EEng2UDwPLP6w5TXd7?=
 =?us-ascii?Q?pNIc8+Io22wJL86QB4RkDEVTMs3WfJ4zw0CjHu+nnwmOc8jVzuy2VxTzrqXT?=
 =?us-ascii?Q?ySYrhHi/BAPzuy6m6v9Ht6v9XeMS14qeI85PkgQr1KYuyt91IyaSgkrLpnkt?=
 =?us-ascii?Q?C/NrvK7TiS7DEH9pOuh4q1QjFOBtJrsZE+uEAbyC7QipnVYKDNyXeH6FTLnO?=
 =?us-ascii?Q?uw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3708e6de-c3e8-423c-51d3-08dbea1ce272
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2023 23:03:18.3915
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VGM4OYLHL7is2e88q6qtt742MNYlpiJGHJfw5Pfe8guQuJq5XDl8atkQz6DBBJpAv8JElk35ktTcPVC5seEGNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8153
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 20, 2023 at 04:01:45PM +0200, Roger Quadros wrote:
> +static int am65_cpsw_setup_mqprio(struct net_device *ndev, void *type_data)
> +{
> +	struct am65_cpsw_port *port = am65_ndev_to_port(ndev);
> +	struct am65_cpsw_mqprio *p_mqprio = &port->qos.mqprio;
> +	struct tc_mqprio_qopt_offload *mqprio = type_data;
> +	struct am65_cpsw_common *common = port->common;
> +	struct tc_mqprio_qopt *qopt = &mqprio->qopt;
> +	int i, tc, offset, count, prio, ret;
> +	u8 num_tc = qopt->num_tc;
> +	u32 tx_prio_map = 0;
> +
> +	memcpy(&p_mqprio->mqprio_hw, mqprio, sizeof(*mqprio));
> +
> +	ret = pm_runtime_get_sync(common->dev);
> +	if (ret < 0) {
> +		pm_runtime_put_noidle(common->dev);
> +		return ret;
> +	}
> +
> +	if (!num_tc) {
> +		am65_cpsw_reset_tc_mqprio(ndev);
> +		ret = -EINVAL;

num_tc == 0 is what signals the deletion of the mqprio qdisc.
Why return -EINVAL?

> +		goto exit_put;
> +	}
> +
> +	ret = am65_cpsw_mqprio_verify_shaper(port, mqprio);
> +	if (ret)
> +		goto exit_put;
> +
> +	netdev_set_num_tc(ndev, num_tc);
> +
> +	/* Multiple Linux priorities can map to a Traffic Class
> +	 * A Traffic Class can have multiple contiguous Queues,
> +	 * Queues get mapped to Channels (thread_id),
> +	 *	if not VLAN tagged, thread_id is used as packet_priority
> +	 *	if VLAN tagged. VLAN priority is used as packet_priority
> +	 * packet_priority gets mapped to header_priority in p0_rx_pri_map,
> +	 * header_priority gets mapped to switch_priority in pn_tx_pri_map.
> +	 * As p0_rx_pri_map is left at defaults (0x76543210), we can
> +	 * assume that Queue_n gets mapped to header_priority_n. We can then
> +	 * set the switch priority in pn_tx_pri_map.
> +	 */
> +
> +	for (tc = 0; tc < num_tc; tc++) {
> +		prio = tc;
> +
> +		/* For simplicity we assign the same priority (TCn) to
> +		 * all queues of a Traffic Class.
> +		 */
> +		for (i = qopt->offset[tc]; i < qopt->offset[tc] + qopt->count[tc]; i++)
> +			tx_prio_map |= prio << (4 * i);
> +
> +		count = qopt->count[tc];
> +		offset = qopt->offset[tc];
> +		netdev_set_tc_queue(ndev, tc, count, offset);
> +	}
> +
> +	writel(tx_prio_map, port->port_base + AM65_CPSW_PN_REG_TX_PRI_MAP);
> +
> +	am65_cpsw_tx_pn_shaper_apply(port);
> +
> +exit_put:
> +	pm_runtime_put(common->dev);
> +
> +	return ret;
> +}
> +
>  static int am65_cpsw_port_est_enabled(struct am65_cpsw_port *port)
>  {
>  	return port->qos.est_oper || port->qos.est_admin;
> @@ -737,16 +989,6 @@ static int am65_cpsw_qos_setup_tc_block(struct net_device *ndev, struct flow_blo
>  					  port, port, true);
>  }
>  
> -static u32
> -am65_cpsw_qos_tx_rate_calc(u32 rate_mbps, unsigned long bus_freq)
> -{
> -	u32 ir;
> -
> -	bus_freq /= 1000000;
> -	ir = DIV_ROUND_UP(((u64)rate_mbps * 32768),  bus_freq);
> -	return ir;
> -}
> -

Insufficient code movement in the previous patch?
