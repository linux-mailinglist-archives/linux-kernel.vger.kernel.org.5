Return-Path: <linux-kernel+bounces-115639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CABB988A087
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:57:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12017B3DDDA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10F8534E9D1;
	Mon, 25 Mar 2024 02:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jEGOv6lT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D1D136996;
	Sun, 24 Mar 2024 23:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321496; cv=none; b=tj9eo0jX07JhKwYJhkld85IvdwO9Glqki1esG4ia0b1851YB1RnkGPA2iBQg9QVx5z0sWu5C10Jc7v2lEw2mEqYFgVrzTsAN0K3aJhE921Wc51V6Spnm1oF2enTxr5odZhDSux3eAVWB5ntpjwiK4tnPg3R8N2zXLw4cMF3BaSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321496; c=relaxed/simple;
	bh=9u5NrhJcsS9DElx+ocr086SXQ18+mS2wYgg/2/lpBXU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KF6Y5bL0OuStM3FUfUZcJLF6MDH33fXi6FuuY9eN1GaENVcZUJPO2MnpoXSDRYenFtFErQAslRl0JGHMwvDphk1sC/ODq3AuZrOx+6V0vu5EKdDhvdKlLQG+gS90kXvtalcbVVIo5HwRzDERyFeXzaKnwwGhKPTKoZC/YKvIfyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jEGOv6lT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62808C43399;
	Sun, 24 Mar 2024 23:04:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321495;
	bh=9u5NrhJcsS9DElx+ocr086SXQ18+mS2wYgg/2/lpBXU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jEGOv6lTW1W2T0Lb8pk0/1SRxNBaninMYefnrN9q5r0tXp4p8OA/IFfnX3bz6Mr0c
	 BVQhYmB7nIc81pZQdSwL+pZp/T7hLtkYDJ9ERT8cxiQDx4A/RR149VN5uiJwAfQu6S
	 d0bvct3tFcrKM/DfWDO9R2YDLb6G1CUiv+nrizIeYKixLQR2W96e6ovpSm80zNV1GR
	 uy04GV75UCLmQhtTXvcDH/qeJ3fH+Y9Mef7AJYHTdqwtuzPRF6Rda7cELdvOBYzFfw
	 6gW6ZcTRBGHmgjXFlM0VAWzo24d3C4cPQw4l4BnK5VZ1Vfl/GTehYGAbZM1T/8o0AS
	 9xi7m1XIdXSCA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Unnathi Chalicheemala <quic_uchalich@quicinc.com>,
	Elliot Berman <quic_eberman@quicinc.com>,
	Mukesh Ojha <quic_mojha@quicinc.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 220/638] soc: qcom: llcc: Check return value on Broadcast_OR reg read
Date: Sun, 24 Mar 2024 18:54:17 -0400
Message-ID: <20240324230116.1348576-221-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Unnathi Chalicheemala <quic_uchalich@quicinc.com>

[ Upstream commit ceeaddc19a90039861564d8e1078b778a8f95101 ]

Commit c72ca343f911 ("soc: qcom: llcc: Add v4.1 HW version support")
introduced a new 4.1 if statement in llcc_update_act_ctrl() without
considering that ret might be overwritten. So, add return value check
after Broadcast_OR register read in llcc_update_act_ctrl().

Fixes: c72ca343f911 ("soc: qcom: llcc: Add v4.1 HW version support")
Signed-off-by: Unnathi Chalicheemala <quic_uchalich@quicinc.com>
Reviewed-by: Elliot Berman <quic_eberman@quicinc.com>
Reviewed-by: Mukesh Ojha <quic_mojha@quicinc.com>
Link: https://lore.kernel.org/r/20240212183515.433873-1-quic_uchalich@quicinc.com
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/soc/qcom/llcc-qcom.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/soc/qcom/llcc-qcom.c b/drivers/soc/qcom/llcc-qcom.c
index e877aace11555..03d5de759b256 100644
--- a/drivers/soc/qcom/llcc-qcom.c
+++ b/drivers/soc/qcom/llcc-qcom.c
@@ -610,6 +610,8 @@ static int llcc_update_act_ctrl(u32 sid,
 	ret = regmap_read_poll_timeout(drv_data->bcast_regmap, status_reg,
 				      slice_status, !(slice_status & status),
 				      0, LLCC_STATUS_READ_DELAY);
+	if (ret)
+		return ret;
 
 	if (drv_data->version >= LLCC_VERSION_4_1_0_0)
 		ret = regmap_write(drv_data->bcast_regmap, act_clear_reg,
-- 
2.43.0


