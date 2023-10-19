Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2548C7D0540
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 01:06:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346675AbjJSXGh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 19:06:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233222AbjJSXGf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 19:06:35 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91884FA
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 16:06:33 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2c509d5ab43so3189231fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 16:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1697756792; x=1698361592; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vyephYMGi9WkrF+MMy/aTcTtLZAvJsqtW+X3GM9oKyI=;
        b=XLScS6SxFxKUAqTUem7TJ54dAnmfCURESHowXgmWQ1vxH0MjIQLMv4NiccWfdNQ81o
         5ZcLccrDnSzYHjqc64UjvxOpSvRJNgjkHzArwGJMtQn3Yqxrc6SAQlHDxcgmA7MXLcPa
         jhxI7YiRmCnbCgVqS0vpsurLG8UspeVIvZumA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697756792; x=1698361592;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vyephYMGi9WkrF+MMy/aTcTtLZAvJsqtW+X3GM9oKyI=;
        b=nEeSVuT5xwojlce3hDXuVzCZcGc6NBVPG9SUxBcEt8Hz3bCnqbUyiAQYz/Z8RollKP
         jZTmdGmMJH6W1lPpgQRrPqZFZ+4DLi71v9rL0L56oDyViZ7f6MW61gEkJPsGNHQygxqh
         JJkrq+3J2RWW6I+TzONKgYPThd7HNEYvtaSzDppez8iabvneahjZlrRTPilkCRO7Rlw3
         Ha1nQrZysoAfiFmSdND1PDbYZadFwHpI75tPRXrldS4wvMDSMYkp00/z8OmqXgHCSGJb
         1MR0LVCHmE8ee9NWRfEo3SZL+bKM5vp9g3hG+ShP39R/XQ8wdR/QaJrI7noX7kt6WDK4
         Su6g==
X-Gm-Message-State: AOJu0Yzewb4lPLj1KmG6Xi3p59UOtfsdr5O07PQRE0mPURIg189o38Nt
        7zu6NibCG0YCOypY0INzBL3Uk8wftx/KA1GI3nDq4JG2
X-Google-Smtp-Source: AGHT+IHiJ78IkW0RR4V5AyLHVGhaap50OWtU5RSVVfQRS1lyydZzIDTtJiYygjwib3ewnKax/IA5vA==
X-Received: by 2002:a2e:81cc:0:b0:2c0:2ef8:9716 with SMTP id s12-20020a2e81cc000000b002c02ef89716mr258938ljg.1.1697756791842;
        Thu, 19 Oct 2023 16:06:31 -0700 (PDT)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id b12-20020a2e894c000000b002c00d4eb5ddsm107519ljk.99.2023.10.19.16.06.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Oct 2023 16:06:31 -0700 (PDT)
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-507a98517f3so246729e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 16:06:31 -0700 (PDT)
X-Received: by 2002:ac2:533c:0:b0:503:3453:ea7a with SMTP id
 f28-20020ac2533c000000b005033453ea7amr52431lfh.66.1697756791018; Thu, 19 Oct
 2023 16:06:31 -0700 (PDT)
MIME-Version: 1.0
References: <20231016143828.647848-1-jeffxu@chromium.org> <ZS1URCBgwGGj9JtM@casper.infradead.org>
 <CAKbZUD2A+=bp_sd+Q0Yif7NJqMu8p__eb4yguq0agEcmLH8SDQ@mail.gmail.com>
 <CALmYWFtOgMAQDGNoM6k2Ev4kMHD396wwH+rVDODaSjsyVMDogg@mail.gmail.com>
 <CAKbZUD2j1jbomCAVxUX_JmG1rfa8udc=5SqVOpDgc-3GnSTbAQ@mail.gmail.com>
 <CALmYWFv7jzOj5HPcYct=UzYKPrwwvtN1EQeHioQHDPwGFvL5Ug@mail.gmail.com>
 <CALmYWFt71Vi6ySiZhW+tmE-LZL7Tnu-dQ1uMO10DUkASUTxzKA@mail.gmail.com> <CAKbZUD12pEaDCLysOpT3yL3064=P28Pm3c=UBqhOZYeBP026WA@mail.gmail.com>
In-Reply-To: <CAKbZUD12pEaDCLysOpT3yL3064=P28Pm3c=UBqhOZYeBP026WA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 19 Oct 2023 16:06:14 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgDv5vPx2xoxNQh+kbvLsskWubGGGK69cqF_i4FkM-GCw@mail.gmail.com>
Message-ID: <CAHk-=wgDv5vPx2xoxNQh+kbvLsskWubGGGK69cqF_i4FkM-GCw@mail.gmail.com>
Subject: Re: [RFC PATCH v1 0/8] Introduce mseal() syscall
To:     Pedro Falcato <pedro.falcato@gmail.com>
Cc:     Jeff Xu <jeffxu@google.com>, Matthew Wilcox <willy@infradead.org>,
        jeffxu@chromium.org, akpm@linux-foundation.org,
        keescook@chromium.org, sroettger@google.com, jorgelo@chromium.org,
        groeck@chromium.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        jannh@google.com, surenb@google.com, alex.sierra@amd.com,
        apopple@nvidia.com, aneesh.kumar@linux.ibm.com,
        axelrasmussen@google.com, ben@decadent.org.uk,
        catalin.marinas@arm.com, david@redhat.com, dwmw@amazon.co.uk,
        ying.huang@intel.com, hughd@google.com, joey.gouly@arm.com,
        corbet@lwn.net, wangkefeng.wang@huawei.com,
        Liam.Howlett@oracle.com, lstoakes@gmail.com, mawupeng1@huawei.com,
        linmiaohe@huawei.com, namit@vmware.com, peterx@redhat.com,
        peterz@infradead.org, ryan.roberts@arm.com, shr@devkernel.io,
        vbabka@suse.cz, xiujianfeng@huawei.com, yu.ma@intel.com,
        zhangpeng362@huawei.com, dave.hansen@intel.com, luto@kernel.org,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Oct 2023 at 15:47, Pedro Falcato <pedro.falcato@gmail.com> wrote:
> >
> > For mprotect()/mmap(), is Linux implementation limited by POSIX ?
>
> No. POSIX works merely as a baseline that UNIX systems aim towards.
> You can (and very frequently do) extend POSIX interfaces (in fact,
> it's how most of POSIX was written, through sheer
> "design-by-committee" on a bunch of UNIX systems' extensions).

We can in extreme circumstances actually go further than that, and not
only extend on POSIX requirements, but actively even violate them.

It does need a very good reason, though, but it has happened when
POSIX requirements were simply actively wrong.

For example, at one point POSIX required

     int accept(int s, struct sockaddr *addr, size_t *addrlen);

which was simply completely wrong. It's utter shite, and didn't
actually match any reality.

The 'addrlen' parameter is 'int *', and POSIX suddenly trying to make
it "size_t" was completely unacceptable.

So we ignored it, told POSIX people that they were full of sh*t, and
they eventually fixed it in the next version (by introducing a
"socklen_t" that had better be the same as "int").

So POSIX can simply be wrong.

Also, if it turns out that we had some ABI that wasn't
POSIX-compatible, the whole "don't break user space" will take
precedence over any POSIX concerns, and we will not "fix" our system
call if people already use our old semantics.

So in that case, we generally end up with a new system call (or new
flags) instead.

Or sometimes it just is such a small detail that nobody cares - POSIX
also has a notion of documenting areas of non-conformance, and people
who really care end up having notions like "conformance vs _strict_
conformance".

                 Linus
