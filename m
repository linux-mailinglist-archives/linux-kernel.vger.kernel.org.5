Return-Path: <linux-kernel+bounces-84493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D11E386A76B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 04:57:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F9871F242A3
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 03:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41CAB210E6;
	Wed, 28 Feb 2024 03:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="DNfQMhQe"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2289220DF4;
	Wed, 28 Feb 2024 03:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709092613; cv=none; b=rAhArWdwmM4xEbLn4FEKDsga4bFFvChcmR45JwqisuEb5i6N1aosQkVanZG4W86zlgycVlWLZMnhpYk+vHMUIBnUibjzQRLfvtEtMmTayq8eFm9c/khFWgtUEfQlK4mzHHUqWXyzwWn9JC09emcpsEy6k6LKgeSVwGXXg9Jtty8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709092613; c=relaxed/simple;
	bh=FIbJ20iO9crqfJURpfEx4vUAT5jF0FNH+iyZsp7PFsU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=gf46oBaNElZkyes4eZ69/gwvC/xvhzd50RcJkrMLxGWL15Sd0lyQgE4Yr4j6XUfcwQtIAGUj7EqvjODR5Gp1Uwl75cAmKGQvjzbApFbi7jP/cCU8EL+5gLVssksfZoJLictKhm+5mG5lk8cKXB40uk8c4T/nVlSEkPQQcAuhJ+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=DNfQMhQe; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1709092609;
	bh=xz3UT3lPq7/CGkMXPHVhK5laf0+VQBGZuR6bne1bF3A=;
	h=Date:From:To:Cc:Subject:From;
	b=DNfQMhQeCJX1M1Fm7QAfbOE+sBNlOArF+xQq6/9b6QAn+f+700jj0l6BecgSlw5X8
	 UiyoEBwXUrPN/TEbTxFHmcZu1tJ0dUQ45wtek5Q9TjTxfv4lQVLeIrXu72/3aLtQCy
	 +NDnluIMKOh0l8/fhf8ICMRaE3Ad3d8X6sZeaHn4XQeVGeVKOEWu9/OrRSkAQIJIB3
	 NWt4TAWhylg54/8keNsrbeKqhB0bXlfe3DSgZbTU4jatF8KRUbh6Vmn31Ectyf5h3I
	 Vpsg1OkRAPZ83kBUGkx6OYcuzBN9ik8NjcCa3GpBxydZO8jpqy/JVqRxzZZ0XQ5x9V
	 XtriFpKIrnlnw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Tl0sY0rhzz4wc7;
	Wed, 28 Feb 2024 14:56:49 +1100 (AEDT)
Date: Wed, 28 Feb 2024 14:56:48 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires
 <benjamin.tissoires@redhat.com>
Cc: Basavaraj Natikar <Basavaraj.Natikar@amd.com>, Jiri Kosina
 <jkosina@suse.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the hid tree
Message-ID: <20240228145648.41c493ec@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/3b6V1L2+LREF=st6vXefKtA";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/3b6V1L2+LREF=st6vXefKtA
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the hid tree, today's linux-next build (powerpc
allyesconfig) failed like this:

drivers/hid/amd-sfh-hid/amd_sfh_pcie.c: In function 'amd_mp2_pci_probe':
drivers/hid/amd-sfh-hid/amd_sfh_pcie.c:413:21: error: 'boot_cpu_data' undec=
lared (first use in this function); did you mean 'boot_cpu_hwid'?
  413 |                 if (boot_cpu_data.x86 >=3D 0x1A)
      |                     ^~~~~~~~~~~~~
      |                     boot_cpu_hwid

Caused by commit

  6296562f30b1 ("HID: amd_sfh: Extend MP2 register access to SFH")

I have reverted that commit for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/3b6V1L2+LREF=st6vXefKtA
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXerwAACgkQAVBC80lX
0GwBwwf/V2vcvG9Gylq36uNSX9qK3evirP/hNRAkYaYH9pWdShUEubd5sUBefue4
Qyr3OcNrJ1mrH5m3rro3R6FqTtFl0SXpOxatlERQRZjBV4N72sfu5QRBfXwmCJQs
KY+ICLTjnqFa3t95vyz/bqEEzeNzKpOLfl30fHLFGx1x3m4imUJhIuGgVSRuqcRr
gzhaykWwiSjjdU+uKh4WpvidvdKGDt3LlqqWJgnCvoe1BdaJc2sk5JrSQPs6aiGS
ukNraSEQD1pk6Tmuu0GcHR7N1TygbhaXo6D7WG/wuc5TktXAEnW0Gft7bfHAAEMS
Qeq/fTINXufk5/2XlstCWr3VhDhjkQ==
=eSHQ
-----END PGP SIGNATURE-----

--Sig_/3b6V1L2+LREF=st6vXefKtA--

