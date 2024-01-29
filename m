Return-Path: <linux-kernel+bounces-42278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD93E83FEF5
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 08:19:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A08901C20B23
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 07:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AECB4E1CE;
	Mon, 29 Jan 2024 07:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="H5CReA+i"
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2079.outbound.protection.outlook.com [40.107.8.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9830E4D5AC;
	Mon, 29 Jan 2024 07:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706512746; cv=fail; b=tbi71z1oeaORnjA7g3YgHhhFzDDA2Z3Gt10K6L1V1bEk2oiOGi7qVvIJPizQAqcYIJabf54IBNjSLOrYkXbh7Fa9oA5fI6+9vMFlk0+VS377QrDMYo925cE1pCyawpP94RLYMUQ/jdwHqJIuNW+bwhe2W+Hhw41ecOQxZYKeUtc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706512746; c=relaxed/simple;
	bh=ZP5Bcp41koVUz8nJAzOTWppzry3nQQQO23qniclPdIE=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=T1KAEyFAmbOlmt962Nu12eqqv8zoV6TibwkI2TDsVtgN+z7DRTK4lHB5S7P7PyXuHKisMV3T8Xbg3nX4b2kCuCbLjqiHhdOSLkkP6yZ2jaEAAomO6FHUFHpsaIatxFEsD8FHzn5j4byLWNb+l7348AONauREyi/TXQbYl8LgNx0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=H5CReA+i; arc=fail smtp.client-ip=40.107.8.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=edZGeqxgPXGu9ZFsROFyh2JCxaSKRJnKwqIz89wWIDiep8KttrNQq7dz+QaHYLzpPguL/0Nr1OiOgKWtVmh5BuflzTg0dEfRAg1yfEtMyQGbiFFfq9lXhmAOo1dGGF0YeoUj9dqV+88i7CwL0f3Ad7G7XlpWuJISznBVd5I/rt3gO8gO2zPXTqLgRrK2jqvPej6HegVCfPrvsia4ta8pC/bEGXuwSim6NmeG5G6fS5va/Wa/M9f8YYOc+iamNkkwdcrkGyttzigZNSWQ7ez1IQnoU5xMZ24M35wZIjfwT8N1YPIP2yUcSn8weh952wOLXoM/5eQ+E+ClLLYVuo3Rbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0uw+FaeGGnFvifwvejNBTN7XqSd+0cJJBDFAnEno47Y=;
 b=ByIfcE1VYyVNcUIycaV0b3rxD08jS1T9UcE9N3FFm315VgbIuoZr/dmhzC0rU+IvTLdKjfgVN0cbeSeqaMbOHicP47C9SRXduPSBt/dxEKwWKmYZmXWyErPkb63vh6aSvrVyrSRbjCnQ1LSJIfPA5vZpuJCQa3A6EtxEaL0IG/NfxBsfKu4HplKBqm6kN+qcp1UBZD3pD3R3pe/k91Vgq6Ys17vUHZG6hm2hSIeQgewZavLbKKS1gzmgmN4bI8yzfJuVnXJulcn80WHrmOVcVT4AuoyUMQKCnI/JPJhF36wzs3IKCASjgN2cfyNwk0nhi7Z16VuSUzK5Vf1ju3GrfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0uw+FaeGGnFvifwvejNBTN7XqSd+0cJJBDFAnEno47Y=;
 b=H5CReA+iyzW6m8/vB2utoIYvOyAqtcKYY7STkwRUwfIVdN+LWgLPH/DGXfs+UVmt/xp1j073rkV3nZzibX4XfNnMIcqydsV1ru07Goi5DXmPUbo001JXyrThac3HyZoNOD47YfzsPfPsSntS3adeHPka7dkA6dr5ZoiLJSm7Fqs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9498.eurprd04.prod.outlook.com (2603:10a6:10:360::21)
 by DU2PR04MB8838.eurprd04.prod.outlook.com (2603:10a6:10:2e1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Mon, 29 Jan
 2024 07:19:01 +0000
Received: from DB9PR04MB9498.eurprd04.prod.outlook.com
 ([fe80::2a3c:9a90:b09f:293c]) by DB9PR04MB9498.eurprd04.prod.outlook.com
 ([fe80::2a3c:9a90:b09f:293c%3]) with mapi id 15.20.7228.029; Mon, 29 Jan 2024
 07:19:01 +0000
From: Chancel Liu <chancel.liu@nxp.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	kuninori.morimoto.gx@renesas.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Chancel Liu <chancel.liu@nxp.com>
Subject: [PATCH] ASoC: soc-core.c: Prefer to return dai->driver->name in snd_soc_dai_name_get()
Date: Mon, 29 Jan 2024 16:18:39 +0900
Message-ID: <20240129071839.2393483-1-chancel.liu@nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0051.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::6) To DB9PR04MB9498.eurprd04.prod.outlook.com
 (2603:10a6:10:360::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9498:EE_|DU2PR04MB8838:EE_
X-MS-Office365-Filtering-Correlation-Id: dabf4d02-2244-415b-c26b-08dc209a911c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	3k8ChNFeogLe9qcu7OLdBLz2F07/RvNhwjFRxSt1jJ5Uv6o0rjxeaYPkvIHe0P+CQvP5YtgVcBjMKvhOdiDGYrdbEx1gA64dYCCi/xZC7t9BUosquxJp8ar6KOEQuNQELBdsEBArLp8RhVgWRXCdTi2b8UYXIPGCtV1YlBqciBLdrcZrVDgZPfT7DbW0na1BPycdHkxAXyWlU8/Uqb7PnCtiq3Nxr1ThU2bhkv6XIa0Fcbp7AK/grpFzWnggkGOzvGweN68MAHG/ahdJJiJ+BfWNH+klthFcNW/in/2k94C8Tft1dNu25j327qI5HfSX6+gq1y/QEA2L3Eo7gb9Sn0h6/dlp9UGWIUmmVCKCZrCFRf/FClnM9M/pQes+Z0RENzJzBk6zuSormX2Ar7YHSq/R83SkqD8qBXafPtOKQik89stBhh3TvFVsBo9WmMI5ny8HJWJuVd3BF/aWySpXbTP5u3QZ4rEou8MrkVeJ+2CNH3aBvbhHIYEk2pUx/kNjX+VN4uRNvFXqc8TUYO30ajm0eeeV3MSjOxZnt2ZPOJF4thOZgwd6NbQZkt30iKRX2sFuMWTRvNznqkuubFlKBwMDw1CEenKsiMx8G2MwLT6cqXDQpALabzf2c5Xstrqt
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9498.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(376002)(366004)(346002)(136003)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(26005)(2616005)(1076003)(41300700001)(38350700005)(316002)(36756003)(6512007)(478600001)(52116002)(6506007)(6666004)(6486002)(83380400001)(38100700002)(66476007)(66556008)(5660300002)(2906002)(66946007)(86362001)(44832011)(4326008)(8676002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nEbzJ1mQki5B1xPSH1HZmeNLHy4Eo+4oJHF4yCAQ9iMUuB98CP38iDs+v8Ll?=
 =?us-ascii?Q?BCOc47nuPKDjAFvGVqBM4IdFHhD6R2DCMqqooI6UzIUAf54aBvgbI+rGVGbS?=
 =?us-ascii?Q?GxJ4n7WhwESCjuqA/59kBZLKLnShznn04F4ZuKk6jqmzGdOHbLNCT4PTEexQ?=
 =?us-ascii?Q?IUeL7xbw+fjMsemuktW5pkO+S6CL8Mpd33jRIWuzc/q0bx9Serg7i7f3xrBS?=
 =?us-ascii?Q?ikF/KnGSXkjOHJ1Ifu0UTa9az3PZm4lv9k/bv/P7b7Li5cM5ONne4Z5e1sQU?=
 =?us-ascii?Q?sZcYheNQKDBcNaCxhndx4pT4idCh7cP8vw5wRuB/dCQJWqh1Ioqcty942c+2?=
 =?us-ascii?Q?x57acI3L9P6i/cCR9BAunBFD+eRCAIlaKfiUWivt2y0OKfPeX2qPwNMjmAv5?=
 =?us-ascii?Q?Z1oloONg9uld6cx1M7zJPVpZLdA3YehvJVF4elO8uz4n+cjPQnGmwkdwsWd2?=
 =?us-ascii?Q?NfyWWrYwwlHh8CEcgLCG0y1jh5A+fTTgCZmaZLoj7rhh+mc1mrS0N18lMGBF?=
 =?us-ascii?Q?161FK+n7hmwuW1yzZm/EEx/6LuncLB9Nir9oplwLdfkaUMioKinBq+jM+oET?=
 =?us-ascii?Q?vZepw89hK12e25zdRHDGAFRhrBuWc8zc1Fj6krIMUtdoRtZjj8kE/RURlcqr?=
 =?us-ascii?Q?/EFeoWXNV09u4oCXObmzM6leDGk9AimF6FLANKBdBVUvwLF3J7G1L5OJi5Ux?=
 =?us-ascii?Q?4rMadiQRmDsNR6qgb7sIBn0f20aDlE9LhH9B6vego89Kg6K/4ObOwl+g8Q5l?=
 =?us-ascii?Q?RHEzkr4uc14BJWJZ6QE/ag/DLFE+6yQpOzhzAidOdg64ZseWTDrSqai4x4tb?=
 =?us-ascii?Q?5/FjP5dl5g3C51ye8nLNbah49swEM6Q3FNRlBX17mvZxevmIbQqVQ8wangZ4?=
 =?us-ascii?Q?Scw5JhgKpuAkOKMYqKrpQDYJW6IqIvtLp5ePpkhkHW8cNKe9crLNV51epwRE?=
 =?us-ascii?Q?oCJuXcW+A0iwCLsIZ7F+0UH7OUo1MtZVRwBPjMyCHZLyEfWGxVDATOt05ozG?=
 =?us-ascii?Q?jEtSo/VGJ/gqgnO8iPqddsg7N4z4ho50E3/5CMXj1HbdCqc5pkLMiaZfIMxW?=
 =?us-ascii?Q?hCszFdHg/HhYiLkl7McljstEN8wTRx3ZDmEnJcBRQr2g3y13AAnVDZXljXhz?=
 =?us-ascii?Q?J0BXddxfXYM71fcUFnsgvsj6Op2g+2hedzF//vUPzkoAVRPkyOC/X2jxxCT0?=
 =?us-ascii?Q?dIFB7Awxvk4hePOF06O/b76SsNkcMx9rveqsY72b69RWb8bnbuwSrYWduU7p?=
 =?us-ascii?Q?2lhYmN5VMqe5oIN+e7QFfs2Wd+rFF/i3SDYt2/g2TtsYPtc8gV6e+0kSTCMW?=
 =?us-ascii?Q?2Q8ihfkMEFihfJ7fVQswZ61f52NJyN9wTfVFXaO8sz0f9Z7FTih+DaQv6v1E?=
 =?us-ascii?Q?D3xdPgDlmQX4kz1bulCq2z1Jr+5vaZ3HVgWSwvkkXhenb9EjuBDBNJdIKAb6?=
 =?us-ascii?Q?XA/loVtuVHwiNMxpn4bgCEe7GcyDdUJ9Xuc0uOVXR8lwCDw6T8+5IYMOHvB/?=
 =?us-ascii?Q?oPUOlZS9UfTuiKEYsM7IQFiXH18DN0CofUauoh4gaJlJ8FzrbHzanzXwUpDL?=
 =?us-ascii?Q?TONeqTwdIvxWx6GyMv4EwZkrOKKTeAhIcleekJYP?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dabf4d02-2244-415b-c26b-08dc209a911c
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9498.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2024 07:19:01.3107
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j1iTdkn38hjkoKGP3Y7BxGITbYYU5QE+BDnWXaCoIQn1crnqjmAMJzlIaDotrQL5Ru1OwFJFRMUizuhVc1UpRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8838

ASoC machine driver can use snd_soc_{of_}get_dlc() (A) to get DAI name
for dlc (snd_soc_dai_link_component). In this function call
dlc->dai_name is parsed via snd_soc_dai_name_get() (B).

(A)	int snd_soc_get_dlc(...)
	{
		...
(B)		dlc->dai_name = snd_soc_dai_name_get(dai);
		...
	}

(B) has a priority to return dai->name as dlc->dai_name. In most cases
card can probe successfully. However it has an issue that ASoC tries to
rebind card. Here is a simplified flow for example:

 |	a) Card probes successfully at first
 |	b) One of the component bound to this card is removed for some
 |	   reason the component->dev is released
 |	c) That component is re-registered
 v	d) ASoC calls snd_soc_try_rebind_card()

a) points dlc->dai_name to dai->name. b) releases all resource of the
old DAI. c) creates new DAI structure. In result d) can not use
dlc->dai_name to add new created DAI.

So it's reasonable that prefer to return dai->driver->name in
snd_soc_dai_name_get() because dai->driver is a pre-defined global
variable.

Signed-off-by: Chancel Liu <chancel.liu@nxp.com>
---
 sound/soc/soc-core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 516350533e73..09467c693627 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -300,12 +300,12 @@ static int snd_soc_is_matching_dai(const struct snd_soc_dai_link_component *dlc,
 const char *snd_soc_dai_name_get(struct snd_soc_dai *dai)
 {
 	/* see snd_soc_is_matching_dai() */
-	if (dai->name)
-		return dai->name;
-
 	if (dai->driver->name)
 		return dai->driver->name;
 
+	if (dai->name)
+		return dai->name;
+
 	if (dai->component->name)
 		return dai->component->name;
 
-- 
2.43.0


