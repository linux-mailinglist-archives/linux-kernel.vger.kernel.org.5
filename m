Return-Path: <linux-kernel+bounces-65895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 703D685536F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 20:47:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94C461C23ABE
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 19:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16ED113F00E;
	Wed, 14 Feb 2024 19:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WhmY6gjO"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2084.outbound.protection.outlook.com [40.107.101.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D99713F001
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 19:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707939975; cv=fail; b=KZjF8u1rA46Gal+HSePswnKCP67cAvMetp63Z4CIJMthCt5eMjXT0y6a7CfsC1ynS5v2OKs0SCQatL3k0thg+6Hja3E07Fcl4Kqww+L3DQaP2eqz0yr4z+2O8RBza9PfZN3rCSsBCyKwmmmfBiD3yZ6vtSx4dBhCenWNbd7yXmQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707939975; c=relaxed/simple;
	bh=mJMIHDE+lWjgenYu/mQj60E1Q69EZeY9j0Y7kzCt1Tw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LlHvhDA9d9xfaA4C08wYCsGcbuO6OqAOe0Fyr1d2RubENYpvwD//IWVgGi12fnp7l7aotF1hVfqPz18ip25+fIOsy7/uNFZk/BBUxgU3kE3mrisjNPtIYmxGx32gmddlzcXD8lvIdfHk/8y9/cam5oGD5lL+2d+oaFiKvsxeBJo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=WhmY6gjO; arc=fail smtp.client-ip=40.107.101.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=APQO7kLY55hDcJ2K7nzZvzGdxpywg40OA3Se1qwnk7n5k0x51YzD+lRa07TEwY8o/c3kyFGf+wVoOJAVDEH18pRA81dXjey3RGNHp51yZXAOluUT5UbBPk/M/IkNUXarF9hrCtxw203+hT88nB8N7Wp25bzqRrfhTWwLmBPY9MvBBuGFwHRJKwzBPCFjGE33I9idDshh3OjbZeJ/EGo4K4/C1FAdFhndPjn/AYLVKy57SdpTQSmGqhjfT6SY3TbYB+iHievrM5DYF6E9QYsNwDETT4jjKqzCaOhjQ+ahf3lsoO9+xm5h5qGu1HEQbQzO3Du0J1KAcMqIHhetqPS97A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k1YTTpPdGLQdypbUkrXIUXB5rMw4QV24FyWWVZgGw94=;
 b=ckR647vQ9WJM74IVzXwVz5RGRyeyUYknPuJvVJVL5msBRYF2T70lW159zrImLUdUnL3nsTVDPA+dsy8ruE6fmMissnpdaVuuL5a34i8V7/p0pXBO+GRXkIzHEDwH9COn7sK0+mNCUe7lSjwrC9rvFSWhW9jq8caKpfUP5wnGe+yDKI2fglfx5q7rKs/x1JtSyqy1ehPw9+iJHuXDdRlPk1cNgoiaugBzcS/Ii4zcuF+ojb0Z6GGMZbMWlaYyXiTn/RAxIthypnAJl9Sip0pmZUEzVeFfRGo29pLI/DaG1umK1+a9Lpzb/vh1AZdKiJZWhpOiUTr754yFcNtemHXLBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k1YTTpPdGLQdypbUkrXIUXB5rMw4QV24FyWWVZgGw94=;
 b=WhmY6gjOOu0Pf9suSjHa6AQVq7KHAULNbwpoUiyigbxay+85VhOwNxwKgXfXI0qtHD5CvWGk2DFTjWvX1Ol8H1BILS4tfHM5Qyep1QpgC0+A0BH/gra1xA6PWgtitnU07Xu3CpBZGgF+0gVC/DHfCVudsgM2c817Xl2hwAqOobg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5732.namprd12.prod.outlook.com (2603:10b6:208:387::17)
 by BN9PR12MB5338.namprd12.prod.outlook.com (2603:10b6:408:103::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.26; Wed, 14 Feb
 2024 19:46:10 +0000
Received: from BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::e164:6d6:c04c:ff59]) by BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::e164:6d6:c04c:ff59%6]) with mapi id 15.20.7292.022; Wed, 14 Feb 2024
 19:46:10 +0000
Message-ID: <696a5d98-b6a2-43aa-b259-fd85f68a5707@amd.com>
Date: Wed, 14 Feb 2024 13:46:07 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] x86/random: Retry on RDSEED failure
Content-Language: en-US
To: "Jason A. Donenfeld" <Jason@zx2c4.com>,
 "Reshetova, Elena" <elena.reshetova@intel.com>
