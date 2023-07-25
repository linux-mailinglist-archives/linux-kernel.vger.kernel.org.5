Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEDAE7622E4
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 22:02:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230082AbjGYUCS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 16:02:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbjGYUCQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 16:02:16 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2122.outbound.protection.outlook.com [40.107.94.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02BCA122;
        Tue, 25 Jul 2023 13:02:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JlGw9hvM+IeSAnoK6Ix1ghc6LQgu2wp+QZKif8Z3sU3DwCPwvI9e1z30bgeoEAWVROk4rDelo/zrXdl66D2fBvHE7knRgNGVb1ygudvqjGdFRxUdpotlA3k7AySqI84Fjg3Im3gu1IEleHyF98o4R1lBZDIKes42SRFRNfPQxeaTRXTJ4KkgYDDcxOR/MluX9WYBA3E8fuxQL1SMWirXgcVVC6ehBydh4Kz3IaVKULIagATok086YfrgVfdiqaXvbaaagv6+sdtHo+UMVpNgLhaP8zmtaryngzJVkHB50r9dA396oJDqeKblBOwS9jSDOmsszHW6SNLk6fyXBeK3zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=norgWxuffg02CcWuv1SmppHeaI7Lf2aVOmDSQ+CP06w=;
 b=Y4Y26dAkwqf5cNIV9cX0ukaqhyV0gXXehxf8kvLCoYLoQvdv6EBJOkr2deRU6S2wO1fwunYwzRwC1Rfl6fSgZRR6QNhMp1CuOUp66GXrTw71adWHWcP6tp8n70pH/YmPgkeHogQqnPmsBbspPCOgcQuJA9ugvmTqdInSnaf1xpKCrfPRIG+Kbk3RKV3xjBPGG8dTRY8c6qr2NNohF4Jpa8tWwd533YdqhYESGIR2cWXNQMl5T4jV0x6pZRrLKAFxpr9R10gHn/r/KhS0P7b5C5PCjpZxaNc8AGt/xZaQMiCQ+gvyDbYXZx3BT+5YHNS8yl6DzW09dWKN3EskWuF1jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=norgWxuffg02CcWuv1SmppHeaI7Lf2aVOmDSQ+CP06w=;
 b=ChheWTP6VKt4DK9m/xnXn5X+kn2M25hSpI9msTYiPI7u+dGkQWp1enhERvor3YI4WjORiuKYTLBBvtSYjbsbAGLPwRw+iineYkHTfTxCsrAJqq/K593jb2NmEn8m9BmdMTBQysbIdV/NrAuAkWzpA1FPPcl2vXGPsrgmbUgNqkM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by DM6PR13MB4414.namprd13.prod.outlook.com (2603:10b6:5:1be::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Tue, 25 Jul
 2023 20:02:11 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::fde7:9821:f2d9:101d%7]) with mapi id 15.20.6609.032; Tue, 25 Jul 2023
 20:02:11 +0000
Date:   Tue, 25 Jul 2023 22:02:05 +0200
From:   Simon Horman <simon.horman@corigine.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Ioana Ciornei <ioana.ciornei@nxp.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Robert-Ionut Alexa <robert-ionut.alexa@nxp.com>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Sean Anderson <sean.anderson@seco.com>,
        Josua Mayer <josua@solid-run.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dpaa: avoid linking objects into multiple modules
Message-ID: <ZMAqPdO2XcIXOCFs@corigine.com>
References: <20230725064403.581634-1-arnd@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230725064403.581634-1-arnd@kernel.org>
X-ClientProxiedBy: AM0PR05CA0095.eurprd05.prod.outlook.com
 (2603:10a6:208:136::35) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|DM6PR13MB4414:EE_
