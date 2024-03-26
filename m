Return-Path: <linux-kernel+bounces-119061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FD1A88C387
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 14:34:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E72AEB21EBE
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 13:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33A8674BF7;
	Tue, 26 Mar 2024 13:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PfaoiGYF"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D80F24F890;
	Tue, 26 Mar 2024 13:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711460066; cv=none; b=qbRsI/H5xdDphLRKvrClTSVBqbP8J4w8bykVYefWeG02V2BQteXzB3Lu9yPmLFgpfMXWfP06WSP2CvrlLBemcak6aNAUK/mgg5yPXPIIwSX4rxsdsQYrOapv6jkVS7C/bwBNbFhU8Jk27bgjrlGQ0gwkTfNW28RMh21mmyFx8rA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711460066; c=relaxed/simple;
	bh=FT1vX791HGO7aKS9G/ZPDGT71wZoKwZ8shUH9nLTTLA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=hZ67qxBtMXY46N+nqyU3aHkqkPTuY+A0BcEE7rH/wCKlY/LJpwi66cem0IujPczC+TWWORVTF1p7YCl2s7+PTKMAnd7fr5PEHHIULvRrYaT5ReOR5Sj+5IUZN1w/BciW+GBo6DSdBQM6hMZvKTGv+4d91j6VtD2mQKM6m3Gc+ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PfaoiGYF; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-56c147205b9so3233067a12.0;
        Tue, 26 Mar 2024 06:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711460063; x=1712064863; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MS1VY+YyK3WfAN9Fvb2/BOf2p6kWCOG3l21nlXYxAzI=;
        b=PfaoiGYFivPQ5McUPl2bIEb1FFTrR0Xydo15KMAsbPO3zvP6vIIEIz/iuRGDKXahzA
         vZY+LoyNpXf6agVXa+JGQxDNKy5oQxL1obrqjJnfVAkfF0iJDAWGlXoISesMKrHqvy5Y
         JIW9KMIx7TwvitwarLnFbm8n/NCAY/qmTA538GSpNBz+6oSPbZ0S2R2AFYTc5mSTUV1x
         hzYPuNxG34n3fTMkrQGtO/1Osn6DH08mr1hA6VpS4tobbg1BgLbLhj5FONNKU4mYeaOS
         ev3tXtItWrAPG4qEO0Jeb02dR3tPr9U8TvHTvI3VQdeqFSOx6vX4WEKNAKNmMLeEQD9Q
         SPeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711460063; x=1712064863;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MS1VY+YyK3WfAN9Fvb2/BOf2p6kWCOG3l21nlXYxAzI=;
        b=JJdD+T1rKaQlvyldVY7jWd425Ne5cHraKRZtEbSJUc/6g0y0jckFRuPRx03bkWt+bL
         /pWxJ3BnnpL3z4lRwMNgl8LBNhRYi/1Heq/yL2PgazzoflTURpwIQOnZrtG06jx8+/i7
         uxOQ/cLqd93Q+hoSq6/sZLCeRnHjK9SGdsIaJD/Bt/HVh9BDmCUwRGgxuaVhr9b8Evh4
         2SHcxptSk1VQ7SF4S3+y5oBOTXwx50GkaDc9Bo9hTwj7tppeE/SDV5wby+3yYn4VNf8Y
         1iOFQiN+rW6S+/WksMG9QnxnSX3cdWxhsbc1c4MrfIWbLEfDL6aOH6jH86tfclCMX1Cp
         j1LA==
X-Forwarded-Encrypted: i=1; AJvYcCUsgH1tUhK1o+W8H09tWP9DwWx/aEY90P7GvenMwJPDMluozcycvKGjqjnmk0h3vuy4JtRtHtpPF6F7j1w2rd85ek9YDRq7+0moFPYcrguWCC6COUeJVRbT+9CIoKOU0wOfNh2DXwQs
X-Gm-Message-State: AOJu0Yzlo8xR/JF8yoUMTikictvPN27TlG+SFcnig858fyGFnGB1fxwb
	0GuHf3/no+qtdFSzQBJUgHFRR0tZoVyr2sPH20CwUMD4dKp8WH16
