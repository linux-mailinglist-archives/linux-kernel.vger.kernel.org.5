Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13A7376880F
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 22:44:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbjG3UoB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 16:44:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbjG3Un5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 16:43:57 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A868010C0;
        Sun, 30 Jul 2023 13:43:55 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-583ae4818c8so44005377b3.3;
        Sun, 30 Jul 2023 13:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690749835; x=1691354635;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2aodzXpRHI/bS7yWyn8V5jZfavldcj/3Y/at9dgvqKc=;
        b=J0LH5189v+VQoh18mnc1fiUc4rgF3UC6iplLI7kl85Ep1TIvOuD8TVtXOmXVe0VUS8
         UKPga1SzVaptjyTJodO7qq9ePk2R22cHp2uu13Mrdn8qmQUnklFyYDNsbsKp2uDmbGCa
         Bbd9j8i6NkNgjZ7OqxNNn0UiGOXUNc+rdnxAiAPsVOh22/QFjr0ry45jQUTUG5KBhFl0
         jXzEMPLUDPwzIJWic5rV/7x6hHXz1gZWn2k/9souI5qwNwY3K+BxsFaPN2FeYkqHIn2B
         4kj5qr5xRvkhRMHkWe+WUeZt3O0Qb2U2oaH5VVPZNYUF6K3RfiVgF/HHogbao7KP1td6
         AZJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690749835; x=1691354635;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2aodzXpRHI/bS7yWyn8V5jZfavldcj/3Y/at9dgvqKc=;
        b=gkyCwdn5FxxaB/r65GjrgzRvWQZk+HZJMtdeKKeciop86XezTuSztN++juJ6/mL8Hm
         kfNG5Dvh+2ZgtNV/wDphHR5nzZYjB8R50rVfXkOP0C6IsBT2KfAvuYrnbTiHn5zTtF/z
         VYtTKq5iejMgZIB/UC3kF6dP76kaadZZnZgOq5LZUxo0KZAOuCTJj5ZfF9gBsJlHxTIG
         wQaAjrcDOBQFFI/6poDYQiFmAeRZEctUuYw+vxl2SX34CEua4wu9eNQKCA+N+zWv3wXA
         CFEJOF1g/uG4AUSaiMLjLjjEYzRvr5Xa0Q2xQYPh4WHnrFN9nN/x48QfzxD/9tDHESbb
         VAYA==
X-Gm-Message-State: ABy/qLZe41ZKHxVaAX0mpf7ffgWuPy3XZP99lV6yDTjlg4myqgFMdh7b
        Yt1qaYsfkgkN9y9rwkPrXD1yQYFCeiAINzjLjtA=
X-Google-Smtp-Source: APBJJlELqz4rIk0ONTX57WRyZ97exjjOdhECXSwlxGUOjsg0MFwyo9pJsPd/rsR+fvXfy3CbhtN65ylorV061oqVAXA=
X-Received: by 2002:a0d:e6c5:0:b0:583:af0a:267 with SMTP id
 p188-20020a0de6c5000000b00583af0a0267mr8900253ywe.5.1690749834884; Sun, 30
 Jul 2023 13:43:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230730012905.643822-1-boqun.feng@gmail.com> <20230730012905.643822-2-boqun.feng@gmail.com>
In-Reply-To: <20230730012905.643822-2-boqun.feng@gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sun, 30 Jul 2023 22:43:44 +0200
Message-ID: <CANiq72nf4N_HXOAZupM_Gq=c0jg-L__YUQtx4fSRpNuRqt4JAw@mail.gmail.com>
Subject: Re: [PATCH 1/3] rust: allocator: Prevent mis-aligned allocation
To:     Boqun Feng <boqun.feng@gmail.com>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        Benno Lossin <benno.lossin@proton.me>,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
        Alice Ryhl <aliceryhl@google.com>,
        Dariusz Sosnowski <dsosnowski@dsosnowski.pl>,
        Geoffrey Thomas <geofft@ldpreload.com>,
        Fox Chen <foxhlchen@gmail.com>,
        John Baublitz <john.m.baublitz@gmail.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Kees Cook <keescook@chromium.org>, stable@vger.kernel.org,
        Andreas Hindborg <nmi@metaspace.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 30, 2023 at 3:29=E2=80=AFAM Boqun Feng <boqun.feng@gmail.com> w=
rote:
>
> +// Note: Although these are *safe* functions, but they are only generate=
d at
> +// `GlobalAlloc` callsites, hence we assume the parameters obey the same
> +// `GlobalAlloc` function safety requirements: size and align should for=
m a
> +// valid layout, and size is greater than 0.

Thanks for adding all the `// SAFETY` comments here Boqun!

Bj=C3=B6rn, do they look good to you? (since you fixed the issue in the com=
piler)

On this comment in particular, "generated at `GlobalAlloc` callsites"
sounds a bit confusing to me. Would "... called by the compiler with
parameters that obey ..." make sense? Or does the sentence refer to
the normal case (i.e. when the functions are generated)? Anyway, it is
not a big deal.

Cheers,
Miguel
