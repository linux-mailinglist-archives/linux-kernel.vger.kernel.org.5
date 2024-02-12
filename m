Return-Path: <linux-kernel+bounces-61072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 901BF850CED
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 03:54:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDC151C220E9
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 02:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D64E33C0B;
	Mon, 12 Feb 2024 02:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ppcJ4bXA"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2084.outbound.protection.outlook.com [40.107.223.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C137EC;
	Mon, 12 Feb 2024 02:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707706478; cv=fail; b=t729JKFmvK05lT1wpgZsylWdZsUzd8Xij8fmlABBQjNSQzQNJEE2GC6oKdqHcRn+abSsavaUlfaaC4tKfVGlYtLSyGLF/7wWY/zr52LwGSA2aI46nQ5Mi+rLAVwIZfxSHHgxaocjDJD5zlmQS+4+YgIUQZ/qo0yeN9YBH/oiMU0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707706478; c=relaxed/simple;
	bh=w/FsgYtmUYd1gteGAH1euUzadoKpr8m/7hs1mtTxWWY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nT3qPFKWSWDrFXgLTRZmgSzFFIcDeUt6koJNyEjq948d6+LGFHgkHMTcgqORdN2pEzoisQM2o8oVtkH6P+ZgkSN42hYoL6g+lbckqQJ/6YFCoxZewDLcAHH4Sbi63sGKg8hyYMYkh0zqUPBdpg7zCesjzDF9/TTlFiNlAuF1O0Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ppcJ4bXA; arc=fail smtp.client-ip=40.107.223.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=njSvz6zEoZVGv0FVRG54xXV55K4+iEWgpytksyHRytWnccJWCN57U9tWjo5+N/RnSHIUFomsvMZHw01c3p8dROyn9M7LovuGV6EHa/gEck4NzMP8OSU8V2jsrgH2V0SF+yzpZEnveAEJQ6RdJ1UOxTeUnqe2oAabCy2lbdS9/T9aC1F09h6HKqp0emEK5Ee9G10+VWRMET2b4p/Ef7R64h4n7GzhlRpP80VK6jEtBu6cD9s+murr4FbKMnJpj41ygXlxWIhMIdhSkk9VI6fpLWzP3BuytEGcXc3DL+BvQ8cMcxbyjd9cKV1AWRIlDktkoWTxlPylTNgunvXxw/Ka4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4557BuXjuyhjvdOLEAiPKPzmUmGwdnPC2ypej4SdvCQ=;
 b=lYgNqIP8rahpaS+BdibmRQmvJmJxfL405qjAHrJJ7gqGnvXc4KAO+ZxRdusymnjKfIKvQ2xiQuOwUkbb+PLj2Z7LAWbEZ+8SEHHniSNC6gTtiJzDTUKRF7ao9oC5lRmT6BrZ3CkCbLlBatnvW6KvYaVXFOYoyU+tpZyYFyDtnwNSvU/hJTcDxUs8k+1F7bqv33D1EVUnz9X4uAtAmipypZBL2bGzuBYMilzcYqx17GGAApMeXhS1bjzU0bamC4wvR/Ljd/zjytcZHmA2nqj7oIA3WNpdzW8WcOZu7T3Byl+plRMamAIIzO9Ky7N8seSqdd3o7FjN/g9/Izsiq3icuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4557BuXjuyhjvdOLEAiPKPzmUmGwdnPC2ypej4SdvCQ=;
 b=ppcJ4bXAgNfkiPdC8/Q8wXjIS/KAsHqeBK23jCvbiacnmVSP6nxFCG50Z+JN3+vRSYZe1V5x1Qizt0G6eUB0AupqJ2SYlHcZqxZxLQjV6tfY0TacFCPvT/hUvcXCA8bTpu6Il5AO4GioAFGAlzJn8cCVECPjLaB7bU9bSqibUZA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB8403.namprd12.prod.outlook.com (2603:10b6:610:133::14)
 by CYYPR12MB8731.namprd12.prod.outlook.com (2603:10b6:930:ba::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.11; Mon, 12 Feb
 2024 02:54:32 +0000
Received: from CH3PR12MB8403.namprd12.prod.outlook.com
 ([fe80::ea0e:199a:3686:40d4]) by CH3PR12MB8403.namprd12.prod.outlook.com
 ([fe80::ea0e:199a:3686:40d4%4]) with mapi id 15.20.7292.019; Mon, 12 Feb 2024
 02:54:32 +0000
Message-ID: <774e7ca5-154d-4ca4-bc4c-2f945c20b938@amd.com>
Date: Sun, 11 Feb 2024 20:54:29 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] x86/MCE: Add command line option to extend MCE
 Records pool
