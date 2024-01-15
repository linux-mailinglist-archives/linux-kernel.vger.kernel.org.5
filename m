Return-Path: <linux-kernel+bounces-26433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 490A782E08F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 20:21:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34F1C1C22178
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 19:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A907018C19;
	Mon, 15 Jan 2024 19:20:51 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05olkn2054.outbound.protection.outlook.com [40.92.89.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9822118AF0;
	Mon, 15 Jan 2024 19:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aA9R9IyJcCA8L/e9I7Yq8HzHbTJqqVya+ZFVDT+XK9Q49+60GuI1MBxzf5cIZdAmjXF+MPSmwlZar7DRCCPP2rKab07FGwC9zG4Y8DhekGavVKBv6wVXm7h0LAY/BfFpb9+GiP6nznZP0jllvi1QusoU5ZgXDmlbIG8OdRNw/euRt3pyhV6NLelNqBD9J4FtUuhRB6HD5Dqm7RzYe1nkoIfkIFl1iTahdn7buPph1o8YXB07K8zJ+mK6MSI1mfPUYMkdMQ8lVG+1EJc7Sa7041+xl1Gan3QWiv94u/4nUqWt0O8fd5lYUfurvFI5kkXHIbJ6PNUMCPYQ5hD/0VUPTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6jPTxL5OpRVaxkWWCXA1XtnX6eQpMGzPtpdmv9RgZlE=;
 b=FkwJJvY3hLmylshszJzoF7PO3aMg8wQjOG+G8eFhHBiBFsxhhOHyH/hFySpGz7P2uSLMGIOVJq3pP4EAJC9QSF/Yrp1AQeePLgQ+j0aQV86Ztvj6E2bp/wRNiejsjPfeW/O/Jjr9z7VN+ChALa7lsHR3ekkjslJywNAVFEA+3Dz75WM2yF23O7ERCyoy880CiCh7eXie+9UucRgPB+t1xxTeyeG8V39UWeAQWVyIVh+bvyY9+wKf0in+IuAo5M4JdziXt7Q0jcCqUvShFCMQPZhDfH5h4dZd0j6Y6gGkUd/SCC/tQN2ZWMxDQcK/4kcdl9/+HFzV3oO65X+dW3CWSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from AS8P193MB1285.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:333::21)
 by AM0P193MB0769.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:16d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.23; Mon, 15 Jan
 2024 19:20:47 +0000
Received: from AS8P193MB1285.EURP193.PROD.OUTLOOK.COM
 ([fe80::897e:cfd5:b29b:c611]) by AS8P193MB1285.EURP193.PROD.OUTLOOK.COM
 ([fe80::897e:cfd5:b29b:c611%6]) with mapi id 15.20.7181.019; Mon, 15 Jan 2024
 19:20:46 +0000
Message-ID:
 <AS8P193MB1285EEAFE30C0DE7B201D33CE46C2@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
Date: Mon, 15 Jan 2024 20:21:42 +0100
User-Agent: Mozilla Thunderbird
From: Bernd Edlinger <bernd.edlinger@hotmail.de>
Subject: [PATCH v2] net: stmmac: Wait a bit for the reset to take effect
To: Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jose Abreu <joabreu@synopsys.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Jiri Pirko <jiri@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>
References: <AS8P193MB1285DECD77863E02EF45828BE4A1A@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
Content-Language: en-US
In-Reply-To: <AS8P193MB1285DECD77863E02EF45828BE4A1A@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TMN: [awWvB8M45afXTdq0zJngE/LO/0atHbZDLwB6sZo2A9pBAuJIjOQOuTWYzCpl2Dq8]
X-ClientProxiedBy: FR3P281CA0205.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a5::17) To AS8P193MB1285.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:333::21)
X-Microsoft-Original-Message-ID:
 <f6be722e-8265-4eb2-a91f-857e55dcf659@hotmail.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P193MB1285:EE_|AM0P193MB0769:EE_
