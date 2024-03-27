Return-Path: <linux-kernel+bounces-122137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5232C88F29A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 00:01:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C8DF1C2CDFC
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 23:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A570152534;
	Wed, 27 Mar 2024 23:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UCykkP+q"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E0512E5B
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 23:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711580484; cv=fail; b=Ebt3IVCJMywx8zaqFrbvWtLr91nVq7Vtl2Fozg3aekpqMnrWxjr6WdN6JszMN+UyF/H/n15+NW51etk/wu1YbbT13ibKRCbImvMUWBNv+EoaildWYm5rgMnn5aju/XjcjoF/ytw54Lm0uV+kdI/weLS1h16BCQWUMlQK/N3eCUM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711580484; c=relaxed/simple;
	bh=dXSmVY4qdbqzxtt+iLJflj8vJ7DzaySVhaMOAqlhbZk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=n1e6Ib8DBq9UKrSM3Uq8d23AhR/Yn8XGZ6Lu4EgPRGeo/7Cnb4q/IhufETDQsnz7VCSzmhsK174zdLF/io6YxwkL83DUQ0gNdzpBhpRGQmgFO/wgLmQcWDubEzBCjwjH0XUhAFQQxg4e97lmZ/6LctwcRSyqRPJwPD6zpH5ZMWw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UCykkP+q; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711580483; x=1743116483;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=dXSmVY4qdbqzxtt+iLJflj8vJ7DzaySVhaMOAqlhbZk=;
  b=UCykkP+qPFibO0jAju4y+bb4aYJ/4yaOnmxDEZM6B1qvJVwbVdjZaLdE
   giWVsYiFx1p19j73IsPHT+q2IU8hIXUhVPC/tvDAipCt1EemKB5p089xu
   ve4mW3BS+TRei8P0W43U3M5vwVEgPmiDmHi0ADEfBE4NOqQNbqcE0Gj72
   /+4GTfdTcS+HsPUK2o3ISut6/ZwMe0yHLjuYbX5+SWpdUku/ypt4pjm3L
   dGPXUpRbvQ6++zIEZ0od8bhi2gy/siGXHwsVoNMnaSd2Vk3lA21071VV1
   RnQ9U7p4GBVlraeYBZz426OvyKsYf7KlBjb6GrDDIFlrgO9+uappMZA3Z
   g==;
X-CSE-ConnectionGUID: dp8+JlOBT4uvHcL7guVklQ==
X-CSE-MsgGUID: FaC1Uvc8Se2b8tbkKhax0w==
X-IronPort-AV: E=McAfee;i="6600,9927,11026"; a="6541856"
X-IronPort-AV: E=Sophos;i="6.07,160,1708416000"; 
   d="scan'208";a="6541856"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2024 16:01:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,160,1708416000"; 
   d="scan'208";a="21167688"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Mar 2024 16:01:15 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 27 Mar 2024 16:01:15 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 27 Mar 2024 16:01:15 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 27 Mar 2024 16:01:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fE8P8ZERBuoOHLI0iPSNXhRI6R9Kg77x0OYiPRi/+KsmU8I0i33j3OnbrXYEv1E3dVk+NJJw8P7MX8JibiFJNJDYlyyCC3dbxdu+30z00vhMMx2BdtX7hyJ2UeQ3MwJN+Fb++qJEoHXNl8L58J3RxbThoQERDX6MrJXFyB5ykAFuDEOijj9DSUSGmwKPQT2SplppfzY/mOgT907KA95YAD+TlLENcXfgwD40HNfvTTbgAAHFvGgXvm9EvXDjxjSha7FmRRylVdf3J1888TWy5YOcYyM/tHKRuU64E4GVqLI+1+Z3Y7l7aLqMpV3lQ8mEi04jYbXVt3KM5iOffixJhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dXSmVY4qdbqzxtt+iLJflj8vJ7DzaySVhaMOAqlhbZk=;
 b=CRHXcoeJkSY0VTe6efIYwiB3XIw1h/MmOZnzlrsnRRNZjm8Yw64qt3nmA7N1aCQyN7ftS+/K0v+Y86mEaKtHxpnWabgVKnZM5Pp1Bkr7Ldt9CKk9MdZ0CA3uEd6/Us3oVcJBfAQLz/EX2rby7QAR8+XUZ8UQHyaMZafqy4IzFTXW6qXicS42KPCEyuJSBQiaZPn8L6nimNAkBXK6xo+sNQEeXLBn0U/TSSymmf3ymZ2bg5H8oN06WNnxKMLOL9YkFTV1MVp4MMZlLkmpKqWUvThAWpw0SNVz29NuFYME0QeqpTpqlU4kuBPvxFFuEZx/nttzBtR7JVhF0HoCtcyneg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by BL1PR11MB5979.namprd11.prod.outlook.com (2603:10b6:208:386::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Wed, 27 Mar
 2024 23:01:10 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::fca9:7c00:b6d0:1d62]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::fca9:7c00:b6d0:1d62%5]) with mapi id 15.20.7409.031; Wed, 27 Mar 2024
 23:01:10 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: "Chatre, Reinette" <reinette.chatre@intel.com>, Borislav Petkov
	<bp@alien8.de>
