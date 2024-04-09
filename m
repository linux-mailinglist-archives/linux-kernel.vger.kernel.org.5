Return-Path: <linux-kernel+bounces-136791-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7896789D833
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 13:40:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3023B2883A6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 11:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB49E12BEAC;
	Tue,  9 Apr 2024 11:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Mep8RMYk"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6769128362;
	Tue,  9 Apr 2024 11:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712662613; cv=none; b=L56vpUjIjHqpOcUXvMlWmil/4ob64+b61JDVk2IhIOu3zKypWSf4N/7BN9rN7yZkuLq8rlmUjHd3q7UBZQPuJzN1CCTxPJCqxKwe9C+UTNSWs89bGrwS0KQ5hJf5TIihEo0PkSI/ANy8toOyx7UoLSTvgbxWrIFW8pCedfzrC/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712662613; c=relaxed/simple;
	bh=qiUfa1Nb3MNGOeFN+5SAcHIbFBa6b14g3LCj9WcfGYY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bTyfc+2JyxRlinUP1qk1bSb8NSKza3jJjPakqtvXpmaxltKpLg0kOvxi/uiulsFaScmOYCuPFaHZ6+8nEfdcxgyDduE0fiGfiv5viAqzKRtnCSPc2Y2ixRuaFbrYIZm0P6OL3yXMxPJXIS8T54GRstw3yRZubTjtMbpzHeu5vNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Mep8RMYk; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1712662610;
	bh=qiUfa1Nb3MNGOeFN+5SAcHIbFBa6b14g3LCj9WcfGYY=;
	h=From:To:Cc:Subject:Date:From;
	b=Mep8RMYkVlOpYMgMdWwjPtOKDv+586xQEH0KaEtOWtrk5FtIwj6khBk+KYPa6I8yl
	 r8XyrLDcLYHNFRej+tc57p7sgZVWVFclMJPgRqlH1OxbHzcp73vn8P6Ijy5ntzRnlt
	 TgpgZ8faEyXkebBmm4TPlM0QV1QRWTsP6cC0SiH8KIzc1jbgQ49+J+5qdjXxFuej2V
	 TLMKz15ZmkCaNW57iTkJFpEvEjnxTsyN8vGyBHZPbJkLU4Um4H2+EyC++YB4yFMVwM
	 hS0E3jCsrTwTrUe4mUOsIevgv46NqwxTueT0naTlTu77RodIeta+1ur/IPC8X8Jifx
	 1S1vb8MndbUTw==
Received: from IcarusMOD.eternityproject.eu (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 8AD6537820F5;
	Tue,  9 Apr 2024 11:36:49 +0000 (UTC)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: heikki.krogerus@linux.intel.com
Cc: gregkh@linuxfoundation.org,
	angelogioacchino.delregno@collabora.com,
	dmitry.baryshkov@linaro.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel@collabora.com
Subject: [PATCH] usb: typec: mux: it5205: Fix ChipID value typo
Date: Tue,  9 Apr 2024 13:36:46 +0200
Message-ID: <20240409113646.305105-1-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ChipID bytes are read in inverse order: invert the ChipID value
defined as IT5205FN_CHIP_ID and used for validating the same.

Fixes: 41fe9ea1696c ("usb: typec: mux: Add ITE IT5205 Alternate Mode Passive MUX driver")
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/usb/typec/mux/it5205.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/typec/mux/it5205.c b/drivers/usb/typec/mux/it5205.c
index 5535932e42cd..4357cc67a867 100644
--- a/drivers/usb/typec/mux/it5205.c
+++ b/drivers/usb/typec/mux/it5205.c
@@ -22,7 +22,7 @@
 #include <linux/usb/typec_mux.h>
 
 #define IT5205_REG_CHIP_ID(x)	(0x4 + (x))
-#define IT5205FN_CHIP_ID	0x35323035 /* "5205" */
+#define IT5205FN_CHIP_ID	0x35303235 /* "5025" -> "5205" */
 
 /* MUX power down register */
 #define IT5205_REG_MUXPDR        0x10
-- 
2.44.0


