Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 829AB7C55F1
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 15:55:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232466AbjJKNzb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 09:55:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232213AbjJKNz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 09:55:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3649090;
        Wed, 11 Oct 2023 06:55:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04FF4C433C8;
        Wed, 11 Oct 2023 13:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697032524;
        bh=bu5eBhwhfULEbVLtjkQ7jS6kUjdaiRIyYPhtQbetQXo=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=FS7tOU0u1A8rdy6h19ItvoCmfY6Wqef/Pk0gdNru63VmCgZQEXWL00+sKwWOp2CiX
         MdrE/LlN8WWS8ZE6pR3KvATGnY9Uaf0OjTQX1ltljTkkdOkKRrKoXSFS7LoJdfRWMt
         K6+mzVFt+WD8Wxl8B9PQjHU2IP4b3slxic6OYH43NYiVdkslCfqMLFdGQ+pp/BaC8W
         c+Ht7+pQ6gq8BwLy6LLsAglepPR395DWLKmSb2L81MpkkUJgt70Gs11Sv0udGWxYdP
         5OYSTwr0ClnjlAbg/PZ7msx45LHeBdDo4LnMmiYANohtflIQDoUXgxmR0eDgGu0/lK
         o20Cl8blsqjuA==
Message-ID: <bdf8dbb2e1aeeb6396d7a03b8c00d0db729c602d.camel@kernel.org>
Subject: Re: [PATCH] KEYS: trusted: Rollback init_trusted() consistently
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     keyrings@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        stable@vger.kernel.org, James Bottomley <jejb@linux.ibm.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        David Howells <dhowells@redhat.com>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        "open list:KEYS-TRUSTED" <linux-integrity@vger.kernel.org>,
        "open list:SECURITY SUBSYSTEM" 
        <linux-security-module@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Date:   Wed, 11 Oct 2023 16:55:20 +0300
In-Reply-To: <CAFA6WYN0vXWZveAkzOfV_6Kki77SxgX7C=Xqe9brZMX1Dj2iLg@mail.gmail.com>
References: <20231010231616.3122392-1-jarkko@kernel.org>
         <CAFA6WYMdrCfqMVExYBbhCK7vUSQffyUfSWpQO0=HeQc6Edz9OA@mail.gmail.com>
         <186a4b62517ead88df8c3c0e9e9585e88f9a6fd8.camel@kernel.org>
         <0aeb4d88952aff53c5c1a40b547a9819ebd1947e.camel@kernel.org>
         <CAFA6WYObvJvQv=-JJ5gnmFqJKbT=4JnT+ErC=iB1KfnYfVn7Ag@mail.gmail.com>
         <79fe0b97e2f5d1f02d08c9f633b7c0da13dc9127.camel@kernel.org>
         <CAFA6WYMrg3VBYvdV8Or==YK_qATk22bL+_ryDC-oO4jVf7DCWg@mail.gmail.com>
         <b70d6be5980185a4fb4205e71c56111183e1f160.camel@kernel.org>
         <CAFA6WYN0vXWZveAkzOfV_6Kki77SxgX7C=Xqe9brZMX1Dj2iLg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-10-11 at 19:12 +0530, Sumit Garg wrote:
> On Wed, 11 Oct 2023 at 18:36, Jarkko Sakkinen <jarkko@kernel.org> wrote:
> >=20
> > On Wed, 2023-10-11 at 18:25 +0530, Sumit Garg wrote:
> > > On Wed, 11 Oct 2023 at 18:07, Jarkko Sakkinen <jarkko@kernel.org> wro=
te:
> > > >=20
> > > > On Wed, 2023-10-11 at 17:47 +0530, Sumit Garg wrote:
> > > > > On Wed, 11 Oct 2023 at 16:04, Jarkko Sakkinen <jarkko@kernel.org>=
 wrote:
