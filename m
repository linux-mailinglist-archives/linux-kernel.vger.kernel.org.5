Return-Path: <linux-kernel+bounces-52033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A27C084931B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 05:58:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D57D61C2169E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 04:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50EB1B667;
	Mon,  5 Feb 2024 04:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="oxcCc7qa"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D21B645;
	Mon,  5 Feb 2024 04:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707109125; cv=none; b=jk1vvH+4KkQoDVWevf7/AdBbb0uW2DKlXrMXX9cCh0VBkNujvvUsr7hdl/V0C8wtVgycDEarE49Y3pNJUaYku4q66wBcnVF4X5WGoV8edFn23nbNWYj9Y5uItQMsmBp8sUE1sdf2VCFEHPH347FFzhO6GUd9TI0wGLia8Tn/uBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707109125; c=relaxed/simple;
	bh=etRWsI1iWMbYkJH2a2nEeSbV7NH4e8t9jJLpSRI0pVw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=JaR+BgSCrDS3PaNqM5b7pZ09DioDYlDf3vEy+5/mpRlv9I3tTwmpICSNXuQoi26NOTfLbTE06T21ePA5w7FAr4xY8LNH17BZJ0yNcZHaxQpm3G8pe4ZpmMKlkM/DBsNUsufVfmPEd18cNpu+zcCJec4w61rXOv5OiTtpYT1Egis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=oxcCc7qa; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1707109118;
	bh=g6WIC2hOQQY2p1LYurBa0QPM3Z03WJOfSSZ0L0JYyg4=;
	h=Date:From:To:Cc:Subject:From;
	b=oxcCc7qaCj0PUYptQpP0mHFw5vSKBvCFAbyTJzY74ujxgCY8lncI9rZexDpBvpVaS
	 VyN7iwT8GBWSoh9nFxThjXi74WK3VcltpDw1PeXyfYqsESjA0WJ5BFe+K1LPahJb+H
	 PyyfuG8eKfPRbcr2CJudn0zhf2XSAToOYh91/1omls6XrJStH8AeGftn/CS9ooaxOA
	 8X0ZgJCLXyaYTusyTesgCi/ipt0un6onFEodhXOiB/s0JeNSLuNHCMczH1ye2pi94J
	 GvT0/B4/ZiOTePNFr5TSdWbK6heDx/qxsZ1ow118qCk0deNDOx2z8zuBscPSA2vF8V
	 UHFu0PLb0Q1jw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TSvKV39CBz4wcb;
	Mon,  5 Feb 2024 15:58:38 +1100 (AEDT)
Date: Mon, 5 Feb 2024 15:58:36 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Christian Brauner <brauner@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: boot failure after merge of the vfs-brauner tree
Message-ID: <20240205155836.7a388196@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/HFV6GAst.047r5w.vFuPe49";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/HFV6GAst.047r5w.vFuPe49
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the vfs-brauner tree, today's linux-next build (powerpc
pseries_le_defconfig) failed like this:


Bisected to commit

  7a1cac7d58e3 ("pidfd: convert to wake_up_poll()")

--=20
Cheers,
Stephen Rothwell

--Sig_/HFV6GAst.047r5w.vFuPe49
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXAavwACgkQAVBC80lX
0GwdjAgAnVsF8MMXSBkP9kGpuOEzAfX79JfGXck6EWP7In5h778+ak4sjc3Mc9Pe
0bvuJsOO8azGUrN7K1QQ/GxV8R4a2MVRDo5PN43Ey7Qq5Kmz/ZnOliDFGZig9WAp
d+imbr6lFNTd1kcnx7XfNeGlX3oEbjKEN+GNtFRR4rVzbFZ4GuKTzSByWk7HviSP
29hDZlp8yUoDDhLjzKlO8t/W0UhzXVVE9QV/04XdHv4mQOlnx3wjPs0DmC3tjb8Y
XLtSg8T7D2f4QOoxtFBGTyPff1q6mkbHOJvTdNAdTsmFEr2I1L9ZYtpGIK+rdHLG
cbJ1Y13ccZgfz750hz+rUE132qtcCA==
=qnIy
-----END PGP SIGNATURE-----

--Sig_/HFV6GAst.047r5w.vFuPe49--

