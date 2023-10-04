Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC1AC7B7E01
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 13:17:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242205AbjJDLRa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 07:17:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232519AbjJDLR3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 07:17:29 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2074.outbound.protection.outlook.com [40.107.21.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89CDBA6;
        Wed,  4 Oct 2023 04:17:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DNGJiKlMNFFfiNTesh+4so9RUPE8mT6sHMACnNSUUzE3Ll143uxV/tE7QdEDqP/tCC/bsg6iAknh9k8pcpCTv7hfLnbzeGujoJEjJCPMd+cJ2eIwONdTDVxIyHmn1+HWCXLlRwKIJN0jj4PTCC8JMi9mVgzEYggpSPh5dxZrRYjfKBvIm66lcV/TQpZXJSa68bPwPcb8LMorcI+cw9LSkkEKSX76kwCcBUXT/vjg0Sm8TpGa6Ew2VKy9W983+xrSGMsrktg1goFyVE3MftHIkaeIBUDwAkJSCRAoOAp0ZdQEoft1swqiu/L/CX2rptjFZn5JYFD5l8AJWL2BzIGN2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xEUa2ixnzlfimUNxVDALtFf6OgXLfkLJkOL1YDiXmAQ=;
 b=nfbRl1GEO1qMOcbNGOspWZnI5Nei9YDnaSL4HABw/W8rkgDUseART+JrkaKzVaUel6XvoC4pDe3tSiwkd7s+0rmnOkd9+IUV4aAmQJbawtU8x+k/i5zUVSKVWpgVSFf88jB3nPG2aYQEJ4HQPp03DhvgxohCAjcNtL3XHulxLztrY9eAuWZfxCfFQSk7k4CvoIk8i4FtILOT2KVtAz99KaoS/QTugsGkPNokRGp+I6qR60ePxfYvbzPfByFZNciwVwJ8oEsTvSB421aSS0E1AVBeK+CUrMkPraX8qgSFG0OHFgo3+Pn0ZkjAsmU2bV5I952nN4p6PBaPuIDmjxCbEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xEUa2ixnzlfimUNxVDALtFf6OgXLfkLJkOL1YDiXmAQ=;
 b=sJN/zg8S4LRHgNnehPfBGd5BEaGP17EJb8A6FPirNHz7CEOsH9XcZuPAulLS8ZZOy6O3cuYoFJ6bXKGchxGw38uTZ0z6++rSHrwWI3U2F2MYiQg568oqF/qFg5eByNWcUWdJ0XUFf0XoMJdNdnXLQT5kT55MeNodLSck/eQi1kw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by PAWPR04MB9911.eurprd04.prod.outlook.com (2603:10a6:102:38b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.36; Wed, 4 Oct
 2023 11:17:22 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::568a:57ee:35b5:e454]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::568a:57ee:35b5:e454%3]) with mapi id 15.20.6838.024; Wed, 4 Oct 2023
 11:17:22 +0000
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     netdev@vger.kernel.org, linux-phy@lists.infradead.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Ioana Ciornei <ioana.ciornei@nxp.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH net 0/3] Fixes for lynx-28g PHY driver
Date:   Wed,  4 Oct 2023 14:17:05 +0300
Message-Id: <20231004111708.3598832-1-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR02CA0119.eurprd02.prod.outlook.com
 (2603:10a6:20b:28c::16) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|PAWPR04MB9911:EE_
