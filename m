Return-Path: <linux-kernel+bounces-119167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A3B588C508
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 15:22:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3B272E1174
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 14:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05F7A12D76A;
	Tue, 26 Mar 2024 14:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Q92Mjw3g"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2133.outbound.protection.outlook.com [40.107.220.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 816416CDD4;
	Tue, 26 Mar 2024 14:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711462933; cv=fail; b=K1LGaDFb9BDNcMFR80r/LnVgaDYb73JUMQvaApXnnv2aXZYg+6GYq+LSlC0eTcoqSSN6eBFnsGBinOEmZnsV9FKZ8+5XqbA6KJGF4N8hbu0NEwfd+f0nT+hnPh/0A9V4fy2NhHGM0nOl9ARX3tYnFUlo0G7AElg7lSyILKu8gEM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711462933; c=relaxed/simple;
	bh=s9zsoTzeM5/dAE1vsH4j1Mcx/UPBwqU/gnVWzhq8Clo=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aPZmBvq0VYTwupRszOtoCOwf9KkBSjJkWzmY/tMZMddvv/xde8cT6/QKb4DeuVP+JGdZUdqwYb5rk9ZKZ2xyW1IWSRSnOA5G3RJsdwZH4+xlG4zRUI2XjZHKtf/6acND3PSXY++wunbCK/ame3F8R8/3E0CvbbSs3yVqMPfyfZ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Q92Mjw3g; arc=fail smtp.client-ip=40.107.220.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SV11hfcMzYywx/Ag4VwwTixvThbjitJPLwbJqe9ZRIApWomI0kF3c0TNoy75URo3mNgMK0/OJ+5PuPNIdqsdH9DQefSmwQY5zXo+LvcyIOK0ARET5p1d5ta/etU/rOsuc2lPgeDrGCZFy9qPHsfiW1ZWOsSSHkHX8/j5dKeczjcpnWndoBzpNf0rRa59qVmNyd7SYmxZ13KSy9EwkaS48QlygUan2429QHZZBRAXqpV8A7PWSRJY8F3qHW9tFTMy3uMblqpCon2/WFWjC2JXVNu3uIFz5Nv8TPjkz8cToDXDuf95xDMP7Qws2k0qWfSnSjiwC8iYsAi7cXU/Apco8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NJtq3FJKK70zfIMjfGu1M+wC+WeIAypGEC93OKaSYSc=;
 b=SPzSGUnloyVZshZku7PdGxqUPnPnOhN9p2WM+OPUsBRvpNkytmgyeNPggj3uQVKK9KGTuCxyBG82qaJgHH/g7tycpNW2nUve6xyEdokN/u8ZlcZBU//FXjmp5e4WHUh4bhS+PQHfvQCtXe5erNbXGUatNeLOsPAFU49/grXbFTFQQJzi+6IZxMjww3YAbSuVv9LPfuG6PbJDU3yhcSRDmp7MZXvn/jN1H2b5eH3+I0PBfsF8ntaIL9nSfHolVPB4LNo2hS6tMua+i1qzO9lt/qWEg5cES/iul0UkcOoZTwOYEZbKdnHFQeMrvJHt0XFRuz7177BANqky2OA7x7OBig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NJtq3FJKK70zfIMjfGu1M+wC+WeIAypGEC93OKaSYSc=;
 b=Q92Mjw3gDgBXDNyLtb0HsK2UoKCr47Fp2vzh0I72vlVh7/jAoPAg1Z0afLywpjSf87uaqf1e4Z6M5/DtvbwR17rjyZRhOhx2w/9Y1hkmAe9wjWm9CXVqCosaml0C1rdU9IUrBDOz1exTi+7jHAJe4ULjPEujSTeAYvR2cABv1EU=
