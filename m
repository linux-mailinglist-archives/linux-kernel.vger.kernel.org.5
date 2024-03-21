Return-Path: <linux-kernel+bounces-110790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 261908863FA
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 00:32:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8DD0CB21A1B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 23:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D702E54C;
	Thu, 21 Mar 2024 23:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="mnGJtQhp"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8BC94A2F;
	Thu, 21 Mar 2024 23:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711063960; cv=none; b=tLAEvjIR8KJwpV0/qBwoK4IRCdgQ4gjAJehytE1H/7WX0Of4pLIgBwxbdaWZbF3JWCcuy0UnMsuWubkjSz77e9SPm/dWV5G4m2ORxTDGULYRz7Vw9BlNBZ++tH5ss4XJTHXxn5+f3FKxTAGgNiOZbFQSyxFqtp5tHBoLPrpIvDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711063960; c=relaxed/simple;
	bh=TDo3mS/eIuCe8I2muxsY0xHIUNFbYCJ9TI8/pVMdnaM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j/9yN/xL/qkB7kU2NuOukjJXpEgvGChdu5U9agCj3Ys2z9iqDPvHyRRVtMGYF9EPnWCDvn+eEEDbO8wWPf96fYFLYdQYEMIjJrCk+VVd/9+tlkVc0JNWzkAOj+Bd93NdoA4q/vWHlqAlfH54AZAH/w3CzN5ZLd6E8Yg3oc7+wN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=mnGJtQhp; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1711063952;
	bh=PUAtAqwrgsjnyLK7M08cRgmCiFD0vnA+y8R8dTZkTFQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mnGJtQhpuAaDfdAzeugCthHe0/POF+LfHV4e5/Gf2FLeg/qSI5VZMgh98JJTt4tzg
	 mQokM4s4uluHQTE2fu4P7HHTwnirlfKm2WFT6xZfx1cV8PlmpBzw0fwVoNufF2Epnv
	 oEh2wrxtc6pEZ+uf5nG9ek4in68hGfdntpGpXthtnKGcVD+1uz9fzkNnn5wtZwXvLs
	 gosqHXXLCleNWniPCAX4zIBxB/T30bgs8ifKgj+cGtMoVfK4k7HNjNWD/4k85icYJH
	 QJ7//8pxWv1B4AhlxtYRaWe+0cTCWU/4sWLqA8/Ff3pNXwmiPF0C3ER6vMr178sZ46
	 Lfz76ikKH+mNA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4V11w02Fjyz4wcF;
	Fri, 22 Mar 2024 10:32:32 +1100 (AEDT)
Date: Fri, 22 Mar 2024 10:32:29 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>, Namhyung Kim
 <namhyung@kernel.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the perf tree
Message-ID: <20240322103229.28d823b8@canb.auug.org.au>
In-Reply-To: <ZfzAZJmrBwVi5e28@x1>
References: <20240322084131.2316eb8f@canb.auug.org.au>
	<ZfzAKMlYY7IkWXUg@x1>
	<ZfzAZJmrBwVi5e28@x1>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/pdSAHKnCvGsm344T3=kTxdb";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/pdSAHKnCvGsm344T3=kTxdb
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Arnaldo,

On Thu, 21 Mar 2024 20:19:00 -0300 Arnaldo Carvalho de Melo <acme@kernel.or=
g> wrote:
>
>=20
> About this specific problem, was this done on over a previous build? Can
> you try after a 'make -C tools/perf clean' ?

It was done over a previous build.  I can try a clean build later
today.  We have had this problem before with different include files
and I think it came down to a missing dependency.

--=20
Cheers,
Stephen Rothwell

--Sig_/pdSAHKnCvGsm344T3=kTxdb
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmX8w40ACgkQAVBC80lX
0Gwddgf+Jtzvy0nCEDD1lVDkhunEfzwVEw/BpBONsDEobUenDlUGq+WT47Adq22J
z/gW2vwQIN4m4rnepHL2cZGtFz04Kkx16VysCldBoHVGR6t3xqYiN9bmW4HJz8xS
PC/0KagqMfKPtmBX/byxfREOuKMYKdIwBrjEK6EKMTc8lEvN37VbUDIUtb44/GbG
detv5yml/I85iEOLqDLkgGTF9JHq5iJ+Qm4kx2RvnIkt9CXrT8Yemw35KH83EWL6
Yz3jTSp/5Kd6ZCU8PK5x4nGoose2gycQZGdliwYoxI6sJtK6GqqjJnPkn15EDk/Z
3teYCjVF6NR9aJqHaUDVawp0hDkWCQ==
=zoxz
-----END PGP SIGNATURE-----

--Sig_/pdSAHKnCvGsm344T3=kTxdb--

