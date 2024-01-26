Return-Path: <linux-kernel+bounces-40552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 786D783E254
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 20:16:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E2E11C21AB2
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 19:16:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C46D224D3;
	Fri, 26 Jan 2024 19:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cA8gqLJk"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DBE2224C7;
	Fri, 26 Jan 2024 19:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=134.134.136.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706296575; cv=fail; b=BxIHoj7Rpxoymh/iGeclBL78WuUAkLancN+sSErK4V7tx9iRCV/bn6qcnmpqO/GXkIWi7B8VLtAVCmtjSMrsnAh8U/5KxOaTYuzEUeRvcMbvu9AOFHrghRCf4uuIehB4QkCXtJX21M+jdvigNpI24oMGbGFtJI0S/T04o6qiFOA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706296575; c=relaxed/simple;
	bh=QhneiFOM8kzU+J7qAOu6ZFD3f6rBkkr98DwqoWYbbR0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dkVJo7sLs8BZHpUvWdvTZd92LiABU/nuruDDd9LPcmrjk2PYc20QYTZ72gdGkMowfc37hUll/wGYNmGrPeUabT1yhixH0c8WP+wSWl1f3x7fMPCZ9uOtTMy7ObNj7SqU+3/yvbYbmMN8nAkzW+NQx1bj0MLtZ1Bb1m6IRrYADMw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cA8gqLJk; arc=fail smtp.client-ip=134.134.136.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706296568; x=1737832568;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=QhneiFOM8kzU+J7qAOu6ZFD3f6rBkkr98DwqoWYbbR0=;
  b=cA8gqLJkLW9qvmkPYTk0osUpW8ebxIWbBOP/E2f5DJYicqF/POIvCdBT
   gQ7dfrXM2YbmBPUWS9TBXCoCemsEUZs7ItP/K3CJfSAV3VhLkViD6bYBS
   WWE+GkGqyPg+mp6gGUdUmm4G2S9WJroOxtjYq+f9XEikCqPxY4/a7DFYh
   vJ7HRKx9KpZqmD7piWYqxEdTHRjbAWDZzZMgoHBtdjFC4FJEbOEBstGIW
   NIWIUADsbEXjLzxZIG9A3WkMOUSL8oBk7FS1906+ug7lXODFsHiR/zi/r
   zRyPL75bhE0p77alpB4nV7lt9SKmFXPQ42SyMshvH6k9M8scLI9MQWGw0
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="392985769"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="392985769"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2024 11:15:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="2678088"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Jan 2024 11:15:54 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 26 Jan 2024 11:15:53 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 26 Jan 2024 11:15:53 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 26 Jan 2024 11:15:53 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 26 Jan 2024 11:15:52 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kLji7LY/QZoNPodNxmiYRh1WwZsNhh8i6YgiMtcDTwUlDZI+TOekK2oqRU5mEq/nnHWwZVFY1YsnzFsepHz+U7L5PUB0avf81EW2FhUb61piMcV9EowG+oGkjBQdL7mMDPVqbMLsxhPDBgjqpqx5/Z3LK7Wl3IkXn3Xl5YJcBUAWvrkmhTFJTPokhUlHfZi0R1AS244MQSaa17L2PHYF0xX4IWeDKpH59dkMpA/ZemNRehiNCA/t7Z+080d0au8qf7oP6FTedzRPRGphlABHIXREqlV26XW/P4jnlpXeueWdQ52jERTVKjzuTIC2g5YTYkiHyGJNF4Uwa8uKtaicag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QhneiFOM8kzU+J7qAOu6ZFD3f6rBkkr98DwqoWYbbR0=;
 b=ITRHySRskQb0+8A6+Sga1SkcLzroMh0an4hd8Rp50/VgLHxvpUCWmCI8G3HWVFnBz/Zctois9yfwQg+S6GCPMa3EjpaI0FhbVCzwKB5BC/Fiatg9PVPxCRbS2FLzTNfrEzZoT9R7fmq54IUlEqcyYrrgo5cCXgqd2Dhm/G+idu34bjVNiGQDCTvlS6sfj3+gu+SSSM7VHL6qM8vL3BjMlKxl1rZP//PDCAkp7H7IcrRCa2b1o98XG/ISH3DtWba/oRf/l5XyIuTMxE40f2rhoairL+2Oz9S94TXwC5KutkyX33bFLKpBxUhejxBmEV15IF7gTASB62HeOV6OKwMF5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by SA1PR11MB8524.namprd11.prod.outlook.com (2603:10b6:806:3a9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.26; Fri, 26 Jan
 2024 19:15:50 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::a136:fb19:acde:7670]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::a136:fb19:acde:7670%7]) with mapi id 15.20.7228.027; Fri, 26 Jan 2024
 19:15:50 +0000
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
Thread-Index: AQHaT780LVN5GzQCtkupW37k1NP6AbDq4W+AgAACUMCAAQE/gIAAbNLAgAAhhoCAAACOkA==
Date: Fri, 26 Jan 2024 19:15:50 +0000
Message-ID: <SJ1PR11MB6083E6BF178B9D394BD58DDBFC792@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20240125184857.851355-1-avadhut.naik@amd.com>
 <20240125185821.GDZbKvTW93APAiY1LP@fat_crate.local>
 <SJ1PR11MB6083DAA7A6EDBBDAF5987A80FC7A2@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20240126102721.GCZbOJCTqTVmvgOEuM@fat_crate.local>
 <SJ1PR11MB60839509241AA98A59B78D15FC792@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <20240126185649.GFZbQAccZphdW_0CkH@fat_crate.local>
