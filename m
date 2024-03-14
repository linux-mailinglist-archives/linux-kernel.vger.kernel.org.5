Return-Path: <linux-kernel+bounces-102717-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF38387B66E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 03:33:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32F011F22725
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 02:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0F3D8BFB;
	Thu, 14 Mar 2024 02:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dnj5zFOm"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD4168BE5
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 02:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710383588; cv=fail; b=Fz6UiX7gy9KVeWSDobFD/8yBeDJgD3/J1lzrNkpgxa3/6Djs7mpIb96zz60GlwFPAD0JAmnzyJj1qCa8elU+WhVTxpwtaMYmCVn7KKXmyGc7bbhiSlMfEm6SgxVB2WcPShf1JfmUTl/awmNGYEgvGPLJCkm4Vw8gK0gBSkHloOM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710383588; c=relaxed/simple;
	bh=i/+P56aNfAQJT+nofBFZkD9Yl5wfsSBCgEhC+LvqYFE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=psx19NPt8lo3c73hHTVUIPOdr8xVfeD3pdDTrmqsTb1CYc+DMUykg0+s5O8IplIHPu7wT6DbjNg+uGuqDcbzwgB5yr17cslu4jrFf/y2HbmC2KsThADWW5b9uVdjHs7enrQ3hFHmgZQPurVJ4ESiLfkyNm3SumbWvhJ56qGB1yk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dnj5zFOm; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710383586; x=1741919586;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=i/+P56aNfAQJT+nofBFZkD9Yl5wfsSBCgEhC+LvqYFE=;
  b=dnj5zFOm5kbleV9RFpj8wH9cyrBHFgxBH4Si4StVx13UN8o/Mok1oXu+
   DWTvSjcYpFe+6z/vwyDLUX+HUmYrClwNCjCkcvcE57CdpmGHiZaDL9cq6
   Ikw4DvvWVU+Kfi7nXeHXFhWKkEXMQw2GXjvZXhXTzHr1TpoIMhBglIT4f
   E9i2Zhb1sk61vx+/qac8/fhA9YVVPBdpWz6kobFdjBx3ubCZouOmwGISs
   kzuCAbra2jnrQJd2oDEj4Ju3kS0EKRzJBRPr+TzN4/L1+Bk11PBY68Wd6
   aGCjyziLI9A5tpP5bg3z7qcyX+UnaEA0RLXHtKk4CZScE9X0q7MZ6W+ok
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11012"; a="9001430"
X-IronPort-AV: E=Sophos;i="6.07,124,1708416000"; 
   d="scan'208";a="9001430"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2024 19:33:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,124,1708416000"; 
   d="scan'208";a="16789961"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Mar 2024 19:33:06 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 13 Mar 2024 19:33:05 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 13 Mar 2024 19:33:04 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 13 Mar 2024 19:33:04 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 13 Mar 2024 19:32:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aRHe/tmA2nMmrKp8ff7x8cUEN9pCJxQv2oYaxlylDwEeiI2dBRbbfR2FOSCxssYidHPgERH/n0Fip4M4OXE6nddnl2vIJIOvXBiB7Mc67cYabELqFDTTMw9PUgJv+glNWDmslLFFwuraFUFMa72GK2a0D7B2d7syHPmFH9G4BtWAwEqhvpisxOvDuyWLWRJn1P53C4aiSK3y+fQ1qZY6qrnWLNtCZjEC64bDpV9uAxpBc7PieNJav+auN/rXBjF/bl0otT1dUNCHnz6sL9TkkwmPFmCz/LRAj+9zs10F9i3Bu6bWEwM12wKgRGfawtpYCfxiEHGAIQjxam313Y0orw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=121xbhs73+8MGAr/fy/Z5AOBycSxhAf0ckHT9IEXQEs=;
 b=JgtXcfiu+LEf2GQD6s2i6U3XucPNAAps6gzP6ce+wPJYkJ4Ty0RagCzyghAkf9ux2W0u3jCfb1/LIaW0DgGpesRqfomLA9dDya4d5YNfRa1Ao4oX97aiT7ioDOfi6IGnKq9zKBjT1e8tf0Es8XE+Zu2af407y+0ndEqLOtC4VNvBe0m0goCUjly9zV3hMNzYOKs5w7FI3c6vnDbRlUioylo6a8v+ydf8cDi51F0iDFTPDL/eSWhgJNuicJO+x+o9adVr2ElQ5dt8q1Qhx/g7gg+pFZgtaCJERdTT4qstmSxjeSL8hEiG+tc58Nceko+sOmL1ygXrdAXAxr8H9nMoLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5751.namprd11.prod.outlook.com (2603:10b6:8:12::16) by
 LV8PR11MB8461.namprd11.prod.outlook.com (2603:10b6:408:1e6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.18; Thu, 14 Mar
 2024 02:32:57 +0000
Received: from DM8PR11MB5751.namprd11.prod.outlook.com
 ([fe80::7cad:cb8a:117e:9f96]) by DM8PR11MB5751.namprd11.prod.outlook.com
 ([fe80::7cad:cb8a:117e:9f96%4]) with mapi id 15.20.7386.015; Thu, 14 Mar 2024
 02:32:57 +0000
From: "Wang, Xiao W" <xiao.w.wang@intel.com>
To: Charlie Jenkins <charlie@rivosinc.com>
CC: "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
	"palmer@dabbelt.com" <palmer@dabbelt.com>, "aou@eecs.berkeley.edu"
	<aou@eecs.berkeley.edu>, "ajones@ventanamicro.com" <ajones@ventanamicro.com>,
	"conor.dooley@microchip.com" <conor.dooley@microchip.com>, "heiko@sntech.de"
	<heiko@sntech.de>, "david.laight@aculab.com" <david.laight@aculab.com>, "Li,
 Haicheng" <haicheng.li@intel.com>, "linux-riscv@lists.infradead.org"
	<linux-riscv@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3] riscv: Optimize crc32 with Zbc extension
