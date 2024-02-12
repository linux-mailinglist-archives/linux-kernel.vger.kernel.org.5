Return-Path: <linux-kernel+bounces-62278-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76896851E00
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 20:40:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 001001F22F88
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 19:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A18D747793;
	Mon, 12 Feb 2024 19:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="sSQ68kiI"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2061.outbound.protection.outlook.com [40.107.93.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41111E522;
	Mon, 12 Feb 2024 19:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707766828; cv=fail; b=LsBufYFTJvrCsxdt6F576YoA9s42+TXL3vothPS2MMDkNIOr6fTMx5n/RxwSt9VuuAveSsWH6ZDys65dRmJf0Gu8LNLdOIsU1T+zbevzxAsdj9Ewwtja+qZhHPiiJMjlVbtCzT07imKU6mhiSdM2G3P4UEPU0w2Pp8dyiLWnJOU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707766828; c=relaxed/simple;
	bh=rPQ138zFjPwBtW+VqmIrLkBgQDN5bTDy3RfZuGPjWrc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jAGOin+Xk8PV7L+0pfModIBedmwBg73azM0U6ozME2r8Hmby1FZX78o9efUUJJbeOaPPjW7uCJzl5/xdRrVqcXAA0k8Xhj0fkzDOkV9puFkiG4ZYy/UsM3KxYjfwytoUDAfBDlVhDTze+jB1WR6fE123GUln/DOXDn2v2/A+sU0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=sSQ68kiI; arc=fail smtp.client-ip=40.107.93.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mVdH+wWWD2NBiM+tOgNAdc3VWmV2nNSJnlkeWsgFnMrY4RPiVIIzHvWgjpyFVDD3KnDYXf0u6fLL1Q7fTcGAaL+rnj426P22e0/IC3bBgCXYfhmFruXJwGBfA+ZwIfXGSyYMb9PaGkpN+IpBtPjpGwnFjoHezdRDZworjypwApRqGmgLhuu0/YpqC8ryen+2UuW5NfAzJaM4LWonWjF535Wdv37A5k7n2HeoootNWqsRfkDKrw4ucTtrb3PFCc/9U8GSb3lfMoh2xX3L0hosa2frgjiiWqqqUpO3wOznFGJEFUFe91Mf311h2qIoAqPu1IDU7PGZjREZzsM3p9SV7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uenu68UTtPsWxh29aGhp1AqsHTMN1/deSx250raOc3c=;
 b=YO+fXD70LpozpaYvU/17xxcB7PVPO0skwzZWWGXeYZTUGcPgv9aWpkz1B9ktq/VOMwq0qtSb9NRsyCk4v9KD4IJl2ItrHVroCYb+nA8Kcs+ku9LAXRBjAYPGjqnt/E3uQrZ06m2YRtquMFcQyQ8JPwVNdkxbPSlI2aIq2vC6pMy+cHBL9afVNdEVyc4p+6/D3mXD+EGfwMrzbBhpKnqNIyPCbJxYcF2tVH/dF1UwTBGJkF+AAjLKPjbJQ0SlacBKssdfa2iLk6GxDoeSRuuQ9TXoelpqirdsWuuFXTQZGQMdiqptEQP+CDMa4p6619FyrY9dfzqOgBGkEQaUr3u/VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uenu68UTtPsWxh29aGhp1AqsHTMN1/deSx250raOc3c=;
 b=sSQ68kiIHDplwo1zFk3SzUrE+WrJ3EwXJR/bMMF7djp7u9Ac+d9pSi34Pro2U77PmUsrx1M2PUK3XNnDX36gK7cMys5Z5NPBH1XWnY9HyVtnLJkpFS0xFEGMB47oNW+SU5wNWCwbKlszZVWUKwkikoW1KG3Zudg6Y58fA4gLT+c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB8403.namprd12.prod.outlook.com (2603:10b6:610:133::14)
 by MN0PR12MB6102.namprd12.prod.outlook.com (2603:10b6:208:3ca::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.14; Mon, 12 Feb
 2024 19:40:23 +0000
Received: from CH3PR12MB8403.namprd12.prod.outlook.com
 ([fe80::ea0e:199a:3686:40d4]) by CH3PR12MB8403.namprd12.prod.outlook.com
 ([fe80::ea0e:199a:3686:40d4%4]) with mapi id 15.20.7292.019; Mon, 12 Feb 2024
 19:40:23 +0000
Message-ID: <1cf19ecf-4785-48c9-91ef-4ca3c965f568@amd.com>
Date: Mon, 12 Feb 2024 13:40:21 -0600
User-Agent: Mozilla Thunderbird
Subject: [PATCH 2/2] x86/MCE: Add command line option to extend MCE Records
 pool
Content-Language: en-US
To: "Luck, Tony" <tony.luck@intel.com>, Yazen Ghannam
 <yazen.ghannam@amd.com>, Borislav Petkov <bp@alien8.de>
Cc: "Mehta, Sohil" <sohil.mehta@intel.com>, "x86@kernel.org"
 <x86@kernel.org>, "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
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
 <b5904910-ed58-405f-9425-566383b48068@amd.com>
 <SJ1PR11MB6083CF3400AD2F2047D65E17FC482@SJ1PR11MB6083.namprd11.prod.outlook.com>
From: "Naik, Avadhut" <avadnaik@amd.com>
In-Reply-To: <SJ1PR11MB6083CF3400AD2F2047D65E17FC482@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR03CA0202.namprd03.prod.outlook.com
 (2603:10b6:5:3b6::27) To CH3PR12MB8403.namprd12.prod.outlook.com
 (2603:10b6:610:133::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8403:EE_|MN0PR12MB6102:EE_
X-MS-Office365-Filtering-Correlation-Id: c017a322-d6d8-4817-7e6b-08dc2c02746b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	dxYLsjT3kkCX3d+w9A8ag08/hWqWsg6dUf3//3CvZ8NSTdr/zxHyQF3FJ8f/8fnjg68RoamEEJ1KPe80azHwqV+DD4zR0iiz07Nvk7OzoXZkMPlvJOQO8NYuTGil7NzMR56xRwUSvvZxnW9d/Uo/n5X4aL5aeZNMgiyRmarvtmc2reJ2KRviRUg2CsPxZq8E024RjgWd5Wx3Cpyv1BdFIH/KSXJ5gR3ZIsmwtOelwBoBu/OZCQ/r7Ds0qdbCVVsWaihHcQqax9I69Zgpi2VgEwVY/G5Vamgsb0ru3Y9La62rI/P3ZJpBSyaMLsAFjH6QOjSwRtlS0cVtstLwWdB8GPZAUj0sowEHT+/wA/0Hqetf4u/bH9O/EDbpoqYCs6/T76XLxmjzUUPm1gnWbrpPryxFuSeDc3N5+7a/tN7hwJW/YUsT1cpESVADcMtcPr6lH15YUT8wyfSQ8FFHjVZsllwXZJD4umCR4HY3hkq/BWtDpeySFYylNWdBl8jDEM7SIOdbV8k/JHF+OfMLk16rf2hr9yL5nhl3UZqXxyiAOTlqor75k71iMN8HEmMTmo5z
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8403.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(376002)(346002)(366004)(136003)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(6486002)(31686004)(6512007)(478600001)(41300700001)(8676002)(2906002)(4326008)(5660300002)(8936002)(66946007)(53546011)(54906003)(6506007)(316002)(66556008)(66476007)(2616005)(31696002)(26005)(110136005)(83380400001)(36756003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?KzYxUzhVTGlsM3kyQU0wL1VnT0VseUtvSldDZVJKYVlncXR3MlFPSU92MlJC?=
 =?utf-8?B?dEVWSUQvU1ZEMG1aM1VJZkxrL2J0MXpiY1VEQ2ZBanFMYklXUnRYZTFQY1M1?=
 =?utf-8?B?NUpzRVNWOHg1Sng5a0NqMXJSTjMyL0QvajhXMUdUTi82dUE0bkZvVGppVDlG?=
 =?utf-8?B?b2hOc2o2Nk5lY04rNzRjelNYWm5Ub2U0cU0rWXUrZU83VEVTUGg5dHNKZmNK?=
 =?utf-8?B?WU5zTU4xcDVUdW1WTEowdUg4eG5vUjFlMXl0YzVuZExWU2xqNTQzcWRFeklh?=
 =?utf-8?B?Wmk5a2JDTWNlMU5VR2daYWlEeE0vYk5QV0hRSWRJWjluc1ZMV3IvNGZmei9O?=
 =?utf-8?B?djhXbUtoSFVmcFBLRmJDQ1dDM0UzQ2g2ZDZmTzdqbE5tdWVrdjBmd1lJVnBt?=
 =?utf-8?B?U2Nrd25DRlhzS1B0ZFp4Z2tLaU51UFBSM1VxU0VueEVMaFZyeFlzcWptK0Uz?=
 =?utf-8?B?b3M3L0pydDZ3akJKYS81RU51SUR2bmlnaHZVWVFqMTA4QmZPSCt6ZWlxMkRP?=
 =?utf-8?B?WlNyaWRNamRNZ29KWERKcmdCdGR6WUpKZU9mWXRPeXBxcGloL3c5TjNmUDBw?=
 =?utf-8?B?UmJ3b2M4RGtKU3Bwd0pJMTZJbUFVM3JZZDNOL2l6RjhZdjdWNU5wTjZoV0Zr?=
 =?utf-8?B?NlVwUmNwZEtPelFIVHJSVERkaDAyWmkzZGRYYXpTbGVuRTQyQzZ3WWkycUpO?=
 =?utf-8?B?cjFKVjYrNXNSRDhTRHNELzF0c054OVFUY05BOE1pYnNNNW1vdWExYkI0aWho?=
 =?utf-8?B?Wk93MlFUb3JCazFwWVJuYVJLV1lFOVlJRm9zNEZwd2Nia3NGRjFzS2Z1cGZ0?=
 =?utf-8?B?cEhTUXNvT01nc1NnRmpjQmZLTTBkZWtkTnozdFFNTGNRODhsN09mczY3Q1Vq?=
 =?utf-8?B?R2gyam1lN2pEdFlwYmVjbVBZdExvSkJSbUt2SzF0WGZDOGdQa0pGcDJhWVBY?=
 =?utf-8?B?TUIrRDAxV0daaVZUZ09raWZMNXAxNk9rOHZhOGZKWXJ3aDV0aWkyWTdua2Fp?=
 =?utf-8?B?dnZ3LzEyMWVsT01rYk8vWXFjaVNZSHpmNm1GOTZHMDdWT3ZXNkVEdEhvMGhv?=
 =?utf-8?B?QUJBbXJ4YTZqazl3OEIvdnBQOU1MaHQ5YWRtcDBDQkNGUmZqT1FnQXgzWlBP?=
 =?utf-8?B?RHdRYll6Rnc4eGJjWVlCT3l5M0preGtSOHpvd2tVNnloeUFlMG44RjE5MEhq?=
 =?utf-8?B?OGdmeW9VZ0wzWVFGSVgvQVFLc1RMTG9KdmdBTERBdTVDTHFWVzhZWUxubjZO?=
 =?utf-8?B?SjZmeEhxZ3gveTg3K2xla2pkVGlGNmZKYlI5MWpLVFVxU1ovbkdQOXhtOW03?=
 =?utf-8?B?ak5RNVh5WkJxblhYbktzNHlXaHVoM2YrdXlUZDRqRkNqZDJZWDFFTU9ZeDJ4?=
 =?utf-8?B?NGFHcmpxRTJCK3NWODltbjJ2THJzU2lnbzdBK3hWa1M0RDRqQUZVNytmSHM2?=
 =?utf-8?B?ZXExWXVpcEE4MHNDMWJLRFRmYk5SSkJLMm1kSDBla25GRTNiT080cUljOFdG?=
 =?utf-8?B?K0dWTWIxR1NCdEE0MnhoVFNMWjUwb1ZZaGlqSkZ1a1hlZXlQREJSRXZ4a3k2?=
 =?utf-8?B?Nkw5UWc0Si9EUmhyV3VQcmVQQXFMcHM3bDd6ODhSTjNqeDJFZkMyMVJyVXFv?=
 =?utf-8?B?NzdDdTdsQ2FDNW01MDJkNnRFL09WT0dRZ3ZoMGxyZ3JyeG5jeDQxVGVJQlFC?=
 =?utf-8?B?ZG4zRUJMTEVLd2syNWlnUDdBM1oyd0VXS3QwT01pdGxxdUNSZCtJQmF2cUdk?=
 =?utf-8?B?amF6dEZYZVFHcmNSNVdxUFdBZGszb3YrVDFyRXJPVWwyRVE5VFdDRVVGWHJh?=
 =?utf-8?B?YmxBdUpnQ2gvb0VRa2szTmxzT3RkTkxEVU55ZEx6U2s4MUIwNDZodll1c1Nh?=
 =?utf-8?B?RzdsV0FibCsxdWFUa2FMb2d1NmMvRE1WZ1dyNVBXU25kR1YyNmRPb1VjbXNZ?=
 =?utf-8?B?OWVGQ1BWMzJ1MUVEVEhSRGllUWhjZ2M5MzlMeGN4Z3ZGQ0syL2J3ZlRITi9M?=
 =?utf-8?B?UWswZ2dtTjNGRlpwRmZtZnZOSzJUR09oay80dnU3TitBNUJaSHZrOTJUMmU1?=
 =?utf-8?B?bk91aDI0T0h6WCt3UzUzL0RtbGt4REFXQmZZbUpBNEI5ZXBPc09EUld3UWRD?=
 =?utf-8?Q?rwh3jhmyJiDORb/y5TrNV1BDF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c017a322-d6d8-4817-7e6b-08dc2c02746b
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8403.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Feb 2024 19:40:23.6303
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kQZnB24YZTxBg3r7IX+3QTq7derHuZsf7rwrr9Zhh/qLVCiB2R92kgVD/Y747cfC66fkBSXKPR5yMq8iuUHoeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6102

Hi,

On 2/12/2024 12:58, Luck, Tony wrote:
>> I need to look more at the genpool code, but I thought I'd ask too.
> 
> Yazen,
> 
> gen_pool_add_owner() is the code that adds an extra chunk to an existing genpool.
> 
> This bit doesn't look obviously safe against a #MC at the wrong moment in the middle of
> the list_add_rcu()
> 
>         spin_lock(&pool->lock);
>         list_add_rcu(&chunk->next_chunk, &pool->chunks);
>         spin_unlock(&pool->lock);
> 

Even I am somewhat confused by this.

The spinlock is mostly held to prevent other primitives
from modifying chunks within the genpool.

In #MC context however, we are not modifying the existing
chunks, per se.

While in the MC context, records will be added to the genpool
through gen_pool_alloc() which eventually drops down into
gen_pool_alloc_algo_owner().

gen_pool_alloc_algo_owner() iterates over the existing chunks
within the genpool through list_for_each_entry_rcu(), within
an RCU read-side critical section (rcu_read_lock()).

Now, the below description of list_for_each_entry_rcu():

 * list_for_each_entry_rcu  -   iterate over rcu list of given type
 * @pos:    the type * to use as a loop cursor.
 * @head:   the head for your list.
 * @member: the name of the list_head within the struct.
 * @cond:   optional lockdep expression if called from non-RCU protection.
 *
 * This list-traversal primitive may safely run concurrently with
 * the _rcu list-mutation primitives such as list_add_rcu()
 * as long as the traversal is guarded by rcu_read_lock().


Makes me wonder if the genpool can be extended and traversed
concurrently.

OFC, not sure if gen_pool_alloc_algo_owner() being in #MC context
makes a difference here or if I am missing something.

-- 
Thanks,
Avadhut Naik
> -Tony
> 
> 
> 
> 



