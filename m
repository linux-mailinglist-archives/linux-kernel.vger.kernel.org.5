Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CE3E7839E0
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 08:23:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232981AbjHVGXw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 02:23:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232969AbjHVGXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 02:23:51 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBE47E9;
        Mon, 21 Aug 2023 23:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1692685416;
        bh=baux6wKyrSwGF5u0Zk4EklCqNw3y1Nb0sygcmX9Ue7w=;
        h=Date:From:To:Cc:Subject:From;
        b=FClRdczx5wK/P/QoyaHSszcy9YaRmDIgADZPuV99fGSsTY0sh7yF3VgxdbUZykIlg
         ZaB93+ayJJVKktT+WHTrwRFv85FsYzmC1E6v6N5wWaMkB4fh+989Z4Vo1HuIayltFo
         zoUfPzrWgDHF65+aHxiITil5h/+dSf4wIAjy00ru/YGDR/E6YnFBYu5un/eysDHPt0
         dlzYpoW0QDeHVPajGjksOr7E2QIoQ4HftQaEEHkpaPvPLw6amTgXlHtXyGtFoBNg4G
         jWSKaYh59267Qr7RfnsUGEOeMCwUfktag4PPRNvuV/rC4KoYRkupbLWRy/HjCfUKoe
         WLCkhq8CS13AQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RVK6b4N2Sz4wxR;
        Tue, 22 Aug 2023 16:23:35 +1000 (AEST)
Date:   Tue, 22 Aug 2023 16:23:33 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Miguel Ojeda <ojeda@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Brendan Higgins <brendanhiggins@google.com>
Cc:     Benno Lossin <benno.lossin@proton.me>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the rust tree with the kunit-next tree
Message-ID: <20230822162333.752217fa@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/.0Ilvkk/dX+C.ZPDJM0yq9a";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/.0Ilvkk/dX+C.ZPDJM0yq9a
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the rust tree got a conflict in:

  rust/kernel/init.rs

between commit:

  a30e94c29673 ("rust: init: make doctests compilable/testable")

from the kunit-next tree and commit:

  35e7fca2ff59 ("rust: init: add `..Zeroable::zeroed()` syntax for zeroing =
all missing fields")

from the rust tree.

I fixed it up (I think - see below) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc rust/kernel/init.rs
index e05563aad2ed,0071b2834b78..000000000000
--- a/rust/kernel/init.rs
+++ b/rust/kernel/init.rs
@@@ -522,9 -517,11 +526,10 @@@ macro_rules! stack_try_pin_init=20
  /// For instance:
  ///
  /// ```rust
- /// # use kernel::{macros::pin_data, pin_init};
 -/// # use kernel::pin_init;
 -/// # use macros::{Zeroable, pin_data};
++/// # use kernel::{macros::Zeroable, pin_data, pin_init};
  /// # use core::{ptr::addr_of_mut, marker::PhantomPinned};
  /// #[pin_data]
+ /// #[derive(Zeroable)]
  /// struct Buf {
  ///     // `ptr` points into `buf`.
  ///     ptr: *mut u8,

--Sig_/.0Ilvkk/dX+C.ZPDJM0yq9a
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmTkVGUACgkQAVBC80lX
0Gx9AAgAku/zfspUpHuWIE1cnLHuuGbHpxE3dSE2ejzItREptjIRJA7xYLWxMesH
//kPRFVqfPj4ECbmySnrCf9+fg1PUPPlMedfpdaSSImyJoFZWh3TQMHscxE/iR38
ZLJEWoMvlJrqMcOrQ8F6n02uLAjX80cOesggb07wvqry9DNLNcGcJpauU4k6LZDD
Ygg2WURYIyzjZ0MIE/RiXCW+cfzU1nrq1UUhs5kAYPMg9rKQNBLPhQbCPrSbUKEl
U0dSPs1vm77cXdRuWX5oQ9lpPhfpXFrneePKnV2KdHQ7y+hfAGe+I7ibbThXfgUv
HvR48/BL9cBxvUgqMLxFgix4uQ8h4g==
=2oZR
-----END PGP SIGNATURE-----

--Sig_/.0Ilvkk/dX+C.ZPDJM0yq9a--
