Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79B2B77C6BA
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 06:28:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234547AbjHOE2B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 00:28:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234677AbjHOE0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 00:26:13 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDC601FC3;
        Mon, 14 Aug 2023 21:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1692073478;
        bh=4HIEDtYquPQorJ4mXi5h7ds8EOEWiJB1s3blGYY+Rv8=;
        h=Date:From:To:Cc:Subject:From;
        b=YksAwXqvlf1kX1LOZTP2VAn8DPQZg2ydYslH3mBcp7VaoMrFyeboI3+/snWcuYin8
         FTAmkc/+67QSQ/dbIEe4agTz454uIy7GqXyYGIVjaAk3k5StPp+XMNBv0pzj/7otaS
         ySOy3TsyXMJzQnx5KCTO0FmnRBABcD9F0VP/BIU8tBbG17Oi011QuDclr3FlQLTRnL
         5OKmmGAu1l9iUJEck3KuBloo4ohanaNiMRL71PmWZ/OMfe1A0DjGqyWe54dGfBYPnq
         Mu/6Q0pTVc1YYNW5LodGC7NymhPdAD1z0VE91eTRHR8GD7gI/P13GTaq/kIET71siU
         YbowlBE0aV2lg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4RPypZ0cNBz4wb5;
        Tue, 15 Aug 2023 14:24:38 +1000 (AEST)
Date:   Tue, 15 Aug 2023 14:24:37 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Christian Brauner <brauner@kernel.org>
Cc:     Alexey Gladkov <legion@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Palmer Dabbelt <palmer@sifive.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>
Subject: linux-next: manual merge of the tip tree with the vfs-brauner tree
Message-ID: <20230815142437.01441969@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/S8yXrKYqxr02YRxztdU37OG";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/S8yXrKYqxr02YRxztdU37OG
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the tip tree got a conflict in:

  arch/x86/entry/syscalls/syscall_64.tbl

between commit:

  78252deb023c ("arch: Register fchmodat2, usually as syscall 452")

from the vfs-brauner tree and commit:

  c35559f94ebc ("x86/shstk: Introduce map_shadow_stack syscall")

from the tip tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc arch/x86/entry/syscalls/syscall_64.tbl
index 814768249eae,38db4b1c291a..000000000000
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@@ -373,7 -373,7 +373,8 @@@
  449	common	futex_waitv		sys_futex_waitv
  450	common	set_mempolicy_home_node	sys_set_mempolicy_home_node
  451	common	cachestat		sys_cachestat
 -452	64	map_shadow_stack	sys_map_shadow_stack
 +452	common	fchmodat2		sys_fchmodat2
++453	64	map_shadow_stack	sys_map_shadow_stack
 =20
  #
  # Due to a historical design error, certain syscalls are numbered differe=
ntly
=20

--Sig_/S8yXrKYqxr02YRxztdU37OG
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmTa/gUACgkQAVBC80lX
0GwzvQf/dINNlOYnUFNKYoGdg2MONRsEJhVRkhuUhB+oFxLUqfAEwEZiR1O2mcVj
KdIP36VCp4b0r9CNfOaLnNtfHJ8PoxiWl3vnfw9led/qZ0oWWL8Ct7vhdrJVSQ8e
p0UJzskoIedw+nYtWUNrwBuX5GI38+QKebhmjklLXHmx52XOxHOkV06lKDI8Yrrf
VeOLCJHp8Kkyb10amAoR4k4WyRAagnw8z5GiXTnp5vedgQM26PaZ0CDsabjTMIeG
H64ZXjkk/SkGo1KX7QP9iHYUg9MqO9DL7UKNcwaOZZ/LKnNBZ+5ucIE0dw2l2JE3
XgFac2wg3qtqr4KJsvMXXRvXOzsSaQ==
=zkMW
-----END PGP SIGNATURE-----

--Sig_/S8yXrKYqxr02YRxztdU37OG--
