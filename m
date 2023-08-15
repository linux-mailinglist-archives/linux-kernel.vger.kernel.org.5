Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 350C877C848
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 09:12:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235209AbjHOHGs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 03:06:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235285AbjHOHGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 03:06:22 -0400
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E526E10F9
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 00:05:39 -0700 (PDT)
X-QQ-mid: bizesmtp62t1692083088t8k0r85y
Received: from localhost.localdomain ( [113.57.152.160])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 15 Aug 2023 15:04:46 +0800 (CST)
X-QQ-SSF: 01400000000000G0Z000000A0000000
X-QQ-FEAT: wIl24N/TCD4/tPhPuj+YKhYjoZITwiM2MkS4tlY/grP96nhSNsgYzgnJPQh4K
        zjUwfzcHAo5Q/o5sPzPtgPPU546CRj25sXogatgG/JC68+K8mQR0I0H2hPCGUrXfVh5Lw3H
        QoNifDZMv8P4BX5EpWh/cFAZzDTt75vXgWpgRC0+YKzxgz5Cle8duNf5lRbPFrFywU5FsSt
        +GFtb6FPEL0fs9kgfk2iF/1HuMERaeEF6rd6BhYTqxztII9ZnGySHM7XevWm8zWwkKPhxuT
        bUZ8V8TjAB8P6BdbR0TpwkfBlBx7c+zSfMrArv8ytoFA0uo0Vmf7Ww6A14QC2d+U1YPnRLF
        3uBr6DBN/Rj/vT1XnWI03L8qEbK+VyfR5QsD3+ERKJMuVoL7eZm2M8M3ajpxBFeDyeN7qPb
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 4099447814679117161
From:   hongao <hongao@uniontech.com>
To:     alexander.deucher@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
        daniel@ffwll.ch, lijo.lazar@amd.com, mario.limonciello@amd.com
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, hongao <hongao@uniontech.com>
Subject: [PATCH] drm/amdgpu/gmc6: fix in case the PCI BAR is larger than the actual amount of vram
Date:   Tue, 15 Aug 2023 14:54:45 +0800
Message-Id: <20230815065445.25576-1-hongao@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybglogicsvrgz:qybglogicsvrgz7a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[why]
limit visible_vram_size to real_vram_size in case
the PCI BAR is larger than the actual amount of vram.

Signed-off-by: hongao <hongao@uniontech.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
index b7dad4e67813..c0de7496bfd1 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
@@ -320,6 +320,8 @@ static int gmc_v6_0_mc_init(struct amdgpu_device *adev)
 	adev->gmc.aper_base = pci_resource_start(adev->pdev, 0);
 	adev->gmc.aper_size = pci_resource_len(adev->pdev, 0);
 	adev->gmc.visible_vram_size = adev->gmc.aper_size;
+	if (adev->gmc.visible_vram_size > adev->gmc.real_vram_size)
+		adev->gmc.visible_vram_size = adev->gmc.real_vram_size;
 
 	/* set the gart size */
 	if (amdgpu_gart_size == -1) {
-- 
2.20.1

