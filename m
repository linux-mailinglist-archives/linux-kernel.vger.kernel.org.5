Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19D9A76B5D2
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 15:28:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234175AbjHAN2z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 09:28:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233944AbjHAN2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 09:28:53 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2050.outbound.protection.outlook.com [40.107.8.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 695A2173F;
        Tue,  1 Aug 2023 06:28:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cwkI0RNc6GNbBIvcu69LD1RURsIizxDdKlnpIyrwYaTGdac37Ju2heZoWT0hZi3PB2rYzlU5HXPwinQlUP/ZHsDx+G1hSC8uPJl2+2EA6WxnIFx5EEw1fxKYmdT0j9g+cPFVXH2h8Z31FvxN3QzTn3GuvPv99tE9I9nLXAMEcW/ZfbPz6Bwgxzf7U3SbD5C8RcZzfCz4lA4TP3xIPAqL4xTYmsEDC34/1SsXv9WOUQlpT0qt0iEfTbJsBgXeZgk4RMli8VpXKicN4/UnVG2Mv9hObT91uOSd9AbooQd2AdHZ4CbkA6tTV4TA2TJDq6xP8rZDCKNvxFrPCk2QAFYbYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jv5zDr8MLwWuKfbsDpqQ1TSqu2Wd3INGRtxWmzk79lw=;
 b=faoxnKu2LPVXSai3Zw9GNN1O+U100CWX9oIVoP/azy4pKnoAOXffsRl+vUSCBJumHV3IatUSn20l+IXa6zOQ/8NROIzF6MAzs0+YQ8++CXGSmo6DvY1zzOIzgdrt4CcIIgPAm6cq6L2cqyaY0HY/uDHTiKqcTs4Exwnsx6BfJcZAksnwqvZA+5pngarujpr/0hykSpbv9inNBaWH02stvUFI2lGimmFVG6xQl7HPM6gpS1S/K2ufFLmVI4NJaDBZ2wAm91nyqTYmUA1OyPZlQGjQGV99xpjaQ27HkEgLgeGC1f1Oyv0A7yqUlalnWeCuuUGqBTNN7lRPcvPdnv9osg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jv5zDr8MLwWuKfbsDpqQ1TSqu2Wd3INGRtxWmzk79lw=;
 b=cBbCM0jBqxIqHpVUBWKrdanApWODeOLcYKA1QnM4Si1nejY/7mgvyrOVAKk27o25M5NvZ2uC/yIpwiTNJOikXub6tqxCYyIF+vPcvkzgL9XUU832K3d7Kv4WLLwDVXYnL1OeVLwb1OKOMBZ/4OfVMK6PEgLkWZsgJnew8tdv9Oc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by DUZPR04MB9966.eurprd04.prod.outlook.com (2603:10a6:10:4d9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.44; Tue, 1 Aug
 2023 13:28:48 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::6074:afac:3fae:6194]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::6074:afac:3fae:6194%4]) with mapi id 15.20.6631.043; Tue, 1 Aug 2023
 13:28:48 +0000
Date:   Tue, 1 Aug 2023 16:28:44 +0300
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     Roger Quadros <rogerq@kernel.org>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, s-vadapalli@ti.com, srk@ti.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] net: ethernet: ti: am65-cpsw-qos: Add Frame
 Preemption MAC Merge support
Message-ID: <20230801132844.o56h3bsx7zfwbeu6@skbuf>
References: <20230725072338.20789-1-rogerq@kernel.org>
 <20230801131418.bhcjtflj3iu77mmc@skbuf>
 <0f18cf9e-9c5b-02dd-b396-729b9fecdfe7@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0f18cf9e-9c5b-02dd-b396-729b9fecdfe7@kernel.org>
