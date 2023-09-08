Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DC7979824D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 08:24:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240720AbjIHGYG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 02:24:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237063AbjIHGYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 02:24:04 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB4B419A6
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 23:23:59 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id d75a77b69052e-414c54b2551so138641cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Sep 2023 23:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1694154239; x=1694759039; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TBd0PEKDa0GklZY+3jaMMJ9dni8AGLqK5Rg/U8MR1Nk=;
        b=XxxugHaHyCpPfOdNB7o23Fxr6uih9bGN0jcgHZJqaa54RS8y/mUK3Io1gLnY3nW5cq
         B46nF7iVJs6PlBgXSDfaQYLoKTWGBFo4a2U+AC7eloX9sPQRNZoJ9teDUqVsXylq+wGu
         xftz1j1Jm+h/KzAx12myRQfYRjXiK0TrSFoMm0kdCbXo6rX/8oPlAWzOp/Wb4oU/Mv5y
         rvGnI7FnCq/XMUK30Ln5AfE1mJ5qM2oLtKEJSjIv1R3c/Jl3UD00RZmMZGfjwiGfrS9h
         WRMgA2TXuaM9Y4TuTgIZPhEsGjoALWIxy+UKYHtvHbp6vDP1yUiSG9vYbS+ksMGu7FLE
         ZxlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694154239; x=1694759039;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TBd0PEKDa0GklZY+3jaMMJ9dni8AGLqK5Rg/U8MR1Nk=;
        b=rX51OZqttNnF6+tNs7ZmWsDghqP1GCmGy131hvrjcgAl0POhNySG63jue+E9IwaVg6
         9yl8OxujclyXNfF3WrKks1htWp9I9SudOjLVz/6kZM+80zcUj5OUL4VtFYIkGPdj2S+d
         5YGEZ4nb3YT+84upisJCzaMn07/OZ42GVXpt7yyC2wqeVwdW4bD6k0SdAuAZ7q1cAUnW
         zuXeuQ01/e7REeyiaSJrnFWwcFXge05wxa/i2Rf/khYJITe4a5BUPPXZ5VZf69c81wPw
         jvXK8Hz1vLrDVBPw1eA0WvPrDiJY7DvJ1OmulgDHmTIe75qVM0nHJDE3TiLCE+ydUiiq
         DzYQ==
X-Gm-Message-State: AOJu0YwSAbcgLnsPUTXfrHhGz7ynQjDFHx2nnswdp/p/ngjFMi0WbZnZ
        beiiEzGngZDE2NssGmxw0yULjyHanRvIfk/vy8qS+khLrkfm4y3OqSSKsg==
X-Google-Smtp-Source: AGHT+IEcYwEKNhzhb/oN2gICOT6FKzcOxeFWdr7HQvla5c8T0wJmYsDcsmPUMvIPR6VVA1RlVpe6FYtCFG1iDW+cXcE=
X-Received: by 2002:a05:622a:1315:b0:3ef:5f97:258f with SMTP id
 v21-20020a05622a131500b003ef5f97258fmr168200qtk.16.1694154238897; Thu, 07 Sep
 2023 23:23:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230908052216.566148-1-namhyung@kernel.org>
In-Reply-To: <20230908052216.566148-1-namhyung@kernel.org>
From:   Ian Rogers <irogers@google.com>
Date:   Thu, 7 Sep 2023 23:23:46 -0700
Message-ID: <CAP-5=fUtEvW9h7N=w3vvYBB3vytnTXJsXrHDD6zLA2DzYFOBHQ@mail.gmail.com>
Subject: Re: [PATCH] perf annotate: Add more x86 mov instruction cases
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
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

On Thu, Sep 7, 2023 at 10:22=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> Instructions with sign- and zero- extention like movsbl and movzwq were
> not handled properly.  As it can check different size suffix (-b, -w, -l
> or -q) we can omit that and add the common parts even though some
> combinations are not possible.
>
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/arch/x86/annotate/instructions.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/tools/perf/arch/x86/annotate/instructions.c b/tools/perf/arc=
h/x86/annotate/instructions.c
> index 5f4ac4fc7fcf..5cdf457f5cbe 100644
> --- a/tools/perf/arch/x86/annotate/instructions.c
> +++ b/tools/perf/arch/x86/annotate/instructions.c
> @@ -74,12 +74,15 @@ static struct ins x86__instructions[] =3D {
>         { .name =3D "movdqa",     .ops =3D &mov_ops,  },
>         { .name =3D "movdqu",     .ops =3D &mov_ops,  },
>         { .name =3D "movsd",      .ops =3D &mov_ops,  },
> -       { .name =3D "movslq",     .ops =3D &mov_ops,  },
>         { .name =3D "movss",      .ops =3D &mov_ops,  },
> +       { .name =3D "movsb",      .ops =3D &mov_ops,  },
> +       { .name =3D "movsw",      .ops =3D &mov_ops,  },
> +       { .name =3D "movsl",      .ops =3D &mov_ops,  },

In Intel's manual some of these names are "Move Data From String to
String" operations, movsb and movsw in particular. These instructions
can be used to make simple memcpy loops. Could it be the past omission
was deliberate due to the different way the addressing works in the
instructions?

Thanks,
Ian

>         { .name =3D "movupd",     .ops =3D &mov_ops,  },
>         { .name =3D "movups",     .ops =3D &mov_ops,  },
> -       { .name =3D "movzbl",     .ops =3D &mov_ops,  },
> -       { .name =3D "movzwl",     .ops =3D &mov_ops,  },
> +       { .name =3D "movzb",      .ops =3D &mov_ops,  },
> +       { .name =3D "movzw",      .ops =3D &mov_ops,  },
> +       { .name =3D "movzl",      .ops =3D &mov_ops,  },
>         { .name =3D "mulsd",      .ops =3D &mov_ops,  },
>         { .name =3D "mulss",      .ops =3D &mov_ops,  },
>         { .name =3D "nop",        .ops =3D &nop_ops,  },
> --
> 2.42.0.283.g2d96d420d3-goog
>
