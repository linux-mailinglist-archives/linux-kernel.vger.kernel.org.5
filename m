Return-Path: <linux-kernel+bounces-25632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 833AC82D3CF
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 06:14:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 058D31C20DB4
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 05:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 506F623C9;
	Mon, 15 Jan 2024 05:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KlGw/4+1"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A769120E6
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 05:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705295666; x=1736831666;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=HOrUpfDzOfR3Pn3fMOISTUlPMJ+V/+OGSU/nxD06ZoA=;
  b=KlGw/4+1yp+ChHiWU3cb/epfAwxxZo0PbsIBNYKDXWOs1aE1ryuHtxCm
   3q6yCT1FGYn1kZMq480q3Wz25+M5Wc5eQR4YZo5C+vWr0yvVh34GXFAvx
   lYZruE6HJ/J9dvxNkCZ7fPTHu2SLD1bGL4IUXFXMyPypAAfZWRo7Co/Q0
   vv0wO1R0Q/96USQQH3LAe2/yKCsryNIfNA97m3Wqp6rP8mbNcI1jB8yCS
   /+myqwVXkvfWXvNNCyreBV14iJnS1S2VkmmRGILynynsrGrgUw/7DKlKM
   UdaHY1Q9B3yenhwBCbN7rQg8pyCmrq+huVypLFV0CviDdWmK4nl5KRWqI
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10953"; a="465916668"
X-IronPort-AV: E=Sophos;i="6.04,195,1695711600"; 
   d="scan'208";a="465916668"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2024 21:14:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10953"; a="873989357"
X-IronPort-AV: E=Sophos;i="6.04,195,1695711600"; 
   d="scan'208";a="873989357"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Jan 2024 21:14:25 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 14 Jan 2024 21:14:24 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 14 Jan 2024 21:14:24 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 14 Jan 2024 21:14:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nRhsURQPdRUAjpsgM5QbtiKroFXeaxYuqwCA/9utNs/S1M+x4C4camktkh29FxKts7oR7iAV27d9+tcwJzRYEdCeR4b7Lfigf05KuJtJ7MwxW0/eeXcfBiP8Zco4zpPwNa7mvyi1QhKnrMsG7AKI0iprLstDvWFAPH+FbCFI7SgoXv6eEY6omejBq36DzxwasWp/NW/nycH7WprS3NwEfpVF9C+EzLoAraY6W1/dI3s8U/p/gN8dr5Bgm5z/Lq+OvIBrCpnmcHQunVUy5U3WbLLd+fWUgsIH4DtFJcUIATVMlFMLmCUPbkiaFXLHJwFrsv7Gw89dGHRKlkmBSZ34GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HOrUpfDzOfR3Pn3fMOISTUlPMJ+V/+OGSU/nxD06ZoA=;
 b=Hr9ei5+AeKbOjg70xrjtcZ5hnLvEC3mTG1YwC9I013sJK+RcC3y/fJTkI9q2VMZqQNFPkcYWdXBGrkzOdIsRqsMpC2u3or5WEZJHTY6IW/Jv5RlTBXoatlVnyUnKpCMXlumoDFk8GL7aVPTZRb5eUIoU/+vWkTKFhXho4fd9aQPLQvWP7D0EtmU3OeY8wBMSJmWyrSP6odqiU3Na7ZWDVGhZs8O4vc6NvMAkG7x8IQ2mJKDPmOa5b6omzO3+JSzsj6vM9R6TtzoEf7yhANoK8I5EfoMPFqdeaGIR3O68UEPgsUOvMHO0ZLjVdTeobfJmJ08Zfvsb40dDYTdQmIA8cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by MW6PR11MB8367.namprd11.prod.outlook.com (2603:10b6:303:249::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.24; Mon, 15 Jan
 2024 05:14:22 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ca1e:db:ee01:887]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ca1e:db:ee01:887%5]) with mapi id 15.20.7181.019; Mon, 15 Jan 2024
 05:14:22 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "sathyanarayanan.kuppuswamy@linux.intel.com"
	<sathyanarayanan.kuppuswamy@linux.intel.com>,
	"kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>
