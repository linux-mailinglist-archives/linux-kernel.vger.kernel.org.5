Return-Path: <linux-kernel+bounces-123239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60F89890509
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 17:23:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15F17298F03
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 16:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19B1C1327F5;
	Thu, 28 Mar 2024 16:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qWBAGCON"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61ABF1311B8;
	Thu, 28 Mar 2024 16:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711642927; cv=none; b=kBE6yFLhTWN0EkCpQBrHWsWOSvfY8AGqWJ/0gaoKM96F3C4Jl+bSnp3zxw3qVeIWtSP3JcPC9sQ8VlWdavJsl561tEq3mkL1KVNj+o8QX5ortMy6qR2WMun19OGLiZ1pcuMblTWRDdZRNfF+9VVwGDkSpmGRYVLYwAlYpcVaIOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711642927; c=relaxed/simple;
	bh=9i/j6Kd9Cf5Q18SStkolhdqkZ+7IDboxbiGNwYw/hN0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eApRmeDSd27fyeTpfIc1aNt+O8YaEriqtTIxT+wBd4RDJR10XVVzXEscGTCvoeLgH8jiYGUSFynUERg5zlruNB/h9O92oL1EIcWr253qFZVK3jFUF/dhfq3o6tnyRZfQAhZilS1/mqiin2MM2CKikPtUCbJ3lAOhU4C/M4W2W/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qWBAGCON; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 00485C433C7;
	Thu, 28 Mar 2024 16:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711642927;
	bh=9i/j6Kd9Cf5Q18SStkolhdqkZ+7IDboxbiGNwYw/hN0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=qWBAGCONzFqUdjU2qsIT/Ukp4tsWgbsql4h9crftd2uz2qMhMOo+qStsZliVHrNiW
	 bIZntan1dNm/hAHjZ5pWWHdaOq0uqQltcAjm6rDBRpSORyA1BxHgH7KgHAdUY9+BV6
	 86sRxN+DgpzGzE2QAkHN/wSkQRlwSI5PJGtelIaCHL980JvP536uW3m5R/lFy4Na9e
	 JKR/AlRrj4Noc0S8EO1G1pfrsnVglwq7zqvh4Y5eT4iOY5NNe7qHTutMyCkEanHCP/
	 MCoTRsymaUvGdz6fkJQ4G+HpTynD3ApVbUH8pemyrih1vcjlqZhgeYWdUXp9908fJE
	 +T2/yEgfK8Zqw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3D19CD1288;
	Thu, 28 Mar 2024 16:22:06 +0000 (UTC)
From: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Date: Thu, 28 Mar 2024 17:22:02 +0100
Subject: [PATCH v4 2/6] iio: temperature: ltc2983: convert to
 dev_err_probe()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240328-ltc2983-misc-improv-v4-2-0cc428c07cd5@analog.com>
References: <20240328-ltc2983-misc-improv-v4-0-0cc428c07cd5@analog.com>
In-Reply-To: <20240328-ltc2983-misc-improv-v4-0-0cc428c07cd5@analog.com>
To: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org
Cc: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Olivier Moysan <olivier.moysan@foss.st.com>, 
 Jyoti Bhayana <jbhayana@google.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711642925; l=19092;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=p7rra+d/iE4ivxuEmfElqbM0Q9Z+oVixbVj1b4czt8A=;
 b=TVsFsE5w2JGPQLASdXeKu3VTXkYnlPBfU8BQf0APKUd4weIJYzGoqZw/dyVjHiDnDH3PB42Jg
 yEtU/jGVWyCAXV1iCbb9L3f7kDaCiw0NVq2U4J/+MKPc/SJNP6x4z7A
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-Endpoint-Received: by B4 Relay for nuno.sa@analog.com/20231116 with
 auth_id=100
X-Original-From: Nuno Sa <nuno.sa@analog.com>
Reply-To: nuno.sa@analog.com

From: Nuno Sa <nuno.sa@analog.com>

