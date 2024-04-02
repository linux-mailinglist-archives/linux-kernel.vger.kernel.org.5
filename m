Return-Path: <linux-kernel+bounces-128791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B3F0895F92
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 00:31:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58B291C21EA6
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 22:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9A0A1EB31;
	Tue,  2 Apr 2024 22:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="H6RJ6zBX"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2120.outbound.protection.outlook.com [40.107.243.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0976813FE7;
	Tue,  2 Apr 2024 22:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.120
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712097076; cv=fail; b=B7OwjjNMD23bdnUz/eOaWpyVV/PZypvCPdF+cRX0A8A5zT1nwupzuiDx43SBOuYNaxerTQ/nXafalehB3d37avnI4npU6h1F+2uAOxfFuy4rO9RyohksvOWX+24jCVcAafnW1fHzYmgfAwAUJZ4lekyuUlymlKAELVhjA548WMI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712097076; c=relaxed/simple;
	bh=I32PvyRaBbiwAFn57Kf84emG9CXxj7hOSBfrM3oj5Fk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rvQDJ6cDY4fiZ9wZK0Txq9zqeEKi3HtuztwFvne8rYLvi/eKQ83zsB8SUZoOlIrv0rRLQksYO62XmqGdliQ6DLkTW1yonWb1Gpu3ZXvwo1XFK5buAjtW3v81spnyRZzy4bSIAuwKhGf+ManHYjZCcF/yTYMu5NXv99zKX1/9m8g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=H6RJ6zBX; arc=fail smtp.client-ip=40.107.243.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XNI52YPzBjzf1BBVQQdKunqw/Mh3uXXTbuYG/oOwttYok1SEiiAoKaZf+nmZQxHiJCN2stuZ3rO/USjxkEcQ77c4JEih4++4TLP6L7/boIlAHmWg5JJgIsNQei1puz/qXN5KEtJRBcx4hUyUK4Ve1qwPjC0FWccIRjZsp1oi7XidOua5bcdB5dNfEgin8EUB/+yjDtCHXuCZNQ1RkRAEz0P0LTANvh924hLKIoykGENsjJNlTBXEE7R8Vu4iMejYhBQaH7UreiKWwmLKCbYeKZy49m95YFFIGH+5obSXrPd2VJBv7MtovO1Voz8f7uFNdT9KeSvniTqHyorlz1H+4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DxD9+H6TumpdOk2BzTb2V/tquCIUmivN61R+GWkbj08=;
 b=ZVAadC0FlKT+Bbu53m79CV9x+2DL8SEIkgOD57Z8AzV0NshZZZUVz9A9KKujYNQ7lKMHGuTSy1wJRyOK24eOlgNKBro3/SrqQa3Yjf+RsvTexI0iQSeyo0nOkD1InhxlxT5IgktoqZYaN/e+LSky87SQb+Ekr6YdFGAJB1s4aSdidogxQ3YQkmjSEOqceX2fuY8nIZfCRH7eXMuMAeXM1bR7+SNJ3A5M1nR4SB1czn1584hQ/aA+TZEwOqyS8gaWOgyLHX9P7imazHdiMv7mRbX7ya8XaVfm7wFOzRVpxjlH/sLgy1Jy+CcrX3LBlrXVzZHlDRiMoFIdvuLS/np8+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DxD9+H6TumpdOk2BzTb2V/tquCIUmivN61R+GWkbj08=;
 b=H6RJ6zBX/wVAuDTOM88iQgUVLLy/z1S57G7QmZdJNcEnCFisfMYhxk5/862reuH+/XI+zItb6kJHYIWh/Wg/8UHfuM/KxkFyfG2FkLqJtfV7/S19L/kyjAOHkNi+/3iAuOl/yjce3qXf9Q/vP/tVmAYzDffjuMbmxarHNR43Agk=
Received: from SN6PR12MB2767.namprd12.prod.outlook.com (2603:10b6:805:75::23)
 by MN2PR12MB4374.namprd12.prod.outlook.com (2603:10b6:208:266::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 22:31:11 +0000
Received: from SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::3cc5:f552:44ae:1f26]) by SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::3cc5:f552:44ae:1f26%7]) with mapi id 15.20.7409.042; Tue, 2 Apr 2024
 22:31:11 +0000
