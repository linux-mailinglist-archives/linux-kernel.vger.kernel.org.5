Return-Path: <linux-kernel+bounces-83086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF94E868E3E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 12:00:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 848C2281D6E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 11:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F27C1386C8;
	Tue, 27 Feb 2024 11:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Id45SaLh"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 243F62A8C1
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 10:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709031601; cv=fail; b=hjpo77zT8eF2PbcEaa8JegKiskFhYIk7wlhI6Xlb9xFY5Q4sZ1xFi/0IIw1t9xX6v+qhUA5LN+vR8qfjedUxPfrd01kIC10uBemo0VBGWBeYsG8YMVX8NDQrqDITtuW3nmuBTTm2Wl9VoPoAbVssj3kr6ugl0Iz/x4QP+Mcew4o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709031601; c=relaxed/simple;
	bh=qv3fDl8l4geYAWyzYdJw9CIcfzcHjjq6o8sc5lqrwug=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mmihjFlo2TGywrUsuAeAczhsKcZ7SXy0kcY6JxGn7th4jbE3sqXGLHtLrNMBatCB1tJdSbLn2CZuC5wLWfrerMDRRrdLVqNI61yXwUdMGEmSFHLTHFidZ08xtOzlcxAA8tBtABJfNhX13+nAFvrabh+X3SF04dRt+BVGIgAQD80=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Id45SaLh; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709031599; x=1740567599;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=qv3fDl8l4geYAWyzYdJw9CIcfzcHjjq6o8sc5lqrwug=;
  b=Id45SaLhxXp+u0epZj80a3iNzbTqOGPi+oUiZQm0Sjy3pNvmd4JmAyhP
   b49AZKoCrBKY8pBLzOZhomhQ5Dgp/Utf0pfSUXXxf5XxaDvYH/H6lGPXR
   sLaqdCFpAHiIWZpDtexgoaV67b6wTYs2V/eQyOwSa4rP90pdvCfOeMPgo
   KXAn+XE4jHslCfSr+4S+dfNYBnU6CkoLMSMgrx1lvYEKDB8q7VbrUnCOz
   WLgsw5Bv/xUfDhW9lIwjk/NZ6k1TcvF2WKa5bvpd00E0KlyM0UvwRwCIl
   wLZvsa7HJpv+3TAvliW2bV8gWVDEUq06K11JQwmu0J5fuTXPXrz8LFHDP
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="3492939"
X-IronPort-AV: E=Sophos;i="6.06,187,1705392000"; 
   d="scan'208";a="3492939"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2024 02:59:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,187,1705392000"; 
   d="scan'208";a="11597141"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Feb 2024 02:59:58 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 27 Feb 2024 02:59:57 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 27 Feb 2024 02:59:57 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 27 Feb 2024 02:59:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BrChFUFwpVy5rkWJ7WgeP9Iu5YM7XUzKM/jPvQlV2h18Wht73P3BBuSvMSxUHOpWb7s9bPhKSDYGKzj4kpMgV6TPfB9hn5Imbi2BejhBbBiwOpqrwK9DL2bECctbrvg82WovJ+c5hTMmRcUC3NGurInFsoMvgKj7CDMbsiJBlYMf7xaPBRYNF1pWCkmALfeCAsU74YHdqVIU55dAPIn50lt2NqNt2bJsY+FVVoyNqxuHz8M3qw2KQLMpnMKE4ysnfcpoC4CvG1TbhSmFe6UVDBDO736QN28w3vCAHycXyRxkWhMwXxPgo00wmXz6cN1CDSc2Ik6Uu3fjVkB/P4Vy0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qv3fDl8l4geYAWyzYdJw9CIcfzcHjjq6o8sc5lqrwug=;
 b=HKmH1f81gB+YFo4vbGW+KCwhxzXjY4rp8gDNiHQXTHAnUF6T6zdG+pnT4C1wKUjK+/BFlqoRpthKNx86BgUKT6Q6R0MLlnfHDbCs4WBlboN+KMEwntND0qZccswCLNTjtVsAmB5zPuPBOQaRCkKUv26sox0uHuSOY0DrlpjX4qFa9RURRHInD2G2v617p+xoYU96/lHojkp+8Pg5YS3XX227Yb12n7ybLwGbhkRQWbMqpvE49cBlY7XRy2WAiWe/GzNsV5f2ZkeNhRl1m5bLzdovxL1V+88PceCZySKhH73GlwZ4NQQzsCFfEtWBLuAi0xgX3c2PmmXN8Em/GyTpyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by BN9PR11MB5260.namprd11.prod.outlook.com (2603:10b6:408:135::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.25; Tue, 27 Feb
 2024 10:59:55 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ef2c:d500:3461:9b92]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ef2c:d500:3461:9b92%4]) with mapi id 15.20.7339.024; Tue, 27 Feb 2024
 10:59:55 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
