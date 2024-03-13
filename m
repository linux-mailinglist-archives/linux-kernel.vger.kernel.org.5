Return-Path: <linux-kernel+bounces-101910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CB9B87ACA5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:13:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBF9F1F2FA47
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C39AF61680;
	Wed, 13 Mar 2024 16:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B5+yt00n"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B466B83CCD;
	Wed, 13 Mar 2024 16:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710348049; cv=none; b=RLMaw5wx5HMKTVVq7e0dgqqP9mSxOE98K8pnmdfDY9BF/RmAUXEAtmfX/qvuHPKYj7FSSRTHka2csrE92SDWLhZEQ+N1z5EM6PEyVygwaI/wZ5LAABsgOsdpfGqTCS95T4ntF3SA74HmEw405Unc7lVF0JxZwT/l7RkoCzdaAxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710348049; c=relaxed/simple;
	bh=yancN6ke9kxfGLZae9cvszrzCYaSYwXr/NHlpLNACcA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GR7XTBwFVNdlM/aTJdSDjzVnGlF/vcqqABYU7dTiKtTk9k/1H4P4uy9nO2dEAbWtw8mbKXuMzUOOtM0xW6K++uVvVVjCLJC/pAI5y6uPaclFhhNsh845VPK+1J9aMyBMoHvcyyD6Msck9jsrePqqhSmrbkA6Np9cpI3NrLE+N6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B5+yt00n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5937BC433C7;
	Wed, 13 Mar 2024 16:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710348049;
	bh=yancN6ke9kxfGLZae9cvszrzCYaSYwXr/NHlpLNACcA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B5+yt00n1IFRxFxiHgJcGg2qcxbNLrVCKCBhrx/hViMA1zxnk7zSnNQHD0D+Drjh1
	 90oUpz9xKW/s9YqTqq5T0POcUzYYyR57+ChcHBaivucYjAGgm21iuLL1KGHwWnanAb
	 G8IkKfJTlSr+Y1Ckh9bd/3nDp0nxSehwFdlITbZMbwo73fkwiG0iUnyNJSvkgQCIGC
	 ZVSUzcp/QRcDa3umUGuq2a7OWycu7DKBkcNsIysmAC+ADAjvMLGSBWDFPW0Z3XYlhI
	 4rS0ZalZFuuTLe1eF96m+kHAcCikivwhfVc2giY6Q2olPF8mhd2R1FDjzAEiD9M7hW
	 k3BlRXe5pAoog==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Friedrich Vock <friedrich.vock@gmx.de>,
	Joshua Ashton <joshua@froggi.es>,
	Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 42/71] drm/amdgpu: Reset IH OVERFLOW_CLEAR bit
Date: Wed, 13 Mar 2024 12:39:28 -0400
Message-ID: <20240313163957.615276-43-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313163957.615276-1-sashal@kernel.org>
References: <20240313163957.615276-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.82-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-6.1.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 6.1.82-rc1
X-KernelTest-Deadline: 2024-03-15T16:39+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Friedrich Vock <friedrich.vock@gmx.de>

[ Upstream commit 7330256268664ea0a7dd5b07a3fed363093477dd ]

Allows us to detect subsequent IH ring buffer overflows as well.

Cc: Joshua Ashton <joshua@froggi.es>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Friedrich Vock <friedrich.vock@gmx.de>
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/cik_ih.c     | 6 ++++++
 drivers/gpu/drm/amd/amdgpu/cz_ih.c      | 5 +++++
 drivers/gpu/drm/amd/amdgpu/iceland_ih.c | 5 +++++
 drivers/gpu/drm/amd/amdgpu/ih_v6_0.c    | 6 ++++++
 drivers/gpu/drm/amd/amdgpu/navi10_ih.c  | 6 ++++++
 drivers/gpu/drm/amd/amdgpu/si_ih.c      | 6 ++++++
 drivers/gpu/drm/amd/amdgpu/tonga_ih.c   | 6 ++++++
 drivers/gpu/drm/amd/amdgpu/vega10_ih.c  | 6 ++++++
 drivers/gpu/drm/amd/amdgpu/vega20_ih.c  | 6 ++++++
 9 files changed, 52 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/cik_ih.c b/drivers/gpu/drm/amd/amdgpu/cik_ih.c
index df385ffc97683..6578ca1b90afa 100644
--- a/drivers/gpu/drm/amd/amdgpu/cik_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/cik_ih.c
@@ -204,6 +204,12 @@ static u32 cik_ih_get_wptr(struct amdgpu_device *adev,
 		tmp = RREG32(mmIH_RB_CNTL);
 		tmp |= IH_RB_CNTL__WPTR_OVERFLOW_CLEAR_MASK;
 		WREG32(mmIH_RB_CNTL, tmp);
+
+		/* Unset the CLEAR_OVERFLOW bit immediately so new overflows
+		 * can be detected.
+		 */
+		tmp &= ~IH_RB_CNTL__WPTR_OVERFLOW_CLEAR_MASK;
+		WREG32(mmIH_RB_CNTL, tmp);
 	}
 	return (wptr & ih->ptr_mask);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/cz_ih.c b/drivers/gpu/drm/amd/amdgpu/cz_ih.c
index b8c47e0cf37ad..c19681492efa7 100644
--- a/drivers/gpu/drm/amd/amdgpu/cz_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/cz_ih.c
@@ -216,6 +216,11 @@ static u32 cz_ih_get_wptr(struct amdgpu_device *adev,
 	tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 1);
 	WREG32(mmIH_RB_CNTL, tmp);
 
