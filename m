Return-Path: <linux-kernel+bounces-162355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D886F8B59C3
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 15:22:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 087971C230BC
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 13:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B891D6A00B;
	Mon, 29 Apr 2024 13:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5HNj3QEr"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2073.outbound.protection.outlook.com [40.107.223.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5169554FAB;
	Mon, 29 Apr 2024 13:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714396972; cv=fail; b=sCjfAgffNvpJCz1qVGoqiV7L06Sc+2D03rc2b3RiDzE3n9gXuWdYQt0nSoe0prswQ620wLFVPuwAK4hIcrVm2PLSdxm2PKecmRuDiHvoS6FDMb28zyZzA9sU5lwqqam/xcJPOLzorRiW8ipxVnow5Ji2gXYhNnFPuI299BAVZbY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714396972; c=relaxed/simple;
	bh=0ZI8pezh0v+E6A1IpL58viovfnr7H0UUUT7Knksib5Y=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=szulVcvMaMU7tYWzHfSAkFIbQUJ8tUTnfef7sdzUS/vq5131hwz01NgOgTaDVV4RUQnWSAe0+JKOz1VTwLhLIX09QGlmHGSNzEEw2pKXCKYOS0SwWmdKNhqV6L+vGQajAgysnMLssk/hpt9xWVCouRBuv0sGDjLnwI9mvEYCjwM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5HNj3QEr; arc=fail smtp.client-ip=40.107.223.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T6Ya1PjcPpOcNsKkEH/fd64WwRFvg6VqSJH86uVnGfyKHXKp8brphHLSDrlcRlPr6cb4s8vbohVPBZsLZy2ydGY8s5F3iW8kOL8VRkcdxsHku0a2I4T1TX3kSgf6Xvq0/OFGz8aoHmbUMfwWLzmsf5h/+16zQbO+4GkwF/vnQ12PYVKrf1qV4Ufjxg+s7CIkQpklywhgpg90xLi1GuRlX15vnSPA37MxiYo52auysuKtdofsleNk3o0idj8ogDBHHMlfpDreDT1bcaDCfGgiXZhaFDTYvb4r7TgRaJ685YOi7K6mXhWvKTTuy3Fqw1557nIQgkALpDnwGhCrCUx2iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=on9rTpisaMYtAv5PxsLvO48aBR0lqxWc1badxz8B860=;
 b=MndwAiV8tDXxHtEX0KFzce7EEM1SVwt2FqqelbU+sYNdLtcE7lxoHmX1tj/MQqi2MjEARc5xBOsXgVEuSFxZHtKCTJY+Zv+b7HD0+G6ZONwPYVeYVNnIf/9SJVL4Opoy8TI8KB2BQ9zZfxVT5FOfSdeququsDp7BrNjFbDrwvmyYuIMe4OMQW10B29rIlJvLDpeTN89vYEzscBkQleQ/kwlUwSbnMvsKp5u5GY5ATEBGz3tWXQXQhmDVOta1Od+OO+8a0xa3WrBYeILY8NibMYLgdF629F2oS1OXWdSr5b9V45adAKi5cO0119KLtSnbU5gymi+gMj/q3AtoKuUlCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=on9rTpisaMYtAv5PxsLvO48aBR0lqxWc1badxz8B860=;
 b=5HNj3QErx1EnwKdVu5kQg0FolXjSzsoD4uTNlLFNG44yyvIKCPU99V8E/5tIw6xERnpehpd0Dj5uoOzl8NCWQuJtuOFhpvVruQpuNDhU7ZnWD5kPPcIxly05FnFAjLxDYVaPM7abrYdH38a1ImI1kYjgKUcYbY2PNsode0/pjpc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by PH7PR12MB7843.namprd12.prod.outlook.com (2603:10b6:510:27e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35; Mon, 29 Apr
 2024 13:22:46 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::43a5:ed10:64c2:aba3]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::43a5:ed10:64c2:aba3%7]) with mapi id 15.20.7519.035; Mon, 29 Apr 2024
 13:22:46 +0000
Message-ID: <f2acc860-f227-4ca4-af74-8aeebb84c163@amd.com>
Date: Mon, 29 Apr 2024 09:22:45 -0400
User-Agent: Mozilla Thunderbird
Cc: yazen.ghannam@amd.com, linux-edac@vger.kernel.org,
 linux-kernel@vger.kernel.org, tony.luck@intel.com, x86@kernel.org,
 Avadhut.Naik@amd.com, John.Allen@amd.com
