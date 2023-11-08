Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F200A7E503B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 07:07:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbjKHGHo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 01:07:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjKHGHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 01:07:41 -0500
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2053.outbound.protection.outlook.com [40.107.255.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 613191AE;
        Tue,  7 Nov 2023 22:07:39 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WO/hczzxXDearTiZNAUpdSOt8fc+niCZErfrr1uenxhwEfB/T0lPfbMYnV9eLTgVgybjyyk5rArhJ+NAPP8M2UruPs88wJtDivfUf2F3jut4bC872JejBCuYohzd/+wiPwJP7F1vkg7TYhkqMgE4KHEmjE2c57I3k2PvtoRaZmvy7AYe8H+o1LxPqsbgVkEshfqcCaQkb+QqUMB3qNT7ojw2RsCEoc+7ceQzL7tUEIBnc2A4anenKLCPgD1GBs0GuX6YtUYIHoWFfG9QOvSMZdsH84XvlO0zETbz5HcK/v+cLCpuHTLD+pfh19u80YHfOyd+6I6+NLexhh/Oi2Casg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aRX0YbdHyK8r1dv1Guq02N+i5w7l3P8b+NZa9z4JCiE=;
 b=Ww5Iw5ZVDxwy7OdK3skeDSJfkc74tmte7jHzgCF6cLw4rZzddfjgYZhzgAcuXsN05ozssFADrasmn89KlXwm/VUqxOXWW6JNJBgwGTrJcLvkZEtr8mBTUr6sSApJ98rEDw9LoqFBkChNt5eM506Wryr90qDb/9m6u/CaRQjvdUgepu6fhH4YlR6y0yiTTmAhmnrs3ZULUhmtnewT+XG6HXNhmIWtPujTY14k/eXVLx6LSR4IfszYkmOnEA4ULTv1QZaxvXouTyCNbdR/mxRnRFrPnq3LERBxo+mYn7LEM2hJqjIknyQe6e3wJq5pG+YydYBVyjmwsPsk4/An74EcdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=moxa.com; dmarc=pass action=none header.from=moxa.com;
 dkim=pass header.d=moxa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=moxa.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aRX0YbdHyK8r1dv1Guq02N+i5w7l3P8b+NZa9z4JCiE=;
 b=EY24DDUFwuCOXJD4sxF1BkW0R34+YwY8ENs6uGSK6BzuwLnyRvBHjeneCdPQ374PaWKzuTRFECL14Bc9rrrQqalDtixrMMYG1tFbbJsvnYVPcbe4GLaTtFLXCEC58UPLQYc6FGgcFt5bZ/+1847Nc1z8j9psohaXHlKN3Mlsh+8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=moxa.com;
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14) by JH0PR01MB5649.apcprd01.prod.exchangelabs.com
 (2603:1096:990:12::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29; Wed, 8 Nov
 2023 06:07:35 +0000
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::5856:88f7:3f55:3d72]) by PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::5856:88f7:3f55:3d72%3]) with mapi id 15.20.6954.028; Wed, 8 Nov 2023
 06:07:34 +0000
From:   Crescent CY Hsieh <crescentcy.hsieh@moxa.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Crescent CY Hsieh <crescentcy.hsieh@moxa.com>
Subject: [PATCH v3] tty: serial: Add RS422 flag to struct serial_rs485
Date:   Wed,  8 Nov 2023 14:07:19 +0800
Message-Id: <20231108060719.11775-1-crescentcy.hsieh@moxa.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYAPR01CA0240.jpnprd01.prod.outlook.com
 (2603:1096:404:11e::36) To PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR01MB5405:EE_|JH0PR01MB5649:EE_
