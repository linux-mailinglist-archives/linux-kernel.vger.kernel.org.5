Return-Path: <linux-kernel+bounces-166679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CB378B9E0C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 18:02:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F2D8287A4D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 16:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E5AE15CD71;
	Thu,  2 May 2024 16:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0wYk4h4R"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2055.outbound.protection.outlook.com [40.107.244.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 413CB15B97B;
	Thu,  2 May 2024 16:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714665731; cv=fail; b=aXMSyThoW4Gf463rEKY6Abl8TnVkJqgZUXVihmOoJHQMR/Eo+KJPtv5FCdroK5YhX3zCujGfdp7FoSt815A1dg2sQAOYCteJdqkb4/rZ6guivaLiWDe1jSEPq/KtsXBzKNbf4s6vy8YuC4bWafl8rojWWCbjWZmwZNya0zpePN8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714665731; c=relaxed/simple;
	bh=AvSDYBYENt3bFstN4f6bFvaQQTFXQj4DKaKcrh6icYo=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LExHYBwKvKANNk66dUBh3aywtUEoy7NGDettbbRQckMfl7fIyzidBEZVuuItxrLf0GtpBccjBa1aJVH7FvV974EzYJQ2ktgGcYJg/CaiTRBihEpIKaHIcZWz9koV2cv95OHzaR1Mm+XzG86v7vhByrOOzkcqv9Zi2IdxCpsoQnU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0wYk4h4R; arc=fail smtp.client-ip=40.107.244.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GN4V5sPmWmJq17kLjW0U3uBuE8sFohHaF2LmdH9tBhREolsTIqJHj75aPT91apzgJagzlFPELjeM4WrtEjY8qjxn5OIAkBwMQF7la19ExAcN3lM/AXONbZauzHu4CR3U5wYl287V0JGhpTslwuDeiyoKYGZic29GlDMJOUiXD/ipn6ARToVHcnvEpSEPVbnF5TGD09X34gU6qU9cyfusG33T4BYwPkpFPy/4Pwn7/m1QiCaNKiA2S2D4X569smrYVvrXBbtANeUm+XKeDcbtGPJ6P0KJOJ1/i4ms68PchAzLW8CuXQX/M5c2Z2+BtsjPbtZQkgd03u3bZH7L0kM2aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z0xLccvihuOyFkN+qJHLAS9VxMIjXeSjYz3XK4ddGhM=;
 b=FEUG90Mkwkl9Gx1X3WGjpE0jyJo5xNj3WiTkIxK4ro1O3Y/h/SpviI/0ziIXH64CDelUCqVBKjPP5Y0KU2o59Z0PwjPDvq+hdV1q1L/0AItJDRt4hUPcZsmDfuwa9f5T/LPDup6bqPQhJe8EO+OIDj7dKpXGKqAfEXT4Arl+bCiv9g6VGGSPuaKE7RFwe4n6yPW4QnZSlRrDQJ/KZpB+x3sfyPkkKTA9c/4xNZFMtDFiKspN8qTpb4rToqks9cJCPjSD0gaQxOlu/Xm37sdgokCm8BG8U6xCD/73Y9TwcWPO0QzT7f1J2OLOihH4mQPHZIfuDLiW60jGlkw1iD8ABQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z0xLccvihuOyFkN+qJHLAS9VxMIjXeSjYz3XK4ddGhM=;
 b=0wYk4h4RQkdO4yVRtYEejXnh85+kHeDQe2wJTh926LsubRLALdFPdcvDDWqUH5+VLW3OAUgQy8lQvbO1MpSmzglY5X7g/yvOtnwnp+kL8ZzGo6vu7dbWENVrfNWggJHnOh1m9igFBji6K9MCvuH4VbJ4OFW+6cGy0U1lJdmgGsU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by BY5PR12MB4225.namprd12.prod.outlook.com (2603:10b6:a03:211::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.29; Thu, 2 May
 2024 16:02:03 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::43a5:ed10:64c2:aba3]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::43a5:ed10:64c2:aba3%7]) with mapi id 15.20.7519.035; Thu, 2 May 2024
 16:02:03 +0000
