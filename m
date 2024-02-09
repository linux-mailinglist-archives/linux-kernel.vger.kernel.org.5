Return-Path: <linux-kernel+bounces-59033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0515284F01B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 07:06:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAE6228818C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 06:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 371915788A;
	Fri,  9 Feb 2024 06:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AmuTqN5i"
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A020457301
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 06:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707458748; cv=none; b=C+AVRDxR0lKODyfxPP64ND6fR1VenyGE0GjAT4aBs1C+6LKuj7W7BZmC4OpPgOPaEwEZZbCvqxNlGaBOqjrvyy7tpA3ajxMlBem84GoIUg4erQTqGkIMjt0beVMRGFdYFH1OPfu4XwdtjhtlUg2Fzd/9SA1TG/+jULHvYzib47U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707458748; c=relaxed/simple;
	bh=v/nT8b1jYweKH7pv1wyqHS1aqwvFWTRrfh3SnZ5y8ZY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SUY/lYe4AHung7OSalo+ABbdFag4vU2xs5jalz5HYvBwfqzqIAjNOpSVXL1iwHAm0NXDOxFXRqQ0OEq+RTIKqESC+z6pA1dytSTW7MjaZp+tBBA9/q3MggMmum/6L9CB5HSyJjAStVdKr2ab1JaRigX55J9ZbxKLeWgvo4IgW/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=AmuTqN5i; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-59a99ef8c7fso179694eaf.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Feb 2024 22:05:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707458745; x=1708063545; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NXa++egn1I8A9aejMkYJFqgX4tfheQa1aOxxLsKxQ0w=;
        b=AmuTqN5im7fkdVxgg2FgKZqXluRiSzWNgJRiNTIP7ZErMbBri+jjf7LBy2sNPLvH1j
         BoNQ6LGzBYZif8qqOLcHy0IxGCiBR02VTlhoBJODbgimJpNUd61B05DxXm62zkIR11l1
         qQQLvV2Wn89j1Kaa0NY39AX3tls45t5w/hDZ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707458745; x=1708063545;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NXa++egn1I8A9aejMkYJFqgX4tfheQa1aOxxLsKxQ0w=;
        b=oBnt2ROPZmIklVusBqelSuHK7zM2YBTIpkZKUHQkp3HeHMdyKXSb+Pi1GynaGGHawu
         ++jEB0ZIggG4kvREMXBSgZrBACoznyNHoR5PqMsgRX1GZjpn2c09K8D4vzpOzDHHZNFE
         98JJEvjqXE4cNpEbxBFsaQnC0bsDxl/Rn3UnKhYDUXKDs2WHeG+eSoKxUhfuYeLzdOO2
         s4M81r3bSOTgG7myBaJEoG7s0VdtiovWi7pZmEnfZdpq+lBwgwOwVVgY7U2oGJs6HvzG
         45VMLIKAc2+dYYL3cRF2c63EGy5+xkRRH0yrpjYRaNsT2gHtbtdN7qOOUXfhG32VLpN4
         SZJQ==
X-Gm-Message-State: AOJu0YxUyIB9zWg+b64KQ5x8dk1M4XEiX1BesAd2xD8BDJUqJGG+CCud
	yyPL6IZ2qGosncBoUhYuvyA8XPnz1KV9AAx9UPXU5bfnuLBhioCAvTfY8cbP+A==
