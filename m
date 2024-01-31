Return-Path: <linux-kernel+bounces-47174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F3AB0844A1F
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 22:34:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B49F1F27384
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 21:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2409838FB5;
	Wed, 31 Jan 2024 21:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gMXPVZTo"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2073.outbound.protection.outlook.com [40.107.94.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DCB539846
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 21:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706736859; cv=fail; b=Q8dEYK9EhuQQxaAdNaXisFRhSYa/Fe8Xl8+iXyX57IEuuZZ6lOq0/twT2zOXfq4eBhkUFPNMHk/gvhKBiHvpRRoRMfNXKcMQiYxGHGr+OwEVS9gzLk8ReTTWH78R9wnRMtAz16Xmhto0BLXZakfIGiILHJ/s79BpwAJz69MV8Is=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706736859; c=relaxed/simple;
	bh=1L4KKEIP2SFkotsrDDREp6dF1MRhTbNIIsPwt7om+x8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CcoXW/1HuwVBAqoTxykueUOyGY9k3yLmUnLjFas7ZWJtKbdngO2Xqy0vV9WyC0z5+WQZyO09AyOkiRqGOg/YUq4uUzPqgkFUHbwQ6TXu2HmslCB2UDhzSGg/3tClz90uPLV2WUh6LUIm2WU9icqaXWRT0Pe94nmJJ8t45pXh29A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gMXPVZTo; arc=fail smtp.client-ip=40.107.94.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H2KdMw7sqq2y6B5zdIqxXoMbpioVtCnuF8n5+LVsU1NAlh3ggcvGzc5nx/oBJvgcoVj1RJwJ1icPDPp29k0Uv2itYXdArzLPgCz9OvpZ/snO82L0uvHGg9wyGix6EQTRWPnqfzpxdYmRHj+/fi1KSS/tIp2vQ+3yMHrbj4FdYA+k9QGLpFi0jWmDqUz2FseWtrDWHPitXdfogKmzxFSLD4h+6KSh9nVWNWp05+3enLGKbRM6CxaxFbCcJ8fUMSOlavILf6f0NR4jWCOAxpGP3Nd5EbfXyhoyd6um61AdN4KBxaXXfsgmamilMLZUy1C6mfEd80evaWTMLHyjo6QT+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=509K9s47AXJLTFCNGVStQt5qeA6e2QdeQmpV46TQ4So=;
 b=DzYeEuGHlWTBLwTEYhzeZ0a1ztaix4N+i+3EE9Mi2Gtbu3VsrsEFNhLgNwiKNQR19nY0NkQz5FSzjgFrtk84hJpSq3Q58u2e6A9M05ffK3wCrOCqTKf31LmTjnkSOVVmqxJtAACzUqnn4zrypaa5Kgds4+DjWmmCp2BMFUYxWGK6nuqFSspelozT9zx/CKMZ2rjwVxA+KHZjriYUDn96gbzxru3ib2TxQKNYg7xzts45BF0FQIWFdaRfM5seVk71fcLDLNl4meRL502ipfVh6/dNgT9E6KSWHI4tigVp1uLbKEopgIHvZTDJTUctEEKufonrHtpaW3aABMOt+34qKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=509K9s47AXJLTFCNGVStQt5qeA6e2QdeQmpV46TQ4So=;
 b=gMXPVZTojWN1IrkHXzNSijepmrrAOjurVVQ3NBm9aJZmQpa1sSj3mFOo8KH1FKCsaCDToy96nyDShL2eTsx/3M5JLURMHB+rQgMxj63C/CM952cCkho672DnNjKtmQNnPdBFEAX4hf3PRKJP+c21DgoCf7iODBG409IdTrqHcoA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5732.namprd12.prod.outlook.com (2603:10b6:208:387::17)
 by IA0PR12MB8695.namprd12.prod.outlook.com (2603:10b6:208:485::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.22; Wed, 31 Jan
 2024 21:34:13 +0000
Received: from BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::200:c1d0:b9aa:e16c]) by BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::200:c1d0:b9aa:e16c%4]) with mapi id 15.20.7228.029; Wed, 31 Jan 2024
 21:34:13 +0000
