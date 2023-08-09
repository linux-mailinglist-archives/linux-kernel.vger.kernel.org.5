Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11B76776CB9
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 01:21:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231178AbjHIXVt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 19:21:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230489AbjHIXVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 19:21:47 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B3D3E76;
        Wed,  9 Aug 2023 16:21:45 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id 3f1490d57ef6-d6041e9e7d6so310286276.1;
        Wed, 09 Aug 2023 16:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691623304; x=1692228104;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fqPhSKEhAxdN896thpE1jEBzRUIXHDDDcmy8dPclHgc=;
        b=YHpB1fM+/bsbFkErDhR9Q+L2r87uw9nADj/lA80maywU1ipSwvMdW0Y0k1MCBNT0hU
         Vcz1rrWGKw3PjIpf4qV0ai/27TeZvPzJbtIb8n+ejunzudwHGBQMUFBkyjLhI9puH4YV
         qYi2zuumU9X/ooIlMOY8S9mcC77Pkoq7e5V3U9oPBRzZdf70LGHwbDUhErClH/icDwhO
         FKeBG5KGrsCnWmfWpGOnDP0lO+bQD7ClaCs39ciIEPsFJUtMe3waiZZPjPoVUyHvEQy/
         bPQ9v/gyWCWnx7W2mASY8M1gVNnov8hT19t/o/c/rONc+5bl166nnwnG1eN/s3wJ1pvZ
         pJGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691623304; x=1692228104;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fqPhSKEhAxdN896thpE1jEBzRUIXHDDDcmy8dPclHgc=;
        b=PMtfr52cWe/ap6Y68VCDwJunVPvL4Mj0dKQB0AJykRFGtL7VsYYG1F5b+PkG9jRPEr
         ACVy790RUqhNPMov7VgaM2OgQZzjKPpzQJK2F2/+q7jimtJIPC3xZZW0L2hPY64ioo0W
         Mw0hn3UTn3JsM4ziS7m9S7ydhMqv9C95XR0iAeDTA4B/bIL23dWlY6M8MhOXQEGrqYDB
         XnGtPeIx5wbwvAClsbC4zhnV+uoKGWsBPQZl3ZLEVhMgh8vjqUaNPTvKC6Z3jDG1JfiM
         IejFVwEAG/QxBnZk0YOtldgHTP+ZBkNzC4UTx+BAvDTA/tgiNtdaw7w2/sZKsuk4ZffM
         gmlQ==
X-Gm-Message-State: AOJu0YyGeUDv/8YqllglgRatqqCjnECMRirJP9tpD0sePd6LeWqOySUe
        hfLywspHBVzE04/uVb6AffGzEtqc4SfkNDguNmQ=
X-Google-Smtp-Source: AGHT+IFiyMa/iQ1NyMHGBxBvqSHp3vWMNVT0jkD4qUeKJs5plCuf861SCUO02G9gJm5D36GYtwWy6fs21qFzqzMa7bk=
X-Received: by 2002:a25:d206:0:b0:d1c:bb1d:238a with SMTP id
 j6-20020a25d206000000b00d1cbb1d238amr965837ybg.52.1691623304316; Wed, 09 Aug
 2023 16:21:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230614115328.2825961-1-aliceryhl@google.com>
In-Reply-To: <20230614115328.2825961-1-aliceryhl@google.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Thu, 10 Aug 2023 01:21:33 +0200
Message-ID: <CANiq72kVzySOqeWpK0+wn3gn-wOHUhm0TcSxdsr71eFsN3bnnA@mail.gmail.com>
Subject: Re: [PATCH] rust: make `UnsafeCell` the outer type in `Opaque`
To:     Alice Ryhl <aliceryhl@google.com>
Cc:     rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev
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

On Wed, Jun 14, 2023 at 1:53=E2=80=AFPM Alice Ryhl <aliceryhl@google.com> w=
rote:
>
> When combining `UnsafeCell` with `MaybeUninit`, it is idiomatic to use
> `UnsafeCell` as the outer type. Intuitively, this is because a
> `MaybeUninit<T>` might not contain a `T`, but we always want the effect
> of the `UnsafeCell`, even if the inner value is uninitialized.
>
> Now, strictly speaking, this doesn't really make a difference. The
> compiler will always apply the `UnsafeCell` effect even if the inner
> value is uninitialized. But I think we should follow the convention
> here.
>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

Applied to `rust-next`, thanks everyone!

Cheers,
Miguel
