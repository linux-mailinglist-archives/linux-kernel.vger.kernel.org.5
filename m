Return-Path: <linux-kernel+bounces-104086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 708FF87C8D4
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 07:41:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	by am.mirrors.kernel.org (Postfix) with ESMTP id 98A3E1F210B1
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 06:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB48B156CF;
	Fri, 15 Mar 2024 06:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LptHZTyX"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D69A14A9F;
	Fri, 15 Mar 2024 06:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710483873; cv=fail; b=i4cFB7972tosvnxJPQdjTSFnEzB6iIzfui42MC3dxeSsqtf3ACPRiELPNL+IaoICG6FmFQKgEofxxEkVyPpSFKAgNzPt2S9fHf6djD8hO987m8iKXwSze4Iw0aZUHgoHqDlt0TF4TGSqU/pQt9L6KIEBSWA9/+HuJAwo5/NJTxg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710483873; c=relaxed/simple;
	bh=YieE4CvAt1sqdVA2smdq/6mVWGm0pFlgrJVFg5o12Zw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZZbV1u/QhX8fc14sJaBKMBOtEqM3Fchqt3Lva5IxyhJGXmo25uVnn7CtDhlxlNpESSmPJjn4LzO1F6wfS0k+axMgAiRa48T3NFYWUIgJ1o3fIpp2TJW4DD/fOEgFvGLSg5tnZaZCcpXDi6jzd7x/Ttkh5anY6m9rGAbpqXst4f8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LptHZTyX; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710483871; x=1742019871;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=YieE4CvAt1sqdVA2smdq/6mVWGm0pFlgrJVFg5o12Zw=;
  b=LptHZTyXWbN7uPBAEwasMS5TVGemh/+h5pPA2Gb4muyQwoYKkPiQ+DX4
   3z9uq4cBWFr8GBjufI/S98ADRJQ8TOdGL+bTWdPLfbBfFsDIjrGStYRAL
   bIW5uch8YXIrmXGbO2HUMvfuNadDYEpk1KXm25Fw70sv55OFrNFYLOJ29
   3D+ZshNVWMLicweNnihmws8ZuwXFJGj3hDwUVkgxHYTi9JFcPq/VJarPd
   bf98WcSHsXxBKA9mw8Np353JAaXCgSlyfbiBKknaLBkJsKzTh+3BJmZ9+
   pzE5o3FaMVZrREHpT+NPCBMy/+WiPhBRJ3vrCX5OLR4/dZYHIdbrpDA5K
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11013"; a="9175269"
X-IronPort-AV: E=Sophos;i="6.07,127,1708416000"; 
   d="scan'208";a="9175269"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2024 23:24:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,127,1708416000"; 
   d="scan'208";a="50019089"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Mar 2024 23:24:29 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 14 Mar 2024 23:24:28 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 14 Mar 2024 23:24:28 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 14 Mar 2024 23:24:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GvdRW4CTABvDw1FRchx3SqJGLpPviL83WjEMdXwz4483l7z3Bqyvs4mHuzS0ltFE6Oh99Dq9d2Ysqoj/yHhTg+IkGPTlQr1M/HTJn7c5cwv3E5t9D5KOtSLFdLi7ezKfxp0S/j11o4sFB3G60r//mwSs7rZolpJ+ub4PrK5QEVVmr+ZDGZ6Htn/yMMRUtZOxNiqdTmFiyYEBdX5JHOvyRgtPtEjwfn5yLPasH1Rpla+d4pyjgEp+zcRwZx/MmWtTV0oyfg4SGDpUv55UNd+qu/KGR0sypw/QTL1LEggy9nX0/MBGZpBPNOJgS0CEFt4tFz8AIZbVM0DG5MZfyFkXaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5bBkYTbBSoQ7lFLV7xpGPfeFTyHl8I7fSX/XSexeAqI=;
 b=ABEbcyJe/vTLnstczLqrZLhQ6pZ6ex02HsTFjyvZaAjAEjCX1aTmPhsgnhWHjdSxVhUv81cc6gQR1qBXgvhRQR2vZzdj7WOFrXCPooM8FlHqO2KBTJqXJ5SOXMP3KnD9eZ/Zz94t3o4GN6OHusohalQP/x8+CTcKwoekCtPqQfQTqgrAmWyeHWqtJax+aYUoBFx+a6eyu3Xq5quQo1Een58Q5eXq1yPj+RtaTdi+M6xu0duIfNKjk2dGcWGh6Y/dqn5aJL/NY/ZuDjYvfEmzKjgZoRUTmJN5vzFDdtGDk++X78BOFdp3/bx0grr8u/1pxxSwfLoaK60fMXYoP1rVmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM4PR11MB6020.namprd11.prod.outlook.com (2603:10b6:8:61::19) by
 PH8PR11MB7117.namprd11.prod.outlook.com (2603:10b6:510:217::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.17; Fri, 15 Mar
 2024 06:24:12 +0000
Received: from DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::7ab1:eed9:f084:6889]) by DM4PR11MB6020.namprd11.prod.outlook.com
 ([fe80::7ab1:eed9:f084:6889%4]) with mapi id 15.20.7386.015; Fri, 15 Mar 2024
 06:24:11 +0000
