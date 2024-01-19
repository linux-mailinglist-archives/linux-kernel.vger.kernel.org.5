Return-Path: <linux-kernel+bounces-30666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BCD18322CC
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 01:52:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 608C21C22D67
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 00:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 044A217F5;
	Fri, 19 Jan 2024 00:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JfXLhr36"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 848B5EDF
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 00:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=134.134.136.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705625561; cv=fail; b=l4kcRp7o0ONMFBmEfqGSkYUWKfNOKi5PjqUbGzX04EyFWnghIQOvRKIkQ2KFEzbX5tbMxZ+2Lwp+ZdkJki3MVf12GMPpJYDzPj+0F8Hn47ZXu76EdezEJJlirtMYofk1+V+JuNK0kF9puzACwcjbHMK0Hw99CmfmC3YIu+GX8cQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705625561; c=relaxed/simple;
	bh=MYyBehrfFvb8O1UBeZXEskO8Ap+5kpipWSk4zQAcuwc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FkBWgVHSb0fXeNJ2jG6ut3bEVmaAlVdMgFBKuh9bnwCa339juvmLz0N6laIx171/6SvZGcropk6NgacLVChbr7TWWSIVuzdYU1cBZ/INvZQHHPZSPL82u9tms1w/gw2cLD+H6HxD4aLGxqcrF7IcS6ndAkq34wABnsEtPJPaX2g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JfXLhr36; arc=fail smtp.client-ip=134.134.136.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705625559; x=1737161559;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=MYyBehrfFvb8O1UBeZXEskO8Ap+5kpipWSk4zQAcuwc=;
  b=JfXLhr36Z0BCxApxwJNAUdvivVlhGQhZzV65dsAiQWdo7lyVkZvUhfeq
   MdWxmHIPZhR7LDSVulbB4N+7dwU+mWBTFfrjbJPvPNQdYoyjhsxo8jlAO
   hP96YepD7nYqapSHxNfzt5s2eTCV9t78IunVQjl4Ked30v572LQFXNygT
   IJ6rwqGwUiE+k/t6xQ8jZ/OqukKlWqCDjYmorG5HurI+AsN3ZZCEdfg0j
   qx9Ai8HuNEHS/shO2N6qX2ddX6ZZZldHOgr9o/eH366HDgzJf71Nds/zV
   0e5NKuvErqyFlKYoqcZBZ8SorOlQ/rB1+T2c6G6AkPj7ocfqLn75ydRsn
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="466993343"
X-IronPort-AV: E=Sophos;i="6.05,203,1701158400"; 
   d="scan'208";a="466993343"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2024 16:52:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,203,1701158400"; 
   d="scan'208";a="33243555"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Jan 2024 16:52:39 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 18 Jan 2024 16:52:37 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 18 Jan 2024 16:52:37 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 18 Jan 2024 16:52:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jGVRZOMi/6qdcz+TNNrY8FoPIQhrxhaxr8OGW7WK9fDTY6dECi5pI6/65+/1x0AigYxtlzB6srow4d2P8cF/IybaDTMNHmzbj1daI3osOysd3U22zUfCXcPXEUjeMvKunwI9pjSlMY/K7Ebklf1F9+ZZZG9O0XgR1W9yKRmZBKAIRE++hyA+np/Py8kYA74azP3t3Ph0TPV0Zhd+EZVzMK5lSL/EN6z6NRyqmOmmmCyvlHCFszEgivNY5O3jAZh2u6Gq/qs1hiELHfqNEpefmU18TtQvZ9rO5xzktJGFjbIFYGwQaHHyFD380lHvK2LA2dvBXQcO7lYsPG0CIneWEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MYyBehrfFvb8O1UBeZXEskO8Ap+5kpipWSk4zQAcuwc=;
 b=ZaDysKqZQQttNq8jsq6urFDRS7TBjCDpuOJETy0R37vLACI6Ko08HJM5E5FTP0qqDUI6Vp9TEkNJ6MAG4E3hSTaWexJMoeal+2C67kaimDjvKj3yeACLoNbv9SOjQXyEpYMtjPvU7GfDvActjLKBTylQrDHfuhDAOf765ncDLZVSBWEoUXUhzyv0gXTKAr4B7hpylcQ2gSjiAdmmHX3w5HVIDW0g2dUW1Gr0q7uQs4btybKRTzsvltoAGatjtegtchhmomwFiYHDJ3B9Gui8xIRuMC4TVdGyaS1MGGmxNGN8d7JDWkdc1Vf+37bqekHtn+vkgST3OT6+TqLnbzaQAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB5983.namprd11.prod.outlook.com (2603:10b6:510:1e2::13)
 by PH7PR11MB7480.namprd11.prod.outlook.com (2603:10b6:510:268::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.23; Fri, 19 Jan
 2024 00:52:29 +0000
Received: from PH7PR11MB5983.namprd11.prod.outlook.com
 ([fe80::7996:73f3:9de4:3a57]) by PH7PR11MB5983.namprd11.prod.outlook.com
 ([fe80::7996:73f3:9de4:3a57%7]) with mapi id 15.20.7202.024; Fri, 19 Jan 2024
 00:52:29 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
	"nik.borisov@suse.com" <nik.borisov@suse.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"x86@kernel.org" <x86@kernel.org>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>
Subject: Re: [RFC PATCH] x86/virt/tdx: Disable KEXEC in the presence of TDX
Thread-Topic: [RFC PATCH] x86/virt/tdx: Disable KEXEC in the presence of TDX
Thread-Index: AQHaSifQt9ZVu2pn/UaFVG+BwjuRcLDgFwyAgAA3TACAAADjgA==
Date: Fri, 19 Jan 2024 00:52:29 +0000
Message-ID: <7695034c0c7bf91532fb5cbd05d9a4b8cb77e70f.camel@intel.com>
References: <20240118160118.1899299-1-nik.borisov@suse.com>
	 <e75addd3a8af6ef0243999f933df528e975d5ca3.camel@intel.com>
	 <fc731bd3-4232-4906-9f78-448a96e3eb5b@suse.com>
In-Reply-To: <fc731bd3-4232-4906-9f78-448a96e3eb5b@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.50.2 (3.50.2-1.fc39) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB5983:EE_|PH7PR11MB7480:EE_
x-ms-office365-filtering-correlation-id: 8c1cdd4e-b8ae-4ef9-d6d0-08dc1888e9b9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: H6T6VT08gbZ5Fk6mOAV/SlfV5vJk7uDXjCQ3xaXvKEHqhGAPTDuCn2hEWawC3fpmWVPW17O/90kAVLUOylGB8/thAdVGKABhlDLoRZdSup/m0zChajWd/AzrtvikrUzYaCTThXIZU4QTHMdg9ClpuMIJ8HRpI2eu2OUTmAxfZMy+QP30oD5sLV6iJrRLRxNOSSbakC5zbnA02OWf1Y/vyNF6Ry6fsYWRKWpuhI7wzTeaBLbOu5y1qsdeTJdlr8MyQJcnJJJrdvs27NdFD53olbMB0FO37HaCE5inKXJHp2vC5A8L7cNyp6+QjyrObqf4b3e6UY0Bl6qGe2MBRzWUXC5r91JVlr6lsUkIxezvp/ilZbapcYL8uimpcWns3wQq3XaXiYUzvm2ZXtXRNAISUlMOIcgztD2gyS/zQiSc+NbsMIa1zJ2VEEtvB+ZYRYaqhn2fHwfo8kClto8IpvBZHFZ2xGzEKbe3KuoBFU3YFYtVughld5oxFUMjd2jpcWe/Adv77gX6Cqs2bIrZ70yAWMGztVo8R7zelbR+RhH8/F0V0bJBDdz1MbQLdyWcYmoArr/iMIk0vHbYjRtW/cw9sWgpCH4gy0dfGl7AFGEP5662/Gmmf4Uo+b57vVXafGxV
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5983.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(366004)(39860400002)(396003)(136003)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(122000001)(38100700002)(82960400001)(83380400001)(36756003)(38070700009)(54906003)(6486002)(64756008)(66946007)(76116006)(316002)(66446008)(66556008)(110136005)(91956017)(8936002)(8676002)(5660300002)(4326008)(26005)(71200400001)(6506007)(2616005)(2906002)(6512007)(4744005)(66476007)(478600001)(86362001)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z3NIMnMyTGxkVzlDdE9ZbDI5bEtyQ0ppV3lHVUhVT3EreldZL3BDZHJlRytY?=
 =?utf-8?B?N2szY0pEL2p0andLd29nR1ZnWWNoMmY2ckhGYXdSVytaNXU0Qi9JWEN0eE5H?=
 =?utf-8?B?d3JFVXZ2VTEwOGcwQkhkbnNMcUZwVy85RUQzS1BWSDBTN1IzWG9YbklaWFp3?=
 =?utf-8?B?V25QQTQ0bk1tN2RmdTVNb3JveUloMElrc3FNQ1g2MlNWNG16UjBoY2MvbHhx?=
 =?utf-8?B?dVNKbWFYREhFZ0VHT1NRQVJXcVFOaUdadWhnY0VFbnZ6eXA4cUNtS2ZwOTcv?=
 =?utf-8?B?VjFIMjVLMlZwUENqamU3L3R4cGd1bHlZdnNKZ3gxeHFOdUo2S2ZKblh5OE9l?=
 =?utf-8?B?L2lzTkcxQXZWMHZVUVZZejlwVVpnRGF3RU5UWm9xczdCL0s3dGZ0bXh6em9n?=
 =?utf-8?B?c0dzUlVBbkZSdEhuR3pJUENWN0pQWlFCWFNkNWtPcXN5L1JaS0c1TjVGTTRq?=
 =?utf-8?B?SFZqVGg1dW41ZktvSTc2Mmxvb2tNT2FhaGRKN28vbk92OEw4TW5GZ0IwZmJq?=
 =?utf-8?B?Z0lsU2VIcWZFd1prVWxFRUdpdkd0c3hlRUplY3FWdmRVcnA1Qk1qTGx5Qk5m?=
 =?utf-8?B?T3NEc1JocFhScEpzcjJISi96TDJhUU1zRklnSlJiVTAybWEyQ1p4dHlza0hk?=
 =?utf-8?B?L0tQNy9IQ3dqYUtiQ2Yvd0Q0VXZxQjI2VTVITlFjOXMvektoU25pYkpKWjBr?=
 =?utf-8?B?S2hBdlVzTjJmU090YU9LMDQ0eVRiYUQrcTZzYndtMTZ6djlqRFZ6MTc3L2lz?=
 =?utf-8?B?TzE1K1F3d3pDVnI2NFJvNTBEbkRwUVJUZy9FMVMwUEtIVWhzRWp5L2hYdS8x?=
 =?utf-8?B?Y2FWUlpOS1U2NjhBaTRrb296YU1rYTUyVGdBMTZDaUlKTlZvTVNqcnhrUC81?=
 =?utf-8?B?VGtTT3VqTHBpdWxRRS95TFh1cSs5MzFkRExMT0VwVnZ6azhUM1dNdHdadzB5?=
 =?utf-8?B?UEJaZkQvUmdaWldKNnlST0FaakIvM0xFVGFmc09JSkN4TmttaUxDWVpzWHg1?=
 =?utf-8?B?NUI4WS8rSFkyN3Z3S05EVnhUdHVjNWtGWTRkR0d0MGw4RVBkNEI0ZTNoVEJj?=
 =?utf-8?B?aTZZNzZjbklYczc2SkpkTUtmMU1KNWFyZDJnQS9uRDhIVWhnL1dLdUh4dmRQ?=
 =?utf-8?B?cmRRM1psYkRweFpXUmtwRHVNb1diVTRDMFBDMzRTSG9ZVXpGUkZmRVIrYkpV?=
 =?utf-8?B?VFlJUkQwenlsazJWMkpTbTAvNk5vN0J4Um54bExKVkRNYWx3Z1E1U08vampy?=
 =?utf-8?B?d0FPMW52UllVRmRIZnpTV096SFFzOE5TcUNOc3hPMlM3MmF5K0FUVGI5MDBs?=
 =?utf-8?B?UThiLzVIWC9vUWUrWTBFN3cvalF5aHhmSURCUnFSWVNsZTBEakZuK0FNMXJi?=
 =?utf-8?B?eWJTb3B2aTFWOU4xWmhHekxiNGh5ckNGTjdYd3l5Q2o2Mkp3T0xHZk85R09v?=
 =?utf-8?B?dGYyMDNWUHJxOW1CNVpUN0tBUStudHVqNjMrL2ZNV3RqQWxRQkpSMzdTSFV6?=
 =?utf-8?B?RHB1UEFSdVgzTHJTNm01M0tIbkZjendpYnU1UU1hR2U2RWRoWGtZTjdhSnFH?=
 =?utf-8?B?clZzVHpKaUhWWGVWY2Mra1hXTGZPazl1dzMrSG1tODAvTEd2QjlILzdqN3I1?=
 =?utf-8?B?d3ZOaTU3cTRzdFk1aEFyaDgxL0F6Wm03cThlYUFmRFhlM1B1N0xkZS93Tkwx?=
 =?utf-8?B?c3lYQnBXSmVVUmc2d1BLcE1VdTY5V1RsSHNHSzJYT3puNmYxL2h6Z3hJakxv?=
 =?utf-8?B?ZlEycHU2c2xxZWYzRE03UHNWOHRENHZ0ZEwvTGJXbTUvNnZDcnJYNTN2aEFE?=
 =?utf-8?B?Um5OMVFNaWpTU3dNTHFkK2VOM2V4TDQwdXVJbGJvSkNFWXdjVGtUU3hoQmh0?=
 =?utf-8?B?ZlFUeFFKYVptYlI0OXZkb1ZUcW9LbmQzM3ZreHltamFpWjc3V3ZUL2VVY0x6?=
 =?utf-8?B?ckVGNUxjMlpPRm0zK3JoSmdoTE5YZnF6VFFqRzFHdnlZSGVkejRSczAvMjdu?=
 =?utf-8?B?Y2ExZ3JNekNJQTNOQXFkOGtRNzZxOEVIMmJxbmJia0w1ZXg3SlpNT2VrSHdS?=
 =?utf-8?B?OERoQ0FmK0pHa1VyWEc2OGpITHdkbDJSdi9OZUs5TlE3K2pRZmZNZWwwaC82?=
 =?utf-8?B?ejJVUmJvVnpPQmo0YVBoeWlGNFdIN3UrbzdJMVV4eUJ3Sk5ORnpqbk5iazl0?=
 =?utf-8?B?UGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <49024A62265FFD49882A998A0873B811@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5983.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c1cdd4e-b8ae-4ef9-d6d0-08dc1888e9b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2024 00:52:29.5449
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PgwIzfY+GDWDmofBhlXfEAolD7d2GqPdBUhJFmEQZg13HNQeyuE7rwCPy4Zgoo/EtuzO7A3oXCU67Ap7VBeBFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7480
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI0LTAxLTE5IGF0IDAyOjQ5ICswMjAwLCBOaWtvbGF5IEJvcmlzb3Ygd3JvdGU6
DQo+IFtBZGRpbmcgS2lyaWxsIGFzIGhlIGhhcyBhIHNlcmllcyBpbiBmbGlnaHQgYWJvdXQgS0VY
RUNdDQo+IA0KPiBPbiAxOC4wMS4yNCDQsy4gMjM6MzEg0YcuLCBIdWFuZywgS2FpIHdyb3RlOg0K
PiA+IE9uIFRodSwgMjAyNC0wMS0xOCBhdCAxODowMSArMDIwMCwgTmlrb2xheSBCb3Jpc292IHdy
b3RlOg0KPiA+ID4gVERYIGRvZXNuJ3QgY3VycmVudGx5IHN1cHBvcnQga2V4ZWMgc28gZGlzYWJs
ZSB0aGUgbGF0dGVyIHdoZW4gVERYDQo+ID4gPiBpcyBkZXRlY3RlZCBhdCBib290IHRpbWUuIElm
IGtleGVjIG11c3QgYWJzb2x1dGVseSBiZSBzdXBwb3J0ZWQgdGhlbg0KPiA+ID4gVERYIGNhbiBi
ZSBkaXNhYmxlZCBmcm9tIHRoZSBiaW9zLg0KPiA+ID4gDQo+ID4gPiBNYWtpbmcgdGhpcyBkZWNp
c2lvbiBhdCBydW4gdGltZSByYXRoZXIgdGhhbiBhcyBhIGNvbXBpbGUgdGltZSBvcHRpb24NCj4g
PiA+IGFsbG93cyBkaXN0cmlidXRpb24ga2VybmVscyB0byBoYXZlIGJvdGggZW5hYmxlZCBhbmQg
ZGVsZWdhdGUgdG8gdGhlDQo+ID4gPiB1c2VyIHdoZXRoZXIgdGhleSB3YW50IHRvIHVzZSBURFgv
S2V4ZWMuDQo+ID4gPiANCj4gPiA+IFNpZ25lZC1vZmYtYnk6IE5pa29sYXkgQm9yaXNvdiA8bmlr
LmJvcmlzb3ZAc3VzZS5jb20+DQo+ID4gDQo+ID4gSGkgTmlrb2xheSwNCj4gPiANCj4gPiBUaGFu
a3MgZm9yIHRoZSBwYXRjaC4NCj4gPiANCj4gPiBJIGFtIHdvcmtpbmcgaW4gcHJvZ3Jlc3Mgb24g
cGF0Y2hlcyB0byBtYWtlIGtleGVjKCkgd29yayB3aXRoIFREWC4gIEkgcGxhbiB0bw0KPiA+IHNl
bmQgdGhlbSBvdXQgc29vbiAoZS5nLiwgbmV4dCB3ZWVrKSwgYnV0IEkgdGhpbmsgcGVyaGFwcyB5
b3VyIHBhdGNoIGlzDQo+ID4gcmVhc29uYWJsZSBiZWZvcmUgdGhhdCBpcyBtZXJnZWQuDQo+IA0K
PiBJIHRob3VnaHQgS2lyaWxsJ3Mgc2VyaWVzIHJlY3RpZmllcyB0aGlzID8NCj4gDQoNCk5vIHRo
YXQncyBmb3IgVERYIGd1ZXN0Lg0K

