Return-Path: <linux-kernel+bounces-127100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C0088946AA
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 23:41:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20A74282E12
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 21:41:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45C6D54FBB;
	Mon,  1 Apr 2024 21:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fuyptb1C"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374B854BE9;
	Mon,  1 Apr 2024 21:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712007615; cv=fail; b=EULmZ+oyZYyFVjIhF2UrUoNY+xy6DDRyS/Zz9Ep3OWjOX5MGu/fwytSsZsnWCpuMyBexz01p+aDgwkv5qAeHJ2v0NhEIbbF1Woky24Ll1BxzE02g5kiehbi4QDA2uOQWVwOZLHn2EaXS3PXe//JJEwnq6C1i1vcUezo6nLlLDds=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712007615; c=relaxed/simple;
	bh=f0ql1bxUC8Xk0PPROTzweHLNnlNEmwq8ZC1Ua2C97jc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qyHqD5zUDBmgtN38mtlO9EtAhAAwVwjgFWDzp1dtsqhQfR77aYq8DDILZVVXyP28XnhtNl71alEFBgdrhVrig3IPsBFveuxN5Q7tFc4eB+NJJT1LZ2I56w7XyZ5tin6MfViIRQVNcqCA6EoDn62ZYBhFSI5kSI6ujeWWWm9v244=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fuyptb1C; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712007613; x=1743543613;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=f0ql1bxUC8Xk0PPROTzweHLNnlNEmwq8ZC1Ua2C97jc=;
  b=fuyptb1COE57GcCwx4SgGaF+xaUNFc4SPUr4/0+Fjh4g7tefeh2XWH1i
   9nwp6MLpM3m7WNgWKRd9ULLScvX4Dlu8DTj3y40yPsFfUkidDl7SiQEH/
   X14ZSBNW3SmzvyTMlCZynErx1tOaKbVkGgFyGQGb5Kv7/DYOFiTD+pmLn
   YoODuV/i+raE82t9wa2QZigDYpJ4ObbGSLZ0jZsOh9SnYKzUy+4WSV3VG
   Kw2yq/8BlvHVzCvJurO+tJIOQh8k6m6nAuy+qozd5JyyMn1NgY1UULlBD
   N6z0OjMrgW5Qp0wxvPdp2yo0MvQsW7iOl1cnJs6MouZIpqOrjs5Q8og+O
   g==;
