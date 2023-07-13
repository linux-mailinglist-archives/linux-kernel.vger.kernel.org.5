Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A789752116
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 14:19:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234668AbjGMMTo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 08:19:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234663AbjGMMTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 08:19:38 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2075.outbound.protection.outlook.com [40.107.14.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1A302706;
        Thu, 13 Jul 2023 05:19:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ROCa0DarMt3sv8UUjrTGWWrTN1olq0X6150GwQiKsn0RpMpo4l2UR9OQtZfqt6iARsgFXsWsX/7uwSf7YjqDThI+mLOVmGdqhv9rh6GSUQ3Am2ahzXoLjSb1meiTdoy+p27XboeIDxlMaW1ndjDXFSxZlOPJrhnF9bHcqKpw481TF+M+j06rxLcWCOK71iq1gRAJXhO4dRkDLFotpr1WWyiFxWPmkL/cS98R7WNWTOGcIQMhIhgKN5SoD0Gk2uczJzxU204JEq0IV6+NyQDWt3V/7St6vvAGaPOK9fa0d6kKmLrfRix2ugRsvWWw1Aw98nvb20BQLAxP5FNu+kd0QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eIdP5O4JigGuuPyoOYxAGk4KKsGKBGJHukSXxI6GkxU=;
 b=FrfTDi6vNS0ieTAPg2938HmiqkAIC5r074RdEkORDNy6Zuv662eixtI8T3GYljRyATPREiXXIci3Y15M3+FmLo24EzJWZBT0kzGwBXCFr8YE2rNFswZtIPpZzTJQb/JK5kgNA0KTZ5CLN4/dFNfZ7xNK/NmQNMdbWXOh/w7ZYYZ4R20Ps/Dy4j3l/UvnZHfwGC0OH+l9Uc9Em1naq0oILztAFv0vT0ZJAsKbBxWFV1BFjK0X6V+o5K0CzFiRqDbmpB171jYJoQ4q1khJQq83LDMgbfPM+y6IccScBaBhnkRLn/JJClgQwGwmq2ab+tPZWWptfWrPM1c62NPTbCPvtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eIdP5O4JigGuuPyoOYxAGk4KKsGKBGJHukSXxI6GkxU=;
 b=E80aB2ROItEkpLtShuNr1VNcRmd/ZA92cKj2pU806ijNVKw3GlUcAdzRlxOr7QWXaaly1MzjGUOki9gK4UfxAPeDss6iYZvUhqx3HQpgscT5dIHDEsa+rq2vcpRCuOMM+xY9TcHZZXxXQFvDsZk0GSdNQYEpm3ceAaIN++KaNfM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by DB8PR04MB6971.eurprd04.prod.outlook.com (2603:10a6:10:113::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.24; Thu, 13 Jul
 2023 12:19:30 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::cc2a:5d80:9dbd:d850]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::cc2a:5d80:9dbd:d850%7]) with mapi id 15.20.6588.017; Thu, 13 Jul 2023
 12:19:29 +0000
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     netdev@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Maxim Georgiev <glipus@gmail.com>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        =?UTF-8?q?K=C3=B6ry=20Maincent?= <kory.maincent@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Vadim Fedorenko <vadim.fedorenko@linux.dev>,
        Gerhard Engleder <gerhard@engleder-embedded.com>,
        Hangbin Liu <liuhangbin@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Jay Vosburgh <j.vosburgh@gmail.com>,
        Andy Gospodarek <andy@greyhouse.net>,
        Wei Fang <wei.fang@nxp.com>,
        Shenwei Wang <shenwei.wang@nxp.com>,
        Clark Wang <xiaoning.wang@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        UNGLinuxDriver@microchip.com,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Steen Hegelund <Steen.Hegelund@microchip.com>,
        Daniel Machon <daniel.machon@microchip.com>,
        Simon Horman <simon.horman@corigine.com>,
        Casper Andersson <casper.casan@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7 net-next 00/10] Introduce ndo_hwtstamp_get() and ndo_hwtstamp_set()
