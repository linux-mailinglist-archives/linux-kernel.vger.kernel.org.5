Return-Path: <linux-kernel+bounces-78397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C91258612ED
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 14:40:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84C7E286314
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 13:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9371981723;
	Fri, 23 Feb 2024 13:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uaAeS5iX"
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 418C722EF5
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 13:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708695579; cv=none; b=jKh4O20NOOXGzZXVXyLRacSjfIlhpfJ20M3h3lAeO+Uj0aRQLFzQSgJj121r0T1Ebv4vixBEYcOoguDmOxqVwogxXwqIcGf1DA/fYM4SKn3W5Hu1vUUPQLNX5CZuwJE0GBqsJPeoKzesvN257Qbeh2f5utj1RDpM4xhoiVkvNdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708695579; c=relaxed/simple;
	bh=voB5J/gWI489fiUoN4WmnD8Oq5taa5Y4VccTJXCT+QE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Rsr4HqA17Ptjh5h9Ml1j9AtPkFMqVBPEowB3X/Sdj+BrXNKAd9CMtzKPpOt2j3KeB8sGCVQ/mmrfmFTrf0XLlrK8h0+d1E5Dv5/HgnsmFL4izO2hZmJy+BaAptSmXKyNdAQ4M1t8fIxI8G6IpEdM86J97bAXjHxPL5YGYEMuNJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uaAeS5iX; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-7c488a5af5eso22088639f.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 05:39:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708695577; x=1709300377; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xWiT0h/7JNt0Wi4P0Jnc6qFGd/ux4GQTUN2IFCPouK8=;
        b=uaAeS5iXsXCcQS4/sxdIhXb0mq1RQjZpzM1pMf9R5LmxdKff0ufM+etG24zUvi2VUZ
         EszG8klHN2iluUxKU3CQeo55niFdqRkSepv5tqdqrzvezpCdTL4+RFIdCDg7LT3DDPiu
         9rtXZVzOnI7HDsWYqfZZOU6sTa/msfCnAzQy4VR51cwI5LjuCFzjduk1YiwkEEsBv9wR
         p3oMgg1KJGHJdXFkX/Ku12SKkJCfOVdsfumb91fFQ6JdeKHPPu/to+3ZPzkKmPCX1eyu
         QXPLJt3PjDn8gbje7eW3wstzg3C7ZcuSqpS90FP8e/3IsarVmcMKCkdYCcWlWRTsibQV
         WrDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708695577; x=1709300377;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xWiT0h/7JNt0Wi4P0Jnc6qFGd/ux4GQTUN2IFCPouK8=;
        b=fXKAuhtKHB3yibqg4gLEtZn41jRkxb0N2fPCaM7ci0bxC8zax+W4ZzXwAWMVjldGj1
         /bojv/hhREHpup57QAuRjWQWzKlqq+ziKIa1CFZ2k7ynuLGd7ZAxEskEoZX952Tt/2ZK
         4WKPZxO5YY0fpOeOrzvHObUZPXFn/v8YUC0HA2amPTccPhLC4A1WOSL4PpxWIirXmL0B
         L9m5tHqZGvdSsjQ5e4w9VwzC9WQdJmnRoGLfiWxFXVsaymibf0pf2PSjA8FkLCgMnFU6
         wEL8q1R5nB5N2O7YI/1KkUfnczRQqKxylnIi45UhqlsN/uhB2B0Iocn731bCuCpIIZrE
         AfXw==
X-Forwarded-Encrypted: i=1; AJvYcCW/4PLkCUa0YraTFv75LmEPwFNpMmoYNWbFzTtxYRWbRK4NGCorX8BhtVVLDILwRnNVVeMqCNaol7CwX+RZIjdhfSCW+N5YVjBAIJkD
X-Gm-Message-State: AOJu0Yy8WvbT8apOZaQcXCYJtK1u2sDy00NONu+bWWkLQSTgShdGhmsF
	WjuLd7zGIgSvEXDTQb/28q0tlcGC8G63zQZ+XgSEtErV8mHBSK/wkroZEl9Y7p0=
