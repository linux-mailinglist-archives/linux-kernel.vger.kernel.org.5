Return-Path: <linux-kernel+bounces-110674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A69C0886227
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 22:02:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35EEE1F218E4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 21:02:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EC7E13541E;
	Thu, 21 Mar 2024 21:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Mavkhv5b"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57741134CC2
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 21:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711054941; cv=fail; b=VuU2t5jEslTipAV+7dBpY5N67ujCvp3SFgB/TT96frL2N+w4/nQUOD/v20gpyXj/hCfPK2W9WPSukT5dG4z9OOGq4QC+F+LrfIqbRRze5fodm+apdQAvK+eVkv5lTSWNYsIi+gED6Wajz27QiYqNR3/Yb6OBVtIAQwdXi1cUrTg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711054941; c=relaxed/simple;
	bh=7InAVX7WPBtwkFYY/1hdDWz43IpEuvj9yJVyTKOEdj8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Bdol41zBrW5rSIIS5xCKRpc4baD0JOritmbgelYVka83UgJcY/H6iohRxDr6KczLvbQD83YrEbYe4TmQ1enSSYXDRkD65fILnq5/NptBG0LFBlEJGPDO8fNK3pdacJ2nwVgWIOuKAAIEWHLF5abifv5YJ8aL87LacoI4SjSg8Fg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Mavkhv5b; arc=fail smtp.client-ip=40.107.236.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mX4mX/4kEQVifnm0O6167ScseWemmXOPwJCftRNbxejEPVdYmKjjcmWDnp0KzMhk9qrdBdTcpmtURTTg9qP1m223ER3NVTPPl6SmS/TdqzqbyweZmQzumYCI41GkbTUxcre8jz/4XqJwKZxUJqmS0qUtAqayxzIOI3GWpQkErm5yB8TOADoQEPfvFzqCHwfeRp8BglrrwtReqKwmmIT5+s97XSqdqL0t1YeRLQddItcUTk9o1AzcbiTstKR2nFCUt7DR9j5CfOQMhR2K+YduHP0eyvgtiHHnjYFM6Q1qgpxwCCPrm5W9GAddV8/7QMtVAdhfT7ryOYWcm+p0UlFS9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pdTELuaEddSjn+vC57e3yL2PzhLl1OK6iJFS9xXL2m8=;
 b=Ji4bDO0x8WkeljUMylVxwux5aoTS9kQzL85g3qrBdhREdQS0D75ebL7XMONih93eQH8tanfWMLGFpeaHzAkSajCctV2u9pF0AqqZ7ApLLvsgnOc9DlOi1sviBLElNSxZE6JXDTSCqGti9i7oEru29EJEUJC7qYTVwIDTEkpf+Eb4cXo39w0S/cz9vtHcdSg61csoSYXqL466QROR/KEtbheujKOZBhMw+r32LGlYKxzpWASLPJcrHEIEF/2DCksTsIEC7628dUK0tbXrfTxC7EZ4dTVh2riwNZDEVG0t0tvn84g4mthN4mvtwBJ9Zx/IS+VmYxfrEntzz1O6fwcphQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pdTELuaEddSjn+vC57e3yL2PzhLl1OK6iJFS9xXL2m8=;
 b=Mavkhv5bpPHLpFV4xPkGGSidA7jnjeae07VqYMGQISLk764erUF4NLBsjEUqSE0hxIotrFeHJDvYPjCVfAVjlHekaOVCnbptTzNOheCWyDuedlvO56KQSBfYJcElOuJ31NpfIm1DvjeaCW0xJPB3nw9P7gYclpxThuai7SxtaEM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5732.namprd12.prod.outlook.com (2603:10b6:208:387::17)
 by DM4PR12MB5819.namprd12.prod.outlook.com (2603:10b6:8:63::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.31; Thu, 21 Mar
 2024 21:02:15 +0000
Received: from BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::1032:4da5:7572:508]) by BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::1032:4da5:7572:508%5]) with mapi id 15.20.7386.030; Thu, 21 Mar 2024
 21:02:15 +0000
