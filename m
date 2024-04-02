Return-Path: <linux-kernel+bounces-128715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 860BE895E8C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 23:18:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8810B25390
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 21:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8E1B15E5D6;
	Tue,  2 Apr 2024 21:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Q/0sJDcy"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2106.outbound.protection.outlook.com [40.107.94.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC1A15E5CF;
	Tue,  2 Apr 2024 21:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712092650; cv=fail; b=e+V+q+hYXJ5ssVppyAOGtSMLp4HyL3lTAInrNZp9PhdiAU1Xi6K++3S3sRDijo9B7uCpERe4rG3CjHsdgh2IwKzWxC/5c0AFm8tGqAYSwoLVVVU3JUdKIUZNf+MT8zP7cmAnVYIAQpCApR1xJjtwZvBKZf126fn/t2VbcNihPr0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712092650; c=relaxed/simple;
	bh=Rs9Y8DxLbF6N9W/cQ3iG7vxhYnnYQlU6VRM8xfx7jt4=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LLSnroGqD58cJjExRmUaQoRpds83EmP1ziYnR7x4W/I3+zfdAxcAncCjHfHDoiDT/0VS+MLu03bneFuip6mfhM1f7RohNkqDPG7ivbTrVIbuQg1Mpd0squFvNfK/NpAfYhxj+F/xtksbVoGcs79XhoLX1XNqx/Jq2QKTBGkXUJs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Q/0sJDcy; arc=fail smtp.client-ip=40.107.94.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DBTBUR0zUz8chmDrJAVhyFPXVjvnhgn/fvldvE/dL8OYFxZ/ZQfbuHzCBVUt/OUiMdwqVd53ywxCpCSuTaN4v0kCgQ1JnQv0NRXK+MstKJzyeHOnbqvcGmjhYG9fEshtIoo+bpVqSa6E/6kI8RkuRfnH+LPufvw4R/x0YjIoLTQY4B2VmbXsTRMw9miqwznWCcVKwbOxlgfe1ljbkHGXxeSU4Nm4CH5Zezpq8oK+pB8pHYdRp75KlK6S87pa0+lwevNgNrN5V45RHNCtD9jOwKJhdD5cGSzYNcjzmnNxlAz/6nchXj11AR7FbdAsaUhuwe7F8PcSMqdE8RTBokUcwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vJ7XAmuzqEcsApU3h7y8VKF+I/XIzQC02mAWbySiVEk=;
 b=KFvDm151LyeatgFlvhRJ9fNElSiAbggZXrGXVWq/yRJPQkc8aceZBLhoE1uLT/SEJLtiMGXFnmDYGU9S/qkzC1DQpM9NnYDFo9DhcjFShXdySQnSKvY9nNmUJsE7zzsNkxmEAtnFZU+oW8iLML7IHwqxU6rh2urvVAPLfvQLWzj3EEQKH7Sm7lEK+ebiMhSgwI23BqcvSL8SmeJnGhYHKkhdLseajX7xsu7MtgnPq/6RRv2UKENRuuyqrMPxO2eRteU6v5kWdGdHD/Q6QQrKU3E3X4j3aAeK8pj1V9QmpsUtcAm4XBE6P0GTkhiJ+0BUrLhXTdU1zXQD+62Rhjiayw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vJ7XAmuzqEcsApU3h7y8VKF+I/XIzQC02mAWbySiVEk=;
 b=Q/0sJDcyDo0EI6MRnuf761CZh+dsd3wGv+IBvurmXlyEuMb6P3ZoktVlWL20paMVAROvfyLTCPemTgp5uukcIHtnAmbW7Bt0aB3unrasd5dPXn+AX6ZRaX2UEkj4xstxsus3ap8pP7LDmf1Kay194cHUkp6mZdATI2NiHhRGdfM=
Received: from SN6PR12MB2767.namprd12.prod.outlook.com (2603:10b6:805:75::23)
 by CY8PR12MB7708.namprd12.prod.outlook.com (2603:10b6:930:87::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 21:17:26 +0000
Received: from SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::3cc5:f552:44ae:1f26]) by SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::3cc5:f552:44ae:1f26%7]) with mapi id 15.20.7409.042; Tue, 2 Apr 2024
 21:17:25 +0000