X-MS-Office365-Filtering-Correlation-Id: 20179a74-747a-48dd-0257-08dbe021002e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9/SgJSTlOV/umWVLWHFsogwLq020GASkilED0dA0EiURAEi1CAz+zlWa8+K3KjX/0d3dd2fDAhHKh0ZlIB1vUn3FCbCSE8/GBkRaUAJO+czifzZHp7RDzJbKbXpxqP2jub9kTo1UcvWpd673zkkBOtkq8T9bua7WGzhxbAF3J7lLCkoWz4sfaQ0hXKU35uBHBQZLA21kMQE4sYSa2TEVW83CRgQPh2BGCvGcQ7hO5jrPx9LqKhsKo4VEMQ13hptJbvo8pWGGOOv96ZiU04K5Q9Ox1fv80tQLkm/zWj8SQ6GTBTjT/Iexk4DItDYYpryUdoAxXzbUIkgIL25XiB6Q91QvPr2QnzIN2iyZVdotPeDUkucu1gfIwOUx9acisUInmgOPzK+vP7UE5IYtK4fTjPemLHndg7Zz7lXty+oL0t/hlJQxFV9LpBuS+QLDwvimcXnDXt4m+kmegvpLcX0lYqyWRXXBJUQpRWD22p2LTglHpxhSlR51lf+0v/1Q1yzVRkGl2O/dLhI6Djajbt0rEvYtjsEAE8SdEh2c6BXC4nRytjM2ow5nzbt6hdziWOiM+Rn2gIOPn2runWVt/1+yVMYPT/LvyZhZIlqI2qqdyR4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR01MB5405.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(366004)(396003)(346002)(376002)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(8676002)(41300700001)(4326008)(36756003)(2906002)(8936002)(110136005)(5660300002)(38100700002)(6486002)(966005)(66556008)(66476007)(6512007)(316002)(86362001)(66946007)(83380400001)(107886003)(26005)(38350700005)(1076003)(2616005)(66899024)(52116002)(6666004)(478600001)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gr7I4wVVK/nmuSUOL6Cm98kB9tB+WgufyraxXWJujVcuNm3G5cpNL0K+NENY?=
 =?us-ascii?Q?hFfTBJ2hhQXATGG3Bdt5EvJVdVVnBCiFklf9wgv8slqHfjrZ/Q4ERBgwr26S?=
 =?us-ascii?Q?Lyk1hKZfSysugI2PPzeDKQ7kmnw1LpqKjuVhLGWSVndivNREXddp7EEqREuI?=
 =?us-ascii?Q?/kE/8z/x3l4hMvI2l6E5LNCQVKkLyDK1E+jKRfpDIbgUOiOGII8gApBwFTjv?=
 =?us-ascii?Q?eapMxM/p3t6/H3YBB4FiKW7Ti7KBaAgiJMnqpp3abrxmouy+K8nzr/aPww6P?=
 =?us-ascii?Q?nr/RJkQU1tEUy1VhasEe3Kwh9SLBbjDbvNGHwcsrZLCzbcYysk6kl+21+4+I?=
 =?us-ascii?Q?EGMKtCA1HEX8QuljdGWLfDjvWgMCD6yhhxTQRXY+wCHU17dhqp6ZAaY2lvpB?=
 =?us-ascii?Q?Y2XaCxdhm/lYK6A8VcnSlm5CFh20l56Q7tONQq2ST1iRuRRa3oXDKi+4HJiV?=
 =?us-ascii?Q?uCZQT8u76tVZ7xqYwhd875RZafU/RMjoZeH7e9yRX9+CLb3aJzwuWqSreKBj?=
 =?us-ascii?Q?8CFnuHnyN4XbtaMW1fgWmvXijxl30yhW8Wbjt3Jt3tYtbdZgohCHz1Gp6p3y?=
 =?us-ascii?Q?w9/MW8gR3OkCKMxK8kw0IRMlQ/5aBOyDWIovf7kZTNsmBlfx89rPdvgkqNIG?=
 =?us-ascii?Q?TTc1fi8RvpAOn8exq7LUlzl/7XYE+MT/xweZDomONSIx8g1MWA/HGIGietNc?=
 =?us-ascii?Q?MBx66/erUVQCc+VmriSshCmBb3amsjMaRAQzoE2e2Fro98k75HSaVzpYUby9?=
 =?us-ascii?Q?TAOzC/UEmk7HT3/nqYQWiUDqwvw8Q94R3zL0epo+L6yug3kI4d65u/CbyYGX?=
 =?us-ascii?Q?Qu6zBDZDzjZAWZqA3JOkKnlSk/5T+hR0vb2aAj+XhR04Gwcq7GmMzXJmULFB?=
 =?us-ascii?Q?l9qexpSM88Gqf5Qkh/UgyOllxx7Dp+4gT/nnHcBKrK5MUTE6XnyMvzSLp32T?=
 =?us-ascii?Q?at/x5bHSzLsAFVfxjkdo5HapaCSoE2d91xYJ45jJ0jSF6cmvnbEb2XNvGdlx?=
 =?us-ascii?Q?urQTMnMFqhvP2vpowY66GNBN1oz6Vfm88iQ4TmgOyqJ+43bsXpmmjLR65ZRR?=
 =?us-ascii?Q?VA/jMXKTLCEC0VRiZ3VjZAK1ziAOCe4+okMsbwjo2HIxolroQhsnT6bYHC7L?=
 =?us-ascii?Q?EYAo7rDS8E1st8EBoM4RZ+F1EPWJmSvcae0Exi8ApWVOT3NqbWnu7JSAh2mK?=
 =?us-ascii?Q?84te5+BMdkLUpMmNZj7/IhxbWFg/PbPhw4K/l5/bS5kiLTK/m4D4gBAHbIpY?=
 =?us-ascii?Q?skCbWzlm5izhIbx42O72BV9SMr7wopUNMPCnyXBMIlP/KoMegpHZ2RbvqgRX?=
 =?us-ascii?Q?veMqbUGyLAV9QzJXPj/fzBUfRvCByK/jgh2AeMUVNBilpUWDIgwXNy1hG/7k?=
 =?us-ascii?Q?OGv7EXqhoI9JKOQR6wlXesLVmX0SLoWhuH1vOubvibudj/kWE+WyQCNd0YPF?=
 =?us-ascii?Q?KM8F7lE1LDmyRTlDqVUP3YoEn+3cbEowNjjp9ALSTAJcCUAmCXZ4JB8u3+2z?=
 =?us-ascii?Q?OKpmJZAMctkVH7zEQwLJWW2qx8JfyBiJk1hT1uU4id4px7ym9vU+V+ITgkJm?=
 =?us-ascii?Q?vz8k2/Cf/7Gc57FtlA/aFF+nBQ2ltcjo9Dp5sMgmrheovICavkqIuwfn7BHU?=
 =?us-ascii?Q?Gw=3D=3D?=
