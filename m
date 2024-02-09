Return-Path: <linux-kernel+bounces-60123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB670850024
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 23:39:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE8301C233C6
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 22:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D73C838FA9;
	Fri,  9 Feb 2024 22:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lto0lsIf"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 605AF2AD39
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 22:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707518310; cv=none; b=EU43PWo+uCJPL1t2cOaemukEqpuZfry0GPrkujMJjAnzLIb6xYhyRd5iDcsEkalEfj4tYorAvvhadVI5GBl74D6AFucvESLjo1qov1eLZQWOLWCU37z9yppi6Q+F0whrOhPudhFsx6rn5WXTQVbvBweFo6/Zk5s6HqCjBS5z2kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707518310; c=relaxed/simple;
	bh=Cc9hBfVDEI9Fq6JPOFe/l1+gX3OamRL9BW5+Efsqr2c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e0I4VkJRWA/9D21bwpLoacSTbo/IUiEU1I6Rq8Bu+M5R04fg3sBPSaPXQo0cxI9W4y3bHVHrahj1fzSpji5x46rghTjjSpKuA4cghprW6FKU/Q9MpBi6BfY+MynbJJTnigBy43hFUQh6OYVo+Pj/0cfc6vrkGTqqJw8mu9ifsNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=lto0lsIf; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1d76671e5a4so12102375ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 14:38:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707518308; x=1708123108; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V6t8uVjqfKj+e3cGps0LaAFzQjViggK8EPU4tBP7N9o=;
        b=lto0lsIf//GA22D8769iFnDeGCnOzmprRL1OWUuO4vsUmTT1gdS96Xq0CzEhwRosS8
         ewsHzq2hlevgJ6hwVcF8S3nG2Vq5WUoiFw0aeN4GiMNLrUaLotfGHfhwG36w8lVUSGBP
         38qxsRGdVvs+rU7dyh27jiSZXUlKu4PuQVyjk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707518308; x=1708123108;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V6t8uVjqfKj+e3cGps0LaAFzQjViggK8EPU4tBP7N9o=;
        b=V13TM1hrOMXxAnBI1HMSJhRugN04ACHZvwNaVuIV8p8hKKvTGsp0ilysAOgTwE9W6S
         6AJp2PI2aHuXS5sD1wRTEY5YAQm7ZCRwYTyGuZBKm7Xn51qzY126MUSLQHd1fg6UZU/j
         LHxXN1639devqHqaaGLaTpt9FHJMEq8UuKyhUazVVRlPAHf8fAYkdJq17JfHfBUqAhi5
         7C5DS0Gl39S7ABKRMzuTi0+bvyVSD/8nr8TpZKpd0cnJdji3BPNq4CUDfwKtjNxVMbFX
         82+50G7l2/olHTPdjDqQBtxx1jt9hL7lVM8i14IJViBVA7nubLYEklemSqtAoAMZDRb4
         JXig==
X-Forwarded-Encrypted: i=1; AJvYcCUqIFRmtXSH3KFtX4A32Urs5Xg1W6+zfYWNmkgSjvwmqOZecANoaiF3sVh3oepS3PeCJWGwn5BHF1w+vyzk0OenuTXN/yTOLPp1Y/P0
X-Gm-Message-State: AOJu0YzIZm8KiYv1xgPu648Pb4195asEjpB+VYWC3u9a5CPOf7m9L8kl
	FO1ER10t9/uV2XEgjVZv9ERODX8RMJ58xfNlB6H1EXEPpNPNBEDDM+XXd0759g==
X-Google-Smtp-Source: AGHT+IEf//UhEtjPmIrfZyWSzsZOgYN4OBY74daLptH7w7pxhwxszMYJQ2/w+0GFx12aZrxBx8nNRw==
X-Received: by 2002:a17:902:fc50:b0:1d7:7edb:e9b9 with SMTP id me16-20020a170902fc5000b001d77edbe9b9mr737372plb.37.1707518307760;
        Fri, 09 Feb 2024 14:38:27 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXXkAyYIf/gyptbxo35GZBi2zFh6q5MA2hBk8+tFFeMl6Ynu0eX3gNs43873+gh09D2GTJqakgvMCSVvIJpb2wpNLdV/MbVWlkZWckABc+q/SkSkWyUNhXGsZwaJYSg8AtCQi1THbkaAV0G+ErCQPo4Yvd09wzir0JbwCwuUEfFnE68QMxVqhspVjUIMmodycitHvl+T2dJhqDGcot1+/51ba3Herr3M7JTKueaKHAYcmHcUdWnEpDGIc1NXnCtf8OyuZiFPB+oho0cZaotNupuQIg72vy7qmjPaF/GVkYBlbDBJcZEzwhgiuvPeOctdxdzflbKVo4DTCF/luDodCjqEn2rWYmb
Received: from localhost (209.148.168.34.bc.googleusercontent.com. [34.168.148.209])
        by smtp.gmail.com with UTF8SMTPSA id v2-20020a170903238200b001d54b763995sm1976154plh.129.2024.02.09.14.38.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Feb 2024 14:38:27 -0800 (PST)
From: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	linux-usb@vger.kernel.org
Cc: pmalani@chromium.org,
	jthies@google.com,
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rajaram Regupathy <rajaram.regupathy@intel.com>,
	Saranya Gopal <saranya.gopal@intel.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 2/3] usb: typec: ucsi: Update connector cap and status
Date: Fri,  9 Feb 2024 14:37:31 -0800
Message-ID: <20240209143723.v5.2.I3d909e3c9a200621e3034686f068a3307945fd87@changeid>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
In-Reply-To: <20240209223824.622869-1-abhishekpandit@chromium.org>
References: <20240209223824.622869-1-abhishekpandit@chromium.org>
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

(no changes since v4)

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


