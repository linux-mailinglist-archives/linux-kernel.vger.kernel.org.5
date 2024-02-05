Return-Path: <linux-kernel+bounces-52037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EEDC849329
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 06:09:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF0CC1F22409
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 05:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98E47B667;
	Mon,  5 Feb 2024 05:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="ejj1ZYyu"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A3CB654;
	Mon,  5 Feb 2024 05:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707109753; cv=none; b=E7tV4aBAyDmsRjEtMwdPA5eh5hzk4TE96S36B871ro1lij7Bb6XtO6UNIauZIK7IWlACGu7707EcnQnF3ZxV3V0IMs2uN5bM6E9QL5hOYBvOx8EwexACTClzzcX0Lt9tDhdH23sKOC0vZuy1Bv9ESJQuE3lBx52pDtYrrdVTr/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707109753; c=relaxed/simple;
	bh=q/Xi4KajUWwxdMCzbdgmwEu3T3xuWQSeqmorusa2PNI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=G5tlLE+j7qORRD6wmXp2/reSLrPZRJItPtcLzcdrqcHKu5EKdHuSnlp2riX8jSXNHzdeeN4gM2Z7KDCnJ/hsiPJRVMQNWVP24Du0TcfMKm2fshuIpmD8qILy34conIRoMlRWhxW4zNolj0s5Xb0G5sbbrKSguOFGVdLRy8PGptM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=ejj1ZYyu; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1707109749;
	bh=PO3qNj2W3pYd8+HqYALOny12mvC6LogSBw4N8EJjxGw=;
	h=Date:From:To:Cc:Subject:From;
	b=ejj1ZYyuTWXvuXDuJlscxjxbmcLaw7tSkdzPho8NtPkPFDMT3//QiC55k98giHZsP
	 2EN/c2rvxOeCTxsDZPYqgNcSwIFbQOvkcrDFtgqiSDwE9b/yRvHG7fffvy35Q+0Opw
	 BxmYP/gX07pJByGmWeMy+EE0MB3tGr8Fl1D1ES7GAH+Rii/4Kh3ClUA63fjypW8QdT
	 LeRJsVkNyAI2Va194u9ABbSykqF+0AAMCa7fTaWboMugqm9lZVvOIhZ4oxhpqaBNBc
	 vE1+jDVuqdiErAsfS4urcrd59CoIXkhOSHbucDbnUQddYwUl59PMqhj8uL0JO7Uot+
	 lMAORoj+80dxg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TSvYc5hJ1z4wcb;
	Mon,  5 Feb 2024 16:09:08 +1100 (AEDT)
Date: Mon, 5 Feb 2024 16:09:08 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi
 <lpieralisi@kernel.org>, Krzysztof =?UTF-8?B?V2lsY3p5xYRza2k=?=
 <kw@linux.com>
Cc: Philipp Stanner <pstanner@redhat.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: build warnings after merge of the pci tree
Message-ID: <20240205160908.6df5e790@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/xs0peBkEdPQ67sRY5VnqT6s";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/xs0peBkEdPQ67sRY5VnqT6s
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the pci tree, today's linux-next build (htmldocs) produced
these warnings:

