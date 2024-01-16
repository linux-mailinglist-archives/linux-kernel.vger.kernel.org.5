Return-Path: <linux-kernel+bounces-28340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D34F482FD13
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 23:40:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71B031F2F8A5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 22:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 090D61F933;
	Tue, 16 Jan 2024 22:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="lxkQ+G6s"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B13D1DA50;
	Tue, 16 Jan 2024 22:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705443738; cv=none; b=FbDCA6fK6KP+x+DH2rThVwfRWGYy7YvL6V2xyE58i5dU5f47xptXAVk/Kf7bVZBxm20LXQVOHWg4wekpDtUAu1s9Taoh9ulcMsaQKHErVl2TVpY1dArwR0q0jtsHf+lSCbGnBMQAzQz22A3Zgq49lvZ03RJghP8GMc8knBTaR0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705443738; c=relaxed/simple;
	bh=P3ol08Fw41CIfzFFQooVhb0iE3Fv1ZRgddqxkDDBgGg=;
	h=DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type; b=G3XXjjFM2QFpmnWtvhIHvMcHCURrPOJczb2KkgnLFizvWK7B+bF0gy+7HQjZSCOEthFsI07+CFdTRh88yKIiYQwq2ycIC7HrQAK7XsaHXqYSc4uRlf7Fq4hJS/FwfAPkuXM9/KLFgXxiVFtjPqznCNzEk8QAHZYYCno6K7+K194=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=lxkQ+G6s; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1705443731;
	bh=AxIQOMJi6FIcABc8p8DFjfS3N7iZ0CR4Tu2qx3sFLAs=;
	h=Date:From:To:Cc:Subject:From;
	b=lxkQ+G6sqWoHvr9pwuzJeAVNYHtUK9BYGqsXPYEeYIrdHAJ5/11VUhkvS5EiPScaT
	 JVCm8S8CuKXrtjkT6a+2bUwxYfIS/Mv1jMXEv8GawzP9YwJMX8q7XJxybrsICrVPtk
	 vkktWDAOWOkafvMqnJz/6cmgQ/oaRCdbHSKDXmMZQ/rivDMCkGyRxyYzr25gMrUfV1
	 XExGCfilTnw+uWQyb4QVMo41rmwu3aLKDW6vHKPFip/mu8rCnIH3vWzk7dtOiIB2Bi
	 QWIkerNtRfbNel09XWVDixut9KeqiH1GIGxQZ9s0xg1arcmdzNTl25T7goOyqAmqtl
	 1mUfX9NDSJKaw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TF3Qq0kyGz4xP9;
	Wed, 17 Jan 2024 09:22:11 +1100 (AEDT)
Date: Wed, 17 Jan 2024 09:22:09 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Yury Norov <yury.norov@gmail.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the mm-nonmm-unstable
 branch of the mm tree
Message-ID: <20240117092209.7157a9c2@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ieYZL_P0CFftq=Ot5lzFi/N";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/ieYZL_P0CFftq=Ot5lzFi/N
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the mm tree, today's linux-next build (powerpc
ppc64_defconfig) failed like this:

In file included from include/uapi/linux/posix_types.h:5,
                 from include/uapi/linux/types.h:14,
                 from include/linux/types.h:6,
                 from include/linux/kasan-checks.h:5,
                 from include/asm-generic/rwonce.h:26,
                 from ./arch/powerpc/include/generated/asm/rwonce.h:1,
                 from include/linux/compiler.h:251,
                 from include/linux/array_size.h:5,
                 from include/linux/kernel.h:16,
                 from lib/group_cpus.c:6:
lib/group_cpus.c: In function 'group_cpus_evenly':
include/linux/stddef.h:8:14: error: invalid initializer
    8 | #define NULL ((void *)0)
      |              ^
lib/group_cpus.c:356:59: note: in expansion of macro 'NULL'
  356 |         cpumask_var_t npresmsk __free(free_cpumask_var) =3D NULL;
      |                                                           ^~~~

Caused by commit

  f004021b058f ("lib/group_cpus: fix initialization section in group_cpus_e=
venly()")

CONFIG_CPUMASK_OFFSTACK is not set for this build (so cpumask_var_t is
an single element array, not a pointer).

I applied this hack for today:

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Wed, 17 Jan 2024 09:15:07 +1100
Subject: [PATCH] fix up for "lib/group_cpus: fix initialization section in =
group_cpus_evenly()"

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 lib/group_cpus.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/lib/group_cpus.c b/lib/group_cpus.c
index c9c95b21e6c6..2c54b49d4c59 100644
--- a/lib/group_cpus.c
+++ b/lib/group_cpus.c
@@ -353,7 +353,11 @@ struct cpumask *group_cpus_evenly(unsigned int numgrps)
 {
 	cpumask_var_t *node_to_cpumask __free(free_node_to_cpumask) =3D alloc_nod=
e_to_cpumask();
 	struct cpumask *masks __free(kfree) =3D kcalloc(numgrps, sizeof(*masks), =
GFP_KERNEL);
+#ifdef CONFIG_CPUMASK_OFFSTACK
 	cpumask_var_t npresmsk __free(free_cpumask_var) =3D NULL;
+#else
+	cpumask_var_t npresmsk __free(free_cpumask_var);
+#endif
 	int curgrp, nr_present, nr_others;
=20
 	if (!masks || !node_to_cpumask || !alloc_cpumask_var(&npresmsk, GFP_KERNE=
L))
--=20
2.43.0

--=20
Cheers,
Stephen Rothwell

--Sig_/ieYZL_P0CFftq=Ot5lzFi/N
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmWnAZEACgkQAVBC80lX
0GzXmwf+JI6+3rRdCG2/ZbxzjpcItSDfA73tvA0ndNYsQrlKjzOTdmKl95Au5BaL
ZYhjfIlgXrcmS+5Kkm+cyH8bVaW6dJc6dDa2LDCpoFTUp2tY5YMc+TJMuJnBthwe
bqgEVaslkVU2qZ/7daLN9rZ0zPDlS0CQcDqQESh1jARcI7OdH64f3fLO6ZuqODHx
n12YedFA0ZYRg4LgkWTkhPI+sW9WuM2ZbSU0OOeSNuKECNnNEvISbRzEcKG7nPlQ
WyR9kVAYXoL+aAh6fQ8yhOePwnhbZlZxCAbifK3FQk16WA2Vvq8GvJ85DjDYA4Ow
BXFiokhnnDaikcXhGk3s2D8Dsobg0A==
=slum
-----END PGP SIGNATURE-----

--Sig_/ieYZL_P0CFftq=Ot5lzFi/N--

