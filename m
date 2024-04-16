Return-Path: <linux-kernel+bounces-146458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FA018A659E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 10:03:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C46D01F21A5E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 08:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C7A512837B;
	Tue, 16 Apr 2024 08:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="MyBil7y6"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5545C75808
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 08:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713254629; cv=none; b=sfNVDRENuiImbddWep0i2f8caHDyZ8AZwAeqv6ScNWz+8KPaDuKNap7khQ35iytEGbSmbCIArAHzExsTlEkeP6L2xQpuLVrt5l5Zk8m4uvvUPoPzLcQsC+nH1r1SPTIviBU54sPCOEm/5fxEvgY1Hx+Mg4SBc68YEkYYDE2Ez4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713254629; c=relaxed/simple;
	bh=kYNTupiv3TQw3fNvik9CrYQof7/tZvkNuRS5rjJflOw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=a7NPk4gcR5x/jDemordxmlvrxKIw2ElCz7b/5SjmlPu2F7Hx3lN4tWXQR3Dd0DosCit0IeIs1lGOd5FUMUArDudhTD6iFml+jDw3K7LcdHIdXYxnE6gX8Y6u0Ze5X+GdUkO3Ch5mNhSOaSNMPqHMY5LaUbjQrts586WE6Mf931k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=MyBil7y6; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=YtBq8
	yEZv097YxmGZO1uAqajLtUZ0qspENxuvlWUMkc=; b=MyBil7y69RfEJOQK3poij
	wtEPInopyvPyO8Boov1c831gSKz9YmwGkmmBpShXwENKg5C/31BczWlB9lGnGelL
	Go7awvruOkWKqw7AmI++8bGNQmJinP2BuR2lqRosiUEc+xTiySsbG1kyaRoHjpLA
	X7lkaGZXEo/jKAu1IoHPl4=
Received: from flipped.. (unknown [159.226.94.118])
	by gzga-smtp-mta-g2-3 (Coremail) with SMTP id _____wD3Xx_DMB5m5JBDBQ--.33062S2;
	Tue, 16 Apr 2024 16:03:16 +0800 (CST)
From: Sicong Huang <congei42@163.com>
To: gregkh@linuxfoundation.org,
	johan@kernel.org,
	elder@kernel.org
Cc: greybus-dev@lists.linaro.org,
	linux-kernel@vger.kernel.org,
	Sicong Huang <congei42@163.com>
Subject: [PATCH v1] greybus: Fix use-after-free bug in gb_interface_release due to race condition.
Date: Tue, 16 Apr 2024 16:03:13 +0800
Message-Id: <20240416080313.92306-1-congei42@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3Xx_DMB5m5JBDBQ--.33062S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJr1rtFWDuw1UXFy3WFWxZwb_yoW8GFW3pr
	WrGrWUGw4DJFs8tws8KF1UXFZYgw17KryakFWxCw4xGr98Ary3Zrn0yFZrAFZ3Cw1rJr17
	Zr4UZ3sYvas8X3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07Ul-erUUUUU=
X-CM-SenderInfo: 5frqwvrlusqiywtou0bp/1tbivgbC8mV4Ir559gAAsG

In gb_interface_create, &intf->mode_switch_completion is bound with
gb_interface_mode_switch_work. Then it will be started by
gb_interface_request_mode_switch. Here is the relevant code.
if (!queue_work(system_long_wq, &intf->mode_switch_work)) {
	...
}

If we call gb_interface_release to make cleanup, there may be an
unfinished work. This function will call kfree to free the object
"intf". However, if gb_interface_mode_switch_work is scheduled to
run after kfree, it may cause use-after-free error as
gb_interface_mode_switch_work will use the object "intf".
The possible execution flow that may lead to the issue is as follows:

CPU0                            CPU1

                            |   gb_interface_create
                            |   gb_interface_request_mode_switch
gb_interface_release        |
kfree(intf) (free)          |
                            |   gb_interface_mode_switch_work
                            |   mutex_lock(&intf->mutex) (use)

Fix it by canceling the work before kfree.

Signed-off-by: Sicong Huang <congei42@163.com>
---
 drivers/greybus/interface.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/greybus/interface.c b/drivers/greybus/interface.c
index fd58a86b0888..d022bfb5e95d 100644
--- a/drivers/greybus/interface.c
+++ b/drivers/greybus/interface.c
@@ -693,6 +693,7 @@ static void gb_interface_release(struct device *dev)
 
 	trace_gb_interface_release(intf);
 
+	cancel_work_sync(&intf->mode_switch_work);
 	kfree(intf);
 }
 
-- 
2.34.1


