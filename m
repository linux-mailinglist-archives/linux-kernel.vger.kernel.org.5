Return-Path: <linux-kernel+bounces-162433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78A948B5B1B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 16:19:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78CE7B24BDA
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 14:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4456B7BAED;
	Mon, 29 Apr 2024 14:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="AQfCQC0y"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2075.outbound.protection.outlook.com [40.107.243.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D0F7867D;
	Mon, 29 Apr 2024 14:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714400351; cv=fail; b=V7hvQzCKEpK3j7sHI5SaGYeXwCR9OjWRxEN2qMQ8JUBXh1X6YE56umoUBy6eogPEdJ7w7gm3bS09cPbHIq8Kl2r94oFi3ct5D1kzRN90TrdjConEKbuFlxP/557XzM7pt5ydVzYxQRbH/d15bHh2HB8lJ/nksYyvC6Q8dwi1xpQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714400351; c=relaxed/simple;
	bh=/2Euq0N0v3PVxYzVkLO6El2S6rbZtV8eKA+2qdjaoL8=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZZix5quCl3YxQo0jKK0vzAeG7jk7rI0VqBY8EtKYugeyxH8xpNsA2CUegFJhilXTVMS9m0sA2sDUthcpAh1rBCqNm2+gFRNAKxLBPlAf0gKvhLBTZpoWu8ZtfFKds4uZ/E2HzfXo7m3BehwKt5g4KecEoiKmYHPNXbRyMV5tmec=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=AQfCQC0y; arc=fail smtp.client-ip=40.107.243.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S/7CQMoLExYzwqQYtJFQ8c0SX68fWefYIQBXP996S2sQB3y4cT7jRnOZC/L0TntBEZEsbe9zCR4yiDPSMvOp3vD7+5d90B/oFH4O1ro0PGNWAEvbl2IBOi/3VbSLizFxVk20GGZFVI7WdQrBhOj9zDXTZ9rYW6uHLY60jbnKRzKljVwH3BbC/LxuH+7gF9HclGxGY/EfBUWPRfmyNZHn99pLTj30Nmy3EIsEkJ6anZuy8rtd2VF4TU6VbUinvbSbhmnt7ToDnF06uI2RKfriLm+3Iv8j3ZGiz15Pzka98NOdDSpXEz68PmwCOj8c2TEBpX5UOZimXwhN865R0G4/Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S3hg2BMvRucF0LStk7g/dEy/qW0ow5k+332vnJB6mQA=;
 b=nsi/jDKCipcbVC8uf9OhPQnUiSxTuuVS6FLZ/y5xJs57cIU/BnMjf/RdFKPHUfpGxaFJ4pGsVStkva9wnwbK0PCaz+7ytc+5PPkGsgxpU7cKwzeeiOXWxm5U1kQ6Yft41ztjURhQvaYPVnmdF7ri7ZU+591p76cJdeCX0LL260OX2t3pEXF5WsY6YEtUDSXIE9XFF7oOfVCj0lt3KUh7RFuIu0lRu/LhKmdph8KPTYjQrNxlfXANHZ4x2V9RRBANsPiBdJVlIoENhLTvKs7M7Na7baVppSUkVeAUeVciErQpB4D8WZvvsurgonHlpyHCMb5uw4pD7t8BCvNM6HFQpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S3hg2BMvRucF0LStk7g/dEy/qW0ow5k+332vnJB6mQA=;
 b=AQfCQC0yZhWYGuhkJ8z2YLA2ZMXTaZYP1B/ro4HbLzwQWRg5RursYdxqz2JAHP7IMJm75creb+3hwm+h3+UFNVQnfdVkJQxY7HICDtJaDDLxj0ysw5JDMzOfiiY7gs8EEO68431cRzDJR/M2aobjBLw14fXCCIK/srUJsNXpaho=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by CH3PR12MB9281.namprd12.prod.outlook.com (2603:10b6:610:1c8::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35; Mon, 29 Apr
 2024 14:19:07 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::43a5:ed10:64c2:aba3]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::43a5:ed10:64c2:aba3%7]) with mapi id 15.20.7519.035; Mon, 29 Apr 2024
 14:19:01 +0000
