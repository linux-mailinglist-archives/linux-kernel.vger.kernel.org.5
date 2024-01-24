Return-Path: <linux-kernel+bounces-36480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E09E083A17F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 06:45:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FDDC288D7D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 05:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9A7BE54E;
	Wed, 24 Jan 2024 05:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BL/3FGHE"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0802AF9E4
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 05:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706075101; cv=fail; b=Z5Rox+GjeOXZvmVeQnWYkG49g0f621MkJ+p2Fb6TXcI70XZfTco7u7H4epwljQJd3daaYwuRZPSkJD4CemWbLBaL1KhhW7TJbnA/HfMbH3CpPNUgrRV2hePfj4GugugI24mAtED10i7DnjQTI5C/qGid48TIXiqmCbg8DcxHPm0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706075101; c=relaxed/simple;
	bh=+boVkHIjtxzqgQ01idi9vMajXGbft0DW/wFmuNI+iPw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WLdKOmahNurjKn/xWZq/U8RWgy5/gx/kmwxBMP992BIoUIKIpdcd6i7axlO/vEoXtWPYrvN74iUaNjHXAluqO3qS3w8XoEDfNJz6sYU6mNddNbfRMsbVaMC/YAJpRAZb1aRDbYx5a2hi0wL2myoyicg0XWXP/01dC8BnOUO5H8g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BL/3FGHE; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706075099; x=1737611099;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+boVkHIjtxzqgQ01idi9vMajXGbft0DW/wFmuNI+iPw=;
  b=BL/3FGHEOpRYmtb8yLaJRnM4tayMMDghBcSwPaX4Wjc567LRtvVy9erb
   KsrFKKbFXTzjnEto628EyRayPgWt4ai5HQ9OklT9EV5wNCu+Nla6crXfy
   tdIn42SzWP0q4gNchrEvc/0ldaAIgrqCa3te5apRmxD/XWffGon1QNBci
   UmaoyJElvvWzNkiG/JrAruwjcOH47r3PmRqa/bm/qFD2bauGec0zWg6lK
   WU7zEyzXI0oE9TZYV2ftEP/7pdC2K2M46LgEbkK1kbhzkOO3CJe0kdV/2
   JQm0aj8cKq9WnqRl0dZXkIQhR2cQV2luHGScFFofpOf5RWiWFGlOkN87e
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="20304201"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="20304201"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2024 21:44:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="735808072"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="735808072"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Jan 2024 21:44:57 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 23 Jan 2024 21:44:56 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 23 Jan 2024 21:44:56 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 23 Jan 2024 21:44:56 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=izCwaD6BZqJLeNUDjdNwSBzULa06WYnpDi/u5SvwjK7g7OdPNaBjtnLSfTS977hoobnPiRftt8hXp62Bg6M5/ZGsmveqYN4gPugYhpiAKP5icRYnnV+s3tUEu/YXRCoTBmtiOJ+ZreWMgNZGSHmaBm1+KxaOW0ZyLc0CwNw6kbv5UhXn+1bYgQ1jAbtR53g5C1uEDvB9W9d7ItJBPQcv23cgOgEbRrw0KZE3kDF8wTLlzGYXcjpdfU6cqqk2ulyqlvkhOrq9MQHQkxCOft580mfLMHf2BD7szEnUsf8wRxeehvpkW/btNWBHwCmb+FNhNK2j/QcK/YK94X3mqle2lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=au7YMmcpqAcMV/6F/kKWMzNNkaiHrSYGfpqx1clm9iI=;
 b=cD+afj+l7hFc5/P8FNm4oPlMVtJc8F598SyparFkHzq6B0jZmAiDi6WHj7gIOhwa35vXo6WZ2ne7WjS/dTxaG+sw8aaK/rv4gKCrQUfizuaJWdPv5j89WIGmtkbKfkLDFWXaw60+YFnoQaFImLKZQXnpyVGZh0nVS32HZ4QJotBuIE9zsD2AYyAX+WOVOzMOU+4v2mx7RufM3FbPU6wriNjMvw8gsG7V3GM+pXi+iIqEiRtZFRU4iGCMcYb7urqZDYTORSmiPrZPb3C3cuz/EERk0pWiAsNiFAykfr+Cu7189zfcIuDjdO+xinTpPZIb+Ul22VQuqqaA+iSf4e3IYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL3PR11MB5747.namprd11.prod.outlook.com (2603:10b6:208:354::22)
 by BL1PR11MB5954.namprd11.prod.outlook.com (2603:10b6:208:385::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Wed, 24 Jan
 2024 05:44:53 +0000
Received: from BL3PR11MB5747.namprd11.prod.outlook.com
 ([fe80::7627:31de:36ec:27c]) by BL3PR11MB5747.namprd11.prod.outlook.com
 ([fe80::7627:31de:36ec:27c%5]) with mapi id 15.20.7228.022; Wed, 24 Jan 2024
 05:44:53 +0000
From: "Wang, Xiao W" <xiao.w.wang@intel.com>
To: Andrew Jones <ajones@ventanamicro.com>, David Laight
	<David.Laight@aculab.com>
CC: "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
	"palmer@dabbelt.com" <palmer@dabbelt.com>, "aou@eecs.berkeley.edu"
	<aou@eecs.berkeley.edu>, "conor.dooley@microchip.com"
	<conor.dooley@microchip.com>, "heiko@sntech.de" <heiko@sntech.de>, "Li,
 Haicheng" <haicheng.li@intel.com>, "linux-riscv@lists.infradead.org"
	<linux-riscv@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] riscv: Optimize crc32 with Zbc extension
