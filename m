Return-Path: <linux-kernel+bounces-149295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D1618A8F00
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 00:52:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EFA81C20BC1
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 22:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04E6384A5F;
	Wed, 17 Apr 2024 22:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="FnslrRqI"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2076.outbound.protection.outlook.com [40.107.236.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7BCD22F19;
	Wed, 17 Apr 2024 22:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713394350; cv=fail; b=VW5aI+8oiF3K4pNB9hdaKUYRlwMcgFVVCMGYEAbifP6g1KXB3ofDo/N5qNniPdIudONew3pleC7hb3xUOiolIfEw3OiS1X0+ClJZ19jpUsEj1lnIRjFQ6C4FkEInWnskyjpw8y2vCQ9WowchymFKpsFxQhUBbLKSxqVTRdAi8jk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713394350; c=relaxed/simple;
	bh=h3Z+iLXENFE+UNTpsG0g3lrsk+rV/q2ZT1241PU15cA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JfOGv7U9D1oCgfy0lEcbfQOWpxLHqkqcY0cCydp4tJzTEUtglPACwmmkLbDK3nGAV3LSSY1DNkmcdUrh1iqAPnr2+xNZETZOPvozlmKiPk8VDFY87H+mvwuL11/QTE9KtJIJLeXpyKIvBg6gbxO/BsPVfx4ogAC6Yilz8Z5tha0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=FnslrRqI; arc=fail smtp.client-ip=40.107.236.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kI1bQDyDtq+Bt/w5TJD5j1n6QGnBTOcDWFmqjw7Ytof5VIJGFeeMT9Fo81c6o/y9KXIQa1fZH0VyrmIDu2zHEoggNuKqfbp2wHZbD0NP1MrFUeQF7Vh1TJmyaJmbtGQj58tjvOb77Ys1BZa311GFFmGCUNB5BB/Nc1/WLiaFd2lMb33Usf2zbm4YmAB7ifY21cyA2/SCorGUz4xzGqaYtLX6WO9YyC0UmV1ZFSPpedh900uZt/oGqLDaVxCW9p3AnxqzC35uUsO5iL+JGCH34yGopQWp7Cq07ZhLC+pS9XOjFn2VNoBwywRWPfz3JzBalYbUkJ8GfnK6vtpDyObylQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2tMZVJEJeS6/7JaSFD2/f3w9GAftrvPEglQLzUMB1qw=;
 b=m5CZwlaEUV3kjz2AfvX/YdAPqZN8ccZOLkd0M22Cou9yXnX+dy9kHozsz2Lx+zVW12qNt2hAKyd3sNeQAx0v9z+9X7Z6iugJk9tYsMcsOnt8jFdGXMIRqPp5drqOxDRtjBs6KiHJrbN3untdJTZNzpiQq9lc0daI9i6balLBY5G2fScIsZxHEhfhgZjE+dRqGbB6p96Rxz4KbUeTmFuojhgLDrL4sPX35feouHruKzUZtnTx4J8hZYALfaG2dnPb/v5hpivFpqqMLdGVtZaK8pOXuqv4kh+uxubtpAehSy/5KICmOV1fWfBEW6WCcIv4JqkpFxB3pWMSTzsQmNkRRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2tMZVJEJeS6/7JaSFD2/f3w9GAftrvPEglQLzUMB1qw=;
 b=FnslrRqIRYGyc+1rjEs4EuFmUDziH3wlhzAKE1kdFrK1rdfpjJYqxgVjWxDtTJ1MvZlJ15mmBQgvuFIZMlSbRPZdnaTYd+EHILEZc3x5fwegR+a8sh8S22vnP4lXA3k/mCVDFGbL5L8aLbb2fU1xXOiFQfHSakgMYhHKXJFFemg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by MW6PR12MB8736.namprd12.prod.outlook.com (2603:10b6:303:244::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.53; Wed, 17 Apr
 2024 22:52:25 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::57f3:51f5:d039:ed24]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::57f3:51f5:d039:ed24%5]) with mapi id 15.20.7472.037; Wed, 17 Apr 2024
 22:52:25 +0000
