Return-Path: <linux-kernel+bounces-118805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CA0388BF8F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 11:33:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1FB9B2871E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 10:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28C2DDF60;
	Tue, 26 Mar 2024 10:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JWi33lWz"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B88647
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 10:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711449032; cv=fail; b=ILTLSXhAMgEDyOn6xYB+Szvo5WfneEe6C6KBmAylhvcbdYXyCXPXSpy18uV3E3FpUcznlOXvoynpuR0Kc0j7lROh5tgtFHqEKR9EqPLDt60g0EtPTBKC502xzNEWXsXmMgy7DmtrjOlhuuXtzLF1x3be7vPMylpfC5uhDKtZ9m4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711449032; c=relaxed/simple;
	bh=fr6pay0+hUTzJDFc8DHbr2Ciz7p4NcQtjsZGsV1UkQk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=so7+RH6N7jsMqDULWO5VCoQ/77c0fw9Jc6KnQV/bKFihAW9ryxp3zpp9yUdeUJjeUMDFl/gotfxDEFPc/vpwpeFdOy0Z10VGi6eDSlZF80TDxwEuFVDXiQkE5gvmQJXcsNYcKyJ6uuZ72cwH8DLZdleiYr57te7yiQiDx3713Tw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JWi33lWz; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711449031; x=1742985031;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=fr6pay0+hUTzJDFc8DHbr2Ciz7p4NcQtjsZGsV1UkQk=;
  b=JWi33lWzCus1o8xq1BsFhk97ZTN4cWmFECgZmdrWHwTdKjD97l+AkpMa
   kjUfyqnDwDvj4J16/FNFE76j9AObk1EvXi6YQ96TNfYWFdOf681AreNBK
   GDODuXbH7R0eMzanzGUKAI9esOAOcDoJDYreRc6ZFKg7nUGdOJr86hKab
   FgUxddGebuTavMEEbxv7EOjwmpkr7q7l9VADThEoEQ7XtPOu8BEn6y0TT
   wifLkQo8QtJo6zPqOjsGKWCLYuf180/90/RGMFK4PNjpcBab1dXPIPtN+
   MLhZhJENGARpPJ4MK1YYKdWlV/u1j4tBiZeSPDa38FCT8r3COKTXoGXoP
   w==;
X-CSE-ConnectionGUID: FrbiHi3pSKa3ruppFonPLw==
X-CSE-MsgGUID: IA6DNVzcTfiu5hzJ11dWMw==
X-IronPort-AV: E=McAfee;i="6600,9927,11024"; a="6355937"
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="6355937"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 03:30:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="15893845"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Mar 2024 03:30:30 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 26 Mar 2024 03:30:29 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 26 Mar 2024 03:30:29 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 26 Mar 2024 03:30:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B8P7dfb1Qv6KMbOvtMjbxcacYpHVXBKfGOAteMCsxoPvzKYPasCaqA/Uk0bub63vM1APuSHYLKX9Sy9Yq/9F1gkkYUaJ5q0ybv5kXlJbp+15NED+ohRStTJvGssstpfAgmiuE3LAC3zvHmzzEyWLaeF2UTZU6mCsobUXmwkBXFU0cLqRmPIVd/DMgFyZgZhxosSEdkcBfpthKs8RJ+oH16s7s2mRhQGIx5QO2L4/qAJTvM0VT6zSiVbqgh0/GLtl3cKd0hBs6ekYoJm2JUfM0Q9Xzo6QLDroWB/Cuh3H8a5WXXZySu2dx+rPoolb9t+GK1d0mlo8thSqinSQoH92Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fr6pay0+hUTzJDFc8DHbr2Ciz7p4NcQtjsZGsV1UkQk=;
 b=Rj47aRNdWEk3otxxqZKRSYQz7UHN2N3hXgfT1DwCBZ8r4KpYS6NH908HtZHKu1ZtqJvHtmnqr5hsIjnJXDb8y4MmLrOa+HXSzTyPsDaDtFmX2Ny4NRulcJm/XbqyEMQV/C/0JUnyx0lsWDTxLdGGww60ZRTeVaLtBq4xHS9yv4GktXmHIEltIGq5y3/guE3C/7zuhWAGQ9xtaOrdek7kX1U03cpvhE4WYL/QK77fPuW9D2Liv87N2D/+NrYu5iYZC3HW6MY3e+ejYKqJZMtP/xQxHcbJq5vdigZ4yFcUt08BK7NGxqQNLDtaFavKj6FgemN+h3o99Rm6NrrsFCMk6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by DM4PR11MB5279.namprd11.prod.outlook.com (2603:10b6:5:38a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Tue, 26 Mar
 2024 10:30:27 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ef2c:d500:3461:9b92]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ef2c:d500:3461:9b92%4]) with mapi id 15.20.7409.031; Tue, 26 Mar 2024
 10:30:27 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com"
	<mingo@redhat.com>, "x86@kernel.org" <x86@kernel.org>, "bp@alien8.de"
	<bp@alien8.de>, "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
