Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 786BA766042
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 01:29:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbjG0X3W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 19:29:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjG0X3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 19:29:20 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C67319B;
        Thu, 27 Jul 2023 16:29:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1690500557;
        bh=Lzz7Vvn33Y6HZLNczNaF1kmpu6iCoQiPcrxkidWIRT4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=N3eB6xuu3xFRLuI3pgO5q3I6xwYv5DO2VhW5zloB/5WwY20a2MHd+S6xhjGR8g0TY
         cjaug3aJyreGoi0m6KJAf2HZGxQ6grILoWjXNsi6mqMRIgxfwnVdtn+8NP8e5wTGkV
         nBz89OAac00CdjRyemM/Mdlx1vKuBOvAlPUMklv75nM/7cGwRCN75coJiHsmOXrXoM
         cCcmk0LkpFnzNHQE6xWvHtQ05aDCvnKCh8Gr1b4Jr8ctXO8hPBHiZHwBabCoqqKBB/
         i2Ta6TFRvqGhNmTr+MH2SXUVqV6SuTwcS60konsmwMz6PLSjpBwnmi+n9pZ5/bwjUW
         RTkrgIt8Kq0Vw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RBn64556Jz4wqW;
        Fri, 28 Jul 2023 09:29:16 +1000 (AEST)
Date:   Fri, 28 Jul 2023 09:29:15 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Jann Horn <jannh@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: linux-next: manual merge of the mm tree with Linus' tree
Message-ID: <20230728092915.732d4115@canb.auug.org.au>
In-Reply-To: <20230728091849.7f32259d@canb.auug.org.au>
References: <20230728091849.7f32259d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/NFQ9DE+V61/f+Ow9PDrTCgX";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/NFQ9DE+V61/f+Ow9PDrTCgX
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Fri, 28 Jul 2023 09:18:49 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> Today's linux-next merge of the mm tree got a conflict in:
>=20
>   mm/memory.c
>=20
> between commit:
>=20
>   657b5146955e ("mm: lock_vma_under_rcu() must check vma->anon_vma under =
vma lock")
>=20
> from Linus' tree and commits:
>=20
>   69f6bbd1317f ("mm: handle userfaults under VMA lock")
>   a3bdf38e85aa ("mm: allow per-VMA locks on file-backed VMAs")
>=20
> from the mm tree.
>=20
> I fixed it up (I think, please check - see below) and can carry the fix
> as necessary. This is now fixed as far as linux-next is concerned, but
> any non trivial conflicts should be mentioned to your upstream
> maintainer when your tree is submitted for merging.  You may also want
> to consider cooperating with the maintainer of the conflicting tree to
> minimise any particularly complex conflicts.
>=20
> --=20
> Cheers,
> Stephen Rothwell
>=20
> diff --cc mm/memory.c
> index ca632b58f792,271982fab2b8..000000000000
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@@ -5392,32 -5597,18 +5597,21 @@@ retry
>   	if (!vma)
>   		goto inval;
>  =20
> - 	/* Only anonymous and tcp vmas are supported for now */
> - 	if (!vma_is_anonymous(vma) && !vma_is_tcp(vma))
>  -	/* find_mergeable_anon_vma uses adjacent vmas which are not locked */
>  -	if (vma_is_anonymous(vma) && !vma->anon_vma)
> --		goto inval;
> --
>   	if (!vma_start_read(vma))
>   		goto inval;
>  =20
>  +	/*
>  +	 * find_mergeable_anon_vma uses adjacent vmas which are not locked.
>  +	 * This check must happen after vma_start_read(); otherwise, a
>  +	 * concurrent mremap() with MREMAP_DONTUNMAP could dissociate the VMA
>  +	 * from its anon_vma.
>  +	 */
> - 	if (unlikely(!vma->anon_vma && !vma_is_tcp(vma)))
> - 		goto inval_end_read;
> -=20
> - 	/*
> - 	 * Due to the possibility of userfault handler dropping mmap_lock, avo=
id
> - 	 * it for now and fall back to page fault handling under mmap_lock.
> - 	 */
> - 	if (userfaultfd_armed(vma))
> ++	if (unlikely(vma_is_anonymous(vma) && !vma_is_tcp(vma)))
>  +		goto inval_end_read;
>  +
>   	/* Check since vm_start/vm_end might change before we lock the VMA */
>  -	if (unlikely(address < vma->vm_start || address >=3D vma->vm_end)) {
>  -		vma_end_read(vma);
>  -		goto inval;
>  -	}
>  +	if (unlikely(address < vma->vm_start || address >=3D vma->vm_end))
>  +		goto inval_end_read;
>  =20
>   	/* Check if the VMA got isolated after we found it */
>   	if (vma->detached) {

Sorry, doesn't even build ... let me try that again.

--=20
Cheers,
Stephen Rothwell

--Sig_/NFQ9DE+V61/f+Ow9PDrTCgX
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmTC/cwACgkQAVBC80lX
0Gz71wf9EpAnKBLioVFm0n9YwpN5Iz0unRTVxNP2txaJJDKbGh+sFEN26F3GtD7b
b2fI/Od7qVFJmPWms8Ji8YGyMAXqOi513BXTvTmzM0ShM+3p8oz5PlWVYgqmIOyA
NmuzUjUaTOWL9gwttNuxfj7vKV04vGxPArTJMG04lN7bjZHLu2MVapj6qatNTuGv
PZy8wA50WBxf/KnloGx4RbmIErJSqMInJ/r0nBiNQFWKpIhkRhv6rFSQt1wPqvEh
dRs4/ukzR2NSZisRSnzeKMiBaNDi6dVoVbhamrbE4SyHggzbXy9VXFHiDt396qz/
Wcg9YjZ0RSq3i8oVy6GeSzJOWUvIkA==
=7Qo8
-----END PGP SIGNATURE-----

--Sig_/NFQ9DE+V61/f+Ow9PDrTCgX--
