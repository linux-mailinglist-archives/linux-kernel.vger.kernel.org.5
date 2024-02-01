Return-Path: <linux-kernel+bounces-48326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5BB1845A64
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 15:35:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E77D290882
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 14:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2EF553392;
	Thu,  1 Feb 2024 14:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ro8rrW9t"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 929C05D497
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 14:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.55.52.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706798133; cv=fail; b=EmW72YOUzHssVKHvYod7yw/lkZIcUwfrQwIdJGjcwJNQwM9DvfDdYVjoiYVdwVL4XUgnn4gF3Qy+ADZC4mQ4yhkFKMyH4y0QISIblk7VsW1lz/cYf7KOZ4HNlb3wiMriMlcqyUsDTR7xXr98dMrwiTR2r7FhSg1rvXKnZYbzIow=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706798133; c=relaxed/simple;
	bh=gCu4SraMRTO3mRlQGOHmi6lvY+q6pyxVDuYdlYb/pfw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AVtS3RMNaEvbBf1FIx1R3NmOIuiOcZZrOQcaSmXmmoDQnTONRI12zv/vdxIvJ32DGh+9T00hfvQeYaBrkPSP3/ekun/1C4JQvQh7WRwwn3CDfUdNgH4ol78iTwkGToIvObPGa9LOqIrgWdRnmskmbsr5Mj0Fm7Lj9eC/PBAo7XE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ro8rrW9t; arc=fail smtp.client-ip=192.55.52.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706798131; x=1738334131;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=gCu4SraMRTO3mRlQGOHmi6lvY+q6pyxVDuYdlYb/pfw=;
  b=Ro8rrW9tKoISxBQvpeBYZczv0PTR/gCXOQyVexQtIAptF5ohjw5d14ka
   QAO+vAFzN7OVLMqYjs7ECBAAgUrApenleinKUtw9HgOPAGG9WUozW8LLP
   ohVKY8pRXLXtbXEZQSiFMRcBPl/WuylthCSHXnTuXUl7lHZO7InJTS5ie
   p+jZqlknAmAyaZPBbK4mCuqelcDh88p+JMOpOb+HhtWrd3BwoDpB1bi5S
   t6Qpwis7+2WvSD0l4eyinGYHUDZ3bW3PnkPKptz56pGuZAFGpXAV3hALU
   HQgGtz10ofy1MYHDFyM84zkHE3uxKx/0j1Rq7YwjnufkyUDtTO/m10DOO
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="401037377"
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="401037377"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 06:35:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="30611094"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Feb 2024 06:35:30 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 1 Feb 2024 06:35:28 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 1 Feb 2024 06:35:27 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 1 Feb 2024 06:35:27 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 1 Feb 2024 06:35:27 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MCwufxbGmAUCxbDtRZg1RRO/BBQCuBtOOhuIc3KDCdM9X3IWVJl/ATXes0FZhH/LTCNYNHglGWjEfMB6o9FZVlulSjOhtUCyQX82BkNqJgoF5zuk/lp4Ww49A+uO3eqxX+AOGDzBB7b4N8Zzsz9dQ1SvAvgrxJN/1iZ1YC2tviLD+KzZ+GdaMaHM9m/e3vJ9A28k14GHOXU01jr255hcQVw97ZNPW64egCZS9lbgCRGZl3ihjyxRv0Ldtqy7QEgxCltN6TMn5P9aBnbF2MRVxeKbEJ9Y10fAmfAbyKkm1tLmyConc9Qxm0KCRB/qIJ9NGzO0QgvQuDmoVhiPtUnDDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N6luWbW1WtUD/1pd/WWhgaQTc8UNerJz+cCZT5FR3D0=;
 b=N/RJTWoPw2GlTjI2mfNCM3Yjp1n+ZNyOMBqU+hjJSUTBvsCdWr6Pfa0Z1mYV7BiKjg+6nF6TBVcgOxsQ5XYL08dHuUlFBb0Ly96GbLKJUYdawWfub0g3+ICL0aI6NAwb+0snLrSWR9nF9HAfg4ddKI2K1PGmZZaHGO74BQeqFYM/Pz0jBYi0mG4wxJcH2t5oVS0i04yEE1eFAo3A+OI3s9pe94deajCFYW6BdOljIDFKW6YxBQedxDW/cdR28ftPUw9OYWdKiUxbiY/ofPSmxqkJ5Nw0chs/PD7gzgX61rRbCLp+0WLnBlHNc2LwhvrPYCCPbhVcwFG0IrMs7S86qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by PH7PR11MB6379.namprd11.prod.outlook.com (2603:10b6:510:1f9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.26; Thu, 1 Feb
 2024 14:35:19 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ff69:9925:693:c5ab]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ff69:9925:693:c5ab%6]) with mapi id 15.20.7249.024; Thu, 1 Feb 2024
 14:35:19 +0000