X-Google-Smtp-Source: AGHT+IG8/Od7w+V1C3/Y6DkJoNE3VLKfgWZDJyxZHEjxxObhmW7WJ+p3G9ws/FpiMjGOJCQyvMyWPA==
X-Received: by 2002:a50:9ec3:0:b0:568:c6d5:e13a with SMTP id a61-20020a509ec3000000b00568c6d5e13amr1351788edf.15.1711460062735;
        Tue, 26 Mar 2024 06:34:22 -0700 (PDT)
Received: from [192.168.1.253] (57657817.catv.pool.telekom.hu. [87.101.120.23])
        by smtp.googlemail.com with ESMTPSA id bc5-20020a056402204500b0056c3048e64esm134184edb.70.2024.03.26.06.34.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 06:34:22 -0700 (PDT)
From: Gabor Juhos <j4g8y7@gmail.com>
Date: Tue, 26 Mar 2024 14:34:11 +0100
Subject: [PATCH] clk: qcom: apss-ipq-pll: fix PLL rate for IPQ5018
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240326-fix-ipq5018-apss-pll-rate-v1-1-82ab31c9da7e@gmail.com>
X-B4-Tracking: v=1; b=H4sIANLOAmYC/x2MWwqAIBAArxL73YLag+gq0YfmWgtR5kYE0d2TP
 gdm5gGhxCTQFw8kulh43zLosoBpsdtMyD4zGGVqVZkWA9/I8WiU7tBGEYzrismehIF8ZV2jnZ4
 M5D4myvL/Hsb3/QAZtxYsawAAAA==
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, 
 Sricharan Ramabadhran <quic_srichara@quicinc.com>, 
 Gokul Sriram Palanisamy <quic_gokulsri@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Gabor Juhos <j4g8y7@gmail.com>
X-Mailer: b4 0.13.0

According to ipq5018.dtsi, the maximum supported rate by the
CPU is 1.008 GHz on the IPQ5018 platform, however the current
configuration of the PLL results in 1.2 GHz rate.

Change the 'L' value in the PLL configuration to limit the
rate to 1.008 GHz. The downstream kernel also uses the same
value [1]. Also add a comment to indicate the desired
frequency.

[1] https://git.codelinaro.org/clo/qsdk/oss/kernel/linux-ipq-5.4/-/blob/NHSS.QSDK.12.4/drivers/clk/qcom/apss-ipq5018.c?ref_type=heads#L151

Fixes: 50492f929486 ("clk: qcom: apss-ipq-pll: add support for IPQ5018")
Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
---
Based on v6.9-rc1.

Note: The change is independent from the "clk: qcom: apss-ipq-pll: various
cleanups" series posted earlier [2].

[2] https://lore.kernel.org/r/20240326-apss-ipq-pll-cleanup-v3-0-15c4aeeb14ac@gmail.com
---
 drivers/clk/qcom/apss-ipq-pll.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/apss-ipq-pll.c b/drivers/clk/qcom/apss-ipq-pll.c
index 678b805f13d45..5e3da5558f4e0 100644
--- a/drivers/clk/qcom/apss-ipq-pll.c
+++ b/drivers/clk/qcom/apss-ipq-pll.c
@@ -73,8 +73,9 @@ static struct clk_alpha_pll ipq_pll_stromer_plus = {
 	},
 };
 
+/* 1.008 GHz configuration */
 static const struct alpha_pll_config ipq5018_pll_config = {
-	.l = 0x32,
+	.l = 0x2a,
 	.config_ctl_val = 0x4001075b,
 	.config_ctl_hi_val = 0x304,
 	.main_output_mask = BIT(0),

---
base-commit: 4cece764965020c22cff7665b18a012006359095
change-id: 20240326-fix-ipq5018-apss-pll-rate-fed3ab51b1c2

Best regards,
-- 
Gabor Juhos <j4g8y7@gmail.com>


