Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A15AD7DAFDF
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 00:00:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231376AbjJ2XAk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 19:00:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231562AbjJ2XAD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 19:00:03 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19B13D47;
        Sun, 29 Oct 2023 15:57:09 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58F5EC433B7;
        Sun, 29 Oct 2023 22:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698620228;
        bh=jGXXUx8iaeHPMaEHKaAXeM6iKlz7xPyaHyWjHBeR5Wo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jTinBTSaeBq39SzJVz4D1gUKUZASfrPfeJY0Hfvm/dQ4pW1umBXpvcCtMxmgmfdrd
         Xl8gkSj2iBgxdL22gITvARTU6+2abYgSTlFxHj8Ag3e+Y5giN7GoMBAadgPUkW7CDY
         HbRnIwlDOMqX6QDXrsmaOpkzyYciWo5qAcO4cu0arAxD9O0IfjyCni8dMSyGCzlIV4
         oElmHD9P8kmWRgDIBSS6Z2gXC/dKRqwZJNi+yJCmS4C6m0T9pAHzr3dW5D55hE5XuF
         UzceJaHJXJgcFkzi8YOLtwOwzUPqhfrLWyN4MhacTHxZ24IrKYj8nZRKPqI5c1+5Hd
         kuvuS4HhOjtMg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Felix Kuehling <Felix.Kuehling@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, Xinhui.Pan@amd.com,
        airlied@gmail.com, daniel@ffwll.ch, srinivasan.shanmugam@amd.com,
        Arunpravin.PaneerSelvam@amd.com, Philip.Yang@amd.com,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.5 52/52] drm/amdgpu: Reserve fences for VM update
Date:   Sun, 29 Oct 2023 18:53:39 -0400
Message-ID: <20231029225441.789781-52-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231029225441.789781-1-sashal@kernel.org>
References: <20231029225441.789781-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.5.9
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

From: Felix Kuehling <Felix.Kuehling@amd.com>

[ Upstream commit 316baf09d355aec1179981b6dfe28eba50c5ee5b ]

In amdgpu_dma_buf_move_notify reserve fences for the page table updates
in amdgpu_vm_clear_freed and amdgpu_vm_handle_moved. This fixes a BUG_ON
in dma_resv_add_fence when using SDMA for page table updates.

Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
index 12210598e5b8e..ba3a87cb88ccc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
@@ -403,7 +403,10 @@ amdgpu_dma_buf_move_notify(struct dma_buf_attachment *attach)
 				continue;
 		}
 
-		r = amdgpu_vm_clear_freed(adev, vm, NULL);
+		/* Reserve fences for two SDMA page table updates */
+		r = dma_resv_reserve_fences(resv, 2);
+		if (!r)
+			r = amdgpu_vm_clear_freed(adev, vm, NULL);
 		if (!r)
 			r = amdgpu_vm_handle_moved(adev, vm);
 
-- 
2.42.0

