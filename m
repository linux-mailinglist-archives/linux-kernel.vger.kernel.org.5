Return-Path: <linux-kernel+bounces-50966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14AA5848467
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 08:53:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EE921F26BD5
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 07:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32AB14F618;
	Sat,  3 Feb 2024 07:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="U2lmYnlY"
Received: from smtp.smtpout.orange.fr (smtp-18.smtpout.orange.fr [80.12.242.18])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18CA24F5EA;
	Sat,  3 Feb 2024 07:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706946750; cv=none; b=KEVkGgv0T0kk4OCpCl8963q0BEa3rndETtRyBS6ZGuh+e0hO7ntIQz32NZQzYIFr2lCd4BsNgZwYuUwAFQxmGhuwfLAy5qJ/Kf500/JzDyKXLXZSZjpj1sdQdiHtBdnnPHtRHgyrO0KTGZFKVLlzkowK/eXIqVVpvqH25EwTiw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706946750; c=relaxed/simple;
	bh=haoge43Ne0oBEpD0h2wKsXPSAC+6OmzX0ZitPVb50po=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VUe8gLis0wbO5cnIVk1vofx9rue2i28BKEtY7+BtAIhqvS1XimI4ui3cJQYADNRhDT2+G3G4VfH6NqhHEbbIOzmd/srJcIDRkr3mK9AZcfe81FNyn3sEXkDk7Wr879uHSPF9QXOSA2kwjmQ37dpb6C44uS1MsqwrpRfR/AruVgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=U2lmYnlY; arc=none smtp.client-ip=80.12.242.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([92.140.202.140])
	by smtp.orange.fr with ESMTPA
	id WAnwrvC6Ki8tRWAoBrII3V; Sat, 03 Feb 2024 08:51:27 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1706946687;
	bh=PvF+EwWrp7JXup44JQu6ssRQrUrUbuCCt5KLY27Imlo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=U2lmYnlYSmycEgBJXlN2kKc9yNONiBofVvUFCrMyqJeT6IAryWYlRMtj/4oueueNT
	 yAbm+SA4Rw6NXIk5zwAIqm3mqWITyfjGJlGZ2YZlVknWGUPvwIQJBfBdFgH+wBEwEx
	 OrRKvCWXcZ1VEG9qm+eF/wfYqYp2g6ps8915m9QYY3Y6rA6ER4vSguUXaZrGZuswoh
	 /QsHpEIko+2L307vGAEv779FY+f9yFUTrNzuYzz61XUJc03Yvjc3yNN4wupoUSehwL
	 8iCkn8evBtX+Qp1WvTN/Ituv+u6jy8T+ECHVp40ZRNXTagK5Q716Z+PVHOLs9Ztyvs
	 iJ/ivpPL7Qx+A==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 03 Feb 2024 08:51:27 +0100
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
Subject: [PATCH v2 2/2] nfc: hci: Save a few bytes of memory when registering a 'nfc_llc' engine
Date: Sat,  3 Feb 2024 08:51:04 +0100
Message-ID: <01cafe43646575d843ce81221ef4e0cdef6df84b.1706946099.git.christophe.jaillet@wanadoo.fr>
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

nfc_llc_register() calls pass a string literal as the 'name' parameter.

So kstrdup_const() can be used instead of kfree() to avoid a memory
allocation in such cases.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 net/nfc/hci/llc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/nfc/hci/llc.c b/net/nfc/hci/llc.c
index 480c17f372a5..ba91284f4086 100644
--- a/net/nfc/hci/llc.c
+++ b/net/nfc/hci/llc.c
@@ -33,7 +33,7 @@ int __init nfc_llc_init(void)
 static void nfc_llc_del_engine(struct nfc_llc_engine *llc_engine)
 {
 	list_del(&llc_engine->entry);
-	kfree(llc_engine->name);
+	kfree_const(llc_engine->name);
 	kfree(llc_engine);
 }
 
@@ -53,7 +53,7 @@ int nfc_llc_register(const char *name, const struct nfc_llc_ops *ops)
 	if (llc_engine == NULL)
 		return -ENOMEM;
 
-	llc_engine->name = kstrdup(name, GFP_KERNEL);
+	llc_engine->name = kstrdup_const(name, GFP_KERNEL);
 	if (llc_engine->name == NULL) {
 		kfree(llc_engine);
 		return -ENOMEM;
-- 
2.43.0


