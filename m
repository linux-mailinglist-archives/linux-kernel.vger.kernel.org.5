Return-Path: <linux-kernel+bounces-119621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A9C688CB43
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 18:47:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD3221F82AC6
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 17:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 363558664F;
	Tue, 26 Mar 2024 17:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EDGlAL5g"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5144C63A
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 17:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711475203; cv=none; b=U0lS8Idnl0ILWyifsUGd0YhK4ACzFdNhn/4padgUE7k/7/MbKgA08omJQh1+Ga+2c5rFNHQojMT8XZLbuhShiAhj3/Ff42XYBEKGB+ikpahpOKMtSTFHAcN7Baz7Zn00ZHRtKTNRvNJ+QHbkROk2D7L4BPZW4G13lzhy42VWrUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711475203; c=relaxed/simple;
	bh=GDUp9wJ+UoTRfjRoqI2yRMLcZ251pIUop5pxEzpVuSA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kkc7YcOnQXlDD7Hu++ouTfccUkf+iF0cAU+3xyf6gBNPRPpcFG3fkUNXQpLfJSUVSSSQEiQ9eTjxg0OS6VzM/jtZYNQdbyVTHVUVYk1Ol8qxdIssSb8wjP33evcqGSGqccIlxknc4WpLqswGR6k1CudtW3tUW1w49QZ1n5uDuzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EDGlAL5g; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2d485886545so102049581fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 10:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711475199; x=1712079999; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C14gSplgZGLWljRtlb00xiW+Ox3cRsPiTyqaLpAbCSM=;
        b=EDGlAL5g1Jx8bB1Of9FgZ8go2VdRt1LLnRIRO2L6e49nKA93A1JuRRAzYoo2NZPRJ6
         Th48OaLsf2GwjU0T2+hZIcdoy/QLqjx99qbVCfK3IcNI49zwF5tgldYgHJEraEaThLra
         1i/EUt9hj/DIVmQLko/0hv02eiH14e+HAdI75H7ryfAgb5tgB6T+iGZKCAGt1h7c2el1
         FK1ECPrOF/f/h1VfoC19ezxr4gKvtlNiPYNxInwnT7aKUVq0YhwshSX1yjVAouXGCVnU
         pqelCO0k4NNIipo7lxKs3TAm+RfV58Nj49Q+YEc6PETYltVOQxtn5Oz7HR3uLSYJq3kc
         CLNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711475199; x=1712079999;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C14gSplgZGLWljRtlb00xiW+Ox3cRsPiTyqaLpAbCSM=;
        b=aU+sePNr+FO0TAhRZV9QTbsSyOySE3CXnUx8oERGBa/8nu8CO5aivp5vJBIVy6+Bfs
         QeiTphQ1zgqYU/UzVhn1PUeUdrDJTXj8lMErrwJjfmsF3hVsNoglkDTdui0qh2dfKYN+
         TGZBfPu8jtgsQ1Z8f2GrmQZ6RSg8dMPpyeWkSIP4FrcH/i4czyJ27tShDEBee7O8oBnz
         L0zPOoy+Fk+6E/Ncq7OFH/g4ndESu3MYS4XlsiwoGOf3bwovoZtgn4LjyjQsO6wh9pXi
         khDf7F0sEtwmOE8u/4Y+njY8sRWxRZBHtK2qTcm55Y6CgYJGFZ5I0FuH93yoyb6k031S
         FFXA==
X-Forwarded-Encrypted: i=1; AJvYcCW/QM0aB9qN+LILlf7jhk7i9krPOE0VB6NhIgTKpBgH4qADx0abQskw4T5kopxJ5aneu+ZvKOr28ODP+W2BDvGk0Ahp2jVaXdzl3Lnz
X-Gm-Message-State: AOJu0YxasLX6f0i4uy4JYFzSSI7nTgTsJE5G4lx1PnKoNVxz+CCvBd7l
	MvwXPC6BMLSEOK6Llt6bfXt9/4VieCPgRUSF4ybTY7M5wmaUAXoVhdNUP/PAp+0=
X-Google-Smtp-Source: AGHT+IHpjlYocgfcalACtbl2UwhjQKJtDVwl7I/xmVa1t7F1W8q/ciAzRtEpdbYUZ9Xfi6NEZgRCTA==
X-Received: by 2002:a2e:b34a:0:b0:2d4:7455:89f6 with SMTP id q10-20020a2eb34a000000b002d4745589f6mr291125lja.40.1711475199130;
        Tue, 26 Mar 2024 10:46:39 -0700 (PDT)
Received: from krzk-bin.. ([178.197.222.44])
        by smtp.gmail.com with ESMTPSA id l19-20020a17090612d300b00a46cffe6d06sm4451438ejb.42.2024.03.26.10.46.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 10:46:38 -0700 (PDT)
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
Subject: [PATCH 3/3] dt-bindings: ufs: qcom: document SM6125 UFS
Date: Tue, 26 Mar 2024 18:46:32 +0100
Message-Id: <20240326174632.209745-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240326174632.209745-1-krzysztof.kozlowski@linaro.org>
References: <20240326174632.209745-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document already upstreamed and used Qualcomm SM6125 UFS host controller to fix
dtbs_check warnings like:

  sm6125-xiaomi-laurel-sprout.dtb: ufs@4804000: compatible:0: 'qcom,sm6125-ufshc' is not one of ['qcom,msm8994-ufshc', ...
  sm6125-xiaomi-laurel-sprout.dtb: ufs@4804000: Unevaluated properties are not allowed ('compatible' was unexpected)

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/ufs/qcom,ufs.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml b/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
index 7e6d442545ad..cd3680dc002f 100644
--- a/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
+++ b/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
@@ -33,6 +33,7 @@ properties:
           - qcom,sc8280xp-ufshc
           - qcom,sdm845-ufshc
           - qcom,sm6115-ufshc
+          - qcom,sm6125-ufshc
           - qcom,sm6350-ufshc
           - qcom,sm8150-ufshc
           - qcom,sm8250-ufshc
@@ -243,6 +244,7 @@ allOf:
           contains:
             enum:
               - qcom,sm6115-ufshc
+              - qcom,sm6125-ufshc
     then:
       properties:
         clocks:
-- 
2.34.1


