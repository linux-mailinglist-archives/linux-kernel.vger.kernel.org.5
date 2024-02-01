Return-Path: <linux-kernel+bounces-48697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29AFF845FE0
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 19:28:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2E3128EF78
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 18:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE80B12FB37;
	Thu,  1 Feb 2024 18:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TTkmyumh"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2069.outbound.protection.outlook.com [40.107.102.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E6D12FB29
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 18:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706812119; cv=fail; b=XjzNytroXG1QnuMtY7W0kqEqdwxsIgi4apTF2hH8T/YrivoZ6HU1zqL4krYieepkbOetHV4Zem9ojY4SXmePrA9L2kWJVTP92uW+dl1bBAZSmU7XG/o+WP9YxlZ+ESvOEetw/gGsmTPFrX1TCP1n8DMxfiDnM7fbLwyuLfiB8iw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706812119; c=relaxed/simple;
	bh=GSJ+bubYZ2Zi0iwfHXNo47bUwHHj5zzs9LabRpMNatE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=thOag4DneyA0WxdCgdNOq6tIKLwx/KppcrAuFYKSKSmhr7/xK2yUSRPTWUceSxA4I7r6MH3+b0FCyqqgCzqAnTjqpERuzE1ed5rP20I3OIMiFTx4SKMk0sylqLkg4HSSntiUuksg9/hWSrTI1IeSigFdSJ2hoxo6RU7o2/ufQoE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=TTkmyumh; arc=fail smtp.client-ip=40.107.102.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CtRBYpJ4ZcWDcsvJkjvYOxHYxt6gZn1C9sot75Mf1gNtgtPkiunAaOvxEkoRFL6/heaPGeWhCLh88pXw5X97MSEBbx1It0Mn8qrNxvPlTzIeFVdP6tcIDzYJLA0tG5d8ac1tlWNnG8z3Tuo1lIQITvVfPsTwuKel9FxoLOUJtjDsPvQvhVxnaqQXSPBiDNFdO5gdKahMgvaOMArXcPGKUy5t8U008kFTEj3LJ5eDTz9AZrhMsGGX/1YSfmgyDdB7Lqrmw4Yrp+xk6ZSLQKgWZr1M4SvTZlBYfcJWkko3qHEOKPbbnIBBKP+MA47uYLBUmLcIwMIRM5yrWioVlGSewA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TkIDITixEzSFDuidK+4Vku8Six7SL75guWCjm7v95Xc=;
 b=MlPh/owIIehcPHTdbXwMN0SpTzQfHs+mp4NikYfHa4NO6G5UU1+yBCejnISAPlq0q79Uh1Rqg8Gx/eHDkcT8AYtvfDquGImNI/yXslaca0nXUIwZjRUrTPp2xuPA8P/5OPggDDxxIkoS2SpZVHr3DX5gaxqrC1W6TKwcwmcVtE4kRzZUJr5V0rjrez5HpFdDERCehrLoy8FdpHa7k3nKEDPZEU5xK7Z+IujtW9t+xqJNU1QdVjJ8srnXl0vkwQVA9eqIozyRbxkW9Pq0yjdy+hKw/5h1g27+jeoYd1vriOWqFXMJ9Mf73y8RstaTkXkW1tetlZ76QiOshHm5i5DpcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TkIDITixEzSFDuidK+4Vku8Six7SL75guWCjm7v95Xc=;
 b=TTkmyumhA5Pq2RhlFiPhXB2etXx4Rgsh4IwvD+AYIQ5j6az3EmenOjSSYwMEHrLc1F1glj6Kes4kv9MYHZN3uJLQlng1+/NY+AbMAqbKalcXky+gY99igqFPhsIDo9mb4ywTNZIgWQer6RUgXp0kId73NrA3F3JCkCFm5dBzgb8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5732.namprd12.prod.outlook.com (2603:10b6:208:387::17)
 by IA1PR12MB8585.namprd12.prod.outlook.com (2603:10b6:208:451::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.24; Thu, 1 Feb
 2024 18:28:35 +0000
Received: from BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::200:c1d0:b9aa:e16c]) by BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::200:c1d0:b9aa:e16c%4]) with mapi id 15.20.7270.009; Thu, 1 Feb 2024
 18:28:35 +0000
