Return-Path: <linux-kernel+bounces-370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F77C81401D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 03:44:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BD581F22EC7
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 02:44:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC333FC0E;
	Fri, 15 Dec 2023 02:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hYWgICcv"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99ABBCA71
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 02:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702607990; x=1734143990;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=w40oMiM8HvxOsbD7iatE1wVOY0HtTP2Fue7xs+msWrk=;
  b=hYWgICcvdjT/gtkW7s3rRuzSbPou4/18JNVqjXAijtIVt294A2wWfbuC
   NqbAFjoPBNKfIhBDVaUsfyZqPv2YLi0DsOT/Rkul7UJTaPHTahwxLPCMU
   H2ywDqYeWN0OpalKPHAdN9EIgdVoLdI7Md49MfjdbqgXiIoau0s2DoDbE
   P5Zyh9K9C+vlcnIaJjxrQD8mGk/2qFGEDanVX8PkifTNPQM+Tbpy0dJFu
   mws0d/xMIfnE0gS4kQbeRRXpmk01k1SjzWS4jyySPLubA/ekg9U8dZikg
   nAktL4D2ouJwaPQ6lfkFnm0VlRT1S2L6+YNVmiZuYWc8vX6qg3jMkLLx5
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="2309714"
X-IronPort-AV: E=Sophos;i="6.04,277,1695711600"; 
   d="scan'208";a="2309714"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 18:39:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="803551515"
X-IronPort-AV: E=Sophos;i="6.04,277,1695711600"; 
   d="scan'208";a="803551515"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Dec 2023 18:39:49 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 14 Dec 2023 18:39:49 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 14 Dec 2023 18:39:49 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 14 Dec 2023 18:39:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VX1LMTDkXn5qxngGkUVT26dBn7qVnd7wLCCWRFs1J6pC0EshraE4lNKB+VZ/iauskBuA14RLkKtrUiUqGE92FgxWS6oFWboX6X1Ivy3cA6XHlPNq9eXnwS2jCIWL1PJFN8+V/gbWJyGyiBZoz/wJF3bfbXD8vvS7q/N7Vp/JzME/KsFXzn88SJwnqcKhnkeJzwrPz2dtMtm9ern/eKgHiXwEayH+FJCaDymBjaEfEWqD5kmUkzHMvYvSMvPJ0RuX3r856YEKUbQuE4XE4jBYmx1YC/xZj8CDWf/XodKbZ2ZSj8CvZOlDbSPGrfe1kHYQAf1VmqoSanFhRo9YBBA3AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pNVBU0M5h30ljDTcWRScfWgLj65SUItsu3gOavCi2E4=;
 b=bkVhna/RSp7hkpxnpHdTWIt3uTw8YDM1RAPNP84gBd31qhRpYRNmtCVFeeIZAQOR7hvRWj7V0nXzb0tQBZY2Ky1y9mCMr7kAgZe9hQNmsCioxAg6kVg2SiLIAgE/FKhIyTYiPY8G6lHqa+roBOoEimoTtZaW4lfTl96XC7OjND9FlbgoCxk2WzgGtGrutQaSHHWo/bWNhsnRe9fq4ovu2yRnD6LG99NdbHOUyRzYPNjJKSTdkPZXyOFtEbJBjPs3gFtta7RcLf9IxE9kYLOd368zLlE8Es2VfabkVm+MbjR76ePyflRjwRxEHvvN7vqbxJVwuMQvvl4naME/6ckWcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4820.namprd11.prod.outlook.com (2603:10b6:303:6f::8)
 by PH7PR11MB6931.namprd11.prod.outlook.com (2603:10b6:510:206::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Fri, 15 Dec
 2023 02:39:45 +0000
Received: from CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::3d83:82ce:9f3b:7e20]) by CO1PR11MB4820.namprd11.prod.outlook.com
 ([fe80::3d83:82ce:9f3b:7e20%5]) with mapi id 15.20.7091.028; Fri, 15 Dec 2023
 02:39:45 +0000
Message-ID: <91288e11-0d92-4b69-b792-e83456e1752f@intel.com>
Date: Fri, 15 Dec 2023 10:39:38 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 15/39] mm/huge_memory: batch rmap operations in
 __split_huge_pmd_locked()
Content-Language: en-US
To: David Hildenbrand <david@redhat.com>, <linux-kernel@vger.kernel.org>
CC: <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>, "Matthew
 Wilcox (Oracle)" <willy@infradead.org>, Hugh Dickins <hughd@google.com>,
	"Ryan Roberts" <ryan.roberts@arm.com>, Mike Kravetz
	<mike.kravetz@oracle.com>, Muchun Song <muchun.song@linux.dev>, Peter Xu
	<peterx@redhat.com>