Use dev_err_probe() in the probe() path. While at it, made some simple
improvements:
 * Declare a struct device *dev helper. This also makes the style more
   consistent (some places the helper was used and not in other places);
 * Explicitly included the err.h and errno.h headers;
 * Removed an useless else if();
 * Removed some unnecessary line breaks.

Signed-off-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/iio/temperature/ltc2983.c | 255 +++++++++++++++++---------------------
 1 file changed, 115 insertions(+), 140 deletions(-)

diff --git a/drivers/iio/temperature/ltc2983.c b/drivers/iio/temperature/ltc2983.c
index 3c4524d57b8e..b4a8ca36458a 100644
--- a/drivers/iio/temperature/ltc2983.c
+++ b/drivers/iio/temperature/ltc2983.c
@@ -8,6 +8,8 @@
 #include <linux/bitfield.h>
 #include <linux/completion.h>
 #include <linux/device.h>
+#include <linux/err.h>
+#include <linux/errno.h>
 #include <linux/kernel.h>
 #include <linux/iio/iio.h>
 #include <linux/interrupt.h>
@@ -657,10 +659,11 @@ ltc2983_thermocouple_new(const struct fwnode_handle *child, struct ltc2983_data
 			 const struct ltc2983_sensor *sensor)
 {
 	struct ltc2983_thermocouple *thermo;
+	struct device *dev = &st->spi->dev;
 	u32 oc_current;
 	int ret;
 
-	thermo = devm_kzalloc(&st->spi->dev, sizeof(*thermo), GFP_KERNEL);
+	thermo = devm_kzalloc(dev, sizeof(*thermo), GFP_KERNEL);
 	if (!thermo)
 		return ERR_PTR(-ENOMEM);
 
@@ -687,21 +690,19 @@ ltc2983_thermocouple_new(const struct fwnode_handle *child, struct ltc2983_data
 					LTC2983_THERMOCOUPLE_OC_CURR(3);
 			break;
 		default:
-			dev_err(&st->spi->dev,
-				"Invalid open circuit current:%u", oc_current);
-			return ERR_PTR(-EINVAL);
+			return dev_errp_probe(dev, -EINVAL,
+					      "Invalid open circuit current:%u",
+					      oc_current);
 		}
 
 		thermo->sensor_config |= LTC2983_THERMOCOUPLE_OC_CHECK(1);
 	}
 	/* validate channel index */
 	if (!(thermo->sensor_config & LTC2983_THERMOCOUPLE_DIFF_MASK) &&
-	    sensor->chan < LTC2983_DIFFERENTIAL_CHAN_MIN) {
-		dev_err(&st->spi->dev,
-			"Invalid chann:%d for differential thermocouple",
-			sensor->chan);
-		return ERR_PTR(-EINVAL);
-	}
+	    sensor->chan < LTC2983_DIFFERENTIAL_CHAN_MIN)
+		return dev_errp_probe(dev, -EINVAL,
+				      "Invalid chann:%d for differential thermocouple",
+				      sensor->chan);
 
 	struct fwnode_handle *ref __free(fwnode_handle) =
 		fwnode_find_reference(child, "adi,cold-junction-handle", 0);
@@ -709,14 +710,13 @@ ltc2983_thermocouple_new(const struct fwnode_handle *child, struct ltc2983_data
 		ref = NULL;
 	} else {
 		ret = fwnode_property_read_u32(ref, "reg", &thermo->cold_junction_chan);
-		if (ret) {
+		if (ret)
 			/*
 			 * This would be catched later but we can just return
 			 * the error right away.
 			 */
-			dev_err(&st->spi->dev, "Property reg must be given\n");
-			return ERR_PTR(ret);
-		}
+			return dev_errp_probe(dev, ret,
+					      "Property reg must be given\n");
 	}
 
 	/* check custom sensor */
