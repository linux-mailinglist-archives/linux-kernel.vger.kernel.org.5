Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10B46800488
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 08:16:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377713AbjLAHQk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 02:16:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377711AbjLAHQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 02:16:37 -0500
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2062.outbound.protection.outlook.com [40.107.117.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B9571726;
        Thu, 30 Nov 2023 23:16:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h4kVCPfHC/qV2EIzwSh2iR2CFhHVuxdkX3+QhhB8LaXcctUNdgDt4IFGD+79oAf54+V9byuHD8GvocRHkiP/1GnI/urorFwf3qTL9TfuhbjP2axsKrz8kT1C/3yeBNpIEYnIMeCsjLfw5mHMeYmp37nZVv9tiA/FO2c22qSzEGWUEZXfsp1A02FAsawzUTOBB7JoaRj3eyVhYtVXzl2lBUjlerD3+k75i+AvI6NuEozJjgdj7vXivJc7gjPyYJ1aKfo/16YueHPFqyz2ITr2va9w/6ZpO/dDgcggd4B3NLz1oVIImneIrMvvQrwKrHfWNE+RN5WwkU2X8XsAxZiyMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ArAh908wYFJWhXcoO5REz/BBDJ1hRKCWJknYZ87vrC0=;
 b=D9g0yKbQsPl+EUzzaKnqBtjFKuc7cB0vqs884VQiqDl+Etq4i8kJ+gPKQJx163MNBtKsk0XzKkGzulwJK/cRd3xEY4ArnGEE6Kv8eJfr701BM72ItgAURGvu9KloBZ6bIsKioyoeUAWuroGJjHPufWYeoqcTTaYbed2GUcYESqIqLbrlK1I0niWtekT+UTFw9KTERvDr9oEuRxFIHnVm1Aezq7VR9oAxq5ucvORyUlEiZFf80tjZh9aS+dIMA6MkwHHsUDqdO4l4m71OrNaI0mWg9nzdqOY29dkp6+TldGZ3vyzSFbJzlv/wv0ulzwIhmA3IT0ArGA0KaXtclZ2m7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=moxa.com; dmarc=pass action=none header.from=moxa.com;
 dkim=pass header.d=moxa.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=moxa.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ArAh908wYFJWhXcoO5REz/BBDJ1hRKCWJknYZ87vrC0=;
 b=DNRwgU1atp+6yLdAwYUEDrePfAUVksaFBUPngPTQ3znjP4EP7AkD2luCOZMKOFLYuNgdAI2egTP2df2vGzr447XAzT8IsSh7prAXa900t93BHWqEr6zu4MvwLMONsrE9y4bQVnZX4DFcN1VxhR2TDDd7vvpVvEcAS7JRh/q2b5M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=moxa.com;
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14) by KL1PR01MB6537.apcprd01.prod.exchangelabs.com
 (2603:1096:820:13d::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.26; Fri, 1 Dec
 2023 07:16:40 +0000
Received: from PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::1023:2132:c05e:ea6b]) by PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 ([fe80::1023:2132:c05e:ea6b%2]) with mapi id 15.20.7046.015; Fri, 1 Dec 2023
 07:16:40 +0000
