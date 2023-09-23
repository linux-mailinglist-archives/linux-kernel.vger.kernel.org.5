Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05F527AC280
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 15:50:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231591AbjIWNuP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 09:50:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231199AbjIWNtp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 09:49:45 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2063.outbound.protection.outlook.com [40.107.21.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCBDB1BD;
        Sat, 23 Sep 2023 06:49:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DW/ajB72BxvMtDSS12cCqLSkvrgPABwqpsCB1oUXXaJSnc3g2sFEeRDemcbN80I6nuDiWm5/SLV2Asr8hCm+qJPuMsbe3v3w94Vi/pLze8+7pEG4Zigjm00iQUevajv7QxRwgOG6B3fUQKTQ/nt1LwmnUgDISMJMnI02+fta6XWUPC5c6/U7G0QZYE0kdp+Fsl52h1mJ6k7nKhPHknclxKFbpUOdEHkA0dUFJhdooPHpVlzDednyTMy9V0a1WyYq5W0pySeJjFBF66McON47ArzNDtm7RxqPyOyFnu3Ta8fkeY50wyHZ0Fl9B5EBeyuS3fpMxBy1yOBrDasbjUzMZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5opFA3sHphDMtZr7cXb2BkhQSw25iuh5BpeyWpeg7Ss=;
 b=BDG9VUJmDVtYN47dKLYIA5AF92HYe4MFCmhnpKMOaSGAZ6QACNTDaecBDD8tYDDmCgxINEWs01d6K352QaO64Y71vd0q302GDoZUzUODVRzKTAKNOAyEZBivE6CKSTNYiG9J1H0elogf4L7psEjF7pLhrqNSPAb97mCSV9KJtBTZda+Coe5NZW2yox1bxVY12t6TB+zAiS8eKSRT/Fz5MESrzbub+vrB+A+Am+tLhcWpafhz14R90PilC7bglpZLOFPRVw0po3K9QweIglSQA5Z+W/JZBHTCbC/nFelBo9xbsbZT8hteRPDByh8O2ud/lUQoElF0ya2o1qLq9wixAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5opFA3sHphDMtZr7cXb2BkhQSw25iuh5BpeyWpeg7Ss=;
 b=TCnYAYFriZ7RErVfinlB5veJfq00ghAc3YenWZqJmpK/VlxQTVj/m3LUIpFRopsp84n6dVn37x4DGc3d738ytQjZU+SGPm1wnvYKRa0HNk0/gZsrtwa/YUv6BPtxR4EtGgUiugOuF/+33/2wi/yZTf9fyUQeEGY4QGmVT1Du/Yg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by AS1PR04MB9454.eurprd04.prod.outlook.com (2603:10a6:20b:4d9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.21; Sat, 23 Sep
 2023 13:49:33 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::568a:57ee:35b5:e454]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::568a:57ee:35b5:e454%3]) with mapi id 15.20.6813.024; Sat, 23 Sep 2023
 13:49:33 +0000
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org
Cc:     "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Madalin Bucur <madalin.bucur@nxp.com>,
        Ioana Ciornei <ioana.ciornei@nxp.com>,
        Camelia Groza <camelia.groza@nxp.com>,
        Li Yang <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor@kernel.org>,
        Sean Anderson <sean.anderson@seco.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>
