Return-Path: <linux-kernel+bounces-116692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A14B88A193
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:21:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC6FD1C37AD8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE82214EC46;
	Mon, 25 Mar 2024 10:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V8DoHjcg"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00DC214F11D;
	Mon, 25 Mar 2024 08:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711354982; cv=fail; b=qsObgZ1bzV39QKBzq87ftRPZ9Gl4PnYBdrTRHqw9BShIvkJQg66zGb30g7tqvscoH5c1I6t9R9KmQJ2wP5x8BXKZF7t+dk0GbdXrBv56Hs4nyTu7XkTk/U2QSwuWzRdLVF7uE0dxD2ELLleoH95Xn9UBoPElu3Q29Wyc/At11iA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711354982; c=relaxed/simple;
	bh=VpP99+hyL4rBlFDS3AHCkYTKlZw3DcNdnzp0lZdB2uw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mVs+64VSmUQUmeyLFJxn51NRtuiBW8Pxme+s4r/c8KhIc99y1tw1by6/SZ9+LeDHDbSk5HBgxggYj4A6GZNHN8XyXr0o+XDZOS8b3Eu1ZiaWYMzboRHoJ1L4oVS7CdzXZjc8rkrOjNwKtKorix/UrCx4jlMFCCAV8ve/AKsh3Pc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V8DoHjcg; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711354981; x=1742890981;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=VpP99+hyL4rBlFDS3AHCkYTKlZw3DcNdnzp0lZdB2uw=;
  b=V8DoHjcgF4hRW2L+RJPPrB6OqBT3KrmcRBdC0DPOU4vYgne7xlIgJzSc
   V17wxfXsfytZIXshBX/7tSXIp63Gyazz3bW6I80m/fSHkzTMFwIG7lrn6
   ZcAwQp/n1hEve06IlofktjsARcStYgzRlLGxUVp9yvNvCAtU0wJ8/0rpz
   ktcvXMfIoj0Isx079fr5m3L0IVjhZjGCj+7rMWk//x6vFEtemohCIU+lK
   T6qeoWVdFGoxlzADDBoW0N7vYBSjZC9mNw033WaBkKtva+H/V6462wCpi
   l5Zp/yXs/mXrozxOiqbOAr14zP5xnN6wa/5JUnoqYr3Tu3DLu4/z4WXbr
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11023"; a="17074071"
X-IronPort-AV: E=Sophos;i="6.07,152,1708416000"; 
   d="scan'208";a="17074071"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 01:23:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,152,1708416000"; 
   d="scan'208";a="20212921"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Mar 2024 01:23:00 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 25 Mar 2024 01:22:59 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 25 Mar 2024 01:22:59 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 25 Mar 2024 01:22:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GlTANxjsoYdV9onsUBwOgGx23Ipt+j8NwzzU8FLoCkFgdIz+ZVuYisweTPUi2hL+We9GFTVVQJpSzTkSeZq+sKfPk8xMMTjprFsST8bNXrQ7ezlRPtBPAHtQMhFQv9D1feLBNLWDkfx2BnC43zgzGKdZnvGYdS4vBEaji7VCC3nvznLGINuAvN8qU+UNVhBPPtlfyFSigbixFk8GObKAz9JJ7U0gYtXT4bREWeeM4bp4fJWxQftW2v5QfVP4GhQCicqAi2lWNaqbgMKz1BfxP3y34zltN0YcNO0TibcrpTo0qzgBMNrKavJBfYV2ijSNEPd0I4L48GfhvLvKWfTNuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VpP99+hyL4rBlFDS3AHCkYTKlZw3DcNdnzp0lZdB2uw=;
 b=L0LvQ7cC8ktPob/kBBQQCtOX6BcapcLu0n9j2lUe8pPUphi7hpQuPDr1DHtlqb+RNB4Is8kvcypiRaHdm+Y85ZlmMwMqn9FfAdkzSsMV+Fje8WTWMSRzAb7kWlp53841y4595T/3L29Oc80jBeplaI45yaGJ+dqxVO2NoKMCcYtlUzZMOdyjtxHyqU9egC4pDZzHwg7s5dLHPe1fGKzsuqtdbVxDTSNCqr7gj2Wt1+fIl4v/7p0EUSlqCjEqzmJ1XlVaApvSi6QJYPszh8tWF0LuAJaMiy4QglfXQrIgYpIm0SN2PNWRRfFuvwf920D4jA0kGur5K7fhBX3B33x7AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB7605.namprd11.prod.outlook.com (2603:10b6:510:277::5)
 by CYYPR11MB8359.namprd11.prod.outlook.com (2603:10b6:930:ca::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Mon, 25 Mar
 2024 08:22:57 +0000
Received: from PH7PR11MB7605.namprd11.prod.outlook.com
 ([fe80::5144:aca9:5cd9:42bf]) by PH7PR11MB7605.namprd11.prod.outlook.com
 ([fe80::5144:aca9:5cd9:42bf%3]) with mapi id 15.20.7409.028; Mon, 25 Mar 2024
 08:22:57 +0000
From: "Winkler, Tomas" <tomas.winkler@intel.com>
To: Avri Altman <Avri.Altman@wdc.com>, Ulf Hansson <ulf.hansson@linaro.org>,
	Jens Wiklander <jens.wiklander@linaro.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
	"op-tee@lists.trustedfirmware.org" <op-tee@lists.trustedfirmware.org>, "Shyam
 Saini" <shyamsaini@linux.microsoft.com>, Jerome Forissier
	<jerome.forissier@linaro.org>, Sumit Garg <sumit.garg@linaro.org>, "Ilias
 Apalodimas" <ilias.apalodimas@linaro.org>, Bart Van Assche
	<bvanassche@acm.org>, Randy Dunlap <rdunlap@infradead.org>, Ard Biesheuvel
	<ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, =?utf-8?B?QWxleCBCZW5uw6ll?=
	<alex.bennee@linaro.org>
Subject: RE: [PATCH v3 1/3] rpmb: add Replay Protected Memory Block (RPMB)
 subsystem
Thread-Topic: [PATCH v3 1/3] rpmb: add Replay Protected Memory Block (RPMB)
 subsystem
Thread-Index: AQHaaZI6hlE8ndSfV0SK+qyaZjIC67FEGAMAgAQr5oCAAAIrUA==
Date: Mon, 25 Mar 2024 08:22:57 +0000
Message-ID: <PH7PR11MB76054BC0C863E5947C7B2DAFE5362@PH7PR11MB7605.namprd11.prod.outlook.com>
References: <20240227153132.2611499-1-jens.wiklander@linaro.org>
 <20240227153132.2611499-2-jens.wiklander@linaro.org>
 <CAPDyKFp5j+L=oE1uVyUdu7rVLxRcueWwP0XcNTTMMrFQgmeZiw@mail.gmail.com>
 <DM6PR04MB65755A95AA492565F7576D10FC362@DM6PR04MB6575.namprd04.prod.outlook.com>
In-Reply-To: <DM6PR04MB65755A95AA492565F7576D10FC362@DM6PR04MB6575.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB7605:EE_|CYYPR11MB8359:EE_
x-ms-office365-filtering-correlation-id: 918f4828-b1c5-4987-d8cc-08dc4ca4c6de
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: s/SNj/ETHH8J9pbKITMtW0LLmy4vuSRPyGOBXBuPmQCuMT2NM4wBeC35z6usFAs4l/Ncs3o0FQ5VITDuf06LNZXhgc/H5XnknOIgLD4yv6QItriRRdYce5tBGegs1ptzcyxzY8jrBIwNf8IM6w5s1T1ueuM/w1LWf+f3I+DGzAbvLQ4UoHr4Biyd0zbJX0acq03vGbqLHzdunTtG4qzCYRKEBIBUj5R+23kmdXGzoDT83jN8zRmmOhTlCjowo8HTy0+j6k3kysccbyFoOfg+G1+TjvR9OHZbxxW5grpyA7V+25HPuhsR1LRDTZ0EQjaiDf/eOGPlNsGUWtflaf040Dhzn9+VkRUpTNQWYDCIkZ1JH5zf5PzfgdFAZzUagp6Q4G3DOc7ILkprU/N8BA2Ia55qKsh/BMXQQRu3ShLdi0mm8aK74iqqAhlzmwpQshboYAuTrRMBA2iZO68OahcCSnAfSgPQMBAyG+a/jSJ8U0irwPOMwD8NODJJjodiT19gqcoJslpQANp9cJDk4po/cw7jfbIreN0hmCKEHmOtnbGtLaRu+Uuc9c/EP4EjDBWL7ty/OwoA+gOrczFjkqDgGL4wDjT3LnlbAHtOOoanAXklF+8+HulV++0BPhH/D7NyCPgSS76ESwYAW+whIIA3cFzUuP84huHOhMnabPpbK8NWC/tTm1bjuaV7zCfR23TEhm3U8WK6pPO53fvDXigqql8JQ24R52H1n1Ke2Rc9nYI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB7605.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(7416005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WTBlS3VSRHBWOGZUOHRxeEt3bWNFZzJFcGJza1RJNk5FTzBQZExsT3Nhd3kr?=
 =?utf-8?B?NWZsN3F2bDNIQzBXSjI4S0JiSVFTVG8wbEtLazVNcXhoWGp5dmpoRVBtYnlX?=
 =?utf-8?B?Mms5Q1RCRzUvdnM2Y29qaWoyK2pHekRNaENPeVRMc3R0d0tvYlJtTHpyL1RD?=
 =?utf-8?B?NFZPanhPK1ZudklZV0JlZXZQLzB5UlJaR1ZESWl5UGdabElGN3BKMlFqRVRm?=
 =?utf-8?B?bmF4MmdxM3l5c0N3MGNvdXlnaVhSN3ZBckxYQ3BGaEw0MFJiUjJhdVkzU1Fz?=
 =?utf-8?B?Q2FyWFMyNDdPdWM5NWZ0d3BoRE81R09XcGsyaWhHeU1VZTNqT2ZCOFV4TWI4?=
 =?utf-8?B?MW0zSHREanNoMTFPZHhGZ3lNQ0xNNHBncE9Zemhaa3c5RGlYWEY1MHZjbEs5?=
 =?utf-8?B?US8vREJCL1dXL3BiRFlZRVQ0SWRzdUNkUUw0TzhrMzJOdUdiRjRzcWNUVTZz?=
 =?utf-8?B?dXhTdXh6UDNvMkJSNjh0dlBKUTE3YmNWclVKa2Y2MU1hTFNMdHhpZ200QUE2?=
 =?utf-8?B?UHRYQlVsV04rUXFvRkxqSGw3VTFxbks2YVJpcUloWnJoUE9BNHBtVlFYMjFN?=
 =?utf-8?B?clAwaGltYm5ieEEvU1U3K3h4VDRtQlRBUk4zQXFvZi9ONGd2N3puSnozSmd3?=
 =?utf-8?B?TDd0cXFydERIeWdzWVBXeHd5Um90Y0wvSHZ2dUI3aEdOak5meVQ5SGRJMHBF?=
 =?utf-8?B?eHNML0d6YVR2R05SSURVL3Q2Vk1nRms5ZWsxOUtGOHcrQUZnWUJhZysrN3Nz?=
 =?utf-8?B?SnB2VVFkWkRGdWk4Ymp6ZC9iS2hDTVBHNFpZMEpNc1pWUEViM2d6QzV6VzNn?=
 =?utf-8?B?RFIwTnQ0cS9qdTNUTXVhM3pSeENKTXEvcjh5NmlBNFZ6Z09SeVFTaFJVTUFs?=
 =?utf-8?B?bVVpWG9IbG5sajhPY0FXSGhIOG82ejMzd0s5Zkdzc2toZExqNDl2UEI2ekFp?=
 =?utf-8?B?OGt2UVFlRmR2NGJiN0tFMkZxbzZkUFhOMnlqRzJjN0ZaTmc0QTBENFJETEto?=
 =?utf-8?B?V3YzODNjSnpUSHpJNjYrd3haR0JZTEdFbUxzdkl6WUtTZ0JselZMYmh1emVy?=
 =?utf-8?B?N3BTd1l2Tk9wRC9id0wvM044ZEdKYllQRlBXM2ZBVzdLeGs0VHdyZkFXbXJv?=
 =?utf-8?B?KzI4U2lBT1dKS1JhWEU3R2R6VHZ1bVpCNDFsZE9mQ2E1dzc0V1c5Zlh1YkZr?=
 =?utf-8?B?UWttblIvRUE1YlAxMWJLUXhMMmFVZU90cTJxclBjM3JPbjVkcnhQS3c4OU9H?=
 =?utf-8?B?LzBsUGhUNVhRVEFsbnZTRGRVVUdkM0FETFdJRlJKNXNaMXo0aHNQZjNYSWJO?=
 =?utf-8?B?UXBFMWtHVnBuZ0F4eGRqU09ndWVhdE9hYXlwd3p3K1dZakpOZ2VsbUsrYTZr?=
 =?utf-8?B?K053ekFtTG92VTduMnJydkVNK1Y5N1ExeTNJbzdocFRpVE53QVNxMndmK3Fi?=
 =?utf-8?B?am9UTnhoWDFNcFpVYUlOMUF0dDh5ZEUyS3JDczN3V1k1N29xMHRmdlpaM0lY?=
 =?utf-8?B?WTluRFBid2MySGVGZWdSd1ZmMWtGcDgxOC9VM0dLM3VuRUUxUW1qaUVFMFBk?=
 =?utf-8?B?bGpaVEV2V1RmNUhLV2dGMzZjYUtQTzFiam5kU29xUEIyNlFmK2ljRFFzRVkr?=
 =?utf-8?B?Q1FNaUhkTVFFR0t2T0FQTFZtakZrSElXSUVwSUpkeEpsNFNwT29tQmo1YXRi?=
 =?utf-8?B?eVVNb0tmczRXUTg0clFTN0NvdmI1S25pVWJXUXpqSVRCNXBsZVRpazVMSTNa?=
 =?utf-8?B?WWZhRzNjNndPcVE2cUxrZXhGSGhnR3BXVjA2Mm1kUGdpVjFTcmljcjhDUzBD?=
 =?utf-8?B?MUYwSkVqSVZIbXI0TGJ2Q3JFME15a0lyYTJaQ0xrYjYrb3lQbnBsTWVmb0M5?=
 =?utf-8?B?bWVPNnZlMERZOG01ZWJabU10NkE0THdKWnRwdkFhVHJmcklFays0MTJZcU9U?=
 =?utf-8?B?SzFTYk1qQ3JoZXViYzBycEgwMkQ1N25NREdoWmJ6cUtqdXcvb3lmQi82KzlZ?=
 =?utf-8?B?TG1EWnErWEFid0h4ODl4YmFJeHJuZUN5NFZXSmVMSGovbDlsbHdaVEZMbkF5?=
 =?utf-8?B?SEI1YzJVaW9CMEc2T3I4SWJKSEhlaFVtTXVZYy9WRGZlWXNQVjRodHRSU3VO?=
 =?utf-8?Q?XLJ5KrcYWAnoG9raW1U+yWAHL?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB7605.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 918f4828-b1c5-4987-d8cc-08dc4ca4c6de
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2024 08:22:57.3984
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JojCcrE9LpkV7lbk4JbJy+LM0GqCW++1b6goCkLxttPuzt2DwS6c/OcOi6ndXYhcfJTurKR5bzkAZXNY/VEMKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR11MB8359
X-OriginatorOrg: intel.com

DQo+ID4gPiArc3RydWN0IHJwbWJfZnJhbWUgew0KPiA+ID4gKyAgICAgICB1OCAgICAgc3R1ZmZb
MTk2XTsNCj4gPiA+ICsgICAgICAgdTggICAgIGtleV9tYWNbMzJdOw0KPiA+ID4gKyAgICAgICB1
OCAgICAgZGF0YVsyNTZdOw0KPiA+ID4gKyAgICAgICB1OCAgICAgbm9uY2VbMTZdOw0KPiA+ID4g
KyAgICAgICBfX2JlMzIgd3JpdGVfY291bnRlcjsNCj4gPiA+ICsgICAgICAgX19iZTE2IGFkZHI7
DQo+ID4gPiArICAgICAgIF9fYmUxNiBibG9ja19jb3VudDsNCj4gPiA+ICsgICAgICAgX19iZTE2
IHJlc3VsdDsNCj4gPiA+ICsgICAgICAgX19iZTE2IHJlcV9yZXNwOw0KPiA+ID4gK30gX19wYWNr
ZWQ7DQo+ID4NCj4gPiBJIGhhdmVuJ3QgbG9va2VkIGF0IHRoZSBOVk1FIG9yIHRoZSBVRlMgc3Bl
YyBpbiBkZXRhaWwuIEFsdGhvdWdoLCBJDQo+ID4gYXNzdW1lIHRoZSBhYm92ZSBmcmFtZSBtYWtl
cyBzZW5zZSBmb3IgdGhvc2UgdHlwZXMgb2YNCj4gaW50ZXJmYWNlcy9wcm90b2NvbHMgdG9vPw0K
PiBUaGUgcnBtYiBpbXBsZW1lbnRhdGlvbiBpbiB1ZnMsIGhhcyBkcmlmdGVkIGFwYXJ0IGZyb20g
ZU1NQy4gRS5nLiBpbg0KPiBVRlM0LjA6DQo+ICAtICB0aGUgZnJhbWUgaXMgZGlmZmVyZW50IC0g
c2VlIHN0cnVjdCB1ZnNfYXJwbWJfbWV0YSBpbg0KPiBpbmNsdWRlL3VhcGkvc2NzaS9zY3NpX2Jz
Z191ZnMuaCwNCj4gIC0gQWRkaXRpb25hbCBleHRlbmRlZCBoZWFkZXIgd2FzIGFkZGVkLA0KPiAg
LSB0aGUgZnJhbWUgc2l6ZSBpcyBubyBsb25nZXIgNTEyQnl0ZXMgKDI1NkJ5dGVzIG1ldGEgaW5m
byArIDI1NkJ5dGVzIGRhdGEpDQo+IGJ1dCA0aywNCj4gIC0gdGhlcmUgYXJlIDkgcnBtYiBvcGVy
YXRpb25zIGluc3RlYWQgb2YgNywNCj4gIC0gVGhlIGF0b21pY2l0eSByZXF1aXJlbWVudCBvZiB0
aGUgY29tbWFuZCBzZXF1ZW5jZSB3YXMgd2F2ZWQsIEFuZA0KPiBwcm9iYWJseSBtb3JlIGRpZmZl
cmVuY2VzIHRoYXQgSSBmb3Jnb3QuDQo+IFRoaXMgaXMgd2h5IGl0IGlzIGJldHRlciB0byBkZXNp
Z25hdGVkIHRoaXMgYXMgYW4gZU1NQy1vbmx5IGltcGxlbWVudGF0aW9uPw0KDQpBcyAgSSB3cm90
ZSBwcmV2aW91c2x5IHRoZSBvcmlnaW5hbCBpbXBsZW1lbnRhdGlvbiBoYXMgYWxyZWFkeSByZXNv
bHZlZCBwcm90b2NvbCBkaWZmZXJlbmNlcw0KIChOVk1lIGhhdmUgYWxzbyBkaWZmZXJlbnQgYnl0
ZSBvcmRlcmluZykgZm9yIGNsb3NlZCB1c2VjYXNlIG9mIHN0b3JpbmcgZGF0YSAobm90IHRoZSBj
b25maWd1cmF0aW9uKSAgDQpJIGJlbGlldmUgdGhlIHdob2xlIHBvaW50IGhlcmUgaXMgdG8gbGV0
IFRFRSBkcml2ZXIgdG8gc3RvcmUgdGhlIGRhdGEsIHJlZ2FyZGxlc3Mgb2YgdGhlIHRlY2hub2xv
Z3kuIA0KIEluIGFkZGl0aW9uIEkgbWlnaHQgYmUgd3JvbmcgYnV0IEkgZG9uJ3Qgc2VlIG11Y2gg
dmFsdWUgaW4gZU1NQyBhcyB0aGUgVUZTIGFuZCBOVk1lIGFyZSBjdXJyZW50bHkgbGVhZGluZyB0
ZWNobm9sb2dpZXMuIA0KVGhhbmtzDQpUb21hcw0KDQo=

