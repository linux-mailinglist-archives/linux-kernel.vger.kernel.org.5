Return-Path: <linux-kernel+bounces-101680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9661087AA6D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 16:31:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F2BE284FA3
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 15:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 896FC47796;
	Wed, 13 Mar 2024 15:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="basaIBH4"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7A43E48C;
	Wed, 13 Mar 2024 15:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710343886; cv=fail; b=tSuAopMQT4L8XQUNoxBpupMX9QKtmFTjHEOqUDsjuUvXglQrvc11ba2Z/VIvwV0a+BSnXl3mpqkRycC/oxgmBB/WpmthUX5Us327k0MmqPfcimS6NMeSQaY3Ef3sqks/tuA/XgWmnJre41503c95kMXfd9mZwPtLGENbIXj5fWI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710343886; c=relaxed/simple;
	bh=BZD3P5nMmNtbQoL66r987S2kS9ENdZekQOoyEMvJ22Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uYRkyKmhlCWgy6t6STj3Z1ykhwcLeTXSZU5w/axYLw98oB4kUoKkXZLS4jrurKkmJs/xrl+NduZk8f1XfeJrcKYm5Lwahu4hGFTQD/IMwCm7WcoYimHBQreiYUXi41yi00sqnftE59XHJZdKP6sDGNqSKlJCfKOtPvqC7Fdg8G0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=basaIBH4; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710343884; x=1741879884;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=BZD3P5nMmNtbQoL66r987S2kS9ENdZekQOoyEMvJ22Y=;
  b=basaIBH4wqG+yTYwnXfooGv9kEaFvSCxf7fVbLOFwOaNAb9TUtQi6JAK
   wyo20kDGtS095ke4HyIlLCbK1nbUUc6KYveljg9YOXfAZaipdf4xgIoUB
   dR3TFm4dP784ORDhnZ8zj+HSq8GfiDfjj1dqqKXjOFT/18AN51+Phga0Q
   UpkqmrWMbp7R0Jdml8c2aIG6QrZ7Ldg1W85o5KDvWOiQMzngxzrxSZMCF
   ZanJI2pEB9QyP/EKZoEbK6V0E9aivf+VvfnvzzNifHLSyMgVuOHXfHMWn
   pWg+IbjVVSpzG0Ec/O6kD8vf5lJVbjgvqbuWoco3LutI5OxsRn5ZY31sw
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11011"; a="16268395"
X-IronPort-AV: E=Sophos;i="6.07,122,1708416000"; 
   d="scan'208";a="16268395"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2024 08:31:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,122,1708416000"; 
   d="scan'208";a="16618357"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Mar 2024 08:31:18 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 13 Mar 2024 08:31:17 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 13 Mar 2024 08:31:17 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 13 Mar 2024 08:31:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lc11onAMDGpGIy/RLiPXnJeNwVVB49Pms0xMI6s41F+EPjA+rAmOGU+3ijtLZ5AZxos6Ph94h04UEJcYh2FYn92JRj1mdA8LnY8r5kSUB/qKzYAb0OsOYy5GTpgyNnSQR/vLUAX5Efey6GzvhXWbR89Ug8Y/5Jc4dSFh4D/vQYLkndVxhTsDcttauNxc2GTcE1xJdBTxK+jgrIswW3Bt1mXYgcmXUexSWmVJhm3AZki+li03UvXtbZy3s1P95f57cBx0XR7C9Nf1jlZb8B+Nc/dzeHh0mY5dVYF8JGbQgxLHXSTOdheoIzgaQid5mWdhSiKZgDQNuGMEIif3RGQ/0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BZD3P5nMmNtbQoL66r987S2kS9ENdZekQOoyEMvJ22Y=;
 b=kWHIodi0edUW+INzUcBW25Z/NpP/gfhJpMQYhlCKGb2nL5DjJEsk2V10FT2kCdXmno+GYCs5hjzZ7ExsNwcv2JW4DEbEV9VJPQqlVXjDAJ2UvYLQnDZ5sjn1ZonCI4/fcDKTJrjlwSbcK2OXWmdoEqzPpkK0PK8MbIWN9vElQzI/ho8UhPS+6gUVy2c739DqrEYTzcdupp3ONVmaApG6aLrmo3Bp0cigfmlOSWOT4FQZYGzGyyji+sQxLI13ZLIW5tFjxULRlmDbDY8pbD0ZD/SSAZIrHZ39r9JG7KH1bc+y+dDToXl35wgyoSo7Y16L/tJRJBUEH28sVGSyO01k+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO6PR11MB5635.namprd11.prod.outlook.com (2603:10b6:5:35f::14)
 by CY8PR11MB7876.namprd11.prod.outlook.com (2603:10b6:930:7d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.20; Wed, 13 Mar
 2024 15:31:14 +0000
Received: from CO6PR11MB5635.namprd11.prod.outlook.com
 ([fe80::d3a0:f70a:9340:9a3e]) by CO6PR11MB5635.namprd11.prod.outlook.com
 ([fe80::d3a0:f70a:9340:9a3e%3]) with mapi id 15.20.7386.017; Wed, 13 Mar 2024
 15:31:14 +0000
From: "Wang, Weilin" <weilin.wang@intel.com>
To: Andi Kleen <ak@linux.intel.com>
CC: Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>, Peter Zijlstra
	<peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Alexander Shishkin
	<alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, "Hunter,
 Adrian" <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>,
	"linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Taylor,
 Perry" <perry.taylor@intel.com>, "Alt, Samantha" <samantha.alt@intel.com>,
	"Biggers, Caleb" <caleb.biggers@intel.com>
Subject: RE: [RFC PATCH v4 2/6] perf stat: Fork and launch perf record when
 perf stat needs to get retire latency value for a metric.
Thread-Topic: [RFC PATCH v4 2/6] perf stat: Fork and launch perf record when
 perf stat needs to get retire latency value for a metric.
Thread-Index: AQHadNf1Lb9qvih3R0e9m3GYI58o8rE0yhJ9gAAEsmCAAAoM2YAA8zyQ
Date: Wed, 13 Mar 2024 15:31:14 +0000
Message-ID: <CO6PR11MB56351D1706A9C46D80982AECEE2A2@CO6PR11MB5635.namprd11.prod.outlook.com>
References: <20240312234921.812685-1-weilin.wang@intel.com>
	<20240312234921.812685-3-weilin.wang@intel.com>
	<87le6nm20o.fsf@linux.intel.com>
	<CO6PR11MB56356A213DBE53535E9D802BEE2A2@CO6PR11MB5635.namprd11.prod.outlook.com>
 <87edcflzkr.fsf@linux.intel.com>
In-Reply-To: <87edcflzkr.fsf@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR11MB5635:EE_|CY8PR11MB7876:EE_
x-ms-office365-filtering-correlation-id: 996f22b6-d296-48c5-080b-08dc43729e98
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kTTTaelCMvGvpJJBOmWRf/ZCSJOdbF6snOfY+JkHffqmMxNAA2Azk2kKROcOkvtFKYSqMs4tjPad+laTvrXPIDZUMP8d/79kciXBC+BXPEx4ajZM29wmq8Nf00xkJxqAGLZIxMLdb7cGo6uxi58fWTg+z+MMsOcNxR2cjCxbh9/EVj6YDuEVVFOCRqiuPRubGldgGWCNC4UhDUAKDYteh15yWoDKOCT+7QUkxKgJfZ915VEk0fVOVU838xkn/qPv+dWgz7NwbpobtTJZT4aekzTVrt3SgLLYGFZJY68hgKFzgiGxIZW7oQeqcjRRl7XwwnMiepSKoOl4ryHa9Ljeox8hFeWYL98xTQASN2Lc55o+dEfet6d4+ZVtj1WodtDuSr9RnjXjNdA3rO1Md3P3geCLwzrL25c03d97wBgrN7j1chgB6tklAM9Vr8yHZitNB+kKWkGHrbFlLmBWrdinu25GBTetYtgFvtoZ2TbLWE76/e2fEeom+f74MCLjMNdPRU+EqwoL5cqlkDIzUIkkxi5CgHC4TDT2SP0TMjyKAfh3ZaaJvTRuzLzHsls0dMBJXZR7fvnW7uYwtwHM3skVNSIHcIdRPRKEoqwpjNAHHVg9WigxpxNiuiG1FyASMiAyswRrnZyeuXADzDxO89YnU90CtbHojIO2IDKkGvvzki+LK7kyF50Bkv4WPihFKkUgsPw5wj2jzy/GnzEony+f5YcH7dzNHRFVfc4w+qPjj60=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5635.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?slnxQbUo2m+B8pLCkh1Qwm7AOCLlZRUoWhiQOwVDa3MU39p1lEDVOTXVxgVs?=
 =?us-ascii?Q?0kBRvP0QPIUTDo4DRSa9H3jRLDkmel8pmWT8zxooKWWwZV6B4zs52JI6qDAp?=
 =?us-ascii?Q?zVyFIAMkBp6ZQn946dMmYRoXZJMuIgx74PwoZRlZDafsO2AETEC6a6Y97SsT?=
 =?us-ascii?Q?nqRqqNUN3JoM7AWLX+mdEQfxVndHfoUax9t3V07ZHsRAy8eLMGC8OnXthR/a?=
 =?us-ascii?Q?7sJ6zEKH57mydp2otn5znHNFClniLPDqTSKpD97Ca7qArnItv63uGj3VhBpJ?=
 =?us-ascii?Q?w5M71Ypu1sTM/BXz9fKZu3aMaZwueTZOxAFc2eouwGRhgN1EAnZiEFCb+fNO?=
 =?us-ascii?Q?yX/p45q4HZjJn88VnYE87wX7bS1PEdS76nC7+UWNUq2m8ltXz0HaqS4rBSVB?=
 =?us-ascii?Q?r1B0Cm1qSmxogsD6gZyUPtMdKUX3PZzbnQJ5RUWI2so95ZrJ/5ciS7M1HXo6?=
 =?us-ascii?Q?1BIWvVyQqjtyQhfDUMxIY+uyQBYOCHoHb/1wSr9Xo+BrbY1+NEeLSjHmsRxv?=
 =?us-ascii?Q?O71Cv7axdpjysRBQDd3Qppgrwa0zm9k+uwrkMXLTevwh5YpueX5P/mElqbHJ?=
 =?us-ascii?Q?6OGVCsNgJF8BRwtFR0IvdAUycG748x8UxouSCQgmi0yc0ByW9Re2G3Y4Ikw+?=
 =?us-ascii?Q?+Oqd0Ij9g0ufzxWriRj9EGPv40+4dt4Cy5pq9Z2/mrYUs7v1EKgMcLMGDZ0f?=
 =?us-ascii?Q?Ex3Xll+Pw8j+xBBMv0eYnu7yaSVsvmkGgE9mBnMIY5GMUO0DNHBsoOZ1WnUo?=
 =?us-ascii?Q?A6wxuSthf0tlrGxjViV5C3Kb2C1d/hP/TpxLSO8unph2/lQMUp3CTi4stdty?=
 =?us-ascii?Q?oK8sc0qPiBAiSX1MmxMfzmhQGs5WaWkKLfwDlGb2hs14kmVHX+GANJ9W3/F7?=
 =?us-ascii?Q?w7CuOeCqNwgR9AwfAyOdII2tSXPAQK50oWcC5f+9PQgW1TbpUBdxiNO2GZg4?=
 =?us-ascii?Q?Fpcq0GoXSo9pyTUGvmJrn59xf3rPiL2mIMsBHTvYtyd3rtkpbL2a30NjpV9x?=
 =?us-ascii?Q?K2fjndSMOco/ByMAUIS+ZyZrIk61qzxQZKY3Qm6EVc9K1DuSdEoOfVxQvAcF?=
 =?us-ascii?Q?3KsW2dcMUCz5LGOUrZL3XucZav40Ej6YSgRzI/V07DPqaRYs9R70KpDmucZo?=
 =?us-ascii?Q?Uf5rEHHtuRE/AjBmwSFqgLrqEYoK46ej3qoFi1HoAN/eCuWiCq+lCYbnC6O4?=
 =?us-ascii?Q?LOVWoGLzQahaIeNE2cj/ukgq4pNmEqT+3PHcTxLT5HkV1UrBujlCKrwJqEXG?=
 =?us-ascii?Q?HMUGVk8Vcv4wgZFz0KAanWf0CgfrDUNikZbN9DvNULaphdq7MMfidsFB8tfk?=
 =?us-ascii?Q?B6fcpJibinTo7FnWozQwWSBqD74XCV53ig1E/PejG+LFMZ6vxush9AGZYt1O?=
 =?us-ascii?Q?YPpIiUMJ/q1cDrR3U7wMbI6R16rCxn2aoCVAcS3yNwu7fDygu52Tg9QEURoX?=
 =?us-ascii?Q?DsoQhQ67SDhLdI6sOfhno/1fQCzjRo/dPg91WflJ7sStodhaiGiyyU1xR2d8?=
 =?us-ascii?Q?lVLQUESEQD+esArnUH1DjUAG5mi8AquDlra1Yd1gxv5ITF1r4w3ECnirfqSy?=
 =?us-ascii?Q?nftukh3K+a0qdzvwjLUmy2M1uoiztqjQyNgvlVz3?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5635.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 996f22b6-d296-48c5-080b-08dc43729e98
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2024 15:31:14.5716
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QAh6wgrHgoObUojPBogMN9sntoJEPh4J0pGtw6OyE4QytcI3mWpFJJYufmdajzkrBDZf4hZ2emGu/Mqv+r/NiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7876
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Andi Kleen <ak@linux.intel.com>
> Sent: Tuesday, March 12, 2024 5:56 PM
> To: Wang, Weilin <weilin.wang@intel.com>
> Cc: Namhyung Kim <namhyung@kernel.org>; Ian Rogers
> <irogers@google.com>; Arnaldo Carvalho de Melo <acme@kernel.org>; Peter
> Zijlstra <peterz@infradead.org>; Ingo Molnar <mingo@redhat.com>;
> Alexander Shishkin <alexander.shishkin@linux.intel.com>; Jiri Olsa
> <jolsa@kernel.org>; Hunter, Adrian <adrian.hunter@intel.com>; Kan Liang
> <kan.liang@linux.intel.com>; linux-perf-users@vger.kernel.org; linux-
> kernel@vger.kernel.org; Taylor, Perry <perry.taylor@intel.com>; Alt, Sama=
ntha
> <samantha.alt@intel.com>; Biggers, Caleb <caleb.biggers@intel.com>
> Subject: Re: [RFC PATCH v4 2/6] perf stat: Fork and launch perf record wh=
en
> perf stat needs to get retire latency value for a metric.
>=20
> "Wang, Weilin" <weilin.wang@intel.com> writes:
>=20
> >> -----Original Message-----
> >> From: Andi Kleen <ak@linux.intel.com>
> >> Sent: Tuesday, March 12, 2024 5:03 PM
> >> To: Wang, Weilin <weilin.wang@intel.com>
> >> Cc: Namhyung Kim <namhyung@kernel.org>; Ian Rogers
> >> <irogers@google.com>; Arnaldo Carvalho de Melo <acme@kernel.org>;
> Peter
> >> Zijlstra <peterz@infradead.org>; Ingo Molnar <mingo@redhat.com>;
> >> Alexander Shishkin <alexander.shishkin@linux.intel.com>; Jiri Olsa
> >> <jolsa@kernel.org>; Hunter, Adrian <adrian.hunter@intel.com>; Kan Lian=
g
> >> <kan.liang@linux.intel.com>; linux-perf-users@vger.kernel.org; linux-
> >> kernel@vger.kernel.org; Taylor, Perry <perry.taylor@intel.com>; Alt,
> Samantha
> >> <samantha.alt@intel.com>; Biggers, Caleb <caleb.biggers@intel.com>
> >> Subject: Re: [RFC PATCH v4 2/6] perf stat: Fork and launch perf record
> when
> >> perf stat needs to get retire latency value for a metric.
> >>
> >> weilin.wang@intel.com writes:
> >>
> >> > From: Weilin Wang <weilin.wang@intel.com>
> >> >
> >> > When retire_latency value is used in a metric formula, perf stat wou=
ld fork
> a
> >> > perf record process with "-e" and "-W" options. Perf record will col=
lect
> >> > required retire_latency values in parallel while perf stat is collec=
ting
> >> > counting values.
> >>
> >> How does that work when the workload is specified on the command line?
> >> The workload would run twice? That is very inefficient and may not
> >> work if it's a large workload.
> >>
> >> The perf tool infrastructure is imho not up to the task of such
> >> parallel collection.
> >>
> >> Also it won't work for very long collections because you will get a
> >> very large perf.data. Better to use a pipeline.
> >>
> >> I think it would be better if you made it a separate operation that ca=
n
> >> generate a file that is then consumed by perf stat. This is also more =
efficient
> >> because often the calibration is only needed once. And it's all under
> >> user control so no nasty surprises.
> >>
> >
> > Workload runs only once with perf stat. Perf record is forked by perf s=
tat and
> run
> > in parallel with perf stat. Perf stat will send perf record a signal to=
 terminate
> after
> > perf stat stops collecting count value.
>=20
> I don't understand how the perf record filters on the workload created by
> the perf stat. At a minimum you would need -p to connect to the pid
> of the parent, but IIRC -p doesnt follow children, so if it forked
> it wouldn't work.
>=20
> I think your approach may only work with -a, but perhaps I'm missing
> something (-a is often not usable due to restrictions)
>=20
> Also if perf stat runs in interval mode and you only get the data
> at the end how would that work?
>=20
> iirc i wrestled with all these questions for toplev (which has a
> similar feature) and in the end i concluded doing it automatically
> has far too many problems.
>=20

Yes, you are completely right that there are limitation that we can only su=
pport -a, -C=20
and not support on -I now. I'm wondering if we could support "-I" in next s=
tep by=20
processing sampled data on the go.

Thanks,
Weilin

> -Andi

