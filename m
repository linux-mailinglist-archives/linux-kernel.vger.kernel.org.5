Return-Path: <linux-kernel+bounces-80103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F3E8862AC8
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 15:31:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 045BEB20FEA
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 14:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A165213AC5;
	Sun, 25 Feb 2024 14:31:49 +0000 (UTC)
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [207.46.229.174])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8D7979D3
	for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 14:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.46.229.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708871509; cv=none; b=rzMJnt/Y4lixqXRkJPxoLnCydcKCh2g151f5MrZeyExEEYmVvVx+4S9ue2Zu2+DQ1Yd9jxRl3Hv63Z2HMNvrkXEvGjqs02rAFu5YcVqB3W4Ejse9I8g9e1JLi2FOkqMYjQ2F+1XcCh4ONuITjQCb3wPhcWYgHtTu8KuUyfKiJJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708871509; c=relaxed/simple;
	bh=yPhSNzLIccL3qeNSURpP50RfcSx7VjbT9FP7a/TTtGg=;
	h=From:To:Cc:Subject:Date:Message-Id; b=g2ATB/fkep1C4jTN5zVcJbEFx762T6Sv84f2ruSDs4Vg5dY/sq3a0U/QBRf8Q8Gnd2bVojSg8ZkYO7JJ8IXhbfNxXCeeNp/TwZE7nF2FHqi75RsQ7WP3x5nOsz8LK0ROWNgGIyCaOqQcqTq7Z+y3+AyrDCl8/O46Mi6zRL89JvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=207.46.229.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from ubuntu.localdomain (unknown [218.12.16.226])
	by mail-app3 (Coremail) with SMTP id cC_KCgAHDjk7T9tlSgGRAQ--.63064S2;
	Sun, 25 Feb 2024 22:31:33 +0800 (CST)
From: Duoming Zhou <duoming@zju.edu.cn>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	andrew@lunn.ch,
	gregory.clement@bootlin.com,
	sebastian.hesselbarth@gmail.com,
	linux@armlinux.org.uk,
	Duoming Zhou <duoming@zju.edu.cn>
Subject: [PATCH v2] ARM: mvebu: Add error handling in coherency.c to prevent bugs
Date: Sun, 25 Feb 2024 22:31:22 +0800
Message-Id: <20240225143122.5640-1-duoming@zju.edu.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID:cC_KCgAHDjk7T9tlSgGRAQ--.63064S2
X-Coremail-Antispam: 1UD129KBjvdXoWrZFWrAryfKw45uFWrWr45Jrb_yoWkXFb_Cw
	4Sy3yDur1Sqay5ur1Uua1xWr90yws7Zry8AayIqFZ8A3yY9r15Zr9rtr1fAryaqrZYkrWa
	yasFkF1rAw1UWjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbskFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
	6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWU
	AVWUtwCY02Avz4vE14v_Xryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr
	1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE
	14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7
	IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E
	87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73Uj
	IFyTuYvjfUo-B_UUUUU
X-CM-SenderInfo: qssqjiasttq6lmxovvfxof0/1tbiAwMCAWXaOtIJRgAGsd
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The kzalloc() and kstrdup() in armada_375_380_coherency_init()
will return null if the physical memory has run out. As a result,
if we dereference these null pointers, the null pointer dereference
bugs will happen.

This patch adds error handling to avoid null pointer dereference.

Fixes: 497a92308af8 ("ARM: mvebu: implement L2/PCIe deadlock workaround")
Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>
---
Changes in v2:
  - Adds checks to judge whether kstrdup() fails.

 arch/arm/mach-mvebu/coherency.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/mach-mvebu/coherency.c b/arch/arm/mach-mvebu/coherency.c
index a6b621ff0b8..be50c83bfef 100644
--- a/arch/arm/mach-mvebu/coherency.c
+++ b/arch/arm/mach-mvebu/coherency.c
@@ -191,7 +191,13 @@ static void __init armada_375_380_coherency_init(struct device_node *np)
 		struct property *p;
 
 		p = kzalloc(sizeof(*p), GFP_KERNEL);
+		if (!p)
+			continue;
 		p->name = kstrdup("arm,io-coherent", GFP_KERNEL);
+		if (!p->name) {
+			kfree(p);
+			continue;
+		}
 		of_add_property(cache_dn, p);
 	}
 }
-- 
2.17.1


