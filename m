Return-Path: <linux-kernel+bounces-36588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46A3383A37B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 08:48:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B5821C28AE8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 07:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8994117C6E;
	Wed, 24 Jan 2024 07:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h0OiU3Tp"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0186517BA9
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 07:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706082348; cv=none; b=FxqyjDicEUeCvDpkEYPfoFo2maJfsSk+ZuP5ef2geXTrLTSwPdbAcrSzdYva1Aou4Dl1c8Y18nm2W6cxfCbSBSctVpZrbtsmP8EXfx/WNTDe5quCXPh2h3Csedht/bjuAY15lFbK0QSNQJdVUg73iyxsOiZxVhLaSlFSBqr52+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706082348; c=relaxed/simple;
	bh=oh0sTMif6CnOQLiL5a5MmyT0hcKnwI/jjGqAII0YSDc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=P4i3nFDFsAv/aTUyVUDLLcfum+WWCFh/EXHcXGVANyPGYzDSG65kqPPhMUUGd7TR69uxZANJm2c0Df9UGy5l4YZeimrKnF7b7YpkQ0rqqZhb5rI6lFmI+Mw7O5mYvqulZT2rFeXJ7IbPkR8bGJOIM/51WyYcZPqbzqv+LDLoKNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=h0OiU3Tp; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-55a354a65afso4468034a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 23:45:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706082345; x=1706687145; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lRX88GpgU1fgsZxup3Gn93xc8N0Fj24AFUmctHwLfn4=;
        b=h0OiU3TpQicg0o3kpaS0v/nI2qe7EBYWo9w/H00iiGH0qw6TggAGYMAAFll2MGZyKT
         XpKErrU/WfdLcbD7gvAIe5op7mQDI8THOBiSXlGNUnhx0EoZF3Slvj+zyHmm397xw9+t
         G5ESlNL0edDsu37+6ECeOG0v1iYWYicC7QXk41n8f/5Lu7sijWTZUfJRgTRFqzywskXF
         LPLewqX2CKUBgbFbyQs3X6lXJV3WiDOiKimD8NvFO2wS0N5U5I2LMUxIB68QH512G84P
         TLkNmMM/bFlv0IXKLdjp0R6qWYcKN+pHBq4tOlTSYepHA2AHzBVzfYkSkOPWTK2Nu9hh
         LkUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706082345; x=1706687145;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lRX88GpgU1fgsZxup3Gn93xc8N0Fj24AFUmctHwLfn4=;
        b=a8254Q6k9w6ngJNz7iTK7Le7Pn05UYqfFXpJLnRyFaE+AOOgpPNZFLVimnVJX/29zz
         Y8pv6cz3wgZZ1kQ/MEFbp0WdcGrFiTjTGnKCF3Hk85eFbd99r/2Cndrl7kPeg+J6hnB4
         nEQKZWAPQbzDIgsITyx20IAC8cphS1+OpsaoxhCSCbBQ/YyZae19PfA9RiIU3N4tCVWv
         JPMCFZyXt6yEM28+cQZVPagPjh/2a1Vrr5rPvi0zRubXDBN+VSHiA/bQIbPCQ3JVFgGC
         P8g725zrhgZkmQpUIHdnCNB5Eb/YARh6Vzn0y9sufDi18vTawCwRX0NCzsCb+efJSp0W
         bJEQ==
X-Gm-Message-State: AOJu0YzVeS3c+rA+//tBKFpv2SPpqnJLY6hgB0sEAtQWsVyIxv26cOcJ
	gSA0k/n4PHrpM6J2LyOKwcZRdoFoOyPPcC/cCC8VwuGZ5UUO5NMGaSmm1YLQQpk=
X-Google-Smtp-Source: AGHT+IHIiivpDee0vXa9Za1ZlMPh5ql9o2I3lx2sDE7uKWnN6FQlUAjNNnKSKOW8KA9hLJkFcO5VfQ==
X-Received: by 2002:a05:6402:26d4:b0:55a:e42c:fafd with SMTP id x20-20020a05640226d400b0055ae42cfafdmr2239875edd.25.1706082345305;
        Tue, 23 Jan 2024 23:45:45 -0800 (PST)
Received: from krzk-bin.. ([178.197.215.66])
        by smtp.gmail.com with ESMTPSA id c4-20020a056402100400b0055c8a30152bsm1306951edu.83.2024.01.23.23.45.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 23:45:44 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Banajit Goswami <bgoswami@quicinc.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Frank Rowand <frowand.list@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	alsa-devel@alsa-project.org,
	linux-arm-msm@vger.kernel.org,
	linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Sean Anderson <sean.anderson@seco.com>
Subject: [PATCH v5 6/6] ASoC: codecs: wsa884x: Allow sharing reset GPIO
Date: Wed, 24 Jan 2024 08:45:27 +0100
Message-Id: <20240124074527.48869-7-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240124074527.48869-1-krzysztof.kozlowski@linaro.org>
References: <20240124074527.48869-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On some boards with multiple WSA8840/WSA8845 speakers, the reset
(shutdown) GPIO is shared between two speakers.  Use the reset
controller framework and its "reset-gpio" driver to handle this case.
This allows bring-up and proper handling of all WSA884x speakers on
X1E80100-CRD board.

