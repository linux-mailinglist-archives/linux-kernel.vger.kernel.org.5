Return-Path: <linux-kernel+bounces-103608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE4AA87C1DC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 18:11:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CB711C20FA4
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 17:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07A7374439;
	Thu, 14 Mar 2024 17:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g8C1RR9+"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F6C87441E;
	Thu, 14 Mar 2024 17:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710436253; cv=fail; b=CdtaGZ9cTlHrh01SgU9T2c+rPPzvIvsy/vsJNfEZlcMpsIzVFq8d+Sja1WF+uAFYbQMhNxbGXXytBV/dAee7PafEZTDWchD7ygh/xd/pSNAKIoOwAn/K5E4rIUyjt1QEk9cluhVbeqV+I+8BHuRmg2uy6D6aAOn5Tk8v9aQMMpo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710436253; c=relaxed/simple;
	bh=uFLqHmTcizh/W6+uQFs2YNk38s4SQg3+NAbeLdlKbZA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=A31177Ux3BMxN1jkJ+NJIw5c+BhsmaYjQBUeemxMAHLWuBVLUa3LMuqwzG/zWyh4lI6l9xx+C++ye7hvGjnr9rIqpR6cG2LavgFzr9ONWKJLjFghvk0rWT3ScYuAxjQmOqodhnU8HPahA4fkYA9EcRZfUALJ+D2LOsnfG1wUwc0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g8C1RR9+; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710436251; x=1741972251;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=uFLqHmTcizh/W6+uQFs2YNk38s4SQg3+NAbeLdlKbZA=;
  b=g8C1RR9+hjMgbRrFPVjMMKopz/YkhDni6FI59pQYs1HZdoToqQMEuxr8
   7q1s1Lx6kPWglHb4i2SAAOUvbiiDf+KMt0ENy7M5L7fQ83H7FHX9wezH4
   bKONbSIqKcXJr+r2q4UJlZouO5ibrBuxurLyw11DyL47Ov6EY66eqaKfK
   W/91+cjEfEXemuDUo6y1HhKTP4wY8c0xQIelOwf4UGaYpt+XRXcYmcMN9
   E289COeQqcpEhc6uoxE44aIZ9mz/nx1Icik3LeMtlKVXfcjpTuWyWVBuX
   eGeUBAA3MkYEHn4q+pcmoi24TGF3meBZo876fW6WhYXneH5aXNbQiwPvm
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11013"; a="16426281"
X-IronPort-AV: E=Sophos;i="6.07,126,1708416000"; 
   d="scan'208";a="16426281"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2024 10:10:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,126,1708416000"; 
   d="scan'208";a="12428747"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Mar 2024 10:10:46 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 14 Mar 2024 10:10:46 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 14 Mar 2024 10:10:45 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 14 Mar 2024 10:10:45 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 14 Mar 2024 10:10:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hGxskfrjCOP6RFtzGTBz5ymja3dFExGhOUnS9yIpoW++5j1z83z7NUy5kG6GDdjZbGXIJ0fNqaxXmE/R4CR9kk003FqSTAeHA33eIxyiR2YSoa5seJNpQ9/NpPoEGnB769yF8lEv+QWizfTK7EELCwzWX/eMGlUxQTamIWJzslbAL1IhPfOPWT/mWx6+YC7VsaSKjj8yQkyORdDwPp+z3rs3t6vpJK4REraU91CyzCOmLbsAHRkI91DvKGIIDCoFD+MzUAN4v/z037lziunXfYYVCc+qdLmtF6Gi5+ARhbq/Y1E/Mz1R+eyM1LbV7QnHYVSsuemeDDN/JzMHU1ePTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uFLqHmTcizh/W6+uQFs2YNk38s4SQg3+NAbeLdlKbZA=;
 b=ips08cDy/KVVeK0rzIyUt8ffTv8ieb1eVGT5cg5g1fBA4bga+4H9Kj0yg6ryMRwyWaaTtygtRGf1Q8bXLgUaJNu1EX8llXvPHWLqVq7EBPCtcXkRf+X5ZyodgsHlrp40xZ9oQx4pWZ17T4aHO+zyjFTPKeMtXO5jZeXvqoQ2DoCK8cDvflj+SZ9MbegL/8aTO61qR6GOROz7nTJS6tySD8I/deAJA4o0Bxe1DqOAotFLWz3IcqtKD6MZLdkio864fnZr5Nyaozl4kl2JyZrNRxg/+A3AfUL8oPipcX5SYNqXiQ7wQeEzftvC9hkYii0HsHNBSmY3ymf/Qb7w/Fc7yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from LV2PR11MB5976.namprd11.prod.outlook.com (2603:10b6:408:17c::13)
 by PH7PR11MB6499.namprd11.prod.outlook.com (2603:10b6:510:1f0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.20; Thu, 14 Mar
 2024 17:10:42 +0000
Received: from LV2PR11MB5976.namprd11.prod.outlook.com
 ([fe80::4f6f:538b:6c36:92f6]) by LV2PR11MB5976.namprd11.prod.outlook.com
 ([fe80::4f6f:538b:6c36:92f6%7]) with mapi id 15.20.7386.017; Thu, 14 Mar 2024
 17:10:42 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "keescook@chromium.org" <keescook@chromium.org>
CC: "kernel-hardening@lists.openwall.com"
	<kernel-hardening@lists.openwall.com>, "luto@kernel.org" <luto@kernel.org>,
	"Hansen, Dave" <dave.hansen@intel.com>, "x86@kernel.org" <x86@kernel.org>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"peterz@infradead.org" <peterz@infradead.org>, "linux-mm@kvack.org"
	<linux-mm@kvack.org>, "rppt@kernel.org" <rppt@kernel.org>, "vbabka@suse.cz"
	<vbabka@suse.cz>, "linux-hardening@vger.kernel.org"
	<linux-hardening@vger.kernel.org>, "shakeelb@google.com"
	<shakeelb@google.com>, "Weiny, Ira" <ira.weiny@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Williams, Dan
 J" <dan.j.williams@intel.com>, "ardb@google.com" <ardb@google.com>
Subject: Re: [RFC PATCH v2 00/19] PKS write protected page tables
Thread-Topic: [RFC PATCH v2 00/19] PKS write protected page tables
Thread-Index: AQHadiycu6FXAqyoXk+eGGptL6GfrbE3eLyA
Date: Thu, 14 Mar 2024 17:10:42 +0000
Message-ID: <3b3c941f1fb69d67706457a30cecc96bfde57353.camel@intel.com>
References: <20210830235927.6443-1-rick.p.edgecombe@intel.com>
	 <202403140927.5A5F290@keescook>
In-Reply-To: <202403140927.5A5F290@keescook>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR11MB5976:EE_|PH7PR11MB6499:EE_
x-ms-office365-filtering-correlation-id: 13b806d1-fcc9-4a54-340b-08dc4449ae21
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: r5trGMwzrx1YzncB7dv8DTAEAHe4uF5rEgjXrHCdvYSnkuz9Yhh5LuRWe4OnzEMXpDQAtPS28bm0paFimasShzkaOe1k+CEbdh4NafqAZEujhi3xvi0Kcsx4cF4Rodd4Oy+2GLJ7NJ4ZtODpo1lpP9jVVS96zV99lyAMy+f877Gur/GtM1Nuil6mVjk1VSZBbZEAe1VIXolQxwIBfTP6D8OGCVg5iRag7w2ixlLj1xn5bWNUvNcFLulVUSGMXidCiRBsuuRJCgD9FUsTio03rfhigQh0y0oTQmIkXEqfxe480W1FaGRUOiZYJ53Z9qUPylzuS/55HAUdR47qy0+E5jzwGiJyhTG5sPF5ynLhTYknq8/bBAkfEfERtCzyzDqkuWRg0CSqGDxQi7aPgiLJB/BCS5OzIKkp8Fs3/UVS1lm9cwP+PBQOXFaHwJ+8CNn7r5H040gw1VCZgas4v1BMF+FPw36R9HmkzK4wbtj+tdldz2cthViRbUqcPpuwRPfq4kRxOs3gWMM7ivDfWLm9uCIoCl17dChAq9Gq8elgRWhnJsrK3OFahttpABIi6CwtHtjJTPTmrOJ1zBZeHo7SXlYdBYpMiWJ1siArVWDTQyHA2OyhBloLooIg7T85reSnD7eui/Luhp8RZmvMHSGqLB28ikMAxXqYAELthVRxCGk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR11MB5976.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RnZaanNNeEVxWHFURnFaYnJYWE04ejkwWHRvS0V3OTZGUWJpNE1nZFIvdW9P?=
 =?utf-8?B?WjVoOTBKSmFuTkFYb0IxelRTZmk4akZkSkxhQnE3aUZjbEZNczkydG1mL2dS?=
 =?utf-8?B?R0ErQ2prSnVSdlVnQnNuRFN4bW5WVFg5b3R3RFhTOEdSa25ETzNueUpMSVc4?=
 =?utf-8?B?c0I2SHNOQlNOWnpXcElPRmdLRCs2eHJXZVE0UTBTYmdrSkppNDlUTCt4SW1G?=
 =?utf-8?B?UEVjbkp2YkpzMDlQemVwUTMrdEVCWTRHNzB0TXlDT3RISFByOFdONlRnazRs?=
 =?utf-8?B?Qnhxa1VpNnY4a01HOTd4MUtIQ0tJUHZ2QmtVMng2aTJKQ3QzRXp0RVVNSXF1?=
 =?utf-8?B?TGl4WUI3dTI0U2krZUdVZWV3R1dPZE1UTEJYUU1za1JFWEJmNkt5dlU4VjBz?=
 =?utf-8?B?eTZsNnhtTTZOSzFyd2ZQODBXV2V1NnBYSmViLzRKTEZPME9rMnRWaUc0T2ti?=
 =?utf-8?B?SFJWd0p0d1pTZ3h2MzVlY2hHcGtYUnZpcnBoNlpBMSt1MktjWkdJWk9kZVdr?=
 =?utf-8?B?RUhXQXJTUWhtMkhkVDVabkFpNnplaEk4ZmhVcXQvenEweU5GbUR3OFMvZ1lW?=
 =?utf-8?B?cHVpTVpwL2Z5R3FTT1ZuUUl3dU9pSDlxSFkzK043NkRxZDlPeW5icERiM0R0?=
 =?utf-8?B?Q0UrbE9nbWNyS3hUUVFCa0lrdkNZZ1ZiNlNGZUxldU1ZR00vc0owZzdMdVNM?=
 =?utf-8?B?K25HM3cwVi9sN1BlamoyYlhsWFBnYUNnbVA3VXdrNmRwL1B6THUxeGJtMFpH?=
 =?utf-8?B?REhqV3ZiNDhSSmwrWk5ENU5TWE9uVkFJUmk3MjlZUE04VXphQXF1V2JrWmhW?=
 =?utf-8?B?RVk3VWJyQWszT1YzQmV2Z2ZZbmx6MHI3cExxL2tiaVRGaytQWnFCaXlja0lo?=
 =?utf-8?B?YVpteW5Tb2l6aGJQUzFrMTRraWVoaGFoYXBDVWxwK25vVCs3eDRaVndldGhV?=
 =?utf-8?B?Wmh6Sy9sYjZMRWhUQnJFTXYrOE1JdlRWQUJybHBWd1JVNkRXU0t1RXBzb0Yz?=
 =?utf-8?B?ZjZRWENYcE16TXNabDJIN2tBdTRvZzF5ZEM3bE5qTGtNVHhyWG1nZlRSVW5Y?=
 =?utf-8?B?NjVVSmFBVlF2ZGtXbE1KU2lRWDZRTFVKSmZjYkJVcnNFNVhPZVFiYkJoSzFj?=
 =?utf-8?B?MFRtNE1CeG5QMGE3TXFUTktJVjNrZG95SFAvaktYRkE1cmZNYm5CY0pQOFQx?=
 =?utf-8?B?cnA2d3ByRmdaQVFlRzdHRGw3Szk5V2o5cjdNR20vUzl4ajRwenNUNTRBOFlr?=
 =?utf-8?B?Y2dvMDMzajYrcEt2MWNTZnJTSEVIeklHYnhsc3o3ajJEbUw4dWVRUlVVQ3o5?=
 =?utf-8?B?RDRvYmdjUmZsUTVzWG5oVERxcFF4cWxDbHlsN2xZcVV1VkpDWUY3cXJmUnhz?=
 =?utf-8?B?SERLK2tOMkJwUHVFdVJGL3VzSEVHUmdVSFhHODJQL0NVSlFobXBDeTB5RkNT?=
 =?utf-8?B?SWsxV2lYbFl0OUhFMk1nK0RUVjBoZXpXUTk1SVZyZWlJSVo2WmhrWk9FNGoy?=
 =?utf-8?B?T3dwTUJ4MW1KYjEzOEZveVpocnI2N0YxQURPMmtzOC9UMWNQck9VYXpHOHR5?=
 =?utf-8?B?anZPcUxYOFEyVTNuNE9JUEZqWDRHeFJBVXl5SCswQVNQU01JTzh4aGFQMkhl?=
 =?utf-8?B?R3hJS2pQc3Z3Tk5rNkkySTNmTzdXNWZRR1BML2pJTHZpRWhJV05NT29Ka0Jq?=
 =?utf-8?B?c1JKbzdHeW5WZkh6MnNwSm5yMmtBN28rMFEvUFUzdk9IN1poZEMveFpFQzcy?=
 =?utf-8?B?eGpOcUFTUkhLQThvTFF5RmZybjF5eTdRRFRVQjQ4K3l5Z3MzVTZtMUpDT3p6?=
 =?utf-8?B?a0ZQMEZUTlJIQUYxMVlnR2dEbGRTeWF6OEZ4dHNSOFR6WUJkcTVYY2RUYVBL?=
 =?utf-8?B?OU9aSC82VVBTMGg0U200WVVvbE5YUGcyczllUmhocHN3R0ZJWHhnWUZzbGk0?=
 =?utf-8?B?TVBhazFRVEdpbjRDUXB4WkJCK2dGam1kbkZ6NmhMY1RhWEZzZ0RRNlNFMDZB?=
 =?utf-8?B?cE1KMjU2WnVNellYT3pUUGNVVUlGdzBySWRsZzAyQVE4TDlSclIwbTJZQy9l?=
 =?utf-8?B?a3U1UzBJMkxLNTBxTUpkKy9NeUNUNTFmRDRacko4VTFVYXBZOVJydklzYVdY?=
 =?utf-8?B?YVpzVkZNZjFTN0p6RlZFazdWZ2gzMmRJRVFPdCt6VHdJNnUrMHF1R0hnNUx3?=
 =?utf-8?B?Q1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <46CB043D5B6FF1409A4162DF765C3CA2@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR11MB5976.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13b806d1-fcc9-4a54-340b-08dc4449ae21
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2024 17:10:42.4298
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VRc4qKtc7yKSJfBlsvS+2k9DAiGOISfwRQD997IrhQDeUN79by4XHgAq32exiCgKM5Lz/OZuRisUimOwu8lBstAICSJJltZZpdj5JNJIQYc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6499
X-OriginatorOrg: intel.com

T24gVGh1LCAyMDI0LTAzLTE0IGF0IDA5OjI3IC0wNzAwLCBLZWVzIENvb2sgd3JvdGU6DQo+IE9u
IE1vbiwgQXVnIDMwLCAyMDIxIGF0IDA0OjU5OjA4UE0gLTA3MDAsIFJpY2sgRWRnZWNvbWJlIHdy
b3RlOg0KPiA+IFRoaXMgaXMgYSBzZWNvbmQgUkZDIGZvciB0aGUgUEtTIHdyaXRlIHByb3RlY3Rl
ZCB0YWJsZXMgY29uY2VwdC4NCj4gPiBJJ20gc2hhcmluZyB0bw0KPiA+IHNob3cgdGhlIHByb2dy
ZXNzIHRvIGludGVyZXN0ZWQgcGVvcGxlLiBJJ2QgYWxzbyBhcHByZWNpYXRlIGFueQ0KPiA+IGNv
bW1lbnRzLA0KPiA+IGVzcGVjaWFsbHkgb24gdGhlIGRpcmVjdCBtYXAgcGFnZSB0YWJsZSBwcm90
ZWN0aW9uIHNvbHV0aW9uIChwYXRjaA0KPiA+IDE3KS4NCj4gDQo+ICp0aHJlYWQgbmVjcm9tYW5j
eSoNCj4gDQo+IEhpLA0KPiANCj4gV2hlcmUgZG9lcyB0aGlzIHNlcmllcyBzdGFuZD8gSSBkb24n
dCB0aGluayBpdCBldmVyIGdvdCBtZXJnZWQ/DQoNClRoZXJlIGFyZSBzb3J0IG9mIHRocmVlIGNv
bXBvbmVudHMgdG8gdGhpczoNCjEuIEJhc2ljIFBLUyBzdXBwb3J0LiBJdCB3YXMgZHJvcHBlZCBh
ZnRlciB0aGUgbWFpbiB1c2UgY2FzZSB3YXMNCnJlamVjdGVkIChwbWVtIHN0cmF5IHdyaXRlIHBy
b3RlY3Rpb24pLg0KMi4gU29sdXRpb24gZm9yIGFwcGx5aW5nIGRpcmVjdCBtYXAgcGVybWlzc2lv
bnMgZWZmaWNpZW50bHkuIFRoaXMNCmluY2x1ZGVzIGF2b2lkaW5nIGV4Y2Vzc2l2ZSBrZXJuZWwg
c2hvb3Rkb3ducywgYXMgd2VsbCBhcyBhdm9pZGluZw0KZGlyZWN0IG1hcCBmcmFnbWVudGF0aW9u
LiBycHB0IGNvbnRpbnVlZCB0byBsb29rIGF0IHRoZSBmcmFnbWVudGF0aW9uDQpwYXJ0IG9mIHRo
ZSBwcm9ibGVtIGFuZCBlbmRlZCB1cCBhcmd1aW5nIHRoYXQgaXQgYWN0dWFsbHkgaXNuJ3QgYW4N
Cmlzc3VlIFswXS4gUmVnYXJkbGVzcywgdGhlIHNob290ZG93biBwcm9ibGVtIHJlbWFpbnMgZm9y
IHVzYWdlcyBsaWtlDQpQS1MgdGFibGVzIHRoYXQgYWxsb2NhdGUgc28gZnJlcXVlbnRseS4gVGhl
cmUgaXMgYW4gYXR0ZW1wdCB0byBhZGRyZXNzDQpib3RoIGluIHRoaXMgc2VyaWVzLiBCdXQgZ2l2
ZW4gdGhlIGFib3ZlLCB0aGVyZSBtYXkgYmUgbG90cyBvZiBkZWJhdGUNCmFuZCBvcGluaW9ucy4N
CjMuIFRoZSBhY3R1YWwgcHJvdGVjdGlvbiBvZiB0aGUgUEtTIHRhYmxlcyAobW9zdCBvZiB0aGlz
IHNlcmllcykuIEl0DQpnb3QgcGF1c2VkIHdoZW4gSSBzdGFydGVkIHRvIHdvcmsgb24gQ0VULiBJ
biB0aGUgbWVhbnRpbWUgMSB3YXMNCmRyb3BwZWQsIGFuZCAyIGlzIHN0aWxsIG9wZW4oPykuIFNv
IHRoZXJlIGlzIG1vcmUgdG8gd29yayB0aHJvdWdoIG5vdywNCnRoZW4gd2hlbiBpdCB3YXMgZHJv
cHBlZC4NCg0KSWYgYW55b25lIHdhbnRzIHRvIHBpY2sgaXQgdXAsIGl0IGlzIGZpbmUgYnkgbWUu
IEkgY2FuIGhlbHAgd2l0aA0KcmV2aWV3cy4NCg0KDQpbMF0gaHR0cHM6Ly9sd24ubmV0L0FydGlj
bGVzLzkzMTQwNi8NCg==

