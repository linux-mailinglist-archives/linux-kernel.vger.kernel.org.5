Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C54657B2A6E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 05:13:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbjI2DNd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 23:13:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjI2DNb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 23:13:31 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7959199;
        Thu, 28 Sep 2023 20:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1695957207;
        bh=Kp3bxoiQPtPuwiL5zyIKxtFifL7FfwEny9r+snjjZMs=;
        h=Date:From:To:Cc:Subject:From;
        b=T+V44he03Hfrg/m4Ztw3wOjYEWAjB5rNGogFY/WPHrrPBdcO2n2FplYf6rwEj/tnJ
         HywX3mZh/dVqzE7UlIjz/sjKJ0b+cKLFdvbg06rWImuailEHn4tWG7yVMqjWYavB14
         xOQBvMBuyglBTrRAHoL0aJWFvVUjIl9A8YLvXpZvAxJgmbQUy4pstk8zet0ZzSG1BO
         etfNNn9EtsUAHQ7oR/PUWzaMLLa68XzuAo9sJ/r4qBje0bcv1hVfgFlv444wY4Jwj9
         /7yoU5q8jDHZAamMg+EgR9RGg5+JZoXKNjQQOnzal4LN68JJ/qFRE2x4KWrTpNv7kd
         +RFPwTP2lmKuA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Rxb5f4xsFz4x3F;
        Fri, 29 Sep 2023 13:13:26 +1000 (AEST)
Date:   Fri, 29 Sep 2023 13:13:24 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Frank Li <Frank.Li@nxp.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the dmaengine tree
Message-ID: <20230929131324.6bb84292@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/xBmQ568W3Z_WezT.xYdDYUA";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/xBmQ568W3Z_WezT.xYdDYUA
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the dmaengine tree, today's linux-next build (powerpc
ppc64_defconfig) failed like this:

ld: warning: discarding dynamic section .glink
ld: warning: discarding dynamic section .plt
ld: linkage table error against `ioread64'
ld: stubs don't match calculated size
ld: can not build stubs: bad value
ld: fs/debugfs/file.o: in function `debugfs_print_regs':
file.c:(.text+0xee8): undefined reference to `ioread64be'
ld: file.c:(.text+0xf50): undefined reference to `ioread64'

Caused by commit

  09289d0ad122 ("debugfs_create_regset32() support 8/16/64 bit width regist=
ers")

I have used the dmaengine tree from next-20230928 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/xBmQ568W3Z_WezT.xYdDYUA
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmUWQNQACgkQAVBC80lX
0GzogAf/csdYGsvdtWy/ZFSkO5fncMmtgnLgumguZAFWUao70p4rVeLqJAre6DSq
jozauxKYvGP5eyS3eX7ezAxxVNk5CPoPDNZEn6kJn6qGT5UziDTWPqwixGWmVm+s
ZXgDhrQbP9G3+NWA/DqwjcJAEDVEtBRZyUENsE2p1EiTTf5YChK9zAL/jcG49v1i
tre8X+a89w5a8DBCLfPuDJZXorvSylq9goA9JZKUC7GeoxH3L9NosYO7+Vx1bf90
tPc5R3Yzbi4rH4PGJBaBpkQEkV9W4AJ66UUHVYPw1TRqw+7ALhpa7Z3VZXG+xwVK
A1YJEH6qufAqwPHrLiLtrKHoj365Cg==
=45IJ
-----END PGP SIGNATURE-----

--Sig_/xBmQ568W3Z_WezT.xYdDYUA--