Subject: [RFC PATCH v2 net-next 09/15] net: ethtool: introduce ethtool_link_mode_str()
Date:   Sat, 23 Sep 2023 16:48:58 +0300
Message-Id: <20230923134904.3627402-10-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230923134904.3627402-1-vladimir.oltean@nxp.com>
References: <20230923134904.3627402-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0165.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a2::10) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|AS1PR04MB9454:EE_
X-MS-Office365-Filtering-Correlation-Id: 705f73e4-ada0-4a8b-0f6d-08dbbc3beaac
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cjWmT6vIrw9Z+ZXd1DMuLmHZRnkxrs+VuVnQcag8cG9XpeQI7DZKI+C2of5HcGFs3J2BATKJuugMvsTY7j16AptlcKPzF5m63CcsmrRx+Ff0GXMoWAA7PDGmWwba6QEuZTViJFNwrRQkm+YUHwmDLbJnflAfLg6pN+tGXnEO5Kj12GWSSnD69TqZEiE+kX5fEiqYIoeHm4Tvc3JBlP2htBIiGxb+RTZoWDgtmSAhWcUx5fAqNo3nGqKScco6wyxmidLZAmDnxEjMZMJm2h875Pqy5UdT20FfA8OWl+A23HvgFRhqdoCFhXN07es12bcQ4Af0+hOnMGepRvBMSmvLgaOFRber+u6Mp/UPC+YE/QHTnhKw+cSSlj43ct+s3zDJ+vFrTMyv0lzJURW5D4CURv/8HoyBXGU+82ygNwgwTNt8wBBzVKIxdw+uxBbS2Lk27eds73QYBv397psou5r2I+VE4TRbY8GxtleMuNuxL63ybJy5X/5MqyAvqdbZJ+8W+wQCXQEoA6JoYXLBv0gK7511F5oS3J/yTxR5dVv+nIGTAvaBaz5VvRSrKHPSu3OBAcLYB+umDOyn/B2rSCoj+n2/lfcoYvB5Q/dRHJDncXla3SjoPk2OPxF4wHzWU1gN
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(39860400002)(136003)(396003)(376002)(230922051799003)(1800799009)(451199024)(186009)(66556008)(52116002)(2616005)(6506007)(6512007)(316002)(5660300002)(66946007)(38350700002)(6666004)(478600001)(1076003)(66476007)(26005)(44832011)(2906002)(4326008)(36756003)(41300700001)(7416002)(54906003)(38100700002)(6486002)(8936002)(86362001)(8676002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pE3xgH+WfUZtHT2IU8KOedW0ry+g8yiIcCxsCpbRK4cbfhWSOzv3goyqDg2i?=
 =?us-ascii?Q?pjsekcJGEoJNRc2OYkwktyDvUpnWWof80/x6g7skNBlmX8tkaYAtIg58SMJN?=
 =?us-ascii?Q?2OyYkYcNrOP9vnadkr9qjKqXe+5yMd+FxZ0HnvVa5KGf+hZ5S+pDSRhw3SiE?=
 =?us-ascii?Q?ZDvsq2GOYzfLNOvbH4bmIZyGD/wRxg6QDMQXf+GOobD37OyTevp0H3levfNj?=
 =?us-ascii?Q?15kZPEqbm6MrSWicXPblqHra5HmFzso6bDSFiNrIkONxS+mOcBFaXYTsrZcJ?=
 =?us-ascii?Q?pmuUtOFdrOnPh7EYtEPXB6wYFYeJ9d+ERvWmKI5p2QZs8l+u+JlgNAn82rDg?=
 =?us-ascii?Q?meWIhuVBkT32re3tY1QxZ7L1lVwtya21s2RevD8LXG8TEXUY3v0Y/xNfxoI2?=
 =?us-ascii?Q?BnMAPdIasOb8XgifSCMLO/zK+ks5PROq9htj+Jpq1mhug+p1HchZYEu3mfF5?=
 =?us-ascii?Q?B4eeZcoZkpi6WaJeXyNimy3ju+RFMHBaamrueubWPHqS8X2sSQUiwVNkwA1r?=
 =?us-ascii?Q?pEaV1oJedugXlssIIli6TJ8v82sWAYlAm/e33v8yr6qWGdhMGdINdKimXR7d?=
 =?us-ascii?Q?LzJFswyWkFHlBUcaLtdZQfE+oIJZVg0ogVlgnLQvPEZdBsCmlUAAlkXVKQYF?=
 =?us-ascii?Q?Kk5Fzt/W+XIqnfoPkaSXrFx/EI54gu2GZjIGtOWSlMowSjw2/jnQpn3w2MxN?=
 =?us-ascii?Q?SDnotmoqGBT/9rRgrXUezyWZNpIDznI3maeDCfAcpysWjA8uKuXMPW3sdH43?=
 =?us-ascii?Q?RnmRwsddgEhAYs3moUdQC8DQpWiDJNGCLn5JgvIxl1Fo5D2E1ddeXQsxvUlV?=
 =?us-ascii?Q?iilAqV15PIGdWXnb3LqQD5VNnjFOElkMURuka3huG85f0LE1cENxw7Jg0254?=
 =?us-ascii?Q?SQtdScSCf6XKtAe9UTDWzBznSQOwAWTS9SblFMYQYyRnT/JEYWmDcSCHJU+E?=
 =?us-ascii?Q?YgQoB7833q3L6OLo250fW0pHctR6wiwboGDtWLFJ7TnCJUntHW2QaPa/FWLw?=
 =?us-ascii?Q?nNvuRcGXUWwuFw5Pmlox3S21V7IzUyeu3MqlLI3y1/R6Ukjz/xbgmeMb9GOg?=
 =?us-ascii?Q?JbRkhEcDp1lcFoZQ54BoxIKulAy5oawm4pp7XlOpzOkhl/0MITrh2HnfKA0C?=
 =?us-ascii?Q?rMQREQRy5Lh3rnaJKJKzh8nBq3pxZb4vZrjgIHziaVOKB/yNLGJMZqPEVKJV?=
 =?us-ascii?Q?mC14H05ZTj1sU2M/J+SIYkuMB9YGuXE6GMSoR9WdirlZOXaDhZk+OxgRhtuG?=
 =?us-ascii?Q?vmq/+e+hH6nkuUVfQZGmagHRNYvK2nw9AFDAC7MNuXg3munulxPbTC+M6wj5?=
 =?us-ascii?Q?KLw1QQLo9uIKgdTQhaATr0xxDvnANulC9SJUztnBqbefdh0vJ8cktiz/Wqfa?=
 =?us-ascii?Q?NQSf4vpzT+ow4noJzE/G5Sy6TMdlf4WLxtkNyUSaEBZYAliUym2JkfeWJV+D?=
 =?us-ascii?Q?sPIEdh3+MpZ+DlH5Rs8I6bUuO1lQ8rv9jKv6y4QpmVgK+yxUJYcwUK0Vm+xn?=
 =?us-ascii?Q?FrSZ8HLZS+0MPQ8EuKuB3XWevCl1qtmi8gAKxlo6RGOjMMlabPzUizlPWDSC?=
 =?us-ascii?Q?6TOZLGamxO9c9dekLFmZh/zPdufmEfUb6K/gTXUVtPPMq4PLK5T/w855SOKc?=
 =?us-ascii?Q?zg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 705f73e4-ada0-4a8b-0f6d-08dbbc3beaac
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2023 13:49:33.0746
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EhQTaWRvNlpG0ldO5wLdAWDGU8ovnewFRG33RWab5WFGgMRfR5WP4G1TsH2mGMarp6luGez6u6c0bhGDzZXPlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9454
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow driver code to print stuff like the resolved link mode to the
kernel log, by giving it access to the link_mode_names[] ethtool
internal array which already holds this info.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
v1->v2: patch is new

 include/linux/ethtool.h | 6 ++++++
 net/ethtool/common.c    | 6 ++++++
 2 files changed, 12 insertions(+)

diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
index 62b61527bcc4..7b144f2b7dfd 100644
--- a/include/linux/ethtool.h
+++ b/include/linux/ethtool.h
@@ -988,6 +988,12 @@ void
 ethtool_params_from_link_mode(struct ethtool_link_ksettings *link_ksettings,
 			      enum ethtool_link_mode_bit_indices link_mode);
 
+/**
+ * ethtool_link_mode_str - Get name of a given link mode, in string format
+ * @link_mode: the link mode represented in integer format
+ */
+const char *ethtool_link_mode_str(enum ethtool_link_mode_bit_indices link_mode);
+
 /**
  * ethtool_get_phc_vclocks - Derive phc vclocks information, and caller
  *                           is responsible to free memory of vclock_index
diff --git a/net/ethtool/common.c b/net/ethtool/common.c
index 2b3ddea465af..9a79548adb68 100644
--- a/net/ethtool/common.c
+++ b/net/ethtool/common.c
@@ -691,3 +691,9 @@ ethtool_params_from_link_mode(struct ethtool_link_ksettings *link_ksettings,
 	link_ksettings->base.duplex = link_info->duplex;
 }
 EXPORT_SYMBOL_GPL(ethtool_params_from_link_mode);
+
+const char *ethtool_link_mode_str(enum ethtool_link_mode_bit_indices link_mode)
+{
+	return link_mode_names[link_mode];
+}
+EXPORT_SYMBOL(ethtool_link_mode_str);
-- 
2.34.1

