Return-Path: <linux-kernel+bounces-155020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A377E8AE470
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 13:42:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5EA01C222D2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 11:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CB341353E3;
	Tue, 23 Apr 2024 11:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bdRfV9fp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A1C1350D0;
	Tue, 23 Apr 2024 11:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713872420; cv=none; b=qm8xbzUg3kntPe7jExPLmVHIe4C2aTdfOA8kd5GTlYWVAUMAxY4seszg5dRMHB+ZSZAQ7oOFtx2dXu1qNiYNxhTTSYuU5ymfFRfZxp6OTW4SiZJKpWzQ8zXeVdiux63HxuRCc+B5AXgV2PWKz04MrkFKMEvfxYO1Tc4icXTXUvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713872420; c=relaxed/simple;
	bh=rT1aHSFbmk8TcPG89gLfrewCUWPTuWYquSEwnudsayg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N1ic6KMh8y0dEPEmG6eOqCleQjCG42bAOICQnin4MeF3QDjOS58WPxNQ4nd82HuCZaYTLd7/e0FSWEwBLNNaQ4xtNTPnonQJj3h6rUMNuhLFc1um9Hw8i1gJvLKn1o5woE/U3SL5ked78Z1AyNL3yHjUaMGKM6gjtSG9KnSYHIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bdRfV9fp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 281C5C32783;
	Tue, 23 Apr 2024 11:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713872420;
	bh=rT1aHSFbmk8TcPG89gLfrewCUWPTuWYquSEwnudsayg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bdRfV9fpWRG43epBQL8QG/b3XqG+w8sGH5SlxiD6A368j8GiwCA1HyFCZdrzyK08L
	 2Ryjhru56QvWq2X5TMLskbJ0uCa1N8E5pCn9rHjf3Munpd1PcXZjB8Ietep85soSa+
	 D8VZDMA83yuD6hHfXQnM4KJ85ubObrmrpc2OylVkePATQ7Shc6cEBmgkqtZO/xV0pW
	 Wz48kAcJnAoHEKDSSaDqvof7Qfx/JtccZy8lYHIY001wWlDTfMOTwJoxiG6Cp3UJaX
	 kXCpTi4HwEgFCzwZ11dQAtqQImwQmuMzT/iwWVDb0mNo6OMNbxzyJTToHFHESKno6U
	 3H2zNRRPIoLvg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Lyude Paul <lyude@redhat.com>,
	Dave Airlie <airlied@redhat.com>,
	Sasha Levin <sashal@kernel.org>,
	kherbst@redhat.com,
	dakr@redhat.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	dri-devel@lists.freedesktop.org,
	nouveau@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.8 12/18] drm/nouveau/dp: Don't probe eDP ports twice harder
Date: Tue, 23 Apr 2024 07:01:08 -0400
Message-ID: <20240423110118.1652940-12-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240423110118.1652940-1-sashal@kernel.org>
References: <20240423110118.1652940-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.7
Content-Transfer-Encoding: 8bit

From: Lyude Paul <lyude@redhat.com>

[ Upstream commit bf52d7f9b2067f02efe7e32697479097aba4a055 ]

I didn't pay close enough attention the last time I tried to fix this
problem - while we currently do correctly take care to make sure we don't
probe a connected eDP port more then once, we don't do the same thing for
eDP ports we found to be disconnected.

So, fix this and make sure we only ever probe eDP ports once and then leave
them at that connector state forever (since without HPD, it's not going to
change on its own anyway). This should get rid of the last few GSP errors
getting spit out during runtime suspend and resume on some machines, as we
tried to reprobe eDP ports in response to ACPI hotplug probe events.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Reviewed-by: Dave Airlie <airlied@redhat.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240404233736.7946-3-lyude@redhat.com
(cherry picked from commit fe6660b661c3397af0867d5d098f5b26581f1290)
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/nouveau/nouveau_dp.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_dp.c b/drivers/gpu/drm/nouveau/nouveau_dp.c
index 7de7707ec6a89..3f72bc38bd2c4 100644
--- a/drivers/gpu/drm/nouveau/nouveau_dp.c
+++ b/drivers/gpu/drm/nouveau/nouveau_dp.c
@@ -225,12 +225,15 @@ nouveau_dp_detect(struct nouveau_connector *nv_connector,
 	u8 *dpcd = nv_encoder->dp.dpcd;
 	int ret = NOUVEAU_DP_NONE, hpd;
 
-	/* If we've already read the DPCD on an eDP device, we don't need to
-	 * reread it as it won't change
+	/* eDP ports don't support hotplugging - so there's no point in probing eDP ports unless we
+	 * haven't probed them once before.
 	 */
-	if (connector->connector_type == DRM_MODE_CONNECTOR_eDP &&
-	    dpcd[DP_DPCD_REV] != 0)
-		return NOUVEAU_DP_SST;
+	if (connector->connector_type == DRM_MODE_CONNECTOR_eDP) {
+		if (connector->status == connector_status_connected)
+			return NOUVEAU_DP_SST;
+		else if (connector->status == connector_status_disconnected)
+			return NOUVEAU_DP_NONE;
+	}
 
 	mutex_lock(&nv_encoder->dp.hpd_irq_lock);
 	if (mstm) {
-- 
2.43.0