CC: "Yu, Fenghua" <fenghua.yu@intel.com>, "Wieczor-Retman, Maciej"
	<maciej.wieczor-retman@intel.com>, Peter Newman <peternewman@google.com>,
	James Morse <james.morse@arm.com>, Babu Moger <babu.moger@amd.com>, "Drew
 Fustini" <dfustini@baylibre.com>, "x86@kernel.org" <x86@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: RE: [PATCH] x86/resctrl: Fix mbm_setup_overflow_handler() when last
 CPU goes offline
Thread-Topic: [PATCH] x86/resctrl: Fix mbm_setup_overflow_handler() when last
 CPU goes offline
Thread-Index: AQHagHcYKBtWIGpjwEScEcO4Mpl3nLFMLbiAgAAF+iA=
Date: Wed, 27 Mar 2024 23:01:10 +0000
Message-ID: <SJ1PR11MB6083F3AB8069CCDC7DB5004BFC342@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20240327184619.236057-1-tony.luck@intel.com>
 <c53d6abd-5dbe-4edf-89c0-abbea0df1f1c@intel.com>
In-Reply-To: <c53d6abd-5dbe-4edf-89c0-abbea0df1f1c@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|BL1PR11MB5979:EE_
x-ms-office365-filtering-correlation-id: e4753bf0-c388-4dbd-baa2-08dc4eb1cb37
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2t9qVH7S68BNdwtzyCCYbo2jLhch9BSL+ani1Ixa+/rgSq2aJXqblcN4z3grpNQAsPbz6cTReQMkkMQhdhEvnxylZcLmwTCtUDEFwInZWe5fAh46T5m2aTpIkO2dQu2tZfmf/w1P7ID4tFJs2BGUOVwl1UnHsfjVy2CWRaLTF+/VNo4uoih2uichcZEvVSNQqgHm8xSTMK9H9O45AJpTaZy1UTVYbk/JrCrJBgTIQ0mxXabkAkMVWH0XXahQ9NUA/biBT2efyO2ma89kP8+WtsIIM/o4XSFDGWXKu5GUeSEpyiDeVmUYH6ddUwYd1PZQ1ckXxZLsNL+39dCb+TmVCe4msqHlBEp6y25UL5+vUoDSVKwMeL3CXJElXewFKAtFJUvWwhp33SZy31GeJDLhbV2YKvJ/RTmJxQcSw4//nO7tmIGzUnGsHDredi1F4sUf4gLOSK2CdZRLiu3d+R26zDlyDODbVofosJGKiBRMg8uQvHGa7/QnK94ztSF9Vu+NRcPBwfdyOtR4RdNR2ZxS1s/tnnTRkgERq467BvKQgxXUBYpcpOTISzRBVYSuMbDaseYclU42ias6X/d0aMC8NKyr0fTjI707aetWqHccBhN/DtqISt0OXxkOvrnBKbzXaYX9dM/0Tx0tOogtXFLUJvn1nwPlzMh9C2aO4Par/h07orvM8PyHsJ/nc4cnVRD8YqdXmBBHPEbqZ00Ilncxs3oBWm/3eXOBPZERsOoneS8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c1g4MWhacmhJQi81Z3E0R0FnamhqNHp2OGJyMEJRbXg5WThDL3B1akdJK3JN?=
 =?utf-8?B?Ym5FSElSa05wWkVad1hOTEh3dnJ1a0JaeDhlR2tSeTBOd0xmRE9zRnozTTZG?=
 =?utf-8?B?eUg4VFYxY2xCTlRsL1h6M0VyUUtERmJQYllwZlRXa2NRWVdVYjVFanZOTmNn?=
 =?utf-8?B?TTZHODBDRmJlQkRoTFJlSnBqTlg1UzdRUTlZVkVQM1Y5c01TNzFkOFpEdkZH?=
 =?utf-8?B?TkZCemlQU2xlcDRhL3ZlTlZjcjJudjlmUVZFV3NUY0JoNXpWL1MybUpld2J2?=
 =?utf-8?B?Q3c0L3NULzRmelhZOWRwMUpkYmFsQUNSZTJkYzREdEgraUtEZ2JuNmd5Yity?=
 =?utf-8?B?amR4SkZQb0MxQmVVWk0rcmdYbHJJQ0RBZ0Q5M0pPb2VSVE9FRTJENnM3cXMw?=
 =?utf-8?B?STg2YjJqRFJZb1hXU2I1NGoydEYyQzNjd2ZuYUI4Qm9jdFo3dkhBcXdVNU9P?=
 =?utf-8?B?WlJyRllnZHcyVmttNW1rWk1PRjlkZDVyUnF3dk9tRlo4c2xWOEtHT3pCNHZj?=
 =?utf-8?B?cnZpQWZNaHozZC9aQmY0VEpRa3ZINU1ucjh1d1QzZGdmVWxCbWpISzMwb0I2?=
 =?utf-8?B?aFc0dll0amZIeHRiUy9RMWcwamhFeFVWWXRrblBNR1V4cUl2bkhjRTc0MmEr?=
 =?utf-8?B?cWhva1JpdTVkZ3MvSEZObzFMZWl3NU8wODJNSU16SlRYQkswY3VzeWI0SStK?=
 =?utf-8?B?d3FtRWpFcjZCRFlYcUVtbnBMRFZJeE9Jd2R1akZoenJXMHBURTFzTzRLS21P?=
 =?utf-8?B?NDJGKzc1c3BTWWpJQklWaHJ0T21FL2NwM3kzWHpNU2tZK0NaRjVIRVlFdFV2?=
 =?utf-8?B?OFBFdTJCRGs2RlQyNDRhSTJkRVRQZHFCMzloZDdiM0pUcVEvWFFoQnZVTGt2?=
 =?utf-8?B?bkJpajlFWGJnWjZGR1RmNHh0aDl0K0Z2VnVEZ1RxQklwUWJJM2h0ckNCYzlI?=
 =?utf-8?B?QTBmcGdFbnZBZkFUbnlwNVlRQmVIU3UzRDVPRmxkL0hYbEl3YUkvRVJUemc1?=
 =?utf-8?B?b09wei9GUjNKOTJDMnVIdVhIMExaZm9uU1cyQmQ1Y2FhUHFRQ1dVZytnMm9I?=
 =?utf-8?B?VG1qUzdNYzhsVHM0c25VVUl2WlFOVGpndDViVEZMeEhxTGErN2xnbk1UM0dp?=
 =?utf-8?B?MnAvV24xTmc0dEJZdVIrZ0l1Z2pZQUtjSDY0dXc3YmsvZWp5RmFldnVtOUlz?=
 =?utf-8?B?TkxzNzlINjM2dnhiSVBIb21zeVRKVW5zMmNOOTF2ZnpYYVl0MkFrM21ORVBL?=
 =?utf-8?B?RCs0V1k5aWlYQ1k4ZFRyM0F3clFnSHg1UVJBajhUdGVNamhLOGFWdHBEMktr?=
 =?utf-8?B?QnduanpYRURFcmpOV3ZuR1Jaa3JyalVXT0FCRk8xMGU2eEdTZ1VsaWljUUVs?=
 =?utf-8?B?UkxuN3I4Mk50VlIzODlhTUhvOXptaWM1NzNGWHdzT3Qrc2J3elYyQjBmam5W?=
 =?utf-8?B?OEF4RW1rM3dJMFhkdENRR1VXWW5EMDgxcGx6MVlNSDNPOStnWU5CbVhpN3Fl?=
 =?utf-8?B?RGI4N0pjaEozVFdZN0ZQYWJKRkhZeEg0WjRhN2RNYzJxMXRFRkpwUzRybkdh?=
 =?utf-8?B?cE1PMkhkeG84bFkxZDJvZEZtanQ5a21JUHRmWjM2VytRQitXMnYwZzJXT0o1?=
 =?utf-8?B?TUVRZ0VtZCszNnQ1dkhhUUtJbSt0dllpRGVpOFgyL3dXRUFvL2RrWjBScTB4?=
 =?utf-8?B?YlVweFNRSTk4YlN4WUVwUnBRUFpWWUltdGVSWEtnOWYwd2dwcUF0OUxnak5N?=
 =?utf-8?B?Yll1RXN1M1o0anp0U3o2Z1ZoR2s5ejl4MHRWenlSSHRMemZaRDRiWXE1K2ZS?=
 =?utf-8?B?MGZhdSs1ZjczQ0IrUFE2cVpDWXB2ZVUwRHllazlrVXdLWlhOc3VMUGtud0lv?=
 =?utf-8?B?YWJRNm5kZEEzeTNQR0FkZHhJeXBkd25BSXhkUG95emh6SnFKSStFQUh3UEtU?=
 =?utf-8?B?OWcwMndYTy9nRU9ZVFV3TE1qaTVvczNleUxCRXNDc3MvYUJnNitBTmNpa0Nn?=
 =?utf-8?B?THdLOVZmQ1kyb1Rxdmt1NDVkMFduamVTK2ZPYW9VaTBPTTVUa1l0QUszQTZH?=
 =?utf-8?B?NjBmM3dOeVBiUnJpbDNMVTF3UGg4YWtaSUE3WFMxWDFxdUova1VyQWlSTytx?=
 =?utf-8?Q?+56yzyRxKzg63NdebSjCy7VN7?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e4753bf0-c388-4dbd-baa2-08dc4eb1cb37
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2024 23:01:10.5195
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ew1nauf3ZsIRAKKxY1dRQxLMhqqip/bn5+R006Nj1IMyTokAemcrP/gcxiem/6h29ozPBddzzrSVJWpxHTfTZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5979
X-OriginatorOrg: intel.com

