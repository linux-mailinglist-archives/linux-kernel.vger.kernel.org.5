Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E0BC7709B5
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 22:31:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230180AbjHDUbq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 16:31:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjHDUbk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 16:31:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26D524C2F;
        Fri,  4 Aug 2023 13:31:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B01C261F2C;
        Fri,  4 Aug 2023 20:31:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21000C433CB;
        Fri,  4 Aug 2023 20:31:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691181097;
        bh=Kx0ukmmajEq9jA//xRgg8P9Hb44BicThE/9GSCwfyv8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=MWuY6vdvN3/8McDUIeK/NLYPOf42KN6frl/OWKvSnGA7FSv5PMzfChEAdcboshshX
         IPanNsNM/1HCi045p4zVpzKqEsS3bm3lP0smn5AzDJUva/eiYlZXX8NT3MJAKAT11B
         rzDpBkTPSZuWb0VAzD3cJ8G0yxUsC2F0chOAV3tBwhxtycLJFO8ABytzvjkTIY0IgA
         9DkAkXtJwk8lEf4dGxd8GUl+dW5z3jJ/X6lSZy4wivW91ASXpPSUoAcTB+kZqUNNFr
         3wOZBkkOE92/+duJMjU9dvxmMUthb0m7rfwt/KdOLddZVH55PjOEzDInVEc3hGDaEu
         fKDn54egWryzQ==
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2b9c55e0fbeso38686771fa.2;
        Fri, 04 Aug 2023 13:31:37 -0700 (PDT)
X-Gm-Message-State: AOJu0Yy8T3eqUAq5bkNMSxAeTZbWfCzKtwGlQ6vAezadRBXcSVTI4eQv
        kDaQoT5AfgYKcIGVLMbCuxV6J+tOJM6Qzssavg==
X-Google-Smtp-Source: AGHT+IGqAa3XK8M6oZTyrHv0ezLXcIqNfO0j3+RA2Jc9Dmlqh0zIS3hCEdpdhjRowJn16g1c8Pj8Rwea/hdGZOqs/TA=
X-Received: by 2002:a2e:864b:0:b0:2b9:e701:ac4d with SMTP id
 i11-20020a2e864b000000b002b9e701ac4dmr2673200ljj.26.1691181095107; Fri, 04
 Aug 2023 13:31:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230801-dt-changeset-fixes-v1-0-b5203e3fc22f@kernel.org>
 <20230801-dt-changeset-fixes-v1-2-b5203e3fc22f@kernel.org> <ZM1Jk9s3gRYLyagW@alley>
In-Reply-To: <ZM1Jk9s3gRYLyagW@alley>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 4 Aug 2023 14:31:22 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJzEZOO4OA7ewMNZsF-5Z7CR2+_HMYM12yb0i5E2Gpquw@mail.gmail.com>
Message-ID: <CAL_JsqJzEZOO4OA7ewMNZsF-5Z7CR2+_HMYM12yb0i5E2Gpquw@mail.gmail.com>
Subject: Re: [PATCH 2/5] of: dynamic: Refactor action prints to not use "%pOF"
 inside devtree_lock
To:     Petr Mladek <pmladek@suse.com>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        "Enrico Weigelt, metux IT consult" <info@metux.net>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
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

