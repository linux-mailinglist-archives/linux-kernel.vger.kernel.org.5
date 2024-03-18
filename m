Return-Path: <linux-kernel+bounces-106243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBB9687EB4F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 15:45:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 181321C21062
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 14:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64D9E524CE;
	Mon, 18 Mar 2024 14:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R8rtkbBm"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29EF50A69;
	Mon, 18 Mar 2024 14:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710772999; cv=none; b=QGNbPbag7G6AO+mfEysuY0KFjSJboumnAUeP5XjsetVvrqHelfwH3onthYabltYbOPeFOYNVyLUGPM6mmWdwOxfwnNf5GAYW833AONoM3WZDFSK1lO8fZBxhxVp/bezXi4e1h1J9pZw3f4YvdGeycoVE1QR3sN6QhC2+g3HhYg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710772999; c=relaxed/simple;
	bh=qd9OurlGMiM81BMao1aJ4SpekOda8rLsQ9rKx4C/g1Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dzoeFFmkCT8K5StRGVxhB4DHWO/EmNce4to4GMntPOM59YquFYYeU1bc6Lv8D6DRR0u/s7UwywqdzoPmVqa+93V6BBtW5YMGsoBrVBIBIK7OP33fmZIiY0VfkpB4Oj98Y0Fp7cmqllIpjk9oHBDZEztzfumRVxUS6ZzyYiJxcYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R8rtkbBm; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2d094bc2244so60085131fa.1;
        Mon, 18 Mar 2024 07:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710772996; x=1711377796; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gBcn1nMAdTSCT3A+/DCOtS0XSUKaFGHkFwng8LbwhbQ=;
        b=R8rtkbBmuOu9jeJ4nX1DTyKuJv5fvtEDORYysYGqesvvNO4rwpJbjw74tKNYvEusct
         7aUr6RcWVaO7VRenTHGf5im+RXDhP1OEmTYEPmug5V3wXLCwASiv2J3yb6PTjjLR/lUi
         gtiGFbKrev5c8SlcUECRvxaKFQyWNkbNyhCr5PkXtR9Fg/tljI7+WaoE8RCDutOo7JPD
         opkEo+A3qzEnUw8dHe6mp697IT+/MTWgOak6OLZ7dWb8AdGuBq1XS4npS9UsyWEaF8BE
         NU4OCPVEKtmpALb+MbqvqhrKmEM/mWB17xtTVCrY+DPXAL0gxL5bH9PqbrsRKIypu7Cd
         z8NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710772996; x=1711377796;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gBcn1nMAdTSCT3A+/DCOtS0XSUKaFGHkFwng8LbwhbQ=;
        b=O3TA+BKAP6pCH01oe9hcmTaTjacVRJbfvH9TrF9bhcV7ZYFWacBBlhAzRa2vdlR6/L
         h9dFcy8Nrz2EkBuJf1KMJOYSpRiqN6If7eAPJJWewPi+1plELnR4n+Kk2LxcNeSwZjPX
         AVXYh5+Joh8Kw0H3qT9gmNz8PoYylq90X0bn8cqqGTE3Ug0gL5VU69jFhL1foD/CjNAN
         5WHgqodWUAPJJW2uH5Yc8+Layhe+UfW8fGM47Em63X+OUJoiKyAtk16Tpj1XZoDtG2B9
         W3CCvZOHZPHxdZBDiuDj2XzCx/4NVyrGtx+as8t4Yr/tcNSTx3sA3hYcb4AJnVYkZZFv
         SNxQ==
X-Forwarded-Encrypted: i=1; AJvYcCVZKXbg4i3h4oQY3DwtWytyhhweQDujd3PJzDsybb+G6nPoqIUcEqPie6j/4kh+7Qi61WunfbJUgJJscrAciIzYIf/+TZtYpwW1g3XVP9tIQm0a9uLjHTYLf7JtBXAhOow7sN5AQwkboDwsyDngNZCpEKYBxb+y1yBL6N2hVN/c5t6HODyn
X-Gm-Message-State: AOJu0Yw3c916sPKKtOC4Rfa0+ou+6dZn7FJcvbLlfZ1kPf5cO+aO92iG
	tbIXe/hdA088SsePRs1UkSlRumWnBDqDRYoZ4wioxttIqwVt0PUF
