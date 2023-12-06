Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC29F8079D2
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 21:52:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442908AbjLFUwb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 15:52:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379478AbjLFUwa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 15:52:30 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94358193
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 12:52:36 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-54744e66d27so3313a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 12:52:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701895955; x=1702500755; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wc+U1ZZjYhJUaholik0HYdU4QVswqDd86cBUF35MTLo=;
        b=cIn2uHplDIhQYlTgZSXZIv7lHpV9j7NG6fMfTKRy+Jdlqb8yK+9hQjY7pUSfaKrSsS
         HfkuzfeFfQEEG6gED82FKFMDEIaVRWAQVk4sqDxXq44yic6Sq0UZfvyNQxoBkQlIH9E5
         Lpouo9qAiH4O0srQNRKJzNoQn2YcVZS4cg+IHYvMJiTFiSmNUkS4FNrhW4iaP1OywZDv
         ZTh6EYQt7uPKV1kKv1NL9R5nDybVWhjv3DvGMMM4Mkm0c7kC/EOA/7fZFeh9uwYMbOV5
         KOI6FOPa6ajR0eRO9VbpJ7xZXCi27tT/DhK2ol+rE75iyapHYQvqjCeyWNfeXYVnbBmV
         /0ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701895955; x=1702500755;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wc+U1ZZjYhJUaholik0HYdU4QVswqDd86cBUF35MTLo=;
        b=aBCLrdIadXnfF20BpucUVVGuyKgb8NOy7dhHu5yKdGDIOWNDMIS3Or4dB3Q6dS7RjU
         Tegmpiv39sol/PCV3ouAh3J8XqMsLqxPPm0NCDQWXqn3ffR8QqRcBMXSQhhmbjChzDiE
         ZPnhoSpIaJM2YGUyEkGfos2/ABflP9tEpxQiuifVBTOv6NixKwqrTPVIvVvjAtHW5AH2
         fOHJjKs/owY3I5qsRZGb1wrcCw4ul5ieE94iRU+0bKmYjGMQ7ol8yaKzZHBJRmhCLM0H
         +LLrsZFDTnx2Mpns8xGqY9f6mg51en9IJMhB2qXvjG8Q3ZtweT1dUvM9/2SbcUTrFJSb
         LTVA==
X-Gm-Message-State: AOJu0YydP1ocaKG+WTvxRyBjxIb5oQrKC2oWc0D9SLxF7tHCovN91Xdq
        KG2efFCTSMw1tJtXRmsKU5IzDvGw1JnHjxyc5+KKGE3oKSE3sAZqtEqU6ltu
X-Google-Smtp-Source: AGHT+IGtA3bnHvsfbkhSBuFL3L5tA5vDIE/p2HJVerg2kXcpu/i9D0h24oyvWWOTepK4bTrNrg6CT3uixKmr65ClDvo=
X-Received: by 2002:a50:c35d:0:b0:54a:ee8b:7a8c with SMTP id
 q29-20020a50c35d000000b0054aee8b7a8cmr154930edb.0.1701895954732; Wed, 06 Dec
 2023 12:52:34 -0800 (PST)
MIME-Version: 1.0
References: <20231206172844.1756871-1-jannh@google.com> <20231206195814.GDZXDSVgtCWspEJx8Q@fat_crate.local>
 <CAG48ez3weAU-Uti0QyBSDNRv8xYqCJ5UbgJvssEWAWpvyon0DA@mail.gmail.com> <20231206203158.GEZXDaPslvxtOS/gze@fat_crate.local>
In-Reply-To: <20231206203158.GEZXDaPslvxtOS/gze@fat_crate.local>
From:   Jann Horn <jannh@google.com>
Date:   Wed, 6 Dec 2023 21:51:58 +0100
Message-ID: <CAG48ez3FwbqaU+hP6cAZEGWdHDJdEMuDyqW7SiYrDFf+rOt=bA@mail.gmail.com>
Subject: Re: [PATCH] x86/microcode: Be more verbose, especially about loading errors
To:     Borislav Petkov <bp@alien8.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
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

On Wed, Dec 6, 2023 at 9:32=E2=80=AFPM Borislav Petkov <bp@alien8.de> wrote=
:
>
> On Wed, Dec 06, 2023 at 09:23:48PM +0100, Jann Horn wrote:
> > Well, yes, except that if no microcode blob is loaded, you're not
> > gonna have the errata fixes and/or security mitigations that you might
> > expect to have.
>
> We say that too:
>
> microcode: Current revision: 0x000000f0
> microcode: Updated early from: 0x000000be
>
> That second line would be missing.

Ah, right. I guess that's decent for diagnostics, though I think it
would be nice to have a more explicit message about not finding a
microcode update, since otherwise you'd have to read the kernel
sources to figure out that you have to check for a missing second
line.

> Therefore, the mitigation fixes all report that too. Look for
> "[Mm]icrocode" in the mitigation strings in arch/x86/kernel/cpu/bugs.c.

Yeah, fair, I guess that's a fairly visible indicator that something's
wrong with microcode. (Though it doesn't tell you whether your
microcode is just outdated or you have no microcode for the CPU
family.)

Well, I don't really feel particularly attached to this patch.
