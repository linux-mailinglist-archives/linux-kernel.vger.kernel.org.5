Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E97EA7E90DD
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Nov 2023 14:32:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231728AbjKLNbl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 08:31:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232874AbjKLNat (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 08:30:49 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A4CE5FC8;
        Sun, 12 Nov 2023 05:29:22 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5BD0C43395;
        Sun, 12 Nov 2023 13:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699795762;
        bh=ckoGjyC0/jwc26OxRRvzVlsmw9trxr1M39AQ/VPMYYQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iFXkIBSCFvzw76o/oq5omHADxxP18GsZOo4py3VPJyM1o4AY7xc1YRI2lrp2LyIVk
         01PrSiuJVrqWPZCmBoKjzPYnHl+Q89x+aeKsEE/UoufcFlwtiDepqeQjKSbUlKLL+J
         iv+ehVO7kNi1eLpaFj9yXcmNsKqo2tRRLHrgdPAnKBjuvqatarzSnvCzSutDKSiI8V
         fqo7sWDWdxJUr+lYA7/EM7XYpQ7JbnQGtbz5v+ajUeA0ysGp+4DaXI7nSk90QxBsvf
         kKOIVcxNZdusLQ2GAsQ0OCVc7bKh2n9t0Mm2E3KKKfmeSkmJ9Dbczh32I5ySUNFGF5
         qjSWNO6axqvJQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Wayne Lin <wayne.lin@amd.com>, Jun Lei <jun.lei@amd.com>,
        Hersen Wu <hersenxs.wu@amd.com>,
        Daniel Wheeler <daniel.wheeler@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, christian.koenig@amd.com,
        airlied@linux.ie, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.19 5/5] drm/amd/display: Avoid NULL dereference of timing generator
Date:   Sun, 12 Nov 2023 08:29:12 -0500
Message-ID: <20231112132913.176824-5-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231112132913.176824-1-sashal@kernel.org>
References: <20231112132913.176824-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.298
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
index fdcc8ab19bf3f..25b8a8f933821 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
@@ -281,7 +281,7 @@ uint32_t dc_stream_get_vblank_counter(const struct dc_stream_state *stream)
 	for (i = 0; i < MAX_PIPES; i++) {
 		struct timing_generator *tg = res_ctx->pipe_ctx[i].stream_res.tg;
 
-		if (res_ctx->pipe_ctx[i].stream != stream)
+		if (res_ctx->pipe_ctx[i].stream != stream || !tg)
 			continue;
 
 		return tg->funcs->get_frame_count(tg);
@@ -305,7 +305,7 @@ bool dc_stream_get_scanoutpos(const struct dc_stream_state *stream,
 	for (i = 0; i < MAX_PIPES; i++) {
 		struct timing_generator *tg = res_ctx->pipe_ctx[i].stream_res.tg;
 
-		if (res_ctx->pipe_ctx[i].stream != stream)
+		if (res_ctx->pipe_ctx[i].stream != stream || !tg)
 			continue;
 
 		tg->funcs->get_scanoutpos(tg,
-- 
2.42.0

