Return-Path: <linux-kernel+bounces-60041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B99784FF03
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 22:37:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D178DB28746
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 21:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4683229405;
	Fri,  9 Feb 2024 21:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LgOIWmao"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E94210E7;
	Fri,  9 Feb 2024 21:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707514590; cv=fail; b=jomC9obI5BR1e5HKNEEYTOpfCCbFJYhfhnRDVCwJSAvrLT1Z4bdkde0W0DunODiRHgny5DD2IhMstx1DccF1yiZOPidX1uPCuMEbo2QNkyBYkxv2aClDjbbfV/e6rVeCba5nkGrC2kF8nhgwD7y85bTbRYcK4e+lR5YdHuCR1mw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707514590; c=relaxed/simple;
	bh=jfBHv03fJ8VOIcDMQ/1gtRDf/V/IhP0i/von7N6OYqE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sYz0jJSF2uuSRM+5i4kZNQ1GzwGEc5GW9pBQpYO2zQZYe+q95shdvQ3AnP18ejN7A7xNhJQZj6FTkQ3j5ZSKrPh5cAcmx8iEapfFPv7jY5FnPYzk5w3CAXkZY/3SrHPtKVB6qMMc/RdFMKfXtMXEpH9diS4+addXOp1hwHVZf3E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LgOIWmao; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707514589; x=1739050589;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=jfBHv03fJ8VOIcDMQ/1gtRDf/V/IhP0i/von7N6OYqE=;
  b=LgOIWmaoIuctSf+shOy2rSwKFTUrV0rSYy1YvLXoELANpztJLzRZuUur
   +HtyouZr8wiNbZ8cTyVpC4u3ypCE2/l6Mw1m3Ht+yNkfSswVuFE+WlI1M
   nXiAgEtZMCh0l0MPcsawZjPGM+mBz7hc8E7Iuij6JUqJzfedsqjrL2H0a
   bEbLxDp/g0N5HWt2WVy201Jsu9aTxuF/T0+4ThuCegmjiJK5mOn7TpOJ4
   1c7SqA34eMb2n3C2Ae57uLDXJk4ZYPQapYe1Fr8f6YFg9ZaWTpmicWShN
   77U/STZRFNksyryf2Vbz2L563RKcn101irNjTCstLGDU49eX88MtScEaC
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10979"; a="19009989"
X-IronPort-AV: E=Sophos;i="6.05,257,1701158400"; 
   d="scan'208";a="19009989"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2024 13:36:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,257,1701158400"; 
   d="scan'208";a="2026991"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Feb 2024 13:36:28 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 9 Feb 2024 13:36:27 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 9 Feb 2024 13:36:27 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 9 Feb 2024 13:36:27 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TcWoSY41jM9nZnl5ksGzxLR7woa0KTtsiSgfieoxf5z9ExDxA7jxmZWuKpSVY/jdkrQbob8j/n8mjZ2iTGsV4Tu9CY8dkcRRKjgYlrP+XYDUlGAwvbIOdkcbAKRpddFlqUPBH48Gs7n3kaJqqJFpHfXkOflvezizdSyTPspV1U3gdKKFZ5ZSRQMyUKVDcySTRsgifJJ+L9fdGgs4m2eoEuEpAKMZslcwtH8G3UgeEGjdfv2QfC9hOk6BKJqmWqE6sRt3oIZirMI5kaBeUBZnqk5IK9rJ4HuIkN7bBziE+90i395Z03S4hrk4Nuo1ZT5fv6P4B3piTelK627ObPtI5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jfBHv03fJ8VOIcDMQ/1gtRDf/V/IhP0i/von7N6OYqE=;
 b=JU1KGTrqECYMLFxYDSo/SDs86XJLVT/NCKgMpLrnZ40zWM1WacOVZyXzUEjKMy1QSWy/fgx8r/1f6lEZXAw7sUY1eeLLdS0hkoaoMnTdDApq8MVWagkrz0/N0x/kOvXs0DsnN7sDIwv5Itxw5bQeVofYCIKLHdl25uMN7Xhl0yU9YtKIDOAiWudKmkuEIckw3yaCvSk95L4fsXGupJTRfgpSOzE5mJsPl6BvVjUzjONcPF6ZsAkfDpwf0CjpREfRknZkzmpUUveOkYUBc3eJ3h4tzoSCao2lw3CBwNhK4kjUDl/R+fGIukHnkdkKVltWe16qvrSvl1jqisQDvvQHTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by LV3PR11MB8673.namprd11.prod.outlook.com (2603:10b6:408:21c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.38; Fri, 9 Feb
 2024 21:36:25 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::7103:9cf7:fcc0:e802]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::7103:9cf7:fcc0:e802%3]) with mapi id 15.20.7249.035; Fri, 9 Feb 2024
 21:36:25 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: "Chatre, Reinette" <reinette.chatre@intel.com>, "babu.moger@amd.com"
	<babu.moger@amd.com>
