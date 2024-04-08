Return-Path: <linux-kernel+bounces-134689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90BD389B518
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 03:06:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F237281546
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 01:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BCEE184F;
	Mon,  8 Apr 2024 01:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pjcxxf8l"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E33B1EBB
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 01:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712538404; cv=none; b=icYTNL9LaJmBhhUKqJe0NIq/xtM8vnoWVfXXMKps45e3y/o0If2X10C6iqzguJE4k32rhwQMS9nTkUCmo3yu9otNc+NU4vKBPxsDBuzj7u1sQB2VR9eLEvytGmkhg8LSK0uDS5xZJh+gBim1MWL6w6/zgntP6j7mK2f9l1OUwYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712538404; c=relaxed/simple;
	bh=d+ruzdmvGa/okGAGeYbBxEzaBs0mn1exB2go+KqLJPk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=lqh+OGSC72xtn+Kqnd+yWG6E6LgkaVEg7BgjapuktG2kMCsb2l8fBfajqUyOEF/RQVVs5qMFH/Z8TeC/Nm6R/rzhe2J3zVLbqkJ/eqBnKiHmgmE+CE8cwKJr92PUPz/xooTSO5w6I7lGsbdRS9lm1EWYYzkSvRJM8FXtgEIB9bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pjcxxf8l; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-56e6282dd72so216145a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 07 Apr 2024 18:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712538401; x=1713143201; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UVWIf+cNR8uAkF1rG7ZsWkZNC2MxcJK/X8n15oF2cWA=;
        b=pjcxxf8lkkCVyNC0NvJpX/IwNCpXYitiC90mBlmPLmkY9UQq4xl+KJK6M+qCHUessC
         0b20KvWTZrqj8O70yA0/mnquvSSS8VxubmsUG+Nd71EOAMvXNXad6SZEU9ZX0r4/dQgQ
         W+llfJbF5nBIMA1624MDmGkJGG4jRctSAQxpetmQ0FrcL7OTEuDMg3mKHVtk81A+67OI
         BlVJReV0nK3kGZui/MbXJ7PqF4Bp27JtV32TEsVpGe9HhUr8Pvvl5bpKyx0u1G4LX05x
         T/G+DyLGGgHKCGJ+LEFeS2xRxyPKS4SoiiE6Eki8YiAtdMOBguF9fd6kwFewSPYNlW7/
         Yf7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712538401; x=1713143201;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UVWIf+cNR8uAkF1rG7ZsWkZNC2MxcJK/X8n15oF2cWA=;
        b=haoACNB/X5YTUoqxknCXaexeZIoBeMnuLiFkV6F/LMvS3xN3DospAM2sblhy3PTAM1
         s2DCeljwyDQRO9OIXxlSppsQg65G5MEvDiLQuy4hGe1llxZpNVkQvuP5Ug3PPJcwvDse
         VvuZ8QP5k52p1uU9bHBQ5AwvslYNmX5XoPPMH7RtpZyCcb0V5Ngl4s5JoKoo6z39W1zJ
         7Zzogit9O/ZhPubos5kgYamQTWaVL/HsWzM5k1OAAwLf0Z9g4c+3Ot7P/9OOIyhaBfgS
         uODlYNI/BqUwudhZ6/UdBwfnUHqrsUE+n44s0iZD6oeDIg+XbhDvDA3r9aFt5W+u0Lvr
         sWfQ==
X-Forwarded-Encrypted: i=1; AJvYcCVoAAp9j+9M3BHBErUNjiOIdXXXngyInMSqv3RtO4oSkoOa9Dk/AJE6PWhllVa2GDohsvWbhepXic4TPVQ3sdmcLru5R9V5ScpyYGU6
X-Gm-Message-State: AOJu0Yzz45yWvLCiLIdgmRbkALbvlnPaiKsz0dAMJ2egS592OL/YFh37
	+nIkTEddG8JWvRiy2Xd02hXoMWK36qRSrv2+MWtuJuSriIMsXYPZ2HxpU70AyMs=
X-Google-Smtp-Source: AGHT+IGbS984iRveFDFXvDEXPDi5nYh6QK1hCEBKraYaVmtp7WfgwASl+Y7Yy5kjRjKkUiiNzuWyCw==
X-Received: by 2002:a50:a69a:0:b0:56e:309f:4cb3 with SMTP id e26-20020a50a69a000000b0056e309f4cb3mr5056356edc.16.1712538401181;
        Sun, 07 Apr 2024 18:06:41 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id b14-20020aa7c90e000000b0056e46beba6dsm2069990edt.16.2024.04.07.18.06.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Apr 2024 18:06:40 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 08 Apr 2024 04:06:40 +0300
