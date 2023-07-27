Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 343A17644CF
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 06:19:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230185AbjG0ETl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 00:19:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbjG0ETh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 00:19:37 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30AC62701;
        Wed, 26 Jul 2023 21:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1690431573;
        bh=rI80oRT9KLOdefr5McbBoz22mLySxa8Y2O77k8IeNCw=;
        h=Date:From:To:Cc:Subject:From;
        b=eFvK+QvKQUleYx0glPPi4wYbOdayXpqK9fZRhis2aII+mtCBc2dtO++eQPmD3Uy/d
         EOiJthmkNE71HY9YlYA0IJNqJ469ZkI3fhcQSPGh71p2nL2A4KDAP0dZDLuTczhymL
         PIPgnFLkfdSdrWTlVb79CRg0vLj8gckDfcgA5H5HFPhyPHPNZsh2NL0yMffn4XZWA0
         NKakq/ktw5DivQlQmKAFS9wnnIfqq9LQLTls7IHAW9yDQ7xSeTwXveBFriYRb1Nsbz
         D5QxdTTtk8CZHh8OdcdLtsUIqH04MU98Wv1TnQL2WfsPS0EcTp2D+u7WCdP7Z6IG9e
         u+OIJdjRwPF4g==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RBHbT08VXz4wbP;
        Thu, 27 Jul 2023 14:19:32 +1000 (AEST)
Date:   Thu, 27 Jul 2023 14:19:30 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the rcu tree
Message-ID: <20230727141930.0b5a3c40@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/lgAEqfJ860BEoAZ._ZOC9Qw";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/lgAEqfJ860BEoAZ._ZOC9Qw
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the rcu tree, today's linux-next build (arm64 defconfig)
failed like this:

In file included from arch/arm64/include/asm/alternative.h:9,
                 from arch/arm64/include/asm/lse.h:14,
                 from arch/arm64/include/asm/cmpxchg.h:14,
                 from arch/arm64/include/asm/atomic.h:16,
                 from include/linux/atomic.h:7,
                 from include/asm-generic/bitops/atomic.h:5,
                 from arch/arm64/include/asm/bitops.h:25,
                 from include/linux/bitops.h:68,
                 from arch/arm64/include/asm/cache.h:40,
                 from include/linux/cache.h:6,
                 from include/linux/slab.h:15,
                 from include/linux/resource_ext.h:11,
                 from include/linux/acpi.h:13,
                 from include/acpi/apei.h:9,
                 from include/acpi/ghes.h:5,
                 from include/linux/arm_sdei.h:8,
                 from arch/arm64/kernel/asm-offsets.c:10:
include/linux/init.h:149:33: error: expected '=3D', ',', ';', 'asm' or '__a=
ttribute__' before '__ro_after_init'
  149 | extern char boot_command_line[] __ro_after_init;
      |                                 ^~~~~~~~~~~~~~~

Caused by commit

  de2f542cfbec ("fs/proc: Add /proc/cmdline_load for boot loader arguments")

I have applied the following fix up (I have a faint memory that the
section setting attributes are only needed on the definition, not the
declaration):

=46rom 9f56e539ed7d9c402caa85d4f5f3f8cec8373b2f Mon Sep 17 00:00:00 2001
From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Thu, 27 Jul 2023 13:26:08 +1000
Subject: [PATCH] fix up for "fs/proc: Add /proc/cmdline_load for boot loader
 arguments"

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 include/linux/init.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/include/linux/init.h b/include/linux/init.h
index e3ce68988e1b..c075983c5015 100644
--- a/include/linux/init.h
+++ b/include/linux/init.h
@@ -113,8 +113,6 @@
=20
 #ifndef __ASSEMBLY__
=20
-#include <linux/cache.h>
-
 /*
  * Used for initialization calls..
  */
@@ -146,7 +144,7 @@ struct file_system_type;
=20
 /* Defined in init/main.c */
 extern int do_one_initcall(initcall_t fn);
-extern char boot_command_line[] __ro_after_init;
+extern char boot_command_line[];
 extern char *saved_command_line;
 extern unsigned int saved_command_line_len;
 extern unsigned int reset_devices;
--=20
2.40.1

--=20
Cheers,
Stephen Rothwell

--Sig_/lgAEqfJ860BEoAZ._ZOC9Qw
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmTB8FIACgkQAVBC80lX
0GxpRQf8D8prb/iZ9MNVQjCb+M9J8j7slYPCER6M6OYpx0bMzxfkXuDybdOovx6/
/oI1clagbOi9s/zVbmCZzdAd1fIHZ5IxlZ2jfZr9A9Wl5mNC3ACyRhm0n/6jeD/K
3BeYOVW9fnZbkhLNEj+MF/Wz6Lt5it/xFkOo4Pnz7tT8sLCHTQ9dla/auQ6bekHU
J38005fbpsvcgpnE77Nqzcy/gPyzzUTEsCocFjx0u8B4WWqegvZvgmW+wopLWBom
tFE9O73x7kTPDgqdLTaTw61PDIbo58BHwYPzFHysB4KO5mvpGwWlQv8lfOWafmMG
YdYeXBfTxDm05DIrUeVMJjS6ofmXZQ==
=ICTK
-----END PGP SIGNATURE-----

--Sig_/lgAEqfJ860BEoAZ._ZOC9Qw--
