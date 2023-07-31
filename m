Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1367876A052
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 20:24:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231628AbjGaSYb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 14:24:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231153AbjGaSY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 14:24:26 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CA7C173B
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 11:24:19 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2b9ab1725bbso72431221fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 11:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1690827857; x=1691432657;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1JsJGaMslWBF9ml2379UCHrdiT1Bj5wN4ELxCIbCizg=;
        b=CtRurR7TocHfwYJED+G5FJni7/g3phT4SLTFdA3TZ23s5uriP01O/X5nquVcDm3ccP
         IwG96ndm/zHE233TIveqlV9fL/k3riH3i6vQuif/IIBJZiV+amRWGNzT11kEl0j4f7UX
         4qcBotaaEm8KSelrT9L5ebHAjRNuDWzwNAGRU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690827857; x=1691432657;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1JsJGaMslWBF9ml2379UCHrdiT1Bj5wN4ELxCIbCizg=;
        b=JbfET4fmi/Ul9nAtA8dtvHYDfODtfHOcyKJrWW0YU3DvogqLjyBN0fzp6C2ZX2DUBW
         WExhqMYOmHBiYXx99qvgOH+bHHbfcwBnZ/I0oeRrXfKnJi3VrsslQf2RgQpYs0B8EzSu
         57hfGbZRmMXbAIqZkKZdNOoVLCL+U15EB6wzcCmFaPSdPjfENzxvVfM7xghSI6cuyd/u
         c/1oJfawj21iur3iAMHAZPIoLsGZv5Nl3VXwD/h2YZv4h7BOXgNHXLBK+r4QK61xQj+v
         6F2fStvDD9wp7UyLLEVAWJedcNuCsMbIF8RsbLAz2ENdLsgiBN5FBI5uZUT+3QrhuCle
         0dgw==
X-Gm-Message-State: ABy/qLbznHKdeqlW8Om+g7VAJXKjG2RNZSBh2yXv8eyWZUS4nY+P9I70
        u2ggxTk8nFM65pirnk94ySP5NB0t/rnhEePyYeajYzQz
X-Google-Smtp-Source: APBJJlGI2hRZCLTdt6HWsLfEiMI8QBL5KIlnJa1POIebyQtDsMKz7pFnw7ivNn5ORqKNycERkhFXgA==
X-Received: by 2002:a05:6512:3711:b0:4fe:ecd:4950 with SMTP id z17-20020a056512371100b004fe0ecd4950mr473253lfr.1.1690827857390;
        Mon, 31 Jul 2023 11:24:17 -0700 (PDT)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id h26-20020a19701a000000b004fe28e3841bsm1251893lfc.267.2023.07.31.11.24.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Jul 2023 11:24:16 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-4fe28f92d8eso3221314e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 11:24:16 -0700 (PDT)
X-Received: by 2002:a05:6512:20c1:b0:4fd:faa3:2352 with SMTP id
 u1-20020a05651220c100b004fdfaa32352mr423948lfr.14.1690827855949; Mon, 31 Jul
 2023 11:24:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230727212845.135673-1-david@redhat.com> <CAHk-=wiig=N75AGP7UAG9scmghWAqsTB5NRO6RiWLOB5YWfcTQ@mail.gmail.com>
 <412bb30f-0417-802c-3fc4-a4e9d5891c5d@redhat.com> <66e26ad5-982e-fe2a-e4cd-de0e552da0ca@redhat.com>
 <ZMfc9+/44kViqjeN@x1n> <a3349cdb-f76f-eb87-4629-9ccba9f435a1@redhat.com>
In-Reply-To: <a3349cdb-f76f-eb87-4629-9ccba9f435a1@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 31 Jul 2023 11:23:59 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiREarX5MQx9AppxPzV6jXCCQRs5KVKgHoGYwATRL6nPg@mail.gmail.com>
Message-ID: <CAHk-=wiREarX5MQx9AppxPzV6jXCCQRs5KVKgHoGYwATRL6nPg@mail.gmail.com>
Subject: Re: [PATCH v1 0/4] smaps / mm/gup: fix gup_can_follow_protnone fallout
To:     David Hildenbrand <david@redhat.com>
Cc:     Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        liubo <liubo254@huawei.com>,
        Matthew Wilcox <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        John Hubbard <jhubbard@nvidia.com>,
        Mel Gorman <mgorman@suse.de>
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

On Mon, 31 Jul 2023 at 09:20, David Hildenbrand <david@redhat.com> wrote:
>
> I modified it slightly: FOLL_HONOR_NUMA_FAULT is now set in
> is_valid_gup_args(), such that it will always be set for any GUP users,
> including GUP-fast.

But do we actually want that? It is actively crazy to honor NUMA
faulting at least for get_user_pages_remote().

So right now, GUP-fast requires us to honor NUMA faults, because
GUP-fast doesn't have a vma (which in turn is because GUP-fast doesn't
take any locks).

So GUP-fast can only look at the page table data, and as such *has* to
fail if the page table is inaccessible.

But GUP in general? Why would it want to honor numa faulting?
Particularly by default, and _particularly_ for things like
FOLL_REMOTE.

In fact, I feel like this is what the real rule should be: we simply
define that get_user_pages_fast() is about looking up the page in the
page tables.

So if you want something that acts like a page table lookup, you use
that "fast" thing.  It's literally how it is designed. The whole - and
pretty much only - point of it is that it can be used with no locking
at all, because it basically acts like the hardware lookup does.

So then if KVM wants to look up a page in the page table, that is what
kvm should use, and it automatically gets the "honor numa faults"
behavior, not because it sets a magic flag, but simply because that is
how GUP-fast *works*.

But if you use the "normal" get/pin_user_pages() function, which looks
up the vma, at that point you are following things at a "software
level", and it wouldn't do NUMA faulting, it would just get the page.

(Ok, we have the whole "FAST_ONLY vs fall back" case, so "fast" can
look up the vma too, but read the above argument as "fast *can* be
done without vma, so fast must honor page table bits as per
hardware").

              Linus
