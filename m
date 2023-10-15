Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9E847C9B8A
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Oct 2023 22:35:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230339AbjJOUfn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 16:35:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbjJOUfl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 16:35:41 -0400
Received: from mail-ua1-x931.google.com (mail-ua1-x931.google.com [IPv6:2607:f8b0:4864:20::931])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3817CB7
        for <linux-kernel@vger.kernel.org>; Sun, 15 Oct 2023 13:35:38 -0700 (PDT)
Received: by mail-ua1-x931.google.com with SMTP id a1e0cc1a2514c-7b5fcf9c682so1762959241.2
        for <linux-kernel@vger.kernel.org>; Sun, 15 Oct 2023 13:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697402137; x=1698006937; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KUi6hE5CuO5LVhmusvTHYPNNPWcnkaNQ7utVUkV5A98=;
        b=MxqBHeP+N1BoEhDvnO38u9mSnfoMpXqoAUmXqf/6R1rgE+aTqjagNJ+KwwNCqWrec6
         wR7MyaVgd2b5+OKKNJEzHxmd7PgMgiQwEsJOwW6XljEkSvrxjC+DmkEGNSakQr1UDT3O
         MQ8EX8Oj0robLskDuUHZwS25lbOpzRBzU3tZIcdcYdtvOX8AnD2PugS75z9b7dl8/9st
         KCbzsb8/u1CZbowGXiScmGTl0RURpFT1DdOr5k4b51NO+R4uPDkXzZ6NMrFeuOGWuvYP
         qnIOdIFRX2idRyB+/RZHE1NhC/Y3P2KDquUsdThkRr8AxD0vkSSrgtHztkp/zWyeaES6
         HQ5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697402137; x=1698006937;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KUi6hE5CuO5LVhmusvTHYPNNPWcnkaNQ7utVUkV5A98=;
        b=P0YRxZhTJMNl4oLl+g8ZY4xJLLOAkJnqtTnn/q+xl58mkU7I7FlheEh7I0FDNwcinS
         UleTLl8N/RjnQPqpcNkSbWBrMS16Cbrd5TBWzSP86x9pvYjp5TRYEBCDzAO2yu5IsKoN
         YPT4bR6bYfZGLLKBOQGxyHxhpj0tdUufoyCT/AqaebuxMJJsFfdENBBg8C1GGV0StI+P
         bGSC8vx1aJQPhyFjepXz1DChDWoIs4iJ/LqBppzQr24//RzwvLDTwimybNkQ4dpAQ0YW
         1/EobSxuuPaTzaRYRYvc7iGDFsFZ1C+RJeexrRLmTQV8Y1UG6FefDoou4r5uKJ7cDYgG
         vvKA==
X-Gm-Message-State: AOJu0Ywsk/DwADE8NwIgTuHW5AUoBOOtqIRH6uPNky8eddmUqHlS97GE
        jrNxpKTZzluyergYfpSe6/g6YArtJnufogWssoQ=
X-Google-Smtp-Source: AGHT+IGiVHZoo9jCzLgrNbqZ2xyjmtoDGcfOALVQO5EkFYAX0IGctmDvW6JIjbXNSp66oasybQhjw0PFvA0UcV2vv14=
X-Received: by 2002:a67:e006:0:b0:457:c57c:ef13 with SMTP id
 c6-20020a67e006000000b00457c57cef13mr4889967vsl.31.1697402137240; Sun, 15 Oct
 2023 13:35:37 -0700 (PDT)
MIME-Version: 1.0
References: <20231015202650.85777-1-pedro.falcato@gmail.com>
In-Reply-To: <20231015202650.85777-1-pedro.falcato@gmail.com>
From:   Pedro Falcato <pedro.falcato@gmail.com>
Date:   Sun, 15 Oct 2023 21:35:26 +0100
Message-ID: <CAKbZUD01au=HoDe=yXSLtxJgYdivZccqqBfpmnmQ04R1Y1orvg@mail.gmail.com>
Subject: Re: [PATCH] mm: kmsan: Panic on failure to allocate early boot metadata
To:     kasan-dev@googlegroups.com, Alexander Potapenko <glider@google.com>
Cc:     Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 15, 2023 at 9:26=E2=80=AFPM Pedro Falcato <pedro.falcato@gmail.=
com> wrote:
>
> Given large enough allocations and a machine with low enough memory (i.e
> a default QEMU VM), it's entirely possible that
> kmsan_init_alloc_meta_for_range's shadow+origin allocation fails.

Ugh, forgot to run checkpatch.pl until it was too late :/

> Instead of eating a NULL deref kernel oops, check explicitly for memblock=
_alloc()

If there's no need for a v2, please wrap the above line and...

> failure and panic with a nice error message.
>
> Signed-off-by: Pedro Falcato <pedro.falcato@gmail.com>
> ---
>  mm/kmsan/shadow.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/mm/kmsan/shadow.c b/mm/kmsan/shadow.c
> index 87318f9170f..3dae3d9c0b3 100644
> --- a/mm/kmsan/shadow.c
> +++ b/mm/kmsan/shadow.c
> @@ -285,12 +285,18 @@ void __init kmsan_init_alloc_meta_for_range(void *s=
tart, void *end)
>         size =3D PAGE_ALIGN((u64)end - (u64)start);
>         shadow =3D memblock_alloc(size, PAGE_SIZE);
>         origin =3D memblock_alloc(size, PAGE_SIZE);
> +
> +       if (!shadow || !origin)
> +               panic("%s: Failed to allocate metadata memory for early b=
oot range "
> +                     "of size %llu",

unwrap this string like this:
    "%s: Failed to allocate metadata memory for early boot range of size %l=
lu",

Silly mistake...

--=20
Pedro
