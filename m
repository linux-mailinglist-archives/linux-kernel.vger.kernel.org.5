Return-Path: <linux-kernel+bounces-91054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF5CE870906
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 19:04:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76A9E2870D5
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 18:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 833DB6168A;
	Mon,  4 Mar 2024 18:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zsm1WIlR"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 889FE61685;
	Mon,  4 Mar 2024 18:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709575436; cv=fail; b=Jx2nTrjD/oorij6c9VLROuCG3jbXSj0RgRSgHfcEdaoEj8mzD/UyPWNzabTqd+wvAwSRmMJJ840i8QCUENqC8LhBjJUCd3KW3L7HeAAAXrXWIJY9dh13GwLeTzQ7YLT2J3ax75G77butTzK4H5LzydPkK60BX/FzmdJoB2XfwFM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709575436; c=relaxed/simple;
	bh=G0DzSIeyP48E2AGpBeHy7G8Bf7aOpZbWUZKP7lVEh/g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pR2VZwXXZ/neo6wl91OhbIMoXeLKGhLVBAyPxmuaM4uz6FNskIbrh7EwT0xQ3hzS9Nc+6KEtu2xu9fqnM+bw/MgKylyJEq7Q1ED+Gzc13YCZ//JJ7qUM4ycKeNzJeyTDQ2JoNm+FEQLYZUokwXC6Rjd/e+8dHMYOLCzYXCHsAuQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zsm1WIlR; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709575435; x=1741111435;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=G0DzSIeyP48E2AGpBeHy7G8Bf7aOpZbWUZKP7lVEh/g=;
  b=Zsm1WIlR5/UcmBWfKpJziSL7WB1oi/e/T+27OZHnDbDgspoxhjPwQK9o
   sg6xERKSdFyuleaALx2MbF7i148HMcnXHT+BAhjifKeVg3xmr7Sm9CQ47
   g2DbQJgcZaw0t5Rj5B/GBOKgy8ZWMgzDvtzeixTZAj3nIPXLuyiUcSuBg
   DanoHAOSpiDHD47vY7oX+YxA8ZKsW8kZRyGTm85cmEHAamVl82sY3WgHg
   UQq4gAIx4qQNCW9WZgx/+CBvJAIHT1pBOhzvZYxs+tNTUOJP0lJUpTGwj
   rsJUaEcssUB+4j5qM3tHacekiV8S2yW+zJmkWqE0CmEBKSwXELRbcKbsI
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="3940696"
X-IronPort-AV: E=Sophos;i="6.06,204,1705392000"; 
   d="scan'208";a="3940696"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 10:03:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,204,1705392000"; 
   d="scan'208";a="13746741"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Mar 2024 10:03:53 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 4 Mar 2024 10:03:52 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 4 Mar 2024 10:03:52 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 4 Mar 2024 10:03:52 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.40) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 4 Mar 2024 10:03:52 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LgnxxVQFZnKyLAC6ZwPiRq7BzpqmayvX1S4C8sx35e5lkR8Cx3DqKsKlgEZ8Q3kmPKoTEsbYQvPp+GFvWqgo31TG+7gHdtu1+qNtCfg1yYl6t39NqA1tlkqt0qY2XYpCTire7hqQOXAZdJ2i3cyhDvSz93SX2ABoYBIIAn1vkvhGYLZ7vP4+XypjyQJGc7wOpFZ8JjtS54jDHTiXPNcy9/ecUGqyBxIMc2FDmATQ3myMVcZGUm1nDxDHQUfhOxAthwuLzVobSewtAKErug89EwlMOx/cWa2v3OGvJN2hTJGz+GvJrQGQdFdqY3f4u9iuxEJvWftn8pnFkYX6MR5Dow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G0DzSIeyP48E2AGpBeHy7G8Bf7aOpZbWUZKP7lVEh/g=;
 b=A7LnfUSBrOrCe5fwYz8PJkhZdO0dOenNM/DVAh87E+JVWFUirRajQ+KWMcAszPK/anD6RH97JGn7MifrSPo7zFWTQ1XUbFuYp6ltqrBGExzUnEmTXM+AhWeyipmc/txCs2pjI8UlYnN4mlEx8VXKzwd0ZTwD9hizp/MmaYVPSzUsyoxbczAdRH5g9tJJ5Q8yAtusq+zP15wyQVw5lsRNYVbMExSIEuNuCfbTC97VlQ1pslQXVevrnD8OzyofeUifD0sqtgxRnb0lsdXXtV2sbsau8hcyq1nBwdTfGvqDGhO3eaigv9t682y+p2lhMH7sIlj5y0QQhsCDaSXgoN7iRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.22; Mon, 4 Mar
 2024 18:03:48 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::fc9e:b72f:eeb5:6c7b]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::fc9e:b72f:eeb5:6c7b%5]) with mapi id 15.20.7362.019; Mon, 4 Mar 2024
 18:03:47 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "keescook@chromium.org" <keescook@chromium.org>,
	"christophe.leroy@csgroup.eu" <christophe.leroy@csgroup.eu>