Cc: Theodore Ts'o <tytso@mit.edu>, Dave Hansen <dave.hansen@linux.intel.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>,
 "x86@kernel.org" <x86@kernel.org>,
 Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
 "Nakajima, Jun" <jun.nakajima@intel.com>,
 "Kalra, Ashish" <ashish.kalra@amd.com>,
 Sean Christopherson <seanjc@google.com>,
 "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <CAHmME9oJvbZgT4yT9Vydc2ZQVSo3Ea65G5aVK7gFxphkV00BnQ@mail.gmail.com>
 <20240131140756.GB2356784@mit.edu> <Zbpc8tppxuKr-hnN@zx2c4.com>
 <20240131171042.GA2371371@mit.edu>
 <DM8PR11MB5750C7D16DC566CD1329D5A5E77C2@DM8PR11MB5750.namprd11.prod.outlook.com>
 <CAHmME9q-eUXnXnpaDu0VOQemOYysst7SaJ-=b8-vCFP9h50Szg@mail.gmail.com>
 <20240201045710.GD2356784@mit.edu>
 <CAHmME9oqM2a766dBK22-yKr8=2-icg=UkQzmBOF8G5Zh_Y9E9w@mail.gmail.com>
 <DM8PR11MB57505F657A8F08E15DC34673E7422@DM8PR11MB5750.namprd11.prod.outlook.com>
 <DM8PR11MB57503A2BB6F74618D64CC44AE74E2@DM8PR11MB5750.namprd11.prod.outlook.com>
 <Zcz2r51Tbb44ywjl@zx2c4.com>
From: Tom Lendacky <thomas.lendacky@amd.com>
Autocrypt: addr=thomas.lendacky@amd.com; keydata=
 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
 vFkWitqCJg==
