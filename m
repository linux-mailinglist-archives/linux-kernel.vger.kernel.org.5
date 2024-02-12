Return-Path: <linux-kernel+bounces-62224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B9D02851D39
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 19:49:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2072BB288C5
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 18:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C4BC482EF;
	Mon, 12 Feb 2024 18:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dgLmmAST"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F47E405FE;
	Mon, 12 Feb 2024 18:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707763643; cv=fail; b=CMbGtcFksdnQSDf50pQwTV7sZBBGURMuYqUyhorBxPkwps6NBHJ2BQ+CRHPrL4USA9XCbCqkxg1bvLAh/9Uww7uVelNusPT7zWZXbCLN/uGL8Z2xavGUMaS3LUhSHySn0Iu4gFa/+aPDx4gyBNiZqiG8CjqCT1i4IrpvOdSL0w0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707763643; c=relaxed/simple;
	bh=AhWXSFYmpL3E/in6vc6hqJYNG2OxtW0VsgW7y0og6kI=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=p7kVSg2prmgMRfdLE1LCkn9ypAwU1C6wPocNY+oRBr9wHOMd5b1ySbiKBTFFP8qFJkmncbddM+xR+ITjKxfdCbjQe1MDrp0mKdDp3CpxlAdUvug2hePHakUqiXYFyxQ/QBAGSIe5+w/feOZ7eKiSh2PYk8EytS0W5O2D2hAP42Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dgLmmAST; arc=fail smtp.client-ip=40.107.236.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FbNOSl6NUKN+UEiUkF2vZtTqcm3rV7EN/Qeo3MvYAgMWjI+i/sjVfRno+QryN1B7syjP4fSmZMb4ACrLVPqInUZ5l67epvQhEC2t3ZGyvkiHg94Fl1BV7w0nwFRzQGwNog5utYnRB0ZewZtD5crW8n/qc9Ch4gJlKIuzMLDHGA20fmfNLcOCdi4OAoRvVZ+xfJYJ5CNWi3XOyFXs9cuc3CgsArGX5m3UkRR/bScKgG5F2c3SYz6XsDrWwaWCIyFNerWD2YyckQJ8mDor8eDivS+pipEeKRnQes9NL6q2PbNLaNaPH4Ao7NkdXTANHl4KQTdSLthEsVv+pRt4LiR8Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Er14n2zdgULPDZh7R0TAnY1f6qxucWJZSoCym3rVJg=;
 b=Iwf37sIhLj5FccLP70DfA88COcskE+3AHBqdVh+gAWEv1CtbuGxquE9RqI3+2S+KX65kVIwNIkFGUXFhwvBVRZwqC7d8fAcujBS3JwFIQf6wl/PQpg7LI8MZ7cBeKUSJLfGGm24zYsWW5sLAwFz5CM71ZTIGBdXMlLCbuoMkMGat9FNzQ/qQbmG+2tEhrA3Kd8HzSKHPDqC1lKh/cSrAw1LCQ1luoZie0J6uHQgPEJeKWBPRoi31xeZkqre8WNUqsz0DXUU78dh70vrojlYtnRiDVYZEs/1Jl+tmdexCbIovSgnisiT5dzC64YKOVsL9DSAkR+b6LTLo+j5fVKfW4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Er14n2zdgULPDZh7R0TAnY1f6qxucWJZSoCym3rVJg=;
 b=dgLmmASTmwbSt+Hti6T1zdNUiFf5bmDZTk26jDvSbsZ4uR8icA36q/EDflFeTHpFliN6eQrlOcFm/SqiCLs2V79B65FYQPKHguEw63Vao6jvrK1RN5Sxrh/ZABZnnSoaCR4Snz7fRnnDACucYcC8LlYR4aJRj5hiayiobDrxKRE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by SA1PR12MB8920.namprd12.prod.outlook.com (2603:10b6:806:38e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.18; Mon, 12 Feb
 2024 18:47:17 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::3a46:cf50:1239:510c]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::3a46:cf50:1239:510c%7]) with mapi id 15.20.7270.016; Mon, 12 Feb 2024
 18:47:17 +0000
