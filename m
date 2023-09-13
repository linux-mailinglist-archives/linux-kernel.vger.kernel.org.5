Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E98679DCEA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 02:01:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232142AbjIMABY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 20:01:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbjIMABW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 20:01:22 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B209F10E6
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 17:01:18 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-26934bc3059so280928a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 17:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694563278; x=1695168078; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=y/Q7bkPiUIkagJc1JU2t5jAEeKH7MiIhHAkk2p3uzGo=;
        b=pSprO7GBpG11Thf5c5i9699ROwAbl3e2YNZt6b/GFfteuKgWZyjjm3XpxDn0fcEoYw
         ly7ID+4AJNlK0BvWP5acrb2SYZz4U9DFzF54zqq2n9DJpx3n2KoaxNeXey4NcKccZtc2
         /1tb8VrqwiKFW9cpyevWnV7rw0vXeCDzMLAVxxfpFv7n0MGSxS8gLW0MGPOBCPqhmbiu
         Lc2sEVxG8dRZCydvuRrWSqQxA++MCSJs6f8MKg1p4JeTZ2y7zAKRxIFlWMcPFsJsCW97
         wtqCzj8HswBTM9+IperGLaO61h+KBeIuSBXkQiSfFOF3Rnan6TWHJ9JUpJHS2lbD/f5W
         7lKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694563278; x=1695168078;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y/Q7bkPiUIkagJc1JU2t5jAEeKH7MiIhHAkk2p3uzGo=;
        b=MVM3f50eNJVAAVBCWyFqwf+5A96FcHRPfwuWVa0ccKyqF+uSGv9jkvwRXKkQnMBdMd
         10oreOv41QBKJEmQFX8K8Z8RL0gvPPOFEAJ/drCOlkdmNK6iLfj86ID1rQ2oelLnFZ7C
         7W8Z5bZeqkcYIGsmIOW/b8bbSen3IBeqJdClks8imnhIfNeQxBOOwmGy1c4ejTOXEI/S
         nD8ruEBzUtXP9z5JcpVvfOoC8p/0GNbtjMfuxc9yXNCQH8qJuaMMTsC+9hlJDbWZMV4L
         KL0xuwedEbwtiRIxnKwo38c2oi4x0np9FQa6qrGvVaNpFntvjRb2NCIrM1CB3vykRi7c
         JG1g==
X-Gm-Message-State: AOJu0YxWQQRQbq6liIYU5n+TmUkeTV9jcH3qQQZ6qDZsLTHw0yHlhCQA
        O31rnEQ7HS7xPETxfC/fTARUDxB4K40=
X-Google-Smtp-Source: AGHT+IGcglZ2x/MlceOhu/+LsvqEGp+O/m7oFsUO1srinD7/I5SKcqgvDjUC+N+ZJ8bJ6y28e6Avdw==
X-Received: by 2002:a17:90b:4b82:b0:26d:689f:4253 with SMTP id lr2-20020a17090b4b8200b0026d689f4253mr5532999pjb.6.1694563277551;
        Tue, 12 Sep 2023 17:01:17 -0700 (PDT)
Received: from localhost ([216.228.127.131])
        by smtp.gmail.com with ESMTPSA id a10-20020a17090ad80a00b0025bdc3454c6sm165381pjv.8.2023.09.12.17.01.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 17:01:17 -0700 (PDT)
Date:   Tue, 12 Sep 2023 17:01:15 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tariq Toukan <tariqt@nvidia.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        shiju.jose@huawei.com, jonathan.cameron@huawei.com,
        prime.zeng@huawei.com, linuxarm@huawei.com,
        yangyicong@hisilicon.com,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH v2 0/6] sched fixes
Message-ID: <ZQD7yy0aGUpCoG6C@yury-ThinkPad>
References: <20230819141239.287290-1-yury.norov@gmail.com>
 <ZOiRHPvVfB8Q7TLv@yury-ThinkPad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZOiRHPvVfB8Q7TLv@yury-ThinkPad>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Another ping... 

On Fri, Aug 25, 2023 at 04:31:44AM -0700, Yury Norov wrote:
> Ping?
> 
> On Sat, Aug 19, 2023 at 07:12:32AM -0700, Yury Norov wrote:
> > Fixes for recently introduced sched_numa_find_nth_cpu(), and minor
> > improvements in sched/fair.
> > 
> > v1: https://lore.kernel.org/lkml/20230810162442.9863-1-yury.norov@gmail.com/T/
> > v2:
> >  - fix wording in commit messages;
> >  - move nearest node search inside rcu lock section in
> >    sched_numa_find_nth_cpu();
> >  - move NUMA_NO_NODE handling inside sched_numa_find_nth_cpu();
> >  - rewrite comment for sched_numa_find_nth_cpu().
> >  - add review tag from Yicong Yang.
> > 
> > Yury Norov (6):
> >   numa: generalize numa_map_to_online_node()
> >   sched/fair: fix opencoded numa_nearest_node()
> >   sched: fix sched_numa_find_nth_cpu() in CPU-less case
> >   sched: fix sched_numa_find_nth_cpu() in non-NUMA case
> >   sched: handle NUMA_NO_NODE in sched_numa_find_nth_cpu()
> >   sched: fix sched_numa_find_nth_cpu() comment
> > 
> >  include/linux/numa.h     |  7 +++++--
> >  include/linux/topology.h |  2 +-
> >  kernel/sched/fair.c      | 14 +-------------
> >  kernel/sched/topology.c  | 25 +++++++++++++++++--------
> >  lib/cpumask.c            |  4 +---
> >  mm/mempolicy.c           | 18 +++++++++++-------
> >  6 files changed, 36 insertions(+), 34 deletions(-)
> > 
> > -- 
> > 2.39.2
