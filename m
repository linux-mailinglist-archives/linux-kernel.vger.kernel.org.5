Return-Path: <linux-kernel+bounces-116529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E01B88A06D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:54:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE31B1F398C3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 136FF7580B;
	Mon, 25 Mar 2024 07:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="FX7aTEzf"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12olkn2081.outbound.protection.outlook.com [40.92.23.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E075A184314
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 04:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.23.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711342658; cv=fail; b=MeoRigq7ymAgGOyJbdPRfs5qXcsjC2lB2an4dxQpL22fs1+pNl1NlUWCL9GlUZU6MFe2zu3GH+pnR2hplm/tqSgodPMOCpr+bf2mzzjUwtHIVZVjYlP/FPHAC8HmjHLnb0MxQ/PAzFqNmLmX7EadS/Jw7HpqLUYupYUEr3FY4rU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711342658; c=relaxed/simple;
	bh=1k3wVFtz29d0fWU4fH80BM/8+ONfj3slbQZhXoGpUts=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OMo1aB7Qsah5zYTKlconF5hA2uwQpGV9YDjQXucsUoH9XPQtdevLGECvJ4u2P4KzQQLmGK7O5oZrWOBidl+yCPrFFoiZ3yS5ISYUqGQ8sMoeOjF6gsGgVLkrmWFrUgJ+fKVIhHvb3cxyE/jE+qkLHMWXo0IijYGZXw+KHuOxbZ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=FX7aTEzf; arc=fail smtp.client-ip=40.92.23.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J1ExpinpKsQf1HjbykRaahg9GUE/6yH+rWyWmfHJceC2vtINGabHIQgBaJ5AYm99bKwGbs6WkBfVv/LiF3xVxBy6hd8SbylvK2xzL3MSzkUeeeJ5NIF0edz1qPzWagJXAR88/gBPPo7c4MW1HYEh/BT2pFVgJmWshGBmOCbNtoLP8YKljAmPCOLAyZ1EN+oykY7eVfhl7pUnvYZPQolIGxcn7oIO7XsfGHGxUZ3AcfIfpQtbjY4z86smCmhkZxqYK/NYuv4iiw4EUmdW0JG8e/kgNNoRcoqV3hHTX63srqT6PI/j7TVE2oljuUPAfag53CeDUtQ76BTnxPRTC3ecOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LcAQiQgGT6ica+l+OkEkLmid0en38ZhYoGtvmnd3Yio=;
 b=VauJvt8cNUa324kuU5+vACnBLcJYpSViFVBweDVcQx8NoUecU6cYjcmDolVIFsybXh7GxTeTXfcwVEdtwh3dUtp9GS0wCXgJWpeURDVU2/fziB4gWfkZIWl59DfhoyHF1tLAx4jvNsNZDfwth3bbX/GRASE1KGVmKnOgZ58H3BNrvq3jz1oDl+0n7IcTo9HJHF1GhYQh0JCeIIiiEXzjI2lvktRbbYg4WGwWkTaqdDxnBxsybGXCz5vCIaaNYJ7UEnzSqIoaVNaexKi8F7cWLGFW/qIolEwoPmQ0HX1UhQbvkCp6b7hDNR1nWLBIwyTWTWwTwLZhfNZpiHlSzPaTfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LcAQiQgGT6ica+l+OkEkLmid0en38ZhYoGtvmnd3Yio=;
 b=FX7aTEzfzkIsJ5QrapqVkKZweFbhurpubPAKKwEBe1zAnni0PegsleWrmoR2ygzdHkgbjb2YQ3h/6XMU6sSb11/bvLf115Rdr7DDFpBCq0bYaj/JcrKJoe9lJaIRKj9sDZz3MHdveV4R/Kko+ak75XObNImoBs0GYmK8D4uGRGEwcBI56pkvJ/vLLjnFbLDog3HEr3MFQGeiB427jnu1G27Ii4BLBgPljLDxSwgzjjYy6cEWZ47un10DkGg3TpSWRr3Cnd32Ro/nKezSyCHNxon88uNJLQ+Kfz6hy6KsbH0kz/fHrSbn9/S9F/4R91srv72RsS58htAk/EaAjTSDDA==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by PH0PR02MB7301.namprd02.prod.outlook.com (2603:10b6:510:1b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Mon, 25 Mar
 2024 04:57:34 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::1276:e87b:ae1:a596]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::1276:e87b:ae1:a596%5]) with mapi id 15.20.7409.028; Mon, 25 Mar 2024
 04:57:34 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Xi Ruoyao <xry111@xry111.site>, Dave Hansen <dave.hansen@linux.intel.com>
