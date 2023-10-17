Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BE497CC6D7
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 16:53:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344191AbjJQOxO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 10:53:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235147AbjJQOxA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 10:53:00 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBF995BBA
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 07:51:27 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id af79cd13be357-77063481352so570758485a.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 07:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1697554286; x=1698159086; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=N5FO3wWvQMky4isidchl4+kOtGJ4NGoQiZPEFFej4sM=;
        b=KERFHROQv4T8NmbMFGaqqdyXcpqGjvwxVw7p6dfpFhME3fYd/UABGorm3zOyWEHehe
         ae3IYQ5ksNePIk995G1cBcBlP5hIVxSYAvaz3VwQohpfY+VPQeh/9EHIHWByU4hUDqTw
         I22LXuDpS1G/S64aS4B3yhVqQi8bWChQwPZW2I7vmUxX44pftSxjh2369Gap853D9lAO
         PveT3n8zhABb5X0asRZ9hQ2TtGAIZ9hLjUyEsomRuMXFpYb7VkYbUPuXcZKdkXO2HMVd
         8ndB9vNNyz3cqecFJ6hC0Sgijr7jf/+q2KhkLPXPCpUuCQrSsz6mN6LRn1E3dHIPwdu1
         uCdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697554286; x=1698159086;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N5FO3wWvQMky4isidchl4+kOtGJ4NGoQiZPEFFej4sM=;
        b=m/+8oMGmkyi2zW/vFNpdSxFLl073ytddhn8d+mNU0R1ftGs141V8d0Z7n65fKyyTAH
         VGCIR4cO9GBCZ1HAOnr1MExMO/Ng7gS4fFIyeXgGDRIVYysBRDjWHFv2lFcnYSWvyYoP
         ZoBinbdggRRnW3W8Tq0x051ElhWv1Nib0/LXq3IRNSkSv1/M6Xnntim7ohS9sYbhxnZ1
         nxGOO9SSUD+kp2OOvmHWgTC1f3UiXuFTZW0deZ4HMPrHESr6BSvRTrhIw6KShTx0HRZi
         3D3afkGfZlpWEEoVIQLj1ZME7sDTUlLbl0RnQV1j/5j3CUNgAxcA4+YnkPkPWlbDaosI
         BXDQ==
X-Gm-Message-State: AOJu0YxrOyrR3ZKu7LcGVUrsq2Ax7HGD4ZK4OpeN/zyYSETV+prq6GvS
        YQQxaSLrotGo4IwX8mabKnZenA==
X-Google-Smtp-Source: AGHT+IF2q7fH7erJb+ALBTQzyw0uBgX3n0GRSRGDiBPBYXAS8xGIvLeQTOS1Axkw//NbOBVGus1Ayw==
X-Received: by 2002:a05:620a:2586:b0:76e:f686:cad8 with SMTP id x6-20020a05620a258600b0076ef686cad8mr2571083qko.13.1697554285812;
        Tue, 17 Oct 2023 07:51:25 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:f369])
        by smtp.gmail.com with ESMTPSA id q17-20020ad44351000000b0065b1bcd0d33sm606598qvs.93.2023.10.17.07.51.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 07:51:25 -0700 (PDT)
Date:   Tue, 17 Oct 2023 10:51:24 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Nhat Pham <nphamcs@gmail.com>, akpm@linux-foundation.org,
        cerasuolodomenico@gmail.com, sjenning@redhat.com,
        ddstreet@ieee.org, vitaly.wool@konsulko.com, hughd@google.com,
        corbet@lwn.net, konrad.wilk@oracle.com, senozhatsky@chromium.org,
        rppt@kernel.org, linux-mm@kvack.org, kernel-team@meta.com,
        linux-kernel@vger.kernel.org, david@ixit.cz,
        Wei Xu <weixugc@google.com>, Chris Li <chrisl@kernel.org>,
        Greg Thelen <gthelen@google.com>
Subject: Re: [PATCH 0/2] minimize swapping on zswap store failure
Message-ID: <20231017145124.GA1122010@cmpxchg.org>
References: <20231017003519.1426574-1-nphamcs@gmail.com>
 <CAJD7tka6XRyzYndRNEFZmi0Zj4DD2KnVzt=vMGhfF4iN2B4VKw@mail.gmail.com>
 <20231017044745.GC1042487@cmpxchg.org>
 <CAJD7tkbEJDczxPqp2ZcZiz1ZWYdUWZLaiovxiGWcM57md-URhA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJD7tkbEJDczxPqp2ZcZiz1ZWYdUWZLaiovxiGWcM57md-URhA@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 16, 2023 at 10:33:23PM -0700, Yosry Ahmed wrote:
> On Mon, Oct 16, 2023 at 9:47 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
> > On Mon, Oct 16, 2023 at 05:57:31PM -0700, Yosry Ahmed wrote:
> > > On Mon, Oct 16, 2023 at 5:35 PM Nhat Pham <nphamcs@gmail.com> wrote:
> > So I obviously agree that we still need to invest in decoupling zswap
> > space from physical disk slots. It's insanely wasteful, especially
> > with larger memory capacities. But while it would be a fantastic
> > optimization, I don't see how it would be an automatic solution to the
> > problem that inspired this proposal.
> 
> Well, in my head, I imagine such a world where we have multiple
> separate swapping backends with cgroup knob(s) that control what
> backends are allowed for each cgroup. A zswap-is-terminal knob is
> hacky-ish way of doing that where the backends are only zswap and disk
> swap.

"I want compression" vs "I want disk offloading" is a more reasonable
question to ask at the cgroup level. We've had historically a variety
of swap configurations across the fleet. E.g. it's a lot easier to add
another swapfile than it is to grow an existing one at runtime. In
other cases, one storage config might have one swapfile, another
machine model might want to spread it out over multiple disks etc.

This doesn't matter much with ghost files. But with conventional
swapfiles this requires an unnecessary awareness of the backend
topology in order to express container policy. That's no bueno.

> > > Perhaps there is a way we can do this without allocating a zswap entry?
> > >
> > > I thought before about having a special list_head that allows us to
> > > use the lower bits of the pointers as markers, similar to the xarray.
> > > The markers can be used to place different objects on the same list.
> > > We can have a list that is a mixture of struct page and struct
> > > zswap_entry. I never pursued this idea, and I am sure someone will
> > > scream at me for suggesting it. Maybe there is a less convoluted way
> > > to keep the LRU ordering intact without allocating memory on the
> > > reclaim path.
> >
> > That should work. Once zswap has exclusive control over the page, it
> > is free to muck with its lru linkage. A lower bit tag on the next or
> > prev pointer should suffice to distinguish between struct page and
> > struct zswap_entry when pulling stuff from the list.
> 
> Right.
> 
> We handle incompressible memory internally in a different way, we put
> them back on the unevictable list with an incompressible page flag.
> This achieves a similar effect.

It doesn't. We want those incompressible pages to continue aging
alongside their compressible peers, and eventually get written back to
disk with them.