Message-ID: <a5f623ba-6df1-42f1-a709-aafa59b004ba@amd.com>
Date: Thu, 2 May 2024 12:02:02 -0400
User-Agent: Mozilla Thunderbird
Cc: yazen.ghannam@amd.com, linux-edac@vger.kernel.org,
 linux-kernel@vger.kernel.org, tony.luck@intel.com, x86@kernel.org,
 Avadhut.Naik@amd.com, John.Allen@amd.com
Subject: Re: [PATCH v2 07/16] x86/mce/amd: Simplify DFR handler setup
To: Borislav Petkov <bp@alien8.de>, Robert Richter <rrichter@amd.com>
References: <20240404151359.47970-1-yazen.ghannam@amd.com>
 <20240404151359.47970-8-yazen.ghannam@amd.com>
 <20240424190658.GHZilYUvw1KfSfVd_e@fat_crate.local>
 <e0d10606-4472-4cde-b55d-34180efad42b@amd.com>
 <Zi_oPUzvCDhRVSk4@rric.localdomain>
 <20240430180635.GDZjEzK8H3xQ_uEGYn@fat_crate.local>
Content-Language: en-US
From: Yazen Ghannam <yazen.ghannam@amd.com>
In-Reply-To: <20240430180635.GDZjEzK8H3xQ_uEGYn@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0629.namprd03.prod.outlook.com
 (2603:10b6:408:106::34) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3108:EE_|BY5PR12MB4225:EE_
