Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26DCA7AB99E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 20:51:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233729AbjIVSvr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 14:51:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjIVSvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 14:51:46 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B85BA9
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 11:51:40 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-501eec0a373so4411823e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 11:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1695408698; x=1696013498; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ah1VmvWzOnKnkyFlWIeYuTucJzJ+3NRjWIwcRi6c2zI=;
        b=K206OWkq6kaxl7G8Ji8lQHvJt62F3PD1ZPRGcCnu8AntaKpKUZwGksoriGB54WH/rR
         xSixvOssELn7Vsr9eG28bj5gUY6AOI0R9qRAJY4C3AFBlzJb7O8rOX00tzG6MgBzpKXh
         Mmclg9La7wY5fKGsBa1y7iFIC82FJlvYNJybM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695408698; x=1696013498;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ah1VmvWzOnKnkyFlWIeYuTucJzJ+3NRjWIwcRi6c2zI=;
        b=pmNSiX27RA/zK45lfXylmhLGm+pdQcS5Jiq/z00l9EsfCg/g9RsfxQflCIFHT98+P8
         sTYD8+d0XzZPu0YiQx9KedK/Bf/OZcLyC2JtJwhqhI3IryRGJ8nE4EIvk/0iQFCAFYm8
         B2V0w2CMA7nSpohCcz/4sfkiFkLykN1FoVdB5ViRWq6+cK+LxDC6/2J6W+YNb4ojwnH6
         F+0oXkGJ7oQkOZMWwWN46DFNeM8nZOgjBa2nl5Jl7yfXN95koskLSdKA6Nezg7ZOdJ2o
         za/aggX6xQYNUf6RGGf3tDP8GaquQlByMotWxsuSXCDBmRlBKKoHLz+y6pr7ovI99TjG
         UGKQ==
X-Gm-Message-State: AOJu0Yyop0p7P8LFFAfHX7fHgIuL+obrcIe68x/5FGGo1BH0gB4X5MK2
        GCafGCGQgkFRGVZhQVnWCujrtSM2yPn+3t04q8q/wo2N
X-Google-Smtp-Source: AGHT+IGPw2rtvah69xYK94UX/xkLmHBOU7yvFzKn2Y3C8npvvHdq4nXX+NmKln4HoVAIC3njKbPVGw==
X-Received: by 2002:a19:6506:0:b0:503:1bb0:a658 with SMTP id z6-20020a196506000000b005031bb0a658mr271777lfb.32.1695408698083;
        Fri, 22 Sep 2023 11:51:38 -0700 (PDT)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id v22-20020a056402185600b0052a3aa50d72sm2576571edy.40.2023.09.22.11.51.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Sep 2023 11:51:37 -0700 (PDT)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-52889bc61b6so3068731a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 11:51:37 -0700 (PDT)
X-Received: by 2002:aa7:c98b:0:b0:533:310b:a8aa with SMTP id
 c11-20020aa7c98b000000b00533310ba8aamr309019edt.13.1695408696292; Fri, 22 Sep
 2023 11:51:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230922120227.1173720-1-dhowells@redhat.com> <20230922120227.1173720-10-dhowells@redhat.com>
In-Reply-To: <20230922120227.1173720-10-dhowells@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 22 Sep 2023 11:51:19 -0700
X-Gmail-Original-Message-ID: <CAHk-=whyv0cs056T8TvY1f0nOf+Gsb6oRWetxt+LiFZUD4KQCw@mail.gmail.com>
Message-ID: <CAHk-=whyv0cs056T8TvY1f0nOf+Gsb6oRWetxt+LiFZUD4KQCw@mail.gmail.com>
Subject: Re: [PATCH v6 09/13] iov_iter: Add a kernel-type iterator-only
 iteration function
To:     David Howells <dhowells@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>,
        Christian Brauner <christian@brauner.io>,
        David Laight <David.Laight@aculab.com>,
        Matthew Wilcox <willy@infradead.org>,
        Jeff Layton <jlayton@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-mm@kvack.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Sept 2023 at 05:03, David Howells <dhowells@redhat.com> wrote:
>
> Add an iteration function that can only iterate over kernel internal-type
> iterators (ie. BVEC, KVEC, XARRAY) and not user-backed iterators (ie. UBUF
> and IOVEC).  This allows for smaller iterators to be built when it is known
> the caller won't have a user-backed iterator.

This one is pretty ugly, and has no actual users.

Without even explaining why we'd care about this abomination, NAK.

If we actyually have some static knowledge of "this will only use
iterators X/Y/Z", then we should probably pass that in as a constant
bitmask to the thing, instead of this kind of "kernel only" special
case.

But even then, we'd want to have actual explicit use-cases, not a
hypothetical "if you have this situation here's this function".

                 Linus
