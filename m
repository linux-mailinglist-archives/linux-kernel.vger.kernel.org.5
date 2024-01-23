Return-Path: <linux-kernel+bounces-35985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F63B839985
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 20:29:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C47C71C28EB0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 19:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6606282D75;
	Tue, 23 Jan 2024 19:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VfUdfHty"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB802823AE
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 19:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706038115; cv=fail; b=PsyWOWbsUF1BVdSg8qrG2CF6vueT45EugWb0F0SUXKgfnIBRXvHM1zPu90j8lARaxfNk0Lw7JvdP1Ypm5mZHV8eak293ig+yTGI/L7+GSXc8Zvr8xJOP35UmruZP/g5ImvZPs0qXy2BI1juMxUgONY6rpnd476TnuYRVNtntZd4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706038115; c=relaxed/simple;
	bh=xq+54HWlLiDi3/Xbn72OZWVydU6X1379ESb4kArtkhk=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=D62T0OpyvsZ28DiJ+7dS/Z5Ao2jh5sBLuL4jpHbaMo77e15sxoxKbnCNVjdQh9Ohuyo/rT4w9HF6WFnv5Ia/U6aWfDkCcNqwUK8PRXCjlzPQ+/Cfg/EwCNcwY44A6SAAEBZEGAHvrMXJp+9GRYQN0Ts8Sw9pg/IRnrP5xIG7/zg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VfUdfHty; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706038113; x=1737574113;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xq+54HWlLiDi3/Xbn72OZWVydU6X1379ESb4kArtkhk=;
  b=VfUdfHtyfJpggRuV7i7Oz6lWsdeymcKyHhumuCuC9hQB4mntjpgwAviO
   dvbuLJ41RTTZHv1FvCixpcD2PXRcKypCJLKCwTwkQTljyAfrEKdN+CgSi
   /EdsF40eAmIypXrTh2MMBvvOp2DeBZEFhfAmTUaqkSF7NpHugBAKg1EKG
   vxRKIPe6i+okK2EgBgdcSWWLFWBMXyO3AE8FYN0GZOG6q0FNBtR/D5f7d
   twfFN8qbZlgn0gehBBzjnGLSNWGQxx5p6oa8OilicqwbEP0LRec6bDGuN
   ropJtAM2gGA1hm6P/gc5fsZatJ/c9bY/98jAjh9oLkHBbdFQ8dttTlmi0
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="8744544"
X-IronPort-AV: E=Sophos;i="6.05,215,1701158400"; 
   d="scan'208";a="8744544"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2024 11:28:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,215,1701158400"; 
   d="scan'208";a="1778995"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Jan 2024 11:28:32 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 23 Jan 2024 11:28:31 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 23 Jan 2024 11:28:31 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 23 Jan 2024 11:28:31 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 23 Jan 2024 11:28:31 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OWFhQ+SkscgW+s0YLq0KX2b9XvpwXXGhR7HquEJXvG2Ypef0nsEUV3l1RMx3BuKzId/duhSuonzyuJt9XKg3mob9xmE/cKrbkqRiZ7HrBoWJNlkaKlJrwtNkOcYb66b38/4t/TMa4J9uXDbKTq/9BwiuY/naQlgsjxNvZmTvR9FNSTVhzLQlRDkHGY5rNwwXAXd00pFrpm2CrFHna1+qgtXIdO475vYB0/VPIwK80OYAFDji3055PrKzA9v2TIky39+ACQmAtZearAurSww+dl8vRRoFM2md4LOrQYl7dMUPGNrWsIEX+AkaA+1DnTi38jHRLUIjwrToaxSdqkIL6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1/d9mGk3r8EWEMwA4lqvBtJSdyAxoEx9AF6/Hj2Re/4=;
 b=XyhsHkWpwQXnc2HrTLH/hEKHNfZxCv1bCU645wOCRh7wY/JdbS007x18ZfEwcTHeCXc2oegETQbrrZW12MtX0B0yKGWVPd5WLX8DCpx4AiGdUtxfAmOearT+FrB21Zjll1Ya7A3bCs4XGzenF6l9hniFScyf7k0x54m1o7Wtqor21ox2XV/Jq2PKvJMS5yvm5y2qP+bMxQcfwAhcNwz2XA/oc3UoIrzasmld4+ZD+t805UkwhoB6zuDU++LBgb45EMA5X9oa5CLv/xyFtAeRA4CUQiQjAKqYXz4TlFcj+olKANDfQLIRe02vewg6+n+x0cd3Qz7N5xN067UTYK3/SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3320.namprd11.prod.outlook.com (2603:10b6:a03:18::25)
 by LV3PR11MB8505.namprd11.prod.outlook.com (2603:10b6:408:1b7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.36; Tue, 23 Jan
 2024 19:28:28 +0000
Received: from BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::c3aa:f75e:c0ed:e15f]) by BYAPR11MB3320.namprd11.prod.outlook.com
 ([fe80::c3aa:f75e:c0ed:e15f%3]) with mapi id 15.20.7202.035; Tue, 23 Jan 2024
 19:28:28 +0000
