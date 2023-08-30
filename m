Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69E6978DFAE
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:15:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242933AbjH3TMV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:12:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245053AbjH3OZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 10:25:02 -0400
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D977A132
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 07:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1693405498;
        bh=SAJ852dwJOFVNABFj7uHiWKS/atHcQIwsECyB7d1znc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc;
        b=Nx4p3rNN+N6CNu2n5GDBlIYBZ8fiLlVvDVj2BeDp24yOet/R0NXvwDv0FYgfVK26d
         Tz+/xKcX0ujHa4GwPSJnj1dbQSmUUd+tYuYlEPZbkIVR/fpMex9buASLrN6APCTthV
         xC8mEYsRc4deRyXGfdllAVFEyEcwHlRGUkImeuaP8lgysFa6H3+W9icQRjxunrHcTh
         /dV8r2Fo71cW7vST5S08+Kur8iL2HItOTbMwxH+Wx83NhhoCLD4BZs30jyuUPdl6Zd
         82y6cGuIQnAQPNYls1pSbXe4sqEkwriQo0CWUaYeShQBKtCrneyNgrdgFazxjUzXyv
         0z+Qf59pkwjsw==
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
        by gnuweeb.org (Postfix) with ESMTPSA id 5C28624B2B0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 21:24:58 +0700 (WIB)
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-500a398cda5so9028955e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 07:24:58 -0700 (PDT)
X-Gm-Message-State: AOJu0YyPwCuOmO846YennLNhgVl1OFSfIIEmyNX7RXJcoxMG1T0+HAkh
        TZP9Ksd6bSAkWyc0sHtIsptqcGSKsH7fG6pzYpc=
X-Google-Smtp-Source: AGHT+IFwyvEFmlcIBHrmZQn42+yIboqEIJDG4VYbfKktDwqPz1Jn9RP7oE8EChawUezFFdIIwfqn0RqmwhDh/I9taes=
X-Received: by 2002:a05:6512:3603:b0:4ff:834b:e01b with SMTP id
 f3-20020a056512360300b004ff834be01bmr1639153lfs.19.1693405496395; Wed, 30 Aug
 2023 07:24:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230830135726.1939997-1-ammarfaizi2@gnuweeb.org> <20230830135726.1939997-3-ammarfaizi2@gnuweeb.org>
In-Reply-To: <20230830135726.1939997-3-ammarfaizi2@gnuweeb.org>
From:   Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>
Date:   Wed, 30 Aug 2023 21:24:45 +0700
X-Gmail-Original-Message-ID: <CAOG64qNGdPjXHTvrpYxjizOYvMRaB9_2t2raw6DJ3kK852KUHg@mail.gmail.com>
Message-ID: <CAOG64qNGdPjXHTvrpYxjizOYvMRaB9_2t2raw6DJ3kK852KUHg@mail.gmail.com>
Subject: Re: [RFC PATCH v1 2/5] tools/nolibc: x86-64: Use `rep stosb` for `memset()`
To:     Ammar Faizi <ammarfaizi2@gnuweeb.org>
Cc:     Willy Tarreau <w@1wt.eu>,
        =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        Nicholas Rosenberg <inori@vnlx.org>,
        Michael William Jonathan <moe@gnuweeb.org>,
        "GNU/Weeb Mailing List" <gwml@vger.gnuweeb.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 30, 2023 at 8:57=E2=80=AFPM Ammar Faizi wrote:
>   00000000000010b1 <memset>:
>     10b1: 48 89 f0              mov    %rsi,%rax
>     10b4: 48 89 d1              mov    %rdx,%rcx
>     10b7: 48 89 fa              mov    %rdi,%rdx
>     10ba: f3 aa                 rep stos %al,%es:(%rdi)
>     10bc: 48 89 d0              mov    %rdx,%rax
>     10bf: c3                    ret

Just a small idea to shrink this more, "mov %rdi, %rdx" and "mov %rdx,
%rax" can be replaced with "push %rdi" and "pop %rax" (they are just a
byte). So we can save 4 bytes more.

0000000000001500 <memset>:
    1500: 48 89 f0     mov    %rsi,%rax
    1503: 48 89 d1     mov    %rdx,%rcx
    1506: 57           push   %rdi
    1507: f3 aa        rep stos %al,%es:(%rdi)
    1509: 58           pop    %rax
    150a: c3           ret

But I know you don't like it because it costs extra memory access.

-- Viro
