Return-Path: <linux-kernel+bounces-138048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EB0B89EB81
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 09:11:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 803841C21491
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 07:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB07613C9B6;
	Wed, 10 Apr 2024 07:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="GXeR+ESe"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C6313C903;
	Wed, 10 Apr 2024 07:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712733062; cv=none; b=o2dl2oL6alUNUgdEckEWECebyoTDWHD+1K6rR/41HqXjwG2T1MNp8GGWHC5bz6fKc6lLGTBL+sRZPVfhG5efbI/SsSv24xUQmUp9HwKvWfcGOzndg/HmdqAQpIuPdjYdEvuT3t2Qn3fp7+4hA4rVuexKu3RH3/yHnMbAM0/tTv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712733062; c=relaxed/simple;
	bh=K9ZC8G7osWKKKF8a/tJjhaswJrqEV1KZaFfP5+r+sKU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Yy2drlCaq7lcQ3IL5pyNGbvIFo0OBVHmhbGbgu0Q8oW1uJ6IJ+hSgOx0dihvOer2cQkKs+35QPHOdDgWl0enyahUpd5PMFUjxIBRGEfJ+Y5pOPMsrS8uQ6SgvvE6u8X6tu2CrZ8UcG3cUK5xA4Fdkvgrdj/zyaCvgvP5E+97RKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=GXeR+ESe; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id BDF25E0009;
	Wed, 10 Apr 2024 07:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1712733058;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VTpKlPiX2xXwu9MO3vuIvPNbD06SGLmZ+l9rPMuQPG0=;
	b=GXeR+ESeHRb8pKpN6lH/rpC+NectWzH9cBqp5weIQGX6KVrqk2Xh5v9azE5W48AtJZkr/z
	TAuCD40sLcBf1+68Ffr6mOTZbgyIvGS7/tlFHX7q+Egm83cJhCQ4k0e6pr5MYuO5ERAYQ6
	Oj/+nXzIu7Do/FnL882KNWJHOx3luzicckqeuLdGUToq5NuJ4syf3oHfqoSgB2Z5+j6Xs3
	1ovNht1dSHSXsxVWAA9c1X7MgMAMBXju6XACU0NmqSSkVoT4J5rxkfcG4xFghHtRkN8kS6
	yAfZpqGNhnKK1E7QVxZOpNeqvtzHnfUUiAsCK8qcYUqzyBd0D4d0FkajzfgXPQ==
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Date: Wed, 10 Apr 2024 09:10:33 +0200
Subject: [PATCH 1/2] wifi: wilc1000: set atomic flag on kmemdup in srcu
 critical section
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240410-wilc_srcu_to_rcu-v1-1-a9ff5b10feaa@bootlin.com>
References: <20240410-wilc_srcu_to_rcu-v1-0-a9ff5b10feaa@bootlin.com>
In-Reply-To: <20240410-wilc_srcu_to_rcu-v1-0-a9ff5b10feaa@bootlin.com>
To: Ajay Singh <ajay.kathat@microchip.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, Kalle Valo <kvalo@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
X-Mailer: b4 0.13.0
X-GND-Sasl: alexis.lothore@bootlin.com

In order to prepare wilc1000 driver switch from SRCU to RCU, make sure that
allocators are provided with the GFP_ATOMIC flag when called in a critical
read section.

Signed-off-by: Alexis Lothoré <alexis.lothore@bootlin.com>
---
 drivers/net/wireless/microchip/wilc1000/hif.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/microchip/wilc1000/hif.c b/drivers/net/wireless/microchip/wilc1000/hif.c
index f1085ccb7eed..3925ca653e80 100644
--- a/drivers/net/wireless/microchip/wilc1000/hif.c
+++ b/drivers/net/wireless/microchip/wilc1000/hif.c
@@ -1594,7 +1594,7 @@ void wilc_network_info_received(struct wilc *wilc, u8 *buffer, u32 length)
 	msg->body.net_info.rssi = buffer[8];
 	msg->body.net_info.mgmt = kmemdup(&buffer[9],
 					  msg->body.net_info.frame_len,
-					  GFP_KERNEL);
+					  GFP_ATOMIC);
 	if (!msg->body.net_info.mgmt) {
 		kfree(msg);
 		goto out;

-- 
2.44.0


