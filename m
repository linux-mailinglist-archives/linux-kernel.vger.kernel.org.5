Return-Path: <linux-kernel+bounces-101637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E81E187A9BC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 15:48:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16EA51C22729
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 14:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B26AF4A11;
	Wed, 13 Mar 2024 14:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jgEV6S25"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D14710E5
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 14:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710341319; cv=fail; b=GP8Bfdh8hW1YbwwRMpWCiwQunxKBPfVwAplQOQIxUUjj/iyF1B+Rpt32OAtU48rDdZ/viRkzs7LoP/On67Mi0DicinHPh/rrsu9n1RX4ksQz+QbsBjACzWYIg6gvZJdcGAa/SIPG6wrRUNeEsyzosCre7kW4HlkDfk1mo1dRJVs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710341319; c=relaxed/simple;
	bh=WKkewcy7oama5URLmra+254de2nlzlP766DbLx5lYv4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=avx56OZ3Y05ta9mJM2OAlhJZJ39W2OliTPyVyv9ZrsqDalYE/KBczZNx0QOG25n4w46SwFTNBE/B69kA0xiqXZC5TnA/SK40QdU4LPE5/7NLoTy05OV3DYUyqD0vObqN0ltl50V7Dg7Smpp34j9b0uWpFTOjJp0dzFifzHAol28=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jgEV6S25; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710341318; x=1741877318;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=WKkewcy7oama5URLmra+254de2nlzlP766DbLx5lYv4=;
  b=jgEV6S25A96IJq3jULipsQmvwrQ70d0fBA0nA+ofWOna5ms5xBc8f1MY
   kPcIp6RMD8a1eul0Nbh0FGWymBWrNdGPbjfjWuAF6X/szCW+aQlDM+Ffh
   7/cKQ/MNopSTxHMy4AHwTdyXWyHQakFhN6omEvqDCfggUaYp7PDnj6WmN
   ONaa4Ia5gNBy8Kg05MzgV5yGmolCnFI9zuITUjJxQVjQkTCgQXUCsHSAY
   iH3ClRwfSPiCsbMv9zFfNwJRygi55vhYmA+yHYWIOxaOBqdKmq1kh+SM2
   u6UeLyspjPiKaua03hFs6dJ1xKYH9k90YWFrPGXkN/6xl+RR8FrAvHHiq
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11011"; a="30548865"
X-IronPort-AV: E=Sophos;i="6.07,122,1708416000"; 
   d="scan'208";a="30548865"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2024 07:48:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,122,1708416000"; 
   d="scan'208";a="35071638"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Mar 2024 07:48:37 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 13 Mar 2024 07:48:36 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 13 Mar 2024 07:48:35 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 13 Mar 2024 07:48:35 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 13 Mar 2024 07:48:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BqB/sw148Y1Y0HJtMIiyyJYbXQXIEatxJbGaMw5PdAB2BmRbdRRUxk3oYmLvX56spYG/idylGK1hmtP/G5BFut+8eRk/xFtTpM1hxdg/yWHeU2vlJvDqdYhLIcY0ozx+uom+c3HBv2MT7BjRkbQYjoqijW/PxLkFF4IcHkYQDlT78Zd70kS90yZTzW0j/dITJ2XAEHsvZAOy95UHxH5obX2Vo7KNul4M18p3R/ZmF8IMzTYV6XNfm4Dqnf220oIxKzdWhZIF7fCgmwFn4qlW1jpsgLb31ycV8zWS8YkwtNW5+W5SSuvftysCheUILUtgTLZHD3mczo6GB7EZtCNYrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WKkewcy7oama5URLmra+254de2nlzlP766DbLx5lYv4=;
 b=SFcbtUWfx+u1TB1wbAJj8zTfoSc4MQe3hly4RU4dZJk3QmLd6L1NZOnNJTJsgsw1GA5ISOeoa9yFMrSZH/ib8yXGeWrmAcLf+PxSFzzD5CLKPXPjkNWfAOvUnvrXbmxfwIo5QDa7ZuY8LtopurgBSStmGaoEIfgTYyR0v3qsltmjMniBg+mvyydNXaHmJnWG35APCNAiJszZA/Wk4bMITlQqletEtwFbZjB61LH/WGB2aJBEhTR9tHY3GgaCwVm4HuBoecMmFHUzC1jNE18sESndFcCJMIMOrEhw6dATt8w54TkCHhmFHe3A9X3D7mL41id5j7GNYrJN+Ha/cGM7Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by LV2PR11MB5997.namprd11.prod.outlook.com (2603:10b6:408:17f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.20; Wed, 13 Mar
 2024 14:48:32 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::fc9e:b72f:eeb5:6c7b]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::fc9e:b72f:eeb5:6c7b%5]) with mapi id 15.20.7386.016; Wed, 13 Mar 2024
 14:48:30 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "debug@rivosinc.com" <debug@rivosinc.com>, "luto@kernel.org"
	<luto@kernel.org>, "x86@kernel.org" <x86@kernel.org>,
	"Liam.Howlett@oracle.com" <Liam.Howlett@oracle.com>, "broonie@kernel.org"
	<broonie@kernel.org>, "keescook@chromium.org" <keescook@chromium.org>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "hpa@zytor.com"
	<hpa@zytor.com>, "christophe.leroy@csgroup.eu" <christophe.leroy@csgroup.eu>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, "mingo@redhat.com"
	<mingo@redhat.com>, "kirill.shutemov@linux.intel.com"
	<kirill.shutemov@linux.intel.com>, "bp@alien8.de" <bp@alien8.de>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "peterz@infradead.org"
	<peterz@infradead.org>