X-MS-Office365-Filtering-Correlation-Id: bc13044f-8354-4d5b-9345-08dbc4cb7abb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OQ2/VkRHVWmCijD8IfwThJiI66XJFH8rjjlpImR8FXd69i2n0WjbTrt2+pdq1+Ng6CsM2VtkJO31kTgLTyElx+JO8O9UAowO8SSc50Oy6ZBrCHdp0Rs+G4FVKmN5JMMX9hcoFafMMpJrPkYP9LI3Oa+mEiDiL0RpUPwJDV/Spja4sqpjDMY7MK8yjAoOOkrKPTEmWVlsoc9tyLszW0qtayKY8sIeACQyT6X6bFr813P6SWV3PlWj5EwqfVD6Zzg5VGRiy/feaH+QrqsUD5wSaPaJMIBRiyVBy2kogUhIYM95oK/jX0Zui7OoOiAx9FFLCWl0tz3ihg8G92eqLnr/mTLf6PnRxDhT9HcXqlp29gsX9XtPzGTbkbqnclsgfQEis2mqYu5qjdzJP1M4150gpxu1o3e6F6xn0bfZj/pXqCbj97KeIOXCc4AzqZrDC4KljZGKV6DydG+CkiVU3SKFtKfPA0wFzM2yRJ7RZEG1AoJ2bhBmUsAgm65IXbdJk1VfkM9Z5gy95WC2c54qhV/LOKFNrZK07O03vY5bd5oAcZS6N3kRAIyLyh++ctixCqtOTT1Cv2Ok5RhN/wkPusImwZzZcg5uZeCu5FbbUkI7PNS4B2cEEZofJjCJ2T+mnmu1
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(39860400002)(396003)(136003)(366004)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(316002)(66556008)(66476007)(54906003)(66946007)(2616005)(1076003)(26005)(83380400001)(6512007)(52116002)(6666004)(38350700002)(38100700002)(86362001)(36756003)(478600001)(6486002)(6506007)(2906002)(4744005)(41300700001)(8676002)(8936002)(44832011)(4326008)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MpZts3V1dFZoprdBAQ9hX4RoG6OBhJx7YqskPRBRCPkO0YCHhZXSN2GA5bv7?=
 =?us-ascii?Q?XvQvLgC0z2FVJlDhWTGYV4exfJd0xAsXKbVanzPWanLKA0p7GIhMgMgQDZ+T?=
 =?us-ascii?Q?rscKJ0WjnNVySb304wZ4aRaBiyMwW/wyr+2OFy79IvesjIOb7Z+i3Bga+hGQ?=
 =?us-ascii?Q?N49jRmdaZxA8ohvTEmnabVpxtHZC35pS058migh1pl3MmctzG6f1FwvaGym7?=
 =?us-ascii?Q?w7us55XG7+P12wKs4Iro1pFJbY5674kRW32mb1BofYlU2RN2cbYgrLTzBr1G?=
 =?us-ascii?Q?eBuzJgLqC4/Ep8xHettzBoXlbtotBZaO00EDnYIHFG7WJA3KbmjgifiPjMmA?=
 =?us-ascii?Q?bUzMDe4SSPQIpCmoThVyzXDC97LA4M+3sgkOoaj7D73hNBZ03Amjn4sOVsiJ?=
 =?us-ascii?Q?EsNzRgRbV/xLF7Dr/C8GvpNv0/gljUT4sZU1deeq96WDZ0Y9HBDOow88iQET?=
 =?us-ascii?Q?A9/byWxtx40BlQ0vevTBTveGa/sRP0lrskY4JG9f1ukRCMODWU+kPR0mJf7m?=
 =?us-ascii?Q?oYECuAJubUFIOalEBUAcNRWwurxDhMpJ6lW8DtGsGeOXyVR5+df4ufwLhvH8?=
 =?us-ascii?Q?Qxf8TuANmnbRoBOwNVP5Y0geyisH9fZu2z4J+numw2uV8hVRZ/mIz6x4GznR?=
 =?us-ascii?Q?uGdvUfBrZn1asJ+dNQ3qe4Ffs2pnxnBn2XGAScpfou4e52oHnKfdDXJcuz8F?=
 =?us-ascii?Q?2iMy1M6Nh/VQdOXkd89mGizVwhilerm8rIuO2ZQN5Z2NgPlX71QCRklsQs4m?=
 =?us-ascii?Q?BL7blSBYlhDpcYODO6ghfx6Ynx0dsk5SAIwYKAfGcEpbOimhVTpYFMkMTIEZ?=
 =?us-ascii?Q?rWQaUmG1NIothn184GKORo4Eh6EX0aMJJrK19tbtfD3uNvNrz+3cbHCiAwZR?=
 =?us-ascii?Q?hWCbLQJdu3+CSCA/mf8mhIqhFKa9rpChiqRL0qxZSkysr350zyF3nn1Vj2zy?=
 =?us-ascii?Q?z3Kc9vPGZ7N6eS3XInWdIC2KEZNLC/aW0JeqHgq6v2g3GsVHc+A0oWJPFR6z?=
 =?us-ascii?Q?P1p9D9oHYr3CEqyj563RK4goBSj3kNe9Chewu6QgHMoLXSb5OwMFDCrI7S09?=
 =?us-ascii?Q?KwXS5tTPszny3hQ1nS7RlgzsoTk4djEhUydCn7rGrl2qLiBC4EHB0D1UUtFx?=
 =?us-ascii?Q?thXrGOUGrAHLBfYHKEBEzdEaei0kSn+LkHQiFgQc2kmAeBXpxAMnJowtV7fM?=
 =?us-ascii?Q?S8cXixG0l3uVQznW5BcOW8X+Eu24uT7wMcBSSX8ltix+1/hHsJCmYTqWp+ry?=
 =?us-ascii?Q?mbTus2EeYsKgOwEr316WImc3r6UntNJN28NNrBUlWIx/2xKlC3cSmnARGkBS?=
 =?us-ascii?Q?gZndmCXHiOfEbeC75HqO//dagXOjPpLMO9j9oyg/+XYKBz3NCnD390VmN+Dn?=
 =?us-ascii?Q?yo8VREOuVrHcoUp7Y+NK5FL7kXoRCTGHDDVf76yE4vFHuKty/ahGb2eOzIUC?=
 =?us-ascii?Q?wdic3YoDTNftzkLBggyxmBRr5i+dXYH1s1NiRrZDgLAFfhW1956uR93Ll639?=
 =?us-ascii?Q?qEmlv/m63/jG/H9XG2TIG+LgmvTusJl6ijdpHOrfJBY9TYVzzShqruWDa5mE?=
 =?us-ascii?Q?HozRmPmrk7w/o7E/VOKLhQcnx1/CH1kfINRwoAAV4IEeLJ2f6SkfkUPSKATO?=
 =?us-ascii?Q?Wg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc13044f-8354-4d5b-9345-08dbc4cb7abb
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 11:17:22.2006
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9xwLU34FxbLaMU8VkTUBYLwN8UvXGBdz1dlb2YFmpBBFqsGJv3CCyNG5l0ksfm2bSHwaT1Xi+9hg70cng/malA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR04MB9911
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series fixes some issues in the Lynx 28G SerDes driver, namely an
oops when unloading the module, a race between the periodic workqueue
and the PHY API, and a race between phy_set_mode_ext() calls on multiple
lanes on the same SerDes.

Ioana Ciornei (1):
  phy: lynx-28g: cancel the CDR check work item on the remove path

Vladimir Oltean (2):
  phy: lynx-28g: lock PHY while performing CDR lock workaround
  phy: lynx-28g: serialize concurrent phy_set_mode_ext() calls to shared
    registers

 drivers/phy/freescale/phy-fsl-lynx-28g.c | 27 +++++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)
---

I have some more work pending on this driver, hopefully for this
development cycle, which is entangled with net-next. Can this series go
through the networking tree, with the PHY maintainers' Ack? The original
driver submission also went through net-next.

-- 
2.34.1

