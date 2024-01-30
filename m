Return-Path: <linux-kernel+bounces-44450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B62F484223E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 12:06:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E177B2FAED
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 11:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18B6E6774C;
	Tue, 30 Jan 2024 11:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KPFl9kck"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2060.outbound.protection.outlook.com [40.107.220.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D803664B0;
	Tue, 30 Jan 2024 11:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706612542; cv=fail; b=JxvFm/qZ8l6UsZLk5m4xUf7L3zrGoiP7S+/zHCirk9Nn/4k7/QItdxrJhR2uON+ox398COBMJYGssV4xghuCNzGpgiO4M8eHyt9m/xfGzy1OOgsucAFYmuFufyO5c6an5DRhnA7HD40/AwEFHFM0p1K30bPcPdhQ0iYq+59wXe0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706612542; c=relaxed/simple;
	bh=w7SFYV3z/CtQzAU8wt4xCdeTdLq1xTqMEO3N+bWmqBc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YyaXUXpS8sE5+6ft9Yid/r2vc25b8kVY+Oaf6uxFxwHVaih++Uan3zM98vbU77MGLE8tThx3kXDolttJSUcA1QIItYsK7WhL3PlheFETCyQKcaw2IsnYEgqPIAZVAeRVUnAjcqhLshaslZUCSjEzC2Zw5Wjly8w7xJsgJZJ5Sm8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KPFl9kck; arc=fail smtp.client-ip=40.107.220.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q5wSHR8HIrQpWzf0sTB7Wf25hJoACeD9JOu+hhymOeiVYadYi49X1Xp8Y94lgwg6VOYz/SDrcrzyIzmCTKxcQbvwHF0u1MkGXw0B8M0xKi6AwHz5r4WOGLMyacVuoC6V5AU/Deca+kkXBf7gQ5do8DYi/rfPnRZLcuL5Rt8PdNwKuFbQP/K259GfBertBX5Cuy3zRiYxs7fUQqNLELzBCChzcCwY7CuD2NMP70Uh86ObZ5AFjb7/FUCtdj4Aauy/iuBoVNgRwYHRICwHq6e6ceHJDgXgPZe7sE0cofHNJa2ORxUBZokrjTknE5ec925XdG96qbyatxBcH7ESd5uTiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MeriIaf6gpu12JWYS8rO+RzTEkanKWSzZDLhsKT29nY=;
 b=Av0CBjvF+FDCaRgrY5asECyb4XquM+QkgpzbTxKrPF0wdxsr1Ju5XDsGSsdbueuLgkfKA+aa59/WDBdi4XVETwqkXl//ld02thGLlYBdTDFuUZQ9ZQh5QM2vFoUWEhyBHTBESDH7+BIuam0uMvdJCTzXBhkGaWTOpSs7mRTWk/0HdIIjS6JZzECfmNKKLhA0EYwpwKjp3TEegAjvddWU8H0RsYBGoFipXSH+TIk4rH+590ULiwJTOtfFAG/olk1bvbhDWSyrXMIbMrsdIWApUMbhDhelZzI5UfWu93DTzu+vjRLLt/cvVdVpnXreeBTVOjrfHSqS+ScriV9yKwXmXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MeriIaf6gpu12JWYS8rO+RzTEkanKWSzZDLhsKT29nY=;
 b=KPFl9kckkO9uhhYpBoldvPOFqP+j93HkhkSkTnwQScASy0dwJVFd8Qaa19d4jtHtqOfqfLcxImL3U8D2YqS/x4Pu65xJ+lcg5/VgXDkETbZUYbcebU7T/afy+g51zD4TMtra4olM+R+ojpuWZ5SrodE9d16OFoZIOxTrQDt/C2ayDiuC5oCzkwz2sxrZG+z7rv5vUDkKXa3+B0+ehCxrSvhveVcyR7zRTnn5x3ocM0RYvupJL6OYXyiwbmGle56BEePFjH+mfWuEyYivP0CUAJubw6Zd5T0dOq+UpcpeqmPWqEHvMPJCgOPMMYoFZymHx6r3Lyl3pJb40zNFm+1yHA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 MN0PR12MB6077.namprd12.prod.outlook.com (2603:10b6:208:3cb::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7249.22; Tue, 30 Jan 2024 11:02:17 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::acb6:8bd8:e40b:2bfe]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::acb6:8bd8:e40b:2bfe%3]) with mapi id 15.20.7228.029; Tue, 30 Jan 2024
 11:02:17 +0000
