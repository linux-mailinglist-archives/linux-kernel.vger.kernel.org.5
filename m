Return-Path: <linux-kernel+bounces-87301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0F7586D273
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 19:39:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 875BE288709
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 18:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 539CF7E580;
	Thu, 29 Feb 2024 18:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l3nPNxaL"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADBBB79F1;
	Thu, 29 Feb 2024 18:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709231946; cv=fail; b=XZbA13SwdOlG3yXeKRynnZdtXws74h/anHhmoF4DHPvKJwol2xvE2BpFDxdVc1bIlZrinZBEk2yAv39s9RgEiVL6PmIaOtZ8tS6uVMgChhPMrFUqm5wZrZzpKjKmw7qhmCF/7ygEMNH8J2IIpU4ip+ZfCIVAX+lvfbXaDqfP2yc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709231946; c=relaxed/simple;
	bh=tjkMqKkWhj7HWWYBWBr6GXpDYkhn95eYJxLK7aK6SWc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BGNb//ntFyaEJwSMvZjCKTRClwjuoXbWPPLIogzE8B56G6Vu2J8RETcHLd4Iq9pebNWSDv27cHrYbH2TVRgNs5REdc6vWyAGxgzlUoNH22bBdVF76HTiTcxHzLMJImXyLRGICJ8i7PpETiJaowIlso9ohstm6F+tmg/K7X11DCE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l3nPNxaL; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709231944; x=1740767944;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=tjkMqKkWhj7HWWYBWBr6GXpDYkhn95eYJxLK7aK6SWc=;
  b=l3nPNxaLMNOd64K7iZIJGhZsdUMjWFYQkwSViBYjNTOoPMOsO/Av7LZX
   47v16YjZ0Egv4bg/Tie/Mx9py/g6gGpxznnOiqBFb8mIG743xjM1GY84D
   XKcDAt5h9XrCvarbyP9FkenUshDg0XLRK2o3R6X6TRVdcBb5Cr6BQbDex
   e8iJivkcwXceoApx1NrWy1qIAqgqCPQ8hE87y+hrR3yurkaGskmohj5n4
   eID1F/1T0aRv8MVSQ57xuVZIlBC5fQD1ss7c0QytYOr7OZBLsFGw5L7L5
   55cRZ+ev6zUCZ6yKBnGomMpsbrQIBfoiLfmLeU6WYZtV0rJx1FlE1xxIe
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10999"; a="3843801"
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="3843801"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 10:39:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="7850932"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Feb 2024 10:39:02 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 29 Feb 2024 10:39:01 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 29 Feb 2024 10:39:01 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 29 Feb 2024 10:39:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ny0dL2oPvIABvvAHfZUsIie1P+c7M88xR6i9RNPN8FvBHUeCkgtBA+zKl/Uv86oDju5rO0EevnICUGmNol/tSTiCKc86UDq26Hgv7CZMzyJzNga+NAe2KQFS1zrI4yEFqo+sGgE95ovzyLQIVOZ87jH8pycee0Mdb/44b1c5xQj55GyW+q9mBPHfJ80EXHK845g0YlJGCD8PxHOgQz/j1i4b/mSbgYF1a2pI2FU7otYd7rDufX+kiadaABZqDZHbh0TAKhy3LO1E+eckb28Q/V6rZhmGrcCkfWTsINhFxLzqvsdPX+rPcn60IYorvK4CGMsWEjB9C9e1l/A7huRYHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tjkMqKkWhj7HWWYBWBr6GXpDYkhn95eYJxLK7aK6SWc=;
 b=h2zMeD7nfy+zeZuJBnVGqU6R7hNk3OiNF4Z3o51JRFw1y+8ERIEzmBL071VWWdsQ4lKAR2M+tTEq9QM+uV3+UEyKH9/YafHHL6fjbVF9YsJzR+u5/H32VYlrh7cZESZIu7KnkoibkzC5BJojIZyGJ0O7xBzyrWO7M1mDxOtR4WlK7zQzYdYaWDIo+xXBikujHaA8lB8Ca1TuZG5JYm8bEEmbTdtmfzyauZeNodbcMtV0T0HtpYJw3DFxWRTTPXNERF1rSv1tr00QWgSsnhDwVe8aak/90rQqa651HLnHLI5LU+mMEkLjy62Oj5lXVWCnlouY8ULFIp9X0Juz5SWCEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by DM4PR11MB6287.namprd11.prod.outlook.com (2603:10b6:8:a6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.25; Thu, 29 Feb
 2024 18:38:58 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::d5ce:2b6c:458:3ca9]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::d5ce:2b6c:458:3ca9%7]) with mapi id 15.20.7339.023; Thu, 29 Feb 2024
 18:38:58 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: "Naik, Avadhut" <avadnaik@amd.com>, Borislav Petkov <bp@alien8.de>
