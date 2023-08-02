Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 514E676C1E1
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 03:07:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231370AbjHBBHe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 21:07:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjHBBHa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 21:07:30 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA8011BD3
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 18:07:29 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4fe1c285690so9095231e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 01 Aug 2023 18:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1690938447; x=1691543247;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FXkdVovEwsRXfv+Dg7OQg7KZYMXc3NVjQ9UsNbCmbkM=;
        b=h2oAqqiZHA1I7+7KJ4qkiD6c+sb34x9IKFRrWiIgIKCjYGnQ9LY5YfGQeIXDkWDb7n
         gaC4QjEwJE9EC56qPqcn+iDm0F8zZ/suBTIWB7KirvXY9IApXagyXhHGhA16U9vBIiRf
         g4LVUfyHUdi2IVB2eTF2vDKxmPMNA7awbpXws=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690938447; x=1691543247;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FXkdVovEwsRXfv+Dg7OQg7KZYMXc3NVjQ9UsNbCmbkM=;
        b=WOXDerNDw1H0INeuqXFnTYxOk4uSe4aiuPBi92zUCoIdRLSp3QugGmTi0oug/kyWfv
         dODoterCQ+wENKqFcWWSKRDfgOdaLkzTeWmwunqoo4xtEUuTVjPq/IWpRqQXK3B0potu
         f31+lxJJosb18tMaoZfCqbHdb2PDki5JqQofUMQr7IrPGBhwRT5qi+RVQYkr1SfHqC0Y
         0H+3rUW70Ak/Zyf1nMtixS9QVfNwoJ/I2XO7c1q/ZIVPsRqMh9XcrdvF2nPmi0Nll41w
         78cjydVnW/6immdKROlx9Eim9IU19K3uAaZ68a3+uzaeaHnHHcWpd6i0mCja/0wfgpOs
         lCTQ==
X-Gm-Message-State: ABy/qLZdWljpfAjq0P4t6sXW2oIdKLwionN1UdEiMkdX1Ws/fZ40jcdL
        7AueS9+zTTQ9DwdnXuAsj4RO++bCg3xRrD5RzVqg0isA
X-Google-Smtp-Source: APBJJlEkDDIKcl3TO91gSbCgBDmOx8RKThECry+gO7bCc24kuD4JdD9sBH+mAc9LRvw1fmKRuSfkrA==
X-Received: by 2002:ac2:5f6a:0:b0:4fb:740a:81ae with SMTP id c10-20020ac25f6a000000b004fb740a81aemr3092406lfc.16.1690938447453;
        Tue, 01 Aug 2023 18:07:27 -0700 (PDT)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id d26-20020a05640208da00b00522be713f0csm4413034edz.32.2023.08.01.18.07.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Aug 2023 18:07:26 -0700 (PDT)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5221b90f763so8880506a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Aug 2023 18:07:26 -0700 (PDT)
X-Received: by 2002:aa7:df18:0:b0:522:289d:8dcd with SMTP id
 c24-20020aa7df18000000b00522289d8dcdmr3129466edy.35.1690938445668; Tue, 01
 Aug 2023 18:07:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230801-bitwise-v1-1-799bec468dc4@google.com>
In-Reply-To: <20230801-bitwise-v1-1-799bec468dc4@google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 1 Aug 2023 18:07:08 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgkC80Ey0Wyi3zHYexUmteeDL3hvZrp=EpMrDccRGmMwA@mail.gmail.com>
Message-ID: <CAHk-=wgkC80Ey0Wyi3zHYexUmteeDL3hvZrp=EpMrDccRGmMwA@mail.gmail.com>
Subject: Re: [PATCH] word-at-a-time: use the same return type for has_zero
 regardless of endianness
To:     ndesaulniers@google.com
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
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

On Tue, 1 Aug 2023 at 15:22, <ndesaulniers@google.com> wrote:
>
> Compiling big-endian targets with Clang produces the diagnostic:
>
> fs/namei.c:2173:13: warning: use of bitwise '|' with boolean operands
> [-Wbitwise-instead-of-logical]
> } while (!(has_zero(a, &adata, &constants) | has_zero(b, &bdata, &constants)));

Gaah.

Yes, I think that 'has_zero()' should return the 'unsigned long' bits
on big-endian too, because I do think we always want the bit ops, and
turn it into a boolean only at the very end.

> It appears that when has_zero was introduced, two definitions were
> produced with different signatures (in particular different return types).

Big-endian was kind of a later addition, and while that file is called
"generic", it's really "little-endian has an easier time of this all,
but let's do the 'generic' file for the more complicated case".

Who ends up being affected by this? Powerpc does its own
word-at-a-time thing because the big-endian case is nasty and you can
do better with special instructions that they have.

Who else is even BE any more? Some old 32-bit arm setup?

I think the patch is fine, but I guess I'd like to know that people
who are affected actually don't see any code generation changes (or
possibly see improvements from not turning it into a bool until later)

            Linus
