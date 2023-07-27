Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBAFE766032
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 01:19:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230335AbjG0XTL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 19:19:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbjG0XTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 19:19:10 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0D5A30D3;
        Thu, 27 Jul 2023 16:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1690499943;
        bh=jU5JsLHZmKBu77K0XMsV1r5yt36hT5CLa9hx2frbJj0=;
        h=Date:From:To:Cc:Subject:From;
        b=fmJ3/vlJ9IpmHCnOw5NJJj8Kuw75rkoQEUTCiMuqKNepao9NfuUX5UYMtop3wt03p
         gH8eHIO6nDKSLd67jkOPNm03jEFDpcRHd0OP9Dl2JpJQQQQdOyx5sG9o8k84j/wmow
         8oA7E9sNXPXH1UwPg3Z5dFlpFDXnw+MHPkBSOuDF1mT51iEJ2/6WObkngBHKjU6Z6j
         yLMgLlU8itd2t1Vra8OyVlEvesQ+sLiKTaSG9GYPUyxfQfGb8gjZ+Bv2/EClK4GShO
         ISqJ9Fzh2PJsgo58z7Q96Q5+XMe7D/VwKYFO7UvMsccdR5+UFfkqKT0MPf5hbtM04G
         3vjCOaCHBT5MA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RBmtG70tnz4wZw;
        Fri, 28 Jul 2023 09:19:02 +1000 (AEST)
Date:   Fri, 28 Jul 2023 09:18:49 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Jann Horn <jannh@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Suren Baghdasaryan <surenb@google.com>
Subject: linux-next: manual merge of the mm tree with Linus' tree
Message-ID: <20230728091849.7f32259d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/TtX60qia5O1Es19qg7bXjYk";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/TtX60qia5O1Es19qg7bXjYk
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the mm tree got a conflict in:

  mm/memory.c

between commit:

  657b5146955e ("mm: lock_vma_under_rcu() must check vma->anon_vma under vm=
a lock")

from Linus' tree and commits:

  69f6bbd1317f ("mm: handle userfaults under VMA lock")
  a3bdf38e85aa ("mm: allow per-VMA locks on file-backed VMAs")

from the mm tree.

I fixed it up (I think, please check - see below) and can carry the fix
as necessary. This is now fixed as far as linux-next is concerned, but
any non trivial conflicts should be mentioned to your upstream
maintainer when your tree is submitted for merging.  You may also want
to consider cooperating with the maintainer of the conflicting tree to
minimise any particularly complex conflicts.

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
++	if (unlikely(vma_is_anonymous(vma) && !vma_is_tcp(vma)))
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

--Sig_/TtX60qia5O1Es19qg7bXjYk
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmTC+1oACgkQAVBC80lX
0GxIlQf/cTBNHPT28bNHlQKKKA4kZcb2pf1eV3nKSCCJQohZJCDMNgmTnZyOAOxy
pnWiu+nmuxU2kPXsEff2YdTptmeXXmhmtDq2Zt5je63dH/fjMY71nT+9YPXkzFzN
s4JQGfDueMqiwDAiOYiP6YIridL3HT2GnSYv47FDC7lFCeMH1g+4kUlskApc1wH3
uw4ndUaCdzqad143KIRAseDMwZueyN1ordAKng+0tajX9kxLFHBm2d11Yo1cv0hB
HvHLhUoAbRkQf43uYc8RncRpFk/PGbT0+0jos7Izj692O/X/zibG9raEDYki0LBH
EZUz9HbcRBRTw33tnL8eBZJzEdpbTw==
=fWj0
-----END PGP SIGNATURE-----

--Sig_/TtX60qia5O1Es19qg7bXjYk--
