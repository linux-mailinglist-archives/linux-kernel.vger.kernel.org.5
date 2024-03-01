Return-Path: <linux-kernel+bounces-87892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31AE386DABB
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 05:38:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA4A02843DB
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 04:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B13CD4F60D;
	Fri,  1 Mar 2024 04:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="GqugR3BQ"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C98346425;
	Fri,  1 Mar 2024 04:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709267892; cv=none; b=NQZG3+xA3k1u0Ur0/bWrbRZCCTUBvZAxFHzpDbELEv7d9f7eQ4RMej6xgSFEfIx4ZOdm7EEPQL0ZoG6Dva5IOsMH/XtocX0dATElBlTrYICsA2jAZaFOdHMU9OZDoU0pfvkuwbpcPFsNPXVu5OqsE139BPXl3sPN4CiKYqwMdnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709267892; c=relaxed/simple;
	bh=yCx6g2n76XZ+RlK7e7HSEMhl1xCxf1kYvZuF4riZm1A=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=D4zoCaaRlju4zyParOGKvj540z5Zp/i+YiLoJZxrqW93C8XBUWwy5Z79HGtqGguEXsNhsQlaBDCdmuJi8eVj+dtjkJ8+cikfHiSovy4bfznzvyIwnWaUJupKGUI1EiQI9qvUnlj3dX/I18KMsjszyhyv+rMg+phakKDz2OhfXb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=GqugR3BQ; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1709267888;
	bh=F77xY+9qqb1mR0bwmOtlNnouwx91f9f018ulkOph5ik=;
	h=Date:From:To:Cc:Subject:From;
	b=GqugR3BQ3qU3YEhAtUA0zYVJWIpceIQnCJXyAkFa7rZHv2PpErRhg4gPy1JMveoDb
	 cAcPMAJ1O2lmejI9bpD6Vi8ZofR4DR49+oXkft8ZUevM+/YzlgMV5p7m6Wqw7tG18u
	 pMv/FkqY0DWuZCDI3g8FXHG9EHADTI6LG22ZrkTL3g350TRzAzv+OxNQkFh68HtBA+
	 BaMQSjikTMsQzm6jFfMO1b3u2txwV/2Es1X8GJXVuz52f33ouFHayKB5Ug7o0/bhsw
	 U34XP04YelFcme3y+AJWe3DKmjPrf5IrC+PSRRrtWxWvbCXIg2nrtj/P42Npfcr5bY
	 2bTlTymnQgAMw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TmFhH6KSwz4wcY;
	Fri,  1 Mar 2024 15:38:07 +1100 (AEDT)
Date: Fri, 1 Mar 2024 15:38:07 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Miguel Ojeda <ojeda@kernel.org>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: Jamie Cunliffe <Jamie.Cunliffe@arm.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the rust tree with the arm64 tree
Message-ID: <20240301153807.796a3a28@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/.2pj11Q6FkPKN0uHRUIBq4B";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/.2pj11Q6FkPKN0uHRUIBq4B
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the rust tree got a conflict in:

  rust/Makefile

between commit:

  f82811e22b48 ("rust: Refactor the build target to allow the use of builti=
n targets")

from the arm64 tree and commit:

  ecab4115c44c ("kbuild: mark `rustc` (and others) invocations as recursive=
")

from the rust tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc rust/Makefile
index fe045dbc701e,a78fcf4004b0..000000000000
--- a/rust/Makefile
+++ b/rust/Makefile
@@@ -435,11 -434,8 +435,11 @@@ $(obj)/core.o: private skip_clippy =3D=20
  $(obj)/core.o: private skip_flags =3D -Dunreachable_pub
  $(obj)/core.o: private rustc_objcopy =3D $(foreach sym,$(redirect-intrins=
ics),--redefine-sym $(sym)=3D__rust$(sym))
  $(obj)/core.o: private rustc_target_flags =3D $(core-cfgs)
 -$(obj)/core.o: $(RUST_LIB_SRC)/core/src/lib.rs scripts/target.json FORCE
 +$(obj)/core.o: $(RUST_LIB_SRC)/core/src/lib.rs FORCE
- 	$(call if_changed_dep,rustc_library)
+ 	+$(call if_changed_dep,rustc_library)
 +ifneq ($(or $(CONFIG_X86_64),$(CONFIG_LOONGARCH)),)
 +$(obj)/core.o: scripts/target.json
 +endif
 =20
  $(obj)/compiler_builtins.o: private rustc_objcopy =3D -w -W '__*'
  $(obj)/compiler_builtins.o: $(src)/compiler_builtins.rs $(obj)/core.o FOR=
CE

--Sig_/.2pj11Q6FkPKN0uHRUIBq4B
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXhW68ACgkQAVBC80lX
0Gx0HQgAkomBdPUY5OuyXNUaiNmCnATr7bS63Q9dCYtcXivOsJgE1PuTw3qtmtfO
T5Fo9dllS6vgbs7PfBTxI6GnDFgq0laJO+waBNhid5HrPnQLvnpHefcGItnoS8qG
tok5nGED2pDbsKApamcIpaAL4XOg75ux9A5DlRWsilOekEqHa2C6imwQ71ufqBne
A6TPuNPQg3SnXoNLFcrs1nLwNPv5xJd4o/j1dI0pEZT7YU/Hp6Ym6YmL4cJ7qLon
xZFGAdwDLbuPCbbN3iMe2f8h3FdKezG04ZdMePnMJ+p3/MDwMd90awcyz495yxk2
KU2STa/4ZMtOcH0n4S3CkqdX2KUklA==
=VUiZ
-----END PGP SIGNATURE-----

--Sig_/.2pj11Q6FkPKN0uHRUIBq4B--

