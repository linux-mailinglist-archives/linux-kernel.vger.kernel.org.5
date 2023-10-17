Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DE0E7CC970
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 19:05:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343684AbjJQRFU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 13:05:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231569AbjJQRFS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 13:05:18 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D1ECB0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 10:05:15 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-9b95622c620so1034359666b.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 10:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1697562313; x=1698167113; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8E8o2x2e8DzqPr/PksD/TO2/JNV/3RJFF1TJnJk/P9E=;
        b=VzZSqUbQCFDEZIO65M8OUMjiIcF5HTBMW7L/1rVBqiL/iVLqGog5ALFEn7/N1Q/uBP
         dj6Uzm1k86agHI3rbaZO09ENpOHswvrQPrOKogU4JnDN/2dtxbZAz+sWWRMFQQgxPi5d
         Dig6fDyo9ewwryAA3OXUC5NQU1alTp6VJHCpg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697562313; x=1698167113;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8E8o2x2e8DzqPr/PksD/TO2/JNV/3RJFF1TJnJk/P9E=;
        b=HkiX1itR+pt+APeyT5Xibi4CACwE2gFVSpTq5/GAESG6Nf7AD2VdCR4sn/dzIDS4D9
         pz9ppneu137Zr2+ApnlwFp81x14cVPsRdnh6qTfV9y5Inh68Lujfb4MKCaGmgpt9/Mco
         V5JZB4pNAuDUYw/OBu78HLHd4qb5g6LDBtEXKiLmGy7yaKcT+UwafEx+uEITGlioSppS
         JVOIJBN6AuvVJ5/RTRCA1AFtjm6gfKCreqvSX9O3ea7Cx0EvuDV7zst/dheV8/2y4ii2
         prkk6xPD2rvO8346nLSY5yNQjyYVs2ygoQGERHiznVNQ1Na+M181//s1JPqNTytBizAf
         iipg==
X-Gm-Message-State: AOJu0YyYtCZmz/h761WK5he+PhEdKGe6W1l1DZNhubUBcrsPQ51xwb3C
        +uox5m4n8crLzGhOuTog8x8w0hsSdgOCsUOuT9lqSn+J
X-Google-Smtp-Source: AGHT+IF/Nim3dI8VW7jGxhKRvywITCltwfQfwRFnd1pB2TalK2hhN01dbQvFPUiHi/AZjhAK84d8Wg==
X-Received: by 2002:a17:906:4787:b0:9b9:a1dd:5105 with SMTP id cw7-20020a170906478700b009b9a1dd5105mr2248235ejc.50.1697562313476;
        Tue, 17 Oct 2023 10:05:13 -0700 (PDT)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com. [209.85.218.49])
        by smtp.gmail.com with ESMTPSA id d1-20020a17090648c100b0099b76c3041csm146516ejt.7.2023.10.17.10.05.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Oct 2023 10:05:12 -0700 (PDT)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-9b6559cbd74so1033256166b.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 10:05:12 -0700 (PDT)
X-Received: by 2002:a17:907:d1c:b0:9b2:b2f8:85dd with SMTP id
 gn28-20020a1709070d1c00b009b2b2f885ddmr2808664ejc.34.1697562311687; Tue, 17
 Oct 2023 10:05:11 -0700 (PDT)
MIME-Version: 1.0
References: <20231017090815.1067790-1-jeffxu@chromium.org> <20231017090815.1067790-8-jeffxu@chromium.org>
In-Reply-To: <20231017090815.1067790-8-jeffxu@chromium.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 17 Oct 2023 10:04:54 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh+6n6f0zuezKem+W=aytHMv2bib6Fbrg-xnWOoujFb6g@mail.gmail.com>
Message-ID: <CAHk-=wh+6n6f0zuezKem+W=aytHMv2bib6Fbrg-xnWOoujFb6g@mail.gmail.com>
Subject: Re: [RFC PATCH v2 7/8] mseal:Check seal flag for mmap(2)
To:     jeffxu@chromium.org
Cc:     akpm@linux-foundation.org, keescook@chromium.org, jannh@google.com,
        sroettger@google.com, willy@infradead.org,
        gregkh@linuxfoundation.org, jeffxu@google.com,
        jorgelo@chromium.org, groeck@chromium.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, surenb@google.com, alex.sierra@amd.com,
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
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Oct 2023 at 02:08, <jeffxu@chromium.org> wrote:
>
> Note: Of all the call paths that goes into do_mmap(),
> ksys_mmap_pgoff() is the only place where
> checkSeals = MM_SEAL_MMAP. The rest has checkSeals = 0.

Again, this is all completely nonsensical.

First off, since seals only exist on existing vma's, the "MMAP seal"
makes no sense to begin with. You cannot mmap twice - and mmap'ing
over an existing mapping involves unmapping the old one.

So a "mmap seal" is nonsensical. What should protect a mapping is "you
cannot unmap this". That automatically means that you cannot mmap over
it.

In other words, all these sealing flag semantics are completely random
noise. None of this makes sense.

You need to EXPLAIN what the concept is.

Honestly, there is only two kinds of sealing that makes sense:

 - you cannot change the permissions of some area

 - you cannot unmap an area

where that first version might then have sub-cases (maybe you can make
permissions _stricter_, but not the other way)?

And dammit, once something is sealed, it is SEALED. None of this crazy
"one place honors the sealing, random other places do not".

I do *NOT* want to see another random patch series tomorrow that
modifies something small here.

I want to get an EXPLANATION and the whole "what the f*ck is the
concept". No more random rules. No more nonsensical code. No more of
this "one place honors seals, another one does not".

Seriously. As long as this is chock-full of these kinds of random
"this makes no sense", please don't send any patches AT ALL. Explain
the high-level rules first, and if you cannot explain why one random
place does something different from all the other random places, don't
even bother.

No more random code. No more random seals. None of this crazy "you
ostensibly can't unmap a vma, but you you can actually unmap it by
mmap'ing over it and then unmapping the new one".

             Linus
