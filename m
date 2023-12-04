Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E742802A95
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 04:45:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234417AbjLDDne (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 22:43:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjLDDnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 22:43:32 -0500
X-Greylist: delayed 37577 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 03 Dec 2023 19:43:36 PST
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [20.231.56.155])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4D56BC4
        for <linux-kernel@vger.kernel.org>; Sun,  3 Dec 2023 19:43:36 -0800 (PST)
Received: from luzhipeng.223.5.5.5 (unknown [60.186.191.128])
        by mail-app2 (Coremail) with SMTP id by_KCgCnrtbgSm1lZ41EAA--.54620S2;
        Mon, 04 Dec 2023 11:43:29 +0800 (CST)
From:   Zhipeng Lu <alexious@zju.edu.cn>
To:     alexious@zju.edu.cn
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/radeon/trinity_dpm: fix a memleak in trinity_parse_power_table
Date:   Mon,  4 Dec 2023 11:43:09 +0800
Message-Id: <20231204034309.3290173-1-alexious@zju.edu.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: by_KCgCnrtbgSm1lZ41EAA--.54620S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Xr43Xw47WrWUuryDWry5CFg_yoWkXrb_Ga
        y8Z3s7Wryj9Fn5u3W8AFsxWrZakF1F9r48u3WftanYqFyIvrn7u392grnxX3sxGFs3AFyD
        AF18Wr43Zrn3WjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb2AFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr1j
        6rxdM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
        0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
        jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
        1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkIecxEwVAFwVW8GwCF
        04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r
        18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vI
        r41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr
        1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvE
        x4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JU-miiUUUUU=
X-CM-SenderInfo: qrsrjiarszq6lmxovvfxof0/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The rdev->pm.dpm.ps allocated by kcalloc should be freed in every
following error-handling path. However, in the error-handling of
rdev->pm.power_state[i].clock_info the rdev->pm.dpm.ps is not freed,
resulting in a memleak in this function.

Fixes: d70229f70447 ("drm/radeon/kms: add dpm support for trinity asics")
Signed-off-by: Zhipeng Lu <alexious@zju.edu.cn>
---
 drivers/gpu/drm/radeon/trinity_dpm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/radeon/trinity_dpm.c b/drivers/gpu/drm/radeon/trinity_dpm.c
index 08ea1c864cb2..8bf56fb7b933 100644
--- a/drivers/gpu/drm/radeon/trinity_dpm.c
+++ b/drivers/gpu/drm/radeon/trinity_dpm.c
@@ -1727,6 +1727,7 @@ static int trinity_parse_power_table(struct radeon_device *rdev)
 		non_clock_info = (struct _ATOM_PPLIB_NONCLOCK_INFO *)
 			&non_clock_info_array->nonClockInfo[non_clock_array_index];
 		if (!rdev->pm.power_state[i].clock_info)
+			kfree(rdev->pm.dpm.ps);
 			return -EINVAL;
 		ps = kzalloc(sizeof(struct sumo_ps), GFP_KERNEL);
 		if (ps == NULL) {
-- 
2.34.1

