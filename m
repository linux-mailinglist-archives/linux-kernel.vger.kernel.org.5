Return-Path: <linux-kernel+bounces-69634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4672A858C9F
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 02:12:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B12A0B26614
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 01:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E24B4C8F;
	Sat, 17 Feb 2024 01:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U65XJ3Vn"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCEEADDA9
	for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 01:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708132325; cv=fail; b=kM7p7Ui1llyeM8rnHTL9jmbTCE81hukcFonM8yPRORX1iJ33ahZlcEZfWM2PE5z0YR9KFyFYKk9YgaUIJOh2DZKqGjwkfOwM8YXYpKQ2M1+V5O3tNTjZvgR5gI4Lqcb5g+9GHrOmMRXMX1x2+jz5XlUqOIAR0rV10qyaGSG9S14=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708132325; c=relaxed/simple;
	bh=5/Wk7rka0fdrdTkCHqMocIi84m/MXPrZz56dPJ58e3Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ahoam5zXGaSMtZxMQkD+fzJbd+mL0r5wcNQOxdfKqhQW6Gbqti6KGh2ndcWhIyqhqcHNaOA+At3EhB357BRB8qbjpVuLxr2GtqLLoIsAxTGMHbOTP+UbJ4bMjKz1E5tb3tPwhWcgJnTcwbU+w/2AITK068GZpnPP3BNLGXRVoeY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U65XJ3Vn; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708132323; x=1739668323;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=5/Wk7rka0fdrdTkCHqMocIi84m/MXPrZz56dPJ58e3Y=;
  b=U65XJ3VnjVo5CgojFjUBRn9aW7eKNii7vEnhqQmyWNgQB5FPWpiBsUYL
   b43SZNqNOyLAIudYQ5DXeI7tXRco0wZLxh9ltL8P8Hlb81/Hzks9I1feE
   LNbste5gZVOTYOYstm/F/TvCfvzccN/7FlcaztSZ78En+yFyjziSJvxkc
   8SxvmV7oo/1WLMLqhzSxelUWCU5oTITc7ALuaL/hfi32TJjZoJeJyXMGC
   4IQ6VB0g4b0+ElYEL9JmLxPrPQ5brCYdfiKwU92nmojxwLw1PJOhOmJlX
   hDGks5i97S9lH8ULW+tjHh2gFNxkeJHddTemQacmsXgFKF4F6SmtNYLbF
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10986"; a="13672265"
X-IronPort-AV: E=Sophos;i="6.06,165,1705392000"; 
   d="scan'208";a="13672265"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2024 17:11:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10986"; a="826653809"
X-IronPort-AV: E=Sophos;i="6.06,165,1705392000"; 
   d="scan'208";a="826653809"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Feb 2024 17:11:55 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 16 Feb 2024 17:11:54 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 16 Feb 2024 17:11:53 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 16 Feb 2024 17:11:53 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 16 Feb 2024 17:11:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dQzxBfjEvZ55Dujn/tavOWxaCZ3Qf4jtlj9k7ONGKse8c8z5OwG4yblh8OQIY73G8G1EIZII5+4NOPD/Kym4j+20WvmM4czF06KrX2aIP/Us+aMIESH3FnBF28jqaft7wpyIpSyzI8qsRaGdNoJJ3A+97eByuuVof6JoBBWX5Kc7AyC0DjCqM2d4yQf3mcWf6U3aVXMbxt0zbgv5/s7vOyk6T3y0qM7/PoA9zh0exMA26lslCKuwq/9QCOmQwXBOzT4W/Km2VBewj0grebZ15BAz3hHh3f0Fqud7tn9GLiCNfOChz5gsYBIrzP0RE+EkBKyk1vjfmTnqp9nfmGTWrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5/Wk7rka0fdrdTkCHqMocIi84m/MXPrZz56dPJ58e3Y=;
 b=aXUy6uhLF2yA8olEdCOOkqMA/UqP1umqgoULOPulKjvg/VcJJOENquMb+UwJAHM5X0nUFxK25zdis13Gda3weFUys2xzqBeZelbLc/i9yjYP2b9aWO9aAHYZHGfGT2Qt0C9Fmdc9HY0wY5rG74wPuO9X3c2EFdj737oGO8kSe8A5knMOnPpugNqfDUru7OTFSSpIjCWEW4MuVa+fQfR67oz0LnOXRVUxhvnm7OAPJiSD8UJYN8KaxycUzuf6BFVTz0el1hZtpTvbtjtH8L4tGVg3ddLCyBYrUk9AMUAxQaFjjOw/t7Ytw6BDiwOuvUvczOP4jTAoFRat3XM9Sh87LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by SA1PR11MB7112.namprd11.prod.outlook.com (2603:10b6:806:2b7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.32; Sat, 17 Feb
 2024 01:11:51 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::5d40:83fd:94ac:d409]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::5d40:83fd:94ac:d409%7]) with mapi id 15.20.7292.029; Sat, 17 Feb 2024
 01:11:50 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>
