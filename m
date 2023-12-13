Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61E19811D18
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 19:43:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233557AbjLMSn2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 13:43:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbjLMSn1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 13:43:27 -0500
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E66CFBD;
        Wed, 13 Dec 2023 10:43:33 -0800 (PST)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-5e309941f46so6509167b3.3;
        Wed, 13 Dec 2023 10:43:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702493013; x=1703097813; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Py7pGp8pdHDiaozPkIU0AHzFq8SxGOJ+oThpJ6qUk8=;
        b=TCsoDXmjafpgTI7Dp36Z9MC4UU8R/1Qw9iIoo+8ZoUeQsOyyqFQWZilKs+FMwsFIH/
         9i1JjOKAy4S0q/R1dlXxDCZJlVVCWoe+nA4cyILEYKV2hUf6MrYohHEowTrtzmlltWj6
         NaSvgqDNVsVVTQ54zHE7XP8SpfK1U215WHxBG6/XemML6PtTbfwpRg7LfONwwI9MXv53
         YukPwv2YvtnSgwsIzSceaPpubK0xXUaU4d8ZClluSyZg5bB3NtS69iz6F9f04VYfGpIm
         slIqwUdLP7rGkmqqfCbC0d50dIwJqZuwVioo24ihwh4r5UPB5n+PqhpuspCQCDbgBuLu
         TMgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702493013; x=1703097813;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/Py7pGp8pdHDiaozPkIU0AHzFq8SxGOJ+oThpJ6qUk8=;
        b=JuVZsFuZMevMP/CkNmzG6kR8KwXiGBG30ji3nh7LXNBe72IFn7QRV8eWRQSqNlS7sj
         Boc5zrEtZLjOFCsTvGs2b4DXiM+QLAcVChWAQ+lyqkSTaHzz25s4GpGb4YFLrkjcnOJB
         P7frBq4n5jPulSUxGELGyYWJMvqNAa4DaFVorMAMpUbdLzPcAuGq77VBnc/4NrX4ngVO
         f6MOstT6mEhR7IbzV3fhmE2GHzfHtPHsBds3jtNO3MDzD54lGUXbecpSkdC6v8mHf5Iz
         8y6dchP673AHzUXvhRY6It7XinTCe6UcdC5KLz0DrrguyoPE+Lhn3G7zAaXzrCejReUj
         I42g==
X-Gm-Message-State: AOJu0Ywe4EmrcrCwjBBfbHk8ihZq2L40n8DV+CJkFjPAbwBwJ3Xp/aaU
        EnNfomtlR9MApvxu7sdkE42wBhHtDWXGaqTQtOI=
X-Google-Smtp-Source: AGHT+IFB4zWxh1M3w3CvBzyO4rpXYYmJgL1IXBNWAJoRVWom5OIFB/LGcpzZKJ1btMxOVZajc1S1A+iIyRqn5nNfjNY=
X-Received: by 2002:a0d:dc83:0:b0:5d3:9fcb:b699 with SMTP id
 f125-20020a0ddc83000000b005d39fcbb699mr7277271ywe.49.1702493013147; Wed, 13
 Dec 2023 10:43:33 -0800 (PST)
MIME-Version: 1.0
References: <20230714-cstring-debug-v1-1-4e7c3018dd4f@asahilina.net>
In-Reply-To: <20230714-cstring-debug-v1-1-4e7c3018dd4f@asahilina.net>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Wed, 13 Dec 2023 19:43:21 +0100
Message-ID: <CANiq72n0OiZ8_Ot8-PxU2rV8k+qrAdk_6tvCiWDMMVr7R7nbsg@mail.gmail.com>
Subject: Re: [PATCH] rust: kernel: str: Implement Debug for CString
To:     Asahi Lina <lina@asahilina.net>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        asahi@lists.linux.dev
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

On Fri, Jul 14, 2023 at 11:19=E2=80=AFAM Asahi Lina <lina@asahilina.net> wr=
ote:
>
> Trivial implementation.
>
> Signed-off-by: Asahi Lina <lina@asahilina.net>

Applied to `rust-next` with the commit message from Alice.

Thanks everyone!

Cheers,
Miguel
