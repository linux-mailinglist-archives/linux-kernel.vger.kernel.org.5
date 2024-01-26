Return-Path: <linux-kernel+bounces-40289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0289483DDBC
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 16:42:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF36C284646
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 15:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 769F51D522;
	Fri, 26 Jan 2024 15:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iyZHHmWo"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE1D1CD26
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 15:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706283739; cv=fail; b=SQXFFcjlxCBS71BXqLwHzsKC7hnbf3k00twpnAF2iVNNd1IW3lXiViYGgYkoON93JiCZu7kHdP2KKkjnBDJdGHR0rGQJl7IwIRD2wINDfSATZ1DvZntqVsu8pNxxRX01SByqziqzjg9WGrSFDevKJcAxx7R5NPU/R9tEyqFnRfY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706283739; c=relaxed/simple;
	bh=UwgULD178W7Vb7VMM6nrP0Xfk7GPWvmRJo1N26QgRiw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=On5GIWcbc8xbq2Z0CHZkD9w2IoWSnwohoeBGHR1tlyZ9xQbuVK1LjTwAa2BfB5EESZUKX+X7M8P32FXaTOkkkmk/k3FtvlGZjzRKl8qg/giwf7OtFZ5+68aHMUW8FZpGLflBi0D2LrliDvIpTWhlFPja9LR7h2kbdmyLzPI7/+o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iyZHHmWo; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706283738; x=1737819738;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=UwgULD178W7Vb7VMM6nrP0Xfk7GPWvmRJo1N26QgRiw=;
  b=iyZHHmWoxOHfS1cbnUde0Vfp9BrU6fd+oEokab24F5UO4LghHRNwKGM5
   GDZ15enxfpTh22lHul94+G/8XH2EpORrc+H9lzaPxeBgyoFxZBbr39xWB
   81Y/Q9kQT0u5BD7FlrZgD25DnPDeGdu94oLInZ1FdfMMNjJBe6RqG8HSd
   QdiKtxkDeRSCBBwcolvOztf9wzfB1q/Jl2EAjhi9UQZagPrpA7WXtvNWk
   OzrWcmoteu1K0rfUfa8zFNvT9xZdo7VLW5kEHFificyjWPMxXnpK1QkIf
   TSBpDgB3a1xcSh1GEhJniwqLnMoiB4Py5S0z8XoBN5iUCxkFSibcKtDhi
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="16026669"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="16026669"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2024 07:42:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="960233272"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="960233272"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Jan 2024 07:42:16 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 26 Jan 2024 07:42:16 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 26 Jan 2024 07:42:15 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 26 Jan 2024 07:42:15 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 26 Jan 2024 07:42:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D/XanBmz0vFE7iJHKZLmQ0pkl0mYPzkSYLRNfplgWpMDFLQBt/INZQ9XNIrCA9lg7l7WTHuTvbmarynryFS2wczsvSE8mDk9msCuZYEOhg3HusuYKnQhsjjJIARcJnvo4qjBVQElEPfmDv2V45CgeNxK+kbaAx77V5VPKbCgI6RE/fWas3a3eHJGzJejmq8D/AgFGKN68Yn3fp5k4b2r5+eluICUltjuBfN4HUuP6n6rI6BvdxwWghdOsfhbQMl8wBb5SKFw/weupoEpnamiixJWFkYn9nfijpH4niMf0pBDa0OkDFM+QUYBoRxF6KLuYVnjkrxZO7z2P4PvHDpTPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UwgULD178W7Vb7VMM6nrP0Xfk7GPWvmRJo1N26QgRiw=;
 b=ZokMuoU5AW46u7kOCnJbct2M/lmFLQYrJm/4DnPKX79VdwxELB/dDx1OLiTjjAphy3UWxdGrQjt9idn67wTVui+hfUhRTp/MgylOH31RJsqTUHKjZTCSBrcjTxVg5Mtx3/V0dqJHetTa7elc2OmpmYx1M0e/FavGl+1WY3Iy/nw2GVUPiCGDVBiGk6VwpkbHUCDNM9fEZJzTDsu0kvGKLmSekrDU1ZQKm8nx96JO8HcBI/gTcJZU+NuNuXXYZVWxmw86YCrSPrPrlWkwJIyNmsHsXMnPnZGGdwwfk1/N7NGzqHzrOoQj7bVMNxCasnG+/EjnARNOZVMoTXrFI2y6Ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5750.namprd11.prod.outlook.com (2603:10b6:8:11::17) by
 CY8PR11MB7846.namprd11.prod.outlook.com (2603:10b6:930:79::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7202.38; Fri, 26 Jan 2024 15:42:13 +0000
Received: from DM8PR11MB5750.namprd11.prod.outlook.com
 ([fe80::f1b2:bfb1:b1b:66ed]) by DM8PR11MB5750.namprd11.prod.outlook.com
 ([fe80::f1b2:bfb1:b1b:66ed%3]) with mapi id 15.20.7228.027; Fri, 26 Jan 2024
 15:42:12 +0000
From: "Reshetova, Elena" <elena.reshetova@intel.com>
To: Nikolay Borisov <nik.borisov@suse.com>, "Kirill A. Shutemov"
	<kirill.shutemov@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>,
	"Ingo Molnar" <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
	"x86@kernel.org" <x86@kernel.org>, Theodore Ts'o <tytso@mit.edu>, "Jason A.
 Donenfeld" <Jason@zx2c4.com>
CC: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	"Nakajima, Jun" <jun.nakajima@intel.com>, Tom Lendacky
	<thomas.lendacky@amd.com>, "Kalra, Ashish" <ashish.kalra@amd.com>, "Sean
 Christopherson" <seanjc@google.com>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [RFC] Randomness on confidential computing platforms
Thread-Topic: [RFC] Randomness on confidential computing platforms
Thread-Index: AQHaUF3eVzWxkihyOEqZjVbKjj5n1LDsLEEAgAAOodA=
Date: Fri, 26 Jan 2024 15:42:12 +0000
Message-ID: <DM8PR11MB5750C6641F0951928E95439BE7792@DM8PR11MB5750.namprd11.prod.outlook.com>
References: <20240126134230.1166943-1-kirill.shutemov@linux.intel.com>
 <6afe76be-90a7-4cf7-8c6c-23e6a14f8116@suse.com>
In-Reply-To: <6afe76be-90a7-4cf7-8c6c-23e6a14f8116@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5750:EE_|CY8PR11MB7846:EE_
x-ms-office365-filtering-correlation-id: 80e3b8ed-d8d3-4ddc-d1a0-08dc1e855d88
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZoHXPWqcbg2bbS2IwrFtALQN8KB8fB+9U7rfIdja7o9//Wf99pCZB/QwhAjgajZevlue5Q9s45lntxER9LBiWf4tOv/TpEgMvWI+ZngzZl6VcUWjSWE93Z5JWLEdZtfuhGnuEkmr5mqsIJYHyYZeanMXlmHHcIa7XAMoWuJxjizfs/U9xofwgAedemRSpfaBHczAY6UUMXp955OiCAO3hXQ5u1vtD/87Pr5t87W1HJS8HBxGw+PfseAT4wofdf2gEZXi2vtIi9vjkVLdIOk8fj1JvbDp9424xVxfBamwcGQyw9CYmaTJh88m8ctmDaO1T50a4VpYmt4xuQEUGB6vwuHPHqrRkF9ytXirii3oqKEaxY6QNP5seUdb36HRgV8a+lwdnjFi7vgOK2CqUV1p0PN8wdZC8n6dMWVCMBUnBQWvFhVBy5ilILQbr2IhfeivxrpO9lTS/P9KFhQTCJcnJdfuLKY4rQ5J/OA2N0oMSLpOKkwU5uzwZLFoBDl8szGTGzitXoqVQwcc24SVeYp6bek3BZO2mNnFZXwLerArjieSia/8CW0Z4Wts+f5kjAydtXYxkHREyDzWhQiytxFYJLTQqauVIZW3a6vrjSAgj0gMxdb5CaVPcu+CTHP3acbs2du8613HRIJEcvFzARFyHg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5750.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(396003)(376002)(136003)(346002)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(55016003)(83380400001)(26005)(9686003)(41300700001)(921011)(38070700009)(82960400001)(86362001)(33656002)(52536014)(122000001)(38100700002)(54906003)(66946007)(66556008)(7416002)(71200400001)(6506007)(110136005)(5660300002)(66446008)(64756008)(8676002)(7696005)(76116006)(66476007)(2906002)(478600001)(316002)(4326008)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WHlHRGlyK3YxTUlVV0NpNlBEa1hDbGFLNzE0WmFqcURnNkd6eHNOUkJxaXVo?=
 =?utf-8?B?ckMzamVmTFRKUmJ2ejNGOHdjTzRML1hMbVpwY0c2U1NSSnJMT3BFLzR4cGdi?=
 =?utf-8?B?VWVJN2trZVBRbHd1SjVkWGlnTis4NVFRZnRoM1lYVk92eUtZMDR6d2xMMERY?=
 =?utf-8?B?alYxQ2VrZHFtWGJzaTR0K0cvQ2hud2szY05iQUFOb2lrYUhwRkxONTRhSWpv?=
 =?utf-8?B?ZzNGV253SktycWFKelBVdTlaRmRrNzhBaEdFeDdlZ3VkMnZOMldRWndXdWVK?=
 =?utf-8?B?Zy9OZjhXcjhvL0MySFFKOU1OOStKSWxqNUZoRjBkWldVSUpyNmVmWEhLRTI2?=
 =?utf-8?B?WnVZTmV4MlhlK0FOZDhaUTZySUdlbjdMdzRXNndSdEN1bEhUYzdLQVFBWVo2?=
 =?utf-8?B?ZlpoN2NoK2pHQWZUM1FUZUhYd3FqZHdaVDdCSEI2bmNQY2ZVcnZCSHdLYjNS?=
 =?utf-8?B?SUlOV3RhUllDN3NvVHMyR1NEdE1qZ3VBYmVzeEVwSXNpdHFqUmozemJvMkc4?=
 =?utf-8?B?V3pSZkoyYmpRbjQzSXlPODhtcXpIbTdWSDFlczJiOWR4MnI1dnlLUHVGYTlP?=
 =?utf-8?B?VVk3Q2pZQi92d2lRV0V2dDk5eVBPUlc0VWxCUG4zS2xxaERMeVVIS2QvdFFz?=
 =?utf-8?B?RkZna2xLbDBaTDNqcGtncmFWazBYTmJHck9QR3o5Ti9pcG84aTBtK3Vqd29w?=
 =?utf-8?B?R3dBc1o4QkFMeE5CMlZVcXNHMlhzcmVUQjVDNERRc1hraHN3R1BBaGd1dWhL?=
 =?utf-8?B?NDhGaFQ4YldpWEY5UHZjR2UwcFplTVlCbkUwdGpDOHh0UVN0ZzA5bmpWL2Q4?=
 =?utf-8?B?cGdYZmdOa3lNZVM2T013SEQxVVFvR094THMwUjMwbEV0YUtPTW41d0FMNmhK?=
 =?utf-8?B?YUNoaVVEM0FoRzV0emVKN3BxN3h3TmhRdlNXemd3a3hiN21BaHBXbllRdHE4?=
 =?utf-8?B?RU01K2tVTG83OE1rTEFVaEY5MkFnMzhUV3Iwdjd4Y0Zob3R1eWN2WUY0MU5H?=
 =?utf-8?B?Y0RNa0E4dHpDaGpiYmZ1QXVOaDl3L3RvdUJtMnl4TDZBRGxGTU5FT0FDOFF5?=
 =?utf-8?B?Q0hhMWprN2tMNVpEVzRZUGgwMERwaDBBcGFxc2pGOWN1aFQxTlJ5clRaWk96?=
 =?utf-8?B?MS9uRXFvVlB1NzdqaXY5MDY0NXpNbUhBd1F4R3hHMU1KUVVKSXNYZWJtZHk3?=
 =?utf-8?B?RFBiYXdBclNuVlBkQUh2TW5ibXE2ZUVqNkNtaVlZbGUwb2VKVHQybzBQQmVl?=
 =?utf-8?B?WWZFWjhsYU11VzRjb2gwMEdDTUdiTlgzRHVySVJUck9ZWjdNVWE4SkF0cVlE?=
 =?utf-8?B?YkZROHBGQTVMM20rb1h1aWc4b0FXT29vb0FrTGt3RHN2dXpqMm5XcE1LMFFk?=
 =?utf-8?B?NDJ1eE1HV284dUtMYXg3djhWOTZGbnU1VzFtRWY4UFA1d0d6aWhNWE1aNU9k?=
 =?utf-8?B?ZUFTTVk0dVVqdEJqMWYvL3VxeGxEY0lvcUhld2hiUU1ab2VGSktUaVZldW5r?=
 =?utf-8?B?WVcxVStWZUx3dnRHV1d5eU5BSXlFaTN6RE9aK2xtU0FYUTNwQUdqSHlKSStF?=
 =?utf-8?B?eWtjSWNBUzZSQ0hJVEZTcG9Vb1QycTVZZFExd1ZFNHpqS21BNnF3M3IzVzh6?=
 =?utf-8?B?SzQxeW50KzFabGNCZjhkSGVtOXZJTlpJcmlWSS9URGFZbkdvQVh3djZVRUo3?=
 =?utf-8?B?UEZkcVRDKzEzNzNpWjM0SWRjaWkwVkxaRUJXbm90SlV0RWJMaUtlRlpGMGNV?=
 =?utf-8?B?VWxicFQ1cHA2ZHVlZEpWYlZhSE5iem9kb0xRUXpJVlRpcWRLYUZ3V1JuaUZn?=
 =?utf-8?B?dm1KdnVFZ3V2RnZEc3FKMkJjRFlhVXd5ZWxBRWM5ODZFQ2VuR2lhekZZVUtk?=
 =?utf-8?B?N0R6UnU1K1BFaE9zc0xoRCtRTzhxdStBdzBLc1c4b2w1Nk9YdVFiTzRTS1Bm?=
 =?utf-8?B?N2RHYjRCaC9VcXNMcmVhdHJLZHlRdXd1T2J1R1hlUTRaRi9IbXJrVFFTck1X?=
 =?utf-8?B?VXhxWDBhOU15TlBnWjdyVy9lUkQraGtmTi9KRmNvTStsMWxsR05aUlVpMHI5?=
 =?utf-8?B?ckZBUWtoaXl1MXJoNEx2QmNMbnFLU1NWVXVRdWszdEZDM2dyWEt6Rk9RcGhR?=
 =?utf-8?Q?4Nnn4slwYpFy1jfFL/miUGE6H?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 80e3b8ed-d8d3-4ddc-d1a0-08dc1e855d88
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2024 15:42:12.7891
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +b9aQyxDHZKaBOqtT2E5QHK6IbPBh0LKcpe/cbLKr1F4in2yDBNpiDXQWGs+zYqJ9jO2dKUPqRSzxkJgPNxjIoutJ4XXo3HYUxs4wl08+cs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7846
X-OriginatorOrg: intel.com

PiANCj4gT24gMjYuMDEuMjQg0LMuIDE1OjQyINGHLiwgS2lyaWxsIEEuIFNodXRlbW92IHdyb3Rl
Og0KPiA+IDQuIEV4aXQgdG8gdGhlIGhvc3QvVk1NIHdpdGggYW4gZXJyb3IgaW5kaWNhdGlvbiBh
ZnRlciBhIENvbmZpZGVudGlhbA0KPiA+ICAgICBDb21wdXRpbmcgR3Vlc3QgZmFpbGVkIHRvIG9i
dGFpbiByYW5kb20gaW5wdXQgZnJvbSBSRFJBTkQvUkRTRUVEDQo+ID4gICAgIGluc3RydWN0aW9u
cyBhZnRlciByZWFzb25hYmxlIG51bWJlciBvZiByZXRyaWVzLiBUaGlzIG9wdGlvbiBhbGxvd3MN
Cj4gPiAgICAgaG9zdC9WTU0gdG8gdGFrZSBzb21lIGNvcnJlY3Rpb24gYWN0aW9uIGZvciBjYXNl
cyB3aGVuIHRoZSBsb2FkIG9uDQo+ID4gICAgIFJEUkFORC9SRFNFRUQgaW5zdHJ1Y3Rpb25zIGhh
cyBiZWVuIHB1dCBieSBhbm90aGVyIGFjdG9yLCBpLmUuIHRoZQ0KPiA+ICAgICBvdGhlciBndWVz
dCBWTS4gVGhlIGV4aXQgdG8gaG9zdC9WTU0gaW4gc3VjaCBjYXNlcyBjYW4gYmUgbWFkZQ0KPiA+
ICAgICB0cmFuc3BhcmVudCBmb3IgdGhlIENvbmZpZGVudGlhbCBDb21wdXRpbmcgR3Vlc3QgaW4g
dGhlIFREWCBjYXNlIHdpdGgNCj4gPiAgICAgdGhlIGFzc2lzdGFuY2Ugb2YgdGhlIFREWCBtb2R1
bGUgY29tcG9uZW50Lg0KPiANCj4gQnV0IGlzIHRoaXMgcmVhbGx5IGEgdmlhYmxlIHNvbHV0aW9u
IGluIHRoZSBmYWNlIG9mIG1hbGljaW91cyBWTU0/IEl0DQo+IGFzc3VtZXMgdGhhdCBpZiB0aGUg
Vk1NIGlzIHNpZ25hbGVkIHRoYXQgcmFuZG9tbmVzcyBoYXMgYmVlbiBleGhhdXN0ZWQNCj4gaXQg
d2lsbCB0cnkgdG8gcmVjdGlmeSBpdCwgd2hhdCBpZiBzdWNoIGEgc2lnbmFsIGNhbiBpbnN0ZWFk
IGJlDQo+IHJlcHVycG9zZWQgZm9yIG1hbGljaW91cyBwdXJwb3Nlcz8gQ291bGQgaXQgcGVyaGFw
cyBiZSB1c2VkIGFzIHNvbWUgc29ydA0KPiBvZiBhIHNpZGUgY2hhbm5lbCBhdHRhY2sgPw0KDQpU
aGUgaWRlYSBoZXJlIGlzIHRoYXQgaXQgaXMgbm90IG5lY2Vzc2FyeSBWTU0gdGhhdCBpcyB0aGUg
Y2F1c2Ugd2h5IHRoZQ0KUkRSQU5EL1JEU0VFRCBmYWlscywgc28gaWYgdGhpcyBpcyB0aGUgY2Fz
ZSwgVk1NIGNhbiBpbiB0aGVvcnkgZG8gc210aA0KYWJvdXQgdGhlIHNpdHVhdGlvbi4NCg0KV2Ug
aGF2ZSBiZWVuIHRoaW5raW5nIGFib3V0IGlmIGl0IGNhbiBjcmVhdGUgYW4gYWRkaXRpb25hbCBh
dHRhY2sgdmVjdG9yLA0KYnV0IHdlcmUgbm90IGFibGUgdG8gY29tZSB3aXRoIG9uZS4gRG8geW91
IGhhdmUgYW55IGluIG1pbmQ/IA0KDQpCZXN0IFJlZ2FyZHMsDQpFbGVuYS4NCg==

