Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D61F7EDA4A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 04:34:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344839AbjKPDen (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 22:34:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235663AbjKPDem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 22:34:42 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5FA019B
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 19:34:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700105677;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Fh6sr5djueJxvg69Qt1Q1YfFiPMkWzsCiD40QbSJilw=;
        b=MlPaDj9t9Q3VpepCYrQEERlS/QrIwmwF80slh0jRG/fdWkjhuXs+Kqn43IfCXalWssLPgj
        F6tZI0CCT+zhyt4RuVc5NWZ/iG2ywSrSm8PTf3wfKY9ZCEIt01KUZ8f2SewcTbZIARFVI7
        8Gh9G61VAuuJazS1T/f4dQx3yM56C0U=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-508-LVbmSX7jPZ2g5WfQ6uex4g-1; Wed,
 15 Nov 2023 22:34:34 -0500
X-MC-Unique: LVbmSX7jPZ2g5WfQ6uex4g-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 061C91C04344;
        Thu, 16 Nov 2023 03:34:34 +0000 (UTC)
Received: from llong.com (unknown [10.22.8.169])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 241AF492BFD;
        Thu, 16 Nov 2023 03:34:33 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Peter Hunt <pehunt@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Waiman Long <longman@redhat.com>
Subject: [PATCH v4 0/5] cgroup/cpuset: Improve CPU isolation in isolated partitions
Date:   Wed, 15 Nov 2023 22:34:00 -0500
Message-Id: <20231116033405.185166-1-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v4:
 - Update patch 1 to move apply_wqattrs_lock() and apply_wqattrs_unlock()
   down into CONFIG_SYSFS block to avoid compilation warnings.

v3:
 - Break out a separate patch to make workqueue_set_unbound_cpumask()
   static and move it down to the CONFIG_SYSFS section.
 - Remove the "__DEBUG__." prefix and the CFTYPE_DEBUG flag from the
   new root only cpuset.cpus.isolated control files and update the
   test accordingly.

v2:
 - Add 2 read-only workqueue sysfs files to expose the user requested
   cpumask as well as the isolated CPUs to be excluded from
   wq_unbound_cpumask.
 - Ensure that caller of the new workqueue_unbound_exclude_cpumask()
   hold cpus_read_lock.
 - Update the cpuset code to make sure the cpus_read_lock is held
   whenever workqueue_unbound_exclude_cpumask() may be called.

Isolated cpuset partition can currently be created to contain an
exclusive set of CPUs not used in other cgroups and with load balancing
disabled to reduce interference from the scheduler.

The main purpose of this isolated partition type is to dynamically
emulate what can be done via the "isolcpus" boot command line option,
specifically the default domain flag. One effect of the "isolcpus" option
is to remove the isolated CPUs from the cpumasks of unbound workqueues
since running work functions in an isolated CPU can be a major source
of interference. Changing the unbound workqueue cpumasks can be done at
run time by writing an appropriate cpumask without the isolated CPUs to
/sys/devices/virtual/workqueue/cpumask. So one can set up an isolated
cpuset partition and then write to the cpumask sysfs file to achieve
similar level of CPU isolation. However, this manual process can be
error prone.

This patch series implements automatic exclusion of isolated CPUs from
unbound workqueue cpumasks when an isolated cpuset partition is created
and then adds those CPUs back when the isolated partition is destroyed.

There are also other places in the kernel that look at the HK_FLAG_DOMAIN
cpumask or other HK_FLAG_* cpumasks and exclude the isolated CPUs from
certain actions to further reduce interference. CPUs in an isolated
cpuset partition will not be able to avoid those interferences yet. That
may change in the future as the need arises.

Waiman Long (5):
  workqueue: Make workqueue_set_unbound_cpumask() static
  workqueue: Add workqueue_unbound_exclude_cpumask() to exclude CPUs
    from wq_unbound_cpumask
  selftests/cgroup: Minor code cleanup and reorganization of
    test_cpuset_prs.sh
  cgroup/cpuset: Keep track of CPUs in isolated partitions
  cgroup/cpuset: Take isolated CPUs out of workqueue unbound cpumask

 Documentation/admin-guide/cgroup-v2.rst       |  10 +-
 include/linux/workqueue.h                     |   2 +-
 kernel/cgroup/cpuset.c                        | 286 +++++++++++++-----
 kernel/workqueue.c                            | 165 +++++++---
 .../selftests/cgroup/test_cpuset_prs.sh       | 216 ++++++++-----
 5 files changed, 475 insertions(+), 204 deletions(-)

-- 
2.39.3

