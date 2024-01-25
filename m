Return-Path: <linux-kernel+bounces-39175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAB2283CC0F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 20:19:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B0891C22651
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 19:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75CED1350EA;
	Thu, 25 Jan 2024 19:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Hclk5Qgz"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E66061B945;
	Thu, 25 Jan 2024 19:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706210371; cv=fail; b=rbMpsGQYzDrI892ED7h5c3EIERF31rF4BbaBi5FhYq3cM3oVDahwIRgC9OS+j+IaMyBZlsqYOCaad+nxB6KC1Z5ENL8urjkD6PFqQMCRRXLOLG4Vs4/XW92xsc+sf2kfGjM+gCbwz6QE5FPSxSEFFjZkiE4zMAJyaU+LoiqqX0s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706210371; c=relaxed/simple;
	bh=SFMBRex06JsRqXqcjA40/t/H/E0ujlt0eKwZikCfurk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TuBflRR1SQdmJkL83wEtIe2VEI6aQdpxFs3Y0v7Xv7PYRX7gsnL0aO7kyAOBGT+4S/xV2goaBPi86wLxXXTzHXMmR1ZBSJVBw+kjc04EefmP7w5jfLxOMdcl1pm9GRVudCf3lBpyxoZ0ehvDeX02Juc4FrJbQegmRYTT72SsZxo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Hclk5Qgz; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706210370; x=1737746370;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=SFMBRex06JsRqXqcjA40/t/H/E0ujlt0eKwZikCfurk=;
  b=Hclk5Qgz1LeqbUY6sPlW7/thjE3qDXkL4I/CgpMtHXS89r9LFUutXMEz
   6kowU6aNDZs6Dej+qhZj9ftJaYk9TNVbwgPeBiysVAaTvTc/WqQldcVRW
   Yklq55M6z9rt47yPkPT8B0V5j9EIovSQ8QOaijaCJy+nLTbJO8Sqr8NuM
   hkbKUh3I+DfMpIk70oOqmKZ97JxcmwiQNxrqIoAC+i3/BkWDp3soCt9GV
   7IFKYxPvDONgY3gr5hQxhc3xjvDm6xI3uee5X297TQmPBQTq0GbMnoBA6
   H+AZSeOUdvH2CD+dlJq9zsz0TIqkYHOW2WN7JcTniftl+jCpG9V0CBmxJ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="8951327"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="8951327"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2024 11:19:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="28865217"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Jan 2024 11:19:26 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 25 Jan 2024 11:19:25 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 25 Jan 2024 11:19:24 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 25 Jan 2024 11:19:24 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 25 Jan 2024 11:19:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mSiqPArmzVlssqL8jnoU1ykVrFkaP/rE1esTcVnSXGUORTEoodnwPLj7C+nP6/Q3xyOFPWHibtcj2UqCC83RlZJdhOfqrZMOsTpxDr692stj2Hm8j8rqWnBKz2XjT5KGfdZtThcp7ke6h5hGX4QdPHh5Z3c8BAr1EhpHuWtWuleaku4N2ncZ+tr4LAI3glVfZnqEsJp7Z/v96FcqwEbJOp9yGfsuRjCkqQkJkVKZBGu3QCn0j1qpFn/rBLAX7f0/wE7C/nc+B/jBCMjeBJ4JT5BL8nWf/okofow5nkLC+wFjZGksXnuOofn9R09YqQjyW63F8PisuPQW9asYlNazOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SFMBRex06JsRqXqcjA40/t/H/E0ujlt0eKwZikCfurk=;
 b=Zk1LtQmBsb8q2dmLxDRYQeZ5VM+lQ8t19U6jwkyrymaVPWzI+UFrVWJhQNWZekzfQIWuLFF+BuCGtkPot4R+Rng5vamZ86w6y3edNC0ske942Q9dU43kskF2ZW2bnBbdUHlr+3SGCXeg/+XIT1oylXijcsIaCR1QyVVTlAnfPRH6ABqnAHmRpDjOvbgW1cQAm9ubPevvYdMeWXGDsO4nliTSvnFzgqHFMxtGawXEv96d//j75XfinDvvMR4948jS0TPGWxyv/mmzD2kiuskZU7dD/8OTK1f56Y3pgOpJuwTCmsk+7eL9U4m5OAxKJ5317ql9SGjzYQKj6HZA2ZOQSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Thu, 25 Jan
 2024 19:19:22 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::a136:fb19:acde:7670]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::a136:fb19:acde:7670%7]) with mapi id 15.20.7202.035; Thu, 25 Jan 2024
 19:19:22 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: Borislav Petkov <bp@alien8.de>, Avadhut Naik <avadhut.naik@amd.com>