Subject: [PATCH v2] usb: typec: qcom-pmic-typec: split HPD bridge alloc and
 registration
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240408-qc-pmic-typec-hpd-split-v2-1-1704f5321b73@linaro.org>
X-B4-Tracking: v=1; b=H4sIAB9DE2YC/4WNQQ6CMBBFr0Jm7Zh2Wom68h6GRWkLTIK0toRIC
 He3cgGX7yX//Q2yT+wz3KsNkl84c5gK0KkCO5ip98iuMJAgLbS44NtifLHFeY3e4hAd5jjyjER
 XoUnIm6AWyjom3/HnKD+bwgPnOaT1OFrkz/5vLhIlqlo5Y7pWWVU/Rp5MCueQemj2ff8CmM0dD
 b8AAAA=
To: Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
 Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Caleb Connolly <caleb.connolly@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2202;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=d+ruzdmvGa/okGAGeYbBxEzaBs0mn1exB2go+KqLJPk=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmE0MggQfqBW60Ab7/gmZuI/fIvOljKpi5FvEEv
 np6fKrtdTmJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZhNDIAAKCRCLPIo+Aiko
 1WlHB/4o8o82DHnzpyyKOvhmrDsG1qJVmkgeTP8m04DZzlWHpuQNOSerlSGwpQ9jjpB4iiC22AS
 sdT+E8no1yleTOLWqCIg0q4BtZI28dwvY739j9H2EMunRljXjhKFCB9PCcbhmw2EfU2XXVP0qS8
 y6aXXfDoPlt5Ctae6baejV2GR7QNNLD7PgZFjZPkEpO0ynQx6kvarXaHOVtYgCKWgn+zW681nMM
 h7ac2+V3p72R0hwfTggIU3ui9ivhyVRHaCtQDOLHp8iD7o4vJ682yWNtGLHUxat9ixoSr/8KXBk
 OBn/oQb3gR8hlvTggf2ck3vbBsxDQK0njpocvAi5fDm43Xcc
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

If a probe function returns -EPROBE_DEFER after creating another device
there is a change of ending up in a probe deferral loop, (see commit
fbc35b45f9f6 ("Add documentation on meaning of -EPROBE_DEFER").

In order to prevent such probe-defer loops caused by qcom-pmic-typec
driver, use the API added by Johan Hovold and move HPD bridge
registration to the end of the probe function.

Reported-by: Caleb Connolly <caleb.connolly@linaro.org>
Acked-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
Changes in v2:
- Fix commit message (Bryan)
- Link to v1: https://lore.kernel.org/r/20240405-qc-pmic-typec-hpd-split-v1-1-363daafb3c36@linaro.org
---
 drivers/usb/typec/tcpm/qcom/qcom_pmic_typec.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec.c b/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec.c
index e48412cdcb0f..96b41efae318 100644
--- a/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec.c
+++ b/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec.c
@@ -41,7 +41,7 @@ static int qcom_pmic_typec_probe(struct platform_device *pdev)
 	struct device_node *np = dev->of_node;
 	const struct pmic_typec_resources *res;
 	struct regmap *regmap;
-	struct device *bridge_dev;
+	struct auxiliary_device *bridge_dev;
 	u32 base;
 	int ret;
 
@@ -92,7 +92,7 @@ static int qcom_pmic_typec_probe(struct platform_device *pdev)
 	if (!tcpm->tcpc.fwnode)
 		return -EINVAL;
 
-	bridge_dev = drm_dp_hpd_bridge_register(tcpm->dev, to_of_node(tcpm->tcpc.fwnode));
+	bridge_dev = devm_drm_dp_hpd_bridge_alloc(tcpm->dev, to_of_node(tcpm->tcpc.fwnode));
 	if (IS_ERR(bridge_dev))
 		return PTR_ERR(bridge_dev);
 
@@ -110,6 +110,10 @@ static int qcom_pmic_typec_probe(struct platform_device *pdev)
 	if (ret)
 		goto fwnode_remove;
 
+	ret = devm_drm_dp_hpd_bridge_add(tcpm->dev, bridge_dev);
+	if (ret)
+		goto fwnode_remove;
+
 	return 0;
 
 fwnode_remove:

---
base-commit: a6bd6c9333397f5a0e2667d4d82fef8c970108f2
change-id: 20240405-qc-pmic-typec-hpd-split-22804201902b

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


