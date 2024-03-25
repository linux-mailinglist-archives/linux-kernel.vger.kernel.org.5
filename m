Return-Path: <linux-kernel+bounces-117572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E196188ACB9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:59:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91F9B306C8A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3449286277;
	Mon, 25 Mar 2024 17:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="iCV8Ufgs"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9325675F;
	Mon, 25 Mar 2024 17:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711387254; cv=none; b=IAGuiRITZI3ypmL0+I7MyhtYolVq/ETdVB0+kryxxjacD5XJdNeIjXvUBusFYT+y23pageGddS7/Yrfe25YHznpr36V5otB1gS1KHQKNcKydWtHh+qCNCd6LLCUqzMlFIpkdAS5k88MU9CZYYUg2R52YBHPWDrzucEPRJVv8DPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711387254; c=relaxed/simple;
	bh=RLHrE4+FLPei6drd0nfg5Xsf77bF5ZMVxNn5H4/rTNs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jt1YK7DyLZz4MW91ANroLBR5D8KDG2n/fJD+sn7dFZ1gQN6CcZl9l0CR42jj5JSNY8uMCdWzObCO84wFTQYcugkt2M4rzEQrhLqhridH6VD9F7ZopebpV4pPmUrGAY0i1sxxbUBs9wqZr4QIz9xySgjDlJH8X0nXjsLwqYiMxik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=iCV8Ufgs; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 42PHKm64061072;
	Mon, 25 Mar 2024 12:20:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1711387248;
	bh=fzz8HZfna6Pp/NIj4g98zvFf9RVRo+dtZspHw7cVATs=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=iCV8Ufgs1QUH6WIb1B5DRNuzkNmyXAKqEHChPIUQTtBSupAnvJAGhE3R6s3bqLePM
	 FSe2yOk+I2B2EWRzb03RJmTjwRNZvMd7vX8qSjnBaURrMv02XPgeDgdLMbl2c9DGNv
	 7j+V+u81W3BCjkM8GzJR9i/wAN+ihsIoHKBOnklE=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 42PHKmWC008615
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 25 Mar 2024 12:20:48 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 25
 Mar 2024 12:20:47 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 25 Mar 2024 12:20:47 -0500
Received: from lelvsmtp5.itg.ti.com ([10.249.42.149])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 42PHKkYZ075282;
	Mon, 25 Mar 2024 12:20:47 -0500
From: Andrew Davis <afd@ti.com>
To: Jassi Brar <jassisinghbrar@gmail.com>, Hari Nagalla <hnagalla@ti.com>,
        Nick Saulnier <nsaulnier@ti.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
CC: <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andrew
 Davis <afd@ti.com>
Subject: [PATCH 03/13] mailbox: omap: Move omap_mbox_irq_t into driver
Date: Mon, 25 Mar 2024 12:20:35 -0500
Message-ID: <20240325172045.113047-4-afd@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240325172045.113047-1-afd@ti.com>
References: <20240325172045.113047-1-afd@ti.com>
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