Cc: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Sean Anderson <sean.anderson@seco.com>
Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---

If previous patches are fine, then this commit is independent and could
be taken via ASoC.
---
 sound/soc/codecs/wsa884x.c | 53 +++++++++++++++++++++++++++++++-------
 1 file changed, 43 insertions(+), 10 deletions(-)

diff --git a/sound/soc/codecs/wsa884x.c b/sound/soc/codecs/wsa884x.c
index f2653df84e4a..a9767ef0e39d 100644
--- a/sound/soc/codecs/wsa884x.c
+++ b/sound/soc/codecs/wsa884x.c
@@ -13,6 +13,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
+#include <linux/reset.h>
 #include <linux/slab.h>
 #include <linux/soundwire/sdw.h>
 #include <linux/soundwire/sdw_registers.h>
@@ -699,6 +700,7 @@ struct wsa884x_priv {
 	struct sdw_stream_runtime *sruntime;
 	struct sdw_port_config port_config[WSA884X_MAX_SWR_PORTS];
 	struct gpio_desc *sd_n;
+	struct reset_control *sd_reset;
 	bool port_prepared[WSA884X_MAX_SWR_PORTS];
 	bool port_enable[WSA884X_MAX_SWR_PORTS];
 	unsigned int variant;
@@ -1799,9 +1801,22 @@ static struct snd_soc_dai_driver wsa884x_dais[] = {
 	},
 };
 
-static void wsa884x_gpio_powerdown(void *data)
+static void wsa884x_reset_powerdown(void *data)
 {
-	gpiod_direction_output(data, 1);
+	struct wsa884x_priv *wsa884x = data;
+
+	if (wsa884x->sd_reset)
+		reset_control_assert(wsa884x->sd_reset);
+	else
+		gpiod_direction_output(wsa884x->sd_n, 1);
+}
+
+static void wsa884x_reset_deassert(struct wsa884x_priv *wsa884x)
+{
+	if (wsa884x->sd_reset)
+		reset_control_deassert(wsa884x->sd_reset);
+	else
+		gpiod_direction_output(wsa884x->sd_n, 0);
 }
 
 static void wsa884x_regulator_disable(void *data)
@@ -1809,6 +1824,27 @@ static void wsa884x_regulator_disable(void *data)
 	regulator_bulk_disable(WSA884X_SUPPLIES_NUM, data);
 }
 
+static int wsa884x_get_reset(struct device *dev, struct wsa884x_priv *wsa884x)
+{
+	wsa884x->sd_reset = devm_reset_control_get_optional_shared(dev, NULL);
+	if (IS_ERR(wsa884x->sd_reset))
+		return dev_err_probe(dev, PTR_ERR(wsa884x->sd_reset),
+				     "Failed to get reset\n");
+	else if (wsa884x->sd_reset)
+		return 0;
+	/*
+	 * else: NULL, so use the backwards compatible way for powerdown-gpios,
+	 * which does not handle sharing GPIO properly.
+	 */
+	wsa884x->sd_n = devm_gpiod_get_optional(dev, "powerdown",
+						GPIOD_OUT_HIGH);
+	if (IS_ERR(wsa884x->sd_n))
+		return dev_err_probe(dev, PTR_ERR(wsa884x->sd_n),
+				     "Shutdown Control GPIO not found\n");
+
+	return 0;
+}
+
 static int wsa884x_probe(struct sdw_slave *pdev,
 			 const struct sdw_device_id *id)
 {
@@ -1838,11 +1874,9 @@ static int wsa884x_probe(struct sdw_slave *pdev,
 	if (ret)
 		return ret;
 
-	wsa884x->sd_n = devm_gpiod_get_optional(dev, "powerdown",
-						GPIOD_OUT_HIGH);
-	if (IS_ERR(wsa884x->sd_n))
-		return dev_err_probe(dev, PTR_ERR(wsa884x->sd_n),
-				     "Shutdown Control GPIO not found\n");
+	ret = wsa884x_get_reset(dev, wsa884x);
+	if (ret)
+		return ret;
 
 	dev_set_drvdata(dev, wsa884x);
 	wsa884x->slave = pdev;
@@ -1858,9 +1892,8 @@ static int wsa884x_probe(struct sdw_slave *pdev,
 	pdev->prop.sink_dpn_prop = wsa884x_sink_dpn_prop;
 	pdev->prop.scp_int1_mask = SDW_SCP_INT1_BUS_CLASH | SDW_SCP_INT1_PARITY;
 
-	/* Bring out of reset */
-	gpiod_direction_output(wsa884x->sd_n, 0);
-	ret = devm_add_action_or_reset(dev, wsa884x_gpio_powerdown, wsa884x->sd_n);
+	wsa884x_reset_deassert(wsa884x);
+	ret = devm_add_action_or_reset(dev, wsa884x_reset_powerdown, wsa884x);
 	if (ret)
 		return ret;
 
-- 
2.34.1