CC: "Yu, Fenghua" <fenghua.yu@intel.com>, Peter Newman
	<peternewman@google.com>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
	<skhan@linuxfoundation.org>, "x86@kernel.org" <x86@kernel.org>, Shaopeng Tan
	<tan.shaopeng@fujitsu.com>, James Morse <james.morse@arm.com>, Jamie Iles
	<quic_jiles@quicinc.com>, Randy Dunlap <rdunlap@infradead.org>, Drew Fustini
	<dfustini@baylibre.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "patches@lists.linux.dev"
	<patches@lists.linux.dev>
Subject: RE: [PATCH v15-RFC 0/8] Add support for Sub-NUMA cluster (SNC)
 systems
Thread-Topic: [PATCH v15-RFC 0/8] Add support for Sub-NUMA cluster (SNC)
 systems
Thread-Index: AQHaU8qTZyE779HfV0Os6ryGu61IgLECMYcAgABGHaKAAB4egIAAAUhg
Date: Fri, 9 Feb 2024 21:36:25 +0000
Message-ID: <SJ1PR11MB6083D539920A888F93902954FC4B2@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20240126223837.21835-1-tony.luck@intel.com>
 <20240130222034.37181-1-tony.luck@intel.com>
 <91bd281e-e21f-4b60-9e73-2f14fcbec316@amd.com>
 <ZcZvguSNel-z3Xe5@agluck-desk3>
 <f4d4ff97-7d40-4915-943a-a7371e24dae5@amd.com>
 <65e1d936-0e1d-4d6c-81de-0b2b1d3256fd@intel.com>
