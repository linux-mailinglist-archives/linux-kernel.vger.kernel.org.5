Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F033C79316B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 23:55:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234195AbjIEVzO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 17:55:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233147AbjIEVzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 17:55:13 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2066.outbound.protection.outlook.com [40.107.20.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9F1AE48;
        Tue,  5 Sep 2023 14:54:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fMDcuXeUDshjHgz8eZJdn+73WjarFh2S4Dz8pDZeQUQk+cET2pslmCMN05xZAUt0elN9yDKeoTnoeRkx9k1pnxnhcQiXBZQ8UgOUbd9Kp6D+AvbtGLTFO/VEHT+VKxW4aoVtT7hyqcljdoFzMqfIvVIT4RvlaCh3pwXzjvdzgVrb9ELSNd3YkA6cf/316pU8FBYBtI0nDQfddzKeEaiB4NSE0j8iNqyUKhR7rblqjBL3+Z1NHb7ob7jhaVt5FSg5swgz6OpEbXkoUSDuyVFvjTOQZQrHoGF+Rw89tXkAIrBnQTFeI6c7ZXX3FDqZcvfR9Sk1lVznES6hh84u4lno+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/NqVeKn/xUcWG7L/7aivMRpWX0KOY+CqKYET3VcoAVI=;
 b=m6gEeYI/TOQ7kfiq9B+GPPpTayxPn2O1teVk7hL6Vnfsuz5+nlpc6qjoCk3sY+izDwnfgEWBu+oxtgLJas2z2ySiPAfr6Ie5UVfevO2Lw1TfdwD0l8plzG4bzmcIyU++ACK6ARkzO4vCGNGzBifpVRUF+7habwvEMMvAOd2Toeo/0dPEnpeVVcNveMPyGz0eWs3BDN1llUdGbd8fuvoFokO9v1DmCuBW/wTmd//cXQ/n5OD0wICTZK0JQYvtU04+Sx8FrzuQdMncty7/LeQ2vTpu5rPcjJkTHWl+UnzSiy8KRObW7mlJ+SrETnTYIslIurB+SkYkgRwS7+9iKLjBoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/NqVeKn/xUcWG7L/7aivMRpWX0KOY+CqKYET3VcoAVI=;
 b=lcIq0e/hePabuDv4MqP0lEtI7Ip0uNHeAmtqbU80oq8xw3dqc1Wm9bQQ/kWaA7DncFa7R2w7JuRMl6RteC6MZwusGxVN8qsMwA5A4grAgQVA3NsO/g++XJCR4mkRQWg58D28kBjq+50J/xOcIa5BJcJr0D3iateiWzzEMXosVR8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by AM0PR04MB6963.eurprd04.prod.outlook.com (2603:10a6:208:18b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.30; Tue, 5 Sep
 2023 21:53:54 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::568a:57ee:35b5:e454]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::568a:57ee:35b5:e454%3]) with mapi id 15.20.6745.030; Tue, 5 Sep 2023
 21:53:54 +0000
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     netdev@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Xiaoliang Yang <xiaoliang.yang_1@nxp.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Yanan Yang <yanan.yang@nxp.com>,
        Vinicius Costa Gomes <vinicius.gomes@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH net 3/3] net: dsa: sja1105: complete tc-cbs offload support on SJA1110
Date:   Wed,  6 Sep 2023 00:53:38 +0300
Message-Id: <20230905215338.4027793-4-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230905215338.4027793-1-vladimir.oltean@nxp.com>
References: <20230905215338.4027793-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR07CA0029.eurprd07.prod.outlook.com
 (2603:10a6:208:ac::42) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|AM0PR04MB6963:EE_
