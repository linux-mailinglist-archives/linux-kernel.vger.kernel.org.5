Return-Path: <linux-kernel+bounces-4703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6051F8180CE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 06:07:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F55028575B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 05:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 694305689;
	Tue, 19 Dec 2023 05:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="jikoi80u"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-15.smtpout.orange.fr [80.12.242.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 591CB611F
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 05:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from pop-os.home ([92.140.202.140])
	by smtp.orange.fr with ESMTPA
	id FSK1r7LYOlOIfFSK1rNq1F; Tue, 19 Dec 2023 06:07:14 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1702962434;
	bh=hNYuJtLt44j1feoxZtTgwq9FQXGAYBO23/GymZ86/oM=;
	h=From:To:Cc:Subject:Date;
	b=jikoi80uOG58pqVrEA9fTFMioN76sSv7LCJL4SuH6vCakXTBBmWmYfkAOQWtYoHyu
	 pEc6A7aHjbvWlA7dkVbNPKz4uqfFiNM2NzScWprWYzm+kTMVWkRKVjXsvoA1ucYThx
	 tsqgHNq8Dwg5liFAPkI9BhslqfgEkNQMQbfeItSN+OlEqm7Y8bnFQkVPVUGKoZ6fLW
	 M1KMltITCaUvAJp7hjqExWDcmRT4CC8xOKmRB6+/gn8PhavLF7M3ia69Pe6zPA5MBq
	 kc5XCbKvWtdTv5C4xx+dMppMM42ECriwWhMvMnHBZ+Ljn8DWwJSKqBX0OzI9B7Slm7
	 XrjzckzfpVRng==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Tue, 19 Dec 2023 06:07:14 +0100
X-ME-IP: 92.140.202.140
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-rtc@vger.kernel.org
Subject: [PATCH] rtc: class: Remove usage of the deprecated ida_simple_xx() API
Date: Tue, 19 Dec 2023 06:07:12 +0100
Message-Id: <4f2c049cb09d46fed336e22445c71988b4f340d6.1702962419.git.christophe.jaillet@wanadoo.fr>
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

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Commit 592ff0c8d064 ("rtc: Directly use ida_alloc()/free()") missed this
call
---
 drivers/rtc/class.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/class.c b/drivers/rtc/class.c
index edfd942f8c54..921ee1827974 100644
--- a/drivers/rtc/class.c
+++ b/drivers/rtc/class.c
@@ -256,7 +256,7 @@ static int rtc_device_get_id(struct device *dev)
 		of_id = of_alias_get_id(dev->parent->of_node, "rtc");
 
 	if (of_id >= 0) {
-		id = ida_simple_get(&rtc_ida, of_id, of_id + 1, GFP_KERNEL);
+		id = ida_alloc_range(&rtc_ida, of_id, of_id, GFP_KERNEL);
 		if (id < 0)
 			dev_warn(dev, "/aliases ID %d not available\n", of_id);
 	}
-- 
2.34.1