Message-ID: <8f449fbb-c6c0-e864-befd-a3f95a89e85e@amd.com>
Date: Thu, 21 Mar 2024 16:02:11 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 2/5] x86/kexec: do unconditional WBINVD in
 relocate_kernel()
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 "Huang, Kai" <kai.huang@intel.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, dave.hansen@intel.com,
 bp@alien8.de, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
 luto@kernel.org, peterz@infradead.org, rick.p.edgecombe@intel.com,
 ashish.kalra@amd.com, chao.gao@intel.com, bhe@redhat.com,
 nik.borisov@suse.com, pbonzini@redhat.com, seanjc@google.com
References: <cover.1710811610.git.kai.huang@intel.com>
 <e1d37efb8951eb1d38493687b10a21b23353e35a.1710811610.git.kai.huang@intel.com>
 <tvembdwwh4immxytlfzlhpvd42dlfsz7sddb7msk23kdduhu3t@ogpc66hklorv>
 <38fca2fa-11b2-4eb7-9e59-dc5d524d172e@amd.com>
 <689bbd29-aaf0-452e-a97f-41b8e3aa6224@intel.com>
 <5a2441a3-4d7e-4fee-bfa7-65b53376b0ab@amd.com>
 <e677ab03-8b25-46cd-90ac-cacae6ba5027@intel.com>
 <bbtfbfkg6frhpvf34gqnml7mdgqtyt5khaiqi657nd2kbnlbib@yarqgrrszf4v>
