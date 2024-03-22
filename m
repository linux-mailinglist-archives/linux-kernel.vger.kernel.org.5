Return-Path: <linux-kernel+bounces-111612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D417886E84
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 15:28:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 000091C21C1F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 14:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 911A54AED1;
	Fri, 22 Mar 2024 14:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DvBH3Ikn"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF5D481A0
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 14:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711117702; cv=fail; b=j1Y/FMgbMNrv4lv9sSw0xfmDd/T4CYnxoeqmpzQo9yIjubEAFNsSVNC5lyPix+2giYCYsWp2whvlVanoct86bX6Bj7RjcAI9mUWJOLm3JSQy9Nrc8F/zsTclbPD9U6z+C2My9dJltYAA1BE8DjtCENtk9OT7mXKlqPx6vxc3ygc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711117702; c=relaxed/simple;
	bh=x6F+7jGQaoiDVl4HSM9cVg7jrQdeUaC2Zfh/BfOeBo4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gThSmrKGaiiIvYy+1gCRghdKP6zVodE6jWA9y+XtdWiz67MypcUr1FbJoP5bxIaozLOVH7qi8OUnjaUBS/xC1SI/8MpRSs1e7lrRPeteY1M4lB/O4evGvwLzybn19IkbD4/Xfwqbvn4Q4IReQbbc5mOxuOKAmQweiRjjrPxYJU8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DvBH3Ikn; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711117700; x=1742653700;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=x6F+7jGQaoiDVl4HSM9cVg7jrQdeUaC2Zfh/BfOeBo4=;
  b=DvBH3Ikn2uAB1lXhmLvEScpWjHaDN0/NnQ0ONApl4ZOB9LsKRFh1ybqb
   3qD+E5y6gBQDImfqnOQZHpg7ilel7ucEXc/EmwCjs2ICIpN41/y1tb3JE
   IKgw7SIJWyJkMzxl72UhXvBbgburY++z18LiyerS+4N43eXcUJK0op+JU
   a6b9++q5z4MKBDAgpRX3BuQgwtvHeXsgN6k6OP9eFhLbC2ziKTy6/O/3v
   l7g1OXoQr0VLmFo3kyH2EBlNHJ0vrI4rZGTVFyT62PTFh/u+dgeF9ia7o
   ClDsnaHbCdH/DO0ut1XJDEKzDKV9+j2EQ9hZYSsYSIFuboliFp50/mA5T
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11020"; a="5996737"
X-IronPort-AV: E=Sophos;i="6.07,146,1708416000"; 
   d="scan'208";a="5996737"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2024 07:28:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,146,1708416000"; 
   d="scan'208";a="19642414"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Mar 2024 07:28:18 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 22 Mar 2024 07:28:17 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 22 Mar 2024 07:28:17 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 22 Mar 2024 07:28:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R76mcC80s/0aCEZ8NVesxNbNVvY/3ObMcRgmzjGTuTY4hXeaae6+zlEye3u5KxhtI7h/WoHcJ+SHle/h2oz+2Be32QQZJBxmpJhhCYpUhdjpMI7JeJO3J7lx4rNbhvXT4iZJEwJQH0eGyz3f3ap1/YvAjGQuzpY0E4s8OwiVKyGjLxXGQJDikjhlljPyirRhdC3o+A32lEPfaYvfwarD6zwbBorzRzzc0IPZiKZUilkSumw/A+0Eca91bCw1AjWwpN1nJ2SygAe4XrqOBqWVjgL4mtZyp7BUbJINyglZEESMAIcZkRTZAx4LAVJaPMALMocDdXJM0dOlh95o7lpjsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x6F+7jGQaoiDVl4HSM9cVg7jrQdeUaC2Zfh/BfOeBo4=;
 b=QDJlP1HSNLs81/aQf9LrKtzrAk4RJPo4jQSH5yM+vOsJQ3BHgiSN0xe5Mp5NFZEWjDrA22WlmgpFq4Fu6MzH65V9RH/FQ5x9GkmY4XgtczEgTJ2h2zYsnyApIy/Sc1vKq06+0ZYBNpdu8wPzipmu7+5kJZ8Wsm4sZ4/VCRde7GBUJ4TQufadESbrHWGug8CPioHRvueb9inBPJwW4rBCGpE8M/eYu4KIf9us76HcJlDvykmvrh07c2GvUEgnCfdi6uuBCsNeWSHaNb3ZD37XkOkJEpUJa6xMmyMwTGZ6oS1tUXUbyD2v46MSFElILABTT70cc8snUTD4C13Y0eiW2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by IA1PR11MB7809.namprd11.prod.outlook.com (2603:10b6:208:3f2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.24; Fri, 22 Mar
 2024 14:28:15 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::1761:33ae:729c:a795]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::1761:33ae:729c:a795%5]) with mapi id 15.20.7409.023; Fri, 22 Mar 2024
 14:28:15 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "hjl.tools@gmail.com" <hjl.tools@gmail.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH] x86/shstk: Enable shadow stack for x32
