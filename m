Return-Path: <linux-kernel+bounces-100926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5182D879FBE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 00:42:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 686E31C2170D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 23:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7805B47A52;
	Tue, 12 Mar 2024 23:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="pQs+2XKK"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 956A726286;
	Tue, 12 Mar 2024 23:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710286925; cv=none; b=KIZZu9W2l6f1HLly/STJi3JzcecDTYcAr0kv3Z0lGboRNDofCU/mvbgM5gtobescMzFporlN5RRZUiyjsQYWpfjRrPJb7G8AVIshlBajF2rCUqUhoaqpHcsh9EET50MrsH+/AI2kCC6xB4DDPBjk8go7Gz31XxyZV+4HTDarAqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710286925; c=relaxed/simple;
	bh=Ht/vgGvTfP6q+zutj4Q4xwtp2EYZWw9H/nQfpl+nkDo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iHgkpAZ/OyGi1V4v1FtdTthQZvXnOREit4hEks5+wFmndWPtlS5pQy/ZS3xxiz9IL1cSBLGPu0vQ70OX0NMm6gICXNKKfbtltQq+XBelXXy2pRn699LXOculbvpDiZiI/FtpX6tB/m4L1PVDTK3uek4l3AJ8cMp6u6Rj64UfWoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=pQs+2XKK; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1710286920;
	bh=M7wqUR1uMhwgn2qeeoDQh7iUiljE4XKlKtAM47Rzd2I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pQs+2XKKCTYqB7tmyy89+/4Txiqd6SwHDGlVBpci2+TZymPbAvFEQMzbsl5oSH/jX
	 vSITjwswJ2n1B4tRNmwRJ13FSoUEqcnS18GrrploxN2HeM/UNUOi6qr7biKBHYwAjL
	 vU16EQIRfAM3gERWEpJu9H84D2KT15GxlwfUK2foFiFlHImytrnKB8XGnKeFwl212J
	 iwum/lO6TRuKFdQyGu4AF0GLmHBoVDHcyXkqA4+4XXrjfBDFcByFR5TcE9n9ReqK7h
	 5fcWh4r6RJa+HLlNR/a2jucA5iMv+w/WANaGleFXVY3Lnx6Pf3epICfUygfTP14oXM
	 DHCISxIqkQ6XQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TvVY373nXz4wqN;
	Wed, 13 Mar 2024 10:41:59 +1100 (AEDT)
Date: Wed, 13 Mar 2024 10:41:58 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Christian Brauner <brauner@kernel.org>, Dai Ngo <dai.ngo@oracle.com>,
 Jeff Layton <jlayton@kernel.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the vfs-brauner tree
Message-ID: <20240313104158.5649190c@canb.auug.org.au>
In-Reply-To: <20240219104450.4d258995@canb.auug.org.au>
References: <20240219104450.4d258995@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Zd.4RUrtd4Rx6L=dpQzjrfL";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/Zd.4RUrtd4Rx6L=dpQzjrfL
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Mon, 19 Feb 2024 10:44:50 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> After merging the vfs-brauner tree, today's linux-next build (powerpc
> ppc64_defconfig) failed like this:
>=20
> fs/nfsd/nfs4state.c: In function 'nfsd4_deleg_getattr_conflict':
> fs/nfsd/nfs4state.c:8845:32: error: 'struct file_lease' has no member nam=
ed 'fl_owner'
>  8845 |                         dp =3D fl->fl_owner;
>       |                                ^~
>=20
> Caused by commits
>=20
>   a69ce85ec9af ("filelock: split common fields into struct file_lock_core=
")
>   282c30f320ba ("filelock: remove temporary compatibility macros")
>=20
> interacting with commit
>=20
>   b9b89fb3e0b6 ("NFSD: handle GETATTR conflict with write delegation")
>=20
> from the nfsd tree.
>=20
> I have applied the following merge resolution patch.
>=20
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Mon, 19 Feb 2024 10:38:26 +1100
> Subject: [PATCH] fixup for "filelock: split common fields into struct
>  file_lock_core"
>=20
> interacting with "NFSD: handle GETATTR conflict with write delegation"
>=20
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  fs/nfsd/nfs4state.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 3545125c8b73..71bb0ee57cf8 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -8842,7 +8842,7 @@ nfsd4_deleg_getattr_conflict(struct svc_rqst *rqstp=
, struct inode *inode,
>  			}
>  break_lease:
>  			nfsd_stats_wdeleg_getattr_inc(nn);
> -			dp =3D fl->fl_owner;
> +			dp =3D fl->c.flc_owner;
>  			ncf =3D &dp->dl_cb_fattr;
>  			nfs4_cb_getattr(&dp->dl_cb_fattr);
>  			spin_unlock(&ctx->flc_lock);
> --=20
> 2.43.0

This is now required in the merge of the nfsd tree with Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/Zd.4RUrtd4Rx6L=dpQzjrfL
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXw6EYACgkQAVBC80lX
0GxuEQgAmwdzCg+Z+okkA3vPask4kdQH2VbxyPkHgZcdng66p4LFz88T0OOpbz2x
skOW9PnMKUVVd9hUTM/YknEWbaUZgxEWFhn7Z1M5xLv9bSVByJOBYxoXNwPT6cBt
O4hphar7sDhNhrzLFv5D0jYYMNVtHKhN6d4+4Xu67ypS5jNnpTne5cEWixn9wqD1
z4BG/D6KdFA02u8Cv2ZejqweGW0v9plMKkgJW8yS3cNixQiK7lcfNj157oEGcX38
uG0yBwq4pO54xa1Upvxt93ELooe0DvlsOJ9Vk1CtekgBmLedOSDoQAz9QDw8AcNX
83j7AUmjy5Jfwcbs3sV4w0DID8YiVg==
=zFGI
-----END PGP SIGNATURE-----

--Sig_/Zd.4RUrtd4Rx6L=dpQzjrfL--

