Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EA197660BA
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 02:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231705AbjG1AVT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 20:21:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbjG1AVR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 20:21:17 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 402102D7E;
        Thu, 27 Jul 2023 17:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1690503662;
        bh=IiJgWH/Vklb2Fwrpc3NwHVwHxoibOOL+7d3Gq6GDxKc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=MTY7LkC7ot+2uKXHQAJO2vOXp0hOPSXtKIJ6M0vfV22VoAn2/VikjE8WOXDJ2FDBW
         vAorMM9cE6w2sFXmrmZPAxx+aOcVt318IF3TTAikL+kDZu6hojaYLCRdqteCST4F0J
         WTKZ/UX3mOLx3paiMid1PaZroI6k0enDzDYeSgwijhtFC7Ev2/z6rx9foNCVWkXEj7
         Ff+ftlE+t32wiHfoBtACRBRzJsoaIqVUkzMgRyiJByGgaH5vp6l3W6D2Ex+CY9LXw8
         swrUc/MjcZtehSShOn+9TW759FSeCAKySSgT+1GmCYEgVujtB/e7SA/uHR8+sw8bJ7
         C/W7rLubIbM4g==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RBpFp1146z4wqX;
        Fri, 28 Jul 2023 10:21:01 +1000 (AEST)
Date:   Fri, 28 Jul 2023 10:21:00 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jann Horn <jannh@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: linux-next: manual merge of the mm tree with Linus' tree
Message-ID: <20230728102022.7593856b@canb.auug.org.au>
In-Reply-To: <ZMMCnvc3h7XT/NM2@casper.infradead.org>
References: <20230728091849.7f32259d@canb.auug.org.au>
        <ZMMCnvc3h7XT/NM2@casper.infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_//yb.j3cI08T_=Y6OSsroN5f";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_//yb.j3cI08T_=Y6OSsroN5f
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Matthew,

On Fri, 28 Jul 2023 00:49:50 +0100 Matthew Wilcox <willy@infradead.org> wro=
te:
>
> On Fri, Jul 28, 2023 at 09:18:49AM +1000, Stephen Rothwell wrote:
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
> >  + =20
>=20
> No, this isn't right.  It should be:
>=20
> 	if (unlikely(vma_is_anonymous(vma) && !vma->anon_vma))
> 		goto inval_end_read;

Yeah, see my second attempt.

> I'm not sure about the userfaultfd_armed() clause.  My patch wasn't
> intended to affect that.

That was removed by commit

  69f6bbd1317f ("mm: handle userfaults under VMA lock")

in the mm branch.

--=20
Cheers,
Stephen Rothwell

--Sig_//yb.j3cI08T_=Y6OSsroN5f
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmTDCewACgkQAVBC80lX
0Gzg1AgAnPCQs1b/arFmUhcj5LO5Ij0Y9b77pBV0zyN7e6Zy+ddaRWzgbLbEKBsI
oFkaa3aBs58Q4uhYiKCXBEskdKMZP4Q0nEQRaSJ8/IFuM/1gt5Wcl8Y/08zenSWE
NxkcBmhpRctyLh6t4giPlqXpmfL5ZQnCb9aHCcJXmDSmMs9DCY8ab5nifB+o4k6+
ohzVzKz11VjRt56jBJvjgIP4WPv+Ozm3BJTd/QHG4ZZLiecXc2E21P5KM3hJgJLj
pKUyH01514hK/YhvQ/PugEaaylifxzt3x3W6gWB8iOWB1NyI3YgQz71nQ6xyKuBd
yMOALy7ml+K7aVX00aJXts8MmWZW8A==
=z7G/
-----END PGP SIGNATURE-----

--Sig_//yb.j3cI08T_=Y6OSsroN5f--