In-Reply-To: <Zcz2r51Tbb44ywjl@zx2c4.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR11CA0173.namprd11.prod.outlook.com
 (2603:10b6:806:1bb::28) To BL1PR12MB5732.namprd12.prod.outlook.com
 (2603:10b6:208:387::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5732:EE_|BN9PR12MB5338:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e52d0f1-42c3-4070-6da3-08dc2d9597e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	GXMPl5u9xvdJK563nQg4EMWsPXVBo/86o1HYsUGbei+z9MfMjjk8ZyjwOXXlz9DWHfzmvb4GFvW6ojaCu54HtL8BMvB5BoEyjSUW00g0gLRVR0JpEGNjirmX9ke3lq6I6tv1s+nsSmLjkffqvEMMcg4WNROu+krzpqVFGIqgK2VzkrVZNNoG56QWxIG8hbMx+SVHOlIvKsPa4/LrxhLVT66cU/YWg6PUOCj0gOqwHjhtX4aj3P4RGR4g1zWLZWCGK6bUHk1KbummjYNzCKzlIwfaMo/pVJF68O2lVmj4fuqAZtKo5YRPKzZCwlb68GdExdfZdt3v6TW9h27+B3RkX184uwq0JXSlEZ5g/hCI/H8CpcNcCnWMfjlGIwLSB+NgxxNZyItHVhCGoXdhxBsL4Zq6fGEOwh37oqAAMRPCTCcGbsAZqhavDLen/ixz0ITv9wQlwe/tusD1VLAkHt9h/SVu5vJJ4Xznqcps9b+brGMKgxpN+TeABltLzo8EmWSkKZ75XCOdJYtAhiA8viGYwwpI3lyA+PDjVAGrFJaYqsp5ABGBWsk3HGTs9tMLhVmp
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5732.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(376002)(39860400002)(136003)(346002)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(2906002)(8936002)(8676002)(5660300002)(7416002)(4326008)(83380400001)(2616005)(86362001)(26005)(31696002)(38100700002)(36756003)(6506007)(66556008)(53546011)(66946007)(110136005)(316002)(66476007)(6666004)(54906003)(6512007)(478600001)(6486002)(31686004)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dTVkVFhIekdUUjVUZXgvVnZaWENSVDFwemZ0dGFzMjZPUHdOQ1VPQlhWSXZi?=
 =?utf-8?B?RVVBSDIyTldWODRyeW9yRkZLRmQ2a3B5YXdoMDkvNUR4dE9Yc1RnTzVWaXdQ?=
 =?utf-8?B?YmNkb09RckJacGRPaFhZQnJ3MjNvRDN0Yzl6NUFhNnpNMEw2WnhFWGFaOUF5?=
 =?utf-8?B?LzVaTjlEUTBRcFJxTUE1NitNMW84M2Nxa3BEWm5aUGczNW9VRWcvclc4VjVr?=
 =?utf-8?B?K205UGNDcy9DZk5LY0RzTzRPelpoYWJZQURhL3BYZFRWRGV2Rys3VmpSK05H?=
 =?utf-8?B?YVYzaWJIdlFld3NYdjJJckxITEo4QmlkOVZINGJUYzRLbkxGOEdUNjh4VXA1?=
 =?utf-8?B?d2t4M3lxY00wMm0yWTZ2MWtCaG1qeHBhZDhWUzI0UjVrWVMwREhFKzc4dkd2?=
 =?utf-8?B?em5paXYzbzdEZCtRV1JUSjN5Zkdjb2JlYlVEaVkvNUlsWXFOTmlUeWtkaWFo?=
 =?utf-8?B?Rk9ZT2I3M2F0TGlENlZWaTVmZkFBUzg0K2tqb1ZmRDI0cC8rbEtUeGY5Mzda?=
 =?utf-8?B?cU8xeEx4b0gwa2U5dHVqQ2JhKzFYaG9YYkdHSnVwZVZLMXRNUDdCU002T0Rk?=
 =?utf-8?B?ZVBHYnZESlgvcWNLaXRCMmJwTjlKTFQvZlF2bUs4cE1GM1pMVzFoOXRxY0sz?=
 =?utf-8?B?UngxMXNWdXdWc2FKc0FBc2NYWXpOVHI0THNGaVlLcVE3TlU1WXZmRFJVOFo0?=
 =?utf-8?B?NmF6d1Jmb20rREx0WFFEcm1RNHNVeElqZDRkUFA1a3VqVVpreTJkbkJ0Smxq?=
 =?utf-8?B?RDVvRXFiQkJRM09RdThnYXQ1Z3dMaE5KRDRZRzA5YjRaNVl3QVlQNzZTVlM0?=
 =?utf-8?B?REZGbFYxeDNGWEE5ZEwzSlRtZ2NCNVBoekRSWlRSK1IzYWIvNU4wNEsxTHhK?=
 =?utf-8?B?MXk2NXZ6UHVLTmxET1JTbGJBUVhUS2hUOEplbU5MR0FtZ2wvbExHbnZRSDdQ?=
 =?utf-8?B?NHdha3JJVUU0Y2tIS2pLY0lMMWQ1M09sa1RKMmZvWmFzRWVjK09Kd3lPWUs2?=
 =?utf-8?B?aHh2bVVCMWZuMjRKaEl6Q05RNERiTGlKTHZ3L2FNaTRjK1RtN2pTZEZTM2hj?=
 =?utf-8?B?UVNaMjBFbDhmZ1pBZm5rUkhneEFNRE1zS09SaXdPQjBvTDkzbGNVUy9jTUps?=
 =?utf-8?B?cWNOZnorNmN4T3lmcTdjVDhGNnpkK1UxYXZKL1E1QXIrQWNtYnNjbTFWOGhP?=
 =?utf-8?B?VEUxSy9QQmR6WHg2NWV6VEhpN1hRYmJ3NG9hWXRRdjgweWIzSXRVUmNXN1Js?=
 =?utf-8?B?bXJDbGtWenE4TVhPOTBqY1lGcmx3ZHJxT2VKVC9vdEZpSWdqZGN1cHR3ZVNF?=
 =?utf-8?B?Q3VKa0xMRS9KVzVvNkFkZkFBTVk0NFRsdUlZUURiUlZkS1Z6QklWVUQ0M0J4?=
 =?utf-8?B?MGFFdm5PQkM5UEpKY2JOZWVVYUlsQjkzaVFTMmZ1cW5LUGxibUdjbUJ6UDc2?=
 =?utf-8?B?dnFEYWlLeVpaVFlJZXFvYnJEWUZ3Ny9VSlU5azlTcm1Bblk0V21lb3NqMW9E?=
 =?utf-8?B?NnJJRXlXbHhKUitOMUg1NmVpSkZPRmhPRkE2TDdyV0dZWXNiSzlVOUFyWWp2?=
 =?utf-8?B?SFZaTUY0V2hscmZwMTZJdUJDZ09kZ09HNU1RNjgxTmV0VHFySXozeHRsN2Zv?=
 =?utf-8?B?U0drS2pYaEI1Qy9NK1JBWWE4bDdSZ2xlRXlXNmxsZEhIS1pTclJZNEtoWkox?=
 =?utf-8?B?RmhscmxudUV6TityMjBRM2hMM0VBTC9SZFlIZEdmaG5XVTRCNC94MXRtWHdG?=
 =?utf-8?B?RUl0OEE1MmQ2Sy96OHhKS0hjaEdsemt6SkJJVmxDQWhNVXpRSGhHRU90bzdt?=
 =?utf-8?B?SWxwbk9BcHdNbEF2bUlJYm5WaHBYUldYWElobzQyMnNwbTluMmJ3dlU0Z3l5?=
 =?utf-8?B?MmdaMDV3ZUQxQjJoMFI4WmNIZ2RIYmNNdTZlVUxNbzZQYStkdWZLTGRQbTRC?=
 =?utf-8?B?c1NYZ25hQXNFbW5oY1pmR1dieWtvT2dIY255bXE2WDU1REFPd1djTS9VQTJJ?=
 =?utf-8?B?dUFXSDhNNkY3Z1pPWTRURE8zNDVVNSs0NUx1VHlGSTdadk1uMGMraHlYV05C?=
 =?utf-8?B?Z3g2WDRLcWJpWm03b3dabmtNcEtiUEJVVE03ZzlDajFnK1IzaWNQQWZ5Qld0?=
 =?utf-8?Q?20AiKRy+ukt/RKCCxd1xeBbQx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e52d0f1-42c3-4070-6da3-08dc2d9597e4
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5732.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2024 19:46:10.2780
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3U1n58aB8T8yrgwh+C2emBOuoKqO8eO3NNtXE1vcmwYLkhWnDO5S2bfIZnRm8M0XiagFPUUe4xOA84E667gQzg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5338

On 2/14/24 11:21, Jason A. Donenfeld wrote:
> Hi Elena,
> 
> On Wed, Feb 14, 2024 at 4:18 PM Reshetova, Elena <elena.reshetova@intel.com> wrote:
>> "The RdRand in a non-defective device is designed to be faster than the bus,
>> so when a core accesses the output from the DRNG, it will always get a
>> random number.
>> As a result, it is hard to envision a scenario where the RdRand, on a fully
>> functional device, will underflow.
>> The carry flag after RdRand signals an underflow so in the case of a defective chip,
>> this will prevent the code thinking it has a random number when it does not.
> 
> That's really great news, especially combined with a very similar
> statement from Borislav about AMD chips:
> 
> On Fri, Feb 9, 2024 at 10:45 PM Borislav Petkov <bp@alien8.de> wrote:
>> Yeah, I know exactly what you mean and I won't go into details for
>> obvious reasons. Two things:
>>
>> * Starting with Zen3, provided properly configured hw RDRAND will never
>> fail. It is also fair when feeding the different contexts.
> 
> I assume that this faster-than-the-bus-ness also takes into account the
> various accesses required to even switch contexts when scheduling VMs,
> so your proposed host-guest scheduling attack can't really happen
> either. Correct?
> 
> One clarifying question in all of this: what is the point of the "try 10
> times" advice? Is the "faster than the bus" statement actually "faster
> than the bus if you try 10 times"? Or is the "10 times" advice just old
> and not relevant.
> 
> In other words, is the following a reasonable patch?
> 
> diff --git a/arch/x86/include/asm/archrandom.h b/arch/x86/include/asm/archrandom.h
> index 02bae8e0758b..2d5bf5aa9774 100644
> --- a/arch/x86/include/asm/archrandom.h
> +++ b/arch/x86/include/asm/archrandom.h
> @@ -13,22 +13,16 @@
>   #include <asm/processor.h>
>   #include <asm/cpufeature.h>
>   
> -#define RDRAND_RETRY_LOOPS	10
> -
>   /* Unconditional execution of RDRAND and RDSEED */
>   
>   static inline bool __must_check rdrand_long(unsigned long *v)
>   {
>   	bool ok;
> -	unsigned int retry = RDRAND_RETRY_LOOPS;
> -	do {
> -		asm volatile("rdrand %[out]"
> -			     CC_SET(c)
> -			     : CC_OUT(c) (ok), [out] "=r" (*v));
> -		if (ok)
> -			return true;
> -	} while (--retry);
> -	return false;
> +	asm volatile("rdrand %[out]"
> +		     CC_SET(c)
> +		     : CC_OUT(c) (ok), [out] "=r" (*v));
> +	WARN_ON(!ok);
> +	return ok;

Don't forget that Linux will run on older hardware as well, so the 10 
retries might be valid for that. Or do you intend this change purely for CVMs?

Thanks,
Tom

>   }
>   
>   static inline bool __must_check rdseed_long(unsigned long *v)
> 
> (As for the RDSEED clarification, that also matches Borislav's reply, is
> what we expected and knew experimentally, and doesn't really have any
> bearing on Linux's RNG or this discussion, since RDRAND is all we need
> anyway.)
> 
> Regards,
> Jason

