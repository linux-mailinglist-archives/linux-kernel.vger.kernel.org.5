Return-Path: <linux-kernel+bounces-50332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25CF6847788
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 19:35:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D202828A1AC
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 18:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 228321509AA;
	Fri,  2 Feb 2024 18:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rihPEnza"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55FB314AD03
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 18:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706898899; cv=none; b=uhwdOPCvHjdTgdyY5LJZD1Cyo5mXOIaHGs0oxtt1R4wSxUM8fWRF8vVpCQjKbbsHv8IDch18EqlSZpwMaqRiecKWxXShNP5XHXTtnOXwT2m5vhRMLJ+ewBKNXJjrLDMuwI/Lekqf9MQ8PLXACVimGClJwVXZATzB38deTC00u08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706898899; c=relaxed/simple;
	bh=tlQN6nvq4H5ReX1vOGJO+iCczHZ1UxQKYxVMQ/Rq9OQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Yf6sJPXRgSfohLobHBJ1WeZzr7oojrosk15RSHc++2+ItM3EAAsOJLstpUUhcrYNLcCoA7qsRRIA0oFPk+ZMBp/ud8NkKtcLu+pzGKD5n1KPv6JO7PG5LinJSvOaqAmo1VVJSKZDiw6IeQ+LLmHHPsVRR0gCRFDmJ/l99VfhEhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rihPEnza; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5100cb238bcso4421540e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 10:34:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706898895; x=1707503695; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SKEVsPPTfdFX9/r7oO3ASHywsZE0/XlQU3+5d0rJ6uU=;
        b=rihPEnza/mVtGyZ0MBJt0SeP+QfxBcFuNfsiKo1JTG28jRAEmSUpRzyG4idyftvgxs
         F85fSKdQas+wDf+TcweRraVBjvkRJMYjJ8zP4sI/q+MPzmSN4MPLCF+yx57qqQ0XUab8
         rfxA8JlzU50CPdobTVCdvgr0XPBsxfiOu61M4nZwjOR6q4SEXtPzEkfkALoR8JHLXOo8
         m7CcOYc5OV5ZMZTar/QvqMQDFJkL6tDZwaBnUC+SiyNHUnGG+HsYUMeRHWvduC3F0JOc
         fJR81JXWZchkuWSvi/GZzILPuaX5fB6+RSclB5GZJMISzUv4k4/Vp5P77MevPbJaYleD
         oftg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706898895; x=1707503695;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SKEVsPPTfdFX9/r7oO3ASHywsZE0/XlQU3+5d0rJ6uU=;
        b=Gcj5UxdsjQL08dPtWyDa0QCgS0e8VAaUSIws9cPHQZe6AF3PMU7/VrFyvmHZ9juEg2
         XK8+tMKQTwdWMRi2nUsn8MUTSqEhafYLztKUGDf/VORPV3u4hgHg9or+4Tg9jEwJyul2
         DF4HCy3WxLAQzh4iVf22tp3LVQ02383jbnF5bOdRN9LZCtvmfH+fSYErf5K6Oalvi0Fr
         wMOLlZDR2b/GB5rGGJNn7u4p0CGOtfmsd4hnHi7cRs16d6qPowFq2txtgve4+2zFO0KB
         su3IPgg+wspGnzgJimfNmzcwO41k8kLdstzqBV/A3+Hb4fjv+sXtbzSCJ6I+xkD8XEJ0
         /hEA==
X-Gm-Message-State: AOJu0YyD+xoIrXj51lBRBXTHiSrktCSCSqKBaeeDF2P5Q/mP0FwtKrlo
	qaXqn+C0faSPJLMMldi3CUPyVXahplIbUab1GZ6QJTVYLqK6kl7AmNLOmAm0XHM=