X-OriginatorOrg: moxa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20179a74-747a-48dd-0257-08dbe021002e
X-MS-Exchange-CrossTenant-AuthSource: PUZPR01MB5405.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2023 06:07:34.7133
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5571c7d4-286b-47f6-9dd5-0aa688773c8e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: taJhdCVxXD0ypC/KVgh4mLMOuNxdu/nrzspn20qgo/MelQKNeSGqawAF2YPK28JjRiSrejS+k3KW4+b+2f+CgtQB7GaMfnwwalnGhfjKltg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR01MB5649
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add "SER_RS485_MODE_RS422" flag to struct serial_rs485, so that serial
port can switch interface into RS422 if supported by using ioctl command
"TIOCSRS485".

By treating RS422 as a mode of RS485, which means while enabling RS422
there are two flags need to be set (SER_RS485_ENABLED and
SER_RS485_MODE_RS422), it would make things much easier. For example
some places that checks for "SER_RS485_ENABLED" won't need to be rewritten.

There are only two things need to be noticed:

- While enabling RS422, other RS485 flags should not be set.
- RS422 doesn't need to deal with termination, so while disabling RS485
  or enabling RS422, uart_set_rs485_termination() shall return.

Signed-off-by: Crescent CY Hsieh <crescentcy.hsieh@moxa.com>

---
Changes from v2 to v3:
- Remove "SER_RS422_ENABLED" flag from legacy flags.
- Revise "SER_RS422_ENABLED" into "SER_RS485_MODE_RS422".
- Remove the code which checks the conflicts between SER_RS485_ENABLED
  and SER_RS422_ENABLED.
- Add return check in uart_set_rs485_termination().

