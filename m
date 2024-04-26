Return-Path: <linux-kernel+bounces-159542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73F528B2FFD
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 07:58:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28C762849F1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 05:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01D6F13A40B;
	Fri, 26 Apr 2024 05:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nup7zFcb"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2072.outbound.protection.outlook.com [40.107.94.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD9213A276;
	Fri, 26 Apr 2024 05:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714111114; cv=fail; b=PQKBzMK4NUCqgqZhVTd9V/kISREi6ytoIC1kJOn5eo0LhoHYfIgnen7i/smXNTBWMzPGETNqUcROl4AXm//VFaqq6lEaE+Mr8oj3HPC/ACnMt6unSEBwxQXWswlFBPI27Bd78n20ha/Tgm/yHQfzU5NCmiN3m+fa+LI5iSoKLvY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714111114; c=relaxed/simple;
	bh=5JxZ2x8L8rws3n8cFAGrBwecDFzxcxbpm/JHJUMLo/Y=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=n/qZC+E70YpjhNH7Mspu72Qau17LfFchFLiHzp8oPIRNOcx7eqrixJ7opIL18zlR/9LyibJUGpIYdwBfH9sFcWL5Ny5ia8wqUftAsEuQ40a5co3DTQs1ef22e810g+ainvQDd7Y144cvJchfoyrKlL+qn5zzyFbm8b4ep5qLkCo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nup7zFcb; arc=fail smtp.client-ip=40.107.94.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T0jo7hlQe37NSm2wc+WlhE0GEkWSmJ/Q0OyFmcq8cHKfvEA9yV6D42yK8dfz9tX/7LuZQAT28mmyDCbir6YSMDqHs61aZq3EY84EQmQnw5fWq5GPBAQ0sX3kUtPeFAyp51iF/6fWWnb2RrMTz3jJPEdz7VOs6ndITe2ab2J6tpfm5gQRDBtdL02l9lFCGunKwZnUCg8lyzGmSYOcxzbeK+g9UU3azI8QeeVuVIHwh9PP+H8H/mdVtNKVrgDmyl9G5HeietG3IvMjxXzF/JAgrIJ1m2sLel5O9e7kF5ziPEIaH4NDCQkoWRiLrcCv6VIQC0ZMnRlhuL4mpTLSPPb4+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MIGCs9Y0RGZksYJp2/esPn7CAcAe631OXSwbWzobtLU=;
 b=LjnbRwNnSth2CRNYnNtC1mT4iI7UzPUAVtaztDxrrixmrRXCDIicG5SJOCc1EfHyD/SgnKdycArevl4YwnblwOQ5vF9SIeTol0J+DfbKxZc8MVD082F/KT0BKMFFzMzFqlIhHx4Vd73HyFelL7h9s9cVmfg1yUkykGE55Ibtu0lpez2UzHTzYxRGaf/8s7hBS55LSVArzhv+1ZZ86/oh770kkk4XG9c9pe1lSLTssHa5Lyww2Nw2rBEL2YL118Cdw2JPGxdYbaxIjk18h8KnFyYO4pRC/hmN75XjoZmSXeN+kXxpSZ7y8Ak9RseV1ocD4NS1Lk9cxLSOCYAPySrc2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MIGCs9Y0RGZksYJp2/esPn7CAcAe631OXSwbWzobtLU=;
 b=nup7zFcbG4IUDcONYsJPnXFWKRBujkNRp7hsuXz1ntVgDgzXa3oHzJaHrnh3tIdPdF8oCFTQ41iWXfqCxyO+eSxeBDliRlSCqsBkQFNVTmwu2KiEUGaH8Hgyh5CVjtIpPwGJCjEIKrVKn4SncGOz5I8y9KJgAeeOu2xAW9emF9A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by CH2PR12MB4296.namprd12.prod.outlook.com (2603:10b6:610:af::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.49; Fri, 26 Apr
 2024 05:58:30 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::c3fc:3be9:dde7:745f]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::c3fc:3be9:dde7:745f%7]) with mapi id 15.20.7472.044; Fri, 26 Apr 2024
 05:58:29 +0000
