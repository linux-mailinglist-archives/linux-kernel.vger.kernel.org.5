Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C5F27F324E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 16:25:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234571AbjKUPZI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 10:25:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234467AbjKUPZA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 10:25:00 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E47AFD69
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 07:24:52 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51EC0C433BD
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 15:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700580292;
        bh=7LLenNPUQY5hiI60A1xIsFlQxx5tT75/fBlDFU9EUpc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=TD6sHtdjzN2MEuxsWHu8Bl7znNywClV1DNlnl/CLIYBZ1LdffKTHlpYSi2SglaLHs
         MKQlxEKT5eIVqD74vQQr8ifYehcKZB73lvxvF7x1ycxhZ3EjHpYT9SH0ki3ZmZIBBW
         7sPgAQpHi+Ef0fpq4uRf1bwtCPlSbGdZ4LTTDaMck7oBytW7tRGw8Hlfek+x8wGOuo
         KqsuG03IqMqyKVtid4Tqft829/OJH9acWux7LnS6qFMtw7k6f+5z6XdX3e9YqAYpbk
         avFmgq/RXUhWs4/0tqbPXl9xdyTGbYH05eWAXbKsRQ8gYhzR0SpT5KwOjNiuZd5HYF
         3vH8hs1zr8aXQ==
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-27ff83feb29so4896443a91.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 07:24:52 -0800 (PST)
X-Gm-Message-State: AOJu0YzARXigmIa+oujRBvjUCAZct5DAOq+F89c4rJ8LVcK4OLMjB2K+
        qgtgb4O1sXKKs5X1ZI0AT8kNjQtqhnHv/PdVNe+CiQ==
X-Google-Smtp-Source: AGHT+IF3ktHxB7VN7h7FmgdH5lCDH3Ks1p1hDBNcAIeVd4vaaIDYb0i0Jwhb005tXkBoWfmuLXk7FSJspBWkumAMsJY=
X-Received: by 2002:a17:90b:1d83:b0:279:2dac:80b3 with SMTP id
 pf3-20020a17090b1d8300b002792dac80b3mr11363391pjb.44.1700580291565; Tue, 21
 Nov 2023 07:24:51 -0800 (PST)
MIME-Version: 1.0
References: <20231119194740.94101-1-ryncsn@gmail.com> <20231119194740.94101-6-ryncsn@gmail.com>
 <CAF8kJuMx5HbSRogY4mVoZ1EELHbmZpOnwv5fRdOE7xvNhjZDbA@mail.gmail.com>
 <CAMgjq7Bo8=gTe2LTtwVruakvj2RLjMHkqxDC3bY0gwpEPKjzRw@mail.gmail.com>
 <CAF8kJuMoiGe3e98Lx0NWmb25vVx0s3SdKqR3yiiG2rQKk0ztNQ@mail.gmail.com> <CAMgjq7Cf1jQnnvWB-DCORhGBacbbnKa4Q_G-+3Z7Nwz-Ogxxzw@mail.gmail.com>
In-Reply-To: <CAMgjq7Cf1jQnnvWB-DCORhGBacbbnKa4Q_G-+3Z7Nwz-Ogxxzw@mail.gmail.com>
From:   Chris Li <chrisl@kernel.org>
Date:   Tue, 21 Nov 2023 07:24:40 -0800
X-Gmail-Original-Message-ID: <CAF8kJuMX1vYgeA1MoXNR_mwmzZ0JcZ8wMgEG8NqzphwLxV6qpg@mail.gmail.com>
Message-ID: <CAF8kJuMX1vYgeA1MoXNR_mwmzZ0JcZ8wMgEG8NqzphwLxV6qpg@mail.gmail.com>
Subject: Re: [PATCH 05/24] mm/swap: move readahead policy checking into swapin_readahead
To:     Kairui Song <ryncsn@gmail.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        "Huang, Ying" <ying.huang@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org
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