Message-ID: <80c56417-3d74-7d68-1228-9cd944567b4e@amd.com>
Date: Wed, 17 Apr 2024 17:52:18 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Reply-To: babu.moger@amd.com
Subject: Re: [RFC PATCH v3 17/17] x86/resctrl: Introduce interface to modify
 assignment states of the groups
Content-Language: en-US
To: Peter Newman <peternewman@google.com>, babu.moger@amd.com
Cc: corbet@lwn.net, fenghua.yu@intel.com, reinette.chatre@intel.com,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 paulmck@kernel.org, rdunlap@infradead.org, tj@kernel.org,
 peterz@infradead.org, yanjiewtw@gmail.com, kim.phillips@amd.com,
 lukas.bulwahn@gmail.com, seanjc@google.com, jmattson@google.com,
 leitao@debian.org, jpoimboe@kernel.org, rick.p.edgecombe@intel.com,
 kirill.shutemov@linux.intel.com, jithu.joseph@intel.com,
 kai.huang@intel.com, kan.liang@linux.intel.com,
 daniel.sneddon@linux.intel.com, pbonzini@redhat.com, sandipan.das@amd.com,
 ilpo.jarvinen@linux.intel.com, maciej.wieczor-retman@intel.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, eranian@google.com,
 james.morse@arm.com
References: <cover.1711674410.git.babu.moger@amd.com>
 <f7dac996d87b4144e4c786178a7fd3d218eaebe8.1711674410.git.babu.moger@amd.com>
 <CALPaoCihU+mat2A-wNtTm=qbpya8ZqhDURsfZfjuHitch0WrLA@mail.gmail.com>
 <9d59d38b-af1a-46d8-81c4-b426d47d4ed6@amd.com>
 <CALPaoCgFEybS5MhsPx4EaJmsfBe8Es_6QwWBXpoctdaNf0NcMQ@mail.gmail.com>
