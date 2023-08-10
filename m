Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE2D3777C8E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 17:47:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235581AbjHJPrM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 11:47:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232404AbjHJPrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 11:47:10 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2070.outbound.protection.outlook.com [40.107.6.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E22CC26B7;
        Thu, 10 Aug 2023 08:47:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d030UCNcACiGX6mdDUTKQmRELoljqpa/hTndfCkkKPQ3ia9+skD5QRNLjBLfS3YIoU9+6rt3yKhzqLXNi9i7Z+RYjdxMV60SxpK04Zlhyw3qoqWGuIWqd0Iu2Mg2epJHoLiMcAIL+yTLu1dJ/cta0uI8CZMYb8jDqH4J6jN1hubUIlRjH152QUpIc7eKgpgA1akvdlPtfOzAYrMinDb2q18FHxxCFR7dB3m48WkCO9WOA2EINbq333TcfKC9NtVP7VJ7aeKckV6myFYQRw42dHgjDw1Ogb70GNJ3w/NcK8zw5e83We9lTzlvKo158bOrp4NAV8BosYINFNfkAh047g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tId8FehPTxn2kJuVW3dvPkvgINb/cMZxtcSWMOxc0fg=;
 b=HPYUxRaPp/nx+BS3RswE3XmyZsdw4pbo3fzq2v38tTqGzJQIjHuIOnhdFOa10AvQbN6EGEGeu6NN1U9pYM/ZU3ibvC19NKOd06Z+6hhUNVo7z/rVFlo8tV13Lyk3PjgCWzdnRSS2/IYVgKHb2WRMyPtCdb46mpzji8DLG92KBZ0p41F3sycdCAczNtez/oTA7IJLSmLUKvxTlg59Dwij9FtjbpoATd/7LuHEG78ngDM9XZtKUIEEJPkYR/rT71GaEgWyXG6hbyhPgUAgo/5vhpIevK74nrLZWesxp/nlnP+8E5KuxTaXCArp58HO/hKxePDFf6ihcuhCXCKyTHEzaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tId8FehPTxn2kJuVW3dvPkvgINb/cMZxtcSWMOxc0fg=;
 b=FHU6Ov6fxkyNzA8hz5INSOFbPM/ld3FAOIpXLXYyXkkvvNktkyUnC2/lVJmgidcpynZptg4I+oWD+yQTQgUZMMchWYenHzpq5+o6LXreQfWjcIu9vfwYgXAlo22xmgoepXHng7X71wY3CxyD3XhmN+zo8JZiGdM0af1jlusD2wY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by PAWPR04MB9888.eurprd04.prod.outlook.com (2603:10a6:102:385::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Thu, 10 Aug
 2023 15:47:06 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::d4ed:20a0:8c0a:d9cf]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::d4ed:20a0:8c0a:d9cf%6]) with mapi id 15.20.6652.029; Thu, 10 Aug 2023
 15:47:06 +0000
Date:   Thu, 10 Aug 2023 18:47:03 +0300
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     Roger Quadros <rogerq@kernel.org>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, s-vadapalli@ti.com, srk@ti.com, vigneshr@ti.com,
        p-varis@ti.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] net: ethernet: ti: am65-cpsw-qos: Add Frame
 Preemption MAC Merge support
Message-ID: <20230810154703.cyyivcxlppdqr45q@skbuf>
References: <20230810152538.138718-1-rogerq@kernel.org>
 <20230810152538.138718-1-rogerq@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230810152538.138718-1-rogerq@kernel.org>
 <20230810152538.138718-1-rogerq@kernel.org>
X-ClientProxiedBy: AM0PR02CA0118.eurprd02.prod.outlook.com
 (2603:10a6:20b:28c::15) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|PAWPR04MB9888:EE_