X-MS-Office365-Filtering-Correlation-Id: ffada9da-9918-435e-5730-08dbae5a993f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LKMXqHV2fB4dsEFx2WjG2ZTQ7S/LCkgINwdHaaPFWF3hfoidUEda9irPSnLxdiqck4r+IDKuxhPTDzJC5OtFcz5Y1BjRAqyPYozU0lkSIf10qqy+OetirI7UPXqwr3gGnWHhQYv05f3V4zH+VFrk3vUmHclavFv3AGbtG09pBipKBiBL5OXqF3bCXU8bbxp13CYP7SML5a+E6bu65RyzqmoNhn/XwUecDuhTWuXdtaPUBeBfcZ4uab/x05t5My4BQLnAqNH07jcpfOSPCNk2kRMFrE4Q2fUEiIDuczqrqRA+0uneRinrkI7b/UcAvNmV2s3gBchvS69sc//oIIlZsWbxqBRiAvstSyMiR37cjGv8F7ceCGdugeiqkqHgACkTtX3ehWMf83PFGiMBZXQTqrxIAVVoWOv9Q8X222x3M75fZoJ6iTxxCGlz+hLo+q2Lhrm0pBy7p0QSSvAOEpOI/h6kUj9p/9H3Rw+XRzf9kA+r3L58NVt5fqYBocUwUmi1HsfIJGIEZ0LBw/WPC3EwhOAEWrh7anfpdFQtVY18wbi+mLSJT/uQutziwKSUSKzYm04Em11/q4zrzBqOEIwlA66NKjQIJ5liaBpY6BFbnuMWLMjRzk1kGO6R/Ld2/Qez
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(346002)(376002)(39860400002)(396003)(451199024)(1800799009)(186009)(38100700002)(38350700002)(44832011)(83380400001)(5660300002)(36756003)(86362001)(41300700001)(6666004)(66476007)(66946007)(1076003)(66556008)(478600001)(2616005)(6512007)(8936002)(4326008)(6486002)(8676002)(26005)(316002)(52116002)(54906003)(6916009)(6506007)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VClfTtyRkbSQsxLeQMf59SVKlH1eq9qkOu3iJfcITal0egZQmlwlR58bhWzH?=
 =?us-ascii?Q?FW9mxFcbtNnT2BQpjkaSd+CI7pXAagscHQHJqipzdasPboZp1fMMI6GQ9Pla?=
 =?us-ascii?Q?QXYxUrbu9YVRcraDKNci8xJl2N1Oc7em9clNi5O3aOy1wG6mTI2z0yLUESQ6?=
 =?us-ascii?Q?FnRzbUSLs83QKemLaKX/LdI0vzuG0ThgIHU2IdG5HrkNKRbksYoSOFZ/nJgu?=
 =?us-ascii?Q?1NehhVjtJP1Y3mRFHP9PMhC1oF/0me5Kw5jgPyNcLtdcbGWkeA2jibbbowXB?=
 =?us-ascii?Q?MdDoemHxAQQBJPywav2eMrazKSCESK7KVzDBxogy9SEt0N3ZYrZENPiIlSNb?=
 =?us-ascii?Q?W+QguXaMtA5+xeAkI62syzmuKcmlMpd77JV0Tkfx+m+N8S4n+4IQ4teIpWUr?=
 =?us-ascii?Q?D/mvZjYGLfuTmdFBRXkorSyUijZ5mOjmF8Jsck44c5HkuXdUF5Mbo+Zf1u7m?=
 =?us-ascii?Q?AuvRM/UHaiOQxPxQSXPtRvbhsAFzLfP/Z2H4zR4HuXSQt6E51VCZKIX2d2A3?=
 =?us-ascii?Q?pxzwfVXc1wK6N//0TI333AK07MoQgtpuI9VgTMoCphxNNAgdjXTmLcoX9mIN?=
 =?us-ascii?Q?UWx4TkjHKxu8JTgEGQqUVPwRZtBdKAAjg3QpEu1JLTw7/qL/DbYsAoBzFJ2N?=
 =?us-ascii?Q?sIo+pmiUULHi+Finz/LG46poTIdelPY4Wn7xZmcpmslXAMwEooc6mJaM63r8?=
 =?us-ascii?Q?ma/33KdjVbb+ShxLLd/72yw+lN2MYsIvOaAXx8N/Mk//oNOMxmSpCf4nlBYW?=
 =?us-ascii?Q?xNusMzdxw+YZc5EKWw7rQGfbZvK4PcAKGHPrapgThP6k+f1iXdhxoE5V5X7Y?=
 =?us-ascii?Q?Siv0t21cTuGh7sIvFO40G/Fmb3jbPE/eISvY6uR8CGZUjNreH2d9XG0CKlmp?=
 =?us-ascii?Q?hjUwmkStPA7JctI8LGISDQJt+3qLmX8B4dO2VYh8CEHUuUcr0szKWeQk+qi8?=
 =?us-ascii?Q?H1/qPsSFpe0+jMZAWNYz6+4oiV78FDTM11dqOmRIBhlCVG5R8q3EwGy/bKuq?=
 =?us-ascii?Q?lsKNCDMX/QnJmvdUk1UOoch5xu9yIE2pNSkGOGATp2xBlAuTGy1uBCN+yn17?=
 =?us-ascii?Q?Gvc+sI9GTMYo9UquIZB+J4+zg1WbGdywm0f6niBYJxTmiWd/5uiH/5WForFL?=
 =?us-ascii?Q?oLOVtJ/sYR5dZ84YVhQnKAZCbifPHKqdJTgm5TNkolMdW4KRxtzkbmSUQw68?=
 =?us-ascii?Q?efkFuXdWCqiQjOJxp6iFsDO72DTusz7gyW/gvjx5liPsexihbyp/Lnfvnxb0?=
 =?us-ascii?Q?TQkax1r+FHmm9LXO8Qsgrvk5e8hUApKRwYjiXKyM5EO3kImEz3jNA1QKvRJe?=
 =?us-ascii?Q?yq/lgsnzCOpi7NUomWuBDODw3/EEugZuxUbmKTplH/ma7KdQEkjzE4Szi1e+?=
 =?us-ascii?Q?GZap1PPUwOH564so4g1q/FZN/ofha3KiMMYsWv/FHZeJzzVm+yFZ3vRnQiwf?=
 =?us-ascii?Q?3+tC3Rfrahd2V/fQWfVtvaDVMXryokwTpbZHbW6G2f39OTvcjxEWIirJZ7Vq?=
 =?us-ascii?Q?jaj1DcjpHgzSQdNg89NI8v9TyeoFvLxSrffSeYe50ZXaXZtq6pI/o3jHaY6M?=
 =?us-ascii?Q?W5iKt/T+siLJKFgu2V978hOwXwALChmosJua8uJ+d5kBt3CVCdb9UvREOIAq?=
 =?us-ascii?Q?Ow=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffada9da-9918-435e-5730-08dbae5a993f
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2023 21:53:54.6134
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hP/lMx/SPO4/LeBWqt6Z8WgBfZsld8fWi8DZiXQjH9FL/fRhR1cdcfvEmrSlWUb7p51tg3U3bIwmW3r3+frwyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6963
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The blamed commit left this delta behind:

  struct sja1105_cbs_entry {
 -	u64 port;
 -	u64 prio;
 +	u64 port; /* Not used for SJA1110 */
 +	u64 prio; /* Not used for SJA1110 */
  	u64 credit_hi;
  	u64 credit_lo;
  	u64 send_slope;
  	u64 idle_slope;
  };

