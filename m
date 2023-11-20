Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86DB07F1452
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 14:23:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233238AbjKTNXt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 08:23:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233196AbjKTNXc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 08:23:32 -0500
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2130.outbound.protection.outlook.com [40.107.249.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE5211BC3;
        Mon, 20 Nov 2023 05:23:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sd4OxwXx72ihTChxa3iagzAT/FYESLFSRmjqHZ7OhpDttnKZjJtW+gEvzRkDYvcniJ9HmQ+UgOJLIvgRczuozwgWWitBLk6wFcCTYZeM9yO+/Q9uvqEGkLtyoBFb9OieoYacEhCu2oaC/UDhw8Ne5axgMy5dOENe2PeSlkjYi/7bWU4HF+2IO+YWX5ydQ3RMuBu91Z0RAqv/uNzptoRfnVS+9FeHA7Fe8/0GNePoqtXXyDkd41o2fipWPAmas4rj2GRAy4FShfygt1C40db8QpiGhD3Po3/xc2/BrceR6CqfAWDBsz6QFwiQAMwcqY0+c7OG7mwMj9P/cUgGPQ3uuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DmzXDeBo+XDchVJ8hCo0/DZ8bunhflc21u3s4OEd9sI=;
 b=NLJixvZj+CS7Viwxr0p6DN0vRmZ8zoFoJYZalVBCk9ivfR/vrzeKKiTEARnMFc3UeYjJGwyev+LSMDZqRCDnEmtJ78qTUxXlKaZEUJX5BT8B/yVxOTN0EEB+i+iodlue8/GP++71IiFcOvBydcvUD/HJa6sthf/KOeFrQXSCbYQRKLTyLj35oifk+8MouBb1oZmB8cVDJyBRoq+k03HOIU+LuITjPpi5izxFmZHTKXrIO4MxD0766SNbxP3PHKIJ2KvF4drLPwwy/MIs8qFedCS6IyclvLFH0e9Nn6XeGpkRywI0Elax4MW4gxjHrXvtghADwPwErinNC6momM/zeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DmzXDeBo+XDchVJ8hCo0/DZ8bunhflc21u3s4OEd9sI=;
 b=GJbNa47V6+Tz0HXSJeseNYtc85w2XpfrFiWktQUdTugWwsX/mvNiqt2SmeQPHh1jnEhA5F+KeXvPEhC3L2MTJ9eJpX54fyQ0+DCMlKrOGGtClknr8HlXfQjCD6B6sap3QuX5tmwJ8nDro1uKbZWtW4ZkFmYc7y/EWgvjuUI+b8c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=prevas.dk;
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 by PAWPR10MB7176.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:2f2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.26; Mon, 20 Nov
 2023 13:23:07 +0000
Received: from DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8bd9:31bc:d048:af15]) by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8bd9:31bc:d048:af15%5]) with mapi id 15.20.7002.027; Mon, 20 Nov 2023
 13:23:07 +0000
