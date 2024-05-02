Return-Path: <linux-kernel+bounces-166718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DE768B9E85
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 18:25:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A50E91C22F7F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 16:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4294B15ECC2;
	Thu,  2 May 2024 16:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="c29O4V8v"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2046.outbound.protection.outlook.com [40.107.236.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E840D15E5B8;
	Thu,  2 May 2024 16:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714667117; cv=fail; b=gUMT/kZ1oVaabLFUdsS6TOLmEy36ZpXufGuGLpYkYTawbKCqTTgmvqdxJUtGVrd+DBSjYVfPX6oehnDKlRFrPqeGyMu1QFNAhgWsXzBUT473tw7PbaaXD+Gp8DN02Ql7dL+akGWDYLzltO2KNN1qH+bLGH4wB5EfzbbYtcnWfSA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714667117; c=relaxed/simple;
	bh=V2oGA3y1hMaeFtHcfr4fNSejnaUg6hIcb6+Nkp31SxE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Zb4RN8o5op8ucO/jNL3jPF2VY/rOb+f0LZKeOKVVIxllhhHR987Kgpq0VAP9NFrXxLw0nMoBHSeuiJOyihUA5JbTmtf0c3TUDuJ9yb0+Ad42gjXZdQcEOFYiGdSajU9eEwaYMuD0CXYixsrID2jpL9Ld5HElsLqOjKrrqTIKTR0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=c29O4V8v; arc=fail smtp.client-ip=40.107.236.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FR18phU51JY0FaK+saIPhCIdWAw16L4LR5QI+2eQsX3V+Bjk8YQ9ExGMqonf7ItWJHBtxvSRlUo5SQHRVaPvkBeeShgN2OojQdME6JhDvTNVr/QVHkoJhAJUB/abCzWqznvKSX6AoXctQ3jJH0WHhcmksJL6rdlUIUiwhN+dX9+GvlR8sjj+s1f8FiucCzFi2vUxaA7mE+u4ghSmVy5z1B95/dunvWticBlKCMLOjqe+6+bHOtjyaJ1/QHGGedTQXPzLEebv9FvRWyD2Kbj9aW0tcf/S3DtsOfmZeoTh2Zx26F9lxTVa6oUDR2Sq3eSmESO/YxNeY31Vz6YBhreK8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KZ08rvR67dhsivRmMHJi3H8KWPUKR8WZEPzgCABaCYs=;
 b=eGESnXwtrN8jsxkQyJBCV9tr1Ru6VmTYcAjvbvdz/2d9T6yefyFSMEI011Wg4NEdk4ca/RHfWEjC68fuA8UMp2ZHX97PesgUQxhJgAVe8wWQhqD8iYePZI7Zig6VQedrz129s3WnDh6p2te4u793aBdg/9FvCKMUj4eQzNqfN0RzxumRs8orcOurKSFfVkdllYlqEh1NqKjVG0/epmd7Y+qk0iU5ccX4Wy8WH5Prqzaz3WoHXyfLCQCw/JfCqExmKX7mmicI+pXNDMjTBGVRpGGbTL+1sGu28s4lvIv4NlfM5SoGeGqBYkRbzrAlPpXQs2sswyqJYAfr8TflWjTPPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KZ08rvR67dhsivRmMHJi3H8KWPUKR8WZEPzgCABaCYs=;
 b=c29O4V8vEalxI3t31YGquFIcaWdQI96du1SwE572TLgEVc+q2DV0l/RrSMz5GaR1sl39CMML9oaDu5gpp5z518qb2fC3K/aO13q/7iYHQrMRtbLDHFMjTqA+VSOOBcyIBPfvCGZD0tJiegEU6kcNpzHtfaJzim7jx7HCq071IVU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by MN0PR12MB5954.namprd12.prod.outlook.com (2603:10b6:208:37d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Thu, 2 May
 2024 16:25:12 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%4]) with mapi id 15.20.7544.029; Thu, 2 May 2024
 16:25:11 +0000
Message-ID: <b35dc4e9-7e8b-42ed-9a51-ae50d521cf4b@amd.com>
Date: Thu, 2 May 2024 11:25:06 -0500
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [RFC PATCH v3 00/17] x86/resctrl : Support AMD Assignable
 Bandwidth Monitoring Counters (ABMC)
