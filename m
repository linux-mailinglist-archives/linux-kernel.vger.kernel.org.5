Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68ABF7FEED2
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 13:21:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231897AbjK3MVB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 07:21:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345191AbjK3MU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 07:20:57 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8FD69A
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 04:21:03 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EDAAC433C9;
        Thu, 30 Nov 2023 12:21:02 +0000 (UTC)
Date:   Thu, 30 Nov 2023 12:21:00 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Waiman Long <longman@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/kmemleak: Add cond_resched() to kmemleak_free_percpu()
Message-ID: <ZWh-LLuTeAGzY3lM@arm.com>
References: <20231127194153.289626-1-longman@redhat.com>
 <ZWYPmCLi9XyUdCNT@arm.com>
 <c0419245-42c8-4df1-9939-a98dd013699a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c0419245-42c8-4df1-9939-a98dd013699a@redhat.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29, 2023 at 05:57:11PM -0500, Waiman Long wrote:
> On 11/28/23 11:04, Catalin Marinas wrote:
> > The problem is looking up the object tree for each per-cpu offset. We
> > can make the percpu pointer handling O(1) since freeing is only done by
> > the main __percpu pointer, so that's the only one needing a look-up. So
> > far the per-cpu pointers are not tracked for leaking, only scanned.
> > 
> > We could just add the per_cpu_ptr(ptr, 0) to the kmemleak
> > object_tree_root but when scanning we don't have an inverse function to
> > get the __percpu pointer back and calculate the pointers for the other
> > CPUs (well, we could with some hacks but they are probably fragile).
> > 
> > What I came up with is a separate object_percpu_tree_root similar to the
> > object_phys_tree_root. The only reason for these additional trees is to
> > look up the kmemleak metadata when needed (usually freeing). They don't
> > contain objects that are tracked for actual leaking, only scanned. A
> > briefly tested patch below. I need to go through it again, update some
> > comments and write a commit log:
[...]
> The patch looks reasonable to me. It also has a side effect of reducing the
> # of kmemleak objects to track especially for system with large number of
> CPUs. Of course, we still need more testing to make sure that it won't break
> anything.

Thanks for having a look. I'll tidy it up and post today or tomorrow. It
can stay in next for a bit before upstreaming to get some exposure
(though not sure many test -next with kmemleak enabled).

-- 
Catalin
