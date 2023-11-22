Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACD7E7F5217
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 22:11:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232324AbjKVVL4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 16:11:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230377AbjKVVLy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 16:11:54 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4964098;
        Wed, 22 Nov 2023 13:11:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1700687506;
        bh=2WqVTYX4xg0dPpQTyqGxEQaQgOPvNCCd94EcOLW6qYU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=UPxfowbVxoX1lhpzrXB/1w6P1571jnN6frAW3QnR4L2XiRatXe/CZhq8GWpwfgct7
         tUoTDCefyAysV8dm/w2PnVerq5KLGNH6AfsQ74CgnvMK0zJmc/UxFQGCnSxLqadL52
         0eeQpo1FABVuQVrOT/skW7w+x5yfMgaFp2NGNjJos9IWqc55CxrLfS5QMXJgDOFmqU
         Q9huzu/UcPAphT3z8su4RbNGDqL+u3LXUssQcchjzadiHLKVRyvODG+u7zMUhiai+a
         pTNW9Eajgp6Kfj6O4vY+NtekKb79O7lVfcGUEQlJNcpTiQGac8QwEJxouxHvVBoq0v
         6EFTC8WHaQyLg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4SbDSx2Xfjz4wc0;
        Thu, 23 Nov 2023 08:11:44 +1100 (AEDT)
Date:   Thu, 23 Nov 2023 08:11:43 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, KVM <kvm@vger.kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Sean Christopherson <seanjc@google.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: linux-next: manual merge of the kvm tree with the vfs-brauner
 tree
Message-ID: <20231123081143.23c520f3@canb.auug.org.au>
In-Reply-To: <20231122071040.GA4104@lst.de>
References: <20231122125539.5a7df3a3@canb.auug.org.au>
        <20231122071040.GA4104@lst.de>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/6rxvHngSrUiKK7f=V74ttjT";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/6rxvHngSrUiKK7f=V74ttjT
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Christoph,

On Wed, 22 Nov 2023 08:10:40 +0100 Christoph Hellwig <hch@lst.de> wrote:
>
> On Wed, Nov 22, 2023 at 12:55:39PM +1100, Stephen Rothwell wrote:
> > index 06142ff7f9ce,bf2965b01b35..000000000000
> > --- a/include/linux/pagemap.h
> > +++ b/include/linux/pagemap.h
> > @@@ -203,9 -203,8 +203,10 @@@ enum mapping_flags=20
> >   	/* writeback related tags are not used */
> >   	AS_NO_WRITEBACK_TAGS =3D 5,
> >   	AS_LARGE_FOLIO_SUPPORT =3D 6,
> > - 	AS_RELEASE_ALWAYS,	/* Call ->release_folio(), even if no private dat=
a */
> > + 	AS_RELEASE_ALWAYS =3D 7,	/* Call ->release_folio(), even if no priva=
te data */
> > + 	AS_UNMOVABLE	=3D 8,	/* The mapping cannot be moved, ever */
> >  +	AS_STABLE_WRITES,	/* must wait for writeback before modifying
> >  +				   folio contents */
> >   }; =20
>=20
> Note that AS_STABLE_WRITES, is a fix for 6.7, so this will probably
> end up getting reordered.  It might also be worth to remove all the
> explicit number assignments here to make the merge conflict resolution
> a bit easier in the future.

Thanks, I will reorder them from today (and drop the numbering on the
added ones).

--=20
Cheers,
Stephen Rothwell

--Sig_/6rxvHngSrUiKK7f=V74ttjT
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmVebo8ACgkQAVBC80lX
0Gz1FAf/avUN7bmmzBWD0S4b28tnWjeBBo0rLAaAN8VzXer4m9coY5CcHH0Otm5x
i5tOw099nM2LDInurpEh78v4TBt8/0TW90Seezetdr3tiUs/NXMdoOlrKx4DUqeg
89wD6lsU+EMNJ5mu5lVCWDzFdM7lshLA1hzvFEQUgGdUBzZt07XC7FQG5DgwofA4
98kIjw+xEd8RZX6oko7aO3nWl9jV3diwQA774wKg/EZ5fbpEem1CaJnkPeCVaN+8
hDcPG2kMdQhpsHUO8IS8RqMKpUojWHQyxw7qqD2O2quaZTNWM3K2gIBbUMpo6aeN
dsBeXvBnsdfxtXKv3IKpZ8EBTcShcg==
=CMIT
-----END PGP SIGNATURE-----

--Sig_/6rxvHngSrUiKK7f=V74ttjT--