CC: Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>,
	"x86@kernel.org" <x86@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Dexuan Cui <decui@microsoft.com>
Subject: RE: [PATCH v2] x86/mm: Don't disable INVLPG if "incomplete Global
 INVLPG flushes" is fixed by microcode
Thread-Topic: [PATCH v2] x86/mm: Don't disable INVLPG if "incomplete Global
 INVLPG flushes" is fixed by microcode
Thread-Index: AQHafh5br9v5ziibjkOOzawG3mO/srFH4YWA
Date: Mon, 25 Mar 2024 04:57:33 +0000
Message-ID:
 <SN6PR02MB41576028614CB7FE9A11EBEBD4362@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20240324190503.116160-1-xry111@xry111.site>
In-Reply-To: <20240324190503.116160-1-xry111@xry111.site>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [f9i3nEO713lBcX6mekaaLDOcsTNH6wwx]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|PH0PR02MB7301:EE_
x-ms-office365-filtering-correlation-id: 722fa4a4-5f39-4f44-1fad-08dc4c88156f
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 ODZKuFZlxcNJkbPJLsl7zoIQ2s72TbVVEM9r9bqMb6tIxYflO/LPqbocWqQLL5olKmmBf40n982hTVb7DQfINgrMBVJHzG/wcdoZUMT8Wr56mv33+zY6Ez48xxs/w+VNctjZ1kW9U5oxi6kbFlKCx1YUuUKmJhCrLfAgqxDmkmA/ofL27QJWEZ5R88ZZqAHdMcQO5DuqaDb6HffoVmeZYljCFEs9GovIUI8Laz2kuP6EgM2yWkFpaQ7YsxqH1jaradjd4I2ays8IbG2OssklL67rNS6HxXcXiJG1LPCGhEQJvUJiNGKFCLZIvvO0R8s/IYzxXtMauNJxzySlwUb3+Dc7QJ8OdqeFWsrCI+W/dlyT+/mFGzw185xL+eF8BGDREapP+T3F0nIDNH32tRPouRtvnZB2nsOTktHBb3w2ba+Y3RmxuMAndoDYV4taGOCiWk/invvu3XAP1Fo0WMlzRf0ZMsKXau4fHaytPr8K60OR2i7H8z5vxy2IMMez0fMKwcz5M/UH8PT3oM4GGAFqT5oHQnQRWK9OX9RRudZmw+7AmUNCwikadJ3ze/QdFDNW
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?3Qf6+0DWtLWbLIQBEqJrJWXeilJECvT4HRA7gEyDkhiFIos8zVtjcw2Kfk5k?=
 =?us-ascii?Q?JH6sVwez0INUO2rbL739OfVIjZQnhazL0YOo14qKIo0bDrRJfG6UuKoLhlJv?=
 =?us-ascii?Q?v0soYDD7d8xxoaBNCKi7AeXaXf7ZbR/zY9iHsdwvwNJ6/J3sm4cCDwO2Z0z7?=
 =?us-ascii?Q?GsokiujFZxCi1ubJJv0rKO1dRg2OqDKD52zGu3afvEmw8Um/i/XuFMsp5liG?=
 =?us-ascii?Q?VEh3aZf1mHLfnJjWHqFn2pvZDwK1KVOoWIeEK0HbD8kr5/IzjcBSBz5ns1AT?=
 =?us-ascii?Q?lnrtubyVqHv+AeJWZTPAur67acDbftwkqeot17/SiaOrJlnlKjMv3vKeVlm3?=
 =?us-ascii?Q?L3mxRN7JLrA+sh8gSt9Kf46EV2NghG6qsX7paIpu3pClLu3kEPWGQogHevxl?=
 =?us-ascii?Q?y+Oo3P4QM+wvXCNGuNfASk5eHih3wBho0pZXrhehUZUVz/LweaG7S3kjSLWJ?=
 =?us-ascii?Q?MduhPlMmd7P/LSLMXut8ATRtxzzNVOKEeg9SNfhMAIfNYTdH5aGFi5LUOwRh?=
 =?us-ascii?Q?5/aOsNXp6LdEDve5hjt61GKZWkNky03Uwu+Fh8ZRuq4/m7SF26O4NPpQYVDK?=
 =?us-ascii?Q?jVY1phGxGKWLlKV7wjbiiYHtzS6ptAlCVeOn3MaSmvnJTMhYn3Us4mFmZX7R?=
 =?us-ascii?Q?q1pBlQ16UHJM/+8hotiVqfiQ3DFA4yehWtvYiDd+nnHce9X74jRk0nyb1/tv?=
 =?us-ascii?Q?w8gMvLZi0d/DobaIYYjeOoJF68z4EjKExvJ58BoJiNWo70Jf9w79AnORy7Gl?=
 =?us-ascii?Q?UGp+sr0fQOv0YpaO0dT/YgwwEFD3EhSnw/FS/U33a+N6CC2vZ06Ro+1RvBfn?=
 =?us-ascii?Q?S7gFnmKZYACbu2+4UsIVGWxJkOym68n6vVYh+L0C3oOHsslFOkUDakDyj1IG?=
 =?us-ascii?Q?JeahU8yvZk5o74+SNFD+ntDvR+kGJbfxqCHOJ+3jLzSDtyL9itQEkaQYLPh/?=
 =?us-ascii?Q?a3gPBPgbpLW/kGs0oRy7uMxdXbLw80mPBrYKigKrO9cxXxwHVjCYDBTFKip4?=
 =?us-ascii?Q?rybd1et57PxW9M5PwikAwjB71vllhNwKuDvb36tWq6hoqYYappTMr+ZX3GV9?=
 =?us-ascii?Q?IxNulrpONePRM+Ghg1go7lsn1R5s99GmO3jTLcTLgRevHUI8KK+9KO5pqvCZ?=
 =?us-ascii?Q?6/OO6LPVqd3PFsYbECJ63312xgfz6R+qW4Xj7LvVz35pTa1PSfchbH61VWyg?=
 =?us-ascii?Q?XiJd3ZzZzC+DSUc4RE4LfsebWqpZPrJ9Ne3aaw=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 722fa4a4-5f39-4f44-1fad-08dc4c88156f
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2024 04:57:33.8268
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7301

