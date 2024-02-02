Return-Path: <linux-kernel+bounces-49501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0637A846B29
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 09:49:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 996181F2C1A6
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 08:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EA43604CF;
	Fri,  2 Feb 2024 08:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="f4ufHFKq"
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD6E5FDDF
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 08:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706863661; cv=none; b=L4GqEm/EmF+FRnU3TjsMu+cjbd0YZOOOWNoc4K/hbYggWtYe13WZFXXqWxGikpROR1raYX79Uj2b5803lTCI8aZCGibPTQPQrjYPCZjBUvFPxPxfm3048hRDsxIdzK8UXiukImxAAM2Hi1FOcPkuRhzWjeqkrXy8as3RNVk8tc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706863661; c=relaxed/simple;
	bh=TWrQ56IBIk385dRlWI6v4D/KSIm0/vXb/VmuQXJsf9I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pwCA4jhMg05toUur1x/MljVb8hgZxIX5rHk9pDdjOIK6pdDYNCA1s76vThrJb+9VNxeoaMp6+/mripNWH1AVvOIbXRTfueHZ5jdSUq3cnqFU8GwChVNkqL1HB9BnYR2XnEu0lX+SoRa91Tc70fzh2VkppiScDFhg2CUSpDcTnp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=f4ufHFKq; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1706863655; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=Wz0VMCZ/c7UOCmvQesFR0QZjCIgWilm0YmsxOmqNZmk=;
	b=f4ufHFKqOTM9WVNCI6Q8DwJ3ELwisMehXrCSXxpbEfy2r1FzDwJZCM8foAQkX1TgXEDRtz3PH56p+xaGWX51810HyTHAeaURnMSqBm+9UiQv/fBmDsEQGqZoR5xU4sGgOSJ1kuNgC+4vS8J/xnZhM3FuvtrsNrkqvAnFfCW9G20=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0W.wVXmB_1706863648;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0W.wVXmB_1706863648)
          by smtp.aliyun-inc.com;
          Fri, 02 Feb 2024 16:47:34 +0800
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
Date: Fri,  2 Feb 2024 16:47:26 +0800
Message-Id: <20240202084726.91920-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

/drivers/gpu/drm/amd/display/dc/dml2/dml2_utils.c:236:49-51: WARNING !A || A && B is equivalent to !A || B.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=8169
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 drivers/gpu/drm/amd/display/dc/dml2/dml2_utils.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_utils.c b/drivers/gpu/drm/amd/display/dc/dml2/dml2_utils.c
index 1068b962d1c1..f15d1dbad6a9 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_utils.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_utils.c
@@ -234,7 +234,7 @@ static bool get_plane_id(struct dml2_context *dml2, const struct dc_state *state
 		if (state->streams[i]->stream_id == stream_id) {
 			for (j = 0; j < state->stream_status[i].plane_count; j++) {
 				if (state->stream_status[i].plane_states[j] == plane &&
-					(!is_plane_duplicate || (is_plane_duplicate && (j == plane_index)))) {
+					(!is_plane_duplicate || (j == plane_index))) {
 					*plane_id = (i << 16) | j;
 					return true;
 				}
-- 
2.20.1.7.g153144c


