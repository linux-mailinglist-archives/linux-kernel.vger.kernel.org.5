Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22B1B7A4E30
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 18:08:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbjIRQIa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 12:08:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbjIRQIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 12:08:09 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFE9518C
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 09:06:16 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id d75a77b69052e-41215efeb1aso30560951cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 09:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695053176; x=1695657976; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=npyytzb/8fGfFOzFWav6JIpKQnixl0/mUAWigmTXJoE=;
        b=KER+sb53uKOLf9hVKWXR3A6+wLTGwA3dJryEkYbj4mUmUJolfVJ/65dbpU+gqfS2d/
         vAqaOcTEq+uwydtWtaTfeUhvx3ad1O03Tsa0bHmWw6H+uWUe0f51KZT/caB0SNX9+EA7
         nhkuQNwFT1ATwMDVR2IGWBNd+iHusLvpUQ7BpJzzOJ7wH0L0cI2PwXrcAnFGw1DmBT0b
         0YJeyORXR0ZOzo4j3VIO2tvzrG0fff28GGSyr3sXRRK3diflEa4ITBBltBWexjq3qAIB
         FE+YCffC0yBEJgUb6JDVxAgAFVwyvzulMKXXtcnZRYSJB0h1SK86Cq22PKfbtT9fZfAE
         bMlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695053176; x=1695657976;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=npyytzb/8fGfFOzFWav6JIpKQnixl0/mUAWigmTXJoE=;
        b=E6ybKnWcT0tVl3GPaKDjtPxJp7P2phUdiu3S1M10VwjILu1+KTynzWO3XAbaI77OpJ
         tpo63rFt4CgMMXTIk3ADTwP5WFq+f5/cmjcEOUKvKKqdTGj9G2rpcc9rlVxQEVqonVbd
         JA1IIcv1lk4003A7Sfih7SAGwP2HMo1B/ZaaNU7WDUm76ve9Q96SLtSPhD6OQncojEvZ
         2UmhOK7axfZ2xIdcMKqutqZ5sUDS7agC74/LPILdCunIQ6k8Zb+sjmi6z5vZPUheOkWX
         4Hd9cKwvGMrkEebbQpop+aJ7lSP6NmgGReMdTAPZ/z6LBBec+HxfiO30ZYmsoQo+N8a4
         rlBQ==
X-Gm-Message-State: AOJu0Ywq+haGmKXxc6b7+WgHpEirbafWritPi78+kkKu2W94kuVvBaZl
        nWcquxZQHYdBbX+NEM5Hgxy9sGJ1sPIcNqzlcZYhIJnXHyyB+mkEemw=
X-Google-Smtp-Source: AGHT+IHPaIO4FZQQUgcCagLrdno/prKFPjefmt9O/XHrjrH4UUIZ2xFroktRxa6d4bksnAf1hANZGczmFQi2ZOdIueE=
X-Received: by 2002:a0c:f547:0:b0:63c:fbd0:6361 with SMTP id
 p7-20020a0cf547000000b0063cfbd06361mr9120163qvm.37.1695052283895; Mon, 18 Sep
 2023 08:51:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230914131225.13415-1-will@kernel.org> <20230914131225.13415-2-will@kernel.org>
In-Reply-To: <20230914131225.13415-2-will@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 18 Sep 2023 08:51:13 -0700
Message-ID: <CAKwvOdmJa5WFLw=YZWAEu=o+3dkUgVNrwNWDZLC=k2Be=Bcy3Q@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] scripts/faddr2line: Don't filter out non-function
 symbols from readelf
To:     Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        John Stultz <jstultz@google.com>, linux-kbuild@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 14, 2023 at 6:12=E2=80=AFAM Will Deacon <will@kernel.org> wrote=
:
>
> As Josh points out in 20230724234734.zy67gm674vl3p3wv@treble:

Perhaps a suggested-by tag would be appropriate then? Next time.

>
> > Problem is, I think the kernel's symbol printing code prints the
> > nearest kallsyms symbol, and there are some valid non-FUNC code
> > symbols.  For example, syscall_return_via_sysret.
>
> so we shouldn't be considering only 'FUNC'-type symbols in the output
> from readelf.
>
> Drop the function symbol type filtering from the faddr2line outer loop.
>
> Cc: Josh Poimboeuf <jpoimboe@kernel.org>
> Cc: John Stultz <jstultz@google.com>
> Link: https://lore.kernel.org/r/20230724234734.zy67gm674vl3p3wv@treble
> Signed-off-by: Will Deacon <will@kernel.org>

LGTM; thanks for the patch!
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>  scripts/faddr2line | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/scripts/faddr2line b/scripts/faddr2line
> index 0e73aca4f908..a35a420d0f26 100755
> --- a/scripts/faddr2line
> +++ b/scripts/faddr2line
> @@ -260,7 +260,7 @@ __faddr2line() {
>
>                 DONE=3D1
>
> -       done < <(${READELF} --symbols --wide $objfile | sed 's/\[.*\]//' =
| ${AWK} -v fn=3D$sym_name '$4 =3D=3D "FUNC" && $8 =3D=3D fn')
> +       done < <(${READELF} --symbols --wide $objfile | sed 's/\[.*\]//' =
| ${AWK} -v fn=3D$sym_name '$8 =3D=3D fn')
>  }
>
>  [[ $# -lt 2 ]] && usage
> --
> 2.42.0.283.g2d96d420d3-goog
>


--=20
Thanks,
~Nick Desaulniers
