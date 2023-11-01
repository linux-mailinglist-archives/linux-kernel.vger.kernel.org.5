Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B5997DE72C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 22:08:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346405AbjKAUeB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 16:34:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231461AbjKAUd7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 16:33:59 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29F82DB
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 13:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698870834; x=1730406834;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Cp4iVeEmUC+vZMvjPDM6amjD08xP2fG0kDLkuKjWBi0=;
  b=jyzyimHWorUMM18JMh6y95I9O1ZxP6eYUGw6ti+T2OLReDeoZAmB+l6q
   HmKy+zVFuEhZirilAWlLuyoW+Y4L7fwII45mKHT+M7+s88UnkD4Zg0lXX
   i+ss/RHLSlbmvXicC8aawTL+QtxZLEk5lygoA9tNICTvw2W8CA4e8ZcjS
   c07MvAxu+F05u2GggnhJyRBZtXanj/kfxYmZpKkBUxcdw4FFikeqk89wT
   Yx13YNZqD9RnsdACVoe2r5OV9oDyCwSybEiNoPthVEmuLnK8FROUH4IhW
   ah6/ZXBViYOtTLBkoZ/Xs201XmaXBe78CdxryG4wuNbt3sRcBKHdLawcp
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="419691803"
X-IronPort-AV: E=Sophos;i="6.03,269,1694761200"; 
   d="scan'208";a="419691803"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2023 13:33:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,269,1694761200"; 
   d="scan'208";a="9157748"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Nov 2023 13:33:53 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 1 Nov 2023 13:33:52 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 1 Nov 2023 13:33:52 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Wed, 1 Nov 2023 13:33:52 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Wed, 1 Nov 2023 13:33:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RzPRLQ9CjYzQO/5OgWPsHg+w5ZhKi0zUSOex4JDNsX+AgbumqzzkXgIibzf2W2FmY4/rWhYcVjwEzxuMAXYC9yZRaM8szAGH2tW5Y76gd5eAGqihIr1Ld2XfD+9ByCN5mIj8jOjf+DCKIxJNrVUT6sb2wW5pMRXEl+ZLbRBKJIagi6tcIWq3gs+TecX/smWwdu3GkJHk//+nzvcfaWMRgjcZbzQfhzGNZapHUXPUH4eyQoQLFJZTxUqaFqKdvsPHoRwSLaktjkd/ANIUBmSWoHJRfHEaFKz4gNGgL9hlZWWWRBZ9EDjkF4hKg8iAHaLdTED2wLrslo94t4ceHRbXzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cp4iVeEmUC+vZMvjPDM6amjD08xP2fG0kDLkuKjWBi0=;
 b=ZWqxlJrwZ4ra0g+DKpHoaRuFXu3Uduox3sD3V9vVAqHIh970oCuWB9wIepjpo9Yv3h/VRD1manK5JGofb8mWMdEBX2mgGx8alvOw8itOSSAzU8YavI+Pc4rLLavyi2AxDKI2sNs2Ftx4KHwUxM7neMBxxD3P49cD53WubjFzyee5y6IdgsAKjGH1119vrtRzC/WZzNraw19b/RhuF9VD4v1Z1LsCiInsA+dzqUmiu+j/4J6e6J03KPgcg+qO8OgC8yxRlv82rXPYXwnrsVXMtXgIavdFJtbgoQ3XpTooDe3y8puQGWo2KvoLPES8sZhcxzUn6qDR+7Qli5tAAWjcyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by SJ0PR11MB4846.namprd11.prod.outlook.com (2603:10b6:a03:2d8::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.28; Wed, 1 Nov
 2023 20:33:48 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::2b58:930f:feba:8848]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::2b58:930f:feba:8848%5]) with mapi id 15.20.6933.029; Wed, 1 Nov 2023
 20:33:48 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     "babu.moger@amd.com" <babu.moger@amd.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "Chatre, Reinette" <reinette.chatre@intel.com>,
        "Peter Newman" <peternewman@google.com>,
        "x86@kernel.org" <x86@kernel.org>
