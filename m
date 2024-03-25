Return-Path: <linux-kernel+bounces-118103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 135DE88B405
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 23:28:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F2791C3FBD0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 22:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35A9E811FF;
	Mon, 25 Mar 2024 22:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="C+2KUOGg"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12olkn2065.outbound.protection.outlook.com [40.92.21.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E21839E7
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 22:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.21.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711405662; cv=fail; b=KKROGFR117JJxYEtD+h6TyHhxwfA3TpT6A8T3NgC/CMtLeHfUUii7xuNSnA2YkMyWIfLaI918ad80HfTRjajgtE1iHydiZ8vKMqtVGju6b0mZu1IsA7Vq/Lz8JhZhURa3F7kTbPLAAs0PhCHVDfefSF/sX9cKtl0Gg67JqAWhD0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711405662; c=relaxed/simple;
	bh=hibP0OhKNOHLEwnCp9cYZS8tVHfEKGtes0S/u2sLqH0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kx5b2rTCesFhphCNJR2ZYhMOuloPK1I/MX7pcMrg7sCMjipi2L5YW6Mgzzhe5HeRAUeaqz/Y4K5NzCtoeVTvl36flg/J3Vrc4cuw3LKgm5HaL4wlTRRteTorrwWo+cwywaYGjKhIAMg9RmazUPXa4oxL6myMaVV9kJXMnYbDND4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=C+2KUOGg; arc=fail smtp.client-ip=40.92.21.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MBNBQ9A7CoubCC2eU7aLUzm8KYo4sPjKu51mxFb8tylmZ54WOdOWs2psI2zEwg4dYMv9h93MpVuAxArcp4rVCnJg2GDOs6ZSUvbCA8BioJ9mEnuFPjo0z8lKkAE1X6EYR7VQI4GnZjr/9BvCFc2aJVcizLv+u/gzGX4WfZdCKwGb8wfD4pJCfwJB5zmJU4VXh0qWwE+GhiGw+uEsL3uNrOTJTNVmqAcLrSuroxG18VTIumgB134qC7XxyRue73ad9yP5x06D3uvmAAkutlOT295RoKwTW3jS3uYZ9/TdD0Jybgn9m02umxeqGMIYzUlLcEIn2cd/Aqgbf8hHRnDuYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wAdAfsRGmJPlIWoczI02TsvI1DYvEMapRse2xhCRzGo=;
 b=MPNkBmGLYvmHXVk+takj9Uj8GrnuO56yZ427kL9NgmgwdaSRswIqxJQL+Zk0ZTQpbwCfpfthFaU4iIV4JFqWuQqvOSvIIifOWKTixQwzC5COVb30ERKRYM5YP8f6eZP/3TwiZdQXkbIlIEDWpPb35kNPhNBiau52SM79N2tM1v3tN2JzIXLgghrDeDw3F606sO4PRlBd9d7yNiS/P6bvJd/+5/+cOLxX0PTb3nJ8WuYDYVt0wT++13n0/tr71qtf/t1BqcxfzU9nCiHF7+6iY+TXxxJTo4c+fa6ETkOP50eOQyiYI1UqfubVsmk69DO0OFq89oT78uDkFo3egGjoQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wAdAfsRGmJPlIWoczI02TsvI1DYvEMapRse2xhCRzGo=;
 b=C+2KUOGg37GhBcvWTBpLv7wqZuLB7NIRNqTpPIRYX9jktAXvHbiblbSgUjf9TU7yDU8y/qvVFjJ8ACTI2KQSGAFq1DdHkK9HxM5MigFxrds8GgiBYIuOtYyleOEhtFcRmepzpdVC7G6Bi+EitCKpqChGVFzYi3VVGQVpo626WyUIXIbxJlyDflsh0zlXQQoYjU9tdD0dXszazcZ8R09O04UIk8KjwbaJwquHE9hbSAdRqL8Z4IMQQSbWteqCYpDwbcNUDIzVOYwSm28K4wv5GPVL/enxFzXExNvKyhVr1cmt8wP5lFNCDBFwheZL1jny+AXrZx05vktGzQMWvmg/pA==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by SA1PR02MB8557.namprd02.prod.outlook.com (2603:10b6:806:1f8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Mon, 25 Mar
 2024 22:27:37 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::1276:e87b:ae1:a596]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::1276:e87b:ae1:a596%5]) with mapi id 15.20.7409.028; Mon, 25 Mar 2024
 22:27:37 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Xi Ruoyao <xry111@xry111.site>, Dave Hansen <dave.hansen@linux.intel.com>
