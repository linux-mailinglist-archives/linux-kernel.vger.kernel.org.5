Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7E0C7E17CD
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 00:09:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbjKEXJS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 18:09:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbjKEXJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 18:09:17 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59EFCE0;
        Sun,  5 Nov 2023 15:09:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1699225752;
        bh=K0yX5PBFL48awonuW1w9J4/ecr4f7GPYpsQu94b9V+Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=rQSaLNopqQvqYrOwOEyZXOVn4FvZGeycqGSaUWnwgnJx1x2zh7wlSAC5avVWeg+K9
         lEvwDXs4gjCuf/DQrLhAVXEwpuHC0MW202kiEK1wYwAQzo9Rm1StC9/s6E/RRlsH3n
         HgTGFwF2vPOLjgiuFvKVuaWNwn7Qxu+WrtTn0oAC84pP2q/E5nd6fAGdYSnWpXS4PM
         9dZ7VlJEPoNR16UPjSuT5i6rqrv50E0uL2KVLRGkCSSoQJl19tigJ3wSD496Kdia1k
         D7ZcRZp6c6A8eS3/CcmI/2QIxpJaliYRB3sCjzcRHZmY+BMZ66VLBcAjJunkgVcFy5
         rbPlVdL/VpQUg==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4SNqtJ1Wf7z4xPQ;
        Mon,  6 Nov 2023 10:09:12 +1100 (AEDT)
Date:   Mon, 6 Nov 2023 10:09:11 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Paul Moore <paul@paul-moore.com>
Cc:     John Johansen <john.johansen@canonical.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the apparmor tree with the security
 tree
Message-ID: <20231106100911.1f94abd9@canb.auug.org.au>
In-Reply-To: <20231027130320.69469330@canb.auug.org.au>
References: <20231027130320.69469330@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/g.iwLCQgR7xwrLqknfsqLo0";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/g.iwLCQgR7xwrLqknfsqLo0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Fri, 27 Oct 2023 13:03:20 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> Today's linux-next merge of the apparmor tree got a conflict in:
>=20
>   security/apparmor/lsm.c
>=20
> between commit:
>=20
>   3c3bda37ca1d ("AppArmor: Add selfattr hooks")
>=20
> from the security tree and commits:
>=20
>   bd7bd201ca46 ("apparmor: combine common_audit_data and apparmor_audit_d=
ata")
>   d20f5a1a6e79 ("apparmor: rename audit_data->label to audit_data->subj_l=
abel")
>=20
> from the apparmor tree.
>=20
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
>=20
> diff --cc security/apparmor/lsm.c
> index 5e16c03936b9,4d34180e9799..000000000000
> --- a/security/apparmor/lsm.c
> +++ b/security/apparmor/lsm.c
> @@@ -771,16 -868,11 +917,16 @@@ out
>   	return error;
>  =20
>   fail:
> - 	aad(&sa)->label =3D begin_current_label_crit_section();
> + 	ad.subj_label =3D begin_current_label_crit_section();
>  -	ad.info =3D name;
>  +	if (attr =3D=3D LSM_ATTR_CURRENT)
> - 		aad(&sa)->info =3D "current";
> ++		ad.info =3D "current";
>  +	else if (attr =3D=3D LSM_ATTR_EXEC)
> - 		aad(&sa)->info =3D "exec";
> ++		ad.info =3D "exec";
>  +	else
> - 		aad(&sa)->info =3D "invalid";
> - 	aad(&sa)->error =3D error =3D -EINVAL;
> - 	aa_audit_msg(AUDIT_APPARMOR_DENIED, &sa, NULL);
> - 	end_current_label_crit_section(aad(&sa)->label);
> ++		ad.info =3D "invalid";
> + 	ad.error =3D error =3D -EINVAL;
> + 	aa_audit_msg(AUDIT_APPARMOR_DENIED, &ad, NULL);
> + 	end_current_label_crit_section(ad.subj_label);
>   	goto out;
>   }
>  =20

This is now a conflict between the security tree and Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/g.iwLCQgR7xwrLqknfsqLo0
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmVIIJcACgkQAVBC80lX
0Gw03gf/cFPxT0LwJV+lg/tadhfTiM7d3IenUgzcneeC2kXy7qHoHE2E+gpe126m
k6KjOHLgxP8AGBdg+KUOBHV6Bh3Dku+E4yNQz/f4LofqIxwrrbyq2BsMT6jffp60
1eE8QyTHxoLQ34KgiSYjRr9CNNFAwk8vX3Cy0M+8vh+hg4BZplmhpPtFyzcAgsFY
h7HnqJxSg29H//tVv3FB5BHNXnfKRCgAq05FD03YD94YPWAm4rqe/XrhoVas9Ijd
kzt1b1vzwHRm/gg0xAZTCVCnwVoZrvPm7yTfkdeRZATGTHPyMmmtSY6oDjONInqK
FBx3Pi5t3Yv9ctbK+z4bt/AIPY/h5w==
=j0VG
-----END PGP SIGNATURE-----

--Sig_/g.iwLCQgR7xwrLqknfsqLo0--