Message-ID: <7f4729cd-da86-4198-a2be-1c12a5513eb3@intel.com>
Date: Tue, 23 Jan 2024 11:28:26 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/mm: Simplify redundant overlap calculation
Content-Language: en-US
To: Dave Hansen <dave.hansen@linux.intel.com>, <linux-kernel@vger.kernel.org>
CC: David Binderman <dcb314@hotmail.com>, Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	<x86@kernel.org>
References: <20240123163623.1342917-1-dave.hansen@linux.intel.com>
From: Sohil Mehta <sohil.mehta@intel.com>
In-Reply-To: <20240123163623.1342917-1-dave.hansen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0357.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::32) To BYAPR11MB3320.namprd11.prod.outlook.com
 (2603:10b6:a03:18::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3320:EE_|LV3PR11MB8505:EE_
X-MS-Office365-Filtering-Correlation-Id: 56ab933e-8e08-4a05-979a-08dc1c4979a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uVVDsB24zgtp+3wxgeDf8C35aAfAZfFVBGBw+AK8Zo5lKuO1PD8kKO1zHsFjaApKOx41bvTW7gmV2uOvAIIoV5bJR54pDrABxslP84q2oKkq4zZZlFXJC8aqmVvGdhXZkIMpOyhS87QrzL0NVprBG1MOtjfxHHMaLp4VI0/ZajNUMcYuapRNVmLEXtoJN/LfWWUFBqLeUfn9dZwy8R6rA9ThXU7S7P0guswRmAPeU7s5Afi9jDlvTH27JKsCJl6Y0Qz5cKvbJkrDyDjj/xoVweEHDjwnENs/0Xih5HUENN/s8Rxg3hju3TO7KKcv/7cNsxpYxuSDx+p8uGSuoOfCbnsGGDiezSvayD//WJnyOqNzroIHjr+QL2wXPhgBwuWvnBhUBop74pPFrtjHZOEgsGy6iNIBIaw39XGAsOfyUYDDX4mAGbMkWWu6kGxxmBbJC0Fi2EhrXMZ2xsDa6mrNPez7WpCp5m2IPHcfFhO0hoZrDLpRIvYzQos7SXUO8CH1UIpXW/l+9/BsErnPN47eMgo7vLymekS3eKCc9Wq0HJdaURfNvVVe0sxK7fJrn8HnjlZ2dwMfiF2CFoNfheCPSh/IegoVKGoo75GqiB2ZjLKcr/XJVIqO9X6W38a9+VxTxqT8ZLCmST8m1jrCGiCK3w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3320.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(39860400002)(376002)(136003)(346002)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(478600001)(6486002)(45080400002)(31686004)(83380400001)(38100700002)(5660300002)(4326008)(8936002)(8676002)(2906002)(26005)(44832011)(31696002)(86362001)(36756003)(53546011)(54906003)(6512007)(41300700001)(82960400001)(316002)(66476007)(66556008)(2616005)(6506007)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WTVxdDJNcDQvWFgvUVJLU0tlRW5FTkVlQ2dOMURUMUM0dERoWndyUVB2cC9B?=
 =?utf-8?B?cS8vZ1RZOThFTmZQUk9vNFhnSlRoYnhlNFRhc0s1SkpIVEdubFgvOVQ4RCtJ?=
 =?utf-8?B?VzE1c1pEaVVHTUNTeDA4eGVCNkxHTXVkVDJrVjF6R282MlI4dHBGbktIdlJz?=
 =?utf-8?B?NzZwOGF1NmtaenAxRmdpMHFiK3luUytqTnZ4aVpzOHZKNmk3bDB5Q29VTnk5?=
 =?utf-8?B?Q1d2TUl4dXloMEc0N3EwbDRCYS9MSGFVMW5rTmx0cGw2MHplNkVlYUVXOWVO?=
 =?utf-8?B?OGt0RXJyekxTSzBvamNjS0RLSTIwbDU1bnhZOFZLa3dUMG9xZUovQzc2SlZE?=
 =?utf-8?B?d0x4eXRqUkNmY2NSS1A4QTJSMHVrK0pncS9GRk9rS1BSNjJRZWJvR20vaHJ1?=
 =?utf-8?B?bDhuTnErYUxJUGZzblJ6M2Z5ZFBUT2N2akRkNGwvZEZGazArQlNmSzJSNjVv?=
 =?utf-8?B?eWUxQStvR3ZCWXFsNWZBVnFZck9OSWpENXcrU3AvNDZlWVVkR1JZQno4UUpQ?=
 =?utf-8?B?a1NJOEVrNm5SMEFUeXYybHlvR3I5OE9YbUczV1dLbDZvS2pDa2tWWHF1S3Ry?=
 =?utf-8?B?bnY3SnllcUJNTlVSNXY4cUJ5Qml3OGdYcUkzdnk5WUE1bkIwL2ZNU0Fvc25S?=
 =?utf-8?B?bExpMXprRnB3RzdkdDkwdjJSWW9tZVQ5K0NPRVlXM09NSENTOXRreUpvL2lv?=
 =?utf-8?B?WEdFTU9kMDFibXl5MkpPNkNNZzhJaEd4UDkvS0lEZFBlUE1PRlVNaHFDRXFW?=
 =?utf-8?B?aWx1OUN1cCtzQ2syYjRSRW5QbEl6TVRHQlcvaVhxZTE3Y3M0T3lwOXpiMGZT?=
 =?utf-8?B?M0N0dE5rNzBCSURCWGU0ZlR3SVNyRkF1dGlkV3oyWFk4bVJuSU9uMDdFSnJ3?=
 =?utf-8?B?R3BTNzdZSmhVOHlXTHhoTWFuNUJDcURDR0hwT1o4SmJSTGtqR2ErOGNnU0tT?=
 =?utf-8?B?QjVsQjBzMUpvbTNBOFBTYmVERTBqNnNMbDdVT201Z3VmYURocHRrR1lMTllr?=
 =?utf-8?B?K3RkRHNSVWVQQXIzM0dZQlc3c2MwMFB3bDFXK1MvWWFYZkpFY1NhMGJHVjNL?=
 =?utf-8?B?RW5sUWdGMGdZWjVXNWUxVUZLT052Slo3bDV6MThtb09WN3BHbnh6bDQvMTNW?=
 =?utf-8?B?TWlBQW9DbnFDb0xWR2tCblhKbDJjWSsyL3QxWSs2NHBKSWVFNUdMVTJOU2ZW?=
 =?utf-8?B?RC9oMlRMUTJTbGlSRW83TU01NG1YMEJCTzNhcmtPc0I0ekdxMHgvcC82Tngz?=
 =?utf-8?B?Mm8zRVRUcXg2SkxpTGpJRVNhakl5R0dqbmJEYlhLNWN3ODJzbDcrN1JjZU44?=
 =?utf-8?B?c0NONERYaUpvclBKU3FlVTJUSFhWRW1Ec1dhUmtTQXJmSTZYOVQ4MWFKTFhH?=
 =?utf-8?B?QlE4NFN0dEwzOHFKUXdqY2RLNGtVTHZ2L2p0QmN1YTlIQ3gxMkhUOERYTHZa?=
 =?utf-8?B?Nklmcy9ud2FuMEY2VWFsbFBuSEZ5c0pBNWdRbkpFN1RVdzdPeWRQcGowWVgz?=
 =?utf-8?B?WTRkUTZGZTVTSTk3NHNmd0RJY25id0h5eCtWVERkbm4zWjRKRWozUS93VURP?=
 =?utf-8?B?UU50WnZwdVF6MlVwUWdWQmcrbi9NczR6T1cyOGk1WGdQNmZnM0hHeURRUS9I?=
 =?utf-8?B?MjJXVU45NElGQ3NOeWlZRHNpMEVGaHB3TUdRTkNvRkwwODdwTm4wdW0yWVRO?=
 =?utf-8?B?NDdnRGc2UGhKN3p5SkUxZEs3Uk5PSC82Skt0Z0o1YnZiNGNKeG11algxUzc2?=
 =?utf-8?B?SC9uS3pjK0JWZ1piNmZYdFR6czBTY29xMmo0ZlNiTzBLdk1TWXNhYThUMWpq?=
 =?utf-8?B?dnJBa1o0MHlFWFFuV0VSVU9xdkJYSi9XZGdRNVo1cDNicGUyWGtyWUNNeHpS?=
 =?utf-8?B?Nk1ueXdpVFJCT0xGNys4dEZVZHRLTlVtd3M4Q2ZXdmVPaWFPMkl3dmZUS2s4?=
 =?utf-8?B?Y2drdTlJS25tVkJNMnl1V2Z1M2drajZwODBjNHQ5WFhuanQ5VXJCRmx5RW0w?=
 =?utf-8?B?Wi85QzNsOUN0R3hXeW9iNjNLVVBXSDM1VE5TNWRjQis1V1I2Z2J3R0FYNHEx?=
 =?utf-8?B?TUx4em1BbHF2MytYd0VzejA5ZXpEanN0RU1weFZPQ1M1V0UwcTIrTVJLOHMr?=
 =?utf-8?Q?q5Vqgg0I4g8+puIaQbCab8GS2?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 56ab933e-8e08-4a05-979a-08dc1c4979a9
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3320.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2024 19:28:28.0388
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZuUarTiJsNHUIOC747nBPaVQkl/D1ZMh4EhicBpFdfmWasoxH0+iAegT4hX9IPUc2RxfA/O4zizRat+ewBYk2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8505
X-OriginatorOrg: intel.com

On 1/23/2024 8:36 AM, Dave Hansen wrote:
> There have been a couple of reports that the two sides of the
> overlaps() calculation are redundant.  I spent way too much time
> looking at this, but I became convinced that they are redundant
> when a little test program of mine produced identical disassembly
> for both versions of the check.
> 
> Remove the second condition.  It is exactly the same as the first.
> 
> Fixes: 91ee8f5c1f50 ("x86/mm/cpa: Allow range check for static protections")
> Reported-by: David Binderman <dcb314@hotmail.com>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: x86@kernel.org
> ---
>  arch/x86/mm/pat/set_memory.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 

Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>

> diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
> index e9b448d1b1b70..fdc00516c0b54 100644
> --- a/arch/x86/mm/pat/set_memory.c
> +++ b/arch/x86/mm/pat/set_memory.c
> @@ -435,8 +435,7 @@ static void cpa_flush(struct cpa_data *data, int cache)
>  static bool overlaps(unsigned long r1_start, unsigned long r1_end,
>  		     unsigned long r2_start, unsigned long r2_end)
>  {
> -	return (r1_start <= r2_end && r1_end >= r2_start) ||
> -		(r2_start <= r1_end && r2_end >= r1_start);
> +	return (r1_start <= r2_end && r1_end >= r2_start);
>  }
>  
>  #ifdef CONFIG_PCI_BIOS


