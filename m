Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5579575A2FB
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 02:00:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbjGTAAl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 20:00:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjGTAAj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 20:00:39 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9601A19B2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 17:00:38 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-9891c73e0fbso56514866b.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 17:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1689811237; x=1692403237;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=COIx9PJNSvI0bd/8+R1trZjf1/QUjd+w4gApApqhVyk=;
        b=NnlmABdlgfcyYyH79U9UQWX+O0tKiipVmdb85nK2bSBM/aWDj7mfd5ylC1O1ykowNM
         dAl9apPj9FXotYDS1432ThAXZMYxNGpHTSbh9KsjkV0XmbZZyf7Y2IsAt+Fdr6OW9ABq
         5ZVvc0YbfLwtACU4geOMBBYfD2Y89gX2Tgt4E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689811237; x=1692403237;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=COIx9PJNSvI0bd/8+R1trZjf1/QUjd+w4gApApqhVyk=;
        b=hY/ZizpX8XxpJdRMZfq8efciz6wgfwYniSsd+hnfWhJH7XU2X6MeAU4ovvNYGLc15g
         nEl2VsTpjDtQ4aD8qQRrhyj27sSIz1iFfagIsv/Ekp6X8P0L6YpZcKChByt1U/5nadVH
         8Me1tW2FaZLej0nB93kpXcI8zb/Q7KI4evPXHxGG3Meso86mGJ9SWp7ds5pvohGHvtGi
         1hLPiRgipJdbWxL58Lunb3UNjus39oOvacctGXtI2BaBChdScLmV/LFpXJk5ON5jznkV
         hkkFOn4l+ycEJgI4nQ81GvaV48Or7o0QJEV72ToDodPpH30Dx75mnQUrfepHDqVBPogZ
         Y3oQ==
X-Gm-Message-State: ABy/qLbOOc/z4a4cyOEqDfYJKv232i/lWWbcq1Z00pD7gt9NfLbp1Fpg
        0Vdl4U39ShEZzWLBjm+t7wlrbnl2UeWDud6xJEkYJDnv
X-Google-Smtp-Source: APBJJlF8YRHmdl0dgdPdvgiQoTLs4RvoYzkUAORo22q2rQ7zOl3MwH42vU/ezNu+5AVvrzqRbyXaiQ==
X-Received: by 2002:a17:907:c29:b0:993:f664:ce25 with SMTP id ga41-20020a1709070c2900b00993f664ce25mr4782873ejc.19.1689811236990;
        Wed, 19 Jul 2023 17:00:36 -0700 (PDT)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id mh11-20020a170906eb8b00b0099315454e76sm2951565ejb.211.2023.07.19.17.00.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jul 2023 17:00:36 -0700 (PDT)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-51e344efd75so567743a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 17:00:34 -0700 (PDT)
X-Received: by 2002:a50:fc13:0:b0:51d:914a:9f3d with SMTP id
 i19-20020a50fc13000000b0051d914a9f3dmr3806792edr.10.1689811234438; Wed, 19
 Jul 2023 17:00:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230629155433.4170837-1-dhowells@redhat.com> <20230629155433.4170837-2-dhowells@redhat.com>
 <CAJfpegsJuvXJDcXpo9T19Gw0tDuvyOJdv44Y2bt04MEf1JLxGg@mail.gmail.com>
 <c634a18e-9f2b-4746-bd8f-aa1d41e6ddf7@mattwhitlock.name> <CAJfpegvq4M_Go7fHiWVBBkrK6h4ChLqQTd0+EOKbRWZDcVerWA@mail.gmail.com>
 <ZLg9HbhOVnLk1ogA@casper.infradead.org> <CAHk-=wiq95bWiWLyz96ombPfpy=PNrc2KKyzJ2d+WMrxi6=OVA@mail.gmail.com>
 <6609f1b8-3264-4017-ac3c-84a01ea12690@mattwhitlock.name> <CAHk-=wh7OY=7ocTFY8styG8GgQ1coWxds=b09acHZG4t36OxWg@mail.gmail.com>
 <0d10033a-7ea1-48e3-806b-f74000045915@mattwhitlock.name>
In-Reply-To: <0d10033a-7ea1-48e3-806b-f74000045915@mattwhitlock.name>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 19 Jul 2023 17:00:17 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgwdG9KnADHQg9_F9vXFMKYFRcbSyb=0btFnzr2ufpQ6Q@mail.gmail.com>
Message-ID: <CAHk-=wgwdG9KnADHQg9_F9vXFMKYFRcbSyb=0btFnzr2ufpQ6Q@mail.gmail.com>
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
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Jul 2023 at 16:41, Matt Whitlock <kernel@mattwhitlock.name> wrote:
>
> Then that is my request. This entire complaint/discussion/argument would
> have been avoided if splice(2) had contained a sentence like this one from
> sendfile(2):
>
> "If out_fd refers to a socket or pipe with zero-copy support, callers must
> ensure the transferred portions of the file referred to by in_fd remain
> unmodified until the reader on the other end of out_fd has consumed the
> transferred data."
>
> That is a clear warning of the perils of the implementation under the hood,
> and it could/should be copied, more or less verbatim, to splice(2).

Ack. Internally in the kernel, the two really have always been more or
less of intermingled.

In fact, I think splice()/sendfile()/tee() could - and maybe should -
actually be a single man-page to make it clear that they are all
facets of the same thing.

The issues with TCP_CORK exist for splice too, for example, for
exactly the same reasons.

And while SPLICE_F_MORE exists, it only deals with multiple splice()
calls, it doesn't deal with the "I wrote a header before I even
started using splice()" case that is the one that is mentioned for
sendfile().

Or course, technically TCP_CORK exists for plain write() use as well,
but there the portable and historical fix is simply to use writev()
and send it all in one go.

So it's hopefully only when you use sendfile() and splice() that you
end up with "oh, but I have multiple different *kinds* of sources, and
I want to cork things until I've dealt with them all".

            Linus
