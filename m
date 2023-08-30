Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3740E78D147
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 02:46:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239437AbjH3AqN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 20:46:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240015AbjH3Apl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 20:45:41 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46B5219A
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 17:45:38 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-27178b6417fso2215286a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 17:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693356338; x=1693961138; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=03m2A+TmUzgwhqrt9lI9ZZVbFhAvl2ARTiZlbzfRzC0=;
        b=Uix+AnNQO6XxqHVpvEolVOeSvw3DGoCXo7B7OWveMONkzJ9dS5uzMnvyhxz58r6sEd
         olztLVgw6tPViA2LYIPny7ID4YyFPvXm0aRwQdMgOUP/3zz8DxrHNV4sRyopcXl0E4Ph
         9lyCF9eiWsDxD6P77u+P//Cqr6WNZvhUzep80=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693356338; x=1693961138;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=03m2A+TmUzgwhqrt9lI9ZZVbFhAvl2ARTiZlbzfRzC0=;
        b=OL5X2ULSo1fW6I39K5L242Iy+lecr7anQ71so3OqJOnRusSlWSDBvXIi0KstUT1Sb/
         nj9oyMfBtErkmWBfRBaBq/tro3M9LnXDUfrJrsAsHff1h6X0yavMSY7s/sX88HFLOQjN
         RAT6SRBTyHLgIqKcRdxGZaVVjCgPFF/iz75NSiyyUMEf3451BfXgzfoZriXHzhLciPZX
         A7kBLJfh86i+NXE2HobPnRz5SUIOh1QxeW9unmoSUjXvtt6ZL/AG0z8EiAPscqYHwO2J
         KpYvdV2lYuHeDbrRURcEd0UycujqCMtRjwXwvlc31akOhOMkCkNaBKwGRdzXklDr2hCq
         8PKQ==
X-Gm-Message-State: AOJu0Yw67r3Zq4+Xfnrm8r4lvwx/fSm1xMSXKJ4DtPeVnxOt/qrEzIzS
        9natsqbwvfl9QnLtk52BW6DwZw==
X-Google-Smtp-Source: AGHT+IHYjpZQOYH32iyhG+dAWZLq6k37sN9+T4hVIVxiqFu/DJ8Z4UetURj4TiF4f5nBLcGIckVxDQ==
X-Received: by 2002:a17:90a:ea87:b0:268:3ea0:7160 with SMTP id h7-20020a17090aea8700b002683ea07160mr850064pjz.0.1693356337723;
        Tue, 29 Aug 2023 17:45:37 -0700 (PDT)
Received: from google.com (KD124209188001.ppp-bb.dion.ne.jp. [124.209.188.1])
        by smtp.gmail.com with ESMTPSA id t24-20020a17090aba9800b0026b4ca7f62csm162223pjr.39.2023.08.29.17.45.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 17:45:37 -0700 (PDT)
Date:   Wed, 30 Aug 2023 09:45:33 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Jonathan Corbet <corbet@lwn.net>,
        Tomasz Figa <tfiga@chromium.org>, linux-kbuild@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kconfig: add warn-unknown-symbols sanity check
Message-ID: <20230830004533.GG3913@google.com>
References: <20230826071359.2060501-1-senozhatsky@chromium.org>
 <CAK7LNAROnZpZiOC4eS5kTcv4Q2YDrE9KYBD-dVcfXwBPQWvbmg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNAROnZpZiOC4eS5kTcv4Q2YDrE9KYBD-dVcfXwBPQWvbmg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (23/08/29 22:13), Masahiro Yamada wrote:
> > +KCONFIG_WARN_UNKNOWN_SYMBOLS
> > +----------------------------
> > +This environment variable makes Kconfig warn about all unrecognized
> > +symbols in the .config file.
> 
> 
> This warns not only for the .config but also defconfig files.
> 
> Could you reword it?
> 
> For example,
> 
>  "symbols in the config input".

Done.

> 
> 
> > +
> > +KCONFIG_WERROR
> > +--------------
> > +If set, Kconfig will treat `KCONFIG_WARN_UNKNOWN_SYMBOLS` warnings as
> > +errors.
> 
> My hope is to turn other warnings in the config file into errors.

Done.

> > +++ b/scripts/kconfig/confdata.c
> > @@ -349,7 +349,12 @@ int conf_read_simple(const char *name, int def)
> >         char *p, *p2;
> >         struct symbol *sym;
> >         int i, def_flags;
> > +       bool found_unknown = false;
> > +       const char *warn_unknown;
> > +       const char *werror;
> >
> > +       warn_unknown = getenv("KCONFIG_WARN_UNKNOWN_SYMBOLS");
> > +       werror = getenv("KCONFIG_WERROR");
> >         if (name) {
> >                 in = zconf_fopen(name);
> >         } else {
> > @@ -437,6 +442,13 @@ int conf_read_simple(const char *name, int def)
> >                         if (def == S_DEF_USER) {
> >                                 sym = sym_find(line + 2 + strlen(CONFIG_));
> >                                 if (!sym) {
> > +                                       if (warn_unknown) {
> > +                                               conf_warning("unknown symbol: %s",
> > +                                                            line + 2 + strlen(CONFIG_));
> > +                                               found_unknown = true;
> > +                                               continue;
> 
> Please drop this 'continue' because it would skip
> conf_set_changed(true).

My bad. Those 'continue' are left-overs from previous version.

> > +                                       }
> > +
> >                                         conf_set_changed(true);
> >                                         continue;
> >                                 }
> > @@ -471,6 +483,13 @@ int conf_read_simple(const char *name, int def)
> >
> >                         sym = sym_find(line + strlen(CONFIG_));
> >                         if (!sym) {
> > +                               if (warn_unknown && def != S_DEF_AUTO) {
> > +                                       conf_warning("unknown symbol: %s",
> > +                                                    line + strlen(CONFIG_));
> > +                                       found_unknown = true;
> > +                                       continue;
> 
> Same here.

Same here. My bad.

> > @@ -519,6 +538,10 @@ int conf_read_simple(const char *name, int def)
> >         }
> >         free(line);
> >         fclose(in);
> > +
> > +       if (found_unknown && werror)
> > +               exit(1);
> 
> 
> I like to reuse 'conf_warnings' as you did in the previous version.

Done.
