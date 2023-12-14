Return-Path: <linux-kernel+bounces-101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30146813C2F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 21:59:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CC5728250F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 20:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D24C6ABBE;
	Thu, 14 Dec 2023 20:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="no427WYR"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-24.smtpout.orange.fr [80.12.242.24])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6734282E7
	for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 20:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from pop-os.home ([92.140.202.140])
	by smtp.orange.fr with ESMTPA
	id Dsfdr7wPcMO0QDsfdrnicB; Thu, 14 Dec 2023 21:51:02 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1702587062;
	bh=hcT2b/b6xTR+1AfrfpvlyfQ5cS5UMi2KsmeUgQqFiK4=;
	h=From:To:Cc:Subject:Date;
	b=no427WYRMy2s0aygADy5g9EOe3diE20SSlJA9Ki1nMexv59xQQBKtdfRVknJt7lxW
	 7ZI8PULUI+71968sLXcPHJDOb18fFhXcHf/qgaZpys3dLwPMUlyeFWWFLV4yzLq379
	 +pSk1Y0KK9S83D9DRHw6Hra0+3t72JoawwJkB0hhnKeMQCj+L0XyWspl6f2jeJG3PO
	 Dk9v6YaO5GlQcJEtqlZFQpzj5Pb5ZQOg5H+pjpaGAiK8aKxFZJLWJXfTAbzKKxBFuj
	 acLiDQPiE14pzTJAsV5mCl4MdHK9CwR3G3fnZhN425yAT838E/VIntia6SiaaqNnHm
	 VdAelwxBBQHXA==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Thu, 14 Dec 2023 21:51:02 +0100
X-ME-IP: 92.140.202.140
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <sfrench@samba.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Tom Talpey <tom@talpey.com>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-cifs@vger.kernel.org
Subject: [PATCH] ksmbd: Remove usage of the deprecated ida_simple_xx() API
Date: Thu, 14 Dec 2023 21:50:55 +0100
Message-Id: <f9d067e773f1cb3e9d4af19f18e80d7d35a71153.1702587034.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ida_alloc() and ida_free() should be preferred to the deprecated
ida_simple_get() and ida_simple_remove().

This is less verbose.

Note that the upper limit of ida_simple_get() is exclusive, but the one of
ida_alloc_range() is inclusive. So change a 0xFFFFFFFF into a 0xFFFFFFFE in
order to keep the same behavior.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 fs/smb/server/mgmt/ksmbd_ida.c | 21 ++++++---------------
 1 file changed, 6 insertions(+), 15 deletions(-)

diff --git a/fs/smb/server/mgmt/ksmbd_ida.c b/fs/smb/server/mgmt/ksmbd_ida.c
index 54194d959a5e..a18e27e9e0cd 100644
--- a/fs/smb/server/mgmt/ksmbd_ida.c
+++ b/fs/smb/server/mgmt/ksmbd_ida.c
@@ -5,42 +5,33 @@
 
 #include "ksmbd_ida.h"
 
-static inline int __acquire_id(struct ida *ida, int from, int to)
-{
-	return ida_simple_get(ida, from, to, GFP_KERNEL);
-}
-
 int ksmbd_acquire_smb2_tid(struct ida *ida)
 {
-	int id;
-
-	id = __acquire_id(ida, 1, 0xFFFFFFFF);
-
-	return id;
+	return ida_alloc_range(ida, 1, 0xFFFFFFFE, GFP_KERNEL);
 }
 
 int ksmbd_acquire_smb2_uid(struct ida *ida)
 {
 	int id;
 
-	id = __acquire_id(ida, 1, 0);
+	id = ida_alloc_min(ida, 1, GFP_KERNEL);
 	if (id == 0xFFFE)
-		id = __acquire_id(ida, 1, 0);
+		id = ida_alloc_min(ida, 1, GFP_KERNEL);
 
 	return id;
 }
 
 int ksmbd_acquire_async_msg_id(struct ida *ida)
 {
-	return __acquire_id(ida, 1, 0);
+	return ida_alloc_min(ida, 1, GFP_KERNEL);
 }
 
 int ksmbd_acquire_id(struct ida *ida)
 {
-	return __acquire_id(ida, 0, 0);
+	return ida_alloc(ida, GFP_KERNEL);
 }
 
 void ksmbd_release_id(struct ida *ida, int id)
 {
-	ida_simple_remove(ida, id);
+	ida_free(ida, id);
 }
-- 
2.34.1


