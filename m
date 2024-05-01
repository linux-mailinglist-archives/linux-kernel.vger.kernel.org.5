Return-Path: <linux-kernel+bounces-165532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23A7A8B8DAC
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 18:05:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0602B2350A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 16:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA0E612FF64;
	Wed,  1 May 2024 16:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="o/zpxaEg"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04olkn2071.outbound.protection.outlook.com [40.92.45.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 369731304AA;
	Wed,  1 May 2024 16:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.45.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714579439; cv=fail; b=F18pSzWUl9y9RJwMO2CdZICS6I1iZurdnKTIQIMmQc0NOmXp8u6cr24OBMWGB15s0kHCWq1GCa1GbJKH+eGWc4nmyBDFJNFsSILKTHbi9sBDDG9d0HPgztQN4JOhOBpLbUW8xlsw9U7Yb/9WPUW2ErSJjLL5rcIZcLov2lPtqyg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714579439; c=relaxed/simple;
	bh=lBev2nx+Rwa/bnJJgAjIrRVrYkHTGj8aoqvOO+ETPmQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=D0Qwf9a5idOe5/UlM+t8wtNGWaUeDNjH5w95Rvegnb55JsXOQp7pEZgAJo9OGx98/5Wg3TZb03KhGfUbIZHgfIMB6NQu8/aDNPwSb5gcg7ePoutojVcPWVdqOduqtwdoQ1VLtYoxpBpb9VsnaTzzZjH0D89C5zvJd0ROmX3xuBc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=o/zpxaEg; arc=fail smtp.client-ip=40.92.45.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KfMdX9GTwD0wpS6JZ4tyWHScNutTT80XJqFcJo54jIBnVunZOWOHW3/nBOKzijYHZsAn9ocAudrCk2efeKIAQFbUr0R3GUvYyqUZAlHQt/nVn+dw4n4RGsJioeMheyv5ah61nZdElw1STYKB4L2CeZej5ioFchGekKBL/uOLu++kTL3HoimkxGUDq4flrxzCVw4gM7EiEiAca3guux5p/jkyCRfHpbFfjvryIhAA5YGvhzSXc2ya85K9ok3huW/l7uWovVoqdi/Jw3m5nh/vQzVIdUwypL9C6xljZtRerMk2XaOfcG1p+up3yTeo8IkA9GD58cMjYQSF9ArWWJ0vbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yoNEDh+iFq7lzKBU9CENiMetKrSdJTglln2bu+84U0E=;
 b=LDLTVBxU6i2kAaMXxJtVJZquQDklXPjG7kgMRreWvAxz1+OXVHB7whCKK6K3xmz6xxCMa/7T5lUFVEgibRNWUfEVkt8Vu1SymONGLyvgAQNkEDQjOZCiIxKusc2yHmv8y18S4b/DKQpcEmngINznaLYczJ6nxLhlQCTJZKNP+0Ns0KxB7FUPrenDw0wVwIkdTVhEIN3GoXDCXW4x9hFhTws7oow6PvK+Xd2+OIIUmO3W9K9vwod6SKinkZg7H1fOaC7GcJ5DvGxd6k3+8rfnoh8udkBhx27+X0rD2zMZFdawlC7tvHM0WbX7tV59x+Eko/IGDT4Dbc07ah8qGC5ZTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yoNEDh+iFq7lzKBU9CENiMetKrSdJTglln2bu+84U0E=;
 b=o/zpxaEgb7LFmApOPrucIsye4LllxHus2gdobl+6TmGeTDEOe6X/MhJnwaq7W9abLJUfE/5avpIRWQvrBc+w1UqEPwaVbmxazVfvv8VkM+AsRTebd41r4EtYcBsZOrDBT4/k9RlUitIP5GEWtTAkwTo+Err82K1VVk3qZsI6W2KwnUaG8Y1iETuzw3YQ5YvvSem8v/CH/cwfxGSm3i+/UhH8TpM9VfWPN46DB/lfYm0Ao+qCZKZijC57rRQbDlMIXiFlnmV5iRgxh7A88Bwm2W0ANSj1rQQUPZEVX0UKSCuA8ratoGeRhgowJTa+tN1iV8KKfK7KVl3wPt/oGaADgg==
Received: from LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:1ac::6)
 by EA2P220MB1331.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:257::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.28; Wed, 1 May
 2024 16:03:51 +0000
Received: from LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM
 ([fe80::7d42:dbbf:4d41:6999]) by LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM
 ([fe80::7d42:dbbf:4d41:6999%4]) with mapi id 15.20.7544.023; Wed, 1 May 2024
 16:03:51 +0000
