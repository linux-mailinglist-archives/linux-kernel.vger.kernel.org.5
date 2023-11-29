Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 858437FDB14
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 16:22:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234874AbjK2PWf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 10:22:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234860AbjK2PWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 10:22:30 -0500
Received: from exchange.fintech.ru (exchange.fintech.ru [195.54.195.159])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76755E6
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 07:22:36 -0800 (PST)
Received: from Ex16-01.fintech.ru (10.0.10.18) by exchange.fintech.ru
 (195.54.195.159) with Microsoft SMTP Server (TLS) id 14.3.498.0; Wed, 29 Nov
 2023 18:22:34 +0300
Received: from localhost (10.0.253.138) by Ex16-01.fintech.ru (10.0.10.18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Wed, 29 Nov
 2023 18:22:34 +0300
From:   Nikita Zhandarovich <n.zhandarovich@fintech.ru>
To:     Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
CC:     Nikita Zhandarovich <n.zhandarovich@fintech.ru>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        <amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] drm/radeon/r600_cs: Fix possible int overflows in r600_cs_check_reg()
Date:   Wed, 29 Nov 2023 07:22:30 -0800
Message-ID: <20231129152230.7931-1-n.zhandarovich@fintech.ru>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.0.253.138]
X-ClientProxiedBy: Ex16-02.fintech.ru (10.0.10.19) To Ex16-01.fintech.ru
 (10.0.10.18)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While improbable, there may be a chance of hitting integer
overflow when the result of radeon_get_ib_value() gets shifted
left.

Avoid it by casting one of the operands to larger data type (u64).

Found by Linux Verification Center (linuxtesting.org) with static
analysis tool SVACE.

Fixes: 1729dd33d20b ("drm/radeon/kms: r600 CS parser fixes")
Signed-off-by: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
---
 drivers/gpu/drm/radeon/r600_cs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/radeon/r600_cs.c b/drivers/gpu/drm/radeon/r600_cs.c
index 638f861af80f..6cf54a747749 100644
--- a/drivers/gpu/drm/radeon/r600_cs.c
+++ b/drivers/gpu/drm/radeon/r600_cs.c
@@ -1275,7 +1275,7 @@ static int r600_cs_check_reg(struct radeon_cs_parser *p, u32 reg, u32 idx)
 			return -EINVAL;
 		}
 		tmp = (reg - CB_COLOR0_BASE) / 4;
-		track->cb_color_bo_offset[tmp] = radeon_get_ib_value(p, idx) << 8;
+		track->cb_color_bo_offset[tmp] = (u64)radeon_get_ib_value(p, idx) << 8;
 		ib[idx] += (u32)((reloc->gpu_offset >> 8) & 0xffffffff);
 		track->cb_color_base_last[tmp] = ib[idx];
 		track->cb_color_bo[tmp] = reloc->robj;
@@ -1302,7 +1302,7 @@ static int r600_cs_check_reg(struct radeon_cs_parser *p, u32 reg, u32 idx)
 					"0x%04X\n", reg);
 			return -EINVAL;
 		}
-		track->htile_offset = radeon_get_ib_value(p, idx) << 8;
+		track->htile_offset = (u64)radeon_get_ib_value(p, idx) << 8;
 		ib[idx] += (u32)((reloc->gpu_offset >> 8) & 0xffffffff);
 		track->htile_bo = reloc->robj;
 		track->db_dirty = true;
-- 
2.25.1

