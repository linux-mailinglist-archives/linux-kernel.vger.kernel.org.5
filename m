Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0A9C783089
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 21:12:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbjHUTBT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 15:01:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbjHUTBR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 15:01:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D25AE2B7E;
        Mon, 21 Aug 2023 12:00:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D19B3642B6;
        Mon, 21 Aug 2023 19:00:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DE92C43391;
        Mon, 21 Aug 2023 19:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692644440;
        bh=p9svIL0nCLYzaPrmC4v5kKXr9sDBVwg9SepJnF/RICw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=L1wpF2J3X+JoMk1gWyjXqkyoeuDPOwkLVuvVCFonSDCp16n5wv7m0SYhlIQfmGNCY
         q4tkXrlLRKDsHbWfaonvw3W5PiaWHmIR/UsRnHrRxO0dM/CDu8/dvUOB1WP9l6M/bL
         0E6SJxh2lQ1sPBiBPyonRV4VAojaqctQAifvD6MRz2I3kI4G8I8EbUQp0xxDrPCkaN
         24Sm0BRUnX55ynXalJeN2eHFScGPhRdEq+K7xCS0YoFxh+cSnQmQ4I7+qmGqD0cYei
         L+KU+vs6FtbFpzlBWEL7wXRKAIOQIzYzJCd6Et5XsNxlg2dkaZve9ZBW+sKu15XxIn
         sUJA+01d0YT1A==
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2bcb0b973a5so31892301fa.3;
        Mon, 21 Aug 2023 12:00:40 -0700 (PDT)
X-Gm-Message-State: AOJu0YznqAJG5TB7/n2ZZ+CFRrq0jBA9jXz3sDFkAIFOGAgw/k9ObFSj
        wpKltB9+rnbyDKCoHF2M5mCUgBt0A9vimkbQ0w==
X-Google-Smtp-Source: AGHT+IHm4AbaUWDVW3wQ14cdXZkHH3AL4TMA23vobf18MBUJXUjopKVREy/biZZb3M8ZS1htZIpW5m755SH4+l9TKGU=
X-Received: by 2002:a2e:8416:0:b0:2b6:ddab:506a with SMTP id
 z22-20020a2e8416000000b002b6ddab506amr5774302ljg.34.1692644438172; Mon, 21
 Aug 2023 12:00:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230801-dt-changeset-fixes-v3-0-5f0410e007dd@kernel.org>
 <20230801-dt-changeset-fixes-v3-6-5f0410e007dd@kernel.org> <CAMuHMdWc78KFbBiqynfTF=LrD-rOxsk8EapqzKXP4qcP2nBSXg@mail.gmail.com>
In-Reply-To: <CAMuHMdWc78KFbBiqynfTF=LrD-rOxsk8EapqzKXP4qcP2nBSXg@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 21 Aug 2023 14:00:25 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLMoUZwacLe-mz1uHd9y7dy-ynS85=9aHARr+jB33K2jA@mail.gmail.com>
Message-ID: <CAL_JsqLMoUZwacLe-mz1uHd9y7dy-ynS85=9aHARr+jB33K2jA@mail.gmail.com>
Subject: Re: [PATCH v3 6/6] of: Refactor node and property manipulation
 function locking
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        "Enrico Weigelt, metux IT consult" <info@metux.net>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Petr Mladek <pmladek@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 21, 2023 at 8:19=E2=80=AFAM Geert Uytterhoeven <geert@linux-m68=
k.org> wrote:
>
> Hi Rob,
>
> On Fri, Aug 18, 2023 at 10:41=E2=80=AFPM Rob Herring <robh@kernel.org> wr=
ote:
> > All callers of __of_{add,remove,update}_property() and
> > __of_{attach,detach}_node() wrap the call with the devtree_lock
> > spinlock. Let's move the spinlock into the functions. This allows movin=
g
> > the sysfs update functions into those functions as well.
> >
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> > v3:
> >  - Rebase due to changes in prior patch
>
> Thanks for your patch!
>
> > --- a/drivers/of/base.c
> > +++ b/drivers/of/base.c
>
> > @@ -1576,37 +1587,36 @@ int __of_add_property(struct device_node *np, s=
truct property *prop)
> >   */
> >  int of_add_property(struct device_node *np, struct property *prop)
> >  {
> > -       unsigned long flags;
> >         int rc;
> >
> >         mutex_lock(&of_mutex);
> > -
> > -       raw_spin_lock_irqsave(&devtree_lock, flags);
> >         rc =3D __of_add_property(np, prop);
> > -       raw_spin_unlock_irqrestore(&devtree_lock, flags);
> > -
> > -       if (!rc)
> > -               __of_add_property_sysfs(np, prop);
> > -
> >         mutex_unlock(&of_mutex);
> >
> > -       if (!rc)
> > -               of_property_notify(OF_RECONFIG_ADD_PROPERTY, np, prop, =
NULL);
>
> The notify block should be kept.

Yes, good catch.

>
> The rest LGTM, although I have some second thoughts about more
> functions with a double underscore now taking devtree_lock().

We still take the of_mutex. :) I looked at it some and we're already
not consistent in usage of '__'. Not a great argument I know, but if
we're going to make things consistent I think we should do that
separately for the whole subsys.

Rob
