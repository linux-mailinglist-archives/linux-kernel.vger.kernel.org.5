Return-Path: <linux-kernel+bounces-55819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4209184C21A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 02:46:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43909B28AAB
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 01:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C72421CD1B;
	Wed,  7 Feb 2024 01:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MxGurFZL"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137EB1CD13
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 01:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707270228; cv=fail; b=POEA2+x5aPEA5GzhJty2yl9kkgVYeAOkfmW005CReXUutL8o2XDt9oa8G0VYOvxdCCAD96j+XfEcUpHuuCDSYrYB1ZdfMkJ94ROuZ/feDkSqpk2ztubBE6Ge+kiW3RZ+uONIK1pKMiv33zms0iaeMv7XCdjfvEwI5pL8a87AaIc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707270228; c=relaxed/simple;
	bh=MgsJDuduXDowDefrM+4tip3gcEf/phakGkhmADkbMaE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mJYBaqe7tTncBA0/5u0UOU7BZwE34/oQX4ZFMahmxViLZN929VUrfuCq1DCPTVUJNhe3K6cCUhQoh69DClRk/jeyB4oGEco3xN86N/m1puqwwjP/6nCAsS/zaiJ/49Fac+2c/ar3/LrldyLAHCu8B8emugrXsTlWbaGC+NdeJAI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MxGurFZL; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707270228; x=1738806228;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=MgsJDuduXDowDefrM+4tip3gcEf/phakGkhmADkbMaE=;
  b=MxGurFZLe1PS+XQzZqtiL1JAtLfk5pp6yJTYhH5lkJIB8Ox9EtDNTplV
   Dk4ToaZo7HE5472TBdLzGikT1oHJIMu8l+Is48TVvO0wCb7AUxVSL3hMY
   WCKbL6AUgQCbjKSt0AmDmOkG2C6w4Bg8mvJI7XpQ76rSObJjkLEhuOiWO
   H5Mz+22zSh5WJDkjQOKefMhun6AsQvXMyyf444MPAF3YV7oJI08R2qKV/
   jyfQqEFFWFePvkMPe1A+M6r5ur8SAwfiOMdbJc6ZdrnVXHG187rNMfMGY
   0Ev2hnARtdlpZWRaZ8NT18K6dRV9kanUBIxzO5fSrj7s8i1LvUcrL0Sja
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10976"; a="1034130"
X-IronPort-AV: E=Sophos;i="6.05,248,1701158400"; 
   d="scan'208";a="1034130"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 17:43:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,248,1701158400"; 
   d="scan'208";a="1413187"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Feb 2024 17:43:45 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 6 Feb 2024 17:43:44 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 6 Feb 2024 17:43:44 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 6 Feb 2024 17:43:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nM8lYBiTEHJtPK5iV1zoEEfGPpvCbeHOGtN1zn/EG8De0wQJ95bcfdUIITc6GjkGX7Yl5JAef2nDz+k2nuPdQ6bG6rWgxcicZmXTNvHTBd6d3ElDSKCNjXaL4Dm02k/tzNb3nNyiIBdyNAgghVd57XpBZxtp6k+yX7BJGgyoyZTa8d2IWDelHHg58GhKv/ixIzKh9D9dMTok4WbaCIFOELOO/QJn6AlqX8c4lR5NI1ONYIAX+W9VgpiZMN0d9hWUnwSemAZAOXfnHSbTO59f24z51Koznd3iF9T2kGWKCvXsrk2LYLX0fwm9NBo5rPoJ4nfl+BX7RGxvet8iViuZYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MgsJDuduXDowDefrM+4tip3gcEf/phakGkhmADkbMaE=;
 b=B3ayDzEF2DWWbeA+LhoTOAdL2sLJvD3RhOANyiQcVGerkxhPrGQ/b/pL9NoyoNHBF4PvrrZj6eujD0bxqPWKMR8CGC2nWdgfU+JlZZl67JaZkxw22GPz3teHoss/xXi+oLOARmDSzQ9hYEa3Rq9CS13dFgI8Le+Q66zWwPHRfuc/UsZT1t4HdQHD+czBYZAMbRhqko/qWNGMU1itb0y6kZXKQYGXFXJ54YdVRCBKLbCWxcqXel8/a7vVhe6KB6Ix5TaQvazJyhqiW7oyOc3KuaSCHTBTxvd/hDUVUijXBuRW+y+9hVRxYFHendsHuKXOHbBeYh4s+IQMCWFBMQ/VFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by SJ0PR11MB4911.namprd11.prod.outlook.com (2603:10b6:a03:2ad::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Wed, 7 Feb
 2024 01:43:42 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ff69:9925:693:c5ab]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ff69:9925:693:c5ab%6]) with mapi id 15.20.7249.035; Wed, 7 Feb 2024
 01:43:42 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "Kalra, Ashish" <ashish.kalra@amd.com>, Tom Lendacky
	<thomas.lendacky@amd.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: "x86@kernel.org" <x86@kernel.org>, "Hansen, Dave" <dave.hansen@intel.com>,
	"kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "bp@alien8.de" <bp@alien8.de>,
	"mingo@redhat.com" <mingo@redhat.com>, "hpa@zytor.com" <hpa@zytor.com>,
	"luto@kernel.org" <luto@kernel.org>, "peterz@infradead.org"
	<peterz@infradead.org>, "Gao, Chao" <chao.gao@intel.com>, "bhe@redhat.com"
	<bhe@redhat.com>, "nik.borisov@suse.com" <nik.borisov@suse.com>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>