Message-ID: <469c7329-89f4-41b2-a17c-3adbc7db663d@nvidia.com>
Date: Tue, 30 Jan 2024 11:02:15 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: Tree for Jan 29 (soc/tegra/fuse/fuse-tegra30.c)
Content-Language: en-US
To: Arnd Bergmann <arnd@arndb.de>, Randy Dunlap <rdunlap@infradead.org>,
 Stephen Rothwell <sfr@canb.auug.org.au>,
 linux-next <linux-next@vger.kernel.org>, Kartik <kkartik@nvidia.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
 Thierry Reding <treding@nvidia.com>
References: <20240129143030.16647483@canb.auug.org.au>
 <d0e1a7c1-06a2-4fa4-b4f8-df149af8eccb@infradead.org>
 <61e8b6ae-fd30-4443-8473-6429f6de8768@nvidia.com>
 <dafa2fb5-276d-4c87-b003-4b7f30d44f0a@app.fastmail.com>
From: Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <dafa2fb5-276d-4c87-b003-4b7f30d44f0a@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0244.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:350::10) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5444:EE_|MN0PR12MB6077:EE_
X-MS-Office365-Filtering-Correlation-Id: abfe48d3-cd74-4cc8-4e9a-08dc2182ec2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8mlGnSG5V62zbPnCdHbjY9JYKYOv3nqlX8d/qEV7B5/J4RakpkdrUB1QJze+cZNNTk8JdoWcFBiHjOGHgdGFiipDmrC8RpjFRdCJ6YlsmH2Xy9GfaCyRAzs8AYDL1JIgJ1pVGmaa00vUff8vxRA7Sx7YSKj3Hc8O3/u79OgZhfFfTwZ6fq20fMxtrLcyxU9KcasEVQkUmyLpJN101sQ2Kh4JmS5TSZtGphc7XENwVi0+2i7ls0qGnUaOKYUOguCG60ckNRmyY90odxODOPqI+WUc8fmxj9L9kqV+eVrObgh2eMreHrxRRbY4XKAyQ42E9ylf/6uUwQS1ATf68C0k+K3inCJtRgzaNC3ZBsTJuwj83iPowGiRsc0+tDguOhvjEUAw38VH8BkcxjK3ayxg70+YVJI/XHztzB+8HuZjBt7YW9bOMPoqTYHiqqsNa5aN/IgcYrK3hwPPgrsXip6AFMvQycBXDBQDuMCMiWZxdJV4aS/o4kA21UDwpgKChDUeYbR1KJwGNnVcIDZrfK+KA8YYB/778ALydXrVXqg9YEJGJDP6eXHfUUrrWa+2hrUAUNRDrt232LOqF95fHHYCDJSeUcRaZ18kf0vf9F8tiwoE7+/PvF4P0Y1dmlJTOTDxiyH+lvt1bmKWLMqWSxhStOT4Ad8LytZccHK4jKMHTVgOKfjxNSlBQJV6EvQ1Htzx
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(346002)(376002)(39860400002)(396003)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(41300700001)(2616005)(5660300002)(107886003)(4326008)(8676002)(8936002)(31686004)(110136005)(86362001)(2906002)(6512007)(478600001)(26005)(36756003)(54906003)(66476007)(66556008)(66946007)(316002)(6636002)(31696002)(966005)(6486002)(55236004)(6506007)(53546011)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K21xWHE1Y0RCNTVUZmppUU41VEVCK1lyZnArSFYrbGlKTVlidTFLa1pJSjR2?=
 =?utf-8?B?SWR2WFl3aU15Tm9HMVlSNEF2MnByQytpUDFQSzNoNUozQjVNKzNMVmNieng5?=
 =?utf-8?B?YkJDRE5nMEtJVEgrQmZ1YjJpam1Wb3IrSFd6NTE0UlpLMkxvRHIxaE5CNjUy?=
 =?utf-8?B?Y2dMZWtXeXFGdzF0MHQ5MzlSWUZyZ055V2tMcHo4UlBSUEIyTmtoWk8wNzl3?=
 =?utf-8?B?aytEbjFTcTZzQmhZdkYvc1oxY1ZJd3NyZ3RBdXY4cDdrYXIrZFF2SVNVYjJ2?=
 =?utf-8?B?VUhzb25xdFl4WUc5anNRSkd2em5JRFBtc1UxUEZsN2NxeU1SZWtLTlo1WHlk?=
 =?utf-8?B?MlAvRzBoYTZkUkpPdHhEQjBMQzBrcVFMWFdBR09UYnh1SDYxRjkwc1ovRmVW?=
 =?utf-8?B?akE5UldkSWdNaEtpclJWbHlsOFBUVENBVVdwL0l6cnhDTzMyK0IzckgrT2Y4?=
 =?utf-8?B?Y3FpeUZDdXVqR2pNOUNZNFdvZ05USWJZOFFvNE9POERSZW5DVXF3eDY5eHZ1?=
 =?utf-8?B?d0tWV1d2YlhibmpHaVpsd0w0SS95eXZEc0t2ZFFCSnlvaXI4MVRqRW9YdzRJ?=
 =?utf-8?B?eElQTHFCeFo4N0FMeDdDeWRlMThtcWRMaFJLWWN1eXNXYXQ1VE80RFlVWFc5?=
 =?utf-8?B?dStldVJFUTBDOWl1Vkg5U2k2a1Jlb3dsYjc2bVYyUE5vaEY4VnVyQWRja011?=
 =?utf-8?B?bWZKT3pHUURGYjc3UHVybm14dUwwNmIzWmQrcXc0aE80YzIyNEJ6L0tBZGNL?=
 =?utf-8?B?bFQwZzljdUhOMHAzZGR3dFRKdzdOV0YzaHRFdUtnMzFvaU1HUEJoSU8wQ0hm?=
 =?utf-8?B?eGhxR2RVUUxBVXhWVVZ2Qi8vUnJKOW40Q3ZIQ2RnNWFzQVlkZXlIaDlrTDZk?=
 =?utf-8?B?K2pJK1cydkZCdXBIbUVCR0FRcUM2cEpJRytSYjJUT2plU08wRVlBczRYOW52?=
 =?utf-8?B?TDBpR3VpVFdmenhhOXUrekxzQnlMY0xuY09LdlJTQmltaVF2TkxDVERzdzZM?=
 =?utf-8?B?VjBHWXlncS9GeFlWOWpxUGIwVzR6ZHByRmZ3cWhaRHBNcFk2SHlFTFJFdG5D?=
 =?utf-8?B?cE4wT2JRQm05dCsvMlFwMkQ5M1RuMnZkRXlMK3pDem8rWW43SkpyQ05jdi9O?=
 =?utf-8?B?NXdKODVWMThYRTI1emRmQ045dTlOcTdWL0pwaFNKZ1RmWDJlNWxwZHNQenE0?=
 =?utf-8?B?RzJZMlNwUmV2WHQ5MXF4c2o5Z1RFbVpYeVV1UG5KQVNSdk9wejZ6enhKeUFs?=
 =?utf-8?B?L3BITllqOXJJTWlhQjBadGpXMG8zTGFVL0xCRXZuV2d3U1JqbWk5ak9mTmFT?=
 =?utf-8?B?MkNTQUpJUTNsbzMwVzFnazI2R2RpOEd3dkF1ajZoajRUeXYrd0QrTWlCZjZH?=
 =?utf-8?B?TGFzSUY4ZG5MTlhTa3REZFVFdXlmRVVqMFVkbmRXb3lDcm1mVmUrbG9RK0VZ?=
 =?utf-8?B?VThvdU93dTVYZjNVL2VYNmttNGRtTE8xUGp6b0RpbEZ5M29HSkFJemwvMUJm?=
 =?utf-8?B?OU1jWm81RXllVkU0VHhQUXA2UEhHbll4Q0VOOUFSMkpud3VyTEFENlk0djho?=
 =?utf-8?B?M0pwSXRuak5aWHBiRTEvVVJxRVMzL0c5dm9LZlRiSEhRZU44ZDBRQzEyUnJ4?=
 =?utf-8?B?OTJqOGNmMnJNODNlQ3JoY21ibjQwWWFOak4zckduOVdBbHJ2b3ZRb2dqNk5w?=
 =?utf-8?B?cmZSZEFwcTBvamVNT05rS1pSeWVNZS85QW9ZcndQbXNycjFpNkt3YzNzYUZi?=
 =?utf-8?B?NXNMdjEyWFlpaENiWGQzbkJRQnljV085TUdEZFZsUnNEOXFidFlvb1Z2anZo?=
 =?utf-8?B?RWNtWEF0aEs1ZUVYdXNPRnFpVGxKT1hES0xBdC9JNG9QQUdRSEwxSVEvL21I?=
 =?utf-8?B?MVc1YUgvM3BDVldVdk5SUzdNNkVUS2xCSGVNSnY5VUltWkJRK3lGMEFpZ21D?=
 =?utf-8?B?VUNVVG5yR3MvYXNYdmhxVmZqRytlSUtiNWhiemh3NmtIcUF2Y2hzVDVxcFFX?=
 =?utf-8?B?dUhSSTQrekpTOFhhWXZhWDZXeFZ5dmJVNFFzRGtvVWtHT1VyMGdhM1ZUT2JC?=
 =?utf-8?B?QlJRVWlwQkFiN29aUzRLUlVRYzB1M1pGc2JVaG1MWHd5czJmY3hwMWVDWVhP?=
 =?utf-8?B?T1Q3NkJVS01zVmdRMHVjS3BBODRCYVoxcysyT29mdmc2ZytYY0ErTEVWM1VM?=
 =?utf-8?B?ZVE9PQ==?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abfe48d3-cd74-4cc8-4e9a-08dc2182ec2b
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2024 11:02:17.7453
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kz02zDuIRoPpCFva90KkKZ260i4g08c9tq+yjbR+0Nfj5FWXRAGi03RxmMqbE5sZVWMytQXe9H2yeTf3/s/Usw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6077


