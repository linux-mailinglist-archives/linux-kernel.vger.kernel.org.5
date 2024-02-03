Return-Path: <linux-kernel+bounces-50967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BAFFF84846A
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 08:53:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F1511F26714
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 07:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B72D84F8B1;
	Sat,  3 Feb 2024 07:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="kWneXtzT"
Received: from smtp.smtpout.orange.fr (smtp-17.smtpout.orange.fr [80.12.242.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D1A74EB38;
	Sat,  3 Feb 2024 07:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706946752; cv=none; b=KUfpZo3hZVjGrSMhcNVjN1Jpi+LBY1PfH7m/g+zpyvMn9ZoJNLuNJ/H05MSzQNg1VlMxliuV0Dr3+iXYk2uZeA/37XOYL8pzME1JMDqwxin4PlJ4akluscqr6osOPe8G0P79Eap0r7jdDr/HFj0clkEwNt3KZnnTL4kb8E6gVeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706946752; c=relaxed/simple;
	bh=aObXlr/4PR6KuSz8tcT/d0388K6mphyDLXDR/dnQyDE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EJuBBqKJsTpX9A2Hz7HVbqQ/wN7nJndAHQhfA4IuTKSeN+RWZDHL0Yk11kvhBUmObnkZNQ5CDclyg2yJzpHGy64db40O/TP3b1b/YNb/GqM7rrRAxhnmqSgoTHUkrg2GcLnk2t6c5jkbkFGN9cP/EBLuFlyrCDT8ch/MXf3kx7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=kWneXtzT; arc=none smtp.client-ip=80.12.242.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([92.140.202.140])
	by smtp.orange.fr with ESMTPA
	id WAnwrvC6Ki8tRWAo5rII0H; Sat, 03 Feb 2024 08:51:21 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1706946681;
	bh=fjCBezS7CokH+7JLcr/hfWM+uGZ5cz/EMtWkOxCQIdQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kWneXtzTmCFzOw/FUm8NnKkQd7Iw/IzgIyI9OnUrFuIkyCUysZBPxzSSHc7rCnzLp
	 Fjo0vDrwv1+o0JQAK6tK7XJMUzCdZ2FJaNBDhFY7VqWZjSmQTcIkzexhjGiUyygQp5
	 iYTUCXnEUxtPItjc+7CG2+NFGh59KFIPKqTGGyKSNWiJwn2DtS1+BYrVRJhTl/3EnV
	 X+gYEW8+s/BwowQ8bpVYMbXhj2rWc8ueMITbCV3FcgsJCKcaA94wP43ikE2KMFCE/r
	 2SboN1MQF6TknmG3CvtHW61z0kq5QVbiVkCQzCa3uZmCpzg3TczRjcY1OeWz5SINnA
	 nhruBnB2ax0ig==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 03 Feb 2024 08:51:21 +0100
X-ME-IP: 92.140.202.140
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: krzysztof.kozlowski@linaro.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH v2 1/2] nfc: hci: Introduce nfc_llc_del_engine() to reduce code duplication
Date: Sat,  3 Feb 2024 08:51:03 +0100
Message-ID: <6d9a8544b923d92defdf2ab1b9092004cc7b51f1.1706946099.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1706946099.git.christophe.jaillet@wanadoo.fr>
References: <cover.1706946099.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new helper to avoid code duplication between nfc_llc_exit() and
nfc_llc_unregister().

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 net/nfc/hci/llc.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/net/nfc/hci/llc.c b/net/nfc/hci/llc.c
index 2140f6724644..480c17f372a5 100644
--- a/net/nfc/hci/llc.c
+++ b/net/nfc/hci/llc.c
@@ -30,15 +30,19 @@ int __init nfc_llc_init(void)
 	return r;
 }
 
+static void nfc_llc_del_engine(struct nfc_llc_engine *llc_engine)
+{
+	list_del(&llc_engine->entry);
+	kfree(llc_engine->name);
+	kfree(llc_engine);
+}
+
 void nfc_llc_exit(void)
 {
 	struct nfc_llc_engine *llc_engine, *n;
 
-	list_for_each_entry_safe(llc_engine, n, &llc_engines, entry) {
-		list_del(&llc_engine->entry);
-		kfree(llc_engine->name);
-		kfree(llc_engine);
-	}
+	list_for_each_entry_safe(llc_engine, n, &llc_engines, entry)
+		nfc_llc_del_engine(llc_engine);
 }
 
 int nfc_llc_register(const char *name, const struct nfc_llc_ops *ops)
@@ -82,9 +86,7 @@ void nfc_llc_unregister(const char *name)
 	if (llc_engine == NULL)
 		return;
 
-	list_del(&llc_engine->entry);
-	kfree(llc_engine->name);
-	kfree(llc_engine);
+	nfc_llc_del_engine(llc_engine);
 }
 
 struct nfc_llc *nfc_llc_allocate(const char *name, struct nfc_hci_dev *hdev,
-- 
2.43.0


