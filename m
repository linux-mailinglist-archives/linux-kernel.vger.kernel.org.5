Return-Path: <linux-kernel+bounces-62668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EF4DD852430
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 01:45:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7EB6EB2664A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 00:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08397633E7;
	Tue, 13 Feb 2024 00:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L3Jth6gE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4836963131;
	Tue, 13 Feb 2024 00:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707783710; cv=none; b=i+DScPbjdv0tOKcts0bEL6pylB3e4m8vS8yJa0qn/Oxz0vxgNKYhGw6L361es8PxiP1GvvRP4ILhG9f7u+9p3qZ6PbuHme4jIQatf2kg/O+Emhj+t7g9Q0uVKGMkriP3KOP2V9tMfVv+K8nakyeIvXbtvktXdiOLYvLs6Yr6zy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707783710; c=relaxed/simple;
	bh=UgzG8GfobsDYimcbdrx2RqxzhsKbSTEF4rLtVP4bQmg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pNqdnkdu1i4iPZpJJMKZJOrOL/Lrm6NsWVB7V4cY6wnrkLS+vkijv4Y8z6zbw7UxCfMJt4aWtR2/T0nqQ0QkzPv0tnqkESy0e5IDS4NGhr2Imw9K4dGHCDnf1JwFgGlmBWlG2ZnJqC0IHgZ32MCQMs3OsDNtKHds5C13l7beOHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L3Jth6gE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2B42C43601;
	Tue, 13 Feb 2024 00:21:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707783710;
	bh=UgzG8GfobsDYimcbdrx2RqxzhsKbSTEF4rLtVP4bQmg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L3Jth6gElLO4VnMcgLuSRiAJqmAL6qctfh9k6tJO5Na6gV/XmI3VTbj1BEk18K4rc
	 oPnwEbJ0DeLozGcNgLLA6LC5vqb4Hmf3ugmKHsP5rp11YLOB7Bn/reksGghVP4hATH
	 94QX4UgJq0SpreekwUHY2QZwg6KkYuARFtp0s90K7B5I3j4XKtZ4Fhrdj2xUWTRKOD
	 IdzlnaB98z/R5Ue8jOH1OM4n4irx9oVvsq9hbZt+xDK9128hFoNSYxnfZAPbwsAAYA
	 daPgrFWCDPFUVsKEXKtIUEoMSIp8uWVlIpSZBelveVVp9g7ghv+sRFWeglM5HqI888
	 tJLAqLb27WRng==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: "Wachowski, Karol" <karol.wachowski@intel.com>,
	Wachowski@web.codeaurora.org,
	Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
	Jeffrey Hugo <quic_jhugo@quicinc.com>,
	Sasha Levin <sashal@kernel.org>, stanislaw.gruszka@linux.intel.com,
	ogabbay@kernel.org, dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.6 37/51] accel/ivpu: Force snooping for MMU writes
Date: Mon, 12 Feb 2024 19:20:14 -0500
Message-ID: <20240213002052.670571-37-sashal@kernel.org>
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

From: "Wachowski, Karol" <karol.wachowski@intel.com>

[ Upstream commit c9da9a1f17bf4fa96b115950fd389c917b583c1c ]

Set AW_SNOOP_OVERRIDE bit in VPU_37/40XX_HOST_IF_TCU_PTW_OVERRIDES
to force snooping for MMU write accesses (setting event queue events).

MMU event queue buffer is the only buffer written by MMU and
mapped as write-back which break cache coherency. Force write
transactions to be snooped solving the problem.

Signed-off-by: Wachowski, Karol <karol.wachowski@intel.com>
Signed-off-by: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
Reviewed-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240126122804.2169129-2-jacek.lawrynowicz@linux.intel.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/accel/ivpu/ivpu_hw_37xx.c | 2 +-
 drivers/accel/ivpu/ivpu_hw_40xx.c | 2 +-
 drivers/accel/ivpu/ivpu_mmu.c     | 3 ---
 3 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/accel/ivpu/ivpu_hw_37xx.c b/drivers/accel/ivpu/ivpu_hw_37xx.c
