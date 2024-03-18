Return-Path: <linux-kernel+bounces-106459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 789B987EEE3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 18:34:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98CBC1C22105
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 17:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8389455C1B;
	Mon, 18 Mar 2024 17:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="DbOPxPpc"
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02olkn2042.outbound.protection.outlook.com [40.92.43.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A7A56765;
	Mon, 18 Mar 2024 17:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.43.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710783167; cv=fail; b=q+so64G36i5IdILnBeZMrWPBJY8AGiv5EHnsb0JCO9ro/A/GPMbM+35H0WsGT7PkwHfKUFhg3BgWcU7FmAVAUZ6Y+6g+c6u0l+RqpQAvhhL3vSS3rQaDpwYzZ1U+cgPf5lAAYHkReDGoAMFtbcvSsPDnsytA5j3Z08G4tq/ehlQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710783167; c=relaxed/simple;
	bh=lBev2nx+Rwa/bnJJgAjIrRVrYkHTGj8aoqvOO+ETPmQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bfCxQPravG2B2+ZX2q8CHnqTzCuelDdescEcP9x9qIB6JPfUbMTDMhDzZ9r2fYWEw3+fHoDj4Tcy9vxo6In07s+/SBj4O5bmr7l7hTP5XV9YG6qiWFezrR4ulffG5+kX4MqFhN/MNR8rHwkr0abwn4N2WdaXzZe8ChWBtHdKCSM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=DbOPxPpc; arc=fail smtp.client-ip=40.92.43.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bzl2VTRGs6q8g+bsiBOXXnLkQ9n2PCUJyMl4+8BYB+CilAoMB2zefA9/RdOjcm18vp98NpHYYkHG/TteKnnUHc0R6a7WfYW9hNhtOWu0/DRHDDow0T6Z7wWETo9NInNJdoXQlqyCAbT6bp28XFPOnghBQBHiqkwE3BezdBrkFwpkK+sdDt9UvK6kI96x1vzHkjcZ8Sgojcu1EM0qIJJL7YwoBi+qjPCpBNtt6zyreAoJgUTcMKmmowZFlzFSCAIAcW9a3gncjFPE3D47/81/Cdf/WzeQaqlNzfmTrqQ3IwyqFFnNQLQ9WW89qpkFa2OI3UF5yvEcKPAqvuaNSbZj1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yoNEDh+iFq7lzKBU9CENiMetKrSdJTglln2bu+84U0E=;
 b=TxY7kOvAJtI545r1vxPRJxTPmD3izcCSambQ4uxSgfXwAdCnom7Gw3dm1vdEY+AhNouSmj7ctsTbGF5u/erMJvjnyDFVVYjpmDQf0XHFm83clOXKQS3o2mZanpyxcMsOf81O6TB3bWQZ9opFbBX2bgG/BYqvkdOXFzmGpZQaeHtq6EhyUlwYsFk3xl/Lmf7qJqxjsz0bAfbcn+Po9cO7nBiVqb44wIPyD02jWuzWLBobBfXinDwNUkaGbiXxu8KSbjusOniDy/bTKOS7luOqy/sVQasSVO7WxqwiZqE5XsAqM/IoA1FXEEOexqE6ZRj7LA/laZbsO7XW5k8Jmg+OGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yoNEDh+iFq7lzKBU9CENiMetKrSdJTglln2bu+84U0E=;
 b=DbOPxPpctdHhuNTmj0q67os6cQsdQfmkQN+WXpE20twix78t6rJuZfhSwppUtjTiV7qn5wooXICAel9VGG23Q/A7a/Qx6+c4YbqQc1E2z8yzQPmcclncUF4j7PUrdBovmjLg6l9R+AYoBV8mcKE4TtWiO4XK5rxYwL2slF7jhl4JlwOjGHCzAnMDbDaS7VIB53AdoPmd/+Ez/sbWnlzMmube9LcdNhebE7g2e89WRE+DyaCMlGGyUs/zDcXtFnFLW+pBsWOrnyKHqbcEkvSgiZn6M3cwjTs1e5zZQE9TYxZaeLNZyyrtW8LHb4B0v8HE1NYWRsy0sBx86M5KiMGMvw==
Received: from LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:1ac::6)
 by SJ0P220MB0785.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:408::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26; Mon, 18 Mar
 2024 17:32:43 +0000
