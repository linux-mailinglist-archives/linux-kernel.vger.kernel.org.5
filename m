Return-Path: <linux-kernel+bounces-128401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FFF6895A69
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 19:09:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7B60B2AC7F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 17:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50F09159915;
	Tue,  2 Apr 2024 17:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S5tUrQAE"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7AFE1598FF
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 17:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712077635; cv=none; b=KFVBP4dmIEOGxj1ETxVCV+1Cvh1MdjOQ25XGzCm1F3iPxGUuJzi6RE6z6DD+bgmKGOLAYDgpz1i8W9Ri18hTFVlvYMXDppLgEHmNKnd4VIcPhOlobRhhP3b1JTNlIUHxqXz7Zg2UFRuOeci6r8FsFEkIfNu1e4AxLVFAagUVloM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712077635; c=relaxed/simple;
	bh=PyZ6nf5pW6oLTbA/Il8yzhinXaig/Ih9w+i/c0+eUKY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ieoCbKJzw2JL0t8SSYtwKo8tj4eCdbhwVUNeatZh9/RaAjwZIWJzI8MdwnydlYzOj83Mp8odntkv/SpncnJ0/fHnlocfeG7jxuCGB0m9keH3szj5lSLifZsJsYGzxOHKJc2HORpyhUMr0cznA1OAecv8hfkct8m1XnaqKIdI/Ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=S5tUrQAE; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-515d55ab035so2366188e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 10:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712077632; x=1712682432; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=t0qX4V5dOuF+AyVy4H1pGmM8NKk2LMBP13hX/86nKyo=;
        b=S5tUrQAEstzK+1BPU0zWqCcDyeu7Ii/qu7noAkPzPOLaSOXhOVDQeFVK3a8zKlUKJJ
         DZ2/OvJMonpcAvQBNu2f4RtNCupWMatl1kjAHE2RMjlTjH37UDGmFr+NI4MlDUsYX3OQ
         mwh+p3enZ0xI8U13jzleMAK9WE5hjiD3fmxtKFjvyk/WJ03nBoVq/QDC4JJ8jMJoBjSE
         07Qq4gwzbfPtIMqgt0w/Nt9lN7ftsykIavQ8ik5MiHoFgeQ+BLasA+LBzrckU/36EwVy
         elvRM3RDR8vag58gwjG2o61/nc/olUp8ziMfZeO74lEBnreJNMON0y33CFcdevTNKZLm
         3Pbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712077632; x=1712682432;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t0qX4V5dOuF+AyVy4H1pGmM8NKk2LMBP13hX/86nKyo=;
        b=KdmB9lreQtRhtenvUWheaVkL/Qn5umGwzBfr1+oy2p88rotYRg/FURKSg078+yf+c+
         ososd8pt7Gbf2ExxHzpSUX9DBzooXePJixSwom/CZCgJtLybzznwhj8+buuFHsDNAFBK
         DqQLYikzmSI6EKB+aKIbJfxy5+RGL/yTpQjopvOBhvzVTBeUSYXykJW/BXi6gXDmYULq
         Ww6BhvlP7ecoxUPs6fQdHxQFAOjoOzfIaMKB7Zqi+hTO4gz1DRH8Qrq42pP3yk9I3J6q
         tZ0h/oUkzsW81x+oA5NsdfBw9ZNmUGtOQpjYdjhzQuVEp7icT1/yf//Nhz+3fSsdcq48
         xmhQ==
X-Forwarded-Encrypted: i=1; AJvYcCVNqt64odhEQMGdC47pRtGQI7DUBNdpSVVGmxTHNe0k5FFfOk2R2WBrp6SvgRb/zGQTMidPWm7rKPJBW0/+BdgBFFVD1Vxk+rQZwNVQ
X-Gm-Message-State: AOJu0YyCKxsGujqg+qDYy5RvTo83xSCq4fIZLcWvJiB2n7ypKQ0fsFfd
	RqK+ALAsMlu/x/TRBebo3Sif5DaU02d7zvgIEJCIOmDXotbTWBgJqUmbBvwa8gA=
X-Google-Smtp-Source: AGHT+IFbKuOHROYclyFrXlXrX3WTp/q+L6iZdrC4TlZm6jq2X9VgDgB71x2MJXe87coZCCukYSa95g==
X-Received: by 2002:a05:6512:48d:b0:513:cb0a:9632 with SMTP id v13-20020a056512048d00b00513cb0a9632mr7954720lfq.50.1712077631872;
        Tue, 02 Apr 2024 10:07:11 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id e12-20020ac2546c000000b00515cc53c5b3sm1603486lfn.125.2024.04.02.10.07.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 10:07:11 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH 0/2] soc: qcom: pmic_glink: fix client handling
Date: Tue, 02 Apr 2024 20:07:05 +0300
Message-Id: <20240402-pmic-glink-fix-clients-v1-0-885440b81c65@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADk7DGYC/x2M0QpAQBAAf0X7bOscIr8iD3dnsWHpTlK6f3d5n
 KaZFwJ5pgBd9oKnmwMfkqDIM3CLkZmQx8Sgla5UpTSeOzucN5YVJ37QbUxyBazHSVljS2qbAlJ
 8ekr6H/dDjB+LM5X0aAAAAA==
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=696;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=PyZ6nf5pW6oLTbA/Il8yzhinXaig/Ih9w+i/c0+eUKY=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBmDDs+fFGcLjnsZRmpGubABsNWqLwowNjHewOIs
 Lv8+UhmLJqJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZgw7PgAKCRCLPIo+Aiko
 1Xh+B/wI9dzzVg0oUn6+Q8ChrL8hGLKPR2FpU+6PI5kdA/4lqXyZ3avW2+5mutX9TV5flrOwx4A
 N61bwdeN6qMbRLnMj4fGB1MsFShUeGXqqWvSpiIuTOaOmZbWTRojU0/Nat10amVFROU3ukFdtV3
 0zncr3tvsRSV+ow2Nbi1/aTx82WU8e6m6uZpO0U7DrDzxOyNskwPmndwr66xef89K5alini5Ola
 m3nM22LjFHcWCHXNXGEd8UdNAA/tBgNqpKAgcd4BiuVlYrClU16GY944PabnD439Pp27Goe7g+l
 sFnOvwZ+h3NoSJNBSkav1CJeaB3/7Bb79cSZwiEWDa0NWRe0
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Fix two issues with the way the pmic_glink driver handles its clients.
First issue is mostly theoretical, while the second issue can easily be
reproduced if the drivers are built as modules.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
Dmitry Baryshkov (2):
      soc: qcom: pmic_glink: don't traverse clients list without a lock
      soc: qcom: pmic_glink: notify clients about the current state

 drivers/soc/qcom/pmic_glink.c | 7 +++++++
 1 file changed, 7 insertions(+)
---
base-commit: a6bd6c9333397f5a0e2667d4d82fef8c970108f2
change-id: 20240402-pmic-glink-fix-clients-5df0bab3e871

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


