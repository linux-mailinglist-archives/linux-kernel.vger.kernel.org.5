Return-Path: <linux-kernel+bounces-108276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0F168808AD
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 01:45:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D0FF1F21854
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 00:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A880BA3F;
	Wed, 20 Mar 2024 00:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Dj27TqZX"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7B4629
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 00:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710895552; cv=fail; b=bbgjsofR516oc1ixnOiqqhqaMSVwbzaykxKIBQ/2by5/DiLX3DEPPnmzLAIJ/X7RSAQzd+yADyRNwOCh8bx/L53gBUQUEHPbV2ID5vLX+TW/TVLXv7D2yNCO5KmggfAI9YHfmD4BWl9GCuu3ZdvdiXYbHdyG0CWe+2CRM4rEyhk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710895552; c=relaxed/simple;
	bh=T0v+t3EGShIle3C8WcOqykJ1RZoBmf6JZNqXQht38f4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UjPa2BQ8euWIHUvNeJuR7evN79oDm4G4HMNs9g4QozKjwl6lwjeWxqWrcdNA8hc2Nj60l9Sb8PTs2Cbj7IM6+TLRRLI5EmxdOY/C/vTlKxY48hQOpjh99Lo/u68fqc7goWA3c6K0raEs8u04xNCiMqhqaclT4ghm4h9NseqDGEk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Dj27TqZX; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710895550; x=1742431550;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=T0v+t3EGShIle3C8WcOqykJ1RZoBmf6JZNqXQht38f4=;
  b=Dj27TqZXGC9M/NZRWDaW4nbInVPhiMmrsE/BRw1PzcTpyfNVzYezi9w3
   bw7kD7Uv1hY7i18LdSIYmuKTC/vSyCtisakQ8TAmAfPbuCoUq+zLjbcmR
   v0sbKT5AeBm5PgQMgzkGZRINMg/gPE1uusZZxMbU4HVcSVZ1AI8ntNcgL
   91FUqvfc/adniy/f2VkNcLa3dI6/emj0Es8HcqLubavG3rUCoA068L8qV
   hObOtjRqRRtpzWZTxWqCeK2gcVEbV5lge29gH2PBHLla8OmY1FzIeGLmZ
   9ru7H+19Yop2WDiIm9f87iXKm0rzGv51dQgctxuGHsRfUBhfLZp+AS4R8
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11018"; a="6407788"
X-IronPort-AV: E=Sophos;i="6.07,138,1708416000"; 
   d="scan'208";a="6407788"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2024 17:45:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,138,1708416000"; 
   d="scan'208";a="13969058"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Mar 2024 17:45:49 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 19 Mar 2024 17:45:48 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 19 Mar 2024 17:45:47 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 19 Mar 2024 17:45:47 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 19 Mar 2024 17:45:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fPSDaYsBs4l/EofbUHvEwsYZnLeifcAmTwGqdK2iIs7XqZCoRI1WDC3nwBRjBUa/24gbaSz0NktuGLJ/ao8jcaKQtLYpXuyrMBK0JSaPUSFMgNRh2/4L/IbKLuiNUWtrH+p7QXFuokpH9ZleO5g/4XI0hzcyfKm3Nky3Q0XVdxfg/gEO3D4scn+8YYmxOMT78VnacsxnIYYXdOKqmc+3A3aeb4feErFuIkGC6pIOiIw0HMkiBansMNpXsBQgG/llFmIAe/rQ0etP4f14o6e6OyusJS4CFKVTvPoomrdrikEqlKxg6HxcIFAR9ulm+RH8DYPC1qdjsWPuJSQyAhnjPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LrJkUwEo2EEeXV7m6n76H+jFpKTfpWJ/J8D9vBt0mIY=;
 b=K72yUg2r2HkMcLDqCm/OhOJmdunQYPMTCRddPeFzFE0MKWEOQ1mA10+9Gz89Keqb3GcnZSOaWMSAZtaj2BfvwRJ44msXLkF/9LJQ8ypZo+rDbOtwDB55aZ7mzxFKH3NaVTdhqxp8WOhX7fgR3x2CEf80XvwnTqD7tA4uYgFSTbbFgZsGLTS5DgIx+qiK+XSchrue4VzudAgF0tr7C88XcySHWQpysproUfb9Oj+wXBPEjpwSauW4r0WgbuIefHlf4i0/FLAZ7tWF6+WXomjPZ9Wa746C9QF//z8awt0pJQ3AFTgOJ4TiNfKm3lf4FKEEyFplPMeQIk5c2KVaDYn13Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by SJ0PR11MB5183.namprd11.prod.outlook.com (2603:10b6:a03:2d9::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13; Wed, 20 Mar
 2024 00:45:45 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ef2c:d500:3461:9b92]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ef2c:d500:3461:9b92%4]) with mapi id 15.20.7409.010; Wed, 20 Mar 2024
 00:45:45 +0000
