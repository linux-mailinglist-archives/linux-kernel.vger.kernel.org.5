Return-Path: <linux-kernel+bounces-127068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D6CF894664
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 23:05:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33D7C1F21D2B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 21:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D502854919;
	Mon,  1 Apr 2024 21:05:47 +0000 (UTC)
Received: from cae.in-ulm.de (cae.in-ulm.de [217.10.14.231])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59EFB339B1;
	Mon,  1 Apr 2024 21:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.10.14.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712005547; cv=none; b=limVxFAOXlvy40eZzowRmpQQlSsTcs78Q+pY7cFttOZh7KPL7eJ5cuGzeDcAX3m0dZzjInBMWNUABcluC7BFdZNt9yrqDh7C+Uw83XvQNdEHC2mCU92wPBvI0KkdmGLgyichPD9PyjrWbxJd7TAych5y9GM+6eWdOzduJpVxhq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712005547; c=relaxed/simple;
	bh=bJVKAgGnqfF4tjUnla5zMbVpX1RvRhpt1DlkH2v+sL4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AOnGYFZiesGG5gpl7aLEH7NHXT83kZUCg3yV4YVV9kiKCMKar0HqwIGg5/BZz0kTsgkwHAc6ZFABDVAb/LcnApkin21sXlYy12rzyHIkmfc9d3+b3YkzLhzVCCZvHgYaSqez1G3s6HZOL9rSYUvzv7WFI/vkdXkaKcIgZc1R7XA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c--e.de; spf=pass smtp.mailfrom=c--e.de; arc=none smtp.client-ip=217.10.14.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c--e.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=c--e.de
Received: by cae.in-ulm.de (Postfix, from userid 1000)
	id 106C114033A; Mon,  1 Apr 2024 23:05:43 +0200 (CEST)
From: "Christian A. Ehrhardt" <lk@c--e.de>
To: linux-kernel@vger.kernel.org,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: "Christian A. Ehrhardt" <lk@c--e.de>,
	stable@kernel.org,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Prashant Malani <pmalani@chromium.org>,
	Jameson Thies <jthies@google.com>,
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	=?UTF-8?q?Samuel=20=C4=8Cavoj?= <samuel@cavoj.net>,
	linux-usb@vger.kernel.org
Subject: [PATCH] usb: typec: ucsi: Fix connector check on init
Date: Mon,  1 Apr 2024 23:05:15 +0200
Message-Id: <20240401210515.1902048-1-lk@c--e.de>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix issues when initially checking for a connector change:
- Use the correct connector number not the entire CCI.
- Call ->read under the PPM lock.
- Remove a bogus READ_ONCE.

Fixes: 808a8b9e0b87 ("usb: typec: ucsi: Check for notifications after init")
Cc: stable@kernel.org
Signed-off-by: Christian A. Ehrhardt <lk@c--e.de>
---
 drivers/usb/typec/ucsi/ucsi.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
index 31d8a46ae5e7..bd6ae92aa39e 100644
--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@ -1736,11 +1736,13 @@ static int ucsi_init(struct ucsi *ucsi)
 	ucsi->connector = connector;
 	ucsi->ntfy = ntfy;
 
+	mutex_lock(&ucsi->ppm_lock);
 	ret = ucsi->ops->read(ucsi, UCSI_CCI, &cci, sizeof(cci));
+	mutex_unlock(&ucsi->ppm_lock);
 	if (ret)
 		return ret;
-	if (UCSI_CCI_CONNECTOR(READ_ONCE(cci)))
-		ucsi_connector_change(ucsi, cci);
+	if (UCSI_CCI_CONNECTOR(cci))
+		ucsi_connector_change(ucsi, UCSI_CCI_CONNECTOR(cci));
 
 	return 0;
 
-- 
2.40.1


