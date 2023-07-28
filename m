Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0214A766072
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 02:00:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbjG1AAz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 20:00:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjG1AAx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 20:00:53 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C82E51FC4;
        Thu, 27 Jul 2023 17:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1690502449;
        bh=kYd9MCQv4bFC1hzebI8mdDUARnwaJlRVeWrVkwXaNSE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QzshTNZnGsk63UlEyMgQU+nueGmpdigNrI99Ra2O5xGNSte1DqLsWFLvaYeqSKCKw
         tf++yNGPiwjBAbMchcnRYWqiCFvL1oTTKIbOULzVHfHI6m3rbrprJPMbo5i0Qn+gKt
         KotTxcLCzaaXDLNNlqfpkf7lUgHdJRTQyCMxCSV4WF/mDgEsq4csgdhEJeJyBb798C
         opZRFhjEzkIB8yC6a5WsUWf/7Hdx18xVGa3VGGQosX10oOEduV3gFInROMPpKsEzIR
         Hgq0qlAf1h64H1nQvoTqU06q1LA1eg/kW+siOtCLAl5zhXMB5Nd/rIqSqEe4fa98XU
         4pQdtE8JSczMg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RBnpT1G5Dz4wZp;
        Fri, 28 Jul 2023 10:00:49 +1000 (AEST)
