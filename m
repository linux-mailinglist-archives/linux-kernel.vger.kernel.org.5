Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F34887C8E27
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 22:08:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231978AbjJMUIS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 16:08:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231814AbjJMUIR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 16:08:17 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 568F5BB
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 13:08:15 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-991c786369cso404028966b.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 13:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1697227693; x=1697832493; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jsKHNTC7q/1Ae/WWJWgpmfclq27doB+7avsJMMxFAis=;
        b=MVJNAWpg8M27Z92TDeKm3C7wfK8rJfLyxdi0mfKHdTa9qe2DApRBvCe+2U6hMYEALz
         Au3XUuBD5fXwYz7XqfgZR9zbuKsD8tLDU2W6SpGqITjaW4hCwtIXwYCaTfQ0QzeeC8mt
         xxkJNOFQkiB9ALoWaztoOSZgdFMM6JKoXfjHo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697227693; x=1697832493;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jsKHNTC7q/1Ae/WWJWgpmfclq27doB+7avsJMMxFAis=;
        b=k5SwlYMLZllk8vVwUCRj1Yfe+twrm9gyHiDh7Xz/VqwhVClDUs4Ul0GaPpX77qsxK0
         jyQJRbiCu2vpJ+NcO9fTt3acxPmJoV9iOhkS6P5fQVAtvNtwx/SaPL2eJvKwe5mMcZ2i
         fZEEvNS1CFVTIA/ZD1aZmucVxbJmbT2EK0zwJa/zr4xGgF0Q/AAQe57o6Oicu0cwHNnH
         h9fjp9DoWGHo/u5f4mTdoHY2C3Jlaz92Y4b9pC630psZ94/ZWG5xDKRRDOPYNtJEy/dE
         cSfpcbR2XirBwTAaWvyvLDwtILF7Nuih3VxcZsG2XS01xw2kWOZ0iADAB6HsFzG5BRis
         2aEQ==
X-Gm-Message-State: AOJu0YwYNu0plJ0aeY+ruekyUPbpdwAOaXtFPXGGLBuki4LkDiFk52av
        KJL3tvzg1bQRRYo/sf9F2i2T2M1q8deOdlowSidR4uzv
X-Google-Smtp-Source: AGHT+IG0iW+MOtS3MhTBwV2n50TiX3lP4Y0VolhD2phUKGSSv1rKfkooNgyaHRyOnufNDJtdJkEZYg==
X-Received: by 2002:a17:907:3f94:b0:9bd:e99b:82dc with SMTP id hr20-20020a1709073f9400b009bde99b82dcmr1811977ejc.61.1697227693728;
        Fri, 13 Oct 2023 13:08:13 -0700 (PDT)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id x15-20020a170906710f00b009ae5e46210asm26909ejj.99.2023.10.13.13.08.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Oct 2023 13:08:12 -0700 (PDT)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-9a9f139cd94so402594366b.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 13:08:12 -0700 (PDT)
X-Received: by 2002:a17:906:e:b0:9b2:7492:70a0 with SMTP id
 14-20020a170906000e00b009b2749270a0mr23332329eja.27.1697227692462; Fri, 13
 Oct 2023 13:08:12 -0700 (PDT)
MIME-Version: 1.0
References: <20231011204150.51166-1-ubizjak@gmail.com> <ZSlqo-k2htjN1gPh@google.com>
 <CAFULd4bTyKKw+=SuTVbFXzgqqV+XU-kGaO5eBcXck5BUpvoUJg@mail.gmail.com>
In-Reply-To: <CAFULd4bTyKKw+=SuTVbFXzgqqV+XU-kGaO5eBcXck5BUpvoUJg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 13 Oct 2023 13:07:51 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgvG1X60i5DQdExmS9DB3-0v3ByDyzLZdewvy6ptf1-+w@mail.gmail.com>
Message-ID: <CAHk-=wgvG1X60i5DQdExmS9DB3-0v3ByDyzLZdewvy6ptf1-+w@mail.gmail.com>
Subject: Re: [PATCH tip] x86/percpu: Rewrite arch_raw_cpu_ptr()
To:     Uros Bizjak <ubizjak@gmail.com>
Cc:     Sean Christopherson <seanjc@google.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Nadav Amit <namit@vmware.com>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Brian Gerst <brgerst@gmail.com>,
        Denys Vlasenko <dvlasenk@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Oct 2023 at 12:30, Uros Bizjak <ubizjak@gmail.com> wrote:
>
> There are some other issues when memory access to the percpu area is
> implemented with an asm. An ongoing analysis shows that compilers
> can't CSE asm over basic-block boundaries, the CSE of asm is a very
> simple pattern matching through the BB.

Ahh. That explains the odd "partial CSE".

I was assuming that CSE was done on the SSA level with some dominance
analysis. Which presumably all the load simplification ends up doing.

              Linus