CC: "linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>,
	"linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>, "x86@kernel.org"
	<x86@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "yazen.ghannam@amd.com"
	<yazen.ghannam@amd.com>, "avadnaik@amd.com" <avadnaik@amd.com>
Subject: RE: [PATCH v2 0/2] Update mce_record tracepoint
Thread-Topic: [PATCH v2 0/2] Update mce_record tracepoint
Thread-Index: AQHaT780LVN5GzQCtkupW37k1NP6AbDq4W+AgAACUMA=
Date: Thu, 25 Jan 2024 19:19:22 +0000
Message-ID: <SJ1PR11MB6083DAA7A6EDBBDAF5987A80FC7A2@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20240125184857.851355-1-avadhut.naik@amd.com>
 <20240125185821.GDZbKvTW93APAiY1LP@fat_crate.local>
In-Reply-To: <20240125185821.GDZbKvTW93APAiY1LP@fat_crate.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|SN7PR11MB8066:EE_
x-ms-office365-filtering-correlation-id: 073cc3c9-1882-40b6-de3d-08dc1dda892e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ubHnMHlL/oI/R7CROYNu5mWrjnYxAQ5/rj0msBFywAnKRB7DttDCcS+d5zY9rGGF80j9xJsgZN5Bg9OzOU3fjpRsCfs7IHYJI070vBVnvfl71I7qhjIBWcTHlyprnVGNGm8FFRiWHh4RcKVw6YlBaxhbh86kcCLSck2/4G5avjbQznhghcOI6xwGEpdqp/TrPBs9+gifM3FLMXnAbAbkIYVm6SqWMrnF+MQf19sMBP1CbIe/wAwBgw52IJh7LSM51Nj/pNnbN7r3kOKibUJLXfKxVKApyEJqAtCX8Ts6W5+LWqXHygST3L+aeooUTPiRqA5ezRnOgVU2JrMm+M5oVJhTFneDDL7ejVO56Ib4X3Awj8EpW6sFsqWQ/+HOYzUnr64Rc0HNuH7tor5z0jkFb+0z9EiAZFLJJjRqvYwjFRF+CF9RZRkWSXh32T4GkDbVm97s8JvtOPSqdReSXoPVKAEpfO0UJmxdwIUF5toitzywwrbjbykfvs/GMssidQwvRlSL2MuNiJWO33XHY2itu8Edp+iybKYxLdVrIlmqOgfU3DhG5UquEQJqUXWPk5UbChJ2ADSw0PqxD8X1zZ8zZgSuAgJmCvswS5+WtUCG0rXOW7BMuzHOoKJcJ89vT+pT
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(366004)(136003)(396003)(376002)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(66446008)(64756008)(54906003)(316002)(66556008)(66476007)(110136005)(66946007)(8676002)(76116006)(26005)(7696005)(33656002)(478600001)(38070700009)(71200400001)(41300700001)(9686003)(86362001)(38100700002)(2906002)(15650500001)(122000001)(82960400001)(5660300002)(6506007)(52536014)(8936002)(83380400001)(4326008)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TDl2djhMY3FaNmM0TFo5YnFqdWdXWENRRlN2RWE1bUhIajBmUG1yeEdneDhG?=
 =?utf-8?B?ZVJaRGZmOFNpSEdJYkhQL09PMU1aVVh5dXBxYVE4ZnozdXdhTTRiZ0NublR0?=
 =?utf-8?B?bnZlS1drTFlLQTlMaktSdmRpaG5BbUR1UWpPSWkvc1N5Q0toT0NpNGRMeFVa?=
 =?utf-8?B?b2FwNHJnVHRPOHhMc3lkYmJhaVdJRHdnbzFGVXk2NlpTYytJVmZDK1plNytx?=
 =?utf-8?B?TUJRaWVXaVdjYWMwbXVPYXh0TGwzTVloV0xJWTBiQlVBNHh3RTFGN05ZcTc4?=
 =?utf-8?B?Vi9BcEZNLzVsRFMyVVFqVk8wSEhlTE4yQWJ4eWRWLzY0dG9ndCt3N3NrbUc4?=
 =?utf-8?B?clYwWHFKb1hpM0w0ZGI3ZExTaHZ2dktnQmRCcHBFTUNHay9MdUhQeEdpVGEw?=
 =?utf-8?B?Tk1GdXhRUjJhZDZXL0lOeUd5V2FXT2VKR0taY0VLUy9UZW9NRFIyM2lYZHZC?=
 =?utf-8?B?dis5emg2ZEVLZ2FpbFJ1ckg0T1FRd2FsQTRBM3FMcGFXTlZCdjh3Y01TT1Zs?=
 =?utf-8?B?c0x0ay8zdFVZY0xBcm1tOGFmbDZlWUJwN29xdTFjL0ZoYlh5Q0VQa0JPRWhK?=
 =?utf-8?B?K2ZacnFlTGlHL1ZLSnZOUTg3c0J3K0xWZUhtajB5QXloMnM0QXhNMGJpdXZu?=
 =?utf-8?B?dHc3aU9nb3NuV3MxT3BjVk9jNHFQM0daeVlCRTFtckJCOTBVS2RpYWYzaGtO?=
 =?utf-8?B?M1dhazZXdHFDYlYrdVAwUUhIa1FJZk95dkxjYThtcitCQk12WURRNVhZclhR?=
 =?utf-8?B?REJUeXlIUjV2TFVLaXloOUttUEh1MS9SVVhUTTBBcHk0VWtKUHppbEhGVElo?=
 =?utf-8?B?ZGRlYm9adWJTYU05SlVBN2w1VGZycHpIME45VkhjK2hKTGV3TVEzZWtCVVI4?=
 =?utf-8?B?M0FRU1VVU1piZEhvdlZWOGpFOEw0c3paNXFIOUwraWlMREFkUnRLRjR6OHBZ?=
 =?utf-8?B?VE9PTEt5SVF6YkowWmNXMXBDS3ZyUXoxd3Uwd0lkYWoyOU54c2xjL2JTWTBS?=
 =?utf-8?B?R3Irb0NaM1pSME5EQVh1VVEwdnZZNFVFZzREalV3ek9kbGNlYVZMUXQ1L1oz?=
 =?utf-8?B?dlduUzFFZlF2NlBtam9KMFlrTERLUHJkbzA2Vlpqd0VSQ0RCazRyRnliTktD?=
 =?utf-8?B?ZWFzVWNuOEZOay9ERlJrRlFYU1h4R0Rkd2NmNnRuM1JXSFRvd3ZsbWZJczIw?=
 =?utf-8?B?Rk1QaVU1MTY5cXBJai9CS0ZqblNMUXprQVR1bnIxYWhiQkduU0tnQ1RySi9i?=
 =?utf-8?B?MnFCV3FMZ0dBVkpsVVk1RG0wNWFQOTVtSmVuaEZhMTFZMmw5M1Vydm4yS1lq?=
 =?utf-8?B?M0M1YUMrL1hHYzdVeU8yMHQ3c05xUnhkNVFqaFhjWHJiM09QSTh4dkJZSllB?=
 =?utf-8?B?OSs0T3l4c014Qkl6bUJNUjNCWkZIcUhYVXo4aFc4eHVvenVWekU1RW9KN1pi?=
 =?utf-8?B?cmgzaU1NaWJSK3NoSXVsZk1SSENVTGNkTGVMMUt6Q2ZESm40MS91ZUc5WWcz?=
 =?utf-8?B?Ynd6Mm9reDFudUVjeHEzang4ZXA2UnhEOWF6cXNxcWlpYmtXbVVCbkhwejBv?=
 =?utf-8?B?YUpQQnIxNDZ2RkJrVG9RUmxQNUZReElQMytndk14TVBXbmYydTVjZXJySGtO?=
 =?utf-8?B?OGp4dlV2VjB6VmFhMlRETXlLcGVSVFpvSTYwK2plbmwvbFQzUWx5RDBERmZm?=
 =?utf-8?B?cy8zczlEaDlZVnl5MkFnY080SUt6VWw2aFcvem43Kys1VENnN3JVZjVORUtH?=
 =?utf-8?B?eTExSVEvQyt6ZU94ay9TbnhkQXZMUnVaRlA5VUhIK1NIMCtEdE8yUUtqUk5D?=
 =?utf-8?B?dXEwWmV4Ri9xNGx0a2JkMEN1UVJlTEJLNDc3ZUx1RTdkZTkvM1EwSUgxRkQ3?=
 =?utf-8?B?V045cEUwY091L2EzWWpyTEFGcnE0cWtDVlYwNjdCNVVJWEFHSjBST3NSNXdz?=
 =?utf-8?B?eERHWFdrNEN6OG0xakhzd3hvYWJvS1lXZ0R2ZFJobG1OMTI2UHFjY3krV1hh?=
 =?utf-8?B?R3UzVWdteWUrcC9aN0Fja2xuSThLYjZVTzZQb3pjT3daTWREVVdpRXRZenhM?=
 =?utf-8?B?T1dTelg5TEFPVzFraTE3MWNobFFjRDhoMWJxdjgwbzFhbkc0eG1xdjEzZGRp?=
 =?utf-8?Q?PvDH2SXfrOBv1Ss9rVNUFCD2T?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 073cc3c9-1882-40b6-de3d-08dc1dda892e
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jan 2024 19:19:22.1252
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l+LmSf0dE+KJ3+IrMWuERkDt1zib3R9rwL5FCHjjiXLmCnWyJ5ujHPOjIbDOygqLlCtBXYu8gmQZYqou2WhzfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB8066
X-OriginatorOrg: intel.com