X-Google-Smtp-Source: AGHT+IHTGX9CVxW3jhHyBMgb3qVM/QtmntIs9qDbPpxHgmlX8hNPBZsArGFrdGAdHfVrv1W3LK+HkQ==
X-Received: by 2002:a2e:a30c:0:b0:2d4:8db2:f79c with SMTP id l12-20020a2ea30c000000b002d48db2f79cmr5349716lje.50.1710772995857;
        Mon, 18 Mar 2024 07:43:15 -0700 (PDT)
Received: from localhost.localdomain ([178.70.43.28])
        by smtp.gmail.com with ESMTPSA id t9-20020a2e9c49000000b002d476327311sm1527486ljj.18.2024.03.18.07.43.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 07:43:15 -0700 (PDT)
From: Ivan Bornyakov <brnkv.i1@gmail.com>
To: Nas Chung <nas.chung@chipsnmedia.com>,
	Jackson Lee <jackson.lee@chipsnmedia.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Ivan Bornyakov <brnkv.i1@gmail.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH 4/6] media: chips-media: wave5: separate irq setup routine
Date: Mon, 18 Mar 2024 17:42:19 +0300
Message-ID: <20240318144225.30835-5-brnkv.i1@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240318144225.30835-1-brnkv.i1@gmail.com>
References: <20240318144225.30835-1-brnkv.i1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Separate interrupts setup routine to reduce code duplication. Also
enable interrupts based on vpu_attr->support_encoders and
vpu_attr->support_decoders fields to facilitate other Wave5xx IPs
support, because not all of them are both encoders and decoders.

Signed-off-by: Ivan Bornyakov <brnkv.i1@gmail.com>
---
 .../platform/chips-media/wave5/wave5-hw.c     | 53 +++++++++----------
 1 file changed, 24 insertions(+), 29 deletions(-)

diff --git a/drivers/media/platform/chips-media/wave5/wave5-hw.c b/drivers/media/platform/chips-media/wave5/wave5-hw.c
index 2d82791f575e..cdd0a0948a94 100644
--- a/drivers/media/platform/chips-media/wave5/wave5-hw.c
+++ b/drivers/media/platform/chips-media/wave5/wave5-hw.c
@@ -299,6 +299,27 @@ static int wave5_send_query(struct vpu_device *vpu_dev, struct vpu_instance *ins
 	return wave5_vpu_firmware_command_queue_error_check(vpu_dev, NULL);
 }
 
+static void setup_wave5_interrupts(struct vpu_device *vpu_dev)
+{
+	u32 reg_val = 0;
+
+	if (vpu_dev->attr.support_encoders) {
+		/* Encoder interrupt */
+		reg_val |= BIT(INT_WAVE5_ENC_SET_PARAM);
+		reg_val |= BIT(INT_WAVE5_ENC_PIC);
+		reg_val |= BIT(INT_WAVE5_BSBUF_FULL);
+	}
+
+	if (vpu_dev->attr.support_decoders) {
+		/* Decoder interrupt */
+		reg_val |= BIT(INT_WAVE5_INIT_SEQ);
+		reg_val |= BIT(INT_WAVE5_DEC_PIC);
+		reg_val |= BIT(INT_WAVE5_BSBUF_EMPTY);
+	}
+
+	return vpu_write_reg(vpu_dev, W5_VPU_VINT_ENABLE, reg_val);
+}
+
 static int setup_wave5_properties(struct device *dev)
 {
 	struct vpu_device *vpu_dev = dev_get_drvdata(dev);
@@ -340,6 +361,8 @@ static int setup_wave5_properties(struct device *dev)
 	p_attr->support_vcpu_backbone = FIELD_GET(FEATURE_VCPU_BACKBONE, hw_config_def0);
 	p_attr->support_vcore_backbone = FIELD_GET(FEATURE_VCORE_BACKBONE, hw_config_def0);
 
+	setup_wave5_interrupts(vpu_dev);
+
 	return 0;
 }
 
