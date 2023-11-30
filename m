Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39BBA7FF76A
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 17:56:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235192AbjK3Q4q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 11:56:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231837AbjK3Q4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 11:56:44 -0500
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2B2E10D0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 08:56:49 -0800 (PST)
Received: by mail-qv1-xf29.google.com with SMTP id 6a1803df08f44-67a91a373edso715376d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 08:56:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1701363409; x=1701968209; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/OnsmpUH3uPWb9adT3MVl22lO/c/KEyWJNg1p4mH6C4=;
        b=pD6VQ9MKUnuFwBFsGpNoq1+j+vEQX30TouU48TFLZs3HCG35RBzE3NZiZSy/zYHy11
         v0MqMXV72h9+abWZdhIt72lzhSB2z2XKcrpe6yyXB6Bdi+6L8nFB5DyWSrG6OGCPS99N
         IIf6Kx6KaujCQu9xYLMvaW++O47jLXi/QW8giWw9dTsYLWqnazhVlRnGp7JgQz97S2UQ
         e1Ol/ledN1c7peyHRM3SreP2byyLJ12e/fry9GxVEEDdunFAqTwD1lYotaQvFRLznfh4
         2DYYYxBxYESN9HAis3xO23LCAHzB99282VoK5g4V0o6RuFJXYyO1wRYcUFUtjX7QsnEV
         oJQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701363409; x=1701968209;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/OnsmpUH3uPWb9adT3MVl22lO/c/KEyWJNg1p4mH6C4=;
        b=pFvJd3cYxR7fJxqQj7E8QYbv8gL+9y/quxZ8fuPjcPrvnqs9VMOIa7NGEiL3k4EON+
         tHK7dMRA1FNHJ00c5SK7BuMM4C9MoXgyBFINcpPh3iyecwlkRupi4r6Py9f+oYS7E82v
         nme+XQzCil5FWsUGEQgQ0+0XtWuQOIHqLq5VX9HOveYeZ/dP+kbJCvWDucZ8F1sY0fqR
         LNWkm5JvwyUlVGzAli1lnLykW4c99IRGaCK9qSr0nKJtDIO9MUwEehhgvIA/VvXPM+yZ
         lKmGRPsHxZkXxFWMz/XMnJcKOxknygVVASdxJE1J4b3bbbT3vld1G56rL/19o9n/0Bf+
         qy+Q==
X-Gm-Message-State: AOJu0YzYlwewjKsGx9zJsitr8beiITdyFWWaTpj1wS5qEMFvlk5xqFho
        SWkYxn3N3CxZ8uAI0tZgz+e3IA==
X-Google-Smtp-Source: AGHT+IHcJpQUxaVA/+lad1maiVUeE9yNLpI5CPPwm06wwTHhVR25W6sk4PQ/92Cm1s0DXwkSDvsBGA==
X-Received: by 2002:a05:6214:1387:b0:67a:4ab3:991a with SMTP id pp7-20020a056214138700b0067a4ab3991amr14101831qvb.60.1701363408836;
        Thu, 30 Nov 2023 08:56:48 -0800 (PST)