Content-Language: en-US
From: Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <bbtfbfkg6frhpvf34gqnml7mdgqtyt5khaiqi657nd2kbnlbib@yarqgrrszf4v>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0179.namprd04.prod.outlook.com
 (2603:10b6:806:125::34) To BL1PR12MB5732.namprd12.prod.outlook.com
 (2603:10b6:208:387::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5732:EE_|DM4PR12MB5819:EE_
X-MS-Office365-Filtering-Correlation-Id: 56718077-c9e1-4015-915a-08dc49ea2fee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	JJqMe4cgPmNIeKif/2ipgRSOBeEumAkO7PvwOaZ9acLHIwp+xQeBvEdLC7o6H//w6LXz7booC70nqpl3JL4swIxIkyxZaecgP7TIWt9t+sYurUYYXBrVmPr9hYSecDn3YBhCjGzaCSugdZTZmT5BYBWxLV3tuEOxD4zU3DYGxCI7TFzlFMuoOUNmPC4KB7o0P+zxzMQOhse7A25+nwUZ1ToAAk4/AV26v+lz7RvRP2xmoHQktB7h23Iu2K809mgEnHkCdfDMUvKplXND88nlDZ5oGBLoUQukX5FIgQFEJLPkR+uCV+07DOk2GShvgayqayo3sVQOGfFs2zeIQ2FaIxeObHNp+tdMiHl9EUD6UGJz7Q71tlbPa1YgD3Jo7W1K/iJqOHPD8Gf53nouP1HtHb+1LUOxabTck/0dzkCyG5d/VVdunvT7PQjisifs3nZ5rHcaFkO5ly6FmHuetTJJ3Flvpxoxn6rsXJTGPIIug7a5HJkYINNrYjwR9ArJ1KrjQtO0oLZmTvzRBZQ8HeOBWZTQ+CuCPW8SDGW8biesXk5CziTHzbNbwZlxjQjSk1eAW+B4H9kop4gujzPpeOodpv6Og2YlpePC0pR25NeOWq7lfnuY+AG0w+TAugUAsCWC17PnsMvghs9y7MVrqejz269Alf05Rcv7Qnei/gNFBwU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5732.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(7416005)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?czZCTVFoYTVDR3BZeHVtVGRNWVN1akhEbjZrMlNZNjZjdEgxWFcvVitHUTR6?=
 =?utf-8?B?K3h3TGgwdklOQngxM1NvVFBBdURFQUUyckwxRTZHTDNmNXpkdklqQVA5RGxv?=
 =?utf-8?B?WDQyR21PdGltaHB2cEZPUm1aK1FJQWlGZ01CanAzdlNqTFZUdE1TZE9MeVQy?=
 =?utf-8?B?T1BCamFqWGwzN3k5Y0NkcHI0VGtRZ0wvSmUwT0xNQXR6K2N3SnI1cFVpd2oy?=
 =?utf-8?B?WjlYQnQvbWRveXIzRElqWVBCb1hCeW5ZYmRmNFhjOVlWZUJjc2gxL3FMdmlQ?=
 =?utf-8?B?UVhjN0NwT2RkdnlGdEV1eThpT2hKbE8vdDBxM0VQUHlxZE5jenhIQVVtQU1E?=
 =?utf-8?B?NmpUa2RiTXN3T0RyV3Jra1d2eExXMG5XcXVGYU5qelpVczV3clNVUSs1eEsx?=
 =?utf-8?B?STFUS1RCUWF4WWQ2Znh5RkZndWltVVlybDN5aFB5eUJMQ0ZuSkNVT0dtTXRI?=
 =?utf-8?B?SHpHWHcxSnRqZ29nSk9sMjNhZzEvRG82TVJBVHR5aXByaXRrZVRoYndnZG42?=
 =?utf-8?B?V1lXaFpMTCtEejBGL05nVUVKTGpHWGJ6eURKM0NTYytDOVBzT2VBNFFFNzNR?=
 =?utf-8?B?K2lUZHBsZmRFRCtYdUFDV0krdnArSi9XdmkxTDBYVU5aTTdwK2w1N28rcytC?=
 =?utf-8?B?cG51ZTJzT2UzNDFJSThUNk5HZDltSEMxTDRGTGlIck9XM2pDTE03S2NIa1do?=
 =?utf-8?B?dXo2ZkE1WVZyRnpPSzB6T1Yra1ZubCtmMWZyRngrUzVlRXRJYzFzVm1RMFpv?=
 =?utf-8?B?OUdBcGh0UWtnTUpSUTRsTklhUXU0TTJ2R2JjaGdtMEJSa0MrNHFiTFg4U2V4?=
 =?utf-8?B?UkwrM3RHMDU2dTQzY2Z0ZklGZDBSVFErdGVkZVNiODdkZGJPTFRYQU5iR2RC?=
 =?utf-8?B?Uk96WTkyVVRuOG14VldJRkxLaXI0em9lYWJONnVTM1RPSjhoTno4VzNINVBU?=
 =?utf-8?B?V0ZtOFYxSUVqelpLK01tZ1hGbURlM1hjNzJNM1JmbVM3SXlKdVlqVVlDM0hz?=
 =?utf-8?B?NmhYZ0xMU3orNUtRTEdsOUNIVGJseG5Fc09Oc20ybkw3SDJqNnNnMVlQYW1I?=
 =?utf-8?B?eEdPS2ZvZlFpazRZbDIrY1lIT0JPNHdIa2tQSFVGK0dHbXM0SEYzSkhiNG03?=
 =?utf-8?B?b3M5MklTUDNVNzV1MzdQK3RNaHZVZERwYXFobDAvL1FuUkIySEE2Um8wSUNy?=
 =?utf-8?B?OXFoazNIZCsyV3NFaEtSc1h1ZkNDQWRvS3VhVWhlQnMrNzVJT21Va0FiWEdW?=
 =?utf-8?B?T1UwblFIL3JZVVNQRDRpWTh6em5UVlpEclZCWHNZUXZlRCs5NWlGdk1oeXFG?=
 =?utf-8?B?c2lmT20zUDlwVThRK3ArTFV3blVIMmZORHNHVEFnbFNUMkN5bVVpVUNvWUl4?=
 =?utf-8?B?ZXlsbFBlbmtBRGhDNlpoOGxpNkJjNmdScktQSnRLU3BYc09sVE90KzRxL2ls?=
 =?utf-8?B?UkRwc3V5M1NUMXB2ZFo2YVpZR1ViUU5DclhYVThCT1hZVDJoNGtYallGWXhO?=
 =?utf-8?B?YW01RWJGNlJpNVdhYWJ0WlR5WDhMait2R2ZWSkwzQlAwbk5aeWo5UklUamZQ?=
 =?utf-8?B?UTVRM3AvVkxmRTNGdEdHeWFUMnA5UDM2Z3crZkpVWnZEM0xheDFrYVhTamI3?=
 =?utf-8?B?NHRrZmxwK1FwU0JZS3FBM1dubTlsdkxQMVE0dmV2Y3VmNGwyWWFMSUZjOXhx?=
 =?utf-8?B?YlNzRUZWMG5Cd2hMTHN3SWowNEUzZkZyakgxRndGS056Z3dMUDlyMnA1UTlM?=
 =?utf-8?B?QkFBUjhQd3BTY1V2dlpkRjFCTndINnppWFV1YlRQRklNdXdBRFkrWXhsUVQ4?=
 =?utf-8?B?ek43MVBpeCt5N041anU3b25QSk8xZWN6MTU3K0VoYy9uWVFpMGdIWjlwQnhY?=
 =?utf-8?B?T0dvNUg4K2VHbHBRRjdlZU9WcE5Yd0N1VUgvOHlucFBXN253VnFtZUsxakR3?=
 =?utf-8?B?bDFFU1RKUmRoSkdRRTBNeCt1TG9ZanNDNFg4NVk5b2VrZ1BMdTR2SlNqRWxM?=
 =?utf-8?B?N1FXc3Raem8rNUh5N29rbERaVVY0QjV1ak42bzVnV2pqNytOdnkwam1qZ1Nt?=
 =?utf-8?B?eVJqK2Q3N1prVmtTSEFLK2xTVUlnRHlqZkpEZHpGNzk2RElpZHlxYnNYRjdu?=
 =?utf-8?Q?Xdi5x36q2Na4BZ9N0PLuWp3r8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56718077-c9e1-4015-915a-08dc49ea2fee
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5732.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2024 21:02:15.6245
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LsUpfsDoy2Bf4Pltg49TmlM5u/VD0KIMBvH+t9elIVBTsYg3oU/sbt9a1bahtFTTNCoxnTWBzvV+oWWcdcH8EQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5819

On 3/20/24 18:10, Kirill A. Shutemov wrote:
> On Thu, Mar 21, 2024 at 09:48:28AM +1300, Huang, Kai wrote:
>>
>>>> Hi Tom,
>>>>
>>>> I am not aware of kexec() support status for SEV-ES/SEV-SNP guests.
>>>> Does patch 1 break them?
>>>
>>> SNP guests can kexec with some patches that are currently in process
>>> around shared to private memory conversions. ES guests can only kexec
>>> with a single vCPU. There was a recent patch series to add support for
>>> multiple vCPUs.
>>>
>>> Patch #1 doesn't break either ES or SNP because we still have an IDT and
>>> traditional kernel addressing in place, so the #VC can be handled.
>>
>> How about plain SEV guest?
>>
>>>
>>> Whereas patch #2 has switched to identity mapping and removed the IDT,
>>> so a #VC causes a triple fault.
>>
>> That makes sense.  Thanks.
>>
>> Hi Kirill,
>>
>> Does TDX guest have similar behaviour -- that WBINVD in stop_this_cpu() can
>> be handled although it causes #VE, while WBINVD in relocate_kernel() will
>> just triple fault the guest?
> 
> No. We never handle WBINVD #VE. Guest cannot handle WBINVD itself and the
> only option is to ask host to do this. We cannot guarantee host will do

Is the WBINVD performed or ignored in that case?

> anything useful with the request. I guess it can be potential attack
> vector if host strategically ignores WBINVD to induce bad guest behaviour.

With SNP, memory is coherent so there isn't a need for a WBINVD within a 
guest and so issuing it should not be an issue whether the hypervisor 
performs the operation or not. I don't know what can happen in the case 
where, say, you have a non-coherent TDISP device attached or such, but 
that would be very unusual/unlikely.

> 
> And it is not good from host PoV either. If it does WBINVD on every guest
> request we get guest->host DoS attack possibility.

Yeah, that can happen today, regardless of the type of VM running.

> 
> Tom, I am curious, how do you deal with these problems?

If the WBINVD is being intercepted, then it will generate a #VC and we use 
the GHCB protocol to communicate that back to the hypervisor to handle.

Thanks,
Tom

> 

