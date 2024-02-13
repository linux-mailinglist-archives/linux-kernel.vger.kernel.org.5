Return-Path: <linux-kernel+bounces-62618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BED198523B1
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 01:31:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 522891F21393
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 00:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E70FF8813;
	Tue, 13 Feb 2024 00:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BjyG5zde"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13BB854FA5;
	Tue, 13 Feb 2024 00:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707783593; cv=none; b=SRJg8LSadUmwsX2Vclu1V5+hY499qUCj2rtpop6IiTGHHNJy9Kbx1JbHja2tuGZPXi97gTNv5bQPSIzqge5CaMSeddsHtWhAq9RgbKj1E3NiIeN8h/6uSX4O8LY5f+U3RwQo4AHqBWsCOaiIp7k7Bq2HfIBtVeCOSS8GUMrL7nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707783593; c=relaxed/simple;
	bh=7ynkB4KuekvjZkQ7J+ZoqGj1ObfsvOxomf1rtb8eb44=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VmZnmf396n0Do2nU0C4gbZY/7DI+o9fHFrLRGFF0tWsrEEXdwpjLAypqw5jjqSHObqQrvMxe1BVt0YjOv9uPhiEudiPy6xivkdzFPbhqADiv2+YWaXfBt3MxF3MrqgWDNlVnpi0mF+o8LKHKCJUpJ7OgxSR/IF3NVMjzdoCI2oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BjyG5zde; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D05DDC433B2;
	Tue, 13 Feb 2024 00:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707783592;
	bh=7ynkB4KuekvjZkQ7J+ZoqGj1ObfsvOxomf1rtb8eb44=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BjyG5zde0/6FjWz3SggcmWOXSYfzPiNmInBST0SysY7/XiAmrzT84rT/XSiyDOmsF
	 XpiIDT5LSa9wrVr3byVW4JpYzCYa/yz2IRK7UBA9rjArTUGeujecrHDoYlOc1of30C
	 S9Q++y9uU0dZSThrai54S8mO7IhtycV8FYuyOJMm2HpaRRa9KfQblrYrWFapgu8Dl9
	 h0q0BVe+PCrptQlBpbjy2FwIC8u2VZ1qoLMVQQGQ0F9Y0AdTU66oWtgAAYpdOLIL3j
	 bp6Qo5dISKvAKneE/7IjWK2/ncaPeWFsHY9V4LbFL93XOfCKFqqs+UcsJiCZ7Tg9Yr
	 Yu3yWbV4xfU8Q==
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
Subject: [PATCH AUTOSEL 6.7 45/58] accel/ivpu/40xx: Stop passing SKU boot parameters to FW
Date: Mon, 12 Feb 2024 19:17:51 -0500
Message-ID: <20240213001837.668862-45-sashal@kernel.org>
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
index 8a7440bcd6df..a7c976256ed3 100644
--- a/drivers/accel/ivpu/ivpu_hw_40xx.c
+++ b/drivers/accel/ivpu/ivpu_hw_40xx.c
@@ -700,7 +700,6 @@ static int ivpu_hw_40xx_info_init(struct ivpu_device *vdev)
 {
 	struct ivpu_hw_info *hw = vdev->hw;
 	u32 tile_disable;
-	u32 tile_enable;
 	u32 fuse;
 
 	fuse = REGB_RD32(VPU_40XX_BUTTRESS_TILE_FUSE);
@@ -721,10 +720,6 @@ static int ivpu_hw_40xx_info_init(struct ivpu_device *vdev)
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


