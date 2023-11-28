Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 244837FC8A0
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 22:53:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376308AbjK1VOg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 16:14:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346908AbjK1VNz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 16:13:55 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 338F31BE1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 13:08:03 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BC66C433CA;
        Tue, 28 Nov 2023 21:08:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701205683;
        bh=B6jdAq523tUTjoQ/nCF3xKon70u7LX+Geuk+Zb+g6Ek=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IqV0e0Z6x5uPyZ+oCWXC3AwUalzh4Q1FYVS1NrD4Oar2zOBmB851+5Q6twvWjulCv
         +OnN5Pjvb1l1aUMyC6mibXOsgwlIUj46oaHdy+U74fT9TnVGTEjLyfCBNLzDWb6uER
         DzM2q1302mUKkA8qq9oGBt6ODZt2rEaoh0H5Ff2ozWjauxzOIH1CAMFcEGlKzSKm+q
         aCtysG2bSLFOK13or5NH5BsjWySadT/zzGm/trKN1+CuvqPNuqCeLuQ2lPSv4aE0o7
         5aXWSa5s/NmCw4wqHD2T/CbFBeDhLVaUiiYKmiWD0U23pM1E7FHWQE5dIkF+dUfLzf
         C269ev8dJE91w==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <sashal@kernel.org>, tj@kernel.org,
        josef@toxicpanda.com, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 05/25] blk-cgroup: bypass blkcg_deactivate_policy after destroying
Date:   Tue, 28 Nov 2023 16:07:21 -0500
Message-ID: <20231128210750.875945-5-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231128210750.875945-1-sashal@kernel.org>
References: <20231128210750.875945-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.64
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
index 60f366f98fa2b..1b7fd1fc2f337 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -462,6 +462,7 @@ static void blkg_destroy_all(struct gendisk *disk)
 	struct request_queue *q = disk->queue;
 	struct blkcg_gq *blkg, *n;
 	int count = BLKG_DESTROY_BATCH_SIZE;
+	int i;
 
 restart:
 	spin_lock_irq(&q->queue_lock);
@@ -487,6 +488,18 @@ static void blkg_destroy_all(struct gendisk *disk)
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

