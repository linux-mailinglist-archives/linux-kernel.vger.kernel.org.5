Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34BE07CD1D1
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 03:30:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344332AbjJRBaZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 21:30:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjJRBaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 21:30:22 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86B14B6;
        Tue, 17 Oct 2023 18:30:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1697592616;
        bh=MoQnsNEinM8NYDsh5Ogyks6w9xDCU0Mj2oDOrkzM4/Q=;
        h=Date:From:To:Cc:Subject:From;
        b=Rk1TCxRc8zpUHvRA3pG9BG9pYC9kniwLq35rklMzDlTekiLG/XAcKBjOK9fOu5Kzd
         OUpqtPKvKeuXhuI6Sz7XJMLZ0uS9GPMzddXiFEwjhnTeX8Zgj/M7X24weuq2SoGv2S
         y0zj971puTYt9gpylaxowyA0dtrDWvR2tPNem9P4YkCRZTLOanPl5lXJVHQ042l4A7
         CQlXW38bQ+JEXw88c8oJyvqiBn4RmDDyEgjvSR0HFrvg/3WUeNtMwLNpMXH46kAs5G
         sGAc+e3zhmpBrDaZLnVKmk4/ftIk7bAs+T52teLuD0EEQJ1xWq1CTmibKxgKpQcEMv
         2f+L5KzxVfHqA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4S9Cvr0bbpz4xM1;
        Wed, 18 Oct 2023 12:30:15 +1100 (AEDT)
Date:   Wed, 18 Oct 2023 12:30:14 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     Beau Belgrave <beaub@linux.microsoft.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Subject: linux-next: manual merge of the ftrace tree with the
 kselftest-fixes tree
Message-ID: <20231018123014.65073211@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/CPS/Y=Y7WBQF=uC3bltgfsG";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/CPS/Y=Y7WBQF=uC3bltgfsG
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the ftrace tree got a conflict in:

  tools/testing/selftests/user_events/abi_test.c

between commit:

  cf5a103c98a6 ("selftests/user_events: Fix abi_test for BE archs")

from the kselftest-fixes tree and commit:

  cf74c59c4fc1 ("selftests/user_events: Test persist flag cases")

from the ftrace tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc tools/testing/selftests/user_events/abi_test.c
index f5575ef2007c,3d539e556dcd..000000000000
--- a/tools/testing/selftests/user_events/abi_test.c
+++ b/tools/testing/selftests/user_events/abi_test.c
@@@ -47,7 -59,22 +59,22 @@@ static int change_event(bool enable
  	return ret;
  }
 =20
- static int reg_enable(void *enable, int size, int bit)
+ static int event_delete(void)
+ {
+ 	int fd =3D open(data_file, O_RDWR);
+ 	int ret;
+=20
+ 	if (fd < 0)
+ 		return -1;
+=20
+ 	ret =3D ioctl(fd, DIAG_IOCSDEL, "__abi_event");
+=20
+ 	close(fd);
+=20
+ 	return ret;
+ }
+=20
 -static int reg_enable_flags(long *enable, int size, int bit, int flags)
++static int reg_enable_flags(void *enable, int size, int bit, int flags)
  {
  	struct user_reg reg =3D {0};
  	int fd =3D open(data_file, O_RDWR);
@@@ -69,7 -97,12 +97,12 @@@
  	return ret;
  }
 =20
 -static int reg_enable(long *enable, int size, int bit)
++static int reg_enable(void *enable, int size, int bit)
+ {
+ 	return reg_enable_flags(enable, size, bit, 0);
+ }
+=20
 -static int reg_disable(long *enable, int bit)
 +static int reg_disable(void *enable, int bit)
  {
  	struct user_unreg reg =3D {0};
  	int fd =3D open(data_file, O_RDWR);

--Sig_/CPS/Y=Y7WBQF=uC3bltgfsG
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmUvNSYACgkQAVBC80lX
0Gxwjgf9HqrEE0VA/Wf2+JV+xnWVUo8ZsOFUjnlsiX4zKkOF2wuPb8UaUVA6SSx9
g1deOIUOgzaadC1+iqJfhkUvgBJcVY9IsHhdmnnaiP3OTAW6meuiLJNUGswkdO/8
74rcvpIPLLcCljWGHlBhdtFAi90NYKJh2nDu4bhdiRnqED9K8wjLGvKytWtBcGk6
DmMz4P/8ExI/2itNhkGlIItQ6EqECi4i1OYOOkv0wEqVuYU+s0zsfXgyxEIxUZ/v
BOpA2gpJspzjmGare2ucVtMbpPODIWGiR+joEDK7AvEFE/HOoU6OPYz5BcPpmjAY
gbs3wNfFOzFOJ494ujLxWmIJuYyQqQ==
=3GAp
-----END PGP SIGNATURE-----

--Sig_/CPS/Y=Y7WBQF=uC3bltgfsG--
