Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4CB675FF2D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 20:36:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229664AbjGXSgH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 14:36:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbjGXSgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 14:36:02 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E3A110E0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 11:35:31 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-991fe70f21bso750123466b.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 11:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690223690; x=1690828490;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RHsSjCzPEu8aIR0EiXrFcnff9X89cuZKlKes/xQyYu4=;
        b=tgJjvbb8fbr4lsjCqG6AjX4CmhOF8BSm7LMTX8UnAu+pO48JGry6u+EknbBFqthu35
         YuLb16ZhBdCfECepHRAACWWL63o2gq9/l0HmXEWAx52uuTkb175nx9DfYQbNGbivylFg
         8GMxtUduFz/VbJuOBPg6gl76EqxGhi7nkt0UgtFWdUkfpx6l+jvy6+AFVLexMgR0OdmO
         pryO0K1ssC1Fditn9CU8HNxmis5RUgMd//HRjjv4ZORGSlZve6Vnh+dC0VqJy5/cx4Dr
         t2S6Z+tc1Q9scwxfvVnl+yfOEF2RgbKrDiwN4JCAZVwAN/G/P1W9vEGjkCcLFY0T0Rbx
         LJ7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690223690; x=1690828490;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RHsSjCzPEu8aIR0EiXrFcnff9X89cuZKlKes/xQyYu4=;
        b=eSjPVeuw5F44pentQ5NVh/nUkrs/8udEXUc1m+gie1D71Ve2y5ntq5q2UWaZVrdxEq
         JZPeGODmn3mQiqWV86YUblsVkAwfDs8dUXPRCkebqnbuapIk2Qpf8qVw/o2w7fCZMBI/
         3aHBOUOBK7m53/yH2lWtR1p2vZN3BkcT8t4n+wstq7zGf6u8brhStuvusvgw+hFkg41I
         5EINXC0zwQjEs/B/r76kalZsWM30ifglt6NbZtGQh5eyOPzLH6gAfnx9BK/OFp5OYLHd
         H7f8QR19GFpaurVcia2CixUZ6LZWdY+88I/uWjhXB4dMmzPHYchcgFKm32vjo9NhDhEt
         pLBQ==
X-Gm-Message-State: ABy/qLbcMoQZqEu8hCfTQX5Z0kyVME103zXvJnJVFZMtoorHoL/1pLb+
        TPDpoFFTaeU4AffjDv3W+iWrOlcVR7ax8kXSx/Tjfw==
X-Google-Smtp-Source: APBJJlHXhwyT47TwVlBofR03GtqUt39PXL5S6GHF7dm7gtIyN2+4uaBe2BqoGZPtzqlb9F3tE/w+t97EgRV0UTvVrIU=
X-Received: by 2002:a17:906:778f:b0:982:45ca:ac06 with SMTP id
 s15-20020a170906778f00b0098245caac06mr10027114ejm.60.1690223689846; Mon, 24
 Jul 2023 11:34:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230719174613.3062124-1-yosryahmed@google.com> <20230724113104.6994bd471fb926ceeaf46707@linux-foundation.org>
In-Reply-To: <20230724113104.6994bd471fb926ceeaf46707@linux-foundation.org>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Mon, 24 Jul 2023 11:34:13 -0700
Message-ID: <CAJD7tkYPr7wsxX9uy7VdL0P4UL=OQWtryKzxcevK8Ja19jbaOg@mail.gmail.com>
Subject: Re: [PATCH] mm: memcg: use rstat for non-hierarchical stats
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 24, 2023 at 11:31=E2=80=AFAM Andrew Morton
<akpm@linux-foundation.org> wrote:
>
> On Wed, 19 Jul 2023 17:46:13 +0000 Yosry Ahmed <yosryahmed@google.com> wr=
ote:
>
> > Currently, memcg uses rstat to maintain hierarchical stats. The rstat
> > framework keeps track of which cgroups have updates on which cpus.
> >
> > For non-hierarchical stats, as memcg moved to rstat, they are no longer
> > readily available as counters. Instead, the percpu counters for a given
> > stat need to be summed to get the non-hierarchical stat value. This
> > causes a performance regression when reading non-hierarchical stats on
> > kernels where memcg moved to using rstat. This is especially visible
> > when reading memory.stat on cgroup v1. There are also some code paths
> > internal to the kernel that read such non-hierarchical stats.
> >
> > It is inefficient to iterate and sum counters in all cpus when the rsta=
t
> > framework knows exactly when a percpu counter has an update. Instead,
> > maintain cpu-aggregated non-hierarchical counters for each stat. During
> > an rstat flush, keep those updated as well. When reading
> > non-hierarchical stats, we no longer need to iterate cpus, we just need
> > to read the maintainer counters, similar to hierarchical stats.
> >
> > A caveat is that we now a stats flush before reading
> > local/non-hierarchical stats through {memcg/lruvec}_page_state_local()
> > or memcg_events_local(), where we previously only needed a flush to
> > read hierarchical stats. Most contexts reading non-hierarchical stats
> > are already doing a flush, add a flush to the only missing context in
> > count_shadow_nodes().
> >
> > With this patch, reading memory.stat from 1000 memcgs is 3x faster on a
> > machine with 256 cpus on cgroup v1:
> >  # for i in $(seq 1000); do mkdir /sys/fs/cgroup/memory/cg$i; done
> >  # time cat /dev/cgroup/memory/cg*/memory.stat > /dev/null
> >  real  0m0.125s
> >  user  0m0.005s
> >  sys   0m0.120s
> >
> > After:
> >  real  0m0.032s
> >  user  0m0.005s
> >  sys   0m0.027s
> >
>
> I'll queue this for some testing, pending reviewer input, please.

Thanks Andrew!

I am doing extra testing of my own as well as of now. Will report back
if anything interesting pops up.
