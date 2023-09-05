Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BE59793166
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 23:54:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231794AbjIEVyr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 17:54:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244744AbjIEVyl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 17:54:41 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2066.outbound.protection.outlook.com [40.107.20.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 635FEFA;
        Tue,  5 Sep 2023 14:54:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QL4wGaLGAYnjGWtMZK8BRxqnMVll9NFECc/FB2zSQ55r3OmeQ9Ma9Az4IC/h6ehJ6mdvUwFYfubtObAB0uYhB82ED70Q0Q0X9UQGURB36l2mz0LNBvn+BvOEI+XklfHeCJtuN91qY72AtSOtaIuphakFVtJVrEg5sjpyUExZoxq31/ScDrV/bq1O2BZVH3nZbQYiXHwQFSoSl/cO09Xqw1JkrbmzPzBCv98d2U2FkhHnlM00n6ecLnajyVd1G2r2RK50DdZPc7MpT0ryMBMS1pjwLCfk0FNsJuMMoPMCbaW69kzRIBRm2lSBprrpMo8va20d5Tji6fdIis4jFMF8qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qfxDyEeqWpq/P6wjPuFiKe/vBOHvsv8ygeWRWpbIwYc=;
 b=O64Ptmq0hHR4UbgGBW0ON8ayDtIWHn/7lar3HdJ0BNO8Ayxw0OoktyabNpyAkYArIAa7EjVmgKNk5TWaP1PFb9RLrgbBP8YRzGFZWAnoAAmGm2Lt80wxKFHAdIVR/fT9DAsgX6EHw6eypGSdRBJxIkUVyUoaRgY9uzkZ5rYLmHXyB1+WFLftTX6geve9Nxa3x4mXFbzvCPjGtpGrNg34X5njJ+U3kdA1ngQjHP/KnrbvBs5GYXmjVaKROhzDpy95OLDZ3BE8iRuTkZZ4hoDZmKb+X+Krvgv8xGiRoDulsomP/zePLU5xy51ayDOgA0w+U6VQRsBvG1xUhixkZI+mYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qfxDyEeqWpq/P6wjPuFiKe/vBOHvsv8ygeWRWpbIwYc=;
 b=DVP2kLtX687wCKH7aL7r0QlMi31vFUInopOefcZTQmYsk6aHjp+g5u0kUgxf3mqcUQVk5O4JGZ2gJj6GLtiPcVnq1zAI3QT15lfP+TX2dv1AuNkyjxUOwq9MMRb9/LkkrcqHoxhAQaw92r1ULGBAbltP3em5JJ2OrpHO7arSAcY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by AM0PR04MB6963.eurprd04.prod.outlook.com (2603:10a6:208:18b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.30; Tue, 5 Sep
 2023 21:53:52 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::568a:57ee:35b5:e454]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::568a:57ee:35b5:e454%3]) with mapi id 15.20.6745.030; Tue, 5 Sep 2023
 21:53:52 +0000
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
Subject: [PATCH net 1/3] net: dsa: sja1105: fix bandwidth discrepancy between tc-cbs software and offload
Date:   Wed,  6 Sep 2023 00:53:36 +0300
Message-Id: <20230905215338.4027793-2-vladimir.oltean@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: afcd2e45-b584-4b2b-0538-08dbae5a9826
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /hx+njpJFrwhKr5GlDOwhkO++b0hMgFICGgXyd8F7efqJFD347EPggzF44Ziy/BNRg8xEwjyz7NQHDxEV4kOsGCcRkyCpJQZ29RW8VzMsVqVg4ZEHxuuEo+G9zTH81ySfUnladWvCvrwS19ybazFPO5ubBoh4O1dsQWBgCjs0plc43adSdGWTPdRLlqK33yjO8XC0vAB0J2pQz7QzdPOLnUaO28VJRSLEiEan0pD1CSoF+z/SIIfalrIyi1uECF5z7ay0cfdwCijXazZQz/5SjEiSIkmMQznS6e+KxxGrgudBwMIgx0K+jduJGqNS3TjXHYwTnzxA/jhkjtSG6HzwsFStAY5fQsMOwEVzuxW8QkYfmbrS6RwquWjmdgCPezaARxB8RE1oiqIQY4+uUj6aE+srkX5CH6rYazS9tFChbCoJ2P7qJl/5UN8IaTn2Z9Fb+HGQI+az5z2xv1BAc2suXQTxcJK9G1PmJOQ1f8IPK9rxc002poS+ftqYcP5BcwuCZFwNp5z4Vc4cpndG4psxgMSkSlD4MPFm2RRIiA9ZZbQP6O8FmCgDw9/l0W3cHR3PxdkQm2QFVda/DrpB+i8MmYxrwtoRG2/TOzB87Qiz2WuoR07lscuS5CEQ0n68Dep
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(346002)(376002)(39860400002)(396003)(451199024)(1800799009)(186009)(38100700002)(38350700002)(44832011)(83380400001)(5660300002)(36756003)(86362001)(41300700001)(6666004)(66476007)(66946007)(1076003)(66556008)(478600001)(2616005)(6512007)(8936002)(4326008)(6486002)(8676002)(26005)(316002)(52116002)(54906003)(6916009)(6506007)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QZJe/oXMRCgb+JHhLZrU+yCW1lbbXkby6uRTTFOy05xjh4ZyWMSvWSVSDogw?=
 =?us-ascii?Q?MBhSpIFkpK8Y+8q+FL4o8ezK6wU5WKUgVzHJKqGGGqFWEjNRHGD5825CJ1z5?=
 =?us-ascii?Q?U4QUs0sHbnfVC3S2PqAoOivfe9RogkeXW7MUlTWNlW1tnZ71jMBPpQcnu4mP?=
 =?us-ascii?Q?KQf6Dd9irVZEAyqxZo6FFRGKz9j+WkPNvbsX7/zt54xb8XGYpiTt/qe/S5ZF?=
 =?us-ascii?Q?XwlZyOpuG3rt2DRoUoajnDZAxWbVo3y2hdwiRF8fQwPPL4mcWYhldidJka02?=
 =?us-ascii?Q?CHoHzjTgZfO9oai3Uy6r6UdLjgUYX74w0gIBpzyh0Gf5REJIm/kjCa3GazKK?=
 =?us-ascii?Q?go8UGSs6ToGWHdlxwpIsCfZtkcxSTL/aNkKyTBrIwyYAb+ZTkjZaMs6r0Xex?=
 =?us-ascii?Q?Tr/+q8l9+dAlhFHAJRzylYLxA9Ft/5Z0KQGFvK4umHIJlzmAO4SE1h7fYy+U?=
 =?us-ascii?Q?DClCzuy0RivF2Cx6qWjoaCozScsH6UE7BhFwuuXKiPvGI3KFiUH8Oc2Qrl/N?=
 =?us-ascii?Q?yIkk3Y/OuqppaCjzBrjMz3lCdLDiN0tTGUhCHItvh4jouQSvL6JRC0+hKZ7/?=
 =?us-ascii?Q?GvbwNkOTSuXCtSyM5AK/C7SfLznEo8bg9Se82DDYZA3TWA1/Yugc0Spoe0J2?=
 =?us-ascii?Q?2/UFzxlQPwFoqsaKWvbUckI5BSsHNPke8ruujIvRLSNi5RQQPjVIYm1AvlJa?=
 =?us-ascii?Q?vhKZ30v+d8IQMYxbPjbXp93K9wtMdzjssFPw49MVBI4R/bPEe3QbjmhYghTm?=
 =?us-ascii?Q?m6YiPk78EYVGOajsfeCeoT+sqkstP5GqSWB+HG8Xcq5RCN8yLGI7gfiwGPde?=
 =?us-ascii?Q?LER/G0YHc29V0+twkvPCNeiWQWJKerVWmIGccJZXV8Fol6CYkyShomWWijEz?=
 =?us-ascii?Q?UWQUtydpXLvAu2lTgAdJGA9OsKavXa736lZk1uReV3ZvAlgejAsfGL9akvtP?=
 =?us-ascii?Q?58G3CMuMzKeV2KYmNNhCGnvCVdpWLVYw4kvsCHiqrTbqA13bqYGOdbiKRt6G?=
 =?us-ascii?Q?EtL4vX66XrAIukXvaT0kjjSCm65JQoZvug3rWNXsEAvDi/oaYcTDu3hMyHNa?=
 =?us-ascii?Q?UraUV9gi5yNC0eGDSbameHNAnCC+ECSK8a3+qOA2jqWqk4DkNHQf96R0r82t?=
 =?us-ascii?Q?+HOniq8g9qSsbNw1tl0Y8TtxvqOPjfY2GfIRNRChbFR58oBQEeGSHfAMDT5I?=
 =?us-ascii?Q?xGJr83CGuA93Jux4rbvYXpsLTJRRsSVu/AgaDu7pyFCcX6p6ftRawE9JsQxt?=
 =?us-ascii?Q?Lfz12DYOKkJAW2xef5CCdi8TxNTV5C+VWHeIjngyHPfhws0NXf4BPzjNeKDR?=
 =?us-ascii?Q?yLTxIIpPcasJZVqiDk82ShKTymEkSZYbxjcjF0mKC6cfCIDOYq1qluk7eshh?=
 =?us-ascii?Q?Pxrlp8/srdcNusPKMwWbTSdN72RJveMdk+sV9vqYEJR1fF30fjNw9LEDgBQs?=
 =?us-ascii?Q?wDjEzydzbj/pwhwl05VkR7lb5ziYWltIFtunVhitFmyMCBVxyTo0Ix2IyD/Q?=
 =?us-ascii?Q?oqsaDicpHCWDCZ6mJq8PhIfTAJe88+vgwPWU1b5l6f3ZK5cWeOHr9J0JA1Q0?=
 =?us-ascii?Q?lG6f9j633Bt5/o5bxP0iPMEG/BAoyABXJcsU1Yv2Y0wT3AuMVCgfyWX1yYvs?=
 =?us-ascii?Q?kw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afcd2e45-b584-4b2b-0538-08dbae5a9826
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2023 21:53:52.8626
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pUpxdNlpR1G9q7dKsuEDdIj05N21q39pvRfBuaTXh4xVElpghn89gRnvSNoOM7r+LKiNczx4CYDHkfrCqsGRTA==
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