Thread-Topic: [PATCH] riscv: Optimize crc32 with Zbc extension
Thread-Index: AQHaP65h4Tgp9DgCwEu/ue2vJWxme7DcmyaAgAvSDaA=
Date: Wed, 24 Jan 2024 05:44:52 +0000
Message-ID: <BL3PR11MB5747805F781890D336A417D7B87B2@BL3PR11MB5747.namprd11.prod.outlook.com>
References: <20240105080830.3738117-1-xiao.w.wang@intel.com>
 <20240116-9f09b002afc2337ab5e41e3f@orel>
In-Reply-To: <20240116-9f09b002afc2337ab5e41e3f@orel>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL3PR11MB5747:EE_|BL1PR11MB5954:EE_
x-ms-office365-filtering-correlation-id: b2975d85-886e-4234-bde3-08dc1c9f9682
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: s3iSpSqBG0fdp2iSj4sxAd1KK4bsD2ZxooxMea+6Yqo0GDXbz36oHaH22QuhBkyixoNCKVBMJtQy68W4iGClhcZ6kVwSg/zRFd/T/WjFAtAmDN5YnXQv8VMXcp30dNM3UY3uP2H/z6QDjgkqisQS2W/ZgcrUlMzjEHLota0RQmYMsYRdJvoNIdpponx9mlZLZCal67oqHsa2yWsi0VrKBsuke6i0ckhbcgNnt8N9y9wuA2UTxOvAWbWmUVsKROtulqGkbEWjFrLIaqfB9+AdkMyrNG4jlLlvD47uhyvEC279t/nPZW3HIzcqK1hzYtjb93WTMCNwH+vehxCLt2gaX5pNHp3daCVJRXMT2t3ptUknQMG1t9TqSp6Tkju8910jV5oOKnddEVOV7p/ZyModYl9uGGKlSqBHKnq68vp/8Yv34TuS7vRy6K/PJETLGyxRbxAk1d9j1ljYuy0zdTSmGNPniaXPl4eunyRBB41SGwVaoO8w6FTsu2U52K5GGlRaSXqK6OoobtYZcBCtTgjoyrI+p5iOUaYjSxRqxvk/azi49TZ9mhAilSoPODtdPK8rf+M8hviza5jW87UE/vXD4n6JJapC12o0U3allqBsesxXnWYYCnDUtbw/Y8/AMyElIWrzhY8hYcVYIzEd0aDZMfZn8v24fPBsggaEqXCDoZXHIOyI42oDZW6OV6222y9y
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB5747.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(366004)(39860400002)(136003)(396003)(230922051799003)(230273577357003)(230173577357003)(1800799012)(451199024)(186009)(64100799003)(64756008)(66446008)(54906003)(66476007)(66556008)(316002)(110136005)(66946007)(76116006)(26005)(66899024)(38070700009)(478600001)(9686003)(71200400001)(41300700001)(33656002)(966005)(38100700002)(2906002)(122000001)(53546011)(5660300002)(7696005)(6506007)(82960400001)(86362001)(52536014)(8676002)(8936002)(83380400001)(4326008)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?dUh/sl15NP7vOdlxpgFg5BsUDjKXrguQTSEK+9YoMZZCR45fFVbL5bkz?=
 =?Windows-1252?Q?zZ52fhxtFlWoswHtr0NWappNiSjf+3iWBTh7nxuSVcYRwFwAvHfffAH+?=
 =?Windows-1252?Q?MsdQhQgR8BzGGwTrg2PZSQkMhhVwwsG+vIn1/ecTI4Gb2F0+YHvnFzQO?=
 =?Windows-1252?Q?Bt8Ji3lPgpUu+FgBeiMvmfu6V4bCNWjfke2pl3psxyTT3c/g9XCJCTGF?=
 =?Windows-1252?Q?qSTKTzTtg2AhqX1AwanEqJzwkCGrCy+rBSyWff97Vy2u/hnOTRyF1AtO?=
 =?Windows-1252?Q?ghVunh5/utgT/NPMXYCpRBcXefe6+0bnPBe/pqtZIr3ftSjDcrnslyFS?=
 =?Windows-1252?Q?vv7dgfirXOM8tq7ISdgo31PUpdEkeWzzxLNzMICRzbvlTf0JU9OnX3Ko?=
 =?Windows-1252?Q?KjF7mU4+Ub/sgO/FK4l1a/GEKvqOJcKlO9QZUNGJuIpqKMTJTCir66tl?=
 =?Windows-1252?Q?J/ZZc2fa9gwrXUAPABgS4t5D1XCmTZ2MOV4VcKU8iupVa+N1Dj+nOYWP?=
 =?Windows-1252?Q?w0XY+gHWLX35Q3eV1M8zFCnDuZ2WE+VkSGb59A10jffiS4H80phvO7qt?=
 =?Windows-1252?Q?/LdUpmytVzdf4w5kie/C4KqRT9cTpdVf37xMwPVb0n0hqhpXkPKv+9GX?=
 =?Windows-1252?Q?7t6u79beBz+dhhOLjekI+t7p20rwqNFis9CpeuuFZQXX2fmkDvoTjX8p?=
 =?Windows-1252?Q?BJ4AuIaIZrI6BB8NzRCnMOyLJUcQdfamzV5xvXmkchZX0yNeaZq+xvmT?=
 =?Windows-1252?Q?tIYPKLSlriev7BQ5ylVmaG96nhW3V9IHL8pB8Sao40z5U5AFiI88sY+Y?=
 =?Windows-1252?Q?ipoI9wXCj6XG4YFQGC0aScRz2iymmqjoWGAURktP+L7d+WHasqb0739T?=
 =?Windows-1252?Q?UlvKn3V5eKoWBWiWFUmu1rxxnr0EnqNr+NAg/35nD+45r98muzHK+vRb?=
 =?Windows-1252?Q?tUBikd/R0MHgm3tnmKgdrKVRyHEl6XINofIJgE+G1bKforxU1bP+y2DF?=
 =?Windows-1252?Q?FiIOeLwzdGxiuw6Yelt5z1/HjZEjCoY559MXBVaQNbrtAIJGVKdabH9P?=
 =?Windows-1252?Q?ZEzdYjafDBbwoyfDDl6x/FfQjCnKV85g+HKMd9zvWc1kmh2ySzd1ZwmA?=
 =?Windows-1252?Q?NFyAJrRsC6sIiYQy3CPQx08S1frBZOcYprld7ZQ6p0LrE1QB7FAShG58?=
 =?Windows-1252?Q?iHZ+ykRCzu6LdL5zIYGlY30ckkJApbCv1wSjNjK1ZfZVdep13kcQiWiA?=
 =?Windows-1252?Q?NcDRVG3uONqANsfFrzFof2BsY7cOfmz96DYwC1eUZhmm1rpZZDRcml7u?=
 =?Windows-1252?Q?LiOi9Pcuxcj0GaWWl7s4nKzwBUt4g7Fwkruoc4KXeAevdkq9QuRuvZLE?=
 =?Windows-1252?Q?aBwa/uNjW+zCnmhm5Bv5Q07J7jwSMVFXSsDXgrc6Y04qtapvZH74FyQ3?=
 =?Windows-1252?Q?EaiY/Ll7DPboypT9YODBfiXpu8er30+GGi3R87niHFKxm9EcITmrKuzc?=
 =?Windows-1252?Q?V8I9gA72kBGDDDW6CL0Pr/0657cZAUXt4DC7kaPp52RPyZNda4VF+Z+Y?=
 =?Windows-1252?Q?L7n8tTo4ESbUVn6uiAd27xSVgqJTEo98bduMQnuVJTpP7f5Ge1CHEj0e?=
 =?Windows-1252?Q?/Qs+WO9QEAc7XOKqtU+ZZyok/gO3wzopueB9wmencGsSNG1PyugziUPj?=
 =?Windows-1252?Q?K3x0gZ7SHX4jtO0ei1LJQENPfKAPDWL/?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB5747.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2975d85-886e-4234-bde3-08dc1c9f9682
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jan 2024 05:44:52.9704
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /0R+CaLb63Gdv4WkNd9v8XfpeKa0R7iUPltMaP6wke1msY1DMPF5BOamUS7bpPFyn2r7gyiYCZo2OQ+hK62c5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5954
X-OriginatorOrg: intel.com

