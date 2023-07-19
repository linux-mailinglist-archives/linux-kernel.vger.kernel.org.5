Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84E95759ED0
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 21:37:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230260AbjGSThT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 15:37:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbjGSThE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 15:37:04 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 133B3268B
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 12:36:22 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2b708e49059so115236321fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 12:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1689795345; x=1692387345;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rtl6gXXMYsoBnIpPYfSTqQ6nm1s8Hn5GW+fEct1ALRE=;
        b=Zhw4JJ4K/38BOlZM21pHWDopKnx38TCDNfnXcKZHpT7uRqEqXE9WONINOAv9x6yiUj
         z+XUsIZz2aKcBKEiQPUdSZ4hejspiaLEcEvoQjmfzw/3G5HXTxgK4A9mvFZ//TIcP2A6
         YyRF2CDGgYyMaztEqeHFfJfxRmV3g4oGKIn6g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689795345; x=1692387345;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rtl6gXXMYsoBnIpPYfSTqQ6nm1s8Hn5GW+fEct1ALRE=;
        b=l5T0SHEHPQPRM3HEhjjs7kIvb5FZliC4Yz28ObZks43GYu2RiZnUOELd2+kXvsd1Fp
         d6zILais8A38SllOZ6etEw5UiELVPep0EvRsvOVOHKBuDHBPnCuXwCRPKsTxhJjx/oZ+
         0UwOFkqq1ae0kUDFr2uZaACNrfr79+2WhAwEGQXbT51Km2JigVqxbEDbyxx5awaMD9Ms
         JfhHwnpjHpxTKVLSXN0d1UOsSTbU4XKTAs7zDC0NImOQkkaYBoWbhdoOMMGNCviHZv9j
         H1YXmUBg5HqKAyqoLE31IPYLp4tW6LwukO/C9HcEi3rJeeCxd5MFXqII5tDa4BmRl0bT
         xHlQ==
X-Gm-Message-State: ABy/qLYd7a58ncqe3fSYgkPT3yV1fIu8qVBq/n3h/wWHoIXN+XhX43Aa
        NJjkHAgz7kgdry9uCmT0PgM+GiYfWf0XQb3QdZWeaA==
X-Google-Smtp-Source: APBJJlF263loCbf4G/vbjQ8OkGORJrA6h2pTRLBd08SnNbJHsNdGQLjuleOM0+lhq7ys4UZ/gSu7iS5raBbyA9YXqQA=
X-Received: by 2002:a2e:9584:0:b0:2b6:e2c1:980f with SMTP id
 w4-20020a2e9584000000b002b6e2c1980fmr643994ljh.36.1689795345357; Wed, 19 Jul
 2023 12:35:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230629155433.4170837-1-dhowells@redhat.com> <20230629155433.4170837-2-dhowells@redhat.com>
 <CAJfpegsJuvXJDcXpo9T19Gw0tDuvyOJdv44Y2bt04MEf1JLxGg@mail.gmail.com> <c634a18e-9f2b-4746-bd8f-aa1d41e6ddf7@mattwhitlock.name>
In-Reply-To: <c634a18e-9f2b-4746-bd8f-aa1d41e6ddf7@mattwhitlock.name>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 19 Jul 2023 21:35:33 +0200
Message-ID: <CAJfpegvq4M_Go7fHiWVBBkrK6h4ChLqQTd0+EOKbRWZDcVerWA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/4] splice: Fix corruption of spliced data after
 splice() returns
To:     Matt Whitlock <kernel@mattwhitlock.name>
Cc:     David Howells <dhowells@redhat.com>, netdev@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, linux-fsdevel@kvack.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Jul 2023 at 19:59, Matt Whitlock <kernel@mattwhitlock.name> wrot=
e:
>
> On Wednesday, 19 July 2023 06:17:51 EDT, Miklos Szeredi wrote:
> > On Thu, 29 Jun 2023 at 17:56, David Howells <dhowells@redhat.com> wrote=
:
> >>
> >> Splicing data from, say, a file into a pipe currently leaves the sourc=
e
> >> pages in the pipe after splice() returns - but this means that those p=
ages
> >> can be subsequently modified by shared-writable mmap(), write(),
> >> fallocate(), etc. before they're consumed.
> >
> > What is this trying to fix?   The above behavior is well known, so
> > it's not likely to be a problem.
>
> Respectfully, it's not well-known, as it's not documented. If the splice(=
2)
> man page had mentioned that pages can be mutated after they're already
> ostensibly at rest in the output pipe buffer, then my nightly backups
> wouldn't have been incurring corruption silently for many months.

splice(2):

       Though we talk of copying, actual copies are generally avoided.
The kernel does this by implementing a pipe buffer as a set  of
refer=E2=80=90
       ence-counted  pointers  to  pages  of kernel memory.  The
kernel creates "copies" of pages in a buffer by creating new pointers
(for the
       output buffer) referring to the pages, and increasing the
reference counts for the pages: only pointers are copied, not the
pages of the
       buffer.

While not explicitly stating that the contents of the pages can change
after being spliced, this can easily be inferred from the above
semantics.

Thanks,
Miklos
