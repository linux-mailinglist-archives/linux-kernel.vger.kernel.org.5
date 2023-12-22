Return-Path: <linux-kernel+bounces-9506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3453D81C6AD
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 09:34:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 677581C2534F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 08:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A2F3CA59;
	Fri, 22 Dec 2023 08:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="T9RIE5C/"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D843659
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 08:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1703234050; x=1734770050;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=ik9crkT0XTZ3SsD0fxNTR3pdx9l+an8Ix+Qa0YkNTG8=;
  b=T9RIE5C/wrkd5UuI+t9g+BoYgUSuDHuceWD92teAd1urO8b4Uqs02kPL
   otwL7h5wFhM0xbEmqQgDuVuvGidNGvXbr06wbM8ZsAdUOpijcRZifmbmc
   1uKmPE9GKI4g5JN65Q7nqdBaVITUQyi83hHQYGVD7LJlJ930CKlmBydCS
   gXEj6KKFDQjFKCAS99BY9FMNu/Oy5G9R3FwiGjEydj7h0jonPQ7D8bft9
   qsIJBQhI+DBPR3qOy5SWa4m7SEot30tLI7YhLqQjA7hhqDGP9R4adbS8H
   VRUd2WvEMm+EYOBhK1qhO5RGuqkKCCivSSUSzbRMi9h/ADpdn5GK2rpi4
   g==;
X-IronPort-AV: E=Sophos;i="6.04,294,1695679200"; 
   d="scan'208";a="34649508"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 22 Dec 2023 09:34:07 +0100
Received: from [192.168.2.128] (SCHIFFERM-M2.tq-net.de [10.121.53.15])
	by vtuxmail01.tq-net.de (Postfix) with ESMTPA id 80332280075;
	Fri, 22 Dec 2023 09:34:06 +0100 (CET)
Message-ID: <ced9897c5db7ea22313d58ba95590e634e98e54b.camel@ew.tq-group.com>
Subject: Re: [PATCH] powerpc/6xx: set High BAT Enable flag on G2 cores
From: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>, "Aneesh Kumar K.V"
	 <aneesh.kumar@kernel.org>, "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, 
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	linux@ew.tq-group.com, Christophe Leroy <christophe.leroy@csgroup.eu>
Date: Fri, 22 Dec 2023 09:34:06 +0100
In-Reply-To: <875y0rkpe1.fsf@mail.lhotse>
References: <20231221124538.159706-1-matthias.schiffer@ew.tq-group.com>
	 <875y0rkpe1.fsf@mail.lhotse>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2023-12-22 at 12:16 +1100, Michael Ellerman wrote:
> Matthias Schiffer <matthias.schiffer@ew.tq-group.com> writes:
> > MMU_FTR_USE_HIGH_BATS is set for G2-based cores (G2_LE, e300cX), but th=
e
> > high BATs need to be enabled in HID2 to work. Add register definitions
> > and introduce a G2 variant of __setup_cpu_603.
> >=20
> > This fixes boot on CPUs like the MPC5200B with STRICT_KERNEL_RWX enable=
d.
>=20
> Nice find.
>=20
> Minor nit on naming. The 32-bit code mostly uses the numeric names, eg.
> 603, 603e, 604 etc. Can we stick with that, rather than using "G2"?
>=20
> Wikipedia says G2 =3D=3D 603e. But looking at your patch you're not chang=
ing
> all the 603e cores, so I guess it's not that clear cut?
>=20
> If using "G2" makes the most sense then it would be nice to update
> Documentation/arch/powerpc/cpu_families.rst to mention it (not asking
> you to do it necessarily, more a note for us).

According to the 603e manual I could find (MPR603EUM-01), the HID2 register=
 does not exist in the
original 603e cores - the register was only added by Freescale in its exten=
ded implementations.

The manual of the MPC5200 calls its core an "e300", but that seems to be an=
 older implementation
than the "e300c[1-4]" cores described in the "e300" manual. I'm not sure if=
 "e300" (without "cX")
and "G2_LE" are synonymous.

So AFAIR either "G2" or "e300" could be an appropriate name for the family,=
 but which is better I
can't say.

Regards,
Matthias




>=20
> cheers

--=20
TQ-Systems GmbH | M=C3=BChlstra=C3=9Fe 2, Gut Delling | 82229 Seefeld, Germ=
any
Amtsgericht M=C3=BCnchen, HRB 105018
Gesch=C3=A4ftsf=C3=BChrer: Detlef Schneider, R=C3=BCdiger Stahl, Stefan Sch=
neider
https://www.tq-group.com/

