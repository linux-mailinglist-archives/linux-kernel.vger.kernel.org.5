Return-Path: <linux-kernel+bounces-483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1D998141D3
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 07:34:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BFEA282D9A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 06:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9271CA7F;
	Fri, 15 Dec 2023 06:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cr2fyJEB"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B03F748A;
	Fri, 15 Dec 2023 06:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702622043; x=1734158043;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=e9tu1sr2Nohb5GxurgP53Ujr7jUc3pNJ6Q/dDV2IQs4=;
  b=cr2fyJEBc/md4aSEkV4Fy2dLikTdubZI3KbTgww/u4FrrJng9l4OB92L
   D5aZkHdRg8H/Okm3yNlJYLc1HonjuADWVfm/UvOjSgwvF5vchOPAEzvPM
   6imWgDH9sS9k16lpIhXeV/BRpg8QaivRaoB5HCVkwPNSnPYLFyRwL9T+S
   GyiA+JOLdQvXyqTVzLuZP1i5q92tZPQbNxqjex8xYRa/IFcmwYDttL7rL
   uh+TT3jXL+W+6nJ+otqN6Ejn5GODFdGtqzPheJr3Lz04MaSSY5/COw+vW
   udI8DP5dGo+TgUrqZKu2sMkNDIirLpWVIXhtVSyUz81pCfCb098DRaYxI
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="380231039"
X-IronPort-AV: E=Sophos;i="6.04,277,1695711600"; 
   d="scan'208";a="380231039"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 22:34:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="845016934"