X-MS-Office365-Filtering-Correlation-Id: a1bb3bb2-8f78-4811-3388-08dc6ac1351f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dS9tbkw1VG5hVjRQWXVRamdHTjcrUjQ3Tld3WUs1dDAxQkJlaUdxN0l4RlNS?=
 =?utf-8?B?U3BaVm5QUXV4R1lIbEptUEJhTkxyc1ZXRmZIOGw2WHVkaWdEallESmkyYUd5?=
 =?utf-8?B?U2JxcXV5YmJuQlNnTzJjQ0xJYU90QkJKNkd1RDVaTi81RWVuU3VKa3Q0aGpF?=
 =?utf-8?B?VmlyY2RkQktyQ2ZVVjU5U2xobmxqMnhETVBmbFgra2JXakhMbVk0SnZ1clhY?=
 =?utf-8?B?ek00OTMwZ2N3b3VIU1lPQWtGVTN1RzVXbENGMmQ5dnFKQkZnSkVKZnpYYkpr?=
 =?utf-8?B?dm9KYkhBZGltcnBCdFk4SFE4aWQveTVhcEVhNGlpUysvVkEwUHFoL1Q5NFd4?=
 =?utf-8?B?ZFhiVjV0WTJ0ZTh4N2FDenJvcjRsOGFTS2pGMmxlT0VqL2w0UmNpNWlxZ0k3?=
 =?utf-8?B?NkRkYmZIbUlXTVpWV1hxdGZuSEhwWUVVR01UdWVEcHArZTd6dTd1aFJTSU41?=
 =?utf-8?B?c283ZXNxa291OXFIM2d0M1JMMWhWWlhQUVJXeTR0QnFYaTJPbTFxUGhWWEVh?=
 =?utf-8?B?LzhHR0doMGV5dk1iVkN4Z3VscWtIVmxJK25jaW5Uc0Evd3dza3Jwb3UvRFU3?=
 =?utf-8?B?QTBWekpza3NCNjc0RnlzSWF3dTEyUmdJSS9jNVBIRkVxa2EzYWpnclRIQ0pW?=
 =?utf-8?B?bGFrTEdhSlhFQzI3Ly80TlJLQ2p1azNCVm0vWGZValdnYkw4WFVWZ2JKaVF3?=
 =?utf-8?B?N2hSd20vWjFVT0lnT0hNZC94dlZxTGdTM2dHQ0oxQ3o1NEZON2pIekdVeVVu?=
 =?utf-8?B?dGRTN1lNU0hQaWgyWUoyWHZoRy84K2NoR2hSWU5CSGlhbU41dGZCRFBXQzJw?=
 =?utf-8?B?SGhiVmVydjZvR05vYnZnSHE4WkVpL3JNYktCRkRxbEkvNkxuZlhYdEVXWW40?=
 =?utf-8?B?UCs0dlZyZ3Q2MU9KTTlaWkZNb0Zmck14ZEE2Z2dCMjBEMW1GcVlEdW9rbTht?=
 =?utf-8?B?ZjNMekRuRENnRzdad1psUDZhK3phVE0wU2ptSGVWblo5NlNldHdUeWU3T2ww?=
 =?utf-8?B?VGd4T2xyRHZWamJvTXlhWGU5WFp6cit2YnMwTnozT2g3U1NIN0VVV1JhbVlU?=
 =?utf-8?B?K3ZRSFVZUFVTSnRFRjgydGtRV3lES05HWXd2Vmp3Z0xFTk9FRThRMlh4cDFJ?=
 =?utf-8?B?cml1Wk5GOC9Qb0lwczNmS0NVTG52MHJzUUlSazl5VUVWeFlTNGdtOEV4cWtr?=
 =?utf-8?B?Uk0xR0hKZzg4WEdqVEZFdkZnWHlnV3BiM041ZEFkWVhwNnFaZUtaN2dFSk5u?=
 =?utf-8?B?ckRwZDczTXpQZHIyNGRMOFJCOFNZZHlWeW13Tk1iUXFIVk9BOFRXZlc4QWtB?=
 =?utf-8?B?NjR0aTU4Q1pwTGMyZlFTYjREQzZDd2I0Z09EVzRuNmFWK1prL0Y3Zjk3SlN3?=
 =?utf-8?B?dk5uZko3RlVDZ05mU2JBUEgzS1BmVEh4Q2g0UmJCV2gzYzEyYWxRRzBFdGVv?=
 =?utf-8?B?aURIdEozR2dsUHpjdTcycS9pU29VTkREd2laVzVSOTNhODFjZ3hXb0hmTlNT?=
 =?utf-8?B?c0FzNHd0T1hTSjhpYXk3MUtPbmduSUltc204UnkxVTZ5b1pTQ1FjYmdQSlpS?=
 =?utf-8?B?bFVsQUc4T2NOeE5qOGlMY2Q2R2dGUlYwRzRSTytvU2paYVh6eDltdCtLQjRY?=
 =?utf-8?B?RWJBQ0M2aEg5dk9SRGEza3BXbThxMmk2Tlk0NnpOSUR0TDEwZWhHcnRKZHpq?=
 =?utf-8?B?UG14d1hYUjZYdkxyT3RkaVNYT3EyMHVMdS85QWRWVnRUajdSWDNTYjV3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Qld0NlhTZGUxUmFEQ0NNLzZiSzYrNThQUkQ1aXVjUXhSVThuODVjSkpVTnlN?=
 =?utf-8?B?TmJJd3plSU1WWVJBN05BYTRaamFTUnJHU2xyUlQycUZpRGRxUys1K2VMTm9u?=
 =?utf-8?B?d25aQTZPZkRmSW9pbSt3Sm5hbm1tcml0VUpYVHVzVmVEQmEyc0FTeWlMK0ZX?=
 =?utf-8?B?b3kzNm9YcTFic3NDcGhaTnZzS3A0ZURUdEdQY2tiOTFxQmxudktUdXRaRSsv?=
 =?utf-8?B?eHI1Mml5RytTVjhHK00yV1ZaOUhocUZjQmVYUUtVamU5cEV0Y01LTnZxYTRr?=
 =?utf-8?B?VlZEN0xiYjFDbFBTelhKNGNmOXZKWmFQaU5hL3IyVFB0TFFoRFBVcUFReEJ0?=
 =?utf-8?B?bkhkRW5oTzlCZ05rd1lsRHpUTnV6K1hkdWlOYjN4SjQvZS9oNzZFN1ZhcGhQ?=
 =?utf-8?B?OTRPNis4aUMvUnVKZFU3c2dYc2trNHUzdlIrKzdFSXBZUy9qMmFhYkw5TUxu?=
 =?utf-8?B?d1VNSlVZeGJaQ2xXbDJrV3hvV2k1c1BrOTVWQS8wZEJZZi9rYkY1SXRoM2xa?=
 =?utf-8?B?b25qZWY5UDFtMkRkcjdMVWVwcEVYYURwQWJSSTlFQ2JVOHV5L01YdTJCaWlD?=
 =?utf-8?B?ZEhMRjZpYUtLbTBHUFBaOTFDcHB2SUdHV1RNMFFvSU95d1Y2NHhxTUxhSmVB?=
 =?utf-8?B?YXdWN1hncmI2TGJCcTJSNHEyMWRQQkEyN2xnNzBGQjk3YWtvVTJCdDNieS9O?=
 =?utf-8?B?RThTOW45SkNjTUZoRmtudzRBUnloMjRwVlRxby9uekdVNDcxbHJNeHdVZ3lP?=
 =?utf-8?B?bUtCOUQzb2QxNGFYbW5NMktzWXkzb0VCMk01YUN6Z0VmL0o4amcxeXQzaTU2?=
 =?utf-8?B?bmdPSlM0eFdVR3pTR2FIRVFHWWNudERlUm1uWlhmZmFhbDQ3dVYxZEZidytr?=
 =?utf-8?B?cE1TWFNIbDFwdFVlSlFSakVwMW1sTytoM0N2WW4wU1hrVHoxVnl6S3JUSzBv?=
 =?utf-8?B?eXBGMUZzN0FTVjJCcml6MnJXMXJTblpRTnBodlJiNFlVa1U3c3ZzVVErVDZy?=
 =?utf-8?B?UlVJR0luV2lDZ0hsV2doY0RYODh5djZSL2ZIMnIyZzE2R2F5eG5GSUJDZi96?=
 =?utf-8?B?YlFtcXBEeGVsSEhzRVJWTngyT3QzRm5lSENjeVFIelJRaHZNZXVRN2NOQXRN?=
 =?utf-8?B?Q016TzRLMHdPbjlrU0tDTGI0Rm4vR1pyWWFwTjVIa2VQNHNDa01pQzFlcUty?=
 =?utf-8?B?OHIrNUVJYUZVUHRSQ3E1SHBXTnhBSXZQNkFpMERQRHZFTi9TQ3FRb0c2azEy?=
 =?utf-8?B?RFk4ZnBqL3ltNGNldDFRM2x3emQzOVVmNXVFYUp0SWdhVFNKZmsvWXJlaHBM?=
 =?utf-8?B?MDYzbEhuMVhiaEx5Y1JrbFpQZ0tMOW1HWUJranlIaGIvLzJybCt3K3JEcTBX?=
 =?utf-8?B?bWh2MDlKY2xPbWVHcDZtMVFSbDdkWUhCQi9jOWp4d1VPdkhlRU9lUXFkZEky?=
 =?utf-8?B?SWxJVUpLcXp4MnBheXFGUndMdTFZZDJlMmZRZDQvL1V4RnFMaGZ1V2pMWlNu?=
 =?utf-8?B?QUs4ZTJoVzkxS1h1eTAvUnIvYktCaThQMUtWU3VHZVRXazNRQmkrR3FCU2hU?=
 =?utf-8?B?Y0hrMFlQVGFOWWcvV01UMHJ3b2RhekRYZjhnQksvSzhJb21Db2M5WFNzYnJ0?=
 =?utf-8?B?eEd2Z2ExVW1WTFp3R2dRVGtYanpzbEpIR1R1YnlReFB5SDJKVnNHdlFXSCsz?=
 =?utf-8?B?NTQ0ZzBLc2xjWCtvbUJhTnp3WFJkNmMyNWFNM3FDdGtpb085cXU0NTFkZ0xQ?=
 =?utf-8?B?QXFGU0hKOU1iRG9vVGh0Q2Z2bGIwTkZBYTd3T2RBNXdxZHI0UlJoVFkvMzZM?=
 =?utf-8?B?YWJIV0NTUnpIcEkwVjBTYzlWWVNleEpsZmpqV3QrbmdmRThLUmFRd0k3OHVY?=
 =?utf-8?B?S1NFMFBpVlY2clpDTU9saDl3L3pYM2VYblUzUFE5MDZEOExXRmp0YlJuQWRi?=
 =?utf-8?B?WnhtRGJlRnZvV3JhRDBMREhNR2J3VW9rcEtHdkI1MEVvbmlMWXlFSlhMcEZ5?=
 =?utf-8?B?RndTWkNQWUtyTHlnajdkM3BJVm55TkFFT3JZRnlaR0t0YUlIZndFY2hJd1Vq?=
 =?utf-8?B?ckRkVjRiRGhMb3I0Z1pHOXJ2V2FMRGl5MW9nK01Cb2lwbTMrMUU4Q1FJVGl2?=
 =?utf-8?Q?l+OVeyAs+ClhRC/MHdyzVR2Ol?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1bb3bb2-8f78-4811-3388-08dc6ac1351f
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2024 16:02:03.3355
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TsPhe5VHtbdtcDmGbFCDT/6q0+VKmTOimbN1hTacHSKCzSCSA3SoPEMG/Joh6tjwAp7WqGInZUwOkOphhGgPCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4225

