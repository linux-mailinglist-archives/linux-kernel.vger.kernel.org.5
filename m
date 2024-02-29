Return-Path: <linux-kernel+bounces-86695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9536686C91F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 13:23:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6AB11C22C41
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 12:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CBE27D06B;
	Thu, 29 Feb 2024 12:23:24 +0000 (UTC)
Received: from zg8tmtu5ljg5lje1ms4xmtka.icoremail.net (zg8tmtu5ljg5lje1ms4xmtka.icoremail.net [159.89.151.119])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95ADF1FA3;
	Thu, 29 Feb 2024 12:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.89.151.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709209403; cv=none; b=g1INh+KN79+oRDQEAOTuFvypDU3bKSuVX+Kxvt94Kaj5FiL2H7erJ8fzhoQ33kNZUUzNYwF/bNeItSdyB6SfoAm+Zwapds5U0QBIE2AAO9ml7i4zbnEKma/t3XEx+1SMchK1DkhZKa6z180azGKR56zWH99i98i8AcICS7jqrCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709209403; c=relaxed/simple;
	bh=9bw/tOBzuEyt2UgNj6zGFgbsv+CXBbuZyMtRZjhVKOo=;
	h=From:To:Cc:Subject:Date:Message-Id; b=CfIY7rytnW+w7SQdcswZG4d0CsZseydDTv720BjceV11cZPOmeh8bmZE3KnjiqUJAmCobRR7MU70CVftpEaciC0jNFaclixxzXhDz1PmdgLgSHlxHpqA8vfz5bRrj+mxByR5whTT3uYWYbUDx0Qne26ametgesSwX73fE7Y+dBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=159.89.151.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from ubuntu.localdomain (unknown [218.12.19.137])
	by mail-app2 (Coremail) with SMTP id by_KCgB3uKcbd+BlOY1oAg--.37484S2;
	Thu, 29 Feb 2024 20:23:00 +0800 (CST)
From: Duoming Zhou <duoming@zju.edu.cn>
To: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-clk@vger.kernel.org,
	michal.simek@amd.com,
	sboyd@kernel.org,
	mturquette@baylibre.com,
	Duoming Zhou <duoming@zju.edu.cn>
Subject: [PATCH v2] clk: zynq: Prevent null pointer dereference caused by kmalloc failure
Date: Thu, 29 Feb 2024 20:22:50 +0800
Message-Id: <20240229122250.24786-1-duoming@zju.edu.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:by_KCgB3uKcbd+BlOY1oAg--.37484S2
X-Coremail-Antispam: 1UD129KBjvJXoWrtw1fCr1xCFW3XF1fKFy3urg_yoW8JF1xpF
	WxWrn0yF4DWr4qgFZrCFyxZrWS9ay7Wa42g34Iq34vvrn8JFWUWFW5CF95ZF18XrWfWFW3
	tF4Utr48W3WUC3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkC14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_
	JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIY
	rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14
	v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8
	JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUr2-eDU
	UUU
X-CM-SenderInfo: qssqjiasttq6lmxovvfxof0/1tbiAwIGAWXfgNMODgAmsJ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The kmalloc() in zynq_clk_setup() will return null if the
physical memory has run out. As a result, if we use snprintf
to write data to the null address, the null pointer dereference
bug will happen.

This patch adds a stack variable to replace the kmalloc().

Fixes: 0ee52b157b8e ("clk: zynq: Add clock controller driver")
Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>
---
Changes in v2:
  - Use stack variable to replace kmalloc().

 drivers/clk/zynq/clkc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/clk/zynq/clkc.c b/drivers/clk/zynq/clkc.c
index 7bdeaff2bfd..e4c4c9adf79 100644
--- a/drivers/clk/zynq/clkc.c
+++ b/drivers/clk/zynq/clkc.c
@@ -427,7 +427,7 @@ static void __init zynq_clk_setup(struct device_node *np)
 			SLCR_GEM1_CLK_CTRL, 0, 0, &gem1clk_lock);
 
 	tmp = strlen("mio_clk_00x");
-	clk_name = kmalloc(tmp, GFP_KERNEL);
+	char clk_name[tmp];
 	for (i = 0; i < NUM_MIO_PINS; i++) {
 		int idx;
 
@@ -439,7 +439,6 @@ static void __init zynq_clk_setup(struct device_node *np)
 		else
 			can_mio_mux_parents[i] = dummy_nm;
 	}
-	kfree(clk_name);
 	clk_register_mux(NULL, "can_mux", periph_parents, 4,
 			CLK_SET_RATE_NO_REPARENT, SLCR_CAN_CLK_CTRL, 4, 2, 0,
 			&canclk_lock);
-- 
2.17.1