PiBUaGVyZSBzZWVtcyB0byBiZSB0d28gaXNzdWVzIGhlcmUgKGFsdGhvdWdoIEkgYW0gbm90IGZh
bWlsaWFyIHdpdGggdGhlc2UgZmxvd3MpLiBGaXJzdCwNCj4gaXQgc2VlbXMgdGhhdCB0aWNrX25v
aHpfZnVsbF9tYXNrIGlzIG5vdCBhY3R1YWxseSBhbGxvY2F0ZWQgdW5sZXNzIHRoZSB1c2VyIGJv
b3RzDQo+IHdpdGggYSAibm9oel9mdWxsPSIuIFRoaXMgbWVhbnMgdGhhdCBhbnkgYXR0ZW1wdCB0
byBhY2Nlc3MgYml0cyB3aXRoaW4gdGlja19ub2h6X2Z1bGxfbWFzaw0KPiB3aWxsIGNhdXNlIHRo
aXMgT09QUy4gSWYgdGhhdCBpcyBhbGxvY2F0ZWQgdGhlbiB0aGUgc2Vjb25kIGlzc3VlIHNlZW1z
IHRoYXQgdGhlICANCj4gYnVyaWVkIF9fZmZzKCkgY2FsbCByZXF1aXJlcyB0aGF0IGl0IG5vdCBi
ZSBjYWxsZWQgd2l0aCAwIGFuZCB0aGlzIGNoZWNraW5nIGlzIG5vdCBkb25lLg0KPg0KPiBUbyBt
ZSBpdCBzZWVtcyBtb3N0IGFwcHJvcHJpYXRlIHRvIGZpeCB0aGlzIGF0IHRoZSBjZW50cmFsIHBs
YWNlIHRvIGVuc3VyZSBhbGwgc2NlbmFyaW9zDQo+IGFyZSBoYW5kbGVkIGluc3RlYWQgb2Ygc2Nh
dHRlcmluZyBjaGVja3MuDQoNCkdvb2QgYW5hbHlzaXMuDQoNCj4gVG8gdGhhdCBlbmQsIHdoYXQg
ZG8geW91IHRoaW5rIG9mIHNvbWV0aGluZyBsaWtlIGJlbG93PyBJdCB1c2VzIHRpY2tfbm9oel9m
dWxsX2VuYWJsZWQoKSBjaGVjaw0KPiB0byBlbnN1cmUgdGhhdCB0aWNrX25vaHpfZnVsbF9tYXNr
IGlzIGFjdHVhbGx5IGFsbG9jYXRlZCB3aGlsZSB0aGUgb3RoZXIgY2hhbmdlcyBhaW0gdG8NCj4g
YXZvaWQgX19mZnMoKSBvbiAwLg0KDQpMb29rcyBnb29kLg0KDQpUZXN0ZWQtYnk6IFRvbnkgTHVj
ayA8dG9ueS5sdWNrQGludGVsLmNvbT4NClJldmlld2VkLWJ5OiBUb250IEx1Y2sgPHRvbnkubHVj
a0BpbnRlbC5jb20+DQoNCi1Ub255DQo=

