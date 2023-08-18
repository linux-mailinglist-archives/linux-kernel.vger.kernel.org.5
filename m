Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D0C87812A3
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 20:15:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379400AbjHRSOc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 14:14:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379393AbjHRSOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 14:14:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D52DE4D;
        Fri, 18 Aug 2023 11:14:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D14A5633C4;
        Fri, 18 Aug 2023 18:14:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38ED8C433C7;
        Fri, 18 Aug 2023 18:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692382441;
        bh=lI4vdRb7jfKzMARmisrv/G48nnvWl34/HTlIJyE74n4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ADwHu3TlLd/wAJY+A3II85M0EDdo9m6PbAj7vmYshipFnhL2TwFUVYKEkULyXZPGM
         iEq2YVUZmMB/qXHXqxYZHdls8rcuOFa2oqvSMkKTLSLvnDzXcfTXrR+jZi4BYEDJee
         +XbCKjFe1kI5+cNq5r7nFC2JgFNCmEHKQw899Lz/hAC7ajyD00OSTRnvLT2XEEKZtj
         z29DCe6SlY2YrWDjwsHKOGNZNl2ATSuhw36+AxkVOsSsQ1GE29/YZxe6sOgtkZZIas
         2okXzOrdDAAsdv8HoTjEVslQrDfSR8B5fmiE0hmE31pAULM6ejWqwpCT/EHHKxtzqc
         pwJFpc9c14v8g==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-4fe55d70973so1399460e87.0;
        Fri, 18 Aug 2023 11:14:01 -0700 (PDT)
X-Gm-Message-State: AOJu0YwGJsFHiFLoYZNYiOSMz55CvRE8U+AFHEPMHr4NCdbstZvyCvWM
        +zqakLBclFC+JBPLmhlVXOf/jCTf/3yKjFB1xA==
X-Google-Smtp-Source: AGHT+IFpUj+sT35xzz8cXa3m2p1e9TUoo16yzYCV9UN88HP32yt2WTy3F4NcuGfPMou5/JJw3jFlKkeZ0x8sDOBl4JM=
X-Received: by 2002:a05:6512:33d6:b0:4fe:27a0:68bc with SMTP id
 d22-20020a05651233d600b004fe27a068bcmr2403060lfg.27.1692382439181; Fri, 18
 Aug 2023 11:13:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230801-dt-changeset-fixes-v2-0-c2b701579dee@kernel.org>
 <20230801-dt-changeset-fixes-v2-2-c2b701579dee@kernel.org>
 <CAMuHMdX4gqPLv5ZWiWe-B+bQtHSfF9AxZTKWisFZEKa29Ge2KQ@mail.gmail.com>
 <CAL_Jsq+2nz9MCLffKEHxygUbMNisNAFh_i-8BaZjXy_eDHEi0g@mail.gmail.com> <CAMuHMdVN+A6XDHAThz-7gNWvdeFgSfPFW0EYSEJQ12CmRKVaHg@mail.gmail.com>
In-Reply-To: <CAMuHMdVN+A6XDHAThz-7gNWvdeFgSfPFW0EYSEJQ12CmRKVaHg@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 18 Aug 2023 13:13:46 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+fnSec9Abi6LhnzD+VtxJdEP1FLArwDjqMs43EjEE=Zw@mail.gmail.com>
Message-ID: <CAL_Jsq+fnSec9Abi6LhnzD+VtxJdEP1FLArwDjqMs43EjEE=Zw@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] of: dynamic: Refactor action prints to not use
 "%pOF" inside devtree_lock
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        "Enrico Weigelt, metux IT consult" <info@metux.net>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Petr Mladek <pmladek@suse.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
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

On Fri, Aug 18, 2023 at 12:37=E2=80=AFPM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
>
> Hi Rob,
>
> On Fri, Aug 18, 2023 at 6:17=E2=80=AFPM Rob Herring <robh@kernel.org> wro=
te:
> > On Fri, Aug 18, 2023 at 10:36=E2=80=AFAM Geert Uytterhoeven
> > <geert@linux-m68k.org> wrote:
> > > On Sat, Aug 5, 2023 at 12:42=E2=80=AFAM Rob Herring <robh@kernel.org>=
 wrote:
> > > > While originally it was fine to format strings using "%pOF" while
> > > > holding devtree_lock, this now causes a deadlock.  Lockdep reports:
> > > >
> > > >     of_get_parent from of_fwnode_get_parent+0x18/0x24
> > > >     ^^^^^^^^^^^^^
> > > >     of_fwnode_get_parent from fwnode_count_parents+0xc/0x28
> > > >     fwnode_count_parents from fwnode_full_name_string+0x18/0xac
> > > >     fwnode_full_name_string from device_node_string+0x1a0/0x404
> > > >     device_node_string from pointer+0x3c0/0x534
> > > >     pointer from vsnprintf+0x248/0x36c
> > > >     vsnprintf from vprintk_store+0x130/0x3b4
> > > >
> > > > Fix this by moving the printing in __of_changeset_entry_apply() out=
side
> > > > the lock. As the only difference in the the multiple prints is the
> > > > action name, use the existing "action_names" to refactor the prints=
 into
> > > > a single print.
> > > >
> > > > Fixes: a92eb7621b9fb2c2 ("lib/vsprintf: Make use of fwnode API to o=
btain node names and separators")
> > > > Reported-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > > > Signed-off-by: Rob Herring <robh@kernel.org>
> > > > ---
> > > > v5 (v2 in this series):
> > > >  - Move majority of refactoring to separate patch and minimize the =
fix
> > > >    to just moving the print out of the locked section.
> > >
> > > Thanks for your patch!
> > >
> > > > --- a/drivers/of/dynamic.c
> > > > +++ b/drivers/of/dynamic.c
> > >
> > > > @@ -648,20 +634,17 @@ static int __of_changeset_entry_apply(struct =
of_changeset_entry *ce)
> > > >                 }
> > > >
> > > >                 ret =3D __of_update_property(ce->np, ce->prop, &old=
_prop);
> > > > -               if (ret) {
> > > > -                       pr_err("changeset: update_property failed @=
%pOF/%s\n",
> > > > -                               ce->np,
> > > > -                               ce->prop->name);
> > > > -                       break;
> > > > -               }
> > > >                 break;
> > > >         default:
> > > >                 ret =3D -EINVAL;
> > > >         }
> > > >         raw_spin_unlock_irqrestore(&devtree_lock, flags);
> > > >
> > > > -       if (ret)
> > > > +       if (ret) {
> > > > +               pr_err("changeset: apply failed: cset<%p> %-15s %pO=
F:%s\n",
> > >
> > > Printing the cset pointer will (needlessly?) complicate the EXPECT_*(=
)
> > > handling in the unit test.
> >
> > That's added largely because the other prints which I rework later in
> > this series had them. Either printing the changeset ptr is useful or
> > it isn't. I think people running the unittest and the post-processor
> > can easily enough filter this out when looking at the results.
> > Honestly, even I probably run it less than once a cycle.
>
> Do you have a use for printing the pointer value?

I have no use for overlays in general, so no. :)

I'd assumed it was there to provide a changeset ID to tell which
actions belong to the same changeset. But it's printing the changeset
entry rather than the changeset, so I agree it is not really useful.

Rob