From: "Zhang, Qiang4" <qiang4.zhang@intel.com>
To: Nathan Chancellor <nathan@kernel.org>
CC: Andrew Morton <akpm@linux-foundation.org>, Nick Desaulniers
	<ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, Justin Stitt
	<justinstitt@google.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"llvm@lists.linux.dev" <llvm@lists.linux.dev>, "Stable@vger.kernel.org"
	<Stable@vger.kernel.org>, "Zhang, Qiang4" <qiang4.zhang@intel.com>
Subject: RE: [PATCH] memtest: use {READ,WRITE}_ONCE in memory scanning
Thread-Topic: [PATCH] memtest: use {READ,WRITE}_ONCE in memory scanning
Thread-Index: AQHadFQSJGEbnIyyQ0G1fVC+polJ+bE17SuAgAJYgTA=
Date: Fri, 15 Mar 2024 06:24:11 +0000
Message-ID: <DM4PR11MB6020ECE5592459BB33281A16DF282@DM4PR11MB6020.namprd11.prod.outlook.com>
References: <20240312080422.691222-1-qiang4.zhang@intel.com>
 <20240313172141.GB3064248@dev-arch.thelio-3990X>
In-Reply-To: <20240313172141.GB3064248@dev-arch.thelio-3990X>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB6020:EE_|PH8PR11MB7117:EE_
x-ms-office365-filtering-correlation-id: d1c3e526-1d83-48e3-787e-08dc44b8877a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tns3mobdxzK8NQf3MrzMB3J467bnKBQfVjO7akh+jsFNcTTLkyzs0dYgqWBeTNPCxdNKqU1m8RwZvNXERr6DnptNdg7Cxk/qZOqbbLT2CD4BIeCXzdbhrR1pSLwOwpmRbcAIoEhjVOCTf7oYCKdTG5gvsBK6fwc68eKwz2VnNveo8fwIW2D+n2qs/9ypU3ESJKvMoFFokzYbjh8/a5p+4m0w3PNWO04XiKtP/mk4ShLlCTVv4WPwvI3ATb+hmSeWLiRev2O9llOIWNHukBlqmlORRWxrMAAaJbORT9QTsAcUavde+Dfu5k03AeLku76fmQTch3Yy3taYhiyK0Dpt8PM3euWMe9zuhA0IDbgv6L7lvR7jRURmscnazIDzsTwuNCYgUw7cI8l2NovR+5u6lByDxOZtCtzPxFTIszqGxhR6HtdzVsqILUaNTF2hSzMbQYns+50TktggFgtA3nY4auRhTV+ET3b0AZV8qd9iWRJ4kndste9ZDyuN3/zJ0To6Ql1ufrlMG56Jp/QNjEQgcZs++SQeTybUql8motOVXJA924/0kkDamElXkyuPbDqGAgYzImsVC25BqvpmtwId+mfEi7+fPUoZfW4+qPJvXPmKMPZ7IA2WDHQwKnWo0aY7ygC19WuQkzrKss7RtvhhbGNHOuugTCU7wmstWntNx8bqbdiRwbkOljxRQN4qmaHeRQUVGzCKJALmhPxiGDibsS/AasK6JvUgomAQrgKWwYU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6020.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?l3YOA1FWR4LPdfXH5QCObAt0Tg1jCNIP8+ss/J9DqHzjKr0d6s81Dwe7U+5F?=
 =?us-ascii?Q?yLGR/Y995A3tj66XJLrpNRylyOJZ6Q2iYL6dXtzh38Tvs4Qm2C5Yn5BMzDk9?=
 =?us-ascii?Q?U2tSeOwyp4v1bF4HqNlwGe4uIvh3YAl4Iv6DZ8ovDvWQaAP50nyZOTbJtYmS?=
 =?us-ascii?Q?JmN0UNx7GYVElV9XSvMrIUDJLEZw+A40PygBqZfQxzoFk3GW/UdtiL/SqzDL?=
 =?us-ascii?Q?7F2B2nU9giJOlRodOXFT/gcgvlU+VJcd+q8I6fkjR1EBKxNPY6YC+cDigfgy?=
 =?us-ascii?Q?78uLO6YutldFW2x+Cg0RnM3r/MNx6HphRnJmnut1VSQOU+HSPfcQNtWVcLqt?=
 =?us-ascii?Q?WZjp0qN/38i1rZwvrc67ctQh8e4ZTNiX+pCLUVwau+HMigvuDWkUS9zzCoeI?=
 =?us-ascii?Q?88D6wY/rpeLV7OFmdG21qQki/FaYQ/3s1ClyXXxLzhOUq+Xyf9/Mv1FpyDz1?=
 =?us-ascii?Q?Oaaev3mNOdJFr5gmVBJSsvna0RPcaScAfvYATqNJoTYLJ5a6Mi0L81WUTZru?=
 =?us-ascii?Q?nVmQWyMAObhAEFppxJtUenz80uBR2QKhYtluybglyT4Ab6+MLuPyjp88dPJ+?=
 =?us-ascii?Q?RCOQE+m4WvBrIqgDsbot0ctyfG5Ts8hXLf3+RKeMOeMsOPRxZ1btNY7OMtV2?=
 =?us-ascii?Q?JLTw5uqW7U2/oS/vF3Hgz+6Tqr5ojX8cG3Ra750/LdEcXwibaJOuPDgTLUlN?=
 =?us-ascii?Q?VW1s4ZpETl7HkafTGgI3B+HK+Xguo4rKj4ecXxn9RT9e8AJ7Yh5KIXniTk1i?=
 =?us-ascii?Q?eAk1ahQNNqP7Xr007WvsPit5jmHslT7BM2AYULUMeZ/3+/sa/QSZ5fmZAUTd?=
 =?us-ascii?Q?gFm3GJEa6u8hyOZz3DWEx2t5J/xZG6FBPxfKg7KRAtBkHkpc7F8agGBAofWF?=
 =?us-ascii?Q?gicsuMxILW3e96oGzShfMadGmDTmvOFSPghAcPiMCEODSJoHNIz/DrVtyxFH?=
 =?us-ascii?Q?46UvIB1HIYl/UTpdsGrxuagcp+7WOIq7u9Y3xPclQEZ8+neXp+A0QLJKG04r?=
 =?us-ascii?Q?G259QM1RH42Cj0Lgwt6ea3dFOI3/fVTjucUklpQJ+N/gY9I01XEQSQJKPhoj?=
 =?us-ascii?Q?4fLxDfzqfYOxQImEpPM00LL9xcl+PRzOeamk004voFn9vwFN95ufipDETSwU?=
 =?us-ascii?Q?JLoU9tG6PQI62KyO0LqbuQdCDYuYBW8moPs1Kt3p64TCEYzS6e/sYXuKztXT?=
 =?us-ascii?Q?KqFj3sn4TitaCvo6at9TW/wWgfqb4ljUAz6QxfCXsiDJ0GtqFPxmMGFCnA1N?=
 =?us-ascii?Q?9hfw243+zlNkXkbqN0OxmBrzkTRfTlgtoyKVEZk5eqLjTD7bWYztFdLtNekd?=
 =?us-ascii?Q?51VvMiUjgUdlV7TYw+ld+/VBGk+2TDZEzktsyk8br3aMBLFWxCm3iHah+dkj?=
 =?us-ascii?Q?UH/eD5f61J7R55i9yLgtpmvF23QubeNKmiQaa6bRLwsQwrmsfOSJN/j3EF2B?=
 =?us-ascii?Q?+l25j92evlYFe835VbyUEN9k1FJqMVSBnpFd3h5bHqBjnKgRZPQz3p40+KCo?=
 =?us-ascii?Q?UZlUf1rkhUCEYZC+fg6Ym0+JeF+qI0j6BxUem1RQURMUjs64AvGJOg9wUb79?=
 =?us-ascii?Q?m4/GdH8pmJqrz7O0vy1w4+jIb75vnlK4QaYc9ro0?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6020.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1c3e526-1d83-48e3-787e-08dc44b8877a
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2024 06:24:11.7091
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IPiWdCoSuhCgshJ+uY60LQfZ3uOiqvmgXNifBHSwiZ8pUEu/wUeNA53u0SJg3MyaVeqeJcTC76PzPST+RlH7Nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7117
X-OriginatorOrg: intel.com

