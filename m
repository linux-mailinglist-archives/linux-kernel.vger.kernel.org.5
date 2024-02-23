Return-Path: <linux-kernel+bounces-77651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FFD6860880
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 02:50:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F23B1C219D4
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 01:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A018B67F;
	Fri, 23 Feb 2024 01:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="mxoq4V5j"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 847C9AD53;
	Fri, 23 Feb 2024 01:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708653035; cv=none; b=mzLXK4+1+0REivRmVXwgPGcLQt9MbG7G9zk/yNe0wyv2yzihbLIpFDVtTJdcuVxN5005UqVQ+Qn+A6lo3tv2X09c4EqwWy+QyItstMWlTf+8p/btE8KiI5vp9krmPO8oOCpXspy/EKWT7kahzU/7uAcWKcu1Tdj4t4A05PLRUBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708653035; c=relaxed/simple;
	bh=TO9aSmC1qF+2Vi3+58lvCecuRJcGdfmPoYzFPgBvLh4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=q1t8CyXQ50BldY2evLRmo3v5Bt5OK9GnLTwIppo3wED/LCSq7l2vcMHxmLmXHZ9r0JEE4k+hmlceWXlwB1X9xQOno/hvCVXo7Oi8H8gvRyFnovRgFiLPp9Nrk6O5Kz+mdnloc5ZcgEPvTbFXxXsWH/4JyKD8O0E5Pq5t6D1dRLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=mxoq4V5j; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1708653030;
	bh=uuyXxSqtakaPAQV/y8aASUxaDXqmMJlArJZheVqoNb8=;
	h=Date:From:To:Cc:Subject:From;
	b=mxoq4V5jTdP6nBNw+E4kSJ9rHS3+MpHGdPnIoFB9bD6agKfzDCui49GfiwtRTagus
	 xEZrYpNlIhH8r/t5pNDB5ShAuvWQUC7dn/qtY1u+zmaIpLRMly1FW4i0VCLNwU2ViU
	 m1rYKh9CPNfXaIxgxfFyeP00jG/mb13xNHmID+1mcfflgQwbadZbl0attRpicaG7JG
	 6GD/T9lTESKCQziAoqY79SHDWf9lj3nZPJdPmhGydMFwy0KWUjW/kYeQujwnX4X7VD
	 JD8F0v60VWPqxV/97wk/DDVsnU7reF3VXKAh6PDwYmdK1aF5z1b7SA9DbbAk2n3hjr
	 r/aROdV2W1FIA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TgtJ55hQbz4wcR;
	Fri, 23 Feb 2024 12:50:29 +1100 (AEDT)
Date: Fri, 23 Feb 2024 12:50:27 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Paul Moore <paul@paul-moore.com>, David Miller <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Networking <netdev@vger.kernel.org>, Alexei Starovoitov
 <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Linux Kernel Mailing
 List <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>, Ondrej Mosnacek <omosnace@redhat.com>
Subject: linux-next: manual merge of the security tree with the net-next
 tree
Message-ID: <20240223125027.1c9f4f07@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_//dCjoofoYCR0aUn90YdCSxX";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_//dCjoofoYCR0aUn90YdCSxX
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the security tree got a conflict in:

  security/security.c

between commits:

  1b67772e4e3f ("bpf,lsm: Refactor bpf_prog_alloc/bpf_prog_free LSM hooks")
  a2431c7eabcf ("bpf,lsm: Refactor bpf_map_alloc/bpf_map_free LSM hooks")
  f568a3d49af9 ("bpf,lsm: Add BPF token LSM hooks")

from the net-next tree and commit:

  260017f31a8c ("lsm: use default hook return value in call_int_hook()")

from the security tree.

