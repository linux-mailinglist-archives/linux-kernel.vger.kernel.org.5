Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7132579E83E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 14:44:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240660AbjIMMoZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 08:44:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236200AbjIMMoX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 08:44:23 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D8D619B1;
        Wed, 13 Sep 2023 05:44:19 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E77DC433C9;
        Wed, 13 Sep 2023 12:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694609059;
        bh=IiwoPpnvt0R5H+88ZLjuFyVUwkaVr0IlZjHEWMkr3ng=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=YpEHN3Hx/ZZLvFtkFquV6WIcGkgDFzLPLDXh0UxsRn965nJytPjmLkhXJBT53su/3
         Z8fS7CzIYKdV2mwBhYDiIGksonc2mPNiuDR2l1rXVowecXdx6eF9naa9hVkjz2+t5Z
         Czn9Ob6nkI5f0ve56MjaXvZYDyRri84yG84bKs+lsu4yKXYtTgMNJotLAGEc9FxUZR
         vZxK82dR6wP0i+y/lIX/deYrM0vkv95V8Nu/grPO1nBqKvF7RfrNN2VMD5xESvyHon
         92605YYTd20qzRTw0dQ9WCgSOG34djBv8qJ//eL5ifhDEm77Kju4NJhRUZKYAMjwf8
         RqV8D8cs31XYg==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-501bd7711e8so11750048e87.1;
        Wed, 13 Sep 2023 05:44:19 -0700 (PDT)
X-Gm-Message-State: AOJu0YwtI6Vin6FD+rRN4kS1yrxLi1x0hIVRl5GkSvvIZfTadkDTWmWE
        AGYPhUCkugDgNkW7DFZ524/zrBgrBVqrLoefTQ==
X-Google-Smtp-Source: AGHT+IFWl2lGThpj/Ri14G/ai+csuSXfqbufoqWAQymPnRgDfPkByJ1KkxRmGht5fgilf18q2crJEcXCNlSvINpzU/A=
X-Received: by 2002:a05:6512:3e16:b0:500:863e:fc57 with SMTP id
 i22-20020a0565123e1600b00500863efc57mr2409837lfv.25.1694609057312; Wed, 13
 Sep 2023 05:44:17 -0700 (PDT)
MIME-Version: 1.0
References: <7dfaf999-30ad-491c-9615-fb1138db121c@moroto.mountain>
 <CAL_JsqJB_pK-Q-Y-v6mWV1KwfL8sjFGgCcSL5gdrZm-TqxvBJg@mail.gmail.com>
 <CAMuHMdVep4Hib0iBabGdFfbCxdftWcJ8wfySGLB8GbmbSmBNhg@mail.gmail.com>
 <06327197-9b17-481f-8ecc-3f9c5ba3e391@kadam.mountain> <CAL_JsqKZuG4dK2ThuTaFKk9b9HtGcvmuJMgZFMeVw7ADg2+_kQ@mail.gmail.com>
 <e6cba9f9-2d90-473d-a6b3-5b74b520617d@kadam.mountain>
In-Reply-To: <e6cba9f9-2d90-473d-a6b3-5b74b520617d@kadam.mountain>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 13 Sep 2023 07:44:04 -0500
X-Gmail-Original-Message-ID: <CAL_JsqK3aC4RoKDEfhepz9=Vo5+1MLG9Kcm=-tcFCNc6-hkYgA@mail.gmail.com>
Message-ID: <CAL_JsqK3aC4RoKDEfhepz9=Vo5+1MLG9Kcm=-tcFCNc6-hkYgA@mail.gmail.com>
Subject: Re: [PATCH] of: dynamic: Fix potential memory leak in of_changeset_action()
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        kbuild test robot <lkp@intel.com>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 13, 2023 at 1:29=E2=80=AFAM Dan Carpenter <dan.carpenter@linaro=
.org> wrote:
>
> On Tue, Sep 12, 2023 at 10:32:08AM -0500, Rob Herring wrote:
> > On Fri, Sep 8, 2023 at 11:14=E2=80=AFAM Dan Carpenter <dan.carpenter@li=
naro.org> wrote:
> > >
> > > On Fri, Sep 08, 2023 at 05:34:53PM +0200, Geert Uytterhoeven wrote:
> > > > > > Fixes: 914d9d831e61 ("of: dynamic: Refactor action prints to no=
t use "%pOF" inside devtree_lock")
> > > > > > Reported-by: kernel test robot <lkp@intel.com>
> > > > > > Closes: https://lore.kernel.org/r/202309011059.EOdr4im9-lkp@int=
el.com/
> > > > >
> > > > > Despite what that says, it was never reported to me. IOW, the add=
ed TO
> > > > > and CC lines don't seem to have any effect.
> > > >
> > > > The copy I received did list you in the "To"-header, though.
> >
> > Are you sure that's the header and not in the body?
> >
>
> How these warnings work is that the kbuild bot sends the email to me and
> the oe-kbuild@lists.linux.dev list.  I look it over and send it out
> publicly if the warning seems right.
>
> You're seeing the first email that I hadn't forwarded yet but the second
> forwarded email went out and it reached lkml.
>
> https://lore.kernel.org/lkml/eaa86211-436d-445b-80bd-84cea5745b5a@kadam.m=
ountain/raw
>
> You're on the To: header so it should have reached you as well...

Ah, okay. I have that one. It just got dumped off to my lkml folder
rather than one I have for 0-day which I actually look at.

Thanks for the explanation. Looks like I need to adjust my filters for thes=
e.

Rob
