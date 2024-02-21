Return-Path: <linux-kernel+bounces-75153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FB9185E3E3
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 18:00:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BB8D1C2305D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 17:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18344839F6;
	Wed, 21 Feb 2024 17:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Zt/OumNe"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2070.outbound.protection.outlook.com [40.107.20.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D006F4D9FD
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 17:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708534820; cv=fail; b=WwTafiROXtWYqyfZQlcMaUguuqStHsV06MMOTsO1DiHZBTWDQTIvC1omDQbfiSzYk457cpqxBook2z2NS+Rub9wcyy313mMHv9Rj/pr5P0P913ezT0FSMjwEaluVE8C6jW0o7XFWHm5Uf89k++awvlmibeCkS5JnfvmdfUoUSbc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708534820; c=relaxed/simple;
	bh=cl5rK41o7LZ6koXEijH0a2nfegJcsHo39g/raPiCTQU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qG9Iw5x8DWY+6Lp2gF8jU+6FrcaF073vjNES3WZxzmz7rtso/yuEXorABNltH5bkq5F6gC/dr1gzusB27nUWs0BszpwtRjzTWQYHlkFsg5I5poecEYTqlDR6y1o7XBRI+AEyjpkJkWNwYxd6xrVtwXFuhI63I3GVpNx+ewwojmI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=Zt/OumNe; arc=fail smtp.client-ip=40.107.20.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DCnzKi4UOt6xc7+Vc2uNxzqA95KJedaWesJLixuvJU5MSz4n0emPHegXze8epk0SHLl7/C8x5cDaP/W7GBSgp/Xfyuq/jN1ivsgXuf5nnJVVl4iKFOcHOkz3+v2IbrOltS6J6X4Z6+aZKSrihI1yIj6gI2P+byP0q1AtSLBMfWCHOIJGDJPoGrjtMlGuxnIViI457GfLHvs4sANbFpFPZsRD9JlF00SlaEchxSmzasK8vpdxKLIgwP3b5hrnUaTZ596VIGyQR2CbPXctYvModTuV4pOaTvJYQCrNSvPLMdvt/MeSm9TLEs4i9EEEhC6Sw6EOuwwx/sfXkwP4ajRFqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hstYrZB4eoaxK+5vYbT9kgx1ayHRzaf4aQ170ENoKvY=;
 b=jMEdHRE4m5enyjcl1Mn/HFQKjdCccRhoPqOP9d9uOFD88yDbveRMPF07hlyczZh7rsrZO6PmUzsoKA9WB91CaiQf3IxHf8dnuUBMYorg/8VcVyzlW+/epFGiyT7phGKpGPqgeNHQtRlGPypr5BUtWTBfARYg68qxrKdA1IKMH2paVJ1sQLP0Tj+dNVP0S05X+tK9Ly1oXw7h/GKJPjvPd8GdsPKZNpJfpDa7h+2bAWeRcgWyLsiFcJRi4IJgkqf3yOP8SJK4B/KnfwzpRUxOYsmwhCnCfJ/aj71a7Zqk4w4RFgMgXo1lCxU4tDnFmh/OfaXg0cA/te4bdZF0tTXaIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hstYrZB4eoaxK+5vYbT9kgx1ayHRzaf4aQ170ENoKvY=;
 b=Zt/OumNeHtK2TvGuue9xStsOfxLPp7z2SsxYwcu9SFC6wWAZNtPBMoX7k3InyPihMD4zTYQaKIj01nid+wAFMioAKwXD1iIYDuFqsqzGsTm7+F1Pw1RQejB/8JDNAZ5zz+UFgimWLrXq0oqbUkjcKPXKRkyy3w0CT0Ym29E4qXc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU2PR04MB8582.eurprd04.prod.outlook.com (2603:10a6:10:2d9::24)
 by AS5PR04MB9893.eurprd04.prod.outlook.com (2603:10a6:20b:653::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.22; Wed, 21 Feb
 2024 17:00:14 +0000
Received: from DU2PR04MB8582.eurprd04.prod.outlook.com
 ([fe80::195c:9861:96a1:56ed]) by DU2PR04MB8582.eurprd04.prod.outlook.com
 ([fe80::195c:9861:96a1:56ed%4]) with mapi id 15.20.7292.036; Wed, 21 Feb 2024
 17:00:14 +0000
Message-ID: <bcb79af4-56d9-4204-9503-cff996f1ba41@oss.nxp.com>
Date: Wed, 21 Feb 2024 19:00:10 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] MAINTAINERS: Add maintainer for NXP S32G boards
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
 Chester Lin <chester62515@gmail.com>, krzysztof.kozlowski+dt@linaro.org,
 =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
 Matthias Brugger <mbrugger@suse.com>, robh+dt@kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 soc@kernel.org, NXP S32 Linux Team <s32@nxp.com>,
 Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>