Message-ID: <d527fccc-6c32-43bc-bfad-477e6f07e33c@amd.com>
Date: Mon, 29 Apr 2024 10:18:59 -0400
User-Agent: Mozilla Thunderbird
Cc: yazen.ghannam@amd.com, linux-edac@vger.kernel.org,
 linux-kernel@vger.kernel.org, tony.luck@intel.com, x86@kernel.org,
 Avadhut.Naik@amd.com, John.Allen@amd.com
Subject: Re: [PATCH v2 08/16] x86/mce/amd: Clean up
 enable_deferred_error_interrupt()
Content-Language: en-US
To: Borislav Petkov <bp@alien8.de>
References: <20240404151359.47970-1-yazen.ghannam@amd.com>
 <20240404151359.47970-9-yazen.ghannam@amd.com>
 <20240429131240.GOZi-cyLh2OhRrNTWM@fat_crate.local>
From: Yazen Ghannam <yazen.ghannam@amd.com>
In-Reply-To: <20240429131240.GOZi-cyLh2OhRrNTWM@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR20CA0042.namprd20.prod.outlook.com
 (2603:10b6:208:235::11) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3108:EE_|CH3PR12MB9281:EE_
X-MS-Office365-Filtering-Correlation-Id: 9fbcfac5-9d42-4569-8104-08dc685750eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T3MzY1ZraTdWanY4SUtDTmlVWHhOLzd3SDhjZld0aW5zVE5sT01JL3I0ZGRs?=
 =?utf-8?B?SkJrYzlHZGRQb2oxVXVUSU5OWFkvcXBoZWRyOWRSZW55TWJwZ083TFgzUGNx?=
 =?utf-8?B?dTJPb0Z5aWJBZlFjTjM2YjRLbkhJMUp5ajNqcmtwekJsUG1ZQm13MnNGQ3Vh?=
 =?utf-8?B?c1pQNG4xUHl6UVB4SFJhaWVWRmpzNkl0NjI5T1RCS1l1VGxXUE8vcGlzZ1Nx?=
 =?utf-8?B?TlV4QW9NNkZBbi9GTUFENmd1d2VRV2JyQmJsWU1NSGVueXFLeFVqTi9pOUJK?=
 =?utf-8?B?MDdXQ2J5MVkybkFubk0yd0tZYkRRTEZYK3BZeGdwbVowcTZSeXozVGxHT2o1?=
 =?utf-8?B?WThhcjVmTDBXSTNkYnQ3c1lHQm5zT3pTNmZBS29HNUU2Z3JOMDZnVWkrMGJk?=
 =?utf-8?B?L3JQc1JJN3JkdU9IbTBNTjFWTDBVeVlVS3JYbFVwMWhqZWx4Q1dNVmgvdC9r?=
 =?utf-8?B?TFp6Vk9GSVJVR3hDd09yV2lMdE9wczE0emw3Zm5rQ1JWMXFNeGl1YW9ERjUw?=
 =?utf-8?B?ZFUxRnFSK3JwWmNzZmNiOXBHdmNyOVJqenA3OFIrRVpGOEFsWVAzSFNteGJh?=
 =?utf-8?B?TXlqOTVHL0ZaemttQ2NpeldkcnRra3Zjby82RzFhTTF1aFJRT3VKdFRwRnhO?=
 =?utf-8?B?dXBhbks0VFMrdUVuU0owMjdJaGNLUE04eG1IREY3Qy92UCtadDZNT0d6cjdz?=
 =?utf-8?B?QWo5aHhWcXZsYVNsN3M5Q3dESXZiazZPMDR3Y0RCM2Faak5jZmtteU9TbnZN?=
 =?utf-8?B?a2tYaG5DYUwrd01xTTg3VWVGUVRtN2lCbExEUTNMTFUzUTF5NzVtNEpDa2dN?=
 =?utf-8?B?elN4cnloTjRjTkFTMTVmSDJCazBOZGk3T0VaSFE1aDREbmxUVzF5QUQ5ck5x?=
 =?utf-8?B?VXliZ1pna3JHRkVlZkI5dmk1M3B4SzFQeDNDQnhBZXFZa21QTjdrVndaWEl3?=
 =?utf-8?B?Q3p6SjZpRVJKbHFQQ2Y1VE9uQzM3NFluQVY2RzhrV2t5c2lQb3RhbzM5U1Z6?=
 =?utf-8?B?eWdjL0xWeVhTQVJ3bVdiRjkwak5OTVg3Y0hpR0tMbi9Za05WcHh0WitlcHRT?=
 =?utf-8?B?ZjYzSzhwOUtYNUN6VWtNeWVmbEduV1lMczRublBVSm92YkdobzhOZU5oc1VQ?=
 =?utf-8?B?N2tValBsSnFBQVp5YUFoNVFKakp3ODI5QU94cy9aT0g2L1RRekRIdENxRUNI?=
 =?utf-8?B?cFppVDdXZFVjcU1pWDRPYVBzcDliN2dTMGd1a2ZnZzlXdTFjWWNHRWRaM25q?=
 =?utf-8?B?T01DWkNBMVhwN3FpYU96eVhCU05lZURnK0RDbytMZXdXWEs4K1NmZ2FvbU5v?=
 =?utf-8?B?M0JJOWRJMldzTmJrbUJQbjhaemtLM1hiV1dlTzdtTWxnYnViUmZsUTkvN1ZU?=
 =?utf-8?B?eCs2OFMvUnpBWG9uaGdZSTIyOHZ3NGRJT29vaytQR2tCYllGUlVhdHlCbTBl?=
 =?utf-8?B?VE12bkxTOU5QTittNjM0V0wvTVVka1J0ajBkcjlzQk1RSWtwTExtY3d0aHJt?=
 =?utf-8?B?WHZXTlQ0MnpFZFc0UFhkejMyR2NVVWxiUXFENDlYY0ZsRTNuOGZqQndmZk5v?=
 =?utf-8?B?dU1IL0JoeTQvM3ZuWVBhWmVwZS8yZ3RIc0pRbmd6NVhFelBCdVFXZi9IbEdo?=
 =?utf-8?B?SmRqemQ0WEdCMnMyemwyeEFmUVgrellLemE4U2hrMytDQnlrNFZZdkdrWFVn?=
 =?utf-8?B?bElmSUNhWUR0R2tIc3doY2ZEcXdkenJjLy9VZkpxcTNIbGRkWXI5UFhnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d25rWFY5RTFJNHlUWStkQ2RDbmdiVWE1b3ZkdVVRL0dFTERQYXB1OXVwMk5L?=
 =?utf-8?B?bVFPbVFyRkVKWWUvbS84ZTg3NGRIeThDSkxrRWJhS3lYMFNsZlF3UGE4d2dk?=
 =?utf-8?B?eDdsMm0ybUN0R3ZqUEJIc1Z0RzRKNWpRdlZQRldNd1NlMWMxRklPcDVxdVpJ?=
 =?utf-8?B?Umdtc3FZbWxheGZpU0dRTzJNSHdhdEJ5OGl5d3dIQ2taam50VVM3VURCVGxS?=
 =?utf-8?B?SnpEVXNnTXRvenZDMXBZTWtQekJYUkx3dnlPRC9mZG1EUUVzYW03MUJnZDVO?=
 =?utf-8?B?eFJZUjFjQVU4Yk56YW5jV3dKczVNTk4zYUJDOUdmaEtDciszQzVZb09vN2E4?=
 =?utf-8?B?eHZGRll5MEltRmg2Zk9GaGV3ajc3TVpDd29VMGJZazMxeUNWUXpNUjNJQkp0?=
 =?utf-8?B?eTJhaUszb0VtZ213djluTFB3VU5iaG1MQXNYdi9FUGQ5dHdVakErWVp3U1JM?=
 =?utf-8?B?WEVRUW1UamtUNWgyeXJCdVVUclQ1ZWM0NzQySzBQMytiajNsZmt3UkUreUJ6?=
 =?utf-8?B?MHBLNEtmWTE0bmxsQjBpdVVLWGR3Y3JXeWdveStBSUkyNVFNZkxCMG4zaWJM?=
 =?utf-8?B?VFcwZWk2S3JkczJHY2w5b3BBK3NzS2hJMEl3VkVDSmM3S2ZlS3N4MSs4bjBX?=
 =?utf-8?B?NUhBeEtMcEFtK2lsR0Rjb1phVDRKdlgrS0N1ZHhxa3FkU29aeHp4U0tjTWJO?=
 =?utf-8?B?cGMycjZNQ29MWTJTV1FSL3crVjloNWo0cHVqN1M0d2pVa0FSSGFIejQ0SGhE?=
 =?utf-8?B?WlY2cFBkemNLaWh5c25NYzZyYkRDNUNlbVhLanBYdGxqYWJqVGh2MDNwbEZy?=
 =?utf-8?B?YUhjM1p6TEVab2QzMUozY2IrbTdZbFIyaUZSNXdWc2wzYisxYmIrMWhuMmI2?=
 =?utf-8?B?Z0drdEdCMG04a09mM1QrWmt5VHZsdy9LU3QxaE52MTdOUHdweDU0TGVDSy9F?=
 =?utf-8?B?Qms2TmlKTUd3eGFXM1VlN1U5MUNEVmdxcEN5VjlZMVBQL05uWUE4YzRFenUv?=
 =?utf-8?B?MVUwcHpucFY4VC9vc2pNTWtqNVR4d2ZMb3J2elNGRFlqeFpzMXlXVkQ1K1Zn?=
 =?utf-8?B?LzQ0MTV0cWRoZ1ltZG41R2p5MlMxUmdZK2VhUzhvNFpEenlJblE5MkNuaXYy?=
 =?utf-8?B?WEhQbGQvMytZQkVpQ2Vsb21DSGt4Qk0rTkFmcXkyWVhPakhVWnMwMGNDa0hQ?=
 =?utf-8?B?SnNGMnRzWUtKUUl5V3p2MG5jL1N5V1QvZ1graDkrQkZaOGx2ekZjQ0sxdWVo?=
 =?utf-8?B?UER4dG9qeGlxMFE4VnduWHAraXlrMlAwVmxHZWFUQUdnZ1JaU2RSK1dFRnMz?=
 =?utf-8?B?RGlFUzdWcVFCUVpzaFBIUWlpaTBjb2ZlQSszZVlmK2hsS3JVZzlYdEdDY0ln?=
 =?utf-8?B?YzJURDd6OGlWcmtHMXM1Z3UyRnNJd055ZVEyTjI2d0xDRlhCV0RnSVhvazNE?=
 =?utf-8?B?MHFveVVtQXpMSmFlT2NYUUU4bi9XRHJxR3lBaVMwWE16eTNZMWtCRGxuR3Rj?=
 =?utf-8?B?aXkwcnRZUWpqMjhTWC9Vdk5OOTB0Q1BOM3UzTjJvSEk5OEpiWXVsRlFmdG5o?=
 =?utf-8?B?UytCTmpBMG5BczVSbjJlcFVQa1Nid2t6dGJOVTRLY2F5cVZ3TDJIejBkNHpt?=
 =?utf-8?B?a0YwZmkyT1RMemtLSG1NWm1mbWdoQ3A2RFREMFd3bDJzTnI0OHdUQ3pUTkJB?=
 =?utf-8?B?QTVEaFVoZHE3NWdMaVMxNm9ZWUJVR2Q0VkEyalJ6a3NsbGxPNTJOdGxPR0Fn?=
 =?utf-8?B?cDRWRm5NV3pVVzkwZ1Axak1mV3MxOFlUVEV3cG5NY2NGSU0rb1c0RTRFY3JH?=
 =?utf-8?B?Zk85WjZ3YWd2cGIvL1NEaFJQanNJb0pQYndjR25iZnhqT3d1anJVbWkyRExX?=
 =?utf-8?B?MnVpVnJnVG05MFhacFBHcTlGUWhFQmUwVFZyS01JcSt1Q241S0pWR1JUT2ZO?=
 =?utf-8?B?YkFSbHJIS3NadUxFYm9heFN0Nm5iNG4weHVGaW44Y2tVaC9IVUthOW03Rm9B?=
 =?utf-8?B?WjhUOW9oOSsrL201SlQ3Z2o1bkZ1cmJkekY2Z3dHbjVuZ1dzRWVNMStZL2p5?=
 =?utf-8?B?dnh5N3J0Sm9Jd1Bic01seTJKdURYVEFqTVNkUU1YVy9wNXJ5RDgzWkVaZ0hh?=
 =?utf-8?Q?GpJr1fvHynz8zk98u0NxXvyAJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fbcfac5-9d42-4569-8104-08dc685750eb
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 14:19:00.9558
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rg/72g9onWfkc7bpKDhCJIcRsl01sJ1wEHr9kGGSHqdMyRosCDyTZnbvuxkIR2MjMabQVeNoZgK1uRj8/y2Riw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9281

