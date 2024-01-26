Return-Path: <linux-kernel+bounces-40711-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4898483E472
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 23:03:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DECB1C2282E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 22:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD21E250F4;
	Fri, 26 Jan 2024 22:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lmhokE++"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A0625547;
	Fri, 26 Jan 2024 22:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706306601; cv=fail; b=g0t88L73t6qWMbUsfeBSq5Z243D7gA8IlfUhAztgT1dMyF10KEqXOgDYKrBnmKXuWQwlznWc8ASGJ+mlGP+kvovIWZ/jNkn1Pi88N2yLYXOX4nr1yIqiKSdDvFafZ0Di+SKnDOOWrHB/y94WQAhRF6bfN7qUMeL9zm/0CvV2BkY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706306601; c=relaxed/simple;
	bh=2Rb0IDiNHcuKZbqL2YyqKWD+RddVwdaJwkVoQxjN6V0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JuVgOwSfFSnTNBgwQ5yRM8R0hGfL27/QBZfRKBsEvGzQ+3S6viRg3CeZbFAArEkIRD08wgX4/XoBByqYiK4sZO21WpsXThMVjubxU0+2Hfwliw4Ih9g0G9aHGIDbsmB3WQJ3GjJEFiMUmlRxM1H0TB3PvvftN6U3IWTVrid4ry4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lmhokE++; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706306600; x=1737842600;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2Rb0IDiNHcuKZbqL2YyqKWD+RddVwdaJwkVoQxjN6V0=;
  b=lmhokE++oe+CHEAdOXJuMQU/ggEI+o6zYciHF7FtLt5hwwd9NNIJclVo
   uSve7oVcSObV3Qo+uSIZehuVuq/ChLBIyHf254sKihGQqkbWHvA8o+anA
   Y3kJhJm5ZMWW9MXcR0AQw55f+3wf2UBYZyb3AiZ1kbcY32nRDVoqRCneM
   1fluIwbqyfQJLRHI1q/z1AsNx5xop18CqbpJDfvEHxT4zvrwkdLCJiiyE
   QGafiLgvfRpmnZcriqqGZTMP/HzQZZEdul2KAhp5DOncOJY3LV5EkxLUI
   7bsClhHUcI+oztgaJuP323Hru/U5QxjsVDp/jWDkI1gbEpLbMqlZUf/cP
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="9272614"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="9272614"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2024 14:03:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="821265536"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="821265536"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Jan 2024 14:03:18 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 26 Jan 2024 14:03:17 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 26 Jan 2024 14:01:33 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 26 Jan 2024 14:01:33 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 26 Jan 2024 14:01:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LCW48j8IU4O0QRQMi9/KjhK5dj7std08QobxNEQXcJAVmgCdMXhozdJfyb47pj07IsVM46VQGp9fwBb1an1LV/8GFi7zYsqxyzl3JbhxUj4fArHbSo720H6gzm7BPLV7zWWNeHCPmsmnJ0YoXpLW6pjCruwpCkKymJdOrziGadWKZCLdfLcNOr4fFhlJzX+1dE9AwJcszsJw5ZMT21jXrfGdiee7dXW28AXs58JK7iJwN9vzkXc/b0QwaUfmOvAkcJ1H39jwGoQZ5aQMmoN8UnpRxPJq+z++OOHlWcKo3+YBsepRmEyTW74zPMLi4454E8PCDczu+izX5o9YK6wKIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Rb0IDiNHcuKZbqL2YyqKWD+RddVwdaJwkVoQxjN6V0=;
 b=A1UwRLJf9KTyr4fA/m3RbuvqIcPeb1JtmNSxG7STREmQMJF/GAMNbDd5QiSkcnCWQohpqrccHyAzb3b9lFtueGwaixWIgQ4bet3Te7lTQAw9fiaaPyOt/RI3Wbrh/JvYauskByeIH1CtF4zTBptonkvvgkhX9jGTczmVPFUS3+1KKuPySf7aEpuIKINb0IFjQBkc0LaBowo8AR32q6TPITApjyzvY51UL3kpk3aHV8EVGXac60n5h+r0wx4CbHNf3hXn9pMp7v8az5XzFziYAZ8PsyIGYoKfSWnZBYn/rrUwLFNAzSHp4pfMwP2jNWMIK5PF6ME6EDzm/TPvmA9uvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by BN9PR11MB5241.namprd11.prod.outlook.com (2603:10b6:408:132::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Fri, 26 Jan
 2024 22:01:30 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::a136:fb19:acde:7670]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::a136:fb19:acde:7670%7]) with mapi id 15.20.7228.027; Fri, 26 Jan 2024
 22:01:30 +0000
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
Thread-Index: AQHaT780LVN5GzQCtkupW37k1NP6AbDq4W+AgAACUMCAAQE/gIAAbNLAgAAhhoCAAACOkIAADQMAgAANWGCAAAq8gIAAC4Xw
Date: Fri, 26 Jan 2024 22:01:29 +0000
Message-ID: <SJ1PR11MB6083B9CEE1398878664D90F7FC792@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20240125184857.851355-1-avadhut.naik@amd.com>
 <20240125185821.GDZbKvTW93APAiY1LP@fat_crate.local>
 <SJ1PR11MB6083DAA7A6EDBBDAF5987A80FC7A2@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20240126102721.GCZbOJCTqTVmvgOEuM@fat_crate.local>
 <SJ1PR11MB60839509241AA98A59B78D15FC792@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20240126185649.GFZbQAccZphdW_0CkH@fat_crate.local>
 <SJ1PR11MB6083E6BF178B9D394BD58DDBFC792@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20240126194522.GGZbQL0gTwpniYGDHw@fat_crate.local>
 <SJ1PR11MB6083E1000D4B267CF4271135FC792@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20240126211133.GHZbQgBfqX4Qkdbmu_@fat_crate.local>
