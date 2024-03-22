Return-Path: <linux-kernel+bounces-111382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D4C9B886B94
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 12:52:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57DC61F24670
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 11:52:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC1B8405E5;
	Fri, 22 Mar 2024 11:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UVrGfFeG"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E523FB02
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 11:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711108354; cv=none; b=cNcqXGEIBE8EqFiudF6p7M4Og0V01ugbC69SbZzInv3t2j4ckOVEmZT8mY7XPhMZOwEzr9MCctJmKQMu+RXLKFkTkwVsLTJfmiCKtImQCeouxJ1lzdP+jcq0CnL56FKWw8qdu3BntGto7eUlT6GGaEX8vCRDoY/pjo/dSmISqZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711108354; c=relaxed/simple;
	bh=uM78URD0gmUDrKQrIPNiYKlgPKGQKTJvi0ZT5XQ1EB0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=MujKukX08/ukc3BG7yaMm0UtBOa4bNDttbBrNvtXKDtou4UxNsXIx9f8VK3DlZrgDtlgQuiD/683J3Mx258lnk9IH1SvgbRv0PPKekkGMrqIJ2v96ed+Uw6ua6/Vjl9c+jaGDawKR1ledSGJAroc0V+KZP1OL8P+hHR9za9TUdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UVrGfFeG; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-512f54fc2dbso1947146e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 04:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711108349; x=1711713149; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XWwlbSeFXBG15AriHw93hkTw8OUx5yGbRBkNRks3CkI=;
        b=UVrGfFeGg8DdJDFp+8XOvN29M7JX2Ue1rUzq1yzXXx4/v/Kz7lYlp5H/HepfeYF204
         a7Bp+iMxW4iW2yib+QzRrKY/oZcI5SgSdOEgsDjOQyPlXX/rsFYkFsIHLporwZz8fzE3
         biIHYzc3j/LEHGLWifiBRsxYjAi6yqGDE4SgNhOGtNUKq+L7+L1Repa3GmySNrcBajh3
         +SilfgADPqQullrUT51GzMpCoBMA3WKHfNnx2Q9y83ubDCO8P5q0+eD3YeVUxKCQhrCc
         8rpYXeLDwVURAmUYNICSG7+XCrjd3LI05ped7zHyra+m3Z2VR5edGaPVNa8WYsn+gALX
         isvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711108349; x=1711713149;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XWwlbSeFXBG15AriHw93hkTw8OUx5yGbRBkNRks3CkI=;
        b=VnDQy7zRV4eiuFpZV0q6Ynvcv9VcaLIJUB+7vXqqNQFgaKhgawtIgZnRfjWOFX7V2y
         twAI9/EfdnaNDyE8CUQSvq8+C/XpgU038untP2YicGGL4+lbmtFSMDtjVEILraIN9gpo
         Ihhp4s0VdFHHp5KIVRe0v8PKaB7NXe5UI9aiu7ky4lNnANfiogjYfQWeiFstGKOT5fzS
         6z7Xd9pGPDB8yCWwCJsz6QzqoRQ51NRyOePmKhuSRgfpqB1dK7MKRCjqVeZ7QjdneDvp
         OSh6IuTmlwYxFruhLyLcuhkzGiCsnVjj7VsgXY3t7gEuHKAmNIelQlu0IVqYUpxZNA0l
         6HRw==
X-Forwarded-Encrypted: i=1; AJvYcCXDRigELILmVAd9XBmrvMd+Otz5IwwW3ASzShFQTSaOBzb7I9CY+LAUOy5D+/yIJ5S9GTH7cWJXf7nIxf0DZVuZODyPiewJ3okrK5so
X-Gm-Message-State: AOJu0Yyy8JRhZaLgGBWAeEm9BKaIdXua69yoFlTRK57LzsmaaCloWqZ+
	ZjtFiIQRZfjCsjhAV5OsgdaXHDVrSvo3M82x6N7ImFN9CGWmnir04zXngspF0rw=
X-Google-Smtp-Source: AGHT+IEtdCncG/ZEKbVGMQRXRtfDRdVEBTPHtMJs6fpl3hXYy+IxP+4SEqcAjWlvPSgV+JuRA04T6w==
X-Received: by 2002:ac2:499a:0:b0:513:ed0f:36c4 with SMTP id f26-20020ac2499a000000b00513ed0f36c4mr1536091lfl.43.1711108349344;
        Fri, 22 Mar 2024 04:52:29 -0700 (PDT)
Received: from umbar.lan ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id y18-20020a056512045200b00514b644bfebsm320136lfk.299.2024.03.22.04.52.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 04:52:28 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH 0/2] dt-bindings: usb: qcom,pmic-typec: OF graph
 corrections
Date: Fri, 22 Mar 2024 13:52:20 +0200
Message-Id: <20240322-typec-fix-example-v1-0-6b01c347419e@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPRw/WUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDYyMj3ZLKgtRk3bTMCt3UisTcgpxUXeMUyyTD1OREC1PjFCWgvoKiVKA
 02Mzo2NpaAAPMGdFjAAAA
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=743;
 i=dmitry.baryshkov@linaro.org; h=from:subject:message-id;
 bh=uM78URD0gmUDrKQrIPNiYKlgPKGQKTJvi0ZT5XQ1EB0=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBl/XD8w8CexWMiJQ7x21C64WZ/aqo1apoJ9seAO
 Oq/9Vz93ESJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCZf1w/AAKCRCLPIo+Aiko
 1e6jB/9Eu1u/vRRBp6wrsMZtEet5SCW49JbbtMaiPCYmiTSEDz90925Kj4xVr+YVC+Bq557xPsu
 2nPooieMCq016OLfddrm4IN5mWbkjjBMUd5y3spUudY9RR+s4PDq+ldTW9o8dyGaAXcSLSv3K8c
 oB/P8xb5Hi8OuYmJ/HBnvxrpSiwJjM3RFls8/0TKrvplK5GG+IidGmuuvMyS87K22pHtVOPBPGg
 Qg2j6XHm63P73Xy4GckU97dWifLZ2Cs1RfdfZJADZh3mhkciitnHbINRZOgEScyspxzIX35hCKC
 ggOF7QX+sozAdjLrSQpDYxe12e/ZfxjPVKoy8xowp2ZNGYWF
X-Developer-Key: i=dmitry.baryshkov@linaro.org; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A

Drop the extra port definition: it is not used by the DT files and
there is no correponding physical signal.
Update examples to follow usb-c-connector schema wrt. ports definitions.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
Dmitry Baryshkov (2):
      dt-bindings: usb: qcom,pmic-typec: drop port description
      dt-bindings: usb: qcom,pmic-typec: update example to follow connector schema

 .../devicetree/bindings/usb/qcom,pmic-typec.yaml   | 39 ++++++++++++++--------
 1 file changed, 26 insertions(+), 13 deletions(-)
---
base-commit: 226d3c72fcde130a99d760895ebdd20e78e02cb5
change-id: 20240322-typec-fix-example-3d9b1eca853d

Best regards,
-- 
Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


