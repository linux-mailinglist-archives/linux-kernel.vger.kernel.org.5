Return-Path: <linux-kernel+bounces-1425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2EDB814EE3
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 18:33:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70BFC1F21C87
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 17:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C791082ED7;
	Fri, 15 Dec 2023 17:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aT/+jI2W"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D7163010F;
	Fri, 15 Dec 2023 17:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702661576; x=1734197576;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=fqokpoKkIpKA1lwzNVmJUA49H0PG6XMit0WTM2Apxr8=;
  b=aT/+jI2Wg6Jx+0My8yfTSUWiGTY9074yvc9Q1v6PrMLvPIrxo6SKJtzH
   0yhPGrnSFRf6zypxRS2mvc5GzCdV0mUYKD+CSNYK516K07OjQpaHQAKCW
   7Sx1Sfs6bv6BdgRqOCET17vh7e81eneSl/qLvg5N/uHQhBVU7UKcpg8HR
   qMfwitDkjbix49NW5Tr712dYLuVgFGOMN9YRegxoKWALaUdtfQF2QwPrl
   jpn0uYxYxFk80QDAkaQWlP8GI77RCfi66qSJR5gmxowhAsRX76oIgmoEM
   3b1EA3M87yNICtHXoOpb506i3K/Qi+reRnzco1tZelR6xB4heg0eU65VD
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10925"; a="375452778"
X-IronPort-AV: E=Sophos;i="6.04,279,1695711600"; 
   d="scan'208";a="375452778"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 09:32:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10925"; a="840739049"