References: <20240221120123.1118552-1-ghennadi.procopciuc@oss.nxp.com>
 <20240221120123.1118552-2-ghennadi.procopciuc@oss.nxp.com>
 <f4465547-1fb1-4578-9a69-7d399e7661b3@linaro.org>
 <403e32c2-910e-4745-9ebe-fbf377c3fde8@linaro.org>
 <ad856766-8903-46c0-93af-24e101ad51dc@oss.nxp.com>
 <e538ded0-bd3a-4ca4-b2bd-8d20d8c8c3fe@linaro.org>
From: Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>
In-Reply-To: <e538ded0-bd3a-4ca4-b2bd-8d20d8c8c3fe@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR06CA0214.eurprd06.prod.outlook.com
 (2603:10a6:802:2c::35) To DU2PR04MB8582.eurprd04.prod.outlook.com
 (2603:10a6:10:2d9::24)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8582:EE_|AS5PR04MB9893:EE_
X-MS-Office365-Filtering-Correlation-Id: 24af8a84-6b23-4ab8-15a3-08dc32fe924d
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	K7uMaj4M4B0xNdBHiu15D2AuWX1DJyc8Amr5ubydIYqaAk/ygH2H6XWD8q+DulBRIr8Zlcr+knr7K4E2fORZqQbi9uvqmQdUXNwW4nlrse4N7ftf1KiOv0u0ECp2xjUWvQDLgnY6xgyazkvZmmkl+4wOo8efxjK4tFaLDlSzCGGz/FQBI3bXOcpz//yVyrru55mc1fZLfigII6lrnaEDtCNNN+OsA/BZzhstuqdJf55pq7J8D3ij3Nyq/JNZhCx0BfflyJIP5fOx51HCVveyXrXSi/wvcxWx4XdZupHsmF87+But4UDPxB6LutxkQpCYVzNqcTPktcmqyOwTjttOMXiULXqThuqFpatGb4TOUEAy2hp7gV3AJsLmaorOzMEAE65E1GNcAllmDHYvI23DQxP2QDMyX0mYsbpIg+eFG2NqLE19xUTBjddq/4n/I7D/3JxKw7N+oCdL7a1UALzgjwDcGKmxHm98rgsPWmg73DsoRK6nGoi6M3SIlZYQkYisbKjXXSBdOHR+x8Hge8anWw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8582.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bk1kOTUrVmUvOVZTVExtc0lXaXlVdzBKK295Qkt5aG1PUkpiTnRBZEthcWhy?=
 =?utf-8?B?QlRVMkFBeGlHb0hCUDFOY3hrd2FQZ2JaTGFtMlNjV2hHelNUOXFMYkl2aXBK?=
 =?utf-8?B?WnJBUExGN1lBdEg5ZGFNNVpyZlk5aXBtVW80bFBMU3ZLbUZ2ODhaV29VNWQx?=
 =?utf-8?B?UUpJUzNIU0x5bFY3UlZMWlo2UVlLc0Vrc205VTVVRHJpMGRDeGhxWlZhWlBa?=
 =?utf-8?B?clBqUXVaUmFXa1FZMHQxc09VQzdjY2hpb1h3NEVyS0hlSzd1NzFVYmZOTUh1?=
 =?utf-8?B?aFM5Z2lLenNtUHRkSGx5QXllMFIwQUtCVFc5NlFFMjh0WVYxZE83VExJOTVJ?=
 =?utf-8?B?elVhZWx1eEtTOHE3Z01TQUVGeGkzYUc5OGVsM2pXK3VmcE5LaW1IVW1hdzVr?=
 =?utf-8?B?bENKdG5DamlNWDJ0R3JHb0Nqa0RwTXRPMUxPVm1uV2JJMks0MmJZcXVsTmRR?=
 =?utf-8?B?U2RQeWVWdFNDaHI0enV1emphS3JmUUI4WkxZMHJKekovQnk1ZWdKWU9TMFBY?=
 =?utf-8?B?YjN1TUJPbGJmRFZXcXkrZUQ5UE1MaEs2YXA5TVc0R2F6OXQ5TUZDQUtxbjQv?=
 =?utf-8?B?RmV2WGVlUVlBanZUalRiU3J3R1JUcjkwN0NVcFkrRTR2aXZ6UXRRWllXelVk?=
 =?utf-8?B?NlpEcG9QK0prcE93MXBuVnhPNnE3N3BkUkxKN1NGb0YxR045ZndqNm56Z3hV?=
 =?utf-8?B?K2RENDlvZGxxOGkzVVliVWFWdmZXb05udDVsRTVjdzRMWjE0cWk1ajlhZnFR?=
 =?utf-8?B?a1pEQWdOb1BEaVRBRkRQSEsyeTU2SHRMWVo2RVB2ajkvQXlnSVBCYUhMbVlS?=
 =?utf-8?B?cWpqMk1jcWJ4dUZqOHQ4T2cwdlFoNHRVNEJ5NzBFdHZyREV4cW9ZUHJmd29H?=
 =?utf-8?B?V0NhVVB0MHFYYnVNdkY2aUFHNkdrQ3dWeEdYcy9EdjlwVTEvb3hXMmxhUFBt?=
 =?utf-8?B?NlFXU3VlamVTZkxLZ3AxQkpZd0hMTThkYmtxWHQ3VjA4TnVhSTFYcS82b2Ra?=
 =?utf-8?B?NWlrc213TUs5YWl3dnBCQmMybFJCQ1FQZmJPZFJvUUdKL2pDRm9zYVFSWDd2?=
 =?utf-8?B?T2RCS2V3TXVyMnI2MXJXSithWTZQMFdJRmhKN1lTVTdseHVXcUcwUjdrdWRp?=
 =?utf-8?B?TUUvR3ptVy9pYjBpa3hXcGtwVzJKWXJSOFM5MWkyQWVJVHI4SzRKRFNzeG5u?=
 =?utf-8?B?SSs3Z2g3ZmlYUll6MzdkWXk3YUNNejdTSWI2c3pLU1NPZXFWNDFOZThCeW9r?=
 =?utf-8?B?enJzY2NZZjdSV0I5WGk0akRWcXZxWFJ6NW9odHdzSXY3S05WMXBudnVzRE1X?=
 =?utf-8?B?RWxsZytuMUFlTDh6KzNqcDBSNXpxNXEvWmYxMnVmTjdvWjFrcU5EWWtGbUtH?=
 =?utf-8?B?N1FERU1QUXZ5MC92T0xIYitRTEhOYzhnQTFXRTVKeWFEUjNqR05qUnlUUjBy?=
 =?utf-8?B?K2paVklSenlJcDZPS1pxN1pZejkzbW1Cc1REanltd1NsZDgrU1lZQ3JKWTFI?=
 =?utf-8?B?b0Q2N00yT0VDa3cxbW1Yay9FdUhUb1ZWQm5LNm8xdHJWYlIycENkTzFOa1Jh?=
 =?utf-8?B?dnBOZVBKWXZxVU1tYXRGbFhYSTgwUHUvS0ErNGdoT0J3SENqL3RsTmtkQ2dR?=
 =?utf-8?B?OTRaWUZmcEhMQW5YYUVPakVEdTBmc1hpRUY2WTVjSkRYQTBqdGI4ektVWmgw?=
 =?utf-8?B?di9lTjlTcWE0OGlHQ1l1bGJVSkZ2a3BOWjM0VXAwZFB4ZWNUbHFQdmRLUjdR?=
 =?utf-8?B?amRIc0t1aUJQb2R5Rzh0Z2FXaExiNTgwTE93OWhyMGNuL3g5MHQ5MjgwaTRV?=
 =?utf-8?B?bGJFSSs4S0puOGpMdFhneTREL1lYN1hSYzh3UWxscnNsZUNSU2tIYTNoejNK?=
 =?utf-8?B?enNnSjhsdTR6a2E1bkprSjBSQnhGdDVvRFh3ODNiMzBZbXZ6a3JybUtSeDVM?=
 =?utf-8?B?bnFGdWNvcHdIZjQ4KzFrZWtJOFNJVm5iRWR2Z2d5MGwxazF6Tm03YURoM3By?=
 =?utf-8?B?eFgvQk5ONDNSMVFEQTZyRFpkZGEvZU84VVdHQlVIZ2hDbE9ZbnNNQURKdjZK?=
 =?utf-8?B?K0xLODl3eCtucnFmNDVnRkpEZEUyQzRaZU5yVEF0eXdRZGJaVDhjYlJXOThX?=
 =?utf-8?B?NnVEM1hrSGFqR0QyQk53TXIzRjR4dWxHVUpjQmg3NFF4QnkwUjJoUk1BNEVs?=
 =?utf-8?B?WlE9PQ==?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24af8a84-6b23-4ab8-15a3-08dc32fe924d
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8582.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2024 17:00:14.0418
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tHK81gfsstCIubiIjOjLpemoxv1CuqYpnWymSmN3YTGkqt9caX8RYZUSRlMSDRtCsf+FvsL+Lna7RMpbMIKCUrCFV2d4H7euP/NbptvW/s0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9893

