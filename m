Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 829467C54D4
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 15:07:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234938AbjJKNHd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 09:07:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231931AbjJKNHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 09:07:31 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E45C58F;
        Wed, 11 Oct 2023 06:07:29 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4C34C433C7;
        Wed, 11 Oct 2023 13:07:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697029649;
        bh=PZbkwNpj85GGGtIWqLhOxru3XfF8afsoSJk3oU+3ZLc=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=oVz0KUYsB4BjpLqBt3bdsVUXDDF9lBuM9ahJzRep8fDwbsX7jo+8+SD0i+qcJdZhK
         V307WYYE0Tde0AaqcFhFb9kZ/PTaA93EdwKk8G6OgrBJ55WWhIbJ1sEziAsP+IgQXa
         K8PpUwvmEQ5uMtrRAfkskMmD+rGtozabg+Uqz29mE1mTVwM/F2EMQbjC9Yer80pnoO
         L6fWToJ4Fyxt+xFI3EriCX2j60sks2lofzSyK2XG1FmwKeOOr6gdRJSdF/jcKrC7ie
         MDJ2Mr9FO1zj2q1WzU4oihJZK1SnKMhb1WUvzAIcRsGEmPJ4UccWCn2iH2ai9spbgc
         pbp6u4ysHgL+g==
Message-ID: <45297add30c17d6b07e43a9d035f38e9b2828bfe.camel@kernel.org>
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
Date:   Wed, 11 Oct 2023 16:07:24 +0300
In-Reply-To: <b70d6be5980185a4fb4205e71c56111183e1f160.camel@kernel.org>
References: <20231010231616.3122392-1-jarkko@kernel.org>
         <CAFA6WYMdrCfqMVExYBbhCK7vUSQffyUfSWpQO0=HeQc6Edz9OA@mail.gmail.com>
         <186a4b62517ead88df8c3c0e9e9585e88f9a6fd8.camel@kernel.org>
         <0aeb4d88952aff53c5c1a40b547a9819ebd1947e.camel@kernel.org>
         <CAFA6WYObvJvQv=-JJ5gnmFqJKbT=4JnT+ErC=iB1KfnYfVn7Ag@mail.gmail.com>
         <79fe0b97e2f5d1f02d08c9f633b7c0da13dc9127.camel@kernel.org>
         <CAFA6WYMrg3VBYvdV8Or==YK_qATk22bL+_ryDC-oO4jVf7DCWg@mail.gmail.com>
         <b70d6be5980185a4fb4205e71c56111183e1f160.camel@kernel.org>
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

On Wed, 2023-10-11 at 16:06 +0300, Jarkko Sakkinen wrote:
> On Wed, 2023-10-11 at 18:25 +0530, Sumit Garg wrote:
> > On Wed, 11 Oct 2023 at 18:07, Jarkko Sakkinen <jarkko@kernel.org> wrote=
:
> > >=20
> > > On Wed, 2023-10-11 at 17:47 +0530, Sumit Garg wrote:
> > > > On Wed, 11 Oct 2023 at 16:04, Jarkko Sakkinen <jarkko@kernel.org> w=
rote:
> > > > >=20
> > > > > On Wed, 2023-10-11 at 13:12 +0300, Jarkko Sakkinen wrote:
> > > > > > On Wed, 2023-10-11 at 11:27 +0530, Sumit Garg wrote:
> > > > > > > On Wed, 11 Oct 2023 at 04:46, Jarkko Sakkinen <jarkko@kernel.=
org> wrote:
> > > > > > > >=20
> > > > > > > > Do bind neither static calls nor trusted_key_exit() before =
a successful
> > > > > > > > init, in order to maintain a consistent state. In addition,=
 depart the
