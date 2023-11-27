Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF7277F9802
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 04:48:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231909AbjK0Dsu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 22:48:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjK0Dss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 22:48:48 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 012F1127;
        Sun, 26 Nov 2023 19:48:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1701056933;
        bh=xDZKSlzh1/UCfSWZwMAP6iEXsWt5FFryCFfldIgRDvM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tq93Kuo33izvLI6GbhYWWx5Ia6NAAoD3hBp9dEPcUCYATgIfb9agy/7CueloQpLu3
         gHrLDRCrAebicnW4a+sFrH9U0rjM9jOgirIPng00QJD7JlfXMPC8LVt2KGV4rtZziu
         /MyP/uaZy2XREwjPURXMecVh/lIETFw4KrVpknXPLoPVRZyDrzv3eAsQ2PucYbX8WS
         lHbLA9tiG6FMRAOBm0zmpYMUPAc1itaGiR4A7aoRVg1h0pBU9lLA1bI1uVTslL5RQh
         MFVzulnEAitK6bDbE3vNqo8lfVd2Z4/V/kAF2XcqsmSu6XHG4BBcN+PlIu3ZAV+LRA
         7D7yIe3iAv17Q==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Sds5K2g9nz4wbr;
        Mon, 27 Nov 2023 14:48:53 +1100 (AEDT)
Date:   Mon, 27 Nov 2023 14:48:52 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        PowerPC <linuxppc-dev@lists.ozlabs.org>
Subject: Re: linux-next: build failure after merge of the mm tree
Message-ID: <20231127144852.069b2e7e@canb.auug.org.au>
In-Reply-To: <20231127132809.45c2b398@canb.auug.org.au>
References: <20231127132809.45c2b398@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/1OxpgZpOL2DDzmvOW3C.v.M";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/1OxpgZpOL2DDzmvOW3C.v.M
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Just cc'ing the PowerPC guys to see if my fix is sensible.

On Mon, 27 Nov 2023 13:28:09 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> After merging the mm tree, today's linux-next build (powerpc64
> allnoconfig) failed like this:
>=20
> arch/powerpc/mm/book3s64/pgtable.c:557:5: error: no previous prototype fo=
r 'pmd_move_must_withdraw' [-Werror=3Dmissing-prototypes]
>   557 | int pmd_move_must_withdraw(struct spinlock *new_pmd_ptl,
>       |     ^~~~~~~~~~~~~~~~~~~~~~
> cc1: all warnings being treated as errors
>=20
> Caused by commit
>=20
>   c6345dfa6e3e ("Makefile.extrawarn: turn on missing-prototypes globally")
>=20
> I have added the following patch for today (which could be applied to
> the mm or powerpc trees):
>=20
> From 194805b44c11b4c0aa28bdcdc0bb0d82acef394c Mon Sep 17 00:00:00 2001
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Mon, 27 Nov 2023 13:08:57 +1100
> Subject: [PATCH] powerpc: pmd_move_must_withdraw() is only needed for
>  CONFIG_TRANSPARENT_HUGEPAGE
>=20
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  arch/powerpc/mm/book3s64/pgtable.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/arch/powerpc/mm/book3s64/pgtable.c b/arch/powerpc/mm/book3s6=
4/pgtable.c
> index be229290a6a7..3438ab72c346 100644
> --- a/arch/powerpc/mm/book3s64/pgtable.c
> +++ b/arch/powerpc/mm/book3s64/pgtable.c
> @@ -542,6 +542,7 @@ void ptep_modify_prot_commit(struct vm_area_struct *v=
ma, unsigned long addr,
>  	set_pte_at(vma->vm_mm, addr, ptep, pte);
>  }
> =20
> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
>  /*
>   * For hash translation mode, we use the deposited table to store hash s=
lot
>   * information and they are stored at PTRS_PER_PMD offset from related p=
md
> @@ -563,6 +564,7 @@ int pmd_move_must_withdraw(struct spinlock *new_pmd_p=
tl,
> =20
>  	return true;
>  }
> +#endif
> =20
>  /*
>   * Does the CPU support tlbie?
> --=20
> 2.40.1

--=20
Cheers,
Stephen Rothwell

--Sig_/1OxpgZpOL2DDzmvOW3C.v.M
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmVkEaQACgkQAVBC80lX
0Gx3Uwf/eggLiBT0CMRtGTvKcImnVpzRYOstDC8af1O5yiQc2pfZeP1h5aG+DXTw
eT/PR/kTiL3zK9pywiKe3a2wJu0UN/QZinW/7Mk/xJf3L8JHGUu+fyAaVjBKqjm9
Ze+PH6AACdmi84DkTzOKmkLZR7AauuyKyuDbltPMrga6zsex0/shCRHRxjs3aGQu
x+4eeWsjx2Pf24kUHrQ8f44+5cJZ+A9Vjzh99cJvycepd3GJEoTohBEPoda0NFCD
xIGHUDC1B/dNuxzaGYkYy6jqYWtk/cjJOI/I3KvzYubPQwr3m7OVhe4EI11IyvSR
kpoHYFK6c3LJ3LNWRf5SWFs3mS6+gA==
=N35d
-----END PGP SIGNATURE-----

--Sig_/1OxpgZpOL2DDzmvOW3C.v.M--