X-MS-Office365-Filtering-Correlation-Id: 72cb534a-efd6-4817-3ead-08db99b90cb0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /4k95UFRBdhY+kLiJMt66XVA1HSYN9GLVGEX7KPHdxVrzyfbOjjZcKCPj//rSTs/kuhiMIBxCFqpFy3DexbazXJxUtIxy+NUQvoiFCfXhO1a2VF4XzE5pbaEv58OUonH8ggFVpQrkIMgMFVjcdSo+8y7FAwPD5/RbDdvjylxzy1QPc5iycKLKbza3fpSmFGegRgVFY85gBCGsF9LBHTBgQ6CyKTvyuk58yJUk4aXOdhUZW3vASt686uyQkZU8fkuZiYFNa0zwKsGdXhpzxy1TowjgklwxBociw/STuzVq8oDsFsVX9FuKOzb2OOkOtfUICqcCvlmMouvTDq8bki74HQ7HEsbKYljlrMOfLR+DUcjSxKDXt6Sm26ivEdiAPNAyg5rWkolrp415zgb1IAytdo9YpiMcM/y/61eFKBy48cXjm3F/ndWxiKkEI1UUc/owihN1D5qPiWYWwnPl3gTPrxy8Vtn0xLykRLbcLhvnQCz12MqxK3XOM5eCNmqcH2p8hKt/nZG3of82UL4whT2u+nsG8oWsJO9lZIM0Ifzp9ZwvpbvmHhhBrAj3Rgsao1SBB2YHWydsd5mOcdNomGAHQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(136003)(346002)(39860400002)(376002)(396003)(366004)(451199021)(1800799006)(186006)(1076003)(26005)(6506007)(8936002)(8676002)(41300700001)(2906002)(83380400001)(38100700002)(33716001)(86362001)(44832011)(7416002)(966005)(6916009)(66946007)(66476007)(66556008)(4326008)(6512007)(9686003)(478600001)(6486002)(5660300002)(6666004)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UGpPUG9kUlNxdVJScldGUmFYYzJDa1BqaGtSc3k0V2ZacHFoYnhvQjdyYll2?=
 =?utf-8?B?YUpSbTF0Znc1b29ON3ZZMUZwUlJtQ1FtTi9EQVlUTHpoek5YY2Evb2p2ZHpl?=
 =?utf-8?B?TlBoRFp1eFl1VkkvcUViWDBqQlBXYVpkdXRRTFhyT01nazg5STA5QWR4SllW?=
 =?utf-8?B?aVZIS2UxbW81Q1VscUVxaFNRbzl4T2czWlNDczZ2M3BZK1VpRG56c0ZXbFlI?=
 =?utf-8?B?VGcwZ0E1YlZyZGt3RXR2dzZBZVFSTXFEc0Y3ZWxQd1pFM0lVdmFPUTkzZlh1?=
 =?utf-8?B?STF4WGc0VlZ5TCtjOUlsZDhBZm84QjliWnpiZHljU3BUZDJPQ3hXc3FQV3hZ?=
 =?utf-8?B?V0FTOFFQSUpXc0RYR1QwK0N0TzI3eDkxemRyZnB1dHBBdy90QTZXYXlMWFNT?=
 =?utf-8?B?eU40TUZTcWRkZzg2Sk81RHFMbS9LQS9tUEt2NjJlTGpwY0hQK0FodXI2ZkpQ?=
 =?utf-8?B?c2srWVNLRWJ4bGV2aEI1ZnY1Ky9BZ2lHTXBucUZ2cGV4V283QmFBNHR5N3VQ?=
 =?utf-8?B?NVk4bk1nRXUvNlZHTzBLbG5TYjdjcXZNUHNCeHYvN0dYMXBNTkxncE5wakFt?=
 =?utf-8?B?NW4yc09VOTdES0JsRUJVUjdFOU5sdFpvUGVkQkpUazVHL2RrcXVGbGg2QW40?=
 =?utf-8?B?a2oyMDUwTnJhaVYyc0JHZ0hXck5zL1luZG5za0xZWFd0MGEvN0hGdzFORjFu?=
 =?utf-8?B?eVZaTjhWZTNUV3ZXNWowNDVaMlpmemIyaHhGSGxGeDg5VFRNWFJ2cUVuU3lz?=
 =?utf-8?B?Q1VET0dpMmZCbHhLMmpBcGd1OUtJZEt4dkREdGxxSWw3R0VLSGIxQlp0YjN0?=
 =?utf-8?B?cWN5dWFPQjdCLzhMci9hbmVBQWx6UUM3UkgwSEs4UFQxRFczTGJrck9VOGlv?=
 =?utf-8?B?dGQ2WTBCeEd4VHd2RkpaMzBaQ2ZSMDRQV3prTHZOdVBiem5ndFZBYjMrL1lt?=
 =?utf-8?B?OUR2Zk9aeDJScDg3RVlsbVBCcEFpZkE3N2psRXFtUmU4aTVWUWM3ZzlsY0R4?=
 =?utf-8?B?TWJjNjNySkplRUhhUkRySHlnUlV5aUo5RTl5TWZQRHlNOTJPcm1ydXJJL2Iw?=
 =?utf-8?B?ZTFTajZFSG5oTEZGVi94NmY4NmxhUG44ZDZlVWJJMW1mM1pQNmt2NGdvRUp5?=
 =?utf-8?B?aGt0RllEVWNyRS80SVdWWEJ0Umhmbk9SYTFNZGZjV2xsTmdDTXUxUkZWQ3U1?=
 =?utf-8?B?UGpYSVk5YlpoaWxaZnlLQTIzNmhxc1AveVNyNVRCNUw3NUtzbU1hM2RaSFdW?=
 =?utf-8?B?bEM4SWtZMmQwQ3E5S1AvTnYvL1RtNjdzV0ZjdElOb0VOdFVwa29IVU5uWkQz?=
 =?utf-8?B?a20zRjIrQ21ubXFHWlE4bmxOZjVLY1BlbHJxT1dncVFHanRnWDJCay9yam93?=
 =?utf-8?B?NlVadFJoazRQenNpYUpQWGxnMlR1UWtWcHY4TGRvRncrcmtJYUVpcjY3emlQ?=
 =?utf-8?B?aG5td040NzVTVkhLSGdocWZPb3dleHc1TWJpYnhxZm00aDYweGpGS3lOT2N2?=
 =?utf-8?B?QWtURHlhd3hsUWRKRWt3SWFrTmQyOUNubjdhVlhxSHFCME4wZ1lOWSs3OHV4?=
 =?utf-8?B?VzRjMGowUnJwVHFYUWNoN1NKWWhRZy9yUndOdHRTNWxUUWJhaWdtWHZlTHZl?=
 =?utf-8?B?cDJXb1NWYXJ0dW41L3dQbXpjbWw1MHFXRjB0aSthOVd4Tm1OcDJqemcyY3VN?=
 =?utf-8?B?ZGRLUUMzSDZsem5kVTdwSFlTM2tQSVRTMWMxcVlJUFkwYzVycXhlZTh5Vzl6?=
 =?utf-8?B?bTZDa1gyZXBwVjJOUkpVemcwWU9CTFQ5YkJtZ2dyMmFhYmcxa0F2OFNQSG9h?=
 =?utf-8?B?VEtKSXZ3dFE2OUg0VWlva1I2MFpYT2NoVmhyQ2kza0NLejMxSEFNRTJUcHNi?=
 =?utf-8?B?czFoWHRMc3JDTHcxYy9Qam9wdkQ3Y21QTW1mRlY0WUVLbVhCa3pDNUlRc3Na?=
 =?utf-8?B?bmRSbWVrMVAyMXI2UFFIa0svQTQ3SXVzYTJxOHFJL1BQUnN2ZHUvVHJPMElN?=
 =?utf-8?B?VE12bGI3b2FxNGpaRDRsOGlzTHlkanprTHNJcFFVSkdJMUZkdjR6Y1VOdUZv?=
 =?utf-8?B?NGNTb3d4U3FMMm1LdlhPZVFjWlNWbTVlWThUQWxhQUl6VjRGS1lKS2FDZlhH?=
 =?utf-8?B?RWZnNVpiV0U0Y0VxMXNNcjNiTFRVaGkvU2gzOE9HMlhzWG1PL0xpMnNLdVFQ?=
 =?utf-8?B?THc9PQ==?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72cb534a-efd6-4817-3ead-08db99b90cb0
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2023 15:47:06.6032
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kpSF6q8VgX6YB+qRFkhRJRgVDSLWOgcAc37jSf9E7wcUdCaPSCmgbDM+ugWLr98O8bZVC5pSHzGTFnTVfitweQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9888
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Roger,

