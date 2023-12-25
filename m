Return-Path: <linux-kernel+bounces-11031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4054F81E04D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 13:05:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F08032812DD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 12:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C52853813;
	Mon, 25 Dec 2023 12:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H3VsINRD"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45CCA52F67;
	Mon, 25 Dec 2023 12:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-40d557541e5so10100245e9.0;
        Mon, 25 Dec 2023 04:03:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703505819; x=1704110619; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5YKKwCbE2bVC81oS/UxuxOltquOrU1cWJrPWd3LKzlY=;
        b=H3VsINRDI47hmCjDXWkykjkOHPBpKEke6Rr0lfqZ9M1p0mHb4NXSrWhZdoNDr0g0Hp
         7BBTPRCaybJ6DVCCh27ggupJMP/eouHcDbfb4CiB5lPlmOJy0r104gOCamombvkamqzz
         HgIDx9jEZriaskksnI1/hotnTpTOlHLC+WwZ+fpTDVWAe7ro6hXqAZMun8Hfg5Hr4ocb
         K22hKjeYFo4sVV3ZZx3TBrdXF2kvA93TlywIhozaS8TdJm1r/XxfCmYCUaEFgbiDpca9
         sh9A5Q5VzgUigw1/Y5rCfFH2RcAr+w6eT9M3euf8N7CulqPl5UzlCqwoHy2GUA+I+No5
         hljQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703505819; x=1704110619;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5YKKwCbE2bVC81oS/UxuxOltquOrU1cWJrPWd3LKzlY=;
        b=OsoJNbMmHpuLP7lhvkD1kajljTbP1nJ1Cpggj/B7Y6//JTQVkYF7qAD/L1E55tJHCS
         el0vl9AvGNW4ShphnfM0LAeQ9FikTuN2otrqM1z46xCrR+qPaOBU17JQcG0zwBFKOFtG
         f7ArI09zWk/MJ/AG8aGwN+/fnFFqqmQZle6n/L+WT/PplRfkpPEto/wY+EPjMA1bJwnM
         VaCEJui6X+bZ1l5jAogDisPjOpPErDtJ9EXVn8E7N3Idko56wBWKsivs9iOIGBeQSuo4
         pydUsl9NkI6+WZDBQXkVZ3tCBupYDQnFtn6X2IVyPYDmtp1KyMnNCaNUbltUNvLCB2qN
         cc8g==
X-Gm-Message-State: AOJu0YyWuEqcIRFgeEZDQT9Jxhs4TS+cv8tPKWz6xHOgytAT2XXDGdgX
	2hbPMIceyzJ5OQ0m1j8Ls7Q=
X-Google-Smtp-Source: AGHT+IEpfz+A8etqQOC+NaZ2PjlhBpNmJiqppfuewTa8F6Tdc1sMUi6TCz+W0Nu1qy1sOkX2ESOcZA==
X-Received: by 2002:a05:600c:4ca7:b0:40c:6de5:7613 with SMTP id g39-20020a05600c4ca700b0040c6de57613mr3161665wmp.173.1703505819430;
        Mon, 25 Dec 2023 04:03:39 -0800 (PST)
Received: from david-ryuzu.fritz.box ([178.26.111.208])
        by smtp.googlemail.com with ESMTPSA id 14-20020a05600c020e00b0040d23cea7bcsm6349456wmi.1.2023.12.25.04.03.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Dec 2023 04:03:39 -0800 (PST)
From: David Wronek <davidwronek@gmail.com>
To: Andy Gross <agross@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S . Miller" <davem@davemloft.net>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Avri Altman <avri.altman@wdc.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Joe Mason <buddyjojo06@outlook.com>,
	hexdump0815@googlemail.com
Cc: cros-qcom-dts-watchers@chromium.org,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-scsi@vger.kernel.org,
	~postmarketos/upstreaming@lists.sr.ht,
	phone-devel@vger.kernel.org,
	David Wronek <davidwronek@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 4/8] dt-bindings: arm: qcom: Add Xiaomi Redmi Note 9S
Date: Mon, 25 Dec 2023 12:59:57 +0100
Message-ID: <20231225120327.166160-5-davidwronek@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231225120327.166160-1-davidwronek@gmail.com>
References: <20231225120327.166160-1-davidwronek@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the Xiaomi Redmi Note 9S (curtana) smartphone, which is based
on the Qualcomm SM7125 SoC.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: David Wronek <davidwronek@gmail.com>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 1a5fb889a444..59430524dac6 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -988,6 +988,7 @@ properties:
 
       - items:
           - enum:
+              - xiaomi,curtana
               - xiaomi,joyeuse
           - const: qcom,sm7125
 
-- 
2.43.0


