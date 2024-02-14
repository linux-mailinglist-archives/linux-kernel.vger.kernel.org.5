Return-Path: <linux-kernel+bounces-64840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EA4F85438E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 08:42:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23AC81F23A21
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 07:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0797811716;
	Wed, 14 Feb 2024 07:42:42 +0000 (UTC)
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [52.237.72.81])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A7F611706;
	Wed, 14 Feb 2024 07:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.237.72.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707896561; cv=none; b=jpYPRtihctQxwlR2zyhdzX7CZLoPLEJJ+rLcop8s+OPNoJFqP9KtYtwuCXc1pKBmBCyP0i4PWI4NXkWOAAXvyYHDKRG//ZvK5M9VU3cJwywVt4jR1rYh5HsFdCGd2mqtY94n54IjnMNXAoWfDboTih7q+lIUwscqeUHXzD8LnG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707896561; c=relaxed/simple;
	bh=KsUQZovNZ1Mq26qTNCJ02kvNZqNLKyNEdqfRIzw9Mxw=;
	h=From:To:Cc:Subject:Date:Message-Id; b=MMcDNKo+vJ/jTMvr7CcyovoRXvhksncB3TkeB98J6sNtn2vim1M7IrRxvz9OD1uwJ6zwxFSStv6jqeD1ePxL6XYeqLnXYLMkcuZ0dRPPqS3iAr0QZdXZFHIh2U9X6JMGnQTWvAiVjNBeiyIrBqTw2CG2Ps2BoOUUON6A1YhU0iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=52.237.72.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from ubuntu.localdomain (unknown [218.12.18.71])
	by mail-app4 (Coremail) with SMTP id cS_KCgAXEH6_bMxl4x1EAQ--.55591S2;
	Wed, 14 Feb 2024 15:33:31 +0800 (CST)
From: Duoming Zhou <duoming@zju.edu.cn>
To: linux-kernel@vger.kernel.org
Cc: mturquette@baylibre.com,
	sboyd@kernel.org,
	michal.simek@amd.com,
	linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Duoming Zhou <duoming@zju.edu.cn>
Subject: [PATCH] clk: zynq: Prevent null pointer dereference caused by kmalloc failure
Date: Wed, 14 Feb 2024 15:33:18 +0800
Message-Id: <20240214073318.82573-1-duoming@zju.edu.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:cS_KCgAXEH6_bMxl4x1EAQ--.55591S2
X-Coremail-Antispam: 1UD129KBjvdXoWrtw1fAw17KFykXF1Utr48Crg_yoWDCwb_Gw
	48X3srC34rA3s5A3Z7AF4xuFZIvF1Fvr1vvFnaq343A34UZr1rWryI9ws3Ar4fJrWFkryD
	Cr1kKrZYyr10vjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbcAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
	Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v26r12
	6r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
	0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y
	0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
	WUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1l
	IxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjfUYCJmUUUUU
X-CM-SenderInfo: qssqjiasttq6lmxovvfxof0/1tbiAwMLAWXLulEB4QAnsI
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The kmalloc in zynq_clk_setup will return null if the
physical memory has run out. As a result, if we use
snprintf to write data to the null address, the null
pointer dereference bug will happen.

The required memory is only 11 bytes, so this patch
adds a "__GFP_NOFAIL" flag in kmalloc in order that
the kmalloc will never return with failure.

Fixes: 0ee52b157b8e ("clk: zynq: Add clock controller driver")
Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>
---
 drivers/clk/zynq/clkc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/zynq/clkc.c b/drivers/clk/zynq/clkc.c
index 7bdeaff2bfd..7621c2f0046 100644
--- a/drivers/clk/zynq/clkc.c
+++ b/drivers/clk/zynq/clkc.c
@@ -427,7 +427,7 @@ static void __init zynq_clk_setup(struct device_node *np)
 			SLCR_GEM1_CLK_CTRL, 0, 0, &gem1clk_lock);
 
 	tmp = strlen("mio_clk_00x");
-	clk_name = kmalloc(tmp, GFP_KERNEL);
+	clk_name = kmalloc(tmp, GFP_KERNEL | __GFP_NOFAIL);
 	for (i = 0; i < NUM_MIO_PINS; i++) {
 		int idx;
 
-- 
2.17.1