Message-ID: <7e15ccf9-1461-44b0-bc26-ede086bc4f25@amd.com>
Date: Tue, 2 Apr 2024 16:17:23 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/sev: Apply RMP table fixups for kexec.
Content-Language: en-US
From: "Kalra, Ashish" <ashish.kalra@amd.com>
To: Borislav Petkov <bp@alien8.de>
Cc: bp@kernel.org, thomas.lendacky@amd.com, linux-kernel@vger.kernel.org,
 linux-tip-commits@vger.kernel.org, michael.roth@amd.com, x86@kernel.org
References: <2ab14f6f-2690-056b-cf9e-38a12dafd728@amd.com>
 <20240402163412.19325-1-bp@kernel.org>
 <6f0d2ccf-243c-4073-a470-21e2f404595a@amd.com>
 <359264a1-e4ef-438c-8f24-32848e131272@amd.com>
 <20240402174540.GAZgxERNxsRJUCb1yp@fat_crate.local>
 <37321af9-aee4-4ba6-81ac-0df4cef38644@amd.com>
 <20240402185039.GBZgxTfwvEP45OxVjm@fat_crate.local>
 <8daf448f-eb52-4b1f-9f98-099a83665321@amd.com>
 <20240402202118.GCZgxovu-pgPKYvner@fat_crate.local>
 <6fdb98f8-b4e2-474d-b8e9-c3092e77e56e@amd.com>
