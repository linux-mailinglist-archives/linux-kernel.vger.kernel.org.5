Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A169176B59A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 15:14:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233949AbjHANO2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 09:14:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233889AbjHANO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 09:14:26 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2043.outbound.protection.outlook.com [40.107.7.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20C382107;
        Tue,  1 Aug 2023 06:14:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K2xp816z3MR1ytHCi7H3+i+3X34vw3+EbrVY+YvKNEkV2RCqv0QEckN3D0j3Aq9j5vnVHi/+D7GmRhrBJiuwVh1bLNgMRgABaDhXLZFxH1tvjm5dsxTfRnMR/Ok0cT56r4ZOeW8bMeibPy12Ol3crj2xft4e9nXzDqAvFu5PqSX7ouz83DqkvC9XhEetMCHuBgzjSA/MGu47ZXENiyywrfUoJ4VUS9MX80/pM31ESLtyErUC1qGgpvnzBgo70vCc9crHomNKGeE8u5YbAutrll95RY0BQd8fa0jHDekNw+XPXq27aBOhSHCCc/cpCmvDy3tW0lkSOGTpF/qrJAFkWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xG2KDWTm79ZiEpOBwSp5ZEyUndoxLUEspub7UajpHAg=;
 b=OOd2FFB8VHVaV0Si1lZABQY71STBT5J4kHCoXtPE2PLRoogXV6gKaG17AtrsT3G1OeHkpd2laRi4zv5AtrZLuMcn1jOKFpuJg17GvDny7CFIvuBAjoB/GXH0T6+waPkbeapsSISThw5opvvWmpEepU9mHLlge/yXcBhJjZGC68QyUyq9IFTmZH4rYXCjcdgo8FzoEW1kiNpst9v6p+h3ln4QMNoPVWDF0B4YoaxBSpvENblgLVLZnju3Xdd74fVXuYvaq26lsjOCTtbVRYduc/tSzCFrbWJSNu6cjenmOFBl1rQb4LEu3N/LcZiT/qzUKNROBspcWIp8etho5xo3gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xG2KDWTm79ZiEpOBwSp5ZEyUndoxLUEspub7UajpHAg=;
 b=QoNf6vmXGZZUtGPrgwTbDRmr+VSa9ft5hH4fwaifW9j+xyMbGJZraGGp1hMD3LVkUjUOAC2V3pd1ZnbqGdVc5zC/caJWIWFXKsK0Gvb/ZR4/ygLM+flndhLtIPHGHdp0IsQCVBkgS7hCfJ06ETkaNHHpzRYx3kzaWR1nr8BzIDc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by DU2PR04MB8712.eurprd04.prod.outlook.com (2603:10a6:10:2df::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Tue, 1 Aug
 2023 13:14:21 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::6074:afac:3fae:6194]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::6074:afac:3fae:6194%4]) with mapi id 15.20.6631.043; Tue, 1 Aug 2023
 13:14:21 +0000
Date:   Tue, 1 Aug 2023 16:14:18 +0300
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     Roger Quadros <rogerq@kernel.org>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, s-vadapalli@ti.com, srk@ti.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] net: ethernet: ti: am65-cpsw-qos: Add Frame
 Preemption MAC Merge support
