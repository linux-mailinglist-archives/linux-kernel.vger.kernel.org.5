Return-Path: <linux-kernel+bounces-40637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2986E83E379
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 21:49:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2D6F1F24941
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 20:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DF3724205;
	Fri, 26 Jan 2024 20:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Sn8GwH1g"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 790001DFC3;
	Fri, 26 Jan 2024 20:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706302151; cv=fail; b=coE44FjsKnULg6xuexj5ZfkmFWTJB4cNKDTmdq51LPZfntbTVARDMRyMyKIbecuLUtHj0neEiFjC9BihueGHjTs9X+6HwV7r2OmnXozXdg9CQ8LaqZtPzpsulwQ89jeLe4YVrxoHYiY7WNM3O0CcULLzr+5iOf9k9lEJo7Z9SDU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706302151; c=relaxed/simple;
	bh=7lVWfA7VgWc2swOeXJ1IQYu3nrBttod6FdojPPkVklI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jN3qCSmg1qMr47IBcgDthRCas7m2GsRTVDFGqUmLGgWQ+1eEphmVR5fGmP7BYcDoDttdxrbFrg4mEwWGFAHrpdjgTl/D0QijSLA80ImEqG5b2/HPeFX+fpcBrQcmaCVPndV+LVWvegVasJ4DHY3iRyFpUdWQ8CBAIy87CbFB7dg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Sn8GwH1g; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706302148; x=1737838148;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=7lVWfA7VgWc2swOeXJ1IQYu3nrBttod6FdojPPkVklI=;
  b=Sn8GwH1ggsOW1qyucMSOiUnH1zGtgB5jUlzWUmy++hdojjhHtN0njq5S
   mQ+bv3GXFZQwj55k4Y+vue9p4PPpzj/E8753Q0McxenpTnyNtX7kXCfB7
   IhQ477mTkLiA9aOO4x8hvyQB9VQk0mD81tFgQA1agVNEC2dUkx8fVjrA2
   7pTw5WbtHEeHLLb7p1IORrraNIfHUm4HyhILC67cDDBiweJyGn6ILlE1o
   yIFSb1FzN1k+sbqx3m539VW1PeVyz0Beq+OSu48hOcx+nLVZzGqTjtZqK
   GfB1j43XPm+tl1Gbey4giFM0SVcOKewH3paAqoz3pjdw4RNukPtAQArMl
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="2441291"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="2441291"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2024 12:49:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="787227311"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="787227311"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Jan 2024 12:49:07 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 26 Jan 2024 12:49:06 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 26 Jan 2024 12:49:06 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 26 Jan 2024 12:49:06 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 26 Jan 2024 12:49:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A5SgDDRAaIRuOAcIaeIcM7m9iMWjuLT+UwQa/7UideGglZU6GTXBF47yB/B1Z69IPwhp+fj7WMegjscy39CU/Vyrj43R43DB+A2JP6evHsWT0x54d7o8y78r+986tdtWiHcN28xyiTX8tMmKr2Y1G1JV+4XBQ1IfogyhMaoVMCBVjnwQ8H1gpLMdxUpi1FwxkHudxfF40KjE1eU2og9xSWN2AZS0XJBcmRx9DyYUMrgj2pIs1M9E05Iy7l4PEZfKa8u1ihgxctGpbkbDVV+4Lbah0kXNymDgZNz4r/WQuqggtNSPAZx4BZJY3u4WdhvL0f4bhobTGc0ZJ+wum4LRvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7lVWfA7VgWc2swOeXJ1IQYu3nrBttod6FdojPPkVklI=;
 b=DxfriAlfAtTtNlTu0h6kR8OyO5j5BknxcDtO/dYTB3/S7J7aPiHFQEPbxbINDe6QHFpDMP5L3kFE9pNboCUfq9HmT2flxl1EaQJY/HPBgfhVFvQMk/I4+nx5vG3MT9+HWU22MM6MOFGhOJl3NgnsJU8GZzgY28WeXiT5w+tEDJmcAw7cQxJ8xwWIUGbl7iiohed5S2h2omG4gmKuA9nThko54aDSppzVIRy+FHG1OAUQNlrEAcRRsWhAH8P1dGrRi5ZxVABr7A8InDN7k8EBCbeUxU86LMitAnZd+FrAjuexNb8ics7wuasMMihKMYSUbrfD38vYIEB8QwOVYhUV3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by SA1PR11MB8446.namprd11.prod.outlook.com (2603:10b6:806:3a7::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.26; Fri, 26 Jan
 2024 20:49:04 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::a136:fb19:acde:7670]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::a136:fb19:acde:7670%7]) with mapi id 15.20.7228.027; Fri, 26 Jan 2024
 20:49:03 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: Borislav Petkov <bp@alien8.de>
