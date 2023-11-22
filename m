Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDBEE7F3D5D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 06:34:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbjKVFez (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 00:34:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjKVFey (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 00:34:54 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CDC090
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 21:34:50 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EEB3C433CC
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 05:34:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700631290;
        bh=+oyhJw+7WDNmz+8BB3oZ+9jML7VR1PCueTIj1yyeSJE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=S7dQz6c8HTOaMWHw0+v8POXeHHNgESqqp6IZQSFG8+JBaOa4iVFm60usbgE64pLoz
         Qlunhv0YUWMetRsAv+7LcuJJYdskWp/gG8FftvYsRYG8NfzopVqFNVtvgOQS8h8DKE
         GCTMOJ51R2jYnqT3/BEM9MX7e+fFis6y7mf1B2Q2cO8Gcrl7KNX8tjITyZKsBXXlyo
         d0A4rjvrDc3p1TtDNXyk2oohsoMsa017+Hg4i86F8yVt+zPOdoBvMnxAk22JWlILHg
         Cy/v0lSPgHbC25txAI07W7824PU4LL4UtwggSy/xgk3NB6/Qgprt3/yLW+hFGgqRUV
         jXbHBNjgZbSxg==
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-1f9460cb66cso1577193fac.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 21:34:49 -0800 (PST)
X-Gm-Message-State: AOJu0Yw8zSvW3+mMvRIMeSDJGDoT4XdYMcpIttIcMTByzkqOccgL4Eum
        pmo/3LZvX2UWBk2MQknPPCcrcnvTUh+eltLcaaAkFg==
X-Google-Smtp-Source: AGHT+IFx1OBet7WELnVj3mLYddyu1QmnNSMWiKQ+4A9WFcAMSYkIoxEBRkjJKPTTYeaaUfvmaHZMc5SVjs66MkcFvzo=
X-Received: by 2002:a05:6870:470b:b0:1ef:b649:cbd0 with SMTP id
 b11-20020a056870470b00b001efb649cbd0mr1594597oaq.52.1700631289206; Tue, 21
 Nov 2023 21:34:49 -0800 (PST)
MIME-Version: 1.0
References: <20231119194740.94101-1-ryncsn@gmail.com> <20231119194740.94101-24-ryncsn@gmail.com>
 <87msv8c1xy.fsf@yhuang6-desk2.ccr.corp.intel.com> <CAMgjq7Ahh2HVA0ym2t0UdX=FYQ52mrKXDueK5GeNK9=2h+adwQ@mail.gmail.com>
In-Reply-To: <CAMgjq7Ahh2HVA0ym2t0UdX=FYQ52mrKXDueK5GeNK9=2h+adwQ@mail.gmail.com>
From:   Chris Li <chrisl@kernel.org>
Date:   Tue, 21 Nov 2023 21:34:37 -0800
X-Gmail-Original-Message-ID: <CAF8kJuOahJMXu0ds8j9XHV81eSknVitvvWmvW4J-O_i=H-ON0g@mail.gmail.com>
Message-ID: <CAF8kJuOahJMXu0ds8j9XHV81eSknVitvvWmvW4J-O_i=H-ON0g@mail.gmail.com>
Subject: Re: [PATCH 23/24] swap: fix multiple swap leak when after cgroup migrate
To:     Kairui Song <ryncsn@gmail.com>
Cc:     "Huang, Ying" <ying.huang@intel.com>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org,
        Tejun Heo <tj@kernel.org>
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

On Mon, Nov 20, 2023 at 3:17=E2=80=AFAM Kairui Song <ryncsn@gmail.com> wrot=
e:
>
> Huang, Ying <ying.huang@intel.com> =E4=BA=8E2023=E5=B9=B411=E6=9C=8820=E6=
=97=A5=E5=91=A8=E4=B8=80 15:37=E5=86=99=E9=81=93=EF=BC=9A
> >
> > Kairui Song <ryncsn@gmail.com> writes:
> >
> > > From: Kairui Song <kasong@tencent.com>
> > >
> > > When a process which previously swapped some memory was moved to
> > > another cgroup, and the cgroup it previous in is dead, then swapped i=
n
> > > pages will be leaked into rootcg. Previous commits fixed the bug for
> > > no readahead path, this commit fix the same issue for readahead path.
> > >
> > > This can be easily reproduced by:
> > > - Setup a SSD or HDD swap.
> > > - Create memory cgroup A, B and C.
> > > - Spawn process P1 in cgroup A and make it swap out some pages.
> > > - Move process P1 to memory cgroup B.
> > > - Destroy cgroup A.
> > > - Do a swapoff in cgroup C
> > > - Swapped in pages is accounted into cgroup C.
> > >
> > > This patch will fix it make the swapped in pages accounted in cgroup =
B.
> >
> > Accroding to "Memory Ownership" section of
> > Documentation/admin-guide/cgroup-v2.rst,
> >
> > "

> > A memory area is charged to the cgroup which instantiated it and stays
> > charged to the cgroup until the area is released.  Migrating a process
> > to a different cgroup doesn't move the memory usages that it
> > instantiated while in the previous cgroup to the new cgroup.
> > "
> >
> > Because we don't move the charge when we move a task from one cgroup to
> > another.  It's controversial which cgroup should be charged to.
> > According to the above document, it's acceptable to charge to the cgrou=
p
> > C (cgroup where swapoff happens).
>
> Hi Ying, thank you very much for the info!
>
> It is controversial indeed, just the original behavior is kind of
> counter-intuitive.
>
> Image if there are cgroup P1, and its child cgroup C1 C2. If a process
> swapped out some memory in C1 then moved to C2, and C1 is dead.
> On swapoff the charge will be moved out of P1...
>
> And swapoff often happen on some unlimited cgroup or some cgroup for
> management agent.
>
> If P1 have a memory limit, it can breech the limit easily, we will see
> a process that never leave P1 having a much higher RSS that P1/C1/C2's
> limit.
> And if there is a limit for the management agent cgroup, the agent
> will be OOM instead of OOM in P1.

I think I will reply to another similar email.

If you want OOM in P1, you can have an admin program. fork and execute
a new process, add the new process into P1, then swap off from that
new process.

>
> Simply moving a process between the child cgroup of the same parent
> cgroup won't cause such issue, thing get weird when swapoff is
> involved.
>
> Or maybe we should try to be compatible, and introduce a sysctl or
> cmdline for this?

If the above suggestion works, then you don't need to change swap off?

If you still want to change the charging model. I like to see the
bigger picture, what rules it follows and how it works in other
situations.

Chris