Message-ID: <20230801131418.bhcjtflj3iu77mmc@skbuf>
References: <20230725072338.20789-1-rogerq@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230725072338.20789-1-rogerq@kernel.org>
X-ClientProxiedBy: AM8P191CA0013.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:21a::18) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|DU2PR04MB8712:EE_
X-MS-Office365-Filtering-Correlation-Id: 8dc9b466-3727-4360-a697-08db9291382c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I1VaNSL9mYWakAI6NQlH2KVOaUpKt8U4D4UuXwUQXBaSG2ffngq7E4AxWD4Ef7bDmyve37SqPlHwT9ezahQQ1WfEO4EJRz7swa+Rx59EcPYNVMM/bXrBRqy7Pmq4Vi+k81EK97aGYcmdKwPKTAEJTqPLyUQuTAU2055KzG9Gq/NELdCQZKtbsmeelGZJ5HrYY0vTyVweTNyVBI8ZRmpnaunMq8rNgqgBU4m0UA8t23x0/FaU88bPo1hNpHY9rO/w0qCao1AkdkDKmDuvB1WcnzZLjeW9QGVs5lW1A0zqAcjjCs/+Op4xu8tSTvSG7CqrRJjh8SNtNCXpyp5/x/Ls47aqOkTggPsOBsqciWp4rVb1Vmjv0S4PRmLUrIM9CNFrMnkIh1k1X69XQgzzHfzruT3iK00BD9kZHYqIfVpwzatyBDqngfXP+dC3e2hZNmPChYgZB3n+gsDdoQX15r859g1C/IMlpKz/1xDK9QljjknIRopLdxynYcoEyZyjj3joJwmMfuLPGSP1VFbo+WbdX6gpe9Eok3gzSBY4rqh4wtNn3FghHiHLz2I4+dA/odq9/if5v9HQ+Q0xs4W67pv3+g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(4636009)(39860400002)(396003)(346002)(136003)(376002)(366004)(451199021)(26005)(86362001)(8936002)(41300700001)(8676002)(2906002)(83380400001)(186003)(1076003)(6506007)(44832011)(5660300002)(33716001)(6486002)(478600001)(66476007)(66946007)(66556008)(4326008)(6916009)(6666004)(38100700002)(316002)(966005)(9686003)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SkFYeEwzK3VyLzhRdXNBRGFaRExmcDBVcHF1NEx6dlA1R3o2Zy9TZUtNTGtQ?=
 =?utf-8?B?MUJ6dHNHcWdvVldxR3JTa3ZjMWhlSkg5QlYwOTQ4VXhlY0NhUG5FVHpCZHdY?=
 =?utf-8?B?NFh2cHh0Q2dicjMveGNGT2xoMDNmbmxnbkxtcmsyQzlCaFQ3dUpSblJ6TnNO?=
 =?utf-8?B?bExkZzN4OEc1UnNkZ2xRM3pnUG5aYmdEUGh0ekZnK3BXVU51RTFzZHE0MHZ3?=
 =?utf-8?B?bStTZWJidm1COXQ1Z1VwRHh2NHVOZ3ZaZWo5NDJIWEtUMWRqL2hseDFwNkxl?=
 =?utf-8?B?WWdERGNaeHB0UU5xUjZvZGl0clQxWDJFb1NtZmlMaVhaVmJhWXYrekM3K2NS?=
 =?utf-8?B?ZUoyMkpTYlBHZnhPaVoyUTNSTDNNeWlIelMyQmsxemE5MndzQmFSNTdhclQz?=
 =?utf-8?B?cnBReG9JeGNlNnlBTUR4NUsyeUpqa1hIenU0R0hlMUlGOVo1TVdsZDNGdFky?=
 =?utf-8?B?TnJHdzhOUXhsODFoQmpTSGk0VVB6MGZDT2lMSy8xZWFQMHVGOXUxbHVhdXQz?=
 =?utf-8?B?Q2V2Z2tsNTFiYUpob0ZZRDVTaHNpYTIwUUY5VVpnWmwwOHpPNlQ1TVZsU3pl?=
 =?utf-8?B?S2Q0WWx3MmcvRVRhVDBwNWtTTFNOM3cxTUYrcWZrQnZJOXYzNnNBYVJzRjl6?=
 =?utf-8?B?V3BHTlo4ZDhKWkl1TUtQNjRiOGlIQXBuTlYyeTkwWnF2QjRzZnkxSFpGcWM5?=
 =?utf-8?B?Y1gyb3pMaEtwYkpQZkRPZFVpMXAzc3VTbFFEVm5oNWd6SGprR085aC81UWw4?=
 =?utf-8?B?dGZOWmJSeVB6a0YzaVlTZ1djVGs5bm5MK0JZZklTWTdUc2lUMWxHVHlQT3VK?=
 =?utf-8?B?VjkrcWNrZ2MwVDlTWmM0L3VVWjdsZ3E2Y0NhQ3BKWCtYTmRtUTlpcjBEWXFL?=
 =?utf-8?B?SnJXUXphUmorOStXY2tMSFJwaWk1aTMrWkhHT1BldDQ4MU1OWG9GT3pFV1NZ?=
 =?utf-8?B?N2tKSnVtU2F1dHFTYU01cWZVZjFBRjBPTzRlTHlIRUpYaklPSGhvSS9FaHlS?=
 =?utf-8?B?ZE1SU0NOeVZUcmt1UnprNzhTaXhZSExOVUFLQmNmVWVkZFV2VFo4T2JHdkRD?=
 =?utf-8?B?cGNuTmxmSjVzTHUxdXh0V1gwY0V1M1lWamZ6Vi9IemdscG9jZmVRM2llZWZ1?=
 =?utf-8?B?dHBiQjEwdHhuOTR6cmNrbkZGb1FETGhpcm80WWQzWS95RzlDWkJTRkQxWWNP?=
 =?utf-8?B?YnV1NE50Y29XMEpOaDZWWkxFR0g5UStGVmhPSGVYbWxMYXFXdUtoTXhOdldp?=
 =?utf-8?B?dlhZZjJvV2VzY0pqazA4cDVITVhFUFUxZ0NxaW4xNnNXa3FENWI3ejhaU0Fs?=
 =?utf-8?B?SFlwUmJ6L3hoWElITGdxSTY1M3A5UmRHeFJGSGVLTzQ3bUhtWUdMRm40VHZY?=
 =?utf-8?B?ZDVBaEs0YWZ2aEVNNFVwR3Y0REl5MUs5d1d6eHRDV3ZPejRKZzhhYjhRMWhj?=
 =?utf-8?B?UEExRWNLVDdQWUw5SmI5U0lleVl4TTRqUmxQTzhrcnhZeEJ0b0lPVXE4MUlu?=
 =?utf-8?B?Q083WTJvU2tvRGY2RGxIZjJySS9wNE1Lc0xQeUF3aldIQkhmV2J5cU05cFhI?=
 =?utf-8?B?ckhlcnBwZ3ZhU2JXZlBvWVlOZWttanFJTTYwM2J3Tjl4TUcrZGhPR01GQWpy?=
 =?utf-8?B?ZDF2THFhTEN2ZmJERFVCUDlKS1hZVUttN0JIK3BITU10d1pxVzVDR2I3aTc0?=
 =?utf-8?B?Q1UzdTVhc3E5VmRRb2JFSndWRVNJc3lTbW9rZC9tb2FCNlRlMGlhYkF4ZVBl?=
 =?utf-8?B?MjA5L3ZnVzVJSk5NNGEzTCszY3RtVXNlS0p3N0hZdDUvcEc2cTVPMy9uL3dp?=
 =?utf-8?B?MHNjVFdIV3pZay81SElaUVN3d2pyZWZXdTAxbktWRVJ4Ny9yWTE0cEZUcXRl?=
 =?utf-8?B?VUV6UUVEVmphQ0FXQ2ZER21XRllxL1FkWnNEQjlnOVlIOUNzcUJ6MVhGMWNG?=
 =?utf-8?B?eUZ3SktpcUhnYWFXb0p2dlB1aHpFc1Jqd2NCcDYyWGwvQ3RYak5xNGgzRXVv?=
 =?utf-8?B?S0xTN3JDeGhxTnZoNzE3WUVyRzNJeHAwQkZBc2RSSXU0aFp5cmgzS3hCUXVR?=
 =?utf-8?B?U1NsYlF1VHNXbFZnbnZLQzZDTmVjKzV3bHRlNVl6OEFYWCtrWTh2TzNuTHIv?=
 =?utf-8?B?YllwY2pabFc5amg5dHI2S1JnTkU5ei96b3RDSDZ3NGNZNUM0MFdDUmg3Q21n?=
 =?utf-8?B?T3c9PQ==?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dc9b466-3727-4360-a697-08db9291382c
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2023 13:14:21.4890
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wev4Jn3jma/iBuFn6Bt7IjlsUjLWlkNqSiONANs+Cp3CwMl9OoLLlT3GnWeRVh8NjdStBFusYDbrZ4hhUz8r/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8712
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
> 
> Signed-off-by: Roger Quadros <rogerq@kernel.org>
> ---

