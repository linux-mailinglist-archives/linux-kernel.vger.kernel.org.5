Return-Path: <linux-kernel+bounces-58151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F41D684E1EF
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 14:25:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6BC81F268E9
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 13:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8221676403;
	Thu,  8 Feb 2024 13:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MRl3m7sV"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB59271B47;
	Thu,  8 Feb 2024 13:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=134.134.136.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707398704; cv=fail; b=rohwyd5JVm86gxJ9ZOiJ5l4+9xTSKcH+9vdtRi0AIZxkjGtYVHUjOm5VSYP8j948K4SWCLOy4OR2ZB4i/i7adVSDkGPhW+UNbvfU7oz4j+QYjyhZNFFolyy/PNMT9Gp/3xd59XYNam0dSZPb8r8HWmHZjE2P+xGMgppafVTMioQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707398704; c=relaxed/simple;
	bh=jQ7vJwWyVH4AobjYWPPpd8eSNj8ltuxPHnEjMkqm/f0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tZcU/hC4t9YbpuMK+xylcQW6coPiGbAmGOkQIhZh9ERqcQKmgqIS+yOF6JRGbbZs6MPYx4tCGdX1GdckumUu05xPyEv1Yobveps5fOczwhA6caMvvlgSKwYyuvI8PF1tH41OSlyPH8ZKgj6f1xyBDvoKN5IEiN9NvXPNE1lcm10=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MRl3m7sV; arc=fail smtp.client-ip=134.134.136.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707398702; x=1738934702;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=jQ7vJwWyVH4AobjYWPPpd8eSNj8ltuxPHnEjMkqm/f0=;
  b=MRl3m7sVHS1N60NG4R8u8lYCzYtF8TrDTWeN0QDnAI5E+bgE7ux71jSM
   +pbHlseELI5rSkXbqYjba4uF0Ue+nK1CEyQcFg77mY+E54NKnp/Ef/7ZV
   F7rxnOrBkOWmg8BtGqUVwtuUM/x9ZIJhvdVmZO1hv+Dh3d9ClU9sjCXzN
   XuXcWILBFxTQGLE1YyIwvgWtGnWm/5Ne+IIQV8w5zjyC+VYsjxAZuElFf
   FWPdMTIRZOPnkxwQeigQygruoCC8A0j4sWQYkyLbt1hvxekrjNJrI3seR
   xA6PRRLoliuPQ+IdQ0ExAUGNqRyNFIEgUjLKIehbAUqx42AzJtVuYa89X
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10977"; a="395628232"
X-IronPort-AV: E=Sophos;i="6.05,253,1701158400"; 
   d="scan'208";a="395628232"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 05:25:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,253,1701158400"; 
   d="scan'208";a="39083589"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Feb 2024 05:25:02 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 8 Feb 2024 05:25:01 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 8 Feb 2024 05:25:01 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 8 Feb 2024 05:25:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jp7bAeKEloiX+0B/wFwNN5ADeC5+5URa2JFkVS6KflyjnCTkdStkjNqjXwHG4kSUuOy/A4YsRewdBvY5vAnZwAVuiz+G/QIHMh11jkhU/VfgjNeGM46HptKShB2MKMlHjOwi7ecMWFPnsQ2So4wpUjWIVLNLBAj8NW5aUGXmFmSn4lGSpxI51nkve77EQLtrdn/wW6hQqY0jpL6363me9CplrDJcxhSUVqGl9PVm9NOZActSUVvAGf5TWCu6PVcLfDMKk9QV+E0U4J10CtF8/IsoxK5nw02Xxi93QHpejRfIqLYzUMqGgDvSDtG8y0Wkq7KPcUUPLM93a47VFi8MvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jQ7vJwWyVH4AobjYWPPpd8eSNj8ltuxPHnEjMkqm/f0=;
 b=WUUaKHLLQAa6pAgn9HJTmT3hvje53nkTvHrN6lKbT+3UlSKk89/Yrs8RFADCT9cfcIyl21vyZ2XNCWnNME71l8ZJZK3SUBqtHJlyFsyIOcH9TgcgalQWKozv+YBsJ+gaRdyLQfIqzP2WRSMeCKdLE7EH2NadT5N0iM2kVYQUwEmWUNNwsMw+nfyBEU0oCZxjMtUmZ7JCR3iRjCAarYX3gNecAu46WVNmB8SxMUSeCsOnQ+LxuIpQhd9MOzgewHTT7rQbaQjgV3S1Q3y8V3+ZmwXiLl5oezqghcc+woxw7BRSkVtfNcat7it+pjuecpQS9ltfreAG8yae63PdwMjsWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW5PR11MB5810.namprd11.prod.outlook.com (2603:10b6:303:192::22)
 by SJ2PR11MB8371.namprd11.prod.outlook.com (2603:10b6:a03:543::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Thu, 8 Feb
 2024 13:25:00 +0000
Received: from MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::d140:9bf1:fdca:b206]) by MW5PR11MB5810.namprd11.prod.outlook.com
 ([fe80::d140:9bf1:fdca:b206%4]) with mapi id 15.20.7249.038; Thu, 8 Feb 2024
 13:25:00 +0000
