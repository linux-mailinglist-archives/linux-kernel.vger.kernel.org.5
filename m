Return-Path: <linux-kernel+bounces-118826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAAF488BFCC
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 11:46:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A2992E7F1D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 10:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 552084C83;
	Tue, 26 Mar 2024 10:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZwVWQB18"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 343CC63A5
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 10:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711449967; cv=fail; b=NBzxguy+4X77wp2azWIjO4xiZQoV5gVsKSlLDt28zqyk0mRM2rfCqyLJRqpocw4iWjeJnTLS0k4QUCjbWutQhhp5v3dt/KaEMXmwxIrIG4U02iwAyjUlEsQAHKvZqMDTsxrvtqbU8iNILMaRV6PvxKiVmbadb2UNe8aXgawJyNs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711449967; c=relaxed/simple;
	bh=K8IUsFA4QWmM7IGX7AQj2+N3L2ihJuT5RJ8KBB5Cs0I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uHoBVya3S+n8smTWFSln+cuqPKTPNVKw4rtjfW8mDoehbcMCtzfXLcL7cyzIgtsIcQSCo0onFSWdXzH1KOqF4gPwdpA8pfnz1zaaDE9teIdaaVqrZHICtOh3UTznV7nDeu+oEPVH1j0rslY7tjhpMbocRXfGQhAHPlvzs+vI0tU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZwVWQB18; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711449963; x=1742985963;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=K8IUsFA4QWmM7IGX7AQj2+N3L2ihJuT5RJ8KBB5Cs0I=;
  b=ZwVWQB18rlfb9wpHfFTDtQN75w/Bjt31rS0eTYxCs9yvSEot7CCqbYeL
   hh1CcPE8C4UzFlhj80mUbX8a8i8UkPU337nZ1Fezu2XK9FXMUNgGT2JOp
   rMhDUT/T6xV1X2tn+5rpw0vpatu8TyHqEkCt+ceBv3Y91t2DsuuWO7Vkl
   qolgvjx1zTfrXFNAbJ2VL5X5v759cyN5d2bzmlNRK0wSJ6nfaaJuTmPwg
   dWuT+O98l2bk7OraXvNUde3r5jVz8NwRMsBrETBTi22Va8e6ADbj7ls5l
   YtsOOg67P6RtW45pb46SAuQfyX7eJy7ul9S/hithrXCv8WCGEqAgoa0Xz
   g==;
