Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10AF17FA7BE
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 18:12:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234823AbjK0RLt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 12:11:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234820AbjK0RLJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 12:11:09 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 408E11BC7
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 09:11:15 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-a03a9009572so614019466b.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 09:11:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1701105073; x=1701709873; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=X8veV/N8u0KLOX8kp8+RpeOybN7ghMV50gJ3VwXOlp8=;
        b=PcsInHh5HXkbieFV2FX4t1zPdN1+/iP8d7BWrpr6i3br4LFffPLYqVhO4o81qXs/pt
         557sTkZthTNX+awOWpakw2gLe5Ili83IAPKFflhwykqPf5xDmFiVBt+DgUElyMcXcCUD
         RhA+9WOZd7rMdF1uZkilHuMAXGtIfQ3tTa5bY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701105073; x=1701709873;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X8veV/N8u0KLOX8kp8+RpeOybN7ghMV50gJ3VwXOlp8=;
        b=Xttiyz3g5Flf1vnryqs+FZnnHIRibeEIZHfKFaKve4pud60WMu2DyDxgOLxW47wOrR
         nhwBowivxkkCMXJiV487P0o+dPNw7LbbiXuBFZowcGkpR6/gSHXZmd2soei6E1o4LJHK
         QFZ0Up4rwbLeneUintwuWze2rg06zQyT6ROFtyfoWAWd3uWpKYI2zuauvoEISisEd7X/
         V+2BoO9aQsXlHE5RUSSCdAq1Uo5Ef4cTDG3WEyfWQKc6BDA7hiVg6C+nbRz1USdCNe4C
         TZ/sg353DkZG2cL7od9ExWko4/43UQVaXBuvnaTzOR2fBhYkE2T/FRh5f+QK33BhjuPg
         A7jQ==
X-Gm-Message-State: AOJu0Yz/5kvjUHu5tc+sXOiLmnikICw364P9TUtV3NsyrCOejfQ/ZxXJ
        1zGhItBRC3gmnAghYfaGT7zyhaQWjkTp+5Ayh87BQg==
X-Google-Smtp-Source: AGHT+IG492A2CUJHXNUR4+ZqN3VU6fWpzJM6nRmcf2iPOnjfrp2MhlSz3yJYOt2fK+75A5jevjYexQ==
X-Received: by 2002:a17:906:10d7:b0:a0c:85f8:c1f8 with SMTP id v23-20020a17090610d700b00a0c85f8c1f8mr4935208ejv.50.1701105073376;
        Mon, 27 Nov 2023 09:11:13 -0800 (PST)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id jt24-20020a170906dfd800b009e5c644e34dsm5844098ejc.82.2023.11.27.09.11.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Nov 2023 09:11:11 -0800 (PST)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-54b0c7987easo3638902a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 09:11:11 -0800 (PST)
X-Received: by 2002:a50:d4c5:0:b0:53e:1b:15f5 with SMTP id e5-20020a50d4c5000000b0053e001b15f5mr7964361edj.39.1701105070828;
 Mon, 27 Nov 2023 09:11:10 -0800 (PST)
MIME-Version: 1.0
References: <202311201406.2022ca3f-oliver.sang@intel.com> <CAHk-=wjMKONPsXAJ=yJuPBEAx6HdYRkYE8TdYVBvpm3=x_EnCw@mail.gmail.com>
 <CAHk-=wiCJtLbFWNURB34b9a_R_unaH3CiMRXfkR0-iihB_z68A@mail.gmail.com> <20231127-kirschen-dissens-b511900fa85a@brauner>
In-Reply-To: <20231127-kirschen-dissens-b511900fa85a@brauner>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 27 Nov 2023 09:10:54 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgwpzgoSYU9Ob+MRyFuHRow4s5J099=DsCo1hGT=bkCtw@mail.gmail.com>
Message-ID: <CAHk-=wgwpzgoSYU9Ob+MRyFuHRow4s5J099=DsCo1hGT=bkCtw@mail.gmail.com>
Subject: Re: [linus:master] [file] 0ede61d858: will-it-scale.per_thread_ops
 -2.9% regression
To:     Christian Brauner <brauner@kernel.org>
Cc:     kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev,
        lkp@intel.com, linux-kernel@vger.kernel.org,
        Jann Horn <jannh@google.com>, linux-doc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, intel-gfx@lists.freedesktop.org,
        linux-fsdevel@vger.kernel.org, gfs2@lists.linux.dev,
        bpf@vger.kernel.org, ying.huang@intel.com, feng.tang@intel.com,
        fengwei.yin@intel.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Nov 2023 at 02:27, Christian Brauner <brauner@kernel.org> wrote:
>
> So I've picked up your patch (vfs.misc). It's clever alright so thanks
> for the comments in there otherwise I would've stared at this for far
> too long.

Note that I should probably have commented on one other thing: that
whole "just load from fd[0] is always safe, because the fd[] array
always exists".

IOW, that whole "load and mask" thing only works when you know the
array exists at all.

Doing that "just mask the index" wouldn't be valid if "size = 0" is an
option and might mean that we don't have an array at all (ie if "->fd"
itself could be NULL.

But we never have a completely empty file descriptor array, and
fdp->fd is never NULL.  At a minimum 'max_fds' is NR_OPEN_DEFAULT.

(The whole 'tsk->files' could be NULL, but only for kernel threads or
when exiting, so fget_task() will check for *that*, but it's a
separate thing)

So that's why it's safe to *entirely* remove the whole

                if (unlikely(fd >= fdt->max_fds))

test, and do it *all* with just "mask the index, and mask the resulting load".

Because we can *always* do that load at "fdt->fd[0]", and we want to
check the result for NULL anyway, so the "mask at the end and check
for NULL" is both natural and generates very good code.

Anyway, not a big deal, bit it might be worth noting before somebody
tries the same trick on some other array that *could* be zero-sized
and with a NULL base pointer, and where that 'array[0]' access isn't
necessarily guaranteed to be ok.

> It's a little unpleasant because of the cast-orama going on before we
> check the file pointer but I don't see that it's in any way wrong.

In my cleanup phase - which was a bit messy - I did wonder if I should
have some helper for it, since it shows up in both __fget_files_rcu()
and in files_lookup_fd_raw().

So I *could* have tried to add something like a
"masked_rcu_dereference()" that took the base pointer, the index, and
the mask, and did that whole dance.

Or I could have had just a "mask_pointer()" function, which we do
occasionally do in other places too (ie we hide data in low bits, and
then we mask them away when the pointer is used as a pointer).

But with only two users, it seemed to add more conceptual complexity
than it's worth, and I was not convinced that we'd want to expose that
pattern and have others use it.

So having a helper might clarify things, but it might also encourage
wrong users. I dunno.

I suspect the only real use for this ends up being this very special
"access the fdt->fd[] array using a file descriptor".

Anyway, that's why I largely just did it with comments, and commented
both places - and just kept the cast there in the open.

             Linus
