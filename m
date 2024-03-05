Return-Path: <linux-kernel+bounces-92696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 360B5872475
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 17:37:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B17301F2697D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 16:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55C10946F;
	Tue,  5 Mar 2024 16:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q/gN99P5"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B01C157;
	Tue,  5 Mar 2024 16:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709656651; cv=fail; b=IBtXqRRntlHOT9dj3h5Ks5ggMT88dRbss+KIksSMpLQYzLIbF4SHuiLRwn5f1zyK+gWCL0X1eNIvYRr39SdSXPGu6aHgwqjOrtpgqjjb8Xw4fvNwqqDtQdELCncnWrH0QhWq8znvLCoUlgQSzVJeWc7TNDwL+PBiUuxc+CibMGE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709656651; c=relaxed/simple;
	bh=pU6oBHeb+0d5q8CoBxW/bKSEqMRNnl2mh7MHWWxdmTM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NSfDz0cDMsMnEeVfOxgZEvuT/Lj1r+AKyLJxc2S8wJHaeMzSLXXgS32jr86M4sLqjMrNqfygd88yMPKb9G+hwGIIawqDibVra/IVDLfxo9TdLS8PU3QS/rstz0P4oyTtsnP8r3WPnQV0/uDkqhVM9qZzZ5S42T5/OfLmyUidjjU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q/gN99P5; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709656650; x=1741192650;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=pU6oBHeb+0d5q8CoBxW/bKSEqMRNnl2mh7MHWWxdmTM=;
  b=Q/gN99P5ZGo2ghLh6tKNiIJOkN8giM9Y+pIctQ+bUXHyl4y42GiORUfR
   CFqEbRNOM6DCpMnrUdueHlXnLxR0rbeQZqGJjv1LjX/qWsFICLotx3Lkk
   sV4F/KbW4oIE4ZctxepIZ5B5VfKpmBtg3biNa9eOQbAyob1ek63HnilFJ
   8aWF1DF+OWDzVOcNYw4naiSNwURJFVD6cepB/1lN3W5R3eBD8fT0WSyiy
   OQbut8+ar6NtZhgZN++J7ytuS4BveVVxHZ2IYGtSmkNE3zLkkFheA9ELP
   2SnaEkxsYYY2CLoda7buI0uv8CGyc2e/hkXv/Z8YeJOs1TvvQvNAVJocc
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="4346505"
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="4346505"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2024 08:37:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="9392947"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Mar 2024 08:37:29 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 5 Mar 2024 08:37:28 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 5 Mar 2024 08:37:28 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 5 Mar 2024 08:37:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J7KMjrlY2zxa5/D2cdUKooRubDDcNs4DmyVG39cdljfl4epDn972JH9I3vD7oDmn0S1vi5ZWLFxJlHLpuI+vphdjfVPFcxFX/1xM/c5brABZyBLc8sbQhQfqs4DLelaYXeyH90YY75RC1r+UdmbFUqCyGEUH4CLElG63HE23yqKoh8y/x/lxmnWjEWry4XOy1mWfAnwY3bIdUeeqG6Aco5dLmo954JyYs7UBgM1lbwjkWcrxQKYOF16PHAbt0t2x5uLZhmBlrUPZZICv//SSbtG5nAN+zOHvvgWSKp050y5QPLRrMtL+qDnj7TCPgGPZMAFUArmZg3SPNMromNqtJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pU6oBHeb+0d5q8CoBxW/bKSEqMRNnl2mh7MHWWxdmTM=;
 b=eIMqwlr8CorF2xkdpn13NJmoCfXGgQcj9z5XCIbY4fCcjX862dD8j9pURlaR0NTB2p0x/9S7UHYzo1hdjlGij4L52XdpnAP1U6WyrKoJ3tnR8AHpw3gLVu3LuI5GLs44GMO20zLYRtJt3ETiR9y0nVmbrpPRf11ItPgSNmC3fL3TlsKYowJsFQw1bqE9CLqhYR+DyVuwM8Qq9/NwAaud9GL/dtBicawiSDxSCPSTgi5tl/dNFdWfsTH7un0yv6oE+6falsSNycfckVnN4EU+GsAZpN77fhQSYeZIRrvoG0a8xvwqqGQyNYZ8AiaAe4Z90nwhQ/DRq4Gv4AsZo9hmVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by CH3PR11MB7297.namprd11.prod.outlook.com (2603:10b6:610:140::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Tue, 5 Mar
 2024 16:37:25 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::d5ce:2b6c:458:3ca9]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::d5ce:2b6c:458:3ca9%7]) with mapi id 15.20.7362.019; Tue, 5 Mar 2024
 16:37:25 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: "Chatre, Reinette" <reinette.chatre@intel.com>, "Yu, Fenghua"
	<fenghua.yu@intel.com>, Peter Newman <peternewman@google.com>, "Jonathan
 Corbet" <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
	"x86@kernel.org" <x86@kernel.org>
