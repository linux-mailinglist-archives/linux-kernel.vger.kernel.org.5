Return-Path: <linux-kernel+bounces-155037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6510C8AE49F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 13:46:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 945751C22BB9
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 11:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21D4080038;
	Tue, 23 Apr 2024 11:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LYU5M9AK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E04113CF9B;
	Tue, 23 Apr 2024 11:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713872449; cv=none; b=oTadbeueaMZ5AgPaHIxkwOEMhyBEcKb4eRtHtBMuvywCAngWieI04KKTSztuoeWX1GzPQY2MW6LNTNwPYtQZ0lGK+rHr0hUls/mWU42Ql/7LQSeNPLzNJMa3rkmx6ojkBf6B10oJydBor2t0XmT2mpsA3HvruPnAbZOS8u0FgeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713872449; c=relaxed/simple;
	bh=nq+kPSKYllN1RkHpJFSoPYEfPtGdlTgw8sdi/a8uZXE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NkTY2dt7Av5a6zCzw+4nO/3J6amZjJ2xi39POJd6KpUy45Q/FV24cbhaRRNfn1syqwwPsPtinrrtgCP73/qEJCZlhxQ27ycP32YURI8ZEwxx8nvV8KF4T5efTKaV+EWo88ZE3KJPEm6LuroWKj4gfS+1ELf2VCNNWEQl6qy181w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LYU5M9AK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7170C2BD11;
	Tue, 23 Apr 2024 11:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713872448;
	bh=nq+kPSKYllN1RkHpJFSoPYEfPtGdlTgw8sdi/a8uZXE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LYU5M9AKJhptCCF7P/sc1RtTxA0PeYibb34Sxxc6nv/ddbVhcIoAz9psKtoirz2Xr
	 J9RojiTbacsGd/Z3eyn3NurZ0lNtEQzifTXEUuhY8ezxFVuRghPYZnvUswOB+Q6i25
	 p4T/mlr02nUbzwQTdIIwTZroYUM8N0jUBcNBx8S8kMr1v2NszbHdk+F7QdWXyP28k/
	 LzMtg9jnx3K3yHe9FVxgfXgTotmpjZKPeJdknls+X8aF0zed2iv38BnFvRgiXf0QeL
	 ncMMgt6zRV7hPf4ZuiEW5kH0VSGyLlMtD7IoUTSObDsSr8DGD3M4ZJs4gSZxKdLave
	 nXA2SrIh6AXSw==
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
Subject: [PATCH AUTOSEL 6.6 11/16] drm/nouveau/dp: Don't probe eDP ports twice harder
Date: Tue, 23 Apr 2024 07:01:44 -0400
Message-ID: <20240423110151.1658546-11-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240423110151.1658546-1-sashal@kernel.org>
References: <20240423110151.1658546-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.28
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
index 6a4980b2d4d4e..bf2ae67b03d94 100644
--- a/drivers/gpu/drm/nouveau/nouveau_dp.c
+++ b/drivers/gpu/drm/nouveau/nouveau_dp.c
@@ -108,12 +108,15 @@ nouveau_dp_detect(struct nouveau_connector *nv_connector,
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