On 2/21/24 17:43, Krzysztof Kozlowski wrote:
> On 21/02/2024 16:19, Ghennadi Procopciuc wrote:
>> On 2/21/24 16:45, Krzysztof Kozlowski wrote:
>>> On 21/02/2024 15:42, Krzysztof Kozlowski wrote:
>>>> On 21/02/2024 13:01, Ghennadi Procopciuc wrote:
>>>>> From: Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>
>>>>>
>>>>> Add myself as a maintainer of the NXP S32G DT files.
>>>>
>>>> No need for cover letters for single patches. OTOH, this commit msg is
>>>> empty...
>> Thank you, I can correct that.
>>
>>>> Plus your patch looks corrupted (wrong encoding): F??rber
>>
>> Indeed, it is due to 'Content-Type: text/plain; charset="us-ascii"'.
>> I can fix this as part of v2.
>>
>>>> BTW, did you contribute anything to the upstream Linux kernel? Do you
>>>> know the process? Downstream does not really matter.
>>>
>>> I found the answer:
>>>
>>> From: Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>
>>> Signed-off-by: Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>
>>>
>>> Does not look like. Please get some upstream work experience first.
>>>
>>> https://lore.kernel.org/all/?q=f%3Aghennadi.procopciuc%40oss.nxp.com
>>
>> Although I am new to upstream communities and may make mistakes, I am
>> eager to learn and improve.
>>
>> After leaving SuSe[0], the current maintainer of the NXP S32G DT files
>> became inactive[1]. As a result, this area is not currently being
>> maintained. This is the actual reason why I attempted to add myself as a
>> maintainer of that area. Although I acknowledge that I may not have
>> enough experience to become a maintainer, I am concerned that the NXP
>> S32G DT patch submission may be blocked for everyone due to the current
>> situation.
> 
> I would be just happy to see first actual contributions or any sort of
> activity, like reviewing, before taking over something.
> 
> You do not need to become maintainer to provide reviews. By reviewing
> patches you already reduce burden/work from the maintainers.
> 
> Best regards,
> Krzysztof
> 

I fully understand and agree with your perspective on this matter and
accept the fact that I will not be a maintainer as initially intended.
Furthermore, I am very willing to participate in any reviews related to
S32G SoCs.

Patches, including those I have created ([0], [1]), will likely be
submitted for this area. This is because each enabled driver for S32G
SoCs is expected to have at least one node in the device tree. These
patches will undergo review and receive feedback. However, the upstream
process will come to a halt at this point since there are no maintainers
to apply and integrate them. 

I do not know how this situation should be handled, given my lack of
experience in upstreaming maintenance. The documentation for the Linux
kernel is insufficient in providing guidance [2] on how to handle
inactive maintainers and it is unclear who should take over their
responsibilities. This is likely not the first time this has happened in
the kernel's history.

Could you please guide me on how these patches should be integrated into
a maintainer's  tree and by whom?

[0]
https://lore.kernel.org/all/94742ebd-bc3a-4726-9ba7-5954203e4da1@suse.com/
[1]
https://lore.kernel.org/all/372ed255-85b7-4f18-a28e-82e18171f7e3@suse.com/
[2]
https://docs.kernel.org/maintainer/feature-and-driver-maintainers.html#non-compliance

Best regards,
Ghennadi