In-Reply-To: <6fdb98f8-b4e2-474d-b8e9-c3092e77e56e@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0069.namprd13.prod.outlook.com
 (2603:10b6:806:23::14) To SN6PR12MB2767.namprd12.prod.outlook.com
 (2603:10b6:805:75::23)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR12MB2767:EE_|CY8PR12MB7708:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	IIh2Qq97FbdMGxFx2Hu30nzKVsoHnJsBO9DsEUUFi94F+3hCntHttZLP6/w6rhBu8ry5JdR2Jkux5RfTPXtrAEKBq73Fzffw7lvY/XvUHt31KTZKfi1Nmc0VK8ls7btEDIFk5G/OGs5trWAul/Ur/r/SIgrbSufkY75+w04OlgKv38pNxZDv2fDiXUiJR+2BoZiKrPjyAb81V9mbC91tY0ociVaov7gCs+tvwIIDilsGn4fUNBYvB43lr8e3m9Bh+wckb5GbqgpV5cQUBco7IJVR3Pc1dIvaCECAjEHwWYm8cL6X3RAhrI2M4RN50xxdsKUutG0ToNAxU/HBlLfDqZ++D7HvHkUDBnDhGm4Mxs5E3nsorxhiAwD8XqpdksVc78IYsM+GYfOH+Za72ll+R7LUeAk+EmsIhQuBqLLoJiWBUmB1V7avS8RdGnr6x06L9EvGOGfuAAkF9Vi1xJHxhFvYpeYfvt7iqEmFZzkGbLzXrsy7Sqa4ZZ5MoDAkbeK8QQwyMc+WIkKSY1Cb0wIfeo4nqJH542vXjfnTHiSGgrSo95D1+itM2h49GotE1/hs9gqBEa1Pcb8irQJoGyFwTRjLTUm4saRjVq4+ZKyq5NnJYLIqqAtFp1PVx/z1Asy97p9Cc5CvraCTrUxxXPk8zvGSpjZQeTYWJ9q/FTf+0N4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2767.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?emFUbmd2aENBdzFpYXpnV0liMGZaeVkycUxBSTZFVDBNVGZ6QWU4Sml3c1ZY?=
 =?utf-8?B?aE81WmlpdHA3WUFKL2RjaWVNMytlNkNMQTF4MTlUbE0rdVluTXdoVEZYUGRY?=
 =?utf-8?B?bno2cU5NK093WXhwWk9kNm4vcWh1NkJ3NzRXaWFtUWlhTzhnMHl2RGhlZkhk?=
 =?utf-8?B?eHNxdW4rYkcxVHJURlFRb0x0cURWR3V5d3ZpTHJJdGhPd0tUd3lOL2FIU2dO?=
 =?utf-8?B?VFFqakdiU2NrYWViakpPeGRLZ1FKa090K2JVbW5wclhXSUwwaFFKcWNMR3JF?=
 =?utf-8?B?VUp6S1RTQ0NoUWkxNU83MHZYNVFjRVRBUEhnT2V1THZyQm1PQXJYNTlpdytZ?=
 =?utf-8?B?WHp2R1pIcjRNR0ZaRXlTb1RsNENnQncvNHZOd0xtNGlMMy9iSEJiMjNVZEdx?=
 =?utf-8?B?QzcxQm00ZE5DejE2UG5QdXE3OEpFUmtWeEFsUDFaT3VqT2VuNTR0Z0FPbnJH?=
 =?utf-8?B?VmNxbWZ2ZHhRaXk1YmVKWUxqTnhpM1dkbHY2ekd0d1oxM0t5SldDVTg4U2h6?=
 =?utf-8?B?WkpOemIzVzQwUGZEWTRnUWE2OElteHNYM09ZUnFLZFlGQVVSb0ozUktDN1JT?=
 =?utf-8?B?NkJzQzRFRm1Fc1BsMUlHeXpTOVdUejAxaURwMFVxWVBiZVlnWnI1RG9sbHQ0?=
 =?utf-8?B?TVJnUkJWVHE2dVErYWFSQXBZelowQmxaa0dlOUtBV2czcVRPREFwai91WVhw?=
 =?utf-8?B?YmdaMEo2djBqY3IwWHp4Q0V6Q3Z4ZTg0bElSTFFBaDdCM2xLNERYaGtJTkcv?=
 =?utf-8?B?bi9WTWg1bHJhWUJSWlFLMlNLa0tiaUYyWXRNd0t4bmpDenNuS25neEI3dW1x?=
 =?utf-8?B?MnFyZnlKRTcxWHJRSTVNRVJHYmVSM0NRdjFSMmJicjNjS25OcGJLVGhWSEd5?=
 =?utf-8?B?UlRmek44Q0pFZmhFZXpGZHBucnkveDZWd3J5dDRvY3RoZ3U3QzRZRG9PSUtY?=
 =?utf-8?B?MTFxKzVBM0JPL1VkQm5RN2pCVVNkNCtRYmlYYUJQOGRTSGtWcnVuZnNrMXZx?=
 =?utf-8?B?NHgrZlZmYmswOGFtZGQ5djd1WWxEa204UHhKampwcDQvVnFtVWNLYzc1a0xr?=
 =?utf-8?B?K0dSNG8zZUhCL3RpL3pNWTBJRG4rTnNCcUNuYW9XM3diS3E2WnZKZXZsY2Q5?=
 =?utf-8?B?ay9pZDR6b3N3KzhQWVhoajNpbGlJaitFNktIUFNsQ1d2TE9ZNkU3bS9vWFh4?=
 =?utf-8?B?eHZGL2dJMDlnWkRPR3E3TGE3SEpBaWl4akFjWWRzRnVJRUNnV2lQMUJsbWFw?=
 =?utf-8?B?NzZDSXY2TTFrY1FSMzFYbWhrdUpIN3RLRnk3R2dJRlh5UWdqSkxRaXVpdWlL?=
 =?utf-8?B?RzVCUEJrRktOWXJ2NWt2RHpOcVJXNDZycjEzOU0yYUZSSFRDVVFJRDBrR0Yw?=
 =?utf-8?B?dGFaWWY4VnZkSUZHYy80ZHFoSlBVYXUxeUJZUEpGRW1XNW1zSk1jSkFqUFRj?=
 =?utf-8?B?TWpScG9aUmxGK1cwdGw0eWZ4YzJ1RkFSSkxjeXdBeGZEWDlOaHhndEpBenRD?=
 =?utf-8?B?V2oreldHUmRUZ3lmRnJKaGc5SFVXQ2lWemtsaHVaMWRwNkhTNVZ1ZE53Witi?=
 =?utf-8?B?QTVZTjk0aWJ5cHowSEZyVWluOStGMTAxQm5meUJ0dEQzUXl4YldBLzlOM3pn?=
 =?utf-8?B?RzhSWVBrSlFuSkZIYUcxNm5JeXJJdDBXSFRTY3NqUFBZWHN3bklmSzdQbEdB?=
 =?utf-8?B?dHlYYm9wT0lFVUkxZEVIajE1K3g1a0pJTUgwUHVUYTczeTQvUGFac1ZyQ0Jy?=
 =?utf-8?B?R0VNWkJNeUg0dEFTVFFhSFlLL2xRZVdsUVdabEpOaE5IZmZXN1cwZmFFanFx?=
 =?utf-8?B?dzRBY2pwUkdnL1J2WHpFRTdCQ3RmQUQyK3RXdzkvL3BXSThNcDJVdy9CQTRj?=
 =?utf-8?B?VjVPajl3eERFdTlHalhRbXBXRHpmUnhvQUYxcFlwTWd6NjcrekowdzdyY0tU?=
 =?utf-8?B?R2huRnNTWXR6NjJWOXZzejhIc0FiOW5jV0Y4SzlGbGk1NWw3bG1Vay9NOE4v?=
 =?utf-8?B?RGJXaVgyWVdUcDBBV2xSWlhZSjV4TkNjbkJjeDM1ODAyZ0ViK3VYN0JJcWUx?=
 =?utf-8?B?eFdOaE1nTkIvWkN4bndqbHgwRUltNWRIVFcrdVlMQUtYcXNDbzNwK1FJNjBG?=
 =?utf-8?Q?VxrswX71a4nfjKH8E75rJ7Fit?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d8650d0-2641-44ce-89c9-08dc535a4b66
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2767.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 21:17:25.7938
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ndmHeAm6OsyGBjHR142tLQaDKnn1WGZRju1qFHUbIK6ZBqtzbtuEFJxU6RlkF1ltZOa4f6BeiMYpHSvezrW85g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7708


