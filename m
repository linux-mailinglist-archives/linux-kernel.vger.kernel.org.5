Return-Path: <linux-kernel+bounces-106475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C797287EF1E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 18:44:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E2841F2143E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 17:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A38CD5579C;
	Mon, 18 Mar 2024 17:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b="S3lliHu3"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB7955E41
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 17:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710783860; cv=none; b=f8ItgHd9DkZMzn9leK/SZNM+KI2nFJUuM+aOcQ4/zT86yhQH7AUAlZrnenRlFq6He1l9rsCz7MZkZXhbx59ryLd94fmvuGVL2L4lgCdFc2mA7tqOE+K8fB27F7Wv5FhKyIpK8FhL6tMLaOWD4EIwTXFsRlYwAP42nyVzFMaVhT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710783860; c=relaxed/simple;
	bh=E7XSj0pyzwRnbhEItgfs1Biw2IzEoXA27lamXCSeXf8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NpVwwW4Oy36q/fHhWMxlhlVUsZEmq7JbovfjajVuwrAG3Q7RtaHwEicikFmYR94eEUDphB4wOSfPbb2kJcE9rbubBl6ZNw/Cs9yNHv2W5NLuHL/54BGCKOhGt2ywI6Fxz3Ezy1qhHQXz5KBgU3zWraNzxXgQfdIwKdvPr65YBWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=9elements.com; spf=pass smtp.mailfrom=9elements.com; dkim=pass (2048-bit key) header.d=9elements.com header.i=@9elements.com header.b=S3lliHu3; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=9elements.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=9elements.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a468226e135so387802866b.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 10:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1710783857; x=1711388657; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aWgXcsCIwNB8quceeSPfUi0wO64rrOVtbtRuUW+5aHM=;
        b=S3lliHu3RHcvylU2lSBY393/7ZQfLdQjhDdLyT13hZJNwZRMbVUeZkHOCrq2RPpDQ7
         EsW7sZ2pa65767Va438QsN5gMJxlDC9mFvQ7ub/PeBc47yn5mqUT9jubvgDMxyWmvKnv
         sHJvVSMTsc/h4VkBetxBPicEAC45KGNODAruF1DtEUP1pa9EcES/GBLOoIAm1aYfpAYA
         aMilxdhzAfobZXMzKHgKIv87nHUV0sBFrPj1dxFSXu3XbfHcDwag1j0PwR2q6YvEBP+a
         rFZQtBTOHSld2pO4898nRVbuunNoUwY61W1PeIfGCcr6ZlbhiTua8XzhO+ptGqucqnWW
         MCmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710783857; x=1711388657;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aWgXcsCIwNB8quceeSPfUi0wO64rrOVtbtRuUW+5aHM=;
        b=Z/nDhJmRUK5Y8e9c3sX8nTqL7BtHZOUQxEZWdsf8VdHuXoEEQ0NbSGW4ILpjox/oWE
         Hb6iizlrEX39fAa/Rm/FFee39oJFDXcwJBzFOTsvLhW0avYIPzimhD4qCUU0Aw1OqmQ5
         HAGp4cbPD39R6VDuzN0upUueIDYwcZW7PJC0wJUAFxb82fCRk0ooc7z9toRPIQFIxci1
         neImVDpAA8vvEFr5MtJ8+DT+L7RSvHNv7dSfp107sC5nRrvYMXVgVmfkGsw0W6P9NW33
         3dkBOaz6z53ILjbaJx5nO7cWe6bJsX5tYk6/tBEOWWEXeZZscygSLygUMadYgrLbxuaY
         DFNQ==
X-Forwarded-Encrypted: i=1; AJvYcCWX4WCDU2IUFEE1FYHzOYi2c8DYgMKQyS8vlwLe1w1HQGqj/r3dw8cvvmKBTAwceeSpvLWVzgT9+J2MkXi+it8Vp5Lo4irR2eROKU1I
X-Gm-Message-State: AOJu0YwdLw8ekXoVaeRhXM9Qq4MZgnL05MXyv7x+xu78IsabHr4BynSw
	i7zI5Z/8Lag6atu+PvxLmKApvVnSh/A7Ai54DhCsXSbjwA+c9lg/tyFYcIVN1j8=
X-Google-Smtp-Source: AGHT+IG3vx0ReTieIcSydRi9DPhGpG/POg/ztkcVuM9Rj9eSQTrM0AO5OSat4zJ59NE7k4evhHwDaQ==
X-Received: by 2002:a17:906:f6c6:b0:a46:caa1:3e5b with SMTP id jo6-20020a170906f6c600b00a46caa13e5bmr1772572ejb.41.1710783856917;
        Mon, 18 Mar 2024 10:44:16 -0700 (PDT)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id h21-20020a17090619d500b00a46447348e8sm5071598ejd.191.2024.03.18.10.44.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 10:44:16 -0700 (PDT)
From: Naresh Solanki <naresh.solanki@9elements.com>
To: Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>
Cc: mazziesaccount@gmail.com,
	Patrick Rudolph <patrick.rudolph@9elements.com>,
	Naresh Solanki <naresh.solanki@9elements.com>,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RESEND PATCH v3] hwmon: (pmbus/mp2975) Fix IRQ masking
Date: Mon, 18 Mar 2024 23:14:05 +0530
Message-ID: <20240318174406.3782306-1-naresh.solanki@9elements.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Patrick Rudolph <patrick.rudolph@9elements.com>

The MP2971/MP2973 use a custom 16bit register format for
SMBALERT_MASK which doesn't follow the PMBUS specification.

