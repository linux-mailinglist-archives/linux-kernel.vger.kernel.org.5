Return-Path: <linux-kernel+bounces-45617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99AE984330D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 02:58:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC9C01C252CA
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 01:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7A705224;
	Wed, 31 Jan 2024 01:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="okkeiws6"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A88DA4C89;
	Wed, 31 Jan 2024 01:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706666331; cv=none; b=oiBL2xTJK7qOzA5aDPwCg3anjd4EESHHqRd3GWFuE4/ZWElUHn+Q3Is3k/Sn8iKB2mBPEclvwEd0L43CiNaD7mlaGUahsgrswifmyqSZWen7JxCe9ExVTZgAwGt6EJX2RggqP2ASskJJbF1kmUrvxmfM4mr0M39aNRElPimuEp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706666331; c=relaxed/simple;
	bh=c6RAw+yFP8FHnlxowXVoB6Ci7fBAwVaevvcU3/xjoD0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=GZdV/Drx3O75t2W7Lb7cjaAI7dLWzTKZEdmSeDIrHFHW8hzVmtQroWpqEPJziI2z3x6ywywUD8P49f1Cn9BPangZTdNiOv/dLU1htpAwsfVtbEE8kMuvwe2Jxg3+I1Ncgzk2FZHxvWE3J3wrw6gqGQSAj8Z3uXgIavxQRMVvGFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=okkeiws6; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1706666325;
	bh=k/q2BD1QuM7f0WCp9eGJmHRCpvb2DB6AnNrf1lzlFjo=;
	h=Date:From:To:Cc:Subject:From;
	b=okkeiws6b2V3XDauBJbW1O8pSolRsfGE4poSd4dAizvdyvuodG0drVdAGuCmNCbSU
	 8oVfT4MMJM4SNvrYZwIsoMCgatArMk5FfqIKE8luwAPaFLjg24g+t9Chs3PsOUR0R+
	 rMJLtzn8Afiv5WJqwAciCA3WOCcge//DvTTbV2TUAt8IiyD8NJFw93eh4WFo38npB4
	 ShudJhLMcqgHFnBXYecR/wSwDT8tc4oPzYR2ZRWuDDM+VpPXPVf/x9wP26LAeoNe0j
	 MkbVJn48swJ1HyAS7CPyOjTQ/OxczGnhpQq2UVUuaCKIW3XWYpVHS5LJkuKYvi0Ght
	 sCMXqk2/D2j+w==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TPlZD6SHzz4wxv;
	Wed, 31 Jan 2024 12:58:44 +1100 (AEDT)
Date: Wed, 31 Jan 2024 12:58:43 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi
 <lpieralisi@kernel.org>, Krzysztof =?UTF-8?B?V2lsY3p5xYRza2k=?=
 <kw@linux.com>
Cc: Johan Hovold <johan+linaro@kernel.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the pci-current tree
Message-ID: <20240131125843.29e54460@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/4HE0hfYMu+r3v3xZMhn8Dl/";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/4HE0hfYMu+r3v3xZMhn8Dl/
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the pci-current tree, today's linux-next build (htmldocs)
produced this warning:

drivers/pci/bus.c:440: warning: Function parameter or struct member 'top' n=
ot described in 'pci_walk_bus'
drivers/pci/bus.c:440: warning: Function parameter or struct member 'cb' no=
t described in 'pci_walk_bus'
drivers/pci/bus.c:440: warning: Function parameter or struct member 'userda=
ta' not described in 'pci_walk_bus'

Introduced by commit

  69fb843fdbd9 ("PCI/ASPM: Fix deadlock when enabling ASPM")

--=20
Cheers,
Stephen Rothwell

--Sig_/4HE0hfYMu+r3v3xZMhn8Dl/
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmW5qVMACgkQAVBC80lX
0GyDhwgAjWPbqkutjX+l76qKqP//T5GSvkx6VhkVFTtKJLGHEfGPrpIjvBDbdAVM
9pagcfMBYQZiR28BjiM4XYciAKsKjrVV4yllCg/XZx2wGWWJuxEi33xGfTeIH6PJ
+INg5JfCUY3Ei19Ly5btwZQvDmX57X/pZaF+QOPqH65rDr34dfyvatd1s0ItgFsp
TDMFWKoos5O6UNjYguJjKFwvXQk8X/p1w9ekz9O4mgaeq5iDV8Ywir7wXSKtoVje
Sdj+um3lEYXd6Vv1cTlrCIYZHQlqunLNHi+zhYzE+gZ3xqq7lyFyDCi4j3vmcCQZ
9pQtfPtsqUePEX3KMHJOtRE3N/Xy3w==
=IAbJ
-----END PGP SIGNATURE-----

--Sig_/4HE0hfYMu+r3v3xZMhn8Dl/--

