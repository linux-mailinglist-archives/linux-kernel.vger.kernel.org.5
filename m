Return-Path: <linux-kernel+bounces-62031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0669851A93
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 18:03:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 868C6288A92
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 17:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A4073D96E;
	Mon, 12 Feb 2024 17:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dNtIu875"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A38B3D564
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 17:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707757376; cv=none; b=MY6upzXqsWfsYdcCjbMXjIKOIl7glTkQQMhAzd+U75FCAqb89QLrLcb5FDeI9WeyfVxBIXjVJTIzs/uvXuCchCiXKiwjU+fa9kYhdfH5qm48EoDl9FyTJGPTF4h328PCfM8SHM0N5sxcwpZ5BxxUjLvAM9D/pCsRcDRsuczbB5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707757376; c=relaxed/simple;
	bh=nnFi0dz7hSqMF4DlCZ0/X5ltymPDZD4pOj9wQcTNkyg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=sbGNgzLa+Qf6SZPxFs8UXn5ZvNKRoxL7AM7rhwZDkRmuAcyR+R+bfoNLXJROJTj77xkyBPD9Ymi7gO+3eyi4WhmEq+Z7hOd5ES5rJ+x7c7gSprhPRyeDD/q9L/J4detXhFoBmDaxWVW1wHdlRx3FEPYKJS/2gQ4rA5/hMbcrbS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dNtIu875; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-51187830d6dso1442288e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 09:02:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707757373; x=1708362173; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Glg4WPNjCjWUYTPSWyXIx3TsulJuAQ07BgmnN6oIbto=;
        b=dNtIu875TWm83flmINy3wCmDh7rOUqI8pS6xlZpY6YVIR/I8t1zRfkVTj2kXGgGRbh
         XQY7RXflETDoCCyEGuwDDVpvDon43bIHQFRAfqmEIPsJ9BXHZZTK0eTy9f9EXV3M2te+
         3Ylp1FCWekopm9jkeF7g0V1IloposuX/GGEXV1rv8Jo1aZqvezlzmc5xHvyyynEq6lcj
         RjBP9M89I4j7RKJ2vo+7EmhloAJdo491zS0OTnBMDWC6FlAVKag/amxpPjdu5nGPdLdu
         oeqr5eypdMGyUY/gVtXcg3u+Q+HanUO/3BGx/qAc7qyhvWkIq/Cv2Kwsft/tMo2gznZS
         mSHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707757373; x=1708362173;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Glg4WPNjCjWUYTPSWyXIx3TsulJuAQ07BgmnN6oIbto=;
        b=Ey71HWqYT8JvRb5/ey7BKU6d4ofxshhljdas/uCttA1R+gxEgZBtv/gJhXosTVs0P5
         rntZn77+Beylckc14Lf/Sl35bTd5uIwcyYrl0Q1D83EvrygIpTiYQ+s9kMWkHTdL0jLw
         QDvZZdtW18I3MmZXmcoWBRnduPXCd0PeY7OAUe9JqbSAu+C30gxGy/2tbqUMQRMuRYZo
         Wi6PpFVqOAXw9OoM3v7ESGHr7mWbmBWuvyD4UTgn5xMjtMEYxh1uBSGMzdRDLd6Sldam
         Fy6jBFbihuXm3nv8iaRCNYld+dbutIBCS6Z1Av3G1RyIV53z0dpTnzGD+IbvBgRyxyp/
         FXMQ==
X-Gm-Message-State: AOJu0YzrFt1HifVgKklmlOai+IlNjGLaxUEY8GzVXr9DgCMf/kRPsrXh
	2ReydEcaJZOTtSJkGqUflXM1AnAevj27czqbFyAjZFsZEwmsktTIQjF1V+N0dUs=
X-Google-Smtp-Source: AGHT+IEObiDJ+lPv9tBw5NH4DThm25ty5XwAVlLgnIgSMvFdfXzooCjz8i931pQ1mcoDJLnSv1Im8w==
X-Received: by 2002:a05:6512:3494:b0:511:29ee:83b8 with SMTP id v20-20020a056512349400b0051129ee83b8mr4336538lfr.62.1707757372838;
        Mon, 12 Feb 2024 09:02:52 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWsrJMgEm1KKo6RrePDwPj88tQQpYSUIAH5HZUr0OUxSvTGI80E5ATulpEFTvlrgb6h9Vcvg5J6YH0CHrM/ZPYxdTVeVSuPG7sPJHBr5mKWfUPUMwqe0ZiAkM2lI4MFnl7/iLTNJQmNWKB8viHkfunEplGlJp0uDq1fqxwq39pRBGKQj/Lw1vTt8PR1zbxaowfr3U0lg+pbhttq7H4TXH4EF5yH5pvHZJNjALdt8M3qm/NRo8bJ4BgF9hOjS7m83745C3oi1WNRRX9Wudx1mHMnKf+KWfxcqVfWer4E9DgB9Fed8qtYUmuc+JvuOQGIohKmy2CDIWXTQDYGGx8x+GVScP4EXNlHwciC9TUpuopPCTaPb1LzBZz2YMrrX0VW8sMwy+7Tg1+eF7msSEzUbleoPAW00QYgSFDTLh6rCQPQmDTy+n7DtVC+QXTQmete9byqYsNRkALbRye87REzhXLk4JSlYGPbUr/abgBXrnHdz3GufP9gOKY4kc0hRrWC+1h/OlVUC7aw47mU7mWNbc1GhYvzsvR/8PA44Mn2mrB1yaPGiXyBNxTiNfM=
