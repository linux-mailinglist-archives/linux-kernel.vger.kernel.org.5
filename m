Return-Path: <linux-kernel+bounces-91754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBC12871619
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 07:56:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F240DB22C51
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 06:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 868457B3CA;
	Tue,  5 Mar 2024 06:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="dfKvpJTW"
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2054.outbound.protection.outlook.com [40.107.13.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79AE345C14;
	Tue,  5 Mar 2024 06:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.13.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709621796; cv=fail; b=cqcmq7c7c47F7TGWKPA+OZavhmq2dmqFWNnC9hcMUhtdVZuzwW8Lu2hA8e0f8ILmcOVt8aQKT9cRUm0MTts6tfkBrXUSiTvyVpvRqUmP75/vq+nyBD4uCY4sa2Q+HlaPb6iIORflrSb5WXzo7kJfCeT5vwI5tU+U9ME00v0iW6Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709621796; c=relaxed/simple;
	bh=bIkbYKJwL2+l6GVkvyYIj6n4xVHoQctTnTZoYV0QX7U=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=kLk2lFSUUZPPJCsQEyE1qbt75ZrZ+LoLMtTIE8eiIE6XKIxt4Rh5KVrMRxrM+MbHYNa2PCB8s+ifSspg38dIy4sM9pUa9zHMjBXX4hxoHLxStps34vuFrLr2/6FsiNR+fDLbahyG4aOvvkOeg6brm+pgGDTDUwBT+eFH1kPqbtA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=dfKvpJTW; arc=fail smtp.client-ip=40.107.13.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b1h673m0NLzqbCNEYo1GLW0d13lPEHRC1VRx+TLx1YfS7n5s7e/w+Ppg3MY7aS5+vl4CQ2+hKHgFtB7P6TfYaeGcx/sA+AZVX7XOKj7Xn/drZZVSv+WuNW378gzZPBv0i9zZca+OmUB94nSl/ebryVeyiJFrp9ADhH2ZxHQV3y5Gf6c4mmsmpIphKYW1Bj8l4bxCedhlI6cUlU5Y1NyyVseqGSNymkvgm2e4ZXt/cNNRV//6g/PyNUtyIW/yAeeqOQwls+A8utW5euH8DBa3qcfmL8I7aeB9fsfwh3BbXWOXuWDphs/gOeJP4OxeadD7bz8b/vjVKPRBNDhxxHOUEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G56Q5jgQHaatZRvRWxX9A/N2oSt6fO3+MrhuoX9NqY4=;
 b=n/D/bh3hkWu2sWoMKP9ZRKgm81yvIFC0JyU2qWgPJUkntjWzSNnT83ssqCECuHgW2GvQTl24jAfjfTBO2FAYnXzXvzqp9Z0N3wLGI4oClpnuAzfIsz/iP4VZGijt0czYjwKsVIrU/dRQ7ZFE0NQw3PsO3Ij5vTW/kGBH4AnClEptGj0UfFoWDbx9+7I43ADofYANKtTXe7n6orNAuJgBe5PTeY0wvM58VhT7WuaKYL7N8KmhizZWo41bhQ0jzgIaBLY1uJ3C3bX0U4pLASm6PwESdMyefT/MtGuBOBlj2+WRxyMJtcpKVs2z+Z4ygC6Zrpn8v+Qtw9av1N3UL+3mfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G56Q5jgQHaatZRvRWxX9A/N2oSt6fO3+MrhuoX9NqY4=;
 b=dfKvpJTWn6oyLgPJrf8K7a9qAizWpvp89+vjf9zTcOKKEb/Y2s2zjLYwu4L2uD7WUArMY+LD8X/i7whL+Z49jtDCEKQ7MFJ+bCEsFWK6Ji7Us8+nyBiW3l8Rh7DpUXSEymEzIOGnVsqV5vfgIy8vsZzfAE3yQEf7fxH+C8zTInM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9498.eurprd04.prod.outlook.com (2603:10a6:10:360::21)
 by GV1PR04MB9119.eurprd04.prod.outlook.com (2603:10a6:150:26::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.38; Tue, 5 Mar
 2024 06:56:30 +0000
Received: from DB9PR04MB9498.eurprd04.prod.outlook.com
 ([fe80::4bee:acb0:401a:3a01]) by DB9PR04MB9498.eurprd04.prod.outlook.com
 ([fe80::4bee:acb0:401a:3a01%7]) with mapi id 15.20.7339.035; Tue, 5 Mar 2024
 06:56:30 +0000
From: Chancel Liu <chancel.liu@nxp.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Chancel Liu <chancel.liu@nxp.com>,
	Zhipeng Wang <zhipeng.wang_1@nxp.com>
Subject: [PATCH] ASoC: soc-core.c: Skip dummy codec when adding platforms
Date: Tue,  5 Mar 2024 15:56:06 +0900
Message-ID: <20240305065606.3778642-1-chancel.liu@nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0019.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::15) To DB9PR04MB9498.eurprd04.prod.outlook.com
 (2603:10a6:10:360::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9498:EE_|GV1PR04MB9119:EE_
X-MS-Office365-Filtering-Correlation-Id: b20572fd-e2ab-4d30-4062-08dc3ce16273
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	dOfN/qmVli/usMCIESSs8tpnhuZpvPbn63dyP3AFfMPVSToyh2cgO4tsAVrCy8swCtZ+RfETgLIj561/da21KRWTgkPHB/Rlc1JE6dmpHdmKGI11K6loqxReb4xSHj/Q5a8Ah7vlpBOJj/PFbENxaznY6P6ZnHand3tQEg37ktkfUNV1ODCzoynIp175GLCissOJU/E/wsDIS/oln1VwzeAav/mqEuscje22bH/z2casHiuqsOY9+TA9MOCyzaC5Gm71Sbx5RpJjvAKkQANg7Bd8trKieJakUnUyVg/dq4s6KjEiXjozkCgV5nHLAn4PmBCWJ5J6ZF2ReIu5UfzBXL5OTfSMAd5GKZ+cgJ8q4cRNyDJeJkUiTB/42KeMC75zOtJVHgN0FnH8XwrfLlzh4Q5qn93MbjIt85JBd0g/4aSAzwkt/eG714j4R2A4HXlApdGQs5RN6me706MmuG5WbjxTqvgNNtnZAnOhAVQY2QIkoqrKGPVoU+9GstHNWJzXqGH0zfGe35j1WwZT0qup00W4xoEFgzHiKZ+do7LDe8yJpcJ8yUSzOJTCHb9jX6m6kaPkkhPwGTfSzfYttrH0HGTKyiPW2rz2AIR6gi3v9gOuognvz7wQOfmlO/lxelipuSf3ccDR5VEQnHIPhUE3GbUKBauisWBhLzKeO8R+IWAMzqPyF4Im1AUyua+9rHXsyXXmHtbqEj0Pg01q0JztoA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9498.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?O0a9nt7AwtfT1XsSBFYKf8VjAa6BWn/Hfh7NOTrmOeEIhnZOzyH4lY+Ac++q?=
 =?us-ascii?Q?xhzf1opkrKAOCR3ZChWde7rT5fE9kQx8t5ZAUkd2tXP0249hpi3vLi45ncko?=
 =?us-ascii?Q?UroqiW/m9PJZOPZrQGFyJ31ET5DM9MTrpaqioYPo0NZBSBRALlO4owbhSxPe?=
 =?us-ascii?Q?lh2fB9seg5/mwmEUKHv+4bcwMXXbrN1mBQLDk9n4rsEhBi9sf4KPpXLKukeA?=
 =?us-ascii?Q?OX3h6QrMd5Q1a+9qFu7Cwref2wQwvZTJ7nq+RjhSwIGZGuZHLVUGZAOgWj41?=
 =?us-ascii?Q?h0D8CGPNFpLdusIveWA84geNwxv1EAkl4IgVvOLoD1Hn1C/kDeTuHB/Cv8RY?=
 =?us-ascii?Q?+dfsPSGH81BQHzd/DrJh7B6VWv3tVswIi47VlAFwUveUFJgTeDIQAT0lfeHO?=
 =?us-ascii?Q?sZDcAlllK4oziiIzZVIZeIHP7RIN0T9o5ZQJuUJg9S+l2wixLNQrLhDm0S3p?=
 =?us-ascii?Q?50AnKK+KixkMZZjcDRRqbXrtIoWsbomHjc0dPsanRUlxr1EYq/3wCkbQcM2k?=
 =?us-ascii?Q?MxIGsQ2pTwEwlWBddptJ0dDny5Q0hGb34Rl/k3jZSowIwb0I9SUfeZHmQo25?=
 =?us-ascii?Q?89ZLxSBx4+lxR+z3D5ePuS3d5EgZ802H5cKm6HMdkYHfYxXZacgg3B/53hX7?=
 =?us-ascii?Q?Ut+w+SpeqwFTbPcuP1fkz0k52x4yghOdgczWYPrz7Vh1JYAaSr3lSJMxnbSz?=
 =?us-ascii?Q?qP3sLcM6J5vCReOghDnXr+vgRVP86KagfT4NKJOg2ezxdqJizKDxP4gDKx+Y?=
 =?us-ascii?Q?FuiV92ISOtZ0WkYv+F9qmAWg6s8cUeosx9N8xOaj5X3dJQw+9sLF7Hf3MzCp?=
 =?us-ascii?Q?kc6FuYSnftJVgdNfiSD2j+KpqCYWHv7fT2wc7tN9fMixhuSSC12S2kHd850O?=
 =?us-ascii?Q?NRTCoNzKSG0zXQUSdWnOQ8m61RggPzGt1634dnR+DuhOoj2HzvG5x5AIsrdn?=
 =?us-ascii?Q?8cYBO3gVB+NY5K+2u+BGSBtHOSahMLplNGo0w3o0uOqntTmlMaSJWAgwuP9J?=
 =?us-ascii?Q?15WiwHDUbY8N33pCi1RnIxqe/xJRyFHG4L1fe6QNcIq3D3fWS2gTjMy2H8S5?=
 =?us-ascii?Q?D7OhpWth1MLvqGobSb0084E3oklZprzcjFtYDE4DBG6Er+ksfituG1NEf+m/?=
 =?us-ascii?Q?aWIcnXBdnHJxsI9qFSAreFtam0lJYyfHW9vKCAnCFKLVNMjpWwArOQBuKo54?=
 =?us-ascii?Q?+d2JnmL5Ubh4m/wBmsI06HtTZuAkeDoggKlHZGRZ5Zm0XXath+cc16sOjt3D?=
 =?us-ascii?Q?3XS2w/vd1ar7UQLF4ZzWBR5286gX9MAmZpMhVTug5Jd2/1RMoQbYTi9OUBAl?=
 =?us-ascii?Q?RfccUotToc9717lgybpem8NBTj7HgVbtNKl09oGQalNdC4TY27T/C0K1TWRp?=
 =?us-ascii?Q?Qx5VeYa7h5IVUc1MXYu0TscBOYfZpeyshd91L39X+auNclBcaePQPbteKhsR?=
 =?us-ascii?Q?gAh34UkIPDuo7QIEZ92zrNYOkJXfPm0hxfHoyjGvEqu1hgabW7BZ3H0+2Szd?=
 =?us-ascii?Q?AWeE2K3kWKtrU72mhJMco2u9NBWYrIPr2Kl0Ea1OrznjArlRNfPJS+jjYvoJ?=
 =?us-ascii?Q?1PsdeABWgyVgbTEddS6LLF9oTqjwNCcSkQ2/YsG+?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b20572fd-e2ab-4d30-4062-08dc3ce16273
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9498.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2024 06:56:29.9648
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U3tZ5w6EqycKtOJiycnEh6HAzV7mqTdNoP+7VV2ytM8RtbMJWJvZwpWlqDNXsIIZqISN7RO6hRV5c9Gx5BO8zg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9119

When pcm_runtime is adding platform components it will scan all
registered components. In case of DPCM FE/BE some DAI links will
configure dummy platform. However both dummy codec and dummy platform
are using "snd-soc-dummy" as component->name. Dummy codec should be
skipped when adding platforms otherwise there'll be overflow and UBSAN
complains.

Reported-by: Zhipeng Wang <zhipeng.wang_1@nxp.com>
Signed-off-by: Chancel Liu <chancel.liu@nxp.com>
---
 sound/soc/soc-core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 1e94edba12eb..2ec13d1634b6 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1219,6 +1219,9 @@ static int snd_soc_add_pcm_runtime(struct snd_soc_card *card,
 			if (!snd_soc_is_matching_component(platform, component))
 				continue;
 
+			if (snd_soc_component_is_dummy(component) && component->num_dai)
+				continue;
+
 			snd_soc_rtd_add_component(rtd, component);
 		}
 	}
-- 
2.43.0