CC: Avadhut Naik <avadhut.naik@amd.com>, "linux-trace-kernel@vger.kernel.org"
	<linux-trace-kernel@vger.kernel.org>, "linux-edac@vger.kernel.org"
	<linux-edac@vger.kernel.org>, "rostedt@goodmis.org" <rostedt@goodmis.org>,
	"x86@kernel.org" <x86@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "yazen.ghannam@amd.com"
	<yazen.ghannam@amd.com>, "avadnaik@amd.com" <avadnaik@amd.com>
Subject: RE: [PATCH v2 0/2] Update mce_record tracepoint
Thread-Topic: [PATCH v2 0/2] Update mce_record tracepoint
Thread-Index: AQHaT780LVN5GzQCtkupW37k1NP6AbDq4W+AgAACUMCAAQE/gIAAbNLAgAAhhoCAAACOkIAADQMAgAANWGA=
Date: Fri, 26 Jan 2024 20:49:03 +0000
Message-ID: <SJ1PR11MB6083E1000D4B267CF4271135FC792@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20240125184857.851355-1-avadhut.naik@amd.com>
 <20240125185821.GDZbKvTW93APAiY1LP@fat_crate.local>
 <SJ1PR11MB6083DAA7A6EDBBDAF5987A80FC7A2@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20240126102721.GCZbOJCTqTVmvgOEuM@fat_crate.local>
 <SJ1PR11MB60839509241AA98A59B78D15FC792@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20240126185649.GFZbQAccZphdW_0CkH@fat_crate.local>
 <SJ1PR11MB6083E6BF178B9D394BD58DDBFC792@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20240126194522.GGZbQL0gTwpniYGDHw@fat_crate.local>