From:   Rasmus Villemoes <rasmus.villemoes@prevas.dk>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] serial: imx: also enable Transmit Complete interrupt in rs232 mode
Date:   Mon, 20 Nov 2023 14:22:56 +0100
Message-Id: <20231120132256.136625-1-rasmus.villemoes@prevas.dk>
X-Mailer: git-send-email 2.40.1.1.g1c60b9335d
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MM0P280CA0040.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:b::11) To DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:10:45a::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR10MB7100:EE_|PAWPR10MB7176:EE_
X-MS-Office365-Filtering-Correlation-Id: 33395abe-c967-4072-2730-08dbe9cbd5b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mVuKI/OUadO5/7MxdZMQU8a5s9/kQB7899xO5/qZzSPA/pL3vGY/rL2yNezqXVnAx8bNxf6XL+VO00KY39lk9UOdCbhfkn+XsSx89dSlvhwCzRa0ZlJ1RNQQNrQiXTQ39WZ5W7Svj8/EqBthtoVnv0KVwchqUmpWHWFDO4srvDmRDZON/SCZ/iZiYPqJEBuYskAVW2rVXD00jP7b0xrAS6/AMCQ6zdogQT/ZLfbYpAWmgSief0USgolsI/WNvJDMEjXfv+rhGUG5GiMUwUwz+FFoZoJTydpBtyCH8o/7Hv63k+6+JBe7MREgIGMMY2u2MR1PsgS2JOhIsT0muhNrQj8l94naZwy/gI6XbD+hTrt+hI59uc/4789tilTeVSZ1VITWL3+09/wk18ssicc7ZlVB4DFVXD9wznqa+/7sxLnqhJccHGIhKg1/e8Oo7+Cjgp5f/aDh86R7ajFjPuszemHBUDquM8Gx9ub8eTvT6SRo0VN1/42Cxt7+xWfo4nd/dWXCpbRFviYSjlEw5YI7Jxfy2IuqH56Bv7EgbYkQl4PmBgv3dEt60Ibfn23Ej9StPotuTNeH3Nr1v/zte4v8yOaTgbkOaqUjCCw+zfKWTzp8CBkuxJ2/y/g5AHAx+g0d
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376002)(39850400004)(396003)(136003)(346002)(366004)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(41300700001)(44832011)(36756003)(5660300002)(7416002)(2906002)(86362001)(38350700005)(52116002)(6506007)(6512007)(26005)(2616005)(1076003)(83380400001)(6486002)(478600001)(6666004)(38100700002)(110136005)(66556008)(66946007)(4326008)(8976002)(66476007)(8676002)(8936002)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TE85S6ss8jTrHmrFfn6fNxsc7pHA/7eD4KDXAfVP7TK0+QxtR2onF/kE7PBj?=
 =?us-ascii?Q?UI8PbKw0OcCOEO2KYgmkF2+T6pGHImMHsVjynqDir/ZzbU7ET7qEp5AcSFqC?=
 =?us-ascii?Q?X59T5VPtBE2SBqQJwi/FG6iN7o+8CgSn2ABJZ067ID16QZsc9+mulIv1+jlY?=
 =?us-ascii?Q?b0VS2OhUEH2TFIjUeeG2u8HhgQ9Sm/uEq1pVtPV4ROZ7/uy3nNlbHBs8CBv9?=
 =?us-ascii?Q?Y/x/fT1S9ELC/Xp+agu225R9vR5Hxr5IoqROOtUkrzHhZ0CAc2MfzusadryS?=
 =?us-ascii?Q?iw3AVtnGe0QJOvp5DveDARMAju9D+ohr64po+KspLlSH15uliTsb2qCfetUm?=
 =?us-ascii?Q?MaduJDnTZn3+glcjUGVtOkTE2zypf2B8Ho/IG7NpCqPjrL9asJflQWnvvyIF?=
 =?us-ascii?Q?WeKHJzfaXoiSFz/npo9ldsx/VlPfWcpmShKoEfw1aKgiHgrBMC7OapocByzo?=
 =?us-ascii?Q?ySiVbhW3I1ioV98dZXDNq6+8cXaC3RcF3xKqHfI56xiueY+N3lDTwMhY3W+T?=
 =?us-ascii?Q?JYtqUb3ZQUCz8WG9VunDi6mFmYyC6Smi/OHyQlNbLQcsX2RYnblhv66LScqd?=
 =?us-ascii?Q?vjXJ14vapIq9B2CAe2c+WIUgTx8rYGMVaWAjzd96bx/2RgSCaZdGWJozSGmj?=
 =?us-ascii?Q?7SnYE4K6p5u5XMlNsULcxDbXhZw/Nsz8WDdSCdqgi8PBgEjaA517PQB8LwqK?=
 =?us-ascii?Q?MMrpt2D8hEII9JJwpl2dqK09HAxoeRAw3gjxyppXjWyIsUVToywYsTtRKCK8?=
 =?us-ascii?Q?YWDkI9/THFVVIXlJ9ok09DX7XbeRmDut2sQHvrYHxntE/A2Iy7b8QIC18bDu?=
 =?us-ascii?Q?AZtVP7c4LlRlACYI9gugtu1SLP+YVs3zGr4fLKZWEYRRw5LC/lYkOE9Q24vE?=
 =?us-ascii?Q?VVzkB1+9+1tML0C7pG/2AMh0kmjHxExYpqiVBvbSe6djnqVLjkGivKu/GOmn?=
 =?us-ascii?Q?1GI0wot3ka+GnNEyj/QHlqC3/Jf85M5hZVNZ7+FOXg0AssnQSRElbDv/rocD?=
 =?us-ascii?Q?JanQBFO52/A4ekHtZAhFMW5M2uIzw/dWkRcECYhL1tDMG4zcUQuO0mOiAqKB?=
 =?us-ascii?Q?VjgyRsy8Gnf6ispGkCePH2VefXqd+kvjD9BjrlIHUNwzlof1JBDDMbjCg1mf?=
 =?us-ascii?Q?cpiobqzT1zmzkMXAGnBxMwpXtrbmMVJP9Ex5j9HLzqFiElYxlcG4L3lGGPsE?=
 =?us-ascii?Q?3RXCuT+YqKuh8+zz6fqk2uWkfjD5m8vqPXXXBlEtBPpbE4BjqRAvC0QHSmKw?=
 =?us-ascii?Q?oZ2MRhbgfrUz1ASxxP0d7mml54JiEbSkfttGF6mcfHu3pP8BXuSG9VgJe7WW?=
 =?us-ascii?Q?+FFb5a2JlsEGvxQRxYD2fbXlPWUjzXcfpd11W2DrO6C/kD0D2Lgct0AYby2X?=
 =?us-ascii?Q?4oc6GiFBkdZM4VznjCyWr7qtnZh3TbQ+02T/UMYWogcPSbNQNQgQMz8Tb/cS?=
 =?us-ascii?Q?8E3kJQt1Q2ug02pj41NlfTxrOOY0+DyZP38FeJxEKWm2YqZlu8aJq5f8RS1V?=
 =?us-ascii?Q?vyg4Mz6U+J52HH3Pk9gKnRxkxq7LQcPwy7wLQdDEDKa+AdVnWeC8OjF/iXeJ?=
 =?us-ascii?Q?1c2sGeb4LZUhHrP5TckNQXu2y2eFA5PsHb+IwtZie7ThHIYBRTZ54OEv+43n?=
 =?us-ascii?Q?8Q=3D=3D?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 33395abe-c967-4072-2730-08dbe9cbd5b2
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2023 13:23:07.7447
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nZfvnRJffkL2+1hoWQpjQaoIau6G8iPWhIotiAX6r7Je/shog72LftUW/UJoDp8YpMEtrHS3VJgIeZOKGG9CxNcqFW2Fw5/TxVN8YIxKLDA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR10MB7176
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, if one switches to rs232 mode, writes something to the
device, and then switches to rs485 mode, the imx_port's ->tx_state is
left as SEND. This then prevents a subsequent write in rs485 mode from
properly asserting the rts pin (i.e. enabling the transceiver),
because imx_uart_start_rx() does not enter the "if (sport->tx_state ==
OFF)" branch. Hence nothing is actually transmitted.

