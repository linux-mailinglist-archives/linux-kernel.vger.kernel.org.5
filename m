Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37C517CF7F6
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 14:03:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345480AbjJSMDV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 08:03:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345613AbjJSMC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 08:02:57 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2070.outbound.protection.outlook.com [40.107.13.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15A9C19A;
        Thu, 19 Oct 2023 05:02:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UAJCGfgTWUyyF7SzrVJSnujcS+paps8VNoKa9VBmOYNddqhkuxsbmfJyeocXbXWRkmDUb9PD2I9V3nKKQmqtzsL5uzHTzQWBr7uAQV0+hGoNrYNOb06/tjGO2rCscxhmiftxmz4T0fp5x/mz1vtYPp+4T5HG4fFk+aXrD+JZOCGF/5habShmGgOzkPygPK4ZX1jE7TsYJDAV1g77Y1/nSjHXmCSX6FdbvuQ7gMMPgg0D0TtcQKr+cUkggiJx7cRgWXK4zdJbIv+PXqXGcgJg8Y39vhqmlL8KOhQTEGvG3Y6V+3IM5kYd8fxA/59LFeKfFOPqb1Ln+lD2v31TDMKeVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tJ6IWB1eO23xxxCaqkfHUdzdxtoCCVxgxW7CGg8ub4o=;
 b=HCH1reW/UuyAmIO3IWsAnK28um9by+lQeFlzyZqGYG7obojBvYlMkYid9y62SY1nrTHZwwZsLfD9wlJw4WXXQrnsD3JZtPcBxaE9VNmT1N/XK4xR2rQ2NHofPNtq+uNH3Vty5bJBGQyhHHuDSkfmc/1bv2iovFnpkkCWFwkVELoEHAoKq5x0gWLDoZA9RtmsqazzriVbPguaXsXqW3OzU4H/1p30u1uiy8t7NO+dBTukmJogOSdUkiDuxFehCyZVmetJmsUyr2LdXNOfBWOU/nBgkbhFmJHqXGhw3zhbYEzvs9t6Xe5n3Wh2f1sBfx99R0DgmsLNxHyIr1NOTjHNpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tJ6IWB1eO23xxxCaqkfHUdzdxtoCCVxgxW7CGg8ub4o=;
 b=TQM2dRoyPja4XbBpCzeacslMIBI66nalXNW5p8Yk/QvCHFqEgSYb1W4pJ3daXCHg7PTMOTThOaC91wbnZnXVsRNPS+JIS5rAx4NrVvgJqy8jYCL8vaS2dycyspZdbW75ixvdrp+c8Yq73Dbnx600TjM3IC6TIDbj7/tHTi8GbgU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com (2603:10a6:20b:409::7)
 by DBBPR04MB7961.eurprd04.prod.outlook.com (2603:10a6:10:1ee::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.7; Thu, 19 Oct
 2023 12:02:50 +0000
Received: from AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::e109:7026:7d76:5617]) by AM9PR04MB8954.eurprd04.prod.outlook.com
 ([fe80::e109:7026:7d76:5617%7]) with mapi id 15.20.6933.008; Thu, 19 Oct 2023
 12:02:50 +0000
From:   "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
To:     sd@queasysnail.net, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, andrew@lunn.ch,
        hkallweit1@gmail.com, linux@armlinux.org.uk,
        richardcochran@gmail.com
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        sebastian.tobuschat@oss.nxp.com,
        "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
Subject: [PATCH net-next v7 0/7] Add MACsec support for TJA11XX C45 PHYs
Date:   Thu, 19 Oct 2023 15:02:02 +0300
Message-Id: <20231019120209.290480-1-radu-nicolae.pirea@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR08CA0236.eurprd08.prod.outlook.com
 (2603:10a6:802:15::45) To AM9PR04MB8954.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8954:EE_|DBBPR04MB7961:EE_
