Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 660EE77036E
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 16:47:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231287AbjHDOrl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 10:47:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbjHDOrj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 10:47:39 -0400
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2082.outbound.protection.outlook.com [40.107.241.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71FD646B2;
        Fri,  4 Aug 2023 07:47:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kycI4w915hlNrI26AiieVaSQRW25dNb7DAq2d35oyCjJd8hzrlpdi9U0echtNAEAGWLOuPGJiNH0TJoxLPja2C15zkdUKFckPUtSB02InNUnijm2C2JTRD0TXZdNohbx2DNvoH+g75tjpgU9jE+Y7BlVVjY4MJjLDZ3teptX26AYrW0BCKTx9zo+OYxVQ/bQjJuM5HxNtehzlIUxHpF0gCq54wanbIvHsLnsK66CAPq9ZL4wNGaUuB+n+Htf3Vjc9Bg1mfD/v5wRq5daGQ0g5QwJOSc525cwCj77Lvv1Kj2qke5mKdGAKgX9h+NGLQ2D2D4d5SThoSFMgro6x2K2vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g7PCIZr7xnTTm/OGx58lZL32KK8CrwjGpq5TlHRlB2Q=;
 b=lSFNJocEf2Ihog4b9CLlptqgE7e3Q4VIlA9pIIlpjdtzDpAb4s1yTlVG/BmMz9KETMlRCxZ0azpqbeN1tnd76eXFWOSFEiTxGxkkpBugJmImXLQO0Ftvogk6iEy9FNzXi6+Q9VLtJYcEJlG3VVsF5TaixwPrFj7dGNL9P5JbWbB2mDirx9qmJk3QG3KH6HgdwJ9E86qRP+jvl4oJenJ5BdGVEz2oKA/ekpaB/gtJkuLkb069JLJZIve6kvzG4UV8IW9v6lsWhQbSsrQG5Xe1V9O9o1YalohmiMAlo2b3uObRA68UX6gqQ+GIsF9mDCX7t4IGn72gM+otU7TQJaKujQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g7PCIZr7xnTTm/OGx58lZL32KK8CrwjGpq5TlHRlB2Q=;
 b=jgh+b5vz1A5MFE6OyoyFTXMhmAGmcWhtt3KHF/8+WqD5nKkCd8kAYWxfzcq9EzdkoD1SZlc8b/YG1cPxLYJbUodTAWjAcg8o9hR7BwjIaaxMpaRhh6X2eIhcgSFdPVUXvxSLOj1KVZm8fP/BtP2VLFg86CFpJLFBdyhHHt2iJEs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com (2603:10a6:102:231::11)
 by DB8PR04MB7164.eurprd04.prod.outlook.com (2603:10a6:10:129::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Fri, 4 Aug
 2023 14:47:33 +0000
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::d4ee:8daa:92f4:9671]) by PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::d4ee:8daa:92f4:9671%3]) with mapi id 15.20.6631.046; Fri, 4 Aug 2023
 14:47:33 +0000
From:   Shenwei Wang <shenwei.wang@nxp.com>
To:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Vinod Koul <vkoul@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>
Cc:     Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Simon Horman <simon.horman@corigine.com>,
        Andrew Halaney <ahalaney@redhat.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Shenwei Wang <shenwei.wang@nxp.com>,
        Wong Vee Khee <veekhee@apple.com>,
        Revanth Kumar Uppala <ruppala@nvidia.com>,
        Jochen Henneberg <jh@henneberg-systemdesign.com>,
        netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org, imx@lists.linux.dev