References: <20231211155652.131054-1-david@redhat.com>
 <20231211155652.131054-16-david@redhat.com>
From: "Yin, Fengwei" <fengwei.yin@intel.com>
In-Reply-To: <20231211155652.131054-16-david@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0059.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::19) To CO1PR11MB4820.namprd11.prod.outlook.com
 (2603:10b6:303:6f::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4820:EE_|PH7PR11MB6931:EE_
X-MS-Office365-Filtering-Correlation-Id: 94913a52-59fb-484c-091c-08dbfd171910
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 94F2kHyFiQPapjTfcn9AC+MBKN8cN6rWMF4bt/4UT0BOV6ERfdMr0MWL05LErfY+jd1lDV7EPM2LZ3lzR67P04g/DQQvopXgbqZZud8jCkzAstEh+THApbgaqQT2Fzcm5Sts3h/FeHyZYI09271HChxurwS+C1drjyhtv0h9H8g+9U5Zo6fHulz0dt0yG+U1WVdBaN5/0vxP1AS44NwhnEhtuIgmdB5jioD39WWJ1UTnRasduaJ05dJCazvPpkgs+UJBCLb7/PHRUWelI8poC36Nj/uxSTJa16Jj2GUu3kh8e0HCk8ehxvHazNBhHa4P4C0ju8X9TcgVAd91Nh4lU/u0Gq8uINZzhhn4zTUjFso5YbpDJJ0yyzYBHXRq5sjeOt94sKOSMtxP7UrQ3C1M9KW49syAXiWBZsT4rT+F8Py+G/h0J8nN2wdla3SyHdLnqcPMeS8O8aLT0Yrop6PkJhB5ZIq7TvaeRs7TkXfbcWBT5Ty8Ak9me3zlYjOBqR2kPZeGsFEYGEBhd8+y92qToIzNZNoGGVPqvH92ez+BdbJ6ZNe3hth0jtm8qhdU6xEQJWpmirPPOQpYPeDCk6XDzp8W2e5/fXgUw7lEBf2rpNme2HyaUP0FaEO+VLZfTCI4lGO1huw4XLagcqLJgdbWoOKYJ1U0GaCk/1A3ZIdRjP8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4820.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(366004)(346002)(39860400002)(136003)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(6666004)(478600001)(6486002)(82960400001)(4744005)(38100700002)(31686004)(26005)(2616005)(6512007)(6506007)(53546011)(5660300002)(2906002)(8676002)(41300700001)(36756003)(8936002)(7416002)(4326008)(86362001)(31696002)(54906003)(66556008)(316002)(66946007)(66476007)(14583001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RzU5RTZ6TFlZSXBxbG9TRHhMVlozUWRlRmFrTDk0VlR5MC9aa2xBcStjazc3?=
 =?utf-8?B?S1FjL3FoUHVoT2wvNzQxa0gvdkVDazVwZnk5K3UvckJvek1Nd0NnTnk0ZGNr?=
 =?utf-8?B?SmZ5RWlodFB2QURPZ1ppbWRIOUNYOUt6cjZzTHVGSHZtODQxT3JvN1VmZVly?=
 =?utf-8?B?V0xQSzRSUGpRSU1EUmZ6WFExR3BpWExFZWRjYkRHWTBzeW92ZnNGRyt4Y1Zh?=
 =?utf-8?B?OVhVd2cxbmo5Z2t1ZGFjT2ZzRmR4ak9HVVlpdHZuaTB5U0dUdUFJaXE3L3Bv?=
 =?utf-8?B?aXgwN0NNZy9wanRXRjJjNytLaDhHclNKQVd5Uk1sNGtvYkROWmtDOTVxcnNm?=
 =?utf-8?B?RnBZalBFcG8wd05KaSs5eE16Y2tEVU01Y3pNQVFxQ2VhbUlvK0RVTWE1UDJs?=
 =?utf-8?B?RWpjaGdVcVhBdEduVTNXU094R0RZSS90Z21BOWNhWXB1K1U0Q1FmU25LSEk0?=
 =?utf-8?B?UXd4THA1U25WTEhDZHMzWVh3aUwwQ2E0bjgvR0o5cEdxemdTODRpem83SkpD?=
 =?utf-8?B?dGlSd0w2MlcwaXlkQzhxNDFFeVBaYXhIODEwcnNDRnRhcC93enZlZU1IbEdy?=
 =?utf-8?B?OGJnREc2NDZFY1hidzdLK25ONU85YkhvRzBJZ21KdEFpQzVtdFpteEp1Wk5h?=
 =?utf-8?B?OHhudTYrT2lhTElEUDJ1MGF3WndsUFBrT1J4bmJaN2h6SlJXZldrMkM5WmtY?=
 =?utf-8?B?empnUEJFZTFCbGtnTXJORVJrWSs1Y3NaZmsxKzJIb3pNSFlOWFpUeUVtUHRt?=
 =?utf-8?B?OUs3UWFiOEJaNmRUQkJKV3h5UThUOENMaWpVN3BrY0lwb1BnMnpUc1B2Y1g3?=
 =?utf-8?B?Mldua0dlMmIvaHR4cnEvQ1U4WTY1enNMT1ZYQXNlLzJZUDh0YWJmbDRMcm4z?=
 =?utf-8?B?VDVKUUlUY2RESWZ2OU1nZzYydW9LVDBycU42Y1pPTVJwOFNTdVY0QUE4WFZk?=
 =?utf-8?B?ck9yZUlFbWdjZTZhcVlzVGZxcWJoYjBTWmhMbHJacXNST2VYMkp3YktTSWxj?=
 =?utf-8?B?UG0wdVRWUVFOQUFIMFRyd21vaTgyV096bG1mS1RQbWNYTFk5WkxBZmRNamJH?=
 =?utf-8?B?Uzk4K1BmSzBYeFVwWnd6MnZQQWlZWDNiTkN1eWwxbVFsazFvZW1PZksrSjZu?=
 =?utf-8?B?SkU4YS9qRDlvMjlkZVNxYXZ3cFNudmFrS0tNWlBBU2tGeTNzUjFZZVliNjNG?=
 =?utf-8?B?NlB1Q0V0NTFTcDRGUUZQMnpCUHJGZlNUVmZ6cnJXV0lNQzg1S2JnUFZuanZh?=
 =?utf-8?B?RFlDQXJPV0FTUW1IaHpIV1p6SkYvT1lPT1hVR1p1cktpU3I0aVJDRXB1dUVx?=
 =?utf-8?B?TnNxdjF1MDJzcnBuMWpJRDBucTNyNUUwSytOamlWOEphSjZzRzU5TmZ5bnR3?=
 =?utf-8?B?SDE0d2NYU3ZERWlnK24xcjBQMzI2MHBSSGF2dmVydUdUZnpyUUxhWkFzNmkz?=
 =?utf-8?B?cGtURFAwVzFhdzBST1FDU2pTVVFOZVJ1OStYZ280b2VvWTN4OE1NN21MWTZW?=
 =?utf-8?B?c1c1MU9zUWF3ZTV4eTJpc09CTWNFRVZLUXZwc1BvK2pGdDk2SHBxSHA4L0t2?=
 =?utf-8?B?VUNHYmE5QzhwTUd6NTZ0M3k5MThIeGxWekFCWktaRDUxNUV0S0d2dy9qZGZD?=
 =?utf-8?B?QkNJOEs0VDZiOFQvSGozbWtSUXFIdUxDSFg3RXdWTkh4dDdXVmVWb3dDTHZ0?=
 =?utf-8?B?dkQ2dFoxOFIzMS81dHE2djZTM1BkNGt3QkgyL1RHZ3RILzJicUtxbE1SR2h1?=
 =?utf-8?B?YVppUStuQXlJdGIrVjFjYWlFN1hFVjN4bjU0L0pJSndxT3J1R3hRVEU1S0FH?=
 =?utf-8?B?dWNialJWQ28rdHBTZjZVZm9UMTM1ZVg1VEZSaHNFdnhPM1V1bUxVTFMxUGRT?=
 =?utf-8?B?UGl3WDhNKzJlNnd5eUV2eDNYYkhhREptdVRYazI2c2JGTy82cmJSekhsRTFV?=
 =?utf-8?B?SE5ib094b0Jub0NIV1ZqS25XVmV1QjIvVUQ5U0pWQkU1WTFFZnhQcXJqVjRH?=
 =?utf-8?B?L0NSbjRQOEpYV0RrbE9MUE9Fazc1QUNNRzBES2RMRnp4cnNIZloyRXRyUzZP?=
 =?utf-8?B?d2xhM0VnMVJWZFhSL1k1RFd0M0xXVTkyYjBEVnpWZThsakZOaWtLTEsvQmgx?=
 =?utf-8?Q?qFIFch/2TTcGl/mukJTlVt1rw?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 94913a52-59fb-484c-091c-08dbfd171910
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4820.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2023 02:39:45.2077
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pADq+P9wY0vmSmMlMBMSzjjpuctBs1sN1YV5CNZIx8nPJC52ZrBkMDNE0XmfjJ8r90DKefERRNPV6/JVcg7Yyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6931
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


