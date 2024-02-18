Return-Path: <linux-kernel+bounces-70410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D00D859762
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 15:21:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EAE14B21033
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 14:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 371CE6BFCE;
	Sun, 18 Feb 2024 14:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="X2GhJ1kh"
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2138.outbound.protection.outlook.com [40.107.7.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 825BE1E867;
	Sun, 18 Feb 2024 14:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708266102; cv=fail; b=Mik9cwQwM7264FcUFGHtUyV+3t7VusnObXTTrUSD0p5qfL5b+JJ39ZssUskLhklitW2I+7xJLn9j5bxmpHJD3bfj+iNicIKI44usJwwLinyoyC98AZNz06M4DLCcahFjn1UnbcNpb2nB6SlUskEM/AGH9rx2OGgcydjSNld2FVo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708266102; c=relaxed/simple;
	bh=rN+jm3tyucYIuKG1mMBU6uDAUc67FzQzfCV5sdxpmI4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PHuQuA4XKFSDCK9uTSSw+rvyjOAX0/U7K5hlUrq59vYU9E7fbqaGMZRUCg1mbfmYZY4N6FyRwm7drjqCDsZjqaJVyYpTXejGcWUPOHnevNqOhw4LDpyNNAGf1sucKBzpDrclKhdUFnyrUBk8DOUjIdbX0/zZe0a9ezELJPwXauE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=X2GhJ1kh; arc=fail smtp.client-ip=40.107.7.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JDm2NXS8U1sEE53C0XnZKZgNnEBvnv26kEFd7ehbqV60P4QW1gKSFQ8JNWzyuwhpQFkARD2Tod2ziZoPYqhcU8D5hx/tyeFAd0umoYeD8m3h+WAlWJjaTkeNH6v3rK1urOEqvgu9rzKw30wYT98l/eYox9x8FJLe778BNJphkxGbxMRmj8vmKBCQgB2dCk+5PKtan0b6lAMUiHmlE66qGf9svmWdaEtAeFV6cTgL37B6klwqlOOIL48MChnAkXmgcZS/rc09I7lhI1x6N0HdqRpFKFjEkx+rLoQSUFjze0IItLoo5KzSLCjE2AdYt38zDDymmuYYJ9PikgOC2yNeCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+eaXtPTP0ScXyB7ql5mtBYd2Yy1cl8nSVIM/y61lZN4=;
 b=obKPMSwi3m+483E/KxN6y8E/b3MnpBioVcRwGCLurX951jarmuAxa60POB5X3st1+BZlc30+nonC9QVvMdENaouDZ0Ue0fKDx+Vh+92gQi8Jrgcsyg5i8zIFs4yjMrDPxuIjTxGxPVdv43NuPTNrgdmP7yxSDpTwiwk4fSua+wMKICDQQGB7W3tKnqVT+eOr7iNpuL8tkaEbMIF2eKbUI5BXHJmMcHwMSbi1RsHCeqXpdssHfwr3GDR1GZQIMz64Bap/xxlZPfikxTrwTOtwJ/5FNjZJIWn8AlLej8mBgPKmZezwgKUsbIeVmWIjk4xGoLQGQ7vU45hEUWBBxV5crA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+eaXtPTP0ScXyB7ql5mtBYd2Yy1cl8nSVIM/y61lZN4=;
 b=X2GhJ1kh9yAqon2Df9VART7jOEsCT7YEXENeEXOCWOhrNZMRyvwvXoyHyq/kgIY/1EfYHdVBCfapT41Hzu2RjTGKGslXNi62DmdhzV5PBAw1tgfyjyEYEsXg5AJI+Bf2keCgXzxjJxzde6ZiXps3mSqYRSaS+DVj/NMaQxwYGmY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
 by DB9PR04MB9914.eurprd04.prod.outlook.com (2603:10a6:10:4c1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.31; Sun, 18 Feb
 2024 14:21:37 +0000
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::3b94:f607:ebe1:7d6c]) by AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::3b94:f607:ebe1:7d6c%7]) with mapi id 15.20.7292.033; Sun, 18 Feb 2024
 14:21:37 +0000