CC: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, "Reshetova, Elena"
	<elena.reshetova@intel.com>, "Nakajima, Jun" <jun.nakajima@intel.com>,
	"rafael@kernel.org" <rafael@kernel.org>, "peterz@infradead.org"
	<peterz@infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "sathyanarayanan.kuppuswamy@linux.intel.com"
	<sathyanarayanan.kuppuswamy@linux.intel.com>, "Hunter, Adrian"
	<adrian.hunter@intel.com>, "thomas.lendacky@amd.com"
	<thomas.lendacky@amd.com>, "ashish.kalra@amd.com" <ashish.kalra@amd.com>,
	"kexec@lists.infradead.org" <kexec@lists.infradead.org>, "seanjc@google.com"
	<seanjc@google.com>, "bhe@redhat.com" <bhe@redhat.com>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>
Subject: Re: [PATCHv9 08/17] x86/tdx: Account shared memory
Thread-Topic: [PATCHv9 08/17] x86/tdx: Account shared memory
Thread-Index: AQHafqDhyTVBuVGp6US8Ih8vYTctVbFJ0/cA
Date: Tue, 26 Mar 2024 10:30:27 +0000
Message-ID: <9e30828eaf9e4254d2d994cd11e469cca43314c9.camel@intel.com>
References: <20240325103911.2651793-1-kirill.shutemov@linux.intel.com>
	 <20240325103911.2651793-9-kirill.shutemov@linux.intel.com>