X-CSE-ConnectionGUID: 07mana8vT2at3OUPZcp0tw==
X-CSE-MsgGUID: eTB8fLeYRC6Y7wBL8h/zRw==
X-IronPort-AV: E=McAfee;i="6600,9927,11024"; a="6357479"
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="6357479"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 03:46:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="20640123"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Mar 2024 03:46:02 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 26 Mar 2024 03:46:01 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 26 Mar 2024 03:46:01 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 26 Mar 2024 03:46:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=egKW4472jxDvMpQNSFlZnpnuzNCNKoYk1N7P/8yfspbAxZZRsjc84+44cfzqWucXsj5pq982R6/eW05WO3sYcUSP/Z5G92hx0BtiT+acGuDamJdTUAPPc6Qtmq+Dyt0xMRMY+RBMoARjcvgIo/fetg3Wvf/0Sq0QgpIvTMKS5I/2kKaNhSYElooNrss9dvTxKPJPGvzTNNFWPNLWJPpLV8tmpUtUn8eL5nFbCLEWvlBfln/h3ED7eeQPuFYS6DZlC2XHknQpQFiwqDLiKZZxZ+Hklgf3oFMKvm3U6yGXgD8Vz74JHUYXrEJuOqQj8Ncl2zA/3UwVOTtWl7UK/mNjBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K8IUsFA4QWmM7IGX7AQj2+N3L2ihJuT5RJ8KBB5Cs0I=;
 b=nI30AquFBFNYz18sLTRZHDIMRHAX0e+cBMCSQZvDR91t3I2Q2er540OyfjXrr+LKUwf/WB3jf8095d23xBbSynzIBDe/NyHJlJSP/05NYiiMNdeygg++kB1SFV1XlPS9iP5n0HX5tlLnPHjyhTu11hkJtuRhRQN6fzVrAy7/p1gxod6FeVj+wyyzNMTikF+CpHE9gz2CV+DvOlt/wAxwRhkpKQVYOF61CqGR+TstY8U26HKM7n04bnlirVZKUHxqCWYrvZkYR1aE8lBIpe2xuFlQRV8mFV3fIYowPoquvOqTUu2YB3AvBtq1MiZ8mN1Z4A4HfIqRk4pEJBpF1JahmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by CY5PR11MB6440.namprd11.prod.outlook.com (2603:10b6:930:33::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Tue, 26 Mar
 2024 10:45:59 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ef2c:d500:3461:9b92]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ef2c:d500:3461:9b92%4]) with mapi id 15.20.7409.031; Tue, 26 Mar 2024
 10:45:59 +0000
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
Subject: Re: [PATCHv2 2/4] x86/tdx: Rename tdx_parse_tdinfo() to tdx_setup()
Thread-Topic: [PATCHv2 2/4] x86/tdx: Rename tdx_parse_tdinfo() to tdx_setup()
Thread-Index: AQHafsJOKWcAaZ7hEkaz2WSeg0XXcbFJ2AsA
Date: Tue, 26 Mar 2024 10:45:59 +0000
Message-ID: <b32a41884209a5092c3e8fe837ce7fe250c68e86.camel@intel.com>
References: <20240325104607.2653307-1-kirill.shutemov@linux.intel.com>
	 <20240325104607.2653307-3-kirill.shutemov@linux.intel.com>
