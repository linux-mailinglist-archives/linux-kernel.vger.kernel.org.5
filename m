Return-Path: <linux-kernel+bounces-45165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E628D842C58
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 20:07:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 704501F21EC0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 19:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62F837AE5A;
	Tue, 30 Jan 2024 19:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="htm0ATGb"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E0771B2C
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 19:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706641583; cv=fail; b=HcMZPqBgEnJ2kH+zfu8Xemks8SiSTmLu+yKMkA6ejn0x8E5/yoMsGm/l65GW6Mj5ekGUeZsq8BHF1rExeufJCQE2rpAqHyCV3beIZ9IPNrswyoV9lpKyHeIBN9ZtT6j6B+nqe0Uf8haDKaZ3Y6dXF5KwWnmn9sElTTc5gIKUnKI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706641583; c=relaxed/simple;
	bh=Gr6fISCbLoYX563tKZccyPaA272N5d172ryK3YHkEB8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MSiYg6CEhvH5RMwP+ywztRhrTlRecQGGow4PmID3+/n/toNhqPIvwZd7QPyRnHnMzb2k2+jOZiXIVdJ+NCef9+VxavNbBs7fjj+0TqZcTMdkNuCpgJGY+jBb9jrvn4ETEaHCg9cQurMd6DPojO4MEd64uBa08or1AsKkusp+0hM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=htm0ATGb; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706641582; x=1738177582;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Gr6fISCbLoYX563tKZccyPaA272N5d172ryK3YHkEB8=;
  b=htm0ATGbZGts30kqQVJP8rqHIRj4LTl8w0H/xNzT2vLmRZvJcFxgzPqQ
   to3g3B5zLqTiGZg4/L44LGbzbIqyh84c/HDh45pZ4uszogAFB0DNlVrSV
   S3ZS6BQoAeEhjMCzWcgLalSUFSwvH/RDytVWEnHzKUfc6zzGufXwDefxe
   XOCj7NlZMXB8bMiYou+bJ/kNCQajLFQxtNY1qntjhysia7AhzIBVb9EWz
   aFgANJiL1KCtoG5kWkLonuhz6JYDSGUrdJLi2MxCu/Hy2tKTKV7TPcrcJ
   1qfzs6ag8FTjK/w+wrdFxyse6+ogud7G21OZJSy5R3luvbmlzW/84oHcg
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="16908477"
X-IronPort-AV: E=Sophos;i="6.05,230,1701158400"; 
   d="scan'208";a="16908477"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 11:06:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,230,1701158400"; 
   d="scan'208";a="3790954"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Jan 2024 11:06:20 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 30 Jan 2024 11:06:19 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 30 Jan 2024 11:06:19 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 30 Jan 2024 11:06:19 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 30 Jan 2024 11:06:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cxzSpj82xfwO73OuT9sCW6qeSD2mbC3/n9uQlaO7rETJ2+yaIoBlerqMBQq8FfLVNPOClwIEDk+IAnj/DIfRRIp47WxxqYfU73m2MV7S8W1roxjwoPnMg2qz3UziPaAKrJRFVmxNHPAYs7HKPxrkAQH1lAicAodqRuuBdunA5m02R/vNsufns83DtiJbF4RvInSXLVCPi9KXUOQ+nU7ls4z8moaoi7TSaevfWVCsNbRDnEPHUMRIDJJMu/CWiGzF5NIYtIXF9IuEFAU1DjCsZPwk6rOcJqAmimy29cnPS0VDngJthpo7Sf3vFohull5j9F45iGuRFhpSbHmY67sksA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gr6fISCbLoYX563tKZccyPaA272N5d172ryK3YHkEB8=;
 b=nBrZkBWULXo0XRM+q7kycFJiY0lhbgdFtLG8qaV7QFDcVCUhZyhkst3FVoGsMa//GNP6E871rkZ+iJOTl79dAXhrTNMBwN2jtNRlQPxnFj6h/1yxXEFE5IhbS68Pbs3G2jpTft20nE8A3Z5ljmfXt0gJDAbChcKb7JRzwiqxdo0k4GnUF2ZwNkPnJVX4TLo5jH/2GQD6dwQr9lEYocGvPSvT4R9+oit/19w2OywhwOqH1LwL1bTMJ9YYaotkfD4cnRs11gPjC8ASPYg8MbA7Cb76z2OURA7t4YLi1myIOoYgB+9EXMxRWYwU1AOgRFEaMO48J4yzF9U6UgiKFhTphQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5750.namprd11.prod.outlook.com (2603:10b6:8:11::17) by
 PH7PR11MB6054.namprd11.prod.outlook.com (2603:10b6:510:1d2::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7228.32; Tue, 30 Jan 2024 19:06:17 +0000
Received: from DM8PR11MB5750.namprd11.prod.outlook.com
 ([fe80::f1b2:bfb1:b1b:66ed]) by DM8PR11MB5750.namprd11.prod.outlook.com
 ([fe80::f1b2:bfb1:b1b:66ed%3]) with mapi id 15.20.7228.029; Tue, 30 Jan 2024
 19:06:17 +0000
From: "Reshetova, Elena" <elena.reshetova@intel.com>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
CC: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Thomas Gleixner
	<tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin"
	<hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>, Theodore Ts'o
	<tytso@mit.edu>, Kuppuswamy Sathyanarayanan
	<sathyanarayanan.kuppuswamy@linux.intel.com>, "Nakajima, Jun"
	<jun.nakajima@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, "Kalra,
 Ashish" <ashish.kalra@amd.com>, Sean Christopherson <seanjc@google.com>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/2] x86/random: Retry on RDSEED failure
Thread-Topic: [PATCH 1/2] x86/random: Retry on RDSEED failure
Thread-Index: AQHaU1aX7QKpTpzPXU+lq+SGmZ3MRrDySSwAgAAHtwCAABNoAIAAS0IAgAAD1CA=
Date: Tue, 30 Jan 2024 19:06:17 +0000
Message-ID: <DM8PR11MB5750797D0B9B8EB32740F55DE77D2@DM8PR11MB5750.namprd11.prod.outlook.com>
References: <20240130083007.1876787-1-kirill.shutemov@linux.intel.com>
 <CAHmME9pOt=uEmuBzBpgUHw9DqAD2FZTZ3v53AOZbQ3Cd2p97xQ@mail.gmail.com>
 <DM8PR11MB5750E38A8B2BCE66AF7F9812E77D2@DM8PR11MB5750.namprd11.prod.outlook.com>
 <CAHmME9qMO7=RDR60bKJvpDTRokcKed_i0+7BbFD53_7o2OJ6-g@mail.gmail.com>
 <CAHmME9rum4uwSNFd_GkD9p_+vN4DBxA=feZX7k9RvugFZsZNJg@mail.gmail.com>
In-Reply-To: <CAHmME9rum4uwSNFd_GkD9p_+vN4DBxA=feZX7k9RvugFZsZNJg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5750:EE_|PH7PR11MB6054:EE_
x-ms-office365-filtering-correlation-id: efff36e2-4568-4115-6314-08dc21c68973
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EmFQuqxCtshI62Tl/7/vMHOmsX6kBljVaks5GewLh88oja/rS4Z7CY/sQb+l/Tvu3ygWqb/gIrjxLxs6KtLaH2rSzLzfxkdg9LO/xfJSUndzoUsEEhNwQGoXHst4vdAZPRGNiNOLVh20YuoGIyz+pgGDWPmB+EZMOQ6npddbH4TSFrvyrcgzzahBfXruXIcWjFkxaLLT5JwwudZ9XGKaXycJgjKZ9UYMtm3ZZ9pDlQyo3ifuJRGakxzfNTXlgjV0WBve7li7UVtghaVmv/QRCI6ullUErjJ7xXFxmLQLu3Nl9GCmcuyscePk40fuJi+jiM46/d5SnSDwbayPJfymRVxf1JDIfHIs3hs7jpam2F22LmJpnhRJ6ZIsI1fu0WRpYyeBPyZOZNZHnPvaSOVdkz4t+ovFf3rm3LaOxKZTw1XGSxhNIFx8gz4334TsRmExXhFtqesGCG9UySX3Ichgi+MsPvZJ/AbmQufczWIiP/K7EEkvdpM5OGTdsVtNzYZnMi0wuASvb+ukfL/mUbnrRizpii01m91f02wR/rFNJLtXQ9lZM8W0FKEbChpQkCzNJOEHLfMXqYn+kOVMpEmtO0ujoro5uE7KyrG62sBzr0tTukBrQZtzqNkySSTp2G1Z
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5750.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(366004)(346002)(136003)(396003)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(54906003)(41300700001)(33656002)(9686003)(71200400001)(7696005)(6506007)(478600001)(26005)(8936002)(76116006)(4326008)(2906002)(7416002)(55016003)(64756008)(5660300002)(66446008)(66476007)(66946007)(66556008)(316002)(52536014)(8676002)(122000001)(82960400001)(38100700002)(6916009)(53546011)(86362001)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TmFKUTlWKzFEbnZIVDdKdnNPb0tIbUNEODFmRkdKWDNvUnZROWJZSi95aTlE?=
 =?utf-8?B?bzZkbStUb1ptWkRGMmRNNm01bEpUaU9lbEU4VWxqVVIrbXlUOWFBcUJJSTVp?=
 =?utf-8?B?cSttYVJqRHVKaUFtaEhYUVovSmFEOXZYbzdTZjdMWUp4bElCRXR5ZzZsU2F0?=
 =?utf-8?B?dU50Z3hxZ2U0Ykd4MjBBTHloSmJkRC83NnJBUVkrUGlRdVdlWXlxNjVOWXdW?=
 =?utf-8?B?a0liOXlHR2tpN3FxSnlBVFRsRU1IUzlBS2pVbEtXcHN3c1p3b1lrOFhGL3li?=
 =?utf-8?B?S3ltNTFGWUFEVEVuc0tCUWxZdEpMNXUxNU4vRDZSMnJHdUdlSTFFQnk1bHRW?=
 =?utf-8?B?TkJpM3Q1WEl6c0dGck5aRllNelFDNWoyOXZFSW5NYmkyWnZVcnQ1L1phNmZT?=
 =?utf-8?B?eGdQUGRYSjVndStHazg2WVJtWnpwSVVSRVZtbDYwbWV2bExGU3JzdGxpNnA2?=
 =?utf-8?B?U3d1dExuektsckdEUjlrY1lLYlJlVk5uT0labzlZTE5DaXFDS2NSZUd4YS9q?=
 =?utf-8?B?eWFkai9NSGJnRFF5RTFHMEh3cENsWmRSM3VrOXNEcnNxN1RVWkVmUko5SFRw?=
 =?utf-8?B?VjlZMHRLOHFVakgzRktERkR2U0dkaGI5RjlMM1dpSU80dTJUdkJBUFZEMHhr?=
 =?utf-8?B?eW9DbU10Z0VQSDlQbUFOYkYyUVZXT05ZWHpOVSt5eEM3amZOaUtJM3lKa0ts?=
 =?utf-8?B?a0VoZTR0N0tJb3pjZ2Exc25MQnNkZGR2ai9RcVBMcnh3VUdwRlJMdFpHOVhL?=
 =?utf-8?B?bFJjMFlVbUxIR1cyWGNNSyt6T21nRm1PaW43Y2dpR0kzTE9RRVl4blFUTGZJ?=
 =?utf-8?B?ZVA5bDZqbDJvUDc4MjVCSnF4eTJIQ0g3UHhDY1lxOUhWelQ4UGIyRy90MFha?=
 =?utf-8?B?cW5qWThBclp4ODIxM0EyNWhpaTh1WFNjWCtaSkdmbUxXenJ3N1hZcWpMTkQ5?=
 =?utf-8?B?TlNnK0V2dHQvUVZIcGplVGt0a3Bta3dPQW9XMzFvRmh4THl4aS9jd0p0ekpX?=
 =?utf-8?B?bHFaVmlZN0JaaXgweG8valloWGVyeC9YTVNNak9HclpnTWZuWSt2V1ZRdUVD?=
 =?utf-8?B?N092TTR3WjZwTVlwTGZhVFMzWURRZkovNG1velNRanR4bzY0aHBuMUZtK040?=
 =?utf-8?B?d1RGdmR5dHZDK0lhSHkzbFJWOXU4cFp5eUVLdTRNM0Y5M0hSZ1RtTUx0RndK?=
 =?utf-8?B?OGFIQTJaOVhRdlBPOEdoUDZwV25Ca2hOWUdEUzNhVUJHMWJaNk1YMDJhbG8v?=
 =?utf-8?B?b280clVMUTA4dWlPM2IrQmNrSFpGWU1jL3pRSTJXcSszeFlGUVhTa3dkSWFO?=
 =?utf-8?B?OFlaclkyNGpYMTVTVzZ5Wi9kZkwrdkIzb2lKMWtlZTlCUllEd015Z3p5UytI?=
 =?utf-8?B?TzM3UnhGRFRQOTF1aEFHTFFOQXlDN09KRHVDSXlYb05JS09qTlFoeXdyQUd0?=
 =?utf-8?B?ZG5FYkExNlBjRisvM3ZBTkdHODUvRTllVXJXWXQyM0I1ckEzbmF3dUZoNmp2?=
 =?utf-8?B?dmxVU3RLQkFLZXpGNGRUMDBYQzVXVy9TTjE5R1o5ZXFkS2E2em9zZGlqVjND?=
 =?utf-8?B?R2tFUWRCbiswRTVNMWxhWFdtQ09nNzdRcHhXaERCSld5eFlRNWFFNWI2STFM?=
 =?utf-8?B?Mit3eWkyWnplNUIzRXFaR0MranNPR0tKRjhrS28xbWMzRUJGZHRVOWtISnln?=
 =?utf-8?B?N0MrbnZzRDlmL1FVdWUzbzRkelBPdWJ6TWwvYVM4NjRVSkxOM1JTOW1FdURv?=
 =?utf-8?B?cnJaM2I0ZjNFbm1xZmNKaHNZN2g4WHY4YjAzSzVBQmZmZDdsd1dMV01aQk1C?=
 =?utf-8?B?TG9mcGFNcGxteEFBZDdZKzNsb2VhcVEvcERHZGR5RGZuYk9UUEZUODBQRVNG?=
 =?utf-8?B?WTVvcDBXOGZWdW9nbFdLa3R1SHBXQXpqajVLekN2aWo0Ykp5elg2cEdiMUx4?=
 =?utf-8?B?VEVUQ05FVzIwQlBGcmpGVXAycUNDWFlIVDREd0NjL0hIUE5UTzRkUlNlRW81?=
 =?utf-8?B?SHF6eWR4VGthd3VDTFlWYlJrNXpjWFl2L3ZwM1ZIVVFMZGFlbUlSOHR4Rk9v?=
 =?utf-8?B?SWtXSzJJNmhZeVV0S3NHWmNiSU5GWEk0UFp3L3k1WjliTThSZExQNnFPaWg1?=
 =?utf-8?Q?xh3UAKF1F+tmYcrjWUom/RwoS?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: efff36e2-4568-4115-6314-08dc21c68973
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2024 19:06:17.2698
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oQuPh2sJ1dxtQyFX2VJiVwu1iZFU0Mk/q5vqnFLWDS0/uKkHKSEtvvu56l0KllhbjJw43/o1n131OxWKr9rQmIsFtKAjOkmaPNtiTqYo0Ns=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6054
X-OriginatorOrg: intel.com

DQo+IEVsZW5hLA0KPiANCj4gT24gVHVlLCBKYW4gMzAsIDIwMjQgYXQgMzowNuKAr1BNIEphc29u
IEEuIERvbmVuZmVsZCA8SmFzb25AengyYzQuY29tPiB3cm90ZToNCj4gPiAyKSBDYW4gYSBtYWxp
Y2lvdXMgaG9zdCAqYWN0dWFsbHkqIGNyZWF0ZSBhIGZ1bGx5IGRldGVybWluaXN0aWMNCj4gPiBl
bnZpcm9ubWVudD8gT25lIHRoYXQnbGwgcHJvZHVjZSB0aGUgc2FtZSB0aW1pbmcgZm9yIHRoZSBq
aXR0ZXINCj4gPiBlbnRyb3B5IGNyZWF0aW9uLCBhbmQgYWxsIHRoZSBvdGhlciB0aW1lcnMgYW5k
IGludGVycnVwdHMgYW5kIHRoaW5ncz8NCj4gDQo+IEknZCBsaWtlIHRvIHJlLXVwIHRoaXMgcXVl
c3Rpb24uIEl0IHNlZW1zIGxpa2UgYXNzZXNzaW5nIHRoZSByZWFsaXR5DQo+IG9mIHRoZSBjb25j
ZXJuIHdvdWxkIGJlIHdvcnRod2hpbGUuDQoNClllcywgc29ycnksIEkgYW0ganVzdCBiZWhpbmQg
YW5zd2VyaW5nIHRoaXMgdGhyZWFkIGFuZCBpdCBpcyBnZXR0aW5nIGxhdGUgaGVyZS4gDQpUaGlz
IGlzIGV4YWN0bHkgd2hhdCBJIHdvdWxkIGxpa2UgdG8gaGF2ZSBhbiBvcGVuIGRpc2N1c3Npb24g
YWJvdXQNCndpdGggaW5wdXRzIGZyb20gZXZlcnlvbmUuIA0KV2UgaGF2ZSB0byByZW1lbWJlciB0
aGF0IGl0IGlzIG5vdCBvbmx5IGFib3V0IGhvc3QgJ3Byb2R1Y2luZycgDQphIGZ1bGx5IGRldGVy
bWluaXN0aWMgZW52aXJvbm1lbnQsIGJ1dCBhbHNvIGFib3V0IGhvc3QgYmVpbmcgYWJsZSB0byAN
CipvYnNlcnZlKiB0aGUgZW50cm9weSBpbnB1dC4gU28gdGhlIG1vcmUgcHJlY2lzZSBxdWVzdGlv
biB0byBhc2sgaXMNCmhvdyBtdWNoIGNhbiBhIGhvc3Qgb2JzZXJ2ZT8gTXkgcGVyc29uYWwgdW5k
ZXJzdGFuZGluZyBpcyB0aGF0IGhvc3QgY2FuDQpvYnNlcnZlIGFsbCBndWVzdCBpbnRlcnJ1cHRz
IGFuZCB0aGVpciB0aW1pbmdzLCBpbmNsdWRpbmcgQVBJQyB0aW1lciBpbnRlcnJ1cHRzDQooYW5k
IElQSXMpLCBzbyB3aGF0IGlzIGFjdHVhbGx5IGxlZnQgZm9yIHRoZSBndWVzdCBhcyB1bm9ic2Vy
dmFibGUgZW50cm9weQ0KaW5wdXQ/IA0KQW5kIGxldCdzIGFsc28gcGxlYXNlIHJlbWVtYmVyIHRo
YXQgdGhpcyBpcyBieSBubyBtZWFucyBJbnRlbC1zcGVjaWZpYywNCndlIGhhdmUgb3RoZXIgY29u
ZmlkZW50aWFsIGNvbXB1dGluZyB2ZW5kb3JzLCBzbyB3ZSBuZWVkIGEgY29tbW9uDQphZ3JlZW1l
bnQgb24gd2hhdCBpcyB0aGUgc3VwZXJzZXQgb2YgYXR0YWNrZXIgcG93ZXJzIHRoYXQgd2UgY2Fu
DQphc3N1bWUuDQoNCj4gPiBJIGltYWdpbmUgdGhlIGF0dGVzdGF0aW9uIHBhcnQgb2YgQ29DbyBt
ZWFucyB0aGVzZSBWTXMgbmVlZCB0byBydW4gb24NCj4gPiByZWFsIEludGVsIHNpbGljb24gYW5k
IHNvIGl0IGNhbid0IGJlIHNpbmdsZSBzdGVwcGVkIGluIFRDRyBvcg0KPiA+IHNvbWV0aGluZywg
cmlnaHQ/IA0KDQpZZXMsIHRoZXJlIGlzIGFuIGF0dGVzdGF0aW9uIG9mIGEgY29uZmlkZW50aWFs
IFZNIGFuZCBzb21lIHByb3RlY3Rpb25zIGluIHBsYWNlDQp0aGF0IGhlbHBzIGFnYWluc3Qgc2lu
Z2xlLXN0ZXBwaW5nIGF0dGFja3MuIEJ1dCBJIGFtIG5vdCBzdXJlIGhvdyB0aGlzIGlzIHJlbGV2
YW50DQpmb3IgdGhpcywgY291bGQgeW91IHBsZWFzZSBjbGFyaWZ5PyANCg0KQmVzdCBSZWdhcmRz
LA0KRWxlbmEuDQoNCg==

