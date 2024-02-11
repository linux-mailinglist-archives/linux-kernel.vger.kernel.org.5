Return-Path: <linux-kernel+bounces-60827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 025068509F2
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 16:11:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 343D01C20F07
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 15:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D96B95B699;
	Sun, 11 Feb 2024 15:10:10 +0000 (UTC)
Received: from mail-out.aladdin-rd.ru (mail-out.aladdin-rd.ru [91.199.251.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF0D5B676
	for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 15:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.199.251.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707664210; cv=none; b=dZ9DLCmYghgY5T2FKpkuUt9Ytfe8s43tAeqfIW3v45EgmjaKENUFU1eXBLc8V68yH6jbQZ9KOdMS//JX6cx/vf5vdV1ibsXO6mIdkgOawGG0xH7k95BqtYoIs1Y8ZNN31c+ZHoobIzvi8UPCoOCinUGs8XLDwvOnmnrrxZlVePQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707664210; c=relaxed/simple;
	bh=CFda6FtgqFCoYpvumAV9E9kesldPM7xLZy26c/iaEys=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=W3VKBJBQp1WQS5y9BWPuqypqD8P3PwHdFc08UOfn+HIaOdwf3vJmrV5zBKRVUEB3WdF54KHQiRcxGd8Qu0gKTpyjL02Dq2mvHW9vgONG/DM2wJjZ9/gEtBjpOJwNzYeTs4JS1/oXcL9pod5V4dTQk2PdYlR8hwwssUU5CQiHEr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aladdin.ru; spf=pass smtp.mailfrom=aladdin.ru; arc=none smtp.client-ip=91.199.251.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aladdin.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aladdin.ru
From: Daniil Dulov <d.dulov@aladdin.ru>
To: Juergen Gross <jgross@suse.com>
CC: Daniil Dulov <d.dulov@aladdin.ru>, Boris Ostrovsky
	<boris.ostrovsky@oracle.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Stefano Stabellini <sstabellini@kernel.org>, Jeremy Fitzhardinge
	<jeremy.fitzhardinge@citrix.com>, <xen-devel@lists.xenproject.org>,
	<iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>,
	<lvc-project@linuxtesting.org>
Subject: [PATCH] swiotlb-xen: remove redundant NULL check
Date: Sun, 11 Feb 2024 07:09:58 -0800
Message-ID: <20240211150958.4112-1-d.dulov@aladdin.ru>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EXCH-2016-03.aladdin.ru (192.168.1.103) To
 EXCH-2016-01.aladdin.ru (192.168.1.101)

In this case hwdev cannot be NULL, so remove redundant NULL check.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: b097186fd29d ("swiotlb-xen: SWIOTLB library for Xen PV guest with PCI passthrough.")
Signed-off-by: Daniil Dulov <d.dulov@aladdin.ru>
---
 drivers/xen/swiotlb-xen.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
index 2b385c1b4a99..b166f6efea26 100644
--- a/drivers/xen/swiotlb-xen.c
+++ b/drivers/xen/swiotlb-xen.c
@@ -305,7 +305,7 @@ xen_swiotlb_alloc_coherent(struct device *hwdev, size_t size,
 	if (!ret)
 		return ret;
 
-	if (hwdev && hwdev->coherent_dma_mask)
+	if (hwdev->coherent_dma_mask)
 		dma_mask = hwdev->coherent_dma_mask;
 
 	/* At this point dma_handle is the dma address, next we are
-- 
2.25.1


