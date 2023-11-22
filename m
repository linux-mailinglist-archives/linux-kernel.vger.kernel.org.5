Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 921ED7F41CF
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 10:38:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343510AbjKVJii (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 04:38:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235129AbjKVJih (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 04:38:37 -0500
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1391183
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 01:38:33 -0800 (PST)
Message-ID: <109029e0-1772-4102-a2a8-ab9076462454@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1700645911;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=hzQTsEYOMm4An3het2XGLy3/nW2/MSOzvCz8NWvRraU=;
        b=gENINQ8D2HHl+YbB5l3Lhsql8T2XGT6IAOflzD6Ia6CIkZjbuFWGyp8zNJ5jEgQZeGszrA
        vHmtt3dZdiuT83pKrz220NM+97JIGMnfllW/viSxKcyLZdBT7+xrWV6MLnEgez0v1Xr9el
        e2qhBZE1nE2FWIH01b8P5SEx6uaZU9g=
Date:   Wed, 22 Nov 2023 17:38:25 +0800
MIME-Version: 1.0
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Chengming Zhou <chengming.zhou@linux.dev>
To:     LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>
Cc:     jack@suse.cz, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Christoph Hellwig <hch@lst.de>, shr@devkernel.io,
        neilb@suse.de, Michal Hocko <mhocko@suse.com>
Subject: Question: memcg dirty throttle caused by low per-memcg dirty thresh
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

Sorry to bother you, we encountered a problem related to the memcg dirty
throttle after migrating from cgroup v1 to v2, so want to ask for some
comments or suggestions.

1. Problem

We have the "containerd" service running under system.slice, with
its memory.max set to 5GB. It will be constantly throttled in the
balance_dirty_pages() since the memcg has dirty memory more than
the memcg dirty thresh.

We haven't this problem on cgroup v1, because cgroup v1 doesn't have
the per-memcg writeback and per-memcg dirty thresh. Only the global
dirty thresh will be checked in balance_dirty_pages().

2. Thinking

So we wonder if we can support the per-memcg dirty thresh interface?
Now the memcg dirty thresh is just calculated from memcg max * ratio,
which can be set from /proc/sys/vm/dirty_ratio.

We have to set it to 60 instead of the default 20 to workaround now,
but worry about the potential side effects.

If we can support the per-memcg dirty thresh interface, we can set
some containers to a much higher dirty_ratio, especially for hungry
dirtier workloads like "containerd".

3. Solution?

But we could't think of a good solution to support this. The current
memcg dirty thresh is calculated from a complex rule:

	memcg dirty thresh = memcg avail * dirty_ratio

memcg avail is from combination of: memcg max/high, memcg files
and capped by system-wide clean memory excluding the amount being used
in the memcg.

Although we may find a way to calculate the per-memcg dirty thresh,
we can't use it directly, since we still need to calculate/distribute
dirty thresh to the per-wb dirty thresh share.

R - A - B
    \-- C

For example, if we know the dirty thresh of A, but wb is in C, we
have no way to distribute the dirty thresh shares to the wb in C.

But we have to get the dirty thresh of the wb in C, since we need it
to control throttling process of the wb in balance_dirty_pages().

I may have missed something above, but the problem seems clear IMHO.
Looking forward to any comment or suggestion.

Thanks!
