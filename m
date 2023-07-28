Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8057F767728
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 22:41:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbjG1Ulo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 16:41:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbjG1Ull (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 16:41:41 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 663C7422B
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 13:41:40 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4fe11652b64so4465469e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 13:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1690576898; x=1691181698;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1o44kCiViu9poWK+pr269ZTRZv94Q/szYxEaIBZbPhc=;
        b=PWaHtGPoN5IQlEquCn4tZQ9Xaw8HZBNIeKlodAQFA9UjMmPbEx4Zvik+rmvi3Xl2z1
         Xbj/BWXP+kirOWjWdBCB8SRhKojOTkZeB3KyV9xtbK5YO/ezCWaWvVVNtjpX7o7fsouj
         AeL8LN4YTxu9oul07qxtWCCQ2Ob9TTv02Xb4o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690576898; x=1691181698;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1o44kCiViu9poWK+pr269ZTRZv94Q/szYxEaIBZbPhc=;
        b=iOQjhOZ2qWul/emWH9WkM7XL3liIbaBHQdTIqvV3+Z9ielOOO5ArNzVBrAA+41QWTh
         40EhBLewYK1h8BaQ+VwL7k7EqVKWwxx+Sbyfc9SZaj4T+/PNYyWX8gnzCGpkemSuYwjv
         8QGyA0HHXHVnGtIxRB4FyHP6elcTsmHZ0JAqd9fduPU/VdKJkKp5662vJQl+zIWYLTR7
         aN0u6FrVZpImd+uinUpt59inIiBHjrvNThkyt7Q+LqSKv7CIcXCGvMW2usPH/JpE1Cjd
         5bfXLXfsmOnDoW4hLbgAaed7V//5EzNwEKVzAGwkjVUELmMLItA453uTLvR22x30e0C6
         wH2Q==
X-Gm-Message-State: ABy/qLaDUi22NDK/5H+Y/WBhKWNIWvHbE5L1Ru0CtBbaSGD6S0pnPiyi
        ybVFy38TM1nEI3rdAg5PE7HkHXiMfgVmen736fhVXsxh
X-Google-Smtp-Source: APBJJlFMl4CJmTIRbuMcU7i059vIC8DUzUJzoa+QKEVAyLMbtOkMfyA45JnqvVFPWO8Q1iIJqVfSCw==
X-Received: by 2002:a05:6512:202e:b0:4f8:6abe:5249 with SMTP id s14-20020a056512202e00b004f86abe5249mr2147394lfs.3.1690576898444;
        Fri, 28 Jul 2023 13:41:38 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id t9-20020a19ad09000000b004fe26362d48sm145854lfc.75.2023.07.28.13.41.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jul 2023 13:41:37 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-4fe1c285690so3103858e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 13:41:37 -0700 (PDT)
X-Received: by 2002:a05:6512:61c:b0:4fb:90c6:c31a with SMTP id
 b28-20020a056512061c00b004fb90c6c31amr2404424lfe.14.1690576896802; Fri, 28
 Jul 2023 13:41:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230727183805.69c36d6e@g14> <b1dd27df-744b-3977-0a86-f5dde8e24288@amd.com>
 <20230727193949.55c18805@g14> <65a1c307-826d-4ca3-0336-07a185684e5d@amd.com>
 <20230727195019.41abb48d@g14> <67eefe98-e6df-e152-3169-44329e22478d@amd.com> <20230727200527.4080c595@g14>
In-Reply-To: <20230727200527.4080c595@g14>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 28 Jul 2023 13:41:19 -0700
X-Gmail-Original-Message-ID: <CAHk-=whqT0PxBazwfjWwoHQQFzZt50tV6Jfgq3iYceKMJtyuUg@mail.gmail.com>
Message-ID: <CAHk-=whqT0PxBazwfjWwoHQQFzZt50tV6Jfgq3iYceKMJtyuUg@mail.gmail.com>
Subject: Re: [PATCH 1/1] tpm: disable hwrng for fTPM on some AMD designs
To:     Daniil Stas <daniil.stas@posteo.net>
Cc:     Mario Limonciello <mario.limonciello@amd.com>,
        James.Bottomley@hansenpartnership.com, Jason@zx2c4.com,
        jarkko@kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, regressions@leemhuis.info,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Jul 2023 at 10:05, Daniil Stas <daniil.stas@posteo.net> wrote:
>
> Here is the bug report I created:
> https://bugzilla.kernel.org/show_bug.cgi?id=217719

Let's just disable the stupid fTPM hwrnd thing.

Maybe use it for the boot-time "gather entropy from different
sources", but clearly it should *not* be used at runtime.

Why would anybody use that crud when any machine that has it
supposedly fixed (which apparently didn't turn out to be true after
all) would also have the CPU rdrand instruction that doesn't have the
problem?

If you don't trust the CPU rdrand implementation (and that has had
bugs too - see clear_rdrand_cpuid_bit() and x86_init_rdrand()), why
would you trust the fTPM version that has caused even *more* problems?

So I don't see any downside to just saying "that fTPM thing is not
working". Even if it ends up working in the future, there are
alternatives that aren't any worse.

                 Linus
