Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60DB180ABA8
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 19:11:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232869AbjLHSLU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 13:11:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbjLHSLS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 13:11:18 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 704E590
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 10:11:24 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 147B8C433C7;
        Fri,  8 Dec 2023 18:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702059084;
        bh=+F+CuKHjMhjOaVmDV9U/s8l7zrO94PrksbiVe6XkcXg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=I8hmSMa+C7BeWc+f7WDx935Prfc4M1k0zk4ffWscm2PljjTOt0YXZQ4pjXhyOZL+n
         6tMZItugZ/qeVB9J8ejMkOacIJ4C9pkdIl4+NCxC64tIjKs7WhiXuXsGVnctSrKq7y
         4VTihcYiZQ6e8ZDoLfJIJbWZw/vrH6aKhk9IHIxZddiNAlCLQfhIYAWL+DIhxF8Cx4
         GWN0G3tF5PuvHjfUr7bSmaAcoxCaFjgtQotOsypI6a2JCPqQVFJKJTwL9yh6lSmvNC
         FISt9wiMGW1IqTehrbAqq6iPxMFZUrigeoB2+/eQWHnM33OXIycIcYLUGJM9AHgwyE
         uaDSbIbhT22iA==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-50bef9b7a67so2667226e87.1;
        Fri, 08 Dec 2023 10:11:23 -0800 (PST)
X-Gm-Message-State: AOJu0YzTtvpOekWdghHpxMcD75XJJxIWQVle6BVF3Xbik70nts38CDqE
        o97sBDjhZ7aTvERPV0cRATziKCPY/XSQwQX5Zhw=
X-Google-Smtp-Source: AGHT+IG6LJR5y7Arr5OwpIwgsyoV0O6bDJv5rQ3+/wPqJVZq1OA5HIuoJtYWlq5B7EYjpwpdlv5oQAchTUPCPjAGzKw=
X-Received: by 2002:a05:6512:488d:b0:50b:e750:dd99 with SMTP id
 eq13-20020a056512488d00b0050be750dd99mr142687lfb.38.1702059082273; Fri, 08
 Dec 2023 10:11:22 -0800 (PST)
MIME-Version: 1.0
References: <03dd7de1cecdb7084814f2fab300c9bc716aff3e.1701632867.git.christophe.jaillet@wanadoo.fr>
 <202312041419.81EF03F7B7@keescook> <CAPhsuW43g-M+xvzD0N1JsJ_zGnvZQOw2Bi1TEqoHKanPnvMHLQ@mail.gmail.com>
 <202312080926.FBF7A2DDD2@keescook>
In-Reply-To: <202312080926.FBF7A2DDD2@keescook>
From:   Song Liu <song@kernel.org>
Date:   Fri, 8 Dec 2023 10:11:10 -0800
X-Gmail-Original-Message-ID: <CAPhsuW5F1aRrCRW-ad5Sq=cgxHX+QgXgYZyMX17Zj4Mj=Jnhjw@mail.gmail.com>
Message-ID: <CAPhsuW5F1aRrCRW-ad5Sq=cgxHX+QgXgYZyMX17Zj4Mj=Jnhjw@mail.gmail.com>
Subject: Re: [PATCH] md/md-multipath: Convert "struct mpconf" to flexible array
To:     Kees Cook <keescook@chromium.org>
Cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-raid@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 8, 2023 at 9:27=E2=80=AFAM Kees Cook <keescook@chromium.org> wr=
ote:
>
> On Thu, Dec 07, 2023 at 09:33:17PM -0800, Song Liu wrote:
> > On Mon, Dec 4, 2023 at 2:20=E2=80=AFPM Kees Cook <keescook@chromium.org=
> wrote:
> > >
> > > On Sun, Dec 03, 2023 at 08:48:06PM +0100, Christophe JAILLET wrote:
> > > > The 'multipaths' field of 'struct mpconf' can be declared as a flex=
ible
> > > > array.
> > > >
> > > > The advantages are:
> > > >    - 1 less indirection when accessing to the 'multipaths' array
> > > >    - save 1 pointer in the structure
> > > >    - improve memory usage
> > > >    - give the opportunity to use __counted_by() for additional safe=
ty
> > > >
> > > > Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> > >
> > > This looks like a really nice conversion. I haven't run-tested this, =
but
> > > it reads correct to me.
> >
> > Agreed this is a good optimization. However, since MD_MULTIPATH is
> > already marked as deprecated. I don't think we should ship further
> > changes to it.
>
> Hm, that seems like a weird catch-22 to me. I would say we should
> continue to improve any code in the kernel that people spend time to
> work on, or we should remove that code entirely. Should MD_MULTIPATH be
> removed? How long has it been deprecated? (We just had an LTS release,
> so doing removal now is a good time...)

We marked it as deprecated about 2.5 years ago. But to be honest,
I currently don't have a plan to remove it. I guess I should start thinking
about it.

Thanks,
Song
