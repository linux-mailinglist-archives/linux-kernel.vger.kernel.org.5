Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F4BB7F73EE
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 13:39:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344777AbjKXMjW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 07:39:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230159AbjKXMjU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 07:39:20 -0500
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03olkn2022.outbound.protection.outlook.com [40.92.58.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E79FD43;
        Fri, 24 Nov 2023 04:39:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e67Bpc9+Qsj2Cnd6LW7BiSsiXr8QGtfOR/pMBq2rxWXWUdug/qCo4mk1bz/K2lswr/AJtYRylOdvuF5DNNUlbWONsk5n+FWWdTo+6WLxXGST5oWdmr5QdKwSpL94rgLpiImi33YHUzyY8XHTEa2j+LqWueQAawx9qgHsBomMaA3Y9Dx4WbmutJH22TqX13tvxIPtKaWh6FpVOX6AOF/bSw0O3ta4ykPPE6XTe/ao3PNQ6Ks3Fpt0EVMR5uCii35Ggw98EQkL9RNQctVlFVrCdIqjT2UBRT+JRxp8YlFCE/FbiKuuGDyBTinNY+7Bpc/nN257RTQY7cEDxd8CHur+2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BCym2pgNGtRNpLvmYYpqu7UHj3p9cxqFEEKhS/Q4UoY=;
 b=VTiJtjtdnRxqPw/5SMhKj5fvSISIFvK+ZQzfLhp3ccccnt0618Zr5loy231aBStiKRRPQCjmc8XXSpZJZsixPb9RRPZ5ESC3ys2ZC5FRFo0ZRVq2cnY7VMAusMRlTaTdqLBHMt+R662HeegvVebfWdVdIK5RCimGMsvl9v8Y+IzhJLOFD0rtq35FyGFP6sKd5atrHUaVNFJw7Vi/NsYUEE58ZCUS1t83B9XuV9c/fymyyvRB3not0VkEfqb/Eujqt1W0PnwUhkFY73ixVnitdIr8M8c3NIPGydc2pF9AhTCdWhv/PvUYtjxEClPozZefFNUOg+Iy5FlCM5MncQMHAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from AM0PR09MB2675.eurprd09.prod.outlook.com (2603:10a6:208:d3::24)
 by AM0PR09MB4084.eurprd09.prod.outlook.com (2603:10a6:208:19b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.21; Fri, 24 Nov
 2023 12:39:24 +0000
Received: from AM0PR09MB2675.eurprd09.prod.outlook.com
 ([fe80::279b:7d4f:cf90:e9c9]) by AM0PR09MB2675.eurprd09.prod.outlook.com
 ([fe80::279b:7d4f:cf90:e9c9%3]) with mapi id 15.20.7025.020; Fri, 24 Nov 2023
 12:39:24 +0000
From:   Paul Geurts <paul_geurts@live.nl>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com,
        u.kleine-koenig@pengutronix.de, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Paul Geurts <paul_geurts@live.nl>
Subject: [PATCH v2] serial: imx: fix tx statemachine deadlock
Date:   Fri, 24 Nov 2023 13:38:39 +0100
Message-ID: <AM0PR09MB26751EFD9552DE4ED1B150A795B8A@AM0PR09MB2675.eurprd09.prod.outlook.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <2023100450-charger-disregard-9683@gregkh>
References: <2023100450-charger-disregard-9683@gregkh>
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-TMN:  [tNXReewPVNfurAdwigmvcOoH8u0S2/S9QG74d5vLPiER6Z+/MNTtLLvt0eeGfa0K]
X-ClientProxiedBy: AM0PR10CA0006.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:17c::16) To AM0PR09MB2675.eurprd09.prod.outlook.com
 (2603:10a6:208:d3::24)
X-Microsoft-Original-Message-ID: <20231124123840.5303-1-paul_geurts@live.nl>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR09MB2675:EE_|AM0PR09MB4084:EE_
X-MS-Office365-Filtering-Correlation-Id: f099ee7c-d814-4a2b-f4aa-08dbecea62f1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Cr0J/Md0PGnRegiBK3VZyBCtaaqnmwi6Nl/u4YavlT79V7FtoWxL0IAiG3eUMwAzcxJ6ldYM4qMvacsAFvUlwEwXGJXeawt296Ow0TXLUudE9OAHO9T0MUvQdXPXWxQrj/TuYSmnwXZUFA7t8COczIO9AIviFW7PzFLvZqcVRvMNotmhUuu8PcawqGaB/jSS9Jyss9lOLjFQcnQBv4Gr+Ha+pVWmDDXYVtI/nkX5bYUMka/IXkL8/jJo5hNbqzieY3Kkb2YohaUIiYvVPrZ6L3AAaewJydwhFcBIivJRtO2Z3FhJarkTCgh5MlxfT5Gnr//XQw0lMq/5hTCBEkfVU3Sv2MvGr/swdcldkH5i0pFA9mPY2oTnuxAJiY3HcrlsVB9YfFXzYU/h3LqwI4DC4CJwcEpfmer+gUmRUMmmuU2s6w/bv+u+Upw/6y2H1nH8c5NRHE/guWexGTPvPrNEoOBpPiW1vXLWHF7gPGUd7WYNcdYM6Crp6sFhfPkjP3UYsoj3g4HZa/6Tn1YmjbQzIm+/e0bUDPoSiljLQ8aFar4C+7rTg4dsZK7NNJgUBQAod7sdZx2lmmaEQSsk0A6VkzQ1PXPGb5X/ckaVZpLVGpO+lEUYZG5SKun0kQh9Oc5M
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?P7NPeHp7GojrKkqBgkLOrLJ9hW5sO4QSEPrL5JKuetzhNiF0t8TlnJEbpJYy?=
 =?us-ascii?Q?I+6ro4GRqz3vEcCcxbMTi3sC5cEfa097zWZvK9QQMEZv7najSOG1rEXP1uqI?=
 =?us-ascii?Q?PVA5VDt5o3Skgi4OuTrqZO8ij8hJ5XInxVw3tlohgy4tyOR4DFdM4ugehKZB?=
 =?us-ascii?Q?qV9EUW/1Te0PhL2a3VsdRTOpT6j/WQfLuS+KoD8156lOIkDTTNjqtr0xCIwT?=
 =?us-ascii?Q?mCcf1e0s70qu0lV2HCVDTIkCpXipq3LzE5j44wJtXmErkJeDkwlPBcyhZ2x2?=
 =?us-ascii?Q?17oamJK/CNuae3VHrVPrkeXIG1OJocMV5rD7tUeu6KIxGm20VVuS+WwWx3lf?=
 =?us-ascii?Q?60PQIfCZC3cnLVNXdch6F9ouCtgCxQwmk0qbMio4QhMSjuYbJ11k4EdQTG7W?=
 =?us-ascii?Q?rPyxvADHmCLLGOtlXJMpp+CT0JjDolooUOnhbyyIRYW0xrfgOLGJq9M36yU5?=
 =?us-ascii?Q?8tTiJyUA63g9nvz36qBykAes0nmC0m7GWXrGRaZraA6fp8VqTa/QpwjHei3S?=
 =?us-ascii?Q?x3RwRBmj9iGhYEc5b0bavwMWCThtrFhXXbniRIfAh0nfTlXqRH2Sz0AH1yO7?=
 =?us-ascii?Q?WJpuBEc0RQXeN+pw2qyhd+H3b5wM4Nx4DvMeRX5vDiXDENITZzS4PHiN0cRX?=
 =?us-ascii?Q?Fpg+hC6yDIGbueMU+8MFvXQ+3DPYynxOkkBlZEEoPahTl0u4s3mx16wTMf6z?=
 =?us-ascii?Q?m0hffWR+8LJMHE5ywB+GfZc4HAQ/ifYlwWyjGt864kn+1moOwtDdiLlKDNjd?=
 =?us-ascii?Q?kCx9ZJacdFqUTGo89ROJUFLdblM3EW32LLodMPvuaBEmrokhVrPtlOcmenC2?=
 =?us-ascii?Q?SF8CVpd7O5KC2GVYO+4+X6Nar2RT/MsSjT7+UxDuh46gMeNjSC9YUG0DJqg/?=
 =?us-ascii?Q?ibzpWH3cVDSkZuVuQQ7H4neICkk0M0Sw9te/br4wTTxaHerrXj235fOmhPyO?=
 =?us-ascii?Q?AZOFyIRpb0x+XDZskzwx6jIQRQJWp9PRc/9GM0y/iXjjwDtC9+CWpXMpLcMa?=
 =?us-ascii?Q?WA2dH3cEJ0EjDROURRjui9DgolYm4nMx4eGkj+zj72pc6bwsKQlamZUVGzRI?=
 =?us-ascii?Q?3/rhyrF4ka4ZD6DOkFQ8J024KSgJXoT/CU9zQ3TdFLSXcIBZgFy24Ua10J+p?=
 =?us-ascii?Q?f52Hw9u5JAZUKkPLuiCk3QRqtzXjwn4mIE/5H7cI1aq6z/Kd9Ve7Us14T5jD?=
 =?us-ascii?Q?ESTdynPQnPwIr4101aLKLHowtce7KRZPCmLH+evoC8WlHpZq055B1dp5eoKl?=
 =?us-ascii?Q?uDsaecAu6b5Us9Aj4iAcNcE+Pg9Ulg/Ll1rLCS5LMA=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-64da6.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: f099ee7c-d814-4a2b-f4aa-08dbecea62f1
X-MS-Exchange-CrossTenant-AuthSource: AM0PR09MB2675.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2023 12:39:24.1449
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR09MB4084
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
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