Received: from BYAPR12MB3109.namprd12.prod.outlook.com (2603:10b6:a03:db::17)
 by PH7PR12MB8780.namprd12.prod.outlook.com (2603:10b6:510:26b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Tue, 26 Mar
 2024 14:22:09 +0000
Received: from BYAPR12MB3109.namprd12.prod.outlook.com
 ([fe80::b2b4:a3f1:a86:d6bd]) by BYAPR12MB3109.namprd12.prod.outlook.com
 ([fe80::b2b4:a3f1:a86:d6bd%5]) with mapi id 15.20.7409.028; Tue, 26 Mar 2024
 14:22:09 +0000
Message-ID: <adacb412-a043-4512-a8d3-1a0f6f40e9f4@amd.com>
Date: Tue, 26 Mar 2024 10:22:05 -0400
User-Agent: Mozilla Thunderbird
Cc: yazen.ghannam@amd.com, linux-edac <linux-edac@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 "anthony s . k ." <akira.2020@protonmail.com>
Subject: Re: [PATCH] RAS/AMD/FMPM: Fix build when debugfs is not enabled
Content-Language: en-US
To: Borislav Petkov <bp@alien8.de>
References: <20240325183755.776-1-bp@alien8.de>
 <eede2586-f143-4107-a065-2860ed413d0a@amd.com>
 <20240326140759.GGZgLWv3UZVpHZ5c98@fat_crate.local>
From: Yazen Ghannam <yazen.ghannam@amd.com>
In-Reply-To: <20240326140759.GGZgLWv3UZVpHZ5c98@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0435.namprd03.prod.outlook.com
 (2603:10b6:408:113::20) To BYAPR12MB3109.namprd12.prod.outlook.com
 (2603:10b6:a03:db::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3109:EE_|PH7PR12MB8780:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	g8ITHQBR5lEnCw3P8Xbhy956EHLZy0fgPfS7x+WSbHfPJh4EZX4V9CbiX6ayiPd5v32oLfzZyk0lKr8R57ItgacfPS+hJd4ecCq4bRTDQkJjWnECWGhCz1q4tljrGt8Ra+hcXb3ar2qm1FERxHxwlr9ajN6LWdfA0sSZoBjc35DCKzxbqk4S4d9OJFDjW2JgjCgWFVtS4yCeDpgkxDzq5ICTviU9/CUr/P569s1sIkTNAGjh+HDj/4I3BasOy8gB/ldtEHgtnMpOSRLar/2yVBTX5TsQaa6JVxzMO+Eozj/MX8glHhy4SMmXtrdwCKkTa+gPBhYAgKxBj4jV8f7UHeGAxHU/6HlRgF9VYIKuyTj2LRnZryH426KVQSUzcHOnaJdofCYEYGHLKsWKzhizwEMsIv+aASjWn+axT5C+C7FxMQ8xYvMeZc49Mxzu+k4YfyhjwtEnDM1gjxWC4dWp5YE+6zoOf+DqyutGA2fX5jYcQKL3Lmhsnfy9gsbGnNFoLPz+ChZCTKJb8W6HXWndNCHzinlOuGg233j02/Uk2gQdlmj3id6Gw/N0D1TU2AhcqWvVmd+1IiOhhRD7HLqsPo8MpMxQff58Yg9avwr/DZJOpmxoCxnxIV3QUOGnrHXcJMr7eKKzyl4n0awFkJh0eWqoTIzHBjbb7fZTHjzUbuE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3109.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dyt0RWdFOEdCZk1OVjhZMkpHUC9uRkxtQWdIWVhMZE1saVM5ZXRmNlF6ZVU2?=
 =?utf-8?B?bUVSUC9RUWovbSthQVVNTHJ2V1lHeFlNdkxHdHFhVXB2YjhuOHZwc0d1ejZQ?=
 =?utf-8?B?YzhGZGdmTytwVER4bE5OSVZkWjZjNlJVZlRoUmpiWkFCN216ZUY1dXpFYTEv?=
 =?utf-8?B?aitZZS9rcllHMVE1SGZIRC9VUGRGK3J2SHBZWFhzMmNGRWl2U2pSczFuWFha?=
 =?utf-8?B?WjVIL3VsYjdqYVpENnFmc1U5aVdOR2JBS2FINE9wT3lpUHA0QzBlRG0yTDhT?=
 =?utf-8?B?Z1lYWHJWdDBOWHZFUDhRMzh5SkY0bWtZTWZCM0hDbFBrVUlCYjZWUWNCNElL?=
 =?utf-8?B?VnB4NlZKc0x0bnJNbEZPWXZkZEhqUUtTM01jVWdrSlY3SlJvckpyVStXRXdi?=
 =?utf-8?B?L2t6M2w3UkI0ZkVzQkVUR1RLM0wzdHd6Q0dOM0dFN2ZTNm1zZ1l3djhFZlV6?=
 =?utf-8?B?Z2F2STJHVW13aUxTMjdJNldsWkNKalF3Q1hXWEtSK3l4K3ROWjVrN0dIQXI2?=
 =?utf-8?B?NDREbTFTNzk2WHBGNkV2bzNCbTVCSkxPNG9vblBPYy92ZXQ1aERTcUpxd2M5?=
 =?utf-8?B?cGhrY2ZVQVY0UWdKWkI1WHhySmxzWDByZExGZ3UwTEdpY1VMSEZUemRqZU9X?=
 =?utf-8?B?MGp0NHMwSWN5Uzdna2RlS1MvNkw5Q3p1NHVUZGUyY2FTYkd5aUxBWVBrMHFW?=
 =?utf-8?B?Y3I4MERBNjk2emg2RGJIQ2tOb3U4ei9vWFFNOFV2YzNmZjFiV05DL3hXdS90?=
 =?utf-8?B?Vm9vbmFJeEFIUDBXSU1rLzM4REpMdytnT25ncjR6ZHRrM2krb05qS3k3NEd2?=
 =?utf-8?B?blJiS2JPWElDSC9PUVdwcFNBZFpkRHR2ckMrNVpCTnNCWmRGbWdQRDZsTTVl?=
 =?utf-8?B?QWljbUhJdzlHM1c2Y3JENG5GTVVtdng5WGh6d0srcnJzM1hwdE1Vd0ZHSXdX?=
 =?utf-8?B?R0xLeXdaNnVPUC9TZHhCVTZLV1UwQzJYK01KMmFMeHNycjRFWnpUcmgwS1VE?=
 =?utf-8?B?VlRXamFVcmNRL2txTEdBVmd2R245UzJ2UjFIL21VSHE1RzdZQndydDlJdGty?=
 =?utf-8?B?dllKUFJiNjBZK2dkRE9xWVdYYWhtRThwV0d5SHJ5VklBa3FZNXlSbjZQbUdB?=
 =?utf-8?B?Nm12Y2MvMmN4N3NJNGJBNFBsd3VzcGtOcStJY2RaeFVldFJKcHVSV1EvRENq?=
 =?utf-8?B?cDVmeXJKZW04cHlFL0prWHNuYzlXTnN0OFRJQlRLWlBQUDJDWnhpZldXdUNl?=
 =?utf-8?B?cE8xS1FYZEFRdXhJV1pPakRjMjZIY0svMVhLNHRHYXVDMktaY09zQjZHcW1C?=
 =?utf-8?B?VGJDLzhid1dDY3IweWJsa2tlNHV5Qm8zZVM3Mm1JS0VWcW9qbCtPNG4wMkhK?=
 =?utf-8?B?VkFROHBJaTY3dDVYTHVudmVQWHE5UE5KUmZ0V2tIWXRiUkxBcWoyTGtRczVy?=
 =?utf-8?B?UVROUnBOdW5uSUxzU1VIdkg5T3Nha3RkL3ZJaTR6ZGd5bTc0YjFxTngzSVkw?=
 =?utf-8?B?ZllhbGVnWXN6WDN5Tit0SDdzVDBpK0tTT3dGUHBCeUdCdmh3aER3Q09SOW1E?=
 =?utf-8?B?L2tWVHB2eE95a1I4VHZQUGZwcWt1TTRSUzlCdkwwcnAyOFhuSllHSm1jVUlp?=
 =?utf-8?B?NkMrcFp0eDBvdUFsNmJGTGliUXlWRDNjQmFLcEJ0WE9pNkVBRTViT01kZXFn?=
 =?utf-8?B?eFpsalAzVVpyUTA2NTJxR1o4T1NmYUowK2duK3ZkUVljbTZ5V3BSb1lsWTFQ?=
 =?utf-8?B?emt0OTFobUl1eVR4YmJrMGhrdzBGTCtJY0tla2pBa3R3ZE5ETTBtOXdnQWRI?=
 =?utf-8?B?SHFmWTJIK1JqVU5oQ2pzdkpPMGxvd25RbkxJK1ZHQ0FxTG5peWFLUDNLcHps?=
 =?utf-8?B?S1V5YUxibmk1ZmF5ajIrMGFLaXpacUJBSHBnajJvLzV4WnlySXdNMUtFTG1z?=
 =?utf-8?B?cmJJRVh2RnYzQmlHRUZuaTl1cWlnaWRwcE9mbWorV2t1YXpLWGJJYWcvNVZz?=
 =?utf-8?B?T2NKZGJFa1VleU1EZU9KM2FYL2plMHZqeFdoRGhnUFJJUjdhVW5PbnNvK0hz?=
 =?utf-8?B?M2JtZ216M3B0QmxQWVEwQjFMbkhkaGpnNityU0FRLzY0RjJSV0lnRWc2NlBK?=
 =?utf-8?Q?z96cee7MXWDqBs7IR8l9Vy73q?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6719c7b9-32c0-4196-27a7-08dc4da01f18
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2024 14:22:09.3118
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lOhaVtTGuM/38SPUwY7DiKjzZMqA8cMd+foa9DRE4zH3Q62gat9ms54TfcyOeU3NJzBxL5007UFDJ/Qx8zAG5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8780

On 3/26/24 10:07, Borislav Petkov wrote:
> On Tue, Mar 26, 2024 at 09:41:41AM -0400, Yazen Ghannam wrote:
>> This isn't true which is why the module doesn't fail to load if debugfs
>> is not available.
> 
> How useful is this thing really without debugfs to dump records?
>

The goal of the module is to save and restore records across reboots.

The debugfs thing came later and the commit message states that it is
optional.

7d19eea51757 ("RAS/AMD/FMPM: Add debugfs interface to print record entries")

>> This was my first thought too. However, besides not true as stated
>> above, this also leaves the issue open for others to hit.
> 
> The others to hit? I don't get that part.
>

Sorry, I mean that if there's another user of ras_get_debugfs_root()
that doesn't depend on CONFIG_DEBUG_FS.

>> I think the fix below (not tested) would be more appropriate.
>>
>> What do you think?
> 
> Sure, remove my fix and send me a tested version of yours and I'll swap
> them if the driver is useful without debugfs...

Okay, will do.

Thanks,
Yazen

