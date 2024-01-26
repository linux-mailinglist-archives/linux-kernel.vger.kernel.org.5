Return-Path: <linux-kernel+bounces-40342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A680783DEC9
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 17:33:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1FCFB257E0
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 16:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 165821DDF2;
	Fri, 26 Jan 2024 16:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kLlxniM2"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2059.outbound.protection.outlook.com [40.107.243.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B08DBA29;
	Fri, 26 Jan 2024 16:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706286766; cv=fail; b=qYfe420X151Oy3O8nU1OSYPPQJuEbuQYkx+f+Fp5d41yhoPk6fX6nRuZScLd6kfesPkPnIsi+qiHmZoQINLXb6sIMmBq1QoqF7p2gOtAoiQdK2qSwFbBixc9vxgOVqBHXydpkxwLihMX6CuJWAgEM4NPt06gCAKwvFxDPICZOhs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706286766; c=relaxed/simple;
	bh=poeaCG7eFDffcUKFAN6Djt8HNP8Gg2xFCsqYDmcKpH0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PLDjMLY+/YgkphrxPNQRx+xNRQOWcCdH4jZicwZDeep3d4TpcIwvbUd9Wdur5HkM83BenV1/GlGvKwuWmLAb49f9WABsdMoV8yCMvNUhU0BvljfDFGkKa7CCDFYLaBu1khsFPJYU7l2/dh4tQr7oIQ0O+V69flfcd2vL8oUnKwY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kLlxniM2; arc=fail smtp.client-ip=40.107.243.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G6nlsMUMZZ835EXbU4FTDNMiteK9KTimsjQfrTrad+S1ctUUk0BfRt58Vx5f944QajpnM8zBe1OwTcoHEmHfmidYW2GPsARhToIWtEZwkfk0Hn8gWSjSo+poDj9Auk3d5/D2Hvj9BBiiqZZ5z4QbWrogtfmnvbg02hoeGqzq7CuhNqI9zwNwuC2faKh/f8vUu+L5hFHOBsAWpSVsHA4DheMjSMqeNwBszfHnH/9bJfPBVsuJl5AT/NXinuJlfDINQBb2sNdCet3qylc2pqy22RcLWyuPVhyr0E/2/tCq/ISAFeiBaJOlC4imX3PrWZZXH9MlZW+FrG7LfeoV39CYpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ix+tswOlHlAuusZ2rXG5IvcvAYywPS4hHD7qjz+EI4o=;
 b=m26XR5njg0g/eqBwtsuXB8APhuiv4f0tl7UP/AAqiu3nWzE8CwdxO9lIXroS5Y8IuiBjDhrGsjLRwSh8cGZ//HZLPZAsaNRZeP8MRi9DHEAKAxoJpVGz7m+ugpJ/PFSeV4SuCy6rl04SXiCFVRYRf0+5JHM2R9kmeDMro42BeZoAvVTP97Gp9P0KkbQXVwkui7lrYY/cjUaiIjXVVQruzCrTpkOqZc5qQeQL2YkljihfEwbVa+8gqY/mBFoKKQ2tbGTjDwPRtX99aUAWSS1KYqbA/zAwlNUfWtkYQ5eDqCgNmwNa2PE9ZREEYJvA2ERtynAXTvNbOXkrspgeo/0dOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ix+tswOlHlAuusZ2rXG5IvcvAYywPS4hHD7qjz+EI4o=;
 b=kLlxniM2fFpGWe6t7BcanPMIOgDdESQbhiZcHu1FSpTdqZe/hzp9LtOA76TCnYbewkp3OhiQVcivSaarvcsaZTJscB8pjD8kLmVt3oCJ/09yA/10SLU35+D+WkZAPYK3ZLw7tjX2oClZtVK/I6gGJuuBo+AJ99Ejc40YRPNWGLY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6263.namprd12.prod.outlook.com (2603:10b6:8:95::17) by
 SJ2PR12MB7944.namprd12.prod.outlook.com (2603:10b6:a03:4c5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Fri, 26 Jan
 2024 16:32:41 +0000
Received: from DS7PR12MB6263.namprd12.prod.outlook.com
 ([fe80::7a38:8f14:8998:89a7]) by DS7PR12MB6263.namprd12.prod.outlook.com
 ([fe80::7a38:8f14:8998:89a7%3]) with mapi id 15.20.7228.023; Fri, 26 Jan 2024
 16:32:40 +0000
Message-ID: <c2fe25b0-a51c-44b8-a454-2573fe6ac651@amd.com>
Date: Fri, 26 Jan 2024 10:31:19 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] crypto: ccp - Fix null pointer dereference in
 __sev_platform_shutdown_locked