X-ClientProxiedBy: AM8P190CA0007.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:219::12) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|DUZPR04MB9966:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d9c658c-59ff-4924-8a61-08db92933ce9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wiNMcwHAVrkgoZWjmLYy5SR3c8fy7Q0Kc4eoLI7mtjOfButXX+q0PzkwAxukD7NkrTui3+NLwY/fFRSiKTVXJjgef4JiLda56MQyYrnnwjOhLFF0tGDTIGl5/gT17lA2lD+WxEh2/pez6lY9Q93xVl6fw7v68IZagF1i0C4AEPxp5lFc7SVFpOmEd0zoph2gKKsdQg3pPnweaGeIw3GKUEifUKIuz5VxZgE2/fmF8xxCM4a1A3rfpFug62L98GkdNktTBH9rxLseEm97IePE0HrKleYwH3C3g6lWh4R7ffN/0av0HHIQGjH4Me/ehbOUdcXzwRGPYaOj7h4UXvED2RGxulFNBKJ1lxr7nWhAve6GD8HZyKdo/STa24pSyKH39w2MCb6HzhtbOFlUUOSyRJ7LwB3+dUav/7ImOFen6qZuTNuIs6N6vOowwkNwkcyvHh+/t+2UXWRQQ2dW3G8w6L2M8Qt9cacwr6lUJAerCwE/CzaWgaoiECo1gCCH0neG73DT1QQ8UY71SPEGsAtaH0i7akgwa4XwcBaxiJotIybzrgi456Zo+bnTJBTDDx8XSOtVFttHjdFy9oq2TRWWZQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(7916004)(376002)(396003)(39860400002)(346002)(136003)(366004)(451199021)(84970400001)(966005)(6512007)(9686003)(6666004)(6486002)(83380400001)(86362001)(186003)(38100700002)(33716001)(6506007)(1076003)(26005)(8936002)(5660300002)(41300700001)(8676002)(6916009)(66946007)(66556008)(2906002)(316002)(478600001)(66476007)(4326008)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VGJhOHFZeGpWZU5wUGpUQk83VklxMWtMdTRyWHVqcG12UlgrNHVMSzU5L2Uz?=
 =?utf-8?B?NHFrZmlsWmt2ejc4SDZjaHV1ODluNWZlUXh0NTVIUnhvdkJNVnhoWUNiTlRH?=
 =?utf-8?B?RTVZbUV6UTc3aDYwUVdMRTd6L1NranN6bllGYWtCVXZiZ045YkI5R0REbU1Z?=
 =?utf-8?B?QW53U3VlOGdLOHZxanc5SURKQ0xsRGlNbUdxbWpiUWs2emtHY3B5RjRmU1Bv?=
 =?utf-8?B?T2JTdi8vZ0xZWENDU25NaEJLL04wNHFKVWZsdXJ4WlVlTi9jem1ER1dVU0x6?=
 =?utf-8?B?VW4yVU9tUXA4SnlrQkVnNWs0bG9rOTF6cFU2c1ZmUGJ6Ky94eHlYeXdJRS9B?=
 =?utf-8?B?ak9sWXNmcWtUaFR1aTJGTjN2TnhXNVlENDFFbEhNbTMzeDM4U2VhZVJaZGY4?=
 =?utf-8?B?T0ljUmxIeGdEc3RwRnZOekZhN0psVHFvQlBxRVZqZk5PV3ZsWk5qaWpnbkpX?=
 =?utf-8?B?UnpsY0ovbFZONHpDSjRWaktReUQ2OGZXc0F4OGJxdno5OXUvV0JabDYvNkdN?=
 =?utf-8?B?OXVoMFVMRzA3OFI3aC96cXcrODM0WWhDaUhuK2dvR0g0Wk5mQzFpTXFraFFr?=
 =?utf-8?B?M3F3YkMyK0VPaUdpM3lhbXJ3d2daQktmdkJJY2NRd0ExMEIxZmFZS3NNcjZK?=
 =?utf-8?B?SlpPcUlFZUw4WkZmbCtwa2xJb3NsdS9FRGhhM1BkTzg3bE1JQklCQ3g2M29k?=
 =?utf-8?B?T0RqTDZxVlNHMHN0NE9BOTRETmlDNWlJTUNPQkZMeDNYWEpLb2JseEdzazR3?=
 =?utf-8?B?eXpjcnZobEpNcTh4ZUNiMG5FczNmbmVVenNYU2o4SVNLR3BEVFRNcGtqQWxi?=
 =?utf-8?B?ZWJqTlV0cDRhSWdaMUpRNW9NdUNmMlNCRElEenlRZjFXVmZtZlhmaDg4NjNB?=
 =?utf-8?B?ZDJlZ1pIVm9lcDg0V3RSQzljSlQ5SFRLa3dNaEYwOHEvQ3AwSVF4VWJyN0dB?=
 =?utf-8?B?ZXhsbDNPRFl5b05vY0NaVmlDb1J3U3F3SGhJbW1hSVRtaWdsR0ZOZDNlMm9N?=
 =?utf-8?B?bFNqUkcyc1hBUXhrOE5kTTBIa2MxTHVkMjlZeG8zQmhFYUJtRHdwbGlkN2Ft?=
 =?utf-8?B?OW1xcjlUdkg2TUU1MG9ramJxcVlQNWRqblBuR05wcEIvZTdYNW1zcTZxTzRK?=
 =?utf-8?B?bXg5VEUwb3NkWElrcWNQV1I0bDM0M25qbkxET28xRG9rMkg5OGdWTi9NVk5S?=
 =?utf-8?B?eVVwRUdjV3E0ZTdweWMrVlRLakRRRTVBdGxVUXN4Vk9aVkp3ajQ4Q2xkMW5k?=
 =?utf-8?B?YnpSdzBWcmw3WDkrYTdpWU5CRy82c1BIRFo2cmt3UUdCaDFRT1Jib093UVhT?=
 =?utf-8?B?aDFMV0xTV0VWOUtCRktJT0lmMThNbGlvRUM3d1MrR0l2cjFRZmZWTm1YMkFi?=
 =?utf-8?B?UmtMSnIrNVlNSnlwaE9WOTdmSWc1TCszTFYzZGM0TDhlN1hSb0lvWDk5Y2Jr?=
 =?utf-8?B?OFFSMXBNaDRzMjhKWmErb2FrREtrQi9zc1UyVnZhcTFyRWRTMTN6UmxvUDJB?=
 =?utf-8?B?eTFyMkdCOFpwWnliN094QnRNUXFNUWM3YnU0Q04xaW5hUWdMVmxCNWV3eCs4?=
 =?utf-8?B?THBSYWMzTW5xWVhVTE41amFnbWhMdjZQeEpNN3hLRG9hNk5xZmhtT2EvRzAv?=
 =?utf-8?B?dXBHZVdUVWRvU28wbUwxMEVMMlhvdUhYc0JaTVdqbGlTdUliZm5NbkFUaytu?=
 =?utf-8?B?MklWRmU1cnJjdUJ6aXlIeEdKY2p6bDBqR3FMRUYvdURjSEI3ajJWRVJmQ1VI?=
 =?utf-8?B?eVlWSnVuWGZ2V3F0VHVQQVkraXMyL24xWDJJNTFla1g1SDhnbkIzSVcwb3Ji?=
 =?utf-8?B?UVk4RVkxcGdOWkhRYk44RFB6cXRlbm91QkwrOU0xZ0ZTSmVIQmIva25FUUdh?=
 =?utf-8?B?MHBVd3I0eFRCaG5ocWhQbDBLZDlBNEZ0OEpGYXJlUEtaeWJsMUxtTWZVMlBK?=
 =?utf-8?B?akZEOXJyRzA2NklHOFNPQzQrZ0JHc2FhTXdjcDg2VXJSSk9OV1VsRjZiMkdh?=
 =?utf-8?B?YmdMbFR5Uk5ydkZieVVkdm5TMGhvUWowZHZBTDlZTkMxUnE3MElQVm9qSkMy?=
 =?utf-8?B?UWsxUEE1L1FsSW5oSlRtWTZGUEZHNFBFTWdQZE1jTzgwUE9hYzF3djBLMjQ5?=
 =?utf-8?B?T01Ra0dFaEYycFdibVVwSXFtUnlxdW9QdDJLU2NEQWxGYUtocmZRcHVnTVdW?=
 =?utf-8?B?Rmc9PQ==?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d9c658c-59ff-4924-8a61-08db92933ce9
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2023 13:28:48.4170
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OpqQKutb3hTEr+aQCXDIo4RAI762mJ6gEgreAZa9nzodGwqotgPwv/BAwz15VvMjyuQ//CiKTO92o7qYiSURug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9966
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 01, 2023 at 04:19:30PM +0300, Roger Quadros wrote:
> > Also:
> > 
> > ../drivers/net/ethernet/ti/am65-cpsw-qos.c:173:6: warning: no previous prototype for function 'am65_cpsw_iet_change_preemptible_tcs' [-Wmissing-prototypes]
> > void am65_cpsw_iet_change_preemptible_tcs(struct am65_cpsw_port *port, u8 preemptible_tcs)
> >      ^
> > ../drivers/net/ethernet/ti/am65-cpsw-qos.c:173:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
> > void am65_cpsw_iet_change_preemptible_tcs(struct am65_cpsw_port *port, u8 preemptible_tcs)
> > ^
> > static
> > ../drivers/net/ethernet/ti/am65-cpsw-qos.c:179:6: warning: no previous prototype for function 'am65_cpsw_iet_link_state_update' [-Wmissing-prototypes]
> > void am65_cpsw_iet_link_state_update(struct net_device *ndev)
> >      ^
> > ../drivers/net/ethernet/ti/am65-cpsw-qos.c:179:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
> > void am65_cpsw_iet_link_state_update(struct net_device *ndev)
> > ^
> > static
> > ../drivers/net/ethernet/ti/am65-cpsw-qos.c:699:33: error: redefinition of 'taprio'
> >         struct tc_taprio_qopt_offload *taprio = type_data;
> >                                        ^
> > ../drivers/net/ethernet/ti/am65-cpsw-qos.c:697:33: note: previous definition is here
> >         struct tc_taprio_qopt_offload *taprio = type_data;
> >                                        ^
> > 2 warnings and 1 error generated.
> > make[7]: *** [../scripts/Makefile.build:243: drivers/net/ethernet/ti/am65-cpsw-qos.o] Error 1
> > make[7]: *** Waiting for unfinished jobs....
> 
> I'm pretty sure there weren't any build errors for me.
> Did you have and resolve conflicts when applying this patch?

