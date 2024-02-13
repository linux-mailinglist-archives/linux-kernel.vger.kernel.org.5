Return-Path: <linux-kernel+bounces-62677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F53685244A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 01:48:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82CEF1C23906
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 00:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 065E6692E1;
	Tue, 13 Feb 2024 00:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VMpSp30x"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B7169956;
	Tue, 13 Feb 2024 00:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707783731; cv=none; b=U4Fb6q6nJryW0xF6VJwV9SF9YLi/lCLTqW/ulcPnbaFcaoqjGlG6Ex/vGOCIvcitpPaNCSwmBrGeuxBsW7rxTvDKILdLR7hstgt1rGSvHDWSQt7pqhMdwul/Ti5ya46nN3xNhK0sTRW95C0pXpIWmAIhG5tf8F6T7zTjlLpzUws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707783731; c=relaxed/simple;
	bh=I7nRm05Rrc8jVppMcnUrwhVUzVglvFm1ffpXBh29HME=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VmVPm8zliebUe8TQiMy3x3tpYGMi5orjF+5dgako2qk3FFqZJnFsZK8s5rzvRdWrD0GMdrCnTKBU8U7Q6oZX6gG/SHw1kiZdCax/LLmfD/XxpfoeOjtYNkAg6Qm3SZqyu5kwcm5TpjQ2zjQP5tJNuK1xG88O42+tbNFrzNmrOSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VMpSp30x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6163CC433C7;
	Tue, 13 Feb 2024 00:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707783730;
	bh=I7nRm05Rrc8jVppMcnUrwhVUzVglvFm1ffpXBh29HME=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VMpSp30xsFiW8IbPOS9LOw2uo599frEUhiyjsO2oifrg0tmt/shmceIAi/NwvyJ82
	 7IRsiiccEvtAOYn4MpdzerLT2vixuk08RkpTHkgOpF49d8+/czePmYraqlbpgnUiQ2
	 FmI99BbZLDlnCI2hX/puM21Z0xs0mgkRduslv4M9JGw4qvaKc1jQR/CNSb5Rr4NlcI
	 OVvG7BreuqiLFk3aHzBFJFi17QCtmu8gDWEMERi26k3/oqR/0mcKhG5Yg2KIQj3zG0
	 cGabNmkLnIsp7NHMupsw7UwMtbuFAftdA4Uk/Iqpxza442bIuiZPAOZN6Q5aj8PCLV
	 YTrPWSgW/p9aQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: "Stanley.Yang" <Stanley.Yang@amd.com>,
	Hawking Zhang <Hawking.Zhang@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.6 45/51] drm/amdgpu: Fix shared buff copy to user
Date: Mon, 12 Feb 2024 19:20:22 -0500
Message-ID: <20240213002052.670571-45-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213002052.670571-1-sashal@kernel.org>
References: <20240213002052.670571-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.16
Content-Transfer-Encoding: 8bit

From: "Stanley.Yang" <Stanley.Yang@amd.com>

[ Upstream commit 2dcf82a8e8dc930655787797ef8a3692b527c7a9 ]

ta if invoke node buffer
|-------- ta type ----------|
|--------  ta id  ----------|
|-------- cmd  id ----------|
|------ shared buf len -----|
|------ shared buffer ------|

ta if invoke node buffer is as above, copy shared buffer data to correct location

Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c
index 468a67b302d4..ca5c86e5f7cd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp_ta.c
@@ -362,7 +362,7 @@ static ssize_t ta_if_invoke_debugfs_write(struct file *fp, const char *buf, size
 		}
 	}
 
-	if (copy_to_user((char *)buf, context->mem_context.shared_buf, shared_buf_len))
+	if (copy_to_user((char *)&buf[copy_pos], context->mem_context.shared_buf, shared_buf_len))
 		ret = -EFAULT;
 
 err_free_shared_buf:
-- 
2.43.0


