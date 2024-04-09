Return-Path: <linux-kernel+bounces-137228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F5CA89DF32
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 17:33:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E08731F29EA7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 15:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D347713C9A7;
	Tue,  9 Apr 2024 15:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QOUEkWKC"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E9DC13B5B2
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 15:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712676564; cv=none; b=ZAgQ6A+vqUC5yvr/ak15D7PpTD/yBZre28JsuZEq+hVac8915m+S3jg7P1MQKWMyhmlRjAit+Jx3pCdxCpsfu2oUB7TzDfb+PCvBKJwpyFkwjV2y8c7aHDCKO4zs9dKNAXR0slBQS+OKagbu+UmZDPWCo1iraTtn3pegLMX22dI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712676564; c=relaxed/simple;
	bh=Qii41m4WQHeAZjiOSBCpdD4P8rWOw8ayDA/3aiWLd8s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FHLjhke0mskr7aTFSxhJaGIZ20Stj9+XaAj7XgHW1OX8RU5ipgO3Cv1SxOS1SeC8Gkz2AaLQKi7OQtM0Bz94BnFm7NyIDiS6usaUhic/ZeVC5XiN2TTsAopVn7WWr3FaCGFc8xYafjrhy29pvdAiH4prSjSeDC95DZtBF5Rk0JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QOUEkWKC; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-516f2e0edb7so3137465e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 08:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712676560; x=1713281360; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+rK4J26zOCM/IkzvRWeb9dI3/SvLzqKWXafwI1/aF88=;
        b=QOUEkWKCmCxIBAP5sY/uH9inDRSXrPTOt/86djQ89oKg5GEwGwK0aFQIAXkYIjhbEd
         GKAOSzY2BY2wE/bYWqdnRtw8bAEEaK+Kf4yuufgkB37+1rFM1ztK6AoGrx66/2EpVvqT
         2AdgHeie864URa9l3NaDXNUbDwf8OE27jI+YAswRg551hUo/xqaLO7Vg3cgZo7Pu2sNl
         OrG+AV7dQoirxDx8P7Wec24fJQvS2Nl+50lLFXYREw1QF9H3Hh6Dp8zZ/1syiqkRz1L1
         BuxZ66qxI+zUJ2lUNUM7ug3GCD25uYWGy8OaPP83+oBIysc8mGZiGRTfjivi4oFgdNVm
         +1Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712676560; x=1713281360;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+rK4J26zOCM/IkzvRWeb9dI3/SvLzqKWXafwI1/aF88=;
        b=JMUWb/NX7pJlke52usVteysFPV2Pmeh0sZhjUHR8GGcvFalia3qYsAYMTz+yGxVaOC
         vmZKESmVzF8bErxRq+pdDfB64DKnXkqEhFxrPrtNhNmV1X0ouEujccyywcPsLIFgJpJT
         TysxlExHh2PC8tKFUMhXb6+YXXMpUdUSkZBI5Y00Zt2IcjE/owBiTm37TMfbiUkfcTdR
         aJTUcTcz+VMFSaZ1n0pcGQjCPtdf3Def0X2I/BB/W0kb7mgFUhReZFM7UIGeGRkn7BfS
         OoVuMIF9AmeMDWv8l+W9KFVcYLtNx2wC9w0zI0oZHXwU+lAktbIVNBbU+oCJ29QNby/c
         twOw==
X-Forwarded-Encrypted: i=1; AJvYcCUxTonoBGRSK95qmko1j11Hpzl6ZQsvi222m32YuXH4FxTjltIx9o4QXmU8nW8BaQb9yDtZdVtvFMPbp/xj34FW3vU8FjwHHLz0nLOq
X-Gm-Message-State: AOJu0Yw/VSe04gQASPkFqgejFsFiuVIZkRR6b//yv87+Acy3UyDGjZub
	fkI7ElFKJYe3pJRmQGFU9OTSyG3mQ8gVhHxf8Rz1LW/XhjS6xNMBpAGfQW6W0Cg=