Thread-Topic: [PATCH v3] riscv: Optimize crc32 with Zbc extension
Thread-Index: AQHadPUZgJSwa1OZEUm5ETdeu7ZVobE2Rs0AgAA0pQA=
Date: Thu, 14 Mar 2024 02:32:57 +0000
Message-ID: <DM8PR11MB57514B86A2C1AA40973AF705B8292@DM8PR11MB5751.namprd11.prod.outlook.com>
References: <20240313032139.3763427-1-xiao.w.wang@intel.com>
 <ZfIs5ND0S08N2zLd@ghost>
In-Reply-To: <ZfIs5ND0S08N2zLd@ghost>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR11MB5751:EE_|LV8PR11MB8461:EE_
x-ms-office365-filtering-correlation-id: 84e76c87-5c2f-41e0-0758-08dc43cf0f2b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uXJ0BpTnD2Iaw3a0NNs410F2dpavWchh103bHus4xHBowVwbd3rq2P9449LEWQiPTHW00xVjvhYwY1HJ4JwKGq7JttTrNV7x/+EeXMrAZh2i9DvbxUJoAlTsjNXrg+KXJxNdn44WamKziqHTtZxDxynzOGbs6TweBFR44jYp0qOge975U7sE6X/R+EybRVMpzfr5aX9CAkBjE5XRdpP+hBVIu2S6I31Nm34i2NUjyIkMzZmSgYFZdzhO5rMLJcANL8n8lQDhGzeqJwrLOBAdT56pvNABP6U34ChOHOLCm8b0xXiijRLiYteV1xn47mZRNLNEp86zQi4nl8j48jdzymehzVwXMUFTh73VbdhIDiPcpzWW13N+NkHitXnQNRdqzo48T+mB5ttXy6lcQAgsnjivS+UMhY/j4vZ3/zr7U5/IYIsim+DM3of2TGnsvn5ToR48kLgt2hHuaKHM3MMUhEGyi6AA4OdphOmfpOWEkRA/67QPz/z5jTM6vocz/1S3qEitkpD9VPZRa8lrloqF+6l2z7RPYUt2B0FV4rtQGlUX7tBSgt859LoGdY1mxzNc9/yuLr5nVtMRFxUmtquXIJb1kKzJP2e6BjZI8x6C9TLBn9hIk0WXku/IIb51FnugSgLelPQGkcMCM7mc1C87jVWJ2cZFFHiTX7C39/AyEutOP0IWSKYSAkuWwSM5yyeJB5aCO44eoCa11Fssse48Tw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5751.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?Windows-1252?Q?68L1vz0S6IkMZuwoCBS4n7R4SLbjF4mlIJ2aXc8iCzbboSBJI41fAy20?=
 =?Windows-1252?Q?srB6i0/7wWu0jaGRlsWIzacCZ3Pe621Mez6S7xzvT5u0jtK0rqtfWfa0?=
 =?Windows-1252?Q?i8kp9TbYeghhU9UslfJ2BVYLYLNZyjf9vfhx9M6S51iJzAqGaLcqtQPN?=
 =?Windows-1252?Q?95boH4TXF6Gjgv55uFGaxi7CF5C9EHq1L7IzngB+PAEd4JMjiNHBSwn3?=
 =?Windows-1252?Q?AWKUwFpWWtMlqGBAU6rHOOPwT/PrIS495PP1bo8VyrUSiM0u1RILf85f?=
 =?Windows-1252?Q?yHd+468R2OFbiyLFq2lV0WmHkZMhoxF72ZCKyd8akWC6ADJSOZMRHRPp?=
 =?Windows-1252?Q?fMc5zOc9BD/ZhTZcSRAgPobglaAtMQ2PlPiSwEuhgFOg4YcsEAguJyHR?=
 =?Windows-1252?Q?8BXdPX/DnuDSPAFl9kEMXpIVe78nnrJuxE8IR0J6jKTX8r0e4qowk5F3?=
 =?Windows-1252?Q?/LFmvgFiKtOL1BoN1w2rTj6YhBJRzOudgKTJ2REA9Pna6gxLTYplk8CD?=
 =?Windows-1252?Q?gO3NiKv82xLY1jufbsL6aRwKM7V9+f8jWiTTe6FAW3nkS6zh9u8y0j/R?=
 =?Windows-1252?Q?Hm3jY53YnNVNayLwcKdeQ9N5qhVW3ot9DnNbspqQqp8bWpfL6ShIqasi?=
 =?Windows-1252?Q?YxVNzUlTLOiX66KSWy4/ZcOqNNUQwZANiFpWdsccDMG4jR/VEab+hlND?=
 =?Windows-1252?Q?8OZqR4/XsTe2N7wW/sByww3s+tkFc10i0Jz+wWsXjEcZVr6PAjPRxpGu?=
 =?Windows-1252?Q?jh5Kti9/FC2uRAtzJSuUjjYdytuCFKeEerhazmgnxVt1j2DpdncwrenN?=
 =?Windows-1252?Q?neYDspu4RPjV8SugZFdMpRqN7bTpqbboa9O1CaJYfyCjO2/TCvtLBZl9?=
 =?Windows-1252?Q?fHMxYE9ThHgV4DkBuyTWxFp2Kno115141u1aE2gpXz+yoN/O03gymEZO?=
 =?Windows-1252?Q?ljYPSFXux0fBbm7E91wSR9y4lviJJkwXz3iYDmEtw3Iw/lKnHcKLTc2s?=
 =?Windows-1252?Q?wBs1OJ95Qm6CvWrr8ndY21F56cTFEPq44wSYBZLG63iptGCUrEY1Gp7p?=
 =?Windows-1252?Q?coa4YLaN+ZKS1Y1EqqalcWaH0enGXvpJ85qE79Yk1fcBE2eKrcdq6aX5?=
 =?Windows-1252?Q?IJwWW9mtmjsPdY+ex9cqaw6jkuBYI1mo1vvZr15Gl53qs6svkc5Umdzd?=
 =?Windows-1252?Q?3IMD8qCohWHfSTxok+ANLD57xB5RBsguEmZvTzWYXc9yKxywsjRZNwNL?=
 =?Windows-1252?Q?rZiarS0RZSXbOuZ5Et86KLgRLflEKPzArpmijgzHoW90TCKqMs5N4z2h?=
 =?Windows-1252?Q?VCKFyUjeYKZocWkkCHqtjGgJ7XRSASOWzALYXJPUk/gMMz3MYCqivTk5?=
 =?Windows-1252?Q?KeXZxAwLgnIcF08hnM2ED9HVXNVE7pqpfFlYRHjtoQ6QcFWlXpXIBtrs?=
 =?Windows-1252?Q?VVLF5F/ahzG1VbAAoWORDuFBglpdcWKA0G7EuSGgRnyNKJCTiq4LCbib?=
 =?Windows-1252?Q?vQIUpvp97ihFT47qLYvEjIIgWhzsA9S8HsYvAV75OT0X5zw4rlV+MdSC?=
 =?Windows-1252?Q?CV3Fjo68ThusKv6868UWyuFJTee5DCZ7kCTu6LYtn0ezVpmGqgXBVx3Q?=
 =?Windows-1252?Q?6pesFEpGWL0wWmAQrqy0UUiDVHhesOcBgLfKAuSZcUQd+hm4BaOhRcz8?=
 =?Windows-1252?Q?UokgVa5XjamcCgHln8pJdiIO9HX9Scyl?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5751.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84e76c87-5c2f-41e0-0758-08dc43cf0f2b
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2024 02:32:57.1261
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i68r9x1N9QR3Qrx6HqmOkUBSdIO+npDkHxrvG6CANe+J3yw6cZCSNC+ZhHaJy9ExDJTfmmAEBfc+y/Ygih3XDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8461
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Charlie Jenkins <charlie@rivosinc.com>
> Sent: Thursday, March 14, 2024 6:47 AM
> To: Wang, Xiao W <xiao.w.wang@intel.com>
> Cc: paul.walmsley@sifive.com; palmer@dabbelt.com;
> aou@eecs.berkeley.edu; ajones@ventanamicro.com;
> conor.dooley@microchip.com; heiko@sntech.de; david.laight@aculab.com;
> Li, Haicheng <haicheng.li@intel.com>; linux-riscv@lists.infradead.org; li=
nux-
> kernel@vger.kernel.org
> Subject: Re: [PATCH v3] riscv: Optimize crc32 with Zbc extension
>=20
> On Wed, Mar 13, 2024 at 11:21:39AM +0800, Xiao Wang wrote:
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
> > mechanism.
> >
> > By inspecting the vmlinux built by gcc v12.2.0 with default optimizatio=
n
> > level (-O2), we can see below instruction count change for each 8-byte
> > stride in the CRC32 loop:
> >
> > rv64: crc32_be (54->31), crc32_le (54->13), __crc32c_le (54->13)
> > rv32: crc32_be (50->32), crc32_le (50->16), __crc32c_le (50->16)
>=20
> Even though this loop is optimized, there are a lot of other
> instructions being executed else where for these tests. When running the
> test-case in QEMU with ZBC enabled, I get these results:
>=20
> [    0.353444] crc32: CRC_LE_BITS =3D 64, CRC_BE BITS =3D 64
> [    0.353470] crc32: self tests passed, processed 225944 bytes in 204470=
0
> nsec
> [    0.354098] crc32c: CRC_LE_BITS =3D 64
> [    0.354114] crc32c: self tests passed, processed 112972 bytes in 28900=
0
> nsec
> [    0.387204] crc32_combine: 8373 self tests passed
> [    0.419881] crc32c_combine: 8373 self tests passed
>=20
> Then when running with ZBC disabled I get:
>=20
> [    0.351331] crc32: CRC_LE_BITS =3D 64, CRC_BE BITS =3D 64
> [    0.351359] crc32: self tests passed, processed 225944 bytes in 567500
> nsec
> [    0.352071] crc32c: CRC_LE_BITS =3D 64
> [    0.352090] crc32c: self tests passed, processed 112972 bytes in 28990=
0
> nsec
> [    0.385395] crc32_combine: 8373 self tests passed
> [    0.418180] crc32c_combine: 8373 self tests passed
>=20
> This is QEMU so it's not a perfect representation of hardware, but being
> 4 times slower with ZBC seems suspicious. I ran these tests numerous
> times and got similar results. Do you know why these tests would perform
> 4 times better without ZBC?