X-MS-Office365-Filtering-Correlation-Id: ca1cec73-e0da-4642-92b8-08dbd09b505d
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9bf5XIhjFIZuDqJQRaWqTI65TS00jSiQF4rL684lwxorYOazs6TdZPy+Pq08+X6VRH8CiBtMFFDKyv2uZgaksvQr2QAVtrKEjs/v0CFG+RKIivPPUqH+dAySqklAl2E/gH6MBCqIxswcgNjPxZMsht5xRAFuQD+2uX63fKSLFOcQvHcgKeyi0C4fahZxnQD2TojsyiZ7/Mlbq36PQr2yzSHWHMOgqsItQwwGuyWJGgeI7PwmkSFq8PZVWfRTTGeAXMzl0khasrDLOHUUr0+Mkhuo+KWXMe3vAPWY6j+sg1c2PeF5BaZC2QE/UZxxWiufaSE/h88FdMTPYJdReG8fKHYGjyNviM7sCG9uMFZv7U5D9Czfu79IQmF5yPPGi69q+WN6SPl9rbgnbUS8EiPqiNoACscg5Vyn7GEzPCJrSiEkmJp2U60gO/HuGl/h/8rukuOVwYnc97/pBhLncmQRx8sgXeko+0IZyul168cHEC6zN23iCnDrsDrFehRUAeHUE89NbblSN6j3/WHqGo4zgKswvT7d06tZwVdjXpCBqYEwb24Sg/EI520DWlsOi3EMFBRXWv7qq4WPBD8AmnFelwtWvLJTHZRGWvFtCY1zxe3Bhv5x85NxKFAwEhtgSdr4
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8954.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(346002)(136003)(39860400002)(376002)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(38350700005)(41300700001)(6506007)(38100700002)(4326008)(8676002)(2906002)(7416002)(86362001)(83380400001)(1076003)(26005)(6512007)(2616005)(52116002)(5660300002)(6486002)(6666004)(478600001)(8936002)(316002)(66476007)(66556008)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?metzaYOjr+vGbllQd66niENEKQ1KQZV9eIV7hgYMspR9QKE9CtIc/4HOSlMx?=
 =?us-ascii?Q?sc6Bxt+Y7KqHFbF4VdvFHSaZYoWwRFTFpsJW+CJpAh9P+4yf3gnbIMk42iiS?=
 =?us-ascii?Q?EBT5yyuyetCv/Y/gLkZxI9UWooWUFZkB9ykv60kY0CzlJm3jfahHhl6FAbtD?=
 =?us-ascii?Q?I998tRNAKRKQwbpJ2aGW5Rzryaty3mhb2ymb2tX33JUqv4ZwZ2FNXkJQcumy?=
 =?us-ascii?Q?ALZMOU+v9xVL5s1M0TvaVnmLNfLZBiBFsHCxMTj64P5RDLQF3eqIpKxuP1xL?=
 =?us-ascii?Q?Rca+qB78U5zLqHgIUjXr4UDLdrL4WEzsWWY0Xwk+njS54Fd1vekBOfrK3LTY?=
 =?us-ascii?Q?65JlLKsmtHNQ2w2oj6GxfMpy4oMoj+Q9B09p4xKXEwSlGzFslbZ1+X7gtw4n?=
 =?us-ascii?Q?fXiVPu9nC6CMV5z997owgWiFgfFH9X7TNWO6lS1tgilYfgcwBAjeU50W0kVB?=
 =?us-ascii?Q?Emn+I5IxUxuXhPonUj9ZgmtgDJFuFflyqovX7tuI1zlx5iuJsV69jSsw7a9R?=
 =?us-ascii?Q?OapJFBW90JrqUXDNnIJZDVR3RGoCqqxsQqpx2BwJP1smPV0flkcioJWniwyo?=
 =?us-ascii?Q?ybArfyGBIZoP7JmXQ+PxRmsmnH3UAvDAhNk575z9O+xwAAapZ+wQzbG65FKI?=
 =?us-ascii?Q?uAfDKBRHOauZKu4vuT58hCGRUGXjfmTauBBEExT9WY8zWHel5vAWOux8e+/T?=
 =?us-ascii?Q?u5F96oHCOBbWgUlv5FgqFGOSGTGJ420g8iXm3sS+Vi+NkkO//n0B0KstCEJN?=
 =?us-ascii?Q?9TZOBv9d6yJFQF5gg0JWb6u9TDD5YpIh+Yeixc1TfyXKT1MM/XzX5j906M71?=
 =?us-ascii?Q?OII0BGRf1V4HQ+w/MZvm8Hf4N2ZjFio7PPiFktqQBzj/oB2JnjpfwXFzZn6K?=
 =?us-ascii?Q?e1+CrbNLXClcKW63glLPIVWfmW7AFBZorwA6qtI4HNw3I2dnSuN0Ho1Qb5Eo?=
 =?us-ascii?Q?zl3LeChwf40oXUNUy+Jci5Mo0V78gD5JxOGWPezY9bhW+ZioWiUgKuXRGhjP?=
 =?us-ascii?Q?5+q0eSJMzCkDOWfBA8U33xk5Q5dFJZuVcl6+oxCy7dfsFHUG3EPto7yCVrX7?=
 =?us-ascii?Q?Tx0nBwb+kYIt+bjvp5wgKMgwv6VGW21/zVJDJ6lfyqrD8RzrsW1N+LXIJnrw?=
 =?us-ascii?Q?D1cb5/7o8eZOOejJBc0K5khcVtkkoeuyEFkcoXGCNXdbrSUKBh2NaMWlwoWO?=
 =?us-ascii?Q?V1dPWoTrLuukDFFyxVrKg7osYSacuhFGaC9lXqaW6wbaAT+/Kcy20q3ALEIc?=
 =?us-ascii?Q?OvfGIX6hre5rhWqIWOx4uZRTXY3PG+C76r2ZH7C8g4NMUU51Ms7RAMy7CIAu?=
 =?us-ascii?Q?3ELENa1qBY8+G2XwXQTfoJg9y77JP+Wg1HuPF2azudNykR0Y/SDjRLZ0cWYu?=
 =?us-ascii?Q?oaTfL4qEgXW/7AEYo8vsvSzZ8cYQW/uVfxaqDn0QimItVA7I0bEhK8FpFQ5o?=
 =?us-ascii?Q?/tZUH+Aq9iC7CimwvLGzCTjUHjNl6mypfTS+XgUB73RFoaX09XSwcYLeexOe?=
 =?us-ascii?Q?90s404JM4fs8cFwOmxTBYxh6gYWuBeD88MfF29joouCV4zQZ24Od7p8Kc/qg?=
 =?us-ascii?Q?BR06zpm+rglt4cLOTh1NNBSxj7TgSenn+TcW+2A6dpDgI114SnxESFWN9eeF?=
 =?us-ascii?Q?GQ=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca1cec73-e0da-4642-92b8-08dbd09b505d
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8954.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 12:02:50.0511
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HOgZTuWkoFmG1BGHTsuIyj+g1MTTr13ramXJEjiI/iEYUce55RPbhHlNdJQ1QgmKC+ONBumRd5eMSpwsOTBB3so5/yMkdQ4n82I9R4nulik=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7961
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the MACsec support for TJA11XX PHYs. The MACsec block encrypts
the ethernet frames on the fly and has no buffering. This operation will
grow the frames by 32 bytes. If the frames are sent back to back, the
MACsec block will not have enough room to insert the SecTAG and the ICV
and the frames will be dropped.

