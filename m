Return-Path: <linux-kernel+bounces-126601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0EC5893A3E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 12:39:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80A6B1F2117A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 10:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFC29200A6;
	Mon,  1 Apr 2024 10:38:35 +0000 (UTC)
Received: from mx2.usergate.com (mx2.usergate.com [46.229.79.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81DF22209F;
	Mon,  1 Apr 2024 10:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.229.79.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711967915; cv=none; b=G8emiY1on8Y1rJtxLUIEej0KNcxhcor5SK2prC8Rrrq5y+WZafbhPPkHPcQ7LsZk9oUR3Zjmiyp8ai+W8kJfXyaoh0fztBveIjmAiQWYA7IZJEJHHzzhKLppuaNvI/440907vAl1GVz2I7bJx16S1cPnPK+vqVkyBm5H/Z07O50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711967915; c=relaxed/simple;
	bh=3wAh+pB/PnNQex92i1+AES9ZDslGICWsgIRD4jVuNyI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=el31ggzNFczMKnlH4+D7n6ygLqrdW9XssrYN2ktQppp63KugO1CoffpDkDpdToRi60U+W8HP/EbHRpELfbCLFpXJGoEDq/zDJow0MQtNC5pSqHhhyVNjP2xZ6W63S7gpxWUjCPhav9J5H/woSny9PnAqi9bgWkcCLOLGt0xDmPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=usergate.com; spf=pass smtp.mailfrom=usergate.com; arc=none smtp.client-ip=46.229.79.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=usergate.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=usergate.com
Received: from mail.usergate.com[192.168.90.36] by mx2.usergate.com with ESMTP id
	 F0569C2093D044FBB24DB97CF6AC9904; Mon, 1 Apr 2024 17:38:21 +0700
From: Aleksandr Aprelkov <aaprelkov@usergate.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC: Aleksandr Aprelkov <aaprelkov@usergate.com>,Michael Turquette <mturquette@baylibre.com>,Stephen Boyd <sboyd@kernel.org>,<linux-kernel@vger.kernel.org>,<linux-samsung-soc@vger.kernel.org>,<linux-clk@vger.kernel.org>,<lvc-project@linuxtesting.org>
Subject: [PATCH] clk: s2mps11: Check of_clk_add_hw_provider() result
Date: Mon, 1 Apr 2024 17:38:08 +0700
Message-ID: <20240401103808.617463-1-aaprelkov@usergate.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ESLSRV-EXCH-01.esafeline.com (192.168.90.36) To
 nsk02-mbx01.esafeline.com (10.10.1.35)
X-Message-Id: D787E24C5A284804AC7923C7C89510EA
X-MailFileId: 0DE6D82EDE3D42C6A79E7984A7D233FA

There is no check if error occurs in clock provider registration.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: b228fad50c00 ("clk: s2mps11: Migrate to clk_hw based OF and registration APIs")
Signed-off-by: Aleksandr Aprelkov <aaprelkov@usergate.com>
---
 drivers/clk/clk-s2mps11.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/clk-s2mps11.c b/drivers/clk/clk-s2mps11.c
index 38c456540d1b..f9ce413b6c02 100644
--- a/drivers/clk/clk-s2mps11.c
+++ b/drivers/clk/clk-s2mps11.c
@@ -187,8 +187,10 @@ static int s2mps11_clk_probe(struct platform_device *pdev)
 	}
 
 	clk_data->num = S2MPS11_CLKS_NUM;
-	of_clk_add_hw_provider(s2mps11_clks->clk_np, of_clk_hw_onecell_get,
+	ret = of_clk_add_hw_provider(s2mps11_clks->clk_np, of_clk_hw_onecell_get,
 			       clk_data);
+	if (ret < 0)
+		goto err_reg;
 
 	platform_set_drvdata(pdev, s2mps11_clks);
 
-- 
2.34.1


