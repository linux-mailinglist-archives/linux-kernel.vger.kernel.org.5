Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20EBC7DDCD1
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 07:44:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345200AbjKAGon (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 02:44:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231597AbjKAGom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 02:44:42 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2054.outbound.protection.outlook.com [40.107.117.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9744298;
        Tue, 31 Oct 2023 23:44:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ddZ9rtpsCJlibh/Z7CpXHmUU/yscXy+Yxvsz5qxPAPx8Ys3IRkuvOAiK84ZBVw4alGI/KJTTO4xT8sVqFkTUlyQaU/3UzjeNaTK9Hf+oOrVxHZA/ISxPwfJ4/P4+WbPyd0gJ9TDrYWu7Dh6sdZUZFZxGJlrCO++XnaObbYzpc/TdPUKk1Wo4E4ElQbO0lt7QpdOrrUej3pH2kAt3gbjOqK9d5S0lWe/zX3fu5iTmcbHbT3Fo6YTNxfGXrqlUPHfCPZJuCRJkcA1XmUs+IKeYt06b2mgLAHwGbLLY2vQaqGvtQ8lJVyqS9b/rQrrFbkQSkbJsqyquTXsYEluhY0ixJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vimPg/4qIiMDyDAu+Uey9uLm6+VX7YYYRcLI5GIfSRk=;
 b=QujBHQV3PZ0mRNCneIN7z42PziH/cqXvhNGPv22b0IEx+dH7v6i9XDrfds950pWMAoBXMhhQkLGQO6re85Qu9a/q/z2iO1Zfz1/ErcczPeDa7hglCe/2unCM+n02MzN7KL0PpmHbXftOrEoq7AvvwpcxEtKowjWB34OXquIGSh4jtKWe1mZajtS4l6FHR6AOCIkN3J3hYFwk86ZAW5fAecLbGma1Hz4G4LsQo00dJx/ctdr1Is5fbU+4ow2nehMNQVaYaj9ZiwZE5yDxC9BOObPOLVlItqsBK/IZ7fMrTHbiZwAj7R29dtxkJ4PkbHUXNNVEwRr2/6a+Q+St7YccTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=moxa.com; dmarc=pass action=none header.from=moxa.com;
 dkim=pass header.d=moxa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=moxa.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vimPg/4qIiMDyDAu+Uey9uLm6+VX7YYYRcLI5GIfSRk=;
 b=Io0hipWkhGqAL9JApk7Ltl8J2zLYWvXz1J/9GGD3kK6f5r9TvMHu/xvgbPKJNcJZLQwZnYV2GbDqomRgfwEO4ouaM1vw4N8h2WSdKPJhsn0d7veyo+vnxqFFdgd/TQtmG6tjHcF7YBFgtwdbjhZT9IjdqWFDM7Mjj+PlIsn2qQE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=moxa.com;
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14) by TYZPR01MB4989.apcprd01.prod.exchangelabs.com
 (2603:1096:400:26b::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19; Wed, 1 Nov
 2023 06:44:33 +0000
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::5856:88f7:3f55:3d72]) by PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::5856:88f7:3f55:3d72%3]) with mapi id 15.20.6954.019; Wed, 1 Nov 2023
 06:44:33 +0000
From:   Crescent CY Hsieh <crescentcy.hsieh@moxa.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Crescent CY Hsieh <crescentcy.hsieh@moxa.com>
Subject: [PATCH v2] tty: serial: Add RS422 flag to struct serial_rs485
Date:   Wed,  1 Nov 2023 14:44:04 +0800
Message-Id: <20231101064404.45711-1-crescentcy.hsieh@moxa.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY2PR0101CA0035.apcprd01.prod.exchangelabs.com
 (2603:1096:404:8000::21) To PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR01MB5405:EE_|TYZPR01MB4989:EE_
