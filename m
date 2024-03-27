Return-Path: <linux-kernel+bounces-122157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BE7588F2DF
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 00:20:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EC4F29C9A1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 23:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 895C215573D;
	Wed, 27 Mar 2024 23:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="gdYn2HNs"
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EEC9154C08
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 23:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711581548; cv=none; b=PoX4E20rr/ffaB3vDhgvTJ0hWibRi9SaEOVP2+9aEF+uvQ58JVKncG1CX0rdNRqjgGu/rAqpG31Ffdi4bNsfKFdYvvqmISwg3rBFDwL2lhFyLYfg5SFKLIhTCMBGvh/wEE2ZTZqkQwC4to1fyLuvezm4gYqkD8YilFNfwnWZWsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711581548; c=relaxed/simple;
	bh=ly8n7SxGz9Lf2EUP25mArGs3mqGcGcPAZGBiTMozfFk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CPkemTlli70vRXCnPxD+G/13cTGOX53nK9WeGfSD/AkkOq4ljKQziqnnDMWnI8IIaYSbevIZQsL3h7IM8mE5ELC//bETwK2yY0G6QLRrB9SHbZ9/bml1ujgJuOZkmifUehUCZYNUnyTYOBwrVl7EIPR30xAUU2BhAiJzzAIJ0M4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=gdYn2HNs; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-221e6bf537dso253424fac.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 16:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1711581544; x=1712186344; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PE6UqUKX3G/FV5HVYmxMOtqukpZG7UeidX96eu+NYsg=;
        b=gdYn2HNs6K4qNEtXCegpSeDGvDV8ACFqhl6Vw7p9/9Zn5KL7U7CJyRzv4oEUP2PMR5
         AKCmYlJhBTSAEsxYPxJ86q1ivvhTcUFZgFSuV1IOS2YTJQbS6t4gfXZsaVYvLW/gd4V3
         +BaPLv351a9TJ3oTxqqzPeBLOMFKo/+DCu++5GtOZgLvE4O+LnX8bKtlgWbIofTNmSrR
         WFdGNJqz2nZWysZ1zrflE6XVoa8EvSoGsQmeFNaYFRevPflnCftuprK54+Sjn4WRyxG3
         p7QvTOg4/8kuwS5Y2OKt/x6LHKoBihgpkdzBouj2haJea7QiHmCDPVHWIBMJGbX7EyDr
         Jy2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711581544; x=1712186344;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PE6UqUKX3G/FV5HVYmxMOtqukpZG7UeidX96eu+NYsg=;
        b=bvAdHKaZOO3YUFpTf6wA7TaX2ZkhHBYF7DYot3+ewgDvzvsu1PwFhyUZm/ZjTcVAtJ
         2oDMTs+zI+nIO64ZF5pXG53659M/OaV4F0VNZ19VXqlIqv3evb6tzWSXtqeD9EELwBPB
         G4GlRyxoFvrm0j9RGn1Ucn7Tf26lx4XlUvDxmylRfXzAWs3ZIBYezse55CmvuQHkEBJR
         RRJ/Dg4p/iElbg2fEX4tcG0XAMfP0Q3ZjwJNaTTAJct2JPf+fS/+HwBymaPhhz/oY2sl
         1OnnFqMhayNdrK+X1q29MktW+IcxHfZ31UHF0nVJkCBmOGXkERF6MrHqqybKL4Podhzo
         kgsw==
X-Forwarded-Encrypted: i=1; AJvYcCWkv3DZAm6cIoWau2BHYVwQIokedX4EseGK2zAQLp/exQUvQlu50nnr/P+QZfHJLXK7J+5Ju62GZ/Pcx6bNxiWmTh01GbFrmDw4h/FW
X-Gm-Message-State: AOJu0YyxwsgnwlR/7QV7EXTxlB979digt5lOB/GbBLLGTkuKk/AkstnL
	ykQ8ID5zdkM+4MqL4ZKx9ipvLELthQjKho1gYGrHiGm63Gc2fxp8QI9y/vy5VeHuEz4UzD4DfOw
	G
