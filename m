Return-Path: <linux-kernel+bounces-342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26590813FB9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 03:27:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A9CEB21846
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 02:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 763025692;
	Fri, 15 Dec 2023 02:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MfmYIxjU"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC38566C
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 02:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702607253; x=1734143253;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=w40oMiM8HvxOsbD7iatE1wVOY0HtTP2Fue7xs+msWrk=;
  b=MfmYIxjUovWG70vLr86sKBAO0n+9zhcuyHWUQRDHK+cjYuN5JS7eIN/W
   55gQgj3vTk3ScRstQrcdynPxfnjPc+fuy0ob1QaYPdz+RDOi8VDDZgZyQ
   A4ZSMf1Zkde+y2hRKe1yI9+RE5dSqIioQnn/HiAVAk1LKtPpNGHewoKqW
   QyBTZgqJ3DCfhFo4IsuNOpVhwl5cXjJjtUMHxH+XhX0dtAsxq8/VWlrrf
   XDK9Dva04ZQurqYOh4cpUcLZ1XZRcLUK/g550bND3kGfm3TsKwwQwzFcz
   p1SmAEAdryQ0MmVk+Y4OP/FRHQo3O44mzoL0LlZ77ewqnjgBQP9KAiK6b
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="392396246"
X-IronPort-AV: E=Sophos;i="6.04,277,1695711600"; 
   d="scan'208";a="392396246"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 18:27:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="1021784952"
X-IronPort-AV: E=Sophos;i="6.04,277,1695711600"; 
   d="scan'208";a="1021784952"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Dec 2023 18:27:28 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 14 Dec 2023 18:27:28 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 14 Dec 2023 18:27:27 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 14 Dec 2023 18:27:27 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 14 Dec 2023 18:27:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SyONV3pJ6g8GdoNBdKGuDTgC0ntOh8P7cknmk0/v7VGApmdfD7ipW6S0xVSF5HYU8wVuEdlw/Z2E9kgzjDZrrlQXTiHKC+q+r/0O2MiRB1rI7d/XWzieN3JwjlyfdHd2Kxc1AujxmRgspgGINcyXj9D3X6ys6HtSi1QIQIXt4/b2/uuAROfB2LZAGEnvQcsdilUtCoU9zyAGvWRVkY0mGRbYHJczz2Pqa3Xm+XnbE8OJ2FdHmXSi+eN+tq+h2FIuOvYjDppYgZpOAJ+kdwauh/JVdnSSje9a6gFchz18pGk98EfxzQgrNH6gBR5Nku0x5/5CjVcV1q1cQiBhpxnh2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pNVBU0M5h30ljDTcWRScfWgLj65SUItsu3gOavCi2E4=;
 b=eJY19hp1/c+5SQYzeBuppCmZg800VWTN0k6kMAfCxEmq9xXAYJal599ks5VdHdY//fqYi8ac15QtPj0erb9vb915+lkQ0DYSBztvUz9xSDlsJyZpMIaqAT6UF84UZIMeviYqRWdDSwNH4WCT2RTzgF7oepAnMr0qs19QAUethIriF9PGAqDkVcK/G1ZJsHuD3jzzkKJNSaIapfJ5RpBdPlmW274LKRAk521RgnTDbD0lbAwJjgzaaM5hup2Erb79XASxO4iiI0ZXtVf23DZZLlsQh6KmqLDPMlDBO0eXRpWnElHwLF494pggEO1Z9jxqNj/byKNizmEvHnBZ5LX6hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by SN7PR11MB7017.namprd11.prod.outlook.com (2603:10b6:806:2ac::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Fri, 15 Dec
 2023 02:27:18 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::3d83:82ce:9f3b:7e20]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::3d83:82ce:9f3b:7e20%5]) with mapi id 15.20.7091.028; Fri, 15 Dec 2023
 02:27:18 +0000
Message-ID: <3bc7d3b5-7b15-4b14-ab2b-20968249818a@intel.com>
Date: Fri, 15 Dec 2023 10:27:15 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 15/39] mm/huge_memory: batch rmap operations in
 __split_huge_pmd_locked()
Content-Language: en-US
To: David Hildenbrand <david@redhat.com>, <linux-kernel@vger.kernel.org>
CC: <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>, "Matthew
 Wilcox (Oracle)" <willy@infradead.org>, Hugh Dickins <hughd@google.com>, Ryan
 Roberts <ryan.roberts@arm.com>, Mike Kravetz <mike.kravetz@oracle.com>,
	Muchun Song <muchun.song@linux.dev>, Peter Xu <peterx@redhat.com>
References: <20231211155652.131054-1-david@redhat.com>
 <20231211155652.131054-16-david@redhat.com>