X-MS-Office365-Filtering-Correlation-Id: c962aedf-15c5-45cf-d4fc-08dbdaa601b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mbVT/i7ndtrxFwHXhUT26cE19b7wZMcRKHCZb3Wp5TOWTwk4u/Uj7d8o6qyAmjeg/YpX+oleh5Wg8K2fHWseY19Kvcd8Br3gGAC7XtVGafubMMoZ1m136hogEzo9opwwZTsV4vwWV2uv4h9d9CT5MY27TLyaNS9cppufyl8E5Qzr6V25VCmVnDD81o4Yl7fKR693duwP24045WS3zc/K0VxBGaFcyTe+KmSYD6pLDEsF/XvqGCLE4sz/UfBy2bfbJyfzq1QZJK78ARTKKqePfeh9nl7Us/TuyhHnFb47wUgB7MsnqUcPTwBr/OGftfXeN7z2r0IM2XeVR3anzDo6QHMC7wQlt9G6cSIQKs8wbNGmmNfEmzed+qUNzB6DiGM1qU58p370rL7GBO+7JapPXIdwZWJhxvRvGNqI/JE4U/QkBAgSKfiWSx+bTL7e/TPiAt3KPbIDeYBB4cvc4OaaIJlAbIVHNtQeQ709Ou8sjHi+d3NbBSr/uMpd6/JSkpaHwOw7y6b7aRJRrDDT+b+Jy+Q0sajvYGW+enM53jAFOZ0F/WC5FyCubb5DpL3L2b4RxYSD2d3zVWnsOVc1ak93sE+XIWiIr0MGXDVOP0EQygY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR01MB5405.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(39850400004)(346002)(136003)(376002)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(41300700001)(36756003)(6506007)(52116002)(478600001)(38100700002)(6512007)(66556008)(110136005)(66946007)(966005)(5660300002)(6486002)(8676002)(6666004)(8936002)(4326008)(38350700005)(107886003)(86362001)(2616005)(316002)(26005)(83380400001)(1076003)(66476007)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6deGcNwBZ1jsJCMEQGAoXp0W1OenJIRefPK2NvHXsX477zvRbsJAFhab1fwD?=
 =?us-ascii?Q?a6m/yXREzc0/YCPq/91lqY7wsBf8AseSuIGloeGGzVkVRqivdRJ7Aiy0eJ8E?=
 =?us-ascii?Q?jMvlDNAJaa2Coa3gXZC3jGoUkaz7+3g0Lw030i5lWMGEGWjLreS2oUi37U6J?=
 =?us-ascii?Q?yzee6G3vlyviLtJPk9ocC8FrXybTe+2gRfbRNhiyKDX96aXG41uch/GDrg7u?=
 =?us-ascii?Q?PSotXNSaAInLoNz3ycRMo6lL93AuQuaiRvkUerK+bc6GndPTJ+XxD9+GqhHx?=
 =?us-ascii?Q?Afr+7xfT5qfZciatmv3qvA7cFjcH4yVLlDnDatpAnQR7aW7AO1LVUgn//CDL?=
 =?us-ascii?Q?8RKmF0ZO74RPKBSspQk3/b4ouezMPb6727EVL4zG2DY/TOgkiuRBfY8YoAqn?=
 =?us-ascii?Q?J4ZTci6UXIQ7EiYK+l5C/Ehhv8MKkpLn8a5t2o/xPhYPnaA99mZN0S+6sjNT?=
 =?us-ascii?Q?oPXc9rQfOsknVHPRZbgN3W+6Im19n+oqekViHclKByFxOqU1qsmclhH/KD+8?=
 =?us-ascii?Q?GWXqyKga2vLrNnPu8Sc34+VhAhblf6bNzAaUxewpZYNG8U0lwTdTRAVIv87y?=
 =?us-ascii?Q?MS1v+a66aJvv1z3E3bIEXQmE1ZXuWTJynDunHaWm7bM9VptSNnISgEquetcj?=
 =?us-ascii?Q?dSMauZFhYVJC+b+1bCZkTK8AgbxDSdpF4qmynEcSFSJRkVN/rmijWSDKMTyO?=
 =?us-ascii?Q?jRWafOm92VmN3YwZovsGiq5tWw2rVSWl3ekF94mzGGhJXzG3mB7X+sGqgHfk?=
 =?us-ascii?Q?pt4ehqQV5I+LafzOWLPmAyy8SBkIbYct65j+sTod2l9tl9PwSZYT1CXHZztK?=
 =?us-ascii?Q?/TUnDcCEyxjK8CAsreINwp+KuPM7SiAdKh9dp6ERAsj9TR46BattquuE6GRL?=
 =?us-ascii?Q?Za0tXBG/CSLl2jWb7jGNUDZdaw9pphQqj5NyKUFz0i1MUEKnPj7ns8JK6Ks6?=
 =?us-ascii?Q?cHWoA9c0kcH3ctf3zpcRvtOwvJNuvUepTyqcGq7hlV4FQHFfG2UgWHd1bdgU?=
 =?us-ascii?Q?BegbA256De9ZUCCn8qxKFDz/aKf6G7nxj96PBguppugsYWwyaIeqhZ+K9P2F?=
 =?us-ascii?Q?4vjRER/p9SE01wyIdpX1DN8bJQxj379ky2dhZ1AGRAlIfRT7heUaLysAuP4b?=
 =?us-ascii?Q?d64ZrDHIM3H5djiYSEop6oz8qnelQLPgnnAj3I8uFjnTz3hKNcQGEAWCWPyp?=
 =?us-ascii?Q?ICKhuD+Exw+N9XOos/WIse77meucgf6LthEKcotCj1ooAIyZI3RtxGFAnDHB?=
 =?us-ascii?Q?7xKTN1Vw2j0P/uUJwgosKbobubf8mLQ1yTJ3oUE/vFQym3CJ5wxT+mVgh/qN?=
 =?us-ascii?Q?Yq8Y9ATi2yCgtjciXtcdp11Be8Kvfjowl7vElx6l77PSmf+RaDE92+W42S7B?=
 =?us-ascii?Q?T10foCp6I5/iShqKnTb+l60Y/O0t2X0le1czgDZCOD9M3G+4AmWJfBfdsYmB?=
 =?us-ascii?Q?8B6KBiZ6HY6yEIFHrBf6vpO2UFs4xElLvKfy6qvxLVAezqCGX7PFPinh4C72?=
 =?us-ascii?Q?nxHlY5jjV7NgoxNyts+kd8QNKCeh3sO+okxXqCSeHnfuHGsSsJra+5EEXAOt?=
 =?us-ascii?Q?i8hjrg863ymdezXYnhi8RQJ1YF32BQaEX3rBkBnlJ8UuzqBBJUOF7lYmW2eH?=
 =?us-ascii?Q?Ew=3D=3D?=
X-OriginatorOrg: moxa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c962aedf-15c5-45cf-d4fc-08dbdaa601b2
X-MS-Exchange-CrossTenant-AuthSource: PUZPR01MB5405.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2023 06:44:33.2756
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5571c7d4-286b-47f6-9dd5-0aa688773c8e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mpNyJhbB4hRShp6PDrpqE+I1CJnK3hk+kzF+LTSJnl5oHROfpopP0vvkPRXzmbLGCJjSI1crM6sT4ekp6GkWKYTct9XJiVO+aOo0KVqrVsU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR01MB4989
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
Changes in v2:
- Revise the logic that checks whether RS422/RS485 are enabled
  simultaneously.

v1: https://lore.kernel.org/all/20231030053632.5109-1-crescentcy.hsieh@moxa.com/

---
 drivers/tty/serial/serial_core.c | 19 +++++++++++++++++--
 include/uapi/linux/serial.h      |  4 ++++
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 831d03361..54a104c52 100644
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
+	if (rs485->flags & SER_RS485_ENABLED && rs485->flags & SER_RS422_ENABLED) {
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