From: Min Li <lnimi@hotmail.com>
To: richardcochran@gmail.com,
	lee@kernel.org
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Min Li <min.li.xe@renesas.com>
Subject: [PATCH net-next v7 4/5] ptp: clockmatrix: Fix caps.max_adj to reflect DPLL_MAX_FREQ_OFFSET[MAX_FFO]
Date: Wed,  1 May 2024 12:03:23 -0400
Message-ID:
 <LV3P220MB12026BB3CBA7FCE8480438FBA0192@LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240501160324.27514-1-lnimi@hotmail.com>
References: <20240501160324.27514-1-lnimi@hotmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [IdUgggu3wXRCbNpBN3M6bqWA/4XT2Z5y]
X-ClientProxiedBy: MN2PR18CA0016.namprd18.prod.outlook.com
 (2603:10b6:208:23c::21) To LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:408:1ac::6)
X-Microsoft-Original-Message-ID: <20240501160324.27514-5-lnimi@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3P220MB1202:EE_|EA2P220MB1331:EE_
X-MS-Office365-Filtering-Correlation-Id: db463bf8-941a-44f4-6971-08dc69f84aae
X-Microsoft-Antispam: BCL:0;ARA:14566002|461199019|440099019|3412199016;
X-Microsoft-Antispam-Message-Info:
	UFTT1jZ8joSCknJj6EuBEzb0JPDflDqxFCVpiqkpmqHaFmwH5eMhUKkdEwwGfZz6CmdfNhcyhIvbuHzDja6s9f3m/+WtbyBHW1tc1KC+tW7XpZpFdBINg53l5LhVTWGMtHQLfjoHsGRSNdQmH/5muOVfraa/Ey465fOC3FqjZ7b2AVahNomt0khePep+gOx3q2YH2ZdagBBc7jXZaShLWYdJ8T+g1ppawGE7U87JOFuH+JiH1e6+Sz5Umtw1PpaMHFvtkaPwDAQqTn3t5+Y7YZaVtrTM0fmN0ZmYhBD//UKg2kiKEeArKxVOVRm0oc2v2z5ocEBsID8kGFrbvMe0K6uvh4HeKZYkJHQ4OfwMpXQtnFaJa1b1YA6Gi7AR8Tf4GcFCfGyJ/fIInOH0foyVst2mM5gZFk8FRP1Sm5K/VOUx2djYm6PGD5DJ5MTysY2CXdQpimmASRHWWwUudUnmQ5QvkW8FV4YBJMaKCDBr/iTVZWm7qgjZOO2Hci0HioUUFT5CgujfMTkNjnegFWr4wV2z/Ke7HXpgK1lybRaimYmrTDMFt05oZvEjWF5VD78e
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PZm6FM1NsaVU23Jj0JSaR7zVtN1dYFkJ3ggNtFfWoNVZLMWudJSFwozYo86U?=
 =?us-ascii?Q?9S176f0pEXKGf/bVjtzRHWOyQH8fkAcqqS1nnHItbaw+6E4ErgSaQ4caQ7Up?=
 =?us-ascii?Q?ycuULamM598FD2DIic/utRWJjJFr7pcFSuj452X8sh94MIVgzLo5UvYpj5mR?=
 =?us-ascii?Q?a8Yfc4ge4u/XzuRdmx/O4cW/HpCPSmpHPk3x4POdG12kZ0zEs+KmJtSfzA6N?=
 =?us-ascii?Q?bLV6FTXC1pAWjpxN2nkGlRlJ7IWIzz6wRtaMGXSKiasgTp7xnlZB946hHj/Z?=
 =?us-ascii?Q?FZm2KRWW6E482WV9HC8Z0uLiuiKn2env4ucb8c+mHwUchJb/IzrUGK8YYMZf?=
 =?us-ascii?Q?pX+h37DY7tUkgnR8wkaKfR/fL2wiPCZDU06mWyCwj1xIfJ3zeV3B1r8U1Ejn?=
 =?us-ascii?Q?uJXYQqEbwYyW0P0g1iQi+kDQ+xUCLx5IsZcBFTJZnWhanIAX20yP5gBmgDp8?=
 =?us-ascii?Q?tlHBBl6Z3934ku+o6Mq+ptSLphcOwujSo30sJMxUM9xgimZWVnCIpadxvy9t?=
 =?us-ascii?Q?azjfIEds4XHzS7yclyw+lC4rlHjMw7yKFdAqCZ6t4FYzVm4hLCzTULriveAI?=
 =?us-ascii?Q?4wfCf4/oq/uJDccRM/JNBa1Nhmt59Eg6CYLpMFYG5lJJA3BnBR8j0g4WvRu+?=
 =?us-ascii?Q?Q+txGtrIaB0cf5Th4crUzLyqsQ1dzBCXaZ1wAiyq1bjE6XPza8ZMoLEwZyIh?=
 =?us-ascii?Q?JV51f6dHM5vxhoTHfCngw4mKrw0Ffy7b0jkJ2Vl9LusPqGdepz/YPoAQlDNO?=
 =?us-ascii?Q?CkiHoKr74mXLGQc5jGmHqtTPy88xIso/HT43PfQ0BL93FrB57toRNnmvKpfM?=
 =?us-ascii?Q?2fabOSuYZsjjFF+iTvxPuDTQtI4RFuOscFYUXiH9+kDHoAvaJWs1qWU7ra2I?=
 =?us-ascii?Q?0Kk1dn8jsUI/xVjKhjzMxLpyl9kcL0AEEs0QuuRj81bgv4aM0t0/yq2M/HX0?=
 =?us-ascii?Q?m4SmPxo4npsSrCTSF5AGFEL2TBLvjeCrac3LCftF0JV+HQaqGpIeH7Y9P8t7?=
 =?us-ascii?Q?5DGeieOXEw1cJtS3JOPP/LApgOwgbw9GBbg56LW/2jrwi/oKcFahfhtl6o1x?=
 =?us-ascii?Q?FqVc+lE1WotYyv8rWW9JU4H/2Y0Rpai5kX+omrGT69VvKwqD739c909n1Pbq?=
 =?us-ascii?Q?0JwQxE0w88+2Sd26qLGDwVlRQ0aUZnJBXN/vFzei1MenkczC7dHoJk2htTx4?=
 =?us-ascii?Q?oEVL6mSoRFZotF0PKVphZRNj1B6pCHe3O+D2QdA9F96JPPgQd3edfK95T3E?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-3458f.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: db463bf8-941a-44f4-6971-08dc69f84aae
