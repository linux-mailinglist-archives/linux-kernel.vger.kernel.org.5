Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5BFD7567EC
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 17:28:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231315AbjGQP2d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 11:28:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232286AbjGQP2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 11:28:01 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2040.outbound.protection.outlook.com [40.107.20.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC3022699;
        Mon, 17 Jul 2023 08:27:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xz7lrLr/t8ev1UDtvTFrc4zvRfgAllEo6iEaBdCfD8A8OSul+emUnmFrAucHkfpxIRDkM4XhASqnf667/h8AK0eC6ET06D1X+Lv8ZMhb5Iz68N1O+HjNe64P2fRryKcs0o8rdZ7pQR6j6tsAe48CQtXR1wWiwj5QfGVN1U150h4Sr8gM/mcQ1I4Ga39k/MMxbDMVt6EI84QguCkr3vNw5LWHwy7D0JnT+QTVwMFhTqnEmR/cmK5hl25EGBHtwf9kKH6JB2i7qz0jS5keUR4v2al492QuJIdcTRETqWbFwqR+dAuHSx9uLyCIzoX13MjduThiAsfXrgNqIfLwsk3PrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g2Se2pQxcNMhA0FJ2uTjagYf/L5wMgw7IYmnuLV6n2M=;
 b=adZ4QiKeyxKqoNwBTqvRYm/UUGvn0fG+GhY+qta0+G7lU6EALDzo+Hch5VM1LK1IMzmu/9JtNFI5Tc1JmQOUDrXR2msmavSooQwKIm+oOhjDXGz72Fs2wo69RooXcSOEy2N9c/Q0rAZwuGKTXbsxR/DRISYKd+ytj1xbdKO3buYWdy4q7hCL6LqaCegHAMYgaehaescEMWZ9ppytw0Ba3kJp2UJUxWxj3MItG8klLsQaAwU/GwE+KGW3536p6YNL22VzV3IhrKso/5kAYWZJHWXWWZhulM4JlN16wwp0qiv2kvejSIc+DPxRdKmiXRKyfJc5c9/PS8e1R348HFDdAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g2Se2pQxcNMhA0FJ2uTjagYf/L5wMgw7IYmnuLV6n2M=;
 b=DS+n1zP1mMgebU8nAyhdQkbYPdJ4nmXeCkE61uQ1wO862ti6/lPx/a5IPhcmM1WSYpIXE0EmSwRUrLbNJ49xFt/VoIV1EKS2Snlbl14xldZJZBzYaRQWho0bORqOjnoKvjtjn9hLEvt5kUUdraaNMuZcF2TkxcaVf7Aaw8zQkwQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by VE1PR04MB7245.eurprd04.prod.outlook.com (2603:10a6:800:1b1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Mon, 17 Jul
 2023 15:27:22 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::c680:1128:9d53:24ae]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::c680:1128:9d53:24ae%4]) with mapi id 15.20.6588.031; Mon, 17 Jul 2023
 15:27:22 +0000
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
        Michal Kubecek <mkubecek@suse.cz>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v8 net-next 00/12] Introduce ndo_hwtstamp_get() and ndo_hwtstamp_set()
Date:   Mon, 17 Jul 2023 18:26:57 +0300
Message-Id: <20230717152709.574773-1-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VE1PR03CA0035.eurprd03.prod.outlook.com
 (2603:10a6:803:118::24) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|VE1PR04MB7245:EE_