> > > > > >=20
> > > > > > On Wed, 2023-10-11 at 13:12 +0300, Jarkko Sakkinen wrote:
> > > > > > > On Wed, 2023-10-11 at 11:27 +0530, Sumit Garg wrote:
> > > > > > > > On Wed, 11 Oct 2023 at 04:46, Jarkko Sakkinen <jarkko@kerne=
l.org> wrote:
> > > > > > > > >=20
> > > > > > > > > Do bind neither static calls nor trusted_key_exit() befor=
e a successful
> > > > > > > > > init, in order to maintain a consistent state. In additio=
n, depart the
> > > > > > > > > init_trusted() in the case of a real error (i.e. getting =
back something
> > > > > > > > > else than -ENODEV).
> > > > > > > > >=20
> > > > > > > > > Reported-by: Linus Torvalds <torvalds@linux-foundation.or=
g>
> > > > > > > > > Closes: https://lore.kernel.org/linux-integrity/CAHk-=3Dw=
hOPoLaWM8S8GgoOPT7a2+nMH5h3TLKtn=3DR_3w4R1_Uvg@mail.gmail.com/
> > > > > > > > > Cc: stable@vger.kernel.org=C2=A0# v5.13+
> > > > > > > > > Fixes: 5d0682be3189 ("KEYS: trusted: Add generic trusted =
keys framework")
> > > > > > > > > Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> > > > > > > > > ---
> > > > > > > > > =C2=A0security/keys/trusted-keys/trusted_core.c | 20 ++++=
++++++----------
> > > > > > > > > =C2=A01 file changed, 10 insertions(+), 10 deletions(-)
> > > > > > > > >=20
> > > > > > > > > diff --git a/security/keys/trusted-keys/trusted_core.c b/=
security/keys/trusted-keys/trusted_core.c
> > > > > > > > > index 85fb5c22529a..fee1ab2c734d 100644
> > > > > > > > > --- a/security/keys/trusted-keys/trusted_core.c
> > > > > > > > > +++ b/security/keys/trusted-keys/trusted_core.c
> > > > > > > > > @@ -358,17 +358,17 @@ static int __init init_trusted(void=
)
> > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!get_random)
> > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 get_random =3D kernel_get_random;
> > > > > > > > >=20
> > > > > > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 static_call_update(trusted_key_seal,
> > > > > > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 trust=
ed_key_sources[i].ops->seal);
> > > > > > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 static_call_update(trusted_key_unseal,
> > > > > > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 trust=
ed_key_sources[i].ops->unseal);
> > > > > > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 static_call_update(trusted_key_get_random,
> > > > > > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 get_r=
andom);
> > > > > > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 trusted_key_exit =3D trusted_key_sources[i].=
ops->exit;
> > > > > > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 migratable =3D trusted_key_sources[i].ops->m=
igratable;
> > > > > > > > > -
> > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D trusted_key_sources[i].ops->init(=
);
> > > > > > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!ret)
> > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!ret) {
> > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 static_call_update(trusted_key_seal, trusted_key_sources[i].ops->seal);
> > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 static_call_update(trusted_key_unseal, trusted_key_sources[i].ops->unse=
al);
> > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 static_call_update(trusted_key_get_random, get_random);
> > > > > > > > > +
> > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 trusted_key_exit =3D trusted_key_sources[i].ops->exit;
> > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 migratable =3D trusted_key_sources[i].ops->migratable;
> > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > > > > > > > > +
> > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!ret || ret !=3D -ENODEV)
> > > > > > > >=20
> > > > > > > > As mentioned in the other thread, we should allow other tru=
st sources
> > > > > > > > to be initialized if the primary one fails.
> > > > > > >=20
> > > > > > > I sent the patch before I received that response but here's w=
hat you
> > > > > > > wrote:
> > > > > > >=20
> > > > > > > "We should give other trust sources a chance to register for =
trusted
> > > > > > > keys if the primary one fails."
> > > > > > >=20
> > > > > > > 1. This condition is lacking an inline comment.
> > > > > > > 2. Neither this response or the one that you pointed out has =
any
> > > > > > > =C2=A0=C2=A0 explanation why for any system failure the proce=
ss should
> > > > > > > =C2=A0=C2=A0 continue.
> > > > > > >=20
> > > > > > > You should really know the situations (e.g. list of posix err=
or
> > > > > > > code) when the process can continue and "allow list" those. T=
his
> > > > > > > way way too abstract. It cannot be let all possible system fa=
ilures
> > > > > > > pass.
> > > > > >=20
> > > > > > And it would nice if it printed out something for legit cases. =
Like
> > > > > > "no device found" etc. And for rest it must really withdraw the=
 whole
> > > > > > process.
> > > > >=20
> > > > > IMO, it would be quite tricky to come up with an allow list. Can =
we
> > > > > keep "EACCES", "EPERM", "ENOTSUPP" etc in that allow list? I thin=
k
> > > > > these are all debatable.
> > > >=20
> > > > Yes, that does sounds reasonable.
> > > >=20
> > > > About the debate. Well, it is better eagerly block and tree falls d=
own
> > > > somewhere we can consider extending the list through a fix.
> > > >=20
> > > > This all wide open is worse than a few glitches somewhere, which ar=
e
> > > > trivial to fix.
> > > >=20
> > >=20
> > > Fair enough, I would suggest we document it appropriately such that i=
t
> > > is clear to the users or somebody looking at the code.
> >=20
> > I went throught the backends on how they implement init:
> >=20
> > 1. Returns -ENODEV when it does not exist.
> > 2. Calls driver_register(). Something is wrong enough if that
> > =C2=A0=C2=A0 fails to rollback the whole procedure.
> > 3. TPM: -ENODEV
> >=20
> > Therefore, I would keep in the existing patch since there is no weird
> > uapi visible legacy behavior to support in the first place. And for
> > that reason there is no good reason to have all those four POSIX rc's
> > in the list.
>=20
> Okay I can live with this patch as long as it doesn't break the
> intended use-case.

Well this sort of policy has been already existing for some time:

	/*
	 * encrypted_keys.ko depends on successful load of this module even if
	 * trusted key implementation is not found.
	 */
	if (ret =3D=3D -ENODEV)
		return 0;

If we would need a list of error codes, then this is also incorrect
implementation because the error codes that you listed should be
also success cases.

BR, Jarkko
