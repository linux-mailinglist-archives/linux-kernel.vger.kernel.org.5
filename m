Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A4447DB2DA
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 06:37:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231143AbjJ3FhA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 01:37:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjJ3Fg7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 01:36:59 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2082.outbound.protection.outlook.com [40.107.215.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE44C90;
        Sun, 29 Oct 2023 22:36:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L1YsO6uZc/rWTZ4nSXXQR8955OwDhxo4b+hdI5DEEUJe8BMm1Q2OGJxvYGjsytS55drCiS0gM7ilYwoqdrZT4nRqUzbp+GYtzprPHY8NjtuYqHC6hr7dttuaNiDOWFPpnnbABRmM35RLPbu5OYhG+2mJNW0BPdXnAEn5neVv89eL40ao6Kb6BvX5tfcbgpMwZB+U1IDRk6wKDPfpbc5xQoglMNxuThLrap4zAfM37I2+mGE4QZzpBlvo5KEAt0Fmfe5Xw0Z+bjHmfDSflSC4tMuw5NazQi7iHP8UafZvnLH0ml3D4WOqnF1gCrn0MKavxErJhhoNF9lFFbJZ5IpuiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FgnEGyf7YiMoDafmWRsnnhQa0xwrWyFPdnjCZSdJQ3U=;
 b=O0LnK1Mg2Mek3XESSLJVbDGRDSnM7WwT12OrfVhPmQ+pgodcIp0PJsC3p4m89wgtmvaxy+vBblxu1XOu+nWof4v+TLhfzf+2i2kWpYvM92/eKAjuvb9r3ldiCr0LgEJ2jyl/g1bbXhq0OdVBt+VRyNYYwAaGZlB/7OkgOdj5zpQO+9GEZ9FpYRdjgu7QfpyH0MztS+RlPCHze+LmRkCslQQ4/NZtG7vWevPceFRXxgy2bz4ltVyE0EcvidNV33zlXYk6rCgwjaoz+fWohGRsvY9SxyAqbysFm0kGuKPEQLspsXLdzgBUto7B4qeIp34bcZaz86glktCh2OUaNMLYJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=moxa.com; dmarc=pass action=none header.from=moxa.com;
 dkim=pass header.d=moxa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=moxa.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FgnEGyf7YiMoDafmWRsnnhQa0xwrWyFPdnjCZSdJQ3U=;
 b=fcpZso231hn78pukVXMgJvFlnZY4iC0Sy6ARbICigdBQJmoT/NSXT1Q0E99Vi4p9H5YOm2nKtAkgdqWr7aTP0jCb64AvCc7ra13UKcPLXJsGlvvMC2aRmNLVroaKo0nEFiq3EqJykWTyvRlHUm4NIYBLgNMEtsdfVFWkMY5kWCU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=moxa.com;
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14) by PUZPR01MB5211.apcprd01.prod.exchangelabs.com
 (2603:1096:301:11e::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.24; Mon, 30 Oct
 2023 05:36:51 +0000
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::5856:88f7:3f55:3d72]) by PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::5856:88f7:3f55:3d72%3]) with mapi id 15.20.6933.027; Mon, 30 Oct 2023
 05:36:50 +0000
