Return-Path: <linux-kernel+bounces-59892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0E9E84FCFD
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 20:38:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C1841F2205D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 19:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14EC48287F;
	Fri,  9 Feb 2024 19:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="sL2rOeYr"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2070.outbound.protection.outlook.com [40.107.212.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63214381C4;
	Fri,  9 Feb 2024 19:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707507524; cv=fail; b=OF1gRfuUtBFsEEVpIpMMON2+aBZTBrrKSpe3EKSUqHH/pGfTAgEy6BgEJ5teg/blqXhhrNpRXSyj2tqWrRmz6/c9fYOtiAIk+d7lHoE0+GGrYPBmSQncxOLFqpVOW7ZNfQCg2W5w2qt134KCCU691OmmDIEvnfis5uPUBJqAy7I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707507524; c=relaxed/simple;
	bh=ttzJayLCFgSk91PoySmI/mVWyI3VfguSdV/BUKPKpEg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QTSW55f7NqG3iYej00K1Ju6GPphVeBRlS5rFhnMRv7sazgcmtft8rA8uRywFPoRREIxZ0FkpLQ+VFuBSlseJ5oaPQRUgd4XT26epIsUu2y4JG8NKOmf31rGjxP47cSQygWfOtnYzBzpXr5j/aPeISONAL9J19Poi2m/fFkSGu/A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=sL2rOeYr; arc=fail smtp.client-ip=40.107.212.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QMIeeh6ORFTalelgHw+aL405QX3b6ETRUjwvtoDGSHUHs3H953hgX621UCsTwvk2jC641XOj8jmYnOlbUZcAj7kSa81R3mqhl7r5iwzG1fab61j5ktv85Z9iXLY5+k4tRqNt2vkN3XrONQmD68ENL9FyVhCt9ngLXKApWtG6FxLnLACS23vsCI7Y1ypDDjbnDcb/9J2ns+mogb0JbVGuyzxPCIo4XZ9DdGn0KX1sSvdyn1A1qGxEKfhGJc/WvErcQSQr0s4B8AKDs8nuoSxtDu/pwLONu2/IptThZbHSrzNHhDVGMLhkgm2jEy2JYDFbRJXjuaB0ganP6ogCNzWBOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7yrAyT2NBE4AqY4imMZ5f0gBD9wU0n7WIWSQ/U3CiKo=;
 b=Hwv7laCqaErVhN2VbrKDQ33fX/EI1oQYGVLXphaF3pKdUHpg3BaT4OtvKOYkqnEujV8O2tFNcKVWOGDSyLVoTGMNRZregnSCLR8ZcPYCqyyZa2kRJCXETPNFTg3wAp04C7/P4pBw/hynsEEAWFOmMH4SbgbB67WeTuJtVRM+qlnC5WubIskfiawOobQApBU+UssWBfStBcH95GkXrPmTno/9Mk7AVNXhFsPEjFRZdgGJj5hoQb4DB832Oz4tTwO5liACmQTL26tGRSViaozLRQIn88yHzuCPKjxjvDyQg8HDPtskjREqrx/A7kssqgIqqcQYLnHVb5o9aFWCoQHuRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7yrAyT2NBE4AqY4imMZ5f0gBD9wU0n7WIWSQ/U3CiKo=;
 b=sL2rOeYrPKQXiW1sX/oah0ivQBPoDQX6p/a7WbwLvTqvLKCkI6aVXiZo7DSSG4eGT6MnXOuTO8ifPHgz9lKopIN3vRwbio4HDRJ7s9McO+xrN+jSl6AUGKH+hjcYNnoCj6UmO93OblG25MOwW3P736SuG9AfnaIdhXAHi2qU13A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by SJ0PR12MB5673.namprd12.prod.outlook.com (2603:10b6:a03:42b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.17; Fri, 9 Feb
 2024 19:38:37 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::f1ae:6833:99e2:9dd4]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::f1ae:6833:99e2:9dd4%7]) with mapi id 15.20.7292.013; Fri, 9 Feb 2024
 19:38:37 +0000
Message-ID: <f4d4ff97-7d40-4915-943a-a7371e24dae5@amd.com>
Date: Fri, 9 Feb 2024 13:38:34 -0600
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v15-RFC 0/8] Add support for Sub-NUMA cluster (SNC)
 systems
Content-Language: en-US
To: Tony Luck <tony.luck@intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>,
 Reinette Chatre <reinette.chatre@intel.com>,
 Peter Newman <peternewman@google.com>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, x86@kernel.org,
 Shaopeng Tan <tan.shaopeng@fujitsu.com>, James Morse <james.morse@arm.com>,
 Jamie Iles <quic_jiles@quicinc.com>, Randy Dunlap <rdunlap@infradead.org>,
 Drew Fustini <dfustini@baylibre.com>, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, patches@lists.linux.dev
