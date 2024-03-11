Return-Path: <linux-kernel+bounces-99203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65DD98784CD
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 17:18:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E30F21F246EF
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 16:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAC59487BF;
	Mon, 11 Mar 2024 16:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="k2LPUU/y"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2078.outbound.protection.outlook.com [40.107.101.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E525347F63
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 16:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710173813; cv=fail; b=L1SnSGTfklD+3u542HVJsvOUZFDBCAnuPZ8sjKWhFdGNMcaKYQLdkarvz+yJctpoHFBYJN/rh/vqteHnpezzNaZyqvkVOTrC9BIntOXI8KsmhKetNUOYaNeRdjyHtCPhbdEWrZIcklNWCbGNkT9B81nrCQ1RBS2AiqUDNncEpmE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710173813; c=relaxed/simple;
	bh=V/d1F6WS2li9DbYbBYCbSoPp4oePopRvX10s7UZ240A=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=svs6zR6jI67AHYItQKx+LqEn263gi/ujbd2euQQpgYRGvsE28aTL0AyuqNRZYrDlxszDSxvaL8/N8g33vtnKay/q1B4R02SHJ7vLFjpFEmKr9aDibRABrQzs/Z8cyJ9OFOQu2w+a3I04KrJX8FqthppgU/2s+4kDZZyOzUYN/bc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=k2LPUU/y; arc=fail smtp.client-ip=40.107.101.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NglrE9DshszliZR0MS+YLjlERYx5DmPAECQlQCUaTiWwNHi748Sjyez/7Od2MjgkkbRtBJbs1QIbnJR8tNbK3qH0wZ+UEOueJKFqbTbUiCeh9F6RKuNRwxeU/tR/d1JAU50CuAeJjfroNDqg6GnWQdUr3lbfaNsi5Exqmb+NCDuSG8AlrhBiZVlhawC0973lCYNz48wq2iOCZ1IEE852QkmgnSAWEn+2fqDT6FUH7P5BNlFRvFQsNnVRe6z4R8zBmRMQlFjISX2Y0e/FJ8YLRHptBzZnwIHl73FVnEfvknIJpOg+cb9Qu0WZkgrT7Ml82FLjc5uqCcuprQcnidylhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xoxsTqM0croZx5k2quBAE0z4vr5DTDbusz1X60P7S6s=;
 b=aAq532bf/v/9xfucjU97G7wDLKFFYs67Nzbb0eUr/8kYpQmmIgzNLSgwW915VwFsPlG3Rs2Lq37wIfdethz4sted/44BZZW9SdUExFcPVSq8HJOz9kd+ZFPIwon1F/UYZkcXTpT1r1tMKQ8o0TUvya/ADl7Nu8M1UBVUBP8qcncRwUoj1E47Lr8JB4bDsriiv/WVsTurvr6eMtHg9r29FvXsK3Jt7x5hxJV5O5pqQ0TiGYUWo2unF6RQ67Qad3XD7dKT3keIMqDtU06YF/1AqiUed2C++8+KmA88bd6gV1teTOV/U6I97UV5R/L6b0VGT/Gb/UMnT355jlxiz09hJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xoxsTqM0croZx5k2quBAE0z4vr5DTDbusz1X60P7S6s=;
 b=k2LPUU/yDfwDWlsqreLohQiKRsg75fVfbE78cuZgiDoxkwOLUY6QLxB3m3RvBblIYcOJptk8rs76xMYEdNrzukJZPgz/DRRb6u3LbMCjS/hOChqfPic2mLD9/8V9sHOOd34U/HlXoMAbyxQfXFVOskWeQFz5kYSEU2QjJNiHfIo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5732.namprd12.prod.outlook.com (2603:10b6:208:387::17)
 by DS0PR12MB7747.namprd12.prod.outlook.com (2603:10b6:8:138::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Mon, 11 Mar
 2024 16:16:48 +0000
Received: from BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::4c26:40af:e1fd:849e]) by BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::4c26:40af:e1fd:849e%7]) with mapi id 15.20.7362.035; Mon, 11 Mar 2024
 16:16:48 +0000
Message-ID: <33b7a57e-1df8-47ee-94d7-aa646a9e923c@amd.com>
Date: Mon, 11 Mar 2024 11:16:47 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/14] x86/sev: Rename snp_init() in the
 boot/compressed/sev.c file
Content-Language: en-US
To: Borislav Petkov <bp@alien8.de>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Dan Williams <dan.j.williams@intel.com>, Michael Roth
 <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>
References: <cover.1709922929.git.thomas.lendacky@amd.com>
 <d558343480a78b53ac419ce67fc9f13d631672a4.1709922929.git.thomas.lendacky@amd.com>
 <20240310212521.GBZe4lQWwIQSBsaCLc@fat_crate.local>