Message-ID: <256052ee-4e7b-45c5-8399-515fbb529a01@intel.com>
Date: Wed, 20 Mar 2024 13:45:32 +1300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] x86/kexec: do unconditional WBINVD in
 relocate_kernel()
Content-Language: en-US
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
CC: Tom Lendacky <thomas.lendacky@amd.com>, <linux-kernel@vger.kernel.org>,
	<x86@kernel.org>, <dave.hansen@intel.com>, <bp@alien8.de>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <hpa@zytor.com>, <luto@kernel.org>,
	<peterz@infradead.org>, <rick.p.edgecombe@intel.com>, <ashish.kalra@amd.com>,
	<chao.gao@intel.com>, <bhe@redhat.com>, <nik.borisov@suse.com>,
	<pbonzini@redhat.com>, <seanjc@google.com>
References: <cover.1710811610.git.kai.huang@intel.com>
 <e1d37efb8951eb1d38493687b10a21b23353e35a.1710811610.git.kai.huang@intel.com>
 <tvembdwwh4immxytlfzlhpvd42dlfsz7sddb7msk23kdduhu3t@ogpc66hklorv>
 <38fca2fa-11b2-4eb7-9e59-dc5d524d172e@amd.com>
 <689bbd29-aaf0-452e-a97f-41b8e3aa6224@intel.com>
 <i3nxazyv2dlauias4jmoqwpjixviuduaw6bgtfv4claxtimlm3@54xmat6zqud4>
