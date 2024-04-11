Return-Path: <linux-kernel+bounces-140091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EFC0C8A0B5B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 10:35:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CC5B1F22FBD
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 08:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87A0A1482FC;
	Thu, 11 Apr 2024 08:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HrKnZSjW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 855C3146A85;
	Thu, 11 Apr 2024 08:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712824327; cv=none; b=oVDBL3tet9hrCs8Y04hniLOV4DIgWdSIZu9vfD6D8xAmAa01k+yjiLlk297Wn/gYOo9PE2lvbveKCELrI1MBF898cXROZdqFsewLjIJ0LI3OttyZCwVwW8x3M/VVe4EYl+Tqb2m0oiAgJA1voNXH+tot/dugUxXTWd/vqtIDRuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712824327; c=relaxed/simple;
	bh=awcXiHlY45RRTD8/mgYlpukV/VJjGSgPy2Oj5Qablns=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=u9BSKz5x1WFZ3b+z04LRw7X5dU70k+/ca3vbFzwBbQWDqVI8JTrWqlToErc/OGx/PPA8FdWiJKeUTAQAatNmfHMW5Ebgs5rKPi/bkgrYVs9P4XRao3WG9yw/xTZ0ItRuPF7fDh8O5G3xKyySmCZB9iQibz2QTecjUTjClpMkYy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HrKnZSjW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id EF96BC433A6;
	Thu, 11 Apr 2024 08:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712824327;
	bh=awcXiHlY45RRTD8/mgYlpukV/VJjGSgPy2Oj5Qablns=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=HrKnZSjW4HhBRx6U8g1kevAQ/Mgrgv4mcLc28fKC0i3FYit1yd3GljRXoYESnVFgi
	 Br7RnPi4c3svW1Jz4slB37pyPWYtoKlAXEmA2wxddm/s7YR+e5vkO+/DAOH5igaC9F
	 /yCUnPfiHiS5/+OQSdZQclKdHfmoTbiUnTwCQQH6lBeSpHObaVOj8yVbcrIgbysHvu
	 bseB1Uqx0VT2pXqgv9XQz7VU+QGzGlbmie6hHZx6W5W7Ds4aemOPW8hGBj61D6EInO
	 udOUhdbG0gEwdv7tKlMyuDGS8eJVbGW/kWFRcJ9ApV8CFGjtIrSiYCYl2Ao2XRRwFb
	 ZMwrHgqgLloow==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1346CD1299;
	Thu, 11 Apr 2024 08:32:06 +0000 (UTC)
From: Fenglin Wu via B4 Relay <devnull+quic_fenglinw.quicinc.com@kernel.org>
Date: Thu, 11 Apr 2024 16:30:58 +0800
Subject: [PATCH v9 2/4] input: pm8xxx-vibrator: refactor to support new
 SPMI vibrator
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240411-pm8xxx-vibrator-new-design-v9-2-7bf56cb92b28@quicinc.com>
References: <20240411-pm8xxx-vibrator-new-design-v9-0-7bf56cb92b28@quicinc.com>
In-Reply-To: <20240411-pm8xxx-vibrator-new-design-v9-0-7bf56cb92b28@quicinc.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712824325; l=4271;
 i=quic_fenglinw@quicinc.com; s=20240327; h=from:subject:message-id;
 bh=5iLyWd/zr4xemra0cdRKHCPkeXfpcSHYnUInjuL/7l8=;
 b=USbW4RlGW9KjPBeUeWn+w70DL7kdlAef+iqSXxeCojJc8ZjkAXNroettdOjh31AzRzRBTPkw6
 wi5jwRnrCt5A07uXDtkUCG/mc5Y1bvTScF11lYtRpRff6NmgvrlqL7I
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
 drivers/input/misc/pm8xxx-vibrator.c | 42 ++++++++++++++++++++++++------------
 1 file changed, 28 insertions(+), 14 deletions(-)

diff --git a/drivers/input/misc/pm8xxx-vibrator.c b/drivers/input/misc/pm8xxx-vibrator.c
index 89f0f1c810d8..2959edca8eb9 100644
--- a/drivers/input/misc/pm8xxx-vibrator.c
+++ b/drivers/input/misc/pm8xxx-vibrator.c
@@ -20,26 +20,26 @@
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
@@ -51,6 +51,8 @@ static struct pm8xxx_regs pm8916_regs = {
  * @work: work structure to set the vibration parameters
  * @regmap: regmap for register read/write
  * @regs: registers' info
+ * @enable_addr: vibrator enable register
+ * @drv_addr: vibrator drive strength register
  * @speed: speed of vibration set from userland
  * @active: state of vibrator
  * @level: level of vibration to set in the chip
@@ -61,6 +63,8 @@ struct pm8xxx_vib {
 	struct work_struct work;
 	struct regmap *regmap;
 	const struct pm8xxx_regs *regs;
+	unsigned int enable_addr;
+	unsigned int drv_addr;
 	int speed;
 	int level;
 	bool active;
@@ -83,15 +87,15 @@ static int pm8xxx_vib_set(struct pm8xxx_vib *vib, bool on)
 	else
 		val &= ~regs->drv_mask;
 
-	rc = regmap_write(vib->regmap, regs->drv_addr, val);
+	rc = regmap_write(vib->regmap, vib->drv_addr, val);
 	if (rc < 0)
 		return rc;
 
 	vib->reg_vib_drv = val;
 
 	if (regs->enable_mask)
-		rc = regmap_update_bits(vib->regmap, regs->enable_addr,
-					regs->enable_mask, on ? ~0 : 0);
+		rc = regmap_update_bits(vib->regmap, vib->enable_addr,
+					regs->enable_mask, on ? regs->enable_mask : 0);
 
 	return rc;
 }
@@ -103,11 +107,10 @@ static int pm8xxx_vib_set(struct pm8xxx_vib *vib, bool on)
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
 
@@ -170,7 +173,7 @@ static int pm8xxx_vib_probe(struct platform_device *pdev)
 	struct pm8xxx_vib *vib;
 	struct input_dev *input_dev;
 	int error;
-	unsigned int val;
+	unsigned int val, reg_base = 0;
 	const struct pm8xxx_regs *regs;
 
 	vib = devm_kzalloc(&pdev->dev, sizeof(*vib), GFP_KERNEL);
@@ -190,13 +193,24 @@ static int pm8xxx_vib_probe(struct platform_device *pdev)
 
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



