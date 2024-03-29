Return-Path: <linux-kernel+bounces-124798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3243891CA0
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:54:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5D701C26C01
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D842718D868;
	Fri, 29 Mar 2024 12:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VFJXAGsH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A82418C9F1;
	Fri, 29 Mar 2024 12:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716155; cv=none; b=m66vwsWr3w6eNg4g4tKZbburC22N0BvcCDUN5fZW3yZTjwiHAxzfhg0ZYLP8QclK56vuiXyl0E6xnZ30IbbaqkwUKq2ql4aXwUQn7iOU+zGltOz1TT5eJyxrTOENgLODZAyHL4kJOm4EOTDa+2u6Tqrclh1ZxCRTT0V9kjzF1Rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716155; c=relaxed/simple;
	bh=q2BWX4NtxKmcgK3P7af7UtWPPDXWCKw/GYQhqCUTSNY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rlDg8AP5Ss8nNfW/Bu6cdtlRvjRABPnVR0czLSiB6pDvzz70PrOZmStwQG4+Yz5/lYJPg8GFt2KiMIox/lLT0+RWphN6Q9OUvuRwRNssYVm49WdaRRzLN5lGip3IUCYS0YyDscZ9CZze5e7Ox2Oxh68deuREmZa6N1NliwIxEOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VFJXAGsH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D50FBC43390;
	Fri, 29 Mar 2024 12:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716154;
	bh=q2BWX4NtxKmcgK3P7af7UtWPPDXWCKw/GYQhqCUTSNY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VFJXAGsH16GzdYPhwr00hA+ZDqwwWCrUYAflTt25DugoReaQWShGIQdkCK5+P2IRP
	 ekTKxlBTZ+a3nfStrCl+4o77WDXZ3L/SKwV5/kpGCtnLlLIuOb2eRl5QN01Rc97N+t
	 LUG9XhApxSc7yyfkqIR1Md5/7ln1iOojYUlAAbFEhK2vhi6ZkED76k3q10XV+FbdDa
	 leCc1AVeEvWIjl777FHduMYafdpzjACMI9XWZ5fNU2GLjB4/JL9ReuuqTTVa7LDqIu
	 c4Lu4G5klVooEGedvgiIomLfjoeMW34YPyQ+/IzEXX2CZKgi4VdN/kZCmk4roK7Fvx
	 yzCM1EmlPmtIg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Duje=20Mihanovi=C4=87?= <duje.mihanovic@skole.hr>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Sasha Levin <sashal@kernel.org>,
	markuss.broks@gmail.com,
	linux-input@vger.kernel.org
Subject: [PATCH AUTOSEL 6.8 87/98] Input: imagis - use FIELD_GET where applicable
Date: Fri, 29 Mar 2024 08:37:58 -0400
Message-ID: <20240329123919.3087149-87-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329123919.3087149-1-sashal@kernel.org>
References: <20240329123919.3087149-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.2
Content-Transfer-Encoding: 8bit

From: Duje Mihanović <duje.mihanovic@skole.hr>

[ Upstream commit c0ca3dbd03d66c6b9e044f48720e6ab5cef37ae5 ]

Instead of manually extracting certain bits from registers with binary
ANDs and shifts, the FIELD_GET macro can be used. With this in mind, the
*_SHIFT macros can be dropped.

Signed-off-by: Duje Mihanović <duje.mihanovic@skole.hr>
Link: https://lore.kernel.org/r/20240306-b4-imagis-keys-v3-1-2c429afa8420@skole.hr
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/input/touchscreen/imagis.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/drivers/input/touchscreen/imagis.c b/drivers/input/touchscreen/imagis.c
index e1fafa561ee38..fe65e083fd49b 100644
--- a/drivers/input/touchscreen/imagis.c
+++ b/drivers/input/touchscreen/imagis.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 
+#include <linux/bitfield.h>
 #include <linux/bits.h>
 #include <linux/delay.h>
 #include <linux/i2c.h>
@@ -29,12 +30,9 @@
 #define IST3038C_I2C_RETRY_COUNT	3
 #define IST3038C_MAX_FINGER_NUM		10
 #define IST3038C_X_MASK			GENMASK(23, 12)
-#define IST3038C_X_SHIFT		12
 #define IST3038C_Y_MASK			GENMASK(11, 0)
 #define IST3038C_AREA_MASK		GENMASK(27, 24)
-#define IST3038C_AREA_SHIFT		24
 #define IST3038C_FINGER_COUNT_MASK	GENMASK(15, 12)
-#define IST3038C_FINGER_COUNT_SHIFT	12
 #define IST3038C_FINGER_STATUS_MASK	GENMASK(9, 0)
 
 struct imagis_properties {
@@ -106,8 +104,7 @@ static irqreturn_t imagis_interrupt(int irq, void *dev_id)
 		goto out;
 	}
 
-	finger_count = (intr_message & IST3038C_FINGER_COUNT_MASK) >>
-				IST3038C_FINGER_COUNT_SHIFT;
+	finger_count = FIELD_GET(IST3038C_FINGER_COUNT_MASK, intr_message);
 	if (finger_count > IST3038C_MAX_FINGER_NUM) {
 		dev_err(&ts->client->dev,
 			"finger count %d is more than maximum supported\n",
@@ -115,7 +112,7 @@ static irqreturn_t imagis_interrupt(int irq, void *dev_id)
 		goto out;
 	}
 
-	finger_pressed = intr_message & IST3038C_FINGER_STATUS_MASK;
+	finger_pressed = FIELD_GET(IST3038C_FINGER_STATUS_MASK, intr_message);
 
 	for (i = 0; i < finger_count; i++) {
 		if (ts->tdata->protocol_b)
@@ -136,12 +133,11 @@ static irqreturn_t imagis_interrupt(int irq, void *dev_id)
 		input_mt_report_slot_state(ts->input_dev, MT_TOOL_FINGER,
 					   finger_pressed & BIT(i));
 		touchscreen_report_pos(ts->input_dev, &ts->prop,
-				       (finger_status & IST3038C_X_MASK) >>
-						IST3038C_X_SHIFT,
-				       finger_status & IST3038C_Y_MASK, 1);
+				       FIELD_GET(IST3038C_X_MASK, finger_status),
+				       FIELD_GET(IST3038C_Y_MASK, finger_status),
+				       true);
 		input_report_abs(ts->input_dev, ABS_MT_TOUCH_MAJOR,
-				 (finger_status & IST3038C_AREA_MASK) >>
-					IST3038C_AREA_SHIFT);
+				 FIELD_GET(IST3038C_AREA_MASK, finger_status));
 	}
 
 	input_mt_sync_frame(ts->input_dev);
-- 
2.43.0


