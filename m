Return-Path: <linux-kernel+bounces-101650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E17687A9DB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 15:58:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 917061F22EF4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 14:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 688A841202;
	Wed, 13 Mar 2024 14:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jrVtsQ7M"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0740D41C6E
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 14:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710341913; cv=fail; b=rvovmAzoIrXMPaW3kdHUoNfptm3jWsOvzLALRBaYaWoPIqnbLEYAK/oDNN3go1Ko3/NuqT6bsgBtFDggmBCj3cSV87765RKiJITrVg0mQdUbTdo+UsnZ3DWF6nzjiB7321EOFoXORhbG+OCcv89mK6Uite7yP+VVz9yVB2pr1CQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710341913; c=relaxed/simple;
	bh=3ZHi/NU+G8U3jiEFby18CFcLXFKtAHTiMPqNo8JKTpw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KXAJxAMQGplP1r66kr8iR4nPCfc6vf6xKjfXsd7BfttdkvZpI/wV+6i4LsD9CzVNi4mpIccBiaJvZMWsz1ly/BcGD0VqYZSStfb9pRt1WM65dzqh2NFgz10Gpu0L9WUmT+Znh99b52RvmPIfbied+bwlt/s3AIqXRzNX5on1rbI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jrVtsQ7M; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710341912; x=1741877912;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=3ZHi/NU+G8U3jiEFby18CFcLXFKtAHTiMPqNo8JKTpw=;
  b=jrVtsQ7MoRZ2SRaBRLR9P1aYUzlT0g1/MvnYBZPXqwKxy137RR9a19Ca
   tZaPbtaZMEL65TwqGo7uFt9qfvWdkI1zHUYF9GP/TZb5+ADSSdYdpmXhp
   8E4cHeu9crLQbBr7h3bc9fp6SWC8xaXSKSc53Zfe4M2wK6ofVrA0bESNw
   ZxBitRCY4FweulMe3B6yUfj7dyN7y6CJ3LaXvdlWtGW6d1XkksAmWJn4T
   fqQjXvgqBWn85boTz4eTI/2+FRNGHxu8IpGU3qcnve296LxckSMYpraBu
   rPOfZK5U2P2FsUtNg7zDzatRMIaPKp6b3+PgH/cGqY762qcXoq8hIqh5I
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11011"; a="22624875"
X-IronPort-AV: E=Sophos;i="6.07,122,1708416000"; 
   d="scan'208";a="22624875"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2024 07:58:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,122,1708416000"; 
   d="scan'208";a="16547816"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Mar 2024 07:58:30 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 13 Mar 2024 07:58:30 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 13 Mar 2024 07:58:29 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 13 Mar 2024 07:58:29 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 13 Mar 2024 07:58:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XJmmQmeoStSNKo2ygf4LEWO+t8G6MNGcnHUd6LntWqQtDuERbOR8zW+Q+gfvTuInmOerRF4cYnckflTHT6v+M2S+/cZW73NeWuaSUxbP5wPkyd05Su0QXd9OydbpMtWuq4CHRf8Ujuwnp0qv8mP4MM4LFgUniujUZMZgJk5i+Xx1hXwWbqe4TFAW+lVw/zLWDDyJiEM9qa1xqcPL+rIn1a4mBAN61c2gXnNx79dWveaRrf0JqUZyLFOJU3gwoKczfjWe6Uvb5ROjXHPYCXjj1CBNxp9usYcaIz9TqtR4sdWOdIcvOWwSoXXQyM0BJLxka4ml3Ts0WCdkFkUWnOSN7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3ZHi/NU+G8U3jiEFby18CFcLXFKtAHTiMPqNo8JKTpw=;
 b=C0RbmJt9PaEc88cPhK8LKEqZqAIHIfytJ0NMIsoHCnI4d0cnIdwXKbRloXm6a5nVye8Xe6A+Rg3hadC62OadSc0lj7qprzjqNcRPXPbeLOU8ctESUAksOzUs10X6AQm+ACK1DHrM2eQeTBSgmlbjoy8FeAA9PlOv0cN9xRqIFRyhyIMYfBSXnvFwKkifGkcMJfdEZWh40lhF0xy5NY6Gpe8GLch51z1QcBBfJHC1Koq495D3I9HE5NPUhRfG5pb7m/K4dPwneihe2NbvFjSsmT/bHKU0WvFWHah6T7ODZIuAeQqHdkQEUikdKJjgTyNxsphTY2/JhngBjnrnWmm7Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by CH3PR11MB7673.namprd11.prod.outlook.com (2603:10b6:610:126::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.18; Wed, 13 Mar
 2024 14:58:27 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::fc9e:b72f:eeb5:6c7b]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::fc9e:b72f:eeb5:6c7b%5]) with mapi id 15.20.7386.016; Wed, 13 Mar 2024
 14:58:27 +0000
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
Subject: Re: [PATCH v3 09/12] mm: Take placement mappings gap into account
Thread-Topic: [PATCH v3 09/12] mm: Take placement mappings gap into account
Thread-Index: AQHadMzQbQ6iiqjCZ0m44IAU+ZlTp7E1YViAgABi2wA=
Date: Wed, 13 Mar 2024 14:58:27 +0000
Message-ID: <6457f3a65ebb25811ce57be9f8da39fe475496fa.camel@intel.com>
References: <20240312222843.2505560-1-rick.p.edgecombe@intel.com>
	 <20240312222843.2505560-10-rick.p.edgecombe@intel.com>
	 <615a783a-0912-4539-94bd-f1e09535bf38@csgroup.eu>