Subject: [PATCH v4 net-next 0/2] update stmmac fix_mac_speed
Date:   Fri,  4 Aug 2023 09:46:27 -0500
Message-Id: <20230804144629.358455-1-shenwei.wang@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0183.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::8) To PAXPR04MB9185.eurprd04.prod.outlook.com
 (2603:10a6:102:231::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9185:EE_|DB8PR04MB7164:EE_
X-MS-Office365-Filtering-Correlation-Id: a99dd553-c584-4e61-1e6a-08db94f9bc98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6RHEvYUpH3vQGwlKzQsn5GMhpPBxtAHnSzxV7FeVzvS6NVhpkujt3Hzz3HX202u2JGcRSo9zPDL05CGzEX2joEJYFArGchTHTDdp8z8aZs0wsYQ+0ZV3bDo/iS490/+q4SiADCCk+5SnSy/uxVHRUDN+KwwV3pHuPBis5PUdGGItBBEqpq+6XCLqS0dQqYKi5DTlndsosnlkiuXk1qoMegnbXWDwjuHM2VkkyaT6YfXXjhH91oioh9Bz2ICQA152pNqFxg+LgULYF7Fe+hN818SA2VRBLwKgbSosjHgnssjii7oExuW+xr32XRiv1At7BjHRmF3G+F1GQ9EL2fY+8p1KOwYORLRQCkIh/IPIHYrmE/44h9StVPufiCRbW6dNIbgE73zrPQLdpjuFHfb+3K9EfENEo1gjCfbrPRj1TftGneeBAWnxFHXItSCG2XvcIV67K1/SS7mQFilYZ9OGDkfF5c9FVTfKgaQcywUffuaBBMsGZz5fzGYdwKil/qfdtcvhgfbmrbvqrQznIMfKfyxjvLCtm0JZfsxqdfx6Lshvffl5u+2YUPIVw1srDMHAPzZCPHoobc2pifLC20jJUjGZL+7GLKvtL1sHBj6XdX3Jkm7evT7epfQ1s9BioMr9tObidPo/WAb77Hzxm5PP6g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9185.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(39860400002)(136003)(376002)(366004)(451199021)(1800799003)(186006)(2616005)(1076003)(83380400001)(55236004)(26005)(6506007)(8676002)(316002)(66556008)(2906002)(5660300002)(66946007)(66476007)(4326008)(44832011)(7416002)(41300700001)(8936002)(6486002)(7406005)(6512007)(6666004)(54906003)(52116002)(478600001)(110136005)(921005)(38350700002)(38100700002)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?92uk+Mj6qX4LxxSNJ70jkXJiwKb+EUAphswRKqjHe3ZFi3VdQ10fq9rTdTMc?=
 =?us-ascii?Q?mKbhobiBLyWCDVHiL/wKcH+pskYfiZwWh5aYiWZq96u5LP3iNOA4M3VtSULN?=
 =?us-ascii?Q?rb+lTp8yeBxggIxUIZSWCigqz+OEtHkq2dmaVBp4Y33Llkixj1UaZ2pMepNS?=
 =?us-ascii?Q?JNyPXOTWGIbMPhnbJeJHyIbNcQnEm7rB4n9yRF13rDziWs1X8GaL2dpEqjWc?=
 =?us-ascii?Q?zJQgrOFkQqoGJkt5PCfm84GcWx4zbrr/jOLt6mM55IpDlMkxtZMH69+z5kF9?=
 =?us-ascii?Q?jhnC0okCLetIz66q7+Hl0Cq8lNWAv3mgCqjJR7yYmoNtuAorh4drjBbl2A3g?=
 =?us-ascii?Q?kAKXnhrVrl/7RpQ9vutk4Tl81zaSiHnf0zcD+vhYRDFUefJpd2ZxkgK7VqRe?=
 =?us-ascii?Q?b2us9DIL/QU3UmRW8sHCBeCA7Hxbtx0hZAJIIfefH4pBcxeP6snNUICVzQPh?=
 =?us-ascii?Q?I9WlVdq1wSDxowVodqGdAovIF61uPAQ3CTS1jb2VlIiZXIsSklH9f55VAOo8?=
 =?us-ascii?Q?QAqYdRuYkxUmKXyA0m7G+IdAKe75Jn+JB8Ca5JJlCAXtOKviv6gCObX1MEJH?=
 =?us-ascii?Q?EjMJR8WRNbaEVqOElmp5810NFbWEp9D8A1UHABhrqBAhVQ+jgFxCNqvAARwM?=
 =?us-ascii?Q?RTT8h74h5jVhbcvMafz5VD7APtfbNb1uXgTRYoM7gsiJCaIzFxK+qkz1JVBH?=
 =?us-ascii?Q?7P2Wj7FKTpRYSezQFwTIMLiNVHiZy0IteoZm/YJZc4Bzm43GsPDpaqNl7dGC?=
 =?us-ascii?Q?5ndoN6J2tYwkzCSyNRY9Td5nOeeaW85/jznyhtcgk3VRENhqE/owX2zAzXYX?=
 =?us-ascii?Q?3ihhqiMQSw3X9iluH0Ht41Rjbs5dvIYQg5UFPYEAx0EvePJR8u6X4iNS5kKx?=
 =?us-ascii?Q?9efK5PDZCVFQPeu0TYQl8YZAqEAOJPpGC/ZB2GmW6UqRrPnlnNOkiGlIak+A?=
 =?us-ascii?Q?frqPqZaDihOHleMo7BGAiTfncivIoy0tGGGxoy94S4VXDN0Yb+ntmfCIBIMY?=
 =?us-ascii?Q?45Ug2YuxB5ThlWPIoN9N5RHVQD3zlEIoGBPgC0Ueqo/UfTLDBQa61Q3LnKwO?=
 =?us-ascii?Q?86WT58JMRQvYlvAnrKr8726yq5KHdyEoDvjkPeEfaU9GBM0qf9Y1yjMSH9i3?=
 =?us-ascii?Q?Oe8ZM3drmVGzTNZXdmFs69SKzGEPpSBofJNkmu6Lg88rEkQ2V7jl5bvR5lww?=
 =?us-ascii?Q?nY3Gxze034hIkxKaNY+0lGc8SSprZ2lwnS5jNImCTrPzvOjxVXXC7kTirzvj?=
 =?us-ascii?Q?37R2ssfeCor2bwxcy+MU2TJYH4ofBjeTENknahHioRA6DVYDFPEYBUj1hgtY?=
 =?us-ascii?Q?T83dH+ZqPBBr2EzsL05dnvSstS8/hOZJAq+eDszFxt04fUbuSEF7rX7Dbco5?=
 =?us-ascii?Q?Q6nBkgcozkDsqW8SHK8piNdxqFnoWLfkWr8OX0AUVjP71MQWGaLeybVaa9b1?=
 =?us-ascii?Q?LFQBeUotVgp9bp7IfUcfS38a2I0CJXX4zrAZkHG3Z7WdCyV5FmEjt50Nbg9i?=
 =?us-ascii?Q?C6E/El+OSl32ml9BizD+ADloWyqkKR2dzBNMxutQfA7xExqwrClwXrmuKkud?=
 =?us-ascii?Q?7P5OU8B9KD+QURdfQX2k6l41llt8+hU20hD0eHcE?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a99dd553-c584-4e61-1e6a-08db94f9bc98
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9185.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2023 14:47:33.6944
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H4/hRFLoIT/Kkft/V5XtlsaUHV7Hp2XfMhgG3+pFBlsJ/d1mEML0E0m/uo6wJJxLRTA88VXWlVdUS4PpMAmoMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7164
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes in V4:
  - Keep the 'unsigned int' type specifier in the fix_mac_speed
    function declarations.
  - Move imx93_dwmac_fix_mac_speed into the SoC specific ops.
  - Use a read back to replace the wmb() instruction.
  - Correct the target to 'net-next'.

Changes in V3:
  - fixed the build errors reported by 'kernel test robot'.
  - Only perform clock pause in RGMII fixed-link usecase.

Changes in V2:
  - Call fix_mac_speed() with new mode parameter added.
  - reorg the function of imx_dwmac_fix_speed_mx93 by using the
    mode parameter.

Shenwei Wang (2):
  net: stmmac: add new mode parameter for fix_mac_speed
  net: stmmac: dwmac-imx: pause the TXC clock in fixed-link

 .../stmicro/stmmac/dwmac-dwc-qos-eth.c        |  2 +-
 .../net/ethernet/stmicro/stmmac/dwmac-imx.c   | 45 ++++++++++++++++++-
 .../stmicro/stmmac/dwmac-intel-plat.c         |  4 +-
 .../ethernet/stmicro/stmmac/dwmac-ipq806x.c   |  2 +-
 .../net/ethernet/stmicro/stmmac/dwmac-meson.c |  2 +-
 .../stmicro/stmmac/dwmac-qcom-ethqos.c        |  2 +-
 .../net/ethernet/stmicro/stmmac/dwmac-rk.c    |  2 +-
 .../ethernet/stmicro/stmmac/dwmac-socfpga.c   |  2 +-
 .../ethernet/stmicro/stmmac/dwmac-starfive.c  |  2 +-
 .../net/ethernet/stmicro/stmmac/dwmac-sunxi.c |  2 +-
 .../ethernet/stmicro/stmmac/dwmac-visconti.c  |  2 +-
 .../net/ethernet/stmicro/stmmac/stmmac_main.c |  2 +-
 include/linux/stmmac.h                        |  2 +-
 13 files changed, 57 insertions(+), 14 deletions(-)

--
2.34.1

