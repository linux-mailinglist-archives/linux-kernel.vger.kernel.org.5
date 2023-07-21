Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 613A975BB6E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 02:07:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229654AbjGUAH4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 20:07:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjGUAHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 20:07:55 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D31281982
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 17:07:52 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-992acf67388so198354566b.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 17:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689898071; x=1690502871;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OaecvBVf9Flq0C+mZ5QEkg9NA82UBvH6EXy41+0INrA=;
        b=faHYAA+C7baJNH4ty1xusZ1GAMizOuhswFoWstiefxPx5kIsdmuE9U8cUmQHhOeHrk
         5D0dko+MIjrr37VaAnnddqI178VcnobmLffPqhhTmjyA/ZJqzxsB9P3o3tXGl1KOXupN
         41KeL8AVmEyVjcLgywZInS05YyxV5osfdNAJfDYZdF/xdJZRYucW4OPzDbbYhaIpxG+h
         Brosl06kzi75w9/BHG8kM7Porua9q9p8IGdBTIMIO5EoUvyy8aXd9EGU6n3AVAUF8ezX
         36fwLy4GUQZnwDJwnTMrYZAckVf5TRZDItY9IV2nC9OuSWoD/25PQk0tp63E/TydQY1B
         YQ/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689898071; x=1690502871;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OaecvBVf9Flq0C+mZ5QEkg9NA82UBvH6EXy41+0INrA=;
        b=j0FCEBBvGTZMam1BGa1C67WiB4KKRF0RPi0MhaqFXOtdruWrpNFO6bL/NT9rTmN2vb
         1vgT75y/emQW0RpCorJTQ6RR6vB7zYNQqMZ/GlbtIpBrYOQSaGKWkk4Juw07DfHcv09j
         sdJPEt1mcbPkuszCT5H0uMuAKeNa2iDQCOpHeEkJAUutgS7lWdQTpa4ZOXDjWRwQEu91
         x89d1ohRCoDBSANdYjw70Zpo0lnWpWdJ8dxbvCSMYuTkQb8hfw4nItiuAozsgOcRMNe0
         WN3Fem/aroL63ZwQ5gLl4cEJyDRRAuXToMBNqCT8AWNrUEQOueOaJ2o7IMS4fttEzhoy
         zE+w==
X-Gm-Message-State: ABy/qLYoLAxGwfM9Y9kw0ruLb6OqZZubXAg8aQ2D0DbwRX8kziOgWgoI
        y+xfmlb22oLk+Gg4Yu3QBn+gMxPsEGiRxbpQ+PGj2w==
X-Google-Smtp-Source: APBJJlGCmBYCLfGUYj8+RWCJS0Yb3I3KQuFXuZWKw8k0TOqCrXxDtB0PWTMBDKaPH+ebMF2XPV6DTiN8mIa+p43wiTE=
X-Received: by 2002:a17:906:59:b0:99b:4525:e06c with SMTP id
 25-20020a170906005900b0099b4525e06cmr287734ejg.55.1689898071090; Thu, 20 Jul
 2023 17:07:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230720070825.992023-1-yosryahmed@google.com> <ZLnLDlQ/B81Qb9pj@P9FQF9L96D.corp.robot.car>
In-Reply-To: <ZLnLDlQ/B81Qb9pj@P9FQF9L96D.corp.robot.car>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Thu, 20 Jul 2023 17:07:14 -0700
Message-ID: <CAJD7tkYrF9OkfahXVqRMNo2-krrotjeY+Qp-pb9e1ebrFWS6PA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/8] memory recharging for offline memcgs
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Yu Zhao <yuzhao@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        "T.J. Mercier" <tjmercier@google.com>,
        Greg Thelen <gthelen@google.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, cgroups@vger.kernel.org
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

On Thu, Jul 20, 2023 at 5:02=E2=80=AFPM Roman Gushchin <roman.gushchin@linu=
x.dev> wrote:
>
> On Thu, Jul 20, 2023 at 07:08:17AM +0000, Yosry Ahmed wrote:
> > This patch series implements the proposal in LSF/MM/BPF 2023 conference
> > for reducing offline/zombie memcgs by memory recharging [1]. The main
> > difference is that this series focuses on recharging and does not
> > include eviction of any memory charged to offline memcgs.
> >
> > Two methods of recharging are proposed:
> >
> > (a) Recharging of mapped folios.
> >
> > When a memcg is offlined, queue an asynchronous worker that will walk
> > the lruvec of the offline memcg and try to recharge any mapped folios t=
o
> > the memcg of one of the processes mapping the folio. The main assumptio=
n
> > is that a process mapping the folio is the "rightful" owner of the
> > memory.
> >
> > Currently, this is only supported for evictable folios, as the
> > unevictable lru is imaginary and we cannot iterate the folios on it. A
> > separate proposal [2] was made to revive the unevictable lru, which
> > would allow recharging of unevictable folios.
> >
> > (b) Deferred recharging of folios.
> >
> > For folios that are unmapped, or mapped but we fail to recharge them
> > with (a), we rely on deferred recharging. Simply put, any time a folio
> > is accessed or dirtied by a userspace process, and that folio is charge=
d
> > to an offline memcg, we will try to recharge it to the memcg of the
> > process accessing the folio. Again, we assume this process should be th=
e
> > "rightful" owner of the memory. This is also done asynchronously to avo=
id
> > slowing down the data access path.
>
> Unfortunately I have to agree with Johannes, Tejun and others who are not=
 big
> fans of this approach.
>
> Lazy recharging leads to an interesting phenomena: a memory usage of a ru=
nning
> workload may suddenly go up only because some other workload is terminate=
d and
> now it's memory is being recharged. I find it confusing. It also makes ha=
rd
> to set up limits and/or guarantees.

This can happen today.

If memcg A starts accessing some memory and gets charged for it, and
then memcg B also accesses it, it will not be charged for it. If at a
later point memcg A runs into reclaim, and the memory is freed, then
memcg B tries to access it, its usage will suddenly go up as well,
because some other workload experienced reclaim. This is a very
similar scenario, only instead of reclaim, the memcg was offlined. As
a matter of fact, it's common to try to free up a memcg before
removing it (by lowering the limit or using memory.reclaim). In that
case, the net result would be exactly the same -- with the difference
being that recharging will avoid freeing the memory and faulting it
back in.

>
> In general, I don't think we can handle shared memory well without gettin=
g rid
> of "whoever allocates a page, pays the full price" policy and making a sh=
ared
> ownership a fully supported concept. Of course, it's a huge work and I be=
lieve
> the only way we can achieve it is to compromise on the granularity of the
> accounting. Will the resulting system be better in the real life, it's ha=
rd to
> say in advance.
>
> Thanks!
