Return-Path: <linux-kernel+bounces-104171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 772BB87CA21
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 09:43:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF633B21EDB
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 08:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF06B1757A;
	Fri, 15 Mar 2024 08:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZusRqSPz"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB3679E4;
	Fri, 15 Mar 2024 08:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710492216; cv=fail; b=jXwr+4kefz1wvxr0ir0NONUvLNym+TPGt97Db0tqzshE/r880PmYf7oF1xSq+PTeMbNpA3Tt8CfvKARYTLmJNOHqNuubZ90uUleU2aRVoBpYkjiw+4sfjfriLmDN4H4SNnbfakZK1fAk6kPyEbTl11JfATCZRjK1Cz/zflUfSrQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710492216; c=relaxed/simple;
	bh=CwcLAQGdeD/pnj+VUTMeqwANopru4cHDexJN94tcRqA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HLvdvwxk+zYCvc2OlsPwWzEOMzNfM1d9nU0Qedh0VLPcUmtCri21raDuo2MZopx4rsYLi2gAiEEHoo3JOZWBeeaKhBEefntOyWLhygPXFfMWKwuyk6hGkI7lEhJ+p+l0qrZ37Em9VxjfhLUY+Li4Gb9t9xv1vicEK3rgo0q5XPs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZusRqSPz; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710492214; x=1742028214;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:mime-version:content-transfer-encoding;
  bh=CwcLAQGdeD/pnj+VUTMeqwANopru4cHDexJN94tcRqA=;
  b=ZusRqSPzxGiwFzlD+i9sX5JnGnHNzObHrjUyBBm3/0iDrHQuHq8zVB54
   rTtVyfFZeWEqWePtzAeh0NELLMe7Hk82oa4wifxP9hCKWn2CNV3qLS5S3
   zdcB9Z0yfoL8E8SrTaFzlClUtd4Z3YfXlbUH21DjIQk6YMFv87PFVwneD
   yehfJOAq44GuVIN24NAiseLOEQXcpVDL8pMYTUNCWmqH9oeq6u0x8LmNx
   A7EXdkIWHCVMEJBc7Al1DbvyDCQwJRa3mQ75b0w3JQ0UpO1ttu5zw6q1C
   ZLGiUr+XguitHoAJ2vGFlWyNLGXTFKZ4N/RYI6nSupyGVpwToMbEoSVa/
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11013"; a="15900310"
X-IronPort-AV: E=Sophos;i="6.07,128,1708416000"; 
   d="scan'208";a="15900310"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2024 01:43:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,128,1708416000"; 
   d="scan'208";a="12507512"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Mar 2024 01:43:33 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 15 Mar 2024 01:43:32 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 15 Mar 2024 01:43:32 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 15 Mar 2024 01:43:32 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 15 Mar 2024 01:43:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PDvzKNPGT/9TWUo94pYWuEJbi2ciHdaFm/96dWfDTOFvlXm1lM/z4eRZwG1cr/AdGqF73PHs00NyePZd0BSPK9lMBTuuPqQOBPcLya9Ulhg+ufRiHdLPU+Wje8UlkgdnK5UieBn2ubeAiYZNFbifOinFmK1/+4BMAtWYG76pttFxuLbHzHuv8uuCLesJXk1S1Hef8ExgcKKGz8KYLkdsEN7EpqJCW72G3LPIXAdTjirQ/wxa7vmZNTG41QdYUVIlGx15O/8ppnqbJqPX49E096JbLiVyd55Sb4WKl9lYZpp3zybRGgU4dkTpsqHoCkxqi+m1gq4hoY7B6ygJTAuIUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z/RpwFxKIWYHrlbc3s9pZN+u5Wix4u5Znv9DGL3w2fU=;
 b=S2AKJXvrf6UPUz0CWT2xFfJm3H8/4NeKFT8rP9aNXsbukrwRqnsdFp6Wtj7AjN8va7TV5zfv0n0FKBKtY9himVZQJGlUjcVsOZ59v8JyJ1T0vA9/OkirO2GPsOcMtNjJzjRQ0mDgGhGi5CigImPv/H6eK7dDurjDMJLhWhuYSV+nyanSpfW/wwdXD7mWB2sCIZ34BUMChabr2dWdMyeGYBo2enk5epn0h05YbbYxpqk8sbDXe+/+My27Wu8oYtoaOdEW+D4u2ylYv00PttkCDqIosZ7FPHfAIUQ4LLRLw1Jtf0mnEY4duB2dsh2dj5MTiX39PAaZugX4WgpUxbkqmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN2PR11MB4566.namprd11.prod.outlook.com (2603:10b6:208:24e::16)
 by PH7PR11MB7720.namprd11.prod.outlook.com (2603:10b6:510:2b3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.17; Fri, 15 Mar
 2024 08:43:29 +0000
Received: from MN2PR11MB4566.namprd11.prod.outlook.com
 ([fe80::39be:a2b8:752e:a089]) by MN2PR11MB4566.namprd11.prod.outlook.com
 ([fe80::39be:a2b8:752e:a089%6]) with mapi id 15.20.7386.017; Fri, 15 Mar 2024
 08:43:29 +0000
From: "Willgerodt, Felix" <felix.willgerodt@intel.com>
To: Borislav Petkov <bp@alien8.de>
CC: Vignesh Balasubramanian <vigbalas@amd.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-toolchains@vger.kernel.org"
	<linux-toolchains@vger.kernel.org>, "mpe@ellerman.id.au"
	<mpe@ellerman.id.au>, "npiggin@gmail.com" <npiggin@gmail.com>,
	"christophe.leroy@csgroup.eu" <christophe.leroy@csgroup.eu>,
	"aneesh.kumar@kernel.org" <aneesh.kumar@kernel.org>,
	"naveen.n.rao@linux.ibm.com" <naveen.n.rao@linux.ibm.com>,
	"ebiederm@xmission.com" <ebiederm@xmission.com>, "keescook@chromium.org"
	<keescook@chromium.org>, "x86@kernel.org" <x86@kernel.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "jinisusan.george@amd.com"
	<jinisusan.george@amd.com>, "matz@suse.de" <matz@suse.de>,
	"binutils@sourceware.org" <binutils@sourceware.org>, "jhb@FreeBSD.org"
	<jhb@freebsd.org>
Subject: RE: [PATCH 0/1] Add XSAVE layout description to Core files for
 debuggers to support varying XSAVE layouts
Thread-Topic: [PATCH 0/1] Add XSAVE layout description to Core files for
 debuggers to support varying XSAVE layouts
Thread-Index: AQHadgIwSxIkfuYuPE6B9BKDFgzWiLE3GuDggABT34CAAQBKoA==
Date: Fri, 15 Mar 2024 08:43:29 +0000
Message-ID: <MN2PR11MB4566300360E97CCA874ACE8B8E282@MN2PR11MB4566.namprd11.prod.outlook.com>
References: <20240314112359.50713-1-vigbalas@amd.com>
 <MN2PR11MB4566BF54DEFF9B7627B096B78E292@MN2PR11MB4566.namprd11.prod.outlook.com>
 <20240314163345.GBZfMm6Ve5QMY_xPjl@fat_crate.local>
In-Reply-To: <20240314163345.GBZfMm6Ve5QMY_xPjl@fat_crate.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR11MB4566:EE_|PH7PR11MB7720:EE_
x-ms-office365-filtering-correlation-id: 4c031c0a-1ad6-4430-2b60-08dc44cbfd40
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: G5VW7Q6WtDkjLsEqorOeaUtBmPKqtKRiu8/vntqKXdNg+ESQcZACwXBPSa4T4IsLb9cD8yb5RrOCHs7Ra4yhXw+BoGTCYXu4+6xHIgP+/8Pe90pfXu6tN00BzV+X9kCwaaedQSFtoI8h63kx7WCjlu/uOaZaaNy4Exb9adkgxOd4zh6J8piVpjhrvsbOruy3DseM+ymIvczHd0oeEITaS3QpknkmtZBjyRHd2ojCt8aWDfgRJof90cSKw9NYmzA3e1br2YKcbFpcH12tWxpNJzxg/A/Jm2kQ8cyO8dWYuY6mXU556mT1OaUE5ZV4mtEvFrz+Eq60kl2JYUkLWPwD/dhtXMKM4DH3XKiUHHGWTgq1ySQ6gVy1+PrLRpIU9CAjfQoCYFtNX7I1BxgSxvXjz2TbWkvomEJMe+Cwm7p90hw7C2KOlgqzd23eJnVOXPJ7Ps7hPv2UITIF08CZdZ7eGAjSCVUJMjgWMIPlYpRpkpC2WGaY0s9m24Xhpl+fcecDHP3WHlnEjDgf38aohkgfrYs+fe0zNtIjDqssf45bqJ5yzmeY2Icm76t4jMjFfTvnoLEkSTbWIp/IF4SDlhLrYmLcHiQswHDcif16fEeN39FTY/9mSfnXVMl1CW4xp6D34FuV5Jw1F3IcpzPOvaeohG2iXbU8EJbd5UpRqCrkToEERAOUsII+wrQg939TsqKiRAZacy4UxEc3nYp40gZ+2HQagkZfTnNCFxqgOAKi5qk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB4566.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(7416005)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SEFDUHNsckI3emJSSXF4ZEJuSkhraFVVS2ppZGJtaXAxM0Qwd1h4K3dhVVlI?=
 =?utf-8?B?OGlPelRwTGlsMzJsT0hUdVhuZklMeU92Y2FCVEFNRFVCZjJPekd6UzlYM3Z3?=
 =?utf-8?B?MUZrNStNbWEvRm81cVA0QUJoWi93ZU1EeVRFQUFMZDdhdXVFWmtjYll4eTRn?=
 =?utf-8?B?R1RZM2swVmYwYjQ3SjVRdXRYVit2TlFYRUZ3dUtEaUk0K0dVcUdCTHFJdnVv?=
 =?utf-8?B?MGxPMnI3NVVibWd0Und1OXpGenhIMzJ4WU91aGQ0elBpbUFZT1JZYXdTT2dz?=
 =?utf-8?B?Y08yYnpJZFlQQXpzOExjbnlRRHduRDZRTU10Ni9lRHJXVUlCclU3amJjbTRW?=
 =?utf-8?B?cE9Mam16Q2VRT3BwaThDY2JTWUxqelBYbUZWeHlTSWV3M2MvY0lPRjhFNDdZ?=
 =?utf-8?B?NkpoWU9NeVRxVDhwUHNuaHRXYnNPMWo4WTcrTC9YejRkOGk0cEhoRUtPZ1Fo?=
 =?utf-8?B?NjBpY2xwTnFOUUhwVE9ySWI1WmNJeWlidWxBbkJCSm5xYlNuVjkyWXJJbmMz?=
 =?utf-8?B?VjVyUUgwdzRvSGZJOEZVMnJZTW9ZUHlFcXVDci9rYWVPdldLTVpiMkFtZFho?=
 =?utf-8?B?M1Q4TVZ4bFZwMVBlOU5yUFcvNDhITWMwc2w5THhldEdEdiswNFl2eGpldWtZ?=
 =?utf-8?B?VE10YmJ3OVpPZkszSWpKbGg5M1A4NTRIeDZTdVpGR2VmM08ybDRlc1orSnkw?=
 =?utf-8?B?anRuODBnRFNTR0dBbWw2amNvckZlZTd2NDVaZms4bm9tLzNKSkE5RWgzRi93?=
 =?utf-8?B?bk1oTGgxaW9iZllhdTBoWVpBTlo1dXhQYnFOTUoxc2o3blVFdXc3ckxQYUIy?=
 =?utf-8?B?dXk1YUxnNlFGZTR3ZEhaWkZ4dmE0SkVYVWRaMHJIUFhFTTJ3eCtOMUsweGxu?=
 =?utf-8?B?MHo3WC85TUwyQ0lFS0dURmhDakJKLzJqUS9WR1lnZmZTTkNnb1Zzc212Mms0?=
 =?utf-8?B?QVlaRzNQbndYUUhjak9rOTFwQ3MrTWdFN2dYa29JaXh5TkQrYUlVc1VuY1M2?=
 =?utf-8?B?OXJBQzV2L0dmWmd1OXk5eWdRYlAwUGxUS0lmemx5ZHJCbU5udXJEMkhnQnJ0?=
 =?utf-8?B?M0Znb1ljak9tVG8rdlhKdWtEM1kyWWtsalpUeWRxS05GZ1BBRjhoM25FUHRv?=
 =?utf-8?B?NTd0TzFLd1FRRUtibHZzRzVRakFPVUdzcFY5U2o3NzljaVdRQjAxaGlaR2VU?=
 =?utf-8?B?MnV2Szk2emZPL1NGWjlBT0t1TldOOW1OdzdOeER2Vk1NaW1vbHZkMmIwMWVO?=
 =?utf-8?B?OHUyNzc3d1FHVXVuSDkwV1ZhbjZFQ0VMVWk0TGdGcG1FUzNNUzFHdkJ0eEda?=
 =?utf-8?B?dmhWN255a3ZPR0VtangySm1oZUE5MjNnK3BnZm1QcytndnE3VHJ6NlUrMjA0?=
 =?utf-8?B?azMzVmNRVHBUSmFWWGNGM0g5SjVQSG9zSE9DUWlublFnQVQvT3pzUkYvbTBa?=
 =?utf-8?B?bFQ3L2kvUHNkUk9lRVdpSGJGMDBmR3RZTXVkTmpxdUVzMDFmT0xhU0hBV2E4?=
 =?utf-8?B?TFZBREFGOVUxc2pOUVJCMFhXMkQ2MXZEK0VMK0p1b204RTREQm9Wa2VNRis3?=
 =?utf-8?B?Y25Gd0NFWUY1eVZoTU5DWEpqNjk2V3NXQ254bERJNEF5MXBvSlJ2OW5XT2t3?=
 =?utf-8?B?SS9qNHU2SDlMY3BKTWFpS2dTOUlNK2dFREhIMkFQMWV5d2JSRCtiM3RvczFD?=
 =?utf-8?B?Q1phWmgrK1F3STNoK3JTRmVoSUdoSGlaRSs2bzZnazU0cFJ5cDc4QUM3WFNu?=
 =?utf-8?B?S3pUV2dzdnVBdCt1bklKWUVWWWVQNFA4VDFNOXZCVUlxQXVFcUdzRUFPRld6?=
 =?utf-8?B?V0Q2MFJyTTFNNkRJV2VBRnY4YXMwZWFOaGtPdmhodGVTSGN5bEZDSStVV3J4?=
 =?utf-8?B?c3VRWnNEV3lhZExhVzhScHZsSUxIQXYzMS9BQm4zNWc2ZjFQY0NnNlJyejZ2?=
 =?utf-8?B?d1R0UTNnWHJCcG92aC96V2sydVZuWWl3c0VxMDB4bHVRQStNOHNTTDdmSy8x?=
 =?utf-8?B?V25LRFBsSFV3d3BLL1BFNFRlMFFlN01pNXlrQ3RkcUJVeVZKMCt0T0VTNDRU?=
 =?utf-8?B?SENnaEZtUWt3Nzdoa0JGNjR2S0Q1T0x6aTBXUzg5Y1JKLyt2NjZXcThWaTFm?=
 =?utf-8?Q?lBrpZ4SqYQbZW8UhD+EveIpXK?=
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB4566.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c031c0a-1ad6-4430-2b60-08dc44cbfd40
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2024 08:43:29.7303
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7Rj82OAgvSDdRhenDjW2OSesLx+URRlSYiabMKzl2YKOocwfXHSo2XJRy2vniSNI9LUcZhSoaP3BXAK8/FWeiDKgOesKrkNDShwGCuNUPyk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7720
X-OriginatorOrg: intel.com
Content-Transfer-Encoding: base64

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBCb3Jpc2xhdiBQZXRrb3YgPGJw
QGFsaWVuOC5kZT4NCj4gU2VudDogRG9ubmVyc3RhZywgMTQuIE3DpHJ6IDIwMjQgMTc6MzQNCj4g
VG86IFdpbGxnZXJvZHQsIEZlbGl4IDxmZWxpeC53aWxsZ2Vyb2R0QGludGVsLmNvbT4NCj4gQ2M6
IFZpZ25lc2ggQmFsYXN1YnJhbWFuaWFuIDx2aWdiYWxhc0BhbWQuY29tPjsgbGludXgtDQo+IGtl
cm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LXRvb2xjaGFpbnNAdmdlci5rZXJuZWwub3JnOw0K
PiBtcGVAZWxsZXJtYW4uaWQuYXU7IG5waWdnaW5AZ21haWwuY29tOyBjaHJpc3RvcGhlLmxlcm95
QGNzZ3JvdXAuZXU7DQo+IGFuZWVzaC5rdW1hckBrZXJuZWwub3JnOyBuYXZlZW4ubi5yYW9AbGlu
dXguaWJtLmNvbTsNCj4gZWJpZWRlcm1AeG1pc3Npb24uY29tOyBrZWVzY29va0BjaHJvbWl1bS5v
cmc7IHg4NkBrZXJuZWwub3JnOw0KPiBsaW51eHBwYy1kZXZAbGlzdHMub3psYWJzLm9yZzsgbGlu
dXgtbW1Aa3ZhY2sub3JnOw0KPiBqaW5pc3VzYW4uZ2VvcmdlQGFtZC5jb207IG1hdHpAc3VzZS5k
ZTsgYmludXRpbHNAc291cmNld2FyZS5vcmc7DQo+IGpoYkBGcmVlQlNELm9yZw0KPiBTdWJqZWN0
OiBSZTogW1BBVENIIDAvMV0gQWRkIFhTQVZFIGxheW91dCBkZXNjcmlwdGlvbiB0byBDb3JlIGZp
bGVzIGZvcg0KPiBkZWJ1Z2dlcnMgdG8gc3VwcG9ydCB2YXJ5aW5nIFhTQVZFIGxheW91dHMNCj4g
DQo+IE9uIFRodSwgTWFyIDE0LCAyMDI0IGF0IDA0OjI1OjQ0UE0gKzAwMDAsIFdpbGxnZXJvZHQs
IEZlbGl4IHdyb3RlOg0KPiA+IEkgYW0gd29uZGVyaW5nIGlmIGl0IHdvdWxkbid0IGJlIGVhc2ll
ciBmb3IgZXZlcnlvbmUgaWYgY29yZWZpbGVzIHdvdWxkIGp1c3QNCj4gPiBjb250YWluIHNwYWNl
IGZvciBhbGwgcG9zc2libGUgWFNBVkUgY29tcG9uZW50cz8NCj4gDQo+IFlvdSBtZWFuIHdlIHNo
b3VsZCBzaHVmZmxlIG91dCBmcm9tIHRoZSBrZXJuZWwgOEsgb2YgQU1YIHN0YXRlIGV2ZW4gaWYN
Cj4gbm90aGluZyB1c2VzIGl0IG9yIHRoZSBtYWNoaW5lIGRvZXNuJ3QgZXZlbiBzdXBwb3J0IGl0
Pw0KPiANCj4gVGhhdCdzIHNpbGx5Lg0KDQpJIGRvbid0IHRoaW5rIGl0IGlzIHNvIHNpbGx5IDsp
IExldCBtZSBlbGFib3JhdGUuDQoNCkkgd2FzIG1vc3RseSB0cnlpbmcgdG8gc3VnZ2VzdCBhbiAi
ZWFzeSBmaXgiIGZvciB0aGUgTVBYIGlzc3VlLg0KSSBhbHNvIHNhaWQgdGhhdCB3ZSBjb3VsZCBk
cm9wIGZlYXR1cmVzIGZyb20gdGhlIGVuZCBvZiB0aGUgbGlzdCBpZiB0aGUgQ1BVDQpkb2Vzbid0
IHN1cHBvcnQgdGhlbS4gWWVzIGl0IGlzIHN0aWxsIHdhc3RlZnVsLCBidXQga2luZCBvZiB3YXMg
dGhlIHN0YXR1cyBxdW8NCmluIHRoZSBwYXN0IGFmYWlrLiBBbmQgeWVzLCBpZiBuZXcgc3RhdGVz
IGNvbWUgYWZ0ZXIgQU1YIGl0IGNvdWxkIGdldCBtb3JlIHdhc3RlZnVsLg0KDQpUaG91Z2ggaW4g
YW5vdGhlciBlbWFpbCBoZXJlIERhdmUgc2FpZCB0aGF0IHRoZSBvZmZzZXRzIGluIFhTQVZFDQph
cmUgImZpeGVkIGluIHByYWN0aWNlIi4gVGhhdCBtYWtlcyBtZSB3b25kZXIuIEV2ZW4gaWYgd2Ug
YWRkIENQVUlEIHRvIGNvcmVmaWxlcywNCndpbGwgSW50ZWwgQ1BVcyBiZW5lZml0PyAoSSBhbSBu
b3Qgc2F5aW5nIGl0IGlzbid0IHdvcnRoIGNoYW5naW5nIGV2ZW4gaWYgSW50ZWwgQ1BVcyBkb24n
dC4pDQpFLmcuIHdpbGwgd2UgYWN0dWFsbHkgZ2V0IHJpZCBvZiB0aGUgOGsgdGhhdCB5b3UgYXJl
IGNvbXBsYWluaW5nIGFib3V0Pw0KSSBkb24ndCBrbm93IHRoZSBhbnN3ZXIgdG8gYmUgaG9uZXN0
LiBJZiBYU0FWRSBvZmZzZXRzIGFyZSAiZml4ZWQgaW4gcHJhY3RpY2UiLA0KSSBkb24ndCBzZWUg
aG93IHdlIHdvdWxkIGJlbmVmaXQuDQoNCkFuZCBob3cgd291bGQgeW91IGNoZWNrIHRoYXQgIm5v
dGhpbmcgdXNlcyBBTVgiLCBpZiB0aGUgc3RhdGUgZXhpc3QgYWNjb3JkaW5nDQp0byBDUFVJRD8N
Cg0KPiBQbGVhc2UgaGF2ZSBhIGxvb2sgYXQgdGhpczoNCj4gDQo+ICtzdHJ1Y3QgeGZlYXRfY29t
cG9uZW50IHsNCj4gKyAgICAgICB1MzIgeGZlYXRfdHlwZTsNCj4gKyAgICAgICB1MzIgeGZlYXRf
c3o7DQo+ICsgICAgICAgdTMyIHhmZWF0X29mZjsNCj4gKyAgICAgICB1MzIgeGZlYXRfZmxhZ3M7
DQo+ICt9IF9fcGFja2VkOw0KPiANCj4gV2hhdCBpcyB3cm9uZyB3aXRoIGhhdmluZyBhIGJsb2Ig
b2Ygc3VjaCB4ZmVhdF9jb21wb25lbnQgdGhpbmdzDQo+IGRlc2NyaWJpbmcgdGhlIFhTVEFURSBi
dWZmZXIgYW5kIHBhcnNpbmcgaXQgaW4gZ2RiPw0KDQpJIGRpZG4ndCBzYXkgaXQgaXMgd3Jvbmcg
b3IgdGhhdCBJIGFtIG9wcG9zaW5nIGl0LiBJbiBmYWN0IENQVUlEIGluDQpjb3JlZmlsZXMgY291
bGQgYmUgdXNlZnVsIGZvciBvdGhlciBzY2VuYXJpb3MgYXMgd2VsbC4NClRob3VnaCBhbGwgY29u
c3VtZXJzIHdpbGwgbmVlZCB0byBhZGQgdG8gdGhlaXIgaW1wbGVtZW50YXRpb24uDQpJIGFzc3Vt
ZSBMTERCIGFuZCBHREIgYXJlbid0IHRoZSBvbmx5IGNvbnN1bWVycy4NCg0KRmVsaXgNCkludGVs
IERldXRzY2hsYW5kIEdtYkgKUmVnaXN0ZXJlZCBBZGRyZXNzOiBBbSBDYW1wZW9uIDEwLCA4NTU3
OSBOZXViaWJlcmcsIEdlcm1hbnkKVGVsOiArNDkgODkgOTkgODg1My0wLCB3d3cuaW50ZWwuZGUg
PGh0dHA6Ly93d3cuaW50ZWwuZGU+Ck1hbmFnaW5nIERpcmVjdG9yczogQ2hyaXN0aW4gRWlzZW5z
Y2htaWQsIFNoYXJvbiBIZWNrLCBUaWZmYW55IERvb24gU2lsdmEgIApDaGFpcnBlcnNvbiBvZiB0
aGUgU3VwZXJ2aXNvcnkgQm9hcmQ6IE5pY29sZSBMYXUKUmVnaXN0ZXJlZCBPZmZpY2U6IE11bmlj
aApDb21tZXJjaWFsIFJlZ2lzdGVyOiBBbXRzZ2VyaWNodCBNdWVuY2hlbiBIUkIgMTg2OTI4Cg==