To: Peter Newman <peternewman@google.com>
Cc: corbet@lwn.net, fenghua.yu@intel.com, reinette.chatre@intel.com,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 paulmck@kernel.org, rdunlap@infradead.org, tj@kernel.org,
 peterz@infradead.org, yanjiewtw@gmail.com, kim.phillips@amd.com,
 lukas.bulwahn@gmail.com, seanjc@google.com, jmattson@google.com,
 leitao@debian.org, jpoimboe@kernel.org, rick.p.edgecombe@intel.com,
 kirill.shutemov@linux.intel.com, jithu.joseph@intel.com,
 kai.huang@intel.com, kan.liang@linux.intel.com,
 daniel.sneddon@linux.intel.com, pbonzini@redhat.com, sandipan.das@amd.com,
 ilpo.jarvinen@linux.intel.com, maciej.wieczor-retman@intel.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, eranian@google.com,
 james.morse@arm.com
References: <cover.1711674410.git.babu.moger@amd.com>
 <CALPaoCjZ3oLdKymJjASt0aqtd0GGOme7LavvYOtPYTb_rA-mYQ@mail.gmail.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <CALPaoCjZ3oLdKymJjASt0aqtd0GGOme7LavvYOtPYTb_rA-mYQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA9PR03CA0006.namprd03.prod.outlook.com
 (2603:10b6:806:20::11) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|MN0PR12MB5954:EE_