Map the PMBUS defined bits used by the common code onto the custom
format used by MPS and since the SMBALERT_MASK is currently never read
by common code only implement the mapping for write transactions.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>

---

Changes in V3:
1. Avoid precedence issues in Macro
2. Optimise macro.

Changes in V2:
1. Add/Update comment
2. Update SWAP define to include both variable.
3. Add defines for each bits of SMBALERT mask.
---
 drivers/hwmon/pmbus/mp2975.c | 77 ++++++++++++++++++++++++++++++++++++
 1 file changed, 77 insertions(+)

diff --git a/drivers/hwmon/pmbus/mp2975.c b/drivers/hwmon/pmbus/mp2975.c
index e5fa10b3b8bc..953c02a2aeb5 100644
--- a/drivers/hwmon/pmbus/mp2975.c
+++ b/drivers/hwmon/pmbus/mp2975.c
@@ -392,6 +392,82 @@ static int mp2973_read_word_data(struct i2c_client *client, int page,
 	return ret;
 }
 
+static int mp2973_write_word_data(struct i2c_client *client, int page,
+				  int reg, u16 word)
+{
+	u8 target, mask;
+	int ret;
+
+	if (reg != PMBUS_SMBALERT_MASK)
+		return -ENODATA;
+
+	/*
+	 * Vendor-specific SMBALERT_MASK register with 16 maskable bits.
+	 */
+	ret = pmbus_read_word_data(client, 0, 0, PMBUS_SMBALERT_MASK);
+	if (ret < 0)
+		return ret;
+
+	target = word & 0xff;
+	mask = word >> 8;
+
+/*
+ * Set/Clear 'bit' in 'ret' based on condition followed by define for each bit in SMBALERT_MASK.
+ * Also bit 2 & 15 are reserved.
+ */
+#define SWAP(val, mask, cond, bit) (((mask) & (cond)) ? ((val) & ~BIT(bit)) : ((val) | BIT(bit)))
+
+#define MP2973_TEMP_OT		0
+#define MP2973_VIN_UVLO		1
+#define MP2973_VIN_OVP		3
+#define MP2973_MTP_FAULT	4
+#define MP2973_OTHER_COMM	5
+#define MP2973_MTP_BLK_TRIG	6
+#define MP2973_PACKET_ERROR	7
+#define MP2973_INVALID_DATA	8
+#define MP2973_INVALID_COMMAND	9
+#define MP2973_IOUT_OC_LV	10
+#define MP2973_IOUT_OC		11
+#define MP2973_VOUT_MAX_MIN_WARNING 12
+#define MP2973_VOLTAGE_UV	13
+#define MP2973_VOLTAGE_OV	14
+
+	switch (target) {
+	case PMBUS_STATUS_CML:
+		ret = SWAP(ret, mask, PB_CML_FAULT_INVALID_DATA, MP2973_INVALID_DATA);
+		ret = SWAP(ret, mask, PB_CML_FAULT_INVALID_COMMAND,  MP2973_INVALID_COMMAND);
+		ret = SWAP(ret, mask, PB_CML_FAULT_OTHER_COMM, MP2973_OTHER_COMM);
+		ret = SWAP(ret, mask, PB_CML_FAULT_PACKET_ERROR, MP2973_PACKET_ERROR);
+		break;
+	case PMBUS_STATUS_VOUT:
+		ret = SWAP(ret, mask, PB_VOLTAGE_UV_FAULT, MP2973_VOLTAGE_UV);
+		ret = SWAP(ret, mask, PB_VOLTAGE_OV_FAULT, MP2973_VOLTAGE_OV);
+		break;
+	case PMBUS_STATUS_IOUT:
+		ret = SWAP(ret, mask, PB_IOUT_OC_FAULT, MP2973_IOUT_OC);
+		ret = SWAP(ret, mask, PB_IOUT_OC_LV_FAULT, MP2973_IOUT_OC_LV);
+		break;
+	case PMBUS_STATUS_TEMPERATURE:
+		ret = SWAP(ret, mask, PB_TEMP_OT_FAULT, MP2973_TEMP_OT);
+		break;
+	/*
+	 * Map remaining bits to MFR specific to let the PMBUS core mask
+	 * those bits by default.
+	 */
+	case PMBUS_STATUS_MFR_SPECIFIC:
+		ret = SWAP(ret, mask, BIT(1), MP2973_VIN_UVLO);
+		ret = SWAP(ret, mask, BIT(3), MP2973_VIN_OVP);
+		ret = SWAP(ret, mask, BIT(4), MP2973_MTP_FAULT);
+		ret = SWAP(ret, mask, BIT(6), MP2973_MTP_BLK_TRIG);
+		break;
+	default:
+		return 0;
+	}
+#undef SWAP
+
+	return pmbus_write_word_data(client, 0, PMBUS_SMBALERT_MASK, ret);
+}
+
 static int mp2975_read_word_data(struct i2c_client *client, int page,
 				 int phase, int reg)
 {
@@ -907,6 +983,7 @@ static struct pmbus_driver_info mp2973_info = {
 		PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP | PMBUS_HAVE_POUT |
 		PMBUS_HAVE_PIN | PMBUS_HAVE_STATUS_INPUT,
 	.read_word_data = mp2973_read_word_data,
+	.write_word_data = mp2973_write_word_data,
 #if IS_ENABLED(CONFIG_SENSORS_MP2975_REGULATOR)
 	.num_regulators = 1,
 	.reg_desc = mp2975_reg_desc,

base-commit: 8debe3c1295ef36958dae77487eed9cf6584c008
-- 
2.42.0


