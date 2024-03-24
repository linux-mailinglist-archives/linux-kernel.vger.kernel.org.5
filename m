Return-Path: <linux-kernel+bounces-114049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 361E088880F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:17:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DECCE1F2661B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA80F22F8C5;
	Sun, 24 Mar 2024 23:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E9RfObhH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC291FD116;
	Sun, 24 Mar 2024 23:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321329; cv=none; b=am5k7Aqm54RLWgJBMsZjVE+NVDN0oSDU9IagHtnZy265Bc29+YviAdMeiGozQbLZOZ7Xb/5g6U0gmaqQuumTgHgtpcfC3lrTb9TeXJ7JFkoUgvoAhxTo1ROnI0U9j8dQ9Ej1aqXq3sQFz02VJ0UJnFCR+OpZBipZcvcuq2Iodiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321329; c=relaxed/simple;
	bh=hznCVND+HknEJDdeppqPpocutl/j4K2q3jGl5en2yYQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RAVbzBpieiK4CQ8asj/VeuFNpaZERAo6bq/Uhjjb70ELzXfOmDyFb55EG5Ro+ScuNSWO1Kv238PQl/b4jTFX6ikFkNHHUXD+L5Z5Q641UiktzAvoQ/a8FTV/tVmfvSw30VlYuJNVhKcZq3I7wG1LFLQcNbfT0w47a8Pzf6T+sf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E9RfObhH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 156AAC43390;
	Sun, 24 Mar 2024 23:02:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321328;
	bh=hznCVND+HknEJDdeppqPpocutl/j4K2q3jGl5en2yYQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E9RfObhHyxelmqY+sA6Ouj+3lVn7ktUZdIjoxfRtTaVwsDDPxhG29XMIurR02ELJ9
	 daDGrDc1sOmQWzk7IOFDfUmvDxLsziO15XO8XT6lkvcuAhCHHCP0OF7p2z8fSCp/nE
	 sZdoCwy3kqXOJ7FGMn4AkRhQ7kLSOlJ2oZFF9YxDQauqhFxUiwYzybBezpa/Hg3rgk
	 dy4O6UOUHOksM+Mtz7NSIaCXFujRO/MpBvZtdQ7k+CAvrFMZZSfP/V9Zbh9SOLgCJG
	 RjVfPt1IaKNvsNvtdVpchAes9wzQ1Fle2d/edJzAiQJ/jRJC98sxU7JjCL8N2ajhOV
	 +ZqfOQo+btkNQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jiawei Wang <me@jwang.link>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 052/638] ASoC: amd: yc: Fix non-functional mic on Lenovo 21J2
Date: Sun, 24 Mar 2024 18:51:29 -0400
Message-ID: <20240324230116.1348576-53-sashal@kernel.org>
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

From: Jiawei Wang <me@jwang.link>

[ Upstream commit ed00a6945dc32462c2d3744a3518d2316da66fcc ]

Like many other models, the Lenovo 21J2 (ThinkBook 16 G5+ APO)
needs a quirk entry for the internal microphone to function.

Signed-off-by: Jiawei Wang <me@jwang.link>
Link: https://msgid.link/r/20240228073914.232204-2-me@jwang.link
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/amd/yc/acp6x-mach.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/amd/yc/acp6x-mach.c b/sound/soc/amd/yc/acp6x-mach.c
index 5587198751daa..abb9589b8477c 100644
--- a/sound/soc/amd/yc/acp6x-mach.c
+++ b/sound/soc/amd/yc/acp6x-mach.c
@@ -199,6 +199,13 @@ static const struct dmi_system_id yc_acp_quirk_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "21HY"),
 		}
 	},
+	{
+		.driver_data = &acp6x_card,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "21J2"),
+		}
+	},
 	{
 		.driver_data = &acp6x_card,
 		.matches = {
-- 
2.43.0


