Return-Path: <linux-kernel+bounces-85076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5822F86B00F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 14:12:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BACE71F276FA
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 13:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 840CD14A4C9;
	Wed, 28 Feb 2024 13:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FlJeM1AW"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5483E14691C
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 13:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709125966; cv=fail; b=qQxKd47fATc6mM89PZLqbHSG6KUi270MZdnJEtbDgYDR+Cwkpor9jyJt/2obSUwHujKx5sJWQfAMoxHBgoXNsfZDKx3v1haj/n0d7qVFwxAbql0AnMEGUfU8y77HXfpKKxl7zeNltigoiqGaBGJdsjH6Xgh4KBpPvz6tSCRuPL0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709125966; c=relaxed/simple;
	bh=4qKHQAOsnyycQxsChAuM4eXAzq6jpFo/dWGfkccEV3k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=a/6Mk859q7yWIyy/7D1DbBJpom9MeXYs1dqO+JVqhra8zsl0DHWcirvDJoaV9oGRhAt7nYatNm0pmgAYaH5LjqHfbx9i0Iyw24ax7T3h+OxguAMnw0uOwbg0vGxN6yg4UlVTVBY4UiWgusv7RfoX1PiWsyJLdjBegBi8yaVCF7g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FlJeM1AW; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709125963; x=1740661963;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=4qKHQAOsnyycQxsChAuM4eXAzq6jpFo/dWGfkccEV3k=;
  b=FlJeM1AWoo38GKid3KlI0hAchW7TkDqucVSypPCJMf4cB71ZGY/HEdtE
   OdLDacb7icd96MBMthihMurYHKrmMAhRF9NcFlCzv7p17kfV3oDUIQ/oV
   9ACXpnbwUubiPPd2+GIJAfyl4SOeyasT9g48kU2hYhX23ZQFd6NiJupPW
   DjGLY5F9ZI3Iu6oSEj1SjHkLqt46e7wbXqrFG7J00W8ZBNg6dMfm/xY3Z
   2MzY7yHupMEKHvpsc1w2rdzWz5sgljMSOErSloJJkwFlfUBRbdTeQ0g40
   861LaQlFpPCUBR9tJuutkXgiDD6yP96TyBFBSSwci4RLyYyRLc7Pycs2o
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="3445032"
X-IronPort-AV: E=Sophos;i="6.06,190,1705392000"; 
   d="scan'208";a="3445032"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 05:12:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,190,1705392000"; 
   d="scan'208";a="7363629"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Feb 2024 05:12:42 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 28 Feb 2024 05:12:41 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 28 Feb 2024 05:12:41 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 28 Feb 2024 05:12:41 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 28 Feb 2024 05:12:41 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ObRTlTW1RXbu2iSny5JzZkDzQXfWFdeJt2ToiwZRa6n6OUfVyR3kR4rkMBSewHB1bpbEzMXdaEzD4VSE2nC5QwW2AZHuC8pwwN65pX/sRjW8e7t9uiOl/EfoGMAtSUwuC3VQTPPvSaNgxXz+G0HESkN0RBUjNlq0MK3a65oEjHsnBb1OGc6gJnoA1r7WchjOgvl8XMYASU45KuG0+aCMWi/2CffXypyT58mSh7nMR6+JNJruqhrNJR9V+dIBghQcVHHKiNhWwEBHLLCSxXWM4TngZLZlMZ9XFAjwnAacePE4WsiaPJnUymqBo5y4ZbvtC9hKREKNVPgkQ172mcMACQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4qKHQAOsnyycQxsChAuM4eXAzq6jpFo/dWGfkccEV3k=;
 b=YMACzw8VgWsCP/6L9BzrokF7/tFo38cfw+notNQDbBmZWrF4wNX1kwpmZbcSm9I2ko7uQv5Y9Gs3azIJ4VgSugnsPK1gH4Ybqy8Y+BHVPkHfdLvMz+L4mP1nQUBBPjM4AtaA116SFRjBmOgkLA6wqPLPyFHBqZMZX+0rtqp9y3tolSPV9PjtvL0kvVLzr2fs4jccxe+B6JpplhPLWWSFPb5cKFvwF6X7DbW7wu/3fJnjJuKgzMBOEdQGUAKwRaKZUP7mZTnAyZD0BLBuxBaFvoEutd6kLRuRe4lxxcwU3XpxVC3KmEQ5fDjundS+8TdI8ojTMm30V0zNugnAu5qgTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4PR11MB8179.namprd11.prod.outlook.com (2603:10b6:8:18e::22)
 by CH3PR11MB7762.namprd11.prod.outlook.com (2603:10b6:610:151::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.12; Wed, 28 Feb
 2024 13:12:36 +0000
Received: from DM4PR11MB8179.namprd11.prod.outlook.com
 ([fe80::c563:8fb8:d95:71ac]) by DM4PR11MB8179.namprd11.prod.outlook.com
 ([fe80::c563:8fb8:d95:71ac%3]) with mapi id 15.20.7339.024; Wed, 28 Feb 2024
 13:12:36 +0000
From: "Souza, Jose" <jose.souza@intel.com>
To: "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
	"quic_mojha@quicinc.com" <quic_mojha@quicinc.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "Vivi, Rodrigo" <rodrigo.vivi@intel.com>, "johannes@sipsolutions.net"
	<johannes@sipsolutions.net>, "Cavitt, Jonathan" <jonathan.cavitt@intel.com>
Subject: Re: [PATCH 2/4] devcoredump: Add dev_coredump_timeout_set()
Thread-Topic: [PATCH 2/4] devcoredump: Add dev_coredump_timeout_set()
Thread-Index: AQHaacAJwgnYu/V0b0q0sHYUz7HnqLEfbESAgABPzwA=
Date: Wed, 28 Feb 2024 13:12:36 +0000
Message-ID: <cc11ba085ee36494cfb26d273a5e68e7a9f35ece.camel@intel.com>
References: <20240227210008.182904-1-jose.souza@intel.com>
	 <20240227210008.182904-2-jose.souza@intel.com>
	 <27b24aa4-f5d8-0936-051d-59f298da2315@quicinc.com>
In-Reply-To: <27b24aa4-f5d8-0936-051d-59f298da2315@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB8179:EE_|CH3PR11MB7762:EE_
x-ms-office365-filtering-correlation-id: 6a82cf19-36c3-4af7-359d-08dc385eeefc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Qh6KI6poH3kCbZ2bmflLhsc9JiPiRj5GeR0NaSccYgwxoKg+q/QfcJu0y+y+IHcnMZXC8y4F1wZC496G05fIlSBVYvVUDF6mPV41889mT1egOlE7Cn1FzYYQw4bJT0BsBL8vUENB+1fD5TyKL/lxFqBAfRYuWUc+xGosiuO3m02Dbw8Z0mmWwyAUYldQT7q3cSHekngLopANBOttw3QaecynHMb0v2+AlNIXHAFX4SxPX4wK12+0GsboSH5BaMF+5+6ljVa99C+S/PaXknbV6jNG8Ch5VEd+foI6gopBEX6gEyE/o6bOLFAUpR/TfsignNTh9b3E8qvxA4OmL5o9Q2srdEDJUHA3Sz6I9VUV1OyveVyA95m9SKIiK3Oa+zM7ksI1w3oXCQkRZ/4ARNG45pZlewoMY1EyiNYuytz9hVGw6XuB58ZWV8wDVge9oSkB0ps5stc4AZ7hU9iZsON5WSrZXoefMJF83GMpCJO7qdjKDmmLBwJK5kieIB+5x+iuosW2YAh1XiSWPE0P/mInw9IvqMDipK/Y6cTrqnbZInGPXXPjX73+rOpECOhCFfK2/gFwmg7+2VoPuty6cdX0b5/4uFiDpYRMmKtGD7f9oo3qegJ1tOhJgDoYeRg9nOfLaDU+iC62PQu7SoH2Xu2wBUgWhxZLfTmbJXougSsOYhmXnDq8YSSxDaeluWVfC06iCF0KQfWaSVZJDVPWisLx1cKKZhI5z7ERYTGadKY24Gw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB8179.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YXJTT2pqVThBaTY5NXErM2gzZDZBL0Vvem9yQ0g2YVQwQXZLQzBJcVVFMFQr?=
 =?utf-8?B?aTJnRHpMOEJ4M0pWL2RYYUVDMmlMVnpaS0xHa21mTmtGR01EOTV6cVg5b25u?=
 =?utf-8?B?TWEyeEZzdHBaSUdCV0EvRmNqOENaWXBqZU95ZVFjdm0wZVZTM2c2UUgzRmgx?=
 =?utf-8?B?eEZBM1ZRYzNHTWduOEtqVlVtY05QRW5hRG5GWDRLK1pGcWlnb3BDcGF1MS9h?=
 =?utf-8?B?V3l1d0hJNFRFSUVlNHdxQkRSUXBoZ0oyNUIyT0JmclNEeGtNOFlNaWRMcmJG?=
 =?utf-8?B?TTJZOVhqbDByRFdXekxCeVl4MXUxL2dTcmxLbE9GUExZZ2JUTFhYeGYvQnVS?=
 =?utf-8?B?N0h2WDNMWnNQaUtIS2cvWk9rb1NLb2h0WGRreTg4bExaeGExZTZNRDV5WUcr?=
 =?utf-8?B?Z0JXT1RHTG16d2JlZnJ0ZGtsVGRpMFhCV2lBUmZ5cjdKNFJ3aGd4Mmh5b1g0?=
 =?utf-8?B?bUVrQ0ltTlRkZTVMbUF4NGRJYnZ2b2tHdG1vRU5mNWhRT1dxZThtc2xmck9z?=
 =?utf-8?B?OTFlVWZ6L3ZVTDgzSktnUTY4S2ZqbGtpeGV2ZUZ6OE9PaTQxY0p3WEJGSm5z?=
 =?utf-8?B?U0pnNExsQ3pLdVY0MHFzdzQ2SjZJUUxRandnM3ROMUFyenBBRVBhdzFDOEpS?=
 =?utf-8?B?RDJUdFhkdlFPeHBTQ0QyU2c0QnAyNUNqd1Jqc3dodjh4N1k2YTVMUXh4Sm44?=
 =?utf-8?B?SjBQaEYvVnJlSHRvZE1VM2UyU2ljQ1ZEQ2t1Y3Bja1hHd1RJendXbDhHR3ZI?=
 =?utf-8?B?N3ZQdHdHNEZ0dlBQVGJHM3Vwb05zVzkxZXVPbDJrVjdEd2VCb0JhTVIwM0Vn?=
 =?utf-8?B?bndCWDEybnVEcDFLSjcrbE1ML21icVNndW9BYnlMZFpxanp5U3JDUHh3Yk9p?=
 =?utf-8?B?M0paQU5XV2UwR1l3bE00cS8wTjJYZEhMYUxyU09WV3lPUU5DcDAyYWZUZTZ2?=
 =?utf-8?B?TFV2cXFLRXNVWklvT2h5bUU1aWFVNWNJRE5IcVNnckZxeG1ya0dtczhkcFJQ?=
 =?utf-8?B?T2JoWDJqa3BKWkRLeE9OZlJCdjRiZzJTUm9MQXBhVEs3UHMxMlhBZFN5bmFs?=
 =?utf-8?B?aVFEVHFXUzdJbHRCS1lvU0pGWUZvOEJNSHJFazhKRnFZL01ONjVLcWtNcC9x?=
 =?utf-8?B?eXltekZieFVSNHkvcDlBcXVvKzhuOUxWTjNiQTZ5Uk5NdVBxbi8yQTlpeFdY?=
 =?utf-8?B?M0l4a0FEcTlIVlpvcmJZdmVjQVUwWmtTbXFCYXV5K21rU0RWRlJHamoxMXlC?=
 =?utf-8?B?am1ldmtzWFBIZEo4RzAzZnFKTXlHQ2xHMHpWUFNrYVhLdlJQMlV6Mkk2ejFa?=
 =?utf-8?B?NXRIY3YvK1RxWkttdG5uUnlWQWlhMHNMYlE2bm0yZWtTZ0VqTXNNaUp4OXJQ?=
 =?utf-8?B?M3RNY0NtZ2lLSXVOYWhPVjZheFVZZnZ6R1c1cjl1QzdETTdnRzlKSnpNRGpR?=
 =?utf-8?B?V0ZiODRLbUpxcmtyQ2p3VmdnL3FyRjQwckVndjd6UzFPSFFJUzh2bDlTenl4?=
 =?utf-8?B?WkY1VDVxY3lBK2ZhNzd4Q1M3cXI5aXptMEZQYm82d1Btb2plZkNscGVmUkFu?=
 =?utf-8?B?K3JFN21ERVVaTzFXSGtUbkhWd0hMNndtL0FJdmVQb21Lb1Nac2Q4aTZvMFJn?=
 =?utf-8?B?U0JTZk9LUDJIbTlkSkhiMmlsR3FUMGtsR0laYnBSQTZ6dXU5WDhFZlZaVTIv?=
 =?utf-8?B?S3FaTG9yUUx6TmEyM2dkem81RmsxTWwvbUphbmNEZFRvdG5yUnpDS2o5TWpQ?=
 =?utf-8?B?cDdhT0MrcnE3M2VkOU9pR0dHT21pQkdmbnZVYkdIYzJJb1Z1bHFVa1RibEls?=
 =?utf-8?B?TWtaTEFEN0NhK1hEVzJWRWhBWkpYUWUxRW9VK2lPQzZtQndUSnBRMVRxZXN2?=
 =?utf-8?B?ZGlsem5HV3hXM0wrWWdtdGF1SStkUmZraFI3YzZ0c3J6SHZid3M1T3VuaUY2?=
 =?utf-8?B?cXorbjRDN3M0cHo1a1ozc0IrY1ZicTN0SzE2RGljU0dLZVpjZndPZ3dnWVNI?=
 =?utf-8?B?TitBYlplSzBObHUvMDAvMVlmdTNwYlVXTElqZWFRZkN5bjFlcGFKQUQwYnB1?=
 =?utf-8?B?bUlRaVI2UkpPRVZpRGxGQTExeUxWb0pJRW16WUZCUEVveEJFRCtCYW8yNGdQ?=
 =?utf-8?B?MlBuR2ZTQUVDSWJuT1pJYm9SbVVodFJGZ3RtRTRqWEVOSFZXcG5NUzg5RHE4?=
 =?utf-8?B?dWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <86C3E6B7924DB04A8BBB23260D947D9A@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB8179.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a82cf19-36c3-4af7-359d-08dc385eeefc
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2024 13:12:36.6900
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8BfgFESRuho38BV+K/1lRLofA4zDAb7zAl5FDew0vUwEg62mz8o6xhyKijcaNGTZ+cEmLkvRmGO9sjdpvUtOXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7762
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI0LTAyLTI4IGF0IDEzOjU2ICswNTMwLCBNdWtlc2ggT2poYSB3cm90ZToNCj4g
DQo+IE9uIDIvMjgvMjAyNCAyOjMwIEFNLCBKb3PDqSBSb2JlcnRvIGRlIFNvdXphIHdyb3RlOg0K
PiA+IEFkZCBmdW5jdGlvbiB0byBzZXQgYSBjdXN0b20gY29yZWR1bXAgdGltZW91dC4NCj4gPiAN
Cj4gPiBDdXJyZW50IDUtbWludXRlIHRpbWVvdXQgbWF5IGJlIHRvbyBzaG9ydCBmb3IgdXNlcnMg
dG8gc2VhcmNoIGFuZA0KPiA+IHVuZGVyc3RhbmQgd2hhdCBuZWVkcyB0byBiZSBkb25lIHRvIGNh
cHR1cmUgY29yZWR1bXAgdG8gcmVwb3J0IGJ1Z3MuDQo+ID4gDQo+ID4gQ2M6IFJvZHJpZ28gVml2
aSA8cm9kcmlnby52aXZpQGludGVsLmNvbT4NCj4gPiBDYzogTXVrZXNoIE9qaGEgPHF1aWNfbW9q
aGFAcXVpY2luYy5jb20+DQo+ID4gQ2M6IEpvaGFubmVzIEJlcmcgPGpvaGFubmVzQHNpcHNvbHV0
aW9ucy5uZXQ+DQo+ID4gQ2M6IEpvbmF0aGFuIENhdml0dCA8am9uYXRoYW4uY2F2aXR0QGludGVs
LmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBKb3PDqSBSb2JlcnRvIGRlIFNvdXphIDxqb3NlLnNv
dXphQGludGVsLmNvbT4NCj4gPiAtLS0NCj4gPiAgIGRyaXZlcnMvYmFzZS9kZXZjb3JlZHVtcC5j
ICB8IDIzICsrKysrKysrKysrKysrKysrKysrKysrDQo+ID4gICBpbmNsdWRlL2xpbnV4L2RldmNv
cmVkdW1wLmggfCAgNiArKysrKysNCj4gPiAgIDIgZmlsZXMgY2hhbmdlZCwgMjkgaW5zZXJ0aW9u
cygrKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2Jhc2UvZGV2Y29yZWR1bXAuYyBi
L2RyaXZlcnMvYmFzZS9kZXZjb3JlZHVtcC5jDQo+ID4gaW5kZXggZTk2NDI3NDExYjg3Yy4uMjg1
N2NlYjNlYjNhYSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2Jhc2UvZGV2Y29yZWR1bXAuYw0K
PiA+ICsrKyBiL2RyaXZlcnMvYmFzZS9kZXZjb3JlZHVtcC5jDQo+ID4gQEAgLTMyNiw2ICszMjYs
MjkgQEAgdm9pZCBkZXZfY29yZWR1bXBfcHV0KHN0cnVjdCBkZXZpY2UgKmRldikNCj4gPiAgIH0N
Cj4gPiAgIEVYUE9SVF9TWU1CT0xfR1BMKGRldl9jb3JlZHVtcF9wdXQpOw0KPiA+ICAgDQo+ID4g
Ky8qKg0KPiA+ICsgKiBkZXZfY29yZWR1bXBfdGltZW91dF9zZXQgLSBzZXQgY29yZWR1bXAgdGlt
ZW91dA0KPiA+ICsgKiBAZGV2OiB0aGUgc3RydWN0IGRldmljZSBmb3IgdGhlIGNyYXNoZWQgZGV2
aWNlDQo+ID4gKyAqIEBzZWNzX3RpbWVvdXQ6IG5ldyB0aW1lb3V0IGluIHNlY29uZHMNCj4gPiAr
ICoNCj4gPiArICogSWYgZ2l2aW5nIGRldmljZSBoYXMgYSBjb3JlZHVtcCB0aGlzIHNldHMgYSBu
ZXcgdGltZW91dCBmb3IgY29yZWR1bXAuDQo+ID4gKyAqLw0KPiA+ICt2b2lkIGRldl9jb3JlZHVt
cF90aW1lb3V0X3NldChzdHJ1Y3QgZGV2aWNlICpkZXYsIHVuc2lnbmVkIGxvbmcgc2Vjc190aW1l
b3V0KQ0KPiA+ICt7DQo+ID4gKwlzdHJ1Y3QgZGV2aWNlICpleGlzdGluZzsNCj4gPiArCXN0cnVj
dCBkZXZjZF9lbnRyeSAqZGV2Y2Q7DQo+ID4gKw0KPiA+ICsJZXhpc3RpbmcgPSBjbGFzc19maW5k
X2RldmljZSgmZGV2Y2RfY2xhc3MsIE5VTEwsIGRldiwNCj4gPiArCQkJCSAgICAgZGV2Y2RfbWF0
Y2hfZmFpbGluZyk7DQo+ID4gKwlpZiAoIWV4aXN0aW5nKQ0KPiA+ICsJCXJldHVybjsNCj4gPiAr
DQo+ID4gKwlkZXZjZCA9IGRldl90b19kZXZjZChleGlzdGluZyk7DQo+ID4gKwltb2RfZGVsYXll
ZF93b3JrKHN5c3RlbV93cSwgJmRldmNkLT5kZWxfd2ssIEhaICogc2Vjc190aW1lb3V0KTsNCj4g
PiArCXB1dF9kZXZpY2UoZXhpc3RpbmcpOw0KPiA+ICt9DQo+ID4gK0VYUE9SVF9TWU1CT0xfR1BM
KGRldl9jb3JlZHVtcF90aW1lb3V0X3NldCk7DQo+IA0KPiBXaHkgZG9uJ3Qgd2UgcHJvdmlkZSBh
IG5ldyBleHBvcnRlZCBmdW5jdGlvbiBsaWtlIFsxXSBhcyBjYWxsaW5nDQo+IGRldl9jb3JlZHVt
cG0oKSBhbmQganVzdCBhbm90aGVyIGZ1bmN0aW9uIHRvIGNvbmZpZ3VyZSB0aGUgdGltZW91dA0K
PiBkb2VzIG5vdCBsb29rIGdvb2QuDQoNCnNvdW5kcyBnb29kIHRvbywgdHJpZWQgdG8gYmUgbGVz
cyBpbnRydXNpdmUuDQoNCndpbGwgd2FpdCBmZWVkYmFjayBpbiB0aGUgZmlyc3QgcGF0Y2ggdG8g
c2VuZCBhIG5ldyB2ZXJzaW9uLg0KDQp0aGFuayB5b3UNCg0KPiANCj4gWzFdDQo+IA0KPiBkZXZf
Y29yZWR1bXBfdGltZW91dCguLi4sIHRpbWVvdXQpOw0KPiAgIF9fZGV2X2NvcmVkdW1wX3RpbWVv
dXQoLi4uKTsNCj4gDQo+IGRldl9jb3JlZHVtcG0oLi4pDQo+ICAgX19kZXZfY29yZWR1bXBfdGlt
ZW91dCguLi4sIERFVkNEX1RJTUVPVVQpOw0KPiANCj4gZGV2X2NvcmVkdW1wdigpDQo+ICAgX19k
ZXZfY29yZWR1bXBfdGltZW91dCguLi4sIERFVkNEX1RJTUVPVVQpOw0KPiANCj4gZGV2X2NvcmVk
dW1wc2coKQ0KPiAgICBfX2Rldl9jb3JlZHVtcF90aW1lb3V0KC4uLiwgREVWQ0RfVElNRU9VVCk7
DQo+IA0KPiAtTXVrZXNoDQo+IA0KPiA+ICsNCj4gPiAgIC8qKg0KPiA+ICAgICogZGV2X2NvcmVk
dW1wbSAtIGNyZWF0ZSBkZXZpY2UgY29yZWR1bXAgd2l0aCByZWFkL2ZyZWUgbWV0aG9kcw0KPiA+
ICAgICogQGRldjogdGhlIHN0cnVjdCBkZXZpY2UgZm9yIHRoZSBjcmFzaGVkIGRldmljZQ0KPiA+
IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L2RldmNvcmVkdW1wLmggYi9pbmNsdWRlL2xpbnV4
L2RldmNvcmVkdW1wLmgNCj4gPiBpbmRleCBjOGY3ZWI2Y2MxOTE1Li43MGZlNzJhNWM2ZDM2IDEw
MDY0NA0KPiA+IC0tLSBhL2luY2x1ZGUvbGludXgvZGV2Y29yZWR1bXAuaA0KPiA+ICsrKyBiL2lu
Y2x1ZGUvbGludXgvZGV2Y29yZWR1bXAuaA0KPiA+IEBAIC02NSw2ICs2NSw3IEBAIHZvaWQgZGV2
X2NvcmVkdW1wc2coc3RydWN0IGRldmljZSAqZGV2LCBzdHJ1Y3Qgc2NhdHRlcmxpc3QgKnRhYmxl
LA0KPiA+ICAgCQkgICAgc2l6ZV90IGRhdGFsZW4sIGdmcF90IGdmcCk7DQo+ID4gICANCj4gPiAg
IHZvaWQgZGV2X2NvcmVkdW1wX3B1dChzdHJ1Y3QgZGV2aWNlICpkZXYpOw0KPiA+ICt2b2lkIGRl
dl9jb3JlZHVtcF90aW1lb3V0X3NldChzdHJ1Y3QgZGV2aWNlICpkZXYsIHVuc2lnbmVkIGxvbmcg
c2Vjc190aW1lb3V0KTsNCj4gPiAgICNlbHNlDQo+ID4gICBzdGF0aWMgaW5saW5lIHZvaWQgZGV2
X2NvcmVkdW1wdihzdHJ1Y3QgZGV2aWNlICpkZXYsIHZvaWQgKmRhdGEsDQo+ID4gICAJCQkJIHNp
emVfdCBkYXRhbGVuLCBnZnBfdCBnZnApDQo+ID4gQEAgLTkwLDYgKzkxLDExIEBAIHN0YXRpYyBp
bmxpbmUgdm9pZCBkZXZfY29yZWR1bXBzZyhzdHJ1Y3QgZGV2aWNlICpkZXYsIHN0cnVjdCBzY2F0
dGVybGlzdCAqdGFibGUsDQo+ID4gICBzdGF0aWMgaW5saW5lIHZvaWQgZGV2X2NvcmVkdW1wX3B1
dChzdHJ1Y3QgZGV2aWNlICpkZXYpDQo+ID4gICB7DQo+ID4gICB9DQo+ID4gKw0KPiA+ICtzdGF0
aWMgaW5saW5lIHZvaWQgZGV2X2NvcmVkdW1wX3RpbWVvdXRfc2V0KHN0cnVjdCBkZXZpY2UgKmRl
diwNCj4gPiArCQkJCQkgICAgdW5zaWduZWQgbG9uZyBzZWNzX3RpbWVvdXQpDQo+ID4gK3sNCj4g
PiArfQ0KPiA+ICAgI2VuZGlmIC8qIENPTkZJR19ERVZfQ09SRURVTVAgKi8NCj4gPiAgIA0KPiA+
ICAgI2VuZGlmIC8qIF9fREVWQ09SRURVTVBfSCAqLw0KDQo=

