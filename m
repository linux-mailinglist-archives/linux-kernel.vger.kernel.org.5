Return-Path: <linux-kernel+bounces-159891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57ACB8B3580
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 12:46:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15D4C2840BA
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 10:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01C74143C6C;
	Fri, 26 Apr 2024 10:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="L4xE3tMB"
Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.8])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F17D14430A;
	Fri, 26 Apr 2024 10:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714128368; cv=none; b=uTFKtydSRfdvLGBvk2b/Xc/jWCmX7Ftf8iaArA7Ixtr4rMaLmHx4R1ZYUUht4u0svYRfAewmG10zE7DA3A4p7YhJRthUoOM1KJfiiET2ez3kUhr9+5KzsiiQtu3ozM5K0S0xvP5QWyEKKOiOIT9kEzTrWkXhL7/gIcf2w1U49Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714128368; c=relaxed/simple;
	bh=1Pxy5wY6hXj0Y3hhL63SvhatbJuxuuTHhotJyXcqVgk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Nxo/D3ktj8sXGyMo8JtRuXesgInFZaDqmTjaR1BtsBjMjuEhZtm/6wJPu0cpktzI0t1dzr68e1OBbzv7kh5E2Mlcslm7S3de107x/nGFFqfa6i5vNKixvvfDF0UDEfGHLP9c1bUIsifCzlHnnyaruZjbfyJZ1W0ke5Zrtva4e0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=L4xE3tMB; arc=none smtp.client-ip=220.197.31.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=JYyZF
	llG1UFCRZ2iFF/rENG29SUZzw0/ZtGvA7R1+0A=; b=L4xE3tMBjiiMw5Yuv+mvv
	E3hImT9kngJA1jt9O3Em6nSlGwzOUHoxZxI2iRucdjU44nIxSKlA9vYEaRFvZrwY
	ZW+A3Zs13us20wbJllFVE0xZ5WZEj6fT0egz8djEtXOZ3N86ZAPJPT6PfUpk+E3O
	P3eg91OOCjYbhWPFhXvDC0=
Received: from localhost.localdomain (unknown [111.198.54.11])
	by gzga-smtp-mta-g0-5 (Coremail) with SMTP id _____wD3H0rRhStmSuqdAw--.3265S2;
	Fri, 26 Apr 2024 18:45:38 +0800 (CST)
From: lumingyindetect@126.com
To: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: ilpo.jarvinen@linux.intel.com,
	andriy.shevchenko@linux.intel.com,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	LuMingYin <11570291+yin-luming@user.noreply.gitee.com>
Subject: [PATCH] Fix a memory leak in the function lpss8250_probe
Date: Fri, 26 Apr 2024 11:45:35 +0100
Message-Id: <20240426104535.1238368-1-lumingyindetect@126.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3H0rRhStmSuqdAw--.3265S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7AF1rKry8Cr48XrWfur4rKrg_yoW8Wr4UpF
	sIkF90kFyvqa4xWa4jyr4jqr1Fva97Za47GrZrKwnIkrZIkF9IyFyFya4ftF18ZrZ5tF9F
	va1UAF4UAa4UtaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07bbJ5rUUUUU=
X-CM-SenderInfo: poxpx0hj1l0vphwhu3a6rslhhfrp/1tbi6BXM9mVLbDyv5QAAsz

From: LuMingYin <11570291+yin-luming@user.noreply.gitee.com>

In the lpss8250_probe function in the 8250_lpss.c file, the program may directly return at either line 347 or line 351, without jumping to the error handling label to release the dynamically allocated memory region pointed to by the variable pdev, as done at line 357 or line 361. This fix introduces a new label named free_irq_vectors to release the dynamically allocated memory region pointed to by pdev, thereby fixing the memory leak defect.

Signed-off-by: LuMingYin <11570291+yin-luming@user.noreply.gitee.com>
---
 drivers/tty/serial/8250/8250_lpss.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_lpss.c b/drivers/tty/serial/8250/8250_lpss.c
index c3cd6cb9ac80..fa9fd4dc86c7 100644
--- a/drivers/tty/serial/8250/8250_lpss.c
+++ b/drivers/tty/serial/8250/8250_lpss.c
@@ -344,11 +344,11 @@ static int lpss8250_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	uart.port.mapbase = pci_resource_start(pdev, 0);
 	uart.port.membase = pcim_iomap(pdev, 0, 0);
 	if (!uart.port.membase)
-		return -ENOMEM;
+		goto free_irq_vectors;
 
 	ret = lpss->board->setup(lpss, &uart.port);
 	if (ret)
-		return ret;
+		goto free_irq_vectors;
 
 	dw8250_setup_port(&uart.port);
 
@@ -367,6 +367,7 @@ static int lpss8250_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 err_exit:
 	lpss->board->exit(lpss);
+free_irq_vectors:
 	pci_free_irq_vectors(pdev);
 	return ret;
 }
-- 
2.25.1


