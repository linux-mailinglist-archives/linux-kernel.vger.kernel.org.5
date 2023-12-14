Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A9CD813897
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 18:34:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444034AbjLNReP convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 14 Dec 2023 12:34:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjLNReO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 12:34:14 -0500
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44ABECF;
        Thu, 14 Dec 2023 09:34:20 -0800 (PST)
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2cc3dd2d897so21397881fa.0;
        Thu, 14 Dec 2023 09:34:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702575258; x=1703180058;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/I1W7e0WksPQr4B0ossVVfyuwCWdZSDTARqTZ332iVA=;
        b=CUjRuZsdP0GVflCOjfnGC+WYb4btVNGptBOItvUMAU4UePmZOcczcXjtdzHm2L3H/d
         Q+k3Y1V/AAs1C+pxIl41XW7NB35N28Lbc7m0S9dPpqbTc4F59Cmunp5/KXpdzAX8sMmz
         BMO3tfgE+iekoWMQz31HtnCry/89hS7mdaSO9Zo/VmeM2uMPA8NuZ9eT+QGoBSkpfuXV
         s7hc0TMRKn8ed1GsEog2SBmDUIVhWKV09qqUiC+LLbtLTxjoTMUtAg8+9O+t9EDAgaMp
         3a1RAUsSpstsowZVepZ+SuTpLtKqM1XZQ+Q7MI2y5R6rJeV5Ht+Bs+zIcwXlwdJ1ck2n
         YvZQ==
X-Gm-Message-State: AOJu0YzeZYakRRAtUKLBMqcc2xaB9MphqiD2whTZDlBFLiFkoFnyz0pl
        CEB6Sb3NZOuyojBHDXLkBQjQJ2Uy3D1CLJVlng==
X-Google-Smtp-Source: AGHT+IGp30y/H8P//ZOKK0ZSEtOYUDKVBBp+xHmSJODVndRI0if5ppAbKb6uab8A8wMFFgIMHH/LKKVpMRst2iIg9nk=
X-Received: by 2002:a05:6512:148:b0:50b:f858:f132 with SMTP id
 m8-20020a056512014800b0050bf858f132mr4870323lfo.132.1702575258112; Thu, 14
 Dec 2023 09:34:18 -0800 (PST)
MIME-Version: 1.0
References: <20231207192406.3809579-1-nphamcs@gmail.com> <CAF8kJuPEKWbr_1a-OzqrYKSPmuty==KhC2vbTPAmm9xcJHo4cg@mail.gmail.com>
 <CAKEwX=Oj0Rur8i9Oo7y2Py7svx-g11sEj3GKQfMVL62x=4hvdA@mail.gmail.com>
 <CAF8kJuNpnqTM5x1QmQ7h-FaRWVnHBdNGvGvB3txohSOmZhYA-Q@mail.gmail.com>
 <20231209034229.GA1001962@cmpxchg.org> <ZXeTb_ACou7TEVsa@google.com> <20231214171137.GA261942@cmpxchg.org>
In-Reply-To: <20231214171137.GA261942@cmpxchg.org>
From:   Christopher Li <chrisl@kernel.org>
Date:   Thu, 14 Dec 2023 09:34:06 -0800
Message-ID: <CANeU7QnR+4Lgt8D9Z+Zo3Ydktx_7n45K0b=kVj+qSOzT=5GGQA@mail.gmail.com>
Subject: Re: [PATCH v6] zswap: memcontrol: implement zswap writeback disabling
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Minchan Kim <minchan@kernel.org>, Nhat Pham <nphamcs@gmail.com>,
        akpm@linux-foundation.org, tj@kernel.org, lizefan.x@bytedance.com,
        cerasuolodomenico@gmail.com, yosryahmed@google.com,
        sjenning@redhat.com, ddstreet@ieee.org, vitaly.wool@konsulko.com,
        mhocko@kernel.org, roman.gushchin@linux.dev, shakeelb@google.com,
        muchun.song@linux.dev, hughd@google.com, corbet@lwn.net,
        konrad.wilk@oracle.com, senozhatsky@chromium.org, rppt@kernel.org,
        linux-mm@kvack.org, kernel-team@meta.com,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        david@ixit.cz, Kairui Song <kasong@tencent.com>,
        Zhongkun He <hezhongkun.hzk@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 14, 2023 at 9:11 AM Johannes Weiner <hannes@cmpxchg.org> wrote:

> > Hi Johannes,
> >
> > I haven't been following the thread closely, but I noticed the discussion
> > about potential use cases for zram with memcg.
> >
> > One interesting idea I have is to implement a swap controller per cgroup.
> > This would allow us to tailor the zram swap behavior to the specific needs of
> > different groups.
> >
> > For example, Group A, which is sensitive to swap latency, could use zram swap
> > with a fast compression setting, even if it sacrifices some compression ratio.
> > This would prioritize quick access to swapped data, even if it takes up more space.
> >
> > On the other hand, Group B, which can tolerate higher swap latency, could benefit
> > from a slower compression setting that achieves a higher compression ratio.
> > This would maximize memory efficiency at the cost of slightly slower data access.
> >
> > This approach could provide a more nuanced and flexible way to manage swap usage
> > within different cgroups.
>
> That makes sense to me.
>
> It sounds to me like per-cgroup swapfiles would be the easiest
> solution to this. Then you can create zram devices with different
> configurations and assign them to individual cgroups.

Ideally you need zram then following swap file after the zram. That
would be a list of the swap files rather than just one swapfile per
cgroup.

>
> This would also apply to Kairu's usecase: assign zrams and hdd backups
> as needed on a per-cgroup basis.

Same there, Kairui's request involves ZRAM and at least one extra swap
file. In other words, you really need a per cgroup swap file list.

>
> In addition, it would naturally solve scalability and isolation
> problems when multiple containers would otherwise be hammering on the
> same swap backends and locks.
>
> It would also only require one, relatively simple new interface, such
> as a cgroup parameter to swapon().
>
> That's highly preferable over a complex configuration file like
> memory.swap.tiers that needs to solve all sorts of visibility and
> namespace issues and duplicate the full configuration interface of
> every backend in some new, custom syntax.

If you don't like the syntax of memory.swap.tiers, I am open to
suggestions of your preferred syntax as well. The essicents of the
swap.tiers is a per cgroup list of the swap back ends. The names imply
that. I am not married to any given syntax of how to specify the list.
Its goal matches the above requirement pretty well.

Chris
