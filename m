Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DDDD7EFC3E
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 00:48:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346337AbjKQXsF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 18:48:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbjKQXsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 18:48:04 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE836131
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 15:48:01 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52D34C433CA
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 23:48:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700264881;
        bh=3VDvuRLZKeYSFlqVGWpz4nQo8YGybjGYmZp/AoQF7ZQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=BJZwIlBgytB1VjMr4ot28kbKARhgLJ5qblFXXO3MPvCjNfJ6eMZwi1uir6c7i2n0l
         2gI3j3LZXyuKLAjQPMnH+XB3lI72BjlhW43fo6W4BM8i5MB/eyH3jJDTB37epeC/et
         0L37xgsckYnn6i4ciYOowmT7SzPxY7hWzXJVeZcRkKqpabodmtnD2giHauq4dSmkoe
         AYLMkLRqFo5JpLitRxt3gjs8YsWBkh3pKFQ2FuN4pAhbQzBst0k0GiY/WtU7VlJZ3Y
         0cvllACAjxXqJy1a844fTVuGkbnQX1X2Kvj5XMsvzdH28n74KeNRuei4bt/6pusk4m
         F8sdRwu7xqG/g==
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-5b8f68ba4e5so1940832a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 15:48:01 -0800 (PST)
X-Gm-Message-State: AOJu0Yyhm1r824zs+Fv46A5gNbCisf73VJIuf1P4rE4slIRZlOsEaQRQ
        e1NHE4+STfrR/bBJSyMbZXGhOGYfF0vTJcR6gnfqJg==
X-Google-Smtp-Source: AGHT+IE5jWgX3mx6H+/pTof48BxfxixJNNp0jbg8NIX38ujTQyiTUPzja/pfj4EUf/KacaJwQo1RuKPpCDFvbyhYC6M=
X-Received: by 2002:a05:6a20:3944:b0:155:5c28:ea74 with SMTP id
 r4-20020a056a20394400b001555c28ea74mr681946pzg.12.1700264880792; Fri, 17 Nov
 2023 15:48:00 -0800 (PST)
MIME-Version: 1.0
References: <20231113130601.3350915-1-hezhongkun.hzk@bytedance.com>
 <CAJD7tkY8SwROmNEaBAhkS4OKj33g-6fHsKFeYKW3afT+yAbvxA@mail.gmail.com>
 <CAF8kJuPonfuOtipdifXwBny2H7cy6m6BL8mWFVXzfb9JSdYq3Q@mail.gmail.com>
 <CAJD7tkYMiJiXTTgAN34TP8QTr-ViAuEFddYes=ac+1ErenjCZw@mail.gmail.com>
 <CAF8kJuOC30feLGs0bNHOxMjSZ3uqF1y7eUdJ4p-w-myP8c1cFg@mail.gmail.com> <CACSyD1NJ4ycr74pXHNus3ZjA=LvZP+aMNyz=iWyHuDODpx7aww@mail.gmail.com>
In-Reply-To: <CACSyD1NJ4ycr74pXHNus3ZjA=LvZP+aMNyz=iWyHuDODpx7aww@mail.gmail.com>
From:   Chris Li <chrisl@kernel.org>
Date:   Fri, 17 Nov 2023 15:47:49 -0800
X-Gmail-Original-Message-ID: <CAF8kJuPymUX+DwouwgH6og0BO6ZYheGXsk=GYqYuMjKMz-Xqbw@mail.gmail.com>
Message-ID: <CAF8kJuPymUX+DwouwgH6og0BO6ZYheGXsk=GYqYuMjKMz-Xqbw@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] mm:zswap: fix zswap entry reclamation
 failure in two scenarios
To:     Zhongkun He <hezhongkun.hzk@bytedance.com>
Cc:     Yosry Ahmed <yosryahmed@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Nhat Pham <nphamcs@gmail.com>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, Ying <ying.huang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 17, 2023 at 1:56=E2=80=AFAM Zhongkun He
<hezhongkun.hzk@bytedance.com> wrote:
> Hi Chris, thanks for your feedback.  I have the same concerns,
> maybe we should just move the zswap_invalidate() out of batches,
> as Yosry mentioned above.

As I replied in the previous email, I just want to understand the
other side effects of the change better.

To me, this patching is actually freeing the memory that does not
require actual page IO write from zswap. Which means the memory is
from some kind of cache. It would be interesting if we can not
complicate the write back path further. Instead, we can drop those
memories from the different cache if needed. I assume those caches are
doing something useful in the common case. If not, we should have a
patch to remove these caches instead.  Not sure how big a mess it will
be to implement separate the write and drop caches.

While you are here, I have some questions for you.

Can you help me understand how much memory you can free from this
patch? For example, are we talking about a few pages or a few GB?

Where does the freed memory come from?
If the memory comes from zswap entry struct. Due to the slab allocator
fragmentation. It would take a lot of zswap entries to have meaningful
memory reclaimed from the slab allocator.

If the memory comes from the swap cached pages, that would be much
more meaningful. But that is not what this patch is doing, right?

Chris
