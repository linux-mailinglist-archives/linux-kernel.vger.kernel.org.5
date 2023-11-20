Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C56C7F1DF3
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 21:22:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbjKTUW5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 15:22:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbjKTUW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 15:22:56 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32631CB
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 12:22:53 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E161C433C8
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 20:22:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700511772;
        bh=gIgqR/9VcuTYBSkml6AkfzkkEsnD1KQBGwRnh+jZD2U=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=cJSYvudJ73nVPGMLTsPa0tmWSiq0m7uJ8URX3gFum2ENVm5MjARlAtnKSfWFmgMjY
         xOHhg9SCtmXslK3vqF+uvvUFWLrazsmFY/gv1jmQGTkDXOsFdYQfuo100i+3xOQP3q
         yMzCvLmapw6u8tIM/bLdyXSp/+YKrrUBHIaFPufmfSecGNFkvbrKPZZkMzOeiHkzV4
         Hks2YHQ+TW33yNpF5ABTV5wU2Ox9gZKsWEqBAZZAMkkxV+H1irYmHFHoIkEWERlNbe
         Mi3zBdbo+q8hr1v2HiPetVfl4EhNTh+UcetcLrqengyjX+zGNUH0nwFB9RYPwfCBgB
         l5Mhg+eleOIeQ==
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-285196aaecaso1192184a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 12:22:52 -0800 (PST)
X-Gm-Message-State: AOJu0YyJ4aVloYNfSW1xtV7ywbs3Mv6PkFoJ3UKV8BZq4dhK19a5M/h8
        V8ZmYVCnTo+41f8k0kO5JT27AqypUN8KXW/ugtzQaQ==
X-Google-Smtp-Source: AGHT+IFEQM3maKhSUUF0uyuZ3TL136y/JNrYvF3KNApHKyAwkdOxRtYNGaJo2Y+2WFGmSVShsJPF2y/MqmURgeNPZZo=
X-Received: by 2002:a17:90b:4d0d:b0:27d:c36:e12d with SMTP id
 mw13-20020a17090b4d0d00b0027d0c36e12dmr6456816pjb.6.1700511772129; Mon, 20
 Nov 2023 12:22:52 -0800 (PST)
MIME-Version: 1.0
References: <20231119194740.94101-1-ryncsn@gmail.com> <CAJD7tkYXcQkTZkUnAz89dR0O1YmEUr29UFeg3142t6Y09aaSpg@mail.gmail.com>
In-Reply-To: <CAJD7tkYXcQkTZkUnAz89dR0O1YmEUr29UFeg3142t6Y09aaSpg@mail.gmail.com>
From:   Chris Li <chrisl@kernel.org>
Date:   Mon, 20 Nov 2023 12:22:40 -0800
X-Gmail-Original-Message-ID: <CAF8kJuNWj_2tQA+0D-hpQgeJwWZRaQWxOCF=qagFnA8+yb3R1Q@mail.gmail.com>
Message-ID: <CAF8kJuNWj_2tQA+0D-hpQgeJwWZRaQWxOCF=qagFnA8+yb3R1Q@mail.gmail.com>
Subject: Re: [PATCH 00/24] Swapin path refactor for optimization and bugfix
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Kairui Song <kasong@tencent.com>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Huang, Ying" <ying.huang@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kairui,

On Mon, Nov 20, 2023 at 11:10=E2=80=AFAM Yosry Ahmed <yosryahmed@google.com=
> wrote:
>
> On Sun, Nov 19, 2023 at 11:48=E2=80=AFAM Kairui Song <ryncsn@gmail.com> w=
rote:
> >
> > From: Kairui Song <kasong@tencent.com>
> >
> > This series tries to unify and clean up the swapin path, fixing a few
> > issues with optimizations:
> >
> > 1. Memcg leak issue: when a process that previously swapped out some
> >    migrated to another cgroup, and the origianl cgroup is dead. If we
> >    do a swapoff, swapped in pages will be accounted into the process
> >    doing swapoff instead of the new cgroup. This will allow the process
> >    to use more memory than expect easily.
> >
> >    This can be easily reproduced by:
> >    - Setup a swap.
> >    - Create memory cgroup A, B and C.
> >    - Spawn process P1 in cgroup A and make it swap out some pages.
> >    - Move process P1 to memory cgroup B.
> >    - Destroy cgroup A.
> >    - Do a swapoff in cgroup C
> >    - Swapped in pages is accounted into cgroup C.
> >
> >    This patch will fix it make the swapped in pages accounted in cgroup=
 B.
> >
>
> I guess this only works for anonymous memory and not shmem, right?
>
> I think tying memcg charges to a process is not something we usually
> do. Charging the pages to the memcg of the faulting process if the
> previous owner is dead makes sense, it's essentially recharging the
> memory to the new owner. Swapoff is indeed a special case, since the
> faulting process is not the new owner, but an admin process or so. I
> am guessing charging to the new memcg of the previous owner might make
> sense in this case, but it is a change of behavior.
>

I was looking at this at patch 23 as well. Will ask more questions in
the patch thread.
I would suggest making these two behavior change patches separate out
from the clean up series to give it more exposure and proper
discussion.
Patch 5 and patch 23.

Chris