In-Reply-To: <20240325103911.2651793-9-kirill.shutemov@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.50.3 (3.50.3-1.fc39) 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|DM4PR11MB5279:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /BOwGrMuC1/4hFNMulu4PosT44AOlK6c7xOfSQjdfN1dbuQ5TwOa+8w1NMPQeV+TxaX49kjXwkjk3o7dzi0zSg/b885ZvWy6AqDOCLabFMgNLhDlNdsKA4SI9TQ7RzPrju8vSa5f7o41cnbA6qDLj84Ol/gUQ6p2rWTGFcnYH022aKNxTt5O46PRgSQ4nFqeNTNku/qSMAOsRC8h7qGOSiaU81N8UKCNKjFZAwnfSumjeTlJmNg4gbwF06IpxX2zftYh6WWmQ+Z2H99XpRytf2XOiYoVYvz/opu/FZgjI0E5SrpDUw+dxtVQ70DxhqS37UYbXoR2u70XwDbcmnd/32Ec9uVJx7sqRG/vURNvuptZXP/iIZ0fPnM3unPmcj3Hxz6wBMXqYdjWNlGzYLiG8v1G6qH2i2qqUodfg/xBg6Rf1bJus7/McdVrESQt00XKNETPkKXeGsr3Cz95KUwINnRnlk4x37r+CJMVo/3pP3PUYWfC4GW5eP9vPPVo8I5pNEh6Uja9338Gz+y7lHeWU9QHxkeSULOqCwPZMR1GNhZxesI0oR6W6KfWDZdLHsSbC1pNf+CaYNC6BCG+apWqXK35t8UQJ604ANdRy0Iqn9F2tWmYe+vetK3ZcrPfkGtbRHgZiifqhf5RAx1jvIZX7ggDeEBSvHXtEF9KHHvQcu0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(7416005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V2ZHcHFjOTFzYk5aVk9Fa1F0RmlnWUwrTW9OSUlJVDN6SGdqL0hGRFNOb1dr?=
 =?utf-8?B?UUV6ekNwY2x5QVNVa21WNm5nY2pEbGd3Ulp5MFpBZkUwSTIybGRqZ3Nka21s?=
 =?utf-8?B?bG4zNS9hWEFPZ1UyN1RRSDVPMlJKUURDMDN1aWV2Qys3V2hzNDVoWW5FczB2?=
 =?utf-8?B?ay9WY2FsV29WeThTOHFPd2RWSldlWDcycitHVUo2NnNNSnJiVkJoRnFVS3VY?=
 =?utf-8?B?VVU4OC9NbVhwNU9NbVZDZmRYSTY2WmdDOGtjNTlEOGtieWxVSVI0KzlPVG5R?=
 =?utf-8?B?TWV3Q3BocHpNYThEVmMrb2hla1RRekk4K1JrNlg5V3NFaFRrUWxVdDBPdWdH?=
 =?utf-8?B?dDJkMnBzYWNaMGh5anNGOXNwTmtLcWRrZGZwbldKdXpBemdZVjhzYWtuSmxr?=
 =?utf-8?B?TUN4ZU1mSndCUzNrTnlsREd1MW1HbnpnSFhBeFNSSWVNbHpIS3pYWjZnMXFM?=
 =?utf-8?B?Q1FzZkFJVHBvYXdPOVFXUnFqLzJLVEI2U3ZORUJjN3hOWlZ5bndRcWROcG9r?=
 =?utf-8?B?WWhCSC9PWW9YM3Z5T05EK0NYY1paM1V5dnVocHlOL3BTaFp4dmplQmdLSURZ?=
 =?utf-8?B?N013TXgrN09aaVgvcDdsaG5ZVGlFU2U1R1prLy81V2pqRTRGL0xIQUVhbUg5?=
 =?utf-8?B?MzZZRGdDUFhHTXVuQlM5TFFxcEVJWmkvZmJxeHlpVi9ZNEhWNFQ4WVZlNG94?=
 =?utf-8?B?ZE1reU5KeVMvVldQNGhPakpZMGFBT1YvcXRKMUMyZXVMYmJnMXlyTjdYRElC?=
 =?utf-8?B?dG1yV1k5RUtPbDgvcEpva1B4MFRxNGVCSUZxV1RjZ245RDZnc3IxRTRVZTky?=
 =?utf-8?B?Z1A0MnBUWVpvSzdtRDdYS2lNVVAySGFEQUhaOUJkYmxWRUg5VFNxaytCWXpI?=
 =?utf-8?B?a1pQaGorODhQVnJsSS9YSU1sYkNIZHVyZVhrSjNwQTBNNDFwUUsrTWtocUxX?=
 =?utf-8?B?T1IrTXVTdUpTczFIQ3R3Ti8vS1BiVU01NDNzUDhzNWFXc1I2eER6cnVPSjhl?=
 =?utf-8?B?TE05QVN1M0FOL2VQUlczRVQ5NjJBSFVBZk9sVXRzeDdUT2RPcUd6UWk0M21K?=
 =?utf-8?B?SnZjV2k3ekh2YWdlM2Era1JlUHYvNWJseFNIS0F3dzF0YndVNGJqMHVYbTJO?=
 =?utf-8?B?RzFGdUpKU1RNQ2k4WUYzT1RJZ09JSWt0K3JaVDRTcEVTR0xtQ0xRVENCc0F4?=
 =?utf-8?B?UERvTFJqcDF5TisyVVB0MXQwcnBpMzFDbzJDOENqa3ErK0d0STZPcWVGMncz?=
 =?utf-8?B?aDZUUW5teldVOTFtZUFCc2o4OTZCamFlZUZneVo5ZU9pYzJDeXVrVmR2SFlj?=
 =?utf-8?B?MVp3VTVJdEFSZmpqQm9qSUt1QTl4R3NuNGRmU05KVUN6bTRMQUFEWnVWSEF6?=
 =?utf-8?B?RVUzOVFaOVI1U2NlN3pDVXMvcGZzUE5oVDQrQUxNQ3UyNWRZWnBxQjVjKzdL?=
 =?utf-8?B?dklvRzJjWUF6K05XU0JSbGpOTm82QXZhOE5PTzl0dUlDTi9tNnNJNCs3c1du?=
 =?utf-8?B?WXhBcDE3T3VZWjFQSmtSZmNNMzdYU3B1QlluN2FrTUtWYjMza05YUk9kV2Zk?=
 =?utf-8?B?Ym1WNkQvUVp4VGJJVEhDL2lXN1ZWdnUrc2JrNzhUdGJ6MHRtY2xpOERuSEsv?=
 =?utf-8?B?RUtiVG8zbHZwdU14bnIxWXdTWGxZc01udXJ6am4wNWxVR3MyV2NMK3pVNjRW?=
 =?utf-8?B?ZUpzNDZqaVA0UlBIUFcrTkIrNnZ2TFBYV3NzVTRHc2cxZGpJZ0UzbWlxU0o3?=
 =?utf-8?B?NGVIMDBXOHB0dzlJa1VnVVB1emFTbCtUR0hkM1ByNU0vSFA2L0FVN2JhSlJv?=
 =?utf-8?B?c3RCeGFHK2hPRDBiQmhSVXJxc3FDUmhVZGZYWnNwaVdXeEwxVUI4Rit2SlFG?=
 =?utf-8?B?YldIcm91NWl2VUYwU1drMHpRdkVZQmdCT0V4NlZaYTdSL1hraGNRM091dmV3?=
 =?utf-8?B?dnFldDNqaGQvUFZtU0RmTUQwMnhZcXR0dHNMSndVTC9zVWh3OEdXWjBUb2Vm?=
 =?utf-8?B?QWxsV2J3dExCcHFuLzZDYkFDMFdubUVjLzNnbUNhSG5lVmlWeDEvYlVPeWNR?=
 =?utf-8?B?RUUzc21NemY2SVgwUmhoOE1vQVpScEhLTEp4VFV0SjRVeDIxd0FNL3RqRXRv?=
 =?utf-8?B?THBZdnVPL3ZFcTNYZWJ5ZElZd216UWhBMUZRcVFXckdqMElnYUZjN3lScnBs?=
 =?utf-8?B?YkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C9345AD76E84F94387E85F4B9C74CBFA@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d493ae1-900a-4caf-2509-08dc4d7fc110
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2024 10:30:27.4548
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RJ7YWIuq5KK63RW+XguJWdv79fQ0JwFDAT1v7qneSdk+Gu9lUVvEhb4vCZxzRgSjuv7PZl7qwhT3IgA/GE+8AA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5279
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI0LTAzLTI1IGF0IDEyOjM5ICswMjAwLCBLaXJpbGwgQS4gU2h1dGVtb3Ygd3Jv
dGU6DQo+IFRoZSBrZXJuZWwgd2lsbCBjb252ZXJ0IGFsbCBzaGFyZWQgbWVtb3J5IGJhY2sgdG8g
cHJpdmF0ZSBkdXJpbmcga2V4ZWMuDQo+IFRoZSBkaXJlY3QgbWFwcGluZyBwYWdlIHRhYmxlcyB3
aWxsIHByb3ZpZGUgaW5mb3JtYXRpb24gb24gd2hpY2ggbWVtb3J5DQo+IGlzIHNoYXJlZC4NCj4g
DQo+IEl0IGlzIGV4dHJlbWVseSBpbXBvcnRhbnQgdG8gY29udmVydCBhbGwgc2hhcmVkIG1lbW9y
eS4gSWYgYSBwYWdlIGlzDQo+IG1pc3NlZCwgaXQgd2lsbCBjYXVzZSB0aGUgc2Vjb25kIGtlcm5l
bCB0byBjcmFzaCB3aGVuIGl0IGFjY2Vzc2VzIGl0Lg0KPiANCj4gS2VlcCB0cmFjayBvZiB0aGUg
bnVtYmVyIG9mIHNoYXJlZCBwYWdlcy4gVGhpcyB3aWxsIGFsbG93IGZvcg0KPiBjcm9zcy1jaGVj
a2luZyBhZ2FpbnN0IHRoZSBzaGFyZWQgaW5mb3JtYXRpb24gaW4gdGhlIGRpcmVjdCBtYXBwaW5n
IGFuZA0KPiByZXBvcnRpbmcgaWYgdGhlIHNoYXJlZCBiaXQgaXMgbG9zdC4NCj4gDQo+IFNpZ25l
ZC1vZmYtYnk6IEtpcmlsbCBBLiBTaHV0ZW1vdiA8a2lyaWxsLnNodXRlbW92QGxpbnV4LmludGVs
LmNvbT4NCj4gLS0tDQo+IA0KDQpSZXZpZXdlZC1ieTogS2FpIEh1YW5nIDxrYWkuaHVhbmdAaW50
ZWwuY29tPg0K

