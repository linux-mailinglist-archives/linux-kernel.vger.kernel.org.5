Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71FAF7EC90A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 17:59:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbjKOQ7P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 11:59:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjKOQ7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 11:59:14 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62D7218E
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 08:59:09 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2c788f5bf53so81585531fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 08:59:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1700067547; x=1700672347; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ac4Ls6gftQvQgbcRf5XLhX5PwcgnIwraX4CtQN05HrE=;
        b=ISToxIFwv32EAIpVkhDLFkDZCmzsjj7iEL7z4lL9dWknjh7m/SwyKBjF4gmLs7MbOp
         BBQDAjbMS1dSLB0rOsfeRW76HT+wYD78wxoI5/RfwL5PA07Is3NMz1Y/R2l8pz+ayAe0
         edNZ/avSIq+f+GVmo8imQDB/SOG9TedAuXbl0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700067547; x=1700672347;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ac4Ls6gftQvQgbcRf5XLhX5PwcgnIwraX4CtQN05HrE=;
        b=NVHGl7eH8Dibrh0m+WxJmF4gS37wizhWGLrU+D7XdN1sosYzn9mZXSgRDPcomPj9+2
         xnUbNeqTjQfvSZRALK3qgy4RRAvuH/rK0ZCQ8gGzEyyhVk2NEP5mR9qwlTv9OA4es1hg
         F8R7w2qLVH37PCxilfIEhwSPBexf/ex37/dJ+CqD/wauCV510UoTe9eH9O92954r4PhP
         Z3NshZL0T8bMWwP8ZHaG+8FkUWdnq/RKlWLH7ZDugUy1MdcH+oKF9uSOXZ6LyR/WrWca
         /h8DHXMiYA31RrmYKpPc209H7NtjdpC+63nMfMTznaEtlDqd9CHm6x6zLMeVgn0Hz871
         LXfQ==
X-Gm-Message-State: AOJu0YwanVkPdnICPxNzXY3zso/VAgXwJWGoTeKkJxlhQqs83yUhbOOm
        6MuoLXV1thqU9W465yZHeZyORRMTIP4Hr+/W8nopg8Hg
X-Google-Smtp-Source: AGHT+IFthxDTTt0dRR1ix11kTKn1F3ponp3MiFCnga+UVQIfDdsEYEzsvpJ7OGuxvgNMazSDfYdqbw==
X-Received: by 2002:a05:651c:1549:b0:2c5:2813:5538 with SMTP id y9-20020a05651c154900b002c528135538mr5617596ljp.21.1700067547445;
        Wed, 15 Nov 2023 08:59:07 -0800 (PST)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id i19-20020a2e8093000000b002c596731419sm1710679ljg.23.2023.11.15.08.59.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Nov 2023 08:59:06 -0800 (PST)
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-50943ccbbaeso10007901e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 08:59:06 -0800 (PST)
X-Received: by 2002:a19:7119:0:b0:507:9787:6773 with SMTP id
 m25-20020a197119000000b0050797876773mr9107681lfc.36.1700067545585; Wed, 15
 Nov 2023 08:59:05 -0800 (PST)
MIME-Version: 1.0
References: <20231115154946.3933808-1-dhowells@redhat.com> <20231115154946.3933808-6-dhowells@redhat.com>
 <CAHk-=wgHciqm3iaq6hhtP64+Zsca6Y6z5UfzHzjfhUhA=jP0zA@mail.gmail.com> <3936726.1700066370@warthog.procyon.org.uk>
In-Reply-To: <3936726.1700066370@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 15 Nov 2023 11:58:48 -0500
X-Gmail-Original-Message-ID: <CAHk-=whEj_+oP0mwNr7eArnOzWf_380-+-6LD9RtQXVs29fYJQ@mail.gmail.com>
Message-ID: <CAHk-=whEj_+oP0mwNr7eArnOzWf_380-+-6LD9RtQXVs29fYJQ@mail.gmail.com>
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
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Nov 2023 at 11:39, David Howells <dhowells@redhat.com> wrote:
>
> I was trying to make it possible to do these tests before starting userspace
> as there's a good chance that if the UBUF/IOVEC iterators don't work right
> then your system can't be booted.

Oh, I don't think that any unit test should bother to check for that
kind of catastrophic case.

If something is so broken that the kernel doesn't boot properly even
into some basic test infrastructure, then bisection will trivially
find where that breakage was introduced.

And if it's something as core as the iov iterators, it won't even get
past the initial developer unless it's some odd build system
interaction.

So extreme cases aren't even worth checking for. What's worth testing
is "the system boots and works, but I want to check the edge cases".

IOW, when it comes to things like user copies, it's things like
alignment, and the page fault edge cases with EFAULT in particular.
You can easily get the return value wrong for a user copy that ends up
with an unaligned fault at the end of the last mapped page. Everything
normal will still work fine, because nobody does something that odd.

But those are best handled as user mode tests.

           Linus
