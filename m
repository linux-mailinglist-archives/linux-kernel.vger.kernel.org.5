Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C781C782BA4
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 16:23:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235898AbjHUOX3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 10:23:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235894AbjHUOX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 10:23:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D301E7;
        Mon, 21 Aug 2023 07:23:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2490E639A4;
        Mon, 21 Aug 2023 14:23:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86E60C433C9;
        Mon, 21 Aug 2023 14:23:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692627804;
        bh=OaWNqSvQEiD1xmCg4SPCQRjx+fMWtx5iLMEQKBnd8cw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rwhlq4tC4EvRUmr/wbT0Ue51oVpNlMsu83qtdLFrxL3InwKNRZ9fv9Q1CT7yhYQUq
         2n1NzCWETXNLMkaMpID1GNQcgdbYEnMOfU3D94e3DYOBJhwhpBJYSVRAaHVNTKsEh8
         pMea45h+BUy5LQJGwAL+M/2vdzp2jW77Ebp55DzJmZ4OdgErQ0WbH6A60lOrqWZp3g
         Nuo7DXXHAQD7aty3rQ+/oLuDvvBMPUadlGTtJQoA1gZHjy13VFq5oXUm+WPMrWyZ91
         7y2jsova6Uz0AJlK9FAzH/WsUGhzHFwqcZqKJyDobBESaB2g3eiSj6cJYVK7XRuQqn
         8ygIBIfSdlkdw==
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2bcb89b476bso22164741fa.1;
        Mon, 21 Aug 2023 07:23:24 -0700 (PDT)
X-Gm-Message-State: AOJu0YwomV6JvOJwE1Sj++0x8wrqifA6Hn0z6K1MyI0lX4qq7QJA7a31
        CWN9RQnxQarNrUzPk0DtoFWHXzkx226Yvtqocw==
X-Google-Smtp-Source: AGHT+IGqWIjI4t81zqE/7ga2ouKLVTQbXY0MKa0xbyIPjA5d60S4eHI9X7anlOsfqpBvu7tnpqhcRmdxmQ2XPK6mec0=
X-Received: by 2002:a2e:9d96:0:b0:2b6:c2e4:a57a with SMTP id
 c22-20020a2e9d96000000b002b6c2e4a57amr5393041ljj.38.1692627802545; Mon, 21
 Aug 2023 07:23:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230801-dt-changeset-fixes-v3-0-5f0410e007dd@kernel.org>
 <20230801-dt-changeset-fixes-v3-5-5f0410e007dd@kernel.org> <CAMuHMdXi+fAH=sqMb941BGNidg=GtLiByPtMpoHX4Bf-5Cjv4A@mail.gmail.com>
In-Reply-To: <CAMuHMdXi+fAH=sqMb941BGNidg=GtLiByPtMpoHX4Bf-5Cjv4A@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 21 Aug 2023 09:23:10 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLU4Oy3aiw6mnPUnxSPiXyydpR+zyESDvqS26cSVo=ngA@mail.gmail.com>
Message-ID: <CAL_JsqLU4Oy3aiw6mnPUnxSPiXyydpR+zyESDvqS26cSVo=ngA@mail.gmail.com>
Subject: Re: [PATCH v3 5/6] of: dynamic: Move dead property list check into
 property add/update functions
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

On Mon, Aug 21, 2023 at 8:05=E2=80=AFAM Geert Uytterhoeven <geert@linux-m68=
k.org> wrote:
>
> Hi Rob,
>
> Thanks for your patch!
>
>
> On Fri, Aug 18, 2023 at 10:41=E2=80=AFPM Rob Herring <robh@kernel.org> wr=
ote:
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
> >
> > Signed-off-by: Rob Herring <robh@kernel.org>
>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thanks!

>
> Perhaps this needs a Fixes tag?

I didn't simply because in the decades that these functions existed,
no one cared. It would require a specific sequence of calls which we
could pretty much determine doesn't happen just looking at the callers
in the kernel.

Rob
