Return-Path: <linux-kernel+bounces-44169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F4F6841E83
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 09:57:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5017B2D15F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 08:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BDE260EEE;
	Tue, 30 Jan 2024 08:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Qi93fdeJ"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21F8460ED2
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 08:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706604264; cv=none; b=rsZWLcBxhFqkx0OeEIMq37xBTSqHFspQBOuJG1BAMVAXsWvM+Z2+AovDKz6O1ZRI2sUCnqU7ID1QTu0+3gANGRzhUyVp281JVJNmY8MB1neUM6ay1FIg9pj3HOcgK+dyobJ7ttIAhDP8EKwXxOjHE4cmlH/yhHn9DUi7VvOjAbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706604264; c=relaxed/simple;
	bh=bYXuSCoKukzXJsZktTDDVdGFGywE4T8aErnrwaizOJw=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZITw4PU9VaIoNhC04vMGv+C159D0tnHflN48zj/7wuGVyTsez/yXjUeOt0cnuBf+sPsY6Jqh74AKcB6O4iNh3XhpumHVBNgHbl+5Wnkq9N2yem/V+Mevn3XPFwq2QbEqOv040W2vS9/XMicalivjRx/gGrgWf35f5QAah9KoJ7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Qi93fdeJ; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1706604262; x=1738140262;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bYXuSCoKukzXJsZktTDDVdGFGywE4T8aErnrwaizOJw=;
  b=Qi93fdeJYlv85P9PlGnZPH6gk7HXCUUPS46tKWF9Tc/vySv4BviEcimz
   w0Gj8PHiguO47/kFI7F2iPRaqSeijp/XxEy/mX3BxAi0YP8jga2JvQFvt
   z/2PfIRQzqgPYYNnQftZanwQOCXuo1zSg97xqhbMrUVTGJSAuhUO6k1WF
   oqWzL/xppywdaiTfYf6dYBE2XYqwAM0cqzO7AfmOMTlQOQiWDwVhFbGZG
   QOMTESRzFXRZ3dlqnoGRTzEqhpjXb1uLqpbHRrrAsCF1ek+OBE6Enwq1A
   CRUX2mBAc9g4+ExNzrtr/rrmxYqOBWuII+STzsFSyN9xCWGPyY0Wz26zl
   Q==;
X-CSE-ConnectionGUID: oX+nB/PuTbmJKFZjlYO7pA==
X-CSE-MsgGUID: GseA+0pkQU2Yu8MOQhQc9w==
X-IronPort-AV: E=Sophos;i="6.05,707,1701154800"; 
   d="asc'?scan'208";a="15987627"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Jan 2024 01:44:20 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 30 Jan 2024 01:43:59 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex01.mchp-main.com (10.10.85.143)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Tue, 30 Jan 2024 01:43:58 -0700
Date: Tue, 30 Jan 2024 08:43:20 +0000
From: Conor Dooley <conor.dooley@microchip.com>
To: JeeHeng Sia <jeeheng.sia@starfivetech.com>
CC: Conor Dooley <conor@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-riscv@lists.infradead.org"
	<linux-riscv@lists.infradead.org>, "paul.walmsley@sifive.com"
	<paul.walmsley@sifive.com>, "palmer@dabbelt.com" <palmer@dabbelt.com>,
	"aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>, "sudeep.holla@arm.com"
	<sudeep.holla@arm.com>, "robh@kernel.org" <robh@kernel.org>,
	"suagrfillet@gmail.com" <suagrfillet@gmail.com>
Subject: Re: [RFC v1 2/2] riscv: cacheinfo: Refactor populate_cache_leaves()
Message-ID: <20240130-tinker-speculate-89e694c5f559@wendy>
References: <20240129075957.116033-1-jeeheng.sia@starfivetech.com>
 <20240129075957.116033-3-jeeheng.sia@starfivetech.com>
 <20240129-parrot-dropout-c4ece33a98da@spud>
 <BJSPR01MB05611B1A4DDB1F73FD9E0A829C7DA@BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="RjPP/Q2tX/ed6WHc"
Content-Disposition: inline
In-Reply-To: <BJSPR01MB05611B1A4DDB1F73FD9E0A829C7DA@BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn>

