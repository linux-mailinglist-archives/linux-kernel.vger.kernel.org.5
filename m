Return-Path: <linux-kernel+bounces-100962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A92687A023
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 01:26:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D85C41F22963
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 00:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32B5A625;
	Wed, 13 Mar 2024 00:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b2bVKJHo"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2733E182;
	Wed, 13 Mar 2024 00:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710289600; cv=fail; b=S6JA1968KTbO7ZdUj1RUyMDqrJ0ugCmvxl8kM2JCU5psQ82+99iOYOGSnzWR3ZO02BfZqKRwO9vV797HX3fp68bK9IWvpQoB0hpRsJe9GiOTRVy0/56YAFH5XCuf3MzxLxHV8qSiD6iqd8DV+Yhb+6C+j0CRwrY/p3bbD92VJio=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710289600; c=relaxed/simple;
	bh=ikyc4VZ952nWhvTJRYDM/uVndXYDtCQXnyuy6iLqbKE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jYb6OIYoX/w3np2/65KOP33Yo5DsLuheEkuMsxldMH87xgFMvG0oJ7Vd13wsTYQFZkeqWY1MF4I/IXduSiu2/XYJad2f/Cm5YH0Bp7rCoKZ8BAxqoxicmKTRPLukTkTMX1ncEpuIy0z20eHXk6l3T2O2mFpT6lAb5n1C3Ibd260=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b2bVKJHo; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710289598; x=1741825598;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ikyc4VZ952nWhvTJRYDM/uVndXYDtCQXnyuy6iLqbKE=;
  b=b2bVKJHoJKnBfsdTEOpsTaNCXHcjRS9qv6pDCzY0K2J3kdOJr2M1C8yU
   UFWbDZ51dNGMbO0AuKIToBTTw73ugmHVa5iObIj822dED+2TCC8zu/M46
   Xr9HgGpr7pXFpHRH0ezmbYCAJG8XBzqACrrbZSmv1eIOgXlWKR1hSn8JA
   53saaMYjCdUEhJwXtgOPLptHjwmRawvVDX2VXoYAXjJKc6Ten/AYjxK43
   FQ5laBkwra89gnZoWJyTIM3dzHWqfN4tmciR4LxyfJjyxCwxEeG9N7Pkv
   5WpI8CHTMBCcII1aqusVZnEt0L4OXidCMdoCbAusDftww9ynW+vuYxRO7
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11011"; a="5639127"
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="5639127"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2024 17:26:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="12309837"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Mar 2024 17:26:36 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 12 Mar 2024 17:26:36 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 12 Mar 2024 17:26:36 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 12 Mar 2024 17:26:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hhjYpUDJjDHpujfaRV5jww+F4+n/6sL/SpVq5JlYN27K9QV6ELjdRUWBFbgnYIIpoBrcUwAjCFeKiNEPEp7WEh9D2pywNsrZof9IgGRDOGV2lbfch19R5XkcLLk3dL8vYVbYiayb3KhoQmITzMABuutPt7HeA13fEcUNWaTBjZdkLGjwN6hyP8q/dKs0pvRMBCfA3VcwQUVg85RRYRVHkjdZVw/TiRSRvC5uY1Uu7Y0QD1kMDpf3p0QcSwc1/Jk76RCPILI231dx4Qt/ETpM045r6+0dvKKlBBz75G7gc7yKmrol7gEnXNhfwLcyavtgH6oCFkbOCAaFMlZVlkOq1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ikyc4VZ952nWhvTJRYDM/uVndXYDtCQXnyuy6iLqbKE=;
 b=luuH11DNFzYYQGUgYEulbHJ59QcMtjEsrSKKMt3P5Dfzkms8omlysXkdux2QXU+dfVx7foEnFU+rir9MbMCr01dq1o6mYyjkMKCAtENyb4kkLCTOdCo5QzK4mq6CKDwd4cDLKZ2VbvzV3GuQBAyoHC+JYGtJayG+8enoEW3TlDpPnBYwq2VIG+f3xUtYMIANTUYEnaKC3DQWeGVqCLlrsXNp4ifbLkDVVtjw20LFvyCmHjpb4/rcNHvD+ApbpK9TiOrKVTQD4Q0XQCMtuWFyELR3sKuvBZyo7bX7AaFZ0+j5POhWNI4tsDbyz/uWxahoTUh8vuZGgBemDEZBRLojBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO6PR11MB5635.namprd11.prod.outlook.com (2603:10b6:5:35f::14)
 by CYXPR11MB8755.namprd11.prod.outlook.com (2603:10b6:930:e3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.16; Wed, 13 Mar
 2024 00:26:30 +0000
Received: from CO6PR11MB5635.namprd11.prod.outlook.com
 ([fe80::d3a0:f70a:9340:9a3e]) by CO6PR11MB5635.namprd11.prod.outlook.com
 ([fe80::d3a0:f70a:9340:9a3e%3]) with mapi id 15.20.7386.017; Wed, 13 Mar 2024
 00:26:26 +0000
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
Thread-Index: AQHadNf1Lb9qvih3R0e9m3GYI58o8rE0yhJ9gAAEsmA=
Date: Wed, 13 Mar 2024 00:26:26 +0000
Message-ID: <CO6PR11MB56356A213DBE53535E9D802BEE2A2@CO6PR11MB5635.namprd11.prod.outlook.com>
References: <20240312234921.812685-1-weilin.wang@intel.com>
	<20240312234921.812685-3-weilin.wang@intel.com>
 <87le6nm20o.fsf@linux.intel.com>
In-Reply-To: <87le6nm20o.fsf@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR11MB5635:EE_|CYXPR11MB8755:EE_
x-ms-office365-filtering-correlation-id: f483f68e-a771-41d7-fc18-08dc42f43826
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /uA21PNVG4HArwSWs5jy25h2FVSu9Iyc9egPyCcGJUXVUXuoc3hHsxhqG0iqiyg3Ku5lp+Oz7zqtKcTdZBU6sFQsklZ4x6GJZL6DqLwKSYQNxy1uh5a84rYSJOR/3a1cUIRQpr8PvfymdAdx199dRN7fMiuKBmmQi+IO1Gi9Mk0dr4xTEb9Lpzmb93n4LqNkdzoUGQ73bZqnvira/lWfwtPTVxSxYg3E/rXmCvuFGp7pMRfXLZO6M/eGZySM2SRV/TMexDmn+jcoJ3sMUhaw26jP5BfdKVXxoAxf5rek78VtxwSiG+1P0omqCpfSOOu2/FRg/f0nuysMfIZ6xC6BHXjl8RZtO3X4u4bhriFTF9gNNv1SNI76PPLx0v9jF6FEsNCL0M5WiEF+GfcwIAzqZZs0QnjruJkXP/tc3DIp4Ib2xFT1b8UsyvKqs3I3OHIPKt2wzIVs6n0dfLjYkH5pQutKPyrxX3ZLaVsdEHZKl1Eks6mnvLpmjHNgazQ3KSD5MiewMq0HhWaCmtEBAobpJyFjZVDUjKr5uQN3vOxk8pOZ5FoBQUryAWvdHoNrfrPiQ/YhDJm1wQcfgMAdvFtLNo/MxhdZ2HmN1bMYpp3S3jBZb/cjWAn8sUhkf39g7MmADIN5OjUJ4iEk0eqBQVdsb87jLcVSj2qoyUofkBks9XJREe0rJrlkofbQJss+81G7i9wHX5P7XgJ4bDTHcoaASYC/cC9A3ka86Q5QLC5b3OM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5635.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9U4phJpFoUimZvn/ox5iCsWts5grEkHEq/2/ujaPpEmUYnmd1sAEHxoFi9WV?=
 =?us-ascii?Q?YJs2RS0vXoTCvfXv3z4YUYQNP+ux29RLyzhN25lvEJae0cheurBcKk/7i7ZC?=
 =?us-ascii?Q?9XrCaHDsz6HKKm0QJJp2eNSRS1Ws6yBrGV8yJoCRcMjJm2DNlKISH2LQWErn?=
 =?us-ascii?Q?USlLUAV9dEuuv9Cvr/rb1vvBSnD0RHhU5IycRhoYCnLulj4D2ftvWsesk4df?=
 =?us-ascii?Q?ktmllejavm5GqBMqUYT81210KbX3H0rZI3Mye0BWf4aP2QwDrjHyhde9u0j1?=
 =?us-ascii?Q?X+h9EzPCzIip8pkVh+6QUZwbZCdmKhhkL+1dKN8+BlnV32oPP5yprb4uRc0m?=
 =?us-ascii?Q?Z8kQyCor3pGDzilPLHIx1TC9dDVsG8IRDS5fK39DwMnH0iLSxH9ZDttK3M9G?=
 =?us-ascii?Q?HTtQpeywTQUQb9ATLxuuO4iO5MGF5tQWwldOyEb9KUig3TAu8YvdNMG8CIZy?=
 =?us-ascii?Q?DiAmcbWdf73xjkMjTIzi7oQfQuD7Tw8K4tgUHgoUNi47rK82TIludzlHTqZz?=
 =?us-ascii?Q?f5Gx6i1ETYsWkTP2ZM0GqkCvwI+9c9JFVZRYA6hrEIBWcoQXihw7IgllXkEA?=
 =?us-ascii?Q?R2u5Bye/nHl+pZKVATuacY78uINEVUm4XPRZaENXnFPbfdaMXfO/4x7Hde+T?=
 =?us-ascii?Q?MzbbSZ1m7JvSxaiYaS2OHNBgT57YRne98qWjXpi8Mr2WxWaWUsNzAvTUAwIl?=
 =?us-ascii?Q?yo247ov1KpXVdVv157ojpkWgjPZv7Glt+3p6wLaZymaNTgW6wqyx6YWkxcDZ?=
 =?us-ascii?Q?Z3MhCug2960/qUufW9NwceNbweA6swWsag8+xvzAmqzKRbfZW1USmmkjchvA?=
 =?us-ascii?Q?8H+U97M5g+wxQvutpTf2QnjBT36r34oqy2oP4PqE0P6e8PqvSBAyuymG3ZqQ?=
 =?us-ascii?Q?2S+DEHCY3OhT9jknsButLp/Xow3EYq0JR6LeuB2H7Sc7+NxlbR1AuVN3pLG9?=
 =?us-ascii?Q?Nv2r8DQKBUHlHqR5rpbSgUa8aPW4J4V92i5bFwxjFeV60QRb3zoj2vId/l70?=
 =?us-ascii?Q?JqSyZff/rWQzteUxnbnuhk4r06PQ52DGJXEBA6iYpU5JitjHqAqKOGJJE+eY?=
 =?us-ascii?Q?tv1TGt7KxvQQBnCGbkpqW+yRYYFaJ26ypKI+EX6S+4b9/GkL2nZVLzoQlsNj?=
 =?us-ascii?Q?jrxZ22Qk5CaUlpvr4jYIiB1TJSlYNpzC0bJtKxoglBX36HcmVDgkqekDen+U?=
 =?us-ascii?Q?1cTEaUIwJxtCVnU5Cd7qXRBtuREfvJr13yhDcWc+mlrK4JADEAYT0sXI8nqv?=
 =?us-ascii?Q?S3oLZo3oXJHe3+hU3VHh5JI5Inr65c1vyKzZNsd8U5Zu0ZrdNHq/L5FLbALY?=
 =?us-ascii?Q?AhJqCheUpU3jNL/crVT4K1sO9BZUoQQJTJ4qywamYTB9K3RbChDkv9aJLH3w?=
 =?us-ascii?Q?MlrrcYNE1oY6b3b+52ZrjgJacl0yUv6hxxrSpBlBgSVrT/O4MsiHqgRn21zo?=
 =?us-ascii?Q?XLlsX1tjV1qQGL8JByRbdeEJprFl7LKQVyIyh3WuIfREMEzE29LoUjOpIwwY?=
 =?us-ascii?Q?XgPuIdsLKBF5yDeUYnD73wKqUXgLHkA1L/T6nuOt24INt/fz+1aq6TaPmab/?=
 =?us-ascii?Q?aU2KqxTipfihIivuoW1Gao+cWnHzrGMChZjZ8056?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f483f68e-a771-41d7-fc18-08dc42f43826
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2024 00:26:26.0960
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eDFchQzV56oDB4nxIr+IOzD1XhIYyCCi0GIFqbOdXDHLsPeJYnZknPkvjMQnPBBW1j8alj+ia/ip8QoJyoUKPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR11MB8755
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Andi Kleen <ak@linux.intel.com>
> Sent: Tuesday, March 12, 2024 5:03 PM
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
> weilin.wang@intel.com writes:
>=20
> > From: Weilin Wang <weilin.wang@intel.com>
> >
> > When retire_latency value is used in a metric formula, perf stat would =
fork a
> > perf record process with "-e" and "-W" options. Perf record will collec=
t
> > required retire_latency values in parallel while perf stat is collectin=
g
> > counting values.
>=20
> How does that work when the workload is specified on the command line?
> The workload would run twice? That is very inefficient and may not
> work if it's a large workload.
>=20
> The perf tool infrastructure is imho not up to the task of such
> parallel collection.
>=20
> Also it won't work for very long collections because you will get a
> very large perf.data. Better to use a pipeline.
>=20
> I think it would be better if you made it a separate operation that can
> generate a file that is then consumed by perf stat. This is also more eff=
icient
> because often the calibration is only needed once. And it's all under
> user control so no nasty surprises.
>=20

Workload runs only once with perf stat. Perf record is forked by perf stat =
and run
in parallel with perf stat. Perf stat will send perf record a signal to ter=
minate after=20
perf stat stops collecting count value.

The implementation uses a PIPE to pass the sampled data from perf record in=
stead
of writing the data into a file.

Thanks,
Weilin

> -Andi

