Return-Path: <linux-kernel+bounces-135884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6869789CC9E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 21:48:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 213D028188F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 19:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4656C146019;
	Mon,  8 Apr 2024 19:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="PWEtn11u"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2096.outbound.protection.outlook.com [40.107.101.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C72E1DDD6;
	Mon,  8 Apr 2024 19:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712605680; cv=fail; b=nzD7Yz+hvt0tI8mubMVtgjDR1C2XdVPJycTKTfrgCVaNAe7k62AXUmK4U0mAx8yuLTRwT1r2dONPg1zNhpVRyY7icfLVfdjSvItaooFtqUnIKrJ5hR984kTnqM4Sup+KoU7Oh9gkznX+d4KixDqTBiejlBjEzIodtHCrHaNBVmw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712605680; c=relaxed/simple;
	bh=xhTbKdCzFCRZrcOiOJX+EMqNMVG46wtLXc8+NfI/Jak=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DZkpXJ7UT0EYRS0tzm4k/3KJ/QIy2ntXTYCTkrILwZrNiMdAw1Xvyl4dKlDCQ2M9pX6K5DEmuXhmb4D6OCqz1lexmuFcTScpXb3f7dnpX2qklciOmGKN5hVjnaIKShNJ4weM1EfdoNcaQQj8dDydT3qJKRYqzc2ORqp9zMAVF8M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=PWEtn11u; arc=fail smtp.client-ip=40.107.101.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hWPhdrs8jvjIyAwjhXG9Qeu18PvsiHPvPy8GeiJ4EwoM2cPb3+9hTy2mbhFEU5UAhX2e0b0Vmk9UiNniO9hRJGDmOvyVEvXxbQv28zZOZCZqMxbrwLTdjupWXlUB59OFuD3ymYkdIxIN0X3E47VRcNAx6tP+B2a9VbHOXY/HBcQDCyCJXUENIPNJOnyCZnHjxWK1ulEjOIK0+ymMerFVmGlO9IkJ4ZnJNex7CgGA80WZuML3YVt4GkSyI0+UKUhRgKwSxHZjySEDunRU+dOU4ZCi81rM39OSqR1iWcJ79EYL3AFmP7PFLPUpQ1iCF2uzVb7sqiwzyc310zYoOKQoDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oiD6EndZ4AnYsiKn4Qdwn8j9HZyllrAtggbxFIJFHNY=;
 b=IuDboRZ02ARqAxpJrrrclmMUM/wcNGW36iWduQRGCRZ7bhmLbgiXTS9B2VJAP7yCkmrmEOaT5tVJ/uSf8CkGIxJlRMuKXlqepswPgDD3EcmGZHyQIfTTMvBB6SvMly+wj2SFctk1FZ1r1rdiVmslx6MPmJxXR+Uao1oDZHwzhL7tiHyq619mIJ98g4CX/FuB825bpPuw27MORVmU3lcPeXaI097H5G/aot+2EfCJ1ob5ZASH+6q1/ahgvHrp8qgfkkM0fVoyFAH1OMNIbsUXExOQqofndJMgG23Vd3tLqi5bndsl9bOJDSIyPLNRFiHi10tGlm0AFZLUfM6dk/N/pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oiD6EndZ4AnYsiKn4Qdwn8j9HZyllrAtggbxFIJFHNY=;
 b=PWEtn11uju4NPna19zFaEi3J3A3yicIxTs2ihaep6j0aJUjKQ00XqCvLRaBosT24IfRm5H4wJwOCv3uvIZL3DAeJGdNJNR5pMpj/ID4opizVgOzbRtklqI4c/MTjR+GEXTSVsNgUJrDkISSlUqZGpvVBIH5l1vLdJSB/G+18qvM=
Received: from CH3PR12MB8403.namprd12.prod.outlook.com (2603:10b6:610:133::14)
 by SA3PR12MB9157.namprd12.prod.outlook.com (2603:10b6:806:39a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Mon, 8 Apr
 2024 19:47:55 +0000
Received: from CH3PR12MB8403.namprd12.prod.outlook.com
 ([fe80::aaa1:af99:e0e5:7f14]) by CH3PR12MB8403.namprd12.prod.outlook.com
 ([fe80::aaa1:af99:e0e5:7f14%5]) with mapi id 15.20.7409.042; Mon, 8 Apr 2024
 19:47:55 +0000
Message-ID: <0c903e3b-093e-461a-aa70-c2d58fc6d82d@amd.com>
Date: Mon, 8 Apr 2024 14:47:52 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 16/16] EDAC/mce_amd: Add support for FRU Text in MCA
To: "Luck, Tony" <tony.luck@intel.com>, Yazen Ghannam <yazen.ghannam@amd.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "x86@kernel.org" <x86@kernel.org>,
 "Avadhut.Naik@amd.com" <Avadhut.Naik@amd.com>,
 "John.Allen@amd.com" <John.Allen@amd.com>,
 "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
References: <20240404151359.47970-1-yazen.ghannam@amd.com>
 <20240404151359.47970-17-yazen.ghannam@amd.com>
 <SJ1PR11MB6083683CAEA79F935BFA1B31FC032@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Language: en-US
From: "Naik, Avadhut" <avadnaik@amd.com>
In-Reply-To: <SJ1PR11MB6083683CAEA79F935BFA1B31FC032@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR05CA0049.namprd05.prod.outlook.com
 (2603:10b6:8:2f::27) To CH3PR12MB8403.namprd12.prod.outlook.com
 (2603:10b6:610:133::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8403:EE_|SA3PR12MB9157:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	qCCpAiOpDdpio7Ol1kiehALCs4JOe6kzOwW9TtT8SQQQt1OifBCHbmHFhsn7a9kbWwatKw1EIaJD29suoWGzkmiHa5BDZ+yBzH9r7YprS85vAg6zCYHeZTemePUHgf21bAyYeGXTDE7GXkPkM/9m0qyN5VpImwbt7HMo8UNuO0yX+O8gIZ6l95KS5y4/24Bv5eW/wMXmAPEgQ8RuUoSJqU4DFi5EnAKxgHDO2dg+2begc7xbEYvw/bhNQUL23Hdpl9JH5688hiWISnzCLDUOTXVjeFL3D3sbeWcui4LchyDxUGRxP/3nA/DjAluDP1XWP6uqrJIxA4THt+q8Yofyb6khn1Pwrd2ZXjF5PP0SFpZHdqiUvN0dwoFLvYOWSQZnJgCbj0v493Qh921i9U0f+a4nt2PCt3c8mEQNWD7EBaqzX1K1QB50p3XPi2ZXEvNFxPuH83CRgQ2lUpGXYJA3uNCfKDA+K+vNNeucNcxzOVUhCDzS4IWyG2LxnKELD9JUTK7FueApaqWA1Rl3acauIrUuySYiZjDnPrkFtGTHPYwG7eWn3oX6jp2jLpM6ikRA8buW/pW5FtWw81ZcgqtGuyHwgnOL6cHeBCLjQllucx1MAQDFrt9seYTo5AyeBAbUw8Ygqnwu2AHxhHvXvvt/CvOViqjYMEUMOKJqgT8us/Q=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8403.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cUF1VWkyc0swRytGS3gwZCtoakN6VUNaY2dFRjI2L1FMcnZ0U2laMWRZUk1M?=
 =?utf-8?B?YytCYndzenhGeHNIVnJOOTNrZ3h4M2J2ak93SjJtV1pGQ05pbk9xTmVWQkI1?=
 =?utf-8?B?U0NpVHRPMWpQWExDRml5a0U5WUIwdG9ZS01VaGU5bVJzU3NUcXpuWU9xcDF2?=
 =?utf-8?B?VVl2UXdrbmhhRUhXLzF4Rk1FY1o4cExhSjU3SDRFMnZjendmRWZMUDZxZThp?=
 =?utf-8?B?TVRaK09UbHlGd1ZNQmZleTQxUEZlb3RKd1dhM29ZL3o0OEpzWVVTdFJBQ0F1?=
 =?utf-8?B?Y1NYZDhwOFhtL1ljUW8vTXJqSVl2TGFIaXdqMmdIdlE0SkFYQmUwOVZSVWVB?=
 =?utf-8?B?amNkSDlqdWN5dk9uTDF2VTJsaTVQS3k4NlNpTFBhM2o0bC9DOHAxNFM2WEJz?=
 =?utf-8?B?cFZ4T0o0REtYRVhUc0h1eHZMRGdoYVl5K3p4T0VJcDRjekx1UFh4TnA3aGNS?=
 =?utf-8?B?YkpsQ0VLSnNwTFZOVGY1WkVPNzVtalB6aXF6MlovNmV0NEk4RnVWMjExSTlI?=
 =?utf-8?B?N0dzZnp4Y0E2UTF2R2lSZHVYUkVITTREaE9XRlMvWVltVDdLVTFZSzFYNUkz?=
 =?utf-8?B?dndpSm5FVGNCOGYyejNzZ2E2UmtxSUJNbkh1Ny80cG0zZWV1Nitla3ZSOHMw?=
 =?utf-8?B?RSs5K3R2V01mWUJIZ1FjSER4STFZV0tiaEh0RTYzUGRwWTFUcnNZUW42Vytw?=
 =?utf-8?B?SUZyaVZxLzErNW5PRzMrblZsbEJPNzArL1hjcFhlS1BVUnJJK0hWQVJIcm55?=
 =?utf-8?B?NCtJZ0dxZjB3WkJHcnNNeXpQZG94Q1hUQm52MmQwWGcwM1lIcFFjWldnR3ps?=
 =?utf-8?B?QXBLV0J2bGJnOEZ6ZzVBeUh5eGRxYjBRODkwM1pMWXFsY2FDTDRLNTgwQjJz?=
 =?utf-8?B?L0dFcHdqVTYyVk5SUnYxVGdaUEdXTXpjWGV0blpzUmtJT0VuZjdKSHlUdktn?=
 =?utf-8?B?R0dPdXNvYlR0QnFOWFVKRCtDTFhiZjNDdVY0YU84OFcyZGNUa0lRZ2k0azB4?=
 =?utf-8?B?MWJqb2UxR2k0YWtTMWNZYmpTNDl3Mms4VllyQnNaVzlWQnFmVldDcVdLZU8z?=
 =?utf-8?B?QWhxc25lN0I5aThaVi9IQmJ6bkVXQm9EbVA0MHZDdXZOd2x3RXJqRkxaTE1F?=
 =?utf-8?B?N0lQUThJdVRKK2JjWktGVDZtUUhPWTNHenljTnNyVUFwZEVqYmd3ZEFXajFQ?=
 =?utf-8?B?SzFKV0N6cS8vbm4wWEZMNlZYV0lOR0lzM2wxUkVuS0U0Z0Zhemkzc25qc2I1?=
 =?utf-8?B?b1B4K2ZSN25JZlFXOUZMNllLOVlSTHUvMGt0R2laUGErWm9RNUJGejR0L2Zm?=
 =?utf-8?B?RkJxc1NhZUxYenFpMElDbEZwR3c3T0FoZS9sL0tUb2k5Q241UVNNS0pMRC9p?=
 =?utf-8?B?U0w4aExjVHQySjJlY1J6ODN1RmpJTWg3WHJJMTVidUgrUDlnS0R3SFhCeTd2?=
 =?utf-8?B?cE9ZczVSR01MVkkvM1ZvOHJtOVVHQkFUZUZBbmtzMGkvU3JJNWFvTXl1RDhT?=
 =?utf-8?B?cllubUFSMTNIU2NJcEtnT05ZZHZTakVPS0x3Sk5PZzJuWHhXZWJmZzZ2R2ds?=
 =?utf-8?B?Z0tWcWU1aHBwdEFxWjRwdG50c0g2VlVjcVZ4djNmVjZ4T3Z5T0JZaDVTZkI1?=
 =?utf-8?B?cmUrWjdKUElCQ3ZuMFA2TmlBcGdZZ0wvTC93LzhlNHU5cWt1SHloYVIyaE5m?=
 =?utf-8?B?WlhUZzZLRklqakE5c1FGWXYxbktpOERnVGlnK1pXb1lKZmp1WUFBZzVjUVlq?=
 =?utf-8?B?VDYvek5iWjdwUTV6Nzh3Wk54VW9Hbmw4djE2bldvQU1uRXdxTkp4ZG5COUhn?=
 =?utf-8?B?RU5qTHBselpBU1IyUkFzbVh1Tjh4NXVtdUhuZkVsb2F4eDhyVVM4N3RFaCs4?=
 =?utf-8?B?QUhrUHNTS0xVa1hFV1p0V2NiT01tMEZmUkZNdG95WnVHNDBlNmI3U1JOZkpN?=
 =?utf-8?B?ZXBjbmtBVm5MdFFoVU1Kc1U2Z2xaclJyeEhwWml4VVB4QTJZa1pUOTVrNVRt?=
 =?utf-8?B?eG1rcWg2WUthVkdKRGt4REdXcFRSQjFzZmhkc1FIUk5LUEFpRDhOZWhBU0N1?=
 =?utf-8?B?ZDBac2krTzNJMHpKRUpuSnlEOEJvdW1rT0NSTXJLdldSc0ExTzdnRDJiaTdH?=
 =?utf-8?Q?godRMJPCw8N8V7MkMvaW4R5Xw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7784ecbc-79dd-415d-2df4-08dc5804c8c6
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8403.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2024 19:47:55.3023
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v3JICGSwoSAjXDZ0MRxhPwqGk9wk8nGAoSqlhM22YxsH2N8OiWbKpAS5SkOPoXouJRIYYgX1hYWHNyJjnC21AQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9157



On 4/5/2024 11:06, Luck, Tony wrote:
>> diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
>> index aa27729f7899..a4d09dda5fae 100644
>> --- a/arch/x86/kernel/cpu/mce/core.c
>> +++ b/arch/x86/kernel/cpu/mce/core.c
>> @@ -207,6 +207,8 @@ static void __print_mce(struct mce_hw_err *err)
>>                       pr_cont("SYND2 %llx ", err->vi.amd.synd2);
>>               if (m->ipid)
>>                       pr_cont("IPID %llx ", m->ipid);
>> +             if (err->vi.amd.config)
> 
> This is in common code. If other vendors start adding their own stuff to the
> "vi" union you might incorrectly print this.  Add a vendor check before looking
> at values inside "m->vi".
>

Do we really need an explicit vendor check in this particular instance?

Below is a snippet from __print_mce() after applying this series:

    if (mce_flags.smca) {
        if (m->synd)
            pr_cont("SYND %llx ", m->synd);
        if (err->vi.amd.synd1)
            pr_cont("SYND1 %llx ", err->vi.amd.synd1);
        if (err->vi.amd.synd2)
            pr_cont("SYND2 %llx ", err->vi.amd.synd2);
        if (m->ipid)
            pr_cont("IPID %llx ", m->ipid);
        if (err->vi.amd.config)
            pr_cont("CONFIG %llx ", err->vi.amd.config);
    }

    pr_cont("\n");

All of the above registers including the newly added config MSR will only
be logged if the smca flag is set in mce_flags.
Doesn't that already serve as a vendor check of sorts?
Something that I am missing here?

-- 
Thanks,
Avadhut Naik

