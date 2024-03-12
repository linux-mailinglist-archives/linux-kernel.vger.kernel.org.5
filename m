Return-Path: <linux-kernel+bounces-100745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E688879CA1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 21:08:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 520861C21A8A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 20:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C71AE1428E9;
	Tue, 12 Mar 2024 20:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aCtL7sLH"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB201428ED
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 20:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710274121; cv=fail; b=Gpc6TKxMDdgVexim7EJhr8rg+Rj6ShkUFzq4RqDwT8N8lkxzkO2OmTAO8fBoMCqnxiLoyOoHKm74LETMApeLL8hqpJrd0g0htyOVOYUFOle1tLgcBnM/+xZg/tTIn9upiqNWK4CZ0NMrso9dyINSoZ5ms318qM7Ek8RFEmPbSR4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710274121; c=relaxed/simple;
	bh=Wgvc6GecvjoujRoMHr09sB8DpgNIdqLhQDQVJla3We8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CFyOenXtXQ3079+T0fkN1YVAhGC5YMEqgY8LHWQBoKSIXnWnYHXwpGHCv4/UUq6NLZa3PCaurpRICUS3SwDwjfvlAuTH19v0aTocbb3zOprDSdE6YNzaWCmL7L0uhC/MoxbPy4rLvQVZTbNfOWj3Vfngb8w8ws54lEJuNPVngTo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aCtL7sLH; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710274121; x=1741810121;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Wgvc6GecvjoujRoMHr09sB8DpgNIdqLhQDQVJla3We8=;
  b=aCtL7sLH3EPvxpqKUB1LmFo1y21OTjDRQyADceuoWYEGq/IpY4eYWtvH
   R3eHvniI2EPe2gp6eE9d0oqTVXfvsD7B8FAh+7jBNii+uRsO9qKV6+yJL
   9Ok8Bk8OZtzFkD3zS2yk7dS7/RNRayLhJjFiK9+ia1R73mioxMgiJK1s+
   o6mhGfwTNZxnHpvzKxe4FdQK3BTXoOtQKly12ImBnYSrWaLy8u4pun9T7
   ENx7OTw8q/SC8VDPt2z509aF+MwnLvSkWhIycr4Brq7i2hANCuSYaAt/F
   76sMO9Sebl2nQkQOL7pu8gddXPMYN5T032zBKdeHI6Kyakatb1F3Zacv/
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11011"; a="7952943"
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="7952943"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2024 13:08:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="11602327"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Mar 2024 13:08:40 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 12 Mar 2024 13:08:38 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 12 Mar 2024 13:08:38 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 12 Mar 2024 13:08:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QQY1UZaXHq0PEOPtGqFSE8/czogYMeW0FuG7Pfap+G54TIljRiL7zZwgINFclwRpddJyDFB6cOvfjp5ddnLzQrSHlt30ugLe+Rfxqzb6K0UtBfJQugz537GTrHEQLAPFoMjd1E9SIWxQl6Wb1DM8rwIQmwZdnu+owphfO+5g7LGDo0oErNCTXq9JlBELUEOhAei/UtPscH/jZgUMqU3f9x/Fx0j62kbD6HA6+nq8E3j/pjvuDds6uOD4X8T98p/1PndlyTdk77Hfe+9zstTtgz1N9c2cb/chuepcp4jill+J8E+ytJ/jD0S96xZ6H+oJa/Hsolycf0pUMEfOdJ/Fug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wgvc6GecvjoujRoMHr09sB8DpgNIdqLhQDQVJla3We8=;
 b=A7/N4kFGe7cGCZKO0+6krBchFZ62NQuCnWSxnlfuk2lOWGdjZ5pTCICMS1dZBuOu7264Nax85tmGB3u/DTHPtmDAe4GbmCaNcAayMQbiWVVaW1vHj71Qv4vOdRxD92vi5ckoz5r+/5cMC426r79xFBIEXVIMtRscljpcLxBA+t/uxPkD5qkOp+Cf/i5n2zo3PXySLVEqKKMiaWAwD6Los4PTXZI4k4blaOv+83jravSloo1JundW4YWcBWdVjouwCb6XPX5Ew7jBbQ2D9ynzqboZQOqTP/mZ95Ip1KRaVYPYrE8uJzA4FcFanELOoGS+tbaROPaTargZKuyVQnN2Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by DM4PR11MB6168.namprd11.prod.outlook.com (2603:10b6:8:ab::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.18; Tue, 12 Mar
 2024 20:08:37 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::fca9:7c00:b6d0:1d62]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::fca9:7c00:b6d0:1d62%4]) with mapi id 15.20.7386.016; Tue, 12 Mar 2024
 20:08:37 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: "babu.moger@amd.com" <babu.moger@amd.com>, "Chatre, Reinette"
	<reinette.chatre@intel.com>, Borislav Petkov <bp@alien8.de>, James Morse
	<james.morse@arm.com>
