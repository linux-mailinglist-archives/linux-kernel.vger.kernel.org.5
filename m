Return-Path: <linux-kernel+bounces-25424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ADEC82D011
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 10:00:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F93B1F21C1D
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 09:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF8121FBE;
	Sun, 14 Jan 2024 09:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="ssbkoVS1"
Received: from smtp.smtpout.orange.fr (smtp-23.smtpout.orange.fr [80.12.242.23])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 308D9186B
	for <linux-kernel@vger.kernel.org>; Sun, 14 Jan 2024 09:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([92.140.202.140])
	by smtp.orange.fr with ESMTPA
	id OwEZrP7Of2jhsOwEZrsM9R; Sun, 14 Jan 2024 09:52:50 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1705222370;
	bh=yi38xR3jxyaNMmKPbq/ZSFZvYl79v0C2NPnhX4g7YBk=;
	h=From:To:Cc:Subject:Date;
	b=ssbkoVS1ZRNE8a3dVGCLxULy25MBTpxwBy07CDmMkeKUxMU4lGqdjnsGZr95CpCOQ
	 Zp6BVWDeOOuVPT4gbzC0Aod4Kt99bTRE8SOIobJrnxvbRMtdKEgKtOCLGHLjhbQE4m
	 XEOmGfFj/PK45n0AIdJA7QK9JWt8lmdxsVfbJmqLIeOny3zk8aryQgS6ACNU6iz+TG
	 K7jvZPXs5QqUEBuyZ5jNF0PD0rN2eTgDLwcegwa4WcB7atXIn578kqYaU+2kxw5EtV
	 4D38/TyQv5dZ+lLlKgQHMmAwNmfKzjQ+V/k8dMnA6j+mExZcJWVv5DSe7Bo+kISc1N
	 akRsy7qslzeng==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 14 Jan 2024 09:52:50 +0100
X-ME-IP: 92.140.202.140
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Marc Zyngier <maz@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH] irqchip/gic-v3-its: Remove usage of the deprecated ida_simple_xx() API
Date: Sun, 14 Jan 2024 09:52:39 +0100
Message-ID: <3b472b0e7edf6e483b8b255cf8d1cb0163532adf.1705222332.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ida_alloc() and ida_free() should be preferred to the deprecated
ida_simple_get() and ida_simple_remove().

Note that the upper limit of ida_simple_get() is exclusive, but the one of
ida_alloc_max() is inclusive. So a -1 has been added when needed.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/irqchip/irq-gic-v3-its.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index d097001c1e3e..cd950f435cf0 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -4419,12 +4419,12 @@ static const struct irq_domain_ops its_sgi_domain_ops = {
 
 static int its_vpe_id_alloc(void)
 {
-	return ida_simple_get(&its_vpeid_ida, 0, ITS_MAX_VPEID, GFP_KERNEL);
+	return ida_alloc_max(&its_vpeid_ida, ITS_MAX_VPEID - 1, GFP_KERNEL);
 }
 
 static void its_vpe_id_free(u16 id)
 {
-	ida_simple_remove(&its_vpeid_ida, id);
+	ida_free(&its_vpeid_ida, id);
 }
 
 static int its_vpe_init(struct its_vpe *vpe)
-- 
2.43.0


