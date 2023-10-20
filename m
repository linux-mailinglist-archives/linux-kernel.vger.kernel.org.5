Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C96757D0DD6
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 12:45:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377199AbjJTKpv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 06:45:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377184AbjJTKpb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 06:45:31 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 610921BF9
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 03:44:35 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A8D792F4;
        Fri, 20 Oct 2023 03:45:15 -0700 (PDT)
Received: from e122027.cambridge.arm.com (e122027.cambridge.arm.com [10.1.34.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 390923F5A1;
        Fri, 20 Oct 2023 03:44:33 -0700 (PDT)
From:   Steven Price <steven.price@arm.com>
To:     Boris Brezillon <boris.brezillon@collabora.com>,
        Rob Herring <robh@kernel.org>
Cc:     Steven Price <steven.price@arm.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>,
        Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH] drm/panfrost: Remove incorrect IS_ERR() check
Date:   Fri, 20 Oct 2023 11:44:05 +0100
Message-Id: <20231020104405.53992-1-steven.price@arm.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sg_page_iter_page() doesn't return an error code, so the IS_ERR() check
is wrong and the error path will never be executed. This also allows
simplifying the code to remove the local variable 'page'.

CC: Adrián Larumbe <adrian.larumbe@collabora.com>
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/r/376713ff-9a4f-4ea3-b097-fb5efb685d95@moroto.mountain
Signed-off-by: Steven Price <steven.price@arm.com>
---
 drivers/gpu/drm/panfrost/panfrost_dump.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/panfrost/panfrost_dump.c b/drivers/gpu/drm/panfrost/panfrost_dump.c
index e7942ac449c6..47751302f1bc 100644
--- a/drivers/gpu/drm/panfrost/panfrost_dump.c
+++ b/drivers/gpu/drm/panfrost/panfrost_dump.c
@@ -220,16 +220,8 @@ void panfrost_core_dump(struct panfrost_job *job)
 
 		iter.hdr->bomap.data[0] = bomap - bomap_start;
 
-		for_each_sgtable_page(bo->base.sgt, &page_iter, 0) {
-			struct page *page = sg_page_iter_page(&page_iter);
-
-			if (!IS_ERR(page)) {
-				*bomap++ = page_to_phys(page);
-			} else {
-				dev_err(pfdev->dev, "Panfrost Dump: wrong page\n");
-				*bomap++ = 0;
-			}
-		}
+		for_each_sgtable_page(bo->base.sgt, &page_iter, 0)
+			*bomap++ = page_to_phys(sg_page_iter_page(&page_iter));
 
 		iter.hdr->bomap.iova = mapping->mmnode.start << PAGE_SHIFT;
 
-- 
2.34.1

