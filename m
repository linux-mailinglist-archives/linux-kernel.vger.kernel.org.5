Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D1A78137BD
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 18:12:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443898AbjLNRL7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 12:11:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230344AbjLNRLj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 12:11:39 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5659BD43
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 09:11:44 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id d75a77b69052e-42542b1ed5dso62934621cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 09:11:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1702573903; x=1703178703; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mxUe6pUm6l0Cf+AsboBSISPAY2O3/ATI4QcyYk76Qaw=;
        b=ZuWmgDP2RPaxeToLI4GdiMy0n9VxgleimNq2Ve4UflR5VmtBU/ObovLmEhb8iV6WCX
         q08ZFqn9iBh0SPTx7tbVeCSrRH8RtzvpeMMo6TU06LNRldgfAavMySNRqRL9s7ZULgGx
         PNOprntlR9j+rTVN1mELsQ8Bv+ZniUijGGoeLamYbtTPesAS9ZejDsxiLcpJScYpIvJR
         W8Tiw4m0H8xjZVbglShYPEol5K7oNPazMeni8ExOpd7QHTmFCku4cf2QMCD/EhKynml+
         qEcOp1Aj1ihSJHusQt7/SeHiDKo9rJspkAgJzUlZ5Lw0/BvlY2xR/fnonBUrYWZWzcjz
         jNzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702573903; x=1703178703;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mxUe6pUm6l0Cf+AsboBSISPAY2O3/ATI4QcyYk76Qaw=;
        b=b3cipJnPxuIIOxOncC9v5SesX8/b4hSbVILeHYlVvpmabfkq9vrtZTEq4ZfjWgcLNB
         HL5osy/eY7e0aWA0CBjk2zd+sBidr6ZQikjIEwJCkpuGBKy1otQhJJ8NPqjZEoal8i76
         wZqMgR9cRK0xFzIOqV1cUwPRKYo9aiH5QZP6LopgMMPQXpX8zCjVgz5u8RTzUPY/ZhQB
         wRXcpowBdk2f+JZgXUPPT2z0ZLMkmGTVu6b0sqz7IFQfJ3z7XosKpGz03LGftORlUz9g
         LhrNC6zAD929GLubNKBWsnGyOAoqgR61FOZ8PsY9l4FQNSvSBVmQTGz7uhhFzUBNjdnE
         aXhg==
X-Gm-Message-State: AOJu0YzF9QvW8mt7XoSogdxrfj71mUFw5uKDtGuVpf5OiicNKtkPkto6
        KhOPVqRaQ1Ccxbybyq4j61bMuA==
X-Google-Smtp-Source: AGHT+IGDCYzqXWzUxXKjMVSmW4MwYuT+8dRIEGxntC/zMVHNGiAZX7h9jOSwoAdpLErOc9Au0X9hgA==
X-Received: by 2002:ac8:7d52:0:b0:425:4043:96e2 with SMTP id h18-20020ac87d52000000b00425404396e2mr15224897qtb.111.1702573903122;
        Thu, 14 Dec 2023 09:11:43 -0800 (PST)
Received: from localhost ([2620:10d:c091:400::5:a0a6])
        by smtp.gmail.com with ESMTPSA id e7-20020ac845c7000000b00418122186ccsm5911083qto.12.2023.12.14.09.11.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 09:11:42 -0800 (PST)
Date:   Thu, 14 Dec 2023 12:11:37 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Minchan Kim <minchan@kernel.org>
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
Message-ID: <20231214171137.GA261942@cmpxchg.org>
References: <20231207192406.3809579-1-nphamcs@gmail.com>
 <CAF8kJuPEKWbr_1a-OzqrYKSPmuty==KhC2vbTPAmm9xcJHo4cg@mail.gmail.com>
 <CAKEwX=Oj0Rur8i9Oo7y2Py7svx-g11sEj3GKQfMVL62x=4hvdA@mail.gmail.com>
 <CAF8kJuNpnqTM5x1QmQ7h-FaRWVnHBdNGvGvB3txohSOmZhYA-Q@mail.gmail.com>
 <20231209034229.GA1001962@cmpxchg.org>
 <ZXeTb_ACou7TEVsa@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXeTb_ACou7TEVsa@google.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 11, 2023 at 02:55:43PM -0800, Minchan Kim wrote:
