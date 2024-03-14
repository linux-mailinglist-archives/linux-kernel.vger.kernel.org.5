Return-Path: <linux-kernel+bounces-103515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D23387C078
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 16:38:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B07D01C21839
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 15:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E633071B48;
	Thu, 14 Mar 2024 15:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="O7pnVY0M"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04olkn2103.outbound.protection.outlook.com [40.92.47.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F3DB71B3C;
	Thu, 14 Mar 2024 15:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.47.103
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710430651; cv=fail; b=ukkfyXwJThUplVMoAukbmctPxJmrBYBXErPp8849JDARdyH1xKZI/fdOYTwneYa89D0KCqTtgfihIl1G5y9EEvTQRjCMOioM6/6SxiE9HDpFjiR0Y4CjNwicI09D+PHlcKVRorixrs2JQWbvGs8U5W0bfDlkgMxpWuqTT066vY4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710430651; c=relaxed/simple;
	bh=lBev2nx+Rwa/bnJJgAjIrRVrYkHTGj8aoqvOO+ETPmQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=W16t3pULEe8x3+vQ2A1dhCne5GggAk4sodylzXrdXTsa7KyHyEj9VZhVuRVLOvdqBo754n/AzMPlvpU+nNN9O3q0RXd9gB0c0dDAyBTO4EQ4s6YfEke3kK/78eSnMiI2xA5mphwgkzKYygmf/QUEZIR9PL4CNVfT227tIWoDI04=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=O7pnVY0M; arc=fail smtp.client-ip=40.92.47.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LG2i+f6uWRlN6azCdj8c2u2Hrtgddft07qRuArbT/7OVbh+/a0YDESRNS+KnDTehkHKm+nfVKw8rzh7kWiOsZlMVoJ6UWsxUtic6gEfldttD3C8DLJptxwvdWIjGXduCx36M9zLG5AfXslCSQ3LdN6MCnzHohV6Exnm9C+Q/a4kkd2YS+Adnok1tORoSSHwsGcgiSCJQdaHm3K1pfYNB6o7X7MqxqtIkmwrY4+A7DMplpnz6AZNP3puamVpZmLuULpqzBhLlMf+PSVyu4GdlbFH9pI7rUTcl/WS/q3MGZGHXROfrFp42a0gJD77P9UnyvLf4Wk8sjujLMDVIr5GpWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yoNEDh+iFq7lzKBU9CENiMetKrSdJTglln2bu+84U0E=;
 b=XX3+u7ns1MxYPNRtOgeZqt8keqB1oGDLyXPgzIF9edgYRwGDzqM7fHIS5EGFs8nMvqAmEqmGz5T0YxEuNIPCMs2mLypsRN9IiRtXgFfvpLZyCRhXNoM6NV57ZltU8JFA5zAKP1YeYmmZHdhVEqAacmzlVevFAmS2S+92xrxHkX5glqktLatMKNufM5y7yQNIgb1OGkKzdTLwB1Oa1wRb0CSSsSpUtpN3U5JKTkyFFY0p0K1tKchS3d1tdQ5EUd3CbhGrvzYfrW2SKBML7YISPJy0cKqMwZwR3PF1RnXyh7o4ai14/XfK5G9WswU9Hru1RPJzFtg80jDp3dd+KHkPtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yoNEDh+iFq7lzKBU9CENiMetKrSdJTglln2bu+84U0E=;
 b=O7pnVY0MfJIbZu8VhJiSb+fuOr+Pyy322xOhXlGhMLSSmCra/24m387jbhrl550XDHu0GkxYzjYfLB+AQe0pBnhTytwgE63UZ7SEiVNT8Iz5Zn7wBi0eaii9Xnc4g6woW/lk5JIMFQBeZu96u6LUw8Bj9BJ2jatlAOer+/m9OlTQwRAVwjWQAYjDPRxBXyk+uGoiPCjuUo4ML5ktTc9tfe0958Ha13FSg5DFtDZdfVxKbgVQwXflmwLIX3LJMtD67jf1iU+l1wuI8rWqc2AGlysKE1Azb8lgqh97JoeMGAja7n1e4DKRtSOxII1q5f3LIJg7dtW2Cx9LHieC2SoPgQ==
Received: from LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:1ac::6)
 by PH7P220MB1063.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:31f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Thu, 14 Mar
 2024 15:37:26 +0000
Received: from LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM
 ([fe80::57aa:102b:db4b:e05]) by LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM
 ([fe80::57aa:102b:db4b:e05%7]) with mapi id 15.20.7386.017; Thu, 14 Mar 2024
 15:37:26 +0000
From: Min Li <lnimi@hotmail.com>
To: richardcochran@gmail.com,
	lee@kernel.org
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Min Li <min.li.xe@renesas.com>
Subject: [PATCH net-next v7 4/5] ptp: clockmatrix: Fix caps.max_adj to reflect DPLL_MAX_FREQ_OFFSET[MAX_FFO]
Date: Thu, 14 Mar 2024 11:37:06 -0400
Message-ID:
 <LV3P220MB12028CD708A65633F55B01F6A0292@LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240314153707.31551-1-lnimi@hotmail.com>
