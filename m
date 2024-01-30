Return-Path: <linux-kernel+bounces-44833-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A6D18427F5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 16:24:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9215E28E4ED
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 15:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AE3E7E79A;
	Tue, 30 Jan 2024 15:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m140FU6/"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7069823DE
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 15:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706628127; cv=fail; b=tVD01tRE53e0V7XiSKqz98IQI/OrDwGj/d/3tzL5PpmfOCTcfpUuPOFz7WV5t30SaMqlUvEW2aNMDIOU1fPyUDKh1K+pJ6CtXIMTHQaaecSsMlgIc0TpnIycs0UVd4edu28v/iK2RmLnb7rc/Me3PAVOhjr8rzRZHa3JE7oBd5E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706628127; c=relaxed/simple;
	bh=zHZN/XT1VHZL3FB+ondvoe+7s2+njINqfY6puDV2J5E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tgrehqKb2SEVD6H96r5x6S43uFZr8huJMBVM/vJe2TP6Wb+FGsb3tFX+SZA1O9VUrmf6GjBroMiCT5Val6iclmkOoj0VFiw9oCeHl1/OyjgLqpPkmw1hWQn64WxIjPdYLrCpGZhjXffEANwc+5CXkJcpKMdmd4ehBXrQjXYZ+BY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m140FU6/; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706628126; x=1738164126;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=zHZN/XT1VHZL3FB+ondvoe+7s2+njINqfY6puDV2J5E=;
  b=m140FU6/x8MdQzbzLPvG4iSw9ZvbZk9rRgaTB1IUN2XglTxviItUtXcM
   DLKznRLrK8lpHPLa5MGn2AZUDhNKvZrEW61566zhqRyKNBrvAViTQrpFv
   K8h7qusEbmJsf7cVIuJFbTntTjmHrDUm713HhxtXJSIrBZlqIpxjDEGIg
   VbHyC/tzLzXAU23mSbajhQ0LthN78ASbgIhVyOH3UrPTdYhanHDoPrG+4
   A3cuocGPzNQjKt0Ff6O3kyKC1LAdZU52geZ2YSKn0VVNbJd4I1tuBjsMS
   sjH5z5ZDq3mh0QyfnkyZmLoaHsUMwPHwNyopBbrTFp1eeBDZ18EzJFa5d
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="10055584"
X-IronPort-AV: E=Sophos;i="6.05,230,1701158400"; 
   d="scan'208";a="10055584"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 07:22:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,230,1701158400"; 
   d="scan'208";a="3746861"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Jan 2024 07:22:04 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 30 Jan 2024 07:22:03 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 30 Jan 2024 07:22:03 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 30 Jan 2024 07:22:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fqkb+4eOz3MFkyuA8+LxXJV5X3OYl4FA0wGMZyFg4gPVbszA49H06WXU0CVl0KYJqSe+73dgCA0QreLIsKgJkkbrydyehtenYEgoYH0jAWksA/nIMbQnRo5soyBWwG1k0afE6Ls+A2Ei2QQQoYCsjuU4DB8e9C00d1LEPmLv6Ley2NNoAorBV/nwaZZ89g6jS2/dMhE0b1a4GoXdtCUYqbkU3qhaskZNp4TlmudD9Tl/4Ct4U0y1SxQChhAuyfy//jN08RNBGRjF7b6GM3zkgOjAtoRg5YOV+F2lfWQUoCu55QKLlziK3JUTXpqcn5Mnx9zPhsyneLL7nmGVoCyQug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zHZN/XT1VHZL3FB+ondvoe+7s2+njINqfY6puDV2J5E=;
 b=odGgk+dYtSJwb/+tWRbNqvx/BYJTya1MlloGN3s/6ZlRr6xVdQsSJ1dKK+izZvu1yh12tuqKIOJQMLEonYn327NHb8kgsn0hLUKd3JhuA36ZJkk4Q1/vIsW0Zgmn8Kl2Q/7r5T+fSTj4AqG37DjxTqLs/z4S2W1AXpxt4kXgl81WfqnFbVlRNOeaSwnVEmelHo2Vf4o1QdMISPTRBze5M+JD4SXWwluLDUBXrhk2jLxTCUDAcDgat9R1gPc8kcsO9zE9w0rINPI9sgjUEdoQtGUTb/ylXZF3Iqby809bbdCmQDwgHIvbak2ydphaT4ObSXRUR2GGw/+MrKNYGE0CLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA1PR11MB6734.namprd11.prod.outlook.com (2603:10b6:806:25d::22)
 by SA1PR11MB6919.namprd11.prod.outlook.com (2603:10b6:806:2bc::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Tue, 30 Jan
 2024 15:22:01 +0000
Received: from SA1PR11MB6734.namprd11.prod.outlook.com
 ([fe80::8ccb:4e83:8802:c277]) by SA1PR11MB6734.namprd11.prod.outlook.com
 ([fe80::8ccb:4e83:8802:c277%4]) with mapi id 15.20.7228.029; Tue, 30 Jan 2024
 15:22:01 +0000
From: "Li, Xin3" <xin3.li@intel.com>
To: Borislav Petkov <bp@alien8.de>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com"
	<mingo@redhat.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>,
	"hpa@zytor.com" <hpa@zytor.com>, "luto@kernel.org" <luto@kernel.org>,
	"Shankar, Ravi V" <ravi.v.shankar@intel.com>, "andrew.cooper3@citrix.com"
	<andrew.cooper3@citrix.com>
Subject: RE: [PATCH 2/2] x86/fred: Fix build with CONFIG_IA32_EMULATION=n
Thread-Topic: [PATCH 2/2] x86/fred: Fix build with CONFIG_IA32_EMULATION=n
Thread-Index: AQHaUQj02gjTP2yv1ECwmfq/9SS72rDyUx0AgAAgzgA=
Date: Tue, 30 Jan 2024 15:22:01 +0000
Message-ID: <SA1PR11MB6734A226858F6030C86AE2E5A87D2@SA1PR11MB6734.namprd11.prod.outlook.com>
References: <20240127093728.1323-1-xin3.li@intel.com>
 <20240127093728.1323-3-xin3.li@intel.com>
 <20240130124816.GCZbjwEFrZS55FLxb8@fat_crate.local>
In-Reply-To: <20240130124816.GCZbjwEFrZS55FLxb8@fat_crate.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB6734:EE_|SA1PR11MB6919:EE_
x-ms-office365-filtering-correlation-id: c8603997-85d0-4cd7-ee00-08dc21a7350b
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JVo3kPuHGpWu8y8TNZ6+1pleb2u/f7yOK/xg58ZsNKFmI5ZFP81MGqOIRy8L0rHkmfa5JRd6J9stfC4woS2i9VbeBrHT9O4raQntyKZR/7eJ4WpYW6GSnK7g0rTZHCZLdBmm+gmwPS9+h101zGIR/H7ul3gAwSlT7XO8VjoEcqYeY5gC1jKidU4EfGr+36XUlGYNVpOwiuxPi1K7hpotCZyTmmRe0x7QggYQfv4rwdpDsEbARQGu53avspEwJGEcSDLh7gunGLWdA7hqZrsiTT9gnZhTtdJk2WmdZcq5boCmd8hniN2UeLajxad3pF6NIkbHivQbj+JPq4mwT1nzdL7JelmuS1E2t3nkSppVhXdGyRWdSmUzTnb/xg2X1W0dXBeFsMcqW1d0xCsowdhtl9ZZOM1jV0RUsT2L3QojBa6/vH7KJdO7WLJLjuPlSKDC0v7zIOJ6szfJYGw+UEbjE3Qc3F74l1R09QGSroZRk0yloCa4kgWHTqG2gNPU0bW4R5s63ptv76EEqY3mxkFBq3CmFAzdiaD+ooxZAaX9AJ1crF1SaKfUvQdbtDWtXNkKCAoypc9xo1OoZF/x40TwXkwMCBMfuUhQSAAXuKokgyc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6734.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(396003)(136003)(366004)(346002)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(66946007)(66446008)(316002)(76116006)(86362001)(66556008)(38070700009)(64756008)(33656002)(6916009)(54906003)(7696005)(6506007)(8936002)(66476007)(966005)(8676002)(26005)(4326008)(478600001)(2906002)(71200400001)(9686003)(52536014)(5660300002)(41300700001)(82960400001)(122000001)(38100700002)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YnIrVFZwVDYvWXVQclp2VnZhZDRQakJJR3g4UlFQSmw2cWZ0R0JibVBURUgx?=
 =?utf-8?B?Q2Y4L0h5R0JXZnM3MmptRkNDY3pzUFhpRzcyMmltckRTZTY0Q0lNaEFUWkxI?=
 =?utf-8?B?WkF2QVY4elA0S0xGNmNVZ2Y2NHM2V2pXZjVUeHVmNFgrUDcvL1p2RHFTdkNL?=
 =?utf-8?B?OTR4eTJVTmN0TmtsZ2pmSFB3cmxEYVBLZnk5dUNmaGVMTVNMc0hyU2U5Njgr?=
 =?utf-8?B?c2VDQnpJK0poUVhiUEZHek92c2UyQ1JqclFyZitYMzRmK2t2SzN2RnlSa3Zq?=
 =?utf-8?B?ajgzY2lKRWRORlBYWE1oNi9haTF3L2F6RlFoK2prOUJ0UER2NWtHbEtaczla?=
 =?utf-8?B?V1NFMGR5VGRicXFmR09RUlJueVNVKzRpSWI4cVVVK3IyWjVGVS84OUFXN2tx?=
 =?utf-8?B?Mlk3R24xSnFqUC9DbGpRNTF6ZVBnVnU1UGdNNU1xWDVvWUlMT2RUOHY0T3Bv?=
 =?utf-8?B?MEoyRUVtTDNacjRoTXI5ZHpXNVRlUUdOY3BxNENQZkk4c2ZVK1RNamF0QXdy?=
 =?utf-8?B?RlVFYWl6QUNUbFQ4cENhVTIxTENWMUovRlhWeEhVbTY3VDFvbGNnUVVNRlh5?=
 =?utf-8?B?N0Q1UHlCY2szOW56V2M5NHdHYlF3MW0zU3pQZXBPOUluaEhMajhRcEtSWnpU?=
 =?utf-8?B?NjZzK2NCMFRHZTNyek8xQ1l3Y3czQTBIR01mRDdiNG5BL3oyVllISS9iaXE2?=
 =?utf-8?B?WllPbEJtU05GY2VPbXRWVkcwUVQwY3dVK3VGQTlrUzV5cHFjTnNxRVlCa0xZ?=
 =?utf-8?B?cENnOGNhUU13NFpZU3ExVTlZeVZTYzYrSVoxamFHNmVFSXV6NlYrWkxqRXZW?=
 =?utf-8?B?NHlzZ3hRRGJ3Q0x3Tld6UXlJTkdxSlR0emZqK2NDSG9mUzgyYkJSVnRmTFM1?=
 =?utf-8?B?cXVDajQ5TURBQkNrWFRBcHh2K3NTZVo0SFlTRWxjWTlkbmRsOHdoOUN6RnRi?=
 =?utf-8?B?YjhTd1grR0c2cHJUL0k1WWJCNWcrQ2k5M0REaks2Z0pDMDloRk8yd0pIMDBX?=
 =?utf-8?B?aEN2WVl1L0RKdlRDVkNtWWMxSDRCNlltdU9nUk0ySnZlcnRTU1NnV0dXT2Ry?=
 =?utf-8?B?eHd1dE4rUzQvVG9MN09MTkdJWTBGTXJISkJtQWhQdUJUL016MW9SdUQvckZX?=
 =?utf-8?B?a3h2V2drU1craVJVMkdsNXptNWZXa3JpcDNZZjNya1FLb3B1WTRjMUhzVE9B?=
 =?utf-8?B?T2cvcTIzQnJvak5JdzF5UlZva2lIWXY5aTNqcHpOTUI1TTJxaStDQzJUUkh2?=
 =?utf-8?B?UnBTbXpPaWx2ajQ3VU9ndGxpOWs3WnJRdVk5TzRrRndRZHQ5SHJuVm05ZjJT?=
 =?utf-8?B?KzNkWnZJRkY3N3NzazRJaEdmRjMrVFc1aVVEbDE4UFFmU2d3TzNYL2doT0xK?=
 =?utf-8?B?bHFmMDVLSGpiK0Z2NGFrT1FqWStHUSsxbUJsOHZqbFFMMHVoSDFwU21HdGds?=
 =?utf-8?B?WStxWmFVd21yUEI1aWIrRFh1eHFxV3JrV205TnMyLzhpQ2lvd3A5ckVrcHJx?=
 =?utf-8?B?TEtCbTBreldmSmtCb20yK1duTHhLN1ArSnUyOEVJbzVQT1FrVzFCYm40UjRi?=
 =?utf-8?B?c21GRnF4cXorc3NxOVpjUFpJSXpTaFBpUXZ2d3dqdW5TMTE5eUJlUVI1ZDY3?=
 =?utf-8?B?TlBXb0ZHVVVUUTNkWGdmU2pYZFUzbEhETHhlb0IwRE9yVVFhZFpneE1HWU4x?=
 =?utf-8?B?d2JSc0JEcHBhMkk4UHhiZjFCWWRTR3Fqam9kd21Wc2wyRHFubkpyNThzRmVF?=
 =?utf-8?B?NitiQkpuUFQvM0t2Y3JmYjFoU2U2QjRTbDRLdnFMUTI3blRGVzJlWFhHeHdt?=
 =?utf-8?B?NDkrcllib3F2MFcwekhGRjE2cnAyNHpEb1RlL0dWek1YY3VCUWYzLzZ2cUZn?=
 =?utf-8?B?Q2ErSVVsd1ZpY283bHZvbFcxa0tpNkRqSG95YkZWU0VRUDJlQ0Q1SlpmTnVK?=
 =?utf-8?B?a0pDM01rTnRzZUY5akE4Q2lTbVhNNkJSZGZ0VDU0U2tjTmpCK1VBNkNmQ05v?=
 =?utf-8?B?cnVTZUVnYmcrR3U4Q2s1eFAybzVGK0dQRkRkcGFDL09HTXhqMzVQT1FvUUZa?=
 =?utf-8?B?bzRxb0pPZkFHQVhkS2VQK09ZOGFOQnc3QThqdWVxUS8zdHdDdnlGWXprMnpG?=
 =?utf-8?Q?Q9XQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6734.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8603997-85d0-4cd7-ee00-08dc21a7350b
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2024 15:22:01.2451
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wnNSAnBcCzk5ZSOdGCwDORgKShkiAqDq1ZNv2aDsmxokMwBGaIsYK7DHNYJH5+DrGaCF6e6kAglF35oD71P2aQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6919
X-OriginatorOrg: intel.com

PiA+IFdoZW4gQ09ORklHX0lBMzJfRU1VTEFUSU9OPW4sIGludDgwX2VtdWxhdGlvbigpIGlzIE5P
VCBkZWZpbmVkLCBmaXggaXQuDQo+ID4NCj4gPiBGaXhlczogNWUwNjM2YTQxNDg1ICgieDg2L2Zy
ZWQ6IEZSRUQgZW50cnkvZXhpdCBhbmQgZGlzcGF0Y2ggY29kZSIpDQo+ID4gTGluazoNCj4gPiBo
dHRwczovL2xvcmUua2VybmVsLm9yZy9sa21sLzIwMjQwMTI2MTAwNTE5LkdCWmJPRDN4RkIwdjNt
cDVCMUBmYXRfY3JhDQo+ID4gdGUubG9jYWwvDQo+ID4gUmVwb3J0ZWQtYnk6IEJvcmlzbGF2IFBl
dGtvdiAoQU1EKSA8YnBAYWxpZW44LmRlPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFhpbiBMaSA8eGlu
My5saUBpbnRlbC5jb20+DQo+ID4gLS0tDQo+ID4gIGFyY2gveDg2L2VudHJ5L2VudHJ5X2ZyZWQu
YyB8IDIgKysNCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4g
ZGlmZiAtLWdpdCBhL2FyY2gveDg2L2VudHJ5L2VudHJ5X2ZyZWQuYyBiL2FyY2gveDg2L2VudHJ5
L2VudHJ5X2ZyZWQuYw0KPiA+IGluZGV4IDA2ZDAwYzYwZWE2NC4uYWMxMjBjYmRhYWYyIDEwMDY0
NA0KPiA+IC0tLSBhL2FyY2gveDg2L2VudHJ5L2VudHJ5X2ZyZWQuYw0KPiA+ICsrKyBiL2FyY2gv
eDg2L2VudHJ5L2VudHJ5X2ZyZWQuYw0KPiA+IEBAIC02MiwxMSArNjIsMTMgQEAgc3RhdGljIG5v
aW5zdHIgdm9pZCBmcmVkX2ludHgoc3RydWN0IHB0X3JlZ3MgKnJlZ3MpDQo+ID4gIAljYXNlIFg4
Nl9UUkFQX09GOg0KPiA+ICAJCXJldHVybiBleGNfb3ZlcmZsb3cocmVncyk7DQo+ID4NCj4gPiAr
I2lmZGVmIENPTkZJR19JQTMyX0VNVUxBVElPTg0KPiA+ICAJLyogSU5UODAgKi8NCj4gPiAgCWNh
c2UgSUEzMl9TWVNDQUxMX1ZFQ1RPUjoNCj4gPiAgCQlpZiAoaWEzMl9lbmFibGVkKCkpDQo+ID4g
IAkJCXJldHVybiBpbnQ4MF9lbXVsYXRpb24ocmVncyk7DQo+ID4gIAkJZmFsbHRocm91Z2g7DQo+
ID4gKyNlbmRpZg0KPiA+DQo+ID4gIAlkZWZhdWx0Og0KPiA+ICAJCXJldHVybiBleGNfZ2VuZXJh
bF9wcm90ZWN0aW9uKHJlZ3MsIDApOw0KPiA+IC0tDQo+IA0KPiBUaGF0IC5jb25maWcgaXMgc3Rp
bGwgbm90IGhhcHB5IGFmdGVyIHRoaXM6DQo+IA0KPiBsZDogdm1saW51eC5vOiBpbiBmdW5jdGlv
biBgZnJlZF9lbnRyeV9mcm9tX3VzZXInOg0KPiAoLm5vaW5zdHIudGV4dCsweDE3N2EpOiB1bmRl
ZmluZWQgcmVmZXJlbmNlIHRvIGBkb19mYXN0X3N5c2NhbGxfMzInDQo+IG1ha2VbMl06ICoqKiBb
c2NyaXB0cy9NYWtlZmlsZS52bWxpbnV4OjM3OiB2bWxpbnV4XSBFcnJvciAxDQo+IG1ha2VbMV06
ICoqKiBbL21udC9rZXJuZWwva2VybmVsL2xpbnV4L01ha2VmaWxlOjExNTg6IHZtbGludXhdIEVy
cm9yIDINCj4gbWFrZTogKioqIFtNYWtlZmlsZToyNDA6IF9fc3ViLW1ha2VdIEVycm9yIDINCg0K
U2lnbiwgSSdtIHNvcnJ5IGl0IHN0aWxsIGRvZXNu4oCZdCB3b3JrIHdpdGggR0NDLg0KDQo+IEkn
bSBwdXNoaW5nIHRoZSBsYXRlc3Qgc3RhdGUgSSBoYXZlIGhlcmU6DQo+IA0KPiBodHRwczovL2dp
dC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9icC9icC5naXQvbG9nLz9oPXRp
cC14ODYtZnJlZA0KDQpCZWNhdXNlIGNsYW5nIGNhbiBjb21waWxlIGl0LCBJIGNoZWNrZWQgdGhl
IGdlbmVyYXRlZCBhc3NlbWJseSBjb2RlIGFuZA0Kc2VlIHRoYXQgY2xhbmcgb3B0aW1pemVzIGl0
IGJ5IHNpbXBseSBjb252ZXJ0aW5nIGlhMzJfZW5hYmxlZCgpIHRvIGZhbHNlDQp3aGVuIENPTkZJ
R19JQTMyX0VNVUxBVElPTj1uIHRodXMgbmV2ZXIgY2FsbGluZyBkb19mYXN0X3N5c2NhbGxfMzIo
KS4NCg0KSXQgbG9va3MgdG8gbWUgdGhhdCB0aGUgZm9sbG93aW5nIHBhdGNoIGlzIGJldHRlciB0
aGFuIGFkZGluZyBhbm90aGVyDQojaWZkZWYgQ09ORklHX0lBMzJfRU1VTEFUSU9OIGFyb3VuZCBk
b19mYXN0X3N5c2NhbGxfMzIoKS4NCg0KSG93IGRvIHlvdSB0aGluaz8NCg0KQlRXLCBJIGhhdmUg
dGVzdGVkIGl0IHdpdGggYm90aCBHQ0MgYW5kIGNsYW5nIHdpdGggQ09ORklHX0lBMzJfRU1VTEFU
SU9OPW4uDQoNClRoYW5rcyENCiAgICAgICAgLVhpbg0KDQpkaWZmIC0tZ2l0IGEvYXJjaC94ODYv
aW5jbHVkZS9hc20vaWEzMi5oIGIvYXJjaC94ODYvaW5jbHVkZS9hc20vaWEzMi5oDQppbmRleCBj
N2VmNmVhMmZhOTkuLjAxMzQyZDM0M2MxOSAxMDA2NDQNCi0tLSBhL2FyY2gveDg2L2luY2x1ZGUv
YXNtL2lhMzIuaA0KKysrIGIvYXJjaC94ODYvaW5jbHVkZS9hc20vaWEzMi5oDQpAQCAtODEsNyAr
ODEsNyBAQCBzdGF0aWMgaW5saW5lIHZvaWQgaWEzMl9kaXNhYmxlKHZvaWQpDQoNCiAjZWxzZSAv
KiAhQ09ORklHX0lBMzJfRU1VTEFUSU9OICovDQoNCi1zdGF0aWMgaW5saW5lIGJvb2wgaWEzMl9l
bmFibGVkKHZvaWQpDQorc3RhdGljIF9fYWx3YXlzX2lubGluZSBib29sIGlhMzJfZW5hYmxlZCh2
b2lkKQ0KIHsNCiAJcmV0dXJuIElTX0VOQUJMRUQoQ09ORklHX1g4Nl8zMik7DQogfQ0KDQo=

