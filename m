Return-Path: <linux-kernel+bounces-159507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C22038B2F88
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 06:49:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D2CEB22D28
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 04:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B241613A241;
	Fri, 26 Apr 2024 04:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="cP/8UZck"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B0079C8;
	Fri, 26 Apr 2024 04:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714106941; cv=none; b=MlNALCk/3nAoN+AaNK72Aa8vdD41tDz61awyQfUrzOItLzvHrIsiHOiZ5CDdaNYJWQj+wWUQvnXOs8Tif+jTVfJ+3HG8akFRK/zGeEzIQwRZEoXTM/wg+ZURVsainR94R0qBE2RdALMLvW+bUH6yz89UY3Lb4if9Ptixxt7RK74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714106941; c=relaxed/simple;
	bh=xU2zomwj9/ydjNYiRynDe3eb1DKIRhbGKqT+uKeZ1S0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=psqIH0+ib3DaEigJSA3tnFupYldwOk4Id1CQleMoFNrDgssoUWwGW5F7FrxjcU7tnZVA/x23us4BFuD1XSYUdrOOJELvcX1YZdDMoPgXZdMHWEzdLnFSnVr2ygB9CbaDsf+2DIOEBFzGVGsHv1LEdoxRBc6fMQR86yaIQGEHI+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=cP/8UZck; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1714106931;
	bh=WbnxceZDcqzRy9lC/t3W8aleW+UyGIU0IM6Ke2NiOyA=;
	h=Date:From:To:Cc:Subject:From;
	b=cP/8UZckJfC5HQsspOfkGABwi81y+1ldiGwZvQeRmbp9mOAiJjc37AvYtPVSL/VQ0
	 hPLGKcDoVsUR/CJs/7udtKJUd1hGg7/f9Unkg6G+1diuapnRjUSMgoH2Kg7nERRe6f
	 byugcb7jLW0NK1HelKMWBFCQOsVwDEYqaEeeLYF7bVqzgeayL7QQKjQUwF1o07JQeO
	 f1oB/gHBrywMvt+GC47SNOhaG6mUT9n0wImoBwnOvtKJoQ9rxjG3KBKvsHPCVnVNHO
	 E0x/+0mNe4be1ouZcdjHKLCyWIl84zxiWMqoEDtsv9FZzHfMkVtYFl5Naso73T4gyO
	 8386NKOtQsWHQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VQgGp2y5Fz4wcd;
	Fri, 26 Apr 2024 14:48:49 +1000 (AEST)
Date: Fri, 26 Apr 2024 14:48:48 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Greg KH <greg@kroah.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Krishna Kurapati
 <quic_kriskura@quicinc.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>, Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Subject: linux-next: manual merge of the usb tree with the usb.current tree
Message-ID: <20240426144848.42539084@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/MSf8mbwjGh7ewI70lSjVUnn";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/MSf8mbwjGh7ewI70lSjVUnn
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the usb tree got a conflict in:

  drivers/usb/dwc3/core.c

between commit:

  6d735722063a ("usb: dwc3: core: Prevent phy suspend during init")