X-Google-Smtp-Source: AGHT+IEoTHHATEQkuJa2BbeiTLbiTgSE1yaSMq5ULG3gGF3llvbq0XtMCg26/o3L5+Q/P6Gnym6iXw==
X-Received: by 2002:a05:6870:7d19:b0:22a:5690:f056 with SMTP id os25-20020a0568707d1900b0022a5690f056mr1316238oab.44.1711581543700;
        Wed, 27 Mar 2024 16:19:03 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id js3-20020a056870bac300b0022a0519183csm81381oab.2.2024.03.27.16.19.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 16:19:03 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: Jonathan Corbet <corbet@lwn.net>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Support Opensource <support.opensource@diasemi.com>,
	Cosmin Tanislav <cosmin.tanislav@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-input@vger.kernel.org
Subject: [PATCH RFC 1/7] regulator: devres: add APIs for reference supplies
Date: Wed, 27 Mar 2024 18:18:50 -0500
Message-ID: <20240327-regulator-get-enable-get-votlage-v1-1-5f4517faa059@baylibre.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240327-regulator-get-enable-get-votlage-v1-0-5f4517faa059@baylibre.com>
References: <20240327-regulator-get-enable-get-votlage-v1-0-5f4517faa059@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.4
Content-Transfer-Encoding: 8bit

A common use case for regulators is to supply a reference voltage to an
analog input or output device. This adds two new devres APIs to get,
enable, and get the voltage in a single call. This allows eliminating
boilerplate code in drivers that use reference supplies in this way.

devm_regulator_get_enable_get_voltage() is intended for cases where the
supply is required to provide an external reference voltage.

devm_regulator_get_optional_enable_get_voltage() is intended for cases
where the supply is optional and device typically uses an internal
reference voltage if the supply is not available.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 Documentation/driver-api/driver-model/devres.rst |  2 +
 drivers/regulator/devres.c                       | 83 ++++++++++++++++++++++++
 include/linux/regulator/consumer.h               | 14 ++++
 3 files changed, 99 insertions(+)

diff --git a/Documentation/driver-api/driver-model/devres.rst b/Documentation/driver-api/driver-model/devres.rst
index 7be8b8dd5f00..fd954d09e13c 100644
--- a/Documentation/driver-api/driver-model/devres.rst
+++ b/Documentation/driver-api/driver-model/devres.rst
@@ -433,9 +433,11 @@ REGULATOR
   devm_regulator_bulk_put()
   devm_regulator_get()
   devm_regulator_get_enable()
+  devm_regulator_get_enable_get_voltage()
   devm_regulator_get_enable_optional()
   devm_regulator_get_exclusive()
   devm_regulator_get_optional()
+  devm_regulator_get_optional_enable_get_voltage()
   devm_regulator_irq_helper()
   devm_regulator_put()
   devm_regulator_register()
