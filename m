Return-Path: <linux-kernel+bounces-99809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CDED878DB7
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 05:00:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA1FB2824F6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 04:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE936BA34;
	Tue, 12 Mar 2024 04:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="rLZMA8Av"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 031A144C73;
	Tue, 12 Mar 2024 04:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710216007; cv=none; b=k76w1ds8xPAfWwOBc7z9YXrM5ezX0EIzNIqFecN0WYhlo8hixjBnnh+lv4eTS4BNtcHqiSPBM1o+TNXzTtrlQiTafMUx2j0jZeqRRLnZMDYe+kmFZFoGZDw9u0agGvdNJBHZSjwM/1dAzEn7meVH51XSt6V4AQQgsTVjj5Yvh04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710216007; c=relaxed/simple;
	bh=3URuGkzPRs4E77GmbYD2e4py9I9aZt63BbacUZfesj4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tqAr3+9EQHjmhwXQL1otB3ePsCo6LBEeA3y/qmVvZjX+viuMUi2myxYqrCGJyw50Owi41kCruIlVVr8OewJaSJfP2YzgmzRj1TBQUXHrU/7izeo3RWxgLFqaLE8I0X2zUQVuXrGJQtBFZWsSvKfVE9kUE01U6CcRHfs3yES0foQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=rLZMA8Av; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1710216003;
	bh=yZEz+WS8bOu0ju02ZAMRnOp28kobzHPnntSr9VC43dQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rLZMA8Avh4iVz/ES4lHIoJ6Oo7PzLY2WyH9Wa2iCV5yO7+uVRoEKO1V5AiLSbA61k
	 OE2Eay8jatzMHgmvWJea9iNJIVgXXRxzhTXNobjpCVEeGb9YmCytb8nDqfcPY5aCP7
	 HH2gcbKnFqleVQdp5sHPDJLF8oFMQQeoUEcK+9RwpBOw3kX+8wCPDFUBm6xAK5lRbn
	 lQogRLggX06teXSf7emFd95zzjGxA3OTHjAbbc53GAtGUY5CD5VgR6kw+I8yFzEugA
	 1DFtDIj+zBPW1EYynw1CyZyQlc/yKZvUebVE0Lzu4UpW4f7fi5iOnLUicnLGeucuNm
	 W+z/raDNVqD1Q==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Tv0KG4sNjz4wyx;
	Tue, 12 Mar 2024 15:00:02 +1100 (AEDT)
Date: Tue, 12 Mar 2024 15:00:01 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Christian Brauner <brauner@kernel.org>, Steve French
 <smfrench@gmail.com>
Cc: David Howells <dhowells@redhat.com>, Jeff Layton <jlayton@kernel.org>,
 CIFS <linux-cifs@vger.kernel.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>, Steve French <stfrench@microsoft.com>
Subject: Re: linux-next: manual merge of the vfs-brauner tree with the cifs
 tree
Message-ID: <20240312150001.471d3d94@canb.auug.org.au>
In-Reply-To: <20240226110343.28e340eb@canb.auug.org.au>
References: <20240226110343.28e340eb@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/N44fLK/yQcRJfrUddlD0fgT";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/N44fLK/yQcRJfrUddlD0fgT
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Mon, 26 Feb 2024 11:03:43 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> Today's linux-next merge of the vfs-brauner tree got a conflict in:
>=20
>   fs/smb/client/file.c
>=20
> between commit:
>=20
>   d7e87923939a ("cifs: Fix writeback data corruption")
>=20
> from the cifs tree and commit:
>=20
>   a69ce85ec9af ("filelock: split common fields into struct file_lock_core=
")
>=20
> from the vfs-brauner tree.
>=20
> Please do not do unrelated white space cleanups ...
>=20
> I fixed it up (I used the former version) and can carry the fix as
> necessary. This is now fixed as far as linux-next is concerned, but any
> non trivial conflicts should be mentioned to your upstream maintainer
> when your tree is submitted for merging.  You may also want to consider
> cooperating with the maintainer of the conflicting tree to minimise any
> particularly complex conflicts.

This is now a conflict between the cifs tree and Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/N44fLK/yQcRJfrUddlD0fgT
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXv00EACgkQAVBC80lX
0Gz45Qf/UDETD9m+M72hF/5WefZSbb6LRz09k8PyMM9r0PMZhi5wA7DKVMWWT6rV
ODAz8JnjUvv2j/Q2bPDCrhV+S0kE+D1rJ4V46aZYABA4Bcrl2fGp3ujSWzI+r5gP
U0s2UVFcgzdB1iNLtj+M72T/qDxvQQ+PSSn+f+dc5L1axvwZtxm2LXghHTlkWwNs
C9fAORLlnX/OG+SG8cbPZSbYsBIG58lwX14iFV/DchHSzOp8CxJfeLDsiThGwlnW
8PEhEMjTZgiSWOhsKenRHrfqS6bPoKkw5WkdvO4l+BucvlOcAMfG2XwMD1eOat5w
xbd36kNPKulgq69T+BSwLhKv5NPLTA==
=N9Cd
-----END PGP SIGNATURE-----

--Sig_/N44fLK/yQcRJfrUddlD0fgT--