CC: Thomas Gleixner <tglx@linutronix.de>, "x86@kernel.org" <x86@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Yu, Fenghua"
	<fenghua.yu@intel.com>, Ingo Molnar <mingo@redhat.com>, H Peter Anvin
	<hpa@zytor.com>, "shameerali.kolothum.thodi@huawei.com"
	<shameerali.kolothum.thodi@huawei.com>, D Scott Phillips OS
	<scott@os.amperecomputing.com>, "carl@os.amperecomputing.com"
	<carl@os.amperecomputing.com>, "lcherian@marvell.com" <lcherian@marvell.com>,
	"bobo.shaobowang@huawei.com" <bobo.shaobowang@huawei.com>,
	"tan.shaopeng@fujitsu.com" <tan.shaopeng@fujitsu.com>,
	"baolin.wang@linux.alibaba.com" <baolin.wang@linux.alibaba.com>, Jamie Iles
	<quic_jiles@quicinc.com>, Xin Hao <xhao@linux.alibaba.com>,
	"peternewman@google.com" <peternewman@google.com>, "dfustini@baylibre.com"
	<dfustini@baylibre.com>, "amitsinght@marvell.com" <amitsinght@marvell.com>,
	David Hildenbrand <david@redhat.com>, "Wieczor-Retman, Maciej"
	<maciej.wieczor-retman@intel.com>
Subject: RE: [PATCH v5 1/2] x86/resctrl: Pass domain to target CPU
Thread-Topic: [PATCH v5 1/2] x86/resctrl: Pass domain to target CPU
Thread-Index: AQHacaEMnytKeNiinE2EIuYLr6CVvrE0jksAgAAAYPA=
Date: Tue, 12 Mar 2024 20:08:37 +0000
Message-ID: <SJ1PR11MB6083FC68BA0F1EC6FC839F7BFC2B2@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <ZdZPht8hY4J9uIOz@agluck-desk3>
 <20240308213846.77075-1-tony.luck@intel.com>
 <20240308213846.77075-2-tony.luck@intel.com>
 <9fc33aee-8afd-4c8e-af83-74eb11a951b1@amd.com>
