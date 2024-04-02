Return-Path: <linux-kernel+bounces-128729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BCAE3895EB7
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 23:31:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD80F1C23C5E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 21:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B86515E5D4;
	Tue,  2 Apr 2024 21:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SLm+5mzK"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2099.outbound.protection.outlook.com [40.107.94.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 725D515AAA7;
	Tue,  2 Apr 2024 21:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712093500; cv=fail; b=Oz1RAERjm+hRP04kju5Xw0tPUJJK0pnfOsRGW+tx7A75wRchHe2VKyKuNNgbWDC6oLR8OsZWfesyKHqURIcGjBVlY/Ca3PVnG/xgqypO/Ha3dX36G3ajGAQVab0GQQ893wpBr2bj6UKpCWe1jq6V1kMdTk/tAIFmfvfFtat7u7M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712093500; c=relaxed/simple;
	bh=weuvomLptSR5xHzQymgs4gX9xFhgjZD/rD02nS/6sXs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fpqK8xJAAQJxfYWI/kB+JhuSZdeuUGtou1VayepPYUsp4RZHrdSinEyumdlS8rLO5U3ZLxmDtBVM8zNpc8dmlVPw34DQ/AhrjW6O05F5LVxgloRebts6ctEGnkUpwAag6lEY+GiXOwwPjk579xeCL/+jg55WCIEiq6C/vc/JAmw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SLm+5mzK; arc=fail smtp.client-ip=40.107.94.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aLY6HaYApaiieR7i3A3k7goG16hVIlYCChg/D67FtTSgyMBN+/yHc58DjS6U7CFeWXcxA8hnMLwraSu22gK+4lvi/K9eabVcIKmStZKB1JvU+ExQfHBsT35IDqYhhoxGeVuS7exSegCyelkv5pA8loHMrO2vLIDGTDbEpuQXpp/+8WFh6OcLFmqxLsUpfPZVDVhMAvI4DMXoP8wkvDfSndIt098PGWk3ZbfeLsbmvbWRex5Cam84P6jtwhPEl/z7fE0k5gBGjeFTiT2vPbp3irUR2p7ozIhVmsJyQLu+lH9vEIOzkO3/IKh8kDMuQ7hamQsdizqFJBXxuSDJMPCM7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XOGh6KoMhpgPpxwDHVOpU3xE2UKd072Wk6ZCopuAgRw=;
 b=RineuNOSzKYybYMitKVESp379mALnqEtq9o14DkMJTQShqFi+hBhg7Mm6/UTknBDloGoOvUIN7L6+4l9zOe0QM0GRQ1qC/SsHIe+D+f71c/dX9FMs1pXgkvssoNnamhYl7pr/YM98Uu7FkTWH5mFSOoHcuI/SX/zKMS/+VbQF8NfgUxoGjscVpmk0+iG4yq6dfQ02U1LpsPKj8nZhiBIeDzXhWTm+D2+7nSFguU+Jz/Ljn45hnKa4HBZlTwl7nPYdKzNHtXG5c+2nSshwUrVWpD7JOSEmWVQr0Oy9JEkavgG1d28dtFuLQvGcMXZaOvRidNe+uLe7E0OPRvdekREDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XOGh6KoMhpgPpxwDHVOpU3xE2UKd072Wk6ZCopuAgRw=;
 b=SLm+5mzKhl1l1xmt2VHOSNaIEDnqZL/0PS6uUf/eG7Mvg1KOzoNi5N1fRoyu4h6c5LnAGsGwoPQIEcEpRye/qp22ujcdObyZXiIm9f0gDyWTKGC8FcLknQ2rLCm6/WzGzjq2IPqrsgECtc6fIVJMo+MUcKSn2ZFMiPpolQb77sI=
Received: from SN6PR12MB2767.namprd12.prod.outlook.com (2603:10b6:805:75::23)
 by BY5PR12MB4211.namprd12.prod.outlook.com (2603:10b6:a03:20f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 21:31:33 +0000
Received: from SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::3cc5:f552:44ae:1f26]) by SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::3cc5:f552:44ae:1f26%7]) with mapi id 15.20.7409.042; Tue, 2 Apr 2024
 21:31:33 +0000
Message-ID: <f1802e68-88b2-43f9-8344-d2a513e206a1@amd.com>
Date: Tue, 2 Apr 2024 16:31:30 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/sev: Apply RMP table fixups for kexec.
Content-Language: en-US
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
 <20240402212009.GEZgx2iZC_Plx-ajKW@fat_crate.local>