Received: from LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM
 ([fe80::57aa:102b:db4b:e05]) by LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM
 ([fe80::57aa:102b:db4b:e05%7]) with mapi id 15.20.7386.025; Mon, 18 Mar 2024
 17:32:43 +0000
From: Min Li <lnimi@hotmail.com>
To: richardcochran@gmail.com,
	lee@kernel.org
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Min Li <min.li.xe@renesas.com>
Subject: [PATCH net-next v7 4/5] ptp: clockmatrix: Fix caps.max_adj to reflect DPLL_MAX_FREQ_OFFSET[MAX_FFO]
Date: Mon, 18 Mar 2024 13:32:12 -0400
Message-ID:
 <LV3P220MB1202968CE7483B0FF89B7E5CA02D2@LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240318173213.28475-1-lnimi@hotmail.com>
References: <20240318173213.28475-1-lnimi@hotmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [uLvgenvusVOTLSi0D0GoMOLBmUIy8oAp]
X-ClientProxiedBy: YQBPR0101CA0070.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:1::47) To LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:408:1ac::6)
X-Microsoft-Original-Message-ID: <20240318173213.28475-5-lnimi@hotmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3P220MB1202:EE_|SJ0P220MB0785:EE_
X-MS-Office365-Filtering-Correlation-Id: d8814eef-8ace-4ae0-04e0-08dc47716b3c
X-MS-Exchange-SLBlob-MailProps:
	YfhX3sd/0TVtq4avcNPNE0XRC8HkTjez/GivjffYX438AWKz/rwEsHhmede62eQsvVVO1HUhUZUxAnWd9ahB61vFxuZOiFvtfegL9lHjCDcTDjn8hb6MPporhxyWQn4agQNQsn8oXFbZl+OEYYhnLMvFTIudG0dZacqal7Dn/bnPut0uD/d/D5vLF9o20viY8VXsOEnJz7ErWoNj/coeRJOwSBokEDFm6cv28Wgs5MfPYZqIRlFJScP9VroGYe8FUn3D3Mgl7eoMD+ODaQANMd/LNxKKWjiTzHKOcimBz8imc4qdwNuTFAxX+w9pJLAx7dnVY0hkLcmavAk5zFbLRz6fEoNRSps/nP6E7hURDLCxRcaDx2ewKsCYAFWS+EjgX4rLk4pTFMF3NY60xlpy/1HhECt/eIjPB/1G8oY23bt9dvP8Dc3rbLmOZT1eBt2vHZ/W3XPWs4K+M+zeLu71f039+TSgYZe8QrrNggcy1X8SYyjQU5Aw06wgYdkpJPbHu58UHk+nY92lWd0FAyeUxrkP/3mJ9J4XX80xac3474LYdxrrbLoWPGyDyZqpOKgwoCQF7JUFj6F0CXqEgY4PhMM/gcI1vcZvQk3ouWbvVHxY2Nk4UkzPZJbwPm6WDn8zifm2zQJN1m0sseoOWp5WeX76hPZnxI5DiH2fI+jLUpPN06Z/beUHxwyoYvhQcnSc6azw/tqEeEA/aaMdy3ZQZ4PWZM+HEPdSjttCKscqG90m82bSbox9/cjKMFyzywsYmauPzDwaSqEURByISHOHRvUqH/mCCieMOyTLyu172Gk=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	dqQijQ1axX1Ojcj+/ERev/6nUBu1QXiEMV9Cat4OhoMmdS7zxZtrktcNJzp4abnSKuwTzt9jFcceEXZ8hBkAiiGPKVB5LPfrzPPh732qa5RG6zL0n/kC/t/HAegY9TfApNlu3fSDwD82TJ7oBkiUQbqB5s/QIZCpSELaOyu4kM+oyuhooLx+o+b02KKJupkCjR8rqsX269Yp+xu8AFMT3Hnx+yhJyJtx7Zt/dX8bIAbxExc6GGrEnaeAx+3n/S5GlwEaLJCIkYH0zxelUWuB5+Qdrh9MBofIH2/fxV0bcUW5918PjviDhjyoXak/Ff5bg8zX4UGYi1BRL6QTDN4ciSXwqxGr3tZfFZjy1KKKi1QZhOHCLn5IwAHYMWXgZxbfy2LAw1rZbIs3BF+i06j6cq64f8Ywqmx/pReCBCWoKBIGjakFRT+wuLdiX3KjOE2XuS0C/MmM/IXccIb5YwWOmTqiSR5FACxr5yuZ+hKtVuGfHirHO7vWY6lIXssQnmxTxDD4CQdTqF7jrzRvR4KP5qpekm0PU6N6E4P1Vx45VeQRWSpYxabmTRUWolVQOLVN
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PWrhwB+54DJH6UWwXaRpzo3iQlVaepvjjkilYZeohuiAAi9Cgb6PZttfJfsl?=
 =?us-ascii?Q?MKRtWyI6EiccOu3vinSkMsh8FZ9N9VztYFQinuLfeksH6FwdCXVC/revs3NP?=
 =?us-ascii?Q?wRqcrIICoVQFLz6FyExJPIqcEeMlIBBl9v6uBEFbcS9FEbtLmibL1IqiDZb7?=
 =?us-ascii?Q?PakNmTC+F4qndq4Y8GAwDmvJW29XolDf/8XYoeOrBOTYAfz+U4mP2jHxlv82?=
 =?us-ascii?Q?qh9asYUFVVwRDOhk2lob9XNVfC+N5QXNdqRvV5yUUlmy9yAOqevMh6BiVoGP?=
 =?us-ascii?Q?UTLWrRfa3cZ1IXCMclT2maHjKnTMgH4wvCZ+8oPSqINPaxaKttFDEFltPkTS?=
 =?us-ascii?Q?G2boRdwmtUbp6h2L23nz1mAeqaH1dnIeBwOLkFHymxqkDPsuAlk00kQMCJ9a?=
 =?us-ascii?Q?dOGsR9p6o3tTk1IUe3mQ52vqKF9Ns3xjwKvY7mzSfXXau1APQjWEbNc0GHJG?=
 =?us-ascii?Q?ks1JNGQJQoGLIUxRYbureT4a1LTP2lKTH21LTvL9AWZqvsMDnTqiTHI951kS?=
 =?us-ascii?Q?kqORJ4Nc+J8AGogGZhu699xMMTX6AyP55Mg3pUIxjGNcWK/u8jCEQFYhaHom?=
 =?us-ascii?Q?EnTaQyc5+++8j7ujjFiUlUMnGDoaeDemsGz+OILxhOEdMibEVswljKZBixPx?=
 =?us-ascii?Q?W2iCThlG2NubkpwAsr1wqDjNrEgDTMkbtoo2ckNFFxkqz9jRKaF1ivo0kbM3?=
 =?us-ascii?Q?rXA0yiO0+RKi46QEKpU0U1Caix+IEWYhWXw2IWj+psPGBHdvLR27yUiQsF/z?=
 =?us-ascii?Q?xo8pIzJCQL2NG5mAEN7T5KcTmf/6sdEeUxj/+N5kv+gSxTSNMeu3FV/ehzw8?=
 =?us-ascii?Q?yIoNLLUJ9IseslEwJucwqa+rLYxbxBJQKrMw/c/GFExtLtsvLW9mum+x63fz?=
 =?us-ascii?Q?J6pHrMjpfC8ovQi54wiGjY2UDNeksROA4mcF82sacVpxViNJE3cpW5CK5Jyq?=
 =?us-ascii?Q?jgBwBiuGXmMfhrYGN1f2EU5zx7/CJC80qx0kGTXEPG9Ybru+V7NFulbA/Hla?=
 =?us-ascii?Q?MfSNR9ysdI/lLIB80ADWm6ESMXCgQh6odf/hSFYdC1oqQn+obQv9j6sCuVNk?=
 =?us-ascii?Q?X/aBS4joW84lmP6DBzM8LuiCJeIaKlYVtscbKEsr2cflkrR6n50qNGgtszO/?=
 =?us-ascii?Q?UeycENaWzD+XhS6ww9R8Rx6lex8cmvyftSRsdhmRUpgNkBAqlN+c4zuwDPtj?=
 =?us-ascii?Q?YwTbNgNIQPWmDfP81IsfdMQyG6sC2p4mxx35qTmhSd7eCu1Bq7hepAlVtJ0?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-3458f.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: d8814eef-8ace-4ae0-04e0-08dc47716b3c
X-MS-Exchange-CrossTenant-AuthSource: LV3P220MB1202.NAMP220.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2024 17:32:43.8190
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0P220MB0785

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