On Tue, Nov 21, 2023 at 12:33=E2=80=AFAM Kairui Song <ryncsn@gmail.com> wro=
te:
> > In a strange way it makes sense to charge to C.
> > Swap out =3D=3D free up memory.
> > Swap in =3D=3D consume memory.
> > C turn off swap, effectively this behavior will consume a lot of memory=
.
> > C gets charged, so if the C is out of memory, it will punish C.
> > C will not be able to continue swap in memory. The problem gets under c=
ontrol.
>
> Yes, I think charging either C or B makes sense in their own way. To
> me I think current behavior is kind of counter-intuitive.
>
> Image if there are cgroup PC1, and its child cgroup CC1, CC2. If a proces=
s
> swapped out some memory in CC1 then moved to CC2, and CC1 is dying.
> On swapoff the charge will be moved out of PC1...

Yes. In the spirit of punishing the one that is actively doing bad
deeds, the swapoff charge move out of PC1 makes sense, because the
memory effectively is not used in PC1 any more.

The question is why do you want to move the process from CC1 to CC2?
Move process between CGroup is not something supported very well in
the current CGroup model. The memory already charged to the current
CGroup will not move with the process.

> And swapoff often happens in some unlimited admin cgroup or some
> cgroup for management agents.
>
> If PC1 has a memory limit, the process in it can breach the limit easily,
> we will see a process that never left PC1 having a much higher RSS
> than PC1/CC1/CC2's limit.

Hmm, how do you set the limit on PC1? Do you set a hard limit
"memory.max"? What does the "PC1/memory.stat" show?
If you have a script to reproduce this behavior, I would love to learn more=
.

> And if there is a limit for the management agent cgroup, the agent
> will be OOM instead of OOM in PC1.

It seems what you want to do is have a way for the admin agent to turn
off the swapping on PC1 and let PC1 OOM, right?
In other words, you want the admin agent to turn off swapping in PC1's cont=
ext.
How about start a bash script, add itself to PC1/cgroup.procs, then
that bash script calls swap off for that PC1.
Will that solve your problem?

I am still not sure why you want to turn off swap for PC1? If you know
PC1 is going to OOM, why not just kill it? A little bit more of the
context of the problem will help me understand your usage case.

> Simply moving a process between the child cgroup of the same parent
> cgroup won't cause a similar issue, things get weird when swapoff is
> involved.

Again, having a reproducing script is very helpful for understanding
what is going on. It can serve as a regression testing tool.

> And actually with multiple layers of swap, it's less risky to swapoff
> a device since other swap devices can catch over committed memory.

Sure. Do you have any feedback if we have "memory.swap.tiers", will
that address your need to control swap usage for individual cgroup?
>
> Oh, and there is one more case I forgot to cover in this series:
> Moving a process is indeed something not happening very frequently,
> but a process run in cgroup then exit, and leave some shmem swapped
> out could be a common case.

That is the zombie memcg problem with shared memory. The current
cgroup does work well with shared memory objects. It is another can of
worms.

> Current behavior on swapoff will move these charges out of the
> original parent cgroup too.
>
> So maybe a more ideal solution for swapoff is: simply always charge a
> dying cgroup parent cgroup?

That is the recharging idea. In this year's LSFMM there is a
presentation about zombie memcgs. Recharging/reparenting is one of the
proposals. If I recall correctly, someone from SUSE made some comment
that they tried it in their kernel at one point. But it had a lot of
issues and the feature was removed from the kernel eventually.

I also made a proposal for a shared memory cgroup model as well. I can
dig it up if you are interested.

> Maybe a sysctl/cmdline could be introduced to control the behavior.

I am against this kind of one off behavior change without a consistent
model of charging the memory. Even behind a sysctl, it is some code we
need to maintain and test function properly.
If you want to change the memory charging model, I would like to see
what is the high level principle it follows so we can reason it in
other usage cases consistently. The least thing I want to see is to
make up rules as we go, then we might end up with contradicting rules
and back ourselves to a corner in the future.
I do care about your usage case, I just want to address it consistently.
My understanding of the current memory cgroup model is charge to the
first use. Punish the trouble maker.

BTW, I am still reviewing your 24 patches series, half way through. It
will take me a bit of time to write up the reply.

Chris