References: <20240314153707.31551-1-lnimi@hotmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [HJW/M7Gn5LER1pceoInwWyEsVMurQO1K]
X-ClientProxiedBy: YQBPR0101CA0208.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:67::31) To LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:408:1ac::6)
X-Microsoft-Original-Message-ID: <20240314153707.31551-4-lnimi@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3P220MB1202:EE_|PH7P220MB1063:EE_
X-MS-Office365-Filtering-Correlation-Id: 274125dc-20d4-498a-99e4-08dc443ca69d
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	S5BmreBY4HzmIAIt4Hvi9GsZ8/59UeppWJ48dvt5kZpm/utoOZquKKpAEf7kolLi9KYMP2WneUhTS5Y78b5gR8nwv4kvQoDCGdo1H8Uyop1rIzRmfItDkYRlXnL8wcpO9wTAvrNsK9dMsEo3IIRqVj0gPwzlrRI2L5yq0VKUmkTomDXcnjIFr4K3nfRedk1KRgp44dNTFErCwIheFFA2mdFS6DCXe3kAlkXE/ZqvUnj1jybUnhVS+b20nDcTCldxm9LyBJMt9mJgN+NDr4nl710NFTEv7sF52ysnFNxJ/pFXzqsPYiF+Jd66SiCL2lzXoBRElicjv1leR+V7d8RDxMrjTMdw2RzPdyG2COVL7r/qmf72m2x/r1v6+32Duhd6kK3k5JYMmMv5J9sUufXzb/wZEAuDIzztL9sZzNlM7woCh4M1Dzk65T3PVl6J6fXou4BroV4okU65FNr6h66dEyZ5y+y+zUUTX4jLWHC9bHiVlDlDz0DU6kphAkv1AtXWMDMPPDVDV02sI+jfC5k5M8xn+6mqQbPpN+uUvgAa9rbEIlwarRPAqnKJuS0SWzSK
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GiP3iqpo4ASGEKb/rF0E7IhkTAJThIwsE6ayQNKQgDOU+JMCZNpn3ECyPr6p?=
 =?us-ascii?Q?1oF+nTVQqRS+gduJOboQwnypz1DMsRfiVjCHzEyQwr6+MWsCHWT/Qwe8vCwL?=
 =?us-ascii?Q?Fpc4I/nscIWVOggmBNimODv0vSKvl/y57HtTuL3N+0X1lPeNR8KBgibVng2I?=
 =?us-ascii?Q?uQAqis1+/PetrT4cohSR3iqOl6wGRDDFrHGJEWust6c73Zg2f77orr/1i+Dm?=
 =?us-ascii?Q?wiohMtYVj8Zs9MK7Ddcen8dnLtgEDq1W1CGl28m7jjbcLlAeP1duXtW3HpUS?=
 =?us-ascii?Q?KHK2OquD6vBub/WaPsqa6hXWpBeR5QDnHrW3dSAv6PCZsduX3ZZ45P8DcUoN?=
 =?us-ascii?Q?2Quc2c6StvWlykpLbXbFnvkvUJLKF4rPjEnAwzIFFyQYqkVuKbwb8TaRRlhu?=
 =?us-ascii?Q?qOeDo6FU2jdpPdzGtFktV5buGS30W5nn0foepHhi/23kZIhSwT1voaGBkhHy?=
 =?us-ascii?Q?8IDeKfVClkQIHTea6PrfQJI+Nu3Fo98dN6yoobjTNQUD39tHJ+4xBmsGxg9O?=
 =?us-ascii?Q?tLYbEsGsw7Ty36K3m1JuNnte/dlkhv6+w/L1goyAW2GrpKGHVnhHeTou/d7e?=
 =?us-ascii?Q?O9by/b05GTCigZsXlP0Iua6Nmc9UTxYRMFChcN9IXE40cdH1QS7SSU1ar2Fq?=
 =?us-ascii?Q?tr4ikBf8NgKKbnhi/e/5AoVCVV7kahMK+JQWsQvO1bcndUe8U78UNORfOQMn?=
 =?us-ascii?Q?4PjVIpT1Z7lA9z0is9WK0p7dq5WlqQjPeQlAB0SXpKGbMo2ZdRjuuvHpRS+k?=
 =?us-ascii?Q?4koe8MPIfGRf/cSdd3PlxzsBQL0cas83CV/8Ft+4RBs/NufkixnFuSEwGgoZ?=
 =?us-ascii?Q?AHuUB+poM7kjanlqaQVOKnMHR8k0gfaAk9c9cSS0jKLeTlZi449+q5xOa85e?=
 =?us-ascii?Q?ilo0xotQ7tDoGJXRhRD0TXmJEWGp3RaqZNIMdw5z+0UoQqr2um/LyH2MkNIH?=
 =?us-ascii?Q?XoObH1mnUZ/6K7PF3YotTe/SBf/EqDdoOVdpsbDHd5AyvyIadeqjHJSVtc2d?=
 =?us-ascii?Q?sCK2qCjwJaYDheZq1Emz66o6DP5eOSeAyH2aOJDGj4/+KjAAJAtseQTBkyFp?=
 =?us-ascii?Q?D18peI4A98Q2mHgmRKmg/a8/eoMCjheG5xyq44fAmKTd4WymrOOI/mNfE/RJ?=
 =?us-ascii?Q?IfpSleI3U2sn/A4XNYbzaA8aOBTskpEK2KaRGWLqwCQueAHrFIsDGC6ORmKW?=
 =?us-ascii?Q?W7ygbS42/ZLPBK3n3GcEbxTfL9UxyA6gewN/7vjWkYi91VjrhPLnqelryZY?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-3458f.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 274125dc-20d4-498a-99e4-08dc443ca69d
X-MS-Exchange-CrossTenant-AuthSource: LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2024 15:37:26.6301
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7P220MB1063

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


