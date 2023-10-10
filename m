Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85DBA7BFF55
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 16:31:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232779AbjJJObd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 10:31:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232993AbjJJObc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 10:31:32 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBD72AC;
        Tue, 10 Oct 2023 07:31:30 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79BBEC433C8;
        Tue, 10 Oct 2023 14:31:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696948290;
        bh=E6qmXnfM79rt9DvpUcOLVl3EFr6inxFqSczU8DTqSk8=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=gH2yL6N0KLhvEhoOnb9yn5yIJS+3KBFb5lZc22sLtaAOGFdGWtFZ6gajXvQv5D7XT
         RK8g+EQmNS/yQajQSiaxerd6q+C6rL5YOz9xV6HLFEP3T1HMWktFaEHZ9omVp+/vYE
         THBjSxeXQ706bygv6W2brB9PytFYa562260owe47KQk7v4LyFE5f62gXp7k1cNnbVb
         scYAwYXDYSplFnU5xQafOLTbj1hAssc8bT1qN9nMQipg6ERGggxZKVOabGnJs3Jcyg
         EPRc/VCzqujLP3cRQNMCLUX0MBbr8d27BiQ3mT7iVjYeasaxz78L5biIalJ98/mpe3
         SpJqRP4fdQ0UA==
Message-ID: <786c9edfb4324eff764a279c96656db17d380b47.camel@kernel.org>
Subject: Re: [PATCH v2] KEYS: trusted: Remove redundant static calls usage
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Sumit Garg <sumit.garg@linaro.org>
Cc:     torvalds@linux-foundation.org, peterz@infradead.org,
        zohar@linux.ibm.com, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org, jejb@linux.ibm.com,
        David.Kaplan@amd.com, bp@alien8.de, mingo@kernel.org,
        x86@kernel.org, regressions@leemhuis.info,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>
Date:   Tue, 10 Oct 2023 17:31:25 +0300
In-Reply-To: <47e5f0a7-e3ee-79c8-7460-2c67cf9960cc@pengutronix.de>
References: <20231006051801.423973-1-sumit.garg@linaro.org>
         <8eeac047a59667912a45b21050a6e4c57d7cccd5.camel@kernel.org>
         <CAFA6WYNamspdK=RakirdS3fiHrmmaPXcgEcZeNn5z2DRNdE3Rw@mail.gmail.com>
         <1de1ace90f1645fc629c075826aa67eda8dfd138.camel@kernel.org>
         <47e5f0a7-e3ee-79c8-7460-2c67cf9960cc@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-10-10 at 16:19 +0200, Ahmad Fatoum wrote:
> Hello Jarkko,
>=20
> On 10.10.23 15:49, Jarkko Sakkinen wrote:
> > On Tue, 2023-10-10 at 18:44 +0530, Sumit Garg wrote:
> > > On Tue, 10 Oct 2023 at 18:03, Jarkko Sakkinen <jarkko@kernel.org> wro=
te:
> > > >=20
> > > > On Fri, 2023-10-06 at 10:48 +0530, Sumit Garg wrote:
> > > > > Static calls invocations aren't well supported from module __init=
 and
> > > > > __exit functions. Especially the static call from cleanup_trusted=
() led
> > > > > to a crash on x86 kernel with CONFIG_DEBUG_VIRTUAL=3Dy.
> > > > >=20
> > > > > However, the usage of static call invocations for trusted_key_ini=
t()
> > > > > and trusted_key_exit() don't add any value from either a performa=
nce or
> > > > > security perspective. Hence switch to use indirect function calls=
 instead.
