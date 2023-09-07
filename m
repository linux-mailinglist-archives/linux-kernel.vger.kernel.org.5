Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D27CF797EB9
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 00:33:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237646AbjIGWdc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 18:33:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbjIGWdb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 18:33:31 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 643141BC7;
        Thu,  7 Sep 2023 15:33:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0154FC433C7;
        Thu,  7 Sep 2023 22:33:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694126008;
        bh=11OxPGs4D8TG3RACZZ9X30xzAuDPKXdLvJllCq6fnTo=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=A9CB1+8hr6VRvzDP+b4+8UmSv+gg1cQtjVgTQLSreTgDVuN3TsxSV8iw3Neljvbus
         Kr+EiccofWyyWM/0+UPpajzV8JRcNi2VBidD9cKl74APIVZBj7+9H5kBc9v1VmfJ9D
         +N0l48ppypPbnTuJ4CRKkhJZgOsPvxe3uUL/A8pdt39iYL2fWlp2q9VkOo5+7SIdaH
         2E9yAbvowEqBtvye++5wCPbtIeiSLsRtRUeqc4lz9YpQsU+eBTZcbFrwr5L07wcxEL
         K+H9WVjahsSaoFLQNpO6uhDa4WZoumTTd06OMNvryDVDlty/hOJiyeMAUZrWkKuBp1
         dEmlOLpRceqbA==
Message-ID: <fc8023b435f78e02c96fecbe8e7599ee.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAPp5cGTshQJ3aLeLqv=CbaVeg9GnK_k9nsoaWrBKs1dcXzNZow@mail.gmail.com>
References: <20230822134849.3352329-1-alessandro.carminati@gmail.com> <CAPp5cGTshQJ3aLeLqv=CbaVeg9GnK_k9nsoaWrBKs1dcXzNZow@mail.gmail.com>
Subject: Re: [PATCH] Sanitize possible_parent_show to Handle Return Value of of_clk_get_parent_name
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Philip Daly <pdaly@redhat.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Alessandro Carminati <alessandro.carminati@gmail.com>
Date:   Thu, 07 Sep 2023 15:33:25 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Alessandro Carminati (2023-09-07 07:15:36)
> this is a gentle ping
>=20

I couldn't read your email because it was sent to nobody
(unlisted-recipients). Can you resend with a proper To: line?=20

>=20
> Il giorno mar 22 ago 2023 alle ore 15:49 Alessandro Carminati
> <alessandro.carminati@gmail.com> ha scritto:
> >
> > In the possible_parent_show function, ensure proper handling of the ret=
urn
> > value from of_clk_get_parent_name to prevent potential issues arising f=
rom
> > a NULL return.
> > The current implementation invokes seq_puts directly on the result of
> > of_clk_get_parent_name without verifying the return value, which can le=
ad
> > to kernel panic if the function returns NULL.
> >
> > This patch addresses the concern by introducing a check on the return
> > value of of_clk_get_parent_name. If the return value is not NULL, the

Use of_clk_get_parent_name() to signify that it is a function.

> > function proceeds to call seq_puts, providing the returned value as
> > argument.
> > However, if of_clk_get_parent_name returns NULL, the function provides a
> > static string as argument, avoiding the panic.
> >
> > Reported-by: Philip Daly <pdaly@redhat.com>
> > Signed-off-by: Alessandro Carminati (Red Hat) <alessandro.carminati@gma=
il.com>
> > ---

It needs a Fixes tag.

> >  drivers/clk/clk.c | 11 ++++++-----
> >  1 file changed, 6 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> > index c249f9791ae8..ab999644e185 100644
> > --- a/drivers/clk/clk.c
> > +++ b/drivers/clk/clk.c
> > @@ -3416,6 +3416,7 @@ static void possible_parent_show(struct seq_file =
*s, struct clk_core *core,
> >                                  unsigned int i, char terminator)
> >  {
> >         struct clk_core *parent;
> > +       const char *tmp;
> >
> >         /*
> >          * Go through the following options to fetch a parent's name.
> > @@ -3436,12 +3437,12 @@ static void possible_parent_show(struct seq_fil=
e *s, struct clk_core *core,
> >                 seq_puts(s, core->parents[i].name);
> >         else if (core->parents[i].fw_name)
> >                 seq_printf(s, "<%s>(fw)", core->parents[i].fw_name);
> > -       else if (core->parents[i].index >=3D 0)
> > -               seq_puts(s,
> > -                        of_clk_get_parent_name(core->of_node,
> > -                                               core->parents[i].index)=
);
> > -       else
> > +       else if (core->parents[i].index >=3D 0) {
> > +               tmp =3D of_clk_get_parent_name(core->of_node, core->par=
ents[i].index);
> > +               seq_puts(s, tmp ? tmp : "(none)");

How about using seq_printf("%s", ...) instead? That should print out
"(null)" in the case that it is NULL, instead of "(none)" and it is a
one line change.
