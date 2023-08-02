Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DC9576D59A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 19:38:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233120AbjHBRiy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 13:38:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232400AbjHBRic (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 13:38:32 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B28D13AA2
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 10:38:04 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-5222a38c0a0so10381540a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 10:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1690997882; x=1691602682;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WyQdxgtNMG4RTFo6glKNGilpjeAOgHu/v44MBJ5lr6g=;
        b=FdGjw6HXHhZ6+Vw2hxfQAMrStQiiadvB/SsztWB+Hfj84Tz9a8e6TDptPNV8ihiSnl
         yZIQWFAs0/daQGqP59TJy+VoE7dMwfj3h/DxzVCR8pbqJY9pllhuUbq/kjebn38H5GAv
         zuFWmAEuAcogVpDQ4n1F3tMwwoQYRfOQzigX0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690997882; x=1691602682;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WyQdxgtNMG4RTFo6glKNGilpjeAOgHu/v44MBJ5lr6g=;
        b=He//MnBit++Hg4PRxXACztu4plwb/nGM721sV3iheGuf6YbaxYB3UiOdel4110Tgg5
         GaAHKBPPDNBkmZOVHzNZfuZDq7tggrmKArxsuSkb2PWFVZazXndk2tjYyvYIIczeHc6l
         Md6u/2lldae/wmZTnghDlBysRM4y1xtChQFyDVEq689zURgUZ93g4b9YBy7N3L+pXI5F
         iC4L5nY6JQ0d95zRxx9nGbAFw3l/LrgDp9xkh9C5vmLGPvhyVdimpGn/VvaeoleTQ/xV
         NWSdhlJGSgQLj6VFeK9EPvzWbJm3HQBkfdblqBPpHL+yUGvMxFLEO/PbhS5t5Haz3blz
         e97w==
X-Gm-Message-State: ABy/qLaFagrbjBrfRUhWEzlnjlDeKK++BJ/rWtGy3PnL6GuWnnbiaK6w
        qm70eES0Extcy/pt96NlEjbZWt7ZDlvqQ2ktmugj78NK
X-Google-Smtp-Source: APBJJlGovFtcSLKDrGJTGEVfzeb+zdBItFdgKtezLLF3hpsKe0udQuRYo0fyCNTdNTD4Yb/SXoKRxg==
X-Received: by 2002:aa7:da91:0:b0:522:c0ea:15f with SMTP id q17-20020aa7da91000000b00522c0ea015fmr4945512eds.41.1690997882544;
        Wed, 02 Aug 2023 10:38:02 -0700 (PDT)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com. [209.85.221.51])
        by smtp.gmail.com with ESMTPSA id n21-20020aa7d055000000b0051e26c7a154sm8793879edo.18.2023.08.02.10.38.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Aug 2023 10:38:01 -0700 (PDT)
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3176a439606so50895f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Aug 2023 10:38:01 -0700 (PDT)
X-Received: by 2002:a5d:608c:0:b0:315:9021:6dc3 with SMTP id
 w12-20020a5d608c000000b0031590216dc3mr4961506wrt.27.1690997880674; Wed, 02
 Aug 2023 10:38:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230801-bitwise-v1-1-799bec468dc4@google.com>
 <CAHk-=wgkC80Ey0Wyi3zHYexUmteeDL3hvZrp=EpMrDccRGmMwA@mail.gmail.com> <20230802161553.GA2108867@dev-arch.thelio-3990X>
In-Reply-To: <20230802161553.GA2108867@dev-arch.thelio-3990X>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 2 Aug 2023 10:37:43 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjmWjd+xe88cf14hFGkSK7fYJBSixK8Ym0DLYCa+dTxtg@mail.gmail.com>
Message-ID: <CAHk-=wjmWjd+xe88cf14hFGkSK7fYJBSixK8Ym0DLYCa+dTxtg@mail.gmail.com>
Subject: Re: [PATCH] word-at-a-time: use the same return type for has_zero
 regardless of endianness
To:     Nathan Chancellor <nathan@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     ndesaulniers@google.com, Arnd Bergmann <arnd@arndb.de>,
        Tom Rix <trix@redhat.com>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
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

On Wed, 2 Aug 2023 at 09:16, Nathan Chancellor <nathan@kernel.org> wrote:
>
> We see this warning with ARCH=arm64 defconfig + CONFIG_CPU_BIG_ENDIAN=y.

Oh Christ. I didn't even realize that arm64 allowed a BE config.

The config option goes back to 2013 - are there actually BE user space
implementations around?

People, why do we do that? That's positively crazy. BE is dead and
should be relegated to legacy platforms. There are no advantages to
being different just for the sake of being different - any "security
by obscurity" argument would be far outweighed by the inconvenience to
actual users.

Yes, yes, I know the aarch64 architecture technically allows BE
implementations - and apparently you can even do it by exception
level, which I had to look up. But do any actually exist?

Does the kernel even work right in BE mode? It's really easy to miss
some endianness check when all the actual hardware and use is LE, and
when (for example) instruction encoding and IO is then always LE
anyway.

> With both clang 18.0.0 (tip of tree) and GCC 13.1.0, I don't see any
> actual code generation changes in fs/namei.o with this configuration.

Ok, since the main legacy platform confirmed that, I'll just apply
that patch directly.

I'll also do the powerpc version that Arnd pointed to at the same
time, since it seems silly to pick these off one at a time. It too
should just be 'unsigned long', so that the two values can be bitwise
or'ed together without any questions.

              Linus
