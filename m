Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 533B575A2EE
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 01:48:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbjGSXss (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 19:48:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjGSXsj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 19:48:39 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCD561998
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 16:48:38 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4fb7589b187so274446e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 16:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1689810517; x=1690415317;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xITvYVSy1BHIKVEC9gx23jBZUjPhKEXUypo/Br0I0Ws=;
        b=D4iqILciLzn7WTiO1p1n9bdvliLyspYUZILG9YBKTCYmU+QgFYSdY/rntmy0VeqoGH
         sDc8CDY17K/9ymmr19ynrCAU4/FLQDdYFove8g/WAFJFY7nByt7CogliX4y9g9NVcnBS
         2ll2pGJTYgplQMNR1GHIOT8LRuenCD0WjAVnc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689810517; x=1690415317;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xITvYVSy1BHIKVEC9gx23jBZUjPhKEXUypo/Br0I0Ws=;
        b=Tp9t7x4vyAJWgSLI2bm+YfeQtqHcnnU461V00n6O8o7OLaAW6qJWnkPZNte2KzAMfX
         vx0aFRIxxe0TgLt2fzn5eVyQn9ttNjSawWhIiQejBU9oTPi4AgRsC0eB4ZcZ6u64Hr9o
         8ROQvsfOt0IaIJ+mhCDdQVQI+atcseBtMF9e3yWq3fSKkcMnBb0PNrdBomERCdfZW4vk
         Fqf9bTcE12wsr+Ynf3H2seuJirSgX0fDKEcvCpQW/DH7r/iOu9FMwuIfBQN4inbRVHeS
         4Flzv7kjG2QL7c3T8iAdtnHsBRKVpZF4Zn23uAucTjyTB69RJa9lnc4Y50761UmbRQ81
         0FkQ==
X-Gm-Message-State: ABy/qLaLaGsVMgLmH02rf4xTaxK6cyZgzmCoE1UtASZdV1DdbCjqGPLX
        XCIX4wq3CnL7K6TLoeb65zwj7hTdlxd0yAsqdb61KOkU
X-Google-Smtp-Source: APBJJlGwNobt8TIIXZZzyHksfQ/eY0kKprSr+tpygEOW65VfxdY1mpWG0lefNcqGcvNrakfB+8CqlA==
X-Received: by 2002:a19:8c0a:0:b0:4fb:9772:6639 with SMTP id o10-20020a198c0a000000b004fb97726639mr900455lfd.6.1689810516882;
        Wed, 19 Jul 2023 16:48:36 -0700 (PDT)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id j17-20020aa7ca51000000b0051d890b2407sm3235580edt.81.2023.07.19.16.48.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jul 2023 16:48:35 -0700 (PDT)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-51e429e1eabso155997a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 16:48:35 -0700 (PDT)
X-Received: by 2002:aa7:cd52:0:b0:521:aeba:c6c8 with SMTP id
 v18-20020aa7cd52000000b00521aebac6c8mr3187409edw.39.1689810514772; Wed, 19
 Jul 2023 16:48:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230629155433.4170837-1-dhowells@redhat.com> <20230629155433.4170837-2-dhowells@redhat.com>
 <CAJfpegsJuvXJDcXpo9T19Gw0tDuvyOJdv44Y2bt04MEf1JLxGg@mail.gmail.com>
 <c634a18e-9f2b-4746-bd8f-aa1d41e6ddf7@mattwhitlock.name> <CAJfpegvq4M_Go7fHiWVBBkrK6h4ChLqQTd0+EOKbRWZDcVerWA@mail.gmail.com>
 <ZLg9HbhOVnLk1ogA@casper.infradead.org> <CAHk-=wiq95bWiWLyz96ombPfpy=PNrc2KKyzJ2d+WMrxi6=OVA@mail.gmail.com>
 <6609f1b8-3264-4017-ac3c-84a01ea12690@mattwhitlock.name> <CAHk-=wh7OY=7ocTFY8styG8GgQ1coWxds=b09acHZG4t36OxWg@mail.gmail.com>
In-Reply-To: <CAHk-=wh7OY=7ocTFY8styG8GgQ1coWxds=b09acHZG4t36OxWg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 19 Jul 2023 16:48:17 -0700
X-Gmail-Original-Message-ID: <CAHk-=wguPaB+O0cSZaT-Zi1o+h0FccqL91s7rDokwkruNHE2BQ@mail.gmail.com>
Message-ID: <CAHk-=wguPaB+O0cSZaT-Zi1o+h0FccqL91s7rDokwkruNHE2BQ@mail.gmail.com>
Subject: Re: [RFC PATCH 1/4] splice: Fix corruption of spliced data after
 splice() returns
To:     Matt Whitlock <kernel@mattwhitlock.name>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        David Howells <dhowells@redhat.com>, netdev@vger.kernel.org,
        Dave Chinner <david@fromorbit.com>,
        Jens Axboe <axboe@kernel.dk>, linux-fsdevel@kvack.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Jul 2023 at 16:20, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> If you want "one-copy", what you can do is:
>
>  - mmap() the file data (zero copy, not stable yet)
>
>  - use "write()" to write the data to the network. This will copy it
> to the skbs before the write() call returns and that copy makes it
> stable.
>
> Alternatively, if you want to be more than a bit odd, you _can_ do the
> zero-copy on the write side, by doing
>
>  - read the file data (one copy, now it's stable)
>
>  - vmsplice() to the kernel buffer (zero copy)
>
>  - splice() to the network (zero copy at least for the good cases)

Actually, I guess technically there's a third way:

 - mmap the input (zero copy)

 - write() to a pipe (one copy)

 - splice() to the network (zero copy)

which doesn't seem to really have any sane use cases, but who knows...
It avoids the user buffer management of the vmsplice() model, and
while you cannot do anything to the data in user space *before* it is
stable (because it only becomes stable as it is copied to the pipe
buffers by the 'write()' system call), you could use "tee()" to
duplicate the now stable stream and perhaps log it or create a
checksum after-the-fact.

Another use-case would be if you want to send the *same* stable stream
to two different network connections, while still only having one
copy. You can't do that with plain splice() - because the data isn't
guaranteed to be stable, and the two network connections might see
different streams. You can't do that with the 'mmap and then
write-to-socket' approach, because the two writes not only copy twice,
they might copy different data.

And while you *can* do it with the "read+vmsplice()" approach, maybe
the "write to pipe() in order to avoid any user space buffer issues"
model is better. And "tee()" avoids the overhead of doing multiple
vmsplice() calls on the same buffer.

I dunno.

What I *am* trying to say is that "splice()" is actually kind of
designed for people to do these kinds of combinations. But very very
few people actually do it.

For example, the "tee()" system call exists, but it is crazy hard to
use, I'm not sure it has ever actually been used for anything real.

               Linus
