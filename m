Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EE927ED638
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 22:50:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233601AbjKOVuc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 16:50:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233253AbjKOVua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 16:50:30 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 031FB1A4
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 13:50:27 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-99bdeae1d0aso23880366b.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 13:50:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1700085025; x=1700689825; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=euaKLHnf5NJceWFhMbsDdv1xMlqpCbfs4YJAKx1yvno=;
        b=c4mSnWglBKRwKbzvaa1GTvwlD261qX+VUfnzEMxj+bCUx+LuIgcG6FQRntun3s66tV
         PmeSIs63p8ww+j7kuZaFpeR0a2eugJ9kt5fPLqScRNUSzRRcDXaXObwgaLYIdm3NU32V
         VAGRzYOqEj2hyvZoOxfbmf3JOsEsnTTR/UUXc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700085025; x=1700689825;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=euaKLHnf5NJceWFhMbsDdv1xMlqpCbfs4YJAKx1yvno=;
        b=hMZm3t3ltVHYOqNbwIeC9LZ75wjme9X99UdpjxvklckPNcONlQWBBf+yObzSceHsfs
         Fjt1IzpUel+SiEi7DtokSiN4vET9XrhcJhwhSX//p58kUtA0hrqtSOrbWvmcFshYw83h
         iUAK/3Niw9+Or6GwMVHEI5PNnm91TJtij2UU87f7Mk+fsFVHv5VEQc6bP8lrK3AhnIhB
         jP4+5yzKE+4wpjEsgZ46d8s5lMmT/0l8OiQsa572g1QfZH5ihUYdRp8yHsIa9fSVutm2
         AXKF5uOTWtbTEynhLyeq39Z4Yr6/lH4kLyKZo3yJhwwbKkeAMEyB2wJUxQuVnxPCd659
         EJSA==
X-Gm-Message-State: AOJu0YzsDsieY8hgIu31aZHia+tAnC7xZ7TpJTD0Db7sCWq9wquSpkan
        u64a8dHNK60F93DrTgLl5jk7cEo8L3MBqrKt3hK5ZVqn
X-Google-Smtp-Source: AGHT+IHGrup1wdeFg7fK85JymHPgDg4nHzH9E000H4G/CDwJh/oC3z1g7xz5JSLbUxUoB/vMVlbiVA==
X-Received: by 2002:a17:906:ae91:b0:9a2:28dc:4166 with SMTP id md17-20020a170906ae9100b009a228dc4166mr10501414ejb.75.1700085025321;
        Wed, 15 Nov 2023 13:50:25 -0800 (PST)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id dt10-20020a170906b78a00b009a5f1d15644sm7465686ejb.119.2023.11.15.13.50.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Nov 2023 13:50:25 -0800 (PST)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-54553e4888bso215671a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 13:50:24 -0800 (PST)
X-Received: by 2002:aa7:d49a:0:b0:540:b1fb:b630 with SMTP id
 b26-20020aa7d49a000000b00540b1fbb630mr10875459edr.27.1700085024118; Wed, 15
 Nov 2023 13:50:24 -0800 (PST)
MIME-Version: 1.0
References: <202311061616.cd495695-oliver.sang@intel.com> <3865842.1700061614@warthog.procyon.org.uk>
 <CAHk-=whM-cEwAsLtKsf5dYwV7nDTaRv1bUKLVBstMAQBug24uQ@mail.gmail.com>
 <CAHk-=wjCUckvZUQf7gqp2ziJUWxVpikM_6srFdbcNdBJTxExRg@mail.gmail.com>
 <CAHk-=wjhs6uuedgz-7HbcPtirEq+vvjJBY-M2zyteJwBhOMZhg@mail.gmail.com> <4097023.1700084620@warthog.procyon.org.uk>
In-Reply-To: <4097023.1700084620@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 15 Nov 2023 16:50:06 -0500
X-Gmail-Original-Message-ID: <CAHk-=wgR3Mw2-8k2O3S10T-f4oz8FNfg7aziLU_6pbx0qowxew@mail.gmail.com>
Message-ID: <CAHk-=wgR3Mw2-8k2O3S10T-f4oz8FNfg7aziLU_6pbx0qowxew@mail.gmail.com>
Subject: Re: [linus:master] [iov_iter] c9eec08bac: vm-scalability.throughput
 -16.9% regression
To:     David Howells <dhowells@redhat.com>
Cc:     Borislav Petkov <bp@alien8.de>,
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

On Wed, 15 Nov 2023 at 16:43, David Howells <dhowells@redhat.com> wrote:
>
>   LD      arch/x86/purgatory/purgatory.chk
> ld: arch/x86/purgatory/purgatory.ro:(.altinstr_replacement+0x1): undefined reference to `rep_movs_alternative'
> ld: arch/x86/purgatory/purgatory.ro:(.altinstr_replacement+0x6): undefined reference to `rep_movs_alternative'
>
> The symbol is available in the arch lib directory:

That patch of mine ends up exposing the fact that we have a lot of
special boot-time code and similar that isn't real kernel code, but is
built with kernel headers.

Normally not that noticeable, but when it modified something as core
as memcpy(), it shows up in a big way.

Sadly, we don't seem to have any obvious #define for "this is not real
kernel code". We just have a lot of ad-hoc tricks, like removing
compiler flags and disabling things like KASAN etc on a file-by-file
(or directory) basis.

The purgatory code isn't exactly boot-time code, but it's very similar
- it's kind of a limited environment that runs at crash time to load a
new kernel.

               Linus
