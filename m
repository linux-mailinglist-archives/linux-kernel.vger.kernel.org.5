Return-Path: <linux-kernel+bounces-113992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D96B8887D3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:11:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EFBA1C26C7D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE039156F21;
	Sun, 24 Mar 2024 23:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iOwlbwwc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ACA91F30C7;
	Sun, 24 Mar 2024 22:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321124; cv=none; b=ngZD7mpEdHkCAYkRCQcsYlwTzUDI9O1LkU4Z9yKAJ+J31KbRd4QsgxHvtgWYuf/KpZd4Jas41BgLGa8HcNB0PiiK8ArcaGDC9nVSRZab17dG4AdI+u2f3armhVXuqlhNqNZIHW3r+sRyN3JRpp04BJVHGXvdqVFqcP8BccvZTKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321124; c=relaxed/simple;
	bh=X/3XYKAUHv8Ahibku5Y9s1Ozf8W++cB+0fCChROp5Z0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sl4KSQJTCPy+z12nXYhIwajHBBPkuopREaFlX5DGxeYsMkBpAfb39Iti5Noy1OGZLdGDb4diVPu6GWDtxRnw0QbhBDzhUoTOOijYNyHxRY+FZIsTshzELGiVbBiGsiqJyiZZTxxQZONoX4vT/URq3/eWuaplQeLMmu746ZyU06U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iOwlbwwc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98951C433F1;
	Sun, 24 Mar 2024 22:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321123;
	bh=X/3XYKAUHv8Ahibku5Y9s1Ozf8W++cB+0fCChROp5Z0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iOwlbwwc+vd/UeQEo+zZsyKECFSIpELaSR+lxfYWnDR9FNr8oUtkbJP/5LlbnqQ7b
	 OFSxPO3gD/oSACfxWPheQTSWHHR/1u5UkD/K4rIEGQ4WSGiJDUCpIkQYNDNCC63T5N
	 Lo/dDcCeaEU4+1NXsbIUOsH4HhnBBtUtnog0+8feegMRLtjll8E/wjHVkiH4JxgJlO
	 Dio6uhFag+Ff8AcLr/mYYrwqGcMB4j1dOHlTSbU7CJk3Gr85FDjx3ho7KsFJMDMUe9
	 nOQ6ez8IT62guHDeBVl7IyNq7fEufoapynfADcdfBPVkl2jMCHoI7naZ4PwgXtoYVW
	 j/Jk4RzduX9AQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dave Airlie <airlied@redhat.com>,
	Danilo Krummrich <dakr@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 684/713] nouveau/gsp: don't check devinit disable on GSP.
Date: Sun, 24 Mar 2024 18:46:50 -0400
Message-ID: <20240324224720.1345309-685-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Dave Airlie <airlied@redhat.com>

[ Upstream commit 5d4e8ae6e57b025802aadf55a4775c55cceb75f1 ]

GSP should be handling this and I can see no evidence in opengpu
driver that this register should be touched.

Fixed acceleration on 2080 Ti GPUs.

Fixes: 15740541e8f0 ("drm/nouveau/devinit/tu102-: prepare for GSP-RM")

Signed-off-by: Dave Airlie <airlied@redhat.com>
Signed-off-by: Danilo Krummrich <dakr@redhat.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240314014521.2695233-1-airlied@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/nouveau/nvkm/subdev/devinit/r535.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/devinit/r535.c b/drivers/gpu/drm/nouveau/nvkm/subdev/devinit/r535.c
index 666eb93b1742c..11b4c9c274a1a 100644
--- a/drivers/gpu/drm/nouveau/nvkm/subdev/devinit/r535.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/devinit/r535.c
@@ -41,7 +41,6 @@ r535_devinit_new(const struct nvkm_devinit_func *hw,
 
 	rm->dtor = r535_devinit_dtor;
 	rm->post = hw->post;
-	rm->disable = hw->disable;
 
 	ret = nv50_devinit_new_(rm, device, type, inst, pdevinit);
 	if (ret)
-- 
2.43.0