Content-Language: en-US
To: Borislav Petkov <bp@alien8.de>
Cc: Sohil Mehta <sohil.mehta@intel.com>, x86@kernel.org,
 linux-edac@vger.kernel.org, tony.luck@intel.com,
 linux-kernel@vger.kernel.org, yazen.ghannam@amd.com,
 Avadhut Naik <avadhut.naik@amd.com>
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
From: "Naik, Avadhut" <avadnaik@amd.com>
In-Reply-To: <20240211111455.GAZcisL09LeFPWa2EI@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN0PR04CA0187.namprd04.prod.outlook.com
 (2603:10b6:408:e9::12) To CH3PR12MB8403.namprd12.prod.outlook.com
 (2603:10b6:610:133::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8403:EE_|CYYPR12MB8731:EE_
X-MS-Office365-Filtering-Correlation-Id: e488e471-9d63-45d2-1be1-08dc2b75f06b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	21h39LaDNqFtTQ24VfkD7Syu+0p3c6YbJUchGFKt+AkCX8yDpqZMwIM9rrWPkEBDrB3SpwwYXAvT0U5agib0uMf8DqkuKn3lxF6CnoND9ctFgFi6isRS7rliqiHh932rF+R1kuLVenZ2+tB82Ya77C6WkpvukL5iRdgP9dEoixAY/y5onZM2tdhVaq2TZ4n/5/K1RQ3nrqwBtR3vTxCe9A6ViPetBhTQh7kqZCNwd3qvP9JIm3aanHEDNQwSiB5tKdEJesCrVhbWq8O6AF0bYVIvod+iSJZrJr6/enX4cKsU+wN5R9Q38S3HmlM8lV7bsm/g0q16EGITg1VZsL7uVKOKgJgwMdxxC8UAw5g25dvF/p2HBjaLVH1tDHmXkJ57AIDEX76DQlf/ZZVllp1XoH8qEJ/1eyNILYta8qpE/1zemtiRPk86mdpdv7cA+ythYN1wCCXiN1mvLTpC+2BtcEr2ntgbXy1iZT84nOYa+l7i1dwBoPH+TKDV4ejlHGMs/9oKGDnfx2/VSq9oizGcBYU+e3uS39JH8nq2U/3das8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8403.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(396003)(366004)(136003)(376002)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(31686004)(41300700001)(478600001)(6666004)(45080400002)(6486002)(26005)(83380400001)(66556008)(6506007)(2906002)(5660300002)(66476007)(66946007)(2616005)(36756003)(966005)(6512007)(8936002)(38100700002)(53546011)(31696002)(8676002)(54906003)(4326008)(6916009)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UHEvTkRNeXlZak5vR1JSSExaRXc0TFo0Qng3RS8rV0FTU2FVVjBpamNlV2ZV?=
 =?utf-8?B?alVZSVMvbjVvdEJxZ251MSt1RktrT09jUys0UUMyMVZPQW8zMmFNVWhSZTZ2?=
 =?utf-8?B?VzBjZVhrMjRYaXg1YXZYWVVNWXpMcnQzb3pHbEdjOEhRM1hSNjlLR0NrTFpW?=
 =?utf-8?B?VlRETGFmUlU4L3JNeGN1OUJYZ1U4dkJBSVVGUDJWNzU1WHFPME1PMndiak1k?=
 =?utf-8?B?emVtZE1BLzJHK1h2KzM3WitVTEJLZUdwRkRHOVR0L3BzMkY1ZjcyZExSWU05?=
 =?utf-8?B?TFZadzFzK0dPVExlcVhBZDZSQWdPMVJrOEhDK2kvQmxkNjRCUzZhQ2VzOW9l?=
 =?utf-8?B?Tk1NWGtUenJjN3B5dEV5MytycDNmY3dSOEJzQnhUS1BHdFpRWWtpTU4xc2ZM?=
 =?utf-8?B?TkxtWlU5OXk2aHZLdTNtZmlROWJzK3ZaU0IvbFVVdnYybFl2ayt6ckxMVWcr?=
 =?utf-8?B?RUZJbGdXQlBRbE1VeWl6ZHZ0eXFwaitGRFFkN3pHanNnbS9iSmkxQmVjVmRY?=
 =?utf-8?B?TTFpZ0hGUUlId1Y5QW1HQnJqZlpMMFZXVzlyS2RmQzdtYjVtdndZUWVxcXBx?=
 =?utf-8?B?V3YyV2YyNjIyZ2ZFazVZOWZiaUd4b1duOVVJT1l0cllPYkNSM1Q4ZHRBYnFV?=
 =?utf-8?B?WS84a0F2b1BMME5wWHhnOHFJcEhmQjdsMG5NSDRPRm95TGV4SVFhWXFuMDQy?=
 =?utf-8?B?cjZxaWxRa1JNdEFjS2o1Nkw3V2xFM2hzdlRidWxZdzhyclQvUHB3WWFPUjRR?=
 =?utf-8?B?TTQ4cENWY0JiSEpRbTV3UE1YYmsyUTFyb094UXlZUlUyNnpVaVNURUxoa3Zt?=
 =?utf-8?B?QTBidkE4b2lzekJ5Vm9pQmN3QnZDNlVXWXFSUGpiRU1MUDV4UWRuVTNCRzNZ?=
 =?utf-8?B?MTkrU1NsdGdBaUIvYVY4ZGpFOUhCdjBQeDNkRXRpc1FSL2RwUXN3RjM0WDA2?=
 =?utf-8?B?THdjK3ZmUDE3b3RHQ2dqZVdJenJTakQ2Y3JTRGRBSGFsVEdTa2tXekhZWTNC?=
 =?utf-8?B?dzJ0VE9ESDhtbms1blY3Mzg1OHJkSFFHKzJCOVdQL2xUL2JXTzBoQXJmNFVu?=
 =?utf-8?B?ZTdZamVnekFGVFhUMFdNZHd6SjZKMjZJNThBU2hJKzlxbXRqTC91VUttTnZZ?=
 =?utf-8?B?OFIvUTBtMUQwTWVCTDBCMk1ZZVZnT295dmpKWS9zN2llTnJnbXd3RW5FSVpz?=
 =?utf-8?B?NStGMlRDVHlRRWI0aER3aHozT0Y5dnpHb2VwaExPVnBKZmlmdEptZEY0S2Iz?=
 =?utf-8?B?emlhUHYraUdpR21TTk5ZNTVjaE41cGxLRzBTcXFaR3RVYTgxY1kxOHAwL3lt?=
 =?utf-8?B?aHVDRlRHR0tUL2lmczN5dTBpTDZEajRnNEsxWGE2WTl0N2RrUUFHd0ZPWkFG?=
 =?utf-8?B?YmFRa2Y1T0d0eWVvSEF1YTNHb2xtM0lzVEhzcW5XazRDU3g2b1NEV1VXZ3ZZ?=
 =?utf-8?B?U3FNSmZlc2JEcy9sQnNRUkorUzJQOW9BS3l6VUE0Sy9lMXVyNk9XSGg5WkJ1?=
 =?utf-8?B?Yk0xc2ZzK3Mxc3VGcDVlbENNc0RLaGJVVTFHMFpYUGVzN1BIY1ZySGlneTl3?=
 =?utf-8?B?WVV4RTRRR2ZNTStlc29uenc5Q2VNS2IxUW1OU0dFS3ZFcTMzMUE3eWxORzIr?=
 =?utf-8?B?TkRveUhNaUhXaUcrQ0JiV0U2djN4bTdOY2kyNTM2RkI1clBWZm1LR0Z6cUNm?=
 =?utf-8?B?ZWdlL1pLbmhHSUJhKzh0SVdXU0ZVdS9seUZwNjJQN0NUc1FqT21DL0loYXh3?=
 =?utf-8?B?UUhVcGFSSFBUODBtK3AzZXpZOGIxajMrVXdZWFJYQ0dnUzZBTytMOWZKc3JC?=
 =?utf-8?B?NDJ0aHZ2TEJwTzAyY0xwMjNnalVPVjE3aVY2K25KVGt0VEdNY1l1NzMyNWtR?=
 =?utf-8?B?eUxWSGR4cnZnSEJrWlp0RitLdjFzYmVIKy9MY3dhYVdBTDZoL040dUpwSVBK?=
 =?utf-8?B?N0F0TmJ3UFJ1czBxbnJXOGRpYXhFNnVwdHR5eHFyUzFjVTNkOGhMVmI4M0hZ?=
 =?utf-8?B?d01xekhndWxSY2Z1U3JwNXdXRDUvUFIyYUNlWkd5Qkh1RnVEbWcyL2FIemRx?=
 =?utf-8?B?eFF5RG1KNjdzclZUbkxmZ2d3QXoyTE5jZ3NibzR2cXNlWGhDZEJ6bnJsakRL?=
 =?utf-8?Q?Vw+1jF6yxZtWheadoOtGkUAVI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e488e471-9d63-45d2-1be1-08dc2b75f06b
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8403.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2024 02:54:32.6224
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 96tw7I7IWMownOMoqxzTLdJLKpLp1NLXAzbxh6j9cAsMMTKKbKnYaOYFR+k+ATaIooKp/Ui/uX3rGzKXOu1dPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8731

Hi,

On 2/11/2024 05:14, Borislav Petkov wrote:
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
Okay. Will make changes to allocate memory and set size of the pool
when it is created. Also, will remove the command line parameter and
resubmit.

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
> Thx.

Thanks for this explanation!
> 

-- 
Thanks,
Avadhut Naik

