Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECCE97EDA29
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 04:26:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344770AbjKPD1A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 22:27:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344863AbjKPD04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 22:26:56 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E7571A4
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 19:26:51 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-9d0b4dfd60dso45026966b.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 19:26:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1700105209; x=1700710009; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Lpw5N7hLJVBmWx1YZh3JJftpK5bs0D0hrTfIHC0Li88=;
        b=YU9xIEdlaoIZq+xWDKVdiwF/2vfnX6Qq3UbjfIcPEtMsWk7FEHBSZFU5DsqZyY1n8X
         JTE2JRI/erQ747axppsem29Xoj+gizG3UF1RHSEufffC+Fsh3dGeX2s81J2ouujBXpYV
         K6fSWocNXNCtqCRxw3aLvteh/OpzX9lj+xrfQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700105209; x=1700710009;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Lpw5N7hLJVBmWx1YZh3JJftpK5bs0D0hrTfIHC0Li88=;
        b=Ya6nJl6WJufwWSdDgl4jiMz1xsDSxthXjPFWZNv3N93u4TOk5V7vPmogUTNhhVP8vF
         TfMx23bGR0D/zL7QcSZlG361xF5wBWEVKtrqFWqEGZ2iN7Q5RPk+sSBTNkzVLFWUKJyb
         ZB/1OOtXmJ49elzZJTGd9qh5oExrMjKyFCueNhssT+Fm/6PxdvBawjcEtNKrBTlBrznC
         cVtbkxVMePx1k8lAf/y3X51tBs5fKOWfX46SG0uy3K3X445483/gZDnLl+jaqxKUJwLJ
         JGsZOdbhlkyXIbZADQ8cprJZgeS0AcEjTZEECspDfLwOV+eob+OqhIhGdiLvP1RxSDzq
         y6Yg==
X-Gm-Message-State: AOJu0YyJJuFugvuXzS+3oS7Nw9TnhQFjPbghRHzv8McX8B29XWxZ6W6R
        L8ZLouLzOpTmhE+DJCJU4DVhK+cygxx9nwvfkhNdr16z
X-Google-Smtp-Source: AGHT+IFCKfXCziAtQpJlDGDrEUVkLMDc9pXqoaQJL8NIe88JQXYUSl0fEbCGzxxDT7caoAWNITFQFw==
X-Received: by 2002:a17:906:5297:b0:9e2:af56:c375 with SMTP id c23-20020a170906529700b009e2af56c375mr10608506ejm.52.1700105209503;
        Wed, 15 Nov 2023 19:26:49 -0800 (PST)
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com. [209.85.208.43])
        by smtp.gmail.com with ESMTPSA id d7-20020a170906370700b009dd4b2d412fsm7823586ejc.36.2023.11.15.19.26.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Nov 2023 19:26:48 -0800 (PST)
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-53db360294fso520949a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 19:26:47 -0800 (PST)
X-Received: by 2002:a05:6402:1111:b0:53d:bc68:633a with SMTP id
 u17-20020a056402111100b0053dbc68633amr11218507edv.5.1700105207537; Wed, 15
 Nov 2023 19:26:47 -0800 (PST)
MIME-Version: 1.0
References: <202311061616.cd495695-oliver.sang@intel.com> <3865842.1700061614@warthog.procyon.org.uk>
 <CAHk-=whM-cEwAsLtKsf5dYwV7nDTaRv1bUKLVBstMAQBug24uQ@mail.gmail.com>
 <CAHk-=wjCUckvZUQf7gqp2ziJUWxVpikM_6srFdbcNdBJTxExRg@mail.gmail.com>
 <CAHk-=wjhs6uuedgz-7HbcPtirEq+vvjJBY-M2zyteJwBhOMZhg@mail.gmail.com>
 <4097023.1700084620@warthog.procyon.org.uk> <CAHk-=wgR3Mw2-8k2O3S10T-f4oz8FNfg7aziLU_6pbx0qowxew@mail.gmail.com>
 <42895.1700089191@warthog.procyon.org.uk>
In-Reply-To: <42895.1700089191@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 15 Nov 2023 22:26:30 -0500
X-Gmail-Original-Message-ID: <CAHk-=wi7gdgFM4tnLXfE4cj2XiKNARbGY-N2aF5h9CMaN6JUbA@mail.gmail.com>
Message-ID: <CAHk-=wi7gdgFM4tnLXfE4cj2XiKNARbGY-N2aF5h9CMaN6JUbA@mail.gmail.com>
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
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Nov 2023 at 18:00, David Howells <dhowells@redhat.com> wrote:
>
> And using __memcpy() rather than memcpy():

Yeah, that's just sad. It might indeed be that you're running on a
Haswell core, and the retpoline overhead just kills that entirely. You
could try building the kernel without mitigations (or booting with
them off, which isn't quite as good) to verify.

> A disassembly of _copy_from_iter() for the latter is attached.  Note that the
> UBUF/IOVEC still uses "rep movsb"

Well, yes and no.

User copies do that X86_FEATURE_FSRM alternatives dance, so the code
gets generated with "rep movs", but you'll note that there are several
'nops' after it.

Some of the nops are because we'll be inserting STAC/CLAC (three bytes
each, I think) instructions around user accesses for SMAP-capable
CPU's.

But some of the nops are because we'll be rewriting that "rep stosb"
(two bytes, iirc) as "call rep_stos_alternative" (5 bytes) on CPU's
that don't do FSRM like yours. So your CPU won't actually be executing
that 'rep stosb' sequence.

And yes, the '__x86_return_thunk' overhead can be pretty horrific. It
will get rewritten to the appropriate thing by "apply_returns". But
like the "rep movs" and the missing STAC/CLAC, you won't see that in
the objdump, you only see it in the final binary.

                    Linus
