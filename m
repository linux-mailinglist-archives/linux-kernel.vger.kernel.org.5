Return-Path: <linux-kernel+bounces-90545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E511D8700F3
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 13:08:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D13C282A29
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 12:08:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BA9B3BB3F;
	Mon,  4 Mar 2024 12:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="aysvxr+D"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05olkn2070.outbound.protection.outlook.com [40.92.90.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F733B296;
	Mon,  4 Mar 2024 12:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.90.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709554115; cv=fail; b=meHrqDzjDq5eF8q11LNqz7ICWVZkBCfrlBL//RbY7ljJv1m/2Vj3VwLxvIUmK7Mnk4tEpY3rQ8/vo/HRi4WTKItmg88DIKUqKTyAK23XNs2GIGrk2zRxT5Gppo3dvdlTqg4S1909Ozb9IpruumDd+gtaJkMLgZ1OkjLgdgcZyv8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709554115; c=relaxed/simple;
	bh=sPpMHZi7dschW/YoNRabwqj25iFF9ki10/vkuSG76JI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YDU1mwLTNzuZXOK+AO5hBGvk1+N7gXFkzRN5pZgdtdBZnC0gYojh8T3O9j8X3Tp9UYTeYu/g+q02BLoD0UnnqDoN7MwDWHvqn2Rs47DdMk6DUrEwdy8szdjeMJyHCzvc5DIAbsrnfEWrPC26HbaSk4NraKuSrKFH7NhWwKDWCE0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=aysvxr+D; arc=fail smtp.client-ip=40.92.90.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nr3E971/7//B67YpiZ1oE2xTx+7ElRCMCUFtmk4059ytbzJx56yBOLG/AQLfyPk2Jh3Mx2vIKaAibUmX/dknxLAKM/Nqhkp4qpZiiozrzk1wglQctkPDuNwlwvbtW7hUZKUuiAW0tImhDzXhJ6ZFxSxH2hvNMMw6XS5iltaSBDhzxVBwveWDf7q4X1BGpefLbjEDx1ATzND6m1cREEuvN9xrk8IjqBTS0hUbXGRLvSmJBwN/weaW4c3OR61zQbbFKKuhzrOMIXHb1m17mkImVmhDC2pSc7di5i7ksSoTb+gtrDNSBginfKP64jBvb3vcfSRGwUPipQdROYmKG/nvxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aEoNqMfhLIMjWS60JemBKHbtSHZkTm251ieZoUgn1hc=;
 b=bgCxu1bUdDqsYIqszZvbwrnLjHiaJJE0HMx4V3OB4kn9C60LBE+NoXCE2zRe9ZyJ+0k++fiA1f2kqemwgcj5vLLRCl8Lcxcbg5+nc+3TIRCg48gBAHQ3jpwfF+AfjM2UAkfoDrpviPDCjJD1nZ0kqX88prb4s5BbDV6Ll7ZbWzGh4UAExb0Hs333BylLe44mxwHmJbqKuIv/7rwKqlUdAUCBBS1M8pMkr39hirQUxMOqfbuBWOY1P07zumMt9fXg5SymTZM3itL9YGt4rJ3T/+jp303VPEEJopTGK9ieJk6u8KrWxA0FPbqlai9hGIwvP+myDATzsXrL+G4FXay1XA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aEoNqMfhLIMjWS60JemBKHbtSHZkTm251ieZoUgn1hc=;
 b=aysvxr+DsW0r8YXKl1dllbpA8EpM7PuIdzv/J5CnT4gAwLrneFjh1N7j1Z8VUdxCEoB4VydVYGKsESqX9kgzFAsA1J+TrHSXNQ0fOS8+Yf3OBxFoeKoCCdQzHEeJn5ArqYMJlHJgDCKwuKSgZOMORMMhijQu72mLg9+JzAnLvmPEKMs3qHKx/nKCavCeYWtsQYlVdqdF+6bOe9Pw17Q2BQzuUzY239qwUN/8b34J20PMLBqyOxIn6H81QxWR5IMIzXtHjDXNYDlaOZvuUodg9f6UQxanfJDjgxOaegqW+5voCYGu93VuPFkQLyvDmWC+oKVqGdyz5qPrgnU+4rNwiA==
Received: from AM6PR03MB5848.eurprd03.prod.outlook.com (2603:10a6:20b:e4::10)
 by AS2PR03MB8905.eurprd03.prod.outlook.com (2603:10a6:20b:5e5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.32; Mon, 4 Mar
 2024 12:08:27 +0000
Received: from AM6PR03MB5848.eurprd03.prod.outlook.com
 ([fe80::58d5:77b7:b985:3a18]) by AM6PR03MB5848.eurprd03.prod.outlook.com
 ([fe80::58d5:77b7:b985:3a18%7]) with mapi id 15.20.7339.035; Mon, 4 Mar 2024
 12:08:27 +0000
Message-ID:
 <AM6PR03MB5848FE9567FCB44911E8E4D599232@AM6PR03MB5848.eurprd03.prod.outlook.com>
Date: Mon, 4 Mar 2024 20:08:28 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] inet: Add getsockopt support for IP_ROUTER_ALERT and
 IPV6_ROUTER_ALERT
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <AM6PR03MB5848BD89913195FF68DC625599232@AM6PR03MB5848.eurprd03.prod.outlook.com>
 <CANn89iKzGS39jLrRszBLh6BMyYykX-d_n3egdDU77z_fcXbiXQ@mail.gmail.com>
From: Juntong Deng <juntong.deng@outlook.com>
In-Reply-To: <CANn89iKzGS39jLrRszBLh6BMyYykX-d_n3egdDU77z_fcXbiXQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TMN: [Qgai2JlTW25CZRL9duFv7m3qn+YDLvop]
X-ClientProxiedBy: LO6P123CA0024.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:313::16) To AM6PR03MB5848.eurprd03.prod.outlook.com
 (2603:10a6:20b:e4::10)
