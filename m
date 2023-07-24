Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DC4875F984
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 16:15:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231874AbjGXONU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 10:13:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231672AbjGXOMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 10:12:52 -0400
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2044.outbound.protection.outlook.com [40.107.104.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1D1CA3;
        Mon, 24 Jul 2023 07:12:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XcwzDO7gTg5TkuGIYbQtQj79OJEYycyxyWIhYlZb8pBJHSk4U3bsf8DpZXZnokU2+nH3JqEEOqS7A8qvzIfVt+2B6iW1zOXSn32MfGLxMSHF2XCpo/kkdJQHZcwiFcoSaFBNQ7PQqWJN+v1wxY6nchCr3bThbRyfDm/5noxy0sPfciVIGZxSTmaMT3PocdMVHE0xS29u3kidkhtRGBKEuNtvHYHeFtQCaFoKDsP4LvBgP96tO4U1WH+scebg1hQB/LeW5aTfQKGqXWOtY7/Fx1y3lNLvJ6oCGAhpUEAyTFnPsAmb6YqXFZLk6sp7/wN0MELe8ovL0iHGC5dy04sKFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xFy0L8MoZBwANkRIemfr6qSiKUQ5BJs5PyQao4w9D9c=;
 b=dXTlve3c1zPYZly+fWRd68pzebkVy8JnkyHqK65QzNN//DxG+cVxqk1x1eu9z3c/NHF28NtaIASZU9gD9x/wyg9+K8xTn47sk9PXwAYHV3Utrit3sdHzSKugQlnJqL3hUj9fo2pqDQ/en7rGxDXNjkI435sRdLZsyqg064AtgQBq5A3g75kmu/VKKGMxw5trh03V4s+L0U8YBor3qVS/4JTXZFS3xCm2Ib0knwSsrbWNNqWXB8Rm0Z8AVhnjcsg7pGxCiqdp5LiFQRLfo3E3EPtp1yw2c8ysAy82AUh/09ItiWJn29tzsKyUL9XHjQkUut4End++aZ4KdUR4oc++wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xFy0L8MoZBwANkRIemfr6qSiKUQ5BJs5PyQao4w9D9c=;
 b=ha5/tYCqNfJUggVnOkmmwXD1fDACH+TdCyAcmNlCa9vaU1kzJoL83+XFOjcQUHgdbUve9Tw9cMAyJxgzECvdJ5g78WSGScK+mMtaXIDd3AZLSR9WFZaNnZvvvEuOnhqTXaggNYGkg1qEh/kA5/HDwevKdv/UPj5+P+1wQrxWIlc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com (2603:10a6:20b:409::7)
 by AM0PR04MB6851.eurprd04.prod.outlook.com (2603:10a6:208:182::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.32; Mon, 24 Jul
 2023 14:12:44 +0000
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::74e7:6384:dbdc:e936]) by AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::74e7:6384:dbdc:e936%5]) with mapi id 15.20.6609.032; Mon, 24 Jul 2023
 14:12:44 +0000
From:   "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
To:     andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, richardcochran@gmail.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        sebastian.tobuschat@nxp.com,
        "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
