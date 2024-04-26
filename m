Return-Path: <linux-kernel+bounces-159440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 736DD8B2EA8
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 04:22:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 134011F22115
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 02:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CF74187F;
	Fri, 26 Apr 2024 02:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="G6kmxnNS"
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.6])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8D1BB642;
	Fri, 26 Apr 2024 02:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714098125; cv=none; b=IfYUMZ1ET1LtsS8dgdDtvoCLdDFTNhdcV1kN4Mj/di6jdDrNeZ47A9Mp/XBJH4ZrFPcEJ+EObgEfNIcZT5+XMG394GBN+cumcJs1Y/GzhLu2T0EjED+4piI9hcoGUwU+MR/qijZn8zp0IUKfzddc5r9/d9NGYR+S7vH0UFWjOyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714098125; c=relaxed/simple;
	bh=XXS/DqzOUd2pZXmZfdeWQlXnvZ4h6TO847RjqihLfV0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PWgQDs/FXQUClgAnkGOdbcyOgSlw7MPWNnMHNhHuEBN05wUEFbCGRhaN7eplx/sq7xD9y05udJ3dGXdUWSiERsUekIqKRvWB/6dXGi0ZYAreFD6rlMAtv2x8unZMTojQ2Hq4CMClsXMzYME4CaY1uf4X0gApXoK4ggnkd2uCvyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=G6kmxnNS; arc=none smtp.client-ip=220.197.31.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=W+llE
	iqHYcicbi/eAfa58Zpn06ur3WDHgrUuuzURwcs=; b=G6kmxnNScC5OKeEvYCRxJ
	6RtO1bCZAee5jvKaXiQDcM2Zy7mfmOyWlNgvH57ND3Cb5rFX9nqvMgc64ONgt1Gp
	vkzjz1UiJqsDhCJkGnsMXu+9I9wv0flIET2qVR3xehB/taVR21vYs2LC9rkoXK2I
	e6PbPGXU5e06tDyyU6lHlY=
Received: from localhost.localdomain (unknown [111.198.54.11])
	by gzga-smtp-mta-g0-1 (Coremail) with SMTP id _____wDnL+I9DytmkXXvAQ--.21672S2;
	Fri, 26 Apr 2024 10:19:47 +0800 (CST)
From: lumingyindetect@126.com
To: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: ilpo.jarvinen@linux.intel.com,
	andriy.shevchenko@linux.intel.com,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	LuMingYin <11570291+yin-luming@user.noreply.gitee.com>
Subject: [PATCH] "drivers:Fixed memory leak in /linux/drivers/tty/serial/8250/8250_lpss.c file.
Date: Fri, 26 Apr 2024 03:19:39 +0100
Message-Id: <20240426021939.1083521-1-lumingyindetect@126.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnL+I9DytmkXXvAQ--.21672S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7CFWDKF4xXFW5WF4kArykGrg_yoW8GF4UpF
	sxtFsIyFyYqa4Ig3Wjyr4qqF1Y9FZ2ya47WrZrGwnI9rZIyF93tF4rtFySyF1UXrWktF9F
	yF48Ca1jya4UJFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jK-erUUUUU=
X-CM-SenderInfo: poxpx0hj1l0vphwhu3a6rslhhfrp/1tbiEATM9mVLbE9NvgAAsQ

From: LuMingYin <11570291+yin-luming@user.noreply.gitee.com>

In the lpss8250_probe function in the file /linux/drivers/tty/serial/8250/8250_lpss.c, there were certain return paths where pci_free_irq_vectors was not called to release memory related to pdev, leading to a memory leak. This commit fixes that issue."

Signed-off-by: LuMingYin <11570291+yin-luming@user.noreply.gitee.com>
---
 drivers/tty/serial/8250/8250_lpss.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_lpss.c b/drivers/tty/serial/8250/8250_lpss.c
index 776ec1ef29d6..2bb86f9cad5b 100644
--- a/drivers/tty/serial/8250/8250_lpss.c
+++ b/drivers/tty/serial/8250/8250_lpss.c
@@ -344,11 +344,11 @@ static int lpss8250_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	uart.port.mapbase = pci_resource_start(pdev, 0);
 	uart.port.membase = pcim_iomap(pdev, 0, 0);
 	if (!uart.port.membase)
-		return -ENOMEM;
+		goto early_err_exit;
 
 	ret = lpss->board->setup(lpss, &uart.port);
 	if (ret)
-		return ret;
+		goto early_err_exit;
 
 	dw8250_setup_port(&uart.port);
 
@@ -367,6 +367,7 @@ static int lpss8250_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 err_exit:
 	lpss->board->exit(lpss);
+early_err_exit:
 	pci_free_irq_vectors(pdev);
 	return ret;
 }
-- 
2.25.1


