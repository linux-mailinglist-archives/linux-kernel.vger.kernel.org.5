Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8580C776C2B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 00:29:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231603AbjHIW3U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 18:29:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbjHIW3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 18:29:19 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1904DA;
        Wed,  9 Aug 2023 15:29:18 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id 3f1490d57ef6-bcb6dbc477eso272328276.1;
        Wed, 09 Aug 2023 15:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691620158; x=1692224958;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=md0QMIXJf01edhbs+yGhhB4W0Bd2+ymbTe85aAF+L0g=;
        b=i+QACLOkeS4nZ3g4o2ZoxhnSh4XeW2x5x1TnffvXS4FKlD0oRvNuRY8J1tn9v4CUPD
         Jge8jsRgj3IuO/u3RSQqruD6g4hi+QjWJ59CvRpUEaiXtKRjGRqeQcsx0fGzl15vKN/L
         QdvsTXiUlUF3xdoArCdL+NO6QiSh+od8guo1T53zHZe4qazVAg+L5r+9HoNzf3PTy92g
         KbxdZ3TQiCToA2DISz6qkYsGjElojMpvZKayjdJjfb/M10LBpclAXAVXwqgfN1v4/bf5
         jW6t/+vAHTaiXk3XK3Ebkw1ayFmfVHf2TkXeUu97iYv0siM4wuVq2Igg/mbcdtiTMIDc
         c6mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691620158; x=1692224958;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=md0QMIXJf01edhbs+yGhhB4W0Bd2+ymbTe85aAF+L0g=;
        b=a2wfzkWgq6eZoBOZw397Md+eThwuhx9P+zgIV8frQIgf+7Yto9BtI3CKLXp/L+22gH
         PvT4zXzi1SL2c7ve8v/p5gdWo4goOJdkS9i8OJ4N9pfO2zwYqmeA1dKB5Sw94ECv24TS
         y0iPJaNrxt0zMsNJom3tukQGCafyqwhDIuXxy7quvWoUwjO1ZbQcZH19fD/1dlHAzeiR
         6VIH5QAwltNKmzJl+KYUrXcSIhkJ0hkxd265O0JFlOcF2FSGCczonnSPdaabnGEC8rQR
         ktdLMSNuxSvEPBpajsphu4kqktq/GbVtHxlDjvZD7Ks4AEL1HN4ld7fcIgMrWVnU9KEF
         xoww==
X-Gm-Message-State: AOJu0YxXI/YH6RfmHn99t3pKHOEdy1i8t6QvjDlhP27dsBmnvZGdVN9s
        QJA2cYYkeH+XUKOYqaoZv3n724z3A/tVBP57PqI=
X-Google-Smtp-Source: AGHT+IHeVcjwRnGNxnabot0Y+GQyHu71bqtKVVmW+MicH8CJo+8BQ9/VfazrvSFuVWPoYegCMnUH3al+rUetvt90wjo=
X-Received: by 2002:a25:ab61:0:b0:ce8:4567:a382 with SMTP id
 u88-20020a25ab61000000b00ce84567a382mr886673ybi.1.1691620157888; Wed, 09 Aug
 2023 15:29:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230628171108.1150742-1-gary@garyguo.net> <CANiq72miVic=P+qSobuUqXoCuKW30_tT_buD8MyEsyVb_uoj6w@mail.gmail.com>
 <20230809230249.01ffc009.gary@garyguo.net>
In-Reply-To: <20230809230249.01ffc009.gary@garyguo.net>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Thu, 10 Aug 2023 00:29:06 +0200
Message-ID: <CANiq72nWArGsvWVVknPdAVYUbWqJKfwOAVCRUmLnuAHAHP+rSQ@mail.gmail.com>
Subject: Re: [PATCH] rust: macros: add `paste!` proc macro
To:     Gary Guo <gary@garyguo.net>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Alice Ryhl <aliceryhl@google.com>,
        linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
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

On Thu, Aug 10, 2023 at 12:02=E2=80=AFAM Gary Guo <gary@garyguo.net> wrote:
>
> Sorry I forgot to add license comments!

No problem at all :)

> All my kernel contributions are permissively licensed if possible, so I
> am fine with this being either MIT or GPL-2.0 (I think GPL-2.0 is
> deprecated in as a SPDX license identifier and it should be
> GPL-2.0-only going forward, though).

Yeah, the 3.0 version of the SPDX license list deprecated `GPL-2.0`,
but the kernel still allows `GPL-2.0` and lists it first. I recall
thinking about this before the initial merge, and I think I went with
the original form because the main `COPYING` file still uses that.
After that I am just keeping it consistent, though I am not sure when
the kernel will migrate.

> Given this is non-kernel specific generic code, I think it might worth
> following the convention of the paste and pin-init code and make it
> `Apache-2.0 OR MIT`? This would also make it the same license as the
> `paste` crate (although we don't have to keep the same license as this
> is a different implementation).
>
> I'll leave the final decision to you.

Since you prefer it and it makes sense that someone may want to use it
(`concat` and `expand`) elsewhere, let's go with that. I will add:

    // SPDX-License-Identifier: Apache-2.0 OR MIT

then. Thanks for the very quick reply!

Cheers,
Miguel
