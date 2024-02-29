Return-Path: <linux-kernel+bounces-87634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B983886D6C8
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 23:22:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB2E21C2264E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 22:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3698A74BF9;
	Thu, 29 Feb 2024 22:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="BboKlfR0"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 941AC74BEF;
	Thu, 29 Feb 2024 22:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709245330; cv=none; b=B9uMO04+CItIN/QUPuSpAMjEzudZ6IVu9JRdA7lYkKwbDMde4rce32wTx4y5UAQ+uIqY9p3E6qvXgFKLSkKx3vnHVXjyhd/LXsIeNu3crN8jEx5HdLKC3oVcA4gdxV1RDQqCIRDtpqmW7GlgP788ZCVaG8CjeoY+m/DIDaqwsHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709245330; c=relaxed/simple;
	bh=x18bamUUPpeftryab9h32Jt2kASCNEMw/tFEjiNtjOw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mcurYwLQaobd8aHYl34efM9ndgraQziRIrmqD5WroNukNJ8D/LtmlP5oowXfxVZDcfTrBzXwGbhDyFBYIg+4tPqD1X0uGy0AhKIZZT6UxWnXK3+FIXKlxnHsPV/dGdy8QI1K/Z7EWRGEPn2zHX/SLdCK7Szco0lq7/qf0TGVLYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=BboKlfR0; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 594DC1BF205;
	Thu, 29 Feb 2024 22:22:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709245324;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=vXQti813qjlmOLifixiuae4rGnXkl/dZRgzemhLIIuI=;
	b=BboKlfR0io6uhoSX9M/qXIXMRpbuvsG8ZMbNg98I66b0NOSB14mbHaVQn2B2noqZOXW9GN
	Jjy4nI02E+iAMD1ECCTRwYTNYFHqSDxq6mDCGWMcAHhzevWvTSJuWMYLIvoMsvIFwOvp6O
	RFEGJVXRWrJsgMy0GBDH1sOtAgfDKceOJhHXb2dqsd4Hz150sv4rqye/a9UM5pj6j88TmF
	aem+3qWJPn8mBsfTbH7+RP3jR5S14Ou4Rvwfw5Tvbz51wuTJMXvtpJobkypGc/LojAQKzN
	iftBgEP+ZeGuJ5suGgi/mGdIgf2Ae2UzNlC+Ek4gMyiWOLtN4OG21a7AA9kOxw==
From: alexandre.belloni@bootlin.com
To: Avi Fishman <avifishman70@gmail.com>,
	Tomer Maimon <tmaimon77@gmail.com>,
	Tali Perry <tali.perry1@gmail.com>,
	Patrick Venture <venture@google.com>,
	Nancy Yuen <yuenn@google.com>,
	Benjamin Fair <benjaminfair@google.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: kernel test robot <lkp@intel.com>,
	Dan Carpenter <error27@gmail.com>,
	openbmc@lists.ozlabs.org,
	linux-rtc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] rtc: nct3018y: fix possible NULL dereference
Date: Thu, 29 Feb 2024 23:21:27 +0100
Message-ID: <20240229222127.1878176-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alexandre.belloni@bootlin.com

From: Alexandre Belloni <alexandre.belloni@bootlin.com>

alarm_enable and alarm_flag are allowed to be NULL but will be dereferenced
later by the dev_dbg call.

Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <error27@gmail.com>
Closes: https://lore.kernel.org/r/202305180042.DEzW1pSd-lkp@intel.com/
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-nct3018y.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/rtc/rtc-nct3018y.c b/drivers/rtc/rtc-nct3018y.c
index f488a189a465..076d8b99f913 100644
--- a/drivers/rtc/rtc-nct3018y.c
+++ b/drivers/rtc/rtc-nct3018y.c
@@ -102,6 +102,8 @@ static int nct3018y_get_alarm_mode(struct i2c_client *client, unsigned char *ala
 		if (flags < 0)
 			return flags;
 		*alarm_enable = flags & NCT3018Y_BIT_AIE;
+		dev_dbg(&client->dev, "%s:alarm_enable:%x\n", __func__, *alarm_enable);
+
 	}
 
 	if (alarm_flag) {
@@ -110,11 +112,9 @@ static int nct3018y_get_alarm_mode(struct i2c_client *client, unsigned char *ala
 		if (flags < 0)
 			return flags;
 		*alarm_flag = flags & NCT3018Y_BIT_AF;
+		dev_dbg(&client->dev, "%s:alarm_flag:%x\n", __func__, *alarm_flag);
 	}
 
-	dev_dbg(&client->dev, "%s:alarm_enable:%x alarm_flag:%x\n",
-		__func__, *alarm_enable, *alarm_flag);
-
 	return 0;
 }
 
-- 
2.43.0


