Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90BEF77C472
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 02:31:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233158AbjHOAbF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 20:31:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233336AbjHOAah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 20:30:37 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C61E4198D
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 17:30:24 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3fe4ad22eb0so48184165e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 17:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google; t=1692059423; x=1692664223;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dLuShFOThvoDFyPjtjqSrXce/+NsjfeL6FKbvb91ep0=;
        b=CxLgfRZTYE2O+lvzzG0vY5ne298WWrrJYUWkVxMZpLYYaHsHujbTYL5pjKgETSom8D
         vzAAqqBkpXkWiv0++Uxv0ACgo3g3wnwX2egyTis+N6wLSzvjoT/n1He6wzKIsNcmOJPd
         u2v+6Q1C4+SciYbUN3OI8YjqnJpbMRUzxEYaE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692059423; x=1692664223;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dLuShFOThvoDFyPjtjqSrXce/+NsjfeL6FKbvb91ep0=;
        b=hXpIbdsFAOv9PL/FsfyouRYo4efVUSCQOmOZ6Ij26iHWj+psvctAslmp/i4ejrWa43
         UTRl39D5qSbVQVniNMtij6uM+N1SKx5/6MQ8uGkCwxzQleC4q2UdR+ftnqC0RZFVZvQr
         O94UKziiB3/+I1Pp85nSQ/5coOncEK9awaEHim8j5G1fm5CcwsEElRbq9vS5jliPgECV
         Vy/el+s5f/fE/brtt2FDnlKdDFbwG10P8s0gN+lT7yrINIGkc+4+H1Vyp3Drf/dq6Fiy
         Jq5ecZ1+q8eIzzO6rbe0+5Q7+jLpFclyQTg+mqtj5oJsayPrk3UKfBYy14/ZI8bNBxOl
         U1+w==
X-Gm-Message-State: AOJu0YzQBmm6LFeSKGhB1I8F8fhlSjH8Hs8ppgdFfbWwrVLjFBGcg/Js
        g7xjq+zowvJpceHzNeVSSj82igOYVaiLkpXlsceOUgF9QOqNvS6hXsg=
X-Google-Smtp-Source: AGHT+IGyNYUpfBkaRUehRFQ2BJSXZpWDK4rzsea/ReN61axbfTfPHR5q7HWor/xA/ao4HC/HTFvoIKofUvPoizB2tp4=
X-Received: by 2002:a05:600c:3648:b0:3fd:29cf:20c5 with SMTP id
 y8-20020a05600c364800b003fd29cf20c5mr8857963wmq.7.1692059423025; Mon, 14 Aug
 2023 17:30:23 -0700 (PDT)
MIME-Version: 1.0
References: <CABWYdi0c6__rh-K7dcM_pkf9BJdTRtAU08M43KO9ME4-dsgfoQ@mail.gmail.com>
 <20230706062045.xwmwns7cm4fxd7iu@google.com> <CABWYdi2pBaCrdKcM37oBomc+5W8MdRp1HwPpOExBGYfZitxyWA@mail.gmail.com>
 <d3f3a7bc-b181-a408-af1d-dd401c172cbf@redhat.com> <CABWYdi2iWYT0sHpK74W6=Oz6HA_3bAqKQd4h+amK0n3T3nge6g@mail.gmail.com>
 <CABWYdi3YNwtPDwwJWmCO-ER50iP7CfbXkCep5TKb-9QzY-a40A@mail.gmail.com>
 <CABWYdi0+0gxr7PB4R8rh6hXO=H7ZaCzfk8bmOSeQMuZR7s7Pjg@mail.gmail.com>
 <CAJD7tkaf5GNbyhCbWyyLtxpqmZ4+iByQgmS1QEFf+bnEMCdmFA@mail.gmail.com>
 <CAJD7tkb=dUfc=L+61noQYHymHPUHswm_XUyFvRdaZemo80qUdQ@mail.gmail.com> <ZNrEV1qEcQMUgztn@slm.duckdns.org>
In-Reply-To: <ZNrEV1qEcQMUgztn@slm.duckdns.org>
From:   Ivan Babrou <ivan@cloudflare.com>
Date:   Mon, 14 Aug 2023 17:30:11 -0700
Message-ID: <CABWYdi3z7Y4qdjPv4wiHyM6Wvwy_VwSLGA92=_PdYyVZgQDSYQ@mail.gmail.com>
Subject: Re: Expensive memory.stat + cpu.stat reads
To:     Tejun Heo <tj@kernel.org>
Cc:     Yosry Ahmed <yosryahmed@google.com>,
        Waiman Long <longman@redhat.com>,
        Shakeel Butt <shakeelb@google.com>, cgroups@vger.kernel.org,
        Linux MM <linux-mm@kvack.org>,
        kernel-team <kernel-team@cloudflare.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 14, 2023 at 5:18=E2=80=AFPM Tejun Heo <tj@kernel.org> wrote:
>
> Hello,
>
> On Fri, Aug 11, 2023 at 05:01:08PM -0700, Yosry Ahmed wrote:
> > There have been a lot of problems coming from this global rstat lock:
> > hard lockups (when we used to flush atomically), unified flushing
> > being expensive, skipping flushing being inaccurate, etc.
> >
> > I wonder if it's time to rethink this lock and break it down into
> > granular locks. Perhaps a per-cgroup lock, and develop a locking
> > scheme where you always lock a parent then a child, then flush the
> > child and unlock it and move to the next child, etc. This will allow
> > concurrent flushing of non-root cgroups. Even when flushing the root,
> > if we flush all its children first without locking the root, then only
> > lock the root when flushing the top-level children, then some level of
> > concurrency can be achieved.
> >
> > Maybe this is too complicated, I never tried to implement it, but I
> > have been bouncing around this idea in my head for a while now.
> >
> > We can also split the update tree per controller. As far as I can tell
> > there is no reason to flush cpu stats for example when someone wants
> > to read memory stats.
>
> There's another thread. Let's continue there but I'm a bit skeptical whet=
her
> splitting the lock is a good solution here. Regardless of locking, we don=
't
> want to run in an atomic context for that long anwyay.

Could you link to the other thread?
