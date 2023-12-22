Return-Path: <linux-kernel+bounces-9200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 27A2681C240
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 01:17:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E5191F25BF6
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 00:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ECED631;
	Fri, 22 Dec 2023 00:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="FdXNL8ZP"
X-Original-To: linux-kernel@vger.kernel.org
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 719BD375;
	Fri, 22 Dec 2023 00:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1703204211;
	bh=1JsxQjtT1/vQ1gEdjO4PMMXq/CHcQ5f3Oy1hSXOOcsw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FdXNL8ZPhnzXz4uNpww3wbPmR4j23S4TK2QsN+h+qFRyur5hN39kNGCKyC/dO+acL
	 5qOnJx/w7dq2CuDM5L62M+6VAsdL++DSnUe/G4EOBM1maQKG/QFgK18HGqA6YS+5mz
	 jOzMSw1GmQ2SfmiO7nV8xyWKxWPSmE4w6W1LDlxp8bUHsvKpaRYvb/resL3iofWuTY
	 LIrJGCwhqKOmulBF8U/ICWtNlaOxuXH7/bZlIKulAJ/5VQSeN+oOJpPv3f6R/4opyz
	 j5TLIrgXKf7MMyYQhRFEzd4naob+H62IhnshRtc+8lsHEUBBgoPSVDXiyfAibqocqS
	 1LFmr07rurH+g==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Sx7C64jmNz4wbp;
	Fri, 22 Dec 2023 11:16:50 +1100 (AEDT)
Date: Fri, 22 Dec 2023 11:16:49 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the mm tree
Message-ID: <20231222111649.7802e7d7@canb.auug.org.au>
In-Reply-To: <20231127144418.54daad5d@canb.auug.org.au>
References: <20231127144418.54daad5d@canb.auug.org.au>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/N_O+YR9S.mjrjz0.HzMV6lY";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/N_O+YR9S.mjrjz0.HzMV6lY
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Mon, 27 Nov 2023 14:44:18 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> After merging the mm tree, today's linux-next build (sparc64 defconfig)
> failed like this:
>=20
> arch/sparc/vdso/vclock_gettime.c:254:1: warning: no previous prototype fo=
r '__vdso_clock_gettime' [-Wmissing-prototypes]
>   254 | __vdso_clock_gettime(clockid_t clock, struct __kernel_old_timespe=
c *ts)
>       | ^~~~~~~~~~~~~~~~~~~~
> arch/sparc/vdso/vclock_gettime.c:282:1: warning: no previous prototype fo=
r '__vdso_clock_gettime_stick' [-Wmissing-prototypes]
>   282 | __vdso_clock_gettime_stick(clockid_t clock, struct __kernel_old_t=
imespec *ts)
>       | ^~~~~~~~~~~~~~~~~~~~~~~~~~
> arch/sparc/vdso/vclock_gettime.c:307:1: warning: no previous prototype fo=
r '__vdso_gettimeofday' [-Wmissing-prototypes]
>   307 | __vdso_gettimeofday(struct __kernel_old_timeval *tv, struct timez=
one *tz)
>       | ^~~~~~~~~~~~~~~~~~~
> arch/sparc/vdso/vclock_gettime.c:343:1: warning: no previous prototype fo=
r '__vdso_gettimeofday_stick' [-Wmissing-prototypes]
>   343 | __vdso_gettimeofday_stick(struct __kernel_old_timeval *tv, struct=
 timezone *tz)
