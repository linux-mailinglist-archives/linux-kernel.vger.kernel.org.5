Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 056DA76A0DF
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 21:08:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231295AbjGaTIE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 15:08:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231569AbjGaTHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 15:07:55 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48704AF
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 12:07:53 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4fe15bfb1adso7618676e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 12:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1690830470; x=1691435270;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=n0D+OWW2wByasWNJM+tEhbiKI7Yb1duh5NU83GOmeCY=;
        b=JZwiXX7skaxM5ZjjFhi+e88VSUCJ8kQ6OIPqSH+47oIZCTJNOQvi1mWqvTiYd5fpGS
         nf1Q/xIzB0oB1Hmfz0iGiYhAu52LznBvcxYIaocckrzcWi8BjpWDFg4fUb6QSXt8RUcq
         7RXhWWdqPwcUUYb8cbvwKwBt6eKXrxsidzbSM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690830470; x=1691435270;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n0D+OWW2wByasWNJM+tEhbiKI7Yb1duh5NU83GOmeCY=;
        b=DJ/+MsPS1g6feq0RUtspB5Yo82rX5NT7MLqVtBe+syFjHcSNExsKSWovYh79YVQ3mE
         C9pGsxWLvsmHIu2eOOsliN595d/BfEsQILfzknk+S1VdDx+U3aIBys0iJVv0ugnvKRDE
         YDVb2NLA8trRc51A7J/iW7H+0i3F1i4hZ7hrcBbGaAI2slrGA2GGw5J99qDQ7Z7+KXxv
         ryau8DIISduc0vPws37GdIU321p7F2SUPAIOTHwUQwWyUR34nQV3JrKBeL24GUvxg6x8
         FFOElrmlEvGuA+S4fgcvrCWkkxv6f5aOKYTDBWlzcVf6tUWkl/jfGgqWVeKVG7s+/fUi
         zZPg==
X-Gm-Message-State: ABy/qLYFbPu/5kRJIK+y73gmBXoD4A1GwRJkYgNdqv5thy1tgXpdI6VP
        WJHiufvgA4wEAbVsL2Su+FcsU3KZL6YjQxhSje6zPGYy
X-Google-Smtp-Source: APBJJlFH8BgiltNE/LIoQgwC9zH5PTs5zhbQCpUAS266pmKic316S+oiTzcPMa1kEXrcAffU0K5zSA==
X-Received: by 2002:a05:6512:2009:b0:4f8:6560:6436 with SMTP id a9-20020a056512200900b004f865606436mr473738lfb.9.1690830469942;
        Mon, 31 Jul 2023 12:07:49 -0700 (PDT)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id d19-20020a1709064c5300b00997d7aa59fasm6633520ejw.14.2023.07.31.12.07.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Jul 2023 12:07:49 -0700 (PDT)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-522294c0d5bso6345094a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 12:07:48 -0700 (PDT)
X-Received: by 2002:aa7:d702:0:b0:51e:d4b:3c9d with SMTP id
 t2-20020aa7d702000000b0051e0d4b3c9dmr679676edq.23.1690830468573; Mon, 31 Jul
 2023 12:07:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230727212845.135673-1-david@redhat.com> <CAHk-=wiig=N75AGP7UAG9scmghWAqsTB5NRO6RiWLOB5YWfcTQ@mail.gmail.com>
 <412bb30f-0417-802c-3fc4-a4e9d5891c5d@redhat.com> <66e26ad5-982e-fe2a-e4cd-de0e552da0ca@redhat.com>
 <ZMfc9+/44kViqjeN@x1n> <a3349cdb-f76f-eb87-4629-9ccba9f435a1@redhat.com>
 <CAHk-=wiREarX5MQx9AppxPzV6jXCCQRs5KVKgHoGYwATRL6nPg@mail.gmail.com> <a453d403-fc96-e4a0-71ee-c61d527e70da@redhat.com>
In-Reply-To: <a453d403-fc96-e4a0-71ee-c61d527e70da@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 31 Jul 2023 12:07:19 -0700
X-Gmail-Original-Message-ID: <CAHk-=whxpKc_zOiJ9n-MA9s0wxvU9vRST+iuNYGkHHB6ux48Rg@mail.gmail.com>
Message-ID: <CAHk-=whxpKc_zOiJ9n-MA9s0wxvU9vRST+iuNYGkHHB6ux48Rg@mail.gmail.com>
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

On Mon, 31 Jul 2023 at 12:00, David Hildenbrand <david@redhat.com> wrote:
>
> So in the "!writable" case, we would always call
> get_user_pages_unlocked() and never honor NUMA faults.

Ok, so kvm doesn't just use the fast version. Oh well. It was an idea..

         Linus