X-MS-Office365-Filtering-Correlation-Id: cbe21b6d-df57-428c-057b-08dc15ff1340
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	FAOybPWN+qdlZCcWoVUxF0Q7xokWhTgkX+1Kdolkck1Q9Dt7P0peyR/WSz/cE73SGgq3Cn0w/RoYKrXjDIHUv5JFQVHeCiOsfffLh0+O29P8wybyco3hyWUGV2dE1X8dtwUju+psuM7DFe+SzbfTy+pAh5dk3cYMEMHACFvH8ISLvX9mMT8Ah5tZIqbR75rT7HRCuASiMhwBz7rAP3uuSSGZP3GrQ9V9Ajw6UAbZyWcjnQ+5iBJ6EEDmps2L2iv944v7zaeAu8vLAPNWpUd0PCR71FY5kTXMAHovK65GL2Uur10/vS0SjYRNXH/Bv0X6zOH1B6YfeolFvbR8l7SGtT8Raj/gBPFHI1JtUdr9vGu7MCHq0u7J8T9MYxMku0YrvnIql8izDV3cHy3u/bdX/Pt/Lix0rN0EES0wIr73kuvbm864qN5zmmnD1lu1z1I85oDIHWNzQuEfGUw9PVK9a00LbfzT6XrE+qAuM1Om6JY1MweRuyDJhadiQBN6J7HK9qGEbuQZTk1pZWBKW6RexNU7joFhG9CvX8nhyMwjLbzPaI36a3olzOWjjPyf+Oxkduo94WBOgg1wzkIDdAcSgAJIZgY9fB1KX5lTCpE2F48=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?KzVrSmFyK2k3VWRiaUpaNzN4MW1za3RMM0hsT01vajdIVGhzV1k0WjE0M0Nn?=
 =?utf-8?B?SVp5NlpIZ0x4blBqdjYwSk5la3VoNE1YK3VBWDJRZkl6WWJtRHBIa3FaS3Vj?=
 =?utf-8?B?bVR5cmtWOGJDajVocERCcTVxVkQ0SFJTYnBIaTdCWDZpQWFpUVFXaDVvM1g4?=
 =?utf-8?B?dHpkK1lqNmdYRy9ET2xLTjdwUUlzQWhhNlllRjdtNnpqS3ZTLzRjeG5OTWJY?=
 =?utf-8?B?QkZVYWY5WUlIU3ZyS2VCMHJaL2o3a3JoUXc5a2o5b1ltNjJGK1hYS1h0ejNJ?=
 =?utf-8?B?dEp0NnY5THVJUk5SNG9Gamo0Z29ISzlGdHllVWM4c0JjUzBsVG82amx1Yk9q?=
 =?utf-8?B?Q3JKYTRVcDNScWxPTTFWa0wrUkt6MTV2Rm92TGVKU3AzeHhrbkwvT3hVNHNK?=
 =?utf-8?B?ZlZPQ0JDVVNyRVlCRDBESythOXFHVjFxMmd4dWRHMFpHZVVQcUpZSmhhMnZS?=
 =?utf-8?B?R3dMZ2J6OUVXSkZRVkZNQ2hSVXdFa0dmWGo4ZTZVVExwZnN2V0QzWWcvQThv?=
 =?utf-8?B?akJvcmNJWHo2eXl2b1FzMDRqMnBsd2xvWCtYWWw5WExKMVg3TzY1NHJBQU44?=
 =?utf-8?B?S1dLTUxsMFpFSGp1eXF2b2pRYkFTM1BxUVZNamFxVjd3U3BMUy95YXpHQStx?=
 =?utf-8?B?TkNDM1haWmx4V3luYjBnTjU0UVRjZjB5dWwrNS9rME44V2hRemNIOGJRSUh4?=
 =?utf-8?B?dnBBU0xLMVJ3d2hNNFpjVFJ2NUZIeG5IdU9ZdG1rbkZ1Y09DRGZWT1RSNVkv?=
 =?utf-8?B?NHFzdkx0VnVoSlBwZ3pwM2FvV3Y5ZjBTdndVaFQ5VCs2V2d5ZU1Ta291STB5?=
 =?utf-8?B?TzVCY1BxZEdBZUFIUTZ0SWhweHphbW5hT3NjZGk0Ky80UHgxS3lZN2NvNENN?=
 =?utf-8?B?aUh1WVlEQXVBN3pqNXluWTlzNlpIUTNBUzRhbWtBMTVneXJydkJCNGJpT2Qy?=
 =?utf-8?B?b1N6YW92c1YxYU9ydjNQd21ySXlEUzFvdEtUWDlEbDFxSWJmdkFBMDVVY1A3?=
 =?utf-8?B?ZDVKRnRPVC9XejIwUnE0NkRsZURnMnpnb2ZkSFZySDBjQStOSnN3eVlJcHhj?=
 =?utf-8?B?S0ZhTWM5aExubjM2NFBxM2NBR2ZXd05LaE5LSXFOQm5MeDY1eDJjU3E4cUV6?=
 =?utf-8?B?TUpCeHlGclBLNFlVTVBWSHdEbzBrRG01dEFVOGRLTUpyT3dqSGl6UUEvUmRl?=
 =?utf-8?B?azExL1NMUG9nUllRaEdmSCt6YUhUTXFkRVZLTWM2Z2VaMHAzSjE3TUI1RXdB?=
 =?utf-8?B?VzN1eGh3M01WcFo4WjdvaTdKODFkRnVXeVhvS3VFblhyUTNUSzM2VVFUSWo1?=
 =?utf-8?B?eDV5Mmc4NHpNR0ZORzB2UWtNRG51WVF1REVFU1hhN0V6ZmlheXAyUUVwSitI?=
 =?utf-8?B?STZEcExBM0VHUjlIUUs0WllFMGg1NVVSYnIxd29WZnZOa3hINjIrWUNhcUdq?=
 =?utf-8?B?UU5Nc0ZGUkpuOUIvNXFwck5iNUFhaFd1NEZlNnR6bEdpdmczWmxHbUR1SFAr?=
 =?utf-8?B?aDJvWnN2QUphUXNZWUpMb2JXZ2lyOUF3cEhvNVpZNFl3RW9ld29Hb1IrZm02?=
 =?utf-8?B?OEVMa0p3aGE3YjBqS05oZlgvYzhuOWlseUxrejc1N1dLdCttVUxnQzJCNUZH?=
 =?utf-8?B?MzVRaGhVVGQ4dUd1V2FTQjZnR2hrSHZHYUNBSUdNVTRaVHpHSlQ0Wi90N3Nx?=
 =?utf-8?B?NU9hYlluWGFET2c0blNXaFlPNDJRWStoeTljV0l1N0g3bUFmOE5tWVJQYjRu?=
 =?utf-8?Q?BFLE/rhKobmfAK5kzM=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-80ceb.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: cbe21b6d-df57-428c-057b-08dc15ff1340