CC: "debug@rivosinc.com" <debug@rivosinc.com>, "luto@kernel.org"
	<luto@kernel.org>, "x86@kernel.org" <x86@kernel.org>,
	"Liam.Howlett@oracle.com" <Liam.Howlett@oracle.com>, "broonie@kernel.org"
	<broonie@kernel.org>, "keescook@chromium.org" <keescook@chromium.org>,
	"bp@alien8.de" <bp@alien8.de>, "mingo@redhat.com" <mingo@redhat.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"peterz@infradead.org" <peterz@infradead.org>, "hpa@zytor.com"
	<hpa@zytor.com>, "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 5/8] mm: Take placement mappings gap into account
Thread-Topic: [RFC PATCH 5/8] mm: Take placement mappings gap into account
Thread-Index: AQHaYGTFuMtklJzH10yK+fVk1/ghbbEM8tiAgADI74A=
Date: Sat, 17 Feb 2024 01:11:50 +0000
Message-ID: <e951a0e08c2ba9ead0b35714aafa00ebbc75a780.camel@intel.com>
References: <20240215231332.1556787-1-rick.p.edgecombe@intel.com>
	 <20240215231332.1556787-6-rick.p.edgecombe@intel.com>
	 <3ynogxcgokc6i6xojbxzzwqectg472laes24u7jmtktlxcch5e@dfytra3ia3zc>