I fixed it up (I think, see below) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc security/security.c
index aef69632d0a9,b95772333d05..000000000000
--- a/security/security.c
+++ b/security/security.c
@@@ -5458,10 -5436,9 +5439,10 @@@ int security_bpf_prog(struct bpf_prog *
   *
   * Return: Returns 0 on success, error on failure.
   */
 -int security_bpf_map_alloc(struct bpf_map *map)
 +int security_bpf_map_create(struct bpf_map *map, union bpf_attr *attr,
 +			    struct bpf_token *token)
  {
- 	return call_int_hook(bpf_map_create, 0, map, attr, token);
 -	return call_int_hook(bpf_map_alloc_security, map);
++	return call_int_hook(bpf_map_create, map, attr, token);
  }
 =20
  /**
@@@ -5476,59 -5449,9 +5457,59 @@@
   *
   * Return: Returns 0 on success, error on failure.
   */
 -int security_bpf_prog_alloc(struct bpf_prog_aux *aux)
 +int security_bpf_prog_load(struct bpf_prog *prog, union bpf_attr *attr,
 +			   struct bpf_token *token)
  {
- 	return call_int_hook(bpf_prog_load, 0, prog, attr, token);
 -	return call_int_hook(bpf_prog_alloc_security, aux);
++	return call_int_hook(bpf_prog_load, prog, attr, token);
 +}
 +
 +/**
 + * security_bpf_token_create() - Check if creating of BPF token is allowed
 + * @token: BPF token object
 + * @attr: BPF syscall attributes used to create BPF token
 + * @path: path pointing to BPF FS mount point from which BPF token is cre=
ated
 + *
 + * Do a check when the kernel instantiates a new BPF token object from BP=
F FS
 + * instance. This is also the point where LSM blob can be allocated for L=
SMs.
 + *
 + * Return: Returns 0 on success, error on failure.
 + */
 +int security_bpf_token_create(struct bpf_token *token, union bpf_attr *at=
tr,
 +			      struct path *path)
 +{
- 	return call_int_hook(bpf_token_create, 0, token, attr, path);
++	return call_int_hook(bpf_token_create, token, attr, path);
 +}
 +
 +/**
 + * security_bpf_token_cmd() - Check if BPF token is allowed to delegate
 + * requested BPF syscall command
 + * @token: BPF token object
 + * @cmd: BPF syscall command requested to be delegated by BPF token
 + *
 + * Do a check when the kernel decides whether provided BPF token should a=
llow
 + * delegation of requested BPF syscall command.
 + *
 + * Return: Returns 0 on success, error on failure.
 + */
 +int security_bpf_token_cmd(const struct bpf_token *token, enum bpf_cmd cm=
d)
 +{
- 	return call_int_hook(bpf_token_cmd, 0, token, cmd);
++	return call_int_hook(bpf_token_cmd, token, cmd);
 +}
 +
 +/**
 + * security_bpf_token_capable() - Check if BPF token is allowed to delega=
te
 + * requested BPF-related capability
 + * @token: BPF token object
 + * @cap: capabilities requested to be delegated by BPF token
 + *
 + * Do a check when the kernel decides whether provided BPF token should a=
llow
 + * delegation of requested BPF-related capabilities.
 + *
 + * Return: Returns 0 on success, error on failure.
 + */
 +int security_bpf_token_capable(const struct bpf_token *token, int cap)
 +{
- 	return call_int_hook(bpf_token_capable, 0, token, cap);
++	return call_int_hook(bpf_token_capable, token, cap);
  }
 =20
  /**

--Sig_//dCjoofoYCR0aUn90YdCSxX
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXX+eMACgkQAVBC80lX
0GyEuQf/fzW8pQqhRLV/LNjkPuQR42gLeAwWk3S5MB02eF0x5Rtjob5uUAFyZZRs
j8d9rWhqoi5yQLzGEbcpIfZfUKjQOzzXRqCWj0q6r6HtsF9hDcLGrHoDoWBiyHjf
/tASthmG100GLPol1xgbiWAIKV+tFIJOWZ6+j0WaUwYM2WsmeeCYtt3uuYfKD2GG
RRJkPjrr7JnHfKrD57uosARQKHTal5JHdo0wiZsS/vX76YXCzqtvqubFBw0YalDf
lQthV7SnrXux7wxglMjEQfKvJQyRntjsjRRRt2mfx6scfn2WKmFLG+HlkmXEcGrb
lqF7Hfhr4oGHpXaAxACKYTMsZ4ojQg==
=yQjI
-----END PGP SIGNATURE-----

--Sig_//dCjoofoYCR0aUn90YdCSxX--

