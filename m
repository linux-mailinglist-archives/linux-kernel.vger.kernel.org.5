Return-Path: <linux-kernel+bounces-36149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C74A839C44
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 23:31:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BD1A1F2A924
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 22:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F7DD55767;
	Tue, 23 Jan 2024 22:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="b4OD7+G2"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D06754654
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 22:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706049048; cv=none; b=MFAaRxYFpN/bRYlFemkNhIsQJwZ+4TS3wDJ1EDwO8P98H80JgE/2SUWmcF/pl5djWWbAOjz4tO8E7rQI/b5IZnqhA8Xht7uEPHjPNmkA3BqNYu8kr+vpeS1yCpdx4HcHCjo8osUo/p9rOoUQhOgEI+wn5aPtTzAC/YSfmpb2kis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706049048; c=relaxed/simple;
	bh=kf7yJI0PSynYy3En1UbYNrF5sIujOUcOGcuO2Brc3lg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KnKpUUHw0zjzucm5Ze16MZzL3E0KUnR5qy3lYnOp4gPv507ErBmZWgUvdpmd4UX31KOD6K+qX7xpmwzJ1fKyVjzFISHjHHkP695EB6GIDiYXj/0aXlH1i6mJPWx6ySQF9zYnGJcOGVMO8fBGVRQVEU6EwH5J3ijGA/mejVF5KqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--abhishekpandit.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=b4OD7+G2; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--abhishekpandit.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc221ed88d9so6345907276.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 14:30:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706049046; x=1706653846; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2vpNRulCzZMNU5JocFm5dd+td45+IWqD0hs2FPi7+Eo=;
        b=b4OD7+G2XdgXMPZrHTuh9Hd0lRAiN3RdB9dNXfAeUVANpKrATRyxQoHAq4BgV5F1uN
         fpBEsgIJEcI4wWw3R2+zZdloBYVNY/fA3lw/XhCuWKAN/G9brUKmQG5QsvLQbn7LiH94
         Le0ZZbuqRkKZVYIMR7a5qjJzBP2ZLHaLHI7qI2PCp5Isf5x3GLPoOc9YiKrH7+4MQDxI
         MjkAgKtJnWclP1R6neEYD7C9WLcpdAbMDwfgIjPZ3dPRMrZ2gAcvUv/hGZYKzSErGDmc
         E0dXigVpPREi3GsLituRmZYETj8eDjWY4MaFslCbhFWomJdSUdCiRv0gf0zR3VYhOwOQ
         vhMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706049046; x=1706653846;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2vpNRulCzZMNU5JocFm5dd+td45+IWqD0hs2FPi7+Eo=;
        b=mM46q2j5PhYhSZ1T+L3YFRyRCoyY8Y4Dqj5HtZyUPVLCKC3hoUJ/p2JBSzmGDR6Ewb
         oty/HRfLCaVtRboY8cbk3Uh1s3mUXxH5GCkKSxd+MsbSHqVeq9hTGlTklDGDjyAO3buN
         sQK9ReHE0/XR6Y0d/cnUKhunUbLc8tpNrDt3AUWQZp/68bTbIYma3Hq7Fzoq3nbHZWDr
         nkw0x+327pZvtopKlySwMLAJuR0y820VNpMFI9Alk06ZRtsdUV7Xlg3JWGrwFVQ9dMiS
         mnkxGddnvmZlUPrr6i1rCRiMiJSIrLA7TA57Vutxeee4Pst+LGrlzi5NDTXqgvgHmjKL
         rAGA==
X-Gm-Message-State: AOJu0YxPztvTVa4sRFz4dAna//zbMjlh5bQB/Cc9XopXuJham4zPsWLZ
	laix1Ev1S2+EpCI0kd4udw5WK6mGR9+OH6i8CPPYod7yzsOrCrZ7/YRsxj7OxDQR9E7vG0Tx0+Q
	+HGExgsFx6LO+7o5VHvl1p4kwsj+JyNbIlw==
X-Google-Smtp-Source: AGHT+IEKXaLwcIhuIIjt7ZY+gcERRVNWvf7dQiKd6y1V/MnqABqCPAsRs6xT4Xi282+JqMW7qgWOSI3RmS+eQFHX9BvmuQ==
X-Received: from abps.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:9b4])
 (user=abhishekpandit job=sendgmr) by 2002:a05:6902:230e:b0:dc2:57c9:b462 with
 SMTP id do14-20020a056902230e00b00dc257c9b462mr408887ybb.9.1706049046103;
 Tue, 23 Jan 2024 14:30:46 -0800 (PST)