In-Reply-To: <615a783a-0912-4539-94bd-f1e09535bf38@csgroup.eu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|CH3PR11MB7673:EE_
x-ms-office365-filtering-correlation-id: afae2643-ed2e-4e9d-f97e-08dc436e0a3e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zmunS2lRYyCWzkiKhWMpCakLONuOQmOvE40XZ1R0hotCmkXjWVD9ExNlZIgxf1I7s212qZppzjDijxCGw2ipwInhMZAR5iLyXbTQXb6lqL/PzJR5kOXxe7MAanbIZL/DSPvKfRdVvnnKQD9X8v5lZ6e37Y6ZkzcuHmIN2sBC3VB7NB5pynNrmhscmKzX/u5pv+psd+WKEXouDXbgglmTOVna5uvy1tQfASnidbTf31gBJhXkFRN2bwZK/OMBS1OJgkHGv6ECvwcNKgsfzyWl9JUxVlYQ8/HXOsVqgjtvWXq0OrNoQ786ddtdbdNf7uhtAPvtDaicUg3OdR4rXohiCx1pcnvJ/+Cl0CbsvOgzx/G5KivoCGGNGl4qEGzVi6EAavKDdaHIohIyjrHkvRnUTVMOBaT3DlyHdb8/TU1Dc+054tad8GZb/hUbhgT2+Lhfy9rwS6JfcT+5BuZ6bIPU0S523yN4rS5hGRAuzQ1REpdVXf8yEs8GBeEQvDQGT21u0r4bunlOn7VabHv+va75RGIgGAFivdQqoA32wgFR1/OUOJnqmsMVVMqueMiWHMyNx4vAq/91d1r7RjvCQhnhguOivwOEZFHkeaVyKaJNVl/d24u4FLfSkvBeuM/oPyZw6PraBbfaSRxQ5UvNn5UV+QQisIc6w81FaPNmwVj6PcPXRoDP3+BYO0uhuJ7HK6nQpI58LpGfNBxN7NXvSi2ymsLHCUch212/AXlhemdpFXI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(38070700009)(921011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R1ZrWExOak5STGd4WUs0UDkxOVExNnJtV1FlNWFVZlIxR1lqRFBtNUhwbnll?=
 =?utf-8?B?bHR0OFpOendjenROamdpaVhYMkpaVm1ZNDFVWitLR3RsS2lMUmtZeFphV0Jn?=
 =?utf-8?B?OHN1bS9XZzY1VFNuZnVZeGNhNXFiclMwSGxQTjJSTFp1bSthM1gvaEhMN3ZM?=
 =?utf-8?B?amNuUWp2U2ltc0VjcnVhMkMxQmxrbzBmNFltbkQvMWVGM2pKZ0lKSmJ2WVNJ?=
 =?utf-8?B?Z2RhNlB0ejlSSXVKQUtZNkh2d2NRWlhqY2RQUU8ya2d1dGM4LzBoSDl5M1pY?=
 =?utf-8?B?bVN2VURzTG9HRldMVXYzd3B5Y0NoeEdEY3hsZWZubFFiUXhKbHg4eFNxdm1K?=
 =?utf-8?B?dHJUemNvTjNXRjJFL2FjWWpQUXhTejE1RStpZmRZK0pmaEFSbE9NU3FudGYr?=
 =?utf-8?B?R2lzOEw1Ry9uMnlKa1laYVFveWxoVGx2REtMYjhDdjFpRUcyd1Y2T2VQQjZM?=
 =?utf-8?B?OE1SNTRTUGFhVGxaemRPdHQ2KzRnS3pXN2hqZkVNaUdzbEcxWHhvOENHeVNW?=
 =?utf-8?B?QlV6dTZXOGFtZmJqbytURXpNK1pwVXYrQU9MbXJHTTI4UUxJaFlQUVA2dEFp?=
 =?utf-8?B?Rmh4NEVmbHJaRXhNZE9nK0hpbEpNMEx3dkJMcVY4bmNzRCttQVlyM2hZb1VR?=
 =?utf-8?B?dmtnVzZrVk90a0xpMzdJdlNnWHhyQTdKdnFlanFRWUl0cFBWTlV5WEdhYUxy?=
 =?utf-8?B?QnYzWnlOa2JkMmxJQVBCeWxFS0kyV2RMaHdiMTlPWEFEcld2cm5WVG80SEZP?=
 =?utf-8?B?c2FBMGhpSU9lZGdYeGptLzlzVGk4cXc1QWNVYVdqTSsrWXdZU3Awb3ZSSmhU?=
 =?utf-8?B?YlljaklMUnJiVmFEWHd2SHN2MS81NDV0WnRaUnRsNTdPdFJSekNZMTQxb2N6?=
 =?utf-8?B?L1FZMmNHQzJ6ZXVwY2doSXF6UzRpaUhJVHV0b0huZmlZM2N0TzZCdUhnWlZh?=
 =?utf-8?B?YVlITTM0TTNweXFzRmNEVjF3RWkyazN3UGJQMXdwd0ZyRFlJdFdFdkExZWgr?=
 =?utf-8?B?Q1BOTUU3ZnI4N1A5Q1RWbUZjZ29IdlMxMDNYSE5rbnZobHZZWDN5MWJ5Mkd0?=
 =?utf-8?B?QzNqWXdWTVJpdllSMXpFRXFNZWVMMEE4aHhsZEZ0aHBTRTNEbGo1NVArVlJR?=
 =?utf-8?B?dmVwdDE3bEVVVW9oWDJWQ08zc044UnlxTTNWUk05alZsd0ZTL2RFeTErZ1dp?=
 =?utf-8?B?VzI1V1FwSGRJcGN5ZzNoVHVsa1JPekpSUnUzV0ZReCtkVFdiek8zSmk0ZXdr?=
 =?utf-8?B?NFM0MGg2SGhMb2NmTlFHRmFvdGFnY29Ec0tVM00vaFlnSXI4UFcxdktObFZJ?=
 =?utf-8?B?ZFlVRDdTQm9zTG5xSlRmL3lSNCtMQUcxeG10YUZZZ1BHYXBuejc4d0dPblJU?=
 =?utf-8?B?aHFTR1ZUbCtydDlxd2RSTWNPVVUvMjVmNktTRWJ6Z3dYN21aT2JOVXFTVEwv?=
 =?utf-8?B?N2ZLbTlRaEtTeDZ0MmVMcUh5dUtGdmJGY05aNHhHaktCM1dMUGVuNXRCU1lT?=
 =?utf-8?B?T0ZyNmhzdnhmQTZRYU9TdkFzNXUrb1pmUUxNSTJEQ0pYRU80dWRSbW1FVllY?=
 =?utf-8?B?cFlqQThvbkxYRVJNYWxxK21QUFM3dHlkWjVCcmIxVG5IWVpoNjRCV2RWY3E0?=
 =?utf-8?B?dDRSR3ZwMG9CTmxvN0NsVDlJRmNmTVhNSTBCalpPNExFWDJXSGpVWHFDc2VH?=
 =?utf-8?B?eTVielFqblMydnNzMHBpZmE3TjlJTFM3YUp3dytFQS95WUQzL2pCNlE2WC8y?=
 =?utf-8?B?T3k5UmxFcUNuQ1JDK1psSU1kdDJxQkJpUEUvUjBsb1VqTStoSnBjVSs5NmJM?=
 =?utf-8?B?RlUxWXF4SFhBWmp5aHowUDU0bCtnU1JKL2s0STdBUkI2NUk3L3FPY1Zvb0JU?=
 =?utf-8?B?VzQ1UFpRL3N0UGsvS0hUTC9LUmFtMklZREl6aFVYUHpnSFNoWDZZZ0c1OUVG?=
 =?utf-8?B?YnBIVFM5bTFSRE0wRDdpb1pXSlYvZkpVelBJbnRYMnVvWmUwK0JrdytUcDZz?=
 =?utf-8?B?NVE2MU5sSXZFd2dkWFpEZkUva1h1Y082MnQxZE5meXNFcnVPV2dPSEVoMm9K?=
 =?utf-8?B?cUMxSlJGS0pkNTdSQUNOaGt1TjByaUN6Rk0rQ0VVUEg5Zm1hcVdVRGxCSmg2?=
 =?utf-8?B?eGRmczVLRk52eWNNdmoyOFI4eU0wQ2oyUXRORmZLT3A5bmtWYmJ2bUd2Tjcx?=
 =?utf-8?Q?fj85k9Ze+cyze8jdZms5DtU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3AC61150AE0AAC4FBBFC5082B8B4123B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afae2643-ed2e-4e9d-f97e-08dc436e0a3e
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2024 14:58:27.6828
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ffwUAiNrtzhNzyySwZgK+AsQ51S24yfzhp2rrV+YFL2R4PEyHunFy49tlDrfAXOqyuYpMeAmqYgQviLaJifd9Godcr+UKuNQp4aweEx7CnQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7673
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI0LTAzLTEzIGF0IDA5OjA0ICswMDAwLCBDaHJpc3RvcGhlIExlcm95IHdyb3Rl
Og0KPiANCj4gT25seSBhIHN0YXJ0X2dhcCBpcyBuZWVkZWQgPyBObyBuZWVkIG9mIGFuIGVuZF9n
YXAgPw0KDQpZZWEsIHNoYWRvdyBzdGFja3Mgb25seSBoYXZlIGEgc3RhcnQgZ2FwLiBJZiBhbnkg
ZW5kIGdhcCBpcyBuZWVkZWQsIGl0DQp3aWxsIGJlIG11Y2ggZWFzaWVyIHRvIGFkZCBhZnRlciBh
bGwgb2YgdGhpcy4NCg==