In-Reply-To: <9fc33aee-8afd-4c8e-af83-74eb11a951b1@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|DM4PR11MB6168:EE_
x-ms-office365-filtering-correlation-id: 1b7cd906-4cf3-489a-bc09-08dc42d033ed
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /uHjMIcUoMPI8O4rGQDcScyKPNxT+DYj6vTBfjgyzRi7/ezl+ckUT+KK8ayJMcJDAkgd7zG+ocOxv2oD3Rks98hdjSX1haVz3KAuM2PmSsjcqQEdw4pcGSeos/fNI8/K7/ZRiWsymdquPISoGC/xXBjevDoVSDsvJ8VWXru1VlaSlNJ9EQqN7VQEVkoZ7MfRMsv+Nt3e0BtoQbRwdDZSefHMolVfI44QP3IOpkyo4i6Axlqfuv0QRPX7ZeOwXPPrQ+0vJNg09/YgTpUpNfI0nkWhGroS7sV88sB/5Xmd8T9gWIavaVFYtCc9PXXET+CDAQBduz/IVkrzSoOaWcANCy1TFwoNXKQYBijsZO2qotgdZmtur3q/LMeWp43EWtJtI51Rkn6nBBGJM9DgJz3BIQ8z5kqtWgaRHqqzUTN1USBmhRmW1Ffw+r+J0VaEsfaWE59XKcllZ5iT3JqtXWkM5ki5CnGJxfoN4Lsk0wdr+2GTDWd3tflA/AqW23DGuEXxLM86MWgQ1cNYr3Xy53i5b1dgFq1Qp9hhi3CRXa67WSLUpO00k9qwp2R8SoPnCS7etBWHgnSZhv4XFi+JlhA2X5OMmCPYoH7qrb+ULzCKDEVRJkp6FAIMgGQTWLOEShibYsAILvHjhvxei5lwHAjFsDlwPNpiM5Amn/FT1G9gjmcAmi4/xpgZGVbvLFfeDmdqByblG6CLPnTACwmRXz5O3Gm2qrnFsZIik8MKhd2zONM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dmZMUVZjS2RBTzlhbysvUWFTQXptcXBZWmdiT3kxbHB6TVJ6STFqcXpPOE5G?=
 =?utf-8?B?aUVhcjJRb3lCejNoYU81eWJEV1RqT1d0ZFk0M0piM2tuNHZwdEtQRWxlcTVC?=
 =?utf-8?B?TkRxOVBFdDZrc2M2L21lNnFGcUhPZUFHWWhVbWpQd2k0UFNoWGRBWnlNcUFj?=
 =?utf-8?B?eGoycWpiajhOanBmaWxlWm5lVUkvN3I5QjlaZHUyOFBCZEVXKzEwOFZOSUtu?=
 =?utf-8?B?S1BTVG9YRC9ac0U5ZWt0MkRseEZwRy94clRZMlovL2xtdTI1VkJNMlRlUUYv?=
 =?utf-8?B?aGdPdmVnVC8zbWdkOXliM3kraytnbEtVOHhtbW5WRUJtNWZOZlB4a214bWF6?=
 =?utf-8?B?UDRqL0Mxb3puYlZ6ZDhDTUFPd253QnRMc3pPeHEvWXF1R1ArK1crVU1YOEZF?=
 =?utf-8?B?dTFCMHBBdCtzTGhtN2cveFBkM0lDcHpGMnlOZVpqdWdrUmgyRG5iSjk1SVRW?=
 =?utf-8?B?MjlSN05wU21FaGZzcmZFblJRdEtqcERjYk9DNXptNzY4WkcyN2lpcnVkL0hj?=
 =?utf-8?B?aGVTRDd4L1FLMWU4Q0VSMkN1Q29VYkJ4UHdrdXNxTkpseU1jTGoweEwvUExo?=
 =?utf-8?B?dlZxRm84RTlUQU5GVUF3OVhlYWZyUHE2UkQxSCt2VWxualI2M2kzMVgyVHZU?=
 =?utf-8?B?QzBDSytrSFA3OU1pVVhINzhRSlZvTnN0VjJFZTFmc3ZmTVU3L1NaaGxzTEZJ?=
 =?utf-8?B?SHdjUWVXd0lWTzNneEVTbldPNnZVN2tlRjVCZHluay9UQkFEZitNSU5tSmFs?=
 =?utf-8?B?WTZDbGd1bE9rbmRMZlhIUmhFanJaeUczaUFmandFcnNQRTlIOXJuUXFmRXYz?=
 =?utf-8?B?UnhXT1dEdmpaVHpnOHVVeGtQRjlmT3Y5cGt0YVFOOFkyeXlwUnJ3bmtIc0ZV?=
 =?utf-8?B?SGpOaXhKcE1NZGVXd0NmMDJWRW1HdVZVb2s2SDVMSzd0bFBQMTltSHdOUDJE?=
 =?utf-8?B?WU1LQjNxeUFCMlBVVVJWeUNoeUFhRDhRT1BuWFdzMFpESHdJeVpyblpGODdr?=
 =?utf-8?B?Vm8vU3hBMWZrUW5kMU93bmlwYTdmSWlzZFNWNzVrbmJIZDlMdlFEUzcyRE0w?=
 =?utf-8?B?cGU4TjBjRGMyMzV1NU92WmFGTVBtak0rV05rOUlsRkl6eXYrdjVOUjJENWVr?=
 =?utf-8?B?Wm9RNXVVQWJrV29DY0JVV2M0ZzUrd2krRmt1TFFyNlJjMXdaSjVxNjdwWlN1?=
 =?utf-8?B?SllaOHlObEZFM0VSZEdrUkxyVExYZVNIbUxtaDBHTUxiRHFTTEFDNks4Q0RC?=
 =?utf-8?B?SWZNeGJmdDdYSHAwNUJ1emFoYnVINnh2Z2JydTdhQVhZcHFFNkppMzR3Qjh0?=
 =?utf-8?B?Y3JmOHV3U1JYK0pnaHBrR3BYOWxGaVdQWnJIZlFwYkxIc0VYNUJXZTAwQ0lS?=
 =?utf-8?B?RTllN0xIQit5M0t6QTUrS2x3bU9Cbm1HcUxxTEVjbFJSLzZzbWtJOXhhazZO?=
 =?utf-8?B?Rmh6azJyVGhEc2dvNDhFNEdZNVZnbUxCUWZqVW5EUDZlK0ljcENxWW1UUUJN?=
 =?utf-8?B?Z3VmTkpPZ0hlaitXUFVYQ0t1MGV2b3V6bWgxck1GVDVCZ2U5cHRXbkhPUWNw?=
 =?utf-8?B?REgyOTJndURRbzhYaFBiaTNjUDhDaEJ0Mk95dldFMEZNampxUEdlSUdCT0g1?=
 =?utf-8?B?bkRxQm02NU9RenN3WHRlMjdLUG1TUzhmZmVkK3J0bmFac2lzNmtnVW5xSkt1?=
 =?utf-8?B?NlFMWUVDUU5KRDRkZldGSkI3R29JWGYzbEoxMG5ONTFUcHNQRzFJNTdnR2pr?=
 =?utf-8?B?WXNjM0RkZ2NmVFB6N3NOSkUrQUtwdHBaVDJBaWRheFUvMU90MnBRK0FSR3d5?=
 =?utf-8?B?L0pkL2g4QWxXREFhNDhyUlVSZVRFa0JJVzRVZUN3dHhrWE5RMmtFMnI2MEZ5?=
 =?utf-8?B?dXM5QnBpSURUcUllRVJWeUQ5VlZnM0xhbUFwcEhFeFpxbjQrK1hqOE9sd2Zh?=
 =?utf-8?B?d0hxVjJYUFZrVmtYSHFGTWhCOWRwNWtRditMc0NZMk9yektRMHMyVW1pQlJJ?=
 =?utf-8?B?dE5XWWIxT0R5TFNUYjdnYWhlbXFCMUdWeDZnS0dvUTdsTjRyNkFxa3FocDFK?=
 =?utf-8?B?QTl0dFBMS2hJOVRNMXJQMHRKeFVoMStWQXlrOHVuc1lIMUF1eGF4c1VWNGNJ?=
 =?utf-8?Q?fxsKKkN/K2gcCixaVFKk+oTt3?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b7cd906-4cf3-489a-bc09-08dc42d033ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2024 20:08:37.1174
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ppf6wBhbcyh24kuoSeYphIZcxPfXLKjMTs614W6pMAnCQocMTFnHVLSOd+jAPPaWHXn5IqhtjFt8T6G7F2zNIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6168
X-OriginatorOrg: intel.com

PiBSZXZpZXdlZC1ieTogQmFidSBNb2dlciA8YmFidS5tb2dlckBhbWQuY29tPg0KDQpCYWJ1IC0g
dGhhbmtzIGZvciBib3RoIHRoaXMsIGFuZCB0aGUgcGFydCAyIHJldmlldy4NCg0KLVRvbnkNCg==

