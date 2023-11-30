Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34D617FFCF2
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 21:43:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376706AbjK3Uno (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 15:43:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232306AbjK3Unk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 15:43:40 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1268FD40
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 12:43:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701377026;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=8uUhkmFY3baFHZKA0GPbNGpyZmiXUmHvRAktUmbwJUI=;
        b=MURdM+rtQK0ICYoELfWy4Z9LcDVgCeAQZvmxqJibUZSc6yRhXKvJ249n8xjtRIqJhoIuz2
        0jfUpJ8SqkxQDpsJNB8tNV8GRpAHE0teZdyi3nK58HWnByZHYSn9P8u9TWtw0CROaOcTJ8
        eEUIAxj/U4EFZlxifmgxXcvZm53nSFM=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-74-hNwsiTMiMOu0QY_LOCCSfg-1; Thu,
 30 Nov 2023 15:43:44 -0500
X-MC-Unique: hNwsiTMiMOu0QY_LOCCSfg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 843A01C06ED1;
        Thu, 30 Nov 2023 20:43:43 +0000 (UTC)
Received: from llong.com (unknown [10.22.9.192])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E72D340C6EB9;
        Thu, 30 Nov 2023 20:43:42 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Cc:     cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Joe Mario <jmario@redhat.com>,
        Sebastian Jug <sejug@redhat.com>,
        Yosry Ahmed <yosryahmed@google.com>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH-cgroup v5 0/2] cgroup/rstat: Further reduce cpu_lock hold time in cgroup_rstat_flush_locked
Date:   Thu, 30 Nov 2023 15:43:25 -0500
Message-Id: <20231130204327.494249-1-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 v5:
  - Drop patch "cgroup/rstat: Reduce cpu_lock hold time in
    cgroup_rstat_flush_locked()" as it has been merged into the for-6.8
    branch.
  - Rework the recursive cgroup_rstat_push_children() into an iterative
    function to prevent possibility of stack overflow.

 v4:
  - Update patch 2 to fix a minor bug and update some of the comments.

 v3:
  - Minor comment twisting as suggested by Yosry.
  - Add patches 2 and 3 to further reduce lock hold time

The purpose of this patch series is to further reduce the cpu_lock
hold time of cgroup_rstat_flush_locked() so as to reduce the latency
impact when cgroup_rstat_updated() is called as they may contend with
each other on the cpu_lock.

Waiman Long (2):
  cgroup/rstat: Optimize cgroup_rstat_updated_list()
  cgroup: Avoid false cacheline sharing of read mostly rstat_cpu

 include/linux/cgroup-defs.h |   7 ++
 kernel/cgroup/rstat.c       | 153 +++++++++++++++++++++---------------
 2 files changed, 98 insertions(+), 62 deletions(-)

-- 
2.39.3

