Return-Path: <linux-kernel+bounces-100739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46E2A879C8D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 21:06:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 127531C219FD
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 20:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAD02142657;
	Tue, 12 Mar 2024 20:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="uxFHGpaU"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2057.outbound.protection.outlook.com [40.107.244.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09C25142649
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 20:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710273972; cv=fail; b=UllbuJIaW+rLu9Y65uItZnXECDQHRapm7vS6XqjMxkb3bPWidLqU0LMsQ0rQClt/r+c/vjLjO42h1p1moF3etKyNMVw4LjJHjpP3jgyqsv2RBmelz2dYgw6cUKyGsb+Mb9VPVdlUAqG+RMBmKHem2ReYSYOO5HTxm/2rlNUxlmU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710273972; c=relaxed/simple;
	bh=iJPRAAQ9zVcohekKnijHD4eqZ3LMsYWng+qhITj7NOs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AeMN87R5a1V/x+7a5Ylg4xgAjM1uB7rC5LKgWWKLft9+8YxufB4nmq34HcmSoTX1iOve1a3We7+DH9wqRVZR1X+U67Je3qC//ZIOKqhWXafU93ilHnwpmERCwep4Nl7Ni0r7IKnOh5bpcFNxTnk9YpCq6ZdFAy0aKUgsAftGyZA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=uxFHGpaU; arc=fail smtp.client-ip=40.107.244.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mp4oF0YT7hdpvXTrerizCzoME+xXXAM7mC8mz0+bVHzr5O9bethEWjs0ks0IW++jDvPEzG7DROgqTfZ7c9Nk8tKDCcT7E1kKneD/MfmN4kvJOeKVsTKXc7/XxefMR9R8G+jc5oD1ceOeutKdG6aezbvRF62Rua23r/AdnV1zGdlNws6jHfZJisDMel8ZpAIcma+aMS4laydeFnbtnMOU8n9UA0pfoo0ofH7gSMaKw4GRRl5kbdoD1FBEwUyvnvF8lTseXp5YL9xBwCO9tMxzs1zKIyG/IyE+8r8YXf7Oed7Grysm7Pk/A/L/TLppX9YdRcBX9dZK4POKDDmeZfZfOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yXvsPaPKrafLfZR1TLaxlSCEMgKVY9QBgFZGkSfAIZw=;
 b=HNpmFGhefmUTw8cIOjYmTYHwIgo7UXFnRKyixZS1/uzHAWMMHYGI/+zuDZAuTd1y+BiKsvocogCE/IVIlDeKED+xsDArFkG+8v6G2siQTJvAzR0SEXHWEbCl4kYGyCZTTMEmDI9t98QvyBKE639M63il+ySJNOJW1rjuSYAbPETwVZ1al40j2esNmTu4ZhmlAcCQw65wVQYtvplVGbgAP7HvIlvs+ikNUbfghmbnG3496N1XGS5cVQCF65vDwEMiDauoz+WL++gQThFfKgSoKNoeJlLX6aF2s8x1jzJUwCG8EakTMGtFR76qkV38EBJKkbsyPoW15bXk5H1el+EFDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yXvsPaPKrafLfZR1TLaxlSCEMgKVY9QBgFZGkSfAIZw=;
 b=uxFHGpaUzzaz+exVQjkQ3lZOABXWkNOaqHlTW+zpMdot8kx5JBv84hoEZCVOsx4SUfciAsIOOFc/AILQ4B2LdgG6B4wRCXU1NgZCh7xk/tn+UE2smRY88C2bwFBz1iHFx+F2chsseci13zSQOkHW3rOrNlX5K6KABcndYKWBKYg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by SA1PR12MB7410.namprd12.prod.outlook.com (2603:10b6:806:2b4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Tue, 12 Mar
 2024 20:06:08 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::873e:e31:6eff:36a4]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::873e:e31:6eff:36a4%5]) with mapi id 15.20.7362.035; Tue, 12 Mar 2024
 20:06:08 +0000
Message-ID: <fa04abad-9191-4333-bcad-9b37ac23e6aa@amd.com>
Date: Tue, 12 Mar 2024 15:06:04 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v5 2/2] x86/resctrl: Simplify call convention for MSR
 update functions
Content-Language: en-US
To: Tony Luck <tony.luck@intel.com>,
 "Chatre, Reinette" <reinette.chatre@intel.com>,
 Borislav Petkov <bp@alien8.de>, James Morse <james.morse@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org, "Yu, Fenghua" <fenghua.yu@intel.com>,
 Ingo Molnar <mingo@redhat.com>, H Peter Anvin <hpa@zytor.com>,
 shameerali.kolothum.thodi@huawei.com,
 D Scott Phillips OS <scott@os.amperecomputing.com>,
 carl@os.amperecomputing.com, lcherian@marvell.com,
 bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
 baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
 Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
 dfustini@baylibre.com, amitsinght@marvell.com,
 David Hildenbrand <david@redhat.com>,
 Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
