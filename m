Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DFBB7828F0
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 14:25:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234865AbjHUMZB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 08:25:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230526AbjHUMZA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 08:25:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C51DBC;
        Mon, 21 Aug 2023 05:24:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D572663406;
        Mon, 21 Aug 2023 12:24:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02EA3C433CA;
        Mon, 21 Aug 2023 12:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692620698;
        bh=VRMEzTu4HApcZfH6koLO+FGvNzNpz2Cpuse+j31Gmyc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=PC3sZlf1GGm6MBIy79Xbg8kc17r00L87DsHPYLodZngr2CMlwNrhftpTeQF5+1DQc
         kb3rvt/x8MvlktoR1kKKW2WgwTlmtcCpeWMTb89Kw9jQaL/WM2SPWHapoOaEnCLZ5a
         c5seB4sC16/XdgX4imm1xlx7b6oOzKJPyZHgENZGo9lsYDftrY8XJqDgSU6r3c36rX
         UbjFiTL6mQkvVgfeiGomewiNh6QVG2fdLvrUS+3T3mGtWkHduUzKWS5S4PAvYJoaYg
         Kl6Q9rl9XEiim51JuubyfOwEvg03pAmybt7sOu1pl9eR38BzeRFfoeWfpMvOdS0Srb
         krEGCvkEF1xyQ==
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2b9c907bc68so56359441fa.2;
        Mon, 21 Aug 2023 05:24:57 -0700 (PDT)
X-Gm-Message-State: AOJu0Yzuby765VMgvKcmbUhoLk/HaP9ZTl1RR1qENsGALgrNMIUP1OaA
        tk7cJDXeXqXJjGTObcnLIhhbegZiD7T47xMMTQ==
X-Google-Smtp-Source: AGHT+IFxA1bwBYUO7AewyfzEgVRdRAlaH+I45xGQuyUXPi6lnP6fLXI9KGcWScVC5t7iWGx7bMGpNOmboiIovP+74Tk=
X-Received: by 2002:a05:651c:8d:b0:2b9:b6e7:bd7 with SMTP id
 13-20020a05651c008d00b002b9b6e70bd7mr4912302ljq.29.1692620696018; Mon, 21 Aug
 2023 05:24:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230801-dt-changeset-fixes-v3-0-5f0410e007dd@kernel.org>
 <20230801-dt-changeset-fixes-v3-5-5f0410e007dd@kernel.org> <ZONBMMVrzuu53hwC@smile.fi.intel.com>
In-Reply-To: <ZONBMMVrzuu53hwC@smile.fi.intel.com>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 21 Aug 2023 07:24:43 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJRQ0VFLHJYo6XHnUnyhtn3X6F2ZedsftnsviO_wOtcGw@mail.gmail.com>
Message-ID: <CAL_JsqJRQ0VFLHJYo6XHnUnyhtn3X6F2ZedsftnsviO_wOtcGw@mail.gmail.com>
Subject: Re: [PATCH v3 5/6] of: dynamic: Move dead property list check into
 property add/update functions
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        "Enrico Weigelt, metux IT consult" <info@metux.net>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Petr Mladek <pmladek@suse.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 21, 2023 at 5:49=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Fri, Aug 18, 2023 at 03:41:00PM -0500, Rob Herring wrote:
> > The changeset code checks for a property in the deadprops list when
> > adding/updating a property, but of_add_property() and
> > of_update_property() do not. As the users of these functions are pretty
> > simple, they have not hit this scenario or else the property lists
> > would get corrupted.
> >
> > With this there are 3 cases of removing a property from either deadprop=
s
> > or properties lists, so add a helper to find and remove a matching
> > property.
>
> ...
>
> > v3:
> >  - Keep existing style in deadprops loop
>
> Not sure where exactly in the code that one, but...

That was your previous comment...

>
> ...
>
> >  int __of_remove_property(struct device_node *np, struct property *prop=
)
> >  {
> > -     struct property **next;
> > -
> > -     for (next =3D &np->properties; *next; next =3D &(*next)->next) {
> > -             if (*next =3D=3D prop)
> > -                     break;
> > +     if (__of_remove_property_from_list(&np->properties, prop)) {
> > +             /* Found the property, add it to deadprops list */
> > +             prop->next =3D np->deadprops;
> > +             np->deadprops =3D prop;
> > +             return 0;
> >       }
> > -     if (*next =3D=3D NULL)
> > -             return -ENODEV;
> > -
> > -     /* found the node */
> > -     *next =3D prop->next;
> > -     prop->next =3D np->deadprops;
> > -     np->deadprops =3D prop;
> >
> > -     return 0;
> > +     return -ENODEV;
> >  }
>
>
> ...if it's this one, I don't see how it's better than
>
>         if (!__of_remove_property_from_list(&np->properties, prop))
>                 return -ENODEV;

Because this way doesn't work well when we move the spinlock in here.
Maybe cleanup.h will help, but I'm not going to do that now. If we do,
then I'll do it for the whole subsystem/file.

Rob
