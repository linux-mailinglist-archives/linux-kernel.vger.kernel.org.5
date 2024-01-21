Return-Path: <linux-kernel+bounces-32185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A3FD8357C8
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 21:42:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22316B220F0
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 20:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26B3838DFC;
	Sun, 21 Jan 2024 20:41:44 +0000 (UTC)
Received: from cae.in-ulm.de (cae.in-ulm.de [217.10.14.231])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96DAD381AC;
	Sun, 21 Jan 2024 20:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.10.14.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705869703; cv=none; b=Mx53Vo0AGVJ5TRaYFW0DgLTZrDo2m6NaS+qgj8xrAoRzrdP8XQ5KLXlVbrDh8gsUDg1Jz/5beF/L983tSQQraJPwTaWY7QdODQ00fy93aeh1bFC0hggRJxQMxri3hETxO126qIP+og99sNYefIj/k3bxIwIWGhC2blL+8kKhEbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705869703; c=relaxed/simple;
	bh=a74cBVmfYeJUZpWdG+gkCPScISxo1VpIOiqyEL6S6W8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UXj9FEOY6s9/E3m4XCTIWvP8LrKgzYS8/WwBwF8cVmluYdcSKXfN49mkZ1mAI75Q31GLTCmoLHyOrwbH3j79BtXqGcurKiwpDlDB7fO2wU2qkcwL2lIxnFkkTj+8ZucVihhBz63N2/2prRaHklgTUDsNh7qXf13MsqVjk/THhcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c--e.de; spf=pass smtp.mailfrom=c--e.de; arc=none smtp.client-ip=217.10.14.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c--e.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=c--e.de
Received: by cae.in-ulm.de (Postfix, from userid 1000)
	id 9B3C7140255; Sun, 21 Jan 2024 21:41:39 +0100 (CET)
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
Subject: [PATCH v3 1/3] usb: ucsi: Add missing ppm_lock
Date: Sun, 21 Jan 2024 21:41:21 +0100
Message-Id: <20240121204123.275441-2-lk@c--e.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240121204123.275441-1-lk@c--e.de>
References: <20240121204123.275441-1-lk@c--e.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Calling ->sync_write must be done while holding the PPM lock as
the mailbox logic does not support concurrent commands.

At least since the addition of partner task this means that
ucsi_acknowledge_connector_change should be called with the
PPM lock held as it calls ->sync_write.

Thus protect the only call to ucsi_acknowledge_connector_change
with the PPM. All other calls to ->sync_write already happen
under the PPM lock.

Fixes: b9aa02ca39a4 ("usb: typec: ucsi: Add polling mechanism for partner tasks like alt mode checking")
Cc: stable@vger.kernel.org
Signed-off-by: Christian A. Ehrhardt <lk@c--e.de>
---
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


