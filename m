Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 806AD7EC8D5
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 17:44:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232753AbjKOQjt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 11:39:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232446AbjKOQje (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 11:39:34 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E49418E
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 08:39:31 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 724F0C433C7;
        Wed, 15 Nov 2023 16:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700066371;
        bh=ZLWT97N45Ta6Fe0IDs/iYeT0WAcl/lGZt3orsFz1SZA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oLySOhiA1mXQwPlJpUqWK6eDz8jnmmkOA3SHWQaXScZmE4Yutq6tywwIANg93u2t5
         hshGS8/bRmU/Zrw/0Xp91Qzcik5L1i1ZdRv4vlD0ghsUGjLuWOsbWVlUSKwwP1ZyIa
         Kq1d/BAvV0KbVPwJ9vAROTVbyS6fwm/Q0o3UpH8gyy+BDqowDrXLJUTk33pQB1Gg7b
         EuvYULcCEzVkEk9FyXEJN3TMrFNAAG3Nj4qxn+3MaiPJeCHqW98dXCVwT6JmGNalLr
         Z4uwtAB9VoDTpnamehPzdzOl6Q+SBrqbgC1cCnX+3F//gPqiIKsPUWIfmhkoCgsl6a
         j7tBTY3JPC/ag==
From:   Oded Gabbay <ogabbay@kernel.org>
To:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     Dani Liberman <dliberman@habana.ai>
Subject: [PATCH 09/10] accel/habanalabs: print error code when mapping fails
Date:   Wed, 15 Nov 2023 18:39:11 +0200
Message-Id: <20231115163912.1243175-9-ogabbay@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231115163912.1243175-1-ogabbay@kernel.org>
References: <20231115163912.1243175-1-ogabbay@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dani Liberman <dliberman@habana.ai>

Failure to map is considered a non-trivial error and we need to notify
the user about it.

Signed-off-by: Dani Liberman <dliberman@habana.ai>
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>
Signed-off-by: Oded Gabbay <ogabbay@kernel.org>
---
 drivers/accel/habanalabs/common/memory.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/accel/habanalabs/common/memory.c b/drivers/accel/habanalabs/common/memory.c
index 0b8689fe0b64..3348ad12c237 100644
--- a/drivers/accel/habanalabs/common/memory.c
+++ b/drivers/accel/habanalabs/common/memory.c
@@ -955,8 +955,8 @@ static int map_phys_pg_pack(struct hl_ctx *ctx, u64 vaddr,
 				(i + 1) == phys_pg_pack->npages);
 		if (rc) {
 			dev_err(hdev->dev,
-				"map failed for handle %u, npages: %llu, mapped: %llu",
-				phys_pg_pack->handle, phys_pg_pack->npages,
+				"map failed (%d) for handle %u, npages: %llu, mapped: %llu\n",
+				rc, phys_pg_pack->handle, phys_pg_pack->npages,
 				mapped_pg_cnt);
 			goto err;
 		}
@@ -1186,7 +1186,8 @@ static int map_device_va(struct hl_ctx *ctx, struct hl_mem_in *args, u64 *device
 
 	rc = map_phys_pg_pack(ctx, ret_vaddr, phys_pg_pack);
 	if (rc) {
-		dev_err(hdev->dev, "mapping page pack failed for handle %u\n", handle);
+		dev_err(hdev->dev, "mapping page pack failed (%d) for handle %u\n",
+			rc, handle);
 		mutex_unlock(&hdev->mmu_lock);
 		goto map_err;
 	}
-- 
2.34.1

