Return-Path: <linux-kernel+bounces-35616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31CC883941B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 17:04:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE31B28F180
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 16:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8F4E61678;
	Tue, 23 Jan 2024 16:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="WZVT7AEv"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA12361664;
	Tue, 23 Jan 2024 16:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706025860; cv=none; b=VhcfGhhSJcrNL5Ij6qFqr3FzO/0Y9vTlB7SGOBpcsOTwqToeEPrxF+X1MYG7JAhLX6eyGFOvgvWDo9Y4gqwhULbyvIxbFXGE6wKg1O5rYY4gqXvIn0AnUttRRdUtaf2ydkta4d7nYOT/6RzssB0zRZa9OKS2oU0YlW1QLJDa80M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706025860; c=relaxed/simple;
	bh=Uogn8EJB0neDLPk8nY7o5SxlO2A4FSj14WC6Jlvmndk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nSksahpit8MVFRAK9qtj68tc1CpWxmdbvnFif9aufJs+wS6HFzUz1aT839EfV3E/QhdWMw1OyNyZ64t5Yhc1ZJFzQUWQ6MgjecXNkns/ZfF4Vv7aYm90HTfFQkGPkIXJcR7bP18sfeMHs+WzAnoUDDC0ZMHWLE6vTcvuAdconjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=WZVT7AEv; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40NG47gC080012;
	Tue, 23 Jan 2024 10:04:07 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706025847;
	bh=LKn+jbEC9GkzieXZ3A0/w1WjKrCLoZAa4wM4YmPwjv4=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=WZVT7AEvvu+33Z/dOGXdfZdf/ZB56kHSnvQ+wIyTbMptc1gaJBpHLiP7zV/SRvMat
	 3Y8T7ToTAG+uMtWyrF0hD9gaj21mOuPIi7xrzY8MguCiXlX1qs+atnjlajBkjm9c9/
	 wdcNNapKz51by/LqO6j8liNDXHQCJ7ZrwjfTayoQ=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40NG47sD000509
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 23 Jan 2024 10:04:07 -0600
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 23
 Jan 2024 10:04:07 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 23 Jan 2024 10:04:07 -0600
Received: from lelvsmtp6.itg.ti.com ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40NG45hf078075;
	Tue, 23 Jan 2024 10:04:06 -0600
From: Andrew Davis <afd@ti.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Baolin Wang
	<baolin.wang@linux.alibaba.com>
CC: <linux-omap@vger.kernel.org>, <linux-remoteproc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Andrew Davis <afd@ti.com>
Subject: [PATCH 4/4] hwspinlock: omap: Use index to get hwspinlock pointer
Date: Tue, 23 Jan 2024 10:04:05 -0600
Message-ID: <20240123160405.360437-4-afd@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240123160405.360437-1-afd@ti.com>
References: <20240123160405.360437-1-afd@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

For loops with multiple initializers and increments are hard to read
and reason about, simplify this by using the looping index to index
into the hwspinlock array.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 drivers/hwspinlock/omap_hwspinlock.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/hwspinlock/omap_hwspinlock.c b/drivers/hwspinlock/omap_hwspinlock.c
index 1b0a1bea2b24a..a2555c41320d8 100644
--- a/drivers/hwspinlock/omap_hwspinlock.c
+++ b/drivers/hwspinlock/omap_hwspinlock.c
@@ -75,7 +75,6 @@ static const struct hwspinlock_ops omap_hwspinlock_ops = {
 static int omap_hwspinlock_probe(struct platform_device *pdev)
 {
 	struct hwspinlock_device *bank;
-	struct hwspinlock *hwlock;
 	void __iomem *io_base;
 	int num_locks, i, ret;
 	/* Only a single hwspinlock block device is supported */
@@ -117,8 +116,8 @@ static int omap_hwspinlock_probe(struct platform_device *pdev)
 	if (!bank)
 		return -ENOMEM;
 
-	for (i = 0, hwlock = &bank->lock[0]; i < num_locks; i++, hwlock++)
-		hwlock->priv = io_base + LOCK_BASE_OFFSET + sizeof(u32) * i;
+	for (i = 0; i < num_locks; i++)
+		bank->lock[i].priv = io_base + LOCK_BASE_OFFSET + sizeof(u32) * i;
 
 	ret = devm_hwspin_lock_register(&pdev->dev, bank, &omap_hwspinlock_ops,
 						base_id, num_locks);
-- 
2.39.2