Message-ID: <b5904910-ed58-405f-9425-566383b48068@amd.com>
Date: Mon, 12 Feb 2024 13:47:14 -0500
User-Agent: Mozilla Thunderbird
Cc: yazen.ghannam@amd.com, Sohil Mehta <sohil.mehta@intel.com>,
 x86@kernel.org, linux-edac@vger.kernel.org, tony.luck@intel.com,
 linux-kernel@vger.kernel.org, Avadhut Naik <avadhut.naik@amd.com>
Subject: Re: [PATCH 2/2] x86/MCE: Add command line option to extend MCE
 Records pool
To: Borislav Petkov <bp@alien8.de>, "Naik, Avadhut" <avadnaik@amd.com>
References: <20240207225632.159276-1-avadhut.naik@amd.com>
 <20240207225632.159276-3-avadhut.naik@amd.com>
 <8b4f8ec2-7534-4f77-b44f-6728c699ff64@intel.com>
 <51255499-0b5d-45c6-9c72-f353bae83c0d@amd.com>
 <20240209200920.GFZcaGcOr757W9O3IG@fat_crate.local>
 <7a4945b0-322a-444e-a0ca-860a062a49c3@amd.com>
 <20240209205111.GGZcaQP1gb6C9m0WZB@fat_crate.local>
 <5DB0FF8D-C6DA-45DC-B287-201A9BF48BDA@alien8.de>
 <75ddf61d-8dda-47fa-9da0-24221feb22a2@amd.com>
 <20240211111455.GAZcisL09LeFPWa2EI@fat_crate.local>
Content-Language: en-US
From: Yazen Ghannam <yazen.ghannam@amd.com>
In-Reply-To: <20240211111455.GAZcisL09LeFPWa2EI@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0342.namprd03.prod.outlook.com
 (2603:10b6:408:f6::17) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3108:EE_|SA1PR12MB8920:EE_
