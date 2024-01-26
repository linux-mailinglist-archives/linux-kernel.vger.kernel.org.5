Return-Path: <linux-kernel+bounces-40172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5799B83DB9F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 15:22:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CA1E284127
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 14:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D897F1C29E;
	Fri, 26 Jan 2024 14:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZmUNtgqb"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2072.outbound.protection.outlook.com [40.107.223.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 140A71B599
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 14:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706278930; cv=fail; b=Ugejt67L1lNtkxe5LS7SeguOd9SiZU+6eJkgZthrvzjlh3QzOKfxuimrbYEnNIWD64VOWuEE0phxHY11SfHcXuNPf0+Gxz+NpBHcPjACQY5UDF/2iXelLPynW548xeoHxP3UPa7WV9WOimwgiGmqoUe8d9RSMqXHyhnb7xsoR8c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706278930; c=relaxed/simple;
	bh=3ySJRPLm7Qoo+3nmKo+lAak4scAf0HCKHrDYVYJgojE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TNB2yNcJEtOrNwAzbaFr17J0unikHyCvix+CC5zz+Okkz5kqcU+Tr27oHNSeuIfzAjacKmw/CmH5G7tJLvN5P+CWHNLBM5oHKgpJhdoFsPhhJIsx6wh8NgcjOmrunTEOdjFsn74VJGlwv40ZLDd+pOiJ7KSofC2XUJcrR07xfpA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZmUNtgqb; arc=fail smtp.client-ip=40.107.223.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a3we9VLLJGbU3XYqW3xOzSqA2ZFrs401+Pab7qc8m4eYgd36S6z+5mORQWryq2XvJxhvWVQvuHB+JLXxFLJiIYKcq0gTmroKDAY1SIygBaRNwRrPEG7sBvjcvs4tPm016gBibx7/sKbtBQ0qEaaKPSRZHFZP7fpabebynMKOUu+z9OXr8Q3be7unW7M/zLoQ+DPNb3Uy/Fg9JzMjTbuoULip9UwD02U4W/RmoUfhtmx2U77UmagPAKyLhLnvmxLgY+T4m2KBNo2R6uB/r1GLlyj0BVCRZxci06/0YG5f5GPZN5+U8ahjfyv1Be6MerVC726NZz+4i4v9ONJa/qZnmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y0moajHl7xz+U1jGgVwYV+OLr3SnbQ0UXIOtrH8KS1U=;
 b=g4QPybMAydY4R6JxSDZ5Pt043ynPU5D5z6zRHIAWAg3ExoDScmMsLFc2VlpRuADPQqnKofxzFxIwZxfdQW/x6QsAVbiE4D80EIN5UJ8pirYabTwSLET4yvtfvlSaUE+sGf/qGhi/PEwKwWmTZbdSLnlX24YXpRAq5d/XwprU6GnN5wBuOJ4aatY+M1L+hofcnTLC5waqGWsBMXSIP4Muy0So/w+Vp8xwx61t8BLYsjXEfz8O7xdga/rLq/Kotgr1czizAXst0I1npAOsSUmVBYEDEmvSBzQj2wSpFK5O+o+wEYM0QehEnFQrn3r2jEfsyyLuk2hjnwjvoqm9OPP4Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y0moajHl7xz+U1jGgVwYV+OLr3SnbQ0UXIOtrH8KS1U=;
 b=ZmUNtgqbzIpFiwz0Tu+hc9w06JWFSweLydfII9lNUsFwrE1aYsTmHTw8L8sPInmY8D5mB8jX9DFp79k/gQgBoV3gchg4PQcMVuu52l0NqMS2a5+ga57WDaWpknEe2rhcDVgPST893aOCpcQLh8SblMJLQSfZDwMNiMeTOk+ohRWkFeHzLeVjdt9pfxWbIuVkKK65Z+0sraUsRdE/dnNBpNUbEKNQoH9OKQVwNdVxfgMb1Qd/SsHnIr98GW3SoErvb9y5spKaOCct21geo8l+BC4BJSvmpV9m3iUD2L0sRm4E0Be6qqiz2SbyR+fxJrTh69PazrY4Su8I4gTUw7UG/A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 BN9PR12MB5338.namprd12.prod.outlook.com (2603:10b6:408:103::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Fri, 26 Jan
 2024 14:22:04 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::63ac:1dc1:e486:121f]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::63ac:1dc1:e486:121f%4]) with mapi id 15.20.7228.026; Fri, 26 Jan 2024
 14:22:04 +0000