Message-ID: <26eff838-9f87-452f-8bad-90ce3d389255@solid-run.com>
Date: Sun, 18 Feb 2024 15:21:33 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] phy: lynx-28g: use read_poll_timeout when waiting for
 halt/reset bits
Content-Language: en-US
To: Ioana Ciornei <ioana.ciornei@nxp.com>, Vinod Koul <vkoul@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>
Cc: Jon Nettleton <jon@solid-run.com>, Rabeeh Khoury <rabeeh@solid-run.com>,
 Yazan Shhady <yazan.shhady@solid-run.com>, netdev@vger.kernel.org,
 linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240218-lynx28g-infinite-loop-v1-1-59cc5cef8367@solid-run.com>
From: Josua Mayer <josua@solid-run.com>
In-Reply-To: <20240218-lynx28g-infinite-loop-v1-1-59cc5cef8367@solid-run.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL0P290CA0015.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:5::7)
 To AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB7586:EE_|DB9PR04MB9914:EE_
X-MS-Office365-Filtering-Correlation-Id: 58fb878c-3e5e-48e2-986d-08dc308ceb07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	O5aUJOwcj7CAmLhvHHiO3JJOJwTO9cFCHFVJvkYwPju/a/rOxHtG6dteJ3qY7UWJUb4elJOWKLEWCvWLg/HaLKWLEdKBSxq+eA4eFq1TPp+XATYblKTwJbW8BO9OKGYazIUDU2S0ZGQ5YBH8+wEoGCU47Stwql4GbZED12u0KtiMcaIX7W1QI1KKhG6IzVN8S3w8x7E4myU2en6Iu3KibFQfMUeFbwATKYL77+RB086oLC6ShdopbP6eP/KHrPXBmjDh8WIAHZ33AwXAwAfT5V4WTM8qRbWkJdO9qoyV5n7XaC7drkkpt24Ndqueg6yh5tnhyCOaI/1QyX5gWzg6PwtIEOxLayRFa4AV+aPGPuCuwzqONw8mWJL9A3l20e0d59MQlgO5XAeqBOl47xcWS7GfpnSn1lvioU0K8XXZZqDIAioBcEqHq/aW3WBwPpD7O64xHi+o/wn5qi6cu0ys1Lv1qa6MDWhZ0lrYQj3VlUwOpipQaCthzg2IJwjcsixEHcSV12FiWI44jEEZkHWbn2FR/9103FBIzJkRyOQ+r5d2kW51B1SfBkTAwYYNSQwP
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB7586.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39840400004)(366004)(346002)(376002)(396003)(136003)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(478600001)(6512007)(6486002)(31686004)(41300700001)(4326008)(8936002)(8676002)(5660300002)(66556008)(2906002)(6506007)(316002)(6666004)(110136005)(66946007)(66476007)(54906003)(83380400001)(2616005)(86362001)(31696002)(36756003)(26005)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QXEzaVo2SmZHWlp3KzgzdldXa3JkZE1jY1B6dXNLWU9HR3RKcm5lNDQzZjdj?=
 =?utf-8?B?MSt4VFEwYThLUE9HM2RGb3lmTWZhRlBNSkFwbjVRV2lkN3JYdzdIamRCTWZk?=
 =?utf-8?B?QnY5Q0ZzQ1E1SXdPWnJmb0kxZGRyY2hzU2JBL3lveVgrbkhTWHhGaWtFclJM?=
 =?utf-8?B?ZzB5WExFek5ReUFINUFBRXQzYlRrZWRFS3NXQVRvQnNyOW0zMHNDSGZ5K2xn?=
 =?utf-8?B?b3BVSm1hYkNwdDhoWEIrdVY2Q282UkhpdU5RVm1UVUV6UXdOOTZSajREUnpq?=
 =?utf-8?B?bTVHZmVJSHc4TkRKUUhpYWh6MHJSbExMWUNSS3hnMzVya0JPNC83dDB6NFVO?=
 =?utf-8?B?R2NEU1ZhSDIwU3BueGZzK0VkeFFHTU90Y3BrYkhWYU84Qk5sUElTbU9vRXQx?=
 =?utf-8?B?RHZ4YnpKdFF3ejZHVVJzNlhsMjRFWWFxWnpRSWdrVkYydXNVNGZGQ1o0VFdQ?=
 =?utf-8?B?d25PUDYxV1loaDJMaExjT3B2bEFGZlFxL3JHbUVhdytJMVhDR2t1T3ZpZXY1?=
 =?utf-8?B?cGtQWklFekdyQVRJOE1BY0xMSU1IMnRTSkFKaU02eGRCSEtoZmswOHVxY0lh?=
 =?utf-8?B?cDl5cHo2N0NjRGpxWWlUb0xNdCtjMlY1SHlwa3Z0VGZhZFRDaHVBSEtLRFV3?=
 =?utf-8?B?TnRKK29SL2Z4SUJ5NVdEZHZJU012SnBzMzlVRjllN2ZPWnVzZWd2SUREd0l4?=
 =?utf-8?B?WFcrVHlBSFgyNTNMZUdueXBmTTJnZy9kNnZpdUtmRUFtN1JqMjgrMWszTnlK?=
 =?utf-8?B?bXA0NWRuZFo4OGFLQnpzT09zcUtybmU3aFFaS3F4Sld2b1lqOG9tVzY2S2ph?=
 =?utf-8?B?dFJuZXlkOUgySGJyT3JMNk8ralREYkVFOGxtSERWRUZzNmhjMWhHNVZGdklV?=
 =?utf-8?B?czhGcnR1TWZHS3pDaDFWVmtvQllqL2U3bGVBc3RBMTcxY3ZJOXphV1FiMjND?=
 =?utf-8?B?WkhLOTM1dzJjb2ZrSFFmS2JyRWo0R011MUgxZmtkWjh2d1kxOGhlUXhUZ1pX?=
 =?utf-8?B?bVNVWG5DVWFocml1VFBWSVhJQ2o3TUNVKzJlSFM3bTZoN2wzbkJvd3VmOG1Z?=
 =?utf-8?B?VnVObzF1UFpZdnVaTVp5am9LZ2ZsV09Oc3BYbGlnemNtTVRqc3dnWDF4bjYr?=
 =?utf-8?B?Nlp0dThyckhqRlBJbEFSQ2l6dXEyT3BUMDFRY2FtemhwTXNZV0g5bm9Jb3NR?=
 =?utf-8?B?d3phSTE3SlRIZkp3TWtSTjdSVkF2bDBMSFRJTEhwOTBZZEVZWmxBTmVqZkdO?=
 =?utf-8?B?SnN2eCtFemtsbjZtODJ5cng0TFRWMlQ2ZnE0d0FiK3AzS3AyRDNkMGdiNjRU?=
 =?utf-8?B?ekR4RG1qUzZmS3pic1YvSTUyOFk1NStTL25hN2ZSTTZlRzIvbEJJTXZ3WEdp?=
 =?utf-8?B?UUdpQnN1Z1VJRUswM3NxQjhBc1dlMkNNUWNsQllaaFRnM0xheXN4Z2JTZkg3?=
 =?utf-8?B?QlR6b003YitjbjRXWE03enpBM0NKSWhmYkJLZVI2U2FRZXN4S3BtMi9veG1U?=
 =?utf-8?B?K2hGNUJhN0NzemFZc0tVSkR6WDRicHV4bkFnVUZ1Kzk5VWp4SUlIbjNVZWxD?=
 =?utf-8?B?cUIvRzRPNXFUdElmYnZ3ZUxXYUppWVk0ZjVvV29XMDNGOERxQ2Z1NWFtQkYz?=
 =?utf-8?B?VmJiQzNDMWRaYitmejVKZWI1ai9ybTdtakhjQng3bHo2WlBHSmhoR2hOMjV3?=
 =?utf-8?B?MERmNUFEYUxOTExKM2pNd2tucnhKVEdMOGtyMStzWm5QVGFkQ1l3eXg0Y0ZH?=
 =?utf-8?B?engweXZOazhFUDgyb254MHJYdHAwdlRJM2MvMHBJbE9OM0FRazh6L0RGSlhv?=
 =?utf-8?B?a1dxajlsdjBPRkJOV0gwSS9yQ0NVclBzZm5RTmIwbGh5azF6akFDRzE3N3M1?=
 =?utf-8?B?V3NBNWlEVytHWi9uRmtqTmpnNlpoZ0NoTmsvcGZjMHFLZElPaG53VSt4VmNa?=
 =?utf-8?B?dWZHODZiZXg3WkFIQkdnS2tsZTNxcXhVNStTVVdMOWVHQzJHQlF1azBuTFN4?=
 =?utf-8?B?UFVJcTdySVBFVFdTR0RXUjFzZksvbkphbUlWZ2ZUQXBWdHgzdmt3OU9QcXJW?=
 =?utf-8?B?VTBHWSsya0RXUW95Vm1USnAyaGh4RFNZZGJvRFIvdkFPYkk2ZkVsQ0kybjdm?=
 =?utf-8?Q?I8FGPd49wTE/5Dwjh8mRmM5Fl?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58fb878c-3e5e-48e2-986d-08dc308ceb07
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB7586.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2024 14:21:37.8191
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MwmGb7n1UjWBMMGIg9ZgbSNjuC0UyxmigE/+wbbgXOhmsjbzvSXbfREXvhgnY9mlgR32FVkDhYV2VFLmbFrTpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9914