diff --git a/drivers/regulator/devres.c b/drivers/regulator/devres.c
index 90bb0d178885..e240926defc5 100644
--- a/drivers/regulator/devres.c
+++ b/drivers/regulator/devres.c
@@ -145,6 +145,89 @@ struct regulator *devm_regulator_get_optional(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(devm_regulator_get_optional);
 
+static int _devm_regulator_get_enable_get_voltage(struct device *dev,
+						  const char *id,
+						  bool silent_enodev)
+{
+	struct regulator *r;
+	int ret;
+
+	/*
+	 * Since we need a real voltage, we use devm_regulator_get_optional()
+	 * here to avoid getting a dummy regulator if the supply is not present.
+	 */
+	r = devm_regulator_get_optional(dev, id);
+	if (silent_enodev && PTR_ERR(r) == -ENODEV)
+		return -ENODEV;
+	if (IS_ERR(r))
+		return dev_err_probe(dev, PTR_ERR(r),
+				     "failed to get regulator '%s'\n", id);
+
+	ret = regulator_enable(r);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "failed to enable regulator '%s'\n", id);
+
+	ret = devm_add_action_or_reset(dev, regulator_action_disable, r);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "failed to add disable action for regulator '%s'\n",
+				     id);
+
+	ret = regulator_get_voltage(r);
+	if (ret < 0)
+		return dev_err_probe(dev, ret,
+				     "failed to get voltage for regulator '%s'\n",
+				     id);
+
+	return ret;
+}
+
+/**
+ * devm_regulator_get_enable_get_voltage - Resource managed regulator get and
+ *                                         enable that returns the voltage
+ * @dev: device to supply
+ * @id:  supply name or regulator ID.
+ *
+ * Get and enable regulator for duration of the device life-time.
+ * regulator_disable() and regulator_put() are automatically called on driver
+ * detach. See regulator_get_optional(), regulator_enable(), and
+ * regulator_get_voltage() for more information.
+ *
+ * This is a convenience function for supplies that provide a reference voltage
+ * where the consumer driver just needs to know the voltage and keep the
+ * regulator enabled. Also, as a convenience, this prints error messages on
+ * failure.
+ *
+ * Returns: voltage in microvolts on success, or an error code on failure.
+ */
+int devm_regulator_get_enable_get_voltage(struct device *dev, const char *id)
+{
+	return _devm_regulator_get_enable_get_voltage(dev, id, false);
+}
+EXPORT_SYMBOL_GPL(devm_regulator_get_enable_get_voltage);
+
+/**
+ * devm_regulator_get_optional_enable_get_voltage - Resource managed regulator
+ *                                                  get and enable that returns
+ *                                                  the voltage
+ * @dev: device to supply
+ * @id:  supply name or regulator ID.
+ *
+ * This function is identical to devm_regulator_get_enable_get_voltage() except
+ * that it does not print an error message in the case of -ENODEV. Callers are
+ * expected to handle -ENODEV as a special case instead of passing it on as an
+ * error.
+ *
+ * Returns: voltage in microvolts on success, or an error code on failure.
+ */
+int devm_regulator_get_optional_enable_get_voltage(struct device *dev,
+						   const char *id)
+{
+	return _devm_regulator_get_enable_get_voltage(dev, id, true);
+}
+EXPORT_SYMBOL_GPL(devm_regulator_get_optional_enable_get_voltage);
+
 static int devm_regulator_match(struct device *dev, void *res, void *data)
 {
 	struct regulator **r = res;
diff --git a/include/linux/regulator/consumer.h b/include/linux/regulator/consumer.h
index 4660582a3302..35596db521a0 100644
--- a/include/linux/regulator/consumer.h
+++ b/include/linux/regulator/consumer.h
@@ -164,6 +164,8 @@ struct regulator *__must_check devm_regulator_get_optional(struct device *dev,
 							   const char *id);
 int devm_regulator_get_enable(struct device *dev, const char *id);
 int devm_regulator_get_enable_optional(struct device *dev, const char *id);
+int devm_regulator_get_enable_get_voltage(struct device *dev, const char *id);
+int devm_regulator_get_optional_enable_get_voltage(struct device *dev, const char *id);
 void regulator_put(struct regulator *regulator);
 void devm_regulator_put(struct regulator *regulator);
 
@@ -329,6 +331,18 @@ static inline int devm_regulator_get_enable_optional(struct device *dev,
 	return -ENODEV;
 }
 
+static inline int devm_regulator_get_enable_get_voltage(struct device *dev,
+							const char *id)
+{
+	return -ENODEV;
+}
+
+static inline int devm_regulator_get_optional_enable_get_voltage(struct device *dev,
+								 const char *id)
+{
+	return -ENODEV;
+}
+
 static inline struct regulator *__must_check
 regulator_get_optional(struct device *dev, const char *id)
 {

-- 
2.43.2


