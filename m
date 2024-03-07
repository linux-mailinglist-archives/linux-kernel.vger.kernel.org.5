Return-Path: <linux-kernel+bounces-94835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C55B98745BE
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 02:41:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AFBC1F2450A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 01:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FEBD5695;
	Thu,  7 Mar 2024 01:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="IrSkWBj7"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81FD6320E;
	Thu,  7 Mar 2024 01:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709775644; cv=none; b=tbRKTqMODgwXQ1ZppvCWDWki86KtVo1Psu/ZImRBBDVa/pKveH51+/XrvEYFPLJTG0KTDoW2/XbVsHf4JdThDgWRfdkL8hcBzIhlOPzxiOYhqZ83R+rP8OW80Wm0MKctIp7SBIHmRISUE/NcXcqi6JY33R41tSrjhKOTqFt3fGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709775644; c=relaxed/simple;
	bh=Lo9iz+n9edm3o53h72vU/6OxtqAKFhQ+PPqRU6+UL/8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=DE0Qc2mm0BuWPK2RljHTqQuvDcFLRzCeGJdzHn4sl7Ie9N8kf/360jpXMDd3801rC0+P06kowe5uhTbeKDsar3xxtAdOv1IUri2I+dpYpOQ2k+o2En7g9F4x6pJ5toufyKono2GP3t0BZunhEDry0WjdsGOtZSGWfAJVa3wkyM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=IrSkWBj7; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1709775641;
	bh=T/j2tECYmvWyYhRQzO6iM6NxszqMwlNlx0r9oi+lhHA=;
	h=Date:From:To:Cc:Subject:From;
	b=IrSkWBj7sq6MnNLa1BtDPXvkU7O/2wn8lp1Bj0avzfsosMzV5MhEa1ORbGbYdlWS5
	 VOxZS9llx7QWnI65QFqxFGdY0ZtIQsTWG9hax2uwNxGdAl3WQ+PQcEmHfqf8DCd14Q
	 4HZs7/d1qO8y4++WBGfMyHlhh29YVQo0+HN4A/ApBJ8arWDfCsF0xSkSyB4iriSeIt
	 /xwutvofqnw0AMG7cJG2jffYOwp/Envrvqi1Uligbtoxabo9FME4qHJ4CX6pSO314d
	 lIsQZQlH7mL9VzeZVKkTsPMjUAdJpR624n8/OtCzEKPqxWhfdobImX4ImAMYs8k5s1
	 pVvnHyL+LmJrA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TqsSm59d9z4wcK;
	Thu,  7 Mar 2024 12:40:40 +1100 (AEDT)
Date: Thu, 7 Mar 2024 12:40:40 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov
 <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, Networking <netdev@vger.kernel.org>, Eduard
 Zingerman <eddyz87@gmail.com>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the bpf-next tree with the bpf tree
Message-ID: <20240307124040.1a177b71@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/I9j87X6ApN8PS6sC_1mfoKA";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/I9j87X6ApN8PS6sC_1mfoKA
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the bpf-next tree got a conflict in:

  tools/testing/selftests/bpf/progs/verifier_iterating_callbacks.c