Subject: RE: [PATCH 0/4] TDX host: kexec() support
Thread-Topic: [PATCH 0/4] TDX host: kexec() support
Thread-Index: AQHaVDdZtDgH2S2eJ0eogFGsYKpb77D10HwAgAWGbQCAAl0qAIAAcW3Q
Date: Wed, 7 Feb 2024 01:43:41 +0000
Message-ID: <BL1PR11MB597813163A56BA75B0EDE60AF7452@BL1PR11MB5978.namprd11.prod.outlook.com>
References: <cover.1706698706.git.kai.huang@intel.com>
 <c86203a5-0223-4824-888e-76ff9565e178@amd.com>
 <23b05fe0-60c5-4cd4-bfe8-b706c34d23ac@intel.com>
 <073bad3d-7a4e-43da-b9b4-3123ce1e2da5@amd.com>
In-Reply-To: <073bad3d-7a4e-43da-b9b4-3123ce1e2da5@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|SJ0PR11MB4911:EE_
x-ms-office365-filtering-correlation-id: f9a4da78-8978-4d3e-3b36-08dc277e36ec
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HhkGcLY6zWrNNxaJDqMIAvdX0FOf+pujjg+1tixKMV13yIgPH2Aa1xGmmStSUHjF0GnNvMUk0x5Ub5DzZxdjYDz4C3Y3u3iTR4n7pmAHBCv2y7j/FjnnmcCo7rYF3Kn+fh0NbzOizARKBq0+hFGTnwbaOX0Ud78xidqluHCs2+NgGXBFtbQe+D24CBNZH84pW+tAY0nrEhg6nTAI+RSANrQ6cdUsjnnEjphOPQpSQ3b5bQMEdNccFhCz7oCz7b1oPWWr6gC5VYn7w1X5fgb+ED4uOjW2fF+6s8wsTxDbjm6cDl8AHDcGHDr1tC8T95xstDkMWp3+WRW1pcQDli61BLFoxqErxveZs2/ibgV8v4o5dcd2ssKsZa2TI5trxTAJyScifk1mC137Zc2H3/RdXFZmTOQqggucuY0S//6WWNJVuuLC0cE/NaGMSQzjYv/NBLOok1IcESLLptHyerrjhoyehRuWrGlNrim1H/lOaYPvXumP7gEdGRYvI+ik8De0gCs/EYnCyf5lqOxnIzw6cJikp568HmUst3YivgwGlt9wgeRoTGEUPwgZD8BhQnC+PaGW7ArX6T+CHc4Pbk4OE3wtswAobJIxJ7uoXYHMKnpQYpl3uhXCgphpnVYjHtdX
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(39860400002)(136003)(346002)(396003)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(41300700001)(76116006)(86362001)(8676002)(52536014)(4326008)(8936002)(7416002)(33656002)(5660300002)(478600001)(558084003)(6506007)(9686003)(7696005)(71200400001)(64756008)(110136005)(26005)(66446008)(66556008)(66946007)(66476007)(54906003)(316002)(38070700009)(122000001)(38100700002)(82960400001)(55016003)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZkMvMEFURVpMdHlLU3RoZU9hSy9JNUsyeFRpeTloa0FYMXJZTjJvRkpISGJS?=
 =?utf-8?B?Y1hQMmdQcGRZNWpUbEpSaXlkNU1lWjN1R0FuY3R6VUxnVmgyMHM3RXVvbEhT?=
 =?utf-8?B?L0oxM0NCVVNSdENWMW0zUUJGWE5NUXpkRnRpKzM5MnNKZlNWRFhPcnVFMDJt?=
 =?utf-8?B?eHhrNkVEMGdaRWFwUUN3OGlpcklFWDUvazlGRENrL25BTWVnN0tTQXJJWFJJ?=
 =?utf-8?B?RjAwZnIzcjBXTGUvNXFFSE1IRTN1OFJzdzhuMGg3OVRENFpBaVdqVWwrQUhh?=
 =?utf-8?B?YUVKa1hiRTVueVM5OGVVbk9zQ0N3Yi9ubnBQOXY1SjU0MmlhQnFWdVhqb1Z2?=
 =?utf-8?B?MjhXS1QyZGU3Q1p2RWV3Q0o4UFF3VG5MRTRoeFRlY3RBQUxaT1NlTWNBeWtV?=
 =?utf-8?B?L0RvVnQzckhOY0ZnRDUrSnFLZWFDVDgvaGp5TmFFeWJqTUk0R2hxTmFCaHl1?=
 =?utf-8?B?WWxlenNHS2FBYlo4S0xycFM2UGRzSUVpUWlDUWxNdCtBenc1aHg0QjR2YmtU?=
 =?utf-8?B?NHBpTmpnNnhCR2t3T3owa0VPUm9ibE1Qb2xZQVBaZHdXOWJzSkFtNkt2TTNv?=
 =?utf-8?B?OGdNVFRwOTEwOUVhVU5nSlZKMkMrbW5GRWxoc0cvRzJ3Nk1NZEhoN1FEMDMv?=
 =?utf-8?B?dTJQVGpTVVVlTkhRbHZxNHZZM1RNdkpabjc3dVQ3MDBZS1BIcUhVT2hpQTA4?=
 =?utf-8?B?Z3F5SDQrUWNzcHZQd21jbFRINVdjaXBzM1RkenZDNWJ0YmkrWGRybDgwVzRI?=
 =?utf-8?B?LzZKNlBnN290NVQ0SXVWbjVsblk0RFZWZms3TU1ocURXcFhDTWl4ZDVsRFhM?=
 =?utf-8?B?bFFlUjg2dS9pK3pOWGd6OXVYd2pFZmZDS2NUMkFvemdHSDNJcDkvck5ZZFBy?=
 =?utf-8?B?SEcxUmdyRnVMSndPQThjbUp4S2tzT1ZPRjBZMmlZdkZGSUpFcjBuclFtUnRi?=
 =?utf-8?B?aTF5UitTdWxoNmtDSFk2V2FSaENLak5kMFZZR3laSS91dDFMbm05VDFIbkFQ?=
 =?utf-8?B?aXRxdUJZVDRrbi9BdjB6L2V6UUdnRmtqbTNaTjJSbjl2OHVyVmdJTTYzOWRF?=
 =?utf-8?B?NGNSL2h2WXRoUkpUVStRb3ZIVU5lSkhuQ2JEVkM5NE5nV0ZsNitvSnRCKzd4?=
 =?utf-8?B?VXBFZFQvTzVrWW5MM1VpV1d6bThjY0FSUXlyTnQvNDlYN3hoZjhLTm5ZaFNG?=
 =?utf-8?B?cnV0Z2RkSGFaSTNQbGFYay9CaEtLVnF2Tjdpdmo1TkZ4QlVib0FTOWloTzhE?=
 =?utf-8?B?Zk9FRTlNbHRoS2dKcTB4b05POXB1MjFJaEZJaVdCYStCRGJONDNQNTVwYnl3?=
 =?utf-8?B?d1FabERUQ0gvOFA5SlNuT0ttSVJyWnpjcE1FWU9DMVlFWTR4cGRFREtrWVJF?=
 =?utf-8?B?SjJZcTQ1cklVTFhVWmh0MDFyeWtXUStNdW9DM1lNWmcwMUdGaEpmK013OGhx?=
 =?utf-8?B?R21BMXZjR3pmUEp0YVBXSVlmTnJ2dGorQmNQWVV4R1hnUi9aWkJtZWpoVkRt?=
 =?utf-8?B?ZEFIMjNJL1lWQkJjRVcxNTRPc0QzeW53Z1hoVjR2djF5OC95QjI4THR1MVJP?=
 =?utf-8?B?cHRDNHBDR0N6SmltV2RPT1RMeW1FTUtKZnFzVnR4T283Y3o4UnFGaWVxZElx?=
 =?utf-8?B?ZFBSTm9zc2tTMWZPSTQyVFpJcW94L1FsTVp5bjNjbTBMbjJ0T1pXUEdpM25m?=
 =?utf-8?B?R1pFQUpZVWcyTFVmR3U4NHZSOXNVNlRQUXllcnV4MU1Ma3hRQnZuZGJ4S2NM?=
 =?utf-8?B?TjJSUi9VN3ZSaUUyQmxJOWxsdU9vR3VHTy82QjNuL0F3R2w3V05sbzEweVJF?=
 =?utf-8?B?cHhtRmtBd1RsdUR6NkJneUtqOTZVY1A5NVo2YWpPWjN4SUVtNjRsVjVkLzdX?=
 =?utf-8?B?aVcxWVp0TGxVVllPZm03OXVvbGdHc1ZJZ1pwOXlRWk9QZjJHQi80UXdjZEE2?=
 =?utf-8?B?cUQ0c2R4Q01Idlg2RG9wRlJZVnZGUTZFRnNrUVBvTVZrcUdzZ1BJTHFJay96?=
 =?utf-8?B?MWc4ei93VHo0bTY4Q2M3ajZubUg3VUNKUWsycjVrNXhtZ0tCaGlmdGowa3N4?=
 =?utf-8?B?NGlXODc1RkpmMkNHcjhERXVFVVcvZ1NSVTRwMFRWdjdZL2YxU3k3TEllbjY0?=
 =?utf-8?Q?yXtQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9a4da78-8978-4d3e-3b36-08dc277e36ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2024 01:43:42.0146
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vkdRzFXs8WX9IOZjxdArAfopEwJaD0/vKIqUeFXQPNU9DF7YuGuqUBqx2GUtp7N+ceFGy0er1SuOPAkmTpuVTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4911
X-OriginatorOrg: intel.com

PiBIZWxsbyBLYWksDQo+IA0KPiBZZXMsIGkgYW0gY3VycmVudGx5IHdvcmtpbmcgb24gU05QIGd1
ZXN0IGtleGVjIHN1cHBvcnQgb24gdG9wIG9mIEtpcmlsbCdzIFREWA0KPiBndWVzdCBrZXhlYyBw
YXRjaGVzLCBpIHdpbGwgaGF2ZSBhIGxvb2sgeW91ciBwYXRjaC1zZXQgYW5kIHRlc3QgYW5kIHJl
dmlldyBpdC4NCj4gDQo+IFRoYW5rcywgQXNoaXNoDQoNCkhpIEFzaGlzaCwNCg0KSSBhcHByZWNp
YXRlIQ0KDQo=