>       | ^~~~~~~~~~~~~~~~~~~~~~~~~
> arch/sparc/vdso/vma.c:246:12: warning: no previous prototype for 'init_vd=
so_image' [-Wmissing-prototypes]
>   246 | int __init init_vdso_image(const struct vdso_image *image,
>       |            ^~~~~~~~~~~~~~~
> arch/sparc/prom/p1275.c:52:6: warning: no previous prototype for 'prom_ci=
f_init' [-Wmissing-prototypes]
>    52 | void prom_cif_init(void *cif_handler, void *cif_stack)
>       |      ^~~~~~~~~~~~~
> In file included from arch/sparc/vdso/vdso32/vclock_gettime.c:22:
> arch/sparc/vdso/vdso32/../vclock_gettime.c:254:1: warning: no previous pr=
ototype for '__vdso_clock_gettime' [-Wmissing-prototypes]
>   254 | __vdso_clock_gettime(clockid_t clock, struct __kernel_old_timespe=
c *ts)
>       | ^~~~~~~~~~~~~~~~~~~~
> arch/sparc/vdso/vdso32/../vclock_gettime.c:282:1: warning: no previous pr=
ototype for '__vdso_clock_gettime_stick' [-Wmissing-prototypes]
>   282 | __vdso_clock_gettime_stick(clockid_t clock, struct __kernel_old_t=
imespec *ts)
>       | ^~~~~~~~~~~~~~~~~~~~~~~~~~
> arch/sparc/vdso/vdso32/../vclock_gettime.c:307:1: warning: no previous pr=
ototype for '__vdso_gettimeofday' [-Wmissing-prototypes]
>   307 | __vdso_gettimeofday(struct __kernel_old_timeval *tv, struct timez=
one *tz)
>       | ^~~~~~~~~~~~~~~~~~~
> arch/sparc/vdso/vdso32/../vclock_gettime.c:343:1: warning: no previous pr=
ototype for '__vdso_gettimeofday_stick' [-Wmissing-prototypes]
>   343 | __vdso_gettimeofday_stick(struct __kernel_old_timeval *tv, struct=
 timezone *tz)
>       | ^~~~~~~~~~~~~~~~~~~~~~~~~
> arch/sparc/prom/misc_64.c:165:5: warning: no previous prototype for 'prom=
_get_mmu_ihandle' [-Wmissing-prototypes]
>   165 | int prom_get_mmu_ihandle(void)
>       |     ^~~~~~~~~~~~~~~~~~~~
> arch/sparc/kernel/traps_64.c:253:6: error: no previous prototype for 'is_=
no_fault_exception' [-Werror=3Dmissing-prototypes]
>   253 | bool is_no_fault_exception(struct pt_regs *regs)
>       |      ^~~~~~~~~~~~~~~~~~~~~
> arch/sparc/kernel/traps_64.c:2035:6: error: no previous prototype for 'do=
_mcd_err' [-Werror=3Dmissing-prototypes]
>  2035 | void do_mcd_err(struct pt_regs *regs, struct sun4v_error_entry en=
t)
>       |      ^~~~~~~~~~
> arch/sparc/kernel/traps_64.c:2153:6: error: no previous prototype for 'su=
n4v_nonresum_error_user_handled' [-Werror=3Dmissing-prototypes]
>  2153 | bool sun4v_nonresum_error_user_handled(struct pt_regs *regs,
>       |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> cc1: all warnings being treated as errors
> arch/sparc/mm/init_64.c:2644:6: error: no previous prototype for 'vmemmap=
_free' [-Werror=3Dmissing-prototypes]
>  2644 | void vmemmap_free(unsigned long start, unsigned long end,
>       |      ^~~~~~~~~~~~
> cc1: all warnings being treated as errors
>=20
> Caused by commit
>=20
>   c6345dfa6e3e ("Makefile.extrawarn: turn on missing-prototypes globally")
>=20
> I applied the following hack for today.
>=20
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Mon, 27 Nov 2023 14:18:45 +1100
> Subject: [PATCH] sparc: turn off Werror for now
>=20
> ---
>  arch/sparc/kernel/Makefile | 2 +-
>  arch/sparc/mm/Makefile     | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/sparc/kernel/Makefile b/arch/sparc/kernel/Makefile
> index 0984bb6f0f17..1ce4d5028c86 100644
> --- a/arch/sparc/kernel/Makefile
> +++ b/arch/sparc/kernel/Makefile
> @@ -5,7 +5,7 @@
>  #
> =20
>  asflags-y :=3D -ansi
> -ccflags-y :=3D -Werror
> +#ccflags-y :=3D -Werror
> =20
>  # Undefine sparc when processing vmlinux.lds - it is used
>  # And teach CPP we are doing $(BITS) builds (for this case)
> diff --git a/arch/sparc/mm/Makefile b/arch/sparc/mm/Makefile
> index 871354aa3c00..a199484e131f 100644
> --- a/arch/sparc/mm/Makefile
> +++ b/arch/sparc/mm/Makefile
> @@ -3,7 +3,7 @@
>  #
> =20
>  asflags-y :=3D -ansi
> -ccflags-y :=3D -Werror
> +#ccflags-y :=3D -Werror
> =20
>  obj-$(CONFIG_SPARC64)   +=3D ultra.o tlb.o tsb.o
>  obj-y                   +=3D fault_$(BITS).o
> --=20
> 2.40.1
>=20
> After which I got these as well:
>=20
> arch/sparc/kernel/adi_64.c:124:21: warning: no previous prototype for 'fi=
nd_tag_store' [-Wmissing-prototypes]
>   124 | tag_storage_desc_t *find_tag_store(struct mm_struct *mm,
>       |                     ^~~~~~~~~~~~~~
> arch/sparc/kernel/adi_64.c:156:21: warning: no previous prototype for 'al=
loc_tag_store' [-Wmissing-prototypes]
>   156 | tag_storage_desc_t *alloc_tag_store(struct mm_struct *mm,
>       |                     ^~~~~~~~~~~~~~~
> arch/sparc/kernel/adi_64.c:299:6: warning: no previous prototype for 'del=
_tag_store' [-Wmissing-prototypes]
>   299 | void del_tag_store(tag_storage_desc_t *tag_desc, struct mm_struct=
 *mm)
>       |      ^~~~~~~~~~~~~
> arch/sparc/kernel/uprobes.c:237:17: warning: no previous prototype for 'u=
probe_trap' [-Wmissing-prototypes]
>   237 | asmlinkage void uprobe_trap(struct pt_regs *regs,
>       |                 ^~~~~~~~~~~
> arch/sparc/kernel/time_64.c:880:20: warning: no previous prototype for 's=
ched_clock' [-Wmissing-prototypes]
>   880 | unsigned long long sched_clock(void)
>       |                    ^~~~~~~~~~~
> arch/sparc/kernel/pci_sun4v.c:259:15: warning: no previous prototype for =
'dma_4v_iotsb_bind' [-Wmissing-prototypes]
>   259 | unsigned long dma_4v_iotsb_bind(unsigned long devhandle,
>       |               ^~~~~~~~~~~~~~~~~
> arch/sparc/kernel/setup_64.c:602:13: warning: no previous prototype for '=
alloc_irqstack_bootmem' [-Wmissing-prototypes]
>   602 | void __init alloc_irqstack_bootmem(void)
>       |             ^~~~~~~~~~~~~~~~~~~~~~
>=20
> And these from the sparc (32) defconfig build:
>=20
> arch/sparc/lib/cmpdi2.c:6:11: error: no previous prototype for '__cmpdi2'=
 [-Werror=3Dmissing-prototypes]
>     6 | word_type __cmpdi2(long long a, long long b)
>       |           ^~~~~~~~
> cc1: all warnings being treated as errors
> kernel/dma.c:70:5: warning: no previous prototype for 'request_dma' [-Wmi=
ssing-prototypes]
>    70 | int request_dma(unsigned int dmanr, const char * device_id)
>       |     ^~~~~~~~~~~
> kernel/dma.c:88:6: warning: no previous prototype for 'free_dma' [-Wmissi=
ng-prototypes]
>    88 | void free_dma(unsigned int dmanr)
>       |      ^~~~~~~~
>=20
> So I turned off -Werrror in the lib directory as well which added this:
>=20
> arch/sparc/lib/ucmpdi2.c:5:11: warning: no previous prototype for '__ucmp=
di2' [-Wmissing-prototypes]
>     5 | word_type __ucmpdi2(unsigned long long a, unsigned long long b)
>       |           ^~~~~~~~~

Is anything being done about the above warnings?
--=20
Cheers,
Stephen Rothwell

--Sig_/N_O+YR9S.mjrjz0.HzMV6lY
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmWE1XEACgkQAVBC80lX
0GzG4Qf9GktuYErI+AP3R/f5obZ8hkM4QDRjyBXZ1eS/D7b6tPPUY686Z+DDCTgA
LdZMFlcN6xHsxrGv0qA4307CiRczeqkbcM9EmZPvB1slWlCI/s7QK1f6j1wr6Jci
ACXvlQj8taIDHtm7f8iWMSuQFlWk2vVB3hFCySd4sg8bl8IifmE+IPQjMqYqwp8c
NwC8kwyOnjyA8h6PfCc8P1c4oe42/81sJxYJzSgKy26DlMMXwXKwinvlME1I7F9q
zdXLxqVoaEvH9J/n63z3/Ghj8riZ06b+ZYfCUflikQlv338CYcIhBtriujzTQaK4
CGBCYzAUWm/YyGn0+q6XrR2vCKLDZw==
=7xpq
-----END PGP SIGNATURE-----

--Sig_/N_O+YR9S.mjrjz0.HzMV6lY--