From: "Moger, Babu" <bmoger@amd.com>
In-Reply-To: <CALPaoCgFEybS5MhsPx4EaJmsfBe8Es_6QwWBXpoctdaNf0NcMQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0P220CA0030.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:610:ef::28) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|MW6PR12MB8736:EE_
X-MS-Office365-Filtering-Correlation-Id: 52b85099-bf99-4bd6-ba0b-08dc5f310c9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R09VcEpWMlowODBkNDBWeVdVM25aTjFtUGtSQUtrTTlPWHRTS21vTXVVU3pw?=
 =?utf-8?B?YUVDbHZiQXNUZWZoYWVoVG1lRXE3ZzR6dGJjR3FvVy9KQVU1QS8zYjFPYzhv?=
 =?utf-8?B?WEVWbmlhZlhzT1dKdW05dHhBYXVJdDRZTmx0aUNtdEU1SzBxdjFpMU1nUUFp?=
 =?utf-8?B?RmgycXV2ZUVBNFZnS09CaHpqWEpleFpWMU0zSVBLWjd6eWhPc1BEMlFiVE5k?=
 =?utf-8?B?NGY3NzZ6ZEMyTkFmNUxaeUhtL3RtM0JOMzV3d0xXM1RFOHB6cEpyc2JKZ3lr?=
 =?utf-8?B?ekI4SUpvMEhNeWNoUHdSZSt1SEc0T3RkbW9zakZhOUlEamcvMkJ1aDNQQUlk?=
 =?utf-8?B?L1M1QSs0djdDU0VCN3VGSG1PUmJGYnBzcUwyQjlvdlBJUXg3N3Z6RWQ2YUJE?=
 =?utf-8?B?aFgwN1JXb3NZazdTVTFLVUFTOG1IcVV1ZzdleFVkVllWenRjZ0FrWERiMWVX?=
 =?utf-8?B?T0FLQkMrZ3EvVFlzdFhGU0FST1BaVjEyRUtkV3hLZWhmdUw0V0J0SkF1TVNJ?=
 =?utf-8?B?eTNHWlJ3UVJYVmV5NDRGbDd4ZEx1UEZ0dWhydHJXZVdYS3JVeWl1N2hBRlZI?=
 =?utf-8?B?eGhwVkNPdnBYYlFjWDR4cWJNcHlhbnBCeDhXK1VoS2pyL0FRMi9Pc3pTcVBm?=
 =?utf-8?B?MHpTeGEyWnE5N0hRK3pCRmFJelIvRjBWckdjbVZ6RU9BNEJvcWVjcGtvNVF4?=
 =?utf-8?B?azh6VzZ0ekhZZjI0MzNKSUFOUHY4ZjdyMXVGRzNRakVCQ25sRm00T05INTdj?=
 =?utf-8?B?eTZEcU9EemtoNFdtNW9aT2k2NHFLQ1VsalJTV0dOZy82azdDc1BZbGp3cVdM?=
 =?utf-8?B?NHNYS09Nbys0ZDZJMVpvanN0aTZWNUZrN0xlUjJPSGRmWUVjZGh2dzNGUW96?=
 =?utf-8?B?RDZObkFCclNWakhHcXZsTWxES1BsRlVRSndEMnluL1ZnNlA4NkJDOExLbHla?=
 =?utf-8?B?aDdzQlRyTjVTc2hWRUo0cVRyUmk0dWJ3dFc1VkIxNjNVaHFXQWRrTW9WUlkw?=
 =?utf-8?B?MTNxV3lSSkJMTVRoa1JvT2hKenFvYzl1R2V4MHJVQm1mTk9SbHdUSjJ2Wnli?=
 =?utf-8?B?dDRKcWZvQlZyYUlXN3NCODlEOG1oc0RFWUVIc0ZSKzR0VDJoOTd2a1FEUnJu?=
 =?utf-8?B?SVhaQkl2RGIvNmk2UFlDM0VIT3k0ZDk5Q3VzcmRsNmszRXF5YkZjR1h3K1k4?=
 =?utf-8?B?Z1I5ZUh3dm16LzFxKzFpRFh1VEZ0OGx4YWFGY2dZczVxeHRSRHlRRmVobEwz?=
 =?utf-8?B?NHlSaGFZeHN0WmEvNjdQQzlwY2VoZkZQZkhzeXJMVkxsMzVtS29DTTFld3hO?=
 =?utf-8?B?SjBIMlJxRk4yUXZXdHJSemtsbEVZdnZCMDdUSVM1cmZJdGxBeHFPVGt1TDJn?=
 =?utf-8?B?M3MxZE5MaDZkMHcxY3pvSHJpajIrWTg4QlNCRW8vWmErY0VVSFFsRXZpbGlE?=
 =?utf-8?B?UE42ZTJmbFpxZXpEQWhoek9WeEhVVFY4VXgwZkcwTUxFVTd1T2FqekVSRnhr?=
 =?utf-8?B?ZExycWc3dklMLytMdFlieTZOeWtHYnRVSUtPbUNsMWVUWXUxVkVRZXh0bnls?=
 =?utf-8?B?dUl5dnJyb0J3VVlqNUVDTFBqdURXZzVyVVhZR3p2YkhDTWtlMXhJZWlOYkI1?=
 =?utf-8?B?UkpwL2V6RkdHUGlpaXAzZWNPM2U4WXB4NVEzcU1jQUZlT0JvY1BQT29oVWlq?=
 =?utf-8?B?N1gyK29ya0ROaUF5aW5ZTzJMZWFhRXgwcmpGclAyUzd6UFc3ZHd5N2JRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cE9FcEd5MDcrOUZyMGZta1VtTE9LRzduWTdyVjd6QkJGZGhPMWVna3F3akxB?=
 =?utf-8?B?R21UMmM5RExISmphckVHOXNockVtb3h6dVk5c0FUOWRycTd3bnRlOW5ZajFU?=
 =?utf-8?B?ZE11dU5KRWovS3lHWDJMeVNQenV6YXpRTFN1aXBobm9PM2FGVDZyK2ZBRGt0?=
 =?utf-8?B?cGZaRXNEZy9NNW9MVFNMSUVqbzJldUdRT0xqd3hPb3BuNnFreFFiY0U3Q1Zt?=
 =?utf-8?B?Y0VEbmxxeEN3ZWREcTM0bWljdXRSL092N0Y3c2diZkZvQUhUanJYdUtXTDdD?=
 =?utf-8?B?aXJmcVkwN29Zd2lLRWx3Y29rQUxxTU9HdDd2MzA3dXI3OVAxdzgxdUorYkIx?=
 =?utf-8?B?RHk3VGpram9KTDNlTEorRU84UHpKazRyMEZYQytVYzA2dXNpR3BKanlFd2Np?=
 =?utf-8?B?anNXclFLMFU3MmJBblkvTFh2WktPUzdxZFhVZzlOcThscWNnSUlqdk9HMjBZ?=
 =?utf-8?B?Y1dmRXM0TU5lclUvOUZLYkRzUWhRbWVLV2t1UkhtRHgrZUZIVHhBYS9Qcno3?=
 =?utf-8?B?bndQbm4yY0pQeUc2Z2lEcVBqL1lVNjAwNVlHWEhUQ0VzN3lLSVZCVW95Tk5z?=
 =?utf-8?B?Ri9NcFRDM1FQdTVaczF5RDZINDllOWp4K2grTmxBQTBRd1c4anVZZmppd041?=
 =?utf-8?B?R1k5cVNYU1lSQUZ0eEhnZmNtUDgrdkFiTzMyeDNSVU02MjJmUGRkNEczT0JM?=
 =?utf-8?B?Nzc3QUkyeE0wRDR4Zm94MDhVaWNBRFRBY0dLMXhQank5bU1jSVZtc3lxRzhQ?=
 =?utf-8?B?Y3ZPdWdUODlsNE1lYmpySFJ2ZllWTFFBZmF3SE5UMVg2NTg3Z0hRMTFNWWlW?=
 =?utf-8?B?eHJRNmIwTnNBTVZWa04yTjFuTlFwMi9lblFna0hiRVo1Z1dUNmkrK3l4N3Bs?=
 =?utf-8?B?bGsyTDdmeWt5MjRJVEFKZmFOVG5KTjlxeGsvcjRST1B1eEhzVERMSkgvWWlj?=
 =?utf-8?B?K2Jka3ROSStPVmJSelFoM0VhRUR6eDVTQTNqaUw0OThtQUJReWM3TzloUVg0?=
 =?utf-8?B?Wm1BVVVqWExJR1NtNm1JeGNmTjZqVXVrRVVIZWlSQUlxeng1Y1pVUmdxNkk1?=
 =?utf-8?B?bzhLeU5mN3BjLzM2Nmp5ZE1PT1lkbDd6QTJvR09TZ2VJSTJkT2g0R1VVdFhD?=
 =?utf-8?B?bjBmMzI0bGVEWjJQOUUvWnBWeVd2L3NibmE5aWw2dnViSEV5QTF2SURFdExK?=
 =?utf-8?B?UWJIUS9LSGRGSmd5bHFxRU1EZzZDSzhyVDF2WGE5WjAyR0gzOEVZMDB0bXJE?=
 =?utf-8?B?OXkvWkFkUlJqdG9Xd2J2azM1TitNS3JhQ1NJT3BJcm5FOEZnRnVFMlRVZ1NQ?=
 =?utf-8?B?UDZrbTQvNWwxRXAvUUtKRmFhenk5MGI5bWFydmpoN3VtVjBSTkMyd1d0MVRy?=
 =?utf-8?B?UGU4aldqMlRvTTJmRVZNUkZsTktEWjFnTStZRmtBSFd1VU5EcWF5Q1lWbkh3?=
 =?utf-8?B?QzI1ajF6blVXejZZaVFnMkVhS2tsQzdsanFjWWJyVDJRcEI3K2ZTRzZhcEZU?=
 =?utf-8?B?WkpzQjZueDRwb0ZMSE1kQmNnUFdLQjJkalFlN1pXeThnU2ZaNW96UXdXTDlI?=
 =?utf-8?B?azlnVGlEeUpSbW1HNjFBSDRWbU1qUDd6eFl3N2huT2V6S2JycHp0SXBPcGVP?=
 =?utf-8?B?NFhtRlhRalMrSzRJbktwc0ZrdHI4bVQrQ0padEYxalFPRWtRMjJnRUplM2VJ?=
 =?utf-8?B?VEYxbUtGYXVoQ25aTmhDVXhNV09LamcrdWhlSWU4L05LZWZDWFNwOHZOa0x5?=
 =?utf-8?B?bEhMckYycm1VdllDNFUxTHpDRmUyV2Q0bkZ6dUhUUkxlMlNSM0Jjc0pMa0JS?=
 =?utf-8?B?QnlLZUpSaG4wRTUyTTRpcXlQUnA0RnlNYzhnWlZBRUExTUFZR3J0T3o3enEv?=
 =?utf-8?B?MitFeks4ZlBFVGhldlFaRDJHbm9yd0VnSHNzajZmZTcvdGJSUi9LaDNBVjlB?=
 =?utf-8?B?OTFnNmFvU09uN2dPSFNhZUxCaEJlTmJiUmxSUCtvc3F0THo5SDR3Z1JlTWNj?=
 =?utf-8?B?NGpwcHAxT24yb2ZTZzVTcjNDalFXR1hNZTllVDBLZERYOFVkZThHUURGU2lj?=
 =?utf-8?B?M0tLVlg2VU15VTBpQXZ4UlBMSGg1dlQ0U1JSNHZsOUd0YlZDQjBBc3hWSmxi?=
 =?utf-8?Q?bDmoBrDUmpgPwAVZOOxYSboyh?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52b85099-bf99-4bd6-ba0b-08dc5f310c9e
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2024 22:52:25.1015
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 56eMDw3xolp9YNCDWp1iO7wvEYG5jfknghgPh6tNQ1D3LbCK7SxwzdYBUt7T5Rpf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8736

