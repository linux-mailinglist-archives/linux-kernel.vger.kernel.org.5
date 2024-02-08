Return-Path: <linux-kernel+bounces-58489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D252384E70F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 18:49:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3942F1F247E2
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 17:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC30E85C67;
	Thu,  8 Feb 2024 17:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3dM0NOOt"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2045.outbound.protection.outlook.com [40.107.244.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A25823D3;
	Thu,  8 Feb 2024 17:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707414427; cv=fail; b=PxQ/4LAxr44F04dymnf5VW+HLU2OkSW8EMHuqmTttSJ+ojqDTrjJbZ9WOfhHUzcsmC6lCJzqaULGGugPMkeobsOZJbCidpJ0L5ls//GA/oKeMDYBxLVhiGA+B/Aff1C7I1RZXILXfuXm3BTAOPl6J9d1l0d+r77xbk4tCuBePzg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707414427; c=relaxed/simple;
	bh=aHYgzAw4qRYYfwep1A2dzJ5UbW+X3/9cr7KtWzFqPiM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Q7zh9wk/GpP1hyuHF8UqwBYnFjZ9i4ZzpgJd+JoxHmXd0eygJkeLRm3NUDYPAO1TR+2tAz0flXo/K0f3/yn+OuzIQDL8sAizlS0mMdGXFKrJOcMOG2vt+jsoJLtIBxeIuhIZsBUuKFXlhJBMRlKf4jKZknanNMRtXLWPrCXfEcs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3dM0NOOt; arc=fail smtp.client-ip=40.107.244.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PCjCDUoUU7sfsHMT3iKKoBb26qyLHFejR7R8ESF/r76r4hWhYmKYDpgCacYPryiH7oAgv2FtYuTM94BGYvAUx1V3VUGtZNdrevqpXl/pSQJKAfYlqpzhUdNHszNbkWrq4UlSSwQl3mKGIlPQcjo7nZrElWafsvoMfwvBCaY7FiMHrLw04aoa3Vj7W/BM8jxU4jFo6wMpu78E6lp/szxmFSCSv/cUc6gPhO6S0y4+CAehTrHvJIUUMG8Vpr+gCL17givU80fBx2bNzM/Os5F+nM8T4X1d9IAfFyjoL9NaNoTzo0qiA6J1eQ7sEvK5YMW7abEv4lCEIbqLnUrAJvFYSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m43vJc/ppeHivFDS9/julpytnvEw91XrUebUm/hX3Z0=;
 b=W/8U8j++XN9NwE+7HvfV0rHZo9qB/F3GEwxRBDCPMEzrtWt8IGRl0t151VSaTicI+1YTaQLAD6FwJY5WLM5NIlDreyJph0cq4LUVO6qxqz6mIzHe+X0+Ayi4gRES8uhNbisQgN9UQFM0NxRuYyaCd/LjTVbTE029oxX1pChEqRlNI4wWUqbC9sv3oLjfQDYj1V8c8TpzPAq1T9dGMnlDtzgkue2g+O1vSU0vYW0OettDrVpZhLHJtEPxdvXziIazzSpvBAlMWeQf3AruUd1GhSG4H28TpmrDQDjnNuJrwmGh4WzL5mLvurPqvzG6oqcNgWyhisUt82QICAoNOsv0xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m43vJc/ppeHivFDS9/julpytnvEw91XrUebUm/hX3Z0=;
 b=3dM0NOOtY+LauAkjyFRocpRhOjugUaEXjz+A3dVzDEt/mec6qwHiEhjEN9sfO3AepB9pIyzHWM/84wtonHNAazB1biHbi7HcOlR2IkdFqVgvi2fB2z7Pg9goU6cjwCnYlFcfqCdhBpWpWXDSbAW5vIt/JJO4XhaanronzUWAOQ8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB8403.namprd12.prod.outlook.com (2603:10b6:610:133::14)
 by CY5PR12MB6105.namprd12.prod.outlook.com (2603:10b6:930:2a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.14; Thu, 8 Feb
 2024 17:47:04 +0000
Received: from CH3PR12MB8403.namprd12.prod.outlook.com
 ([fe80::ea0e:199a:3686:40d4]) by CH3PR12MB8403.namprd12.prod.outlook.com
 ([fe80::ea0e:199a:3686:40d4%4]) with mapi id 15.20.7270.016; Thu, 8 Feb 2024
 17:47:04 +0000
Message-ID: <077f04a8-bba3-4f10-88ea-2ec132f2b6ef@amd.com>
Date: Thu, 8 Feb 2024 11:47:01 -0600
User-Agent: Mozilla Thunderbird
Subject: [PATCH 1/2] x86/MCE: Extend size of the MCE Records pool
Content-Language: en-US
To: "Luck, Tony" <tony.luck@intel.com>, "x86@kernel.org" <x86@kernel.org>,
 "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
Cc: "bp@alien8.de" <bp@alien8.de>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "yazen.ghannam@amd.com" <yazen.ghannam@amd.com>,
 Avadhut Naik <avadhut.naik@amd.com>
References: <20240207225632.159276-1-avadhut.naik@amd.com>
 <20240207225632.159276-2-avadhut.naik@amd.com>
 <SJ1PR11MB6083E1876B8CFBA76F1B3806FC442@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <3281ec05-60cb-4fa2-8562-afa93e770159@amd.com>
From: "Naik, Avadhut" <avadnaik@amd.com>
In-Reply-To: <3281ec05-60cb-4fa2-8562-afa93e770159@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN1PR12CA0087.namprd12.prod.outlook.com
 (2603:10b6:802:21::22) To CH3PR12MB8403.namprd12.prod.outlook.com
 (2603:10b6:610:133::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8403:EE_|CY5PR12MB6105:EE_
X-MS-Office365-Filtering-Correlation-Id: d5660e36-aa56-48fd-afd2-08dc28cdf5e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Tpq/+aSXnsopMKxMEzCuPusAYBi0voEHmnnjou3uA/BiVuE6AlQHzBI/wIk3G7lEI29l5PCydIu6gIMC5aJ90brdgeFRYt0kNIq+Uvsw5k7hWOmw2mCGiGEWNCcgqnC69xc/uMHK8CaijCF24c0cAt9SIwat1aaBhD+XAaAmmONgEF+qZFqAJHO7U1dD8BtEfJ+Rui3zY3gd+qxAlEKN2XojKc6lJMpy8WFEyzHDosk0vGEB3I1uMKMvnNk245CsrxeWfFvz6s/i0WTAfspFaquLxe9pP8Bf5NekAtbCRqVy6n5dQrAzHF6wsBCTsFN1f2bNHpkyKrWoTLfc1/jVehwzQr0vveyTdrs8jdygLb23pycj8aEax21FFhSw4WpZjUBcuGmDSqMU0LMOKUlLCnVPY5Drr3DAeBlQZxBIhjUV6SBBi4LtpAHZlZqR1cu4Dq5tK/nTexQYOO/jD90hzoojJTbLQyALPfoOdBAuHqfJ38aC4l9gBvPLe2HMfydFW/5cmEWPMQ7lbA39tYWZ6t1EnlXsjIJKNf8mQQyrUpvvHheoKJpfkuuUVqQs8Skl
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8403.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(136003)(366004)(376002)(39860400002)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(6486002)(2616005)(31696002)(6666004)(478600001)(110136005)(66556008)(26005)(31686004)(38100700002)(53546011)(6512007)(6506007)(83380400001)(66476007)(54906003)(66946007)(316002)(4326008)(8936002)(36756003)(41300700001)(5660300002)(8676002)(2906002)(4744005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Slo1OU9GcjJ0M2lJQnFCMlJWTWtBVmhKNzU0YzVrYUZmTFZrYkZoZHRqcW4w?=
 =?utf-8?B?SHgwMUdNSjJqR1MyMm43Vk4zN3RqZG5acGpsU1lYWWtnV3locWJueUxNYzND?=
 =?utf-8?B?cW9tV2ZSaG5OaUVrd3RVei9NamRMYlViV3ovYU15L2dWUlUraloySml3aVJl?=
 =?utf-8?B?bFJtVVV2T0NCSFF6WFpudzJ5VDFWcm1uREhmR3JpRUNaZzhKenpQOFo1RlJG?=
 =?utf-8?B?dTBTeStJZGd5SDdHV2tGemcrbVZzRnF6Q1AyeWRYTDhuSDFtREZWYXMzM2JZ?=
 =?utf-8?B?QnY2UEhqT3hHN291WnU5bHNheVJMNW1UVjFneDFPL1VUZ3FTdzhyNVhQOFdv?=
 =?utf-8?B?UVRSVzdLUGhsMG05ME9KcTJPd0dtaEllM3lkd01nVG9IOHNpSzV0QlJqNFg3?=
 =?utf-8?B?c0RGYUlKc29HTytUcW9Hc1NIbVdhUnM0clh0OFhLaTN2QzNSc2o1NG44VDJ6?=
 =?utf-8?B?dEFEUktSTEl5ZFk5Z1JZOW5ndXVCTW5mTkE4V3c5RHgzYmVCNnJUaHU3Y2s2?=
 =?utf-8?B?NW5YeVZadmRlRmZaU0lVTk1CZVF5NzZLUFdxdGYvWU9WeVRyRnoxNVpOTFBG?=
 =?utf-8?B?cGtHNFA4ZHRMek5tWVlKVmNZbjNuVUtoUTFoOEdtclRXeVBGZzhoMEpiem5V?=
 =?utf-8?B?R2hSa3R2OUNtOUFTM2VkUzUrQkZZUDg1Tzk3OG5iMk13SDY1Q292Z0J6WXdG?=
 =?utf-8?B?aXd1TnBsNEZyT0c5QzlLYm1LdlpjMmxOSGxSR05zc09PMFJWTUhlbjVaeUdF?=
 =?utf-8?B?VEdELzNTbjVQejFBUTgrYUxGRk5OdC9jN0Z3UXlLRlhPWjdVZ1dSVXIrWXI2?=
 =?utf-8?B?SDAyKzR3ZnF0MjBuVXVOQkZWa2N1YmpZR3YxRjgyeFdMU3pIZllNM1hya0RZ?=
 =?utf-8?B?MWNJWEM1MjJoNlUzT2dTODZiNmQ1OVNnbFhLQ0FzYW5pZ3RONGNCRXVhWHcz?=
 =?utf-8?B?WVZDZXN0dDl4MU0yOThSVTg1UWpMMzRkbmFQQVd0YXBCQmJwMkdNNGZXQnlk?=
 =?utf-8?B?bmRvMWpXenFVNDdmWHhTUjRCVjR0S055VDU0bWhHWERSczJwYUh6TFZzZW96?=
 =?utf-8?B?V3A0VzJYNTcvMlByeTZSbDRzUUFPTlJZeWdYeEVGdzNhMVgycnMxSVBlbFFF?=
 =?utf-8?B?dXErRVY1SzF3ZlVrbGMyM3ArUEVpSVVQR2JsVSs1c3YyV3JENFNKTFRPNysv?=
 =?utf-8?B?VXp2TVlFd2g5WlVLSCs3WmtVKytqMVhiWFVlYXJxa0o3WlcvbDlYaldwOUcy?=
 =?utf-8?B?cjN0eWI0bUVvemFISlVXUU9mN1p3SXZEL0VoTWlVbVlMTHlTZkZzTUdHQ1dX?=
 =?utf-8?B?QnF0UndYa2w1dFdrMS9GdCt5ZDRtRzZaZWMvaEpGNmNpOE1aK21LNlF0NDA1?=
 =?utf-8?B?QUFvNE9uTGJkT1lEdnNBWWQrMXJrSTNZRDVtdjIyYUl4bGdESHZ4a2k4Uk1x?=
 =?utf-8?B?b2hQa2hiTzl3Vkp4SmY3K3ZrQ0VuZU10KzZwbWJ5WEFuZERuQjZ3OXllYkRr?=
 =?utf-8?B?RGVDbFF4MUI0ZENXeXJHZXkxdXJ6UFV3SFRLMHBnUnpEOWZ2K25kWDdxNlQr?=
 =?utf-8?B?ZFd3ZU4xYS9LNis4V25XR3FMcVE3cmtpS2lQeXhwTS9SUlJOV01mTkpPQUw4?=
 =?utf-8?B?T1Z6SW5YaUdIek9pYm00VStXbWExT3ViQkM4UU9NQkVFLzdZMExqbG5WeFd0?=
 =?utf-8?B?NjQxNTRSSHhVbFdWZmtGL2VHVVl2d3RZK0FRRkU3WFU3L1JxZXpPelkzdTRk?=
 =?utf-8?B?cGpROGt6bXMxZ3lSNHdneC9iemVNa1p2bE9jMnUzZHF4bGkvSnhSZy92NWIz?=
 =?utf-8?B?SU90SHhRbklSV2lQK3d2M3JGYVRLYkluUk1XRFRrejcwampqeUZGZUs3UzZ6?=
 =?utf-8?B?SDh3a2JsMi9FK3hKWjN5WE0yOWtiVWtIci9NRW9LWTF0dFpsbXczN2Q1OTFR?=
 =?utf-8?B?Vk1WOWN4OVF1ckl4OS9WZFhsaGY5VDNXNjBSZU9xOHZtWG84Umt0b2JqSnZN?=
 =?utf-8?B?TC9SbUVVdmRmQ0hjenJtVjlOM3BLcmN6RU9Zb1lycW1tRFlzcU9XRmRwZkcy?=
 =?utf-8?B?bnhyRnUxV2V4WmFvTm1aZEs4TjVUUHNzaVRXODhGSTR3azNwSlo0aUswNGdm?=
 =?utf-8?Q?1naU1ihEZRNMNH0TedXYb4vUl?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5660e36-aa56-48fd-afd2-08dc28cdf5e0
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8403.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2024 17:47:03.9624
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ABao5/TQcA5a+pOrYnHEFmi6AdD0XJf8v0lkbQrWDkGDUi8ycWYttVzmdxPZDLzrGOed0YaZIDaCJheV+ZGoYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6105



On 2/8/2024 11:41, Naik, Avadhut wrote:
> Hi
> 
> On 2/7/2024 18:02, Luck, Tony wrote:
>>> +#define CPU_GEN_MEMSZ	256
>>  
>> What is this define?
>>
>> Why isn't this "sizeof(struct mce)"?
>>
>> Or 2* that if you are trying to reserve enough space for two records per CPU.
>>
> That's the memory in bytes reserved for each logical CPU in the
> extended MCE Records pool. By current size of struct mce that
> equates to around 2 records.
This memory will be reserved for each logical CPU only when the
command line parameter being introduced through the second patch
"mce-genpool-extend" is not set.

> 
> Will change it to (2 * sizeof(struct mce)) though. Feels more
> accurate. Thanks for the suggestion!
> 
> Do you have any additional concerns/comments on this patchset?
> 
>> -Tony
> 

-- 
Thanks,
Avadhut Naik

