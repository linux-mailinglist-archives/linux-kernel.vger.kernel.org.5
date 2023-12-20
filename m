Return-Path: <linux-kernel+bounces-6594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0575819ABE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 09:44:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B24BB21DAB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 08:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E66821F947;
	Wed, 20 Dec 2023 08:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ADRcGBMv"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C37E51F922
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 08:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703061873; x=1734597873;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=PZMrDz1w/JkK/tY2FietyG0HQka0iWmUSAFfBVjX+Tc=;
  b=ADRcGBMvR6Sfy6ClV5hWAz1dJxVlE7RaOVYhSdgXwjmMtAVa/D98iXyZ
   DZOD03UvyRPApurdckrKrW1MS3Z22DKcHNSC9UGGXVivRpCivyZtE/Ik3
   9h/dvMWmwXR1osL4eOh7LmBAQbpOxTIoGKugMQiB9hDGvVZbHztR/F895
   tjZxUxrKZH1gbg7bkSN444bpBqkhg+kxtoBzy11fySZSA9vmFj4/5O/6G
   rEEXGV8l5+GPUFSWFrMPHUfdhneHkbIxCXxlS1i6n5xzwekeFRuJLXiUi
   SdCoeYlFYK7IRf0Bl1pqPz1bdYScATKN/9oWIR4sSjmpysyhwH5RXX5Du
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="462233999"
X-IronPort-AV: E=Sophos;i="6.04,290,1695711600"; 
   d="scan'208";a="462233999"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2023 00:44:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="769514480"
X-IronPort-AV: E=Sophos;i="6.04,290,1695711600"; 
   d="scan'208";a="769514480"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Dec 2023 00:44:34 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 20 Dec 2023 00:44:33 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 20 Dec 2023 00:44:33 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 20 Dec 2023 00:44:33 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 20 Dec 2023 00:44:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lXFuRS7Cahhu9HpTtmYi/uslYLil+Ix8PJKHbHWnXLsSqEmgpIh1vC9goseWpBDOtuAztVfJ3XT4sILx+YiLdWKcFJ0Kr6PShDvhcgWFg9UY8togDiaDVFD7OH637MekUOFekqTsCgIq/QuaRbkJKO2BJ3jW1BD3WvVSrrQojbPV0YHJo9HOkfRLDBntSy0VstLcJf4RLOR+Zt238HHhUnktodfxv/cEhlsFy64RrsLMScA0IOsOLnIh7zMyG1yAkJWY7Z6V+QEznMjzkndYDWsdHBJsSXmliqJBkFG0EP5jYg76jkgiYirpz6qKnrRYN9/8gwvLZdFqwjS4z1Vjdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PZMrDz1w/JkK/tY2FietyG0HQka0iWmUSAFfBVjX+Tc=;
 b=dyE8GgC/iVjKehtIStzmz7684Cq4L+lBBVFuklKQTadUXpdvNP8ddCj8uhjqNag7rRIl/VOV+ieFye/Q922AHvQuT2jaWIHoOrGqihOWIYxi4+yKqbLweD+GCwEhV3G0e3TI8kjCPf1D07BjD+KA7dIDxgv1pw+L5zhthdmmXcqTn9YDBePwnLzFyG7wR3ETZsq4XG0UF57jP3ClV3vM6Ye9ual+eTu3SD1R8VC8LDhT4duxEn9LsJ10mAtehMndC9pZbyYKBiWPZgJj1u1CMHGurWAJtCmoomlUjyOWuUKvXz/Gsvs+3oZKLNkoW3Ay9RHYKOVGOxaVcGazrKh/iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CY8PR11MB7134.namprd11.prod.outlook.com (2603:10b6:930:62::17)
 by CH3PR11MB7345.namprd11.prod.outlook.com (2603:10b6:610:14a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18; Wed, 20 Dec
 2023 08:44:30 +0000
Received: from CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::6a88:3d6c:99ec:d988]) by CY8PR11MB7134.namprd11.prod.outlook.com
 ([fe80::6a88:3d6c:99ec:d988%5]) with mapi id 15.20.7113.016; Wed, 20 Dec 2023
 08:44:30 +0000