On Thu, Aug 10, 2023 at 06:25:38PM +0300, Roger Quadros wrote:
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
> 
> Signed-off-by: Roger Quadros <rogerq@kernel.org>
> ---
> 
> Hi,
> 
> Dropping the RFC tag as I now have MAC merge verification and frame
> preemption working.
> 
> Changelog:
> v2:
> - Use proper control bits for PMAC enable (AM65_CPSW_PN_CTL_IET_PORT_EN)
>   and TX enable (AM65_CPSW_PN_IET_MAC_PENABLE)
> - Common IET Enable (AM65_CPSW_CTL_IET_EN) is set if any port has
>   AM65_CPSW_PN_CTL_IET_PORT_EN set.
> - Fix workaround for erratum i2208. i.e. Limit rx_min_frag_size to 124
> - Fix am65_cpsw_iet_get_verify_timeout_ms() to default to timeout for
>   1G link if link is inactive.
> - resize the RX FIFO based on pmac_enabled, not tx_enabled.
> 
> Test Procedure:
> 
> - 2 EVMs with AM65-CPSW network port connected to each other
> - Run iet-setup.sh on both
> 
> #!/bin/sh
> #iet-setup.sh
> 
> ifconfig eth0 down
> ifconfig eth1 down
> ethtool -L eth0 tx 2
> ethtool --set-priv-flags eth0 p0-rx-ptype-rrobin off
> ethtool --set-mm eth0 pmac-enabled on tx-enabled on verify-enabled on verify-time 10 tx-min-frag-size 124
> ifconfig eth0 up
> sleep 10
> 
> tc qdisc replace dev eth0 handle 8001: parent root stab overhead 24 taprio \
> num_tc 2 \
> map 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 \
> queues 1@0 1@1 \
> base-time 0 \
> sched-entry S 01 1216 \
> sched-entry S fe 12368 \
> flags 0x2 \
> fp P E E E E E E E
> 
> tc -g class show dev eth0
> tc qdisc add dev eth0 clsact
> tc filter add dev eth0 egress protocol ip prio 1 u32 match ip dport 5002 0xffff action skbedit priority 2
> tc filter add dev eth0 egress protocol ip prio 1 u32 match ip dport 5003 0xffff action skbedit priority 3
> 
> - check that MAC merge verification has succeeded
> 
> ethtool --show-mm eth0
> 
>         MAC Merge layer state for eth0:
>         pMAC enabled: on
>         TX enabled: on
>         TX active: on
>         TX minimum fragment size: 124
>         RX minimum fragment size: 124
>         Verify enabled: on
>         Verify time: 10
>         Max verify time: 134
>         Verification status: SUCCEEDED

