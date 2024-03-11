Return-Path: <linux-kernel+bounces-99570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40AE1878A16
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 22:30:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA8BB281421
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 21:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE9D656B7A;
	Mon, 11 Mar 2024 21:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d5BLSvx5"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB36D56B90;
	Mon, 11 Mar 2024 21:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710192635; cv=fail; b=D1h51wyqkn1vKvilGIOXxBDYkWCabLjEAKLHoZ7MlW3QgPPGzZq55gGMyAkITR/QRTNPkvHnTjlY+vWm3nY3ffeTsy7xUywWFiiOhSsRGRR8pY+TEN9uzKWZzWWes2ynfwszkIXI73tlCqggSZKQyyV2ki7G+5EgVA8PjVhK0+w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710192635; c=relaxed/simple;
	bh=PMAsaEbu9cajDzrWsHNRWLD13El8EFBPEW1y/HCWG2Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rWDSiZey3KLHORPpDFChp1r/C9y22yMkZ3iOsjg/aKq4Y8ySxHFdJQhMaiBuAcj0n8bQKzpVTyV+1IR/haeU93xZBW2UsV2jd/JprLGdZZc8qxD/4wZn/1nVnfCtke9Y/3fT6BOATMs+/5OU3kgSEI36QmG/mEkOWZxNeBXW9TE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d5BLSvx5; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710192634; x=1741728634;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=PMAsaEbu9cajDzrWsHNRWLD13El8EFBPEW1y/HCWG2Q=;
  b=d5BLSvx5FP0nTQ4Xn4FzZStGOjclLQYGJoyD49SCD0f3Zo3jBPctNHLc
   zlbNkyaakuoJMId2ZcZTmA94eACMfMhz1dbjhrZVBYyjKmQMlQ+wVxgCv
   sWrM51BeEF6DrhF8o3ltkWlEfoh1+oXX6jb3CLOZMpojy40XTnW0XmS/M
   ZMbRpDVAeXR3aWxTFlu7w+FLgRNzBXDUS5i+QicDcHo2npGw87Lc9d/X5
   v9NTnZJ09Cm4FmSjMJd894pWiFnux6sNNJKFZcM0gIEn8QyIbkmXq5eQu
   kjdzBoxMUMKziWVWy51L6x3Hy+jCGUOeYu8WuT9iGCIbVY+FFYMkGiXUx
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11010"; a="22398149"
X-IronPort-AV: E=Sophos;i="6.07,117,1708416000"; 
   d="scan'208";a="22398149"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2024 14:30:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,117,1708416000"; 
   d="scan'208";a="11367611"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Mar 2024 14:30:31 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 11 Mar 2024 14:30:30 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 11 Mar 2024 14:30:30 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 11 Mar 2024 14:30:30 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 11 Mar 2024 14:30:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ev82WlWhLLoCTl0OCu3t+gYxL0UvezaYVpsHIZ6j+y2wOIt4r93699Gl7WzJnl0rdaAWIJ2OaTmPb3rSNaSOB1Fb3QJXsssrsSGQg1BIsLV0FaSlISdA0TDvudqHb9WBXSlSbF+n9jszCaSoZy+hipiSJC3r61dyNo4iPx1F+riU9kt688t2dxxjNQn+nljPo28ziYO3yV/YMMIHdnsGzKTa5ZAeHHGJNxtWuCkG3ocCj1QiolqrKc7uTApQYwOrr9sO3bC6uaHJDkmIMGiIEv02qzQFg2dacqUrTbThrLzDSbv9x2xM4nIAQ/XnPTEpp8Gqu3ikb1gc2LUs4pyKmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PMAsaEbu9cajDzrWsHNRWLD13El8EFBPEW1y/HCWG2Q=;
 b=i04AVSgv5Ko2FVmlrfUVTWdGuU/AUMWB4+Y1qLaEZXTSw1fk9JjL6k0w9R1JXL5xcnP2z0I7fvh29LuqcD7rKEA+LY6Q9gZeADB17cdHy45veF1qFEUwkyMF8wTfa2QrTezoOe6LmxagCcmPKMkguoLNnzB7Iu9/Uewb7Vv51pzt+wZtVLvmy78sBSQyBpEWebHLQ4NMG6eML21Vcgbu1gqd88zYWR0dS0xj7krUe2O/+8nCTdLKSTAt9R03y1t7qH4lfJ+7pvyoATMYK2r5Ip+OWVlYlN7jKvT3pMIUjIeB1u1j/mfUiqAuyQhD1BIKbg3MK6HdZ0eifkzc87aDlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO6PR11MB5635.namprd11.prod.outlook.com (2603:10b6:5:35f::14)
 by CY8PR11MB7393.namprd11.prod.outlook.com (2603:10b6:930:84::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.16; Mon, 11 Mar
 2024 21:30:28 +0000
Received: from CO6PR11MB5635.namprd11.prod.outlook.com
 ([fe80::d3a0:f70a:9340:9a3e]) by CO6PR11MB5635.namprd11.prod.outlook.com
 ([fe80::d3a0:f70a:9340:9a3e%3]) with mapi id 15.20.7386.016; Mon, 11 Mar 2024
 21:30:28 +0000
From: "Wang, Weilin" <weilin.wang@intel.com>
To: Namhyung Kim <namhyung@kernel.org>
CC: Ian Rogers <irogers@google.com>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Arnaldo Carvalho de Melo <acme@kernel.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa
	<jolsa@kernel.org>, "Hunter, Adrian" <adrian.hunter@intel.com>, Kan Liang
	<kan.liang@linux.intel.com>, "linux-perf-users@vger.kernel.org"
	<linux-perf-users@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "Taylor, Perry" <perry.taylor@intel.com>,
	"Alt, Samantha" <samantha.alt@intel.com>, "Biggers, Caleb"
	<caleb.biggers@intel.com>
Subject: RE: [RFC PATCH v3 2/6] perf stat: Fork and launch perf record when
 perf stat needs to get retire latency value for a metric.
Thread-Topic: [RFC PATCH v3 2/6] perf stat: Fork and launch perf record when
 perf stat needs to get retire latency value for a metric.
Thread-Index: AQHabDY/WYWU0sDgOkmWpl/MeP21nLEzF/sAgAAFmPA=
Date: Mon, 11 Mar 2024 21:30:28 +0000
Message-ID: <CO6PR11MB5635949BE12E694160F28D5CEE242@CO6PR11MB5635.namprd11.prod.outlook.com>
References: <20240302001139.604829-1-weilin.wang@intel.com>
 <20240302001139.604829-3-weilin.wang@intel.com>
 <CAM9d7cjz1JPM0MQ5m6V7DCgShCBNCd5uqVLotf61J3eu216mEQ@mail.gmail.com>
In-Reply-To: <CAM9d7cjz1JPM0MQ5m6V7DCgShCBNCd5uqVLotf61J3eu216mEQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR11MB5635:EE_|CY8PR11MB7393:EE_
x-ms-office365-filtering-correlation-id: f051b33a-1798-41b2-08c3-08dc421278e6
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: haBiT0fkN3G5XrcZoi6p0iIYUjp8s/rDHJlVm304/sm8jII/jiwUluxYNlz9GpjC1vxQa9faFPjJ1Qx0TZ3Ffu4QpZVJpLv6P33D7RHcKYEvxfdJk41Q7tYNlf+eBilLZ4IGyjDosYBha29Z24+fq3IyCHKkBlQN8fql8M7QkvmlEcmEBPqI5qzHXM4nAzraAe3EYheT7rCKv58ndosICWNlJSxX4+0BbAVY4S8e8MrIzitNjTQCjMrijuVqCmn2gZdkbcZacRc1Jb8NPqBHovxFbahmxD9nJY29uloivZDKp+hiLqMw8tKXyQhXdNZQ4OP7ArBp4sJoMf6tZ3x2v/oB1fRQ1pyZGGHDZxQE1DJSAFfG1RLDNvpR7a3ITRtK+r5zwRp/ejquazLD+lyntXggTVK81NrLSC+7ngL+hfHuTErlgkEN7GnXphqFTzi98GAhZGSkI8f4c+J90fUh6fQ9nQlTpO9oqEFxRFidv6moLlpJgkuTgL5qaZtzZQL+xX9i8qEFdP8dDwlfxIO8ha7hEopOR7E59dnnu3hR8q8mwz3zbqFinOOZjAcAxnpvStznRAhBR9MPePOQPG96nyJ8cGjjy0bZUTXulMumEeg+dgHRoUuv1L35deVpkvW7IQN/3WQJJOqivcDdfMrFMNrgE3rjEcqNpqOR21mT5PgFAXBXXrkWGw0OmipMOz+x9c3HN+NeG79z3x9veAAIIKuGuxeatKxOQoqgAK/HOSQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5635.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SnlQaG1UVk5qUlI5MjFlcnUrZzNuQmJDSDdEQUxzeURFTUhnUFR4WDZaKzZq?=
 =?utf-8?B?SlFpSjZ3ZldGQzZNTW1yNll4dVpLVXl0SkV5YllUVDMwYTVKUmxJRnVZeFI3?=
 =?utf-8?B?THRKbElyaWxWR3UzZTErR2R6dnZPdGQxdzF1Nk1DNHphRlRidUJRRW14WXpY?=
 =?utf-8?B?cmx1RFhnOXQrNTlVditmVXZPTWxBKzNCUjY2SXJsZWRBZU9DKzdJdG5mRUxa?=
 =?utf-8?B?aUlqT2NESmsrTmVtekloSkcxR2FKbVV5b0FPejNkWmtOWmd0L0swckE2bUNo?=
 =?utf-8?B?U1hPcWFOKy8vVi9aZkdwb3l6aUk3WXBGQWh0RjI0N20wL3kzZDJyajlBNW1t?=
 =?utf-8?B?SnFmUjVMTXUrb1R4MnZNMTF2dW01bldiOWVPbU1zR0RScGxaOTk5MmlGRkV1?=
 =?utf-8?B?RDNKNFVvK1AyY3lEU1dYNWY3RUUzTDF1UDlVdXlSdEZNTHhLOTZxRktyaHdF?=
 =?utf-8?B?eDlGc2I1SzVFTU54L2dhTExMVURLSnFybk5Sd0d6SWN6QWxPMGI0aGd1aUhE?=
 =?utf-8?B?UFpmS09vV3lmeHJNQlU3OE9WVEUyWjBNdGJxR3hydmNBUGxXK0xnRVFZT1A3?=
 =?utf-8?B?YldSbmlVeGN4alo4bThnR3pxVDFaMjJUeFVGSmRIQW9VR081RWNBSDkyR29I?=
 =?utf-8?B?TFpVVEplWkFDWUxpQlVKUTdmVDBPUStoZCtnWFZzSUpUUGN4VVlHZEpIQzU1?=
 =?utf-8?B?aGpIMXR4L21HeGhWY1lDQ0NQeGE3RGtMakJhQWdwaXJMMDdUemV4N0dvaHV5?=
 =?utf-8?B?aHljZ0FPSlRRQ2x4UUlVSXk0empoNHBHZzZKQTI1Y1dvOWUrM3REOFFMdUQw?=
 =?utf-8?B?MlptRVdPcmNPZCt0L1loU2g4SUJ6Sk9uVzRIdyt0QUtwUWtnZEhVUVA0UHZP?=
 =?utf-8?B?V3c1cFRnc3M0NmdIUXJCRC9BcnpRckJrK3JYckNNWlRGNmN2NW8wSkZ5RXJ2?=
 =?utf-8?B?dmI3NGlPVktVQWNRWjhWZHo3Z0Nod2ZXQmpsNVRHei9peHIrczQxN1VBYllF?=
 =?utf-8?B?UWhVdFhQRmswM1hRbmloNDNneXJuNXFTQXBCK3VoZ0lBZzJoN043SndzeXMx?=
 =?utf-8?B?d1k3R3NkelBQaHRPL3VPY3BNQmNEalVaSlhqWURsWS8rT1c4OHZPMWZhQVZY?=
 =?utf-8?B?d3RUSStqd1Q4dVF4eHlEWkFDT1VTUFhLOWlsa1VhVGtLRHFtK05wU25kek5l?=
 =?utf-8?B?QitDbHBBVDJpYlVWZmZNTU52N3RzSGxUejhHV0M5NzgrV2xuRFd2RU5xK3Nx?=
 =?utf-8?B?ZVhBQmpsa0MyeWhaVjZnalJmZEZKS1VXWitMU0pFZENtMkdrbGtqWTJpUWI0?=
 =?utf-8?B?QnBQTS9CSE50K1ZBOU9VQWY4cXI1MmxqVTkzb3IvemQ3c251S0ZXRmZNSFRw?=
 =?utf-8?B?N3hiM21CZDVVWEFKczBFTGtmRkg2cGIwSmZZblh3NVI5ZTB3V01KZm9vZWlX?=
 =?utf-8?B?amtHZnlZUEhKR0hITEo5ZjhydWNaeGh5VElTWlNDaUlyY294UVVGRjRvclJz?=
 =?utf-8?B?SmpQWUpYVnNYL3pwOWJONjJJVGhhRFNsMllIelBJMWQvUG5kY24rbkVIeFMy?=
 =?utf-8?B?cStSZmtJSVIzWnJoaVMxYVRSVm45RUJLcDU4M0c1cW9Cb2VTcWRPVG1aZHJj?=
 =?utf-8?B?S2JjL0pqVm1WYTBJYVZzcyt1Zyt0YndJQjJIcDV6R2QyZWJuWlZKRktmTzN4?=
 =?utf-8?B?ZHY2TWFHMWVPbTU4NEhqckhhYm55eU9BdkpDK0U5bjFreVZVNDVYUTI5bHFy?=
 =?utf-8?B?TEExb0lFakRXU1N0eDNNNk1hQkJsOTlCSjArM0JGRUVyWFZqbXY3QmV6UGwr?=
 =?utf-8?B?d3ZHM2gyMG1udDRQdTFubktqUG96R3BsVzdrTC9yZ0tGS0wwYkJDbDdQN0hr?=
 =?utf-8?B?M2tMSWdTWlFQbENxTE1kbTFaS3p2NXhHSUpUNTJYNFFXNnp1anY2czJQTGR5?=
 =?utf-8?B?b3RCdmhiOXFxOUY5R3M1N3BRVXh2NGtaMEhTQmtLZWJIRk5FTWtpbDR5eDE3?=
 =?utf-8?B?SFFCcUY5MFN4ZzdZWHlGdjUrbzhrVENYVXFFS1BPU1ZBOVgzK1FjYVZmYkJD?=
 =?utf-8?B?TG5RMU9FSExZaURsQXN6WGhuQkpRMkhUWW5qaCtyWUtoN0hvVDZYNmQzODhY?=
 =?utf-8?Q?7jFXAx3gtJ2fmoVMt46J/amjr?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f051b33a-1798-41b2-08c3-08dc421278e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2024 21:30:28.4518
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7ozb/OC/Lji3kZRSg4wIMyqeqH4VCO8B3thqpMu53dUraszHP1spbENUISQy1JIU5LH7vwHu9p3TSPc0w5LYyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7393
X-OriginatorOrg: intel.com

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTmFtaHl1bmcgS2ltIDxu
YW1oeXVuZ0BrZXJuZWwub3JnPg0KPiBTZW50OiBNb25kYXksIE1hcmNoIDExLCAyMDI0IDI6MDgg
UE0NCj4gVG86IFdhbmcsIFdlaWxpbiA8d2VpbGluLndhbmdAaW50ZWwuY29tPg0KPiBDYzogSWFu
IFJvZ2VycyA8aXJvZ2Vyc0Bnb29nbGUuY29tPjsgUGV0ZXIgWmlqbHN0cmEgPHBldGVyekBpbmZy
YWRlYWQub3JnPjsNCj4gSW5nbyBNb2xuYXIgPG1pbmdvQHJlZGhhdC5jb20+OyBBcm5hbGRvIENh
cnZhbGhvIGRlIE1lbG8NCj4gPGFjbWVAa2VybmVsLm9yZz47IEFsZXhhbmRlciBTaGlzaGtpbg0K
PiA8YWxleGFuZGVyLnNoaXNoa2luQGxpbnV4LmludGVsLmNvbT47IEppcmkgT2xzYSA8am9sc2FA
a2VybmVsLm9yZz47IEh1bnRlciwNCj4gQWRyaWFuIDxhZHJpYW4uaHVudGVyQGludGVsLmNvbT47
IEthbiBMaWFuZyA8a2FuLmxpYW5nQGxpbnV4LmludGVsLmNvbT47DQo+IGxpbnV4LXBlcmYtdXNl
cnNAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBUYXlsb3Is
IFBlcnJ5DQo+IDxwZXJyeS50YXlsb3JAaW50ZWwuY29tPjsgQWx0LCBTYW1hbnRoYSA8c2FtYW50
aGEuYWx0QGludGVsLmNvbT47IEJpZ2dlcnMsDQo+IENhbGViIDxjYWxlYi5iaWdnZXJzQGludGVs
LmNvbT4NCj4gU3ViamVjdDogUmU6IFtSRkMgUEFUQ0ggdjMgMi82XSBwZXJmIHN0YXQ6IEZvcmsg
YW5kIGxhdW5jaCBwZXJmIHJlY29yZCB3aGVuDQo+IHBlcmYgc3RhdCBuZWVkcyB0byBnZXQgcmV0
aXJlIGxhdGVuY3kgdmFsdWUgZm9yIGEgbWV0cmljLg0KPiANCj4gSGVsbG8gV2VpbGluLA0KPiAN
Cj4gT24gRnJpLCBNYXIgMSwgMjAyNCBhdCA0OjEx4oCvUE0gPHdlaWxpbi53YW5nQGludGVsLmNv
bT4gd3JvdGU6DQo+ID4NCj4gPiBGcm9tOiBXZWlsaW4gV2FuZyA8d2VpbGluLndhbmdAaW50ZWwu
Y29tPg0KPiA+DQo+ID4gV2hlbiByZXRpcmVfbGF0ZW5jeSB2YWx1ZSBpcyB1c2VkIGluIGEgbWV0
cmljIGZvcm11bGEsIHBlcmYgc3RhdCB3b3VsZCBmb3JrIGENCj4gPiBwZXJmIHJlY29yZCBwcm9j
ZXNzIHdpdGggIi1lIiBhbmQgIi1XIiBvcHRpb25zLiBQZXJmIHJlY29yZCB3aWxsIGNvbGxlY3QN
Cj4gPiByZXF1aXJlZCByZXRpcmVfbGF0ZW5jeSB2YWx1ZXMgaW4gcGFyYWxsZWwgd2hpbGUgcGVy
ZiBzdGF0IGlzIGNvbGxlY3RpbmcNCj4gPiBjb3VudGluZyB2YWx1ZXMuDQo+ID4NCj4gPiBBdCB0
aGUgcG9pbnQgb2YgdGltZSB0aGF0IHBlcmYgc3RhdCBzdG9wcyBjb3VudGluZywgaXQgd291bGQg
c2VuZCBzaWd0ZXJtDQo+IHNpZ25hbA0KPiA+IHRvIHBlcmYgcmVjb3JkIHByb2Nlc3MgYW5kIHJl
Y2VpdmluZyBzYW1wbGluZyBkYXRhIGJhY2sgZnJvbSBwZXJmIHJlY29yZA0KPiBmcm9tIGENCj4g
PiBwaXBlLiBQZXJmIHN0YXQgd2lsbCB0aGVuIHByb2Nlc3MgdGhlIHJlY2VpdmVkIGRhdGEgdG8g
Z2V0IHJldGlyZSBsYXRlbmN5IGRhdGENCj4gPiBhbmQgY2FsY3VsYXRlIG1ldHJpYyByZXN1bHQu
DQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBXZWlsaW4gV2FuZyA8d2VpbGluLndhbmdAaW50ZWwu
Y29tPg0KPiA+IC0tLQ0KPiA+ICB0b29scy9wZXJmL2J1aWx0aW4tc3RhdC5jICAgICB8IDE3OQ0K
PiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystDQo+ID4gIHRvb2xzL3BlcmYvdXRp
bC9kYXRhLmMgICAgICAgIHwgICA0ICsNCj4gPiAgdG9vbHMvcGVyZi91dGlsL2RhdGEuaCAgICAg
ICAgfCAgIDEgKw0KPiA+ICB0b29scy9wZXJmL3V0aWwvbWV0cmljZ3JvdXAuaCB8ICAgNyArKw0K
PiA+ICB0b29scy9wZXJmL3V0aWwvc3RhdC5oICAgICAgICB8ICAgMyArDQo+ID4gIDUgZmlsZXMg
Y2hhbmdlZCwgMTkxIGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZm
IC0tZ2l0IGEvdG9vbHMvcGVyZi9idWlsdGluLXN0YXQuYyBiL3Rvb2xzL3BlcmYvYnVpbHRpbi1z
dGF0LmMNCj4gPiBpbmRleCA1YTMwOTM1NDFjZmYuLjM4OTBhNTc5MzQ5ZSAxMDA2NDQNCj4gPiAt
LS0gYS90b29scy9wZXJmL2J1aWx0aW4tc3RhdC5jDQo+ID4gKysrIGIvdG9vbHMvcGVyZi9idWls
dGluLXN0YXQuYw0KPiA+IEBAIC05NCw4ICs5NCwxMyBAQA0KPiA+ICAjaW5jbHVkZSA8cGVyZi9l
dmxpc3QuaD4NCj4gPiAgI2luY2x1ZGUgPGludGVybmFsL3RocmVhZG1hcC5oPg0KPiA+DQo+ID4g
KyNpbmNsdWRlICJ1dGlsL3NhbXBsZS5oIg0KPiA+ICsjaW5jbHVkZSA8c3lzL3BhcmFtLmg+DQo+
ID4gKyNpbmNsdWRlIDxzdWJjbWQvcnVuLWNvbW1hbmQuaD4NCj4gPiArDQo+ID4gICNkZWZpbmUg
REVGQVVMVF9TRVBBUkFUT1IgICAgICAiICINCj4gPiAgI2RlZmluZSBGUkVFWkVfT05fU01JX1BB
VEggICAgICJkZXZpY2VzL2NwdS9mcmVlemVfb25fc21pIg0KPiA+ICsjZGVmaW5lIFBFUkZfREFU
QSAgICAgICAgICAgICAgIi0iDQo+ID4NCj4gPiAgc3RhdGljIHZvaWQgcHJpbnRfY291bnRlcnMo
c3RydWN0IHRpbWVzcGVjICp0cywgaW50IGFyZ2MsIGNvbnN0IGNoYXIgKiphcmd2KTsNCj4gPg0K
PiA+IEBAIC0xNjIsNyArMTY3LDggQEAgc3RhdGljIHN0cnVjdCBwZXJmX3N0YXRfY29uZmlnIHN0
YXRfY29uZmlnID0gew0KPiA+ICAgICAgICAgLmN0bF9mZCAgICAgICAgICAgICAgICAgPSAtMSwN
Cj4gPiAgICAgICAgIC5jdGxfZmRfYWNrICAgICAgICAgICAgID0gLTEsDQo+ID4gICAgICAgICAu
aW9zdGF0X3J1biAgICAgICAgICAgICA9IGZhbHNlLA0KPiA+IC0gICAgICAgLnRwZWJzX2V2ZW50
X3NpemUgPSAwLA0KPiA+ICsgICAgICAgLnRwZWJzX2V2ZW50X3NpemUgICAgICAgPSAwLA0KPiA+
ICsgICAgICAgLnRwZWJzX3BpZCAgICAgICAgICAgICAgPSAtMSwNCj4gPiAgfTsNCj4gPg0KPiA+
ICBzdGF0aWMgYm9vbCBjcHVzX21hcF9tYXRjaGVkKHN0cnVjdCBldnNlbCAqYSwgc3RydWN0IGV2
c2VsICpiKQ0KPiA+IEBAIC02ODcsMTIgKzY5MywxNjMgQEAgc3RhdGljIGVudW0gY291bnRlcl9y
ZWNvdmVyeQ0KPiBzdGF0X2hhbmRsZV9lcnJvcihzdHJ1Y3QgZXZzZWwgKmNvdW50ZXIpDQo+ID4g
ICAgICAgICByZXR1cm4gQ09VTlRFUl9GQVRBTDsNCj4gPiAgfQ0KPiA+DQo+ID4gLXN0YXRpYyBp
bnQgX19ydW5fcGVyZl9yZWNvcmQodm9pZCkNCj4gPiArc3RhdGljIGludCBfX3J1bl9wZXJmX3Jl
Y29yZChjb25zdCBjaGFyICoqcmVjb3JkX2FyZ3YpDQo+ID4gIHsNCj4gPiArICAgICAgIGludCBp
ID0gMDsNCj4gPiArICAgICAgIHN0cnVjdCB0cGVic19ldmVudCAqZTsNCj4gDQo+IFBsZWFzZSBw
dXQgYSBibGFuayBsaW5lIGFmdGVyIHRoZSBkZWNsYXJhdGlvbi4NCj4gDQo+IA0KPiA+ICAgICAg
ICAgcHJfZGVidWcoIlByZXBhcmUgcGVyZiByZWNvcmQgZm9yIHJldGlyZV9sYXRlbmN5XG4iKTsN
Cj4gPiArDQo+ID4gKw0KPiANCj4gQSBkdXBsaWNhdGUgbmV3IGxpbmUuDQo+IA0KPiA+ICsgICAg
ICAgcmVjb3JkX2FyZ3ZbaSsrXSA9ICJwZXJmIjsNCj4gPiArICAgICAgIHJlY29yZF9hcmd2W2kr
K10gPSAicmVjb3JkIjsNCj4gPiArICAgICAgIHJlY29yZF9hcmd2W2krK10gPSAiLVciOw0KPiA+
ICsNCj4gPiArICAgICAgIGlmIChzdGF0X2NvbmZpZy51c2VyX3JlcXVlc3RlZF9jcHVfbGlzdCkg
ew0KPiA+ICsgICAgICAgICAgICAgICByZWNvcmRfYXJndltpKytdID0gIi1DIjsNCj4gPiArICAg
ICAgICAgICAgICAgcmVjb3JkX2FyZ3ZbaSsrXSA9IHN0YXRfY29uZmlnLnVzZXJfcmVxdWVzdGVk
X2NwdV9saXN0Ow0KPiA+ICsgICAgICAgfQ0KPiA+ICsNCj4gPiArICAgICAgIGlmIChzdGF0X2Nv
bmZpZy5zeXN0ZW1fd2lkZSkNCj4gPiArICAgICAgICAgICAgICAgcmVjb3JkX2FyZ3ZbaSsrXSA9
ICItYSI7DQo+ID4gKw0KPiA+ICsgICAgICAgbGlzdF9mb3JfZWFjaF9lbnRyeShlLCAmc3RhdF9j
b25maWcudHBlYnNfZXZlbnRzLCBuZCkgew0KPiA+ICsgICAgICAgICAgICAgICByZWNvcmRfYXJn
dltpKytdID0gIi1lIjsNCj4gPiArICAgICAgICAgICAgICAgcmVjb3JkX2FyZ3ZbaSsrXSA9IGUt
Pm5hbWU7DQo+ID4gKyAgICAgICB9DQo+ID4gKw0KPiA+ICsgICAgICAgcmVjb3JkX2FyZ3ZbaSsr
XSA9ICItbyI7DQo+ID4gKyAgICAgICByZWNvcmRfYXJndltpKytdID0gUEVSRl9EQVRBOw0KPiAN
Cj4gSSBkb24ndCB0aGluayB5b3UgbmVlZCBzaWRlLWJhbmQgcmVjb3JkcyBhbmQgc3ludGhlc2l6
aW5nIGZvciB0aGlzLg0KPiBJJ2QgbGlrZSB0byBkaXNhYmxlIGFsbCBvZiB0aGVtIGJ1dCBpdCdk
IHJlcXVpcmUgY2hhbmdlcyBpbiBwZXJmIHJlY29yZC4NCj4gRm9yIG5vdywgeW91IG5lZWQgdG8g
cGFzcyAtLXN5bnRoPW5vIGF0IGxlYXN0Lg0KPiANCj4gVGhhbmtzLA0KPiBOYW1oeXVuZw0KPiAN
Cg0KVGhhbmtzIE5hbWh5dW5nISBJIHdpbGwgdXBkYXRlIHRoZSBjb2RlIGFuZCBzZW5kIGEgbmV3
IHZlcnNpb24uIA0KDQo+IA0KPiA+ICsNCj4gPiAgICAgICAgIHJldHVybiAwOw0KPiA+ICB9DQo=