CC:     Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        James Morse <james.morse@arm.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: RE: [PATCH] x86/resctrl: Fix unused variable warning in
 cache_alloc_hsw_probe()
Thread-Topic: [PATCH] x86/resctrl: Fix unused variable warning in
 cache_alloc_hsw_probe()
Thread-Index: AQHaDEZs+0NIXdfp+UKs6XMbXW1JaLBl6s+AgAAA7RA=
Date:   Wed, 1 Nov 2023 20:33:48 +0000
Message-ID: <SJ1PR11MB6083C14236AC0AFCB49DFB15FCA7A@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20231031220534.37730-1-tony.luck@intel.com>
 <d47235e0-7ecd-483e-82c3-78f13c77df67@amd.com>
In-Reply-To: <d47235e0-7ecd-483e-82c3-78f13c77df67@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|SJ0PR11MB4846:EE_
x-ms-office365-filtering-correlation-id: 3c46d2f0-6fa8-4f3d-d44b-08dbdb19da6d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OSyS1s9d3rbjWVmVgIRNWnjfOSE72Ay/E517EMk3rzlIX8tkSB93HRDn3p6Cwad+0egJvqQofglxGk4z4z0+FmedPiXqxPakKcxoqe6FFAlNsf4D+OWzE0FHF6P/pJHRGcjMjAKxQXTqWC0mZfC0hGuylzAICn/vI63UTax185opLH2oOv+kCbOTrQLYUpeMYBQr7/q8fV/2qg0GSSWPcofrhBvXCYDI95cC3ur1lo5DWzMykT5aJXBzrhtaKw/h1H/rJSoRaxiXap/p90alFnrVM2o9ylopI+uOCtm9MuM7e0VCA7RFXsOMvrMMlysghC/uMkYBdRCBPVFJDFlaYuRiMny6ZR62+komaLxL1L6sql4ktOPuAejQvTihNBCR+D4AGEDrdeQYuwxa7LAGcwi4N0/+B22+U3Kj6rYOGrwPvjGlFQj6xMGhwgMcFQKUBvSAnG0DL1s1fU39AVwh7hwQkaXlqBbFXCxirHiRfPhvxMdX7TygdWPg6nyzt92ZHUQsCsPgPbE06XnJGTv5Pq/sl6wckKQ0C2j3DIRZ/muvVlv4z0+pIzW2kjxHaKN90CxTZTacbMJrUn9W6DkzrToiEW47/B1j+ImbcNeh2XgaEDfUyz8oIvTH6rwnVZpa
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(39860400002)(376002)(366004)(396003)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(71200400001)(26005)(55016003)(7696005)(6506007)(38070700009)(38100700002)(82960400001)(9686003)(33656002)(122000001)(86362001)(66446008)(64756008)(66946007)(5660300002)(110136005)(316002)(76116006)(66476007)(41300700001)(66556008)(54906003)(4744005)(52536014)(8936002)(8676002)(4326008)(478600001)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WG8wczZMQUFqRk1wUW1vR0s1VVE2ZHBKaytEMlpWZmpQbVI1WHB4WHJuMzhK?=
 =?utf-8?B?MDFaSldsbnh4WjNVaUcxaGN3akx6ZGhTbS95c2YwMW1BazJUTGo5NGRUaFRh?=
 =?utf-8?B?ZzlzT0NuOHFJdFczSXBoMWpKOFhzNHFrWkNkWklYZTVqNW9Pb3lNMkZvLzNW?=
 =?utf-8?B?Yk9FSnlJYnFHN3hnN2RLaXQ5UjhmZ0J2ak9ZeG41K2haQVh2OVdoNXhuVFUx?=
 =?utf-8?B?Q0srM0xCaERmdmVQTjJOdy9ra1UwQnEwTGtzOXZoMEEwM2hOTG11MEw4ZzdQ?=
 =?utf-8?B?bnBOczI0S28wTmlTQkJqblRwOGhJYlBaNDk2Ym9IYmkvQkY0Y3pwaG0wSVZF?=
 =?utf-8?B?WmFZMDN1NHZFNEJmeTZHeUo1YWdIWTFNU3d3TUVVSnVGRHdFMmYrakN0aGwy?=
 =?utf-8?B?Z0F0WkxTZjdqaHRGem4rVVhzSDFOelMrUkNRcS9sL3hDUk1LYW5FZG5qZjhL?=
 =?utf-8?B?ZDRGMEM3OEp2cm9jMCtwMlc3WTdqSlJFbUxVTnpVZ3F0SG5DaWlMelFrdjB6?=
 =?utf-8?B?N1VVK1dvU082ZVN3OEVSQ3VsUkFYTzZjbmwrKzhTVjZZcnRzczBtek03aE1Y?=
 =?utf-8?B?b2paZ0NDbE1NU1ZuZVNacEFBaElteG1Rd1lTN0s3QUd6VFN4VzlsNW5UQVlQ?=
 =?utf-8?B?dytaU0tHdkJQMnNhVGM0Yk9rVm81Qk04MFFFUDJKSEgrMUtCRjhUQkppeXpH?=
 =?utf-8?B?a0Y1L1JybDhrQ3pVL3hwYnFBRzNyNmlMQ0xJL3JVSkxGdjIrWmdzMGdYUzh2?=
 =?utf-8?B?cFRpQmVpTTMwamRhWWdPemIvMGxzcEtNbjFiQzFPUDFIUHFha1FNTDluRFQy?=
 =?utf-8?B?M2pqNHlhV2N0SXUzSmJ5TE45d2NvMTh6MnA5Y1NOWEJDQWFRdkg3WDVhZG0x?=
 =?utf-8?B?QVFhTHlQcVFWWnFwbVZSeStZQlU2WTk1MzM3SUhYakNHQWlRak82U2FlNTRj?=
 =?utf-8?B?aTBLdEZjVVlVdUZaUTJRRlQ1UGpyR2E3NzYvQVBIMTJUWEZqZUlEL3QwZFJr?=
 =?utf-8?B?Vng3NnVuLzFwdGNmckRKNGJUbTFGTTc2VE55TkIxZzRJSklZYlp1ZXUwWUU1?=
 =?utf-8?B?by9pMnNqejFNSUlXbVNFNXdWRnR5WVI1SHV2amhEQXIyVjhVd2UyTXF1YWln?=
 =?utf-8?B?VUd3MnlFZ2k0ckRzWUlBRkhnZjh5SnhRRmlnNkVsNG53T3IxQkRLazBGQklJ?=
 =?utf-8?B?SHhCYW5wWVo4cjZnWVpEWXB3N2VZVE5NL0ZwL2p1MTY4d1d0YVVNcXVyOUJm?=
 =?utf-8?B?aGlpbE1kMkkxVWFDaHloSDVwU0pyeWJod2ZPSkVhT3ozR2FOQ1Q2Uk51RnFv?=
 =?utf-8?B?R0xXNHJFa1JtVElnT2VVQmZOV1piWmxoODc1L2N3c2c1QkJqemtTbWxCZ0Vv?=
 =?utf-8?B?LytUYXJoMzFXRUhyNldpQUdobTFpaFRxbEFDOExIZzIrUWxxQ3FPeWErY3pL?=
 =?utf-8?B?NFZjNHZMTFlBcjhhYStabjJONUpiYVdibUJMeFBnWVI3MGpoMEtWQWlPbnlQ?=
 =?utf-8?B?VDMrSGNneVNUNnVESGk4WFRZQnZUNVJYNWFaT09EQXlkMnpTdDRtQWlBbjc2?=
 =?utf-8?B?K3Jic01jUk5qWDJqSzN0WEIwWlV5eDlEZjJjWVJVdUxTZFZ5NzRzQ04rY2xz?=
 =?utf-8?B?eW5aODRGUVVoNW5MSUhIRVZiUnc2UDJOVW5QRElZQTRPczJKVU1wMjRKdHAv?=
 =?utf-8?B?VFlVTkZSeXJxOWUyUTM1clRhOVF5Tit6eDV1ck52UXlUQTVNdXYwR0lxWkEv?=
 =?utf-8?B?L3NxVVZ2em1Vb01hZlg0SVBwblZ0c0RsSU9jNGw2SFFGeFRBV2ltZkt6bUE1?=
 =?utf-8?B?Y1g3SGlNYWlJZ1V1Tjl5bTh4ZnpybVUzV3drdDZqakZnMW1HYW9JcWNrRGcr?=
 =?utf-8?B?RHloSkNpcVQ5S1MwZUJic3Rqd0V0RnVLQW5OR09lcUxZV0VyQUNzeVZlK0sz?=
 =?utf-8?B?bHBHZ1lJQkJJQ0d6aXlUaEtQWXJ5aFQ2S1NmeVhYQ2ZSK0s0UjBLK3JNOVVQ?=
 =?utf-8?B?UXVFYmNIZVVoQ0VLZkM4SVdvc0RmSU5DUW5jWklLYVI5OE9nNldXeXZkYzNy?=
 =?utf-8?B?VDBtMEZSWjVLMmQwREFPUkdJd0Y5dU5URW5JZFE0a3dzNUhCbFEvcjlhU05C?=
 =?utf-8?Q?hjhziO3/80Fg3a+67bMoKbSfz?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c46d2f0-6fa8-4f3d-d44b-08dbdb19da6d
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2023 20:33:48.7797
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AsgYBZH+R8UzIVm7ES96jQrZp/0UZGjKCaeet2riXYQBtHUs9yhNqQ1qO6fKjuyoKinhptgBa0HKBEuNgU0XbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4846
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+ICAgICBpZiAod3Jtc3Jfc2FmZShNU1JfSUEzMl9MM19DQk1fQkFTRSwgbWF4X2NibSwgMCkp
DQo+ID4gICAgICAgICAgICAgcmV0dXJuOw0KPiA+DQo+ID4gLSAgIHJkbXNyKE1TUl9JQTMyX0wz
X0NCTV9CQVNFLCBsLCBoKTsNCj4gPiArICAgcmRtc3JsKE1TUl9JQTMyX0wzX0NCTV9CQVNFLCBs
M19jYm1fMCk7DQo+DQo+IFlvdSBhcmUgd3JpdGluZyAzMiBiaXQgYW5kIHJlYWRpbmcgNjQgYml0
LiBXaHkgZG9uJ3QgeW91IGNoYW5nZSBib3RoIHRvIDY0DQo+IGJpdD8NCg0Kd3Jtc3Jfc2FmZSgp
IHdyaXRlcyBhbGwgNjQtYml0cyAuLi4ganVzdCBnZXRzIHRob3NlIGJpdHMgYXMgYSBwYWlyDQpv
ZiAzMi1iaXQgYXJndW1lbnRzIGZvciB0aGUgbG93IGFuZCBoaWdoIGhhbHZlcy4NCg0KSSBjb3Vs
ZCBzd2l0Y2ggdGhhdCB0byB3cm1zcmxfc2FmZSgpIGFuZCBjaGFuZ2UgbWF4X2NibSB0byBiZSAi
dTY0Ig0KdG8gbWFrZSB3cml0ZSAmIHJlYWQgbWF0Y2guIFdvdWxkIHRoYXQgYmUgYmV0dGVyPw0K
DQotVG9ueQ0K
