Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5467D8113FE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 15:02:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378995AbjLMOCK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 09:02:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235430AbjLMOB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 09:01:58 -0500
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DD5D1B1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 06:02:00 -0800 (PST)
Received: by mail-qv1-xf32.google.com with SMTP id 6a1803df08f44-67a91751ba8so41727196d6.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 06:02:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702476119; x=1703080919; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t+EwRk4ihEWZ1GfrXn6PM8sUev4WliEA8COuJ0yCh2I=;
        b=UlMJ6ciAmEVKyoI5W1wnEbde2KHVfh6SCyiXVVF7eadkr0CqrvjxMS9hInua1hSjx9
         RgOYln1hi7i7JiwzknvJYtdPzGWfIv20ckQOj1igaVKkFpqp/Iuy+rlqMwD/IG7jT4VB
         4gbNHw7hf3Ou2/T6sAQnaOAbFOaM4T70JuKs3GJ70+EZWD01DkKWYJ+QsG7vuGKogWJ1
         PJNbsQWU9plUiGiAhFkJV51WIrgqKn9bGThNmtqRFDAdgliSfE7kAfZ1nHYoqYZEH/dq
         H5iKdDNlwnohzgopYZfCRepYtM3OyAamuu4ZyMQGujagSxM3Qiu6K1iLE5HnLUX28cPT
         H0vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702476119; x=1703080919;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t+EwRk4ihEWZ1GfrXn6PM8sUev4WliEA8COuJ0yCh2I=;
        b=vYLH2JdPGykQnpfmzbn/WTieHo0Ve3G6q+y7jVkUSyfs0/x6q4/6AZiGF++kA6qG8Z
         cs8gaTEtfQKhgcR1OXgmoxVOKuM4Q3DohuGRqAZgNK/l5LSyT/2owPSxumv+5EapjxQ0
         QDa3/2GCzOUpu+Gtn5lSGN5W8yUaYk8L93/LnyVX2BIVCJF0bNURMswSwvWGSS2xdvR6
         GESrrnfe9NtlwpwfxF2HNrXUmev6BWwkV9CZr+MbpSnWNcagnZ5Mv4nCh3pLPYwZ0LTN
         1hvN2W2fStyizG0XgbQAoSNNXdmfWAdF5DngbcC42y7/34jk6s8y7+K8DDwVL0MiztCM
         fX0g==
X-Gm-Message-State: AOJu0YzZAkQ2TPgsAvPYWG3R3ry3SBi1AMEVGGSsnDdEQ/BuxcCaxFyA
        r7qBCmXvuyarlBMq1UskljJG1lbmWEA151Dwy/03vA==
X-Google-Smtp-Source: AGHT+IFMaR6HB4FuIAAB/VNgdDk9QKgcJ5hjeArwb2+ldoTK3/4RQV7DvME7UlkrABg/5w2DMTe14vqBHBSyZYiPN3k=
X-Received: by 2002:ad4:45b1:0:b0:67e:dbf3:a4ba with SMTP id
 y17-20020ad445b1000000b0067edbf3a4bamr4342070qvu.89.1702476119250; Wed, 13
 Dec 2023 06:01:59 -0800 (PST)
MIME-Version: 1.0
References: <20231113105234.32058-1-glider@google.com> <20231213123130.GC31326@willie-the-truck>
In-Reply-To: <20231213123130.GC31326@willie-the-truck>
From:   Alexander Potapenko <glider@google.com>
Date:   Wed, 13 Dec 2023 15:01:17 +0100
Message-ID: <CAG_fn=WsYJmcABW3aXDyGrd04Sh2Hi7_2rReLc5xXPjQ4paScQ@mail.gmail.com>
Subject: Re: [PATCH v9 0/4] Implement MTE tag compression for swapped pages
To:     Will Deacon <will@kernel.org>
Cc:     catalin.marinas@arm.com, pcc@google.com, andreyknvl@gmail.com,
        andriy.shevchenko@linux.intel.com, aleksander.lobakin@intel.com,
        linux@rasmusvillemoes.dk, yury.norov@gmail.com,
        alexandru.elisei@arm.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, eugenis@google.com,
        syednwaris@gmail.com, william.gray@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 13, 2023 at 1:31=E2=80=AFPM Will Deacon <will@kernel.org> wrote=
:
>
> On Mon, Nov 13, 2023 at 11:52:29AM +0100, Alexander Potapenko wrote:
> > Currently, when MTE pages are swapped out, the tags are kept in the
> > memory, occupying PAGE_SIZE/32 bytes per page. This is especially
> > problematic for devices that use zram-backed in-memory swap, because
> > tags stored uncompressed in the heap effectively reduce the available
> > amount of swap memory.
> >
> > The RLE-based algorithm suggested by Evgenii Stepanov and implemented i=
n
> > this patch series is able to efficiently compress fixed-size tag buffer=
s,
> > resulting in practical compression ratio of 2x. In many cases it is
> > possible to store the compressed data in 63-bit Xarray values, resultin=
g
> > in no extra memory allocations.
> >
> > This patch series depends on "lib/bitmap: add bitmap_{read,write}()"
> > (https://lore.kernel.org/linux-arm-kernel/20231030153210.139512-1-glide=
r@google.com/T/)
> > that is mailed separately.
>
> That's a shame, because it means I can't apply the series as-is:
>

Uh-oh, sorry about that. There was another series depending on the
bitmap_read/bitmap_write API, and I thought mailing those patches
separately would speed things up.
But in fact Yury requested them to have at least one user, so now that
the MTE series is also acked I'd better bring everything back
together.
Let me send out another version.

>
> arch/arm64/mm/mtecomp.c: In function =E2=80=98mte_bitmap_write=E2=80=99:
> arch/arm64/mm/mtecomp.c:105:2: error: implicit declaration of function =
=E2=80=98bitmap_write=E2=80=99; did you mean =E2=80=98bitmap_free=E2=80=99?=
 [-Werror=3Dimplicit-function-declaration]
>   105 |  bitmap_write(bitmap, value, *pos, bits);
>       |  ^~~~~~~~~~~~
>       |  bitmap_free
> arch/arm64/mm/mtecomp.c: In function =E2=80=98mte_bitmap_read=E2=80=99:
> arch/arm64/mm/mtecomp.c:198:9: error: implicit declaration of function =
=E2=80=98bitmap_read=E2=80=99; did you mean =E2=80=98bitmap_remap=E2=80=99?=
 [-Werror=3Dimplicit-function-declaration]
>   198 |  return bitmap_read(bitmap, start, bits);
>       |         ^~~~~~~~~~~
>       |         bitmap_remap
> cc1: some warnings being treated as errors
> make[5]: *** [scripts/Makefile.build:243: arch/arm64/mm/mtecomp.o] Error =
1
>
>
> Do you really have such a hard dependency on those new bitmap ops?

Having them in bitmap.h seems natural - this way they can be reused by
other people.
