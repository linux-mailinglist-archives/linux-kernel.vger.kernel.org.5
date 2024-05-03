Return-Path: <linux-kernel+bounces-167847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BBF38BB034
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 17:44:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 699A2B21DA8
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 15:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FEAC1553AB;
	Fri,  3 May 2024 15:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EjfgtUOc"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD3EF15535A;
	Fri,  3 May 2024 15:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714751014; cv=none; b=d46VHTHtYgIg0nBWONZphmQKBZq+gyPyb007CzMGMgsglzwxQeK4sPnqWS9UeCjyuC4kVIZSPldQ9hGUa8HW5BjLhEPXr81iLCl5JGU0DQc7bQJ7pZoTqzrjjgejf5F1HIqFCKCza7FbMgTZrZ1czb7xujAwLavODT0FyPIF4bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714751014; c=relaxed/simple;
	bh=hsF+/tVJJISCYvNg4DUZTK5vJ6OtxR+tbIivggjnO/E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IvChDA4Db6oiZQi04c/wR58mLr2UxojB3rJWxbWJdYS9mXKZpgGJo4oftxSF4RZH1eoPlD78OLMOPeOnhsyRh7KSVVoA+4O0D4LByudNNRAEvVFMTzQ4ex3Zm5u7JPyXUDqYFiyPbxW5HnShDJkUvtt/qqLSY0Bhj7kGnB36n2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EjfgtUOc; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6f44b390d5fso827117b3a.3;
        Fri, 03 May 2024 08:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714751011; x=1715355811; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dzTsI8e+Lzphd73AbkWTKyzZRtc6kuRal+eqPrezZos=;
        b=EjfgtUOcZAIpyoKLX1iw8jojUSqqkbGwYXkr9qEfrw+bWxTuW+34B79lfn9BMSDHka
         Qkw5vE1QcFkJJ5FsilC6+MpjhBY+dWUu//xayGG2Z3hLygzbmmjZ5Uip6gyX9tKiWYPp
         pDZjhFtAhSw2DYfb06WLCgQZCI/A/5mWyzeWYh0+35A3s8NVKz9BE3YiI4xlZ7Gw18mM
         PVaiIDDNrJhUMZ91h+fagztUwjfkAG2BfsriE7ErOSvBL/8aSmQqjJc5Y7A2bX1Sk2uq
         O5a0yDWnUJfDxLUceRpxoCJRXdxWpAZC7+stWDIcckoWKe1rUAmhb6852BZjLJP9lCOs
         547w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714751011; x=1715355811;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dzTsI8e+Lzphd73AbkWTKyzZRtc6kuRal+eqPrezZos=;
        b=FvdCidNqxjTdFm7TkBKRD1gPeL2RMbLQPZWJoJCYbNuz7cYBvGdmXUn7kar2Idc9B5
         +Bv91PzWO8zt7TMxqwWOGujKSYfnqLmPKMVQuczytRzQ0dvsny1bFMlGQzjHTUxjfgJb
         pc5Fjggdo4S4IXNpL90M5dj/0w7eB83wTXU3bohPCP2DU/Q/OOwG5dDcTOQUZ2BPuChg
         7ev3+BpiSOQFujw9AJrwXJXQbr+k9SaFUR/wsXxwNupoR/52xXXkiyXlr6o7RJr0pQmN
         iIrLpk1VVW+gtJDr/HT+yPEwVPkFiGqhca38zWIxwIQZsSFOjM1YhyQte9R+WbgOfonx
         tG1A==
X-Gm-Message-State: AOJu0YzNBefBstmJM31Ln1fa378mb0qRc3gsIKpe1BtwVRuU0Lsxxuev
	h1VcQ7LnY/1w/o+LzCQ+/ANCuLxkJ11qCk0p97YETBJq1pxxRIQyxYd03w==