Message-ID: <a139b1e0-7737-4c20-842c-64457dba17ca@intel.com>
Date: Thu, 1 Feb 2024 22:35:06 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] x86/kexec(): Reset TDX private memory on platforms
 with TDX erratum
Content-Language: en-US
To: Dave Hansen <dave.hansen@intel.com>, <linux-kernel@vger.kernel.org>
CC: <x86@kernel.org>, <kirill.shutemov@linux.intel.com>, <tglx@linutronix.de>,
	<bp@alien8.de>, <mingo@redhat.com>, <hpa@zytor.com>, <luto@kernel.org>,
	<peterz@infradead.org>, <thomas.lendacky@amd.com>, <chao.gao@intel.com>,
	<bhe@redhat.com>, <nik.borisov@suse.com>, <pbonzini@redhat.com>
References: <cover.1706698706.git.kai.huang@intel.com>
 <b52ed259e0d487b3a968b98da91cb4f55a28ae82.1706698706.git.kai.huang@intel.com>
 <12a927df-e437-40ff-ba4d-ceca5446c5b1@intel.com>
From: "Huang, Kai" <kai.huang@intel.com>
In-Reply-To: <12a927df-e437-40ff-ba4d-ceca5446c5b1@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG3P274CA0020.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::32)
 To BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR11MB5978:EE_|PH7PR11MB6379:EE_