Message-ID: <6b45b784-49d5-4a23-bc90-60de542ef13d@amd.com>
Date: Wed, 31 Jan 2024 15:34:10 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: Reserved bits and commit x86/sev-es: Set x86_virt_bits to the
 correct value straight away, instead of a two-phase approach
Content-Language: en-US
To: Jacob Xu <jacobhxu@google.com>, jeremy.compostella@intel.com
Cc: acdunlap@google.com, michael.roth@amd.com, ashish.kalra@amd.com,
 bp@alien8.de, felix-coreboot@felixheld.de, kirill.shutemov@linux.intel.com,
 linux-kernel@vger.kernel.org, mingo@kernel.org, x86@kernel.org
References: <87jzribcvn.fsf@jcompost-mobl.amr.corp.intel.com>
 <20240130213354.863963-1-jacobhxu@google.com>
From: Tom Lendacky <thomas.lendacky@amd.com>
Autocrypt: addr=thomas.lendacky@amd.com; keydata=
 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
 vFkWitqCJg==
In-Reply-To: <20240130213354.863963-1-jacobhxu@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR11CA0022.namprd11.prod.outlook.com
 (2603:10b6:806:6e::27) To BL1PR12MB5732.namprd12.prod.outlook.com
 (2603:10b6:208:387::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5732:EE_|IA0PR12MB8695:EE_
X-MS-Office365-Filtering-Correlation-Id: 43ee7815-d12b-4aa2-c216-08dc22a45e2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	FapIu29Pht/jnqtrvMeJF+a6q62scbTNGcg9UGraWANV1zuKnE7Of9B3m88wfwTuMRpoPibmZu5rcQUvAcb9oeUgqkY6H9OsnvXuDlT3N27axsu02WtK8crkm9NiL4oV0loJfs+SpVznzEDhK+R0VRCyNNTZu1xwee2vsgHMFsk2FAMrPKrJacQTl6ZugOai1Xs1WGg7uOOM3aip/hKcYCFmhWgy/0dabqxal7bxMJAyMJwOz9PJW7w3epvuoZgmgw9+/+h4dFfJhSG8bM0CVOWHJ94+QnYzC2swEjYDDY788mpg+U9N0Hnh7o4rob4M5goSzb9TxJ+MuGX/jK9xUbDWk/EOIPpQqPvcleVwW6Wy4rVXPeGJfeXAbnmnZ4eRWa76WUwa+o2zaBi9EqAfrhXtc3yGKoqgJG9UD1xwd47IUiaadNdnXIkhu205GTkWbvH87Ab6MoyNJC8VDkupcRrbk8aoRmX0Vffb30CWKX0HrsE46YuJC+XmBPSYkBOzY4OdopD9tGcl5fl+ENtszRwDRJzMyc5652qnggz+0kNnbn68FDdcii8+uR7LnGP3DS4fbFB+Qk4ta6AZ2JhbsZdiM/5/WpPekhDZn8nHq37Hg+Thav7l3zwnXDZWby5sIXv5oRgC0o9iJ9dnenoJMg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5732.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(376002)(136003)(366004)(346002)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(31686004)(83380400001)(41300700001)(31696002)(86362001)(36756003)(38100700002)(2616005)(26005)(6512007)(6486002)(53546011)(316002)(6506007)(2906002)(66946007)(66556008)(66476007)(4326008)(8676002)(478600001)(8936002)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L0FqYjJKR1dGeU8zb0JHNnpXTXdvY3RuVFFFTCt3eW05MGVxVm5acDBIYUx2?=
 =?utf-8?B?SHBOOWRyQTMxYVBsTldXV3NnWUNNVGxFN0Zacm9XTUgyaUlvWUdyTzVGWE5D?=
 =?utf-8?B?OHdOYTRUOHJldUpQeHFtTW5FSVA5MkM5VjJLT3B6TWpHYXUyN2JWK3VDKzNm?=
 =?utf-8?B?eEN0SS94a1NBR3hJVlBzMVBOTkpHVDF0TFp5bVBvYmkxN2JzWFlTQTBOQTJR?=
 =?utf-8?B?Z3R5RGZFTEIrclBDMVlDd0dxd2Z4aFJVMjV2VU5ocHpJUEN4eWU5SzhyUVl5?=
 =?utf-8?B?M2dBQ2U0Wk1yTGFyQ0lWT0FRa2N3dFF2VUtFeXBocmN2RGRONzhVTnhPWkxO?=
 =?utf-8?B?WVpOVTl4OWlwQ1JleHYxVytoWXpxV3AySGtNNmZFdDJyelZZaXlQSnlwc0k3?=
 =?utf-8?B?enFlWU5USXNmMWdUOUM5cXpIZ0JrTHFINXZqTkYvbXh5Q0pUeFFTNnVNVFp5?=
 =?utf-8?B?MG0vTjJKaU81L3pLa3phYUVUSlZaUVdMRjFRWWF4WG82UkJ0R3RTa0lWM2Jl?=
 =?utf-8?B?OVhmVEh5VVg4YWRFcjIrU0JDNmFGOUlpSlBiSEhmZjZEQ3pZU3ZDUnFYMkFV?=
 =?utf-8?B?eW5XanMzbVVGMXpqY0kvYTUvcEpMVVFPVHFLYUt2ckYwS01pZjdaL3pIbTl3?=
 =?utf-8?B?cFAvR2hMdzNZekpObTRkUE15OFVVazdmMXFjZVprdXlWdmhJQVIyeklvV3Fp?=
 =?utf-8?B?YUNzV3JPTlBRbng0aFpielg0dEM0bmg1QWw2UVJUQWVYYUxnajU0TyszdnY4?=
 =?utf-8?B?eCtIWno1cUMrOW9rWWpqNHNrcDdNQnR3YlZWNUFRRHUvUXVkdDZWUW8yQ3pG?=
 =?utf-8?B?T1BrTUZ3WHRvdmUvQjRwUW8rQlVhbjY0NXloU1U5QXpoRDZVRWExd3VPa01q?=
 =?utf-8?B?VTd0T0VpUjJhQWpjNklYRTdzekd1RmdKbU8wK0JrYTduamdIYm84MENSbTJH?=
 =?utf-8?B?YVc5TmFvemJoV2taT0NreXJDL2lnUFI3am5rMnpaVXdzMkdDakxYVER1dW9V?=
 =?utf-8?B?N2hwR2RyRTB2ZG42bDFQV3F4S1hKZ2ljRnJuVk1IdXdBellISXQrTDNMTDNo?=
 =?utf-8?B?TnNhbm9zYTRkcHUrc25FSU1GZHhZdEllQWYramFlN0p0SGVMN0xyalR0LzdE?=
 =?utf-8?B?azRlaFpQeGwvVndOVXVWcUgwT2M3RlYrR09LalVseGlWa0JTSnZMS3E3US8v?=
 =?utf-8?B?bVBnYm9QV0dEczdWcG5IWldqanBYUU4ySkhLcXlneGFrWXpVQi90ZTRCMlNi?=
 =?utf-8?B?MDc2Q2FnTzF3a1ZYK1FwQXczOFJCTFh0OVA0SUNvdmxMcG9VaHhDbkNBUDdW?=
 =?utf-8?B?NkpGQ1M5UlFZOWxnb1dodDl4UFk3RklzZ0FlZlRDQnd4WFo1RG0yeGVCVXJF?=
 =?utf-8?B?WUJWTmdsOFlVMy9rWDZ6cjIyMzUxT2FzYkQzNy9jT1paWUFkMDBLK0dwUDBt?=
 =?utf-8?B?K1RtWGdhcmRzcnIvbXhBdHFPZWtiVUdTUzFSVkEwV0VQSVFnSHVlTmRvcVJI?=
 =?utf-8?B?YWVwZFQ2RHU4bzRGcjZhVWRzNUgyWjh0N2ZXTEw4YjdKVXpqK2xNNDVpb2lD?=
 =?utf-8?B?c25uRWZEREhvYmZPanFwVVZteGdCQUZrbjFYMkp6bEFQcWNoN3ZkcnVUallV?=
 =?utf-8?B?WEorcnA0RHEzTGJxWXhzYVBYSFphdFBoUERSYVh3bGMxYWxTMUY0cjhLUWc3?=
 =?utf-8?B?NXZ3anBMZ0hCMWdxc2hNSkgrYms3Z016MnJBeFh6aGtMRTJuOWxlWnpTL3ho?=
 =?utf-8?B?NmNSSTRRNG45MFE4OC9mZmNMenRVWVUrQW1oRmhrRDRHdVJ3UVlMZXdKMmRs?=
 =?utf-8?B?R3NubVZsekI1NmF0M040MkRGTnhHbHE1SmFYdk40Y2JQMVIvcmpGT1lPY3pj?=
 =?utf-8?B?OHRvbDU4by8zTmpMc1RNL1h4VWo0OTdMbHhhQlNrU2wvV0FTSmMwcW5nRkty?=
 =?utf-8?B?dFhHN0taeG1kOTl0SGM4NnlPMEh0RngxZVFLVVJHZWc4S1lsTGNndkw1OWkx?=
 =?utf-8?B?Y3loNXFsbFg2aUZMWC9ENDFFSUp4NzJ0Q2pGYk4xYmlUYkhBWVVReGhaOGF2?=
 =?utf-8?B?Uk1JUlVxUkJNSWF3S3AyUUJDeklySE9nWTdSTmJDK2hmeW1oRGU1dHlPNnFm?=
 =?utf-8?Q?edFMOLA8mZQ9FJcjGqb1XhTK6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43ee7815-d12b-4aa2-c216-08dc22a45e2c
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5732.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 21:34:13.1472
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PYkmWgqN7fCKIdAG5hDsZV26C5eJzk7bC+4A3msSKmp+qqoTNA2LngTH0hcgE4sAdaD7cLSgJ0EMfXax6VBlzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8695

On 1/30/24 15:33, Jacob Xu wrote:
> Adding some AMD folk to the thread here.
> 
> For AMD CPUs, initialization of c->x86_phys_bits occurs in
> get_cpu_address_sizes() which is called from early_identify_cpu().
> 
> However, early_identify_cpu() will first call early_init_amd() which adjusts
> x86_phys_bits based on the PhysAddrReduction CPUID field.
> 
> c->x86_phys_bits -= (cpuid_ebx(0x8000001f) >> 6) & 0x3f;
> 
> Thus, this adjustment is ignored.
> 
> Adding a new cpu_dev callback to calculate num reserved_cpu_bits makes sense to
> me, hopefully the AMD folk can chime in here though.

Later identify_cpu() calls init_amd() which then makes the adjustment. So 
there is a window between when the value is at 48 and when it gets reduced 
to 43 (on my Milan system).

The actual flow has setup_arch() set the value to MAX_PHYSMEM_BITS, which 
is 46. Then early_detect_mem_encrypt() reduces that to 41. Then 
get_cpu_address_sizes() resets it to 48. Then a bit later, identify_cpu() 
calls init_amd() which calls early_init_amd() which calls 
early_detect_mem_encrypt() which reduces x86_phys_bits to 43.

Looking closer, if mem_encrypt=off is specified, then X86_FEATURE_SME is 
cleared and it is X86_FEATURE_SEV that causes the adjustment. If 
X86_FEATURE_SEV also gets cleared, we won't make the adjustment even 
though when we should.

So I like the idea of a callback to calculate the number of reserved 
physical address bits.

Thanks,
Tom

> 
> Jacob

