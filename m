Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86E227ECC12
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 20:26:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233640AbjKOT0q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 14:26:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233951AbjKOT0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 14:26:31 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBD491AB
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 11:26:24 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-9e62f903e88so4328766b.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 11:26:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1700076383; x=1700681183; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=shjpDJFgEA7bY447zVelsVqtgQ9wtQbPGXjY7wm8MLo=;
        b=TfcjMdv8W3ShLC3M03Es+pC07ZaE2B/imbUN0QLCywJpyz/MMWpAxAX6Z0M/V4ZSO4
         Yg/Ol2gY0NcRh51IPAkRjKK6TvJJ1iWKLSS8WL1qvrtR6cE6xYaxCALuuQAVs9RchL8C
         nYJM1GxM2pX+XuJeethkfIu1QNxhABUVr7ivI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700076383; x=1700681183;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=shjpDJFgEA7bY447zVelsVqtgQ9wtQbPGXjY7wm8MLo=;
        b=b9a8yq7FdmlMWyIKU6Pp5FL91Vii5Y9Rg8iIm1OdndHmxw7oWSkq5WIUZcpPJmNhFm
         fv4Co0qR+kaA6cnGVMXLP7mOjKCTwjVRJui6eCMlvbIylJ3rQkGOVjlom1SmIBQb7xfZ
         a4woX5EagdUe5yedTV+/mIOPoQCIBGx/6f947goKc3dQGNKnUvu5j2G1rFTLVXJFph4z
         9sr2FgzLkJR5kzcgWhRfvey07aoMvHG6oj5Mb+qBZjR99wj1Uy6CMlCQvdN15YOzEyvS
         zuT+QhUzP9sH3KJWflX8tuv8Yf3phAAPhKS0YKxHA4YNJBy2BcwOwFEkxCrf3to9QXjU
         BMDg==
X-Gm-Message-State: AOJu0Yw2yEWOWett2zgspvRZOFawI0pwKw3Yyk4JivkXtdAYkqBkZBmU
        fTaUUHG8RvMZ6PalndE2WkWoYk5T7MPtisHzMPZiqL7a
X-Google-Smtp-Source: AGHT+IEN8vgyj+8G5RcwteFz19O/6DHahY+1Bm/LEjookeDkVTXn28IBmPdSlT9qayTAaBpT99A0og==
X-Received: by 2002:a17:906:855:b0:9ae:82b4:e309 with SMTP id f21-20020a170906085500b009ae82b4e309mr10044761ejd.0.1700076383315;
        Wed, 15 Nov 2023 11:26:23 -0800 (PST)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id c7-20020a170906340700b009a9fbeb15f2sm7392726ejb.62.2023.11.15.11.26.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Nov 2023 11:26:20 -0800 (PST)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5435336ab0bso68438a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 11:26:19 -0800 (PST)
X-Received: by 2002:aa7:d545:0:b0:543:6f8e:58ee with SMTP id
 u5-20020aa7d545000000b005436f8e58eemr8359172edr.41.1700076379472; Wed, 15 Nov
 2023 11:26:19 -0800 (PST)
MIME-Version: 1.0
References: <202311061616.cd495695-oliver.sang@intel.com> <3865842.1700061614@warthog.procyon.org.uk>
 <CAHk-=whM-cEwAsLtKsf5dYwV7nDTaRv1bUKLVBstMAQBug24uQ@mail.gmail.com>
 <CAHk-=wjCUckvZUQf7gqp2ziJUWxVpikM_6srFdbcNdBJTxExRg@mail.gmail.com>
 <CAHk-=wjhs6uuedgz-7HbcPtirEq+vvjJBY-M2zyteJwBhOMZhg@mail.gmail.com> <20231115190938.GGZVUXcuUjI3i1JRAB@fat_crate.local>
In-Reply-To: <20231115190938.GGZVUXcuUjI3i1JRAB@fat_crate.local>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 15 Nov 2023 14:26:02 -0500
X-Gmail-Original-Message-ID: <CAHk-=wh0TcXyGmKHfs+Xe=5Sd5bNn=NNV9CEtOy_tbyHAAmk9g@mail.gmail.com>
Message-ID: <CAHk-=wh0TcXyGmKHfs+Xe=5Sd5bNn=NNV9CEtOy_tbyHAAmk9g@mail.gmail.com>
Subject: Re: [linus:master] [iov_iter] c9eec08bac: vm-scalability.throughput
 -16.9% regression
To:     Borislav Petkov <bp@alien8.de>
Cc:     David Howells <dhowells@redhat.com>,
        kernel test robot <oliver.sang@intel.com>,
        oe-lkp@lists.linux.dev, lkp@intel.com,
        linux-kernel@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Christian Brauner <christian@brauner.io>,
        Matthew Wilcox <willy@infradead.org>,
        David Laight <David.Laight@aculab.com>, ying.huang@intel.com,
        feng.tang@intel.com, fengwei.yin@intel.com
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

On Wed, 15 Nov 2023 at 14:10, Borislav Petkov <bp@alien8.de> wrote:
>
> > Borislav, see
> >
> >     https://lore.kernel.org/all/CAHk-=wjCUckvZUQf7gqp2ziJUWxVpikM_6srFdbcNdBJTxExRg@mail.gmail.com/
> >
> > for some truly crazy code generation by gcc.
>
> Yeah, lemme show that to gcc folks. That asm is with your compiler,
> right? Version?

That was with gcc version 13.2.1.

Note that I only see that crazy thing in lib/iov_iter.s, so I really
do think it has something to do with inlining __builtin_memcpy()
behind a conditional function pointer.

In normal cases, gcc seems to just do the obvious thing (ie expand a
small constant-sized memcpy inline, or just call the external 'memcpy'
function.

So it's some odd pattern that triggers that "expand non-constant
memcpy inline". And once that happens, the odd code generation is
still a bit odd but is at least explicable.

That "do first word by hand, then do aligned 'rep movsq' on top of it"
pattern is weird, but we've seen some similar strange patterns in
hand-written memcpy (eg "use two overlapping 8-byte writes to handle
the 8-15 byte case").

So the real issue is that we don't want an inlined memcpy at all,
unless it's the simple constant-sized case that has been turned into
individual moves with no loop.

Or it's a "rep movsb" with FSRM as a CPUID-based alternative, of course.

                 Linus
