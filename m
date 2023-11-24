Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB6F67F74A1
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 14:13:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230480AbjKXNNZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 08:13:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230481AbjKXNNX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 08:13:23 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05olkn2036.outbound.protection.outlook.com [40.92.89.36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA8E110F4;
        Fri, 24 Nov 2023 05:13:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lGHV398egOQH9Kwm5/xiEVfmpJIY+LEoOJlkktHPKsn1HHVPRszU2J20IdywT2RxXvEkwxaXX2hf7PuQyzRCh+R5r7QlwZtdK/iFB0SNuoR8o/rKbORI3fN5suokBnIrcvfh1B4IdLFHIRnaGw6FuF2gb61bJ36pDfSsQUPlSIJlNaKH3ht1Hl+EvcJme2sIyz2Pfp1yCzlqO4kg8iZvkEDliwYXrLC0BYB1pM0KOLfUm2ong/3f93mhywcQKJWEI+X+3ylFhdkS/+2+pNrZ0THj09c8yMw6TIwXsSWpdN3i4qE6sHQrt6WTnBYvMTgi2ZClwl4rrDvu8GJQhc+Ggg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wORcN1y5TvWwAqXkgRb+L3nWL7avJ155M6Wo+iW9YwE=;
 b=G/6jACZPY7JMyiGPsJbNtsvYixOSGpr0a99RF3vIcmJMvspOFd0M3/3SaIvzd775o0mdX5T99AEUfZAeeLK0eff9sxKHm1vVBp7Ps/UyHWGnHnuqWZWPpgtGp9UMPrGz/P9F/uM5mytBfhR5tPdiWXYZO7vZRLIe+u0o98J6FLRITluEzVmKSCDIZn4xqNeDtrPbK6iim9HUfuOX6AOUpYrSzfAq/isXJGKKmKxX8pM0qRuDOBz/gtUSrp8wL47KmvdGN8J9FiOYVcfI5C9wx5MoPEU3tF3ImU73NgvfixQqCD+OoObseiv9nnSkcZOOeZkiq9GOjl9GIvV/7CFs1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from AM0PR09MB2675.eurprd09.prod.outlook.com (2603:10a6:208:d3::24)
 by DB4PR09MB5846.eurprd09.prod.outlook.com (2603:10a6:10:38e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.20; Fri, 24 Nov
 2023 13:13:26 +0000
Received: from AM0PR09MB2675.eurprd09.prod.outlook.com
 ([fe80::279b:7d4f:cf90:e9c9]) by AM0PR09MB2675.eurprd09.prod.outlook.com
 ([fe80::279b:7d4f:cf90:e9c9%3]) with mapi id 15.20.7025.020; Fri, 24 Nov 2023
 13:13:26 +0000
From:   Paul Geurts <paul_geurts@live.nl>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com,
        u.kleine-koenig@pengutronix.de, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Paul Geurts <paul_geurts@live.nl>
Subject: [PATCH v3] serial: imx: fix tx statemachine deadlock
Date:   Fri, 24 Nov 2023 14:11:10 +0100
Message-ID: <AM0PR09MB26758F651BC1B742EB45775995B8A@AM0PR09MB2675.eurprd09.prod.outlook.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <2023112434-winter-embezzle-1b46@gregkh>
References: <2023112434-winter-embezzle-1b46@gregkh>
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-TMN:  [hYXXTl83W3wx5TcUoVLT/S8JRH1/v5N4BHXui0xwimC9zlgCpCjtEW5EMqIjy9ya]
X-ClientProxiedBy: AM0PR01CA0179.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:aa::48) To AM0PR09MB2675.eurprd09.prod.outlook.com
 (2603:10a6:208:d3::24)
X-Microsoft-Original-Message-ID: <20231124131109.2585-1-paul_geurts@live.nl>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR09MB2675:EE_|DB4PR09MB5846:EE_
X-MS-Office365-Filtering-Correlation-Id: 22e98dd2-fcc8-4c88-63c0-08dbecef24b3
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Syse0jgtE/ibMnbrGUPXWGfjfRT9Ogzg1zqchoVZG8i8d821clhkQ/6xz8Z6iwmkBIFo+XzwgvnsvaNRXNg2sOFd+5FttDKv2IuKXJ+wLdq3AqdxQGzbEyxCNNSXVdh+vFEVK6me3xB6aIs3QhiBcFw8bfsAdPjtL2ob6PPLdwRXNwK2BIBp8uPARDxtsAikG4ru/ACrRhP+ekRxi7zf4Eg31FQtmK+jZZQjKs2yzwSJoDKiRS8zVBDNxm4Zxq1Ib1MkWC4NfASDpa8IBTTyykKlsiyLJFhSOT+MWh/07EjYXniq6pUKSlDSTQ3+UkoFrOdWpPCVsizwqDmmHLCtGMrGA8gruen4aLICGyGJh1Hbsfm+kLpwlGsFZMJ/yoFbMGXSkonLMv6K3EjCPC3B3JOpMjZ6WFGlmBYE8ibGkfHxvCQAbbk9myKY+n/6LsrfJIFI4IDZlbwWcjD48zaqTCfqhIxclwYS8lW8FNK434+20oymjl+QCktd3xHpdd8cMOMAv9x//KwpuOchjpFR/l7J26ct3TKqXuAIGjbgNon8CIKzbnqLYmImvRxxu26uSi1njjMZAA1RZcRf4XQM02YJEut6IfILOj+nx/LT8bK+3hsAtNRqNDkAHncnPQ3E
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gLxFaC9LCYkRPcJmJ+nu9Ibn4y+lEPQxzM6fVEeUfP23EeY3ON/X9Qhjv/KQ?=
 =?us-ascii?Q?MZeDusd54oW37e9efbygXQZSd5ahL8C/9oMHJXVS3aVEjm/irFdJfS5J+BpW?=
 =?us-ascii?Q?jVZnk62JcQgwBab3o2yqE2/CHkrwbK1HEQA31mUlGaVFfrbKpSeXp9ZkXlnY?=
 =?us-ascii?Q?556S+SoEzGn+xQB+OswSXVfWzK2IjrXZrqvnoQ8bdUNsdDAa4Nu5D8yawGYT?=
 =?us-ascii?Q?+Ty7vr2kb0Q6sgrX63ZVAGYTYUHl53hIomCiNvU5zY65dk8ndfjx2NR+X/jQ?=
 =?us-ascii?Q?dg6G195o60w3ggnCkVihkTKeCN/xdiu0SHpV7HUD1zAFO4e3s/Hm7cNkstY8?=
 =?us-ascii?Q?mP5kKSxxq3v3CfdfXpHTmBwaYN6fxT+pfTcv2qhEj6ukEBRD7Mt98za+SK7I?=
 =?us-ascii?Q?uP4+7dX/xiXm8EE86MpZNJiKEZmM8FMtLbj1bh5uZBRTQM1cy1X0yRRhEToc?=
 =?us-ascii?Q?cmKj0WQuN+AKzqeWSgwUNwzh0eNRix5nmqp2OyEIVmpmZC5xTXbLBe4763KS?=
 =?us-ascii?Q?t5XYblWzwlT8Q0db0GtvmQr0EBsw0P5IO4LCoDjrcyvtlc06LT05VEJAhMRV?=
 =?us-ascii?Q?mb3/eaPGcJwYhGq1Y+iznZ62RONx99tvRvgrUTOobKcRvccQ/5LhdSt2IFm4?=
 =?us-ascii?Q?PlbH/umvEF496DsT7p+wu75yu+FsLaEI/+0+Gz02No1MSN+8NgBiRyJRFug4?=
 =?us-ascii?Q?Am6+AuAW0rb4p7zoPL0h1+s4oZxPoOVsT2Lo5cnZ8yeH4dg4GpmYeyUNbUKQ?=
 =?us-ascii?Q?2Vg3vdYy4UXpQwnZvN0m6wyKrnbFPzMx4e7fgPCFj7X4814/bRVrlIISbhWL?=
 =?us-ascii?Q?I30KlvfE3f0spuPKV6TKXmYqmxWIXRMagwQh1vddSW5jKI+2+KJNjhUJi7qb?=
 =?us-ascii?Q?mAClaTLMUj7XRvYm4l90bDrEwAvQoC2njnGW0CYMErFgOlDz+636X6hCrMss?=
 =?us-ascii?Q?WHbjzFzXqSsfBWMGjSB/2Y5SldPUuaj5yksvM8wyGUEestWrs/fi25I1wkCd?=
 =?us-ascii?Q?DttPtWY8xY/r7PO5X3qMccZymGCkPL2GAho2nNUsyB3lMQMmvaTjclxP24mR?=
 =?us-ascii?Q?L8vpG7DE2McY2iMlRFhvENjWxNx8DpD9t8wN0PyvEEB/+SbCENIyBQ3LXBUn?=
 =?us-ascii?Q?0LnXUZSdNu+hOT5lz63ojGJIhPcRck23ru9DI7cExsVvQAE0jqM4IKRhPirQ?=
 =?us-ascii?Q?V3W4iItyKOieghZBovEfKIH64JPFnpydLDvv6P5ppXnPLhhBiD6smhIFnlfO?=
 =?us-ascii?Q?lbjVpudvsH9EHKPzBEUgh9/1F99BDFbEFfPsjjSOrg=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-64da6.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 22e98dd2-fcc8-4c88-63c0-08dbecef24b3
X-MS-Exchange-CrossTenant-AuthSource: AM0PR09MB2675.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2023 13:13:26.4784
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR09MB5846
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

Fixes: cb1a60923609 ("serial: imx: implement rts delaying for rs485")
Signed-off-by: Paul Geurts <paul_geurts@live.nl>
---
V1 -> V2: Added fixes line to the commit message
V2 -> V3: Fixed up the fixes line by using the correct format

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

