Return-Path: <linux-kernel+bounces-26472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC78882E175
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 21:19:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AC682838AB
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 20:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E180199A1;
	Mon, 15 Jan 2024 20:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="rvju9V8n"
Received: from smtp.smtpout.orange.fr (smtp-13.smtpout.orange.fr [80.12.242.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B2B18EB0
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 20:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([92.140.202.140])
	by smtp.orange.fr with ESMTPA
	id PTQNrgwv8ZHPAPTQNrErBY; Mon, 15 Jan 2024 21:19:12 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1705349952;
	bh=Nd4xsK13KUVRINMeDES9iWKoGtfPahNcjU6sjTGV0U4=;
	h=From:To:Cc:Subject:Date;
	b=rvju9V8nVQQCGIp2vv2cWzL991buAagC5aU7ROOXh64pAksfHuPeD0XCWauy49vzQ
	 fp3B7xbnlcpbJ/9B/i3MnzRiWpmrC3lraAigKZP4cyY2//CsKelSU90LnFGxcoZuHi
	 9rBv0o+9KgfWfFuhxim4Nls1FBDWlXl3XpnXk77g7fOMwqJ+zx5qmmt8m7P7TBZWwr
	 CfH57WK5vojg4fF+Bp8A6RtuOaKD/apiQc8SdoJZM00Vb3oEGgOnwHPBM3rEUlr6gj
	 nAOCrF8rOYBpRfd+WFf2hoN//f+8R/A4XUumgJlgphbkZ+mm/ItNz1DyFtKGIBe5Ht
	 5Cckss9s3kYtA==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 15 Jan 2024 21:19:12 +0100
X-ME-IP: 92.140.202.140
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-input@vger.kernel.org
Subject: [PATCH] Input: Remove usage of the deprecated ida_simple_xx() API
Date: Mon, 15 Jan 2024 21:19:04 +0100
Message-ID: <a885de14beead2cc3c1c946f192b8b178dac696a.1705349930.git.christophe.jaillet@wanadoo.fr>
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
ida_alloc_range() is inclusive. So a -1 has been added when needed.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/input/input.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/input/input.c b/drivers/input/input.c
index f71ea4fb173f..de7884a5be39 100644
--- a/drivers/input/input.c
+++ b/drivers/input/input.c
@@ -2629,17 +2629,15 @@ int input_get_new_minor(int legacy_base, unsigned int legacy_num,
 	 * locking is needed here.
 	 */
 	if (legacy_base >= 0) {
-		int minor = ida_simple_get(&input_ida,
-					   legacy_base,
-					   legacy_base + legacy_num,
-					   GFP_KERNEL);
+		int minor = ida_alloc_range(&input_ida, legacy_base,
+					    legacy_base + legacy_num - 1,
+					    GFP_KERNEL);
 		if (minor >= 0 || !allow_dynamic)
 			return minor;
 	}
 
-	return ida_simple_get(&input_ida,
-			      INPUT_FIRST_DYNAMIC_DEV, INPUT_MAX_CHAR_DEVICES,
-			      GFP_KERNEL);
+	return ida_alloc_range(&input_ida, INPUT_FIRST_DYNAMIC_DEV,
+			       INPUT_MAX_CHAR_DEVICES - 1, GFP_KERNEL);
 }
 EXPORT_SYMBOL(input_get_new_minor);
 
@@ -2652,7 +2650,7 @@ EXPORT_SYMBOL(input_get_new_minor);
  */
 void input_free_minor(unsigned int minor)
 {
-	ida_simple_remove(&input_ida, minor);
+	ida_free(&input_ida, minor);
 }
 EXPORT_SYMBOL(input_free_minor);
 
-- 
2.43.0


