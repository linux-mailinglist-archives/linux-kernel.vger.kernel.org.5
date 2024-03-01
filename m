Return-Path: <linux-kernel+bounces-88793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD61886E6AE
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 18:04:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 801452893EA
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 17:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 258DA376F1;
	Fri,  1 Mar 2024 17:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fPVwitAF"
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752674697
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 17:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709312576; cv=none; b=gq3t4hqQs9KKE2+rHs4f1ECO+kmhaX327q4N6HZhTAmH2Pg0G/dZ19C/FH+9uIWfsw/BEiAmtiu7pQ191tCSxnsBMjAxJOpodT+0wPV7xSX33odGhj6F+swJ8+9eMOY/hrW8N8wlNK9K394N2UHZ0p72pco2Zk4ufIeDVQN7uL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709312576; c=relaxed/simple;
	bh=pEDv/5wU7sbtDhxVNH7M10AUlaZ8vBb6MddBYxdRtUM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FBJjo2ZcNSB9lRNQihleB4XDKuf4P4IR62dShmd6IpbtTyOA6Gj4kufo6CaN9/PmoN726sT3iIQ6npPsriVD4pc/To7lfIzXZq/AIOXKdtHZ8vvmxkXZj6NTy+yYT5AXQTFi4mknk0iPdEDQiKeFzvPbbt04xJfnLuleubNXW4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fPVwitAF; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-36517375cc6so7824725ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2024 09:02:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709312573; x=1709917373; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CjF4i+Vy6ouwx0EOaBtId9vglat4HShUeD3p4ZJNnXY=;
        b=fPVwitAFZTKFiW3JexhnQtFkAos9fx6cbwlBv8UGW2ytxPMJ8zbJQAJefJB51rWL4l
         QnkVS4r03F5BcbJFn+Jox00lQodhEho6t/kTuWMTJ7kITKRSP/z3i17vMz9yBoH1mW+k
         CNn1n1eMRwvdE4BkAH+bbEV9yDy4ah4U2IK7MIJZPS5NT/rNnv7A1JCRGqtVE5KlW2oA
         I4Bak86W/jskwMNoGcLN8oEAA3351YxjVbhpLKB/HQAv9MUUjPw2qBk0G4/fWvD/aw38
         +5CgW7iUMAGSWF9Ifm+/3Q2ib226udF2s6kYH9SK3W5vdmhI++cQgaUKmTmGlpAygx3T
         /w2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709312573; x=1709917373;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CjF4i+Vy6ouwx0EOaBtId9vglat4HShUeD3p4ZJNnXY=;
        b=rl4Li2+v+PLUflAhiNJfbmDK7CPQy2oqR1CNaw8zBgKCgEInhTvD3Y9sE6vJaewUYj
         H+z7ZoqsVR2RlZea+EdE6XHXfJzPeADnGgm0G/f25zF8Wfa4mLSC8hNXba46GFctUWu2
         wWGE6/zJlDsqopTS8h8IKd/aAD1jQ+tV6biZTmn6HfYqjDsOqFMt8o+Ae2Uhy7N4aqv8
         TEkwto1wzq/RDwvWuZRmVY4uSftmzsBeFqpL2Kim59Kd+3Kc/U3MLltFKLxFCLxQaEEO
         hK5J7P8duJtUf/M6zl8mBuo7YoJNZCzVTSQ3AvCfenonu6kG3OkPWfM5C7a1H+uJUf5X
         X/jQ==
X-Forwarded-Encrypted: i=1; AJvYcCW1kgQ4nZTnypW81muQX5IIAmleC33XmXsi+PFxnLJqw3uYLF+gPiNOAISQ5lBmSVQXpEMnkfPl2jltL/XCYykkWxYuu8XbRhG5qMBT
X-Gm-Message-State: AOJu0Yy2oXCYTsyUgDkrythF/Zx/tDp9U6a+ao5KyqLXhzc6RPcdLizN
	25urA3WMdXkSnzusUtS3LdhOw7HsQhjTBJCg2pJVrk+6WNx37zUfnzxbQuKAxN8=
X-Google-Smtp-Source: AGHT+IHrd68QcExTAOu/aeqCceJo5ZmXmc2iXGYS8ZJMGZzOquE/cm5CHi53LjP1/ur42QPIteCtjQ==
X-Received: by 2002:a92:cd83:0:b0:365:c089:1d3a with SMTP id r3-20020a92cd83000000b00365c0891d3amr2709855ilb.15.1709312573653;
        Fri, 01 Mar 2024 09:02:53 -0800 (PST)
Received: from localhost.localdomain (c-73-228-159-35.hsd1.mn.comcast.net. [73.228.159.35])
        by smtp.gmail.com with ESMTPSA id o2-20020a92dac2000000b0036581060910sm991430ilq.6.2024.03.01.09.02.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 09:02:53 -0800 (PST)