Date:   Fri, 28 Jul 2023 10:00:47 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Jann Horn <jannh@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: linux-next: manual merge of the mm tree with Linus' tree
Message-ID: <20230728100047.4f9cd375@canb.auug.org.au>
In-Reply-To: <20230728092915.732d4115@canb.auug.org.au>
References: <20230728091849.7f32259d@canb.auug.org.au>
        <20230728092915.732d4115@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/hSaS_j2wk.vRPV.Q0JkEiBf";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/hSaS_j2wk.vRPV.Q0JkEiBf
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Fri, 28 Jul 2023 09:29:15 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> On Fri, 28 Jul 2023 09:18:49 +1000 Stephen Rothwell <sfr@canb.auug.org.au=
> wrote:
> >
> > Today's linux-next merge of the mm tree got a conflict in:
> >=20
> >   mm/memory.c
> >=20
> > between commit:
> >=20
> >   657b5146955e ("mm: lock_vma_under_rcu() must check vma->anon_vma unde=
r vma lock")
> >=20
> > from Linus' tree and commits:
> >=20
> >   69f6bbd1317f ("mm: handle userfaults under VMA lock")
> >   a3bdf38e85aa ("mm: allow per-VMA locks on file-backed VMAs")
> >=20
> > from the mm tree.
> >=20
> > I fixed it up (I think, please check - see below) and can carry the fix
> > as necessary. This is now fixed as far as linux-next is concerned, but
> > any non trivial conflicts should be mentioned to your upstream
> > maintainer when your tree is submitted for merging.  You may also want
> > to consider cooperating with the maintainer of the conflicting tree to
> > minimise any particularly complex conflicts.
> >=20
> > --=20
> > Cheers,
> > Stephen Rothwell
> >=20
> > diff --cc mm/memory.c
> > index ca632b58f792,271982fab2b8..000000000000
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@@ -5392,32 -5597,18 +5597,21 @@@ retry
> >   	if (!vma)
> >   		goto inval;
> >  =20
> > - 	/* Only anonymous and tcp vmas are supported for now */
> > - 	if (!vma_is_anonymous(vma) && !vma_is_tcp(vma))
> >  -	/* find_mergeable_anon_vma uses adjacent vmas which are not locked */
> >  -	if (vma_is_anonymous(vma) && !vma->anon_vma)
> > --		goto inval;
> > --
> >   	if (!vma_start_read(vma))
> >   		goto inval;
> >  =20
> >  +	/*
> >  +	 * find_mergeable_anon_vma uses adjacent vmas which are not locked.
> >  +	 * This check must happen after vma_start_read(); otherwise, a
> >  +	 * concurrent mremap() with MREMAP_DONTUNMAP could dissociate the VMA
> >  +	 * from its anon_vma.
> >  +	 */
> > - 	if (unlikely(!vma->anon_vma && !vma_is_tcp(vma)))
> > - 		goto inval_end_read;
> > -=20
> > - 	/*
> > - 	 * Due to the possibility of userfault handler dropping mmap_lock, a=
void
> > - 	 * it for now and fall back to page fault handling under mmap_lock.
> > - 	 */
> > - 	if (userfaultfd_armed(vma))
> > ++	if (unlikely(vma_is_anonymous(vma) && !vma_is_tcp(vma)))
> >  +		goto inval_end_read;
> >  +
> >   	/* Check since vm_start/vm_end might change before we lock the VMA */
> >  -	if (unlikely(address < vma->vm_start || address >=3D vma->vm_end)) {
> >  -		vma_end_read(vma);
> >  -		goto inval;
> >  -	}
> >  +	if (unlikely(address < vma->vm_start || address >=3D vma->vm_end))
> >  +		goto inval_end_read;
> >  =20
> >   	/* Check if the VMA got isolated after we found it */
> >   	if (vma->detached) { =20
>=20
> Sorry, doesn't even build ... let me try that again.

I have gone with below.  Again, please check.

--=20
Cheers,
Stephen Rothwell

diff --cc mm/memory.c
index ca632b58f792,271982fab2b8..000000000000
--- a/mm/memory.c
+++ b/mm/memory.c
@@@ -5392,32 -5597,18 +5597,21 @@@ retry
  	if (!vma)
  		goto inval;
 =20
- 	/* Only anonymous and tcp vmas are supported for now */
- 	if (!vma_is_anonymous(vma) && !vma_is_tcp(vma))
 -	/* find_mergeable_anon_vma uses adjacent vmas which are not locked */
 -	if (vma_is_anonymous(vma) && !vma->anon_vma)
--		goto inval;
--
  	if (!vma_start_read(vma))
  		goto inval;
 =20
 +	/*
 +	 * find_mergeable_anon_vma uses adjacent vmas which are not locked.
 +	 * This check must happen after vma_start_read(); otherwise, a
 +	 * concurrent mremap() with MREMAP_DONTUNMAP could dissociate the VMA
 +	 * from its anon_vma.
 +	 */
- 	if (unlikely(!vma->anon_vma && !vma_is_tcp(vma)))
- 		goto inval_end_read;
-=20
- 	/*
- 	 * Due to the possibility of userfault handler dropping mmap_lock, avoid
- 	 * it for now and fall back to page fault handling under mmap_lock.
- 	 */
- 	if (userfaultfd_armed(vma))
++	if (unlikely(vma_is_anonymous(vma) && !vma->anon_vma))
 +		goto inval_end_read;
 +
  	/* Check since vm_start/vm_end might change before we lock the VMA */
 -	if (unlikely(address < vma->vm_start || address >=3D vma->vm_end)) {
 -		vma_end_read(vma);
 -		goto inval;
 -	}
 +	if (unlikely(address < vma->vm_start || address >=3D vma->vm_end))
 +		goto inval_end_read;
 =20
  	/* Check if the VMA got isolated after we found it */
  	if (vma->detached) {

--Sig_/hSaS_j2wk.vRPV.Q0JkEiBf
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmTDBTAACgkQAVBC80lX
0GzkCgf/QACgILMpdlRwvRTIkbx7OqyjpWUAKpW2FU9kGrd9EcelDxIdWI8vptKy
KFKn7Pw6Dy5HNMplbYeNcX0JufbYzEjktj2WBsgX4S4PivyMaahC/sTYoYxTK8pC
xDqLw1GvtLUfXvixlv87b8KE3YsHXF6dcn8D6+2B1bk7fT8DytVbPPrgJ6DZek+P
rqOAHL+iN5zVIDXY13W/yLoxecWHYF7lLgb2gej1oDH0s47MI2KBp/455/iUCnxl
CG0BkUx0c/WFzEBAn+GZ7aZNG75S7Gu3zLTYp28b67QTpQCz3xR4dIxmD0AzbKpa
Tukj2PCd5+i/u4uYbLQkBK1SNTP8XQ==
=Bbl/
-----END PGP SIGNATURE-----

--Sig_/hSaS_j2wk.vRPV.Q0JkEiBf--