From: Zi Yan <ziy@nvidia.com>
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 "\"Huang, Ying\"" <ying.huang@intel.com>,
 Ryan Roberts <ryan.roberts@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 "\"Matthew Wilcox (Oracle)\"" <willy@infradead.org>,
 David Hildenbrand <david@redhat.com>,
 "\"Yin, Fengwei\"" <fengwei.yin@intel.com>, Yu Zhao <yuzhao@google.com>,
 Vlastimil Babka <vbabka@suse.cz>,
 "\"Kirill A . Shutemov\"" <kirill.shutemov@linux.intel.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Kemeng Shi <shikemeng@huaweicloud.com>,
 Mel Gorman <mgorman@techsingularity.net>,
 Rohan Puri <rohan.puri15@gmail.com>, Mcgrof Chamberlain <mcgrof@kernel.org>,
 Adam Manzanares <a.manzanares@samsung.com>,
 "\"Vishal Moola (Oracle)\"" <vishal.moola@gmail.com>
Subject: Re: [PATCH v2 0/3] Enable >0 order folio memory compaction
Date: Fri, 26 Jan 2024 09:22:01 -0500
X-Mailer: MailMate (1.14r6018)
Message-ID: <D47A9ED8-E537-4D2E-82FD-8E6A77ED5024@nvidia.com>
In-Reply-To: <f7d7eb0a-2bb3-4ae0-9874-7b667f8a004c@linux.alibaba.com>
References: <20240123034636.1095672-1-zi.yan@sent.com>
 <f7d7eb0a-2bb3-4ae0-9874-7b667f8a004c@linux.alibaba.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_47FAB1F6-C989-4B85-903B-DFE8CAC71A9F_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BL1PR13CA0175.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::30) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5744:EE_|BN9PR12MB5338:EE_
