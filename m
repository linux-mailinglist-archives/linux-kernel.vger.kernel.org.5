Return-Path: <linux-kernel+bounces-65766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 969A485517F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 19:07:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4951E296B0B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 18:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9913D13398F;
	Wed, 14 Feb 2024 17:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bm7vlwUh"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05AB21339AD
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 17:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707933596; cv=fail; b=o3IWLyRquF09IzQnGYjpRdYZc27Ei5IqUsnBDiEvy/pLCC4L6dloUvpjmbozJevdqv6cZDCKksJwnaqnVQBemRikKt7jRupwK0IzWpJq07NgBRC51huBhSq1NyWKvBSXCXGxbvh1iZjgojDvT4IfpXJ3pSlisMvd37C4uybnFNw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707933596; c=relaxed/simple;
	bh=pZWgp5i8u1RwhbdDYgWJ5qts+cP2d9aFLIVRXw/6+Oc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LUchj9QIzcJ+VDOFOqrO2mZDYe3BcHbR3sFhr2M8kLRpaNthDuE7V/MH1h1r+q2IbjOS2DJ3UrOmr4flPpngPHHy5DZOhCa1J5rZUINN+ZhtMJ6gQmtZ9oF6hHW3SKvL+DaxCynTJ5/P+zzp7njuvMxr6+z/3rFIhBKjERnq3MM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bm7vlwUh; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707933594; x=1739469594;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=pZWgp5i8u1RwhbdDYgWJ5qts+cP2d9aFLIVRXw/6+Oc=;
  b=bm7vlwUhFrA5k6IzMAu1/ovAUxN//qclXtQakw/rZREr3eg9nXZAPMBs
   SmJY9kNWH5KMidP7XVnlUH1Duyl2wjLfmcP1+CCSSug9WN5z9lZv9bv1R
   n4e/tTdk7FyN/P7BTTaSEynWdW+7l3pFoucBVXord5XJz+sMiMn61HNTo
   OIzaDaURl0crvFVQoG1MAYzVqquLvlAaLaACGEhCobRhTxonKXwdT1utr
   IViJti01inA0VTRPKYZEt6QlKsJY5Tz6D2d9jCURvpvU4kaNk2+enRiXg
   VQFOCnAs+BXAKx4GUICrGtARTTyd/wzw/GIZfb+WuNTteF1GWS1Mr/AVD
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="2135843"
X-IronPort-AV: E=Sophos;i="6.06,160,1705392000"; 
   d="scan'208";a="2135843"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2024 09:59:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,160,1705392000"; 
   d="scan'208";a="7922008"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Feb 2024 09:59:52 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 14 Feb 2024 09:59:52 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 14 Feb 2024 09:59:52 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 14 Feb 2024 09:59:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MPbHVrb54CxErmK6jQI7Xbbu+05Ynj4TNBkPTTYYgz+ZL7hdfR2Ju0Puok65AlmxHxg5IlTekkH+hIkPFqCN/4PgBq0QmMVUh2yKWGfZslIkUg+EftuZP7/wL/3fio7nKTsMQpL5AW3tYwm/h08qSw4TJmIeWWqc+zrfOLxnGf2AnEFDi4VHG+TZ2fonZf+ioowE6lxagv7a/BNFOwDbSJ38e1dLF6TKIhXAweyZWFaWm0Sy4qkwfP6tQWbZ45p8GCw5j5eIkdO+RewAa4f+qCqkLnNybnlcf6CeVbZ4jiPLrDIHeuxztwn5vQgaSJjUs8BriAgrxJCl4uANqzR2aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pZWgp5i8u1RwhbdDYgWJ5qts+cP2d9aFLIVRXw/6+Oc=;
 b=agsi4YT2p9dmr+Kvp4pbxHJGNbCgU7W+rjHHKShpIKfwrRH4/CGWb924jf77Bekfqmjhqccw3uwrc0PCa2NiPFXp4Z5F3pufs+o/3iq1V/CC9gKVmcdV65oSWAY2TRwvN/aj6e2gPI0F6P/3mXbAn017d4mu0RJghsCAWm8slY7X1BPcl7Tfc4s/sQmdICoiq0Y8FZetoRH6TTFfUJKLnwjSuF3O6IAEsdyctwP/PwYLyFzQsV3BE3GTbNUv5dq3tWlX4kaOCjoBv+fwpnTjpXth2ZRnCjOnGCzOubHKDdRHJiSfJn/uD8oqZ0nPK3CW5TFSuVAKI+6hDeAYfVf91Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5750.namprd11.prod.outlook.com (2603:10b6:8:11::17) by
 SJ2PR11MB8587.namprd11.prod.outlook.com (2603:10b6:a03:568::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39; Wed, 14 Feb
 2024 17:59:48 +0000
Received: from DM8PR11MB5750.namprd11.prod.outlook.com
 ([fe80::7e88:63ca:dd41:d190]) by DM8PR11MB5750.namprd11.prod.outlook.com
 ([fe80::7e88:63ca:dd41:d190%3]) with mapi id 15.20.7270.036; Wed, 14 Feb 2024
 17:59:48 +0000
From: "Reshetova, Elena" <elena.reshetova@intel.com>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
CC: Theodore Ts'o <tytso@mit.edu>, Dave Hansen <dave.hansen@linux.intel.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Thomas Gleixner
	<tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, "x86@kernel.org"
	<x86@kernel.org>, Kuppuswamy Sathyanarayanan
	<sathyanarayanan.kuppuswamy@linux.intel.com>, "Nakajima, Jun"
	<jun.nakajima@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, "Kalra,
 Ashish" <ashish.kalra@amd.com>, Sean Christopherson <seanjc@google.com>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/2] x86/random: Retry on RDSEED failure
Thread-Topic: [PATCH 1/2] x86/random: Retry on RDSEED failure
Thread-Index: AQHaU1aX7QKpTpzPXU+lq+SGmZ3MRrDySSwAgAAHtwCAABNoAIAAS0IAgAAD1CCAAAeOAIAAyKKAgABkhwCAAA8BAIAACmIAgAAorwCAAAX8AIAACBOAgAC3UwCAAN1RgIAA2w+AgBNiW/CAACOkgIAABWPA
Date: Wed, 14 Feb 2024 17:59:48 +0000
Message-ID: <DM8PR11MB57503E654C8A0E9A41CB68AFE74E2@DM8PR11MB5750.namprd11.prod.outlook.com>
References: <CAHmME9oJvbZgT4yT9Vydc2ZQVSo3Ea65G5aVK7gFxphkV00BnQ@mail.gmail.com>
 <20240131140756.GB2356784@mit.edu> <Zbpc8tppxuKr-hnN@zx2c4.com>
 <20240131171042.GA2371371@mit.edu>
 <DM8PR11MB5750C7D16DC566CD1329D5A5E77C2@DM8PR11MB5750.namprd11.prod.outlook.com>
 <CAHmME9q-eUXnXnpaDu0VOQemOYysst7SaJ-=b8-vCFP9h50Szg@mail.gmail.com>
 <20240201045710.GD2356784@mit.edu>
 <CAHmME9oqM2a766dBK22-yKr8=2-icg=UkQzmBOF8G5Zh_Y9E9w@mail.gmail.com>
 <DM8PR11MB57505F657A8F08E15DC34673E7422@DM8PR11MB5750.namprd11.prod.outlook.com>
 <DM8PR11MB57503A2BB6F74618D64CC44AE74E2@DM8PR11MB5750.namprd11.prod.outlook.com>
 <Zcz2r51Tbb44ywjl@zx2c4.com>
In-Reply-To: <Zcz2r51Tbb44ywjl@zx2c4.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5750:EE_|SJ2PR11MB8587:EE_
x-ms-office365-filtering-correlation-id: 9fdb889c-d015-4272-b6e4-08dc2d86bc12
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0vFmQSNd1dh5eEXs657nloyKf8DuQJfEyvwpQFKkyt04IhYI0qBmKZlvZ17qWinvcMoITeID9nkiFbNvVNJsYAkwC4QZDm5xXAPUPjRolJFn2+87qOtKtV58FIms26skw8SwGdvqUPZMd4k/7qSaZt8IxJLqAU3iyb6PwSC6/+uQFXgGJXqM/MhkdqMcVgEXsMLxMbs+tmbKGsH3VGok4slm38lh8KWCddF+TU8o67dUIwzGbhbr+iJ4GhWPjrJf7qgd8nQxTtHKvqdg9cjqNVthuDtnEQcob/p6bdAc6JEzRX2J1lnYUV1azZPwVDgVdPi+jX5EoXIhCQSD3P7YJt1hL2z7Fnk3kprAFA3LG2Dvh7WMVFw+BRzkhuXUbf2aZDKrEEHfpsSi4hQNtbnT9q6s/cjfYKmIq8P7+Erixjm07O4xQq2akn1p1HBVeFoegeJXREjdUwfpqDsk/qT6Xf4Zu3s2hyuTSZ/qnfe9D2eBL0gPddG3yXcU/i7PFiargJ5vlyYwZ3tsqJxfTOsx5rNNliXVfKb/T9QMxBZ8I14FpUGrCFpBKTUXG8Bb1/3hDtZeW2sUXQQHwOltuyLA6hcK7eVO/YV6HsraeoZUXH1VjY4nzGQC+qX46fVbp6UX
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5750.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(376002)(346002)(396003)(366004)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(2906002)(7416002)(55016003)(53546011)(41300700001)(478600001)(83380400001)(6506007)(6916009)(66446008)(64756008)(76116006)(52536014)(4326008)(26005)(8676002)(71200400001)(66556008)(66476007)(66946007)(8936002)(5660300002)(38070700009)(33656002)(122000001)(54906003)(7696005)(316002)(9686003)(82960400001)(38100700002)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MU5pZklaRmUzaVpFWDJaV3QwRjF3U1J6eURqWk1TSGVBMHBnZXVhN2pLSXBX?=
 =?utf-8?B?Rkxqb3dRZWtDRXEvUGNBaTZCbXg5MHhnM0p4TzZKcUZrcGZQb1ZCejQxUHE3?=
 =?utf-8?B?Y29DQ1VmeHcwK0ZscmZVend0Y0ZmS1puR3hucmV0MHJ0NW1YTWN1b2RFV0Zp?=
 =?utf-8?B?anFZanFTckpDV0FQZnB0ZzBpOGwwNUFGZ2Ftd0wyV3cyYllsUmZWNG9JNkI4?=
 =?utf-8?B?YUpMZG5MOXVtOVE4WXEvWTBta29pM1p4VDdZZFVFOTRoQnlsS1NtSXFRdmNs?=
 =?utf-8?B?eXdnakVYRTlNU1NoOCtoVXhydlBqbDhHQ1pGcjVoUmFLYVhYaGt0RjNOTGhs?=
 =?utf-8?B?TzZVV01jUitMb2hXTTNYWmdiVE83aXNWemRpY09nbjhwcS82bFlxOFA0T2do?=
 =?utf-8?B?TUxGeGUzR2c4U21BenMwOEZxdVpCVEt0VzIxUFRnUG1QbHBRYzh0THhHRW5h?=
 =?utf-8?B?OUUvQzJRd3BkbkE0bjFQT1F0U0EwWXBMUllxOWlMZFlHNjV0d2FUSFArQStK?=
 =?utf-8?B?Z1RJTWRJaG1HcGQyeStnZ0MvbW01VDY0WEVrYWFCbE9XZWE5NHVTRHR5dGsv?=
 =?utf-8?B?UmpyYVFta3c0RzFYKzNCN3p3ZDNnWHU3bXRJUmFPbHVlaUh2aGFsVXloNVlm?=
 =?utf-8?B?cEZxRzBjZmF4U3BIbTFkaFdabGFUTzN3ZjZwdzFKT2FkeWhydFNwekxRZlJv?=
 =?utf-8?B?NUwwRG9pK1FKdDNrT3B3N3hEUURLTUR5emFsV05DY2tJVnRzbzJIcEs2QjNn?=
 =?utf-8?B?b1JxdVo0SG5zblQwbjNZUXBTdTlacTlUdzQwUjZXbXFQZCtyVVJmSTZ4V0VX?=
 =?utf-8?B?REtBeDBKRlpIU0d5RVpiWElsVWdZRldubzh3R3dFcEFjZm1NRGV1ZWxyUTMx?=
 =?utf-8?B?aTFTQ1ZscnA3OWsrOXhNWGZXZitzYjZCRkV6Y3Rxc0VwbDliVWpLbnhqTGoy?=
 =?utf-8?B?ci9rc2tHVlNJYjAvZ2VENUE0RDVwQnAyeUo5N3g1N0xIcWptZlFzNzZGZW5t?=
 =?utf-8?B?R1dlWHlacFVUOE5EMEU1djY2VVVFVXJPUGZsRXFadnh3N3EvSjRTVzdxS2tu?=
 =?utf-8?B?bGtJR21BNVRVOTZ2dGg4SGp6T0dPUnk5R0JPUm5SOHcybUp2RWZkMXN3cWY4?=
 =?utf-8?B?aVFLRGoybSszVXpxYUZRT1FPdGJLRUxjNm1uc3ppVmgwZDRJNCs4QkpncGFV?=
 =?utf-8?B?N3RCZ0dyMjlVOEhmN0tRM3puTG9YYXZidDZNa1VEZy8xRjJvbmR5aDdGNWQx?=
 =?utf-8?B?elF5U3VIdzJNbTFLS2NTTWUrelJCb3hqOTNoMVpIUzZhSlNlSTZWNWRIUVgz?=
 =?utf-8?B?QlNZUWJTOFhIVWRZTDJSc2tZQ0FORlh4M2NBYUlRYUcvQU1tN2Rka1lPMStF?=
 =?utf-8?B?anFrRVhCdTBndlR1ay82MGdsN1RHaHcvR2ZEWDRKM05mQ0dtc3hzVlRBSUIw?=
 =?utf-8?B?cGFENXZZdnZsNFZnY21aU0Q2MTB6ZzZXNFhTZC9yQ1lqM0d5OERWdnU4cDE4?=
 =?utf-8?B?VWloZHF0dndiSjlHOVRvUE0rektsc3NCekNJS3gwa2pFdUE3OWR5Z3plMHpx?=
 =?utf-8?B?Rjd5UUlHUnN0UUtlMGRscTZ4NFRiVE9DUzB6NzN3eXlzbFo5N2NPa1VHU0gr?=
 =?utf-8?B?aXR1bjZWb29XVUhIRGl3WXRVMG44Zm9YVnFwc3NtYU9tdzNmZERrV3NsQURa?=
 =?utf-8?B?TDJieGxvTXNYOFZYSnc4QnBWK2htZTljUFdPcjdtK1FSZVdadGQ3K0hIb2JL?=
 =?utf-8?B?MVZ0eDkyS2tIM1ZLaGlsM3RaV3drU0ZvL2NSSWhFSWdrSmFQbzMxZ0lRVHFU?=
 =?utf-8?B?MWdmSm8yc1VlLzFIbDJ2V2Y2UHRUaDd1bkRmZFhsUy9zR09vSFVDQnpwZmZv?=
 =?utf-8?B?YVRrb3c5eTNRQXdsQXR4WVdpVkxocUpnaXZRV0tZS3M5OXlXTm4wU0FWeW1k?=
 =?utf-8?B?N21ZV2ZDOTh2bzlpcUk2UGc5WDYzMCtvRGV5S2RobERFcmx6UmtFTlZHaWtJ?=
 =?utf-8?B?UkFKdDQ4bk5jbHkvTUEzOWFuUU5hQWVrZ2xkemJ5bmxpRnRNaEhxSXJ1TzAr?=
 =?utf-8?B?ZFRTbUZqek9Pa1piUWNMOURDNXhJWjlaMm8wb0JaMGp0YWZWbFIwUWhNVXRD?=
 =?utf-8?Q?iqtShNhUd0f2uhIpBRBjagxfm?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5750.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fdb889c-d015-4272-b6e4-08dc2d86bc12
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2024 17:59:48.3705
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4W0Rbh34Sqzw6rjU9PmPj/RcOTbanhsEAUZFZpI4dbvu3ocFNJWJob852/7Isr7bzd6fmc+yhKuf2uAH2/3WA60bn43EYkrPK11yB6VCoSM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8587
X-OriginatorOrg: intel.com

IEhpIEVsZW5hLA0KPiANCj4gT24gV2VkLCBGZWIgMTQsIDIwMjQgYXQgNDoxOOKAr1BNIFJlc2hl
dG92YSwgRWxlbmEgPGVsZW5hLnJlc2hldG92YUBpbnRlbC5jb20+DQo+IHdyb3RlOg0KPiA+ICJU
aGUgUmRSYW5kIGluIGEgbm9uLWRlZmVjdGl2ZSBkZXZpY2UgaXMgZGVzaWduZWQgdG8gYmUgZmFz
dGVyIHRoYW4gdGhlIGJ1cywNCj4gPiBzbyB3aGVuIGEgY29yZSBhY2Nlc3NlcyB0aGUgb3V0cHV0
IGZyb20gdGhlIERSTkcsIGl0IHdpbGwgYWx3YXlzIGdldCBhDQo+ID4gcmFuZG9tIG51bWJlci4N
Cj4gPiBBcyBhIHJlc3VsdCwgaXQgaXMgaGFyZCB0byBlbnZpc2lvbiBhIHNjZW5hcmlvIHdoZXJl
IHRoZSBSZFJhbmQsIG9uIGEgZnVsbHkNCj4gPiBmdW5jdGlvbmFsIGRldmljZSwgd2lsbCB1bmRl
cmZsb3cuDQo+ID4gVGhlIGNhcnJ5IGZsYWcgYWZ0ZXIgUmRSYW5kIHNpZ25hbHMgYW4gdW5kZXJm
bG93IHNvIGluIHRoZSBjYXNlIG9mIGEgZGVmZWN0aXZlIGNoaXAsDQo+ID4gdGhpcyB3aWxsIHBy
ZXZlbnQgdGhlIGNvZGUgdGhpbmtpbmcgaXQgaGFzIGEgcmFuZG9tIG51bWJlciB3aGVuIGl0IGRv
ZXMgbm90Lg0KPiANCj4gVGhhdCdzIHJlYWxseSBncmVhdCBuZXdzLCBlc3BlY2lhbGx5IGNvbWJp
bmVkIHdpdGggYSB2ZXJ5IHNpbWlsYXINCj4gc3RhdGVtZW50IGZyb20gQm9yaXNsYXYgYWJvdXQg
QU1EIGNoaXBzOg0KPiANCj4gT24gRnJpLCBGZWIgOSwgMjAyNCBhdCAxMDo0NeKAr1BNIEJvcmlz
bGF2IFBldGtvdiA8YnBAYWxpZW44LmRlPiB3cm90ZToNCj4gPiBZZWFoLCBJIGtub3cgZXhhY3Rs
eSB3aGF0IHlvdSBtZWFuIGFuZCBJIHdvbid0IGdvIGludG8gZGV0YWlscyBmb3INCj4gPiBvYnZp
b3VzIHJlYXNvbnMuIFR3byB0aGluZ3M6DQo+ID4NCj4gPiAqIFN0YXJ0aW5nIHdpdGggWmVuMywg
cHJvdmlkZWQgcHJvcGVybHkgY29uZmlndXJlZCBodyBSRFJBTkQgd2lsbCBuZXZlcg0KPiA+IGZh
aWwuIEl0IGlzIGFsc28gZmFpciB3aGVuIGZlZWRpbmcgdGhlIGRpZmZlcmVudCBjb250ZXh0cy4N
Cj4gDQo+IEkgYXNzdW1lIHRoYXQgdGhpcyBmYXN0ZXItdGhhbi10aGUtYnVzLW5lc3MgYWxzbyB0
YWtlcyBpbnRvIGFjY291bnQgdGhlDQo+IHZhcmlvdXMgYWNjZXNzZXMgcmVxdWlyZWQgdG8gZXZl
biBzd2l0Y2ggY29udGV4dHMgd2hlbiBzY2hlZHVsaW5nIFZNcywNCj4gc28geW91ciBwcm9wb3Nl
ZCBob3N0LWd1ZXN0IHNjaGVkdWxpbmcgYXR0YWNrIGNhbid0IHJlYWxseSBoYXBwZW4NCj4gZWl0
aGVyLiBDb3JyZWN0Pw0KDQpZZXMsIHRoaXMgYXR0YWNrIHdvbnQgYmUgcG9zc2libGUgZm9yIHJk
cmFuZCwgc28gd2UgYXJlIGdvb2QuIA0KDQo+IA0KPiBPbmUgY2xhcmlmeWluZyBxdWVzdGlvbiBp
biBhbGwgb2YgdGhpczogd2hhdCBpcyB0aGUgcG9pbnQgb2YgdGhlICJ0cnkgMTANCj4gdGltZXMi
IGFkdmljZT8gSXMgdGhlICJmYXN0ZXIgdGhhbiB0aGUgYnVzIiBzdGF0ZW1lbnQgYWN0dWFsbHkg
ImZhc3Rlcg0KPiB0aGFuIHRoZSBidXMgaWYgeW91IHRyeSAxMCB0aW1lcyI/IE9yIGlzIHRoZSAi
MTAgdGltZXMiIGFkdmljZSBqdXN0IG9sZA0KPiBhbmQgbm90IHJlbGV2YW50Lg0KDQpUaGUgd2hp
dGVwYXBlciBzaG91bGQgY2xhcmlmeSB0aGlzIG1vcmUgaW4gdGhlIGZ1dHVyZSwgYnV0IGluIHNo
b3J0IA0KMTAgdGltZXMgcmV0cnkgaXMgbm90IHJlbGV2YW50IGJhc2VkIG9uIHRoZSBhYm92ZSBz
dGF0ZW1lbnQuIA0KIndoZW4gY29yZSBhY2Nlc3NlcyB0aGUgb3V0cHV0IGZyb20gdGhlIERSTkcs
IGl0IHdpbGwgYWx3YXlzIGdldCBhDQpyYW5kb20gbnVtYmVyIiAtIHRoZXJlIGFyZSBubyBzdGF0
ZW1lbnRzIG9mIHJlLXRyeSBoZXJlLiANCg0KPiANCj4gSW4gb3RoZXIgd29yZHMsIGlzIHRoZSBm
b2xsb3dpbmcgYSByZWFzb25hYmxlIHBhdGNoPw0KPiANCj4gZGlmZiAtLWdpdCBhL2FyY2gveDg2
L2luY2x1ZGUvYXNtL2FyY2hyYW5kb20uaA0KPiBiL2FyY2gveDg2L2luY2x1ZGUvYXNtL2FyY2hy
YW5kb20uaA0KPiBpbmRleCAwMmJhZThlMDc1OGIuLjJkNWJmNWFhOTc3NCAxMDA2NDQNCj4gLS0t
IGEvYXJjaC94ODYvaW5jbHVkZS9hc20vYXJjaHJhbmRvbS5oDQo+ICsrKyBiL2FyY2gveDg2L2lu
Y2x1ZGUvYXNtL2FyY2hyYW5kb20uaA0KPiBAQCAtMTMsMjIgKzEzLDE2IEBADQo+ICAjaW5jbHVk
ZSA8YXNtL3Byb2Nlc3Nvci5oPg0KPiAgI2luY2x1ZGUgPGFzbS9jcHVmZWF0dXJlLmg+DQo+IA0K
PiAtI2RlZmluZSBSRFJBTkRfUkVUUllfTE9PUFMJMTANCj4gLQ0KPiAgLyogVW5jb25kaXRpb25h
bCBleGVjdXRpb24gb2YgUkRSQU5EIGFuZCBSRFNFRUQgKi8NCj4gDQo+ICBzdGF0aWMgaW5saW5l
IGJvb2wgX19tdXN0X2NoZWNrIHJkcmFuZF9sb25nKHVuc2lnbmVkIGxvbmcgKnYpDQo+ICB7DQo+
ICAJYm9vbCBvazsNCj4gLQl1bnNpZ25lZCBpbnQgcmV0cnkgPSBSRFJBTkRfUkVUUllfTE9PUFM7
DQo+IC0JZG8gew0KPiAtCQlhc20gdm9sYXRpbGUoInJkcmFuZCAlW291dF0iDQo+IC0JCQkgICAg
IENDX1NFVChjKQ0KPiAtCQkJICAgICA6IENDX09VVChjKSAob2spLCBbb3V0XSAiPXIiICgqdikp
Ow0KPiAtCQlpZiAob2spDQo+IC0JCQlyZXR1cm4gdHJ1ZTsNCj4gLQl9IHdoaWxlICgtLXJldHJ5
KTsNCj4gLQlyZXR1cm4gZmFsc2U7DQo+ICsJYXNtIHZvbGF0aWxlKCJyZHJhbmQgJVtvdXRdIg0K
PiArCQkgICAgIENDX1NFVChjKQ0KPiArCQkgICAgIDogQ0NfT1VUKGMpIChvayksIFtvdXRdICI9
ciIgKCp2KSk7DQo+ICsJV0FSTl9PTighb2spOw0KPiArCXJldHVybiBvazsNCj4gIH0NCg0KRG8g
eW91IGludGVuZCB0aGlzIGFzIGEgZ2VuZXJpYyByZHJhbmQgY2hhbmdlIG9yIGFsc28gYSBmaXgg
Zm9yIENvQ28NCmNhc2UgcHJvYmxlbT8gSSBwZXJzb25hbGx5IGRvbuKAmXQgbGlrZSBXQVJOX09O
IGZyb20gc2VjdXJpdHkNCnBvdiwgYnV0IEkga25vdyBJIGFtIGluIG1pbm9yaXR5IHdpdGggdGhp
cy4gDQoNCj4gDQo+ICBzdGF0aWMgaW5saW5lIGJvb2wgX19tdXN0X2NoZWNrIHJkc2VlZF9sb25n
KHVuc2lnbmVkIGxvbmcgKnYpDQo+IA0KPiAoQXMgZm9yIHRoZSBSRFNFRUQgY2xhcmlmaWNhdGlv
biwgdGhhdCBhbHNvIG1hdGNoZXMgQm9yaXNsYXYncyByZXBseSwgaXMNCj4gd2hhdCB3ZSBleHBl
Y3RlZCBhbmQga25ldyBleHBlcmltZW50YWxseSwgYW5kIGRvZXNuJ3QgcmVhbGx5IGhhdmUgYW55
DQo+IGJlYXJpbmcgb24gTGludXgncyBSTkcgb3IgdGhpcyBkaXNjdXNzaW9uLCBzaW5jZSBSRFJB
TkQgaXMgYWxsIHdlIG5lZWQNCj4gYW55d2F5LikNCg0KQWdyZWUuIEp1c3Qgd2FudGVkIHRvIGhh
dmUgaXQgYWxzbyBpbmNsdWRlZCBmb3IgdGhlIG92ZXJhbGwgcGljdHVyZS4gDQoNCj4gDQo+IFJl
Z2FyZHMsDQo+IEphc29uDQo=