ZBC instruction' functionality is relatively more complex, so QEMU tcg uses=
 the
helper function mechanism to emulate these ZBC instructions. Helper functio=
n
gets called for each ZBC instruction within tcg JIT code, which is ineffici=
ent. I see
similar issue about the Vector extension, the optimized RVV implementation =
runs
actually much slower than the scalar implementation on QEMU tcg.

>=20
> >
> > The compile target CPU is little endian, extra effort is needed for byt=
e
> > swapping for the crc32_be API, thus, the instruction count change is no=
t
> > as significant as that in the *_le cases.
> >
> > This patch is tested on QEMU VM with the kernel CRC32 selftest for both
> > rv64 and rv32.
> >
> > Signed-off-by: Xiao Wang <xiao.w.wang@intel.com>
> > ---
> > v3:
> > - Use Zbc to handle also the data head and tail bytes, instead of calli=
ng
> >   fallback function.
> > - Misc changes due to the new design.
> >
> > v2:
> > - Fix sparse warnings about type casting. (lkp)
> > - Add info about instruction count change in commit log. (Andrew)
> > - Use the min() helper from linux/minmax.h. (Andrew)
> > - Use "#if __riscv_xlen =3D=3D 64" macro check to differentiate rv64 an=
d rv32.
> (Andrew)
> > - Line up several macro values by tab. (Andrew)
> > - Make poly_qt as "unsigned long" to unify the code for rv64 and rv32.
> (David)
> > - Fix the style of comment wing. (Andrew)
> > - Add function wrappers for the asm code for the *_le cases. (Andrew)
> > ---
> >  arch/riscv/Kconfig      |  23 ++++
> >  arch/riscv/lib/Makefile |   1 +
> >  arch/riscv/lib/crc32.c  | 294

