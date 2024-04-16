Return-Path: <linux-kernel+bounces-147102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2662A8A6F84
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 17:17:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A30991F2128B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 15:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71CEA130AD7;
	Tue, 16 Apr 2024 15:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="A2zU06s7"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2053.outbound.protection.outlook.com [40.107.100.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0CC412FF64
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 15:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713280663; cv=fail; b=JiFNVBOJMXvI33klLWjadgbvSJRwngtnv2OU34kOczPB5OFv6dzpsQxtXjZ9BrfXpN7NdUce94HEDASB7bas6ScQGl0OWQPR6e6T+lh6zFYhpaPAAxS6KxrJTnh9vVFjVaSsih/J4qpJ1gsMKYnJz0HiFBDNKbqwfBlRjD2JOZI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713280663; c=relaxed/simple;
	bh=lpg83mDW7YaEEWXVcBbJvZei79ioNAfgWzdqLrdM6tM=;
	h=Message-ID:Date:To:Cc:References:From:Subject:In-Reply-To:
	 Content-Type:MIME-Version; b=Q4ljJ6ePFeqwkM/sF2lxp43Jp+itxsNke4Dul2Nera+B6IsA6dABaYsSf7FNuO8w7kvrna7p6iEFPAqkbeQY9Fag6D55L9YFi45gbOCZozKx2pJo7cZrT18MwShftT8aa/ovOdgKAXNm2Q/1SSfeauGA98GKMJZCB46/pnBMcwU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=A2zU06s7; arc=fail smtp.client-ip=40.107.100.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HpGrzdb8lkHsiqc3asWn5OkipdDnsczJkL3aFVKviSSutxQWJpQcboOApTEQJanOqB/OthZ/BArln6PC10RWPKjwn17uTg0pmcNZtUtueDsMxQqJs5Fj8BvavzKmh5PLN0tfv/GhBpnJgjZyd7ByPump3f+/jX/es96pSvCW3sLn19q8BHr1Xpltx2ifjOeRXkiciCwT8H9cfrwC0VcTMuvCGOmZeWucDAePNokQx9b0hv94s7+1DuO3rC2GwhjrRbW7X8NCNg6YJSdPJs0G2irl2rPngOBVn0KxhG+/zLRljogD5hbzNnGf8E8pmMUUCsQ+B8aUUfV3XKgRGXChOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4JpcWrAdNNqwKUzLR5vd5L4fOtqsr7QtoxqQyDJ4AY4=;
 b=Hj0W3scV7IBBaKm+yqOmC4x0ovhX/G7XpNFKrn9/LeNlshGXx4FGQlYgRS8YRR9YjerNNYRQI3WqE4xQ57C83Dw3v+2L7mtqqA2bQP+n5g2WwmzFz2kSUXzsFQkqQ3Uih6cC2xjk8m7RKSykl9ivJUgwyKor7nvkaBTCT8GDUGFUU0w/9JxjjGgXS5enNQLXfU2hyMHPHU9A5Xe/em++0GgTvrwh8ssvL++JGQPdAjCjF4BzTzt495cM64sn6MjOY8o+JH9aA+R5HfR8VeF1r7JjPLI6sWqIVBsDVWkyKb1n4gNcTIAE4pJc2bcv56ZtWFY8Qlc9BjUehaRisOQy/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4JpcWrAdNNqwKUzLR5vd5L4fOtqsr7QtoxqQyDJ4AY4=;
 b=A2zU06s7kuuUjalA2sh9gsIKvHmPXm4zipHdlR2w3AIbrKiFQPZ4iBZ7Ffog+6Ubw/ze4j1cs7VZ6CiMVPlK8f7s8lHFOlhG6sOTShqTesRwlBZRUjd/osLH5VUeG9KLLvbg9fJB0mQrdi0F7scfFrIaDPregRkdZHtymK3MHR0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5732.namprd12.prod.outlook.com (2603:10b6:208:387::17)
 by MW3PR12MB4394.namprd12.prod.outlook.com (2603:10b6:303:54::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Tue, 16 Apr
 2024 15:17:35 +0000
Received: from BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::bf0:d462:345b:dc52]) by BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::bf0:d462:345b:dc52%6]) with mapi id 15.20.7452.049; Tue, 16 Apr 2024
 15:17:35 +0000
Message-ID: <8a1b16c0-9897-bd10-b6f7-b428292c8c9f@amd.com>
Date: Tue, 16 Apr 2024 10:17:33 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Content-Language: en-US
To: Dan Williams <dan.j.williams@intel.com>, linux-kernel@vger.kernel.org,
 x86@kernel.org, linux-coco@lists.linux.dev, svsm-devel@coconut-svsm.dev
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Michael Roth <michael.roth@amd.com>,
 Ashish Kalra <ashish.kalra@amd.com>
References: <cover.1711405593.git.thomas.lendacky@amd.com>
 <9615e6055e5b262a22bf312608647223517595b5.1711405593.git.thomas.lendacky@amd.com>
 <661e04966c622_4d5612946d@dwillia2-mobl3.amr.corp.intel.com.notmuch>