From:   Crescent CY Hsieh <crescentcy.hsieh@moxa.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Crescent CY Hsieh <crescentcy.hsieh@moxa.com>
Subject: [PATCH] tty: serial: Add RS422 flag to struct serial_rs485
Date:   Mon, 30 Oct 2023 13:36:32 +0800
Message-Id: <20231030053632.5109-1-crescentcy.hsieh@moxa.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYBP286CA0013.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:404:ce::25) To PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR01MB5405:EE_|PUZPR01MB5211:EE_
X-MS-Office365-Filtering-Correlation-Id: defd0686-c721-4797-91a0-08dbd90a3732
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jQjUSbGl4CO9QddKetqzc6ygSkTSjxNqrcLzcCFLSdCEdK/cUYio92TMbP9rfcOdq+89AUYGkQZOsM5xcrNYac9D8TkkS3mVG9GhBx0OIZxiHyGD1LUY3EEFygk6Ip3a4p7oiw9xfvd6CboFW3tDSKPIyqRh3iE0xWzhTEZ0Ui85Y9CTRx2QjL223xBLjfAzfCjsZLp3bHH5ejNFH0oGcmrM8S1X7ARtwWEuMc4pNmPfWSq55l3MMGHQNrEcCJqFroi+k7CYMxerSO8yFKyZKoAXPOOuN0H0pArOngEEgzWv5E1v1k548VIeBznmWCHasdKmE4jLRxQm+JzQN59h3U/d9bXY3j93ehigPa82aCWs1BnZqLXeWjAgsgGh8i5feZPZ2g2zTITkHcgyDmapMwy7V9afQGiVZTDLagxK2g/dCXk1ixudityA3ja2ww2j+o63roXnQM9ZoTztPFy1k0uMsMc3Vx/XPhGJNEvjaB8GkN11xVOn8tznk9SH9jDZtqQAYkfTmY27URYyQU2uA4I4ZO45aZMk7o4NcgiirzONJ5aWCmyaG6wGPLS+nQMmhIOmQjLfi6BqS+akI4RPl/pEPZDe4OmF4HnkOwbHSw5gAU9g2frj+ItZO8H02JIk
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR01MB5405.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(346002)(396003)(366004)(39850400004)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(6486002)(1076003)(26005)(478600001)(107886003)(66556008)(6506007)(52116002)(6666004)(38350700005)(2616005)(6512007)(83380400001)(66946007)(110136005)(66476007)(316002)(38100700002)(5660300002)(8676002)(86362001)(41300700001)(36756003)(8936002)(4326008)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FymTmG9mO/BpO29BASCfsQ0Qhn6VWtPFxmgYsTxP8x0LLoWrDWdu1xmk1QJK?=
 =?us-ascii?Q?zaaSWUc6NMa/F+LCYd22MEvXH0NW9vYuk+I0h98joreT7YeHdAk4Ce1kpdTK?=
 =?us-ascii?Q?27NngW9Xoox+fI9z6oh4LPI5hr/K0NPs+N6s9T6Qp5poWfbvsHl4JVKFa8I0?=
 =?us-ascii?Q?o1tDWFxOkzvjY6NQith5h1WfwlAX+W7ME8JbcS8wj6+L8/nd18JPa5baT/rC?=
 =?us-ascii?Q?8rL0zDjKtyknQIKa0bn59jPJAdBe2NHqFqo98iDsNEkxks28zCH4FuU6ETj/?=
 =?us-ascii?Q?nta41Tyq13OjHD1+YaJ6+rcCrc8D+w+gu4d4PejdJGeDzfPO/2wfhBmPWXHe?=
 =?us-ascii?Q?57RjwF74/R8ae/x9Fst3OnNfTxvSSm0nE53sz82kYCWlb3jlFmAwWmyfWUm0?=
 =?us-ascii?Q?PLhNdY1/rvPa6N84Hd9QCpqdfIYXWrAfqFUZ/7E0iJu8ndxvHGYTMdgQxPLi?=
 =?us-ascii?Q?Ordl2VxB7coFM7l/dAgQQpXfIsGV3K107zSGIhprbecAFdgW/BkRWKDJoQrQ?=
 =?us-ascii?Q?YUf7Y2vylSPgzxPc0MBjGQfpLayp4h8VdvBifZMsm2LNmZn5ZJUNTG4BVuBO?=
 =?us-ascii?Q?TMMhYxvcO4nefulK5CkT9rm7dPnKHEdMVGrHssakVVfTfPYi6swjfqPhDq0i?=
 =?us-ascii?Q?kpkaztuinzrS83R8Z5v9rJT2fx+/Ywst8OItIZ57mZn1K345z49mYBqOqDw9?=
 =?us-ascii?Q?fg2GNzmYjhwqxSiCtk3U6KYB8zeQI/Zvbw5bK+VNDgutpvZ0ilMiuqDa8TwF?=
 =?us-ascii?Q?waXqReidmS8kOOGPQLDG/eQ5eubxHPZV39yhdqzLEYEsAhClN+DQ9LHZw9HJ?=
 =?us-ascii?Q?uI+6XUkISxHRFN/jBG2niCjjPzLBXl1DBvI6qOBhd2XDPzhn1n/mAuX9hBq9?=
 =?us-ascii?Q?icLdbzhFr8qvFwA0W634dG5l0scEp4iTjrRaklCq7zsx67eiPAbZUJhNtVcT?=
 =?us-ascii?Q?8HYNy0y4IOvuI6f8HgRcd5h42VML7rSOEs7SabgVwrZ6gKyrR6YR0Mnhy5QM?=
 =?us-ascii?Q?TxQ1P1PjQbyW5eunfATx7q5K9FqQhg92LVB+K7ba8abR3vYTQNYIJE1ztyy+?=
 =?us-ascii?Q?xGObuUENyDwvbVKlnuWGleDbbavecAYpSzk5foVTcvKwn/DpRsbx/ukzZ0Ov?=
 =?us-ascii?Q?IcB1/Vs3WiBl9yLKpIMlYS0tedsAXCBOWkUuoWwPihclr/o0d63zi1ssOPMZ?=
 =?us-ascii?Q?PSXYPWXUFlACISI3ZA4l2+Lah3hDnzrYrao4eGvrxAE0EcblRWyWqg3sOs0g?=
 =?us-ascii?Q?VIjedZ/X1nTa8EWRdnFT9nuuYTcEEf21Flt1P9OxU72bXWA2IzG5X1vQ2ZS1?=
 =?us-ascii?Q?tUqE8m2B7LBERSZSRhyzkDFftslT9oV5S6TO/tI9C72dSWl68GNj9qEVxItz?=
 =?us-ascii?Q?/F6qhKWSAYX/AdboZ1xYVZ1PY971M9Xc5F/b1RobZMUR0+et+ubZY5yCkEb7?=
 =?us-ascii?Q?URGLRt210ffuwUeFLQmdt1UEh6bJr3LvLWCpSkHGxCDRcLC2ibNzjGypMsgs?=
 =?us-ascii?Q?KzsUDm0yMcmC3CxXyccty8Y2jsJblY1j3RTAJiuVYZfB2ULrgrD4/uNSKi6Z?=
 =?us-ascii?Q?JgDnvkhLlzSftvWNcA6LOEB3TSh92EMrlocKFNWoSTfUYrhtmSM0IzcHOBxp?=
 =?us-ascii?Q?jQ=3D=3D?=