X-IronPort-AV: E=Sophos;i="6.04,277,1695711600"; 
   d="scan'208";a="845016934"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Dec 2023 22:34:02 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 14 Dec 2023 22:34:01 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 14 Dec 2023 22:34:01 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 14 Dec 2023 22:34:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ee2oycF3gNXJP84qKz5Y6LHyU8I/QlgaHwTsECnRqZelsTR5s+BIHoPwcQLBQ3X/lEgwWJpIV9ggSgYS1XZdqUMpGP7w4GSEdmVDWaFTAmpetaMf0s8FHh5VLBAE45myd6vduHWylBb9bGkaJJppG6s49PK4QmnMrWczWDMw4Sv5uqouNZzVi/du1foVLNMkIDQ0PW656xGCgqeWuyQD7Lsx53UCYTuI7mWBE0LfL7H53oGB2RG9No4HApja0ms3kYrZbbbRnc1yPuxzZMO4UhldayM1aOki5m6S3T+tvq8iitti4b1HQtozTtdzcx3zzPjprfUMtnHRYrOVx7NwPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e9tu1sr2Nohb5GxurgP53Ujr7jUc3pNJ6Q/dDV2IQs4=;
 b=TYTuyM7CDajhDgrDdyv9mMXFvUZu6W6aXWY5D1a7tnTeWqluylI0jn4kVp8h1hTWdKiYhf2khYEoCFnYb9MGdH3Ic7Vty4PUokscNOMbfdBXrXOsitplMQ3+iE+NrIyrtpwtutAnLobmXb+FyDFWhDiICoYYHMRIGh9MKkzi+UqUGrmEreU2HEI/sJS01WRv+kWEm0vjIVwA5TEUB0J4USwdrw5+4uCRg8ZoDh2LJ18VfjrauCssIzafjznJGSTz/k4x4UmgLPfnqYkZCJk9DIASBsYF9/HCEAn6qJupTn3t4aHoIB0E10eLP1WyQSrGmVQ0xO6SQgyYB1rLQO6Ccw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW4PR11MB7125.namprd11.prod.outlook.com (2603:10b6:303:219::12)
 by CY5PR11MB6091.namprd11.prod.outlook.com (2603:10b6:930:2d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Fri, 15 Dec
 2023 06:33:59 +0000
Received: from MW4PR11MB7125.namprd11.prod.outlook.com
 ([fe80::703a:a01d:8718:5694]) by MW4PR11MB7125.namprd11.prod.outlook.com
 ([fe80::703a:a01d:8718:5694%7]) with mapi id 15.20.7025.022; Fri, 15 Dec 2023
 06:33:59 +0000
From: "Verma, Vishal L" <vishal.l.verma@intel.com>
To: "willy@infradead.org" <willy@infradead.org>
CC: "david@redhat.com" <david@redhat.com>, "joao.m.martins@oracle.com"
	<joao.m.martins@oracle.com>, "Jiang, Dave" <dave.jiang@intel.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, "osalvador@suse.de"
	<osalvador@suse.de>, "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Williams, Dan
 J" <dan.j.williams@intel.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "Huang, Ying" <ying.huang@intel.com>,
	"nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH v6 2/4] dax/bus: Use guard(device) in sysfs attribute
 helpers
Thread-Topic: [PATCH v6 2/4] dax/bus: Use guard(device) in sysfs attribute
 helpers
Thread-Index: AQHaLxcpu2T6sC1vSk6xtM/1qGvjArCp2LUAgAAKeYA=
Date: Fri, 15 Dec 2023 06:33:58 +0000
Message-ID: <d3eef0c19e949825ad0990a03eb55cc5f3033720.camel@intel.com>
References: <20231214-vv-dax_abi-v6-0-ad900d698438@intel.com>
	 <20231214-vv-dax_abi-v6-2-ad900d698438@intel.com>
	 <ZXvqjIqvcGkumNXf@casper.infradead.org>
In-Reply-To: <ZXvqjIqvcGkumNXf@casper.infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR11MB7125:EE_|CY5PR11MB6091:EE_
x-ms-office365-filtering-correlation-id: 5c9ddc14-3df5-44d0-4518-08dbfd37d1b7
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mAmrwaq6B+CgjWJhM+2O6OsB84Fpzuwn/tzZm5sVBqHCd7ZjuIhRlAatOtIl8okfJlFQ8kRDKfC8FqlaTO/qsUmBg3P2yYhq9HlZppsflwnVOhEX75qrW6LJc96iDlXX7ABL66EaqbIg6S7fVNeldCHZmN/gJ8E7Izc6BdzQwb3GRneNEDvDg+jI87l/PP1xKukrohY+29OZpIl567WBIUADXSXLWcsTvogkC+JZXq0a2/Htcuj/BVRALGmE7siesQGwHQ/MDkRICJDvS4NDE1/ubAndV+yGtdcRmfdgoKy62NGK4mzAAMlIEzovLO5rb7M8R6Mu5EBNx6WNfZ74+t39XQNt+vKgXhsUOQFyQ6XHvS2Hb0vAjWFmPdK8eUxXhaZVUf24PgMhQLp0crkeNYw+oR3jlPP+32Iy3ETlpup8cAzIzt2uz48EAtvTYWCnf/KyUH6CbcyttHVI5m/slTc8WiYuiAQwnyhxM82RXhajaA9QmGm3WIrqbM7DfxP0LkuUvf+Rl+WoJbk0wnSA3oCru9Ot5vd4Z2BS5ksynvdAa580QG9Tqp4rOavnoctBx2Pjxb7Fr0vEsPvNkQ/GNl3bOxrZxlVcqp1zHJb3XQPZmpRtvAUZSfWiopfjSgg+
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB7125.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(376002)(136003)(396003)(366004)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(83380400001)(316002)(4326008)(8676002)(8936002)(6512007)(6506007)(66446008)(76116006)(6916009)(66946007)(64756008)(478600001)(66556008)(86362001)(5660300002)(7416002)(6486002)(66476007)(54906003)(71200400001)(41300700001)(36756003)(2906002)(4001150100001)(38100700002)(26005)(2616005)(82960400001)(122000001)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TDZuWTd0d05TUVBqZkFVVkd2TWFmOEUzUUZmOTlmN3I3NUVOK2FwQWVJeGRO?=
 =?utf-8?B?SFM0TGROR0VTVEMrbVArNUkzck04VGtRa0VMYjFPYTZSeU96K3JEWTNUODZt?=
 =?utf-8?B?c1FLYnhhb0F1VEpVODNUM0lVKzBsNzQ5c2hEcXVJa3hyRmNvUU9SeHJaVUdG?=
 =?utf-8?B?TzhFWCs1RTRoNjBtZ0FZcmpWdHZ2dDBERFZNcnQ0bDRQcWpYOTNMMkFNSm5i?=
 =?utf-8?B?RThpV3ZOU29wSXp6S3prOUZqeGI3TVhIMCtWK2g0YTV0cmJaMzN2Z1NtRThW?=
 =?utf-8?B?NjlJRXlpK3FIc2VPMzhSaDZlU3pzaTVKRGo3VFdMVHlkR1VhU1B2ZXdWTEJs?=
 =?utf-8?B?VXJtSWt0V2EwWmEwYldWb1ZYRkx1d1BMcjg5QXh4OThxZlpRUXdSSlBtL2lx?=
 =?utf-8?B?VVgxRjAvVHh2NzRkZ0MrUURrSmFna1RGdXZLaVgwZzRObnRUODVhYWgrcUN1?=
 =?utf-8?B?U29TME81RlpaeTk4dThkK0E1Tm1LZHlPUFV2a1FjbnRVMmpsRmRyT3ZHVERH?=
 =?utf-8?B?dUxyS3dSK3pkUzZtRWJISVlEd2FqWnFWVUtuMHdYTlhCMmVFbk90eTBFNmx4?=
 =?utf-8?B?ZmYvbjJ0OE5Yc3lteTdiNmNCbGNFQmJ5MGRCRGQ2T3QyeVhsZWJHNXAxNnQ2?=
 =?utf-8?B?elc1NnFId2llUjdQWTVlMXBHSUJ3ZStXMGxFeWpmZ1hHTkZyU21VZGlNdzla?=
 =?utf-8?B?bnlqTTdNRHJFWWFRWUp1Mms3VVdpanpwVVF0eXljTk5BdXlGVVprcVIrYUlo?=
 =?utf-8?B?ZUwxc05pTTdyemlTZ3paWFZ0eGxkTE43OVgyajRkVHFvZkZzNXFBYmFzYnlh?=
 =?utf-8?B?a2JqQ25rMlV3RjhBL0diUE5OVUFJM21iVjVlNmJ0Y1k5bC92RHVSY1NzQ3Iy?=
 =?utf-8?B?S3hVc1QwOWlkV2ZWN2JXSlVqNWVZeExKS3I0bkNZb0loamlhZWhFMzRWODY1?=
 =?utf-8?B?WHhNWVl1RHlETTc4UkRQYjU5QlAyTkQvTXE2WEtsQ0dza1ZyN2dFbXJnV3g3?=
 =?utf-8?B?dVNvS09oeDlGb1VwNVkzdmJkZWZkRVFmQzFaYVBKUGZmMTF5QU9oUU92TDh2?=
 =?utf-8?B?Qm5iSUZvV2ZZZTdjNjRsQ3hlczEwY3p1QXR4cU9OSjh3ajN3VVVQUHlMbTg2?=
 =?utf-8?B?a09Ta3FGVEF6eGJWc2c5ZDVlcFJ4YWlOV25rYlNERHZzMXkzZ3Iza09TSkhS?=
 =?utf-8?B?RkNrdUl1V1dBOHpjdU1hYUV0MERlNGU1c1pVUmFhYWpsSWJIdzZXdjkvQUg0?=
 =?utf-8?B?VDZud2tvRERvSlRxUHJqZTdtSnpOQktQVk9CN2k5STIrTnNqSVVsQlJEcVRs?=
 =?utf-8?B?TzgwVFRuL0tNOUxlQXVscW1aYnFEYVpWOGZTcEljL0pRR1JLVEU2aktsZHpy?=
 =?utf-8?B?amZaVnR3dHhpeFNhSlg2SFJJVDdDVVJWaS9ZQ01zRWJVY0g3WEFKaWxtVnJ5?=
 =?utf-8?B?SXVNT1FURGRrcEN5VDd2MVBQYmlKYThwdm5NbjdpeWJ2bHZ4VFNYWVg3VjRv?=
 =?utf-8?B?cFh2eldFczFwbU1SSHJrbk5iUEJsTXRRek82WFBaak5zY0hSSzN4bEUxVThM?=
 =?utf-8?B?OVNGUzdsU2pwMXc3R0M5bk1EbHpqQzZaQXo4L1VjOXNLNWhObE1Ib2ZRTGpu?=
 =?utf-8?B?dmN0b1krdEtRTkhnSkpDWkk0UVUxVlpOblUzSVJQL2ZmQ04wVDU2YW9LbWQ5?=
 =?utf-8?B?anJackthbnc4cDVnb012c1NOOHl4YWJSQVh5d0xGdmZCcVdQRU9GZklnaEUy?=
 =?utf-8?B?d3lCcUVwSkVQSTFLSHkwNC9FU0Q3ZlNyK0hTMjg0TUFHN0RMODAxK25pR1Bp?=
 =?utf-8?B?c1A0bU5IMFJsT3BkRHFGMjBmbjhFY2dZUWN5Qk1YYWNGditzVWtTekR2QTF0?=
 =?utf-8?B?Vm92ZUhYNTIyVFZOTEdnUzVEMkl5TG5mcS9INGlreDZITDhBM3c1d2ExYWFq?=
 =?utf-8?B?UkMySGN6UGxhaWd0Ly9YMk4yQ21kL0VHWlpucUlvdjR5RnU0Y2hJWFpnTEdq?=
 =?utf-8?B?YXdwTjVRRXU0UnlHUW41WE9ZKzBSMm5PNVltUHF6VndSZWUzclJlbURjOHMr?=
 =?utf-8?B?MEp4MXVVNjRiTHUyeVdnNmRzVGd3YzZveGRONkI3WFQ3S25IbEx4LzZkNGxk?=
 =?utf-8?B?MmVCZ1NURzRiSGladnBud2Q5Z0Yxdms0Y29mQXpUbWdyR0Z1NzYwZHMycTBO?=
 =?utf-8?B?elE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9342294DA339DA44A3222DDFD3754D9A@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB7125.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c9ddc14-3df5-44d0-4518-08dbfd37d1b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Dec 2023 06:33:58.6138
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kpqLyxTNc3t3ACXw3wn0I2GQkvI6rsNDXMN5xez6yqJKYhXxJ/sLVSkKnELyfFYQ2Yyt3aKkeInbXg2zsSZ4cLtStbCZJb8jEUxryIlXqr4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6091
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDIzLTEyLTE1IGF0IDA1OjU2ICswMDAwLCBNYXR0aGV3IFdpbGNveCB3cm90ZToK
PiBPbiBUaHUsIERlYyAxNCwgMjAyMyBhdCAxMDoyNToyN1BNIC0wNzAwLCBWaXNoYWwgVmVybWEg
d3JvdGU6Cj4gPiBAQCAtMjk0LDEzICsyOTQsMTAgQEAgc3RhdGljIHNzaXplX3QgYXZhaWxhYmxl
X3NpemVfc2hvdyhzdHJ1Y3QgZGV2aWNlICpkZXYsCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoHN0cnVjdCBkZXZpY2VfYXR0cmlidXRlICphdHRyLCBjaGFyICpidWYpCj4gPiDC
oHsKPiA+IMKgwqDCoMKgwqDCoMKgwqBzdHJ1Y3QgZGF4X3JlZ2lvbiAqZGF4X3JlZ2lvbiA9IGRl
dl9nZXRfZHJ2ZGF0YShkZXYpOwo+ID4gLcKgwqDCoMKgwqDCoMKgdW5zaWduZWQgbG9uZyBsb25n
IHNpemU7Cj4gPiDCoAo+ID4gLcKgwqDCoMKgwqDCoMKgZGV2aWNlX2xvY2soZGV2KTsKPiA+IC3C
oMKgwqDCoMKgwqDCoHNpemUgPSBkYXhfcmVnaW9uX2F2YWlsX3NpemUoZGF4X3JlZ2lvbik7Cj4g
PiAtwqDCoMKgwqDCoMKgwqBkZXZpY2VfdW5sb2NrKGRldik7Cj4gPiArwqDCoMKgwqDCoMKgwqBn
dWFyZChkZXZpY2UpKGRldik7Cj4gPiDCoAo+ID4gLcKgwqDCoMKgwqDCoMKgcmV0dXJuIHNwcmlu
dGYoYnVmLCAiJWxsdVxuIiwgc2l6ZSk7Cj4gPiArwqDCoMKgwqDCoMKgwqByZXR1cm4gc3ByaW50
ZihidWYsICIlbGx1XG4iLCBkYXhfcmVnaW9uX2F2YWlsX3NpemUoZGF4X3JlZ2lvbikpOwo+ID4g
wqB9Cj4gCj4gSXMgdGhpcyBhbiBhcHByb3ByaWF0ZSB1c2Ugb2YgZ3VhcmQoKT/CoCBzcHJpbnRm
IGlzIG5vdCB0aGUgZmFzdGVzdCBvZgo+IGZ1bmN0aW9ucywgc28gd2Ugd2lsbCBlbmQgdXAgaG9s
ZGluZyB0aGUgZGV2aWNlX2xvY2sgZm9yIGxvbmdlciB0aGFuCj4gd2UgdXNlZCB0by4KCkhpIE1h
dHRoZXcsCgpBZ3JlZWQgdGhhdCB3ZSBlbmQgdXAgaG9sZGluZyB0aGUgbG9jayBmb3IgYSBiaXQg
bG9uZ2VyIGluIG1hbnkgb2YKdGhlc2UuIEknbSBpbmNsaW5lZCB0byBzYXkgdGhpcyBpcyBva2F5
LCBzaW5jZSB0aGVzZSBhcmUgYWxsIHVzZXIKY29uZmlndXJhdGlvbiBwYXRocyB0aHJvdWdoIHN5
c2ZzLCBub3QgYWZmZWN0aW5nIGFueSBzb3J0IG9mIHJ1bnRpbWUKcGVyZm9ybWFuY2UuCgo+IAo+
ID4gQEAgLTkwOCw5ICs4OTAsOCBAQCBzdGF0aWMgc3NpemVfdCBzaXplX3Nob3coc3RydWN0IGRl
dmljZSAqZGV2LAo+ID4gwqDCoMKgwqDCoMKgwqDCoHN0cnVjdCBkZXZfZGF4ICpkZXZfZGF4ID0g
dG9fZGV2X2RheChkZXYpOwo+ID4gwqDCoMKgwqDCoMKgwqDCoHVuc2lnbmVkIGxvbmcgbG9uZyBz
aXplOwo+ID4gwqAKPiA+IC3CoMKgwqDCoMKgwqDCoGRldmljZV9sb2NrKGRldik7Cj4gPiArwqDC
oMKgwqDCoMKgwqBndWFyZChkZXZpY2UpKGRldik7Cj4gPiDCoMKgwqDCoMKgwqDCoMKgc2l6ZSA9
IGRldl9kYXhfc2l6ZShkZXZfZGF4KTsKPiA+IC3CoMKgwqDCoMKgwqDCoGRldmljZV91bmxvY2so
ZGV2KTsKPiA+IMKgCj4gPiDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIHNwcmludGYoYnVmLCAiJWxs
dVxuIiwgc2l6ZSk7Cj4gPiDCoH0KPiAKPiBJZiBpdCBpcyBhcHByb3ByaWF0ZSwgdGhlbiB5b3Ug
Y2FuIGRvIHdpdGhvdXQgdGhlICdzaXplJyB2YXJpYWJsZSBoZXJlLgoKWWVwIHdpbGwgcmVtb3Zl
LiBJIHN1cHBvc2UgYSBsb3Qgb2YgdGhlc2UgY2FuIGFsc28gc3dpdGNoIHRvIHN5c2ZzX2VtaXQK
YXMgR3JlZyBwb2ludGVkIG91dCBpbiBhIHByZXZpb3VzIHBvc3RpbmcuIEkgY2FuIGFkZCB0aGF0
IGFzIGEgc2VwYXJhdGUKY2xlYW51cCBwYXRjaC4KCj4gCj4gPiBAQCAtMTEzNywyMSArMTExNywy
MCBAQCBzdGF0aWMgc3NpemVfdCBtYXBwaW5nX3N0b3JlKHN0cnVjdCBkZXZpY2UgKmRldiwgc3Ry
dWN0IGRldmljZV9hdHRyaWJ1dGUgKmF0dHIsCj4gPiDCoMKgwqDCoMKgwqDCoMKgaWYgKHJjKQo+
ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gcmM7Cj4gPiDCoAo+ID4g
LcKgwqDCoMKgwqDCoMKgcmMgPSAtRU5YSU87Cj4gPiAtwqDCoMKgwqDCoMKgwqBkZXZpY2VfbG9j
ayhkYXhfcmVnaW9uLT5kZXYpOwo+ID4gLcKgwqDCoMKgwqDCoMKgaWYgKCFkYXhfcmVnaW9uLT5k
ZXYtPmRyaXZlcikgewo+ID4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGRldmljZV91
bmxvY2soZGF4X3JlZ2lvbi0+ZGV2KTsKPiA+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqByZXR1cm4gcmM7Cj4gPiAtwqDCoMKgwqDCoMKgwqB9Cj4gPiAtwqDCoMKgwqDCoMKgwqBkZXZp
Y2VfbG9jayhkZXYpOwo+ID4gK8KgwqDCoMKgwqDCoMKgZ3VhcmQoZGV2aWNlKShkYXhfcmVnaW9u
LT5kZXYpOwo+ID4gK8KgwqDCoMKgwqDCoMKgaWYgKCFkYXhfcmVnaW9uLT5kZXYtPmRyaXZlcikK
PiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gLUVOWElPOwo+ID4gwqAK
PiA+ICvCoMKgwqDCoMKgwqDCoGd1YXJkKGRldmljZSkoZGV2KTsKPiA+IMKgwqDCoMKgwqDCoMKg
wqB0b19hbGxvYyA9IHJhbmdlX2xlbigmcik7Cj4gPiAtwqDCoMKgwqDCoMKgwqBpZiAoYWxsb2Nf
aXNfYWxpZ25lZChkZXZfZGF4LCB0b19hbGxvYykpCj4gPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgcmMgPSBhbGxvY19kZXZfZGF4X3JhbmdlKGRldl9kYXgsIHIuc3RhcnQsIHRvX2Fs
bG9jKTsKPiA+IC3CoMKgwqDCoMKgwqDCoGRldmljZV91bmxvY2soZGV2KTsKPiA+IC3CoMKgwqDC
oMKgwqDCoGRldmljZV91bmxvY2soZGF4X3JlZ2lvbi0+ZGV2KTsKPiA+ICvCoMKgwqDCoMKgwqDC
oGlmICghYWxsb2NfaXNfYWxpZ25lZChkZXZfZGF4LCB0b19hbGxvYykpCj4gPiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgcmV0dXJuIC1FTlhJTzsKPiA+IMKgCj4gPiAtwqDCoMKgwqDC
oMKgwqByZXR1cm4gcmMgPT0gMCA/IGxlbiA6IHJjOwo+ID4gK8KgwqDCoMKgwqDCoMKgcmMgPSBh
bGxvY19kZXZfZGF4X3JhbmdlKGRldl9kYXgsIHIuc3RhcnQsIHRvX2FsbG9jKTsKPiA+ICvCoMKg
wqDCoMKgwqDCoGlmIChyYykKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1
cm4gcmM7Cj4gPiArCj4gPiArwqDCoMKgwqDCoMKgwqByZXR1cm4gbGVuOwo+ID4gwqB9Cj4gCj4g
SGF2ZSBJIG1lbnRpb25lZCBob3cgbXVjaCBJIGhhdGUgdGhlICJyYyIgbmFtaW5nIGNvbnZlbnRp
b24/wqAgSXQgdGVsbHMKPiB5b3Ugbm90aGluZyB1c2VmdWwgYWJvdXQgdGhlIGNvbnRlbnRzIG9m
IHRoZSB2YXJpYWJsZS7CoCBJZiB5b3UgY2FsbGVkIGl0Cj4gJ2VycicsIEknZCBrbm93IGl0IHdh
cyBhbiBlcnJvciwgYW5kIHRoZW4gdGhlIGVuZCBvZiB0aGlzIGZ1bmN0aW9uIHdvdWxkCj4gbWFr
ZSBzZW5zZS4KPiAKPiDCoMKgwqDCoMKgwqDCoMKgaWYgKGVycikKPiDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoHJldHVybiBlcnI7Cj4gwqDCoMKgwqDCoMKgwqDCoHJldHVybiBsZW47
Cj4gCkknbSBhIGxpdHRsZSBoZXNpdGFudCB0byBjaGFuZ2UgdGhpcyBiZWNhdXNlIHRoZSAncmMn
IGNvbnZlbnRpb24gaXMKdXNlZCBhbGwgb3ZlciB0aGlzIGZpbGUsIGFuZCB3aGlsZSBJIGRvbid0
IG1pbmQgbWFraW5nIHRoaXMgY2hhbmdlIGZvcgp0aGUgYml0cyBJIHRvdWNoIGluIHRoaXMgcGF0
Y2gsIGl0IHdvdWxkIGp1c3QgcmVzdWx0IGluIGEgbWl4IG9mICdyYycKYW5kICdlcnInIGluIHRo
aXMgZmlsZS4K