CC: Shaopeng Tan <tan.shaopeng@fujitsu.com>, James Morse
	<james.morse@arm.com>, Jamie Iles <quic_jiles@quicinc.com>, Babu Moger
	<babu.moger@amd.com>, Randy Dunlap <rdunlap@infradead.org>, Drew Fustini
	<dfustini@baylibre.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "patches@lists.linux.dev"
	<patches@lists.linux.dev>
Subject: RE: [PATCH v4 1/2] x86/resctrl: Pass domain to target CPU
Thread-Topic: [PATCH v4 1/2] x86/resctrl: Pass domain to target CPU
Thread-Index: AQHaan2PyoBPXNeezkGw1htb4OlYn7EoPHyAgAASjmCAABW1gIAA/Fwg
Date: Tue, 5 Mar 2024 16:37:25 +0000
Message-ID: <SJ1PR11MB6083C8DF1FD451CD43D6726FFC222@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20240228112215.8044-tony.luck@intel.com>
 <20240228193717.8170-1-tony.luck@intel.com>
 <12766261-26b2-4aa4-a735-c2380c4963fd@intel.com>
 <SJ1PR11MB60839371908CDC17A01F2167FC222@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <428622f8-8dd9-40c8-8762-6bdef6d3a785@intel.com>
In-Reply-To: <428622f8-8dd9-40c8-8762-6bdef6d3a785@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|CH3PR11MB7297:EE_
x-ms-office365-filtering-correlation-id: 14d7d779-efd5-4c94-e967-08dc3d328a32
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Stqn4g04X+oNt3HygWUVR1I3ecEBqMwz+0LR9YYLW3MHgwzUT6t+B2lT0CkJaSgTrYjfIZ/kumt37JTKT/jds6S5XijlFaxbYuUA56eMBzwPfUpPEhetqMLkMmgPiDtRyyASsN2PEfty4lLdCNcVWTAmOREPBrB1Ezi5b9uxm5cuzJuauREyjRpa9LME4fT3Inl1KG3hCkpKmEDXyRvUfWEKdSPidiA1106nK1YnxDWCPo/qYqRwuqu6JaIOrJC/vCTfryR3qA5Nf08MhLDX8MWRVhphS3GyZfxZawNJ+VJsNJJ5lP1PMpBK0dggVFWNy2dM9qTsuEeZi1DXxe8fLXskLcDzff9Ml4fSqb/0aiYG+m4Jrpy7wSoV1gnqex1IJ9+dGV/xWS2wshnTpqtVGwRag/PfqLZO7jLqp+/51zxzbXxRUtEWz3o2zQMJOIN+K+a5KK2v0N+7/5rOhOGXbnOLcGNcUoPSKIJtDAC+SOM6JNxXWEAp4epP00BNLv91t7g3Jo2uPKpAUkE32eNxLioDNnN2bFH3EI8aneCxfC40EVwzA8qeIxKpKHtKTu2k9ai/jUt7wL3hH/usni0QCDiAphZjRBCgiZSWkhnWHTJuXD89iRhb/+AR19OVcHhAIhYVPuRp3tv0+sfpH75V7npf7ZPD9C9J4/d4sSxQZeuq9AOIIgjDCeClOEa0AD5b4BGe2RmjuK1xfEyNsRF5KBXNoYJ6sL/9OkNqYfnF+x8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aVRGbGV3ek5DN2phTWh5SkJGVFh4cEp1ZDFPK0ZQUXFiQlpqbStHQWhYWFI4?=
 =?utf-8?B?UzRNaGRMSDlmL3Y3Sm5XZmJQM0gyVGt3VGRTZWt3V2p2UHcrTmpZd3ZXMndB?=
 =?utf-8?B?Z2VPWWwvdG1aRStqTHhLUTNhYXJwMjhKTjRjY2FFUjZKbzgvaEc5WlI3MGt3?=
 =?utf-8?B?RlM3cE01UGZmQ1JsaEJGcVloQVk1N2xTaFlMYnBnN09pTENFUk5BeDFKYWZW?=
 =?utf-8?B?enRRK2tZZFFZWmFNWGoxdWpnY1JYOHc2eEdPQWpXVTMxS0JKemNFUVJNck0v?=
 =?utf-8?B?OWMvSzNzYVF1U2hzV3NJd1FOQjFqUUpQWllVcmgxMy8xNERsb2dGNXE5R3ZZ?=
 =?utf-8?B?QnhLR3Y4WFRMelMxbHdzWnRUWGVTRUFETEFieUdYTzdkUzQ2ZzJVdTd4WWEr?=
 =?utf-8?B?Um9YZ2hwQVZldUdKcXBLSEVpeE9CTjNCN3diVU8raEFGbjFOTEpIZWpqbXF2?=
 =?utf-8?B?WlFjeEx4aktNZC9FYjF0M2RYNzJVamdCdFNYaWRiSXozWnZKdmJzODRVMmJK?=
 =?utf-8?B?bnZlSjN0bExZNHpmWTQ2ZUZ0TFViMkVXVTZuM0tBcmYwbS9nc2xSMkpjYzFu?=
 =?utf-8?B?Sk45ZWN0emdGOFZ1ZElMdWV3eGh5N1Z3R2ZJTHBLMDRVSVJZN1FOZlNuT3Y2?=
 =?utf-8?B?OVhORThhSWVyUW5kYWRqY3VjS1ZVRnpiMXhON2xmTGR4cjhxNGF2S0ZnR2l4?=
 =?utf-8?B?NUtVQzYwc0pRYjA2ZEtzdlppU0pGWkViYmpaRnRGdFJ4dGExYlpBR1puVTBH?=
 =?utf-8?B?a3pTNDZBNzNjM1E0OFV3aEp1ZS9EWnRUUndjMEJoTnVDZnpYT3FUOElQaFRG?=
 =?utf-8?B?RXNiRTVmZkwxUXZEblhCSm9saVd0ZXp1SGxRb3JWRm95TVZqL3VZRnk5eWts?=
 =?utf-8?B?aW1kN2ZDRkpxMTNjV21sV3g2cEhoZEhKNW4xc3dWeU45dUFCOUFhMzJyUVNy?=
 =?utf-8?B?LzFBQ09qOGNGRC9ZdnlzNTUrdmxSc2dYMVZBSzcxUUROektiOU9tU0FJRWpp?=
 =?utf-8?B?MDdRbkFFa1JZblBmY1FvWUFLREE4a2NPNStvNFBMSUxYS25kVytNUytWd2lZ?=
 =?utf-8?B?eGE3VnhPTWs4czNuOFIzeFJ0VGo5MzVDcWdWc3B3TTgyNHFBUnBZVnhaUUFU?=
 =?utf-8?B?R2s5K0ZGVEFyNzM2dFlaYnNVbTFudFJTWFF1eTlRSTdpUzVMSzZFbXNHdjBX?=
 =?utf-8?B?VlJxZzg5b2libkpEdjl4VFNtMVZyeXYwdzdVV0NyWHBzQTVWdUFrU2NlTzlZ?=
 =?utf-8?B?NjBRa2NrU2NLS3dkaWRneWlrbk9iT3k3a2tQNGNxUU0yV1U0d05MR2oyK3Rs?=
 =?utf-8?B?YTFGcXpyZzZXaWp4TkZvSmM3bVQ0WHBGMHJPTTNaMy95R3FzWDNMSlQxYUFE?=
 =?utf-8?B?T0tzL1c5ZFQyNXByajQ5clhPdzdWMzNYN25DaWRwSldmbzZBRmxIdWgwZXN2?=
 =?utf-8?B?WkdSaGowdGJWRlVUQTA4bGtZZTRYZzVJUTJFbWh2TnlxOUN0bktuQTFHNzdu?=
 =?utf-8?B?eEZ5eTVBdUEvZlIreTRRenFnZEtyUWJrdGFIakwzRzlTR2U4a3NxRFFPbExw?=
 =?utf-8?B?QzRLWEg0R0NoN3JIdGxHQWxJTXVWODBrRTJ6N1FFWkRCRURlWXVkbm02MHBs?=
 =?utf-8?B?WThHTTlhVUJNcUJXc2lIMFJNRUlpSFF4T3VPbks5WXpHTkFiOUVUWHBKS1JC?=
 =?utf-8?B?K1NDQWdXVys1VWZqY3NNN0hjNzFXcldqYkxhTzFESEN4NC9oZFNzZE5HV3li?=
 =?utf-8?B?VE52d2h3U0N1SkQ0WXNyZEpMcHdQeWxQVWplTExKRTN5QkFxZ3cwQndiUzd2?=
 =?utf-8?B?ZVFBQWtNeklXdVN4T1BSTk1uZ290eDhsamROUGNyOHdoSndySHRRYVRYSytI?=
 =?utf-8?B?Y29raS9LK2xTRkZ2eWsrWXJuTU4yU3U0TlJGb3dpbDEzMkIvd1BNeEFFeG1z?=
 =?utf-8?B?ak82ZHBoQ2J0TDAraUorVFg3RzY2TFYreHlJUFlEdm1zclQ1akI0K09aVW9k?=
 =?utf-8?B?MnlxNHBxTk93dXpqcklvUzRrNGhEa0pSZVNQR0U3Umo5UmY1MGZUaityTnpz?=
 =?utf-8?B?VHNRSWVzaWNnZkZ3QkErRFhpOFE3bVNiZDJST3dDWUNkN3ZiTkQvak5nTEFM?=
 =?utf-8?Q?fMNW22c2wvNQr+V/QbalkFeGz?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 14d7d779-efd5-4c94-e967-08dc3d328a32
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2024 16:37:25.5755
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jknZzL+BFz7MKN62padRV30QqsnZ7QznCRKPT7emHRBg5ROcbu1gribu5g2XmX0bNXrnqPycctq45l6eQbnCWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7297
X-OriginatorOrg: intel.com