In-Reply-To: <3ynogxcgokc6i6xojbxzzwqectg472laes24u7jmtktlxcch5e@dfytra3ia3zc>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|SA1PR11MB7112:EE_
x-ms-office365-filtering-correlation-id: 758927c6-21e0-45b7-cdc0-08dc2f556b74
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: miEDH0qwLHowIVijQCzIXNkH9SMsc3yyAxwuvMubX1piqIB48XnOyEYNJ6XcK5dMZDAbBdNRO8Ya4LY4IyeWTcxL5HdCAvf/FfURLgoFfklCHfQSBMJhT+HQbeNezI1N9P2d9WdvOP0OwyWxdsnrh8pjtqI1ZYo2JJ+9UgGIYIdidkeLnbwJygZt5tYzu4/orElNJvWrTuX9K7GDMy2j9nKyO/nsviSLkk+sTxqEkpMo8Ss9/538SYCelP+uJ1UDItIjb6Wv5YnkjRsmggSRXQjOxMHHIcjk1yQ4dQT2YQ3C4X3+JLNmHrwzvsyH9Ueun2rDrDNcg6k5MUOdTj1EF3OhDL9dOGFFL1PsNc6YpzWnWb+ZCZBp9f2D8CjRbVSekNXgS6/ffpn3eLlopdckLUXhLMsQnohq0ZDOrQHQODTfEorl9V5a5q0+qU5kLZswv1jAVwGths+zuTKWDdvz+ju1zN/2EyGq4rXg7IbNji+p0gQFn0b5f2RSa/ofBRkTS/6L+CKnaUz8zK9BCl30EGu5CqFt2eQDqlpQ6zzQcD4jVDZeLjvaRXhvCsJtOr8e60yAp3p1j9sw7pGw5DXl/32oJ6t+KC8QRzDw2r4aN6DDPUqqyEhjDO0HFC9Y4DHn
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(366004)(346002)(39860400002)(376002)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(7416002)(66446008)(82960400001)(122000001)(83380400001)(38100700002)(8676002)(15650500001)(4326008)(6916009)(2906002)(8936002)(66556008)(5660300002)(76116006)(66946007)(66476007)(64756008)(2616005)(26005)(71200400001)(478600001)(316002)(54906003)(6512007)(6506007)(6486002)(41300700001)(38070700009)(86362001)(36756003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NjcreGx3elFnMWJJMjBJNm9vaEVTRC90NklteFZJbHlEWHlrQ2pSUVFnV2hx?=
 =?utf-8?B?eEwySFRZdFJmby81MVJRQkZVejA0M3F2TWhuWGtEM3VQUEtnaVBzM21GZERH?=
 =?utf-8?B?L0dQQkh2cDBhQ3FyeGJ3b1RUVy9ERWxxMmszMzhTenJpVG9lcHpJR3NoY0w5?=
 =?utf-8?B?Q2VjR3h5UWwrUEVkd2RJSFFFem5GaTVEa3E5c0NDRTlKTHpUZGk0R2JIVjBP?=
 =?utf-8?B?MC9CUlJQUEJzQTRkZ0FwQ0d3OEV6VzFZMmhTL0NtY0hySUg0MU9xNnhJQW16?=
 =?utf-8?B?UDl3T3hTRnZTajIwQVVQNU9oeWtGNjJ3eDRyU2orTjZwUlJxOGllQ2R3Y25k?=
 =?utf-8?B?ZTlaRlN6cWJCaW50SUwyNjNpMUV2SE96RlpzVm9Nc3M2Z0tITzdhLzYyUkt4?=
 =?utf-8?B?ang2azJrZmF4d3JpSEFnTUVJWXZBeWRqUTA3NmNPRTc3VFdORG15cXY0VDJt?=
 =?utf-8?B?UjdyMUhoa3JVRUlxN2Mxa3F2Q05FV1JCNDBTR3JCczFUWit6ZkVqcnh6VE1j?=
 =?utf-8?B?L1lPb0wzQ2xXSEdOdmdQRGNNNW5LMWlFWDhRRE42WUNUVmx2U3FMbFFkcDVY?=
 =?utf-8?B?VXVPeUNqMzNXWklQU0Q3N1l4R3hUNjZCeHI5RGRhNEZKYWZ4Z0lhRkdXR0ZE?=
 =?utf-8?B?OTkxK3V2Y3BzWlVJNWpUcSttNjR1NWdocWhlN0dnd2VrcjZydTdkd2ZOTVRM?=
 =?utf-8?B?aXdXK1JZNnEzd2FUSFAyUUNOWXJodGxPOXEzYll5ZVlHL1VhSUEzRlc1bmxS?=
 =?utf-8?B?VmF6ZU4yUStwMVQvVHYxb1V1VWovcThBQUZvQmY1ODI2MXFqbWdYTURVZkNY?=
 =?utf-8?B?ZFVveXBWNy9ybEwwUmRFZEhxS3RoMitOdUJzeVF2SHFmTE4wTjg4QjVLQXpn?=
 =?utf-8?B?UHlsU2hoNkNqcE9NQWp6bXY4QmE2aUNaczlVNitPUHRFT3RnclRGTGpoUnVG?=
 =?utf-8?B?U250alpZcUYySHlKeE1mQ2tQWVp2czFzanBDd0hPTjFFZzlTbHI1QkdXRzMy?=
 =?utf-8?B?N2x3V0Z4Q1JjdUFtRCs0Zm9LZE1ZaTY0NFZBOWRiQzZGTERuQ3RBR0ZXVS90?=
 =?utf-8?B?cDc5ZWJySVdsTkhGdjlQQnAvUnhMc3dSVW1YeDMyZ2toYy8xZDZEZUV5aElH?=
 =?utf-8?B?UnNieTFlQm12T0lSZ1ZnSHhxME4rb0xDUmlFNnRRbDA1TVZyNGxNbHN4UENo?=
 =?utf-8?B?RWhPOWdFeWN5Ymx4TGo0UFA5RlFjYW5mSU1UTHRzVFVKclpoZFRUYkNiQlV3?=
 =?utf-8?B?ODN2bGZnT25FTExKMnRCOUFpNUZIcVlQNmgraThxcGdGdXVhV0hWUU1UT3k4?=
 =?utf-8?B?MnhKL2trNFFmTWp1ajh3RUFUY09jT0dvYTNZQ2V1L2FIQU5EUFV1QW1wbnFJ?=
 =?utf-8?B?N2Y2L0ptcTJWM0k3MWxoYkQ0c3NrNU55Rm1yWnhFRndGYlExVmxuS0VIU2c2?=
 =?utf-8?B?RlVwOUkzWThwUTA0VVVYS0hrSFRpampuSFUvTW1Uc3dUUXhkNFlhM0NWRVp6?=
 =?utf-8?B?cEtmdWQraS91eXVON1pYOVFNMnEwMVRIYm1DNWJmUWdxQWMvcHZkU1l6bm9h?=
 =?utf-8?B?eGlrZnYwN0hoZ2d5b2pBN2FNdEU2c0I5Y1FwM1Q4UHdnT0d3L0ZrOEVMYjB4?=
 =?utf-8?B?MTlVdlM4SHkxR2FmSVY2bUpoaG1Kd3R1WWFTVU5rRHY1V3dSYkVZQzRwZzdh?=
 =?utf-8?B?WjVDczlVL3kxaDJDWU0wbk96Y0ozRVd2M2xvbzJxQm1nSEgyT0tDbTlVOW5o?=
 =?utf-8?B?VnRZYnUraWsxM3JTY0dkYTJDVWlOOExwdXRzN054N1RSSGY2em5KdHVqWlYz?=
 =?utf-8?B?dHg1ZUp0dWJrWjJCeFp1QUJzT2tXN25vUXAzeVNRSlcxL00zeURKZXRLMHp6?=
 =?utf-8?B?UzBVR0orVnp4SVZaLzNLVVVpRXpNQkZTUGRjT3cySG9tUE1FclFMWjlaY1hm?=
 =?utf-8?B?TVNxV0NsR3hGZlB0NUNQRjdDT3NDTG9kQkx4NnM1d1JQb245RmtSMkFrY1JE?=
 =?utf-8?B?UlZXU0pEWHJzeUpxRXdZUmliTTg4UzFieUtoQ2xVMU1NWWw2UXZjRXRqZ1dX?=
 =?utf-8?B?NTJHSnovQ0ZRVnFZb3FHSVZ2QklVUXByRXUzc0JOK0RKYWs3QjNVU0h2Y2Rx?=
 =?utf-8?B?azYvMTVVdkJ4dWhrZm5XbmFtN092ck43cHdwQWRzVEtMbW5kOElZaVhXM0ZZ?=
 =?utf-8?B?Z3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4C3524C591CBBA49B8D046BA545AB27F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 758927c6-21e0-45b7-cdc0-08dc2f556b74
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Feb 2024 01:11:50.1278
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ucXH7nNumhXSn5TAXjAPD/51YijdaBATofWHNyXymNajzvF0nx/rGtt0ployZfdT60jLSpdOfNJr6K0mNUjnk6+uG95i8a0kJhrgK1wWYN4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7112
X-OriginatorOrg: intel.com

T24gRnJpLCAyMDI0LTAyLTE2IGF0IDE1OjEyICswMjAwLCBLaXJpbGwgQS4gU2h1dGVtb3Ygd3Jv
dGU6DQo+ID4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvbW0uaCBiL2luY2x1ZGUvbGludXgv
bW0uaA0KPiA+IGluZGV4IDlhZGRmMTZkYmYxOC4uMTYwYmI2ZGI3YTE2IDEwMDY0NA0KPiA+IC0t
LSBhL2luY2x1ZGUvbGludXgvbW0uaA0KPiA+ICsrKyBiL2luY2x1ZGUvbGludXgvbW0uaA0KPiA+
IEBAIC0zMzkzLDEyICszMzkzLDE0IEBAIGV4dGVybiB1bnNpZ25lZCBsb25nIF9fbXVzdF9jaGVj
aw0KPiA+IHZtX21tYXAoc3RydWN0IGZpbGUgKiwgdW5zaWduZWQgbG9uZywNCj4gPiDCoCANCj4g
PiDCoCBzdHJ1Y3Qgdm1fdW5tYXBwZWRfYXJlYV9pbmZvIHsNCj4gPiDCoCAjZGVmaW5lIFZNX1VO
TUFQUEVEX0FSRUFfVE9QRE9XTiAxDQo+ID4gKyNkZWZpbmUgVk1fVU5NQVBQRURfU1RBUlRfR0FQ
X1NFVCAyDQo+IA0KPiBUaGUgZmxhZyBzZWVtcyB0byBiZSBhbiB3b3JrYXJvdW5kIG5vdCB0byBj
bGVhciB0aGUgc3RydWN0dXJlLiBJDQo+IHRoaW5rDQo+IHVzZXJzIG5lZWQgdG8gYmUgdXBkYXRl
ZCB0byBjbGVhciB0aGUgc3RydWN0dXJlLiBJbiBtb3N0IGNhc2VzIHJld29yaw0KPiBjb2RlDQo+
IHRvIHVzZSBDOTkgc3RydWN0IGluaXRpYWxpemVyIHdvdWxkIGRvIHRoZSB0cmljay4NCg0KWWVh
LCBpdCdzIGp1c3QgYSB0cmVld2lkZSBjaGFuZ2UgdG8gaW5pdGlhbGl6ZSB0aGVtIGFsbC4gSXQg
c2hvdWxkIGJlDQplYXN5IHRvIHJldmlldyBhdCBsZWFzdC4gSSdsbCBhZGQgYSBwYXRjaCB0byBk
byB0aGlzLg0KDQo+ID4gQEAgLTE1ODYsNyArMTU4OSw3IEBAIHN0YXRpYyB1bnNpZ25lZCBsb25n
IHVubWFwcGVkX2FyZWEoc3RydWN0DQo+ID4gdm1fdW5tYXBwZWRfYXJlYV9pbmZvICppbmZvKQ0K
PiA+IMKgwqDCoMKgwqDCoMKgwqBpZiAobWFzX2VtcHR5X2FyZWEoJm1hcywgbG93X2xpbWl0LCBo
aWdoX2xpbWl0IC0gMSwNCj4gPiBsZW5ndGgpKQ0KPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgcmV0dXJuIC1FTk9NRU07DQo+ID4gwqAgDQo+ID4gLcKgwqDCoMKgwqDCoMKgZ2Fw
ID0gbWFzLmluZGV4Ow0KPiA+ICvCoMKgwqDCoMKgwqDCoGdhcCA9IG1hcy5pbmRleCArIHN0YXJ0
X2dhcDsNCj4gPiDCoMKgwqDCoMKgwqDCoMKgZ2FwICs9IChpbmZvLT5hbGlnbl9vZmZzZXQgLSBn
YXApICYgaW5mby0+YWxpZ25fbWFzazsNCj4gDQo+IERvIHdlIGNhcmUgdG8gY2hlY2sgaWYgYWxp
Z25tZW50IGl0c2VsZiB3b3VsZCBzYXRpc2Z5IHN0YXJ0X2dhcA0KPiByZXF1aXJlbWVudD8NCg0K
VWdoLCBJIHRoaW5rIGFjdHVhbGx5IHRoZSBhbGlnbm1lbnQgc3R1ZmYgY2xvYmJlcnMgdGhlIGd1
YXJkIGdhcCBpbiB0aGUNCnNlYXJjaCB1cCBzY2VuYXJpby4gSSdtIGFsc28gc2VlaW5nIHNvbWUg
d2VpcmQgcmVzdWx0cyBhcyBJIHRocm93IHRlc3QNCnZhbHVlcyBpbnRvIHRoZSBleGlzdGluZyBs
b2dpYywgYnV0IHZlcnkgbGlrZWx5IEkganVzdCBuZWVkIHRvIGxvb2sgYXQNCnRoaXMgbm90IGxh
dGUgb24gYSBGcmlkYXkuIFRoYW5rcyBmb3IgcG9pbnRpbmcgaXQgb3V0Lg0KDQoNCj4gPiDCoCB1
bnNpZ25lZCBsb25nDQo+ID4gwqAgX19nZXRfdW5tYXBwZWRfYXJlYShzdHJ1Y3QgZmlsZSAqZmls
ZSwgdW5zaWduZWQgbG9uZyBhZGRyLA0KPiA+IHVuc2lnbmVkIGxvbmcgbGVuLA0KPiA+IC3CoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB1bnNpZ25lZCBsb25nIHBnb2ZmLCB1bnNpZ25lZCBs
b25nIGZsYWdzLA0KPiA+IHZtX2ZsYWdzX3Qgdm1fZmxhZ3MpDQo+ID4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB1bnNpZ25lZCBsb25nIHBnb2ZmLCB1bnNpZ25lZCBsb25n
IGZsYWdzLA0KPiA+IHZtX2ZsYWdzX3Qgdm1fZmxhZ3MpDQo+IA0KPiBVbnJlbGF0ZWQgc3BhY2Ug
Y2hhbmdlLg0KDQpTdXJlLg0KDQoNCg==

