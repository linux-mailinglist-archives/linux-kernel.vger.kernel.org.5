Return-Path: <linux-kernel+bounces-144490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75D868A4701
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 04:32:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 212732815BA
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 02:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95DA9179AE;
	Mon, 15 Apr 2024 02:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nuvoton.com header.i=@nuvoton.com header.b="cC5q65Hp"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2072.outbound.protection.outlook.com [40.107.255.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF6C17F8;
	Mon, 15 Apr 2024 02:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713148362; cv=fail; b=sAEUHyUUAGGSEcovnlXiA8sNAzd8Z7AItbmFVWrWZBIvP//8O+7pOiinHOcbf13m9HOpxPhBvMr/r0MOqjEaSz4SQzn6YJzRdI3yl48wSpqJiPyLqDlCFrb0nGu4EiUkiWGelhDGSUQ37Rg9u+POLnY7qqeKHkAFAyhGfsHou30=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713148362; c=relaxed/simple;
	bh=sa5mdYn9TaZXXnuFxQmDMoUnWPfP0O3Uq7UlLne9kyo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bYmMTKLVw28QqCkNS5fetl2Gnbx6Z29hetpvRS6atabo7shn7jLnOzsZfDd+GfY7pcdeU/dScl3FCWQJqxNsLoQDlDjHHvVE54em1bYiIPGsPs5kDlNAOV4sxKWaxZdPG9CNw9nF/50kwbLqSGBtUknrZ+verqvbgbWsUOSJdIs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nuvoton.com; spf=pass smtp.mailfrom=nuvoton.com; dkim=pass (1024-bit key) header.d=nuvoton.com header.i=@nuvoton.com header.b=cC5q65Hp; arc=fail smtp.client-ip=40.107.255.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nuvoton.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nuvoton.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xu8N8q0Np/WlVsNehHpmmv/20+2Ubvc/XwjbENb2Q5iNNXfqghJ6aaonf3HHVPn0fmXd+EvdUk1UTCxJSy/R5e46AYng8NXG3WTATL72ANn0GDuV3nLtcEx4/xcZKiMylv8lx6KymfLiALeBGJ3uVfYOkb5UCb/RQw6pM4dI9OJ3hVXQvD71jj+Y8u0tuOOJXl2EC35AMrJujizvZc9NFwI7Cc0t/uPh6WZ5qm0VCez7D2vfvmdxqEbfXEBeXRmbdvjPk46v1vDnNzjmh1EkTU2uIoMZEDSAmhCrWnAjQpPcY8JkSmC7gfJoYuFcwvMGgcjU8jv2jTcQ2mxiBWcQwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m0r+aQP184g4sAk/uS7H0OPkyHiMikFUaIIgla7SlF0=;
 b=Grz0nVJCVqQxUnctW8v0CDGeIdHPWRgu/bmf3iYj3jAbRxx3GgIAlC1ZNCEi0FDV2iWIOZuvglaNwjN2k7RDNGg74qbYYJ7TVaNQ6TqcFRiRJKriYu4fJVwHc31d9vD4h9ZD6e+TtaDHihToH3HksmpOPZEaICAN9VFMf2DvRHjdervdqpuhdeKeKKv/Hq2TfF/muEB/frvaC0TftyHIjy8mpeErGdrVKd4+vEh03KE9oqOaNY1wLsupq6aYCdQ1+cAT/2D14d7PZgQoZn8MGY3kb3tYmqfyxM7x8MO/YI0Ziv63419jMN+7iffvlSGR4yZpEOUgMv7Trc0n7VFhvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nuvoton.com; dmarc=pass action=none header.from=nuvoton.com;
 dkim=pass header.d=nuvoton.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nuvoton.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m0r+aQP184g4sAk/uS7H0OPkyHiMikFUaIIgla7SlF0=;
 b=cC5q65Hps01GTMzpiGQKpOr3OxXKJbpMrlaQzaoRqMfPq+ND+TF7CJAdjMrIj7y4ljplY/AS0A/lmIzFiEDs7QujTYC2UfazgJhr87o4ymgQQNgcT5URl2LHEaKOHf7jEF2DyHT1fQF6AnDLOfNY+L/yJNaAdE8NX25d7+HUcE8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nuvoton.com;
Received: from SI6PR03MB8987.apcprd03.prod.outlook.com (2603:1096:4:235::7) by
 TYZPR03MB8295.apcprd03.prod.outlook.com (2603:1096:405:1c::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.55; Mon, 15 Apr 2024 02:32:35 +0000
Received: from SI6PR03MB8987.apcprd03.prod.outlook.com
 ([fe80::c2be:325a:575:8db9]) by SI6PR03MB8987.apcprd03.prod.outlook.com
 ([fe80::c2be:325a:575:8db9%7]) with mapi id 15.20.7409.042; Mon, 15 Apr 2024
 02:32:35 +0000
Message-ID: <81fa2939-37b8-479b-a03b-1f2ea17b2131@nuvoton.com>
Date: Mon, 15 Apr 2024 10:32:29 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] ASoC: dt-bindings: nau8821: Add delay control for ADC
Content-Language: en-US
To: Rob Herring <robh@kernel.org>
Cc: broonie@kernel.org, lgirdwood@gmail.com, alsa-devel@alsa-project.org,
 devicetree@vger.kernel.org, linux-sound@vger.kernel.org,
 krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
 conor+dt@kernel.org, perex@perex.cz, tiwai@suse.com, YHCHuang@nuvoton.com,
 KCHSU0@nuvoton.com, CTLIN0@nuvoton.com, SJLIN0@nuvoton.com,
 scott6986@gmail.com, supercraig0719@gmail.com, dardar923@gmail.com,
 edson.drosdeck@gmail.com, u.kleine-koenig@pengutronix.de
References: <20240412103554.3487290-1-wtli@nuvoton.com>
 <20240412155220.GA2918590-robh@kernel.org>
From: WTLI <wtli@nuvoton.com>
In-Reply-To: <20240412155220.GA2918590-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: TYCP286CA0232.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c7::18) To SI6PR03MB8987.apcprd03.prod.outlook.com
 (2603:1096:4:235::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI6PR03MB8987:EE_|TYZPR03MB8295:EE_
X-MS-Office365-Filtering-Correlation-Id: 651c4010-c32d-425a-b512-08dc5cf44f33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MjIvWndJclhEbTBqZEVYa1pWRGVzR3hYRDgyeDZVbk1SUStQMXcrL3FBeTln?=
 =?utf-8?B?M29FMXNsZmlYOCs2YWRBOCtZWGVRUkF0M3VERE1RTGdMS2trVk8zY2t4S2F3?=
 =?utf-8?B?M3VPRWp3QXJ4ZXJZeEdaOEYzNlhSR09Fblh4Z2lvWlZ1cmpnV1hCVTZyQlM4?=
 =?utf-8?B?cjYxRlloQVIxd0thRHlBcU9QTDFIYXhIMVVtK3VnaW5vTzVVUm5VQS9kd1Qv?=
 =?utf-8?B?MjVVTytITkdva0ZuSlZDRTg0d0dNYUhmT1pGYlVOS3F0dEdDLzVFdkpKTFNy?=
 =?utf-8?B?ZHVad1prdlR3ck5XcktBR0cwcWNYS01Gck9EWC9hamNOQnc0bjVaUk1pWDkr?=
 =?utf-8?B?cjhlU2xlNnRpWHJGMkhRK0FXdnNxTUY5K0RhWlRWZE9iZjA0SWFlcGRpbDZ5?=
 =?utf-8?B?V3ZDMk1Md3R6OU9KOENXWWs4N2MvTHd1aytybzFhT3FhdGVIY1YyYjRubXNY?=
 =?utf-8?B?MjdreVp0TDlMY2ljMFhkWmZ5ckZ1djRWMkRJeWRLbW1oRmZYcGQrM01OUW9a?=
 =?utf-8?B?RWNFb1JJdGdmUFdxV0pXVVV3cEowWnYwQU52R2dKc3hOWkM2c3E2aDlaRzNt?=
 =?utf-8?B?YmdwaDNKaWJMRXYzTGlmbk80d3duUWxxRURGZWx6YkszWXFPaUFGUGVHNWh5?=
 =?utf-8?B?M21ialdLMjVYcW1aTkxKTDZDcmwrVDVLMUxyWVdoSy8rZVdGcHlFVVM2Sk9n?=
 =?utf-8?B?eEFEZlp6bnZWWnl0emtuWlJUZnR3STJYY1VqK20vdU5yZ2pYZXdEdGsyMWxU?=
 =?utf-8?B?QjB5cVFHYW9BTEs2aDVzZUVmc3BLcjVENXZacVl2aE5UQmdhamJUOVFJL0w1?=
 =?utf-8?B?RE4rQnZxa2ZxYVV4YlVpVU9wVytzSHgxOFNIQzBqYWlhWG1pODlUYWNuRnNQ?=
 =?utf-8?B?MzZCTCtVMzBweWhYT29lT1czYjJCZndwQU4yeTJLcWpNc0lPY0lsTmZzeVYr?=
 =?utf-8?B?aEZ0dnFZWkNUM1VoZTN4cFNsNnVqalV6SnBZREJSbTluRjJtZmZsd1k1aVAy?=
 =?utf-8?B?eFQ4ZWlhTitQSHoyTklWZitBeEtNMUNXSGgrN1JZR3g2TlNOTmYrWFVNd0FK?=
 =?utf-8?B?Wm54cHVZYWw4T3hNQi93dFR2UUxka2xqWisreC85N1BHSXVyV2VNa2FVRCty?=
 =?utf-8?B?YWJoQ2FtL0l0V1JiN01JektLWUpKL3B6WFBEWnlTdS8yRzYrazdJZ3RyMGVr?=
 =?utf-8?B?Z0NHcnlXVEo3b3ZYUUNPQmpjUnNqUTU1N1VVNFFVNlZSTlFlY2gzcTlFa2s3?=
 =?utf-8?B?QjJqUzBrZGgwaGVtbWFHemZ0RWNiYWNERm1xMzdkODlKOTVGZDY5SkJ5bi9o?=
 =?utf-8?B?MnFFempaWmZxS2E5NmlWR1VidHZyVGlGWngrTUdqV2JpZVBxUWt5bnJvQjl5?=
 =?utf-8?B?bFJtVzJaeUlVcUM3N2I2L2FZUTZUSkN1TndLWDU3Y1VMWXZSbW5obm5nWXVG?=
 =?utf-8?B?WlJwZEtvcW9DbU5YNlg5dnVYWmdMSE81cVdhR0RhQlZvYU93SjZYL3pWZUNi?=
 =?utf-8?B?RnhQdmYySURmWkZkb202R3B2bXEvRE1Cbm4rVWVmZ2s1NlBrK21lVEFFWG9X?=
 =?utf-8?B?S3FzbG5JZndPaVNNMm1OQjlyU2RIZTVWcE1tUTdTNmZDKzdqZ2dmT3lGQWEy?=
 =?utf-8?B?UnNEOEFSditzN2pTdUdyZEdxTTJnSkdLS2pxd0EwK2thaXBTTk1NZTNaNHdk?=
 =?utf-8?B?TUJDSElLUGRCMGI1NTRvb1dKQktRR1h4UFhtRlFBMDZOcnRwQ0s4MW5nPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI6PR03MB8987.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RS9HakFOYTAvOVVvZXJObVd5OG1CTE5kdGpVdVFCM0lzbU9QK3FqMkd2Zng3?=
 =?utf-8?B?ODJENXNHUWFjVjRodEc1WFhNa2FWZWUzWkpPbis5Slg0ZjVaUzdvSW5BamxF?=
 =?utf-8?B?ZWpSeUl2VHE2YkN5N0Y5SGFEbTErMWRmTWd5TjhjUGRyZmc5NE9DM0J1SzIr?=
 =?utf-8?B?aTk1cmxtTTh4TTVDejlXLzFJL2VaZHFGMlNaQlY4L1Y0L0VxTnFaTTVCbkFn?=
 =?utf-8?B?OWhGN0pzL3Y3eHQ1dFFQMkdkQysvY3g4NjdzeXBmc1JQVWpGYml6S0Z1K05r?=
 =?utf-8?B?RDB2QkVSYjhFS0NzNzhKVnJRMHlYYml1a3pwRzM5a0hxRU45SnU4STJvR0lV?=
 =?utf-8?B?MVBkMlhxUWF1YkVBK3RUYTFVbTE5Ulg5TThuWmRycWVnRDEzWTR4KzZDQStL?=
 =?utf-8?B?VHg5bCtleDBUS0lXanpYNVdRTFBwN1dhRlJPN1J2MmhqcDhwcGxJd3pTNkNt?=
 =?utf-8?B?eldvN2pxY2NYb2NVN1htRFdWRGFVaFpqeFFFZmZ2ZXNTQkQzT2pvS1d0RUk4?=
 =?utf-8?B?NnhoVTZGSXozWWFTdVVncnE3dDBrUGkyRmtzSkNlTmYxN3pZVW5maGNrUmZK?=
 =?utf-8?B?SXg3ZnlvTHRqeGRXTkk5NmJ1dXFNV1M2THh4ZkNWMlgzbVBFVnpDc1A2eFBY?=
 =?utf-8?B?QzlsK0ZnZXIzbmJ0NEFVeU9zUk83TUZ1NUc0YmpkZ1dXYmswYnFmSU1wazZP?=
 =?utf-8?B?NEg4dE5GMEtSSWJGOXVzcVR5YW51bGIzZ090NjB5NFhWUlNKSlZUR0VnYW4x?=
 =?utf-8?B?SmZRUFl4dmJsTTFTZEl4QjFQUGQ3U25wK3VwUklBNHVzRk4xanhaWXNKWnNK?=
 =?utf-8?B?T3lOYlh1d0xYd0tYRTFRSldBTjhOS0NZc0cvcW5IcVBpclNEMExuU0lJUlZU?=
 =?utf-8?B?Q2dIV05lSUk3ZEhxdDd6S2FMMHcvcUcyMytCd3ArMTFwdTllVmlqeUZFT0lp?=
 =?utf-8?B?N2V6Y2tpcmkyZ1QxWnlMYUowVTJ6T1d2N2c1TFpad2IvTDNOUVhWK2FFQTdm?=
 =?utf-8?B?a1E4RTc4R1NHYXh1Z2hXRXVzakVzb0JiQy96YXp3Q0IvRHY3eGIxdjBZM0g4?=
 =?utf-8?B?b1Q1VkRiVEwyRWp2d1NKamMxK3NrK0hOc3lvd1FNdk5CRnNEMlJlTkZ4eFdl?=
 =?utf-8?B?OU1NSHJpUDZBd0hwQmNnTzl6VzEvUzRGTnQ1VitzNnQxRndJaUxvcGF4M2xC?=
 =?utf-8?B?dENFOXBocVpFL2hMaUV0V2JQMDZxN0pJQnpyTlltaTUrNlZtdWpIUmwrSlBP?=
 =?utf-8?B?SEU5dU1heWY1b2hmTHE2WHBPMUtZY2xkdFRESEZnb0JIdmhpUkdxcU91OEFz?=
 =?utf-8?B?SHhRaVRCQytGN0lFNUpGWmtZbVNaWmZRK3lpdm94MUhoekFvYVg1NVJKeW8z?=
 =?utf-8?B?ckpnK3Z3WkxqdkpaeWYybTZvYlZMbVY1Y1NHQzlvTjFqcVd2M25YMGcxc2xy?=
 =?utf-8?B?bnRGZy9OQlFaa0pJd0RscXM4MFYyM3ZoSlBDckdqNTBVYUpCcXFVRi9YTmhn?=
 =?utf-8?B?LzdrcERhMDZmRzhLYk5MOVdpVXV1VHJwOVZrL2xVUDJtZDJ3VXRVS3NOd3RU?=
 =?utf-8?B?bzJDYlJsVy9BdFpqbWJod0xEdXB4N01XT2o4N0FPT1RWdTZXaytwdTI1Yzdx?=
 =?utf-8?B?WDN1MmZvN3RKbXVsSUc1cVZRR28xRm00cnFkUytleW5uRFkxZGdZWkM2VVRX?=
 =?utf-8?B?Mi8ybmNpU3Q3WXgyV0Y3WElWVG5UMlptdUtsYmNaNXR0UU5DK1F1cDZYOTE4?=
 =?utf-8?B?VG5zU2FROWZjQ09GczJ0Yk1iR21Sd2NMT09OYzdGdW1CNnlPbmtDdVVzK1Y2?=
 =?utf-8?B?NHZ1U054bitqMEJBazI1SVBsNytHUzQxVE1DSEl0eXUwOThJWFBlTkkrb2JI?=
 =?utf-8?B?RnNSYzVEQUNMRUlnVWVLYXJnUUdMZVZocGlBVUVzQ010OUhZVVlqcUlhQ2tN?=
 =?utf-8?B?aG1FNTAweW9vVkZDL2hyQjRheWFPQXg2VE9nWGF5dDMxYnR2ZWxZRmxoK0ph?=
 =?utf-8?B?WFU2eTNNQ1lKb2JaeThncU1HSjdjTGM4WUZKRGhtKzVqNzlFSmI2U1RsS3FI?=
 =?utf-8?B?OXBTRks2TXRWekhsdS9iVUlaVjBndi9BTFNSUHdjU1Y2a3M1bDR3dXQvd0FP?=
 =?utf-8?Q?lHBxvzNGd5UwhF1vHNkeXWijl?=
X-OriginatorOrg: nuvoton.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 651c4010-c32d-425a-b512-08dc5cf44f33
X-MS-Exchange-CrossTenant-AuthSource: SI6PR03MB8987.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2024 02:32:35.1836
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a3f24931-d403-4b4a-94f1-7d83ac638e07
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6xRGQENI2rio76ZXlpZajdhEFPWHDPwubgZHk/Lj0vjfLzj/Cm+rBZ+CmtLZOQjVFMG9ANxT2R4bhgLwvofSIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB8295


Rob Herring =E6=96=BC 4/12/2024 11:52 PM =E5=AF=AB=E9=81=93:
> CAUTION - External Email: Do not click links or open attachments unless y=
ou acknowledge the sender and content.
>
>
> On Fri, Apr 12, 2024 at 06:35:52PM +0800, Seven Lee wrote:
>> Change the original fixed delay to the assignment from the property. It
>> will make it more flexible to different platforms to avoid pop noise at
>> the beginning of recording.
>>
>> Signed-off-by: Seven Lee <wtli@nuvoton.com>
>> ---
>>   .../devicetree/bindings/sound/nuvoton,nau8821.yaml        | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/sound/nuvoton,nau8821.yam=
l b/Documentation/devicetree/bindings/sound/nuvoton,nau8821.yaml
>> index 054b53954ac3..a726c5a9b067 100644
>> --- a/Documentation/devicetree/bindings/sound/nuvoton,nau8821.yaml
>> +++ b/Documentation/devicetree/bindings/sound/nuvoton,nau8821.yaml
>> @@ -103,6 +103,13 @@ properties:
>>           just limited to the left adc for design demand.
>>       type: boolean
>>
>> +  nuvoton,adc-delay-ms:
>> +    description: Delay (in ms) to make input path stable and avoid pop =
noise.
>> +        The default value is 125 and range between 125 to 500 ms.
> No need to state constraints in prose.

okay, I will fix it.

>
>> +    minimum: 125
>> +    maximum: 500
>> +    default: 125
>> +
>>     '#sound-dai-cells':
>>       const: 0
>>
>> @@ -136,6 +143,7 @@ examples:
>>               nuvoton,jack-eject-debounce =3D <0>;
>>               nuvoton,dmic-clk-threshold =3D <3072000>;
>>               nuvoton,dmic-slew-rate =3D <0>;
>> +            nuvoton,nuvoton,adc-delay-ms =3D <125>;
>>               #sound-dai-cells =3D <0>;
>>           };
>>       };
>> --
>> 2.25.1
>>
________________________________
________________________________
 The privileged confidential information contained in this email is intende=
d for use only by the addressees as indicated by the original sender of thi=
s email. If you are not the addressee indicated in this email or are not re=
sponsible for delivery of the email to such a person, please kindly reply t=
o the sender indicating this fact and delete all copies of it from your com=
puter and network server immediately. Your cooperation is highly appreciate=
d. It is advised that any unauthorized use of confidential information of N=
uvoton is strictly prohibited; and any information in this email irrelevant=
 to the official business of Nuvoton shall be deemed as neither given nor e=
ndorsed by Nuvoton.