--RjPP/Q2tX/ed6WHc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 30, 2024 at 06:24:44AM +0000, JeeHeng Sia wrote:
> > From: Conor Dooley <conor@kernel.org>
> > Sent: Monday, January 29, 2024 8:31 PM
> > On Sun, Jan 28, 2024 at 11:59:57PM -0800, Sia Jee Heng wrote:
> > > Refactoring the cache population function to support both DT and
> > > ACPI-based platforms.
> > >
> > > Signed-off-by: Sia Jee Heng <jeeheng.sia@starfivetech.com>
> > > ---
> > >  arch/riscv/kernel/cacheinfo.c | 47 ++++++++++++++-------------------=
--
> > >  1 file changed, 19 insertions(+), 28 deletions(-)
> > >
> > > diff --git a/arch/riscv/kernel/cacheinfo.c b/arch/riscv/kernel/cachei=
nfo.c
> > > index 30a6878287ad..f10e26fb75b6 100644
> > > --- a/arch/riscv/kernel/cacheinfo.c
> > > +++ b/arch/riscv/kernel/cacheinfo.c
> > > @@ -74,36 +74,27 @@ int populate_cache_leaves(unsigned int cpu)
> > >  {
> > >  	struct cpu_cacheinfo *this_cpu_ci =3D get_cpu_cacheinfo(cpu);
> > >  	struct cacheinfo *this_leaf =3D this_cpu_ci->info_list;
> > > -	struct device_node *np =3D of_cpu_device_node_get(cpu);
> > > -	struct device_node *prev =3D NULL;
> > > -	int levels =3D 1, level =3D 1;
> > > -
> > > -	if (of_property_read_bool(np, "cache-size"))
> > > -		ci_leaf_init(this_leaf++, CACHE_TYPE_UNIFIED, level);
> > > -	if (of_property_read_bool(np, "i-cache-size"))
> > > -		ci_leaf_init(this_leaf++, CACHE_TYPE_INST, level);
> > > -	if (of_property_read_bool(np, "d-cache-size"))
> > > -		ci_leaf_init(this_leaf++, CACHE_TYPE_DATA, level);
> > > -
> > > -	prev =3D np;
> > > -	while ((np =3D of_find_next_cache_node(np))) {
> > > -		of_node_put(prev);
> > > -		prev =3D np;
> > > -		if (!of_device_is_compatible(np, "cache"))
> > > -			break;
> > > -		if (of_property_read_u32(np, "cache-level", &level))
> > > -			break;
> > > -		if (level <=3D levels)
> > > -			break;
> > > -		if (of_property_read_bool(np, "cache-size"))
> > > -			ci_leaf_init(this_leaf++, CACHE_TYPE_UNIFIED, level);
> > > -		if (of_property_read_bool(np, "i-cache-size"))
> > > -			ci_leaf_init(this_leaf++, CACHE_TYPE_INST, level);
> > > -		if (of_property_read_bool(np, "d-cache-size"))
> > > +	unsigned int level, idx;
> > > +
> > > +	for (idx =3D 0, level =3D 1; level <=3D this_cpu_ci->num_levels &&
> > > +	     idx < this_cpu_ci->num_leaves; idx++, level++) {
> > > +		/*
> > > +		 * Since the RISC-V architecture doesn't provide any register for =
detecting the
> > > +		 * Cache Level and Cache type, this assumes that:
> > > +		 * - There cannot be any split caches (data/instruction) above a u=
nified cache.
> > > +		 * - Data/instruction caches come in pairs.
> > > +		 * - Significant work is required elsewhere to fully support data/=
instruction-only
> > > +		 *   type caches.
> > > +		 * - The above assumptions are based on conventional system design=
 and known
> > > +		 *   examples.
> >=20
> > I don't think this comment matches what you are doing.
> >=20
> > For example, the comment only requires that split caches cannot be above
> > unified ones, but the code will always make a level 1 cache be split and
> > higher level caches unified.
> >=20
> > The place you took the comment about the split caches from does not
> > enforce the type of cache layout that you do where the 1st level is
> > always split and anything else is unified.
> Correct, I meant to say 1st level is always split and anything else is un=
ified.
> But, do we agree with the statement?

That the first level is always split and anything else is always unified?
No, but I think the assumption /in the comment/ is reasonable however.

This is your patch, you need to justify the changes you are making
here, not ask me if it is okay after I noticed that your comments and
code do not match.

> > populate_cache_leaves() only gets called in a fallback path when the
> > information has not already been configured by other means (and as you
> > probably noticed on things like arm64 it uses some other means to fill
> > in the data).
> >=20
> > Is there a reason why we would not just return -ENOENT for ACPI systems
> I don't think that we should return -ENOENT otherwise the cacheinfo
> framework would failed.

If you don't have a way to determine the cache layout, what makes
-ENOENT worse than making something up?

Why does your system not get information from its ACPI tables?

> > if this has not been populated earlier in boot and leave the DT code
> > here alone?

> This function is shared by both ACPI and DT.

I don't see how that answers my question.

Why should the DT systems stop trying to parse for the information?

Why must ACPI and DT do the same thing here?

Thanks,
Conor.

> > > +		 */
> > > +		if (level =3D=3D 1) {
> > >  			ci_leaf_init(this_leaf++, CACHE_TYPE_DATA, level);
> > > -		levels =3D level;
> > > +			ci_leaf_init(this_leaf++, CACHE_TYPE_INST, level);
> > > +		} else {
> > > +			ci_leaf_init(this_leaf++, CACHE_TYPE_UNIFIED, level);
> > > +		}
> > >  	}
> > > -	of_node_put(np);
> > >
> > >  	return 0;
> > >  }
> > > --
> > > 2.34.1
> > >
> > >
> > > _______________________________________________
> > > linux-riscv mailing list
> > > linux-riscv@lists.infradead.org
> > > http://lists.infradead.org/mailman/listinfo/linux-riscv

--RjPP/Q2tX/ed6WHc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZbi2owAKCRB4tDGHoIJi
0lO2AQD0A3/H7hh5AG3sDLHfZ9gkTS0mjtoKVg57zYoHoM3nOAD+KK+eRU9gg16t
GkduSQZiXWd2+tOyFY7jz75qEMTTvAY=
=qfNW
-----END PGP SIGNATURE-----

--RjPP/Q2tX/ed6WHc--

