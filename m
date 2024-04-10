Return-Path: <linux-kernel+bounces-138703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75CD189F933
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 16:02:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7CEE1C27B75
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 14:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5DE516F0FC;
	Wed, 10 Apr 2024 13:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="TWwBsoQs"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1151B16E861;
	Wed, 10 Apr 2024 13:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712757595; cv=none; b=kMHTEBBymw+gRdm7iLm9yk4Nj2yA8eBPPpeEcuXaGk4W0DQ2sb3SLPHsJJnmjoukw6TsN8fxAxwMRs2Z3GipydhGHIuklDmjs1TlfcCX03NI3xZ57hZHr0Hy3f8G5Wx0gYAog+G8sEh0rfM2mhbKhyVZt7rwpJok1AgiompnXow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712757595; c=relaxed/simple;
	bh=RLHrE4+FLPei6drd0nfg5Xsf77bF5ZMVxNn5H4/rTNs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fs8Hc0Ucu3VCbo/nQDdnfumwrims7coj1o8t90We/9o87MOGFO1fJ8edpd+ww5ezP/V1mdSSGFO2+TxjtpCfZM4yfYQ9GICBBmPVgyK+KfF3NEpYj5qioRyu2qykjJfT2F2inRoqVEYLVE6BVPfYDH/3nlT99H9DZTfqdPXlK3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=TWwBsoQs; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43ADxjbn067929;
	Wed, 10 Apr 2024 08:59:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1712757585;
	bh=fzz8HZfna6Pp/NIj4g98zvFf9RVRo+dtZspHw7cVATs=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=TWwBsoQs6eyGyjsv6NQ8FrVJG1nyExjvkHEx8AlcoYAX3UpNFM6A+ZS89Wowb1gav
	 0IAL/YJE1sk4M2aEpUPcc2NtwXvR3HaYP+obOKNJiQC1lXUOs0YyGDjdbWzXGnuBcs
	 Hkrzkddb0UApyVPtbDJ1b+nt/0fscooelXElEwpo=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43ADxjsJ011488
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 10 Apr 2024 08:59:45 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 10
 Apr 2024 08:59:44 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 10 Apr 2024 08:59:44 -0500
Received: from fllvsmtp8.itg.ti.com ([10.249.42.149])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43ADxhan067183;
	Wed, 10 Apr 2024 08:59:44 -0500
From: Andrew Davis <afd@ti.com>
To: Jassi Brar <jassisinghbrar@gmail.com>, Hari Nagalla <hnagalla@ti.com>,
        Nick Saulnier <nsaulnier@ti.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
CC: <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andrew
 Davis <afd@ti.com>
Subject: [PATCH v2 03/13] mailbox: omap: Move omap_mbox_irq_t into driver
Date: Wed, 10 Apr 2024 08:59:32 -0500
Message-ID: <20240410135942.61667-4-afd@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240410135942.61667-1-afd@ti.com>
References: <20240410135942.61667-1-afd@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

This is only used internal to the driver, move it out of the
public header and into the driver file. While we are here,
this is not used as a bitwise, so drop that and make it a
simple enum type.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 drivers/mailbox/omap-mailbox.c | 5 +++++
 include/linux/omap-mailbox.h   | 4 ----
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/mailbox/omap-mailbox.c b/drivers/mailbox/omap-mailbox.c
index 8151722eef383..c083734b6954c 100644
--- a/drivers/mailbox/omap-mailbox.c
+++ b/drivers/mailbox/omap-mailbox.c
@@ -51,6 +51,11 @@
 #define MBOX_INTR_CFG_TYPE1		0
 #define MBOX_INTR_CFG_TYPE2		1
 
+typedef enum {
+	IRQ_TX = 1,
+	IRQ_RX = 2,
+} omap_mbox_irq_t;
+
 struct omap_mbox_fifo {
 	unsigned long msg;
 	unsigned long fifo_stat;
diff --git a/include/linux/omap-mailbox.h b/include/linux/omap-mailbox.h
index f8ddf8e814167..3cc5c4ed7f5a6 100644
--- a/include/linux/omap-mailbox.h
+++ b/include/linux/omap-mailbox.h
@@ -10,8 +10,4 @@ typedef uintptr_t mbox_msg_t;
 
 #define omap_mbox_message(data) (u32)(mbox_msg_t)(data)
 
-typedef int __bitwise omap_mbox_irq_t;
-#define IRQ_TX ((__force omap_mbox_irq_t) 1)
-#define IRQ_RX ((__force omap_mbox_irq_t) 2)
-
 #endif /* OMAP_MAILBOX_H */
-- 
2.39.2