From: Xi Ruoyao <xry111@xry111.site> Sent: Sunday, March 24, 2024 12:05 PM
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
>  arch/x86/mm/init.c | 32 ++++++++++++++++++++------------
>  1 file changed, 20 insertions(+), 12 deletions(-)
>=20
> diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
> index 679893ea5e68..c52be4e66e44 100644
> --- a/arch/x86/mm/init.c
> +++ b/arch/x86/mm/init.c
> @@ -261,33 +261,41 @@ static void __init probe_page_size_mask(void)
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
> +	if (invlpg_miss_match &&
> +	    invlpg_miss_match->driver_data > boot_cpu_data.microcode) {
>  		pr_info("Incomplete global flushes, disabling PCID");
>  		setup_clear_cpu_cap(X86_FEATURE_PCID);
>  		return;

As noted in similar places where microcode versions are
checked, hypervisors often lie to guests about microcode versions.
For example, see comments in bad_spectre_microcode().  I
know Hyper-V guests always see the microcode version as
0xFFFFFFFF (max u32 value).  So in a Hyper-V guest the above
code will always leave PCID enabled.

Maybe the above should have a check for running on a
hypervisor and always disable PCID without checking the
microcode version.  That's the safe approach, though there are
other similar cases like bad_spectre_microcode() that take
the unsafe approach when running as a guest.  I don't know
what's best here .....

Michael

