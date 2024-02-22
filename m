Return-Path: <linux-kernel+bounces-76923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D8F585FEBC
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 18:08:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E34992899C7
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 17:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E60261552EC;
	Thu, 22 Feb 2024 17:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hmOxVIio"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5630A154455;
	Thu, 22 Feb 2024 17:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708621718; cv=fail; b=eDFBFZfslTHdw/7381pVepq3nRAvklr6pV0UE0VEMXomQPisKB1TQbvXBRgoeLNlBVMnNRuFnHLWJItqKFoIsHOB41Eb3CItSQMg56oquTw4X3WtiCRrLOtOVJtr8GtJg5GtMla2rDFRs9gcxRZ5Z0AGLAAQwvBAyhfosScijTY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708621718; c=relaxed/simple;
	bh=7AkqndT/GdV6zPfjoZLPHgFl+WS6Pbgept2vpDDoQh4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=P6nCpJ6//HrfB3Lc/uAO73jMPZ/JOGmCsRB34qvwuzVDYazzvepDLqRQ6Nm56J2YRxg9/M25bEvjZ/kFaWcp1k5zZrrzEOZ2owC6SMFJY2I61Qgsm/AM82nODyg/r6UU570RIhHUk/XgpAagrj7GCICQxowkHogIfZWjh3OjZo0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hmOxVIio; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708621718; x=1740157718;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=7AkqndT/GdV6zPfjoZLPHgFl+WS6Pbgept2vpDDoQh4=;
  b=hmOxVIio+OGNIHcwsAvKaberXmWPcK6onJ34jp8LcMTuJX5Pk/bkppl6
   9bdJEos0jWoIkvwKWq88iDsP2QJIilsSQU/7pzwtlrYOTKS2aq7Ev72HK
   zj/nlI39yWF6gEFLtQkAzAaTYCRnkmyncgdjnzJk/LcyUNoVyHCRaUlxw
   LORShiSK/Sj+DDHtKTq/HUGCxpiJS9CFnaPh+bG+0Hc4jNA7CZ0s8xDL+
   J3QTM08UYfA++kE5awlv/4ZjX7R96Ju7oBKZRCmOz9GblnsMYSRssVcec
   sb6TB+CwHtFglNyhS+kj+My/QBvIRoChm2OCozn2GzxSXwxUiAaVVKJl9
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10992"; a="13995201"
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="13995201"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 09:08:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="5752749"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Feb 2024 09:08:20 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 22 Feb 2024 09:08:19 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 22 Feb 2024 09:08:19 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 22 Feb 2024 09:08:19 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 22 Feb 2024 09:08:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XmtENN+GWe6ZZ8Lbl5f+pCKZZBWCf2hoZ/UyZCKp7OxKDqTS3AcxSsISG9M/dgh0Yj/rZw7prxOwI2Am2jEVwZ/KER7pXjf1j4qPa/x6ET220D9N6qX7NKNJ56Wlse67dqkVyFn9hZY10FRPv1i5gWaoTTkj56NKqsiehWXAtHtNhddLkR6TEyF2bkoVsUV7w0MLPN+BItugqb8V0raohOdNb9pkCWS7etyMYkj9jodJ92+y3wYcJFj7ZarSBUgMUddr0mf3VMdH8z50OlxCOLm2pzJ6VObGGs0mpo3PmiTSHM7UoCGU3aoglHmMqnORaUp+Fh6hldU4vwQ1RlhQRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LquL4E+BQgm8DEkkGRF+P7diGQffplOCwXb249AvqXw=;
 b=nZsp5qRc27D7Bhb9biMcxWM1vS2ByCVWDmebCw4Q62FgZlniWUtb94KAMEXm2cNJdbWgd5bV7TEq/v7A82EX3JW+pDB4okzvYbcAJBj9pHLv4NZNTOYf+ZQ/sUO8APEErcoGwOgpNmIBv3kXoaTJVYFhn6GOVF6EkapVrJryA7ssO6lb5tzpVjRnpIDDrNvVUfO8kML6NsfPzrrVZCyQvP5cN+BGPaf2d9vlb4H0WJxpkcAudmw8N01aLw+reEWOPBwH6u194TC8Gz35GKrfjlVsM7otMShP4mVPZel0hCLZbk9f6U5DexseC2fqgOuYQdGlVTW9A+TNNMpgWyr2BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CYYPR11MB8429.namprd11.prod.outlook.com (2603:10b6:930:c2::15)
 by CO1PR11MB5090.namprd11.prod.outlook.com (2603:10b6:303:96::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.10; Thu, 22 Feb
 2024 17:08:17 +0000
Received: from CYYPR11MB8429.namprd11.prod.outlook.com
 ([fe80::d4ca:a743:64d:6324]) by CYYPR11MB8429.namprd11.prod.outlook.com
 ([fe80::d4ca:a743:64d:6324%4]) with mapi id 15.20.7316.023; Thu, 22 Feb 2024
 17:08:17 +0000
From: "Pucha, HimasekharX Reddy" <himasekharx.reddy.pucha@intel.com>
To: Jon Maxwell <jmaxwell37@gmail.com>, "Brandeburg, Jesse"
	<jesse.brandeburg@intel.com>
CC: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"edumazet@google.com" <edumazet@google.com>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "davem@davemloft.net"
	<davem@davemloft.net>
Subject: RE: [Intel-wired-lan] [net-next v4] intel: make module parameters
 readable in sys filesystem
Thread-Topic: [Intel-wired-lan] [net-next v4] intel: make module parameters
 readable in sys filesystem
Thread-Index: AQHaYFqe88erNApq3UCSgZ+ucl00BrEWomCw
Date: Thu, 22 Feb 2024 17:08:16 +0000
Message-ID: <CYYPR11MB842957703E2D353100B6151EBD562@CYYPR11MB8429.namprd11.prod.outlook.com>
References: <20240215220101.248023-1-jmaxwell37@gmail.com>
In-Reply-To: <20240215220101.248023-1-jmaxwell37@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR11MB8429:EE_|CO1PR11MB5090:EE_
x-ms-office365-filtering-correlation-id: 1228e54b-60b9-4942-41a6-08dc33c8dcc2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: h373GnbeAPxN9WqZANPAkIcCIJZAfTPNlegQQ/bN9w39OWFy9kqpVLzcxv6wfk2TzD8ONRtlzko6rOw6dlqJSOaKXqLgFyUqTRxusW5a6O7+dZyWkWxt1HPaY/HiQ+NDPO+dDoZZTRxBaA86B6bkz8SKYMVkUSv1OI0lkEwWXFnOI/vhLSY/OIaxibYdI16zeSuqzfhECjyccJRviUwSYcI8SDxAFwS+/foWUb1pdVu7l6+CKojZRpj9kPfoXF1aniC1vI208XxJNXq0SyBtHF0uwj+jJoEAZD/bU4dh5W4RZGA6zTqMzbsYc8OvXzUF9DWCc0SHZLwwbMO38oBQqs4nxwFDSbZ4J7Oq4MuhhdDK82pxEATdRLqBwPMTo38DNke9BYFfBn206TaNY5QtqWgYBwBBFL9BKXO7/s2ghNzCVTCWZHIT8GMJknZ3CV3WgXBBkoXdypLfImA1njVE1rKu29OU1e8N0BSR6j8gNlqwxO3x6j+5/a6ssSe3NMk3X0qeXbsDfebJz0+nxPwyMELSBbGYCRPqeeVIU+Qa1crmXE6rvTd6QcQin1if6oj5xLbl7qSakuktBl0ylUKqFcBBRYpMmHymfeVn6ax7Zps6Qt2B7ZAxUxnLBjl6HqzU
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR11MB8429.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fUUvBq2TauJDXeXHQScWLDZYbp8iQ9ojpJn8pFY9mYcnoKTGhH915ZUPd7V5?=
 =?us-ascii?Q?lW7+VHxa3sGCxOtuzD1q+qP8eKSg4XLbGiQExE50T/97AJyUYwdpzIcJXsGe?=
 =?us-ascii?Q?DdKPyi3pxIZDm6ZVZsGr7bNJ+aMzpO6Fwfn9/tSPTizpSqjVmBOdkiqu4ApU?=
 =?us-ascii?Q?opUDgUlMI4BjAA1OnZKwZ7nUEiOOxuJx/1tu10j3m5rWD4/6NV/AVC3ukHpv?=
 =?us-ascii?Q?y4Tw8nBzFJW/A8pEuVMFjRWBwTkGYCeWKovyPyKQDSXm5n4mWtem55L+wITN?=
 =?us-ascii?Q?MoHcRZanZ1fbGtxmaUAfHApYqf0gb0jrItL4p/MOgAroUwIIaOA0rZdlDIqa?=
 =?us-ascii?Q?3/oTbT1dwlfebBxXHTxVhhyvYYnpNd9Mz3tkE6HSrTMZ9IpgxidLjHrzFoA2?=
 =?us-ascii?Q?dVu5WGEs3YNUJc7gPCOcDHlWeYrHVGqtB99hhPLpk+1wLEMwyX43YyezUYVv?=
 =?us-ascii?Q?tD76KcmzzIf78mtFxUMVH5w2o5iuhkWPCHd+/cWvA7rnv+CveqaRJcWhaSc5?=
 =?us-ascii?Q?40CCqQ5Iu/jStv0wadYbQcQlvwcnu46tCdakyQuMTXxwWRRmMtKx/BdaV/TS?=
 =?us-ascii?Q?RFC1Vf3+gEc3RN+GGdr1+Nn1gg+fq8KCbbW13OgNtb/Lj7F8d5Knp3w66VVe?=
 =?us-ascii?Q?E+LmGbzjXkISBasdOZvpruey+q5U9i+KRE0effz6SR7fonP4FA3zNyMYWwYs?=
 =?us-ascii?Q?x430UYRAgAeob0VMGKqwQ1YM2qifslwdABHTJRl8+N425tmqF1og3V5WSvp3?=
 =?us-ascii?Q?zBAFUEBnolHazTUYkUcm4cLGplFDMAz/L6T2koc26+6Uyl+Z8u7E3ssT33pJ?=
 =?us-ascii?Q?wO2cqJxPn9Yx0/tfra/paFWiqF/eYjS565pEbYrIA8pdRcsSgqM8YKj+i64D?=
 =?us-ascii?Q?fMR4DsJqo0DfCUk+rdrctD/ta99bMsvCiluqrO9L75i55ruMlNEsLG487fwG?=
 =?us-ascii?Q?ttxCKQpH7mTi4yj3eWPCNmsRL0YuggrujNokk9M4kHJUIBCZ8L26559V90V2?=
 =?us-ascii?Q?e/k7X2+J23JPSymU5QUnK6dIyGEaZ/jkTfdH43rhJIBWTUDwDrsGHoFw9Pi7?=
 =?us-ascii?Q?SfkRjQwr4u1Xz1vYiklvMV+S5IdHBDNCfrvWNHITe+rHmAyepU4lEQmCEvcR?=
 =?us-ascii?Q?3pCTIPVdNynKzGO3LD7hw6YViiVAJKKRsP7HLGm2qwXdO2VwHzUdy7A8K8LO?=
 =?us-ascii?Q?LmC09M+V2A7hpu4WjScCln7ZSvL/cG2fhSkruzcQ5zBi2XXAAkdrgbbg7mmz?=
 =?us-ascii?Q?FcX9y5feudtYdLf3tBB6+OvZN8P9XrfBHLvq37BNMt0bvhZ5y9gRa5q7Dwdp?=
 =?us-ascii?Q?9Yi8i+zUPZ5EQ+N7phuGnCcEcs9lSeSpKSdLxTs7CK+GkQwQF0FrRtsAOYJG?=
 =?us-ascii?Q?ii2m0aQk2WWiUTIYG4EsFUwSYjciCLvxTvXNbR3WnBbfq1hmGnFhEguGBJD3?=
 =?us-ascii?Q?5scuXRhv+ZNyicFZP2nVexk+iX3Y06OxKcVmec8/vHAlUf9CiCgY2XgPUZtB?=
 =?us-ascii?Q?3YLpi4NtCgFh81ROxb7UGLlXU6z5wLFGw7jg9FeP5rpPYqjHGIUdLfDtApE3?=
 =?us-ascii?Q?/irGRzFLYnhMWenNHosZKjHplEDJETfsmXl7bzvcAG0yNPU36HXLYlisx/rS?=
 =?us-ascii?Q?Wg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CYYPR11MB8429.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1228e54b-60b9-4942-41a6-08dc33c8dcc2
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2024 17:08:16.9552
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sakB8PMsTad0E/CwUSWX8bqmOQn4Bb7egEf11qZh+3y+fjY0vE8CyAfPTUog6xyl39kDXxlq+ae98XN6tFkAxEzbb912oPu7NVg87pr8KIdDihWIAlDv199/n2GeuDET
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5090
X-OriginatorOrg: intel.com

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of J=
on Maxwell
> Sent: Friday, February 16, 2024 3:31 AM
> To: Brandeburg, Jesse <jesse.brandeburg@intel.com>
> Cc: intel-wired-lan@lists.osuosl.org; linux-kernel@vger.kernel.org; eduma=
zet@google.com; Nguyen, Anthony L <anthony.l.nguyen@intel.com>; netdev@vger=
kernel.org; kuba@kernel.org; pabeni@redhat.com; jmaxwell37@gmail.com; dave=
m@davemloft.net
> Subject: [Intel-wired-lan] [net-next v4] intel: make module parameters re=
adable in sys filesystem
>
> Linux users sometimes need an easy way to check current values of module
> parameters. For example the module may be manually reloaded with differen=
t
> parameters. Make these visible and readable in the /sys filesystem to all=
ow
> that. But don't make the "debug" module parameter visible as debugging is
> enabled via ethtool msglvl.
>
> Signed-off-by: Jon Maxwell <jmaxwell37@gmail.com>
> ---
> V2: Remove the "debug" module parameter as per Andrew Lunns suggestion.
> V3: Correctly format v2.
> V4: Add ethtool msglvl to message. Remove deprecated ixgbe max_vfs
>  drivers/net/ethernet/intel/e100.c             | 4 ++--
>  drivers/net/ethernet/intel/igb/igb_main.c     | 2 +-
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 2 +-
>  3 files changed, 4 insertions(+), 4 deletions(-)
>

Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Co=
ntingent worker at Intel)