From: "Yin, Fengwei" <fengwei.yin@intel.com>
In-Reply-To: <20231211155652.131054-16-david@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0043.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::19) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|SN7PR11MB7017:EE_
X-MS-Office365-Filtering-Correlation-Id: 99f97810-6d92-443c-c7e7-08dbfd155c11
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Vd87UX7fq2RjroYFqd5VGOlwCFTjCB7EmyoXP2/R0eyPqRoDzV4gGJHxJFWOd5vpW9AAJEYqLJeuuWSycPVZ/sdzaXa5LJsVeoFy+YsabjWZHa3+RT+OfnFtOkIXZG8j9QVTAQ7FpuqZKMu0Zi2qqaubEJSQYzp1SzTCV8gPQOBFWimlY2L+Irzbbhsek2pyP8QS3MGy/a+dU5DlVqwe4ANHcbwqBxxYqZIrTRAMobORLwRjs30PABgT9qRVtmOHBVmPCtsXCYd8AZT/g6TrGekPtNDHlxTfv2+VF0dIdk0qIHZImqtQnwyFux+fDFgIRU2AuyaFKvIwAlWxwWsuOdsy29Ru5SQEae86ax4OVGBqRlRzU2cruBR1WctzjQoSzwBDkTk+L7ax3XTjCNKL2X7kDU7Fnil26GRcyr9kyNSIIYTXcwlPgfcbvc8Ylov90oqCArK2zQ+EdDgCuYadH6JStgdJP69umGqgQbUmUQRS/BE1G/qFykzFFlUCVdQuxU/4E4JCjHQDFoyqTChM+pTwZySGaR4PwjCYzcSrQ4KoGSWwWGBi9pgI/NV7F4Wzi61h+Xo7uA95z+cBpsA7YpDnr9zg4cyvix39keqQRvqQgjY0Q48OiIMLILCE0wopU7H43IbN5rnBWCv1csK+VrHpCZ70HwdZ7bo3acVk3uo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(136003)(396003)(346002)(376002)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(54906003)(478600001)(6486002)(6506007)(7416002)(5660300002)(2616005)(26005)(66946007)(66476007)(66556008)(6512007)(6666004)(31686004)(53546011)(316002)(8676002)(8936002)(4326008)(2906002)(86362001)(31696002)(41300700001)(82960400001)(4744005)(38100700002)(36756003)(14583001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R3NoS3FPejdDWWZ2MTJGdkI2ajYxTkN4VHF5QldPSTBqMnRrNG14dTFFS1g1?=
 =?utf-8?B?VVZibndRY1ZuS3cxNDR0SjZkekRhWHhxcDFoMTVOTWYxYjJ1OG9EdmdZekkw?=
 =?utf-8?B?OWMycGZQTzF0aG5laGEwemdpb0FtSDMrL0Z1K3ZmZ3BSd285WmNqQ1JIS0Iw?=
 =?utf-8?B?MUNCbnRFejBkek51dFFiOFpPRnFzclNHNUxOcHU3by9OY2Ewa3JXcGJValdZ?=
 =?utf-8?B?MGhPbWV6WEZ0Q3l3YzE1eXBTRFpKWXhGbkl2Y1V6b3JLdC9XSWRxaFdEdnZv?=
 =?utf-8?B?blZ4RUEyRzZLRGhhMVVaZkcxVmFqNFdxVmhiRGZTc1lEWXB4Rjk0QTJaRUVE?=
 =?utf-8?B?ZzB2cVY1SU1Xa0lMMU5Za0dram55UVlQYVZpdzNHNHd0S0JkTG1xS0dKMm8x?=
 =?utf-8?B?S3dFNDRLOFdOQ2lLRFYxNHU3OFdMR0xTUGZMR3hFN0I3akdiZDB0S2lFNDRK?=
 =?utf-8?B?aEdMYjBSSHFzYjVpMEgrSW5sYWhvREozUk1rWHpJN0xyM2E2bU12c1VSZnVE?=
 =?utf-8?B?V0tlZ2lqYkRUcWtUUGR1S01IdkRzRlNEOStUT2YvL0gxVFlCOWJDRVdmMVh4?=
 =?utf-8?B?WENkVlRJanhIVDlRNy9JbzcweFcyZGZOeEJLSTJCZmJ5QUozZkY5Yjhhc09U?=
 =?utf-8?B?dlkrbjMyY05LWFVuYjk3NWtXcHVGWnRyb0ZDV1E0YnhIazRTdE9iYUhxcE5o?=
 =?utf-8?B?Z3lXaHhVTGZvMERsOTNvckRXRVk5M25nVGZaMElqOTVhSXNzR0hiMkFUdCt0?=
 =?utf-8?B?b0xPemFueEl1di9YaHVWb01XNmxzREF6eEZuZzNaTEFJTlRCUnhMOTlSNGpl?=
 =?utf-8?B?S2VqTm1ldkZmdWlTK252RHJucVlhdVJxS1k5cmpPL0FYSTdnczhxZkZGRVJI?=
 =?utf-8?B?c3Y0VlJndDZDT3VRbFFhM3FlTkxmTDA5Q1BHNTB0MmluUkkya1RaYnp3WXY2?=
 =?utf-8?B?R3BSUHM0c2VOMzg0S0NrYXRXY2FZYWRjdUxYM0hoeElJaUQ1MjNTOTBXeTc3?=
 =?utf-8?B?YngzR1FmQmpRd3l1SHlzMzY5Q1dCeUVFUm1xOWFyWGwwc095Ym5XVldhSmsr?=
 =?utf-8?B?djJyYy93eG13OXQvUTZZaUR0Q2FETWNvTWlXMHpMYlJCK1BZam5lbFAvR2Uz?=
 =?utf-8?B?c1Y3cERXTjdBazVXV0dTRlZod3FBVGRENHZta2NsZ3E4RjJJWmZYQm9wVENN?=
 =?utf-8?B?U1AzUmMwWjR6bTRnY3Y5YUNQaS9HM2JYdFdFVldyWUpMa0NHV2Z2YTJSV24z?=
 =?utf-8?B?RnRLRXVZM0RscmRvaVVnb01wNDFhbGZYM3RLbUJpelhFTjQ2b0pmU3FYUlhZ?=
 =?utf-8?B?VkVXVnU4djgxejArREJFTFV2d2h1MVNFWGRiR1ZnTEoxSzVUNDNjb01naitR?=
 =?utf-8?B?T1RHdkRjZ2U2TnUwUVNBKzI5N0FoMlBzZ0pWSld1SVJnTnBLNW50UFFzbjkv?=
 =?utf-8?B?UktPY3lKdG9BdGYrVGpDcnBVbHJvdVoydmdobEJGSFpENytnRlhwZ2FJQmNv?=
 =?utf-8?B?bmtQdGsycTRKQmU0Z1ZkaXIwN2NhSnNseG94a0dtUmZpc1VEelg2OTRVblMr?=
 =?utf-8?B?ZG1WMG5RM1dOaElGM1Zqa0NtV2E3NnI3bEZwMmR1M2dBL0NudjVLdEduN0ps?=
 =?utf-8?B?UloyQmk3Zk5hU2VXSjdvQ2lXalFqOW1lV0dSVVRXVFFUSnJsUXFwb1BlQzA1?=
 =?utf-8?B?MHFPcVhXdnYrOEd0TkRMVTN2ckVTVmU3ZS9aQnZOYlIxeDNzNUlXR2piL09V?=
 =?utf-8?B?V3FGeXlaczJRUGtMbHFxKzBmWU0xY2ZJdjZkR21ENEFOcHNYY3ZTWEN1MzFS?=
 =?utf-8?B?QWlYcjJheGVWajFjSHRyUU9HbVlCQkhuLzBBOHBFa3JwRUVWNHIxYlcrRzJ6?=
 =?utf-8?B?OGdITDcwdFhXSHdUUlRYK2FaMVhVWlpXeWRwZHljUmQyYWZkaGJyaGMyOTRN?=
 =?utf-8?B?WVd2QVRJTDBPY1JCcGErQ1c1Z0VBUlhrZ2NnckN0bTNSNUczWGdtOFdpWU1P?=
 =?utf-8?B?T0VrWkZlQVZoQnNZNEtZdTRORkJVMW9aendYajFqS0p6bWQ2enBUb2k3RVVu?=
 =?utf-8?B?UFpYY0FKK1hTcHhieFBiL3VabDdHSHRtK3EyS003ZWlvNnZYbVdaNzE3NHU0?=
 =?utf-8?Q?vWopvejxGUcBUn3Cp21kCbT6E?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 99f97810-6d92-443c-c7e7-08dbfd155c11
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2023 02:27:18.6410
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QXa/vpR9M4W3jnxVvM0pE+ceSxCNVuNvNnbaI83XXqXCYhUjIqTho5FDbI8GR73s95tYWsNVmC+gwXwRpDITQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7017
X-OriginatorOrg: intel.com



On 12/11/2023 11:56 PM, David Hildenbrand wrote:
> Let's use folio_add_anon_rmap_ptes(), batching the rmap operations.
> 
> While at it, use more folio operations (but only in the code branch we're
> touching), use VM_WARN_ON_FOLIO(), and pass RMAP_EXCLUSIVE instead of
> manually setting PageAnonExclusive.
> 
> We should never see non-anon pages on that branch: otherwise, the
> existing page_add_anon_rmap() call would have been flawed already.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Yin Fengwei <fengwei.yin@intel.com>