In-Reply-To: <20240126185649.GFZbQAccZphdW_0CkH@fat_crate.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|SA1PR11MB8524:EE_
x-ms-office365-filtering-correlation-id: 3a31438a-d3d5-4917-add9-08dc1ea33581
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HQyUxKoOSrzhaARDVMG+haGPmwAXdXRgfWbXJlMTwF8YfLpFBHYUOvAMlkZdUDuooYx35S603n4sizf1BPwTPgieKD7DAIIVoXFR7+E9Z7qJOy8XyXn95IZdGUsbOuJoeSN583/3vHw+M+hSzOfZJNagWKeA5ZbU6JPxGS3A5s7lWvjBrG+uYLQthmt4QEiB4Pz4yAc+bP5a+O+c0rmr4rn/QHTJwfbAsX4BbPYz8hS9SVdW6YsIQCr8pJstsT7GcV/4Ubia6nt3zmIprjvGwDRcPAzoPpvfZPK11o+9d+iJiG8spB8gjX6jUADAzgqMt9gh/lMRaeOiWKVY2vl61iWj0WSjqEVJhpzNNxaeqAlP1i1o6cYnpk7lT6hbyP7Y/aZwyrRAWNwnaUn1SbGK3nEiNhezU9iRjrCoqe3LwKeKPDmqsmWYN2j1adEGzheuIZJFpfrqJ1Bj02kKE0MhI/tqeSxwPoNV1TKsK9gPLxrQd+X1nAfuFSjVAKCGqd46u8eYijawIlki+1ftP9R9po3BKozPSVhe0pTsBDCuMf/nfh0V+fWu2Q32t5yr8MSQLDQF3FZuySz2MCSJItaes11vY+w4BoXdA4CeKf7kcAJ6PH3ls/Z2MZ3WyucSbeiY
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(366004)(346002)(396003)(39860400002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(64756008)(86362001)(66446008)(82960400001)(316002)(66476007)(478600001)(66946007)(52536014)(71200400001)(66556008)(54906003)(6916009)(76116006)(38100700002)(8676002)(55016003)(9686003)(26005)(6506007)(7696005)(8936002)(4326008)(83380400001)(122000001)(15650500001)(33656002)(5660300002)(41300700001)(2906002)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bFdwWjhHYVBmems1R3UzRUhuOHUxU2Q4NjZ0VmZYa09Dejkzc250WHpRbCs3?=
 =?utf-8?B?MjFsNWx3aXZFaTB5djV0NVJiSGtRQ2dNYkY5dkxoamFFMy9CYTRlRWlHMkY2?=
 =?utf-8?B?bWx3TmlyZ0hSSFIwaENzL3hWVVpwYWdDMFoxeWJwWC9UQnJ2a3puYzFVekpO?=
 =?utf-8?B?UnBzU3p5SW9yc29UeFFPSkRqaFpXaExkNlN4L2gzMlVvSzBNdzBBK2NMb3VY?=
 =?utf-8?B?a0V4K2U1QXh5UFJmVjhsNk1UVFd6alJreHd2WmwzSVZnTkQ2RTYxMHVsS2c3?=
 =?utf-8?B?VWcxbERrRnNiOS9BMlA0YmNickx3MEV3emtTUklWamE3ckNFNThuVEVZMFds?=
 =?utf-8?B?aTJjaEhYMDV2b0hkMWtVdk5DMEt2K3VFbU5WNStwaHo0dHAxUHJuRm1SUS9p?=
 =?utf-8?B?K3EyTDZEWWVuME9kOS8zT3JFUHNwT3grbDBCcXhZbmlBak9wbXhRWXNnVU5B?=
 =?utf-8?B?ZlI2RGVNQ0N2VlhZY2c0QzR4NVQrZ2hoZGRLTFRRamlNR0owUzVqS0U2K1VR?=
 =?utf-8?B?aG8wSEpuMk4xS2NTdll4dUhjUzhySWlnQ012cHZEd0xsKzBtMTdqTnlqMUkv?=
 =?utf-8?B?RTN5bGh2Wk42Z09FdGdseWpzWE4rVnlQT1QvUERnUjZDaHp1ZHVoYjlVeVdt?=
 =?utf-8?B?SjdPSXNBRzEzL0RRSHp6NDJZTkVDMkliZ0Q5Q1Z6VUJOM3VLSnN5RTNCRTFq?=
 =?utf-8?B?bVRwVjB4cXJ5ZDJhRW04UkZNcXBnWWRUQXFaRE9qSXVuclpSbUx0a0pOSDE2?=
 =?utf-8?B?cHFHeUFiZWJ2emc2ODVjYW9iVmFlR3paYVRLSUQ2UVM5dTFDQXdHSHp0K3RO?=
 =?utf-8?B?L0I3Y1R2MFZ0em8yeHUwNktQcGhXc1c0QVN3MVlaREpwVFBVdHp6NEI3Nzg5?=
 =?utf-8?B?dFJaWXRRWUJ6K1NsTVVxVmE2alB3Y0FiQ3QyS1pqRm5hWUFCQzJZbTR6endF?=
 =?utf-8?B?N3JkSHZEZlRDTGxleEpJWWNseEkyWWN1UmgzUWdaYlNjSU9EYk52Uk5MVnEz?=
 =?utf-8?B?UEUvRHhQanFVQkRNVVR5NlppNkx6emxLcmgva3RTakF2MjVUMkFrM1dEUUNH?=
 =?utf-8?B?MjI5bUFEeStUdU93SVdHSnA4S3pmeXRtYW54bHdrTUlFcjRpT2hHckJ0RmVE?=
 =?utf-8?B?c3N6M0VYRGZDRHlzTkVselNvcW9HaVd5L0RHOW5HbDRRellyUm1yYU5jcDh2?=
 =?utf-8?B?amdOaG9SanJ4SWx5SWtRcytVc01PYjludURnYzBmNWI0b3J1NFZySnBPTmlE?=
 =?utf-8?B?N2wxeFpPbEppdXVHNmhxYXEvOThPaEZZZXR0VWQ2TTFISXNoZFFVQ3pBczEv?=
 =?utf-8?B?ZUNuZmNZMHpReVJuMGloWW9rTXlCeUxLUDZNQ05ueWRUTWx3RkQzOHI3d0lV?=
 =?utf-8?B?dHBOWWF1aVJPRytPcTZKTXJQWHlvaE8yUkduc3ZzQnIvaG11bVlqNThueXFM?=
 =?utf-8?B?MytFZDIxVmhycGo3d3NoeE45M25xS3djT09xeHcxWlhoSGl2S3ZRTGVEMmpY?=
 =?utf-8?B?UEVMSDFxT2R5d0p5QjBYZ0Y1Rlp1Q0ZDTXdTMWhFZEkyNGxZRklveUhldnBV?=
 =?utf-8?B?L2YwSWJYalhVdDRvVFpmaUQ4ZE9ua3V5NnpncS94bmZIZ3VGWUpWWjF5NEJn?=
 =?utf-8?B?NlRoZERSai9ORXQ4ZDNBSUltOVpwYm1QUEEyT3Z3enFvWDR4TU9nQXUycjgv?=
 =?utf-8?B?UTRwSFgyL09kQ0c4Z1JkWG5Rb3pVT1RFMERtRm9PdGQvMTFzUldxTm1SMHlx?=
 =?utf-8?B?c1VzV0hISWNzbWdwdlh6N3pZK3ppWDJONUVvS29WclMxMnB3TE9GK0FmSVh6?=
 =?utf-8?B?K3hBN1laL3JOS3ZkUHZSdS9GcnRwaW9sRXdmM042eURoZGZScjNNSWx2ZkRP?=
 =?utf-8?B?K0lzRlh2cFdORHBZS0t5VFVoLytnWlExcjBXb0dzVGI5S21zdmtmcDJZb3dx?=
 =?utf-8?B?dzBldDBISFRKT3RZUGlyZE5ySFdDeHd5eTQra1hrUGc2QjhnTGdpdXNzRUli?=
 =?utf-8?B?S3FHb05pci9rUWxqUWplUkdmTHFkc3lvMG9Gdk1nRU50ZXhnZHk1N05kRGo4?=
 =?utf-8?B?ckZuRVpPamY0U2wvOE9VK3EzVkRsMFBSczFoQXNoZkdmZ2duaGx2cmNDOHA0?=
 =?utf-8?Q?LhwAOSb/v52Fd1diYa2F7NvXj?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a31438a-d3d5-4917-add9-08dc1ea33581
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2024 19:15:50.5585
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iLmOwgC6ZjP0hngif3kAbOdHoKvi+FgF7KzDySCI+BnEUEnMB+twH34AldMB4gTqGecu/JHkgzquAm+Sro4S1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8524
X-OriginatorOrg: intel.com

PiA+IFlvdSd2ZSBzcGVudCBlbm91Z2ggdGltZSB3aXRoIEFzaG9rIGFuZCBUaG9tYXMgdHdlYWtp
bmcgdGhlIExpbnV4DQo+ID4gbWljcm9jb2RlIGRyaXZlciB0byBrbm93IHRoYXQgZ29pbmcgYmFj
ayB0byB0aGUgbWFjaGluZSB0aGUgbmV4dCBkYXkNCj4gPiB0byBhc2sgYWJvdXQgbWljcm9jb2Rl
IHZlcnNpb24gaGFzIGEgYnVuY2ggb2Ygd2F5cyB0byBnZXQgYSB3cm9uZw0KPiA+IGFuc3dlci4N
Cj4NCj4gSHVoLCB3aGF0IGRvZXMgdGhhdCBoYXZlIHRvIGRvIHdpdGggdGhpcz8NCg0KSWYgZGVw
bG95bWVudCBvZiBhIG1pY3JvY29kZSB1cGRhdGUgYWNyb3NzIGEgZmxlZXQgYWx3YXlzIHdlbnQN
CmZsYXdsZXNzbHksIGxpZmUgd291bGQgYmUgc2ltcGxlci4gQnV0IHRoaW5ncyBjYW4gZmFpbC4g
QW5kIG1heWJlIHRoZQ0KZmFpbHVyZSB3YXNuJ3Qgbm90aWNlZC4gUGVyaGFwcyBhIG5vZGUgd2Fz
IHJlYm9vdGluZyB3aGVuIHRoZQ0Kc3lzYWRtaW4gcHVzaGVkIHRoZSB1cGRhdGUgdG8gdGhlIGZs
ZWV0IGFuZCBzbyBtaXNzZWQgdGhlDQpkZXBsb3ltZW50LiBQZXJoYXBzIG9uZSBjb3JlIHdhcyBh
bHJlYWR5IGFjdGluZyB3ZWlyZCBhbmQNCnRoZSBtaWNyb2NvZGUgdXBkYXRlIGRpZG4ndCBnZXQg
YXBwbGllZCB0byB0aGF0IGNvcmUuDQoNCj4gSUlVQywgaWYgc29tZW9uZSBjaGFuZ2VzIHNvbWV0
aGluZyBvbiB0aGUgc3lzdGVtLCB3aGV0aGVyIHRoYXQgaXMNCj4gdXBkYXRpbmcgbWljcm9jb2Rl
IG9yIHN3YXBwaW5nIGEgaGFyZGRyaXZlIG9yIHN3YXBwaW5nIG1lbW9yeSBvcg0KPiB3aGF0ZXZl
ciwgdGhhdCBpbnZhbGlkYXRlcyB0aGUgZXJyb3JzIHJlcG9ydGVkLCBwcmV0dHkgbXVjaC4NCj4N
Cj4gWW91IGNhbid0IHB1dCBpdCBhbGwgaW4gdGhlIHRyYWNlIHJlY29yZCwgeW91IGp1c3QgY2Fu
J3QuDQoNClN3YXBwaW5nIGEgaGFyZCBkcml2ZSwgb3IgaG90IHBsdWdnaW5nIGEgTklDIGlzbid0
IHZlcnkgbGlrZWx5DQp0byBjb3JyZWxhdGUgd2l0aCBhbiBlcnJvciByZXBvcnRlZCBieSB0aGUg
Q1BVIGluIG1hY2hpbmUNCmNoZWNrIGJhbmtzLiBCdXQgbWljcm9jb2RlIGNhbiBiZSAoYW5kIGhh
cyBiZWVuKSB0aGUgaXNzdWUNCmluIGVub3VnaCBjYXNlcyB0aGF0IGtub3dpbmcgdGhlIHZlcnNp
b24gYXQgdGhlIHRpbWUgb2YgdGhlDQplcnJvciBtYXR0ZXJzLg0KDQpZb3Ugc2VlbWVkIHRvIGFn
cmVlIHdpdGggdGhpcyBhcmd1bWVudCB3aGVuIHRoZSBtaWNyb2NvZGUNCmZpZWxkIHdhcyBhZGRl
ZCB0byAic3RydWN0IG1jZSIgYmFjayBpbiAyMDE4DQoNCmZhOTRkMGM2ZTBmMyAoIng4Ni9NQ0U6
IFNhdmUgbWljcm9jb2RlIHJldmlzaW9uIGluIG1hY2hpbmUgY2hlY2sgcmVjb3JkcyIpDQoNCklz
IGl0IHNvIHZlcnkgZGlmZmVyZW50IHRvIGFkZCB0aGlzIHRvIGEgdHJhY2UgcmVjb3JkIHNvIHRo
YXQgcmFzZGFlbW9uDQpjYW4gaGF2ZSBmZWF0dXJlIHBhcml0eSB3aXRoIG1jZWxvZyg4KT8NCg0K
LVRvbnkNCg==

