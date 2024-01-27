Return-Path: <linux-kernel+bounces-41379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 691BE83EFD1
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 20:46:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14E90281798
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 19:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75A0F2E62E;
	Sat, 27 Jan 2024 19:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EoIMjNb1"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 201A62A1C9
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 19:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706384789; cv=fail; b=ZjAHczwwHoPL1c8AF4k7qPjajpLaiynuecrhddbpzPkeSp8J7wSVlTwPPizpvp6H+8eDcDOPMgKtt5BmsRy7+diMnq9TG/2QzrDf7qct+lpHMLwKfM3CRp4eCuFOolLV3pBj0Nk354zAMN5/rJGIHO4StDC3sEaJ6HLvNU3u2go=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706384789; c=relaxed/simple;
	bh=GI4mvUfX5e3sum+CH0W6ZnfBmXUrMC1KRWoLskpBFCo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DeNvQNrYFIRraKJaQivlRFzUWRENsa46AfKX5+SugHSbToWZMPtxSW1HmsTs6T1gmqn3KNC+1YIV/oIGhbfOdbHIDimJGEdVpFH/Kseg0vWlNJb1N52SNv/oImZBWyqorL+hCWf0v6b13BJ/9WdV+48EXcempePvBD8IuutRNCQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EoIMjNb1; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706384787; x=1737920787;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=GI4mvUfX5e3sum+CH0W6ZnfBmXUrMC1KRWoLskpBFCo=;
  b=EoIMjNb1sGp7Il5lnhpZaS6Q8MdWSrwNCyQgHCaE4U1kNqsWrZEnTNiw
   lPa3j7dFtYNIKBCb/kFqAq9uLLxwj4iAxmvVJ9CVCac9JqSCPvmLwNXSk
   XiZAJEb8dmxY6WjJ3IFvnlhNP45fQLLSfsg4Ayaot05PR6KewaWAVZONv
   DWpUDVToT5jEWC40s1z6b82l1JMDWYrCVBPUGa9SGMm+KsWtWJ5VD18I9
   EQaRt8YHkb5PptqCE+jomlOSKgxeklofhYFF2SpiGYROQ9NUomiA2fQmJ
   YjqjN2pf2BlknttYkOFmm6FVQL9FdsI3KeW2zdxfEqeM0AKd73eohagtj
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10966"; a="10092941"
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="10092941"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2024 11:46:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="3024120"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Jan 2024 11:46:26 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sat, 27 Jan 2024 11:46:24 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sat, 27 Jan 2024 11:46:24 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sat, 27 Jan 2024 11:46:24 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.40) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sat, 27 Jan 2024 11:46:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S1oJDaLUK1xp0i8CplEgF63DYndpxW6K0BiD90LPESs0TijwNNzz0lOqkVA7K1kDPx/LnoahH9anPyzM4H1HGYwAMMoTV3irwHRsURYg9P5+bytj6OrLCTfHSEn59iFfp4TmQnkwu0SZ9P7qziQEM0+h64nrWOLMH2Fc2j3je/YmRWmFNgb15KZccSx9ablfcozf4hVZsFqP8x73Y9o4g+jlT3vSKny1r37gPzHaIlLyN6JwYiagKrAUtljBpQZi3dBEdPPCBJLpeVN0oiPZubl4CSUbaxxkud4y/U1f8MXhPvxDYy4e0QLi9H8jYbEDJxqi+U45pq+vGaASRnGNcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GI4mvUfX5e3sum+CH0W6ZnfBmXUrMC1KRWoLskpBFCo=;
 b=MoGl2MJWtvK7xARA1g+drKOkS96QD2skCNHjPUpFICzJH9sh41bv75CYn3vRfdzCGAVOtJ4n3DoORDC+C2SntfU6oTumEjiZUJEsdjAAYTWTDolHoUAH1Bo1jDEIXH1aKaLLs/OWrXolWohIWQTS46O/r6HnyLUa4O/a6X+kprTmcMkae12uD2SlvFhGJvLPBsM2meoHdNjSv+S5dUWPs30kH+A4hKOYtcXrT3hxLlMOzoMs3JytECPYtHxwZAaoZBzGOA4D4FcD0296Amo100D49mdOLXfSvCoRAjt0f8hY1617GOTpqEB3xKH4ARXXfdXtvV7barFRakDhDMB5fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA1PR11MB6734.namprd11.prod.outlook.com (2603:10b6:806:25d::22)
 by DS0PR11MB8231.namprd11.prod.outlook.com (2603:10b6:8:15c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.29; Sat, 27 Jan
 2024 19:46:21 +0000
Received: from SA1PR11MB6734.namprd11.prod.outlook.com
 ([fe80::8ccb:4e83:8802:c277]) by SA1PR11MB6734.namprd11.prod.outlook.com
 ([fe80::8ccb:4e83:8802:c277%4]) with mapi id 15.20.7228.026; Sat, 27 Jan 2024
 19:46:21 +0000
From: "Li, Xin3" <xin3.li@intel.com>
To: "H. Peter Anvin" <hpa@zytor.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: "tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com"
	<mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>, "luto@kernel.org" <luto@kernel.org>, "Shankar, Ravi V"
	<ravi.v.shankar@intel.com>, "andrew.cooper3@citrix.com"
	<andrew.cooper3@citrix.com>
Subject: RE: [PATCH 1/2] x86/fred: Fix build with clang
Thread-Topic: [PATCH 1/2] x86/fred: Fix build with clang
Thread-Index: AQHaUQjxIW0LUx+n7UOybQMQ5s4uu7Dt90oAgAAXPYA=
Date: Sat, 27 Jan 2024 19:46:21 +0000
Message-ID: <SA1PR11MB6734916F2BB7E296A6FEE52EA8782@SA1PR11MB6734.namprd11.prod.outlook.com>
References: <20240127093728.1323-1-xin3.li@intel.com>
 <20240127093728.1323-2-xin3.li@intel.com>
 <49BA730F-E9A0-44AA-AB62-D2F40C5C11DD@zytor.com>
In-Reply-To: <49BA730F-E9A0-44AA-AB62-D2F40C5C11DD@zytor.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB6734:EE_|DS0PR11MB8231:EE_
x-ms-office365-filtering-correlation-id: c1d6dde9-9825-4f89-1bb4-08dc1f70a2f9
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YssNIGWR2M1TAhQC/VuI1YQUKcQ8ZtO1IyuOC74TcmgbH5sH0QSaJJt3dv8kYVkzph4OEYUrOB8gHkWwHJQB0ag6CtfmdzYjUEB/Fs0EW2F6FAtEFtQv/TyE+oTD+EszsheW3C7k+HSNzyiz8URXG4fNBM1b4tOGkIDpS+/qaaOsqelIC5zAg5QmqCoqNo2dMbMGbdixBcKOZABpxnW61KeQaMRjj0u/c4TGcEwFKKu3so5iYggSDT8MPe1kTFVmRlrJXfWrVjx3eMaMRhblISFtDDWP/EtdTo0NL8fLm82dzGyiHFwXX4hqtNreTmFl3s0PUUj+EkSkFqIOCaYZrwRfLsQElBKrBYMK0TfcSxN0YBeoLdgEvloSN0GF3FPGfPHAKw5UQVOJDoT4/QyixGIwe1s1BKI303hcigxPF1kmUwXNcB/+hfpDhqSjd6fjfWy60Xw96k44E2/pmOvfDcCtdRLhvD0GR/9lOdEUBabqzQxwtTGTgJyeQZpcYriJGJyN+DvPkvUMqi58xvPqvssTewlK0/glUICA3mRLvmgzT5O6/COmtAbd/PmU8mXcmbFvhFUAnT+9zNm9sW3Q5YXzBHE/Lv9CRKijzsdZHH5T7B9vj3y+HCPDiCS97BxE
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6734.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(136003)(366004)(346002)(396003)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(41300700001)(9686003)(478600001)(7696005)(6506007)(71200400001)(26005)(52536014)(8936002)(4326008)(8676002)(5660300002)(2906002)(33656002)(55016003)(76116006)(66556008)(66476007)(54906003)(66446008)(64756008)(66946007)(316002)(110136005)(86362001)(122000001)(82960400001)(38100700002)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OUt4N1Y0ZndobC9GdnVXdUs1N2FmSGlCaVh1azVVWW5GWDA5cks1ZHR3NUJV?=
 =?utf-8?B?dzNvOGFWZ2prZi9FK01zSnlRTm96OXlTUlJPZXJFT0FJbzBrV0MxTFlNeDEw?=
 =?utf-8?B?MlJPR0VRbEVoYWVhaDR3K29lVDVCa1ZGd28wSFFuenY0QmdydXRlSU5tL0Va?=
 =?utf-8?B?eTlvRHJYY1lobXBUYU9wNUdvek5Sb2FlQlRSRVA2VkpRSnZTc0o3b05GWkRJ?=
 =?utf-8?B?QVk5V2VHV1p1UUQwVkJzY0Vycm9CaU9ycUpwbjFPYXJFbVUwblFtd24zbTBG?=
 =?utf-8?B?QTNLOHJVczZMbG5LQ0l4S0pFckIzTTJDYW0zS1E5RHBEYTNlZ0djVkgrUitm?=
 =?utf-8?B?c1pxaG5YVUJieEtBVEw2YmoyREd5aU1vSnpPdFM5U25xUkJpR1BSazd3c0Yz?=
 =?utf-8?B?ZzdVbGt2eHNpVzI0Y1hGc3RrdG9GZURhSDJYT0d1ekg0YnFSV2czcEJJeVVC?=
 =?utf-8?B?ai9XZ2QxcEE1a3dheTN1ZEJGSTFDUmdBbFRocjJGZ3lzZm1aK0ZsSVNOSWxF?=
 =?utf-8?B?S2lpUkZKUlQxeEY3alFtaVR6WjRGWnRTSlJDSDZyR0RKZ1NMTzlRYjJ5QU1S?=
 =?utf-8?B?bXg2bWhTN2VjSmVaVS81UlRQcGp3bktGOHAwa3paa2VSbDJuc2puY0t5WHdq?=
 =?utf-8?B?ZjQ0N0xZWEtIV2V0VzhqdDA0Q2lGampkT1pvZ3gzdUtkQjcrUnpaaXQyaGhD?=
 =?utf-8?B?WW5XUldYQ1FBNEY4QnB2SVdNMmtZdXdXd2FYMVJOZHRxQ2VQT2xSeStyRC9R?=
 =?utf-8?B?WGJjZTl1dHBGTTh1TnNGN2J5U1ZZUXV0aytHdUk5bzUwSXNwdTVIZWZONFZJ?=
 =?utf-8?B?UUI3VnIwM3FZZHN1WHdrd2U2NWpteHY5d1B6c0Q1M2duOFRZZXYxdzdmSUkz?=
 =?utf-8?B?anZvdXVPbjZMVithVzM4a1NteHJMeFFUemdTSlUwL2J1emI3YkZCVzMreEM4?=
 =?utf-8?B?T3MvSGlFU2V2djlxcTJlRWNQZ01LU25JUjNJVVBES3FBeVhjUC9DaDREQkFU?=
 =?utf-8?B?Uyt1bUU4QWhualJob2VxU1JwQyt3and0QlZYWEFGNEtSWWwvdExUdjdVQlFk?=
 =?utf-8?B?QWZ1VHV2dWM0SDVsZXMrb0w2Q2JQelFuOFRzL3NBNEcyaHAyRXQreEx6OElo?=
 =?utf-8?B?dnlKdi9lbVZOYXlxSlFtVzNPcUtkT2VzRk93bE1WMUdOTE5EaDg4TEZacXZp?=
 =?utf-8?B?UzdGdmZWNi9nUTlFVlp6cDN6R1Y1Q29RZFdEUWIxaFZreGVEV2RJV2NzR1Jx?=
 =?utf-8?B?QUZjbnp4U2J6OTdta096VFh2bnEwblNMcE5tZGU3dVQ2QUJIcjRCcW01dm0z?=
 =?utf-8?B?Nk9BNmREcjcvcDdYVGVGRU9rakNsRHJnWTR5MThGQ2U2cEJGeklkbGlKY3Ez?=
 =?utf-8?B?dW5YVnZaZDdKcGZKeFM1NjJVTVd1Y0xpSzZVTlRYQkZMK0VRSElHM1hXdzVJ?=
 =?utf-8?B?MDhveUx3QVlieGpBS05pbmtreFBsVXhRL2tlYUVFLzBiTkpnNDBPWStwM1k4?=
 =?utf-8?B?VkZGMFpHSG5kdDBiVElTUTJ1OTlpZ3FkRll4T014dUpqN1RPUDJ6T0pROFBJ?=
 =?utf-8?B?YVo5b2piTmxqSWhHKzhiS1dFckFKQVNjV25kMmlQQkwyV2dnclhjc2pYNkdS?=
 =?utf-8?B?WHVLd1hvcUZBZG5Tc0VpVVIzeE8zTDdmbmdpQmtjekl3UFNGekVBN0JFZmh1?=
 =?utf-8?B?UzhkUmNQa29ZWHF2dFExeE5tZXBPa1lwYTJ5clBBWkZma1hRREdDbEQ3M3R1?=
 =?utf-8?B?eUNSdThlcS9XMGpUUVlzTVc4NGQ3TitybHFzWEFnU1JENU53YnAwVnVaa2Zi?=
 =?utf-8?B?VU5PZUpBelZjcEpaVlRlK1N4ejZwbFEyN3h2eHlqYS9KOVNlSnEzS1ZaSnVp?=
 =?utf-8?B?b3Y1VFpxL0p2MzRvb0JwWSt4NU9WbjRhUTZ5d01lUXdCSWlGWWtLYUU5eGx6?=
 =?utf-8?B?V003WkZzQWxJNXk3Sk1JNkFkNmlXTHFhUXVteGJ5bUNCclpLSDNMVnpFK1F1?=
 =?utf-8?B?SGNGVlB4Vkp0MGloRzhndVU2Q2pjMmlKWGFIdFZtMEF5a3IzRSswT1c2eVBV?=
 =?utf-8?B?L3NZQ2kyaDQ4Q0YwOFBwSnFJNUlMaks2eXI3SXZ1clM1SEUzM0VxMnU1MXJF?=
 =?utf-8?Q?EvyE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6734.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1d6dde9-9825-4f89-1bb4-08dc1f70a2f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2024 19:46:21.0508
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YcioStLnLI7PV9kRNoq4tp76z5jh+p7Menac558BspumlX36WSEGipq8XfA1eXk3psv3bO+gRieaWy0T3lFDSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8231
X-OriginatorOrg: intel.com

PiA+ZGlmZiAtLWdpdCBhL2FyY2gveDg2L2VudHJ5L2VudHJ5XzY0X2ZyZWQuUw0KPiA+Yi9hcmNo
L3g4Ni9lbnRyeS9lbnRyeV82NF9mcmVkLlMgaW5kZXggZWVkZjk4ZGU3NTM4Li41NDI3ZTBkYTE5
MGQNCj4gPjEwMDY0NA0KPiA+LS0tIGEvYXJjaC94ODYvZW50cnkvZW50cnlfNjRfZnJlZC5TDQo+
ID4rKysgYi9hcmNoL3g4Ni9lbnRyeS9lbnRyeV82NF9mcmVkLlMNCj4gPkBAIC00MywxMyArNDMs
MTIgQEAgU1lNX0lOTkVSX0xBQkVMKGFzbV9mcmVkX2V4aXRfdXNlciwNCj4gU1lNX0xfR0xPQkFM
KQ0KPiA+IAlfQVNNX0VYVEFCTEVfVFlQRSgxYiwgYXNtX2ZyZWRfZW50cnlwb2ludF91c2VyLCBF
WF9UWVBFX0VSRVRVKQ0KPiA+IFNZTV9DT0RFX0VORChhc21fZnJlZF9lbnRyeXBvaW50X3VzZXIp
DQo+ID4NCj4gPi0uZmlsbCBhc21fZnJlZF9lbnRyeXBvaW50X2tlcm5lbCAtIC4sIDEsIDB4Y2MN
Cj4gPi0NCj4gPiAvKg0KPiA+ICAqIFRoZSBuZXcgUklQIHZhbHVlIHRoYXQgRlJFRCBldmVudCBk
ZWxpdmVyeSBlc3RhYmxpc2hlcyBpcw0KPiA+ICAqIChJQTMyX0ZSRURfQ09ORklHICYgfkZGRkgp
ICsgMjU2IGZvciBldmVudHMgdGhhdCBvY2N1ciBpbg0KPiA+ICAqIHJpbmcgMCwgaS5lLiwgYXNt
X2ZyZWRfZW50cnlwb2ludF91c2VyICsgMjU2Lg0KPiA+ICAqLw0KPiA+KwkuZmlsbCBhc21fZnJl
ZF9lbnRyeXBvaW50X3VzZXIgKyAyNTYgLSAuLCAxLCAweGNjDQo+ID4gCS5vcmcgYXNtX2ZyZWRf
ZW50cnlwb2ludF91c2VyICsgMjU2DQo+ID4gU1lNX0NPREVfU1RBUlRfTk9BTElHTihhc21fZnJl
ZF9lbnRyeXBvaW50X2tlcm5lbCkNCj4gPiAJRlJFRF9FTlRFUg0KPiANCj4gLmZpbGwgYW5kIC5v
cmcgaGVyZSBhcmUgcmVkdW5kYW50OyBpbiBmYWN0LCB0aGVyZSB0d28gZGlyZWN0aXZlcyBtZWFu
IGV4YWN0bHkgdGhlDQo+IHNhbWUgdGhpbmcgZXhjZXB0IHRoYXQgLm9yZyBpbXBsaWNpdGx5IHN1
YnRyYWN0cyB0aGUgY3VycmVudCBvZmZzZXQuDQoNCkFoLCByaWdodCwgLmZpbGwgYWxyZWFkeSBk
b2VzIHRoZSBqb2IhDQoNCkkgd2lsbCByZW1vdmUgLm9yZy4NCg==