CC: "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "x86@kernel.org" <x86@kernel.org>, "bp@alien8.de"
	<bp@alien8.de>
Subject: Re: [RFC][PATCH 06/34] x86/boot: Use consistent value for
 iomem_resource.end
Thread-Topic: [RFC][PATCH 06/34] x86/boot: Use consistent value for
 iomem_resource.end
Thread-Index: AQHaZb8hy4dDbnSHFkih6C56qRgvL7EeDKuA
Date: Tue, 27 Feb 2024 10:59:55 +0000
Message-ID: <195ad815f14b71c46de94281f0af57027b4e3fff.camel@intel.com>
References: <20240222183926.517AFCD2@davehans-spike.ostc.intel.com>
	 <20240222183934.033178B5@davehans-spike.ostc.intel.com>
In-Reply-To: <20240222183934.033178B5@davehans-spike.ostc.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.50.3 (3.50.3-1.fc39) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|BN9PR11MB5260:EE_
x-ms-office365-filtering-correlation-id: dbce67ef-3df2-44b2-5356-08dc37833b10
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: esUGoivA4zI39fHouydsLbkQpZY6WEIsZMv3jpDvnxl4JIi4mQmJJcIIvvIwquAOGyTz0cwZqX3WyuHUt2ZRsIMkPk5Durcp1e6BfI5w+OmGAs2nqQftHdcewx/yqKTvvNel6ewRoGebV/HTzOBaRjslQ1umQPBW4tu68Hg2vKVYiCQhGXnSM25Y/2UD8COSHn7SAott6TzFF+RA+KLyb6BkMwDzBFkbkEvIYpX+Fi6PGXM1dP4+dI1h3x9BuoA4gHwDVb0Bm5rl8flSIwk6Aqrz8qPKG162yT94AxOJpUjPt+BAzRiwAz1BqVcJ+yT2gNtROjoPau8eFBClyGwRxB18/rzc6j+/u4vLMzyjlY8OXyxr7u5a0mY4rX2R9wapwlyppkrPnaJQcWtLGX5s69LPN55VOwtBHISrlaw/WVcMIQAn1p4zAR/2hlYIlziL+clw2/9QGFojI98/vuGBhp1kB+XrmsjzDC3x0qYv1icCJ7ac3+BJDETRu3wT0Xha/SqJ7jg1CyPobPx1mTT2ZT7QhNZdriD4gFW1UZQH/vtMVmdpFUGW4qh8yEGmOXFiFSDfR8BQmMkHm7BdkYC+yklmQPCGistdJhP9lHtCzXarmYktU7KHdk12SGu/JmFbH51wQW0KEJNr3uSJQPT6qDrOn6XbF2bXU1GZWme+vThA1ErzDPogncLVZBKLF7X2mfKlbuoFPHTZ39ik8jsPcA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MlhrVDNsS2JwNGx5VzhaUUFlSDc1RDlrVDU3ajVQbkRpa2swY3BhZ0F1QS9h?=
 =?utf-8?B?VW5NdllyeWovWVBLQjVPZEVONFZlTkVjTFlrT0R2dWtrQk9tSzNxQ1Q3blNW?=
 =?utf-8?B?dXM4dm1RNGVrdW1lZm9TTTBuUndtS09ITXkwVlNUdnJsM2RTeWd2cU1tWmg4?=
 =?utf-8?B?em9WcjFVZjRWMUJlYy9FYk9rS1N0UE92VVZuL3FlaXVYRmRCdnVzbWIwN0k2?=
 =?utf-8?B?UEd0MUhtTW0xUkgvalhNM1o2T29HNGxSNGF2SEluTzllS213TFBKUzNKeDc5?=
 =?utf-8?B?L2ZTSUFUU2hORnNTT2lWbWlFL0tWQjBrbkF1eE5EYWh4bDUrWnlYbTdqYUw3?=
 =?utf-8?B?aTNacmkxUVZMYUk5UXB2WUhFL1k3SU5QZFRzdG9oekNuMWZoa3NxaEFtM3NR?=
 =?utf-8?B?eUowUlRFaXdRTlRRL0dFTnkyTmtrTW12dVZ1NXRYeFpVdzdnNzkyRE5YbVpa?=
 =?utf-8?B?SHN2bnNpYXY4U1JiUUZrV3Ntb2lwbTFsVklVVUNyWEw5SHd1dHNIRkZtRGM3?=
 =?utf-8?B?bkVLWjZFeCswNGg5UFY3dTd4aWttekFHQnppbUQ1NFRhRVhabG45N0NmbHBB?=
 =?utf-8?B?UXBZWDNVYWM5bmlGL2ZUdGRkK2ZTMkZiZ0FKcWRVK3o2UVZHS3MwUVp3SEoy?=
 =?utf-8?B?QldVVW9OQWNyYXRwU1RZdU1RL3doamlPQ1JZb3B3T2poYXNGOXJiRER0cVUz?=
 =?utf-8?B?Q1hYU0RVUmlBSUJsY1ZLMlYwRGYza1oyQThKWmw0V2NsbmdncUFQVHE0ZVJF?=
 =?utf-8?B?VExVMTc1WVE2RDU4VU4rOUcrZy8rNW5WeVJEMnZXeU9mNHpSdmFtd2ovTEo5?=
 =?utf-8?B?YUNWZEUvOWRJclg3WHlnOW9vbTNpdFdEVUtnZG9YMzAxbklsYTkrZUJ6Tk1C?=
 =?utf-8?B?T3FEdDVrdWVHdU01OWJHR2tUM3BGd0tyNlFmM1UvK0R0WFNtdlZmTm1jNmo0?=
 =?utf-8?B?ZmRLOHlYdnBmVG4vNTloNHcrSUl4dndTRE04cnVDVXVsU1ZNODI3TEhUSGVX?=
 =?utf-8?B?RmhBU0poOUlRcXgyWkIvZHI4RmtzN25KWUFkODFSbGdsMDcxanBqVUFGVkVp?=
 =?utf-8?B?OWNXQVErMXVjRmZQYytHMEsxekNrbS9PdUJ5NlFDVXZJY2R3VXJDbzg5eTV4?=
 =?utf-8?B?K2NCd3hUdEIvYXFJNVhiUCt5NjM5OUlHUXlqWDB6RkNFTEZWUXZmRG9YL1RJ?=
 =?utf-8?B?TWwzT0IvTmFxcis2c2laaHBjMjJpWVFtbFFJWDJGcFg4NVJFdXQzZW9Lbmpu?=
 =?utf-8?B?TFVPMkJaZDJPU2VmbXNZeDlxd09DMHJCSk01aDQrY2RCUXR0WnJQYXFjYURY?=
 =?utf-8?B?Yjgyd01pVmNCSVBaaU16TlpGVE5yZTRsY1laVVh6OUMwQVZVQ013bFp5dmFi?=
 =?utf-8?B?bm51SUk5cUNaemU1ZlB5QVhmelNDcXp0NDVLY0MvRkExR09wUDl1RXdRaisy?=
 =?utf-8?B?VUF4cW4wOG9JYStuNE5uVjc4NmZwazMrRnliWU5qNFBmVmFzU1dXeExVSTJ3?=
 =?utf-8?B?NnBjdkpKei9ZbzdUaUJTQlJCNWI5RFhTRi9mcWtmM1dpRzMrSlp6Q3BxNTY4?=
 =?utf-8?B?MG5CV1VQZW51UFpBU25hZXlCekNHV2FqTDZiMXduSWZpaWYzWDM5aU1WZGlI?=
 =?utf-8?B?dHdMOUdRVGJ1Nm9ySlp4MmxDNytJczYxcER5WDRnQWhpc0QzdUp3NnZvaEZV?=
 =?utf-8?B?bGV5OFlDeDF1MW9pbjZFT0VGd3M0ZFVFZ1dGMnN1RlVtY2MxNEF0aUNWMWox?=
 =?utf-8?B?TzIzNVdrT1M2NnFZbGoxV1JRenRtWVF4UWJuTGlDbUdHVThpaXk3WmYycjd0?=
 =?utf-8?B?U3NuRGNXa2EwVkM0cTlQMWx5dmtFM3hneWpjOWFmVlAzM1ZxdWNjcXpJVlJt?=
 =?utf-8?B?Q0JwT0RnS1FtcmRObWd3TmdpSkRuL2hlT0g2KzV1SkliOE1OWXRHeS90RUk0?=
 =?utf-8?B?V3RVQUZGZUZSN3c5S09odHJmYWh6Tk9ZZzA3aWNlS28yRjFiTVZDa1BFTEFG?=
 =?utf-8?B?OWpDM29CdmljQjVhMlFrcWUvK2N1WmxsTVlaL0QvQndZWmxwUnVyVGcySXFZ?=
 =?utf-8?B?emFJTS9YSHNUYnQ5emlNS2RkREJHcmVDMElIYVFxekpMakpPTjkzMUt0SmZV?=
 =?utf-8?B?LzZWNjVXMTVlMGN2SUIwNlF3a0prVFdlWHN2M0RyQ1U1ZGYyZjJPZEhlenVR?=
 =?utf-8?B?SlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <260F75304F89D84D9837274EB04BF173@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbce67ef-3df2-44b2-5356-08dc37833b10
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2024 10:59:55.0904
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MPKy71qMFx+L5QxO5dLZ63NC2pt+vgzjEaLzio9294C/LI1EXjSgwBWMQKKeVWSlu0/DoEirGMGD9tJgXbSIVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5260
X-OriginatorOrg: intel.com

