Return-Path: <linux-kernel+bounces-86755-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1826C86CA4E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 14:32:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8632288354
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 13:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7B0712A177;
	Thu, 29 Feb 2024 13:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nppct.ru header.i=@nppct.ru header.b="gAq84hzQ"
Received: from mail.nppct.ru (mail.nppct.ru [195.133.245.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 785D97E575
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 13:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.133.245.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709213511; cv=none; b=IQ5dUvdpQDHtUu5Eu/C02rIOBY/nyVqq8HaQBgaNIUEMWCLp/VhheZC0hO78/rXDDa99/imXBPJ3gY29Kv0IOVWdFEqzOfbZMBpjAnF/RfybPBhGD0v9EU2irI2HTM+SkgVGHXJkpWXjWvZ9HNubt9BuLpEQT5nABX04XS8c7bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709213511; c=relaxed/simple;
	bh=K0TTl2ZaTlnEakj4bva9CgVtiIRlTw5OCcRhupVi7a8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Sga839Ml0WR57XcP1mQSKullEnV3QSdx1kqieQjr6iHM7o1IVwNINJNp10agLyt130xPx+kIcLv87/XnRd/rKjR0MsS9f3APueBNPWBCZFw7ILpRXwjNnoirL/zXunBGGxTD/iRuuALqAIwhs69pgaVULtQFYZyO7/R1J3vUcZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nppct.ru; spf=pass smtp.mailfrom=nppct.ru; dkim=pass (1024-bit key) header.d=nppct.ru header.i=@nppct.ru header.b=gAq84hzQ; arc=none smtp.client-ip=195.133.245.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nppct.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nppct.ru
Received: from mail.nppct.ru (localhost [127.0.0.1])
	by mail.nppct.ru (Postfix) with ESMTP id 90F631C0E63
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 16:31:33 +0300 (MSK)
Authentication-Results: mail.nppct.ru (amavisd-new); dkim=pass (1024-bit key)
	reason="pass (just generated, assumed good)" header.d=nppct.ru
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nppct.ru; h=
	content-transfer-encoding:mime-version:x-mailer:message-id:date
	:date:subject:subject:to:from:from; s=dkim; t=1709213488; x=
	1710077489; bh=K0TTl2ZaTlnEakj4bva9CgVtiIRlTw5OCcRhupVi7a8=; b=g
	Aq84hzQAREDhHz4LQM8fQm/1sIB9ZS03D9rEZkt5VimEaIuc9dm6sBy+SgV/Gqfv
	ucrmRkG7CJiTj5DnRGQqerq2WecLpDrEBXUoDzQUifQry1HbRl8GbjDhfZ5tselB
	F2qqBBuRhJuK19rUeI6vDeMfwdF7lwiopX0Kn4VMLA=
X-Virus-Scanned: Debian amavisd-new at mail.nppct.ru
Received: from mail.nppct.ru ([127.0.0.1])
	by mail.nppct.ru (mail.nppct.ru [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id RYBfhFXJ6kXm for <linux-kernel@vger.kernel.org>;
	Thu, 29 Feb 2024 16:31:28 +0300 (MSK)
Received: from localhost.localdomain (mail.dev-ai-melanoma.ru [185.130.227.204])
	by mail.nppct.ru (Postfix) with ESMTPSA id D0A6B1C0E58;
	Thu, 29 Feb 2024 16:31:26 +0300 (MSK)
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
Date: Thu, 29 Feb 2024 16:31:19 +0300
Message-Id: <20240229133119.638432-1-shum.sdl@nppct.ru>
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

Signed-off-by: Andrey Shumilin <shum.sdl@nppct.ru>
Found by Linux Verification Center (linuxtesting.org) with SVACE.
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
+		printk(KERN_INFO "The mask was applied unsuccessfully");
 #endif
 	pr_debug("priv %p\n", priv);
 
-- 
2.30.2


