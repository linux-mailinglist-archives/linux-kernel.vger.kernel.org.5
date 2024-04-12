Return-Path: <linux-kernel+bounces-141762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 920958A231A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 03:01:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15E4EB220E8
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 01:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 867F1522A;
	Fri, 12 Apr 2024 01:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="WkCv44oB"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4529715B7;
	Fri, 12 Apr 2024 01:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712883705; cv=none; b=agNpGEfB2gGxWDMP1N+elgBfO/rrXjXhEq1JUDnWMmK+8y9bNKl/Pw5qE673eu4des2BsctrrVQtEklU9JsakcCZ5P48r4AO97uVSlJnhIBaBlnhPAieIEbPzC4NHv4Fge3nq0It/a2yuaQHDte5OxMsJ5Rx6HKkCvS5UrYP0rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712883705; c=relaxed/simple;
	bh=MmUZwWEGWD6oDx9BpRouhSb4sOyZ3qN1i1m8BxOXs14=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=tCOzYugxEjNkZw5GGI2wYPBNGavt8i/3DTF7PxiHPhq0+gduz7zvEIGRYepA+2WveFfPYeewGZcwNdijOvOunFZZvmcWuTr9g1CMOgUup3p/fdtZRoV43e5YgK5iGhodSxDvS2R84DhgLplt8LMiby9OQOle9GXHegbaasm9RLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=WkCv44oB; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1712883693;
	bh=suxFYouMG2I1qJZdWl0LtxMnhRDZN2VuG47izcE/4mk=;
	h=Date:From:To:Cc:Subject:From;
	b=WkCv44oBmBdBjOTyQvOfD995H1MoE7/LfIm2oMWI0ey5f9KwMw2m4QeHBj5d9Udh/
	 YajfjSNI58AcxOGwVI9xDAmOhRKbfgTE8bHnr/rdcka3nV9rLmmQ6sOYojDP36Epb7
	 owBP4FyLe0NjrFaTW2gyTEdHhGe8ZEBLdWKc7UATnSWhyLXAG/BNOjSgRXB/wxL6Jl
	 UwafhgmAQ9VlpHBAuEmOpTXm2+0rZl8grxUint2W91azYTxCsuUyHo5K/7QytHWQ/P
	 eTpDUMcIvCtHzWp3kkOvfNIwCNILsubuSqu3gQ/fnAMoTeStR7CIY/b+1Makukadb0
	 4PQUY1GBgc6TA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VFytz71tXz4wnv;
	Fri, 12 Apr 2024 11:01:31 +1000 (AEST)
Date: Fri, 12 Apr 2024 11:01:28 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Chuck Lever <chuck.lever@oracle.com>
Cc: Networking <netdev@vger.kernel.org>, Justin Stitt
 <justinstitt@google.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>, "Steven Rostedt (Google)"
 <rostedt@goodmis.org>
Subject: linux-next: manual merge of the net-next tree with the nfsd-fixes
 tree
Message-ID: <20240412110128.0fd442ec@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/A96EXYk=1Clzx6IfsDayTaq";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/A96EXYk=1Clzx6IfsDayTaq
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the net-next tree got a conflict in:

  include/trace/events/rpcgss.h

between commit:

  a4833e3abae1 ("SUNRPC: Fix rpcgss_context trace event acceptor field")

from the nfsd-fixes tree and commit:

  386f4a737964 ("trace: events: cleanup deprecated strncpy uses")

from the net-next tree.

I fixed it up (I just used the former version (which replaced the strncpy
with __assign_str) and can carry the fix as necessary. This is now fixed
as far as linux-next is concerned, but any non trivial conflicts should
be mentioned to your upstream maintainer when your tree is submitted for
merging.  You may also want to consider cooperating with the maintainer
of the conflicting tree to minimise any particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/A96EXYk=1Clzx6IfsDayTaq
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmYYh+gACgkQAVBC80lX
0GyNuwf/VypWRVNEyBW2fzBhyQjvmWIs55wXP1VhUUk4R0V1fIA1tzjwLzCQ3M81
x5kINhQ5jPpUDBg+NJm+vlRCUsn8K0hSBgG24a7LQ4ll0CE7dHNonblhesBS8b8V
4PJ5AJbSu+ocQOUILY4pjIQ98FjXoY29d5HvVgTvt6FkLSdqwPShNBzehFvkhxLs
iTUfwbPp1y9Zit/SRoOZq49lOfKSUklF195cqe2R8jX06I/LiPCGUNYmteTcss5E
99/fFUZeuHcsbdpscrDzuoGJpA1siPvefw0VY808yj+hR3/HeiVWHh6yjpy71X3h
PMdWDDorF+5hD0ZHX0diJ0phBjGVmw==
=3Zpy
-----END PGP SIGNATURE-----

--Sig_/A96EXYk=1Clzx6IfsDayTaq--