Subject: [PATCH net-next v4 00/11] Add TJA1120 support
Date:   Mon, 24 Jul 2023 17:12:21 +0300
Message-Id: <20230724141232.233101-1-radu-nicolae.pirea@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0P190CA0009.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::19) To AM9PR04MB8954.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8954:EE_|AM0PR04MB6851:EE_
X-MS-Office365-Filtering-Correlation-Id: 38ede5a9-f006-4cb3-12bb-08db8c500c6f
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7TU5ffM5Ya+9fHgveB0QhM1TV6UG2HuiHZHwNEvVbSfNVyYdbqK8ESuYyshOAHup0vKLKoSR1WaJrWXwo7pAxRMlelHh1nLuxTujyZuVsgCsrh4RfFXZ96e2eu7nf6aVxPhH6PwJc1fJN+AqYPO8lw+rZ8fIYmmh83FE8NQ4oNUObdwBq+abvOp+drlc9XisFvPB3dyxu9yi+xVHQDQLIOhJosB/orgPlFAs+62bvC1XBxv+d/+i/Po6ZvqSMC9nSNjqr2Y+Rij3Mvra8u/rLCYjWm77gxX8YUQgxg8icp6L4LHy3jsjO8ihLvfxtqt/vEwZ9/7fNdDnwpGvAdPV0HJGW0omHCJsiAdhO1HwpSVv9Bo6psyvHsAoDi0MPo1MmS1TBxTaU61pFO8mKQg+ejFuAxbnY8kqE3PLVad8fEGd2VLI0qJXiHrh9hHiO1j1+7xQgTrVQpY3Glbnuakua3qdJU+a9MPOKBCrRO3buPRPmbibneLHbe8Gs/smlKDXT1vrr+ZOzI7xmOLW0mJrCtFINgSl79/tseWQdDGyTIhmQ+B9rJ4cJ+AcJlUCgZB0U3PZCCKM3pTInFT68+vTuMfD291BQv7kItUn10uGFeplwW0OO4wSdgjCEPhjiH7n
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8954.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(39860400002)(376002)(396003)(366004)(451199021)(52116002)(6486002)(6512007)(478600001)(6666004)(66574015)(83380400001)(86362001)(2906002)(186003)(2616005)(26005)(6506007)(1076003)(38350700002)(38100700002)(66946007)(66556008)(4326008)(66476007)(316002)(41300700001)(5660300002)(8676002)(8936002)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?89q88lVtmD/Ryy2CEjPNm+w5GRFGY5+b9W85aR5LNS7aHplJpSrwzIBC3fZ9?=
 =?us-ascii?Q?pksETpLhY4evq/FxNxm3tYUwWWITJRsj28pmH91UQs56Rs3u8v8T714+GFIS?=
 =?us-ascii?Q?QKLqXFPowz/tYm3oPq+v9CUcUWUbA8O5Byd5luGdtW3u0oKjHldeMbm47VRH?=
 =?us-ascii?Q?fBS18GjoFi629SbEh1GrQqPVtYlZF3Cm6FG8fV6mxqz1PGg6rmFmkT+/PCDu?=
 =?us-ascii?Q?xlwrjsFKnrjXDt+RMg4KQesQvrNAX+p+gInAbqCFufImlwGrBHet67FJ4wgM?=
 =?us-ascii?Q?w6gCYsqKpXug+LAtzs+Lyhv/a9Aql+L/GP2DAudm3vPEUzn8qM+5YdRxQOOG?=
 =?us-ascii?Q?ipRnNLiy4fwLp4UcQmzi6fyTllrxx7YhMBLDCv/3CmQg2z5ssBzxz+KcWFjV?=
 =?us-ascii?Q?94sWeNR1agFte9nH6G/QapxJRQ8YyEj4ZzbL+KUOKLBrkah/oN29PlqqpFZL?=
 =?us-ascii?Q?hc7MkITPdKNE40uFlOzjiZH3RqMsqIYvDxrmKDWf1b4Z96d43i77UH5AHZoe?=
 =?us-ascii?Q?BGW8hE+psKw9hZFUo75fD1pF1vNmGRsR1EWMQ/MOUfcC9VI+pGyS6ZHraotU?=
 =?us-ascii?Q?9897ZAWg8qGrOxKi1JM/JcyrfrlAFnJiTVhxSFKtsX0r2md781puWOpSKi7d?=
 =?us-ascii?Q?lpu+qgMIzr+PELA7yWkGlhfaTUWLsIUqNNvji7oux5RUVg9u6utio8sPB2Xu?=
 =?us-ascii?Q?3avOy3klnU7D5cANdrXGnEEtWssKS9pkUrZjJGSR45wVQBRw8anQZ8OyCIhd?=
 =?us-ascii?Q?unPAMPZLOgqIu3qqbWu8IGFxURPDPhATvIRDdaCH22apaXrRU/9pb83rUMGY?=
 =?us-ascii?Q?SLhu4fAyybnfP54JXLXrcYPnYl/7ft6TPBekRzWJsH1wz6LCT3sFzFc8/K47?=
 =?us-ascii?Q?sZtlQTqwDeIXSbgJCM/6hCf3Zh1pOluA0uxJ5ZQEr1GWPDsgx/9SpGQ4zC3t?=
 =?us-ascii?Q?s/SSioCJO9oBmyL0IwY5JwYVcUidiUR1sY3/4Zk22VYYy4trcJ+G3RPSiEpR?=
 =?us-ascii?Q?s+E0a2fhq2f2uRNtC2Phdd8wto+AcScWgjTaRUvhhNvPMeFe8RB46mA9x4WH?=
 =?us-ascii?Q?Ix5d998EEVHeTjAn1a64J7L2vJhJvMoqC9AXs3KQQvdMCxaOlFZnxYIHu+T5?=
 =?us-ascii?Q?l1TIXFLPlC9g+OwJAa81aXuWk7PhoT0LLbJtzw47QZ0M44vgCHoxY/I6ZvxO?=
 =?us-ascii?Q?SZeV1Rp5rUq/u2MEAj6/XZ7510trktz5FP0P9hUIEIg13Nf4E5UUJ2GPot07?=
 =?us-ascii?Q?dHWg7op3Eo5JGLWmF3GST/UqLnrLCPVjy5MskYeoDjA6N82BKRSjtYnkNB6d?=
 =?us-ascii?Q?MjYYHxkgJPvlvZAglgxzZdM2dDgtrvJG1BvrJOCFTP7qzTAEvZS8c7RsHCLd?=
 =?us-ascii?Q?OXKpF0AZowcXRuDvCC35ZL0k/G/QExw4C94oUSOtIScFFrtemQF3IogSnCD9?=
 =?us-ascii?Q?24DnFFObrNk90GzfR4e91Nh3I5Nfp27sfercZwgrlGA9ZkmbNFDL0ed091i0?=
 =?us-ascii?Q?ZMVOnCULS2/wuhHqIvsLTTNTQlqPzWFrrMOI0AYYmmbmG+Rq1G0I8CzcNoP7?=
 =?us-ascii?Q?hznvFVQifskLy9gWUIhOMQ/M5KFpsArNC0gNr/1NN93p/74THrxbWwXeEcIR?=
 =?us-ascii?Q?Hw=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38ede5a9-f006-4cb3-12bb-08db8c500c6f
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8954.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2023 14:12:43.9853
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t0aSOXc7f/UlksxwpfOcSggujTpbGub0mLZq7O5O/QY4tKqR88fbbTX5Nky5EEzs8UeocEKbG/8TZYeZ6Pg6b3dz789CUQvpkSy2DIu46a4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6851
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everyone,

