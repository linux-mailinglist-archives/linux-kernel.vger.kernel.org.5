Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A8E876B768
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 16:29:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234675AbjHAO3a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 10:29:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232909AbjHAO31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 10:29:27 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2066.outbound.protection.outlook.com [40.107.20.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A9B8E9;
        Tue,  1 Aug 2023 07:29:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EeH3gfvCIzSB6c821hzUF0BTM0uNt53MbxIWMXm7biKJKf9qLrHGakNALa4x8IXYySzHTN3gaV70723CVOoSe1hdFCPPGfAqu/3KBmvVxyVgIkuPFfRsyBmFVcmP0KYbJdafmnjGz8OKo79+ZmHhQHpgw23JCB4QV+Wznc8wCn3xKqWo9DISLvst91c9Npk7/fp2vKjlGf4h0O22tqUqZ6js7Xl+o1hleMAkvlo5e+yOiM3ts6/otsz4WS0cNI3OHtd1LiiliclJA8lFzdNWbF6EB59u4Li3dscNmjKWPp7+czocgaqnEQL9tBdXOylT013Q4tGrjDSLQ6f8wnGyuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N7CaCgW++x2o1ikUVe9VmdwmQ+wB1Lh+l4tNTTufkIM=;
 b=kZED/gAppBmhqVZ1Vo8f/yzO+VCcZ2bNMeOz3Mfmzzq7p0SsKgzL+mwvWfB/o9xLN2n8rpllVsUS3pviFpHyJgQxUiELk+8SnBSlWyCtNJCPFwUfmak6o9jqkbsAVamUu0S0+5x+FPkZEITadncxZzlTYuYZ9IUbowzeImr7JVa7E3+Up26pNoOZIs9mXJX1uLmoFRreUf9muzMds3GGLA/CG4mlDHhLbdKmh7R1lGKqiQR1P51e1dfPzrSDABLE24NXG0X1hZlbR7TgrII0aLBbQB0cA3TPv35BmB7U6erlLZtvXNcnsXJF4F/yW9eStqZYVhTeO93ODCnUuw9yIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N7CaCgW++x2o1ikUVe9VmdwmQ+wB1Lh+l4tNTTufkIM=;
 b=ZMUQzCk+dqBiPgnarC0uUs+qd0IR0W2APYLC5gZAgEuuJi/rg6zSnJp3OHrwZXwyJVxPPqgnNrUZjYrWE6oLjyQmY1q+bZvgYU+VvR/QWE66c6cXkgQUX4TmFekrmKwKq9ZOMunNnImxF/ChtP+DZ6KN3QNfH3byug/oaFUF/Bk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by VI1PR04MB10028.eurprd04.prod.outlook.com (2603:10a6:800:1db::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.43; Tue, 1 Aug
 2023 14:29:22 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::6074:afac:3fae:6194]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::6074:afac:3fae:6194%4]) with mapi id 15.20.6631.043; Tue, 1 Aug 2023
 14:29:22 +0000
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
Subject: [PATCH v9 net-next 00/12] Introduce ndo_hwtstamp_get() and ndo_hwtstamp_set()
Date:   Tue,  1 Aug 2023 17:28:12 +0300
Message-Id: <20230801142824.1772134-1-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR04CA0027.eurprd04.prod.outlook.com
 (2603:10a6:208:122::40) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|VI1PR04MB10028:EE_
