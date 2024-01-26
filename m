Return-Path: <linux-kernel+bounces-40517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8179883E1CE
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 19:43:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A1BD287B3F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 18:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D909354FB4;
	Fri, 26 Jan 2024 18:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="m9bR1Iqv"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68932224C7
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 18:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706294381; cv=none; b=Ziuw7+3G6lt4azM9uSQMPsr9uGZPfNF7cU7Hd6yRpwm18y933gmNKNRTNC4gi6vTdiFPdKSkHD4FhA22xWn8MO6gMqaAy/PMy9AuPIMYHP1q06aDxPKLRg/d14CZ8YvVYIuA3nqT2odr2NaBBcUIFgpObQFm59LSFdPVDuNwedc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706294381; c=relaxed/simple;
	bh=WS2wYe6S/c+DCMCNP+13L/hCSbu3husS/679bK8KrHI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OGLTRCO1+A7dgHzjOEZJ7eXFE+/Aop429wnTrPLurZ71vVRrtHgVCowWuozOH/RTOQoMczmHzR80MmELqq80tXVyYiPYJYTz3UECyNrWaNcx4/K3RL/DOF+cER//NFO6qrIIASF7AeVqVS3tliBXkAImRg4k3xJ4lH4CwI4N/5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=m9bR1Iqv; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6dddf4fc85dso607145b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 10:39:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706294380; x=1706899180; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U1b6cx5G1n1xjvS7fk7XZQq0rGYbXSd5vf0gWiMPd5c=;
        b=m9bR1Iqv8HMnFAplJms1RyQ8n3z6WbHjrNxf9MOXP8AvJNTQkLJVvnJmzJ65N0Mszf
         yk/hJt0FDby8PoLBcSDpJUY3PQ/g4BNtV2KOERu0PLRS59SW+3NkzJOMz5DEQXDBKf5G
         vkq55z/d3ae3On93Zqmmdm3gJRyUuEGrB3NeE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706294380; x=1706899180;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U1b6cx5G1n1xjvS7fk7XZQq0rGYbXSd5vf0gWiMPd5c=;
        b=BS6N/aUkzkTNUCYjQfgi3pSWSroxPw/SZ33DkMPVCtiIYLkFDoYZmNX8xk7KqfejAt
         5SM4SsJA62c3YNzh/Ict09tSEGXbbO6Y8+kjo2UhIo5f4OojwLrEF2uRM5RvnAQtUK6U
         wEplKiRum1rRN8mC8ylFFaHzSOB0r3TDXdIUHRnzOpMSkmtJ85nl4qSmJBiZMjXNZR7C
         1jMPae0fsDodsH07StKV8WgRA+kkd3YhRIIYmeDmJVoIdtW/1/YWVh1fRWuWyHkuUn69
         oP883pPEc+Atg0vhWgW+pmyTrjZdlPO7CSB0i4MqmeKyQB1ZexeXA6GtKWbP5I/GIgiH
         VtDw==
X-Gm-Message-State: AOJu0YwDh2KCdBxcCqFw5bMjD8x8805YLyWoo7eXxT3+w9zqu//cdxxa
	f2pgWnBpo4HP1kkM8p1P04a2zOUlcnvIiJoZkX0/aROMoNhDCJAONhrzjZ3xvg==
X-Google-Smtp-Source: AGHT+IG4QcXv4005qEUud2yBszhtzIQvO1008BkWeuamxm5ykUAxfEKSr71OU8D4D/kXfp0q/skNUg==
X-Received: by 2002:aa7:9823:0:b0:6db:be80:cad5 with SMTP id q3-20020aa79823000000b006dbbe80cad5mr216612pfl.20.1706294379414;
        Fri, 26 Jan 2024 10:39:39 -0800 (PST)
Received: from localhost (209.148.168.34.bc.googleusercontent.com. [34.168.148.209])
        by smtp.gmail.com with UTF8SMTPSA id n12-20020aa78a4c000000b006ddd2be2169sm1401772pfa.73.2024.01.26.10.39.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jan 2024 10:39:38 -0800 (PST)
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
Subject: [PATCH v3 2/3] usb: typec: ucsi: Update connector cap and status
Date: Fri, 26 Jan 2024 10:39:08 -0800
Message-ID: <20240126103859.v3.2.I3d909e3c9a200621e3034686f068a3307945fd87@changeid>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
In-Reply-To: <20240126183930.1170845-1-abhishekpandit@chromium.org>
References: <20240126183930.1170845-1-abhishekpandit@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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


Changes in v3:
  - Change include to asm/unaligned.h and reorder include.

 drivers/usb/typec/ucsi/ucsi.h | 50 ++++++++++++++++++++++++++++++++---
 1 file changed, 46 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/typec/ucsi/ucsi.h b/drivers/usb/typec/ucsi/ucsi.h
index bec920fa6b8a..1bae4cf8ecdc 100644
--- a/drivers/usb/typec/ucsi/ucsi.h
+++ b/drivers/usb/typec/ucsi/ucsi.h
@@ -10,6 +10,7 @@
 #include <linux/usb/typec.h>
 #include <linux/usb/pd.h>
 #include <linux/usb/role.h>
+#include <asm/unaligned.h>
 
 /* -------------------------------------------------------------------------- */
 
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