PiBJZiBJIHVuZGVyc3RhbmQgY29ycmVjdGx5IHRoYXQgd291bGQgYWx3YXlzIGxvb2sgZm9yIGEg
dmFsaWQgImNwdSINCj4gZXZlbiB3aGVuIG5vbmUgaXMgbmVlZGVkLiBOb3QgcXVpdGUgd2hhdCBJ
IHByb3Bvc2VkIGJ1dCBzaG91bGQNCj4gd29yay4gSnVzdCBzb21lIHdhc3RlZCBjeWNsZXMgaW4g
YSBub24gY3JpdGljYWwgcGF0aC4gDQoNClJlaW5ldHRlLA0KDQpTb3JyeSBmb3IgbWlzdW5kZXJz
dGFuZGluZy4gWW91IGFyZSByaWdodC4gQXNzaWdubWVudCB0byBtc3JfcGFyYW0uZG9tDQpjYW4g
YWxzbyBiZSBkZWZlcnJlZCB0byB0aGUgc2FtZSBwb2ludC4gTGlrZSB0aGlzOg0KDQogICAgICAg
IGxpc3RfZm9yX2VhY2hfZW50cnkoZCwgJnItPmRvbWFpbnMsIGxpc3QpIHsNCiAgICAgICAgICAg
ICAgICBod19kb20gPSByZXNjdHJsX3RvX2FyY2hfZG9tKGQpOw0KICAgICAgICAgICAgICAgIG1z
cl9wYXJhbS5yZXMgPSBOVUxMOw0KICAgICAgICAgICAgICAgIGZvciAodCA9IDA7IHQgPCBDRFBf
TlVNX1RZUEVTOyB0KyspIHsNCiAgICAgICAgICAgICAgICAgICAgICAgIGNmZyA9ICZod19kb20t
PmRfcmVzY3RybC5zdGFnZWRfY29uZmlnW3RdOw0KICAgICAgICAgICAgICAgICAgICAgICAgaWYg
KCFjZmctPmhhdmVfbmV3X2N0cmwpDQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGNv
bnRpbnVlOw0KDQogICAgICAgICAgICAgICAgICAgICAgICBpZHggPSBnZXRfY29uZmlnX2luZGV4
KGNsb3NpZCwgdCk7DQogICAgICAgICAgICAgICAgICAgICAgICBpZiAoY2ZnLT5uZXdfY3RybCA9
PSBod19kb20tPmN0cmxfdmFsW2lkeF0pDQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IGNvbnRpbnVlOw0KICAgICAgICAgICAgICAgICAgICAgICAgaHdfZG9tLT5jdHJsX3ZhbFtpZHhd
ID0gY2ZnLT5uZXdfY3RybDsNCg0KICAgICAgICAgICAgICAgICAgICAgICAgaWYgKCFtc3JfcGFy
YW0ucmVzKSB7DQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIG1zcl9wYXJhbS5sb3cg
PSBpZHg7DQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIG1zcl9wYXJhbS5oaWdoID0g
bXNyX3BhcmFtLmxvdyArIDE7DQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIG1zcl9w
YXJhbS5yZXMgPSByOw0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBtc3JfcGFyYW0u
ZG9tID0gZDsNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgY3B1ID0gY3B1bWFza19h
bnkoJmQtPmNwdV9tYXNrKTsNCiAgICAgICAgICAgICAgICAgICAgICAgIH0gZWxzZSB7DQogICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIG1zcl9wYXJhbS5sb3cgPSBtaW4obXNyX3BhcmFt
LmxvdywgaWR4KTsNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgbXNyX3BhcmFtLmhp
Z2ggPSBtYXgobXNyX3BhcmFtLmhpZ2gsIGlkeCArIDEpOw0KICAgICAgICAgICAgICAgICAgICAg
ICAgfQ0KICAgICAgICAgICAgICAgIH0NCiAgICAgICAgICAgICAgICBpZiAobXNyX3BhcmFtLnJl
cykNCiAgICAgICAgICAgICAgICAgICAgICAgIHNtcF9jYWxsX2Z1bmN0aW9uX3NpbmdsZShjcHUs
IHJkdF9jdHJsX3VwZGF0ZSwgJm1zcl9wYXJhbSwgMSk7DQogICAgICAgIH0NCg0KLVRvbnkNCg==