T24gVGh1LCAyMDI0LTAyLTIyIGF0IDEwOjM5IC0wODAwLCBEYXZlIEhhbnNlbiB3cm90ZToNCj4g
RnJvbTogRGF2ZSBIYW5zZW4gPGRhdmUuaGFuc2VuQGxpbnV4LmludGVsLmNvbT4NCj4gDQo+IFRo
ZSAnc3RydWN0IGNwdWluZm9feDg2JyB2YWx1ZXMgKGluY2x1ZGluZyAnYm9vdF9jcHVfaW5mbycp
IGdldA0KPiB3cml0dGVuIGFuZCBvdmVyd3JpdHRlbiByYXRoZXIgcmFuZG9tbHkuICBUaGV5IGFy
ZSBub3Qgc3RhYmxlDQo+IGR1cmluZyBlYXJseSBib290IGFuZCByZWFkZXJzIGVuZCB1cCBnZXR0
aW5nIGEgcmFuZG9tIG1pc2htYXNoDQo+IG9mIGhhcmQtY29kZWQgZGVmYXVsdHMgb3IgQ1BVSUQt
cHJvdmlkZWQgdmFsdWVzIGJhc2VkIG9uIHdoZW4NCj4gdGhlIHZhbHVlcyBhcmUgcmVhZC4NCj4g
DQo+IGlvbWVtX3Jlc291cmNlLmVuZCBpcyBvbmUgb2YgdGhlc2UgdXNlcnMuICBCZWNhdXNlIG9m
IHdoZXJlIGl0DQo+IGlzIGNhbGxlZCwgaXQgZW5kZWQgdXAgc2VlaW5nIC54ODZfcGh5c19iaXRz
PT1NQVhfUEhZU01FTV9CSVRTDQo+IHdoaWNoIGlzIChtb3N0bHkpIGEgY29tcGlsZS10aW1lIGRl
ZmF1bHQuICBCdXQNCj4gaW9tZW1fcmVzb3VyY2UuZW5kIGlzIG5ldmVyIHVwZGF0ZWQgaWYgdGhl
IHJ1bnRpbWUgQ1BVSUQNCj4geDg2X3BoeXNfYml0cyBpcyBsb3dlci4NCj4gDQo+IFNldCBpb21l
bV9yZXNvdXJjZS5lbmQgdG8gdGhlIGNvbXBpbGUtdGltZSB2YWx1ZSBleHBsaWNpdGx5Lg0KPiBJ
dCBkb2VzIG5vdCBuZWVkIHRvIGJlIHByZWNpc2UgYXMgdGhpcyBpcyBtb3N0bHkgdG8gZW5zdXJl
DQo+IHRoYXQgaW5zYW5lIHZhbHVlcyBjYW4ndCBiZSByZXNlcnZlZCBpbiAnaW9tZW1fcmVzb3Vy
Y2UnLg0KPiANCj4gTWFrZSBNQVhfUEhZU01FTV9CSVRTIGF2YWlsYWJsZSBvdXRzaWRlIG9mIHNw
YXJzZW1lbQ0KPiBjb25maWd1cmF0aW9ucyBieSByZW1vdmluZyB0aGUgI2lmZGVmIENPTkZJR19T
UEFSU0VNRU0gaW4gdGhlDQo+IGhlYWRlci4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IERhdmUgSGFu
c2VuIDxkYXZlLmhhbnNlbkBsaW51eC5pbnRlbC5jb20+DQo+IC0tLQ0KPiANCj4gIGIvYXJjaC94
ODYvaW5jbHVkZS9hc20vc3BhcnNlbWVtLmggfCAgICAzIC0tLQ0KPiAgYi9hcmNoL3g4Ni9rZXJu
ZWwvc2V0dXAuYyAgICAgICAgICB8ICAgMTAgKysrKysrKysrLQ0KPiAgMiBmaWxlcyBjaGFuZ2Vk
LCA5IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC1wdU4gYXJjaC94
ODYva2VybmVsL3NldHVwLmN+aW9tZW1fcmVzb3VyY2VfZW5kIGFyY2gveDg2L2tlcm5lbC9zZXR1
cC5jDQo+IC0tLSBhL2FyY2gveDg2L2tlcm5lbC9zZXR1cC5jfmlvbWVtX3Jlc291cmNlX2VuZAky
MDI0LTAyLTIyIDEwOjA4OjUxLjA0ODU1NDk0OCAtMDgwMA0KPiArKysgYi9hcmNoL3g4Ni9rZXJu
ZWwvc2V0dXAuYwkyMDI0LTAyLTIyIDEwOjIxOjA0LjQ4NTUzMTQ2NCAtMDgwMA0KPiBAQCAtNTEs
NiArNTEsNyBAQA0KPiAgI2luY2x1ZGUgPGFzbS9wY2ktZGlyZWN0Lmg+DQo+ICAjaW5jbHVkZSA8
YXNtL3Byb20uaD4NCj4gICNpbmNsdWRlIDxhc20vcHJvdG8uaD4NCj4gKyNpbmNsdWRlIDxhc20v
c3BhcnNlbWVtLmg+DQo+ICAjaW5jbHVkZSA8YXNtL3RoZXJtYWwuaD4NCj4gICNpbmNsdWRlIDxh
c20vdW53aW5kLmg+DQo+ICAjaW5jbHVkZSA8YXNtL3ZzeXNjYWxsLmg+DQo+IEBAIC04MTMsNyAr
ODE0LDE0IEBAIHZvaWQgX19pbml0IHNldHVwX2FyY2goY2hhciAqKmNtZGxpbmVfcCkNCj4gIAkg
Ki8NCj4gIAllYXJseV9yZXNlcnZlX21lbW9yeSgpOw0KPiAgDQo+IC0JaW9tZW1fcmVzb3VyY2Uu
ZW5kID0gKDFVTEwgPDwgeDg2X3BoeXNfYml0cygpKSAtIDE7DQo+ICsJLyoNCj4gKwkgKiBUaGlz
IHdhcyB0b28gYmlnIGJlZm9yZS4gIEl0IGVuZGVkIHVwIGdldHRpbmcgTUFYX1BIWVNNRU1fQklU
Uw0KPiArCSAqIGV2ZW4gaWYgLng4Nl9waHlzX2JpdHMgd2FzIGV2ZW50dWFsbHkgbG93ZXJlZCBi
ZWxvdyB0aGF0Lg0KPiArCSAqIEJ1dCB0aGF0IHdhcyBldmlkZW50bHkgaGFybWxlc3MsIHNvIGxl
YXZlIGl0IHRvbyBiaWcsIGJ1dA0KPiArCSAqIHNldCBpdCBleHBsaWNpdGx5IHRvIE1BWF9QSFlT
TUVNX0JJVFMgaW5zdGVhZCBvZiB0YWtpbmcgYQ0KPiArCSAqIHRyaXAgdGhyb3VnaCAueDg2X3Bo
eXNfYml0cy4NCj4gKwkgKi8NCj4gKwlpb21lbV9yZXNvdXJjZS5lbmQgPSAoMVVMTCA8PCBNQVhf
UEhZU01FTV9CSVRTKSAtIDE7DQoNClBhb2xvJ3MgcGF0Y2hzZXQgdG8gbW92ZSBNS1RNRSBrZXlp
ZCBiaXRzIGRldGVjdGlvbiB0byBlYXJseV9jcHVfaW5pdCgpIHdhcw0KbWVyZ2VkIHRvIHRpcDp4
ODYvdXJnZW50LCBzbyBsb29rcyBpdCB3aWxsIGxhbmQgdG8gTGludXMncyB0cmVlIGJlZm9yZSB0
aGlzDQpzZXJpZXM6DQoNCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvZWZmMzRkZjItZmRj
MS00ZWUwLWJiOGQtOTBkYTM4NmI3Y2I2QGludGVsLmNvbS9ULw0KDQpQYXBsbydzIHNlcmllcyBh
Y3R1YWxseSBtb3ZlcyB0aGUgcmVkdWN0aW9uIG9mIHg4Nl9waHlzX2JpdHMgYmVmb3JlIHNldHRp
bmcgdGhlDQppb21lbV9yZXNvdXJjZS5lbmQgaGVyZSwgc28gYWZ0ZXIgcmViYXNpbmcgdGhlIGNo
YW5nZWxvZy9jb21tZW50IHNlZW1zIGRvbid0DQphcHBseSBhbnltb3JlLg0KDQpQZXJoYXBzIHdl
IGNhbiBnZXQgcmlkIG9mIHRoaXMgcGF0Y2ggYW5kIGp1c3Qgc2V0IGlvbWVtX3Jlc291cmNlLmVu
ZCBiYXNlZCBvbg0KeDg2X3BoeXNfYml0cygpPw0KDQo=