X-CSE-ConnectionGUID: J4zn8eVRRIyIUA5hAWST8Q==
X-CSE-MsgGUID: PFncFh9QQ6KHGj45WnRxGg==
X-IronPort-AV: E=McAfee;i="6600,9927,11031"; a="7270696"
X-IronPort-AV: E=Sophos;i="6.07,173,1708416000"; 
   d="scan'208";a="7270696"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2024 14:40:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,173,1708416000"; 
   d="scan'208";a="17658431"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Apr 2024 14:40:10 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 1 Apr 2024 14:40:08 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 1 Apr 2024 14:40:08 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 1 Apr 2024 14:40:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZoGoVPXn3x43KIa9q2/JdOK/OvsXDBh1JKF2cW7opPOmVkg072imvpApbjZmwCPKhOBQNH6aDRG9xPF4oyXsWflEcRoYKBn5hH+14eDGGGAQM8PXQ1qkx9MwfXN8wdp7mZu+neVlu6P7l7BZ9wmiYn3DzJWNYfzTxIhsXnpnTw98ZoU9C53phSgglFIho1hu5h6RRrFVKAao0mxjtAnnHtjlkjAjYEAIliCExbBIlG068eUyMrCCW9WzaShi/lOJCE/MVrDV/lUn9alKS9x55tT/H9IuDhyPqb0WBktGTexvvLGerY4NCcom/sneO7vYNYZ9RYuo/FYl1BF7zuh3CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f0ql1bxUC8Xk0PPROTzweHLNnlNEmwq8ZC1Ua2C97jc=;
 b=bBL4VOneT1AyvLhrMMnpRkNf/ecTkENgrGkb2dA9yaBEDd//F4ik91pXl1mBvY72jYlDKSts8fixp0KUwOOQ+evWKdQIzf07M7J2rx2yUj3cdYzw9uh2kuCalE2RXKKDL2QRqhoDeOqRGc5mKdsQrfH0GjTTx7Lst1MPsCtp9jJpmSn2ziGBhMC6ODFpHsauPgwfGbBcJABFN+ja7HvigIUQ/oIfWk1Sz/CTazRkRJKDlFgRHGChEf6jkIwCo8aN0t+PRhStK+n8Tt9Zh/Vm79SY7p3PoI60kca3ChCXFBOKNjK0pXqFsvAj8hhKeU9KcDgYhbEIcc5NysjWEBVmNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO6PR11MB5635.namprd11.prod.outlook.com (2603:10b6:5:35f::14)
 by CH3PR11MB8592.namprd11.prod.outlook.com (2603:10b6:610:1b1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.24; Mon, 1 Apr
 2024 21:40:06 +0000
Received: from CO6PR11MB5635.namprd11.prod.outlook.com
 ([fe80::d3a0:f70a:9340:9a3e]) by CO6PR11MB5635.namprd11.prod.outlook.com
 ([fe80::d3a0:f70a:9340:9a3e%3]) with mapi id 15.20.7452.019; Mon, 1 Apr 2024
 21:40:06 +0000
From: "Wang, Weilin" <weilin.wang@intel.com>
To: Namhyung Kim <namhyung@kernel.org>
CC: Ian Rogers <irogers@google.com>, Arnaldo Carvalho de Melo
	<acme@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar
	<mingo@redhat.com>, Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>, "Hunter, Adrian" <adrian.hunter@intel.com>, Kan
 Liang <kan.liang@linux.intel.com>, "linux-perf-users@vger.kernel.org"
	<linux-perf-users@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Taylor, Perry" <perry.taylor@intel.com>,
	"Alt, Samantha" <samantha.alt@intel.com>, "Biggers, Caleb"
	<caleb.biggers@intel.com>
Subject: RE: [RFC PATCH v6 4/5] perf stat: Add retire latency print functions
 to print out at the very end of print out
Thread-Topic: [RFC PATCH v6 4/5] perf stat: Add retire latency print functions
 to print out at the very end of print out
Thread-Index: AQHagg0ZNLnTKl1HOUmgdHwtTgjvY7FT7CWAgAAAe7CAAAKoAIAAAmkg
Date: Mon, 1 Apr 2024 21:40:06 +0000
Message-ID: <CO6PR11MB56350E73343340DE68BB44BAEE3F2@CO6PR11MB5635.namprd11.prod.outlook.com>
References: <20240329191224.1046866-1-weilin.wang@intel.com>
 <20240329191224.1046866-5-weilin.wang@intel.com>
 <CAM9d7ciqiAOV_1A0N3he_Jiw3ur-ZN6djWpzgR2C+AF2m9an5A@mail.gmail.com>
 <CO6PR11MB56356D30DC2EE8F0EB7ADB30EE3F2@CO6PR11MB5635.namprd11.prod.outlook.com>
 <CAM9d7chNd70gWCOe+268mTiLHAaGQEeJc9B5TebdexM-s_sB0A@mail.gmail.com>
In-Reply-To: <CAM9d7chNd70gWCOe+268mTiLHAaGQEeJc9B5TebdexM-s_sB0A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR11MB5635:EE_|CH3PR11MB8592:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ORn/eV5PMSHWRaMrfqYwi+DkYwDj6BFXrfpKY0Kg2QH8CV/YjiXu3WnvXDfd8zNyYTJrHd4gaiZwBzG+qtw2PAse7DxeWTiQG1pyOyd76WGVEgss+fH+8itRl3jMI3SIJM3yvVvfm1XwktVolcetp574GnB8f857QJmMQTtQZz4Dgct3tGu8V5MajKBq8II6SrAP9nItgWntCmS1Ga4wHAHlhVmY4e+YE4OtuvBnkJogIOLBYU0OHKSZvMHHt/gUMroOfQ1684POJRhAn1pLpvXYt2Y4B11X0Jitm9yGUaDFJOPFCN5lEMFVGRbOtisZm/LvdAv2EceI8m54JrGHKIGiXKOqIetxC4mYF3a3o7ykUvdqUTcHRbhsz/jnnovrUvzgxQaNzTBLe3BURxbRH5GCazkYEhvzEttLYpIwCAb6IkGZyNcmoOxbSmWy/Zq/G8QZ1VV37V/nrekH0LQrWchnEPo3wyS+UAfdriMeQFmZCShPHSo9gLVBI13G6hry2Qyj+IyXM+GuoQ3p89N5hwZGeoKDbrUm0Z6jTnWSd2HbE6bou0JYSexIcIh2Zn0Z6V1u7U+Koj4JpWBbUqUuve0BRcAriBGJu72CsMYVSBLEyyfSdFzfEl59EpAL6zy2ucCpNaPdhrAR0rEdzE1eDSOKW0INKNn3gYEavagxXDg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5635.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(7416005)(376005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UjE0SFhOVjY3OXhaVWhyWjlkZ0JUOHh0aUhwZ2s1Si9lZ0RBL2hBZit2Ty8r?=
 =?utf-8?B?N2JXVmwySmxlWjJqY3pjZWl0U3ExdW1NZkRFSHd1czVnQUtsUk1sOUtXTmxt?=
 =?utf-8?B?TGJuZ2dkZXZPR2JUWjl1d04wd3lvWll6aGttNFBoSkJWN0lLR0ppNm1CcnNV?=
 =?utf-8?B?Z01RWTIxZEFzRXBUUmxMTnhEaHphc2xKR09KdlBhTFlPZFZBb1NSQ1BXanZS?=
 =?utf-8?B?a1Q4N1N5cGtrdzFJbkF4VVJRclVMVE42ZGw3ZUw3bnVNbFdWcisvMDhZWk4r?=
 =?utf-8?B?Myt1QnJ2eUl1eGFZT3pjdUFOelVDdThaNzhkallMdUZNblpMRXpCcFRxVnkr?=
 =?utf-8?B?T05DTk85VktYR09DbmNuVURkYmQzS09Qd2JleXBGZ01Fb1VyTjQvaFlDVGlD?=
 =?utf-8?B?dVpINWY3NWZ2Kzk3bFUvcjBSNUxOcTFwaHhBQi9pMU90MDZFNGdtV2gwUld3?=
 =?utf-8?B?NFFzTXIzUFQ3RG9RWlFpL3g5aXBpM050MW1lMkJ3Ym9WZGlFN0hrK0pKRVNz?=
 =?utf-8?B?ZHpsU2xUTUd0YXk2aDVaaGU3U3czcDRneDBzeVF1b1JRSWR3NDUvd2crVFJV?=
 =?utf-8?B?dWg5ZWNvMDU4TE5mUDE5dFZra0trSEVXS0YveTUwSnFOQkRCcENuQUFQK25L?=
 =?utf-8?B?N3hidWRMbk04STdxVE9oeHdRTUdIWWlEYUdWa2E4Ukd1L3FDeFFqV28zTkMv?=
 =?utf-8?B?SXcwOTZ0S0tRd1dTNlFFRmIwdHFFbStJSCtzelFSa2NzWkFwVCtnTkhVVFRS?=
 =?utf-8?B?d3VhRm9ZQnN2ZlRiUlVERjhFelRsYWhiOTZyYVRiaitCUUIxTmc5VzJ1TWU1?=
 =?utf-8?B?L1FlV2JtQUtlUTh2Yzd5S2lEajkrVnZ0TkdNeU1DT3ZZcEtNUVNsbzBhKzFJ?=
 =?utf-8?B?dEtWaGx2N3FwTC9jbEJ6S25IR1FXV3c0M01NT2ZxdnVWQWVXVnVocmsrKzBH?=
 =?utf-8?B?dGhrbGdCMHltUTluYmtlMC9kWjhveU1XY05sd0tTc3Z5cERWZHo5a1lFalMw?=
 =?utf-8?B?azl4SHhRdEhyZ1ZJV2d1NTJQSitzOEhZNzRXRG9YMTliSC9RUXp5V3ZuQ0xx?=
 =?utf-8?B?a1JVTFNvTDIvN0hpMTVHeWFyWm03Z05NUTlMaEFkWWM4NmE5MUdyeldGUU5m?=
 =?utf-8?B?a2NuTFBlMkd0T1dqTW9rWlJsTnZxdUQ4YlhaaVBCVHBZQnNQbTJLbUR3Z1VR?=
 =?utf-8?B?SDRuaTVOMGNjMkkxaE4xdklqY2N5ZTh3TFAvTFNGUlNkbzlGNmhQUS9ITEw5?=
 =?utf-8?B?WjAyeGVyZ1BVSGRVRHNFcEpKMlZWcmVwbHpXRmlTOUIzZjFsSERKZ2ZnaTNv?=
 =?utf-8?B?czZ0amN1b1NLTWFROGhFVkhFbnJ6ampZSDdWOE1jVXlYcmJLVi94Y2FsazV4?=
 =?utf-8?B?c3lERXhFODErRXQzR1N4ZGNPTlpES2Z3VTBxZEp5eUgxQk9qQ2V6S3hFbnlH?=
 =?utf-8?B?VElGNlkwNmVPWGFoVlhQcGRVYS9Ka0dUb1pUZzJrWVRwamV1TDZ5NUtuOTBR?=
 =?utf-8?B?NkNDb1I0ZWN4cWlqYVg3c2x5KzhxenhzZmc4a2ZMelhnQlVuZHJhZkZZMVhr?=
 =?utf-8?B?d3kveG42ampUeWcyTDUzaG4vRWZkS2pKWFdyc2c2TXZUUEFmNFJpUGxyb0dZ?=
 =?utf-8?B?T20yVFFDRnBwWlI2eCtLcjlPSE9SL1R5bXRSckFnOUZvT3ZSZWdlWmI1R2ho?=
 =?utf-8?B?MzJ5V1g3WVp1Sm9qUXhqd2t4ZTllL0dsOEp6YVd0Qjc0TDlobmlXaC9hdlpO?=
 =?utf-8?B?NENlcnRCaWNUd3VtTFN0T2pPaWhCQlQrVjVGMi9pL1lvVU1vbVhBZS9QUTZW?=
 =?utf-8?B?SWl3Z1ZFTy9VSFNZUDRReS9GWitUY1BIdzJZOEFNOTV1Q1p1bCsvVHAzSi8w?=
 =?utf-8?B?dzN4eUdCd1JUOHhJU3JvV3lYRUxOUXJrMG4vTDZ4SzNYVW85b0Z1Wk9EQW1q?=
 =?utf-8?B?ZlZML2s2OVRUZGxaZm1ZZk1PemozclJGWU5OVHg3cU0yZk1GL2dyNGU1TTlu?=
 =?utf-8?B?YWI3R2pSVUhnL2YybGN4TTgwaysrK1NtdDV5UkdmRVI4L1ozcjZWYU8yMzhN?=
 =?utf-8?B?Wi9ScElWY0ZYQXM4bEdwMk4wdFUrQXpvRXNhcXovWm5kYWxoQkM0eFdiTUdC?=
 =?utf-8?Q?pYoCQjqCFan4K70sz9ZVpUyRV?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5635.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6169b2b8-0466-49df-1007-08dc52944bef
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2024 21:40:06.2287
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ADpCVmBaeTqwoGwTZ0R1phD02NPAC36/Kez7xcHmFJrDvJNRnd74rXmFfNeNB/fZoKTBzWRI13TmxguorwwWvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8592
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTmFtaHl1bmcgS2ltIDxu
YW1oeXVuZ0BrZXJuZWwub3JnPg0KPiBTZW50OiBNb25kYXksIEFwcmlsIDEsIDIwMjQgMjoxNSBQ
TQ0KPiBUbzogV2FuZywgV2VpbGluIDx3ZWlsaW4ud2FuZ0BpbnRlbC5jb20+DQo+IENjOiBJYW4g
Um9nZXJzIDxpcm9nZXJzQGdvb2dsZS5jb20+OyBBcm5hbGRvIENhcnZhbGhvIGRlIE1lbG8NCj4g
PGFjbWVAa2VybmVsLm9yZz47IFBldGVyIFppamxzdHJhIDxwZXRlcnpAaW5mcmFkZWFkLm9yZz47
IEluZ28gTW9sbmFyDQo+IDxtaW5nb0ByZWRoYXQuY29tPjsgQWxleGFuZGVyIFNoaXNoa2luDQo+
IDxhbGV4YW5kZXIuc2hpc2hraW5AbGludXguaW50ZWwuY29tPjsgSmlyaSBPbHNhIDxqb2xzYUBr
ZXJuZWwub3JnPjsgSHVudGVyLA0KPiBBZHJpYW4gPGFkcmlhbi5odW50ZXJAaW50ZWwuY29tPjsg
S2FuIExpYW5nIDxrYW4ubGlhbmdAbGludXguaW50ZWwuY29tPjsNCj4gbGludXgtcGVyZi11c2Vy
c0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IFRheWxvciwg
UGVycnkNCj4gPHBlcnJ5LnRheWxvckBpbnRlbC5jb20+OyBBbHQsIFNhbWFudGhhIDxzYW1hbnRo
YS5hbHRAaW50ZWwuY29tPjsgQmlnZ2VycywNCj4gQ2FsZWIgPGNhbGViLmJpZ2dlcnNAaW50ZWwu
Y29tPg0KPiBTdWJqZWN0OiBSZTogW1JGQyBQQVRDSCB2NiA0LzVdIHBlcmYgc3RhdDogQWRkIHJl
dGlyZSBsYXRlbmN5IHByaW50IGZ1bmN0aW9ucyB0bw0KPiBwcmludCBvdXQgYXQgdGhlIHZlcnkg
ZW5kIG9mIHByaW50IG91dA0KPiANCj4gT24gTW9uLCBBcHIgMSwgMjAyNCBhdCAyOjA44oCvUE0g
V2FuZywgV2VpbGluIDx3ZWlsaW4ud2FuZ0BpbnRlbC5jb20+DQo+IHdyb3RlOg0KPiA+DQo+ID4N
Cj4gPg0KPiA+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiA+IEZyb206IE5hbWh5
dW5nIEtpbSA8bmFtaHl1bmdAa2VybmVsLm9yZz4NCj4gPiA+IFNlbnQ6IE1vbmRheSwgQXByaWwg
MSwgMjAyNCAyOjA0IFBNDQo+ID4gPiBUbzogV2FuZywgV2VpbGluIDx3ZWlsaW4ud2FuZ0BpbnRl
bC5jb20+DQo+ID4gPiBDYzogSWFuIFJvZ2VycyA8aXJvZ2Vyc0Bnb29nbGUuY29tPjsgQXJuYWxk
byBDYXJ2YWxobyBkZSBNZWxvDQo+ID4gPiA8YWNtZUBrZXJuZWwub3JnPjsgUGV0ZXIgWmlqbHN0
cmEgPHBldGVyekBpbmZyYWRlYWQub3JnPjsgSW5nbyBNb2xuYXINCj4gPiA+IDxtaW5nb0ByZWRo
YXQuY29tPjsgQWxleGFuZGVyIFNoaXNoa2luDQo+ID4gPiA8YWxleGFuZGVyLnNoaXNoa2luQGxp
bnV4LmludGVsLmNvbT47IEppcmkgT2xzYSA8am9sc2FAa2VybmVsLm9yZz47IEh1bnRlciwNCj4g
PiA+IEFkcmlhbiA8YWRyaWFuLmh1bnRlckBpbnRlbC5jb20+OyBLYW4gTGlhbmcgPGthbi5saWFu
Z0BsaW51eC5pbnRlbC5jb20+Ow0KPiA+ID4gbGludXgtcGVyZi11c2Vyc0B2Z2VyLmtlcm5lbC5v
cmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IFRheWxvciwNCj4gUGVycnkNCj4gPiA+
IDxwZXJyeS50YXlsb3JAaW50ZWwuY29tPjsgQWx0LCBTYW1hbnRoYSA8c2FtYW50aGEuYWx0QGlu
dGVsLmNvbT47DQo+IEJpZ2dlcnMsDQo+ID4gPiBDYWxlYiA8Y2FsZWIuYmlnZ2Vyc0BpbnRlbC5j
b20+DQo+ID4gPiBTdWJqZWN0OiBSZTogW1JGQyBQQVRDSCB2NiA0LzVdIHBlcmYgc3RhdDogQWRk
IHJldGlyZSBsYXRlbmN5IHByaW50DQo+IGZ1bmN0aW9ucyB0bw0KPiA+ID4gcHJpbnQgb3V0IGF0
IHRoZSB2ZXJ5IGVuZCBvZiBwcmludCBvdXQNCj4gPiA+DQo+ID4gPiBPbiBGcmksIE1hciAyOSwg
MjAyNCBhdCAxMjoxMuKAr1BNIDx3ZWlsaW4ud2FuZ0BpbnRlbC5jb20+IHdyb3RlOg0KPiA+ID4g
Pg0KPiA+ID4gPiBGcm9tOiBXZWlsaW4gV2FuZyA8d2VpbGluLndhbmdAaW50ZWwuY29tPg0KPiA+
ID4gPg0KPiA+ID4gPiBBZGQgcHJpbnQgb3V0IGZ1bmN0aW9ucyBzbyB0aGF0IHVzZXJzIGNvdWxk
IHJlYWQgcmV0aXJlIGxhdGVuY3kgdmFsdWVzLg0KPiA+ID4gPg0KPiA+ID4gPiBFeGFtcGxlIG91
dHB1dDoNCj4gPiA+ID4gSW4gdGhpcyBzaW1wbGUgZXhhbXBsZSwgdGhlcmUgaXMgbm8NCj4gTUVN
X0lOU1RfUkVUSVJFRC5TVExCX0hJVF9TVE9SRVMNCj4gPiA+IHNhbXBsZS4NCj4gPiA+ID4gVGhl
cmVmb3JlLCB0aGUgTUVNX0lOU1RfUkVUSVJFRC5TVExCX0hJVF9TVE9SRVM6cCByZXRpcmVfbGF0
ZW5jeQ0KPiA+ID4gdmFsdWUsIGNvdW50DQo+ID4gPiA+IGFuZCBzdW0gYXJlIGFsbCAwLg0KPiA+
ID4gPg0KPiA+ID4gPiAgUGVyZm9ybWFuY2UgY291bnRlciBzdGF0cyBmb3IgJ3N5c3RlbSB3aWRl
JzoNCj4gPiA+ID4NCj4gPiA+ID4gICAgICAgIDE4MSwwNDcsMTY4ICAgICAgY3B1X2NvcmUvVE9Q
RE9XTi5TTE9UUy8gICAgICAgICAgIyAgICAgIDAuNiAlDQo+ID4gPiB0bWFfZHRsYl9zdG9yZQ0K
PiA+ID4gPiAgICAgICAgICAzLDE5NSw2MDggICAgICBjcHVfY29yZS90b3Bkb3duLXJldGlyaW5n
Lw0KPiA+ID4gPiAgICAgICAgIDQwLDE1Niw2NDkgICAgICBjcHVfY29yZS90b3Bkb3duLW1lbS1i
b3VuZC8NCj4gPiA+ID4gICAgICAgICAgMyw1NTAsOTI1ICAgICAgY3B1X2NvcmUvdG9wZG93bi1i
YWQtc3BlYy8NCj4gPiA+ID4gICAgICAgIDExNyw1NzEsODE4ICAgICAgY3B1X2NvcmUvdG9wZG93
bi1mZS1ib3VuZC8NCj4gPiA+ID4gICAgICAgICA1NywxMTgsMDg3ICAgICAgY3B1X2NvcmUvdG9w
ZG93bi1iZS1ib3VuZC8NCj4gPiA+ID4gICAgICAgICAgICAgNjksMTc5ICAgICAgY3B1X2NvcmUv
RVhFX0FDVElWSVRZLkJPVU5EX09OX1NUT1JFUy8NCj4gPiA+ID4gICAgICAgICAgICAgIDQsNTgy
ICAgICAgY3B1X2NvcmUvTUVNX0lOU1RfUkVUSVJFRC5TVExCX0hJVF9TVE9SRVMvDQo+ID4gPiA+
ICAgICAgICAgMzAsMTgzLDEwNCAgICAgIGNwdV9jb3JlL0NQVV9DTEtfVU5IQUxURUQuRElTVFJJ
QlVURUQvDQo+ID4gPiA+ICAgICAgICAgMzAsNTU2LDc5MCAgICAgIGNwdV9jb3JlL0NQVV9DTEtf
VU5IQUxURUQuVEhSRUFELw0KPiA+ID4gPiAgICAgICAgICAgIDE2OCw0ODYgICAgICBjcHVfY29y
ZS9EVExCX1NUT1JFX01JU1NFUy5XQUxLX0FDVElWRS8NCj4gPiA+ID4gICAgICAgICAgICAgICAw
LjAwIE1FTV9JTlNUX1JFVElSRUQuU1RMQl9ISVRfU1RPUkVTOnAgICAgICAgMCAgICAgICAgMA0K
PiA+ID4NCj4gPiA+IFRoZSBvdXRwdXQgaXMgbm90IGFsaWduZWQgYW5kIEkgdGhpbmsgaXQncyBo
YXJkIHRvIHJlYWQuDQo+ID4gPiBJIHRoaW5rIGl0IHNob3VsZCBwcmludCB0aGUgcmVzdWx0IGxp
a2UgdGhpczoNCj4gPiA+DQo+ID4gPiAgICAgPHN1bT4gIDxldmVudC1uYW1lPiAgIyA8dmFsPiAg
YXZlcmFnZSByZXRpcmVkIGxhdGVuY3kNCj4gPg0KPiA+IFNpbmNlIHdlIHdvdWxkIGxpa2UgdG8g
dXNlIHRoZSBhdmVyYWdlIHJldGlyZSBsYXRlbmN5LCBJIHdvdWxkIHRoaW5rIHB1dA0KPiBhdmVy
YWdlDQo+ID4gYXQgdGhlIGJlZ2lubmluZyB3b3VsZCBiZSBtb3JlIGNvbnNpc3RlbnQuIFNvIGlu
IGZvcm1hdCBsaWtlOg0KPiA+IDx2YWw+IDxldmVudC1uYW1lPiA8c3VtPiA8Y291bnQ+IG9yIDx2
YWw+IDxldmVudC1uYW1lPiA8Y291bnQ+DQo+IDxzdW0+ID8NCj4gDQo+IEJ1dCBpdCdzIG5vdCBj
b25zaXN0ZW50IHdpdGggb3RoZXJzLiAgV2hlbiBJIHNlZSB0aGUgcGVyZiBzdGF0DQo+IG91dHB1
dCwgSSdkIGV4cGVjdCBpdCBzaG93cyB0aGUgdG90YWwgY291bnQuICBBbmQgdGhlIGF2ZXJhZ2UN
Cj4gbGF0ZW5jeSBpcyBhIGRlcml2ZWQgdmFsdWUgc28gSSB0aGluayBpdCBjYW4gYmUgdHJlYXRl
ZCBhcyBhIG1ldHJpYy4NCg0KSSB0aGluayB3aGV0aGVyIGl0IGlzIGNvbnNpc3RlbnQgb3Igbm90
IGRlcGVuZHMgb24gaG93IHdlIHJlYWQgdGhpcyBkYXRhLiANCklmIHRoZXJlIGlzIG11bHRpcGxl
eGluZyBoYXBwZW5pbmcsIHdvdWxkIHRoZSB0b3RhbCBjb3VudCB2YWx1ZSBvZiBldmVudHMgYmUN
CnRoZSBzY2FsZWQgY291bnRzIG9yIHJhdyBjb3VudHM/IElmIHRoZXNlIGFyZSBzY2FsZWQgY291
bnRzLCB0aGVuIHRoZXNlIGFyZSANCmRlcml2ZWQgdmFsdWUgYXMgd2VsbC4gQnV0IHdlIGRvIGV4
cGVjdCB0aGUgZmlyc3QgY29sdW1uIHNob3dzIHRoZSB2YWx1ZSB3ZSANCmNhcmUgbW9zdCBmcm9t
IHRoZSByb3cuDQoNClRoYW5rcywNCldlaWxpbg0KDQo+IA0KPiBUaGFua3MsDQo+IE5hbWh5dW5n
DQo=

