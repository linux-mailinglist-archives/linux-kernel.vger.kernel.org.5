Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01C587C565B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 16:05:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235112AbjJKOFV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 10:05:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232329AbjJKOFR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 10:05:17 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98E219E;
        Wed, 11 Oct 2023 07:05:15 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79A2EC433C8;
        Wed, 11 Oct 2023 14:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697033115;
        bh=YxWa6wRi50kkRgmvr3rIDECtS1ebZ2pMVIPK1wPGjUk=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=p2aK7odQCK6lKXjxAPBb8TQsODJbbh0J/mlp5UeXtOc4zZZIMjvJ5mXMFuyIqj7/O
         m2ykHotL7cuxc7GIAuugHkpXKlchGe+ZIpesJsHkFW8cifNG8LOjT2VZHJnvuhCjM7
         1EcLI7BePAwJVskw+tIznReiPdpSGBmasfQ7i9YONu1CGUtKnPm2lULYcRdVM3i1gB
         BLnDDsYJ7mGjGBcEq0udEQ1WNJZ7pee8RR4uYh/PhSrdu93mH/XcY2QgJeZdJBBToe
         qyC+nZ94fJ1yAKgwmN/mSr24QI8HEUTVdrZMel0p3UP0LpRzuElibJFq7UmBsE3Sh+
         tshmItWemMc9Q==
Message-ID: <6b1c0255de20752b55b902df0882c018cf75032d.camel@kernel.org>
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
Date:   Wed, 11 Oct 2023 17:05:10 +0300
In-Reply-To: <bdf8dbb2e1aeeb6396d7a03b8c00d0db729c602d.camel@kernel.org>
References: <20231010231616.3122392-1-jarkko@kernel.org>
         <CAFA6WYMdrCfqMVExYBbhCK7vUSQffyUfSWpQO0=HeQc6Edz9OA@mail.gmail.com>
         <186a4b62517ead88df8c3c0e9e9585e88f9a6fd8.camel@kernel.org>
         <0aeb4d88952aff53c5c1a40b547a9819ebd1947e.camel@kernel.org>
         <CAFA6WYObvJvQv=-JJ5gnmFqJKbT=4JnT+ErC=iB1KfnYfVn7Ag@mail.gmail.com>
         <79fe0b97e2f5d1f02d08c9f633b7c0da13dc9127.camel@kernel.org>
         <CAFA6WYMrg3VBYvdV8Or==YK_qATk22bL+_ryDC-oO4jVf7DCWg@mail.gmail.com>
         <b70d6be5980185a4fb4205e71c56111183e1f160.camel@kernel.org>
         <CAFA6WYN0vXWZveAkzOfV_6Kki77SxgX7C=Xqe9brZMX1Dj2iLg@mail.gmail.com>
         <bdf8dbb2e1aeeb6396d7a03b8c00d0db729c602d.camel@kernel.org>
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

On Wed, 2023-10-11 at 16:55 +0300, Jarkko Sakkinen wrote:
> On Wed, 2023-10-11 at 19:12 +0530, Sumit Garg wrote:
> > On Wed, 11 Oct 2023 at 18:36, Jarkko Sakkinen <jarkko@kernel.org> wrote=
:
> > >=20
> > > On Wed, 2023-10-11 at 18:25 +0530, Sumit Garg wrote:
> > > > On Wed, 11 Oct 2023 at 18:07, Jarkko Sakkinen <jarkko@kernel.org> w=
rote:
> > > > >=20
> > > > > On Wed, 2023-10-11 at 17:47 +0530, Sumit Garg wrote:
> > > > > > On Wed, 11 Oct 2023 at 16:04, Jarkko Sakkinen <jarkko@kernel.or=
g> wrote:
> > > > > > >=20
> > > > > > > On Wed, 2023-10-11 at 13:12 +0300, Jarkko Sakkinen wrote:
> > > > > > > > On Wed, 2023-10-11 at 11:27 +0530, Sumit Garg wrote:
> > > > > > > > > On Wed, 11 Oct 2023 at 04:46, Jarkko Sakkinen <jarkko@ker=
nel.org> wrote:
> > > > > > > > > >=20
> > > > > > > > > > Do bind neither static calls nor trusted_key_exit() bef=
ore a successful
> > > > > > > > > > init, in order to maintain a consistent state. In addit=
ion, depart the
> > > > > > > > > > init_trusted() in the case of a real error (i.e. gettin=
g back something
> > > > > > > > > > else than -ENODEV).
> > > > > > > > > >=20
> > > > > > > > > > Reported-by: Linus Torvalds <torvalds@linux-foundation.=
org>
> > > > > > > > > > Closes: https://lore.kernel.org/linux-integrity/CAHk-=
=3DwhOPoLaWM8S8GgoOPT7a2+nMH5h3TLKtn=3DR_3w4R1_Uvg@mail.gmail.com/
> > > > > > > > > > Cc: stable@vger.kernel.org=C2=A0# v5.13+
> > > > > > > > > > Fixes: 5d0682be3189 ("KEYS: trusted: Add generic truste=
d keys framework")
> > > > > > > > > > Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> > > > > > > > > > ---
> > > > > > > > > > =C2=A0security/keys/trusted-keys/trusted_core.c | 20 ++=
++++++++----------
> > > > > > > > > > =C2=A01 file changed, 10 insertions(+), 10 deletions(-)
> > > > > > > > > >=20
> > > > > > > > > > diff --git a/security/keys/trusted-keys/trusted_core.c =
b/security/keys/trusted-keys/trusted_core.c
> > > > > > > > > > index 85fb5c22529a..fee1ab2c734d 100644
> > > > > > > > > > --- a/security/keys/trusted-keys/trusted_core.c
> > > > > > > > > > +++ b/security/keys/trusted-keys/trusted_core.c
> > > > > > > > > > @@ -358,17 +358,17 @@ static int __init init_trusted(vo=
id)
> > > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!get_random)
> > > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 get_random =3D kernel_get_random;
> > > > > > > > > >=20
> > > > > > > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 static_call_update(trusted_key_seal,
> > > > > > > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 trust=
ed_key_sources[i].ops->seal);
> > > > > > > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 static_call_update(trusted_key_unseal,
> > > > > > > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 trust=
ed_key_sources[i].ops->unseal);
> > > > > > > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 static_call_update(trusted_key_get_random,
> > > > > > > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 get_r=
andom);
> > > > > > > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 trusted_key_exit =3D trusted_key_sources[i].=
ops->exit;
> > > > > > > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 migratable =3D trusted_key_sources[i].ops->m=
igratable;
> > > > > > > > > > -
> > > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D trusted_key_sources[i].ops->in=
it();
> > > > > > > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!ret)
> > > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!ret) {
> > > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 static_call_update(trusted_key_seal, trusted_key_sources[i].ops->seal);
> > > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 static_call_update(trusted_key_unseal, trusted_key_sources[i].ops->unse=
al);
> > > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 static_call_update(trusted_key_get_random, get_random);
> > > > > > > > > > +
> > > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 trusted_key_exit =3D trusted_key_sources[i].ops->exit;
> > > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 migratable =3D trusted_key_sources[i].ops->migratable;
> > > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > > > > > > > > > +
> > > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!ret || ret !=3D -ENODEV)
> > > > > > > > >=20
> > > > > > > > > As mentioned in the other thread, we should allow other t=
rust sources
> > > > > > > > > to be initialized if the primary one fails.
> > > > > > > >=20
> > > > > > > > I sent the patch before I received that response but here's=
 what you
