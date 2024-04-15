Return-Path: <linux-kernel+bounces-144892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 185A48A4C3B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 12:09:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A0201C21089
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 10:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E15B458ABB;
	Mon, 15 Apr 2024 10:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dAoPpl0l"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D4457889;
	Mon, 15 Apr 2024 10:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713175673; cv=none; b=SjNveSplHT5tAgZMGZ43msjVSYo7etjM5pVWNOLVYpweWfCUD34MFpHkxveVt+2NSUEGucioASxeRm7+RbogthNuZ2KtNyzcPX6rkuhgO0p5RJszZOVvhP8y0qVNtryV2kY3+TkzNrTxOK2/6lSBLuOtTNyG9i7O9rJPJxfODGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713175673; c=relaxed/simple;
	bh=aDbcpQbcbf0YX/mOf1pvgn7kmm9ITS7w0AmOppIc5a0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fVs/Uht15QJ4VBkzkIw5oL2vdZcYghrkm8dzlKn0j9ToIMYSVIoiqcP+Og9WAJF4qrqgMAZTN5sgYgxi+f8io77xCBkJQ+9ErswKL+TwbfHuvG7F58+Mv7t8I+9Q4Cs6PViWKZt/mjFd14wEVR34sExosQJMf8JiHan97hdb4kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dAoPpl0l; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-516d68d7a8bso2506835e87.1;
        Mon, 15 Apr 2024 03:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713175669; x=1713780469; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rcWuWwbYDzN/Eba2XHYlH7krkiOlk1hd506TNmQ/SjY=;
        b=dAoPpl0llXV+WXzU2bTUwaPc+5ImPy+u0HMIaDNzss5B5oTxakJ3wKU/hWfo/9HwOw
         A05bZm9MxU/NsJsa3cmvxpt9WqafAjFolAItKG0BccwILFKWZ7H0OzokyX2iWwDM+/W7
         m/+paRM3Tt2psZzHIA0wpFwaKGxDcXHuuEPUiqOVocHkZmsoQVg/aB9Kn8EwENtGAgpu
         M3J8hpTQ4MG6WrXVU33ot4s0xx71wOMf0nHJOUdT3i1GPKmD+4Q0rxYqTs9FzmD8+mtd
         22hSWHe9ElJFY77V7LkmFnljAa67GpfLYom3T/u3ima39cFDAplcZCk9xuHOaTP5JZa9
         e33g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713175669; x=1713780469;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rcWuWwbYDzN/Eba2XHYlH7krkiOlk1hd506TNmQ/SjY=;
        b=xCZ45CCMHaI0lQpj2MykPDCMcq0uJVzLTV25aoBuzLtB4fHQT8WP/YROSIb0KzjRZr
         UgmsGAZ0vWya7L7uCslzcFN9mjU9l1LjjSMemUcIrEnO7F9l4cYuD17MN/Ar6VDnK9Rp
         9kUGx1rOZ057CBhvEhlIa0EHhkG4v2b2aQHTusOrANDf6aBCID4JPfccowtq4pwshyBO
         xAAorpjUA6hK6AF275CtImDbrP5OI0wys9+fsKBxxGp7/fhb2OzU/LBus+0BtVS53obD
         Ct0IgT34lnjQbc2IFbFzMeZPCeGDnoFVvoS2YDKDtVJOYrwazyvBJwOZlf7qwbSk+yYR
         yDPQ==
X-Forwarded-Encrypted: i=1; AJvYcCXoOJd8Q/Rw7ZwYGShNTFtaOjD4lOHO8MbbgrSjmOTT45iQ9jAxhxqvwtKpfbhclKRT7+23Edjb6zp0uGVH48mZp8VNzo5Ln4QKPFpn71PcP+t2aowKzlfMCuyIfj+TxZnV6oOPu8rLpeQ=
X-Gm-Message-State: AOJu0Yz+baEETON1wa4fDgkiYIOfbc1FrPYO3BfAD7X8TJ9ioJyHBjI9
	/Tj9zzXzYSmF7q9eclvnD+VPkyXi3Fw4A0GUl3n1P+LBkxcq6VhN
X-Google-Smtp-Source: AGHT+IH/G8z4c2B576zjuU6mEYKeUiX3oaz7z6xzI4Z7ygLsYAeFTgihFUfXwwXryrYsaeYqvXNzvw==
X-Received: by 2002:ac2:5f88:0:b0:514:b624:5d36 with SMTP id r8-20020ac25f88000000b00514b6245d36mr2403655lfe.32.1713175669017;
        Mon, 15 Apr 2024 03:07:49 -0700 (PDT)
Received: from localhost.localdomain ([178.70.43.28])
        by smtp.gmail.com with ESMTPSA id g11-20020a0565123b8b00b00518f53da2dfsm149571lfv.291.2024.04.15.03.07.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 03:07:48 -0700 (PDT)
From: Ivan Bornyakov <brnkv.i1@gmail.com>
To: Nas Chung <nas.chung@chipsnmedia.com>,
	Jackson Lee <jackson.lee@chipsnmedia.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Sebastian Fricke <sebastian.fricke@collabora.com>
Cc: Ivan Bornyakov <brnkv.i1@gmail.com>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/5] media: chips-media: wave5: separate irq setup routine
Date: Mon, 15 Apr 2024 13:07:21 +0300
Message-ID: <20240415100726.19911-4-brnkv.i1@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240415100726.19911-1-brnkv.i1@gmail.com>
References: <20240415100726.19911-1-brnkv.i1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement a separate setup routine for interrupts to reduce code
duplication. Also enable interrupts based on vpu_attr->support_encoders
and vpu_attr->support_decoders fields to facilitate support for other
Wave5xx IPs, because not all of them are both encoders and decoders.

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


