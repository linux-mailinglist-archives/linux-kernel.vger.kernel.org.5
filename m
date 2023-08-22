Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B36A5784857
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 19:21:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbjHVRVx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 13:21:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjHVRVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 13:21:52 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DF5D10C9
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 10:21:50 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-307d20548adso4040396f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 10:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692724909; x=1693329709;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jsUwj2O0QlrcEW9NpP/XIQy8tRK8Cwy9R0XymaCyX6k=;
        b=OqUXjPvS+2NJE7N7FUzF1h5yo04GOE7ukz0dtFBxe4aIzQ5fUSEU3lKmd702sUfl6X
         d0GHo4rFgZ41j3grf4kThOjxOWF15PRWZn8Uz6yJ0uzsqaDfHRuK86AjmD+MsuYBqikL
         6R/H7gLZjmQdwB0TPFuXH6ZCkYB49TyB8jVPQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692724909; x=1693329709;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jsUwj2O0QlrcEW9NpP/XIQy8tRK8Cwy9R0XymaCyX6k=;
        b=Xh8KeMySGzo/bE0220bljJ0s9FULsAdOjzKM328dafnlj8wDRtk5TsqkltzadUvImk
         hyiH7RrslRtAbeFLm2SZQkTMsbRFYSuZj1p8fiZat9aIOY1riSJ2wKkTkgvgd7TeW/90
         zcknlgw6ErWeiUPZm5h5CxHBV/KDpUBKflGOlRHXRoPiQTPKlhcu8sM2zHi4EJEEvjbu
         A1r41B5DL531V2Z3VuGJoX02bVDXWZ/KZOepmv5DoMA6phvE7TBlZmOKqhlPg1vKuEoO
         LW8/5xSMg1e7eHmyVZxQLzIgrRBanjOFzAh8IPLIA6njeGlujvZpRkzqtkOAvjAvX8vy
         BGoQ==
X-Gm-Message-State: AOJu0Yyb+B1DgHr7FDrCoARPc1Uo3Wx322F7jbbhUl/SrVyHC20G2gGz
        SUGwtGYqmQXVvbkJrrUQi0L3V9uEK7nOMs99sQ0wDA==
X-Google-Smtp-Source: AGHT+IF3Z4djchwRgxM1JEfE6eBbPj+67XFA+OLB6qoat0hpUFzR5kZ0PS1zGhdT3w2TJ9C+P1TCgzaXGqNiGQDpF00=
X-Received: by 2002:adf:e4c9:0:b0:31a:dbd8:95d4 with SMTP id
 v9-20020adfe4c9000000b0031adbd895d4mr7434871wrm.12.1692724908335; Tue, 22 Aug
 2023 10:21:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230822065256.163660-1-denik@chromium.org> <CAKwvOdmvUCKDk0kU0DVywRRPS9qT09PsQ435GzzuinHkBcRZ0w@mail.gmail.com>
In-Reply-To: <CAKwvOdmvUCKDk0kU0DVywRRPS9qT09PsQ435GzzuinHkBcRZ0w@mail.gmail.com>
From:   Denis Nikitin <denik@chromium.org>
Date:   Tue, 22 Aug 2023 10:21:37 -0700
Message-ID: <CADDJ8CXD05H22G=NsUcZy-uG5+4xQRpCd-UPVL1Z1a0Lybx9+Q@mail.gmail.com>
Subject: Re: [PATCH] modpost: Skip .llvm.call-graph-profile section check
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>, Tom Rix <trix@redhat.com>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Nick Desaulniers <ndesaulniers@google.com>,
        Fangrui Song <maskray@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 22, 2023 at 8:47=E2=80=AFAM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Mon, Aug 21, 2023 at 11:54=E2=80=AFPM Denis Nikitin <denik@chromium.or=
g> wrote:
> >
> > .llvm.call-graph-profile section is added when the kernel is built with
> > profiles (e.g. -fprofile-sample-use=3D<llvm.profile>). The section hold=
s
> > metadata for symbols beloning to other sections and hence doesn't need
> > modpost checks.
> >
> > This change fixes the kernel build with sample profiles which fails
> > with:
> > "FATAL: modpost: Please add code to calculate addend for this architect=
ure"
> >
> > Signed-off-by: Denis Nikitin <denik@chromium.org>
>
> Thanks for the patch. If you send a v2 with Fangrui's suggested
> changes+additions, feel free to carry forward my reviewed by tag.
>
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
>

Thanks! Will do shortly.

- Denis
