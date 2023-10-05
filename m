Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0E297BA6C1
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 18:41:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233756AbjJEQlf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 12:41:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232409AbjJEQj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 12:39:58 -0400
Received: from out-196.mta1.migadu.com (out-196.mta1.migadu.com [95.215.58.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E4AC204F
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 09:23:38 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1696523016;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=yC6D3i3jig2GyzUXuhIeWlA/aD4BBPaKKdQ3mOuig0o=;
        b=q7JydKkWVxDOqEumo0+HHW6e98K99TlfpQTisybmzkBpdV9tlNO0Oc6eoM7K5o5ga4vsuv
        rWQLgrPs8xIAlCZfY3+XFCnGu3qRYqbnsedHD3t3lsBYUtKXkakIjh8dUGw7GWGrb7fydk
        DTh6pOZTWFsnev6TZgzTUFyPV+JK20Q=
From:   Yajun Deng <yajun.deng@linux.dev>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com
Cc:     linux-kernel@vger.kernel.org, Yajun Deng <yajun.deng@linux.dev>
Subject: [PATCH 0/2] Move sched_rt_entity::back to RT_GROUP_SCHED
Date:   Fri,  6 Oct 2023 00:23:15 +0800
Message-Id: <20231005162317.3343678-1-yajun.deng@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The member back in struct sched_rt_entity only related to RT_GROUP_SCHED,
it should not place out of RT_GROUP_SCHED, move back to RT_GROUP_SCHED.
It will save a few bytes.

The 1st patch is introduce for_each_sched_rt_entity_back() & use it.
it no functional changes.
The 2nd patch is move sched_rt_entity::back to under the
CONFIG_RT_GROUP_SCHED block, it will save a few bytes.

Yajun Deng (2):
  sched/rt: Introduce for_each_sched_rt_entity_back() & use it
  sched/rt: Move sched_rt_entity::back to under the
    CONFIG_RT_GROUP_SCHED block

 include/linux/sched.h |  2 +-
 kernel/sched/rt.c     | 25 ++++++++++++++++---------
 2 files changed, 17 insertions(+), 10 deletions(-)

-- 
2.25.1