X-MS-Office365-Filtering-Correlation-Id: 64c8159e-9e0b-418e-9169-08dc2bfb0918
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	txYQHMqKON6VFmuDQE6e8zP0GtUl3G4xY0uHVasHpl+rNbpC35Wpz52xTzQ/G0a7D1XK8XFg42A+lnLC3wE7S5/rJc2LpIxq5gnVxmFEyzMwYqhfZQz0jecVrls2cNb4QxsNJAo/8LO4N5eAwIa0IDDIZDf8/jn5GxNgZ7d1/v8Z6U+lmdoBS45jMeeLTkNt7GglPhmQQRQUyJcjue9ipelHvXoyjZld4Pcn0nJvrlAZcFgZUAgXLRbD+5oDP91cA1tU9jbT9TSgG2qW/43izYdWYXLDyUBOBtE/9OgInzfZs/DuPNbe9qcpKr6zoB0KT1NW103h/KsnQwg5YhLTKfALJ4mJEygX+46/sgXBhjXEo5xocp1KWI2T6VSfzlzOw0gkC9f6M8PxQojv2n+bWV0D5XMV1koZzGS75KdvjGFOdldO1/iGuLXm+oeFbs9UMm4qwjlJ6eKRUimAsft2W96Iuf7zJYCXsEl+7HxAMu62rd8zFyM62nuI1ZOtYQ2gOwYdrx6w2YGd5XN3wZAkSgSIabj8jglCWNrkoNGiE8E=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(346002)(396003)(136003)(376002)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(31686004)(966005)(6506007)(6486002)(6512007)(36756003)(2906002)(44832011)(5660300002)(31696002)(86362001)(66946007)(38100700002)(66556008)(83380400001)(54906003)(478600001)(6636002)(316002)(110136005)(6666004)(53546011)(4326008)(45080400002)(66476007)(8676002)(8936002)(26005)(2616005)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S1VMSnF0RXlhOXRlKzZRNWJrSGZ6R1FHZEdrMTBBeUpDSVBjdVRuRCtkeTdV?=
 =?utf-8?B?QndpSHhVaVdHNmVTVTRmdVpmWkEyR2U5U0hVVEFFWnZ0K2h4ZDZ1VzkxY1k2?=
 =?utf-8?B?S0hTM1pFUGZPZDRRcXVSeFFCODhZVUx2alEzdkhSd2tmRW9yamZHU0hhd0xz?=
 =?utf-8?B?V21KZmJ0M1RYOVpBUFJrUjZsUkVVZGxYNWF3dmJkdzUxNUhodk5UbWZQVkNN?=
 =?utf-8?B?N3VwMUZHd29qR1A4RjN2d1NDeEt0bXltZjUyVy9Bbzl2emZpZlVBNW5Rc1JX?=
 =?utf-8?B?WlRDNitPVHpEcmZ0YzR0VDFWdEsxaXgzdE4rRnF4OVlDdG8zemgreCtWYWRI?=
 =?utf-8?B?NjJXdkc3Ry96Z2syN014U01hUDhtbWl3U3p2VUt0aTFVeHFYUm1sWW5tQkdw?=
 =?utf-8?B?aW9GTUtVUVI2Q2Q3UVVYeWRGVlVla2YwVURjMnI0WTZyL21hZmF2MUU3U2lU?=
 =?utf-8?B?eGt5andxeHRROFRPZHdKN1E4YVlBRnp1eXd1NXA1cTFIUlErY21PaEFvcVJI?=
 =?utf-8?B?c2hvbTZwOXoxbkRFSXFwUGl6eGlSdlpuTk5pSGcyWDJjL1EyWnh5SitOS0RE?=
 =?utf-8?B?WnhIeThRSXFNSGxNT1UzUzl4eUFvQ2RNRzVEdGgwVzA1SEs2ZkNoZkRYNTh2?=
 =?utf-8?B?akp3bFlDL1RhVFR0cEpNUllMTWlDUWRraFpBQ0xFME44QkE4NFVScXdzUVZC?=
 =?utf-8?B?SG5hM0J0YzdNRUt0Q211UjZRM0R6cmxaOHdzWk95NHFkOE1WOGhqV2hBbTVi?=
 =?utf-8?B?MUx0dzZPK1lQQ1BMQjZmR3dwVjdrYzYyTnZwdnB3cU1CSHk1NnpaVDRHMjBU?=
 =?utf-8?B?LzNaOFFtVEJNK2RIRW5hcXVWY09xczErUnRhaWVteGZsSFM2UUlidXhHZUZx?=
 =?utf-8?B?dDNoR1NmZ0ZhUHo0dTBYRllhWElqQzRORi9MelpmQlAwREJSNVdzRktmR1Nr?=
 =?utf-8?B?VEVzNWxMUTZ4N3UxMmhTVFZ4Y1l4RjVFL3pXajdGTE1Tb1NoK25EaWJOOWVr?=
 =?utf-8?B?WTdWaU5QTTE5TlkveGNnTUlOR2lQQmJPbGd5UmhBNjJxMmJIL0RDVmtFY3pJ?=
 =?utf-8?B?NkRGMktOYlp0Q3h4U0VwM0hxVjNRZWRReHZwZEhoTWhPUkhMZ0t0dFExSVIw?=
 =?utf-8?B?UDRHTFdIZ1JUOUlGMit4RVhCcllRVTB2UUQwZkQ2UGVKRjJMeDUra3I3WFlX?=
 =?utf-8?B?RkRJTHJtMjdoamc4Q2oxclpLek1TditMYmJLNG1neXIrZGlnUnJaNFp6U01D?=
 =?utf-8?B?M0lTc2UwQzZRRDJXelNaRXphSTRvdVdLRTVrVU5PZVdzclpoZ1lpTGk0OGRZ?=
 =?utf-8?B?dGhZbjBXT0RNK3FKRzRYay9zclJxR0krV2Y0bnNXeU9PU2RDQUNOUWpyeGdK?=
 =?utf-8?B?di9EVmtBREhkU2RabTM2OWdlOFpGSDVjRXZIbGFydjRSWHJMMk9MUmM5WURF?=
 =?utf-8?B?NjVLY1dzTGNoN0pPMzdoT3M5RzJBM2MrRFFjeW04L3FWQ3dTdUdGUnJndWkr?=
 =?utf-8?B?eWYrWkkwczlTbUJKa0ZuYVhzc0lVN0xwRUlJM0I3VWNqOHMzWkNDL0RVOHFu?=
 =?utf-8?B?L0pDcXZvazFqaXp6MHY0aFR4VklyMmVpL2lIMkpkd1huVFM1RkVxaUZqWm1R?=
 =?utf-8?B?aUFwU0EvRnBGb05ZQW1zeldhNTFCR2U2Q0M4Q203YklQQ1EyRzQxSUF3Sjlm?=
 =?utf-8?B?cHQrT0ErWTdWVXlFZXlMUjhLeWMxdElnMDVUSjd1ZXZiYlJrV3NIazkvSWVF?=
 =?utf-8?B?ZGEwbUE1bHg4VUtaU2tidSt3M3ViUjZQOG5MVnhIMmZmL0p1R1NodFFwNGJk?=
 =?utf-8?B?OVFhMkZwWFdNTUFDQ0ZnQm1FMS9CT3h2VjJLWHlXdGo0OTFoa3ZvY0ZLWUhi?=
 =?utf-8?B?ZURvb1lOV25KUUoya0k1U0hxUzZWKzAyRFNVMXhDODR1WFBqTUZWQ2RMdDhW?=
 =?utf-8?B?cjM1YWcwWlk2YWU1WkgxZGc1cXZsaFFRL1c3Tjdmb3hmQzVoRDhiU08zTnIw?=
 =?utf-8?B?aDltdmtYY2tYZTJlYlhEUU5POExNRnM1WXkzNHRjR0o3NytrSGwvc0F4MHdq?=
 =?utf-8?B?MldxRkRpd0xRYTExQnZvSDRMS2F3VWxIZG02LzdsS0tvcjRiS1UydkVDK1Fw?=
 =?utf-8?Q?K2oakPy4RyIS08BwS0uVLNDI1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64c8159e-9e0b-418e-9169-08dc2bfb0918
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2024 18:47:17.0642
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B5KORadjW0EiEcVNh8LltNxp+Bxi3wG+d0pswnKl41CTkIpiJBjvT8thvHWGUxGJP14q4g6u9QXDp0mrbYWG8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8920

