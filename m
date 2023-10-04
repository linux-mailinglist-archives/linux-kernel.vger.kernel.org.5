Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 184207B7CB9
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 11:58:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241774AbjJDJ55 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 05:57:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232909AbjJDJ5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 05:57:53 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05olkn2075.outbound.protection.outlook.com [40.92.90.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B00783;
        Wed,  4 Oct 2023 02:57:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GkRD33xr94kopdDrEF1lLbyj70A9Qgfwkxif+EGLVVm4KqP1Fu4VxDJK8+cMxyFbAuWKsdt/lSlbcb/VfmOz0Ry2G33rIElP77Liq9mdcH/WhS3DkGLe2LOig7WC+7NJVn9FR4Ttpr4qxFrDTwHi2YdXmswCLLCC7sjav2/boOV20uNHVTpjmMbGB4rO1n6qARoAcY0EK/y70ZLF3pEBlyB4phCLqtFwFZT8xyODUYojnjsOL44XAB2Q7WzvBZ4GH2/3ymHzbDQsVGbusc26ElWy7JzM3b9HxZcCPEmMF4yGxLdlMoT2Hexr4Y85PU241QcsA6iX7jdIH9c9KA0l2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uNk6NQUIbYPXsu0dxUDujzTk9E+ePG5ojRdm0r6gIuQ=;
 b=d3EnaXpElcW3ZfpDnNny6rotsJvIWPEtAdEewm9QtsILHhzYHy/YieS5pKoJ8jFhj58zpmy1/rtx+tcXwxjefKBMC8tDR33kx0AbCPc+D0UdSSbdw/ME1X/CJ165tp2E9DfLXfEpsnCOBuPvcJYHtJnx8NJUd+m6O8PVNsu/Hv88rZSWr2X+9pY83HHsUeS+0nahmtmVoMJbl6uCDDZ76WoZ7DDEnrmvi2MraTCGhIWh97hAh1mDh7QKqIaeJBwzxGTTcMzZeA9F9w452vzfBL9E1KaDu0oxWJvDXXOz2872PqQQT1C9N0ojFQ8rJcyU9cDBhPRZs14KdkbK80xKpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from AM0PR09MB2675.eurprd09.prod.outlook.com (2603:10a6:208:d3::24)
 by AM0PR09MB3585.eurprd09.prod.outlook.com (2603:10a6:208:18b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.35; Wed, 4 Oct
 2023 09:57:46 +0000
Received: from AM0PR09MB2675.eurprd09.prod.outlook.com
 ([fe80::b4c3:964f:93ac:4b0]) by AM0PR09MB2675.eurprd09.prod.outlook.com
 ([fe80::b4c3:964f:93ac:4b0%7]) with mapi id 15.20.6813.027; Wed, 4 Oct 2023
 09:57:46 +0000
From:   Paul Geurts <paul_geurts@live.nl>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Paul Geurts <paul_geurts@live.nl>
Subject: [PATCH] serial: imx: fix tx statemachine deadlock
Date:   Wed,  4 Oct 2023 11:57:22 +0200
Message-ID: <AM0PR09MB26750E782F81CD447058FE7D95CBA@AM0PR09MB2675.eurprd09.prod.outlook.com>
X-Mailer: git-send-email 2.20.1
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-TMN:  [Gwl1f/sRzpQIlRyZ4usHrZvt0oPKC1kAJspCMATHSs3pR9v85oDzABVsyub8L4c4]
X-ClientProxiedBy: AS4P191CA0039.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:657::24) To AM0PR09MB2675.eurprd09.prod.outlook.com
 (2603:10a6:208:d3::24)
X-Microsoft-Original-Message-ID: <20231004095722.3083-1-paul_geurts@live.nl>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR09MB2675:EE_|AM0PR09MB3585:EE_
X-MS-Office365-Filtering-Correlation-Id: 4360296e-620b-4187-1c46-08dbc4c05c2f
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eJnSjbvZLyvd2L69cQII9KTPBZu5jkZ+QAorh5cByU29CiaGvgM4vJQXo0WCRmwa8vWS5VjTBH8sH5mvSgb8XCAXC5weoYCZZ+bcKsLJGO4LJQ5x1YxIb7X2rJ2piX/HxKapG96MHB2LUQ9lBJczCGZI1vpYk0ase+QqcdqkzibCZSBoqELMYWG0C8Bckrph6hoE2QLu99InMliqfOCPNZwfaYR/X56SavM51zIRBo8yQ6wzUw2l71WkgWIcM05L5Cd2m2ODRT17J+o1Lo7h/Al7aklvzzfTxNVTLTSAABS/Njes2+yQw2lwkSnqoaeVuajLyTJRSE9Gq27u3WejiPAKhpWGVY1rHymtfjbyAikmOqQ6po86i8JpLwgkKA/qRH1K537fmWi/5E1DFa+4sf0S3zftY9LbVKV+VNiYO+/BV45x3J2CW/WSAZMJOKuDJhzxRkM8Vcv9OA47bjf8kx8YimiVNQky4e5KiOOTQnC5H7CCoxAeG3sM/qhIGhv7ARS0h492EkX/y42rP7rQAz63o4aWt1gqQvyc8rOVAOBdgOJsIN/gWUkVVEi+j9SMr7I+OCJHWsXs6hsn7ZIh1Apwbq85KaPzD74FcZGxXTRjPfzkCw8nvVTcp3LKnZna
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OSF591OI80e5QgUDtvqQo1SqW08WQWE4rWx47b9UmIakqiPunTpfEbEGYSPR?=
 =?us-ascii?Q?0swFoYvEA6ClTHqtV64e0oNk5DOUu+iQxK8PWPx5EsRQhmnnKW8loC3WWvgM?=
 =?us-ascii?Q?GcL9MG3GJfeYo5md+R+1WNK/8oNP6SqoP9LResw4cSy9MIwkO9GatZuRgOK4?=
 =?us-ascii?Q?BAT6ejOkKa7QIT3FQ81ftnOK4/IkdzwEX4fPJY2FcB7bOAA9Sez0KhPFqv6p?=
 =?us-ascii?Q?yGFqgjNT8qaQu4OfZMQBW7fKUhR1Vy2qklhKcd7AysyAkZg+TVtGUi5xA2+W?=
 =?us-ascii?Q?AXbJlpuEmHW35bHDjFVfjqUITNHDSNxRg14ZCqUmperGLLhWYqXOEo6bOjfn?=
 =?us-ascii?Q?cCSRWZXTy0JglzxQ8+mEr4V66R9FBTm5XdKvS8k+4UnmGNcUxkxcVo1eHBlW?=
 =?us-ascii?Q?yCqajkzvPx2bo+xkU1MVN51N8N8iTX6Jk773aASg3DxyUWvbHaGp4IzKlGOB?=
 =?us-ascii?Q?+zSc5mbZ1LjrsBWeYMiYiqAB3EBqQiidtxp79EanHvwqASKNRp6donRkrLk3?=
 =?us-ascii?Q?ISc7T9PNsikTHfVCTnpSk3LdFKX++PnnVOw88t/wWwTSOKVIj96UPU0gFuDj?=
 =?us-ascii?Q?MFLYbg7R5938yF1Qh1jNWn14TOHBSZxgxFfNFyw/SczJ/VXYdVNUVTyNwaOu?=
 =?us-ascii?Q?94OpknzJNw91hYPn7KbdfVq/4tX9mFXMcyArb8bwMjRgncJMCW2pio+5wOZq?=
 =?us-ascii?Q?Ba1+z6uHzGWlCdcF3BzmVb37c1ZMjhPcLB6ESsMYGfizvCwKdpWlTvCsFO1c?=
 =?us-ascii?Q?r31+jBnfjH1FSkHFpcWOGCzjMvYWDo2f3xbSjbC8shDbySo6QB9jWGXn+bxp?=
 =?us-ascii?Q?Suj7xJoIzDOqvBVKWEVEczDIZHPjoqUsOGOrIobpmO0RytiA/RBK1ENgeXbi?=
 =?us-ascii?Q?PWigzPX9TvRxuneSzuGSBX9JTiRzhESFpmwJGiiX63k4CcHCwTHCNEafI5k7?=
 =?us-ascii?Q?KdcRgLmNsmDHYOmv9qPOSXxex40iZ/0v5jj7jmKSi/4DsIzYHro49aFrnRWG?=
 =?us-ascii?Q?X7mN/yg2b3IIxb4HLsjxRF82PWdFzY1nLTy444O00c2aDQSVSUJ1HQWY3gCz?=
 =?us-ascii?Q?ncRzmbhg+jBl5wFFAIBrgjpJ96zdR82Ydj2YvQsgOP5o404uNColUoRwtK/W?=
 =?us-ascii?Q?rMVhjbr3EYwn3E6+qyZUsmWPaJAzN6COJIjvVWa3JdrpTGy0gb5wvDAHBQyi?=
 =?us-ascii?Q?7jtFeB0r3WkYY+PwYlSM6L5zPdgT8KA/hRNVATvNXae3kvln10svlls8ipwY?=
 =?us-ascii?Q?9eWkVb1QMdBf6FBPBYHChkBjdf+VTxsTlQgWrin/oQ=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-64da6.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 4360296e-620b-4187-1c46-08dbc4c05c2f
X-MS-Exchange-CrossTenant-AuthSource: AM0PR09MB2675.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 09:57:46.7393
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR09MB3585
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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

Signed-off-by: Paul Geurts <paul_geurts@live.nl>
---
 drivers/tty/serial/imx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 13cb78340709..90a4b7841030 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -421,13 +421,13 @@ static void imx_uart_stop_tx(struct uart_port *port)
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