CC: "Mehta, Sohil" <sohil.mehta@intel.com>, "x86@kernel.org" <x86@kernel.org>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"yazen.ghannam@amd.com" <yazen.ghannam@amd.com>, Avadhut Naik
	<avadhut.naik@amd.com>
Subject: RE: [PATCH] x86/mce: Dynamically size space for machine check records
Thread-Topic: [PATCH] x86/mce: Dynamically size space for machine check
 records
Thread-Index: AQHaatqf6DQhCXmfQUqRjrewOC7we7EhAAOAgACkomqAAACpsA==
Date: Thu, 29 Feb 2024 18:38:58 +0000
Message-ID: <SJ1PR11MB60831369FC6FEA7944DBEEC5FC5F2@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <SJ1PR11MB60830AF35FA89C7869B8C11EFC482@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20240212191401.GLZcpt-XHFqPg3cDw-@fat_crate.local>
 <SJ1PR11MB6083C60D7584B02E9CAF19D5FC482@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <ZcqPhVO_DtD2x5N7@agluck-desk3>
 <20240212220833.GQZcqW4WxKH34i-oBR@fat_crate.local>
 <20240212221913.GRZcqZYRd6EPTTnN97@fat_crate.local>
 <20240212224220.GSZcqezMhPojxvIcvO@fat_crate.local>
 <Zd--PJp-NbXGrb39@agluck-desk3>
 <8ee24cad-e9b8-4321-aad4-9a9ba4f8b7b6@amd.com>
 <20240229083951.GAZeBC1yS3MPonWwKv@fat_crate.local>
 <ZeDDLLQWPyyZve_s@agluck-desk3>
 <f17da20f-4379-4dc6-b988-cb3a07f4aa6f@amd.com>
