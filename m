Return-Path: <linux-kernel+bounces-119178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E4CFE88C527
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 15:29:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 295ABB22339
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 14:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F9C712D77C;
	Tue, 26 Mar 2024 14:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="VcjbZ25S"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2109.outbound.protection.outlook.com [40.107.102.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80ECB20DF7;
	Tue, 26 Mar 2024 14:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711463385; cv=fail; b=VGvcE95Jgk8eGUhrhrLXdfS/wDEu27/20qZkVTEFboycGhAcOIfUoxZZkJb1HO67tMY3JIYRwfzZPbDtiHeuuQ7h36ZdWdm170I8XEurJ0RqGPUaEUA8I9Y1ZVM1mvvWEcDM8AOx7u+UdypYqtuP19B/9uZv5n1wJe85kDB4IAE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711463385; c=relaxed/simple;
	bh=QhisoWHuRFA+gtpEhupxQLHBLqMECHZAMtMDTrJ+IbM=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Dwo8AGTEdi2G2RsOQ1f0PqBAd9a/CfxK50kmW0zPopzpiB3hMrwnJaMsRsdCI2kYcFYRkKuSHNQFDfSgXsq6xfWaYQvJEIe6uHysvwYlxds1idRG0vsWI1+Oe/ANMgrgAJImj5/ZaEcGTEusYzQ+aChHVv/6/2HpXsPkEefBcl8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=VcjbZ25S; arc=fail smtp.client-ip=40.107.102.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dCG6gQoZbRgqYPemUqqkg9invrYvW12nrTHB9Bgf2mIHkaOZlPopl9pRanBDhhhQrQJLidt62oR29zgSRSU2JxscNGdaRa28PARejCymIylYLrF0THmviJihWK8GBa9CybquTsIS5P9cshapsfCWMDfNyP1It1mQV/XmWXqD2f8EZEWcmRrzs9lj5heezWePVtjg/bCtiAmaUa219CieOs2932CDMQ5gVay/7ehr/MaGElbjG6Qm8xtMcNp0T4P5GXjttB2Vqz3yon4j9NyFAA+FlDzlhihPgVBTej59bQTSRZmjPb0won7xbshgBh1UoLP+a1BS3aOfoVXc2e6P5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XsdBXXFc3hKjCE3Vg659lXmkO5ulNsPkp42VvmkPXBc=;
 b=e5jAdU8/qp7g0iK82C4BjJKoqHYmU5jPYnDyy7mkdreBU/Ib2+QMJSn3LvHAOfOm73lsa7gA9NxnvaO7ai2c5UB7AcDE0UZ3fVBX1VVBBSjZkhpJXAmF/0+4V8XESVtLEQW9u2X/726Bx7s6jTzKikWo3go2oxiVFpsg39jY8HyQar3+/HmgX8hvkS4WU7rPkgncizd4L7pZx4cPDi3sGPN3Vsg06scKM5oF54OXXnbDyVuTBsns5oWCNO3GqeCkzDKDqTFHW2q1eJgfdhwjugrUUujp0aYE+uYHO8HQ/0vBsd1cQGIJxQD9c4Xzjn8fXGwm04C6/5QH5n7QpcR2eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XsdBXXFc3hKjCE3Vg659lXmkO5ulNsPkp42VvmkPXBc=;
 b=VcjbZ25SkkZreTDSp+/M2PaTqHJBYoLyw2NC4WqfULnz/8CeKpqyYajNA/JsxqrO8nYiEh9naxQHnoHu/vWD23sTNJG02RObH47jvYsfT3Uei/jl/QqNgz3Vgq/OHCLlJZ8tyJq7cPTPMnKFberMNGs3xDRZWgPj7bySpAkVsV4=
Received: from BYAPR12MB3109.namprd12.prod.outlook.com (2603:10b6:a03:db::17)
 by DM6PR12MB4354.namprd12.prod.outlook.com (2603:10b6:5:28f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Tue, 26 Mar
 2024 14:29:41 +0000
Received: from BYAPR12MB3109.namprd12.prod.outlook.com
 ([fe80::b2b4:a3f1:a86:d6bd]) by BYAPR12MB3109.namprd12.prod.outlook.com
 ([fe80::b2b4:a3f1:a86:d6bd%5]) with mapi id 15.20.7409.028; Tue, 26 Mar 2024
 14:29:41 +0000
Message-ID: <656a7134-4984-4577-93eb-60c0c28adf93@amd.com>
Date: Tue, 26 Mar 2024 10:29:36 -0400
User-Agent: Mozilla Thunderbird
Cc: yazen.ghannam@amd.com,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] RAS/AMD/FMPM: Fix build when debugfs is not enabled
Content-Language: en-US
To: A <akira.2020@protonmail.com>, "bp@alien8.de" <bp@alien8.de>,
 "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
References: <20240325183755.776-1-bp@alien8.de>
 <eede2586-f143-4107-a065-2860ed413d0a@amd.com>
 <i2PhAcMufioQc2nhVgO9T23CcF8UsgJo8CWPOl_7lV3iF00GdywfpQa2Hu-yPX3bD4o5wpfUtIsRBIhFH1j3k9aNoUJfgGALNWUUjMokpFc=@protonmail.com>
From: Yazen Ghannam <yazen.ghannam@amd.com>
In-Reply-To: <i2PhAcMufioQc2nhVgO9T23CcF8UsgJo8CWPOl_7lV3iF00GdywfpQa2Hu-yPX3bD4o5wpfUtIsRBIhFH1j3k9aNoUJfgGALNWUUjMokpFc=@protonmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR20CA0056.namprd20.prod.outlook.com
 (2603:10b6:208:235::25) To BYAPR12MB3109.namprd12.prod.outlook.com
 (2603:10b6:a03:db::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3109:EE_|DM6PR12MB4354:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	boltoXA+Pr/kIfzqrnl4a2h3uBt1R843cPCukaPiP81YYMkXF+ae/qSFEEdj+eWwdpsId5hISw4V8kW+gk63nKvdxDgvgqEaR+kSsSyrKrdWahmkHN8Z3jlwRYeHcQKJPye7QCVWqRdkw5SaViCC2i+0rnG3Ky8IV2QMa0zg1b2F97SWxKfxFJDp5XDrUSdYwP7hALXAJs97X4HP6GyM5ZVJvCIQhUwpi+BnkUg2GvCYSs3nYqGNlmpcPZN/1+Ij/S69QaGTXAF74qP8VHqrC/Jr12DLZU83rxwJPOwPthnR4JhqCXbs1plMD+ykk/UadVJd2xL/yc0uPXHrsafaI97R6aTuOzu/O1KOhf9jzWQB/0+mUOrjlmN0xc7Ovz1kdzxzmVVf3H/JetQHEdWB7MP6nW/bqobIRUIkwaMNPoBynIHthyJROzEUz6u1Xe7klRKmmRQ7BEjxsn4Gtx7sxCRpKSp0hiXlFYhNMQWjBOXpCSyhINuyyaq35bNZbVc0cmye/xQDFCp5+PMskXBjhU5koIwK78zvmtgU8dumLkda2w4AtjMbLSXuN4tsmLIDJzh0717Nxrmy9IVtWGQFO6tna/QiEkCEjuxM0kR6CLW3IPsRczW5HrD3oJUrjdXzVjxeOGGm5qYUqeMa+j2+1OaCntyu5H2ORj37IE3kAN0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3109.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZkcraVZaT0ZiWDMwdmc4K0xOS2krUDF3TXdKTUhtVGtMRFJVQVZsQ3FWc0k1?=
 =?utf-8?B?bnF0bXlUdXFFdFRnbjBteXFVTTQ4Tk43MStTbjAvT0psOTBZWGJRcGRzOUVl?=
 =?utf-8?B?dS9NZm5McExzcXBseksvVjRJbzAvMTZNaEZFeHNMb251OTc3aGFXR3MzOFR5?=
 =?utf-8?B?SytiZGYzbkpHVFFmOEZKSjRIUGtBVGFmWmVKYzFhempiOFZaMGo2K3c1VUpC?=
 =?utf-8?B?YWlJYmZMUUhwUHpjQjJ6QkFYSDA1YmtuS01RNVJ1cWYyT01zQWdRL0JiOUI5?=
 =?utf-8?B?Z1dqemtGSjgwbkw5a2xCK3Y2TWZmaU5qMUpyNW9saUVkcGQ0NUdTNDhqeGt6?=
 =?utf-8?B?Z09pbDVzTHBOeERmcXBCRkZnZ0w5YTRoZytiS0E2YXVJSHM0QnM3NEJxeDMr?=
 =?utf-8?B?L2hpc3VsZU9hMTc4a1RmVHgza1RwV05BQmtOYXNJWCtqK1RmeHdiN0JOMFpU?=
 =?utf-8?B?ejl6c1drRXA0SXhBd3lVWDA1VHJxZG1KUkRHS1pFZ1owV2x6VElKNWVHY0p4?=
 =?utf-8?B?UnFreml3YXZSTUdUcEYyQS83eVR5Y3VFN0VJeHVrZGN0cVNMVlg2TzYyU01U?=
 =?utf-8?B?WEc0UjBMd1RxZ2h0Q3o1cXI0NEFIeGxOWGl4VW1WM0F6YWQrd2d0N0dNVkEv?=
 =?utf-8?B?QWVQNHhzZmZCQ2FYeHZqUXU1czhCc1dsNDVVNHg4dU9uNlBTeUJRblNXdjEy?=
 =?utf-8?B?UTZZUlUwQ3FMVHV6ZnVVeHBQazhTVkpXNkE4Z3AwOU1NV2lKUnpYU2RTb2Jr?=
 =?utf-8?B?a0piaHdleUVPaU8zMER2K1Y5WXB1SXQ1YmQrc2pWUFpvM3JnRGRzMjJuY2dk?=
 =?utf-8?B?NU9yRWxYNS9SSlQwNmExOTVhMDhTT1NGbWJta0NIb2FNTkl1cEZCZDhGNEw5?=
 =?utf-8?B?UWI3RjBFc3VPK0pGYUU1ZkdKeGFOZnc5VjBmZFk1cU90MHVIWkNBV0RiUDBX?=
 =?utf-8?B?cnpzL0pMQ2p6NFI3cngwbE1vKzB6YnZtVHJUWjB0SzN6Y3RwcXJ4NHEybzBo?=
 =?utf-8?B?RkZEdWlxS0RQWWdGS0l4emN6ZXlIbDRoTWtZUXU0SDc2RDZrOExSK3d4Q2Vk?=
 =?utf-8?B?R3JOT3dGb3dIR21TQ2tkUGFPc2dCZ1k5NUk3eE9MOXFScEJWb2R1L2lYNUhU?=
 =?utf-8?B?ZTlGRGNacmVhM0thT1ovNTRnVDRwYU5ZK2FQV2w1Y2dCMTlZckcxYkJBK0FV?=
 =?utf-8?B?cXFMU3A1KzdBWks0WXhENWh0b3c5WXpFbFA4ZG44Y1pLYW9QU2U3U3B6Nkdi?=
 =?utf-8?B?U0tPNXZRZnZhNi84Q1dGL2lGd21ORlRXd3o0MzBOK2RwN3d0OFEvTjMzbkdL?=
 =?utf-8?B?WTZIeWRMalc0RVRzTFlUVXN6dXVpUjBMeFBwbDhrdnBmRjVHblNQdVFrRHJj?=
 =?utf-8?B?WFBpRWgyM2V6V3lJelp3eFNzTnVxREFKaHRpQlBsaDZQZGpzY011MXBMRStV?=
 =?utf-8?B?YjhWSnRIYU5NYllhZW1Nck9vTXBLRWg3a2dNQjNYRHRzN2NMc1doZXBIRmN2?=
 =?utf-8?B?R3NCM0RoZDlERjVnRFdwc1JGM2h5RFJCUkdmMnFKaDBmZEF6cEp4Z0U5L0g2?=
 =?utf-8?B?K2Fhc1hEa212NnlmNFh1V2lScWhsZFRVTGw2U00rd3Q1dDBsd1pFa2pGSTFW?=
 =?utf-8?B?dTd4azRNZHlaNXIvYVNob3FLa1Z4MGYvVURLdnVBQ2w4dUJMVnRxb3F0Qnkz?=
 =?utf-8?B?WFNEUVplWGxXUEx4OVpFV2piZEM5cGZGSWRaemVzK3hTTHNOTktJSENTZmZF?=
 =?utf-8?B?YjFwY3o3VWlhNU5Gb2dVbkZoamZNUXl3TlBDSktVOVptSW9WZlExYWI4bmFZ?=
 =?utf-8?B?VjlmWW1SbVNJWUxuU2pzZUlVZlFiOWY3UEpjdnVKVU1laEpUWlhjSzBZT3RS?=
 =?utf-8?B?WGxjckVaMzN2L21WVjdvVWZQcnAzSlFkTHNYTkxGYXJTdlhKWlFuV3JhR0pu?=
 =?utf-8?B?UWU3NjZYU3Y3bnFqbWdnYXhPSjVudTBwTjRkTU8xR2lwdThQOGhzOXB2dnJN?=
 =?utf-8?B?eG15WTB2aGYwNVE0TVgvUEZhUDVBcDQ0YTVzVGk3QTFzWGQ1UkRWL2tIYlNt?=
 =?utf-8?B?QkQ3SEdyRXF0VTRjbktDN3JUYWJjdkFVT0Y4bEZrSzdaVElmTkN4cEJLOFlZ?=
 =?utf-8?Q?xDJ7ZUvzSoeEODT6yKWiSrpl0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bdce994-2de2-4487-57c0-08dc4da12c56
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2024 14:29:41.0445
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eB2dlZpvrB6i2T6/lATzmg3wKoGd86EYphp9bMLgRd5p94q9+qcdLrxAILNDBebf7pj9d1KkJCepup3IKaxljg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4354

On 3/26/24 10:20, A wrote:
[...]
>>
>> diff --git a/drivers/ras/debugfs.h b/drivers/ras/debugfs.h
>> index 4749ccdeeba1..ab95831e7710 100644
>> --- a/drivers/ras/debugfs.h
>> +++ b/drivers/ras/debugfs.h
>> @@ -4,6 +4,10 @@
>>
>> #include <linux/debugfs.h>
>>
>>
>> +#if IS_ENABLED(DEBUG_FS)
>> struct dentry *ras_get_debugfs_root(void);
>> +#else
>> +static inline struct dentry ras_get_debugfs_root(void) { return NULL; }
>> +#endif / DEBUG_FS /
>>
>> #endif / RAS_DEBUGFS_H */
> 
> this also works, just tested
> 
> this time round, `make oldconfig` asks if i want to build RAS_FMPM, i built it as module, compilation succeeds.
> 

Thanks for testing!

Would you mind including your "Tested-by" tag? I can include this when I 
send a proper patch.

Thanks,
Yazen

