Return-Path: <linux-kernel+bounces-118841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FF8F88C00F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 11:59:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3651C301FC5
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 10:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4748C12B6C;
	Tue, 26 Mar 2024 10:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QT/1na4h"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF4ADDBC
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 10:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711450792; cv=fail; b=bJz+ycuRJoPhP3ldlb5S/Jfyf2S86iOohgwQa9tdiDVX4xsUfiPmedPAdVofdrfDQ49SXzN4nLaM76/qoGbh+cAHxpprgevcDq+GiBB8eHEPANLVRSanVXnj+EOanSP/muILbKMfW8qSQUOWn2fFMiIlpRVZs7+AXM3ft0iCdRg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711450792; c=relaxed/simple;
	bh=M4zCx0IQVcSpHnmq/z72RxSeAe56dDpRf+Xl+2GUxzk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NhTBcf7kaQTnN+3u/riXdR8LBx9xt5owktPGT1oWMeoOp/UcKgzbW0p4thbWgIP0SrynIBn923XEQTEVgW53JQMqHvi80dgJr0leCvRM+Fd9UZyANnMQGH/eEE7fANHK33pRFuqfcazODzPlKrS6/Fr9spy7FbiYdHIno6Agvq4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QT/1na4h; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711450785; x=1742986785;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=M4zCx0IQVcSpHnmq/z72RxSeAe56dDpRf+Xl+2GUxzk=;
  b=QT/1na4hokjGn2n7MML6Tsc2DSoaJp2Bmcono7qj9EY4kbS0kudt8ogC
   jQ/YNzpXDnJCCBz5DDmGlUiDEPHc/zrG0lokF8Wnul1pBIt+0nV/EoGuM
   Ag/wOYXpYoQ+Oe8OD8Xy5DxXXZbE4y68GvZ41e/qCVb+p1bQqiSsfXb7a
   lk2T3bygaRiRs3psSIx4GfWYnIewZXqxvBIuzpmXKF4wloJz8u+bX681B
   4zRZcLkJd87oBx0E3qkJ67BuE5PaRRd7DolNL7JjG5PQeMrNJUGdCwIUP
   3ruSV0KVPJicmd3zeUJf0mOW88YymNdljsshU4ZE/AdzCdjStLw2dHqOj
   Q==;
X-CSE-ConnectionGUID: h1Z3lMqXRkCecu4yA1uqsA==
X-CSE-MsgGUID: zDbPyhcWT1SKd44u5yfFyA==
X-IronPort-AV: E=McAfee;i="6600,9927,11024"; a="7094757"
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="7094757"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 03:59:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="15962198"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Mar 2024 03:59:41 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 26 Mar 2024 03:59:40 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 26 Mar 2024 03:59:40 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 26 Mar 2024 03:59:40 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 26 Mar 2024 03:59:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GIH0q39s7yhVud51AU+SR4/FEMPD5NKJYMSDMBuTzv1HMp6kI607ZitxbO9auSgChLdjN6RxpN7dozwDOcSamMXLM/XeCGhDaLM/6nNLhuBgXqZQHL+zret1K25+MPyNVRyY0YWX6CUIulbmX71LSGDwhX423wSdwOddgyJ5rZyaCu2S0VqjHCZ0VXzsRRgT0gD60BtOfsVjAd03yCZ3l87zRmo2leOTVvKsz5NPBrCcBGtlngkklmAJgzZIZohdlIgJLxpWt6uavB7ckWplsiwvsHzGGzm1x5ChcBzxX2YCekwmIGM8Ya09Rt3cRNSKQWWEVqf6w25UwnDHHJhAGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M4zCx0IQVcSpHnmq/z72RxSeAe56dDpRf+Xl+2GUxzk=;
 b=isJBoh2Azn7og78nKUtPzKymMh0RyrzLdh61rkn6Y4yFN+kqijR365FuYwnmCqv6srvw8g7JgHo95hulF0xBPI0/9stoqp+xFF7TSeHemIGNe5PDR4p3dIev5vDuZbSEgOIVUsB0gUmt80g9S42w6oLtrylPJKkxYf58VDoR3cVxXh5cVGA8LOITkN+zeN4jf/2WaKRv0TBkqqmoKtqnJ33IONY5jWUUEimNgD2LYGa2XtZyGPV7KN8bDUHgd/zsKWGoPSTOYoU00wx4wwmkplTNhgkEZINq7l44P5L5dJhJAEWgv5tvDNKRsYyo4hAosBavCCet1y4sDWMAqBm5sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by MW6PR11MB8312.namprd11.prod.outlook.com (2603:10b6:303:242::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Tue, 26 Mar
 2024 10:59:38 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ef2c:d500:3461:9b92]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ef2c:d500:3461:9b92%4]) with mapi id 15.20.7409.031; Tue, 26 Mar 2024
 10:59:38 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com"
	<mingo@redhat.com>, "Hansen, Dave" <dave.hansen@intel.com>, "bp@alien8.de"
	<bp@alien8.de>