> On Fri, Dec 08, 2023 at 10:42:29PM -0500, Johannes Weiner wrote:
> > On Fri, Dec 08, 2023 at 03:55:59PM -0800, Chris Li wrote:
> > > I can give you three usage cases right now:
> > > 1) Google producting kernel uses SSD only swap, it is currently on
> > > pilot. This is not expressible by the memory.zswap.writeback. You can
> > > set the memory.zswap.max = 0 and memory.zswap.writeback = 1, then SSD
> > > backed swapfile. But the whole thing feels very clunky, especially
> > > what you really want is SSD only swap, you need to do all this zswap
> > > config dance. Google has an internal memory.swapfile feature
> > > implemented per cgroup swap file type by "zswap only", "real swap file
> > > only", "both", "none" (the exact keyword might be different). running
> > > in the production for almost 10 years. The need for more than zswap
> > > type of per cgroup control is really there.
> > 
> > We use regular swap on SSD without zswap just fine. Of course it's
> > expressible.
> > 
> > On dedicated systems, zswap is disabled in sysfs. On shared hosts
> > where it's determined based on which workload is scheduled, zswap is
> > generally enabled through sysfs, and individual cgroup access is
> > controlled via memory.zswap.max - which is what this knob is for.
> > 
> > This is analogous to enabling swap globally, and then opting
> > individual cgroups in and out with memory.swap.max.
> > 
> > So this usecase is very much already supported, and it's expressed in
> > a way that's pretty natural for how cgroups express access and lack of
> > access to certain resources.
> > 
> > I don't see how memory.swap.type or memory.swap.tiers would improve
> > this in any way. On the contrary, it would overlap and conflict with
> > existing controls to manage swap and zswap on a per-cgroup basis.
> > 
> > > 2) As indicated by this discussion, Tencent has a usage case for SSD
> > > and hard disk swap as overflow.
> > > https://lore.kernel.org/linux-mm/20231119194740.94101-9-ryncsn@gmail.com/
> > > +Kairui
> > 
> > Multiple swap devices for round robin or with different priorities
> > aren't new, they have been supported for a very, very long time. So
> > far nobody has proposed to control the exact behavior on a per-cgroup
> > basis, and I didn't see anybody in this thread asking for it either.
> > 
> > So I don't see how this counts as an obvious and automatic usecase for
> > memory.swap.tiers.
> > 
> > > 3) Android has some fancy swap ideas led by those patches.
> > > https://lore.kernel.org/linux-mm/20230710221659.2473460-1-minchan@kernel.org/
> > > It got shot down due to removal of frontswap. But the usage case and
> > > product requirement is there.
> > > +Minchan
> > 
> > This looks like an optimization for zram to bypass the block layer and
> > hook directly into the swap code. Correct me if I'm wrong, but this
> > doesn't appear to have anything to do with per-cgroup backend control.
> 
> Hi Johannes,
> 
> I haven't been following the thread closely, but I noticed the discussion
> about potential use cases for zram with memcg.
> 
> One interesting idea I have is to implement a swap controller per cgroup.
> This would allow us to tailor the zram swap behavior to the specific needs of
> different groups.
> 
> For example, Group A, which is sensitive to swap latency, could use zram swap
> with a fast compression setting, even if it sacrifices some compression ratio.
> This would prioritize quick access to swapped data, even if it takes up more space.
> 
> On the other hand, Group B, which can tolerate higher swap latency, could benefit
> from a slower compression setting that achieves a higher compression ratio.
> This would maximize memory efficiency at the cost of slightly slower data access.
> 
> This approach could provide a more nuanced and flexible way to manage swap usage
> within different cgroups.

That makes sense to me.

It sounds to me like per-cgroup swapfiles would be the easiest
solution to this. Then you can create zram devices with different
configurations and assign them to individual cgroups.

This would also apply to Kairu's usecase: assign zrams and hdd backups
as needed on a per-cgroup basis.

In addition, it would naturally solve scalability and isolation
problems when multiple containers would otherwise be hammering on the
same swap backends and locks.

It would also only require one, relatively simple new interface, such
as a cgroup parameter to swapon().

That's highly preferable over a complex configuration file like
memory.swap.tiers that needs to solve all sorts of visibility and
namespace issues and duplicate the full configuration interface of
every backend in some new, custom syntax.
