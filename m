Return-Path: <linux-kernel+bounces-150864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69B3E8AA5DE
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 01:32:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 238D12831D7
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 23:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9815976037;
	Thu, 18 Apr 2024 23:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="mr32p6JA"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808A64A20;
	Thu, 18 Apr 2024 23:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713483149; cv=none; b=Ll5twSuwFncA8pAOOiUtMihfH5TdumhWjqz+jFKyoA7mUD0z9TFnjRmMKa7udu9Vy9yW7qRIfCKjmdxxWQ3XvTI91IkNDgEZ/2ANiLDCtdZmd5qiVGjDtYwYImzEIoGkVNVtAITdQm/gymvtqCavCpyEm1Ms/wu5omwaqg3nhTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713483149; c=relaxed/simple;
	bh=EYZS2H6fzPOlRgIXVoWWJKSUl39I+Z1L0VjK4QxzVJA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=P7qYKjp8ajufHjtUgY5lY748hgxvgdSr6tJD83PvJb1xxlwoFFXIiGEOF+ZVco5sX1dhs906xyZ4xN3KqDlx4WBakEKIkwLbVDKedfSElXMxM1pdDt/8wyqYW2hmnaa897Y2TxHB6hDYOdsWkLUY8hEgSUmFjf4hO/rxQL1oge0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=mr32p6JA; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1713483144;
	bh=R1/1szuT9hPMtMvkuBptcn8TSH/pfi2IMvhJaAia4Co=;
	h=Date:From:To:Cc:Subject:From;
	b=mr32p6JAyv4SxDo+9936crZYbf6KovnjXyG0Q17ypYhxbMDraLPtem01lORtrhaK/
	 k72ummFSUpMcC3KbxHeaosI7IculQV30BCEj8VliL6fEObNUp9qIpeZaEd3P23/aBr
	 33IoXhv3AaH7jQ1Yuxe5yapkLoZLw7tYC91Z/s1DfsF5OXaCXTmjrYr/ZUZ/uZd6bm
	 /Uu1SJ+EgD19Vteke5FpF6pSJabPjNc76DQ0C2RVi4kUIhfNqDGjHwrGaX+ShGnzIl
	 Dze55dlgakEoMLce6l9dBApXGw1Vr2n+J43FNKOZpDpF1z9Y7ECp7JJaPoxELB72Vr
	 zFoYLIhDqVtcw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VLDZv0jPMz4wyq;
	Fri, 19 Apr 2024 09:32:23 +1000 (AEST)
Date: Fri, 19 Apr 2024 09:32:22 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andrew Morton <akpm@linux-foundation.org>, David Miller
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>
Cc: Edward Liaw <edliaw@google.com>, Networking <netdev@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next
 Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the mm-hotfixes tree with Linus' tree
Message-ID: <20240419093222.5a901a84@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Lo7x+b/tFAF1roENO8l.nWi";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/Lo7x+b/tFAF1roENO8l.nWi
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the mm-hotfixes tree got a conflict in:

  tools/testing/selftests/kselftest_harness.h

between commit:

  caed8eba2215 ("selftests: kselftest_harness: fix Clang warning about zero=
-length format")

from Linus' tree and commit:

  52124c13ec1f ("selftests/harness: remove use of LINE_MAX")

from the mm-hotfixes-unstable branch of the mm-hotfixes tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc tools/testing/selftests/kselftest_harness.h
index ba3ddeda24bf,f0ae1f6466db..000000000000
--- a/tools/testing/selftests/kselftest_harness.h
+++ b/tools/testing/selftests/kselftest_harness.h
@@@ -1205,7 -1205,8 +1208,8 @@@ void __run_test(struct __fixture_metada
  		diagnostic =3D "unknown";
 =20
  	ksft_test_result_code(t->exit_code, test_name,
 -			      diagnostic ? "%s" : "", diagnostic);
 +			      diagnostic ? "%s" : NULL, diagnostic);
+ 	free(test_name);
  }
 =20
  static int test_harness_run(int argc, char **argv)

--Sig_/Lo7x+b/tFAF1roENO8l.nWi
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmYhrYYACgkQAVBC80lX
0GxIXAf9GkUydFR4L+GRsO3dV79ZUMzgzwRca1uFwzNSaJkaO54D90SFXWhPecod
1NY7M72Lg9cNT6PqpO6xQ9zPnWjdWlU1fAdZMuZx+Li/MFzmnqBW4S73F1q6HhCx
LikcWI939KGsPG9uBbQ0lxQnG+JBNNp+z7Wny3ypLxOp5e2oqFkySwzWFgv+BS+x
vH9a+BAuBXOzZv/a3heyAmOLx9sNzOAT0HFRnUrEb+dSAVH0wLD9uAdXqCbBQpgd
WtcsCPewuKXVXnKd6GLelrG78GhhED/ezFejgxzDSrJCpcWGISzLO2lR7V7ijIRB
x8POmTps9e6xUxr+8xAYqA9cFrYtuw==
=wSr3
-----END PGP SIGNATURE-----

--Sig_/Lo7x+b/tFAF1roENO8l.nWi--

