Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E0AB7BF1FD
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 06:39:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442101AbjJJEj1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 00:39:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbjJJEjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 00:39:25 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B297F9F
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 21:39:24 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-53b32dca0bfso7824435a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 21:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696912763; x=1697517563; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DhBslu3mHH7RMNsvj83Co5qN3UaAAd8mZnnm83NxaaU=;
        b=in9qbDv7qRNSUvFK9xVfLxoM0OtfctlsxvgpdkufNifd/M+IF1CW9A0qlD/WE0Kigl
         JIU/MvEmZVjB8RwNl9iq8lPQNujZ2Sff8FtBW9bNXVMAc8w2t4K6ewC7Xx36wKV4Ocmz
         Snz2mpm89z4Eax7UPYjMjN7o4p7ESqg+td29CPP2b7nfSxpX6qXyEpWeR1CUGrm0hbS6
         +Gj3AwKqukZpBxhOkAij5J/0OyvQQdDrdSmEuabmf3NGvegu1nJEa2Y4qamrWSzDr8LX
         DZLtBIT1jUDTPfJtWrtr2KJ36m61ofHpDdv+TzJcD+tWflYbkHhNq//SoCB+FvxQ/XHd
         V/VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696912763; x=1697517563;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DhBslu3mHH7RMNsvj83Co5qN3UaAAd8mZnnm83NxaaU=;
        b=Tl/2cyGKvUkFdGfK0FbpOduQFwIEVNZr03I7ZIeid9hfNtV6VQs3Kjp29TebL1KEOY
         yP3k9DbhhY8XDW8kY3IQ0We2S98pxjfg2hmTZNQD3d9N0UFIAirEI5FLEglaaI+cJKbq
         8eTRw+GQ5DpPDP4IondPFepKz8IsdPNXIaWDgNgDUX5vDo4hROtJGiMrORqSlTn/UyBM
         PZgxaPov1BTOiBADW2y6Py6ijydnWAQtKoN6phdHZVxS9QPbI6QGZxvWfPEjjvUdX8ih
         kWZZ38U12/1CT/Y0vdeDXHo2j6BsP8FL0rgjimhOxMYANFrihlgzM98Jy7mmwJKs7V+6
         PPKg==
X-Gm-Message-State: AOJu0YyvI2sJvueBnqM4iC0KNegrNolGjUrFRS2+oqMxJY3m6uNgrtTq
        gMqYfNmBuy0GTeo/r1/cq4x2qpLcXVqX84ddKmc=
X-Google-Smtp-Source: AGHT+IEduK8JBONF4IJe1YUv3pZ0VKUgz9vZLJXZanNxjQjL60rtfv5yPmcqHyHiTaPBHGFd/GDkWG6wDB0nJwNh1Ek=
X-Received: by 2002:a05:6402:278c:b0:51e:5bd5:fe7e with SMTP id
 b12-20020a056402278c00b0051e5bd5fe7emr12704718ede.17.1696912762994; Mon, 09
 Oct 2023 21:39:22 -0700 (PDT)
MIME-Version: 1.0
References: <20231009203132.82773-1-ubizjak@gmail.com>
In-Reply-To: <20231009203132.82773-1-ubizjak@gmail.com>
From:   Uros Bizjak <ubizjak@gmail.com>
Date:   Tue, 10 Oct 2023 06:39:11 +0200
Message-ID: <CAFULd4badg6edcqk_F2zO++6pFVUrshN8Agf1+Lz90G0_J_-Hg@mail.gmail.com>
Subject: Re: [PATCH tip] x86/percpu: Use C for arch_raw_cpu_ptr()
To:     x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     Nadav Amit <namit@vmware.com>, Andy Lutomirski <luto@kernel.org>,
        Brian Gerst <brgerst@gmail.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 9, 2023 at 10:31=E2=80=AFPM Uros Bizjak <ubizjak@gmail.com> wro=
te:
>
> Implementing arch_raw_cpu_ptr() in C, allows the compiler to perform
> better optimizations, such as setting an appropriate base to compute
> the address instead of an add instruction.

Oops, please disregard this patch. It is a previous version, and now
will fail compilation with KASAN. The new arch_raw_cpu_ptr should
depend on CONFIG_USE_X86_SEG_SUPPORT, not CONFIG_CC_HAS_NAMED_AS.

I will send a v2 after some more testing.

Uros.