Do you also plan to add support for mqprio, to present the same feature
set as everyone, and permit IET to be used without EST?

What else would need to change in order for the am65 cpsw to
successfully run the existing tools/testing/selftests/net/forwarding/ethtool_mm.sh?
Just the extra driver-specific ethtool --set-priv-flags? If so, maybe
you could create a wrapper over the generic selftest, and put it in
tools/testing/selftests/drivers/net/. For DSA we also symlink a lot of
bridge selftests, for example.

> - On receiver EVM run 2 iperf instances
> 
> iperf3 -s -i30 -p5002&
> iperf3 -s -i30 -p5003&
> 
> - On sender EVM run 2 iperf instances
> 
> iperf3 -c 192.168.3.102 -u -b200M -l1472 -u -t5 -i30 -p5002&
> iperf3 -c 192.168.3.102 -u -b50M -l1472 -u -t5 -i30 -p5003&
> 
> - Check IET stats on sender. Look for iet_tx_frag increments
> 
> ethtool -S eth0 | grep iet
> 
>      iet_rx_assembly_err: 0
>      iet_rx_assembly_ok: 0
>      iet_rx_smd_err: 0
>      iet_rx_frag: 0
>      iet_tx_hold: 0
>      iet_tx_frag: 17307

Can you please also implement the standardized ethtool_ops :: get_mm_stats()?
You can see these with ethtool -I --show-mm eth0.

> 
> - Check IET stats on receiver. Look for iet_rx_frag and iet_rx_assembly_*
> 
> ethtool -S eth0 | grep iet
> 
>      iet_rx_assembly_err: 0

This would be struct ethtool_mm_stats :: MACMergeFrameAssErrorCount

>      iet_rx_assembly_ok: 17302

This would be struct ethtool_mm_stats :: MACMergeFrameAssOkCount

>      iet_rx_smd_err: 0

This would be struct ethtool_mm_stats :: MACMergeFrameSmdErrorCount

>      iet_rx_frag: 17307

This would be struct ethtool_mm_stats :: MACMergeFragCountRx

>      iet_tx_hold: 0

This would be struct ethtool_mm_stats :: MACMergeHoldCount

>      iet_tx_frag: 0

This would be struct ethtool_mm_stats :: MACMergeFragCountTx

Also, I opened the AM62x datasheet again and I didn't find this, but I
still need to ask. The CPSW doesn't show the Ethernet counters broken
down by eMAC/pMAC, no? If it does, you should also add support for the
following:

ethtool -I --show-pause eth0 --src pmac
ethtool -S eth0 --groups eth-mac eth-phy eth-ctrl rmon -- --src pmac