index ddf03498fd4c..c0de7c0c991f 100644
--- a/drivers/accel/ivpu/ivpu_hw_37xx.c
+++ b/drivers/accel/ivpu/ivpu_hw_37xx.c
@@ -562,7 +562,7 @@ static void ivpu_boot_no_snoop_enable(struct ivpu_device *vdev)
 	u32 val = REGV_RD32(VPU_37XX_HOST_IF_TCU_PTW_OVERRIDES);
 
 	val = REG_SET_FLD(VPU_37XX_HOST_IF_TCU_PTW_OVERRIDES, NOSNOOP_OVERRIDE_EN, val);
-	val = REG_SET_FLD(VPU_37XX_HOST_IF_TCU_PTW_OVERRIDES, AW_NOSNOOP_OVERRIDE, val);
+	val = REG_CLR_FLD(VPU_37XX_HOST_IF_TCU_PTW_OVERRIDES, AW_NOSNOOP_OVERRIDE, val);
 	val = REG_SET_FLD(VPU_37XX_HOST_IF_TCU_PTW_OVERRIDES, AR_NOSNOOP_OVERRIDE, val);
 
 	REGV_WR32(VPU_37XX_HOST_IF_TCU_PTW_OVERRIDES, val);
diff --git a/drivers/accel/ivpu/ivpu_hw_40xx.c b/drivers/accel/ivpu/ivpu_hw_40xx.c
index 03600a7a5aca..65c6a82bb13f 100644
--- a/drivers/accel/ivpu/ivpu_hw_40xx.c
+++ b/drivers/accel/ivpu/ivpu_hw_40xx.c
@@ -523,7 +523,7 @@ static void ivpu_boot_no_snoop_enable(struct ivpu_device *vdev)
 	u32 val = REGV_RD32(VPU_40XX_HOST_IF_TCU_PTW_OVERRIDES);
 
 	val = REG_SET_FLD(VPU_40XX_HOST_IF_TCU_PTW_OVERRIDES, SNOOP_OVERRIDE_EN, val);
-	val = REG_CLR_FLD(VPU_40XX_HOST_IF_TCU_PTW_OVERRIDES, AW_SNOOP_OVERRIDE, val);
+	val = REG_SET_FLD(VPU_40XX_HOST_IF_TCU_PTW_OVERRIDES, AW_SNOOP_OVERRIDE, val);
 	val = REG_CLR_FLD(VPU_40XX_HOST_IF_TCU_PTW_OVERRIDES, AR_SNOOP_OVERRIDE, val);
 
 	REGV_WR32(VPU_40XX_HOST_IF_TCU_PTW_OVERRIDES, val);
diff --git a/drivers/accel/ivpu/ivpu_mmu.c b/drivers/accel/ivpu/ivpu_mmu.c
index baefaf7bb3cb..d04a28e05248 100644
--- a/drivers/accel/ivpu/ivpu_mmu.c
+++ b/drivers/accel/ivpu/ivpu_mmu.c
@@ -491,7 +491,6 @@ static int ivpu_mmu_reset(struct ivpu_device *vdev)
 	mmu->cmdq.cons = 0;
 
 	memset(mmu->evtq.base, 0, IVPU_MMU_EVTQ_SIZE);
-	clflush_cache_range(mmu->evtq.base, IVPU_MMU_EVTQ_SIZE);
 	mmu->evtq.prod = 0;
 	mmu->evtq.cons = 0;
 
@@ -805,8 +804,6 @@ static u32 *ivpu_mmu_get_event(struct ivpu_device *vdev)
 	if (!CIRC_CNT(IVPU_MMU_Q_IDX(evtq->prod), IVPU_MMU_Q_IDX(evtq->cons), IVPU_MMU_Q_COUNT))
 		return NULL;
 
-	clflush_cache_range(evt, IVPU_MMU_EVTQ_CMD_SIZE);
-
 	evtq->cons = (evtq->cons + 1) & IVPU_MMU_Q_WRAP_MASK;
 	REGV_WR32(VPU_37XX_HOST_MMU_EVTQ_CONS_SEC, evtq->cons);
 
-- 
2.43.0