from the usb.current tree and commit:

  30a46746ca5a ("usb: dwc3: core: Refactor PHY logic to support Multiport C=
ontroller")

from the usb tree.

I fixed it up (I think - see below) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/usb/dwc3/core.c
index 100041320e8d,4dc6fc79c6d9..000000000000
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@@ -104,27 -105,6 +105,30 @@@ static int dwc3_get_dr_mode(struct dwc
  	return 0;
  }
 =20
 +void dwc3_enable_susphy(struct dwc3 *dwc, bool enable)
 +{
 +	u32 reg;
++	int i;
 +
- 	reg =3D dwc3_readl(dwc->regs, DWC3_GUSB3PIPECTL(0));
- 	if (enable && !dwc->dis_u3_susphy_quirk)
- 		reg |=3D DWC3_GUSB3PIPECTL_SUSPHY;
- 	else
- 		reg &=3D ~DWC3_GUSB3PIPECTL_SUSPHY;
++	for (i =3D 0; i < dwc->num_usb3_ports; i++) {
++		reg =3D dwc3_readl(dwc->regs, DWC3_GUSB3PIPECTL(i));
++		if (enable && !dwc->dis_u3_susphy_quirk)
++			reg |=3D DWC3_GUSB3PIPECTL_SUSPHY;
++		else
++			reg &=3D ~DWC3_GUSB3PIPECTL_SUSPHY;
++		dwc3_writel(dwc->regs, DWC3_GUSB3PIPECTL(i), reg);
++	}
 +
- 	dwc3_writel(dwc->regs, DWC3_GUSB3PIPECTL(0), reg);
-=20
- 	reg =3D dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(0));
- 	if (enable && !dwc->dis_u2_susphy_quirk)
- 		reg |=3D DWC3_GUSB2PHYCFG_SUSPHY;
- 	else
- 		reg &=3D ~DWC3_GUSB2PHYCFG_SUSPHY;
-=20
- 	dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(0), reg);
++	for (i =3D 0; i < dwc->num_usb2_ports; i++) {
++		reg =3D dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(i));
++		if (enable && !dwc->dis_u2_susphy_quirk)
++			reg |=3D DWC3_GUSB2PHYCFG_SUSPHY;
++		else
++			reg &=3D ~DWC3_GUSB2PHYCFG_SUSPHY;
++		dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(i), reg);
++	}
 +}
 +
  void dwc3_set_prtcap(struct dwc3 *dwc, u32 mode)
  {
  	u32 reg;
@@@ -596,19 -594,14 +618,11 @@@ static int dwc3_core_ulpi_init(struct d
  	return ret;
  }
 =20
- /**
-  * dwc3_phy_setup - Configure USB PHY Interface of DWC3 Core
-  * @dwc: Pointer to our controller context structure
-  *
-  * Returns 0 on success. The USB PHY interfaces are configured but not
-  * initialized. The PHY interfaces and the PHYs get initialized together =
with
-  * the core in dwc3_core_init.
-  */
- static int dwc3_phy_setup(struct dwc3 *dwc)
+ static int dwc3_ss_phy_setup(struct dwc3 *dwc, int index)
  {
 -	unsigned int hw_mode;
  	u32 reg;
 =20
- 	reg =3D dwc3_readl(dwc->regs, DWC3_GUSB3PIPECTL(0));
 -	hw_mode =3D DWC3_GHWPARAMS0_MODE(dwc->hwparams.hwparams0);
 -
+ 	reg =3D dwc3_readl(dwc->regs, DWC3_GUSB3PIPECTL(index));
 =20
  	/*
  	 * Make sure UX_EXIT_PX is cleared as that causes issues with some

--Sig_/MSf8mbwjGh7ewI70lSjVUnn
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmYrMjAACgkQAVBC80lX
0GxUlQf7Bps09f2YPz14hSjRHunWPt1Rdinyg7YIJjURyWA5jK6x22n4rOObioZw
5Vi7BbXT1fYzUsZ4JdSwoKKvn0HPo5q7TN9Y7zV1I+1r7kWxOQ9qdmPeiCkOefa3
7vHFXiHE+wcsWOEuElbqyoc9n0P/9ak3o0FyaEof5a03AhhFAcmY4vkNx9Ar+5VI
LXLXjJ7wFeB3F1ghFGoUBbfMjKZtEUHjRaGROVab2kdVlbsGHnz8m3KZIJeXhPBv
EePxt1gqN8Sq6p1nWP2NVqFuGWgePctnFfsqRspxNqGXafO+zffKLv145B49XHgB
7bF2LQS/B+JIYULKnegT4q5tnL3Lew==
=JKky
-----END PGP SIGNATURE-----

--Sig_/MSf8mbwjGh7ewI70lSjVUnn--

