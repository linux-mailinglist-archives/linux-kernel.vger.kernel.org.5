Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22ED17B5F21
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 04:35:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239008AbjJCCfj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 22:35:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbjJCCfg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 22:35:36 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D07B2CE;
        Mon,  2 Oct 2023 19:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1696300526;
        bh=jJSjJ1auQRHmU9gRYzaWkM2vfWgqDMlzVhu7Az/s5NQ=;
        h=Date:From:To:Cc:Subject:From;
        b=oh1/z3946E5L0wcvfV0ho+o8Vtjfp9pJ8FEW5J+Q4PfBVG4FbDWk0E0tsqdBlp9Sz
         /hBlZbp074hXwSV8owgMR+X9rAWcp231qHqTfqtLZLN/pxSb0xkKutWEla0Lh3y9Mm
         MNEI0cGzyFJqzGsXDvaRc1ky4mgzYRYf+wVlWFqtiDOx6l8fvn0IzbfryrZIyYf0Cm
         1tj2B1rJZ8zRKdrr4uWHkZ7O87sbdPPFPyZje8BewhD7X3H0jAR7nNjEWhqtKDscrL
         p3g7212IcN30s2EZoUNaiYttREqeFUh3C2CN71QOTVg1CUexSV4iUqFPNPwIj5RnbQ
         iuVMi5Bx8P92g==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4S023y57T7z4xQ2;
        Tue,  3 Oct 2023 13:35:26 +1100 (AEDT)
Date:   Tue, 3 Oct 2023 13:35:22 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Kees Cook <keescook@chromium.org>
Cc:     Sebastian Ott <sebott@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the execve tree
Message-ID: <20231003133522.310bda60@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Vq9DWfTQWDUCm0QuuOOzd3U";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Vq9DWfTQWDUCm0QuuOOzd3U
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the execve tree, today's linux-next build (x86_64
allmodconfig) failed like this:

fs/binfmt_elf.c: In function 'load_elf_library':
fs/binfmt_elf.c:1323:37: error: unused variable 'len' [-Werror=3Dunused-var=
iable]
 1323 |         unsigned long elf_bss, bss, len;
      |                                     ^~~
fs/binfmt_elf.c:1323:32: error: unused variable 'bss' [-Werror=3Dunused-var=
iable]
 1323 |         unsigned long elf_bss, bss, len;
      |                                ^~~
fs/binfmt_elf.c:1323:23: error: unused variable 'elf_bss' [-Werror=3Dunused=
-variable]
 1323 |         unsigned long elf_bss, bss, len;
      |                       ^~~~~~~
cc1: all warnings being treated as errors

Caused by commit

  f2a1e5fab9ae ("binfmt_elf: Use elf_load() for library")

I have used the execve tree from next-20230929 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/Vq9DWfTQWDUCm0QuuOOzd3U
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmUbfeoACgkQAVBC80lX
0GzZDggAgZaQsuKqY53ymA9WuAgLIJV1TYURumW0+zm9iMTeggb1Y4JdaOqUxrgh
2NVIFPTy9TKlBbbw3TTjCvS5qOz2pLO/kdBMu6+TcGxHmGQGzvjUhBrFWq/MfaQo
NI4leyrmtXfOln3DmNKNPkUX5URPKqZADHNNU8X4469lT4PcLFPR437gVFy6C0a1
WQGVME07j24n11nLbYwnD2REfy49uo1tDtLclO59I1tRPO1Es0YLsa2qNR1AOVyj
xWtZI4Ab91wVDzSo/Gj0RF4KwZkHvk6Y325OTbfHfAVZhw9M3YgOwXheC2K2bJqV
8cgOJtk5FLYpEN2SxLNNfRfvy/579A==
=9Jf7
-----END PGP SIGNATURE-----

--Sig_/Vq9DWfTQWDUCm0QuuOOzd3U--