Date:   Thu, 13 Jul 2023 15:18:57 +0300
Message-Id: <20230713121907.3249291-1-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0157.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:99::18) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|DB8PR04MB6971:EE_
X-MS-Office365-Filtering-Correlation-Id: dce14071-d807-4a0b-6cd7-08db839b6864
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Wws0bIpOCWnvsCbRydkhqJFRSgUqbJMzVBVOqybZDvJBrEiPUwYA7cpthEJddp50ncQH8DI29FDvjiTj3aQ/JraXx121e9rtrr9jpL9E8Wb/INYPuBQJPFw/puDLKJ7ew5gsGFjCPFi7HOcWXCeREvYo/H7dTuAmZnZBy5vU1vmR/7DF67+/vF2Seie4oaNdqHI4vT/W9xOAze5mEd5pgVzdRvFR7seV8TcdXnYFDtV9APSQ4mJFGcupyaLazD74wkkkyJLrfNiQT800fsMEUE+zo9iYBlUpdbXafEhmoPa2xjnQvqr6QGcYP8SsFYeZTWfvhz5ZRieA/9BxCcqiNLejslvDJZo6x72/ZUDtawdw49PjC+MLU1o/LEdFVlrLfY2FVZqQeAjRLqsHW2LxIwA/S0Emg181FpgEBqvHV4xb+gzdf6rMm6D9giwQH3rfIp6UJWEBA4diByUp21CTovdr2fYixA6Y0/UArH89fCDSLO82algpTET2VUhm+X56Spajr1+uD5BiIAvWWS7cAJCRq/G0vNSnjfAXv6i3YMZr//MAyVoAAP6yxxsShJ3dtewScss107OZ7dZ97Ikqxcb5LP2nTkQfcHVWCyvDSXgEydtMMvV2NwFEohWpGVasgItj1f5c126narrrZT8pDw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(136003)(366004)(39860400002)(376002)(451199021)(54906003)(316002)(6666004)(52116002)(186003)(66946007)(6916009)(4326008)(6486002)(66556008)(66476007)(478600001)(966005)(41300700001)(6512007)(8676002)(8936002)(7416002)(86362001)(1076003)(6506007)(26005)(5660300002)(44832011)(83380400001)(2616005)(36756003)(66574015)(2906002)(38350700002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S0xxZm9SbmJpdmVNNmduRlNTcVh6bk55WkxqaGo2SDhYMDZpaGhXT0pOSDBE?=
 =?utf-8?B?VEp2aW1pVW9tTFZKUDBveThjenlyY3V1cjNaRldrTU12dDNTREtJV3VqdHBJ?=
 =?utf-8?B?VDZ2dWNsNlNIdHUrdDV6TFV6dVY1VTVuMXo0MEo5dk1paGtzT1d1ZDlncklP?=
 =?utf-8?B?cXZSdWpXYnZQTEg0RDVrQWJBY3pHYk1nNHhUTTFiQndYdTZpTnNmV0NqNnVM?=
 =?utf-8?B?T1BGemNyVy83UWxvZDUyNE1ZeFhjcGlVdnlkZm5JREYrajR6UVF1Y2FHMndB?=
 =?utf-8?B?RitNYXdKVTF4aUpwcmlnOEJsUm9JVTdNa3prbjFzbDRqOTBKVS9Fam9lZlNh?=
 =?utf-8?B?S3QrZk1MQko2WDlkUFVPWlE4S0oxdENjakY2WHZGak5PZHBycGFjMURrdVAx?=
 =?utf-8?B?RDlHdWJMdllJdGtyM3JpaFZKYjBJdXhMQm10anVGUjlhVjZTblRZSThxVVJR?=
 =?utf-8?B?b0pJVHY3blNTVDFrL2NYZVkrYjgwelpmbkJWSFVGWHpCcUNtbVNYdkw2eGlE?=
 =?utf-8?B?ZU5yWGg3c2l1SVVTSjlCUURnTWdTSXpud1pDcUJUL2U4NUFZTlUzZmxqaWJk?=
 =?utf-8?B?UmZjY1hQUWc4aFdNTU0waGVaaGhra3ZXK0Roa1U1RzVoNXZUazFMVmwrbTND?=
 =?utf-8?B?RnlTeldGdjJZeUNySHNSSVlna0RlNWdRcFJyczJ3NFFnQmYvQ0hGL3QyYlo0?=
 =?utf-8?B?UEdMNDNpTG5qeE1SUmF5L1cyN2FQcDVURjJxdkdSalVmNXFEL0VHaFgvbWRm?=
 =?utf-8?B?MVBvK2w4Z2xsUkZFZm9qQ0tDcVJBMC9tQitUbjI4UmF1eVhEUWdhM09HOCt6?=
 =?utf-8?B?MStyN1FKNzVlQXJDcWhLcms1cjZVZVY0UEwwM04rVkxjcjVyNmdtODRITCtH?=
 =?utf-8?B?ajRzZHVjckpGcEF2Yk1uNGtUWXA2SXZkSVJ1dzJzTGlaeUM4c1BvL1gySTJp?=
 =?utf-8?B?M3hiYmVMOGNCRm1ldkg3cVYvcGs3MzlzZ2FSYzVMbjltVjlBdGlUVldTL05k?=
 =?utf-8?B?aHNnaHpzWTJnRFBDZlprMnBySms4YXlhMjFBVGFiTUsyWitjRW02YWM2amJx?=
 =?utf-8?B?c05ROHkyUExwQ21iMCtrdXNlbXR1cENnd3BBZndDeTBveitQQVh6TktMcThL?=
 =?utf-8?B?a3dLd3JIMFkzcFI2NEc0dTBKZ2YwVDhPd1VGcStqYWwzYnFPQ1NJR3dNKzVR?=
 =?utf-8?B?SWpKdDMwejVPZzgycVRzTHlYT3VFcjJNZlZwTmxObkE5Mng5NzRpaE83SkFD?=
 =?utf-8?B?UytuWU16eWxNYXgxeHFERGpFbWxaMWFWaml1OGFQbWorRkg2b2czWHNXOS9N?=
 =?utf-8?B?TzUydUt5UkFnajZTRWRQczA5eTFqdzBnRmlCc0kxaHBtSFF1eW56SkNoSjhR?=
 =?utf-8?B?L3RGOG9LeDRrd2J0V3cxK05uTmptNlRLbzl5MkhJQWhZRVRsN2Ireld1bFl1?=
 =?utf-8?B?WlpVL2FYdnJJRmJ4VlFnQVI5ZG5JZlAycmQ5MnhXdXdlcTd0eFlMWWdmbXFy?=
 =?utf-8?B?aWlrM1NPdmdydXltL3NESWVGVVY5bG4xYU0vZGp1Rm1JVjI5blZUK3B6di8v?=
 =?utf-8?B?cFpDZ2pxYVVkS04vbk5HZE0wUXZKQk5veXVOVEdTYjQ5aXNHbURnSEVob1Ny?=
 =?utf-8?B?dDU0b3dFUzNpK01hbnJYeU1LR3BISTdybTZxU0JYYjBrWGhzZlp3a01MbWFY?=
 =?utf-8?B?M0hSei9sdGVxb2JDSjRxd1o0ekl6d2xjYzdmaVNlWmFWaGZid2d3NC8xQjN6?=
 =?utf-8?B?Um43bDEwQVNBS1NVK2hoVkhrczMyd0M3by9qZ1N0NklMaktRR0tYeldKZkN1?=
 =?utf-8?B?RXdSWnUyazU1SlhoTER6YmpZOGRSdzNDZzBBRGxWWjN6MTJzK3lmVXJhUUFY?=
 =?utf-8?B?NW1pMmY0SFNUVkYvaUllYnlYUExybU5EcVdPWkhWSkdqNWhYNHdZQmhLcElD?=
 =?utf-8?B?RU9sMVlpdGh6cE1vRWxIZVZtd2ZzckNGa1dLaHNReUx6RXlQc0RqTlpDS0k2?=
 =?utf-8?B?NDZ0VDRONUFpNWlHT2I5V0RDZlJJMXc2a1k1b3pyVjliaHBXMDJrZGQ4Z3Rn?=
 =?utf-8?B?WUd5VUNNMVBaSHBhWHV1N2NPZHp2dnNZUzg1UWZPTEtkUjRkMDdBdXEwSVpB?=
 =?utf-8?B?U3hEeDRDa0RMbGptWWJkWmc4aS8vT3h2cngxdVNEL3gzU2ZCVzZmU2gvaHBp?=
 =?utf-8?B?ZHc9PQ==?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dce14071-d807-4a0b-6cd7-08db839b6864
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2023 12:19:29.9316
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x4G1CqvrOFY0Ryq6u7JTpQltPRXD+kOZUCBIFEWUrxW5bCRxOBow4JTjw78AZU4TV1I2pM7pTxUqCoxx4M7hhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6971
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Based on previous RFCs from Maxim Georgiev:
https://lore.kernel.org/netdev/20230502043150.17097-1-glipus@gmail.com/

