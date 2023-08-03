Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72D6C76F41B
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 22:43:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232051AbjHCUm6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 16:42:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232059AbjHCUmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 16:42:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC4A630EA;
        Thu,  3 Aug 2023 13:42:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6A5FA61E9C;
        Thu,  3 Aug 2023 20:42:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0339C433C7;
        Thu,  3 Aug 2023 20:42:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691095372;
        bh=zJqSs4II8jCSVtvv08wcMcW4QKzsT4gUqgO8ObX1kb4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=GMBTK2Na4d8I6vAan2HVME+mfwDjYre8MB5cUvjchWrppMhPPqkUuWXp0rWi1NTGd
         YkRgqQ3eTHVaZbl/T1pzbd701cCM2yTZdleyWiFztcfwkJMcHKZ20XMXJ4Yd1uaQ0z
         0Jek2qz1VX3WbYo5NCyGQ1xWMTRfg7imC7luwerhsnVY9SJi+b4ql5k8Muw3uvt996
         MDVYUcCfrY6DqH1d4tImlWcvr94yNmk27NbYayx33ii7bW1WYxxQLT3EtNwKB2jXeE
         psu3fgr8CzEjplyu3YWVzFaeJ3mhKhu9GMFqQ0MUK6CD8+xv38kE+7zG4M1GRmTedm
         F6VHNISmdvTTQ==
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2b9db1de50cso21151141fa.3;
        Thu, 03 Aug 2023 13:42:51 -0700 (PDT)
X-Gm-Message-State: ABy/qLYBg9K8m/625I9CPegJfWTczpgMfQ/gJymeOqX0xuHgrCUKxknT
        NTzwopJa2zl3pa+sQrtBJyxLas7XJsfkNtv0Jw==
X-Google-Smtp-Source: APBJJlGSCWrq8KmhGHFj/GFd8fVARYjMk24g7uxaGIe5XmPn1GnIc1b3hXf+KESdlBUUs8fDtMSFcZ4i8jAuqDE0v3A=
X-Received: by 2002:a2e:b614:0:b0:2b9:e831:f16a with SMTP id
 r20-20020a2eb614000000b002b9e831f16amr7346191ljn.26.1691095369830; Thu, 03
 Aug 2023 13:42:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230801-dt-changeset-fixes-v1-0-b5203e3fc22f@kernel.org>
 <20230801-dt-changeset-fixes-v1-4-b5203e3fc22f@kernel.org> <ZMpySdEBHaPfUiyt@smile.fi.intel.com>
In-Reply-To: <ZMpySdEBHaPfUiyt@smile.fi.intel.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 3 Aug 2023 14:42:37 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJPGh=WvKj9dQbKLOaODjvVXhP4mH+OK_Na5PatDu2OJg@mail.gmail.com>
Message-ID: <CAL_JsqJPGh=WvKj9dQbKLOaODjvVXhP4mH+OK_Na5PatDu2OJg@mail.gmail.com>
Subject: Re: [PATCH 4/5] of: dynamic: Move dead property list check into
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
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 2, 2023 at 9:12=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Tue, Aug 01, 2023 at 03:54:47PM -0600, Rob Herring wrote:
> > The changeset code checks for a property in the deadprops list when
> > adding/updating a property, but of_add_property() and
> > of_update_property() do not. As the users of these functions are pretty
> > simple, they have not hit this scenario or else the property lists
> > would get corrupted.
>
> ...
>
> Seems like this...
>
> > +     /* If the property is in deadprops then it must be removed */
> > +     for (next =3D &np->deadprops; *next; next =3D &(*next)->next) {
> > +             if (*next =3D=3D prop) {
> > +                     *next =3D prop->next;
> > +                     break;
> > +             }
> > +     }
>
> >       prop->next =3D NULL;
>
> ...
>
> > +     for (next =3D &np->deadprops; *next; next =3D &(*next)->next) {
> > +             if (*next =3D=3D newprop) {
> > +                     *next =3D newprop->next;
> > +                     newprop->next =3D NULL;
> > +                     break;
> > +             }
> > +     }
>
> ...is a dup of this. Are you planing to have a helper or at least conditi=
onal
> for_each_*() macro for them?

At least the latter would be more clean-up than I want to do here
because this will be backported to stable. We have an iterator for
properties list, but note how this iterates on the "next" ptr address.
So it's a bit different from the normal iterators.

I'll go ahead and add a helper.

Rob
