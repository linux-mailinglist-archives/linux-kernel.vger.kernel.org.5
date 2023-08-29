Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD8BF78BCE1
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 04:37:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235392AbjH2Cgb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 22:36:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233143AbjH2CgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 22:36:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C670A139;
        Mon, 28 Aug 2023 19:36:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5ADB260CEC;
        Tue, 29 Aug 2023 02:36:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2D5DC433C8;
        Tue, 29 Aug 2023 02:36:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693276578;
        bh=GR786N1WG+6u7KDhtMNYzwV4w0yqeHQX13Xo8ZwlNKM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=VTYmWKaKevaNznKPQb9Vg7GxV+IYK9Q/oOWrANVXZ8QqcKjfp5UVpPO9rTa/fvTI0
         jA7TlguM070y8otXRlyzzCXMZaxYq1VF2X8krusAMXIQXiTJyEpyLisAwb1eW/OpYs
         eevNj4V7nkF8zbQsbovIUotdETdxsJypRuTNNcpnVlTJE3n3qVpKt5be3GTZ5GTEWF
         LVBjTiYfs/hzqoFQ6EuSIDtLxBe2N9z0lRl7tt/TFxworkx4DKU9+8ve9o+iWXt4Ob
         GhubYAPtXO/SXU3SLcdOpCCG6+5o7CUw9ozmx+he7cV/XTv0MuQXwyMrIcjXROGxoI
         xPDd8/4/PQw3g==
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-571194584e2so2480763eaf.3;
        Mon, 28 Aug 2023 19:36:18 -0700 (PDT)
X-Gm-Message-State: AOJu0YzNRMaz7pRJ05uzMogC9aWFQrkxzGzzEa9iRan8C0m6PwLR/ce3
        KtOy3sz5avqkGNS9fC1p92/okkyZ89CU91q75LY=
X-Google-Smtp-Source: AGHT+IHFjR4ul+Tuk0znXoAjKIj9khNjYdgRNj3UF0yVzWH/x+XiTMfPP0bSIc8TlR7+ojMzA6QjyUL1FIMVk3hZlwM=
X-Received: by 2002:a4a:ea3b:0:b0:56d:e6:21bf with SMTP id y27-20020a4aea3b000000b0056d00e621bfmr13266092ood.0.1693276577944;
 Mon, 28 Aug 2023 19:36:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230823115048.823011-1-masahiroy@kernel.org> <20230823115048.823011-6-masahiroy@kernel.org>
 <ZOyuY5XCfYEV8fW6@bergen.fjasle.eu>
In-Reply-To: <ZOyuY5XCfYEV8fW6@bergen.fjasle.eu>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 29 Aug 2023 11:35:41 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQ=5x+zOApY95Oqen0tyfVthb7QYjeskgQmUqGBDtSoiw@mail.gmail.com>
Message-ID: <CAK7LNAQ=5x+zOApY95Oqen0tyfVthb7QYjeskgQmUqGBDtSoiw@mail.gmail.com>
Subject: Re: [PATCH 6/8] kbuild: move more module installation code to scripts/Makefile.modinst
To:     Nicolas Schier <nicolas@fjasle.eu>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
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

On Tue, Aug 29, 2023 at 11:15=E2=80=AFAM Nicolas Schier <nicolas@fjasle.eu>=
 wrote:
>
> On Wed 23 Aug 2023 20:50:46 GMT, Masahiro Yamada wrote:
> > Move more relevant code to scripts/Makefile.modinst.
> >
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > ---
> >
> >  Makefile                 | 34 +++++++--------------------------
> >  scripts/Makefile.modinst | 41 +++++++++++++++++++++++++++++++++++++---
> >  2 files changed, 45 insertions(+), 30 deletions(-)
> >
> > diff --git a/Makefile b/Makefile
> > index 7d9cab3d2186..82d22debf6c9 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -1477,24 +1477,6 @@ endif
> >
> >  endif # CONFIG_MODULES
> >
> > -modinst_pre :=3D
> > -ifneq ($(filter modules_install,$(MAKECMDGOALS)),)
> > -modinst_pre :=3D __modinst_pre
> > -endif
> > -
> > -modules_install: $(modinst_pre)
> > -PHONY +=3D __modinst_pre
> > -__modinst_pre:
> > -     @rm -rf $(MODLIB)/kernel
> > -     @rm -f $(MODLIB)/build
> > -     @mkdir -p $(MODLIB)
> > -ifdef CONFIG_MODULES
> > -     @ln -s $(CURDIR) $(MODLIB)/build
> > -     @sed 's:^\(.*\)\.o$$:kernel/\1.ko:' modules.order > $(MODLIB)/mod=
ules.order
> > -endif
> > -     @cp -f modules.builtin $(MODLIB)/
> > -     @cp -f $(objtree)/modules.builtin.modinfo $(MODLIB)/
> > -
> >  ###
> >  # Cleaning is done on three levels.
> >  # make clean     Delete most generated files
> > @@ -1836,12 +1818,15 @@ help:
> >       @echo  '  clean           - remove generated files in module dire=
ctory only'
> >       @echo  ''
> >
> > +ifndef CONFIG_MODULES
> > +modules modules_install: __external_modules_error
> >  __external_modules_error:
> >       @echo >&2 '***'
> >       @echo >&2 '*** The present kernel disabled CONFIG_MODULES.'
> >       @echo >&2 '*** You cannot build or install external modules.'
> >       @echo >&2 '***'
> >       @false
> > +endif
> >
> >  endif # KBUILD_EXTMOD
> >
> > @@ -1850,6 +1835,9 @@ endif # KBUILD_EXTMOD
> >
> >  PHONY +=3D modules modules_install modules_prepare
> >
> > +modules_install:
> > +     $(Q)$(MAKE) -f $(srctree)/scripts/Makefile.modinst
>
> I was a bit surprised to see 'modules_install' being allowed
> unconditionally for in-tree usage (thus, even if CONFIG_MODULES=3Dn), but
> then realised that this is the same behaviour as we had before.  Out of
> curiosity:  _why_ do we need to install
> $(MODLIB)/modules.builtin{,.modinfo} also for configs w/
> CONFIG_MODULES=3Dn?


I see your tags in commit
8ae071fc216a25f4f797f33c56857f4dd6b4408e    :)


Some drivers need to load firmware.

To make such drivers working in initrd,
mkinitramfs needs to copy necessary firmware files
into the initrd.
So, the tool needs to know which drivers are enabled.

That is my understanding why modules.builtin(.modinfo)
is needed even with CONFIG_MODULES=3Dn.





--=20
Best Regards
Masahiro Yamada