> > > > >=20
> > > > > Note here that although it will fix the current crash report, ult=
imately
> > > > > the static call infrastructure should be fixed to either support =
its
> > > > > future usage from module __init and __exit functions or not.
> > > > >=20
> > > > > Reported-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> > > > > Link: https://lore.kernel.org/lkml/ZRhKq6e5nF%2F4ZIV1@fedora/#t
> > > > > Fixes: 5d0682be3189 ("KEYS: trusted: Add generic trusted keys fra=
mework")
> > > > > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > > > > ---
> > > > >=20
> > > > > Changes in v2:
> > > > > - Polish commit message as per comments from Mimi
> > > > >=20
> > > > > =C2=A0security/keys/trusted-keys/trusted_core.c | 13 +++++-------=
-
> > > > > =C2=A01 file changed, 5 insertions(+), 8 deletions(-)
> > > > >=20
> > > > > diff --git a/security/keys/trusted-keys/trusted_core.c b/security=
/keys/trusted-keys/trusted_core.c
> > > > > index c6fc50d67214..85fb5c22529a 100644
> > > > > --- a/security/keys/trusted-keys/trusted_core.c
> > > > > +++ b/security/keys/trusted-keys/trusted_core.c
> > > > > @@ -44,13 +44,12 @@ static const struct trusted_key_source truste=
d_key_sources[] =3D {
> > > > > =C2=A0#endif
> > > > > =C2=A0};
> > > > >=20
> > > > > -DEFINE_STATIC_CALL_NULL(trusted_key_init, *trusted_key_sources[0=
].ops->init);
> > > > > =C2=A0DEFINE_STATIC_CALL_NULL(trusted_key_seal, *trusted_key_sour=
ces[0].ops->seal);
> > > > > =C2=A0DEFINE_STATIC_CALL_NULL(trusted_key_unseal,
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 *trusted_key_sources[0].ops->unseal);
> > > > > =C2=A0DEFINE_STATIC_CALL_NULL(trusted_key_get_random,
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 *trusted_key_sources[0].ops->get_random);
> > > > > -DEFINE_STATIC_CALL_NULL(trusted_key_exit, *trusted_key_sources[0=
].ops->exit);
> > > > > +static void (*trusted_key_exit)(void);
> > > > > =C2=A0static unsigned char migratable;
> > > > >=20
> > > > > =C2=A0enum {
> > > > > @@ -359,19 +358,16 @@ static int __init init_trusted(void)
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!get_random)
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 get_random =3D kernel_get_random;
> > > > >=20
> > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 static_call_update(trusted_key_init,
> > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 trusted_key_so=
urces[i].ops->init);
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 static_call_update(trusted_key_seal,
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 trusted_=
key_sources[i].ops->seal);
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 static_call_update(trusted_key_unseal,
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 trusted_=
key_sources[i].ops->unseal);
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 static_call_update(trusted_key_get_random,
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 get_rand=
om);
> > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 static_call_update(trusted_key_exit,
> > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 trusted_key_so=
urces[i].ops->exit);
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 trusted_key_exit =3D trusted_key_sources[i].ops->exit=
;
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 migratable =3D trusted_key_sources[i].ops->migr=
atable;
> > > > >=20
> > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 ret =3D static_call(trusted_key_init)();
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 ret =3D trusted_key_sources[i].ops->init();
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!ret)
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 break;
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> > > > > @@ -388,7 +384,8 @@ static int __init init_trusted(void)
> > > > >=20
> > > > > =C2=A0static void __exit cleanup_trusted(void)
> > > > > =C2=A0{
> > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 static_call_cond(trusted_ke=
y_exit)();
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (trusted_key_exit)
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 (*trusted_key_exit)();
> > > > > =C2=A0}
> > > > >=20
> > > > > =C2=A0late_initcall(init_trusted);
> > > >=20
> > > > Would it be less confusing to require trusted_key_exit from each?
> > > >=20
> > >=20
> > > It is already required for each trust source to provide exit callback
> > > but this NULL check was added via this fix [1] in case there isn't an=
y
> > > trust source present.
> > >=20
> > > [1] https://lkml.kernel.org/stable/20220126184155.220814-1-dave.kleik=
amp@oracle.com/
> >=20
> > I'd considering creating a placeholder trusted_key_default_exit() with
> > perhaps pr_debug() statement acknowledging it getting called.
> >=20
> > Hmm.. if we had that I wonder if we could get away with __weak... Then
> > you would not need to assign anything. This is not through-out analyzed=
.
> > Tbh I'm not sure how module loader handles this type of scenario but
> > at least the placeholder function would make sense in any case.
>=20
> If you define a default exit function as __weak and expect trusted key so=
urces
> to override it, you can only have one trust source at most in the compile=
d
> kernel and no boot-time selection would be possible.

Right, got it, thank you.

So, I still would consider trusted_key_default_exit() and assign that in th=
e
declaration to trusted_exit.

BR, Jarkko