Date: Tue, 23 Jan 2024 14:30:35 -0800
In-Reply-To: <20240123223039.1471557-1-abhishekpandit@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240123223039.1471557-1-abhishekpandit@google.com>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240123143026.v1.2.I3d909e3c9a200621e3034686f068a3307945fd87@changeid>
Subject: [PATCH v1 2/3] usb: typec: ucsi: Update connector cap and status
From: Abhishek Pandit-Subedi <abhishekpandit@google.com>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>, linux-usb@vger.kernel.org
Cc: pmalani@chromium.org, jthies@google.com, 
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>, Bjorn Andersson <andersson@kernel.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Saranya Gopal <saranya.gopal@intel.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>

Update the data structures for ucsi_connector_capability and
ucsi_connector_status to UCSIv3.

Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
---
Connector status has several unaligned bitfields (16-bit) that result in
difficult to maintain macros. It may be better if we simply re-define
these structs as u8[] and add bit range macros to access and cast these
values.

i.e.
struct ucsi_connector_status {
  u8 raw_data[18];

..
\#define UCSI_CONSTAT_CONNECTOR_STATUS          FIELD(u16, 15, 0)
\#define UCSI_CONSTAT_BCD_PD_VER_OPER_MODE      FIELD(u16, 85, 70)
}

GET_UCSI_FIELD(con->status, UCSI_CONSTAT_CONNECTOR_STATUS);
SET_UCSI_FIELD(con->status, UCSI_CONSTAT_CONNECTOR_STATUS, 0);

I didn't find a clear example of an existing mechanism to do this. Would
love some pointers here if it already exists and some feedback from the
maintainer if this is a direction you want to go.


 drivers/usb/typec/ucsi/ucsi.h | 50 ++++++++++++++++++++++++++++++++---
 1 file changed, 46 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/typec/ucsi/ucsi.h b/drivers/usb/typec/ucsi/ucsi.h
index bec920fa6b8a..94b373378f63 100644
--- a/drivers/usb/typec/ucsi/ucsi.h
+++ b/drivers/usb/typec/ucsi/ucsi.h
@@ -3,6 +3,7 @@
 #ifndef __DRIVER_USB_TYPEC_UCSI_H
 #define __DRIVER_USB_TYPEC_UCSI_H
 
+#include <asm-generic/unaligned.h>
 #include <linux/bitops.h>
 #include <linux/device.h>
 #include <linux/power_supply.h>
