Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 325C076D9A1
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 23:34:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbjHBVeH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 17:34:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233113AbjHBVd7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 17:33:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8CA23AA2;
        Wed,  2 Aug 2023 14:33:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C1E8361B29;
        Wed,  2 Aug 2023 21:33:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3680BC433C9;
        Wed,  2 Aug 2023 21:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691012016;
        bh=MB2ifa2REkD93UMUYAU9gTE6E8Q0kFDfWoM6nVr/koM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=uXXuXEvwM33sXgFb+vu6khPBJqwoSLG8ZfPOOJY4ULh+z+9T47H6QwWIpkISClgIZ
         E03i4NnNGWoLRQprPb9KxUETflckPM+Lpxjct94EqnTutqke4iXfJAZLJqSdNlgjSr
         kPfUoNx5RmoK+OFleJ3aSPsA7mbT1e0M49lihos6HvqrE1yyYx3In2Kpz1ogHr0kw7
         /6576OGsI+XZfv6+QKOmdPftpTDy/DDtO13GAno+URku7naUpkQFYhLrDzplCf6Yxl
         KFmzyqbX0Y6ER5yvVfyWzInV136ji8DlrsNlimxN9maDIX1G8r4htsMAvOnTjQbjB1
         jvhVHvCmNdOoA==
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2b72161c6e9so17723251fa.0;
        Wed, 02 Aug 2023 14:33:36 -0700 (PDT)
X-Gm-Message-State: ABy/qLahXBnnUMcoWtsVu0pxaZhW7DhamDqrt90cFS9Jv1AVRjSF6mH1
        q+JLoEU/poQGl++Us8t5Z4gZiAy71yHJJ59LgA==
X-Google-Smtp-Source: APBJJlHPpnI7S7STtsTrSdaal7ZVtzU21ObJ0y418uyi4QzsoEWjztocy6m6IxQ6L+BW1ScNNXbThEAByDbIJf8QoLQ=
X-Received: by 2002:a2e:a16a:0:b0:2b8:3a1e:eebd with SMTP id
 u10-20020a2ea16a000000b002b83a1eeebdmr2283141ljl.21.1691012014260; Wed, 02
 Aug 2023 14:33:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230801-dt-changeset-fixes-v1-0-b5203e3fc22f@kernel.org>
 <20230801-dt-changeset-fixes-v1-2-b5203e3fc22f@kernel.org>
 <ZMnNcJ2KW1qUZUA5@smile.fi.intel.com> <ZMnO67avEY25XzB1@smile.fi.intel.com>
In-Reply-To: <ZMnO67avEY25XzB1@smile.fi.intel.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 2 Aug 2023 15:33:21 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLxMVp9-XY_EViYN7qBwOt+GBTsnLfkfJmCZz-zAH2HKw@mail.gmail.com>
Message-ID: <CAL_JsqLxMVp9-XY_EViYN7qBwOt+GBTsnLfkfJmCZz-zAH2HKw@mail.gmail.com>
Subject: Re: [PATCH 2/5] of: dynamic: Refactor action prints to not use "%pOF"
 inside devtree_lock
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
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 1, 2023 at 9:35=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Wed, Aug 02, 2023 at 06:28:48AM +0300, Andy Shevchenko wrote:
> > On Tue, Aug 01, 2023 at 03:54:45PM -0600, Rob Herring wrote:
> > > While originally it was fine to format strings using "%pOF" while
> > > holding devtree_lock, this now causes a deadlock.  Lockdep reports:
> > >
> > >     of_get_parent from of_fwnode_get_parent+0x18/0x24
> > >     ^^^^^^^^^^^^^
> > >     of_fwnode_get_parent from fwnode_count_parents+0xc/0x28
> > >     fwnode_count_parents from fwnode_full_name_string+0x18/0xac
> > >     fwnode_full_name_string from device_node_string+0x1a0/0x404
> > >     device_node_string from pointer+0x3c0/0x534
> > >     pointer from vsnprintf+0x248/0x36c
> > >     vsnprintf from vprintk_store+0x130/0x3b4
> > >
> > > To fix this, move the printing in __of_changeset_entry_apply() outsid=
e the
> > > lock. As there's already similar printing of the same changeset actio=
ns,
> > > refactor all of them to use a common action print function. This has =
the
> > > side benefit of getting rid of some ifdefs.
>
> ...
>
> > > v3:
> > >  - Add missing 'static' reported by 0-day
> >
> > It reported two issues (at least what I see).

Indeed. I missed the 2nd one.

> ...
>
> > > +   if (pr_debug("notify "))
> >
> > This is weird. How did you compile it?

I agree it's a weird pattern...

> Urgh, you need to fix dynamic debug macros to return an error code.

Or adding a 'pr_debug_cont' macro would do it. I'm inclined to wrap it
in an "#ifdef DEBUG" and be done with it.

Rob
