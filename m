Return-Path: <linux-kernel+bounces-105609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 828AC87E171
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 02:00:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3260B280E78
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 01:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 091581643D;
	Mon, 18 Mar 2024 01:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KZKZbeCV"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9298012E5B
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 01:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710723623; cv=fail; b=PWAdM2HFPBYtfHTuaPP7Gf0bJ9t7ohUHjLZjP3grcifV1lrvug5tjtwR4fWFBmcmq7lE5b6sVAOiaFMGBbhp3BKylB0wdwc+z9mBJyfOSQE1C6PdFV3RLGknNDBQMellahuQ8KMn6feT480SSBfKJaN1YVRdfkhCcoSy0v1i9Ks=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710723623; c=relaxed/simple;
	bh=VEKA6WOzpt6HE1B8zOpPEvvvsBF0gEzTOeZGq9sCpnA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ju42qbUDbebTgC1c+eXBFRa0C9/XwN3mzRymjZ1Rj3VYTMXJRrfyRpKOlU/BZ9dXFfniaaLHTss9cSfyTwKJ1ajCLVXiiSf6YcE0lSupkqwAJ7SK7UzDU4kkp10ecK9KKu775DsEwZlFwnFmMgQT1KG6t4uhsrpvUv2b7qMHlRc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KZKZbeCV; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710723621; x=1742259621;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=VEKA6WOzpt6HE1B8zOpPEvvvsBF0gEzTOeZGq9sCpnA=;
  b=KZKZbeCVQZ3ygCjM/8E54jJr2U4rBE7lC0x1G8v6SiGswueN5A8VEtaA
   X92SRYYYOVOy3qH6LTrgxO1n7JiFFQNkTf2odgWsanEB8lH0f+vhSLoTW
   g6ILDUcsPvAs3XpqN35bG2vvX1iuQaDQ+7puhyG9ttl9rmGyOv8uJOZmW
   X0wrBdEiiLUl2lOFjJ4PCusuggPlfX6gPLltqNAdaNfBpbT/7WJzuNRgu
   CiHt4HQtVOTE9ElVF7Bz1C5vyXICxLN8lUX7wlNc7VfnVFe3LsEOTyGO5
   aRydpJ+56p5qUsyVOjxn7s8ks1l+ZwCrjq1p9vaOUFxiTNvP/hU3MjbRQ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11016"; a="8461104"
X-IronPort-AV: E=Sophos;i="6.07,133,1708416000"; 
   d="scan'208";a="8461104"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2024 18:00:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,133,1708416000"; 
   d="scan'208";a="17906052"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Mar 2024 18:00:15 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 17 Mar 2024 18:00:14 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 17 Mar 2024 18:00:14 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 17 Mar 2024 18:00:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L5AqsZqivhjaqw+XSBpxjR8v55sQHIRWvVOtAWRbO10u4SOKZpLa30fMg/DHtuJE/pT+JdgLYI5vEsQBr1vAcGQvu0EBtQ3Lve0oPLztSNQM0LR1S78IpkzLQC0S0YG3qxKNEXIxM9t/NayC7fkO8z0mtexTWqNcoQLOtGmjexhYgvtlLo6RcNm4I4edcYgHNRnNbjose9e3TOketES64fun8eH5wauvLc7tP4zaMGzHqBZSrHOlY5mzNsWwNNiH0bBVWtO0T0MpofvkCK9p+5LFsPUeVVQnn/Xq0gB7Jh1JLblIBcS+7S1yBFqX/Cb9uAg72Q9rXDQdFo9ryZ1pvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VEKA6WOzpt6HE1B8zOpPEvvvsBF0gEzTOeZGq9sCpnA=;
 b=igqOZuTYTO312AbDK/Uztpk57oqCqley+BSkBrqqXOHO49dZLmTvRaHTDgAsgfH7+gE3rwM6HaklemXZiujkVtJHKiJi7qar6yejxgViCtnRfpM/tGzw6MetxFTx48vRomzoe8tu3jIn3FnhE6TEdcwiRjfgpbUk5Qz7/p5YJw+YBlo58ohozo3DEskuFf2WOCrM86VXJNhgtiTWYYmAgbs2vnt0/gAA/+5b853y9a3aU8JGi6MIEzW7xdZRKAlXeWId6Bvw2m549FXNqsU05TgMlSEwyw7eYzb/5L7iS7MHjwU1BptzkhHGob0DbYToLn8oN57OR4yZuBHEJqkp7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by SA1PR11MB6941.namprd11.prod.outlook.com (2603:10b6:806:2bd::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.11; Mon, 18 Mar
 2024 01:00:12 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::1761:33ae:729c:a795]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::1761:33ae:729c:a795%5]) with mapi id 15.20.7409.008; Mon, 18 Mar 2024
 01:00:12 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "debug@rivosinc.com" <debug@rivosinc.com>, "luto@kernel.org"
	<luto@kernel.org>, "x86@kernel.org" <x86@kernel.org>,
	"Liam.Howlett@oracle.com" <Liam.Howlett@oracle.com>, "broonie@kernel.org"
	<broonie@kernel.org>, "keescook@chromium.org" <keescook@chromium.org>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "hpa@zytor.com"
	<hpa@zytor.com>, "christophe.leroy@csgroup.eu" <christophe.leroy@csgroup.eu>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, "mingo@redhat.com"
	<mingo@redhat.com>, "kirill.shutemov@linux.intel.com"
	<kirill.shutemov@linux.intel.com>, "bp@alien8.de" <bp@alien8.de>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "peterz@infradead.org"
	<peterz@infradead.org>
