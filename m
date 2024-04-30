Return-Path: <linux-kernel+bounces-163582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6DE08B6D51
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 10:51:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 561F41F23B7D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 08:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ED0E1420A8;
	Tue, 30 Apr 2024 08:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aKSJO+Mp"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D56FD13C8E9
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 08:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714466992; cv=none; b=dOd0LXzZ9yhxaDvNT8Er6ii98QxPFHbzf3fy4teb3Aj3lGj6uxbtemJLE2THY1jIsMFuuBPDT40CrifFPXyR+IdkO4bVUHlc7X3cIlmHvw3L3sfabd+U2A1T2bDYgeBhU+AF+2UWfn4AlMxhYyE8jq0QuTKsAzV4aEf07nZaGwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714466992; c=relaxed/simple;
	bh=YOY6VMePnb4/AT2CVa1xjZ1s8m74EFlJio0CG585J9o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gTp8wr/VnX+YIZWZn/oJm58C8iShPMj3pZw7rphHPDorEl73IQISPFIEKRRh4bY/UkgEetMveHTAp7xgdWjYN6BcryF5PNW7X6BDSoiPU8Zb9n5lnOSkQZNy53ksU5AbMLvzFcLz3voj+YR2yaNOPaMVDIWj87Eu/PdwUaXZk5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aKSJO+Mp; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2e0933d3b5fso19719301fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 01:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714466989; x=1715071789; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=raLVRuQuTMID7F2/pE7SbhwAHvCCZpmvw4duSEDkNpk=;
        b=aKSJO+Mp9TTT4I7Ss+OIX1TR9jZwe9RHsT4Dz0EDL9Rz2Uhz6/VtMkuxp6IxfoiNsf
         gsIc/aj21d+WupH7OkJRQdF0P15ytdk3rg3toBpiJQc3ZU7AsiVEjppaeh7yUkTKxK8i
         y+cTGGfoGQzivR8FvXDhqWBJZnyAxa87mjf1W6x1fF9NUPD3UqFGMFOJHgRjDX/tuSrL
         lfym9hfIU72jnMtf2BS70J1evRp+37Jb08RVDmD7L4LOKcpf7qt3J/jh1lBQLnSZpklN
         3IzqnWUjqsuOweaD55ZTcHDma9Hay8hZ61BfoQvSuWAuDrDDeLDt+PWql+MPt95uXwB7
         5FIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714466989; x=1715071789;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=raLVRuQuTMID7F2/pE7SbhwAHvCCZpmvw4duSEDkNpk=;
        b=mUtjMtjf9obvgp1qf65dPiQ8J5Sh83Hv2aZPsxuvH2oce41DDkb/Am5TvBdM5iW7hu
         kzveOo3NGdw/SMxwBsLBRtCXaVc14uWv90b3d3CJQmuljnH2NQdtRreg2zPw4RxdDWI4
         SmdoahZBnao9UKrsfGZAVYWoRhuKQqyWhYRxj/tA5jxhSMGeGLeswQERllfhHPMg71XG
         4jJCwaG05DMqyZm+X99kqPXqpvxRTEVvTCu2jXJFrluChAiijAUuq9RNO/TwsbFg6ND6
         jiKBByIF0VHVmF8cvwmWJRY3jJ6m4sAT5mitVhCARBiNBDeoyXQ4V+8wT1s5nG3pv2Rq
         +CDA==
X-Gm-Message-State: AOJu0YwkgFvx3D88hOJOYTv7J0FD9lbd1+59c9vNHA5FmX+gvwVLQ7vG
	JpIcE9gZYtADN7hh5PPPbRbCpNvW+w0ud4QloLNJhQrUZqiLvw4peMn+9a24A4rhEKOQhGQDyxw
	e
X-Google-Smtp-Source: AGHT+IFekEnpqNrNPmyPVrEDbAqSITKADnY/QCYwcI35BBYKNAiIShHmOUIOBVVQd8DMh7p00Yt9NQ==
X-Received: by 2002:a05:651c:50f:b0:2e0:3132:94d4 with SMTP id o15-20020a05651c050f00b002e0313294d4mr4269925ljp.16.1714466989089;
        Tue, 30 Apr 2024 01:49:49 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id q6-20020a05600c46c600b0041892857924sm44490309wmo.36.2024.04.30.01.49.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 01:49:48 -0700 (PDT)
From: srinivas.kandagatla@linaro.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Mukesh Ojha <quic_mojha@quicinc.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 08/11] dt-bindings: nvmem: Add compatible for sm8450, sm8550 and sm8650
Date: Tue, 30 Apr 2024 09:49:18 +0100
Message-Id: <20240430084921.33387-9-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240430084921.33387-1-srinivas.kandagatla@linaro.org>
References: <20240430084921.33387-1-srinivas.kandagatla@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=945; i=srinivas.kandagatla@linaro.org; h=from:subject; bh=p3Sim5/8BE8OX8p8dydVozYD8QQSYlygOfMLnlWeY9Q=; b=owEBbQGS/pANAwAKAXqh/VnHNFU3AcsmYgBmMLCN+6XtDAfsC5Gl3HXM9NXF9X2raaSRb0vDO YXqBqoRPTeJATMEAAEKAB0WIQQi509axvzi9vce3Y16of1ZxzRVNwUCZjCwjQAKCRB6of1ZxzRV N3f4B/9ptGGaRKN0z4vt+Znc67S5adfoNGtSqwUxQ5KVV2WZlZxMS9Ycs/o3WWPvP5kf8UOWY24 RUsnAL8aOyIKkY99GJpHgAfffrbUHWb0oMAI3eyERik0FTZAEn07SwHVbQEFn+uaVclgWLSutnT QyapZMzwJ1vVAclnKxbPhbiIQMOCT7nO0i7MZl4K1wou/XYN9z7ANEJHjuXyH6NMYKXYGTBHQGb 4hOURy/4GP8fp74ZbRj6btEgfHLVflMbrBzxMM08NTQ77zGzHSc8djQjxglLNNAwIE+bC4sJQ+A jX7AmoZx3IaXNaYPoZJ4zotNhwYhNDrQZ3Nz8H+2API8zPRT
X-Developer-Key: i=srinivas.kandagatla@linaro.org; a=openpgp; fpr=ED6472765AB36EC43B3EF97AD77E3FC0562560D6
Content-Transfer-Encoding: 8bit

From: Mukesh Ojha <quic_mojha@quicinc.com>

Document QFPROM compatible for sm8450, sm8550 and sm8650 SoCs.

Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml b/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
index 8c8f05d9eaf1..aed90aff3593 100644
--- a/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
+++ b/Documentation/devicetree/bindings/nvmem/qcom,qfprom.yaml
@@ -42,6 +42,9 @@ properties:
           - qcom,sm6375-qfprom
           - qcom,sm8150-qfprom
           - qcom,sm8250-qfprom
+          - qcom,sm8450-qfprom
+          - qcom,sm8550-qfprom
+          - qcom,sm8650-qfprom
       - const: qcom,qfprom
 
   reg:
-- 
2.25.1


