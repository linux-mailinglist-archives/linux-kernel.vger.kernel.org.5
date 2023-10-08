Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7512C7BCAD1
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 02:50:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234228AbjJHAtw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 20:49:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234241AbjJHAtp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 20:49:45 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1F5B18A;
        Sat,  7 Oct 2023 17:49:22 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF941C433C9;
        Sun,  8 Oct 2023 00:49:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696726159;
        bh=CcuH1njAq6dkAJa0wVnUYRW2piKEopxux2hQDJOyrMQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AxixlpuH9Di5w8WNvX+43cV9OxBVqIVG60rXZ5oIyGQ4NjBg8Y5uCfLhjQJzFrjVL
         ajZvi6Qm4dOcdugNyYu/mXM4iC2BTYRyQ3POB8JWd+j8ko7BWiubLzbOsyU4BCEiNN
         HFvuN99C/G0a3/kF2SaGMkAtv7ohlW+GO7TfenBO2ewjBuHP7wsOp27aFwgpdzPwAQ
         hmC1Clj8H/DoUEPIXkxpxf3CqGDnw/tixyMi9xgPNA5hBCA7Cm4/civ7S05lDKBSXq
         jvGnbCrnNU1+Nj45ZJhbS7qb3IgVSRIThnk1rU++deSylub8xyHI21B/OtN2H9TfB4
         RD3QfrJGUE/Rw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
        Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>,
        Jeffrey Hugo <quic_jhugo@quicinc.com>,
        Sasha Levin <sashal@kernel.org>, ogabbay@kernel.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.5 14/18] accel/ivpu: Don't flood dmesg with VPU ready message
Date:   Sat,  7 Oct 2023 20:48:48 -0400
Message-Id: <20231008004853.3767621-14-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231008004853.3767621-1-sashal@kernel.org>
References: <20231008004853.3767621-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.5.6
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>

[ Upstream commit 002652555022728c42b5517c6c11265b8c3ab827 ]

Use ivpu_dbg() to print the VPU ready message so it doesn't pollute
the dmesg.

Signed-off-by: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
Reviewed-by: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
Reviewed-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
Signed-off-by: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20230925121137.872158-3-stanislaw.gruszka@linux.intel.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/accel/ivpu/ivpu_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/accel/ivpu/ivpu_drv.c b/drivers/accel/ivpu/ivpu_drv.c
index 8396db2b52030..09dee5be20700 100644
--- a/drivers/accel/ivpu/ivpu_drv.c
+++ b/drivers/accel/ivpu/ivpu_drv.c
@@ -303,7 +303,7 @@ static int ivpu_wait_for_ready(struct ivpu_device *vdev)
 	}
 
 	if (!ret)
-		ivpu_info(vdev, "VPU ready message received successfully\n");
+		ivpu_dbg(vdev, PM, "VPU ready message received successfully\n");
 	else
 		ivpu_hw_diagnose_failure(vdev);
 
-- 
2.40.1

