Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACD947BDBAC
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 14:23:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376392AbjJIMXc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 08:23:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376364AbjJIMXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 08:23:30 -0400
Received: from out-208.mta0.migadu.com (out-208.mta0.migadu.com [91.218.175.208])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 517D899
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 05:23:27 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1696854206;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pOSdnU//ZRui2s27MXfjnW8MdGjzkW8wxZ4C5+bH6Oo=;
        b=PvcXroXrprpbYbEiTKcBlDzrNxIHYqJQlTyn41kwGmaXE3WAnFw/W12yM8Dh7G5G4p9n2L
        jiy/MdWQj2Dwe14V1229DeYuc5rdV+oVyf0hmEy6v2/e7BhMxMMHD/GGn6i4bULZTecDms
        H99KLe2PP7QMZU3Xvyx79kfOGc5Jwgk=
From:   Yajun Deng <yajun.deng@linux.dev>
To:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com
Cc:     linux-kernel@vger.kernel.org, Yajun Deng <yajun.deng@linux.dev>
Subject: [PATCH v7 3/3] sched/headers: Move sched_rt_entity::back to under the CONFIG_RT_GROUP_SCHED block
Date:   Mon,  9 Oct 2023 20:22:44 +0800
Message-Id: <20231009122244.2394336-4-yajun.deng@linux.dev>
In-Reply-To: <20231009122244.2394336-1-yajun.deng@linux.dev>
References: <20231009122244.2394336-1-yajun.deng@linux.dev>
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

We already remove the call to the 'back' member when CONFIG_RT_GROUP_SCHED
is disabled.

It's safe to move sched_rt_entity::back to under the
CONFIG_RT_GROUP_SCHED block, it would save a few bytes.

Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
---
v7: Only move back under the CONFIG_RT_GROUP_SCHED block.
v6: Independent patch.
v5: Resend it.
v4: Missed rt_se = root in dequeue_rt_stack().
v3: Keep parent is NULL in init_tg_rt_entry().
v2: Add WARN_ON_ONCE in init_tg_rt_entry().
v1: https://lore.kernel.org/all/20230801062714.3424299-1-yajun.deng@linux.dev/
---
 include/linux/sched.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 292c31697248..d0fe56603e60 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -597,8 +597,8 @@ struct sched_rt_entity {
 	unsigned short			on_rq;
 	unsigned short			on_list;
 
-	struct sched_rt_entity		*back;
 #ifdef CONFIG_RT_GROUP_SCHED
+	struct sched_rt_entity		*back;
 	struct sched_rt_entity		*parent;
 	/* rq on which this entity is (to be) queued: */
 	struct rt_rq			*rt_rq;
-- 
2.25.1

