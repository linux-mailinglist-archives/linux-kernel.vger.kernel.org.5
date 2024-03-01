Return-Path: <linux-kernel+bounces-87986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 184CD86DBD3
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 08:04:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C671C281E05
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 07:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE4836931D;
	Fri,  1 Mar 2024 07:04:02 +0000 (UTC)
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [207.46.229.174])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D88067E78;
	Fri,  1 Mar 2024 07:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.46.229.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709276642; cv=none; b=cdeYmxyk8hA3YFCjei3vB07kcVHSSFIO6YXK7WOJImLexl9Xn1t/vjl3A7tSFuVkqopwC/t25OqiBrlC3d+Ngl+UVpmmXYNAmRC454wUAlkad+tcCK3kcUtV+XzZvUN760k9Emr4kpf27/44tN7nVkflt39ixfycpYH9RxfS2Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709276642; c=relaxed/simple;
	bh=n4GO0amLc6bIw/DDn5v7/jZicN+G4AVEDo5PV4Bf5ek=;
	h=From:To:Cc:Subject:Date:Message-Id; b=d1JI/pDCa/UG1eHE77g0Vhoujg78VXfY/89dgQ/gHyAx5ZdhNNmRiQFE7vVTmifPzj6iiUoOeyzQcIZJbeEvGGgtYyKNt7xG/AOU5yejzuCb7NZdsjRYBDOSeZJZ0aUFmhnNYGfJNypfbLrRDXAoAodrgKlo76Ofw/UG83DzBF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=207.46.229.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from ubuntu.localdomain (unknown [106.117.76.127])
	by mail-app3 (Coremail) with SMTP id cC_KCgCHazXIfeFl6wq8AQ--.9024S2;
	Fri, 01 Mar 2024 15:03:46 +0800 (CST)
From: Duoming Zhou <duoming@zju.edu.cn>
To: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-clk@vger.kernel.org,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	michal.simek@amd.com,
	Duoming Zhou <duoming@zju.edu.cn>
Subject: [PATCH v3] clk: zynq: Prevent null pointer dereference caused by kmalloc failure
Date: Fri,  1 Mar 2024 15:03:36 +0800
Message-Id: <20240301070336.13700-1-duoming@zju.edu.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:cC_KCgCHazXIfeFl6wq8AQ--.9024S2
X-Coremail-Antispam: 1UD129KBjvJXoW7urW7Jr43AF4Uuw48Wr43Awb_yoW8Aw4kpF
	WxWwn0yF4UXrWqgFn2kF18ZrySya17Wa42kw1rt3s7Z3Z8JFyUJFW5CF95Z3W8XrW8XFWa
	vF4qkr48W3WUAF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkl14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4U
	JVW0owA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWU
	AVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
	v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkG
	c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4U
	MIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7VUbSfO7UUUU
	U==
X-CM-SenderInfo: qssqjiasttq6lmxovvfxof0/1tbiAwQHAWXg0lMJ0AANsR
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The kmalloc() in zynq_clk_setup() will return null if the
physical memory has run out. As a result, if we use snprintf()
to write data to the null address, the null pointer dereference
bug will happen.

This patch uses a stack variable to replace the kmalloc().

Fixes: 0ee52b157b8e ("clk: zynq: Add clock controller driver")
Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>
---
Changes in v3:
  - Put stack variable in the head of the function and remove variable tmp.

 drivers/clk/zynq/clkc.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/zynq/clkc.c b/drivers/clk/zynq/clkc.c
index 7bdeaff2bfd..45479653c3b 100644
--- a/drivers/clk/zynq/clkc.c
+++ b/drivers/clk/zynq/clkc.c
@@ -215,7 +215,7 @@ static void __init zynq_clk_setup(struct device_node *np)
 	int i;
 	u32 tmp;
 	int ret;
-	char *clk_name;
+	char clk_name[16];
 	unsigned int fclk_enable = 0;
 	const char *clk_output_name[clk_max];
 	const char *cpu_parents[4];
@@ -426,12 +426,10 @@ static void __init zynq_clk_setup(struct device_node *np)
 			"gem1_emio_mux", CLK_SET_RATE_PARENT,
 			SLCR_GEM1_CLK_CTRL, 0, 0, &gem1clk_lock);
 
-	tmp = strlen("mio_clk_00x");
-	clk_name = kmalloc(tmp, GFP_KERNEL);
 	for (i = 0; i < NUM_MIO_PINS; i++) {
 		int idx;
 
-		snprintf(clk_name, tmp, "mio_clk_%2.2d", i);
+		snprintf(clk_name, 16, "mio_clk_%2.2d", i);
 		idx = of_property_match_string(np, "clock-names", clk_name);
 		if (idx >= 0)
 			can_mio_mux_parents[i] = of_clk_get_parent_name(np,
@@ -439,7 +437,6 @@ static void __init zynq_clk_setup(struct device_node *np)
 		else
 			can_mio_mux_parents[i] = dummy_nm;
 	}
-	kfree(clk_name);
 	clk_register_mux(NULL, "can_mux", periph_parents, 4,
 			CLK_SET_RATE_NO_REPARENT, SLCR_CAN_CLK_CTRL, 4, 2, 0,
 			&canclk_lock);
-- 
2.17.1


