Return-Path: <linux-kernel+bounces-85081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 613F786B01F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 14:22:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 81CD91C21487
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 13:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0992114CAC3;
	Wed, 28 Feb 2024 13:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="BXda9RrP"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2105.outbound.protection.outlook.com [40.107.243.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0325145341;
	Wed, 28 Feb 2024 13:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.105
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709126514; cv=fail; b=GJrgpSMBnzVlt/2cPyMJOf4gT5VPoUAmzKvoSvfS06m/9pQCbTxvYF8e1ROTynvNy9Zt4RMg0ILSubn0KJPbe3jstStJ5/EOtFd2R4HwwZt2uTjtBRay7F9Y3+ByE35n96lCySWXa2x2tli7SOFSOTng77u58xtQBKYs6wmsw9w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709126514; c=relaxed/simple;
	bh=sqba1rF0WLX4Eh6pf24zvdsX6VY7eJZkgSAkgUqwPo0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MlIsg6g5Sx+/XAYAUjxyZ3aPXT1dfgV4a9nnqRRdRiYceO5oU8Gml7/iT906rsqYh0EyX4sZpKH5cXe0V1Z3PSTraCFZI/Ghf9/n4N3BBkdUpKdYeumBBS/do1l8v50kEyx6eT5dEfI22sC3eTRY83eYLruTOP/99W1n13aTubo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=BXda9RrP; arc=fail smtp.client-ip=40.107.243.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BDFfVEKVwGwU4uf8YhZdv6B4YdIhJbYkNo3MhjH0xsn3wBdzTvNvvxBenwVh+pUJ1td8zXwzoaIzaVrOmIXH7AXAbaeAhCi+Vd2KoiJNDz6N736KqqP5BXuSbzy4kXm/m06gJOy301zvn3wtpp/A194z/pR/dW5ZDWG0TiAmNGGHqZzKpPBoOhss/3+yrzMne5V/YlQD6j5EqIiXYXUPFZHqtoUMiGF5wrHsct8EY+9L3hgFhnGeQq8IOi0kCZ879O5CYFGY++tXYltkWuTrfmeYREHojAgwagBC/ApJhjuKKr+aY+Xu86GVoXU4t6ozvifF+j/TGdVneXG9WZi12g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FMZ2B4UDD+ozu2BXQnYdNBaPjFM8AdfBKYb+iyIuzDw=;
 b=MB36KYoIxSzX8zGcdGPDAMJO8kejGw9d5/H9ow+CKQ3ZcTyDZRK5Hj/ooh6tDCXz2cFogm4Ak1M4GioA/J3f6nhBrXqCfIRXIOGSHG9rj9AjGB8mJsIrNAQvUbnyNmdVHsxnNMU6yVxtCijmqaPYx4kOkEataMZfiKoKjdPdUhUXY3cO+lb8knj+bjOKdhVe1lJlbOKNOMfJGWgwEuM0qGtZ56ZKwCai/Eg6Lpp0hnmZGZha57F5funuNXLmMxH0I+CRmBelNj/iN1s9G2kK4g58YE3d/Jqa8yQ5nSGObb0Rh+IpL2D1vDbNTABquuoD7V9xyUumxmAsSK5u3te8Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FMZ2B4UDD+ozu2BXQnYdNBaPjFM8AdfBKYb+iyIuzDw=;
 b=BXda9RrPKpw3HzjaH/+abZeuFd/VEvt/t5zwaDFlFy2MRjZBnC5bg6LSH0GgI2M7DFQoCb7U7MCom5Aqk5U6PwH+/+Re31Y0fCVwvQ4UYHK6j6dFQ/lJoMieXqQMGo7VPWejoilryfcWjdSo7f8WAkCwN4w4tjsXOm5Nl5uw8Fs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from BN7PR01MB3730.prod.exchangelabs.com (2603:10b6:406:85::11) by
 SA0PR01MB6457.prod.exchangelabs.com (2603:10b6:806:ef::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7316.36; Wed, 28 Feb 2024 13:21:49 +0000
Received: from BN7PR01MB3730.prod.exchangelabs.com
 ([fe80::c068:c0a4:25eb:22f]) by BN7PR01MB3730.prod.exchangelabs.com
 ([fe80::c068:c0a4:25eb:22f%3]) with mapi id 15.20.7316.034; Wed, 28 Feb 2024
 13:21:48 +0000
Message-ID: <a8de785f-8cc3-4075-a5f2-259e20222dcb@os.amperecomputing.com>
Date: Wed, 28 Feb 2024 21:23:23 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: make SK_MEMORY_PCPU_RESERV tunable
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>
Cc: corbet@lwn.net, davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 willemb@google.com, yangtiezhu@loongson.cn, atenart@kernel.org,
 kuniyu@amazon.com, wuyun.abel@bytedance.com, leitao@debian.org,
 alexander@mihalicyn.com, dhowells@redhat.com, paulmck@kernel.org,
 joel.granados@gmail.com, urezki@gmail.com, joel@joelfernandes.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, patches@amperecomputing.com,
 cl@os.amperecomputing.com, shijie@os.amperecomputing.com
References: <20240226022452.20558-1-adamli@os.amperecomputing.com>
 <CANn89iLbA4_YdQrF+9Rmv2uVSb1HLhu0qXqCm923FCut1E78FA@mail.gmail.com>
From: Adam Li <adamli@os.amperecomputing.com>
In-Reply-To: <CANn89iLbA4_YdQrF+9Rmv2uVSb1HLhu0qXqCm923FCut1E78FA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0361.namprd03.prod.outlook.com
 (2603:10b6:610:119::27) To BN7PR01MB3730.prod.exchangelabs.com
 (2603:10b6:406:85::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PR01MB3730:EE_|SA0PR01MB6457:EE_
X-MS-Office365-Filtering-Correlation-Id: f2746218-69cf-490e-403a-08dc3860376f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	PB0zvpXofQm1N9z/lGzwHtXmJ9GYGcc/U8/R2kpb0NP2mJQBbxcyuNQb9Yd08x2GJtY1mK9kHKWYBFFlgN8G6YlsLHwGVso0NI2nB11p6HNbqiR1SNpNIIGNMOgcQgAKa/5BDq3E+rS+9jHIv/7HD4gQgnJkOKllxf1fWawwtq90+PAjDfaUwPMo/VLLdKLnheW3PJ6uilmUslrPifOuF1Rdq1t9I9j+QeRXMMJL4lHmy8JdFDim/1g/L0x0Ij4nNzAOLFvGYrXpxw/Kjg2Mj2jBJEPhV7n66/51uWVYnJ1VOm+XJrfxEEs88N1nPlJ1cx8OsCXMh/VCp1IAjIzin0ainY5ht4cg/qBrABvt9dNYIq4WfN3uXXYfjcy0XIMeh88mX17AMqeXeHyIIlG8va8fkENm5x/BS8SVmg2/rq4H0Ek/rsfOFNGlMgeB8Ry1i6JNb2EkJa9rUiz10ZanAhFo86Rrgo7/wMMtH19KqsjVd4dh5ozO7f+Pvwe8cG+70WvimxWUZjOfObE+ZsCU3atWXxXz7pvTvxPQ3aV5qNy18J5QJo2baoXQzQgWFvU0jbjVu2Xf3eh1gSvZxVem+iNgh+3BAB9rK0nedroqxpVWk1lftDomcQDSzKuJ2KPeFiw4kJED8GCmBGFtvnEVLA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN7PR01MB3730.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VmVqUThYUG03aFJyalU1SlZId0Zid1k5YXJ1U3psdTJ1MFFwQjVYYkZQck5p?=
 =?utf-8?B?Y0NsTXI0bEttU0JJWEl0YVhvTkJwbDBENzVGTHlvRHR1b0pLRUl0TVkxYUxy?=
 =?utf-8?B?VVcrR0FQejhuRmNZeTIwSWp5dWVNd0NTOEVGMFNMN3VaZElCV28xRTliQThS?=
 =?utf-8?B?U2NNV2V4SjJYdkJMdjdQOGhvSmg5VTRjVDlxWXdXRGxxbGVSdkNHWDRjcHhp?=
 =?utf-8?B?MHl0b1ZkQkxrYTlRVVRQMnNtSjhGMVRzR0Q1NTFlWFkyTEVyQmlVUS9WcVk0?=
 =?utf-8?B?dHRMRkYya3E2RVhQL21EN2NRbzRFVkRsZ3JVaUlrbnprWi9iRHdVYlBKQ1VQ?=
 =?utf-8?B?QjlEeHNHOU5DdHVIa21LMENnWWJpRkFyT1ZCRDRvY2Mzejc3aG42d3gwK0FQ?=
 =?utf-8?B?TmRzeDhCbkRIOXBLVEVPWWpFRSt4cWZqWEczaGZxQWEvZDlGdmw5WUQ0am9n?=
 =?utf-8?B?MzZ5ZUZOcVlQL05kbks4SzRJUUpMSVhiYklJWEJFOFJGSVlHUHRTWHV2Y3pj?=
 =?utf-8?B?eHYwRGVqa1RrSWtMY05tbDNNUnh3SVFLd21ZMHRaMmhkR0Y0T3k0UVMremVN?=
 =?utf-8?B?bFExemtpa3FBNE5DOEplTC9aSVk4c2s5WVJMczRrNlJJRkZZNEgyaXVDVHl5?=
 =?utf-8?B?RWhRa0NTOTVoaStIVDlYVEVqZHhmN3duVHZQZk1MTWJ6b2Yva0EzRzk0UTdE?=
 =?utf-8?B?Sld2dTVla3VzcERQeWZIQ0N1S1kreERWVTA1T2xkcUxWdktwVmtoSngreWk1?=
 =?utf-8?B?YmgyOXVQL0xabU4rdVd0VWhhTmFiLzYvYWx5WlFrSHgybE5RVDRSejJVWkpq?=
 =?utf-8?B?Slp0NVlvaVpHYzgwVW1tb21lTGpscEp5bld4YW1xbHBVWTdqK3J5N1d4L3ZM?=
 =?utf-8?B?SVZ0VWlraUZVSDdOM0NtT205MW9aUE9HbU9pcUF5WGdtVFlTQ2pGU0JUUklt?=
 =?utf-8?B?b2xKaWJpb01LaWdSVExwOUk0WGk0YWJTNytobUNNLysrUVhMODVtR2VkUk9R?=
 =?utf-8?B?cXV5cGhPVlVNUHBTd3BnT3ZIK3RkQkxmOGdYc09kRytyRmtiY2pYUkxoTWVk?=
 =?utf-8?B?blYwNEFvZ2ZrbTV1Z3FFN0E3VllYajMvWjdXSVIzYng2aUsvVnNXbUJqSUV5?=
 =?utf-8?B?TW1rM3RhVG1mQ1loYzdBTVJXN0ljQ0JJckxDM0NIb2tNT3VpZFhHWWxndjRN?=
 =?utf-8?B?SUxMcTZNTHdXbm81WWpNcjllQVR0NjlyaENQMzZlV1h5eVJYVDN5WXJKSloz?=
 =?utf-8?B?aFNLUGlhdmpLR1AxeDkyYkZKTzRnTUc4NlhpVTNZNWI2cEhFT0tyWGpKcWxk?=
 =?utf-8?B?NmozT1BDekVWOWlGckxXcnlIWnBjNm03S2xRemhvOWRUQ1ZTTnBxbWV1YUJI?=
 =?utf-8?B?MHFoVUcrVllqV3hsdGhMc1FWU09lSlJRY2Z4TTZNVGNtQXFPb3IxOXg3SnRK?=
 =?utf-8?B?SWFiUWZteUpUa2lGSEFJMURuajJCeEdxanU1RjB6dTJrMDdpaFNLbzBqQVly?=
 =?utf-8?B?VmkrOGpvTEhXQlZySjNUaE5IN016bExuSXovSEF4NmJUNmtia3JmbE95Q2tr?=
 =?utf-8?B?TWNCNy9kYk56NTdGK3FEUnRzbWUzTWkrQUlNMzVablBNTklNOUdUNzlqOXhx?=
 =?utf-8?B?RElZSjhJNy95KzZ3aXhQUksxejhFTmZXeXJscFpvNm1DM1hzWW9jc1JWRDBl?=
 =?utf-8?B?azdQdkk0TTBITVphYUhxbTBIOVBVdi9FT0UwNjZoKy82eVMzREdTMHRjVHNv?=
 =?utf-8?B?NnJ4bmUrZ3k2cFdTeWpmNkFRaFZZZWhaa2FZNXFTcFcwMGc4SzJuVXNSa3BW?=
 =?utf-8?B?eXR6d0pWTlkzMkhRcE55Y3A3UmJlWnFHNFZyZTBvL29DM2xKdXU2bUx4dGdu?=
 =?utf-8?B?SUFPS0hwelVWZWZZQXlZWGN2dWJxRWJTa1gvS0JIQnlKZ016YW1DRzdmbE1m?=
 =?utf-8?B?Wm9rYjYyc2NreFJCNDgvNUZ5RzVTckJSaGt0dVF3dWtoU0xBWHNhYUU2MnBh?=
 =?utf-8?B?NDd6Z2t0WUJaQmpVTTN4TjdQdkZnRTlsZDRHVTBTY29PcjZlYlhCSy8wSnhO?=
 =?utf-8?B?NGhDWFhnbXpGUmloQ0tsM1ZPOHI3TXZrL2VKU2g0WHo0Qk5yVFRYdEpwNHJM?=
 =?utf-8?B?TVljY1ZQcE5yRm9TY28rUEYyaXJyVWMzVWhIeXJjUFlESTF0SWowTHcvd2hT?=
 =?utf-8?Q?l2yBKTiUSB+0UFp2bLwQioA=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2746218-69cf-490e-403a-08dc3860376f
X-MS-Exchange-CrossTenant-AuthSource: BN7PR01MB3730.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 13:21:48.6170
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vGykPKUBvbl5ksZMQ0CGjgQV+f1NMh/SQVJPBuMrwlaIxOYH0D2UfZtarKcqLnHVCzvIXmVMfCZtIX9akhMmIMKDkLe15bIcAygeeq59cbtaCxtBkqcmyMEtxFW8xpgO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR01MB6457

On 2/28/2024 4:38 AM, Eric Dumazet wrote:

>>
>> sk_prot->memory_allocated points to global atomic variable:
>> atomic_long_t tcp_memory_allocated ____cacheline_aligned_in_smp;
>>
>> If increasing the per-cpu cache size from 1MB to e.g. 16MB,
>> changes to sk->sk_prot->memory_allocated can be further reduced.
>> Performance may be improved on system with many cores.
> 
> This looks good, do you have any performance numbers to share ?

I ran localhost memcached test on system with 320 CPU threads,
perf shows 4% cycles spent in __sk_mem_raise_allocated() -->sk_memory_allocated().
If increasing SK_MEMORY_PCPU_RESERV to 16MB, perf cycles spent in
__sk_mem_raise_allocated() drops to 0.4%.

Thanks,
-adam


