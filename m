Return-Path: <linux-kernel+bounces-74089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 593F085CFD6
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 06:39:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D82881F24434
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 05:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6392239FC9;
	Wed, 21 Feb 2024 05:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="So8EeGgc"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB6DF39AF1;
	Wed, 21 Feb 2024 05:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708493939; cv=none; b=TkrF5pTq+XpoJ2grXIorra08moyOkiCiJv/cpBuUKtnDs9P7L5qsH9MQdhvGhN2mRmI3VGDNioFVJoOBig5B9Ug8Sq0vPjQGf2KWHQWPiz9YS+DcrHC9xTJCIgkaPCScKj2Wr5A9Yruox5Pc8HPxgzNxbycol0xly5aYJ75Tm3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708493939; c=relaxed/simple;
	bh=k0dkQkkQDrm+UQROj9mgkM66Hwa7xSyoUkq4I+IVQ2w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ke1pMwd0ZWbOD6xJEfGB95PQmD9jZlnottv300LeXXpbMdVn9TedVaGSWaEvpe4Sba85kWFzXm0chK4Jyb4YvQ9NVDZWa0oSEwPJ8ixo5g0w9Z3C75KKTfLPqD3fMrcYPuKLAKKT4b3q/V16F2Rd6RslPJUxawv9r8N111PUKig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=So8EeGgc; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1708493935;
	bh=u/DCvJioEQ/jkbKNeO117+C8Yo2yl8wdT0vaqI4I3yY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=So8EeGgcKKeawf0yQ57hFj7hGVlsIz/UjkahW+CTjj8c5NIptkFkHvPp6k4Qe65Ln
	 +wgbxHAAUBIlBPTKn7vx7kpQDwr5r/5H9AG5NF+Jh99B3uAJDt48IEuS75oDvbub2h
	 6sCXeIJU3uCfELKOW3HtQEXlGQyd1ZFgZ5Tlrlz1EQnEWFnNFH3+bF1KWv25D2LBMn
	 YQFiDe5+xaCkJ1ahvylKjk/8k5yI28wvUU68Q86mvyblP6M0J3YvxZFCwFEaztqL6W
	 H+90fzlAUHfsh5QnwoBNpjN+kBFgXWNlXhwvnQziyzGIbQdSjvmN294w0m+9J85cZj
	 GcdnH4JppkQBg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TflSZ72v1z4wc4;
	Wed, 21 Feb 2024 16:38:54 +1100 (AEDT)
Date: Wed, 21 Feb 2024 16:38:54 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>, ARM
 <linux-arm-kernel@lists.infradead.org>
Cc: Rob Herring <robh@kernel.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the arm-soc-fixes tree
Message-ID: <20240221163854.3ccca24d@canb.auug.org.au>
In-Reply-To: <20240221163010.5f81813a@canb.auug.org.au>
References: <20240221092826.748e70c4@canb.auug.org.au>
	<20240221163010.5f81813a@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_//IeWwP_w7Es_4mDgD75+HnM";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_//IeWwP_w7Es_4mDgD75+HnM
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Wed, 21 Feb 2024 16:30:10 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>=20
> On Wed, 21 Feb 2024 09:28:26 +1100 Stephen Rothwell <sfr@canb.auug.org.au=
> wrote:
> >
> > After merging the arm-soc-fixes tree, today's linux-next build (arm
> > multi_v7_defconfig) produced this warning:
> >=20
> > arch/arm/boot/dts/renesas/r8a7790-lager.dts:444.11-458.5: Warning (inte=
rrupt_provider): /i2c-mux4/pmic@58: Missing '#interrupt-cells' in interrupt=
 provider
> > arch/arm/boot/dts/renesas/r8a7790-lager.dtb: Warning (interrupt_map): F=
ailed prerequisite 'interrupt_provider'
> > arch/arm/boot/dts/renesas/r8a7792-blanche.dts:376.10-392.4: Warning (in=
terrupt_provider): /soc/i2c@e60b0000/pmic@58: Missing '#interrupt-cells' in=
 interrupt provider