On 4/30/24 2:06 PM, Borislav Petkov wrote:
> On Mon, Apr 29, 2024 at 08:34:37PM +0200, Robert Richter wrote:
>> After looking a while into it I think the issue was the following:
>>
>> IBS offset was not enabled by firmware, but MCE already was (due to
>> earlier setup). And mce was (maybe) not on all cpus and only one cpu
>> per socket enabled. The IBS vector should be enabled on all cpus. Now
>> firmware allocated offset 1 for mce (instead of offset 0 as for
>> k8). This caused the hardcoded value (offset 1 for IBS) to be already
>> taken. Also, hardcoded values couldn't be used at all as this would
>> have not been worked on k8 (for mce). Another issue was to find the
>> next free offset as you couldn't examine just the current cpu. So even
>> if the offset on the current was available, another cpu might have
>> that offset already in use. Yet another problem was that programmed
>> offsets for mce and ibs overlapped each other and the kernel had to
>> reassign them (the ibs offset).
>>
>> I hope a remember correctly here with all details.
> 
> I think you're remembering it correct because after I read this, a very
> very old and dormant brain cell did light up in my head and said, oh
> yeah, that definitely rings a bell!
> 
> :-P
> 
> Yazen, this is the type of mess I was talking about.
>

Yep, I see what you mean. Definitely a pain :/

So is this the only known issue? And was it encountered in production
systems? Were/are people using IBS on K8 (Family Fh) systems? I know
that perf got support at this time, but do people still use it?

Just as an example, this project has Family 10h as the earliest supported.
https://github.com/jlgreathouse/AMD_IBS_Toolkit

My thinking is that we can simplify the code if there are no practical
issues. And we can address any reported issues as they come.

If you think that's okay, then I can continue with this particular clean
up. If not, then at least we have some more context here.

I'm sure there will be more topics like this when redoing the MCA init path.

:)

Thanks,
Yazen