From: "Korenblit, Miriam Rachel" <miriam.rachel.korenblit@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM
	<linux-pm@vger.kernel.org>
CC: Gregory Greenman <gregory.greenman@intel.com>, Kalle Valo
	<kvalo@kernel.org>, "Berg, Johannes" <johannes.berg@intel.com>,
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, LKML
	<linux-kernel@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>,
	Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
Subject: RE: [PATCH v1 0/3] iwlwifi: mvm: Thermal management fixes
Thread-Topic: [PATCH v1 0/3] iwlwifi: mvm: Thermal management fixes
Thread-Index: AQHaWfmscI0ONMIKDk+7Rq00PN9JerEAcBkQ
Date: Thu, 8 Feb 2024 13:24:59 +0000
Message-ID: <MW5PR11MB581099D043805C432D538048A3442@MW5PR11MB5810.namprd11.prod.outlook.com>
References: <1892445.tdWV9SEqCh@kreacher>
In-Reply-To: <1892445.tdWV9SEqCh@kreacher>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR11MB5810:EE_|SJ2PR11MB8371:EE_
x-ms-office365-filtering-correlation-id: 0b2099b6-e13a-4193-6e31-08dc28a95993
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oQWh6RgupRNlT6cxnTyGmsYmaNnwNzhKCYTzDCQvH+Disd/WjgWf+PuMSJ/GpYtj8u2cu2i1s6Sx4bGp3ag1vyhhiISMX4kJxbHR9ECZVJqgTwfFgkHoXOCjzYQt217Xy3yPbj7X9rubrPCicYROtmn/5bNrKoYREC3tdOQHk2Rt0Nwz/E6Tmg70/NoXS4AiizV7W6KjumDze0GDEtcIz+tx09vbMilhXgKH2JEf+LFGw6IB7BTELHvwcUVIoQdrWwcys/Af+X+jMkk4Q77nWz0q3yngxUaTnZvtJC6/7HyUVJ6XZ/09vHKDrvhNhZ45e+fdGdo+ys+RElCXxDnhR77Ni5uFOUTFv77QVPDdKZH6zlwd0RTG7fc2/YWwXxKo9mj5v+JmxAqun6v5PwDazvLhy5qDc+4+MdNLjKVjn+2dQ9FixF86xmEIRyRkX/s7U54l2RVypA79UcnuzLgMZbviyrzZP++oRsgd+NzFzKIGI4lj9eF4FR2JxT1lqy7Bqd3VPezssPydV1LR3q3H16XhgpFR73OAfVLdMukcnR2Q0q124ZR63FPDCSNKJlUK9LI7+tluXg05RfW7fnBTVAIn6E9yorsIJJBsNn7XNQw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5810.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(346002)(396003)(376002)(366004)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(2906002)(83380400001)(122000001)(55016003)(38100700002)(82960400001)(66476007)(64756008)(66946007)(41300700001)(86362001)(38070700009)(26005)(110136005)(316002)(66556008)(66446008)(76116006)(54906003)(71200400001)(478600001)(4326008)(52536014)(8936002)(8676002)(33656002)(7696005)(6506007)(9686003)(5660300002)(966005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?akMrQ1hCb1owUXl2Ym5BcGdIYVkwa1dOWWZiYTkrOVhRZ3dJTGd5TGhsWlRU?=
 =?utf-8?B?U2hQeFB0S2UyQk9rYjl0b2hyazZIOGQ0bTNUek0wYWxvREQyWDlrUXlBc1JL?=
 =?utf-8?B?QXdDNHhGQzdhYS9KM1llRVllZ1cwb25kZWFKbGRXUEQ4Z2RSSzJXYUd4MzdW?=
 =?utf-8?B?eXNUMkwzS3YwNnRFVk44eTBGV1JpTkREdTB4OUpUR29vMHNpZkNlZ25kcWg3?=
 =?utf-8?B?YzM3SDk5NmZxWDdYeUczL2hYRWZkQWlLVUpaU2xsVE9rU25lT3lFRjZHZHV4?=
 =?utf-8?B?cFlnWWZpdFdpbjh6NVJYR2NKWmtiVzJubDJmeUg1cUpyNk1hVFdDdFZWMm41?=
 =?utf-8?B?VmVsa1RHRFJMZGxCVnZBM2poT1dJc1p0RjA0QXNObVFVektsNGd1WGsyRHVY?=
 =?utf-8?B?SVV3UzN6VUlaOXlvZy8zRmhhbFlVendvUjRRQWFtcnN3WWczYmNpMTJqdTBP?=
 =?utf-8?B?RWlxT2NyUzdHckxWWkNpV0ZzOXNncy9jVU1yS2RUcnB2UCt5clEzTmdybUhp?=
 =?utf-8?B?YkFUSmdJR21CT3ZFbCtIY1NUZGRuMEV1cmY5ZjdrYlVRbGFlZ1lialNNUXdW?=
 =?utf-8?B?TkJqQnA2Ylk3dldmVHNFY2VJOU5JanpJQVMvbWJjclBDVm9XWndlZmMwKzgy?=
 =?utf-8?B?Mkk2KzVhMjlCa3VPK1ZHdjByWU5HV2xXeGtYVTVLTTJRYzZFYUd4bFVPWkph?=
 =?utf-8?B?VDVIWWRTWHpJc0hreFFsZWkwbmJ0VE96VE1Rc2xuSUU0RFphc1JqUEQzZmZR?=
 =?utf-8?B?dzluSWFUNFI4VFlQbEJXdDQrLzRveXRONzZEQUFsWHZXdTBlZTZSKzJGZFkw?=
 =?utf-8?B?bm0rbytjaFNzSkhFUTRVdDdpSDAzbnV3UTh6bk5IY1dUdEJoSEVCblpsdThI?=
 =?utf-8?B?Q2EyLy9kQXhpcW5aZU0wTXg0aVorTXgySFA0SUpSb0NQUEZCNWxsRTJJQ0M4?=
 =?utf-8?B?NjZvS0VoRko5d1pUQmtvai9XSjRKcjJHaU9rZUdZNWd5NVk1Y0g4dUxkcTJD?=
 =?utf-8?B?V1hVL2QrdEJqS29ZeEtNWkdsYnB5ejh2VFZncWV4VzdQWUFxeXVIbDR2Vm5J?=
 =?utf-8?B?RDVwOXBNcG1uem9ocVZFOC9oWmh5dmtZaU1aN0UzdTZ1ODdUL2QxcXlpdHJT?=
 =?utf-8?B?QWVoTUR2a2dRNHVPaDV2aEdXMmJiUE4xakV1TGM3clM1OWpBVTJNNmlMd09v?=
 =?utf-8?B?MkdpdnNzRzRuL05vUG9Gbmw5bmc0bjYreFVRS01scEwyd1MyTHZVRGJKV3Vo?=
 =?utf-8?B?UjN6MHpoRCtTa0ZkL3BYQlpENzRSeUhFUGtYMFlhVW5SS3Q3ZGZtTktKVllH?=
 =?utf-8?B?dXlMMEZoRjZjL1NBTStGYXhMbnZIdUhNbXV4S3UzZUxhNGcyN0hRcmZpM0Iw?=
 =?utf-8?B?SWF6VEh3bjlGUzVjYWdVV2ZKam1IQy9oaVBZU0hERC9tMW42SUc2KzN5NGVY?=
 =?utf-8?B?VlF4bUY1V1dvN3RSN1V2U1hwaDlXYk5wYWxhRjF1bHB2OFFHU1F6RWErblM0?=
 =?utf-8?B?Y3hSNE11MXB5UFU1eTkvMmhNWmJYQVJoOXg2T056UTRsUkcwUm5oQXE4amw2?=
 =?utf-8?B?cnAzbDJ3RUpsenF4eVhnemlOVnV1QXF0TW1tbG1vWmowN1hYRXlsNjV6Uk85?=
 =?utf-8?B?bnA0aitUTVh5VDdkTGdjRjV4RG44N1JJbnRuWTJwdzVMN2U3TS8xeXVXMDVn?=
 =?utf-8?B?NDJQZXBTYkM3UEc4ZU95eXgxVUNZV0JERG1HSStqeFFSN01qa28rNmF0OXU1?=
 =?utf-8?B?Q3o5RHM2Y21QdGw4alhYVWJsVTRwVG85emFmY3hRR2Y5d2JPR1dTaGZ6YlNo?=
 =?utf-8?B?VHZkcjdPQmNDUjVPN3FwdE5xVnBJTkROWDJXcFpUZnpYeUViZFI4NzFsVjVu?=
 =?utf-8?B?dExXZkJ0aHJQNFFrblhMeUN1d2liRmRxeW0ySDNzMUxwMXI3bjdianR1TXNl?=
 =?utf-8?B?V0R0UEFwdFp4cEJzL3Vzdm9lK3lIYWdFSVJCNDVQbkRTTUVHNGFqNHpyek5S?=
 =?utf-8?B?eUpXcC9tMjNyb1ZYSUFiVFpVN3o2N2NqSzUzeWs3OU9YMmpEWlJwNWQvWTZN?=
 =?utf-8?B?VmRsd05jR2VFaVkzSFRPQ1krajIrdlh0cmdQNXB3UFpwNGlPZUxwSUV4SXZE?=
 =?utf-8?B?U21TVEk0SzlmZTVTa2lIY3dkSFQ5bEhFTWxSemZ1cHhLUnhpRVNwMkYzcmFq?=
 =?utf-8?B?VUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5810.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b2099b6-e13a-4193-6e31-08dc28a95993
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2024 13:24:59.7121
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jGjT+D9Wqi6wqqX4bUNCIANLDymmJ0Mjth+dwCukJXJ4UjDUsuNzAASGTP/jMGD7Lx0McHMyCgatgpEp+0RYi+4Nraqt8Ah+BP9LQLDtNU7/8LpwZRfl6qbtMK3SYYUA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8371
X-OriginatorOrg: intel.com

PiBIaSBFdmVyeW9uZSwNCj4gDQo+IFRoZXJlIGFyZSBhIGZldyB0aGVybWFsIG1hbmFnZW1lbnQg
c2hvcnRjb21pbmdzIGluIHRoZSBpd2x3aWZpIGRyaXZlciB0aGF0IGFyZQ0KPiBhZGRyZXNzZWQg
YnkgdGhpcyBzZXJpZXMuDQo+IA0KPiBGaXJzdCBvZmYsIHRoZSBmd190cmlwc19pbmRleFtdIGFy
cmF5IGZpZWxkIGluIHN0cnVjdCBpd2xfbXZtX3RoZXJtYWxfZGV2aWNlIGlzDQo+IG9ubHkgcG9w
dWxhdGVkIGFuZCBuZXZlciByZWFkLCBhbmQgdGhlIGNvZGUgcG9wdWxhdGluZyBpdCBoYXMgcHJv
YmxlbXMsIHNvDQo+IHBhdGNoIFsxLzNdIHJlbW92ZXMgaXQuDQo+IA0KPiBTZWNvbmQsIGl3bF9t
dm1fdGhlcm1hbF96b25lX3JlZ2lzdGVyKCkgcG9wdWxhdGVzIHRoZSB0cmlwIHRhYmxlIGFmdGVy
IHBhc3NpbmcNCj4gaXQgdG8gdGhlcm1hbF96b25lX2RldmljZV9yZWdpc3Rlcl93aXRoX3RyaXBz
KCkgd2hpY2ggaXMgdG9vIGxhdGUsIGJlY2F1c2UgaXQgY2FuDQo+IGdldCB1c2VkIGJlZm9yZSBp
dCBpcyBwb3B1bGF0ZWQuICBJdCBhbHNvIG1heSBhcyB3ZWxsIHVzZQ0KPiBUSEVSTUFMX1RFTVBf
SU5WQUxJRCBhcyB0aGUgImludmFsaWQgdGVtcGVyYXR1cmUiIHZhbHVlLiAgQm90aCB0aGVzZSBp
c3N1ZXMNCj4gYXJlIGFkZHJlc3NlZCBieSBwYXRjaCBbMi8zXS4NCj4gDQo+IEZpbmFsbHksIGl3
bF9tdm1fc2VuZF90ZW1wX3JlcG9ydF90aHNfY21kKCkgYWNjZXNzZXMgdGhlIHRyaXAgdGFibGVz
IHVzZWQNCj4gZHVyaW5nIHRoZXJtYWwgem9uZSByZWdpc3RyYXRpb24gZGlyZWN0bHkgaW4gb3Jk
ZXIgdG8gb2J0YWluIHRoZSBjdXJyZW50IHRyaXAgcG9pbnQNCj4gdGVtcGVyYXR1cmUgdmFsdWVz
LCB3aGljaCBpcyBub3QgZ3VhcmFudGVlZCB0byB3b3JrIGluIHRoZSBmdXR1cmUsIGJlY2F1c2Ug
dGhlDQo+IGNvcmUgd2lsbCBzdG9yZSB0aGUgdHJpcHMgaW5mb3JtYXRpb24gaW4gaXRzIG93biBj
b3B5IG9mIHRoZSB0cmlwIHRhYmxlIC0gc2VlIHRoaXMNCj4gcGF0Y2ggc2VyaWVzOg0KPiANCj4g
aHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtcG0vMjcyODQ5MS5tdlhVREk4QzBlQGtyZWFj
aGVyLw0KPiANCj4gSWYgcG9zc2libGUsIEknZCBsaWtlIHRvIHJvdXRlIHRoZSAkc3ViamVjdCBz
ZXJpZXMgdGhyb3VnaCB0aGUgdGhlcm1hbCB0cmVlLCBpdCBpcw0KPiByZXF1aXNpdGUgZm9yIHRo
ZSBhYm92ZSBvbmUuDQo+IA0KPiBUaGFua3MhDQo+IA0KPiANCkFja2VkLWJ5OiBNaXJpIEtvcmVu
YmxpdCA8TWlyaWFtLnJhY2hlbC5rb3JlbmJsaXRAaW50ZWwuY29tPg0KDQo=