CC: "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 10/12] x86/mm: Implement
 HAVE_ARCH_UNMAPPED_AREA_VMFLAGS
Thread-Topic: [PATCH v3 10/12] x86/mm: Implement
 HAVE_ARCH_UNMAPPED_AREA_VMFLAGS
Thread-Index: AQHadMzkrqf7F0uN1U+4RKWWb1IklLE1YUsAgAB0HgCABuA+gA==
Date: Mon, 18 Mar 2024 01:00:12 +0000
Message-ID: <6456ae066e6f209f38c01737cd707e54c5f3bd36.camel@intel.com>
References: <20240312222843.2505560-1-rick.p.edgecombe@intel.com>
	 <20240312222843.2505560-11-rick.p.edgecombe@intel.com>
	 <887b3a3a-e4b6-4b0a-abea-bb47a593d9cc@csgroup.eu>
	 <14a2bc3add91981fe2f9d51d2b25507dc1c69131.camel@intel.com>
In-Reply-To: <14a2bc3add91981fe2f9d51d2b25507dc1c69131.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|SA1PR11MB6941:EE_
x-ms-office365-filtering-correlation-id: e061ec7d-c2fa-4fc3-c98b-08dc46e6c3ee
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NuDjkjOTuCSsXIuG+/aejnda5QEez6F/I1iNT+ejZFVWIulIDVKhSMRP5FVYjkJADMw4Ke+7kmGhx8R75X3HPYfhJzJxwg7Ht7IIg7Rg+hLfRLXjFnsN0ZVZxQTFGOX0HfChGgHU0CoOBBc7RWTVsJdG9wk2I1l+uigmMWnW+of/sT2TBa/MJqE6stNkdBo4SahjuAhh/CDvaT3Bku+HKhVvFc0Yk5x8Ajn9Ufat9UFRgPVrMvKAz3sPRWIeymh+IDenU70nyyFv2AXue2ziapBm4bbdlsFvIkLeL6emvnYx9tUXGB5mlD6hkLqI7vSqB1G/58K+3mN/aYt/1T+hUwvC94tKAdFsSAiTr7sqXVH3hOrMsVTAETPJluoEGcpZGRLs7TNSRjALRSm4TI1FWb/v8lzN/7tgpWrhYt5cWKknE+HUAln3YPZC+AT5lKFmqTitGZDXh6PXJV3U3XhI10z3yRAFcZLs8xwtT1bCzhUS39AvDNzm+nJeaHzycs2DuaOp43tqpw0CiFy58yOG5Pn6kKJd6iNjKTpVvc0g6H+nncewmsqUHExSzGcb44eqA7U5ZLVYAej6dgM09nuOmnzQR/n0ghJ0GMq5VZ/Nm70/6Ml5ElMhd/YPM17Xnolj8NcIztBshdXFo8Sf1oZRyzJ/8QCGgl+s1JDL2TYh+yozr0tlX+c9g4GhBNwHO6A2hSkQ9ihNBgDGyktRHIOcfExDolseugyj71udBn20zgI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(7416005)(921011)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TFMweDZOeElhM0tNRnFkNGxYYmhBTnVnRERmZXBUZkQ1WFFEZWJNN2l4aDlV?=
 =?utf-8?B?cjNlUUZMWWtidHFWajZObWd2QWE3Q214QVhhSWFQQWpsQ0REbmxhelJoVTNT?=
 =?utf-8?B?K3RuNmVsaGVWWk9HNHEwandob0xYSGVQNmNkMmZBamdNVm5HbW1Fb1lOc3ZZ?=
 =?utf-8?B?cEx5bnlWWUw2OE51NzdWQ29VaWp5KzhMRmZWejVhV2piNXhPNkwyOXJsdHRP?=
 =?utf-8?B?SC9BTDVIS25jL1ZrTFBkWkdjbUl6V0JnOEJ6OHFmeUYrdFd6TElkL25zMDZj?=
 =?utf-8?B?V0J3VzZDNm1GN3V4WnQ2Ny9NbjZHTElNMnV4aVZ6U0RGcXRhRnYrTGd6Wm5o?=
 =?utf-8?B?TVVmRTdiSlhUbEZUS0Y3aW5kQW55TDh1akdQaGw5K0lidTJNVVpOa01wVktS?=
 =?utf-8?B?eE1TU0tFZUU4TTdvbkZrQVZQU3Z3UzJFOGczSVRvaVVnTG92YzNNNkV0YjFZ?=
 =?utf-8?B?SGJEcEZPMzRaRjRXS0tPd0FoWENyUmgzTFZZZHcyVE5KcjgzNTd6K2ZjQzIv?=
 =?utf-8?B?NzlOd1BaMjNGUTB1RUF2VG1rM1VWWUVWMUJ0SW9lREtvYTJPMU9vb090K1d5?=
 =?utf-8?B?c3cwSWVPZ3dDNjJuUHQ5bUlDaVNmdkxMdGF2R3VMTDA3MUs4Y1pnVTlpNWJJ?=
 =?utf-8?B?NmU4QjhoQmwvZS9HTENVZzlwK3V6S0hoeUt4eU1RNnMvVWxUOE1WZ1JoQTQy?=
 =?utf-8?B?WWF6OG1rWWZaK1l2ay93R1FCUzV2UFB4dm80K2FUUXFXelNTMVlNTU5venpw?=
 =?utf-8?B?MWdiMjhodlNpblo3aUtXUDJ6VHZLQ3pYUk1YeFRCaG9ScWp6NXR5YjFJcDk2?=
 =?utf-8?B?eDZhOUNhQUR5Mi9jWFJQeE5PR1BHSGpSb0hDRnJhUUxCRU1KUUNOQndGL1pn?=
 =?utf-8?B?aERVdXFPVHJBS1pTaTJLdngyaGdPL1ZJamxMR2paaEJTcVNCU25OWVVkaitZ?=
 =?utf-8?B?TDFoM2JMWW9RYWpqdlI0TTJ6L21reXBIdDVZSTMrUHdlYW1EakYrbHdna2ln?=
 =?utf-8?B?ZlJrNWlram95MVBXMlpkbnkzSkdNa0thajdScXJRbFR1dVhjZS9SYzV0ZGxO?=
 =?utf-8?B?YitvUy95WndhSGZqZHdCd1ZWNUNHRUdEYnRYODlJV1ozd20wVTVFaGFpZ1dE?=
 =?utf-8?B?dnFDUkFQQzNScGdaSEdMRXR1cGNEVGFOTUoyWERDUkhmb1pWZWF0UWcrOHY1?=
 =?utf-8?B?U3liQXczOGh3MnN0dnFaUmdMWjJrZjB0T1o5YjNSMEw3ZFhneFhNd3NWQW1p?=
 =?utf-8?B?dk5zTUcwd2V0aEY4U3d6QnNodjNSMzFxR2xsR0RQQk1GZDM5cnFnamQzS05n?=
 =?utf-8?B?MnU2U0ZYZVpXaUtsT2s4L29IV0t3Tjhla1hCa0hGMmxJN0xMU3c3WXpVODVU?=
 =?utf-8?B?Y3Y3Y3RldWVYK3gxNTNVMTFlMHhjV3ZoVzFkZWV6MG9TMmorcDUrY3Vsd2dR?=
 =?utf-8?B?WnFBTEp2am00bkJmbG53S0ZkMzdkd1JZcEJBKzhzNVVXZ0p6Q0hFNDc2R2g0?=
 =?utf-8?B?N2dma05UV2htSVVGYUNpQnFJb0hlblFzMTVlMmdlZ2pjQy9VRWNPVFk4QVB4?=
 =?utf-8?B?anJwdDFJSWJqcmdXdlgvM1FGM0hVZityTzFNMlNTZ3IzMnppYnBKNitkRWJ6?=
 =?utf-8?B?Yldtbkw2dG0zMjBSUUVXV2JSRUFCOEZmTStxa3RPbGRmZlVTQUNDNnluVWtv?=
 =?utf-8?B?bXN4THQ3OEE5aFJmZE1HeG9XcVF4a00wRXMxSFRqOFFySHZRaHdHczF4bXZQ?=
 =?utf-8?B?RGJnSHdvcDkwODhYRm9taHBaU21FQllhenFmZGV4VXducUhyUFNNaitvc01Z?=
 =?utf-8?B?WG12dDF5RnlwY3NPY2lURW5EMjQ1ZENYclh4RFI4c0ZZN1hROFg2dy9zYkxL?=
 =?utf-8?B?eFM5aW9DSWVMNk9IRERqNXJSZm94WkRlU2cvc1BMU0F4ZUgrbzA3Q1J6Y3BB?=
 =?utf-8?B?ek8xSWw3MFhZaVNpM3FNYjZMNjRGZXVKUko1bzA3NVpmZVlVOFZvU05MMXAx?=
 =?utf-8?B?UEttWkdtbG82Qk1yZ3ZXbFdsWXdDQVVPcWFQZG10bitqbEE4U2pla2tLWmpW?=
 =?utf-8?B?YlNaelBsWUhtdzBoem1XeklZQTRrRzU3WXNWM0xkb2NacVJtcytoU1h3M21m?=
 =?utf-8?B?M3FYcldXYzVUU05PV1BST3Z4Y1U2akdqSjJqL0xHQVZVbFZJT2pBVGF6c3Ft?=
 =?utf-8?B?OUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2105F03BA397EE4E82AA5EC77A86D2B0@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e061ec7d-c2fa-4fc3-c98b-08dc46e6c3ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2024 01:00:12.2946
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wajP8gTYu8CMM+Y1ZAwFWoSdveFACKq+N43skIIJ3fidHAdcZ6f67in8FlLzD4K+IX5SZboa1czukvdLq8mTuFY4wf/nEkhYAwT801MMSwk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6941
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI0LTAzLTEzIGF0IDA5OjAwIC0wNzAwLCBSaWNrIEVkZ2Vjb21iZSB3cm90ZToN
Cj4gPiBXb3VsZG4ndCBpdCBiZSBiZXR0ZXIgdG8gZGVmaW5lIHRob3NlIHR3byBhcyBzdGF0aWMg
aW5saW5lcyA/DQo+IA0KPiBZZXMsIEkgdGhpbmsgc28uDQoNCkkgZ2F2ZSB0aGlzIGEgdHJ5IGFu
ZCBpdCB0dXJuZWQgb3V0IG5vdCB0byBmaXQgaW50byBhbnkgaGVhZGVyIHRvbw0Kd2VsbC4gSSBk
ZWNpZGVkIHB1dHRpbmcgaXQgaW50byBhIGdlbmVyaWMgaGVhZGVyIHdhcyBub3QgZ3JlYXQgc2lu
Y2UNCnRoZXNlIGFyZSBhY3R1YWxseSBzdXBwb3NlZCB0byBiZSBhcmNoIGltcGxlbWVudGF0aW9u
cy4gRW1waGFzaXppbmcNCnRoYXQgcG9pbnQsIG1tYXAuYyBhY3R1YWxseSBkZWZpbmVzIHRoZXNl
IHVubGVzcw0KSEFWRV9BUkNIX1VOTUFQUEVEX0FSRUEgaXMgZGVmaW5lZC4gU28gdG8gbWFrZSBp
dCB3b3JrLCBtbS5oIHdvdWxkIGhhdmUNCnRvIGFzc3VtZSB0aGF0IGlmIEhBVkVfQVJDSF9VTk1B
UFBFRF9BUkVBIGFuZA0KSEFWRV9BUkNIX1VOTUFQUEVEX0FSRUFfVE9QRE9XTiBhcmUgZGVmaW5l
ZCwgdGhlIGFyY2ggYWN0dWFsbHkgZG9lc24ndA0KaGF2ZSBhbiBhcmNoX3VubW1hcHBlZF9hcmVh
KCkgYW5kIHdhbnRzIGEgc3RhdGljIGlubGluZSB2ZXJzaW9uIG9mDQphcmNoX2dldF91bm1hcHBl
ZF9hcmVhKCkuIEl0IGNvbmZ1c2VzIHRoZSBtZWFuaW5nIG9mDQpIQVZFX0FSQ0hfVU5NQVBQRURf
QVJFQSBhIGJpdCB0byBtZWFuIHRoZSBvcHBvc2l0ZSBpbiBzb21lIGNhc2VzLg0KQWRkaW5nIGEg
QVJDSF9XQU5UU19VTk1BUFBFRF9BUkVBX0lOTElORSBzZWVtZWQgZXhjZXNzaXZlLg0KDQpBcyBm
b3IgcHV0dGluZyB0aGVtIGluIGFuIGFyY2gveDg2IGhlYWRlciwgSSB0cmllZCBhc20vbW11Lmgs
IGJ1dA0KYXJjaF9nZXRfdW5tYXBwZWRfYXJlYV90b3Bkb3duL192bWZsYWdzKCkgaGFkIHRvIGJl
IGZvcndhcmQgZGVjbGFyZWQuDQpCdXQgdGhlbiBhbHNvIHZtX2ZsYWdzX3QgY291bGRuJ3QgYmUg
cHVsbGVkIGluIHByb3Blcmx5IGJlY2F1c2Ugb2YgYQ0KY2lyY3VsYXIgZGVwZW5kZW5jeS4gQSBm
ZXcgb3RoZXJzIGhpdCB3ZWlyZG5lc3Mgb3IgYnJlYWthZ2VzLg0KDQpTbyBpbiB0aGUgZW5kLCBJ
IGRlY2lkZWQgdG8ganVzdCBsZWF2ZSBpdCBhcyBhIG5vbi1zdGF0aWMgaW5saW5lIGluDQphcmNo
L3g4Ni4gVW5sZXNzIHRoZXJlIGFyZSBhbnkgb2JqZWN0aW9ucywgSSdtIGdvaW5nIHRvIGp1c3Qg
bGV0IDAtZGF5DQpidWlsZCB0ZXN0IGFsbCB0aGUgYXJjaHMsIGFuZCBJJ2xsIHBvc3QgdGhlIHNl
cmllcyB3aXRoIHRoZSByZXN0IG9mIHRoZQ0KZmVlZGJhY2sgaW4gYSBmZXcgZGF5cy4NCg==