This patch series got bigger than I expected. It cleans up the
next-c45-tja11xx driver and adds support for the TJA1120(1000BaseT1
automotive phy).

Master/slave custom implementation was replaced with the generic
implementation (genphy_c45_config_aneg/genphy_c45_read_status).

The TJA1120 and TJA1103 are a bit different when it comes to the PTP
interface. The timestamp read procedure was changed, some addresses were
changed and some bits were moved from one register to another. Adding
TJA1120 support was tricky, and I tried not to duplicate the code. If
something looks too hacky to you, I am open to suggestions.

Cheers,
Radu P

Changes in v4:
- rebased on top of net-next/main
- dropped "net: phy: c45: detect 100BaseT1 and 1000BaseT1 PMA abilites".
 Already part of upstream.

Changes in v3:
- merged "net: phy: nxp-c45-tja11xx: add *_reg_field functions" in
 "net: phy: nxp-c45-tja11xx: prepare the ground for TJA1120"
- rephrased the commit message for "net: phy: nxp-c45-tja11xx: remove RX
 BIST frame counters"

Changes in v2:
- dropped "net: phy: nxp-c45-tja11xx: fix the PTP interrupt
 enablig/disabling"
- added error msgs to nxp_c45_set_reg_field and nxp_c45_clear_reg_field
- used phy_err instead of phy_warn in nxp_c45_write_reg_field and
 nxp_c45_read_reg_field
- removed null checks for .driver_data and its fields
- added 100BT1 and 1000BT1 features bit
- replaced .features with .get_features
- dropped changed on TJA1103 EXT TS behaviour
- improved timestamp reading workarounds
- merged patch "net: phy: nxp-c45-tja11xx: timestamp reading workaround for
 TJA1120" to 9 and 12
- implemented PCS reset workaround in link_change_notify callback

Radu Pirea (NXP OSS) (11):
  net: phy: nxp-c45-tja11xx: use phylib master/slave implementation
  net: phy: nxp-c45-tja11xx: remove RX BIST frame counters
  net: phy: nxp-c45-tja11xx: prepare the ground for TJA1120
  net: phy: nxp-c45-tja11xx: use get_features
  net: phy: nxp-c45-tja11xx: add TJA1120 support
  net: phy: nxp-c45-tja11xx: enable LTC sampling on both ext_ts edges
  net: phy: nxp-c45-tja11xx: read egress ts on TJA1120
  net: phy: nxp-c45-tja11xx: handle FUSA irq
  net: phy: nxp-c45-tja11xx: run cable test with the PHY in test mode
  net: phy: nxp-c45-tja11xx: read ext trig ts on TJA1120
  net: phy: nxp-c45-tja11xx: reset PCS if the link goes down

 drivers/net/phy/Kconfig           |    2 +-
 drivers/net/phy/nxp-c45-tja11xx.c | 1134 ++++++++++++++++++++++-------
 2 files changed, 863 insertions(+), 273 deletions(-)

-- 
2.34.1