X-MS-Office365-Filtering-Correlation-Id: e5a4e6f7-42ba-4423-3372-08db929bb2bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2EaQuigIV7pbzNfMAIIpF1x/OjxUtwuhDGJ+46gi/A1FqVJAfEXiCevlXp1pamqdDXfYNFOiKPWatWqD/SEw3nfDhURkkpq4BJFV79GHIKEMKgYOS+j+7N0F/MYu3+Rv1fCuquzKkFSbKuLQvyMN1HxMcG9nJJU8PAMXg17ao0d4P6Q5LAw6L60bPmh4HQVboxPz20vZqiwKvq90pY0NaWNWZK4a00jtFCGriaaegjM0Q0/nrlPePtPC8gHQDHI1ncGazIkslqjPmQEWufQuNoxvlZ/Llx+P36OLehNEXHg18TlgKOA8UGZVt/nKpguSWB2XN1QWxCIbXbuO5MMmmtLdf8Hlfj4YYr9JhKHC772zkebni7mA5Ybta2ZNqqo3Bs+cMLeWy3CNxtWfx6DqMijogeQPUbDogeCNBhGYPBtQGXSbhtB9YpyCKutF1Us6DUBqeI4UJI76xzVvAPjAPhm8p1FP0TnZ5tyzWRZk6gmPKLp0xT3Hj5KV3HTq3GKNzeuSD/wjydCP+x3hOp5ld6FbJP8N7LLEk1rhUfVNPjZGmFeVh0oznNWM1VpBNw9yReWpSPIfLcdDovGHdcNAJBRrVwG1KRFHTNIp01nhtrf1oypatYRGEJt43AQk84Vc2nI3jr6f45RD/e7cKKc0KA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(376002)(346002)(39860400002)(396003)(451199021)(66476007)(66946007)(6916009)(66556008)(2906002)(4326008)(44832011)(5660300002)(7406005)(54906003)(41300700001)(316002)(7416002)(2616005)(52116002)(6486002)(6666004)(26005)(8936002)(6506007)(1076003)(8676002)(186003)(66574015)(83380400001)(478600001)(36756003)(38100700002)(38350700002)(6512007)(86362001)(966005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QVdCT2ltclJJVXRzK1hWUkpZdlE1ZFFuTnJ6K2dXY1lacXQ5SU91cGcwdm5Y?=
 =?utf-8?B?Umg4OFpoQUVZbHNnNTZjb3ZzL1AyblVyZXQ2RGNpSlA5ei9MU0RHVktSWTdx?=
 =?utf-8?B?MjJIWFJvY29Kb3ZwMnhlcHpzbXdySGJQekdzWXFvclNUbXZRemVuL2dvMzdo?=
 =?utf-8?B?WnlpczRBU1hsSzdVZzAyYkk0cndnWDBqQzh1dkRna3VYUFJxVnk0Z0EyVElO?=
 =?utf-8?B?ZktETkJuUUpWRzVPODJGdWhYbGJlandsdEZpZzhTZ0hkZjRPcWpLVjE1eGMx?=
 =?utf-8?B?TXlNOEJRTXZ6NVExTjdzaXAzN0RaVkZJUTQ1bVdGWFNnMUxvM3Y2QXdnVzc3?=
 =?utf-8?B?TkhNaFFERUY0M0d2K3U2VmtTaUtONTI0S3djQmhBSEJ3bXJreU5qOUp0WFdM?=
 =?utf-8?B?NDRwYWVDV0crNTgyeXkrSlNsUlg2Ly90UVpITWd1WCs2a0M3WTBqZUpjaXE2?=
 =?utf-8?B?ZXprR0hPMWhVK3Z6NUlRWUtUNk5MOHFpekFkWi9TZExqSEVrd09FM0tTUVVh?=
 =?utf-8?B?RUdwYWQydWNoNGRJSWoxOGFCZXJXZm1wMmlsZVE1V1c4MTVCYm1xZGEwSmVJ?=
 =?utf-8?B?YmRNcDVOLzhSS1MydVNXZ21nUUVaWjlCbmY4WFJCRm5iQWRJUzkzb1hHZG1q?=
 =?utf-8?B?em5jcmdIUUNPYTRFQzZGam45UE5tbWRuK2VtbUNhUitaVjdNQ2ZLK09EczBG?=
 =?utf-8?B?SzNGRy9LN3llL1ptajdvK0toREJ6Q2lNZ0RIWFhUb2ltQWt5THpXd0x1V3BV?=
 =?utf-8?B?OEplUkluSWFFVWlwS1kvVmNWTnZ3WVZSOE1iNWFJWmQzbTkwL2pDSFpHN0NS?=
 =?utf-8?B?UmtRMERpYS9OQnJveWtTMEpHTDVvcFBOZFNjZ1FCcGd1U1dkenMvOXBFNkRx?=
 =?utf-8?B?V2ROT21IZTNDUEsrWTkvMVNqY3V4YTZJREpmckdPdkRrMlluQlFJNnY1d3hh?=
 =?utf-8?B?cnB5OEEvUFNIWmJjMTRBcktBWVJTYWJMTVZMSXZnTC8xcmUzRG5VZzRscHlV?=
 =?utf-8?B?cjRvZmxrSHZtNTZYQ1F5ZDd0MDhralBHN2xlN2xSd3lQQTJjSVlKUnhrVXBH?=
 =?utf-8?B?WW5rR3RucGJQaytYaXBHbTgvWkR4S2x3a1dESFdrN3FCTk10K01STldBVFVt?=
 =?utf-8?B?KzhLVDJxaW1YYlB0SDZ1YjVBK2RkV3FoZW1vSk9aeVZqL01KVmVLTnZ3Q3ho?=
 =?utf-8?B?QWVCMEVXWm5zaEV6NkI5Sm9MbjkwSmVpTGFqaG1NOTNyMUY5b3RWZFg5dTB4?=
 =?utf-8?B?VlBMckVEeU1obUlhM3FIVVIveTFoVi9MaTZYTFZibHVCS1FuUGVSSjcyKzVv?=
 =?utf-8?B?N0N5aGhiRVIwNXFxVERiamZEcUp5OFV3dTRLNTE2SGNUU05zRmk0QWxodmFl?=
 =?utf-8?B?T3l0Qk9POWR2OHNYMDhlbllYcjBFOEx1Vm5QQTR5eFhieEJ5L1NtZnYwRmY3?=
 =?utf-8?B?TzdzV1pVejRITGtZZFYwbmZmQ2xFL21xNHZNTjFDcWx6bGFqUTI3aDIwemIy?=
 =?utf-8?B?V1FsaFhQbmtqb3JVa2hBN1VQN3BHWEFCZnc4WkhpQ1RuSk5zdTVWOWVnSTdt?=
 =?utf-8?B?L1RpOU02Z2d6RWJjODRCdlhDMHVsRjg0YUl2MklwbDR1U2IrS2VRbDYxaDhv?=
 =?utf-8?B?UHJhVmVuSXlWRGRvcGRCc3oreHlZRm4wcDlNeU83bXFIVC9oWVVIVm9ZUG5j?=
 =?utf-8?B?bHdGSVlHMlJkOVV2Sk83Zkx6TmplTThhN2NoY0JjNks0bDlyWWllZHM2N0tZ?=
 =?utf-8?B?MUpKRHF2R09aQm8vUXhMT2llclFHaW12VDN5Rld5NUF0Yy9semp6dU5Hb2I4?=
 =?utf-8?B?Z1JYN3RhUWpPR2pXN3VVTi9vRGZiMVh5VmZmS0NmSUlEMEg4aXNCYkdyYjV2?=
 =?utf-8?B?UGZ3YXkzSHlTenN4YTNqUDVkSTFSaUJsMXlKaDhTTnlMNUczK092S3BwOThG?=
 =?utf-8?B?d3NLNThNWUhIVmgxZ2FrV2YrWU1CZ083Mzh0TktoM3BacVR2ZWdobmR0dTQ4?=
 =?utf-8?B?Lzh5QWYzS3FCeXp2YjZjMEVmWDJMT1pUd2Y4VXd2dFEvZU0vcWhrYjd4Zklu?=
 =?utf-8?B?SkhNRkdFSjVrZ296VnpTdFpscEhQelhCeDJsZjFyMWZjQVhLV285Q055Mmpv?=
 =?utf-8?B?eXd6eVZwQXZLWmpabnR5UkVSdmFoWWNPNUZ2bmdRb3M4c2JCTk9jdUdEOWIw?=
 =?utf-8?B?WXc9PQ==?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5a4e6f7-42ba-4423-3372-08db929bb2bf
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2023 14:29:22.1452
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gbnhoR0PHW6kruJ74pM2/BjQe6+apQIXPr3dzTB9YBeYOyIWmXx9d0LEOkFcoh1EKzWMfHPiqo0Jdz2iaEgmvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB10028
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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

https://github.com/vladimiroltean/linux/commits/ndo-hwtstamp-v9

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

 MAINTAINERS                                   |   1 +
 drivers/net/bonding/bond_main.c               | 105 ++++++----
 drivers/net/ethernet/freescale/fec.h          |   6 +-
 drivers/net/ethernet/freescale/fec_main.c     |  62 +++---
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
 drivers/net/phy/phy_device.c                  |  26 +++
 drivers/net/phy/stubs.c                       |  10 +
 include/linux/net_tstamp.h                    |  30 +++
 include/linux/netdevice.h                     |  25 +++
 include/linux/phy.h                           |   7 +
 include/linux/phylib_stubs.h                  |  68 +++++++
 net/8021q/vlan_dev.c                          |  27 ++-
 net/core/dev_ioctl.c                          | 184 +++++++++++++++++-
 net/ethtool/common.c                          |   3 +-
 23 files changed, 630 insertions(+), 209 deletions(-)
 create mode 100644 drivers/net/phy/stubs.c
 create mode 100644 include/linux/phylib_stubs.h

-- 
2.34.1

