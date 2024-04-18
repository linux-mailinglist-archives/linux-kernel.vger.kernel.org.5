Return-Path: <linux-kernel+bounces-150764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9518E8AA444
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 22:48:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33CD81F22CA3
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 20:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B465199EA1;
	Thu, 18 Apr 2024 20:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G0RM36eV"
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28DE819069F
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 20:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713473261; cv=none; b=BdO4MdzL8TInqD0jGkAv/Hna2OlXzrzNMFJRpA2kEt5FxoZ80YASmRD2gV9lbL1UBwPASYkHnjm9cPy2qpNylJHzCPm6+vtxaBGHyX7mjvJYl0CnLEeqEnIgsiNQuG3DEXafObKv/I6pX28q9nKrb6GunH41IOjgL7YVA3V2RVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713473261; c=relaxed/simple;
	bh=SvZGld3nMQ7dE2gk0jttFi3f7Z56qPw6gijv/jWfvuw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sfxOh9kxUAI17HxQoPJcrb1jz7N5NtZRaM3QKTQLcdQX13Xpc7fm8UPCKTCAmija/rAIVqWMLFF83a9AK5tFBzRn1CVeycaTlJ559S986nzEn85qsnFI39RkmrFOEK3mwlU6d6bnNWBgi2H1JS1YU165Vc/nLpOIkKvP7GRGymg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=G0RM36eV; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-7da4373f850so16451239f.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 13:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713473258; x=1714078058; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=03uMyBMor63/6Po8Y4dDq22jgMVPIQliIIsTiCDwZ1I=;
        b=G0RM36eVMkq+RjztfcJrrLXdtJTC4PaLmDraFFWHHHi/4HPlMgtIo5twMGvrScXlNc
         kFptF0IzjrlRiZj1G4OAYZ5vIZiZE0JfgqEAsywmg4ybKYlZxPu1NVyX+5spN60MBcV+
         cHZ7rd0w3sdaVzJouFjHvVcw/974z/WP9gHnc6mRLXMgTrgbjSeWiVaxYS6DWLg1boQ8
         VIRrU03UyKNQZDXaacyLYJZEnQDcOvOAZ7hUY0D7CgFvY3Snd5LlwdRWai5aCgZU7GD+
         mrAm358TQafIC9SehdJ/C0ADS3eaxBWmk9mKjXYCMOlS7NvTe7KqA7srYOumD7qOSCpu
         FUsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713473258; x=1714078058;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=03uMyBMor63/6Po8Y4dDq22jgMVPIQliIIsTiCDwZ1I=;
        b=h9EHYI3N43DWBB4kDyhZYpCXYoFU6EgGGgc8+isa7pLwKj8G5yzbORIK21jWHdlBYw
         1Jx94I5hTfcaucg+Cf/wfQggrfqpn5v0lo70Ea8MxglUx37EDJu8tKcbKEdqMWgxu5wi
         7TujS30H+Uyl/VDKkqy+uHUKMJ5fvTMsh5M68axrEUOdFOv7o4rPN50yHCILvtInqeap
         ihUcbjUvURvoBMWla36iPgWEaXq1Gjzcv1X5KF95dyjtnNLyZHvVrUfaxNuUORRjGOzm
         hVBupW1npGodvj8pAnPf7FjbhW/bYt3PGASkY3t1b3TWfEn6/RMAG7byy86WWgU+lEnL
         ztGw==
X-Forwarded-Encrypted: i=1; AJvYcCUyOIzXX8FQAAtmew0F/Hf1y+VA9SCbsbmM0UT0aPvIXE2e5OQxRdGZFJJioK/1neyl2pNC5AUDBGCSEQZKGN7MOe01FZ05WjfYFK5K
X-Gm-Message-State: AOJu0YyIx8ZBLIr6Or6D+RUnm/5/qfIKafAqta1UBh0Uo+ERsVQnZ6R3
	EQgdxxvf4rdwVPoHRftbKWckjDOSKafB0ecRmuPh9JuuVTiUkF1tKXS3GVi08zY=