X-Google-Smtp-Source: AGHT+IGEv1aFabvDZyV56WxZPibw1TT/8xIORIIZdbbywUZXAqfuveziofK3iTunII+JqPSDQr38cQ==
X-Received: by 2002:a19:4342:0:b0:50e:d3dc:2245 with SMTP id m2-20020a194342000000b0050ed3dc2245mr1788796lfj.58.1706898895411;
        Fri, 02 Feb 2024 10:34:55 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXE+YJpNzZHr1ASPlNERFXCjevSj7Xesk5UtbYNrblkobt9sbxMHm26ielEKTlzVlMeaJj6whNwVd/YHrGn9rvMq8V0ZfnA9X10sYh6UCytFuSVKmsDCmRsqNGmNZPo8tGvoucGww1TOmTF+VbKnTgfD5Zz/GL2sLHSkhkSWYtCHM1mwA1uJMmHzBWSpusBmaVQhBVTu6r+Vc/VXkBoqphPUbPWdFy+qU2mE06pUUmzMzWo6CgG2U5RFaLJRZ82PPXU8zditwaHuhYfn+NqVRBcca3L/rGq11UCO6hvNj9x6JrzP5OYnTy4SwodajyerX/jmuBzRwkZJa5rBeM1mX2NLS9JKDJZ1hCB1VUdKq6iRSg8D93Hsi/Iglr9IrTIBHcivvdjHj9421MW8Du8mc+XhbR/ecyGlM/x5DSej6E+X4Q02vEkIBub0jbbfbZVKhVWdhC5BdK9MyUlQ1Gsiga69PzY3ZhnXIXGHq+2cff0BBIoXG1iMhESpiLVaqajUrsBTwCOQ2uRQYNAuvGJcWm3ZckK4ObCswNvZeB8cTaOe8w8bdQOnNJrXdbVRPqId4BaEAZmeMYTVKzXn6L1Zj/gO+FLXzQky3sxnswPqDOIenetaNtwzRyHVoPlrpZ+6i3mca47ileC3iXY25EmHdZwecbjdbNGk0egSjNjaiYzoq8jWdxgE1PV/iCBSbQa2N0MfF097DhJ
Received: from [127.0.1.1] ([62.231.97.49])
        by smtp.gmail.com with ESMTPSA id vh10-20020a170907d38a00b00a36fa497a65sm1051328ejc.110.2024.02.02.10.34.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 10:34:54 -0800 (PST)
From: Abel Vesa <abel.vesa@linaro.org>
Subject: [PATCH v4 00/10] clk: qcom: Add TCSR, GPU, CAM and DISP clock
 controllers for X1E80100
Date: Fri, 02 Feb 2024 20:34:35 +0200
Message-Id: <20240202-x1e80100-clock-controllers-v4-0-7fb08c861c7c@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALw1vWUC/33P22rDMAwG4Fcpvp43yXaXZld7j7ILH5TGzFjFD
 qGl5N3ndAc2Brn8JfTx6yYqlUhVvOxuotAca+TcgnnYCT/afCIZQ8tCgdKoAOUF6QAIIH1i/y4
 956lwSlSqdNYoB/tuPxysaICzlaQrNvtxJZx5+jn+XDFPcmJZR0ppPTgXGuLl3ub41vIY68Tle
 i834zr96oFqq8eMEiQEQjsYE7zTrylmW/iRy0ms7qx+W2bTUs1qX3W6d+SC6v5Z+tsygKrftHS
 zQv8crB8oIJg/1rIsH+FlwGiOAQAA
To: Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
 Rob Herring <robh@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
 Abel Vesa <abel.vesa@linaro.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Rajendra Nayak <quic_rjendra@quicinc.com>, 
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=3780; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=tlQN6nvq4H5ReX1vOGJO+iCczHZ1UxQKYxVMQ/Rq9OQ=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBlvTW9RWacj4Bm+DbRnibS3h/QHvSmDbMOKEVF1
 qPyd9AGpumJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZb01vQAKCRAbX0TJAJUV
 VlLYD/9+esnTnPZpkfKpXyxMIG7WrPDB19DqjDxgxYt4DuA1Ce8tulxqR70rYgKqM9AZFq6RLQi
 3qk+uHr53k3RG8cvI+yDHDCndNufdiiYQiE+qU6CCim9IMxU3iL1HfbsQMemq0W2jywZs20jBlx
 +4H77tq4iLmrK41Em8vOjj/POsxSU5blrIWxHiXdGM/DuyeuV9ZNSPagpoiLxKZ61/0nOCAvzSj
 DEeo56IKJVzPsr/UXhRxgF6UzKUhGaCW/a4uoyO2KjT8F3C1S94PbhrtvLzMDfHCN16R2y/2bWo
 kq5pAVqY3jkCzLrd8oTVxRdcAogfA0LuosGmwZh+OPMrdASWemEr4OKaAcQ0hZRNZrhbasxakm9
 KUvECAv8tKkq+JdqR0AS8vp/dJuWsg6aCKuhoK+99dz1LuDT1K4ixJmjnOHlD1hEOp5iw4tlox0
 NRhP9oNRS+VkLnMrlEiW/eWuHER3PwPSLYwL2SHfBked9OZRItVGVy55U0sdZekdqMxra7nS0FA
 mwsvRyRdPTS5lRTqQS+NEQGB/eqTT2bwbzuHGntIxyU51TIb7Jr881RjkMbUbFaHtdAPGjGeAU9
 Rb5k6tqI4hjlHDBx15Q+0xDP3zewNaCSao3kJCB48dOBOvC3hdMhSNSFAagEIIIYJZuuApuHeu/
 ebw4Z0pZTUW51jA==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

