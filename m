Return-Path: <linux-kernel+bounces-150763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 204328AA43F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 22:48:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C50782849C3
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 20:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 188AD194C84;
	Thu, 18 Apr 2024 20:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sp7hzYh/"
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27341836EE
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 20:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713473259; cv=none; b=PnooW8W/taS8JKiDpEVnlxwK+sUXnx0vlwZRQxdh40LPXeHtrlrdidXXwIY5v++jML4rGHGFgZgIrBm/Xrq5WkxEXRyquzkuz/RhnF3DxUCyIjUjDGlvypDD8RWfDzLf022QJZBIyKl7c7nu4cPMvWVJL5wuZ0tjhvXrgzF+D24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713473259; c=relaxed/simple;
	bh=wOZ29LhTx7wkAYOpITTHRSLIJcO3BmrsfUA3gU19uiE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tvqIDAJGIPgdBRi1GwUJrnBqi2uxHtaDnnYynwPmWGa0xv3mA9bS+xuFor3PgXGPLX7l7nLfJ4kDnQruUs6st9V2z84IiRjKQgMRlVhM/MfkOck4VgohI5JvmAZAGpcCiXQjXGD5/uojoxo6Ot/3OYSvS3R/VG75L+hhprIX7QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sp7hzYh/; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-7d5e93b40feso53612539f.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 13:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713473257; x=1714078057; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6LzULljTo8+N+96QvC2qoioFAtmWDPdfpszoy4xuRkk=;
        b=sp7hzYh/vnpXl0kDurNytDvVYou5VVMG/nV/QX69u5/jedeyFyQTl8g9KWp/YGhLv5
         I2F6KhK6BxRs9k9TWVzV/o5k4VPyx/5iAcpWkcacotk61zD3qWTApwbiqbeKNXAMPKRt
         Ib55CzRsWP70QU7miXjUcPcGm1J9rgqlvvfc+pPaJf7AECop/HBng2uaZ1ceEoUmSSTn
         507zP0vzyPxWKlKAiTD9Tee5mhLdk6omuCKpGgwdBCjKod5TTDnw3mB+YZJiKn0rCIQq
         pmZAUSUM/1ghcCcY0flR8uJH6sDMhoXEjbBFwrUiWoBQ3Sr86CZ248PjQeLxMmeyHk05
         SCLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713473257; x=1714078057;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6LzULljTo8+N+96QvC2qoioFAtmWDPdfpszoy4xuRkk=;
        b=Jk3nM34VOuPfgw7WuRSQWlP9Nc7JsZCmm8rLE8wyivDClPB6kVYr1vGswnVr7H/1br
         1xYB+zuvQ0yIMRGM44isroqp8NMKkyYgIS7IJTZv94iahJLkac8fE7kuTZFYicmR0Rio
         8W3WqylDLQYIuIKBBU3qBchtYu83YMEsttPCMnq0o4nBAKwlOsUBphtWwV3sBMto1+OW
         +CSGssD3WcPdLn03GXejvnZaSyFyJiXkxjVedkbsnRiR73o1Wluzu6SYaTGRlqlxCxqZ
         q+Zutk5PHiAmDAvehJExiTm421vq8jEyxVtD/GYc2uYlbVoWXyJ06z3DsjDPRspnTLAA
         rhEg==
X-Forwarded-Encrypted: i=1; AJvYcCULgWGn5szekfOlTXTdBiem2g1RUFgp0QW80Z3aVBPtt2F4yEr9NIQ9yrCLuq1mRqqZzGg/c50oRfihRzVtTDzW/JtCwgk9wJaawT2z
X-Gm-Message-State: AOJu0YzWPW0hdzIH4xemr3+0Lvqb6wy6tj3hYByKu7Q1uPRgqCnyb7jm
	0oxHZTXFDpSK73VLZw0H82gahrLPpfvEgn1xmDbIAitRvo2dgI5lfDc2Tgeo39M=
X-Google-Smtp-Source: AGHT+IF/8sENsUBtrRO5r7kTRYkTSjppW5lU/+XdQth1kzRoara79a8dQ3dQQLUx9E2VuyuprtPmOw==
X-Received: by 2002:a5d:9a9a:0:b0:7d6:5fb2:56bf with SMTP id c26-20020a5d9a9a000000b007d65fb256bfmr399803iom.11.1713473256983;
        Thu, 18 Apr 2024 13:47:36 -0700 (PDT)
Received: from localhost.localdomain (c-73-228-159-35.hsd1.mn.comcast.net. [73.228.159.35])
        by smtp.gmail.com with ESMTPSA id r6-20020a056638300600b00484948cb8f5sm626998jak.91.2024.04.18.13.47.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 13:47:36 -0700 (PDT)
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
Subject: [PATCH net-next 1/8] net: ipa: maintain bitmap of suspend-enabled endpoints
Date: Thu, 18 Apr 2024 15:47:22 -0500
Message-Id: <20240418204729.1952353-2-elder@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240418204729.1952353-1-elder@linaro.org>
References: <20240418204729.1952353-1-elder@linaro.org>
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
index c44ec05f71e6f..0e8d4e43275ea 100644
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


