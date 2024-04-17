Return-Path: <linux-kernel+bounces-148175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 294878A7EB6
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 10:53:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFB171F2282F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 08:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 478F8128392;
	Wed, 17 Apr 2024 08:53:50 +0000 (UTC)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0473027701
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 08:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713344029; cv=none; b=eRYwT1z5YBIsL7gHvv2BAQaChWeu6Dd7lWUaosAn4rh3yF4SZeojcPcbeWIELOqUO3NaAxqdma2bB9nt+nz4YvS7IzB//hzKuDI1UspEwFjFt0ZmNWmHcKiYD+KcWhj0ET43rm9yFqiDQ8VtJBFhV12IylbTCexDW8YH9zMrxWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713344029; c=relaxed/simple;
	bh=Jxp5iGC+oiD4XSKrX3vbfULJ6vMyg2omC5NIy3We4vI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uYnPU9QqSMZXOEZcG7JdNDNacsP3ZQ5rXZYKO7s/1rwRRo2qm58AViFXqOaKTS8ItJaJZfnpWF34BgpP776mNzw1g948Z+1dvWweyUwAqo7LZi+3QZN0xLWGFwNZk1np5Nf2Umq39LIRuD2Kz1FrHpnE8zbcHLH/JK41VsFTsaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4VKF454m64z1RCRw
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 16:50:45 +0800 (CST)
Received: from kwepemi500008.china.huawei.com (unknown [7.221.188.139])
	by mail.maildlp.com (Postfix) with ESMTPS id 0315B18001A
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 16:53:44 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 17 Apr
 2024 16:53:43 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <tglx@linutronix.de>, <linux-kernel@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH -next] genirq: Simplify the checks for irq_set_percpu_devid_partition()
Date: Wed, 17 Apr 2024 16:53:56 +0800
Message-ID: <20240417085356.3785381-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemi500008.china.huawei.com (7.221.188.139)

Since whether desc is NULL or desc->percpu_enabled is true, it returns
-EINVAL, check them together, and assign desc->percpu_affinity
using "?:" to simplify the code.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 kernel/irq/irqdesc.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index 23120e5a46a9..6b19c72db29a 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -911,10 +911,7 @@ int irq_set_percpu_devid_partition(unsigned int irq,
 {
 	struct irq_desc *desc = irq_to_desc(irq);
 
-	if (!desc)
-		return -EINVAL;
-
-	if (desc->percpu_enabled)
+	if (!desc || desc->percpu_enabled)
 		return -EINVAL;
 
 	desc->percpu_enabled = kzalloc(sizeof(*desc->percpu_enabled), GFP_KERNEL);
@@ -922,10 +919,7 @@ int irq_set_percpu_devid_partition(unsigned int irq,
 	if (!desc->percpu_enabled)
 		return -ENOMEM;
 
-	if (affinity)
-		desc->percpu_affinity = affinity;
-	else
-		desc->percpu_affinity = cpu_possible_mask;
+	desc->percpu_affinity = affinity ? affinity : cpu_possible_mask;
 
 	irq_set_percpu_devid_flags(irq);
 	return 0;
-- 
2.34.1