From:   Crescent CY Hsieh <crescentcy.hsieh@moxa.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Crescent CY Hsieh <crescentcy.hsieh@moxa.com>
Subject: [PATCH v6 2/2] tty: serial: Add RS422 flag to struct serial_rs485
Date:   Fri,  1 Dec 2023 15:15:54 +0800
Message-Id: <20231201071554.258607-3-crescentcy.hsieh@moxa.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231201071554.258607-1-crescentcy.hsieh@moxa.com>
References: <20231201071554.258607-1-crescentcy.hsieh@moxa.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0255.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:456::15) To PUZPR01MB5405.apcprd01.prod.exchangelabs.com
 (2603:1096:301:115::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PUZPR01MB5405:EE_|KL1PR01MB6537:EE_
X-MS-Office365-Filtering-Correlation-Id: 133a18a7-5ead-43fa-106b-08dbf23d76b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gIBrpIMCwHacGBpXz1gT7o2W8O8fo0uAZFrZSDOh8IF+xJ4II5Dz9oeSWBJ0FWDTE/cucTEG9ctRRFlSSJ531pvdfgxf69fgi1wDb1aVehUiPTwptipDcWOefmkOJ9wFMPXpSEV8kZc9nyCPe3zA76ND5G876Bq0kAEehK9oVigqkKufQdr+iyeGBHsGXcoau/+LYna1CIXe00ddLzaUmbH8OuxbPnvPGTjVlEm46f+IJD73OFsH7KBpYNMh9EHSYhA62A32KwsvkN2oRDIgAFziAn0nkXFGyY1ZDhPbwffRjsda+oVVc0BSDNUjDfUB1b61VeGSD+BlzfOgmH5S0KGzzq+YbbYTgVh1ngNkWousZW0B+1wHkgZkL2q15Aq1inu6gykn2s/DwjOnyfSKyaVMRAcSSgKvTVO/plCbjuRwHh7yEyiR6QQVYbRowzZQoVAKcyQH6YUCd6KDbc7AnHejPP0FtyrudwHQeLpzS1C18Mtvq0R5o5/G37ECDbibvisDEGNuWwgdAU2eEzGC95TdZBym+zpWccNQQ3USIfermPfkJl3Gegz0xyW5JapBuDsaBnSLRjN7pXGlh6aDt7e7+xP80M9oC4N76vdk351yrw6EkCiFkqvqGgGXTdYi
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR01MB5405.apcprd01.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(346002)(136003)(396003)(39850400004)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(5660300002)(2906002)(8936002)(8676002)(316002)(66476007)(66556008)(66946007)(4326008)(110136005)(41300700001)(6666004)(107886003)(6506007)(478600001)(6486002)(52116002)(2616005)(26005)(1076003)(6512007)(36756003)(86362001)(38350700005)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?P/OgwyaJph+28JUhXgNS5wDKLDHDb0j79ZxsZu24XAvZvyiK0HtvVJ3QP7Ke?=
 =?us-ascii?Q?HK7ej8VqwAf6Ot+cBhf/dKDjYkpoXQIK+uG6l+sxNMYJ3qrxSJhibN/aW5Wx?=
 =?us-ascii?Q?OlwAIqsktFV14kJe06F6nndjOC2K/rqKEK6nzIsBT8V3obptiKriejtgUvfA?=
 =?us-ascii?Q?JmU0/ykhYvhnGGcSb3DnNITATbMrS7BtS+OvO7kOxw+4kuWLx7ilUxJGBNPj?=
 =?us-ascii?Q?Aod5mLPqJx8HHE4/aNYMjP11ZuNXDtj/WbOJ/db95JwsJ7qa7S0Tsh5J+in0?=
 =?us-ascii?Q?NwcD2VOC4utcvG6nJd5PBMsdvV3vVuChbGsRo52Y8HdTlNN0PrqQJtm3Jx41?=
 =?us-ascii?Q?WVZA4oXaSSWoKyo8xe8MUvbX+MHBxjJZC4Cwfd0VVpWgYYp2/NX5Q9B3TrBa?=
 =?us-ascii?Q?7ZxKBXpg5K6i8Q7wRXkf/pV6E6+woQ6yKifp+wnXFC0xuGJpTjo0Gd5NU/go?=
 =?us-ascii?Q?pLfY1hrsQc15QhuXIOGH5gGfcYgfnK1H+5ZHV1M3oW3/4B6cKvLDmuWQqg2u?=
 =?us-ascii?Q?wxpiskmEwf5m5adt/ZbUUJtaLAe8uHdJRZ5nTimy5rJ8wZHshS2TT7veFT7l?=
 =?us-ascii?Q?soc/a2DItWLKxFqoWaHv+jyVRY9jEbA0TLbp9FLk41tpeRanTUTjHChYcDZ7?=
 =?us-ascii?Q?ZWgsKx4OYWLeJBlbQh1+FDlF8XUMGIU1IXdrY/QHzTjgj+gq32DZl8r+Hzot?=
 =?us-ascii?Q?aSYSlzKI4RwhUOVJRU3gnhUBqL3DLcgQ4o0A4850uMIawjl7olO22WD5qvh+?=
 =?us-ascii?Q?/1597EQ19ivuAVzYDFeh9nimz7tpQXMAzbntp+sPtm5tUb2CoG/cV7FAYzXy?=
 =?us-ascii?Q?m8zqa9SgZlZQEMxtL+qT6pSyGWJkgn/Rms5dFeVgNTPuVkL79hxktSy2v3jl?=
 =?us-ascii?Q?kJ0yhrgIwab/5IxlUfPmaQ2XwKqF5Cdpgr/H0j9M4UPjErx4JyErbVdNkpWY?=
 =?us-ascii?Q?FhQMVrdwCuel+Gxf/24ORVUlHY9fWBuiES8jqcHYbLmCS74I60edBAJA+e7L?=
 =?us-ascii?Q?fy6PNP4kUEnfTFM39ziHrCjlGCXPKdwLpB+W/BBJjSlLKfgAGsVmZPW+TIbe?=
 =?us-ascii?Q?afeBDvcOReXeLMeYE3jtPA86JXz3tIudeKnBR0p+LCa8+VQx2aP3ClY+lFi2?=
 =?us-ascii?Q?ZTo3maX2fReHuzvdWpr+oFa5vQD/Q432+4QVRytVqXNhjzwSlOkhws4jhJH2?=
 =?us-ascii?Q?V6h9W+h0AgTuJmZkWaK7hWIkFDizfo9r3e9axRASBIWbJhrj6l7LOoxoOls9?=
 =?us-ascii?Q?15umIkGfV3U1oN5rqtiCBVa2+czHeeUPuSI4m+pXu1I1vGFueKOOrRDQTbiz?=
 =?us-ascii?Q?4FbVCxRAnYjnIhAMdeV7O4PvIWYMN/hBBWAM1tTV/Foi6ly1myiSu6q/R7f7?=
 =?us-ascii?Q?sCq7Ltgckgd3dTAh+GWpV9MJ5jvjfRjrUQ6p+hTBb3Vd49grFn9gkUKHxgtT?=
 =?us-ascii?Q?16IEa07o+t2LnXTHe7VD7IpTUXnC2xhwblwMgci3I8LP7FWPwPn7CsrnVYq8?=
 =?us-ascii?Q?ZB+J3L0Oi0KYNAWrpb4TlAvKjgISn2e80iOrc16nHlCA/uHbW4g2Wcz29PgZ?=
 =?us-ascii?Q?elStQce4FDaKUDCdnQk4g/hMOnM6N3Ua2ksJhCj1RnSfOyYRAJfi3RItlqIE?=
 =?us-ascii?Q?RA=3D=3D?=
X-OriginatorOrg: moxa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 133a18a7-5ead-43fa-106b-08dbf23d76b8
X-MS-Exchange-CrossTenant-AuthSource: PUZPR01MB5405.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2023 07:16:40.3086
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5571c7d4-286b-47f6-9dd5-0aa688773c8e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aHnZF/j0fysNg+rlZtoa5Dysb8O2Mo9ehPA3JKxT1FJ8bXclQB1fA+GDC8QFveG8LB6i8qzXIJVlJA7GjMBKclLeLBXHIZOSEib4hkmsObQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR01MB6537
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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

Signed-off-by: Crescent CY Hsieh <crescentcy.hsieh@moxa.com>
---
 drivers/tty/serial/serial_core.c | 6 ++++++
 include/uapi/linux/serial.h      | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 831d03361..a195ec1ab 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -1376,6 +1376,12 @@ static void uart_sanitize_serial_rs485(struct uart_port *port, struct serial_rs4
 		return;
 	}
 
+	/* Clear other RS485 flags but SER_RS485_TERMINATE_BUS and return if enabling RS422 */
+	if (rs485->flags & SER_RS485_MODE_RS422) {
+		rs485->flags &= (SER_RS485_ENABLED | SER_RS485_MODE_RS422 | SER_RS485_TERMINATE_BUS);
+		return;
+	}
+
 	/* Pick sane settings if the user hasn't */
 	if ((supported_flags & (SER_RS485_RTS_ON_SEND|SER_RS485_RTS_AFTER_SEND)) &&
 	    !(rs485->flags & SER_RS485_RTS_ON_SEND) ==
diff --git a/include/uapi/linux/serial.h b/include/uapi/linux/serial.h
index 6c75ebdd7..9086367db 100644
--- a/include/uapi/linux/serial.h
+++ b/include/uapi/linux/serial.h
@@ -138,6 +138,7 @@ struct serial_icounter_struct {
  * * %SER_RS485_ADDRB		- Enable RS485 addressing mode.
  * * %SER_RS485_ADDR_RECV - Receive address filter (enables @addr_recv). Requires %SER_RS485_ADDRB.
  * * %SER_RS485_ADDR_DEST - Destination address (enables @addr_dest). Requires %SER_RS485_ADDRB.
+ * * %SER_RS485_MODE_RS422	- Enable RS422. Requires %SER_RS485_ENABLED.
  */
 struct serial_rs485 {
 	__u32	flags;
@@ -149,6 +150,7 @@ struct serial_rs485 {
 #define SER_RS485_ADDRB			_BITUL(5)
 #define SER_RS485_ADDR_RECV		_BITUL(6)
 #define SER_RS485_ADDR_DEST		_BITUL(7)
+#define SER_RS485_MODE_RS422		_BITUL(8)
 
 	__u32	delay_rts_before_send;
 	__u32	delay_rts_after_send;
-- 
2.34.1