@@ -752,16 +752,14 @@ ltc2983_rtd_new(const struct fwnode_handle *child, struct ltc2983_data *st,
 
 	struct fwnode_handle *ref __free(fwnode_handle) =
 		fwnode_find_reference(child, "adi,rsense-handle", 0);
-	if (IS_ERR(ref)) {
-		dev_err(dev, "Property adi,rsense-handle missing or invalid");
-		return ERR_CAST(ref);
-	}
+	if (IS_ERR(ref))
+		return dev_errp_probe(dev, PTR_ERR(ref),
+				      "Property adi,rsense-handle missing or invalid");
 
 	ret = fwnode_property_read_u32(ref, "reg", &rtd->r_sense_chan);
-	if (ret) {
-		dev_err(dev, "Property reg must be given\n");
-		return ERR_PTR(ret);
-	}
+	if (ret)
+		return dev_errp_probe(dev, ret,
+				      "Property reg must be given\n");
 
 	ret = fwnode_property_read_u32(child, "adi,number-of-wires", &n_wires);
 	if (!ret) {
@@ -780,19 +778,19 @@ ltc2983_rtd_new(const struct fwnode_handle *child, struct ltc2983_data *st,
 			rtd->sensor_config = LTC2983_RTD_N_WIRES(3);
 			break;
 		default:
-			dev_err(dev, "Invalid number of wires:%u\n", n_wires);
-			return ERR_PTR(-EINVAL);
+			return dev_errp_probe(dev, -EINVAL,
+					      "Invalid number of wires:%u\n",
+					      n_wires);
 		}
 	}
 
 	if (fwnode_property_read_bool(child, "adi,rsense-share")) {
 		/* Current rotation is only available with rsense sharing */
 		if (fwnode_property_read_bool(child, "adi,current-rotate")) {
-			if (n_wires == 2 || n_wires == 3) {
-				dev_err(dev,
-					"Rotation not allowed for 2/3 Wire RTDs");
-				return ERR_PTR(-EINVAL);
-			}
+			if (n_wires == 2 || n_wires == 3)
+				return dev_errp_probe(dev, -EINVAL,
+						      "Rotation not allowed for 2/3 Wire RTDs");
+
 			rtd->sensor_config |= LTC2983_RTD_C_ROTATE(1);
 		} else {
 			rtd->sensor_config |= LTC2983_RTD_R_SHARE(1);
@@ -815,29 +813,22 @@ ltc2983_rtd_new(const struct fwnode_handle *child, struct ltc2983_data *st,
 
 		if (((rtd->sensor_config & LTC2983_RTD_KELVIN_R_SENSE_MASK)
 		     == LTC2983_RTD_KELVIN_R_SENSE_MASK) &&
-		    (rtd->r_sense_chan <=  min)) {
+		    (rtd->r_sense_chan <=  min))
 			/* kelvin rsense*/
-			dev_err(dev,
-				"Invalid rsense chann:%d to use in kelvin rsense",
-				rtd->r_sense_chan);
+			return dev_errp_probe(dev, -EINVAL,
+					      "Invalid rsense chann:%d to use in kelvin rsense",
+					      rtd->r_sense_chan);
 
-			return ERR_PTR(-EINVAL);
-		}
-
-		if (sensor->chan < min || sensor->chan > max) {
-			dev_err(dev, "Invalid chann:%d for the rtd config",
-				sensor->chan);
-
-			return ERR_PTR(-EINVAL);
-		}
+		if (sensor->chan < min || sensor->chan > max)
+			return dev_errp_probe(dev, -EINVAL,
+					      "Invalid chann:%d for the rtd config",
+					      sensor->chan);
 	} else {
 		/* same as differential case */
-		if (sensor->chan < LTC2983_DIFFERENTIAL_CHAN_MIN) {
-			dev_err(&st->spi->dev,
-				"Invalid chann:%d for RTD", sensor->chan);
-
-			return ERR_PTR(-EINVAL);
-		}
+		if (sensor->chan < LTC2983_DIFFERENTIAL_CHAN_MIN)
+			return dev_errp_probe(dev, -EINVAL,
+					      "Invalid chann:%d for RTD",
+					      sensor->chan);
 	}
 
 	/* check custom sensor */
@@ -885,10 +876,9 @@ ltc2983_rtd_new(const struct fwnode_handle *child, struct ltc2983_data *st,
 			rtd->excitation_current = 0x08;
 			break;
 		default:
-			dev_err(&st->spi->dev,
-				"Invalid value for excitation current(%u)",
-				excitation_current);
-			return ERR_PTR(-EINVAL);
+			return dev_errp_probe(dev, -EINVAL,
+					      "Invalid value for excitation current(%u)",
+					      excitation_current);
 		}
 	}
 
@@ -912,16 +902,14 @@ ltc2983_thermistor_new(const struct fwnode_handle *child, struct ltc2983_data *s
 
 	struct fwnode_handle *ref __free(fwnode_handle) =
 		fwnode_find_reference(child, "adi,rsense-handle", 0);
-	if (IS_ERR(ref)) {
-		dev_err(dev, "Property adi,rsense-handle missing or invalid");
-		return ERR_CAST(ref);
-	}
+	if (IS_ERR(ref))
+		return dev_errp_probe(dev, PTR_ERR(ref),
+				      "Property adi,rsense-handle missing or invalid");
 
 	ret = fwnode_property_read_u32(ref, "reg", &thermistor->r_sense_chan);
-	if (ret) {
-		dev_err(dev, "rsense channel must be configured...\n");
-		return ERR_PTR(ret);
-	}
+	if (ret)
+		return dev_errp_probe(dev, ret,
+				      "rsense channel must be configured...\n");
 
 	if (fwnode_property_read_bool(child, "adi,single-ended")) {
 		thermistor->sensor_config = LTC2983_THERMISTOR_SGL(1);
@@ -936,12 +924,10 @@ ltc2983_thermistor_new(const struct fwnode_handle *child, struct ltc2983_data *s
 	}
 	/* validate channel index */
 	if (!(thermistor->sensor_config & LTC2983_THERMISTOR_DIFF_MASK) &&
-	    sensor->chan < LTC2983_DIFFERENTIAL_CHAN_MIN) {
-		dev_err(&st->spi->dev,
-			"Invalid chann:%d for differential thermistor",
-			sensor->chan);
-		return ERR_PTR(-EINVAL);
-	}
+	    sensor->chan < LTC2983_DIFFERENTIAL_CHAN_MIN)
+		return dev_errp_probe(dev, -EINVAL,
+				      "Invalid chann:%d for differential thermistor",
+				      sensor->chan);
 
 	/* check custom sensor */
 	if (sensor->type >= LTC2983_SENSOR_THERMISTOR_STEINHART) {
@@ -980,12 +966,10 @@ ltc2983_thermistor_new(const struct fwnode_handle *child, struct ltc2983_data *s
 		switch (excitation_current) {
 		case 0:
 			/* auto range */
-			if (sensor->type >=
-			    LTC2983_SENSOR_THERMISTOR_STEINHART) {
-				dev_err(&st->spi->dev,
-					"Auto Range not allowed for custom sensors\n");
-				return ERR_PTR(-EINVAL);
-			}
+			if (sensor->type >= LTC2983_SENSOR_THERMISTOR_STEINHART)
+				return dev_errp_probe(dev, -EINVAL,
+						      "Auto Range not allowed for custom sensors\n");
+
 			thermistor->excitation_current = 0x0c;
 			break;
 		case 250:
@@ -1022,10 +1006,9 @@ ltc2983_thermistor_new(const struct fwnode_handle *child, struct ltc2983_data *s
 			thermistor->excitation_current = 0x0b;
 			break;
 		default:
-			dev_err(&st->spi->dev,
-				"Invalid value for excitation current(%u)",
-				excitation_current);
-			return ERR_PTR(-EINVAL);
+			return dev_errp_probe(dev, -EINVAL,
+					      "Invalid value for excitation current(%u)",
+					      excitation_current);
 		}
 	}
 
@@ -1036,11 +1019,12 @@ static struct ltc2983_sensor *
 ltc2983_diode_new(const struct fwnode_handle *child, const struct ltc2983_data *st,
 		  const struct ltc2983_sensor *sensor)
 {
+	struct device *dev = &st->spi->dev;
 	struct ltc2983_diode *diode;
 	u32 temp = 0, excitation_current = 0;
 	int ret;
 
-	diode = devm_kzalloc(&st->spi->dev, sizeof(*diode), GFP_KERNEL);
+	diode = devm_kzalloc(dev, sizeof(*diode), GFP_KERNEL);
 	if (!diode)
 		return ERR_PTR(-ENOMEM);
 
@@ -1055,12 +1039,11 @@ ltc2983_diode_new(const struct fwnode_handle *child, const struct ltc2983_data *
 
 	/* validate channel index */
 	if (!(diode->sensor_config & LTC2983_DIODE_DIFF_MASK) &&
-	    sensor->chan < LTC2983_DIFFERENTIAL_CHAN_MIN) {
-		dev_err(&st->spi->dev,
-			"Invalid chann:%d for differential thermistor",
-			sensor->chan);
-		return ERR_PTR(-EINVAL);
-	}
+	    sensor->chan < LTC2983_DIFFERENTIAL_CHAN_MIN)
+		return dev_errp_probe(dev, -EINVAL,
+				      "Invalid chann:%d for differential thermistor",
+				      sensor->chan);
+
 	/* set common parameters */
 	diode->sensor.fault_handler = ltc2983_common_fault_handler;
 	diode->sensor.assign_chan = ltc2983_diode_assign_chan;
@@ -1082,10 +1065,9 @@ ltc2983_diode_new(const struct fwnode_handle *child, const struct ltc2983_data *
 			diode->excitation_current = 0x03;
 			break;
 		default:
-			dev_err(&st->spi->dev,
-				"Invalid value for excitation current(%u)",
-				excitation_current);
-			return ERR_PTR(-EINVAL);
+			return dev_errp_probe(dev, -EINVAL,
+					      "Invalid value for excitation current(%u)",
+					      excitation_current);
 		}
 	}
 
@@ -1101,26 +1083,26 @@ static struct ltc2983_sensor *ltc2983_r_sense_new(struct fwnode_handle *child,
 					struct ltc2983_data *st,
 					const struct ltc2983_sensor *sensor)
 {
+	struct device *dev = &st->spi->dev;
 	struct ltc2983_rsense *rsense;
 	int ret;
 	u32 temp;
 
-	rsense = devm_kzalloc(&st->spi->dev, sizeof(*rsense), GFP_KERNEL);
+	rsense = devm_kzalloc(dev, sizeof(*rsense), GFP_KERNEL);
 	if (!rsense)
 		return ERR_PTR(-ENOMEM);
 
 	/* validate channel index */
-	if (sensor->chan < LTC2983_DIFFERENTIAL_CHAN_MIN) {
-		dev_err(&st->spi->dev, "Invalid chann:%d for r_sense",
-			sensor->chan);
-		return ERR_PTR(-EINVAL);
-	}
+	if (sensor->chan < LTC2983_DIFFERENTIAL_CHAN_MIN)
+		return dev_errp_probe(dev, -EINVAL,
+				      "Invalid chann:%d for r_sense",
+				      sensor->chan);
 
 	ret = fwnode_property_read_u32(child, "adi,rsense-val-milli-ohms", &temp);
-	if (ret) {
-		dev_err(&st->spi->dev, "Property adi,rsense-val-milli-ohms missing\n");
-		return ERR_PTR(-EINVAL);
-	}
+	if (ret)
+		return dev_errp_probe(dev, -EINVAL,
+				      "Property adi,rsense-val-milli-ohms missing\n");
+
 	/*
 	 * Times 1000 because we have milli-ohms and __convert_to_raw
 	 * expects scales of 1000000 which are used for all other
@@ -1139,21 +1121,21 @@ static struct ltc2983_sensor *ltc2983_adc_new(struct fwnode_handle *child,
 					 struct ltc2983_data *st,
 					 const struct ltc2983_sensor *sensor)
 {
+	struct device *dev = &st->spi->dev;
 	struct ltc2983_adc *adc;
 
-	adc = devm_kzalloc(&st->spi->dev, sizeof(*adc), GFP_KERNEL);
+	adc = devm_kzalloc(dev, sizeof(*adc), GFP_KERNEL);
 	if (!adc)
 		return ERR_PTR(-ENOMEM);
 
 	if (fwnode_property_read_bool(child, "adi,single-ended"))
 		adc->single_ended = true;
 
-	if (!adc->single_ended &&
-	    sensor->chan < LTC2983_DIFFERENTIAL_CHAN_MIN) {
-		dev_err(&st->spi->dev, "Invalid chan:%d for differential adc\n",
-			sensor->chan);
-		return ERR_PTR(-EINVAL);
-	}
+	if (!adc->single_ended && sensor->chan < LTC2983_DIFFERENTIAL_CHAN_MIN)
+		return dev_errp_probe(dev, -EINVAL,
+				      "Invalid chan:%d for differential adc\n",
+				      sensor->chan);
+
 	/* set common parameters */
 	adc->sensor.assign_chan = ltc2983_adc_assign_chan;
 	adc->sensor.fault_handler = ltc2983_common_fault_handler;
@@ -1165,21 +1147,20 @@ static struct ltc2983_sensor *ltc2983_temp_new(struct fwnode_handle *child,
 					       struct ltc2983_data *st,
 					       const struct ltc2983_sensor *sensor)
 {
+	struct device *dev = &st->spi->dev;
 	struct ltc2983_temp *temp;
 
-	temp = devm_kzalloc(&st->spi->dev, sizeof(*temp), GFP_KERNEL);
+	temp = devm_kzalloc(dev, sizeof(*temp), GFP_KERNEL);
 	if (!temp)
 		return ERR_PTR(-ENOMEM);
 
 	if (fwnode_property_read_bool(child, "adi,single-ended"))
 		temp->single_ended = true;
 
-	if (!temp->single_ended &&
-	    sensor->chan < LTC2983_DIFFERENTIAL_CHAN_MIN) {
-		dev_err(&st->spi->dev, "Invalid chan:%d for differential temp\n",
-			sensor->chan);
-		return ERR_PTR(-EINVAL);
-	}
+	if (!temp->single_ended && sensor->chan < LTC2983_DIFFERENTIAL_CHAN_MIN)
+		return dev_errp_probe(dev, -EINVAL,
+				      "Invalid chan:%d for differential temp\n",
+				      sensor->chan);
 
 	temp->custom = __ltc2983_custom_sensor_new(st, child, "adi,custom-temp",
 						   false, 4096, true);
@@ -1329,10 +1310,9 @@ static int ltc2983_parse_fw(struct ltc2983_data *st)
 	device_property_read_u32(dev, "adi,filter-notch-freq", &st->filter_notch_freq);
 
 	st->num_channels = device_get_child_node_count(dev);
-	if (!st->num_channels) {
-		dev_err(&st->spi->dev, "At least one channel must be given!");
-		return -EINVAL;
-	}
+	if (!st->num_channels)
+		return dev_err_probe(dev, -EINVAL,
+				     "At least one channel must be given!");
 
 	st->sensors = devm_kcalloc(dev, st->num_channels, sizeof(*st->sensors),
 				   GFP_KERNEL);
@@ -1419,6 +1399,7 @@ static int ltc2983_eeprom_cmd(struct ltc2983_data *st, unsigned int cmd,
 			      unsigned int wait_time, unsigned int status_reg,
 			      unsigned long status_fail_mask)
 {
+	struct device *dev = &st->spi->dev;
 	unsigned long time;
 	unsigned int val;
 	int ret;
@@ -1437,19 +1418,16 @@ static int ltc2983_eeprom_cmd(struct ltc2983_data *st, unsigned int cmd,
 
 	time = wait_for_completion_timeout(&st->completion,
 					   msecs_to_jiffies(wait_time));
-	if (!time) {
-		dev_err(&st->spi->dev, "EEPROM command timed out\n");
-		return -ETIMEDOUT;
-	}
+	if (!time)
+		return dev_err_probe(dev, -ETIMEDOUT, "EEPROM command timed out\n");
 
 	ret = regmap_read(st->regmap, status_reg, &val);
 	if (ret)
 		return ret;
 
-	if (val & status_fail_mask) {
-		dev_err(&st->spi->dev, "EEPROM command failed: 0x%02X\n", val);
-		return -EINVAL;
-	}
+	if (val & status_fail_mask)
+		return dev_err_probe(dev, -EINVAL,
+				     "EEPROM command failed: 0x%02X\n", val);
 
 	return 0;
 }
@@ -1457,16 +1435,15 @@ static int ltc2983_eeprom_cmd(struct ltc2983_data *st, unsigned int cmd,
 static int ltc2983_setup(struct ltc2983_data *st, bool assign_iio)
 {
 	u32 iio_chan_t = 0, iio_chan_v = 0, chan, iio_idx = 0, status;
+	struct device *dev = &st->spi->dev;
 	int ret;
 
 	/* make sure the device is up: start bit (7) is 0 and done bit (6) is 1 */
 	ret = regmap_read_poll_timeout(st->regmap, LTC2983_STATUS_REG, status,
 				       LTC2983_STATUS_UP(status) == 1, 25000,
 				       25000 * 10);
-	if (ret) {
-		dev_err(&st->spi->dev, "Device startup timed out\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "Device startup timed out\n");
 
 	ret = regmap_update_bits(st->regmap, LTC2983_GLOBAL_CONFIG_REG,
 				 LTC2983_NOTCH_FREQ_MASK,
@@ -1566,12 +1543,13 @@ static const struct  iio_info ltc2983_iio_info = {
 
 static int ltc2983_probe(struct spi_device *spi)
 {
+	struct device *dev = &spi->dev;
 	struct ltc2983_data *st;
 	struct iio_dev *indio_dev;
 	struct gpio_desc *gpio;
 	int ret;
 
-	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
 	if (!indio_dev)
 		return -ENOMEM;
 
@@ -1582,10 +1560,9 @@ static int ltc2983_probe(struct spi_device *spi)
 		return -ENODEV;
 
 	st->regmap = devm_regmap_init_spi(spi, &ltc2983_regmap_config);
-	if (IS_ERR(st->regmap)) {
-		dev_err(&spi->dev, "Failed to initialize regmap\n");
-		return PTR_ERR(st->regmap);
-	}
+	if (IS_ERR(st->regmap))
+		return dev_err_probe(dev, PTR_ERR(st->regmap),
+				     "Failed to initialize regmap\n");
 
 	mutex_init(&st->lock);
 	init_completion(&st->completion);
@@ -1597,7 +1574,7 @@ static int ltc2983_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 
-	gpio = devm_gpiod_get_optional(&st->spi->dev, "reset", GPIOD_OUT_HIGH);
+	gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
 	if (IS_ERR(gpio))
 		return PTR_ERR(gpio);
 
@@ -1607,7 +1584,7 @@ static int ltc2983_probe(struct spi_device *spi)
 		gpiod_set_value_cansleep(gpio, 0);
 	}
 
-	st->iio_chan = devm_kzalloc(&spi->dev,
+	st->iio_chan = devm_kzalloc(dev,
 				    st->iio_channels * sizeof(*st->iio_chan),
 				    GFP_KERNEL);
 	if (!st->iio_chan)
@@ -1617,12 +1594,10 @@ static int ltc2983_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 
-	ret = devm_request_irq(&spi->dev, spi->irq, ltc2983_irq_handler,
+	ret = devm_request_irq(dev, spi->irq, ltc2983_irq_handler,
 			       IRQF_TRIGGER_RISING, st->info->name, st);
-	if (ret) {
-		dev_err(&spi->dev, "failed to request an irq, %d", ret);
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to request an irq\n");
 
 	if (st->info->has_eeprom) {
 		ret = ltc2983_eeprom_cmd(st, LTC2983_EEPROM_WRITE_CMD,
@@ -1639,7 +1614,7 @@ static int ltc2983_probe(struct spi_device *spi)
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->info = &ltc2983_iio_info;
 
-	return devm_iio_device_register(&spi->dev, indio_dev);
+	return devm_iio_device_register(dev, indio_dev);
 }
 
 static int ltc2983_resume(struct device *dev)

-- 
2.44.0



