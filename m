Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF58F7FC843
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 22:52:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234913AbjK1VL4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 16:11:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234878AbjK1VL1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 16:11:27 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0371449D9
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 13:08:49 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8502C433BD;
        Tue, 28 Nov 2023 21:08:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701205729;
        bh=g/4n/1gyrNidi58uj/aOEVUnBhEoWfbEGflIO1f8lf4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tiFjIGxFZGHn7CxrhvwPRjtjwpY9yrVn62fDA5K/jasefCTAObV6+vqqPwk6nji9E
         +ecJBItAqq5LSVNmpU3UkhQrI6RtcpxoVBdHTYtJtSM5L1CCdNmF+7FDUYaKaIxaxe
         9KWUNwc5o2u+b9W6c60Is6p85ZG2Kc6OeVyAox6T1bgRJeu5eq7rfCYTcY2U3K4IjL
         iYNi9TghLB1KfPd/tS/k13Krn8A/Qst+Q5f5Qpg4CYu4czbYfr1eKieVf563jGDFeQ
         Nnh1IjzawYKEa+SxHOwZlGt9SZRBTxd1ND3K8y4f9DIsAVsqkk7YoQ9s6yI+l6QImz
         mgnV5u+DKTuLA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ming Lei <ming.lei@redhat.com>, Changhui Zhong <czhong@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>,
        tj@kernel.org, josef@toxicpanda.com, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 03/15] blk-throttle: fix lockdep warning of "cgroup_mutex or RCU read lock required!"
Date:   Tue, 28 Nov 2023 16:08:24 -0500
Message-ID: <20231128210843.876493-3-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231128210843.876493-1-sashal@kernel.org>
References: <20231128210843.876493-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.140
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ming Lei <ming.lei@redhat.com>

[ Upstream commit 27b13e209ddca5979847a1b57890e0372c1edcee ]

Inside blkg_for_each_descendant_pre(), both
css_for_each_descendant_pre() and blkg_lookup() requires RCU read lock,
and either cgroup_assert_mutex_or_rcu_locked() or rcu_read_lock_held()
is called.

Fix the warning by adding rcu read lock.

Reported-by: Changhui Zhong <czhong@redhat.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
Link: https://lore.kernel.org/r/20231117023527.3188627-2-ming.lei@redhat.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/blk-throttle.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index 68cf8dbb4c67a..4da4b25b12f48 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -1415,6 +1415,7 @@ static void tg_conf_updated(struct throtl_grp *tg, bool global)
 		   tg_bps_limit(tg, READ), tg_bps_limit(tg, WRITE),
 		   tg_iops_limit(tg, READ), tg_iops_limit(tg, WRITE));
 
+	rcu_read_lock();
 	/*
 	 * Update has_rules[] flags for the updated tg's subtree.  A tg is
 	 * considered to have rules if either the tg itself or any of its
@@ -1442,6 +1443,7 @@ static void tg_conf_updated(struct throtl_grp *tg, bool global)
 		this_tg->latency_target = max(this_tg->latency_target,
 				parent_tg->latency_target);
 	}
+	rcu_read_unlock();
 
 	/*
 	 * We're already holding queue_lock and know @tg is valid.  Let's
-- 
2.42.0