Hi Andrew,

> -----Original Message-----
> From: Andrew Jones <ajones@ventanamicro.com>
> Sent: Tuesday, January 16, 2024 11:04 PM
> To: Wang, Xiao W <xiao.w.wang@intel.com>
> Cc: paul.walmsley@sifive.com; palmer@dabbelt.com;
> aou@eecs.berkeley.edu; conor.dooley@microchip.com; heiko@sntech.de; Li,
> Haicheng <haicheng.li@intel.com>; linux-riscv@lists.infradead.org; linux-
> kernel@vger.kernel.org
> Subject: Re: [PATCH] riscv: Optimize crc32 with Zbc extension
>=20
> On Fri, Jan 05, 2024 at 04:08:30PM +0800, Xiao Wang wrote:
> > As suggested by the B-ext spec, the Zbc (carry-less multiplication)
> > instructions can be used to accelerate CRC calculations. Currently, the
> > crc32 is the most widely used crc function inside kernel, so this patch
> > focuses on the optimization of just the crc32 APIs.
> >
> > Compared with the current table-lookup based optimization, Zbc based
> > optimization can also achieve large stride during CRC calculation loop,
> > meantime, it avoids the memory access latency of the table-lookup based
> > implementation and it reduces memory footprint.
> >
> > If Zbc feature is not supported in a runtime environment, then the
> > table-lookup based implementation would serve as fallback via alternati=
ve
> > mechanism. To avoid the performance concern of unalignment access, we
> also
> > use the fallback implementation to handle the head and tail bytes if an=
y,
> > the main body is accelerated by Zbc extension.
> >
> > This patch is tested on QEMU VM with the kernel CRC32 selftest.
>=20
> Ideally we'd also have the results of some benchmarks, or at least a
> dynamic instruction count or something, but I don't suspect that the
> table-lookup would "win" over Zbc. The bigger question is whether we
> want three implementations, because I assume we want Zvbc, particularly
> since [1] says
>=20
> """
> Zvbc is listed as a development option for use in other algorithms,
> and will become mandatory. Scalar Zbc is now listed as an expansion
> option, i.e., it will probably not become mandatory.
> """
>=20
> [1] https://github.com/riscv/riscv-profiles/blob/main/rva23-profile.adoc