CC: "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
	"luto@kernel.org" <luto@kernel.org>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "debug@rivosinc.com" <debug@rivosinc.com>,
	"sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>,
	"Liam.Howlett@oracle.com" <Liam.Howlett@oracle.com>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "linux-parisc@vger.kernel.org"
	<linux-parisc@vger.kernel.org>, "linux-snps-arc@lists.infradead.org"
	<linux-snps-arc@lists.infradead.org>, "linux-mm@kvack.org"
	<linux-mm@kvack.org>, "loongarch@lists.linux.dev"
	<loongarch@lists.linux.dev>, "kirill.shutemov@linux.intel.com"
	<kirill.shutemov@linux.intel.com>, "mingo@redhat.com" <mingo@redhat.com>,
	"peterz@infradead.org" <peterz@infradead.org>, "hpa@zytor.com"
	<hpa@zytor.com>, "linuxppc-dev@lists.ozlabs.org"
	<linuxppc-dev@lists.ozlabs.org>, "bp@alien8.de" <bp@alien8.de>,
	"linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-mips@vger.kernel.org"
	<linux-mips@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>,
	"broonie@kernel.org" <broonie@kernel.org>
Subject: Re: [PATCH v2 5/9] mm: Initialize struct vm_unmapped_area_info
Thread-Topic: [PATCH v2 5/9] mm: Initialize struct vm_unmapped_area_info
Thread-Index: AQHaaOdsOIuf9v8cz0SXVaOI9gIdJbEdxC+AgAC5pQCAAAKPgIAAJA2AgAEcBICAAELjgIADoSeAgAAR4wCABDOQgIAAANoA
Date: Mon, 4 Mar 2024 18:03:47 +0000
Message-ID: <e617dea592ec336e991c4362e48cd8c648ba7b49.camel@intel.com>
References: <20240226190951.3240433-1-rick.p.edgecombe@intel.com>
	 <20240226190951.3240433-6-rick.p.edgecombe@intel.com>
	 <94a2b919-e03b-4ade-b13e-7774849dc02b@csgroup.eu>
	 <202402271004.7145FDB53F@keescook>
	 <8265f804-4540-4858-adc3-a09c11a677eb@csgroup.eu>
	 <91384b505cb78b9d9b71ad58e037c1ed8dfb10d1.camel@intel.com>
	 <def71a27-2d5f-40da-867e-979648afc4cf@csgroup.eu>
	 <202402280912.33AEE7A9CF@keescook>
	 <ac04c9aa134807bbc00e6086e7a14a58a682f221.camel@intel.com>
	 <202403011747.9ECFAD060B@keescook>
	 <ec3e377a-c0a0-4dd3-9cb9-96517e54d17e@csgroup.eu>