In-Reply-To: <20240126194522.GGZbQL0gTwpniYGDHw@fat_crate.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|SA1PR11MB8446:EE_
x-ms-office365-filtering-correlation-id: 7f710074-45b2-43cc-5d57-08dc1eb03b6b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rJ+DmSSs04AjtYL5rvFA9dt4/YbNsYCtG8UEVMlCGeEtd2tCF4hJad6SOS8XvSfXHMT0ofNTAlJLcna7xnvd8wiJ6TltH5iBUO+jfyBxIxd0lXQwyzhRFzEK/r8S/D/w988b2V8Byza2bh+pr5wE3bvwYoote7c0tgZsRhjDgMnswF9jsqAzridRr9DE3XgiXkPZM+whS5UqDdbgCHOfhFj4/2WbeeGJJkRP2WdE8vQoxXK0l+vWmKWDQM+RTy+YXgRQkbDVTeMugndKBHuFSxTAci6eytNzhqL+4KixDrqu85V+1UgDpmMgwx/hiBaCT5YQzA8ogKx5D3BhYLyQMgg/DD3TChgcPwy6tyYgN/1jPE9aDwTSGcA5GTvNT9qRkk6ZAt37TCrgjo1ZiAc3Cd80ynZc+u484oKjyEQVye78SLuP437lUWxGh8cQQ72fmAahR48Ym3127urRdkmrozs1gpzUgcWaghXP4YPGJ0H2SOyYtWl7m2JRNsoKAoahICpVl87ZsAj7j7i+BJWexUs1cNDrnjVWmNxQXqhHvdRXqDOfsbRo50LSH1y6wF4ImEAKDzecU6fdJI7oABVtbitdacYso6edtCNWsGUVZC7OZaTqkuLwM5gCbHXtEW/7
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(396003)(346002)(136003)(39860400002)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(7696005)(6506007)(9686003)(4326008)(8676002)(8936002)(83380400001)(66446008)(26005)(66556008)(66476007)(6916009)(76116006)(66946007)(316002)(478600001)(64756008)(54906003)(38070700009)(86362001)(41300700001)(71200400001)(52536014)(33656002)(82960400001)(122000001)(55016003)(38100700002)(2906002)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SEZuczhYZXJVK0pNWWRXMkFscmVicXNPOEphOGI2cTI4K0I0K296NFpzZmtH?=
 =?utf-8?B?cmtHa2lNdi9rMExWK3ZuMHlTNjJiTzl6anBqRkRrd3BHMUZHQjIrbUx5U2NN?=
 =?utf-8?B?MThVK0ZZMTU0Uk9mYUFWaFlNZ3hvVytaQzFPbXVJRXF3UUxzcWZjRUVxTFdP?=
 =?utf-8?B?aHFCWUc2dUZOVFlUOTh1NW44K2xvRGdEeEpYbGkwcE5Qc2Z6RnZ3cE9seDEy?=
 =?utf-8?B?Skx3VUZLUmJVQWxUSXNSeTJRTkdjcDk2YW5rdWpTb1BxTGZaaU1rUFlINnR0?=
 =?utf-8?B?NFhkVVN0NW1PVUNLSTlrd2diNng0dUw3bUVEU3RHRk9uL3o5WVQ0RlcrN1Q5?=
 =?utf-8?B?TlpzSXQwdHVZa0xCYUlEc1hjN0p6UDNoNTBTOVZaU1FyQlczdGN0bGJOTEhk?=
 =?utf-8?B?NUkwYlYzMGhTWEpHanZ2b212S3l6blRCMEZCOG02V0FnZG9zaTJqSTYvanlt?=
 =?utf-8?B?ZEVmeVRSNWRyUTNSN3hidkgyTS8vdTNlcGNKTVZQU1grbWRkTko1Tm50OGo4?=
 =?utf-8?B?OEk1OXVPWE9NTnZvWXc2em92WFgxU3gza21zNVBIMzhzQk9BM0pSaFREWWJj?=
 =?utf-8?B?WEhTTzk5a0E3TXBOT2JMR000aGc3Y2pBbnRKUmdPcnlTOGlLdkhhSFlGZGlW?=
 =?utf-8?B?L0t6YWhJV3dZMitXZzUvRE95c0FmSHg2UEJQUEFWMWZsN0hHNDlMVVlTSTZB?=
 =?utf-8?B?QTBNUzF6TU1vdzZyRUJva1p5T2htd3h6Q1h6NVhUMzdROFdRT25NTmdlSTVo?=
 =?utf-8?B?UkgxMklicUxzQ21Bb0RsVGQ4L0p3ZUZkT0tDK2VFSE1kQ1JER2NGV1FPbkx4?=
 =?utf-8?B?RXVPNVJ0VWdYK1hOMnVGT1JwaDB2b2dHY3VqR1NoWEVSNVV0ejVCeE1KWk5a?=
 =?utf-8?B?SndtaU9yQnF0OUNHQkVOT2V3bENQczZNcnZKTUowYzNuOWVLMDVMY3NwU0Jv?=
 =?utf-8?B?WmRnYlNCS0toVjZRTFBpMXNsTEg2S3k3bnd5M2lsdllGbTgvY2JJK3JPTHZ3?=
 =?utf-8?B?QVVBMFVxdG1HZHR1Y24yVkpWb0UyRnhxaER0RzdCTmVpSnRIdEpBZnFYOTBO?=
 =?utf-8?B?Zi9BMjBnYS9QRkk4QjFGUkRwUmU2MG5hbHVQZWw0dCtKSnpiYUw3TVlybmFS?=
 =?utf-8?B?NjFrNVRWRlBHUnluYXpUSlIxcjdzNW5QU29tajIvazkvanQxZU5Uc1JBSkEw?=
 =?utf-8?B?c2lWY2Q3V0QyYllzczVkY3VYMlhYVnU2Q3NJYkliN2FNOEYzaWlUbXRDNlJR?=
 =?utf-8?B?UndBamJ4Z0cxOVNnUGNQdC82dnNYc3FRYklzM1htU1ZlcG0rRTlzV204c2JG?=
 =?utf-8?B?SUI4ZVNITGM4OWEzVFRNY0FzNnRJRkdBclQ2ZGp3dndpOVMyM3dxTmRrR0Vp?=
 =?utf-8?B?TjhjK0FuMEFVVG5iU280U0thYUx5cWhWZUJZOVJOakdOYTBQWEhFMUtUREhD?=
 =?utf-8?B?TFlhRkJIMTV5RE11WVFTeTN2cmZzYTNwRG9mYWdvUldzbjhMeFpjai92K3Ix?=
 =?utf-8?B?Z1hXNEFuN0M2Z3Ixa2g1c0xoR1VKSXJSbHVhSVVpNUMvSG5jTVRacXZjTG1t?=
 =?utf-8?B?V0l5RHhueUxkSTFHU0t4MGg2bmVEZ0tTaDdzNURRS05zbFJSQmU2L3RMUzEy?=
 =?utf-8?B?TUpjYUFUSzhwc1JvaDFQK1FkR0J1R1Zwa0tVSE11ZlpoQzZUUjZMcFRhMy9N?=
 =?utf-8?B?NVlIM1ZVZjMwaUVJMEpuWWdXUlJlaktsTkVGdWhXN2liaW1LdUdYSzFNeWVp?=
 =?utf-8?B?ZzM5Uk1TSjhkQkQ0NXcvOUIyaEFrby9BUFZTWmRtWVc1VWwyUE9VUW5GMmJS?=
 =?utf-8?B?SENnem1WRWxWMzg2ZkNnT2djd1FvL2hNVHdjQkxRTzZwMWtWNStxWnNTRHZF?=
 =?utf-8?B?Z1JrNE51cldSMi80REhlLzcyRmxCZzliMWJOL2w4Q0M3a1BpMmhucWp1eUpH?=
 =?utf-8?B?V09OMlpqRm9KMXNoNHEzQUhxZ09jQ1prQzB2YWJVQTV6MURJSVdzcUNUdFlB?=
 =?utf-8?B?d1ZBbGN0eWttVTB3RFN6N1E4YithM3VUaXp3eXo3VHUrMFhNRWZiS1J1am1L?=
 =?utf-8?B?SlNPU2hBZjBWMURTbXNoWjhDbUtGT0M0aFFsQzQvUEI2WXNpRW9ZampSNzdI?=
 =?utf-8?Q?amZNdHMab+kA0DQdMrEGYKavC?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f710074-45b2-43cc-5d57-08dc1eb03b6b
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2024 20:49:03.9346
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5wBI8BvWiyDP83oB7q2bUPcfen0zuNezQXks7S73yPJHE3W0V2eD7IpOc/AU5TIscZVXDuEWrllCrxEXMJ0LKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8446
X-OriginatorOrg: intel.com