I would collect instructions count change and include the info in the commi=
t log.
Regarding to the bigger question, I have some thoughts:

- It looks this question also stands for some other cases like lib/str*, wh=
ich currently
has been accelerated by Zbb-ext, but since the in-kernel RVV support has be=
en enabled,
we may also use RVV to accelerate the lib/str*.
ALTERNATIVE_2 mechanism allows a second code patching on the same location.=
 So
two alternative versions for the same function can be supported.

- At this moment, I can't figure out how Zvbc can be used to better acceler=
ate these
crc32 APIs which take just one data stream as input. I have rough idea for =
a batched
version API which takes multi data stream as input (a parallel implementati=
on of below
Zbc acceleration), but not for these 3 APIs here.
BTW, the vector "clmulr" insn is not listed in the Zvbc spec, but it's usef=
ul in below implementation.
https://github.com/riscv/riscv-crypto/blob/main/doc/vector/riscv-crypto-vec=
tor-zvbc.adoc
Anyway, if we come up with a Zvbc based optimization in future, then ALTERN=
ATIVE_2
would help.

>=20
>=20
> A few nits below.

Thanks for all the above & below comments. Will adopt most of the suggestio=
ns, except two,
please check below.

>=20
> >
> > Signed-off-by: Xiao Wang <xiao.w.wang@intel.com>
> > ---
> >  arch/riscv/Kconfig      |  23 +++++
> >  arch/riscv/lib/Makefile |   1 +
> >  arch/riscv/lib/crc32.c  | 216
> ++++++++++++++++++++++++++++++++++++++++
> >  include/linux/crc32.h   |   3 +
> >  4 files changed, 243 insertions(+)
> >  create mode 100644 arch/riscv/lib/crc32.c
> >
[...]

