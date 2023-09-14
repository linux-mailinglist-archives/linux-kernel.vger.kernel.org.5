Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CA697A0F0E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 22:35:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbjINUfI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 16:35:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjINUfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 16:35:07 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0FCD19A6
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 13:35:02 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1bc0d39b52cso11919125ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 13:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694723702; x=1695328502; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RUZ4tKWNQQW/M0sqK1AFluw87RumzXnsJH+qNtjEDz0=;
        b=sqAe8VJdxqO7wolyV170SCy2crJiWjg3DF6yg4dJLPkKIR77AR8exHgYRHNWUJsdCL
         TRrKpr6JnLxpoDviwVR6q3IQyzqmiKOqlJ0wR7/qyq1gN6bZNhS+E6C8nPgVu3DFNCY9
         T/StOfcuxjsIcDR18FXvguZ55t+Pi1g30gzdBL+8DKqbx0AHEvi00i6Q7i5qszSt117M
         niOhMDseDETaPzb/FQCuorhfzuuWF0v3LEyyu7KzSq1Wp5IJLrCXVsRsMDP3f2KniIFU
         YiWOoThyZ/EO+tcedVpuAD0jB1oozMjchlKrqhGVFrhvUOnWhBOTb2rIA9mXVG3KQFJO
         Sleg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694723702; x=1695328502;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RUZ4tKWNQQW/M0sqK1AFluw87RumzXnsJH+qNtjEDz0=;
        b=Rb+Rnt8CMw+t3hgBtClQfkhTLACVA9CB1vqnAtRo+kwaE01pXv9RnK8n8bvsEWCdxS
         x8xwlRVxLmVunBlycmne1G4mg9q8HS1bYXxrLRAOF3sHrY5suLnGz3Ye54YjiMuWDWV0
         UOaA/iCIFlko3l49fXeJ6aZNmfIsYo1EVbQyEfNt1tCFNWbwZfXDFCrI7sEld/o4R2Ln
         yhp2x9Sob1dFq4wFJnzpeMuML/WTdXS4BIeC/1cikiiG8vPrUmzro7SRv982mhMFzgHK
         J5yOAFm2kAwPOI0sanexrnyAwQzi5cXwo61lCnNzo5xrHipFbw++4bqyHeORRgH/oao2
         fwpA==
X-Gm-Message-State: AOJu0YwcoAnzzqi7hjJRKIHD1nDW0QJpGCXHYLbGTROHbbej7SvNk+fK
        9yHFEYSGuBQYGS0lo3ewtqPy198vCFJDRyj7+aDGjFdw
X-Google-Smtp-Source: AGHT+IFOJYurVLTveCv5tcbwSznaQ3Y77VJdYi4b/nk55QYpjNA4y8dRl/UXfJkyqn2rnYbR9kkKMwrpX3nyJfCj+2c=
X-Received: by 2002:a17:902:c949:b0:1c3:ea60:73e2 with SMTP id
 i9-20020a170902c94900b001c3ea6073e2mr7674254pla.27.1694723702114; Thu, 14 Sep
 2023 13:35:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230914080833.50026-1-haibo.li@mediatek.com> <20230914112915.81f55863c0450195b4ed604a@linux-foundation.org>
In-Reply-To: <20230914112915.81f55863c0450195b4ed604a@linux-foundation.org>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Thu, 14 Sep 2023 22:34:51 +0200
Message-ID: <CA+fCnZemM-jJxX+=2W162NJkUC6aZXNJiVLa-=ia=L3CmE8ZTQ@mail.gmail.com>
Subject: Re: [PATCH] kasan:fix access invalid shadow address when input is illegal
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Haibo Li <haibo.li@mediatek.com>, linux-kernel@vger.kernel.org,
        xiaoming.yu@mediatek.com, Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, Jann Horn <jannh@google.com>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 14, 2023 at 8:29=E2=80=AFPM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
> > --- a/mm/kasan/kasan.h
> > +++ b/mm/kasan/kasan.h
> > @@ -304,8 +304,17 @@ static __always_inline bool addr_has_metadata(cons=
t void *addr)
> >  #ifdef __HAVE_ARCH_SHADOW_MAP
> >       return (kasan_mem_to_shadow((void *)addr) !=3D NULL);
> >  #else
> > -     return (kasan_reset_tag(addr) >=3D
> > -             kasan_shadow_to_mem((void *)KASAN_SHADOW_START));
> > +     u8 *shadow, shadow_val;
> > +
> > +     if (kasan_reset_tag(addr) <
> > +             kasan_shadow_to_mem((void *)KASAN_SHADOW_START))
> > +             return false;
> > +     /* use read with nofault to check whether the shadow is accessibl=
e */
> > +     shadow =3D kasan_mem_to_shadow((void *)addr);
> > +     __get_kernel_nofault(&shadow_val, shadow, u8, fault);
> > +     return true;
> > +fault:
> > +     return false;
> >  #endif
> >  }
>
> Are we able to identify a Fixes: target for this?
> 9d7b7dd946924de43021f57a8bee122ff0744d93 ("kasan: split out
> print_report from __kasan_report") altered the code but I expect the
> bug was present before that commit.
>
> Seems this bug has been there for over a year.  Can you suggest why it
> has been discovered after such a lengthy time?

Accessing unmapped memory with KASAN always led to a crash when
checking shadow memory. This was reported/discussed before. To improve
crash reporting for this case, Jann added kasan_non_canonical_hook and
Mark integrated it into arm64. But AFAIU, for some reason, it stopped
working.

Instead of this patch, we need to figure out why
kasan_non_canonical_hook stopped working and fix it.

This approach taken by this patch won't work for shadow checks added
by compiler instrumentation. It only covers explicitly checked
accesses, such as via memcpy, etc.