X-MS-Office365-Filtering-Correlation-Id: d041bf95-3eca-4aa9-116c-08dc233303c1
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Jxe9Awi0EUsGddqPk1CLg80GKQInJJ/SaaNjbP0ALLA3GNgJCxsNzSi+3w3MBTTK05LJ5RYVpXvyGahMw/m8poZee90m/ELDODXhm7qV47TnD9mUdrpawncIgGApbiZpFesCGUdOk8+yEceptIFw+UttxzXQS9mSrK6QL7tOeRMGdldUiixAMqt4KdBuvAC05KMM9XzwP1ta8AXUIYO8axn8GjgDNy7HSHTxmTpkKQXkkDqbZCtFeyHHDKNcLld/CKyIjZYrMZzq3NJw7/+9hKCx+2jLylXWL7VJl3adih1LXne0Cbh5OzVSs14WRAwVvOlk5tlaxV5876ORuM81J5+PLD8E+xVXj6hi4mZ3KNZbhPAU06eIBpzrTEqr1yWTN2VqBjCz8FgkWZuYq39+qQ05MHqTf+W7/3IakYbAo28mIIhNMrxNAWITnfL+kC/N9KtdSqKUwwxhsDyDzlm0mo54VzSsHj4suB42XzPTBHAYYr9m8tmi6JotrRTDtoiN/ZT0iWqJa379T060ynzDzsHFF2nVn/wUBqQbZ1bGTknj65TPTr+5pLunoRPMA8BSa07p5zEFhlcSAS69MyXpnJe9X//naR8s2EtVmQgqpodZKkxRuIeHOQh5G4V+bRjWGpfD339c7RbeYXKaL1E/MQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(136003)(396003)(366004)(346002)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(66899024)(6512007)(2616005)(6506007)(6666004)(53546011)(26005)(36756003)(478600001)(83380400001)(6486002)(8676002)(4326008)(2906002)(82960400001)(41300700001)(5660300002)(7416002)(31686004)(66476007)(66946007)(316002)(38100700002)(31696002)(86362001)(8936002)(66556008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Qy9abXEyQkNiRERiSkZtV1ZmeWxnVjRLWldFQVQ3TTQzWU5XVjFIMnFNVE5q?=
 =?utf-8?B?MlBFTXVkL2xYTFhtOTlneTkwR0lHQTZ0bU9kemY5bURFRWVxL20vMkJaWXZY?=
 =?utf-8?B?QjhmbnpDT0ltak15WUxaaHl3ODVOblBmWlpGMlNPQWNzem9BRjJwbVZiUFlq?=
 =?utf-8?B?UzZud1pSY0NoUjFYc2ZZOWVyb3FRTEhSYThiU3F4YkpaRHlkK3JKbithRzc2?=
 =?utf-8?B?eFhtK01qT29Qb0dJaFIwc0Y4Ukd4czlISHEyMkZaeTZQaDB3aVRFZmtPRlhz?=
 =?utf-8?B?MGhhblJpY1A3TDU5d3BOYUtoQkJjVDZZZ3ZwSGVlZENGbkFDaGpKTFZaQzJa?=
 =?utf-8?B?d2w4bWUzZDRWVURYeitDZDJCTlZxUGdTd2pWWEM4VVZsVFFib25pZC9tYUQz?=
 =?utf-8?B?Tzd3SEhxakxNQ2NRY0xLT0ZCak1KVXdteUNBcDV4Y3VJMWUrV21CTjVGY0Z3?=
 =?utf-8?B?d0IrbkpxVURhcEhGcFBvTmVqWno5ek9NVi83Z1hUY2VaOXFSTTBPaUZ4dGl5?=
 =?utf-8?B?RXpOVldjNFZsTzhLWmRrckpOcWthZWp2SzFFdjF5OW1waE1paEd6Vk0yRnJI?=
 =?utf-8?B?VmpFcUNJZkJzMzFNUFZublEyUUJuVWdGUy9zMnVnd1lFdWRoZUJUcHF4c0oy?=
 =?utf-8?B?S2x2ajBFbGU5ekhFdldsYnkwTGZsUUJUV3ZhYmRtanNYdDJtdTZyV0ZVYWZ0?=
 =?utf-8?B?dzJ3eUlMVVNTQS83VFJnVUNNUVh3MDJlM3JPb2x5Y3BxQkxFUXhZUGxBbUZz?=
 =?utf-8?B?NnY4ZDVMdkd6ZzZpTElEenBnb08zSUxvUlhWcjVkVWtrb2N3TU5JZXg2aXEv?=
 =?utf-8?B?MklSRUZYQS9qdXhLRnlIckltOFNUTmR4cEJvZ3J2UmNqOFd1aHd5dnEwdUw3?=
 =?utf-8?B?S3AvK0R6YldLNy9NdzJpOEgwMFZZZHpWZXNDYnA5cHZiZ3NhcGFrTFFBeVAv?=
 =?utf-8?B?MCtJTmtXWmlpaUZWVVJmaGo2NVlJZmtHU2ZWaTNOa3ZmZkk4Y1VkbXd0ZzU1?=
 =?utf-8?B?ak5WMnlpOGUrUXNlQmY5YitkQzNOQmIzMFMvNUtJZWhsNmRKM0FQcHFxZ2Vq?=
 =?utf-8?B?OC9Lb3h5Z1ZKWWU4MU15ZG8rOUlhSHNWMyt2U0ZVMGFaZWhKZEtMdjBabWVq?=
 =?utf-8?B?OUZrQ3RTVzNoS1NNVnp0OE4xUGZjMzRSZG10K2VQN1JiNXJqSDQ0alhqdkl0?=
 =?utf-8?B?ajhDSVY5T1BidjlDTzRyczFBU1NDaCtRUUcvYjk1VzJiVkVkVVVuVjZKQklR?=
 =?utf-8?B?cTF0Wlp5SS9mWEVIbVlOcllsTERvNkh4QllNdWl4YlpZMFAwYmRrZkMyV1Fn?=
 =?utf-8?B?OWxFREZ6bEI1SkhvVk9RUmpQSjNQSDZ4dXJMejlHSGJxanJUNUtScUt1M25k?=
 =?utf-8?B?bmxhNDM4M210QzFTbncvWGYwRytPbTlBRlMwS3BjVDJsdlpyNStOTTRmeG1K?=
 =?utf-8?B?MXNNTzJqMHdmT3ZpaXJHb0MzYWZCL2F2QmY2Um5Zdkx3MXhoY1B3VDQvbDB2?=
 =?utf-8?B?ZHFoVzR4dTdSazNrMkVRU1lLVWoyZ1N0OUxtZ2hOc3Byb3JxakhRaWxHcCtD?=
 =?utf-8?B?eDRwNld5MVZBWC9nM2QzNnJvMGZjZ2tuS0s0czFRZ1dFbmtUY2xPcXZPVmFD?=
 =?utf-8?B?NFFEUlRSQ0RwaDFXUXZyaGdqdHc2a2liREs5MTlkUmhOM1EyT2dVbkpYN3Jl?=
 =?utf-8?B?MThhR1NwT2NjUHVkeVk3RlFQaTJYZmlrMlM0a0RKTkpiNG41akoyMWlwM3h4?=
 =?utf-8?B?ODFUMTUyYWYzcmxSMGhmQ251dHNuT0NNNjhReFBTTlQvWkVQOWNGcVorWHkz?=
 =?utf-8?B?WHc3MmRkWldRb3dHUnZvelBRV1FXMkpEY3NDNFFDSTJaUlZrMVlFSE5Dc3Bp?=
 =?utf-8?B?dGZFdkhqcmRucDQ3QjlKYlo0bEIwSldLdE9OQlZDVm1LeUlWZ21XSk9CZ3ZE?=
 =?utf-8?B?cWtrWjIzSUQwZmdVbUllV2QvTVdGYWNvZmRhdUJqa29XOEdBQS9rdTBhNDh6?=
 =?utf-8?B?WHZValBSNVdabFcwOGRMWUV6dUJFL3ZLZzc2REF2SUd3SnViaU51YWhpN1gz?=
 =?utf-8?B?T3drYys2cHpCZmFpMFFCcCtGbUtvMGF5ejlLYjl0b0c1azNVcWhyZWdRbGlk?=
 =?utf-8?Q?PQ+Ak8yb95hVYXtls0BfYvmOh?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d041bf95-3eca-4aa9-116c-08dc233303c1
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2024 14:35:19.7013
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2jmABsLCs1QOydbIV5zmF7rTlYJ02izd3KuQPp1K6yQwNrsCPdh0G+lu0Pc1j+EKyhV0f7bGQWUM+xC9l+M/sQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6379
X-OriginatorOrg: intel.com



