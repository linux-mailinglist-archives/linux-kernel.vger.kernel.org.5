Return-Path: <linux-kernel+bounces-126525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7069789391A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 10:40:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26A06281C3A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 08:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D454C10A13;
	Mon,  1 Apr 2024 08:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C8Kx9g12"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE7D0B67D;
	Mon,  1 Apr 2024 08:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711960780; cv=none; b=MSqCnV/HUHHDWIE8vhOFFcb4Uoy/7a1HIFSHEorFGpTB8/9mVdcqWSUaeVCYiZ6eC2tZsLZB31Z5hWuAorJLXM6kkvfsOQBsW1JX/xH/m1t3M7jogUPwaaum2WLtD+SU+3CkM01ZahQ/AwufFMCpmqi4SMasXNiRurPMm469dPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711960780; c=relaxed/simple;
	bh=krI/WhkrCzluHCBfcmZ8XsjKONfJKJwOoyZj7PJH74o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Y6LqCOf6ItFPAftTyYAkGhRGiwAWu+K9eENDaIh5qBlHAVcB2xZnb6ATSi6EvWAUB2yuH51OoYAxW8GOAVcMFsEBTYNcKUbFKFa0AS8ZnNnCNTtCAz06R0tnF5FhRYVHimGVWqOBxSEOErU5cNNNaOAf3Xlf5Sq7xwWEn398SYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C8Kx9g12; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 86209C433C7;
	Mon,  1 Apr 2024 08:39:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711960779;
	bh=krI/WhkrCzluHCBfcmZ8XsjKONfJKJwOoyZj7PJH74o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=C8Kx9g12z1+EX//V4/1W/hVK5BQkhIy2lBH3dXQFrfDrrzebL8boh0jOuOEMYgTjw
	 esy2fEI2RsKwWfsLD2RkaKzIqKu8VwX5F8TcENxIsF30dTOpfJuYInuT8JYzhJAbXy
	 lXtLyydBfwXufiRCPw1LZpbVRUxirn9fyH222Anz7ge9J/AlaD0Mycy9Gfv90KfsOQ
	 HTqLEEnASxhOKLG8oLVYGM+QsBCdkOpAr4uOCyoxH5czPe0YATUmv/xUhX3On8cXHj
	 3whCpymIqCp5aVL7EYRge0y+k6waQqROVTDX3bqQxvxTkokPECwgpGNGsWl+vvIARY
	 d+DCk7x37Sqjw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72F64CD1283;
	Mon,  1 Apr 2024 08:39:39 +0000 (UTC)
From: Fenglin Wu via B4 Relay <devnull+quic_fenglinw.quicinc.com@kernel.org>
Date: Mon, 01 Apr 2024 16:38:50 +0800
Subject: [PATCH v8 1/3] input: pm8xxx-vibrator: refactor to support new
 SPMI vibrator
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240401-pm8xxx-vibrator-new-design-v8-1-6f2b8b03b4c7@quicinc.com>
References: <20240401-pm8xxx-vibrator-new-design-v8-0-6f2b8b03b4c7@quicinc.com>
In-Reply-To: <20240401-pm8xxx-vibrator-new-design-v8-0-6f2b8b03b4c7@quicinc.com>
To: kernel@quicinc.com, Andy Gross <agross@kernel.org>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-input@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Fenglin Wu <quic_fenglinw@quicinc.com>
X-Mailer: b4 0.13-dev-83828
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711960777; l=4212;
 i=quic_fenglinw@quicinc.com; s=20240327; h=from:subject:message-id;
 bh=tTnC4dubPYKNNJrG47vzyScaCxvgXIPWymh4D69RifU=;
 b=PmWkrTCSTMhDeZyptFvxFuO4XIqNTkyhiNaBzwkZIoA8BI0v48+4NzfPZiT+wcaSkvouMLI9x
 fulz7pfU9K6D2sEZ4EzR1bcbTcZPhA6vxMBnOqW/PahoYispgDrvs78
X-Developer-Key: i=quic_fenglinw@quicinc.com; a=ed25519;
 pk=BF8SA4IVDk8/EBCwlBehKtn2hp6kipuuAuDAHh9s+K4=
X-Endpoint-Received: by B4 Relay for quic_fenglinw@quicinc.com/20240327
 with auth_id=146
X-Original-From: Fenglin Wu <quic_fenglinw@quicinc.com>
Reply-To: quic_fenglinw@quicinc.com

From: Fenglin Wu <quic_fenglinw@quicinc.com>

Currently, vibrator control register addresses are hard coded,
including the base address and offsets, it's not flexible to
support new SPMI vibrator module which is usually included in
different PMICs with different base address. Refactor it by using
the base address defined in devicetree.

Signed-off-by: Fenglin Wu <quic_fenglinw@quicinc.com>
---
 drivers/input/misc/pm8xxx-vibrator.c | 40 ++++++++++++++++++++++++------------
 1 file changed, 27 insertions(+), 13 deletions(-)

