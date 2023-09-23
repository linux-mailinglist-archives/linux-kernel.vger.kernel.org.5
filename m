Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 674847AC463
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 20:19:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232200AbjIWSTj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 14:19:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232116AbjIWSTh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 14:19:37 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 631D8127
        for <linux-kernel@vger.kernel.org>; Sat, 23 Sep 2023 11:19:30 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2c008042211so66376211fa.2
        for <linux-kernel@vger.kernel.org>; Sat, 23 Sep 2023 11:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1695493167; x=1696097967; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZHvsp74Err2zYK1OLHJlR5XcxNgb3U+TwUDTFKciRR0=;
        b=YAT6xNkP0H+18h/ccuHN2td1sNiTRZzgvkQzWIBFvCaYS4X5q4M3wW93oFpy0bUgkn
         68DoHXaI6UcA1WPEm1yfVZolCnfEPIXeeOkwrDk0KWmhe4vqOb6goe0FyyqA9RiapERO
         PMmZH3RiPHysy35buUN0wdxrKrtyYjO/PlKes=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695493167; x=1696097967;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZHvsp74Err2zYK1OLHJlR5XcxNgb3U+TwUDTFKciRR0=;
        b=iE2fptiuKeaOCHrTX6oJX5wGKY0UhORd92eYtsN3R39WQqK6uDj6Apm5U3sQOnsTHH
         Hk4nVlz+8pk1Bvq+SRWC3ndAhJCwPJ3dzF6lNqV4OzOQTKp05N8FWs7djfyW3E/udiy3
         wHm/7JhxKhPgAvV4gGbIMAmFLvq/RQNKLO6MT/8wzQP99Y1QaRjj1b2+sNbmmEH8rHit
         5oD8TANDstAfeiECR1aK8KzBgHfE20NmW5KHwrJHIyqHWFC1o3gsNS4Z5eQb3MKj39g2
         TnPM3FjX/SkPTpuRIi058ZK8i7b+jnfMX3X/psoytcp6AWIg71ItW5Xp1njpCpKsTmoU
         TXgQ==
X-Gm-Message-State: AOJu0YyIVH/5mTz58ciUW+VPxZlvwb+MTUh8gJFLmhXZ3S8ZUNLyiaDp
        zeEhX5RZyRQ3B9C0/j5bBCc48mvD3o6Ju6s2vYvewQ==
X-Google-Smtp-Source: AGHT+IGgmmuDKKHznKDawFNPGDPO/VB47iUOsqTDj99n+4FWsFT5jH02Egmfz7dhfpMCn8NTblcJsA==
X-Received: by 2002:a2e:7e04:0:b0:2b6:e105:6174 with SMTP id z4-20020a2e7e04000000b002b6e1056174mr1949371ljc.47.1695493167118;
        Sat, 23 Sep 2023 11:19:27 -0700 (PDT)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id va1-20020a17090711c100b00992ea405a79sm4160545ejb.166.2023.09.23.11.19.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 23 Sep 2023 11:19:26 -0700 (PDT)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5230a22cfd1so4584118a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 23 Sep 2023 11:19:25 -0700 (PDT)
X-Received: by 2002:aa7:c98b:0:b0:522:38cb:d8cb with SMTP id
 c11-20020aa7c98b000000b0052238cbd8cbmr2023816edt.20.1695493165617; Sat, 23
 Sep 2023 11:19:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230918145533.14642-1-brgl@bgdev.pl> <ZQhtWNaCiHVu5yzL@smile.fi.intel.com>
 <CAMRc=MfkzdFgwEuNGJYgxyCA_b__Ds-jA4S+jVT1ULJ9DTRhOw@mail.gmail.com> <ZQl8tkWnQcjtFBbQ@smile.fi.intel.com>
In-Reply-To: <ZQl8tkWnQcjtFBbQ@smile.fi.intel.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 23 Sep 2023 11:19:08 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgK+PimVukScvVjoqOdOWWG_e+xCurhP_9SvA_+7scYWw@mail.gmail.com>
Message-ID: <CAHk-=wgK+PimVukScvVjoqOdOWWG_e+xCurhP_9SvA_+7scYWw@mail.gmail.com>
Subject: Re: [PATCH v4] gpio: sim: fix an invalid __free() usage
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     brgl@bgdev.pl, Linus Walleij <linus.walleij@linaro.org>,
        Kent Gibson <warthog618@gmail.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        akpm@linux-foundation.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Sept 2023 at 03:49, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> Nope, k*alloc*() returns ZERO or NULL on failure. That's what most developers
> are missing :-)

Absolutely not.

k*alloc() returns NULL on failure. Absolutely nothing else.

On *success*, it can return the special ZERO_SIZE_PTR. But that is
*not* a failure at all. It's very much a successful pointer.

Now, it's a pointer that you can't actually dereference, but that's
very much intentional. You can't dereference it, because you asked for
a zero-sized allocation. You got a zero-sized allocation.

But please never *ever* think it's a failure. It's very much not a
failure case, and it is very much intentional.

It's different from NULL exactly *because* it's successful, and
exactly so that you can write

     ptr = kmalloc(size);
     if (!ptr)
          return -ENOMEM;

without having to worry about the "size is zero" case.

The standard user-space "malloc()" library is misdesigned. Surprise
surprise. The kernel isn't.

                Linus
