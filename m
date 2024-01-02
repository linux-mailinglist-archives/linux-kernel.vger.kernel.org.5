Return-Path: <linux-kernel+bounces-13987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F99F821687
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 03:41:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E426282002
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 02:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4341ECD;
	Tue,  2 Jan 2024 02:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gTwOn30/"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D3FEC0
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 02:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704163275; x=1735699275;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=k9nvLdFgcGv5u6wJ9Bi1YZUEdSZHg1t5c5MbuHhILOk=;
  b=gTwOn30/aLw/GTeIOKHpMPmPU/tzwO+Wk+f0WAbr2WeH4kFadwNehrsN
   XefmeB8Hrq3gALz9JS4LhwtnlYxx0M5QhjXRweBIgWLzX9/CCz6myTyp5
   A+83dLTzZcKaO4CNnE47bAUh24iUCe2MzVr1e9QcKxvOcfIKyM6bSgNcY
   dpjEJiKtx631pmzJsuvDJTVYd5snI3WEMCCs8UaNzhjSnYbNXe9ZlnjyP
   J8OSGC9mVVEMnukgUbzq1l0nvzyTO3qalqSWIxd2A9BxGn9bwcIwfWq45
   CJ4+nfC/gECX3LVaOKjUyGtn1RG1weJN8G6bJFD6vXYxMUT9VPqU5E81K
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10940"; a="461140305"
X-IronPort-AV: E=Sophos;i="6.04,324,1695711600"; 
   d="scan'208";a="461140305"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jan 2024 18:41:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10940"; a="813801481"
X-IronPort-AV: E=Sophos;i="6.04,324,1695711600"; 
   d="scan'208";a="813801481"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Jan 2024 18:41:14 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 1 Jan 2024 18:41:13 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 1 Jan 2024 18:41:13 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 1 Jan 2024 18:41:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L8euw1Ep5ckJ3Ae8gN35SHPi5NWpvyQOOxVcI7VLDXMIaAvJ0aqMu08AGNUNuTyBo4b7MUZdH/LfZcqwK7niIjnngQv/HNRRLss+n5Egcub9QRZS2mKwg8Pvrm92B4aNIY34fh6a3ZMyFdgolfZpNf3c2bqm4cFfuZhV/trDEYZ36UO0cnzH1dVslSa+4vPRazzwAL66axGP9ojDXsdiq7A2ZOwt3EeMA/4P+BSTZZTxbDjXTVkZ2FPrcBZdsQJEMrgIlG3O8CLZCM6mHyyR+UzxI8qVnDeU8uF0pCErirECLHhdtlXtyTDmQIngSwCxmAq8ky6CLEKMOOQjLEWbaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k9nvLdFgcGv5u6wJ9Bi1YZUEdSZHg1t5c5MbuHhILOk=;
 b=kvg9CcD3IL3bzDy0fpj1NCSAhyKXclaJkdjT8bp1MpxAF2OePb6lraelr7TQzTnyMewokKOAiAmI/e2hdEoi9h83zyHPeUt5Qfyq9cQnlrR5nc1GGx0bDmxcCYx72bi8h8JIAWw/2Do4mC+wOq0JgHNDr0+2LC+iaMuV8Nm44E7oCW9W00HhCokl1fdhqh0PuYg7kzTmQ9RKJqr3lYDJyLVkxfSSpdR664K826pLPRoMVS3CNGlCdiE2EyBt3xRkzMNzDJlfsdFe2nIOX/9j10CG4JIzfxz6I70wmRypLnCh4cAAQdMQcXWBdWhY14rspBXIrgl6XniZw4cfnAtzhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7134.namprd11.prod.outlook.com (2603:10b6:930:62::17)
 by CH0PR11MB8234.namprd11.prod.outlook.com (2603:10b6:610:190::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Tue, 2 Jan
 2024 02:41:01 +0000
Received: from CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::6a88:3d6c:99ec:d988]) by CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::6a88:3d6c:99ec:d988%5]) with mapi id 15.20.7135.023; Tue, 2 Jan 2024
 02:41:01 +0000
From: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To: Andrew Morton <akpm@linux-foundation.org>
CC: "naoya.horiguchi@nec.com" <naoya.horiguchi@nec.com>,
	"linmiaohe@huawei.com" <linmiaohe@huawei.com>, "Luck, Tony"
	<tony.luck@intel.com>, "Huang, Ying" <ying.huang@intel.com>, "Yin, Fengwei"
	<fengwei.yin@intel.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 2/2] mm: memory-failure: Re-split hw-poisoned huge page
 on -EAGAIN
