Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A20FF7B400B
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 13:04:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234115AbjI3LES (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 07:04:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233237AbjI3LEP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 07:04:15 -0400
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 723C0CA;
        Sat, 30 Sep 2023 04:04:13 -0700 (PDT)
Received: by mail-vs1-xe32.google.com with SMTP id ada2fe7eead31-4526c6579afso1096302137.0;
        Sat, 30 Sep 2023 04:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696071852; x=1696676652; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fJo83pwx4y7gaRZ8bey8OSQgDQ8Tv3HF9f55YMBadbY=;
        b=aP39uq4xPESzyElD1xyo5SmtwAiJ1LP5/dqlMERS2bF7kLP/CTgoOYcUsR9EPFdmsZ
         n0Huf8YvLlUJ6K/y0QC2sntpMWXgTExpZ8AEMCpleaGqwR89LxkQVLLcNZG8hfxr2jQo
         N1SPm0CpvBcyk1pRCEfouwElfvgBnsQLsqbwMj17NHIMGXYNbCMSPVIVjUNmyIePiHS+
         U+nTQowuoxjha4hRQEqSftHLx9D3ynspzNc5BvsNZ2nAMUpcUNiJC7mE9zUOAJ8ausGv
         xIqqs5lDYKRqxjxPTR0Uca4SPlTNjtcDM8xAssurtN+8lRH7VCDMAMmt2FBK5bYn6lbo
         GkAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696071852; x=1696676652;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fJo83pwx4y7gaRZ8bey8OSQgDQ8Tv3HF9f55YMBadbY=;
        b=a7GlLy76iBo7tg+zuE5jaCFnmkO/FhFbPKLkrXYg9Dy3N9f+iYCA62zAXutPyx1zmw
         E/jWj1fOviPoZmZIMs9eLMgmbvtV91qGbmewbuzB5pkNjcxuv7Zy460mpvt1/fr4PyIr
         0BYVXXOEIqLGWkNXeovXuxvaRpWHGI+jI7oOxcps6Ht7UZUMJFUeipapBZAxQwrZAtmd
         kJbQg/60sHGygMFWHJUMccbJ9k7Wfuvs1tVyRrksV2rDdgUfxJPA6pUR4Bg9mNzvL1RJ
         5fVWvgYVXP7odKXpWToGI9HdW9DhRq4HPb1q0dHGDVniXbRalW/QXBT6KNKuMkU1HjWJ
         /h+g==
X-Gm-Message-State: AOJu0YzSbIBQKusMqRlqDEhyXGUu+DhLFzgaWOgO/tD+O1ANACLTDsnZ
        7zHj18KE+gnQSAaEneWTvdt+Zt30mA1iX92U/Jw=
X-Google-Smtp-Source: AGHT+IE2qF/n7ShtQDqO7HPLK5FDKy2SymdW2yn4PQByIVeeaU1qQHfQj8OmZG4uK+8n2mr3IzPZWyYWBbSRlWktX0A=
X-Received: by 2002:a05:6102:5587:b0:452:6cea:89b7 with SMTP id
 dc7-20020a056102558700b004526cea89b7mr3719924vsb.14.1696071852334; Sat, 30
 Sep 2023 04:04:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230915105933.495735-1-matteorizzo@google.com> <20230915105933.495735-2-matteorizzo@google.com>
In-Reply-To: <20230915105933.495735-2-matteorizzo@google.com>
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
Date:   Sat, 30 Sep 2023 20:04:00 +0900
Message-ID: <CAB=+i9RQiDWE6ignfKn2p+UiDF9W=jAuqsmYhHrO9h06+X-pKA@mail.gmail.com>
Subject: Re: [RFC PATCH 01/14] mm/slub: don't try to dereference invalid freepointers
To:     Matteo Rizzo <matteorizzo@google.com>
Cc:     cl@linux.com, penberg@kernel.org, rientjes@google.com,
        iamjoonsoo.kim@lge.com, akpm@linux-foundation.org, vbabka@suse.cz,
        roman.gushchin@linux.dev, keescook@chromium.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-mm@kvack.org, linux-hardening@vger.kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        corbet@lwn.net, luto@kernel.org, peterz@infradead.org,
        jannh@google.com, evn@google.com, poprdi@google.com,
        jordyzomer@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 15, 2023 at 7:59=E2=80=AFPM Matteo Rizzo <matteorizzo@google.co=
m> wrote:
>
> slab_free_freelist_hook tries to read a freelist pointer from the
> current object even when freeing a single object. This is invalid
> because single objects don't actually contain a freelist pointer when
> they're freed and the memory contains other data. This causes problems
> for checking the integrity of freelist in get_freepointer.
>
> Signed-off-by: Matteo Rizzo <matteorizzo@google.com>
> ---
>  mm/slub.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/mm/slub.c b/mm/slub.c
> index f7940048138c..a7dae207c2d2 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -1820,7 +1820,9 @@ static inline bool slab_free_freelist_hook(struct k=
mem_cache *s,
>
>         do {
>                 object =3D next;
> -               next =3D get_freepointer(s, object);
> +               /* Single objects don't actually contain a freepointer */
> +               if (object !=3D old_tail)
> +                       next =3D get_freepointer(s, object);
>
>                 /* If object's reuse doesn't have to be delayed */
>                 if (!slab_free_hook(s, object, slab_want_init_on_free(s))=
) {
> --
> 2.42.0.459.ge4e396fd5e-goog
>

Looks good to me,
Reviewed-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
