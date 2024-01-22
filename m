Return-Path: <linux-kernel+bounces-33338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45C8D836886
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:39:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F115828837B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 15:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ABDA62A12;
	Mon, 22 Jan 2024 15:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pABwJY5h"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E74482D9;
	Mon, 22 Jan 2024 15:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705935928; cv=none; b=KA93PGDXO6lxRCH7Wyb2n5PvibXFog3PpI/OS3FAkKD+4fWw+ScdCPUA6y5dMwFw3w5/A78QyND14inv92ONAe/uQsrASqEonUg9/1hDMzuhW1m/7EWw9qY/IQJORMBMTVndibSDtXUN6hbjBxcoel74qy6cUwYumOWjbXlwFVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705935928; c=relaxed/simple;
	bh=z9yFUwVMGr6KTvDqeyh995QcZ2urdt0fl6Xd/4eXJmc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ADQW0IvnSNVEJVQE8AHoD4TuzhuLPQHVZJX+miIOz7lxmIOHnWZYcc0nE5gh3tVlCZ2WBGVSlL/0I5gJ4ZoZ6ZM8CyDc8uzVnKKcb5VEHBd0AHeLly8dNmlH6qUS6cS4v5Gzu6IAi/38F5NdYid+QklTkhJ7Dg7opi33q/0H8fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pABwJY5h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7C17C43394;
	Mon, 22 Jan 2024 15:05:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705935927;
	bh=z9yFUwVMGr6KTvDqeyh995QcZ2urdt0fl6Xd/4eXJmc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pABwJY5hfXFkcFFicK9wF1JV5BzUAozzzpoy3KWO34N6b0zdwqfRujsiDTQnH5hCn
	 q+vpFB4CmdA4ApjP+WvPef0cFvHXtccIWJLSivpF4rav36i47S/LNbBKZ6x4X7iusd
	 FLN7yRQcudz5L7Oo3G7wa2SD2OHtBk0kc8osrqPpY99e3Dh0JBpQMJ0YRzcFW32OVK
	 in11jGDXiUhRchhUYBW4tfV9+5tLrITD+WqTZ8l4bdkIoF4EsOFqT778Zoon17QKqT
	 8HDO3C8PRxDBT9nfDGTpm5CfCCoFhBMDiK0OFa+dSusgZ9rHmcflvwqhuB4aLaaXhA
	 yzcrsIuS5ZK4A==
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
Subject: [PATCH AUTOSEL 6.6 17/73] drm/amd/display: Fix writeback_info is not removed
Date: Mon, 22 Jan 2024 10:01:31 -0500
Message-ID: <20240122150432.992458-17-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122150432.992458-1-sashal@kernel.org>
References: <20240122150432.992458-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.13
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
index c232d38e70ae..79f3d7648eb7 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
@@ -546,11 +546,12 @@ bool dc_stream_remove_writeback(struct dc *dc,
 			if (stream->writeback_info[i].dwb_pipe_inst == dwb_pipe_inst)
 				stream->writeback_info[i].wb_enabled = false;
 
-			if (j < i)
-				/* trim the array */
+			/* trim the array */
+			if (j < i) {
 				memcpy(&stream->writeback_info[j], &stream->writeback_info[i],
 						sizeof(struct dc_writeback_info));
-			j++;
+				j++;
+			}
 		}
 	}
 	stream->num_wb_info = j;
-- 
2.43.0


