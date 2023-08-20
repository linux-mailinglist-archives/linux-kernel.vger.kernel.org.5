Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19CF1781C95
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Aug 2023 08:02:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbjHTGCs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Aug 2023 02:02:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjHTGCc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Aug 2023 02:02:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1055422A39;
        Sat, 19 Aug 2023 22:12:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8E8906182A;
        Sun, 20 Aug 2023 05:12:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1597C433C8;
        Sun, 20 Aug 2023 05:12:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692508325;
        bh=FvDr/dOuSBFMzqfBbCipsALY383eEHqj2Qwe11D0HDA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KaN8k0NY77Wny/IQOJMxFoSGNrKN4NwtmU34eA1QyNTKsbSrH/kwLp9nw02mCBVmx
         /YT4Z0Ffe6EWO13yd8iyxJwVJ9CaJfLa6LVrlHzSueINLPtmsjb2gmQ9m0dnNc2SbL
         jmsVIkWLuxZ/CNIV3Lf0O1/W1vNrK8bgfU//bVeAX5ykuadsjfxTWRc61yfu/03iC8
         G5bIkiDPsSdDTy2e1NGgyV7SkXMzX2ZMve2h4/38p0bj3ihNl+od8E4obH/M03xyie
         zi8sYv+HXvVV8pD+DXTcYOOVi9j2/7AJqqHcm4dqmxocqukz20o2bJjXM3ZcNFp1ns
         B9UDCkfI9y0xQ==
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-570bf51cb96so247239eaf.0;
        Sat, 19 Aug 2023 22:12:05 -0700 (PDT)
X-Gm-Message-State: AOJu0Yw4UThhXM6Bxj+xcrc7GkfZslUwRHY94W4KJ/3+sTXwIpOTsLOj
        xXbqh01xjV330c3+CD0H/Mn7IejlrT5LdqoyeIY=
X-Google-Smtp-Source: AGHT+IHzO4eqjEpPnew8SirXjxbH4XY7DpO8dFrmzm+w9atlwVBaJBJn1veuEp92e8AUHCrKjbSikzI8chtwMjMrUK0=
X-Received: by 2002:a4a:851b:0:b0:56c:c061:a9a8 with SMTP id
 k27-20020a4a851b000000b0056cc061a9a8mr3189511ooh.0.1692508325067; Sat, 19 Aug
 2023 22:12:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230817012007.131868-1-senozhatsky@chromium.org>
 <CAK7LNASJWKSsdzn5ccgWaC35-XvHGU7pnE6C=eZFDbqrrghtdQ@mail.gmail.com> <20230820024519.GK907732@google.com>
In-Reply-To: <20230820024519.GK907732@google.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sun, 20 Aug 2023 14:11:28 +0900
X-Gmail-Original-Message-ID: <CAK7LNAS9KC1GjPgadMEivSpy4TMYU8mQ+BrtfJpNs2kvhK18yA@mail.gmail.com>
Message-ID: <CAK7LNAS9KC1GjPgadMEivSpy4TMYU8mQ+BrtfJpNs2kvhK18yA@mail.gmail.com>
Subject: Re: [RFC][PATCH] kconfig: introduce listunknownconfig
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Jonathan Corbet <corbet@lwn.net>,
        Tomasz Figa <tfiga@chromium.org>, linux-kbuild@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Sun, Aug 20, 2023 at 1:20=E2=80=AFPM Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> On (23/08/20 08:19), Masahiro Yamada wrote:
> > > Example:
> > > Suppose old .config has the following two options which
> > > were removed from the recent kernel:
> > >
> > > $ cat .config
> > > CONFIG_DISABLE_BUGS=3Dy
> > >
> > > Running `make listunknownconfig` produces the following
> > > list of unrecognized symbols:
> > >
> > > .config:6:warning: unknown symbol: DISABLE_BUGS
> > > .config:7:warning: unknown unset symbol: ENABLE_WINAPI
> > >
> > > Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> >
> >
> > A new target is not what I like to see.
> >
> >
> > We decided to add KCONFIG_VERBOSE, which will be used to
> > warn options accidentally disabled or downgraded.
>
> That doesn't seem cover the cases that I'm concerned with. I don't see
> anything related to "!sym" in the patch.
>
> What will KCONFIG_VERBOSE do if it reads the following config file?
>
> // assuming that both config options were valid and existed in the old
> // kernel, but were removed/renamed in the new kernel
>
>  $ cat .config
>  CONFIG_DISABLE_BUGS=3Dy
>  # CONFIG_ENABLE_WINAPI is not set
>
>
> I'd like to see warnings for both lines, even for config that is not
> set, because it maybe we set by a build script depending on USE flags
> for instance, so that build target may still refer to non-existent
> config.


I did not say Ying Sun's patch covered your case.

I just meant I dislike your approach.

After his patch is applied, please come back with a similar approach
if you want to address your case in the mainline kernel.



--=20
Best Regards
Masahiro Yamada
