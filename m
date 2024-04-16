Return-Path: <linux-kernel+bounces-147120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECC728A6FB2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 17:23:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3D56281A3B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 15:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7307D130ACC;
	Tue, 16 Apr 2024 15:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="RN5a9UIs"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2059.outbound.protection.outlook.com [40.107.94.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A79913048E
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 15:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713281019; cv=fail; b=gb2/z6FJN37cze+WQ+gVvu3Xc944oFEyXkPs/gn8XKIZzZ208R8kUQYCdYWC3CSqWGi4ZpAfZ9JDKYkQtnd6GzOTjRBG7He5PLUVbxYbw+5Ny4EG7zPh4wW5ZBTqSZ7SxlVcXFik13bHs6mXN+6p7aB/nkhnB3m5wF2ckpLp4Vk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713281019; c=relaxed/simple;
	bh=mZ8fzMumNUfuPXzPZ9Rdr+xo7oC1euIn3b8LZHda/bw=;
	h=Message-ID:Date:To:Cc:References:From:Subject:In-Reply-To:
	 Content-Type:MIME-Version; b=SQ3LH6sCiH4izHqoZzDtm9pJ69oQnPg2pIt/lcpmdxL+h6d/gwTZ2Iq63zdMBEQ8AurN97XpI62FLukNjQwE9xOfwQP4+CQu+JsaOqj1YinmqKWc235dd6LcJdBintyBbeALQJkVuWTKdVCozBE9dD6KBpA+S2Hii/vEgN9Ry3s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=RN5a9UIs; arc=fail smtp.client-ip=40.107.94.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a5Bcqe2Ex9DwsGo6BrGubhhbvJKK0MRVQ646E5RB5eVHthDTz3lE+pP193wH/z2eCZwPI5pAr2K2UK19CJn2NEFFH6GSnN2QA8+g8rgdVGq8CSf1UnYXu/Qg/ac5VTRsAogdDEmnF0zHCCQu9eZ+lRCvshZ/TYbfIfJU+6gTAPVDDmTEnYgJQ9nDxDy+KU1XcQMT51tWvl1tqAz8GludKEqxeKs9FamXWMsQD3DNFEHoSMVSnuhACZjcHAy/I0Z2KGClbGljEfKW+cvmZBQVkuVaVfYr+07cypkpsryUf/rJjckjOJSKDaULELIKLiAJv/clUJkKQbDICX1PbzRGPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3ebCs0dz4LIz1cxpSdWY0HjZ+v/60SibESFOEJiuTuQ=;
 b=HbUqiIUwjlyHw0i9kfmzpWepyiYIFze8IUTipyNTTaw+8v97SAVadI4SYW2AeB11M444fJvEHkQ+8mx7WzYyuGBCxVkkCrjux3XoqJdT8rBJxlDzDgIdrSb+WC1REYvK1GbghPrnjvUAJ25kNiIOhcz1Hm0hbDhydnSa4zumwbpdWpPTqkMpe/VJwel8QZysdraRSaxlZG8Y20+x7gWhHB0HO3zAlv+710YlTdszLRVuCTJjL+zBmZTCFWHhpPrpmOfiKo+LrrFqDXPQT0uY2lUvJUtX7Jspm2mmqDLFKJWiAbanBgQTpzWoQriVuo5unz0c6NbrNIZS7YedFSSj0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3ebCs0dz4LIz1cxpSdWY0HjZ+v/60SibESFOEJiuTuQ=;
 b=RN5a9UIsQDBUjYPqfdfqV0sd8Xz7e8KUENHgKYkxAezYvQookIINtRH80OUsjQyd/RhAdgdFdA3C5uIXqir+cgMia3pEWAqra+VG3vvKmiLtKrXPOlMBTBj3KutOGQNFURahSMmT0ySiTLVdI+JDnwocWvQH+8MM+4oTLjRagsU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5732.namprd12.prod.outlook.com (2603:10b6:208:387::17)
 by BL1PR12MB5898.namprd12.prod.outlook.com (2603:10b6:208:396::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Tue, 16 Apr
 2024 15:23:25 +0000
Received: from BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::bf0:d462:345b:dc52]) by BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::bf0:d462:345b:dc52%6]) with mapi id 15.20.7452.049; Tue, 16 Apr 2024
 15:23:25 +0000