In-Reply-To: <65e1d936-0e1d-4d6c-81de-0b2b1d3256fd@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|LV3PR11MB8673:EE_
x-ms-office365-filtering-correlation-id: cd125bce-9414-4feb-47d2-08dc29b72ab3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YaAKndfYY9QmnsN0j5aBRiAmIE0cnucEI2YGejQnXwTh5P6UqjndG5DBf1sYXDRJu0ZjOjJvJmZbEfozg1PjjSLvGHY/H5WnsXgebgKDDezMFQ9XrNYk9YLrydIu+LDEXRWI3JUsXLqhjCAJTI3qhBzy2e+sDKk3l2kfWG3YOdFgLR19kkuuvWef6Xj1eUE8k3vHZ3vW3DVt7cA+CnujgEB8l7+Lwvtim2jzpVmZMyu2rUunXXTGfjvLl4fHm39dWvlchqo/3raFESeiBvKcdrVKTUSlkt18p7pqz3RNgjNU4yOGhudqKD4bjuTPJvqaQuX1tPWu8dhistM3Dq2iu9paTosC89BHZTdBoyswb5BSBGJ3Ka41rDs4Gf69emfWMoxUTBm5xxKI+MVAloVpkIIdRiYZ5Y9aQ/YUToYFYerTpSzeG6nPRXrI1ib9ZNCP0NGTgvFvKqtmdW7gRD6qDEchQD1VgH6qu2Y6jCqnxY8rKy/vwl5DmVo+Gfccc4eh2Z9CC9d5CsKJOyjU+T6bUWvp6zp7rQbJaV7yiOOL0dGomT0HCV9Cr0ool3Foj6aF0lOD8WJ4awwSrmntpZzumgjZ/4FLNdgIoxrRFR+7PzH4hjgFW+hc4EkiIY6fAIW5
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(39860400002)(366004)(376002)(136003)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(478600001)(9686003)(55016003)(41300700001)(7416002)(5660300002)(4326008)(8676002)(8936002)(4744005)(52536014)(2906002)(66446008)(76116006)(66556008)(66946007)(110136005)(38070700009)(6506007)(7696005)(71200400001)(66476007)(64756008)(54906003)(316002)(83380400001)(122000001)(82960400001)(86362001)(26005)(38100700002)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NzF6clMvUnpnMzdBRUtxL0xML1FDL21obi9iMWpoNEFlM1dqb1RzRXBBdkhN?=
 =?utf-8?B?cFRzeG5PUDdRNldvY21MdHR1VVVPVGp2eTMzWmcvS2xCZzdoMFc2NXZCNEVC?=
 =?utf-8?B?K3JZNjZ2dk83MkczU3A3RzJ6TDBaTm9QM0Z3clN6SCtEd3RCcGhDS3JFQU9i?=
 =?utf-8?B?TTV5WlVRaXYyUEJSUncrRzBDc0RHYk1UOTU4Ykw4bTJ2b0J3TnlEWFF6SUtD?=
 =?utf-8?B?NkdNZlNsUlRwRVdKZ3lOSlBPYVppdVFrUU1TWVNHQkdLVzdFamd1OFBwVEEr?=
 =?utf-8?B?R2NFYmZSNG5vYjRLbmpqclhnVHN6MGtVUXdWRi9xV0RqK3lZaytNenVRQm5X?=
 =?utf-8?B?VmRHRXpqRllXaDllT2hhYXpndjQ3VStuS21oRzlSRHk1ZENYRG0rM1dBdEFu?=
 =?utf-8?B?Vno5VkJUV3prNHErRVBUNGNZVE9FVC9MUmdyVHVsRG1KNUdTYUFESGNacjBn?=
 =?utf-8?B?ZkdqRVJ6MUhQL0lUaUpxUUo5TkZ2QTEzZGFxWnRFcU9SR0oxRml6ZjVkMnZV?=
 =?utf-8?B?aXg2bmhncmhEUkpkK1NQK2VkTUgzL3ptdlM3cHVCTjh1MWlIbUJ5eWpHZDRn?=
 =?utf-8?B?cEwzdWZYRU1aYUxGbzZIQVE4RXNCRVNkYWJaMEtONXZONDNOdm9ucitvT3Z1?=
 =?utf-8?B?eDBBMHZjN1FWMjZEYkZueE1PMGxsd04vQysvRzJTMkNsbmVETzZaQlVoUHR2?=
 =?utf-8?B?aGF0NWZnNmppaDEzbmoveU5qOUs2aHZ1MUFsTU13cjhBUENpbDRiL2pyMmJm?=
 =?utf-8?B?OTdDZWFrOEVWcVJ5NVFlWkVjOEgvQ0dyb0xqRzJMem85UjN6SnVNQzlPQXg5?=
 =?utf-8?B?cXRMOUNLdk9BMStsYUFQdjM3N0RiamNCZVZTbEozcFhpSE5HVG9aUm5DOXdE?=
 =?utf-8?B?cEVPSkVBbGliN01DaUtvZEI1cTJ2c1RYWkJCeGRYMDZSMTZWL0Vtck5keE1U?=
 =?utf-8?B?UUVLWXNIektudytGejlHQjdKVkxVV3hGeS9DWHVUdGRyaThzYlNNZjFRb0xy?=
 =?utf-8?B?MEMzejNTc0pvMTd4Rmp1SzRJb0p0M0RpL1hmTGJGOFlPZmdHQXdtYi9MOFR3?=
 =?utf-8?B?UFVjK0pyS3NwazJYeG9MS3JjUXZRUjRhNjR4MlVlU1VWWXI3eUFubVZCQnJ5?=
 =?utf-8?B?ampZZmpPc2tpUGZmV0xZN2prS0lUeWdocXVVRmVxaWtLeWQvV3Q1UXhkL3Qx?=
 =?utf-8?B?d0swWFhpV09jdDE3REhPeHJHbkJxdFErWmRGckswMWl2aWc1MHp1L2duU3Uy?=
 =?utf-8?B?MTlxYU1LMjcvZFh2NFZrWjFWdVNNam8ybDVxWnlrTFB4Z003ZmVhT3VuRmdZ?=
 =?utf-8?B?eG1LbFVUSkFBL1pNVTRQcFNla3cwaW9QWnJSbEg3cERKNGc1Y2QvZkhzTzEz?=
 =?utf-8?B?eWhNZFd3ZkdPSmYyKzVuRStBSGtVZ0o0VUZNVTFhVGRuM2Q4UVVCQjN6VG9Q?=
 =?utf-8?B?WGtxUkJwSTl2c2M5VGNyS3JTRWNvUy9UdkVxTjlCcUVYM2RGTmRXOVBVbDJ5?=
 =?utf-8?B?Tmg3aDFmN0tSV1RHVHBueVBrb1Q5OFJaZG9WUlZjL3hRUmhSR1hpczRjb1dZ?=
 =?utf-8?B?Y1laUFlZYUYzeE90SnBlOGx3LzNXc3Yzd085V2hDbkNuWEVuUVlFU0xzSmlo?=
 =?utf-8?B?Q1EwZTFZSTR1ZFl6ODBhUnBTM0lyZW1OL3F0R3hkTTdiNHVKTzlyWm5Cclk0?=
 =?utf-8?B?ZXNYZzVpR0FHbU5TLysyUmwyQlF6bmY3dzU1VjRBQkl6Y05jWGFRalpuOE10?=
 =?utf-8?B?TlpDY1FlYS9vYW9yQjBPZ2dlWWpBengwdk9iZHdUbUQ0eEhBTENKamFVbUdK?=
 =?utf-8?B?SXNoYmwxenZnOWtMRUtQOW5aei9tamxETTRPcTJtSEs2SlVJQXAvRFl3Q2I3?=
 =?utf-8?B?MDRUcENjSlJSSytWVlQycllMdXBPOHg0ZnpiRTc1YnkxMkE1bkx6c2V4ZFFQ?=
 =?utf-8?B?YVc0R1hkajAzRTZtT2RpcGdEbnRTcWpNd2N1MmRacTlwRnE5SzF1ZVFPRE4v?=
 =?utf-8?B?OE4vQ1YzUXpUTlc4UVhraWhRMVZ2enhvTEdEelF0cVNiOVpTeTlhazM2TFkr?=
 =?utf-8?B?MGNZZHhWSnc0VXdVZEh2cC9zMVU4dkZwRS9ZQkdES1NISjVwSFRzbXN6SUZG?=
 =?utf-8?Q?gUlojnEmG2DgVwZKC+6Jb3niF?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd125bce-9414-4feb-47d2-08dc29b72ab3
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2024 21:36:25.1359
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5ncDCL7CmmMOhR1RJnDjeHjLtn3HfAfuZ6eStvyBfg1iyNel4Ft1ONkQEqVLlgBNxaF+NZunMmKazCqtswlZYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8673
X-OriginatorOrg: intel.com

