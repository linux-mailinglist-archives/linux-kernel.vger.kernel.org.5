Return-Path: <linux-kernel+bounces-14675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 072FF82209A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 18:50:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 702FE1F219D1
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 17:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94F22156C3;
	Tue,  2 Jan 2024 17:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nWZdqzOE"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 595F2156C4
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 17:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704217827; x=1735753827;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=La8fJ31TM1AivE0Lcxk+zybgD5rcQZP3WoEisOMFJRQ=;
  b=nWZdqzOEzD/sbLF3Bx0iIspC/qS8drHSAKXS6YTQFbJ5rgW5EjPyiKcl
   L1eZQWIozxtRneozIVSGEsjhgGdxbAm8Lows9ulpEsKVjw06nwTAO8fX6
   L8Ib+Tr1TiVlSgddda/UO0vjaXWbQnLJ7cl+k12s7yDbaig1v2a8aasQP
   xZAS8RmIFcZRZFVUuLO2ZONS5rWdYQMtcc0ILwpCtD0hsuOhpVXxyQya1
   0a4YSUi9/xdfiZRGSNK9zhX4+JXlhumCxFBuQ441AnkXUB2TZBeGr+lXs
   HQzLzsuZJElHgUbbRDu967A98ckmrEancrKJHddtfi8BK1/euUrTYlQLO
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="4240732"
X-IronPort-AV: E=Sophos;i="6.04,325,1695711600"; 
   d="scan'208";a="4240732"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2024 09:50:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10941"; a="813999325"
X-IronPort-AV: E=Sophos;i="6.04,325,1695711600"; 
   d="scan'208";a="813999325"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Jan 2024 09:50:10 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 2 Jan 2024 09:50:09 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 2 Jan 2024 09:50:09 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 2 Jan 2024 09:50:09 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 2 Jan 2024 09:50:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jOSdUgAJailBXF/hevcxt4+ByGMLNXPCN0g3bYelGXcvEBMBRhSK1HK225p74u4RIqw5mrr/cYQ5YI7Nl+es3Cjff6Cka3iYo/Mf6qATTkZPRn5qV1zRW2ZgUTmjGL/VxkTt4Bb9IEmy+SXEEt45SFXcE9HsTxZZ+xmnL0I9frpJx+dKn/COFf80aAwl8Sse/UgqKfJt5lmYy7GsbJY7IYanWaaU377WdxPgd6lTIdfYv7Z03mN1ARGrSF+rY1njFyscMiiATi0p8l2jiR8u7lNmaZKmG3FL6Q1wV+1gQV7z/kO2WpFhVlYuWet2wzyiFwLzCHp2tTq9fsSKBQdIAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=La8fJ31TM1AivE0Lcxk+zybgD5rcQZP3WoEisOMFJRQ=;
 b=Ghqwd3qbTPQM+31Uir1bXeS7nXv9VYR95pB+am5okBAotEQFw167o7mt7rdlPKjQ4aAIqNEPpmTnGtSk3zxz8GtXI9ffGMak/i5Z/50VqPYidfTnxpo+/GBvxrRJV09LgI41rUnKethATFwtm1Ryl2wj7bTOoZTlArEZ8iVh04n+EOowWV69IUiXba6l2wNJUpshxE7fCcIAnjiiWgGld1SID2IsIHTNiuzVZBE3Q+JthwqzeygWgOpEZOYwl3QLI8PF4HzDxfNsnBtnKYtg1adLOMulR8optUHCybK5sffCdrvlh6EhT9W88Ds8BcqkndjUAwOF9QLglEWrO8dgiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by CH0PR11MB5411.namprd11.prod.outlook.com (2603:10b6:610:d2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13; Tue, 2 Jan
 2024 17:50:06 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::6dc:cee5:b26b:7d93]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::6dc:cee5:b26b:7d93%4]) with mapi id 15.20.7135.023; Tue, 2 Jan 2024
 17:50:06 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "broonie@kernel.org" <broonie@kernel.org>, "debug@rivosinc.com"
	<debug@rivosinc.com>