From: Tom Lendacky <thomas.lendacky@amd.com>
Autocrypt: addr=thomas.lendacky@amd.com; keydata=
 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
 vFkWitqCJg==
In-Reply-To: <20240310212521.GBZe4lQWwIQSBsaCLc@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR03CA0019.namprd03.prod.outlook.com
 (2603:10b6:5:3b8::24) To BL1PR12MB5732.namprd12.prod.outlook.com
 (2603:10b6:208:387::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5732:EE_|DS0PR12MB7747:EE_
X-MS-Office365-Filtering-Correlation-Id: 780c29b7-8c77-4557-0a75-08dc41e6a753
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	vCeWyXE7SWMZ3bvnuy4O80S/mZJDdubpHyShcMcW5pqyfZWVNhsz9UYt9CEDL/5MNB+0xibfL7rydfR4CwBfcBJVEbyIITvjkW4OlUR4x64AvsnIfcQDlgcvD9l6XtQOUuOGqB8/2U2yYmRBn7mO3HFke07iEl+eBXgL+MWnntvOL7LrW7jeQXwHJCdZUMwFRFTEww7T/60ht8iNDA1KZ3CBqGj7UBGFMd1S0mefSd7skLDHeeaH43ChIkO4t5//y06RFYRRJrVM8M6CLNLVo/az76LimPpz+uPG10wM9oPlPePjbh5h9+dRZ/wFNYkGq6b7licNt1CoAf4sQHRPDfowUtJJsydaJdU4E/e1RX67Le0zqec0RjZqJv+QCOwZThgQZYFlVCp38s1VaNLyYMQiOAjuET2doqXO6To5LHp+hOG8QnUZvZ0cE9DiwpiybeLx60kAsCrVlBQjMJXsWiqIZbJwcb20HrH+get6qDhZH0w9dlIy6hCLJy83kU4c+pmOrlandulr6BTs5+LnrIocgMtJoH1S7UX+mxFwo6rhYzOp/rYB7+mMKZSWvu9DuGtu+IQlTwUjTGj2EqUdpkfrH7e9pV4hfhbe3kfIGAFmA1PR1KFf+Gtw203N54EGH0aOtFi+EU1SW6nHS1SbUmUbIsY3aLGBUBsfTJPkoNk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5732.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WGphUXVlczhDOWVBejJ4V1BuYzllejNadS81ZFhLUmtvWXUvU2xYL1UrNkN1?=
 =?utf-8?B?a0EzMlI4eTFuQkU0ZjVaNUJrNWt0b3RoRWNQWnd6czVsZ212WUlpd0VqVlFh?=
 =?utf-8?B?dk92a0FwalYybkxzTHJBVEo0YjZFbm9zTHA5QkJPeWJkanJLazdnbFZYNzdV?=
 =?utf-8?B?aFZ2aGxFT0V4UnR1R1c1eVFySXYwdDRiNlBHQzc5bGxYb08zL3AxeitzS1F5?=
 =?utf-8?B?YmZkMGpJdDNReWNyY1VhcEtmYU53TTE0dVJtTGhaTXAxZ0Q5dDRiVG80UjFK?=
 =?utf-8?B?MVR5MDV3SU5rQnJxdS83L0FuMllOOXVGN1VQbndWWURNMXJ4NjNPSk9RQ3pF?=
 =?utf-8?B?aWlJTno1KzlXdzVmYzkrY1pqN0srRnhHaGxyVlg4QVdRazJieXlPT25Ramg2?=
 =?utf-8?B?L2FjS1ZLR241cm94a3dMdDJkbHBKY09JQ2Y1aWtPZ2E3WWc3MFZyTUNMdDNG?=
 =?utf-8?B?SEMvalZXd0JQZEhCcURva2lJemZRdy95SUxCMVpZTXIyUWtlbGNyTmZYNkdr?=
 =?utf-8?B?a2dSMGx2TmwrZlQrV2p0SzNiQlA5ajBVdjJhQy9GVmRzK3pEZEcvbVpxbmI5?=
 =?utf-8?B?b2hQMDhQY1BFejhXRGhPZkdTRDB6ZXJIenZad2FuZ3VJRTZTUGJMR3ZZcDZq?=
 =?utf-8?B?Q0ppZzlYekdjMS9pYkVjaTlsN1NlZUxkVWoxYlZvN0hWa1dxamRSMzl5VlJr?=
 =?utf-8?B?UU9zbkdxL21ONCtuOEI5RThsSnE1NnhFdC9MMDJvSWl0ckI3UlhIOTlZMUVB?=
 =?utf-8?B?clJZYUFqMGcyZngxdks4THFIRzE5RVhvVlFSV0RhMkk4THB0bVkreENLQVRE?=
 =?utf-8?B?aTR1NnJpYTF5RmNsTGdBS3IrQkdIbW90dFl3MGFKTW96MDNST09SeEFIV1kz?=
 =?utf-8?B?N25GS2RZSFNYR0VuMTVFSFhvY2VNVWpheTdKOWd2MGtYSm5GdFBub05uS3VQ?=
 =?utf-8?B?RTVGUWZIc0V2OC9xTEc4RHFLSVhhTWttRXFyUGJrRlB3SmVuSjZHZTUwRGZi?=
 =?utf-8?B?ZVRsTDQ2ci9pZW9DbTBUaFM2d29qZGRGTFhEb0J4VXRLZEE2ZjJmQ2tVRWxD?=
 =?utf-8?B?QU9zaXlYVUF4TEthVTV1S2hNbEQ3KzFpL3l1c3VlR0RKTnhxVUFYbitDZWVw?=
 =?utf-8?B?Z3E2YTcyT0NoNkpvT1gzVHpCRW9Ucm5OSzJxYWZYVzk1SlFJbjlVeDNTeGM1?=
 =?utf-8?B?SW0yU3h0RUIrdUJWOTl0bGVjUDlPRGI0dFhrVGJoUGQ2eU1ldUVXbndFRGRw?=
 =?utf-8?B?YzhpWHVGdnovV2JmQU1pQzFYQ1NjS1FTWW1aTk5IU2hjWWpUOWlBZEpBc2lG?=
 =?utf-8?B?T1FyMHJhRCtaeWMxdmpWa2J0RE5DTFpxSG5QbzBFb1VYUGdWNTk4MkZEaEFh?=
 =?utf-8?B?Z2gzM1NZTTVjaWpYVVRieGpuTllsN002dWNFZXc3Rjlwa2VoYTJjMVJscXQ2?=
 =?utf-8?B?Smk1am9CVGRuN3krNDlHMzFwM1N4bXBDdnlxdjkyVTJOckNPYWpKMTN0YW1M?=
 =?utf-8?B?N0RIeXo1SlJxQmFMS2YvbTFPdVlrRGpnNTJZM1FjV2J0ZE0zaDN4R0p1N29p?=
 =?utf-8?B?OXNsc21ZWUJPYkRPdVFSZ1dXTU1nVWQ1MHIrdi9rdktaa2JhbUNHRGh3RTdL?=
 =?utf-8?B?RGVzck5OWlJCNU5INXVwdnJGdzdBWG1JaEsrZWlYRUIvWm5DNmtBM1lZa1ZC?=
 =?utf-8?B?RWFVY0hFL1lQQnZ0Q3lUcU5sVkxkY1YxdFJsSFBzQk9SR0hUcHZvdjJBK0Nq?=
 =?utf-8?B?WDhiMmczZjh3ZzE5VlVNdzFVeDUyOE1SL2ZDYVZraDR2bWZ6WGVmTENUMlRS?=
 =?utf-8?B?dUpTM0k3czZLWktRaEs2TnFLcVdBUC9SaWhsU2hrS2tsZE5TeitSZXIvbHhh?=
 =?utf-8?B?SXgwdGduQ01yNmpLdHYvamQwNVg5TXJHaE91ZFdEblB4R0lKM21CYUhFdFlv?=
 =?utf-8?B?bEFNNzQ2VnM0NjZJNlpuRHZvU3Y1VEY2eDFDaitXUk9WcTJ1dFlMQkFEMUE4?=
 =?utf-8?B?QUhzZVVES1F5YnA1b1lnQzR1b2Z2b1FLZlVmNThNRlJ5ZEpaMmMwZExTQWc5?=
 =?utf-8?B?UGo3ZkxTdGVaRkJlb3l1RmM1NXd2UzZoUGRwQnU4Q01vdHk1eVVoYVhzL1Iy?=
 =?utf-8?Q?EdAgwAZNcTV5b3MjXeWZfBh9/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 780c29b7-8c77-4557-0a75-08dc41e6a753
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5732.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 16:16:48.6536
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bxzn1FmQrduxTyWzFrG8T6EMhRu84mv41QyvNT2vySC0hm/m4fFDQsw7X+F7ACO0AZDUxDrdyviB9aXznNsb9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7747



On 3/10/24 16:25, Borislav Petkov wrote:
> On Fri, Mar 08, 2024 at 12:35:16PM -0600, Tom Lendacky wrote:
>> @@ -478,7 +557,7 @@ void sev_enable(struct boot_params *bp)
>>   	 * Setup/preliminary detection of SNP. This will be sanity-checked
>>   	 * against CPUID/MSR values later.
>>   	 */
>> -	snp = snp_init(bp);
>> +	snp = snp_setup(bp);
> 
> So if you call the compressed/sev.c version early_snp_init() or
> boot_snp_init() or something similar, you know immediately when it is

Yep, makes sense. Will change it.

Thanks,
Tom

> called vs having to grep the tree to figure out which is which - was
> snp_setup() early or was it in the kernel proper.  And so on...
> 

