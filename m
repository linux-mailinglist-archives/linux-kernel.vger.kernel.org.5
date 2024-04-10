Return-Path: <linux-kernel+bounces-138398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AC9FB89F0AD
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 13:27:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC680B23411
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 11:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 168A715E809;
	Wed, 10 Apr 2024 11:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="Vr6qAr8i"
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385AF15B98F
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 11:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712748318; cv=none; b=s5Wbz3LGa0U6Fbpa6k27s14aVyR9TglCbbJZkoFSSGu+vb3XjTOb6QxbT+oaP7xB/4yV6sqHlJuuFPezAQjY9uA2ncpnYqKrmApCvXPGjLhMWnlbU1zcNMBEhzcLN+gCInKBFq1TGJEq9nLxuv+7UrXJzxceSS91cKfJr8VBu4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712748318; c=relaxed/simple;
	bh=KPt2uGhm9EdfH7F5fIbK6qEcblJ4g2P2Nirv6Vrgn0E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SgLHRNG0EJxZsv0+3FF2/RRzJqpHqEHkxEtSjqzxWj5ipClpagoUroO12alu2OY8qiDXNqxlTeComLFjKBQN5l664cjNlWEHE/fc25n3YOro3yYe97eH0stErivo6xKjr+WURg+Gi9rVv5MRcc/q6gf3YuOeb8fiW488nMsBsHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=Vr6qAr8i; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	 s=k1; bh=3esuL+DU1erk/gYHtm2gF1OBGVxFNyh1r/SypUa9yCM=; b=Vr6qAr
	8iFkO2wOh0d1gYTcxzNKRyDBqot/1ghiSOBRenx8UjsO+5PnOwwgoljk8Bs/UjIQ
	kbTetXqSgGkGWju9mEG5XkPttMpOltFo8bPzQwTAte/ly+rE108AWwHLP8sAtiZj
	diJblVIrmuAlp9n2ASvIDo9yY7FXDSOFWXfHqJ4sNFcPO3D/2OiY4q+t4uqm0e/f
	q8QmDwWXO42uR8VA1W5j5/WFcbOq6LzMSrn3wvZ5jYrLQM+c1XQhE3zlg2+bLwYP
	zgG8WxIPhfFPh0+uULC/GQpyFKVXQQUW+QiQkzK3WqGAGQ4YeBeVzrIJJ6N8Woqp
	N96as7wrkefpS4xA==
Received: (qmail 521590 invoked from network); 10 Apr 2024 13:25:08 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 10 Apr 2024 13:25:08 +0200
X-UD-Smtp-Session: l3s3148p1@YCV+SrwVeGJtKPEL
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Andi Shyti <andi.shyti@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 09/18] i2c: nomadik: remove printout on handled timeouts
Date: Wed, 10 Apr 2024 13:24:23 +0200
Message-ID: <20240410112418.6400-29-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240410112418.6400-20-wsa+renesas@sang-engineering.com>
References: <20240410112418.6400-20-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I2C and SMBus timeouts are not something the user needs to be informed
about on controller level. The client driver may know if that really is
a problem and give more detailed information to the user. The controller
should just pass this information upwards. Remove the printout.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/i2c/busses/i2c-nomadik.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/i2c/busses/i2c-nomadik.c b/drivers/i2c/busses/i2c-nomadik.c
index 4f41a3c7824d..45c6df26fcbf 100644
--- a/drivers/i2c/busses/i2c-nomadik.c
+++ b/drivers/i2c/busses/i2c-nomadik.c
@@ -542,12 +542,9 @@ static int read_i2c(struct nmk_i2c_dev *priv, u16 flags)
 
 	xfer_done = nmk_i2c_wait_xfer_done(priv);
 
-	if (!xfer_done) {
-		/* Controller timed out */
-		dev_err(&priv->adev->dev, "read from slave 0x%x timed out\n",
-			priv->cli.slave_adr);
+	if (!xfer_done)
 		status = -ETIMEDOUT;
-	}
+
 	return status;
 }
 
-- 
2.43.0