Thread-Topic: [PATCH v2 2/2] mm: memory-failure: Re-split hw-poisoned huge
 page on -EAGAIN
Thread-Index: AQHaNKAJpOMHiZzGXk+DrRHIjPkF6LC1tMOAgBAjJiA=
Date: Tue, 2 Jan 2024 02:41:01 +0000
Message-ID: <CY8PR11MB7134D3ADA0BCDAB938E6E2A58961A@CY8PR11MB7134.namprd11.prod.outlook.com>
References: <20231215081204.8802-1-qiuxu.zhuo@intel.com>
	<20231222062706.5221-1-qiuxu.zhuo@intel.com>
	<20231222062706.5221-2-qiuxu.zhuo@intel.com>
 <20231222114233.68a4fcf2428ae50da6b249f4@linux-foundation.org>
In-Reply-To: <20231222114233.68a4fcf2428ae50da6b249f4@linux-foundation.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7134:EE_|CH0PR11MB8234:EE_
x-ms-office365-filtering-correlation-id: 8e54616c-ca22-4f87-db85-08dc0b3c41f6
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3RXB9Z50afNXMyX5Zxug9dWJjEbyp2dnJ1laLM1aA9tFV9unM6tNIaKgj8slZKxjxKCPGt6nwK+yDBNuYPL2CBEGeNHePmnQsi0IjIHLhsFdTw6eBJxpQQddT1AqIf+hh+i5tRZoLHIXhq2qjmN+YdFpI1LKYVchtLUG7Df1yCpOqvERQONI+5ufbjXIVFHABv9+dm2Ef/LXXH+txn+i+1B1CQ0tGGpZU7ReiQzWzMGczX3dNGluyO/wZl+kdqLpqtYp8jLErQan0gqM8n5O6+hWy+fvOHMUe06WDTN6I2A+wioLjjXtj2fI4sWMXX3kMdkP1heFTnsYteqjQK5vzraFDfQUANy2QxhI1q9c281Q/ziXc9RacPjc6UXXyiK0DiJ2KWBK74OGi/xNgba0fIXuUoTrE3PbkIqGOcIywsKjq1MUFwMDThBrnwrOy2dobIqlvusiCocoe203vFfsS4Fl+w8umV/WuSThAR7I/1eD3FtY6muqsaQlx/zZo+3qFVHqfIS/dcUJ5kLeZA7MRTGTFDhRenZrehJ+VZeMbQrfxS57NQUlETKBSN7toyiIQxTwbIM065tI1bA6y7jD3Z+oG7D9NHlHU4CtoM0qDD6ajPfzshf5opdmJIUVysW4hOYA9DBlNUfiqDquIptRfA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7134.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(346002)(396003)(376002)(136003)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(55016003)(26005)(83380400001)(86362001)(38070700009)(38100700002)(33656002)(82960400001)(4326008)(52536014)(5660300002)(9686003)(71200400001)(6506007)(7696005)(76116006)(54906003)(66946007)(8936002)(8676002)(316002)(122000001)(66556008)(66476007)(66446008)(64756008)(6916009)(2906002)(478600001)(41300700001)(14583001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TmY2NllVaXRBZ2hYWFM2UHVxaUsxUEJOMFhVTnpKSjlxQkYrSmpjbUNTeEt1?=
 =?utf-8?B?bm91QXU4N1lUSTFzSk8vc3FmYTIwQ0hMejEreVhWSlovZ0VNUEtUNXBpQjcz?=
 =?utf-8?B?TXZpa2hMRmNBc054dDkvb0NkeTZHcFRPTHpXKzZEcmR6VDFaSWdGT1p4VkZ5?=
 =?utf-8?B?ZHU2VStNQjJyRzdBSi9icVJVL011Z0tnYklYWkZxTWVvQzR2TTdEZUZiRURu?=
 =?utf-8?B?Qm9YZ29DWW1lanIyS3RYMlJzT3p2cDJJYW5BWXY0Z0J4dmczQmk4UEJ5YjBL?=
 =?utf-8?B?VHpmZ3NHZFYwZW1ZNTBYdXlZOTR6WUVwSGdUdnBhYml1ZWZZb0dqaEN5UnVL?=
 =?utf-8?B?SDZJdHlxOHZ6QU8xUkdBdHdkT3VISkxzQm0vRzdlTC9JMkNkeWp3aHBNQ2hZ?=
 =?utf-8?B?Z2FSZ1pDSDdnbDB4aU5EdzR5TGxnV2JQT3dSRHA3eVAxQVJuT3M4dHZDa2Qv?=
 =?utf-8?B?emlOdjNyQ0FUM0NRQWNUaFp2NVFnSXA4cDZVaHhuRHJRUFFqVEQ0V2RMZUw0?=
 =?utf-8?B?TW5LSndLL0FWNDdkMzRVRjY5c1BvRDQvS1E3ZWEvNTZFWFQrMDNBMDdZa05E?=
 =?utf-8?B?M1AyQ1JhTjB6TC91ZHhEUnllODdrZWRocEpjMzUva0pDUGVYL0xkZVdTK1Er?=
 =?utf-8?B?THFpclkwZ01OaXB6MGR0azI0cUxMRVFidnhrNEFPaUtOVEtyUU5aQ3g4TkFm?=
 =?utf-8?B?RnFtMWo5bUtISCtzdGNGM1VzUkluajFCaVJnNE0xR1R5N1R1MWFUakxlaHdL?=
 =?utf-8?B?M2VGS2U1bXRKeUJtb3NtWnl5ZDZCMGFHRWwwS0lDNnJMUWNJTm5zMVB2elVL?=
 =?utf-8?B?MUtDQ3k0OENZay9iOE9MOXNXWnd3RWJSWHJvQU91eVEyZlUwVXowazd0VGx2?=
 =?utf-8?B?QmhsZG5HZWJicnVSTHhxNnZNeTlnNjlwOTNjcFhJQVBaL2ZHbVB0Y3NFdWlt?=
 =?utf-8?B?bW04cmo1cTF4cCs1K1A2L1g2T01EQ2RqaWpUZUJrT2tRVjNVZG1Ib1kwRUlK?=
 =?utf-8?B?cG9WNnc2cThpRGFzOGtOV0FBM0FYTTV4ckVLWmtlVDhJdi9oKzhOQkdEYnd0?=
 =?utf-8?B?bGt1ajdiaGsvZ0pLWXBTRW5XWGd2Qll1NkxlTEsxWkFPUmxHQjJFYTZQT2VO?=
 =?utf-8?B?ZlRQK2RkajVyd01qSWFLNDRTMXZVczN0OHBtSHdjL3owL1BhUUdqUG9FSWdS?=
 =?utf-8?B?ZFVFTGFTSTlWMEJCTWNqcmsrQUdLVmxxU2lPaEU5YTQvQVBrZ1B2bXk2OFRS?=
 =?utf-8?B?a0JzN2JtZzRXalJmTEZ5QzA1QVVnZS9lWXZSR2lEVDNpSzMyWWZFSGZzaGdw?=
 =?utf-8?B?UFJwTXZGajFrdWJBL0lDbEVkTjZvTytpamRhZzNOcTl3eVZBUG5kM1g5RkFG?=
 =?utf-8?B?cVpoNVJVaVZpVERpSjRDekpTMlBnTHhuMjZqOVJIVVFBZjZrcSt4UE9tQk5j?=
 =?utf-8?B?UTM3bUdlbXlzeUpkb1cxOG90NHRSbm5IZE9CRGZLZ1hHS3BkaW56enk5NHZ4?=
 =?utf-8?B?d0dUT2VlM1FhUlRSTWYyOWNrSk43L0xzQ3h3eDFGbTdVSUpwZGl6M1FmTnJT?=
 =?utf-8?B?M3VyNXJJdHJQNkNJRUZQUnYwTU5UcmduRGQrNkQwK2M2dk0rd3dqWnIxbGhP?=
 =?utf-8?B?WVcxQVhHMVhyTWxsNlRhWFdVV2JkNEROWjdaS2paRWtFRWk2RTJoMHlwMEkv?=
 =?utf-8?B?c1c1TGVPdlBrM29BcERGczlqVGo0QzVxVm9VNjliK0dMU1dmVFhuNklxREtz?=
 =?utf-8?B?RXpPRThaVzhpbUMyRE1NVDljdHg0TXNPUUg2K2VOQ091RXNQVUxkRWtKT1M4?=
 =?utf-8?B?ck9HbVQvWHo3OE0xbEpIMVRhbUtEZDdrdTZ0SDJqb043TDBBZy9VOU84eHpi?=
 =?utf-8?B?a011ajAvUlFWZ0ptdzFrbVR6S2I0Zk92VDY0elB4UmJTaWtHTFp1NlE4bklz?=
 =?utf-8?B?ZGtyK3ZvYnlLTHI0Y1IyQjdPSTduemQxRkNNWlFoVG1hQ1JWNXZaZW1hZTV4?=
 =?utf-8?B?TWIzZnZuWDFKZGtYbWc3V2hORXdMWGQ1SDRKdFpPVGZDd3VQSS9qTFBDWkxX?=
 =?utf-8?B?QklPRFliMlNFTmhTZlpnVFQwcGRoNEhFZTdlS3M1Skl4WkNVSGo1Nk13UVI1?=
 =?utf-8?Q?6MVBXtW+9TJSJ7J6f4D+c4L57?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7134.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e54616c-ca22-4f87-db85-08dc0b3c41f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jan 2024 02:41:01.2278
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: T4JxB61VnP9zgNfwDnawDCFrOPJ2CMW8U6dL+og/GKXPJHvnOBgqOdRgERov9fRusv16hp+yAtloxX+V8SVXaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB8234
X-OriginatorOrg: intel.com

PiBGcm9tOiBBbmRyZXcgTW9ydG9uIDxha3BtQGxpbnV4LWZvdW5kYXRpb24ub3JnPg0KDQpIaSBB
bmRyZXcsIA0KDQpIYXBweSBOZXcgWWVhci4gDQpUaGFua3MgZm9yIHJldmlld2luZyB0aGUgcGF0
Y2guDQpQbGVhc2Ugc2VlIHRoZSBjb21tZW50cyBpbmxpbmUuDQoNCj4gLi4uDQo+IA0KPiBTbyB3
ZSdyZSBob3BpbmcgdGhhdCB3aGVuIHRoZSB3b3JrZXIgcnVucyB0byBzcGxpdCB0aGUgcGFnZSwg
dGhlIHByb2Nlc3MgYW5kDQo+IGl0cyB0aHJlYWRzIGhhdmUgZXhpdGVkLiAgV2hhdCBndWFyYW50
ZWVzIHRoaXMgdGltaW5nPw0KDQpDYXNlIDE6IElmIHRoZSB0aHJlYWRzIG9mIHRoZSB2aWN0aW0g
cHJvY2VzcyBkbyBub3QgYWNjZXNzIHRoZSBuZXcgbWFwcGluZyB0byANCnRoZSBoL3ctcG9pc29u
ZWQgaHVnZSBwYWdlKG5vIHJlZmNudCBpbmNyZWFzZSksIHRoZSBoL3ctcG9pc29uZWQgaHVnZSBw
YWdlDQpzaG91bGQgYmUgc3VjY2Vzc2Z1bGx5IHNwbGl0IGluIHRoZSBwcm9jZXNzIGNvbnRleHQu
IE5vIG5lZWQgZm9yIHRoZSB3b3JrZXIgdG8NCnNwbGl0IHRoaXMgaC93LXBvaXNvbmVkIHBhZ2Uu
DQoNCkNhc2UgMjogSWYgdGhlIHRocmVhZHMgb2YgdGhlIHZpY3RpbSBwcm9jZXNzIGFjY2VzcyB0
aGUgbmV3IG1hcHBpbmcgdG8gdGhlDQpoYXJkd2FyZS1wb2lzb25lZCBodWdlIHBhZ2UgKHJlZmNu
dCBpbmNyZWFzZSksIGNhdXNpbmcgdGhlIGZhaWx1cmUgb2Ygc3BsaXR0aW5nDQp0aGUgaGFyZHdh
cmUtcG9pc29uZWQgaHVnZSBwYWdlLCBhIG5ldyBNQ0Ugd2lsbCBiZSByZS10cmlnZ2VyZWQgaW1t
ZWRpYXRlbHkuDQpDb25zZXF1ZW50bHksIHRoZSBwcm9jZXNzIHdpbGwgYmUgcHJvbXB0bHkgdGVy
bWluYXRlZCB1cG9uIHJlLWVudGVyaW5nIHRoZQ0KY29kZSBiZWxvdzoNCg0KTUNFIG9jY3VyczoN
CiAgbWVtb3J5X2ZhaWx1cmUoKQ0KICB7DQogICAgeyANCiAgICAgIC4uLg0KICAgICAgaWYgKFRl
c3RTZXRQYWdlSFdQb2lzb24ocCkpIHsNCiAgICAgIC4uLg0KICAgICAga2lsbF9hY2Nlc3Npbmdf
cHJvY2VzcyhjdXJyZW50LCBwZm4sIGZsYWdzKTsgDQogICAgICAuLi4NCgl9DQogICAgICAuLi4N
CiAgfQ0KDQpUaGUgd29ya2VyIHNwbGl0cyB0aGUgaC93LXBvaXNvbmVkIGJhY2tncm91bmQgd2l0
aCByZXRyeSBkZWxheXMgb2YgMW1zLCAybXMsDQo0bXMsIDhtcywgLi4uLCA1MTJtcy4gQmVmb3Jl
IHJlYWNoaW5nIHRoZSBtYXggNTEybXMgdGltZW91dCwgdGhlIHByb2Nlc3MgYW5kDQppdHMgdGhy
ZWFkcyBzaG91bGQgYWxyZWFkeSBleGl0LiBTbywgdGhlIHJldHJ5IGRlbGF5cyBjYW4gZ3VhcmFu
dGVlIHRoZSB0aW1pbmcuDQoNCj4gQW5kIHdlJ3JlIGhvcGluZyB0aGF0IHRoZSB3b3JrZXIgaGFz
IHNwbGl0IHRoZSBwYWdlIGJlZm9yZSB1c2Vyc3BhY2UNCj4gYXR0ZW1wdHMgdG8gcmVzdGFydCB0
aGUgcHJvY2Vzcy4gIFdoYXQgZ3VhcmFudGVlcyB0aGlzIHRpbWluZz8NCg0KT3VyIGV4cGVyaW1l
bnRzIHNob3dlZCB0aGF0IGFuIGltbWVkaWF0ZSByZXN0YXJ0IG9mIHRoZSB2aWN0aW0gcHJvY2Vz
cyB3YXMNCmNvbnNpc3RlbnRseSBzdWNjZXNzZnVsLiBUaGlzIHN1Y2Nlc3MgY291bGQgYmUgYXR0
cmlidXRlZCB0byB0aGUgZHVyYXRpb24gYmV0d2Vlbg0KdGhlIHByb2Nlc3MgYmVpbmcga2lsbGVk
IGFuZCBpdHMgc3Vic2VxdWVudCByZXN0YXJ0IGJlaW5nIHN1ZmZpY2llbnRseSBsb25nLA0KYWxs
b3dpbmcgdGhlIHdvcmtlciBlbm91Z2ggdGltZSB0byBzcGxpdCB0aGUgaGFyZHdhcmUtcG9pc29u
ZWQgcGFnZS4NCkhvd2V2ZXIsIGluIHRoZW9yeSwgdGhpcyB0aW1pbmcgaW5kZWVkIGlzbid0IGd1
YXJhbnRlZWQuDQoNCj4gQWxsIHRoaXMgcmVsaWFuY2UgdXBvbiBmb3J0dW5hdGUgdGltaW5nIHNv
dW5kcyByYXRoZXIgdW5yZWxpYWJsZSwgZG9lc24ndCBpdD8NCg0KVGhlIHRpbWluZyBvZiB0aGUg
dmljdGltIHByb2Nlc3MgZXhpdCBjYW4gYmUgZ3VhcmFudGVlZC4NClRoZSB0aW1pbmcgb2YgdGhl
IG5ldyByZXN0YXJ0IG9mIHRoZSBwcm9jZXNzIGNhbm5vdCBiZSBndWFyYW50ZWVkIGluIHRoZW9y
eS4NCg0KVGhlIHBhdGNoIGlzIG5vdCBwZXJmZWN0LCBidXQgaXQgc3RpbGwgcHJvdmlkZXMgdGhl
IHZpY3RpbSBwcm9jZXNzIHdpdGggdGhlDQpvcHBvcnR1bml0eSB0byBiZSByZXN0YXJ0ZWQgc3Vj
Y2Vzc2Z1bGx5Lg0KDQpUaGFua3MhDQotUWl1eHUNCg==

