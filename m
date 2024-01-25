Return-Path: <linux-kernel+bounces-38230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1B4983BCD1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 10:08:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58E671F2EAB3
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 09:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 624591CD24;
	Thu, 25 Jan 2024 09:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8devices.com header.i=@8devices.com header.b="hC0eDsgQ"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B7E1CD19
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 09:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706173476; cv=none; b=Zj0V3Agu1FzmtbBIpLwUcpqrKj/L6Z1sMA11RmkK0uyopQuVqegqf8Qfbl6Cteit5KclUBT98SvHE/i6oRiiFSpxMQri1q0aV5txif+v+rFAvEB4iCaHtKOzNPmbwHzHGAL6nkpm0VB6NYbo5pv02GHOAiaI3h35l7Xk03HF8zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706173476; c=relaxed/simple;
	bh=COtAbM7RJTtMRbtk7i6Tx7S7OWuaB2ZiKtohexJWlFg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Cn3H1tP6pFqYwjt05+tDvdIvt6erDhoAFGxuhtZi0rh+q+2dcehtGiCMlmD17bVQMhtv52+Vh+rCw0jFNNZn1etT3rFGqvIO7tdZtdmCLZhca5+6/rVaxWf4GMtQ5mLt6aM8MAH4p0t8RcPyBF0deD2AbH5HTkDDEdSCKdd9998=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=8devices.com; spf=pass smtp.mailfrom=8devices.com; dkim=pass (2048-bit key) header.d=8devices.com header.i=@8devices.com header.b=hC0eDsgQ; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=8devices.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8devices.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2cf3a0b2355so2006991fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 01:04:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=8devices.com; s=8devices; t=1706173472; x=1706778272; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sbN8fdebOyzeSDzgcpAdiySI0Y63EdYcxgGZBLtd78g=;
        b=hC0eDsgQQy5zPtnrljg+ZgnsWfDNJpspd+bL1L5MlbjUkEe+OCx9aA+9OfDhBAojx0
         tV13GOlaxknMsHs3EcD4y6gVmHuTs6SNa9TVnF83eufCaedckaJ2V2I0sNFiQtzPO4r8
         BesHhY9Dng4clGMExNi1MXw+hdjvCBfgGoxvW6Hmdz48JmbTF8oJtwjk4FgiRh1XUL4s
         vMWwERJYFP6MshIJV84xSTaIuitCyv9CU8VJyj1WuCdihJKrrnp05tPE6C9WxkLHLw7y
         a4dsHA709wsPwcNUGGqv4F3XGm95uCn4V44a/DtqR8PBV1U1robvVGQnkr5ek8Xe8T4f
         s78Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706173472; x=1706778272;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sbN8fdebOyzeSDzgcpAdiySI0Y63EdYcxgGZBLtd78g=;
        b=FU1RUKSuFjKhb9eSws7dY08I1nPdattHQumcLSCBQocNBoSoz/wEHuOg8Qn8r2Vve7
         GDeCFrhc5VDndf0/z8QqythUwk9euN/PZ/b+pvW9ohV43EC221Czthfga9Q1+0U3Mq8j
         UaqR92/djVxA8MSGXMJ8CVED/iYBZYdti6lirq1GPUznngSq7gnu7a2i4CGOsopsYZeK
         DcHMI1/277wmpUG5vTFYO4wASkVwAnpyMTK2zQSic28/Q3TfEdh9X9FhihhqBcDPc4oD
         M5ZREQ/SOYJQX8Yjsft/EJREOFAB81wlnwOZzYeruIMvxXpqeqapF8JRyURBoCWpfsUd
         +5Tw==
X-Gm-Message-State: AOJu0YyEYS77BYAV1OVkmJ1tXk0vZoLKN2MtlljfztFJVfRai2L1preO
	CVW4YZGCLCnzFTx9QJx8Taknowm6lQXbVHMBUvxQTJzzxBdXmW/oM6FKuqm+P6o=
X-Google-Smtp-Source: AGHT+IFc0sYdhDzxkmSyEK4zXLlWsd1jzKhHs8mVKbHHYe5HOCJw6HEx7dZkRpOB2wcDj51hN/wk/w==
X-Received: by 2002:a2e:700f:0:b0:2cf:2d82:a5f5 with SMTP id l15-20020a2e700f000000b002cf2d82a5f5mr307089ljc.56.1706173472614;
        Thu, 25 Jan 2024 01:04:32 -0800 (PST)
Received: from mantas-MS-7994.8devices.com ([84.15.37.222])
        by smtp.gmail.com with ESMTPSA id m10-20020a2e870a000000b002cdf8c9af34sm229123lji.57.2024.01.25.01.04.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Jan 2024 01:04:32 -0800 (PST)
From: Mantas Pucka <mantas@8devices.com>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Amit Kucheria <amitk@kernel.org>,
	Thara Gopinath <thara.gopinath@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Mantas Pucka <mantas@8devices.com>,
	linux-pm@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] dt-bindings: thermal: qcom-tsens: add IPQ6018 compatible
Date: Thu, 25 Jan 2024 11:04:10 +0200
Message-Id: <1706173452-1017-2-git-send-email-mantas@8devices.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1706173452-1017-1-git-send-email-mantas@8devices.com>
References: <1706173452-1017-1-git-send-email-mantas@8devices.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

IPQ6018 has tsens HW block compatible with IPQ8074.

Signed-off-by: Mantas Pucka <mantas@8devices.com>
---
 Documentation/devicetree/bindings/thermal/qcom-tsens.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
index 99d9c526c0b6..d6f333a7bcd1 100644
--- a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
+++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
@@ -76,6 +76,7 @@ properties:
       - description: v2 of TSENS with combined interrupt
         items:
           - enum:
+              - qcom,ipq6018-tsens
               - qcom,ipq9574-tsens
           - const: qcom,ipq8074-tsens
 
-- 
2.7.4