@@ -214,9 +215,29 @@ struct ucsi_connector_capability {
 #define UCSI_CONCAP_OPMODE_USB2			BIT(5)
 #define UCSI_CONCAP_OPMODE_USB3			BIT(6)
 #define UCSI_CONCAP_OPMODE_ALT_MODE		BIT(7)
-	u8 flags;
+	u32 flags;
 #define UCSI_CONCAP_FLAG_PROVIDER		BIT(0)
 #define UCSI_CONCAP_FLAG_CONSUMER		BIT(1)
+#define UCSI_CONCAP_FLAG_SWAP_TO_DFP		BIT(2)
+#define UCSI_CONCAP_FLAG_SWAP_TO_UFP		BIT(3)
+#define UCSI_CONCAP_FLAG_SWAP_TO_SRC		BIT(4)
+#define UCSI_CONCAP_FLAG_SWAP_TO_SINK		BIT(5)
+#define UCSI_CONCAP_FLAG_EX_OP_MODE(_f_) \
+	(((_f_) & GENMASK(13, 6)) >> 6)
+#define   UCSI_CONCAP_EX_OP_MODE_USB4_GEN2	BIT(0)
+#define   UCSI_CONCAP_EX_OP_MODE_EPR_SRC	BIT(1)
+#define   UCSI_CONCAP_EX_OP_MODE_EPR_SINK	BIT(2)
+#define   UCSI_CONCAP_EX_OP_MODE_USB4_GEN3	BIT(3)
+#define   UCSI_CONCAP_EX_OP_MODE_USB4_GEN4	BIT(4)
+#define UCSI_CONCAP_FLAG_MISC_CAPS(_f_) \
+	(((_f_) & GENMASK(17, 14)) >> 14)
+#define   UCSI_CONCAP_MISC_CAP_FW_UPDATE	BIT(0)
+#define   UCSI_CONCAP_MISC_CAP_SECURITY		BIT(1)
+#define UCSI_CONCAP_FLAG_REV_CURR_PROT_SUPPORT	BIT(18)
+#define UCSI_CONCAP_FLAG_PARTNER_PD_MAJOR_REV(_f_) \
+	(((_f_) & GENMASK(20, 19)) >> 19)
+#define UCSI_CONCAP_FLAG_PARTNER_PD_MAJOR_REV_AS_BCD(_f_) \
+	(UCSI_CONCAP_FLAG_PARTNER_PD_MAJOR_REV(_f_) << 8)
 } __packed;
 
 struct ucsi_altmode {
@@ -276,15 +297,36 @@ struct ucsi_connector_status {
 #define   UCSI_CONSTAT_PARTNER_TYPE_DEBUG	5
 #define   UCSI_CONSTAT_PARTNER_TYPE_AUDIO	6
 	u32 request_data_obj;
-	u8 pwr_status;
-#define UCSI_CONSTAT_BC_STATUS(_p_)		((_p_) & GENMASK(2, 0))
+
+	u8 pwr_status[3];
+#define UCSI_CONSTAT_BC_STATUS(_p_)		((_p_[0]) & GENMASK(1, 0))
 #define   UCSI_CONSTAT_BC_NOT_CHARGING		0
 #define   UCSI_CONSTAT_BC_NOMINAL_CHARGING	1
 #define   UCSI_CONSTAT_BC_SLOW_CHARGING		2
 #define   UCSI_CONSTAT_BC_TRICKLE_CHARGING	3
-#define UCSI_CONSTAT_PROVIDER_CAP_LIMIT(_p_)	(((_p_) & GENMASK(6, 3)) >> 3)
+#define UCSI_CONSTAT_PROVIDER_CAP_LIMIT(_p_)	(((_p_[0]) & GENMASK(5, 2)) >> 2)
 #define   UCSI_CONSTAT_CAP_PWR_LOWERED		0
 #define   UCSI_CONSTAT_CAP_PWR_BUDGET_LIMIT	1
+#define UCSI_CONSTAT_PROVIDER_PD_VERSION_OPER_MODE(_p_)	\
+	((get_unaligned_le32(_p_) & GENMASK(21, 6)) >> 6)
+#define UCSI_CONSTAT_ORIENTATION(_p_)		(((_p_[2]) & GENMASK(6, 6)) >> 6)
+#define   UCSI_CONSTAT_ORIENTATION_DIRECT	0
+#define   UCSI_CONSTAT_ORIENTATION_FLIPPED	1
+#define UCSI_CONSTAT_SINK_PATH_STATUS(_p_)	(((_p_[2]) & GENMASK(7, 7)) >> 7)
+#define   UCSI_CONSTAT_SINK_PATH_DISABLED	0
+#define   UCSI_CONSTAT_SINK_PATH_ENABLED	1
+	u8 pwr_readings[9];
+#define UCSI_CONSTAT_REV_CURR_PROT_STATUS(_p_)	((_p_[0]) & 0x1)
+#define UCSI_CONSTAT_PWR_READING_VALID(_p_)	(((_p_[0]) & GENMASK(1, 1)) >> 1)
+#define UCSI_CONSTAT_CURRENT_SCALE(_p_)		(((_p_[0]) & GENMASK(4, 2)) >> 2)
+#define UCSI_CONSTAT_PEAK_CURRENT(_p_) \
+	((get_unaligned_le32(_p_) & GENMASK(20, 5)) >> 5)
+#define UCSI_CONSTAT_AVG_CURRENT(_p_) \
+	((get_unaligned_le32(&(_p_)[2]) & GENMASK(20, 5)) >> 5)
+#define UCSI_CONSTAT_VOLTAGE_SCALE(_p_) \
+	((get_unaligned_le16(&(_p_)[4]) & GENMASK(8, 5)) >> 5)
+#define UCSI_CONSTAT_VOLTAGE_READING(_p_) \
+	((get_unaligned_le32(&(_p_)[5]) & GENMASK(16, 1)) >> 1)
 } __packed;
 
 /* -------------------------------------------------------------------------- */
-- 
2.43.0.429.g432eaa2c6b-goog


