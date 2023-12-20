Return-Path: <linux-kernel+bounces-7616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB74B81AADA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 00:12:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 683CD284671
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 23:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0F3C4E623;
	Wed, 20 Dec 2023 23:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Llpk3YIc"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD2EC4EB25;
	Wed, 20 Dec 2023 23:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703113384; x=1734649384;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Oy+ydVkJPJKUJCVMCPGjGd0Ha2Dozq+Q90jnGlGsyX0=;
  b=Llpk3YIceiHM/23BryoJD+GYwEKXBp5R44RHBeHYVJygccjgONnSPWhM
   wp05sbI8A27c1fBej2OKmrq6BCUu5LjcdIkXiDQkS4/K3jLt6iIMwvhDc
   OlIu0eamt8RPF4yH71U665UlIDXLz2ph71C8uQvkmskRF5h/PPgE38pot
   4JF2IlvlBP7YJPeAik+xnRkuBzmFlDobCwF6wbA2ljSJPmrPuws4z3tRB
   E0qVr9w6kB6lwPbUiUaZR1jmCBkQitBBpgJQyY1UZNAyZXKilVySx6R4l
   sY7+Xodpat9JBw1JWptc//F6deQgc0Keqw23W8Tdjv+yedAbaiKJFScXL
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="9347675"
X-IronPort-AV: E=Sophos;i="6.04,292,1695711600"; 
   d="scan'208";a="9347675"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2023 15:03:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,292,1695711600"; 
   d="scan'208";a="24737132"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Dec 2023 15:03:02 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 20 Dec 2023 15:03:02 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 20 Dec 2023 15:03:01 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 20 Dec 2023 15:03:01 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 20 Dec 2023 15:03:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fa2ibGdaVA1yBT4y/8IsptIlGe635gEEFdfXI1fYbkLJSqatuYm6XNuh0n6M5wGIXygmVk3NQ8pFbOGneUfB6NfhpjWgkuiwxDuaTmP+xQoJf8ABBTnLDFaRiriGbP8D06Vp/XA0QSkwWLy/1z/T3UeITje/X7YJd1iXbwASYZuLxv3bltRV+/Es2VBhZnk4Ry73FPntCPiyZoUKCdpgqbkz6RiX0lq0+K/aCV0IKqmBy2tiwESLZRrgJwQVaWVu28TF0V9c2+YLSwOakd7YJsUoSP0AjKJtnmsYP21lQZ9qllY1srJkv7DbD2w68zzwLfAhDCEnxfgLMrW7S9N5Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lHtQnDAm3dBHVW05HOd47JRAin9+y6IKO5ANMAckujU=;
 b=iDG2ZqKqHT5or+1bTEe/1sNrM150AVLhDXHcPS8tqN5X1+lRZzUFqido7NXi+rlabIz/NBnhd+pgnolTzUpayBG3NKCJ7lNRapxwzOCNFcq8hgyOdlCR/clHzuLJRVPhBuooZvjBvCZeuvBMUw5o5R7DFIWx8tpY2sO7TQ+0ld21GEH+BKVwNnkY6Ho9QKdxShlkCtEwfYcdHpPktB0beDke3phVdDGDIy9w3mBAV95SvYHTL1BSdK2zz3ZdhvAGoY3vanq1SQAX+4Ag3H4MXr8sxiYar1eEfr6rne3VrqH+YH7/q0GVbBF+1V428I+gjsxFS3JuLrSf8mPVaFIGYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5095.namprd11.prod.outlook.com (2603:10b6:510:3b::14)
 by IA1PR11MB6073.namprd11.prod.outlook.com (2603:10b6:208:3d7::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.37; Wed, 20 Dec
 2023 23:02:56 +0000
Received: from PH0PR11MB5095.namprd11.prod.outlook.com
 ([fe80::ea27:681d:ec93:3851]) by PH0PR11MB5095.namprd11.prod.outlook.com
 ([fe80::ea27:681d:ec93:3851%5]) with mapi id 15.20.7113.016; Wed, 20 Dec 2023
 23:02:55 +0000
Message-ID: <5422a086-6283-479a-abc8-ce5b08aa9d36@intel.com>
Date: Wed, 20 Dec 2023 15:02:54 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 11/12 net-next] qca_7k: Replace BSD boilerplate with
 SPDX
Content-Language: en-US
To: Stefan Wahren <wahrenst@gmx.net>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Stefan Wahren
	<stefan.wahren@i2se.com>