X-Google-Smtp-Source: AGHT+IF5CxCAWG/VNUGG1iIqxZegtuuT7f9cQSMghIVVa/CJhs4425T6h5CS/gS9J4mn1A8U87CbXw==
X-Received: by 2002:a05:6359:459f:b0:178:70f0:5a47 with SMTP id no31-20020a056359459f00b0017870f05a47mr595965rwb.2.1707458745538;
        Thu, 08 Feb 2024 22:05:45 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVcoxGYvdJdvOyr87l1IP50EKua3vOXqvYubDDDK/JcY/bGNDfu97x+B1NZ18UL7ruOYfTYjHIzjJ6keroBgdNBAWMSTfH1CD2qXxSulaW4i/zCFDubLqSuuU/D6KWmuQL5q1Pf+dMwAgr20ZCVXmo4NvmBw6FZUGA1FeSpJVo4mQB8Ksat/Mf3AomJwcASKjoatcnZhU6cxXLaK8j7uY+rpoPFwx7OcduA2xH01K1J0HFz1dQhYuWkoQr81UTZGHHyEWFqr2V96fwZDUQotLoGyi1TOXiXcfzihh4ADYS55glOvdn1rc6JpqsLyfaz7XO0jj/kZOnew7wIpNelZ2RkrB6oXYuMCA==
Received: from localhost (209.148.168.34.bc.googleusercontent.com. [34.168.148.209])
        by smtp.gmail.com with UTF8SMTPSA id v14-20020aa7850e000000b006ddb83e5e47sm827281pfn.90.2024.02.08.22.05.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Feb 2024 22:05:45 -0800 (PST)
From: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	linux-usb@vger.kernel.org
Cc: jthies@google.com,
	pmalani@chromium.org,
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Saranya Gopal <saranya.gopal@intel.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/3] usb: typec: ucsi: Update connector cap and status
Date: Thu,  8 Feb 2024 22:02:39 -0800
Message-ID: <20240208220230.v4.2.I3d909e3c9a200621e3034686f068a3307945fd87@changeid>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
In-Reply-To: <20240209060353.6613-1-abhishekpandit@chromium.org>
References: <20240209060353.6613-1-abhishekpandit@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update the data structures for ucsi_connector_capability and
ucsi_connector_status to UCSIv3.

Reviewed-by: Prashant Malani <pmalani@chromium.org>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
---

Changes in v4:
  - Fix BCD translation of PD Major Rev

Changes in v3:
  - Change include to asm/unaligned.h and reorder include.

 drivers/usb/typec/ucsi/ucsi.h | 56 ++++++++++++++++++++++++++++++++---
 1 file changed, 52 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/typec/ucsi/ucsi.h b/drivers/usb/typec/ucsi/ucsi.h
index bec920fa6b8a..7e35ffbe0a6f 100644
--- a/drivers/usb/typec/ucsi/ucsi.h
+++ b/drivers/usb/typec/ucsi/ucsi.h
@@ -10,6 +10,7 @@
 #include <linux/usb/typec.h>
 #include <linux/usb/pd.h>
 #include <linux/usb/role.h>
+#include <asm/unaligned.h>
 
 /* -------------------------------------------------------------------------- */
 
@@ -35,6 +36,12 @@ struct dentry;
 #define UCSI_BCD_GET_MINOR(_v_)		(((_v_) >> 4) & 0x0F)
 #define UCSI_BCD_GET_SUBMINOR(_v_)	((_v_) & 0x0F)
 
+/*
+ * Per USB PD 3.2, Section 6.2.1.1.5, the spec revision is represented by 2 bits
+ * 0b00 = 1.0, 0b01 = 2.0, 0b10 = 3.0, 0b11 = Reserved, Shall NOT be used.
+ */
+#define UCSI_SPEC_REVISION_TO_BCD(_v_)  (((_v_) + 1) << 8)
+
 /* Command Status and Connector Change Indication (CCI) bits */
 #define UCSI_CCI_CONNECTOR(_c_)		(((_c_) & GENMASK(7, 1)) >> 1)
 #define UCSI_CCI_LENGTH(_c_)		(((_c_) & GENMASK(15, 8)) >> 8)
@@ -214,9 +221,29 @@ struct ucsi_connector_capability {
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
+	UCSI_SPEC_REVISION_TO_BCD(UCSI_CONCAP_FLAG_PARTNER_PD_MAJOR_REV(_f_))
 } __packed;
 
 struct ucsi_altmode {
@@ -276,15 +303,36 @@ struct ucsi_connector_status {
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
2.43.0.687.g38aa6559b0-goog


