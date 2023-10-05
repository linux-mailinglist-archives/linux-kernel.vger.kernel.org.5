Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BB497BAF62
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 01:40:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbjJEXkH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 19:40:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjJEXje (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 19:39:34 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BF59116;
        Thu,  5 Oct 2023 16:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1696549171;
        bh=W4CzBrXIZfoFxDzwDzpUKkmGPcZbwFXTX4PF7psd/3U=;
        h=Date:From:To:Cc:Subject:From;
        b=qKQdSheofcQIGSCDXjiVqQhqzvLuu6/7SC69nW8btUIMyr+IZnd4p484qDf+qbW6i
         BHegnvIjon6dS/EErONfP4XrQKiPnL6NUpzt480Z9DEtyP/XdbXaQWgXwEDldLQwAb
         Kg1ZHZUJnCj9Q6UK1ramSog8xg9SL4cDqeD7uBC7lIx3l0CL8FuG7pNMldMHaIWvOj
         VjNF5jx2nzF7YUyeva2C3c0vTVXmtPqM/h0uiOZdRG2JCu4EMtxsxtcmMrfmTe6yCa
         80nXrmNVdd3Jc4effQ4RC8Db1xZC75jDlQYZh1qIsO0dEItyrBK72Fb4lI8SSPiCNp
         3IxBnBq3kxPmg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4S1p1b4KDtz4x5k;
        Fri,  6 Oct 2023 10:39:31 +1100 (AEDT)
Date:   Fri, 6 Oct 2023 10:39:29 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the scmi tree
Message-ID: <20231006103929.4c56edb3@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/nPc_8xk77m/.M5evTqA8giC";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/nPc_8xk77m/.M5evTqA8giC
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the scmi tree, today's linux-next build (arm
multi_v7_defconfig) failed like this:

In file included from drivers/tee/optee/ffa_abi.c:8:
include/linux/arm_ffa.h: In function 'ffa_mem_desc_offset':
include/linux/arm_ffa.h:105:10: error: implicit declaration of function 'FI=
ELD_PREP' [-Werror=3Dimplicit-function-declaration]
  105 |         (FIELD_PREP(FFA_MAJOR_VERSION_MASK, (major)) |          \
      |          ^~~~~~~~~~
include/linux/arm_ffa.h:107:33: note: in expansion of macro 'FFA_PACK_VERSI=
ON_INFO'
  107 | #define FFA_VERSION_1_0         FFA_PACK_VERSION_INFO(1, 0)
      |                                 ^~~~~~~~~~~~~~~~~~~~~
include/linux/arm_ffa.h:368:28: note: in expansion of macro 'FFA_VERSION_1_=
0'
  368 |         if (ffa_version <=3D FFA_VERSION_1_0)
      |                            ^~~~~~~~~~~~~~~

Exposed by commit

  0624de756f75 ("firmware: arm_ffa: Update memory descriptor to support v1.=
1 format")

This has been possible for a while, and arm_ffa.h needs to include
linus/bitfoeld.h ...

I have used the scmi tree from next-20231005 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/nPc_8xk77m/.M5evTqA8giC
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmUfSTEACgkQAVBC80lX
0GwZIAf/eKN4PbTQKD/opx6+HlOC5J3bf5Jm1Z7THWV8iCzELwJtSdImmzt8CEkh
E9GJEKB1LLW/7+/eGo2G6bpiuzs0s2f/MryzYSjQaLyLitBqNQVDItOjL7+62I1e
2akQLA39qCJA5XvHqMP0fgmMaGQ4CGdS07pZm58IMcLpIewnYW5SGrPXr/6g4H6w
5Op+jxQ6EK7vYOkbm6u90/YtY6Wk0kSqw/MLs0xJ5yiMQJPngpCl098ffBVVmMRG
4E7Mel1ZVKaLe50W6FutqFadSe0hEte5LTpkVhhOQAtb21YBGNGgq2NSpOg9Gvtc
oaCkfPy9xz6eOXZVwDeKYuqga+nY5A==
=lpIV
-----END PGP SIGNATURE-----

--Sig_/nPc_8xk77m/.M5evTqA8giC--
