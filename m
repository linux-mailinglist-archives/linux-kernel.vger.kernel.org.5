Return-Path: <linux-kernel+bounces-76014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C490D85F1F3
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 08:35:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32D8CB215F7
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 07:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 378C61799B;
	Thu, 22 Feb 2024 07:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FdIHIhMq"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0DA717583
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 07:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708587335; cv=fail; b=OH6cRESJbZ5t78DlHb7McgEQbcfXaJbRJK6BysTkRrcIfWxLRWf882RY/y2pB5Jov66L2e6aABaPEApeqPoazcQslJ851/9YAfOYGhQtP6Th9uqxgnb3RJsyVwJB/bQ/COvzEqsvuGWjww8JR6SAniJQ8uozW218dZVzLCJrq7M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708587335; c=relaxed/simple;
	bh=TRurSQycl+EWQb8CZnnKADmJiSOWqZOhAIlS0pDZ9og=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XJRMXi1U5qgQDGzzpEiabvoiNBxeUXXXzFgtlm0vvkySDUZg4bIse1Lxjns7W5ZKqULFtTSeAwK/AsU1KqQCZ48cB1ZAVEif16DkKMYLTRwMurrChhfqu69ye9fmuYGXtWz/Ngs580rDjvLXY6G3GLh0bo6FeocNpIXO19vR1qs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FdIHIhMq; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708587334; x=1740123334;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=TRurSQycl+EWQb8CZnnKADmJiSOWqZOhAIlS0pDZ9og=;
  b=FdIHIhMquAdk3RVhaJfXppy5IprO6mjzZuJyX0CYobcwtI1dbHZWCq2n
   asz6KMPgLWb6+YEfqi6SWXHA7Sym6QNo+7BADwIhnRCag5XgSeMGkjvZW
   HWHAcOy9oDMrEIsenSfKSCzJC2GH1PqY8bvvQubNa9M+lHfRyy3UlTUA/
   d2N5PsIyEGjawAS6F5MG7yzHPqWA2klbp/VQwxb/eBTdjug9vllQtLN0U
   rm/SPVTvtLlIwtwfELKHMudrDWl5Ubsr2/1IKEOWACmuJ0SP2BPe1GDVp
   y7zb1pDDYLXyDZAlUx1N1MBsxsZ0fdK4DDYqrpaNCmp9ait6YpobCcye5
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="2936011"
X-IronPort-AV: E=Sophos;i="6.06,177,1705392000"; 
   d="scan'208";a="2936011"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2024 23:35:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,177,1705392000"; 
   d="scan'208";a="28562930"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Feb 2024 23:35:33 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 21 Feb 2024 23:35:32 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 21 Feb 2024 23:35:32 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 21 Feb 2024 23:35:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dy9mCqE9XEydAbdg0mCajCbo6NERpYDHf7C3msvBitkmjTja2apFoUKt1Z5kRTDxAyEJoodCUb1zI/Kqy5cNE9eTlhe77AKF9ifzm1DiWekdXgAWlpTP69AznKt5i0Igq+dXUEDtnZ0v0OiGMWA6xPkhDYXiMczwKoFnFGk3eh8yKuzGC1OMqSBcRzxoHdreA7OwHxSgJ4WCq793KSs2jfOKtpsniDadIDI8p7ZobGplh9JePbGzuGnMDW5MOKRl9sY+F6bxS0p6xA9sCGwDQ1Xq2pgbQqx/G0+wwGZtdWIkaB0qz0W/rQ4z7UzHlSnVFTcLlRGHkCPxKHPyVw0vUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TRurSQycl+EWQb8CZnnKADmJiSOWqZOhAIlS0pDZ9og=;
 b=AetIYMZ2sBIepkUN9yxVcCcKQSqkYp+KS3lucYOm/z13kk9lCOErFrMbV8T1fOEa7qGwHvAzdrTUYa3hRdhforfBIA+Wp2/Bbaq+NMf4IR9FGra0k2Jri36G0sCH/bFbFsFvb9adZ759XC3apzBO1YwCzhwpGBpwMJJb/raZpf2Nnnl1xgtS8Z9NvH37kiu7EKfjAAPcxiPigiRB3r7lEjdx/zuOY6zF206WD0pNXf8brDZuEikrB2zLu2gbLdbyVsYLCu0GDR6j0+yXjUpC4UUk/oZILtUGCsm5timuh39RNkjvlgrdCFOyOvT5SZM9jSug5LczCkDKvOd7FrTN7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN0PR11MB5758.namprd11.prod.outlook.com (2603:10b6:408:166::18)
 by MW4PR11MB5892.namprd11.prod.outlook.com (2603:10b6:303:16a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.10; Thu, 22 Feb
 2024 07:35:22 +0000
Received: from BN0PR11MB5758.namprd11.prod.outlook.com
 ([fe80::3d61:699:5e9:2346]) by BN0PR11MB5758.namprd11.prod.outlook.com
 ([fe80::3d61:699:5e9:2346%4]) with mapi id 15.20.7316.018; Thu, 22 Feb 2024
 07:35:21 +0000
From: "Reshetova, Elena" <elena.reshetova@intel.com>
To: "Hansen, Dave" <dave.hansen@intel.com>, "Jason A. Donenfeld"
	<Jason@zx2c4.com>
CC: "x86@kernel.org" <x86@kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Borislav Petkov <bp@alien8.de>,
	=?utf-8?B?RGFuaWVsIFAgLiBCZXJyYW5nw6k=?= <berrange@redhat.com>, Dave Hansen
	<dave.hansen@linux.intel.com>, "H . Peter Anvin" <hpa@zytor.com>, Ingo Molnar
	<mingo@redhat.com>, "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	Theodore Ts'o <tytso@mit.edu>, Thomas Gleixner <tglx@linutronix.de>
Subject: RE: [PATCH v3] x86/coco: Require seeding RNG with RDRAND on CoCo
 systems
Thread-Topic: [PATCH v3] x86/coco: Require seeding RNG with RDRAND on CoCo
 systems
Thread-Index: AQHaZMI0e+uC4Xjgr02rINi1nuP+9LEVBAQAgAAGxoCAAFuJAIAAju6g
Date: Thu, 22 Feb 2024 07:35:21 +0000
Message-ID: <BN0PR11MB5758BD74D42550725E60FDC1E7562@BN0PR11MB5758.namprd11.prod.outlook.com>
References: <20240221123248.25570-1-Jason@zx2c4.com>
 <eada8acd-9341-401b-b6c9-a05848eb91d6@intel.com>
 <CAHmME9o75KzsfMRDtr2K0+N-UM-MX7MWL4AZhy27CedZRNd2Tg@mail.gmail.com>
 <7a8c04bb-214b-4031-bdd6-59dad62f88a7@intel.com>
In-Reply-To: <7a8c04bb-214b-4031-bdd6-59dad62f88a7@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR11MB5758:EE_|MW4PR11MB5892:EE_
x-ms-office365-filtering-correlation-id: 8a1aa45a-7864-4bb7-6b06-08dc3378d329
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QOlT/stXYM2QYDW9PHePSJ8L96ktS/s8LeXjDiT//JWFqunc6Mu04bHOYQ1EUc8u1JT7jWF54jLsHjj59MfoOH4KEimRG06JTVdZgsDAuSjIe1KYDbXUAI0oV15ztwlYzgnN4NRN68CBpzR1/g5DNamKa4JQL5z3CAPfeAYDTNYiAgUdbgEw1INdfkKlEuMowhwXLvlsoV08gyFT6dPCqgBE5YijGdN/wDmBadfP0PnLFodTDUIP+VLf4rkX2mnmnOLAYI8l5j8sGRIk6LK7rTfdcn7h7YRP8K2lUI9kAIwg4L1VvtQJwZ+Nr36ElJZ6HGmLRxn5rm64y+OkDAAdPUJEyFmGJVVDFHudY2CQGSJ/LV1HmAmCZMCUsmP0gsIAxeoqkXR2wV60m4WBNNPbhLTZVk1CLLZA1SCnDY+pePhjYuvvHPPjqIK3ON+gmU85EaCOqkgGhFZxLaPM9z1oF8sVeyN6M4iMBKsmBXl8voZHKxZtmbRVwvNFWQK0tRUnIllK83KgOFZhPPryH5Eh8wMINWuoGIJymVmiixiw4YR0NWTUU1mB9br9755DtkfxQxvoy6NMeoGpPNpE5TVZxFF0/6LkTvZ77GvwrD/iATY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR11MB5758.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z0dSM0ZZb1JkUDhDNWNSYkZmQkJib05QYkhMQ1BzRkVmQStwd0N3MXpHem95?=
 =?utf-8?B?NEtRK1RKd1RjZGtDZWM2MFhXaDZ0eXJYQkd4ckY1TXZGZi8vN0FVanJHM2tB?=
 =?utf-8?B?NGF3alNHdFQyN1ZMLzg1S0thb2p6YzcwajI0ODdNRWNrU3F0UTB1VU0xR0lJ?=
 =?utf-8?B?MFpCSDNRYUtHdlFhdjJUSjBLTGRPbDNkYzZDS3dJdDFVci9ZU2ZGM2U5S0lu?=
 =?utf-8?B?My9IcVl6RllNYm5KOGwvcHg1RXdpUFJiK0hoWWttaXRJYlJlbC92V1ZvT0pT?=
 =?utf-8?B?NlcwME9sTjFzRDIzWHNZM1Aya1ppU1VFaFdlY3lXV3JmUFE3TlNpdkZMRVJx?=
 =?utf-8?B?WnR2WlNWaTNPQ3pZT3hFS2gxTzcvVnJqRGVBTlI4VkppWVVhMHVQdlVVY0lh?=
 =?utf-8?B?VEFQclBXakpOZ1k4ZzdIMUo0NTdEcjJCZVYzRnpPSlZaTmpVYy9NdHhkMVJv?=
 =?utf-8?B?WXFiYzdrSmcxM05Ka1RWSy9BS2VubHN0SGVISHVhUUw5Y0wxVjFOMUlaWnpM?=
 =?utf-8?B?U1pQVmdzT2hSVGtWR1ptbmtRL3JGS2xpREJzR0lXVWQxN1pndHRIandhMmhy?=
 =?utf-8?B?dFFEbUlPVS9NRGx6UWIwMnE2KzZkdDdLTWk0eWRDYjRVcEEzQ3RVVlgxR2pl?=
 =?utf-8?B?S1BiYkkyVzd5QzdYdUYxc2hVcjYweVNxSFdrL1I3M3hHWU1QTUZxNGR6VkxC?=
 =?utf-8?B?U0dQSzc1cDlIa3dtN09ZU0RrclJZcHRrNXpBSGJPMVUvVWJZSkc2RTBIeUdw?=
 =?utf-8?B?blNSTDRGc0dsd0QrSlo5YUh2OE9MaWc2SkZucVBTbnNaZit5bGZjcmVuWEdP?=
 =?utf-8?B?endwYi9Hcy84U1J2ZTczNUhHMWhMU3VtMm1KZTBIUGNwVUNwTXZiK1NvVUxk?=
 =?utf-8?B?TUloeGlacUJHMHJBaUpVTXhFdmJPOStkbE0yZGtzc2RSdVJvVkpuSTJxZERn?=
 =?utf-8?B?cll1MVNsS0ZJd3pzQmttdGJzQlJudTBPc1pBb1o2Q0NpSG1GQnAyZksyZEZV?=
 =?utf-8?B?Ym5INjBhK1dQSVgrUklNTDF1ZHVPNEFQWUJlNTMrRWZDT2RZd1FCYW5mS0kx?=
 =?utf-8?B?Y2k3d05xMVVtc0EwNy9RSXlFN2I1ZDBCdDBWNkFTd2VBT25VaVA0aTUzZ2Nl?=
 =?utf-8?B?L2tSVDY5MVFab3VYZFFPbkNlREFnUzBkSlFaMUlLQUNoc0NjMFVxZGsxNmxk?=
 =?utf-8?B?UW14MDVuZkJGWXRwZGIvc2d3QnBKdlEza0hINUZWMzhScUNuQ3JNdUJYdjkx?=
 =?utf-8?B?bHlxVEtBN1BjZnBCYUlrTThxQy95bE9NMHQyWitrRE9CRFNrVWdrcjBiTUg5?=
 =?utf-8?B?T0JndmVHcEN5NmxpazN1ZGpDbG5icEtpanF1bUdvSVZ5VlhEdE9LMjhsbVJR?=
 =?utf-8?B?SkgrWlZRTFhHb2c4T2FVZ3RMN3RlYUo4NlFvbXhEcnllRzd2aWdGdzh3cjdX?=
 =?utf-8?B?elhHZ1l5elYxZWIrby9UcUM0SDdycHZOc3pJcUdnSldyUFFpZjhOcFlZcmc1?=
 =?utf-8?B?NVdYZ0pDT05UenVoQitIRHR2Um92SjdacVdZem5RaGgvWGV6WVp0cDlvVzlH?=
 =?utf-8?B?Z09yT3AxM1UydzhPQzFRbUlyQXJWRGNMMHBWY3FSY0g5TkN5QSs0Tk9TSksy?=
 =?utf-8?B?cmFUcWZnUEorM2k2K3FFWVhpcFZzc1BzNW1vY2UvWGNuam5FZXFJdFFZd0Ns?=
 =?utf-8?B?QXVZcE1RWkh5VXZrMVRkV21zOXNzSzZUOVRDaG5HeXF4TGlUOVlFb0c1cCtE?=
 =?utf-8?B?ZnhlaGlYZVpOdVRLV1paTG5XNlhQQ0VoTzZZTVBJaEdJWnFRN0hpekM4K2pl?=
 =?utf-8?B?V2pnN2pwM0wrTno3U3g1Y2sxRVhRa3FZVTc1WHZmalBPZ0pYWGpWdUhsUEd2?=
 =?utf-8?B?RC9OQ1dpVE0xd1E3U2JwZ3VIdk1OZG1sU1owa0dSS2xJQ0k4ZitjSHpSOU12?=
 =?utf-8?B?clZpRHV0Qk5QYzUvTDRKRjArNS9KNS8zYlJNS01jQTZzTWZjQ1B4WWxSU0do?=
 =?utf-8?B?SGxQZXh2NUQ4VjJsUWtQNmJpOU5VS0EvOHJ3QTc4UHBoY2YvRzZiZHh2dmdT?=
 =?utf-8?B?Um9PL3p5RjN5KzlGaDd4SzMxNDlkSUR2dCtXQkRpbnFJb3FLRmh5Yml3VlV5?=
 =?utf-8?Q?zvow4VQYMo+3rqJkJ7NDbPawH?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5758.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a1aa45a-7864-4bb7-6b06-08dc3378d329
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2024 07:35:21.1327
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZQ0uQmDppNcxUbro8qtzOGJd8vDjJrW09pbEJUeHl1LCG5Mc9o1s53ZSyYVEZsuupshqhoLQbd9/D0EHdNodWHQDNU20uAHjHvIo2KILcPc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5892
X-OriginatorOrg: intel.com

DQo+IE9uIDIvMjEvMjQgMDk6MTksIEphc29uIEEuIERvbmVuZmVsZCB3cm90ZToNCj4gPiBPbiBX
ZWQsIEZlYiAyMSwgMjAyNCBhdCA1OjU14oCvUE0gRGF2ZSBIYW5zZW4gPGRhdmUuaGFuc2VuQGlu
dGVsLmNvbT4NCj4gd3JvdGU6DQo+ID4+IE9uIDIvMjEvMjQgMDQ6MzIsIEphc29uIEEuIERvbmVu
ZmVsZCB3cm90ZToNCj4gPj4+ICtfX2luaXQgdm9pZCBjY19yYW5kb21faW5pdCh2b2lkKQ0KPiA+
Pj4gK3sNCj4gPj4+ICsgICAgIHVuc2lnbmVkIGxvbmcgcm5nX3NlZWRbMzIgLyBzaXplb2YobG9u
ZyldOw0KPiA+PiBNeSBvbmx5IG5pdCB3aXRoIHRoaXMgaXMgdGhlIG1hZ2ljICIzMiIuDQo+ID4+
DQo+ID4+IFdoeSBub3QgMTY/ICBPciA2ND8NCj4gPiAzMiBieXRlcyA9IDI1Ni1iaXRzID0gd2hh
dCB3ZSdyZSB0YXJnZXRpbmcuIFZlcnkgbm9ybWFsIHRoaW5nIHRvIHNlZQ0KPiA+IHBsYWNlcyBp
biB0aGUgUk5HLCB1c2VkIGFsbCBvdmVyIHJhbmRvbS5jIGFuZCBsb3RzIG9mIHBsYXRmb3JtDQo+
ID4gZHJpdmVycy4gUHJldHR5IG9idmlvdXMgYW5kIHN0cmFpZ2h0Zm9yd2FyZCB0byBhbnlvbmUg
ZmFtaWxpYXIgd2l0aA0KPiA+IHRoaXMga2luZCBvZiBjb2RlLiBOb3QgdGhlIGtpbmQgb2YgdGhp
bmcgeW91J2Qgd2FudCB0byByZXBsYWNlIHdpdGgNCj4gPiBzb21lIGFic3RyYWN0ZWQgY29uc3Rh
bnQgdGhhdCBtYWtlcyB5b3Ugc2VhcmNoLg0KPiANCj4gT0ssIHNvIHdlJ3JlIHRyeWluZyB0byBn
ZXQgMjU2IGJpdHMgb2Ygc2VlZCBkYXRhIGZyb20gUkRSQU5EPw0KPiANCj4gVGhlcmUncyBhbiBl
bnRpcmUgc2VjdGlvbiBvZiB0aGUgSW50ZWwgd2hpdGVwYXBlclsxXTogIkdlbmVyYXRpbmcgU2Vl
ZHMNCj4gZnJvbSBSRFJBTkQiLiAgSXQgZGVzY3JpYmVzIG9uZSAibWV0aG9kIG9mIHR1cm5pbmcg
NTEyIDEyOC1iaXQgc2FtcGxlcw0KPiBmcm9tIHRoZSBEUk5HIGludG8gYSAxMjgtYml0IHNlZWQg
dmFsdWUiLiAgSSB3YXMgbmFpdmVseSB0aGlua2luZyB0aGF0DQo+IGlmIHRoZSBrZXJuZWwgd2Fu
dHMgMjU2IGJpdHMgb2Ygc2VlZCBkYXRhIGZyb20gUkRSQU5ELCBpdCBtaWdodCB0YWtlDQo+IDIq
KDUxMiAxMjgtYml0IHNhbXBsZXMpLg0KDQpZZXMsIHRoaXMgd291bGQgYmUgYSBwcm9wZXIgd2F5
IG9mIGRvaW5nIGl0IGluIHRoZSBhYnNlbmNlIG9mIDEwMCUgZW50cm9waWMNCnNlZWQgZnJvbSBS
RFNFRUQsIGJ1dCB0aGlzIGd1aWRhbmNlIGRvZXNu4oCZdCBxdWl0ZQ0KYXBwbHkgaW4gTGludXgg
Uk5HIGNhc2Ugc2luY2Ugd2UgYXJlIG5vdCByZWFsbHkgYWJsZSB0byBzZWVkIENoYUNoYSBQUk5H
DQpkaXJlY3RseSBhbnlob3cgd2l0aCB0aGUgaW5wdXQgZnJvbSBSRFJBTkQ6IHdlIGFyZSBvbmx5
IGFsbG93ZWQgdG8gDQpjb250cmlidXRlIHRvIHRoZSBlbnRyb3B5IHBvb2wuIElmIHlvdSB3YW50
IHRvIHByb3Blcmx5IGZvbGxvdyANCk5JU1Qgc3RhbmRhcmRzIG9uIERSTkdzIChTUDgwMC05MEEv
Qi9DKSwgd2UgaGF2ZSBtYW55IG5vbi1jb21wbGlhbmN5DQppc3N1ZXMgaW4gTGludXggUk5HIGV2
ZW4gd2l0aG91dCB0aGUgQ29DbyBjYXNlLiBTb2x2aW5nIHRoaXMgd2hpbGUgdGFraW5nDQppbnRv
IGFjY291bnQgcGVvcGxlJ3MgZmVhcnMgYWJvdXQgUkRSQU5EL1JEU0VFRCB0cnVzdHdvcnRoaW5l
c3MgaXMgbm90DQplYXN5LiANCg0KQmVzdCBSZWdhcmRzLA0KRWxlbmEuDQoNCj4gDQo+IEknbSBu
b3Qgc3VnZ2VzdGluZyB0aGF0IHdlIHVzZSB0aGUgZXhhY3QgY29uc3RydWN0aW9uIGZyb20gdGhh
dA0KPiB3aGl0ZXBhcGVyLCBidXQgSSdtIHJlYXNvbmFibHkgc3VyZSBJIGNvdWxkIGFjdHVhbGx5
IGV4cGxhaW4gdG8gc29tZW9uZQ0KPiB3aGVyZSBhIG1hZ2ljIDEwMjQgY2FtZSBmcm9tLg0KPiAN
Cj4gSSBhbHNvIHdlbnQgdGhyb3VnaCBhIHNtYXR0ZXJpbmcgb2YgYWRkX2RldmljZV9yYW5kb21u
ZXNzKCkgdXNlcnMuICBJDQo+IGRpZG4ndCBzZWUgbXVjaCBvZiBhIHBhdHRlcm4gdGhlcmUgdGhh
dCBzZWVtZWQgdG8gbGluZSB1cCB3aXRoIGENCj4gMjU2LWJpdHMgY29udmVudGlvbi4gIElmIGFu
eXRoaW5nIHRoZXkgc2VlbWVkIHRvIGp1c3QgdXNlIHdoYXQgdGhleSBoYWQNCj4gbGF5aW5nIGFy
b3VuZC4gIEkgc2F3IGJ5dGUgY291bnRzIG9mIDE2LCAyMSwgMTIsIDgsIDEsIHN0cmxlbigpLCA1
Ni4NCj4gQnV0IG5vIHBhdHRlcm4gSSBjb3VsZCBkaXNjZXJuLiAgRGlkIHlvdSBtZWFuIHNvbWV0
aGluZyBkaWZmZXJlbnQgYnkNCj4gInBsYXRmb3JtIGRyaXZlcnMiPw0KPiANCj4gSWYgd2UncmUg
Z29pbmcgdG8gaGF2ZSBhcmNoL3g4Ni1zcGVjaWZpYyBjcnVkLCBpdCB3b3VsZCBiZSBncmVhdCB0
byBtYWtlDQo+IGl0IG9idmlvdXMgYW5kIHN0cmFpZ2h0Zm9yd2FyZCB0byB0aG9zZSBvZiB1cyBz
aW1wbGUgZm9sayB0aGF0IGFyZQ0KPiBmYW1pbGlhciB3aXRoIGFyY2gveDg2IGNvZGUuDQo+IA0K
PiAxLg0KPiBodHRwczovL3d3dy5pbnRlbC5jb20vY29udGVudC93d3cvdXMvZW4vZGV2ZWxvcGVy
L2FydGljbGVzL2d1aWRlL2ludGVsLQ0KPiBkaWdpdGFsLXJhbmRvbS1udW1iZXItZ2VuZXJhdG9y
LWRybmctc29mdHdhcmUtaW1wbGVtZW50YXRpb24tZ3VpZGUuaHRtbA0KPiANCg0K