To mitigate this, the PHY can parse a specific ethertype with some
padding bytes and replace them with the SecTAG and ICV. These padding
bytes might be dummy or might contain information about TX SC that must
be used to encrypt the frame.

Radu P.

Radu Pirea (NXP OSS) (7):
  net: macsec: move sci_to_cpu to macsec header
  net: macsec: documentation for macsec_context and macsec_ops
  net: macsec: revert the MAC address if mdo_upd_secy fails
  net: macsec: introduce mdo_insert_tx_tag
  net: phy: nxp-c45-tja11xx: add MACsec support
  net: phy: nxp-c45-tja11xx: add MACsec statistics
  net: phy: nxp-c45-tja11xx: implement mdo_insert_tx_tag

 MAINTAINERS                              |    2 +-
 drivers/net/macsec.c                     |  144 +-
 drivers/net/netdevsim/macsec.c           |    5 -
 drivers/net/phy/Kconfig                  |    2 +-
 drivers/net/phy/Makefile                 |    6 +-
 drivers/net/phy/nxp-c45-tja11xx-macsec.c | 1724 ++++++++++++++++++++++
 drivers/net/phy/nxp-c45-tja11xx.c        |   77 +-
 drivers/net/phy/nxp-c45-tja11xx.h        |   62 +
 include/net/macsec.h                     |   54 +
 9 files changed, 2028 insertions(+), 48 deletions(-)
 create mode 100644 drivers/net/phy/nxp-c45-tja11xx-macsec.c
 create mode 100644 drivers/net/phy/nxp-c45-tja11xx.h

-- 
2.34.1