In-Reply-To: <20240325104607.2653307-3-kirill.shutemov@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.50.3 (3.50.3-1.fc39) 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|CY5PR11MB6440:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HBEnudnlQzsHrwxA0Q7i7SNn9FndMdytjTKYsUp3Du9sVV5EDJDq1EvCbdO5Bdicp1zFCRqcLbSNqn1gG9cXF2t99FLc7n2ZrGCWvhbz0y7pm4qccL1+cnmg6o+ueosbPyizwzUox6PNOZJC4AXxRtf8IR8p9BIhUWrQ9ar2GrRxuiJyeuX8G2HukoRDsibj9HOCgxVXr9eJJCxSYOS3y/QvlV6bRgvgLSMIAgNlDAlo0WqIrV4VrgyKTrW6j0Aah/V7iLZwvyp9Gr87fFirmbX8PFgfJLVojQpmPcymP25vzSdRK8CjVk/qiHP0rq/RLRCBaInvb720gHfKyXZOYXHfddCCNdhYseAdudyLs4lfVca3CR2YY/08lq4LzMegSb6j6+SlFBTxKHf2eaHw39mdsX2uRlRGl7HmPr0qY5IwtAY3jOX0Ixpajsabzw1a4rSbn5z+E7sT4qLxIdP7SA7G77kORWYq5k1LNqOU464nHw5gUSk4oWRPrml+vMb3ZsBKxbB2sYO9BvOmvdo2wpY0+Vp0W+DBaEswfU2h6BlrpbEDDiFA/FynwgXB1afeidEqHizAj/x2Irgbz2LTjfeBaqE0fBtsqtzH1XBd9W6l5qXhBsD5mVh/pFrxVe3PjN7Vt3OU0gWJHoobrSxnKlRY3wNW9lF6jOyQbJ5Y5zc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?clFtNTdsRmEvN0ZBem10bVdiWnFVd2xUaWMwU2Fsc003bWVob2w1TG1Baml1?=
 =?utf-8?B?YTd1L3ZtUkIwWXhUM0o5WGRhbWVvVVZHUGEvZ0ZnaHZmb3hsSUtHTEUrYUgv?=
 =?utf-8?B?UkllcUNicUxKYjZmNVo5akkxQnBxZ2ozM2hYZmZzY1lGWE1EVUl0M3ljdE5G?=
 =?utf-8?B?VFpEWW5RN2YwaEJseE1wQ21yVzFscEh2amNhNlo3NGJ3SGUrc2dmMlY1R290?=
 =?utf-8?B?Ulk0cUI1cFlOUm9scG9GNE0vZnM3K3dhbmY4V0xveVBTdDNGN2VXQnJ2TCtR?=
 =?utf-8?B?cmUyVXEyNHpKN3I0b1diT1VsS0lOZ1crczJUb0RUdGV0S1FVV3hnbkwyOW5S?=
 =?utf-8?B?d2hIL1ZtTk9ZNDVnZWNvSDkvR3dSRUcxdWZBTndscWVZRjcvTTNjMlQvWmZn?=
 =?utf-8?B?ZXNSME1HZ1RYcWRjM3FBWjJYRjFGWUhDdmJaWERETEUvekg5bDA0NVpkR3dD?=
 =?utf-8?B?eCtaQ1hxY3VsMGRLNW1EeEsxU2NlQ1JJamg5L2h2dGVaVmZRdE9yQ2hKaDMz?=
 =?utf-8?B?eC9UV2NlT2JrSDhuaWw2L1AzbmFKaW4xVkVULzBYNDJWaC9IK1BUaURVd2lH?=
 =?utf-8?B?SHg0UTFnN2dUSm9wWFhoUlVzOUY5aFU5cTdnanI5ZEhEUm84U1ZxdHNYUkpI?=
 =?utf-8?B?cVJyVVFZOU9Cb3g3ck9BZmY4WjN4Rzdsck9FYm1SQWFoU05kVGlCaUdJUG9D?=
 =?utf-8?B?QU54NW1obTArYTNNVVRmMHhOT0R4WlM3NXp1WC96ZkV1RmZEQmJ1MFVTUENx?=
 =?utf-8?B?UG45YmVpeUdrQzdYVTBVdytBQ3pTeDdjYTRDWFp4WTZieitsdkJjSDRLb3g4?=
 =?utf-8?B?SWNIOEJWN1pCWnZqL1RETFNQSWNTRUQwbVZlaE02QURYRFlBc0FnZ3lqMnhx?=
 =?utf-8?B?SkRKdUNZVENlejBvbXVWZzhSNEtkeHE1WmNFdWc4QUVwZUlQU2Eyb1hLR1g5?=
 =?utf-8?B?VjFJSGxiNkgzUDMzN0RHL08xWThzVjdtS1lrcHV3aDJyMTVQblA3RjBaWlZr?=
 =?utf-8?B?eXlXZ3QzbG9tbHBlM3FxdHlreldVVS82bGJqNnJFQXpINzMvK3d1Y1BhTlVs?=
 =?utf-8?B?UEVKdGFvUm1CWlhJTmZ3ZkFyZ05MbnNxV3ZkZmg1dWVGRlJkNmdleS94WXRO?=
 =?utf-8?B?SGVaMXRPL1lQcXVSVGd6aGRDYXVxUDNTb0doSmFRdE91eUk3ZWl2VkhIemJ5?=
 =?utf-8?B?MmYxaDR6UWhFWWF4bWlsbzdlVE9zRHRkZWJwdWRLZVVLRVo2cHBtcnJrdDNw?=
 =?utf-8?B?YmNET2FQRVVkbFI5SndoY0cydjAwbzFpQTM4ckFmaHpFbEdUNFV0TkhNS05t?=
 =?utf-8?B?ZDFRQllXQjNBVm9ITTBqanU1NWJuaGliTkQxQWo2UU4wWXRMQXFKUi9aVE4y?=
 =?utf-8?B?V1podjgySGMvcVNLeExXdk5UT2IvQlZKdUxVNjFPdTJnc2x3SytKY0NzblV0?=
 =?utf-8?B?S1VkK1lRSjh1cFordXB5QnVrTUZuOCsyNkhsRDJVcjJUemFxWHAyUkRIcmxi?=
 =?utf-8?B?UTRhK1NXcFBHL1Z6aDVReForMkd6UE9QVG5SN1JZazhhRXp4NEdzc0g0RVlO?=
 =?utf-8?B?Yi9mcEM0WEFlYjYxbUsvM0VjMVY3WlFPNVVaeEV5eExQdWZqTlVEM014Y3VJ?=
 =?utf-8?B?RFdBclVjVktraWd2d2xuK21tRUptakprYWhlK0JuakU0cUN3T0l4ejJDTXdz?=
 =?utf-8?B?anFoclVYZ3pUWmRVeFN6MjRiMmlnRUtYOUtpb2xsSEw4aTBob3JscDc2SitS?=
 =?utf-8?B?VzIxYmdlcDVaWFM1aUhEcEI3NXJkU1R0S2J3L3BxTy93S2FaeGoxR3IzQkNo?=
 =?utf-8?B?RVlGempjNmVMbnFWQlJmMXRQRU5ieWpobDl4WjkxbHJCcjV6Yjk3eE9XSGND?=
 =?utf-8?B?Tnc5amxmOEovWmFXSEVkM3ErTlphdGUyVFNFakFCMHZ2dEVha1d3MHJxNDBU?=
 =?utf-8?B?cS8rM015NnpkZnRXdFkxbzk0UmZ3TUd4NStoamtNZnpkbnM5VUhQUGc2RW9M?=
 =?utf-8?B?ZEUwd2k0alFOZlZhbGgzekRab0xHQ0R6NnhPZzlTQ0V2K0JPYmc2QVgvcDNI?=
 =?utf-8?B?WGpBRVFOV2ZBTmJybEtOVlZIS0FSVHNYZjRzYStCcnFFL3lLTjMxQWRaMmVG?=
 =?utf-8?B?NzF2MzRLN0owSS9tNG90RTl5S3MzOHlyRXVJYmIvOGJUZDVQaXdwK3RGQXlC?=
 =?utf-8?B?QkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7DEF2FDFCCC63F4ABFCFBAC10FBE5527@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0e0cee4-a72e-4b88-cdd1-08dc4d81ec72
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2024 10:45:59.2293
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H7aHQJFfSvAtt5O/DV+aEX9xv1ZN+ogEBXKI7BRBAaA3uo0QyPpS3aZWash8tdFwcEE/v1rLrpia6+WeeavgUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6440
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI0LTAzLTI1IGF0IDEyOjQ2ICswMjAwLCBLaXJpbGwgQS4gU2h1dGVtb3Ygd3Jv
dGU6DQo+IFJlbmFtZSB0ZHhfcGFyc2VfdGRpbmZvKCkgdG8gdGR4X3NldHVwKCkgYW5kIG1vdmUg
c2V0dGluZyBOT1RJRllfRU5BQkxFUw0KPiB0aGVyZS4NCj4gDQo+IFRoZSBmdW5jdGlvbiB3aWxs
IGJlIGV4dGVuZGVkIHRvIGFkanVzdCBURCBjb25maWd1cmF0aW9uLg0KPiANCj4gU2lnbmVkLW9m
Zi1ieTogS2lyaWxsIEEuIFNodXRlbW92IDxraXJpbGwuc2h1dGVtb3ZAbGludXguaW50ZWwuY29t
Pg0KPiBSZXZpZXdlZC1ieTogS3VwcHVzd2FteSBTYXRoeWFuYXJheWFuYW4gPHNhdGh5YW5hcmF5
YW5hbi5rdXBwdXN3YW15QGxpbnV4LmludGVsLmNvbT4NCj4gDQoNClJldmlld2VkLWJ5OiBLYWkg
SHVhbmcgPGthaS5odWFuZ0BpbnRlbC5jb20+DQo=

