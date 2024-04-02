Return-Path: <linux-kernel+bounces-127887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3010A895242
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 13:59:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 505501C21F1B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 11:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E23B6997A;
	Tue,  2 Apr 2024 11:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nppct.ru header.i=@nppct.ru header.b="Ox6G3NuS"
Received: from mail.nppct.ru (mail.nppct.ru [195.133.245.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C435A4C7
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 11:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.133.245.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712059182; cv=none; b=rmUGbyTC7LvSEJo1rBF0YIMK2kX0xzTKE6BbMLfnqDXU9dw+tbNX0AKOnBNl6Hdp/NHNrdpeuanxBNi1LEcWrs0i44doqcSr/bHcAIOqyOQO1pRZs90dVC3q9KlgproVkyxksH0ryUultA9A8a5M1F/5PTmf+NIkyObA0vERw6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712059182; c=relaxed/simple;
	bh=dzFzoRjMBaoyQUng2Yecgold2it77CXBKBHEAhjFIc4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rNHNrzSiaox8u278NfgLCO4kI+1aG/uaF8d8aeLYZbOwVvEp9jZ23oafO19oaYgDPRMdDi8YQeM4psSMv8u5+O8vVuORhb1fnNNtvg7b8iKoM32UJylm/D1wnxcejwYdEwITcAQD9A3QbevAtMj87O1DZbHUPKACiKh9IlMlaN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nppct.ru; spf=pass smtp.mailfrom=nppct.ru; dkim=pass (1024-bit key) header.d=nppct.ru header.i=@nppct.ru header.b=Ox6G3NuS; arc=none smtp.client-ip=195.133.245.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nppct.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nppct.ru
Received: from mail.nppct.ru (localhost [127.0.0.1])
	by mail.nppct.ru (Postfix) with ESMTP id 4D5E31C1E16
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 14:52:12 +0300 (MSK)
Authentication-Results: mail.nppct.ru (amavisd-new); dkim=pass (1024-bit key)
	reason="pass (just generated, assumed good)" header.d=nppct.ru
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nppct.ru; h=
	content-transfer-encoding:mime-version:x-mailer:message-id:date
	:date:subject:subject:to:from:from; s=dkim; t=1712058731; x=
	1712922732; bh=dzFzoRjMBaoyQUng2Yecgold2it77CXBKBHEAhjFIc4=; b=O
	x6G3NuSRVjzEFWjk6vnt5xQ0Ut6hQaJd8qZ/5Eh0a09l8xYpr1IgsafoMoUnMuOh
	PC7Dh7cWHxq5FpqkKFwQXFJuorS13vU7LIvwNljFeGjpghpTpLhLwyGv0sZI6B52
	MCtJCTn7tR1jtMUyEW1Vtsa2AKjstHJakGty9ipLE0=
X-Virus-Scanned: Debian amavisd-new at mail.nppct.ru
Received: from mail.nppct.ru ([127.0.0.1])
	by mail.nppct.ru (mail.nppct.ru [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id HSN-IraGDnoU for <linux-kernel@vger.kernel.org>;
	Tue,  2 Apr 2024 14:52:11 +0300 (MSK)
Received: from localhost.localdomain (mail.dev-ai-melanoma.ru [185.130.227.204])
	by mail.nppct.ru (Postfix) with ESMTPSA id 5C07C1C1D18;
	Tue,  2 Apr 2024 14:52:04 +0300 (MSK)
From: Andrey Shumilin <shum.sdl@nppct.ru>
To: Juergen Gross <jgross@suse.com>
Cc: Andrey Shumilin <shum.sdl@nppct.ru>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	khoroshilov@ispras.ru,
	ykarpov@ispras.ru,
	vmerzlyakov@ispras.ru,
	vefanov@ispras.ru
Subject: [PATCH 4/4] gntdev: Unchecked finction result
Date: Tue,  2 Apr 2024 14:51:57 +0300
Message-Id: <20240402115157.672915-1-shum.sdl@nppct.ru>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The dma_coerce_mask_and_coherent function may refuse
to apply a mask due to incorrectly passed parameters.
But since this function returns the error -EIO, this
is an abnormal situation and the error must be written to the log.
Do not return an error from the function.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Signed-off-by: Andrey Shumilin <shum.sdl@nppct.ru>

---
 drivers/xen/gntdev.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/xen/gntdev.c b/drivers/xen/gntdev.c
index 61faea1f0663..8a448dbbca86 100644
--- a/drivers/xen/gntdev.c
+++ b/drivers/xen/gntdev.c
@@ -597,7 +597,8 @@ static int gntdev_open(struct inode *inode, struct file *flip)
 	flip->private_data = priv;
 #ifdef CONFIG_XEN_GRANT_DMA_ALLOC
 	priv->dma_dev = gntdev_miscdev.this_device;
-	dma_coerce_mask_and_coherent(priv->dma_dev, DMA_BIT_MASK(64));
+	if (dma_coerce_mask_and_coherent(priv->dma_dev, DMA_BIT_MASK(64)) == -EIO)
+		pr_err("The mask was applied unsuccessfully");
 #endif
 	pr_debug("priv %p\n", priv);
 
-- 
2.30.2