On 4/29/2024 9:12 AM, Borislav Petkov wrote:
> On Thu, Apr 04, 2024 at 10:13:51AM -0500, Yazen Ghannam wrote:
>> -/* Deferred error settings */
>> +/* MCA Interrupt Configuration register, one per CPU */
> 
> SMCA?
> 
>>  #define MSR_CU_DEF_ERR		0xC0000410
>> -#define MASK_DEF_LVTOFF		0x000000F0
>> -#define MASK_DEF_INT_TYPE	0x00000006
>> -#define DEF_INT_TYPE_APIC	0x2
>> +#define MSR_MCA_INTR_CFG		0xC0000410
> 
> You do see those other MSRs' prefixes, right?
> 
> MSR_AMD64_SMCA_...
> 
> Is this one not part of the SMCA arch?
> 

No, it is part of SUCCOR. The old define is above: MSR_CU_DEF_ERR.

This is how it is listed in the PPR:
MSRC000_0410 [MCA Interrupt Configuration] (Core::X86::Msr::McaIntrCfg)

>> +#define INTR_CFG_DFR_LVT_OFFSET		GENMASK_ULL(7, 4)
>> +#define INTR_CFG_LEGACY_DFR_INTR_TYPE	GENMASK_ULL(2, 1)
>>  #define INTR_TYPE_APIC			0x1
> 
> Ditto for its bit(s) names.
>

Okay.

>> +static u64 get_mca_intr_cfg(void)
>> +{
>> +	u64 mca_intr_cfg;
>> +
>> +	if (!mce_flags.succor)
>> +		return 0;
>> +
>> +	if (rdmsrl_safe(MSR_MCA_INTR_CFG, &mca_intr_cfg))
>> +		return 0;
>> +
>> +	return mca_intr_cfg;
>> +}
> 
> This is an overkill. If we add a function for every MSR we're reading...
> 
> Do this differently: prepare the value you're writing back into the
> INTR_CFG MSR once, save it into mca_intr_cfg and then write it on each
> core at the end of enable_deferred_error_interrupt().
> 
> And make u64 mca_intr_cfg static global to amd.c so that you can refer
> to it from outside of the functions and then you don't have to pass it
> around as a function param.
> 
> Thx.
> 

Good idea. In fact, we can treat this register as read-only, since we will
only handle (SUCCOR && SMCA) systems. The only need to write this register
would be on !SMCA systems.

We need to assume that the register value will be identical for all CPUs. This
is the expectation, but I'll add a comment to highlight this.

Also, we don't need the entire register. We just need the LVT offset fields
which are 4 bits each.

Thanks,
Yazen