On 2/11/2024 6:14 AM, Borislav Petkov wrote:
> On Sat, Feb 10, 2024 at 03:15:26PM -0600, Naik, Avadhut wrote:
>> IIUC, you wouldn't want to extend the pool through late_initcall().
>> Instead, you would want for memory to be allocated (on the heap) and
>> size of the pool to be set at the very beginning i.e. when the pool
>> is created (~2 seconds, according to dmesg timestamps).
>>
>> Please correct me if I have understood wrong.
> 
> Nah, you got it right. I went, looked and realized that we have to do
> this early dance because we have no allocator yet. And we can't move
> this gen_pool allocation to later, when we *do* have an allocator
> because MCA is up and logging already.
> 
> But your extending approach doesn't fly in all cases either:
> 
> gen_pool_add->gen_pool_add_virt->gen_pool_add_owner
> 
> it grabs the pool->lock spinlock and adds to &pool->chunks while, at the
> exact same time, gen_pool_alloc(), in *NMI* context iterates over that
> same &pool->chunks in the case we're logging an MCE at exact that same
> time when you're extending the buffer.
> 
> And Tony already said that in the thread you're quoting:
> 
> https://lore.kernel.org/linux-edac/SJ1PR11MB60832922E4D036138FF390FAFCD7A@SJ1PR11MB6083.namprd11.prod.outlook.com/
> 
> So no, that doesn't work either.
> 

I'm confused why it won't work.

X86 has ARCH_HAVE_NMI_SAFE_CMPXCHG. I expect atomics/caches will still
work in interrupt or #MC context. If not, then we'd have a fatal error
that causes a hardware reset or a kernel panic before we get to logging,
I think.

Or is the issue when running on the same CPU? In this case, either
&pool->chunks was updated before taking the #MC, so the extra memory
is there and can be used. Or it wasn't updated, so the extra memory is
not available during the #MC which is the same behavior as now.

I need to look more at the genpool code, but I thought I'd ask too.

Thanks,
Yazen