X-Google-Smtp-Source: AGHT+IGNKITui78tgeJKpSFfKPvLuXP9hpg0hkvTUTZ1gUgB1JNcJrjXSv8yGqV5nkB0u574NEl53g==
X-Received: by 2002:a6b:5f0e:0:b0:7c4:831d:32e with SMTP id t14-20020a6b5f0e000000b007c4831d032emr1877101iob.0.1708695577350;
        Fri, 23 Feb 2024 05:39:37 -0800 (PST)
Received: from localhost.localdomain (c-73-228-159-35.hsd1.mn.comcast.net. [73.228.159.35])
        by smtp.gmail.com with ESMTPSA id p11-20020a6b630b000000b007c76a2d6a98sm1836838iog.53.2024.02.23.05.39.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 05:39:37 -0800 (PST)
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
Subject: [PATCH net-next 2/6] net: ipa: kill IPA_POWER_FLAG_SYSTEM
Date: Fri, 23 Feb 2024 07:39:26 -0600
Message-Id: <20240223133930.582041-3-elder@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240223133930.582041-1-elder@linaro.org>
References: <20240223133930.582041-1-elder@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The SYSTEM IPA power flag is set, cleared, and tested.  But nothing
happens based on its value when tested, so it serves no purpose.
Get rid of this flag.

Signed-off-by: Alex Elder <elder@linaro.org>
---
Note: checkpatch warns: braces {} are not necessary...

 drivers/net/ipa/ipa_power.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ipa/ipa_power.c b/drivers/net/ipa/ipa_power.c
index 694bc71e0a170..be9e859e853fb 100644
--- a/drivers/net/ipa/ipa_power.c
+++ b/drivers/net/ipa/ipa_power.c
@@ -37,12 +37,10 @@
 /**
  * enum ipa_power_flag - IPA power flags
  * @IPA_POWER_FLAG_RESUMED:	Whether resume from suspend has been signaled
- * @IPA_POWER_FLAG_SYSTEM:	Hardware is system (not runtime) suspended
  * @IPA_POWER_FLAG_COUNT:	Number of defined power flags
  */
 enum ipa_power_flag {
 	IPA_POWER_FLAG_RESUMED,
-	IPA_POWER_FLAG_SYSTEM,
 	IPA_POWER_FLAG_COUNT,		/* Last; not a flag */
 };
 
@@ -173,8 +171,6 @@ static int ipa_suspend(struct device *dev)
 {
 	struct ipa *ipa = dev_get_drvdata(dev);
 
-	__set_bit(IPA_POWER_FLAG_SYSTEM, ipa->power->flags);
-
 	/* Increment the disable depth to ensure that the IRQ won't
 	 * be re-enabled until the matching _enable call in
 	 * ipa_resume(). We do this to ensure that the interrupt
@@ -196,8 +192,6 @@ static int ipa_resume(struct device *dev)
 
 	ret = pm_runtime_force_resume(dev);
 
-	__clear_bit(IPA_POWER_FLAG_SYSTEM, ipa->power->flags);
-
 	/* Now that PM runtime is enabled again it's safe
 	 * to turn the IRQ back on and process any data
 	 * that was received during suspend.
@@ -219,10 +213,9 @@ void ipa_power_suspend_handler(struct ipa *ipa, enum ipa_irq_id irq_id)
 	 * just to handle the interrupt, so we're done.  If we are in a
 	 * system suspend, trigger a system resume.
 	 */
-	if (!__test_and_set_bit(IPA_POWER_FLAG_RESUMED, ipa->power->flags))
-		if (test_bit(IPA_POWER_FLAG_SYSTEM, ipa->power->flags)) {
-			;
-		}
+	if (!__test_and_set_bit(IPA_POWER_FLAG_RESUMED, ipa->power->flags)) {
+		;
+	}
 
 	/* Acknowledge/clear the suspend interrupt on all endpoints */
 	ipa_interrupt_suspend_clear_all(ipa->interrupt);
-- 
2.40.1