@@ -417,16 +440,6 @@ int wave5_vpu_init(struct device *dev, u8 *fw, size_t size)
 	wave5_fio_writel(vpu_dev, W5_BACKBONE_AXI_PARAM, 0);
 	vpu_write_reg(vpu_dev, W5_SEC_AXI_PARAM, 0);
 
-	/* Encoder interrupt */
-	reg_val = BIT(INT_WAVE5_ENC_SET_PARAM);
-	reg_val |= BIT(INT_WAVE5_ENC_PIC);
-	reg_val |= BIT(INT_WAVE5_BSBUF_FULL);
-	/* Decoder interrupt */
-	reg_val |= BIT(INT_WAVE5_INIT_SEQ);
-	reg_val |= BIT(INT_WAVE5_DEC_PIC);
-	reg_val |= BIT(INT_WAVE5_BSBUF_EMPTY);
-	vpu_write_reg(vpu_dev, W5_VPU_VINT_ENABLE, reg_val);
-
 	reg_val = vpu_read_reg(vpu_dev, W5_VPU_RET_VPU_CONFIG0);
 	if (FIELD_GET(FEATURE_BACKBONE, reg_val)) {
 		reg_val = ((WAVE5_PROC_AXI_ID << 28) |
@@ -1034,16 +1047,6 @@ int wave5_vpu_re_init(struct device *dev, u8 *fw, size_t size)
 		wave5_fio_writel(vpu_dev, W5_BACKBONE_AXI_PARAM, 0);
 		vpu_write_reg(vpu_dev, W5_SEC_AXI_PARAM, 0);
 
-		/* Encoder interrupt */
-		reg_val = BIT(INT_WAVE5_ENC_SET_PARAM);
-		reg_val |= BIT(INT_WAVE5_ENC_PIC);
-		reg_val |= BIT(INT_WAVE5_BSBUF_FULL);
-		/* Decoder interrupt */
-		reg_val |= BIT(INT_WAVE5_INIT_SEQ);
-		reg_val |= BIT(INT_WAVE5_DEC_PIC);
-		reg_val |= BIT(INT_WAVE5_BSBUF_EMPTY);
-		vpu_write_reg(vpu_dev, W5_VPU_VINT_ENABLE, reg_val);
-
 		reg_val = vpu_read_reg(vpu_dev, W5_VPU_RET_VPU_CONFIG0);
 		if (FIELD_GET(FEATURE_BACKBONE, reg_val)) {
 			reg_val = ((WAVE5_PROC_AXI_ID << 28) |
@@ -1134,15 +1137,7 @@ static int wave5_vpu_sleep_wake(struct device *dev, bool i_sleep_wake, const uin
 		wave5_fio_writel(vpu_dev, W5_BACKBONE_AXI_PARAM, 0);
 		vpu_write_reg(vpu_dev, W5_SEC_AXI_PARAM, 0);
 
-		/* Encoder interrupt */
-		reg_val = BIT(INT_WAVE5_ENC_SET_PARAM);
-		reg_val |= BIT(INT_WAVE5_ENC_PIC);
-		reg_val |= BIT(INT_WAVE5_BSBUF_FULL);
-		/* Decoder interrupt */
-		reg_val |= BIT(INT_WAVE5_INIT_SEQ);
-		reg_val |= BIT(INT_WAVE5_DEC_PIC);
-		reg_val |= BIT(INT_WAVE5_BSBUF_EMPTY);
-		vpu_write_reg(vpu_dev, W5_VPU_VINT_ENABLE, reg_val);
+		setup_wave5_interrupts(vpu_dev);
 
 		reg_val = vpu_read_reg(vpu_dev, W5_VPU_RET_VPU_CONFIG0);
 		if (FIELD_GET(FEATURE_BACKBONE, reg_val)) {
-- 
2.44.0


