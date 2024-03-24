Return-Path: <linux-kernel+bounces-113577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2284488856F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:07:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97AFDB225A3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C5E11C9855;
	Sun, 24 Mar 2024 22:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CgSa2u39"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78CF1C8822;
	Sun, 24 Mar 2024 22:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320380; cv=none; b=TlRjlPaNsUxeLDwQctDScaErc+poFn8sOj40V9a8QAZDI9asEBTaN5olxarbWnSedl97G+/Ua4fWCsFJ1QWsIFNh0Zk8PQWXbheAqoKwsnNRlbV+2W/vshiwUj8MszV9RBUt4tzkwCDisHIk41cZ1HY7Q2gRvKERgUjyVd7CktQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320380; c=relaxed/simple;
	bh=X/3XYKAUHv8Ahibku5Y9s1Ozf8W++cB+0fCChROp5Z0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J7K9GymfTC7EsnJ0bFYdowvmANokx3QdC7Hq92nqTqdOEMbDaFRd+tl1lDzs3hSR0lpjJ/P0GwL52FllO1P77hADZ0QK6mjEscF54f+lJ4aj6EWDLUeF1O6u/JJ1/h4iKu+3nQrXztfkLqzOrE2y7F/Wexq3A7LiGpjH1aRIjvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CgSa2u39; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 124D7C433B1;
	Sun, 24 Mar 2024 22:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320380;
	bh=X/3XYKAUHv8Ahibku5Y9s1Ozf8W++cB+0fCChROp5Z0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CgSa2u39ntVodhTYZ+tXxTll/KICCG/ON1rKfkneI3sSLTOMZ6LQftDrx+o61dzxJ
	 30O/cl889uGsbqQe8eCT8Ikh5Y+kJg6R+Je5MRn3Nc1ZAG6ibvruMRMQuSoCF1wTj8
	 a6C8qVTEmj8WwCuBN9nZX1bjzviFHX5lF+AdcQ3siGFohKn3YbtS3QIdM9sc6LZU0x
	 S61vHbJCd2qFkaUXDPH8MkqAEU9R2nLDGs/AncHqhgikyyTBUEDxxCvOW5fSg15RsV
	 J7oU2nysFITnQwOaq8ko3MT8CdlsN85mibp4ryBFGI+PTE3k1wypgxoGw1qqY1bS34
	 3A+9amR3xfvhA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dave Airlie <airlied@redhat.com>,
	Danilo Krummrich <dakr@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 686/715] nouveau/gsp: don't check devinit disable on GSP.
Date: Sun, 24 Mar 2024 18:34:25 -0400
Message-ID: <20240324223455.1342824-687-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
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