On 30/01/2024 10:59, Arnd Bergmann wrote:
> On Tue, Jan 30, 2024, at 11:46, Jon Hunter wrote:
>> On 30/01/2024 04:06, Randy Dunlap wrote:
> 
>> Looks like we are missing the following ...
>>
>> diff --git a/drivers/soc/tegra/fuse/fuse-tegra30.c
>> b/drivers/soc/tegra/fuse/fuse-tegra30.c
>> index 2070d36c510d..eb14e5ff5a0a 100644
>> --- a/drivers/soc/tegra/fuse/fuse-tegra30.c
>> +++ b/drivers/soc/tegra/fuse/fuse-tegra30.c
>> @@ -38,7 +38,8 @@
>>        defined(CONFIG_ARCH_TEGRA_210_SOC) || \
>>        defined(CONFIG_ARCH_TEGRA_186_SOC) || \
>>        defined(CONFIG_ARCH_TEGRA_194_SOC) || \
>> -    defined(CONFIG_ARCH_TEGRA_234_SOC)
>> +    defined(CONFIG_ARCH_TEGRA_234_SOC) || \
>> +    defined(CONFIG_ARCH_TEGRA_241_SOC)
>>    static u32 tegra30_fuse_read_early(struct tegra_fuse *fuse, unsigned
>> int offset)
>>
>>
>> Kartik, can you send a fix for this?
> 
> If I get an Ack for my original patch, I can pick that
> up into the soc tree directly:
> 
> https://lore.kernel.org/all/20240103102654.3779458-1-arnd@kernel.org/

Done! Thanks.

Jon

-- 
nvpublic