X-Google-Smtp-Source: AGHT+IGMKent0y5+d712rV157ro50tteaT7iALlT9p6G6N21wZ5FvY8p31VZWC1tP1MhiFwnv7+z+g==
X-Received: by 2002:a05:6512:4dd:b0:516:d029:b51e with SMTP id w29-20020a05651204dd00b00516d029b51emr8019855lfq.60.1712676560602;
        Tue, 09 Apr 2024 08:29:20 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id a16-20020ac25e70000000b005159412ab81sm1579990lfr.216.2024.04.09.08.29.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 08:29:19 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 09 Apr 2024 18:29:16 +0300
Subject: [PATCH v2 1/3] usb: typec: ucsi_glink: enable the
 UCSI_DELAY_DEVICE_PDOS quirk on qcm6490
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240409-qcom-ucsi-fixes-bis-v2-1-6d3a09faec90@linaro.org>
References: <20240409-qcom-ucsi-fixes-bis-v2-0-6d3a09faec90@linaro.org>
In-Reply-To: <20240409-qcom-ucsi-fixes-bis-v2-0-6d3a09faec90@linaro.org>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, linux-usb@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1312;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=Qii41m4WQHeAZjiOSBCpdD4P8rWOw8ayDA/3aiWLd8s=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmFV7NfOogr91/8Kf+FoWNU3eahnqt2+8+GmUBf
 1bZb1X99uiJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZhVezQAKCRCLPIo+Aiko
 1foKCACKFkuLgNblvsbMUbIOPyJPkyBv80SJal1FZyJm7wAjvXqbqKaNM40PqGlByQHjZ3zcFuq
 KCpCQw03UbOYRvhnRSNNFptDsnxLdtFXTrp9hhcfNioicXaw22I3GL0UxcYNNCQDQjvjnM+UAm7
 rU4d4GlcxbtlWV2oi/WrUlSFYuDC8pm8VAz5qPC/ZPSAAinWlkjLPm769thDt/W1zfYzO1m2tDp
 8kVfTxwg7hYrvcEUsbq4huiQnxtPTBvFI3rB4NmNoPYqTd5wr2xqkQPdHfFz4ZKSZdw2txDvm3s
 HKdx2E0KR7QCgFoORL4mtqKvGAue+efT4KC/y4aNXNHNTy8A
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Enable the UCSI_DELAY_DEVICE_PDOS quirk on Qualcomm QCM6490. This
platform also doesn't correctly handle reading PD capabilities until PD
partner is connected.

Fixes: 5da727f75823 ("usb: typec: ucsi_glink: enable the UCSI_DELAY_DEVICE_PDOS quirk")
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/usb/typec/ucsi/ucsi_glink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/typec/ucsi/ucsi_glink.c b/drivers/usb/typec/ucsi/ucsi_glink.c
index ef00a6563c88..9bd80a2218e4 100644
--- a/drivers/usb/typec/ucsi/ucsi_glink.c
+++ b/drivers/usb/typec/ucsi/ucsi_glink.c
@@ -316,7 +316,7 @@ static unsigned long quirk_sc8280xp = UCSI_NO_PARTNER_PDOS | UCSI_DELAY_DEVICE_P
 static unsigned long quirk_sm8450 = UCSI_DELAY_DEVICE_PDOS;
 
 static const struct of_device_id pmic_glink_ucsi_of_quirks[] = {
-	{ .compatible = "qcom,qcm6490-pmic-glink", .data = &quirk_sc8180x, },
+	{ .compatible = "qcom,qcm6490-pmic-glink", .data = &quirk_sc8280xp, },
 	{ .compatible = "qcom,sc8180x-pmic-glink", .data = &quirk_sc8180x, },
 	{ .compatible = "qcom,sc8280xp-pmic-glink", .data = &quirk_sc8280xp, },
 	{ .compatible = "qcom,sm8350-pmic-glink", .data = &quirk_sc8180x, },

-- 
2.39.2