On Fri, Aug 4, 2023 at 12:55=E2=80=AFPM Petr Mladek <pmladek@suse.com> wrot=
e:
>
> On Tue 2023-08-01 15:54:45, Rob Herring wrote:
> > While originally it was fine to format strings using "%pOF" while
> > holding devtree_lock, this now causes a deadlock.  Lockdep reports:
> >
> >     of_get_parent from of_fwnode_get_parent+0x18/0x24
> >     ^^^^^^^^^^^^^
> >     of_fwnode_get_parent from fwnode_count_parents+0xc/0x28
> >     fwnode_count_parents from fwnode_full_name_string+0x18/0xac
> >     fwnode_full_name_string from device_node_string+0x1a0/0x404
> >     device_node_string from pointer+0x3c0/0x534
> >     pointer from vsnprintf+0x248/0x36c
> >     vsnprintf from vprintk_store+0x130/0x3b4
> >
> > To fix this, move the printing in __of_changeset_entry_apply() outside =
the
> > lock. As there's already similar printing of the same changeset actions=
,
> > refactor all of them to use a common action print function. This has th=
e
> > side benefit of getting rid of some ifdefs.
> >
> > Fixes: a92eb7621b9fb2c2 ("lib/vsprintf: Make use of fwnode API to obtai=
n node names and separators")
> > Reported-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > Signed-off-by: Rob Herring <robh@kernel.org>
>
> > --- a/drivers/of/dynamic.c
> > +++ b/drivers/of/dynamic.c
> > @@ -63,37 +63,31 @@ int of_reconfig_notifier_unregister(struct notifier=
_block *nb)
> >  }
> >  EXPORT_SYMBOL_GPL(of_reconfig_notifier_unregister);
> >
> > -#ifdef DEBUG
> > -const char *action_names[] =3D {
> > +static const char *action_names[] =3D {
> >       [OF_RECONFIG_ATTACH_NODE] =3D "ATTACH_NODE",
> >       [OF_RECONFIG_DETACH_NODE] =3D "DETACH_NODE",
> >       [OF_RECONFIG_ADD_PROPERTY] =3D "ADD_PROPERTY",
> >       [OF_RECONFIG_REMOVE_PROPERTY] =3D "REMOVE_PROPERTY",
> >       [OF_RECONFIG_UPDATE_PROPERTY] =3D "UPDATE_PROPERTY",
> >  };
> > -#endif
> > +
> > +static void of_changeset_action_print(unsigned long action, struct dev=
ice_node *np,
> > +                                   const char *prop_name)
> > +{
> > +     if (prop_name)
> > +             pr_cont("%-15s %pOF:%s\n", action_names[action], np, prop=
_name);
>
> Note that pr_cont() does not guarantee that the message will be appended =
to the
> previous part. Any message printed from another CPU or interrupt
> context might break the two pieces.
>
> It is better to avoid pr_cont() when possible.

Yeah, I got rid of it in the snippet I posted.

>
> > +     else
> > +             pr_cont("%-15s %pOF\n", action_names[action], np);
> > +}
> >
> >  int of_reconfig_notify(unsigned long action, struct of_reconfig_data *=
p)
> >  {
> >       int rc;
> > -#ifdef DEBUG
> >       struct of_reconfig_data *pr =3D p;
> >
> > -     switch (action) {
> > -     case OF_RECONFIG_ATTACH_NODE:
> > -     case OF_RECONFIG_DETACH_NODE:
> > -             pr_debug("notify %-15s %pOF\n", action_names[action],
> > -                     pr->dn);
> > -             break;
> > -     case OF_RECONFIG_ADD_PROPERTY:
> > -     case OF_RECONFIG_REMOVE_PROPERTY:
> > -     case OF_RECONFIG_UPDATE_PROPERTY:
> > -             pr_debug("notify %-15s %pOF:%s\n", action_names[action],
> > -                     pr->dn, pr->prop->name);
> > -             break;
> > +     if (pr_debug("notify "))
> > +             of_changeset_action_print(action, pr->dn, pr->prop ? pr->=
prop->name : NULL);
>
> If you really want to simplify this, then I would do:
>
>         pr_debug("notify %-15s %pOF%s%s\n",
>                   action_names[action], pr->dn,
>                   pr->prop ? ":" : ",
>                   pr->prop ? pr->prop->name : "");

That's a good idea.

> > -     }
> > -#endif
> >       rc =3D blocking_notifier_call_chain(&of_reconfig_chain, action, p=
);
> >       return notifier_to_errno(rc);
> >  }
> > @@ -599,7 +569,8 @@ static int __of_changeset_entry_apply(struct of_cha=
ngeset_entry *ce)
> >       unsigned long flags;
> >       int ret =3D 0;
> >
> > -     __of_changeset_entry_dump(ce);
> > +     if (pr_debug("changeset: applying: cset<%p> ", ce))
> > +             of_changeset_action_print(ce->action, ce->np, ce->prop ? =
ce->prop->name : NULL);
>
> One possibility would be to create a macro for this, something like:
>
> #define of_ce_action_print(printk_level, prefix, ce)            \
>         printk(printk_level "%s cset<%p> %-15s %pOF%s%s\n"      \
>                 prefix, ce, action_names[action], pr->dn,       \
>                   pr->prop ? ":" : ",                           \
>                   pr->prop ? pr->prop->name : "");
>
> And use it like:
>
>         of_ce_action_print(KERN_DEBUG, "changeset: applying:", ce);

The problem there is the debug print is always enabled.

>
> But I am not sure if it is worth it. Sometimes it is better to
> opencode things so that it is clear what is going on.

Maybe so.

Rob
