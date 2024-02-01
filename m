Return-Path: <linux-kernel+bounces-47412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2D8C844DAC
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 01:15:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6007D28F1BC
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 00:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAAD2110A;
	Thu,  1 Feb 2024 00:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="lW96T7wT"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C964637A;
	Thu,  1 Feb 2024 00:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706746511; cv=none; b=hUCnzkQR8rvnEMkrw2wzISo0aRFs1DBRg9gWpzmSGAyvi6f0wJrFFjgVaGnE58D+x1+lVcc/Jcb7D2cOQOxZBIUshpRYrvuGbZRQnld1If6olmvjhGbGawhohdnoKOooWe3CT7HQXMx4gr1JD6fLoo0RHDzQoeoVOqr6I349eJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706746511; c=relaxed/simple;
	bh=2LBQU3W1CBLmlUwbEx11B9z4juEyOikn6gFpNGoqVpM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=ENiOmixwKU4LylyD41lrvkUIZbD6S5AuixTPkazAEOcjsYqVg0AlT/KlM13REiPZrJ85gVQYURHVf709qPJZjpA4WI6s32hNx2CKdc0P3hozRcW6yif/2CMEFfbSXxUkxyRoFuh1pzWuy/Mk1Vwz4/ZgOOueJ1VzuHswP97BGEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=lW96T7wT; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1706746498;
	bh=Mo8m4XGUMpy4yRQ1ibGzCKYA2icyGepWszobc6YR624=;
	h=Date:From:To:Cc:Subject:From;
	b=lW96T7wTKrMzs2UhmxdiIAbJCkuzNdM789lrbyNzzo+NwkIFB/HqVd5dEBEOJnrMi
	 TVTdS821bloRRfKXX6865BzbqFb4NQxb81dOZ6w8CX6u33E4G2+bmSMFyuuDqk/C5u
	 3Hr5GR7B1RNQ/zuuJZ+gI2mGushbOWWogiw+8vR2A3yF6N3CpgmF6BNwBSa+Hiqnho
	 wuQ4oBgsthb2YU1KimTJb2anuXrrNA4Ncb2sDqm5wKriBVl9jWm6nxxmQZrfP9ySbY
	 QJH64Sx0MqfB2iJyqnN6sme0MiCD8tb2rfDgzxsDcygVo1kMd+FHSFO2jU/SIN/wTR
	 HSevI9vnbszgQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TQKCz2nH6z4wcK;
	Thu,  1 Feb 2024 11:14:55 +1100 (AEDT)
Date: Thu, 1 Feb 2024 11:14:53 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>
Cc: "Borislav Petkov (AMD)" <bp@alien8.de>, Xin Li <xin3.li@intel.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the tip tree
Message-ID: <20240201111453.0ee3beff@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/B2SPw3IlrpIXX89W7FH1BqJ";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/B2SPw3IlrpIXX89W7FH1BqJ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the tip tree, today's linux-next build (x86_64 allmodconfig)
produced this warning:

vmlinux.o: warning: objtool: fred_extint+0x1c: call to array_index_mask_nos=
pec.constprop.0() leaves .noinstr.text section

Probably introduced by commit

  6786137bf8fd ("x86/fred: FRED entry/exit and dispatch code")

--=20
Cheers,
Stephen Rothwell

--Sig_/B2SPw3IlrpIXX89W7FH1BqJ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmW64n0ACgkQAVBC80lX
0Gyt8wf+IRxrB3za5wezZkKqUwIJPJTpk6TG0zNayczGLql0Ss2sCHLnH72+TNEb
xs3d61xiS7TV91gDP9Xx/6/TcglsYJaHBok34DL1lxB0NRxp/jgb41nzGWqP4KuC
DGkzSHnlJozPJIXlsgwWCK4AzdK7zG9p2oYIFSfZGPlSrLsgZ/ett2VGmaD6lhmS
pivRxENbC9Z1LWmlAJ2CJGs9yNxAcbmvnRa9cGRWYDfuuuWv1MAywCiX8JnbRRAy
Ga2Qk726XFuZ8o0wGe7cf7UceQIfKS8DUeS+9x3s2g0AFg/hNuGKiRjP0Brl/mAF
ZlXAhRxTUYT56y2Cg21W7v9A2EDWDQ==
=Z0mm
-----END PGP SIGNATURE-----

--Sig_/B2SPw3IlrpIXX89W7FH1BqJ--