Hi Peter,

On 4/17/2024 3:56 PM, Peter Newman wrote:
> Hi Babu,
>
> On Wed, Apr 17, 2024 at 12:39 PM Moger, Babu <babu.moger@amd.com> wrote:
>> On 4/17/24 12:45, Peter Newman wrote:
>>> On Thu, Mar 28, 2024 at 6:10 PM Babu Moger <babu.moger@amd.com> wrote:
>>>> diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
>>>> index 2d96565501ab..64ec70637c66 100644
>>>> --- a/Documentation/arch/x86/resctrl.rst
>>>> +++ b/Documentation/arch/x86/resctrl.rst
>>>> @@ -328,6 +328,77 @@ with the following files:
>>>>           None of events are assigned on this mon group. This is a child
>>>>           monitor group of the non default control mon group.
>>>>
>>>> +       Assignment state can be updated by writing to this interface.
>>>> +
>>>> +       NOTE: Assignment on one domain applied on all the domains. User can
>>>> +       pass one valid domain and assignment will be updated on all the
>>>> +       available domains.
>>> How would different assignments to different domains work? If the
>>> allocations are global, then the allocated monitor ID is available to
>>> all domains whether they use it or not.
>> That is correct.
>> [A] Hardware counters(max 2 per group) are allocated at the group level.
>> So, those counters are available to all the domains on that group. I will
>> maintain a bitmap at the domain level. The bitmap will be set on the
>> domains where assignment is applied and IPIs are sent. IPIs will not be
>> sent to other domains.
> Unless the monitor allocation is scoped at the domain level, I don't
> see much point in implementing the per-domain parsing today, as the
> only benefit is avoiding IPIs to domains whose counters you don't plan
> to read.

In that case lets remove the domain specific assignments. We can avoid 
some code complexity.

thanks

Babu


