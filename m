Return-Path: <linux-kernel+bounces-29656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40CAF83115F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 03:23:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2F6D2898E0
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 02:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA42E4698;
	Thu, 18 Jan 2024 02:23:33 +0000 (UTC)
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A5665A
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 02:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705544613; cv=none; b=Gg8LMA7ahXFjGeZTHnB+aMs7R+NCJCFzHob47saAXXg5bJNYX8ZPsEnex5rgllN/SR2eI6nkytqj+5MvH+XNXxBoAzX+j+yJdyu/1Mi7S+u3LrVX7XUfR04OdHR50k+rm7rnrd7g6FvIDTHzGb7efcGQXDfTXGZnBOHbHg+evt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705544613; c=relaxed/simple;
	bh=ISyDT6ZTpul8IViXHrwaswJvjFTDhvxeyAh3bwlBl8s=;
	h=X-Alimail-AntiSpam:Received:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding; b=dsK+2zK/inZjSINak+bU1oHDa3FDxOvzXJFcu4AZqUN/tZdGzhuZLifOFlFIcmNIiRNJYrpokVJEgi4eppXmM1qpdO+DVX3O+e/iOC+UywjTECTcEZ3yqKOuJla5ep/p31PL79mYnZKYQk4vk+e8bitPAqTq9PL4B+kQnSnAe9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R561e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0W-r4shC_1705544597;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0W-r4shC_1705544597)
          by smtp.aliyun-inc.com;
          Thu, 18 Jan 2024 10:23:25 +0800
From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To: harry.wentland@amd.com
Cc: sunpeng.li@amd.com,
	Rodrigo.Siqueira@amd.com,
	alexander.deucher@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] drm/amd/display: Simplify the calculation of variables
Date: Thu, 18 Jan 2024 10:23:15 +0800
Message-Id: <20240118022315.107671-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

/drivers/gpu/drm/amd/display/dc/dml2/dml2_dc_resource_mgmt.c:703:47-49: WARNING !A || A && B is equivalent to !A || B.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=7931
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/gpu/drm/amd/display/dc/dml2/dml2_dc_resource_mgmt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_dc_resource_mgmt.c b/drivers/gpu/drm/amd/display/dc/dml2/dml2_dc_resource_mgmt.c
index a0ce681b26c6..118aaf4389bc 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_dc_resource_mgmt.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_dc_resource_mgmt.c
@@ -700,9 +700,9 @@ static void free_unused_pipes_for_plane(struct dml2_context *ctx, struct dc_stat
 	for (i = 0; i < ctx->config.dcn_pipe_count; i++) {
 		if (state->res_ctx.pipe_ctx[i].plane_state == plane &&
 			state->res_ctx.pipe_ctx[i].stream->stream_id == stream_id &&
-			(!is_plane_duplicate || (is_plane_duplicate &&
+			(!is_plane_duplicate ||
 			ctx->v20.scratch.dml_to_dc_pipe_mapping.dml_pipe_idx_to_plane_index[state->res_ctx.pipe_ctx[i].pipe_idx] == plane_index)) &&
-			!is_pipe_used(pool, state->res_ctx.pipe_ctx[i].pipe_idx)) {
+			!is_pipe_used(pool, state->res_ctx.pipe_ctx[i].pipe_idx) {
 			free_pipe(&state->res_ctx.pipe_ctx[i]);
 		}
 	}
-- 
2.20.1.7.g153144c


