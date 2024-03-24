Return-Path: <linux-kernel+bounces-113976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F52B8887B5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:07:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAFC91C26A69
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 723E8156674;
	Sun, 24 Mar 2024 23:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="joZ5xb6l"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF791F23D8;
	Sun, 24 Mar 2024 22:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321102; cv=none; b=nLCMWkW99Hzq1cDHRH9CwGOwX+L8z6r7BbKzOLCodfWL8Qgwx/JskWwI4ExF853fmodNvk+J0UCfEqoUP++lCZtrk0UL9NWHKaQrtHXNw/NdtuIXBMlt2iNJJEpBvjGa15aFg5BP4e935sHD4oIO8oi/aKba3Zu3T0bMKjUU++M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321102; c=relaxed/simple;
	bh=9123jR0gyQTTvHkC+QjmGNgnRZ6KOlFUFXuEXV9RdQw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GRwn93KibEc9DpXF7W3z1ChSf2LZB/gXLD0Ac0XPAiTY2U4EagBPStoR+gaLWISRGsRwTGmgqh48YOxqjKmCxTc5OduLUYNQzLDIuHTavvnhCPAWaubEMrRU8Q4glcc/npOqV7vTG9Zwlv/fFtb4qgOQt2MyhMBx8l9q2V4Q30s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=joZ5xb6l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2082DC433C7;
	Sun, 24 Mar 2024 22:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321100;
	bh=9123jR0gyQTTvHkC+QjmGNgnRZ6KOlFUFXuEXV9RdQw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=joZ5xb6lTXn26jRWYpVJ1N6H4ejBAg1NTRyMSwVhwKz8Qcen02G2RHkUmHiyZx7k3
	 ZH0ddsAhNIQKcr34FNUpBxfI378R5P2CNAQ7XUvSqZXY8diYXsRh0mLFoPSgLjrA0I
	 pUG8iMiri6FIUCDhpt5UFros1X4JjYzgh+A8uZyg4APItcd40sWiZbU69sBWr569Ge
	 qh3aB/1wmz0mRTmG6PwaGttD/Zum9RNg4O8PgoP+Mbec8N3rkMKvVoGQUguc+5kGg8
	 h+4q87h3cohUbt7pnXGn34LFUYG9bctrTCK6QVa4ua5l5uvZI7njQ4ZM+0B2QMCLJH
	 4480qwsYRH86w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Duanqiang Wen <duanqiangwen@net-swift.com>,
	Michal Kubiak <michal.kubiak@intel.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 663/713] net: txgbe: fix clk_name exceed MAX_DEV_ID limits
Date: Sun, 24 Mar 2024 18:46:29 -0400
Message-ID: <20240324224720.1345309-664-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Duanqiang Wen <duanqiangwen@net-swift.com>

[ Upstream commit e30cef001da259e8df354b813015d0e5acc08740 ]

txgbe register clk which name is i2c_designware.pci_dev_id(),
clk_name will be stored in clk_lookup_alloc. If PCIe bus number
is larger than 0x39, clk_name size will be larger than 20 bytes.
It exceeds clk_lookup_alloc MAX_DEV_ID limits. So the driver
shortened clk_name.

Fixes: b63f20485e43 ("net: txgbe: Register fixed rate clock")
Signed-off-by: Duanqiang Wen <duanqiangwen@net-swift.com>
Reviewed-by: Michal Kubiak <michal.kubiak@intel.com>
Link: https://lore.kernel.org/r/20240313080634.459523-1-duanqiangwen@net-swift.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
index b6c06adb86560..b95187a0847f7 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
@@ -551,7 +551,7 @@ static int txgbe_clock_register(struct txgbe *txgbe)
 	char clk_name[32];
 	struct clk *clk;
 
-	snprintf(clk_name, sizeof(clk_name), "i2c_designware.%d",
+	snprintf(clk_name, sizeof(clk_name), "i2c_dw.%d",
 		 pci_dev_id(pdev));
 
 	clk = clk_register_fixed_rate(NULL, clk_name, NULL, 0, 156250000);
-- 
2.43.0