In-Reply-To: <f17da20f-4379-4dc6-b988-cb3a07f4aa6f@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|DM4PR11MB6287:EE_
x-ms-office365-filtering-correlation-id: 1f86620b-ced6-4d21-72de-08dc3955b0fe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PBSrnF0Uy+/eVidCF+qA5rIP1W1N2HEA18P8F3ZiRz42odAwKvI4TfZsiV4FVr77bIG+f3WPhmIeOk24FXkxNRawVT0T6LTF8hM+DjOEteVxfR+KTynbcZdBurI4uOY1XY9goWf82T7eaiRP6LsXuBFglqJg+55+TBEU281j/BfSaKEYAP4OVc0P7dYhiTG0kwPdgmopCoLrYuNBfxeL3Lf5GwCy2ddkGKJcjrVGG8yaV1jN3WbNNfm9rFKtLvcXDPDXEyFv98Ygbo9l9ryb1uVUsSMNVTEEdcX/yKEOCS60olq/3dqMn9ABONDtec7REcDs5F24jHBabAOWM8IYf/Pcgtj/rnxk0jKvkiPju+ElngUBAMnx2sIpVBdLuOAoKU+ElhvNsnA0jE025JK7flgTpAidjZJsWdX3LvByeA8cRWdokF/tVUr1NOeHIrNTEsOGLhk6Fh4XgwlEXD8gYkdlYrGXBP5L/oyK1qjYpj9Mi3saoiDzWDFxpRvK7+QbIvylje9NJlOx7AmyZjZOuKPtqUwCDJz4eMNf23i1iHelsi5Qfbtkcl5TUbIT7uEt60mZY+eLLOH539HZesxrNAumc3Fdr+4FcLMEq6pvh+SJIX8TlhDAIEdevfJqrQlC+hr8Dj8/gqlOqO+oittuu6JHDAYrERZ2YMGO3nCtGZoDhmXSLDkSIRmwDkyNGzs06zxbexXHDHCfnVP5W0zj/PnoZViVCda+oY/t2dRLvu4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZlVIRWhldXQxOUcycEdid2R5OGtvWUw2QzlDN1gzL0FOaElRQ2Nvdmk2cnVQ?=
 =?utf-8?B?Qk9pdmtia0l1bUZqc084RTdpWEswYTJmZWVZUE1hNHZIREVLd2s1N3FiVlRS?=
 =?utf-8?B?ZjdUa211aDU0ZnEyR1J5RWJxb2pzV1dxVy9NYzhwNytYMkdCRFBuSlNIeUs2?=
 =?utf-8?B?K29ObklDTkEzR1pxRzFyZ214VGVhN1FLdEpmbERkMkkvL09xWk9lUWIzb0N4?=
 =?utf-8?B?L1BucWNKeG9SYlcxSllVN1RGbC9XOWtFSHNYNmgyWjBFT2t5bjlDR1lVNURD?=
 =?utf-8?B?WTZ3d3p4OU01SmE3cUJ4U3JkV1RJQWZDcmpGUHNqQ1A2U1h3VmYrd3pvTFhC?=
 =?utf-8?B?Q2xTTUFXUmRGUUpLNEpzSGdQa2NzVGN4Wk1vdjNobUdteE4wYkh5RnZyZzU4?=
 =?utf-8?B?MGpQTnRZZjN4VjVVaW1ZSEFqYk9wQkluWDk2QjlSMHdXOUU5VU9HQTFhRWU2?=
 =?utf-8?B?V243cWh5ZDFwSWlVYUVPeHhSSU5Mb0RCb0lULzZwK1ZGZHRKSFNuU3Q3SGJQ?=
 =?utf-8?B?MGc1bzEvbHRCK2NrcUc1RzVwZElBNEJPa2hXODRmQ2hMSWlWMHFHT1BVN1l5?=
 =?utf-8?B?eWFqM2xtUUl3RWhWOXY3R3dnVkhmdlRibGF0SlVJZ3NMN2FhUndzbzhkSDhh?=
 =?utf-8?B?b1N1K1RLRm9BR2dWcDdCUHdic1pGSkNpVGhISlJGcVI2RlpqaGliN0FiWjUy?=
 =?utf-8?B?aXFXTGZsSjBKQzZFU3BEbktvTXI0bExyNWZTY0d1cFl4ZFpyNnVDRlJOcENs?=
 =?utf-8?B?bTNrVzdNT1pFL21TN2F4ZFdXajZsSm1wTitXbVFwSnNsVjVZVUdDL3U1S0hw?=
 =?utf-8?B?RlY0MDJTeEpLM0E5QnM1S0ZyS2piZllNMXFNYWF4TkJxSStVNHYvTG5PcWtO?=
 =?utf-8?B?dVUzTFpJeHU2VUlKVXJoNTVZb1Q1OWFwMUI0RDJsU3g2Q0hJYU04RnZ2VnJk?=
 =?utf-8?B?OE9UMmdqZW45a0FMdzRjTmRzcFVobDRqZHhobmJKRmJCL1c3Q1RkcnNuOU1P?=
 =?utf-8?B?eG9qbGRSWFZ6ZFlSYlNXQU1idEN6bkJxZzIxWU12UFdIL1NwR1RNdTJTbE9T?=
 =?utf-8?B?R3BkMVlCQ3VHQ3o1YVZ0aFNoMFk4bmlnNHArSzRiL2ZHMk01aGhYdTZCbmZN?=
 =?utf-8?B?MW0zTmhEa2xzYmZER3VxdmhxWXJFOVkvbjYvNGxmS2dpYURxNkJmRnpJUUIr?=
 =?utf-8?B?dUI4bmlsM05IUEhmTUxmWkttRDhDeW5odktvTTBuZFNTN25nS0Q1d3NOeFBT?=
 =?utf-8?B?cmRTTEU2KzNaQTBUQlBBZ3V5bWF3ZVhmdElxblU4cnB1bTZwRE1adTlWUDhG?=
 =?utf-8?B?Ymx2N0N5TDl5L0k2R0EwOGpJTjBCUGNYQ1pDMGx2dUx0WUxUVDVWTzVJV1Q5?=
 =?utf-8?B?YWtXRk5WMHQ4aERJYklxQ2tmMmIzeXBPYVQ0ODJTYVpvMHBKbE5BczRSU0xP?=
 =?utf-8?B?T0hVOHJtNVdWdCtabmQ5MklldjNPbndSMG1BSFJTTnJJdFUrbGQ3K2xuVDhG?=
 =?utf-8?B?YzVWZXgrNkdFaHZNMUozdTNHeGlXTFpVU2ExN0l5ZzRoTUFFMWt1bjhXOGly?=
 =?utf-8?B?ZWRDOUozMlA5WWpHYWVsNWVPRWU4UkF4MloyOEc2RDBBTm9MRWk5dGdaMXk4?=
 =?utf-8?B?SG5kTnozS0o5RitvTUs4R3lWYi92Y1gwRXRJREc0OTl2amFmZGJsSThrZnF0?=
 =?utf-8?B?RnQ3cEFidWQwQ2hxV0FJRlVFMTZCVThtV2ZYUmF6Qis3OXlZTVlzeGxYSWhs?=
 =?utf-8?B?T0R6d240RjZwdGQwV1RHTkphNEFlK25WWU9TSUh2WlZIaUw5Qlh5VEdmVFFG?=
 =?utf-8?B?blRHZEZLeklGNFN2UzN2OElwNmE0RTVGYWRweXRPRlRObWwvQWgxT1p0MEZ3?=
 =?utf-8?B?VjdrZXNnZmhqcXFOcUdIellEcXVKYmdJcmxtRWZoVFlwRk80Y0FDbnlEdVFs?=
 =?utf-8?B?K3ltc1JzdngyWGZnUndLNHVMbURQS2VrTHRscnJoSVV3RG1jYmZNK2tYTThI?=
 =?utf-8?B?OWxJVnh1S0NUU2JpUUo0K1dSdTA3a2N5RUg4eHBRNk1saTAwNVoxQ2RrYklq?=
 =?utf-8?B?Um5wZlN1VVVUNlJGdlJzK1FKNHNqZ3dTLzFURWVKcUVZa2J5VzJNblBFRWRu?=
 =?utf-8?Q?IWEj7dLGP5AJtiEM6HEBvfnSR?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f86620b-ced6-4d21-72de-08dc3955b0fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Feb 2024 18:38:58.4178
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bP/Wqptjo90JMl4nogsaV8bYpQUbjoAOEumn66y1O2WlxfsJZL7xPcwMy03BQ9UaT8o0tOq+miFzGsQb50y5kw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6287
X-OriginatorOrg: intel.com