X-MS-Office365-Filtering-Correlation-Id: f9654a85-fba2-4198-3b04-08db86da5115
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1zqdtDKxRM6ynKZVRPOh+ClIc4Ke2FvSK0Kmy736GCVTzrM6QzN9J9yVfs7+FnQbF1Xfyckv9UKx92Jwkly8nbhfMYdXTWlp9UdNYtrk5I8w91+WcPnG2eqwUFYjVbKg3O1N35B/xiy9ylHaelZ46j0pjp0zPK3LwRoNhBGxQL6PnVg9Jv3MQccCq9yENI+bCDb6IOrIaQJGjdMyW/SwryDfqr2din9gUMUBEzHvjASg33l03czUxkEdlrW7hcVws4xiqe/tb8LhSkB7CzCQj6H3KjX0uQCy9MxtxArIxcKnQviw41J+3nyZYtdRYVqKYCTL46bMl3G5ksp7MDvskmLfwPws34UEgB4LRlFPz6TjtwrYgkehwSHK7SRNcneN21OgZGeuHXT4RX5BEZ/iXVlrSbAGrCywXFNBbqON1TwmEAo3iY/SOKvnJGtAgezN9p/sbkvH8UI8hKO/YGEQtd36Zt+XfC/FymE9ynNW599sxVeGf8zIuaQltuWOKpYvXsnBZ3/16d3eXnKg69uo/WqmpFBztzXQ9F4HwOsnIQTfTNJfaVtvP6H2a9Km2SG6jrJY5WyHEmEUWE/OPEI1+D4X+LTvyEtCwlZ0JpP69q0MGcrMRQvSFMNefhzbS2Ut71Mx9rO2INSjoch2pXs+1w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(376002)(136003)(39860400002)(346002)(396003)(451199021)(2906002)(38100700002)(86362001)(6512007)(66574015)(83380400001)(2616005)(1076003)(186003)(26005)(6506007)(966005)(38350700002)(5660300002)(36756003)(8676002)(8936002)(7416002)(44832011)(7406005)(66556008)(478600001)(6486002)(54906003)(52116002)(6666004)(316002)(41300700001)(66476007)(6916009)(4326008)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZXhjZWphMHJnc1JwQnl3dld4WkRFY3JHc3dZKzZlN1dZL0xXQjNqZThzdnZv?=
 =?utf-8?B?T28zdWxadVVzT25PYW1tOFZrUXBXK2FZZHdaWm5LUGZuU3VRSFNYTkpmME1N?=
 =?utf-8?B?cURCQmk3cWJyRzJneEE2b0c5WnpGZHFObVNkM0d5SE1YYndIcGw4endPT1BD?=
 =?utf-8?B?MVR0RmFkTG9qdXQvUVgxRWJVSGUrVXIyeEJhcFZYNVBMeCtDcVcwbkFXSUpZ?=
 =?utf-8?B?RGpTNzRVclhWYlZsSzgzK1ljd0ViNCs0eS9zRGtvc0ZycndtQkZsTVJ3bTVQ?=
 =?utf-8?B?cEwwY2w0emp0ckJSc1NmT2NCOXJ5V3hnQ2k0Uy92L2s1QVNGZEVlbUtDVlUv?=
 =?utf-8?B?RHhuNVhtOHlIOVBtck5QelhSU0VPeEcySWJoWEF2WEdXaVN4TXhSQWpMeGFR?=
 =?utf-8?B?dzVvUExPOVFOQnRleWl1dUJkVTZZZE9lQzNsL0duOFRCR21PR0ZoMitUdHlO?=
 =?utf-8?B?VmRwTUhUcmRIYk9pd2pxbWo2SjhrWUt3eXVNU0hpSTNyVE51bHdJZnQvMms5?=
 =?utf-8?B?M0wvOVJWQi9zVFBhUFJDdjgvUC9kUmp5UDNadllIRzFrUVR6RVk5cTFPRVRz?=
 =?utf-8?B?enBUOWxVbU9Zc2IyZW5EY21vVkY3RkllQVM2TC9yZlBaVHFiamFiUUdOTTds?=
 =?utf-8?B?b2NXelZidmZTczQ0Vy9rcE1PN1gybkc3OXRpa2pFeHRVM2R6Wm5LUEVjTjRj?=
 =?utf-8?B?Njd5MTJlUWFMUFRDTlNVOG90MU9UZGV1UWM2clpYbG1JYjFqbXNQRTRYc2k4?=
 =?utf-8?B?UFRZN3lHOGdRV3ROU2lWM21oLzkvcFVRSnN6OURtcDhqamlWMUNVN3NuQi9z?=
 =?utf-8?B?ZFZJeThDZFEwSFR2a3NWamZDMUZtSlEzWWw3N2FBcFJZbG03Q245UGkzYVZj?=
 =?utf-8?B?bmZYYWdHKzd3bkxwTlptOUdVT1RQY3hkMlIwMDBFaUpZUzBVRFh4OWZoOVp6?=
 =?utf-8?B?bjVvbEg0YTdrWnZRWnlaRUloZFQxV0szWVhaZG4xN3MwMFpKQkxDTzErYTcr?=
 =?utf-8?B?SFR4aUJkYUg3MC94REwwZVFjQ3pLVlZDdlRvbzdHcTNBd3BXUEJEM0dlU1RY?=
 =?utf-8?B?VmtFRmgrUUpJVTNxSUlLdy9lTGZKNGE2d2ZaM1o2RFY2d1dqU0dSTEtSNjBC?=
 =?utf-8?B?RnBTT1d6aXZBYUN0MGl1d3hrY2lWOXZHSnZXaDdjSUtYODIzUzhwSDJoRnZT?=
 =?utf-8?B?aVpZUURnMS9IR0UwWEtJS0dZWFdJdVNrQnQzNW1kNHkrUlZoV2YwSUwwYUti?=
 =?utf-8?B?Q2xuQklkVVBxZU90bit1WnZNUjdVNzdydFBwcm9mKzh5dzRXK3ZDdVBrUWZk?=
 =?utf-8?B?T0dHM3VqZ3QrZkNnQXdKQjlaNE1LVHdsM2lvUmtKdzlhS3Rqd1o3VFJrQUZ0?=
 =?utf-8?B?NjBsN1c2N1l2Mlk2eFNYVi9GUzArNS9hRUhhRk96YXZ3clVxM0cwbVE0ZEpU?=
 =?utf-8?B?UXR2SmVsZVN1RG5GOUl0dGhUUzlsTjFXQXFEWmtncUl3bXM1OW1PUStxUFF6?=
 =?utf-8?B?QVJ0R252SVFBK2Y1VGU3bm5NNHNqbUgvRFhyQnYxZnAzV0JxRVIyTzBUdXV1?=
 =?utf-8?B?VTdJV2VidVJ6V29MVGZqcFBacGhOa0xkMlcvRWxBb0l3dFpSNC9mU3dIMmxP?=
 =?utf-8?B?ampBczZZdjFLSUNQQ2JLRHNLTi9aQzR2NVgyTzBGOVYyYnZCKzFmcVQyTDI1?=
 =?utf-8?B?MXczNlcweUwwL05OeFNINXE3ZitEQ2tCVmhGa3hPdHU2YVZ3WmRmTUpOalBy?=
 =?utf-8?B?bFZvOTdiUmpqQkNVVVRnYUo5OEJ5bFAyQkZUZXBpcFpvN1c0VG5QZFFWVUU2?=
 =?utf-8?B?MnlWdzBhaTBodys3MzRJOU1hbGpZN2duZk14L3piek1GOFJaMEZha1IyLzRV?=
 =?utf-8?B?VEVaRFJyTXpFSjFHOHo2T1p1OHhvNFB5enozTjMwTG5vVng4MU5FZVJwWlNL?=
 =?utf-8?B?Z3pvWEFFOXkwTE1Ea2pralhJUWU2WTA4by9xVjh3endKOU4vejVpbHB2a3Vy?=
 =?utf-8?B?ZGpqVFVUTjFmaFJlR3laanhYT2RiaFl5K2trZmpGMHpiT0hkelJpeG1Jb2Vv?=
 =?utf-8?B?aTY1K251Q1VoRUZSdExka2RJMGFiVTRWcmN0UUhyQ2xhcThSSUlJMDUwQXBY?=
 =?utf-8?B?eHBKSVU3QTN2TFJxUWY0a1Y4WVhXR01DVVVvU2VwbHhoRm9LREVmSFA5UVAz?=
 =?utf-8?B?OWc9PQ==?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9654a85-fba2-4198-3b04-08db86da5115
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2023 15:27:22.6351
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qtrNZEPDSpt9SqLgmRNoh9HJX31em1yx8/ZU2h11bSUTW7Lpa6mdgvl8c0x+7yU4nxPToQ5VSiTBoKnZ/KO1Ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7245
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