Received: from [127.0.1.1] ([188.24.162.93])
        by smtp.gmail.com with ESMTPSA id h23-20020a170906261700b00a3c9951edf1sm379600ejc.115.2024.02.12.09.02.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 09:02:52 -0800 (PST)
From: Abel Vesa <abel.vesa@linaro.org>
Subject: [PATCH v2 0/3] remoteproc: qcom_q6v5_pas: Add aDSP and cDSP for
 X1E80100
Date: Mon, 12 Feb 2024 19:02:41 +0200
Message-Id: <20240212-x1e80100-remoteproc-v2-0-604614367f38@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADFPymUC/22NQQqDMBAAvyI5d0s2Kk176j+KhySuGrCJbKxYx
 L83eu5xBobZRCL2lMSj2ATT4pOPIYO6FMINJvQEvs0slFQlKomwImmJUgLTO840cXRg1a01tS5
 JOydyaU0isGyCG3IbPuOY5cTU+fVcvZrMg09z5O95XvCwx6SSqO5/JwuCBKxbhdTV2lT2OfpgO
 F4j96LZ9/0H1C1fUMwAAAA=
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Mathieu Poirier <mathieu.poirier@linaro.org>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Rob Herring <robh@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Abel Vesa <abel.vesa@linaro.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Sibi Sankar <quic_sibis@quicinc.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=959; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=nnFi0dz7hSqMF4DlCZ0/X5ltymPDZD4pOj9wQcTNkyg=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBlyk8zjo2LpSiWbWfUFl2ggatdDySA7XoLWRBbe
 rFm4RiAwqmJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZcpPMwAKCRAbX0TJAJUV
 VuWjD/4zkmQlH31HEOFN+lLSp7LBm+ePX3wXH2/mlJhurPQewMSZjZpAxSPDOaEuSxhROPD4pB1
 WD0d0ch+mgd2C0pksFq5qyFmT6R1XAHhWEr1fzF4zWQMW8xG/kHRvjBt+zdPLP5GCXmkrbCgaJi
 Kvmv7if3fPdp/UDFPsHtbPUU7TDKpGWLiKibQlrXV3rwFNbgcDT8rX614XXkvfL1PmbF3AXe8QE
 cYqW3LbEOn6ff32jk4nJpHMbNT8zNa3pVNS0xtnLopUd2H1PhF/xpdLUVLCXvQ3Qj5aEOy253oT
 UnQGuiU9Balvuw+QK0QgVjbUyBWLXEjHQLIYbfbWmHp0a4YTRPFrQqQrL4AoOeb4pHnKoHgT6Ql
 0dt8a8z3A9D6H9xIDYKJTa2oPFTFjV2k/Y9GuewgCVse5FFVTDvu8A3bMfS34ALltNZkLRK90Ve
 8zW1MOCYqfaPYDCYnDq1H3jPuDsFUA9roowIqWQR09RRWuATAJC0seuaJr+MugO2bKJH+rszOoc
 /6dSvLTUMb4TJSuVs3p6C1+tvO4HgofEPMP2CPf2pYiA0dTuZ8zX5kD3Cl6YDF3wFil/8UgoADG
 qGpTE60Rb6yBM2Af42FG9ht2ZUw20IsPPPvrHM4OYO1vVZBUp/GPVYkZefd6J1rDI4p+ZFi2cMU
 Yq9vyQw+2G7lgTQ==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
Changes in v2:
- Added Krzysztof's R-b tag to bindings patch
- Added Dmitry's R-b tag to the X1E80100 related patch
- Dropped the comment about the comment from adsp_load about lite
  version
- Link to v1: https://lore.kernel.org/r/20240129-x1e80100-remoteproc-v1-0-15d21ef58a4b@linaro.org

---
Abel Vesa (1):
      dt-bindings: remoteproc: qcom,sm8550-pas: document the X1E80100 aDSP & cDSP

Sibi Sankar (2):
      remoteproc: qcom_q6v5_pas: Add support for X1E80100 ADSP/CDSP
      remoteproc: qcom_q6v5_pas: Unload lite firmware on ADSP

 .../bindings/remoteproc/qcom,sm8550-pas.yaml       |  6 +++
 drivers/remoteproc/qcom_q6v5_pas.c                 | 48 ++++++++++++++++++++++
 2 files changed, 54 insertions(+)
---
base-commit: 445a555e0623387fa9b94e68e61681717e70200a
change-id: 20231201-x1e80100-remoteproc-b27da583e8cc

Best regards,
-- 
Abel Vesa <abel.vesa@linaro.org>