Message-ID: <b2da0a15-c0f5-49a7-b34c-eb408e9aa293@amd.com>
Date: Tue, 2 Apr 2024 17:31:09 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/sev: Apply RMP table fixups for kexec.
Content-Language: en-US
To: Tom Lendacky <thomas.lendacky@amd.com>, linux-tip-commits@vger.kernel.org
Cc: bp@alien8.de, michael.roth@amd.com, x86@kernel.org,
 linux-kernel@vger.kernel.org
References: <20240312184757.52699-1-Ashish.Kalra@amd.com>
 <b1822884-cba3-4009-d685-81a36dbb4353@amd.com>
From: "Kalra, Ashish" <ashish.kalra@amd.com>
In-Reply-To: <b1822884-cba3-4009-d685-81a36dbb4353@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR13CA0004.namprd13.prod.outlook.com
 (2603:10b6:806:130::9) To SN6PR12MB2767.namprd12.prod.outlook.com
 (2603:10b6:805:75::23)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR12MB2767:EE_|MN2PR12MB4374:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	nGBvK+HhEFa/2+70Gap+tlU4KVcdY+Rz+jr9Vl+MB0swqOIRlYUymr16Ea2k1cPSurQKtyZ6SpaHYOQxkRK5R2Q0euup9nzU0zKsrhBWVwV3sqdMZvR6Fia2ESeKu0nm8virtjssMzknNA94McMs0PcNQDf0h+v/bselECmR5gbdmUAHwGMW3bm63Npp35oDOnm5j6OA2ETj1Xn4LV6upcIMkKiBvUWySJNvXmgZVyl8vdP7jYWEhQdMhNq/mbZpN3fC6EDmYo3cztEIJnNH2fM/vCWQdc3LSzquee4mQ4Jf6+WNAuTsNQFC1QMgRbm/2KcxmvdrbJe9xRORh/dqxeaySFJmHeigSi9r1YTnbNnJa/n3oRxIi5pp456TEVTDm8bHf+TtkCi7Lw+Gy/kA6IKjuhQb0EFO1ch6gv7EG5q372TAedqBBDJqjF7ptw1+l6Yqw8x2aSIz4pdvTCm2l3ScHocV/9v8Ug/YSrRi6TvY3JPHoIgi98Xzu8I/uczz2YHtkp10eJUjrZ/H/Qpfl41VtdnVc6T0zlxt/pe0lCqjnAlY6bYsLdmXD6NAMOF7Ym9CUZoEsEXa73cGWpJhBGsi/GZA68qnPkdi2kWMfV00GpcXJLmEvaz8oOT00AAU9t7yDTQSPxLRNzb9VhmqIAOhbn9cBg7PrxfBr0z0mrA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2767.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T1lrbmZYU1NNdUVYY3R4QTdjV2hxV2VwZGViS3BHMXJZK3FveUNoWEZ2SmFG?=
 =?utf-8?B?bStTeFY2OFV5bTVvbzBTbkcwZkZSMytxYWZlYlZyWkM4VEJHQ0ZFRWY0LzFJ?=
 =?utf-8?B?VGppVm1nYUtXSVl0TkhKLzZOdGluajJqYjZHdkFDb2owVmJqdURJcFhFQnBH?=
 =?utf-8?B?aS9uRURtckdLRjNuWGd5dTFOdkZpOWdReXZmMHFBR1B3cXo4R0VHcVV3N0Ns?=
 =?utf-8?B?dGI1ZUhOWnlnN3VYYkd1OXFZd3JmTFoyZHRvbzVueTJaVkVFNFVsdGN1TEsv?=
 =?utf-8?B?VzcrU1ZiWGxVUzhPNDg0RXFDRk1PL2txQ0g4elVjTUZ2NUk1QUdqVzFBbDAy?=
 =?utf-8?B?VGZ4RzNqQWdPZXRmUUQ1SHFQdzFiSDFtdm5hV2hwc0pubkRoK052RUFNQkNZ?=
 =?utf-8?B?NTd1WmJQeWVCRnVCaUdsdjZNL3lPU2tpNEN4cERyNkRFSjIrYlBqdEdxdGZD?=
 =?utf-8?B?c1VCNXFvZG5NL1h1NDJzQzFaK3pNSndqbUlLU2FBRUFmQ3pTeU52TGY3YjVG?=
 =?utf-8?B?L0FpRkhJVWVhK2tsNzdWc1k0RmFiV0hOWW1MWXNzeXIxZkR2clBJclFDZm91?=
 =?utf-8?B?eVlvRkd4RWhGMmk0T1I2ZG00TURiYXlSMUUzeFhMbnVyVUhYQVlZV3E3QWd3?=
 =?utf-8?B?ZGVkUStHb0ptM09KRFBzTTR1VmMwdTM1ZSs1TUdWUVdxYkp2anpab21pbm1M?=
 =?utf-8?B?VG9KcHVWdVh5OEJLYjFjRlkvb2tWeFJLa1F1czJtbWdmdTRtZUFYTzJvbFJP?=
 =?utf-8?B?UWQxdE4xNWs1QjNncmp3em5GNTZCM3pBclY1U2JyYmNTTXptWmtyZmxDd1Y3?=
 =?utf-8?B?UWxRL0Zsc085RHlERjlKbHo5ekdqT2dmL2ljMGxONWtKcEh1TDZSQlNnWlBr?=
 =?utf-8?B?bEJrN05wT280VEZ1allEWDhKQ2NvajViZitnK05Idkd0OHd2VW53V3loaE51?=
 =?utf-8?B?aHMzb2w2a2NLeEZOclltN0N0dytTQ2VBWC9ZbHdLZS9vcnU0UlYzN1NjWjhr?=
 =?utf-8?B?eTNGSWhSZmNoRXphbzJTbTMwcXZnWUt3T3N3SW9MVW1IcWlSUzUrb2RGMU1S?=
 =?utf-8?B?ZzZzbGtRb3BZYTIvU3Fqemw3dEZjVTJCSjJKRURxWE81TERXblFhV1dHSEE1?=
 =?utf-8?B?d0k0blpCblBxNkt4WVVvTnF1WGVrakx5VDNWSEUrdm96QTFRQ1Rqc0JzNkJN?=
 =?utf-8?B?VUM1NE5nQmpmR2kvSUFGZjU4VncydnRyUllrMmd4NEU1KzVvV2JaTk9zdU5j?=
 =?utf-8?B?dFcybm1hRG5uayt1ZHkxSkM0OXowL1I2NFhxT3pGdXRvR0k1VzB2djRNTjN3?=
 =?utf-8?B?aEFxRHZxTHdjVGpzUTdtVXpuQ01uM0hwWVV5Q1c4akw3Y2hCREJTbGozSkVU?=
 =?utf-8?B?KzhjeTRRTmgycUtueHgzcVZrc3BlckxYbXBKeWVzR0Z3RWh5dE00cnRodVpx?=
 =?utf-8?B?QTJMd3lNSmIwYTM0VktIVHdFUWptTURwc1pKUDJoWVRIelQ3TndqYy9XZjZV?=
 =?utf-8?B?WHllMTZQYUtZSDRTY1FsUkZuRnpsa2RqSVZ4M09oNkVqMDV1aVR0L0FZY1J0?=
 =?utf-8?B?RzVHTjhOZGJoZTBWeUVZRXNKaEh5Q1NGVWdPMklBV3NCS0M3ekFzSWhxVEZS?=
 =?utf-8?B?TFJnVDJvNStRS2FNcGlQZE1rK01Rbk1peGtvclhTYStDNkhSN25vTVlxQW55?=
 =?utf-8?B?QTVMa3JXWnRkdEY2TmlPN2ZQSXdFVldSYWUxNFpKMnJRUVBGaWc4ampaRUFs?=
 =?utf-8?B?NUtRRFhNYnNOZ2hXc2dWWjJZNUtDSWV5ek9OMER2T1N0b1B0SmFOaHZsWlIx?=
 =?utf-8?B?UWxORHdGMzh3STZwSmVNRGlSTGFCMDBMdGtXbzk3VVgvYTVDSmU4S2ZqVVcv?=
 =?utf-8?B?MW1UV0xETVJ5SytOVDI4VFZVVlhJRUZSdzVoRk9hUmN1ZHROVGV0b2h1bkNF?=
 =?utf-8?B?c3Facy9CRUpmSmlXcjVDNWM2eXpWRW1WUEtmbVpJSGllV0N5bllaS0k0ZkZH?=
 =?utf-8?B?eTVkNmEyY0R3NGxIT2dxSld0MGdJR203R0VQWDRha0xCVkJXWVUwQmRxY2h3?=
 =?utf-8?B?NDNMNzJJOUJtdkdNTUYvMzFjU2NZNEFrT21KTzYxMzhyQ0lKRWZvMnF0ZitE?=
 =?utf-8?Q?X3j9FKbx8WfQQYDS8fIs1A5wv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e66398f-25d9-4014-e267-08dc5364992e
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2767.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 22:31:11.2666
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d/57/GW2t2yyktjoijWki7VlQG+fiSCdyKUjfcNQRBbDsMqQpPhcJJpnkjCEz9fpjDQ/LVH6z++iLz7y35RFbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4374