> > > > > > > > wrote:
> > > > > > > >=20
> > > > > > > > "We should give other trust sources a chance to register fo=
r trusted
> > > > > > > > keys if the primary one fails."
> > > > > > > >=20
> > > > > > > > 1. This condition is lacking an inline comment.
> > > > > > > > 2. Neither this response or the one that you pointed out ha=
s any
> > > > > > > > =C2=A0=C2=A0 explanation why for any system failure the pro=
cess should
> > > > > > > > =C2=A0=C2=A0 continue.
> > > > > > > >=20
> > > > > > > > You should really know the situations (e.g. list of posix e=
rror
> > > > > > > > code) when the process can continue and "allow list" those.=
 This
> > > > > > > > way way too abstract. It cannot be let all possible system =
failures
> > > > > > > > pass.
> > > > > > >=20
> > > > > > > And it would nice if it printed out something for legit cases=
. Like
> > > > > > > "no device found" etc. And for rest it must really withdraw t=
he whole
> > > > > > > process.
> > > > > >=20
> > > > > > IMO, it would be quite tricky to come up with an allow list. Ca=
n we
> > > > > > keep "EACCES", "EPERM", "ENOTSUPP" etc in that allow list? I th=
ink
> > > > > > these are all debatable.
> > > > >=20
> > > > > Yes, that does sounds reasonable.
> > > > >=20
> > > > > About the debate. Well, it is better eagerly block and tree falls=
 down
> > > > > somewhere we can consider extending the list through a fix.
> > > > >=20
> > > > > This all wide open is worse than a few glitches somewhere, which =
are
> > > > > trivial to fix.
> > > > >=20
> > > >=20
> > > > Fair enough, I would suggest we document it appropriately such that=
 it
> > > > is clear to the users or somebody looking at the code.
> > >=20
> > > I went throught the backends on how they implement init:
> > >=20
> > > 1. Returns -ENODEV when it does not exist.
> > > 2. Calls driver_register(). Something is wrong enough if that
> > > =C2=A0=C2=A0 fails to rollback the whole procedure.
> > > 3. TPM: -ENODEV
> > >=20
> > > Therefore, I would keep in the existing patch since there is no weird
> > > uapi visible legacy behavior to support in the first place. And for
> > > that reason there is no good reason to have all those four POSIX rc's
> > > in the list.
> >=20
> > Okay I can live with this patch as long as it doesn't break the
> > intended use-case.
>=20
> Well this sort of policy has been already existing for some time:
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/*
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * encrypted_keys.ko depe=
nds on successful load of this module even if
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * trusted key implementa=
tion is not found.
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (ret =3D=3D -ENODEV)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0return 0;
>=20
> If we would need a list of error codes, then this is also incorrect
> implementation because the error codes that you listed should be
> also success cases.

The dead obvious constraint here is that whatever error codes are
processed they need to be exact same anyway right?

If things fall apart you should really not continue. This is IMHO
categorizes as a critical bug, not just debatable aspect on how
subsystems are engineered. I.e.I do not consider this as any sort
of API discussion per se.

BR, Jarkko