Changes from v1 to v2:
- Revise the logic that checks whether RS422/RS485 are enabled
  simultaneously.

v2: https://lore.kernel.org/all/20231101064404.45711-1-crescentcy.hsieh@moxa.com/
v1: https://lore.kernel.org/all/20231030053632.5109-1-crescentcy.hsieh@moxa.com/

---
 drivers/tty/serial/serial_core.c | 11 ++++++++++-
 include/uapi/linux/serial.h      | 18 ++++++++++--------
 2 files changed, 20 insertions(+), 9 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 831d03361..777f091a4 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -1376,6 +1376,13 @@ static void uart_sanitize_serial_rs485(struct uart_port *port, struct serial_rs4
 		return;
 	}
 
+	/* Clear other RS485 flags and return if enabling RS422 */
+	if (rs485->flags & SER_RS485_MODE_RS422) {
+		memset(rs485, 0, sizeof(*rs485));
+		rs485->flags |= (SER_RS485_ENABLED | SER_RS485_MODE_RS422);
+		return;
+	}
+
 	/* Pick sane settings if the user hasn't */
 	if ((supported_flags & (SER_RS485_RTS_ON_SEND|SER_RS485_RTS_AFTER_SEND)) &&
 	    !(rs485->flags & SER_RS485_RTS_ON_SEND) ==
@@ -1400,7 +1407,9 @@ static void uart_sanitize_serial_rs485(struct uart_port *port, struct serial_rs4
 static void uart_set_rs485_termination(struct uart_port *port,
 				       const struct serial_rs485 *rs485)
 {
-	if (!(rs485->flags & SER_RS485_ENABLED))
+	/* Return while disabling RS485 or enabling RS422 */
+	if (!(rs485->flags & SER_RS485_ENABLED) ||
+	    (rs485->flags & SER_RS485_ENABLED && rs485->flags & SER_RS485_MODE_RS422))
 		return;
 
 	gpiod_set_value_cansleep(port->rs485_term_gpio,
diff --git a/include/uapi/linux/serial.h b/include/uapi/linux/serial.h
index 53bc1af67..c9c4d3b00 100644
--- a/include/uapi/linux/serial.h
+++ b/include/uapi/linux/serial.h
@@ -137,17 +137,19 @@ struct serial_icounter_struct {
  * * %SER_RS485_ADDRB		- Enable RS485 addressing mode.
  * * %SER_RS485_ADDR_RECV - Receive address filter (enables @addr_recv). Requires %SER_RS485_ADDRB.
  * * %SER_RS485_ADDR_DEST - Destination address (enables @addr_dest). Requires %SER_RS485_ADDRB.
+ * * %SER_RS485_MODE_RS422	- Enable RS422. Requires %SER_RS485_ENABLED.
  */
 struct serial_rs485 {
 	__u32	flags;
-#define SER_RS485_ENABLED		(1 << 0)
-#define SER_RS485_RTS_ON_SEND		(1 << 1)
-#define SER_RS485_RTS_AFTER_SEND	(1 << 2)
-#define SER_RS485_RX_DURING_TX		(1 << 4)
-#define SER_RS485_TERMINATE_BUS		(1 << 5)
-#define SER_RS485_ADDRB			(1 << 6)
-#define SER_RS485_ADDR_RECV		(1 << 7)
-#define SER_RS485_ADDR_DEST		(1 << 8)
+#define SER_RS485_ENABLED		BIT(0)
+#define SER_RS485_RTS_ON_SEND		BIT(1)
+#define SER_RS485_RTS_AFTER_SEND	BIT(2)
+#define SER_RS485_RX_DURING_TX		BIT(3)
+#define SER_RS485_TERMINATE_BUS		BIT(4)
+#define SER_RS485_ADDRB			BIT(5)
+#define SER_RS485_ADDR_RECV		BIT(6)
+#define SER_RS485_ADDR_DEST		BIT(7)
+#define SER_RS485_MODE_RS422		BIT(8)
 
 	__u32	delay_rts_before_send;
 	__u32	delay_rts_after_send;
-- 
2.34.1