CC: "Williams, Dan J" <dan.j.williams@intel.com>, "Li, Xiaoyao"
	<xiaoyao.li@intel.com>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>
Subject: Re: [PATCH v2] virt: tdx-guest: Handle GetQuote request error code
Thread-Topic: [PATCH v2] virt: tdx-guest: Handle GetQuote request error code
Thread-Index: AQHaRD8OPWLmEoGzKkSc9Umwl+p8rLDaWuMA
Date: Mon, 15 Jan 2024 05:14:22 +0000
Message-ID: <e78e7004cd2aed14e646e8bb810fe1c252f26f57.camel@intel.com>
References: <20240111033245.2632484-1-sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20240111033245.2632484-1-sathyanarayanan.kuppuswamy@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.50.2 (3.50.2-1.fc39) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|MW6PR11MB8367:EE_
x-ms-office365-filtering-correlation-id: d9b84a3d-97d5-46ec-beff-08dc1588d5d5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: h8u6/llCQKiopnft6uKtx3KTiRcPyyRhZQLElbAFzk8ebUNGxVL4rKEwIZLJM6huv0EnCaE7lB6y1sjJGjz5YYqtZOZXMz3mClLZ4lZ5hPjm8bigv6uSECtcq0QRluNybcr2OoDcs3TzTFlUK5FWumlbpOKNitnJn+xuCXQeFgoSrZK0a9NeLbmYOTG+s9hkn1bKx5rWuE3MS5eGts7afOwlnYnwZVmMDJ+iPcjHVSoypLzNVP1kpkctJpie3Q+Hm5kgtUn/YNVWPj1Juz93jY23bRplz9PtFxoUQiMVlSmuk20VmlBP7B/DNAPA2FxgtQi67hLCTQCw4/aEHCI0JgKqSI8Pyx4AIlykrGK/zDvDxm9AY6TE+L8AeBDalJGyyBxtsq3NtwKu5zqtIA5XBRvWZgmFg0xW/iVC30++UlrNGO2z5LZaLvBhPLgfzscS8dkwhhENVnI4l4uLu1/CePenQzyX1vnLUotn0bIIfk/2yX2R4l52Y8qFK/kNhyYlbU23Aaj8m/47xFLhUFaP/Oyw+5o6MFSyJ9yW0JMafssIyphTqWfPwsxvHizZjJ1aUdMhMNoowa6Nx7Vl+QCMHWigAaTOQMV9H5LRE6JeSuU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(376002)(396003)(39860400002)(136003)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(83380400001)(41300700001)(38070700009)(36756003)(91956017)(66946007)(82960400001)(86362001)(76116006)(122000001)(38100700002)(66476007)(316002)(2616005)(54906003)(26005)(66446008)(6512007)(478600001)(66556008)(6506007)(6486002)(4326008)(2906002)(966005)(71200400001)(64756008)(110136005)(8676002)(8936002)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y0tkU2x4Z1lKMnNxbG82OWVCSmNzTDdCMjAySzhZRHpvVFJXUVVBTmtzRUwx?=
 =?utf-8?B?dzVLMHNjcWxSNjBUYWhqdVpkU2VHOTJuKzVzMENDVTE0ek5ibmx2OWZpK09P?=
 =?utf-8?B?aE9NSHQ0ZG9SYmx0aDVpRGRHdmpKUkorYjhMakE1L3hWQVFtZndaYmpUZ1BT?=
 =?utf-8?B?MUJ6WUZOdmhTOWVCZktBcUZZVlltcWlzMlpnS1IrOFl1VS96Q2JtVjJCT2dG?=
 =?utf-8?B?Zk1jUndtZGhCckhGSGFISGlDeGFMTXJrS2cwL2h0VXQvZjdYSUJQc2hRRVF4?=
 =?utf-8?B?TE9hWk4rVUxqcERqbi9WelVuaFEyUis0Zi9Fd25RcUtZcTU5TW5BZ0c4aU5H?=
 =?utf-8?B?MnlVaW9KZWhvWDBOQnJEUmk1bDJGdkI4RWk4QUpja2U3QUJLMXdKQWFRZlJH?=
 =?utf-8?B?L0N1UlZFK0p1Sk9XVmdJQzc2cnQzRXNDYUZjMjI0aUtLOTRMa2hvQk5tQXIv?=
 =?utf-8?B?Y2ptd2lwalRNYzdxd0FXSTc2c2tEb1FDcU9rK01ENS9PNnBOMnVFOWVNbGNs?=
 =?utf-8?B?L0ZNSi9rbEQ2dkpDUlgrTjJEVjg4Nk8wL1VqSEhXbUpWSEZyOTUzSXpTSGtD?=
 =?utf-8?B?RElNR2krZjczQ0dHcHZ2RkNzTE9IQlRPQnExZU55YUp4ZUVndHZEbjFZYi9v?=
 =?utf-8?B?MlloYjFxMmtZMjB5VHRKNVpGNVhMQkh6VUttRkpWRklEQVRGY3d2eDBSOWtv?=
 =?utf-8?B?eUNacFFSdldzYzNVRjduZlFPaWs5WmtmdjRhTUJZcjIrWjB1NlBFdmpwWVhN?=
 =?utf-8?B?ejc1Y2NNMXZqSFNqWXI0cDEwc2VEYlJNWDlUR3pTM0xJeUtMT3hHdldpNFQz?=
 =?utf-8?B?aHJ2cjZBNUcyMi80YU9MOEtXNmtLUmMyNTRwSnd1cEVkNGRwZnVCVm9CVjY3?=
 =?utf-8?B?bGpIc2dhTTgvWUpQNjZ3b0hybldES3o2dGM4ODRCZW9rWXdBMzVzTU9ZUTFH?=
 =?utf-8?B?RGFGeWFkdDdYWlEwaENCUEtQTitzUzdnMlZhbWR3MUJsZGNnTVVwb2kyanBp?=
 =?utf-8?B?aENKTEw1U3VaRHlXSHh6T1AvS3JlRWc5bVlzcS9HUGNkbUZobkR6YWlnWmI1?=
 =?utf-8?B?OHQvUjBvSi90SS9jVnN5WS8yeFRBTnQ0U3B2Z05OcGNpeG5tNFhxVlhYaEpN?=
 =?utf-8?B?MGRkWlBFMUhZQXVFcUVVNTNHU2U5czhicjVndTB5S1Y5NTZoUE1ZYVAyZE9J?=
 =?utf-8?B?WlFwb3RKUlZQUG9DOG9OdklVdFB0TEc3M3lBVmlsaTQ5bit2NEt4Sk1TM1JW?=
 =?utf-8?B?Nm5KRENGZFBuS0NOT0c4ZjN5RXRsdzYyV3RwK0k4V2xoS3k1MEw4Uk92VGNh?=
 =?utf-8?B?ZS9MUDllT1RkY3VGOWJZQVY4Z2lxOTdOWVo5bk0xZWtCdmxYOXZ1ZE9OazQv?=
 =?utf-8?B?NDYydi9zUTZvYUVhVFBpeldmRzJuR0ZpWnJDVlFhRUpGUzJGWmtRdEJtNldx?=
 =?utf-8?B?TTQydG5PdlhUc084cnR0Y0R0T3o0V0QxOGxEZzZDeUYwMU5IZ0Z5QU9DNXda?=
 =?utf-8?B?NXRzRTFyYWgwM3k0eUNrcDlKVkNEWkRoaUZHUWVnai85UGVqMzVyTUNCMzVT?=
 =?utf-8?B?MUhoY0pIMmh0MHgvMWdwaklrTUFFYkc4dS9NNnJ6M2h0WXdQWHovS0tJNmNx?=
 =?utf-8?B?T0xrTUx0a3psdEgyNUd6dUFFaGk1ZHJTRkhjWTR0WVJOZHI4cG05clFvZXNs?=
 =?utf-8?B?dDFCN2duc2dXa0huYjlneXlOb25ZYis2cTgvWnJkdG5yNkhyY3M4dFkraHRt?=
 =?utf-8?B?TVl5NGQrcnFVeXltTGFEcUdEUm8xbm1rbUVzS2hLbU41SGRlR2hTcGx0OHRY?=
 =?utf-8?B?UjVzZzZyMUF0TkVUSHhCZHNhb3JUN2k0Q3k1cUZseER2TndKQmcyeW94UTlr?=
 =?utf-8?B?UlNjOGVDa0VKemJPL3o1T2VuR0t2QUJBLzkwZndBTEtVcnFDdS9WODVWbk1K?=
 =?utf-8?B?ck1rSkN6TkJZdlZxbm90WDJlYzBuaWdPd0hNNWpjaitRUCtQd2JkaXJxVGR0?=
 =?utf-8?B?MmpldFNWUTZEMjhjRWV6bWR3bWZNNnpYdjNpUmFnN2R0T1NUS1lhZXd6MnZa?=
 =?utf-8?B?bXJpSnYvWjZldWJVcW5kQlhMN0VCWlBuUDA3cUJzOVIrVFphRGVkN0xUOGVa?=
 =?utf-8?B?ZmE5RHlGTXRHMkdlMjA2MGhuaEcwYlZ4L3RaSStJbkh2QzEzVGh4WmY1QmZD?=
 =?utf-8?B?SGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D1B94BAA2B72C341B85FBDDDFB920F07@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9b84a3d-97d5-46ec-beff-08dc1588d5d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jan 2024 05:14:22.6686
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oWv94aUAF90/vRGSZEmAluzdl0FuiNN3DkfVp3BO0livMbWHMWADok2Q7ynUvRBpPdY8uh66+uVo1sXBEGAFZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR11MB8367
X-OriginatorOrg: intel.com

