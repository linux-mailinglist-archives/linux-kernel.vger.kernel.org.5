Return-Path: <linux-kernel+bounces-72315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CA1BE85B1E2
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 05:14:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8EE6B224F3
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 04:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAA1656B7A;
	Tue, 20 Feb 2024 04:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b="Lqes/fsy"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2098.outbound.protection.outlook.com [40.107.117.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83CC153E3B
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 04:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708402459; cv=fail; b=txIUiuyeIsIA7fCOquLCy7OWriwcwEJc+40xdL/ZOR3ql+h0p8tfC4dUV+XRdKRLjoiqVpxYKB0MD36ABNylkIHP2aRVzvi0COZMx/zAzEMpEFpb2KrRECB42IfyQTKpkupaDWEbXgF56nAvQPG3p6GjpZFIW/VjrPNl+0+dJUI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708402459; c=relaxed/simple;
	bh=Jcamx8gtz2nVsY0xFSZ3Ljy0fJLnfJWBwgNSy3mN3tk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XKXVNz9pwAY3tPrgysnSY0hTzhqRfppU4TBrE6j+lM5APYMDXVAzNdAxeKXW6fgJPycDXsvDMAtAooDxYoOUoHzrYM/BCtA4pjIHO34qHoT2DQoJc/trFnKuF1enUjdr5KJxC8fOD8a7O8oWGkMbehxCiZ7aaCMuJG7WWnUhkBA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com; spf=pass smtp.mailfrom=oppo.com; dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b=Lqes/fsy; arc=fail smtp.client-ip=40.107.117.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oppo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J2AwIpzkbzr3evVKdNDbX59L4UjdroVPsdDiWzqjzZ0yXOp3we5mlziU31XFgn+c9IMevhuBTw1W48UT2z3XJSTCgxLsvvQBQHHk/FKYnMjeSRvrLioUa4PF4p4wWlmZ9irR51a0m5wnseREe5vm7kvRXI3wmcxpFiv2fZFZ1F4a82FKupjKD5QW4LbXnkDigNksUDoDZmtYaCpZRKFU6z5DPWDb8KSzfYBxsnkdWcgtlke2bKcYPDDYwhUKfEoeDUydO26viAMm45XCuRxtKeTbLuSJUXCs8rBZl2dDMqoa3nJ/l9PzdeOs1ikrBF3QmEVIl8qQd5b76FlLkVuUiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=znPXYFNu4zmcmuF4gwq8Eo2jKBfGJOusHmc5JYxtl64=;
 b=gX2alo8z9LtSKeQL1C1d4QNdwoDaYhFRzVr5T7JAfuMKi7AwQntUdq8lK1maZ6R1O+9qoAcLq88PQpV91ynMUPomt1dnAYzlwdrkFHl101lUKHurQJVDl7ik6A7jcFC6VQY//ZOwfLhDmQmhVVmPHLm1jMR/6X4bVvmoqi/CJbEcDgh57aeRRg1Xh7nhXSQfPE1Xs/L2GvN5zIciHPpSYyEIol5ElHj7VoNzJiycV4uLAyuxwmbZ0AI8G293uMGfe1YvPXieJPNCLQOJuwAKqMDEILBLXg4WHRIxijrUFvSCokzcUoMuh7gtqmIMB2bUSzu3ZqheGLI64BodVGcvwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=znPXYFNu4zmcmuF4gwq8Eo2jKBfGJOusHmc5JYxtl64=;
 b=Lqes/fsyPYy3L8uQYBuVoRdcHlsM/lBQnuqUwpMqCz8T+kvsmkPDSucicul0oNVS9B69ncA+RdvVjK1aNHgSAdtEI0T24e0sk02+gPULwbgKenozhxk8RdhBY+vOW4i7TBUMRICLIlRm4p+Y/Fz4wbOguYkd7VRRM6c8XYbHnHk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oppo.com;
Received: from SI2PR02MB5612.apcprd02.prod.outlook.com (2603:1096:4:1ab::12)
 by SEZPR02MB8223.apcprd02.prod.outlook.com (2603:1096:101:250::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39; Tue, 20 Feb
 2024 04:14:13 +0000
Received: from SI2PR02MB5612.apcprd02.prod.outlook.com
 ([fe80::5002:785e:e85c:37b8]) by SI2PR02MB5612.apcprd02.prod.outlook.com
 ([fe80::5002:785e:e85c:37b8%3]) with mapi id 15.20.7292.036; Tue, 20 Feb 2024
 04:14:13 +0000
Message-ID: <95a87f90-f82d-f146-110e-1e23cd8d8b24@oppo.com>
Date: Tue, 20 Feb 2024 12:14:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 0/2] Support kshrinkd
To: Matthew Wilcox <willy@infradead.org>
Cc: akpm@linux-foundation.org, david@redhat.com, osalvador@suse.de,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, v-songbaohua@oppo.com,
 gregkh@google.com, tkjos@google.com, surenb@google.com
References: <20240219141703.3851-1-lipeifeng@oppo.com>
 <ZdOG-135dLP0IeU8@casper.infradead.org>
 <a642d9dc-6d48-016c-7007-c08ce8933d18@oppo.com>
 <ZdQUmWxYuuP24w_1@casper.infradead.org>
From: =?UTF-8?B?5p2O5Z+56ZSL?= <lipeifeng@oppo.com>
In-Reply-To: <ZdQUmWxYuuP24w_1@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYAPR01CA0051.jpnprd01.prod.outlook.com
 (2603:1096:404:2b::15) To SI2PR02MB5612.apcprd02.prod.outlook.com
 (2603:1096:4:1ab::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR02MB5612:EE_|SEZPR02MB8223:EE_
X-MS-Office365-Filtering-Correlation-Id: cc8621ce-d36e-421d-0a4f-08dc31ca650b
X-LD-Processed: f1905eb1-c353-41c5-9516-62b4a54b5ee6,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	5oExAED5jScumKrXaOwoDJf78g2V9yzmMhU7VhUf9vc7K9hpoWNaNMMMjBsj1MQURv9XARLnLyNeAUzGBH5kikzFLM4cx3vJTgJCMk3Y2U+vP8b0dvIq1b9y8tOZYjl4OPOZqjq3tNM9FqHq5vTbXb7lJa2ET3SHDZ9S/YHiQDUs3SFbmmHMD46E1vFCZx6cbHhg9guulfbB0wRLOTYXF0x+3Qqxja0EXcrZJJLB6XtJUsRKMNEsznfepTI58N6CUZ5NNGvBDC2n1FHexCRBw7VA7K4xXKwmu7byfh565DFjjSCXvPjUEsmplHvspYUniOybwy+gbGH4gh5jx8iPFqrbVx9Vj6zod5S1w0eQnk9IQzbXTAzBbgu98frRZzP+K5Vb3/YBqrCLcsIvne+tVucFthpCBnJpVm8oq5mI6ZxpPsxAojBHWd7XLBkmcbGDWx36w0jCQgAolhZgW7mGqKWK0sPhy/sc6buNCOrDjj9/ZjTxRVbhPVKu1rvOh8kurLxBLUzgvzTvwGeM5F3agtJ1TXLD2+phWdYuJV4UoR0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR02MB5612.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R1NsMWN1ZjdMQlZ6K3d0Y3NNT2NiN0dHS1ZIekRjVHNKMXdmeVNsYjQyZ2tR?=
 =?utf-8?B?VFpCeGRYZmRyWG94SDcwcnhhWDRFK2lzS3NxcmllOXlUNGk5V0taMjlJc1Za?=
 =?utf-8?B?SHovUlVEaFJiYzdvNTBLY1hLdlJoWVpWbzFvNGtkeTBaRUtBQUtpR3pnNTYz?=
 =?utf-8?B?SWRyRlIyWXY1U0lQOVpHSFhMVVR3S1dueWpQbkJRSWNGckJKa0FhYzFLTzBC?=
 =?utf-8?B?TzB5dk9HMFB4bzljVDhJb3dtWlJrbWZhUEF5NjZ6MUNSZDNXdzF6OVIweFNk?=
 =?utf-8?B?MTFreWV3cXNkdFd4d2RoR1k0QWVhZTNab09YZjVnZWNBcG9kWS83QkY2N3lQ?=
 =?utf-8?B?NFlva3lHaEdDVXFHZTl2YVFWdzVrenJBM2N3ZkxEeW9JblZqd09XaERZZzdI?=
 =?utf-8?B?TjQwL1RKbUhKTXZ3d1NWdXgyQ2IxazhFcU94R3JNZ0x2Zi8vdzdpbFp1MFBi?=
 =?utf-8?B?ektnUkJlVXgxK252M09lQlZuM0ZCYXVpeURvSGp6Vy9OTTFIcGZ5cFdIM0dV?=
 =?utf-8?B?N090M0J2alVtb3NzZ3pDNDI1alplRFVScVVqY3o3UVlIYm5nMEUrSnBCYXh1?=
 =?utf-8?B?UlE0NnVYS3JZUmJhWEV3SVZDVHlVSGh5UkVSdEhad3lyWmtTSEE1VzhwRGd2?=
 =?utf-8?B?N3UxZElPa2RHTy9QNmxnN2VwSG5ZSHY3NmRLNGRyWHAxbWtzejVLM2VUUTZN?=
 =?utf-8?B?TjFQNTVIdThOemo5eFMweUo2R3E4VHR4UVU3WHJFQ2Q5aTlTOTJ1ZS9DdzBl?=
 =?utf-8?B?Y1Zsc1p6MDhOOHp3YWg5Nzh5UEFBVUNLYktsUklTN3ZpNG9Jc0kwK0VON1J1?=
 =?utf-8?B?U05iZmdhRERNVzJncVdLSjBDVDFrYmxRNHRRcmJkbk9OMDQ4S2ZNUk5pa1VJ?=
 =?utf-8?B?QXBFaGJWR0liSlRlQmZvdmN1bG5Fa00wdllvUWY2a1Bzd0s3U0ExRHAzZWRt?=
 =?utf-8?B?MkUxeHk1djhRTFlGWXlxYmpIZGZoVENWNUViakR2WU43NjNsVVlSZ3JlNmVh?=
 =?utf-8?B?dTJ4K0gyVTRuK1Nwdm1nQTdUd1FTVWpJcmpSQmhvM0ZWVS9xRHBBc2Y0aUpr?=
 =?utf-8?B?cjVuNUo2eHFzNjA2WVYwczlSRXNMT1NOakRGSW95bXhhYXo1RzFvemZYbHBn?=
 =?utf-8?B?QUh0UVYvM2VUUENnUjAxSGd1anJaU281RG1LUlc4bnpYNytPQldEZnJKZDlw?=
 =?utf-8?B?UEhybnVDRW9rbUwzQ2VDcWhmMUM4L2FZa1MyYXhJenJRMjVTNGtuSnVML1lq?=
 =?utf-8?B?ZFBtZGViU05MUHBtTEdZMkN3OE5PN3VlRXhSQ0hJUVo4bk5DaldCejVxLyt1?=
 =?utf-8?B?V2MyeXIrVHBuQWRyaS9Ca2d5UCsyd04wSzNwTG1yM2VnaExLWlhNZUZnclND?=
 =?utf-8?B?MWUwNEtrOEhuZkRDeXh6ZGZKcHRSY2sxNlFqMW1xWER0NjBiMEdtclE4SE40?=
 =?utf-8?B?WWg4SWlhVThRVm9xWjE4TmFIWWpyKzlOL2lwQzVkYm1hS3Q4K01jMUkzbWpt?=
 =?utf-8?B?Q042UmU4YnZ6emp3cVFBa0JWS0FrbW1nVDRiMGVsazRXNTJrMFowVCswcUQ1?=
 =?utf-8?B?OVpLK3I5WVBzeElvVWt0ZXlBd05OSlhrOUtMYXdhOHV4TGhiRG11ZzFtSy9z?=
 =?utf-8?B?QnlJd0cvbmtON0FDVi9BVVVCdW1rektFRXl2Nmo2TVBqSXovTUFvOGYzYmth?=
 =?utf-8?B?VHFLdlpXbDlHanhmZVYzODZwZXhHczFocVZScGM0c1hLS2VaVk9RV1lmdmJQ?=
 =?utf-8?B?Rjl0aHVveGpyZjgwaE90UkN6QkdHNjJiRXo3VHgrcktlTHJLSGhYZk02TU9U?=
 =?utf-8?B?dHNjNmg3ZnJRQWxqYU9nMjJMYnJZT1U4bHdiSERPSmxqeVZBb0JVMEJZeGFP?=
 =?utf-8?B?NE1QK3l2OTdYR1ZpbS9mUUtXV3JHUW5RVVg1V0s4WFBUSTlTZ3dVOTc3Wjcr?=
 =?utf-8?B?TXY4Zkl4VlV5RXdzRGdYU1FHNVRaeE1jUHJZd21ELytwUkx1YWhaUUM4Y2J5?=
 =?utf-8?B?aFUvT1REdzBZQng4V1VIak1PWWlUU0JxZDBYb05jK2UrT1M2bVo1cnlJL1Bs?=
 =?utf-8?B?b0NMMGtqT3RjSWRrVUxvZHUvNVExQnhNdml0WnJiM0ZhMzJqSDU3VEFXSVBl?=
 =?utf-8?B?b2RUTHM5SXpyMytBTjBNb21mT2pmTTVPM2loUU5uK1NwZEdWSnlSbHgyd2lu?=
 =?utf-8?B?WGc9PQ==?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc8621ce-d36e-421d-0a4f-08dc31ca650b
X-MS-Exchange-CrossTenant-AuthSource: SI2PR02MB5612.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 04:14:13.0299
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h/IB/TGUn3TGPsnSyUSN78vJLluz6ZWq7h8laGI/aCdhYqmzbNwcuNRrbEFVTimg5QK9cCuSFZL8z92oLNK6fA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR02MB8223


在 2024/2/20 10:55, Matthew Wilcox 写道:
> On Tue, Feb 20, 2024 at 10:04:33AM +0800, 李培锋 wrote:
>> Monkey-test in phone with 16G-ram for 300 hours shows that almost one-third
>>
>> of the contended-pages can be freed successfully next time, putting back
>> those
>>
>> folios to LRU's head would break the rules of inative-LRU.
> You talk about "the rules of inactive LRU" like we care.  The LRU is
> an approximation at best.  What are the *consequences*?
> Is there a
> benchmark that executes more operations per second as a result of
> this patch?

Hi Sir：

1. For the above data in 300 hours test in 16G-ram device:

- 795503 folios would be passed during shrink_folio_list since lock 
contended;

- 262577 folios would be reclaimed successfully but putback in head of 
inative-lru.


2. Converted to per second,:

- 0.243 folios would be putback in the head of inative-lru mistakenly


3. issues:

There are two issues with the current situation:

1. some cold-pages would not be freed in time, like the date we got in 
16GB-devices almost 1GB-folios

would not be freed in time during the test, which would cause 
shrink_folio_list to become inefficient.

Especially for some folios, which are very cold and correspond to a 
common virtual memory space,

we had found some cases that more than 20 folios were contended in 
rmap_walk and putback

in the head of inactive-LRU during one shrink_folio_list 
proccess(isolate 32 folios) and more background

user-process was killed by lmkd. Kshrinkd would let reclaim-path more 
efficient, and reduce 2% lmkd rate.


2. another issue is that staying more cold folios at the head of 
inative-lru would result in some hot-pages

to be reclaimed, and more file-refault and anon-swapin. Data would be 
updated soon if need.




