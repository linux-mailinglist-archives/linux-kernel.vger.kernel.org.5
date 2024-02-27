Return-Path: <linux-kernel+bounces-83781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67DCC869E60
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 18:55:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D187B1F26D2C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 17:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74504149E1E;
	Tue, 27 Feb 2024 17:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HyWqEKdG"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA1A4EB4E;
	Tue, 27 Feb 2024 17:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709056507; cv=none; b=tBwkcnta07D2Co+X72eiPdKnjp51VVHswAhdiheHeC5BN1RL8bVvXkQw5eOBohKs7jwRlA0x4LFBnNoSiJ3YTtuufGjeJRQYIbuSneKb8dIjYrE24X0FfahZhXyFSjVGXLGAhth7AdDec2CDh5fTkD2JinmUd5bplRR6XebCsbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709056507; c=relaxed/simple;
	bh=q9ueplxYhi98+UBEUHecGoVjaUp535cabJ8paga2Ed4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h5BJMzhoEBQGY6t8Uy1tdDnsxL30DBUMQqmeu40Ke8sKM4EA1G9pIncuree6dEYYlixdHSXDD/04d4ujxbiw++sOkUexEW8AYV9oCtq5HWNQ9PS2IjlcyQ7su0yAfLM1iQ1scty4COBqfYpoiGpgcEFwxnJ6loTZ0rkkUuMSSGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HyWqEKdG; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-563c403719cso5718895a12.2;
        Tue, 27 Feb 2024 09:55:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709056504; x=1709661304; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BVlONAcSg6a81indCcHuuDbeAPV2j9CegTXZdcqHY90=;
        b=HyWqEKdG0VCSOPx9JYakmYgk75cAXAa7f+gRLOjzeSm8xdoXf5y3f/GPIgMrkz54Pk
         8KZjioWd2YXdhHEAOFQ4X565n8MlaB5tXOp4LAU50x555QNo/dG2r1YQKjw/hHG3eazK
         k8PBnExA7qJd5oxmrFlQWzZ+CXIM7yxxhORNux2s83lkC+ncuxeZHsjaZasby6lrfdB7
         4UcFzZrAkTpHFDfbiFfoPDCMkpC6ZTBQ9hW1CnUgiGWJlxrqYm87oqdpfIcydW6Chzem
         T8b/cSBf5NP+6Tc2GUtK/qsf10xWlIvqLbV3mnAMY7GRTB7BKk0dSkXtVAR4WkJDcXsA
         RRTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709056504; x=1709661304;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BVlONAcSg6a81indCcHuuDbeAPV2j9CegTXZdcqHY90=;
        b=cPZWrsXF1J2YuCc6/F3FFkCJFW7ge5t61IGjUuEp1jkl4IfbZTyFWIh5963f0tq6Du
         jGsXz9p4FXbCw3nCo6lTydXgX/ObaZOHNAQQL/suMHp6Z9YgRxhCVI0/BbDF+T4KRGfJ
         eY7Q6cjJfrwl9dK442tbw+v/IYmAxQL8KtKhfRtDsPhweaiozi03U77YCg32xRDfGG3w
         TE/KmjecKHaWlUzbVoHKVAmbBQ/lUZRbDMfUy1B//SdVE+gw1j5kzikXN8ryCgvRCHSC
         W0uWhYY8B7yzgmO9YbzfM03EWQFjKCisiWQUx0UQgT/9VqTNjNm1lxt7Lg1P1NcdBBdb
         Zk8A==
X-Forwarded-Encrypted: i=1; AJvYcCUQW9o9c+hn7hsW/P6GH8xI9Ssj30Qp3wwBHhPSkytYATgNe5HpouBViFJgzfhh45uaXnJqxweqdVqVbVHxe/d0oYl7GbC3YXhxUbkUX+Y8klz5TsU0RXkO0ArrtTInqserD32K
X-Gm-Message-State: AOJu0YzAX+ZtGzOr19CB2WQGci2bFLj/pZBv1coTKgu8lHSuSMBoBMwR
	fsPf2a+/+NlpoEquoGiiqauxXy7Zc9nExpOyB3kNRAOcJ6rXEt+0
X-Google-Smtp-Source: AGHT+IGECCHaGSn58c+BkrzitUFqdhIZub7xSQKgddkNOTBGUkJGxD3D5r28AH2OIM6mtka+N/oTtQ==
X-Received: by 2002:aa7:cd19:0:b0:564:4a18:45f1 with SMTP id b25-20020aa7cd19000000b005644a1845f1mr7993721edw.17.1709056504041;
        Tue, 27 Feb 2024 09:55:04 -0800 (PST)
Received: from fedora.. (cpe-109-60-83-139.zg3.cable.xnet.hr. [109.60.83.139])
        by smtp.googlemail.com with ESMTPSA id fd1-20020a056402388100b00566439b97c4sm629268edb.44.2024.02.27.09.55.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 09:55:03 -0800 (PST)
From: Robert Marko <robimarko@gmail.com>
To: andrew@lunn.ch,
	f.fainelli@gmail.com,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Robert Marko <robimarko@gmail.com>