CC: "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>
Subject: Re: [PATCH v1] mm: abstract shadow stack vma behind
 arch_is_shadow_stack_vma
Thread-Topic: [PATCH v1] mm: abstract shadow stack vma behind
 arch_is_shadow_stack_vma
Thread-Index: AQHaNTJa3xIRJ+Wk00639dPvXl10KbDG3dgA
Date: Tue, 2 Jan 2024 17:50:06 +0000
Message-ID: <19703a88d00b6e2d9b6ce2bf911ee34d465b1a11.camel@intel.com>
References: <20231222235248.576482-1-debug@rivosinc.com>
In-Reply-To: <20231222235248.576482-1-debug@rivosinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|CH0PR11MB5411:EE_
x-ms-office365-filtering-correlation-id: 8349815a-ff9b-4a17-47cc-08dc0bbb41a7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qh0PiL2l0mrKb3LG33hf7x5oqEbUIFvrvIVJ2P4XKerW+JHJnllIabevJmXKkd2Ct5Em9sCpjcJ5nCBDi3hrm6BKZ0R1IaQeb9ywUjEQdISiHfrXprXDLQdt08YWflWoH44yWSiCRAzSp8i7TzKiZWUNzIOxhf8S6zOYJPxtQHCZvjYbU7afIcelZo4VfeluT29x/BMH6UyPBGpvbVLFwV6nb9aXd8joHffjZZeATWJR/5hTyNfxlOBE7z/UmGXj0jfiS0gFkKaxMxkxy7HE62TZ48t6jsRmPHMTTUlB7EuvhSro+CgG0Dt3UN6orbHo3/6PomnBfYQSVfdpr+rZfBPLYoEGaUgyvVwQ+WbLBNpasNk9d605aYQveNpfBmkA32K89Dac+lIuJMPjsExAQQCjIpQuvclUuUyjazgf3uOdbcQxFCJ1R3g/gGDlmG2yWQHzquaaWskCLVGjb7vK480grTrTllJ0sQW23b8V29o/U8XdwFFkFMpq9nxPAcvc1/xffvL1Xn2dL8Il4EWlvtfZl3WLmYRwz0x4gLn7DYw4kl4yiOzxh9lABfzX1pTimDeTLzWKB9v/cKEtBZFkPiCjBL3r+e62AXYn6D+4NBY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(346002)(39860400002)(366004)(376002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(2906002)(26005)(41300700001)(2616005)(38100700002)(122000001)(82960400001)(8676002)(8936002)(54906003)(110136005)(316002)(71200400001)(4326008)(5660300002)(4744005)(4001150100001)(966005)(478600001)(66446008)(66556008)(91956017)(66476007)(6506007)(6512007)(64756008)(66946007)(76116006)(6486002)(86362001)(38070700009)(36756003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R2Z3WGNEbThHTzBqRy82cWdVbEY4R2ZjczRKRUJEUEJ4RFJXTCsvYk0zWjhk?=
 =?utf-8?B?Q2RSYW1ackV3eE1IZTlZV1gzdVNpOUlOWVVRaTZXSUpxVlYvc2ZHOXpocmVl?=
 =?utf-8?B?QUhNVERmdytycWEva20wYjludmlOdVlqWVRYUTZvcU9ERVo2MnJnaDRJZXdw?=
 =?utf-8?B?aUZsdFBNMldXQUFsM05Kbkh5VitBY2RqRVFaOFZRN01YWXMwRE1YZXFBK2lK?=
 =?utf-8?B?Z0VIOEx6QkFBSVp2dWNhUlh4TWpLcDdXbTVPdG5qR3dneFA5L21CeWJhZEY1?=
 =?utf-8?B?T296YWhuVEI4Y3hHQ0gvKzJJbHFGSjlRKys0K05MYkVXNE4ydlJLdGlUZzM4?=
 =?utf-8?B?RTJlWVBRVWlTVzhMZnAxaWRjRlNVZWVLQXVQamRuVHIwd2VLZUJHc01zblFH?=
 =?utf-8?B?alVLMEkzT1BWaU9Nbk10a2tyYmhsVG95Qko5TVVlWCsrTG1WazlpYTBQaXFT?=
 =?utf-8?B?a3d4aTNDcXpPOGYzZVBrQ1VMOTBJRUU5L2NmY0huSUFkbFU4YkVpYWg1ditl?=
 =?utf-8?B?aGhuc2RZa0x4Uno4dHBjK1lrNVRNTm5XL1BXNFRPajZBOUJDYzVYdUlHai9U?=
 =?utf-8?B?M0JvbzZSZ1NFRFE0WTBFdFZSNSthemJZWlhQRXJWM1dTb3dhVmZrRDFpRFNB?=
 =?utf-8?B?Rndtbm5UbGRZQ2xBTXdYNXRxaGMyTG1kbFU1dzF6b1JpZ1UwNUwvbVBPRHZH?=
 =?utf-8?B?cThnbE1jenc0b2MrRkhEcEdkN0sxdmtZeHkwZS9ScVdCS0tIcXlMemdTTVk2?=
 =?utf-8?B?RmlOdk5aUkYwUFdsM3VFZFJvc0V3Q1I5QVo5aFpZVnluQ2VPMFZBQWNnYnhm?=
 =?utf-8?B?N3dQdmNvcGNqa2FvMXZselpkNjhrbjlBN3krSFdQUDIzdnhmT2RUQVhNNmlT?=
 =?utf-8?B?SG5NdUR2eUZFOGtVam9jSElzQjVUdHBGNW9sSldUN2ZJcFdNMlhJNElRenAx?=
 =?utf-8?B?dEFkN0JqMHVJV29pc1hrR0pONGtVSVJPTVJlbEdueHMzV1hVNVlBWngvT1Qy?=
 =?utf-8?B?dW5aMW91ZEphODkwSmVvcG5qTkVNMm5ZQkUzRFU1aHNmcWVCS3A3aytndHBz?=
 =?utf-8?B?Qjdnb2xMcS9zUDNNYlN2UHp2c0lTT2RyR2tBS3FienliR1JONTRkaHo5UEUr?=
 =?utf-8?B?MFJ4elJWUGx6M2U2alU5ekNEWEtHajhCYjBORDFYV0lrTUhodEJXenFFSmlM?=
 =?utf-8?B?QXRXNnY1aFlPaHowOGtHMG95TjF0dFFERUowQjhIbFNWZ2VIUGJsaG1HclR3?=
 =?utf-8?B?SC9QMUVkT0g5NmNqdzZsU1d0blphdmsxQlk1bTEzc1VIRVAvd3hpdEZRc3Q5?=
 =?utf-8?B?UnY5eUxvaWMybkJwU0xEYWhzSk5RcERtd1d4czdCajBoaUE5Ymo1WWxrQmpI?=
 =?utf-8?B?OExTdWQzZHhJSHFaNVY0ZlM5Y3lLMGZhdnhZVG14dkcyazJhaDMrQ0Q3L04z?=
 =?utf-8?B?dXdjZmZ4OTNQK3hnNWRNb010Z3VRcVN5QktPVGRHd3dtVi9qRzJaZXNDbita?=
 =?utf-8?B?NlJ3YkJQUmZ1SWM5dTVLQkRybTl6SkpLWlVPM0t4RU1KZXdsbUFhd1JhdW02?=
 =?utf-8?B?eGxKZ2tvQmNrSlAzOENneWxwUHpVb2xtTnRDZlBRcFpEZVU1ellqZDNzTGM0?=
 =?utf-8?B?THk5WHNYRmxKL1VqN05mc2EyTGNqNUVBdUpQQUNWYTVXbVc4WFZyOHVuOGJN?=
 =?utf-8?B?bnpwS29CNnhUS0ViL0R1N01uRG1Lbng3clErY1hkSXdSWHpUKytscHFRNXF6?=
 =?utf-8?B?WkhiSVNOZ285dkdOWmpGYVhhanB3cWpUZnBFQlA2L0RxYWlieldzTVNnU0dH?=
 =?utf-8?B?UVhkODRKY0hjM1dHZHg1UVhEMWVmUTdvcDBHRW1OcXdGUW9UanhLM1diWGU2?=
 =?utf-8?B?Q0FDT2YrRnhPYzgrVVdFbC9nSWtIZTlUZTBVRGN4U2o1WTFkdU9UWVRzeUpq?=
 =?utf-8?B?VG9xUUowVzFLM1lOS2VKanI1OURqdUxtZlhaR1NCaFZsU2g4ajEwempJYWJn?=
 =?utf-8?B?elBOQWlOMFhUeEJSRGNGOEdJd1ZPQnZUVngyRU5PNk1zNjdsb2QwVHEvWkRj?=
 =?utf-8?B?NFY4S2hZSmI2QjhTOUJ3MWM0QzliV05aNW84MFpteUk2T1FQb3BFeGp6VHY1?=
 =?utf-8?B?MDVoYmVMUE5lUnczUmNXWElXQ2ttOEE1d3dOVm9hOFNySXFyMFkzZ2o0WlJQ?=
 =?utf-8?B?OUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C9DC1C84C9C0E045A5A9EDF6B96D07A5@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8349815a-ff9b-4a17-47cc-08dc0bbb41a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jan 2024 17:50:06.7943
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PQf2+TcEiPDDhl28UTp5Ib9RWhoZUTkl7u+JOkpDFThqEyDJna1jGsMIK1zQySc4pZ+acOlpICFrhbBD69NOIvajFmk7q9sn+QZE5RARMf0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5411
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDIzLTEyLTIyIGF0IDE1OjUxIC0wODAwLCBEZWVwYWsgR3VwdGEgd3JvdGU6DQo+
ICsNCj4gK3N0YXRpYyBpbmxpbmUgYm9vbCBhcmNoX2lzX3NoYWRvd19zdGFja192bWEodm1fZmxh
Z3NfdCB2bV9mbGFncykNCj4gK3sNCj4gK8KgwqDCoMKgwqDCoMKgcmV0dXJuICh2bV9mbGFncyAm
IFZNX1NIQURPV19TVEFDSykgPyB0cnVlIDogZmFsc2U7DQo+ICt9DQo+ICsNCg0KVGhlIGJpdCBh
ZnRlciB0aGUgIj8iIHNob3VsZCBiZSB1bm5lZWRlZC4gSSB3b3VsZCB0aGluayB0aGF0IHBhdHRl
cm5zDQpsaWtlOg0KDQogICBib29sIHJlcyA9IHZhbCA/IHRydWUgOiBmYWxzZTsNCg0KLi4uc2hv
dWxkIG5ldmVyIGJlIG5lZWRlZCBmb3IgdGhlIGtlcm5lbCdzIGN1cnJlbnQgYm9vbCB0eXBlZGVm
LiBJcw0KdGhlcmUgc29tZSBzcGVjaWFsIGFyY2ggZGVmaW5lIGNvbnNpZGVyYXRpb24gb3Igc29t
ZXRoaW5nLCBJJ20gdW5hd2FyZQ0Kb2Y/DQoNCmh0dHBzOi8vd3d3Lmtlcm5lbC5vcmcvZG9jL2h0
bWwvbGF0ZXN0L3Byb2Nlc3MvY29kaW5nLXN0eWxlLmh0bWwjdXNpbmctYm9vbA0K

