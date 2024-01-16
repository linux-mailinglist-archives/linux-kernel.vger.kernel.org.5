Return-Path: <linux-kernel+bounces-28359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8535482FD42
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 23:46:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E516FB24624
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 22:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1C221DA31;
	Tue, 16 Jan 2024 22:41:14 +0000 (UTC)
Received: from cae.in-ulm.de (cae.in-ulm.de [217.10.14.231])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1D8C1C2BB;
	Tue, 16 Jan 2024 22:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.10.14.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705444874; cv=none; b=B8YYuUIfznMHO7fuELZoMbU2+megX0Qg5qyPjMVMEG5EAR2fXI4OjjRlO6G/5/FLxsDqsz4HcplVUBO/ihv0p46hykKoq2ux8aBSLVIib7AiBj5oVJFibE2NZSHC42RfCA8VAZ0jAJbhJ/FN7F6Xiv7bL3ApbFIXn7D2W6inalg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705444874; c=relaxed/simple;
	bh=crRkzrseVP9YPMxkcPGvSv5ziYVUbab0uAzK43mUOHc=;
	h=Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding; b=jeY65XovLFzaYDPlbSR6gTNCDpIMVhRlMWHVzvNxatuoDfjEiV4ta/RBZAtnHaB9xs3EoBAMsqTa7rYPm6YObUNwNh6sH5PJn8xeanvgdDseKGGC6NVA6luL6KSxmW+5N+AQGST4ESy4QlvR5sX80tkM/xOrWlTQiERu7FatZSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c--e.de; spf=pass smtp.mailfrom=c--e.de; arc=none smtp.client-ip=217.10.14.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c--e.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=c--e.de
Received: by cae.in-ulm.de (Postfix, from userid 1000)
	id 6E2E6140346; Tue, 16 Jan 2024 23:41:09 +0100 (CET)
From: "Christian A. Ehrhardt" <lk@c--e.de>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	linux-usb@vger.kernel.org
Cc: "Christian A. Ehrhardt" <lk@c--e.de>,
	Dell.Client.Kernel@dell.com,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Hans de Goede <hdegoede@redhat.com>,
	Jack Pham <quic_jackp@quicinc.com>,
	Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
	=?UTF-8?q?Samuel=20=C4=8Cavoj?= <samuel@cavoj.net>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] usb: ucsi: Add missing ppm_lock
Date: Tue, 16 Jan 2024 23:40:39 +0100
Message-Id: <20240116224041.220740-2-lk@c--e.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240116224041.220740-1-lk@c--e.de>
References: <20240116224041.220740-1-lk@c--e.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Calling ->sync_write must be done while holding the PPM lock as the
mailbox logic does not support concurrent commands.

Thus protect the only call to ucsi_acknowledge_connector_change
with the PPM lock as it calls ->sync_write. All other calls to
->sync_write already happen under the PPM lock.

Signed-off-by: Christian A. Ehrhardt <lk@c--e.de>
---
NOTE: This is not a theoretical issue. I've seen problems resulting
from the missing lock on real hardware.

 drivers/usb/typec/ucsi/ucsi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
index 61b64558f96c..8f9dff993b3d 100644
--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@ -935,7 +935,9 @@ static void ucsi_handle_connector_change(struct work_struct *work)
 
 	clear_bit(EVENT_PENDING, &con->ucsi->flags);
 
+	mutex_lock(&ucsi->ppm_lock);
 	ret = ucsi_acknowledge_connector_change(ucsi);
+	mutex_unlock(&ucsi->ppm_lock);
 	if (ret)
 		dev_err(ucsi->dev, "%s: ACK failed (%d)", __func__, ret);
 
-- 
2.40.1


