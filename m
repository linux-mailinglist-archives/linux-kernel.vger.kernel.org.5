Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E0997FF475
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 17:13:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232098AbjK3QN3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 11:13:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232206AbjK3QN0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 11:13:26 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF9F410F4
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 08:13:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701360808;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=FpCx+tElFli3PJ+oneU0SXM88BJcbodDK/a7dugXEk8=;
        b=baIVJP13w67MIpmugDykzvWlMhEjmGG+s+PctseevpeMy18ZTpuAH3FM3UFJRippnXblTw
        viom+Qkl6N5LKp776MmreEI8UZjOfJf+evoyEZJr4KvDkT/fEjO6jLiMktnp4siVHBzq+P
        161Hh3O84pYsZHF4+0ahzX2NHWUIUdQ=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-350-c9GEYIV5M9i-br_w5rxLiA-1; Thu,
 30 Nov 2023 11:13:16 -0500
X-MC-Unique: c9GEYIV5M9i-br_w5rxLiA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C29B2280142B;
        Thu, 30 Nov 2023 16:12:59 +0000 (UTC)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (unknown [10.39.195.45])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 08FCEC15881;
        Thu, 30 Nov 2023 16:12:56 +0000 (UTC)
From:   Valentin Schneider <vschneid@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Phil Auld <pauld@redhat.com>,
        Clark Williams <williams@redhat.com>,
        Tomas Glozar <tglozar@redhat.com>
Subject: [RFC PATCH 0/2] sched/fair: Delay throttling to kernel exit
Date:   Thu, 30 Nov 2023 17:12:42 +0100
Message-ID: <20231130161245.3894682-1-vschneid@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks

I apologize for the one-big-patch-to-rule-them-all, I tried splitting but I
couldn't get to anything that made sense, so it's one big patch and a small
follow-up.

TL;DR of what I'd like to hear about:
o Is there interest in getting this in for !PREEMPT_RT reasons?
o Any ideas on how to make cgroup migration less horrible so we can fully pop
  out the throttled cfs_rq se's?

Survives a good hour of my testing below on a 4-CPU QEMU system, but I expect
the throttled clocks & PELT to be busted. 
  
Testing
=======

setup
+++++
mount -t cgroup -o cpu none /root/cpu

mkdir /root/cpu/cg0
echo 10000 >  /root/cpu/cg0/cpu.cfs_period_us
echo 1000 > /root/cpu/cg0/cpu.cfs_quota_us

mkdir /root/cpu/cg0/cg00
mkdir /root/cpu/cg0/cg01

mkdir /root/cpu/cg0/cg00/cg000
mkdir /root/cpu/cg0/cg00/cg001

read.sh
+++++++
while true; do cat /sys/devices/system/cpu/smt/active &>/dev/null; done

repro.sh
++++++++
spawn() {
    ./read.sh &
    PID=$!
    echo "Tracing PID${PID}"
    echo $PID > $1
}

spawn cpu/cg0/tasks
spawn cpu/cg0/tasks
spawn cpu/cg0/tasks
spawn cpu/cg0/tasks

spawn cpu/cg0/cg01/tasks

spawn cpu/cg0/cg00/cg000/tasks
spawn cpu/cg0/cg00/cg001/tasks

sleep 1

kill $(jobs -p)

Valentin Schneider (2):
  sched/fair: Only throttle CFS tasks on return to userspace
  sched/fair: Repurpose cfs_rq_throttled()

 include/linux/sched.h |   2 +
 kernel/sched/core.c   |   6 +-
 kernel/sched/debug.c  |   4 +-
 kernel/sched/fair.c   | 296 +++++++++++++++++++++++++++---------------
 kernel/sched/sched.h  |   8 +-
 5 files changed, 204 insertions(+), 112 deletions(-)

--
2.41.0

