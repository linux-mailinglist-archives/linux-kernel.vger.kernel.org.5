Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4419078645E
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 03:01:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238935AbjHXBBF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 21:01:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238931AbjHXBAv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 21:00:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 104BCE4E;
        Wed, 23 Aug 2023 18:00:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 83310638C2;
        Thu, 24 Aug 2023 01:00:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D76C3C433C8;
        Thu, 24 Aug 2023 01:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692838848;
        bh=igIfxW+ILE6Z5O0t/aI5hZNrwzQRTTt2FxUYYrKV5Gc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=t+F2qZQkVEJ+7HrGO9xMnM1+FFGN2mfgDFV8mvEnuHOTFx9gnnIPL6ohA+dDgn8fC
         Qt4OKKbUdULesiM2JAjtppCHOutPLqPVdaHw5xrhH9EMaJZtgKp/VW99x731jDFVk6
         v7f76fzEPKDIGV8+KmdDVil2EFCTyWT+j0OoLj2g6qlgiwRySo3wvlKtSQ/44eB77U
         nc0XBbVfKpUyiA3SsIOHnkHLAGJtUO5Y177Qlq0xtWQ1hlHKT09NGFEuIAom9Rw8I1
         Fb0zN6EgDLferk+P9nRAb2ELNTKLbG9lJLFmSNsQKKu9hzQCFGtznnxkzbF76qIlCB
         t2by0w7Du4wTw==
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-570b6f82301so2910756eaf.0;
        Wed, 23 Aug 2023 18:00:48 -0700 (PDT)
X-Gm-Message-State: AOJu0YzqqwK0RDkpzAC15GDi4/kPxpUEA12L75uz2ukcre+CDV3l2hDW
        7fPhLBLVVDN9afv5rnSwLbRpuIYVPaRndgeM2Rw=
X-Google-Smtp-Source: AGHT+IFBLkhQqjGN0mYoEomVtRt5tLfr7zKLqMBurOntLcxFuCoxAYAnVaADi9M4IBZGb6GXjO0NMFVweGMiaE9RTeI=
X-Received: by 2002:a05:6870:e0c9:b0:1c0:25c0:ebe5 with SMTP id
 a9-20020a056870e0c900b001c025c0ebe5mr16019625oab.53.1692838848091; Wed, 23
 Aug 2023 18:00:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230817012007.131868-1-senozhatsky@chromium.org>
 <CAK7LNASJWKSsdzn5ccgWaC35-XvHGU7pnE6C=eZFDbqrrghtdQ@mail.gmail.com>
 <20230820024519.GK907732@google.com> <CAK7LNAS9KC1GjPgadMEivSpy4TMYU8mQ+BrtfJpNs2kvhK18yA@mail.gmail.com>
 <20230820072119.GM907732@google.com> <20230820073332.GN907732@google.com>
 <CAK7LNARTZXvWD8PrA3bC+Ok7LK85qO=pkMs4kOPGn90OBooL6w@mail.gmail.com> <20230822061203.GA610023@google.com>
In-Reply-To: <20230822061203.GA610023@google.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Thu, 24 Aug 2023 10:00:11 +0900
X-Gmail-Original-Message-ID: <CAK7LNAS0qEZk+xAq84=7SuJSQz5F3dNBjYKPoeKTd_caq-QMKg@mail.gmail.com>
Message-ID: <CAK7LNAS0qEZk+xAq84=7SuJSQz5F3dNBjYKPoeKTd_caq-QMKg@mail.gmail.com>
Subject: Re: [RFC][PATCH] kconfig: introduce listunknownconfig
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Ying Sun <sunying@nj.iscas.ac.cn>,
        Jesse T <mr.bossman075@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
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

On Tue, Aug 22, 2023 at 4:30=E2=80=AFPM Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> On (23/08/21 21:27), Masahiro Yamada wrote:
> >
> > My (original) hope was to add a single switch, KCONFIG_VERBOSE, to addr=
ess both:
> >
> >   - A CONFIG option is hidden by unmet dependency (Ying Sun's case)
> >   - A CONFIG option no longer exists  (your case)
> >   - Anything else we need to be careful
>
> A quick question: is it too late to suggest an alternative name?
> Could KCONFIG_SANITY_CHECKS be a little cleaner? Because we basically
> run sanity checks on the config.


Ying's is not applied yet. So, it is not too late.

But, I started to be a little worried
because it is unpredictable how many KCONFIG_* env
variables will increase until people are satisfied.

>
> And one more question: those sanity checks seem very reasonable.
> Is there any reason we would not want to keep them ON by default?
> And those brave souls, that do not wish for the tool to very that
> the .config is sane and nothing will get downgraded/disabled, can
> always set KCONFIG_SANITY_CHECKS to 0.


Kconfig is meant to resolve the dependency without causing an error.
If a feature is not available, it is automatically, silently hidden,
and that works well.

When a compiler does not support a particular feature,
'depends on $(cc-option )' hides that CONFIG option.
Kconfig is meant to work like that.



For your case, it is case-by-case.

Let's say a stale code is removed from upstream.

After "obj-$(CONFIG_FOO) +=3D foo.o" is removed
from upstream, CONFIG_FOO in the .config is a "don't care".

If it were an error, all arch/*/configs/*_defconfig
must be cleaned up at the same time.


So, sometimes it is helpful, but sometimes noisy.




For the MFD_RK808 case particularly,
I believe Kconfig showed MFD_RK8XX_I2C
as a new option.

Or, when you bumped to a new kernel version,
you could run 'make listnewconfig'.
(See 17baab68d337a0bf4654091e2b4cd67c3fdb44d8.
Redhat says they review every new config option.)


If you had done a per-config review
you would have noticed
c20e8c5b1203af3726561ee5649b147194e0618e
before spending time on run-time debugging.




--=20
Best Regards
Masahiro Yamada
