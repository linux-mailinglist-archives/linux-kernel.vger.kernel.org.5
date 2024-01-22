Return-Path: <linux-kernel+bounces-33415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 66C34836976
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 17:02:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8EA00B25E62
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C93C58004B;
	Mon, 22 Jan 2024 15:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PzM/1r1w"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18FB18004A;
	Mon, 22 Jan 2024 15:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705936234; cv=none; b=tORC7TsyL391O0f+/T0c6NwLL9eSmjsQw3ww3yTyP/rWQ8GHB+LKkYW77PXIMK78JoCfaR2Iq7Ep+gaw3Phn5U/QmSd6hS5RI291lfBGh/Lxj+hyTTw/yv7V/kKMJuCPf4mGPWotakXWO40pE7l1KZzMEj+mDDJ60dQ/BsfiYw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705936234; c=relaxed/simple;
	bh=DmGztIB7qtBTmUG9cjOlqGMETbWx9kFVMNSxt6Q37bM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sd0rG6XV3g3ic5V8GdmSQVecaiGOx9gW3Tnq6nNHvfpcjqV2wwMRnsX9fS41bRaybesbs4LZ9r7+b1NsdnsgdF+aWKNRSX+gvtuIHoRYtdTAa8us986CKyS+7zb/fb/DLtuJwX2OoXVY1TuWBnDvlT3egnY07hjiwrItSJQaMY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PzM/1r1w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F0C3C433C7;
	Mon, 22 Jan 2024 15:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705936233;
	bh=DmGztIB7qtBTmUG9cjOlqGMETbWx9kFVMNSxt6Q37bM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PzM/1r1w662lOIq3z3GtzdJlQHx/OeXP/l8LpWNLr6MV/NO1yo9ucyV52VePPhbBv
	 HuKgGIoY2khOpQ8TAna16rBoH+OgX2Mcl+85EDVNliXRZ8A/8nxVsCiy4EZBsBviZk
	 bFh08110AvHEl/IFIIdz+ilvXVplHrFJyaqi/tjHjBu+zxYoolG700c43gYhbYzpsA
	 FXrtXYJCmvaeHzDJJavx1h7RPrc9kjTO5ORfws3jbTOq3S7eJ+wUF9IID54Lg8TUFS
	 XQ244gWeF0dDnFa65QycAaa6Vn+lZea2XN5P2gcGM9PW74g/QGu4oct/+eC3BWeJM4
	 86cfY6NVNffYA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alex Hung <alex.hung@amd.com>,
	Harry Wentland <harry.wentland@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	sunpeng.li@amd.com,
	Rodrigo.Siqueira@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	alvin.lee2@amd.com,
	jun.lei@amd.com,
	dillon.varone@amd.com,
	qingqing.zhuo@amd.com,
	aurabindo.pillai@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.1 15/53] drm/amd/display: Fix writeback_info is not removed
Date: Mon, 22 Jan 2024 10:08:16 -0500
Message-ID: <20240122150949.994249-15-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122150949.994249-1-sashal@kernel.org>
References: <20240122150949.994249-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.74
Content-Transfer-Encoding: 8bit

From: Alex Hung <alex.hung@amd.com>

[ Upstream commit 5b89d2ccc8466e0445a4994cb288fc009b565de5 ]

[WHY]
Counter j was not updated to present the num of writeback_info when
writeback pipes are removed.

[HOW]
update j (num of writeback info) under the correct condition.

Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/core/dc_stream.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
index 12b73b0ff19e..b59db6c95820 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
@@ -521,10 +521,11 @@ bool dc_stream_remove_writeback(struct dc *dc,
 			if (stream->writeback_info[i].dwb_pipe_inst == dwb_pipe_inst)
 				stream->writeback_info[i].wb_enabled = false;
 
-			if (j < i)
-				/* trim the array */
+			/* trim the array */
+			if (j < i) {
 				stream->writeback_info[j] = stream->writeback_info[i];
-			j++;
+				j++;
+			}
 		}
 	}
 	stream->num_wb_info = j;
-- 
2.43.0


