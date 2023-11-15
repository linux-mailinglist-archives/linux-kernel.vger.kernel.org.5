Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DD367EC834
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 17:12:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232391AbjKOQMl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 11:12:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232405AbjKOQMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 11:12:39 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA2F7FA
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 08:12:35 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-9df8d0c2505so209756666b.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 08:12:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1700064754; x=1700669554; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1ab4jnXj8Bjx21zU5WbouPNL4gj/h303kBNvkdQgDmY=;
        b=B2OkhE7x05d4w3oQTaBkB6Io4Ug4UjGVP9vrDzCyeOtkX22hK3oo0Wb1PE1NUihxxo
         4CDEkzae3AL2iJ31u2arE6FuhIui1xKbXOuWOMvuLcWLy28X4wTLvOutjRnooR/Vx0z8
         JiK+UxgfvX6gGgcp9y6taxYXzgG9i8tpqq+YQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700064754; x=1700669554;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1ab4jnXj8Bjx21zU5WbouPNL4gj/h303kBNvkdQgDmY=;
        b=q9u2C9YHQHnbbKGd1hNWnvTgen1HB1a1lHZH+++YL4ox6Yf6Sp4iU5QRVmld7lh4tp
         aAX1Jzsddat1r5Su9Zo/7j2tfcADb76o39g2SMCVVzInbte4buSuqk0s4VjLbWHsY+Ef
         f/f7j76koQTasayON7+rBeaWFWN0lt3+7fMtb+uO1+/noI0RmqbMu/kVyAQUIirL8MRF
         4T1cik8nnUcwy7fEdE2j760H8qZovpUbbwdxAsRqDmR1dIWE237/twD5tc8tL8xvDNOS
         QI6fo9XKW5/cWIYvOM7RxrrFIRb9KTw3C/tifMhSrZXlb3GHKL/zTYbLTWAkMTEVCSXv
         M1VA==
X-Gm-Message-State: AOJu0YysbM/hWW+xGzTZ08ahBpe/TnbU/jaJvvh9Hta/JMsvHw4FjyPh
        81Xoe1fwVENaPuyof8FvY7dJI2leKUrl2VRr8t1EZvWi
X-Google-Smtp-Source: AGHT+IEvZ+kvz21C3hlbVUAH8qlLc2TIFONXp5yeQ5Mj88bUzaU+532IKS+aIhpUzQRXrEfa5w377Q==
X-Received: by 2002:a17:906:730f:b0:9b2:b15b:383d with SMTP id di15-20020a170906730f00b009b2b15b383dmr6766559ejc.11.1700064754378;
        Wed, 15 Nov 2023 08:12:34 -0800 (PST)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id i11-20020a170906264b00b0099bd5d28dc4sm7302909ejc.195.2023.11.15.08.12.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Nov 2023 08:12:34 -0800 (PST)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-540c54944c4so2072910a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 08:12:34 -0800 (PST)
X-Received: by 2002:aa7:da07:0:b0:542:ff1b:6c7a with SMTP id
 r7-20020aa7da07000000b00542ff1b6c7amr5958727eds.9.1700064753769; Wed, 15 Nov
 2023 08:12:33 -0800 (PST)
MIME-Version: 1.0
References: <20231115154946.3933808-1-dhowells@redhat.com> <20231115154946.3933808-6-dhowells@redhat.com>
In-Reply-To: <20231115154946.3933808-6-dhowells@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 15 Nov 2023 11:12:17 -0500
X-Gmail-Original-Message-ID: <CAHk-=wgHciqm3iaq6hhtP64+Zsca6Y6z5UfzHzjfhUhA=jP0zA@mail.gmail.com>
Message-ID: <CAHk-=wgHciqm3iaq6hhtP64+Zsca6Y6z5UfzHzjfhUhA=jP0zA@mail.gmail.com>
Subject: Re: [PATCH v3 05/10] iov_iter: Create a function to prepare userspace
 VM for UBUF/IOVEC tests
To:     David Howells <dhowells@redhat.com>
Cc:     Christian Brauner <christian@brauner.io>,
        Jens Axboe <axboe@kernel.dk>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>,
        David Laight <David.Laight@aculab.com>,
        Matthew Wilcox <willy@infradead.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        David Gow <davidgow@google.com>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-mm@kvack.org,
        netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, loongarch@lists.linux.dev,
        linux-s390@vger.kernel.org
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

On Wed, 15 Nov 2023 at 10:50, David Howells <dhowells@redhat.com> wrote:
>
> This requires access to otherwise unexported core symbols: mm_alloc(),
> vm_area_alloc(), insert_vm_struct() arch_pick_mmap_layout() and
> anon_inode_getfile_secure(), which I've exported _GPL.
>
> [?] Would it be better if this were done in core and not in a module?

I'm not going to take this, even if it were to be sent to me through Christian.

I think the exports really show that this shouldn't be done. And yes,
doing it in core would avoid the exports, but would be even worse.

Those functions exist for setting up user space. You should be doing
this in user space.

I'm getting really fed up with the problems that ther KUnit tests
cause. We have a long history of self-inflicted pain due to "unit
testing", where it has caused stupid problems like just overflowing
the kernel stack etc.

This needs to stop. And this is where I'm putting my foot down. No
more KUnit tests that make up interfaces - or use interfaces - that
they have absolutely no place using.

From a quick look, what you were doing was checking that the patterns
you set up in user space came through ok. Dammit, what's wrong with
just using read()/write() on a pipe, or splice, or whatever. It will
test exactly the same iov_iter thing.

Kernel code should do things that can *only* be done in the kernel.
This is not it.

              Linus
