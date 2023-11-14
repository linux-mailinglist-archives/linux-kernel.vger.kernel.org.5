Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8354D7EAFA3
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 13:08:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232774AbjKNMIL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 07:08:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232314AbjKNMIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 07:08:09 -0500
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2075.outbound.protection.outlook.com [40.107.13.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A67F7128;
        Tue, 14 Nov 2023 04:08:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VjhEXHCxV7UOkjUgm+T6Kdk017w7GKS+fKhcAaJYUMNSmx/TyVF/r0B9/usxFLVex2WTIckRvhWsknZB++80LeJCGlt3uD3jpQ8w33ADkGl/N8NCm8GO+TBmjLAuuAaQ2yPmJ/qt0hhOfCjp6f6IJtzf7eXYX3Twc618JcO4bMEWH2l/3nDFXB4Ew6w4jQIWB2OIGYjO8xg5OJKFajeYlEvcE+rHlBdpOxs1p9kQNImiJC8IBVMXg8ER4QF2MVemHhPZPFqcxUv759nMXnrAmoB3qcTvKR8XbOOGeJWM51TYw13upY998B0/Bn4VVuGg9GImGaInbbavc4dmYWQ9Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EzsVFfQ6b69KvbX7wROLusPR9UBwoK5lsby/FfMCBo8=;
 b=HgrUUBNzFCSaRsZa1SMraQ7LloZMlTY3EVhx7KGLi/3ImRavnIPyXuLX1bajeg0eW0HNVJCOPFlM5PZvyDSONDDxpzJEavDZRsqsC2B1iHXzfjXpKcMRqKlLPuC1fHFzFA3Hs7NtT8ceKDnNTqXWRIw2+Fj9P7ncEUj5r8YIeU7MvZUv+AOS0ADbBIpiFqLs9z602PriNKDjUzbwRxzN/APDm51+MYzR4JQkyy8sVtt45GilEi3DUS61z/qE0yE2aXePuBow8qJTPq+GcnNiE6ahIOpY9YkBCeYKECOIOox3gMUYbCRcDtGj1FY03nJvILdWBmwEDJ7SUtds/EeVzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EzsVFfQ6b69KvbX7wROLusPR9UBwoK5lsby/FfMCBo8=;
 b=B1sbZ7AZaMBLL06RHPgemEyK73dJGd1OHiDhTnjTnJH/FebQEZcnZdSftEkh2TH0nGBlBVz/iC2Y1pWYGe39FJyTXVwMwspyb0CSJfP0NTxPaaCtJr10eDWiFme8Kv28QBLYEXpY1WZtlaWuGmCtneVzeU7o6ZEW8SrtJWiSvzM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by GVXPR04MB9951.eurprd04.prod.outlook.com (2603:10a6:150:118::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.16; Tue, 14 Nov
 2023 12:08:02 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4%7]) with mapi id 15.20.7002.015; Tue, 14 Nov 2023
 12:08:02 +0000
Date:   Tue, 14 Nov 2023 14:07:58 +0200
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     Roger Quadros <rogerq@kernel.org>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, s-vadapalli@ti.com, r-gunasekaran@ti.com,
        srk@ti.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 3/3] net: ethernet: am65-cpsw: Error out if
 Enable TX/RX channel fails
Message-ID: <20231114120758.kz5n3x4fawhcegqi@skbuf>
References: <20231113110708.137379-1-rogerq@kernel.org>
 <20231113110708.137379-4-rogerq@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231113110708.137379-4-rogerq@kernel.org>