From: Alex Elder <elder@linaro.org>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: horms@kernel.org,
	mka@chromium.org,
	andersson@kernel.org,
	quic_cpratapa@quicinc.com,
	quic_avuyyuru@quicinc.com,
	quic_jponduru@quicinc.com,
	quic_subashab@quicinc.com,
	elder@kernel.org,
	netdev@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 6/7] net: ipa: pass a platform device to ipa_smp2p_init()
Date: Fri,  1 Mar 2024 11:02:41 -0600
Message-Id: <20240301170242.243703-7-elder@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240301170242.243703-1-elder@linaro.org>
References: <20240301170242.243703-1-elder@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rather than using the platform device pointer field in the IPA
pointer, pass a platform device pointer to ipa_smp2p_init().  Use
that pointer throughout that function.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/ipa_main.c  |  2 +-
 drivers/net/ipa/ipa_smp2p.c | 10 +++++-----
 drivers/net/ipa/ipa_smp2p.h |  7 +++++--
 3 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ipa/ipa_main.c b/drivers/net/ipa/ipa_main.c
index 17ee075370ce6..3125aec88e6e1 100644
--- a/drivers/net/ipa/ipa_main.c
+++ b/drivers/net/ipa/ipa_main.c
@@ -888,7 +888,7 @@ static int ipa_probe(struct platform_device *pdev)
 	if (ret)
 		goto err_endpoint_exit;
 
-	ret = ipa_smp2p_init(ipa, loader == IPA_LOADER_MODEM);
+	ret = ipa_smp2p_init(ipa, pdev, loader == IPA_LOADER_MODEM);
 	if (ret)
 		goto err_table_exit;
 
diff --git a/drivers/net/ipa/ipa_smp2p.c b/drivers/net/ipa/ipa_smp2p.c
index 8c4497dfe5afd..831268551d9a7 100644
--- a/drivers/net/ipa/ipa_smp2p.c
+++ b/drivers/net/ipa/ipa_smp2p.c
@@ -220,10 +220,11 @@ static void ipa_smp2p_power_release(struct ipa *ipa)
 }
 
 /* Initialize the IPA SMP2P subsystem */
-int ipa_smp2p_init(struct ipa *ipa, bool modem_init)
+int
+ipa_smp2p_init(struct ipa *ipa, struct platform_device *pdev, bool modem_init)
 {
 	struct qcom_smem_state *enabled_state;
-	struct device *dev = &ipa->pdev->dev;
+	struct device *dev = &pdev->dev;
 	struct qcom_smem_state *valid_state;
 	struct ipa_smp2p *smp2p;
 	u32 enabled_bit;
@@ -262,7 +263,7 @@ int ipa_smp2p_init(struct ipa *ipa, bool modem_init)
 	/* We have enough information saved to handle notifications */
 	ipa->smp2p = smp2p;
 
-	ret = ipa_smp2p_irq_init(smp2p, smp2p->ipa->pdev, "ipa-clock-query",
+	ret = ipa_smp2p_irq_init(smp2p, pdev, "ipa-clock-query",
 				 ipa_smp2p_modem_clk_query_isr);
 	if (ret < 0)
 		goto err_null_smp2p;
@@ -274,8 +275,7 @@ int ipa_smp2p_init(struct ipa *ipa, bool modem_init)
 
 	if (modem_init) {
 		/* Result will be non-zero (negative for error) */
-		ret = ipa_smp2p_irq_init(smp2p, smp2p->ipa->pdev,
-					 "ipa-setup-ready",
+		ret = ipa_smp2p_irq_init(smp2p, pdev, "ipa-setup-ready",
 					 ipa_smp2p_modem_setup_ready_isr);
 		if (ret < 0)
 			goto err_notifier_unregister;
diff --git a/drivers/net/ipa/ipa_smp2p.h b/drivers/net/ipa/ipa_smp2p.h
index 9b969b03d1a4b..2a3d8eefb13bb 100644
--- a/drivers/net/ipa/ipa_smp2p.h
+++ b/drivers/net/ipa/ipa_smp2p.h
@@ -8,17 +8,20 @@
 
 #include <linux/types.h>
 
+struct platform_device;
+
 struct ipa;
 
 /**
  * ipa_smp2p_init() - Initialize the IPA SMP2P subsystem
  * @ipa:	IPA pointer
+ * @pdev:	Platform device pointer
  * @modem_init:	Whether the modem is responsible for GSI initialization
  *
  * Return:	0 if successful, or a negative error code
- *
  */
-int ipa_smp2p_init(struct ipa *ipa, bool modem_init);
+int ipa_smp2p_init(struct ipa *ipa, struct platform_device *pdev,
+		   bool modem_init);
 
 /**
  * ipa_smp2p_exit() - Inverse of ipa_smp2p_init()
-- 
2.40.1