X-MS-Office365-Filtering-Correlation-Id: 60a96da6-c53e-4ebf-9df5-08db8d4a0892
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Xkog1G0yGQGDbIpArFoFni5SBvYQa/RcBOmcuJz5jB+eDxFtHIahbK0OkVJ1uQtQMppvA6SUE6r1p/GL4PqnhfRXwImF9bYzC2KdOAewzQoTNOuaKHfoy2y6zLBgSk/rRmAlPXiQS7eA6cpp3Z42y60bXQXY0XAcqo1VW+BjesdTHO1WmSm4WvuV1QwF3XZLNALHEXt4T0+fEKSY69Vbj8Q634JjZSRIhNjyRANRW2pSViRvLpRFL3DNujlQ4KPdIV25mIdottK0XbMIJT+CpL8TBZclBttZrkvRhAunCJCzzz7PQEGiFw2Nw2/PXgYrnqitcKIxMUUProaSkaIVVWpc6ISevUg9hrJArDNwQz063pseYdOcVY7A3PLtxKpKW7hwojNf0wMa/NsbfRrChPUyjp52Or5VcjH31BvrO8xP3ybf4/eYHoWg2RsEBMm2vREzoPv48L+cASvrIN8QBJRFti2BDfI3dqhI43QK7lgz3dO3ZBuAZ62dPP69Kc/82pmtfgNsTyrdjgy6V22KVcFS/V6tzgnqmABFoxpp2ME63ZvFSFoHmuWU9NPSuduLNllflaQfQejCf+mak0w45ylcGQ+p80u1xgpQ3e7G6sU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(376002)(39840400004)(346002)(366004)(396003)(136003)(451199021)(86362001)(54906003)(6666004)(6486002)(478600001)(6506007)(83380400001)(6512007)(186003)(66476007)(6916009)(66556008)(2616005)(66946007)(4326008)(316002)(41300700001)(8676002)(7416002)(36756003)(5660300002)(44832011)(8936002)(38100700002)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AK2T2YglXpvwyCQ1y+YyQjSeoLGXPbGpe5jW7aRvcb32YFs5yZurT6B7r4fR?=
 =?us-ascii?Q?nSggxiGiQ9uLtdyZwjFtGGTIsvdZe8U9ftW8MzdsL9iqurK2iATRHMId1kZ1?=
 =?us-ascii?Q?5Yixk103YrUqs7ht/K35kzfGVxZr4CjuCKzerH1f/+12SEAJk0CicWY+QUUn?=
 =?us-ascii?Q?v6gJq/ghDfXAkeR8FoV/F2uBrgsnCl+UDvnksvL/UXG51fvsGAxnvBap0TS1?=
 =?us-ascii?Q?7+cmiNlktE9ys65KtKh2MXUzJurPKp5RRU9sM9TJ7a5Dve1fvOle86UFPX0S?=
 =?us-ascii?Q?QF68BZ48r76G2r6R/+6yqXQ6dM2rQhJFhEmuG7oOCTg0KYtsfja0DmlsKxtc?=
 =?us-ascii?Q?UW0DK/vmw4HknrWekxQVJQYnQNNAWjAY0Fhv/bhz/8swbHF7RA9xqn+32Aj8?=
 =?us-ascii?Q?V2CRMN7/8WWtAVNyRduXBp+lY7zJGXdJ4Ufkf+4djpEEdkArLRl+Nx+g7+gg?=
 =?us-ascii?Q?Lb/Ue3qZRBge5O1OeHL7MPMC/jJzJWOqYMUezzK0lkf/z+Cyih7vgmuwqsaa?=
 =?us-ascii?Q?ooy+Ez7alWsz7aDdeewkizUTvKo+HbD3EkB9UTqQubhicZgkJEU4ihn+Eo7f?=
 =?us-ascii?Q?6Bkid/0MSwYoZqX1e8VUsXd8VAP4iTg/1B9ArbUiZNrHSrUckAmFaBMULSXJ?=
 =?us-ascii?Q?3WfTg4men7FLh1euepIInyKIpOWGD9flLgpxIxgCn4OgN70PWAthQa3rbZ+o?=
 =?us-ascii?Q?2VY1u2jixog2SYImQyw0a6Nd11LrCkSPM8YFRn7Ap3vXbAMHNXNbndVfDQE+?=
 =?us-ascii?Q?d4VCjSmBy+R4JI5CDzGrLbXL92m0AMy1qcW5P5cWl5wgMs1Gp3aqfwr8i5nQ?=
 =?us-ascii?Q?E9hEm+kf3IrWlG6UCgVI5xpxkYvh78m6GzfaCYfJrrFt7bfmGJ8kyXStDQwY?=
 =?us-ascii?Q?oERNRB59FbbXXShD3u0L/8YqqfQVvRM89lf6g02196VqfmEddgJWfs6QViH/?=
 =?us-ascii?Q?GovhZ93FbRomuE3xss3d+xcbTKEP5+nhw9I6SEGPz8wXO9ZPOTyS03iEFDT3?=
 =?us-ascii?Q?r0oetegNYeiyvWynXoOWmbilQMEgQYw6R0iWR8rJ1Tjll+ijbcKL8snVDyvT?=
 =?us-ascii?Q?S5GVE1q3w37gyQNSMX15TpjxZMfaXVF5OIW8k5e20qVZxzP5YkHaH0UwsruI?=
 =?us-ascii?Q?op0PrWUP2sLT2U2s0NmlQmgSEyb3zecE9+K2PfFpq0+m1us7pgHFcyjt9v9n?=
 =?us-ascii?Q?vC7nd+5hYEolPcCX/2O0zgGhw0j+J+R4qm941qYM3hRfoImZslcVeFejcjQs?=
 =?us-ascii?Q?bIxbrNluF5KosUB+XMPgldH9JmvFiw3EO26xQeaSaiDEVxr/wzqop0ZL1a+I?=
 =?us-ascii?Q?4lE1tSz5BNqoGbTIH7shFrM7pl0JqaQ/fszGRJuEyWoh+/wkiu9RmK8+iiWV?=
 =?us-ascii?Q?6BJrfpn1hzI5/1kE8V5ERKDGVXTAvKY4dpbkTZKVhT8FoNiimNS9NZJAj5H7?=
 =?us-ascii?Q?48q5npeNzTsrVnHxwumbVjb7eNXxsw7uRZke3idIfQfewdNH4MPi2Z8na7jY?=
 =?us-ascii?Q?HDoBGPC0Boh0hatQhK+kTMZ2AeroSQT8QSXewoSh8XBDodlNBrZd77inAYC1?=
 =?us-ascii?Q?pjTeXB3D5a3USOAfPWqRBwDHW2UuDAgMeXK8YZSn2S6RWKKdLuWNNQP+q/r8?=
 =?us-ascii?Q?Q4wxHVMYWMl9UTPOMrQyVPaF6isO3WxGWwRftmEWJcJPizws9q+l63K7dTmk?=
 =?us-ascii?Q?0a7R3w=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60a96da6-c53e-4ebf-9df5-08db8d4a0892
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2023 20:02:11.5316
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +JhGdgI+XW0ZoiXdpQWQUnHitpxJD2Mt/BQsT/fPnIUhUt4bNGfOW8xAIh/rkRpswvvSO0WQFfGVh8QdfM6ganVyX2njHFRpqtwrS8B26ck=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR13MB4414
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 25, 2023 at 08:43:40AM +0200, Arnd Bergmann wrote:
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
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Hi Arnd,

overall this looks good to me.
One thing that I noticed, and I'm not sure if we care,
is that an x86_64 allmodconfig now reports:

WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/net/ethernet/freescale/dpaa2/fsl-dpaa2-common.o