The problem is that in rs232 mode, ->tx_state never gets set to OFF,
due to

	usr2 = imx_uart_readl(sport, USR2);
	if (!(usr2 & USR2_TXDC)) {
		/* The shifter is still busy, so retry once TC triggers */
		return;
	}

in imx_uart_stop_tx(), and TC never triggers because the Transmit
Complete interrupt is not enabled for rs232.

Signed-off-by: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
---
I'm not sure this is the best fix.

At first I considered doing something much more targeted, but
definitely also more hacky: In imx_uart_rs485_config(), if switching
on rs485 mode, simply add "sport->tx_state = OFF;".

If someone has a better suggestion, I'm all ears.

 drivers/tty/serial/imx.c | 24 +++++++++---------------
 1 file changed, 9 insertions(+), 15 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 7341d060f85c..ffee157e13cd 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -708,25 +708,19 @@ static void imx_uart_start_tx(struct uart_port *port)
 		    || sport->tx_state == WAIT_AFTER_RTS) {
 
 			hrtimer_try_to_cancel(&sport->trigger_stop_tx);
-
-			/*
-			 * Enable transmitter and shifter empty irq only if DMA
-			 * is off.  In the DMA case this is done in the
-			 * tx-callback.
-			 */
-			if (!sport->dma_is_enabled) {
-				u32 ucr4 = imx_uart_readl(sport, UCR4);
-				ucr4 |= UCR4_TCEN;
-				imx_uart_writel(sport, ucr4, UCR4);
-			}
-
-			sport->tx_state = SEND;
 		}
-	} else {
-		sport->tx_state = SEND;
 	}
 
+	sport->tx_state = SEND;
+
+	/*
+	 * Enable transmitter and shifter empty irq only if DMA is
+	 * off.  In the DMA case this is done in the tx-callback.
+	 */
 	if (!sport->dma_is_enabled) {
+		u32 ucr4 = imx_uart_readl(sport, UCR4);
+		ucr4 |= UCR4_TCEN;
+		imx_uart_writel(sport, ucr4, UCR4);
 		ucr1 = imx_uart_readl(sport, UCR1);
 		imx_uart_writel(sport, ucr1 | UCR1_TRDYEN, UCR1);
 	}
-- 
2.40.1.1.g1c60b9335d

