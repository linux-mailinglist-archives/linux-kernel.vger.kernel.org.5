Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74B28784CFF
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 00:53:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231589AbjHVWxD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 18:53:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjHVWxC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 18:53:02 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5C0EE4A;
        Tue, 22 Aug 2023 15:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1692744772;
        bh=HF0pKNyPsfPVW6YNobRMdCL/yLQFuP64rg4a4abFP6w=;
        h=Date:From:To:Cc:Subject:From;
        b=LgWDse7TDE3TnNfntc50xpFFayJ2NLQaXdsBMNRKqyIUdsLFJOX1sYyeEzbLfETTL
         VKRipk1huTEkAfismKG/pjQAlXGhu3ozR/0hCmNKgcpxDm3elW7qbA67DANmMWWh+R
         4UpEFHnEXxX7CXLik3atxbde8f2wYN6F0NEzs2sMbw7uSJGe3G45B/sUQ1JA+fRGEC
         lz0wbZf8lI6+aMHoBby7pnzvLyKpZrxddSEdYRnG++iagGNeeaP3JhLybXljThn5nq
         PfxGzkqbmz5wIA6NlsDPGpiEb8S/6WwZbWV+cMdoDle9e+CcM5mM1jR3U4aHibC/73
         40ektCep3Pixw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RVl440xgwz4wxW;
        Wed, 23 Aug 2023 08:52:52 +1000 (AEST)
Date:   Wed, 23 Aug 2023 08:52:36 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Stefan Roesch <shr@devkernel.io>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the mm tree
Message-ID: <20230823085236.0db2e377@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/imbYznHbCMZJpJ7mGFeP37x";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/imbYznHbCMZJpJ7mGFeP37x
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the mm tree, today's linux-next build (arm
multi_v7_defconfig) failed like this:

fs/proc/task_mmu.c: In function 'smaps_account':
fs/proc/task_mmu.c:457:40: error: implicit declaration of function 'is_ksm_=
zero_pte' [-Werror=3Dimplicit-function-declaration]
  457 |         if (PageKsm(page) && (!pte || !is_ksm_zero_pte(*pte)))
      |                                        ^~~~~~~~~~~~~~~

Caused by commit

  5233d9beb1a8 ("proc/ksm: add ksm stats to /proc/pid/smaps")

# CONFIG_KSM is not set

I have reverted that commit for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/imbYznHbCMZJpJ7mGFeP37x
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmTlPDQACgkQAVBC80lX
0Gzaogf/QWWlccScarEB4z6Vcv0zJdSwRADgQvwppZ7oLFRt092NglW4cOdlMWVX
p2kQi4bobXUSTHZImkvrWPazWyA4uCWKz/YRJM0eyE+36jqSVvl4JYRYGJqgwu4f
UvL/5zpyjxVbv57TY/VE9BhpG+1g6yVZLoYW7le8SC7QF5dIaA/gjfD9oXvUTDGY
cGVP0aRwovLhGP4ev3TaTUvduSI12jzk3zXceIIZnBcAy7JuGOSL+d3t9orTJ4iO
Bbc8Zs9y0LwQ1kvcsnvzXmwMc9wtVg/K1ynbb/SzbIw4LaUhZJ9zK0OWsBmj2LeT
4/MjVHsRbxANfJBg/v7gbWcSqW95sA==
=RpMJ
-----END PGP SIGNATURE-----

--Sig_/imbYznHbCMZJpJ7mGFeP37x--
