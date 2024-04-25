Return-Path: <linux-kernel+bounces-158194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F5858B1CD1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 10:28:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB951B21B64
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 08:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0386978C64;
	Thu, 25 Apr 2024 08:28:20 +0000 (UTC)
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E8F53EA86;
	Thu, 25 Apr 2024 08:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714033699; cv=none; b=CrGCGxlFmv+bwzHAnJZLosAeUoJzk9d1SYPV4sn7SvJBLAYnLD5eRkln7CbV0j/zsUpaEqUocPL/bJ6DyreC7oDWQeYa6jIkR8qkiu2OfNzoLX/obe9tiLRw6Z7t/gG/I+s99Or+UeqnxDp2hqWV+Oq0GJuomH9kCKke6bK7hu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714033699; c=relaxed/simple;
	bh=bjj4W06ZrZrg6lhW2BBj9PMprnn35s2f3gB+hiw2rYk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pvTQcQQCxlnw2iSQ8HsE0D7h6oKzZG3X3cHxfFbn4T6q0DPWW+6r6i4F6MybfIKVBBgxvqecEF5hO9iAVioiW/gAux25HlFCXN3qw0Tnzm1b2LRmz20ud4nkHFe8GAQXXgvfPsk9p87dm62FT9F9nhbk4kKnwBpmGXPZaMpzoIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost (unknown [124.16.138.129])
	by APP-01 (Coremail) with SMTP id qwCowADX3hobFCpmk58qAA--.7266S2;
	Thu, 25 Apr 2024 16:28:11 +0800 (CST)
From: Chen Ni <nichen@iscas.ac.cn>
To: James.Bottomley@HansenPartnership.com,
	martin.petersen@oracle.com
Cc: linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chen Ni <nichen@iscas.ac.cn>
Subject: [PATCH] scsi: aha1740: use dma_mapping_error to check map errors
Date: Thu, 25 Apr 2024 16:28:03 +0800
Message-Id: <20240425082803.829150-1-nichen@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowADX3hobFCpmk58qAA--.7266S2
X-Coremail-Antispam: 1UD129KBjvdXoW7GryrJF13JF45Zr1DAw4kXrb_yoW3Zrg_ua
	y2krn7Cw4DGr12gF1UtrZ8Ar9F93y0qF4S9rs2q3ZxAayrWryDWFy0vr98CwsrZ3yUCayr
	ZwnrZryxZrnFgjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbcxFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxVWxJr
	0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc2xSY4AK67AK6r43
	MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr
	0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0E
	wIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJV
	W8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAI
	cVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUjMKZJUUUUU==
X-CM-SenderInfo: xqlfxv3q6l2u1dvotugofq/

The return value of dma_map_single() should be checked by
dma_mapping_error(). Update the check accordingly.

Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
---
 drivers/scsi/aha1740.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/aha1740.c b/drivers/scsi/aha1740.c
index 3d18945abaf7..9768be6fc919 100644
--- a/drivers/scsi/aha1740.c
+++ b/drivers/scsi/aha1740.c
@@ -598,7 +598,7 @@ static int aha1740_probe (struct device *dev)
 	host->ecb_dma_addr = dma_map_single (&edev->dev, host->ecb,
 					     sizeof (host->ecb),
 					     DMA_BIDIRECTIONAL);
-	if (!host->ecb_dma_addr) {
+	if (dma_mapping_error(&edev->dev, host->ecb_dma_addr)) {
 		printk (KERN_ERR "aha1740_probe: Couldn't map ECB, giving up\n");
 		goto err_host_put;
 	}
-- 
2.25.1


