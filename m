Return-Path: <linux-kernel+bounces-151650-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79F4E8AB18F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 17:18:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31FA5282865
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 15:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 160BD12FF70;
	Fri, 19 Apr 2024 15:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PpElE5Nx"
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB3AC12F38C
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 15:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713539887; cv=none; b=BApC5o37nk788kCAo/YH9tngZk3dyPKbEo3C33jia+rrH8Z7FyJfhUBZT6XgKTpUp+GaGL4QZvlrFoA0rIPJCJVfh13IrTJ7n6P8SOLlWcuSFrLppoRFkab8Ib254gIuQI38wnlf9lJ1gDx3seF1XyhycViK3K7MPMbWm70B7o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713539887; c=relaxed/simple;
	bh=fD4GtJkND5n3skuzOjX/NHgWkIf/VxMqfAgE+7qbH6A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q+gRh42Iv+vJ5SU1jHp6LMzb1lbMICbDN4aOU+Ip9XtBjRGPhmVSMyNAHf177YAQfOzHhfjdeXqDnLOH2C0V2b8yphpaRYvLI3/qLdlC7CHIyBpsWb2xye3+qZ29fFqK7FOe5Zgu0NRd+yN1SnfQ/1S6GGEm/OYzGEaG/J5oE54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PpElE5Nx; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-7d5e4097a9aso77908739f.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 08:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713539885; x=1714144685; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ozWFvCz/JSLWpvmqAUWIX5N+6wqlehvl2PgyPqAmf3Y=;
        b=PpElE5NxiDJcZR4OOvs5nu5/wF89pl4vwR75fkFv4T+er+HfAvvrX9fwAD7CJ93ALV
         Z2uguRnOU8eQgzfN1ea0rqdJWm6IoYdwBkZHOQXyKi86iDoQ9n7DhSztABi+RiQ5oBoh
         /bdzKio6xCE9/h/T2T7kbNi3HG8m4CXkEDtoYPOEBS1Na5basepfGJTvqUlrkHaAVA3f
         5nSX7nBhESOL5I9bYezGRyv0dCy5RzAdV09IW82oTh3Vgr0rxHdUEgcY4n0DHYCDVkCw
         EVmA1bD05rCGMy5ONiDYISGCty+Js2Sz5PjGviBFfoJwOw1zwiEHAHkCXOK7RcFah8z9
         yA2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713539885; x=1714144685;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ozWFvCz/JSLWpvmqAUWIX5N+6wqlehvl2PgyPqAmf3Y=;
        b=hBO5s0lZ82kNL8VZVSGzaETUqAzJH/9xqx3rT7uD8voF4PEBUGooRVIG3bmHBNKcFU
         IU6cDZQwOfyMktC0E7HdIiUWEsv77SaGg86ftJZS9yxUdQ/UbdQf28VhL4w81lVh8L+o
         tu1+BYPO2e3AF0d1+hjnJR2np18TBgtAAdnrQAxZcMkx0AOMxpmifazabHxg8Wz5jAQr
         9xTdw8m6061OIsKUOOXybJRTkOb6dlHQ8f4b43sUAY6EUG7o3hXtAGQx1qrVgDctZdnT
         u5j1dh5qdxDLUUO3JVl5ky90Eo9d95Wm2QimwSkHsBKXI/5A7iTpc51FVchDpYJlEuSl
         de9w==
X-Forwarded-Encrypted: i=1; AJvYcCWIapO2Em6yLjPvd6FGaxkFV162xK2aFBc9BLUNaRkCGObSDn4mINK+HcmMyqidikjkXHq9rDswumgZ/fXjWXP58dDXPD2WS+dwxEFZ
X-Gm-Message-State: AOJu0YzlB1gD59P1RnzJCMo2wucPkpDMBU8EiJgZDSQfncIdmqN5NBD8
	e/PoR+mHkYw6H/MvqWxdRwE1LTQoolQ86Zjyrt34CrJZwXVtkVZ4Bv6q3T8wRQs=
X-Google-Smtp-Source: AGHT+IEoLoAQWS9gMBMZDr7ok+++sYe7DskbfxC7uwOH1LqCCmAzw/fyNZQHJP1MEjnS2s9+s5izXg==
X-Received: by 2002:a6b:ed0e:0:b0:7d5:f78f:ab0c with SMTP id n14-20020a6bed0e000000b007d5f78fab0cmr2950857iog.20.1713539885132;
        Fri, 19 Apr 2024 08:18:05 -0700 (PDT)
