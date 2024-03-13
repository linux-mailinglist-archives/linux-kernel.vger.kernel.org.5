Return-Path: <linux-kernel+bounces-101723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFA6A87AB04
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:24:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E9451C21CED
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 16:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94D29482EB;
	Wed, 13 Mar 2024 16:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WUU0FUqc"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE06482C6;
	Wed, 13 Mar 2024 16:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710347036; cv=fail; b=FL+I7ocUNc12N+yAw73DVt6VDK7fXj7Bc+ez9O+nlVg5OWbKBagPyQnpmGRYm2ZJxeVftoWvAPv10sK+EkG909MtEbwKImMrn14niD8HQm/v30xzu61Wpzrk9pxCBz5yptH2W5i776OcfNVdMB1/3oavHH+86VEh0qd/nCZ/HHs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710347036; c=relaxed/simple;
	bh=vuY44qsi6Mlkt3u83FIIwtLl5eUYRd/VVtbiu1BUkJI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IjwiXRTSeMeFS3Haqsiiys22Er5xOovk5EKQxF0VkR+crZ/BaCTgFRnxkLZEZ78wxbUBGwiRB39r/5OaOlAfslBA2/KiSn8gftvfZDy3oEIF/NeH831mDTrve8vX+rj9hX/8rgOJyy71gzu2TmvpebdKCtm2jPnSWvNgMrKlFJo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WUU0FUqc; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710347034; x=1741883034;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=vuY44qsi6Mlkt3u83FIIwtLl5eUYRd/VVtbiu1BUkJI=;
  b=WUU0FUqcYhR18SNOP8X6EQpwqL3bOXdxJKxvvVfVLvQZchdO9qhD3MgB
   KR2EPC0tBpwOklgviB3k1rMROWf0d8eIBUuu2JbsumMdfxNFDxVwr2CGJ
   vyK2BrrpGnLnnr0Msk20RmK1g921r4NLWi5Qu9YEBqH9pfvAyJetrSlcP
   Lteg5qdIyXLyTk50pA26mpeV1WcKU05M9Wv6XvwNdx23Zn6j94jH+uQWU
   IXV3dno/8sZuu2quMt/kctbrci8jBgo89Bb4qMHXg1mz7UbU8hqbtycjs
   SfZB3eh7QT9+8W7BnDkPvqbWAr89nFM20Zqdb4SHqSOxR1UL+ikJj/u8t
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11012"; a="22640186"
X-IronPort-AV: E=Sophos;i="6.07,123,1708416000"; 
   d="scan'208";a="22640186"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2024 09:23:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,123,1708416000"; 
   d="scan'208";a="42987170"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Mar 2024 09:23:52 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 13 Mar 2024 09:23:52 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 13 Mar 2024 09:23:51 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 13 Mar 2024 09:23:51 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 13 Mar 2024 09:23:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fsTW7FbcksEKIGu1Y+7X3P6pXhGrgJKUrgSKyoip7zIj7bMSPnnROm0qxtvW30tLX5nTNhzv11ODQYadB/luNk9SXPaCm4iv5Et+9xAsXk15atR8eJqszmsQ4J5BRY0hwJ5xUFo3ILCBbRQam9t4K9hDU06lgWJ5Yx3Jm5MHf6v56gK83M4BgZbW8xKxQKuYByh0VIDx2CxMfij4IXO7EWyIPWY7xcLB5pOZXM0lqq6lXzY3EF/Jmi4u9VYxWgx1T+rhowsAk/r4BarO7DNqR9rb8ifeZYV0cijuz9c2jj576yjC8deIxyu5yQi1gugFX9GILDDZSmM3aOtbW8H8hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vuY44qsi6Mlkt3u83FIIwtLl5eUYRd/VVtbiu1BUkJI=;
 b=W4gb+dIi58A5RAvhBA+LUSCP4aeYsyy26dcuWRS7JzAWSI+NItDGgsPIrxyxRvrhyOaJt7/WfgIXTSOfRwjxI3qLdkxsa6tAVvd18wVXGhPd7CQ+b7zKOZJ1JizjJ+kpQvedsUF3Z+7dGgQmjn4D/wkeE92T/SV6ZQdV+367jQl/CeSkbMAjgbdxnbiuo0eGR6vB3z6gLF2xMC6Z6EOq1frBTYa9GqnhDD3nJ7agIyLqVMYK5G3X7aRX1e5C+avBPgVYdOnmMhxZQSg0HSujx0ic8gN8mz03mwncYKYT30YdZ2DvIya4tN6EbeVX+ZanVcX9B2DPaDYBgtfyMH91hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO6PR11MB5635.namprd11.prod.outlook.com (2603:10b6:5:35f::14)
 by SJ0PR11MB8293.namprd11.prod.outlook.com (2603:10b6:a03:44f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.15; Wed, 13 Mar
 2024 16:23:48 +0000
Received: from CO6PR11MB5635.namprd11.prod.outlook.com
 ([fe80::d3a0:f70a:9340:9a3e]) by CO6PR11MB5635.namprd11.prod.outlook.com
 ([fe80::d3a0:f70a:9340:9a3e%3]) with mapi id 15.20.7386.017; Wed, 13 Mar 2024
 16:23:48 +0000
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
Thread-Index: AQHadNf1Lb9qvih3R0e9m3GYI58o8rE0yhJ9gAAEsmCAAAoM2YAA8zyQgAAH7QCAAAWU4A==
Date: Wed, 13 Mar 2024 16:23:48 +0000
Message-ID: <CO6PR11MB5635D2EAC53C2CD2B36D4BF5EE2A2@CO6PR11MB5635.namprd11.prod.outlook.com>
References: <20240312234921.812685-1-weilin.wang@intel.com>
 <20240312234921.812685-3-weilin.wang@intel.com>
 <87le6nm20o.fsf@linux.intel.com>
 <CO6PR11MB56356A213DBE53535E9D802BEE2A2@CO6PR11MB5635.namprd11.prod.outlook.com>
 <87edcflzkr.fsf@linux.intel.com>
 <CO6PR11MB56351D1706A9C46D80982AECEE2A2@CO6PR11MB5635.namprd11.prod.outlook.com>
 <ZfHMYM3iWlsODtjP@tassilo>
In-Reply-To: <ZfHMYM3iWlsODtjP@tassilo>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR11MB5635:EE_|SJ0PR11MB8293:EE_
x-ms-office365-filtering-correlation-id: b7d71593-8171-471c-6898-08dc4379f67c
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Fv56yYV0+YQVRDqvvwwRFU4qCMU7vb27vHyZMFB06/gLeEo+dTNFdyvmaeEpZNUH5sLS7p53+AhBBokiDPpQKHu3pDLmANJYBmWqIMtk1SJPQUgBoS8agiprGp3+TLpUkl80T1jyRY7GdR//D185jA6X+5Pq0UPbLzEMZrT34U510SP+U35WpZoRl6ZAQEmfuTIS1AqV3l0DWsSIas8gEOt06oHdSdKnuHRiNEauik/FOcJ1Y/ju+9+7CZHznBSGgOWPNwBxmGVrN7FS6d1h+ClNJf4OEMFEkwhTzDZwZLJMyCHRQaR0cr+DOt6bzrqGGX9b1SJUxcq4GLKuCymcrwy+C6iptYb+z1n3zA+FxV85E6OREg2uAMK4t55Exq57Paq5LTrKNsb2M7P9xD7pcOKsfE9mZBLhFPvewQQkCNzArkIxHtncXeslC9LqJH2WAei8ZfT33W0iU54qLyzUv5ml7yVEo61ULz7dZFKEhxTc0wkGhmUlxI+3CAmSwX/74d56aiyQ5ogn4O1Tv6+DgM+uFMUSwXsXW0efzuOsJtNDdTWb4l9t4JPD2MIKmZz3rLqt2PHTEob0tCro1WGdYzdTGXd2aJUamJ52Vpgdqh12UoS1nwoQpnamafI1GXrD47bJ8I5kMOk5QebR1wORN3iyG6HX+4+A8L8rtq4EyqNC7VZSJj6mN6xg6+EZTMxP
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5635.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?AnHcvA4VZz/cA6H2QlRRq1Hj3JfimNvzcJRazG0npo3Ext0Uxg3cqQI3ey5m?=
 =?us-ascii?Q?SWZLpfjTsfXz01nZnJsBh4iIzSPUNcocKIH7RiGbjdJwW87rGum3jPXQKF87?=
 =?us-ascii?Q?OoKLuozJSxlqCiFmecJ1R68IndeBZko8sc77I4vheG0KFLkZ75CBjfCCspvP?=
 =?us-ascii?Q?iDRllWzwqwNbsGGGLOTthyYIjlyVONUKMPwPUnZNZ7APIgqHMk78hpq7OzB3?=
 =?us-ascii?Q?gP6sumrrpKTWYhdBOeM4wgLGtm2s4v3uAvxYfaOKoiO84Er+CN5oD3hlY7+/?=
 =?us-ascii?Q?W7Y2RhmyAIxJ9438xCDf/Y7b6RKKppwXoQHz0YBGWpeLRTQmNXmHvc6+Xo+3?=
 =?us-ascii?Q?0vYLqeL0ePejKEnt8Admhmyd78U57Is+8U+XjeipkrXMeQgzgNhrIRsNXDWK?=
 =?us-ascii?Q?VdWZcTvHHAJ28+6GTsaEopJrYPNmMU481O7wQXl2rMJfa3LBlLT7hLjx0VSs?=
 =?us-ascii?Q?djo1fiQUucADz7coORZFBxRjaPFwbNR0wC4tLTrLmSiel/p/0cdbkSzAF7YJ?=
 =?us-ascii?Q?ETKxoqSJY04uV0PsNKgvGnvk/6/inh+eTkUM65cDbNCQlkumhbCd48l2mQoJ?=
 =?us-ascii?Q?xLvt0KqVYKXX31gdqK4Hjhy67wmJQCVidPZQFjbEF1MopbrVuDmoeVv+aLS5?=
 =?us-ascii?Q?oShzfIVRBPC0KUDQo92afwEih4F+V4kbrDU1WgqCxyunTe04SxowycekGV9/?=
 =?us-ascii?Q?1Zkgy97HH8VVsAYjVOp4qhxA+w71JanWaGn3b8X2NcJCbuodO5stJuP1jwEg?=
 =?us-ascii?Q?946gHX+nlRjii5oBXaXVrZsn3Bz+H3prveB8T9g2xcadAtvkxTEWNs0mZwzB?=
 =?us-ascii?Q?AKkPTrpGdMZ0UKCLdv6YW/i3g+l5awKVoucXLuk0Szi0Z8xPwqTX91lHmJLP?=
 =?us-ascii?Q?0xbT8kbOloESoJXv8Vf0d9WS0xgAlljJfs9PIi6+gYHpByiKSe/zy57dTdVK?=
 =?us-ascii?Q?ePcwWRdIAuu+a4wGiyRx3S9pBTDl5yIwdRKGYksUsDPsidsH/O7yQiMo/OYp?=
 =?us-ascii?Q?e86EaDuwz9+YGazAjgu4O7+mM2SlGpBsLIUBND8wGjaPaNGKLVvLJoRtH3V0?=
 =?us-ascii?Q?lFNPgs7YFVSXv1Y6mDa1GfNIQHSpysSTAET8m2W1AnG5No6vRsE0xB0nc0U1?=
 =?us-ascii?Q?uQecnfxwQiFcFaGhn+iytPQbvg2w86alKTyI/vhs7bxZ1jw+ZE/TIK6thLCY?=
 =?us-ascii?Q?BR3dVJYI5J/X20a0S65EqJ3JHmVMV8eoLDiPBJjd1yRxKuSLJ3z8RrLqi0aQ?=
 =?us-ascii?Q?xlsI1fdw0520lvWOeh2AjSBmbqqsucXTw4roAAREJflgg2myTfPl4w0bkeEp?=
 =?us-ascii?Q?08Mae1OiHQpQ/fFk+pZS+Qr0jjpKko9RzHZlhMR8cg6xJeFJmVOX8QyHqWtO?=
 =?us-ascii?Q?3AJpiaj6HDVvCGPR16vTTBPq0FztafFZnsfzhy7e2psP/GQ+zc/Bal9e01li?=
 =?us-ascii?Q?TrUr38ESEyqzaJvi1KuHRk8r/gy+v8M6Cc6KkYjFARg7zlgPMgBg9uaRlX99?=
 =?us-ascii?Q?rV4xY8zA126AxhWdEwO1tDRgCVlE/WXCTCU9oZ/OE5jBPw8UjbEZ53ktZ7q8?=
 =?us-ascii?Q?ADP2kJBaU0VNxKaI+KcWxiHbQiu6Ltr51xCZvYPS?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b7d71593-8171-471c-6898-08dc4379f67c
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2024 16:23:48.5128
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Zd8sVdymBgQzB4lRYZ+tV3hCv0LHNj0Cb+Ldg5wm31yXCt6MsFubWw+ahKQDxff+fIrP4U7mOXECpHRoyIN82w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB8293
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Andi Kleen <ak@linux.intel.com>
> Sent: Wednesday, March 13, 2024 8:55 AM
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
> On Wed, Mar 13, 2024 at 03:31:14PM +0000, Wang, Weilin wrote:
> >
> >
> > > -----Original Message-----
> > > From: Andi Kleen <ak@linux.intel.com>
> > > Sent: Tuesday, March 12, 2024 5:56 PM
> > > To: Wang, Weilin <weilin.wang@intel.com>
> > > Cc: Namhyung Kim <namhyung@kernel.org>; Ian Rogers
> > > <irogers@google.com>; Arnaldo Carvalho de Melo <acme@kernel.org>;
> Peter
> > > Zijlstra <peterz@infradead.org>; Ingo Molnar <mingo@redhat.com>;
> > > Alexander Shishkin <alexander.shishkin@linux.intel.com>; Jiri Olsa
> > > <jolsa@kernel.org>; Hunter, Adrian <adrian.hunter@intel.com>; Kan Lia=
ng
> > > <kan.liang@linux.intel.com>; linux-perf-users@vger.kernel.org; linux-
> > > kernel@vger.kernel.org; Taylor, Perry <perry.taylor@intel.com>; Alt,
> Samantha
> > > <samantha.alt@intel.com>; Biggers, Caleb <caleb.biggers@intel.com>
> > > Subject: Re: [RFC PATCH v4 2/6] perf stat: Fork and launch perf recor=
d
> when
> > > perf stat needs to get retire latency value for a metric.
> > >
> > > "Wang, Weilin" <weilin.wang@intel.com> writes:
> > >
> > > >> -----Original Message-----
> > > >> From: Andi Kleen <ak@linux.intel.com>
> > > >> Sent: Tuesday, March 12, 2024 5:03 PM
> > > >> To: Wang, Weilin <weilin.wang@intel.com>
> > > >> Cc: Namhyung Kim <namhyung@kernel.org>; Ian Rogers
> > > >> <irogers@google.com>; Arnaldo Carvalho de Melo <acme@kernel.org>;
> > > Peter
> > > >> Zijlstra <peterz@infradead.org>; Ingo Molnar <mingo@redhat.com>;
> > > >> Alexander Shishkin <alexander.shishkin@linux.intel.com>; Jiri Olsa
> > > >> <jolsa@kernel.org>; Hunter, Adrian <adrian.hunter@intel.com>; Kan
> Liang
> > > >> <kan.liang@linux.intel.com>; linux-perf-users@vger.kernel.org; lin=
ux-
> > > >> kernel@vger.kernel.org; Taylor, Perry <perry.taylor@intel.com>; Al=
t,
> > > Samantha
> > > >> <samantha.alt@intel.com>; Biggers, Caleb <caleb.biggers@intel.com>
> > > >> Subject: Re: [RFC PATCH v4 2/6] perf stat: Fork and launch perf re=
cord
> > > when
> > > >> perf stat needs to get retire latency value for a metric.
> > > >>
> > > >> weilin.wang@intel.com writes:
> > > >>
> > > >> > From: Weilin Wang <weilin.wang@intel.com>
> > > >> >
> > > >> > When retire_latency value is used in a metric formula, perf stat=
 would
> fork
> > > a
> > > >> > perf record process with "-e" and "-W" options. Perf record will=
 collect
> > > >> > required retire_latency values in parallel while perf stat is co=
llecting
> > > >> > counting values.
> > > >>
> > > >> How does that work when the workload is specified on the command
> line?
> > > >> The workload would run twice? That is very inefficient and may not
> > > >> work if it's a large workload.
> > > >>
> > > >> The perf tool infrastructure is imho not up to the task of such
> > > >> parallel collection.
> > > >>
> > > >> Also it won't work for very long collections because you will get =
a
> > > >> very large perf.data. Better to use a pipeline.
> > > >>
> > > >> I think it would be better if you made it a separate operation tha=
t can
> > > >> generate a file that is then consumed by perf stat. This is also m=
ore
> efficient
> > > >> because often the calibration is only needed once. And it's all un=
der
> > > >> user control so no nasty surprises.
> > > >>
> > > >
> > > > Workload runs only once with perf stat. Perf record is forked by pe=
rf stat
> and
> > > run
> > > > in parallel with perf stat. Perf stat will send perf record a signa=
l to
> terminate
> > > after
> > > > perf stat stops collecting count value.
> > >
> > > I don't understand how the perf record filters on the workload create=
d by
> > > the perf stat. At a minimum you would need -p to connect to the pid
> > > of the parent, but IIRC -p doesnt follow children, so if it forked
> > > it wouldn't work.
> > >
> > > I think your approach may only work with -a, but perhaps I'm missing
> > > something (-a is often not usable due to restrictions)
> > >
> > > Also if perf stat runs in interval mode and you only get the data
> > > at the end how would that work?
> > >
> > > iirc i wrestled with all these questions for toplev (which has a
> > > similar feature) and in the end i concluded doing it automatically
> > > has far too many problems.
> > >
> >
> > Yes, you are completely right that there are limitation that we can onl=
y
> support -a, -C
> > and not support on -I now. I'm wondering if we could support "-I" in ne=
xt
> step by
> > processing sampled data on the go.
>=20
> -I is very tricky in a separate process. How do you align the two
> intervals on a long runs without drift. I don't know of a reliable
> way to do it in the general case only using time.
>=20
> Also just the non support for forking workloads without -a is fatal imho.=
 That's
> likely one of the most common cases.
>=20

We could use -a -C and cgroup together. I think this could be a useful use =
case.
There could be other improvement to the implementation in next step. But I =
believe
current implementation could provide users the access to our new feature wi=
th=20
accurate results and without adding too much overhead.=20

Thanks,
Weilin

> Separate is a far better model imho:
>=20
> - It is under full user control and no surprises
> - No uncontrolled multiplexing
> - Often it is fine to measure once and cache the data
>=20
> It cannot deal with -I properly either (short of some form of
> phase detection), but at least it doesn't give false promises
> to that effect.
>=20
> The way to do it is to have defaults in a json file
> and the user can override them with a calibration step.
> There is a JSON format that is used by some other tools.
>=20
> This is my implementation:
> https://github.com/andikleen/pmu-tools/blob/master/genretlat.py
> https://github.com/andikleen/pmu-
> tools/blob/89861055b53e57ba0b7c6348745b2fbe6615c068/toplev.py#L10
> 31
>=20
>=20
> -Andi