X-MS-Office365-Filtering-Correlation-Id: a6b42c85-6bcc-4031-efa0-08dc1e7a2b33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	z0tt13YQYKUXFLny56khRTaELa6LX65uhRLJMmpYwOK/hFSYB+4l7tC1Ekqdh+nW212C4dOBqKEj5m3hzf+c9EUxox3PnQzQzKDdWnC6GnTi4/R2RM7w2JOBS9DWJBd3+G1nPOynrSi+37+srbn4te8Ti3hH95JRA3cMQysTZM25ivzukEWMZRB3LVfBiuZaVXoOSG8lUbgV/lLyTqArV9XEUOkTGpMi8Lg9uVnawa/6m5t36rw8wBxBOqENJJ1pW5ZnYIjUcpZFNWJe5/91TzqvJWZUHB4hvwJGLeiyWz9DlbzkejVOGEJdoo28WbAbFIgHPmI07ULqEXh74GQ6I3s4qGATDD+BIN8RrCxAZpUk7JfuwWBBbZ23G3QtYHkaeWLnXrqIbDfakNJs0zfo06RnQ9eQT7sWwC2dSvoM+OC6/g4xJGmjOVeWmAQRIAnovUzOMhJrFS3Ol5qFNfCJPuzxwaY1CYEhpextToD83x3vIos2L2ytP0k0jRPk2FJrVrwo7c+u6zJsBHgltuvjYbhTS2vh60DxNlRk9aqTP4i1dPUpw3R6jBfS+zPSL+6/FPAFI5RkwRBsmshruUcsDpQPjVqfOgZwMOMtQO5860RS+g6b/UnFxqm/Ny5qhmR3VapU9FehS+3oRK4oL+7G+wboiWx0r1dlEBiEu3rUfoQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(39860400002)(346002)(376002)(136003)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(83380400001)(2616005)(33964004)(53546011)(966005)(6506007)(6486002)(6666004)(26005)(6512007)(478600001)(66556008)(66946007)(6916009)(66476007)(316002)(54906003)(86362001)(38100700002)(8676002)(5660300002)(2906002)(30864003)(4326008)(36756003)(41300700001)(8936002)(235185007)(33656002)(7416002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eTdlTHFVRVU3R2FJdzhpdXI5eFNRUEMxbUZXWXJiQkMzcUtqYWVGSlN0Rk13?=
 =?utf-8?B?eTlPbVJPaFR2WEk2d3RHcFhNQS9TcjQ3TDRQQUlKR0o5MXJrVlVkQ3p5WEY5?=
 =?utf-8?B?UlBOVzc5ZmxnNmhzaXdXWDcweVQyR3hZbXQ1cXlCaEFKWWJ4S3hwU0NJalph?=
 =?utf-8?B?RlVwN3JyMFVzak5GdWxaRnZZM3BUNHJFK29MUEExZlNlaFdlMjdpZUwxZkRr?=
 =?utf-8?B?ZWZFUmVneEZTeXgxbmluYVlHUjAyQVNBZGFRSnhTUW5yY0JnKzRsTlpEb0ZG?=
 =?utf-8?B?d3kvTVVQeHJHZUhMNkFqSUpOLzlQZkxabVRSTTNQMXpVY0ZNZ0FWaVAwM2Fx?=
 =?utf-8?B?Q0l4aldSa2dWOGxyMHZxVHNTS2kwNGYzT2lhOWZBOVQxNjV3UDBEeDVYTzBv?=
 =?utf-8?B?RjJ6Q1MxbE1VY0QyMG82TnZmY3VwenY2Q2ZXQ1FEZUd6Y3dYakZaOTVEZFc4?=
 =?utf-8?B?bHRnZEl4YnUwU01ocVdmRGxjSVNMYTdnSk91Zkh1TFJsQmhRa1pnL1dFTmlN?=
 =?utf-8?B?R2ZldFVjWkx6SHBpa2RLS25NVnp1OGxPV3F0dmhGSjZIcHF3K1ZNUmhiYlZT?=
 =?utf-8?B?aHg5VG4ybVBLTjFCbFJXL040TXVOVHc5VjZBdlpKV3dOWlZSR0hjKytRTE5R?=
 =?utf-8?B?N25pVW52emp4MEtrcFJOdTZ6WWVUdy9UUE1nd3JWb2k4SGplV0EyN1JCTnph?=
 =?utf-8?B?SlI5NHlwbm5KZktJNEZ6U1NMWGVvOTg5UHk0bW5lR041ZTU3b3ZjSkdiRVJs?=
 =?utf-8?B?bVE5dXdWV2xjSzNGRzNmVE9yNkprZ2NveWhmUGtYYTVxRWZBZzh3MnVVV2l0?=
 =?utf-8?B?Q3RHSHJQZFA3UW1rMzRLdWN2ek9ndDh3S0Vkd3plZE9KWWQ0U2VUY0syV0hv?=
 =?utf-8?B?a3RWNW8yampGNTZOWVNKVy90UEYyZ3k4a1IwNitjVmxRcjN3QlYzb0lPTGRo?=
 =?utf-8?B?SGhJNXN3VHhEUFppekc5YnBwaGF3T0hRQlBiVGJFQWRpbllPUWZmWUJ0cTNO?=
 =?utf-8?B?Uk5BZjQrdGZRdG8rb0pKS3ZndlpwZlEwaTFsa2FpNTI0K1NRdGlpV3JiUWdR?=
 =?utf-8?B?aVZMbmlyZ3g5UFNmOVptQk96azg1ZlpJdlhzaG9PM1lqNHl4Y3ZyY2pVQzBS?=
 =?utf-8?B?WHBGcDkzS1ZHWFh0b21kM1BmdVE2U3VLQ0poYjlpSFEyeDlGYmdjclNrMDFy?=
 =?utf-8?B?WHdGNmFGbVJjRm5wbDl6NW5XR0tUdFpiR1BidGJkNzI2Vm91bS9DNVFreDNN?=
 =?utf-8?B?MElzR2k2QTdvK3NmRy9RWlViQUFIR21sOEd6anA0OTl2blV6YkxoVE9NS25S?=
 =?utf-8?B?QmM1eWg3eHpWVkpoc0FFR0RIeVNiWE03Ukl1VkFPMkNXOS95N1lGTVFqd0xs?=
 =?utf-8?B?dVBiT1AwNzRPZnl4OHlramJGMDFGVFUwU1hnWGtDUHl4N053RHNHcTV2cTRq?=
 =?utf-8?B?V25rbnVRN0VtSndMaTFBbnZ6Q1paSnRBZWZoV1M3aStVMWZFaUE1QzZaQTNC?=
 =?utf-8?B?ei9ZQzIxZGVvRE1tL3YzMWVlcGVqc3NZd3doRmtOSktQWDZ6LytCYVFIRUIr?=
 =?utf-8?B?Y3luZ3lYbW1raVRuSG9FOVVuckhpa1JkMVpTU3U2YnU5RVVoSlg1RjA3Q24v?=
 =?utf-8?B?ei81eU11R3VLeUJxMXcrd3NpYXFiUGFhb04zNHVxV1hUV2dkdjg3QmRxZW1H?=
 =?utf-8?B?U29rZmlvQVl2STV5N0RlaXJFUXZvOVpuQWZ2Z0lJZmk4eXJsdmdKTlVQUVA4?=
 =?utf-8?B?ZWM5eE1GWG54T1Fnci9SaGNUVFFGWFovNm1WZHpCeHBCS0ZIajcwNWV5VDVE?=
 =?utf-8?B?Wi8vcDA5THZqY0FBeUJ2czJCdDUwaHN0aGF5U1VMMU10ZTJrbzc3emZuRU5J?=
 =?utf-8?B?RDJtK2I5SkhPSUc2MWNEelZRVktpYUNQM2l1TnhVY0RUZDBweG5zRzlIWHJm?=
 =?utf-8?B?aElxWW91UFRwWkk5VTI4Z01TNnl6OWdqekl5UUJLcTlhT1hydHR3cTBjbjBC?=
 =?utf-8?B?SXkxL3RyUjIvQjNHSG1WakRrZXZncU5JRGlLclMvTFo0MEVIUVc2SE1KQWVP?=
 =?utf-8?B?UTNWN1ZueFNuQWpuYWFBc2dFdWY3SVBIcXBiU2M2VG82UFVVM2lCUlpMLzRF?=
 =?utf-8?Q?B+WLX5Ag4eETKpOXlh9EgwkLM?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6b42c85-6bcc-4031-efa0-08dc1e7a2b33
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2024 14:22:04.0862
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dw2vQO2nLnyrEaRYXNVF9meNUsJ2K+pUN1mugJRbOGGDQJIzR5P1LRFfWxTqZa1F
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5338

--=_MailMate_47FAB1F6-C989-4B85-903B-DFE8CAC71A9F_=
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 26 Jan 2024, at 4:03, Baolin Wang wrote:

> On 1/23/2024 11:46 AM, Zi Yan wrote:
>> From: Zi Yan <ziy@nvidia.com>
>>
>> Hi all,
>>
>> This patchset enables >0 order folio memory compaction, which is one o=
f
>> the prerequisitions for large folio support[1]. It is on top of
>> mm-everything-2024-01-18-22-21.
>>
>> I am aware of that split free pages is necessary for folio
>> migration in compaction, since if >0 order free pages are never split
>> and no order-0 free page is scanned, compaction will end prematurely d=
ue
>> to migration returns -ENOMEM. Free page split becomes a must instead o=
f
>> an optimization.
>>
>> Some applications from vm-scalability show different performance trend=
s
>> on default LRU and CONFIG_LRU_GEN from patch 1 (split folio during com=
paction),
>> to patch 2 (folio migration during compaction), to patch 3 (folio
>> migration during compaction with free page split). I am looking into i=
t.
>>
>> lkp ncompare results (with >5% delta) for default LRU and CONFIG_LRU_G=
EN are
>> shown at the bottom (on a 8-CPU (Intel Xeon E5-2650 v4 @ 2.20GHz) 16G =
VM).
>
> Overall, I haven't found any obvious issues, thanks for your work. Howe=
ver I got some percentage regression when running thpcompact on my machin=
e(16 cores and 120G memory) without enabling mTHP:
>                                  k6.8-rc1               k6.8-rc1-patche=
d
> Percentage huge-1        86.19 (   0.00%)       51.17 ( -40.63%)
> Percentage huge-3        93.64 (   0.00%)       42.48 ( -54.64%)
> Percentage huge-5        94.93 (   0.00%)       31.06 ( -67.28%)
> Percentage huge-7        95.40 (   0.00%)       19.09 ( -79.99%)
> Percentage huge-12       93.51 (   0.00%)       32.06 ( -65.71%)
> Percentage huge-18       83.02 (   0.00%)       54.58 ( -34.26%)
> Percentage huge-24       83.17 (   0.00%)       49.61 ( -40.35%)
> Percentage huge-30       96.69 (   0.00%)       59.82 ( -38.13%)
> Percentage huge-32       95.52 (   0.00%)       59.20 ( -38.03%)
>
> Ops Compaction stalls                 229710.00      554846.00
> Ops Compaction success                144177.00        9351.00
> Ops Compaction failures                85533.00      545495.00
> Ops Compaction efficiency                 62.76           1.69
> Ops Page migrate success            60333689.00    11687573.00
> Ops Page migrate failure               25818.00      459621.00
> Ops Compaction pages isolated      127723211.00   224420997.00
> Ops Compaction migrate scanned     142498744.00   173345194.00
> Ops Compaction free scanned       1159752360.00   624633726.00
> Ops Compact scan efficiency               12.29          27.75
> Ops Compaction cost                    66050.96       17615.55
>
> I did not have time to analyze this issue, just providing you some test=
 information. And I will measure the compaction efficiency of mTHP if I f=
ind some time.

Thanks a lot. These are useful numbers. I can see that the number of
migration failures doubled and only ~1/5 of successes. I will use
thpcompact to look into the issues.


>
>>  From V1 [2]:
>> 1. Used folio_test_large() instead of folio_order() > 0. (per Matthew
>> Wilcox)
>>
>> 2. Fixed code rebase error. (per Baolin Wang)
>>
>> 3. Used list_split_init() instead of list_split(). (per Ryan Boberts)
>>
>> 4. Added free_pages_prepare_fpi_none() to avoid duplicate free page co=
de
>> in compaction_free().
>>
>> 5. Dropped source page order sorting patch.
>>
>>  From RFC [1]:
>> 1. Enabled >0 order folio compaction in the first patch by splitting a=
ll
>> to-be-migrated folios. (per Huang, Ying)
>>
>> 2. Stopped isolating compound pages with order greater than cc->order
>> to avoid wasting effort, since cc->order gives a hint that no free pag=
es
>> with order greater than it exist, thus migrating the compound pages wi=
ll fail.
>> (per Baolin Wang)
>>
>> 3. Retained the folio check within lru lock. (per Baolin Wang)
>>
>> 4. Made isolate_freepages_block() generate order-sorted multi lists.
>> (per Johannes Weiner)
>>
>> Overview
>> =3D=3D=3D
>>
>> To support >0 order folio compaction, the patchset changes how free pa=
ges used
>> for migration are kept during compaction. Free pages used to be split =
into
>> order-0 pages that are post allocation processed (i.e., PageBuddy flag=
 cleared,
>> page order stored in page->private is zeroed, and page reference is se=
t to 1).
>> Now all free pages are kept in a MAX_ORDER+1 array of page lists based=

>> on their order without post allocation process. When migrate_pages() a=
sks for
>> a new page, one of the free pages, based on the requested page order, =
is
>> then processed and given out.
>>
>>
>> Feel free to give comments and ask questions.
>>
>> Thanks.
>>
>> [1] https://lore.kernel.org/linux-mm/20230912162815.440749-1-zi.yan@se=
nt.com/
>> [2] https://lore.kernel.org/linux-mm/20231113170157.280181-1-zi.yan@se=
nt.com/
>>
>> vm-scalability results on CONFIG_LRU_GEN
>> =3D=3D=3D
>>
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> compiler/kconfig/rootfs/runtime/tbox_group/test/testcase:
>>    gcc-13/defconfig/debian/300s/qemu-vm/small-allocs/vm-scalability
>>
>> commit:
>>    6.7.0-rc4+
>>    6.7.0-rc4-split-folio-in-compaction+
>>    6.7.0-rc4-folio-migration-in-compaction+
>>    6.7.0-rc4-folio-migration-free-page-split+
>>
>>        6.7.0-rc4+ 6.7.0-rc4-split-folio-in-co 6.7.0-rc4-folio-migratio=
n-i 6.7.0-rc4-folio-migration-f
>> ---------------- --------------------------- -------------------------=
-- ---------------------------
>>           %stddev     %change         %stddev     %change         %std=
dev     %change         %stddev
>>               \          |                \          |                =
\          |                \
>>     2024326           +35.5%    2743772 =C2=B1 41%    +364.0%    93921=
98 =C2=B1 35%     +31.0%    2651634        vm-scalability.throughput
>>
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> compiler/kconfig/rootfs/runtime/tbox_group/test/testcase:
>>    gcc-13/defconfig/debian/300s/qemu-vm/small-allocs-mt/vm-scalability=

>>
>> commit:
>>    6.7.0-rc4+
>>    6.7.0-rc4-split-folio-in-compaction+
>>    6.7.0-rc4-folio-migration-in-compaction+
>>    6.7.0-rc4-folio-migration-free-page-split+
>>
>>        6.7.0-rc4+ 6.7.0-rc4-split-folio-in-co 6.7.0-rc4-folio-migratio=
n-i 6.7.0-rc4-folio-migration-f
>> ---------------- --------------------------- -------------------------=
-- ---------------------------
>>           %stddev     %change         %stddev     %change         %std=
dev     %change         %stddev
>>               \          |                \          |                =
\          |                \
>>     1450189            +0.9%    1463418           +30.4%    1891610 =C2=
=B1 22%      +0.3%    1454100        vm-scalability.throughput
>>
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> compiler/kconfig/rootfs/runtime/tbox_group/test/testcase:
>>    gcc-13/defconfig/debian/300s/qemu-vm/mmap-xread-seq-mt/vm-scalabili=
ty
>>
>> commit:
>>    6.7.0-rc4+
>>    6.7.0-rc4-split-folio-in-compaction+
>>    6.7.0-rc4-folio-migration-in-compaction+
>>    6.7.0-rc4-folio-migration-free-page-split+
>>
>>        6.7.0-rc4+ 6.7.0-rc4-split-folio-in-co 6.7.0-rc4-folio-migratio=
n-i 6.7.0-rc4-folio-migration-f
>> ---------------- --------------------------- -------------------------=
-- ---------------------------
>>           %stddev     %change         %stddev     %change         %std=
dev     %change         %stddev
>>               \          |                \          |                =
\          |                \
>>    14428848 =C2=B1 27%     -51.7%    6963308 =C2=B1 73%     +13.5%   1=
6372621           +11.2%   16046511        vm-scalability.throughput
>>
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> compiler/kconfig/rootfs/runtime/tbox_group/test/testcase:
>>    gcc-13/defconfig/debian/300s/qemu-vm/mmap-pread-seq/vm-scalability
>>
>> commit:
>>    6.7.0-rc4+
>>    6.7.0-rc4-split-folio-in-compaction+
>>    6.7.0-rc4-folio-migration-in-compaction+
>>    6.7.0-rc4-folio-migration-free-page-split+
>>
>>        6.7.0-rc4+ 6.7.0-rc4-split-folio-in-co 6.7.0-rc4-folio-migratio=
n-i 6.7.0-rc4-folio-migration-f
>> ---------------- --------------------------- -------------------------=
-- ---------------------------
>>           %stddev     %change         %stddev     %change         %std=
dev     %change         %stddev
>>               \          |                \          |                =
\          |                \
>>    13569502 =C2=B1 24%     -45.9%    7340064 =C2=B1 59%     +12.3%   1=
5240531           +10.4%   14983705        vm-scalability.throughput
>>
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> compiler/kconfig/rootfs/runtime/tbox_group/test/testcase:
>>    gcc-13/defconfig/debian/300s/qemu-vm/mmap-pread-seq-mt/vm-scalabili=
ty
>>
>> commit:
>>    6.7.0-rc4+
>>    6.7.0-rc4-split-folio-in-compaction+
>>    6.7.0-rc4-folio-migration-in-compaction+
>>    6.7.0-rc4-folio-migration-free-page-split+
>>
>>        6.7.0-rc4+ 6.7.0-rc4-split-folio-in-co 6.7.0-rc4-folio-migratio=
n-i 6.7.0-rc4-folio-migration-f
>> ---------------- --------------------------- -------------------------=
-- ---------------------------
>>           %stddev     %change         %stddev     %change         %std=
dev     %change         %stddev
>>               \          |                \          |                =
\          |                \
>>    13305823 =C2=B1 24%     -45.1%    7299664 =C2=B1 56%     +12.5%   1=
4974725           +10.4%   14695963        vm-scalability.throughput
>>
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> compiler/kconfig/rootfs/runtime/tbox_group/test/testcase:
>>    gcc-13/defconfig/debian/300s/qemu-vm/lru-file-readtwice/vm-scalabil=
ity
>>
>> commit:
>>    6.7.0-rc4+
>>    6.7.0-rc4-split-folio-in-compaction+
>>    6.7.0-rc4-folio-migration-in-compaction+
>>    6.7.0-rc4-folio-migration-free-page-split+
>>
>>        6.7.0-rc4+ 6.7.0-rc4-split-folio-in-co 6.7.0-rc4-folio-migratio=
n-i 6.7.0-rc4-folio-migration-f
>> ---------------- --------------------------- -------------------------=
-- ---------------------------
>>           %stddev     %change         %stddev     %change         %std=
dev     %change         %stddev
>>               \          |                \          |                =
\          |                \
>>    13244376 =C2=B1 28%     +54.2%   20425838 =C2=B1 23%      -4.4%   1=
2660113 =C2=B1  3%      -9.0%   12045809 =C2=B1  3%  vm-scalability.throu=
ghput
>>
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> compiler/kconfig/rootfs/runtime/tbox_group/test/testcase:
>>    gcc-13/defconfig/debian/300s/qemu-vm/lru-file-mmap-read/vm-scalabil=
ity
>>
>> commit:
>>    6.7.0-rc4+
>>    6.7.0-rc4-split-folio-in-compaction+
>>    6.7.0-rc4-folio-migration-in-compaction+
>>    6.7.0-rc4-folio-migration-free-page-split+
>>
>>        6.7.0-rc4+ 6.7.0-rc4-split-folio-in-co 6.7.0-rc4-folio-migratio=
n-i 6.7.0-rc4-folio-migration-f
>> ---------------- --------------------------- -------------------------=
-- ---------------------------
>>           %stddev     %change         %stddev     %change         %std=
dev     %change         %stddev
>>               \          |                \          |                =
\          |                \
>>     7021425 =C2=B1 11%     -20.9%    5556751 =C2=B1 19%     +14.8%    =
8057811 =C2=B1  3%      +9.4%    7678613 =C2=B1  4%  vm-scalability.throu=
ghput
>>
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> compiler/kconfig/rootfs/runtime/size/tbox_group/test/testcase:
>>    gcc-13/defconfig/debian/300s/256G/qemu-vm/msync/vm-scalability
>>
>> commit:
>>    6.7.0-rc4+
>>    6.7.0-rc4-split-folio-in-compaction+
>>    6.7.0-rc4-folio-migration-in-compaction+
>>    6.7.0-rc4-folio-migration-free-page-split+
>>
>>        6.7.0-rc4+ 6.7.0-rc4-split-folio-in-co 6.7.0-rc4-folio-migratio=
n-i 6.7.0-rc4-folio-migration-f
>> ---------------- --------------------------- -------------------------=
-- ---------------------------
>>           %stddev     %change         %stddev     %change         %std=
dev     %change         %stddev
>>               \          |                \          |                =
\          |                \
>>     1208994 =C2=B1137%    +263.5%    4394683 =C2=B1 49%     -49.4%    =
 611204 =C2=B1  6%     -48.1%     627937 =C2=B1 13%  vm-scalability.throu=
ghput
>>
>>
>>
>> vm-scalability results on default LRU (with -no-mglru suffix)
>> =3D=3D=3D
>>
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> compiler/kconfig/rootfs/runtime/tbox_group/test/testcase:
>>    gcc-13/defconfig/debian/300s/qemu-vm/lru-file-readtwice/vm-scalabil=
ity
>>
>> commit:
>>    6.7.0-rc4-no-mglru+
>>    6.7.0-rc4-split-folio-in-compaction-no-mglru+
>>    6.7.0-rc4-folio-migration-in-compaction-no-mglru+
>>    6.7.0-rc4-folio-migration-free-page-split-no-mglru+
>>
>> 6.7.0-rc4-no-mgl 6.7.0-rc4-split-folio-in-co 6.7.0-rc4-folio-migration=
-i 6.7.0-rc4-folio-migration-f
>> ---------------- --------------------------- -------------------------=
-- ---------------------------
>>           %stddev     %change         %stddev     %change         %std=
dev     %change         %stddev
>>               \          |                \          |                =
\          |                \
>>     8412072 =C2=B1  3%     +32.1%   11114537 =C2=B1 41%      +3.5%    =
8703491 =C2=B1  3%      +1.5%    8536343 =C2=B1  3%  vm-scalability.throu=
ghput
>>
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> compiler/kconfig/rootfs/runtime/tbox_group/test/testcase:
>>    gcc-13/defconfig/debian/300s/qemu-vm/lru-file-mmap-read/vm-scalabil=
ity
>>
>> commit:
>>    6.7.0-rc4-no-mglru+
>>    6.7.0-rc4-split-folio-in-compaction-no-mglru+
>>    6.7.0-rc4-folio-migration-in-compaction-no-mglru+
>>    6.7.0-rc4-folio-migration-free-page-split-no-mglru+
>>
>> 6.7.0-rc4-no-mgl 6.7.0-rc4-split-folio-in-co 6.7.0-rc4-folio-migration=
-i 6.7.0-rc4-folio-migration-f
>> ---------------- --------------------------- -------------------------=
-- ---------------------------
>>           %stddev     %change         %stddev     %change         %std=
dev     %change         %stddev
>>               \          |                \          |                =
\          |                \
>>     7095358           +10.8%    7863635 =C2=B1 16%      +5.5%    74841=
10            +1.5%    7200666 =C2=B1  4%  vm-scalability.throughput
>>
>>
>> Zi Yan (3):
>>    mm/compaction: enable compacting >0 order folios.
>>    mm/compaction: add support for >0 order folio memory compaction.
>>    mm/compaction: optimize >0 order folio compaction with free page
>>      split.
>>
>>   mm/compaction.c | 218 ++++++++++++++++++++++++++++++++++------------=
--
>>   mm/internal.h   |   9 +-
>>   mm/page_alloc.c |   6 ++
>>   3 files changed, 169 insertions(+), 64 deletions(-)
>>


--
Best Regards,
Yan, Zi

--=_MailMate_47FAB1F6-C989-4B85-903B-DFE8CAC71A9F_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmWzwAkPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhU230P/1PKWVU59o1oqC/ID7sRPvzWPV3fjx9hnD4v
93OO+l++5/4mLnPkNzqz1z+T3bgCZUCx40fMmEG/t1rEV8EWr5TUjeW/dro2ZnmR
MdNwMJRJ7zWecaJILQ1omKsKLYyb0PqctD2KIzpKkdL1YEdM+d81Gi71Ec6pHNsc
7dD4uKU/vW54HwkqH3r2PMfr4lsSoeaEkPmsvHzkMd3E30p1jgfKlqKaN39sW9tE
/1tFZsv0C1CkqSasN2Ns2TKOzkD0AVkB3+49mfcZvtxuZffOnvV9curDDc2anz1C
ibKVtRoFjpLkkJKMbeCsUOS2JpxzoyfqBcj0P+IDStQD7H2+HuN1/2QIBXbQ9mz/
3nIwQNwG2z+aXkKpnx2FgR/klT67rOCcCNUUQA4UiIk228cWRNtgol+0GP0HmX31
Ek9EUBVPe/OW3Thkg8uLx2uV0zMZfqFmfz8/2v4NufZl+cDOOfU4HVnk9JugaRiT
MOe3Cpkb2jBfxXLCFCrcvSw52ATYSh1owCD1twR184+oSQ7TJEKEZmyV2qnHTrG4
6C1qH6tzahG96mo1Cq+8YR2Yd25HySnGZJvDXjKgOCN6ywGoIDshz9ygA4PPKpzf
SJWFGy6KgskdKkXnimF8ml+PGBhFWJsjt5kY6DuTBeXPb82pnuwRWxFc0Dtu9oJZ
8Au5olKp
=cTN6
-----END PGP SIGNATURE-----

--=_MailMate_47FAB1F6-C989-4B85-903B-DFE8CAC71A9F_=--

