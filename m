Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9AFC78460F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 17:47:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237295AbjHVPrQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 11:47:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231487AbjHVPrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 11:47:15 -0400
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com [IPv6:2607:f8b0:4864:20::935])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D11FCD1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 08:47:14 -0700 (PDT)
Received: by mail-ua1-x935.google.com with SMTP id a1e0cc1a2514c-79df1303d01so1511441241.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 08:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692719233; x=1693324033;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HYNvV23/sQh2KUeEtBQywg5ma3vCxQAqr4Fitqyx0c4=;
        b=UN77YUOelf5sJQMuE+614A5Z84E2e6FM84c3z6tTCr6fuXnbnqGlC4ndp0jdFNAtHk
         MqVEHFAGNEBE57eFoVnRrvGC6tw1cyDaceDUw2Q5XzhsWU3I75Nz+p/HgJaJUnDj0oLj
         C0ouC1ra3gvDQ5hhAmIA9MmPYICUNSJgL+Wl2xt7Mt/zFVJ4E5wJnlUnkdVL8lU+RlFM
         MSWyZXsKWxc9ossbSLXVPY/mGxsQEe3/Cq1O02zt/qxIoDoJ5HGP9axj+xvWuJCYdJBi
         PTE3Eq8dg0BPPpZ8BSjUtqxRPTT8iI/ZA9muVe8V3uEVr5t1Bjqo8voB435c6gsuRh7N
         YMOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692719233; x=1693324033;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HYNvV23/sQh2KUeEtBQywg5ma3vCxQAqr4Fitqyx0c4=;
        b=SzyhR0zt3F+Z3vUQ6QR3cM07OwclK+Okm4Rsd6CfrXa8HEcYZDz/VjYUXlsiJizzva
         j5iQiP1Ww40sQTh1pf5esVYCXypYYWVZLKkUwt9uJOvoCd7WPcqBYGn8Z0cToP0dF49g
         lUpt4yqdWla2nOlXTJg8SrLtVDtbX9gkHm/46bkWtkJM/OCiN9brp7YtDrndu+ZnNl9+
         BFWXXLImsSrhyKXM41di7uYDjVsvYRbRDH0JTLuj6GIQxGVAqGha4BIgOK7yneoMjOST
         y7gZ8cSplojR1m2EzjpRjtOfec3CK6R9aHxjpRG6UEV7qQ2Mp2KXePulLufTbdHSOFgY
         5GsQ==
X-Gm-Message-State: AOJu0YzLIUd+Ko7aZqJW7NaoK0Wr7lC/1vpF9GEune3UG37Zfx14ojJe
        bClY8TYW9EwHoGBKJ1IBoILC7/jI0z9Eu7swnjrWAA==
X-Google-Smtp-Source: AGHT+IGObL+V0/ELRu9qQaqOGv9Tp3eKDjtfRuftO2ZQwK2jpACBoKq2mdTSjTDQSxxhDvDhAGyMDcJJCgF8fGBxxk0=
X-Received: by 2002:a67:b34b:0:b0:440:b7df:767b with SMTP id
 b11-20020a67b34b000000b00440b7df767bmr8953767vsm.11.1692719233347; Tue, 22
 Aug 2023 08:47:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230822065256.163660-1-denik@chromium.org>
In-Reply-To: <20230822065256.163660-1-denik@chromium.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 22 Aug 2023 08:47:02 -0700
Message-ID: <CAKwvOdmvUCKDk0kU0DVywRRPS9qT09PsQ435GzzuinHkBcRZ0w@mail.gmail.com>
Subject: Re: [PATCH] modpost: Skip .llvm.call-graph-profile section check
To:     Denis Nikitin <denik@chromium.org>
Cc:     linux-kbuild@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>, Tom Rix <trix@redhat.com>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 21, 2023 at 11:54=E2=80=AFPM Denis Nikitin <denik@chromium.org>=
 wrote:
>
> .llvm.call-graph-profile section is added when the kernel is built with
> profiles (e.g. -fprofile-sample-use=3D<llvm.profile>). The section holds
> metadata for symbols beloning to other sections and hence doesn't need
> modpost checks.
>
> This change fixes the kernel build with sample profiles which fails
> with:
> "FATAL: modpost: Please add code to calculate addend for this architectur=
e"
>
> Signed-off-by: Denis Nikitin <denik@chromium.org>

Thanks for the patch. If you send a v2 with Fangrui's suggested
changes+additions, feel free to carry forward my reviewed by tag.

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>  scripts/mod/modpost.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
> index b29b29707f10..64bd13f7199c 100644
> --- a/scripts/mod/modpost.c
> +++ b/scripts/mod/modpost.c
> @@ -761,6 +761,7 @@ static const char *const section_white_list[] =3D
>         ".fmt_slot*",                   /* EZchip */
>         ".gnu.lto*",
>         ".discard.*",
> +       ".llvm.call-graph-profile",     /* call graph */
>         NULL
>  };
>
> --
> 2.42.0.rc1.204.g551eb34607-goog
>


--=20
Thanks,
~Nick Desaulniers
