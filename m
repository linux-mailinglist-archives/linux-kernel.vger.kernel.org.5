Return-Path: <linux-kernel+bounces-116331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE99F889E4F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:06:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3A791F375BF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2456729BB06;
	Mon, 25 Mar 2024 03:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RbGdeduh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 578C4296169;
	Sun, 24 Mar 2024 23:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324317; cv=none; b=U9K/yQS3CbJw2sXZ3XLFQ3xKOBeXW4yu54T2QxI6izNZS4REPrlwRiIlR0PtRYq5YQ2CU5BmIU/NQgBmDNDRSv+oqRo6FbThy4uGk2W7sP7zrVVtJi638NvIr5f2HhjkcEfMa7WoHBKHQ8b3AOACp8qdeyBb0XY0TfKuUh/akFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324317; c=relaxed/simple;
	bh=YSgfR+iwNZXq5JgYJ4A2KR4Tqnl/88XavKHKucwJQ+w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KcMnQVmNyr7taGiWOAMRCNzsJJTMIfdZV+3i3kQlAi+HyKjHeVyvrxiMoVoyew5xZ/s/nUZyOYK9R4xFU1Ur6qcbNIX+EDLXmmxdg0AFS0Jx1LjSMnLc+fXiyBcaUrU9Hjud5o3rzn8F06+Ol/GkpUXFQN2EhFDzU7LNXvlqMbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RbGdeduh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90FD8C433C7;
	Sun, 24 Mar 2024 23:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324317;
	bh=YSgfR+iwNZXq5JgYJ4A2KR4Tqnl/88XavKHKucwJQ+w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RbGdeduhp1aXbeoqrbyAXoYwV1OoOz1QJu4jLISI3pikO4yQbBFbVR7glFUpLsURN
	 PADvZXAKgZElldv5DI0zgp8/RKn9RzTnpJc7wrrk36REYfgNws7tlHxkDRWtx+oHoS
	 xAlOQHDrfPe2n959F4Jct9kaouOi6bqx1BkcWFuzfWhVLFNmi9ld7a60Ah2dE1Ots5
	 ik5bV78FoF6/53vSNlI91W04DMnPUUD25OrEaM7npb+7hwTmvuop43UAY/Uq69LS5/
	 CwzaqbQwc4gyl6ya1dg9ctz5mvWrp0kzxYdspI01BzkJNzsHZpXL0ArwCFj2S+TtUw
	 vG0Zwy2w6oSUg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Stephan Gerhold <stephan.gerhold@kernkonzept.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 088/148] clk: qcom: reset: Allow specifying custom reset delay
Date: Sun, 24 Mar 2024 19:49:12 -0400
Message-ID: <20240324235012.1356413-89-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324235012.1356413-1-sashal@kernel.org>
References: <20240324235012.1356413-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Stephan Gerhold <stephan.gerhold@kernkonzept.com>

[ Upstream commit 2cb8a39b6781ea23accd1fa93b3ad000d0948aec ]

The amount of time required between asserting and deasserting the reset
signal can vary depending on the involved hardware component. Sometimes
1 us might not be enough and a larger delay is necessary to conform to
the specifications.

Usually this is worked around in the consuming drivers, by replacing
reset_control_reset() with a sequence of reset_control_assert(), waiting
for a custom delay, followed by reset_control_deassert().

However, in some cases the driver making use of the reset is generic and
can be used with different reset controllers. In this case the reset
time requirement is better handled directly by the reset controller
driver.

Make this possible by adding an "udelay" field to the qcom_reset_map
that allows setting a different reset delay (in microseconds).

Signed-off-by: Stephan Gerhold <stephan.gerhold@kernkonzept.com>
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Link: https://lore.kernel.org/r/20220706134132.3623415-4-stephan.gerhold@kernkonzept.com
Stable-dep-of: 2f8cf2c3f3e3 ("clk: qcom: reset: Ensure write completion on reset de/assertion")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/qcom/reset.c | 4 +++-
 drivers/clk/qcom/reset.h | 1 +
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/reset.c b/drivers/clk/qcom/reset.c
index 0324d8daab9bc..fc68c8fa30ac7 100644
--- a/drivers/clk/qcom/reset.c
+++ b/drivers/clk/qcom/reset.c
@@ -21,8 +21,10 @@
 
 static int qcom_reset(struct reset_controller_dev *rcdev, unsigned long id)
 {
+	struct qcom_reset_controller *rst = to_qcom_reset_controller(rcdev);
+
 	rcdev->ops->assert(rcdev, id);
-	udelay(1);
+	udelay(rst->reset_map[id].udelay ?: 1); /* use 1 us as default */
 	rcdev->ops->deassert(rcdev, id);
 	return 0;
 }
diff --git a/drivers/clk/qcom/reset.h b/drivers/clk/qcom/reset.h
index cda877927d43a..3e30f6724c7a4 100644
--- a/drivers/clk/qcom/reset.h
+++ b/drivers/clk/qcom/reset.h
@@ -19,6 +19,7 @@
 struct qcom_reset_map {
 	unsigned int reg;
 	u8 bit;
+	u8 udelay;
 };
 
 struct regmap;
-- 
2.43.0


