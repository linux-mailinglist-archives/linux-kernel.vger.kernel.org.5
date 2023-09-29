Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6261B7B34B1
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 16:17:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233252AbjI2ORt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 10:17:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233114AbjI2ORq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 10:17:46 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 622211AC
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 07:17:44 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-5056ca2b6d1so900487e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 07:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695997061; x=1696601861; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wHZm/0dJ6cWlCinb/QJLx3AsO1RtLBLtwABzRD/dBUs=;
        b=HD0hb8BlAHJ23ceWbtBIc9Qca9OHz9rsBoGrMC3R6t3VjVM1TVv3ESq0tWIGOzC5HO
         bbrW3x+MegzfeocmCP0RdkxtkaFwpZAsahbMNpIaj10WLQZGBp4IriVg6477RvK/PeNm
         m9Xk8w6D5WfasDLqbQU74h43UCQjdG5ce6FC8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695997061; x=1696601861;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wHZm/0dJ6cWlCinb/QJLx3AsO1RtLBLtwABzRD/dBUs=;
        b=T7d9WB8BXFPbv7zVQU4z6624xa4kT+FPyoaUyNeJavAPQ6rZJq+/HahhHHDMRVuvZQ
         EXkg0LwjabBcquEP/syc4Az6Tpo/BbHIR2Dz2ASfEHmOHnp1N3udEDp0U9T0XerLDQtO
         fMwcJdEa7ldNr06nNkKcINHCMVFIaplztzqUzonAIXYAPfqec6ljf3iY0GUXr6CadnsU
         rBkRFgRJHbpHQl9ee0Mk4knEe0uNr41CF94/rHSQUDmWIOW8h2wYc7JqvABUl36BVlUQ
         djsle+aWkvkyAggXpOH42mG9u5KYTBdM1EWEh5RESUSq5n5BKpPSL1+oGB+mSlZ2W2if
         AY1A==
X-Gm-Message-State: AOJu0YwF532s0LTikbMUOKHER15yxsR7+32O0v3Bz8fvXKRlXcgxTRm1
        pqDDs7TLgcpiUTS3Q2hdydOGE9apYzoKjOpRrOUr6zfA
X-Google-Smtp-Source: AGHT+IHeWLY+8oysH/ERG1ejzZEhDV9yRDGEUyQ/MvHJY3T6R0oWwOklY7PolHw38xqV4YuJau91BQ==
X-Received: by 2002:a05:6512:10d1:b0:501:be4d:6dc5 with SMTP id k17-20020a05651210d100b00501be4d6dc5mr3456114lfg.8.1695997061004;
        Fri, 29 Sep 2023 07:17:41 -0700 (PDT)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id s18-20020a197712000000b005041e5023f4sm1321131lfc.307.2023.09.29.07.17.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Sep 2023 07:17:39 -0700 (PDT)
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-502f29ed596so6391e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 07:17:39 -0700 (PDT)
X-Received: by 2002:a19:c20f:0:b0:502:cdb6:f316 with SMTP id
 l15-20020a19c20f000000b00502cdb6f316mr285906lfc.3.1695997059452; Fri, 29 Sep
 2023 07:17:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230703-fix-boe-tv101wum-nl6-v3-0-bd6e9432c755@linaro.org>
 <CAD=FV=W2AKQSnWh02Lxbqi47M325JNCaEn1_B0xAW3PKPKKF7Q@mail.gmail.com>
 <CAD=FV=WZ+zX9jrwOhN_ZboSYSBomx2s5vifQEB6MzNFgj=g4Ow@mail.gmail.com> <CACRpkdZutdTDQkCSQoA0_0U=Qdf+xDWTu3PzvYRRz=cT18wHRA@mail.gmail.com>
