Return-Path: <linux-kernel+bounces-156128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D334B8AFE41
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 04:17:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 378D9284EF4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 02:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C63A134A5;
	Wed, 24 Apr 2024 02:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rQ0xzmm8"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F1711171C
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 02:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713925023; cv=none; b=IepB7cItuHyuuNuf7UvjXf5jIzma+7EvGfR2jM+aV/EDK4MtOTU5r+x7t7V+0805q5hodwwRx9ku89fOD7sFe39k2bMR5njyoj7mDLKRzBKm+HvicsCxCGNvBtP+EYOY+8FCWgrv3kNmaVb9B7Zg2d6Z2aNoYbIRx+VbEh8HviQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713925023; c=relaxed/simple;
	bh=z0tyvXJLTPOxib1CjXH35jFEgsUkKqgQu3u4d6x+zAU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=gTjYeULF0x5F+7KyZEPtxFS9+MAMjZz6q+NFn8O4Kt+TNx4W4yDvHpz2Z6028EyjD/qz6bo2PmbVkf6oS0v1zrI614wQNI6hyjEJrqaX5trNQrq5YEyT3IgHdDaWSKama/HLTFfzioVOJ+qYBe2eQBwYA5/+T9RuVum3p9Mje1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rQ0xzmm8; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-51acc258075so5600058e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 19:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713925020; x=1714529820; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bzBIBCWvmTg9A5eqvlFjsg0yTPpcDpY8cD+b74fEx9s=;
        b=rQ0xzmm8kgIl6kVQdUl4i8wEd8jKgflVCtWnTmyRC13EeQs83M3fdXYdcDivbZHOjW
         vAoUeILAj2Mc+E281x0LdRk+jYlO673ZKo+EJCJr01eVGEP6zXLZcgP7MTTjWg0WDdDi
         ccYW/nhORSDfG8YxfGvyVwPYcUX2CWjRelSiq3flmUmaeeMXSYUxM0JoDY0GFIPnc+BR
         qXdB6+eqOTpznF6y8O4ttvHU/KGyLUMkGIqXrS1LBy/9ACfw64kY6QNFzgNpcsZrMykS
         sPFnmDOLSz0mwzqSu71F1Frc8c+LdeUJvPUk9dH53q8pIQofka661vnhCGXWqAaly/jr
         C2kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713925020; x=1714529820;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bzBIBCWvmTg9A5eqvlFjsg0yTPpcDpY8cD+b74fEx9s=;
        b=WkJNMgI23Yx6OgcCLJRM3/5eq4mFc3Rv3yC5YBf/GVqeviLSHpfqUkCAhT0rL3P4Ec
         aYftWltEV5l3k/ml3anx+JIgBRlPAAR7vb9wI9PVt3SAUI+CFvv5pjuWuB1WzmFXf+pU
         FgujeU8jeqpebYWJLXTuXaA2DURAcnRRZP7YelNTuBYWqD0EAYYgtWxlNd+w9PFh+PRf
         F3we9dQX6fbXs4b/7P4XdIIr13L9R8K+HIAcdCbbzANSqL0YpkiKK2oCkKnrTRcRrJVb
         LV4EMf4UbEU0pGotalIYPGgyMFk/RpEQli5ug/sjWFinlEZF2TBc7C9cEMHgA8IRuaDc
         Q7AQ==
X-Forwarded-Encrypted: i=1; AJvYcCWI6Tem8n370wKhzfSdOg8RHVjKQZUWVkZOu4nyw3+PPdKJzMDOK6SVjuX9wBTP/XeZcXMXEnA8M3AS5esE5KM8BkCQHbznwiBWsejN
X-Gm-Message-State: AOJu0Yyytnh8tcOWsHaleFZSkfOFb2aTCcJl+vtCIG/GaGxoRZ7hhkDc
	rbQ53VLgmkp+2usiTcumAdXgbEasrnF+XRMFa8wY5maQecQ32Z2ot76oCAFTKRU=
X-Google-Smtp-Source: AGHT+IE/o14kmL2EDNAN1oAx0F/0WgW8Q1sUU5C5VMVIJeuAKAgcvnAuexE4y6yFJCmkYGcYuchHTA==
X-Received: by 2002:a05:6512:3281:b0:519:33a5:973e with SMTP id p1-20020a056512328100b0051933a5973emr656676lfe.6.1713925019708;
        Tue, 23 Apr 2024 19:16:59 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id o2-20020ac24c42000000b00518e96b85b0sm2144108lfk.234.2024.04.23.19.16.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 19:16:59 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Wed, 24 Apr 2024 05:16:57 +0300
Subject: [PATCH v4] usb: typec: qcom-pmic-typec: split HPD bridge alloc and
 registration
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240424-qc-pmic-typec-hpd-split-v4-1-f7e10d147443@linaro.org>
X-B4-Tracking: v=1; b=H4sIAJhrKGYC/4XNwQrCMAzG8VeRno00Sd3Uk+8hHrqucwHdajuGQ
 /buVk+KiMf/B/nlrpKP4pPaLe4q+lGS9F0Os1wo19ru5EHq3Io0GW30Gq4OwkUcDFPwDtpQQwp
 nGYBoow1p3GqqVL4O0Tdye8mHY+5W0tDH6fVoxOf63xwRELjg2tqmYsfF/iydjf2qjyf1REd6h
 za/IcoQlto0ayasSv6C+A3C4jfEGWpqXaJn3KLFD2ie5wdGsPJ/UQEAAA==