References: <20231218232639.33327-1-wahrenst@gmx.net>
 <20231218232639.33327-12-wahrenst@gmx.net>
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20231218232639.33327-12-wahrenst@gmx.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0306.namprd03.prod.outlook.com
 (2603:10b6:303:dd::11) To PH0PR11MB5095.namprd11.prod.outlook.com
 (2603:10b6:510:3b::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5095:EE_|IA1PR11MB6073:EE_
X-MS-Office365-Filtering-Correlation-Id: 8738f8b1-9a97-47e8-2b29-08dc01afcd63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pXuD95+uXHXydeshmO4viDA2kB4H2iqTAJjFFLKa9+dQtKdnhdlA32naloNmlWmGjumxI2KssWX/TbeH78CGWg+ll+RVzq77X0GsMUFV6FkpCRWCMarC8i49CLwyRRrdyJoZKnB3xvLSYIkkE21mD0W3AgdGtbWlkcdMKWneLI4Y3xjgZXO/4RLx3VYlh5PEj04JxPhPZkFPu1LcQ7AUCFYqqtvbVCYDNlbRZRyBMrfRNR3BVPppQhml62D12ZE68ljgO2BRq09fCH/dCCJYZ0vGIPBUmnGOKoiMsZNsiCy5x/J2+Mn4Dj8eJICJwMpJ5CtDt8RU8ieWNm70xRoFXOdHmdL4FF9qn8OsdSALyalyAjCQhYBcDJmXEx1FjoZCoDONvz1t9Qc0Is0XdHW9KZN4yjvn/GskPzB7vplwCgHoHzScxt0g5tz8yBzz+iDP6PABq3kKcNcXrHON7vfiQ/19+Tg0YatdKjvHdrRR51s4joBVNpgfbYwfNQVTjGWnZRzaWkzuuBq0T1PhqcbZw9kGz7nq0ItsvM3KQBdap/z4QJChE2m8+SxRn0u2kl52BNLBeuosdJxsEwIBCe9bS6xlhj4JrkWo/+6aQ7lmGZhZVkYF1f5XflDI7MC1Aj4W9BoDfsnHpoT6/rsy7ZnXeQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5095.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(366004)(346002)(396003)(376002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(36756003)(316002)(110136005)(4744005)(6486002)(66476007)(66556008)(66946007)(2906002)(8936002)(38100700002)(8676002)(5660300002)(4326008)(6512007)(53546011)(478600001)(86362001)(31686004)(31696002)(6506007)(2616005)(41300700001)(26005)(82960400001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NlJTMk80MEdNTnBkNHhwY2x0NjBmUmZXR0pCSVM0bFFFM0xqSnBEZk9nU2xy?=
 =?utf-8?B?NnpVVDdZc0VpekpWazZpQXZnRTF5TlVIL1BGSTI2emd1amlkMFBhbEJYN1dS?=
 =?utf-8?B?TDRKNm1WODZBUEpZaVB5TGlkTjhmaGVGTDd2YXNFaStKZTlXdCtMdWRKRWpm?=
 =?utf-8?B?c0JCNmFoczJnbUZMeE5GMkJQRkt3b2tpTGNtN3RaVENYc0d2TUhrVFJsbnpC?=
 =?utf-8?B?NS82cUd0OXNqWVRuRDlkZXJZa25sRUNWdEdCZDgveFVMbUtmcWk4bllVOUl0?=
 =?utf-8?B?aE15V2YraThUY2QwMVgrT2l2b1FZeHV6Uk9XWlNyTDNsVHNPb09renBuUUFN?=
 =?utf-8?B?TzU5MWxhcDQ4bUswRGxDSXhkbGdpOXpJQWxqRmpwZzI3YkphMHJRazNaQTN3?=
 =?utf-8?B?bEpYeURPZGFYT3pFM1MzQmUwd3ZUK1pzQlVOSWxzVzY0ZDFQb1pwdWh6UVAv?=
 =?utf-8?B?TFJsK2h4RE4wYjdST2lrVStSMzJhb1dJTnF2R2QyTU1lOUUvdm5acW9lalRp?=
 =?utf-8?B?UXJwNGpKd1ZXQkgwVDgxVGlNT0JtYjZnYVFOdGhBV3M2S1lXKzBJTkJkQk95?=
 =?utf-8?B?Y1A5RCtXbit4SlB6T0JxYnVFRFEwU0pkK20rY3JDWW5DeUNDWEFpdjd4OG5F?=
 =?utf-8?B?M016R28zTndjTXdrYklnSGJuUTRqYkp5Z2w3NXhkYVR5TlN5bE0zSGIrWjJi?=
 =?utf-8?B?S0c0cmVwZWQ5SVBiUEJ4aVVXcHpWUDRtUFh5ZkEybXVTQlJ5NFE1SVFVdkpz?=
 =?utf-8?B?eVFaRGRwUWZta3VscnFYeUN5TStKaFlPNUJIQzF5ZEJnT096WVlqRk5obFZW?=
 =?utf-8?B?ejJyWFp4NzZQQVYxYUl0MnQ3RkY5UGtDZlhUcHRjaHdjd3Vkd0ozWXFMcFdK?=
 =?utf-8?B?SXB6MGFqZDJDbXY5SDVzbEVOcnFUYnB0Uy9GWkk4dmY2bjNhdkxyc1gwNVJk?=
 =?utf-8?B?SFgraWR0WDRBeE5XWmM3TVFJVHpPVWNkSkp3UURLNUU3RktWdWNicFptMjV6?=
 =?utf-8?B?ZVZLNDY0aGYwSExFVE5QNlBIeFpKM3UramxpdUVrYnJpYWlHZmovNXJrVFVD?=
 =?utf-8?B?OHVpbG5rdWJtRG5CYlV5L04yeERsTUZTTmI1bVdkN2FBU2Z0VCtacWdiMDFQ?=
 =?utf-8?B?dDhYdjVWUWNhZFRhWGdyR3pOVEJIczJMZm1jYlEwY1E5cm5NOHptZGJIVlEx?=
 =?utf-8?B?RGJ0ZGo1ZVN4ckFLRGZocUw2TTJuUjJOc0xYeDFuR01OWXJZcVhtejQxdC9k?=
 =?utf-8?B?c0lHT0dPYUJoMFdTL200QkZNdTNxcmV3R0hwTzNsbXp6QnlibmNualFBa2M2?=
 =?utf-8?B?M3BUdFdvSVozUmFGVS9odHRKRHZuUEhkV1d6c3AxSnVZMFAxMk9yR1pTMm96?=
 =?utf-8?B?Q1BaekdvVnB3YmxWZ2NpbE4yWDdRTjhpd3FDaHNIZjRSTC9LUDdtQ2RGZHYr?=
 =?utf-8?B?QlF4bGpxZ2dHQVB6ZVVRYk5tdWFneU1QbzRncHR6bExab1VLOHNFdkUwTStB?=
 =?utf-8?B?Uk5Dd0p2R0xIdU9yc2ZjOUNmNjF6VExaSGtIN2hWMnFYeHFKNHlxZ2VlK3Zr?=
 =?utf-8?B?K2JpKzZ2Y3ZPeG8wRmk5ektyWE9nK2dwVi9GWWdGdjBxV1JwUnpCV25HVUcy?=
 =?utf-8?B?R1RlWXU2UkNOd0NxRmtaOTladWVZZ2hZY2hvSTN5eXZ2TE5Ib2JMc05TMHdl?=
 =?utf-8?B?WnJZaFFDRVBPaHRDeW9LdzNlUkgrY1JKNnBsUlErTWF2UnNhOGpsQ1dpWURh?=
 =?utf-8?B?eVVIN2pxdmxlV0trMEtGOXdrVjg0NEpmR0dGUEJTc2luNDJDUHZBZ09OTk1U?=
 =?utf-8?B?QU5QZjM1OEs2QWR5YndzZnhYV1FoaGJyQkI4dGM2dnFkSGlIdER4UitYWHJX?=
 =?utf-8?B?TlBId2daWUprSFFhcVhyKzhoZmMyVnhzMk8ybmFLVDNzWVBMZnMrbzBxYnd4?=
 =?utf-8?B?SENFL216K2oraGVwUTlVVkdXL2IwYWowR0VvUjJEMUtOMUtXUjlPQndXaTk4?=
 =?utf-8?B?RDFveS9CS3REd0xSSStWbDFGZ21VWWE3MUlZTXMzbzlqWDhNQ01lYTdHY3BP?=
 =?utf-8?B?bVBBOWpzdEltTU5yR0dua1gvZFNLT2xOTEpVUEIwTkpXSkJacGlRcE1UZDdF?=
 =?utf-8?B?NnNTRVRucUpPeWliRTg0azZBdGh5aUpYYVBQUnpnSVBtampyd0Q1Q0x1d0dC?=
 =?utf-8?B?cmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8738f8b1-9a97-47e8-2b29-08dc01afcd63
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5095.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2023 23:02:55.9156
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ezZArocdINpK4a7WjhG5SGtCpqiJ8ZYxBU8qT9LukjykP7LkCqk26MZJmWYJ54Y948/oUh3Ow8yPswiq8p1Oa3okgQmrPAAFYygEDyr4v58=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6073
X-OriginatorOrg: intel.com



On 12/18/2023 3:26 PM, Stefan Wahren wrote:
> From: Stefan Wahren <stefan.wahren@i2se.com>
> 
> According to MODULE_LICENSE the driver is under a dual license.
> So replace the BSD license text with the proper SPDX tag.
> 
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
> ---

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

