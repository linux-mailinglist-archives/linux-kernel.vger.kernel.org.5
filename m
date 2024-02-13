Return-Path: <linux-kernel+bounces-62670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87F4E852434
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 01:45:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB2491C236E4
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 00:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E72E6634E9;
	Tue, 13 Feb 2024 00:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tCzvuuO0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE776340F;
	Tue, 13 Feb 2024 00:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707783713; cv=none; b=OIOt5XmBP5hnEh9RcOiXzU6YnPwokqzmOuDxRsnbcGhqn4c36WNHL8CbPHhfxWoCpqA/i4XhYku7gtH9n0km14MoX5IZYTvtF277KGjM5vq7szbsopJRaWWJjHoQFTTiJmwDNADCFSFJNzrLo7olPOKlLbZD5R3lISCzU5hCzzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707783713; c=relaxed/simple;
	bh=kcc+u4KbzlVoh42OFnpyRdLSr+gaYAJJhrBWSqfzEzc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hxXWhRMJW6VtQhEpghPjG2RWs7yR1NkPsRWiRsp1UvhJ29PGNdDd5GP3VeNB5A8BZAnvsyn4Jg27v1Rr36Xy6YIeD6lhu7S6THGmRNf9QbgApwbrPuaqcSTwMkoWGaQqeolPyFj4o53c7IwYJCwjNqHxC7UxV+BDUu4uiq8Rsg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tCzvuuO0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEB41C433F1;
	Tue, 13 Feb 2024 00:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707783713;
	bh=kcc+u4KbzlVoh42OFnpyRdLSr+gaYAJJhrBWSqfzEzc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tCzvuuO0vRQ1zy/FMT8mFTmEwcH5i+5GSp1wq9xk8YKaledffqjymlSrQv6h+A6Z8
	 U+whXiaJstnbrHE9BkziOWB1uef7LN03ZTfuI7d1PxBU59hvyprLsIt3oQRvlhb5WZ
	 CwL8S5pnU93DiTjJU0vwM+5OKL9SevWqakR7LaCZiBhvGrfBXo4eJUPB+wdGHVpdUl
	 XMC4X0CW3QNM6hco8AFquWIHlh47ICAggZQjHNyduh46XF5gTX9D9IebnWGeH4MQcs
	 tu7oUvBfW454f6zvLeR5PHZ1/MICQIPLz9QZmHgwyqpQgnkafcEg6yVit47ysryrFq
	 tKkgtcSCujZlA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Krystian Pradzynski <krystian.pradzynski@intel.com>,
	Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
	Jeffrey Hugo <quic_jhugo@quicinc.com>,
	Sasha Levin <sashal@kernel.org>,
	stanislaw.gruszka@linux.intel.com,
	ogabbay@kernel.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.6 39/51] accel/ivpu/40xx: Stop passing SKU boot parameters to FW
Date: Mon, 12 Feb 2024 19:20:16 -0500
Message-ID: <20240213002052.670571-39-sashal@kernel.org>
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

From: Krystian Pradzynski <krystian.pradzynski@intel.com>

[ Upstream commit 553099da45397914a995dce6307d6c26523c2567 ]

This parameter was never used by the 40xx FW.

Signed-off-by: Krystian Pradzynski <krystian.pradzynski@intel.com>
Signed-off-by: Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>
Reviewed-by: Jeffrey Hugo <quic_jhugo@quicinc.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240126122804.2169129-7-jacek.lawrynowicz@linux.intel.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/accel/ivpu/ivpu_hw_40xx.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/accel/ivpu/ivpu_hw_40xx.c b/drivers/accel/ivpu/ivpu_hw_40xx.c
index 65c6a82bb13f..ae6be0d5aacc 100644
--- a/drivers/accel/ivpu/ivpu_hw_40xx.c
+++ b/drivers/accel/ivpu/ivpu_hw_40xx.c
@@ -697,7 +697,6 @@ static int ivpu_hw_40xx_info_init(struct ivpu_device *vdev)
 {
 	struct ivpu_hw_info *hw = vdev->hw;
 	u32 tile_disable;
-	u32 tile_enable;
 	u32 fuse;
 
 	fuse = REGB_RD32(VPU_40XX_BUTTRESS_TILE_FUSE);
@@ -718,10 +717,6 @@ static int ivpu_hw_40xx_info_init(struct ivpu_device *vdev)
 	else
 		ivpu_dbg(vdev, MISC, "Fuse: All %d tiles enabled\n", TILE_MAX_NUM);
 
-	tile_enable = (~tile_disable) & TILE_MAX_MASK;
-
-	hw->sku = REG_SET_FLD_NUM(SKU, HW_ID, LNL_HW_ID, hw->sku);
-	hw->sku = REG_SET_FLD_NUM(SKU, TILE, tile_enable, hw->sku);
 	hw->tile_fuse = tile_disable;
 	hw->pll.profiling_freq = PLL_PROFILING_FREQ_DEFAULT;
 
-- 
2.43.0