In-Reply-To: <CACRpkdZutdTDQkCSQoA0_0U=Qdf+xDWTu3PzvYRRz=cT18wHRA@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 29 Sep 2023 07:17:22 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XG1yFfbvAh9t6XiMNKBc3kHNZ8FqVjayboQjuTfxt-6A@mail.gmail.com>
Message-ID: <CAD=FV=XG1yFfbvAh9t6XiMNKBc3kHNZ8FqVjayboQjuTfxt-6A@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] Fix up the boe-tv101wum-nl6 panel driver
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Ruihai Zhou <zhouruihai@huaqin.corp-partner.google.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Cong Yang <yangcong5@huaqin.corp-partner.google.com>,
        Jitao Shi <jitao.shi@mediatek.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Sep 28, 2023 at 2:42=E2=80=AFPM Linus Walleij <linus.walleij@linaro=
.org> wrote:
>
> On Tue, Sep 26, 2023 at 11:49=E2=80=AFPM Doug Anderson <dianders@chromium=
.org> wrote:
>
> > > I'm curious what the latest on this patch series is. Is it abandoned,
> > > or is it still on your list to move forward with it? If it's
> > > abandoned, does that mean we've abandoned the idea of breaking
> > > ili9882t into a separate driver?
> > >
> > > From looking at things that have landed downstream in the ChromeOS
> > > kernel trees it looks as if additional fixes are getting blocked from
> > > being posted/landed because of the limbo state that this is in.
> >
> > I presume Linus is busy or otherwise indisposed.
>
> Sorry I was looking for the branch with my patches and I have it
> somewhere not ordinary :/
>
> Originally I shelved it because I got requests to do additional
> patches to the driver:
> https://lore.kernel.org/dri-devel/CAD=3DFV=3DXkr3Qpd8m_6Xta_2jL_ezbxsmMya=
rbKXTXL+UJLG9xNw@mail.gmail.com/
>
> To do measurements about binary code size in object files, and if it does=
,
> then I need to invent new sequence macros (IIUC):
> https://lore.kernel.org/dri-devel/CAD=3DFV=3DWju3WS45=3DEpXMUg7FjYDh3-=3D=
mvm_jS7TF1tsaAzbb4Uw@mail.gmail.com/
>
> So I just didn't have time for that extensive rework of the driver.
>
> It's good feedback, but I just wanted to make the situation a little
> bit better, and perfect is the enemy of good (TM).
>
> > So I guess we have two options here:
> >
> > a) Cong Yang can post any relevant fixes to the existing "monolithic"
> > panel driver so that we can get them landed and at least get things
> > fixed.
> >
> > - or -
> >
> > b) Cong Yang could take over all or some of Linus's series and post
> > new versions of it, addressing feedback.
>
> Either works for me, I would prefer b), Cong is welcome to adopt
> the patches if he/his employer want to. Go ahead!
>
> We can't really let this one-size-fits-all driver go on like this.
>
> My main concern with the "boe-tv101wum-nl6" driver is that it can
> be renamed "cromeos-hackfest" at this point because it becomes
> hard for any other system to reuse the panel drivers, the typical
> example would be a system using say ili9882t but with
> a different init sequence or something, why would they want
> support for 9 unrelated panels compiled in? The condition that
> these drivers should be related to the original panel that gave
> name to the file has seemingly been dropped long ago.
>
> It looks like the drivers only share the power lines (avdd, avee, pp3300,
> pp1800) then this can be broken out to a helper library. But I am
> sceptical about that too. I doubt that the vastly different panels
> actually have exactly these these supply line names, I think it is
> actually names of the rails on the chrome machine board. And that is
> not how these regulators should be named, they should be named after
> the input name on the component. This is really hard to catch in reviews =
when
> we don't have datasheets so I'm not blaming anyone, but is this something
> that even needs fixing in the device tree bindings? (By deprecation
> and addition...) can we look into this?
>
> I would say can we at least agree that before we merge one more
> driver into this file, break out to subdrivers those that clearly have
> an identifiable display controller and is thus reusable? From my
> point of view I can just see the ili9882t so that's a good start.

This sounds like a reasonable plan to me. What if Cong posted patches
that broke this up into a separate driver for the distinct controller
but otherwise didn't substantially reorganize it? In other words both
the old driver and the new one would keep the "struct panel_init_cmd"
until we get some resolution about the binary size issue. That would
at least let us move forward...

-Doug
