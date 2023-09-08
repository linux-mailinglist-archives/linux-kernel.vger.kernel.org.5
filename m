Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29D9479917A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 23:25:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236082AbjIHVZf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 17:25:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbjIHVZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 17:25:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C17FCE46;
        Fri,  8 Sep 2023 14:25:30 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4972BC433C7;
        Fri,  8 Sep 2023 21:25:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694208330;
        bh=EJY/icTAuiiFC13qXg9U3u1ywFzvyEnEUQNXLL2iNaU=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=Qc97QF3iH2jIgFXEJ7aW9gdw2TmbY4PkxfBCoiWNDds1CYYRChbc5dHaxH23/IXPO
         2nXXh/C/5mOEtDurWkuVGoLrHgM6+nWK4aSuKRn/wdyahpE4lzzQptcXuZ/huUbjs7
         /Z5YrPYf/6Hu1CdZn1vcFDflSg0Agm9B3ls8WalUlNPnRJ6tg+aJyUYj8g3g+9fGYs
         uIYhDN75W1ULemJiNR5kc3gQuRU4AxMzSx2+RWLSUz+tiQOMoIBK9qNU2A2VnUHXG5
         2kdYKtIavnL+fD7k0dxmHTF1gJhrLaxVZ+jbdbCgJmkAyCFQlYmJGOOQjGkjUI5u/i
         T2apJFmY79PLA==
Message-ID: <fde1b20074cf5c0e0bc1944959486150.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAPp5cGQ0Wp4my93tEm9-Huc6R+22zCj91mNJsPpGTFoo49=mcQ@mail.gmail.com>
References: <20230822134849.3352329-1-alessandro.carminati@gmail.com> <CAPp5cGTshQJ3aLeLqv=CbaVeg9GnK_k9nsoaWrBKs1dcXzNZow@mail.gmail.com> <fc8023b435f78e02c96fecbe8e7599ee.sboyd@kernel.org> <CAPp5cGQ0Wp4my93tEm9-Huc6R+22zCj91mNJsPpGTFoo49=mcQ@mail.gmail.com>
Subject: Re: [PATCH] Sanitize possible_parent_show to Handle Return Value of of_clk_get_parent_name
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Philip Daly <pdaly@redhat.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Alessandro Carminati <alessandro.carminati@gmail.com>
Date:   Fri, 08 Sep 2023 14:25:27 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Alessandro Carminati (2023-09-08 01:36:14)
> Hello Stephen,
> Thank you for your review and the time you dedicated to it.
>=20
> Il giorno ven 8 set 2023 alle ore 00:33 Stephen Boyd
> <sboyd@kernel.org> ha scritto:
> >
> > Quoting Alessandro Carminati (2023-09-07 07:15:36)
> > > this is a gentle ping
> > >
> >
> > I couldn't read your email because it was sent to nobody
> > (unlisted-recipients). Can you resend with a proper To: line?
> >
> > >
> > > Il giorno mar 22 ago 2023 alle ore 15:49 Alessandro Carminati
> > > <alessandro.carminati@gmail.com> ha scritto:
> > > >
> > > > In the possible_parent_show function, ensure proper handling of the=
 return