On 4/2/2024 5:09 PM, Tom Lendacky wrote:
> On 3/12/24 13:47, Ashish Kalra wrote:
>> From: Ashish Kalra <ashish.kalra@amd.com>
>>
>> RMP table start and end physical range may not be aligned to 2MB in
>> the e820 tables causing fatal RMP page faults during kexec boot when
>> new page allocations are done in the same 2MB page as the RMP table.
>> Check if RMP table start and end physical range in e820_table is not
>> aligned to 2MB and in that case use e820__range_update() to map this
>> range to reserved.
>>
>> Override e820__memory_setup_default() to check and apply these RMP table
>> fixups in e820_table before e820_table is used to setup
>> e280_table_firmware and e820_table_kexec.
>>
>> Fixes: c3b86e61b756 ("x86/cpufeatures: Enable/unmask SEV-SNP CPU 
>> feature")
>> Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
>> ---
>>   arch/x86/virt/svm/sev.c | 52 +++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 52 insertions(+)
>>
>> diff --git a/arch/x86/virt/svm/sev.c b/arch/x86/virt/svm/sev.c
>> index cffe1157a90a..e0d7584df28f 100644
>> --- a/arch/x86/virt/svm/sev.c
>> +++ b/arch/x86/virt/svm/sev.c
>> @@ -65,6 +65,8 @@ static u64 probed_rmp_base, probed_rmp_size;
>>   static struct rmpentry *rmptable __ro_after_init;
>>   static u64 rmptable_max_pfn __ro_after_init;
>>   +static char *__init snp_rmptable_e820_fixup(void);
>> +
>>   static LIST_HEAD(snp_leaked_pages_list);
>>   static DEFINE_SPINLOCK(snp_leaked_pages_list_lock);
>>   @@ -160,9 +162,59 @@ bool snp_probe_rmptable_info(void)
>>       pr_info("RMP table physical range [0x%016llx - 0x%016llx]\n",
>>           probed_rmp_base, probed_rmp_base + probed_rmp_size - 1);
>>   +    /*
>> +     * Override e820__memory_setup_default() to do any RMP table fixups
>> +     * for kexec if required.
>> +     */
>> +    x86_init.resources.memory_setup = snp_rmptable_e820_fixup;
>
> This produces a build warning:
>
> WARNING: modpost: vmlinux: section mismatch in reference: 
> snp_probe_rmptable_info+0x95 (section: .text) -> x86_init (section: 
> .init.data)
> WARNING: modpost: vmlinux: section mismatch in reference: 
> snp_probe_rmptable_info+0x99 (section: .text) -> 
> snp_rmptable_e820_fixup (section: .init.text)
>
Oh, so this requires snp_probe_rmptable_info() to be fixed to use the 
__init macro.

I believe that snp_probe_rmptable_info() should be anyway using the 
__init macro and this fix for snp_probe_rmptable_info() needs to be sent 
as a separate patch and regardless of this patch getting merged or not.

Thanks, Ashish

> Thanks,
> Tom
>
>> +
>>       return true;
>>   }

