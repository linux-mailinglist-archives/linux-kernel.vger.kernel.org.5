Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 539267A2D46
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 04:04:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234266AbjIPCDv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 22:03:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236656AbjIPCDS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 22:03:18 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91E7C2735
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 19:01:34 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2bb9a063f26so43727311fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 19:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1694829692; x=1695434492; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KAndjmnR48WE2pCpGu0IjwxW3tK8pfCDH+nJM9LoF4g=;
        b=UU/zFBi267VWGewKzj3NnFippMQA7FWpN6AdgfauBJCkHA5tgrUe8LbkdFzwcyomGH
         vg88ayiWthiGiGokkBRE3nJ1sx9LcLBtLYKDhbLrFaVwJJIYDaM9XlwQuZqQa3P6+c3r
         tJwuZZPSD9tEaM28+N3oj7JLXPw1Oi3eal/lI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694829692; x=1695434492;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KAndjmnR48WE2pCpGu0IjwxW3tK8pfCDH+nJM9LoF4g=;
        b=f/OjCOpwgAOvx53TAT+CWfm+xJBl+fARUYxw3XhZz1Pzp288NV1I/LoVLHSbQtpQQo
         8wEu7AhuzctcJbZo0INioZL0yWXG963AkCSQ6H6l334vUSZ2VK8sWaCi3CBHulg3AOw4
         nnQCr2IuA9Z5kZL0DkODljVEPuqIYnk/xWXs1za5eOYKYiUyyhbpx/OrIu8JgFJml6gj
         4X2cB/cRXiM9wqOSlXrRzuNdrTQd//5iQrm0jdYZssIk4JYPCYSNM+Vo6nR5RWPm5zSG
         AumGaZN/+C3SCRvbKGUbujmj66VIJQXsHw8NVlUaVn+03acXhdmPMaUZqI/Ik7PSg/u2
         K/9Q==
X-Gm-Message-State: AOJu0Yyi+aer+Ak9MAY78v+k9kil6GnBGVDaGV4RkGw+mZj2k3G1wZNF
        R/fwc4oFS1TWXx07M/sbKS7UX+BOrugyLlHS4jrhVw4u
X-Google-Smtp-Source: AGHT+IFTSzmdsfr6WoEY02yMlvdE07IzVbFztApvN9rn0DcuvGHute1k2uKHmn3vMA4w8uUdsqidFA==
X-Received: by 2002:a2e:9014:0:b0:2bf:a0d1:b122 with SMTP id h20-20020a2e9014000000b002bfa0d1b122mr2912976ljg.5.1694829692389;
        Fri, 15 Sep 2023 19:01:32 -0700 (PDT)
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com. [209.85.218.46])
        by smtp.gmail.com with ESMTPSA id ck19-20020a170906c45300b0099297c99314sm3108240ejb.113.2023.09.15.19.01.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Sep 2023 19:01:31 -0700 (PDT)
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-9a9f139cd94so356357566b.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 19:01:31 -0700 (PDT)
X-Received: by 2002:a17:906:100b:b0:9a2:28dc:4168 with SMTP id
 11-20020a170906100b00b009a228dc4168mr2220828ejm.61.1694829690885; Fri, 15 Sep
 2023 19:01:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230915183707.2707298-1-willy@infradead.org> <20230915183707.2707298-9-willy@infradead.org>
 <CAHk-=wgBUvM7tc70AAvUw+HHOo6Q=jD4FVheFGDCjNaK3OCEGA@mail.gmail.com> <ZQT4/gA4vIa/7H6q@casper.infradead.org>
In-Reply-To: <ZQT4/gA4vIa/7H6q@casper.infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 15 Sep 2023 19:01:14 -0700
X-Gmail-Original-Message-ID: <CAHk-=whbj+pVGhJTcQCLhY8KZJNomWOKM=s-GZSpK_G=G4fXEA@mail.gmail.com>
Message-ID: <CAHk-=whbj+pVGhJTcQCLhY8KZJNomWOKM=s-GZSpK_G=G4fXEA@mail.gmail.com>
Subject: Re: [PATCH 08/17] alpha: Implement xor_unlock_is_negative_byte
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Sept 2023 at 17:38, Matthew Wilcox <willy@infradead.org> wrote:
>
> On Fri, Sep 15, 2023 at 05:27:17PM -0700, Linus Torvalds wrote:
> > On Fri, 15 Sept 2023 at 11:37, Matthew Wilcox (Oracle)
> > <willy@infradead.org> wrote:
> > >
> > > +       "1:     ldl_l %0,%4\n"
> > > +       "       xor %0,%3,%0\n"
> > > +       "       xor %0,%3,%2\n"
> > > +       "       stl_c %0,%1\n"
> >
> > What an odd thing to do.
> >
> > Why don't you just save the old value? That double xor looks all kinds
> > of strange, and is a data dependency for no good reason that I can
> > see.
> >
> > Why isn't this "ldl_l + mov %0,%2 + xor + stl_c" instead?
> >
> > Not that I think alpha matters, but since I was looking through the
> > series, this just made me go "Whaa?"
>
> Well, this is my first time writing Alpha assembler ;-)  I stole this
> from ATOMIC_OP_RETURN:
>
>         "1:     ldl_l %0,%1\n"                                          \
>         "       " #asm_op " %0,%3,%2\n"                                 \
>         "       " #asm_op " %0,%3,%0\n"                                 \

Note how that does "orig" assignment first (ie the '%2" destination is
the first instruction), unlike your version.

So in that ATOMIC_OP_RETURN, it does indeed do the same ALU op twice,
but there's no data dependency between the two, so they can execute in
parallel.

> but yes, mov would do the trick here.  Is it really faster than xor?

No, I think "mov src,dst" is just a pseudo-op for "or src,src,dst",
there's no actual "mov" instruction, iirc.

So it's an ALU op too.

What makes your version expensive is the data dependency, not the ALU op.

So the *odd* thing is not that you have two xor's per se, but how you
create the original value by xor'ing the value once, and then xoring
the new value with the same mask, giving you the original value back -
but with that odd data dependency so that it won't schedule in the
same cycle.

Does any of this matter? Nope. It's alpha. There's probably a handful
of machines, and it's maybe one extra cycle. It's really the oddity
that threw me.

In ATOMIC_OP_RETURN, the reason it does that op twice is simply that
it wants to return the new value. But you literally made it return the
*old* value by doing an xor twice in succession, which reverses the
bits twice.

Was that really what you intended?

               Linus