Message-ID: <5a94e731-dec2-4c0e-99eb-054c3d1fa5da@amd.com>
Date: Fri, 26 Apr 2024 07:58:17 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: pinctrl: zynqmp: Valid pin muxings cannot be configured
To: Sean Anderson <sean.anderson@linux.dev>,
 "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <5bb0dc7e-4c89-4f3d-abc6-41ae9ded5ae9@linux.dev>
 <f42fd731-ba2d-4000-99b2-c98f0ce77b67@amd.com>
 <309b52e6-c206-4811-b14e-db5206adf902@linux.dev>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <309b52e6-c206-4811-b14e-db5206adf902@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR03CA0051.eurprd03.prod.outlook.com
 (2603:10a6:803:50::22) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|CH2PR12MB4296:EE_
X-MS-Office365-Filtering-Correlation-Id: 1668a55c-a9ce-40bd-9e84-08dc65b5e51b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q0grcitXcWVtbmR4WWF4TXdCcFpoZXIzN3BqeTJxeDlPTDdadWJMWS9ySk53?=
 =?utf-8?B?bHZiNE5wVHY2NUNsWGVUUStVYWRsSlkxUy9pUXpZM2FKMXU4eHhCZ2I5eUhJ?=
 =?utf-8?B?d0JsdE1LUG5HaWFYTktvVSsvNjZvVFZ0YnZIdVB2ZjFmZnY4a0dzSlRzOGFT?=
 =?utf-8?B?bStuMDF0UjdjcnJncUVZTHhNMG94dmdoS0YzNHNyQjEzUjg3U25pS3FqK2Ri?=
 =?utf-8?B?TGxzSno0LzhMUDhrK1Vsc09UQlpmNnBmcVBkMlBrVFZYL0RBbGJMa2RFNm1r?=
 =?utf-8?B?T1RtUjlOV2l1QlpvR2lTL09RSmFrVGtITnFSYXNtS3IyNUpva210WWFlRzYx?=
 =?utf-8?B?K3JZamZLNlpST2h4bHEzRHBiZmNoeG9WdzlBY1NheGx3akR6QXJOSSszV28y?=
 =?utf-8?B?bWp1cTUwTGZjOTZVYVhSM1llVitEdGFaVHFWNjA2Uk9BckMzcXBqNHFkck5W?=
 =?utf-8?B?RUNINGRCY29NWlhSdWNoSDVjNXFGZFpHNFpiYUlhejhrLzRETTJuNGNBM0VU?=
 =?utf-8?B?bUN4dlJuNVhkRk1JYnhvUE9DSnlBRnFuOUlKeGtaZ0tzQ2J2NVlVelJ6cnFZ?=
 =?utf-8?B?R2xLdHdOTVd3c1Q5aUZKVHk1M1dCMUFhV2lTbkJMNWxjZkpINUlFcHREOGgv?=
 =?utf-8?B?SnYvRmZ1WHkyZmZMeTNzeURCVHZlVVV3U29pK0JGYjZIMTBvRk5GbmVQcUhR?=
 =?utf-8?B?UGdTSDBMNU1ZdWRxdyszbGdmNC9FK0d4M25iaW4yWEVSbE5SNnE2V29qTXlT?=
 =?utf-8?B?RUZqS2JPTFhCdnplTlJZYWQxZDNlMVhBUGtUZzRIWFhpa21hcGZ0dldZZ3Z0?=
 =?utf-8?B?eSsxbkkvUUtlNDNuVjFpM1ZQSVBRYzI0YlpsdDdiMWlmSXhtQ3F0Z3NuOFdG?=
 =?utf-8?B?TGNoWnpnMjlJbEw0QmRHZ052R3pHS1lMTDRtamdPaVhBVmtYKy90QVZLZGZs?=
 =?utf-8?B?ZlJJeUZuOUkvanFVS3RJZGZLWXRwWmZKUlZhYnhRbTFuUWZCMkVDS0t2VTV2?=
 =?utf-8?B?ZGNxaFdhZzdYbVZUY1JoeUdWM3pWanJKUTBRb254UWtiazNFYy94YlJwTWJt?=
 =?utf-8?B?dkVjV2FObWtvc1JPM3AwL1BYdTAxdko3aWxQeTRiV1J4clFOZ1kzbEUzVXFI?=
 =?utf-8?B?czR0THladEs3LzNzdUFLcEdmUWpQQklNcHhQdFdCZWIrZThEWFdsNnYvM2dv?=
 =?utf-8?B?WGZmWEUyRHh5YkpSNHp5M3ZOS0QyR0tDWnhzUk84d2hRbVUxT3ZoSE5oaDBo?=
 =?utf-8?B?L29PaFRqeWFuR3VqVCt5a3RIaEpKSzZMd2pRaFpSOFRVN0svZTJFTVFreUYr?=
 =?utf-8?B?U1FEL2VEVDdPcFFGOUxvRTNSNWJyS2Z0NVBTNkovQVBMaS9SdnJNVXRSVCtV?=
 =?utf-8?B?RVhRMjY0WjAwOFFEaXRUc1BIOEJ3c1hOVjdkYlVjTitsQXI0VEpyQlZxUEVh?=
 =?utf-8?B?b2NySGlwRUNQRFljbDYxYlkxNTlTaGpUUklDR2Z6RVhLTkorSWYrb1pSVVZr?=
 =?utf-8?B?L3I0REVaK0xTMzZLeGtycUR0Qm5YbzcrVzVYR3VCWVpxSmJPNHhNNEgrT0tk?=
 =?utf-8?B?cE5wbDNuNTZTM1VIQys2cXF5RGptVGd2MkdUMTRZbXF5cnhaR2pwSmxDaTBM?=
 =?utf-8?B?YVJjOVpxTW1KcE9YeFdyZmdnaW5qbEdSRlJBMlJnQUFBK0d1S2R0YUZ2KzUv?=
 =?utf-8?B?dWVlQ29CYThyRGVUTm51T3F6blV6ZWNodnFWeGJic1hlZEtoRm9CRHR3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8109.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VGhhS0xaU1paZStvWjJkZkMvVEF2R1lnUUxuT2JaV2ZVT3lrb04rbkJHeUVl?=
 =?utf-8?B?SGJhb1hjRFFBQXRPa21YUm84UFByajFFb3BZUFR5MGQrdUVvaVBHTjB1clMw?=
 =?utf-8?B?QjdQejJoQUpJV0JtTlM5VHY0a2JFZjR5Zkw3MWx1Ym5vVGZSTXpNVjg4MzUw?=
 =?utf-8?B?eFV0ZjU4Sm9ad2JjVyt0cnZ0Q1F4bWk0MEhPeUFBVzVFWDl3LzFRT0YzdVR2?=
 =?utf-8?B?Q1loaDJFcEJOUTJ4ZE9oaEdpczBURUU3cXp0cGY2dTdmS3Q5ZjdYWnVlMG1R?=
 =?utf-8?B?UXcxakFud0Z3MEgyQU12SHorMXU0UE5PNVBTMktCbmlPUUt1SkR6Wk54aXh0?=
 =?utf-8?B?K2R3UVAyWWZTdUtJWWNOcnlGaGwzeWJsNnowM3pQRE15L0JBVXJEeWFGSmtD?=
 =?utf-8?B?bVpuSC9xanBPa213OExtOHUwUTV0VHdJUm9YNWdGTU9GVGVlQVlJSXdBUnJO?=
 =?utf-8?B?aE1BM0ZsNFV3WEdjUTRaVTdtOTIzNWhDVVl5aHJPbnBiZVp3eUttL1Nad3NK?=
 =?utf-8?B?eEc0TUtCcSsyd3FOc09RcHpLaHFrWFdJU00wUzB5OVZzRnJ4aE5HQkE1UDFY?=
 =?utf-8?B?L2hzSW8vdGpxK3Zpc2lSQ1ovbmZ6ekp4VGFNb1hSWk91WEp2KzJxbnJSZk0w?=
 =?utf-8?B?M296WFBGTWlDSFpqaVNmcE81eXdJZ24zVjZVQjdKWnFRQ0VrU0MyQmwrOHVB?=
 =?utf-8?B?cVVjUzJjTUMzMFhUUGZGcXZ0T2RiMjFwVDdDYldvM0NHVkd4bFI2czBmL3h1?=
 =?utf-8?B?bU1xNEdFSFc3Q0JMWG44anZvbHpPcTc1a3NGdlFNQkI1OUJNTUxKeTNKOXR0?=
 =?utf-8?B?Znd2bUFGb2RRbFZYSFNRWVNuSHNxQUhoQ1V5dzV5bUh5eUxrRWdMWFZnZERG?=
 =?utf-8?B?blcvMDZxWkcvT01GSmt6SUlabVVoaVJ4TTc2V0R4TDdBZ2VhVGxHZzVXbnYx?=
 =?utf-8?B?dnhLN09oRWJIcTJreWpzbmpPUktGSW5ZNDNvMnZ4dDJwUzBDWjJNaFBOSDEy?=
 =?utf-8?B?cHhacXVYUmVqdFpqWFJZeXJySjlERzJRNEtiZkJUV0hBbW91SnNjcnFGRXpC?=
 =?utf-8?B?TGhYTXBFcnRPSG9UeFVoNkhGV2tORVZjN2ZoekF3NFNNSUdGKzhKWTV1dzVU?=
 =?utf-8?B?YTBQMjNPWStmL2U2dWVJNE5Od3N6U1RHMWRZai93TFEva3JxaU5UQmhIVXNJ?=
 =?utf-8?B?RmFtSTdZZEpMeDRxK3d0VncyYi90aXVhM3NoemVvUU91Zks0Qy8vWGN5bUpp?=
 =?utf-8?B?aTUrTkZYUTZTcXZLN3RkbDZkNytWSEVRK2VXMXpRV1RVdTVhOEd0QlVLK1RK?=
 =?utf-8?B?S3ZzQWI5VURINWhTM3phSFFqV3FkWHZoWUdkWnVqbDRTS20zRTZKcjZCUjFl?=
 =?utf-8?B?UmJVQVo3TmVGSWF3bmNBWjJxMzc5cHBVN3pHRk4wcndXclFPM05kb2g0aDgr?=
 =?utf-8?B?bjI3cXVaVktEY0plcW5PSHk1K1oyRktDVWZSclMvaE1GczF6S01uMTgyKy9W?=
 =?utf-8?B?T3B6eFl0YVhuRzQvRVp4N0pZTmdJRG1QOWFVOFF4bGRENy9EVTc3UHJuVVhU?=
 =?utf-8?B?aG5seGZ3T09GVnF6K1VxTUYwVG5uaDhMZVRhZjFSM3QrYnY2TTFzM24xUytE?=
 =?utf-8?B?SmVwVHpaRjJWaTkrZnpFd2l0Yi9NcEU5Y2ZhME5kclFNa1RZTUJtTGFmNjBs?=
 =?utf-8?B?bW5uSFZuRHdpeWdEdGxjUzVOaFRiQnh2OCtGdHg3aGxuZVV6NDZsanJMYXA2?=
 =?utf-8?B?bG9jcnp1WHEzSU9hMG1TUXpxU3R4eVIxRmRmN1NFUkhsbUZjMFJDVnRxMVZH?=
 =?utf-8?B?OWxWYS9YbnpDL0NMQUE4SmxUWGo1OWpkLzFqWVI2MVFCaUlwSkpPL1VSTG9k?=
 =?utf-8?B?WXN0UGJBaWNBbVlsOFp4dG5PaThOQ0p4NjBYMVhVeGRwdmdzOUZkMEhScUc2?=
 =?utf-8?B?ZStRak0xd2xQeG5Ob1VYUmFhNGpmVjBWa1lxYkJOWFByMDVCbGZIdThVWkQ1?=
 =?utf-8?B?U3JpemxsVFloalpEbi94WlRyRlpDQkJKSFhqaDlFNkV3YVBWZ2hQbWt4TjdK?=
 =?utf-8?B?Y0xHb1lPRnI4UVFmb2UySy9ZL2tVek8ydVV0MUpZbWkyVVR3elBqbmVJTkZX?=
 =?utf-8?Q?zWlieLePNAtMWStd6XWr8H2mP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1668a55c-a9ce-40bd-9e84-08dc65b5e51b
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2024 05:58:28.9671
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z7rfjb3+0N0fPgeAKCFjVTu+Dx4c2v8PyO3ExIb1et7qacmJiHaDn7vGOh2NjA2Q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4296