X-MS-Office365-Filtering-Correlation-Id: 31593203-94bd-4408-d6f6-08dc6ac47027
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015|7416005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cGZYV29xWFlWY3FUVVp1bHAxcngzUFU2Y09aWnVJMGRwSlBmSUxnbmxQU1dj?=
 =?utf-8?B?Q3p2NjlqTjJ5MzFJOEVzUmtmaDNJTTcxNXlRRGc1M1NnVzd4dkFHT0xFSUpv?=
 =?utf-8?B?OGk4aE9NTDE5UitzekNMeFZOK1JoQjNoYXM1aFFBRy9vNXhxSTdYblBKMWM5?=
 =?utf-8?B?emJKcmNXamFsZGVaVHdzdy9YSDFkcWRxdlp4Z3IyTUUrQllJL2grdUNHcHZj?=
 =?utf-8?B?NVRsbnZZVzQ1bzlpUmZGUEx3M3dqQUhTdi9FYTdrQ1YwVGxTUkJ5bVc2SWpu?=
 =?utf-8?B?eVJTYnJNWG5RbUI4ajdRNVgzYW93dFJsZy9tUkZzQXpNTk1iZEtqeklVZmkw?=
 =?utf-8?B?dVRQd0VnWldMbVFZb1FldG5ReEVPOVFiVFQzbGRmYTBCWXRORUxGYmlHcUl6?=
 =?utf-8?B?bm05aG5qYjdCdCtlaUlmZ1VnajRhK3RBbHlNMHZMdW8vdnYxRUFYUTlpbTFk?=
 =?utf-8?B?RUx1eUVkU3IzREVxSjljbWJhQ05zYWdSRk9FbW14bVdvV25EUTN2dGMvMlYw?=
 =?utf-8?B?dU9hZjQwaXMzcXJLS3VIeXlxUXQ4R3dKdjljQndBYjE5WWR4Z0tuS04vdCtW?=
 =?utf-8?B?M1VnUGtwYUlickNzN1NFUTFVWnRwMFJ6dGN2OG5jYU96Ti9vOEZ1OGU3UUZV?=
 =?utf-8?B?ZDdSbGI1eWs5VzFWV0RxOEVOR3QxN01NSDF3b3VmMDRXanAybzFGd1crMFFW?=
 =?utf-8?B?TVRnSGlSNzN2SjJwWTBVWE1JcDBta0RIN3A1OXo3cnBYU01saWlJTkRWR3ls?=
 =?utf-8?B?MEtWYkwzdzJ1Z2xUR0ZTVHZhd25qYUNBd3NaYkhwSUVrcXR4L1FxQmhoN0Fn?=
 =?utf-8?B?dXBWQktSeXBZb3JjMEpDVWNxbHFVamJCTHNyWnRWZUxWbFRUWFd1ZDgrc0Rt?=
 =?utf-8?B?YkZORENWaDRUbVErSTFWREtvWk5ma2RvTEVSYURnak1vdFZPTXRWaDFndTlW?=
 =?utf-8?B?WUtTVGFQNXNxQnFZaldUVVN6bFk2QXBidDlmQkpleUhzYm1aU0FLMjNQTHZ0?=
 =?utf-8?B?aGFta2FmSlk3R1dkM2pmUjY3dFFZZ2I5dVZVcDR1U2IyU2huVDJUT3gxeEVR?=
 =?utf-8?B?azRZQ09nblF0eWJXKzdVKzRMRTQvd3RHTDQySmFINENDdWZjL0wwYTRnREw0?=
 =?utf-8?B?eG05YUdveXkxcnpNTVlKc0hFb1dvUkFpUzVGU2xWNUkxc2x6TW5XT2JGQlY5?=
 =?utf-8?B?aUk5Vmdsa3UwRk9hbmJjckdVKytvcmttbTU0YW1tV09yY0tHc0NNTDZLSjFN?=
 =?utf-8?B?T05aUzFtWHgySUg3d2ExMUVmSFRBRllrRmt5S3dVc205N29oWkFDbnc5WG5Y?=
 =?utf-8?B?aGJQOC9rUkVqVVVpaUV0Qnh1RWcxV0h5QjF4aGFRdDRJd1U0a3BMc2xvSlI1?=
 =?utf-8?B?UkIxMTZNeDVUMktLK0wwZERxaXI2alRQc0RqM1B3WlEyQ2NpL1RSc2E4cjhl?=
 =?utf-8?B?SGZVWHRHcXA1VkRZVU82aDY5dW9PZlIxNkNNTVhBRkZ0NmxmczBjT3BDVlFC?=
 =?utf-8?B?VjhaTmpIQ1haVlVNMXg5Q1JydnpXRU1WWlNhQzRMTFlSSUlvNnhJdjNid05W?=
 =?utf-8?B?UkU4d1JsQVZiNHZTekhVS0FKckFMVDR1aXR4WkxFZlcvbEM2cS96U0dCTDU1?=
 =?utf-8?B?aGZ3UDkyZ05nenJiTjk5YmN5Y0hheVF6T2hoUXhiUCt4TWxENjY5Vk5PQ1pD?=
 =?utf-8?B?RnJUVFJHSXBZTmpuaGw3ZmQweTVYTUhYckhCd1Vyb1NJRW9XSG40ZTJ3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TUtZdm0wd0tFTnAvUjFTbERzeFB3SUFpZ3RFZmpBd0tnbEwwbmtTSHI1M0pU?=
 =?utf-8?B?cXA5bjR0SGlHWU9ocllWTitjcU1jOVN3eTZ6ekRzdnRjSkQxK1Vtd2FJck5B?=
 =?utf-8?B?bkNzTzJRVktMSlFUWVZkam9tMlNKNERpRkwwUktLRGRYd0s3ekgvSnIxeCt5?=
 =?utf-8?B?NENUaFRxaGgrYXJ6RExndi96dEtuS0lnZk55eUdkNDJmcm5IL1RrYnhmWDR1?=
 =?utf-8?B?bVo3VVBJYWVDWDB0eWhVS0FLZnU0YXFjZzRBTVZrcVpMdytoUURsRmhjZW13?=
 =?utf-8?B?bWpiSEFUT2xmQTdwOFdLR05KL1JIQmFlSnplWHgzVE1oOGRaQzl2eXU3YTBF?=
 =?utf-8?B?cTUyL3hCSmdqeXBTSk45Ujk2dHp3V01zQzltdEh0NVJLOUlwWVJmaVlqbXJO?=
 =?utf-8?B?YUFybWI1Qi9ZY3U3d29TbXRsRkF1cTRBZXUwU1E4MzBFVXR3OXNuYUVJOG9W?=
 =?utf-8?B?QnBXYkJVUFNhL2pCdjZuWXFOb0IvNW44czNhQndaZDZOd282NU1VNzRGcjFI?=
 =?utf-8?B?T0RQQ0tRT1RPcncvMkg4ekZSRzVxWXR2bExPY1A5WlRkWEw4cjFhMmJ6UGww?=
 =?utf-8?B?VU5vWEhJNE80MFFZUHZISUxmK2lZaXRYSnlQS3FEV2xmNFJuTUZxOGRSeGFs?=
 =?utf-8?B?cGhlby9pMFZXTno5aEkvS0V0OHRKZ0lSc1g3dERudDdlNHg2SDUwU243VHNz?=
 =?utf-8?B?eVJsblNYeEVaQVlvdTlYUzh5NWhUZ0I2TzNQWlQzMjlKSE1zZjRZVFpVNDU2?=
 =?utf-8?B?eW9XcHBXeDR1c01TUFJiRXZPZC9SM1AwWnlGT1QyN01QMDgyR01TZTVXVXZv?=
 =?utf-8?B?aGcwMy80WVcxYU9jcDg0SUlIb2wrbG1ydDlFYytFYnQ3VDAwZHI3Tnl1Y2pO?=
 =?utf-8?B?aEhYTGRIdlphaExnOXo5Y2NCQ2MyVzN2YTgrM3FveXZpVXAyNFY4cEpBMzhQ?=
 =?utf-8?B?QTFNWDk5V1FQU0F2VlB5YXhabDhrUFVEZGtpZFlVRFZ0dU1rdlBCMzlUb2c5?=
 =?utf-8?B?cWQ5L0lSNE1VVGRUK2N5UnBScU5vckpuQ0ExSUxrL04xZno0L1VGRlFtUHBR?=
 =?utf-8?B?b3hUWC8xNksxYjBTb0k5NFlwVEhpeExWcEoxSDRCT1FXMXgzbjdzYnlWRkc3?=
 =?utf-8?B?NmN3ZDMyYWIwbG9zNnJIWERyempERGROUU5KU0s2SVdPMnFKaFAvM2QvT1h2?=
 =?utf-8?B?TktBZU9BZmorbzc0bnZtMGZvU2hnaXNvL2Fxc2hTRk1IOUxlOHd4UFRKWENP?=
 =?utf-8?B?dXU3UzBqYUt4QlYrMERtVWxSbDhsWDVmNlBQYmxNL1RBZkNpM09wTTlUY0hZ?=
 =?utf-8?B?RThCM0N1TlNwOHhDczMrQVRJdnlRcWlrVFM5VTlibGtHVERGMm1EV3V6YUFZ?=
 =?utf-8?B?ckM3WTd6ZGRVRTdUUlhnU0xETlVRN0E3VzJkZzhBRi84YW5XNnB6a3B1U1kr?=
 =?utf-8?B?MHVHckp1VFZlUzErcTJQbDNGdmNWSGY2NGlvaUhYSEdHcm4rSjVxQkRwWkhy?=
 =?utf-8?B?cjlXc0tzQk1TaEpDTGR5eVNZci81ZVJGUW81UW42UUtWNXh3OEpkeFQ5K0FQ?=
 =?utf-8?B?Q0MwQ3R5S2FReldMWmVHZnFHVVpkSWdHdnRlSGU2ckRHMzJZT1RibThmTHZP?=
 =?utf-8?B?VXFtU3F3Y1Rsc3BrODhkaVZ0WHBncVhuOTc0US9TWTdYN1k5d0FYejBlbkdF?=
 =?utf-8?B?UTREa01ZeUlCZTFscktrUytzbVVFQWhpMnArbWJxRTlmY2FVSnZYM3VsM0lV?=
 =?utf-8?B?NTRmeWEydVpwTDFrQThWSXRMdmxDdU1HVEJIY0g3eEFHeFo0Qk9HVk12cTFL?=
 =?utf-8?B?cXRhT0luTHlabVZ1RWE0Y2YrNlU5NEtiZVRiUEw5SHg4R1RYVm9SRE1qMWxL?=
 =?utf-8?B?ZGVGTnpLaFFYbGlxME5VOWJqQUNEK1N6TUpya2dsK1paL3p1QUxPaHB1OGNS?=
 =?utf-8?B?cGpIajRzeWNIaFphUXMxMVlSYWF6VlRYRnltUDY1N0N1SmxpSU04cEhPU0Uy?=
 =?utf-8?B?WjRyUWtMYzVjLzNqalRBU3p3dXFpNmpqaUJUNWhzTVJTRGRYZXg4QUNDeXBT?=
 =?utf-8?B?alFnQkhtaE80SWUyL0xXb3djbDlDZmVUVDlLYk01aTJHV3hFWjVMT2RtTkdT?=
 =?utf-8?Q?vQIs=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31593203-94bd-4408-d6f6-08dc6ac47027
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2024 16:25:10.9018
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ex+sNgOdvRIRnLBpXAjf6E/WzLj/LXQd4OEWQxXSc1Ver9cNvziEMkPb4qRZDv1Y
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5954

