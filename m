Return-Path: <linux-kernel+bounces-44083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF971841D21
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 09:01:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D02A1F242B2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 08:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E153B5467B;
	Tue, 30 Jan 2024 08:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PXtXkF7u"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B5254668
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 08:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706601702; cv=fail; b=DXwjek2If9hcdP5SHa/MZeuRCg+zeS66UTQbA2l62/UuFyG7DpiZ+u2e8KR92kmbHNW7t4REYuNC2Dd9tULbwOCkJTvVpBeN8QO5HfKEzpurRlu5HxvCT1t9ndrKPMXs/l0mPwr4g7pDzcmmkWVf336NGBO7O/4yzqWSDdiY/G8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706601702; c=relaxed/simple;
	bh=59g0nEH/BW4Hg2DtpWEokC6LmafGH2GNhwgxKR0qL14=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fBrM6/wVvQfr9/eLolP7ezzv9FmymHytulHwRT7Kl4goSnM1EMx044V+SOwvmc0/tpeAIVN/LjBWBTZyhXGA7w6ThLRQhJEwo4Zl6oHwlsN+4uwIlBNVtQ6CkQjjWOvJO7t3/RUU8QqZbHIYn98rZx+HVxNa6YXaD5vUsyMfzhY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PXtXkF7u; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706601701; x=1738137701;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=59g0nEH/BW4Hg2DtpWEokC6LmafGH2GNhwgxKR0qL14=;
  b=PXtXkF7uBB/1bUd1z/ymUBgntPH6/WGLxcyALey+OHpn/jrYF2tseEFl
   oWD7i6i52Us8hfUIEdb/GUkZ8Jl/XN8ZNiXyHvwQM98+KXsKuipCP0cJT
   SPDHHunu+dbX4BQMuAh8vxyKjSnhE5MTsN7L8IE+q0xvBJRsDUPZhOctR
   cLG1QdT76nti3f2330z6S2PBg9WXO5Fo254sSm+wrjSuRoVT8IpU8qFFr
   M+pYHU7EhO1UdxNLaddpiwGGLDP/UWdCOORZbY02xbsoyMfNR+Px8UPGH
   Cx/082Fu6dcEBCh4EkIJPfBZmcUp1m96DaLvt5Iph/yzlTK1ZlIzWV3v7
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="10308568"
X-IronPort-AV: E=Sophos;i="6.05,707,1701158400"; 
   d="scan'208";a="10308568"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 00:01:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,707,1701158400"; 
   d="scan'208";a="3724387"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Jan 2024 00:01:40 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 30 Jan 2024 00:01:31 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 30 Jan 2024 00:01:31 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 30 Jan 2024 00:01:31 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b4cSSfK/ahxD5z6zP+E/Pdq5albv8soG98WBbRYQAqf/HrAqRQqdSubK8/yzJKqjg/vx/1xxD3UKedso99wOM/fLO3LLQTsmRaZBFMBxZHaCrdAkimm6GWDGp57KzfY2QK4T+zeRplatwvnLyY61T9rVD6mbn6IKnk0p5jNpSc2UtL/lTpVkVDtsvQA6X10Z6+pVN6CDvYM+BkRvCaIYwh+U1dRKyQ9Td6D4aWDgQOfUCItQyveuHIC9UKTSB6qzyrvJCo3l1m+1ePa5OW/Vm375G3goiFqI0rfwgpTIINO0sPEwcfq8AUCY+6fZsEpicR7HxVugj9GhqB0GWjPTmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=59g0nEH/BW4Hg2DtpWEokC6LmafGH2GNhwgxKR0qL14=;
 b=knTw+sKBHi3IchPaG9tud3GkmziHtBF73gANdXWvVJw5kZZdBKnavnA67ijuBni6qql35BHvhywHwTpcM6PSUFU/2ib9gzhdZccMzH9FbcpFSIqZdPV20UmZmlUqGfAgPXUBgbfHvX7WbbhCnGHg9l3Gz1rrqVNIGBdxZl5ZCQHoz3B3Mv5zVURF8QVB5HZh0yb++8xvagibXby/E/23O1ntiPZ8Z1UQVy9q+3lEWvpsC8QFMAODsndgLQkrUq6HBg+rsl7EgTcVRn4GVT7lE4jt1ISzvJwJuArKCgmaY8FHn1bpwqcRf3S/PfBN7o7+fHRp+xBGK/1frfyGBd97mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5750.namprd11.prod.outlook.com (2603:10b6:8:11::17) by
 PH7PR11MB8571.namprd11.prod.outlook.com (2603:10b6:510:2fd::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Tue, 30 Jan
 2024 08:01:29 +0000
Received: from DM8PR11MB5750.namprd11.prod.outlook.com
 ([fe80::f1b2:bfb1:b1b:66ed]) by DM8PR11MB5750.namprd11.prod.outlook.com
 ([fe80::f1b2:bfb1:b1b:66ed%3]) with mapi id 15.20.7228.029; Tue, 30 Jan 2024
 08:01:28 +0000
From: "Reshetova, Elena" <elena.reshetova@intel.com>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, "Hansen, Dave"
	<dave.hansen@intel.com>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>, Theodore
 Ts'o <tytso@mit.edu>, "Jason A. Donenfeld" <Jason@zx2c4.com>, Kuppuswamy
 Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, "Nakajima, Jun"
	<jun.nakajima@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, "Kalra,
 Ashish" <ashish.kalra@amd.com>, "Sean Christopherson" <seanjc@google.com>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [RFC] Randomness on confidential computing platforms
Thread-Topic: [RFC] Randomness on confidential computing platforms
Thread-Index: AQHaUF3eVzWxkihyOEqZjVbKjj5n1LDxAB+AgAADQICAACVkAIAAGUYAgAAKs4CAAAf/AIAArOyw
Date: Tue, 30 Jan 2024 08:01:28 +0000
Message-ID: <DM8PR11MB57503361808065E0DB669737E77D2@DM8PR11MB5750.namprd11.prod.outlook.com>
References: <20240126134230.1166943-1-kirill.shutemov@linux.intel.com>
 <276aaeee-cb01-47d3-a3bf-f8fa2e59016c@intel.com>
 <dqiaimv3qqh77cfm2huzja4vsho3jls7vjmnwgda7enw633ke2@qiqrdnno75a7>
 <f5236e76-27d0-4a90-bde5-513ac9446184@intel.com>
 <dlhffyn7cccn5d4uvubggkrmtyxl4jodj5ukffafpsxsnqini3@5rcbybumab4c>
 <3a37eae3-9d3c-420c-a1c7-2d14f6982774@intel.com>
 <v6maadzwtke3z5ejp2mavsnm4mvmjbu7demvldzpobqeva74rx@r6y5fwxsyoep>
In-Reply-To: <v6maadzwtke3z5ejp2mavsnm4mvmjbu7demvldzpobqeva74rx@r6y5fwxsyoep>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5750:EE_|PH7PR11MB8571:EE_
x-ms-office365-filtering-correlation-id: 66f24c8f-36eb-44d6-cb56-08dc2169aa21
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HRkkWhPSms1CC/WA4gbHwHmq1xL/sbfm+s2paKWYZKzo5Q2vpGC9NjQXmHo1bkPScrL/cWuRPEHdiGtS4Ogw3wlMO8BzSDLm97FkXlle3aBv3u3KrXpTItA0Nkmqm/4x0a64R9anP3UWZwIKfeqWM2v0MiXxYjj7ncVb3mDu7H5Q+a2FXT67Mn+PEEWfzKFOVLGaLVqZbpEhkkiubTkPAZI99O3H9flpiV+ligG8xo5mhWUJ4lb/0u8+l7DlGvmHUvbmpY94BdttK0mTxMqJaaaybhL3bUECj7PaKHNgHSAKy9QD3IOKfpQ9FrPVnS4iKyTPudT8eYGHlVWJjCQC5T8SaWITCbvTYuskpPkYLNnfXY7KuIzlc0IhViLaD3nXwHyJeqfArfbOKqrZ7p/NYetHSFOpiMi4+ongN7L2U7WC98N4dQEeWMOq9ph15cXX8Cjxza+7rZngJtvBKyumo7YA7SI7bp/ZLmOm0WTK1Dd3v+5sIS/MXkFQfkSlIfSS5DRqMoz3Na4wkgRSzSQYxppOlcGiPsg9HR0S7eVXZlBWNmIFVFCDBZRgqcSiXKMTVvFUfKL7wJAQMW1m1bxDwKPx7dvLDu8SfkNGy7ceIoB31SikZIGUocRG+TbcLo4e1k3GrI2857VjQvRTPhh6a6TQMpDrGS1Iya6UGDo2GeE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5750.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(376002)(366004)(136003)(396003)(230173577357003)(230273577357003)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(52536014)(4326008)(8676002)(8936002)(7416002)(33656002)(2906002)(5660300002)(76116006)(110136005)(86362001)(54906003)(66946007)(316002)(64756008)(66556008)(66476007)(66446008)(6636002)(38070700009)(38100700002)(122000001)(82960400001)(7696005)(6506007)(53546011)(9686003)(478600001)(71200400001)(83380400001)(26005)(41300700001)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bzdFWTZUbnl2bFA3Mzk3SkJCanNDbzNpd1pYVTYycnFMa0ZRSFpqWDB6MWJx?=
 =?utf-8?B?RUpXLzRBblRqbUJwQVA1NTU1WFV0enNYQTVxSXlHcVkyb2x5MDVmM0FpTHh3?=
 =?utf-8?B?VFZlaG5KY0ZISEFGK1VmSEdzcHhySUQrVjh1T2FyNlFWclEzbjgzYk5pTkpv?=
 =?utf-8?B?enJmbTBXTlhraThoWUtqNzVvMnlUWE14RnExb29CeXdkUDgzOW03elZoQ0Jp?=
 =?utf-8?B?VUFoa3o4WkJvRXRoR3dLZVFhcUYvZWxLWWlHK0lMNzhyNzJsaGJIeXBjcGl2?=
 =?utf-8?B?SzZVdWlNRG9BUDBiRUNoOXdhSWExNEM4UWdyaTN1WWZrY2NKTnZ5TUZBVFhU?=
 =?utf-8?B?cGR6WFE2TnRRaEVtdGxpeUM3L0phTDBaa2VqZVI3RTRFaDBEOWtieG05YUti?=
 =?utf-8?B?Nklhb3lXQVA1UjFvRW05dWd0L1pJQ09WQVV3cWg0NCtOcGd1ZTRKa29nSTNj?=
 =?utf-8?B?dUdGR09DenBzVVNQSStDbUw3MXBxOWxaeVh5TWtzOEtVVC9FbGxtMHhtdi92?=
 =?utf-8?B?SkQyZ2wyQTZWNExSSkhnOW5qd3BrL0xnM09hZ3VPaDVYeUF1Y25oaVlET1o0?=
 =?utf-8?B?eDk2VzUwaVI0YjU2cC9FK092aGNYK3RMYUZoZmhQR3R4MVFMTnlhUzZIV29H?=
 =?utf-8?B?ekUwNDBiamQ1QmZWYThTUGwwcHpQZ21hbW5BNjNOV0F0VjVqWFpvS0xSbnJw?=
 =?utf-8?B?NitiR2FtMHUzcGtUMk5wZDVIQURMMzdOSmUvblVVb2pRUklSOTJyK1Z2SWIw?=
 =?utf-8?B?OFVWaDFLZlhMUDFseVozY3UrZ1NaMlVITm5IOVhDZ21pT3RRNkVxMVRHMWJG?=
 =?utf-8?B?SGhEMmJqbU41bnVTM2JoUHVTS2sxQUhWOG9rUjUvUG5XSnhiSnBIMHZDNVVE?=
 =?utf-8?B?NEZGYWFCZFA4cmRGenhQdHV3SmFaVVR1R1UvZFZhY1NuU3ZvZHRwZEJrdFZz?=
 =?utf-8?B?aGxEb2hKUVl6SDNuWmRHYmNXTU9TWXdUdzJLbklrRnEyU055emsrb3pFOGpm?=
 =?utf-8?B?dStCNzdzdExHTG04MXNKMGRiejlsZzNzYW8zdmF5Rkd2RXM1Vm5UTXF5cFRn?=
 =?utf-8?B?djE3VjJKc2E0b2p6Uk84SVRZbG92dGVXUm82RDVKaTMwS2JaazB0YzlmU1d0?=
 =?utf-8?B?OUNvMzk0aElkL2paREI3bk9LSlpoOS9CUFd3NU95NHptWjhUNk9IaVlTbWF2?=
 =?utf-8?B?T3pCZUs3TGRMOTZSaks3MUdwMHUvaHhEYlNGMTYyY3FQRUhZS20xYlljRmRB?=
 =?utf-8?B?YkswUEhWK0FKL1gvUjcrU2pSWWErV0JQckZpbWx2K1BSNGZoektvS0ExblhI?=
 =?utf-8?B?cTVWTHRJbFNyZm1RQWl6c05wbkZONkYxcGMwcGxtRjJnTkdVS2Q5RWFPOHB5?=
 =?utf-8?B?TzE2Y1I5R3NYRzBVVlkwTmV3STdPeDlSRlVZbjUvNU5HcUxHTGExMDFBcUdx?=
 =?utf-8?B?ZkVtVlloenhrV0FpRml5N0pvbHJUVTZzSFFMYVFLSUl4a0o2VjN5K25oT3lU?=
 =?utf-8?B?dEJ2V1pyb2hBVTlsOU9aWW5ya3RRZkoxbkxtZUJFM0VhOVRaL0FiN000Wldm?=
 =?utf-8?B?cGtJd0gwc2dsaUMvaERzWGkxREoyb2E1RDBVOVVoZkZlcU5WbzZZWElmc21q?=
 =?utf-8?B?dVovSGJQSGt0aDMzcWN3SUNSREpOSGRuRHhBcXhrQmhuOTFPUEVzbDRXbzZF?=
 =?utf-8?B?UWMvd29JSnQrSmdZWEhJR3hXYVFhOFNPV1oybWZyOW5EYVFwQXVVdFZRNHBv?=
 =?utf-8?B?U2F2cHRLMXJLTDVtQ0krQUdwSTJEejB6ME1FZFUvaFRPWjBsakc1dGFNeS9s?=
 =?utf-8?B?bmI3Y1h5TC84VFdBM3hTWFRic0JFaExHZmdhYVFtV0JTV1BkcnluNXMwam96?=
 =?utf-8?B?c0x2SVlxejRCemQvN1hZaDErM3RIZ2ZFVnVuUGI0QnZGc1NsT1NBdEJJWVEx?=
 =?utf-8?B?NmxySXBaMnZnbmMyS1JVUmM0WG05MjBBNDRHSGtPcFd5c3cyQkRvVFc3OWhQ?=
 =?utf-8?B?d2FUMGNpWFJRV2tkbVRkc0VyRUhFNklTNzRaSWVTZHZrVFZyd0NFRkJhM1J0?=
 =?utf-8?B?OWQyT2R3eG0rcVpRSlI3Z1E0MFgzTTVpclI3VlBUVlNjWG5FKytZdmtjNUU1?=
 =?utf-8?Q?+4OTiDMT7Zpuk5XInhF8lVX5I?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5750.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66f24c8f-36eb-44d6-cb56-08dc2169aa21
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2024 08:01:28.9295
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zycjwJ0lpLNxuGPoSA/9yDLJDIXIkoht+FDhgEjw7GLJvSujSBDHjF8G0DlkGib53iGmLNfSfvrSkVps2eO5NdFAUjltuOK1BnU5QDXt0dQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8571
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS2lyaWxsIEEuIFNodXRl
bW92IDxraXJpbGwuc2h1dGVtb3ZAbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBNb25kYXksIEph
bnVhcnkgMjksIDIwMjQgMTE6MzMgUE0NCj4gVG86IEhhbnNlbiwgRGF2ZSA8ZGF2ZS5oYW5zZW5A
aW50ZWwuY29tPg0KPiBDYzogVGhvbWFzIEdsZWl4bmVyIDx0Z2x4QGxpbnV0cm9uaXguZGU+OyBJ
bmdvIE1vbG5hciA8bWluZ29AcmVkaGF0LmNvbT47DQo+IEJvcmlzbGF2IFBldGtvdiA8YnBAYWxp
ZW44LmRlPjsgRGF2ZSBIYW5zZW4gPGRhdmUuaGFuc2VuQGxpbnV4LmludGVsLmNvbT47IEguDQo+
IFBldGVyIEFudmluIDxocGFAenl0b3IuY29tPjsgeDg2QGtlcm5lbC5vcmc7IFRoZW9kb3JlIFRz
J28gPHR5dHNvQG1pdC5lZHU+Ow0KPiBKYXNvbiBBLiBEb25lbmZlbGQgPEphc29uQHp4MmM0LmNv
bT47IEt1cHB1c3dhbXkgU2F0aHlhbmFyYXlhbmFuDQo+IDxzYXRoeWFuYXJheWFuYW4ua3VwcHVz
d2FteUBsaW51eC5pbnRlbC5jb20+OyBSZXNoZXRvdmEsIEVsZW5hDQo+IDxlbGVuYS5yZXNoZXRv
dmFAaW50ZWwuY29tPjsgTmFrYWppbWEsIEp1biA8anVuLm5ha2FqaW1hQGludGVsLmNvbT47IFRv
bQ0KPiBMZW5kYWNreSA8dGhvbWFzLmxlbmRhY2t5QGFtZC5jb20+OyBLYWxyYSwgQXNoaXNoIDxh
c2hpc2gua2FscmFAYW1kLmNvbT47DQo+IFNlYW4gQ2hyaXN0b3BoZXJzb24gPHNlYW5qY0Bnb29n
bGUuY29tPjsgbGludXgtY29jb0BsaXN0cy5saW51eC5kZXY7IGxpbnV4LQ0KPiBrZXJuZWxAdmdl
ci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUkZDXSBSYW5kb21uZXNzIG9uIGNvbmZpZGVu
dGlhbCBjb21wdXRpbmcgcGxhdGZvcm1zDQo+IA0KPiBPbiBNb24sIEphbiAyOSwgMjAyNCBhdCAw
MTowNDoyM1BNIC0wODAwLCBEYXZlIEhhbnNlbiB3cm90ZToNCj4gPiBPbiAxLzI5LzI0IDEyOjI2
LCBLaXJpbGwgQS4gU2h1dGVtb3Ygd3JvdGU6DQo+ID4gPj4+IERvIHdlIGNhcmU/DQo+ID4gPj4g
SSB3YW50IHRvIG1ha2Ugc3VyZSBJIHVuZGVyc3RhbmQgdGhlIHNjZW5hcmlvOg0KPiA+ID4+DQo+
ID4gPj4gIDEuIFdlJ3JlIHJ1bm5pbmcgaW4gYSBndWVzdCB1bmRlciBURFggKG9yIFNFVi1TTlAp
DQo+ID4gPj4gIDIuIFRoZSBWTU0gKG9yIHNvbWVib2R5KSBpcyBhdHRhY2tpbmcgdGhlIGd1ZXN0
IGJ5IGVhdGluZyBhbGwgdGhlDQo+ID4gPj4gICAgIGhhcmR3YXJlIGVudHJvcHkgYW5kIFJEUkFO
RCBpcyBlZmZlY3RpdmVseSBidXN0ZWQNCj4gPiA+PiAgMy4gQXNzdW1pbmcga2VybmVsLWJhc2Vk
IHBhbmljX29uX3dhcm4gYW5kIFdBUk5fT04oKSByZHJhbmRfbG9uZygpDQo+ID4gPj4gICAgIGZh
aWx1cmUsIHRoYXQgcmRyYW5kX2xvbmcoKSBuZXZlciBnZXRzIGNhbGxlZC4NCj4gPiA+IE5ldmVy
IGdldHMgY2FsbGVkIGR1cmluZyBhdHRhY2suIEl0IGNhbiBiZSB1c2VkIGJlZm9yZSBhbmQgYWZ0
ZXIuDQo+ID4gPg0KPiA+ID4+ICA0LiBVc2Vyc3BhY2UgaXMgdXNpbmcgUkRSQU5EIG91dHB1dCBp
biBzb21lIGNyaXRpY2FsIHBsYWNlIGxpa2Uga2V5DQo+ID4gPj4gICAgIGdlbmVyYXRpb24gYW5k
IGlzIG5vdCBjaGVja2luZyBpdCBmb3IgZmFpbHVyZSwgbm9yIG1peGluZyBpdCB3aXRoDQo+ID4g
Pj4gICAgIGVudHJvcHkgZnJvbSBhbnkgb3RoZXIgc291cmNlDQo+ID4gPj4gIDUuIFVzZXJzcGFj
ZSB1c2VzIHRoZSBmYWlsZWQgUkRSQU5EIG91dHB1dCB0byBnZW5lcmF0ZSBhIGtleQ0KPiA+ID4+
ICA2LiBTb21lb25lIGV4cGxvaXRzIHRoZSBob3JyaWJsZSBrZXkNCj4gPiA+Pg0KPiA+ID4+IElz
IHRoYXQgaXQ/DQo+ID4gPiBZZXMuDQo+ID4NCj4gPiBJcyB0aGVyZSBzb21ldGhpbmcgdGhhdCBm
dW5kYW1lbnRhbGx5IG1ha2VzIHRoaXMgYSBWTU0gdnMuIFREWCBndWVzdA0KPiA+IHByb2JsZW0/
ICBJZiBhIG1hbGljaW91cyBWTU0gY2FuIGV4aGF1c3QgUkRSQU5ELCB3aHkgY2FuJ3QgbWFsaWNp
b3VzDQo+ID4gdXNlcnNwYWNlIGRvIHRoZSBzYW1lPw0KDQpMZXQncyBiZSBtb3JlIGNvbmNyZXRl
IGhlcmU6IHRoZSBtYWluIHByb2JsZW0gd2UgYXJlIHRyeWluZyB0byBmaXggaGVyZSBpcw0KdG8g
bWFrZSBzdXJlIExpbnV4IFJORyBoYXMgZW50cm9weSBzb3VyY2UocykgdGhhdCBhcmUgbm90IHVu
ZGVyIGF0dGFja2VyIGNvbnRyb2wuDQpJbiBjYXNlIG9mIHVzZXJzcGFjZSBhdHRhY2tpbmcga2Vy
bmVsLCB5ZXMsIGl0IGNhbiBleGhhdXN0IFJEUkFORC9SRFNFRUQsDQpidXQga2VybmVsIGhhcyBv
dGhlciBlbnRyb3B5IHNvdXJjZXMgKGludGVycnVwdHMpIHRoYXQgYXJlIG5vdCB1bmRlciBmdWxs
IHVzZXJzcGFjZQ0KY29udHJvbCBvciBmdWxseSBvYnNlcnZhYmxlLiANCldoYXQgbWFrZXMgdGhl
IGNvbmZpZGVudGlhbCBWTSBzdG9yeSBkaWZmZXJlbnQgaXMgYWZ0ZXIgVk1NIGhhcyBleGhhdXN0
ZWQNClJEUkFORC9SRFNFRUQsIGd1ZXN0IExpbnV4IFJORyB3aWxsIGZhbGwgYmFjayB0byB0aGUg
ZW50cm9weSBzb3VyY2VzIHRoYXQgDQphcmUgdW5kZXIgb2JzZXJ2YW5jZS9jb250cm9sIG9mIFZN
TSBhbmQgdGhpcyBpcyB3aGF0IHdlIHRyeSB0byBhdm9pZC4gDQoNCg0KPiA+DQo+ID4gTGV0J3Mg
YXNzdW1lIGJ1Z2d5IHVzZXJzcGFjZSBleGlzdHMuICBJcyB0aGF0IHVzZXJzcGFjZSAqdW5pcXVl
bHkqDQo+ID4gZXhwb3NlZCB0byBhIG5hdWdodHkgVk1NIG9yIGlzIHRoYXQgVk1NIGp1c3QgYWRk
ZWQgdG8gdGhlIGxpc3Qgb2YgdGhpbmdzDQo+ID4gdGhhdCBjYW4gYXR0YWNrIGJ1Z2d5IHVzZXJz
cGFjZT8NCg0KR29vZCBiZWhhdmluZyB1c2Vyc3BhY2Ugd2lsbCBhc2sgZm9yIGl0cyBjcnlwdG9n
cmFwaGljIHJhbmRvbW5lc3MgZnJvbSANCkxpbnV4IFJORyAoc29tZSBtaWdodCBkbyBkaXJlY3Qg
UkRSQU5EL1JEU0VFRCBjYWxscywgYnV0IG1vc3Qgd2lsbA0KcmVseSBvbiBMaW51eCBSTkcpLiBX
aGVuIGl0IGRvZXMgYXNrIGZvciBpdCwgaXQgaXMgZ29pbmcgdG8gZ2V0IGEgbnVtYmVyDQpmcm9t
IGl0LiBUaGUgZmFjdCB0aGF0IHRoYXQgbnVtYmVyIGRvZXNu4oCZdCBoYXZlIGFkZXF1YXRlIHNl
Y3VyaXR5IGlzIG5vdA0KdmlzaWJsZSBmb3IgdXNlcnNwYWNlIGluIGFueSB3YXkuIEkgZG9u4oCZ
dCB0aGluayBhbnlvbmUgd2lsbCBnbyB0byBkbWVzZyBhbmQNCmNoZWNrIHRoZSB3YXJuaW5nIGxv
Z3MgdG8gZGV0ZXJtaW5lIHRoaXMuIA0KU28sIEkgZG9u4oCZdCBzZWUgaG93IHdhcm5pbmcgaGVs
cHMgaGVyZSBpbiBwcmFjdGljZS4gDQoNCkJlc3QgUmVnYXJkcywNCkVsZW5hDQo=