Yup, part of it (the error) is to blame due to an auto-merge (conflict
with 2d800bc500fb ("net/sched: taprio: replace tc_taprio_qopt_offload ::
enable with a "cmd" enum")) which failed to do the right thing in
am65_cpsw_setup_taprio():

$ git b4 0f18cf9e-9c5b-02dd-b396-729b9fecdfe7@kernel.org
Looking up https://lore.kernel.org/r/0f18cf9e-9c5b-02dd-b396-729b9fecdfe7%40kernel.org
Grabbing thread from lore.kernel.org/all/0f18cf9e-9c5b-02dd-b396-729b9fecdfe7%40kernel.org/t.mbox.gz
Analyzing 5 messages in the thread
Checking attestation on all messages, may take a moment...
---
  ✓ [PATCH RFC] net: ethernet: ti: am65-cpsw-qos: Add Frame Preemption MAC Merge support
  ---
  ✓ Signed: DKIM/kernel.org
---
Total patches: 1
---
 Link: https://lore.kernel.org/r/20230725072338.20789-1-rogerq@kernel.org
 Base: not specified
Applying: net: ethernet: ti: am65-cpsw-qos: Add Frame Preemption MAC Merge support
Using index info to reconstruct a base tree...
M       drivers/net/ethernet/ti/am65-cpsw-nuss.c
M       drivers/net/ethernet/ti/am65-cpsw-qos.c
Falling back to patching base and 3-way merge...
Auto-merging drivers/net/ethernet/ti/am65-cpsw-qos.c
Auto-merging drivers/net/ethernet/ti/am65-cpsw-nuss.c

But part of it is legit, and I saw it with a W=1 C=1 build.
am65_cpsw_iet_link_state_update() and am65_cpsw_iet_change_preemptible_tcs()
should be static.