> > > > value from of_clk_get_parent_name to prevent potential issues arisi=
ng from
> > > > a NULL return.
> > > > The current implementation invokes seq_puts directly on the result =
of
> > > > of_clk_get_parent_name without verifying the return value, which ca=
n lead
> > > > to kernel panic if the function returns NULL.
> > > >
> > > > This patch addresses the concern by introducing a check on the retu=
rn
> > > > value of of_clk_get_parent_name. If the return value is not NULL, t=
he
> >
> > Use of_clk_get_parent_name() to signify that it is a function.
> >
> > > > function proceeds to call seq_puts, providing the returned value as
> > > > argument.
> > > > However, if of_clk_get_parent_name returns NULL, the function provi=
des a
> > > > static string as argument, avoiding the panic.
> > > >
> > > > Reported-by: Philip Daly <pdaly@redhat.com>
> > > > Signed-off-by: Alessandro Carminati (Red Hat) <alessandro.carminati=
@gmail.com>
> > > > ---
> >
> > It needs a Fixes tag.
> Sure!
> I need to be more careful on this.
>=20
> >
> > > >  drivers/clk/clk.c | 11 ++++++-----
> > > >  1 file changed, 6 insertions(+), 5 deletions(-)
> > > >
> > > > diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> > > > index c249f9791ae8..ab999644e185 100644
> > > > --- a/drivers/clk/clk.c
> > > > +++ b/drivers/clk/clk.c
> > > > @@ -3416,6 +3416,7 @@ static void possible_parent_show(struct seq_f=
ile *s, struct clk_core *core,
> > > >                                  unsigned int i, char terminator)
> > > >  {
> > > >         struct clk_core *parent;
> > > > +       const char *tmp;
> > > >
> > > >         /*
> > > >          * Go through the following options to fetch a parent's nam=
e.
> > > > @@ -3436,12 +3437,12 @@ static void possible_parent_show(struct seq=
_file *s, struct clk_core *core,
> > > >                 seq_puts(s, core->parents[i].name);
> > > >         else if (core->parents[i].fw_name)
> > > >                 seq_printf(s, "<%s>(fw)", core->parents[i].fw_name);
> > > > -       else if (core->parents[i].index >=3D 0)
> > > > -               seq_puts(s,
> > > > -                        of_clk_get_parent_name(core->of_node,
> > > > -                                               core->parents[i].in=
dex));
> > > > -       else
> > > > +       else if (core->parents[i].index >=3D 0) {
> > > > +               tmp =3D of_clk_get_parent_name(core->of_node, core-=
>parents[i].index);
> > > > +               seq_puts(s, tmp ? tmp : "(none)");
> >
> > How about using seq_printf("%s", ...) instead? That should print out
> > "(null)" in the case that it is NULL, instead of "(none)" and it is a
> > one line change.
>=20
> I did consider using seq_printf("%s", ...) as an alternative approach to
> address the issue initially.
> However, after a review of the file's history, I arrived at a different
> conclusion.
>=20
> The commit [1] that introduced this bug was primarily focused on replacing
> seq_printf() with seq_putc().
> I considered that to maintain code consistency and align with the intenti=
ons
> of that commit, it may be more appropriate to continue using seq_putc() in
> this particular instance.
> I agree however with the idea of rolling back that particular change, but
> in this case, we perhaps may want to consider also [2], a similar change =
made
> in the same period.
> I haven't proceeded with a patch submission for it[2], mainly due to the =
lack
> of evidence of a kernel splash related to it and my uncertainty around the
> fact that can exist use cases where the name field in the struct cgroup_s=
ubsys
> can hit that code set to NULL.

Is nothing actually wrong? And this is a speculative patch?

All other arms of this conditional statement check the validity of the
pointer before printing the string. And when the parent isn't known we
print "(missing)", so it looks like we should do that instead. How about
this patch?

----8<---
diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index c249f9791ae8..473563bc7496 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -3416,6 +3416,7 @@ static void possible_parent_show(struct seq_file *s, =
struct clk_core *core,
 				 unsigned int i, char terminator)
 {
 	struct clk_core *parent;
+	const char *name =3D NULL;
=20
 	/*
 	 * Go through the following options to fetch a parent's name.
@@ -3430,18 +3431,20 @@ static void possible_parent_show(struct seq_file *s=
, struct clk_core *core,
 	 * registered (yet).
 	 */
 	parent =3D clk_core_get_parent_by_index(core, i);
-	if (parent)
+	if (parent) {
 		seq_puts(s, parent->name);
-	else if (core->parents[i].name)
+	} else if (core->parents[i].name) {
 		seq_puts(s, core->parents[i].name);
-	else if (core->parents[i].fw_name)
+	} else if (core->parents[i].fw_name) {
 		seq_printf(s, "<%s>(fw)", core->parents[i].fw_name);
-	else if (core->parents[i].index >=3D 0)
-		seq_puts(s,
-			 of_clk_get_parent_name(core->of_node,
-						core->parents[i].index));
-	else
-		seq_puts(s, "(missing)");
+	} else {
+		if (core->parents[i].index >=3D 0)
+			name =3D of_clk_get_parent_name(core->of_node, core->parents[i].index);
+		if (!name)
+			name =3D "(missing)";
+
+		seq_puts(s, name);
+	}
=20
 	seq_putc(s, terminator);
 }