Message-ID: <061802e1-7c95-f1f0-b462-3aca27583d76@amd.com>
Date: Tue, 16 Apr 2024 10:23:23 -0500
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
 <bb088b1409283cd323515138feda224759a247ec.1711405593.git.thomas.lendacky@amd.com>
 <661e04cd345af_4d56129468@dwillia2-mobl3.amr.corp.intel.com.notmuch>
From: Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH v3 10/14] configfs-tsm: Allow the privlevel_floor
 attribute to be updated
In-Reply-To: <661e04cd345af_4d56129468@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0146.namprd13.prod.outlook.com
 (2603:10b6:806:27::31) To BL1PR12MB5732.namprd12.prod.outlook.com
 (2603:10b6:208:387::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5732:EE_|BL1PR12MB5898:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f6352bb-66f1-4507-d28b-08dc5e292908
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ShOfy4OVIY6toO1lCF8wKTht5pJ6mNnC1z3MDphkrgZidoPeE+VZOIP932zJkyhp4o/RrtQSxs4kXHzvFc61kSGk+iW80MPbSIwvoPGgK5yBZEy0D6pc2HnEU6zV7IL4+Wfqs6mKtqHG93OlY7P+S6yf8Oz+/H9IFsgJVCqr80zKpgriEMCiyFnioXG4+/tJCYCj7DFJRYswWFCT8uBAsBI2ifEJ1HJBt0MHBUMFLz1mN3kmxU2ppppExWcjGrXgHYtAkFdiPjbMhU/SdnHQWEvgKmej+4YFKm8QGOAGEZ2H/3eARPGt3R3F+yG1auWKiIwzxPpkNvf0H8Ol0y1AkJOgrxYEhkkQERF49fcqPQtHY1gGlZIBCzoVqf1JSeQhWtNFUANWOKF4D3nWSCPTFsbSSsj2sFP921AL02GGo7oo13sHNFKtlzAa0tiWBakiQpPD6gLwZ/KIK7r9t4JQLIyRqtdRH2b/QsiYUyFFlnlpEBWNylhsGa+dbmQFuM18xLfZIM+ozpbfVpq/J3Tr60xkjSo/Xi+f5OT0iYcm3f64k/NOpxNvzQuTVllNM69DLjuc8DuMcMB9NSXaA5FYvnAgdG02aVFB74JHNm7Z09sEZxIEFM5YQ/jzpdDXxRPf5dhn1aqdSc06qnwDEv30Z24mEER3jhd1Ycz++0E3/2w=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5732.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L3g2QXQraldsRnRoY2tzd01UNEZMMGJWRFM5MmZZRWh4VU0xdkJCM2UwZHZa?=
 =?utf-8?B?WmxxV1VVbXloTWlnZlpORDVzMDQzYlRLaTZKYkE3VzNMcnRrc1JpVC9FRzJ3?=
 =?utf-8?B?RW1Xck41RjhnWTFOYTUvZHNiMEFQcUh6Ui9sckpIQWE2eFMzS2xDVStNdzRF?=
 =?utf-8?B?eFBxS20xdm1TRExzQit3dDc4aEhxdXRUU25lUFBDTEVCdzQyUDRHYVFpOTM1?=
 =?utf-8?B?eE5qOG9PT2dPZktpSzRqOGd4N09BM09UcFVlVDZJdGpXUkphdGQ3NFlCUXda?=
 =?utf-8?B?YkM3MWpueWN5SytiUmFNaWNUOTJpc1RUaWdCSHJTOEZVaTNaZ2NtMlVaZzlX?=
 =?utf-8?B?dUFySnN5VnFFWnRiSE1jTEQ0Y1ZaK2d4WE43dGR0Tm5kZ0JVMVVRbVN1L0Nu?=
 =?utf-8?B?c28walBxSitBUGI4amxxY29DalhmM1N4OGRIcUVkOUltOThTOG45MjNXUCtM?=
 =?utf-8?B?Mkx0VjZJQUFjZ2xFVldOZEppQkNkSHc1RTJ3N0txZTNiY0hXMWNubVErVlNp?=
 =?utf-8?B?UlVRUFQ0Mk1JWGYrWDVXOFVLRDN4dlYyU2FEbWFBZXQ1aExEQkhBY2ZzekFj?=
 =?utf-8?B?SVJ2Y0dRQVhjd1ZtdFIySDMxbXhCN1hKcHhzL3dYWlV3akdHNVYyZmZ1dFRV?=
 =?utf-8?B?S05CeXFoTHVzWDZHMnk2enduUFRNUnMrVnJMaU1FVU03ZzBJdk4wanMxeHRp?=
 =?utf-8?B?aURoRzRiamlqdDllZjdKMjUycndFNWkyc3RXNWo1Si9NWjVUUnlYN2Z5ZFRq?=
 =?utf-8?B?N2s3U0dZL0hkeHFnODF2Qy9DRWRaQzdIT3VCZDJQRzJLUGtyYUN1OUozc05y?=
 =?utf-8?B?SXdwazJIdGdWRTl1MkYzRFVFOTZqM1NkcW0yeWJ5R2p5ZVRLQyt3WHlYUm8v?=
 =?utf-8?B?Rng5Y0NuQTQrRjVwN0YrcTlacEZCalQybWRYb0wwa3ZNdUR3eGw2dGVBZ2Zq?=
 =?utf-8?B?eWl0a3Y4MmVvV3FZMkJNcGY3KzMwUEh0cGxrTkhPdnNVKzNBTXlaY3YvY2dQ?=
 =?utf-8?B?eU1JemNoYktGSU1Ba2dUTjU3aDNWWURKS0Q2QXYwb0ErL0pKNzZNaUFwT0pR?=
 =?utf-8?B?NGcrQlBPMlRQUUNmT2ZIMVJnSXROa3F5N1Q1ZUNydVVrWUhHQTNIUnpwcDlI?=
 =?utf-8?B?OG01NmYxaDNadkxMUzNjZUJNSmpqVGlKNGVTN0lKQkpIMm9GVWtpQWNrUW5N?=
 =?utf-8?B?QlhmYVJld2V0WE1Hb3Z3WWxhNnp5QTVpMW5oR0FyK3IzWGRla2RGYkRGa2Fi?=
 =?utf-8?B?cnZkU1B6WHR5SjdCYkIzY2VqaElBWGVpMUZvQXNLL3FhSGd2MnJuUjRNcjdR?=
 =?utf-8?B?dEF5bG5vOHY0dElYaG84NjZmMTVNWGwyN1UrTnJMT3pVUWk1Ny84RjdnMU5W?=
 =?utf-8?B?SDJmc3BNUnN2Y09mY2w4QlBLd3V2S1haYWNnT3c4OXJURnRqbCtHbUxqcGZh?=
 =?utf-8?B?YTlHRmNaeDhrUmFkQnl4ZnNIajM2TWErR0I3aWVlMWc2bmRFQWhaTitBbTlr?=
 =?utf-8?B?R0Q4ZkdjcTJzWkxvMzNlVHc3Q1J3T2lORnRFaGdKZjVSdVh2Q2hEQjgrYlpE?=
 =?utf-8?B?M004STdjV0dBYTFiMG5tZFFlTWJQQURsVTVBcVVwQ1Z2RUFxQk8zTWlRWk8y?=
 =?utf-8?B?Z1RmWFdvaWQ3RU1LNkFydUdnb0dMRzZmaWc3T2R6RXhiRlJkUWJRdkU0cVd2?=
 =?utf-8?B?d3l3bVNlUFNCbUdpMzdzcnlIQmZWeDJPZkZpWnlBY3ZwKys2TG95RVBlU01x?=
 =?utf-8?B?UlJUZjBKMFFDcWVBNjZNSXEyZmUyWnNuNWI4TjBlQnRZbzhVNmZqcnlzYnlN?=
 =?utf-8?B?SHllZkxTL2JtbGFjcThqUGo4SWQ0akNuTlFiNVZHMlZIdjh2V3o4cENFMFho?=
 =?utf-8?B?U2lMbEFWZUpiVWx5d045YThvQ1NCVjVUbmRkcnJxMnVvOW0vZGtscmRGNTkz?=
 =?utf-8?B?ZmVuMW5nTTVrOFA3MzVEa1JOb2p3ZFozWXEzdnh1eXhPWEFXVzVmanFjeFNj?=
 =?utf-8?B?M29iU2FEWDVNbFF5b1IrZUQzNjNzNFZwMW9JVDVSS1hsU3dEeTJjTXFTRVFQ?=
 =?utf-8?B?OEtnR21MYU0rbTFiYVJnWlcweEZwejQxdzRvKzkrMnJGVy9oUndaUnJJS1JV?=
 =?utf-8?Q?7pT+QpPsq2kOWB9NtmRnzkp9g?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f6352bb-66f1-4507-d28b-08dc5e292908
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5732.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2024 15:23:25.6626
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DODHUVfSEXZg2kRKUthCdDrw6hfgHuFxOoPj8XSJQ8db8MRAmNPjMbVAy68uj2oo0G3GWdpXQT/Ir2uW1xQ5jQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5898

On 4/15/24 23:55, Dan Williams wrote:
> Tom Lendacky wrote:
>> With the introduction of an SVSM, Linux will be running at a non-zero
>> VMPL. Any request for an attestation report at a higher priviledge VMPL
>> than what Linux is currently running will result in an error. Allow for
>> the privlevel_floor attribute to be updated dynamically so that the
>> attribute may be set dynamically.
>>
>> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
>> ---
>>   drivers/virt/coco/sev-guest/sev-guest.c | 5 ++++-
>>   include/linux/tsm.h                     | 2 +-
>>   2 files changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/virt/coco/sev-guest/sev-guest.c b/drivers/virt/coco/sev-guest/sev-guest.c
>> index 1ff897913bf4..bba6531cb606 100644
>> --- a/drivers/virt/coco/sev-guest/sev-guest.c
>> +++ b/drivers/virt/coco/sev-guest/sev-guest.c
>> @@ -885,7 +885,7 @@ static int sev_report_new(struct tsm_report *report, void *data)
>>   	return 0;
>>   }
>>   
>> -static const struct tsm_ops sev_tsm_ops = {
>> +static struct tsm_ops sev_tsm_ops = {
>>   	.name = KBUILD_MODNAME,
>>   	.report_new = sev_report_new,
>>   };
>> @@ -972,6 +972,9 @@ static int __init sev_guest_probe(struct platform_device *pdev)
>>   	snp_dev->input.resp_gpa = __pa(snp_dev->response);
>>   	snp_dev->input.data_gpa = __pa(snp_dev->certs_data);
>>   
>> +	/* Set the privlevel_floor attribute based on the current VMPL */
>> +	sev_tsm_ops.privlevel_floor = snp_get_vmpl();
> 
> Why is this not vmpck_id?

Good catch, this probably should be pulled out separately and submitted 
as a Fixes: against the current support. If you think it's important 
enough, I can do that and put this at the beginning of the series. Or I 
can just modify this to use the vmpck_id value. Any preference?

Thanks,
Tom

