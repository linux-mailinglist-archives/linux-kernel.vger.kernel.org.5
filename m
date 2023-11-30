Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B83097FFDA0
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 22:37:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376964AbjK3VhM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 16:37:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376859AbjK3VhL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 16:37:11 -0500
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD3E910D9;
        Thu, 30 Nov 2023 13:37:17 -0800 (PST)
Received: by mail-oi1-x232.google.com with SMTP id 5614622812f47-3b837d974ecso898633b6e.2;
        Thu, 30 Nov 2023 13:37:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701380237; x=1701985037; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CfQ/d5DYIynVOODVEmY468fgthwDnp9eRwHJ6ueBpfo=;
        b=HbQEQHlYENUZFMt+wseFb2WxYzlSVZC/MXLQauYyJJvl8hqANKKBpM/iE8i8aT28pc
         Y1nW6fh3AQGkjpj2F2MV2qAH0RPIyO8DvBmB3JUtsXxPbNgXjTYIrhTaWLGQwD2OLGxw
         kRPBv7AVYge3A75tjX4OQHXiUEGrIHAeadxauOuS46YcnXJqLH4g1Hyzz4ucMNuf0YwV
         FU09WV0N5M9gVZclXQduH+J9L2/UC8rG3SAu3E5q8SHmIBn/RQqZHRVFG0lvP8uLwKwl
         IwYV7ObX8F4cOairC0Z/OQY++oSQikOcI//MgXVPAHvD8DgHUvr+gKwT9UNNE6452RD5
         sCbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701380237; x=1701985037;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CfQ/d5DYIynVOODVEmY468fgthwDnp9eRwHJ6ueBpfo=;
        b=hiE4g50KWriPKlTPK1TkPd5xTddTbDGcKqLaP7UKBBSVghI+Lxz8DjTKzEqvHkKqba
         HNRWQ2suRIaLJ9c6So12dgl21j0tKzhxk87T0OO5Bn7dSRoKi5xbQ2q+2Qpu+E1S0m5Z
         Kb+voE0t8TGRia4dk87rmGoiQisAbUInJtJOQwQJQv7O9/X5yAOSjjXxoA6x/o6YhuC0
         84EUBWKK3O48TJoermoK7PEAkyhllZqm/RNTlJ1ssv+o7d4jn4O8/R31ufRazXZO4ufh
         4bzqa/yzoLsdKGT3/GT/n4xfjo+wqgeCn+obYTj9IJqZYW3xsEWviHklr2rs3dfn2Rbo
         LPnw==
X-Gm-Message-State: AOJu0Yy9wqmWq52XNxMwVO/hvOgt+76q8VTskCq7s+ipvJmcGU/8bl45
        HjIwHhp6G6p1gquRYmt527g=
X-Google-Smtp-Source: AGHT+IFKDO4eLK+T7YOvu8d4PYcFnqxoxWaOa3rOgoWOJbXIWxNsKVM65n9edQyADm+sl0ak8p7aoA==
X-Received: by 2002:a05:6808:6407:b0:3b8:4023:86e2 with SMTP id fg7-20020a056808640700b003b8402386e2mr1101641oib.29.1701380236887;
        Thu, 30 Nov 2023 13:37:16 -0800 (PST)
Received: from dschatzberg-fedora-PF3DHTBV ([2620:10d:c091:500::7:5fb0])
        by smtp.gmail.com with ESMTPSA id bj16-20020a05620a191000b0077d66e5b2e6sm855589qkb.3.2023.11.30.13.37.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 13:37:16 -0800 (PST)
Date:   Thu, 30 Nov 2023 16:37:13 -0500
From:   Dan Schatzberg <schatzberg.dan@gmail.com>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Yosry Ahmed <yosryahmed@google.com>, Huan Yang <link@vivo.com>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Huang Ying <ying.huang@intel.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Peter Xu <peterx@redhat.com>,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
        Yue Zhao <findns94@gmail.com>, Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH 0/1] Add swappiness argument to memory.reclaim
Message-ID: <ZWkAiZ+Wx6VwRAPu@dschatzberg-fedora-PF3DHTBV>
References: <20231130153658.527556-1-schatzberg.dan@gmail.com>
 <ZWiw9cEsDap1Qm5h@tiehlicka>
 <20231130165642.GA386439@cmpxchg.org>
 <ZWjm3zRfJhN+dK4p@dschatzberg-fedora-PF3DHTBV>
 <CALvZod5dkpnF5h3u3cfdD4L8SExPZCXaPpt4fvpeVRiHPS8ySA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALvZod5dkpnF5h3u3cfdD4L8SExPZCXaPpt4fvpeVRiHPS8ySA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2023 at 12:30:27PM -0800, Shakeel Butt wrote:
> On Thu, Nov 30, 2023 at 11:47 AM Dan Schatzberg
> <schatzberg.dan@gmail.com> wrote:
> >
> > On Thu, Nov 30, 2023 at 11:56:42AM -0500, Johannes Weiner wrote:
> > > [...]
> > > So I wouldn't say it's merely a reclaim hint. It controls a very
> > > concrete and influential factor in VM decision making. And since the
> > > global swappiness is long-established ABI, I don't expect its meaning
> > > to change significantly any time soon.
> >
> > I want to add to this last point. While swappiness does not have
> > terribly well-defined semantics - it is the (only?) existing mechanism
> > to control balance between anon and file reclaim. I'm merely
> > advocating for the ability to adjust swappiness during proactive
> > reclaim separately from reactive reclaim. To what degree the behavior
> > and semantics of swappiness change is a bit orthogonal here.
> 
> Let me ask my question in this chain as it might have been missed:
> 
> Whatever the semantics of swappiness are (including the edge cases
> like no swap, file_is_tiny, trim cache), should the reclaim code treat
> the global swappiness and user-provided swappiness differently?

I can't think of any reason why we would want swappiness interpreted
differently if it's provided at proactive reclaim time vs
globally. Did you have something in mind here?
