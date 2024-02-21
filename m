Return-Path: <linux-kernel+bounces-74263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FBB485D1CA
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 08:52:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADE1E1F23677
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 07:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31A733B1AB;
	Wed, 21 Feb 2024 07:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SuKoWQJb"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A57F73B295
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 07:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708501956; cv=fail; b=SE9ix4hsJNJbyf0zUQo6pzLYoQu9lP4lhF+KQU4WisJ1Ye+qEfNM4sQXCoyz5fiH0S996Gcpnl4+XbTm7rRfb5G4gVVg+wxoz/30YLQb4Cuzzx9ZVfi/vvShfXJ049S1XY/YRyPZB+SvLN35qIVy5189yYrR3FEF67VKiLCATK0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708501956; c=relaxed/simple;
	bh=kdZgj4JGcOSOx7nLGNLnYAYA9zXZhHX2ME1MrCd+68U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Lxu+VHntrB/u95GxUrJfwRBkJtCQh5KYAgdk51YQRFCNDHtZB+LOCgYARXvpi5kqViL8MsSWRl48fLnx7dQBSgxfJMxs2AP0x8kba+uQttViPdVyW+AzwMzcsD4ynNn4wIK1L0X+MrzE1oXp5If+AwiVFbOq1EpEOzkDpOzh+CY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SuKoWQJb; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708501954; x=1740037954;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=kdZgj4JGcOSOx7nLGNLnYAYA9zXZhHX2ME1MrCd+68U=;
  b=SuKoWQJb3vkYR3s5oYUqUHNzIO58PsEE8Ud1HodOF84O7ttKMKLefn+I
   eihL5XNTObAsdnY+a1X/g1A41lU4VRofh33AXn0F+0ndjD5i4wqW0eANr
   l6mBOekb/KQ8hs9CmqkYuNjuV2zxl/qirXMOg7ejQ65E+mSFULvv0KVfp
   gZr2tEbQZAC0Uhfq5vq8uHJgCRsf5JmSKOownkI0p7ZVCr1Pk+JGiuCHv
   IgMLmSB7ioiRTBqU9KkoWRhusjV9gTstrA3c33NCGfSgFBUc5RXVkUbG1
   147aMrfwR76c3NNAgHcrkHyXWHg8ID91C4fQxtaARxqhCrzGq0X8y4EmP
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10990"; a="2785761"
X-IronPort-AV: E=Sophos;i="6.06,175,1705392000"; 
   d="scan'208";a="2785761"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 23:52:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,175,1705392000"; 
   d="scan'208";a="5200317"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Feb 2024 23:52:34 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 20 Feb 2024 23:52:33 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 20 Feb 2024 23:52:32 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 20 Feb 2024 23:52:32 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 20 Feb 2024 23:52:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lL7wyOuojeWViiQkqlBCYlplEMiF23RCsQ2H8RA7gRI/DiV0mlYObblr3FEy5L9FFAuJTnIIsp801C6Q2NhmLHb/HbbOVHdWbPmrShxIyqe7ckMxmQ4nz8BURwCZA3wPASk1X/T0QGl8JhXNnPeBvPWJvbqrp7SHOKROdgL+mxcG1v6+7YzMZXTqhzE9wtKUVScDeXKbu8wby1jlFSvBLkuOcR18ztQuFKs8GjMwg6bjQIJMuVst3qSvqilwBgBHk5hc18eDzurXq4H5N+HURPs9xowknV40WSUdAtb81HiaHEDrVXaqWOgvQWmYXLsg6vJam+yGnl/K6yXL2u2/yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kdZgj4JGcOSOx7nLGNLnYAYA9zXZhHX2ME1MrCd+68U=;
 b=dtgtpI03ECwokQuAolYUyLZjz35GR11FxLniBTriE42CSugx1TMUiVMh8rzEcR2AwJiih9vxBWGv44naoXnzJnv1cqowB7/lwh+jZI8uqZb2zCXTEObn7AyXnYXcRg7kQgOBk0GjW48/JmjG4YjSMUjSAV940q0fmmvv+46j8bU9zuLd2xUGl581cA4Hy6er5MpwxTJ/jp3y6+RLxzqILxtcKmFngoICADCDJFRWA5uIiCp00YhfLR0eFyn4ff5L94Dj5gkE0ch1crMiz2hrZhjQUBvnMwqiwKtv9Y8p+kDznvi9+p5O/NTNt9QxLs3igR6aTYLYL9LAm0WWi9g0JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5750.namprd11.prod.outlook.com (2603:10b6:8:11::17) by
 IA1PR11MB7809.namprd11.prod.outlook.com (2603:10b6:208:3f2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.21; Wed, 21 Feb
 2024 07:52:30 +0000
Received: from DM8PR11MB5750.namprd11.prod.outlook.com
 ([fe80::7e88:63ca:dd41:d190]) by DM8PR11MB5750.namprd11.prod.outlook.com
 ([fe80::7e88:63ca:dd41:d190%3]) with mapi id 15.20.7292.036; Wed, 21 Feb 2024
 07:52:30 +0000
From: "Reshetova, Elena" <elena.reshetova@intel.com>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
CC: "x86@kernel.org" <x86@kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Borislav Petkov <bp@alien8.de>,
	=?utf-8?B?RGFuaWVsIFAgLiBCZXJyYW5nw6k=?= <berrange@redhat.com>, Dave Hansen
	<dave.hansen@linux.intel.com>, "H . Peter Anvin" <hpa@zytor.com>, Ingo Molnar
	<mingo@redhat.com>, "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	Theodore Ts'o <tytso@mit.edu>, Thomas Gleixner <tglx@linutronix.de>
Subject: RE: [PATCH v2 2/2] x86/coco: Require seeding RNG with RDRAND on CoCo
 systems
Thread-Topic: [PATCH v2 2/2] x86/coco: Require seeding RNG with RDRAND on CoCo
 systems
Thread-Index: AQHaX4AnbFohebN8LUyJy3kolvDlzbEK/VhAgABn1ACAATKuMIAAseuAgAcrXgA=
Date: Wed, 21 Feb 2024 07:52:30 +0000
Message-ID: <DM8PR11MB5750FFAC83A7899DC2A5EBBAE7572@DM8PR11MB5750.namprd11.prod.outlook.com>
References: <20240214195744.8332-1-Jason@zx2c4.com>
 <20240214195744.8332-3-Jason@zx2c4.com>
 <DM8PR11MB57501389AE5518CB26E037D7E74D2@DM8PR11MB5750.namprd11.prod.outlook.com>
 <Zc4QMAnrMiiCwkmX@zx2c4.com>
 <DM8PR11MB57503009DDA05C9F0CD683E7E74C2@DM8PR11MB5750.namprd11.prod.outlook.com>
 <CAHmME9oj_LepJfMJHNxbTL+EBYHsnJUf2Q5WTwDotto4S5LrQg@mail.gmail.com>
In-Reply-To: <CAHmME9oj_LepJfMJHNxbTL+EBYHsnJUf2Q5WTwDotto4S5LrQg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5750:EE_|IA1PR11MB7809:EE_
x-ms-office365-filtering-correlation-id: c6fedb1f-9be4-4886-9dd8-08dc32b20e22
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JY4tOs9SuuYWgTW2quMUrJBzLxabCMqdLm6qbTBN/ovlhB+SIe6FeBOb0ZXNQ/oButH6dpfflMJ3XyKO4y28ya0sr0hr7EpKVfgFrnEJpqPlf+YEtuRmWZdoIIdvq7qwbXdxGKlGcxWELcVm7aLAxmr78m6GUbRKRPMw/uCN97BcGvP5BSjMaiDeFB1OvXL8hKCV328WrXjOxcvSeS9eMosCTfTgIX7LsBAH2yl/y2c5sC1iSS0jdQtSeUYDbYoXOJwW80NyWBy1DFmecP2F9IdyoiaDMXJ3XQAcU9xzm8HYlp1F1sm4pIQnUMlRODUq/1JvVOFarhDR6+99iAxObUPiXJaIPVv71QS5e5h46SdtrnWjFd7RYBA0NbysrNnG+umZ7h19KjB5ItX6v+zbhV2gZBBG7K/Z7kDKAMC7nTNruOGjNIfs2UKEOcNuE8VGE6KKyh32mUY2ggCubRE/hP5+BTdEnI+zV8m4JXZJNUDQ5TfT+OrYlsTRfsSsI7NwGzFxkhuZ+KuGm5NiKBr+rqynpAmiwGam9E+wvDachQSgRTRERQoYgorSXgYCcyYyDP6dm+eBjtIBMd8wnR1kX6cZ/X+bxwg5MqGNDKjpQMFhkz1mujg3BUjuOGMQ0l9q
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5750.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bUs0dENTV052RDJJUW91UGFVU29USE5RdHFiREZINmRxZmRjcStxVDJmRXNS?=
 =?utf-8?B?VTNSRTlxRUxDcVNWVi9aOUtTYU9UZUlGeXRZck00aGxPTkpydlIzclFqRkhz?=
 =?utf-8?B?Q2FpeE5YYmVHUDlmbWdaUGtMN3JoWGdWSlhMSmRDdjRnOW9kNmtTMVNqRlUz?=
 =?utf-8?B?T1JEUkI4Q05qM2tHUWphbk5OU3V4VU5BODBkcHVMcXNEcGphckp1S0U5QXJL?=
 =?utf-8?B?bVYxVHdoT0hEZzNkZE5SK3c4QU42bVBvSTVRRjBKT0NWSGRMbXVBWTMzYW1R?=
 =?utf-8?B?c1d4UmZVKy9XVHdRVkg3Uno0V3ZyTU5QK3V1T1ZFNXVoQnVBKytaNks3SUtr?=
 =?utf-8?B?bFUzR0YyZ1dmWjdlb2JsUlRzZEhmR0U1T0FPNGI4dGdudWdGSWpaVEJ1clE4?=
 =?utf-8?B?UHp2K2NTWVRoRXR5bzhLWFE4OWpqcStzUGRNdFpnS2lUeXpVUXFFc2RZN2U1?=
 =?utf-8?B?a3pscElINXpoWHlnVUc1OGMyMkZickFPZVhkNTQxVFpkc2NDdmhwbE1UeERt?=
 =?utf-8?B?NnAxVDlEbTRjblVFcmY5YVNEaHlyK21zT3REUVZOWjFlZmVWVVNTMjFaTGR5?=
 =?utf-8?B?MmMrYzBJVVEwS1VrS3Y3em11b2UrMTVjaGlTUk4wVGt4YWd1MXR4ZXpBenB4?=
 =?utf-8?B?RmVoY3JLdHJXRXRsbFMxSzQvWmFESE5vemVwTU5XS2t5QTFwa3hXOGdwY05K?=
 =?utf-8?B?T2RpRVF0OCtKZ25UVm9aTW1OTmlhNERCQ0NRbzlVbmczRWpPbFRDZ2pRa0Fs?=
 =?utf-8?B?UGlrclA4b2p2UjBhN1Y4RG5kQ0tsY1pDUm1UTHByRHJmVS9DcC9TUUVQeENj?=
 =?utf-8?B?MHEwT2F3aHBFeURTWEQ1OWVMYU9VeUY0OHNNeDEwMUtBeW9PMlBFZzNCZDhu?=
 =?utf-8?B?WVllZEVsdkV0SkNwc2RmT3VFNU9ibkFQQTJBOEJuUHNabEFsR25NaFNrVkNC?=
 =?utf-8?B?TWFMRG4wVXdtYXEwdWZQTENranMrdnhCczVKM2hHNjA2NmxPWEtSRVl4SjYr?=
 =?utf-8?B?aXlqczF5Y1RNRlc2ZWN0N2xBR3BibVpiN3RSdDl1M21ZaUQxazVYc2ZPQnZH?=
 =?utf-8?B?cUdQMGF5UXdzY0lxRGlFSVB1d3BZZWhLeU9iMHNqbE8yN0s4MUhia0p3cGNI?=
 =?utf-8?B?WmYwTHJHdGtBMWZjVVkwNW5YZ0diSzFlZDNILzdOSTVjRjlkaGg2TUx4ZGhH?=
 =?utf-8?B?RWxhSVRjK3RKMVdKL1NEcWRKbWhuOXE3SFZhWHhIeWZaREZBcGgxNml2Vlhq?=
 =?utf-8?B?MW5IZHE5eTZrOW9vc1JSNjh1SjFOTTVKUFVza0FXc0lQdUVnZEJrMFJSd2xa?=
 =?utf-8?B?c1c4eFVqRzBwSC9UUkV4ejE0dkl6UDVlTWdyT05NcWg1RjVJSnU0S2wwbGlT?=
 =?utf-8?B?dlNqVVYrMVBiTjJPVVg5eWQreUkrcGZpbmFEcDdMd0trQXBUZWVHaHhWc080?=
 =?utf-8?B?R24xbUJkYkpuNnkwV0JvVSs3UGwxcGJ0TjNEUXRsbWhpRFh4ZGFBZW9mNy8r?=
 =?utf-8?B?STFuYTVIRUwzMWJZU1Nac2dVcGZWeDBtby9rNHQzN0ZHTHNHU3RpQ1pkdXhF?=
 =?utf-8?B?UGVYbVFTUllveUE0c1ltVWVyMW9CVUVLM2t0aDhjanU0RVFKYkMvR2Fhb1pw?=
 =?utf-8?B?bWJBSURENzQra1pFNDQwRUpDN3V4SWJMdnZqVGhha3BrdVlLVmNSbithYnVr?=
 =?utf-8?B?QmRzU3VUSXN3OWlkQnkxdjAxQ1VSY05IWnowS2psZE9FbGo3QUkwbW5RZnAr?=
 =?utf-8?B?dXJ2Z2pxa0RxT0pUcjBzQ3hYN2pYaG9yV2lRTVdNbUZCaWp4U0VOMGkydWhI?=
 =?utf-8?B?TzhiZTZ5Y2YrbU9uNlBEV3VaMUhyODNweUVNbmZYOTg4Q1V1elVpc3FQYllo?=
 =?utf-8?B?TXpZSzN6NGVzMk4yYzBWWXNIYXNqVVZwakhHdjRlK3l3eVJtVnpQVHVJRmtX?=
 =?utf-8?B?U3hkY01HVEZEMGxobG4wbExIaVEzRXZxaE4xV1plR0NyaGYxK0ZKbnFuSmdS?=
 =?utf-8?B?WEFDRjVMb0FSbGI1RFlzejByYTR0bklpZDh5RnVuOEV2SGFKUkRNQ3RkbUlw?=
 =?utf-8?B?cDRZMlFEQVlsRVZqMGlpRXJDc3NhUWIrS0dpVGNONHBQUnhxMGJpRTJxSE1P?=
 =?utf-8?Q?eVSTzui4vhK6KYksDcPvfY5gu?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c6fedb1f-9be4-4886-9dd8-08dc32b20e22
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2024 07:52:30.2242
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9f4+BZgaqVb9pOb5j9d/4tuZpjHQ90fHFVRp57e0pyA+IVFyp+G4kbYGjEPhH6stRcur8najCdMogyKJ+yLMxj6DeFb+a4+hZWzShAwHsy0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7809
X-OriginatorOrg: intel.com

PiBIaSBFbGVuYSwNCj4gDQo+IE9uIEZyaSwgRmViIDE2LCAyMDI0IGF0IDg6NTfigK9BTSBSZXNo
ZXRvdmEsIEVsZW5hDQo+IDxlbGVuYS5yZXNoZXRvdmFAaW50ZWwuY29tPiB3cm90ZToNCj4gPiBT
bywgeWVzLCBjb2NvX3JhbmRvbV9pbml0KCkgaGFwcGVucyBmaXJzdCwgd2hpY2ggYWN0dWFsbHkg
bm93IGhhcyBhIG5pY2UNCj4gPiBzaWRlLWVmZmVjdCB0aGF0IG9uIGNvY28gcGxhdGZvcm1zIHdl
IGRyb3AgSFcgQ1BVIG91dHB1dCBldmVuIGVhcmxpZXINCj4gPiBpbiB0aGUgZW50cm9weSBwb29s
IChZYXkhKS4NCj4gPiBXaGljaCBhdCB0aGlzIHBvaW50IHdvdWxkIGJlIGFsbW9zdCBwZXJmZWN0
LCAqaWYqIHdlIGNvdWxkIGFsc28NCj4gPiBjb3VudCB0aGlzIGVudHJvcHkgZHJvcCBhbmQgYWxs
b3cgQ2hhQ2hhIHNlZWRpbmcgdG8gYmVuZWZpdCBzdHJhaWdodCBmcm9tDQo+ID4gdGhpcyBlYXJs
eSBkcm9wIG9mIGVudHJvcHkuDQo+IA0KPiBJIGFkZHJlc3NlZCB0aGlzIGFscmVhZHkgaW4gbXkg
bGFzdCByZXBseS4gSSB3b3VsZG4ndCBnZXQgdG9vIGh1bmcgdXANCj4gb24gdGhlIGVudHJvcHkg
Y291bnRpbmcgc3R1ZmYuIFRoZSBSTkcgaXMgZ29pbmcgdG8gZ2V0IGluaXRpYWxpemVkDQo+IGp1
c3QgZmluZSBhbnl3YXkgbm8gbWF0dGVyIHdoYXQsIGFuZCB3aGV0aGVyIG9yIG5vdCBpdCdzIGNv
dW50ZWQsDQo+IGl0J2xsIHN0aWxsIGJlIHVzZWQgYW5kIGF2YWlsYWJsZSBiYXNpY2FsbHkgaW1t
ZWRpYXRlbHkgYW55d2F5Lg0KPiANCj4gPiBIb3cgYWJvdXQgY2hhbmdpbmcgdGhpcyB0byB1c2Ug
YWRkX2h3Z2VuZXJhdG9yX3JhbmRvbW5lc3MoKT8NCj4gDQo+IFRoYXQgZnVuY3Rpb24gaXMgb25s
eSBmb3IgdGhlIGh3cm5nIEFQSS4gSXQgaGFuZGxlcyBzbGVlcCBzZW1hbnRpY3MNCj4gYW5kIHRo
YXQncyBzcGVjaWZpYyB0byB0aGF0IGludGVyZmFjZSBib3VuZGFyeS4gSXQgaXMgbm90IGZvciBy
YW5kb20NCj4gZHJpdmVycyBhbmQgcGxhdGZvcm1zIHRvIGNhbGwgZGlyZWN0b3J5Lg0KPiANCj4g
PiBBbmQgYWRqdXN0IGNjX3JhbmRvbV9pbml0KCkgdG8gdHJ5IHJkc2VlZCBmaXJzdCBhbmQgb25s
eSBmYWxsYmFjayB0byByZHJhbmQNCj4gPiBpZiBpdCBmYWlscz8NCj4gDQo+IEkgZ3Vlc3MgdGhh
dCdzIHBvc3NpYmxlLCBidXQgd2hhdCBldmVuIGlzIHRoZSBwb2ludD8gSSBkb24ndCB0aGluaw0K
PiB0aGF0IHJlYWxseSBtb3JlIGRpcmVjdGx5IGFjY29tcGxpc2hlcyB0aGUgb2JqZWN0aXZlIGhl
cmUgYW55d2F5LiBUaGUNCj4gd2hvbGUgaWRlYSBpcyB3ZSB3YW50IHRvIGVuc3VyZSB0aGF0IFJE
UkFORCBpcyBhdCBsZWFzdCB3b3JraW5nIGZvciAzMg0KPiBieXRlcyBhbmQgaWYgbm90IHBhbmlj
LiBUaGF0J3MgKmFsbCogd2UgY2FyZSBhYm91dC4gTGF0ZXIgb24gdGhlIFJORw0KPiB3aWxsIGVh
dCByZHNlZWQgb3Bwb3J0dW5pc3RpY2FsbHkgYXMgaXQgY2FuOyBsZXQgaXQgaGFuZGxlIHRoYXQg
YXMgaXQNCj4gZG9lcywgYW5kIGxlYXZlIHRoaXMgcGF0Y2ggaGVyZSB0byBiZSBzaW1wbGUgYW5k
IGRpcmVjdCBhbmQgYWNjb21wbGlzaA0KPiB0aGUgb25lIHNpbmdsZSBzb2xpdGFyeSBnb2FsIG9m
IHBhbmlja2luZyBpZiBpdCBjYW4ndCBhdm9pZCB0aGUgd29yc3QNCj4gY2FzZSBzY2VuYXJpby4N
Cg0KDQpPa2F5LCBJIGd1ZXNzIEkgd29u4oCZdCBzdGFydCBmaWdodGluZyBmb3IgYSBjbGVhbmxp
bmVzcyBvZiBhbiBvdmVyYWxsIGNvbnN0cnVjdGlvbg0KKGFuZCByZXN0IG9mIHBlb3BsZSBzdGF5
IHByZXR0eSBxdWlldCBpbiB0aGlzIGRpc2N1c3Npb24gdGhyZWFkKS4gDQpGdW5jdGlvbmFsbHkt
d2lzZSB3ZSB3aWxsIGdldCB3aGF0IHdlIG5lZWQgaW4gcHJhY3RpY2UgYW5kIEkgbGVhcm5lZCB0
aGF0DQoiZGlzYWdyZWUgYW5kIGNvbW1pdCIgaXMgYSB2ZXJ5IHVzZWZ1bCBwcmluY2lwbGUgdG8g
ZXhlcmNpc2UgZm9yIG1vdmluZyB0aGluZ3MgZm9yd2FyZCwNCnNvIEkgYW0gb2sgd2l0aCB0aGlz
IGFwcHJvYWNoLg0KDQpXb3VsZCB5b3Ugc3VibWl0IHRoZSBwYXRjaCBvciBob3cgZG8gd2UgcHJv
Y2VlZCBvbiB0aGlzPyANCg0KQmVzdCBSZWdhcmRzLA0KRWxlbmEuIA0KIA0KDQo=

