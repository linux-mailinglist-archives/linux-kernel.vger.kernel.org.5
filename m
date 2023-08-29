Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FB2978CCF9
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 21:31:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239601AbjH2TbR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 15:31:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240363AbjH2Ta6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 15:30:58 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B32C1A1
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 12:30:44 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2bceca8a41aso71053161fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 12:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1693337442; x=1693942242; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FSQ4gNf423WtPLQ+pPFkJbDeU7NfPCf4BEI8oAjZMoY=;
        b=h71VDVThRR3CO9HiAITYIZNLZAHmIKRU4R3zn9hfdrZ7H6C4/9e6KYHL4wU9cnI4YP
         dk+DG12SHrvV0rtlOZyJkYooPBIWHnEosxklfsBZQeX3Vg1L041GcEbCHz3cX+5cKLJq
         q23vdnEP69DuESkGFjlOXGlI3YVzucGmOqzro=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693337442; x=1693942242;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FSQ4gNf423WtPLQ+pPFkJbDeU7NfPCf4BEI8oAjZMoY=;
        b=buV38vWISeiZMLUXMg4YpbtvV82EI2uekev88ptrkWG9vG5ouy2Xf/fBGTze8Qjj4O
         Kagq4VSA3jbaqzNO1hS+egSFKY7yIKDaYiwG9rbLOCVl6pE3P1PA2rxFAp6HMpyhouWQ
         bq3Qky5kS7fhbeyklXWAq2XSd/dfVWTlWw5VoDJeGcyQQ6huxFZoXHq4HlvOnVezKQLg
         THg08jM9F9qa2hYSiGfo2A2nr3GGdGwi1iXSY3kiNbwvlD00MG4Sgy6pGkt/q3n8uWdM
         uYYzHHnc8TtDBltgp2BYARQWX5/fktXTyFoDdG3I16ZurGFrBNFlnn0pX3pojxsVZLaG
         JUCQ==
X-Gm-Message-State: AOJu0YwVXfSN1R3EUQHHggBec9vTGK+ucBme9KK/gp+JnFD4fMAYDGC6
        6Ou97oTzs4Nv7UXgZDc8/wKWy0sQ8iXjQ5UunjOoQGOg
X-Google-Smtp-Source: AGHT+IFl5o69Nu+W6A22owGV2zSHMDuJhI2xV67tdKfyT9qjM5DjBWBbKgagd4Tpbo3LRU+spiZFPQ==
X-Received: by 2002:a2e:8093:0:b0:2ba:8127:a2c3 with SMTP id i19-20020a2e8093000000b002ba8127a2c3mr215764ljg.34.1693337442472;
        Tue, 29 Aug 2023 12:30:42 -0700 (PDT)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id n13-20020a2e904d000000b002bce5e379a3sm2265399ljg.7.2023.08.29.12.30.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Aug 2023 12:30:41 -0700 (PDT)
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-50078eba7afso7706070e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 12:30:41 -0700 (PDT)
X-Received: by 2002:a19:431c:0:b0:500:7685:83d with SMTP id
 q28-20020a19431c000000b005007685083dmr17941739lfa.48.1693337441334; Tue, 29
 Aug 2023 12:30:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230828170732.2526618-1-mjguzik@gmail.com>
In-Reply-To: <20230828170732.2526618-1-mjguzik@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 29 Aug 2023 12:30:24 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj=YwAsPUHN7Drem=Gj9xT6vvxgZx77ZecZVxOYYXpC0w@mail.gmail.com>
Message-ID: <CAHk-=wj=YwAsPUHN7Drem=Gj9xT6vvxgZx77ZecZVxOYYXpC0w@mail.gmail.com>
Subject: Re: [PATCH] x86: bring back rep movsq for user access on CPUs without ERMS
To:     Mateusz Guzik <mjguzik@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        bp@alien8.de
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

On Mon, 28 Aug 2023 at 10:07, Mateusz Guzik <mjguzik@gmail.com> wrote:
>
> Hand-rolled mov loops executing in this case are quite pessimal compared
> to rep movsq for bigger sizes. While the upper limit depends on uarch,
> everyone is well south of 1KB AFAICS and sizes bigger than that are
> common. The problem can be easily remedied so do it.

Ok, looking at teh actual code now, and your patch is buggy.

> +.Llarge_movsq:
> +       movq %rcx,%r8
> +       movq %rcx,%rax
> +       shrq $3,%rcx
> +       andl $7,%eax
> +6:     rep movsq
> +       movl %eax,%ecx
>         testl %ecx,%ecx
>         jne .Lcopy_user_tail
>         RET

The fixup code is very very broken:

> +/*
> + * Recovery after failed rep movsq
> + */
> +7:     movq %r8,%rcx
> +       jmp .Lcopy_user_tail
> +
> +       _ASM_EXTABLE_UA( 6b, 7b)

That just copies the original value back into %rcx. That's not at all
ok. The "rep movsq" may have succeeded partially, and updated %rcx
(and %rsi/rdi) accordingly. You now will do the "tail" for entirely
too much, and returning the wrong return value.

In fact, if this then races with a mmap() in another thread, the user
copy might end up then succeeding for the part that used to fail, and
in that case it will possibly end up copying much more than asked for
and overrunning the buffers provided.

So all those games with %r8 are entirely bogus. There is no way that
"save the original length" can ever be relevant or correct.

              Linus