X-MS-Exchange-CrossTenant-AuthSource: LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2024 16:03:50.7889
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EA2P220MB1331

From: Min Li <min.li.xe@renesas.com>

Query MAX_FREQ_OFFSET register to set the proper limit.

Signed-off-by: Min Li <min.li.xe@renesas.com>
---
 drivers/ptp/ptp_clockmatrix.c    | 43 +++++++++++++++++++++++++-------
 drivers/ptp/ptp_clockmatrix.h    |  1 +
 include/linux/mfd/idt8a340_reg.h |  1 +
 3 files changed, 36 insertions(+), 9 deletions(-)

diff --git a/drivers/ptp/ptp_clockmatrix.c b/drivers/ptp/ptp_clockmatrix.c
index 21f3a2c179f5..cd7b3110f8e4 100644
--- a/drivers/ptp/ptp_clockmatrix.c
+++ b/drivers/ptp/ptp_clockmatrix.c
@@ -1038,7 +1038,7 @@ static int _idtcm_adjtime_deprecated(struct idtcm_channel *channel, s64 delta)
 	s64 now;
 
 	if (abs(delta) < PHASE_PULL_IN_THRESHOLD_NS_DEPRECATED) {
-		err = channel->do_phase_pull_in(channel, delta, 0);
+		err = channel->do_phase_pull_in(channel, delta, channel->caps.max_adj);
 	} else {
 		idtcm->calculate_overhead_flag = 1;
 
@@ -1594,7 +1594,7 @@ static int do_phase_pull_in_sw(struct idtcm_channel *channel,
 	if (abs(delta_ns) < PHASE_PULL_IN_MIN_THRESHOLD_NS)
 		return 0;
 
-	if (max_ffo_ppb == 0)
+	if (max_ffo_ppb == 0 || max_ffo_ppb > PHASE_PULL_IN_MAX_PPB)
 		max_ffo_ppb = PHASE_PULL_IN_MAX_PPB;
 
 	/* For most cases, keep phase pull-in duration 1 second */
@@ -1880,7 +1880,7 @@ static int idtcm_adjtime(struct ptp_clock_info *ptp, s64 delta)
 	mutex_lock(idtcm->lock);
 
 	if (abs(delta) < PHASE_PULL_IN_THRESHOLD_NS) {
-		err = channel->do_phase_pull_in(channel, delta, 0);
+		err = channel->do_phase_pull_in(channel, delta, channel->caps.max_adj);
 	} else {
 		if (delta >= 0) {
 			ts = ns_to_timespec64(delta);
@@ -1927,9 +1927,6 @@ static int idtcm_adjfine(struct ptp_clock_info *ptp,  long scaled_ppm)
 	if (channel->phase_pull_in == true)
 		return 0;
 
-	if (scaled_ppm == channel->current_freq_scaled_ppm)
-		return 0;
-
 	mutex_lock(idtcm->lock);
 	err = _idtcm_adjfine(channel, scaled_ppm);
 	mutex_unlock(idtcm->lock);
@@ -2054,7 +2051,7 @@ static struct ptp_pin_desc pin_config[MAX_TOD][MAX_REF_CLK];
 
 static const struct ptp_clock_info idtcm_caps = {
 	.owner		= THIS_MODULE,
-	.max_adj	= 244000,
+	.max_adj	= MAX_FFO_PPB,
 	.n_per_out	= 12,
 	.n_ext_ts	= MAX_TOD,
 	.n_pins		= MAX_REF_CLK,
@@ -2071,7 +2068,7 @@ static const struct ptp_clock_info idtcm_caps = {
 
 static const struct ptp_clock_info idtcm_caps_deprecated = {
 	.owner		= THIS_MODULE,
-	.max_adj	= 244000,
+	.max_adj	= MAX_FFO_PPB,
 	.n_per_out	= 12,
 	.n_ext_ts	= MAX_TOD,
 	.n_pins		= MAX_REF_CLK,
@@ -2242,6 +2239,25 @@ static int configure_channel_tod(struct idtcm_channel *channel, u32 index)
 	return 0;
 }
 
+static int initialize_max_adj(struct idtcm_channel *channel)
+{
+	struct idtcm *idtcm = channel->idtcm;
+	u8 ffo_ppm;
+	int err;
+
+	err = idtcm_read(idtcm, channel->dpll_n, DPLL_MAX_FREQ_OFFSET,
+			 &ffo_ppm, sizeof(ffo_ppm));
+	if (err)
+		return err;
+
+	if (ffo_ppm && ffo_ppm <= (MAX_FFO_PPB / 1000))
+		channel->caps.max_adj = ffo_ppm * 1000;
+	else
+		channel->caps.max_adj = MAX_FFO_PPB;
+
+	return 0;
+}
+
 static int idtcm_enable_channel(struct idtcm *idtcm, u32 index)
 {
 	struct idtcm_channel *channel;
@@ -2285,6 +2301,10 @@ static int idtcm_enable_channel(struct idtcm *idtcm, u32 index)
 		ppd->chan = index;
 	}
 
+	err = initialize_max_adj(channel);
+	if (err)
+		return err;
+
 	err = initialize_dco_operating_mode(channel);
 	if (err)
 		return err;
@@ -2437,8 +2457,13 @@ static int idtcm_probe(struct platform_device *pdev)
 
 	err = idtcm_load_firmware(idtcm, &pdev->dev);
 
-	if (err)
+	if (err) {
+		if (err == -ENOENT) {
+			mutex_unlock(idtcm->lock);
+			return -EPROBE_DEFER;
+		}
 		dev_warn(idtcm->dev, "loading firmware failed with %d", err);
+	}
 
 	wait_for_chip_ready(idtcm);
 
diff --git a/drivers/ptp/ptp_clockmatrix.h b/drivers/ptp/ptp_clockmatrix.h
index ad39dc6decdf..31d90b1bf025 100644
--- a/drivers/ptp/ptp_clockmatrix.h
+++ b/drivers/ptp/ptp_clockmatrix.h
@@ -19,6 +19,7 @@
 #define MAX_REF_CLK	(16)
 
 #define MAX_ABS_WRITE_PHASE_NANOSECONDS (107374182L)
+#define MAX_FFO_PPB (244000)
 
 #define TOD_MASK_ADDR		(0xFFA5)
 #define DEFAULT_TOD_MASK	(0x04)
diff --git a/include/linux/mfd/idt8a340_reg.h b/include/linux/mfd/idt8a340_reg.h
index b680a0eb5f68..13b36f4858b3 100644
--- a/include/linux/mfd/idt8a340_reg.h
+++ b/include/linux/mfd/idt8a340_reg.h
@@ -192,6 +192,7 @@
 #define DPLL_CTRL_REG_0                   0x0002
 #define DPLL_CTRL_REG_1                   0x0003
 #define DPLL_CTRL_REG_2                   0x0004
+#define DPLL_MAX_FREQ_OFFSET              0x0025
 #define DPLL_WF_TIMER                     0x002c
 #define DPLL_WP_TIMER                     0x002e
 #define DPLL_TOD_SYNC_CFG                 0x0031
-- 
2.39.2