Message-ID: <c86203a5-0223-4824-888e-76ff9565e178@amd.com>
Date: Thu, 1 Feb 2024 12:28:32 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] TDX host: kexec() support
Content-Language: en-US
To: "Huang, Kai" <kai.huang@intel.com>, linux-kernel@vger.kernel.org,
 "Kalra, Ashish" <Ashish.Kalra@amd.com>
Cc: x86@kernel.org, dave.hansen@intel.com, kirill.shutemov@linux.intel.com,
 tglx@linutronix.de, bp@alien8.de, mingo@redhat.com, hpa@zytor.com,
 luto@kernel.org, peterz@infradead.org, chao.gao@intel.com, bhe@redhat.com,
 nik.borisov@suse.com, pbonzini@redhat.com
References: <cover.1706698706.git.kai.huang@intel.com>
From: Tom Lendacky <thomas.lendacky@amd.com>
Autocrypt: addr=thomas.lendacky@amd.com; keydata=
 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
 vFkWitqCJg==
In-Reply-To: <cover.1706698706.git.kai.huang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0135.namprd13.prod.outlook.com
 (2603:10b6:806:27::20) To BL1PR12MB5732.namprd12.prod.outlook.com
 (2603:10b6:208:387::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5732:EE_|IA1PR12MB8585:EE_
X-MS-Office365-Filtering-Correlation-Id: 66fa5e4d-6ffc-47e2-00bf-08dc235399ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	McKtU1fcFewTt+4ZaUXbx11I33Qu7FNpL1sc86VEXtkbMqcVijBVe6yRuiuAsrJDGhmjzODlH2qOk/lLh2FSTzb/aO8AKMqmyPIjzfpQ7s25lELe3TLAWTGbLZr7divJVZeqyKCaURW6YaOesyBFh2xNQFCS99DyFHFz9o8HufrzqTJHI+0A50BJiPeC9wAtVhpUDeNXXAUsLJWqEy5htn4jTkIBReyoENZJMhYsw/uFhazpq3e7XiZDbzEhSiEMxWmLvnGEvdTtsjx8JUgMMcts6uFt39kxks7KTODhdDVH1eOqBy1hEdNWe0kscLPrtkpC/pur0P5yheKmoKOMWNLsCFbG+mhXh0OSQxG+h0J/y4zAfKCuwmVa0jYYXSqh5nI2fuM42+3CvSj1MeMrxDwp9zRHGtr9aX4pVj60GiH+MpAhHn4Mf4W+lUGdn6Fv8kjyI8Xa2NSzB/1Dta0Ra49kzQTFTJql/7gXpcieRwBN1Nq493s8NthOGxF8JrK40rAWkDsmD+qzaMOR6A2TtBxBMqNaz5rNycOW7aiaF36knKZ+TXo4NckYG15g4+dlF3ZUIDG84QyJ6VSlykBnwJaXnTI/eB7YPVtgcUwSB+lI/S2mAT4R2//gj/RnBfSHZn7IItyBmUG9p/Fk4oan4w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5732.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(346002)(136003)(366004)(376002)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(6636002)(66556008)(66946007)(316002)(66476007)(2906002)(8936002)(36756003)(8676002)(4326008)(6512007)(110136005)(31686004)(31696002)(86362001)(5660300002)(38100700002)(7416002)(83380400001)(26005)(2616005)(6666004)(6506007)(6486002)(41300700001)(966005)(478600001)(53546011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d0RpMG5Wd2xQbzFJR3dNZmlPcm5DdFQ0TXRIbzJOOXFhVVMycE91clVOTmJF?=
 =?utf-8?B?azBXK2RSOThMSlE1MGIxTXdOU3l4L1ZueHlncGwwMDZJSGxkdUVJN25SL3ky?=
 =?utf-8?B?dWpCekVmbkxZdTJqU0U3YzU0RXpkOTAwL3gyd2Z0NGx6ZmN3dTZZc1N6U2la?=
 =?utf-8?B?U1Z2SzdBZnVXbjQzaUZ1RCtmNzRBcHEwYWlic1NkSktEMEhIOXVSdlMzVXNM?=
 =?utf-8?B?eXJaMndRdC93QThKTzE5Z204UE1HSno1THdYQ3J6NFB1RDBsa2FGWnNhdFlB?=
 =?utf-8?B?cFNjWVBkMTJHV0VFK2NpeGkwK05NVVlGRlEySE1oZnAvdDM4TFRybHhBSkw3?=
 =?utf-8?B?K25pMFJCRlNMZmluNkJBQWFGRUQ0eUZRVVBCNXRFSWhQTzYxUnRPcXNMMWx1?=
 =?utf-8?B?anM2MU0zSUlQUlpHeHZPQ2h3Y3cvMWEwVzlnMjF2bExkQVR3RHMvQVIwVi9v?=
 =?utf-8?B?NTVKYURYYVBPV0FaSWNhKzlENDhZdWl2eVA4eUFOZ2E4cytnWVVkbzZPUkdE?=
 =?utf-8?B?TW1iWFQzWDF2WUNXS1dRalA3Q2d4ckRyZUNhYmljeThmZTQwbDRac2h4WDhv?=
 =?utf-8?B?VXZRZit6MEZHcitTRjNETDFMQTY3amVWOUVLM3FGS3VnaVYvN2N1cnMrZ3By?=
 =?utf-8?B?Um50Tkd3QXBQdzExcDh5ZkU3SHc1emUySXR0b3Z2TEpUZk02NTd6VjRmSEp1?=
 =?utf-8?B?NzVIN1luSCtRbUp1VzFPWngzTUJpK2RWd2NzWm5ZTTZMY1A5Sm5pb0NIcU5m?=
 =?utf-8?B?cVAvQ1RwOWV5U0xhaDZmbHp0VzdsTm1lSktqcVhXK3lsT1JJYU54U3dSSFZV?=
 =?utf-8?B?QS95dlYwUWpSRDhqL0dlcndyek52aW9iVGQzaDV1Q3N0bWZ6SnRyblZiaHlV?=
 =?utf-8?B?VVA1S2FlVzhnMlp6L3M1RjZtQjdlaXFnUnZFTXBpbngxUXJyWExUamFhSGVL?=
 =?utf-8?B?MGtBbzVHTndWejNOUW05VHlNVFRGczlmQk9IcGQyYVBvRG9ubWllS0FuVFFK?=
 =?utf-8?B?ejF4NEx3Tjc3ZnRGWitjU0F2WGtCb0loRmFyeFR2VGo3SSt6Tkt1U3Zva3lz?=
 =?utf-8?B?Zk5WT1dGVUV6ZmIzUUpzc2RRa2dzSEQrYjVCcEJpR29oQ2RMR1c3VFcwUytP?=
 =?utf-8?B?b3RlSjNHZWtFSGUxL01kWk5GUThhYjExODBZOHJiRVltZGh5NmNUSUZXSEVr?=
 =?utf-8?B?OWR3Nkd2ZGFpOHRtUUhZVzFxTlRROVNUSFc5N3EzdmdWTVpjUWkvSGpkMW9C?=
 =?utf-8?B?c1hTWVZiNG1RRFJWN0Nock9MM1JIbGFoUjVLNlV5VnQvdmNpL1o4MUJPeFJi?=
 =?utf-8?B?RVZmdGJXa0tBK2JCczhZaEVleHVtNk12RzJpU0NIcTNWdU9uZGpGbXZuZnU0?=
 =?utf-8?B?MkduQ1FuYUQyV29iUTdqSHMyamUrUGxIREFPeHZ2VDlnQWUzdWtqVWJSRjR2?=
 =?utf-8?B?WWVHazJBa2J2SVNtOU5ZRWo0Z1YrWWdxVmNFdFVQdUh5bWs1a2xBTHk2L3RR?=
 =?utf-8?B?VkRrdjFZYlhTdEVUSENuZ1NROHNBWVp4T0cxTi9jcWRSczZjRkdDWXB0N1N3?=
 =?utf-8?B?N2g5bWpENTB3S0w2VWJpV0JyUEM2WGVpbzMxVEZLYTZXOHhyem9RN094TEk3?=
 =?utf-8?B?dkJUT3lNUUFoTmlmRDByei9ZVWpFVjgvMHRpV3lPbVV4WHNMZE5qUHRmaUQv?=
 =?utf-8?B?VjFVdFpmc0grelpVNC82TUdVa0pNbk0rSUxvRmt3V0tqV1ZQRkRPdW15cms5?=
 =?utf-8?B?b1ZoMTdkT3R3VWxxWStJaHRvLzdrZkI1bGdiNTV1WkRrYnc5ZWQyQko4c2tY?=
 =?utf-8?B?N3p2R2JZbHRUT0k5bk85ck55S0I0MjlCZUcxNGFLTEV2eWlLOGQ4OFRmL3JB?=
 =?utf-8?B?MnRjNVZDWnRaeGpzL01BQ0NJbTU1cC96SkgvSnZYTWIyRmlGbjVKcTY2aXo4?=
 =?utf-8?B?VTl3Q1ZWTEt3V0R4cFZOV0VRUFhQUDNQaHJTanErd2xnLytwQXhCR1dhd3Vs?=
 =?utf-8?B?RUp3aDZwYm1pbEdBVUQxb2p3TXZOZWkwQzMzNWkrWmxMeVhOZE8zRlJNWWxQ?=
 =?utf-8?B?Nk8xbEoxd3hHWUIwREZzcXVGMDUzdFcvMkJlc2x0QVVyWlFCOUdVZ1hqUzFN?=
 =?utf-8?Q?aR4KUnGuDEilXctoZtkUq6NZE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66fa5e4d-6ffc-47e2-00bf-08dc235399ca
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5732.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2024 18:28:35.0288
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mpbm6MBvRHDcd0nHE53G6y7YoQoCKMaoJTiIA0PtVaPeVnW0Xa9IOEuD/U6qnIRvrVyR2IgC6dlrvjt/XE8sdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8585

On 1/31/24 05:31, Huang, Kai wrote:
> Currently kexec() support and TDX host are muturally exclusive in the
> Kconfig.  This series adds the TDX host kexec support so that they can
> work together and can be enabled at the same time in the Kconfig.
> 
> This follows Dave's suggestion to add the CC_ATTR_HOST_MEM_INCOHERENT
> attribute to unify both Intel and AMD, instead of having Intel/AMD
> specific checks around [1].
> 
> Hi Tom,
> 
> I've tested on my TDX testig machine but I don't have AMD machine to
> test.  I highly appreciate if you or any AMD guy can help to review
> and/or test this series to make sure I didn't break anything.

Hi Kai,

I'm adding Ashish to the thread to take a look at this as he's been 
focusing on kexec related things recently.

Thanks,
Tom

> 
> Thanks a lot!
> 
> [1] https://lore.kernel.org/lkml/cbc9c527-17e5-4a63-80fe-85451394cc7c@amd.com/
> 
> Kai Huang (4):
>    x86/coco: Add a new CC attribute to unify cache flush during kexec
>    x86/virt/tdx: Advertise the CC_ATTR_HOST_MEM_INCOHERENT for TDX host
>    x86/kexec(): Reset TDX private memory on platforms with TDX erratum
>    x86/virt/tdx: Remove the !KEXEC_CORE dependency
> 
>   arch/x86/Kconfig                   |   2 +-
>   arch/x86/coco/core.c               |  34 +++++++++-
>   arch/x86/include/asm/tdx.h         |   2 +
>   arch/x86/kernel/machine_kexec_64.c |  18 ++++-
>   arch/x86/kernel/process.c          |  14 +---
>   arch/x86/mm/mem_encrypt_identity.c |  11 +++-
>   arch/x86/virt/vmx/tdx/tdx.c        | 101 +++++++++++++++++++++++++++++
>   include/linux/cc_platform.h        |  16 +++++
>   8 files changed, 183 insertions(+), 15 deletions(-)
> 
> 
> base-commit: a6f0b57202b0ee50dc042bae16494008dc6dc992