On 1/02/2024 5:21 am, Dave Hansen wrote:
> On 1/31/24 03:31, Huang, Kai wrote:
>> --- a/arch/x86/kernel/machine_kexec_64.c
>> +++ b/arch/x86/kernel/machine_kexec_64.c
>> @@ -28,6 +28,7 @@
>>   #include <asm/setup.h>
>>   #include <asm/set_memory.h>
>>   #include <asm/cpu.h>
>> +#include <asm/tdx.h>
>>   
>>   #ifdef CONFIG_ACPI
>>   /*
>> @@ -298,9 +299,24 @@ void machine_kexec(struct kimage *image)
>>   	void *control_page;
>>   	int save_ftrace_enabled;
>>   
>> +	/*
>> +	 * For platforms with TDX "partial write machine check" erratum,
>> +	 * all TDX private pages need to be converted back to normal
>> +	 * before booting to the new kernel, otherwise the new kernel
>> +	 * may get unexpected machine check.
>> +	 *
>> +	 * But skip this when preserve_context is on.  The second kernel
>> +	 * shouldn't write to the first kernel's memory anyway.  Skipping
>> +	 * this also avoids killing TDX in the first kernel, which would
>> +	 * require more complicated handling.
>> +	 */
> 
> This is waaaaaaaaaaaaaaay too much information to stick in a generic
> function.  Just call tdx_reset_memory() and make the argument about