Hi Peter,

On 5/1/24 12:48, Peter Newman wrote:
> Hi Babu,
> 
> On Thu, Mar 28, 2024 at 6:07 PM Babu Moger <babu.moger@amd.com> wrote:
>>
>>
>> This series adds the support for Assignable Bandwidth Monitoring Counters
>> (ABMC). It is also called QoS RMID Pinning feature
>>
>> The feature details are documented in the  APM listed below [1].
>> [1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
>> Publication # 24593 Revision 3.41 section 19.3.3.3 Assignable Bandwidth
>> Monitoring (ABMC). The documentation is available at
>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
>>
>> The patches are based on top of commit
>> cd80c2c94699913f9334414189487ff3f93cf0b5 (tip/master)
>>
>> # Introduction
>>
>> AMD hardware can support 256 or more RMIDs. However, bandwidth monitoring
>> feature only guarantees that RMIDs currently assigned to a processor will
>> be tracked by hardware. The counters of any other RMIDs which are no longer
>> being tracked will be reset to zero. The MBM event counters return
>> "Unavailable" for the RMIDs that are not active.
>>
>> Users can create 256 or more monitor groups. But there can be only limited
>> number of groups that can give guaranteed monitoring numbers. With ever
>> changing configurations there is no way to definitely know which of these
>> groups will be active for certain point of time. Users do not have the
>> option to monitor a group or set of groups for certain period of time
>> without worrying about RMID being reset in between.
>>
>> The ABMC feature provides an option to the user to assign an RMID to the
>> hardware counter and monitor the bandwidth for a longer duration.
>> The assigned RMID will be active until the user unassigns it manually.
>> There is no need to worry about counters being reset during this period.
>> Additionally, the user can specify a bitmask identifying the specific
>> bandwidth types from the given source to track with the counter.
>>
>> Without ABMC enabled, monitoring will work in current mode without
>> assignment option.
>>
>> # Linux Implementation
>>
>> Linux resctrl subsystem provides the interface to count maximum of two
>> memory bandwidth events per group, from a combination of available total
>> and local events. Keeping the current interface, users can assign a maximum
>> of 2 ABMC counters per group. User will also have the option to assign only
>> one counter to the group. If the system runs out of assignable ABMC
>> counters, kernel will display an error. Users need to unassign an already
>> assigned counter to make space for new assignments.
>>
>>
>> # Examples
>>
>> a. Check if ABMC support is available
>>         #mount -t resctrl resctrl /sys/fs/resctrl/
>>
>>         #cat /sys/fs/resctrl/info/L3_MON/mbm_assign
>>         [abmc]
>>         legacy_mbm
>>
>>         Linux kernel detected ABMC feature and it is enabled.
>>
>> b. Check how many ABMC counters are available.
>>
>>         #cat /sys/fs/resctrl/info/L3_MON/mbm_assign_cntrs
>>         32
>>
>> c. Create few resctrl groups.
>>
>>         # mkdir /sys/fs/resctrl/mon_groups/default_mon1
>>         # mkdir /sys/fs/resctrl/non_defult_group
>>         # mkdir /sys/fs/resctrl/non_defult_group/mon_groups/non_default_mon1
>>
>> d. This series adds a new interface file /sys/fs/resctrl/info/L3_MON/mbm_assign_control
>>    to list and modify the group's assignment states.
>>
>>    The list follows the following format:
>>
>>        * Default CTRL_MON group:
>>                "//<domain_id>=<assignment_flags>"
>>
>>        * Non-default CTRL_MON group:
>>                "<CTRL_MON group>//<domain_id>=<assignment_flags>"
>>
>>        * Child MON group of default CTRL_MON group:
>>                "/<MON group>/<domain_id>=<assignment_flags>"
>>
>>        * Child MON group of non-default CTRL_MON group:
>>                "<CTRL_MON group>/<MON group>/<domain_id>=<assignment_flags>"
>>
>>        Assignment flags can be one of the following:
>>
>>         t  MBM total event is assigned
>>         l  MBM local event is assigned
>>         tl Both total and local MBM events are assigned
>>         _  None of the MBM events are assigned
>>
> 
> I was able to successfully build a kernel where this interface is
> adapted to work with both real ABMC on hardware that supports it and
> my software workaround for older hardware.

Thanks for trying that out. Good to know.

> 
> My prototype is based on a refactored version of the codebase
> supporting MPAM, but the capabilities of the MPAM hardware look
> similar enough to ABMC that I'm not concerned about the feasibility.

That is good.

> 
> The FS layer is informed by the arch layer (through rdt_resource
> fields) how many assignable monitors are available and whether a
> monitor is assigned to an entire group or a single event in a group.
> Also, the FS layer can assume that monitors are indexed contiguously,
> allowing it to host the data structures managing FS-level view of
> monitor usage.
> 
> I used the following resctrl_arch-interfaces to propagate assignments
> to the implementation:
> 
> void resctrl_arch_assign_monitor(struct rdt_domain *d, u32 mon_id, u32
> closid, u32 rmid, int evtid);

Sure. I can add these in next version.

Few comments..

AMD does not need closid for assignment. I assume ARM requires closid.

What is mon_id here?


> void resctrl_arch_unassign_monitor(struct rdt_domain *d, u32 mon_id);

We need rmid and evtid for unassign interface here.


> 
> I chose to allow reassigning an assigned monitor without calling
> unassign first. This is important when monitors are unassigned and
> assigned in a single write to mbm_assign_control, as it allows all
> updates to be performed in a single round of parallel IPIs to the
> domains.

Yes. It is not required to call unassign before assign. Hardware(AMD)
supports it.

But, we only have 32 counters. We need to know which counter we are going
to use for assignment. If all the counters already assigned, then we can't
figure out the counter id without calling unassigm first. Using the random
counter will overwrite the already assigned counter.

> 
> 
>>
>> g. Users will have the option to go back to legacy_mbm mode if required.
>>    This can be done using the following command.
>>
>>         # echo "legacy_mbm" > /sys/fs/resctrl/info/L3_MON/mbm_assign
>>         # cat /sys/fs/resctrl/info/L3_MON/mbm_assign
>>         abmc
>>         [legacy_mbm]
> 
> I chose to make this a mount option to simplify the management of the
> monitor tracking data structures. They are simply allocated at mount
> time and deallocated and unmount.

Initially I added it as an mount option.
Based on our earlier discussion, we decided to use the assign feature by
default if hardware supports it. Users don't have to worry about the details.
> 
> I called the option "mon_assign": The mount option parser calls
> resctrl_arch_mon_assign_enable() to determine whether the
> implementation supports assignment in some form. If it returns an
> error, the mount fails. When successful, the assignable monitor count
> is made non-zero in the appropriate rdt_resource, triggering the
> behavior change in the FS layer.
> 
> I'm still not sure if it's a good idea to enable monitor assignment by
> default. This would be a major disruption in the MBM usage model
> triggered by moving software between AMD CPU models. I thought the

Why will it be a disruption? Why do you think mount option will solve the
problem? As always, there will be option to go back to legacy mode. right?

> safest option was to disallow creating more monitoring groups than
> monitors unless the option is selected. Given that nobody else

Current code allows to create more groups, but it will report "Monitor
assignment failed" when it runs out of monitors.

> complained about monitoring HW limitations on the mailing list, I
> assumed few users create enough monitoring groups to be impacted.
> 
> Thanks!
> -Peter

-- 
Thanks
Babu Moger