this series attempts to introduce new API for the hardware timestamping
control path (SIOCGHWTSTAMP and SIOCSHWTSTAMP handling).

I don't have any board with phylib hardware timestamping, so I would
appreciate testing (especially on lan966x, the most intricate
conversion). I was, however, able to test netdev level timestamping,
because I also have some more unsubmitted conversions in progress:

https://github.com/vladimiroltean/linux/commits/ndo-hwtstamp-v7

I hope that the concerns expressed in the comments of previous series
were addressed, and that Köry Maincent's series:
https://lore.kernel.org/netdev/20230406173308.401924-1-kory.maincent@bootlin.com/
can make progress in parallel with the conversion of the rest of drivers.

Maxim Georgiev (5):
  net: add NDOs for configuring hardware timestamping
  net: add hwtstamping helpers for stackable net devices
  net: vlan: convert to ndo_hwtstamp_get() / ndo_hwtstamp_set()
  net: macvlan: convert to ndo_hwtstamp_get() / ndo_hwtstamp_set()
  net: bonding: convert to ndo_hwtstamp_get() / ndo_hwtstamp_set()

Vladimir Oltean (5):
  net: fec: convert to ndo_hwtstamp_get() and ndo_hwtstamp_set()
  net: fec: delete fec_ptp_disable_hwts()
  net: sparx5: convert to ndo_hwtstamp_get() and ndo_hwtstamp_set()
  net: lan966x: convert to ndo_hwtstamp_get() and ndo_hwtstamp_set()
  net: remove phy_has_hwtstamp() -> phy_mii_ioctl() decision from
    converted drivers

 drivers/net/bonding/bond_main.c               | 105 ++++++----
 drivers/net/ethernet/freescale/fec.h          |   6 +-
 drivers/net/ethernet/freescale/fec_main.c     |  41 ++--
 drivers/net/ethernet/freescale/fec_ptp.c      |  43 ++--
 .../ethernet/microchip/lan966x/lan966x_main.c |  61 ++++--
 .../ethernet/microchip/lan966x/lan966x_main.h |  12 +-
 .../ethernet/microchip/lan966x/lan966x_ptp.c  |  34 ++--
 .../ethernet/microchip/sparx5/sparx5_main.h   |   9 +-
 .../ethernet/microchip/sparx5/sparx5_netdev.c |  35 +++-
 .../ethernet/microchip/sparx5/sparx5_ptp.c    |  24 ++-
 drivers/net/macvlan.c                         |  34 ++--
 include/linux/net_tstamp.h                    |  28 +++
 include/linux/netdevice.h                     |  25 +++
 net/8021q/vlan_dev.c                          |  27 ++-
 net/core/dev_ioctl.c                          | 183 +++++++++++++++++-
 15 files changed, 480 insertions(+), 187 deletions(-)

-- 
2.34.1