From: "Kalra, Ashish" <ashish.kalra@amd.com>
In-Reply-To: <20240402212009.GEZgx2iZC_Plx-ajKW@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DS7PR03CA0033.namprd03.prod.outlook.com
 (2603:10b6:5:3b5::8) To SN6PR12MB2767.namprd12.prod.outlook.com
 (2603:10b6:805:75::23)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR12MB2767:EE_|BY5PR12MB4211:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	IhaHj1LFogOMPyy+3Oj0E3Xv4mj9AeqjMH/yZSwrLO6f2s7lPjv8aqNicuMLzQ/6ArtOtQR8cW9SjPrurPKWuThoZU+a+/5hdMeb7rRC61RfQPS7pjQrwF7BTfeNJvn80qVOIznuDRgi9mrEkm1Sx5x6U6WusT+0inCLbQZ7WcWfDNGIDrfIgbDW0NER45XO17vPJ/w0kITfWBRe8MCA46756sWUrkd4Pr7NFNwLvIy9Yqi/C8fFQXoGjy42JmQ3HYGv+z+k3dBkumDmvhFBKtSP5l23S8Q3f8cnKmv36i+f0csO/hifL9zGjjPq0ay9DAyxuXw91FHJuPxjG28Ia5itPexJzJoIB95Ej+vGvb9itzhbvN4P9tnVo9R1oYUBDlee6ZtGDCDjYJBzZOHxjx7lbGhu9JO4JmX0lJOL2yX3UkIo5RSII7Rmyhs/cZ50VV2HElWbMTe7z7ISw/NVxIpTieQQX/XfI3XI0TjW840K1Cmj+IOihzxLJ/HtnmJZ/p2EvZKz/iNTbW7yvU9t4ft7Pi+h7sA1L/VasXfsh8j/ivMBmuFUSI0gmaTVGhW7hCvpfcEsD+CO9oZKMxHfUK9g2MDewW5lfjev2fwJUB8MZwhT5VqQ1NYrcPAZ5cSbwxB42DrbJhgNed/gqa2fOtT1Q2d4bxwPBH1KimyZb2s=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2767.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?emxpVkpEL0thZHJlVERYRXB2aGZGVXQxRmIwc1ByYUorS1kyNlp4aEs0WGxX?=
 =?utf-8?B?eHM1cE1EVDQwMExuSTZIOEdXalovM2VQM21wTXpMR1dUTEp4dDc0QlRiOVNK?=
 =?utf-8?B?YTNFOTBvWE5FaGt4MGxCSFJ2THBRUFRIMG80OUI3dHVPUSticnpxbitsS3Bj?=
 =?utf-8?B?dTVnMFd5aUg4MGVGUmcrRlRqbHM5NndYN29yOWV1RjZpdHIwN2RMR3FCODE2?=
 =?utf-8?B?N0JoYnN1M2k5NkcwTjRNUmxPTWV5OWZsNEVxT1dxUnV3a1kraDF0a3NiVUF2?=
 =?utf-8?B?WXFHcDZsWE5xdFR0ZEk2YjI2NHpQa2l4c3c3L2c4MThTYi9sRVA0cUVzVEE0?=
 =?utf-8?B?ZENvRkdoakN2OUZFeENBVVlBT3ZaYVBjZzVZbGREM1RKdW9FZElNZVB5S1Vk?=
 =?utf-8?B?QlVuRXBlaEFEUDlWZklaeVJ5LzBDUVV6clBNZHA5MllaSmFqcmJmeTcrSExE?=
 =?utf-8?B?Y2M4WVByWmN0aEFHZEgrT0h4Ym5odUZLTnJRVlFCc2dacXZmWlgzRko3YWdE?=
 =?utf-8?B?UkF0eVp3VEFGMEtCZFN0MWx5WE9RMW5LNTdtb2N4cjJXTWY5ek1RaHZiRWNx?=
 =?utf-8?B?MjBHUWtJVlFUYjZXL1RUWWZTU2FGUEFvSjdQNi9ucDJXWGZKYWdTYmo2bTJt?=
 =?utf-8?B?VWVGK21rdEtNS2g0MWluaGxKbHpGWHNSbUMwSzlJR0ZEaUxHSEtURzdEUklq?=
 =?utf-8?B?MHp0VjlaVjNZRTNPY3RqSXlNOS9Bc3E3UW5MQWhRUG9VTkVra25xN2FRWnhI?=
 =?utf-8?B?dG9KT3dDWitLOG1aa3NOcDRpcUVZQzNoeVNTekFicGJZL1lhTUthdG1ybVFB?=
 =?utf-8?B?SGtsS2g5M3JGU3BBNHNDWjg4bndDbzdFcXNqRHVKd3MzemV1N0VBL3NYRTJr?=
 =?utf-8?B?b0pnbU1hYk9sMnhRRDByODE0U3ZDdUFyT3RCUzBmVnQyazRLVkJBMEJuU0hE?=
 =?utf-8?B?eCt3eEplUGZ3SzI2Q1cwd09yV2NvaTQ0NVc0TklMQXU4OTFzem1hcGk2aXFL?=
 =?utf-8?B?MlNUWWZkSy9aeGI5ZjU3TzNyRnM1bHJhdk15aVYzQWQ0RmNsK25qRlRISUli?=
 =?utf-8?B?RkRDYW52OFBHdHdtWkM3c0FVNzE1cnFLV3pqeUMrazF6OEtqODZJV0ZrTkhH?=
 =?utf-8?B?aFhTS2lBV2s5UVJBTW5pTENKVlNqMFFvNTB0R0pHcVhYYk1pRXVROTVDZmhp?=
 =?utf-8?B?QmVlcEFPdG9WRm14ZDNmeVAvcTdiaXdFS3FESDdaaGhBa1BvTGk5dW84S01v?=
 =?utf-8?B?RzArTm9sR2FMbTVxVklsMFdlbkhUK0pVS1BsNG1hQ3Y4ZFIwY0Rab2RXeUsw?=
 =?utf-8?B?Z3o5bW45V1pPbjMyTnl2dlNsR2RhZ2l5VXV0UW0wcW5nRHRkVnJZdmkwUDBu?=
 =?utf-8?B?MWhkKy9KaERnYnUwbUJsVkR0VEdHNmxuUW9CZ0RLUm5MVnBvWFR1di96Z3I4?=
 =?utf-8?B?a1p4Vy9NcnJNUXF4MmRzb09Ma0E5dk9MZnBubVFlQVNtYmFGWkNVck91eDhk?=
 =?utf-8?B?ZTdDTUJqRUo1NUhxWXVVZnNQSGJSOVVLTUF2YkVKcW5mbU5iRzU5ZWk5aS8x?=
 =?utf-8?B?a0Y1d0t4SkdPSkJxcmZiOHh4d0YxRng5cWlyQWNOTy9BUnJ0bFRJNmhsd3By?=
 =?utf-8?B?THBMMnc5YjYvbXBlVDBSTVNBTzdwK1A5N01IV1A2ZUhla1NCVEYrWXpDRGVN?=
 =?utf-8?B?ZHB0emI1ZzJxMUkxYzMwU1BlaFh3WHR6eTVEV1VHR1Z0c3F6YUtsKzR5KzVn?=
 =?utf-8?B?UXdEcVBycXZGL29MTVY2bWJBaTc5MG54QXFtSGV4TG9RMm5DLzRjNlZidzR6?=
 =?utf-8?B?RmdvVUN5dVdDbGIyMS9RKzQ2YnBpcngzSFlxMHRFRDQ2SWhoQXd4elE2TDMx?=
 =?utf-8?B?WWJyTUd6ZjQ5NkJtVnJTd0JrblJCbytiUnFrZEcrbVUzUWxZd1hTTVBVYUpL?=
 =?utf-8?B?a0NNWVJCUXhmU2hrVEhZaDB6c2szMXZTNjNTSjN5TXRlL1N2V3dld0hDV3Er?=
 =?utf-8?B?Z1lKWjJmYTFsOXp4MExuTEdVcUQxS0ZidDNNQWNPbW5acWFweEtId3ZoMzcx?=
 =?utf-8?B?QjhkaUNaOVBkc0NBV21KZW1sZCtDUHUyTVJtV21FWkIrS0c0NzN6OHduQkhk?=
 =?utf-8?Q?nuckCo3/ZdSBmbajo4k6oEVIF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3291ec9-758d-4ee5-ca4b-08dc535c4458
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2767.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 21:31:32.9808
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zQkEiIzWTNoZTUmUIkoQPQeBpM+b5Drb5omr2ejmzR2UVzIq69MWjWYBFYSPhyT6CNWwvpwW92JJ8iHffwd11Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4211