CC: "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 01/12] mm: Switch mm->get_unmapped_area() to a flag
Thread-Topic: [PATCH v3 01/12] mm: Switch mm->get_unmapped_area() to a flag
Thread-Index: AQHadMz0q4ZgPznkBE6p6Yp5SBKN9rE1Q++AgAB9fgA=
Date: Wed, 13 Mar 2024 14:48:30 +0000
Message-ID: <9d0a0ba73438031bf60172c7126cee87d63c070e.camel@intel.com>
References: <20240312222843.2505560-1-rick.p.edgecombe@intel.com>
	 <20240312222843.2505560-2-rick.p.edgecombe@intel.com>
	 <21ba6b8e-b9c7-41ae-8815-46525557c687@csgroup.eu>
In-Reply-To: <21ba6b8e-b9c7-41ae-8815-46525557c687@csgroup.eu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|LV2PR11MB5997:EE_
x-ms-office365-filtering-correlation-id: 5fcc5259-41f1-417c-4fc3-08dc436ca67c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vBruv4lG2wozBotHxnkY2G6hl0OIpQYltxAGKJQywwBGnn2xRbGOIoYbjZZtFAweL6xpLLaettOLHCYffH5PApz7mD0e1+7xb0eWapT/30wmbKrL8pVHTO7mbDuyiKSdY0LXSg0f2IutHRG5QUOogTVZvJoQdsrk1Mj+yju1ih8byiLSgVLzl7AxDWe12xGN3jwqn8/2rJZVHDRydljeOfVo5/k35+IJL88ReAF+CDS9/WPAZuqKCLg/RXxOsum1CV/kVf6yn/TSNEwH+UJ5uAjL2hZBFWB/7WdtIkwxe5zYpEwt3iuIJOyRa6BKQ53eyPMu3ZzKE0RvyaTVG4jzas+7pyI7iFm4wPkRDzYBX7O53o2qtObtCbRxxnqbPJip7NJHkBBklHHx8KtiZ8F2OQIVX+Zm6+tnYb+JJ8hrZdsZf5dJhlRqifvKzpeY12/1RQOnA7jAabQh46Cx0CvbSWEysS0ZV0Ni4KjMOp7HimiSMUSXpEkqvJVkIga17snndaZODl0A+OBcugEG34wLFnfR/kohmzq95F/QivwlDdAn++GN70lnJwwnvKqA8zG+Vet09Z4IdG4o+PGQNDAifSry6URz/l8JQOSClOXKDnWT6C5H82OkBUfnmt6w3NgK1w0zSEugn6hPV2YtC6LFS2uI9JnKmZ944zEn2c47Kil5zzn0wFBSV1nQ9teeB+kmyxz+6LRnx0/6bN0MK1MmOSjBPsKmvk2cQQJDfFiWcPU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(38070700009)(921011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TlZvWE16Z29ROVVwL0h0Y3hFSzllWlVjSEZoQXVPeWNta0IzdmtrNkhtK1J4?=
 =?utf-8?B?MVd6MFJ2RHA2MklPa3ZnZS83S1FiUEtxMWdhdlVkR254b3dOVlYrRXEveVVX?=
 =?utf-8?B?NTNaL2cxSEhJdEpSQW9DT2RLMlVKUzUzRlc2ZWU4aDFJT1NrOG9GRUcwanFT?=
 =?utf-8?B?NDlDSE02V3hhNFdJVGtCelQ5dWhtVFhESUJBV25RS0ovWDAycGJKdWtOdjZp?=
 =?utf-8?B?dFFzVW1SSFBzSnhzbmxYL3JrU25YWHliVlBQMmZTK0tzL3hSMFdpTlNDREhO?=
 =?utf-8?B?blNwZzVDTW1tbW5vWVF4UVNBeWdFcDlVUkEwakxLbXpVZnhXQ3J1UUEwc2t4?=
 =?utf-8?B?RzBrTUs0eVNnMjZSK0xpV1c0NmRoMUFURytuR3Q1bFlhek0xTGpaL3dvMWls?=
 =?utf-8?B?MmNueGhkZG9WZGdJOWIvMjFiaXk2UEtmMnJmSGJ2NEpUL1l6Z2lrWWg5VWo4?=
 =?utf-8?B?R2VHSmFkOUpvVzhXenA1NWFoSE8xM1JVMHFXQ2JJSU5BVlVhZlg2MHFOdkYx?=
 =?utf-8?B?ajNtVjV0WGxBcGlHSCtsbmlDaGZpdTJTTEYvL0VzRGthNUU4SHZoT0d5UXhR?=
 =?utf-8?B?OUhUSm1TVEc5RTY3eCt2RHJMRDhVOHNod05FcXYwZnZTM09DSU1pLzlhNnBr?=
 =?utf-8?B?Q3ZEam0wVWhiUFFMV3hCMUduK2g4SmNVbmd1OU5hM2JjTlFmUllaTmxGOStv?=
 =?utf-8?B?TGV4MGxzY294WEo4ME1XZXY3STBDSHBpdlJ3dHBsK1BsZ2Z0MEpUMlJrR05r?=
 =?utf-8?B?Qzh5VkQxS3ppY1F3OFluNmYxQ2RrWlZNdFpOT2dxcENMNWUzdzNXSEJQNElW?=
 =?utf-8?B?K01ZY054ZzUvRk5BV0N2OUhTM01SdCtTWEpDL216YTNzNUduVDRHbzFIdmJN?=
 =?utf-8?B?bm9WMjZ1T0h1cXprL3ZYN3VDS3NPSC9SeTZJMUpDRXpOWkpQaFJ0WGpFODl6?=
 =?utf-8?B?RGh5Y1dDaHVnMjMrcDJsUW5MQ21rM2oySm9McDdhdUJqZ1pRbmxkdXkrOGFn?=
 =?utf-8?B?K0M3TWFCb2xoOUVTY0s1ZU9ROVFmcUNIRUpXOGMrSk5GNXRhL3FRNTF5VDRv?=
 =?utf-8?B?bGZqdTZUNzVYS1ByV1AxbTJFOGgvRUdQZ0h6NHFNQkJxbk80KzExVEt4ZzBm?=
 =?utf-8?B?eXRjK28wTEdzUFVONDUwbFdGQ3MxNktaSHFCRUFJUU8wdWpWQm1LcHl3NFNZ?=
 =?utf-8?B?UXQyNk80SHFDOEhPNjl3UVhOM0VteERsM3RpTGpONFFUTG9qc2IvUFBJS3ZU?=
 =?utf-8?B?clpCV3NJZ28razZnbnVtYlZFbENNRXh4aEx1dTM1d09QQ2FxQVFoZlZ6V1lq?=
 =?utf-8?B?N0M3bzVrQmJjSXdDTDZTcG95OW1FTjNEUzl5YkZOZ21Jdms3UWVtenRUdFQx?=
 =?utf-8?B?cVFIU3VYeTk2NW4rcUpRNUJ6ZWhDYVczeDh1Q3ZWMW1oUDVtSExiajRwOXEy?=
 =?utf-8?B?ZXlsQWtrWTVFcHV1R1lzaGw0QkRzSmNiRG9NMVF0dVBYM292YnRWY010STZW?=
 =?utf-8?B?M09kazVvL0MwODQ3ei9uYVJzRm5JdGs0aSs1MElRcE9WbC9PUTdPSUwzTmlV?=
 =?utf-8?B?cnM2dElKY2orZG53MENiVjIrRHRYSElJd0MzZlpVU2l5aUl5bzZDTlhBd1JS?=
 =?utf-8?B?NW9FdnA2bFBldGZpUWIxNWRUM0tObDFsS2RzaDNhWC9vWGhWR3o3Tm5BdVY2?=
 =?utf-8?B?RXZHaHY4WlF3OXFHQ1VYTFdmSnl0N21KZ0ZpRDZxblZjWjZ5MDUrT3VVbUdG?=
 =?utf-8?B?NWhkUENLZVV6dmhZdjM2NVh1TTlEbWlEVytSR2VyMG9vS0xHVDhxUkx3MWw3?=
 =?utf-8?B?cFNFSjFSS3dDT1lxRXl2bWFlSGJnY3VaNFBHbHpKZ3ZLUkQ4WHpwUFlxYjla?=
 =?utf-8?B?b2VQR0FrVWRtK29sc0dISVptVkxWS0IvTEVVSkdSNWR6SE9pbnlwQlhrS0FE?=
 =?utf-8?B?QU94RzNWM2dhblFDS3AvUmFERnRPUXlmQmNQbG5HRXp5WmU3MjU3M3VESE14?=
 =?utf-8?B?bjdtcUVSTSt4UHowRDRvamloMUtjWThMd1lnYUs3bFdpYjBJNDljOXlQbmVX?=
 =?utf-8?B?ZThLYlFDWmlRMlJpYzVXamVlNlZtK1cyS0IwTlZsVDhZb0JQOGUzbHF4T1Rn?=
 =?utf-8?B?bDQxV2pkcFplYnN4TTV2dFZmTGdwUGN3VDJKbUtjN2YzekRsNk1RdXI5MVh3?=
 =?utf-8?Q?uJynqeFw9sPGpj0mZuLrEAw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B91222F8C0E6A04B865917E6E358DD31@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fcc5259-41f1-417c-4fc3-08dc436ca67c
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2024 14:48:30.8014
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ldyVHt/T14uXJ5fUblg7CK0fqOjuBm/YWU9zNKc+mcFnMCiIA63S91tTyQgWhq0gHJgT97v1UpKDk1D+6CHcdxoAdEJPRoX2cUNBffupKDw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB5997
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI0LTAzLTEzIGF0IDA3OjE5ICswMDAwLCBDaHJpc3RvcGhlIExlcm95IHdyb3Rl
Og0KPiBUaGlzIHBhdGNoIGlzIHF1aXRlIGJpZyBhbmQgdW4tZWFzeSB0byBmb2xsb3cuIFdvdWxk
IGJlIHdvcnRoDQo+IHNwbGl0dGluZyANCj4gaW4gc2V2ZXJhbCBwYXRjaGVzIGlmIHBvc3NpYmxl
LiBTb21lIG9mIHRoZSBjaGFuZ2VzIHNlZW0gdG8gZ28NCj4gZnVydGhlciANCj4gdGhhbiBqdXN0
IHN3aXRjaGluZyBtbS0+Z2V0X3VubWFwcGVkX2FyZWEoKSB0byBhIGZsYWcuDQo+IA0KPiBGaXJz
dCBwYXRjaCBjb3VsZCBhZGQgdGhlIG5ldyBmbGFnIGFuZCBuZWNlc3NhcnkgaGVscGVycywgdGhl
bg0KPiBmb2xsb3dpbmcgDQo+IHBhdGNoZXMgY291bGQgY29udmVydCBzdWItc3lzdGVtcyBvbmUg
Ynkgb25lIHRoZW4gbGFzdCBwYXRjaCB3b3VsZCANCj4gcmVtb3ZlIG1tLT5nZXRfdW5tYXBwZWRf
YXJlYSgpIG9uY2UgYWxsIHVzZXJzIGFyZSBjb252ZXJ0ZWQuDQoNClNvIHlvdSBhcmUgc2F5aW5n
IHRvIGRvIHRoZSB0cmFja2luZyBpbiBib3RoIHRoZSBuZXcgZmxhZyBhbmQgbW0tDQo+Z2V0X3Vu
bWFwcGVkX2FyZWEoKSBkdXJpbmcgdGhlIGNvbnZlcnNpb24gcHJvY2VzcyBhbmQgdGhlbiByZW1v
dmUgdGhlDQpwb2ludGVyIGF0IHRoZSBlbmQ/IEkgZ3Vlc3MgaXQgY291bGQgYmUgYnJva2VuIG91
dCwgYnV0IG1vc3Qgb2YgdGhlDQpjb252ZXJzaW9ucyBhcmUgdHJpdmlhbCBvbmUgbGluZSBjaGFu
Z2VzLiBIbW0sIEknbSBub3Qgc3VyZS4NCg0KW3NuaXBdDQo+IA0KPiA+IMKgwqAgI2lmZGVmIENP
TkZJR19NTVUNCj4gPiAtwqDCoMKgwqDCoMKgwqBpZiAoIWdldF9hcmVhKQ0KPiA+IC3CoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBnZXRfYXJlYSA9IGN1cnJlbnQtPm1tLT5nZXRfdW5tYXBw
ZWRfYXJlYTsNCj4gPiArwqDCoMKgwqDCoMKgwqBlbHNlDQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoHJldHVybiBtbV9nZXRfdW5tYXBwZWRfYXJlYShjdXJyZW50LT5tbSwgZmls
ZSwNCj4gPiBvcmlnX2FkZHIsDQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBsZW4s
IHBnb2ZmLCBmbGFncyk7DQo+ID4gwqDCoCAjZW5kaWYNCj4gPiAtwqDCoMKgwqDCoMKgwqBpZiAo
Z2V0X2FyZWEpDQo+ID4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybiBnZXRf
YXJlYShmaWxlLCBvcmlnX2FkZHIsIGxlbiwgcGdvZmYsDQo+ID4gZmxhZ3MpOw0KPiA+ICsNCj4g
PiDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIG9yaWdfYWRkcjsNCj4gPiDCoMKgIH0NCj4gDQo+IFRo
ZSBjaGFuZ2UgbG9va3MgdW5jbGVhciBhdCBmaXJzdCBsb29rLiBPayBhZnRlciBsb29raW5nIGEg
c2Vjb25kDQo+IHRpbWUgDQo+IGl0IHNlZW1zIHRvIHNpbXBsaWZ5IHRoaW5ncywgYnV0IHdvdWxk
IGJlIGJldHRlciBhcyBhIHNlcGFyYXRlIHBhdGNoLg0KPiBEb24ndCBrbm93Lg0KDQpIbW0uIEkg
dGhpbmsgdGhlIG9ubHkgd2F5IHRvIGRvIGl0IGluIHNtYWxsZXIgY2h1bmtzIGlzIHRvIGRvIGJv
dGgNCm1ldGhvZHMgb2YgdHJhY2tpbmcgdGhlIGRpcmVjdGlvbiBkdXJpbmcgdGhlIGNvbnZlcnNp
b24gcHJvY2Vzcy4gQW5kDQp0aGVuIHRoZSBzbWFsbGVyIHBpZWNlcyB3b3VsZCBiZSByZWFsbHkg
c21hbGwuIFNvIGl0IHdvdWxkIHByb2JhYmx5DQpoZWxwIGZvciBjaGFuZ2VzIGxpa2UgdGhpcywg
YnV0IG90aGVyd2lzZSB3b3VsZCBnZW5lcmF0ZSBhIGxvdCBvZg0KcGF0Y2hlcyB3aXRoIHNtYWxs
IGNoYW5nZXMuDQoNClRoZSBzdGVwcyBhcmUgYmFzaWNhbGx5Og0KMS4gSW50cm9kdWNlIGZsYWcg
YW5kIGhlbHBlcnMNCjIuIGNvbnZlcnQgYXJjaCdzIHRvIHVzZSBpdCBvbmUgYnkgb25lDQozLiBj
b252ZXJ0IGNhbGxlcnMgdG8gdXNlIG1tX2dldF91bm1hcHBlZF9hcmVhKCkgb25lIGJ5IG9uZQ0K
NC4gcmVtb3ZlIHNldHRpbmcgZ2V0X3VubWFwcGVkX2FyZWEgaW4gZWFjaCBhcmNoDQo1LiByZW1v
dmUgZ2V0X3VubWFwcGVkX2FyZWENCg0KU3RlcCAzIGlzIHdoZXJlIHRoZSBmZXcgbm9uLW9uZWxp
bmUgY2hhbmdlcyB3b3VsZCBiZSwgYnV0IG1vc3Qgd291bGQNCnN0aWxsIGJlIG9uZSBsaW5lcnMu
IDEsIDIsIDQgYW5kIDUgc2VlbSBzaW1wbGVyIGFzIGEgdHJlZSB3aWRlIHBhdGNoDQpiZWNhdXNl
IG9mIHRoZSBvbmUgbGluZSBjaGFuZ2VzLg0KDQpJIGRvbid0IGtub3cgYW55IG90aGVyIHZhcmlh
dGlvbnMgYXJlIGEgdG9uIHNpbXBsZXIuIEhvcGVmdWxseSBvdGhlcnMNCndpbGwgd2VpZ2ggaW4u
DQoNCg0KDQpbc25pcF0NCj4gPiDCoMKgIA0KPiA+ICt1bnNpZ25lZCBsb25nDQo+ID4gK21tX2dl
dF91bm1hcHBlZF9hcmVhKHN0cnVjdCBtbV9zdHJ1Y3QgKm1tLCBzdHJ1Y3QgZmlsZSAqZmlsZSwN
Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdW5zaWduZWQgbG9u
ZyBhZGRyLCB1bnNpZ25lZCBsb25nIGxlbiwNCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgdW5zaWduZWQgbG9uZyBwZ29mZiwgdW5zaWduZWQgbG9uZyBmbGFncykN
Cj4gPiArew0KPiA+ICvCoMKgwqDCoMKgwqDCoGlmICh0ZXN0X2JpdChNTUZfVE9QRE9XTiwgJm1t
LT5mbGFncykpDQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybiBhcmNo
X2dldF91bm1hcHBlZF9hcmVhX3RvcGRvd24oZmlsZSwgYWRkciwNCj4gPiBsZW4sIHBnb2ZmLCBm
bGFncyk7DQo+ID4gK8KgwqDCoMKgwqDCoMKgcmV0dXJuIGFyY2hfZ2V0X3VubWFwcGVkX2FyZWEo
ZmlsZSwgYWRkciwgbGVuLCBwZ29mZiwNCj4gPiBmbGFncyk7DQo+ID4gK30NCj4gDQo+IFRoaXMg
ZnVuY3Rpb24gc2VlbXMgcXVpdGUgc2ltcGxlLCB3b3VsZG4ndCBpdCBiZSBiZXR0ZXIgdG8gbWFr
ZSBpdCBhIA0KPiBzdGF0aWMgaW5saW5lID8NCg0KVGhlbiBhbGwgb2YgdGhlIGFyY2hfZ2V0X3Vu
bWFwcGVkX2FyZWEoKSBhbmQNCmFyY2hfZ2V0X3VubWFwcGVkX2FyZWFfdG9wZG93bigpIHdvdWxk
IG5lZWQgdG8gYmUgZXhwb3J0ZWQuIEkgdGhpbmsgaXQNCmlzIGJldHRlciB0byBvbmx5IGV4cG9y
dCB0aGUgaGlnaGVyIGxldmVsIGZ1bmN0aW9ucy4NCg==