In-Reply-To: <20240126211133.GHZbQgBfqX4Qkdbmu_@fat_crate.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|BN9PR11MB5241:EE_
x-ms-office365-filtering-correlation-id: ab303f65-0d6c-4327-bcbe-08dc1eba59d6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 73IeuQC7k72CjefkhZMCHMrH9qkLMCW1WWHOA7kF399vdp66zt1fM1XBa6PmPsyOUUJp/pcU7piZI8wBMWtxM1s9QWdS75/tXDJ6eoccssMLRPPqrBj8/SZP9Jd9us6Qj9kXzS3PbZjuBTEyG1HfVSKLjxT4LY29TrX4ITuGMjpMuQ8mdd7ioAMKqlKnUnaBTW8UHT+JW7ufZwReg65xWGth6f5v2UAtA3ZI942jUwJgNgZECx1jnDCh5p2cCZ4vq92V+8UafFItV0xgMY7xkrpHOKEQB6tVuk+kYgZc28tRCL0y+xtqhYNodDJWj0lqYRZY/qIe+ErF18oZ8xpIE2l3j2Ci8e2w8BYwiomlVlK/U2KKEyFRvKauY8P642TuC3U+r0/YdWsPzFLI6yXqZknsOyYo+jJgHzorB0fZ2QMgNRlKxh7wxXaZoO+BLRhNvV5ISSk1JT/zGwK6ChBfMoNe9URsBwccQkGH7388vJoR0+i6A3jkbwznK7dvF2MlkVutce3eNw7HuDDBMA50jvT73rElVJyL/Ca6l9Cjr+yL5nQXqyFIgbo3qqnLWhn7HqTPrGxkluYFbl5H9GsV5y8FMnVbOBPnmpP1wMa6ASK23hKAC5t9BIL+z9Yxkpro
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(376002)(39860400002)(396003)(136003)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(5660300002)(15650500001)(2906002)(41300700001)(66476007)(8936002)(66946007)(66556008)(316002)(66446008)(54906003)(52536014)(8676002)(55016003)(478600001)(71200400001)(7696005)(6506007)(6916009)(4326008)(64756008)(9686003)(26005)(83380400001)(76116006)(86362001)(33656002)(82960400001)(38070700009)(38100700002)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SGI1emNoV01LTnBnVDBBQUZQbDJSVW1iM053VElub3plNHZmRTBkYXlmeTBI?=
 =?utf-8?B?MWprbG5oSkMvNDZVQ21BN2t0Q1ZXZDNPZWRPaHBpVXVHdmE5VkhmY1l1RDky?=
 =?utf-8?B?RVg0Vmp2UFJzcFF6YzdnZjFsYTJ2VFZOMzJiOTVrU2cwYTFJc0x0ZlpISXRz?=
 =?utf-8?B?NnFPRlMwUlMra3duVVhYZ0JiQjZjbUFJb25uU3FMVG5Wcm0xcFBoNlhXZUp6?=
 =?utf-8?B?NW5ERStOZlBiNmxJWFVTb0VSc0FScllpOXRVWTBINmhzbkVPcHdUTlo4YlFW?=
 =?utf-8?B?Z3FUaWJORS9RTEYzYTVMY3hWS3NWd1dBTHg5OWxKTndmZDJnaTl3Wk84Qnhu?=
 =?utf-8?B?VUFlYlNjRlQ4enFFb3oyVmRoTEZwSVJGVm9lNjJndHEzVDBvMTNRQ2xzYlhi?=
 =?utf-8?B?eHE0eWFMS0xMVlNHcjd6K0lGTWVwNWtRWTQrbC9GQS8rcGRmUzVhcGxCT1M4?=
 =?utf-8?B?TGVuVU9xYVlLOW4vaktCLzloQlYvYlRobC8xN2ZyakEycU55U2lNSVZsTnRK?=
 =?utf-8?B?U2NsOTZ1aUNlaHQrVzFzRDRkTCt0UENiZ0xzZXZxb2l2NVlHSU1iK2M2YXIr?=
 =?utf-8?B?Vm9DdEFadm1JdWJGTmZzc1krSDBsMDdlajdodzEvR0NrZGV4Ti9IeFo3MmRp?=
 =?utf-8?B?Z2JDZ3BBVDlRSFhWNXZGdkE5RlorUmFKU1VJNEVvZkdmVjVTcncyTGtTalQv?=
 =?utf-8?B?RzZuUUpGRjJwZVNwMUxycCtJK2ZRd211Y2d0TjZrd1lsYUdNaFk4R2JjaFdU?=
 =?utf-8?B?RFhhZ0dSMFR6dVZ3YVZDUlNqWlNteVRqUy9NenlnSW1KRTJqbzNqNlJSS0NC?=
 =?utf-8?B?ektzQWlNUXJXbkVKT2pUaWc5T1YwQ1BQOTVMVlZMckdKSWJtYWJ5OFgvV2dE?=
 =?utf-8?B?d0JqeHRVVWtMZS9PckZqemNjWG54OGVNQW40Y1hHbkV4NGJUeWtpM0wzK3VF?=
 =?utf-8?B?a2M0RkZRTnJ1N1NWWmhvY2grdGhzRTF6OVlmQmtaU2JIdUZIRmxpNXdham5Y?=
 =?utf-8?B?dGdCTVlxK0pwcXhsSGl1MS9sOGpwWjJBTDdIMTVqKzNueDRmMzl5NTVvZnpI?=
 =?utf-8?B?cU0vbnJ3ZUpQRG1vOEl4VkEwcEwwaGFPa3B1NUVRMkJiaWhnZlQ2bjRYY2sw?=
 =?utf-8?B?eEdPVmFmaGNwWjcwMUVBUlozOTNVcTZvZFpTOGlJU0kxSUZuNWtNbi94NUUy?=
 =?utf-8?B?Q1BZZnBoZENyOGVVc2J0NnQ2K3JKZHNPN3duditITGFUeDlYejZqVjZRZVli?=
 =?utf-8?B?Qms2OHc1NTVkQVhFSmZweTJhZUQ4ZWJUcnBDa1VNWVpEejlHd1RYMUdWS0NE?=
 =?utf-8?B?eFBzZE1LaktEWWpieTRNSStrMEhXSERWd0VKbDJLL3R6SUR5V1IvRW5mWVJ2?=
 =?utf-8?B?Vk5oY2hSTStTVE92ZGpabE55c0NYRFNDREJEaW1yNXRjSmV3U0lYWFJDa2xL?=
 =?utf-8?B?Z0dQbGMwNnJtckNZZkFjcUszNmNLbEpReTR0YnBCQjhqeW5oQjFnUmVrb1VR?=
 =?utf-8?B?ZzMyRTJlYzI1V3l5RFYxMWlueW4xWFpta3lCMWNsRFFLS1IyQmIxVTFIRzZB?=
 =?utf-8?B?aHpkUlNJa1JGQXZQZmJXTm5MMUJIeUVwRTVRN1BVL0orQW1JbkpDSlFnNjFi?=
 =?utf-8?B?M0lRU0l0ejdwYmd1ZHpMOTBuSHQ3UlBXM2VNZHpySVV4dDBFbGpSekFDS0pn?=
 =?utf-8?B?ekZPVFNoWWo2VzdWTlMyWGNFK0NDVTJ6bGJWNXUzRlJ0Zy9hSEloR3pzVGRX?=
 =?utf-8?B?ZGxKL0xRWmdrUTVwR0xHdXQ5YnJnMXhpQi9qcVhBNHh5MVhMK0p6amxwdU5Q?=
 =?utf-8?B?RU1ESnczak9LTklZT1R5S3g0SVF4Q05HZEhZWEtpUmdCQVg3dVpFU2orbGJa?=
 =?utf-8?B?RkhVYVhmT3RMb0E4UUQxUUg2NXBvSm1LbmZXa01Ea3lWQlRaOHNrRnM1UVE3?=
 =?utf-8?B?R1M5MFNMcUc3Wno0aTdQRXJUY01rK3M0bDR5OHkzc3B3WU15RGwzMWZDZ2lJ?=
 =?utf-8?B?RERvSkk0Y0JYUkN4NFFqNThWM3o5cWUwUklxL3BNYW0raElRK0hiaVBOT0l0?=
 =?utf-8?B?a082UnlpTnlhNnFPNzZlZWI3QU9mK2Y4S05nK1BGc1ltb1lqbVNXWmFkcGov?=
 =?utf-8?Q?Y+OG6G9oRw888JztAoYPn4Afs?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ab303f65-0d6c-4327-bcbe-08dc1eba59d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2024 22:01:29.9610
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QZLpl5pV8pWbT9uRNm9PXCu6QJsrAjv1s+KUy5gXh9QcbSQKQhrKmvgSD7stcdVZiR8lMI9z3qjprWI+9ngrKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5241
X-OriginatorOrg: intel.com

