Return-Path: <linux-kernel+bounces-163634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF73C8B6E02
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 11:17:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2B381C20D9C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 09:17:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C458E128828;
	Tue, 30 Apr 2024 09:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Oc2IVSfD"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809F2127B68
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 09:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714468631; cv=none; b=M2zl4jMcyBQSXzw1lbOLOdmvvhDhn7NahU8zQw1fUhcImzAineNzAZ0tDDkOYDjHRPdLpzsjHfPlr3wJFa/r2sP42NKyVK2nUMOHudqYbRTNxMcA82cquGFgZuTakMi3fQaK61u3dksNIi2653goNYCoq8Zt57zbXyjJNysh+/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714468631; c=relaxed/simple;
	bh=kbui8HAPtLFHoAihV2ljcEUIS+VOYj9eDPfH+oMl4OE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pMjs3BXPTXZh0TwwwWKurlnCBFm/7MyBZKf6eGrILByjwaT7sCcZOC6VBx/bWu/6qC40nto7tmWI9EuSYzfrOm8ODnyhNhL4A+e+Yh8MoKQT4DeWBPa36a5c+bL5ZyWGSdiQlyVL0Mroz0LlfbfsnHExSxAZ1pcfegeMHYjWAf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Oc2IVSfD; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-41c7ac71996so9454215e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 02:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714468628; x=1715073428; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y6uTqfKoynlVxjI21T7uYyBdXiDNj2CtWTfpf3yueTA=;
        b=Oc2IVSfD8ouli3xisE6+E+Mh80edYEPXMvWg3VzBtrjnKBcMuqSNNl9AO4Tc/XBcim
         JoZeZ2dr7BKkYQNyOrqXCu32oASvpfQmGsySXSt79x5bJ8sgpfOK6uwabY3HpiFngxtq
         Rr7z7vdTJTXIOnaO6DKBwqxEEXELaaT4ijA9f3BSqwcVts5OEc7TSpy1PI4Aqhfo03MY
         1O9BZE5eB9nJLgf21M3SXLPlKb/A+WbMfwEUEGdlR2soYtvPmCq9gP7eYwT6RJtA7SmO
         yTi1thqPKi4kjcXvOBtEStRcgX/kxCnVzLXTnQdUUIQAPsHYz6COQVFJ6xeYAkqq3RYG
         Hppg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714468628; x=1715073428;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y6uTqfKoynlVxjI21T7uYyBdXiDNj2CtWTfpf3yueTA=;
        b=P8aj01b5QLy+WS8PXmyrRt5jLB0Zk77GNn0voIw2/Y/fNwL0f5Dxb/WcPZOuUiTkxw
         r1L9bY8s6Y8VquC/Zn3ba2w8P4+3Pjw81nKWrQV8mYKX+5veGx0k43ZuBzYZSeoCuNhq
         b8p6m/GLJqtSx1kLXNNCaXqFDypsjeLdmI3FMJbSe3k3jxtojNJo7EapO1XN1MJ2sE5O
         IEmPxKCPkD+ZWtptlbAQVXYj98tOxebWuovkO4dD2AOlc1/M5MnpZ2gR8aWff9Lo/PLm
         Ct7nQ/rogIjhJknXftayPgkInZMpQvFsxy6mxP0aKqi/Ox/eJi5OFuCt386aiawwCbeL
         QE+A==
X-Gm-Message-State: AOJu0Yz02tqa+m9vJTWLiDLO6kDQaG1FfLhNomvLK6ZTtSf96Rgq0LTp
	IRjx9oSOg7zk1U/ygc3pyAMTD8PmGJkoEnUG06zYF5655jMMPhUUCyo6kpzX76E=
X-Google-Smtp-Source: AGHT+IHS+kEpMsge5Lat4FHl3SzA9hj0fc9sA/LacPhgmWil245qKTdxCK5Cna1s9b2LsxDX+eQAXA==
X-Received: by 2002:a05:600c:1c91:b0:41a:ff7d:2473 with SMTP id k17-20020a05600c1c9100b0041aff7d2473mr9514585wms.4.1714468627926;
        Tue, 30 Apr 2024 02:17:07 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id l6-20020a5d4106000000b0034d8b0b5329sm935513wrp.87.2024.04.30.02.17.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 02:17:06 -0700 (PDT)
