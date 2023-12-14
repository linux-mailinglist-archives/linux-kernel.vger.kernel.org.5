Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE4EB81371C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 17:59:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443602AbjLNQ7D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 11:59:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443568AbjLNQ7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 11:59:01 -0500
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [207.46.229.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2005D8E
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 08:59:06 -0800 (PST)
Received: from luzhipeng.223.5.5.5 (unknown [115.200.224.93])
        by mail-app4 (Coremail) with SMTP id cS_KCgBnbDRSNHtlxiSWAA--.37213S2;
        Fri, 15 Dec 2023 00:58:58 +0800 (CST)
From:   Zhipeng Lu <alexious@zju.edu.cn>
To:     alexious@zju.edu.cn
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] gpu/drm/radeon: fix two memleaks in radeon_vm_init
Date:   Fri, 15 Dec 2023 00:58:42 +0800
Message-Id: <20231214165843.3484373-1-alexious@zju.edu.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cS_KCgBnbDRSNHtlxiSWAA--.37213S2
X-Coremail-Antispam: 1UD129KBjvdXoWrtrWrGF4rtFyDXF45Zr4UCFg_yoWktrX_uF
        18XasrJa4Dta4kZ3W7Z3Z7Zr92g3y0gw4rtrW8Kr1ft34xX3W8uFy3WFn5Xw45Wa13JFn8
        Cr4vqa4fCrsrGjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbc8FF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
        6F4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc2xSY4AK67AK6r1l
        42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJV
        WUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAK
        I48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F
        4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY
        6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfU838nUUUUU
X-CM-SenderInfo: qrsrjiarszq6lmxovvfxof0/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When radeon_bo_create and radeon_vm_clear_bo fail, the vm->page_tables
allocated before need to be freed. However, neither radeon_vm_init
itself nor its caller have done such deallocation.

Fixes: 6d2f2944e95e ("drm/radeon: use normal BOs for the page tables v4")
Signed-off-by: Zhipeng Lu <alexious@zju.edu.cn>
---
 drivers/gpu/drm/radeon/radeon_vm.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_vm.c b/drivers/gpu/drm/radeon/radeon_vm.c
index 987cabbf1318..c38b4d5d6a14 100644
--- a/drivers/gpu/drm/radeon/radeon_vm.c
+++ b/drivers/gpu/drm/radeon/radeon_vm.c
@@ -1204,13 +1204,17 @@ int radeon_vm_init(struct radeon_device *rdev, struct radeon_vm *vm)
 	r = radeon_bo_create(rdev, pd_size, align, true,
 			     RADEON_GEM_DOMAIN_VRAM, 0, NULL,
 			     NULL, &vm->page_directory);
-	if (r)
+	if (r) {
+		kfree(vm->page_tables);
+		vm->page_tables = NULL;
 		return r;
-
+	}
 	r = radeon_vm_clear_bo(rdev, vm->page_directory);
 	if (r) {
 		radeon_bo_unref(&vm->page_directory);
 		vm->page_directory = NULL;
+		kfree(vm->page_tables);
+		vm->page_tables = NULL;
 		return r;
 	}
 
-- 
2.34.1

