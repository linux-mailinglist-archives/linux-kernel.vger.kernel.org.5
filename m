Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87F1E7D8D04
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 04:03:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345138AbjJ0CD2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 22:03:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjJ0CD1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 22:03:27 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02623AB;
        Thu, 26 Oct 2023 19:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1698372202;
        bh=Xf5W6N69BEL5vs00GlwWRmsDVtQ+vGLCc+Q84wpL6mI=;
        h=Date:From:To:Cc:Subject:From;
        b=uMyv+GwndA1sIqK17haga7DY6iHQOWflNo0XKSNLpfWoeOcIsD1IKKir4f9yI8V++
         W9V3yzmG8cNn9ZMfMcVD4qAy8NnAc3Hu8QYbdLinyUZ0ESN/GEqvWgC7lSmN36UyRf
         vfpvHwsPvAsKQ0gviH7HBJgcxAyKtJ3zWNEiSpVngvJPgppwJ1z2l6DrGafJFMSrn0
         RQ9VePSX6Q8obWbRApWfnQ1ueTxnp157MKyNmiAoU8k0/UiOXP0y22eCLK7aoY+ZFw
         1JrCYnjOdsqyYuGCMqBff/MkC5UQ/LJH3fgjx+SMZlaSy2/PreSfZrRMlpD4U5k1BP
         AyPCCkHSSEgKw==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4SGmCt0nfTz4wby;
        Fri, 27 Oct 2023 13:03:21 +1100 (AEDT)
Date:   Fri, 27 Oct 2023 13:03:20 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     John Johansen <john.johansen@canonical.com>,
        Paul Moore <paul@paul-moore.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the apparmor tree with the security
 tree
Message-ID: <20231027130320.69469330@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/E8NMYd5Jkpz=CO8k/Jo4HbF";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/E8NMYd5Jkpz=CO8k/Jo4HbF
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the apparmor tree got a conflict in:

  security/apparmor/lsm.c

between commit:

  3c3bda37ca1d ("AppArmor: Add selfattr hooks")

from the security tree and commits:

  bd7bd201ca46 ("apparmor: combine common_audit_data and apparmor_audit_dat=
a")
  d20f5a1a6e79 ("apparmor: rename audit_data->label to audit_data->subj_lab=
el")

from the apparmor tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc security/apparmor/lsm.c
index 5e16c03936b9,4d34180e9799..000000000000
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@@ -771,16 -868,11 +917,16 @@@ out
  	return error;
 =20
  fail:
- 	aad(&sa)->label =3D begin_current_label_crit_section();
+ 	ad.subj_label =3D begin_current_label_crit_section();
 -	ad.info =3D name;
 +	if (attr =3D=3D LSM_ATTR_CURRENT)
- 		aad(&sa)->info =3D "current";
++		ad.info =3D "current";
 +	else if (attr =3D=3D LSM_ATTR_EXEC)
- 		aad(&sa)->info =3D "exec";
++		ad.info =3D "exec";
 +	else
- 		aad(&sa)->info =3D "invalid";
- 	aad(&sa)->error =3D error =3D -EINVAL;
- 	aa_audit_msg(AUDIT_APPARMOR_DENIED, &sa, NULL);
- 	end_current_label_crit_section(aad(&sa)->label);
++		ad.info =3D "invalid";
+ 	ad.error =3D error =3D -EINVAL;
+ 	aa_audit_msg(AUDIT_APPARMOR_DENIED, &ad, NULL);
+ 	end_current_label_crit_section(ad.subj_label);
  	goto out;
  }
 =20

--Sig_/E8NMYd5Jkpz=CO8k/Jo4HbF
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmU7GmgACgkQAVBC80lX
0GwKHQf/fYyhNZWglpRfPLqH5NJLnyHFQNiGAlc03fYpdvF2C5YcSiD7AU7UHgOG
auZCFsuuE8u6BPm5HFxC6KOmXI/MzL+dlVno4axeXoorCbz61V3bddjoDusPIuuk
Sn4nYKaNJGTNb+cqxv3otweHwTEmpIc5CChdy7sOP/afHqAGU68tMidQhG+cJqwl
vE68juprl1hYf4UIfZL5kp6G61+etDIZB7l2hXB19erP1AJ2fpGbeudbF+oDFFoh
/ojAD3GPgy+DsiRKyJ4oEa+PnFsVclyDdEeD52mRfGWhF/2czNQdn1ZV4PiNANoP
vj6cggD613uYSHijvEwvcT9tCGuCFQ==
=pcZH
-----END PGP SIGNATURE-----

--Sig_/E8NMYd5Jkpz=CO8k/Jo4HbF--