References: <20240126223837.21835-1-tony.luck@intel.com>
 <20240130222034.37181-1-tony.luck@intel.com>
 <91bd281e-e21f-4b60-9e73-2f14fcbec316@amd.com>
 <ZcZvguSNel-z3Xe5@agluck-desk3>
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <ZcZvguSNel-z3Xe5@agluck-desk3>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0037.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:2d0::18) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|SJ0PR12MB5673:EE_
X-MS-Office365-Filtering-Correlation-Id: c5df477e-99b9-4d1b-b2df-08dc29a6b5cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	V2M7U4gI1IdX0nfsIe5ng2deJd7daeSJfXwkFGybF8M34NvQaVfENWaR03qTUzdCCJtSyIqrGOtPIdbRO0hdZsD1p269hOwkaNFYpr0PxjrMToPlKtHHq3+JCY3WS8LSb9v6shcIjNucaltLKgSnnMnZejGXz/43MWrVaFgXaXXEvCnl9ox3wetrhpAWQepELmxkjuS4jhaWw23023OAjxZ8S76Delg/8IssxAr0Fv+SnQjYMrAI9Ccxi4N/qhuYobTjxH4fxSzCnlIAfQA/f/EGcA960zjtjkidxvIyrXIOD7Fsop80jA2iv0yYcOzBaO1NwfZUQ+IF59gIf4yWz5PJUH5/VKBkAfMxG9JqXUc4I1EssrhhoZO8sJ+toTC/sX8eCJs3GNOGrrwod0lzLNew1CoxNyri/8xF4Aa4YaTRFXu0Yoz/37NrKIv9awcncpUC+fTOt7/J5HBBifkOq6C9pbhTWSKdx5CaxqDWI6/6rr7KXI//9n77M4xrQMFs7oERPxHZglAyVIwIlIKRbaZKPUoMrIu8bGpgrFtEKu6o07Pxipymj99utvDVmTCm
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(39860400002)(136003)(396003)(346002)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(41300700001)(36756003)(6666004)(38100700002)(3450700001)(66476007)(4326008)(8676002)(8936002)(5660300002)(66946007)(316002)(54906003)(6486002)(7416002)(6916009)(86362001)(2906002)(478600001)(2616005)(53546011)(26005)(6506007)(31696002)(66556008)(6512007)(31686004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N2dXbEtHVGt5OTlSL3VzazVGdkpCRHJiVUh5M1JTYVl4NWFrL1lBVzNXRmJ1?=
 =?utf-8?B?VVc4dmtDK08rUkRvYnhQSXBJbENyMDFJYVlJVWFJUjR1bTBseThjdkVkVSt4?=
 =?utf-8?B?bTFhQWNhL2szdmtHaU9CSVBpWG5iSUZKcjYzd24yblFBM2lDTVVsMTNlQzdB?=
 =?utf-8?B?dUNsbXFVL1EvWW82d1ZKWFF4YlJMbjMxSG1yV0RzZ0NMR2lkNjdScXAvaEFQ?=
 =?utf-8?B?emtCODZRRnNaejVha0lQZWtLRmZYS0VuZ0tLS2IvUDVrZVdzVEVIREgyT3lI?=
 =?utf-8?B?TllvQzcwTFNmdk5HeDNkZlhxNmpLZzJGY2lML1JMZ2VlRi9Lay96MlZjMVFE?=
 =?utf-8?B?c3U1UDJGK29zYkQyK1BkZzBpMytXVUZUVUJadXpXTU9kNTdFdDRhZ0o5Rmg3?=
 =?utf-8?B?U2NQVmJ5c1dqcExNQzJDOW5vRm1nUE9taTJidFFobTZ5cEZLYlVmUDRjVS9w?=
 =?utf-8?B?MlNLRkFBa3Q4VklYNWVHVEYvM2pWb25yQ1pJbTRtOS9YblNLeTR5TTE0Rkhv?=
 =?utf-8?B?THUwbmxEbmtMSTkxNkFRVlZXczFDb09zY24vVkp1elFGdXdRaTIxKzBoMTQ3?=
 =?utf-8?B?NEx4SmlZd3lYbEJrRWJ3cjh5aE1oZ2QxQXZFNlNhMS9OUENFaUlqZnl6WWVv?=
 =?utf-8?B?OVBpbURVTEZ4eU5NeTlBZFpnZ3JrdG9odXVKSkU5VkhlYktGWVFYMXRGekNt?=
 =?utf-8?B?YTdyd1VTRFk3NmVkWmZWSHRWWUxPRitFN2E2MnFaNWNQdGlSYjFTR3ROV0c4?=
 =?utf-8?B?eTAxTVg3bEs2NnlvMHhZZFVYUTJtTXNYK0FKRENzSVBSOFhlMFdMMDVBSGJt?=
 =?utf-8?B?ZTdjcTNVYXZYdE1pZjdmMDAzeW9tMHNiVDhLbW1XTk5tVjdJSG9jYlJ0cHFO?=
 =?utf-8?B?Z1pheDZUS2lMMFl2S25Uc21ZdjEweDZOUnM4SGZwQ2VhdUdGYU1JR013TGc5?=
 =?utf-8?B?Uk01Z0FYY1d4blpMNkd2Q2xEdVJRU0pXbnhNbUliUGNuY3NyMEZQVjdEcDBY?=
 =?utf-8?B?am80enpUcVdYUWIvRnRhVlNQR0YyMENyeDNCWWZNK3lXd0x1aWJHRkVqUWJJ?=
 =?utf-8?B?RVAzQWVsblRVMzV5dFNqOElwZlN6bU9LQmQ1em0rdERYWXczUjVKRVJxcUR3?=
 =?utf-8?B?SlJGdllFUWdCYUROSjJUd3dOWHFPdFRqY1UzOVlJaWFNL0taWXdpaE91eGVp?=
 =?utf-8?B?SGtXV3hmY0lOaXBadmkwdjZzbmFjdnF0T0JWQTExM05kaG5uQ0piSkFQaUhn?=
 =?utf-8?B?R1NYT2FKN3VhcVV1cGlOZkU5WVZ5YVNXZ3VaTEFlYTNadzB0YU4xdWN0NTFh?=
 =?utf-8?B?Tnh0NUZSWXZQRXNyblJnbDJZclR1UjAyKzRvYUY5SlRtZDEvYk1uUHhBMWNV?=
 =?utf-8?B?NEVKcjR1Vzk2QlRFRE1ZWnhtY2RuSXlaNzlqUWVwRFlqS2Jva0gyQVgzamlH?=
 =?utf-8?B?MHdmU0tVSHZSUjJJc0ZTVXJiSWRyWm1PZlpxTjNPc0V3VHF2UGxxeElOMkJH?=
 =?utf-8?B?NHhiUG8zcmc4dWhuVDRJK1piS0dXTTFlOVZCdzdkZUFOcnZ2c3NkTTVQcDhK?=
 =?utf-8?B?RGhTMkQvREJtQTZWYVJLcSsrVG5pdFAxVitINUJKazJ5OThOemRtdnpLOWc1?=
 =?utf-8?B?WE4yN3ZQbDdoYkpvUEdQWnd3WVMydW1lS2FGM3JTejllWTE0bWw5YzV6RDlH?=
 =?utf-8?B?QzBOZThQN3NyVEFxUTJ2UGhrUEt1YWZRNWdsMml0aDZCOU0wbnIrOGpXR2g4?=
 =?utf-8?B?bzllcHlvdWVhYXZXN0hhWlRSQlBFcjg1K01rTGkxOUxVZStQUU9DOWNCSGdF?=
 =?utf-8?B?NWI5azNVOWt5M0tMblpiYnF3RW45QWxaQWpxMHh2UkdGTktYRWlNR21yL0FQ?=
 =?utf-8?B?Mjg3blhrZmxoTi9UTkM4UzlVcUpwcnJZZnRVM3BCWVlEM0c3RXUzMktPN3FN?=
 =?utf-8?B?SXgzcXJNNTRMMDlTc0hPMGM4cUFWY3FxMVB3UUhuNE10a2l2d0VDVnVMUFhH?=
 =?utf-8?B?cEsrTDhYdTlTS1RwbndLV1p5dVMrVmlTZlc0UFBZaENSSDQxSmJNL3JTZUlz?=
 =?utf-8?B?RE9xTnVkdVBYQjZmVHF0NmRvNXZlUFBoZXErQzdKRmdzZFpQeERYWlhUL25E?=
 =?utf-8?Q?LNbtZqMyxmeIyUVM9fskp9Ir7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5df477e-99b9-4d1b-b2df-08dc29a6b5cd
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2024 19:38:37.2457
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rbkFl5HK/zEiVIcL0nmh1fl8aym1NL4eT7Ec4UHMjhQuLwqZO6N99SBFECUQqgMc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5673


On 2/9/24 12:31, Tony Luck wrote:
> On Fri, Feb 09, 2024 at 09:27:56AM -0600, Moger, Babu wrote:
>> Hi Tony,
>>
>> On 1/30/24 16:20, Tony Luck wrote:
>>> This is the re-worked version of this series that I promised to post
>>> yesterday. Check that e-mail for the arguments for this alternate
>>> approach.
>>
>> To be honest, I like this series more than the previous series. I always
>> thought RDT_RESOURCE_L3_MON should have been a separate resource by itself.
>>
>> You need to separate the domain lists for RDT_RESOURCE_L3 and
>> RDT_RESOURCE_L3_MON if you are going this route. I didn't see that in this
>> series. Also I have few other comments as well.
> 
> They are separated. Each "struct rdt_resource" has its own domain list.

Yea. You are right.
> 
> Or do you mean break up the struct rdt_domain into the control and
> monitor versions as was done in the previous series?

No. Not required. Each resource has its own domain list. So, it is
separated already as far as I can see.

Reinette seem to have some concerns about this series. But, I am fine with
both these approaches. I feel this is more clean approach.
-- 
Thanks
Babu Moger

