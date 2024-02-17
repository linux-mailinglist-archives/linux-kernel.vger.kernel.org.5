Return-Path: <linux-kernel+bounces-69714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39AC2858DA6
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 08:32:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 645CC1C20F6F
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 07:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D4511CD15;
	Sat, 17 Feb 2024 07:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="phcQj97w"
Received: from smtp.smtpout.orange.fr (smtp-19.smtpout.orange.fr [80.12.242.19])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3705517727
	for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 07:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708155120; cv=none; b=lEXpdpTYnkwKCjTxtsQtZ7NqNZeavgJUj7pOiDhEwF8OxCf4n9WVBg6cWLnOGuBrMWcAk0dEc7tqWT9P0GnyQ94eI0Jz+/AVZVPNALy56psYVjtQxdnO1cwMHlYTxPVEQSo38QpMnYvr0C7azTXcfxFcn/NJsidu9lGTzaX9a7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708155120; c=relaxed/simple;
	bh=npv7ZOWRpw6sxGJkWx9vOTc73+q2ocP0AqU18/94cms=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kmzLPrAjFLCQmb4CVKURy4wKSazuflOFf85brgS4Dn4EGwEXsCtHLYv3YRGPmmPuAfmD7tIf7/S/EzwpG6hV/Gc6pRBGfI1NOaCgS8bRAP6c3+qkJb5rNT1Y0xC9zN7ep/8ScZLvAxbeHAUtmqfUj2S2letfze3c40Xz7oXk6yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=phcQj97w; arc=none smtp.client-ip=80.12.242.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([92.140.202.140])
	by smtp.orange.fr with ESMTPA
	id bF9rr7RBlRhCJbF9rr0LV3; Sat, 17 Feb 2024 08:30:48 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1708155048;
	bh=HXDa8YFPQiliIbuq5HJ9khulV8rK+PXHSC6Ee9kcXik=;
	h=From:To:Cc:Subject:Date;
	b=phcQj97w9FE+Zh+H12MyDYbqxfDXboeZhcdKcaDy6IYyvzkOgI972oBzbtXtwMg5C
	 TSZzZnStNK+6c0yjaRj6GF3y0dBpnOXAJAUlwEsLl9upx5aFrJOzMzF2hKsQXaT49C
	 mXh+FDJQK6n9udm26kvldXMSW6j8/KqH2VouZIXH4wPfx71+y8hUTRLOsfunS4eSb0
	 xMXnV9UilbxMZjyEV378CWYPjQR0nLNmPjq0rPE2VV1lRyo6Te76CGsSbLDlhQVbNA
	 BXcBr0lnTd3SDNbOwf3iQ+bI5ijk3c7TvYPinnOVdFynHb25p4ZKxfLFfGilW4zWsl
	 /+7QF7t8eyVFw==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 17 Feb 2024 08:30:48 +0100
X-ME-IP: 92.140.202.140
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] Bluetooth: btbcm: Use strreplace()
Date: Sat, 17 Feb 2024 08:30:41 +0100
Message-ID: <79b9c9d9f86b4c573f0d3f2dac0a6fc9e6024058.1708154999.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use strreplace() instead of hand-writing it.
It is less verbose.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/bluetooth/btbcm.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/bluetooth/btbcm.c b/drivers/bluetooth/btbcm.c
index 0a5445ac5e1b..01d2343b4978 100644
--- a/drivers/bluetooth/btbcm.c
+++ b/drivers/bluetooth/btbcm.c
@@ -11,6 +11,7 @@
 #include <linux/firmware.h>
 #include <linux/dmi.h>
 #include <linux/of.h>
+#include <linux/string.h>
 #include <asm/unaligned.h>
 
 #include <net/bluetooth/bluetooth.h>
@@ -544,7 +545,6 @@ static const char *btbcm_get_board_name(struct device *dev)
 	char *board_type;
 	const char *tmp;
 	int len;
-	int i;
 
 	root = of_find_node_by_path("/");
 	if (!root)
@@ -557,10 +557,7 @@ static const char *btbcm_get_board_name(struct device *dev)
 	len = strlen(tmp) + 1;
 	board_type = devm_kzalloc(dev, len, GFP_KERNEL);
 	strscpy(board_type, tmp, len);
-	for (i = 0; i < len; i++) {
-		if (board_type[i] == '/')
-			board_type[i] = '-';
-	}
+	strreplace(board_type, '/', '-');
 	of_node_put(root);
 
 	return board_type;
-- 
2.43.2