diff --git a/drivers/input/misc/pm8xxx-vibrator.c b/drivers/input/misc/pm8xxx-vibrator.c
index 04cb87efd799..3b6a2e949f30 100644
--- a/drivers/input/misc/pm8xxx-vibrator.c
+++ b/drivers/input/misc/pm8xxx-vibrator.c
@@ -19,26 +19,26 @@
 #define MAX_FF_SPEED		0xff
 
 struct pm8xxx_regs {
-	unsigned int enable_addr;
+	unsigned int enable_offset;
 	unsigned int enable_mask;
 
-	unsigned int drv_addr;
+	unsigned int drv_offset;
 	unsigned int drv_mask;
 	unsigned int drv_shift;
 	unsigned int drv_en_manual_mask;
 };
 
 static const struct pm8xxx_regs pm8058_regs = {
-	.drv_addr = 0x4A,
+	.drv_offset = 0x4A,
 	.drv_mask = 0xf8,
 	.drv_shift = 3,
 	.drv_en_manual_mask = 0xfc,
 };
 
 static struct pm8xxx_regs pm8916_regs = {
-	.enable_addr = 0xc046,
+	.enable_offset = 0x46,
 	.enable_mask = BIT(7),
-	.drv_addr = 0xc041,
+	.drv_offset = 0x41,
 	.drv_mask = 0x1F,
 	.drv_shift = 0,
 	.drv_en_manual_mask = 0,
@@ -50,6 +50,8 @@ static struct pm8xxx_regs pm8916_regs = {
  * @work: work structure to set the vibration parameters
  * @regmap: regmap for register read/write
  * @regs: registers' info
+ * @enable_addr: vibrator enable register
+ * @drv_addr: vibrator drive strength register
  * @speed: speed of vibration set from userland
  * @active: state of vibrator
  * @level: level of vibration to set in the chip
@@ -60,6 +62,8 @@ struct pm8xxx_vib {
 	struct work_struct work;
 	struct regmap *regmap;
 	const struct pm8xxx_regs *regs;
+	unsigned int enable_addr;
+	unsigned int drv_addr;
 	int speed;
 	int level;
 	bool active;
@@ -82,14 +86,14 @@ static int pm8xxx_vib_set(struct pm8xxx_vib *vib, bool on)
 	else
 		val &= ~regs->drv_mask;
 
-	rc = regmap_write(vib->regmap, regs->drv_addr, val);
+	rc = regmap_write(vib->regmap, vib->drv_addr, val);
 	if (rc < 0)
 		return rc;
 
 	vib->reg_vib_drv = val;
 
 	if (regs->enable_mask)
-		rc = regmap_update_bits(vib->regmap, regs->enable_addr,
+		rc = regmap_update_bits(vib->regmap, vib->enable_addr,
 					regs->enable_mask, on ? ~0 : 0);
 
 	return rc;
@@ -102,11 +106,10 @@ static int pm8xxx_vib_set(struct pm8xxx_vib *vib, bool on)
 static void pm8xxx_work_handler(struct work_struct *work)
 {
 	struct pm8xxx_vib *vib = container_of(work, struct pm8xxx_vib, work);
-	const struct pm8xxx_regs *regs = vib->regs;
-	int rc;
 	unsigned int val;
+	int rc;
 
-	rc = regmap_read(vib->regmap, regs->drv_addr, &val);
+	rc = regmap_read(vib->regmap, vib->drv_addr, &val);
 	if (rc < 0)
 		return;
 
@@ -169,7 +172,7 @@ static int pm8xxx_vib_probe(struct platform_device *pdev)
 	struct pm8xxx_vib *vib;
 	struct input_dev *input_dev;
 	int error;
-	unsigned int val;
+	unsigned int val, reg_base = 0;
 	const struct pm8xxx_regs *regs;
 
 	vib = devm_kzalloc(&pdev->dev, sizeof(*vib), GFP_KERNEL);
@@ -189,13 +192,24 @@ static int pm8xxx_vib_probe(struct platform_device *pdev)
 
 	regs = of_device_get_match_data(&pdev->dev);
 
+	if (regs->enable_offset != 0) {
+		error = fwnode_property_read_u32(pdev->dev.fwnode, "reg", &reg_base);
+		if (error < 0) {
+			dev_err(&pdev->dev, "Failed to read reg address, rc=%d\n", error);
+			return error;
+		}
+	}
+
+	vib->enable_addr = reg_base + regs->enable_offset;
+	vib->drv_addr = reg_base + regs->drv_offset;
+
 	/* operate in manual mode */
-	error = regmap_read(vib->regmap, regs->drv_addr, &val);
+	error = regmap_read(vib->regmap, vib->drv_addr, &val);
 	if (error < 0)
 		return error;
 
 	val &= regs->drv_en_manual_mask;
-	error = regmap_write(vib->regmap, regs->drv_addr, val);
+	error = regmap_write(vib->regmap, vib->drv_addr, val);
 	if (error < 0)
 		return error;
 

-- 
2.25.1