On 4/25/24 17:22, Sean Anderson wrote:
> On 4/24/24 02:22, Michal Simek wrote:
>> Hi Sean,
>>
>> On 4/24/24 01:04, Sean Anderson wrote:
>>> Hi Michal,
>>>
>>> I was looking to upstream one of our ZynqMP boards, and I ran into an
>>> issue with the pinmuxing. We use almost all of the I/Os, so everything
>>> is tightly packed into the MIO. For example, we have the QSPI on MIO0 to
>>> MIO5, and MIO6 to MIO11 are used for SPI1. However, I cannot select this
>>> configuration using the pinmux driver. I am using the following
>>> configuration:
>>>
>>> pinctrl_qspi_default: qspi-default {
>>>      mux {
>>>          groups = "qspi0_0_grp";
>>>          function = "qspi0";
>>>      };
>>>
>>>      mux-cs {
>>>          groups = "qspi_ss_0_grp";
>>>          function = "qspi_ss";
>>>      };
>>> };
>>>
>>> pinctrl_spi1_default: spi1-default {
>>>      mux {
>>>          groups = "spi1_0_grp";
>>>          function = "spi1";
>>>      };
>>>
>>>      mux-cs {
>>>          groups = "spi1_ss_0_grp", "spi1_ss_1_grp";
>>>          function = "spi1_ss";
>>>      };
>>> };
>>>
>>> But I get the following errors on boot:
>>>
>>> [    4.261739] zynqmp-pinctrl firmware:zynqmp-firmware:pinctrl: pin MIO8 already requested by ff050000.spi; cannot claim for ff0f0000.spi
>>> [    4.274506] zynqmp-pinctrl firmware:zynqmp-firmware:pinctrl: error -EINVAL: pin-8 (ff0f0000.spi)
>>> [    4.283789] zynqmp-pinctrl firmware:zynqmp-firmware:pinctrl: error -EINVAL: could not request pin 8 (MIO8) from group qspi0_0_grp  on device zynqmp_pinctrl
>>>
>>> This is because the qspi0_0_grp and spi1_0_grp groups overlap:
>>>
>>> group: qspi0_0_grp
>>> pin 0 (MIO0)
>>> pin 1 (MIO1)
>>> pin 2 (MIO2)
>>> pin 3 (MIO3)
>>> pin 4 (MIO4)
>>> pin 8 (MIO8)
>>> pin 9 (MIO9)
>>> pin 10 (MIO10)
>>> pin 11 (MIO11)
>>> pin 12 (MIO12)
>>>
>>> group: qspi_ss_0_grp
>>> pin 5 (MIO5)
>>> pin 7 (MIO7)
>>>
>>> group: qspi_fbclk_0_grp
>>> pin 6 (MIO6)
>>>
>>> group: spi1_0_grp
>>> pin 6 (MIO6)
>>> pin 10 (MIO10)
>>> pin 11 (MIO11)
>>>
>>> group: spi1_ss_0_grp
>>> pin 9 (MIO9)
>>>
>>> group: spi1_ss_1_grp
>>> pin 8 (MIO8)
>>>
>>> group: spi1_ss_2_grp
>>> pin 7 (MIO7)
>>>
>>> However, we are not using the "upper" pins of the QSPI device.
>>> Therefore, these pins should not be included in the qspi0_0_grp. This
>>> stems from the driver placing all possible pins into a function's group,
>>> even though each pin can be muxed individially and it is not necessary
>>> to mux all pins for full functionality.
>>
>> Correct. These configurations were not consider at that time when code
>> was written. The same issue is there if you want to combine pins from
>> different groups. IIRC uart rx via MIOX and tx not from MIOX+1.
>>
>>>
>>> I think it would be better to have a single group for each pin:
>>>
>>> pinctrl_qspi_default: qspi-default {
>>>      mux {
>>>          groups = "mio0", "mio1", "mio2", "mio3", "mio4";
>>>          function = "qspi0";
>>>      };
>>>
>>>      mux-cs {
>>>          groups = "mio5";
>>>          function = "qspi_ss";
>>>      };
>>> };
>>>
>>> pinctrl_spi1_default: spi1-default {
>>>      mux {
>>>          groups = "mio6", "mio10", "mio11";
>>>          function = "spi1";
>>>      };
>>>
>>>      mux-cs {
>>>          groups = "mio8", "mio9";
>>>          function = "spi1_ss";
>>>      };
>>> };
>>>
>>> This allows the full functionality of this chip to be configured. Does
>>> that sound good? I can send a patch to this effect if you agree.
>>
>> The only question is if this can be done without changing TF-A code
>> because we are running out of space in OCM for it.
> 
> I think this can be done just in the Linux driver. This would also be
> convenient because then it will work regardless of the firmware.

Fine by me.


>> Just a generic question to your problem. It doesn't sound like a
>> dynamic case. You have static assignment for pins which likely won't
>> change over lifecycle. QSPI can be even boot device. Do you really
>> need to describe pins via DT that it is not enough to have them
>> configured via psu_init directly?
>>
>> Driver has been developed for i2c bus recovery via gpio which was the
>> main application. Right now Kria SOM is using it for carrier card pins
>> configuration.  And Kria is pretty much only platform where this is
>> regularly tested.
> 
> This is just following the example of the ZCU102. But you're right,
> these pin configurations are static (excepting I2C).

If this is going to product I would try to avoid communication as much as 
possible because in static case it is not needed and just adding overhead to 
your boot up time. But if you want to still do it I have no problem with it.

Thanks,
Michal


