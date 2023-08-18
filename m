Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 260F1780EF4
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 17:19:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378084AbjHRPTH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 11:19:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378122AbjHRPTA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 11:19:00 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A53C93C1F
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 08:18:59 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-58c4dce9db8so10145667b3.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 08:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1692371939; x=1692976739;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hgbLHehGpwVrKSLju1qpBYPuFYa1Zpgs9RdgH+2tDII=;
        b=FlXZgkz4zWKb7PKsS5rps111kwpFX3lkqmSTro6wQNWST+yPW1EqI+qf8wxAJuL7tS
         Iwh/XKweMR+vDi65xYrWK0TorlRzT7zUByL6Z3MWTBAnaQNMEfjv8SPs/Z33X0DGA+IQ
         zVMplgFvd7IdCfj5TjSFEpfu0VxZieWlFnCykEdIxzbqBh8JmZMhJXkxAiUjfq5eDy1A
         J9OGIJKC5p9rauMoPjLnrb/4b4FQACUyYhTGEbS5lFiQDFmk3nhU3JzGIXB8OOYzzjMJ
         fJjGfUmu6eY9TjitLgOOb9fm+tsnXVco5Qd4dNuUdqs871ZYj7WQYopZkEY4tn/O9UQm
         ZvXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692371939; x=1692976739;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hgbLHehGpwVrKSLju1qpBYPuFYa1Zpgs9RdgH+2tDII=;
        b=CKi7fvZlJNewNzKkdPNxJxiAViY0GR317KVCx+H+GKobtnB4qzCALOoSa97AJi8z8r
         JxwBnIt+/Iavst8iy1/vKRvH+ZCf/ed7qLqJxr0qCn/YDvAV52qKZVtk+STX+7pEp3cc
         wfUOSt3Kz6wHDMJiUT0qEoTK3ch/M3uJ7hu3nkAmMtKuLoiSFMtGYfWAUpmW+rzkTeKA
         rjwN/EGiKECPN+OWJ3+qFZHcIPx19TEsmYP2QMK9VZPQXGZ6WdAGjiXigWlJLa20kI08
         HGuc//a7w1CEl7aXm55o6O7bVpjJJXUYZ0x7B2pgbYQBIdOCT4ptEkDJU/qlWCgrxg6R
         ZF6Q==
X-Gm-Message-State: AOJu0YyyWwUNyFB+UETPFLLUxIrf3lSZXJea2v2azAx4vu4rDLV6CQw0
        tfdUxJgKbLiJm2rtfEgQBNeKNeFh9TAwgdcI5QX8
X-Google-Smtp-Source: AGHT+IH/VrHw4mYIGTcJdOBgtqJqiIVp3ULtA4k5KI3iTcBlMWJ/JvZbsEmH3Cr9BShSwCZI+lDHYCr+dkWLtvSdbXQ=
X-Received: by 2002:a0d:d6d2:0:b0:573:527b:747b with SMTP id
 y201-20020a0dd6d2000000b00573527b747bmr3094498ywd.36.1692371938879; Fri, 18
 Aug 2023 08:18:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230817203501.never.279-kees@kernel.org>
In-Reply-To: <20230817203501.never.279-kees@kernel.org>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 18 Aug 2023 11:18:48 -0400
Message-ID: <CAHC9VhRmy=8iWkKcQQmninxNRYqWrR3tTSj4XDvJhZZO0PsA3w@mail.gmail.com>
Subject: Re: [PATCH] audit: Annotate struct audit_chunk with __counted_by
To:     Kees Cook <keescook@chromium.org>
Cc:     Eric Paris <eparis@redhat.com>, audit@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 17, 2023 at 4:35=E2=80=AFPM Kees Cook <keescook@chromium.org> w=
rote:
>
> Prepare for the coming implementation by GCC and Clang of the __counted_b=
y
> attribute. Flexible array members annotated with __counted_by can have
> their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUND=
S
> (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
> functions).
>
> As found with Coccinelle[1], add __counted_by for struct audit_chunk.
>
> [1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/c=
ounted_by.cocci
>
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: Eric Paris <eparis@redhat.com>
> Cc: audit@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  kernel/audit_tree.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

This looks good to me, but considering we are currently at -rc6 I'd
prefer to hold off until after the upcoming merge window.  I'll send
another note once it's been merged into audit/next.

Thanks.

> diff --git a/kernel/audit_tree.c b/kernel/audit_tree.c
> index e867c17d3f84..85a5b306733b 100644
> --- a/kernel/audit_tree.c
> +++ b/kernel/audit_tree.c
> @@ -34,7 +34,7 @@ struct audit_chunk {
>                 struct list_head list;
>                 struct audit_tree *owner;
>                 unsigned index;         /* index; upper bit indicates 'wi=
ll prune' */
> -       } owners[];
> +       } owners[] __counted_by(count);
>  };
>
>  struct audit_tree_mark {
> --
> 2.34.1

--=20
paul-moore.com