Documentation/driver-api/pci/pci.rst:27: WARNING: Duplicate C declaration, =
also defined at driver-api/device-io:27.
Declaration is '.. c:function:: void __iomem *pci_iomap_range(struct pci_de=
v *dev, int bar, unsigned long offset, unsigned long maxlen)'.
Documentation/driver-api/pci/pci.rst:27: WARNING: Duplicate C declaration, =
also defined at driver-api/device-io:27.
Declaration is '.. c:None:: struct pci_dev *dev'.
Documentation/driver-api/pci/pci.rst:27: WARNING: Duplicate C declaration, =
also defined at driver-api/device-io:27.
Declaration is '.. c:None:: int bar'.
Documentation/driver-api/pci/pci.rst:27: WARNING: Duplicate C declaration, =
also defined at driver-api/device-io:27.
Declaration is '.. c:None:: unsigned long offset'.
Documentation/driver-api/pci/pci.rst:27: WARNING: Duplicate C declaration, =
also defined at driver-api/device-io:27.
Declaration is '.. c:None:: unsigned long maxlen'.
Documentation/driver-api/pci/pci.rst:67: WARNING: Duplicate C declaration, =
also defined at driver-api/device-io:67.
Declaration is '.. c:function:: void __iomem *pci_iomap_wc_range(struct pci=
_dev *dev, int bar, unsigned long offset, unsigned long maxlen)'.
Documentation/driver-api/pci/pci.rst:67: WARNING: Duplicate C declaration, =
also defined at driver-api/device-io:67.
Declaration is '.. c:None:: struct pci_dev *dev'.
Documentation/driver-api/pci/pci.rst:67: WARNING: Duplicate C declaration, =
also defined at driver-api/device-io:67.
Declaration is '.. c:None:: int bar'.
Documentation/driver-api/pci/pci.rst:67: WARNING: Duplicate C declaration, =
also defined at driver-api/device-io:67.
Declaration is '.. c:None:: unsigned long offset'.
Documentation/driver-api/pci/pci.rst:67: WARNING: Duplicate C declaration, =
also defined at driver-api/device-io:67.
Declaration is '.. c:None:: unsigned long maxlen'.
Documentation/driver-api/pci/pci.rst:110: WARNING: Duplicate C declaration,=
 also defined at driver-api/device-io:110.
Declaration is '.. c:function:: void __iomem *pci_iomap(struct pci_dev *dev=
, int bar, unsigned long maxlen)'.
Documentation/driver-api/pci/pci.rst:110: WARNING: Duplicate C declaration,=
 also defined at driver-api/device-io:110.
Declaration is '.. c:None:: struct pci_dev *dev'.
Documentation/driver-api/pci/pci.rst:110: WARNING: Duplicate C declaration,=
 also defined at driver-api/device-io:110.
Declaration is '.. c:None:: int bar'.
Documentation/driver-api/pci/pci.rst:110: WARNING: Duplicate C declaration,=
 also defined at driver-api/device-io:110.
Declaration is '.. c:None:: unsigned long maxlen'.
Documentation/driver-api/pci/pci.rst:131: WARNING: Duplicate C declaration,=
 also defined at driver-api/device-io:131.
Declaration is '.. c:function:: void __iomem *pci_iomap_wc(struct pci_dev *=
dev, int bar, unsigned long maxlen)'.
Documentation/driver-api/pci/pci.rst:131: WARNING: Duplicate C declaration,=
 also defined at driver-api/device-io:131.
Declaration is '.. c:None:: struct pci_dev *dev'.
Documentation/driver-api/pci/pci.rst:131: WARNING: Duplicate C declaration,=
 also defined at driver-api/device-io:131.
Declaration is '.. c:None:: int bar'.
Documentation/driver-api/pci/pci.rst:131: WARNING: Duplicate C declaration,=
 also defined at driver-api/device-io:131.
Declaration is '.. c:None:: unsigned long maxlen'.

Introduced by commit

  fbcc7d7f7948 ("PCI: Move pci_iomap.c to drivers/pci/")

--=20
Cheers,
Stephen Rothwell

--Sig_/xs0peBkEdPQ67sRY5VnqT6s
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXAbXQACgkQAVBC80lX
0GwWLwf+J9Q4CeucQguko/ZL35eDyh6TPcV1WNRuDTcElyYIFKuWQ9B8aTzhBzDm
zsZ3W2sr0Oj61Eqyy5DA7wnjQbK/w+lDQNtRlO8qt7oaX+QokXduN6RzARdTADY0
HFGnGjbhFArSsVmnI9Iq0cgAaTs1TLwJyaQZqf8S9nU1Vqy24yC0lh2fdPqOxtai
IrPLWEhZyxgYNpZAzu/jNmlDBEn7b2Z4Tph8ehtBuwYwB057TeZevLE0VfGXKGO+
jVPNb4Z2xm3u60e70Y1m7t0j4XHdIjJyoBQBZgKaTUgbNqozD0qQDCeS/W+2Li+0
B9tv/KG5v/gouYcY6iHf1roPaM994A==
=5MD9
-----END PGP SIGNATURE-----

--Sig_/xs0peBkEdPQ67sRY5VnqT6s--

