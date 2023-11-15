Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 038F47ECB01
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 20:10:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbjKOTKF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 14:10:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjKOTKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 14:10:04 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45245E5
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 11:10:01 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-9f27af23443so6541566b.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 11:10:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1700075399; x=1700680199; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=t3Gj/lDYAeGknhoabh8oIVCV+PKddkxsuVMwfg7hA2k=;
        b=SOF6pTR0SYdBwGdDvZb+wZskTsBttY1Fm3z75xCvfHTDeqVm8lub2GNBS9VErlYdnV
         ceHaytz7vwKmUHNfhC5Q3if7ucuaunqoj/XppIoNvE7prLXIT7j0e8/Cnh+zJPkYbCW1
         s4zyiyIVquw2kb6nWIfPi8SrZ2yj7x7avRSHA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700075399; x=1700680199;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t3Gj/lDYAeGknhoabh8oIVCV+PKddkxsuVMwfg7hA2k=;
        b=SSKM5jrFwhi57WzrjX8+QqVI1KVJUIvsZPHzyfDVZTEqA62jqT9zz5dW/Up/M+u8lA
         MSFVcr6jPB4fHeAvybEWjkqHkt1lBAu06Vt8kmL4lEjHW212OoZtHnswywRpsyKlJdZX
         hLgEVeNtLAhuEBgq5Sc5wuS1h2pISt+nztaUpQyOxOmUbRgGMLxwLjJHlQKLP2OMp97r
         DpT0mumuJXnuLekwrUQembrWSToLyKsAjWGNppoqmVOorw6BKFrWanvahYnh6giPImBa
         +mKcHR/ti0IBw436FPPXmWRfCEO6NE7XuixUV8bd5PdvSMD1M0ARP+2CnZ0nKmshm58r
         zWCA==
X-Gm-Message-State: AOJu0YxSm9Oz8cY0EZeN9T3C+f4rFU3Ekr9LraxTr+N5vv46XyILyegi
        B2ksdhRmhcTbEtBd4BS1EmTY10mZEHBGe/cpTAF0V+R/
X-Google-Smtp-Source: AGHT+IHUl+KmwB99xxUBZLXgfHn0hUv3FHG7R/exR5BRr4gcwCtPyDeXPBlR3Mi3udQXaK87B8L/iQ==
X-Received: by 2002:a17:906:6bda:b0:9be:481c:60bf with SMTP id t26-20020a1709066bda00b009be481c60bfmr8821837ejs.55.1700075399314;
        Wed, 15 Nov 2023 11:09:59 -0800 (PST)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id u14-20020a1709064ace00b0099bccb03eadsm7391986ejt.205.2023.11.15.11.09.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Nov 2023 11:09:58 -0800 (PST)
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-53e07db272cso29733a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 11:09:57 -0800 (PST)
X-Received: by 2002:aa7:ca4a:0:b0:540:eb72:baae with SMTP id
 j10-20020aa7ca4a000000b00540eb72baaemr8814139edt.40.1700075397646; Wed, 15
 Nov 2023 11:09:57 -0800 (PST)
MIME-Version: 1.0
References: <202311061616.cd495695-oliver.sang@intel.com> <3865842.1700061614@warthog.procyon.org.uk>
 <CAHk-=whM-cEwAsLtKsf5dYwV7nDTaRv1bUKLVBstMAQBug24uQ@mail.gmail.com>
 <CAHk-=wjCUckvZUQf7gqp2ziJUWxVpikM_6srFdbcNdBJTxExRg@mail.gmail.com>
 <4007890.1700073334@warthog.procyon.org.uk> <CAHk-=whFGA6YPJp3zazUwBG6ort8i34vGv9utYdOgYpekyt++Q@mail.gmail.com>
In-Reply-To: <CAHk-=whFGA6YPJp3zazUwBG6ort8i34vGv9utYdOgYpekyt++Q@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 15 Nov 2023 14:09:40 -0500
X-Gmail-Original-Message-ID: <CAHk-=whtDxahdzn4yLP_3BNb496AQ0y5QrE36JVLUkqRM+un5A@mail.gmail.com>
Message-ID: <CAHk-=whtDxahdzn4yLP_3BNb496AQ0y5QrE36JVLUkqRM+un5A@mail.gmail.com>
Subject: Re: [linus:master] [iov_iter] c9eec08bac: vm-scalability.throughput
 -16.9% regression
To:     David Howells <dhowells@redhat.com>
Cc:     kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev,
        lkp@intel.com, linux-kernel@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Christian Brauner <christian@brauner.io>,
        Matthew Wilcox <willy@infradead.org>,
        David Laight <David.Laight@aculab.com>, ying.huang@intel.com,
        feng.tang@intel.com, fengwei.yin@intel.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,LOTS_OF_MONEY,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Nov 2023 at 13:45, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Do you perhaps have CONFIG_CC_OPTIMIZE_FOR_SIZE set? That makes gcc
> use "rep movsb" - even for small copies that most definitely should
> *not* use "rep movsb".

Just to give some background an an example:

        __builtin_memcpy(dst, src, 24);

with -O2 is done as three 64-bit move instructions (well, three in
both direction, so six instructions total), and with -Os you get

        movl $6, %ecx
        rep movsl

instead.  And no, this isn't all that uncommon, because things like
the above is what happens when you copy a small structure around.

And that "rep movsl" is indeed nice and small, but it's truly
horrendously bad from a performance angle on most cores, compared to
the six instructions that can schedule nicely and take a cycle or two.

There are some other cases of similar "-Os generates unacceptable
code". For example, dividing by a constant - when you use -Os, gcc
thinks that it's perfectly fine to actually generate a divide
instruction, because it is indeed small.

But in most cases you really *really* want to use a "multiply by
reciprocal" even though it generates bigger code. Again, it ends up
depending on microarchitecture, and modern cores tend to do better on
divides, but it's another of those things where saving a copuple of
bytes of code space is not the right choice if it means that you use a
slow divider.

And again, those "divide by constant" often happen in implicit
contexts (ie the constant may be the size of a structure, and the
divide is due to taking a pointer difference). Let's say you have a
structure that isn't a power of two, but is (to pick a random but not
unlikely value) is 56 bytes in size.

The code generation for -O2 is (value in %rdi)

        movabsq $2635249153387078803, %rax
        shrq $3, %rdi
        mulq %rdi

and for -Os you get (value in %rax):

        movl $56, %ecx
        xorl %edx, %edx
        divq %rcx

and that 'divq' is certainly again smaller and more obvious, but again
we're talking "single cycles" vs "potentially 50+ cycles" depending on
uarch.

                  Linus