In-Reply-To: <ec3e377a-c0a0-4dd3-9cb9-96517e54d17e@csgroup.eu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|CO1PR11MB5089:EE_
x-ms-office365-filtering-correlation-id: 6f9c4469-4e2a-426e-839e-08dc3c757079
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oA41TO9LzyDg1wdOBRaORGkpGJJ9gnc1Zjd0qvtm+wGCJCAELPTxlNAV0BTjg4SiFr+p9AXBnbSJY/WWl6eJzhnE8bHd++DeAraGZ1pv+VGNo3Qx+VkcEO7pp5E8/0dDSYXeESd8HZq1R4Tn9BQTrcoOP6QSm9y6Ljtult9FNEBQrAw/WeA5Gf9zShjy18fl/53k1fSlwrewymhivOwdPNV3gHB/jnH5BUFjmU6jq8tYhID8TLX/NeTkuqCa8witRbv7EfHWkJ0/j9koksUj8KfZgOC4CI2ypgxy1YAk84ONimp3Q4iugHx52lJZwM5SFp4vrocdlUtHe1wD5emByqv+QBctHBOPtBk7USWzD0rGY4n0OdbFYygFv4ObM/bUtpKnGh2ItYZG1brdkqSM2kCZEnBdfLPYvS0lJ1ub42VcNbCSr0wZbzeHF0RO+lDzjRN6+3uEF8wkKUCKyGqF603lmqv+FO121mKZb4QBKrWxshkiNIczkg92usRXX4mBkkmTwDO1amMabsqjf5zoScvBvqxQRhJK0L7jxsxGnQ21fKctNe/U2pqiHWpi959m0CCUFEL2VUamUTXx0WB5l/X+CYt6U8iG7Z7UT+ry77yHqh1EWgjM1tIvzfcOykRY/9JG3Q2d6lBBFqVcWKaaVRlnWie5s9flLVZkzJURUiu4ZHSA4CazeQJL4pUIBbNPQapA2/3x6iwJjCK21mX/RFn0fdJwRR0/T/rrpT4OO+E=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T3NGbFFuMnlOSC81dStnYmx6WXVPV29jdWhmb21jc1JzNzR4bC9sNlY4VkNl?=
 =?utf-8?B?MG91bWtPWVZVVVdlZkc2S2FmQzloNnlESlFNemcrS0RYT0t0S3lwbzZuV1Zi?=
 =?utf-8?B?a01kWCtUR2UybGhqUTBrVEthZ1FpejFQcE8zMHVRK0lVZ2FzU2hITVkwMVJy?=
 =?utf-8?B?TCtSeTR0UmhidkRFeWYzQUphWUZJQytUVGp4VUYyR0FNdzFDVFYvb3krQ1Qz?=
 =?utf-8?B?WkVWcGpSUUljaWdVdUJZMDgxVHBJQm81VXJBQUU2ckFXdWowd0JLc0JkWEFp?=
 =?utf-8?B?RDRveGtQZmc2Q3hFTW8zMmcrZktJMW9BbDNPY0kzNFNvNmsrVGhDYzJDQmEx?=
 =?utf-8?B?Rnd0Z0NuZUdONVNxb1BaRXE5Z3lWT2xUUWxRY2hoSklTb3lMTldUN3kwazBG?=
 =?utf-8?B?bVNsalEvLzZ1bmNKbWVLOTBsWE5JVnlWU2lYNEQ4OWFVVitPRm93RHYyN2Jz?=
 =?utf-8?B?V1F0QmxkU29ScXc4bFZsK25KZHNkY0g5cU5lTXZGZ3A5WUlyU2lKQ0hMNmJj?=
 =?utf-8?B?L0szZG1iNUp0WVNKQ1FGYys1WWdnaFNGQjV5WDhtZHFXTlRVbWVUMzJhcmJq?=
 =?utf-8?B?dGpYcXF2T3dPOStSOW41eVUyOFJQVUVkRDFCaWZsUWdwcE55UUd0bXRFOGpY?=
 =?utf-8?B?bFB3UTFuRWg4VUwyVWlzK283c0dzRndETVhzMzE0R0kyUkJsSCtkT25BMmhz?=
 =?utf-8?B?bXNIZDZlWVZaZm02Ulplc1JWa0szSXdMaDN5UXFCclBnMEZneGwxRTVKdFRh?=
 =?utf-8?B?NTZLakk5UUJiNm5yYUpacytHZUxtS1hKMkVUUzlNck03ODFQUis2amplN25M?=
 =?utf-8?B?bHVGVW01dW5GL3dkdmg4MTZVSEhidnh3aGYxME54UEVWQXFPY2NVZmp4ZjZM?=
 =?utf-8?B?aUpSN3J0aGYwOEdrbzJWQmpsUjFtNis3ejBpQ0h1ckNjaU9SdEJ5bUMybTVn?=
 =?utf-8?B?WllkNWRIVSszUEozN2NPd1o1dVQxVWszN09McUd3VXd6NXFvSXZBbDAzbEJl?=
 =?utf-8?B?TG9GS3E5OVozUS80Um9mZTVyenJPNklmOXo1TnpzbWUzdy9OVUsya2NMd1Ba?=
 =?utf-8?B?VFlFUzhKSUZsWEZER21tYTU3N0NzdnJ0UzBGeUt5akFPZ1hOMW1QOWdyYmxZ?=
 =?utf-8?B?UmRMYWZuUWx2S1BxV3o0cUU0RWpNQmJHcEZBYUdkS1Nwc2JHNmw4MjlLbTVk?=
 =?utf-8?B?bkg2LzVDMjVKVGNiRjdYa2ZXWWg3MFU2U2FHMlJ6V2JQT1ZXeHV4MEhucE9r?=
 =?utf-8?B?Rk9lOVg3anNHV01Jenp6ZUpQRWdhdGpGWDB3VndIOUVXMzkxdU4xUW1ndkFD?=
 =?utf-8?B?WGNwYmljS2dMSmF4b2I0aUFaVllZZjFSRFpRbXBRVExuMFhHZExhSnRJMWo1?=
 =?utf-8?B?NkQraC93c3lwQkpVWDZyb2V0dHY4VklrWW8zRGFBOFBRb3E1d0l2T3l5QXVy?=
 =?utf-8?B?NStzWVJlalFlbS9mem9qYkh5UkJZc2VJc1RiQ3Y2YXdoTFNScHZsaUJYR09n?=
 =?utf-8?B?dzAwdUhLOVM5OTZuTC9CMGoyWHU0Q3pFeGtLWkxYc0NyNkNpR1dEUWd4Qmo3?=
 =?utf-8?B?bTZlWjhVeUdqdnNqejlzTFhnbHBEdHowWjErYjVsTkNtd084L3dyc09ZdFdy?=
 =?utf-8?B?QW9IYVlVdTBhTjJBVHh1VnpORS9qbU83TkdKYUlUUGlHRHBocUtaWVpvcThp?=
 =?utf-8?B?ejU2YUViY2hLVUVHTUtyRHJmMlowV3czVVo0ZkFjQWtTbjVKazZ4T1FLbjFE?=
 =?utf-8?B?Y2xTQVR6a2VaL3kvcHdXbVhyZTNIYkdNZG9XckdaUDBCOHBQVjBnbGxxdC9j?=
 =?utf-8?B?ek1pNTRXNDlvaE1vSzk1UkZNSWpBMVJscVlJbWxjTkpZSS9TQjh2K1QwZTFo?=
 =?utf-8?B?Mml4TEhRR250bGRrL2xTUGVEb2hueHk1K0dYNHA1Zk9KRThYWiswdEc5bEI1?=
 =?utf-8?B?S0h6MEh5Z0FrbWxiMUpjYTdoQWpDUDdOVy91M3dPTWljQldQSWlFZiswZUU4?=
 =?utf-8?B?bGtGUWI1RUlQM0R5OEdJQW0xeWRFYS90UWpJY2lyYXNQVG90Zk42Y1N0LzVk?=
 =?utf-8?B?U3Vubm0vK1Y2VWQrUWNIeVIwWlB4UU1IU21EYldUeXhtVmlHRXVZaWZxS2Fz?=
 =?utf-8?B?d1hBdHN6SGg1c011eGMzWGlIS2NYZmJDMUJnRVhhT0VEek51SUVsK2R3SEJ6?=
 =?utf-8?B?Q3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3CDDD33D4622C94B9E2372E2F147B478@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f9c4469-4e2a-426e-839e-08dc3c757079
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2024 18:03:47.5349
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gehXoEqLQIvc40AL6qt0R9sx0HXuFwzOAqon4b7GIaZqK95C7AgsT5xr+X6W9Z0gjiIFi32ssHQ1LXE39yv1A9pcOcLhhKgea6x6z3luF8Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5089
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI0LTAzLTA0IGF0IDE4OjAwICswMDAwLCBDaHJpc3RvcGhlIExlcm95IHdyb3Rl
Og0KPiA+IFBlcnNvbmFsbHksIEkgdGhpbmsgYSBzaW5nbGUgcGF0Y2ggdGhhdCBzZXRzICI9IHt9
IiBmb3IgYWxsIG9mIHRoZW0NCj4gPiBhbmQNCj4gPiBkcm9wIHRoZSBhbGwgdGhlICI9IDAiIG9y
ICI9IE5VTEwiIGFzc2lnbm1lbnRzIHdvdWxkIGJlIHRoZQ0KPiA+IGNsZWFuZXN0IHdheQ0KPiA+
IHRvIGdvLg0KPiANCj4gSSBhZ3JlZSB3aXRoIEtlZXMsIHNldCA9IHt9IGFuZCBkcm9wIGFsbCB0
aGUgInNvbWV0aGluZyA9IDA7IiBzdHVmZi4NCg0KVGhhbmtzLiBOb3cgc29tZSBvZiB0aGUgYXJj
aCdzIGhhdmUgdmVyeSBuaWNlbHkgYWNrZWQgYW5kIHJldmlld2VkIHRoZQ0KZXhpc3RpbmcgcGF0
Y2hlcy4gSSdsbCBsZWF2ZSB0aG9zZSBhcyBpcywgYW5kIGRvIHRoaXMgZm9yIGFueW9uZSB0aGF0
DQpkb2Vzbid0IHJlc3BvbmQuDQo=