Subject: Re: [PATCH v2 06/16] x86/mce/amd: Prep DFR handler before enabling
 banks
To: Borislav Petkov <bp@alien8.de>
References: <20240404151359.47970-1-yazen.ghannam@amd.com>
 <20240404151359.47970-7-yazen.ghannam@amd.com>
 <20240424183429.GGZilQtVJtGhOPm1ES@fat_crate.local>
 <190ec43d-bd44-42a4-a395-f278f97748fb@amd.com>
 <20240429123818.GCZi-UugM5_UFHm7es@fat_crate.local>
Content-Language: en-US
From: Yazen Ghannam <yazen.ghannam@amd.com>
In-Reply-To: <20240429123818.GCZi-UugM5_UFHm7es@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN0PR02CA0044.namprd02.prod.outlook.com
 (2603:10b6:408:e5::19) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3108:EE_|PH7PR12MB7843:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fb4957e-3f0d-4407-f7c2-08dc684f7599
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RzJnYWV6SkloMjhzM09xTmtrdG5RV01uM2JRSlFFcldwK0VaZTdxcU9qeUg1?=
 =?utf-8?B?S3U4WGtYeU5tMEFpeDRUYXB2ZXlsemJUbDg4QTJhQWlUZUhKckxhK29qY2J5?=
 =?utf-8?B?SUFFanFoSlp6WjEreXdpOFJSMTlxYzNpNUpZT1NSYXpTeGRHZS9KclgyL2JF?=
 =?utf-8?B?UkxZSUJFMW1SbG4wd3ZxRytJUDRka0dNTFZ6S01iR1lMdVBWMUFWWEcxbnlM?=
 =?utf-8?B?aUpuQWlvS0lYVUh5ZWU4bElKNXcxWDRhMnlLOVNqb0xNK0wwN1Y4U3daUEhh?=
 =?utf-8?B?Y3FoTFJ1TEV3SGhhRDh4cVQzZ3RlS3NoSnd2dVhnWkZxeml5VTJ3S2ZLbnlM?=
 =?utf-8?B?TzA1K2lkK04ydzdGUUJIOG1TYnhacXRnL0JGMHVUVzVMd3VQWEtKaWVkY1BD?=
 =?utf-8?B?L3h3T1JoeFZhNEVvN0xNNzN2L0xFUmlSK3lRc3JXM2RrNW5ES05CS0xmMHZP?=
 =?utf-8?B?OXBVZUVDZUc3VzlXbTV5TnVjWXRtVlk1dkYwNGRGR1ROUEJtK3pHb25SaFpa?=
 =?utf-8?B?bDczOEMzVmRoeC9EMnRMcDc4NUFuV0FJUjA4aWYySjROVXVHajRpdE9BaDU3?=
 =?utf-8?B?dzVEK08xNDVUK0pGUUNBTmlnc2R2L1hNcEpYVEd6TVJCZzJsY0FxTjBlTm82?=
 =?utf-8?B?djBabmpjaVVYTE80eVR6QjN2N2VwSEw0UUlZRGF4eSttNUYyYmZTUVVNOVpl?=
 =?utf-8?B?VG04VDFpQjZucXF0bXVqZmhMZDVTZmNDbXA5L0NFNDEyZzlaZmxuZ1VuMXdn?=
 =?utf-8?B?RnlHMitOZHF0RVNMZVFJaGVIWkl0bXNqbXVHWk0zcCtTWm0wYS9aK1ZxV3lm?=
 =?utf-8?B?YmZIblk1RklLcXAwWDdKSnRudjVrU1V1M2pPa1hzZHBWWTVxZGRtTDFmWklE?=
 =?utf-8?B?Z3pYa0ZaV3ZVUW1MQzk5VSs5SnZMcnlTOEQwSEFqQjQ3VDRKQ0Z0M0l4TUd3?=
 =?utf-8?B?Y1NsNlczR0xuaUZ5ZkJnaUZZKzBYb1BIS01TelVoVVpuUTU0OHJYQ3JpdmVn?=
 =?utf-8?B?bUZyUkJNYzgzZ3lXRUFyd3pic0V0VHdidm10YTBnazlITThVYzcyaFN0U3h5?=
 =?utf-8?B?UktCMUJmanZuS2dXejZCZkt2MmYrMlJvR3U4UEQ2dTFGeHhKNk4vTDhIRE11?=
 =?utf-8?B?c1Fkemw1Y1huek5QZWNrcWIxRElscC8wV1hzWTJjcFo2NGxXdmZOanlISVRJ?=
 =?utf-8?B?WGJ3R2c0Y2FmSUhYa0xEVkxkUUorRmJjdFd2VG5mZlZyK1Z5ekxKS2lZOGV5?=
 =?utf-8?B?NmtPK0lrVVdFUTdQQkx6a2d2Q3lITWgveWFBMzVnQzU2NStjSkQxalZmS21v?=
 =?utf-8?B?NW8zRjBmaGxKRWZMbGZnV3J3MUlDZ3A0aWdMd0p4czdaZXpCWWJ1NWhuYWNO?=
 =?utf-8?B?QmNId0xwZVIzQzNiZFFKSkh1Vktya2ZvWVRzUXU3RU1PdWE3azQrZ1VNSUpB?=
 =?utf-8?B?bkwzZFpmOW9paDU3ZlR1VVZ5UkxtVDk0T08xMXNlUTAxSDhiU2hOUk9DLzhn?=
 =?utf-8?B?N0hEUGdQa0srWlhrbUlpdnIyNnlPK0NoRlZkd3Z5aWFYZ1FMR255WnVCUFpC?=
 =?utf-8?B?VERYT0xnc0JVM1Z0SzRBTG1hWGFSS3dMMnVTcVJQTXZGVzlUY08zWm9nNWtG?=
 =?utf-8?B?M1g0OFZoeG1FZlQySEE4MXNmdHB2d2h3SmlGNUVITEc2akRYenlTUU0vMGlR?=
 =?utf-8?B?aDRtMit4R2sydGJUNktoQkRYTEw5Ry9ocng1S3FNakJkWW90a3U2bW13PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RUFWTDZzaWZpMWUrM05FZjJoOGJoaWlpZW9CK0tqNWR6WUlrUTRPQW5nS2JP?=
 =?utf-8?B?SGNyUXZQdms2ZjJKVjBISllaWVFBNTJ2NGxuTm5Jd0hZNVJhcXF3NmtuUHhk?=
 =?utf-8?B?RlZJR2pBeEliUUI5d0Qya1djUnp3bGZpU24wL3l2OEJqNmhZRC9vb3FSVlVJ?=
 =?utf-8?B?Q29xSkZkRURqRWRadS9Jc09BcmJ2dE8rRHRpVEgvR2I2OENsRFB4dU9ER2hB?=
 =?utf-8?B?N3dxUW83RU92dFRldHh4Rm1lRGNZSTlKcmZQekcySUFRQlk1YW4zZmdLV2ox?=
 =?utf-8?B?T2Y0dkwrNzJoQU4zS0ZQOHVLOUFPUVpBWWl4MXFmM0RCaWdBb2JVTExvZ1Fz?=
 =?utf-8?B?cTB4WkFFd3BQUVUzVThtd1hmUkQvWjJia3oyUktEWjVGd3NvYTVWRFJ6S0dL?=
 =?utf-8?B?QlBtVlV6ek5oTVhkc2M0TWlnMEIzWHVQampMSmtBUUZscWZ1OEoxVEExZ2g2?=
 =?utf-8?B?L3plYjU3VVNrZVFIcHN2eHpPYVVmRktGbU5FcmoraEwyZGJZS1pqaWs2SkJH?=
 =?utf-8?B?SlRib0VTMGNWSmNwTGQ2ai91eWtGTjVOQ1E5V1Uva2hPNEZsV251SkQrRVJp?=
 =?utf-8?B?TllsNkcxN1lDQytiUnRjTVBUSWw3QTNRTWRxRTdBbkZVNzV2K1hhL0czTUh5?=
 =?utf-8?B?clRjNW1pQUdzVUNIRjdOWmpuR1Y1MmNIZkQwdHRHbkFmYUZYWGMxVXFUT0R5?=
 =?utf-8?B?bEorT2MvZWNOVUsyUVBzVlBUVkZPT2w4T1phdXJURitRMjdHaFVwdlQ1dEZO?=
 =?utf-8?B?L05PWm5NOERBU0NnQW9rN3pSQlJOcHhOQm5oTVUvZFNuci9DaHhoM3RvOExw?=
 =?utf-8?B?bWpCUGV2eTQ0aWxyQlI2Wnpmbmd2R21XeXFTcU1lRFBwRHVsUFU5bnBVU2Va?=
 =?utf-8?B?Yi9weG45UDh6N3l0M2RSbmErTGRaeitaNWJUanh6L0xKWkduR0wrRWF1YW9U?=
 =?utf-8?B?WTVxZENXMHNQRlV3K2UyQ2hjLzliTUFST05KKzNPZmJCbVRyd3FtZjBJdmhr?=
 =?utf-8?B?WTF4U09JMWNvckRydDM5RzhCVzZ6M3UzV2dYblUveWFxZ1B3SkxiVlV3Qm5z?=
 =?utf-8?B?d3MxdGxBRmZIMGp3WDFpOFVjYkZvUStrYXRjekJmZ0NsM2o5NDJlNlFhMHdz?=
 =?utf-8?B?Vmd1WnExUmtvV2M1TEpuZ1lIUUlSZ0tkSVozRVF5TjVzZzJidUdOS01odC8y?=
 =?utf-8?B?dlVSSEFmb3lMNE5ubk5MZlNEQTM3MlpFWWw3ZHMrcWdyNGthT3N2ZG9CUUFP?=
 =?utf-8?B?QWFuNmUvdkxpQUFQKzNaZS90UTBKL3UrczdWSFRnM2xENnRLVjJSaUVrSUV5?=
 =?utf-8?B?MzJCNUZvYWlsdm1aRlNLbXcvVEsrTmhtNXVkN2djWHVaWHY2K2R4MjdldHBt?=
 =?utf-8?B?VHl2NThWSlBBRDB2RXZzc1FZbUw3THNUdmRYK29XT0dpMGRuenJNejY2bWtk?=
 =?utf-8?B?b0pxZjFUWjljQWlFbDE3elBiM3grQkZmL3BHODJqaVcxS1RRVkFsa2NDSXly?=
 =?utf-8?B?Mll3YkVzUlN2bHRyWGJjbHJTeHFTeGhDcXJJV29Ca1FDSnF3eGU3d3pjS3lB?=
 =?utf-8?B?blBWVUl4a0tqOGJJNE14YWtFblZuckFIQnZMdlBiUFhZU3NDVWRyUi9YWXhN?=
 =?utf-8?B?ZGg0aC83SGZEQjVaenE4eERZODlTTFYxR053TzMxRW16QXFjNlpqaW1vUTRF?=
 =?utf-8?B?RHhucnd2SVdRdVNrcnR3dmxQenp0azQrRUhsajdxdmwzdmdUeUxhOEkxei9j?=
 =?utf-8?B?TDN5bW81WVBEL2dWa2ZEb1hHd1phblcreElMTXdGNjFidytTb3BOQUVKcDZq?=
 =?utf-8?B?ZjhLVTRrSEV1NmhXeTZwZ0F6TzJMY0FHNEFjSUVWTk5MZTdIWjlqNkNKYUlS?=
 =?utf-8?B?Ri9wTG9lUXpYT0EwNlBseW1oNVc4ZWVaTzZMRzJVWFEybWR6ZkVRdmovbnRp?=
 =?utf-8?B?Qm5vRmhIbGRDSWpoMzl5UGo2V2FUUWNDM2VFbWhjeUZ1WU5LWmJSajhCOWVu?=
 =?utf-8?B?clRFWGZhek4rUVpKSUlyUWt0dFBudml4QmJFZ001dm84QjFyNWFqT3BCYU01?=
 =?utf-8?B?TmhqdDU1UTB0RVBZVlVCcEthc1JuTGUzNzRRdlhRaVhDVHNaSmlYUWcrbklH?=
 =?utf-8?Q?PLFC7tflXvaGtmk2E/x00sQSX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fb4957e-3f0d-4407-f7c2-08dc684f7599
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 13:22:46.6560
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GJVPGlXF+X1RqAUwI4PXM9+0y0nlHSqvVOe1fjTvROfIF7elyMQfjRUsIAriSILvAlfv6FSUlpDLGsFjy7DXqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7843

On 4/29/2024 8:38 AM, Borislav Petkov wrote:
> On Thu, Apr 25, 2024 at 09:31:58AM -0400, Yazen Ghannam wrote:
>> They are independent features. SUCCOR is the feature that defines the deferred
>> error interrupt and data poisoning. This predates SMCA. SUCCOR was introduced
>> in the later Family 15h systems.
> 
> ... and as we've established, it is not really enabled on them for
> whatever reason so for simplicity's sake, we'll simply assume that it
> was enabled together with SMCA and that would simplify a lot of things
> in the code.
> 
> Please put that in the commit message so that we know.
> 
> Thx.
> 

Okay, will do.

Thanks,
Yazen

