Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0AD57E9094
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Nov 2023 14:31:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232023AbjKLN3e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 08:29:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231883AbjKLN2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 08:28:35 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B3BA47BC;
        Sun, 12 Nov 2023 05:28:12 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89786C433C7;
        Sun, 12 Nov 2023 13:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699795692;
        bh=PwQQ/qj4qRnuUde0f1x1kHmBhsT7dkxvBgtJO1lWEbI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HVtV69u/ejPEJYayIj9riXs3ncr90/TK6cD3HkkobWhihVgOWqPlin7njMRoW8wQR
         x6kg3TONVaF21wvF9aOTNZGgAp4y06SjVhr54MIVOU17Q71dH4Zx+9yxRo64Oy9axT
         qXM4nszcp9mOmf7c8tAoNP+hykJqu9a5BQ7xKJeiCN4xAREKPbZbh8ReRup5po0Q5L
         szElj4nzW3uNnZVraVmHJhQXa2SsfrDyJHnLbkQpSjBXptSCp9AsnebhlQ2yvuO3b+
         j4MmbP+P+EGOfFhFnjJB/qO6GACyqdiNmTXrhndT/mbGHgLFnC7e59vifrZA/nQLSV
         SOYtK7GY9VvaQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Wayne Lin <wayne.lin@amd.com>, Jun Lei <jun.lei@amd.com>,
        Hersen Wu <hersenxs.wu@amd.com>,
        Daniel Wheeler <daniel.wheeler@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, christian.koenig@amd.com,
        airlied@linux.ie, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.5 10/10] drm/amd/display: Avoid NULL dereference of timing generator
Date:   Sun, 12 Nov 2023 08:27:53 -0500
Message-ID: <20231112132755.175757-10-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231112132755.175757-1-sashal@kernel.org>
References: <20231112132755.175757-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.5.11
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wayne Lin <wayne.lin@amd.com>

[ Upstream commit b1904ed480cee3f9f4036ea0e36d139cb5fee2d6 ]

[Why & How]
Check whether assigned timing generator is NULL or not before
accessing its funcs to prevent NULL dereference.

Reviewed-by: Jun Lei <jun.lei@amd.com>
Acked-by: Hersen Wu <hersenxs.wu@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/core/dc_stream.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
index 6e11d2b701f82..569d40eb7059d 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
@@ -556,7 +556,7 @@ uint32_t dc_stream_get_vblank_counter(const struct dc_stream_state *stream)
 	for (i = 0; i < MAX_PIPES; i++) {
 		struct timing_generator *tg = res_ctx->pipe_ctx[i].stream_res.tg;
 
-		if (res_ctx->pipe_ctx[i].stream != stream)
+		if (res_ctx->pipe_ctx[i].stream != stream || !tg)
 			continue;
 
 		return tg->funcs->get_frame_count(tg);
@@ -615,7 +615,7 @@ bool dc_stream_get_scanoutpos(const struct dc_stream_state *stream,
 	for (i = 0; i < MAX_PIPES; i++) {
 		struct timing_generator *tg = res_ctx->pipe_ctx[i].stream_res.tg;
 
-		if (res_ctx->pipe_ctx[i].stream != stream)
+		if (res_ctx->pipe_ctx[i].stream != stream || !tg)
 			continue;
 
 		tg->funcs->get_scanoutpos(tg,
-- 
2.42.0