Hi Dave,

Thanks for review.

Agreed too much info here.  But I don't quite understand your second 
sentence here.  Can I have your suggestion again?

> 
>>   #ifdef CONFIG_KEXEC_JUMP
>>   	if (image->preserve_context)
>>   		save_processor_state();
>> +	else
>> +		tdx_reset_memory();
>> +#else
>> +	tdx_reset_memory();
>>   #endif
> 
> Wow, that's awfully hard to read.  I really wish folks' gag reflex would
> kick in when they see stuff like this to get them to spend an additional
> 15 seconds to turn this into:
> 
> 	if (IS_ENABLED(CONFIG_KEXEC_JUMP) && image->preserve_context)
> 		save_processor_state();
> 	else
> 		tdx_reset_memory();
> 

Yeah this is way better, but as Kirill pointed out we will have build 
error when both SUSPEND and HIBERNATION is off.

Maybe below?

#ifdef CONFIG_KEXEC_JUMP
	if (image->preserve_context)
		save_processor_state();
	else
#endif
	tdx_reset_memory();


>>   	save_ftrace_enabled = __ftrace_enabled_save();
>> diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
>> index 9f1fed458a32..0537b1b76c2b 100644
>> --- a/arch/x86/virt/vmx/tdx/tdx.c
>> +++ b/arch/x86/virt/vmx/tdx/tdx.c
>> @@ -28,6 +28,7 @@
>>   #include <linux/acpi.h>
>>   #include <linux/suspend.h>
>>   #include <linux/acpi.h>
>> +#include <linux/reboot.h>
>>   #include <asm/page.h>
>>   #include <asm/special_insns.h>
>>   #include <asm/msr-index.h>
>> @@ -54,6 +55,8 @@ static DEFINE_MUTEX(tdx_module_lock);
>>   /* All TDX-usable memory regions.  Protected by mem_hotplug_lock. */
>>   static LIST_HEAD(tdx_memlist);
>>   
>> +static bool tdx_rebooting;
>> +
>>   typedef void (*sc_err_func_t)(u64 fn, u64 err, struct tdx_module_args *args);
>>   
>>   static inline void seamcall_err(u64 fn, u64 err, struct tdx_module_args *args)
>> @@ -1187,6 +1190,9 @@ static int __tdx_enable(void)
>>   {
>>   	int ret;
>>   
>> +	if (tdx_rebooting)
>> +		return -EAGAIN;
> 
> This whole 'tdx_rebooting' deserves to at least be in its own patch.
> Also -EAGAIN seems to be a really odd return code for a permanent failure.

Will move to a separate patch.

How about just -EINVAL?

> 
>>   	ret = init_tdx_module();
>>   	if (ret) {
>>   		pr_err("module initialization failed (%d)\n", ret);
>> @@ -1420,6 +1426,90 @@ static struct notifier_block tdx_memory_nb = {
>>   	.notifier_call = tdx_memory_notifier,
>>   };
>>   
>> +/*
>> + * Convert TDX private pages back to normal on platforms with
>> + * "partial write machine check" erratum.
>> + *
>> + * Called from machine_kexec() before booting to the new kernel.
>> + */
>> +void tdx_reset_memory(void)
>> +{
>> +	if (!boot_cpu_has(X86_FEATURE_TDX_HOST_PLATFORM))
>> +		return;
>> +
>> +	/*
>> +	 * Kernel read/write to TDX private memory doesn't
>> +	 * cause machine check on hardware w/o this erratum.
>> +	 */
>> +	if (!boot_cpu_has_bug(X86_BUG_TDX_PW_MCE))
>> +		return;
>> +
>> +	/* Called from kexec() when only rebooting cpu is alive */
>> +	WARN_ON_ONCE(num_online_cpus() != 1);
>> +
>> +	/*
>> +	 * tdx_reboot_notifier() waits until ongoing TDX module
>> +	 * initialization to finish, and module initialization is
>> +	 * rejected after that.  Therefore @tdx_module_status is
>> +	 * stable here and can be read w/o holding lock.
>> +	 */
>> +	if (tdx_module_status != TDX_MODULE_INITIALIZED)
>> +		return;
> 
> kexec() can't happen until after reboot notifiers are called.
> tdx_reboot_notifier() makes 'tdx_module_status' stable, so no lock is
> needed.
> 
> Right?

Yes.  I can replace the comment with your words.

> 
>> +	/*
>> +	 * Flush cache of all TDX private memory _before_ converting
>> +	 * them back to avoid silent memory corruption.
>> +	 */
>> +	native_wbinvd();
> 
> Since this is single-threaded, it also needs to mention where all the
> other CPU caches got flushed.

OK will point out.

> 
>> +	/*
>> +	 * Convert PAMTs back to normal.  All other cpus are already
>> +	 * dead and TDMRs/PAMTs are stable.
>> +	 *
>> +	 * Ideally it's better to cover all types of TDX private pages
>> +	 * here, but it's impractical:
>> +	 *
>> +	 *  - There's no existing infrastructure to tell whether a page
>> +	 *    is TDX private memory or not.
>> +	 *
>> +	 *  - Using SEAMCALL to query TDX module isn't feasible either:
>> +	 *    - VMX has been turned off by reaching here so SEAMCALL
>> +	 *      cannot be made;
>> +	 *    - Even SEAMCALL can be made the result from TDX module may
> 
> 		    ^ if     ^ a          ^,
> 

Thanks.  Will add.

>> +	 *      not be accurate (e.g., remote CPU can be stopped while
>> +	 *      the kernel is in the middle of reclaiming TDX private
>> +	 *      page and doing MOVDIR64B).
>> +	 *
>> +	 * One temporary solution could be just converting all memory
>> +	 * pages, but it's problematic too, because not all pages are
>> +	 * mapped as writable in direct mapping.  It can be done by
>> +	 * switching to the identical mapping for kexec() or a new page
>> +	 * table which maps all pages as writable, but the complexity is
>> +	 * overkill.
>> +	 *
>> +	 * Thus instead of doing something dramatic to convert all pages,
>> +	 * only convert PAMTs here.  Other kernel components which use
>> +	 * TDX need to do the conversion on their own by intercepting the
>> +	 * rebooting/shutdown notifier (KVM already does that).
>> +	 */
> 
> I'd leave the extended alternatives discussion in the changelog, not here.
> 
> Focus on what _this_ is doing and why it is imperfect:
> 
>   1. Just reset the PAMDs
>   2. This leaves A, B, and C undealt with
>   3. The risk of leaving those is ...
> 

Agreed. Will do.

> 
>> +	tdmrs_reset_pamt_all(&tdx_tdmr_list);
>> +}
>> +
>> +static int tdx_reboot_notifier(struct notifier_block *nb, unsigned long mode,
>> +			       void *unused)
>> +{
>> +	/* Wait ongoing TDX initialization to finish */
>> +	mutex_lock(&tdx_module_lock);
>> +	tdx_rebooting = true;
>> +	mutex_unlock(&tdx_module_lock);
>> +
>> +	return NOTIFY_OK;
>> +}
> 
> Why is 'tdx_rebooting' a new variable instead of a new state in
> tdx_module_status?
> 

I think we can but I believe using tdx_rebooting is more clear.

For instance, if we want to add a new state TDX_MODULE_ABORT for this 
case, when tdx_reboot_notifier() is called after module initialization, 
then the tdx_module_status (which is already TDX_MODULE_INITIALIZED) 
will be overwritten and we will lose the information that module 
initialization has been done successfully.

We may be able to avoid these using more complicated logic but I think 
using a separate tdx_rebooting is straightforward.

