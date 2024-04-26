Return-Path: <linux-kernel+bounces-160074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E04A98B38B7
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 15:41:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DCD7288BF8
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 13:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8239B14830A;
	Fri, 26 Apr 2024 13:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="kMhA+QR7"
Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.7])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6880D147C95;
	Fri, 26 Apr 2024 13:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714138871; cv=none; b=g+jBfQ1iydTBX/kLJsabMPmuZ/43AxUIDrZ8G9Xd5xehiV94xNuBtlGk7YfkhenENRHNr1mIl/GWuiCkyp80hDenj9Stgts97P914uIS5biAoLsLGUERrivcLdE+CN0rciVpTXiaEqYQuEF2Z+52ic2aNm6cO0T+PFyTCGI36ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714138871; c=relaxed/simple;
	bh=UXjzwyHD3xU06AXyGFYmDxIwYgvujORr2saZ8aiLHQY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QiRRV3nWMSz3QGHiq9cc0iAW3jafI5MpR4MYfVMMsolJbEBp52i824GBp8OolV9VhTjp5UEuCpF9G6P/4NUkW0+3dun7p3jQDMoat+KrcSfRnVSWvrm/ICKlYCiERcdgq6XfQHBgO8DMeGPMsiL2fobg5PnOXXCOcdQ/peJ2Nw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=kMhA+QR7; arc=none smtp.client-ip=117.135.210.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=AocrA
	75mqcRUL0QWSUoM3dEaQjCJ8gV8EQHfgGHvBrE=; b=kMhA+QR7pv2AWw5e3Q7yi
	qXUpN6oisGUAxmMLrGJZYlPua9etZBOrZpzTVLDhAwsgUUnRG1ueNKZGhLG/uMtD
	gQKwCT8VwpjRXTDiGLxQUnY7DM1jAftB/rif5mC0Kb9NtNL9Wni6nHijgc/t+Og4
	elXEy4XbmvMNUB560Q7anc=
Received: from localhost.localdomain (unknown [111.198.54.11])
	by gzga-smtp-mta-g1-5 (Coremail) with SMTP id _____wDnL5KwritmM0DuBQ--.25861S2;
	Fri, 26 Apr 2024 21:40:01 +0800 (CST)
From: lumingyindetect@126.com
To: linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: ilpo.jarvinen@linux.intel.com,
	andriy.shevchenko@linux.intel.com,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.or,
	LuMingYin <lumingyindetect@126.com>
Subject: [PATCH] serial: 8250_lpss: Fix memory leak in lpss8250_probe()
Date: Fri, 26 Apr 2024 14:39:59 +0100
Message-Id: <20240426133959.1294012-1-lumingyindetect@126.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnL5KwritmM0DuBQ--.25861S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7KryfAFW5WF1UJFW8GF4fuFg_yoW8XFWDpF
	s0kFsIkFy0q3WIga40yr4jqF15uFWxX347CrZrC3sI9rZIyF97tF1ftFy7tF10grWktFnF
	ya1UtF45Ca4UXFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07js0edUUUUU=
X-CM-SenderInfo: poxpx0hj1l0vphwhu3a6rslhhfrp/1tbiEBXM9mVLbFpVzQAAs-

From: LuMingYin <lumingyindetect@126.com>

The return statements at line 347 and line 351 in the lpss8250_probe() function result in a memory leak of the variable pdev.
Add a label named free_irq_vectors in the lpss8250_probe() function to release the memory area pointed to by pdev.
Modify the two return statements mentioned above to jump to the label "free_irq_vectors" instead.

Fixes: e88c4cfcb7b888ac374916806f86c17d8ecaeb67 ("serial: 8250_lpss: fix memory in lpss8250_probe()")

Signed-off-by: LuMingYin <lumingyindetect@126.com>
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