> > > > > > > > init_trusted() in the case of a real error (i.e. getting ba=
ck something
> > > > > > > > else than -ENODEV).
> > > > > > > >=20
> > > > > > > > Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
> > > > > > > > Closes: https://lore.kernel.org/linux-integrity/CAHk-=3DwhO=
PoLaWM8S8GgoOPT7a2+nMH5h3TLKtn=3DR_3w4R1_Uvg@mail.gmail.com/
> > > > > > > > Cc: stable@vger.kernel.org=C2=A0# v5.13+
> > > > > > > > Fixes: 5d0682be3189 ("KEYS: trusted: Add generic trusted ke=
ys framework")
> > > > > > > > Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> > > > > > > > ---
> > > > > > > > =C2=A0security/keys/trusted-keys/trusted_core.c | 20 ++++++=
++++----------
> > > > > > > > =C2=A01 file changed, 10 insertions(+), 10 deletions(-)
> > > > > > > >=20
> > > > > > > > diff --git a/security/keys/trusted-keys/trusted_core.c b/se=
curity/keys/trusted-keys/trusted_core.c
> > > > > > > > index 85fb5c22529a..fee1ab2c734d 100644
> > > > > > > > --- a/security/keys/trusted-keys/trusted_core.c
> > > > > > > > +++ b/security/keys/trusted-keys/trusted_core.c
> > > > > > > > @@ -358,17 +358,17 @@ static int __init init_trusted(void)
> > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!get_random)
> > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 get_random =3D kernel_get_random;
> > > > > > > >=20
> > > > > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 static_call_update(trusted_key_seal,
> > > > > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 trusted_=
key_sources[i].ops->seal);
> > > > > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 static_call_update(trusted_key_unseal,
> > > > > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 trusted_=
key_sources[i].ops->unseal);
> > > > > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 static_call_update(trusted_key_get_random,
> > > > > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 get_rand=
om);
> > > > > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 trusted_key_exit =3D trusted_key_sources[i].ops=
->exit;
> > > > > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 migratable =3D trusted_key_sources[i].ops->migr=
atable;
> > > > > > > > -
> > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D trusted_key_sources[i].ops->init(=
);
> > > > > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!ret)
> > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!ret) {
> > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 static_call_update(trusted_key_seal, trusted_key_sources[i].ops->seal);
> > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 static_call_update(trusted_key_unseal, trusted_key_sources[i].ops->unseal)=
;
> > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 static_call_update(trusted_key_get_random, get_random);
> > > > > > > > +
> > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 trusted_key_exit =3D trusted_key_sources[i].ops->exit;
> > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 migratable =3D trusted_key_sources[i].ops->migratable;
> > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > > > > > > > +
> > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!ret || ret !=3D -ENODEV)
> > > > > > >=20
> > > > > > > As mentioned in the other thread, we should allow other trust=
 sources
> > > > > > > to be initialized if the primary one fails.
> > > > > >=20
> > > > > > I sent the patch before I received that response but here's wha=
t you
> > > > > > wrote:
> > > > > >=20
> > > > > > "We should give other trust sources a chance to register for tr=
usted
> > > > > > keys if the primary one fails."
> > > > > >=20
> > > > > > 1. This condition is lacking an inline comment.
> > > > > > 2. Neither this response or the one that you pointed out has an=
y
> > > > > > =C2=A0=C2=A0 explanation why for any system failure the process=
 should
> > > > > > =C2=A0=C2=A0 continue.
> > > > > >=20
> > > > > > You should really know the situations (e.g. list of posix error
> > > > > > code) when the process can continue and "allow list" those. Thi=
s
> > > > > > way way too abstract. It cannot be let all possible system fail=
ures
> > > > > > pass.
> > > > >=20
> > > > > And it would nice if it printed out something for legit cases. Li=
ke
> > > > > "no device found" etc. And for rest it must really withdraw the w=
hole
> > > > > process.
> > > >=20
> > > > IMO, it would be quite tricky to come up with an allow list. Can we
> > > > keep "EACCES", "EPERM", "ENOTSUPP" etc in that allow list? I think
> > > > these are all debatable.
> > >=20
> > > Yes, that does sounds reasonable.
> > >=20
> > > About the debate. Well, it is better eagerly block and tree falls dow=
n
> > > somewhere we can consider extending the list through a fix.
> > >=20
> > > This all wide open is worse than a few glitches somewhere, which are
> > > trivial to fix.
> > >=20
> >=20
> > Fair enough, I would suggest we document it appropriately such that it
> > is clear to the users or somebody looking at the code.
>=20
> I went throught the backends on how they implement init:
>=20
>=20
CAAM:
> 1. Returns -ENODEV when it does not exist.
TEE:
> 2. Calls driver_register(). Something is wrong enough if that
> =C2=A0=C2=A0 fails to rollback the whole procedure.
> 3. TPM: -ENODEV

BR, Jarkko