More careful measurement of the tc-cbs bandwidth shows that the stream
bandwidth (effectively idleslope) increases, there is a larger and
larger discrepancy between the rate limit obtained by the software
Qdisc, and the rate limit obtained by its offloaded counterpart.

The discrepancy becomes so large, that e.g. at an idleslope of 40000
(40Mbps), the offloaded cbs does not actually rate limit anything, and
traffic will pass at line rate through a 100 Mbps port.

The reason for the discrepancy is that the hardware documentation I've
been following is incorrect. UM11040.pdf (for SJA1105P/Q/R/S) states
about IDLE_SLOPE that it is "the rate (in unit of bytes/sec) at which
the credit counter is increased".

Cross-checking with UM10944.pdf (for SJA1105E/T) and UM11107.pdf
(for SJA1110), the wording is different: "This field specifies the
value, in bytes per second times link speed, by which the credit counter
is increased".

So there's an extra scaling for link speed that the driver is currently
not accounting for, and apparently (empirically), that link speed is
expressed in Kbps.

I've pondered whether to pollute the sja1105_mac_link_up()
implementation with CBS shaper reprogramming, but I don't think it is
worth it. IMO, the UAPI exposed by tc-cbs requires user space to
recalculate the sendslope anyway, since the formula for that depends on
port_transmit_rate (see man tc-cbs), which is not an invariant from tc's
perspective.

