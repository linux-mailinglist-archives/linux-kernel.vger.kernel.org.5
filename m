Return-Path: <linux-kernel+bounces-108571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C395D880C5C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 08:49:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A578B21D3F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 07:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1071C374CF;
	Wed, 20 Mar 2024 07:48:40 +0000 (UTC)
Received: from cae.in-ulm.de (cae.in-ulm.de [217.10.14.231])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E313C22F07;
	Wed, 20 Mar 2024 07:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.10.14.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710920919; cv=none; b=qAhiOCELr0b9l7frhWRYKJDsukzS4+bAaMHOkOwj0DBBSTrEfwO7jmQCPFJTNd+PUCa7mEXRk3RtAHSqSgJdHv0j3nVhAmr8HAEdkyz3JQLOsOML16AF9NXhfWU+QDM314xBcXTG2fWQZ0+YpfL8A3w3PSGkHRU+DyKAVO2sGJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710920919; c=relaxed/simple;
	bh=mdgMqfsJqx6yP6KG7NUVhitkX5wgR7Ijn/LGX47PJFA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qE14jRNUQrh9+Fgj2FZk3+Tgp/fqNugibF+bx7VRmIJ5DAUpVHKomBGSiTIV0qFP8jWXZ87gmNMs/ID12hkpqqZX6Azk7Soknzf24ot8ibtXw5YyLPxrs9D43S+FjIzZU2S/3tl+Cf3x0S9mBmhYw0Tgzi04Uy3s0IeOp0CjppY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c--e.de; spf=pass smtp.mailfrom=c--e.de; arc=none smtp.client-ip=217.10.14.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c--e.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=c--e.de
Received: by cae.in-ulm.de (Postfix, from userid 1000)
	id BE028140583; Wed, 20 Mar 2024 08:40:06 +0100 (CET)
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
Subject: [PATCH 2/5] usb: typec: ucsi: Check for notifications after init
Date: Wed, 20 Mar 2024 08:39:23 +0100
Message-Id: <20240320073927.1641788-3-lk@c--e.de>
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

The completion notification for the final SET_NOTIFICATION_ENABLE
command during initialization can include a connector change
notification.  However, at the time this completion notification is
processed, the ucsi struct is not ready to handle this notification.
As a result the notification is ignored and the controller
never sends an interrupt again.

Re-check CCI for a pending connector state change after
initialization is complete. Adjust the corresponding debug
message accordingly.

Fixes: 71a1fa0df2a3 ("usb: typec: ucsi: Store the notification mask")
Cc: stable@vger.kernel.org
Signed-off-by: Christian A. Ehrhardt <lk@c--e.de>
---
 drivers/usb/typec/ucsi/ucsi.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
index 8a6645ffd938..dceeed207569 100644
--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@ -1237,7 +1237,7 @@ void ucsi_connector_change(struct ucsi *ucsi, u8 num)
 	struct ucsi_connector *con = &ucsi->connector[num - 1];
 
 	if (!(ucsi->ntfy & UCSI_ENABLE_NTFY_CONNECTOR_CHANGE)) {
-		dev_dbg(ucsi->dev, "Bogus connector change event\n");
+		dev_dbg(ucsi->dev, "Early connector change event\n");
 		return;
 	}
 
@@ -1636,6 +1636,7 @@ static int ucsi_init(struct ucsi *ucsi)
 {
 	struct ucsi_connector *con, *connector;
 	u64 command, ntfy;
+	u32 cci;
 	int ret;
 	int i;
 
@@ -1688,6 +1689,13 @@ static int ucsi_init(struct ucsi *ucsi)
 
 	ucsi->connector = connector;
 	ucsi->ntfy = ntfy;
+
+	ret = ucsi->ops->read(ucsi, UCSI_CCI, &cci, sizeof(cci));
+	if (ret)
+		return ret;
+	if (UCSI_CCI_CONNECTOR(READ_ONCE(cci)))
+		ucsi_connector_change(ucsi, cci);
+
 	return 0;
 
 err_unregister:
-- 
2.40.1


