Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E12180F59C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 19:44:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232921AbjLLSnv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 13:43:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbjLLSnu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 13:43:50 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E32BAA
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 10:43:57 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 254FFC433C8;
        Tue, 12 Dec 2023 18:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1702406636;
        bh=nlynSdmzpDeJ4+c9EM+qpsatuZCr/KLNEXvmbTx2z3o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kX3/5sItCGETTmZWXX+yh10B3+D+Df8L8wljrS/HDEa+aEwt0IK1BMEUphHNmNTJh
         oDL/rJUKzY7PECmK6q+FK0Vzu3anqXz5iAulnT78ISVgKdoUubD4fDvi9tXWwYBLBX
         6CJDVd2mkAWP+ce8UzejvIHfokPwPyIWZzlleMWM=
Date:   Tue, 12 Dec 2023 10:43:55 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Yosry Ahmed <yosryahmed@google.com>, Wei Xu <weixugc@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <muchun.song@linux.dev>,
        Ivan Babrou <ivan@cloudflare.com>, Tejun Heo <tj@kernel.org>,
        =?ISO-8859-1?Q? "Michal_Koutn=FD" ?= <mkoutny@suse.com>,
        Waiman Long <longman@redhat.com>, kernel-team@cloudflare.com,
        Greg Thelen <gthelen@google.com>,
        Domenico Cerasuolo <cerasuolodomenico@gmail.com>,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [mm-unstable v4 5/5] mm: memcg: restore subtree stats flushing
Message-Id: <20231212104355.ba052748471e1e0ce5cc35a0@linux-foundation.org>
In-Reply-To: <20231204235856.k4izppfsrpg2rng7@google.com>
References: <20231129032154.3710765-1-yosryahmed@google.com>
        <20231129032154.3710765-6-yosryahmed@google.com>
        <20231202083129.3pmds2cddy765szr@google.com>
        <CAJD7tkZPcBbvcK+Xj0edevemB+801wRvvcFDJEjk4ZcjNVoV_w@mail.gmail.com>
        <CAJD7tkY-YTj-4+A6zQT_SjbYyRYyiJHKc9pf1CMqqwU1VRzxvA@mail.gmail.com>
        <CALvZod5rPrFNLyOpUUbmo2T3zxtDjomDqv+Ba3KyFh=eRwNXjg@mail.gmail.com>
        <CAAPL-u-Futq5biNhQKTVi15vzihZxoan-dVORPqpov1saJ99=Q@mail.gmail.com>
        <CAJD7tkZgP3m-VVPn+fF_YuvXeQYK=tZZjJHj=dzD=CcSSpp2qg@mail.gmail.com>
        <20231204235856.k4izppfsrpg2rng7@google.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Dec 2023 23:58:56 +0000 Shakeel Butt <shakeelb@google.com> wrote:

> On Mon, Dec 04, 2023 at 03:49:01PM -0800, Yosry Ahmed wrote:
> [...]
> > 
> > From 19af26e01f93cbf0806d75a234b78e48c1ce9d80 Mon Sep 17 00:00:00 2001
> > From: Yosry Ahmed <yosryahmed@google.com>
> > Date: Mon, 4 Dec 2023 23:43:29 +0000
> > Subject: [PATCH] mm: memcg: remove stats flushing mutex
> > 
> > The mutex was intended to make the waiters sleep instead of spin, and
> > such that we can check the update thresholds again after acquiring the
> > mutex. However, the mutex has a risk of priority inversion, especially
> > since the underlying rstat lock can de dropped while the mutex is held.
> > 
> > Synthetic testing with high concurrency of flushers shows no
> > regressions without the mutex, so remove it.
> > 
> > Suggested-by: Shakeel Butt <shakeelb@google.com>
> > Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> 
> Acked-by: Shakeel Butt <shakeelb@google.com>
> 

I'd like to move this series into mm-stable soon.  Are we all OK with that?
