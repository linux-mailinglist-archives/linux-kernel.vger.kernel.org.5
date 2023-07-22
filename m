Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 720C175DE1E
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 20:52:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbjGVSwo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 14:52:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjGVSwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 14:52:42 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B17C32128
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 11:52:41 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-52222562f1eso69719a12.3
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 11:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1690051960; x=1690656760;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=G4EHsYbDrBuVMb0gheWkPS7eVFc1IDuaQkcZFjpTTTs=;
        b=EjD8e/kE4zgLvTf0Y8U30s3ksjYhtPvE3bs7ydQwZREUSkWaV84qRlYN7Wjc1AUZJG
         XNK+uaf3H0bYNy5ERd89OVoc/AufSaZUAJABJ5K/c+F0aKqrixcTR24BuBJ0DwEP1PI/
         ddbtldqLZ2csSXXbKoNTklYHms9h3MiHIyU3k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690051960; x=1690656760;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G4EHsYbDrBuVMb0gheWkPS7eVFc1IDuaQkcZFjpTTTs=;
        b=ZTwOYjAl3q/C94Oypwm/SR2RfSCARDIVxBZ0EoJM2kT0DedNOHUQGr/rv0QSF9LGMy
         bFseXoeEQ0VpeAHfS42G14UzvLJqVY8MuHDTfQmuh92Yd7ggTx41VbfIndrkeiAm06lw
         NJXnRCZDatCJYWDMriod3tLmGfiFfGKnBAGIvBC5EF6LNon5R0QodL1FVDkd/A4BEiKU
         B63udFIUtvma01f9pffw5YCK3IHssLyPYy5nK0OmK9OcRrq+tynEgvbkNHCyLvpfEYZe
         aAZwAZZS4VYRNphhI+TOh9YL9AsRal/V53ZSrKuQrLLHImWQrIIqwdaeApNjF1/cthCk
         uBvQ==
X-Gm-Message-State: ABy/qLbVY2SgtMSLx6hD+aVQ0axF6j3/jZ+VuELw/dpXNbhoW7wY5vdf
        fzleSdhVsV6rktpufetCaPJunI8qq9LgPVzJnTNLwQ==
X-Google-Smtp-Source: APBJJlH5P0eWRH/dkEA//GYW+EdAv0PaQqogdfB4iFyeMTjsAyznAQdIxjUu+2VP1jsuvkERQaN3Bg==
X-Received: by 2002:aa7:dcc7:0:b0:515:1e50:5498 with SMTP id w7-20020aa7dcc7000000b005151e505498mr4633987edu.15.1690051959990;
        Sat, 22 Jul 2023 11:52:39 -0700 (PDT)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id bf9-20020a0564021a4900b0052177c077eesm3664931edb.68.2023.07.22.11.52.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Jul 2023 11:52:39 -0700 (PDT)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-52222562f1eso69697a12.3
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 11:52:39 -0700 (PDT)
X-Received: by 2002:aa7:d48d:0:b0:521:63c5:77d7 with SMTP id
 b13-20020aa7d48d000000b0052163c577d7mr5117199edr.8.1690051959163; Sat, 22 Jul
 2023 11:52:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230722160215.7417-A-hca@linux.ibm.com>
In-Reply-To: <20230722160215.7417-A-hca@linux.ibm.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 22 Jul 2023 11:52:22 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj2g7kDTKPawbhOKXFsAF+Zayygmp1f64oerQktc_LCYw@mail.gmail.com>
Message-ID: <CAHk-=wj2g7kDTKPawbhOKXFsAF+Zayygmp1f64oerQktc_LCYw@mail.gmail.com>
Subject: Re: [GIT PULL] s390 fixes for 6.5-rc3
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     Alexander Gordeev <agordeev@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Sat, 22 Jul 2023 at 09:02, Heiko Carstens <hca@linux.ibm.com> wrote:
>
> - Fix per vma lock fault handling: add missing !(fault & VM_FAULT_ERROR)
>   check to fault handler to prevent error handling for return values that
>   don't indicate an error

Hmm. The s390 code / people seems to still be a bit confused about the
VM_FAULT flags.

The commit comment says "With per-vma locks, handle_mm_fault() may
return non-fatal error flags".

That's actively misleading.

Why? Because handle_mm_fault() may - and will - return non-fatal error
flags *regardless* of the per-vma locks.

There's VM_FAULT_COMPLETED, there's VM_FAULT_MAJOR, there are all
those kinds of "informational" bits.

So honestly, when that patch then does

+       if (likely(!(fault & VM_FAULT_ERROR)))
+               fault = 0;

I feel like the code is very confused about what is going on, and is
papering over the real bug.

The *real* bug seems to be that do_protection_exception() and
do_dat_exception() do this:

        fault = do_exception(regs, access);
        if (unlikely(fault))
                do_fault_error(regs, fault);

which is basically nonsensical. And the reason that s390 does that
seems to be that s390 (and arm, for that matter) seem, to have added a
few extra VM_FAULT_xyz bits that aren't part of VM_FAULT_ERROR, so
then in do_fault_error() you have that nonsensical "test some of the
fields as values, and other fields as bits".

Anyway, I have pulled this, since it clearly fixes a problem. But I do
think that the *deeper* problem is that s390 treats those bits as
errors in the first place, when they really aren't. Yes, the error
bits are *common*, but that field really shouldn't be seen as just
errors, and I really think that the deeper problem is that

        if (unlikely(fault))
                do_fault_error(regs, fault);

logic. It's simply wrong.

Of course, it looks like the reason you found this is that the s390
do_fault_error() then does a BUG() on any bits it doesn't understand.
You have that nonsensical "clear flags" in other places too. So it's
not like this work-around is new. But it's a workaround, and a sign of
confusion, I feel.

Maybe the extra s390 fault conditions should be added to the generic
list and added to the VM_FAULT_ERROR mask. I dunno.

              Linus