Pj4gUmVpbmV0dGUgc2VlbSB0byBoYXZlIHNvbWUgY29uY2VybnMgYWJvdXQgdGhpcyBzZXJpZXMu
IEJ1dCwgSSBhbSBmaW5lIHdpdGgNCj4+IGJvdGggdGhlc2UgYXBwcm9hY2hlcy4gSSBmZWVsIHRo
aXMgaXMgbW9yZSBjbGVhbiBhcHByb2FjaC4NCj4NCj4gSSBxdWVzdGlvbmVkIHRoZSBtb3RpdmF0
aW9uIGJ1dCBuZXZlciByZWNlaXZlZCBhIHJlc3BvbnNlLiANCg0KUmVpbmV0dGUsDQoNClNvcnJ5
LiBNeSBtb3RpdmF0aW9uIHdhcyB0byByZWR1Y2UgdGhlIGFtb3VudCBvZiBjb2RlIGNodXJuIHRo
YXQNCndhcyBkb25lIGluIHRoZSBieSB0aGUgcHJldmlvdXMgaW5jYXJuYXRpb24uDQoNCiAgIDkg
ZmlsZXMgY2hhbmdlZCwgNjI5IGluc2VydGlvbnMoKyksIDI4MiBkZWxldGlvbnMoLSkNCg0KVmFz
dCBhbW91bnRzIG9mIHRoYXQganVzdCBhZGRlZCAiX21vbiIgb3IgIl9jdHJsIiB0byBzdHJ1Y3R1
cmUNCm9yIHZhcmlhYmxlIG5hbWVzLg0KDQotVG9ueQ0K