X-Microsoft-Original-Message-ID:
 <c17bc801-d7c7-414f-9626-8fbfa046addb@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR03MB5848:EE_|AS2PR03MB8905:EE_
X-MS-Office365-Filtering-Correlation-Id: b8668c34-2473-4ed8-c61c-08dc3c43cc9c
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	GUDJBW7G7xtM8evbPAVT2R5gkcQmKsx1ODdbS36HDMET5bTtDnOnJ44aA8HGAjCGeWF7xWmAW5tntuFKV4R+w4OmkeYLxL32yQpn+hLNeakCGOFyFtCbBG78udllaJ/iCAs0NQ+KVbaqEDKoOkkP4kokuL2pKo6KaGQqmRjMVBC/KP56aJ0vij0IwZu8tdhOrhJbDhcfBIx9pKEQIPNjqc9MYAUmLQQ6eOOlb6fxtyXbRM2Rm3swTuTCpiHroobdbeYyrrF26unl4kpwh4HJ43LVSosNhPomCsxSog8XfpeIR5d3sHLSciVAsA6ehClQ3acZc5zxHlJzXgOvQE/DcvowCEurhoTWNljDnRCjpb7gSJgzHwZiJqR152ANxrFPy0KiGGOIocWz6IpdkrBRYH0qvemws2HTr706DVtEZH3wBPSq8rKRt7pyxheqAVi5qSXRsi+C33XswrdVjiaC+4CAM34x9SJwwcdGHgnOtNYatYKwpDbYnkYdIugqGHT94OsUAjfyyNdPor82hM2JHgIuECaQ2wIKN/lgT7WBzoZn4aEIwxH6ZHlzn9Q00dfJ
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RlZMRVdqdk1GbnREUndZUGpZc1VYNW5BL0tTc3JuSndjcXN5RDRTMFF6aDU4?=
 =?utf-8?B?Sm9qTm52RVpWUlk4czU0Z3NkdzFSQzNwZ0Vua3NOTEtiUWdLRWs3VVdOOEpX?=
 =?utf-8?B?UkFNVG5hdk1BalUxaW9rampDa0ZkdmxZeEJWa2tGL1l3U1V3dVJ0Y2VyZWxY?=
 =?utf-8?B?bUVuMkVRMDdqTzdMNGJTMVNJNHFoRTY5T1VwYXhMcFBJZERpMEYzU055SDBt?=
 =?utf-8?B?enhLbC95ZUM5OHZBNU5EL2JKYnNXYmhzdms1S2lpK05xSml4MmZoR0luMndn?=
 =?utf-8?B?UDlCNGVZMFFmcnBnZGU2ZDR0T1djeUpNOXZUOGcrVytjOHlodkVNUmFHY2oy?=
 =?utf-8?B?SW00UFdtQlJsV1pTNGJ5R0p5UFZBOU5VZmpadld6ekJWc09WOFFKODJ0bjh1?=
 =?utf-8?B?cGQ1OXdKOFNKWmE1QmJvd0h2OTdPc0ZnVW02WmwwZ2JuZnJ3T2F1QisyT0cv?=
 =?utf-8?B?UGR5NjdTd1RNZGRPUjQwNnNCZnJvV0p5emhmcVVXbThuNE93Qys3UkhuaTBI?=
 =?utf-8?B?Sjkwcm1XZ3hRZWRxN3pZNE1TTGFvSnkxWUVWaUhSTGlQdUZMTkZReThRbnFs?=
 =?utf-8?B?UWxqR2s1eVpVQzhSRG1CZ3MyaGJ5Nkw2YWxPeVEvTml4elh4ZUprTklVY2dk?=
 =?utf-8?B?MEkwaHozNzdpdTZDQVNsc2M1K0dpOUNoelN0dHVTTnh3MmZsNEpGWUIwMlNr?=
 =?utf-8?B?M0k5all5bU95KytMVVl0VFArQ0RzaDc3VnA4dHlVVElBTVVoZVprRXM3UktH?=
 =?utf-8?B?MzFMU0hITkgvZWEyNS8zVGFaZXBFdjU4Q28xUEV1UlhKdTNBMHc2SHhDNHdj?=
 =?utf-8?B?VnZNbWZOamVEU0FRazUyZDV1R0t1eENiMmtvQmxsMDZxYkpHNklMUmpDN1BG?=
 =?utf-8?B?NjRrU3lwWXdjZzdWd093UHQzRGZET1hnYjY2WCtHUEowZk9Tb3FGYk9Nd3lO?=
 =?utf-8?B?SkNKWWtrM1JGRDRIYXgrWGNUY3JGN25nUFNKM2ZvbXNpNjFrVzhkZTd1OERj?=
 =?utf-8?B?RXFsV2Vvd2lGR2dvZmpYakZmWlgwa1c2TXZsVUo2TWloTG5HS0N1Qyt1U21N?=
 =?utf-8?B?UGxoR1FTdU1GR2tkb24zTkNGWE1zTWlOUktEdHZTSXZOcGxSL0VyRUhSS3Fo?=
 =?utf-8?B?VC9KRHQvK3pwMGd4c1pEYUdHcWxRYytWaHhqeEdMY004MUNuWHl0U2RoL0p0?=
 =?utf-8?B?eE9hSUFPZjhiUW1xRS9qbUpJbjB5WTFiL0xHS2Z4SnBBeDJyNnJXTWJsemgx?=
 =?utf-8?B?RWVqU0tuTGhUV2FJZmFCblJrQzNocnJsN1ZieFdTMFVmcFJhZHYrL2tMSEIv?=
 =?utf-8?B?eVpiTW9lSkxlQ0tyUFRkbVBZZ2hvdndZYURGb3RaU1lOeWdqVW9PeFJmVk1J?=
 =?utf-8?B?NjlxSHByVVp4czdaUEp3UEx0MlVDM0JnQmFmNW5IY2xUcUI0VEFSbEhUZklv?=
 =?utf-8?B?dE81L0VmUUtuTGE2YkdlbTdtUG9HM3pWUmhERmhKRlJYMTJMTU00VllQM1Uz?=
 =?utf-8?B?MGVsQ29tVkJxL1hoRUs4aldZbGdUeUVqZWFoSE9YRlBQb2hxUXBVblJ0TndW?=
 =?utf-8?B?R0sxRjV0Z1pvQUVDYzBhdCtYczR4MHJNMzMva0hBQ1dmOU5CTktHN3NXVmJ0?=
 =?utf-8?B?WUUvUFg1b3djNnl6WWFSdVQ3cVZEWGhOUmdET2VWMXBuNExsczE3MWdvU000?=
 =?utf-8?Q?Khenu9ralXqGeHAY9vqz?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8668c34-2473-4ed8-c61c-08dc3c43cc9c
X-MS-Exchange-CrossTenant-AuthSource: AM6PR03MB5848.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2024 12:08:27.5044
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR03MB8905

On 2024/3/4 19:49, Eric Dumazet wrote:
> On Mon, Mar 4, 2024 at 12:33 PM Juntong Deng <juntong.deng@outlook.com> wrote:
>>
>> Currently getsockopt does not support IP_ROUTER_ALERT and
>> IPV6_ROUTER_ALERT, and we are unable to get the values of these two
>> socket options through getsockopt.
>>
>> This patch adds getsockopt support for IP_ROUTER_ALERT and
>> IPV6_ROUTER_ALERT.
>>
>> Signed-off-by: Juntong Deng <juntong.deng@outlook.com>
>>
> 
> This looks good to me, thanks, assuming this is net-next material.
> 
> Make sure next time to include the target tree (net or net-next)
> 
> Reviewed-by: Eric Dumazet <edumazet@google.com>

Hi Eric Dumazet,

Thanks for the review.

Yes, I made this patch based on net-next.

Sorry for the oversight, I will add the target tree next time.