QWx0aG91Z2ggZm9yIHRoZSBmYWlsZWQgcmVxdWVzdCwgb3V0cHV0IGJ1ZmZlciBsZW5ndGggd2ls
bA0KPiBiZSB6ZXJvIGFuZCBjYW4gYWxzbyBiZSB1c2VkIGJ5IHRoZSB1c2VyIHRvIGlkZW50aWZ5
IHRoZSBmYWlsdXJlIGNhc2UsDQo+IGl0IHdpbGwgYmUgbW9yZSBjbGVhciB0byByZXR1cm4gZXJy
b3IgZm9yIGFsbCBmYWlsZWQgY2FzZXMuDQoNCk5pdDoNCg0KSWYgSSByZWFkIGNvcnJlY3RseSwg
a3ZtZW1kdXAoKSByZXR1cm5zIFpFUk9fU0laRV9QVFIgaWYgeW91IHBhc3MgdGhlIDAgc2l6ZSB0
bw0KaXQsIHNvIHcvbyB0aGlzIHBhdGNoIGl0IHNlZW1zIHRoZSBrZXJuZWwgd2lsbCByZXBvcnQg
WkVST19TSVpFX1BUUiBhcyB0aGUNCmJ1ZmZlciB0byB1c2Vyc3BhY2UuICBOb3Qgc3VyZSB3aGV0
aGVyIHRoaXMgaXMgYW4gaXNzdWUuDQoNCkkgZ3Vlc3Mgd2hhdCBJIHdhbnQgdG8gc2F5IGlzLCBz
aG91bGQgd2UgZXhwbGljaXRseSBjaGVjayBxdW90ZV9idWYtPm91dF9sZW4gbm90DQpiZWluZyAw
IGV2ZW4gdGhlIHN0YXR1cyBzaG93cyBzdWNjZXNzPyAgQWZ0ZXIgYWxsIHRoZSBvdXRfbGVuIGlz
IHNldCBieSB0aGUgVk1NLg0KDQpBbnl3YXk6DQoNCkFja2VkLWJ5OiBLYWkgSHVhbmcgPGthaS5o
dWFuZ0BpbnRlbC5jb20+DQoNCg0KPiANCj4gVmFsaWRhdGUgdGhlIFF1b3RlIGRhdGEgb3V0cHV0
IHN0YXR1cyBhbmQgcmV0dXJuIGVycm9yIGNvZGUgZm9yIGFsbA0KPiBmYWlsZWQgY2FzZXMuDQo+
IA0KPiBGaXhlczogZjQ3MzhmNTZkMWRjICgidmlydDogdGR4LWd1ZXN0OiBBZGQgUXVvdGUgZ2Vu
ZXJhdGlvbiBzdXBwb3J0IHVzaW5nIFRTTV9SRVBPUlRTIikNCj4gUmVwb3J0ZWQtYnk6IFhpYW95
YW8gTGkgPHhpYW95YW8ubGlAaW50ZWwuY29tPg0KPiBDbG9zZXM6IGh0dHBzOi8vbG9yZS5rZXJu
ZWwub3JnL2xpbnV4LWNvY28vNmJkZjU2OWMtNjg0YS00NDU5LWFmN2MtNDQzMDY5MTgwNGViQGxp
bnV4LmludGVsLmNvbS9ULyN1DQo+IFNpZ25lZC1vZmYtYnk6IEt1cHB1c3dhbXkgU2F0aHlhbmFy
YXlhbmFuIDxzYXRoeWFuYXJheWFuYW4ua3VwcHVzd2FteUBsaW51eC5pbnRlbC5jb20+DQo+IC0t
LQ0KPiANCj4gQ2hhbmdlcyBzaW5jZSB2MToNCj4gICogVXBkYXRlZCB0aGUgY29tbWl0IGxvZyAo
S2lyaWxsKQ0KPiANCj4gIGRyaXZlcnMvdmlydC9jb2NvL3RkeC1ndWVzdC90ZHgtZ3Vlc3QuYyB8
IDYgKysrKysrDQo+ICAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy92aXJ0L2NvY28vdGR4LWd1ZXN0L3RkeC1ndWVzdC5jIGIvZHJpdmVy
cy92aXJ0L2NvY28vdGR4LWd1ZXN0L3RkeC1ndWVzdC5jDQo+IGluZGV4IDEyNTNiZjc2YjU3MC4u
NjEzNjgzMThmYTM5IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3ZpcnQvY29jby90ZHgtZ3Vlc3Qv
dGR4LWd1ZXN0LmMNCj4gKysrIGIvZHJpdmVycy92aXJ0L2NvY28vdGR4LWd1ZXN0L3RkeC1ndWVz
dC5jDQo+IEBAIC0yMjgsNiArMjI4LDEyIEBAIHN0YXRpYyBpbnQgdGR4X3JlcG9ydF9uZXcoc3Ry
dWN0IHRzbV9yZXBvcnQgKnJlcG9ydCwgdm9pZCAqZGF0YSkNCj4gIAkJZ290byBkb25lOw0KPiAg
CX0NCj4gIA0KPiArCWlmIChxdW90ZV9idWYtPnN0YXR1cyAhPSBHRVRfUVVPVEVfU1VDQ0VTUykg
ew0KPiArCQlwcl9lcnIoIkdldFF1b3RlIHJlcXVlc3QgZmFpbGVkLCByZXQgJWxseFxuIiwgcXVv
dGVfYnVmLT5zdGF0dXMpOw0KPiArCQlyZXQgPSAtRUlPOw0KPiArCQlnb3RvIGRvbmU7DQo+ICsJ
fQ0KPiArDQo+ICAJYnVmID0ga3ZtZW1kdXAocXVvdGVfYnVmLT5kYXRhLCBxdW90ZV9idWYtPm91
dF9sZW4sIEdGUF9LRVJORUwpOw0KPiAgCWlmICghYnVmKSB7DQo+ICAJCXJldCA9IC1FTk9NRU07
DQoNCg==