CC: Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>,
	"x86@kernel.org" <x86@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3] x86/mm: Don't disable INVLPG if "incomplete Global
 INVLPG flushes" is fixed by microcode
Thread-Topic: [PATCH v3] x86/mm: Don't disable INVLPG if "incomplete Global
 INVLPG flushes" is fixed by microcode
Thread-Index: AQHafvtoA+0/e6KloUSoqoP9U8FJHLFJBtDQ
Date: Mon, 25 Mar 2024 22:27:37 +0000
Message-ID:
 <SN6PR02MB4157C6837815BDB62EB9ED91D4362@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20240325212818.125053-1-xry111@xry111.site>
In-Reply-To: <20240325212818.125053-1-xry111@xry111.site>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [WZzX2ApVjAx3IF+OMonfKLqh1LQmXTJi]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|SA1PR02MB8557:EE_
x-ms-office365-filtering-correlation-id: 0749a7fd-db1a-4745-5a1f-08dc4d1ac65b
x-ms-exchange-slblob-mailprops:
 WaIXnCbdHrNLYEJ5HghreUmTctoVX046w9EfOeOTF0wdNOjo7vac7MMs7IE8VGBUlx7U2IUxJhMoV+SmLFa/jgkBXkUOJB5gYNXyZoPl0BFIrT4I3OOioc7peHFS5GrICoCTRoD1/ekM+IDHyRw0sPZ0bB+pmoepX3l0SsU7cjGUncGJ0jfnLEVEIr8vr7SKwBy5XnOaNXqQkHRTRh5K06WmnWEkkRXRaxIhmRb3fohwo1pJdZZ1rjTe8ua7ZU5yyiM2ecUWqabqWkyzoYKfJelXAyR0hGQhgKIOPcwkj3dEdur1/Q8V2Rjh4d2kEnZvjRoEXzKXv1XDlIUaR6dxiHkJbPejHSFbDXoMN5UOoJLfSvMgqp+O6wapx0tP/WK+rwHxpDfdSNOomIbhbAjWzWV+6bTBwsHOHY52GUkx78UdNcm8aiIBjEb7Py9dpV7+qFlvuGfBpcNfbmGsvOomtiCiX1cTYQ5rsFEnzyyIWskSk/yxwS1nfhw3ybjUg4R19ItAqssfgu7hL/iBZLY5hSydyg/755N4pik6xRMFi0Z/AZWsHS/22gkuGHeKMGz7TXNwoqMn1oLaXwEIYgb5IcFK8s4lJGqYZnNZD0VzPReVLMkAbvBscCrZW02SsN+XoZEBj8TLFgpouhKpUBwl8rYAWbHWcrXyTRnTtqZY/Qz9bzO9emBGCT8eznmRICo9R5L0x0jyscntRX7jD6+Nh5U6KSUbC2IvKfJ3oPJzjFGb42PxrbfA0j2htT4DOf+tBhzgZDbPxNs=
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 JNo0iCgeDxkkaiG30dpDLU3JFBI0rt2YEqxWpmjJrsK9LqTmkMnSqs0uG8koMFZIxXA/uLDGaiaRzunr4JGdAFIDCD8+V3rSaQlaVKin/GNoOmOIPycXmdoxkL3xijg7+whK622U/EPzppPqSbD7nQJtFvsOiTsrvvgwEW24lH/SIkN7kjmyrtWmpb++uIsNGYYG42+5Rno1vdkBn+7ZXrjEJDytBiM7pIc4CAuqZq0jYofh8Ad5aajpuv4ehn1i7Gh6BvdRKDuaUOo58Wd/RPMN9g8I0xLk67fD5J66gJhm5TV3jCi469z6euRcAw4NmTY3AqhABgvryo31FY5zGCajQQiyD6a2Xnz3S+YPVjFiQ2g+zqc3aIiSFiiorvsFdFToQzb0y6QPu4frxLv/ZoBUZOqYaKaiLtagiqu+XGIIzsQ+1mjNF2nQuwaAHkVAzpQDPCnQNmd2EpyaXj0bClcirHYgK9+IP3qM9ayIjen0aMukIbFYlkbSEzqsXNmruXHTV+D8TGRHpYPMU7pmnz/9IxLQWWqDfV4ZHQ6K735K+DGHo1JLaYgexUOhgVMc
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?re6VW2oz+luO9/VcmuAuch3KmNrcWieTGi2zNnqVv+AuK3g9jUNRWfb/Algy?=
 =?us-ascii?Q?s4jJdExPU2YgM/ORWFm5KHJMLUdf6GDDsyIBR+0g/tJsryfLxEIsP8CEUJxH?=
 =?us-ascii?Q?+FO6+jxRtAsCeufPzMTtyqgY1BkBgScCs86HDh0cnXqt0xefxNZSTY+LlVT4?=
 =?us-ascii?Q?cw9FAEQtWT7jE0wR6DBGCj8pv9mECEUcTYvNSo4jM+Rq8e19NUvTJewNPCR7?=
 =?us-ascii?Q?IhELyzY8N9CcxjHd0f3gfxS/TJuUErdnWdwxams8X9hI3iwdgFanFyxnfUHC?=
 =?us-ascii?Q?pefK+hQ6JZVyoChqgcIMd3rrU3QON0wYaRCq7fjmM8Tp7vaEi0+W2vwjoix/?=
 =?us-ascii?Q?XXLmBiCi7xGKk6R1Ly0UAifuMnsLgODJ8LQ3f3gzLxOizq0xo2A+dgePCi63?=
 =?us-ascii?Q?15neXP26w8w5Mrpyiznc3dAZPnOQ46ZW8sGMZkbfOlouVkXGBY2DgSmdzUZQ?=
 =?us-ascii?Q?Cg4TasOH3nlCU1ssJ2V2P+W1lA9nUW1N1eFFXvTrugR9dBmKeS2yGbKUpCSH?=
 =?us-ascii?Q?K79rZFvvZnK5bqyh0l/dd6xOZXUaoc0vS1mvbFuUt/YT9tPxIVI2/3Wjfxmx?=
 =?us-ascii?Q?pWUlP5fTkK/Ijh7ImOscl4hc22AOdOc0op0MqYNmF7T63/gqemktpUsVrmvt?=
 =?us-ascii?Q?/zefz5GHuXkmKX5q69MgDJOKJTWavhUJ6aBYJJUTJu63UzYQX0Rzd+byP2Hw?=
 =?us-ascii?Q?7pKrEF0BIo5tkkU9fp5b5gCHx32kby/QEqD2VFSC3AFdH/zS0dZjYqXgjz9k?=
 =?us-ascii?Q?gnGAwmXfuPER9y8VE2hJNw5+lKtR1/G7cBwWGy89rxSsfu3cyYCQ8vbtytXA?=
 =?us-ascii?Q?xZam0AxAwdfxaIOScZfCkKM30//K5sdycI0ValfFRRAF8lMmgjh2DoSA63QG?=
 =?us-ascii?Q?hUrPQ1dUvFdORdCdNXlSoanSTd62+hRLoRhFQCBXBzMyT7ZHLFQA0kUe6Wik?=
 =?us-ascii?Q?l/asxRjE62W3BDjJ/cFGf6+l9Za+Gov5gLE0GXXerWjLIfCXsa33Thso5TZJ?=
 =?us-ascii?Q?1rLaMqvAvg/ub29PLiQiZyIbB3fKA88iRy1IcF0ETQfOkVb+t2SpRud5crY6?=
 =?us-ascii?Q?RH/HjuyNk0uGSWNW00WpLtwQLvKC3WEYwn/PZFId/zwwCy0O5lSi1zpIWaNU?=
 =?us-ascii?Q?XM0eX53YpbyRoJAj/aGDdaoQ6oSN61ZhFp4b1sl+wB+27Y5BvbbkqBHdMXnf?=
 =?us-ascii?Q?Gvqv3sMgrK7txB0E6xgOcAGX+IAlCQFqDZ5FEg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4157.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 0749a7fd-db1a-4745-5a1f-08dc4d1ac65b
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2024 22:27:37.1631
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR02MB8557