Also:

../drivers/net/ethernet/ti/am65-cpsw-qos.c:173:6: warning: no previous prototype for function 'am65_cpsw_iet_change_preemptible_tcs' [-Wmissing-prototypes]
void am65_cpsw_iet_change_preemptible_tcs(struct am65_cpsw_port *port, u8 preemptible_tcs)
     ^
../drivers/net/ethernet/ti/am65-cpsw-qos.c:173:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
void am65_cpsw_iet_change_preemptible_tcs(struct am65_cpsw_port *port, u8 preemptible_tcs)
^
static
../drivers/net/ethernet/ti/am65-cpsw-qos.c:179:6: warning: no previous prototype for function 'am65_cpsw_iet_link_state_update' [-Wmissing-prototypes]
void am65_cpsw_iet_link_state_update(struct net_device *ndev)
     ^
../drivers/net/ethernet/ti/am65-cpsw-qos.c:179:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
void am65_cpsw_iet_link_state_update(struct net_device *ndev)
^
static
../drivers/net/ethernet/ti/am65-cpsw-qos.c:699:33: error: redefinition of 'taprio'
        struct tc_taprio_qopt_offload *taprio = type_data;
                                       ^
../drivers/net/ethernet/ti/am65-cpsw-qos.c:697:33: note: previous definition is here
        struct tc_taprio_qopt_offload *taprio = type_data;
                                       ^
2 warnings and 1 error generated.
make[7]: *** [../scripts/Makefile.build:243: drivers/net/ethernet/ti/am65-cpsw-qos.o] Error 1
make[7]: *** Waiting for unfinished jobs....
