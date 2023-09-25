Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25FCE7AE22A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 01:19:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233481AbjIYXSL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 19:18:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjIYXSJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 19:18:09 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29E7D101;
        Mon, 25 Sep 2023 16:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1695683881;
        bh=KQsQZ+3JqHiU+NMyakUyR12paC+x5JF/ZlifkGXNuGY=;
        h=Date:From:To:Cc:Subject:From;
        b=O+lVn9QFURcUj6n8nJ3DmpLQfKevjZBqcRLEaMc3f+4UGrVxt3dazKHs84K1ufwes
         uDOHRiFDnWOLmUnAR6Rf4uZEwZFADjMkm4bLYB7gIOdTSxCfN8tdXjl4frMHKH+khd
         PPXprtvBPTEugOZ6Lx0wpwUa9DzojrHRj2BIjLrySun0sZrM/LTHMOiuIOn3sAPiX1
         2SK54G+cdZGAteP00TUg0/wbi86WhituT8tSMJis7J5K/4YVcSY0ao0GTMGVtYHOrK
         /osD5o7yiTBv26QhkF4LGBfhLiT87xwHdEXN0nY6UJRUxNFgNH2dbRw5wTlbQGIDRf
         0bz4efuROtdkg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Rvf1P2Q9Wz4xM0;
        Tue, 26 Sep 2023 09:18:01 +1000 (AEST)
Date:   Tue, 26 Sep 2023 09:18:00 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Jaewon Kim <jaewon31.kim@samsung.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the mm tree
Message-ID: <20230926091800.233cb70b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/.9tB7wDqW52e9FHNgE3_s5.";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/.9tB7wDqW52e9FHNgE3_s5.
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the mm tree, today's linux-next build (powerpc
ppc64_defconfig) failed like this:

In file included from include/trace/trace_events.h:27,
                 from include/trace/define_trace.h:102,
                 from include/trace/events/oom.h:195,
                 from mm/oom_kill.c:53:
include/trace/events/mmflags.h:278:21: error: 'LRU_GEN_ANON' undeclared her=
e (not in a function); did you mean 'LRU_GEN_NAMES'?
  278 |                 EM (LRU_GEN_ANON, "anon") \
      |                     ^~~~~~~~~~~~
include/trace/stages/init.h:20:31: note: in definition of macro 'TRACE_DEFI=
NE_ENUM'
   20 |                 .eval_value =3D a                         \
      |                               ^
include/trace/events/mmflags.h:278:17: note: in expansion of macro 'EM'
  278 |                 EM (LRU_GEN_ANON, "anon") \
      |                 ^~
include/trace/events/mmflags.h:295:1: note: in expansion of macro 'LRU_GEN_=
NAMES'
  295 | LRU_GEN_NAMES
      | ^~~~~~~~~~~~~
include/trace/events/mmflags.h:279:21: error: 'LRU_GEN_FILE' undeclared her=
e (not in a function); did you mean 'LRU_GEN_NAMES'?
  279 |                 EMe(LRU_GEN_FILE, "file")
      |                     ^~~~~~~~~~~~
include/trace/stages/init.h:20:31: note: in definition of macro 'TRACE_DEFI=
NE_ENUM'
   20 |                 .eval_value =3D a                         \
      |                               ^
include/trace/events/mmflags.h:279:17: note: in expansion of macro 'EMe'
  279 |                 EMe(LRU_GEN_FILE, "file")
      |                 ^~~
include/trace/events/mmflags.h:295:1: note: in expansion of macro 'LRU_GEN_=
NAMES'
  295 | LRU_GEN_NAMES
      | ^~~~~~~~~~~~~

Caused by commit

  11113e8e7b3f ("vmscan: add trace events for lru_gen")

I have reverted that commit (and its followup fix) for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/.9tB7wDqW52e9FHNgE3_s5.
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmUSFSgACgkQAVBC80lX
0GyFhAgAhDhrJQPJF9BcOTs9zLd6o96bVbf5r6hRumQCnZUy28hW41IWLD/CGQ8m
H8V2gS0TiIuiDb1ZmE8sRAzCCuJe+lR4RYPAKGvpnhYGwv4cHEgovT46TLt7nLLl
ZSY4Gn/KIANkGPek5E4cR33O7o38a35Kr6Mp1HYm9EAq8Jg7TpOeuYl3+hVPPyiD
qNTEATcCVfavZMkXFFr8NYitvBJ5mYBK3JlZ/bYiKO0E3MztyuuBoxc7WUiOFzw6
9vm4ljTtcCFRHnVgyH9lveSI0fvsSGZsXGIMv0kbUlrmN8RGhMPCc+/XEDUi8pI9
RjbFUkne/7IIvMVdeGStn8nypWDW5A==
=FouT
-----END PGP SIGNATURE-----

--Sig_/.9tB7wDqW52e9FHNgE3_s5.--