PiA+IElzIGl0IHNvIHZlcnkgZGlmZmVyZW50IHRvIGFkZCB0aGlzIHRvIGEgdHJhY2UgcmVjb3Jk
IHNvIHRoYXQgcmFzZGFlbW9uDQo+ID4gY2FuIGhhdmUgZmVhdHVyZSBwYXJpdHkgd2l0aCBtY2Vs
b2coOCk/DQo+DQo+IEkga25ldyB5b3Ugd2VyZSBnb25uYSBzYXkgdGhhdC4gV2hlbiBzb21lb25l
IGRlY2lkZXMgdGhhdCBpdCBpcw0KPiBhIHNwbGVuZGlkIGlkZWEgdG8gYWRkIG1vcmUgc3R1ZmYg
dG8gc3RydWN0IG1jZSB0aGVuIHNhaWQgc29tZW9uZSB3b3VsZA0KPiB3YW50IGl0IGluIHRoZSB0
cmFjZXBvaW50IHRvby4NCj4NCj4gQW5kIHRoZW4gd2UncmUgYmFjayB0byBteSBvcmlnaW5hbCBx
dWVzdGlvbjoNCj4NCj4gIkFuZCB3aGVyZSBkb2VzIGl0IGVuZD8gU3RpY2sgZnVsbCBkbWVzZyBp
biB0aGUgdHJhY2Vwb2ludCB0b28/Ig0KPg0KPiBXaGVyZSBkbyB5b3UgZHJhdyB0aGUgbGluZSBp
biB0aGUgc2FuZCBhbmQgc2F5LCBubyBtb3JlLCBlc3BlY2lhbGx5DQo+IHN0YXRpYywgZmllbGRz
IGJsb2F0aW5nIHRoZSB0cmFjZSByZWNvcmQgc2hvdWxkIGJlIGFkZGVkIGFuZCBmcm9tIHRoZW4N
Cj4gb24sIHlvdSBzaG91bGQgZ28gY29sbGVjdCB0aGUgaW5mbyBmcm9tIHRoYXQgYm94LiBTb21l
dGhpbmcgd2hpY2ggeW91J3JlDQo+IHN1cHBvc2VkIHRvIGRvIGFueXdheS4NCg0KRXZlcnkgcGF0
Y2ggdGhhdCBhZGRzIG5ldyBjb2RlIG9yIGRhdGEgc3RydWN0dXJlcyBhZGRzIHRvIHRoZSBrZXJu
ZWwNCm1lbW9yeSBmb290cHJpbnQuIEVhY2ggc2hvdWxkIGJlIGNvbnNpZGVyZWQgb24gaXRzIG1l
cml0cy4gVGhlIGJhc2ljDQpxdWVzdGlvbiBiZWluZzoNCg0KICAgIklzIHRoZSBuZXcgZnVuY3Rp
b25hbGl0eSB3b3J0aCB0aGUgY29zdD8iDQoNCldoZXJlIGRvZXMgaXQgZW5kPyBJdCB3b3VsZCBl
bmQgaWYgTGludXMgZGVjbGFyZWQ6DQoNCiAgIkxpbnV4IGlzIG5vdyBjb21wbGV0ZS4gU3RvcCBz
ZW5kaW5nIHBhdGNoZXMiLg0KDQpJLmUuIGl0IGlzIG5ldmVyIGdvaW5nIHRvIGVuZC4NCg0KSWYg
c29tZWJvZHkgcG9zdHMgYSBwYXRjaCBhc2tpbmcgdG8gYWRkIHRoZSBmdWxsIGRtZXNnIHRvIGEN
CnRyYWNlcG9pbnQsIEknbGwgc3RhbmQgd2l0aCB5b3UgdG8gc2F5OiAiTm90IG9ubHkgbm8sIGJ1
dCBoZWxsIG5vIi4NCg0KU28gZm9yIE5haWsncyB0d28gcGF0Y2hlcyB3ZSBoYXZlOg0KDQoxKSBQ
UElODQpDb3N0ID0gOCBieXRlcy4NCkJlbmVmaXQ6IEVtZGVkcyBhIHN5c3RlbSBpZGVudGlmaWVy
IGludG8gdGhlIHRyYWNlIHJlY29yZCBzbyB0aGVyZQ0KY2FuIGJlIG5vIGFtYmlndWl0eSBhYm91
dCB3aGljaCBtYWNoaW5lIGdlbmVyYXRlZCB0aGlzIGVycm9yLg0KQWxzbyBkZWZpbml0aXZlbHkg
aW5kaWNhdGVzIHdoaWNoIHNvY2tldCBvbiBhIG11bHRpLXNvY2tldCBzeXN0ZW0uDQoNCjIpIE1J
Q1JPQ09ERQ0KQ29zdCA9IDQgYnl0ZXMNCkJlbmVmaXQ6IENlcnRhaW50eSBhYm91dCB0aGUgbWlj
cm9jb2RlIHZlcnNpb24gYWN0aXZlIG9uIHRoZSBjb3JlDQphdCB0aGUgdGltZSB0aGUgZXJyb3Ig
d2FzIGRldGVjdGVkLg0KDQpSQVMgPSBSZWxpYWJpbGl0eSwgQXZhaWxhYmlsaXR5LCBTZXJ2aWNl
YWJpbGl0eQ0KDQpUaGVzZSBjaGFuZ2VzIGZhbGwgaW50byB0aGUgc2VydmljZWFiaWxpdHkgYnVj
a2V0LiBUaGV5IG1ha2UgaXQNCmVhc2llciB0byBkaWFnbm9zZSB3aGF0IHdlbnQgd3JvbmcuDQoN
Cg0KLVRvbnkNCg==

