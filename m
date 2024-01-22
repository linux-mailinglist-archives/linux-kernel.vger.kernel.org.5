Return-Path: <linux-kernel+bounces-33235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 863078366F4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:09:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BE401F23AFF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 15:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB6503E491;
	Mon, 22 Jan 2024 14:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tFpjpdxD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A2354CB3B;
	Mon, 22 Jan 2024 14:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705935450; cv=none; b=Vp3pDkfDF1A3u4X7rL9OZIJoF27E7kmj7ngwb5dC6pib/5dDS9K5Arg1opbnWTo6qXtehtxfqNT7RKeIK1dBxkQ4P/9jFYmUK3FDXtguTx0isj7hd1Q9CsG2hnk28ZUSeHOXnE8D78R4AxmnQWV532lDs2lEcknCPn9yDZg5Hv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705935450; c=relaxed/simple;
	bh=EnjL0ke689RMfd+PkpdMwleJrNruYu3f6vIsAHbu2XA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BMb6w6JiIfHd4B1QEV7nmrMYXmntnOUvm/8YM0VD9xDivZZt6CLW0Fb4ErNqxaMqEboer/otMIdImubdWIKZke9YbKkaL2erWhape4Bb4PO02UBj/jigXd9nuhERCpjzjWFbCnU0/hF9GkahGT3WjgF+qshHfjJzPJEoFkdNNag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tFpjpdxD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3613CC433F1;
	Mon, 22 Jan 2024 14:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705935449;
	bh=EnjL0ke689RMfd+PkpdMwleJrNruYu3f6vIsAHbu2XA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tFpjpdxDcKtSM2GA2SVUy/XyfC6iKC4MBz+WAnGHPZz9+UGCSr+4AXzMUTm66FwJu
	 ypJ+HrgoSBwSRNblZBpmhaMqGY41N6FtPN4myanSP3VpqSr9sKK+bqzf1PQIe1tjEI
	 /HJTDuFV0xo0eZs2sArg/Ung+RKKM5yz0BMPpcJs6762LGfHrZ6HBLu+YqBiWClthz
	 JVZbQjVjPv3OqYEdCs3zhV32w9pMAaTTf/caYz4Dn9exZftR0/qMnI5qSC81nI91HW
	 9rCyEHUm/9VQbo3Q8vIyB3Onp9QVkLc0U2EqDrmRkqaPij2nc/CSWmdmmaT8Ia4LcP
	 UheYNPrxX7APQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dennis Chan <dennis.chan@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Robin Chen <robin.chen@amd.com>,
	Rodrigo Siqueira <rodrigo.siqueira@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	harry.wentland@amd.com,
	sunpeng.li@amd.com,
	Rodrigo.Siqueira@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	wenjing.liu@amd.com,
	qingqing.zhuo@amd.com,
	hersenxs.wu@amd.com,
	ilya.bakoulin@amd.com,
	Bhawanpreet.Lakha@amd.com,
	chuntao.tso@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.7 20/88] drm/amd/display: Fix Replay Desync Error IRQ handler
Date: Mon, 22 Jan 2024 09:50:53 -0500
Message-ID: <20240122145608.990137-20-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122145608.990137-1-sashal@kernel.org>
References: <20240122145608.990137-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.1
Content-Transfer-Encoding: 8bit

From: Dennis Chan <dennis.chan@amd.com>

[ Upstream commit dd5c6362ddcd8bdb07704faff8648593885ecfa1 ]

In previous case, Replay didn't identify the IRQ type, This commit fixes
the issues for the interrupt.

Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Reviewed-by: Robin Chen <robin.chen@amd.com>
Acked-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Dennis Chan <dennis.chan@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../display/dc/link/protocols/link_dp_irq_handler.c  | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_irq_handler.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_irq_handler.c
index 0c00e94e90b1..9eadc2c7f221 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_irq_handler.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_irq_handler.c
@@ -190,9 +190,6 @@ static void handle_hpd_irq_replay_sink(struct dc_link *link)
 	/*AMD Replay version reuse DP_PSR_ERROR_STATUS for REPLAY_ERROR status.*/
 	union psr_error_status replay_error_status;
 
-	if (link->replay_settings.config.force_disable_desync_error_check)
-		return;
-
 	if (!link->replay_settings.replay_feature_enabled)
 		return;
 
@@ -210,9 +207,6 @@ static void handle_hpd_irq_replay_sink(struct dc_link *link)
 		&replay_error_status.raw,
 		sizeof(replay_error_status.raw));
 
-	if (replay_configuration.bits.DESYNC_ERROR_STATUS)
-		link->replay_settings.config.received_desync_error_hpd = 1;
-
 	link->replay_settings.config.replay_error_status.bits.LINK_CRC_ERROR =
 		replay_error_status.bits.LINK_CRC_ERROR;
 	link->replay_settings.config.replay_error_status.bits.DESYNC_ERROR =
@@ -225,6 +219,12 @@ static void handle_hpd_irq_replay_sink(struct dc_link *link)
 		link->replay_settings.config.replay_error_status.bits.STATE_TRANSITION_ERROR) {
 		bool allow_active;
 
+		if (link->replay_settings.config.replay_error_status.bits.DESYNC_ERROR)
+			link->replay_settings.config.received_desync_error_hpd = 1;
+
+		if (link->replay_settings.config.force_disable_desync_error_check)
+			return;
+
 		/* Acknowledge and clear configuration bits */
 		dm_helpers_dp_write_dpcd(
 			link->ctx,
-- 
2.43.0


