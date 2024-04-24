Return-Path: <linux-kernel+bounces-156550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 189E48B046B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 10:35:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86A271F25B8D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 08:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 811A4156C73;
	Wed, 24 Apr 2024 08:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="cYK4eWIl"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F1A1E4A9;
	Wed, 24 Apr 2024 08:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713947712; cv=none; b=CCDsCI8NLlB3SkZOBoHfJRyWF3mB8voONbFtXi+3DCtSyRH43BFKyElEXSRvpgmgIaacyg1Stk3pndKZ6J0+s9tGYPmWFFtLQkQ8hwumSYoXo3KMDmCchpF2QNyZSJfARycE8f9arSlHnBYLsS3t2CaNppm9DgnobGoWcOlTLoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713947712; c=relaxed/simple;
	bh=D0PjB8GE2zj4HXjrQ9FCk4hXhyXnVv2CBDRAwwpXKFA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=IwxXivNDJSBicN5GOZPgWiKIf3vPeWreKXUOi9hGnicV+LO5z32foxbIy3OQImprB1XVEDavEXFi4Z+4dL5Ty0lArzIBSsLVg1H+L2oZQnsCG00s4G6spYJ/UspzDDrt+qKt1z/iCTbsQQgmzZhEAD3SsQKrGW6dXlfK04mXTBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=cYK4eWIl; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1713947706;
	bh=8StTTalxlnMb1zc1cqHQoff1rypJp3VvX0Tzv0JqIXw=;
	h=Date:From:To:Cc:Subject:From;
	b=cYK4eWIlLLM9KQwaKQkBu45/9UIlJvqtfBuFfJg8qRgdVlCDm5r5O6OXisC7TsnKt
	 ah3kBN0tOxdmnHtpbi37HRv+J2H7K9KxgpvOaKM1WtXH0PIuZ9j/lK4zCKPnvVyuHM
	 VmPAVWnNhtncbGltM/MynwQ1/8mG3EvTJZhVJs17gRR0EaK7J1NI0CrBVIBi3NDZnv
	 MaXT5/U9xgGqqxy6y4X4SaR30lTrxUUaQmpyVBsaLbqnN/chNDWtcZ42uvaBxHUDNW
	 abyNht02KppioZKlWQJ/EJHpq2lPhLAiwl727bh0Ajd49t2J906ImmFW8pNxXmXCJJ
	 kgfyyJ33oJVsg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VPXNp2hMwz4wcC;
	Wed, 24 Apr 2024 18:35:06 +1000 (AEST)
Date: Wed, 24 Apr 2024 18:35:03 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: "Mike Rapoport (IBM)" <rppt@kernel.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>, Michael Ellerman <mpe@ellerman.id.au>,
 PowerPC <linuxppc-dev@lists.ozlabs.org>
Subject: linux-next: boot failure after merge of the modules tree
Message-ID: <20240424183503.2a6ce847@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/.efID6=zWrPD=ivTQPrCikc";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/.efID6=zWrPD=ivTQPrCikc
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the modules tree, today's linux-next boot (powerpc
pseries_le_defconfig) failed like this:

BUG: Kernel NULL pointer dereference at 0x00000030
Faulting instruction address: 0xc00000000057a4ec
Oops: Kernel access of bad area, sig: 11 [#1]
LE PAGE_SIZE=3D64K MMU=3DHash SMP NR_CPUS=3D2048 NUMA pSeries
Modules linked in:
CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.9.0-rc5-08179-ga5ea707d10dc #1
Hardware name: IBM pSeries (emulated by qemu) POWER8 (raw) 0x4d0200 0xf0000=
04 of:SLOF,HEAD pSeries
NIP:  c00000000057a4ec LR: c0000000002cd32c CTR: c0000000002cd304
REGS: c000000004997700 TRAP: 0380   Not tainted  (6.9.0-rc5-08179-ga5ea707d=
10dc)
MSR:  8000000002009033 <SF,VEC,EE,ME,IR,DR,RI,LE>  CR: 84002484  XER: 20000=
000
CFAR: c0000000002cd328 IRQMASK: 0=20
GPR00: c0000000002cd32c c0000000049979a0 c00000000163a500 0000000000010000=
=20
GPR04: 0000000000010000 0000000000004000 0000000000000000 0000000000002cc0=
=20
GPR08: 0000000000000030 0000000000000100 ffffffffffffffff 0000000000002000=
=20
GPR12: c0000000002cd304 c000000002b70000 c00000000001111c 0000000000000000=
=20
GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000=
=20
GPR20: 0000000000000000 0000000000000000 0000000000000000 0000000000000000=
=20
GPR24: 0000000000000000 0000000000000000 c000000002aa0940 c0000000026c0a40=
=20
GPR28: 0000000000010000 c0000000002cd32c 0000000000000030 c0000000027d0f78=
=20
NIP [c00000000057a4ec] execmem_alloc+0x5c/0x12c
LR [c0000000002cd32c] alloc_insn_page+0x28/0x70
Call Trace:
[c000000004997a40] [c0000000002cd32c] alloc_insn_page+0x28/0x70
[c000000004997a60] [c0000000002d07a4] __get_insn_slot+0x1cc/0x29c
[c000000004997aa0] [c00000000005c434] arch_prepare_kprobe+0xbc/0x31c
[c000000004997b20] [c0000000002d1b40] register_kprobe+0x54c/0x878
[c000000004997b90] [c000000002018828] arch_init_kprobes+0x28/0x40
[c000000004997bb0] [c00000000204b33c] init_kprobes+0x138/0x218
[c000000004997c30] [c000000000010da8] do_one_initcall+0x80/0x2f8
[c000000004997d00] [c000000002005aa8] kernel_init_freeable+0x1f8/0x520
[c000000004997de0] [c000000000011148] kernel_init+0x34/0x26c
[c000000004997e50] [c00000000000debc] ret_from_kernel_user_thread+0x14/0x1c
--- interrupt: 0 at 0x0
Code: fbe1fff8 3940ffff 38e02cc0 7c9c2378 7fa802a6 e8c91e48 f8010010 fb41ff=
d0 39200100 fb61ffd8 f821ff61 7fc64214 <7ca6402a> eb5e0020 837e0028 e8de000=
8=20
---[ end trace 0000000000000000 ]---

note: swapper/0[1] exited with irqs disabled
Kernel panic - not syncing: Attempted to kill init! exitcode=3D0x0000000b

Bisected to commit

  18da532eefc8 ("mm/execmem, arch: convert remaining overrides of module_al=
loc to execmem")

I have used the modules tree from next-20240423 for today.

This is a qemu boot test using:

qemu-system-ppc64 -M pseries -cpu POWER8 -m 2G -vga none -nographic -kernel=
 ~/next/powerpc_pseries_le_defconfig/vmlinux -initrd ./ppc64le-rootfs.cpio.=
gz

--=20
Cheers,
Stephen Rothwell

--Sig_/.efID6=zWrPD=ivTQPrCikc
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmYoxDcACgkQAVBC80lX
0GzQcwf/U40DU/cscWGcfGCeC2vL0Xp+EnBRAoPvjcF86HoyYNI5yNGHDkOXWwTz
0E76CpgC7w+XmHqLxZx+jz+eiZnB1u0AP8GtYJb2wOB4ZdkTdH7BZUDYfJ6AgtiJ
rapL1zQmyNr+T8vU1M2pPlz9t645s72o11jJgD04dPh+em8sb7kbNLy49kGcUTMI
sNI6+yOhjT9SX6Zg37+wt8QnV0NHY6ihGO2og2nofmxE/tW/W8s2qiT16/rIAQco
/813SuBm1ekdSQT1/fD3+mqJwk7C58tRkaOzbEe36z9uJaPNJJs4xD4UAeEuROqn
EQgitQ3uM2+A8MWfypdyKqIsm3sG/w==
=UlUt
-----END PGP SIGNATURE-----

--Sig_/.efID6=zWrPD=ivTQPrCikc--