> > +#if (BITS_PER_LONG =3D=3D 64)
> > +					  size_t len, u32 poly, u64 poly_qt,
> > +#else
> > +					  size_t len, u32 poly, u32 poly_qt,
> > +#endif
>=20
> How about creating a new type for poly_qt, defined as u64 for xlen=3D64
> and u32 for xlen=3D32 to avoid the #ifdef?

Would make it as "unsigned long", as David's comment.

>=20
> > +					  fallback crc_fb)
> > +{
> > +	size_t offset, head_len, tail_len;
> > +	const unsigned long *p_ul;
> > +	unsigned long s;
> > +
> > +	asm_volatile_goto(ALTERNATIVE("j %l[legacy]", "nop", 0,
> > +				      RISCV_ISA_EXT_ZBC, 1)
> > +			  : : : : legacy);
> > +
> > +	/* Handle the unalignment head. */
> > +	offset =3D (unsigned long)p & OFFSET_MASK;
> > +	if (offset) {
> > +		head_len =3D MIN(STEP - offset, len);
> > +		crc =3D crc_fb(crc, p, head_len);
> > +		len -=3D head_len;
> > +		p +=3D head_len;
> > +	}
> > +
> > +	tail_len =3D len & OFFSET_MASK;
> > +	len =3D len >> STEP_ORDER;
> > +	p_ul =3D (unsigned long *)p;
> > +
> > +	for (int i =3D 0; i < len; i++) {
> > +#if (BITS_PER_LONG =3D=3D 64)
> > +		s =3D (unsigned long)crc ^ __cpu_to_le64(*p_ul++);
> > +		/* We don't have a "clmulrh" insn, so use clmul + slli instead.
> > +		 */
>=20
> need opening /* comment wing
>=20
> > +		asm volatile (".option push\n"
> > +			      ".option arch,+zbc\n"
> > +			      "clmul	%0, %1, %2\n"
> > +			      "slli	%0, %0, 1\n"
> > +			      "xor	%0, %0, %1\n"
> > +			      "clmulr	%0, %0, %3\n"
> > +			      "srli	%0, %0, 32\n"
> > +			      ".option pop\n"
> > +			      : "=3D&r" (crc)
> > +			      : "r" (s),
> > +				"r" (poly_qt),
> > +				"r" ((u64)poly << 32)
> > +			      :);
> > +#else
> > +		s =3D crc ^ __cpu_to_le32(*p_ul++);
> > +		/* We don't have a "clmulrh" insn, so use clmul + slli instead.
>=20
> also here
>=20
> > +		 */
> > +		asm volatile (".option push\n"
> > +			      ".option arch,+zbc\n"
> > +			      "clmul	%0, %1, %2\n"
> > +			      "slli	%0, %0, 1\n"
> > +			      "xor	%0, %0, %1\n"
> > +			      "clmulr	%0, %0, %3\n"
> > +			      ".option pop\n"
> > +			      : "=3D&r" (crc)
> > +			      : "r" (s),
> > +				"r" (poly_qt),
> > +				"r" (poly)
> > +			      :);
> > +#endif
>=20
> Instead of the #ifdef here, we could provide function wrappers for the as=
m
> which would be defined above in the first #ifdef ladder.
>=20
> > +	}
> > +
> > +	/* Handle the tail bytes. */
> > +	if (tail_len)
> > +		crc =3D crc_fb(crc, (unsigned char const *)p_ul, tail_len);
> > +	return crc;
> > +
> > +legacy:
> > +	return crc_fb(crc, p, len);
> > +}
> > +
> > +u32 __pure crc32_le(u32 crc, unsigned char const *p, size_t len)
> > +{
> > +	return crc32_le_generic(crc, p, len, CRC32_POLY_LE,
> CRC32_POLY_QT_LE,
> > +				crc32_le_base);
> > +}
> > +
> > +u32 __pure __crc32c_le(u32 crc, unsigned char const *p, size_t len)
> > +{
> > +	return crc32_le_generic(crc, p, len, CRC32C_POLY_LE,
> > +				CRC32C_POLY_QT_LE, __crc32c_le_base);
> > +}
> > +
> > +u32 __pure crc32_be(u32 crc, unsigned char const *p, size_t len)
> > +{
> > +	size_t offset, head_len, tail_len;
> > +	const unsigned long *p_ul;
> > +	unsigned long s;
> > +
> > +	asm_volatile_goto(ALTERNATIVE("j %l[legacy]", "nop", 0,
> > +				      RISCV_ISA_EXT_ZBC, 1)
> > +			  : : : : legacy);
> > +
> > +	/* Handle the unalignment head. */
> > +	offset =3D (unsigned long)p & OFFSET_MASK;
> > +	if (offset) {
> > +		head_len =3D MIN(STEP - offset, len);
> > +		crc =3D crc32_be_base(crc, p, head_len);
> > +		len -=3D head_len;
> > +		p +=3D head_len;
> > +	}
> > +
> > +	tail_len =3D len & OFFSET_MASK;
> > +	len =3D len >> STEP_ORDER;
> > +	p_ul =3D (unsigned long *)p;
> > +
> > +	for (int i =3D 0; i < len; i++) {
> > +#if (BITS_PER_LONG =3D=3D 64)
> > +		s =3D (unsigned long)crc << 32;
> > +		s ^=3D __cpu_to_be64(*p_ul++);
> > +#else
> > +		s =3D crc ^ __cpu_to_be32(*p_ul++);
> > +#endif
>=20
> Could write the above without #ifdef with
>=20
>  if (IS_ENABLED(CONFIG_64BIT)) {
>     ...
>  } else {
>     ...
>  }

I got a warning for riscv32 build with this change, gcc v12.2.0
./arch/riscv/lib/crc32.c:191:40: warning: left shift count >=3D width of t=
ype [-Wshift-count-overflow]
It looks compiler takes the always-impossible code branch into consideratio=
n.

BRs,
Xiao