From: Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH v3 09/14] virt: sev-guest: Choose the VMPCK key based on
 executing VMPL
In-Reply-To: <661e04966c622_4d5612946d@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN4PR0501CA0126.namprd05.prod.outlook.com
 (2603:10b6:803:42::43) To BL1PR12MB5732.namprd12.prod.outlook.com
 (2603:10b6:208:387::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5732:EE_|MW3PR12MB4394:EE_
X-MS-Office365-Filtering-Correlation-Id: 55978e6c-b9b3-4429-9d48-08dc5e28587c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	WzEcWbDxhJV5ul//Cjt8KB85E+XTaLHxn5X4p2mkoP44TyVqG4qLfeeUffT3RTCQksSLOqf2+oGU2jwwZp73UwEtt5bfPq4YLnu6x18yseRd1L+5qGGhN8RlRLFAUosyHuSvSAfDBT1Go2EybBI8Cv6R1KYS7admMKRy9rzf9aZRhK8aA7bMXok2KrHRBLXbxevaynMY+Q+gGiC6xHIZFagp7qz6/VkTOjR9SQtuzSWAVO4nKeSpdn0daxm01XC07MI50lj8UHXbDs4bazt7xsQYYK4E2Rl3qShqcBBQmUt4Fp2y+FyfBvOEUPOrwPBQtJv8UhmUHU9NoYctaJox0QskTcYboUuv5wHubz9eT7bbnVKLGcP8s1z57cBMZyPv3eUfOtpSE78awbIBSmpQB50eY568uRY9bY8NYRnNcGTSsWOPkzJb74MqWXqvXj2O5fvUqIkknhG9de9H1Ng5PmXqLM4kKYvdQnb4S0qLzeetwavh//qv4o4S8ImOqw+ppnZiBncyoRtKbrCDkLb7kRzkYYABWZWcj2hjFa9csUUEaKNeH+GQLlNwAHTJduk1Xni/9cWIMZYPlsROQf4ojyT5iehuTH9uWFRKtn++RZ398KwlOkcc9Iznwp4ImsaWV+2Ma2ZlFhq0cPxpEysF/3qaIAxP4JX5eejC+3sV81A=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5732.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TmpzaWs2M3ZjdTMzTDIxZXFEVGY2cEM0UnptR1BqaVdBZ3JhTElLT2NDdkRV?=
 =?utf-8?B?dE1lUWJ2eHEyT05MY0lBQVBuMUJ0L0QrUGpuSFRSSXFYRXN5WVRRNVEyYzl3?=
 =?utf-8?B?aEh5dXp6Y0ZsUkJEWlVRVi9VbXhoMG9VZnVNTFhlV2o2NmMvTjJZVGlyNUx3?=
 =?utf-8?B?Q2xDS0JDV3lUWnZnZTJGaWJZWndjSDUzZjROeWllM1R6SjZ1UDNiUENQRW8z?=
 =?utf-8?B?ZlBCVEcyalB6Z3AyUldrd0JZRDBVNFFXWktNTTRvNkQ3RWtya1BoTE1oa0l2?=
 =?utf-8?B?cDVtaUM4Nkhra2RJVzMzdGtVendPck9vZUl3V05OUWxweitiT0g5U1BhTFNX?=
 =?utf-8?B?ZWdXSWJkSkhtRWNZZ2FFZWtjSDRtQ1gwVEtjNjBwdUd0dEFOekxoVWhaUjlh?=
 =?utf-8?B?ckNlLzY0RXM3a2FYc0tDaHNRR0tubXhLR295K0dIbnNFYlNLbXBTdW1zTkov?=
 =?utf-8?B?OHJWRHZ3WldkUU82SmRKczZ5R096MExGL2JJSGdwOEVrcW8zb2ZBQlp5QlBO?=
 =?utf-8?B?Smp3L0M2T0wrYXZuZnQvcUF3ZFNZY0UyQ0RDTkNBbjlkRTN3V21TOEg0TzhF?=
 =?utf-8?B?aDRpK0g1YzJYZnlZS0ErckNtQ0ZUT1V5SmszOHRLRld3OVpWWktUWDFkMlVD?=
 =?utf-8?B?K3dRNnppL1NLWjNNZjhpcERIQWFBbmlWdDlOSm1sdVBHQTJ4d1ArSnlycTlC?=
 =?utf-8?B?alhpdGdNMTc3UUlDQ2lCNXRBcU9kbjhpSFc2ZWVTOE1JWjhCTE8xRFhPS05B?=
 =?utf-8?B?ZnhZUG1QZThSRkEyc012S05hdjVmMVpMbmlZcnoxQmx4NVBzZ1ZFSjl6V3F2?=
 =?utf-8?B?Uk9DZ3U2QmlOMUk4clFKNTJSRyt4N0JJY05kbDltenNjSFI3aU9hWkJ3R250?=
 =?utf-8?B?VXpaVDQxUlpvc1g0RGhxRjZkVi9QL2l4cGozWFVmR2dHMXMvOE1ZVm5JRzhr?=
 =?utf-8?B?RTV3Q1VkSHhlTjBWTmIxbHlBdVZ4cDY0bnkxRmNXTnZwUXhkVGlUR2NkQVV5?=
 =?utf-8?B?bnBzT1pPQTNSb3JLWjZweTBWSldaZXFNcTdCWFlPak1pdllsanl4K21QVVFJ?=
 =?utf-8?B?c3dVaDhWdXhnRVowOXdCWFROdVltd0k0R1dtN0dGRUhKK0Fsa1huZnpUSENz?=
 =?utf-8?B?TEhlWVQ3dmJLQzR6STdHUCtjeFkzaElsODA1RWk2cDNabmNmdU1acllFa2Jw?=
 =?utf-8?B?S250SkJZcWVLb3lxR3J0WDl6eEo4Qkh0VzdTL2o5K0ozQWFDcjNSNW9qK3d6?=
 =?utf-8?B?MGRUd0duczVEcUxWNm80aEt2TGpPNFJtZWpGWEk3MFk3aFB4ODhZa2ordEoz?=
 =?utf-8?B?MmE0ak0zWmgxSFVQV3ZFeDAyb21GYy90V1dzYS8vN1YyZ1RmQWp5L1VTeFZu?=
 =?utf-8?B?R2ZwSS9ucXcvUDh6VjdvdG5WWk5HWmhOSnMyNXZDTG5kZGdjbFJYL1gxT1Y4?=
 =?utf-8?B?bTlpTStRVTlIUlBXSUR5L04wRUZkdENLTGU1Vy9lWUxFNDBnODdnRitmcndR?=
 =?utf-8?B?QW1wbFFkWk5jY09LeWFGcFEwRUlMOTJGbUcva0piUjBUMzhqOWZEalBJR2Zz?=
 =?utf-8?B?RDJnVWMydlJEWmQ4YlhPTjY0OGI2VjBMU2xoaW55dU1BazVzUWFaZ3VheGVK?=
 =?utf-8?B?bnREc1VySkZMQUQ3OGRNZ3dNUUQwdEViTE1SaFZFejloVjFaTzM0Y1dRaFFr?=
 =?utf-8?B?L2RSTGI2eG14eUNwelUvbzh0SjIxTVEzV05RZFNTdnMzL040eUZOU0s0dDNQ?=
 =?utf-8?B?OURYQjU2V0dQdlJoYiszVHlMb3E4aXZpTTcvZnc0VWZhc05BZ3doRFdCWjlX?=
 =?utf-8?B?dVlPWGVieVlkNlA1TDdrMnlmV0xHZzNlZkxBRU9wMmY1M29NbGlIQjFSTGJm?=
 =?utf-8?B?eFZvdHZWbWRES3h6QzU3dm0yTTdHeXEwR2M0NzJIOGpEWUlJS3A0a3ZnWFg5?=
 =?utf-8?B?eGFRYVJCdkxCMzR3WGlZczZzOTBzQTl4d1lxRWVJekVNemNkZHJSUnhZY2Fr?=
 =?utf-8?B?YjdVM1pleUpWUk50UEc2VTNVZ0RJVUVZRzRqbG81UWxrSGpmOWtXN29vam5Y?=
 =?utf-8?B?UDFPK09jWXVWMlZYWjZySEl2TmYxOUcvUXIrRWFiNlJsaTYwYjNCUzdnbVhK?=
 =?utf-8?Q?LoJR8UpmXJpowzqsCXFjHbSbP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55978e6c-b9b3-4429-9d48-08dc5e28587c
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5732.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2024 15:17:35.7574
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q+4Yddljm87qll6ME14pEBDWF5HPz9FDCPbbfi+mnNEAOAFf3RyyIIOiRocIZZ0Yt7LWMOA4NLmd4hOBqiubmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4394

On 4/15/24 23:54, Dan Williams wrote:
> Hey, Tom, came looking to review the tsm_report changes and noticed
> this...
> 
> Tom Lendacky wrote:
>> Currently, the sev-guest driver uses the vmpck-0 key by default. When an
>> SVSM is present the kernel is running at a VMPL other than 0 and the
>> vmpck-0 key is no longer available. So choose the vmpck key based on the
>> active VMPL level.
> 
> The module parameter is not mentioned in the changelog. Is it not
> sufficient to always use snp_get_vmpl(), and if not should there be some
> documentation about when to specify vmpck_id?

It is possible to encounter an issue that causes the vmpck key to be 
cleared. In that situation, the guest is allowed to use a vmpck key 
associated with a lower VMPL. For that reason, the module parameter was 
added to the driver when it was initially created.

I can update the changelog to mention this.

Note that as long as the vmpck key exists, a guest running at VMPL2 
could request a VMPL0 report using the vmpck0 key, that is why it is 
important that the SVSM clear to zero any vmpck key that represents a 
higher privilege. For example, if the SVSM (running at VMPL0) launches 
the guest at VMPL2, it should zero out the vmpck0 and vmpck1 keys in the 
SNP Secrets Page supplied to the guest.

> 
> Do users know that "vmpl" and "vmpck_id" are interchangeable?

Yes, they should be aware of the relation of VMPL to VMPCK from the SNP 
specification.

Thanks,
Tom