So we use the offload->sendslope and offload->idleslope to deduce the
original port_transmit_rate from the CBS formula, and use that value to
scale the offload->sendslope and offload->idleslope to values that the
hardware understands.

Some numerical data points:

 40Mbps stream, max interfering frame size 1500, port speed 100M
 ---------------------------------------------------------------

 tc-cbs parameters:
 idleslope 40000 sendslope -60000 locredit -900 hicredit 600

 which result in hardware values:

 Before (doesn't work)           After (works)
 credit_hi    600                600
 credit_lo    900                900
 send_slope   7500000            75
 idle_slope   5000000            50

 40Mbps stream, max interfering frame size 1500, port speed 1G
 -------------------------------------------------------------

 tc-cbs parameters:
 idleslope 40000 sendslope -960000 locredit -1440 hicredit 60

 which result in hardware values:

 Before (doesn't work)           After (works)
 credit_hi    60                 60
 credit_lo    1440               1440
 send_slope   120000000          120
 idle_slope   5000000            5

 5.12Mbps stream, max interfering frame size 1522, port speed 100M
 -----------------------------------------------------------------

 tc-cbs parameters:
 idleslope 5120 sendslope -94880 locredit -1444 hicredit 77

 which result in hardware values:

 Before (doesn't work)           After (works)
 credit_hi    77                 77
 credit_lo    1444               1444
 send_slope   11860000           118
 idle_slope   640000             6

Tested on SJA1105T, SJA1105S and SJA1110A, at 1Gbps and 100Mbps.

Fixes: 4d7525085a9b ("net: dsa: sja1105: offload the Credit-Based Shaper qdisc")
Reported-by: Yanan Yang <yanan.yang@nxp.com>
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/dsa/sja1105/sja1105_main.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/net/dsa/sja1105/sja1105_main.c b/drivers/net/dsa/sja1105/sja1105_main.c
index 331bb1c6676a..3f17c17ff636 100644
--- a/drivers/net/dsa/sja1105/sja1105_main.c
+++ b/drivers/net/dsa/sja1105/sja1105_main.c
@@ -2150,6 +2150,7 @@ static int sja1105_setup_tc_cbs(struct dsa_switch *ds, int port,
 {
 	struct sja1105_private *priv = ds->priv;
 	struct sja1105_cbs_entry *cbs;
+	s64 port_transmit_rate_kbps;
 	int index;
 
 	if (!offload->enable)
@@ -2167,9 +2168,17 @@ static int sja1105_setup_tc_cbs(struct dsa_switch *ds, int port,
 	 */
 	cbs->credit_hi = offload->hicredit;
 	cbs->credit_lo = abs(offload->locredit);
-	/* User space is in kbits/sec, hardware in bytes/sec */
-	cbs->idle_slope = offload->idleslope * BYTES_PER_KBIT;
-	cbs->send_slope = abs(offload->sendslope * BYTES_PER_KBIT);
+	/* User space is in kbits/sec, while the hardware in bytes/sec times
+	 * link speed. Since the given offload->sendslope is good only for the
+	 * current link speed anyway, and user space is likely to reprogram it
+	 * when that changes, don't even bother to track the port's link speed,
+	 * but deduce the port transmit rate from idleslope - sendslope.
+	 */
+	port_transmit_rate_kbps = offload->idleslope - offload->sendslope;
+	cbs->idle_slope = div_s64(offload->idleslope * BYTES_PER_KBIT,
+				  port_transmit_rate_kbps);
+	cbs->send_slope = div_s64(abs(offload->sendslope * BYTES_PER_KBIT),
+				  port_transmit_rate_kbps);
 	/* Convert the negative values from 64-bit 2's complement
 	 * to 32-bit 2's complement (for the case of 0x80000000 whose
 	 * negative is still negative).
-- 
2.34.1