between commit:

  5c2bc5e2f81d ("selftests/bpf: test case for callback_depth states pruning=
 logic")

from the bpf tree and commit:

  0c8bbf990bdd ("selftests/bpf: Test may_goto")

from the bpf-next tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc tools/testing/selftests/bpf/progs/verifier_iterating_callbacks.c
index a955a6358206,04cdbce4652f..000000000000
--- a/tools/testing/selftests/bpf/progs/verifier_iterating_callbacks.c
+++ b/tools/testing/selftests/bpf/progs/verifier_iterating_callbacks.c
@@@ -239,74 -237,103 +237,173 @@@ int bpf_loop_iter_limit_nested(void *un
  	return 1000 * a + b + c;
  }
 =20
 +struct iter_limit_bug_ctx {
 +	__u64 a;
 +	__u64 b;
 +	__u64 c;
 +};
 +
 +static __naked void iter_limit_bug_cb(void)
 +{
 +	/* This is the same as C code below, but written
 +	 * in assembly to control which branches are fall-through.
 +	 *
 +	 *   switch (bpf_get_prandom_u32()) {
 +	 *   case 1:  ctx->a =3D 42; break;
 +	 *   case 2:  ctx->b =3D 42; break;
 +	 *   default: ctx->c =3D 42; break;
 +	 *   }
 +	 */
 +	asm volatile (
 +	"r9 =3D r2;"
 +	"call %[bpf_get_prandom_u32];"
 +	"r1 =3D r0;"
 +	"r2 =3D 42;"
 +	"r0 =3D 0;"
 +	"if r1 =3D=3D 0x1 goto 1f;"
 +	"if r1 =3D=3D 0x2 goto 2f;"
 +	"*(u64 *)(r9 + 16) =3D r2;"
 +	"exit;"
 +	"1: *(u64 *)(r9 + 0) =3D r2;"
 +	"exit;"
 +	"2: *(u64 *)(r9 + 8) =3D r2;"
 +	"exit;"
 +	:
 +	: __imm(bpf_get_prandom_u32)
 +	: __clobber_all
 +	);
 +}
 +
 +SEC("tc")
 +__failure
 +__flag(BPF_F_TEST_STATE_FREQ)
 +int iter_limit_bug(struct __sk_buff *skb)
 +{
 +	struct iter_limit_bug_ctx ctx =3D { 7, 7, 7 };
 +
 +	bpf_loop(2, iter_limit_bug_cb, &ctx, 0);
 +
 +	/* This is the same as C code below,
 +	 * written in assembly to guarantee checks order.
 +	 *
 +	 *   if (ctx.a =3D=3D 42 && ctx.b =3D=3D 42 && ctx.c =3D=3D 7)
 +	 *     asm volatile("r1 /=3D 0;":::"r1");
 +	 */
 +	asm volatile (
 +	"r1 =3D *(u64 *)%[ctx_a];"
 +	"if r1 !=3D 42 goto 1f;"
 +	"r1 =3D *(u64 *)%[ctx_b];"
 +	"if r1 !=3D 42 goto 1f;"
 +	"r1 =3D *(u64 *)%[ctx_c];"
 +	"if r1 !=3D 7 goto 1f;"
 +	"r1 /=3D 0;"
 +	"1:"
 +	:
 +	: [ctx_a]"m"(ctx.a),
 +	  [ctx_b]"m"(ctx.b),
 +	  [ctx_c]"m"(ctx.c)
 +	: "r1"
 +	);
 +	return 0;
 +}
 +
+ #define ARR_SZ 1000000
+ int zero;
+ char arr[ARR_SZ];
+=20
+ SEC("socket")
+ __success __retval(0xd495cdc0)
+ int cond_break1(const void *ctx)
+ {
+ 	unsigned long i;
+ 	unsigned int sum =3D 0;
+=20
+ 	for (i =3D zero; i < ARR_SZ; cond_break, i++)
+ 		sum +=3D i;
+ 	for (i =3D zero; i < ARR_SZ; i++) {
+ 		barrier_var(i);
+ 		sum +=3D i + arr[i];
+ 		cond_break;
+ 	}
+=20
+ 	return sum;
+ }
+=20
+ SEC("socket")
+ __success __retval(999000000)
+ int cond_break2(const void *ctx)
+ {
+ 	int i, j;
+ 	int sum =3D 0;
+=20
+ 	for (i =3D zero; i < 1000; cond_break, i++)
+ 		for (j =3D zero; j < 1000; j++) {
+ 			sum +=3D i + j;
+ 			cond_break;
+ 		}
+=20
+ 	return sum;
+ }
+=20
+ static __noinline int loop(void)
+ {
+ 	int i, sum =3D 0;
+=20
+ 	for (i =3D zero; i <=3D 1000000; i++, cond_break)
+ 		sum +=3D i;
+=20
+ 	return sum;
+ }
+=20
+ SEC("socket")
+ __success __retval(0x6a5a2920)
+ int cond_break3(const void *ctx)
+ {
+ 	return loop();
+ }
+=20
+ SEC("socket")
+ __success __retval(1)
+ int cond_break4(const void *ctx)
+ {
+ 	int cnt =3D zero;
+=20
+ 	for (;;) {
+ 		/* should eventually break out of the loop */
+ 		cond_break;
+ 		cnt++;
+ 	}
+ 	/* if we looped a bit, it's a success */
+ 	return cnt > 1 ? 1 : 0;
+ }
+=20
+ static __noinline int static_subprog(void)
+ {
+ 	int cnt =3D zero;
+=20
+ 	for (;;) {
+ 		cond_break;
+ 		cnt++;
+ 	}
+=20
+ 	return cnt;
+ }
+=20
+ SEC("socket")
+ __success __retval(1)
+ int cond_break5(const void *ctx)
+ {
+ 	int cnt1 =3D zero, cnt2;
+=20
+ 	for (;;) {
+ 		cond_break;
+ 		cnt1++;
+ 	}
+=20
+ 	cnt2 =3D static_subprog();
+=20
+ 	/* main and subprog have to loop a bit */
+ 	return cnt1 > 1 && cnt2 > 1 ? 1 : 0;
+ }
+=20
  char _license[] SEC("license") =3D "GPL";

--Sig_/I9j87X6ApN8PS6sC_1mfoKA
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmXpGxgACgkQAVBC80lX
0GyK+wf9GeKO29jQCn5GcUD1Y0Q9Ea6t3msOMQzBJh7hfCFniqOSxb08dYLj2uVc
hLfU2MUZUTh1C5YDcU/DB7LGVfILtTmSev44Pjm1DzPFyKdv4fHSFofPR3xbd/VN
S5HN7NxADM6vBGdEHOiWvXK5w0YmFthTpf/U3CHXuzhGJ7FZ7IhHIPkTeoEDsv9g
muxjtMv4pok3Idzi9HJwBpiEYYgRvOO67gj92cJEFHv157swkQ9b9geoMVqqJbmy
i2u0yY3KRwpu0r5t9GinXbfdtOQk6gVj/a1Pe1uF0pOp4Tlj5yXl1NGJVJa1vZQQ
7ADXFlIzPTSUoMmV9M1HbwQ4xydJ7g==
=HtY4
-----END PGP SIGNATURE-----

--Sig_/I9j87X6ApN8PS6sC_1mfoKA--

