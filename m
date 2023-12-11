Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3532980DF2F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 00:03:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbjLKWzz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 17:55:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbjLKWzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 17:55:41 -0500
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D314F9A;
        Mon, 11 Dec 2023 14:55:47 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id 5614622812f47-3b9e2a014e8so3361930b6e.2;
        Mon, 11 Dec 2023 14:55:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702335347; x=1702940147; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jR8cUnQxE8Fxjjkvko5Z57/p4/4j9l8gY2eevyVTgGg=;
        b=i4QnZhx5jBd+twQDJQcFQHkDBJbxvntV0tYd3zd/qlEwgrHSORXmI2VhNGmnsc3w0t
         XBKYkPRZoRGVIrZXzZGGbC1CcVwyPkFs5W47uO38vUAlRZ8c03CxAA+EARsm2ph5Txu1
         sDmCIvVxIn3B7CSioar0dBUamrHe/rHuULey94iDc955LHlvEh8ESQeH6A/X5f2kBwqN
         JyWY0w7jphiPAKGPKi0jWX4A567+F9g6d5gDT5OiuCDM14RA92OGJ3S9KdUYHM6lHyGd
         n4+mgRgqzELEQXuT6uholJTxXVY6h4C/xLsbEGMQ4mR/DUCbFqOdxaZ5N8LHoD2UrzL4
         8bNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702335347; x=1702940147;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jR8cUnQxE8Fxjjkvko5Z57/p4/4j9l8gY2eevyVTgGg=;
        b=NfdISvxr1nTAj9MYcFQDQVv5Iu4zb0MyjL1cd7b5b5I5zi+lHwmm+Tq/+2OERg95R/
         TXjWH08LIgk+znxqVT95W6rocppJWHosNQRcU5QojuS0ClFhEj9rbTaFX0LBpB7wJD07
         a1XCNcL8FgFeaeM2v7shwbW7PPJM2MfnQxSG/WBL0VX33Y0pj7UxxuDTtH2ZqsF69n2k
         5WXJwNmfhfv/CBsnxlhtFuA7jamST/KgnjgjgWlWHbIWzynQ10ppvv3xE3IJ7f3bx1wm
         nXThfdNbvTpzpu5xKWR8d7ZTnP9/jC3awqX0s+//FEI9HUKTmObmZTZ3/6jr6EtmKBu2
         kxIA==
X-Gm-Message-State: AOJu0YzFfpeLXWR2O2Mnzsx9qfJPl7JHQYyYENQFYXjZZx+XWSM/TAzw
        dJ0K2iVZSqz/UfPhL1Hg46U=
X-Google-Smtp-Source: AGHT+IHDuAZTdcpV4XmlTA7uKfI6uuIRe4lg1MZit6+j+D1VUZEhU7umSXUI8zWgVm0W+j1ePT9gJA==
X-Received: by 2002:a05:6808:1704:b0:3a4:316c:8eeb with SMTP id bc4-20020a056808170400b003a4316c8eebmr6901931oib.40.1702335346953;
        Mon, 11 Dec 2023 14:55:46 -0800 (PST)
Received: from google.com ([2620:0:1000:8411:f6ed:4bc3:49fd:2063])
        by smtp.gmail.com with ESMTPSA id s16-20020a62e710000000b006cb4fa1174dsm6792664pfh.124.2023.12.11.14.55.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 14:55:46 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Mon, 11 Dec 2023 14:55:43 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Chris Li <chrisl@kernel.org>, Nhat Pham <nphamcs@gmail.com>,
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
Subject: Re: [PATCH v6] zswap: memcontrol: implement zswap writeback disabling
Message-ID: <ZXeTb_ACou7TEVsa@google.com>
References: <20231207192406.3809579-1-nphamcs@gmail.com>
 <CAF8kJuPEKWbr_1a-OzqrYKSPmuty==KhC2vbTPAmm9xcJHo4cg@mail.gmail.com>
 <CAKEwX=Oj0Rur8i9Oo7y2Py7svx-g11sEj3GKQfMVL62x=4hvdA@mail.gmail.com>
 <CAF8kJuNpnqTM5x1QmQ7h-FaRWVnHBdNGvGvB3txohSOmZhYA-Q@mail.gmail.com>
 <20231209034229.GA1001962@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231209034229.GA1001962@cmpxchg.org>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 08, 2023 at 10:42:29PM -0500, Johannes Weiner wrote:
> On Fri, Dec 08, 2023 at 03:55:59PM -0800, Chris Li wrote:
> > I can give you three usage cases right now:
> > 1) Google producting kernel uses SSD only swap, it is currently on
> > pilot. This is not expressible by the memory.zswap.writeback. You can
> > set the memory.zswap.max = 0 and memory.zswap.writeback = 1, then SSD
> > backed swapfile. But the whole thing feels very clunky, especially
> > what you really want is SSD only swap, you need to do all this zswap
> > config dance. Google has an internal memory.swapfile feature
> > implemented per cgroup swap file type by "zswap only", "real swap file
> > only", "both", "none" (the exact keyword might be different). running
> > in the production for almost 10 years. The need for more than zswap
> > type of per cgroup control is really there.
> 
> We use regular swap on SSD without zswap just fine. Of course it's
> expressible.
> 
> On dedicated systems, zswap is disabled in sysfs. On shared hosts
> where it's determined based on which workload is scheduled, zswap is
> generally enabled through sysfs, and individual cgroup access is
> controlled via memory.zswap.max - which is what this knob is for.
> 
> This is analogous to enabling swap globally, and then opting
> individual cgroups in and out with memory.swap.max.
> 
> So this usecase is very much already supported, and it's expressed in
> a way that's pretty natural for how cgroups express access and lack of
> access to certain resources.
> 
> I don't see how memory.swap.type or memory.swap.tiers would improve
> this in any way. On the contrary, it would overlap and conflict with
> existing controls to manage swap and zswap on a per-cgroup basis.
> 
> > 2) As indicated by this discussion, Tencent has a usage case for SSD
> > and hard disk swap as overflow.
> > https://lore.kernel.org/linux-mm/20231119194740.94101-9-ryncsn@gmail.com/
> > +Kairui
> 
> Multiple swap devices for round robin or with different priorities
> aren't new, they have been supported for a very, very long time. So
> far nobody has proposed to control the exact behavior on a per-cgroup
> basis, and I didn't see anybody in this thread asking for it either.
> 
> So I don't see how this counts as an obvious and automatic usecase for
> memory.swap.tiers.
> 
> > 3) Android has some fancy swap ideas led by those patches.
> > https://lore.kernel.org/linux-mm/20230710221659.2473460-1-minchan@kernel.org/
> > It got shot down due to removal of frontswap. But the usage case and
> > product requirement is there.
> > +Minchan
> 
> This looks like an optimization for zram to bypass the block layer and
> hook directly into the swap code. Correct me if I'm wrong, but this
> doesn't appear to have anything to do with per-cgroup backend control.

Hi Johannes,

I haven't been following the thread closely, but I noticed the discussion
about potential use cases for zram with memcg.

One interesting idea I have is to implement a swap controller per cgroup.
This would allow us to tailor the zram swap behavior to the specific needs of
different groups.

For example, Group A, which is sensitive to swap latency, could use zram swap
with a fast compression setting, even if it sacrifices some compression ratio.
This would prioritize quick access to swapped data, even if it takes up more space.

On the other hand, Group B, which can tolerate higher swap latency, could benefit
from a slower compression setting that achieves a higher compression ratio.
This would maximize memory efficiency at the cost of slightly slower data access.

This approach could provide a more nuanced and flexible way to manage swap usage
within different cgroups.