X-Google-Smtp-Source: AGHT+IHi9nm9iUmihVl+nUYkbY20SKDAPRl8ovl9feERHmDZj2/wHFbeuoMxKwaBgbMtCXTT0l1DLA==
X-Received: by 2002:a05:6e02:1aa5:b0:36b:3c05:7163 with SMTP id l5-20020a056e021aa500b0036b3c057163mr309979ilv.32.1713473258189;
        Thu, 18 Apr 2024 13:47:38 -0700 (PDT)
Received: from localhost.localdomain (c-73-228-159-35.hsd1.mn.comcast.net. [73.228.159.35])
        by smtp.gmail.com with ESMTPSA id r6-20020a056638300600b00484948cb8f5sm626998jak.91.2024.04.18.13.47.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 13:47:37 -0700 (PDT)
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
Subject: [PATCH net-next 2/8] net: ipa: only enable the SUSPEND IPA interrupt when needed
Date: Thu, 18 Apr 2024 15:47:23 -0500
Message-Id: <20240418204729.1952353-3-elder@linaro.org>
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

Only enable the SUSPEND IPA interrupt type when at least one
endpoint has that interrupt enabled.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/ipa_interrupt.c |  8 ++++++++
 drivers/net/ipa/ipa_power.c     | 11 +----------
 2 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ipa/ipa_interrupt.c b/drivers/net/ipa/ipa_interrupt.c
index 0e8d4e43275ea..e198712d46ebb 100644
--- a/drivers/net/ipa/ipa_interrupt.c
+++ b/drivers/net/ipa/ipa_interrupt.c
@@ -196,6 +196,7 @@ static void ipa_interrupt_suspend_control(struct ipa_interrupt *interrupt,
 	u32 mask = BIT(endpoint_id % 32);
 	u32 unit = endpoint_id / 32;
 	const struct reg *reg;
+	unsigned long weight;
 	u32 offset;
 	u32 val;
 
@@ -205,6 +206,10 @@ static void ipa_interrupt_suspend_control(struct ipa_interrupt *interrupt,
 	if (ipa->version == IPA_VERSION_3_0)
 		return;
 
+	weight = bitmap_weight(interrupt->suspend_enabled, ipa->endpoint_count);
+	if (weight == 1 && !enable)
+		ipa_interrupt_disable(ipa, IPA_IRQ_TX_SUSPEND);
+
 	reg = ipa_reg(ipa, IRQ_SUSPEND_EN);
 	offset = reg_n_offset(reg, unit);
 	val = ioread32(ipa->reg_virt + offset);
@@ -216,6 +221,9 @@ static void ipa_interrupt_suspend_control(struct ipa_interrupt *interrupt,
 	__change_bit(endpoint_id, interrupt->suspend_enabled);
 
 	iowrite32(val, ipa->reg_virt + offset);
+
+	if (!weight && enable)
+		ipa_interrupt_enable(ipa, IPA_IRQ_TX_SUSPEND);
 }
 
 /* Enable TX_SUSPEND for an endpoint */
diff --git a/drivers/net/ipa/ipa_power.c b/drivers/net/ipa/ipa_power.c
index 41ca7ef5e20fc..bdbcf965d5a30 100644
--- a/drivers/net/ipa/ipa_power.c
+++ b/drivers/net/ipa/ipa_power.c
@@ -234,21 +234,12 @@ void ipa_power_retention(struct ipa *ipa, bool enable)
 
 int ipa_power_setup(struct ipa *ipa)
 {
-	int ret;
-
-	ipa_interrupt_enable(ipa, IPA_IRQ_TX_SUSPEND);
-
-	ret = device_init_wakeup(ipa->dev, true);
-	if (ret)
-		ipa_interrupt_disable(ipa, IPA_IRQ_TX_SUSPEND);
-
-	return ret;
+	return device_init_wakeup(ipa->dev, true);
 }
 
 void ipa_power_teardown(struct ipa *ipa)
 {
 	(void)device_init_wakeup(ipa->dev, false);
-	ipa_interrupt_disable(ipa, IPA_IRQ_TX_SUSPEND);
 }
 
 /* Initialize IPA power management */
-- 
2.40.1


