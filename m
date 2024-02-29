Return-Path: <linux-kernel+bounces-87526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5AA386D581
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 22:04:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA48D1C2297D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 21:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97AF9153503;
	Thu, 29 Feb 2024 20:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="SfBEQkle"
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F7914405D;
	Thu, 29 Feb 2024 20:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709239383; cv=none; b=tUk5LwHHlPngCfjMqqjpvzPN6vd4mEABquqAS8JnStkJepF3rMY5uKHxNgKrqxfMDSt32QYhvr5QLe7QBt4qBoHY29i8SPbVkc9jmEY0mjiFXD/qwNDpupZhbu/ugnqrRwF1VB43k9I09EQUz1c0tfaw1uOXxh3i9cqQU+0aVSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709239383; c=relaxed/simple;
	bh=KXdgm/I/ewft6TDONs1/C8PbLQ8HZujA3uwky710JcQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bc+hElg0ImP5fyCqGEj5EDL9MDjPRqMa5IGKW3XW6z71U9hsjT9VZcPQ1R9fjXeQ78Ha2pGlxHrAr67sUFrAgst3BLA4J48WZZzn/wqJc1c8c4q49v5/zUmbkWxOyrMe8uK/gOnwj2+jBdsm1kXHgO6vyxIW/VUP0aYTkjf5Dck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=SfBEQkle; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from localhost.ispras.ru (unknown [10.10.165.8])
	by mail.ispras.ru (Postfix) with ESMTPSA id 3295940B27A1;
	Thu, 29 Feb 2024 20:42:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 3295940B27A1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1709239372;
	bh=eANDFJjcF28TbbY3NAVdjRQJ+bbD85155CR8rqMcY8E=;
	h=From:To:Cc:Subject:Date:From;
	b=SfBEQkleMTQQB8i9ri0DjO6Qh0zDw1x5+QA69r+8BbMw93Gf8bbETFYaG4995ugcW
	 lxfXENFRm1JGJ1peL2XYto6WOYj07fixAqX41BTfoWTSAD/03u4eLrGLcwVomxKABH
	 sU264do6bHhtUbcKqgQjdJfblDDtLGX38dd5fH6E=
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Richard Weinberger <richard@nod.at>
Cc: Fedor Pchelkin <pchelkin@ispras.ru>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Alexey Khoroshilov <khoroshilov@ispras.ru>,
	lvc-project@linuxtesting.org,
	stable@vger.kernel.org
Subject: [PATCH] ubi: eba: properly rollback inside self_check_eba
Date: Thu, 29 Feb 2024 23:42:36 +0300
Message-ID: <20240229204237.30453-1-pchelkin@ispras.ru>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In case of a memory allocation failure in the volumes loop we can only
process the already allocated scan_eba and fm_eba array elements on the
error path - others are still uninitialized.

Found by Linux Verification Center (linuxtesting.org).

Fixes: 00abf3041590 ("UBI: Add self_check_eba()")
Cc: stable@vger.kernel.org
Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
---
 drivers/mtd/ubi/eba.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/ubi/eba.c b/drivers/mtd/ubi/eba.c
index 8d1f0e05892c..6f5eadb1598d 100644
--- a/drivers/mtd/ubi/eba.c
+++ b/drivers/mtd/ubi/eba.c
@@ -1557,6 +1557,7 @@ int self_check_eba(struct ubi_device *ubi, struct ubi_attach_info *ai_fastmap,
 					  GFP_KERNEL);
 		if (!fm_eba[i]) {
 			ret = -ENOMEM;
+			kfree(scan_eba[i]);
 			goto out_free;
 		}
 
@@ -1592,7 +1593,7 @@ int self_check_eba(struct ubi_device *ubi, struct ubi_attach_info *ai_fastmap,
 	}
 
 out_free:
-	for (i = 0; i < num_volumes; i++) {
+	while (--i >= 0) {
 		if (!ubi->volumes[i])
 			continue;
 
-- 
2.43.2