X-IronPort-AV: E=Sophos;i="6.04,279,1695711600"; 
   d="scan'208";a="840739049"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Dec 2023 09:32:54 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 15 Dec 2023 09:32:53 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 15 Dec 2023 09:32:53 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 15 Dec 2023 09:32:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gfvc/vAPHCsqO9EAJRzEwfrcm2MRzlwRevKtOk9hFrSFoNKddn0M5/iWuqvWO9M/+QY5pONYvSjXL5JuCU4ArgN1wcOtzWXtocZEZDM8UNpVF0ZWdCNYyGEsUMYFMnoLibmzh4PkZbYt78pN96CfOFdsSJ1X7ca/i2eEcUepzG8Bze6bIcWSpGSZ/KPQFakRq2yionfHqKbE8XSLFC2YsflxRzIpWDUW+E6X7vx3pwnZ58RntTopqLNhKyHxYgTlqo5aAFNtIYjgRZ9/Tb5QWVzMHTTbS4YflzsEA6+wbo+bmEQmOP2Vhq9yomW4RWc9mCGIegybZN/1ajEAEf+3GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fqokpoKkIpKA1lwzNVmJUA49H0PG6XMit0WTM2Apxr8=;
 b=g+Y9uXb3FlAHhEKyhzjyRJi8HyIYg+kPCaky52cYYWJPv9gUdNpzX3JAoyI4AGsHOzypZYt98xfUeqzFQtR+uChuHLQt87isUyyYXhP1jFDyFc9BVl39sK+/Ip+4g9FCNL9wyKmCw3o9f9yU5FUhUzd21D/y63H/Gt0RDyNgrEaPhPV5AmzbsgYgPluX1oLYu6Gw86uOMqYOIQPzJa1Rtc8swZvdD4/+3X2RJTM9zBz6HtJ/8HPl+O8OP0U9e3vFI+E00kpw5VAKIpYUwqjRmw/t3Fvewit6cR21MM69YSFIPbvycRGulKc/U46tBm7cxJM9QVgxDlaLaKiWQ2+UQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW4PR11MB7125.namprd11.prod.outlook.com (2603:10b6:303:219::12)
 by CO1PR11MB4913.namprd11.prod.outlook.com (2603:10b6:303:9f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.31; Fri, 15 Dec
 2023 17:32:51 +0000
Received: from MW4PR11MB7125.namprd11.prod.outlook.com
 ([fe80::a6d2:cd34:d89c:7b35]) by MW4PR11MB7125.namprd11.prod.outlook.com
 ([fe80::a6d2:cd34:d89c:7b35%4]) with mapi id 15.20.7091.032; Fri, 15 Dec 2023
 17:32:50 +0000
From: "Verma, Vishal L" <vishal.l.verma@intel.com>
To: "Williams, Dan J" <dan.j.williams@intel.com>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>
CC: "david@redhat.com" <david@redhat.com>, "joao.m.martins@oracle.com"
	<joao.m.martins@oracle.com>, "Jiang, Dave" <dave.jiang@intel.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, "osalvador@suse.de"
	<osalvador@suse.de>, "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "Huang, Ying"
	<ying.huang@intel.com>, "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH v6 2/4] dax/bus: Use guard(device) in sysfs attribute
 helpers
Thread-Topic: [PATCH v6 2/4] dax/bus: Use guard(device) in sysfs attribute
 helpers
Thread-Index: AQHaLxcpu2T6sC1vSk6xtM/1qGvjArCp8jIAgACkTYCAAATDAA==
Date: Fri, 15 Dec 2023 17:32:50 +0000
Message-ID: <89ea0a46cd1cf22393c6b05a50cd3e719ab6a4ba.camel@intel.com>
References: <20231214-vv-dax_abi-v6-0-ad900d698438@intel.com>
	 <20231214-vv-dax_abi-v6-2-ad900d698438@intel.com>
	 <2023121515-litigate-finished-76dd@gregkh>
	 <657c89c16d5f5_269bd294bd@dwillia2-mobl3.amr.corp.intel.com.notmuch>
In-Reply-To: <657c89c16d5f5_269bd294bd@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR11MB7125:EE_|CO1PR11MB4913:EE_
x-ms-office365-filtering-correlation-id: 7f339ff1-e8e4-43a3-cfc7-08dbfd93dcbd
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NfzWI6YXHS4BEHPB4XXAFD24OmdGG7U2rMODHso1VMptlzgSb4r3AGA3kpuiyZvPAXkpyhB2Y0QAJFOhICRLM58GsKusjzJ1sn2X72Ki+cs3Ujp+xXZD+55G1Le7VgiIpqt6BqQccmiavgjozBP1Zo8iXX+Jcu17A2Yvdbj9HC4kzdMd06lqXJoqBvEMfL2M0N94eUf/OCcHvDxOkVx1NTlbPo/twt5rUkJfrVbL1CaolQum1/FnH7ZBg2zFwBL/NjRxkN+xHeQtcRaiSNK5nCNLArmPbbE9EAhp6BIK0HqWdSMuuRlvntgnhVMSZgIbGWLJUr0OdE9Z46FVKZ0dSN2SDgTKKkl8oa8tnVFN7jpuSLFuNhzPHfbZRrTvaFmETvi9sciGXc5NIALrGjPJCV2bnjpDq7ZMnPi7FToCYetxqBeRQikqCzxigr6Z7AxlA75pjl7Xg06gMV4bqBra32xY/B/2F3xxjw3mIGRdyubBCYKnLJaXsHSYVe+OugNPszFiGlMu8gbggOgWDoY81EADJP+TY2gTr0Uroroq9Din2SLWXj2J4KMEXm0rCisxS8+YIGZl+3Up/EI7oMywCveApdXldOQdM4ZE9vL9w9T/XeJAYVjR+17ob3oLNc8a
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB7125.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(396003)(366004)(136003)(346002)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(82960400001)(66476007)(66446008)(64756008)(66556008)(110136005)(54906003)(76116006)(41300700001)(8676002)(83380400001)(2906002)(71200400001)(8936002)(4326008)(38100700002)(122000001)(5660300002)(66946007)(316002)(7416002)(86362001)(6486002)(38070700009)(478600001)(4001150100001)(2616005)(36756003)(6506007)(6512007)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UzNGUmpNS21xYjZ4ZXI3di92ajM0THE2Y1Y2VlIvcnZLaWtrWXRORUdqdURP?=
 =?utf-8?B?Vmg0QlVoV2xscnJuMS9zQ3RCTit0ZlFyT2tCWnlLbHVvYmNuQ3NiVVlBb1RR?=
 =?utf-8?B?dGtYUVN0dFBMbkJ4QVlVcm5vZVNQU1kvS2dRYTlEa2MraHhuM0VVYVc0NEpv?=
 =?utf-8?B?UjdIZWQ0a3B1cHY2dHo5TFZzZDJqNTZEZmN4QS9KYVpWeERRTTFiUUhKc1BI?=
 =?utf-8?B?RHc1ajk1cFYzd3FzaFEyZW0zVWg0Q2xTQVBoa0NDTHJadkVkL3ErWmVVTm8v?=
 =?utf-8?B?Z01hM1o0ZE9YUW1EZlZvTjNNY0JicGVhMkI2N0tMbnRBN0o5UC9JNE9JY2lt?=
 =?utf-8?B?ZW5QOERWMHVZd3VtN3dMbnAxQVMxOGp5ckNWakcrcUN2dnkwdXVDZWZvc1Z0?=
 =?utf-8?B?MUNpSVJlTkNRNVBEVFc4R1VzVnFGcmRQU3J0ekZBWmlBUUN6VmJ2T0JoR3hU?=
 =?utf-8?B?VVVPT1dDcCt6dERkYURuZnZjUFdGTmVqcThZSE0rdGgrQm5XY1RsT3lXK0V0?=
 =?utf-8?B?cWRMUnhLQ1pHRUhwOHcyTGM1U0M3VUgxaEhHMnpNV1FFUmo3T05OTzY3YU5m?=
 =?utf-8?B?blRjRzB5MXBDVVVQWWZtTEE0KzdRQ0VjWnltcjQwb0R3Y3JFUnJsOWNhNUlT?=
 =?utf-8?B?SzNreGw3VmM2TnBpREgySEpjeUVTVFJCclNBNTB0cE5wVktsNEhoYnpFUG5Z?=
 =?utf-8?B?RG5tem1qM1lJbVlUU0pkOWhPY0lpV2s5dERGbitBNURqT1h0MXVDNkwxckky?=
 =?utf-8?B?WFVId1dkTE5vMFRCTGVnR01lZjRDTlU1N0RBYU1LQlZmMTdXajVXcU1TY0N5?=
 =?utf-8?B?T3Z6TWNCQ2hhRzNlOStVQmNKNmVJT1g1OXZ5b01FSWxlcXpISTB1SVFyOFZK?=
 =?utf-8?B?Z0tGaDNWdXlocGxCQjRZSTE1cFJFU1l5amtFTGNyVHlsWUFBUHBwd3hETkJC?=
 =?utf-8?B?ak5pdzBiZEhjMXZWVFFSV3UrbTBjaDhWekhmMlczSWNhWGtWeWM2b21zdlBM?=
 =?utf-8?B?TDhUTHE2ZlJSR3IzMlBwREo4VXdHY0JJZ0l2NkI0bytiUHkxZjJvcmVtZE9v?=
 =?utf-8?B?MnF1UEJVenUweC9OWjBkWUVhOXNaQzNDMGkrOFl2eGxZZmN2MVB6dHFZVHdy?=
 =?utf-8?B?eFAxSWdZTzhFbngwbXZuZTRJd3BkcGJJdWtSL3poSUUxeDlYNzBVeW5XOWYr?=
 =?utf-8?B?SXJvMDJlc2RCaVZzcjl1ZXVSS05rNXFGUWVRZmd1L0o2UTh6ZFFSblR2VHhm?=
 =?utf-8?B?R0UvUERraUZ4Y2wrSjZzdjZmY095VDZsUmc3Uk9lOE9VdEFIV3U3TzRDV3hS?=
 =?utf-8?B?TDlRTlJ5Qjk5Nk9IdEkzYU5pbWN1c1V0VS96MG9GYUR3NEk0YjJ5VDUvWmlH?=
 =?utf-8?B?S3BXclA0L0JFeVFSNnVjc1BiUHJkOFhKUnR0V2JzR3Z3N3kzYUVlSjhnRzVZ?=
 =?utf-8?B?QmE5NFBsTVVndzB4a2NkVU43SzdweEEwNE9UZk05akV5b21GM3VTOE5YUWk1?=
 =?utf-8?B?TVNMdm9Vdlo2R2kwb1FNb3V5SUhzcEVLT2VFM3pGeWNoWFpSUzVFT3AzZkVn?=
 =?utf-8?B?a044MDREbER0U2xCR05pay8wVVRRWHdreG5kZzNrd2wxZmtUUjRCVndKUk1L?=
 =?utf-8?B?Tit6Y3Z3eTBiMFk2cXo5ai9QY2RmdzFhL05Ya2c3UkVIQ2dDSklnVnF5Mlc4?=
 =?utf-8?B?cXJ0Y05WK0UyclUzb3lhWUgyYnBmNlZBQ09QNWlDcmFsVFZNcFgzOVdFdGkx?=
 =?utf-8?B?d2pQMTZ3alg4MUhJaCs2a0hmMjh4RmhXQXo2Z2JubUlDU21FdUY4cDRnT0th?=
 =?utf-8?B?bWpWem44SUNUZ2FvakI1dmN1elZHaGdBeWxIUGdmTXNVazlaWktxTW1sZDh3?=
 =?utf-8?B?ZWFFVG5JRlVFdnpIdXlDK2xhTkFLOEc0aXV4SVBiV1NLM0k4dEdkdDc3YzQr?=
 =?utf-8?B?eWpYcnQveTEvNjRYY2htL0I1bW13bjhjS3N2UERYM0VKaUpvYkNsUVBBa256?=
 =?utf-8?B?bTFGUy9idHdMcUlxdlByQzBVbmJBYm90a0EvbGs1cHNlMDBiNnN4SDNJYk1I?=
 =?utf-8?B?QVV0ZDZnRG9Xc2JONVJiNHVCSjhzN2FVbGswcjRaY1dCTk00WCt1Mlh3YUFo?=
 =?utf-8?B?bXROMThpZGp6TEN2dW1abUtaR3VkY2ZVODB0cDY0YktpOCtYd3JwanZGbitm?=
 =?utf-8?B?L0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <11A0A1FC0960E04390A32B591058AB4A@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB7125.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f339ff1-e8e4-43a3-cfc7-08dbfd93dcbd
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Dec 2023 17:32:50.8456
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qH0ieUp66/yc3leNUrT9JmCXhi64g7gxpKxiPLwu6cmsB8zk0o2F3evseT4/T1t3ycPh7UrR3YU8mLJPdu6Q4VkOdhFXeaL4he3MpoEnr/4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4913
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDIzLTEyLTE1IGF0IDA5OjE1IC0wODAwLCBEYW4gV2lsbGlhbXMgd3JvdGU6DQo+
IEdyZWcgS3JvYWgtSGFydG1hbiB3cm90ZToNCj4gPiBPbiBUaHUsIERlYyAxNCwgMjAyMyBhdCAx
MDoyNToyN1BNIC0wNzAwLCBWaXNoYWwgVmVybWEgd3JvdGU6DQo+ID4gPiBVc2UgdGhlIGd1YXJk
KGRldmljZSkgbWFjcm8gdG8gbG9jayBhICdzdHJ1Y3QgZGV2aWNlJywgYW5kIHVubG9jayBpdA0K
PiA+ID4gYXV0b21hdGljYWxseSB3aGVuIGdvaW5nIG91dCBvZiBzY29wZSB1c2luZyBTY29wZSBC
YXNlZCBSZXNvdXJjZQ0KPiA+ID4gTWFuYWdlbWVudCBzZW1hbnRpY3MuIEEgbG90IG9mIHRoZSBz
eXNmcyBhdHRyaWJ1dGUgd3JpdGVzIGluDQo+ID4gPiBkcml2ZXJzL2RheC9idXMuYyBiZW5lZml0
IGZyb20gYSBjbGVhbnVwIHVzaW5nIHRoZXNlLCBzbyBjaGFuZ2UgdGhlc2UNCj4gPiA+IHdoZXJl
IGFwcGxpY2FibGUuDQo+ID4gDQo+ID4gV2FpdCwgd2h5IGFyZSB5b3UgbmVlZGluZyB0byBjYWxs
IGRldmljZV9sb2NrKCkgYXQgYWxsIGhlcmU/wqAgV2h5IGlzIGRheA0KPiA+IHNwZWNpYWwgaW4g
bmVlZGluZyB0aGlzIHdoZW4gbm8gb3RoZXIgc3Vic3lzdGVtIHJlcXVpcmVzIGl0Pw0KPiA+IA0K
PiA+ID4gDQo+ID4gPiBDYzogSm9hbyBNYXJ0aW5zIDxqb2FvLm0ubWFydGluc0BvcmFjbGUuY29t
Pg0KPiA+ID4gQ2M6IERhbiBXaWxsaWFtcyA8ZGFuLmoud2lsbGlhbXNAaW50ZWwuY29tPg0KPiA+
ID4gU2lnbmVkLW9mZi1ieTogVmlzaGFsIFZlcm1hIDx2aXNoYWwubC52ZXJtYUBpbnRlbC5jb20+
DQo+ID4gPiAtLS0NCj4gPiA+IMKgZHJpdmVycy9kYXgvYnVzLmMgfCAxNDMgKysrKysrKysrKysr
KysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+ID4gPiDCoDEgZmls
ZSBjaGFuZ2VkLCA1OSBpbnNlcnRpb25zKCspLCA4NCBkZWxldGlvbnMoLSkNCj4gPiA+IA0KPiA+
ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZGF4L2J1cy5jIGIvZHJpdmVycy9kYXgvYnVzLmMNCj4g
PiA+IGluZGV4IDFmZjFhYjVmYTEwNS4uNjIyNmRlMTMxZDE3IDEwMDY0NA0KPiA+ID4gLS0tIGEv
ZHJpdmVycy9kYXgvYnVzLmMNCj4gPiA+ICsrKyBiL2RyaXZlcnMvZGF4L2J1cy5jDQo+ID4gPiBA
QCAtMjk0LDEzICsyOTQsMTAgQEAgc3RhdGljIHNzaXplX3QgYXZhaWxhYmxlX3NpemVfc2hvdyhz
dHJ1Y3QgZGV2aWNlICpkZXYsDQo+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oHN0cnVjdCBkZXZpY2VfYXR0cmlidXRlICphdHRyLCBjaGFyICpidWYpDQo+ID4gPiDCoHsNCj4g
PiA+IMKgwqDCoMKgwqDCoMKgwqBzdHJ1Y3QgZGF4X3JlZ2lvbiAqZGF4X3JlZ2lvbiA9IGRldl9n
ZXRfZHJ2ZGF0YShkZXYpOw0KPiA+ID4gLcKgwqDCoMKgwqDCoMKgdW5zaWduZWQgbG9uZyBsb25n
IHNpemU7DQo+ID4gPiDCoA0KPiA+ID4gLcKgwqDCoMKgwqDCoMKgZGV2aWNlX2xvY2soZGV2KTsN
Cj4gPiA+IC3CoMKgwqDCoMKgwqDCoHNpemUgPSBkYXhfcmVnaW9uX2F2YWlsX3NpemUoZGF4X3Jl
Z2lvbik7DQo+ID4gPiAtwqDCoMKgwqDCoMKgwqBkZXZpY2VfdW5sb2NrKGRldik7DQo+ID4gPiAr
wqDCoMKgwqDCoMKgwqBndWFyZChkZXZpY2UpKGRldik7DQo+ID4gDQo+ID4gWW91IGhhdmUgYSB2
YWxpZCBkZXZpY2UgaGVyZSwgd2h5IGFyZSB5b3UgbG9ja2luZyBpdD/CoCBIb3cgY2FuIGl0IGdv
DQo+ID4gYXdheT/CoCBBbmQgaWYgaXQgY2FuLCBzaG91bGRuJ3QgeW91IGhhdmUgYSBsb2NhbCBs
b2NrIGZvciBpdCwgYW5kIG5vdA0KPiA+IGFidXNlIHRoZSBkcml2ZXIgY29yZSBsb2NrPw0KPiAN
Cj4gWWVzLCB0aGlzIGlzIGEgZHJpdmVyLWNvcmUgbG9jayBhYnVzZSB3cml0dGVuIGJ5IHNvbWVv
bmUgd2hvIHNob3VsZCBoYXZlDQo+IGtub3duIGJldHRlci4gQW5kIHllcywgYSBsb2NhbCBsb2Nr
IHRvIHByb3RlY3QgdGhlIGRheF9yZWdpb24gcmVzb3VyY2UNCj4gdHJlZSBzaG91bGQgcmVwbGFj
ZSB0aGlzLiBBIG5ldyByd3NlbSB0byBzeW5jaHJvbml6ZSBhbGwgbGlzdCB3YWxrcw0KPiBzZWVt
cyBhcHByb3ByaWF0ZS4NCg0KSSBzZWUgd2h5IF9hXyBsb2NrIGlzIG5lZWRlZCBib3RoIGhlcmUg
YW5kIGluIHNpemVfc2hvdygpIC0gdGhlIHNpemUNCmNhbGN1bGF0aW9ucyBkbyBhIHdhbGsgb3Zl
ciBkaXNjb250aWd1b3VzIHJhbmdlcywgYW5kIHdlIGRvbid0IHdhbnQgdGhlDQpkZXZpY2UgdG8g
Z2V0IHJlY29uZmlndXJlZCBpbiB0aGUgbWlkZGxlIG9mIHRoYXQuIEEgZGlmZmVyZW50IGxvY2Fs
DQpsb2NrIHNlZW1zIHJlYXNvbmFibGUgLSBob3dldmVyIGNhbiB0aGF0IGdvIGFzIGEgc2VwYXJh
dGUgY2xlYW51cCB0aGF0DQpzdGFuZHMgb24gaXRzIG93bj8NCg0KRm9yIHRoaXMgc2VyaWVzLCBJ
J2xsIGFkZCBhIGNsZWFudXAgdG8gcmVwbGFjZSB0aGUgc3ByaW50ZnMgd2l0aA0Kc3lzZnNfZW1p
dCgpLg0K