To: Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Johan Hovold <johan+linaro@kernel.org>, linux-arm-msm@vger.kernel.org, 
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Caleb Connolly <caleb.connolly@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3381;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=z0tyvXJLTPOxib1CjXH35jFEgsUkKqgQu3u4d6x+zAU=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmKGua8A+E5KBZPeNOQXcA2mDi6X8c57wKq09sY
 wf30OEtAHWJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZihrmgAKCRCLPIo+Aiko
 1c9LB/wM2jWAszFbtPuorq1W61uTjm6LJWhzKlr/hwmDcqRGuBIakSHyheyNlJ3qKncxWWTjULp
 akn89vD6sx8RTTM1XS6LVDGX2BpEcZBZBNqXH6kUFX8R2+IirtvLE5Ic6Dtwl6W8zLvFAN3tzQP
 JXGynrrn5RfGvECNrP7i7hNkSv+8K/L/yLksH7fGiIHrr0zMIbTtl8p83lxi/NjpyxyV5Zly/PD
 Nb1BhF7YvzIDAFnZxZlh41Ant7uEQT3yaOASVtMzaLgnW8Jn0iormJypT9XFtmgcNbtxMU1a8I1
 nl8JZ99bMzMMOUPdI5fu7UzTv48R5pY5GVdj540CIHFVITn5
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

If a probe function returns -EPROBE_DEFER after creating another device
there is a change of ending up in a probe deferral loop, (see commit
fbc35b45f9f6 ("Add documentation on meaning of -EPROBE_DEFER"). In case
of the qcom-pmic-typec driver the tcpm_register_port() function looks up
external resources (USB role switch and inherently via called
typec_register_port() USB-C muxes, switches and retimers).

In order to prevent such probe-defer loops caused by qcom-pmic-typec
driver, use the API added by Johan Hovold and move HPD bridge
registration to the end of the probe function.

The devm_drm_dp_hpd_bridge_add() is called at the end of the probe
function after all TCPM start functions. This is done as a way to
overcome a different problem, the DRM subsystem can not properly cope
with the DRM bridges being destroyed once the bridge is attached. Having
this function call at the end of the probe function prevents possible
DRM bridge device creation followed by destruction in case one of the
TCPM start functions returns an error.

Reported-by: Caleb Connolly <caleb.connolly@linaro.org>
Acked-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
Dependency: https://lore.kernel.org/lkml/20240418145730.4605-2-johan+linaro@kernel.org/
---
Changes in v4:
- Rebased on top of Johan's patches
- Link to v3: https://lore.kernel.org/r/20240416-qc-pmic-typec-hpd-split-v3-1-fd071e3191a1@linaro.org

Changes in v3:
- Updated commit message to explain my decisions (Johan).
- Link to v2: https://lore.kernel.org/r/20240408-qc-pmic-typec-hpd-split-v2-1-1704f5321b73@linaro.org

Changes in v2:
- Fix commit message (Bryan)
- Link to v1: https://lore.kernel.org/r/20240405-qc-pmic-typec-hpd-split-v1-1-363daafb3c36@linaro.org
---
 drivers/usb/typec/tcpm/qcom/qcom_pmic_typec.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec.c b/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec.c
index d3958c061a97..501eddb294e4 100644
--- a/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec.c
+++ b/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec.c
@@ -41,7 +41,7 @@ static int qcom_pmic_typec_probe(struct platform_device *pdev)
 	struct device_node *np = dev->of_node;
 	const struct pmic_typec_resources *res;
 	struct regmap *regmap;
-	struct device *bridge_dev;
+	struct auxiliary_device *bridge_dev;
 	u32 base;
 	int ret;
 
@@ -92,7 +92,7 @@ static int qcom_pmic_typec_probe(struct platform_device *pdev)
 	if (!tcpm->tcpc.fwnode)
 		return -EINVAL;
 
-	bridge_dev = drm_dp_hpd_bridge_register(tcpm->dev, to_of_node(tcpm->tcpc.fwnode));
+	bridge_dev = devm_drm_dp_hpd_bridge_alloc(tcpm->dev, to_of_node(tcpm->tcpc.fwnode));
 	if (IS_ERR(bridge_dev))
 		return PTR_ERR(bridge_dev);
 
@@ -110,8 +110,14 @@ static int qcom_pmic_typec_probe(struct platform_device *pdev)
 	if (ret)
 		goto port_stop;
 
+	ret = devm_drm_dp_hpd_bridge_add(tcpm->dev, bridge_dev);
+	if (ret)
+		goto pdphy_stop;
+
 	return 0;
 
+pdphy_stop:
+	tcpm->pdphy_stop(tcpm);
 port_stop:
 	tcpm->port_stop(tcpm);
 port_unregister:

---
base-commit: 15d419fa23ecc51e388a369bbeaf3b47b0b5c76a
change-id: 20240405-qc-pmic-typec-hpd-split-22804201902b

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