but did not actually implement tc-cbs offload fully for the new switch.
The offload is accepted, but it doesn't work.

The difference compared to earlier switch generations is that now, the
table of CBS shapers is sparse, because there are many more shapers, so
the mapping between a {port, prio} and a table index is static, rather
than requiring us to store the port and prio into the sja1105_cbs_entry.

So, the problem is that the code programs the CBS shaper parameters at a
dynamic table index which is incorrect.

All that needs to be done for SJA1110 CBS shapers to work is to bypass
the logic which allocates shapers in a dense manner, as for SJA1105, and
use the fixed mapping instead.

Fixes: 3e77e59bf8cf ("net: dsa: sja1105: add support for the SJA1110 switch family")
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/dsa/sja1105/sja1105.h      |  2 ++
 drivers/net/dsa/sja1105/sja1105_main.c | 13 +++++++++++++
 drivers/net/dsa/sja1105/sja1105_spi.c  |  4 ++++
 3 files changed, 19 insertions(+)

diff --git a/drivers/net/dsa/sja1105/sja1105.h b/drivers/net/dsa/sja1105/sja1105.h
index dee35ba924ad..0617d5ccd3ff 100644
--- a/drivers/net/dsa/sja1105/sja1105.h
+++ b/drivers/net/dsa/sja1105/sja1105.h
@@ -132,6 +132,8 @@ struct sja1105_info {
 	int max_frame_mem;
 	int num_ports;
 	bool multiple_cascade_ports;
+	/* Every {port, TXQ} has its own CBS shaper */
+	bool fixed_cbs_mapping;
 	enum dsa_tag_protocol tag_proto;
 	const struct sja1105_dynamic_table_ops *dyn_ops;
 	const struct sja1105_table_ops *static_ops;
diff --git a/drivers/net/dsa/sja1105/sja1105_main.c b/drivers/net/dsa/sja1105/sja1105_main.c
index d7f57f223031..a23d980d28f5 100644
--- a/drivers/net/dsa/sja1105/sja1105_main.c
+++ b/drivers/net/dsa/sja1105/sja1105_main.c
@@ -2115,12 +2115,22 @@ static void sja1105_bridge_leave(struct dsa_switch *ds, int port,
 }
 
 #define BYTES_PER_KBIT (1000LL / 8)
+/* Port 0 (the uC port) does not have CBS shapers */
+#define SJA1110_FIXED_CBS(port, prio) ((((port) - 1) * SJA1105_NUM_TC) + (prio))
 
 static int sja1105_find_cbs_shaper(struct sja1105_private *priv,
 				   int port, int prio)
 {
 	int i;
 
+	if (priv->info->fixed_cbs_mapping) {
+		i = SJA1110_FIXED_CBS(port, prio);
+		if (i >= 0 && i < priv->info->num_cbs_shapers)
+			return i;
+
+		return -1;
+	}
+
 	for (i = 0; i < priv->info->num_cbs_shapers; i++)
 		if (priv->cbs[i].port == port && priv->cbs[i].prio == prio)
 			return i;
@@ -2132,6 +2142,9 @@ static int sja1105_find_unused_cbs_shaper(struct sja1105_private *priv)
 {
 	int i;
 
+	if (priv->info->fixed_cbs_mapping)
+		return -1;
+
 	for (i = 0; i < priv->info->num_cbs_shapers; i++)
 		if (!priv->cbs[i].idle_slope && !priv->cbs[i].send_slope)
 			return i;
diff --git a/drivers/net/dsa/sja1105/sja1105_spi.c b/drivers/net/dsa/sja1105/sja1105_spi.c
index 5ce29c8057a4..834b5c1b4db0 100644
--- a/drivers/net/dsa/sja1105/sja1105_spi.c
+++ b/drivers/net/dsa/sja1105/sja1105_spi.c
@@ -781,6 +781,7 @@ const struct sja1105_info sja1110a_info = {
 	.tag_proto		= DSA_TAG_PROTO_SJA1110,
 	.can_limit_mcast_flood	= true,
 	.multiple_cascade_ports	= true,
+	.fixed_cbs_mapping	= true,
 	.ptp_ts_bits		= 32,
 	.ptpegr_ts_bytes	= 8,
 	.max_frame_mem		= SJA1110_MAX_FRAME_MEMORY,
@@ -831,6 +832,7 @@ const struct sja1105_info sja1110b_info = {
 	.tag_proto		= DSA_TAG_PROTO_SJA1110,
 	.can_limit_mcast_flood	= true,
 	.multiple_cascade_ports	= true,
+	.fixed_cbs_mapping	= true,
 	.ptp_ts_bits		= 32,
 	.ptpegr_ts_bytes	= 8,
 	.max_frame_mem		= SJA1110_MAX_FRAME_MEMORY,
@@ -881,6 +883,7 @@ const struct sja1105_info sja1110c_info = {
 	.tag_proto		= DSA_TAG_PROTO_SJA1110,
 	.can_limit_mcast_flood	= true,
 	.multiple_cascade_ports	= true,
+	.fixed_cbs_mapping	= true,
 	.ptp_ts_bits		= 32,
 	.ptpegr_ts_bytes	= 8,
 	.max_frame_mem		= SJA1110_MAX_FRAME_MEMORY,
@@ -931,6 +934,7 @@ const struct sja1105_info sja1110d_info = {
 	.tag_proto		= DSA_TAG_PROTO_SJA1110,
 	.can_limit_mcast_flood	= true,
 	.multiple_cascade_ports	= true,
+	.fixed_cbs_mapping	= true,
 	.ptp_ts_bits		= 32,
 	.ptpegr_ts_bytes	= 8,
 	.max_frame_mem		= SJA1110_MAX_FRAME_MEMORY,
-- 
2.34.1