From: Xi Ruoyao <xry111@xry111.site> Sent: Monday, March 25, 2024 2:28 PM
>=20
> Per the "Processor Specification Update" documentations referred by the
> intel-microcode-20240312 release note, this microcode release has fixed
> the issue for all affected models.
>=20
> So don't disable INVLPG if the microcode is new enough.
>=20
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Signed-off-by: Xi Ruoyao <xry111@xry111.site>
> ---
>  arch/x86/mm/init.c | 37 +++++++++++++++++++++++++------------
>  1 file changed, 25 insertions(+), 12 deletions(-)
>=20
> diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
> index 679893ea5e68..1a7d6a61a4cb 100644
> --- a/arch/x86/mm/init.c
> +++ b/arch/x86/mm/init.c
> @@ -261,33 +261,46 @@ static void __init probe_page_size_mask(void)
>  	}
>  }
>=20
> -#define INTEL_MATCH(_model) { .vendor  =3D X86_VENDOR_INTEL,	\
> -			      .family  =3D 6,			\
> -			      .model =3D _model,			\
> -			    }
> +#define INTEL_MATCH(_model, _fixed_microcode)	\
> +    { .vendor		=3D X86_VENDOR_INTEL,	\
> +      .family		=3D 6,			\
> +      .model		=3D _model,		\
> +      .driver_data	=3D _fixed_microcode,	\
> +    }
> +
>  /*
>   * INVLPG may not properly flush Global entries
> - * on these CPUs when PCIDs are enabled.
> + * on these CPUs when PCIDs are enabled and the
> + * microcode is not updated to fix the issue.
>   */
>  static const struct x86_cpu_id invlpg_miss_ids[] =3D {
> -	INTEL_MATCH(INTEL_FAM6_ALDERLAKE   ),
> -	INTEL_MATCH(INTEL_FAM6_ALDERLAKE_L ),
> -	INTEL_MATCH(INTEL_FAM6_ATOM_GRACEMONT ),
> -	INTEL_MATCH(INTEL_FAM6_RAPTORLAKE  ),
> -	INTEL_MATCH(INTEL_FAM6_RAPTORLAKE_P),
> -	INTEL_MATCH(INTEL_FAM6_RAPTORLAKE_S),
> +	INTEL_MATCH(INTEL_FAM6_ALDERLAKE,	0x34),
> +	INTEL_MATCH(INTEL_FAM6_ALDERLAKE_L,	0x432),
> +	INTEL_MATCH(INTEL_FAM6_ATOM_GRACEMONT,	0x15),
> +	INTEL_MATCH(INTEL_FAM6_RAPTORLAKE,	0x122),
> +	INTEL_MATCH(INTEL_FAM6_RAPTORLAKE_P,	0x4121),
> +	INTEL_MATCH(INTEL_FAM6_RAPTORLAKE_S,	0x34),
>  	{}
>  };
>=20
>  static void setup_pcid(void)
>  {
> +	const struct x86_cpu_id *invlpg_miss_match;
> +
>  	if (!IS_ENABLED(CONFIG_X86_64))
>  		return;
>=20
>  	if (!boot_cpu_has(X86_FEATURE_PCID))
>  		return;
>=20
> -	if (x86_match_cpu(invlpg_miss_ids)) {
> +	invlpg_miss_match =3D x86_match_cpu(invlpg_miss_ids);
> +
> +	/* The hypervisor may lie about the microcode revision, conservatively
> +	 * consider the microcode not updated.
> +	 */

Nit:  Except in the "net" subtree, the proper format for multi-line comment=
s
is this:

	/*
	 * The hypervisor may lie about the microcode revision, conservatively
	 * consider the microcode not updated.
	 */

> +	if (invlpg_miss_match &&
> +	    (boot_cpu_has (X86_FEATURE_HYPERVISOR) ||
> +	     invlpg_miss_match->driver_data > boot_cpu_data.microcode)) {
>  		pr_info("Incomplete global flushes, disabling PCID");
>  		setup_clear_cpu_cap(X86_FEATURE_PCID);
>  		return;

Modulo the nit above,

Reviewed-by: Michael Kelley <mhklinux@outlook.com>

I'm good with this. Losing PCID has definite performance impact,
but I lean toward being conservative when we can't verify the
microcode version.

I'd also be interested in other perspectives.  :-)

Michael