PiBCdXQgbm8sIHRoYXQncyBub3QgdGhlIHJpZ2h0IHF1ZXN0aW9uIHRvIGFzay4NCj4NCj4gSXQg
aXMgcmF0aGVyOiB3aGljaCBiaXRzIG9mIGluZm9ybWF0aW9uIGFyZSB2ZXJ5IHJlbGV2YW50IHRv
IGFuIGVycm9yDQo+IHJlY29yZCBhbmQgd2hpY2ggYXJlIHRyYW5zaWVudCBlbm91Z2ggc28gdGhh
dCB0aGV5IGNhbm5vdCBiZSBnYXRoZXJlZA0KPiBmcm9tIGEgc3lzdGVtIGJ5IG90aGVyIG1lYW5z
IG9yIG9ubHkgZ2F0aGVyZWQgaW4gYSBkaWZmaWN1bHQgd2F5LCBhbmQNCj4gc2hvdWxkIGJlIHBh
cnQgb2YgdGhhdCByZWNvcmQuDQo+DQo+IFRoZSBQUElOIGlzIG5vdCB0cmFuc2llbnQgYnV0IHlv
dSBoYXZlIHRvIGdvIG1hcCAtPmV4dGNwdSB0byB0aGUgUFBJTiBzbw0KPiBhZGRpbmcgaXQgdG8g
dGhlIHRyYWNlcG9pbnQgaXMgcHVyZWx5IGEgY29udmVuaWVuY2UgdGhpbmcuIE1vcmUgb3IgbGVz
cy4NCj4NCj4gVGhlIG1pY3JvY29kZSByZXZpc2lvbiB0aGluZyBJIHN0aWxsIGRvbid0IGJ1eSBi
dXQgaXQgaXMgYWxyZWFkeSB0aGVyZQ0KPiBzbyB3aGF0ZXZhLi4uDQo+DQo+IFNvIHdlJ2QgbmVl
ZCBhIHJ1bGUgaGFtbWVyZWQgb3V0IGFuZCBwdXQgdGhlcmUgaW4gYSBwcm9taW5lbnQgcGxhY2Ug
c28NCj4gdGhhdCBpdCBpcyBjbGVhciB3aGF0IGdvZXMgaW50byBzdHJ1Y3QgbWNlIGFuZCB3aGF0
IG5vdC4NCg0KTXkgcGVyc29uYWwgZXZhbHVhdGlvbiBvZiB0aGUgdmFsdWUgb2YgdGhlc2UgdHdv
IGFkZGl0aW9ucyB0byB0aGUgdHJhY2UgcmVjb3JkOg0KDQpQUElOOiBOaWNlIHRvIGhhdmUuIFBl
b3BsZSB0aGF0IHNlbmQgc3R1ZmYgdG8gbWUgYXJlIHRlcnJpYmxlIGFib3V0IHByb3ZpZGluZyBz
dXJyb3VuZGluZw0KZGV0YWlscy4gVGhlIHJlY29yZCBhbHJlYWR5IGluY2x1ZGVzIENQVUlEKDEp
LkVBWCAuLi4gc28gSSBjYW4gYXQgbGVhc3Qgc2tpcCB0aGUgc3RlcCBvZg0KYXNraW5nIHRoZW0g
d2hpY2ggQ1BVIGZhbWlseS9tb2RlbC9zdGVwcGluZyB0aGV5IHdlcmUgdXNpbmcpLiBCdXQgUFBJ
Tg0KY2FuIGJlIHJlY292ZXJlZCAoc28gbG9uZyBhcyB0aGUgc3VibWl0dGVyIGtlcHQgZ29vZCBy
ZWNvcmRzIGFib3V0IHdoaWNoIHN5c3RlbQ0KZ2VuZXJhdGVkIHRoZSByZWNvcmQpLg0KDQpNSUNS
T0NPREU6IE11c3QgaGF2ZS4gTWljcm9jb2RlIHZlcnNpb24gY2FuIGJlIGNoYW5nZWQgYXQgcnVu
IHRpbWUuIEdvaW5nDQpiYWNrIHRvIHRoZSBzeXN0ZW0gdG8gY2hlY2sgbGF0ZXIgbWF5IG5vdCBn
aXZlIHRoZSBjb3JyZWN0IGFuc3dlciB0byB3aGF0IHdhcyBhY3RpdmUNCmF0IHRoZSB0aW1lIG9m
IHRoZSBlcnJvci4gRXNwZWNpYWxseSBmb3IgYW4gZXJyb3IgcmVwb3J0ZWQgd2hpbGUgYSBtaWNy
b2NvZGUgdXBkYXRlIGlzDQp3YWxpbmcgYWNyb3NzIHRoZSBDUFVzIHBva2luZyB0aGUgTVNSIG9u
IGVhY2ggaW4gdHVybi4NCg0KLVRvbnkNCg==

