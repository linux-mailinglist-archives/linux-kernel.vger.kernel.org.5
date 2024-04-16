Return-Path: <linux-kernel+bounces-147686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43D6D8A77B6
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 00:19:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67D461C21C6F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 22:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FC3413AA39;
	Tue, 16 Apr 2024 22:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=LIVE.NL header.i=@LIVE.NL header.b="tWq1uH37"
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01olkn2060.outbound.protection.outlook.com [40.92.64.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 735F913777C;
	Tue, 16 Apr 2024 22:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.64.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713305924; cv=fail; b=Rx15WlWaG6FHz9C1PLOch7yEDOJAL8XFyUuS++gch7RekMizyKrhkCRyvW0eS9CDqkMOpupiKl2iPmpkN1oTYnTP14AuGbl7tr/Tp3u17ReCsCm5CKkbz1xbEdvsDJJPlGVxrrCOaUANXh0qxSX/qhLYu/hSiiX/WY1gKmxS8Jw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713305924; c=relaxed/simple;
	bh=QDJJvpAHPsNCSVqmuCO7kQVxCxCVVOsklX++k4Jq5OI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LwdDi2V5jc+LEf5foeuX1vt5GjX/clD6IDt6lB+nTtpxZrZI8hD5ES/Uxg/qyZ9geaB+holqajamFwEHgMZUtIJ4ps4JNabWknINRyYaGfxn2QKsGyYe3QARYSMeHDUOnrLLhU7QaU3akmPj8c7L0bUgCcD4Rr3DUn1Nlxgke7s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.nl; spf=pass smtp.mailfrom=live.nl; dkim=pass (2048-bit key) header.d=LIVE.NL header.i=@LIVE.NL header.b=tWq1uH37; arc=fail smtp.client-ip=40.92.64.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=live.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=live.nl
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cBGsNbCEuZdIaFQWGEnNkS/nvwkz8l/UqE8uLlxA+zyo5LXXOhquyq3QWcPK1splGIfxrcwbje/cfFnGaxT/sDDSKq8asmm8U3I0AGhgzu78dBykAHA3tY8213RnQMfTEckH9lTROuuP+OHgFz0JPO2N6vExy7d7AJciYzoUn9ktgrSimdR9mBOq30Gx1AxCQ5FN72pweYRek6TjtuyIaJubojkD3PJAitErjN2rDgnK71h0nMzNypYm59kCiCwR7zyCpA3M7Ux4Y6CPVdZue52GMchf4qCsAuxyJ8m/WK+cogajZWo7dqq4rCLAaOy0O9hJwEXslFBfR/CduLPsbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K39q10R9C1RayyooyeKvFUTWftpyWkmzP58m9XrM/IA=;
 b=XPrr/zra0EDbc0HBp1vwG4zd6ki/xtaOqKEgMin9QtoG2NIHCPT5FsuCGuhU4+luwq5g4anSBtg4hHGJUlhljEcpjL8olhamCzBVYEFh0nzBvbzV5xmqfVHRrlY0lE+Ig9VJ1R1QxiZlyZJJBokbzQKSxHGzqqkf6+tzLHXNcuofCqSM7MDffBm6jgkAr67ApZjZcC4ktyTqAz2+NFZAGbHQjXEOPybAHydT7Xz+DXwHpUigpDKePA4JBkjEvWpu7qwT0ldAN7ohnuKfwr/m4JcF6IYj/iKYgDZzuchgyLn0Q+iIS1mE991bqB0oI8xbJuXSByHDQHpxvAPuqOaomg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=LIVE.NL; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K39q10R9C1RayyooyeKvFUTWftpyWkmzP58m9XrM/IA=;
 b=tWq1uH37v9WCxbRGBzn8DfesmjM3yFX0jmTlaGhsKL4UJROlG7UpRZmisV9rv3NXClaLaPZj3QndYtusl8JNzatVCUaR/wmrCcJSLFeApxWSifLpZLHw66unqZ1jRmCmXXTKTJpgIUC8yUnn4fh/K97KK3PmGvlWJ+gQJDBzjMIleDlbieBpEp/buQgmUNU7BETh731bhQ2WpmFUSIWYey0Eq+C0fP9vLqXHBYp2STIolo18pIfSXIhjHrRjjQc1Uy6pV8oxLxMzhBEUTxk7MqalHyAQ/ZKzFywEpUmIpx5IGOeS5If5Wri0GwLi9AuAkC1gKzxjSYXzGB7wpI20Wg==
Received: from AM0PR09MB2675.eurprd09.prod.outlook.com (2603:10a6:208:d3::24)
 by DU2PR09MB5357.eurprd09.prod.outlook.com (2603:10a6:10:276::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Tue, 16 Apr
 2024 22:18:38 +0000
Received: from AM0PR09MB2675.eurprd09.prod.outlook.com
 ([fe80::6881:178c:bae6:1644]) by AM0PR09MB2675.eurprd09.prod.outlook.com
 ([fe80::6881:178c:bae6:1644%6]) with mapi id 15.20.7452.049; Tue, 16 Apr 2024
 22:18:38 +0000
From: Paul Geurts <paul_geurts@live.nl>
To: mgreer@animalcreek.com,
	krzk@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	conor+dt@kernel.org,
	linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Paul Geurts <paul_geurts@live.nl>
Subject: [PATCH 2/2] NFC: trf7970a: Create device-tree parameter for RX gain reduction
Date: Wed, 17 Apr 2024 00:18:16 +0200
Message-ID:
 <AM0PR09MB2675AB84E150CCF698CF73BC95082@AM0PR09MB2675.eurprd09.prod.outlook.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1713305374.git.paul_geurts@live.nl>
References: <cover.1713305374.git.paul_geurts@live.nl>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [GMe95/uJwlAuyKkMPCMvZSzF08AmRkc6u01mCI1d9sco6cIb0NAABeDPFfoM8ySM]
X-ClientProxiedBy: AM0PR03CA0093.eurprd03.prod.outlook.com
 (2603:10a6:208:69::34) To AM0PR09MB2675.eurprd09.prod.outlook.com
 (2603:10a6:208:d3::24)
X-Microsoft-Original-Message-ID:
 <19a371556f8770c551ae89a107c43b3eb5eb378f.1713305374.git.paul_geurts@live.nl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR09MB2675:EE_|DU2PR09MB5357:EE_
X-MS-Office365-Filtering-Correlation-Id: a6c87ffb-95a0-4116-142c-08dc5e632a2a
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	V/LCffn7N6ZdxdbWenCtLA7T59BbsJdZ67KYvXxLWAVdjUQvfgT9EcltNpaHETDpVtvhvOkPdFKSRI08dLB1Ce5xxeGqbmb6pmTTP3spNisj9SrYZMOMPKjpzxGddHaqJRlBv4X3rI5WgoO9ExHhhLzNf6qWFYyHb2G5bfISn8Hl7btJIa3aV0xw0D5568GCVv/sup6G91Dq/4FSzOL2NKVLLIaG/eJ8Yu9WdxmPIEEUYzAUGlH8N0u9MAhuBdue9SLSGaceVMEqI5elSG+FSLgU8eKPKXEQs25l10/gief1GKIPlGAa07YGK7yuN92J9VxIjqmvfrosxz7WdF+RfR84boNJMR0UYUxiF2553kqDoYy7jeS/BJTSo9O1Ng5aYXdwyD/ZV7I7RY1yeR2nXKcG7ORqRmltTcttbVCnAIE/FaMopE0Lf05v0WaC5iwx8f8o28D/UJagM2dehhyTS2ycgYsLXqLybB0/xLdT23cyAstSohEIOPYH9pmrPoqBNin0QdwtMhCd6M+yIIEf31MKu0YMVGWbPiHdMslVK/RagYBMa+APD/fmNK0XN67DMAxLG7eRZlhFk74sNFQZh9MqPwEBHZXr9V1LYD8D216jaDesgHE2ab0fE5m5nldw
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dUEHAWh7XeXWKJcYZ9T3w/tGoKBue/qKmnSDZI2/57P3BY0KupdV4MI1A3en?=
 =?us-ascii?Q?37GpaUsRK/e8BwtXMG4ibcJo0NmEbhMrJL2/gP3FF+JSoHdsRsbSSojBruYm?=
 =?us-ascii?Q?jGjJGQji8cCXS1eCmmNVjGy2fYIjZQ12b/xH2xeVg0x/2OkCh7gIMPyBQRDv?=
 =?us-ascii?Q?1f2jgBTTG8upEa7BcYHXCR04/xRmSYPo8FELQXPRGdQycieQQweWJXky8OxH?=
 =?us-ascii?Q?Rr3Szewkw5QGam+vjBvZ+Q4dI7UuzkZSiMBbyG7QrUpSLpJrCg0KxbgTn62D?=
 =?us-ascii?Q?xar0XMN1irX9aIaLiPojtm7BsBpqvnPaJ5Ji2036rqvKS6PAuyWQGTLQhu+k?=
 =?us-ascii?Q?9OnLFaRoggC10MCWGzQfWvLEWkCwbqX6h4ftQT1/63knFFPYnaI5e5enXE1V?=
 =?us-ascii?Q?kP7QZrkYE23MveimIPxcSp/LiCsIiwCe/OpNgWuPB6mSfm5RquT0LYSw1Wpm?=
 =?us-ascii?Q?wK2sAioFDVAk3myyCAzhA8yPOn1gJBBjBRP9eSsGz1I4EvmXtyTs06x4oQjX?=
 =?us-ascii?Q?10RYVMoPPyMjqBTkwLQFpU4I0WkR+PoIt87Wf3oLQjisiICAXC2fMrrQY0Yc?=
 =?us-ascii?Q?ajkYcdSFOx9n45vZIlR/mpkAm2z2TbgDKou82K91zDpqLFGEirjjB/ddnb0+?=
 =?us-ascii?Q?CweiT5HOmOjqE2taT4JEETUbky/9KL81wBKFfBQbYqiJjxS5Roj1SraTMD5i?=
 =?us-ascii?Q?B560NFTbn07ko5f1pI28hUF+++g16ZKmcnzcyyv96AqKig0Pj4H/wkN5aYS4?=
 =?us-ascii?Q?vG1RVwhiahoT0wb6YATsfNoxFVCqLM7vws2BqRVvHZ5C9Mt8gxC+QQmwd5Tt?=
 =?us-ascii?Q?PHcf7201wZ7VgIi4EPuKvzvsdPz2KvwnzaVYfHloKdwb8ws4m/p13yzPPryv?=
 =?us-ascii?Q?ru4MuQFYEtiHSXLUS0wlkndyfPJuw3pH6DeOEwZdRV6ZC8YYYcGbFSgfv3Rf?=
 =?us-ascii?Q?g7DUTuPrmsiT1nizCwTjUsQjDKAi/MEMTjzWH1AHV64CiLmI4CpxR6CSZo0U?=
 =?us-ascii?Q?hJpqqS6pmmHUeXXVWD8xzlJHQpfAOyVji9b0eIpXR3a6AEXhzVvKbmPK6Zx/?=
 =?us-ascii?Q?vVq59tZgAGUHuAG7xvRNgOT24equ7I9d+5kSgmXb29QyZXxZ4QmKoBA9V1XE?=
 =?us-ascii?Q?ZV8r6XX2fFJhkQXcYLklMzUJD05niBUEQwjVEehZi7e3K0bXJUjsU71dJU3Y?=
 =?us-ascii?Q?nKMmzGo8YBcOLEcUCNswlDEfNaJBP+IlNk1Nv1yy7h4IN+6NnPhPeN5FpnJ5?=
 =?us-ascii?Q?po/ScGMucJMGZCHNvtBn58PUn2e8nt22ABh7YaStC+9r6ldH4EIG9KLHw2nz?=
 =?us-ascii?Q?7Yk=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-64da6.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: a6c87ffb-95a0-4116-142c-08dc5e632a2a
X-MS-Exchange-CrossTenant-AuthSource: AM0PR09MB2675.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2024 22:18:38.5039
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR09MB5357

The TRF7970a device is sensitive to RF disturbances, which can make it
hard to pass some EMC immunity tests. By reducing the RX antenna gain,
the device becomes less sensitive to EMC disturbances, as a trade-off
against antenna performance.

Add a device tree option to select RX gain reduction to improve EMC
performance.

Selecting a communication standard in the ISO control register resets
the RX antenna gain settings. Therefore set the RX gain reduction
everytime the ISO control register changes, when the option is used.

Signed-off-by: Paul Geurts <paul_geurts@live.nl>
---
 drivers/nfc/trf7970a.c | 86 ++++++++++++++++++++++++++++++++++++------
 1 file changed, 75 insertions(+), 11 deletions(-)

diff --git a/drivers/nfc/trf7970a.c b/drivers/nfc/trf7970a.c
index 7eb17f46a815..0991c717a5de 100644
--- a/drivers/nfc/trf7970a.c
+++ b/drivers/nfc/trf7970a.c
@@ -274,10 +274,14 @@
 
 #define TRF7970A_RX_SPECIAL_SETTINGS_NO_LIM	BIT(0)
 #define TRF7970A_RX_SPECIAL_SETTINGS_AGCR	BIT(1)
-#define TRF7970A_RX_SPECIAL_SETTINGS_GD_0DB	(0x0 << 2)
-#define TRF7970A_RX_SPECIAL_SETTINGS_GD_5DB	(0x1 << 2)
-#define TRF7970A_RX_SPECIAL_SETTINGS_GD_10DB	(0x2 << 2)
-#define TRF7970A_RX_SPECIAL_SETTINGS_GD_15DB	(0x3 << 2)
+#define TRF7970A_RX_SPECIAL_SETTINGS_GD_SHIFT	2
+#define TRF7970A_RX_SPECIAL_SETTINGS_GD_MAX	(0x3)
+#define TRF7970A_RX_SPECIAL_SETTINGS_GD_MASK	(TRF7970A_RX_SPECIAL_SETTINGS_GD_MAX << \
+							TRF7970A_RX_SPECIAL_SETTINGS_GD_SHIFT)
+#define TRF7970A_RX_SPECIAL_SETTINGS_GD_0DB	(0x0 << TRF7970A_RX_SPECIAL_SETTINGS_GD_SHIFT)
+#define TRF7970A_RX_SPECIAL_SETTINGS_GD_5DB	(0x1 << TRF7970A_RX_SPECIAL_SETTINGS_GD_SHIFT)
+#define TRF7970A_RX_SPECIAL_SETTINGS_GD_10DB	(0x2 << TRF7970A_RX_SPECIAL_SETTINGS_GD_SHIFT)
+#define TRF7970A_RX_SPECIAL_SETTINGS_GD_15DB	(0x3 << TRF7970A_RX_SPECIAL_SETTINGS_GD_SHIFT)
 #define TRF7970A_RX_SPECIAL_SETTINGS_HBT	BIT(4)
 #define TRF7970A_RX_SPECIAL_SETTINGS_M848	BIT(5)
 #define TRF7970A_RX_SPECIAL_SETTINGS_C424	BIT(6)
@@ -451,6 +455,8 @@ struct trf7970a {
 	unsigned int			timeout;
 	bool				ignore_timeout;
 	struct delayed_work		timeout_work;
+	u8				rx_gain_reduction;
+	bool			custom_rx_gain_reduction;
 };
 
 static int trf7970a_cmd(struct trf7970a *trf, u8 opcode)
@@ -550,6 +556,41 @@ static int trf7970a_read_irqstatus(struct trf7970a *trf, u8 *status)
 	return ret;
 }
 
