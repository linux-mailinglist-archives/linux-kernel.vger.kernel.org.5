Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23F95759F6B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 22:16:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230333AbjGSUQe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 16:16:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbjGSUQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 16:16:31 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF1441FEC
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 13:16:27 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2b74fa5e7d7so77571fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 13:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1689797786; x=1692389786;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ReDr3/cUrrY5O6f157kS0Oes02zkOeh4YD/h5uR7Jps=;
        b=coi65PEzCV7rCDEfL1mpkcR6k+K28LAsBIXeiZTCZLjyw2Hy4j+ku4FXsXBZCMuun9
         P4YFf7zHA3iWFEyAOCYUleRCXXLr6ChxfuWsEDVI8+N1e2T11Lo54fctsXWy4wHwot4X
         ek09n/z1vP6HGncPkGB8YnuM4OcDKlXEa7zZM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689797786; x=1692389786;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ReDr3/cUrrY5O6f157kS0Oes02zkOeh4YD/h5uR7Jps=;
        b=QGVVtVaY4VN2uyDr4gN8Khj03DbxZG0MBSW9nUCf7cDgAf7EVAEhTMfRLZMXu1I+Ro
         DOQ22/5zE9wbxr9+Xh+2cDzbdVKF0d+vZVIh98mcoT0Qi35aoCvx4cyQWIqVCPID3Fx8
         oohrDNctyR5ND2PTnivz83dDrJESM7t8Kd0WWdQbshFHQivZ7pJ9wXslQZ6uLXAvUcdy
         Uzp/h2jFO74Iyp9mHmNS8G0fOGxW4yYk1OphoNoPId9gK0EQ/CzLSglLf6YbLxJEL9Xd
         CYQcekNeB9FNH+rRpgq2yDcci6iZlDgeE2BJSsaAR0VDeZOR+DYizIHia3HpGpdy119p
         OIvw==
X-Gm-Message-State: ABy/qLYH4H2dE+IOebzI16/izlpbXGw5jiRVf80nkYTZnI7JI+qNSMoo
        bmSdCJJbODw7o2dN7/J6QIvGkygGu6UVIXkP+adKIM74
X-Google-Smtp-Source: APBJJlECqlbMh8z7X6ur/8CnGw3EmJTLSqlxZN3xLPcFkMtAjfISDMlVMbwscD9Xl/Yn5uNsKFygVA==
X-Received: by 2002:a2e:908b:0:b0:2b6:dd9a:e1d3 with SMTP id l11-20020a2e908b000000b002b6dd9ae1d3mr705601ljg.44.1689797786041;
        Wed, 19 Jul 2023 13:16:26 -0700 (PDT)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id c3-20020a2e9483000000b002b6cb40e9aasm1162151ljh.103.2023.07.19.13.16.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jul 2023 13:16:25 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2b734aea34aso387471fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 13:16:25 -0700 (PDT)
X-Received: by 2002:a05:6512:368c:b0:4fb:85ad:b6e2 with SMTP id
 d12-20020a056512368c00b004fb85adb6e2mr613569lfs.50.1689797784754; Wed, 19 Jul
 2023 13:16:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230629155433.4170837-1-dhowells@redhat.com> <20230629155433.4170837-2-dhowells@redhat.com>
 <CAJfpegsJuvXJDcXpo9T19Gw0tDuvyOJdv44Y2bt04MEf1JLxGg@mail.gmail.com>
 <c634a18e-9f2b-4746-bd8f-aa1d41e6ddf7@mattwhitlock.name> <CAJfpegvq4M_Go7fHiWVBBkrK6h4ChLqQTd0+EOKbRWZDcVerWA@mail.gmail.com>
 <ZLg9HbhOVnLk1ogA@casper.infradead.org>
In-Reply-To: <ZLg9HbhOVnLk1ogA@casper.infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 19 Jul 2023 13:16:07 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiq95bWiWLyz96ombPfpy=PNrc2KKyzJ2d+WMrxi6=OVA@mail.gmail.com>
Message-ID: <CAHk-=wiq95bWiWLyz96ombPfpy=PNrc2KKyzJ2d+WMrxi6=OVA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/4] splice: Fix corruption of spliced data after
 splice() returns
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Matt Whitlock <kernel@mattwhitlock.name>,
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

On Wed, 19 Jul 2023 at 12:44, Matthew Wilcox <willy@infradead.org> wrote:
>
> So what's the API that provides the semantics of _copying_?

It's called "read()" and "write()".

Seriously.

The *ONLY* reason for splice() existing is for zero-copy. If you don't
want zero-copy (aka "copy by reference"), don't use splice.

Stop arguing against it. If you don't want zero-copy, you use read()
and write(). It really is that simple.

And no, we don't start some kind of crazy "versioned zero-copy with
COW". That's a fundamental mistake. It's a mistake that has been done
- several times - and made perhaps most famous by Hurd, that made that
a big thing.

And yes, this has been documented *forever*. It may not have been
documented on the first line, because IT WAS SO OBVIOUS. The whole
reason splice() is fast is because it avoids the actual copy, and does
a copy-by-reference.

That's still a copy. But a copy-by-reference is a special thing. If
you don't know what copy-by-reference is, or don't want it, don't use
splice().

I don't know how many different ways I can say the same thing.

IF YOU DON'T WANT ZERO-COPY, DON'T USE SPLICE.

IF YOU DON'T UNDERSTAND THE DIFFERENCE BETWEEN COPY-BY-VALUE AND
COPY-BY-REFERENCE, DON'T USE SPLICE.

IF YOU DON'T UNDERSTAND THE *POINT* OF SPLICE, DON'T USE SPLICE.

It's kind of a bit like pointers in C: if you don't understand
pointers but use them anyway, you're going to have a hard time. That's
not the fault of the pointers. Pointers are very very powerful. But if
you are used to languages that only do copy-by-value, you are going to
think they are bad things.

                  Linus
