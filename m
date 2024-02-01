Return-Path: <linux-kernel+bounces-47652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87D1B8450C1
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 06:35:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6FF6B22854
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 05:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A0375F860;
	Thu,  1 Feb 2024 05:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D27ri2Eq"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E06B45F85B;
	Thu,  1 Feb 2024 05:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706765710; cv=fail; b=c1xUt/wInzBFlpsvGUciJSx1USSQUbQS9VdOs/KPMbeVuXmyC7tlT5f+tqpTtOGiHN0I7vElWLtMiVGXBOR0t9AiOd6tPlPPryvv2DjsL+6Pi+mz/zjybubLpOajTHaMO+E8AYJVyK4Dx5wtG+GlIwFMYfa1X5MAI+ggXsJGAIQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706765710; c=relaxed/simple;
	bh=dMPfnmgeNsTxoWzvQo4TwvMuo9B3P5AKtKbWn96+NwM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oGCIpqfVIOdt9anIvDbO9t2cZxNFnoSj2e9kDHZVjob1hgqn/Lgzl7QNnA8na3Lf775XGonl7vKXn+gWtjyTm/53RcrYCE9u7KVxlMlRBctUlfM43bDnhF9f8abpQPWIc8ocbBn8MU7SO84HTv1DFIcXX9N0tphaJCmYUKZDpWg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D27ri2Eq; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706765709; x=1738301709;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=dMPfnmgeNsTxoWzvQo4TwvMuo9B3P5AKtKbWn96+NwM=;
  b=D27ri2Eqfted9ztQaS0xGKieo+VZ79dK4khP96bnhX38rGuhBKLUbjK/
   nvrJ5bG7OCcc6EtjlpejTol/F397qRo6CGKU7YFHbW4a+Tx/DkxM2hU0O
   yevoufRBruNiGaW4J39kL8//ntQIwXzb/+JYrVNjjHvmV7NuPS2zFkt/r
   J24Js0dMVAVM344zd/46Xqh3NTDlkjigOpcnWRajA87wVn3h+vgKQdppi
   jprh3U9BElrrgznuYGb76juvAvzW1ov3pp7ln2B+fMf0vxP8PHGlkP+W4
   LJfrZyqL4bOeebG0MLViWUrqnGMUXoQtOhw1VuFY4xBsFUly+z1bPq7U5
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="22316441"
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="22316441"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 21:35:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="4329267"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 31 Jan 2024 21:35:08 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 31 Jan 2024 21:35:07 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 31 Jan 2024 21:35:06 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 31 Jan 2024 21:35:06 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 31 Jan 2024 21:35:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P8HjmihVBw6PRCuX3yPMXn4rCT+sv3QCF0aA4lkIOqVXSDjW7Be3JrgQHzE4JvZ0DX0PCW9drEUsgcnsxisDXKLjSzsJSlrocrT92pZ4+zSkyINSV6JAs4J8H8yPA9EmsVZ3B25eDFkVdFPGwxHSPNsi2J1rYpk4SfbKIyPCzKwpxEioVnGKSjazUvgBV0SH4R7omFPQPwwRcyHnASEYdWrOQeAPYjf1Sw/CkP7TwCme9MxiNotNcehsHwo0vElXU/S4QNpCUxmtZ1e9oF7RCc+12nd//wMN8BzjOCiodikum7Y3zbwNma1Ye2dSbXp73/pbMOlHCNqPZ4DtLhBCEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dMPfnmgeNsTxoWzvQo4TwvMuo9B3P5AKtKbWn96+NwM=;
 b=MLZvedfSA8HMOVBQdBrU5QasD9aL5GfWR8CIMXwZ2a/UqkZSlh/4jQGACdzxCok7sAB7fdgE7ugNXn2BKcHX5Vv5Nlfa0wI3XELOQrES29gMVzqsuJh8iDQGXuKDT3Skf7/SDu5M/OOoRpTn0gIFyR5fJEDpYn3U8oBooe6jC2cb4FxMqettG5DNu1nv3BMKfXIxRdvx1CwjIBzLzUdZFy4QiZIPghIf9k7zUlsVP9a1mggRmLUNOSn1El8gaqIhQBNcCiCtPAy8G3kzJEW8f1YFakwvLeBeJbMtP+YGb4bv6pRiojyqRYvTx6BlmB2DrUw2VPaMEtSJyAwn0bEUzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com (2603:10b6:a03:478::6)
 by DM4PR11MB6357.namprd11.prod.outlook.com (2603:10b6:8:b5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.33; Thu, 1 Feb
 2024 05:35:04 +0000
Received: from SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::1962:31ea:5a9e:6102]) by SJ0PR11MB6622.namprd11.prod.outlook.com
 ([fe80::1962:31ea:5a9e:6102%4]) with mapi id 15.20.7228.029; Thu, 1 Feb 2024
 05:35:04 +0000