Thread-Topic: [PATCH] x86/shstk: Enable shadow stack for x32
Thread-Index: AQHaduH6Cs7bYZFPJUuH5QAqHlZq5rE42gyAgAAD8gCACvjHAIAABc8A
Date: Fri, 22 Mar 2024 14:28:15 +0000
Message-ID: <799ab2511ba1b4899610474da2dcec16983ec860.camel@intel.com>
References: <20240315140433.1966543-1-hjl.tools@gmail.com>
	 <5f0620c55a01d6a195154783a477ec295cbb4b1c.camel@intel.com>
	 <CAMe9rOrgAtQvA=Tj0=T095JmdoRZ8pLuNOY3sT_RwwnznJN2Ow@mail.gmail.com>
	 <7b341bef9c0cab324350873cab75b7e1313a5172.camel@intel.com>
In-Reply-To: <7b341bef9c0cab324350873cab75b7e1313a5172.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|IA1PR11MB7809:EE_
x-ms-office365-filtering-correlation-id: 5a9ff0e0-14d0-450b-bb0a-08dc4a7c4fff
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SJwhHN5Mn7r/aO2KBttu7pHJ/f86KcoUgM9HNtUUuEbTZLNo28LYQA0qwY9q2nV42IZTuqhntUhSVJ2xE59fsviaD5Z7NY42ztCTeTRMAoZuIi1Y3A8s4iLyicxjlFZJponNqVAttlOmj+8PTGnnVuBVQssqilNPBp8LYHYLciLNraOqcE2TVh4wo4GuFO0Px/Sp+mtLLLxOi/AjVylqt8H4KLTIiiD597LZoHemgVqfWHZ/LTQglBmjnNk6ZPKE9OpB5SCmkVAHcy7xdNdgVc70KR/FXif3eeDIJkFIbe7km6zOHlAxfyOa5Wh3Xqn1pmgFR8NlF0SW0mU5ffyfdcl69xHBeXaQkozNdEnhDROZ48gpN03br35nhWchbwkKrwbBeFbKAce1ILFA9ndOoMKidN13LzxxpbQB+C/l3z+TpjnnHpNbYJMfnzSC/K1GlzC8FE24iNfE1MYNvqeoKlrvEjJ4MX+pLisIKvHwsu9W5zF7jSGnOZlUraxCb/EHvOOuf7H8tUU1saULQWDMtwxY7Vb8XQsYaq0BfbNoCjCCdXR34dwTqn6nUdg0h4LWXLKWQkkOwW5VugBBw14JSFifsk4BqhFTN4Zia1ljKkFCJFD6LE6Ml912FZC7W3ovXcxqC9jFIwI67iFKBFdLhK2fs+yzWA+wO+StYTBfPJzpAtzllX0SsXB4qgHwDXSetHizEaDkPhwtNxynIbGt0g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NFA3aEtxQ09YWmY2VDl4dkphUmN1M2ZuUHlkVjZXczFZbElQcU5vak9EVU9W?=
 =?utf-8?B?YjV3TmlTcENlWlFIbmljQ1lvY2lWb2Exa0tkL3J4eURDU0M1UHI1TzZvY05y?=
 =?utf-8?B?QnVHWXdkVGlPMGkvSzdDbnFNQzY4TDJLWGFuK0xqaGlQbkF1RjJHWjRaZDBX?=
 =?utf-8?B?R0Y1T0pYZzJBeWNWMDVTNVVBUTl5Y1Naem00WXh0eTJzaldYUTBNRVk3T3k5?=
 =?utf-8?B?eHVZUXpVR3J0QWFKZERvMFc1QWlKZC96Z1Qwa2NHc0NvNHQxL1JuZ0hXWnpz?=
 =?utf-8?B?VUZyUnlzUXNHUHQ0QVh5cXZqc2JFaFdPU3RId0p6RTJCNjRGOUdiYk41UEJk?=
 =?utf-8?B?cWx2Yklsd2JFR2dLWUdQd0YrektFR0V1NTh5N0JXcTVUcUlKYkUyTWVxSnZQ?=
 =?utf-8?B?djMvNGtFcllKaUZHODVRQWJpaGxEQ29HOVViSjhYOTluTkJid21LTUU0U205?=
 =?utf-8?B?Q0ZwVGtralVQaTJNc0dzM29OeG9OQ2lWbUxPeGl2SmZ4MkhVYmsyazh2Z3lI?=
 =?utf-8?B?bDU1NmpNcElwaUhSYWh3cTBEVUsveFRDK01sTm5wdWFNeFp2NXdJWjliZk1U?=
 =?utf-8?B?d3NUOURKby9OYitZcnlzbGE4YS8xbUV1K25mSStaU1RhZDAzZFhRdnlZaGxW?=
 =?utf-8?B?dXNjaitTVE9zS1VTYVd4ZFF1bzNVU3NhNExkYVF4TWk5RWFIeitnZ0ZYYjZy?=
 =?utf-8?B?bmpsQVBjM2YvRUJDeDltcE9POTdZOGU3UG5xVmN1czVwUjQ2Q0g1WE5ITHdH?=
 =?utf-8?B?eTBYOG9zKzZkMWtRTGJyZTVZYUptZ0VOQUt0a3pPT1NFalc1eWxaNDlEd0xG?=
 =?utf-8?B?Vnl5VTlla2dCTjRoTmtOWWN1ZTVTblRPRkwyTmswQXlySzdkK2VHNm9YZWVM?=
 =?utf-8?B?Uk0xV3lLR2ZXczRDMkhqdkg2b09TcEE2dTNaNmIvTUxQR3pMbmNja3lNaDdB?=
 =?utf-8?B?QUprak04b2R0bUJPejhwcGpjTVVHRGEyWWtuRDdoWHM0eWl4YXpITC9KNjNa?=
 =?utf-8?B?N2JtbEZsODA3cGZCWnUxSnNwSTdtVlVNQzVlb1NvaUNKYWU4Zml2d2lCUlBz?=
 =?utf-8?B?bDJ0WXNhNkJTaXZydnZEck5nbVlMQkxFcWR3WGpsQnVPK2RQZ2pWVFZyM0w4?=
 =?utf-8?B?ZzJTTVhPVlR2QlprYTZuTXdObzZxZDVwQUh4SjBNR0JoMVJKK3lIUGUwUTVD?=
 =?utf-8?B?TDVFYjZlcU9wSk45b2FLdEFDNXZUZVkzOStPNmVpcXgxdTJzRWZid0lndlpE?=
 =?utf-8?B?aW9iclVhcjN1YXlHNlRGL3FwbW9vcEZiUGRBSmd1TWZsVjFPMi9VUndhakFQ?=
 =?utf-8?B?Ri9kWUgwMWxWbkVFa015dlIzSEpVSXZLbVdUY1JGYTR1U1FocHMvdlBSTlpF?=
 =?utf-8?B?YmdsME1TYW5ZUi9xZm1ZUHdETHB5ZnN0V0NJczd3SXpHZTVIOU5RenFLdCsx?=
 =?utf-8?B?RzJNTVBYWnhadXFRK0ZyaHRFRnlYTU5mYmt6V0pPbVMvalpKeDlNVFpkQWN4?=
 =?utf-8?B?QnB4cHlkeUx4VVJkQy9XZjU1L0dmQVUxaGM5N2plY3BmckpoS0t1NDBQeHhp?=
 =?utf-8?B?ZHltWFRlVStUSzZZR2k1UjlObVBoem1kc1RuZlNkeHdwd0w4dmlTR1NDUDFX?=
 =?utf-8?B?NkNFMCtkMjRkZFlzTWdtRFlEN3pWYXVSckFVT3RJRzNZK0NDdmhWczdmRUxj?=
 =?utf-8?B?N3JpWGJYNEYwcUlScEtmcWEzaGpmMWk1R1FuOG01RmdURDB2cExiNWM5NnZa?=
 =?utf-8?B?U3dVd0NuL01kQXJJdi95NXJqQmtja1FEQlQvdDdZMmJDTTI5TVoyQk5pR3FK?=
 =?utf-8?B?T3p3SU5MTnNRbkhzVlZEUHR2S1RIUFNsTnl0VEt2bXlhWDZKcDRUK0JJVTNM?=
 =?utf-8?B?REtjdHBRcThVZ1FLSk15YXQrUmFLeFNJWXZCVW1vTTQrRjNGOXJxSEVGNlY0?=
 =?utf-8?B?K2FsRWVvQ0hmLzcxMjJqK0JPV0FSeTRMNU5GWXFucHk2djlnUmZvdldEN1Ey?=
 =?utf-8?B?RXlUaExWcXJPZXFmNExUd3RPbVM0R0ZRQkl4bHIwSEpRRGJQMGQvZVZOYUha?=
 =?utf-8?B?b2tJL1ROaGxBOWJvRTFWOWl6NUpoT2JIQUZHcXZYdExRV1JzZmdJVnFyZXVo?=
 =?utf-8?B?YjdxT3VBVmVtd3lSWTBqSzRYTjVxQUVkZi90Uk15emhUYVdQSU91aDBTYy9t?=
 =?utf-8?Q?Zi5boIO6tDlL7bcy4NVwoSo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1094527ECAC5F947A948C544CF8126EB@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a9ff0e0-14d0-450b-bb0a-08dc4a7c4fff
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2024 14:28:15.7947
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tFcc1h6x03ZcKPwpCR14aC0/Re9Vj8gJoE1XKc4ejAG7LWGgpHHgv9VdonviFhLEB3wBpt4Rn8SeDPM3fSxt7YDmlJqelSctaYu6rgJtKm4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7809
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI0LTAzLTIyIGF0IDA3OjA3IC0wNzAwLCBSaWNrIEVkZ2Vjb21iZSB3cm90ZToN
Cj4gT24gRnJpLCAyMDI0LTAzLTE1IGF0IDA3OjM0IC0wNzAwLCBILkouIEx1IHdyb3RlOg0KPiA+
ID4gSG93IG1hbnkgcGVvcGxlIGRvIHlvdSB0aGluayB3aWxsIHVzZSB0aGlzPw0KPiANCj4gSSdt
IGNvbmNlcm5lZCB0aGF0IHRoZSBvbmx5IHVzZSBvZiB0aGlzIHdpbGwgZXZlciBiZSBleGVyY2lz
ZSB2aWEgdGhlDQo+IGdsaWJjIHVuaXQgdGVzdHMsIGJ1dCB3aWxsIHN0aWxsIHJlcXVpcmUgd29y
ayB0byBzdXBwb3J0Lg0KDQpUbyBlbGFib3JhdGUgbW9yZSBvbiB0aGlzLi4uIFRoZSBtYWluIHVz
YWdlIG9mIHNoYWRvdyBzdGFjayBpcw0Kc2VjdXJpdHksIGFuZCBjb21lcyB3aXRoIHNvbWUgb3Zl
cmhlYWQuIElJVUMgdGhlIG1haW4gdXNhZ2Ugb2YgeDMyIGlzDQpwZXJmb3JtYW5jZSBiZW5jaG1h
cmtpbmcgdHlwZSBzdHVmZi4gV2h5IHdvdWxkIHNvbWVvbmUgd2FudCB0byB1c2UNCnNoYWRvdyBz
dGFjayBhbmQgeDMyIHRvZ2V0aGVyPw0KDQo+IA0KPiA+ID4gDQo+ID4gPiBJIHdvdWxkIGhhdmUg
dGhvdWdodCBpdCB3b3VsZCByZXF1aXJlIG1vcmUgY2hhbmdlcyBmb3IgYmFzaWMgeDMyDQo+ID4g
DQo+ID4gVGhpcyBpcyBhbGwgbmVlZGVkLg0KPiA+IA0KPiA+ID4gb3BlcmF0aW9uLiBXaGF0IHdh
cyB0aGUgdGVzdGluZyBleGFjdGx5Pw0KPiA+IA0KPiA+IEkgY29uZmlndXJlZCB4MzIgZ2xpYmMg
d2l0aCAtLWVuYWJsZS1jZXQsIGJ1aWxkIGdsaWJjIGFuZA0KPiA+IHJ1biBhbGwgZ2xpYmMgdGVz
dHMgd2l0aCBzaGFkb3cgc3RhY2sgZW5hYmxlZC7CoCBUaGVyZSBhcmUNCj4gPiBubyByZWdyZXNz
aW9ucy7CoCBJIHZlcmlmaWVkIHRoYXQgc2hhZG93IHN0YWNrIGlzIGVuYWJsZWQNCj4gPiB2aWEg
L3Byb2MvcGlkL3N0YXR1cy4NCj4gDQo+IFRoZSBzaGFkb3cgc3RhY2sgaXMgc3VwcG9zZWQgdG8g
YmUgbWFwcGVkIGFib3ZlIDRHLCBzbyBob3cgaXMgdGhpcw0KPiBzdXBwb3NlZCB0byB3b3JrIGZv
ciB4MzI/DQoNCg==

