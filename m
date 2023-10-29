Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09AE67DAFE5
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 00:00:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231414AbjJ2XAv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 19:00:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231730AbjJ2XAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 19:00:06 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEC063AA5;
        Sun, 29 Oct 2023 15:59:04 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7528CC04E60;
        Sun, 29 Oct 2023 22:58:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698620292;
        bh=Aeyih107epWPKzhs1jqlKBh6gEAUWEspZnE0z5pwaxE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sd1n1POXVU/OFJbAlvmbPbSW4lGjmbYep2fHMJU5OZ42kyHBsmF7+v0twaSpe55Nb
         3pSQ4y91qMSuRrgkAYDzpVe28qlRv0h+sDMlU3sm7+Vc5u35MO034MaYYy+mNDv3Xl
         HSNaYwgqZqopDyxAlw7XpCLrrNeoW9IT3QGBnx/+p/WR8dZL+hw7PTznBn133hp+Ba
         7AVVEjnIckUqCh+VmvRNJHNTHA7Kpht4xqT++KNQuvjh6ycRVcitZnbNUEsXnLBAct
         s2LF82SQudJNJvpfyhIaEsNQOs4wdSqxIsdwrBaBKZASKQR6PPI2+tvLeUuSulpH8c
         GKrUpe5egzvcA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Karolina Stolarek <karolina.stolarek@intel.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Sasha Levin <sashal@kernel.org>, ray.huang@amd.com,
        airlied@gmail.com, daniel@ffwll.ch, dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.1 22/39] drm/ttm: Reorder sys manager cleanup step
Date:   Sun, 29 Oct 2023 18:56:54 -0400
Message-ID: <20231029225740.790936-22-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231029225740.790936-1-sashal@kernel.org>
References: <20231029225740.790936-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.60
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Karolina Stolarek <karolina.stolarek@intel.com>

[ Upstream commit 3b401e30c249849d803de6c332dad2a595a58658 ]

With the current cleanup flow, we could trigger a NULL pointer
dereference if there is a delayed destruction of a BO with a
system resource that gets executed on drain_workqueue() call,
as we attempt to free a resource using an already released
resource manager.

Remove the device from the device list and drain its workqueue
before releasing the system domain manager in ttm_device_fini().

Signed-off-by: Karolina Stolarek <karolina.stolarek@intel.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20231016121525.2237838-1-karolina.stolarek@intel.com
Signed-off-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/ttm/ttm_device.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/ttm/ttm_device.c b/drivers/gpu/drm/ttm/ttm_device.c
index b84f74807ca13..ec9ddaad56a05 100644
--- a/drivers/gpu/drm/ttm/ttm_device.c
+++ b/drivers/gpu/drm/ttm/ttm_device.c
@@ -239,10 +239,6 @@ void ttm_device_fini(struct ttm_device *bdev)
 	struct ttm_resource_manager *man;
 	unsigned i;
 
-	man = ttm_manager_type(bdev, TTM_PL_SYSTEM);
-	ttm_resource_manager_set_used(man, false);
-	ttm_set_driver_manager(bdev, TTM_PL_SYSTEM, NULL);
-
 	mutex_lock(&ttm_global_mutex);
 	list_del(&bdev->device_list);
 	mutex_unlock(&ttm_global_mutex);
@@ -252,6 +248,10 @@ void ttm_device_fini(struct ttm_device *bdev)
 	if (ttm_bo_delayed_delete(bdev, true))
 		pr_debug("Delayed destroy list was clean\n");
 
+	man = ttm_manager_type(bdev, TTM_PL_SYSTEM);
+	ttm_resource_manager_set_used(man, false);
+	ttm_set_driver_manager(bdev, TTM_PL_SYSTEM, NULL);
+
 	spin_lock(&bdev->lru_lock);
 	for (i = 0; i < TTM_MAX_BO_PRIORITY; ++i)
 		if (list_empty(&man->lru[0]))
-- 
2.42.0