+static int trf7970a_update_rx_gain_reduction(struct trf7970a *trf)
+{
+	int ret = 0;
+	u8 reg;
+
+	if (!trf->custom_rx_gain_reduction)
+		return 0;
+
+	ret = trf7970a_read(trf, TRF7970A_RX_SPECIAL_SETTINGS, &reg);
+	if (ret)
+		return ret;
+	reg &= ~(TRF7970A_RX_SPECIAL_SETTINGS_GD_MASK);
+	reg |= trf->rx_gain_reduction;
+
+	ret = trf7970a_write(trf, TRF7970A_RX_SPECIAL_SETTINGS, reg);
+
+	return ret;
+}
+
+static int trf7970a_update_iso_ctrl_register(struct trf7970a *trf, u8 iso_ctrl)
+{
+	int ret;
+
+	ret = trf7970a_write(trf, TRF7970A_ISO_CTRL, iso_ctrl);
+	if (ret)
+		return ret;
+	/*
+	 * Every time the ISO_CTRL register is written, the RX special setting register is reset by
+	 * the chip. When a custom gain reguduction is required, it should be rewritten now.
+	 */
+	ret = trf7970a_update_rx_gain_reduction(trf);
+
+	return ret;
+}
+
 static int trf7970a_read_target_proto(struct trf7970a *trf, u8 *target_proto)
 {
 	int ret;
@@ -929,8 +970,7 @@ static irqreturn_t trf7970a_irq(int irq, void *dev_id)
 			}
 
 			if (iso_ctrl != trf->iso_ctrl) {
-				ret = trf7970a_write(trf, TRF7970A_ISO_CTRL,
-						     iso_ctrl);
+				ret = trf7970a_update_iso_ctrl_register(trf, iso_ctrl);
 				if (ret)
 					goto err_unlock_exit;
 
@@ -1034,6 +1074,11 @@ static int trf7970a_init(struct trf7970a *trf)
 	if (ret)
 		goto err_out;
 
+	/* Set the gain reduction after soft init */
+	ret = trf7970a_update_rx_gain_reduction(trf);
+	if (ret)
+		goto err_out;
+
 	ret = trf7970a_cmd(trf, TRF7970A_CMD_IDLE);
 	if (ret)
 		goto err_out;
@@ -1308,7 +1353,7 @@ static int trf7970a_in_config_framing(struct trf7970a *trf, int framing)
 	}
 
 	if (iso_ctrl != trf->iso_ctrl) {
-		ret = trf7970a_write(trf, TRF7970A_ISO_CTRL, iso_ctrl);
+		ret = trf7970a_update_iso_ctrl_register(trf, iso_ctrl);
 		if (ret)
 			return ret;
 
@@ -1440,7 +1485,7 @@ static int trf7970a_per_cmd_config(struct trf7970a *trf,
 		}
 
 		if (iso_ctrl != trf->iso_ctrl) {
-			ret = trf7970a_write(trf, TRF7970A_ISO_CTRL, iso_ctrl);
+			ret = trf7970a_update_iso_ctrl_register(trf, iso_ctrl);
 			if (ret)
 				return ret;
 
@@ -1604,8 +1649,7 @@ static int trf7970a_tg_config_rf_tech(struct trf7970a *trf, int tech)
 	 */
 	if ((trf->framing == NFC_DIGITAL_FRAMING_NFC_DEP_ACTIVATED) &&
 	    (trf->iso_ctrl_tech != trf->iso_ctrl)) {
-		ret = trf7970a_write(trf, TRF7970A_ISO_CTRL,
-				     trf->iso_ctrl_tech);
+		ret = trf7970a_update_iso_ctrl_register(trf, trf->iso_ctrl_tech);
 
 		trf->iso_ctrl = trf->iso_ctrl_tech;
 	}
@@ -1653,7 +1697,7 @@ static int trf7970a_tg_config_framing(struct trf7970a *trf, int framing)
 	trf->framing = framing;
 
 	if (iso_ctrl != trf->iso_ctrl) {
-		ret = trf7970a_write(trf, TRF7970A_ISO_CTRL, iso_ctrl);
+		ret = trf7970a_update_iso_ctrl_register(trf, iso_ctrl);
 		if (ret)
 			return ret;
 
@@ -1754,6 +1798,10 @@ static int _trf7970a_tg_listen(struct nfc_digital_dev *ddev, u16 timeout,
 	if (ret)
 		goto out_err;
 
+	ret = trf7970a_update_rx_gain_reduction(trf);
+	if (ret)
+		goto out_err;
+
 	ret = trf7970a_write(trf, TRF7970A_REG_IO_CTRL,
 			     trf->io_ctrl | TRF7970A_REG_IO_CTRL_VRS(0x1));
 	if (ret)
@@ -1944,6 +1992,10 @@ static int trf7970a_startup(struct trf7970a *trf)
 	if (ret)
 		return ret;
 
+	ret = trf7970a_update_rx_gain_reduction(trf);
+	if (ret)
+		return ret;
+
 	pm_runtime_set_active(trf->dev);
 	pm_runtime_enable(trf->dev);
 	pm_runtime_mark_last_busy(trf->dev);
@@ -1992,6 +2044,7 @@ static int trf7970a_probe(struct spi_device *spi)
 	struct trf7970a *trf;
 	int uvolts, autosuspend_delay, ret;
 	u32 clk_freq = TRF7970A_13MHZ_CLOCK_FREQUENCY;
+	u32 rx_gain_reduction;
 
 	if (!np) {
 		dev_err(&spi->dev, "No Device Tree entry\n");
@@ -2053,6 +2106,17 @@ static int trf7970a_probe(struct spi_device *spi)
 		trf->modulator_sys_clk_ctrl = 0;
 	}
 
+	if (of_property_read_u32(np, "rx-gain-reduction", &rx_gain_reduction) == 0) {
+		if (rx_gain_reduction > TRF7970A_RX_SPECIAL_SETTINGS_GD_MAX) {
+			dev_warn(trf->dev, "invalid RX gain reduction setting: %u. Limiting to %u\n",
+				 rx_gain_reduction, TRF7970A_RX_SPECIAL_SETTINGS_GD_MAX);
+			rx_gain_reduction = TRF7970A_RX_SPECIAL_SETTINGS_GD_MAX;
+		}
+		trf->rx_gain_reduction = (rx_gain_reduction <<
+			TRF7970A_RX_SPECIAL_SETTINGS_GD_SHIFT);
+		trf->custom_rx_gain_reduction = true;
+	}
+
 	ret = devm_request_threaded_irq(trf->dev, spi->irq, NULL,
 					trf7970a_irq,
 					IRQF_TRIGGER_RISING | IRQF_ONESHOT,
-- 
2.20.1


