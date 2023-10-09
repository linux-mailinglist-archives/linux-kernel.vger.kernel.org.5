Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D001D7BDBA6
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 14:23:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376332AbjJIMXH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 08:23:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376286AbjJIMXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 08:23:04 -0400
Received: from out-199.mta0.migadu.com (out-199.mta0.migadu.com [IPv6:2001:41d0:1004:224b::c7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DDCDC6
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 05:23:02 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1696854180;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=iwdeMq5QLqWQaEIDgzRtZ3AT4JmA1LYOUpcs8Cc0wKA=;
        b=BL6Hreobou9mTA5iSEyUBjYcJe/XzhePBNgXCf1oVPkA2q7g8NxrKyYhHzqzZZHUl53BEC
        3M7wJ9o4ivJD/EZKCoCaIhYSlq7RByz3HB1+Fs0I2GV7eD8xV7OSoqS2ClYCNVodXSK4Ra
        hGFv+H59kY6nPSN3h1dIwhgCVHqmHTE=
From:   Yajun Deng <yajun.deng@linux.dev>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com
Cc:     linux-kernel@vger.kernel.org, Yajun Deng <yajun.deng@linux.dev>
Subject: [PATCH v7 0/3] sched/rt: Move sched_rt_entity::back to CONFIG_RT_GROUP_SCHED
Date:   Mon,  9 Oct 2023 20:22:41 +0800
Message-Id: <20231009122244.2394336-1-yajun.deng@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The member back in struct sched_rt_entity only related to RT_GROUP_SCHED,
it should not place out of RT_GROUP_SCHED, move back to RT_GROUP_SCHED.
It will save a few bytes.

The 1st patch is introduce for_each_sched_rt_entity_back() & use it,
it no functional changes.

The 2nd patch is init 'back' in init_tg_rt_entry, it remove the call to
back when CONFIG_RT_GROUP_SCHED is disabled.

The 3rd patch is move sched_rt_entity::back to under the
CONFIG_RT_GROUP_SCHED block, it will save a few bytes.

Yajun Deng (3):
  sched/rt: Introduce for_each_sched_rt_entity_back() & use it
  sched/rt: Init 'back' in init_tg_rt_entry
  sched/headers: Move sched_rt_entity::back to under the
    CONFIG_RT_GROUP_SCHED block

 include/linux/sched.h |  2 +-
 kernel/sched/rt.c     | 17 ++++++++++++-----
 2 files changed, 13 insertions(+), 6 deletions(-)

-- 
2.25.1