References: <ZdZPht8hY4J9uIOz@agluck-desk3>
 <20240308213846.77075-1-tony.luck@intel.com>
 <20240308213846.77075-3-tony.luck@intel.com>
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <20240308213846.77075-3-tony.luck@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR11CA0026.namprd11.prod.outlook.com
 (2603:10b6:806:6e::31) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|SA1PR12MB7410:EE_
X-MS-Office365-Filtering-Correlation-Id: 04fee30e-8c80-41c3-2286-08dc42cfdb22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	veIv3BOuNSLgvOUNUW+vJVV4KsqoUAONl+iqsG04tgNcSzX84/opLj/xnH7j1fHfqpsXpgoTIbaj80YTUerhRqvjKH6lSZOV5C2AI+1GWMbW4CEV1bbaqvOvd/ttl1LcQ2hjahwz4DWhq3AKd9UhgFvKtPKFNkCUO/hN9mS6WULqPz7CEtb/sZ6RXh9bgZXEahN5iqe9YHdQQO+DAYoOKFgxFNfuoHRcknapS0h01DSIlu3opjSVY2Bc5Oe5C8o7BfgJjGebCBpFHSyVFpMsiACOyI7Gm8zEry6Jy2LkgYj9h5PLG2jaBh9h5hIZcpBz1THwAPps1FupILuN+Qzcr54HZsrhrDwskhVt0RvrBs8AbsCjSXqElsdi/Cz+rh0QVuKuCRbwqOi25otfksEzrNfSkh+lSu2aW5UqFzID3dRDjEyWYWN76KZtZQqPczQ9KV6fj+NWM3Z6kCBw7SXuYPzwCEoCVUk9FeJznNmIRir3h8vR1WwYIl7fdalSlGaKEl3ODk6z8YhmBwHBRhPyKZKzhkU4BQDHfh9mCIfTqUnTGQk/hwkX4/m0C3HCAMjRSRaELtQkDjdRr2bMolT2O4fcl2t/egyf1BQTknXLhEqBi2x5SDlakHOe1aNHBlXip+FNhlif6uOy1gJyoZPhi8n5OFzHUm8WZDI48gw4FFY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bWxKNXBEWHhVeTZVa0dzVlFvQUhXY091YmFmUSt5cWdKVHRIbEdIcml0UWlU?=
 =?utf-8?B?SzFJbzJaUitoZlA0aVA0bThiNmVpQ2tXN3FhODJMeDRrNUJUc0VoWDlrWjlx?=
 =?utf-8?B?aVJod25FM0ZDTS96aFBEeXllemJKcXU2MnV1SmNtbGE5Mkd4dlVObEtXNE1H?=
 =?utf-8?B?OUhlUEI3STBxeVNYSUFHaGxwaDNlbEpDdFVZRGlCTCtxamRWNzgvWlVTUGFq?=
 =?utf-8?B?Um1FYzdmdGp3VGM0WUhnSEJGT0xhNENPSDlpVFh2dkVkdmsrdm5FaVFpYUdL?=
 =?utf-8?B?aWkxM2MzSG8wTWZKRThxK1lnUGFyV3FtSzQwRDZhOUpwUWVvbmlwWFFaOUti?=
 =?utf-8?B?NmliOU5yN2RJQWt3OHlFL0dWZVpMeGhqOE0zREFEbTlpMkRUQjBnN3BVbWxD?=
 =?utf-8?B?b1l4UjBKZmhwTUVDeHl5ODNqQ1R2cFFSTXNOUkdkajc4MWp2Zi9KbG9mdmF5?=
 =?utf-8?B?MGFZZjNSdWJoQ2hjdnNGbHlsd21RMXFWVHRqRUVRZ3N2TWluYWZ5d2tzeDJm?=
 =?utf-8?B?NURhUi9zQW5qZWRlRWFoa1Z6K3BxMndWUkIvOHhFcXUrMkRpNUJiTkhGR24y?=
 =?utf-8?B?S2UrQm4zcU90ZEk0WG9ScjZOMGx6SERzNzlTNmVvWG5WV3NqZEZkU21yZzVQ?=
 =?utf-8?B?UUhuVnpqUzRSYVhaaUZMaWNNc1lKRFkxWFF2bk5BcVdzaWZ5UUpabXc4VDUv?=
 =?utf-8?B?bklGWVEvL0FOL1ZFaFcxN0dJbFAzWmZnVXM4UmtuQ054NElORGI2TjBaMUZH?=
 =?utf-8?B?bmR5cFFCYzE2aGZnRUk1dWpwR1dOOCtDd01WL1g1OGt3QjgvdXFZWURIYitN?=
 =?utf-8?B?cXNFMlp4dStlenN0MjdIY2VoNWJ0SmNVaVpCVlpHR1JEOWRaSUNPQ0F5STJK?=
 =?utf-8?B?Y1poZXUwL1MyZ2NFNDk0eWU0NHJVTWJaYmZveThLenNVWElqbm1sWmhnQW1t?=
 =?utf-8?B?VEU2VzByMjMxVzFSaHRyRk9kTnJTK2xKT01VMHUwVXhQcXE4OVNEYnc5T1kz?=
 =?utf-8?B?aVVnVTBiY2ZrNVFaaU1naUJickpic1d1NFFITldJMmZybW5jemxHVnpWdkVo?=
 =?utf-8?B?TkxUUzNZYndsM2RSUHNDYjg1bFFYUVJqZGxGZmowZ3NVUXVOKzZadzc0eWdW?=
 =?utf-8?B?TVhqbjJ2R1dvalZuRnBXUTBnZXNQbjQ2clBRYXE4cEhmTktWaS9zajk2ZmRw?=
 =?utf-8?B?OXBZbHFTQU5sMmFKT3Q2QVZPRWJsOWtzWVNlWHhWQXQxK09nbWorZzJrNlNh?=
 =?utf-8?B?R0RtK29UVU5XdzRqOUNtRGJDbFRPQlZmSzl2YXhXRzJPbHoyai9iWU5pUE9r?=
 =?utf-8?B?TFlzeHBtUnRyUHl4dlBrKzI0UTVyY05XL0UxVEJxZVlhT01NeFZkNnZkZm1l?=
 =?utf-8?B?a3RRUVg2UGQ4LzBpRHQ1b0swMUk2ZTBlM0hWdzdRMnRJL3JJVzlCc25lUkl1?=
 =?utf-8?B?S1dJVGdZRE1yWmFYVnA3V2NNbit4UnBJOGQxT1hlRDZpTysrdFJOS3BTVk40?=
 =?utf-8?B?VHZseEN4TklOamtYZ2dRQ0hUQ3E3Rk9zZktPNVQ4N2NOVHNaQXZtRUhxa0kr?=
 =?utf-8?B?QW5VUXJaZ2tnK2VrTFRNcjR5bEt4SXhua3lGbGxuQ0lSVkhXRHA4R0pYSVZn?=
 =?utf-8?B?d2JoSThHVDNjYzFjdkRWU1hmcVlVeUI1S2ZobXBqNTFwSHMxMTdJTU1mY2dF?=
 =?utf-8?B?TnRjSUEzTHZuSnpIY3NOZFM4VUtObEdwYzMwZUJuRVlzQy9iOFdSbG9jdUFo?=
 =?utf-8?B?a3RtNi9YWnlsenJOSUt3Z0djMXBKTHU4ZWdjRDZzTTN0YUtlVnJ6MDJGaU5h?=
 =?utf-8?B?TmhCQi9GWFE4L2dsTnVWZkJNZ3l1K2hJWVByeWtWZC9zVlZxOW9pV3RSOWVM?=
 =?utf-8?B?OEhSczhhZzJ0S3JxdVQ0UnNvRUROcXBWeXJjMXZIdEQ0SCs3dVBhYXhwMExX?=
 =?utf-8?B?ZFo1VVBSdEpma1RzbnlZdkFOOFphVEs4ZmhJMndpUzFoWUpaQ0Jrd25nTXBR?=
 =?utf-8?B?YnB4Mm9WelRQUjBIbmN0c1grcCtZWEp0cEd1bUtXblJDSFNlWFBId2ZsWmhj?=
 =?utf-8?B?M2t4V3FtQm5SQXdSNVlhWjJpaFJjdHptajNjcU9rNVhGSmxlK3dud3gxSFFR?=
 =?utf-8?Q?mSxQ=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04fee30e-8c80-41c3-2286-08dc42cfdb22
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2024 20:06:08.3147
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fIZzSEQQFTV9wt+BLMY37iHQOLLlRyXDpdofbYxBOQFjsgGZeRu3sBblAtAczfkz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7410



On 3/8/24 15:38, Tony Luck wrote:
> The per-resource MSR update functions cat_wrmsr(), mba_wrmsr_intel(),
> and mba_wrmsr_amd() all take three arguments:
> 
>   (struct rdt_domain *d, struct msr_param *m, struct rdt_resource *r)
> 
> struct msr_param contains pointers to both struct rdt_resource and struct
> rdt_domain, thus only struct msr_param is necessary.
> 
> Pass struct msr_param as a single parameter. Clean up formatting and
> fix some fir tree declaration ordering.
> 
> No functional change.
> 
> Suggested-by: Reinette Chatre <reinette.chatre@intel.com>
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> Tested-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
> Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reviewed-by: Babu Moger <babu.moger@amd.com>

