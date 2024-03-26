Return-Path: <linux-kernel+bounces-119620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8933088CB40
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 18:47:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA91F1C38D06
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 17:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59ED48529B;
	Tue, 26 Mar 2024 17:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="k3ImuXZA"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D62D1D559
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 17:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711475202; cv=none; b=ZD1d/uPPUgfawXg1w3IdEnRpmlPqZVUde2abSyfaYq6YvIT5dc7ALStRTkj5qjMhIBAN11PDIy92jotfEo0BhT7fUWW2pjnTlanStWcVuGWKpsQw5tNngt8L/GQLy7aY7Dj5YowSAnvwIQkpAyPd9gB59bIXeZ4eqS5DEGBpQCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711475202; c=relaxed/simple;
	bh=+Jb3+P97t3/SYjNzJeD0Doe3JTD7QKu5XiF0KJGtqvE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IrzuCoeti3xXxoGidfMMhDcTMnVp9fAGhYrXt9DOek24Y8FObhqm6tkozevjhyS98OUu13L2Ifr8a14plHrpaA7zJroO9KUkeG9MAQg6Q74/Cdl7q2wGua8h0vQXhDIHIs86cM1m1ddtPaScb2tfkwpJMLMDkpo2dsmMnsMyDqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=k3ImuXZA; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-56c1364ff79so2987728a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 10:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711475196; x=1712079996; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xEazo7CkUjqyyWnsaq027rdmCtFwk9evR4G6KKq+jfU=;
        b=k3ImuXZABKLxMtlS5jhB/uwjnfN5VK7JEQJIHp8a+aGIZiqswNhk27zUh/JBoLl8r6
         t1CVwhLwCM2zkkwXnapZ8vUBwgpadJsQyIYDvqOn3UntxjuMclnRJqZAgGehgPE1LHjf
         kaqO7EOnymZ1D8ZXbvGQ+xiElSi9mMRofMyH94CgEGJ7KwIWZTtB5aiVawgh2BmJBgH0
         97j7OGhqFUH+JN1Jyj5eeEJy2ZvCoOe7pazOh2KKPNbaPPKuSk9/7DWzGLSIJmKOxLzg
         55bQ7kbtNuJJhXUNMiSXugDxEMidn2Je99iHq5pDjhrjr4ZzWgsksWWFqjumKreug/XF
         njdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711475196; x=1712079996;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xEazo7CkUjqyyWnsaq027rdmCtFwk9evR4G6KKq+jfU=;
        b=iWLmhI6kEJE9KDD4hvDLDec1IpgBrzMJEXolXudB+Y0TDF01mVasjVPLwoosjyIkqY
         mBXFtaYq5XCetz+gEgwwnBve0ZG1fXgiUX9IxtwSXGAS/kSLJPtmJxmjh7JXY0HnAMjO
         Iia+D1cT6EieIJBmKmYNt822WC38qfkJpWGOHetGXwzq4y/uRe+mLNYubpfF0nYq0lyW
         rZnDuYgoK6NMCd/A/UCP16a775gp3ni1WaM6PdZqcsHdiChJhmxq9V7LAOf8RIAnYXZi
         Gnmi/JiSKBZY4Hi73vFLY+uF0ScohV70PdgqYxpQ7GW53UlOPkhw0nUAxn8qWHSrvRFL
         9zPw==
X-Forwarded-Encrypted: i=1; AJvYcCUfjuc0r5+tPF+B24pjZid6Je+YEdZKIWJHtVPD+ZWQ2RfcOCvUhJe0cTnAlnNJO/0fc7dBxiq0BpB6Ug6waxP6xcaIMmXacG9Wn59H
X-Gm-Message-State: AOJu0YxmSsQMxPe2mcPZvzt+rzyPwjxX5Hk1uk9kQQMgPSF2DQuJoo+g
	2nxcWoC3Sxj56Y+J6wjGgBIVzSPlGejCkzAKSCTJy+l7F7jKJxnsYJRP1CMPpkE=
X-Google-Smtp-Source: AGHT+IEDXr/rGD/GEqrQHL/G3YeNWczFxMCfJdYUN/McfMgn2peLnTcs3anULp1X3DvgNu3GWK0kxw==
X-Received: by 2002:a17:906:c9ce:b0:a46:be85:4410 with SMTP id hk14-20020a170906c9ce00b00a46be854410mr243447ejb.74.1711475196041;
        Tue, 26 Mar 2024 10:46:36 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.44])
        by smtp.gmail.com with ESMTPSA id l19-20020a17090612d300b00a46cffe6d06sm4451438ejb.42.2024.03.26.10.46.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 10:46:35 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Avri Altman <avri.altman@wdc.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andy Gross <agross@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/3] dt-bindings: ufs: qcom: document SC8180X UFS
Date: Tue, 26 Mar 2024 18:46:30 +0100
Message-Id: <20240326174632.209745-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document already upstreamed and used Qualcomm SC8180x UFS host
controller to fix dtbs_check warnings like:

  sc8180x-primus.dtb: ufshc@1d84000: compatible:0: 'qcom,sc8180x-ufshc' is not one of ['qcom,msm8994-ufshc', ... ]
  sc8180x-primus.dtb: ufshc@1d84000: Unevaluated properties are not allowed ('compatible' was unexpected)

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Rob, considering limbo status of this binding, maybe you can take it
directly? Would be the fastest.
---
 Documentation/devicetree/bindings/ufs/qcom,ufs.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml b/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
index 10c146424baa..1ab3d16917ac 100644
--- a/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
+++ b/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
@@ -28,6 +28,7 @@ properties:
           - qcom,msm8998-ufshc
           - qcom,sa8775p-ufshc
           - qcom,sc7280-ufshc
+          - qcom,sc8180x-ufshc
           - qcom,sc8280xp-ufshc
           - qcom,sdm845-ufshc
           - qcom,sm6115-ufshc
@@ -120,6 +121,7 @@ allOf:
               - qcom,msm8998-ufshc
               - qcom,sa8775p-ufshc
               - qcom,sc7280-ufshc
+              - qcom,sc8180x-ufshc
               - qcom,sc8280xp-ufshc
               - qcom,sm8250-ufshc
               - qcom,sm8350-ufshc
-- 
2.34.1