On 4/2/2024 4:20 PM, Borislav Petkov wrote:
> On Tue, Apr 02, 2024 at 04:00:03PM -0500, Kalra, Ashish wrote:
>> The main issue with doing that in snp_rmptable_init() is that there is no
>> e820 API interfaces available to update the e820_table_kexec and
>> e820_table_firmware and e820_table_firmware has already been exposed to
>> sysfs.
> And?
>
> You can't change it later? Tried?
The main issue is there is no API interface available to do that, i will 
need to add new API interfaces to update the e820_table_kexec and 
e820_table_firmware and then will that be acceptable for a use case 
which can be handled via a platform specific quirk ?
>> The e820 API only exports e820__range_update() which *only* fixes
>> e820_table.
>>
>> The important point to note here is that in most cases BIOS would have
>> reserved RMP table start and end aligned to 2M boundary and setup the e820
>> table which the BIOS passes to the kernel as such,
> So what was this "RMP table start and end physical range may not be
> aligned to 2MB" in your commit message?
> /me is completely confused now.
>
> Or does "most cases" mean that there can be cases where the RMP table
> placement in the BIOS is not 2M aligned and then the kexec kernel could
> try to allocate from within that chunk and there's RMP faults?

Yes exactly, that's what the above comment means.

  That's why the above commit message says "may".

>
> And you want to allocate those chunks up to the 2M boundary
> unconditionally, regardless of SNP enablement?

My point is that we always keep the RMP table memory reserved regardless 
of SNP enablement, so these are simply fixups/adjustments on top of that 
reservation.

Thanks, Ashish

> Now look at your original commit message and tell me how much of what
> came out on this thread, was in it?
>
> Not a lot, I'd say...
>