Vladimir Oltean (7):
  net: fec: convert to ndo_hwtstamp_get() and ndo_hwtstamp_set()
  net: fec: delete fec_ptp_disable_hwts()
  net: sparx5: convert to ndo_hwtstamp_get() and ndo_hwtstamp_set()
  net: lan966x: convert to ndo_hwtstamp_get() and ndo_hwtstamp_set()
  net: transfer rtnl_lock() requirement from
    ethtool_set_ethtool_phy_ops() to caller
  net: phy: provide phylib stubs for hardware timestamping operations
  net: remove phy_has_hwtstamp() -> phy_mii_ioctl() decision from
    converted drivers

 drivers/net/bonding/bond_main.c               | 105 ++++++----
 drivers/net/ethernet/freescale/fec.h          |   6 +-
 drivers/net/ethernet/freescale/fec_main.c     |  56 +++---
 drivers/net/ethernet/freescale/fec_ptp.c      |  43 ++--
 .../ethernet/microchip/lan966x/lan966x_main.c |  58 +++---
 .../ethernet/microchip/lan966x/lan966x_main.h |  12 +-
 .../ethernet/microchip/lan966x/lan966x_ptp.c  |  34 ++--
 .../ethernet/microchip/sparx5/sparx5_main.h   |   9 +-
 .../ethernet/microchip/sparx5/sparx5_netdev.c |  35 ++--
 .../ethernet/microchip/sparx5/sparx5_ptp.c    |  24 ++-
 drivers/net/macvlan.c                         |  34 ++--
 drivers/net/phy/Makefile                      |   2 +
 drivers/net/phy/phy.c                         |  34 ++++
 drivers/net/phy/phy_device.c                  |  26 ++-
 include/linux/net_tstamp.h                    |  30 +++
 include/linux/netdevice.h                     |  25 +++
 include/linux/phy.h                           |   7 +
 net/8021q/vlan_dev.c                          |  27 ++-
 net/core/dev_ioctl.c                          | 184 +++++++++++++++++-
 net/ethtool/common.c                          |   3 +-
 20 files changed, 544 insertions(+), 210 deletions(-)

-- 
2.34.1