Received: from localhost (2603-7000-0c01-2716-da5e-d3ff-fee7-26e7.res6.spectrum.com. [2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id n3-20020a0ce483000000b0067a33133420sm645030qvl.110.2023.11.30.08.56.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 08:56:48 -0800 (PST)
Date:   Thu, 30 Nov 2023 11:56:42 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Dan Schatzberg <schatzberg.dan@gmail.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Yosry Ahmed <yosryahmed@google.com>, Huan Yang <link@vivo.com>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Huang Ying <ying.huang@intel.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Peter Xu <peterx@redhat.com>,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
        Yue Zhao <findns94@gmail.com>, Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH 0/1] Add swappiness argument to memory.reclaim
Message-ID: <20231130165642.GA386439@cmpxchg.org>
References: <20231130153658.527556-1-schatzberg.dan@gmail.com>
 <ZWiw9cEsDap1Qm5h@tiehlicka>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZWiw9cEsDap1Qm5h@tiehlicka>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2023 at 04:57:41PM +0100, Michal Hocko wrote:
> On Thu 30-11-23 07:36:53, Dan Schatzberg wrote:
> [...]
> > In contrast, I argue in favor of a swappiness setting not as a way to implement
> > custom reclaim algorithms but rather to bias the balance of anon vs file due to
> > differences of proactive vs reactive reclaim. In this context, swappiness is the
> > existing interface for controlling this balance and this patch simply allows for
> > it to be configured differently for proactive vs reactive reclaim.
> 
> I do agree that swappiness is a better interface than explicit anon/file
> but the problem with swappiness is that it is more of a hint for the reclaim
> rather than a real control. Just look at get_scan_count and its history.
> Not only its range has been extended also the extent when it is actually
> used has been changing all the time and I think it is not a stretch to
> assume that trend to continue.

Right, we did tweak the edge behavior of e.g. swappiness=0. And we
extended the range to express "anon is cheaper than file", which
wasn't possible before, to support the compressed memory case.

However, its meaning and impact has been remarkably stable over the
years: it allows userspace to specify the relative cost of paging IO
between file and anon pages. This comment is from 2.6.28:

        /*
         * With swappiness at 100, anonymous and file have the same priority.
         * This scanning priority is essentially the inverse of IO cost.
         */
        anon_prio = sc->swappiness;
        file_prio = 200 - sc->swappiness;

And this is it today:

	/*
	 * Calculate the pressure balance between anon and file pages.
	 *
	 * The amount of pressure we put on each LRU is inversely
	 * proportional to the cost of reclaiming each list, as
	 * determined by the share of pages that are refaulting, times
	 * the relative IO cost of bringing back a swapped out
	 * anonymous page vs reloading a filesystem page (swappiness).
	 *
	 * Although we limit that influence to ensure no list gets
	 * left behind completely: at least a third of the pressure is
	 * applied, before swappiness.
	 *
	 * With swappiness at 100, anon and file have equal IO cost.
	 */
	total_cost = sc->anon_cost + sc->file_cost;
	anon_cost = total_cost + sc->anon_cost;
	file_cost = total_cost + sc->file_cost;
	total_cost = anon_cost + file_cost;

	ap = swappiness * (total_cost + 1);
	ap /= anon_cost + 1;

	fp = (200 - swappiness) * (total_cost + 1);
	fp /= file_cost + 1;

So swappiness still means the same it did 15 years ago. We haven't
changed the default swappiness setting, and we haven't broken any
existing swappiness configurations through VM changes in that time.

There are a few scenarios where swappiness doesn't apply:

- No swap. Oh well, that seems reasonable.

- Priority=0. This applies to near-OOM situations where the MM system
  tries to save itself. This isn't a range in which proactive
  reclaimers (should) operate.

- sc->file_is_tiny. This doesn't apply to cgroup reclaim and thus
  proactive reclaim.

- sc->cache_trim_mode. This implements clean cache dropbehind, and
  applies in the presence of large, non-refaulting inactive cache. The
  assumption there is that this data is reclaimable without involving
  IO to evict, and without the expectation of refault IO in the
  future. Without IO involvement, the relative IO cost isn't a
  factor. This will back off when refaults are observed, and the IO
  cost setting is then taken into account again as expected.

  If you consider swappiness to mean "reclaim what I ask you to", then
  this would override that, yes. But in the definition of relative IO
  cost, this decision making is permissible.

  Note that this applies to the global swappiness setting as well, and
  nobody has complained about it.

So I wouldn't say it's merely a reclaim hint. It controls a very
concrete and influential factor in VM decision making. And since the
global swappiness is long-established ABI, I don't expect its meaning
to change significantly any time soon.