From: "Huang, Kai" <kai.huang@intel.com>
In-Reply-To: <i3nxazyv2dlauias4jmoqwpjixviuduaw6bgtfv4claxtimlm3@54xmat6zqud4>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0365.namprd04.prod.outlook.com
 (2603:10b6:303:81::10) To BL1PR11MB5978.namprd11.prod.outlook.com
 (2603:10b6:208:385::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR11MB5978:EE_|SJ0PR11MB5183:EE_
X-MS-Office365-Filtering-Correlation-Id: 084b6a2d-d0a7-4dc9-c0f4-08dc48771407
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: issStWotCpmNRMssuNAw3qerpJbEityAB1sL/Woo4B5M/sh0kFZi38jsXRuC9hvehdmkZqp6Wfr2ahpakOUIVLbSlBl2t8kUQCgq85gKdZf21S03c4T0AQIRsDcL91Z/MK3tco6JwDejpru0gphZVvC5bvpraIWwhmIse/FnppVFWHTKRNYajzHD0d4HBoFfVrxzIHFJ9khT2KBXrGbQEL7+UWhzHeKsp09Ac8HkGRq+nIfoNXv59138mqMlIGLO9M2YU+Hp/jr6VKs7PBzbujcwJ0vQCDOTwsi6Rp/bJ0gc/pRTGdFFxbenXiGZS69jsVuGzWXobYBMbwXB8UIMHrRQLgQZieuSl1moMeZgd5+LS3KVuc+OLiALXSCMwDJjMgw4cQRs0NmYA+1HKyiHAe032yWEmCW9ROQBHPCUPLkgygvOe3WQPu63FDKUyGou9vdXURLzafhYcgTl+iJY6sBa3uKrwoboMOkn5Zx1RXZxpkm3eVNR+bDN4PESEUltIZnJ9g9lBVa8gXw2sBb0hCeqAOIFKiWA7+bnvupB+jsJny6ZyjJE0+ET0PcSG2lIAzy1ibss0v6bw4i/GqlZhzu92BkzMDLqjK6jQIod89cuqWC1pZOXRgvMg/hC/Pjr9kHdD1cIioBNCD+sfKYha3cHAk09hTNz97FPHWlAR6w=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WU0wM1ZBMkUvVytUNVRwWUU3Vml6MDZEb0xnV1gzbW53blYrUlNhdVNhNGlu?=
 =?utf-8?B?bXlSMGQzQkQ0aVpMYUF3OXV5cDduemdTUnpIcTFETXNWZ1hYZTlpZzhjZng0?=
 =?utf-8?B?S3BDQ3l6T0FLNUxBQ2lGM0x5dDdLS0trQWxuOHhqMWl6ckVUUExPSjNOOHBh?=
 =?utf-8?B?ZkY0R1BGTHMxMHUxcitqL3ZGYnhsNVZOZHlqQmYvdHRqWkRYNVRRSksxWU5i?=
 =?utf-8?B?MDJnbENHYmxMczFhZzE3OUtIMFl5UzB3SHJGT2tvc3lUZU16WkJQY25PNERk?=
 =?utf-8?B?Y2dGZm5HMnMybXVjQ3hKTWg0QmNZRFE5UDRFOWJjQXA5S1V6Ly9XOWlOMlRs?=
 =?utf-8?B?bE0wLzZNenpkMGE2bDBNUDNQNk5GSVRGZUlIQ0JJTEM0bi9WU0NXTkVqem0x?=
 =?utf-8?B?anlDVitvOGh2eTViRGV1WUJDc3FEcmQvcVJCRXZJejNrQU5KWFZmeE1GY2FI?=
 =?utf-8?B?QnZzWlBaaVpjRysxM3gxQSswdWw4blJ5bnN0MndKWSt5bGwxdkxGQjM3RmpW?=
 =?utf-8?B?YTE3OWJRN0IrckVxekxrcndxR3NwRWlUMG41TjYyU1BXZUNIdkZxWnU0Y0Uv?=
 =?utf-8?B?dVJKalFnWlN3ZElUeTRxVHBnaW1aODVodUpEa0pJS3ltTnRxdlhXSVJQZjNr?=
 =?utf-8?B?ZDBCVUc5RDVremU1QmpMT0JXTTNiV1ZlSGkvNFN2TXRubVFYdTkrMTV1T25L?=
 =?utf-8?B?OEF5NWsxRlNoRnVNNDJUOXo5cGQ2ZzZscm9aQUJaWm9CeHZBVVFpd0FPaGlT?=
 =?utf-8?B?VENqQUwwY0xCMWxEWTVNYlpIQXl6Nld4RnZrRSthNm5DQUprZ3ExMmtjYXdK?=
 =?utf-8?B?cGdsR1NNVHlWNFBCRnhENnpMWk5MWUgvYXQwUmhPRjlaeUU0MlN5SDFsZEIr?=
 =?utf-8?B?YXBJWVpUWE9PVVFlR3JHSXFvSXg0UGtubVJ2NytES2dOQTA1blBPUlFLVzJT?=
 =?utf-8?B?Q2R5VStNa2V3QS9Ca2dhOHRsN2lWMW0yc2s1d21JaTJvMnhseGwvWDVnN2FD?=
 =?utf-8?B?SXBaZk11ZHRqWDdiZTBQYzVIUWlGMHpiMXBSMGhkcWtSNGNJNjB0YjZrZlg1?=
 =?utf-8?B?YndJMUJuazREWEczc3M0RzQrYTFoTEUxSGlSM253aktmeitaMHpacFpZcnMy?=
 =?utf-8?B?UXI4aXhuSm9FLzF1QkRyUGVQK05kUGNLZTRpdlRmVXNJNmFUUE5NeWRPV3h2?=
 =?utf-8?B?K21wWnFRb09NVkFySHN1TGZJY0lkUWFIdS9KaEFsSU5nNDdCKzE2ZVllb210?=
 =?utf-8?B?aDNSSmcyeGNSeG5JUFJ0WmdMS0JtN1pUSGo0NVd4SHlvalZQSmZuTE5zVGs0?=
 =?utf-8?B?UEcvajkwc3ZkWUhzaHc0Z0xJeDA3cDNPZGpVNERyMDNQdnpVaDFneGlZVlRN?=
 =?utf-8?B?REZjWlhJVWRkVmo5OHVUSWFjQXAyWisyYlJTaVhkV1ZUaGJ6MDJzQXVsZHRv?=
 =?utf-8?B?SU1xNzlUL0NJVTN2OTVUR2h6QS9JWGlFUlFyR21makovd3BVQkM3blFCdktS?=
 =?utf-8?B?SVV1aCtualgxNXV3Z0tQbGtQbnZ5aVNCYW8zVEMxMTRKOHJqc3JvblpaaEVW?=
 =?utf-8?B?aWZLWVFCek04dldGVlBGWVJyWVJxNXlNWlY3U05NMlVGY3V0SUxLQyt0K0JO?=
 =?utf-8?B?WSs4TWRvMkY1bW1lRjN0eGRJczhoNDBjckFMNnNvQjh4aE1EMXZwdlQ5dUZY?=
 =?utf-8?B?azcxbmlIb2lCMWxGK3ovTDBZay9sSFB2eW0xRGpqUTdCNGdZaDJqdGJqcUVV?=
 =?utf-8?B?YVBoUmY3RUczWHdWSklKTnk4NkJDeGxwbDQzcXVLN1hnT3ZZbmR4ZzN2RExq?=
 =?utf-8?B?dVhCR2N2azZjV09Ya1h1U1JJMndIUXpKdWorUkJEd3ErU1J4S1oyRytsd3Nw?=
 =?utf-8?B?bmRzVkZFckdwMGtDS3FpbEF5bWV1R24yOXE5dy9QVldKY3JkUGlsdkpwNmJo?=
 =?utf-8?B?YnB6QzhyYzRFZGNvWGVhSXp3TTF4MVk4WTY5RU92ME02OGRWaE82R3BCTmV0?=
 =?utf-8?B?a2pYYnhRQVFlYjNtMlYrSFFwaTNGV0NNd3F1SmZ2Y3hnWWs0UHFIVlNROW4z?=
 =?utf-8?B?d1JHRXhUUnZZQ2tqWHA3a0VLSi84SnlOaE9DTVFGQTh5UGdqSTNJeFdqWVBU?=
 =?utf-8?Q?rNF1ta7hkhvxEJWhSmqZeymy3?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 084b6a2d-d0a7-4dc9-c0f4-08dc48771407
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2024 00:45:45.5730
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9v++drJa51Pl1JzPsQvc65lqWGh5dYAY4D6T0l9Yd7e3SanmFgXseMu2QjRppEy92xAiOy6pmzRiej6JYxkhRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5183
X-OriginatorOrg: intel.com



On 20/03/2024 1:19 pm, Kirill A. Shutemov wrote:
> On Wed, Mar 20, 2024 at 10:20:50AM +1300, Huang, Kai wrote:
>>
>>
>> On 20/03/2024 3:38 am, Tom Lendacky wrote:
>>> On 3/19/24 06:13, Kirill A. Shutemov wrote:
>>>> On Tue, Mar 19, 2024 at 01:48:45AM +0000, Kai Huang wrote:
>>>>> Both SME and TDX can leave caches in incoherent state due to memory
>>>>> encryption.  During kexec, the caches must be flushed before jumping to
>>>>> the second kernel to avoid silent memory corruption to the
>>>>> second kernel.
>>>>>
>>>>> During kexec, the WBINVD in stop_this_cpu() flushes caches for all
>>>>> remote cpus when they are being stopped.  For SME, the WBINVD in
>>>>> relocate_kernel() flushes the cache for the last running cpu (which is
>>>>> executing the kexec).
>>>>>
>>>>> Similarly, for TDX after stopping all remote cpus with cache flushed, to
>>>>> support kexec, the kernel needs to flush cache for the last running cpu.
>>>>>
>>>>> Make the WBINVD in the relocate_kernel() unconditional to cover both SME
>>>>> and TDX.
>>>>
>>>> Nope. It breaks TDX guest. WBINVD triggers #VE for TDX guests.
>>>
>>> Ditto for SEV-ES/SEV-SNP, a #VC is generated and crashes the guest.
>>>
>>
>> Oh I forgot these.
>>
>> Hi Kirill,
>>
>> Then I think patch 1 will also break TDX guest after your series to enable
>> multiple cpus for the second kernel after kexec()?
> 
> Well, not exactly.
> 
> My patchset overrides stop_this_cpu() with own implementation for MADT
> wakeup method that doesn't have WBINVD. So the patch doesn't break
> anything, 

Well, your callback actually only gets called _after_ this WBINVD, so...

I guess I should have that checked by myself. :-)

but if in the future TDX (or SEV) host would use MADT wake up
> method instead of IPI we will get back to the problem with missing
> WBINVD.
> 
> I don't know if we care. There's no reason for host to use MADT wake up
> method.
> 

I don't think MADT wake up will be used at any native environment.

Anyway, regardless whether patch 1 will break TDX/SEV-ES/SEV-SNP guests, 
I think to resolve this, we can simply adjust our mindset from ...

	"do unconditional WBINVD"

to ...

	"do unconditional WBINVD when it can be done safely"

For now, AFAICT, only TDX guests and SEV-ES/SEV-SNP guests are such guests.

And they all report the CC_ATTR_GUEST_MEM_ENCRYPT flag as true, so we 
can change to only do WBINVD when the kernel sees that flag.

	if (!cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
		native_wbinvd();

Alternatively, we can have a dedicated X86_FEATURE_NO_WBINVD and get it 
set for TDX/SEV-ES/SEV-SNP guests (and any guests if this is true), and do:

	if (!boot_cpu_has(X86_FEATURE_NO_WBINVD))
		native_wbinvd();

It seems the first one is too generic (for any CoCo VMs), and the second 
one is better.

Any comments?

Hi Boris/Dave,

Do you have any comments?