From: "Zhang, Rui" <rui.zhang@intel.com>
To: "rafael@kernel.org" <rafael@kernel.org>
CC: "peterz@infradead.org" <peterz@infradead.org>, "mingo@redhat.com"
	<mingo@redhat.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"kan.liang@linux.intel.com" <kan.liang@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>
Subject: Re: [PATCH 0/5] intel_rapl & perf rapl: combine PMU support
Thread-Topic: [PATCH 0/5] intel_rapl & perf rapl: combine PMU support
Thread-Index: AQHaVFEo6ezcF4MNmECPeAYkGA7FA7Dz/jWAgAD554A=
Date: Thu, 1 Feb 2024 05:35:04 +0000
Message-ID: <0b326053b1a91d0325cd6907bab784e8f9a8cadb.camel@intel.com>
References: <20240131142335.84218-1-rui.zhang@intel.com>
	 <CAJZ5v0ioEx7xSagqeuByqTqefgenZnccrXX1nGBJib72O2qjJA@mail.gmail.com>
In-Reply-To: <CAJZ5v0ioEx7xSagqeuByqTqefgenZnccrXX1nGBJib72O2qjJA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6622:EE_|DM4PR11MB6357:EE_
x-ms-office365-filtering-correlation-id: c50549fe-2b5b-4cba-5bf5-08dc22e78b32
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7b6mVH/ClfljrwllIsz5FKLaKyO3EmuROCWlMnWka7PadlKzXhkTl0h2gtk2XuxkpWhMLAQfJ/Rtd3gfB2E4Sy7/daV5gBq9y/Ew3EXxIXLOybRBsmMQEJFXikIUPu1r9T6HdCjIVT2nd3J5j3ocNHcVpIOC6xqlBrvp0iipjmTsoQEoGAktfNUZ16HcmHmKd+yAVU0w3VFKDp9sqXZOO2A6/50vO7eDa8jlF0Ne3r6661tjNIJ9S3nP0lAU5n7BoQxMiiUFzOKW9RjiYhAd3PoMYKIxg+z3Azal70/QvZCmelI4PuzAsI4BOc2OtFQEIj96YssooDNMH6nI0mkFgii60gxXwWtMasW4e7k3Ya0oR16lXVjinchNu8Iqrn8bvo2D0x9MlDui1fYAaoBqLrSCWSuGB92MvHNmJVfkz1lkDJAbEdiOqccS1tMOwyZ58g8VpPsArVsHJhdd9yFHcQ/WwmSQcn69Yjzv1vksG/mgTz1Mb3njPVKxLEyAtGLIirhlCBQIPRMquQvSqc4seRHb+YAORhhMxF0rmIxMvKEPLv6YfJXJyX8Mf2W7K9U25LsuBE59RHlpYFD+Zcu55z0YVYU792L3t4YA7jSeo/w=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6622.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(346002)(376002)(39860400002)(366004)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(316002)(82960400001)(66476007)(66946007)(6916009)(66446008)(64756008)(66556008)(122000001)(2906002)(54906003)(4326008)(8676002)(8936002)(36756003)(6512007)(38070700009)(86362001)(76116006)(91956017)(5660300002)(38100700002)(26005)(2616005)(71200400001)(66899024)(6486002)(966005)(6506007)(41300700001)(53546011)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dlpKc3h6WFZiUDVkencwK2ExU25VN3ZSUEhwZW1namc2RDRBNmtCUVJNWG5h?=
 =?utf-8?B?bkhVVkU4WEFLWlRzbzBiZlY2TlZYNURuZFdRSVZlczNoYXJFL09CdHhOMDdW?=
 =?utf-8?B?OXZoYU9xUEc5RzFWYzlrZ0tpL3RFLzZQdEFDeGdGTFcydW9NN0hOalliT3lU?=
 =?utf-8?B?ZTdsYzRtZklZeEczZktaSlRuZXF3UlYyT3doZ0tWMEhGYmVEbE11WGdHUldk?=
 =?utf-8?B?TG1TWTRHS1l0enhTanZHNVJaN2ZPRHdQSjg2aHZzSXljWW1oZXpwZHdHclNs?=
 =?utf-8?B?WDIwZjFUM1g0RzNqZDNBQzlYbVNlem5CU2tqekYrQkFIbDB1S3VGU0pRbUxE?=
 =?utf-8?B?QTd6YUFnQWlXREZyZWcrMnNqR1lnSW9maWxyeFdsYmhrOXR2dUwxT3dGVG1K?=
 =?utf-8?B?UUU1S2IvS05QTldaem9YZTNhQTNNNERGOElFSE8waTd1czlqcWhHSENpU3Az?=
 =?utf-8?B?VzVKamV4V3ZFdnVVcm5kTVZwdXprc1orZmZJZlRVTnlteXVYOUVFWEM3dERk?=
 =?utf-8?B?akJjRHU4VDBzaWRSUmdTd2IrRHhKU1ZIZHJXZGxBa01JWUxqeHFPM24rSXB1?=
 =?utf-8?B?L1A4UWtyODFKc3NnaWpjQUs1ZDg2d21GNGk3QVI1eVJDb2kwQ0F0YzJSbEIr?=
 =?utf-8?B?cStIZnhQK2hNVzhNc2VlQVU3NnpWTmFRMUtEbnFrL0hpZzk1VWhHWEZvK0p6?=
 =?utf-8?B?TEEwdCs2aGtSd0h1MjFwL3oyT1Fwb0JBeUJnRHZHRzNjOXlEUHpqYXdVVndn?=
 =?utf-8?B?Mm40enFueDBEcXRxMzNaNk1HaWQzWUhBZEV2YWQwMEU3YnRzQzR6cnJIYjVE?=
 =?utf-8?B?V3NJaTcvTkNTdWN5Uk1rSzYxb0lFdC9NUitTTG9mU3ljaFVyM1llQ3pBMlZU?=
 =?utf-8?B?NWpGZDFGQWlTYmM3WDVwbjB4ZFFUNzNtbVlJVXhRMHJNTjdLc3d6TkxOY0ZN?=
 =?utf-8?B?YmxiRXd5azd3Tks0VW1LRHdTLzlWSmlsMGlwaE5EaTNBbkpOVXRpWUtYN1Rw?=
 =?utf-8?B?WlZoam9oTUdzWmxoQVdKSUNRTGdPdHo4cFNMazAvclYrN0h5dENYV0duSkw1?=
 =?utf-8?B?VVRMSmNqdkxuY3pwVXFJQktOdXpSZEUvQjUvMmlxS25HVmU0aStMZFo0b2M3?=
 =?utf-8?B?N09zR25BRWtqaGhGcWFuTzVLNmEyeW56Q1lQVVViemFva3NhUU5TazlwalBE?=
 =?utf-8?B?KzJueEFWYWJydC93ODNHNXlsdm12VkdPR1hVV0FqTFlRZXFkVys4SFVDeUZX?=
 =?utf-8?B?UElNdi9nUnliMkw4b0lmZkE3MjV4SWpHK1JDL1RxdWIwbHI3ODJ5ZzRhTGRx?=
 =?utf-8?B?T0haZVRENHJ2MEhnVEY0VFExRVpLemFtL2x3RDU0emFwbWE2V1BtWXh6djB4?=
 =?utf-8?B?aDhKdG04c0NpSU1QQzlMUFV5M3diMFRNSWtZZnU5bmlmQjVMS0NHM3VFSVgv?=
 =?utf-8?B?cUJnRHBJbVJLU3dtWDNsdXlCbWh5Rkk0ejVjQ0pLZER3YVBOYjc2RHJPT1ZD?=
 =?utf-8?B?RUhjSktkdVdteC9zeFZJdWl0QnFXNElUK0Z1dExtc0pSVEllcmtlMFNoNjFx?=
 =?utf-8?B?Tm55UnRlMVlHVEo3andZazFDdlVyd2l3QXlhUDA3enpWTEdycCtsUitkRytN?=
 =?utf-8?B?cnRmSm1reEZkTEcybDIvL2lPRUtoNTNhcWVGUjVod2gwbFJxRkozbmVJWkdk?=
 =?utf-8?B?eFRPQldDU0JLVkcxWXJaa1N0aW5SRVFaV3E1MXMxejBGcGx3Y1pGdXJNekxu?=
 =?utf-8?B?QlBPbTVNMmVVRHlWM2tCQm11b29CNkxuMWdDcXY3OCttOFhPUm1XT3NFRTla?=
 =?utf-8?B?WGZIZUhuV25EVU56c0VxNExPWGp6UjJ6ZDNvTDR5SUd0TEt4T0kyVlVNM1VW?=
 =?utf-8?B?cDlBTnk1MHN6MUdJMVdMTFdkVHBiRjY0UzVUWW9RMU9qU2JGS2Fzd2NEQm1j?=
 =?utf-8?B?UWRDaGh6YlZtc1kzbzJ5T3dRTXNmNGJEd2l0Qjl4bWxPVGxKSWp0WFpLTGJq?=
 =?utf-8?B?Ukw4R1pGSUxFWjJoRnljaCtoN0RTZ0YwWm1jNEYveHZHc3kyVjZJaGJxZVMw?=
 =?utf-8?B?Q3lpcDBqZVU0RHBnczYxbTJtVHdlSzZMRC9KcmFuME1nRi9jclFpWk5tSnVK?=
 =?utf-8?Q?xNDXdExg2sheADYR9eS60WTO5?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DE22CC5266E41347BF4D794519183A23@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6622.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c50549fe-2b5b-4cba-5bf5-08dc22e78b32
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2024 05:35:04.7273
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XUWglwzYay0pzA0kEhoo4G/iRmtF2Dk7wcpvthXcUrizddRUt6+78J4JT+hu+ykFmuoZ2Oro+LXsiGXeSX+RjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6357
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI0LTAxLTMxIGF0IDE1OjQwICswMTAwLCBSYWZhZWwgSi4gV3lzb2NraSB3cm90
ZToNCj4gT24gV2VkLCBKYW4gMzEsIDIwMjQgYXQgMzoyNOKAr1BNIFpoYW5nIFJ1aSA8cnVpLnpo
YW5nQGludGVsLmNvbT4NCj4gd3JvdGU6DQo+ID4gDQo+ID4gVGhpcyBwYXRjaCBzZXJpZXMgaXMg
bWFkZSBiYXNlZCBvbiB0aGUgcGF0Y2ggc2VyaWVzIHBvc3RlZCBhdA0KPiA+IGh0dHBzOi8vbG9y
ZS5rZXJuZWwub3JnL2FsbC8yMDI0MDEzMTExMzcxMy43NDc3OS0xLXJ1aS56aGFuZ0BpbnRlbC5j
b20vDQo+ID4gDQo+ID4gUHJvYmxlbSBzdGF0ZW1lbnQNCj4gPiAtLS0tLS0tLS0tLS0tLS0tLQ0K
PiA+IE1TUiBSQVBMIHBvd2VyY2FwIHN5c2ZzIGlzIGRvbmUgaW4NCj4gPiBkcml2ZXJzL3Bvd2Vy
Y2FwL2ludGVsX3JhcGxfbXNyLmMuDQo+ID4gTVNSIFJBUEwgUE1VIGlzIGRvbmUgaW4gYXJjaC94
ODYvZXZlbnRzL3JhcGwuYy4NCj4gPiANCj4gPiBUaGV5IG1haW50YWluIHR3byBzZXBhcmF0ZSBD
UFUgbW9kZWwgbGlzdHMsIGRlc2NyaWJpbmcgdGhlIHNhbWUNCj4gPiBmZWF0dXJlDQo+ID4gYXZh
aWxhYmxlIG9uIHRoZSBzYW1lIHNldCBvZiBoYXJkd2FyZS4gVGhpcyBpbmNyZWFzZXMgdW5uZWNl
c3NhcnkNCj4gPiBtYWludGVuYW5jZSBidXJkZW4gYSBsb3QuDQo+ID4gDQo+ID4gTm93IHdlIG5l
ZWQgdG8gaW50cm9kdWNlIFRQTUkgUkFQTCBQTVUgc3VwcG9ydCwgd2hpY2ggYWdhaW4gc2hhcmVz
DQo+ID4gbW9zdA0KPiA+IG9mIHRoZSBsb2dpYyB3aXRoIE1TUiBSQVBMIFBNVS4NCj4gPiANCj4g
PiBTb2x1dGlvbg0KPiA+IC0tLS0tLS0tDQo+ID4gSW50cm9kdWNpbmcgUE1VIHN1cHBvcnQgYXMg
cGFydCBvZiBSQVBMIGZyYW1ld29yayBhbmQgcmVtb3ZlDQo+ID4gY3VycmVudCBNU1INCj4gPiBS
QVBMIFBNVSBjb2RlLg0KPiA+IA0KPiA+IFRoZSBpZGVhIGlzIHRoYXQsIGlmIGEgUkFQTCBQYWNr
YWdlIGRldmljZSBpcyByZWdpc3RlcmVkIHRvIFJBUEwNCj4gPiBmcmFtZXdvcmssIGFuZCBpcyBy
ZWFkeSBmb3IgZW5lcmd5IHJlcG9ydGluZyBhbmQgY29udHJvbCB2aWENCj4gPiBwb3dlcmNhcA0K
PiA+IHN5c2ZzLCB0aGVuIGl0IGlzIGFsc28gcmVhZHkgZm9yIFBNVS4NCj4gPiANCj4gPiBTbyBp
bnRyb2R1Y2luZyBQTVUgc3VwcG9ydCBpbiBSQVBMIGZyYW1ld29yayB0aGF0IHdvcmtzIGZvciBh
bGwNCj4gPiByZWdpc3RlcmVkIFJBUEwgUGFja2FnZSBkZXZpY2VzLiBXaXRoIHRoaXMsIHdlIGNh
biByZW1vdmUgY3VycmVudA0KPiA+IE1TUg0KPiA+IFJBUEwgUE1VIGNvbXBsZXRlbHkuDQo+ID4g
DQo+ID4gR2l2ZW4gdGhhdCBNU1IgUkFQTCBhbmQgVFBNSSBSQVBMIGRyaXZlciB3b24ndCBmdW50
aW9uIG9uIHRoZSBzYW1lDQo+ID4gcGxhdGZvcm0sIHRoZSBuZXcgUkFQTCBQTVUgY2FuIGJlIGZ1
bGx5IGNvbXBhdGlibGUgd2l0aCBjdXJyZW50IE1TUg0KPiA+IFJBUEwNCj4gPiBQTVUsIGluY2x1
ZGluZyB1c2luZyB0aGUgc2FtZSBQTVUgbmFtZSBhbmQgZXZlbnRzDQo+ID4gbmFtZS9pZC91bml0
L3NjYWxlLg0KPiA+IA0KPiA+IEZvciBleGFtcGxlLCBvbiBwbGF0Zm9ybXMgdXNlIGVpdGhlciBN
U1Igb3IgVFBNSSwgdXNlIHRoZSBzYW1lDQo+ID4gY29tbWFuZA0KPiA+IMKgcGVyZiBzdGF0IC1l
IHBvd2VyL2VuZXJneS1wa2cvIC1lIHBvd2VyL2VuZXJneS1yYW0vIC1lDQo+ID4gcG93ZXIvZW5l
cmd5LWNvcmVzLyBGT08NCj4gPiB0byBnZXQgdGhlIGVuZXJneSBjb25zdW1wdGlvbiB3aGVuIHRo
ZSBldmVudHMgYXJlIGluICJwZXJmIGxpc3QiDQo+ID4gb3V0cHV0Lg0KPiA+IA0KPiA+IE5vdGVz
DQo+ID4gLS0tLS0NCj4gPiBUaGVyZSBhcmUgaW5kZWVkIHNvbWUgZnVuY3Rpb25hbCBjaGFuZ2Vz
IGludHJvZHVjZWQsIGR1ZSB0byB0aGUNCj4gPiBkaXZlcmdlbmN5IGJldHdlZW4gdGhlIHR3byBD
UFUgbW9kZWwgbGlzdHMuIFRoaXMgaW5jbHVkZXMsDQo+ID4gMS4gRml4IEJST0FEV0VMTF9EIGlu
IGludGVsX3JhcGwgZHJpdmVyIHRvIHVzZSBmaXhlZCBEcmFtIGRvbWFpbg0KPiA+IGVuZXJneQ0K
PiA+IMKgwqAgdW5pdC4NCj4gPiAyLiBFbmFibGUgUE1VIGZvciBzb21lIEludGVsIHBsYXRmb3Jt
cywgd2hpY2ggd2VyZSBtaXNzaW5nIGluDQo+ID4gwqDCoCBhcmNoL3g4Ni9ldmVudHMvcmFwbC5j
LiBUaGlzIGluY2x1ZGVzDQo+ID4gwqDCoMKgwqDCoMKgwqAgSUNFTEFLRV9OTlBJDQo+ID4gwqDC
oMKgwqDCoMKgwqAgUk9DS0VUTEFLRQ0KPiA+IMKgwqDCoMKgwqDCoMKgIExVTkFSTEFLRV9NDQo+
ID4gwqDCoMKgwqDCoMKgwqAgTEFLRUZJRUxEDQo+ID4gwqDCoMKgwqDCoMKgwqAgQVRPTV9TSUxW
RVJNT05UDQo+ID4gwqDCoMKgwqDCoMKgwqAgQVRPTV9TSUxWRVJNT05UX01JRA0KPiA+IMKgwqDC
oMKgwqDCoMKgIEFUT01fQUlSTU9OVA0KPiA+IMKgwqDCoMKgwqDCoMKgIEFUT01fQUlSTU9OVF9N
SUQNCj4gPiDCoMKgwqDCoMKgwqDCoCBBVE9NX1RSRU1PTlQNCj4gPiDCoMKgwqDCoMKgwqDCoCBB
VE9NX1RSRU1PTlRfRA0KPiA+IMKgwqDCoMKgwqDCoMKgIEFUT01fVFJFTU9OVF9MDQo+ID4gMy4g
Q2hhbmdlIHRoZSBsb2dpYyBmb3IgZW51bWVyYXRpbmcgQU1EL0hZR09OIHBsYXRmb3Jtcw0KPiA+
IMKgwqAgUHJldmlvdXNseSwgaXQgd2FzDQo+ID4gwqDCoMKgwqDCoMKgwqAgWDg2X01BVENIX0ZF
QVRVUkUoWDg2X0ZFQVRVUkVfUkFQTCzCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqANCj4gPiAmbW9k
ZWxfYW1kX2h5Z29uKQ0KPiA+IMKgwqAgQW5kIG5vdyBpdCBpcw0KPiA+IMKgwqDCoMKgwqDCoMKg
IFg4Nl9NQVRDSF9WRU5ET1JfRkFNKEFNRCwgMHgxNywgJnJhcGxfZGVmYXVsdHNfYW1kKQ0KPiA+
IMKgwqDCoMKgwqDCoMKgIFg4Nl9NQVRDSF9WRU5ET1JfRkFNKEFNRCwgMHgxOSwgJnJhcGxfZGVm
YXVsdHNfYW1kKQ0KPiA+IMKgwqDCoMKgwqDCoMKgIFg4Nl9NQVRDSF9WRU5ET1JfRkFNKEhZR09O
LCAweDE4LCAmcmFwbF9kZWZhdWx0c19hbWQpDQo+ID4gDQo+ID4gQW55IGNvbW1lbnRzL2NvbmNl
cm5zIGFyZSB3ZWxjb21lLg0KPiANCj4gU2F5IHRoZSBmaXJzdCBwYXRjaCBpbiB0aGUgc2VyaWVz
IGlzIGFwcGxpZWQgYW5kIHRoZSBsYXN0IG9uZSBpcyBub3QuDQo+IFdpbGwgYW55dGhpbmcgYnJl
YWs/DQoNCk5vLiBXaXRob3V0IHRoZSBsYXN0IHBhdGNoDQoxLiBmb3IgcGxhdGZvcm1zIHVzaW5n
IFRQTUkgUkFQTCwgLmVuYWJsZV9wbXUgZmxhZyBpcyBzZXQgYW5kIFBNVSBpcw0KICAgcmVnaXN0
ZXJlZCB2aWEgUkFQTCBmcmFtZXdvcmsNCjIuIGZvciBwbGF0Zm9ybXMgdXNpbmcgTVNSIFJBUEws
IGl0IGRvZXNuJ3Qgc2V0IC5lbmFibGVfcG11IGZsYWcsIGFuZA0KICAgdGhlIFBNVSBpcyByZWdp
c3RlcmVkIGJ5IGFyY2gveDg2L2V2ZW50cy9yYXBsLmMNCg0KPiANCj4gUmVnYXJkbGVzcyBvZiB0
aGUgYWJvdmUuIGlmIGFueSBleGlzdGluZyBjb2RlIGlzIG1vdmVkIHVubW9kaWZpZWQgYnkNCj4g
dGhpcyBzZXJpZXMgdG8gYSBuZXcgbG9jYXRpb24sDQoNCmludGVsX3JhcGwgUE1VIHN1cHBvcnQg
c2hhcmVzIGEgbG90IG9mIGNvZGUgd2l0aA0KYXJjaC94ODYvZXZlbnRzL3JhcGwuYywgYnV0IHN0
aWxsIHRoZXJlIGFyZSBxdWl0ZSBhIGxvdCBvZiBkaWZmZXJlbmNlcy4NCkluY2x1ZGluZw0KMS4g
ZHluYW1pYyBQTVUgcHJvYmluZw0KMi4gdXNpbmcgaW50ZWxfcmFwbCB3cmFwcGVycyB0byBnZXQg
ZW5lcmd5IHVuaXRzIGFuZCByZWFkIGVuZXJneQ0KY291bnRlcg0KZXRjLg0KDQp0aGFua3MsDQpy
dWkNCj4gIGl0IHdvdWxkIGJlIG5pY2UgdG8gYmUgYWJsZSB0byBzZWUgdGhhdA0KPiBpbiB0aGUg
cGF0Y2hlcy7CoCBPdGhlcndpc2UsIHNvbWUgc3VidGxlIGRpZmZlcmVuY2VzIG1heSBiZSBtaXNz
ZWQuDQoNCg==

