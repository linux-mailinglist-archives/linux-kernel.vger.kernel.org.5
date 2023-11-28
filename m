Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BFF67FC876
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 22:52:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346628AbjK1VGu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 16:06:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346623AbjK1VGa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 16:06:30 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51F5419B6
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 13:06:31 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1F1DC433C7;
        Tue, 28 Nov 2023 21:06:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701205590;
        bh=2N/mmLBe+5qTAT/+qa2Ez8vln2gY4lOqeJTcfaskgY8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AJfZzr2cenOh7VOJK6+KK/uPvazzL87OFH699FxCETsAGCi07jdziRMFYwSVTyquc
         OV8/ixKxmCKAPjlpAbRO79gdvNGP+1jeeG//MXj9hctTcQm1T291xWHMu82jNeIRzV
         1dBdqD6IhSjW4QqZfYLap9q6FylGcW8PCKpPIDm9JW1sUQMOIRKAI8wdoH62Gwe7BR
         0IENvD2AclDgRFd8MkiJ/3Z+xi4PPDm2DamOW6bllJcSklp4pyk45kaYCMhqBtSA75
         08AuHFGEuVWZUAk+oBceDQIUa/sqYNGX7vJqlN7JVfqBMT3Tdt7696njBIw5MH5V3E
         dWoqaWNa9y8hA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <sashal@kernel.org>, tj@kernel.org,
        josef@toxicpanda.com, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 06/40] blk-cgroup: bypass blkcg_deactivate_policy after destroying
Date:   Tue, 28 Nov 2023 16:05:12 -0500
Message-ID: <20231128210615.875085-6-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231128210615.875085-1-sashal@kernel.org>
References: <20231128210615.875085-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.3
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ming Lei <ming.lei@redhat.com>

[ Upstream commit e63a57303599b17290cd8bc48e6f20b24289a8bc ]

blkcg_deactivate_policy() can be called after blkg_destroy_all()
returns, and it isn't necessary since blkg_destroy_all has covered
policy deactivation.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
Link: https://lore.kernel.org/r/20231117023527.3188627-4-ming.lei@redhat.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/blk-cgroup.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 4a42ea2972ad8..4b48c2c440981 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -577,6 +577,7 @@ static void blkg_destroy_all(struct gendisk *disk)
 	struct request_queue *q = disk->queue;
 	struct blkcg_gq *blkg, *n;
 	int count = BLKG_DESTROY_BATCH_SIZE;
+	int i;
 
 restart:
 	spin_lock_irq(&q->queue_lock);
@@ -602,6 +603,18 @@ static void blkg_destroy_all(struct gendisk *disk)
 		}
 	}
 
+	/*
+	 * Mark policy deactivated since policy offline has been done, and
+	 * the free is scheduled, so future blkcg_deactivate_policy() can
+	 * be bypassed
+	 */
+	for (i = 0; i < BLKCG_MAX_POLS; i++) {
+		struct blkcg_policy *pol = blkcg_policy[i];
+
+		if (pol)
+			__clear_bit(pol->plid, q->blkcg_pols);
+	}
+
 	q->root_blkg = NULL;
 	spin_unlock_irq(&q->queue_lock);
 }
-- 
2.42.0