Hi, Nathan

Sorry for the incomplete commit message.=20

I have tried to compile with gcc and clang-{11,13,14} on Debian 12.  On my =
test environment, hypervisor emulates a range of bad memory where writes ar=
e ignored and reads always returns all ones.
Memtest compiled with all clang-{11,13,14} can't find the bad memory withou=
t this patch. But gcc works fine. So it seems not a regression in clang.
I don't have expertise in compilers. But I think {READ,WRITE}_ONCE can forc=
e the compiler to treat the iterating pointer as volatile.

Welcome more comments !=20

BR
Qiang

-----Original Message-----
From: Nathan Chancellor <nathan@kernel.org>=20
Sent: Thursday, March 14, 2024 1:22 AM
To: Zhang, Qiang4 <qiang4.zhang@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>; Nick Desaulniers <ndesaulnie=
rs@google.com>; Bill Wendling <morbo@google.com>; Justin Stitt <justinstitt=
@google.com>; linux-mm@kvack.org; linux-kernel@vger.kernel.org; llvm@lists.=
linux.dev; Stable@vger.kernel.org
Subject: Re: [PATCH] memtest: use {READ,WRITE}_ONCE in memory scanning

On Tue, Mar 12, 2024 at 04:04:23PM +0800, Qiang Zhang wrote:
> memtest failed to find bad memory when compiled with clang. So use=20
> {WRITE,READ}_ONCE  to access memory to avoid compiler over optimization.

