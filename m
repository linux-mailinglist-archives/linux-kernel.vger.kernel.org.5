Return-Path: <linux-kernel+bounces-62076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54574851B15
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 18:16:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C1C92869BC
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 17:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DCA03D994;
	Mon, 12 Feb 2024 17:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="t9K10Rf2"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2060.outbound.protection.outlook.com [40.107.237.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C35233D39F;
	Mon, 12 Feb 2024 17:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707758178; cv=fail; b=qN+6BuAPQh9oZKgyX6py+sSmq9HwwtDasysff9/ZnKEdevt1bzVTHqjcJelBuvB+wlZ8jZfbaHSP/1UmJuIbtWEpjqAidtlpS8NaEW7/rm7O1afalKuJDtJLpZgJCW4zdsYeYkFGB51KYWXoqEf6+zs/UoTdQro12YediSCh4DE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707758178; c=relaxed/simple;
	bh=yNVyCs4mmI7r778IchtZHAACAF25779mFwoGL24DSYc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sjZIDZOcL1d29x9e/Gai3FDOM48BjEdZb/PfzcA0kvn+62KqonvyrRb9i4LZTz8GE2lQZ07HNCFiGKw2tlDkHcoLG+H7aHkBXdf5JL9vISOwe4Xkqj8v/yNK5U7098l5qrqrVVhWib6HLVzpyE021xDX+get5nwsDoRCnGHiMw4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=t9K10Rf2; arc=fail smtp.client-ip=40.107.237.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vzbaf3HwwHTIBM5Tq9Hm/GFcxjjU+/GrD+6Sy3J0G9XP5ZghYXsjlEYfZTNd7YITg2gx4v3yEndJkay6DT2a9WQumeDV2ItxKs6ysJ1dZkep6ZBDb4CKZn/S9ExlXax4jJ2NZeXI5tIxoyHf/exHBkU2hj4QmooGh7SpdodJRyqY22KAPm3/dsm2QUXb9+sYD4X7FbVjGnVS4dtN7v9O71LiAX6mWgwHtqZ9jjMEWbWb7B8b6FRJZGHRi9Xmn1p0S4oYcUA/OByJ9MKQ429Pi3SRp88IxCvSbTg18DzoQv/4dxuy5NcK0JUThSCHt4mjsX4Cvhx6Q27cNxPmtY+AAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IXA9O9JMhhhBXHsae8moKHVqeKVQni0glg+wstiDqc0=;
 b=CtZ0jVJVHb58JQv8R+v4euzaS574m51TLY0OY8IUwx2MOGlNseEPd0uxC3vfHzA5ohuOtROFwtjGn94trSjbjXNiHtF7NMzlEGiT4QCtXZrBuqHtf+LsYwAX08EX09A0xQ5EUNF7UoszMZAZBBgT/m5/H0TsncV3L0X8vKS5apP0fzjygHaREH6+LqQWuEO0y7TxJmYNjUy0OCHYt3epWIB2bKi59K35VdfAymOcwzuyRmVq2a6EjxvKd8u5I++1/vQkpMO1yFXabGtG6QR1EBy9OwG1b/E6IXUnRhTq0r840FasWBWKkmjnBWnR3+u3+hKPPI7wQXrV+g2EBmi+mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IXA9O9JMhhhBXHsae8moKHVqeKVQni0glg+wstiDqc0=;
 b=t9K10Rf2Hs0gosSjZ8+95RxqQ7M5IWmTj4e9k9LdkpzWmIj7SlhJt7mzF/qclGH8J44BFAa9lw1uHPdsTbEvPl1y7/rxV+ZNsqjgbTPx/VGdiaeZXvGC37iflD+kFVi9aloqZKvBvWl46AERpAlek1fyrog6wYUQbD2RGirGgbg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by PH7PR12MB8121.namprd12.prod.outlook.com (2603:10b6:510:2b5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.16; Mon, 12 Feb
 2024 17:16:09 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::ee3b:5116:72be:be7a]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::ee3b:5116:72be:be7a%4]) with mapi id 15.20.7292.022; Mon, 12 Feb 2024
 17:16:09 +0000
Message-ID: <88fbd6ba-6118-4a80-980b-122dac5b4d39@amd.com>
Date: Mon, 12 Feb 2024 11:16:05 -0600
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v15-RFC 5/8] x86/resctrl: Add "NODE" as an option for
 resource scope
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
 <20240130222034.37181-6-tony.luck@intel.com>
 <6628954f-c7e9-4040-9f03-7b5b6a6d082d@amd.com>
 <ZcZ7wEUzESxUhs-y@agluck-desk3>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <ZcZ7wEUzESxUhs-y@agluck-desk3>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR06CA0046.namprd06.prod.outlook.com
 (2603:10b6:8:54::13) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|PH7PR12MB8121:EE_