CC: "sathyanarayanan.kuppuswamy@linux.intel.com"
	<sathyanarayanan.kuppuswamy@linux.intel.com>, "hpa@zytor.com"
	<hpa@zytor.com>, "Reshetova, Elena" <elena.reshetova@intel.com>,
	"seanjc@google.com" <seanjc@google.com>, "Edgecombe, Rick P"
	<rick.p.edgecombe@intel.com>, "x86@kernel.org" <x86@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHv2 4/4] x86/tdx: Enable ENUM_TOPOLOGY
Thread-Topic: [PATCHv2 4/4] x86/tdx: Enable ENUM_TOPOLOGY
Thread-Index: AQHaftj50EcXGNmF1U25UgIi9sNlFrFJ266A
Date: Tue, 26 Mar 2024 10:59:38 +0000
Message-ID: <ea00b63e4e7f27dfb35b8b5947bd0951039db9bd.camel@intel.com>
References: <20240325104607.2653307-1-kirill.shutemov@linux.intel.com>
	 <20240325104607.2653307-5-kirill.shutemov@linux.intel.com>
In-Reply-To: <20240325104607.2653307-5-kirill.shutemov@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.50.3 (3.50.3-1.fc39) 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|MW6PR11MB8312:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vBFycxBhuBm2OxiH2TBAR4zIBbd6t1eaUOcG+LOJ7UrH9xjwA68xAyosjGC9XUKajMNhmYQGdVwtobm/kN1merEU7iJV5AgXAxjxTO96I5KoPNCvyIFyTzZ7QgJZLzmKFtDzr2ltlsNWPtxdZ0VD71TlOgDVd0mJG2OHIYJ1tEHcerqa+MCsam+xvLLFSLsOujoYx8I9ueWYbZqDZB4+7LcgaGI23cmSB43Yy+rV3o4xQcvw54cD6JFpktwe97006OGr9YDnoEAS1D6p6Js5WThnyD4Xv+pxbXGG5xJaK/do6vrVpT6VuT9c6SuTnUQSPO6bgiB9FAy8i3/5sd1XYeiniSP/IveGgBVjsZcatZ8JcjX1fAig2raKhLtGllzUlr4sKlsYwWRtYo8qG/z73kEZ2eYp9BBbfgU3W0udP+sYboeDd5UZN2JwfYngWTHWupFJq5297ZIZwur+fdOnQm3fhKQGj0byZrdmVleaacjqTyNmNx4zYSQw4rKD7tv2j/yZo4zZyt2c7mSR7hn/BXpQqT1iNDMPyMOtBoeYEKWHT2Bku/iqqVYHyHNCCl/n0CERT3af4WqcvMBLiWmBFlTr+WnbuJWLsdryJXPeNLdbehauEpyVbTB0Ji2k66wJB0mHpyN33xyVsbFCV7zVHfpmK9psxs/w8YFA4qTsHv0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RmllTkppUS9Zd0czMWhsSTA4UXZOUDh6MFRUZHZQZ0xoYm1FVkZ1d2ZGVkd4?=
 =?utf-8?B?cnlNcUp6eWxWNEk3YTA4VUdVSEhsZkF0MmxwZGV1K0JyK1JqRENVWXdTQ1B3?=
 =?utf-8?B?aE1Odkk4SFVnMUdGQVpQSXRDWmwrdkNKRnpsNWFHa1RlNlpLcE9zWUlFQnRz?=
 =?utf-8?B?QXpOVXN2MjFaMCtaa2ZTRDR0Uk41aUpPQWxKV01hRDBWdWloNzE4NmtZMzhN?=
 =?utf-8?B?cm1ZVktZVTFvRG9kWXV6bndRb0syamFnUnlvcXJzV0hWSExReVczVE1kNm1j?=
 =?utf-8?B?dG1VRFUwbHJmVjJoOWZZb21nQVB1RXFqTURYNHNmTVhrbDVrV0VYR21KbkU4?=
 =?utf-8?B?TktzamhSOEtBUVZDK05PMXlBMWYrRkhSVUwwNFhhLzRIWWdSeVkwamViczJx?=
 =?utf-8?B?QXNxU1hVZFg0VklLMG0wWWNwWnhPdkFHbEwxdW9ZSjRFVlNIMjI4dHA0KzJD?=
 =?utf-8?B?NE1CVHlNSGFvUGIxbHJVL1BYc09WaEJpeWVacnVNenU4SU5oTXJWUko0Uk1a?=
 =?utf-8?B?NUVYOHozb28wYUJlSWdaMXJsZk5RaUt4eUJueENMdlhlR0x2M2FqMGszaUk3?=
 =?utf-8?B?cWphS2dqY0JRQjRVRS9vYk1CYklxUklrTjBpamY3TDIrNkJpVS8rMkZPaWdy?=
 =?utf-8?B?WnR1T05lVm5WSGZwRWZZZnR3QTRXRHFZY0lqUFVKZHYvQ3JjR1h0d3VMYllK?=
 =?utf-8?B?N2ZSYzNFRzd5VnpuenlkbkR2SFFwU20yeHp1V3FOS3JKZGZzOTRJRXpFYzJ2?=
 =?utf-8?B?cksxOWQ2Sndja0V6dkxNeGJQVi9NaTNraHJoWkZTWHpCZ1BsQTkxREJmZ0hl?=
 =?utf-8?B?V2JQbG9XRjVzWVRMMkVEYXZlcndnMm5ZVERxS1k4MG9pVi9MUytMNnBubEl2?=
 =?utf-8?B?Um85NVFjeDVoUGlQcnhJd1l4QktaYXhlemxCcS9KcFZTbTZXZDhWVUZhWGI5?=
 =?utf-8?B?UU1MYnE3Ylk2UGRUa1J0STBraDM4QXBhMG9nNjdyYkE3eU5GN2VselFUdmxp?=
 =?utf-8?B?Q0hUTWIyeDZ0UmZLUlpzTkZ4Wmd6TFZMWkJlRnlLcUVYUjVUaHBIWmlEWTZS?=
 =?utf-8?B?Qk9Kb3BLWkJDVCtGbUVrdTlCRXYxWXowN2N3dVpaVnp4Tmp5bGdmWHBpMmta?=
 =?utf-8?B?bytiTEg0aVUyZ2RyYk9Sa3oxVjd6OU5veGRXMlgvbGNIQUtqVUR5V0ZzRWF0?=
 =?utf-8?B?bWpPUStqVnFpSXJXeVZReVVpdU94VzR5NjduMWJEZ0Z4UjdPZGl4aHNDWG9O?=
 =?utf-8?B?TE56cmNmcUdMVGJwQ1pNK2N4VytEeUpNTU5tWlFiRnZtdHUwdjVsL1NEZE1R?=
 =?utf-8?B?aExCTXFJVUl3THFvdnZWalJSU3doWFdpcUp5bDkwcDRySDUrTlZCcHN0TGtS?=
 =?utf-8?B?QzQ3NWw4Ym5GT281bmNFcTRPdFFqc0cyWTV5TTVNRWNSL0t5bTR4dm5XOGJY?=
 =?utf-8?B?Z2hOb0lQUGMrcXRBNHJFb0kzbS9aWE9PMkRKTVY1bWRRSlQ2K3BZdDk4cFRO?=
 =?utf-8?B?YXRyY1BJelhSMGpkWjd2WUg5S0J0R3F4UlJCd1NDM2JJbVZwN0JyY1JkOENY?=
 =?utf-8?B?SGtDaHdmTG91ZzJJRUVIN05jZzhXSXBOcGlLckdSbVNBRGFyZFJ0bVFtYWND?=
 =?utf-8?B?ckRlQnEwNVg4YjdRbnFrNnhFQmh4UldKSXRoZzcrT0EyaU80djFwTDV5Sllt?=
 =?utf-8?B?cnR3Y0xtbUdkWUM0Vzl3NzljUDJiMVZzTGVIS29ocjUyQ2VvZ2dNaVZoSUZl?=
 =?utf-8?B?alFrdmMxbnhGSlRGeGJHVnpMZk5zSXlkbi9FbkQ3aWdwNTU0SlpiQW1PRFdC?=
 =?utf-8?B?TnBZcmh4NWpTbE9lZXRvR2NwcVkrNHQ3ZFZpQTVnOFg3aXVOUW1BNzlkdE1J?=
 =?utf-8?B?Vm03ZmpCVHNqVk5pWDdESTNoaHhydjdhNHl3YXRXTVFPcFg5bkczd2R4Q0Ev?=
 =?utf-8?B?Kzh0VFBoQlByYXVySkg4QUtwZ2IyVWJ2a2pzUUFpYU5rbkN4SFpmTjFoOThh?=
 =?utf-8?B?YjIrR1dPUG9kUlpBaWExWGtoUmsyeHc2N2lEaDhaWDA2TnpDRFNSSFBsVFlE?=
 =?utf-8?B?MkNRVk01cHJOeXcwWnU3TjcwMk81M3JSQlpiblgvT2tiRk1HY0hDL0Myd2Jk?=
 =?utf-8?B?N0hCTDNCbm5IQW5Idkh2UFpjOUc3RTN5bkYzbWFSTXpxZFJJSmpiVGZxRTJ3?=
 =?utf-8?B?V3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2FE1ED1D02AC574A87C07ECA11E34794@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd994a60-5885-4f4c-b1b4-08dc4d83d495
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2024 10:59:38.2023
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: X7HPL5WkIZjZcDutAOfe1ZMM/VB4cqV8PTh4012gq7SX0KOkeBMeg2owifhCuNOord56mJmL3eOHYec7DLP1ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR11MB8312
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI0LTAzLTI1IGF0IDEyOjQ2ICswMjAwLCBLaXJpbGwgQS4gU2h1dGVtb3Ygd3Jv
dGU6DQo+IFREWCAxLjAgZGVmaW5lcyBiYXNlbGluZSBiZWhhdmlvdXIgb2YgVERYIGd1ZXN0IHBs
YXRmb3JtLiBJbiBURFggMS4wDQoNCgkJCQkJCQkgICAgXiBOb3QgbmVlZGVkLg0KDQo+IGdlbmVy
YXRlcyBhICNWRSB3aGVuIGFjY2Vzc2luZyB0b3BvbG9neS1yZWxhdGVkIENQVUlEIGxlYWZzICgw
eEIgYW5kDQo+IDB4MUYpIGFuZCB0aGUgWDJBUElDX0FQSUNJRCBNU1IuIFRoZSBrZXJuZWwgcmV0
dXJucyBhbGwgemVyb3Mgb24gQ1BVSUQNCj4gdG9wb2xvZ3kuIEFueSBjb21wbGljYXRpb25zIHdp
bGwgY2F1c2UgcHJvYmxlbXMuDQo+IA0KPiBUaGUgRU5VTV9UT1BPTE9HWSBmZWF0dXJlIGFsbG93
cyB0aGUgVk1NIHRvIHByb3ZpZGUgdG9wb2xvZ3kNCj4gaW5mb3JtYXRpb24gdG8gdGhlIGd1ZXN0
LiBFbmFibGluZyB0aGUgZmVhdHVyZSBlbGltaW5hdGVzDQo+IHRvcG9sb2d5LXJlbGF0ZWQgI1ZF
czogdGhlIFREWCBtb2R1bGUgdmlydHVhbGl6ZXMgYWNjZXNzZXMgdG8NCj4gdGhlIENQVUlEIGxl
YWZzIGFuZCB0aGUgTVNSLg0KPiANCj4gRW5hYmxlIEVOVU1fVE9QT0xPR1kgaWYgaXQgaXMgYXZh
aWxhYmxlLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogS2lyaWxsIEEuIFNodXRlbW92IDxraXJpbGwu
c2h1dGVtb3ZAbGludXguaW50ZWwuY29tPg0KPiAtLS0NCj4gIGFyY2gveDg2L2NvY28vdGR4L3Rk
eC5jICAgICAgICAgICB8IDE5ICsrKysrKysrKysrKysrKysrKysNCj4gIGFyY2gveDg2L2luY2x1
ZGUvYXNtL3NoYXJlZC90ZHguaCB8ICAzICsrKw0KPiAgMiBmaWxlcyBjaGFuZ2VkLCAyMiBpbnNl
cnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYvY29jby90ZHgvdGR4LmMgYi9h
cmNoL3g4Ni9jb2NvL3RkeC90ZHguYw0KPiBpbmRleCA4NjBiZmRkNWExMWQuLmIyZDk2OTQzMmEy
MiAxMDA2NDQNCj4gLS0tIGEvYXJjaC94ODYvY29jby90ZHgvdGR4LmMNCj4gKysrIGIvYXJjaC94
ODYvY29jby90ZHgvdGR4LmMNCj4gQEAgLTI4OSw2ICsyODksMjUgQEAgc3RhdGljIHZvaWQgdGR4
X3NldHVwKHU2NCAqY2NfbWFzaykNCj4gIAkJZWxzZQ0KPiAgCQkJdGR4X3BhbmljKG1zZyk7DQo+
ICAJfQ0KPiArDQo+ICsJLyoNCj4gKwkgKiBURFggMS4wIGdlbmVyYXRlcyBhICNWRSB3aGVuIGFj
Y2Vzc2luZyB0b3BvbG9neS1yZWxhdGVkIENQVUlEIGxlYWZzDQo+ICsJICogKDB4QiBhbmQgMHgx
RikgYW5kIHRoZSBYMkFQSUNfQVBJQ0lEIE1TUi4gVGhlIGtlcm5lbCByZXR1cm5zIGFsbA0KPiAr
CSAqIHplcm9zIG9uIENQVUlEICNWRXMuIEluIHByYWN0aWNlLCB0aGlzIG1lYW5zIHRoYXQgdGhl
IGtlcm5lbCBjYW4gb25seQ0KPiArCSAqIGJvb3Qgd2l0aCBhIHBsYWluIHRvcG9sb2d5LiBBbnkg
Y29tcGxpY2F0aW9ucyB3aWxsIGNhdXNlIHByb2JsZW1zLg0KPiArCSAqDQo+ICsJICogVGhlIEVO
VU1fVE9QT0xPR1kgZmVhdHVyZSBhbGxvd3MgdGhlIFZNTSB0byBwcm92aWRlIHRvcG9sb2d5DQo+
ICsJICogaW5mb3JtYXRpb24gdG8gdGhlIGd1ZXN0IGluIGEgc2FmZSBtYW5uZXIuIEVuYWJsaW5n
IHRoZSBmZWF0dXJlDQo+ICsJICogZWxpbWluYXRlcyB0b3BvbG9neS1yZWxhdGVkICNWRXM6IHRo
ZSBURFggbW9kdWxlIHZpcnR1YWxpemVzDQo+ICsJICogYWNjZXNzZXMgdG8gdGhlIENQVUlEIGxl
YWZzIGFuZCB0aGUgTVNSLg0KPiArCSAqDQo+ICsJICogRW5hYmxlIEVOVU1fVE9QT0xPR1kgaWYg
aXQgaXMgYXZhaWxhYmxlLg0KPiArCSAqLw0KPiArCWlmICgoZmVhdHVyZXMgJiBURFhfRkVBVFVS
RVMwX0VOVU1fVE9QT0xPR1kpICYmDQo+ICsJICAgIHRkZ192bV9yZChURENTX1RPUE9MT0dZX0VO
VU1fQ09ORklHVVJFRCkpIHsNCj4gKwkJaWYgKCF0ZGNzX2N0bHNfc2V0KFREX0NUTFNfRU5VTV9U
T1BPTE9HWSkpDQo+ICsJCQlwcl93YXJuKCJGYWlsZWQgdG8gZW5hYmxlIEVOVU1fVE9QT0xPR1lc
biIpOw0KPiArCX0NCj4gIH0NCj4gIA0KPiAgLyoNCj4gZGlmZiAtLWdpdCBhL2FyY2gveDg2L2lu
Y2x1ZGUvYXNtL3NoYXJlZC90ZHguaCBiL2FyY2gveDg2L2luY2x1ZGUvYXNtL3NoYXJlZC90ZHgu
aA0KPiBpbmRleCAyOWE2MWM3MmU0ZGQuLjI5NjRjNTA2YjI0MSAxMDA2NDQNCj4gLS0tIGEvYXJj
aC94ODYvaW5jbHVkZS9hc20vc2hhcmVkL3RkeC5oDQo+ICsrKyBiL2FyY2gveDg2L2luY2x1ZGUv
YXNtL3NoYXJlZC90ZHguaA0KPiBAQCAtMjcsMTUgKzI3LDE4IEBADQo+ICAjZGVmaW5lIFREQ1Nf
Q09ORklHX0ZMQUdTCQkweDExMTAwMDAzMDAwMDAwMTYNCj4gICNkZWZpbmUgVERDU19URF9DVExT
CQkJMHgxMTEwMDAwMzAwMDAwMDE3DQo+ICAjZGVmaW5lIFREQ1NfTk9USUZZX0VOQUJMRVMJCTB4
OTEwMDAwMDAwMDAwMDAxMA0KPiArI2RlZmluZSBURENTX1RPUE9MT0dZX0VOVU1fQ09ORklHVVJF
RAkweDkxMDAwMDAwMDAwMDAwMTkNCg0KRG8geW91IGtub3cgd2hlcmUgY2FuIEkgZmluZCB0aGUg
bWV0YWRhdGEgZmllbGQgSUQgZGVmaW5pdGlvbj8NCg0KSXQgc2VlbXMgSSBjb3VsZG4ndCBmaW5k
IGFsbCBtZXRhZGF0YSBmaWVsZCBJRCBkZWZpbml0aW9ucyBpbiB0aGUgbGF0ZXN0IFREWCAxLjUN
CkFCSSBzcGVjIGFueW1vcmUuDQoNCg==