X-ClientProxiedBy: AS4PR10CA0014.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:5dc::18) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|GVXPR04MB9951:EE_
X-MS-Office365-Filtering-Correlation-Id: f9be5295-69b4-4668-20c4-08dbe50a59b4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 35uOVkDtBADXGv2BzxAa3THr4D417awhrFq87OwrfBMEVTGiQrIDFSvBu8MzL6R91bvMCRIHDZwnaAQtzd+kdLSbsqK90tTPVjkkBSeBn1iChyZcgUoDsPOeF+zmWrL4G2aLZeG6U+11+J9usY6JgoOuhSzIcP7pkHlIrnEE+KLlZkIImjvQPvBvQCILVgB4xFs/rnLqGEFzVrFtNZ4E+MqCm+SQgsT8UgpLBWKLolZ5OTx9HvZQcxETBw6yHGSiiiSi1IXdg+nDBjUO6fTwmVgEN/7uUxCf255B9+8Q/3LQcEMDI0AcMyQAYMdNQW+J56HhnkJ02MWd5+sYz7cBbKuTuXZ6BZRnfRBN9pp76bXfE2L/aqqn8BQV3p+i22+naJgL20nSGMTK+aPA1lBskZITKvvMkaMkGG/qG/bErC6Q4TkIRuwttWVLMLxGtjkjz/PWqcvDEjcYKqTw5O4KNsxlkaSR3BoIJF4ewig6lOJ4MyXcA5yb00m4JTpd+NpPf+VI1UcI1JUOml15OFOo7ISWslmCmjo08S5bDYAam2yR0UNqkjuzCGc4pk3mhVbB
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(376002)(396003)(39860400002)(346002)(366004)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(41300700001)(26005)(6506007)(6916009)(6486002)(6666004)(478600001)(9686003)(6512007)(316002)(1076003)(7416002)(86362001)(44832011)(5660300002)(2906002)(83380400001)(8936002)(8676002)(4326008)(33716001)(66946007)(66476007)(66556008)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?M4cPoLOjfk33MZF3fc/lDQvJTbBdoLStAnoIF+rZI/h9LE/mGTLdc3Q8/B30?=
 =?us-ascii?Q?bdV1ydgfTkvsQQPAAgNwL7VeLGYqEehNwS6tsXFcMVcmzI/ilMc3vzG+iHYr?=
 =?us-ascii?Q?6Eeo5FXqHMPf9R7pzVEfT1hRB4JQgF40MhKbc3rZArKFUXf7cVJiLZxVgWS+?=
 =?us-ascii?Q?PTv7MYkB/n9IjZ+gV6+U7c9YSY1bQgBO6SpFSxHsZa9jO6PqMgEmcsl5oSk9?=
 =?us-ascii?Q?2gzFTTN3ty/Vz2/ha5Olj9hGPMw1fXh37qUhMbl/4NCZIxvRVIeenhfNEFNh?=
 =?us-ascii?Q?Gi60whLgJrc/tGLNJgI/4HbVxwC4XkJIXws1XKOiuzXhPTUnHO0w8WYpKJDh?=
 =?us-ascii?Q?k869qIb0pAulZXIuB6z6woPLFLVLYYaoZ5HgHrTvocNQAcYQyBcqaGDR93hh?=
 =?us-ascii?Q?yx/7HZ/3vfL4OCMajcO/9BK5njw6yHO+YyYT7gyUNww8anhgpQYTg0ElbceM?=
 =?us-ascii?Q?Mr79H0YM/wBe8aEUH1Xf7dcGNqO3UwIZDQkG7HRumfmXhjTSgs+B1JliLrwN?=
 =?us-ascii?Q?iXL3bNNqv46YOzxHFYOfJ25kYq+BW2Xhygzeg0S2Qol1KJYVQgPcE1mRdZR7?=
 =?us-ascii?Q?GyD+uc2xtp6PvmFpjzlLkNLsYjZRi9Jn5ZgTOicW+qUvFvbrbXC1lQgNLIwL?=
 =?us-ascii?Q?CFR3B896duevGHMhcXpt7mHdB4oswDvL8EkxxSWJ1BgKBN8BgkFvh6H6m8xh?=
 =?us-ascii?Q?WSx2Iybw8jHmTzDTeUajOVLpIwkPpJ7Le1f3wj9eBhEQwFvGbnWZQuWI6HYR?=
 =?us-ascii?Q?FSu6S+/g2zd1JR2HKta0shferehwePXtN+DS4or8CfM1Um3QOJnQ+Xf7sKDc?=
 =?us-ascii?Q?zSbRA5tv4kCuPNAKz15WjnfPBx76Cm8CstzTqmLEhdTjW9v3eA+pPkWPJCHp?=
 =?us-ascii?Q?cqBNqM2Jo/A3kdwbXDrnxw8mxBCOO9d3IbWWOMvUV2rPU2Q67xecMdrTRrXI?=
 =?us-ascii?Q?zfsH1nlYrsKzTo37nirebpjDLA/PaZ87i+N4ZURB/rdWpHffn4xbp53R1r48?=
 =?us-ascii?Q?m6UPad4m7L7qrFDUYJxJqJ2lMc3FopgHrSDKzHZrBefxC5i6YRSXC+coh0ut?=
 =?us-ascii?Q?l1nY5xshLFdPiponBWZbCWR6hv4yi2/B9K0gQVXEYrtOT0nF0tV+Zr9VUY+j?=
 =?us-ascii?Q?wTOH+ys+bzqZm5iobpF1GseFpSa9NFkI6/eAJHVV7DJKqvZ+59LfDJjQ2MwP?=
 =?us-ascii?Q?wwXHcrVmiiiBmVxrvvJf/YSUygJfLOad5WsOVF2v1wYaVzgZuiu4AAXNwJWJ?=
 =?us-ascii?Q?1Cv6+CfcDHeXlPvOfSf+pAMfh0DTP6xZyIm1ELF+yCfbU9qziJ//4g07i97N?=
 =?us-ascii?Q?y0GHKKYvkZ9kkJs2WbL3vU/iaTPFaDErgqcv4+zhwKtwnktWD7ZdNFYwmAhq?=
 =?us-ascii?Q?nhMfYXUw+sbuzOFpvO9I+ztiHJuOCx4SpD0b186BSVCg4WFJijzUgwwldKNQ?=
 =?us-ascii?Q?4O7rwdN3YeExURCfKyzXC7xlqJ3/ViOHuGl7e95cgY9Dttm9rtJZqL7RdVpF?=
 =?us-ascii?Q?jqF7OEdjO30eUKWN+/dQa8n9dzC9PBUjt2slc95d5Ln6tpUpneqdkrgJ5dm8?=
 =?us-ascii?Q?9FzkXcASA9G3n/pl18cRDNbYS7RKAHZhqO7pMyNiCIkFM0Awmbj2YjjxxjTQ?=
 =?us-ascii?Q?Fw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9be5295-69b4-4668-20c4-08dbe50a59b4
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2023 12:08:02.2514
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nyEVHh3+vjBZVzcT+67b6odl6IFWni76vAmOwVRDuj8cMZeMwY7faqztfD93IIJwb1Ws2HxUKARdfJnkLXhTrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9951
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 13, 2023 at 01:07:08PM +0200, Roger Quadros wrote:
> k3_udma_glue_enable_rx/tx_chn returns error code on failure.
> Bail out on error while enabling TX/RX channel.
> 
> Signed-off-by: Roger Quadros <rogerq@kernel.org>
> ---
>  drivers/net/ethernet/ti/am65-cpsw-nuss.c | 33 +++++++++++++++++++-----
>  1 file changed, 26 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
> index 7c440899c93c..340f25bf33b1 100644
> --- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
> +++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
> @@ -372,7 +372,7 @@ static void am65_cpsw_init_port_emac_ale(struct am65_cpsw_port *port);
>  static int am65_cpsw_nuss_common_open(struct am65_cpsw_common *common)
>  {
>  	struct am65_cpsw_host *host_p = am65_common_get_host(common);
> -	int port_idx, i, ret;
> +	int port_idx, i, ret, tx;
>  	struct sk_buff *skb;
>  	u32 val, port_mask;
>  
> @@ -453,13 +453,22 @@ static int am65_cpsw_nuss_common_open(struct am65_cpsw_common *common)
>  		}
>  		kmemleak_not_leak(skb);
>  	}
> -	k3_udma_glue_enable_rx_chn(common->rx_chns.rx_chn);
>  
> -	for (i = 0; i < common->tx_ch_num; i++) {
> -		ret = k3_udma_glue_enable_tx_chn(common->tx_chns[i].tx_chn);
> -		if (ret)
> -			return ret;

Can you comment on the kmemleak_not_leak(skb) call above, and its
relationship to the pre-existing error handling path in am65_cpsw_nuss_common_open()?
I see that the dev_kfree_skb_any() call is being made from am65_cpsw_nuss_rx_cleanup(),
which is only called from am65_cpsw_nuss_common_stop().

So if there are errors during am65_cpsw_nuss_common_open() and
descriptors have already been added to the RX DMA channel, they will not
be removed either from hardware or from software. How does that work?