[...]
> > +static inline u32 __pure crc32_le_generic(u32 crc, unsigned char const=
 *p,
> > +					  size_t len, u32 poly,
> > +					  unsigned long poly_qt,
> > +					  fallback crc_fb)
> > +{
> > +	size_t offset, head_len, tail_len;
> > +	unsigned long const *p_ul;
> > +	unsigned long s;
> > +
> > +	asm_volatile_goto(ALTERNATIVE("j %l[legacy]", "nop", 0,
>=20
> This needs to be changed to be asm goto:
>=20
> 4356e9f841f7f ("work around gcc bugs with 'asm goto' with outputs")
>=20

Thanks for the pointer. Will change it.

> > +				      RISCV_ISA_EXT_ZBC, 1)
> > +			  : : : : legacy);
> > +
> > +	/* Handle the unaligned head. */
> > +	offset =3D (unsigned long)p & OFFSET_MASK;
> > +	if (offset && len) {
>=20
> If len is 0 nothing in the function seems like it will modify crc. Is the=
re
> a reason to not break out immediately if len is 0?
>=20

Yeah, if len is 0, then crc won't be modified.
Normally in scenarios like hash value calculation and packets CRC check,
the "len" can hardly be zero. And software usually avoids unaligned buf
addr, which means the "offset" here mostly is false.

So if we add a "len =3D=3D 0" check at the beginning of this function, it w=
ill
introduce a branch overhead for the most cases.

> > +		head_len =3D min(STEP - offset, len);
> > +		crc =3D crc32_le_unaligned(crc, p, head_len, poly, poly_qt);
> > +		p +=3D head_len;
> > +		len -=3D head_len;
> > +	}
> > +
> > +	tail_len =3D len & OFFSET_MASK;
> > +	len =3D len >> STEP_ORDER;
> > +	p_ul =3D (unsigned long const *)p;
> > +
> > +	for (int i =3D 0; i < len; i++) {
> > +		s =3D crc32_le_prep(crc, p_ul);
> > +		crc =3D crc32_le_zbc(s, poly, poly_qt);
> > +		p_ul++;
> > +	}
> > +
> > +	/* Handle the tail bytes. */
> > +	p =3D (unsigned char const *)p_ul;
> > +	if (tail_len)
> > +		crc =3D crc32_le_unaligned(crc, p, tail_len, poly, poly_qt);
> > +
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
> > +static inline u32 crc32_be_unaligned(u32 crc, unsigned char const *p,
> > +				     size_t len)
> > +{
> > +	size_t bits =3D len * 8;
> > +	unsigned long s =3D 0;
> > +	u32 crc_low =3D 0;
> > +
> > +	s =3D 0;
> > +	for (int i =3D 0; i < len; i++)
> > +		s =3D *p++ | (s << 8);
> > +
> > +	if (__riscv_xlen =3D=3D 32 || len < sizeof(u32)) {
> > +		s ^=3D crc >> (32 - bits);
> > +		crc_low =3D crc << bits;
> > +	} else {
> > +		s ^=3D (unsigned long)crc << (bits - 32);
> > +	}
> > +
> > +	crc =3D crc32_be_zbc(s);
> > +	crc ^=3D crc_low;
> > +
> > +	return crc;
> > +}
> > +
> > +u32 __pure crc32_be(u32 crc, unsigned char const *p, size_t len)
> > +{
> > +	size_t offset, head_len, tail_len;
> > +	unsigned long const *p_ul;
> > +	unsigned long s;
> > +
> > +	asm_volatile_goto(ALTERNATIVE("j %l[legacy]", "nop", 0,
>=20
> Same here
>=20

Will change it.

Thanks for the comments.
-Xiao