This patchset adds all the missing clock controllers for Qualcomm X1E80100
platform. Another important change is the dropping of the dedicated
schema of the SM8650 DISP CC as a preparatory work for documenting the
DISP CC compatible for X1E801800.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
Changes in v4:
- used #define for clk_alpha_pll_zonda_ole_ops, like Dmitry suggested
- Link to v3: https://lore.kernel.org/r/20240129-x1e80100-clock-controllers-v3-0-d96dacfed104@linaro.org

Changes in v3:
- Added Krzysztof's R-b tag to patch 2
- Dropped the DISP_CC_ prefix and CORE substring from gdsc names, to align
  with SM8[56]50
- Dropped the CC substring from GPU CC gdsc names
- Added P_BI_TCXO_AO to both dispcc and camcc
- Dropped the _ao prefix for disp_cc_parent_data_7
- Added missing test_ctl values for plls in dispcc
- Fixed flags for dispcc gdscs
- Moved comments for always enabled clocks on the same line in dispcc, camcc
  and gpucc, like Konrad suggested
- Fixed some error paths in dispcc probe
- Dropped underscore from driver name and replaced module description with
  full name, like Bryan suggested for all drivers
- Fixed gpucc branch ops and gdsc flags
- Added Bryan's T-b and R-b tags to camcc patch
- Link to v2: https://lore.kernel.org/r/20231214-x1e80100-clock-controllers-v2-0-2b0739bebd27@linaro.org

Changes in v2:
- Added Krzysztof's R-b tag to patches no. 1, 3, 4 and 5
- Added Dmitry's R-b tag to patch 7
- Reordered Signed-off-by tags in patch 6
- Lower-cased hex values in patch 6, 8 and 10
- Link to v1: https://lore.kernel.org/r/20231212-x1e80100-clock-controllers-v1-0-0de1af44dcb3@linaro.org

---
Abel Vesa (3):
      dt-bindings: clock: Drop the SM8650 DISPCC dedicated schema
      dt-bindings: clock: qcom: Document the X1E80100 TCSR Clock Controller
      clk: qcom: Add TCSR clock driver for x1e80100

Rajendra Nayak (7):
      dt-bindings: clock: qcom: Document the X1E80100 Display Clock Controller
      dt-bindings: clock: qcom: Document the X1E80100 GPU Clock Controller
      dt-bindings: clock: qcom: Document the X1E80100 Camera Clock Controller
      clk: qcom: clk-alpha-pll: Add support for zonda ole pll configure
      clk: qcom: Add dispcc clock driver for x1e80100
      clk: qcom: Add GPU clock driver for x1e80100
      clk: qcom: Add camcc clock driver for x1e80100

 .../bindings/clock/qcom,sm8450-camcc.yaml          |    2 +
 .../bindings/clock/qcom,sm8450-gpucc.yaml          |    2 +
 .../bindings/clock/qcom,sm8550-dispcc.yaml         |    7 +-
 .../bindings/clock/qcom,sm8550-tcsr.yaml           |    1 +
 .../bindings/clock/qcom,sm8650-dispcc.yaml         |  106 -
 drivers/clk/qcom/Kconfig                           |   35 +
 drivers/clk/qcom/Makefile                          |    4 +
 drivers/clk/qcom/camcc-x1e80100.c                  | 2486 ++++++++++++++++++++
 drivers/clk/qcom/clk-alpha-pll.c                   |   16 +
 drivers/clk/qcom/clk-alpha-pll.h                   |    4 +
 drivers/clk/qcom/dispcc-x1e80100.c                 | 1718 ++++++++++++++
 drivers/clk/qcom/gpucc-x1e80100.c                  |  656 ++++++
 drivers/clk/qcom/tcsrcc-x1e80100.c                 |  285 +++
 include/dt-bindings/clock/qcom,x1e80100-camcc.h    |  135 ++
 include/dt-bindings/clock/qcom,x1e80100-dispcc.h   |   98 +
 include/dt-bindings/clock/qcom,x1e80100-gpucc.h    |   41 +
 include/dt-bindings/clock/qcom,x1e80100-tcsr.h     |   23 +
 include/dt-bindings/reset/qcom,x1e80100-gpucc.h    |   19 +
 18 files changed, 5531 insertions(+), 107 deletions(-)
---
base-commit: a3003f5d25eca1b034bb684bc6e7797586d5b8f7
change-id: 20231201-x1e80100-clock-controllers-ba42b0575f8a

Best regards,
-- 
Abel Vesa <abel.vesa@linaro.org>