X-Google-Smtp-Source: AGHT+IEC7YH2y5FCfmylVmOuvC8BWy823yPftr2V9+gAKmq0OY8afDQfX6dlkzgM6HcCJcqvBZPstw==
X-Received: by 2002:a17:90b:ecf:b0:2b2:7f91:4e8d with SMTP id gz15-20020a17090b0ecf00b002b27f914e8dmr3387001pjb.6.1714751011255;
        Fri, 03 May 2024 08:43:31 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id pl13-20020a17090b268d00b002aef0fd92f6sm5214221pjb.50.2024.05.03.08.43.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 08:43:30 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: linux-hwmon@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>,
	Lars Petter Mostad <lars.petter.mostad@appear.net>
Subject: [PATCH v2 2/3] hwmon: (emc1403) Support 11 bit accuracy
Date: Fri,  3 May 2024 08:43:23 -0700
Message-Id: <20240503154324.517246-3-linux@roeck-us.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240503154324.517246-1-linux@roeck-us.net>
References: <20240503154324.517246-1-linux@roeck-us.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Various temperature and limit registers support 11 bit accuracy.
Add support for it.

Cc: Lars Petter Mostad <lars.petter.mostad@appear.net>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: Added patch

 drivers/hwmon/emc1403.c | 55 ++++++++++++++++++++++++++++++++++++++---
 1 file changed, 52 insertions(+), 3 deletions(-)

diff --git a/drivers/hwmon/emc1403.c b/drivers/hwmon/emc1403.c
index e656f0432a57..e53bb4d8bc1b 100644
--- a/drivers/hwmon/emc1403.c
+++ b/drivers/hwmon/emc1403.c
@@ -178,17 +178,52 @@ static u8 emc1403_temp_regs[][4] = {
 	},
 };
 
+static s8 emc1403_temp_regs_low[][4] = {
+	[0] = {
+		[temp_min] = -1,
+		[temp_max] = -1,
+		[temp_crit] = -1,
+		[temp_input] = 0x29,
+	},
+	[1] = {
+		[temp_min] = 0x14,
+		[temp_max] = 0x13,
+		[temp_crit] = -1,
+		[temp_input] = 0x10,
+	},
+	[2] = {
+		[temp_min] = 0x18,
+		[temp_max] = 0x17,
+		[temp_crit] = -1,
+		[temp_input] = 0x24,
+	},
+	[3] = {
+		[temp_min] = 0x2f,
+		[temp_max] = 0x2e,
+		[temp_crit] = -1,
+		[temp_input] = 0x2b,
+	},
+};
+
 static int __emc1403_get_temp(struct thermal_data *data, int channel,
 			      enum emc1403_reg_map map, long *val)
 {
 	unsigned int regval;
 	int ret;
+	s8 reg;
 
 	ret = regmap_read(data->regmap, emc1403_temp_regs[channel][map], &regval);
 	if (ret < 0)
 		return ret;
 	*val = regval * 1000;
 
+	reg = emc1403_temp_regs_low[channel][map];
+	if (reg >= 0) {
+		ret = regmap_read(data->regmap, reg, &regval);
+		if (ret < 0)
+			return ret;
+		*val += (regval >> 5) * 125;
+	}
 	return 0;
 }
 
@@ -336,12 +371,26 @@ static int emc1403_set_temp(struct thermal_data *data, int channel,
 {
 	unsigned int regval;
 	int ret;
+	u8 regh;
+	s8 regl;
 
-	val = clamp_val(val, 0, 255000);
+	regh = emc1403_temp_regs[channel][map];
+	regl = emc1403_temp_regs_low[channel][map];
 
 	mutex_lock(&data->mutex);
-	regval = DIV_ROUND_CLOSEST(val, 1000);
-	ret = regmap_write(data->regmap, emc1403_temp_regs[channel][map], regval);
+	if (regl >= 0) {
+		val = clamp_val(val, 0, 255875);
+		regval = DIV_ROUND_CLOSEST(val, 125);
+		ret = regmap_write(data->regmap, regh, regval >> 3);
+		if (ret < 0)
+			goto unlock;
+		ret = regmap_write(data->regmap, regl, (regval & 0x07) << 5);
+	} else {
+		val = clamp_val(val, 0, 255000);
+		regval = DIV_ROUND_CLOSEST(val, 1000);
+		ret = regmap_write(data->regmap, regh, regval);
+	}
+unlock:
 	mutex_unlock(&data->mutex);
 	return ret;
 }
-- 
2.39.2