Received: from localhost.localdomain (c-73-228-159-35.hsd1.mn.comcast.net. [73.228.159.35])
        by smtp.gmail.com with ESMTPSA id lc8-20020a056638958800b00484e9c7014bsm116126jab.153.2024.04.19.08.18.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 08:18:04 -0700 (PDT)
From: Alex Elder <elder@linaro.org>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: mka@chromium.org,
	andersson@kernel.org,
	quic_cpratapa@quicinc.com,
	quic_avuyyuru@quicinc.com,
	quic_jponduru@quicinc.com,
	quic_subashab@quicinc.com,
	elder@kernel.org,
	netdev@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 1/8] net: ipa: maintain bitmap of suspend-enabled endpoints
Date: Fri, 19 Apr 2024 10:17:53 -0500
Message-Id: <20240419151800.2168903-2-elder@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240419151800.2168903-1-elder@linaro.org>
References: <20240419151800.2168903-1-elder@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Keep track of which endpoints have the SUSPEND IPA interrupt enabled
in a variable-length bitmap.  This will be used in the next patch to
allow the SUSPEND interrupt type to be disabled except when needed.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/ipa_interrupt.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ipa/ipa_interrupt.c b/drivers/net/ipa/ipa_interrupt.c
index 4d472f4b0002e..18036e9cd161f 100644
--- a/drivers/net/ipa/ipa_interrupt.c
+++ b/drivers/net/ipa/ipa_interrupt.c
@@ -37,11 +37,13 @@
  * @ipa:		IPA pointer
  * @irq:		Linux IRQ number used for IPA interrupts
  * @enabled:		Mask indicating which interrupts are enabled
+ * @suspend_enabled:	Bitmap of endpoints with the SUSPEND interrupt enabled
  */
 struct ipa_interrupt {
 	struct ipa *ipa;
 	u32 irq;
 	u32 enabled;
+	unsigned long *suspend_enabled;
 };
 
 /* Clear the suspend interrupt for all endpoints that signaled it */
@@ -211,6 +213,7 @@ static void ipa_interrupt_suspend_control(struct ipa_interrupt *interrupt,
 		val |= mask;
 	else
 		val &= ~mask;
+	__change_bit(endpoint_id, interrupt->suspend_enabled);
 
 	iowrite32(val, ipa->reg_virt + offset);
 }
@@ -246,7 +249,16 @@ int ipa_interrupt_config(struct ipa *ipa)
 
 	interrupt->ipa = ipa;
 
-	/* Disable all IPA interrupt types */
+	/* Initially all IPA interrupt types are disabled */
+	interrupt->enabled = 0;
+	interrupt->suspend_enabled = bitmap_zalloc(ipa->endpoint_count,
+						   GFP_KERNEL);
+	if (!interrupt->suspend_enabled) {
+		ret = -ENOMEM;
+		goto err_kfree;
+	}
+
+	/* Disable IPA interrupt types */
 	reg = ipa_reg(ipa, IPA_IRQ_EN);
 	iowrite32(0, ipa->reg_virt + reg_offset(reg));
 
@@ -254,7 +266,7 @@ int ipa_interrupt_config(struct ipa *ipa)
 				   "ipa", interrupt);
 	if (ret) {
 		dev_err(dev, "error %d requesting \"ipa\" IRQ\n", ret);
-		goto err_kfree;
+		goto err_free_bitmap;
 	}
 
 	ret = dev_pm_set_wake_irq(dev, irq);
@@ -270,6 +282,8 @@ int ipa_interrupt_config(struct ipa *ipa)
 
 err_free_irq:
 	free_irq(interrupt->irq, interrupt);
+err_free_bitmap:
+	bitmap_free(interrupt->suspend_enabled);
 err_kfree:
 	kfree(interrupt);
 
@@ -286,6 +300,7 @@ void ipa_interrupt_deconfig(struct ipa *ipa)
 
 	dev_pm_clear_wake_irq(dev);
 	free_irq(interrupt->irq, interrupt);
+	bitmap_free(interrupt->suspend_enabled);
 }
 
 /* Initialize the IPA interrupt structure */
-- 
2.40.1