From: srinivas.kandagatla@linaro.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Viken Dadhaniya <quic_vdadhani@quicinc.com>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [RESEND PATCH 1/3] slimbus: qcom-ngd-ctrl: Reduce auto suspend delay
Date: Tue, 30 Apr 2024 10:16:55 +0100
Message-Id: <20240430091657.35428-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240430091657.35428-1-srinivas.kandagatla@linaro.org>
References: <20240430091657.35428-1-srinivas.kandagatla@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1312; i=srinivas.kandagatla@linaro.org; h=from:subject; bh=RFguBTYvrqxK+fOEwZrYRQmoHKkXcXeO9yaMOm+ScGw=; b=owEBbQGS/pANAwAKAXqh/VnHNFU3AcsmYgBmMLcFDiccHI2mEf0fLCFWeIjJ/nOeJGEyIe6SJ 3Hw8oYeu+GJATMEAAEKAB0WIQQi509axvzi9vce3Y16of1ZxzRVNwUCZjC3BQAKCRB6of1ZxzRV Nyo7B/9Yc+f/HLdPowfEFdgoiSDoutDH9IxcINc9mjzDfExtHWW9WPC898DdVoCQ0HyYSIH9YcV 1mjovBkITfZDKkyq29oFhEuyVzocfjzQFWgZAKXZtrA2tCyoegkCIuB1CYmaKifuqvmuLqKpvEo uFhyhn6DsSqez6c4lAKGB9125cuWPI01bJApmXWHJ9yVSlQfMUNDY8LUHqwsFb2CwQ1sLjnZ2DJ DLYnC8ANE83NZCXZ7tqwPnv/3nFKFOTM/Xc3/afHzh4F78rt0Ycx2Q9UPEGlbI/cW1T0zCFLVt+ EQ6Q+/XQARjGBFCooBMr1UjXhCfpOmbW/dsgxIkxKV1fI6Uy
X-Developer-Key: i=srinivas.kandagatla@linaro.org; a=openpgp; fpr=ED6472765AB36EC43B3EF97AD77E3FC0562560D6
Content-Transfer-Encoding: 8bit

From: Viken Dadhaniya <quic_vdadhani@quicinc.com>

Currently we have auto suspend delay of 1s which is
very high and it takes long time to driver for runtime
suspend after use case is done.

Hence to optimize runtime PM ops, reduce auto suspend
delay to 100ms.

Signed-off-by: Viken Dadhaniya <quic_vdadhani@quicinc.com>
Acked-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/slimbus/qcom-ngd-ctrl.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/slimbus/qcom-ngd-ctrl.c b/drivers/slimbus/qcom-ngd-ctrl.c
index a09a26bf4988..ce28ac35b2b6 100644
--- a/drivers/slimbus/qcom-ngd-ctrl.c
+++ b/drivers/slimbus/qcom-ngd-ctrl.c
@@ -81,7 +81,6 @@
 #define SLIM_USR_MC_DISCONNECT_PORT	0x2E
 #define SLIM_USR_MC_REPEAT_CHANGE_VALUE	0x0
 
-#define QCOM_SLIM_NGD_AUTOSUSPEND	MSEC_PER_SEC
 #define SLIM_RX_MSGQ_TIMEOUT_VAL	0x10000
 
 #define SLIM_LA_MGR	0xFF
@@ -1575,7 +1574,7 @@ static int qcom_slim_ngd_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, ctrl);
 	pm_runtime_use_autosuspend(dev);
-	pm_runtime_set_autosuspend_delay(dev, QCOM_SLIM_NGD_AUTOSUSPEND);
+	pm_runtime_set_autosuspend_delay(dev, 100);
 	pm_runtime_set_suspended(dev);
 	pm_runtime_enable(dev);
 	pm_runtime_get_noresume(dev);
-- 
2.25.1