X-OriginatorOrg: moxa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: defd0686-c721-4797-91a0-08dbd90a3732
X-MS-Exchange-CrossTenant-AuthSource: PUZPR01MB5405.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2023 05:36:50.4201
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5571c7d4-286b-47f6-9dd5-0aa688773c8e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Une9uC/yYYx7+K0Sp/iOmBR5zQuoSmTk8CgrWXSOoMJ56HW/LbKkUu016HIY/9BJhLpvTwpmKP7hQcLPZECxUGapbG3VmHCOyghzy78H3ko=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR01MB5211
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add "SER_RS422_ENABLED" flag within struct serial_rs485, so that serial
port can switching interface into RS422 if supported by using ioctl
command "TIOCSRS485".

In case of interfaces confliction, add checks within
uart_sanitize_serial_rs485() such that only one of RS422/RS485 is set.

Signed-off-by: Crescent CY Hsieh <crescentcy.hsieh@moxa.com>
---
 drivers/tty/serial/serial_core.c | 19 +++++++++++++++++--
 include/uapi/linux/serial.h      |  4 ++++
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 831d03361..afbffa9dd 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -1305,7 +1305,7 @@ static int uart_get_icount(struct tty_struct *tty,
 
 #define SER_RS485_LEGACY_FLAGS	(SER_RS485_ENABLED | SER_RS485_RTS_ON_SEND | \
 				 SER_RS485_RTS_AFTER_SEND | SER_RS485_RX_DURING_TX | \
-				 SER_RS485_TERMINATE_BUS)
+				 SER_RS485_TERMINATE_BUS | SER_RS422_ENABLED)
 
 static int uart_check_rs485_flags(struct uart_port *port, struct serial_rs485 *rs485)
 {
@@ -1371,11 +1371,26 @@ static void uart_sanitize_serial_rs485(struct uart_port *port, struct serial_rs4
 {
 	u32 supported_flags = port->rs485_supported.flags;
 
-	if (!(rs485->flags & SER_RS485_ENABLED)) {
+	if (!(rs485->flags & (SER_RS485_ENABLED | SER_RS422_ENABLED))) {
 		memset(rs485, 0, sizeof(*rs485));
 		return;
 	}
 
+	/* Pick sane setting if the user enables both interfaces */
+	if (rs485->flags & (SER_RS485_ENABLED | SER_RS422_ENABLED)) {
+		dev_warn_ratelimited(port->dev,
+			"%s (%d): Invalid serial interface setting, using RS485 instead\n",
+			port->name, port->line);
+		rs485->flags &= ~SER_RS422_ENABLED;
+	}
+
+	/* Clear other bits and return if RS422 is enabled */
+	if (rs485->flags & SER_RS422_ENABLED) {
+		memset(rs485, 0, sizeof(*rs485));
+		rs485->flags |= SER_RS422_ENABLED;
+		return;
+	}
+
 	/* Pick sane settings if the user hasn't */
 	if ((supported_flags & (SER_RS485_RTS_ON_SEND|SER_RS485_RTS_AFTER_SEND)) &&
 	    !(rs485->flags & SER_RS485_RTS_ON_SEND) ==
diff --git a/include/uapi/linux/serial.h b/include/uapi/linux/serial.h
index 53bc1af67..427609fd5 100644
--- a/include/uapi/linux/serial.h
+++ b/include/uapi/linux/serial.h
@@ -137,6 +137,8 @@ struct serial_icounter_struct {
  * * %SER_RS485_ADDRB		- Enable RS485 addressing mode.
  * * %SER_RS485_ADDR_RECV - Receive address filter (enables @addr_recv). Requires %SER_RS485_ADDRB.
  * * %SER_RS485_ADDR_DEST - Destination address (enables @addr_dest). Requires %SER_RS485_ADDRB.
+ *
+ * * %SER_RS422_ENABLED		- RS422 enabled.
  */
 struct serial_rs485 {
 	__u32	flags;
@@ -149,6 +151,8 @@ struct serial_rs485 {
 #define SER_RS485_ADDR_RECV		(1 << 7)
 #define SER_RS485_ADDR_DEST		(1 << 8)
 
+#define SER_RS422_ENABLED		(1 << 9)
+
 	__u32	delay_rts_before_send;
 	__u32	delay_rts_after_send;
 
-- 
2.34.1

