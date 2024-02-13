Return-Path: <linux-kernel+bounces-62615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22A618523A8
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 01:30:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1C38281453
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 00:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B61156743;
	Tue, 13 Feb 2024 00:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jNxlG2KB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C785645E;
	Tue, 13 Feb 2024 00:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707783590; cv=none; b=KculKqnsGakI94ffFA6xqAAnBppaMPfKcMRvTswfNDs50obAgRBtmqw6fBAtqkWZw/Mv0Ai4wgwQOoopDqxzdrP9/sKd6FsTB10fNZS/bQtb2b2wGDGx+sljSzXGrkjMHH9hM/sRrciq7JODi9Nr5PP7y9qjp6kVNwE6Gb4g5xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707783590; c=relaxed/simple;
	bh=QGj5j0oEDjjnBXJCwY1815nVn1vrlL+NkbYjRzcy7qg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I985AFdV1hWLl6r7SbKO4O83A+0FZgpp170Yk42TAOE5v7IvGxlXtmc8DA+WrfszSi9zJ0trYjJ1ry1uKN9dRrDG10L8KlyVaLYygjsutoULAti1q1QoEhzJcwz3FAGGK+AcDSOpR6dnL3E74yhwT7D6maEODoQnmQ+Lht5uwlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jNxlG2KB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBE94C433C7;
	Tue, 13 Feb 2024 00:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707783590;
	bh=QGj5j0oEDjjnBXJCwY1815nVn1vrlL+NkbYjRzcy7qg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jNxlG2KBDhk9ksqueWhPLERSUO+PHPUuA68K0IlRtp8J2sHryz6nFryDhPrxohAZ/
	 JtihtLlXnCBTzRbCTh813v61R7/Jk9+FgzVNR5AgL498/41YgO8syMUOTrGcGoCLoV
	 rertq50f0qP3HUKVzW8lK0U9jWYLa1yKPsiNCBLiUvJXMXl5aLrpeZlK5a2+DMdPBR
	 UADq8u6CdwykSLPDK0hFvPdoMmcc8ua/98EYTEgksRfMvCW0fdoG4i7FST3SG+jiBd
	 7DfNbL+85MmivRFb4fWws9eC/Kx5tS7BCk8R1IEhhMNwoQLAw0LwQq5MDnSeKoFiVM
	 Vhg+1cEHXkUsA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: "Wachowski, Karol" <karol.wachowski@intel.com>,
	Wachowski@web.codeaurora.org,
	Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
	Jeffrey Hugo <quic_jhugo@quicinc.com>,
	Sasha Levin <sashal@kernel.org>, stanislaw.gruszka@linux.intel.com,
	ogabbay@kernel.org, dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.7 43/58] accel/ivpu: Force snooping for MMU writes
Date: Mon, 12 Feb 2024 19:17:49 -0500
Message-ID: <20240213001837.668862-43-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213001837.668862-1-sashal@kernel.org>
References: <20240213001837.668862-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.4
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
index d530384f8d60..e658fcf849f7 100644
--- a/drivers/accel/ivpu/ivpu_hw_37xx.c
+++ b/drivers/accel/ivpu/ivpu_hw_37xx.c
@@ -523,7 +523,7 @@ static void ivpu_boot_no_snoop_enable(struct ivpu_device *vdev)
 	u32 val = REGV_RD32(VPU_37XX_HOST_IF_TCU_PTW_OVERRIDES);
 
 	val = REG_SET_FLD(VPU_37XX_HOST_IF_TCU_PTW_OVERRIDES, NOSNOOP_OVERRIDE_EN, val);
-	val = REG_SET_FLD(VPU_37XX_HOST_IF_TCU_PTW_OVERRIDES, AW_NOSNOOP_OVERRIDE, val);
+	val = REG_CLR_FLD(VPU_37XX_HOST_IF_TCU_PTW_OVERRIDES, AW_NOSNOOP_OVERRIDE, val);
 	val = REG_SET_FLD(VPU_37XX_HOST_IF_TCU_PTW_OVERRIDES, AR_NOSNOOP_OVERRIDE, val);
 
 	REGV_WR32(VPU_37XX_HOST_IF_TCU_PTW_OVERRIDES, val);
diff --git a/drivers/accel/ivpu/ivpu_hw_40xx.c b/drivers/accel/ivpu/ivpu_hw_40xx.c
index e691c49c9841..8a7440bcd6df 100644
--- a/drivers/accel/ivpu/ivpu_hw_40xx.c
+++ b/drivers/accel/ivpu/ivpu_hw_40xx.c
@@ -526,7 +526,7 @@ static void ivpu_boot_no_snoop_enable(struct ivpu_device *vdev)
 	u32 val = REGV_RD32(VPU_40XX_HOST_IF_TCU_PTW_OVERRIDES);
 
 	val = REG_SET_FLD(VPU_40XX_HOST_IF_TCU_PTW_OVERRIDES, SNOOP_OVERRIDE_EN, val);
-	val = REG_CLR_FLD(VPU_40XX_HOST_IF_TCU_PTW_OVERRIDES, AW_SNOOP_OVERRIDE, val);
+	val = REG_SET_FLD(VPU_40XX_HOST_IF_TCU_PTW_OVERRIDES, AW_SNOOP_OVERRIDE, val);
 	val = REG_CLR_FLD(VPU_40XX_HOST_IF_TCU_PTW_OVERRIDES, AR_SNOOP_OVERRIDE, val);
 
 	REGV_WR32(VPU_40XX_HOST_IF_TCU_PTW_OVERRIDES, val);
diff --git a/drivers/accel/ivpu/ivpu_mmu.c b/drivers/accel/ivpu/ivpu_mmu.c
index 2538c78fbebe..9898946174fd 100644
--- a/drivers/accel/ivpu/ivpu_mmu.c
+++ b/drivers/accel/ivpu/ivpu_mmu.c
@@ -533,7 +533,6 @@ static int ivpu_mmu_reset(struct ivpu_device *vdev)
 	mmu->cmdq.cons = 0;
 
 	memset(mmu->evtq.base, 0, IVPU_MMU_EVTQ_SIZE);
-	clflush_cache_range(mmu->evtq.base, IVPU_MMU_EVTQ_SIZE);
 	mmu->evtq.prod = 0;
 	mmu->evtq.cons = 0;
 
@@ -847,8 +846,6 @@ static u32 *ivpu_mmu_get_event(struct ivpu_device *vdev)
 	if (!CIRC_CNT(IVPU_MMU_Q_IDX(evtq->prod), IVPU_MMU_Q_IDX(evtq->cons), IVPU_MMU_Q_COUNT))
 		return NULL;
 
-	clflush_cache_range(evt, IVPU_MMU_EVTQ_CMD_SIZE);
-
 	evtq->cons = (evtq->cons + 1) & IVPU_MMU_Q_WRAP_MASK;
 	REGV_WR32(IVPU_MMU_REG_EVTQ_CONS_SEC, evtq->cons);
 
-- 
2.43.0


