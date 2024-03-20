Return-Path: <linux-kernel+bounces-108570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 730D6880C5A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 08:48:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A24AE1C21FC4
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 07:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30F0D2C6B2;
	Wed, 20 Mar 2024 07:48:39 +0000 (UTC)
Received: from cae.in-ulm.de (cae.in-ulm.de [217.10.14.231])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E30D41EB44;
	Wed, 20 Mar 2024 07:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.10.14.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710920918; cv=none; b=evtcBuri8uK3XC/t6QiNLdmHAWwNNo/d1XP+OW5DXC0XfK3k6wQlI/ycSQAF9tkmQvzsTAUtahY+DC+q1GSAk0FgLQcaRSd7Yhztdhss9Lmced9ZlEszxxO709MaQfHlc/87HGlipby9wb07UCzFOEqMTTaD4fdQBRCcU9GuUIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710920918; c=relaxed/simple;
	bh=/KZAiC6JOq0ybeDq5lNdxzeP0cezbAGpHMCtN60ZSCE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hO5rXVXqi/IWtxdh4V+a4rjj86MDsqpv+CGwH449QVLg9EONZZG0pRM2iguIMTx9ZJmHS57iQPyCNAIsuxBrb3aRC1/PzoafhqwD9tgfxzwCTVtmijhqBEhDNusMBQxMLeEpwnjscqWpULHM6AdtbSlHYf73ExQqgS3gXKmhNFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c--e.de; spf=pass smtp.mailfrom=c--e.de; arc=none smtp.client-ip=217.10.14.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c--e.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=c--e.de
Received: by cae.in-ulm.de (Postfix, from userid 1000)
	id 89B9E14055A; Wed, 20 Mar 2024 08:40:03 +0100 (CET)
From: "Christian A. Ehrhardt" <lk@c--e.de>
To: linux-kernel@vger.kernel.org
Cc: "Christian A. Ehrhardt" <lk@c--e.de>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Prashant Malani <pmalani@chromium.org>,
	Jameson Thies <jthies@google.com>,
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	=?UTF-8?q?Samuel=20=C4=8Cavoj?= <samuel@cavoj.net>,
	linux-usb@vger.kernel.org,
	Kenneth Crudup <kenny@panix.com>
Subject: [PATCH 1/5] usb: typec: ucsi: Clear EVENT_PENDING under PPM lock
Date: Wed, 20 Mar 2024 08:39:22 +0100
Message-Id: <20240320073927.1641788-2-lk@c--e.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240320073927.1641788-1-lk@c--e.de>
References: <20240320073927.1641788-1-lk@c--e.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Suppose we sleep on the PPM lock after clearing the EVENT_PENDING
bit because the thread for another connector is executing a command.
In this case the command completion of the other command will still
report the connector change for our connector.

Clear the EVENT_PENDING bit under the PPM lock to avoid another
useless call to ucsi_handle_connector_change() in this case.

Fixes: c9aed03a0a68 ("usb: ucsi: Add missing ppm_lock")
Signed-off-by: Christian A. Ehrhardt <lk@c--e.de>
---
 drivers/usb/typec/ucsi/ucsi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
index cf52cb34d285..8a6645ffd938 100644
--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@ -1215,11 +1215,11 @@ static void ucsi_handle_connector_change(struct work_struct *work)
 	if (con->status.change & UCSI_CONSTAT_CAM_CHANGE)
 		ucsi_partner_task(con, ucsi_check_altmodes, 1, 0);
 
-	clear_bit(EVENT_PENDING, &con->ucsi->flags);
-
 	mutex_lock(&ucsi->ppm_lock);
+	clear_bit(EVENT_PENDING, &con->ucsi->flags);
 	ret = ucsi_acknowledge_connector_change(ucsi);
 	mutex_unlock(&ucsi->ppm_lock);
+
 	if (ret)
 		dev_err(ucsi->dev, "%s: ACK failed (%d)", __func__, ret);
 
-- 
2.40.1


