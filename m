Return-Path: <linux-kernel+bounces-159673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 101668B31EE
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 10:04:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4E961F21C27
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 08:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15AD013C8F7;
	Fri, 26 Apr 2024 08:04:44 +0000 (UTC)
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 218EF13BC28;
	Fri, 26 Apr 2024 08:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714118683; cv=none; b=dnpcoxWhpr019PKfudk355BdWUI4+ujUh+oRMslpxAUu71n3cXMaX+my4GKilXoVePCfBhq8dRzX8rXDpq0Zg/mx6AQu0KK5c1xMafnEycfiLQh1GxQYCVwAW6NrM7LhIrMOimACCi6YRu/vN4+Vfoi2w3WTAuklByWM/9/uIVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714118683; c=relaxed/simple;
	bh=QGibK+MjKDWgxbYHPbA4WnjRS7tK0WgFy8+NOQMk5dU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TJEq+O2MlPvgMDddJzSke/AIaTPHld+UlunT0r6s8L/eqdKvx+c2d/NcXTwBGBqyDuh6oMQmdzh3F24tu2aWQdQmA9hReAP7vs/JWsshux56Yofp3zu3pe6WduAe+JwIUNQrtUrRO93ibkVfKk+FAJ8YBc0X4HqQmuOyWWeuyr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost (unknown [124.16.138.129])
	by APP-05 (Coremail) with SMTP id zQCowAA3HROnXitmA8hMBg--.28248S2;
	Fri, 26 Apr 2024 15:58:32 +0800 (CST)
From: Chen Ni <nichen@iscas.ac.cn>
To: wim@linux-watchdog.org,
	linux@roeck-us.net,
	arnd@arndb.de
Cc: linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chen Ni <nichen@iscas.ac.cn>
Subject: [PATCH] watchdog: sa1100: Fix PTR_ERR_OR_ZERO() vs NULL check in sa1100dog_probe()
Date: Fri, 26 Apr 2024 15:58:08 +0800
Message-Id: <20240426075808.1582678-1-nichen@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAA3HROnXitmA8hMBg--.28248S2
X-Coremail-Antispam: 1UD129KBjvdXoWruF43ZFy8ZryxJw13ZrWDJwb_yoWfWFg_Cr
	W2qF9xWrWDGr1rt3Zrtw43A3yI9FWq9F1xuw4vq39xJ347Gr9xurW7ZrykXayDuay09F98
	Jr1DZr4I9r13GjkaLaAFLSUrUUUU8b8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbc8FF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxVWxJr
	0_GcWln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE
	6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72
	CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7
	MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr
	0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0E
	wIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJV
	W8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAI
	cVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjfUnCJmUUUUU
X-CM-SenderInfo: xqlfxv3q6l2u1dvotugofq/

devm_ioremap() doesn't return error pointers, it returns NULL on error.
Update the check accordingly.

Fixes: e86bd43bcfc5 ("watchdog: sa1100: use platform device registration")
Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
---
 drivers/watchdog/sa1100_wdt.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/watchdog/sa1100_wdt.c b/drivers/watchdog/sa1100_wdt.c
index 5d2df008b92a..34a917221e31 100644
--- a/drivers/watchdog/sa1100_wdt.c
+++ b/drivers/watchdog/sa1100_wdt.c
@@ -191,9 +191,8 @@ static int sa1100dog_probe(struct platform_device *pdev)
 	if (!res)
 		return -ENXIO;
 	reg_base = devm_ioremap(&pdev->dev, res->start, resource_size(res));
-	ret = PTR_ERR_OR_ZERO(reg_base);
-	if (ret)
-		return ret;
+	if (!reg_base)
+		return -ENOMEM;
 
 	clk = clk_get(NULL, "OSTIMER0");
 	if (IS_ERR(clk)) {
-- 
2.25.1


