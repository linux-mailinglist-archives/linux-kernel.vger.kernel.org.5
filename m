Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1596A7E2F97
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 23:09:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233248AbjKFWJk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 17:09:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233169AbjKFWJj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 17:09:39 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0596183
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 14:09:35 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8C18C433C8;
        Mon,  6 Nov 2023 22:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1699308575;
        bh=IYP87mPslCnQl/9LQiXvTbko+eNuU/TJe/cJTwCnwiU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SbKYPCgKGr9KACWJJS6bLYB/tEMKq+JVzVmgV5457dZ5/4owurxJXB9SOlDerCIrE
         MF8DZWFbn5ggyJ/fnlUm6AZ6zPnZacX3M1oa0z7Q2W4l8PKgioBAX8YcaQSE1rLhF/
         Pn5nzm0L9CpSMuvj/QZXPVeRgwlDqmEaT43OH4Qc=
Date:   Mon, 6 Nov 2023 14:09:34 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Dmitry Rokosov <ddrokosov@salutedevices.com>
Cc:     <hannes@cmpxchg.org>, <mhocko@kernel.org>,
        <roman.gushchin@linux.dev>, <shakeelb@google.com>,
        <muchun.song@linux.dev>, <kernel@sberdevices.ru>,
        <rockosov@gmail.com>, <cgroups@vger.kernel.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <bpf@vger.kernel.org>
Subject: Re: [PATCH v1] tools/cgroup: introduce cgroup v2 memory.events
 listener
Message-Id: <20231106140934.3f5d4960141562fe8da53906@linux-foundation.org>
In-Reply-To: <20231013184107.28734-1-ddrokosov@salutedevices.com>
References: <20231013184107.28734-1-ddrokosov@salutedevices.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLACK autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Oct 2023 21:41:07 +0300 Dmitry Rokosov <ddrokosov@salutedevices.com> wrote:

> This is a simple listener for memory events that handles counter
> changes in runtime. It can be set up for a specific memory cgroup v2.
> 
> The output example:
> =====
> $ /tmp/cgroup_v2_event_listener test
> Initialized MEMCG events with counters:
> MEMCG events:
> 	low: 0
> 	high: 0
> 	max: 0
> 	oom: 0
> 	oom_kill: 0
> 	oom_group_kill: 0
> Started monitoring memory events from '/sys/fs/cgroup/test/memory.events'...
> Received event in /sys/fs/cgroup/test/memory.events:
> *** 1 MEMCG oom_kill event, change counter 0 => 1
> Received event in /sys/fs/cgroup/test/memory.events:
> *** 1 MEMCG oom_kill event, change counter 1 => 2
> Received event in /sys/fs/cgroup/test/memory.events:
> *** 1 MEMCG oom_kill event, change counter 2 => 3
> Received event in /sys/fs/cgroup/test/memory.events:
> *** 1 MEMCG oom_kill event, change counter 3 => 4
> Received event in /sys/fs/cgroup/test/memory.events:
> *** 2 MEMCG max events, change counter 0 => 2
> Received event in /sys/fs/cgroup/test/memory.events:
> *** 8 MEMCG max events, change counter 2 => 10
>
> ...
>

Looks nice to me.

Perhaps it should be under ./samples/?

I suggest adding a comment to __memory_events_show() reminding people
to update this code if new events are added.