X-MS-Exchange-CrossTenant-AuthSource: AS8P193MB1285.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2024 19:20:46.8394
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0P193MB0769

otherwise the synopsys_id value may be read out wrong,
because the GMAC_VERSION register might still be in reset
state, for at least 1 us after the reset is de-asserted.

Add a wait for 10 us before continuing to be on the safe side.

> From what have you got that delay value?

Just try and error, with very old linux versions and old gcc versions
the synopsys_id was read out correctly most of the time (but not always),
with recent linux versions and recnet gcc versions it was read out
wrongly most of the time, but again not always.
I don't have access to the VHDL code in question, so I cannot
tell why it takes so long to get the correct values, I also do not
have more than a few hardware samples, so I cannot tell how long
this timeout must be in worst case.
Experimentally I can tell that the register is read several times
as zero immediately after the reset is de-asserted, also adding several
no-ops is not enough, adding a printk is enough, also udelay(1) seems to
be enough but I tried that not very often, and I have not access to many
hardware samples to be 100% sure about the necessary delay.
And since the udelay here is only executed once per device instance,
it seems acceptable to delay the boot for 10 us.

BTW: my hardware's synopsys id is 0x37.

Signed-off-by: Bernd Edlinger <bernd.edlinger@hotmail.de>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 3 +++
 1 file changed, 3 insertions(+)

v2: rebased to v6.7, retested and updated the commit message
as suggested Serge Semins review comment:
https://lore.kernel.org/lkml/b4mpa62b2juln47374x6xxnbozb7fcfgztrc5ounk4tvscs3wg@mixnvsoqno7j/
and retained Jiri Pirkos Reviwed-by from:
https://lore.kernel.org/lkml/ZT+Zq4j9iQj1+Xai@nanopsycho/


Thanks
Bernd.

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 37e64283f910..b8e8f6e963f2 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -7440,6 +7440,9 @@ int stmmac_dvr_probe(struct device *device,
 		dev_err(priv->device, "unable to bring out of ahb reset: %pe\n",
 			ERR_PTR(ret));
 
+	/* Wait a bit for the reset to take effect */
+	udelay(10);
+
 	/* Init MAC and get the capabilities */
 	ret = stmmac_hw_init(priv);
 	if (ret)
-- 
2.39.2

