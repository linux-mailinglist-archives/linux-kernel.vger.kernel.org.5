Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D897B7F9833
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 05:20:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231599AbjK0EUe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 23:20:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjK0EUc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 23:20:32 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F45912F
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 20:20:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701058838;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=vrAxGQoF6gd7V1Rx42uLiZqFnKDFhpBL7AxUNIWxi4U=;
        b=Q3XDdNwRP+E5asZ57vbeFXiGSxFB0BfKXqKq/waNpSNgqNhWHsSzPvPHMBJT7XeqjcYLk1
        EWUXczMXFCBh1I1r2O0WMGqZTOa1mZjEn28FiUlUCkfl7X8uyP41sfdZIcgwU7XT/vPHMi
        F2zX2Y5bWi3aBh/FaTmF5jF3+b9ZFxE=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-199-4RH_A7RRPmmMZhIo6iqSCA-1; Sun,
 26 Nov 2023 23:20:35 -0500
X-MC-Unique: 4RH_A7RRPmmMZhIo6iqSCA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B35DA3806068;
        Mon, 27 Nov 2023 04:20:34 +0000 (UTC)
Received: from llong.com (unknown [10.22.32.84])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BD8485028;
        Mon, 27 Nov 2023 04:20:33 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Frederic Weisbecker <frederic@kernel.org>
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mrunal Patel <mpatel@redhat.com>,
        Ryan Phillips <rphillips@redhat.com>,
        Brent Rowsell <browsell@redhat.com>,
        Peter Hunt <pehunt@redhat.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH-cgroup 0/2] cgroup/cpuset: Include isolated cpuset CPUs in cpu_is_isolated()
Date:   Sun, 26 Nov 2023 23:19:54 -0500
Message-Id: <20231127041956.266026-1-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset enables the inclusion of CPUs in isolated cpuset partitions
in the cpu_is_isolated() check to reduce interference caused by vmstat
or memcg local stock flushing.

To reduce cpu_is_isolated() call overhead, a seqcount is used to
protect read access of the isolated cpumask without taking any lock. As
a result, the callback_lock is changed to a raw_spinlock_t to make it
work in PREEMPT_RT kernel too.

Waiman Long (2):
  cgroup/cpuset: Make callback_lock a raw_spinlock_t
  cgroup/cpuset: Include isolated cpuset CPUs in cpu_is_isolated() check

 include/linux/cpuset.h          |   6 ++
 include/linux/sched/isolation.h |   4 +-
 kernel/cgroup/cpuset.c          | 127 +++++++++++++++++++-------------
 3 files changed, 85 insertions(+), 52 deletions(-)

-- 
2.39.3

