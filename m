Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85D42781020
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 18:18:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378546AbjHRQRl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 12:17:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378551AbjHRQRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 12:17:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07FBF3C20;
        Fri, 18 Aug 2023 09:17:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7EAB5632A4;
        Fri, 18 Aug 2023 16:17:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0D4AC433CA;
        Fri, 18 Aug 2023 16:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692375427;
        bh=O8XBIBBk0FYxR5vEAg82+4dXJYu4QAEIUj/8K7HRlF4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=R6iwyWymuSO2IAHS6/PPVsQVuZOaComfb1+XEFnHku/bZxMWY9duAP1YR4sOUzcY8
         Ik+kG0+Nfc/Q+dE/zUQ/dvDsTsvWSNSnQeEZohZ3cBg6AGnxB+SDX0N7B5O7506UbM
         2A4ACjIcYK+hM//hes65nalSgHFHOvaDBZXVzCBAQidb3BeK7Im2yh+9lh6n3Vjrxw
         BLIBA1e/X9Jn4CmAInYjaDmnryLTitCSmvdKdamxEZtB+C7yYuC32G7xD7fp3pjQ5t
         N6RwZeMDoKnrQXy0+X6rGKJrNL7Fv/Nbkr0eoNYD/icVAot412LFwsIFbLNoVbYouA
         b+vjCZzEp7+1g==
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2bba74ddf1bso15698411fa.2;
        Fri, 18 Aug 2023 09:17:07 -0700 (PDT)
X-Gm-Message-State: AOJu0Yz8oB7Je9IOfWX88cES9KlIjA0jA06MW6cDxEs1pe9WP+rlgFdg
        sMnUbE0arzj27vF49KZuCfzXhw59y58H1HUmqw==
X-Google-Smtp-Source: AGHT+IE0UcVXVraEd/bHX7b1u5IHcFO1oZW/xhIzbTW9gXsjV66mo00T6vYZ8BuBZI4CdZ+9YJ2EIk40s3AKvmsIV08=
X-Received: by 2002:a2e:9c11:0:b0:2bb:9293:b44e with SMTP id
 s17-20020a2e9c11000000b002bb9293b44emr2027042lji.5.1692375425873; Fri, 18 Aug
 2023 09:17:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230801-dt-changeset-fixes-v2-0-c2b701579dee@kernel.org>
 <20230801-dt-changeset-fixes-v2-2-c2b701579dee@kernel.org> <CAMuHMdX4gqPLv5ZWiWe-B+bQtHSfF9AxZTKWisFZEKa29Ge2KQ@mail.gmail.com>
In-Reply-To: <CAMuHMdX4gqPLv5ZWiWe-B+bQtHSfF9AxZTKWisFZEKa29Ge2KQ@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 18 Aug 2023 11:16:53 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+2nz9MCLffKEHxygUbMNisNAFh_i-8BaZjXy_eDHEi0g@mail.gmail.com>
Message-ID: <CAL_Jsq+2nz9MCLffKEHxygUbMNisNAFh_i-8BaZjXy_eDHEi0g@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] of: dynamic: Refactor action prints to not use
 "%pOF" inside devtree_lock
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

On Fri, Aug 18, 2023 at 10:36=E2=80=AFAM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
>
> Hi Rob,
>
> On Sat, Aug 5, 2023 at 12:42=E2=80=AFAM Rob Herring <robh@kernel.org> wro=
te:
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
> > Fix this by moving the printing in __of_changeset_entry_apply() outside
> > the lock. As the only difference in the the multiple prints is the
> > action name, use the existing "action_names" to refactor the prints int=
o
> > a single print.
> >
> > Fixes: a92eb7621b9fb2c2 ("lib/vsprintf: Make use of fwnode API to obtai=
n node names and separators")
> > Reported-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> > v5 (v2 in this series):
> >  - Move majority of refactoring to separate patch and minimize the fix
> >    to just moving the print out of the locked section.
>
> Thanks for your patch!
>
> > --- a/drivers/of/dynamic.c
> > +++ b/drivers/of/dynamic.c
>
> > @@ -648,20 +634,17 @@ static int __of_changeset_entry_apply(struct of_c=
hangeset_entry *ce)
> >                 }
> >
> >                 ret =3D __of_update_property(ce->np, ce->prop, &old_pro=
p);
> > -               if (ret) {
> > -                       pr_err("changeset: update_property failed @%pOF=
/%s\n",
> > -                               ce->np,
> > -                               ce->prop->name);
> > -                       break;
> > -               }
> >                 break;
> >         default:
> >                 ret =3D -EINVAL;
> >         }
> >         raw_spin_unlock_irqrestore(&devtree_lock, flags);
> >
> > -       if (ret)
> > +       if (ret) {
> > +               pr_err("changeset: apply failed: cset<%p> %-15s %pOF:%s=
\n",
>
> Printing the cset pointer will (needlessly?) complicate the EXPECT_*()
> handling in the unit test.

That's added largely because the other prints which I rework later in
this series had them. Either printing the changeset ptr is useful or
it isn't. I think people running the unittest and the post-processor
can easily enough filter this out when looking at the results.
Honestly, even I probably run it less than once a cycle.

>
> > +                      ce, action_names[ce->action], ce->np, ce->prop->=
name);
>
> This should check ce->action to avoid an out-of-bounds access beyond
> the end of action_names[].

Indeed.

I think I'll add "invalid" to action_names names and then do something
like: "(ce->action < FOO) ? ce->action : 0".

Rob