Am 18.02.24 um 15:09 schrieb Josua Mayer:

> Power-on and -off functions set and wait for self-clearing reset-
> and halt-bits in serdes registers.
> In certain operating conditions these bits may not actually clear.
>
> Replace the infinite while-loops with read_poll_timeout to ensure that
> power_on and power_off will always return even when the bits did not
> clear within a full second.
>
> On timeout print an error message and return error code.
> In this situation the serdes lane has an invalid state,
> without no known recovery procedure.
>
> This fixes an infinite loop / hang during boot observed on a
> misconfigured lx2160a system where serdes #1 PLLS (161MHz) and PLLF
> (100MHz) were mistakenly swapped.
> After reset the PLL's did lock (to wrong rates) but the serdes locked up
> and never cleared either lane-specific or global halt- and reset-bits.
>
> Signed-off-by: Josua Mayer <josua@solid-run.com>
> ---
>   drivers/phy/freescale/phy-fsl-lynx-28g.c | 42 ++++++++++++++++++++++++--------
>   1 file changed, 32 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/phy/freescale/phy-fsl-lynx-28g.c b/drivers/phy/freescale/phy-fsl-lynx-28g.c
> index e2187767ce00..5ae5b47619f8 100644
> --- a/drivers/phy/freescale/phy-fsl-lynx-28g.c
> +++ b/drivers/phy/freescale/phy-fsl-lynx-28g.c
> @@ -335,6 +335,7 @@ static int lynx_28g_power_off(struct phy *phy)
> ...
> +	err = read_poll_timeout(lynx_28g_lane_read, rrstctl,
> +				!(rrstctl & LYNX_28G_LNaRRSTCTL_HLT_REQ),
> +				10000, 1000000, false, lane, LNaRRSTCTL);
> +	if (err) {
> +		dev_err(&phy->dev, "tx lane halt failed: %d\n", err);
Message should be "rx" lane, will fix in v2.