To: Liam Merwick <liam.merwick@oracle.com>,
 Ashish Kalra <ashish.kalra@amd.com>, Tom Lendacky <thomas.lendacky@amd.com>,
 John Allen <john.allen@amd.com>, Herbert Xu <herbert@gondor.apana.org.au>,
 "David S . Miller" <davem@davemloft.net>
Cc: "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 Mario Limonciello <mario.limonciello@amd.com>
References: <20240125231253.3122579-1-kim.phillips@amd.com>
 <91b75885-26c0-4697-b5dd-3ebce922dd44@oracle.com>
Content-Language: en-US
From: Kim Phillips <kim.phillips@amd.com>
Organization: AMD
In-Reply-To: <91b75885-26c0-4697-b5dd-3ebce922dd44@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0076.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:2c1::19) To DS7PR12MB6263.namprd12.prod.outlook.com
 (2603:10b6:8:95::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6263:EE_|SJ2PR12MB7944:EE_
X-MS-Office365-Filtering-Correlation-Id: 14561383-c85c-46cd-6b35-08dc1e8c6a14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	RSlIhHZzYHKqQi3kyvyL5Hs7Isvs/SHuSXF/Pp1v7VnHRUQxOVQzn8T+tyDAOfhyrUPw2w3DEX89VzU7fionnSgrPuPQ0nyYGGuxRgDYoN5thB1ib9yKDhjavqBquiTgDYkUgsOaasdWpAeHkiHNCtokoTzR/mu8iv3nxzYW9yAbxyq3Iv/SI0vBvVbp3iGa9pEcrNLgBWdkFL8YOoBGvXD9hPEykBcfGM0UUXA0baBl119Yud165Ftb05HQpmTzYLTAny+fgSfZJpGYAqvaYta25BtIbreti9f+jAyqLRrooTBzRRxHY0zA0Udtjr0gT0d8S4dVjjMEbL8LBBsHRh4tJnbbp16XLhuHlFgGM/jwtth1TYXIiFYbzuIipge9HWB2SgjVBgg3RO1sEEPX9w5kA6CmHO2Qo2d09uv/ochm7vR9dfr77rGVH3wjcLqWINQ7bc0IGKV18XUZ8lJw9zg6W3YoptfTY/G/Y5WR3xeDlevOP8ZcBUX79LMRHq285lpOTM8dKOy/8UVoG6Ws2zz6++LLWd0ADy/FX9w2gHMX9WjVdDA0sJBRGiHlF5bNuHPwm8xs/ElCbU1CPSgc8RLSNgd/UPJoFSNs5wjcdicm+8Z0RAhyhVw8SYnxFeduGqZ30nK5Tb+i9x/2pyDioA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6263.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(376002)(346002)(136003)(366004)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(26005)(478600001)(53546011)(31686004)(2616005)(36916002)(4744005)(6486002)(6506007)(6512007)(6666004)(316002)(41300700001)(66946007)(54906003)(110136005)(66556008)(31696002)(8936002)(4326008)(8676002)(5660300002)(38100700002)(86362001)(44832011)(66476007)(2906002)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dW1jT2VYWmM1WVBRRmdFdzh5VUJObjdweDhsZEpSUjIrdmYwdXIydmFrS1ly?=
 =?utf-8?B?UmtPcGsxbFJoZmhtbzN4SmFQS3BldDlDWWhNQ0I3M0FySXk3ZEwyYzBuU3N1?=
 =?utf-8?B?bHBlaUo5L1htWk16VW0ydEkyLzQvdGN0ajhoN0pGaVZsK2VFUXBkYVFtTXNj?=
 =?utf-8?B?K2tLaHJ6OFRJYzVJc2xFdTZPTXg4YjlkU3dxZWdGRWowTVpWU01vcHY5TXJx?=
 =?utf-8?B?bGdyMi93QzlMQm5kL0JtclhOSE1KUXdtNkJxcW9KcUlWY1JSeGxHS21WTTZh?=
 =?utf-8?B?cm9zeTVoS2RaL2NTUC9aM2h0Zm8xNXl4bll5MHVURE1oaU9XMWVhWGIvSUdT?=
 =?utf-8?B?WXBRRTdHbmhMS2xEb2ZvRWNWdHhtTnNza05Mc0lJRnY0d3VVVUlwT0l3cDdN?=
 =?utf-8?B?K1pqUWNSVXd4Y3VOenJBTmgrSVd0YmhDVDA5RmtKeE5XdTd6MDVSSURZVVUx?=
 =?utf-8?B?Z1QzdXloTktFS0xDK1R1dzduYS82L3VlRmRrVThqSGZsdU90K1ZIMno3QmlL?=
 =?utf-8?B?RVJWUjJQOUQyQUh5aGE1Y011MGlBU3luUDhNR29BSHBsdmJHYWdLOEJDWXVS?=
 =?utf-8?B?YlBHL0RWRWYreVZtZ0hwWGk3MU9GZHl3YzFiMkhscEVQbndNMHhiNkhVZWIw?=
 =?utf-8?B?K2dvYk04VkhJOVZTUDBTL0FNZW10MldpbVJkVVR4NnV0VnBScGpCc2NDSnN4?=
 =?utf-8?B?b3JTa0tTQ2trVHJGWk84RTJHZ0tJMWNoZGdQT1Yya05tdjJjeW5qaWdldzhw?=
 =?utf-8?B?ejVyaFkwTXREZjZjajlVbVVabVQwZnJPSVNjMXVWajBQMEtYS0RRVkkza3VV?=
 =?utf-8?B?S2JDQjB1VjczSDlHaTFqVjRZV2dXN1FzanlzMEJIRDBzOVFPVjdCM1NoT1J6?=
 =?utf-8?B?eWVMd2czaGIxQ1d3VGV0eGJ4VVJURlgyV0l6RjNOYnR3Z0dmQWxSK0JWaXY0?=
 =?utf-8?B?VFdyNXIyb3piQTdvcmxJZTJnTm5hY2l3ZW93b21EZ1BUQit6RVVpVUw2UXV4?=
 =?utf-8?B?OHJKRTJ2ZXlOek9pUHgyNmhBZWpBRmNpbzdzL2V1em1EZHVLT3BLelFHWkdn?=
 =?utf-8?B?bS9HaW5sSmw2TTdQSS8wKyt6NmJuZStJUUdicTZiMW1lYmNyVkJHSVA0bStO?=
 =?utf-8?B?VWlIaVNza1dVdVd5ZEk3aDJLNVFaSkowUEFVTEMrNnA2MVpiODdXOUZYYU01?=
 =?utf-8?B?OTI1b25nOEdielkwNnVGUER3RkRJT2diNmk4WmJ2bjJFOFlzT2Z2NFI4eXk0?=
 =?utf-8?B?bHgzRTI5QjgvRnVqWHpCRGI1WHlYMGJqVDFzMlpaQUJ3dHE3Z2hObDkzcGxs?=
 =?utf-8?B?WEZ0a3lMSVFUblhPU25iNWUzU2VDZHluUEJicFo3MEtWRzQwQWl2OXllY0dR?=
 =?utf-8?B?R0lKOFFXWHJURnBPY1ZjbjRIZkVkQUgxVzBrT0g0czhTY1VsU3k0ZzlEV0Nx?=
 =?utf-8?B?Qks2RWkxK3FtdlMzM01lblh6SHgzNmpPeTJYR2tZWVJPVnpNWFVkOWxNK2xJ?=
 =?utf-8?B?RCtJbTJtNVB5SjlUaFFHbDNIcDNCZkFEeTllWUFCby9QOUxob0h0ck9TR3pN?=
 =?utf-8?B?ajJ1alZDMWZhZWZIVGxPYjRFMVNxSGNUU0lTc0xkMzh6VCtPa2RXRDRHTEQ1?=
 =?utf-8?B?QVlVNzFjc0ZXS1pObGVCSG1zZldvYkk4YTRqUnJVdDgzVWljT0dZNEhHZjhp?=
 =?utf-8?B?YzlWc1hsZGZIZUZtN3dHRStWV2pqN2d3WUQwZkVGL3puMnl2TlpZbi9ORW9Z?=
 =?utf-8?B?c0gvbEkreWQzQ1NtMStPeHlHTEduSVc2NFFRM3poY2hSVUxrR0tqWjN0enhZ?=
 =?utf-8?B?SUM0blUrLzNTYVhKakFlSU9KanQ4SVNMN2taUVUvWTF6SWp3WjJwZlgrZjZa?=
 =?utf-8?B?SExVcjBYdnY2UW9wZ3AxdFk2NWt4NUo0bzB3S21jOFlCWnpQNlRYQVRUb1VW?=
 =?utf-8?B?UnRLUG1sY2I0Yk85Z3J5bk8xVHk4UlVGZmxxQ1FyczlPVVdJMGoyZ2J0dDN5?=
 =?utf-8?B?aVd3Tmpzc1NqUFY0SkNOYzlKZGEzT2V3dTFYdjV6OEtEODVnYlVZL1lpVHp1?=
 =?utf-8?B?bmg3S1drM1ZrMlpQKytQQVBvNXBTZUs2WWZwajFLaldDRCt4cXl0WnRmZkRv?=
 =?utf-8?Q?jANl5FEpevkTytKai6DK9XpIs?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14561383-c85c-46cd-6b35-08dc1e8c6a14
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6263.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2024 16:32:40.5186
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FbQqNBSRfB1UApK3wwkm2SLguMV5cFWcVfCh/fGMGwrzyUtGGsHzO5XxsmhyVfzSW2PHMgd9i2vK8e1qtC3NSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7944

On 1/26/24 5:59 AM, Liam Merwick wrote:
> On 25/01/2024 23:12, Kim Phillips wrote:
>> Fixes: 1b05ece0c9315 ("crypto: ccp - During shutdown, check SEV data pointer before using")
> 
> checkpatch warns about SHA1 of Fixes: having more than 12 chars...
> 
> However, although 1b05ece0c931 is the last commit to change this
> functionality, I think this issue exists prior to that.
> 
> 5441a07a127f ("crypto: ccp - shutdown SEV firmware on kexec")
> might be more appropriate so that it'd get applied to linux-5.15.y
> (where 1b05ece0c931 and 5441a07a127f have been backported to also)
> This patch applies cleanly to linux-5.15.y.

1b05ece0c931 fixes 5441a07a127f, and I'm assuming Fixes: are transitive.

>> Cc: stable@vger.kernel.org
>> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
>> Signed-off-by: Kim Phillips <kim.phillips@amd.com>
> 
> Code changes LGTM, so
> Reviewed-by: Liam Merwick <liam.merwick@oracle.com>

Thanks for your review!

Kim