This commit message is severely lacking in details in my opinion, especiall=
y for a patch marked for stable. Did a kernel or LLVM change cause this (i.=
e., has this always been an issue or is it a recent regression)? What is th=
e transformation that LLVM does to break the test and why is using READ_ONC=
E() or WRITE_ONCE() sufficient to resolve it?

> Cc: <Stable@vger.kernel.org>
> Signed-off-by: Qiang Zhang <qiang4.zhang@intel.com>
> ---
>  mm/memtest.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/mm/memtest.c b/mm/memtest.c index=20
> 32f3e9dda837..c2c609c39119 100644
> --- a/mm/memtest.c
> +++ b/mm/memtest.c
> @@ -51,10 +51,10 @@ static void __init memtest(u64 pattern, phys_addr_t s=
tart_phys, phys_addr_t size
>  	last_bad =3D 0;
> =20
>  	for (p =3D start; p < end; p++)
> -		*p =3D pattern;
> +		WRITE_ONCE(*p, pattern);
> =20
>  	for (p =3D start; p < end; p++, start_phys_aligned +=3D incr) {
> -		if (*p =3D=3D pattern)
> +		if (READ_ONCE(*p) =3D=3D pattern)
>  			continue;
>  		if (start_phys_aligned =3D=3D last_bad + incr) {
>  			last_bad +=3D incr;
> --
> 2.39.2
>=20