On 4/2/2024 4:00 PM, Kalra, Ashish wrote:
>
> On 4/2/2024 3:21 PM, Borislav Petkov wrote:
>> On Tue, Apr 02, 2024 at 02:33:44PM -0500, Kalra, Ashish wrote:
>>> And we can't do this in snp_rmptable_init() as e820_table_firmware 
>>> can't be
>>> fixed at that point and by that time this table has been mapped into 
>>> sysfs
>>> (/sys/firmware) which is used by kexec -c variant.
>> Well, you have to do something here because if snp_rmptable_init()
>> late-disables SNP, your RMP table fixups are moot and invalid.
>>
>> Which means, your RMP table fixups need to happen at the *very* *late*
>> step after we know that SNP is enabled and won't get disabled anymore.
>>
>> I.e., in snp_rmptable_init().
>
> The main issue with doing that in snp_rmptable_init() is that there is 
> no e820 API interfaces available to update the e820_table_kexec and 
> e820_table_firmware and e820_table_firmware has already been exposed 
> to sysfs.
>
> The e820 API only exports e820__range_update() which *only* fixes 
> e820_table.
>
> The important point to note here is that in most cases BIOS would have 
> reserved RMP table start and end aligned to 2M boundary and setup the 
> e820 table which the BIOS passes to the kernel as such, so even if the 
> kernel does not enable SNP or disables SNP later, these reservations 
> will remain aligned as such. So what we are doing here in-kernel 
> fixups is doing the same alignment fixups which the BIOS would have 
> done. The summary here is that e820 table adjustments for RMP table 
> done either by BIOS and/or kernel will exist/remain even if SNP is not 
> enabled by the kernel.
>
Again, to reiterate here, RMP table memory is reserved by BIOS 
regardless of the kernel enabling SNP (and also passed on the e820 map 
to ensure that kernel does not map anything in that memory), so any 
adjustments/fixups on top of that reserved memory should not matter, 
after all we don't free this reserved RMP table memory if kernel does 
not enable SNP.

Thanks, Ashish


