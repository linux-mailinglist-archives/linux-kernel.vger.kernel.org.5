Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A1C27EE825
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 21:12:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345515AbjKPUML (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 15:12:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbjKPUMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 15:12:09 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94E26131
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 12:12:06 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 161AFC433D9
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 20:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700165526;
        bh=C5Ag1NQb4cc7th3TofT7+5tV5THCDr4smloIfN3cIT8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=G+VhEEeEu98nDD/uX+PWythEgk4mnU5QndLxsSN8himE0uc4GEJ3FnzQxjc+Vpv5D
         ktSPawRpgT91Pr90Ed9n5No+1Ry0O8mjccIgnf8qwZ4AZxv0Bihx9gE01jpSLW8oIM
         +oO5s/d6f8Ay5qO4Q1MVJvbMXsga+X8AoJipTbdrrmXjOQpnlUp0xLTathTRWiH92J
         7IDMLHg/mB+YlrdXHGZ+O1T4yHJMtzOVMacGgKneYzHfofmi9F2XEKQVoqEq40Jbhm
         YonHu9ghVYABG2A0UPgAVvXHoMJwZPaWw8uz441RaDiz8Dt2YK/5qypu8xu8pk5oWr
         xExUyv0Mtp2Ew==
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-280351c32afso952141a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 12:12:06 -0800 (PST)
X-Gm-Message-State: AOJu0YwBdvAFdChB7ARff+F1a3ovBMozCK3Wekw8Kd0Q2SMhsLk1Zknb
        cQgXkBPLdEOxYisA/jbedCw3bYQSVWMtq5NeRkSj4Q==
X-Google-Smtp-Source: AGHT+IG0K5P5Vq19J39db/gwdi+x76zhJReRhaju/NQOIby1hNOhosKgN6jisI8FQMvoBybSJPNEHy8biG3OJDGliuc=
X-Received: by 2002:a17:90b:3b87:b0:280:a69e:45e5 with SMTP id
 pc7-20020a17090b3b8700b00280a69e45e5mr17271341pjb.44.1700165525441; Thu, 16
 Nov 2023 12:12:05 -0800 (PST)
MIME-Version: 1.0
References: <20231113130601.3350915-1-hezhongkun.hzk@bytedance.com> <CAJD7tkY8SwROmNEaBAhkS4OKj33g-6fHsKFeYKW3afT+yAbvxA@mail.gmail.com>
In-Reply-To: <CAJD7tkY8SwROmNEaBAhkS4OKj33g-6fHsKFeYKW3afT+yAbvxA@mail.gmail.com>
From:   Chris Li <chrisl@kernel.org>
Date:   Thu, 16 Nov 2023 12:11:54 -0800
X-Gmail-Original-Message-ID: <CAF8kJuPonfuOtipdifXwBny2H7cy6m6BL8mWFVXzfb9JSdYq3Q@mail.gmail.com>
Message-ID: <CAF8kJuPonfuOtipdifXwBny2H7cy6m6BL8mWFVXzfb9JSdYq3Q@mail.gmail.com>
Subject: Re: [PATCH] mm:zswap: fix zswap entry reclamation failure in two scenarios
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Zhongkun He <hezhongkun.hzk@bytedance.com>,
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
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yosry,

On Tue, Nov 14, 2023 at 9:16=E2=80=AFAM Yosry Ahmed <yosryahmed@google.com>=
 wrote:
> > 1)The swap entry has been freed, but cached in swap_slots_cache,
> > no swap cache and swapcount=3D0.
> > 2)When the option zswap_exclusive_loads_enabled disabled and
> > zswap_load completed(page in swap_cache and swapcount =3D 0).
>
> For case (1), I think a cleaner solution would be to move the
> zswap_invalidate() call from swap_range_free() (which is called after
> the cached slots are freed) to __swap_entry_free_locked() if the usage
> goes to 0. I actually think conceptually this makes not just for
> zswap_invalidate(), but also for the arch call, memcg uncharging, etc.
> Slots caching is a swapfile optimization that should be internal to
> swapfile code. Once a swap entry is freed (i.e. swap count is 0 AND

Do you mean moving all swap slots free to bypass the swap slot cache, even =
it
is not from zswap? That might have unwanted side effects. The swap
slot cache is not just for swap files on disk. The batching has the
effect that on average lower cost of freeing per entry.

> not in the swap cache), all the hooks should be called (memcg, zswap,
> arch, ..) as the swap entry is effectively freed. The fact that
> swapfile code internally batches and caches slots should be
> transparent to other parts of MM. I am not sure if the calls can just
> be moved or if there are underlying assumptions in the implementation
> that would be broken, but it feels like the right thing to do.

There is also the behavior that if the page gets swapped in but hasn't
changed,  when swap out again, it is possible to avoid writing the
page again to the disk. For disk there is no overhead keeping the old
date on the disk not to touch it. For zpool it might have memory
overhead holding the compressed pool. The trade off might be
different.

Chris