PiA+IFRoZSBmaXJzdCBwYXRjaCBhZGRzIFBQSU4gKFByb3RlY3RlZCBQcm9jZXNzb3IgSW52ZW50
b3J5IE51bWJlcikgZmllbGQgdG8NCj4gPiB0aGUgdHJhY2Vwb2ludC4NCj4gPg0KPiA+IFRoZSBz
ZWNvbmQgcGF0Y2ggYWRkcyB0aGUgbWljcm9jb2RlIGZpZWxkIChNaWNyb2NvZGUgUmV2aXNpb24p
IHRvIHRoZQ0KPiA+IHRyYWNlcG9pbnQuDQo+DQo+IFRoaXMgaXMgYSBsb3Qgb2Ygc3RhdGljIGlu
Zm9ybWF0aW9uIHRvIGFkZCB0byAqZXZlcnkqIE1DRS4NCg0KOCBieXRlcyBmb3IgUFBJTiwgNCBt
b3JlIGZvciBtaWNyb2NvZGUuDQoNCk51bWJlciBvZiByZWNvdmVyYWJsZSBtYWNoaW5lIGNoZWNr
cyBwZXIgc3lzdGVtIC4uLi4gSSBob3BlIHRoZSBtb250aGx5IHJhdGUgc2hvdWxkDQpiZSBjb3Vu
dGFibGUgb24gbXkgZmluZ2Vycy4gSWYgYSBzeXN0ZW0gaXMgZ2V0dGluZyBtb3JlIHRoYW4gdGhh
dCwgdGhlbiBwZW9wbGUgc2hvdWxkDQpiZSBsb29raW5nIGF0IGZpeGluZyB0aGUgdW5kZXJseWlu
ZyBwcm9ibGVtLg0KDQpDb3JyZWN0ZWQgZXJyb3JzIGFyZSBtdWNoIG1vcmUgY29tbW9uLiBUaG91
Z2ggTGludXggdGFrZXMgYWN0aW9uIHRvIGxpbWl0IHRoZQ0KcmF0ZSB3aGVuIHN0b3JtcyBvY2N1
ci4gU28gbWF5YmUgaHVuZHJlZHMgb3Igc21hbGwgbnVtYmVycyBvZiB0aG91c2FuZHMgb2YNCmVy
cm9yIHRyYWNlIHJlY29yZHM/IEluY3JlYXNlIGluIHRyYWNlIGJ1ZmZlciBjb25zdW1wdGlvbiBz
dGlsbCBtZWFzdXJlZCBpbiBLYnl0ZXMNCm5vdCBNYnl0ZXMuIFNlcnZlciBzeXN0ZW1zIHRoYXQg
ZG8gbWFjaGluZSBjaGVjayByZXBvcnRpbmcgbm93IHN0YXJ0IGF0IHRlbnMgb2YNCkdCeXRlcyBt
ZW1vcnkuDQoNCj4gQW5kIHdoZXJlIGRvZXMgaXQgZW5kPyBTdGljayBmdWxsIGRtZXNnIGluIHRo
ZSB0cmFjZXBvaW50IHRvbz8NCg0KU2VlbXMgbGlrZSBvdmVya2lsbC4NCg0KPiBXaGF0IGlzIHRo
ZSByZWFsLWxpZmUgdXNlIGNhc2UgaGVyZT8NCg0KU3lzdGVtcyB1c2luZyByYXNkYWVtb24gdG8g
dHJhY2sgZXJyb3JzIHdpbGwgYmUgYWJsZSB0byB0cmFjayBib3RoIG9mIHRoZXNlDQooSSBhc3N1
bWUgdGhhdCBOYWlrIGhhcyBwbGFucyB0byB1cGRhdGUgcmFzZGFlbW9uIHRvIGNhcHR1cmUgYW5k
IHNhdmUgdGhlc2UNCm5ldyBmaWVsZHMpLg0KDQpQUElOIGlzIHVzZWZ1bCB3aGVuIHRhbGtpbmcg
dG8gdGhlIENQVSB2ZW5kb3IgYWJvdXQgcGF0dGVybnMgb2Ygc2ltaWxhciBlcnJvcnMNCnNlZW4g
YWNyb3NzIGEgY2x1c3Rlci4NCg0KTUlDUk9DT0RFIC0gZ2l2ZXMgYSBmYXN0IHBhdGggdG8gcm9v
dCBjYXVzZSBwcm9ibGVtcyB0aGF0IGhhdmUgYWxyZWFkeQ0KYmVlbiBmaXhlZCBpbiBhIG1pY3Jv
Y29kZSB1cGRhdGUuDQoNCi1Ub255DQo=