+	/* Unset the CLEAR_OVERFLOW bit immediately so new overflows
+	 * can be detected.
+	 */
+	tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 0);
+	WREG32(mmIH_RB_CNTL, tmp);
 
 out:
 	return (wptr & ih->ptr_mask);
diff --git a/drivers/gpu/drm/amd/amdgpu/iceland_ih.c b/drivers/gpu/drm/amd/amdgpu/iceland_ih.c
index aecad530b10a6..2c02ae69883d2 100644
--- a/drivers/gpu/drm/amd/amdgpu/iceland_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/iceland_ih.c
@@ -215,6 +215,11 @@ static u32 iceland_ih_get_wptr(struct amdgpu_device *adev,
 	tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 1);
 	WREG32(mmIH_RB_CNTL, tmp);
 
+	/* Unset the CLEAR_OVERFLOW bit immediately so new overflows
+	 * can be detected.
+	 */
+	tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 0);
+	WREG32(mmIH_RB_CNTL, tmp);
 
 out:
 	return (wptr & ih->ptr_mask);
diff --git a/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c b/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
index 7cd79a3844b24..657e4ca6f9dd2 100644
--- a/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/ih_v6_0.c
@@ -417,6 +417,12 @@ static u32 ih_v6_0_get_wptr(struct amdgpu_device *adev,
 	tmp = RREG32_NO_KIQ(ih_regs->ih_rb_cntl);
 	tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 1);
 	WREG32_NO_KIQ(ih_regs->ih_rb_cntl, tmp);
+
+	/* Unset the CLEAR_OVERFLOW bit immediately so new overflows
+	 * can be detected.
+	 */
+	tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 0);
+	WREG32_NO_KIQ(ih_regs->ih_rb_cntl, tmp);
 out:
 	return (wptr & ih->ptr_mask);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
index eec13cb5bf758..84e8e8b008ef6 100644
--- a/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/navi10_ih.c
@@ -442,6 +442,12 @@ static u32 navi10_ih_get_wptr(struct amdgpu_device *adev,
 	tmp = RREG32_NO_KIQ(ih_regs->ih_rb_cntl);
 	tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 1);
 	WREG32_NO_KIQ(ih_regs->ih_rb_cntl, tmp);
+
+	/* Unset the CLEAR_OVERFLOW bit immediately so new overflows
+	 * can be detected.
+	 */
+	tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 0);
+	WREG32_NO_KIQ(ih_regs->ih_rb_cntl, tmp);
 out:
 	return (wptr & ih->ptr_mask);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/si_ih.c b/drivers/gpu/drm/amd/amdgpu/si_ih.c
index 9a24f17a57502..cada9f300a7f5 100644
--- a/drivers/gpu/drm/amd/amdgpu/si_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/si_ih.c
@@ -119,6 +119,12 @@ static u32 si_ih_get_wptr(struct amdgpu_device *adev,
 		tmp = RREG32(IH_RB_CNTL);
 		tmp |= IH_RB_CNTL__WPTR_OVERFLOW_CLEAR_MASK;
 		WREG32(IH_RB_CNTL, tmp);
+
+		/* Unset the CLEAR_OVERFLOW bit immediately so new overflows
+		 * can be detected.
+		 */
+		tmp &= ~IH_RB_CNTL__WPTR_OVERFLOW_CLEAR_MASK;
+		WREG32(IH_RB_CNTL, tmp);
 	}
 	return (wptr & ih->ptr_mask);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/tonga_ih.c b/drivers/gpu/drm/amd/amdgpu/tonga_ih.c
index b08905d1c00f0..07a5d95be07f5 100644
--- a/drivers/gpu/drm/amd/amdgpu/tonga_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/tonga_ih.c
@@ -219,6 +219,12 @@ static u32 tonga_ih_get_wptr(struct amdgpu_device *adev,
 	tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 1);
 	WREG32(mmIH_RB_CNTL, tmp);
 
+	/* Unset the CLEAR_OVERFLOW bit immediately so new overflows
+	 * can be detected.
+	 */
+	tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 0);
+	WREG32(mmIH_RB_CNTL, tmp);
+
 out:
 	return (wptr & ih->ptr_mask);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
index 1e83db0c5438d..74c94df423455 100644
--- a/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/vega10_ih.c
@@ -373,6 +373,12 @@ static u32 vega10_ih_get_wptr(struct amdgpu_device *adev,
 	tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 1);
 	WREG32_NO_KIQ(ih_regs->ih_rb_cntl, tmp);
 
+	/* Unset the CLEAR_OVERFLOW bit immediately so new overflows
+	 * can be detected.
+	 */
+	tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 0);
+	WREG32_NO_KIQ(ih_regs->ih_rb_cntl, tmp);
+
 out:
 	return (wptr & ih->ptr_mask);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
index 59dfca093155c..f1ba76c35cd6e 100644
--- a/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/vega20_ih.c
@@ -424,6 +424,12 @@ static u32 vega20_ih_get_wptr(struct amdgpu_device *adev,
 	tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 1);
 	WREG32_NO_KIQ(ih_regs->ih_rb_cntl, tmp);
 
+	/* Unset the CLEAR_OVERFLOW bit immediately so new overflows
+	 * can be detected.
+	 */
+	tmp = REG_SET_FIELD(tmp, IH_RB_CNTL, WPTR_OVERFLOW_CLEAR, 0);
+	WREG32_NO_KIQ(ih_regs->ih_rb_cntl, tmp);
+
 out:
 	return (wptr & ih->ptr_mask);
 }
-- 
2.43.0


