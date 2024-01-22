Return-Path: <linux-kernel+bounces-33502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36663836A69
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 17:27:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFC74285140
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F6B813BE9A;
	Mon, 22 Jan 2024 15:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TGHrYeCK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662FC3FB13;
	Mon, 22 Jan 2024 15:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705936547; cv=none; b=fElyTVjY/92rBoHFTR1XRu5vzHFr21wMT0BeqquI7j9yLCj8Z9H+ppjsa3O6WXKKck37FIzTbmRc/bu+iu8xq97aUsS3MDAYpK/iJNzo+z9ukOXYRh5sAhDqs26cYLu+xiKyKTOPQmSb+7qVe/7ACjPVfU15vY2Lnn4ARV8V7Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705936547; c=relaxed/simple;
	bh=UsQX3ShQguyvvPWhdrnfEISc4JhZVMhHQJKyFhICcao=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XqZcCOTu4SuhT1UTXUm1kIHS9M6AI1OCQJjT7OOwFOng2Zr7Km+vN+mGixsYVlIoup+msv+Lr52D3b+scEYymEX3jyLNaCqSokUvFSAFAMnfQHu6t9DNS3vbRGgdp2Y3ewC770GyGKQva0TC+2ttV4ea15tqhe8jSLlO1v6XTY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TGHrYeCK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 904A1C433C7;
	Mon, 22 Jan 2024 15:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705936546;
	bh=UsQX3ShQguyvvPWhdrnfEISc4JhZVMhHQJKyFhICcao=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TGHrYeCKnpDD/ggP9rRr9R6Jwxh9Y4VyfonE8g6klZiXa6aKFmsSvxjCGjlKldm/H
	 +M3orQxTGMI0KMATVv1nnwop3vOl4/Gj6Tcl2kgmgVGSwWJ7qJWVoRCVuvXZf1pVFG
	 2Mx1vWEBMAfPOmJx3UtCWrY3GlqLkjok5r9xCQ8QkmbauKQSHF52kUQRqtSB7aivxA
	 xI9DERSgvpl+A6UlACWsiz1KRiLq+BD+EATmkuJuQrkIoJAWlpbVN85ZSD/0noeBOT
	 K4YDOxYvKtBiDOgdmZ4oxatZV4OP3p3BzIG7Mh0lQl0mY76k3w6HJMzHt4S62zTZbM
	 d1UI0Iui5wjfA==
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
Subject: [PATCH AUTOSEL 5.10 09/28] drm/amd/display: Fix writeback_info never got updated
Date: Mon, 22 Jan 2024 10:14:35 -0500
Message-ID: <20240122151521.996443-9-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122151521.996443-1-sashal@kernel.org>
References: <20240122151521.996443-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.208
Content-Transfer-Encoding: 8bit

From: Alex Hung <alex.hung@amd.com>

[ Upstream commit 8a307777c36e15f38c9f23778babcd368144c7d8 ]

[WHY]
wb_enabled field is set to false before it is used, and the following
code will never be executed.

[HOW]
Setting wb_enable to false after all removal work is completed.

Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/core/dc_stream.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
index 8206c6edba74..c54691166871 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
@@ -481,18 +481,13 @@ bool dc_stream_remove_writeback(struct dc *dc,
 		return false;
 	}
 
-//	stream->writeback_info[dwb_pipe_inst].wb_enabled = false;
-	for (i = 0; i < stream->num_wb_info; i++) {
-		/*dynamic update*/
-		if (stream->writeback_info[i].wb_enabled &&
-			stream->writeback_info[i].dwb_pipe_inst == dwb_pipe_inst) {
-			stream->writeback_info[i].wb_enabled = false;
-		}
-	}
-
 	/* remove writeback info for disabled writeback pipes from stream */
 	for (i = 0, j = 0; i < stream->num_wb_info; i++) {
 		if (stream->writeback_info[i].wb_enabled) {
+
+			if (stream->writeback_info[i].dwb_pipe_inst == dwb_pipe_inst)
+				stream->writeback_info[i].wb_enabled = false;
+
 			if (i != j)
 				/* trim the array */
 				stream->writeback_info[j] = stream->writeback_info[i];
-- 
2.43.0