From: "Zhuo, Qiuxu" <qiuxu.zhuo@intel.com>
To: Naoya Horiguchi <naoya.horiguchi@linux.dev>
CC: "naoya.horiguchi@nec.com" <naoya.horiguchi@nec.com>,
	"linmiaohe@huawei.com" <linmiaohe@huawei.com>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "Luck, Tony" <tony.luck@intel.com>, "Huang,
 Ying" <ying.huang@intel.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Yin, Fengwei"
	<fengwei.yin@intel.com>
Subject: RE: [PATCH 1/1] mm: memory-failure: Re-split hw-poisoned huge page on
 -EAGAIN
Thread-Topic: [PATCH 1/1] mm: memory-failure: Re-split hw-poisoned huge page
 on -EAGAIN
Thread-Index: AQHaLy56zApP4+g32UCjLA2FEfjfxrCv5KOAgAH2EJA=
Date: Wed, 20 Dec 2023 08:44:29 +0000
Message-ID: <CY8PR11MB7134D0CB9A22A24E1B7E928B8996A@CY8PR11MB7134.namprd11.prod.outlook.com>
References: <20231215081204.8802-1-qiuxu.zhuo@intel.com>
 <20231219021723.GA158136@ik1-406-35019.vs.sakura.ne.jp>
In-Reply-To: <20231219021723.GA158136@ik1-406-35019.vs.sakura.ne.jp>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7134:EE_|CH3PR11MB7345:EE_
x-ms-office365-filtering-correlation-id: c18b01da-90c7-40c8-1c25-08dc0137e12f
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4cDg4DsTP/MWYDIrWQ3LkkYblvl0B149TwVQiFy+DSTfY/bCVwUrKEfxIuhLk0eZzSR6VkNMGQzO8Tr5xhoOHI3fnmmO058exsfyHFYoOi68vuIRwQ4s1VGX21gsIzB+v4D26MpiYsAnj5nbxpzuNYT5bSqAjkNtgpTJzsyPfAgzlCzrOn5bqFbPu79ZlOP8GW6vo+ncRnkpuee2gUjwLlPnN4rvgwwyBkFckN3bwvwHOVX6HGevUIUOjLfKRm5ZKTZLH8alpU518N3Nngmt+JV/hmlMrOegIoYcWRpDkacfkz1gKKROViAexKybNxhyR2oIuM7j1YcLGcivv0DZYYt8a9K+fDWiBKHu0Y1zGIc8EOw9hfxfnis9bdAbq5yTr+cQmoJZxAGLpFcwpTfk7JaSUzuMvstatjjITS0jIMOaisYs2WnrO+qYJ4gHDjei9C4il6i2jEHGbrHMgf2hpQfSG9+tCMI6/tqWTf8xMZ5bUXlyd9uNmIo6pKSX5w9xR87DSrWjs4jWv5mFFlJg057Hqzp6WNsbw8llbWNZYCRydMF7SKYr8V61mrqs7aqVC2jTyX2ZnFNGp9aQBYGOTYu9rj43tawYcu4D+b0JKg0hfztibSP7kWhqGqcbr902LLMMKQ2IZ+it+A4bP/mxxw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7134.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(39860400002)(376002)(346002)(366004)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(2906002)(41300700001)(86362001)(33656002)(38100700002)(122000001)(82960400001)(71200400001)(316002)(478600001)(54906003)(6506007)(7696005)(8936002)(8676002)(66476007)(6916009)(66446008)(76116006)(66946007)(66556008)(64756008)(9686003)(5660300002)(83380400001)(26005)(4326008)(52536014)(107886003)(38070700009)(55016003)(14583001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cWM1WXNSOTlTY3lsa1VRbGtPbGhKUU5MUlJKLzRmRHZYZWR6UXlydzREb1d4?=
 =?utf-8?B?ZUZnVjYvZUJQdUl2U0dWVnhHeDVaTjZJTlhPMzVVMnlHeHhmcHFQTWxJdWY4?=
 =?utf-8?B?SlVlUWE2UkFMN3pDenMyNHN6ajNGMkZVUzM1bHdOb1p5TVlRT0NMQktNc2h1?=
 =?utf-8?B?STRSQlBmdlRyajVjWnY0VG5xVlQwM1FtcTJpR2FSSXRIK3A0bExMMXk5RDZH?=
 =?utf-8?B?eTExYXVEVzNCc1FoN0J3VFE1b3RsRXphbVpQU1o5K3JPdHpvWm5uSGk0ZTZv?=
 =?utf-8?B?cVMyUGNJNFhkaG12c0F5TmZKbG80WEo4TVh5a2d0OGRzRFg5cXJOOWJJOFZX?=
 =?utf-8?B?aVdrdzFtdXRmamkxYUx4TEpqZ21mM0x2MHMxTzlTWXpkUWZuR2ZGdklreDh4?=
 =?utf-8?B?aURvTWVjUDZvV3FkZW8ydFdjQmxjeEswS3BtZXpiMzFiTWpmaXZDQ3hEOTY4?=
 =?utf-8?B?aXNoTzIxeGl5WTI3Umo2M3EvQ2ZsMnFUUUVjanBlck9QV1d4aUtsSTNON0hn?=
 =?utf-8?B?U2FYK0lQMUMyRVd1dDNiU2Y1aHAzaEhXSHpBa2VVZTRNQzUzdGVVWnFNM3JL?=
 =?utf-8?B?Q0p5M3pMY3FJQlhYSGViNE1hUFlBcnUvclcxSlRZd3ZpbExKVUkyT1pjWmU5?=
 =?utf-8?B?TG1RUlVwejRXaXRIY0hIRXQ0eWxuY0F5TUNtd3BVQzMvM1VwTWs3ZVl6dFhu?=
 =?utf-8?B?eXFYeTFzaEpIRkk2ckZpeWx3MjAxUk5paDFqaDE5Z2cxaElWWGt3RHh2UU5S?=
 =?utf-8?B?b2Q2MHAzYm8xZnRZODJhMGhBNnByMmJPVi9HSGtBd2hPeUdoeGdDNzVQU1U0?=
 =?utf-8?B?VkxXVExySzIzU29UaTJJWVpRYWdwRVJvMGJGbDVuazMxd3ZwRFZXeVFPRkFF?=
 =?utf-8?B?R0tQMm0yMUxBS3hJVGFIRXdDZTdoM3IyS3B5aGJiVGRoQkRXVzI0aTlleTF3?=
 =?utf-8?B?SXB0bmN0S2F2M2ZJTlNRWFJGS2ZPNFZOUUNGMGhqMmpCTkFMbGpORXlpbGFK?=
 =?utf-8?B?WTZwc3NQRnFyaEMrMENaMVRJVndQeWZKNUpyRmhoUk0va242VnpsSHNCSS9u?=
 =?utf-8?B?cGZJYjk1S0JzY29vbkY1OGZxekdGSHFHYmFGdHByQ082RitFdkNjZjNaaTVz?=
 =?utf-8?B?SW0xSHpIbnN0TUx0cE85YTN6UkJldFhPNTI0V3FoQkxtYkYveDYybnpXTkpj?=
 =?utf-8?B?NWJrY0t4UnZVZDFSV0Z1ZjZWVEhBYVptdVoyVTdjbnRWQk05OXZqTTZGTlIw?=
 =?utf-8?B?ckZEQXRNNUo1ZU45S1dUNzVEektaeDR6bjh5SUV1ay9FK3FkTEVhZXQvd1hY?=
 =?utf-8?B?U0xDYVNPNmJ1V2p1SmppNHIwaGtnaEpoUExCY1F6Rkc0MkJrV3lUWW9oOWpo?=
 =?utf-8?B?U1pVRFlFVHpwK3RBMUtITlFaVFVSS2tEY1FUMmQ4eFdFQTRwbzI0ZVlHVFdQ?=
 =?utf-8?B?UDVETlo1WjFaQTdDV3hCQXUxVjRsaWRucFcwbFdrd1FzTjZZNnJiMzhXcUtt?=
 =?utf-8?B?T2tZR1hDM1R5dGRjZHJKMDNFenFnSk9XOTlKN2s5QzFLNkNublJYcVBFZUFs?=
 =?utf-8?B?bnU0dGNzd2l5WXhrNkFHQTVDRmdadGdaTE5rb3VGUitFSkdFSGF6RnhMZ1RJ?=
 =?utf-8?B?YW04UlhkT3EwRXBpRkJUV3pnRGgwNXh6ZFZKSzhCR2plOGVSQW83QXpsYUNq?=
 =?utf-8?B?cUt4ZVR3WTkrUVVzWU1PTVhtd0lHN3RuSkxRVTU0bEVzTXh4dGRhRkRKRGNr?=
 =?utf-8?B?aHlyQVAzSWpuUGdJaW9tbDYzeFF4TGczektabTBibEk2V2hiL0loNitKdUR0?=
 =?utf-8?B?STlna1oxQzJxVG9rRDFPd3IvWHdqVFRHRTQva01oVllGbjZBYkFIc0pVQXRT?=
 =?utf-8?B?bHdNQXFleUJtbWR4YnJNaUZoRGsyTHQ1RDF1ZmVhQ24yVHY2SDRKTUt5bk9Z?=
 =?utf-8?B?UFVZcFhTQ2hjNCt2QXpwUU9vZitnRlVqZEVZY282REI0YzJmYlFiMlUrL3N3?=
 =?utf-8?B?d3QwV0xMOHAyeWlFUVhTRGtiRFlSek82elBVR0hvOVpDUWZlQjB0R2t6SWt3?=
 =?utf-8?B?YzIvMDFFcjFSTmR2TFZRQjE2T042UEVUUFhtSTV4alJPNDJRQzlQbWFwOEpY?=
 =?utf-8?Q?CBu9Z7AjIKrZNZaHt1QC4Mcq+?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c18b01da-90c7-40c8-1c25-08dc0137e12f
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2023 08:44:29.2380
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d+EMIWfNB8rf1tlrDFKrAOQkbbJ+0fWwgfd/VQVf/AtF1JdxGT9Nttkv6gjPvNbUrAaU398LBJVxU5/v/AkyCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7345
X-OriginatorOrg: intel.com

SGkgTmFveWEgSG9yaWd1Y2hpLA0KDQpUaGFua3MgZm9yIHRoZSByZXZpZXcuIA0KU2VlIHRoZSBj
b21tZW50cyBiZWxvdy4NCg0KPiBGcm9tOiBOYW95YSBIb3JpZ3VjaGkgPG5hb3lhLmhvcmlndWNo
aUBsaW51eC5kZXY+DQo+IFNlbnQ6IFR1ZXNkYXksIERlY2VtYmVyIDE5LCAyMDIzIDEwOjE3IEFN
DQo+IC4uLg0KPiA+IFRoZSBrZXJuZWwgbG9nIChiZWZvcmUpOg0KPiA+ICAgWyAxMTE2Ljg2Mjg5
NV0gTWVtb3J5IGZhaWx1cmU6IDB4NDA5N2ZhNzogcmVjb3ZlcnkgYWN0aW9uIGZvcg0KPiA+IHVu
c3BsaXQgdGhwOiBJZ25vcmVkDQo+ID4NCj4gPiBUaGUga2VybmVsIGxvZyAoYWZ0ZXIpOg0KPiA+
ICAgWyAgNzkzLjU3MzUzNl0gTWVtb3J5IGZhaWx1cmU6IDB4MjEwMGRkYTogcmVjb3ZlcnkgYWN0
aW9uIGZvciB1bnNwbGl0IHRocDoNCj4gRGVsYXllZA0KPiA+ICAgWyAgNzkzLjU3NDY2Nl0gTWVt
b3J5IGZhaWx1cmU6IDB4MjEwMGRkYTogc3BsaXQgdW5zcGxpdCB0aHAgc3VjY2Vzc2Z1bGx5Lg0K
PiANCj4gSSdtIHVuY2xlYXIgYWJvdXQgdGhlIHVzZXItdmlzaWJsZSBiZW5lZml0IG9mIGVuc3Vy
aW5nIHRoYXQgdGhlIGVycm9yIHRocCBpcw0KPiBzcGxpdC4NCj4gU28gY291bGQgeW91IGV4cGxh
aW4gYWJvdXQgaXQ/DQoNCkR1cmluZyBvdXIgdGVzdGluZywgd2Ugb2JzZXJ2ZWQgdGhhdCB0aGUg
aGFyZHdhcmUtcG9pc29uZWQgaHVnZSBwYWdlIGhhZCBiZWVuIA0KbWFwcGVkIGZvciB0aGUgdmlj
dGltIGFwcGxpY2F0aW9uJ3MgdGV4dCBhbmQgd2FzIHByZXNlbnQgaW4gdGhlIGZpbGUgY2FjaGUu
DQpVbmZvcnR1bmF0ZWx5LCB3aGVuIGF0dGVtcHRpbmcgdG8gcmVzdGFydCB0aGUgYXBwbGljYXRp
b24gd2l0aG91dCBzcGxpdHRpbmcgdGhlIHRocCwNCnRoZSBhcHBsaWNhdGlvbiByZXN0YXJ0IGZh
aWxlZC4gVGhpcyB3YXMgcG9zc2libGUgYmVjYXVzZSBpdHMgdGV4dCB3YXMgcmVtYXBwZWQgdG8g
dGhlIA0KaGFyZHdhcmUtcG9pc29uZWQgaHVnZSBwYWdlIGZyb20gdGhlIGZpbGUgY2FjaGUsIGxl
YWRpbmcgdG8gaXRzIHN3aWZ0IHRlcm1pbmF0aW9uIA0KZHVlIHRvIGFub3RoZXIgTUNFLg0KDQpT
bywgYWZ0ZXIgcmUtc3BsaXR0aW5nIHRoZSB1bnNwbGl0IHRocCBzdWNjZXNzZnVsbHkgKGRyb3Ag
dGhlIHRleHQgbWFwcGluZyksIA0KdGhlIGFwcGxpY2F0aW9uIHJlc3RhcnQgaXMgc3VjY2Vzc2Z1
bC4gIEknbGwgYWxzbyBhZGQgdGhpcyBkZXNjcmlwdGlvbiBpbiB0aGUgY29tbWl0IG1lc3NhZ2Ug
aW4gdGhlIHYyLg0KDQo+IEkgdGhpbmsgdGhhdCB0aGUgcmF3IGVycm9yIHBhZ2UgaXMgbm90IHVu
bWFwcGVkICh3aXRoIGh3cG9pc29uZWQgZW50cnkpDQo+IGFmdGVyIGRlbGF5ZWQgcmUtc3BsaXR0
aW5nLCBzbyByZWNvdmVyeSBhY3Rpb24gc2VlbXMgbm90IGNvbXBsZXRlIGV2ZW4gd2l0aA0KPiB0
aGlzIHBhdGNoLg0KPiBTbyB0aGlzIHBhdGNoIHNlZW1zIHRvIGp1c3QgY29udmVydCBhIGh3cG9p
c29uZWQgdW5yZWNvdmVyZWQgdGhwIGludG8gYQ0KPiBod3BvaXNvbmVkIHVucmVjb3ZlcmVkIHJh
dyBwYWdlLg0KDQpZb3UncmUgY29ycmVjdC4gVGhhbmtzIGZvciBjYXRjaGluZyB0aGlzLg0KSW5z
dGVhZCBvZiBjcmVhdGluZyBhIG5ldyB3b3JrIGp1c3QgdG8gc3BsaXQgdGhlIHRocCwgSSdsbCBs
ZXZlcmFnZSB0aGUgZXhpc3RpbmcgbWVtb3J5X2ZhaWx1cmVfcXVldWUoKQ0KIHRvIHJlLXNwbGl0
IHRoZSB0aHAgaW4gdGhlIHYyLCB3aGljaCBzaG91bGQgbWFrZSB0aGUgcmVjb3ZlcnkgYWN0aW9u
IG1vcmUgY29tcGxldGUuDQogDQotUWl1eHUNCg0KDQo=

