Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 232F376F0C5
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 19:37:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235095AbjHCRhV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 13:37:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235082AbjHCRhS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 13:37:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CD2A3A99;
        Thu,  3 Aug 2023 10:37:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 82AE361E57;
        Thu,  3 Aug 2023 17:37:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9136C433CB;
        Thu,  3 Aug 2023 17:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691084231;
        bh=m3ULM7NXZMvAEEi/JL49zRWs3KrVZI5BkIyZSvI3+us=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=eWyxudkOPACaoI+SspPPHRJHWpA8gvLf9O4qKKFwNUQEqGgLIAJFTq2V9BJzifzcq
         Nozzi+6slRkoSduET6dIU9zUTl5H2cOTOP/oW4eNDT4NM0CGhmSLaSp0+WugIvNwGW
         bhe8OVkWQpfDwkt3KPLXqYoBN9SApHlx1vZrPvKLK3ibWq+v/eLs4WXrGmpNRJ7uKL
         S2fvfO9EjhSePDJME1Gwp3kTF7UbNj+pANE+1m1xwXafc5w513qqBVtoh4pZi/zi4K
         U/bdWesXlbxPKc06zXQ/YJygjoeCZzgGPxyrwFlmxX8afgIvDk5LJEcKHLT2dadh98
         HyTSZyyryUx8Q==
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2b9cd6a554cso18464361fa.3;
        Thu, 03 Aug 2023 10:37:11 -0700 (PDT)
X-Gm-Message-State: ABy/qLZlv6k3wiwKy/LiRBcU+mPZCT6wJKwweLJ7Q1rNEZSiZqtV5WLa
        zvIHSEGdJd5xu4h8XIKniBfOTgUXiUk3oX8rAw==
X-Google-Smtp-Source: APBJJlEZKzgMFwN3dNld9CSrOyqe3eT5nhEOJVEUo3gBJedyMQn9LO+tDJQ5v3PCiLDTz6+WFkHnknNHL0T7tZ/sxzE=
X-Received: by 2002:a2e:8796:0:b0:2b7:3b6c:a5e4 with SMTP id
 n22-20020a2e8796000000b002b73b6ca5e4mr8666650lji.38.1691084229939; Thu, 03
 Aug 2023 10:37:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230801-dt-changeset-fixes-v1-0-b5203e3fc22f@kernel.org>
 <20230801-dt-changeset-fixes-v1-2-b5203e3fc22f@kernel.org>
 <ZMnNcJ2KW1qUZUA5@smile.fi.intel.com> <ZMnO67avEY25XzB1@smile.fi.intel.com> <CAL_JsqLxMVp9-XY_EViYN7qBwOt+GBTsnLfkfJmCZz-zAH2HKw@mail.gmail.com>
In-Reply-To: <CAL_JsqLxMVp9-XY_EViYN7qBwOt+GBTsnLfkfJmCZz-zAH2HKw@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 3 Aug 2023 11:36:57 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLUBPaeZx8k4BoEnojauVLzs1dWJS+K0kR9U3aNF+EbPw@mail.gmail.com>
Message-ID: <CAL_JsqLUBPaeZx8k4BoEnojauVLzs1dWJS+K0kR9U3aNF+EbPw@mail.gmail.com>
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

On Wed, Aug 2, 2023 at 3:33=E2=80=AFPM Rob Herring <robh@kernel.org> wrote:
>
> On Tue, Aug 1, 2023 at 9:35=E2=80=AFPM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > On Wed, Aug 02, 2023 at 06:28:48AM +0300, Andy Shevchenko wrote:
> > > On Tue, Aug 01, 2023 at 03:54:45PM -0600, Rob Herring wrote:
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
> > > > To fix this, move the printing in __of_changeset_entry_apply() outs=
ide the
> > > > lock. As there's already similar printing of the same changeset act=
ions,
> > > > refactor all of them to use a common action print function. This ha=
s the
> > > > side benefit of getting rid of some ifdefs.
> >
> > ...
> >
> > > > v3:
> > > >  - Add missing 'static' reported by 0-day
> > >
> > > It reported two issues (at least what I see).
>
> Indeed. I missed the 2nd one.
>
> > ...
> >
> > > > +   if (pr_debug("notify "))
> > >
> > > This is weird. How did you compile it?
>
> I agree it's a weird pattern...
>
> > Urgh, you need to fix dynamic debug macros to return an error code.
>
> Or adding a 'pr_debug_cont' macro would do it. I'm inclined to wrap it
> in an "#ifdef DEBUG" and be done with it.

Here's what I've come up with instead:

#define _do_print(func, prefix, action, node, prop, ...) ({ \
  if (prop) \
    func(prefix "%-15s %pOF:%s\n", ##__VA_ARGS__,
action_names[action], node, prop); \
  else \
    func(prefix "%-15s %pOF\n", ##__VA_ARGS__, action_names[action], node);=
\
})
#define of_changeset_action_err(...) _do_print(pr_err, __VA_ARGS__)
#define of_changeset_action_debug(...) _do_print(pr_debug, __VA_ARGS__)

Rob
