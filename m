Return-Path: <linux-kernel+bounces-111446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68E15886C7C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 13:59:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FD57281A7E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 12:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00D0546449;
	Fri, 22 Mar 2024 12:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uBbWDbQm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B674597F
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 12:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711112324; cv=none; b=iy7Y9OKgsk83Pw4niG778WgSBpIEnW29jfFsyZFlVe7MKBEckli9qQTVoGBC+nA8wlHRywQjbGWpiruS6ev+241BrMFH/5HjXAArzq86KL9u4AKZCT1IiJ1NapCT2YE7cx4ID4YNEaHkXHphXtqoUIQdyOIwu84NBMQo9PK79CE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711112324; c=relaxed/simple;
	bh=tPM3F2u9ASQYBV69NuQIdhVTqJUeD18FsKrclmmQJuQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IrHPezhXTxAZabyN2XWnKDVXafaR3jsrCJmuVguP2HVlV3U5fjnIWv/wsI2UBwrjc5Fj7H4v7z0zY+I8FlTioH/D8lTiTnWaiZTX2+yeXBQtLpjQjqJU1IIk6bhWEp/UgEiIbWDUruLPCwnR5nYFsd78I9wObVqKeGhOc+WdyL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uBbWDbQm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0947DC433C7;
	Fri, 22 Mar 2024 12:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711112324;
	bh=tPM3F2u9ASQYBV69NuQIdhVTqJUeD18FsKrclmmQJuQ=;
	h=From:To:Cc:Subject:Date:From;
	b=uBbWDbQm3ON8eVDvCuGB3egEYJD33nyQn2+geSiL9NhReMtoq8G2GGLWzG+DIf0Hn
	 1abdlYkXhLGyxVnYZ+8H6XsD5qd6wVxsfx3gWZaNGxUkZMBMBll24Y4Ecb9tTWhmbt
	 Bug0vetqcic4hBwO25H7K+g5EbOEg5jiQWznxCeGtsuE4EZXEjRG6fwu4Cc5TPqZ5d
	 XKgnQ6VVOUZFINo5duOjCOMqdaUnBdTjCj3HXT0Q8kFBMbMFrNUm5ThhTEhG24+WhD
	 UV22MNWcXGif2XH1zZuHF/QmXep3Z0wrALMc9uqhDdMEgxtsNq/vi25+RWsULdb7GA
	 mjEWL1Z6ZstaQ==
From: Arnd Bergmann <arnd@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@bootlin.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Marc Zyngier <maz@kernel.org>,
	Nathan Rossi <nathan.rossi@digi.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] [RESEND] irqchip: armada: suppress unused-function warning
Date: Fri, 22 Mar 2024 13:58:25 +0100
Message-Id: <20240322125838.901649-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

armada_370_xp_msi_reenable_percpu is only defined when CONFIG_PCI_MSI
is enabled, and only called when SMP is enabled.

Without CONFIG_SMP, there are no callers, so we get a build time
warning instead:

drivers/irqchip/irq-armada-370-xp.c:319:13: error: 'armada_370_xp_msi_reenable_percpu' defined but not used [-Werror=unused-function]
  319 | static void armada_370_xp_msi_reenable_percpu(void) {}
      |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Mark the function as __maybe_unused to avoid adding more complexity
to the #ifdefs.

Fixes: 8ca61cde32c1 ("irqchip/armada-370-xp: Enable MSI affinity configuration")
Link: https://lore.kernel.org/lkml/20221215170202.2441960-1-arnd@kernel.org/
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
I noticed this never got applied, and the warning still remains.
---
 drivers/irqchip/irq-armada-370-xp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-armada-370-xp.c b/drivers/irqchip/irq-armada-370-xp.c
index a55528469278..4b021a67bdfe 100644
--- a/drivers/irqchip/irq-armada-370-xp.c
+++ b/drivers/irqchip/irq-armada-370-xp.c
@@ -316,7 +316,7 @@ static int armada_370_xp_msi_init(struct device_node *node,
 	return 0;
 }
 #else
-static void armada_370_xp_msi_reenable_percpu(void) {}
+static __maybe_unused void armada_370_xp_msi_reenable_percpu(void) {}
 
 static inline int armada_370_xp_msi_init(struct device_node *node,
 					 phys_addr_t main_int_phys_base)
-- 
2.39.2