PiBXb3VsZG4ndCBoYXZpbmcgZGVkdXAgYWN0dWFsbHkgaW5jcmVhc2UgdGhlIHRpbWUgd2Ugc3Bl
bmQgI01DIGNvbnRleHQ/DQo+IENvbXBhcmluZyB0aGUgbmV3IE1DRSByZWNvcmQgYWdhaW5zdCBl
YWNoIGV4aXN0aW5nIHJlY29yZCBpbiB0aGUNCj4gZ2VucG9vbC4NCg0KWWVzLCBkZWR1cCB3b3Vs
ZCB0YWtlIGV4dHJhIHRpbWUgKGluY3JlYXNpbmcgbGluZWFybHkgd2l0aCB0aGUgbnVtYmVyDQpv
ZiBwZW5kaW5nIGVycm9ycyB0aGF0IHdlcmUgbm90IGZpbHRlcmVkIG91dCBieSB0aGUgZGVkdXAg
cHJvY2VzcykuDQoNCj4gQUZBSUssIE1DRXMgY2Fubm90IGJlIG5lc3RlZC4gQ29ycmVjdCBtZSBp
ZiBJIGFtIHdyb25nIGhlcmUuDQoNCkNhbid0IGJlIG5lc3RlZCBvbiB0aGUgc2FtZSBDUFUuIEJ1
dCBtdWx0aXBsZSBDUFVzIG1heSB0YWtlDQphIGxvY2FsIG1hY2hpbmUgY2hlY2sgc2ltdWx0YW5l
b3VzbHkuIExvY2FsIG1hY2hpbmUgY2hlY2sgaXMNCm9wdC1pbiBvbiBJbnRlbCwgSSBiZWxpZXZl
IGl0IGlzIGRlZmF1bHQgb24gQU1ELg0KDQpFcnJvcnMgY2FuIGFsc28gYmUgc2lnbmFsZWQgd2l0
aCBDTUNJLg0KDQo+IEluIGEgZmxvb2Qgc2l0dWF0aW9uLCBsaWtlIHRoZSBvbmUgZGVzY3JpYmVk
IGFib3ZlLCB0aGF0IGlzIGV4YWN0bHkNCj4gd2hhdCBtYXkgaGFwcGVuOiBBbiBNQ0UgY29taW5n
IGluIHdoaWxlIHRoZSBkZWR1cCBtZWNoYW5pc20gaXMNCj4gdW5kZXJ3YXkgKGluICNNQyBjb250
ZXh0KS4NCg0KSW4gYSBmbG9vZCBvZiBlcnJvcnMgaXQgd291bGQgYmUgY29tcGxpY2F0ZWQgdG8g
c3luY2hyb25pemUgZGVkdXAgZmlsdGVyaW5nDQpvbiBtdWx0aXBsZSBDUFVzLiBUaGUgdHJhZGUt
b2ZmIGJldHdlZW4gdHJ5aW5nIHRvIGdldCB0aGF0IGNvZGUgcmlnaHQsDQphbmQganVzdCBhbGxv
Y2F0aW5nIGEgZmV3IGV4dHJhIEtieXRlcyBvZiBtZW1vcnkgd291bGQgc2VlbSB0byBmYXZvcg0K
YWxsb2NhdGluZyBtb3JlIG1lbW9yeS4NCg0KLS0gDQpUaGFua3MsDQpBdmFkaHV0IE5haWsNCg==