X-MS-Office365-Filtering-Correlation-Id: 17f19952-54f4-41d2-b666-08dc2bee4e11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	7WNAuHC6gDY5ilnwTQFoDLNQiPDrptUPb9SSbLOHDwACLDLyVAJ6YZkzd7fj0zGzG46FzR6ekKRUdkBzSmS/oDFBkvjFctkrn+8+ge9cnaWBnCdHYwTXNB6NmZcYBLTQWIxGM7ZQsxfdmgWYN+RCDrxmPVdapA3fzYHC0QT6BdpCf4qra1gg+7RIGJZpPlVmp9JvoR1OyPs1fYAErk1NaAATsk2EQkwMZzCUkDDYexGoLWqj3muKjbzy0LFcylKJuhV9bzZ/6jKT3ehV0lTbUpf3ifrEkRidqDpWZbgvEH9lJszzIGk0tspH7dLXBiVwqOuIYKr4S5Ms0z+q0RV1PGKoU91bDRa+1tJva7VuBwp2x8Ow9HZJxXjemEl4a6M18dPnCcmf16+BZQ1rd7YYjziV6+4ruwckotg3143ABdcpvRGmZ7bn8bjA+kahbalGfBix8JhC7tjsMZu+tx8DPo9UjEjIziHNN/LEzEgqqH/gWJnmuJRmrpu6V7MrjvwiXNseHrnLRVXntHun3JQEEPykkcSYzKInvIfnQfNfNG7FembaV+hMXy0gpK+iqmov
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(39860400002)(376002)(346002)(136003)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(31686004)(6486002)(6512007)(478600001)(41300700001)(4744005)(8936002)(8676002)(4326008)(3450700001)(2906002)(5660300002)(7416002)(6506007)(66556008)(66946007)(6916009)(53546011)(6666004)(316002)(54906003)(2616005)(66476007)(31696002)(86362001)(26005)(38100700002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UUtodlpqaUgyMnVZeFJ6bmJmbzd5L1hrdlRleE4rcGhJZXNnMVdqeWlLNkVz?=
 =?utf-8?B?ZDRuNjk3bEE1alRJQUxDM3k1K01xMGU4QTd4ckJnNW16ZzBuZ2Y3WGFCSzZ3?=
 =?utf-8?B?emJsK3EvcG44VERjaGlXUTVtS29oL0RHZEgxNjdKelgwclhTSTV6MmhiZGFB?=
 =?utf-8?B?dWkwV3JGTHJ3T3JOUVRpV1JIMGszcVdqS1hWdlJmLzVTVCtmZ0ZmL28rbll3?=
 =?utf-8?B?bithdEpZUENOYmU3RStVZ0llejIrbWFJaWR5VG5tWi9KajFjT1BWcld0bmlQ?=
 =?utf-8?B?V1UrdGJoQkI2c0JpRVZxZCtGUFB1TGdXY0t3UllqMEtBTVM4YURubDMyOG1W?=
 =?utf-8?B?cSszTk9OeEl4VUV2Si9LWFF2SDk3bk94bEw0WTNuTkRvUWIvZmxFUlBGdDhU?=
 =?utf-8?B?WHNXZmpYWXBaK3pDcXNFNS9EcnRRKzJqUFArWnBOUEhFdE1SMHJiRjJxY1Ft?=
 =?utf-8?B?UWpHREdxaHZQUlF2M0F5UHhiQ1prSW5zM3MyWVhuS2RkRkNocXJxN0d2eGR2?=
 =?utf-8?B?Y3hNM3RJL0tUTVNWbWRNdlQ4d245bUt2SlZ0MUFaMDFMbm5XbmRvdFdUYWJO?=
 =?utf-8?B?MUJYRGZQQTd2bThvVzl2SmZreEFXMjVrSVVzOG5vaFh4MDZSOHNXQmY4WVpI?=
 =?utf-8?B?TENYVG1KelQzQ1VVc3JtMEpIRDZLdFJNUjlEVXhBd1hZcWZDZzFxZ1JFM0dj?=
 =?utf-8?B?eGlPWitYTXJBaDdBdGdETHA0ekVrVFU3MkQwamJQcXdNSUVMbUVxUk85d09Y?=
 =?utf-8?B?dmVhVHJseFJWS0psbjRjVjBvdWNud0VGdFVhZEdlUysxZzFWc3hyL09iNFdD?=
 =?utf-8?B?alg2dk5GYjZNd1VUWlQrSkNiTy9MSDU4dGJuaGdTTmlFSmF1YURCQ0ZPeU5M?=
 =?utf-8?B?bDdmaHRsRWRxQ0p2dENWSjNVRFRXUjl2endQOXZoY213ZEF2N2xyY2VvZkEx?=
 =?utf-8?B?dEdLNHIvQXhLYmNWTFlIc0tMczVVTTB0bWk5dWU4YVQ5TXRtK3N3SzJoWHdP?=
 =?utf-8?B?N3d3RHdPc1VDYnY2Z2l2YndZWjRLT2R0ZTJKdGV1ck5qblZ0a0RpS0lHR1Rr?=
 =?utf-8?B?NVQvZ2JnVk9PVUNCZnllU3o2SzdnQjB2UXd0aU9tOUVyOEl6VEYwcHdnRnRs?=
 =?utf-8?B?LzZocUpzNXEzc0FuSE02dVFnRzI3aEUyOXQ0bHJMUVhZSGlQeG0zWHpmT2FT?=
 =?utf-8?B?Ynhud2dBVmtaZUdMcExiUk1EdzQrTnBUME83VTlKbytvN2ppUTNxM0lwTWYy?=
 =?utf-8?B?ODdneUpyOVVpZkhUWFNjUTIraTF5bThtVlFRVk9pSEF3Wkx1NG5FNVJ5U2dy?=
 =?utf-8?B?RnVMSVdMbHc5YWFRdFdIV2htZlJBbDdYMHNoSzRMTkl4bnROUXdYVHhjeHBT?=
 =?utf-8?B?aDZKandQYktoRUdzMmZ2Yy9qaWZOSDRmbHZSR1RGdmRLM3NsRy85K21MZFJo?=
 =?utf-8?B?QS8vYXBKZXVpRi9URVdYYmdNcVhNNGlXak1Ed0F0RjEyR20xZGR4ZXdMS3VU?=
 =?utf-8?B?eEYzbVVhb1BQcng4SUl4Rm1VMTMxbUtRSEtVTTV6dXJmdVhtYTA3aUVvaFhI?=
 =?utf-8?B?NXVzcnJwMFF0c3E2LzFjRmwvN0RIUkhlbk1nM2VmWUVRR1JjeFhsQzhUa3Bi?=
 =?utf-8?B?YUw0NHkvR3lpU3NNUzZseHpKbnF5YnRsSGIzZS9VQlJ4dWZyYzA3Vk9CZXhy?=
 =?utf-8?B?aHAvbTV6bGRGQ1JhNXZ0U2dWTTE2Ym4rd1h1bjd3Z2FpbTE4ZHdiVm5ZenhG?=
 =?utf-8?B?VEN5aUNiWDdPRUZzektwRGpIcU1FbnA4VmNkNkpPNnF5QjFiQXIxMnA4WDNv?=
 =?utf-8?B?U3diNWpSUXNvKzBvWjdPMDVTR0FpRjRETzJGa3BSWTc4R3pucmJMRG9UWFpo?=
 =?utf-8?B?SGtLUHZjVDBwLzViMWtWdnljUWx1bE55di9RQjlyWFRtZlRERnEwR2MyaGZ4?=
 =?utf-8?B?MElvS01jZzMrdFovbzREODJhaFRkNyt0cCtwNzVnSmJaUFRnMzlaQ0FQN0xU?=
 =?utf-8?B?K2E1OWVCVEJhc2NvNUFyT1psNU92SUhEUVhhSmpSL0NWc21peFNNOVhMZ3FV?=
 =?utf-8?B?SFE5WS9JVEJmN051YVF2b3Jiamprb0dTV0gxeURqYU43RjlqL0M5NjNYRFh1?=
 =?utf-8?Q?3/Qw=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17f19952-54f4-41d2-b666-08dc2bee4e11
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2024 17:16:09.3613
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tPBb1bKRs04CHn5DhqtORgP+i1ALm4PLFO4FIakMiKtJG7GTpG2uBbhm16/CwOi0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8121

Hi Tony,

On 2/9/24 13:23, Tony Luck wrote:
> On Fri, Feb 09, 2024 at 09:29:03AM -0600, Moger, Babu wrote:
>> Hi Tony,
>>
>> This patch probably needs to be merged with with patch 7.
> 
> If it just added RESCTRL_NODE to the enum and the switch() I'd
> agree (as patch 7 is where RESCTRL_NODE first used). But this
> patch also adds the sanity checks on scope where it has to be
> a cache level.
> 
> Patch 7 is already on the big side (119 lines added to core.c).
> 
> If you really think this series needs to cut back the
> number of patches, I could move the sanity check pieces
> from here to patch 3 (where the enum is introduced) and
> just the RESCTRL_NODE bits to patch 7.

No. You dont have to cut back on number of patches. I think it is easy to
review if these changes are merged with patch 7.


-- 
Thanks
Babu Moger