Subject: [PATCH net-next v2 2/2] net: dsa: mv88e6xxx: add Amethyst specific SMI GPIO function
Date: Tue, 27 Feb 2024 18:54:22 +0100
Message-ID: <20240227175457.2766628-3-robimarko@gmail.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240227175457.2766628-1-robimarko@gmail.com>
References: <20240227175457.2766628-1-robimarko@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The existing mv88e6390_g2_scratch_gpio_set_smi() cannot be used on the
88E6393X as it requires certain P0_MODE, it also checks the CPU mode
as it impacts the bit setting value.

This is all irrelevant for Amethyst (MV88E6191X/6193X/6393X) as only
the default value of the SMI_PHY Config bit is set to CPU_MGD bootstrap
pin value but it can be changed without restrictions so that GPIO pins
9 and 10 are used as SMI pins.

So, introduce Amethyst specific function and call that if the Amethyst
family wants to setup the external PHY.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Robert Marko <robimarko@gmail.com>
---
 drivers/net/dsa/mv88e6xxx/chip.c            |  5 +++-
 drivers/net/dsa/mv88e6xxx/global2.h         |  2 ++
 drivers/net/dsa/mv88e6xxx/global2_scratch.c | 31 +++++++++++++++++++++
 3 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index f9378fca8305..9ed1821184ec 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -3712,7 +3712,10 @@ static int mv88e6xxx_mdio_register(struct mv88e6xxx_chip *chip,
 
 	if (external) {
 		mv88e6xxx_reg_lock(chip);
-		err = mv88e6390_g2_scratch_gpio_set_smi(chip, true);
+		if (chip->info->family == MV88E6XXX_FAMILY_6393)
+			err = mv88e6393x_g2_scratch_gpio_set_smi(chip, true);
+		else
+			err = mv88e6390_g2_scratch_gpio_set_smi(chip, true);
 		mv88e6xxx_reg_unlock(chip);
 
 		if (err)
diff --git a/drivers/net/dsa/mv88e6xxx/global2.h b/drivers/net/dsa/mv88e6xxx/global2.h
index 20fefa08f54e..82f9b410de0b 100644
--- a/drivers/net/dsa/mv88e6xxx/global2.h
+++ b/drivers/net/dsa/mv88e6xxx/global2.h
@@ -380,6 +380,8 @@ extern const struct mv88e6xxx_gpio_ops mv88e6352_gpio_ops;
 
 int mv88e6390_g2_scratch_gpio_set_smi(struct mv88e6xxx_chip *chip,
 				      bool external);
+int mv88e6393x_g2_scratch_gpio_set_smi(struct mv88e6xxx_chip *chip,
+				       bool external);
 int mv88e6352_g2_scratch_port_has_serdes(struct mv88e6xxx_chip *chip, int port);
 int mv88e6xxx_g2_atu_stats_set(struct mv88e6xxx_chip *chip, u16 kind, u16 bin);
 int mv88e6xxx_g2_atu_stats_get(struct mv88e6xxx_chip *chip, u16 *stats);
diff --git a/drivers/net/dsa/mv88e6xxx/global2_scratch.c b/drivers/net/dsa/mv88e6xxx/global2_scratch.c
index 0e15efd898f2..61ab6cc4fbfc 100644
--- a/drivers/net/dsa/mv88e6xxx/global2_scratch.c
+++ b/drivers/net/dsa/mv88e6xxx/global2_scratch.c
@@ -290,6 +290,37 @@ int mv88e6390_g2_scratch_gpio_set_smi(struct mv88e6xxx_chip *chip,
 	return mv88e6xxx_g2_scratch_write(chip, misc_cfg, val);
 }
 
+/**
+ * mv88e6393x_g2_scratch_gpio_set_smi - set gpio muxing for external smi
+ * @chip: chip private data
+ * @external: set mux for external smi, or free for gpio usage
+ *
+ * MV88E6191X/6193X/6393X GPIO pins 9 and 10 can be configured as an
+ * external SMI interface or as regular GPIO-s.
+ *
+ * They however have a different register layout then the existing
+ * function.
+ */
+
+int mv88e6393x_g2_scratch_gpio_set_smi(struct mv88e6xxx_chip *chip,
+				       bool external)
+{
+	int misc_cfg = MV88E6352_G2_SCRATCH_MISC_CFG;
+	int err;
+	u8 val;
+
+	err = mv88e6xxx_g2_scratch_read(chip, misc_cfg, &val);
+	if (err)
+		return err;
+
+	if (external)
+		val &= ~MV88E6352_G2_SCRATCH_MISC_CFG_NORMALSMI;
+	else
+		val |= MV88E6352_G2_SCRATCH_MISC_CFG_NORMALSMI;
+
+	return mv88e6xxx_g2_scratch_write(chip, misc_cfg, val);
+}
+
 /**
  * mv88e6352_g2_scratch_port_has_serdes - indicate if a port can have a serdes
  * @chip: chip private data
-- 
2.43.2


