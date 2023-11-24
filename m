Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1CF17F7459
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 13:55:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345158AbjKXMzE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 07:55:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbjKXMzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 07:55:01 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05olkn2039.outbound.protection.outlook.com [40.92.90.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37F58193;
        Fri, 24 Nov 2023 04:55:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R/Lar9S/xa9c3xQ6ooZrZB+Akrckwp32KyxUc5Z2qiL7gwx61ns2HJ+MkCs7y6ZJZCVtc7QKIGALQoins7AjGVJCDcDmxqFiKTVUAnrVhU/x5ZvMOyLfkAETbAyqy/+LHa0094QCJtSWf0+vnaFfJKcVt2r9nao1yPbGf6MzIJFj5IVkEPqCiHLAoxXM2bTDN87YTULbfD7WlMqLlnvdkCFb7AcssNWyjnrtmqTVLNrmmEJLgG9P4WRY4cBDN5CGa6o678ubhlB0vY16Vi5Zqes8Tsa3fI2OkOM5KK6gx8a7fUjWNVL74rR77izFH9h7UFQxfwii2SGezTxKsLS2rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QGBRIRhdKtgEeatKM6MRByr9zwGxeeBvzcOVc28Iuko=;
 b=HSKBmaSFhXiRUW/7yPX8tAliCB7WpQ1zXNdAoZpsLkYevik3MJ/8sT1u1gtXlAkH4Q+lZ8rC1RViudhy9+2Yl7Ck4UpFZRdeGCTvnEaPdiEk9aO9PYQliuTYrvmPhIeTZidHLVKHk3nykmTmhRpGNefICLdloFiAigGA2KiO1DfHI3DJxT44wvLMuM74GCHUkK6A6j2Nvg0Smfw4mfthVXrn96JmkNoYgzItHDg82aArMqWJ+sniumh0jB1ynmig/mKWum8eEIEHybeo9B98EGUjBSsV530DHPhXixxZDi2oJslYPY5ZutyyLuOxjz4j56SOZuNGH9LfTVxGVF1m9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from AM0PR09MB2675.eurprd09.prod.outlook.com (2603:10a6:208:d3::24)
 by PR3PR09MB5345.eurprd09.prod.outlook.com (2603:10a6:102:178::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.26; Fri, 24 Nov
 2023 12:55:04 +0000
Received: from AM0PR09MB2675.eurprd09.prod.outlook.com
 ([fe80::279b:7d4f:cf90:e9c9]) by AM0PR09MB2675.eurprd09.prod.outlook.com
 ([fe80::279b:7d4f:cf90:e9c9%3]) with mapi id 15.20.7025.020; Fri, 24 Nov 2023
 12:55:04 +0000
From:   Paul Geurts <paul_geurts@live.nl>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com,
        u.kleine-koenig@pengutronix.de, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Paul Geurts <paul_geurts@live.nl>
Subject: [PATCH v2] serial: imx: fix tx statemachine deadlock
Date:   Fri, 24 Nov 2023 13:53:06 +0100
Message-ID: <AM0PR09MB2675934BBFB6E1DA8E0F626295B8A@AM0PR09MB2675.eurprd09.prod.outlook.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <2023100450-charger-disregard-9683@gregkh>
References: <2023100450-charger-disregard-9683@gregkh>
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-TMN:  [BWGTXt8QdPS/08DN25SOwJ92iJ5Gai/bHl3A9XBGuOhIaofzhZ+iMtj5DcWn+7uH]
X-ClientProxiedBy: AS4P189CA0033.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:5dd::6) To AM0PR09MB2675.eurprd09.prod.outlook.com
 (2603:10a6:208:d3::24)
X-Microsoft-Original-Message-ID: <20231124125305.1206-1-paul_geurts@live.nl>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR09MB2675:EE_|PR3PR09MB5345:EE_
X-MS-Office365-Filtering-Correlation-Id: d0564d1c-8185-4c62-06e6-08dbecec93e2
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ajVBa0R4pIP8w2kTOcaVXJAoXFNPsmXN40+btRTFutCzE+SUjBrHqlrGX2QzpW81rKPhUHyY1Y3J1z6tF+C/JYKdjkVyczLKbD2X4FbCQYO2IuEtjXW29kog9zp6dkclKWhtIQ9mgeEr3s3tBWQ3gI3/jIJkbbPsfq4qQ637PsDQbJvTnKtMu2m9CamzMBTULVgya1uGr2WF55FC3zbRJ4E4zJLdg00iYzc1pbVBzFg1tribfBY3tr4B6ze7WG77gdwwKi2m7ybG4UZlS3NTgHaaKZF0yhAIp5oR2hCPKR7dNcT/AxwIH7WH27d27pCpqBoV40b3yR5MTG/C8zAeidp0Mz+W5qHqlcJeUnvgGBL8Sboh0o1Gdjb3iYU0jf/hTRvOlx8AmXf1ItPssjqoz61pSCOMZyzxjzVEM9ZhStlhJY35g0MvjpeF2RkUwuTRqtMkqSm0vT4AxfkLkblTKcAd2fjXMrP/o18+FPVqsgzpebogmdXfg3dRCqBWEDV1y9wFCKJ8DFBkE5n0sk6/O2uwWz9PrdhQjye8E1Rixd0hR70ZWg+pqUk5Fygh6tONkAbN3DB2vf8pOZMKbFAHPMXsP7n4oVxKTTa0Z1UKO4SxhYqmu2nSUd30s0yJVYKI
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pzyL7wxmAR6PmjQy+4vHGh4InY3cFAw/eUKLZzPwqADmDAMR6UCRpiOZkuL+?=
 =?us-ascii?Q?SuT6gZ7cNKENbV4AuIC6AFrs/Cwlv8C+X62JxE1KLUNPYuJLKyBNpfmlnI7/?=
 =?us-ascii?Q?72+2eld0iKZjdbwHFi6RwT/kwQhuGkHduRfggWhiPCCzMUZS0StI9hXffLXO?=
 =?us-ascii?Q?2aejRHwUFYg0wOY2HsQo0tPCyvwvb4E7bGC/wUCbnmYESJM50Xg7E91hiVLx?=
 =?us-ascii?Q?R+RZbvEVzc3ps5x1R89RvVe8uDxkPPSEYzRCO6FWaYgLA+3SYO9YMrraa6Aq?=
 =?us-ascii?Q?84yGHe8msheJzQYmhvuSsXtrlzuK7gti6zbz5+1BRhDMaRNp4BoGjhe1irXw?=
 =?us-ascii?Q?BcuaXc/1kGubZcymj5sx5TjaFXFeaAeDMpqeAoWIGRE1L/h5gNzd18TWdrT+?=
 =?us-ascii?Q?qohSb9b2x3MESYK+Zl0wTS3DlBE6Y4wbGh+W+Rug2XgAp5ZAy296CMjKTW5U?=
 =?us-ascii?Q?uTp9r6G/e2CXepIjnDlG1J0yf9zoYGT8qjojWjm6pQApzdawVFxHk0HJ22E8?=
 =?us-ascii?Q?Xi5oUX7xNUB6WvDKNt091RudqKwitMRtyXvX694mq2EfvZXxyXKxusVAZuLk?=
 =?us-ascii?Q?dHkT8vEq2oIvXuU/PPLCWAE3uMUuh3mcGgzgg4udrEeJKjEmtj6ergCKkDma?=
 =?us-ascii?Q?cg63SmvVe+5E0wNI0tf9YjwGkoCp6/VpA7d8tzofaiY9vTwIIF0+/xAFeeTl?=
 =?us-ascii?Q?ixpzk8KM2ByZhyMeX9EqpeEWTgqfUoeXCdqsBysRF/rZWa8OkshrGTHi1t0N?=
 =?us-ascii?Q?a9Po/PElu1s9OuSidWPB/BKp7Sqy1YYFB0pnUY3KWNAGzi99ltLWJcUGDsk5?=
 =?us-ascii?Q?tz+tXT+nCYfP5w0lGS6wvyqA9Hmv/jgsGAtRUpuGH2vSp/pYuJlpyjlUs3uB?=
 =?us-ascii?Q?VqQPEHYSFG6k5AVAT8oQCSdEb7WAyG6XFJTsFMNZlJvOEyTuQC+hxnLZPNMx?=
 =?us-ascii?Q?5aKiOx4eGSigf8mZkQ12/faRYpmk18Qu9yqCrvwNU/J+gVbSlKPVjwTWVcoS?=
 =?us-ascii?Q?1rgDrl0pGgpv4o4h3lE0cO9dEHK98UYtvGZVPx/4lV6nRqCZWvnptpLggnV/?=
 =?us-ascii?Q?0pJyyAZn+WS26hsD9gFzvGCX3FVIaaP8erk0u5T8qWdWZyjq0fgqT1gL/CGc?=
 =?us-ascii?Q?8vDDOuvrTV1+5gCbOGHksDnaDPE1CuNsjsvTMLCB8aXGSeUX74tNVC4iBloj?=
 =?us-ascii?Q?fTc3Ie3UqdUHCKHGuCZNAEX/w7ug9eD6Z1Jit65SUxDxU+hqHrz4Gzw23yTx?=
 =?us-ascii?Q?/0906epzAZ2iU801Ne+26VblHBVhgjyfXKP5iMVK6A=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-64da6.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: d0564d1c-8185-4c62-06e6-08dbecec93e2
X-MS-Exchange-CrossTenant-AuthSource: AM0PR09MB2675.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2023 12:55:04.6173
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR09MB5345
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When using the serial port as RS485 port, the tx statemachine is used to
control the RTS pin to drive the RS485 transceiver TX_EN pin. When the
TTY port is closed in the middle of a transmission (for instance during
userland application crash), imx_uart_shutdown disables the interface
and disables the Transmission Complete interrupt. afer that,
imx_uart_stop_tx bails on an incomplete transmission, to be retriggered
by the TC interrupt. This interrupt is disabled and therefore the tx
statemachine never transitions out of SEND. The statemachine is in
deadlock now, and the TX_EN remains low, making the interface useless.

imx_uart_stop_tx now checks for incomplete transmission AND whether TC
interrupts are enabled before bailing to be retriggered. This makes sure
the state machine handling is reached, and is properly set to
WAIT_AFTER_SEND.

Fixes: cb1a60923609 serial: imx: implement rts delaying for rs485

Signed-off-by: Paul Geurts <paul_geurts@live.nl>
---
V1 -> V2: Added fixes line to the commit message

 drivers/tty/serial/imx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 708b9852a575..ad36c49c7898 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -415,13 +415,13 @@ static void imx_uart_stop_tx(struct uart_port *port)
 	ucr1 = imx_uart_readl(sport, UCR1);
 	imx_uart_writel(sport, ucr1 & ~UCR1_TRDYEN, UCR1);
 
+	ucr4 = imx_uart_readl(sport, UCR4);
 	usr2 = imx_uart_readl(sport, USR2);
-	if (!(usr2 & USR2_TXDC)) {
+	if ((!(usr2 & USR2_TXDC)) && (ucr4 & UCR4_TCEN)) {
 		/* The shifter is still busy, so retry once TC triggers */
 		return;
 	}
 
-	ucr4 = imx_uart_readl(sport, UCR4);
 	ucr4 &= ~UCR4_TCEN;
 	imx_uart_writel(sport, ucr4, UCR4);
 
-- 
2.20.1