> > arch/arm/boot/dts/renesas/r8a7792-blanche.dtb: Warning (interrupt_map):=
 Failed prerequisite 'interrupt_provider'
> > arch/arm/boot/dts/renesas/r8a7790-stout.dts:344.10-362.4: Warning (inte=
rrupt_provider): /soc/i2c@e60b0000/pmic@58: Missing '#interrupt-cells' in i=
nterrupt provider
> > arch/arm/boot/dts/renesas/r8a7790-stout.dtb: Warning (interrupt_map): F=
ailed prerequisite 'interrupt_provider'
> > arch/arm/boot/dts/renesas/r8a7791-koelsch.dts:816.10-830.4: Warning (in=
terrupt_provider): /soc/i2c@e60b0000/pmic@58: Missing '#interrupt-cells' in=
 interrupt provider
> > arch/arm/boot/dts/renesas/r8a7791-koelsch.dtb: Warning (interrupt_map):=
 Failed prerequisite 'interrupt_provider'
> > arch/arm/boot/dts/renesas/r8a7791-porter.dts:410.10-420.4: Warning (int=
errupt_provider): /soc/i2c@e60b0000/pmic@5a: Missing '#interrupt-cells' in =
interrupt provider
> > arch/arm/boot/dts/renesas/r8a7791-porter.dtb: Warning (interrupt_map): =
Failed prerequisite 'interrupt_provider'
> > arch/arm/boot/dts/renesas/r8a7794-alt.dts:450.10-464.4: Warning (interr=
upt_provider): /soc/i2c@e6510000/pmic@58: Missing '#interrupt-cells' in int=
errupt provider
> > arch/arm/boot/dts/renesas/r8a7794-alt.dtb: Warning (interrupt_map): Fai=
led prerequisite 'interrupt_provider'
> > arch/arm/boot/dts/renesas/r8a7794-silk.dts:436.10-454.4: Warning (inter=
rupt_provider): /soc/i2c@e6510000/pmic@58: Missing '#interrupt-cells' in in=
terrupt provider
> > arch/arm/boot/dts/renesas/r8a7794-silk.dtb: Warning (interrupt_map): Fa=
iled prerequisite 'interrupt_provider'
> > arch/arm/boot/dts/renesas/r8a7793-gose.dts:756.10-770.4: Warning (inter=
rupt_provider): /soc/i2c@e60b0000/pmic@58: Missing '#interrupt-cells' in in=
terrupt provider
> > arch/arm/boot/dts/renesas/r8a7793-gose.dtb: Warning (interrupt_map): Fa=
iled prerequisite 'interrupt_provider'
> >=20
> > Introduced/exposed by commit
> >=20
> >   78b6f8e7379b ("dtc: Enable dtc interrupt_provider check")
> >=20
> > I guess you missed some :-( =20
>=20
> Also these from the arm64 defconfig build:
>=20
> arch/arm64/boot/dts/freescale/mba8xx.dtsi:233.20-249.4: Warning (interrup=
t_provider): /bus@5a000000/i2c@5a810000/gpio@70: Missing '#interrupt-cells'=
 in interrupt provider
> arch/arm64/boot/dts/freescale/imx8dxp-tqma8xdp-mba8xx.dtb: Warning (inter=
rupt_map): Failed prerequisite 'interrupt_provider'
> arch/arm64/boot/dts/freescale/mba8xx.dtsi:233.20-249.4: Warning (interrup=
t_provider): /bus@5a000000/i2c@5a810000/gpio@70: Missing '#interrupt-cells'=
 in interrupt provider
> arch/arm64/boot/dts/freescale/imx8qxp-tqma8xqp-mba8xx.dtb: Warning (inter=
rupt_map): Failed prerequisite 'interrupt_provider'

And these from the powerpc ppc44x_defconfig build:

arch/powerpc/boot/dts/sam440ep.dts:266.22-287.5: Warning (interrupt_provide=
r): /plb/pci@ec000000: '#interrupt-cells' found, but node is not an interru=
pt provider
arch/powerpc/boot/dts/sam440ep.dtb: Warning (interrupt_map): Failed prerequ=
isite 'interrupt_provider'

And these from the powerpc allyesconfig build:

arch/powerpc/boot/dts/mpc5200b.dtsi:267.20-282.4: Warning (interrupt_provid=
er): /pci@f0000d00: '#interrupt-cells' found, but node is not an interrupt =
provider
arch/powerpc/boot/dts/a3m071.dtb: Warning (interrupt_map): Failed prerequis=
ite 'interrupt_provider'
arch/powerpc/boot/dts/mpc5121.dtsi:508.20-525.4: Warning (interrupt_provide=
r): /pci@80008500: '#interrupt-cells' found, but node is not an interrupt p=
rovider
arch/powerpc/boot/dts/ac14xx.dtb: Warning (interrupt_map): Failed prerequis=
ite 'interrupt_provider'
arch/powerpc/boot/dts/amigaone.dts:57.9-163.5: Warning (interrupt_provider)=
: /pci@80000000/isa@7: '#interrupt-cells' found, but node is not an interru=
pt provider
arch/powerpc/boot/dts/amigaone.dtb: Warning (interrupt_map): Failed prerequ=
isite 'interrupt_provider'
arch/powerpc/boot/dts/mpc5200b.dtsi:267.20-282.4: Warning (interrupt_provid=
er): /pci@f0000d00: '#interrupt-cells' found, but node is not an interrupt =
provider
arch/powerpc/boot/dts/cm5200.dtb: Warning (interrupt_map): Failed prerequis=
ite 'interrupt_provider'
arch/powerpc/boot/dts/ep8248e.dts:101.13-190.5: Warning (interrupt_provider=
): /soc@f0000000/cpm@119c0: '#interrupt-cells' found, but node is not an in=
terrupt provider
arch/powerpc/boot/dts/ep8248e.dtb: Warning (interrupt_map): Failed prerequi=
site 'interrupt_provider'
arch/powerpc/boot/dts/ep88xc.dts:122.13-131.5: Warning (interrupt_provider)=
: /soc@fa200000/pcmcia@80: '#interrupt-cells' found, but node is not an int=
errupt provider
arch/powerpc/boot/dts/ep88xc.dtb: Warning (interrupt_map): Failed prerequis=
ite 'interrupt_provider'
arch/powerpc/boot/dts/fsp2.dts:392.24-397.5: Warning (interrupt_provider): =
/plb4/plb6-system-hung-irq: '#interrupt-cells' found, but node is not an in=
terrupt provider
arch/powerpc/boot/dts/fsp2.dts:399.16-404.5: Warning (interrupt_provider): =
/plb4/l2-error-irq: '#interrupt-cells' found, but node is not an interrupt =
provider
arch/powerpc/boot/dts/fsp2.dts:406.17-411.5: Warning (interrupt_provider): =
/plb4/plb6-plb4-irq: '#interrupt-cells' found, but node is not an interrupt=
 provider
arch/powerpc/boot/dts/fsp2.dts:413.16-418.5: Warning (interrupt_provider): =
/plb4/plb4-ahb-irq: '#interrupt-cells' found, but node is not an interrupt =
provider
arch/powerpc/boot/dts/fsp2.dts:420.18-425.5: Warning (interrupt_provider): =
/plb4/opbd-error-irq: '#interrupt-cells' found, but node is not an interrup=
t provider
arch/powerpc/boot/dts/fsp2.dts:427.17-432.5: Warning (interrupt_provider): =
/plb4/cmu-error-irq: '#interrupt-cells' found, but node is not an interrupt=
 provider
arch/powerpc/boot/dts/fsp2.dts:434.18-439.5: Warning (interrupt_provider): =
/plb4/conf-error-irq: '#interrupt-cells' found, but node is not an interrup=
t provider
arch/powerpc/boot/dts/fsp2.dts:441.13-446.5: Warning (interrupt_provider): =
/plb4/mc-ue-irq: '#interrupt-cells' found, but node is not an interrupt pro=
vider
arch/powerpc/boot/dts/fsp2.dts:448.21-453.5: Warning (interrupt_provider): =
/plb4/reset-warning-irq: '#interrupt-cells' found, but node is not an inter=
rupt provider
arch/powerpc/boot/dts/fsp2.dtb: Warning (interrupt_map): Failed prerequisit=
e 'interrupt_provider'
arch/powerpc/boot/dts/fsl/gef_ppc9a.dts:195.22-209.4: Warning (interrupt_pr=
ovider): /pcie@fef08000: '#interrupt-cells' found, but node is not an inter=
rupt provider
arch/powerpc/boot/dts/fsl/gef_ppc9a.dts:211.22-213.4: Warning (interrupt_pr=
ovider): /pcie@fef09000: '#interrupt-cells' found, but node is not an inter=
rupt provider
arch/powerpc/boot/dts/fsl/gef_ppc9a.dtb: Warning (interrupt_map): Failed pr=
erequisite 'interrupt_provider'
arch/powerpc/boot/dts/fsl/gef_sbc310.dts:217.22-231.4: Warning (interrupt_p=
rovider): /pcie@fef09000: '#interrupt-cells' found, but node is not an inte=
rrupt provider
arch/powerpc/boot/dts/fsl/gef_sbc310.dtb: Warning (interrupt_map): Failed p=
rerequisite 'interrupt_provider'
arch/powerpc/boot/dts/fsl/gef_sbc610.dts:193.22-207.4: Warning (interrupt_p=
rovider): /pcie@fef08000: '#interrupt-cells' found, but node is not an inte=
rrupt provider
arch/powerpc/boot/dts/fsl/gef_sbc610.dts:209.22-211.4: Warning (interrupt_p=
rovider): /pcie@fef09000: '#interrupt-cells' found, but node is not an inte=
rrupt provider
arch/powerpc/boot/dts/fsl/gef_sbc610.dtb: Warning (interrupt_map): Failed p=
rerequisite 'interrupt_provider'
arch/powerpc/boot/dts/fsl/mpc8544ds.dtsi:154.11-204.6: Warning (interrupt_p=
rovider): /pcie@e000b000/pcie@0/uli1575@0/isa@1e: '#interrupt-cells' found,=
 but node is not an interrupt provider
arch/powerpc/boot/dts/fsl/mpc8544ds.dtb: Warning (interrupt_map): Failed pr=
erequisite 'interrupt_provider'
arch/powerpc/boot/dts/fsl/mpc8572ds.dtsi:375.11-425.6: Warning (interrupt_p=
rovider): /pcie@ffe08000/pcie@0/uli1575@0/isa@1e: '#interrupt-cells' found,=
 but node is not an interrupt provider
arch/powerpc/boot/dts/fsl/mpc8572ds.dtb: Warning (interrupt_map): Failed pr=
erequisite 'interrupt_provider'
arch/powerpc/boot/dts/fsl/mpc8572ds.dtsi:375.11-425.6: Warning (interrupt_p=
rovider): /pcie@fffe08000/pcie@0/uli1575@0/isa@1e: '#interrupt-cells' found=
, but node is not an interrupt provider
arch/powerpc/boot/dts/fsl/mpc8572ds_36b.dtb: Warning (interrupt_map): Faile=
d prerequisite 'interrupt_provider'
arch/powerpc/boot/dts/fsl/mpc8572ds.dtsi:375.11-425.6: Warning (interrupt_p=
rovider): /pcie@ffe08000/pcie@0/uli1575@0/isa@1e: '#interrupt-cells' found,=
 but node is not an interrupt provider
arch/powerpc/boot/dts/fsl/mpc8572ds_camp_core0.dtb: Warning (interrupt_map)=
: Failed prerequisite 'interrupt_provider'
arch/powerpc/boot/dts/fsl/mpc8572ds.dtsi:375.11-425.6: Warning (interrupt_p=
rovider): /pcie@ffe08000/pcie@0/uli1575@0/isa@1e: '#interrupt-cells' found,=
 but node is not an interrupt provider
arch/powerpc/boot/dts/fsl/mpc8572ds_camp_core1.dtb: Warning (interrupt_map)=
: Failed prerequisite 'interrupt_provider'
arch/powerpc/boot/dts/mpc5200b.dtsi:267.20-282.4: Warning (interrupt_provid=
er): /pci@f0000d00: '#interrupt-cells' found, but node is not an interrupt =
provider
arch/powerpc/boot/dts/motionpro.dtb: Warning (interrupt_map): Failed prereq=
uisite 'interrupt_provider'
arch/powerpc/boot/dts/mgcoge.dts:105.13-230.5: Warning (interrupt_provider)=
: /soc@f0000000/cpm@119c0: '#interrupt-cells' found, but node is not an int=
errupt provider
arch/powerpc/boot/dts/mgcoge.dtb: Warning (interrupt_map): Failed prerequis=
ite 'interrupt_provider'
arch/powerpc/boot/dts/fsl/mvme7100.dts:135.22-137.4: Warning (interrupt_pro=
vider): /pcie@f1008000: '#interrupt-cells' found, but node is not an interr=
upt provider
arch/powerpc/boot/dts/fsl/mvme7100.dts:139.22-141.4: Warning (interrupt_pro=
vider): /pcie@f1009000: '#interrupt-cells' found, but node is not an interr=
upt provider
arch/powerpc/boot/dts/fsl/mvme7100.dtb: Warning (interrupt_map): Failed pre=
requisite 'interrupt_provider'
arch/powerpc/boot/dts/mpc885ads.dts:127.13-136.5: Warning (interrupt_provid=
er): /soc@ff000000/pcmcia@80: '#interrupt-cells' found, but node is not an =
interrupt provider
arch/powerpc/boot/dts/mpc885ads.dtb: Warning (interrupt_map): Failed prereq=
uisite 'interrupt_provider'
arch/powerpc/boot/dts/mvme5100.dts:155.7-177.5: Warning (interrupt_provider=
): /pci@feff0000/isa: '#interrupt-cells' found, but node is not an interrup=
t provider
arch/powerpc/boot/dts/mvme5100.dtb: Warning (interrupt_map): Failed prerequ=
isite 'interrupt_provider'
arch/powerpc/boot/dts/mpc5200b.dtsi:267.20-282.4: Warning (interrupt_provid=
er): /pci@f0000d00: '#interrupt-cells' found, but node is not an interrupt =
provider
arch/powerpc/boot/dts/o2d300.dtb: Warning (interrupt_map): Failed prerequis=
ite 'interrupt_provider'
arch/powerpc/boot/dts/mpc5200b.dtsi:267.20-282.4: Warning (interrupt_provid=
er): /pci@f0000d00: '#interrupt-cells' found, but node is not an interrupt =
provider
arch/powerpc/boot/dts/o2d.dtb: Warning (interrupt_map): Failed prerequisite=
 'interrupt_provider'
arch/powerpc/boot/dts/mpc5200b.dtsi:267.20-282.4: Warning (interrupt_provid=
er): /pci@f0000d00: '#interrupt-cells' found, but node is not an interrupt =
provider
arch/powerpc/boot/dts/o2dnt2.dtb: Warning (interrupt_map): Failed prerequis=
ite 'interrupt_provider'
arch/powerpc/boot/dts/mpc5200b.dtsi:267.20-282.4: Warning (interrupt_provid=
er): /pci@f0000d00: '#interrupt-cells' found, but node is not an interrupt =
provider
arch/powerpc/boot/dts/o2i.dtb: Warning (interrupt_map): Failed prerequisite=
 'interrupt_provider'
arch/powerpc/boot/dts/mpc5200b.dtsi:267.20-282.4: Warning (interrupt_provid=
er): /pci@f0000d00: '#interrupt-cells' found, but node is not an interrupt =
provider
arch/powerpc/boot/dts/o2mnt.dtb: Warning (interrupt_map): Failed prerequisi=
te 'interrupt_provider'
arch/powerpc/boot/dts/mpc5200b.dtsi:267.20-282.4: Warning (interrupt_provid=
er): /pci@f0000d00: '#interrupt-cells' found, but node is not an interrupt =
provider
arch/powerpc/boot/dts/o3dnt.dtb: Warning (interrupt_map): Failed prerequisi=
te 'interrupt_provider'
arch/powerpc/boot/dts/mpc5121.dtsi:508.20-525.4: Warning (interrupt_provide=
r): /pci@80008500: '#interrupt-cells' found, but node is not an interrupt p=
rovider
arch/powerpc/boot/dts/pdm360ng.dtb: Warning (interrupt_map): Failed prerequ=
isite 'interrupt_provider'
arch/powerpc/boot/dts/sam440ep.dts:266.22-287.5: Warning (interrupt_provide=
r): /plb/pci@ec000000: '#interrupt-cells' found, but node is not an interru=
pt provider
arch/powerpc/boot/dts/sam440ep.dtb: Warning (interrupt_map): Failed prerequ=
isite 'interrupt_provider'
arch/powerpc/boot/dts/fsl/p2020ds.dtsi:274.11-324.6: Warning (interrupt_pro=
vider): /pcie@ffe09000/pcie@0/uli1575@0/isa@1e: '#interrupt-cells' found, b=
ut node is not an interrupt provider
arch/powerpc/boot/dts/fsl/p2020ds.dtb: Warning (interrupt_map): Failed prer=
equisite 'interrupt_provider'
arch/powerpc/boot/dts/fsl/ppa8548.dts:34.22-37.4: Warning (interrupt_provid=
er): /pci@fe0008000: '#interrupt-cells' found, but node is not an interrupt=
 provider
arch/powerpc/boot/dts/fsl/ppa8548.dts:39.22-42.4: Warning (interrupt_provid=
er): /pci@fe0009000: '#interrupt-cells' found, but node is not an interrupt=
 provider
arch/powerpc/boot/dts/fsl/ppa8548.dtb: Warning (interrupt_map): Failed prer=
equisite 'interrupt_provider'
arch/powerpc/boot/dts/mpc5200b.dtsi:267.20-282.4: Warning (interrupt_provid=
er): /pci@f0000d00: '#interrupt-cells' found, but node is not an interrupt =
provider
arch/powerpc/boot/dts/uc101.dtb: Warning (interrupt_map): Failed prerequisi=
te 'interrupt_provider'

--=20
Cheers,
Stephen Rothwell

--Sig_//IeWwP_w7Es_4mDgD75+HnM
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXVjG4ACgkQAVBC80lX
0GwClAf/b471QVL8kt3FlyqW1EAWvRss4UfYBjQzKYlwW04LzvESOr41j9BUhrbr
pvogqG82qlTsAE5WdhUNX+2PGgdqdfwkn+947yyCB2ytgVxDz6U4X40zOWhCY6Ts
QLKxjjTHUWA4NC6cIQnT97I0LGfYb7IDOQ0amEa89jzhVqI6ZXw1PZrc3M64rDmX
a+tDEFcHEAYVSepf3nL8q5MBHEok8H9e4HM/Cwx5PJNr79+I2nHZM7ZL8tM3idRD
OYISSi1Y3ByJWw71Dvuzm1WCgZu2rBsF1nHkqXIBvKIwYguup7sm+ZFU+TKHjzI+
b1DccPU5vkEZFkpRErm+T3DpmnS2ew==
=HCRk
-----END PGP SIGNATURE-----

--Sig_//IeWwP_w7Es_4mDgD75+HnM--

